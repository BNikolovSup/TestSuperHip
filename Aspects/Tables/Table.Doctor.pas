unit Table.Doctor;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, Vcl.StdCtrls;

type
TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

TFindedResult = record
  PropIndex: Word;
  DataPos: Cardinal;
end;

TTeeGRD = class(VCLTee.Grid.TTeeGrid);
TTeeGRDColumn = class(Tee.Grid.Columns.TColumn);


TLogicalDoctor = (
    DOC_ACTIVE,
    DOG_RZOK,
    IS_DOGOVOR_NEOTLOGNA,
    IS_EGN,
    IS_EMERGENCY_CENTER,
    IS_NAET,
    IS_PODVIZHNO_LZ,
    IS_ZAMESTVASHT,
    IS_ );
TlogicalDoctorSet = set of TLogicalDoctor;


TDoctorItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Doctor_EGN
, Doctor_FNAME
, Doctor_ID
, Doctor_LNAME
, Doctor_SNAME
, Doctor_UIN
, Doctor_Logical
);
      TSetProp = set of TPropertyIndex;
      PRecDoctor = ^TRecDoctor;
      TRecDoctor = record
        EGN: AnsiString;
        FNAME: AnsiString;
        ID: integer;
        LNAME: AnsiString;
        SNAME: AnsiString;
        UIN: AnsiString;
        Logical: TlogicalDoctorSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecDoctor;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertDoctor;
    procedure UpdateDoctor;
    procedure SaveDoctor(var dataPosition: Cardinal);
  end;


  TDoctorColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TDoctorItem;
    procedure SetItem(Index: Integer; const Value: TDoctorItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListDoctorSearch: TList<TDoctorItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TDoctorItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Doctor: TDoctorItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Doctor: TDoctorItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TDoctorItem.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TDoctorItem.TPropertyIndex);
    property Items[Index: Integer]: TDoctorItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TDoctorItem }

constructor TDoctorItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TDoctorItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TDoctorItem.InsertDoctor;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDoctor;
  pCardinalData := pointer(PByte(buf));
  FPosMetaData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 4);
  FLenMetaData := pCardinalData^;
  metaPosition :=  FPosMetaData + FLenMetaData;

  pCardinalData := pointer(PByte(buf) + 8);
  FPosData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 12);
  FLenData := pCardinalData^;
  dataPosition :=  FPosData + FLenData;
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion, metaPosition + 4);
  case FVersion of
    0:
    begin
      pWordData := pointer(PByte(buf) + metaPosition);
      pWordData^  := word(CollType);
      pWordData := pointer(PByte(buf) + metaPosition + 2);
      pWordData^  := FVersion;
      inc(metaPosition, 4);
	  Self.DataPos := metaPosition;
	  
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            Doctor_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Doctor_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Doctor_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Doctor_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Doctor_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Doctor_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            Doctor_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          SaveNull(metaPosition);
        end;
      end;
      pCardinalData := pointer(PByte(buf) + 4);
      pCardinalData^  := metaPosition - FPosMetaData;
      pCardinalData := pointer(PByte(buf) + 12);
      pCardinalData^  := dataPosition - FPosData;
    end;
  end;
end;

procedure TDoctorItem.SaveDoctor(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDoctor;
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion);
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          SaveHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            Doctor_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Doctor_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Doctor_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Doctor_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Doctor_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Doctor_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            Doctor_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

procedure TDoctorItem.UpdateDoctor;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDoctor;
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          UpdateHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            Doctor_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Doctor_FNAME: UpdateData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Doctor_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Doctor_LNAME: UpdateData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Doctor_SNAME: UpdateData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Doctor_UIN: UpdateData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

{ TDoctorColl }

function TDoctorColl.AddItem(ver: word): TDoctorItem;
begin
  Result := TDoctorItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TDoctorColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListDoctorSearch := TList<TDoctorItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TDoctorColl.destroy;
begin
  FreeAndNil(ListDoctorSearch);
  inherited;
end;

function TDoctorColl.DisplayName(propIndex: Word): string;
begin
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: Result := 'EGN';
    Doctor_FNAME: Result := 'FNAME';
    Doctor_ID: Result := 'ID';
    Doctor_LNAME: Result := 'LNAME';
    Doctor_SNAME: Result := 'SNAME';
    Doctor_UIN: Result := 'UIN';
    Doctor_Logical: Result := 'Logical';
  end;
end;

procedure TDoctorColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TDoctorItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TDoctorColl.FieldCount: Integer;
begin
  Result := 7;
end;

