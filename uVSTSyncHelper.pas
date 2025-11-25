unit uVSTSyncHelper;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls,
  VirtualTrees;

type
  TVSTSyncHelper = class
  private
    class var FTimer: TTimer;
    class var FPendTree: TBaseVirtualTree;
    class var FPendNode: PVirtualNode;
    class var FDelay: Integer;

    class procedure OnTimer(Sender: TObject);
  public
    /// <summary>
    /// Колко ms да се изчака (default = 15 ms)
    /// </summary>
    class property Delay: Integer read FDelay write FDelay;

    /// <summary>
    /// Бързо и гладко позициониране на дърво към даден възел
    /// </summary>
    class procedure SyncToNode(ATree: TBaseVirtualTree; ANode: PVirtualNode);
  end;

implementation

{ TVSTSyncHelper }

class procedure TVSTSyncHelper.OnTimer(Sender: TObject);
begin
  if (FPendTree = nil) or (FPendNode = nil) then Exit;

  FTimer.Enabled := False;

  // Най-бързият възможен начин — без огромни цикли вътре
  FPendTree.BeginUpdate;
  try
    FPendTree.TopNode := FPendNode;      // моментално скролира
    FPendTree.FocusedNode := FPendNode;  // маркира
    FPendTree.Refresh;
    //FPendTree.ScrollIntoView(FPendNode, True); // прецизно довършва
  finally
    FPendTree.EndUpdate;
  end;

  FPendTree := nil;
  FPendNode := nil;
end;

class procedure TVSTSyncHelper.SyncToNode(ATree: TBaseVirtualTree; ANode: PVirtualNode);
begin
  if (ATree = nil) or (ANode = nil) then Exit;

  // 1) първоначална настройка
  if FTimer = nil then
  begin
    FTimer := TTimer.Create(nil);
    FTimer.Enabled := False;
    FTimer.OnTimer := OnTimer;
    FDelay := 2;
  end;

  // 2) запомняме последното искане
  FPendTree := ATree;
  FPendNode := ANode;

  // 3) стартираме debounce таймера
  FTimer.Enabled := False;
  FTimer.Interval := FDelay;
  FTimer.Enabled := True;
end;

end.

