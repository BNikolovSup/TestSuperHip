unit DynButtonData;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Types, Winapi.Windows, System.Generics.Collections, Vcl.Graphics, Vcl.Buttons;

type
  TDynButtonData = class(TWinControl)
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
    btn: TSpeedButton;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure SetParent(AParent: TWinControl); override;

    function GetBoundsDynRect: TRect;
    procedure SetBoundsDynRect(const Value: TRect);
    procedure SetScale(const Value: Double);
    procedure SetDynFontHeight(const Value: Integer);
  protected
    procedure Resize; override;
    procedure Loaded; override;
  public
    FDynButton: TObject;
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
  RegisterComponents('biser', [TDynButtonData]);
end;

{ TDynButtonData }

procedure TDynButtonData.ControlToDyn(xPos, yPos: Integer);
var
  dynbtn: TDynButton;
begin
  if FDynButton <> nil then
  begin
    dynbtn:= TDynButton(FDynButton);
    dynbtn.FRect.Left := round((XPos + dynbtn.FDynPanel.HScrollPos)/dynbtn.FDynPanel.scale);
    dynbtn.FRect.Top := round((YPos + dynbtn.FDynPanel.VScrollPos)/dynbtn.FDynPanel.scale);
    dynbtn.FRect.Height := round(Self.Height/dynbtn.FDynPanel.scale);
    dynbtn.FRect.Width := round(Self.Width/dynbtn.FDynPanel.scale);
    if dynbtn.ColIndex = 0 then
    begin
      dynbtn.ColIndex := Self.Tag;
    end;
    FCanMove := False;
    begin
      Self.FDynLeft := dynbtn.FRect.Left;
      Self.FDynTop := dynbtn.FRect.Top;
      Self.FDynRight := dynbtn.FRect.Right;
      Self.FDynBottom := dynbtn.FRect.Bottom;
      //Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;
  end;
end;

constructor TDynButtonData.Create(AOwner: TComponent);
begin
  inherited;
  Width := 100;
  Height := 30;
  btn := TSpeedButton.Create(self);
  btn.Align :=  alClient;
  btn.Caption := 'ddd';
  btn.Parent := Self;
  btn.GroupIndex := 1;
  btn.AllowAllUp := True;
  btn.Down := True;

  FDynButton := nil;
  FCanMove := True;
  FDynFontHeight := 12;
  AutoSize := False;
  CanEdit := True;
end;

destructor TDynButtonData.destroy;
begin
  if FDynButton <> nil then
    FreeAndNil(FDynButton);
  inherited;
end;

function TDynButtonData.GetBoundsDynRect: TRect;
var
  dynbtn: TDynButton;
begin
  dynbtn:= TDynButton(FDynButton);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

procedure TDynButtonData.Loaded;
begin
  inherited;
  begin
    ControlToDyn(Left, Top);
  end;
end;

procedure TDynButtonData.Resize;
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

procedure TDynButtonData.SetBoundsDynRect(const Value: TRect);
begin

end;

procedure TDynButtonData.SetDynFontHeight(const Value: Integer);
var
  hFnt : hFont;
  lf : tLogfont;
  oldH: Integer;
  cf: TWMChooseFont_GetLogFont;
begin
  FDynFontHeight := Value;
  GetObject(Font.Handle, sizeof(lf), @lf);
  lf.lfHeight := round(FDynFontHeight * FScale);
  //lf.lfWidth := 5;
  hFnt := CreateFontIndirect(lf);
  Font.Handle := hFnt;
end;

procedure TDynButtonData.SetParent(AParent: TWinControl);
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

procedure TDynButtonData.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TDynButtonData.WMASetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;

procedure TDynButtonData.WMMove(var Msg: TWMMove);
begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);
  end;
end;

end.
