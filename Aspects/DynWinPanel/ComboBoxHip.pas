unit ComboBoxHip; // visible

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Graphics, Winapi.Messages,
  Winapi.Windows, System.Math, Vcl.Buttons,Vcl.ExtCtrls, Vcl.GraphUtil, Vcl.Forms,
  VirtualTrees, VirtualStringTreeHipp, Vcl.Dialogs,
  System.Generics.Collections, Winapi.Dwmapi, Aspects.Collections;

type
  TOnSelectedItem = procedure(senedr: TObject; index: Integer) of object;
  TDrawItemEventHip = procedure(Canvas: Tcanvas; Index: Integer;
    Rect: TRect; State: TOwnerDrawState) of object;

  TFilterValues = record
    value: string;
    count: Integer;
    obj: TObject;
    lstGroup: TList<TBaseItem>;
  end;
  TFilterList = TList<TFilterValues>;

  TComboBoxAspects = class;
  TStyleBox = (sbDropDown, sbList);


  TListVTR = class (TWinControl)
  private
    FPanelDown: TPanel;


    FOnGetText: TVSTGetTextEvent;
    FItemIndex: Integer;
    FOnSelectedItem: TOnSelectedItem;
    FSearchText: string;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    //procedure WMNCMouseMove(var MSG: TWMNCMouseMove); message WM_NCMOUSEMOVE;

    procedure SetOnGetText(const Value: TVSTGetTextEvent);
    procedure SetSearchText(const Value: string);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Resize; override;

    procedure vtrFilterGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
         Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrFilterDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure IterateFInd(Sender: TBaseVirtualTree; Node: PVirtualNode;
          AData: Pointer; var Abort: Boolean);
  public
    vtrList: TVirtualStringTreeHipp;
    FCombo: TComboBoxAspects;
    FFilterList: TFilterList;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure FillFilterList;
    procedure SetPos(X, Y: Integer);
  published
    property OnGetText: TVSTGetTextEvent read FOnGetText write SetOnGetText;
    property OnSelectedItem: TOnSelectedItem read FOnSelectedItem write FOnSelectedItem;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property SearchText: string read FSearchText write SetSearchText;

  end;

  TListBoxAspect = class(TCustomListBox)
  private
    FMouseInControl: Boolean;
    FOnSelectedItem: TOnSelectedItem;
    FOnDrawItem: TDrawItemEventHip;
    function AdjustHeight(AHeight: Integer): Integer;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;

    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure SetHideEx(const Value: Boolean);
  protected

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure DrawItem(index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyPress(var Key: Char); override;
    procedure WndProc(var Message: TMessage); override;
  public
    FCombo: TComboBoxAspects;
    constructor Create(AOwner: TComponent); override;
    procedure SetPos(X, Y: Integer);
    property HideEx: Boolean write SetHideEx;
  published
    property OnSelectedItem: TOnSelectedItem read FOnSelectedItem write FOnSelectedItem;
    property OnDrawItem: TDrawItemEventHip read FOnDrawItem write FOnDrawItem;
    property ItemHeight;
    property Style;

  end;

  TComboBoxAspects = class(TCustomButtonedEdit)
  private
    Box: TSpeedButton;

    FOnLeaveList: TNotifyEvent;
    FOnExpandList: TNotifyEvent;
    FItemIndex: Integer;
    FStyleBox: TStyleBox;
    FWidthList: Integer;
    FHeightList: Integer;

    procedure BoxClick(Sender: TObject);
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure SetEditRect;
    procedure SetBounds(Left, Top, Width, Height: Integer); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function GetBoxGlyph: Vcl.Graphics.TBITMAP;
    function GetBoxWidth: Integer;
    procedure SetBoxGlyph(const Value: Vcl.Graphics.TBITMAP);
    procedure SetBoxWidth(const Value: Integer);
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure setStyleBox(const Value: TStyleBox);
  protected
    procedure KeyPress(var Key: Char); override;
    procedure WndProc(var Message: TMessage); override;
    procedure DrawChevron1(ACanvas: TCanvas; Direction: TScrollDirection;
        Location: TPoint; Size: Integer);
    procedure Resize; override;
  public
    //List: TListBoxAspect;
    List: TListVTR;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OnSelectedItem(senedr: TObject; index: Integer); virtual;
    procedure Expand(AIndex: Integer);
    procedure Collaps(AIndex: Integer);
  published
    property Font;
    property Text;
    //property BoxWidth: Integer read GetBoxWidth write SetBoxWidth;
    //property BoxGlyph: Vcl.Graphics.TBITMAP read GetBoxGlyph write SetBoxGlyph;
    property Enabled;
    property Color;
    property ReadOnly;
    property ShowHint;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property RightButton;
    property Images;
    property OnLeaveList: TNotifyEvent read FOnLeaveList write FOnLeaveList;
    property OnExpandList: TNotifyEvent read FOnExpandList write FOnExpandList;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property StyleBox: TStyleBox read FStyleBox write setStyleBox;
    property WidthList: Integer read FWidthList write FWidthList;
    property HeightList: Integer read FHeightList write FHeightList;
  end;

procedure Register;
const
  ArrowPts: array[TScrollDirection, 0..2] of TPoint =
    (((X:1; Y:0), (X:0; Y:1), (X:1; Y:2)),
     ((X:0; Y:0), (X:1; Y:1), (X:0; Y:2)),
     ((X:0; Y:1), (X:1; Y:0), (X:2; Y:1)),
     ((X:0; Y:0), (X:1; Y:1), (X:2; Y:0)));

implementation
type
  PNodeRec = ^TNodeRec;
  TNodeRec = record
    index: Integer;
    vid: Integer;
  end;

procedure Register;
begin
  RegisterComponents('Biser', [TComboBoxAspects]);
  RegisterComponents('Biser', [TListVTR]);
end;

function CheckWinXP: Boolean;
begin
  Result := (Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1));
