unit DynGroup;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Types, Winapi.Windows, System.Generics.Collections,
  Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Tabs;

type

  TDynGroup = class(TBevel)
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
    FTabs: TStrings;
    FTabIndex: Integer;
    FDH: Integer;
    FDY: Integer;
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
    procedure SetTabs(const Value: TStrings);
    procedure SetTabIndex(const Value: Integer);
    function GetIsParentGroup: Boolean;
  protected
    procedure Resize; override;
    procedure Loaded; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

  public
    FDynGroupBox: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure ControlToDyn(xPos, yPos: Integer);
    procedure DynToControl(xPos, yPos: Integer);
    function GenerateRunTimeCode: string;

    property CanMove: Boolean read FCanMove write FCanmove;
    property IsParentGroup: Boolean read GetIsParentGroup;
    //property DY: Integer read FDY write FDY;
    //property DH: Integer read FDH write FDH;

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
    property Tabs: TStrings read FTabs write SetTabs;
    property TabIndex: Integer read FTabIndex write SetTabIndex;

  end;

procedure Register;

implementation
uses
  DynWinPanel;

procedure Register;
begin
  RegisterComponents('Biser', [TDynGroup]);
end;

{ TDynGroup }





procedure TDynGroup.ControlToDyn(xPos, yPos: Integer);
var
  dynGrpBox: TDynGroupBox;
begin
  if FDynGroupBox <> nil then
  begin
    dynGrpBox:= TDynGroupBox(FDynGroupBox);
    dynGrpBox.FRect.Left := round((XPos + dynGrpBox.FDynPanel.HScrollPos)/dynGrpBox.FDynPanel.scale);
    dynGrpBox.FRect.Top := round((YPos + dynGrpBox.FDynPanel.VScrollPos)/dynGrpBox.FDynPanel.scale);
    dynGrpBox.FRect.Height := round(Self.Height/dynGrpBox.FDynPanel.scale);
    dynGrpBox.FRect.Width := round(Self.Width/dynGrpBox.FDynPanel.scale);
    dynGrpBox.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynGrpBox.FRect.Left;
      Self.FDynTop := dynGrpBox.FRect.Top;
      Self.FDynRight := dynGrpBox.FRect.Right;
      Self.FDynBottom := dynGrpBox.FRect.Bottom;
      //Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;

  end;
end;

constructor TDynGroup.Create(AOwner: TComponent);
begin
  inherited;
  Shape  := bsSpacer;
  Style := bsRaised;
  FDynGroupBox := nil;
  FCanMove := True;
  FDynFontHeight := 14;
  FLockSize := False;
  FTabs := TStringList.Create;
end;

destructor TDynGroup.destroy;
begin
  if FDynGroupBox <> nil then
    FreeAndNil(FDynGroupBox);
  FTabs.Free;
  inherited;
end;

procedure TDynGroup.DynToControl(xPos, yPos: Integer);
var
  dynGrpBox: TDynGroupBox;
begin
  if FDynGroupBox <> nil then
  begin
    dynGrpBox:= TDynGroupBox(FDynGroupBox);
    dynGrpBox.FRect.Left := round((XPos - dynGrpBox.FDynPanel.HScrollPos)*dynGrpBox.FDynPanel.scale);
    dynGrpBox.FRect.Top := round((YPos - dynGrpBox.FDynPanel.VScrollPos)*dynGrpBox.FDynPanel.scale);
    dynGrpBox.FRect.Height := round(Self.Height*dynGrpBox.FDynPanel.scale);
    dynGrpBox.FRect.Width := round(Self.Width*dynGrpBox.FDynPanel.scale);
    dynGrpBox.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynGrpBox.FRect.Left;
      Self.FDynTop := dynGrpBox.FRect.Top;
      Self.FDynRight := dynGrpBox.FRect.Right;
      Self.FDynBottom := dynGrpBox.FRect.Bottom;
      //Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;

  end;
end;

function TDynGroup.GenerateRunTimeCode: string;
var
  i: Integer;
  grp:TDynGroupBox;
begin
  grp := TDynGroupBox(FDynGroupBox);
  grp.CalcChild;
  for i := 0 to grp.FListChilds.Count - 1 do
  begin
    if grp.FListChilds[i] is TDynEdit then
    begin

    end;
  end;
