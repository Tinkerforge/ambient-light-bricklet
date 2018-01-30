#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Ambient Light Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ambient_light import BrickletAmbientLight

# Callback function for illuminance reached callback
def cb_illuminance_reached(illuminance):
    print("Illuminance: " + str(illuminance/10.0) + " lx")
    print("Too bright, close the curtains!")

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    al = BrickletAmbientLight(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    al.set_debounce_period(10000)

    # Register illuminance reached callback to function cb_illuminance_reached
    al.register_callback(al.CALLBACK_ILLUMINANCE_REACHED, cb_illuminance_reached)

    # Configure threshold for illuminance "greater than 200 lx"
    al.set_illuminance_callback_threshold(">", 200*10, 0)

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
