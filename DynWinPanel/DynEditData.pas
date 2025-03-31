unit DynEditData;  // visible

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Types, Winapi.Windows, System.Generics.Collections, Vcl.Graphics, Aspects.Types;
type

  TDynFieldType = (dftPregledID, dftAmbListNom, dftPatientEGN);

  TDynEditData = class(TEdit)
  private
    FCanMove: Boolean;
    FDynTop: integer;
    FDynLeft: integer;
    FDynRight: Integer;
    FScale: Double;
    FDynBottom: Integer;
    FDynFontHeight: Integer;
    FDynFieldType: TDynFieldType;
    FlabelCaption: string;
    FCanEdit: Boolean;
    FCanvas: TControlCanvas;
    FOnEnterDYN: TNotifyEvent;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure SetParent(AParent: TWinControl); override;

    function GetBoundsDynRect: TRect;
    procedure SetBoundsDynRect(const Value: TRect);
    procedure SetScale(const Value: Double);
    procedure SetDynFontHeight(const Value: Integer);
    procedure SetDynFieldType(const Value: TDynFieldType);
  protected
    procedure Resize; override;
    procedure Loaded; override;
    procedure Change; override;
    procedure DoEnter; override;
  public
    FDynEdit: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure ControlToDyn(xPos, yPos: Integer);
    property CanMove: Boolean read FCanMove write FCanmove;
    property OnEnterDYN: TNotifyEvent read FOnEnterDYN write FOnEnterDYN;


  published
    property Scale: Double read FScale write SetScale;
    property DynLeft: integer  read FDynLeft write FDynLeft;
    property DynRight: Integer read FDynRight write FDynRight;
    property DynBottom: Integer read FDynBottom write FDynBottom;
    property DynTop: integer  read FDynTop write FDynTop;
    property DynFontHeight: Integer read FDynFontHeight write SetDynFontHeight;
    property BoundsDynRect: TRect read GetBoundsDynRect ;
    property DynFieldType: TDynFieldType read FDynFieldType write SetDynFieldType;
    property labelCaption: string read FlabelCaption write FlabelCaption;
    property CanEdit: Boolean read FCanEdit write FCanEdit;


  end;

procedure Register;

implementation
uses
  DynWinPanel;

procedure Register;
begin
  RegisterComponents('biser', [TDynEditData]);
end;

{ TDynEditData }

procedure TDynEditData.Change;
var
  wText: Integer;
  hFnt : hFont;
  lf : tLogfont;
  DYN: TDynWinPanel;
begin
  inherited;
  if (csDesigning in  ComponentState) then
    Exit;
  if (Parent is TDynWinPanel) and CanEdit then
  begin
    DYN := TDynWinPanel(Parent);
    if Assigned(DYN.OnSetText) then
    begin
      DYN.OnSetText(TDynWinPanel(Parent), TDynEdit(FDynEdit), Self.Text);

      //wText := FCanvas.TextWidth(text);
//      if wText > Self.Width - 6 then
//      begin
//        GetObject(Font.Handle, sizeof(lf), @lf);
//        lf.lfHeight := round(FDynFontHeight * FScale);
//        lf.lfWidth := round((Self.Width - 6) / Length(Text))- 1;
//        hFnt := CreateFontIndirect(lf);
//        Font.Handle := hFnt;
//      end
//      else
//      begin
//        GetObject(Font.Handle, sizeof(lf), @lf);
//        lf.lfHeight := round(FDynFontHeight * FScale);
//        lf.lfWidth := 0;
//        hFnt := CreateFontIndirect(lf);
//        Font.Handle := hFnt;
//      end;
    end;
    if DYN.FilterMode then
    begin
      DYN.lstvtr1.SearchText := Self.Text;
    end;
  end;
end;

procedure TDynEditData.ControlToDyn(xPos, yPos: Integer);
var
  dynedt: TDynEdit;
begin
  if FDynEdit <> nil then
  begin
    dynedt:= TDynEdit(FDynEdit);
    dynedt.FRect.Left := round((XPos + dynedt.FDynPanel.HScrollPos)/dynedt.FDynPanel.scale);
    dynedt.FRect.Top := round((YPos + dynedt.FDynPanel.VScrollPos)/dynedt.FDynPanel.scale);
    dynedt.FRect.Height := round(Self.Height/dynedt.FDynPanel.scale);
    dynedt.FRect.Width := round(Self.Width/dynedt.FDynPanel.scale);
    if dynedt.ColIndex = 0 then
    begin
      dynedt.ColIndex := Self.Tag;
    end;
    FCanMove := False;
    begin
      Self.FDynLeft := dynedt.FRect.Left;
      Self.FDynTop := dynedt.FRect.Top;
      Self.FDynRight := dynedt.FRect.Right;
      Self.FDynBottom := dynedt.FRect.Bottom;
      Text := Format('%d, %d, %d, %d', [FDynLeft, FDynTop, FDynRight, FDynBottom]);
    end;
    FCanMove := true;
  end;
