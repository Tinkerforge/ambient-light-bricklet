#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call ambient-light-bricklet $uid set-debounce-period 10000

# Handle incoming illuminance reached callbacks (parameter has unit Lux/10)
tinkerforge dispatch ambient-light-bricklet $uid illuminance-reached\
 --execute "echo Illuminance: {illuminance} Lux/10. Too bright, close the curtains!" &

# Configure threshold for illuminance "greater than 200 Lux" (unit is Lux/10)
tinkerforge call ambient-light-bricklet $uid set-illuminance-callback-threshold greater 2000 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
