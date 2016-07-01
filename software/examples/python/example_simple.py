#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Ambient Light Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ambient_light import BrickletAmbientLight

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    al = BrickletAmbientLight(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current illuminance (unit is Lux/10)
    illuminance = al.get_illuminance()
    print("Illuminance: " + str(illuminance/10.0) + " Lux")

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