end;

{ TComboBoxHip }

procedure TComboBoxAspects.BoxClick(Sender: TObject);
var
  CP, SP: TPoint;
begin
  Expand(-1);
  //if not List.Visible then
//  begin
//    if Assigned(FOnExpandList) then
//      FOnExpandList(Self);
//    CP.X := -3;
//    CP.Y := Height;
//    SP := ClientToScreen(CP);
//    List.SetPos(SP.X, SP.Y);
//    List.Width := Self.Width;
//    Self.SetFocus;
//  end;
//
//  List.Visible := not List.Visible;
//
//  ItemIndex := -1;
end; { BoxClick }

procedure TComboBoxAspects.Collaps(AIndex: Integer);
var
  CP, SP: TPoint;
begin
  //if not List.Visible then
//  begin
//    if Assigned(FOnExpandList) then
//      FOnExpandList(Self);
//    CP.X := -3;
//    CP.Y := Height;
//    SP := ClientToScreen(CP);
//    List.SetPos(SP.X, SP.Y);
//    List.Width := Self.Width;
//    Self.SetFocus;
//  end;

  List.Visible := false;
  List.ItemIndex := AIndex;
end;

constructor TComboBoxAspects.Create(AOwner: TComponent);
var
  canvas: TControlCanvas;
begin
  inherited Create(AOwner);
  Width := 141;
  Height := 21;
  TabOrder := 0;
  WidthList := 141;
  HeightList := 210;
  Box := TSpeedButton.Create(Self);
  Box.Parent := self;
  Box.BringToFront;
  Box.Visible := true;
  DoubleBuffered := True;


  if not(csDesigning in ComponentState) then
  begin
    List := TListVTR.Create(Self);
    List.FCombo := Self;
    List.Parent := Self;
    List.Left := -32000;
    List.Visible := False;
    if not(csDesigning in ComponentState) then
    begin
      //List.Style := TListBoxStyle.lbVirtual;
      // List.Style := lbVirtualOwnerDraw;
      // List.Count := 200000;
    end;
    List.OnSelectedItem := OnSelectedItem;
    ItemIndex := -1;
  end;
end;

//
procedure TComboBoxAspects.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style  or WS_CLIPCHILDREN;
end;

procedure TComboBoxAspects.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);

  Box.Left := Width - Height;
  Box.Top := 0;
  if FStyleBox = sbDropDown then
  begin
    Box.Left := Self.Width - Self.Height;
    Box.Width := Height - 4;
    Box.Height := Height - 4;
  end
  else
  begin
    Box.Left := 0;
    Box.Width := Width ;
    Box.Height := Height;
  end;
  Box.Cursor := crArrow;
  Box.OnClick := BoxClick;


  // list.FCombo := Self;
  // list.Parent := Self;
  // list.Height := 97;

  // List.Left := 0;
  // List.Top := 0;
  // List.Width := 0;
  // List.Visible := False;

