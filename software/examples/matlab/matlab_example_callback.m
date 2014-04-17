function matlab_example_callback
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAmbientLight;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'amb'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    al = BrickletAmbientLight(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for illuminance callback to 1s (1000ms)
    % Note: The callback is only called every second if the
    %       illuminance has changed since the last call!
    al.setIlluminanceCallbackPeriod(1000);

    % Register illuminance callback to function cb_illuminance
    set(al, 'IlluminanceCallback', @(h, e) cb_illuminance(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for illuminance callback (parameter has unit Lux/10)
function cb_illuminance(e)
    fprintf('Illuminance: %g Lux\n', e.illuminance/10.0);
end
