unit RoleButton;
        //mousein
interface

uses
  GR32, GR32_Resamplers, GR32_ExtImage, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Buttons, Vcl.Graphics,
  Winapi.Windows, Vcl.Themes, Vcl.Forms, Vcl.Imaging.pngimage, GR32_Image, Image32_PNG,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ImgList, Vcl.WinXCtrls, Winapi.Messages, system.Types
;

type
  TCloseViewType = (cvtNone, cvtEnterLeave, cvtCTRL, cvtMouseLeftOfset);



  TPanelRoles = class;
  TRoleButtonCollection = class;
  TRoleButtonItem = class;
  TRoleButton = class;
  TPanelViewRoles = class;

  TActivesControls = record
    ActivePanel: string;
    ActiveMainButton: string;
    ActiveSubButton: string;
  end;

  TIcon32Item = class(TCollectionItem)
  private
    FIcon: TPngImage;
    procedure SetIcon(AIcon: TPngImage);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Icon: TPngImage read FIcon write SetIcon;
  end;


  TIcon32Collection = class(TCollection)
  private
    FOwner: TPersistent;
    function  GetItem(Index: Integer): TIcon32Item;
    procedure SetItem(Index: Integer; Value: TIcon32Item);
  protected
    function  GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TIcon32Item;
    property Items[Index: Integer]: TIcon32Item read GetItem write SetItem; default;
  end;

  TIcon32List = class(TComponent)
  private
    FIcon32Collection: TIcon32Collection;
    procedure SetIcon(Index: Integer; Value: TPngImage);
    function GetIcon(Index: Integer): TPngImage;
    procedure SetIcon32Collection(Value: TIcon32Collection);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Icon[Index: Integer]: TPngImage read GetIcon write SetIcon; default;
  published
    property Icons32: TIcon32Collection read FIcon32Collection write SetIcon32Collection;
  end;

  TRoleItem = class(TCollectionItem)
  private
    FRoleNote: string;
    FBmp32List: TIcon32List;
    FBmpIndex: Integer;
    FMainButtons: TRoleButtonCollection;
    procedure SetRoleNote(const Value: string);
    procedure setBmpIndex(const Value: Integer);
    procedure SetBmp32List(const Value: TIcon32List);
    procedure SetPanel(const Value: TPanelRoles);
    procedure SetMainButtons(const Value: TRoleButtonCollection);
  protected
    function GetDisplayName: string; override;
  public
    FPanel: TPanelRoles;
    FRolButt: TRoleButton;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Panel: TPanelRoles read FPanel write SetPanel;
    property RoleNote: string read FRoleNote write SetRoleNote;
    property Bmp32List: TIcon32List read FBmp32List write SetBmp32List;
    property BmpIndex: Integer read FBmpIndex write setBmpIndex;
    property MainButtons: TRoleButtonCollection read FMainButtons write SetMainButtons;

  end;

  TRoleCollection = class(TCollection)
  private
    FOwner: TPersistent;
    FActivePanel: TPanelRoles;
    function  GetItem(Index: Integer): TRoleItem;
    procedure SetItem(Index: Integer; Value: TRoleItem);
    procedure SetActivePanel(const Value: TPanelRoles);
  protected
    function  GetOwner: TPersistent; override;
  public
    FPanelViewer: TPanelViewRoles;
    constructor Create(AOwner: TPersistent);
    function Add: TRoleItem;
    property Items[Index: Integer]: TRoleItem read GetItem write SetItem; default;
    property ActivePanel: TPanelRoles read FActivePanel write SetActivePanel;
  end;

  TPanelViewRoles = class(TSplitView)
  private
    FIconList: TIcon32List;
    FRoleCollection: TRoleCollection;
    FOnRoleButtonClick: TNotifyEvent;
    FCloseType: TCloseViewType;
    FActivePanel: TPanelRoles;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMSizing(var Msg: TMessage); message WM_SIZING;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure SetIconList(const Value: TIcon32List);
    procedure SetRoleCollection(const Value: TRoleCollection);
    procedure SetActivePanel(const Value: TPanelRoles);
  protected
    { Protected declarations }
  public
    ListHistoryActivesControl: TList;
    actCtrls: TActivesControls;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure Clear(OnlySubButton: boolean);
    function BtnFromName(btnName: string): TRoleButton;
    procedure ForceClose;
    property ActivePanel: TPanelRoles read FActivePanel write SetActivePanel;
  published
    property IconList: TIcon32List read FIconList write SetIconList;
    property CloseType: TCloseViewType read FCloseType write FCloseType;
    property Roles: TRoleCollection read FRoleCollection write SetRoleCollection;
    property OnRoleButtonClick: TNotifyEvent read FOnRoleButtonClick write FOnRoleButtonClick;
  end;

  TPanelRoles = class(TCustomPanel)
  private
    lblDescr: TLabel;
    btnStartRole: TSpeedButton;
    FIcon32: TPngImage;
    btnVideo: TButton;
    btnHelp: TButton;
    btnManager: TButton;
    FImages: TCustomImageList;
    FMainImage: TBitmap32;
    FIconList: TIcon32List;
    FIconIndex: Integer;
    FDescrText: string;
    FOnStartRole: TNotifyEvent;
    FRole: TRoleItem;
    FIsActive: Boolean;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetImages(const Value: TCustomImageList);
    procedure MouseEnter(Sender: TObject);
    procedure MouseLeave(Sender: TObject);
    procedure SetIcon32(const Value: TPngImage);
    procedure SetIconList(const Value: TIcon32List);
    procedure SetIconIndex(const Value: Integer);
    procedure SetDescrText(const Value: string);
    procedure SetOnStartRole(const Value: TNotifyEvent);
    procedure SetIsActive(const Value: Boolean);
  protected
    procedure DrawIcon32;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadImage(FileName: string);
    procedure FillIcon(RoleView: TPanelViewRoles);
    property IsActive: Boolean read FIsActive write SetIsActive;
  published
    property Images: TCustomImageList read FImages write SetImages;
    property Icon32: TPngImage read FIcon32 write SetIcon32;
    property IconList: TIcon32List read FIconList write SetIconList;
    property IconIndex: Integer read FIconIndex write SetIconIndex;
    property DescrText: string read FDescrText write SetDescrText;
    property OnStartRole: TNotifyEvent read FOnStartRole write SetOnStartRole;
    property Role: TRoleItem read FRole;
  end;

  TRoleButton = class(TSpeedButton)
  private
    FMinValue: Integer;
    FColorProgres: TColor;
    FMaxValue: Integer;
    FPosition: Integer;
    FIcon32: TPngImage;
    FIsRole: Boolean;
    FOffsetIcon: Integer;
    FDescription: string;
    FRoleItem: TRoleButtonItem;
    FIsSubButon: Boolean;

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetColorProgres(const Value: TColor);
    procedure SetPosition(const Value: Integer);
    procedure DrawIcon32;
    procedure DrawIcon32_1;
    procedure SetIcon32(const Value: TPngImage);
    procedure SetOffsetIcon(const Value: Integer);
    procedure SetSplitViewer(const Value: TPanelViewRoles);
    procedure SetDescription(const Value: string);
  protected
    FSplitViewer: TPanelViewRoles;
    procedure Paint; override;
  public

    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    property SplitViewer: TPanelViewRoles read FSplitViewer write SetSplitViewer;
    procedure Click; override;
    property RoleItem: TRoleButtonItem read FRoleItem write FRoleItem;
  published
    property MinValue: Integer read FMinValue write FMinValue;
    property MaxValue: Integer read FMaxValue write FMaxValue;
    property Position: Integer read FPosition write SetPosition;
    property ColorProgres: TColor read FColorProgres write SetColorProgres;
    property Icon32: TPngImage read FIcon32 write SetIcon32;
    property IsRole: Boolean read FIsRole write FIsRole;
    property IsSubButon: Boolean read FIsSubButon write FIsSubButon;
    property OffsetIcon: Integer read FOffsetIcon write SetOffsetIcon;
    property Description: string read FDescription write SetDescription;

  end;

  TRoleButtonItem = class(TCollectionItem)
  private
    FSubButtons: TRoleButtonCollection;
    FMinValue: Integer;
    FIconIndex: integer;
    //FIsRole: Boolean;
    FColorProgres: TColor;
    FOffsetIcon: Integer;
    FMaxValue: Integer;
    FPosition: Integer;
    FDescription: string;
    FOnClick: TNotifyEvent;
    procedure SetSubButtons(const Value: TRoleButtonCollection);
    procedure SetColorProgres(const Value: TColor);
    procedure SetIconIndex(const Value: integer);
    procedure SetOffsetIcon(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetOnClick(const Value: TNotifyEvent);
  protected
    function GetDisplayName: string; override;
  public

    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property MinValue: Integer read FMinValue write FMinValue;
    property MaxValue: Integer read FMaxValue write FMaxValue;
    property Position: Integer read FPosition write SetPosition;
    property ColorProgres: TColor read FColorProgres write SetColorProgres;
    property IconIndex: integer read FIconIndex write SetIconIndex;
    //property IsRole: Boolean read FIsRole write FIsRole;
    property OffsetIcon: Integer read FOffsetIcon write SetOffsetIcon;
    property Description: string read FDescription write FDescription;
    property SubButtons: TRoleButtonCollection read FSubButtons write SetSubButtons;
    property OnClick: TNotifyEvent read FOnClick write SetOnClick;
  end;

  TRoleButtonCollection = class(TCollection)
  private
    FOwner: TPersistent;
    function  GetItem(Index: Integer): TRoleButtonItem;
    procedure SetItem(Index: Integer; Value: TRoleButtonItem);
  protected
    function  GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor destroy; override;
    function Add: TRoleButtonItem;
    property Items[Index: Integer]: TRoleButtonItem read GetItem write SetItem; default;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Biser', [TRoleButton]);
  RegisterComponents('biser', [TPanelRoles]);
  RegisterComponents('biser', [TPanelViewRoles]);
  RegisterComponents('biser', [TIcon32List]);
end;

{ TPanelRoles }

constructor TPanelRoles.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := True;
  lblDescr := TLabel.Create(Self);
  FIcon32 := TPngImageCC.create;
  btnVideo := TButton.Create(Self);
  btnHelp := TButton.Create(Self);
  btnManager := TButton.Create(Self);

  self.Width := 350;
  self.Height := 160;
  self.Caption := '';
  self.ParentBackground := False;
  self.ShowCaption := False;
  self.OnMouseEnter := MouseEnter;
  self.OnMouseLeave := MouseLeave;
  lblDescr.Name := 'lblDescr' + Self.Name;
  lblDescr.Parent := self;
  lblDescr.Left := 184;
  lblDescr.Top := 48;
  lblDescr.Width := 153;
  lblDescr.Height := 89;
  lblDescr.Alignment := taCenter;
  lblDescr.AutoSize := False;
  lblDescr.Caption :=
       'Кратко описание на ролята' + #13#10 +
       'например Преглеждащ лекар';
  lblDescr.Color := 13619151;
  lblDescr.ParentColor := False;
  lblDescr.ParentFont := False;
  lblDescr.Transparent := False;
  lblDescr.Layout := tlCenter;
  lblDescr.WordWrap := True;
  lblDescr.OnMouseEnter := MouseEnter;
  lblDescr.OnMouseLeave := MouseLeave;
  lblDescr.Font.Size := 12;


  btnStartRole := TSpeedButton.Create(Self);

  btnStartRole.Name := 'btnStartRole' + Self.Name;
  btnStartRole.Parent := Self;
  btnStartRole.BoundsRect := lblDescr.BoundsRect;
  btnStartRole.AllowAllUp := false;
  btnStartRole.GroupIndex := 0;
  btnStartRole.Flat := True;

  btnVideo.Name := 'ButtonVideo' + Self.Name;
  btnVideo.Caption  := '';
  btnVideo.Parent := self;
  btnVideo.Left := 201;
  btnVideo.Top := 21;
  btnVideo.Width := 33;
  btnVideo.Height := 25;
  btnVideo.Enabled := False;
  btnVideo.ImageAlignment := iaCenter;
  btnVideo.ImageIndex := 92;
  btnVideo.Images := FImages;
  btnVideo.TabOrder := 1;
  btnHelp.Name := 'btnHelp' + Self.Name;
  btnHelp.Caption  := '';
  btnHelp.Parent := self;
  btnHelp.Left := 240;
  btnHelp.Top := 21;
  btnHelp.Width := 33;
  btnHelp.Height := 25;
  btnHelp.ImageAlignment := iaCenter;
  btnHelp.ImageIndex := 89;
  btnHelp.Images := FImages;
  btnHelp.TabOrder := 2;
  btnManager.Name := 'btnManager' + Self.Name;
  btnManager.Caption  := '';
  btnManager.Parent := self;
  btnManager.Left := 279;
  btnManager.Top := 21;
  btnManager.Width := 33;
  btnManager.Height := 25;
  btnManager.ImageAlignment := iaCenter;
  btnManager.ImageIndex := 77;
  btnManager.Images := FImages;
  btnManager.TabOrder := 3;
end;

procedure TPanelRoles.DrawIcon32;
var
  r, dstR: TRect;
  bmp: TBitmap;
  bmp32, bmpDst: TBitmap32;
  c: TColor32;
  KR: TKernelResampler;
  tf: TTextFormat ;
  txt: string;
  RImage: TRect;
begin
  if FIcon32 = nil then
    Exit;
  if FIcon32.Height = 0 then
    Exit;

  TPngImageCC(FIcon32).ColorDrawAssign := Canvas.Brush.Color;
  r := Rect(0, 0, 115,115);
  RImage := Rect(30, 24, 30+ 115, 24 + 115);

  //Canvas.FillRect( Rect(11, 20, 111,120));

  bmp32 := TBitmap32.Create;
  bmpDst := TBitmap32.Create;
  //bmpDst.s


  bmp32.MasterAlpha := 255;
  bmp32.Assign(FIcon32);


  bmp32.Resampler := TKernelResampler.Create;
  TKernelResampler(bmp32.Resampler).Kernel := TCubicKernel.Create;
  dstR := r;
  bmpDst.Width := r.Width;
  bmpDst.Height := r.Height;
  TKernelResampler(bmp32.Resampler).Resample(bmpDst, bmpDst.ClipRect, bmpDst.ClipRect, bmp32,bmp32.ClipRect, dmOpaque, nil);

  bmpDst.DrawTo(Self.Canvas.Handle, RImage, dstR);
 // Canvas.Rectangle( bmp32.ClipRect);
  bmp32.Free;
  bmpDst.Free;
end;


procedure TPanelRoles.FillIcon(RoleView: TPanelViewRoles);
var
  btn: TRoleButton;
  i: Integer;
  h: integer;
begin
  RoleView.Clear(False);
  h := 10;


  if Assigned(FRole) then
  begin
    for i := 0 to FRole.MainButtons.Count - 1 do
    begin

      btn := TRoleButton.Create(self);
      btn.RoleItem := FRole.MainButtons.Items[i];
      btn.SplitViewer := RoleView;

      btn.Parent := RoleView;
      //btn.Visible := False;
      btn.Top := h;
      h := btn.BoundsRect.Bottom + 2;

      btn.Icon32.Assign(FRole.Bmp32List.Icon[FRole.MainButtons.Items[i].IconIndex]);
      btn.OffsetIcon := 4;
      btn.GroupIndex := 1;
      btn.AllowAllUp := True;
      btn.MinValue := 0;
      btn.MaxValue := 100;
      btn.Position := 0;
      btn.ColorProgres := clLime;
      btn.Description := FRole.MainButtons.Items[i].Description;
      btn.OnClick := FRole.MainButtons.Items[i].FOnClick;
    end;
  end;

  //btnItem := FRole.MainButtons.Items[i];
  btn := TRoleButton.Create(self);
  btn.IsRole := True;
  FRole.FRolButt := btn;
  btn.SplitViewer := RoleView;

  btn.Parent := RoleView;
  btn.Top := h;
  h := btn.BoundsRect.Bottom + 2;

  btn.Icon32.Assign(Self.IconList.Icon[Self.IconIndex]);
  btn.OffsetIcon := 4;
  btn.GroupIndex := 0;
  btn.AllowAllUp := True;
  btn.MinValue := 0;
  btn.MaxValue := 100;
  btn.Position := 0;
  btn.ColorProgres := clLime;
  btn.Description := Self.DescrText;
  btn.OnClick := RoleView.OnRoleButtonClick;


end;

procedure TPanelRoles.LoadImage(FileName: string);
begin
  //imgRole1.Bitmap.LoadFromFile(filename);
end;

procedure TPanelRoles.MouseEnter(Sender: TObject);
begin
  self.Color := $00FCDCE0; //$00F9EDAC;
end;

procedure TPanelRoles.MouseLeave(Sender: TObject);
var
  p, p1, p2: TPoint;
begin
  p := Mouse.CursorPos;
  p := ScreenToClient(p);
  if PtInRect(Self.ClientRect, p)  then
    Exit;
  self.Color := clBtnFace;

end;

procedure TPanelRoles.Paint;
begin
  inherited;
  //Canvas.Brush.Color := clRed;
  //Canvas.FillRect(Rect(11, 20, 160,120));
  DrawIcon32;
  if FIsActive then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Width := 4;
    Canvas.Pen.Color := $00FCCC72;
    Canvas.Rectangle(Self.ClientRect);
  end;
  if not Enabled then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Width := 8;
    Canvas.Pen.Color := $00E08DD6;
    Canvas.Rectangle(Self.ClientRect);
  end;

end;

procedure TPanelRoles.SetDescrText(const Value: string);
begin
  FDescrText := Value;
  lblDescr.Caption := FDescrText;
end;

procedure TPanelRoles.SetIcon32(const Value: TPngImage);
begin
  TPngImage(FIcon32).Assign(TPngImage(Value));
  Repaint;
end;

procedure TPanelRoles.SetIconIndex(const Value: Integer);
begin
  if Assigned(FIconList) then
  begin
    if Value < FIconList.Icons32.Count then
    begin
      FIconIndex := Value;
      TPngImage(FIcon32).Assign(TPngImage(FIconList.Icon[FIconIndex]));
      Repaint;
    end;
  end;
end;

procedure TPanelRoles.SetIconList(const Value: TIcon32List);
begin
  FIconList := Value;

  if Assigned(FIconList)  then
  begin
    if FIconIndex < FIconList.Icons32.Count then
    begin
      TPngImage(FIcon32).Assign(TPngImage(Value.Icon[FIconIndex]));
      Repaint;
    end
    else
    begin
      IconIndex := 0;
    end;
  end
  else
  begin
    FIcon32 := nil;
    Repaint;
  end;
end;

procedure TPanelRoles.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then
  begin
    if Images <> nil then
    begin
      //Images.UnRegisterChanges(FImageChangeLink);
    end;
    FImages := Value;
    if Images <> nil then
    begin
      btnHelp.Images := FImages;
      btnManager.Images := FImages;
      btnVideo.Images := FImages;
      //Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
    end;
    //UpdateImageList;
  end;
end;

procedure TPanelRoles.SetIsActive(const Value: Boolean);
begin
  FIsActive := Value;
  Repaint;
end;

procedure TPanelRoles.SetOnStartRole(const Value: TNotifyEvent);
begin
  FOnStartRole := Value;
  btnStartRole.OnClick := FOnStartRole;
end;

procedure TPanelRoles.WMNCHitTest(var Msg: TWMNCHitTest);
var
  ScreenPt: TPoint;
  HANDLE_WIDTH: Integer;
  SIZEGRIP: Integer;
begin
 // if (GetKeyState(VK_CONTROL) < 0 ) then exit
  inherited ;


  HANDLE_WIDTH := 2;
  Sizegrip := 29;
  inherited;
  //Msg.Result := HTCAPTION;
  //if not (csDesigning in  ComponentState) then
//  begin
//    ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
//    if (ScreenPt.x >= Width - Sizegrip) and  (ScreenPt.y >= Height - Sizegrip) then
//    begin
//      Msg.Result := HTRIGHT;
//    end;
//
//  end;
end;

{ TRoleButton }

procedure ColorBlend(const ACanvas: HDC; const ARect: TRect;
  const ABlendColor: TColor; const ABlendValue: Integer);
var
  DC: HDC;
  Brush: HBRUSH;
  Bitmap: HBITMAP;
  BlendFunction: TBlendFunction;
begin
  DC := CreateCompatibleDC(ACanvas);
  Bitmap := CreateCompatibleBitmap(ACanvas, ARect.Right - ARect.Left,
    ARect.Bottom - ARect.Top);
  Brush := CreateSolidBrush(ColorToRGB(ABlendColor));
  try
    SelectObject(DC, Bitmap);
    Winapi.Windows.FillRect(DC, Rect(0, 0, ARect.Right - ARect.Left,
      ARect.Bottom - ARect.Top), Brush);
    BlendFunction.BlendOp := AC_SRC_OVER;
    BlendFunction.BlendFlags := 0;
    BlendFunction.AlphaFormat := 0;
    BlendFunction.SourceConstantAlpha := ABlendValue;
    Winapi.Windows.AlphaBlend(ACanvas, ARect.Left, ARect.Top,
      ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, DC, 0, 0,
      ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, BlendFunction);
  finally
    DeleteObject(Brush);
    DeleteObject(Bitmap);
    DeleteDC(DC);
  end;
end;

procedure TRoleButton.Click;
var
  i: Integer;
  RB, btn: TRoleButton;
  h: Integer;
  RoleView: TPanelViewRoles;
begin
  inherited Click;
  if FRoleItem = nil then Exit;
  RB := TRoleItem(TRoleButtonCollection(FRoleItem.Collection).FOwner).FRolButt;
  RoleView := TPanelViewRoles(RB.Parent);
  RoleView.Clear(true);
  h := RB.BoundsRect.Bottom + 10;
  for i := 0 to FRoleItem.SubButtons.Count - 1 do
  begin
    btn := TRoleButton.Create(self);
    btn.IsSubButon := True;
    btn.SplitViewer := RoleView;

    btn.Parent := RoleView;
    //btn.Visible := False;
    btn.Top := h;
    h := btn.BoundsRect.Bottom + 2;

    btn.Icon32.Assign(RoleView.IconList.Icon[FRoleItem.SubButtons.Items[i].IconIndex]);
    btn.OffsetIcon := 4;
    btn.GroupIndex := 2;
    btn.AllowAllUp := True;
    btn.MinValue := 0;
    btn.MaxValue := 100;
    btn.Position := 0;
    btn.ColorProgres := clLime;
    btn.Description := FRoleItem.SubButtons.Items[i].Description;
    btn.OnClick := FRoleItem.SubButtons.Items[i].FOnClick;
  end;
end;

procedure TRoleButton.CMMouseEnter(var Message: TMessage);
begin
  if FSplitViewer <> nil then
  begin
    FSplitViewer.CMMouseEnter(Message);
  end;
  inherited;
end;

procedure TRoleButton.CMMouseLeave(var Message: TMessage);
begin
  if FSplitViewer <> nil then
  begin
    FSplitViewer.CMMouseLeave(Message);
  end;
  inherited;
end;

constructor TRoleButton.Create(AOwner: TComponent);
begin
  inherited;
  FColorProgres := clLime;
  FSplitViewer := nil;
  FMaxValue  := 100;
  FMinValue := 0;
  FPosition := 50;
  FOffsetIcon := 2;
  FIcon32 := TPngImageCC.create;
  FIsSubButon := False;

end;

destructor TRoleButton.destroy;
begin
  if FIcon32 <> nil then
    FIcon32.Free;
  inherited;
end;

procedure TRoleButton.DrawIcon32;
var
  r, dstR: TRect;
  bmp: TBitmap;
  bmp32, bmpDst: TBitmap32;
  c: TColor32;
  KR: TKernelResampler;
  tf: TTextFormat ;
  txt: string;
begin
  if FIcon32 = nil then
    Exit;
  if FIcon32.Height = 0 then
    Exit;
  if (Self.MouseInControl) and (Self.FState = bsUp) then
  begin
    if FIsRole then
    begin
      TPngImageCC(FIcon32).ColorDrawAssign := $00FED7D3;
      Canvas.Brush.Color := $00FED7D3;
    end
    else
    begin
      TPngImageCC(FIcon32).ColorDrawAssign := $00FEE7C0;
      Canvas.Brush.Color := $00FEE7C0;
    end;

  end
  else
  if not(Self.MouseInControl) and (Self.FState = bsUp) then
  begin
    if FIsRole then
    begin
      TPngImageCC(FIcon32).ColorDrawAssign := $0058FAEE;
      Canvas.Brush.Color := $0058FAEE;
    end
    else
    begin
      TPngImageCC(FIcon32).ColorDrawAssign := clBtnFace;
      Canvas.Brush.Color := clBtnFace;
    end;
  end
  else
  if (Self.MouseInControl) and (Self.FState = bsDown) then
  begin
    if FIsRole then
    begin
      TPngImageCC(FIcon32).ColorDrawAssign := $0070FA73;
      Canvas.Brush.Color := $0070FA73;
    end
    else
    begin
      TPngImageCC(FIcon32).ColorDrawAssign := $00FFE9D2;
      Canvas.Brush.Color := $00FFE9D2;
    end;
  end;
  r := Self.ClientRect;

  Canvas.FillRect(r);

  bmp32 := TBitmap32.Create;
  bmpDst := TBitmap32.Create;
  //bmpDst.s


  bmp32.MasterAlpha := 255;
  bmp32.Assign(FIcon32);


  bmp32.Resampler := TKernelResampler.Create;
  TKernelResampler(bmp32.Resampler).Kernel := TCubicKernel.Create;
  dstR := r;
  InflateRect(dstR, -FOffsetIcon * 2, -FOffsetIcon * 2);
  dstR.Width := dstR.Height;
  bmpDst.Width := dstR.Width;
  bmpDst.Height := dstR.Height;
  //TKernelResampler(bmp32.Resampler).
  TKernelResampler(bmp32.Resampler).Resample(bmpDst, bmpDst.ClipRect, bmpDst.ClipRect, bmp32,bmp32.ClipRect, dmOpaque, nil);
  Canvas.Rectangle(dstR);
  bmpDst.DrawTo(Self.Canvas.Handle, dstR, dstR);
  dstR.Left := dstR.Right + 10;
  dstR.Right := Self.ClientRect.Right - 5;
  //tfBottom, tfCalcRect, tfCenter, tfEditControl, tfEndEllipsis,
//    tfPathEllipsis, tfExpandTabs, tfExternalLeading, tfLeft, tfModifyString,
//    tfNoClip, tfNoPrefix, tfRight, tfRtlReading, tfSingleLine, tfTop,
//    tfVerticalCenter, tfWordBreak, tfHidePrefix, tfNoFullWidthCharBreak,
//    tfPrefixOnly, tfTabStop, tfWordEllipsis, tfComposited
   tf := [tfCenter, tfWordBreak, tfVerticalCenter];
   //txt := 'TKernel Resampler(bmp32. Resampler).';
   DrawText(Canvas.Handle, PChar(FDescription), -1, dstR, DT_VCENTER or DT_WORDBREAK);
   //Canvas.TextRect(dstR, txt, tf);
  //Canvas.Rectangle(dstR);
  //

  bmp32.Free;
  bmpDst.Free;
end;


procedure TRoleButton.DrawIcon32_1;
var
  r, dstR, rText: TRect;
  bmp: TBitmap;
  bmp32, bmpDst: TBitmap32;
  c: TColor32;
  KR: TKernelResampler;
  tf: TTextFormat ;
  txt: string;
  RImage: TRect;
begin
  if FIcon32 = nil then
    Exit;
  if FIcon32.Height = 0 then
    Exit;

  if (Self.MouseInControl) and (Self.FState = bsUp) then
  begin
    if FIsRole then
    begin
      //TPngImageCC(FIcon32).ColorDrawAssign := $00FED7D3;
      Canvas.Brush.Color := $00FED7D3;
    end
    else
    begin
      //TPngImageCC(FIcon32).ColorDrawAssign := $00FEE7C0;
      Canvas.Brush.Color := $00FEE7C0;
    end;

  end
  else
  if not(Self.MouseInControl) and (Self.FState = bsUp) then
  begin
    if FIsRole then
    begin
      //TPngImageCC(FIcon32).ColorDrawAssign := $0058FAEE;
      Canvas.Brush.Color := $00BDF6FC;// жълто
    end
    else
    begin
     // TPngImageCC(FIcon32).ColorDrawAssign := clBtnFace;
      Canvas.Brush.Color := clBtnFace;
    end;
  end
  else
  if (Self.FState in [bsDown, bsExclusive]) then
  begin
    if FIsRole then
    begin
      //TPngImageCC(FIcon32).ColorDrawAssign := $0070FA73;
      Canvas.Brush.Color := $0070FA73;
    end
    else
    begin
      //TPngImageCC(FIcon32).ColorDrawAssign := $00FFE9D2;
      Canvas.Brush.Color := $00FFCA95;
    end;
  end;

  TPngImageCC(FIcon32).ColorDrawAssign := Canvas.Brush.Color;
  r := Rect(0, 0, Self.Height - 8,Self.Height - 8);
  RImage := Rect(2, 2, Self.Height - 6, Self.Height - 6);

  Canvas.FillRect( Self.ClientRect);

  bmp32 := TBitmap32.Create;
  bmpDst := TBitmap32.Create;
  //bmpDst.s


  bmp32.MasterAlpha := 255;
  bmp32.Assign(FIcon32);


  bmp32.Resampler := TKernelResampler.Create;
  TKernelResampler(bmp32.Resampler).Kernel := TCubicKernel.Create;
  dstR := r;
  bmpDst.Width := r.Width;
  bmpDst.Height := r.Height;
  TKernelResampler(bmp32.Resampler).Resample(bmpDst, bmpDst.ClipRect, bmpDst.ClipRect, bmp32,bmp32.ClipRect, dmOpaque, nil);

  bmpDst.DrawTo(Self.Canvas.Handle, RImage, dstR);
 // Canvas.Rectangle( bmp32.ClipRect);
  rText := dstR;
  rText.Left := dstR.Right + 10;
  rText.Right := Self.ClientRect.Right - 5;
  dstR := rText;
  txt := FDescription;
  DrawText(Canvas.Handle, PChar(txt), -1, rText, DT_CENTER or DT_WORDBREAK or DT_CALCRECT);
  dstR := CenteredRect(dstR, rText);
  DrawText(Canvas.Handle, PChar(txt), -1, dstR, DT_CENTER or DT_WORDBREAK);


  bmp32.Free;
  bmpDst.Free;
end;




procedure TRoleButton.Paint;
var
  r: TRect;
  W, p: Integer;
  KW: Double;
begin

  inherited paint;

  DrawIcon32_1;
  r  := Self.ClientRect;
  r.Width := r.Height;
  r.Inflate(1, 1);
  w := MaxValue - MinValue;
  if w <> 0 then
  begin
    KW := (r.width - 2)/ w;
  end
  else
  begin
    KW := 0;
  end;
  p := Round(Position * kw);
  r.Width := p;
  ColorBlend(Self.Canvas.Handle, r, FColorProgres, 120);
  //Self.Canvas.Ellipse(10, 10, 20, 20);
end;



procedure TRoleButton.SetColorProgres(const Value: TColor);
begin
  FColorProgres := Value;
  Repaint;
end;

procedure TRoleButton.SetDescription(const Value: string);
begin
  FDescription := Value;
  Repaint;
end;

procedure TRoleButton.SetIcon32(const Value: TPngImage);
begin
  TPngImage(FIcon32).Assign(TPngImage(Value));
  Repaint;
end;

procedure TRoleButton.SetOffsetIcon(const Value: Integer);
begin
  FOffsetIcon := Value;
  Repaint;
end;

procedure TRoleButton.SetPosition(const Value: Integer);
begin
  FPosition := Value;
  Repaint;
end;

procedure TRoleButton.SetSplitViewer(const Value: TPanelViewRoles);
begin
  FSplitViewer := Value;
  if FSplitViewer <> nil then
  begin
    Self.Height := FSplitViewer.CompactWidth;
    Self.Left := 3;
    Self.Width := FSplitViewer.OpenedWidth - 10;
  end;
end;

{ TPanelViewRoles }

function TPanelViewRoles.BtnFromName(btnName: string): TRoleButton;
var
  i: Integer;
begin
  Result := nil;
  for i := self.ControlCount - 1 downto 0 do
  begin
    if self.Controls[i] is TRoleButton then
    begin
      if TRoleButton(self.Controls[i]).Description = btnName then
      begin
        result := TRoleButton(self.Controls[i]);
        Break;
      end;
    end;
  end;
end;

procedure TPanelViewRoles.Clear(OnlySubButton: boolean);
var
  i: Integer;

begin
  for i := ControlCount - 1 downto 0 do
  begin
    if Controls[i] is TRoleButton then
    begin
      if (not TRoleButton(Controls[i]).IsSubButon) and OnlySubButton then
        Continue;
      (Controls[i].Destroy);
    end;
  end;
end;

procedure TPanelViewRoles.CMMouseEnter(var Message: TMessage);
begin
  case FCloseType of
    cvtEnterLeave:
    begin
      self.Open;
    end;
  end;
  inherited;
end;

procedure TPanelViewRoles.CMMouseLeave(var Message: TMessage);
begin
  case FCloseType of
    cvtEnterLeave:
    begin
      self.Close;
    end;
  end;
  inherited;
end;

constructor TPanelViewRoles.Create(AOwner: TComponent);
begin
  inherited;
  FIconList := nil;
  FCloseType := cvtEnterLeave;
  FRoleCollection := TRoleCollection.Create(Self);
end;



destructor TPanelViewRoles.destroy;
begin
  //FreeAndNil(FRoleCollection);
  inherited;
end;

procedure TPanelViewRoles.ForceClose;
var
  w: Integer;
begin
  w := Self.OpenedWidth;
  self.Width := self.CompactWidth;
  while self.Opened do
  begin
    self.Refresh;
    Application.ProcessMessages;
  end;
  Self.OpenedWidth := w;
end;

procedure TPanelViewRoles.SetActivePanel(const Value: TPanelRoles);
begin
  FActivePanel := Value;
  FActivePanel.FillIcon(self);
end;

procedure TPanelViewRoles.SetIconList(const Value: TIcon32List);
begin
  FIconList := Value;
end;

procedure TPanelViewRoles.SetRoleCollection(const Value: TRoleCollection);
begin
  FRoleCollection := Value;
end;

procedure TPanelViewRoles.WMNCHitTest(var Msg: TWMNCHitTest);
var
  ScreenPt: TPoint;
  HANDLE_WIDTH: Integer;
  SIZEGRIP: Integer;
begin
 // if (GetKeyState(VK_CONTROL) < 0 ) then exit
  inherited ;


  HANDLE_WIDTH := 2;
  Sizegrip := 29;
  inherited;
  if not (csDesigning in  ComponentState) then
  begin
    ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
    if (ScreenPt.x >= Width - Sizegrip) and  (ScreenPt.y >= Height - Sizegrip) then
    begin
      Msg.Result := HTRIGHT;
    end;

  end;
end;

procedure TPanelViewRoles.WMPaint(var Message: TWMPaint);
var
  x, y: Integer;
begin
  inherited;
  Canvas.Font.Name := 'Marlett';
  Canvas.Font.Size := 15;
  Canvas.Brush.Style := bsClear;
  x := clientwidth - canvas.textwidth('o');
  y := clientheight - canvas.textheight('o');
  canvas.textout( x, y, 'o' );
end;

procedure TPanelViewRoles.WMSizing(var Msg: TMessage);
var
  r: TRect;
begin
  inherited;
  if not (csDesigning in  ComponentState) then
  begin
    case Msg.wParam of
       WMSZ_RIGHT:
       begin
          r := PRect(Msg.LParam)^;
       end;

    end;
  end;
end;

{ TIcon32Item }

procedure TIcon32Item.AssignTo(Dest: TPersistent);
begin
  inherited;
  if Dest is TIcon32Item then
    TIcon32Item(Dest).Icon.Assign(dest)
  else
end;

constructor TIcon32Item.Create(Collection: TCollection);
begin
  inherited;
  FIcon := TPngImage.Create;
end;

destructor TIcon32Item.Destroy;
begin
  FIcon.Free;
  inherited;
end;

procedure TIcon32Item.SetIcon(AIcon: TPngImage);
begin
  FIcon.Assign(AIcon)
end;

{ TIcon32Collection }

function TIcon32Collection.Add: TIcon32Item;
begin
  Result := TIcon32Item(inherited Add);
end;

constructor TIcon32Collection.Create(AOwner: TPersistent);
begin
  inherited Create(TIcon32Item);
  FOwner := AOwner;
end;

function TIcon32Collection.GetItem(Index: Integer): TIcon32Item;
begin
  Result := TIcon32Item(inherited GetItem(Index));
end;

function TIcon32Collection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TIcon32Collection.SetItem(Index: Integer; Value: TIcon32Item);
begin
  inherited SetItem(Index, Value);
end;

{ TIcon32List }

constructor TIcon32List.Create(AOwner: TComponent);
begin
  inherited;
  FIcon32Collection := TIcon32Collection.Create(Self);
end;

destructor TIcon32List.Destroy;
begin
  FIcon32Collection.Free;
  inherited;
end;

function TIcon32List.GetIcon(Index: Integer): TPngImage;
begin
  if FIcon32Collection.Count > index  then
  begin
    Result := FIcon32Collection.Items[Index].Icon;
  end
  else
    Result := nil;
end;

procedure TIcon32List.SetIcon(Index: Integer; Value: TPngImage);
begin
  FIcon32Collection.Items[Index].icon := Value;
end;

procedure TIcon32List.SetIcon32Collection(Value: TIcon32Collection);
begin
  FIcon32Collection := Value;
end;

{ TRoleItem }



constructor TRoleItem.Create(Collection: TCollection);
var
  AOwner: TPersistent;
begin
  inherited;
  FMainButtons := TRoleButtonCollection.Create(self);
end;

destructor TRoleItem.Destroy;
var
  i: Integer;
begin
  FreeAndNil(FMainButtons);
  inherited;
end;

function TRoleItem.GetDisplayName: string;
begin
  Result := FRoleNote;
end;

procedure TRoleItem.SetBmp32List(const Value: TIcon32List);
begin
  FBmp32List := Value;
  if (FBmp32List <> nil) and (FPanel <> nil) then
  begin
    FPanel.IconList := FBmp32List;
    FPanel.IconIndex := FBmpIndex;
  end;
end;

procedure TRoleItem.setBmpIndex(const Value: Integer);
begin
  FBmpIndex := Value;
  if (FBmp32List <> nil) and (FPanel <> nil) then
  begin
    FPanel.IconList := FBmp32List;
    FPanel.IconIndex := FBmpIndex;
  end;
end;

procedure TRoleItem.SetMainButtons(const Value: TRoleButtonCollection);
begin
  FMainButtons := Value;
end;

procedure TRoleItem.SetPanel(const Value: TPanelRoles);
begin
  FPanel := Value;
  FPanel.FRole := Self;
  if (FBmp32List <> nil) and (FPanel <> nil) then
  begin
    FPanel.IconList := FBmp32List;
    FPanel.IconIndex := FBmpIndex;
  end;
end;

procedure TRoleItem.SetRoleNote(const Value: string);
begin
  FRoleNote := Value;
  if FPanel <> nil then
  begin
    FPanel.DescrText := FRoleNote
  end;
end;

{ TRoleCollection }

function TRoleCollection.Add: TRoleItem;
begin
  Result := TRoleItem(inherited Add);
end;

constructor TRoleCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRoleItem);
  FOwner := AOwner;
  FPanelViewer := TPanelViewRoles(AOwner);
