unit DBCheckBoxResize;

interface

uses
  Windows, Messages, SysUtils, Classes, DBCtrls, Graphics, Controls, DB, vcl.Dialogs;
type
  TCheckedEvent = procedure(Sender: TObject; Checked: Boolean) of object;
type
  TDbCheckBoxResizeWin =  class;

  TDBCheckBoxResize = class(TDBText)
  private
    FCompWin: TDbCheckBoxResizeWin;
    FOwnerDraw: Boolean;
    FChecked: Boolean;
    FValueChecked: string;
    FValueUnChecked: string;
    FColorCheckMark: TColor;
    FColorBk: TColor;
    FColorFrame: TColor;
    FOnOfCheck: TCheckedEvent;
    FReadOnly: Boolean;
    FInvertNull: Boolean;
    procedure SetChecked(const Value: Boolean);
    procedure SetColorBk(const Value: TColor);
    procedure SetColorCheckMark(const Value: TColor);
    procedure SetColorFrame(const Value: TColor);
    procedure SetOwnerDraw(const Value: Boolean);
    procedure SetValueChecked(const Value: string);
    procedure SetValueUnChecked(const Value: string);
    
    { Private declarations }
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure DrawCheckBox(Checked: Boolean);
    procedure Click; override;
    procedure DblClick; override;
    procedure DoClick;
  public
    { Public declarations }
    constructor create(AOwner: TComponent); override;
    function GetChecked: Boolean;
  published
    { Published declarations }
    property ValueChecked: string read FValueChecked write SetValueChecked ;
    property ValueUnChecked: string read FValueUnChecked write SetValueUnChecked ;
    property ColorFrame: TColor read FColorFrame write SetColorFrame;
    property ColorCheckMark: TColor read FColorCheckMark write SetColorCheckMark;
    property ColorBk: TColor read FColorBk write SetColorBk;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw;
    property Checked: Boolean read FChecked write SetChecked;
    property OnOfCheck: TCheckedEvent read FOnOfCheck write FOnOfCheck;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property InvertNull: Boolean read FInvertNull write FInvertNull;
    
  end;

  TDbCheckBoxResizeWin =  class(TWinControl)
  private
    FCheckBoxRes: TDBCheckBoxResize;
    FDataSource: TDataSource;
    FDataField: String;
    FValueChecked: string;
    FValueUnChecked: string;
    FColorFrame: TColor;
    FChecked: Boolean;
    FOwnerDraw: Boolean;
    FColorBk: TColor;
    FColorCheckMark: TColor;
    FOnOfCheck: TCheckedEvent;
    FReadOnly: Boolean;
    FinvertNull: boolean;
    tempBkColor: TColor;
    FDynRight: Integer;
    FDynFontHeight: Integer;
    FDynBottom: Integer;
    FDynTop: integer;
    FDynLeft: integer;
    FScale: Double;
    FCanMove: Boolean;
    FVisible: Boolean;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetDataField(const Value: string);
    procedure SetColorFrame(const Value: TColor);
    procedure SetValueChecked(const Value: string);
    procedure SetValueUnChecked(const Value: string);
    procedure SetChecked(const Value: Boolean);
    procedure SetColorBk(const Value: TColor);
    procedure SetColorCheckMark(const Value: TColor);
    procedure SetOwnerDraw(const Value: Boolean);
    procedure OfCheck(Sender: TObject; IsChecked: Boolean);
    function GetChecked: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure SetInvertNull(const Value: boolean);
    function GetBoundsDynRect: TRect;
    procedure SetDynFontHeight(const Value: Integer);
    procedure SetScale(const Value: Double);
    //procedure SetVisible(const Value: Boolean);
  protected
    procedure SetEnabled(Value: Boolean); override;

    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMASetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure Resize; override;
    procedure Loaded; override;
    procedure SetParent(AParent: TWinControl); override;
  public
    FDynCheck: TObject;
    constructor create (AOwner: TComponent); override;
    destructor destroy; override;
    function GetDBChecked: Boolean;
    procedure ControlToDyn(xPos, yPos: Integer);
    property CanMove: Boolean read FCanMove write FCanmove;
  published
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField : string read FDataField write SetDataField;
    property ValueChecked: string read FValueChecked write SetValueChecked ;
    property ValueUnChecked: string read FValueUnChecked write SetValueUnChecked ;
    property ColorFrame: TColor read FColorFrame write SetColorFrame;
    property ColorCheckMark: TColor read FColorCheckMark write SetColorCheckMark;
    property ColorBk: TColor read FColorBk write SetColorBk;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw;
    property Checked: Boolean read GetChecked write SetChecked;
    property OnOfCheck: TCheckedEvent read FOnOfCheck write FOnOfCheck;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property InvertNull: boolean read FinvertNull write SetInvertNull;
    property BoundsDynRect: TRect read GetBoundsDynRect ;

    property Scale: Double read FScale write SetScale;
    property DynLeft: integer  read FDynLeft write FDynLeft;
    property DynRight: Integer read FDynRight write FDynRight;
    property DynBottom: Integer read FDynBottom write FDynBottom;
    property DynTop: integer  read FDynTop write FDynTop;
    property DynFontHeight: Integer read FDynFontHeight write SetDynFontHeight;

    property OnEnter;
    property OnExit;
    property Enabled;
    //property Visible: Boolean read FVisible write SetVisible;
  end;

