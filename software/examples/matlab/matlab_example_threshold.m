function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAmbientLight;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'amb'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    al = BrickletAmbientLight(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    al.setDebouncePeriod(10000);

    % Register threshold reached callback to function cb_reached
    set(al, 'IlluminanceReachedCallback', @(h, e) cb_reached(e));

    % Configure threshold for "greater than 200 Lux" (unit is Lux/10)
    al.setIlluminanceCallbackThreshold('o', 20*10, 0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for illuminance greater than 200 Lux
function cb_reached(e)
    fprintf('We have %g Lux.\n', e.illuminance/10.0);
    fprintf('Too bright, close the curtains!\n')
end