end;

function TDynGroup.GetBoundsDynRect: TRect;
var
  dynGrp: TDynGroupBox;
begin
  dynGrp:= TDynGroupBox(FDynGroupBox);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

function TDynGroup.GetIsParentGroup: Boolean;
var
  i: Integer;
  grp, selfGrp: TDynGroupBox;
begin
  Result := false;
  selfGrp := TDynGroupBox(FDynGroupBox);
  for i := 0 to selfGrp.FDynPanel.FGroupBoxs.Count - 1 do
  begin
    grp := selfGrp.FDynPanel.FGroupBoxs[i];
    if grp = selfGrp then
      Continue;
    if grp.FRect.Contains(selfGrp.FRect) then
      Exit;
  end;
  Result := True;
end;

procedure TDynGroup.Loaded;
begin
  inherited;
  //if not (csDesigning in ComponentState) then
  begin
    ControlToDyn(Left, Top);
  end;
end;

procedure TDynGroup.Resize;
begin
  inherited;
  if (csDesigning in ComponentState) then //  само по време на дизайна, се променя размера. Иначе се променя, ама е следствие на нещо друго
  begin
    if Parent is TDynWinPanel then
    begin
      TDynWinPanel(Parent).btn1.Caption := 'resizeGB';
    end;
  end;
end;

procedure TDynGroup.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
   deltaX, deltaY, deltaH: Integer;
begin


  deltaX := ALeft - Left;
  deltaY := ATop - Top;
  deltaH := AHeight - Height;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    if Self.Parent = nil then Exit;
    if not CanMove then  Exit;
    ControlToDyn(Left, top);
    if Scale <> TDynWinPanel(Parent).Scale then
    begin
      Scale := TDynWinPanel(Parent).Scale;
    end;
    Exit;
  end;
  if Self.Parent = nil then Exit;
  if not CanMove then  Exit;
  //TDynGroupBox(Self.FDynGroupBox).CalcChild;
  //TDynGroupBox(Self.FDynGroupBox).CalcForMove(0);
  //TDynGroupBox(Self.FDynGroupBox).MoveForMove(deltaH);
  ControlToDyn(Left, top);
  if Scale <> TDynWinPanel(Parent).Scale then
  begin
    Scale := TDynWinPanel(Parent).Scale;
  end;

end;

procedure TDynGroup.SetBoundsDynRect(const Value: TRect);
begin

end;

procedure TDynGroup.SetDynFontHeight(const Value: Integer);
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
end;

procedure TDynGroup.SetDynTablename(const Value: string);
begin
  FDynTablename := Value;
  TableType := Random(60);
end;

procedure TDynGroup.SetFieldname(const Value: string);
begin
  FFieldname := Value;
  FieldType := Random(20) +  100;
end;

procedure TDynGroup.SetLockSize(const Value: Boolean);
begin
  FLockSize := Value;
  if (csDesigning in ComponentState)then
  begin
    if FDynGroupBox <> nil then
    begin
      TDynGroupBox(FDynGroupBox).FDynPanel.Redraw;
    end;
  end;
end;

procedure TDynGroup.SetParent(AParent: TWinControl);
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

procedure TDynGroup.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TDynGroup.SetTabIndex(const Value: Integer);
begin
  FTabIndex := Value;
end;

procedure TDynGroup.SetTabs(const Value: TStrings);
begin
  FTabs.Assign(Value);
end;

procedure TDynGroup.WMASetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;

procedure TDynGroup.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if (csDesigning in ComponentState) then
  begin
    if Parent is TDynWinPanel then
    begin
      TDynWinPanel(Parent).btn1.Caption := 'resizIngGB';
    end;
  end;
end;

procedure TDynGroup.WMMove(var Msg: TWMMove);

begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);

  end;

end;

procedure TDynGroup.WndProc(var Message: TMessage);
begin


  inherited;
  if (csDesigning in ComponentState) then
  begin
   // if Parent is TDynWinPanel then
//    begin
//      if Message.Msg = 45076 then
//      begin
//        TDynWinPanel(Parent).RunTimeCode.Add (IntToStr(Message.Msg));
//        //TDynGroupBox(FDynGroupBox).FDynPanel.Redraw;
//      end;
//    end;
  end;
end;







end.
