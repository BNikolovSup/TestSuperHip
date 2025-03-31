unit DynTabSet;    //realhei

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Types, Winapi.Windows, System.Generics.Collections,
  Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Tabs;

type
  TDynTabSet = class(TTabSet)
  private
    FCanMove: Boolean;
    FDynTop: integer;
    FDynLeft: integer;
    FDynRight: Integer;
    FScale: Double;
    FDynBottom: Integer;
    FDynFontHeight: Integer;
    FlabelCaption: string;
    FLockSize: Boolean;
    FFieldname: string;
    FDynTableName: string;
    FFieldType: Integer;
    FtableType: Integer;
    FRealHeight: Integer;
    FTabHeight: Integer;
    //TabSet1: TTabSet;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;


    procedure WndProc(var Message: TMessage); override;
    procedure SetParent(AParent: TWinControl); override;

    function GetBoundsDynRect: TRect;
    procedure SetBoundsDynRect(const Value: TRect);
    procedure SetScale(const Value: Double);
    procedure SetDynFontHeight(const Value: Integer);
    procedure SetLockSize(const Value: Boolean);
    procedure SetDynTablename(const Value: string);
    procedure SetFieldname(const Value: string);
    procedure setRealHeight(const Value: Integer);
  protected

    procedure Resize; override;
    procedure Loaded; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;

  public
    FDynTabControl: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure ControlToDyn(xPos, yPos: Integer);
    procedure DynToControl(xPos, yPos: Integer);
    function GenerateRunTimeCode: string;

    property CanMove: Boolean read FCanMove write FCanmove;

  published
    property Scale: Double read FScale write SetScale;
    property DynLeft: integer  read FDynLeft write FDynLeft;
    property DynRight: Integer read FDynRight write FDynRight;
    property DynBottom: Integer read FDynBottom write FDynBottom;
    property DynTop: integer  read FDynTop write FDynTop;
    property DynFontHeight: Integer read FDynFontHeight write SetDynFontHeight;
    property BoundsDynRect: TRect read GetBoundsDynRect ;
    property labelCaption: string read FlabelCaption write FlabelCaption;
    property LockSize: Boolean read FLockSize write SetLockSize;
    property DynTableName: string read FDynTablename write SetDynTablename;
    property FieldName: string read FFieldname write SetFieldname;
    property FieldType: Integer read FFieldType write FFieldType;
    property TableType: Integer read FtableType write FTabletype;
    property RealHeight: Integer read FRealHeight write setRealHeight;
  end;

procedure Register;

implementation

uses
  DynWinPanel;

procedure Register;
begin
  RegisterComponents('Biser', [TDynTabSet]);
end;

{ TDynTabSet }



procedure TDynTabSet.ControlToDyn(xPos, yPos: Integer);
var
  dynTabControl: TDynTabControl;
begin
  if FDynTabControl <> nil then
  begin
    dynTabControl:= TDynTabControl(FDynTabControl);
    dynTabControl.FRect.Left := round((XPos + dynTabControl.FDynPanel.HScrollPos)/dynTabControl.FDynPanel.scale);
    dynTabControl.FRect.Top := round((YPos + dynTabControl.FDynPanel.VScrollPos)/dynTabControl.FDynPanel.scale);
    dynTabControl.FRect.Height := round((Self.Height)/dynTabControl.FDynPanel.scale);
    //if  not (csDesigning in ComponentState) then
//    begin
//      dynTabControl.FRect.Height := round((Self.Height + RealHeight)/dynTabControl.FDynPanel.scale);
//    end
//    else
//    begin
//      dynTabControl.FRect.Height := round((Self.Height)/dynTabControl.FDynPanel.scale);
//    end;
    dynTabControl.FRect.Width := round(Self.Width/dynTabControl.FDynPanel.scale);
    dynTabControl.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynTabControl.FRect.Left;
      Self.FDynTop := dynTabControl.FRect.Top;
      Self.FDynRight := dynTabControl.FRect.Right;
      Self.FDynBottom := dynTabControl.FRect.Bottom;
      //Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;

  end;
end;

constructor TDynTabSet.Create(AOwner: TComponent);
begin
  inherited;
  FDynTabControl := nil;
  FCanMove := True;
  FDynFontHeight := 14;
  FLockSize := False;




  BackgroundColor := $00E4E1DC;
end;



procedure TDynTabSet.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    RealHeight := Round(Height/TDynWinPanel(Parent).Scale) - 16;//   - round(16 / TDynWinPanel(Parent).Scale);
    Height := round(16 * TDynWinPanel(Parent).Scale);
  end;
end;

destructor TDynTabSet.destroy;
begin
  if FDynTabControl <> nil then
    FreeAndNil(FDynTabControl);
  inherited;
end;

procedure TDynTabSet.DynToControl(xPos, yPos: Integer);
var
  dynTabControl: TDynGroupBox;
begin
  if FDynTabControl <> nil then
  begin
    dynTabControl:= TDynTabControl(FDynTabControl);
    dynTabControl.FRect.Left := round((XPos - dynTabControl.FDynPanel.HScrollPos)*dynTabControl.FDynPanel.scale);
    dynTabControl.FRect.Top := round((YPos - dynTabControl.FDynPanel.VScrollPos)*dynTabControl.FDynPanel.scale);
    dynTabControl.FRect.Height := round((Self.Height)*dynTabControl.FDynPanel.scale);
    //if  not (csDesigning in ComponentState) then
