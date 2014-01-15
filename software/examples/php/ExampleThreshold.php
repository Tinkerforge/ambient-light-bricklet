<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletAmbientLight.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletAmbientLight;

const HOST = 'localhost';
const PORT = 4223;
const UID = '7tS'; // Change to your UID

// Callback for illuminance greater than 200 Lux
function cb_reached($illuminance)
{
    echo "We have " . $illuminance / 10.0 . " Lux.\n";
    echo "Too bright, close the curtains!\n";
}

$ipcon = new IPConnection(); // Create IP connection
$al = new BrickletAmbientLight(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$al->setDebouncePeriod(10000);

// Register threshold reached callback to function cb_reached
$al->registerCallback(BrickletAmbientLight::CALLBACK_ILLUMINANCE_REACHED, 'cb_reached');

// Configure threshold for "greater than 200 Lux" (unit is Lux/10)
$al->setIlluminanceCallbackThreshold('>', 200*10, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
