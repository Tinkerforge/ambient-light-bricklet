var IPConnection = require('Tinkerforge/IPConnection');
var BrickletAmbientLight = require('Tinkerforge/BrickletAmbientLight');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'amb';// Change to your UID

var ipcon = new IPConnection();// Create IP connection
var al = new BrickletAmbientLight(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
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

