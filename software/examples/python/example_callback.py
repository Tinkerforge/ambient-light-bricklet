#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Ambient Light Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ambient_light import BrickletAmbientLight

# Callback function for illuminance callback (parameter has unit Lux/10)
def cb_illuminance(illuminance):
    print("Illuminance: " + str(illuminance/10.0) + " Lux")

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    al = BrickletAmbientLight(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Register illuminance callback to function cb_illuminance
    al.register_callback(al.CALLBACK_ILLUMINANCE, cb_illuminance)

    # Set period for illuminance callback to 1s (1000ms)
    # Note: The illuminance callback is only called every second
    #       if the illuminance has changed since the last call!
    al.set_illuminance_callback_period(1000)

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
