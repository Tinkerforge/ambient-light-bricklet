using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Ambient Light Bricklet

	// Callback function for illuminance callback (parameter has unit Lux/10)
	static void IlluminanceCB(BrickletAmbientLight sender, int illuminance)
	{
		Console.WriteLine("Illuminance: " + illuminance/10.0 + " Lux");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAmbientLight al = new BrickletAmbientLight(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register illuminance callback to function IlluminanceCB
		al.IlluminanceCallback += IlluminanceCB;

		// Set period for illuminance callback to 1s (1000ms)
		// Note: The illuminance callback is only called every second
		//       if the illuminance has changed since the last call!
		al.SetIlluminanceCallbackPeriod(1000);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
