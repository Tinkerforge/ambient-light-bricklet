/* ambient-light-bricklet
 * Copyright (C) 2010-2012 Olaf Lüke <olaf@tinkerforge.com>
 * Copyright (C) 2013 Matthias Bolte <matthias@tinkerforge.com>
 *
 * config.h: Ambient Light Bricklet specific configuration
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

#ifndef CONFIG_H
#define CONFIG_H

#include <stdint.h>
#include <stdbool.h>

#include "bricklib/drivers/board/sam3s/SAM3S.h"

#include "ambient-light.h"

#define BRICKLET_FIRMWARE_VERSION_MAJOR 2
#define BRICKLET_FIRMWARE_VERSION_MINOR 0
#define BRICKLET_FIRMWARE_VERSION_REVISION 3

#define BRICKLET_HARDWARE_VERSION_MAJOR 1
#define BRICKLET_HARDWARE_VERSION_MINOR 1
#define BRICKLET_HARDWARE_VERSION_REVISION 0

#define BRICKLET_DEVICE_IDENTIFIER 21

#define MAX_ADC_VALUE ((1  << 12) - 1)
#define MAX_VOLTAGE 3300

#define VALUE_RESISTOR_0 7354  // 1000/((1/10) + (1/47) + (1/68))
#define VALUE_RESISTOR_1 10000
#define VALUE_RESISTOR_2 47000
#define VALUE_RESISTOR_3 68000

#define DIVISOR_0 (VALUE_RESISTOR_0*MAX_ADC_VALUE/MAX_VOLTAGE)
#define DIVISOR_1 (VALUE_RESISTOR_1*MAX_ADC_VALUE/MAX_VOLTAGE)
#define DIVISOR_2 (VALUE_RESISTOR_2*MAX_ADC_VALUE/MAX_VOLTAGE)
#define DIVISOR_3 (VALUE_RESISTOR_3*MAX_ADC_VALUE/MAX_VOLTAGE)

#define MAX_UA_0 (2*1000*MAX_ADC_VALUE/DIVISOR_0)
#define MAX_UA_1 (2*1000*MAX_ADC_VALUE/DIVISOR_1)
#define MAX_UA_2 (2*1000*MAX_ADC_VALUE/DIVISOR_2)
#define MAX_UA_3 (2*1000*MAX_ADC_VALUE/DIVISOR_3)

#define THRESHOLD_VALUE_0 (MAX_UA_2*DIVISOR_0/(2*1150)) // 15% debounce
#define THRESHOLD_VALUE_1 (MAX_UA_2*DIVISOR_1/(2*1150)) // 15% debounce
#define THRESHOLD_VALUE_2 (MAX_UA_3*DIVISOR_2/(2*1150)) // 15% debounce

#define VALUE_TO_MA_0(value) ((2*1000*10*(value))/DIVISOR_0)
#define VALUE_TO_MA_1(value) ((2*1000*10*(value))/DIVISOR_1)
#define VALUE_TO_MA_2(value) ((2*1000*10*(value))/DIVISOR_2)
#define VALUE_TO_MA_3(value) ((2*1000*10*(value))/DIVISOR_3)

#define PIN_RESISTOR_1 (BS->pin2_da) // 10k
#define PIN_RESISTOR_2 (BS->pin3_pwm) // 47k
#define PIN_RESISTOR_3 (BS->pin4_io) // 68k

#define LOGGING_LEVEL LOGGING_DEBUG
#define DEBUG_BRICKLET 0

#define BRICKLET_HAS_SIMPLE_SENSOR
#define BRICKLET_NO_OFFSET
#define INVOCATION_IN_BRICKLET_CODE
#define NUM_SIMPLE_VALUES 2

typedef struct {
	int32_t value[NUM_SIMPLE_VALUES];
	int32_t last_value[NUM_SIMPLE_VALUES];
	int16_t value_avg;
	int32_t value_avg_sum;
	uint32_t value_avg_tick;

	uint32_t signal_period[NUM_SIMPLE_VALUES];
	uint32_t signal_period_counter[NUM_SIMPLE_VALUES];

	uint32_t threshold_debounce;
	uint32_t threshold_period_current[NUM_SIMPLE_VALUES];
	int32_t  threshold_min[NUM_SIMPLE_VALUES];
	int32_t  threshold_max[NUM_SIMPLE_VALUES];
	char     threshold_option[NUM_SIMPLE_VALUES];

	int32_t  threshold_min_save[NUM_SIMPLE_VALUES];
	int32_t  threshold_max_save[NUM_SIMPLE_VALUES];
	char     threshold_option_save[NUM_SIMPLE_VALUES];

	uint8_t current_resistor;
	uint8_t new_resistor;
	uint8_t new_resistor_set;

	uint32_t tick;
} BrickContext;

#endif
