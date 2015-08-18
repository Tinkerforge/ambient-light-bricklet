Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for illuminance greater than 500 Lux (parameter has unit Lux/10)
    Sub IlluminanceReachedCB(ByVal sender As BrickletAmbientLight, ByVal illuminance As Integer)
        System.Console.WriteLine("Illuminance: " + (illuminance/10.0).ToString() + " Lux")
        System.Console.WriteLine("Too bright, close the curtains!")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim al As New BrickletAmbientLight(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        al.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function IlluminanceReachedCB
        AddHandler al.IlluminanceReached, AddressOf IlluminanceReachedCB

        ' Configure threshold for "greater than 500 Lux" (unit is Lux/10)
        al.SetIlluminanceCallbackThreshold(">"C, 500*10, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
