import com.tinkerforge.BrickletAmbientLight;
import com.tinkerforge.IPConnection;

public class ExampleSimple {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "ABC"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAmbientLight al = new BrickletAmbientLight(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current illuminance (unit is Lux/10)
		int illuminance = al.getIlluminance(); // Can throw com.tinkerforge.TimeoutException

		System.out.println("Illuminance: " + illuminance/10.0 + " Lux");

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
