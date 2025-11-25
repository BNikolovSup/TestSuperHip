unit uKeyThrottle;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils, Winapi.Windows;

type
  TKeyThrottle = class
  private
    class var FLastAction: Int64;
    class var FInterval: Integer;
  public
    class property Interval: Integer read FInterval write FInterval;

    /// <summary>
    /// Връща TRUE ако е минало достатъчно време от последното действие
    /// </summary>
    class function CanExecute: Boolean;
  end;

implementation

{ TKeyThrottle }

class function TKeyThrottle.CanExecute: Boolean;
var
  nowTicks: Int64;
begin
  nowTicks := GetTickCount;

  // ако е първо извикване
  if FLastAction = 0 then
  begin
    FLastAction := nowTicks;
    Exit(True);
  end;

  // проверка за интервала
  if nowTicks - FLastAction >= FInterval then
  begin
    FLastAction := nowTicks;
    Exit(True);
  end;

  Result := False; // блокираме повтарящите KeyDown-и
end;

initialization
  TKeyThrottle.FInterval := 1000; // 30 ms throttle (~33 FPS)

end.

