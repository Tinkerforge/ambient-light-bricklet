using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback for illuminance greater than 200 Lux
	static void ReachedCB(ushort illuminance)
	{
		System.Console.WriteLine("We have " + illuminance/10.0 + " Lux.");
		System.Console.WriteLine("Too bright, close the curtains!");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletAmbientLight al = new BrickletAmbientLight(UID); // Create device object
		ipcon.AddDevice(al); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		al.SetDebouncePeriod(10000);

		// Register threshold reached callback to function ReachedCB
		al.RegisterCallback(new BrickletAmbientLight.IlluminanceReached(ReachedCB));

		// Configure threshold for "greater than 200 Lux" (unit is Lux/10)
		al.SetIlluminanceCallbackThreshold('>', 200*10, 0);

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
		ipcon.Destroy();
	}
}
