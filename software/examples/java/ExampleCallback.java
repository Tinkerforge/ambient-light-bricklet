import com.tinkerforge.BrickletAmbientLight;
import com.tinkerforge.IPConnection;

public class ExampleCallback {
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
		

		// Set Period for illuminance callback to 1s (1000ms)
		// Note: The illuminance callback is only called every second if the 
		//       illuminance has changed since the last call!
		al.setIlluminanceCallbackPeriod(1000);

		// Add and implement illuminance listener (called if illuminance changes)
		al.addListener(new BrickletAmbientLight.IlluminanceListener() {
			public void illuminance(int illuminance) {
				System.out.println("Illuminance: " + illuminance/10.0 + " Lux");
			}
		});
		
		System.out.println("Press ctrl+c to exit");
		ipcon.joinThread();
	}
}