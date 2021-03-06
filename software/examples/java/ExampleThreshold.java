import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletAmbientLight;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Ambient Light Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAmbientLight al = new BrickletAmbientLight(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		al.setDebouncePeriod(10000);

		// Add illuminance reached listener
		al.addIlluminanceReachedListener(new BrickletAmbientLight.IlluminanceReachedListener() {
			public void illuminanceReached(int illuminance) {
				System.out.println("Illuminance: " + illuminance/10.0 + " lx");
				System.out.println("Too bright, close the curtains!");
			}
		});

		// Configure threshold for illuminance "greater than 200 lx"
		al.setIlluminanceCallbackThreshold('>', 200*10, 0);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
