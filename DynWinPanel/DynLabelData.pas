unit DynLabelData;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Types, Winapi.Windows, System.Generics.Collections, system.Math;

type
  TDynLabelData = class(TLabel)
  private
    FCanMove: Boolean;
    FDynTop: integer;
    FDynLeft: integer;
    FDynRight: Integer;
    FScale: Double;
    FDynBottom: Integer;
    FDynFontHeight: Integer;
    FlabelCaption: string;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    function GetBoundsDynRect: TRect;
    procedure SetBoundsDynRect(const Value: TRect);
    procedure SetScale(const Value: Double);
    procedure SetDynFontHeight(const Value: Integer);
  protected
    procedure Resize; override;
    procedure Loaded; override;
    procedure AdjustBounds; override;

  public
    FDynLabel: TObject;
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
  end;

procedure Register;

implementation

uses
  DynWinPanel;

procedure Register;
begin
  RegisterComponents('biser', [TDynLabelData]);
end;

{ TDynLabelData }

procedure TDynLabelData.AdjustBounds;
begin
  //inherited;

end;

procedure TDynLabelData.ControlToDyn(xPos, yPos: Integer);
var
  dynlbl: TDynLabel;
begin
  if FDynLabel <> nil then
  begin
    dynlbl:= TDynLabel(FDynLabel);
    dynlbl.FRect.Left := round((XPos + dynlbl.FDynPanel.HScrollPos)/dynlbl.FDynPanel.scale);
    dynlbl.FRect.Top := round((YPos + dynlbl.FDynPanel.VScrollPos)/dynlbl.FDynPanel.scale);
    dynlbl.FRect.Height := round(Self.Height/dynlbl.FDynPanel.scale);
    dynlbl.FRect.Width := round(Self.Width/dynlbl.FDynPanel.scale);
    dynlbl.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynlbl.FRect.Left;
      Self.FDynTop := dynlbl.FRect.Top;
      Self.FDynRight := dynlbl.FRect.Right;
      Self.FDynBottom := dynlbl.FRect.Bottom;
      //Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;
  end;
end;

constructor TDynLabelData.Create(AOwner: TComponent);
begin
  FCanMove := False;
  inherited;
  FDynLabel := nil;
  FCanMove := True;
  FDynFontHeight := 12;
  AutoSize := False;
end;

destructor TDynLabelData.destroy;
begin
  if FDynLabel <> nil then
    FreeAndNil(FDynLabel);
  inherited;
end;

function TDynLabelData.GetBoundsDynRect: TRect;
var
  dynedt: TDynLabel;
begin
  dynedt:= TDynLabel(FDynLabel);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

procedure TDynLabelData.Loaded;
begin
  inherited;
  //if not (csDesigning in ComponentState) then
  begin
    ControlToDyn(Left, Top);
  end;
end;

procedure TDynLabelData.Resize;
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

procedure TDynLabelData.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
    inherited;
end;

procedure TDynLabelData.SetBoundsDynRect(const Value: TRect);
begin

end;

procedure TDynLabelData.SetDynFontHeight(const Value: Integer);
var
  hFnt : hFont;
  lf : tLogfont;
  oldH: Integer;
  cf: TWMChooseFont_GetLogFont;
begin
  FDynFontHeight := Value;
  GetObject(Font.Handle, sizeof(lf), @lf);
  lf.lfHeight := floor(FDynFontHeight * FScale);
  hFnt := CreateFontIndirect(lf);
  Font.Handle := hFnt;


end;

procedure TDynLabelData.SetParent(AParent: TWinControl);
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
      //TDynWinPanel(AParent).AddDynEdt(self);
    end;
  end;
end;

procedure TDynLabelData.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TDynLabelData.WMASetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;

procedure TDynLabelData.WMMove(var Msg: TWMMove);
begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);
  end;
end;

end.
