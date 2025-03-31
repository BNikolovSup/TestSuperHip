unit DynSpeedButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Buttons;

type
  TDynSpeedButton = class(TSpeedButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('biser', [TDynSpeedButton]);
end;

end.
