#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current illuminance (unit is Lux/10)
tinkerforge call ambient-light-bricklet $uid get-illuminance
