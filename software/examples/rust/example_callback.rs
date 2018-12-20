use std::{io, error::Error};
use std::thread;
use tinkerforge::{ip_connection::IpConnection, 
                  ambient_light_bricklet::*};


const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Ambient Light Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let al = AmbientLightBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
    // Don't use device before ipcon is connected.

     let illuminance_receiver = al.get_illuminance_callback_receiver();

        // Spawn thread to handle received callback messages. 
        // This thread ends when the `al` object
        // is dropped, so there is no need for manual cleanup.
        thread::spawn(move || {
            for illuminance in illuminance_receiver {           
                		println!("Illuminance: {} lx", illuminance as f32 /10.0);
            }
        });

		// Set period for illuminance receiver to 1s (1000ms).
		// Note: The illuminance callback is only called every second
		//       if the illuminance has changed since the last call!
		al.set_illuminance_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
