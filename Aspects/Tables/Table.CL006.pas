unit Table.CL006;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control;


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


TCL006Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL006_Key
, CL006_Description
, CL006_DescriptionEn
, CL006_nhif_code
, CL006_clinical_speciality
, CL006_nhif_name
, CL006_role
);
	  
      TSetProp = set of TPropertyIndex;
      PRecCL006 = ^TRecCL006;
      TRecCL006 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        nhif_code: AnsiString;
        clinical_speciality: AnsiString;
        nhif_name: AnsiString;
        role: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL006;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL006;
    procedure UpdateCL006;
    procedure SaveCL006(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TCL006Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL006Item;
    procedure SetItem(Index: Integer; const Value: TCL006Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL006Item;
	ListForFDB: TList<TCL006Item>;
    ListCL006Search: TList<TCL006Item>;
	PRecordSearch: ^TCL006Item.TRecCL006;
    ArrPropSearch: TArray<TCL006Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL006Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL006Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL006: TCL006Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL006: TCL006Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL006Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL006Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL006Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL006Item.TPropertyIndex);
    property Items[Index: Integer]: TCL006Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);

  end;

implementation

{ TCL006Item }

constructor TCL006Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL006Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL006Item.InsertCL006;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL006;
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
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toInsert, FVersion, metaPosition + 4);
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
            CL006_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL006_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL006_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL006_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL006_clinical_speciality: SaveData(PRecord.clinical_speciality, PropPosition, metaPosition, dataPosition);
            CL006_nhif_name: SaveData(PRecord.nhif_name, PropPosition, metaPosition, dataPosition);
            CL006_role: SaveData(PRecord.role, PropPosition, metaPosition, dataPosition);
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

function  TCL006Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL006Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL006Item;
begin
  Result := True;
  for i := 0 to Length(TCL006Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL006Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL006Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL006_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL006_Key), cot);
            CL006_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL006_Description), cot);
            CL006_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL006_DescriptionEn), cot);
            CL006_nhif_code: Result := IsFinded(ATempItem.PRecord.nhif_code, buf, FPosDataADB, word(CL006_nhif_code), cot);
            CL006_clinical_speciality: Result := IsFinded(ATempItem.PRecord.clinical_speciality, buf, FPosDataADB, word(CL006_clinical_speciality), cot);
            CL006_nhif_name: Result := IsFinded(ATempItem.PRecord.nhif_name, buf, FPosDataADB, word(CL006_nhif_name), cot);
            CL006_role: Result := IsFinded(ATempItem.PRecord.role, buf, FPosDataADB, word(CL006_role), cot);
      end;
    end;
  end;
end;

procedure TCL006Item.SaveCL006(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL006;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, dataPosition);
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
            CL006_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL006_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL006_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL006_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL006_clinical_speciality: SaveData(PRecord.clinical_speciality, PropPosition, metaPosition, dataPosition);
            CL006_nhif_name: SaveData(PRecord.nhif_name, PropPosition, metaPosition, dataPosition);
            CL006_role: SaveData(PRecord.role, PropPosition, metaPosition, dataPosition);
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

procedure TCL006Item.UpdateCL006;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL006;
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
            CL006_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL006_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL006_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL006_nhif_code: UpdateData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL006_clinical_speciality: UpdateData(PRecord.clinical_speciality, PropPosition, metaPosition, dataPosition);
            CL006_nhif_name: UpdateData(PRecord.nhif_name, PropPosition, metaPosition, dataPosition);
            CL006_role: UpdateData(PRecord.role, PropPosition, metaPosition, dataPosition);
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

{ TCL006Coll }

function TCL006Coll.AddItem(ver: word): TCL006Item;
begin
  Result := TCL006Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL006Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL006Item;
begin
  ItemForSearch := TCL006Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL006Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL006Item.Create(nil);
  ListCL006Search := TList<TCL006Item>.Create;
  ListForFDB := TList<TCL006Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL006Coll.destroy;