end;

function TRoleCollection.GetItem(Index: Integer): TRoleItem;
begin
  Result := TRoleItem(inherited GetItem(Index));
end;

function TRoleCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TRoleCollection.SetActivePanel(const Value: TPanelRoles);
var
  i: Integer;
begin
  if FActivePanel <> value then
  begin
    if FActivePanel <> nil then
    begin
      FActivePanel.IsActive := False;
    end;
    FPanelViewer.actCtrls.ActivePanel := '';

    if Value = nil then Exit;
    FActivePanel := Value;
    for i := 0 to Count - 1 do
    begin
      if Items[i].FPanel <> nil then
      begin
        if FActivePanel = Items[i].FPanel then
        begin
          Items[i].FPanel.IsActive := True;
          FPanelViewer.actCtrls.ActivePanel := Items[i].FPanel.Name;
          Exit;
        end;
      end;
    end;
  end ;

end;

procedure TRoleCollection.SetItem(Index: Integer; Value: TRoleItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRoleButtonItem }

constructor TRoleButtonItem.Create(Collection: TCollection);
begin
  inherited;
  FSubButtons := TRoleButtonCollection.Create(self);
end;

destructor TRoleButtonItem.Destroy;
begin
  FreeAndNil(FSubButtons);
  inherited;
