<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAmbientLight.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAmbientLight;

const HOST = 'localhost';
const PORT = 4223;
const UID = '7tS'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$al = new BrickletAmbientLight(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current illuminance (unit is Lux/10)
$illuminance = $al->getIlluminance() / 10.0;

echo "Illuminance: $illuminance Lux\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
