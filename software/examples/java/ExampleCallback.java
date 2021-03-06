import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletAmbientLight;

public class ExampleCallback {
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

		// Add illuminance listener
		al.addIlluminanceListener(new BrickletAmbientLight.IlluminanceListener() {
			public void illuminance(int illuminance) {
				System.out.println("Illuminance: " + illuminance/10.0 + " lx");
			}
		});

		// Set period for illuminance callback to 1s (1000ms)
		// Note: The illuminance callback is only called every second
		//       if the illuminance has changed since the last call!
		al.setIlluminanceCallbackPeriod(1000);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