begin
  FreeAndNil(ListCL006Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL006Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL006Item.TPropertyIndex(propIndex) of
    CL006_Key: Result := 'Key';
    CL006_Description: Result := 'Description';
    CL006_DescriptionEn: Result := 'DescriptionEn';
    CL006_nhif_code: Result := 'nhif_code';
    CL006_clinical_speciality: Result := 'clinical_speciality';
    CL006_nhif_name: Result := 'nhif_name';
    CL006_role: Result := 'role';
  end;
end;



function TCL006Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 7;
end;

procedure TCL006Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL006: TCL006Item;
  ACol: Integer;
  prop: TCL006Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL006 := Items[ARow];
  prop := TCL006Item.TPropertyIndex(ACol);
  if Assigned(CL006.PRecord) and (prop in CL006.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL006, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL006, AValue);
  end;
end;

procedure TCL006Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL006Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TCL006Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL006Coll.GetCellFromRecord(propIndex: word; CL006: TCL006Item; var AValue: String);
var
  str: string;
begin
  case TCL006Item.TPropertyIndex(propIndex) of
    CL006_Key: str := (CL006.PRecord.Key);
    CL006_Description: str := (CL006.PRecord.Description);
    CL006_DescriptionEn: str := (CL006.PRecord.DescriptionEn);
    CL006_nhif_code: str := (CL006.PRecord.nhif_code);
    CL006_clinical_speciality: str := (CL006.PRecord.clinical_speciality);
    CL006_nhif_name: str := (CL006.PRecord.nhif_name);
    CL006_role: str := (CL006.PRecord.role);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL006Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL006Item;
  ACol: Integer;
  prop: TCL006Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL006Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL006Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL006Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL006Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL006Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL006: TCL006Item;
  ACol: Integer;
  prop: TCL006Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL006 := ListCL006Search[ARow];
  prop := TCL006Item.TPropertyIndex(ACol);
  if Assigned(CL006.PRecord) and (prop in CL006.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL006, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL006, AValue);
  end;
end;

procedure TCL006Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL006: TCL006Item;
  prop: TCL006Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL006 := Items[ARow];
  prop := TCL006Item.TPropertyIndex(ACol);
  if Assigned(CL006.PRecord) and (prop in CL006.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL006, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL006, AFieldText);
  end;
end;

procedure TCL006Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL006: TCL006Item; var AValue: String);
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
  case TCL006Item.TPropertyIndex(propIndex) of
    CL006_Key: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL006_Description: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL006_DescriptionEn: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL006_nhif_code: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL006_clinical_speciality: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL006_nhif_name: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL006_role: str :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL006Coll.GetItem(Index: Integer): TCL006Item;
begin
  Result := TCL006Item(inherited GetItem(Index));
end;


procedure TCL006Coll.IndexValue(propIndex: TCL006Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL006Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL006_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL006_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL006_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL006_nhif_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL006_clinical_speciality:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL006_nhif_name:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL006_role:
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

procedure TCL006Coll.IndexValueListNodes(propIndex: TCL006Item.TPropertyIndex);
begin

end;

procedure TCL006Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL006Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL006Item.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(field, -1, Tempitem, value);
    Tempitem.Free;
  end
  else
  begin
    Tempitem := Self.Items[index];
    if Assigned(Tempitem.PRecord) then
    begin
      GetCellFromRecord(field, Tempitem, value);
    end
    else
    begin
      GetCellFromMap(field, index, Tempitem, value);
    end;
  end;
end;


function TCL006Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL006Item.TPropertyIndex(propIndex) of
    CL006_Key: Result := actAnsiString;
    CL006_Description: Result := actAnsiString;
    CL006_DescriptionEn: Result := actAnsiString;
    CL006_nhif_code: Result := actAnsiString;
    CL006_clinical_speciality: Result := actAnsiString;
    CL006_nhif_name: Result := actAnsiString;
    CL006_role: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL006Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL006: TCL006Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL006 := Items[ARow];
  if not Assigned(CL006.PRecord) then
  begin
    New(CL006.PRecord);
    CL006.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL006Item.TPropertyIndex(ACol) of
      CL006_Key: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL006_Description: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL006_DescriptionEn: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL006_nhif_code: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL006_clinical_speciality: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL006_nhif_name: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL006_role: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL006.PRecord.setProp, TCL006Item.TPropertyIndex(ACol));
    if CL006.PRecord.setProp = [] then
    begin
      Dispose(CL006.PRecord);
      CL006.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL006.PRecord.setProp, TCL006Item.TPropertyIndex(ACol));
  case TCL006Item.TPropertyIndex(ACol) of
    CL006_Key: CL006.PRecord.Key := AValue;
    CL006_Description: CL006.PRecord.Description := AValue;
    CL006_DescriptionEn: CL006.PRecord.DescriptionEn := AValue;
    CL006_nhif_code: CL006.PRecord.nhif_code := AValue;
    CL006_clinical_speciality: CL006.PRecord.clinical_speciality := AValue;
    CL006_nhif_name: CL006.PRecord.nhif_name := AValue;
    CL006_role: CL006.PRecord.role := AValue;
  end;