end;

function TRoleButtonItem.GetDisplayName: string;
begin
  Result := FDescription;
end;

procedure TRoleButtonItem.SetColorProgres(const Value: TColor);
begin
  FColorProgres := Value;
end;

procedure TRoleButtonItem.SetIconIndex(const Value: integer);
begin
  FIconIndex := Value;
end;

procedure TRoleButtonItem.SetOffsetIcon(const Value: Integer);
begin
  FOffsetIcon := Value;
end;

procedure TRoleButtonItem.SetOnClick(const Value: TNotifyEvent);
begin
  FOnClick := Value;
end;

procedure TRoleButtonItem.SetPosition(const Value: Integer);
begin
  FPosition := Value;
end;

procedure TRoleButtonItem.SetSubButtons(const Value: TRoleButtonCollection);
begin
  FSubButtons := Value;
end;

{ TRoleButtonCollection }

function TRoleButtonCollection.Add: TRoleButtonItem;
begin
  Result := TRoleButtonItem(inherited Add);
end;

constructor TRoleButtonCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRoleButtonItem);
  FOwner := AOwner;
end;

destructor TRoleButtonCollection.destroy;
var
  i: Integer;
begin
  inherited;
end;

function TRoleButtonCollection.GetItem(Index: Integer): TRoleButtonItem;
begin
  Result := TRoleButtonItem(inherited GetItem(Index));
end;

function TRoleButtonCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TRoleButtonCollection.SetItem(Index: Integer; Value: TRoleButtonItem);
begin
  inherited SetItem(Index, Value);
end;

end.