end;

procedure TComboBoxAspects.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

destructor TComboBoxAspects.Destroy;
begin

  inherited Destroy;
end;

procedure TComboBoxAspects.DrawChevron1(ACanvas: TCanvas; Direction: TScrollDirection; Location: TPoint; Size: Integer);
procedure DrawLine;
  var
    I: Integer;
    Pts: array[0..2] of TPoint;
  begin
    // Scale to the correct size
    for I := 0 to 2 do
      Pts[I] := Point(ArrowPts[Direction, I].X * Size + Location.X,
                      ArrowPts[Direction, I].Y * Size + Location.Y);
    case Direction of
      Vcl.GraphUtil.sdDown : Pts[2] := Point(Pts[2].X + 1, Pts[2].Y - 1);
      Vcl.GraphUtil.sdRight: Pts[2] := Point(Pts[2].X - 1, Pts[2].Y + 1);
      Vcl.GraphUtil.sdUp,
      Vcl.GraphUtil.sdLeft : Pts[2] := Point(Pts[2].X + 1, Pts[2].Y + 1);
    end;
    ACanvas.PolyLine(Pts);
  end;

var
  OldWidth: Integer;
begin
  if ACanvas = nil then exit;
  OldWidth := ACanvas.Pen.Width;
  ACanvas.Pen.Width := 1;
  case Direction of
    Vcl.GraphUtil.sdLeft, Vcl.GraphUtil.sdRight:
      begin
        Dec(Location.x, Size);
        DrawLine;
        Inc(Location.x);
        DrawLine;
        //Inc(Location.x, 3);
//        DrawLine;
//        Inc(Location.x);
//        DrawLine;
      end;
    Vcl.GraphUtil.sdUp, Vcl.GraphUtil.sdDown:
      begin
        Dec(Location.y, Size);
        DrawLine;
        Inc(Location.y);
        DrawLine;
        //Inc(Location.y, 3);
//        DrawLine;
//        Inc(Location.y);
//        DrawLine;
      end;
  end;
  ACanvas.Pen.Width := OldWidth;
end;

procedure TComboBoxAspects.Expand(AIndex: Integer);
var
  CP, SP: TPoint;
begin
  if not List.Visible then
  begin
    if Assigned(FOnExpandList) then
      FOnExpandList(Self);
    CP.X := -3;
    CP.Y := Height;
    SP := ClientToScreen(CP);
    if SP.Y + List.Height > Screen.Height then
    begin
      CP.X := -3;
      CP.Y := -List.Height - 3;
    end;
    SP := ClientToScreen(CP);
    List.SetPos(SP.X, SP.Y);
    List.Width := Self.WidthList;
    List.Height := Self.HeightList;
    Self.SetFocus;
    //List.FillFilterList;
    List.Visible := true;
    List.ItemIndex := AIndex;
  end
  else
  begin
    List.Visible := False;
  end;


end;

function TComboBoxAspects.GetBoxGlyph: Vcl.Graphics.TBITMAP;
begin
  Result := Box.Glyph;
end;

function TComboBoxAspects.GetBoxWidth: Integer;
begin
  Result := Box.Width;
end;

