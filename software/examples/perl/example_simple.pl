#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAmbientLight;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $al = Tinkerforge::BrickletAmbientLight->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current illuminance (unit is Lux/10)
my $illuminance = $al->get_illuminance();
print "Illuminance: " . $illuminance/10.0 . " Lux\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
