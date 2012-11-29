<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAmbientLight.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAmbientLight;

$host = 'localhost';
$port = 4223;
$uid = '7tS'; // Change to your UID

// Callback function for illuminance callback (parameter has unit Lux/10)
function cb_illuminance($illuminance)
{
    echo "Illuminance: " . $illuminance / 10.0 . " Lux\n";
}

$ipcon = new IPConnection(); // Create IP connection
$al = new BrickletAmbientLight($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for illuminance callback to 1s (1000ms)
// Note: The illuminance callback is only called every second if the
//       illuminance has changed since the last call!
$al->setIlluminanceCallbackPeriod(1000);

// Register illuminance callback to function cb_illuminance
$al->registerCallback(BrickletAmbientLight::CALLBACK_ILLUMINANCE, 'cb_illuminance');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
