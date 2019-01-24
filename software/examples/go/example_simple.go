package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/ambient_light_bricklet"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Ambient Light Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	al, _ := ambient_light_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get current illuminance.
	illuminance, _ := al.GetIlluminance()
	fmt.Printf("Illuminance: %f lx\n", float64(illuminance)/10.0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()
}
