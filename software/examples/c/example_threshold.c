#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_ambient_light.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for illuminance greater than 500 Lux (parameter has unit Lux/10)
void cb_illuminance_reached(uint16_t illuminance, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Illuminance: %f Lux\n", illuminance/10.0);
	puts("Too bright, close the curtains!");
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	AmbientLight al;
	ambient_light_create(&al, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
	ambient_light_set_debounce_period(&al, 10000);

	// Register threshold reached callback to function cb_illuminance_reached
	ambient_light_register_callback(&al,
	                                AMBIENT_LIGHT_CALLBACK_ILLUMINANCE_REACHED,
	                                (void *)cb_illuminance_reached,
	                                NULL);

	// Configure threshold for "greater than 500 Lux" (unit is Lux/10)
	ambient_light_set_illuminance_callback_threshold(&al, '>', 500*10, 0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