procedure TComboBoxAspects.KeyPress(var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    Key := #0;
    if List.Visible then
    begin
      if Assigned(List.FOnSelectedItem) then
        List.FOnSelectedItem(Self, List.ItemIndex);
      List.Visible := False;
    end;
  end;
  if ((Key >= 'a') and (Key <= 'z')) or ((Key >= 'а') and (Key <= 'я')) then
    Key := Chr(ord(Key)-32);
end;

procedure TComboBoxAspects.OnSelectedItem(senedr: TObject; index: Integer);
begin
  Text := IntToStr(index);
end;

procedure TComboBoxAspects.Resize;
var
  PList: TPoint;
  PCombo: TPoint;
begin
  inherited;
  if List <> nil then
  begin
    PList := List.ClientToScreen(Point(0, 0));
    PCombo := ClientToScreen(Point(-3, Height));
    List.Top := PCombo.Y;
    List.Left := PCombo.X;
    // List.Visible := False;
  end;


end;

procedure TComboBoxAspects.SetBounds(Left, Top, Width, Height: Integer);
begin
  if Parent <> nil then
  begin
    inherited SetBounds(Left, Top, Width, Height);
    if FStyleBox = sbDropDown then
    begin
      Box.Left := Self.Width - Self.Height;
      Box.Width := Self.Height - 4;
      Box.Height := Self.Height - 4;
    end
    else
    begin
      box.Top := -2;
      Box.Left := -2;
      Box.Width := Self.Width;
      Box.Height := Self.Height;
    end;
    SetEditRect;
  end
  else
    inherited SetBounds(Left, Top, Width, Height);
end;

procedure TComboBoxAspects.SetBoxGlyph(const Value: Vcl.Graphics.TBITMAP);
begin
  Box.Glyph := Value;
end;

procedure TComboBoxAspects.SetBoxWidth(const Value: Integer);
begin
  Box.Width := Value;
  Box.Left := ClientWidth - Box.Width;
  SetEditRect;
end;

procedure TComboBoxAspects.SetEditRect;
var
  Loc: TRect;
begin
  Exit;
  SetRect(Loc, 3, 0, ClientWidth - Box.Width - 2, ClientHeight + 1);
  SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, MakeLong(2, Box.Width+5));
  //SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TComboBoxAspects.setStyleBox(const Value: TStyleBox);
begin
  FStyleBox := Value;
  RecreateWnd;
end;

procedure TComboBoxAspects.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  List.Visible := False;
end;

procedure TComboBoxAspects.WMMouseWheel(var Msg: TWMMouseWheel);
var
  index: Integer;
  p: TPoint;
begin
  inherited;
  //SendMessage(List.vtrList.Handle, Msg.Msg, tmessage(Msg).WParam, tmessage(Msg).LParam);
  if Msg.WheelDelta < 0 then
  begin
    List.vtrList.Perform(WM_VSCROLL,SB_LINEDOWN,0);
  end
  else
  begin
    List.vtrList.Perform(WM_VSCROLL,SB_LINEUP,0);
  end;
  p := List.ScreenToClient(Msg.Pos);
  //index := List.ItemAtPos(p, True);
  if List.vtrList.FocusedNode <> nil then
  begin
    index := List.vtrList.FocusedNode.Index;
  end
  else
  begin
    Exit;
  end;
  if index < 0 then
    Exit;
  //if Self.ItemIndex <> index then
    //List.Selected[index] := True;
end;

procedure TComboBoxAspects.WMPaint(var Message: TWMPaint);
var
  canvas: TControlCanvas;
  r: TRect;
begin
  inherited ;
  //canvas := TControlCanvas.Create;
//  canvas.Control := Self;
//  if FStyleBox = sbList then
//  begin
//    r := Rect( Width - Height, 0, Width, Height);
//  end
//  else
//  begin
//    r := Rect( Width - Height, 2, Width - 2, Height -2);
//  end;
//  DrawChevron1( canvas, Vcl.GraphUtil.sdDown, Point(r.Left + (Height div 2), Height div 2), 4);
//  DrawFrameControl(canvas.Handle, r, DFC_SCROLL, DFCS_SCROLLDOWN);

end;

procedure TComboBoxAspects.WndProc(var Message: TMessage);
var
  PList: TPoint;
  PCombo: TPoint;
begin
  if Message.Msg = 642 then
  begin
    if List <> nil then
    begin
      PList := List.ClientToScreen(Point(0, 0));
      PCombo := ClientToScreen(Point(-3, Height));
      List.Top := PCombo.Y;
      List.Left := PCombo.X;
      // List.Visible := False;
    end;
  end
  else
  if Message.Msg = CM_CANCELMODE then //45060 then
  begin
    if List <> nil then
    begin
      PList := List.ClientToScreen(Point(0, 0));
      PCombo := ClientToScreen(Point(-3, Height));
      List.Top := PCombo.Y;
      List.Left := PCombo.X;
      if (TCMCancelMode(Message).Sender <> list) and
         (TCMCancelMode(Message).Sender <> Box)  and
         (TCMCancelMode(Message).Sender <> List.vtrList) and
         (TCMCancelMode(Message).Sender <> List.FPanelDown)
      then
        List.Visible := False;
    end;
  end
  else
    inherited;

end;

{ TListBoxHip }

function TListBoxAspect.AdjustHeight(AHeight: Integer): Integer;
var
  BorderSize: Integer;
