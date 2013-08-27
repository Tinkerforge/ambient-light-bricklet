/* ambient-light-bricklet
 * Copyright (C) 2010-2012 Olaf Lüke <olaf@tinkerforge.com>
 * Copyright (C) 2013 Matthias Bolte <matthias@tinkerforge.com>
 *
 * ambient-light.c: Implementation of Ambient Light Bricklet messages
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "ambient-light.h"

#include "bricklib/bricklet/bricklet_communication.h"
#include "bricklib/utility/util_definitions.h"
#include "bricklib/drivers/adc/adc.h"
#include "brickletlib/bricklet_entry.h"
#include "brickletlib/bricklet_simple.h"
#include "config.h"

#define ILLUMINANCE_AVERAGE 50

#define SIMPLE_UNIT_ILLUMINANCE 0
#define SIMPLE_UNIT_ANALOG_VALUE 1

const SimpleMessageProperty smp[] = {
	{SIMPLE_UNIT_ILLUMINANCE, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // TYPE_GET_ILLUMINANCE
	{SIMPLE_UNIT_ANALOG_VALUE, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // TYPE_GET_ANALOG_VALUE
	{SIMPLE_UNIT_ILLUMINANCE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // TYPE_SET_ILLUMINANCE_CALLBACK_PERIOD
	{SIMPLE_UNIT_ILLUMINANCE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // TYPE_GET_ILLUMINANCE_CALLBACK_PERIOD
	{SIMPLE_UNIT_ANALOG_VALUE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // TYPE_SET_ANALOG_VALUE_CALLBACK_PERIOD
	{SIMPLE_UNIT_ANALOG_VALUE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // TYPE_GET_ANALOG_VALUE_CALLBACK_PERIOD
	{SIMPLE_UNIT_ILLUMINANCE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // TYPE_SET_ILLUMINANCE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_ILLUMINANCE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // TYPE_GET_ILLUMINANCE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_ANALOG_VALUE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // TYPE_SET_ANALOG_VALUE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_ANALOG_VALUE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // TYPE_GET_ANALOG_VALUE_CALLBACK_THRESHOLD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_SET}, // TYPE_SET_DEBOUNCE_PERIOD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_GET}, // TYPE_GET_DEBOUNCE_PERIOD
};

const SimpleUnitProperty sup[] = {
	{illuminance_from_analog_value, SIMPLE_SIGNEDNESS_INT, FID_ILLUMINANCE, FID_ILLUMINANCE_REACHED, SIMPLE_UNIT_ANALOG_VALUE}, // illuminance
	{analog_value_from_mc, SIMPLE_SIGNEDNESS_UINT, FID_ANALOG_VALUE, FID_ANALOG_VALUE_REACHED, SIMPLE_UNIT_ANALOG_VALUE}, // analog value
};

const uint8_t smp_length = sizeof(smp);


void invocation(const ComType com, const uint8_t *data) {
	simple_invocation(com, data);

	if(((MessageHeader*)data)->fid > FID_LAST) {
		BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
	}
}

void constructor(void) {
	adc_channel_enable(BS->adc_channel);
	BC->value_avg = 0;
	BC->value_avg_sum = 0;
	BC->value_avg_tick = 0;

    PIN_RESISTOR_1.type = PIO_OUTPUT_0;
    BA->PIO_Configure(&PIN_RESISTOR_1, 1);

    PIN_RESISTOR_2.type = PIO_INPUT;
    BA->PIO_Configure(&PIN_RESISTOR_2, 1);

    PIN_RESISTOR_3.type = PIO_INPUT;
    BA->PIO_Configure(&PIN_RESISTOR_3, 1);

    BC->current_resistor = 1;
    BC->new_resistor = 1;

	simple_constructor();
}

void destructor(void) {
	simple_destructor();

    PIN_RESISTOR_1.type = PIO_INPUT;
    BA->PIO_Configure(&PIN_RESISTOR_1, 1);

    PIN_RESISTOR_2.type = PIO_INPUT;
    BA->PIO_Configure(&PIN_RESISTOR_2, 1);

    PIN_RESISTOR_3.type = PIO_INPUT;
    BA->PIO_Configure(&PIN_RESISTOR_3, 1);

	adc_channel_disable(BS->adc_channel);
}

void set_new_resistor(void) {
	if(BC->new_resistor == BC->current_resistor) {
		return;
	}

	switch(BC->new_resistor) {
		case 0:
			PIN_RESISTOR_2.type = PIO_OUTPUT_0;
			BA->PIO_Configure(&PIN_RESISTOR_2, 1);

			PIN_RESISTOR_3.type = PIO_OUTPUT_0;
			BA->PIO_Configure(&PIN_RESISTOR_3, 1);

			PIN_RESISTOR_1.type = PIO_OUTPUT_0;
			BA->PIO_Configure(&PIN_RESISTOR_1, 1);

			BC->current_resistor = 0;
			break;

		case 1:
		    PIN_RESISTOR_2.type = PIO_INPUT;
		    BA->PIO_Configure(&PIN_RESISTOR_2, 1);

		    PIN_RESISTOR_3.type = PIO_INPUT;
		    BA->PIO_Configure(&PIN_RESISTOR_3, 1);

		    PIN_RESISTOR_1.type = PIO_OUTPUT_0;
		    BA->PIO_Configure(&PIN_RESISTOR_1, 1);

		    BC->current_resistor = 1;
		    break;

		case 2:
		    PIN_RESISTOR_1.type = PIO_INPUT;
		    BA->PIO_Configure(&PIN_RESISTOR_1, 1);

		    PIN_RESISTOR_3.type = PIO_INPUT;
		    BA->PIO_Configure(&PIN_RESISTOR_3, 1);

		    PIN_RESISTOR_2.type = PIO_OUTPUT_0;
		    BA->PIO_Configure(&PIN_RESISTOR_2, 1);

		    BC->current_resistor = 2;
		    break;

		case 3:
		    PIN_RESISTOR_1.type = PIO_INPUT;
		    BA->PIO_Configure(&PIN_RESISTOR_1, 1);

		    PIN_RESISTOR_2.type = PIO_INPUT;
		    BA->PIO_Configure(&PIN_RESISTOR_2, 1);

		    PIN_RESISTOR_3.type = PIO_OUTPUT_0;
		    BA->PIO_Configure(&PIN_RESISTOR_3, 1);

		    BC->current_resistor = 3;
		    break;
	}

	BC->new_resistor_set = 10;
}

void update_resistor(const uint16_t value) {
	if(value > 3800) {
		if(BC->current_resistor > 0) {
			BC->new_resistor = BC->current_resistor -1;
		}
	} else if(BC->current_resistor == 0 && value < THRESHOLD_VALUE_0) {
		BC->new_resistor = 1;
	} else if(BC->current_resistor == 1 && value < THRESHOLD_VALUE_1) {
		BC->new_resistor = 2;
	} else if(BC->current_resistor == 2 && value < THRESHOLD_VALUE_2) {
		BC->new_resistor = 3;
	}
}

int32_t analog_value_from_mc(const int32_t value) {
	if(BC->new_resistor_set > 0) {
		return BC->value[1];
	}
	uint16_t analog_value = BA->adc_channel_get_data(BS->adc_channel);
	update_resistor(analog_value);
	return analog_value;
}

int32_t illuminance_from_analog_value(const int32_t value) {
	if(BC->new_resistor_set > 0) {
		BC->new_resistor_set--;
		return BC->value[0];
	}

	int32_t illuminance = 0;
	switch(BC->current_resistor) {
		case 0:
			illuminance = VALUE_TO_MA_0(value);
			break;
		case 1:
			illuminance = VALUE_TO_MA_1(value);
			break;
		case 2:
			illuminance = VALUE_TO_MA_2(value);
			break;
		case 3:
			illuminance = VALUE_TO_MA_3(value);
			break;
	}

	set_new_resistor();

	BC->value_avg_sum += illuminance;

	if(BC->value_avg_tick % ILLUMINANCE_AVERAGE == 0) {
		BC->value_avg = BC->value_avg_sum/ILLUMINANCE_AVERAGE;
		BC->value_avg_sum = 0;
	}

	++BC->value_avg_tick;

	return BC->value_avg;
}

void tick(const uint8_t tick_type) {
	simple_tick(tick_type);
}
