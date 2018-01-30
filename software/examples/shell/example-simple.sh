#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Ambient Light Bricklet

# Get current illuminance
tinkerforge call ambient-light-bricklet $uid get-illuminance
