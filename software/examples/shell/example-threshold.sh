#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Ambient Light Bricklet

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call ambient-light-bricklet $uid set-debounce-period 10000

# Handle incoming illuminance reached callbacks
tinkerforge dispatch ambient-light-bricklet $uid illuminance-reached\
 --execute "echo Illuminance: {illuminance}/10 lx. Too bright, close the curtains!" &

# Configure threshold for illuminance "greater than 200 lx"
tinkerforge call ambient-light-bricklet $uid set-illuminance-callback-threshold threshold-option-greater 2000 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