begin
  BorderSize := Height - ClientHeight;
  Result := Max((AHeight - BorderSize) div ItemHeight, 4) * ItemHeight + BorderSize;
end;

function TListBoxAspect.CanResize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
end;

procedure TListBoxAspect.CMMouseEnter(var Message: TMessage);
begin
  FMouseInControl := True;
  // ReleaseCapture;
end;

procedure TListBoxAspect.CMMouseLeave(var Message: TMessage);
begin
  FMouseInControl := False;
  // SetCaptureControl(Self);
end;

constructor TListBoxAspect.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := True;
  // Style := lbVirtualOwnerDraw;
  // Count := 20000;
end;

procedure TListBoxAspect.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := (Params.Style or WS_CHILDWINDOW // or WS_SIZEBOX or WS_MAXIMIZEBOX
    or LBS_NODATA or LBS_OWNERDRAWFIXED) and not(LBS_SORT or LBS_HASSTRINGS);
  Params.ExStyle := WS_EX_TOOLWINDOW or WS_EX_WINDOWEDGE;
  if CheckWinXP then
    Params.WindowClass.Style := CS_DBLCLKS or CS_DROPSHADOW
  else
    Params.WindowClass.Style := CS_DBLCLKS;
end;

procedure TListBoxAspect.CreateWnd;
begin
  inherited;
  Winapi.Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
  // Height := AdjustHeight(Height);
end;

procedure TListBoxAspect.DrawItem(index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Flags: LongInt;
  Data: String;
begin
  if Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(canvas, index, Rect, State);
  end
  else
  begin
    Canvas.FillRect(Rect);
    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
    Data := IntToStr(index);
    DrawText(Canvas.Handle, Data, Length(Data), Rect, Flags);
  end;
end;

procedure TListBoxAspect.KeyPress(var Key: Char);
begin
  inherited;
  if Key = #$1b then
  begin
    ItemIndex := -1;
    Hide;
  end;
end;

procedure TListBoxAspect.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  index: Integer;
begin
  inherited;
  index := ItemAtPos(Point(X, Y), True);
  if index < 0 then
    Exit;
  if Self.ItemIndex <> index then
    Selected[index] := True;
end;

procedure TListBoxAspect.SetHideEx(const Value: Boolean);
begin
  if not MouseInClient then
    Visible := False
end;

procedure TListBoxAspect.SetPos(X, Y: Integer);
begin
  SetWindowPos(Handle, HWND_TOPMOST, X, Y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE);
end;



procedure TListBoxAspect.WMLButtonDown(var Message: TWMLButtonDown);
begin
  // if not MouseInClient then
  // ReleaseCapture;
  // else
  // SendMessage((Owner.owner as TWinControl).Handle, WM_LBUTTONDOWN, 0, 0);
  // SetCaptureControl(TControl(Owner.Owner));
  Visible := False;
  if Assigned(FOnSelectedItem) then
    FOnSelectedItem(Self, ItemIndex);

end;

procedure TListBoxAspect.WMMove(var Msg: TWMMove);
begin
  Resize;
end;

procedure TListBoxAspect.WMVScroll(var Msg: TWMVScroll);
var
  Info: TScrollInfo;
begin
  // do not intervene when themes are disabled
  if True then // ThemeServices.ThemesEnabled then
  begin
    Msg.Result := 0;

    case Msg.ScrollCode of
      SB_THUMBPOSITION:
        Exit; // Nothing to do, thumb is already tracked
      SB_THUMBTRACK:
        begin
          ZeroMemory(@Info, SizeOf(Info));
          Info.cbSize := SizeOf(Info);
          Info.fMask := SIF_POS or SIF_TRACKPOS;
          if GetScrollInfo(Handle, SB_VERT, Info) and (Info.nTrackPos <> Info.nPos) then
            TopIndex := TopIndex + Info.nTrackPos - Info.nPos;
        end;
    else
      inherited;
    end;
  end
  else
    inherited;
end;

procedure TListBoxAspect.WndProc(var Message: TMessage);
begin
  inherited;

end;

{ TListVTR }

constructor TListVTR.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  Self.DoubleBuffered := true;
  FPanelDown := TPanel.Create(self);
  FPanelDown.Height := 30;
  FPanelDown.Parent := Self;
  FPanelDown.Align := alBottom;
  FPanelDown.ParentBackground := False;
  FPanelDown.DoubleBuffered := true;

  //FPanelTop := TPanel.Create(self);
//  FPanelTop.Height := 30;
//  FPanelTop.Parent := Self;
//  FPanelTop.Align := alTop;
//  FPanelTop.ParentBackground := False;
//  FPanelTop.DoubleBuffered := true;




  vtrList := TVirtualStringTreeHipp.Create(Self);
  vtrList.DoubleBuffered := true;

  vtrList.Name := 'vtrList';
  vtrList.Parent := Self;

  vtrList.Align := alClient;
  vtrList.Color := clInfoBk;
  vtrList.DefaultNodeHeight := 25;
  vtrList.EditDelay := 200;
  vtrList.HintMode := hmTooltip;
  vtrList.Indent := 14;
  vtrList.TabOrder := 0;
  with vtrList.Header.Columns.Add do begin
    CaptionAlignment := taCenter;
    Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor,
    coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coAutoSpring];
    Position := 0;
    Text := 'Какво се търси';
    Width := vtrList.Width - 50 -30;
  end;

  with vtrList.Header.Columns.Add do begin
    Alignment := taRightJustify;
    CaptionAlignment := taCenter;
    Color := 15923186;
    Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode,
      coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coAutoSpring];
    Position := 1;
    Text := 'детайли';
    Width := 50;
  end;

  vtrList.ColumnAspect := 0;
  vtrList.ColumnAction := 2;
  vtrList.Header.Height := 19;
  vtrList.Header.AutoSizeIndex := 0;
  vtrList.Header.Options :=  [hoColumnResize, hoDrag, hoShowSortGlyphs, hoAutoSpring, hoAutoResize];
  vtrList.TreeOptions.AutoOptions := [toAutoDropExpand,toAutoScrollOnExpand,toAutoSort,
     toAutoTristateTracking,toAutoDeleteMovedNodes,toAutoChangeScale];
  //vtrList.TreeOptions.MiscOptions := [toAcceptOLEDrop,toCheckSupport,toFullRepaintOnResize,
