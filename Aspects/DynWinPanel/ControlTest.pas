unit ControlTest;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Winapi.Windows;

type
  TControlTest = class(TControl)
  private

  protected

  public
    FCanvas: TControlCanvas;
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('biser', [TControlTest]);
end;

{ TControlTest }

constructor TControlTest.Create(AOwner: TComponent);
var
  r: TRect;
begin
  inherited;

  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  //if not (csDesigning in ComponentState) then
//  begin
//    r := Rect(0, 0, 20, 20);
//    DrawText(0, PChar('tttt'), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
//  end;
end;

end.
