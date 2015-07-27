import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletAmbientLight;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletAmbientLight al = new BrickletAmbientLight(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		al.setDebouncePeriod(10000);

		// Configure threshold for "greater than 500 Lux" (unit is Lux/10)
		al.setIlluminanceCallbackThreshold('>', (short)(500*10), (short)0);

		// Add threshold reached listener for illuminance greater than 500 Lux (parameter has unit Lux/10)
		al.addIlluminanceReachedListener(new BrickletAmbientLight.IlluminanceReachedListener() {
			public void illuminanceReached(int illuminance) {
				System.out.println("Illuminance: " + illuminance/10.0 + " Lux");
				System.out.println("Too bright, close the curtains!");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
