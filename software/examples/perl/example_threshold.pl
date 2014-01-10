#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAmbientLight;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '6Ma'; # Change to your UID

my $ipcon = IPConnection->new(); # Create IP connection
my $al = BrickletAmbientLight->new(&UID, $ipcon); # Create device object

# Callback for illuminance greater than 200 Lux
sub cb_reached
{
    print "\nWe have ".$illuminance/10.0." Lux";
    print "\nToo bright, close the curtains\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$al->set_debounce_period(10000);

# Register threshold reached callback to function cb_reached
$al->register_callback($al->CALLBACK_ILLUMINANCE_REACHED, 'cb_reached');

# Configure threshold for "greater than 200 Lux" (unit is Lux/10)
$al->set_illuminance_callback_threshold('>', 200*10, 0);

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
