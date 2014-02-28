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
        // Get current illuminance (unit is Lux/10)
        al.getIlluminance(
            function(illuminance) {
                console.log('Illuminance: '+illuminance/10+' Lux');
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
