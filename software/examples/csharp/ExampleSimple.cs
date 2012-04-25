using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletAmbientLight al = new BrickletAmbientLight(UID); // Create device object
		ipcon.AddDevice(al); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Get current illuminance (unit is Lux/10)
		ushort illuminance;
		al.GetIlluminance(out illuminance);

		System.Console.WriteLine("Illuminance: " + illuminance/10.0 + " Lux");

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
