/*************************************************************
 * This file was automatically generated on 23.08.2011.      *
 *                                                           *
 * If you have a bugfix for this file and want to commit it, *
 * please fix the bug in the generator. You can find a link  *
 * to the generator git on tinkerforge.com                   *
 *************************************************************/

#ifndef BRICKLET_AMBIENT_LIGHT_H
#define BRICKLET_AMBIENT_LIGHT_H

#include "ip_connection.h"

typedef Device AmbientLight;

#define AMBIENT_LIGHT_CALLBACK_ILLUMINANCE 13
#define AMBIENT_LIGHT_CALLBACK_ANALOG_VALUE 14
#define AMBIENT_LIGHT_CALLBACK_ILLUMINANCE_REACHED 15
#define AMBIENT_LIGHT_CALLBACK_ANALOG_VALUE_REACHED 16

void ambient_light_create(AmbientLight *ambient_light, const char *uid);

int ambient_light_get_illuminance(AmbientLight *ambient_light, uint16_t *ret_illuminance);
int ambient_light_get_analog_value(AmbientLight *ambient_light, uint16_t *ret_value);
int ambient_light_set_illuminance_callback_period(AmbientLight *ambient_light, uint32_t period);
int ambient_light_get_illuminance_callback_period(AmbientLight *ambient_light, uint32_t *ret_period);
int ambient_light_set_analog_value_callback_period(AmbientLight *ambient_light, uint32_t period);
int ambient_light_get_analog_value_callback_period(AmbientLight *ambient_light, uint32_t *ret_period);
int ambient_light_set_illuminance_callback_threshold(AmbientLight *ambient_light, char option, int16_t min, int16_t max);
int ambient_light_get_illuminance_callback_threshold(AmbientLight *ambient_light, char *ret_option, int16_t *ret_min, int16_t *ret_max);
int ambient_light_set_analog_value_callback_threshold(AmbientLight *ambient_light, char option, uint16_t min, uint16_t max);
int ambient_light_get_analog_value_callback_threshold(AmbientLight *ambient_light, char *ret_option, uint16_t *ret_min, uint16_t *ret_max);
int ambient_light_set_debounce_period(AmbientLight *ambient_light, uint32_t debounce);
int ambient_light_get_debounce_period(AmbientLight *ambient_light, uint32_t *ret_debounce);
int ambient_light_illuminance(AmbientLight *ambient_light, uint16_t *ret_illuminance);
int ambient_light_analog_value(AmbientLight *ambient_light, uint16_t *ret_value);
int ambient_light_illuminance_reached(AmbientLight *ambient_light, uint16_t *ret_illuminance);
int ambient_light_analog_value_reached(AmbientLight *ambient_light, uint16_t *ret_value);

void ambient_light_register_callback(AmbientLight *ambient_light, uint8_t cb, void *func);

#endif