using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAmbientLight al = new BrickletAmbientLight(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current illuminance (unit is Lux/10)
		int illuminance = al.GetIlluminance();

		System.Console.WriteLine("Illuminance: " + illuminance/10.0 + " Lux");

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
	}
}