procedure Register;

implementation

uses Math, Variants, DynWinPanel;

procedure Register;
begin
  RegisterComponents('Hippocrates', [TDBCheckBoxResize]);
  RegisterComponents('Hippocrates', [TDBCheckBoxResizeWin]);
end;

{ TDBCheckBoxResize }

procedure TDBCheckBoxResize.Click;
begin
  DoClick;
  inherited;
end;

constructor TDBCheckBoxResize.create(AOwner: TComponent);
begin
  inherited;
  FCompWin := TDbCheckBoxResizeWin(AOwner);
  FValueChecked := 'Y';
  FValueUnChecked := 'N';
  FColorFrame := $00B05F7F;
  FColorBk := clWhite;
  FColorCheckMark := clGreen;
  //FOwnerDraw := True;
  FChecked := True;
end;

procedure TDBCheckBoxResize.DblClick;
begin
  DoClick;
  inherited;
end;

procedure TDBCheckBoxResize.DoClick;
var
  flagValue: Boolean;
begin

  Checked := not Checked;
  Paint;
  Exit;

  if FReadOnly then Exit;
  flagValue := False;
  if DataSource <>  nil then
  begin
    if (DataSource.DataSet <> nil) and (OwnerDraw) then
    begin
      if (FValueChecked = FValueUnChecked ) then
      begin
        if  not DataSource.DataSet.FieldByName(DataField).IsNull then
        begin
          if DataSource.DataSet.State in [dsEdit, dsInsert] then
          begin
            DataSource.DataSet.FieldByName(DataField).AsVariant := null;
          end
          else
          begin
            DataSource.DataSet.Edit;
            DataSource.DataSet.FieldByName(DataField).AsVariant := null;
            DataSource.DataSet.Post;
          end;
          Exit;
        end
      end;
      if (Text = FValueUnChecked) or (Text = '') then
      begin
        Checked := True;
        flagValue := True;
      end;
      if Text = FValueChecked then
      begin
        Checked := False;
        flagValue := True;
      end;
      if flagValue then
      begin
        if DataSource.DataSet.State in [dsEdit, dsInsert] then
        begin
          if Checked  then
          begin
            DataSource.DataSet.FieldByName(DataField).Value := ValueChecked;
          end
          else
          begin
            DataSource.DataSet.FieldByName(DataField).Value := ValueUnChecked;
          end;
        end
        else
        begin
          DataSource.DataSet.Edit;
          if Checked  then
          begin
            DataSource.DataSet.FieldByName(DataField).Value := ValueChecked;
          end
          else
          begin
            DataSource.DataSet.FieldByName(DataField).Value := ValueUnChecked;
          end;
          DataSource.DataSet.Post;
        end;

      end;
    end
    else
    begin
      Checked := not Checked;
    end;
  end
  else
    Checked := not Checked;

  if not FCompWin.Focused then
  begin
    SetFocus(FCompWin.Handle);
  end;
  Paint;
end;

procedure TDBCheckBoxResize.DrawCheckBox(Checked: Boolean);
const
  ConstrH = 62;//такава е височината на базовата картинка която съм използвал
var
  x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6: Integer;
  rx1, ry1, rx2, ry2: Integer;
  sf: Double;