end;

procedure TCL006Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL006: TCL006Item;
begin
  if Count = 0 then Exit;

  CL006 := Items[ARow];
  if not Assigned(CL006.PRecord) then
  begin
    New(CL006.PRecord);
    CL006.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL006Item.TPropertyIndex(ACol) of
      CL006_Key: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL006_Description: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL006_DescriptionEn: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL006_nhif_code: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL006_clinical_speciality: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL006_nhif_name: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL006_role: isOld :=  CL006.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL006.PRecord.setProp, TCL006Item.TPropertyIndex(ACol));
    if CL006.PRecord.setProp = [] then
    begin
      Dispose(CL006.PRecord);
      CL006.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL006.PRecord.setProp, TCL006Item.TPropertyIndex(ACol));
  case TCL006Item.TPropertyIndex(ACol) of
    CL006_Key: CL006.PRecord.Key := AFieldText;
    CL006_Description: CL006.PRecord.Description := AFieldText;
    CL006_DescriptionEn: CL006.PRecord.DescriptionEn := AFieldText;
    CL006_nhif_code: CL006.PRecord.nhif_code := AFieldText;
    CL006_clinical_speciality: CL006.PRecord.clinical_speciality := AFieldText;
    CL006_nhif_name: CL006.PRecord.nhif_name := AFieldText;
    CL006_role: CL006.PRecord.role := AFieldText;
  end;
end;

procedure TCL006Coll.SetItem(Index: Integer; const Value: TCL006Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL006Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL006Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL006Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL006_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL006Search.Add(self.Items[i]);
  end;
end;
      CL006_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL006Search.Add(self.Items[i]);
        end;
      end;
      CL006_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL006Search.Add(self.Items[i]);
        end;
      end;
      CL006_nhif_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL006Search.Add(self.Items[i]);
        end;
      end;
      CL006_clinical_speciality:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL006Search.Add(self.Items[i]);
        end;
      end;
      CL006_nhif_name:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL006Search.Add(self.Items[i]);
        end;
      end;
      CL006_role:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL006Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL006Coll.ShowGrid(Grid: TTeeGrid);
var
  i: word;

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
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL006Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL006Item>);
var
  i: word;

begin
  ListForFDB := LST;
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, LST.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellList;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL006Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL006Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL006Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
end;

procedure TCL006Coll.SortByIndexAnsiString;
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

procedure TCL006Coll.SortByIndexInt;
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

procedure TCL006Coll.SortByIndexWord;
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
        while (Items[I]).IndexWord < (Items[P]).IndexWord do Inc(I);
        while (Items[J]).IndexWord > (Items[P]).IndexWord do Dec(J);
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

procedure TCL006Coll.SortByIndexValue(propIndex: TCL006Item.TPropertyIndex);
begin
  case propIndex of
    CL006_Key: SortByIndexAnsiString;
      CL006_Description: SortByIndexAnsiString;
      CL006_DescriptionEn: SortByIndexAnsiString;
      CL006_nhif_code: SortByIndexAnsiString;
      CL006_clinical_speciality: SortByIndexAnsiString;
      CL006_nhif_name: SortByIndexAnsiString;
      CL006_role: SortByIndexAnsiString;
  end;
end;

end.