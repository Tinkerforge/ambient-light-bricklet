<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAmbientLight.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAmbientLight;

$host = 'localhost';
$port = 4223;
$uid = '7tS'; // Change to your UID

$ipcon = new IPConnection($host, $port); // Create IP connection to brickd
$al = new BrickletAmbientLight($uid); // Create device object

$ipcon->addDevice($al); // Add device to IP connection
// Don't use device before it is added to a connection

// Get current illuminance (unit is Lux/10)
$illuminance = $al->getIlluminance() / 10.0;

echo "Illuminance: $illuminance Lux\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->destroy();

?>
