program ExampleCallback;

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
    procedure IlluminanceCB(const illuminance: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '7tS';

var
  e: TExample;

{ Callback function for illuminance callback (parameter has unit Lux/10) }
procedure TExample.IlluminanceCB(const illuminance: word);
begin
  WriteLn(Format('Illuminance: %f Lux', [illuminance/10.0]));
end;

procedure TExample.Execute;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  am := TBrickletAmbientLight.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(am);
  { Don't use device before it is added to a connection }

  { Set Period for illuminance callback to 1s (1000ms)
    Note: The illuminance callback is only called every second if the
          illuminance has changed since the last call! }
  am.SetIlluminanceCallbackPeriod(1000);

  { Register illuminance callback to procedure IlluminanceCB }
  am.OnIlluminance := {$ifdef FPC}@{$endif}IlluminanceCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
