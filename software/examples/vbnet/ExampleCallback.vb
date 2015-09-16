Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for illuminance callback (parameter has unit Lux/10)
    Sub IlluminanceCB(ByVal sender As BrickletAmbientLight, ByVal illuminance As Integer)
        Console.WriteLine("Illuminance: " + (illuminance/10.0).ToString() + " Lux")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim al As New BrickletAmbientLight(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register illuminance callback to subroutine IlluminanceCB
        AddHandler al.Illuminance, AddressOf IlluminanceCB

        ' Set period for illuminance callback to 1s (1000ms)
        ' Note: The illuminance callback is only called every second
        '       if the illuminance has changed since the last call!
        al.SetIlluminanceCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
