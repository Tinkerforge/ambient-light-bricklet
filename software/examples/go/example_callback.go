package main

import (
	"fmt"
	"github.com/tinkerforge/go-api-bindings/ambient_light_bricklet"
	"github.com/tinkerforge/go-api-bindings/ipconnection"
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

	al.RegisterIlluminanceCallback(func(illuminance uint16) {
		fmt.Printf("Illuminance: %f lx\n", float64(illuminance)/10.0)
	})

	// Set period for illuminance receiver to 1s (1000ms).
	// Note: The illuminance callback is only called every second
	//       if the illuminance has changed since the last call!
	al.SetIlluminanceCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
