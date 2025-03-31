unit VTREditors;

interface
uses
 iniFiles, System.IOUtils, System.Classes, VirtualTrees, VirtualStringTreeHipp,
  Aspects.Types, Vcl.Controls, system.Types, Winapi.Messages, Vcl.StdCtrls, Winapi.Windows,
  Vcl.Mask, Vcl.ComCtrls, Vcl.Graphics, system.SysUtils;//, DBCheckBoxResize, SizeGripMemo;

type

POptionData = ^TOptionData;
  TOptionData = record
    vid: TVtrVid;
    index: Integer;
    ValueType: TValueEditorsType;
    Value: UnicodeString;
    Changed: Boolean;
  end;

  TOptionEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit: TWinControl;        // One of the property editor classes.
    FTree: TVirtualStringTree; // A back reference to the tree calling.
    FNode: PVirtualNode;       // The node being edited.
    FColumn: Integer;          // The column of the node being edited.
  protected
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    destructor Destroy; override;

    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;
  end;

implementation


{ TOptionEditLink }

function TOptionEditLink.BeginEdit: Boolean;
begin
  Result := True;
  FEdit.Show;
  FEdit.SetFocus;
end;

function TOptionEditLink.CancelEdit: Boolean;
begin
  Result := True;
  FEdit.Hide;
end;

destructor TOptionEditLink.Destroy;
begin
  if FEdit.HandleAllocated then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);
  inherited;
end;

procedure TOptionEditLink.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CanAdvance: Boolean;

begin
  CanAdvance := true;

  case Key of
    VK_ESCAPE:
    begin
      Key := 0;//ESC will be handled in EditKeyUp()
    end;
    VK_RETURN:
    begin
      if CanAdvance then
      begin
        FTree.EndEditNode;
        Key := 0;
      end;
    end;

    VK_UP,
    VK_DOWN:
    begin
      // Consider special cases before finishing edit mode.
      CanAdvance := Shift = [];
      if FEdit is TComboBox then
        CanAdvance := CanAdvance and not TComboBox(FEdit).DroppedDown;
      if FEdit is TDateTimePicker then
        CanAdvance :=  CanAdvance and not TDateTimePicker(FEdit).DroppedDown;

      if CanAdvance then
      begin
        // Forward the keypress to the tree. It will asynchronously change the focused node.
        PostMessage(FTree.Handle, WM_KEYDOWN, Key, 0);
        Key := 0;
      end;
    end;
  end;
end;

procedure TOptionEditLink.EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
    begin
      FTree.CancelEditNode;
      Key := 0;
    end;//VK_ESCAPE
  end;//case
end;

function TOptionEditLink.EndEdit: Boolean;
var
  Data: POptionData;
  Buffer: array[0..1024] of Char;
  S: UnicodeString;

begin
  Result := True;

  Data := FNode.GetData();
  if FEdit is TComboBox then
    S := TComboBox(FEdit).Text
  else
  //if FEdit is TDbCheckBoxResizeWin then
//  begin
//    if TDbCheckBoxResizeWin(FEdit).Checked then
//    begin
//      S := 'ДА';
//    end
//    else
//    begin
//      S := 'НЕ';
//    end;
//  end
  //else
  begin
    GetWindowText(FEdit.Handle, Buffer, 1024);
    S := Buffer;
  end;

  if S <> Data.Value then
  begin
    Data.Value := S;
    Data.Changed := True;
    FTree.InvalidateNode(FNode);
  end;
  FEdit.Hide;
  FTree.SetFocus;
end;

function TOptionEditLink.GetBounds: TRect;
begin
  //if FEdit is TDbCheckBoxResizeWin then
//  begin
//    Result := FEdit.BoundsRect;
//    Result.Offset(3, 3);
//    Exit;
//  end;
  Result := FEdit.BoundsRect;
end;

function TOptionEditLink.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  Data: POptionData;

begin
  Result := True;
  FTree := Tree as TVirtualStringTree;
  FNode := Node;
  FColumn := Column;

  FEdit.Free;
  FEdit := nil;
  Data := FTree.GetNodeData(node);
  case Data.ValueType of
    vetString:
      begin
        FEdit := TEdit.Create(nil);
        with FEdit as TEdit do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data.Value;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
        end;
      end;
    vetPickString:
      begin
        FEdit := TComboBox.Create(nil);
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data.Value;
          Items.Add(Text);
          Items.Add('нещо1');
          Items.Add('нещо2');
          Items.Add('нещо3');
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
        end;
      end;
    vetNumber:
      begin
        FEdit := TMaskEdit.Create(nil);
        with FEdit as TMaskEdit do
        begin
          Visible := False;
          Parent := Tree;
          EditMask := '9999';
          Text := Data.Value;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
        end;
      end;
    vetPickNumber:
      begin
        FEdit := TComboBox.Create(nil);
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data.Value;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
        end;
      end;
    vetMemo:
      begin
        //FEdit := TSizeGripMemo.Create(nil);
//        with FEdit as TSizeGripMemo do
//        begin
//          Visible := False;
//          Parent := Tree;
//          Text := Data.Value;
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//          FNode.NodeHeight := 150;
//        end;
      end;
    vetDate:
      begin
        FEdit := TDateTimePicker.Create(nil);
        with FEdit as TDateTimePicker do
        begin
          Visible := False;
          Parent := Tree;
          CalColors.MonthBackColor := clWindow;
          CalColors.TextColor := clBlack;
          CalColors.TitleBackColor := clBtnShadow;
          CalColors.TitleTextColor := clBlack;
          CalColors.TrailingTextColor := clBtnFace;
          Date := StrToDate(Data.Value);
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
        end;
      end;
    vetCheck:
      begin
        //FEdit := TDbCheckBoxResizeWin.Create(nil);
//        with FEdit as TDbCheckBoxResizeWin do
//        begin
//          Visible := False;
//          Parent := Tree;
//          OwnerDraw := false;
//          //State := cbGrayed;
//          //OnKeyDown := EditKeyDown;
//          //OnKeyUp := EditKeyUp;
//        end;
      end;
  else
    Result := False;
  end;
end;

procedure TOptionEditLink.ProcessMessage(var Message: TMessage);
begin
  FEdit.WindowProc(Message);
end;

procedure TOptionEditLink.SetBounds(R: TRect);
var
  Dummy: Integer;
begin
  FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  FEdit.BoundsRect := R;
  //if FEdit is TDbCheckBoxResizeWin then
//  begin
//    FEdit.Height := FEdit.Height - 10;
//    FEdit.Width := FEdit.Height;
//  end;
end;

end.
