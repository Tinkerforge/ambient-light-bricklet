var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'amb'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var al = new Tinkerforge.BrickletAmbientLight(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for illuminance callback to 1s (1000ms)
        // Note: The illuminance callback is only called every second if the
        // illuminance has changed since the last call!
        al.setIlluminanceCallbackPeriod(1000);
    }
);

// Register position callback
al.on(Tinkerforge.BrickletAmbientLight.CALLBACK_ILLUMINANCE,
    // Callback function for illuminance callback (parameter has unit Lux/10)
    function(illuminance) {
        console.log('Illuminance: '+illuminance/10+' Lux');
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
