
#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_ambient_light.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

int main() {
	// Create IP connection to brickd
	IPConnection ipcon;
	if(ipcon_create(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not create connection\n");
		exit(1);
	}

	// Create device object
	AmbientLight al;
	ambient_light_create(&al, UID); 

	// Add device to IP connection
	if(ipcon_add_device(&ipcon, &al) < 0) {
		fprintf(stderr, "Could not connect to Bricklet\n");
		exit(1);
	}
	// Don't use device before it is added to a connection

	// Get current illuminance (unit is Lux/10)
	uint16_t illuminance;
	if(ambient_light_get_illuminance(&al, &illuminance) < 0) {
		fprintf(stderr, "Could not get value, probably timeout\n");
		exit(1);
	}

	printf("Illuminance: %f Lux\n", illuminance/10.0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon);
}
