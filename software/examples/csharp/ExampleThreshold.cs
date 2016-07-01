using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Ambient Light Bricklet

	// Callback function for illuminance reached callback (parameter has unit Lux/10)
	static void IlluminanceReachedCB(BrickletAmbientLight sender, int illuminance)
	{
		Console.WriteLine("Illuminance: " + illuminance/10.0 + " Lux");
		Console.WriteLine("Too bright, close the curtains!");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAmbientLight al = new BrickletAmbientLight(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		al.SetDebouncePeriod(10000);

		// Register illuminance reached callback to function IlluminanceReachedCB
		al.IlluminanceReached += IlluminanceReachedCB;

		// Configure threshold for illuminance "greater than 200 Lux" (unit is Lux/10)
		al.SetIlluminanceCallbackThreshold('>', 200*10, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