//      toInitOnSave,toWheelPanning];
  vtrList.TreeOptions.MiscOptions := [toAcceptOLEDrop,toCheckSupport,toFullRepaintOnResize,toInitOnSave,toWheelPanning];
  vtrList.TreeOptions.PaintOptions  := [toPopupMode,toShowButtons,toShowDropmark,toShowHorzGridLines,toShowRoot,
       toShowTreeLines,toShowVertGridLines,toThemeAware,toUseBlendedImages,toGhostedIfUnfocused,toFullVertGridLines];
  vtrList.TreeOptions.SelectionOptions := [toFullRowSelect,toAlwaysSelectNode];
  vtrList.NodeDataSize := SizeOf(TNodeRec);
  vtrList.OnGetText := vtrFilterGetText;
  vtrList.OnDrawText := vtrFilterDrawText;

  FFilterList := TFilterList.Create;

  //vtrList.DefaultText := '';
//  vtrList.BeginUpdate;
//  for i := 0 to 200000 do
//  begin
//    vtrList.AddChild(nil, nil);
//  end;
//  vtrList.EndUpdate;

end;

procedure TListVTR.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.Style := 1140916292;
  //Exit;

  Params.Style := (Params.Style or WS_THICKFRAME );
  Params.ExStyle := WS_EX_TOOLWINDOW or WS_EX_WINDOWEDGE;
  if CheckWinXP then
    Params.WindowClass.Style := CS_DBLCLKS or CS_DROPSHADOW
  else
    Params.WindowClass.Style := CS_DBLCLKS;

end;

procedure TListVTR.CreateWnd;
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    //if Parent is TComboBoxAspects then
    begin
      Winapi.Windows.SetParent(Handle, Parent.Parent.Handle);
      //CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
    end;
    Self.BringToFront;
  end;
end;

destructor TListVTR.destroy;
begin
  FreeAndNil(FPanelDown);
  FreeAndNil(vtrList);
  FreeAndNil(FFilterList);
  inherited;
end;

procedure TListVTR.FillFilterList;
var
  i: Integer;
  data: PNodeRec;
  v: PVirtualNode;
begin
  vtrList.BeginUpdate;
  vtrList.Clear;
  for i := 0 to FFilterList.Count - 1 do
  begin
    v := vtrList.AddChild(nil, nil);
    data := vtrList.GetNodeData(v);
    data.vid := 1;
    data.index := i;
  end;
  vtrList.EndUpdate;
