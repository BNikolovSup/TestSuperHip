unit DynDateTimePicker;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Types, Winapi.Windows, System.Generics.Collections, Vcl.Graphics, Vcl.ComCtrls;

type
  TDynDateTimePicker = class(TDateTimePicker)
  private
    FCanMove: Boolean;
    FDynTop: integer;
    FDynLeft: integer;
    FDynRight: Integer;
    FScale: Double;
    FDynBottom: Integer;
    FDynFontHeight: Integer;
    FlabelCaption: string;
    FCanEdit: Boolean;
    FCanvas: TControlCanvas;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure SetParent(AParent: TWinControl); override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    function GetBoundsDynRect: TRect;
    procedure SetBoundsDynRect(const Value: TRect);
    procedure SetScale(const Value: Double);
    procedure SetDynFontHeight(const Value: Integer);
  protected
    procedure Resize; override;
    procedure Loaded; override;
    procedure Change; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure AdjustHeight;
  public
    FDynDatTim: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure ControlToDyn(xPos, yPos: Integer);
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
    property CanEdit: Boolean read FCanEdit write FCanEdit;
  end;

procedure Register;

implementation
uses
  DynWinPanel;

procedure Register;
begin
  RegisterComponents('Biser', [TDynDateTimePicker]);
end;

{ TDynDateTimePicker }

procedure TDynDateTimePicker.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  Height := Metrics.tmHeight + (GetSystemMetrics(SM_CYBORDER) * 8);
end;

procedure TDynDateTimePicker.Change;
begin
  inherited;
  if (csDesigning in  ComponentState) then
    Exit;
  if (Parent is TDynWinPanel) and CanEdit then
  begin
    if Assigned(TDynWinPanel(Parent).OnSetText) then
    begin
      TDynWinPanel(Parent).OnSetText(TDynWinPanel(Parent), TDynDatTime(FDynDatTim), Self.Text);
    end;
  end;
end;

procedure TDynDateTimePicker.CMFontChanged(var Message: TMessage);
var
  r: TRect;
begin
  //CanMove := False;
  inherited;
  //CanMove := True;
end;

procedure TDynDateTimePicker.ControlToDyn(xPos, yPos: Integer);
var
  dynDatTim: TDynDatTime;
begin
  if FDynDatTim <> nil then
  begin
    dynDatTim:= TDynDatTime(FDynDatTim);
    dynDatTim.FRect.Left := round((XPos + dynDatTim.FDynPanel.HScrollPos)/dynDatTim.FDynPanel.scale);
    dynDatTim.FRect.Top := round((YPos + dynDatTim.FDynPanel.VScrollPos)/dynDatTim.FDynPanel.scale);
    dynDatTim.FRect.Height := round(Self.Height/dynDatTim.FDynPanel.scale);
    dynDatTim.FRect.Width := round(Self.Width/dynDatTim.FDynPanel.scale);
    if dynDatTim.ColIndex = 0 then
    begin
      dynDatTim.ColIndex := Self.Tag;
    end;
    FCanMove := False;
    begin
      Self.FDynLeft := dynDatTim.FRect.Left;
      Self.FDynTop := dynDatTim.FRect.Top;
      Self.FDynRight := dynDatTim.FRect.Right;
      Self.FDynBottom := dynDatTim.FRect.Bottom;
    end;
    FCanMove := true;
  end;
end;

constructor TDynDateTimePicker.Create(AOwner: TComponent);
begin
  inherited;
  FDynDatTim := nil;
  FCanMove := True;
  FDynFontHeight := 12;
  CanEdit := True;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;

end;

destructor TDynDateTimePicker.destroy;
begin
  if FDynDatTim <> nil then
    FreeAndNil(FDynDatTim);
  FCanvas.Free;
  inherited;
end;

function TDynDateTimePicker.GetBoundsDynRect: TRect;
var
  dynDatTim: TDynDatTime;
begin
  dynDatTim:= TDynDatTime(FDynDatTim);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

procedure TDynDateTimePicker.Loaded;
begin
  inherited;
  begin
    ControlToDyn(Left, Top);
  end;
end;

procedure TDynDateTimePicker.Resize;
begin
  inherited;
  if (csDesigning in ComponentState) then //  само по време на дизайна, се променя размера. Иначе се променя, ама е следствие на нещо друго
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

procedure TDynDateTimePicker.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (csDesigning in ComponentState) then
  begin
      inherited;
  end
  else
  begin
    if CanMove then
      inherited;
  end;
end;

procedure TDynDateTimePicker.SetBoundsDynRect(const Value: TRect);
begin

end;

procedure TDynDateTimePicker.SetDynFontHeight(const Value: Integer);
var
  hFnt : hFont;
  lf : tLogfont;
begin
  FDynFontHeight := Value;
  GetObject(Font.Handle, sizeof(lf), @lf);
  lf.lfHeight := round(FDynFontHeight * FScale);
  hFnt := CreateFontIndirect(lf);
  Font.Handle := hFnt;
  FCanvas.Font.Assign(font);
end;

procedure TDynDateTimePicker.SetParent(AParent: TWinControl);
begin
  inherited;
  if (csDesigning in ComponentState)then
  begin
    if AParent is TDynWinPanel then
    begin
      ControlToDyn(left, top);
      Format := 'dd.MM.yyyy HH:mm';
      DateTime := Now;
    end;
  end
  else
  begin
    if AParent is TDynWinPanel then
    begin
      //TDynWinPanel(AParent).AddDynEdt(self);
      Format := 'dd.MM.yyyy HH:mm';
      DateTime := Now;
    end;
  end;
end;

procedure TDynDateTimePicker.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TDynDateTimePicker.WMASetFocus(var Msg: TWMSetFocus);
begin
  if Parent is TDynWinPanel then
  begin
    if (TDynWinPanel(Parent).FFocusedDatTim <> nil) and (TDynWinPanel(Parent).FFocusedDatTim.DatTimInplace <> self) then
    begin
      TDynWinPanel(Parent).FFocusedDatTim.DatTimInplace.Visible := False;
    end
    else
      TDynWinPanel(Parent).FFocusedDatTim := TDynDatTime(FDynDatTim);

    if TDynWinPanel(Parent).FFocusedEdit <> nil then  //FFocusedDatTim
    begin
      TDynWinPanel(Parent).FFocusedEdit.edtInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedEdit := nil;
    end;
    if TDynWinPanel(Parent).FFocusedChk <> nil then
    begin
      TDynWinPanel(Parent).FFocusedChk.chkInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedChk := nil;
    end;
  end;
end;

procedure TDynDateTimePicker.WMMove(var Msg: TWMMove);
begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);
  end;
end;

end.
