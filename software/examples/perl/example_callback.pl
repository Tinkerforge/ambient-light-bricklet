#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletAmbientLight;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '6Ma'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $al = Tinkerforge::BrickletAmbientLight->new(&UID, $ipcon); # Create device object

# Callback function for illuminance callback (parameter has unit Lux/10)
sub cb_illuminance
{
    my ($illuminance) = @_;

    print "Illuminance: ".$illuminance/10.0." Lux\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for illuminance callback to 1s (1000ms)
# Note: The illuminance callback is only called every second if the 
#       illuminance has changed since the last call!
$al->set_illuminance_callback_period(1000);

# Register illuminance callback to function cb_illuminance
$al->register_callback($al->CALLBACK_ILLUMINANCE, 'cb_illuminance');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
