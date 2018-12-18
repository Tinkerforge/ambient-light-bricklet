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

	// Get threshold receivers with a debounce time of 10 seconds (10000ms).
	al.SetDebouncePeriod(10000)

	al.RegisterIlluminanceReachedCallback(func(illuminance uint16) {
		fmt.Printf("Illuminance: %f lx\n", float64(illuminance)/10.0)
		fmt.Println("Too bright, close the curtains!")
	})

	// Configure threshold for illuminance "greater than 200 lx".
	al.SetIlluminanceCallbackThreshold('>', 200*10, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
