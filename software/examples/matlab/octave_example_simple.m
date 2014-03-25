function octave_example_simple
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "amb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    al = java_new("com.tinkerforge.BrickletAmbientLight", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current illuminance (unit is Lux/10)
    illuminance = al.getIlluminance()/10;

    fprintf("Illuminance: %g Lux\n", illuminance);

    input("\nPress any key to exit...\n", "s");
    ipcon.disconnect();
end
