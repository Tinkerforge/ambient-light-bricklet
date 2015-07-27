#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_ambient_light'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
al = BrickletAmbientLight.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current illuminance (unit is Lux/10)
illuminance = al.get_illuminance
puts "Illuminance: #{illuminance/10.0} Lux"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