begin
  sf := Height / ConstrH;//koeficient  на увеличение/намаление
  rx1 := Round(sf);
  ry1 := Round(sf);
  rx2 := Round(ConstrH * sf) - Round(sf);
  ry2 := Round(ConstrH * sf) - Round(sf);
  if self.Enabled then
  begin
    Canvas.Brush.Color := ColorBk;
  end
  else
  begin
    Canvas.Brush.Color := clBtnFace;
  end;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := FColorFrame;
  Canvas.Pen.Width :=Round(sf * 3);//3 е дебелината на линията за рамката
  Canvas.Rectangle(rx1, ry1, rx2, ry2);
  if Checked then
  begin
    x1 := Round(8 * sf);
    y1 := Round(16 * sf);
    x2 := Round(26 * sf);
    y2 := Round(34 * sf);
    x3 := Round(53 * sf);
    y3 := Round(7 * sf);
    x4 := Round(53 * sf);
    y4 := Round(27 * sf);
    x5 := Round(26 * sf);
    y5 := Round(54 * sf);
    x6 := Round(8 * sf);
    y6 := Round(36 * sf);
    //стойностите са координатите на върховете в базовата картинка
    BeginPath(Canvas.Handle);
    Canvas.MoveTo(x1, y1);
    Canvas.LineTo(x2, y2);
    Canvas.LineTo(x3, y3);
    Canvas.LineTo(x4, y4);
    Canvas.LineTo(x5, y5);
    Canvas.LineTo(x6, y6);
    CloseFigure(Canvas.Handle);
    EndPath(Canvas.Handle);

    Canvas.Pen.Width :=Round(sf * 3);//3 е дебелината на линията за получаване на ефект на закръгляване на ръбовете
    Canvas.Pen.Color := FColorCheckMark;
    Canvas.Brush.Color := FColorCheckMark;
    Canvas.Brush.Style := bsSolid;
    StrokeAndFillPath(Canvas.Handle);
  end;
end;

function TDBCheckBoxResize.GetChecked: Boolean;
begin
  Result := FChecked;
  if (DataSource <> nil) then
    if DataSource.DataSet.FieldByName(DataField).IsNull then
    begin
      Result := false and FChecked;
    end
    else
    begin
      if DataSource.DataSet.FieldByName(DataField).AsString = ValueChecked then
      begin
        Result := true;
      end;
      if DataSource.DataSet.FieldByName(DataField).AsString = ValueUnChecked then
      begin
        Result := false;
      end;
    end;
end;

procedure TDBCheckBoxResize.Paint;
var
  EventCheck: TCheckedEvent;
begin

  if FOwnerDraw then
  begin
    if (FValueChecked = FValueUnChecked) and (DataSource <> nil)then //приема се , че checkBox-a  трябва да показва само дали е нулл или не
    begin
      if DataSource.DataSet.FieldByName(DataField).IsNull then
      begin
        DrawCheckBox(not FInvertNull);
        EventCheck := OnOfCheck;
        OnOfCheck := nil;
        Checked := not FInvertNull;
        OnOfCheck := EventCheck;
        Exit;
      end
      else
      begin
        DrawCheckBox(FInvertNull);
        EventCheck := OnOfCheck;
        OnOfCheck := nil;
        Checked :=  FInvertNull;
        OnOfCheck := EventCheck;
        Exit;
      end;
    end;
    if Text = FValueChecked then
    begin
      DrawCheckBox(True);
      EventCheck := OnOfCheck;
      OnOfCheck := nil;
      Checked := True;
      OnOfCheck := EventCheck;
      Exit;
    end;
    if Text = FValueUnChecked then
    begin
      DrawCheckBox(false);
      EventCheck := OnOfCheck;
      OnOfCheck := nil;
      Checked := False;
      OnOfCheck := EventCheck;
      Exit;
    end;
    DrawFrameControl(Canvas.Handle,Rect(0,0,Height,Height),DFC_BUTTON,(DFCS_BUTTONCHECK or DFCS_FLAT));
  end
  else
  begin
    DrawCheckBox(FChecked);
  end;
end;


procedure TDBCheckBoxResize.SetChecked(const Value: Boolean);
begin
  if FChecked <> Value then
  begin
    if not FOwnerDraw then
    begin
      DrawCheckBox(Value);
    end;
    FChecked := Value;
  end;
  if Assigned(OnOfCheck) then
    OnOfCheck(Self, Value);
end;

procedure TDBCheckBoxResize.SetColorBk(const Value: TColor);
begin
  if FColorBk <> Value then
  begin
    FColorBk := Value;
    Paint;
  end;    
end;

