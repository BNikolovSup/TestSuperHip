unit SizeGripMemo;
            //color
interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math;

type
  TSizeGripMemo = class;
  THeightChange = procedure(sender: TSizeGripMemo; NewHeight: Integer) of object;

  TSizeGripMemo = class(TMemo)
  private
    FCanMove: Boolean;
    FDynRight: Integer;
    FDynFontHeight: Integer;
    FDynBottom: Integer;
    FDynTop: integer;
    FDynLeft: integer;
    FScale: Double;
    FlabelCaption: string;
    FDynVisible: Boolean;
    FDynMin: Integer;
    FDH: Integer;
    FDY: Integer;
    FOnHeightChange: THeightChange;
    FOnEnterDYN: TNotifyEvent;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMSizing(var Msg: TMessage); message WM_SIZING;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMVISIBLECHANGED(var Msg: TMessage); message CM_VISIBLECHANGED;

    function GetBoundsDynRect: TRect;
    procedure SetDynFontHeight(const Value: Integer);
    procedure SetScale(const Value: Double);
    procedure SetDynVisible(const Value: Boolean);
  protected
    FCanvas: TControlCanvas;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure KeyPress(var Key: Char); override;

    procedure SetEditRect;
    procedure Resize; override;
    procedure Loaded; override;
    procedure DoEnter; override;

    property OnResize;

  public
    FDynMemo: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor destroy ; override;
    procedure OnMemoChange(Sender: TObject);
    procedure ControlToDyn(xPos, yPos: Integer);
    function CalcH: Integer;
    property CanMove: Boolean read FCanMove write FCanmove;
    property DY: Integer read FDY write FDY;
    property DH: Integer read FDH write FDH;
    property OnEnterDYN: TNotifyEvent read FOnEnterDYN write FOnEnterDYN;
  published
    property Scale: Double read FScale write SetScale;
    property DynLeft: integer  read FDynLeft write FDynLeft;
    property DynRight: Integer read FDynRight write FDynRight;
    property DynBottom: Integer read FDynBottom write FDynBottom;
    property DynTop: integer  read FDynTop write FDynTop;
    property DynFontHeight: Integer read FDynFontHeight write SetDynFontHeight;
    property BoundsDynRect: TRect read GetBoundsDynRect ;
    property labelCaption: string read FlabelCaption write FlabelCaption;
    property DynVisible: Boolean read FDynVisible write SetDynVisible;
    property DynMin: Integer read FDynMin write FDynMin;
    property OnHeightChange: THeightChange read FOnHeightChange write FOnHeightChange;

  end;

procedure Register;

implementation
uses
  DynWinPanel;

procedure Register;
begin
  RegisterComponents('Biser', [TSizeGripMemo]);
end;

{ TSizeGripMemo }


function TSizeGripMemo.CalcH: Integer;
begin
  Result := (Lines.count + 1) * Font.Height + 7 ;
  if Result > (DynMin * Self.Scale) then
  begin
    if Assigned(FOnHeightChange) then
    begin
      FOnHeightChange(Self, Result);
    end;
  end;
end;

procedure TSizeGripMemo.CMVISIBLECHANGED(var Msg: TMessage);
begin
  inherited;
end;

procedure TSizeGripMemo.ControlToDyn(xPos, yPos: Integer);
var
  dynMem: TDynMemo;
begin
  if Name = 'mmo6' then
    Name := 'mmo6';

  if FDynMemo <> nil then
  begin
    dynMem:= TDynMemo(FDynMemo);
    dynMem.FRect.Left := round((XPos + dynMem.FDynPanel.HScrollPos)/dynMem.FDynPanel.scale);
    dynMem.FRect.Top := round((YPos + dynMem.FDynPanel.VScrollPos)/dynMem.FDynPanel.scale);
    dynMem.FRect.Height := round(Self.Height/dynMem.FDynPanel.scale);
    dynMem.FRect.Width := round(Self.Width/dynMem.FDynPanel.scale);
    //dynMem.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynMem.FRect.Left;
      Self.FDynTop := dynMem.FRect.Top;
      Self.FDynRight := dynMem.FRect.Right;
      Self.FDynBottom := dynMem.FRect.Bottom;
      //Lines.Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;
  end;
end;

constructor TSizeGripMemo.Create(AOwner: TComponent);
begin
  FCanMove := False;
  inherited;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  Visible := True;

  FDynMemo := nil;
  FCanMove := True;
  FDynFontHeight := 12;
  Self.OnChange := OnMemoChange;
  Self.ScrollBars := ssVertical;
  Self.DoubleBuffered := True;
end;

destructor TSizeGripMemo.destroy;
begin
  FCanvas.Free;
  if FDynMemo <> nil then
    FreeAndNil(FDynMemo);
  inherited;
