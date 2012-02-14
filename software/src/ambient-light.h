/* ambient-light-bricklet
 * Copyright (C) 2010-2011 Olaf Lüke <olaf@tinkerforge.com>
 *
 * ambient-light.h: Implementation of Ambient Light Bricklet messages
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

#ifndef AMBIENT_LIGHT_H
#define AMBIENT_LIGHT_H

#include <stdint.h>

#define TYPE_GET_ILLUMINANCE 1
#define TYPE_GET_ANALOG_VALUE 2
#define TYPE_SET_ILLUMINANCE_CALLBACK_PERIOD 3
#define TYPE_GET_ILLUMINANCE_CALLBACK_PERIOD 4
#define TYPE_SET_ANALOG_VALUE_CALLBACK_PERIOD 5
#define TYPE_GET_ANALOG_VALUE_CALLBACK_PERIOD 6
#define TYPE_SET_ILLUMINANCE_CALLBACK_THRESHOLD 7
#define TYPE_GET_ILLUMINANCE_CALLBACK_THRESHOLD 8
#define TYPE_SET_ANALOG_VALUE_CALLBACK_THRESHOLD 9
#define TYPE_GET_ANALOG_VALUE_CALLBACK_THRESHOLD 10
#define TYPE_SET_DEBOUNCE_PERIOD 11
#define TYPE_GET_DEBOUNCE_PERIOD 12
#define TYPE_ILLUMINANCE 13
#define TYPE_ANALOG_VALUE 14
#define TYPE_ILLUMINANCE_REACHED 15
#define TYPE_ANALOG_VALUE_REACHED 16

int32_t analog_value_from_mc(int32_t value);
int32_t illuminance_from_analog_value(int32_t value);

void invocation(uint8_t com, uint8_t *data);
void constructor(void);
void destructor(void);
void tick(uint8_t tick_type);

#endif
