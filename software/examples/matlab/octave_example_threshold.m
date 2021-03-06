function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Ambient Light Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    al = javaObject("com.tinkerforge.BrickletAmbientLight", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    al.setDebouncePeriod(10000);

    % Register illuminance reached callback to function cb_illuminance_reached
    al.addIlluminanceReachedCallback(@cb_illuminance_reached);

    % Configure threshold for illuminance "greater than 200 lx"
    al.setIlluminanceCallbackThreshold(">", 200*10, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for illuminance reached callback
function cb_illuminance_reached(e)
    fprintf("Illuminance: %g lx\n", e.illuminance/10.0);
    fprintf("Too bright, close the curtains!\n");
end