procedure TDBCheckBoxResize.SetColorCheckMark(const Value: TColor);
begin
  if FColorCheckMark <> Value then
  begin
    FColorCheckMark := Value;
    Paint;
  end;    
end;

procedure TDBCheckBoxResize.SetColorFrame(const Value: TColor);
begin
  if FColorFrame <> Value then
  begin
    FColorFrame := Value;
    Paint;
  end;    
end;



procedure TDBCheckBoxResize.SetOwnerDraw(const Value: Boolean);
begin
  if FOwnerDraw <> Value then
  begin
    FOwnerDraw := Value;
    Paint
  end;    
end;

procedure TDBCheckBoxResize.SetValueChecked(const Value: string);
begin
  if FValueChecked <> Value then
  begin
    FValueChecked := Value;
    Paint;
  end;    
end;

procedure TDBCheckBoxResize.SetValueUnChecked(const Value: string);
begin
  if FValueUnChecked <> Value then
  begin
    FValueUnChecked := Value;
    Paint;
  end;    
end;

{ TDbCheckBoxResizeWin }

procedure TDbCheckBoxResizeWin.CMEnter(var Message: TCMEnter);
begin
  inherited;
end;

procedure TDbCheckBoxResizeWin.CMExit(var Message: TCMExit);
begin
 inherited;
end;

procedure TDbCheckBoxResizeWin.ControlToDyn(xPos, yPos: Integer);
var
  dynck: TDynCheckBox;
begin

  if FDynCheck <> nil then
  begin
    dynck:= TDynCheckBox(FDynCheck);
    dynck.FRect.Left := round((XPos + dynck.FDynPanel.HScrollPos)/dynck.FDynPanel.scale);
    dynck.FRect.Top := round((YPos + dynck.FDynPanel.VScrollPos)/dynck.FDynPanel.scale);
    dynck.FRect.Height := round(Self.Height/dynck.FDynPanel.scale);
    dynck.FRect.Width := round(Self.Width/dynck.FDynPanel.scale);
    dynck.ColIndex := Self.Tag;
    FCanMove := False;
    begin
      Self.FDynLeft := dynck.FRect.Left;
      Self.FDynTop := dynck.FRect.Top;
      Self.FDynRight := dynck.FRect.Right;
      Self.FDynBottom := dynck.FRect.Bottom;
    end;
    FCanMove := true;
  end;
end;

constructor TDbCheckBoxResizeWin.create(AOwner: TComponent);
begin
  inherited;
  FCheckBoxRes := TDBCheckBoxResize.Create(self);
  FCheckBoxRes.Parent := Self;
  FCheckBoxRes.Align := alClient;
  ValueChecked := 'Y';
  ValueUnChecked := 'N';
  FColorFrame := $00B05F7F;
  FColorBk := clWhite;
  FColorCheckMark := clGreen;
  FOwnerDraw := false;
  FChecked := False;
  FCheckBoxRes.FChecked := False;
  FCheckBoxRes.OnOfCheck := OfCheck;
  FDynCheck := nil;
  FCanMove := True;
end;

destructor TDbCheckBoxResizeWin.destroy;
begin
  if FDynCheck <> nil then
    FreeAndNil(FDynCheck);
  inherited;
end;

function TDbCheckBoxResizeWin.GetBoundsDynRect: TRect;
var
  dynck: TDynCheckBox;
begin
  dynck:= TDynCheckBox(FDynCheck);
  Result.Left := DynLeft;
  Result.Top := DynTop;
  Result.Right := DynRight ;
  Result.Bottom := DynBottom;
end;

function TDbCheckBoxResizeWin.GetChecked: Boolean;
begin
  Result := FCheckBoxRes.Checked;
  FChecked := FCheckBoxRes.Checked;
end;

function TDbCheckBoxResizeWin.GetDBChecked: Boolean;
begin
  Result := FCheckBoxRes.GetChecked;
end;

procedure TDbCheckBoxResizeWin.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if (Parent <> nil) and(parent is TDynWinPanel) then
    begin
      ControlToDyn(Left, Top);
    end;

  end;
end;

procedure TDbCheckBoxResizeWin.OfCheck(Sender: TObject; IsChecked: Boolean);
begin
  FChecked := IsChecked;
  if Assigned(OnOfCheck) then
    OnOfCheck(Self, IsChecked)
end;

procedure TDbCheckBoxResizeWin.Resize;
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