end;

procedure TSizeGripMemo.DoEnter;
begin
  inherited;
  if Assigned(FOnEnterDYN) then
    FOnEnterDYN(FDynMemo);
end;

function TSizeGripMemo.GetBoundsDynRect: TRect;
var
  dynmem: TDynMemo;
begin
  dynmem:= TDynMemo(FDynMemo);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

procedure TSizeGripMemo.KeyPress(var Key: Char);
begin
  inherited;
  if Key = ^A then
    SelectAll;
end;

procedure TSizeGripMemo.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    ControlToDyn(Left, Top);
  end;
end;

procedure TSizeGripMemo.OnMemoChange(Sender: TObject);
var
  tp, bt: Integer;
  mmo: TDynMemo;
  NewH: Integer;
  DYN: TDynWinPanel;
begin

  if (csDesigning in  ComponentState) then
  begin
    inherited;
    Exit;
  end;
  inherited;
  if Parent = nil then Exit;
  if (csLoading in  Parent.ComponentState) then Exit;


  DYN := TDynWinPanel(Parent);
  if Assigned(DYN.OnSetText) then
  begin
    DYN.OnSetText(TDynWinPanel(Parent), TDynMemo(FDynMemo), Self.Text);
  end;

  NewH := CalcH;

  if false and (newH <> Self.Height) then
  begin
    if owner is TDynWinPanel then
    begin
      if TDynWinPanel(owner).CalculatedMemo <> self then
      begin
        TDynWinPanel(owner).NestedGroup(self);
        TDynWinPanel(owner).CalculatedMemo := self;
      end;
    end;
    if (NewH > DynMin * scale) then
    begin
      if FDynMemo <> nil then
      begin
        mmo := TDynMemo(FDynMemo);
        mmo.CalcForMove;

        mmo.FRect.Height := Round(NewH / Scale);
        Self.Height := NewH;
        mmo.StretchGroupBoxHeight(NewH);
        mmo.MoveForMove(1);
        mmo.FDynPanel.Redraw;
      end;
    end
    else
    begin
      mmo := TDynMemo(FDynMemo);
        mmo.CalcForMove;

        mmo.FRect.Height := Round(DynMin / Scale);
        Self.Height := DynMin;
        mmo.StretchGroupBoxHeight(DynMin);

        mmo.MoveForMove(1);
        mmo.FDynPanel.Redraw;
    end;
  end;

end;

procedure TSizeGripMemo.Resize;

begin
  //if (csDesigning in ComponentState) then //  само по време на дизайна, се променя размера. Иначе се променя, ама е следствие на нещо друго
  begin

    if Parent is TDynWinPanel then
    begin
      if not CanMove then  Exit;
      ControlToDyn(Left, top);
      if Scale <> TDynWinPanel(Parent).Scale then
      begin
        Scale := TDynWinPanel(Parent).Scale;
      end;

    end;
  end;

end;


procedure TSizeGripMemo.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
   deltaX, deltaY: Integer;
begin
  if Parent = nil then Exit;

  deltaX := ALeft - Left;
  deltaY := ATop - Top;

  inherited;
  if (csDesigning in ComponentState) then
  begin
    Exit;
  end;
  if Self.Parent = nil then Exit;
  if not CanMove then  Exit;
end;

procedure TSizeGripMemo.SetDynFontHeight(const Value: Integer);
var
  hFnt : hFont;
  lf : tLogfont;
  cf: TWMChooseFont_GetLogFont;
begin
  FDynFontHeight := Value;
  GetObject(Font.Handle, sizeof(lf), @lf);
  lf.lfHeight := floor(FDynFontHeight * FScale);
  hFnt := CreateFontIndirect(lf);
  Font.Handle := hFnt;
end;

procedure TSizeGripMemo.SetDynVisible(const Value: Boolean);
var
  BinMemos: TPanel;
begin
  FDynVisible := Value;
  if owner is TDynWinPanel then
  begin
    TDynWinPanel(owner).MemoToBin(Self, not Value);
  end
  else
  if (Owner is TPanel) and (Owner.Name = 'BinMemos') then
  begin
    BinMemos := TPanel(owner);
    TDynWinPanel(BinMemos.Parent).MemoToBin(Self, Value);
  end;
end;

procedure TSizeGripMemo.SetEditRect;
var
  Loc: TRect;
begin
  SetRect(Loc, 0, 0, ClientWidth, ClientHeight);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TSizeGripMemo.SetParent(AParent: TWinControl);
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
    if not (AParent is TDynWinPanel) then
    begin
      if not Self.WordWrap then
      begin
        Self.WordWrap := True;
      end;
      //TDynWinPanel(AParent).AddDynEdt(self);
    end;
  end;
end;

