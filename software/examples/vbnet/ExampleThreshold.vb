Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "aNt" ' Change to your UID

    ' Callback for illuminance greater than 200 Lux
    Sub ReachedCB(ByVal sender As BrickletAmbientLight, ByVal illuminance As Integer)
        System.Console.WriteLine("We have " + (illuminance/10.0).ToString() + " Lux.")
        System.Console.WriteLine("Too bright, close the curtains!")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim al As New BrickletAmbientLight(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        al.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler al.IlluminanceReached, AddressOf ReachedCB

        ' Configure threshold for "greater than 200 Lux" (unit is Lux/10)
        al.SetIlluminanceCallbackThreshold(">"C, 200*10, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
