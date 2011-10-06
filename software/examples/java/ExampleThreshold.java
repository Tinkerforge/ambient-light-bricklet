import com.tinkerforge.BrickletAmbientLight;
import com.tinkerforge.IPConnection;

public class ExampleThreshold {
	private static final String host = new String("localhost");
	private static final int port = 4223;
	private static final String UID = new String("ABC"); // Change to your UID
	
	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the commnents below
	public static void main(String args[]) throws Exception {
		// Create connection to brickd
		IPConnection ipcon = new IPConnection(host, port); // Can throw IOException

		BrickletAmbientLight al = new BrickletAmbientLight(UID); // Create device object

		// Add device to ip connection
		ipcon.addDevice(al); // Can throw IPConnection.TimeoutException
		// Don't use device before it is added to a connection
		

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		al.setDebouncePeriod(10000);

		// Configure threshold for "greater than 200 Lux" (unit is Lux/10)
		al.setIlluminanceCallbackThreshold('>', (short)(200*10), (short)0);

		// Add and implement illuminance reached listener 
		// (called if illuminance is greater than 200 lux)
		al.addListener(new BrickletAmbientLight.IlluminanceReachedListener() {
			public void illuminanceReached(int illuminance) {
				System.out.println("We have: " + illuminance/10.0 + " Lux.");
				System.out.println("Too bright, close the curtains!");
			}
		});
		
		System.out.println("Press ctrl+c to exit");
		ipcon.joinThread();
	}
}