//    begin
//      dynTabControl.FRect.Height := round((Self.Height + Self.RealHeight)*dynTabControl.FDynPanel.scale);
//    end
//    else
//    begin
//      dynTabControl.FRect.Height := round((Self.Height)*dynTabControl.FDynPanel.scale);
//    end;
    dynTabControl.FRect.Width := round(Self.Width*dynTabControl.FDynPanel.scale);
    dynTabControl.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynTabControl.FRect.Left;
      Self.FDynTop := dynTabControl.FRect.Top;
      Self.FDynRight := dynTabControl.FRect.Right;
      Self.FDynBottom := dynTabControl.FRect.Bottom;
      //Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;

  end;
end;

function TDynTabSet.GenerateRunTimeCode: string;
begin

end;

function TDynTabSet.GetBoundsDynRect: TRect;
var
  dynGrp: TDynGroupBox;
begin
  dynGrp:= TDynTabControl(FDynTabControl);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

procedure TDynTabSet.Loaded;
begin
  inherited;
  //if not (csDesigning in ComponentState) then
  begin
    ControlToDyn(Left, Top);
  end;
end;



procedure TDynTabSet.Resize;
begin
  inherited;
  if (csDesigning in ComponentState) then //  само по време на дизайна, се променя размера. Иначе се променя, ама е следствие на нещо друго
  begin
    if Parent is TDynWinPanel then
    begin
      TDynWinPanel(Parent).btn1.Caption := 'resizeTab';
    end;
  end;
end;

procedure TDynTabSet.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
   deltaX, deltaY, deltaH: Integer;
begin


  deltaX := ALeft - Left;
  deltaY := ATop - Top;
  deltaH := AHeight - Height;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if (csDesigning in ComponentState) then
  begin
    if Self.Parent = nil then Exit;
    if not CanMove then  Exit;
    ControlToDyn(Left, top);
    if Scale <> TDynWinPanel(Parent).Scale then
    begin
      Scale := TDynWinPanel(Parent).Scale;
      //TDynWinPanel(Parent).RunTimeCode.Add('TDynGroup.SetBounds');
    end;
    Exit;
  end;
  if Self.Parent = nil then Exit;
  if not CanMove then  Exit;
  TDynTabControl(Self.FDynTabControl).CalcChild;
  TDynTabControl(Self.FDynTabControl).CalcForMove;
  TDynTabControl(Self.FDynTabControl).MoveForMove(deltaH);
  ControlToDyn(Left, top);
  if Scale <> TDynWinPanel(Parent).Scale then
  begin
    Scale := TDynWinPanel(Parent).Scale;
    //TDynWinPanel(Parent).RunTimeCode.Add('TDynGroup.SetBounds');
  end;
  //if (csDesigning in ComponentState) then
//  begin
//    if FDynGroupBox <> nil then
//    begin
//      if TDynGroupBox(FDynGroupBox).FListChilds.Count > 0 then
//      begin
//        TDynGroupBox(FDynGroupBox).MoveChild(deltaX, deltaY);
//      end;
//      if TDynGroupBox(FDynGroupBox).FListForMove.Count > 0 then
//      begin
//        TDynGroupBox(FDynGroupBox).MoveForMove(deltaY);
//      end;
//      if FLockSize then
//      begin
//        TDynGroupBox(FDynGroupBox).FDynPanel.Redraw;
//      end;
//     // ShowMessage(IntToStr(deltaY));
//    end;
//  end;
end;

procedure TDynTabSet.SetBoundsDynRect(const Value: TRect);
begin

end;

procedure TDynTabSet.SetDynFontHeight(const Value: Integer);
var
  hFnt : hFont;
  lf : tLogfont;
  oldH: Integer;
  cf: TWMChooseFont_GetLogFont;
begin
  FDynFontHeight := Value;
  GetObject(Font.Handle, sizeof(lf), @lf);
  lf.lfHeight := round(FDynFontHeight * FScale);
  hFnt := CreateFontIndirect(lf);
  Font.Handle := hFnt;

  //if not (csDesigning in ComponentState) then
//  begin
//    if Parent is TDynWinPanel then
//    begin
//      Self.Height := lf.lfHeight + 10 ;
//    end;
//  end;
end;

procedure TDynTabSet.SetDynTablename(const Value: string);
begin

end;

procedure TDynTabSet.SetFieldname(const Value: string);
begin

end;

procedure TDynTabSet.SetLockSize(const Value: Boolean);
begin
  FLockSize := Value;
  if (csDesigning in ComponentState)then
  begin
    if FDynTabControl <> nil then
    begin
      TDynTabControl(FDynTabControl).FDynPanel.Redraw;
    end;
  end;
end;

procedure TDynTabSet.SetParent(AParent: TWinControl);
begin
  inherited;
  if (csDesigning in ComponentState)then
  begin
    if AParent is TDynWinPanel then
    begin
      ControlToDyn(left, top);
    end;
  end
  else
  begin
    if AParent is TDynWinPanel then
    begin
      ControlToDyn(left, top);
    end;
  end;
end;

procedure TDynTabSet.setRealHeight(const Value: Integer);
begin
  FRealHeight := Value;
 // Height := FRealHeight +
end;

procedure TDynTabSet.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TDynTabSet.WMASetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;



procedure TDynTabSet.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  if (csDesigning in ComponentState) then
  begin
    if Parent is TDynWinPanel then
    begin
      TDynWinPanel(Parent).btn1.Caption := 'resizIngTab';
    end;
  end;
end;

procedure TDynTabSet.WMMove(var Msg: TWMMove);
begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);

  end;
end;

procedure TDynTabSet.WndProc(var Message: TMessage);
begin
  inherited;

end;

end.