procedure TSizeGripMemo.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TSizeGripMemo.WMASetFocus(var Msg: TWMSetFocus);
begin
  //if Msg.FocusedWnd <> Self.Handle then
//  begin
//    inherited;
//    Exit;
//  end;
  inherited;
  Exit;
  if Parent is TDynWinPanel then
  begin
    if (TDynWinPanel(Parent).FFocusedMemo <> nil) and (TDynWinPanel(Parent).FFocusedMemo.mmoInplace <> self) then
    begin
      TDynWinPanel(Parent).FFocusedMemo.mmoInplace.DynVisible := False;
      TDynWinPanel(Parent).FFocusedMemo := nil;
    end
    else
      TDynWinPanel(Parent).FFocusedMemo := TDynMemo(FDynMemo);


    if TDynWinPanel(Parent).FFocusedEdit <> nil then
    begin
      TDynWinPanel(Parent).FFocusedEdit.edtInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedEdit := nil;
    end;
    if TDynWinPanel(Parent).FFocusedDatTim <> nil then
    begin
      TDynWinPanel(Parent).FFocusedDatTim.DatTimInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedDatTim := nil;
    end;
    if TDynWinPanel(Parent).FFocusedChk <> nil then
    begin
      TDynWinPanel(Parent).FFocusedChk.chkInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedChk := nil;
    end;
  end;
  inherited;
  if Parent is TDynWinPanel then
  begin
    if TDynWinPanel(Parent).CalculatedMemo <> self then
    begin
      TDynWinPanel(Parent).NestedGroup(self);
      TDynWinPanel(Parent).CalculatedMemo := self;
    end;
    //TDynWinPanel(Parent).ClearDependList;
  end;
end;



procedure TSizeGripMemo.WMMouseWheel(var MSG: TWMMouseWheel);
var
  Info: TScrollInfo;
begin
  Info.cbSize := SizeOf(Info);
  Info.fMask := SIF_POS or SIF_RANGE or SIF_PAGE;
  Win32Check(GetScrollInfo(Handle, SB_VERT, Info));
  //Result := Info.nPos >=  Info.nMax - Info.nMin - Info.nPage;

  if ((info.nPos + info.nPage) <= info.nMax) then //
  begin
    inherited;
  end
  else
  begin
    if Parent is TDynWinPanel then
    begin
      (TDynWinPanel(Parent).Perform(WM_MOUSEWHEEL, TMessage(MSG).wparam, TMessage(Msg).lparam));
    end;
  end;
end;

procedure TSizeGripMemo.WMMove(var Msg: TWMMove);
begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);
  end;
end;

procedure TSizeGripMemo.WMNCHitTest(var Msg: TWMNCHitTest);
var
  ScreenPt: TPoint;
  MoveArea: TRect;
  HANDLE_WIDTH: Integer;
  SIZEGRIP: Integer;

begin
  inherited ;


  HANDLE_WIDTH := 2;
  Sizegrip := 19;
  inherited;
  Exit;
  if not (csDesigning in  ComponentState) then
  begin
    ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
    MoveArea := Rect(
      HANDLE_WIDTH,
      HANDLE_WIDTH,
      Width - HANDLE_WIDTH,
      Height - HANDLE_WIDTH
    );

    if (GetKeyState(VK_CONTROL) >= 0 ) then
    begin

      if (ScreenPt.x >= Width - Sizegrip) and
        (ScreenPt.y >= Height - Sizegrip) then
        begin
          Msg.Result := HTBOTTOMRIGHT;
        end;
    end;

  end;
end;

procedure TSizeGripMemo.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

procedure TSizeGripMemo.WMSizing(var Msg: TMessage);
var
  mmo: TDynMemo;
  r: TRect;
begin
  inherited;

  if not (csDesigning in  ComponentState) then
  begin
    case Msg.wParam of
       WMSZ_BOTTOMRIGHT:
       begin
          r := PRect(Msg.LParam)^;
          if (FDynMemo <> nil) then
          begin
            mmo := TDynMemo(FDynMemo);
            mmo.FDynPanel.FResizedetMemo := mmo;
            //mmo.CalcGroupBox;
            mmo.CalcForMove;
            if owner is TDynWinPanel then
            begin
              if TDynWinPanel(owner).CalculatedMemo <> self then
              begin
                //TDynWinPanel(Parent).NestedGroup(self);
                TDynWinPanel(owner).NestedGroup(self);
                TDynWinPanel(owner).CalculatedMemo := self;
              end;
            end;
            mmo.FRect.Height:= Round(r.Height / scale);;
            //mmo.StretchGroupBoxHeight(r.Height);
            mmo.StretchGroupBoxHeight(r.Height);
            mmo.MoveForMove(1);
            mmo.FDynPanel.Redraw;
          end;

       end;

    end;
  end;
end;

end.