end;

procedure TListVTR.IterateFInd(Sender: TBaseVirtualTree; Node: PVirtualNode;
      AData: Pointer; var Abort: Boolean);
var
  data: PNodeRec;
  text: string;
begin
  if Node = nil then Exit;

  data := Sender.GetNodeData(node);
  case data.vid of
    1://filterList
    begin
      text := FFilterList[data.index].value;
      if text.Contains(FSearchText) then
      begin
        Sender.Selected[Node] := True;
        Sender.FocusedNode := Node;
        Sender.TopNode := Node;
        Abort := True;
      end;
    end;
  end;
end;

procedure TListVTR.Resize;
begin
  inherited;
  vtrList.Header.Columns[0].Width := Width - 50 - 30-10;
end;

procedure TListVTR.SetOnGetText(const Value: TVSTGetTextEvent);
begin
  FOnGetText := Value;
  vtrList.OnGetText := FOnGetText;
end;

procedure TListVTR.SetPos(X, Y: Integer);
begin
  SetWindowPos(Handle, HWND_TOPMOST, X, Y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE);
end;

procedure TListVTR.SetSearchText(const Value: string);
var
  i: Integer;
begin
  FSearchText := Value;
  vtrList.IterateSubtree(nil, IterateFInd, nil);
  vtrList.Repaint;
end;

procedure TListVTR.vtrFilterDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
  const CellRect: TRect; var DefaultDraw: Boolean);
var
  p: Integer;
  strPred, strSled: string;
  r: TRect;
  FilterText: string;
  DrawFormat: cardinal;
begin
  DrawFormat := DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE or DT_LEFT or DT_END_ELLIPSIS;
  FilterText := FSearchText;
  if Text.Contains(FilterText) then
  begin
    p := Text.IndexOf(FilterText);
    SetBkMode(TargetCanvas.Handle,TRANSPARENT);
    strPred := Copy(Text, 1, p);
    strSled := copy(Text, p+length(FilterText) + 1, length(Text) + 1 -   (p+length(FilterText)));
    TargetCanvas.TextWidth(strPred);
    r := CellRect;
    SetTextColor(TargetCanvas.Handle, clBlack);
    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(Text), Length(Text), r, DrawFormat);

    SetTextColor(TargetCanvas.Handle, clRed);
    r.Left := r.Left + TargetCanvas.TextWidth(strPred);
    r.Width := TargetCanvas.TextWidth(FilterText);
    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(FilterText), Length(FilterText), r, DrawFormat);



    SetTextColor(TargetCanvas.Handle, clBlack);
    r.Offset(r.Width, 0);
    r.Width := TargetCanvas.TextWidth(strSled);

    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strSled), Length(strSled), r, DrawFormat);



    DefaultDraw:= False;
  end;
end;

procedure TListVTR.vtrFilterGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PNodeRec;
begin
  if Node = nil then Exit;

  data := Sender.GetNodeData(node);
  case data.vid of
    0://filterList
    begin
      case Column of
        0: CellText := FFilterList[data.index].value;
        1: CellText := IntToStr(FFilterList[data.index].count);
      end;
    end;

  end;
end;

procedure TListVTR.WMNCHitTest(var Msg: TWMNCHitTest);
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
  if not (csDesigning in  ComponentState) then
  begin
    ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
    MoveArea := Rect(
      HANDLE_WIDTH,
      HANDLE_WIDTH,
      Width - HANDLE_WIDTH,
      Height - HANDLE_WIDTH
    );


    if (ScreenPt.x >= Width - Sizegrip) and
        (ScreenPt.y >= Height - Sizegrip) then
    begin
      Msg.Result := HTBOTTOMRIGHT;
    end
    else
      Msg.Result := HTCAPTION;

  end;
end;

//procedure TListVTR.WMNCMouseMove(var Msg: TWMNCMouseMove);
//begin
//  case MSG.HitTest of
//    HTBOTTOMRIGHT:
//    begin
//    ShowMessage('ddd');
//    end;
//  end;
//end;

procedure TListVTR.WndProc(var Message: TMessage);
begin
  inherited;
  //if message.Msg = WM_NCHITTEST then
//  begin
//    ShowMessage('ddd');
//  end;
end;

end.
