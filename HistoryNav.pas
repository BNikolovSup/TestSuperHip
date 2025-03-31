unit HistoryNav;

interface
uses
  iniFiles, System.IOUtils, System.Classes, VirtualTrees, VirtualStringTreeHipp,
  Aspects.Types, Vcl.Controls, system.Types, Winapi.Messages, Vcl.StdCtrls, Winapi.Windows,
  Vcl.Mask, Vcl.ComCtrls, Vcl.Graphics, system.SysUtils;


type
  THistoryNav = class(TObject)
    // навигационно дърво и възел
    Vtr: TVirtualStringTree;
    node: TVirtualNode;
    //работен екран
    WorkSheet: TTabSheet;

  public
    function FindVTR(ts: TTabSheet): TVirtualStringTree;
  end;

implementation

{ THistoryNav }

function THistoryNav.FindVTR(ts: TTabSheet): TVirtualStringTree;
var
  i: Integer;
  ctrl: TControl;
begin
  Result := nil;
  for i := 0 to ts.ControlCount - 1 do
  begin
    ctrl := ts.Controls[i];
    if ctrl is TVirtualStringTree then
    begin
      Result := TVirtualStringTree(ctrl);
      Exit;
    end;
  end;
end;

end.
