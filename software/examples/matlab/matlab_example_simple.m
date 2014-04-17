function matlab_example_simple
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletAmbientLight;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'amb'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    al = BrickletAmbientLight(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current illuminance (unit is Lux/10)
    illuminance = al.getIlluminance();
    fprintf('Illuminance: %g Lux\n', illuminance/10.0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end
