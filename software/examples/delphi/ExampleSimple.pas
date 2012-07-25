program ExampleSimple;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletAmbientLight;

type
  TExample = class
  private
    ipcon: TIPConnection;
    am: TBrickletAmbientLight;
  public
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '7tS';

var
  e: TExample;

procedure TExample.Execute;
var illuminance: word;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  am := TBrickletAmbientLight.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(am);
  { Don't use device before it is added to a connection }

  { Get current illuminance (unit is Lux/10) }
  illuminance := am.GetIlluminance;
  WriteLn(Format('Illuminance: %f Lux', [illuminance/10.0]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