procedure TDoctorColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Doctor: TDoctorItem;
  ACol: Integer;
  prop: TDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Doctor := Items[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(Doctor.PRecord) and (prop in Doctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Doctor, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Doctor, AValue);
  end;
end;

procedure TDoctorColl.GetCellFromRecord(propIndex: word; Doctor: TDoctorItem; var AValue: String);
var
  str: string;
begin
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: str := (Doctor.PRecord.EGN);
    Doctor_FNAME: str := (Doctor.PRecord.FNAME);
    Doctor_ID: str := inttostr(Doctor.PRecord.ID);
    Doctor_LNAME: str := (Doctor.PRecord.LNAME);
    Doctor_SNAME: str := (Doctor.PRecord.SNAME);
    Doctor_UIN: str := (Doctor.PRecord.UIN);
    Doctor_Logical: str := Doctor.Logical16ToStr(TLogicalData16(Doctor.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TDoctorColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Doctor: TDoctorItem;
  ACol: Integer;
  prop: TDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Doctor := ListDoctorSearch[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(Doctor.PRecord) and (prop in Doctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Doctor, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Doctor, AValue);
  end;
end;

procedure TDoctorColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Doctor: TDoctorItem;
  prop: TDoctorItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Doctor := Items[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(Doctor.PRecord) and (prop in Doctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Doctor, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Doctor, AFieldText);
  end;
end;

procedure TDoctorColl.GetCellFromMap(propIndex: word; ARow: Integer; Doctor: TDoctorItem; var AValue: String);
var
  str: string;
  len: Word;
  int: PInt;
  wrd: PWord;
  bt: PByte;
  pstr: pchar;
  pDbl: PDouble;
  pbl: PBoolean;
begin
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_FNAME: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_ID: str :=  inttostr(Doctor.getIntMap(Self.Buf, Self.posData, propIndex));
    Doctor_LNAME: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_SNAME: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_UIN: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_Logical: str :=  Doctor.Logical32ToStr(Doctor.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TDoctorColl.GetItem(Index: Integer): TDoctorItem;
begin
  Result := TDoctorItem(inherited GetItem(Index));
end;


procedure TDoctorColl.IndexValue(propIndex: TDoctorItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TDoctorItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Doctor_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_FNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Doctor_LNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_SNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_UIN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
    end;
  end;
end;

procedure TDoctorColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Doctor: TDoctorItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Doctor := Items[ARow];
  if not Assigned(Doctor.PRecord) then
  begin
    New(Doctor.PRecord);
    Doctor.PRecord.setProp := [];
   	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TDoctorItem.TPropertyIndex(ACol) of
      Doctor_EGN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Doctor_FNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Doctor_ID: isOld :=  Doctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      Doctor_LNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Doctor_SNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Doctor_UIN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
    if Doctor.PRecord.setProp = [] then
    begin
      Dispose(Doctor.PRecord);
      Doctor.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
  case TDoctorItem.TPropertyIndex(ACol) of
    Doctor_EGN: Doctor.PRecord.EGN := AValue;
    Doctor_FNAME: Doctor.PRecord.FNAME := AValue;
    Doctor_ID: Doctor.PRecord.ID := StrToInt(AValue);
    Doctor_LNAME: Doctor.PRecord.LNAME := AValue;
    Doctor_SNAME: Doctor.PRecord.SNAME := AValue;
    Doctor_UIN: Doctor.PRecord.UIN := AValue;
    Doctor_Logical: Doctor.PRecord.Logical := tlogicalDoctorSet(Doctor.StrToLogical16(AValue));
  end;
end;

procedure TDoctorColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Doctor: TDoctorItem;
begin
  if Count = 0 then Exit;

  Doctor := Items[ARow];
  if not Assigned(Doctor.PRecord) then
  begin
    New(Doctor.PRecord);
    Doctor.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TDoctorItem.TPropertyIndex(ACol) of
      Doctor_EGN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_FNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_ID: isOld :=  Doctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Doctor_LNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_SNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_UIN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
    if Doctor.PRecord.setProp = [] then
    begin
      Dispose(Doctor.PRecord);
      Doctor.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
  case TDoctorItem.TPropertyIndex(ACol) of
    Doctor_EGN: Doctor.PRecord.EGN := AFieldText;
    Doctor_FNAME: Doctor.PRecord.FNAME := AFieldText;
    Doctor_ID: Doctor.PRecord.ID := StrToInt(AFieldText);
    Doctor_LNAME: Doctor.PRecord.LNAME := AFieldText;
    Doctor_SNAME: Doctor.PRecord.SNAME := AFieldText;
    Doctor_UIN: Doctor.PRecord.UIN := AFieldText;
    Doctor_Logical: Doctor.PRecord.Logical := tlogicalDoctorSet(Doctor.StrToLogical16(AFieldText));
  end;
end;

procedure TDoctorColl.SetItem(Index: Integer; const Value: TDoctorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDoctorColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListDoctorSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TDoctorItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Doctor_EGN:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListDoctorSearch.Add(self.Items[i]);
  end;
end;
      Doctor_FNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_LNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_SNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TDoctorColl.ShowGrid(Grid: TTeeGrid);
var
  i: word;
  edtNum: TEdit;
begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCell;
  TVirtualModeData(Grid.Data).OnSetValue:=self.SetCell;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
    //TTeeGRDColumn(Grid.Columns[i]).FRender.
    //TTeeGRD(Grid).ke
    Grid.Columns[i].EditorClass := TNumerEdit;
    //TTeeGRD(Grid).Columns
    //edtNum := TEdit(Grid.Columns[i].EditorClass);
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TDoctorColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDoctorSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDoctorSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TDoctorColl.SortByIndexAnsiString;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while ((Items[I]).IndexAnsiStr1) < ((Items[P]).IndexAnsiStr1) do Inc(I);
        while ((Items[J]).IndexAnsiStr1) > ((Items[P]).IndexAnsiStr1) do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TDoctorColl.SortByIndexInt;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I]).IndexInt < (Items[P]).IndexInt do Inc(I);
        while (Items[J]).IndexInt > (Items[P]).IndexInt do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TDoctorColl.SortByIndexValue(propIndex: TDoctorItem.TPropertyIndex);
begin
  case propIndex of
    Doctor_EGN: SortByIndexAnsiString;
      Doctor_FNAME: SortByIndexAnsiString;
      Doctor_ID: SortByIndexInt;
      Doctor_LNAME: SortByIndexAnsiString;
      Doctor_SNAME: SortByIndexAnsiString;
      Doctor_UIN: SortByIndexAnsiString;
  end;
end;

end.