function octave_example_threshold()
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "amb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    al = java_new("com.tinkerforge.BrickletAmbientLight", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    al.setDebouncePeriod(10000);

    % Configure threshold for "greater than 200 Lux" (unit is Lux/10)
    al.setIlluminanceCallbackThreshold(al.THRESHOLD_OPTION_OUTSIDE, 20*10, 0);
    
    % Register illuminance callback to function cb_illuminance
    al.addIlluminanceReachedCallback(@cb_reached);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for illuminance callback (parameter has unit Lux/10)
function cb_reached(e)
    fprintf("We have %g Lux.\n", e.illuminance/10.0);
    fprintf("Too bright, close the curtains!\n")
end
