program ExampleThreshold;

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
    procedure ReachedCB(const illuminance: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '7tS';

var
  e: TExample;

{ Callback for illuminance greater than 200 Lux }
procedure TExample.ReachedCB(const illuminance: word);
begin
  WriteLn(Format('We have %f Lux.', [illuminance/10.0]));
  WriteLn('Too bright, close the curtains!');
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

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  am.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  am.OnIlluminanceReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for "greater than 200 Lux" (unit is Lux/10) }
  am.SetIlluminanceCallbackThreshold('>', 200*10, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
