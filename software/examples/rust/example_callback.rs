use std::{error::Error, io, thread};
use tinkerforge::{ambient_light_bricklet::*, ipconnection::IpConnection};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Ambient Light Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let ambient_light_bricklet = AmbientLightBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    //Create listener for illuminance events.
    let illuminance_listener = ambient_light_bricklet.get_illuminance_receiver();
    // Spawn thread to handle received events. This thread ends when the ambient_light_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in illuminance_listener {
            println!("Illuminance: {}{}", event as f32 / 10.0, " lx");
        }
    });

    // Set period for illuminance listener to 1s (1000ms)
    // Note: The illuminance callback is only called every second
    //       if the illuminance has changed since the last call!
    ambient_light_bricklet.set_illuminance_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
