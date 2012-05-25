#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_ambient_light'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = '7tS' # Change to your UID

ipcon = IPConnection.new HOST, PORT # Create IP connection to brickd
al = BrickletAmbientLight.new UID # Create device object
ipcon.add_device al # Add device to IP connection
# Don't use device before it is added to a connection

# Get current illuminance (unit is Lux/10)
illuminance = al.get_illuminance / 10.0
puts "Illuminance: #{illuminance} Lux"

puts 'Press key to exit'
$stdin.gets
ipcon.destroy
