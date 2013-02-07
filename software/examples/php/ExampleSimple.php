<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAmbientLight.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAmbientLight;

$host = 'localhost';
$port = 4223;
$uid = '7tS'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$al = new BrickletAmbientLight($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Get current illuminance (unit is Lux/10)
$illuminance = $al->getIlluminance() / 10.0;

echo "Illuminance: $illuminance Lux\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
