using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback function for illuminance callback (parameter has unit Lux/10)
	static void IlluminanceCB(ushort illuminance)
	{
		System.Console.WriteLine("Illuminance: " + illuminance/10.0 + " Lux");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletAmbientLight al = new BrickletAmbientLight(UID); // Create device object
		ipcon.AddDevice(al); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Set Period for illuminance callback to 1s (1000ms)
		// Note: The illuminance callback is only called every second if the 
		//       illuminance has changed since the last call!
		al.SetIlluminanceCallbackPeriod(1000);

		// Register illuminance callback to function IlluminanceCB
		al.RegisterCallback(new BrickletAmbientLight.Illuminance(IlluminanceCB));

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