procedure TDbCheckBoxResizeWin.SetChecked(const Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FCheckBoxRes.Checked := Value;
    FChecked := Value;
  end;
end;

procedure TDbCheckBoxResizeWin.SetColorBk(const Value: TColor);
begin
  if FColorBk <> Value then
  begin
    FCheckBoxRes.ColorBk := Value;
    FColorBk := Value;
    //tempBkColor := value;
  end;
end;

procedure TDbCheckBoxResizeWin.SetColorCheckMark(const Value: TColor);
begin
  if FColorCheckMark <> Value then
  begin
    FCheckBoxRes.ColorCheckMark := Value;
    FColorCheckMark := Value;
  end;    
end;

procedure TDbCheckBoxResizeWin.SetColorFrame(const Value: TColor);
begin
  if FColorFrame <> Value then
  begin
    FCheckBoxRes.ColorFrame := Value;
    FColorFrame := Value;
  end;    
end;

procedure TDbCheckBoxResizeWin.SetDataField(const Value: string);
begin
  if FDataField <> Value then
  begin
    FCheckBoxRes.DataField := Value;
    FDataField := Value;
  end;
end;

procedure TDbCheckBoxResizeWin.SetDataSource(const Value: TDataSource);
begin
  if FDataSource <> Value then
  begin
    FCheckBoxRes.DataSource := Value;
    FDataSource := Value;
  end;    
end;

procedure TDbCheckBoxResizeWin.SetDynFontHeight(const Value: Integer);
begin
  FDynFontHeight := Value;
end;

procedure TDbCheckBoxResizeWin.SetEnabled(Value: Boolean);
begin
  inherited;
  FCheckBoxRes.Enabled := value;
  Repaint;
end;

procedure TDbCheckBoxResizeWin.SetInvertNull(const Value: boolean);
begin
  FinvertNull := Value;
  FCheckBoxRes.InvertNull := value;
end;

procedure TDbCheckBoxResizeWin.SetOwnerDraw(const Value: Boolean);
begin
  if FOwnerDraw <> Value then
  begin
    FCheckBoxRes.OwnerDraw := Value;
    FOwnerDraw := Value;
  end;    
end;

procedure TDbCheckBoxResizeWin.SetParent(AParent: TWinControl);
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

procedure TDbCheckBoxResizeWin.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
  FCheckBoxRes.ReadOnly := Value;
end;

procedure TDbCheckBoxResizeWin.SetScale(const Value: Double);
begin
  FScale := Value;
end;

procedure TDbCheckBoxResizeWin.SetValueChecked(const Value: string);
begin
  if FValueChecked <> Value then
  begin
    FCheckBoxRes.ValueChecked := Value;
    FValueChecked := Value;
  end;    
end;

procedure TDbCheckBoxResizeWin.SetValueUnChecked(const Value: string);
begin
  if FValueUnChecked <> Value then
  begin
    FCheckBoxRes.ValueUnChecked := Value;
    FValueUnChecked := Value;
  end;    
end;

//procedure TDbCheckBoxResizeWin.SetVisible(const Value: Boolean);
//begin
//  FVisible := Value;
//  //inherited Visible(Value);
//end;

procedure TDbCheckBoxResizeWin.WMASetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if Parent is TDynWinPanel then
  begin
    if (TDynWinPanel(Parent).FFocusedChk <> nil) and (TDynWinPanel(Parent).FFocusedChk.chkInplace <> self) then
    begin
      TDynWinPanel(Parent).FFocusedChk.chkInplace.Visible := False;
    end
    else
      TDynWinPanel(Parent).FFocusedChk := TDynCheckBox(FDynCheck);

    if TDynWinPanel(Parent).FFocusedEdit <> nil then  //FFocusedDatTim
    begin
      TDynWinPanel(Parent).FFocusedEdit.edtInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedEdit := nil;
    end;
    if TDynWinPanel(Parent).FFocusedDatTim <> nil then
    begin
      TDynWinPanel(Parent).FFocusedDatTim.DatTimInplace.Visible := False;
      TDynWinPanel(Parent).FFocusedDatTim := nil;
    end;
  end;
end;

procedure TDbCheckBoxResizeWin.WMMove(var Msg: TWMMove);
begin

  if not CanMove then  Exit;

  inherited;
  if (csDesigning in ComponentState) then
  begin
    ControlToDyn(Msg.XPos, Msg.YPos);
  end;
end;

end.