end;

constructor TDynEditData.Create(AOwner: TComponent);
begin
  inherited;
  FDynEdit := nil;
  FCanMove := True;
  FDynFontHeight := 12;
  AutoSize := False;
  CanEdit := True;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
end;



destructor TDynEditData.destroy;
begin
  if FDynEdit <> nil then
    FreeAndNil(FDynEdit);
  FCanvas.Free;
  inherited;
end;

procedure TDynEditData.DoEnter;
begin
  inherited;
  if Assigned(FOnEnterDYN) then
    FOnEnterDYN(FDynEdit);
end;

function TDynEditData.GetBoundsDynRect: TRect;
var
  dynedt: TDynEdit;
begin
  dynedt:= TDynEdit(FDynEdit);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

procedure TDynEditData.Loaded;
begin
  inherited;
  begin
    ControlToDyn(Left, Top);
  end;
end;



procedure TDynEditData.Resize;
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

//procedure TDynEditData.SetAlignment(const Value: TAlignment);
//begin
//  if FAlignment <> Value then
//  begin
//    FAlignment := Value;
//    RecreateWnd;
//  end;
//end;

procedure TDynEditData.SetBoundsDynRect(const Value: TRect);
begin

end;

//procedure TDynEditData.SetDyFont(H: integer);
//var
//  SaveFont: HFont;
//  hFnt : hFont;
//  lf : tLogfont;
//  oldH: Integer;
//  cf: TWMChooseFont_GetLogFont;
//begin
//  GetObject(Font.Handle, sizeof(lf), @lf);
//  lf.lfHeight := round(H * FScale);
//  hFnt := CreateFontIndirect(lf);
//  Font.Handle := hFnt;
//end;

procedure TDynEditData.SetDynFieldType(const Value: TDynFieldType);
begin
  FDynFieldType := Value;
  //if (csDesigning in ComponentState) then //  само по време на дизайна, се променя размера. Иначе се променя, ама е следствие на нещо друго
  begin
    if (Parent is TDynWinPanel) and (FDynEdit <> nil) then
    begin
      TDynEdit(FDynEdit).FieldType := FDynFieldType;
    end;
  end;

end;

procedure TDynEditData.SetDynFontHeight(const Value: Integer);
var
  hFnt : hFont;
  lf : tLogfont;
  //oldH: Integer;
  //cf: TWMChooseFont_GetLogFont;
begin
  FDynFontHeight := Value;
  GetObject(Font.Handle, sizeof(lf), @lf);
  lf.lfHeight := round(FDynFontHeight * FScale);
  //lf.lfWidth := 5;
  hFnt := CreateFontIndirect(lf);
  Font.Handle := hFnt;
  FCanvas.Font.Assign(font);

end;

procedure TDynEditData.SetParent(AParent: TWinControl);
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

procedure TDynEditData.SetScale(const Value: Double);
begin
  FScale := Value;
  SetDynFontHeight(FDynFontHeight);
end;

procedure TDynEditData.WMASetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if Parent is TDynWinPanel then
  begin
    if (TDynWinPanel(Parent).FFocusedEdit <> nil) and (TDynWinPanel(Parent).FFocusedEdit.edtInplace <> self) then
    begin
      TDynWinPanel(Parent).FFocusedEdit.edtInplace.Visible := False;
    end
    else
      TDynWinPanel(Parent).FFocusedEdit := TDynEdit(FDynEdit);

    if TDynWinPanel(Parent).FFocusedDatTim <> nil then
    begin
      TDynWinPanel(Parent).FFocusedDatTim.DatTimInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedDatTim := nil;
    end;

    if TDynWinPanel(Parent).FFocusedMemo <> nil then
    begin
      TDynWinPanel(Parent).FFocusedMemo.mmoInplace.DynVisible := False;
      TDynWinPanel(Parent).FFocusedMemo := nil;
    end;
  end;

end;

procedure TDynEditData.WMKillFocus(var msg: TWMKillFocus);
begin
  if Parent is TDynWinPanel then
  begin
    TDynWinPanel(Parent).HideFilterList(FindControl(msg.FocusedWnd));
  end;
  inherited;
end;

procedure TDynEditData.WMMove(var Msg: TWMMove);
begin
  if not CanMove then  Exit;
  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);
  end;
end;


end.
