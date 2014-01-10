#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAmbientLight;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '6Ma'; # Change to your UID

my $ipcon = IPConnection->new(); # Create IP connection
my $al = BrickletAmbientLight->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current illuminance (unit is Lux/10)
my $illuminance = $al->get_illuminance()/10.0;

print "\nIlluminance: ".$illuminance." Lux\n";

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
