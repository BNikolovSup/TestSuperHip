unit Table.CL022;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees;

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


TCL022Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL022_Key
, CL022_Description
, CL022_DescriptionEn
, CL022_achi_code
, CL022_nhif_package
, CL022_achi_chapter
, CL022_nhif_code
, CL022_achi_block
);
	  
      TSetProp = set of TPropertyIndex;
      PRecCL022 = ^TRecCL022;
      TRecCL022 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        achi_code: AnsiString;
        nhif_package: AnsiString;
        achi_chapter: AnsiString;
        nhif_code: AnsiString;
        achi_block: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL022;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL022;
    procedure UpdateCL022;
    procedure SaveCL022(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TCL022Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL022Item;
    procedure SetItem(Index: Integer; const Value: TCL022Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL022Item;
	ListForFDB: TList<TCL022Item>;
    ListCL022Search: TList<TCL022Item>;
	PRecordSearch: ^TCL022Item.TRecCL022;
    ArrPropSearch: TArray<TCL022Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL022Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL022Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL022: TCL022Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL022: TCL022Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL022Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL022Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL022Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL022Item.TPropertyIndex);
    property Items[Index: Integer]: TCL022Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    
  end;

implementation

{ TCL022Item }

constructor TCL022Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL022Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL022Item.InsertCL022;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL022;
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
            CL022_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL022_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL022_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL022_achi_code: SaveData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL022_nhif_package: SaveData(PRecord.nhif_package, PropPosition, metaPosition, dataPosition);
            CL022_achi_chapter: SaveData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL022_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_block: SaveData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
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

function  TCL022Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL022Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL022Item;
begin
  Result := True;
  for i := 0 to Length(TCL022Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL022Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL022Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL022_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL022_Key), cot);
            CL022_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL022_Description), cot);
            CL022_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL022_DescriptionEn), cot);
            CL022_achi_code: Result := IsFinded(ATempItem.PRecord.achi_code, buf, FPosDataADB, word(CL022_achi_code), cot);
            CL022_nhif_package: Result := IsFinded(ATempItem.PRecord.nhif_package, buf, FPosDataADB, word(CL022_nhif_package), cot);
            CL022_achi_chapter: Result := IsFinded(ATempItem.PRecord.achi_chapter, buf, FPosDataADB, word(CL022_achi_chapter), cot);
            CL022_nhif_code: Result := IsFinded(ATempItem.PRecord.nhif_code, buf, FPosDataADB, word(CL022_nhif_code), cot);
            CL022_achi_block: Result := IsFinded(ATempItem.PRecord.achi_block, buf, FPosDataADB, word(CL022_achi_block), cot);
      end;
    end;
  end;
end;

procedure TCL022Item.SaveCL022(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL022;
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
            CL022_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL022_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL022_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL022_achi_code: SaveData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL022_nhif_package: SaveData(PRecord.nhif_package, PropPosition, metaPosition, dataPosition);
            CL022_achi_chapter: SaveData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL022_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_block: SaveData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
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

procedure TCL022Item.UpdateCL022;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL022;
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
            CL022_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL022_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL022_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL022_achi_code: UpdateData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL022_nhif_package: UpdateData(PRecord.nhif_package, PropPosition, metaPosition, dataPosition);
            CL022_achi_chapter: UpdateData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL022_nhif_code: UpdateData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_block: UpdateData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
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

{ TCL022Coll }

function TCL022Coll.AddItem(ver: word): TCL022Item;
begin
  Result := TCL022Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL022Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL022Item;
begin
  ItemForSearch := TCL022Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL022Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL022Item.Create(nil);
  ListCL022Search := TList<TCL022Item>.Create;
  ListForFDB := TList<TCL022Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL022Coll.destroy;
begin
  FreeAndNil(ListCL022Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL022Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: Result := 'Key';
    CL022_Description: Result := 'Description';
    CL022_DescriptionEn: Result := 'DescriptionEn';
    CL022_achi_code: Result := 'achi_code';
    CL022_nhif_package: Result := 'nhif_package';
    CL022_achi_chapter: Result := 'achi_chapter';
    CL022_nhif_code: Result := 'nhif_code';
    CL022_achi_block: Result := 'achi_block';
  end;
end;

procedure TCL022Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  self.IndexValue(TCL022Item.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TCL022Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 8;
end;

procedure TCL022Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL022: TCL022Item;
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL022 := Items[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(CL022.PRecord) and (prop in CL022.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL022, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL022, AValue);
  end;
end;

procedure TCL022Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TCL022Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL022Coll.GetCellFromRecord(propIndex: word; CL022: TCL022Item; var AValue: String);
var
  str: string;
begin
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: str := (CL022.PRecord.Key);
    CL022_Description: str := (CL022.PRecord.Description);
    CL022_DescriptionEn: str := (CL022.PRecord.DescriptionEn);
    CL022_achi_code: str := (CL022.PRecord.achi_code);
    CL022_nhif_package: str := (CL022.PRecord.nhif_package);
    CL022_achi_chapter: str := (CL022.PRecord.achi_chapter);
    CL022_nhif_code: str := (CL022.PRecord.nhif_code);
    CL022_achi_block: str := (CL022.PRecord.achi_block);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL022Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL022Item;
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL022Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL022Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL022Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL022: TCL022Item;
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL022 := ListCL022Search[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(CL022.PRecord) and (prop in CL022.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL022, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL022, AValue);
  end;
end;

procedure TCL022Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL022: TCL022Item;
  prop: TCL022Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL022 := Items[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(CL022.PRecord) and (prop in CL022.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL022, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL022, AFieldText);
  end;
end;

procedure TCL022Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL022: TCL022Item; var AValue: String);
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
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_Description: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_DescriptionEn: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_achi_code: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_nhif_package: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_achi_chapter: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_nhif_code: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_achi_block: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL022Coll.GetItem(Index: Integer): TCL022Item;
begin
  Result := TCL022Item(inherited GetItem(Index));
end;


procedure TCL022Coll.IndexValue(propIndex: TCL022Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL022Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL022_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL022_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_achi_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_nhif_package:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_achi_chapter:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_nhif_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_achi_block:
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

procedure TCL022Coll.IndexValueListNodes(propIndex: TCL022Item.TPropertyIndex);
begin

end;

procedure TCL022Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL022Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL022Item.Create(nil);
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



function TCL022Coll.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: Result := actAnsiString;
    CL022_Description: Result := actAnsiString;
    CL022_DescriptionEn: Result := actAnsiString;
    CL022_achi_code: Result := actAnsiString;
    CL022_nhif_package: Result := actAnsiString;
    CL022_achi_chapter: Result := actAnsiString;
    CL022_nhif_code: Result := actAnsiString;
    CL022_achi_block: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL022Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL022: TCL022Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL022 := Items[ARow];
  if not Assigned(CL022.PRecord) then
  begin
    New(CL022.PRecord);
    CL022.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL022Item.TPropertyIndex(ACol) of
      CL022_Key: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_Description: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_DescriptionEn: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_achi_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_nhif_package: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_achi_chapter: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_nhif_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_achi_block: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
    if CL022.PRecord.setProp = [] then
    begin
      Dispose(CL022.PRecord);
      CL022.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
  case TCL022Item.TPropertyIndex(ACol) of
    CL022_Key: CL022.PRecord.Key := AValue;
    CL022_Description: CL022.PRecord.Description := AValue;
    CL022_DescriptionEn: CL022.PRecord.DescriptionEn := AValue;
    CL022_achi_code: CL022.PRecord.achi_code := AValue;
    CL022_nhif_package: CL022.PRecord.nhif_package := AValue;
    CL022_achi_chapter: CL022.PRecord.achi_chapter := AValue;
    CL022_nhif_code: CL022.PRecord.nhif_code := AValue;
    CL022_achi_block: CL022.PRecord.achi_block := AValue;
  end;
end;

procedure TCL022Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL022: TCL022Item;
begin
  if Count = 0 then Exit;

  CL022 := Items[ARow];
  if not Assigned(CL022.PRecord) then
  begin
    New(CL022.PRecord);
    CL022.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL022Item.TPropertyIndex(ACol) of
      CL022_Key: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_Description: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_DescriptionEn: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_achi_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_nhif_package: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_achi_chapter: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_nhif_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_achi_block: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
    if CL022.PRecord.setProp = [] then
    begin
      Dispose(CL022.PRecord);
      CL022.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
  case TCL022Item.TPropertyIndex(ACol) of
    CL022_Key: CL022.PRecord.Key := AFieldText;
    CL022_Description: CL022.PRecord.Description := AFieldText;
    CL022_DescriptionEn: CL022.PRecord.DescriptionEn := AFieldText;
    CL022_achi_code: CL022.PRecord.achi_code := AFieldText;
    CL022_nhif_package: CL022.PRecord.nhif_package := AFieldText;
    CL022_achi_chapter: CL022.PRecord.achi_chapter := AFieldText;
    CL022_nhif_code: CL022.PRecord.nhif_code := AFieldText;
    CL022_achi_block: CL022.PRecord.achi_block := AFieldText;
  end;
end;

procedure TCL022Coll.SetItem(Index: Integer; const Value: TCL022Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL022Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL022Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL022Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL022_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL022Search.Add(self.Items[i]);
  end;
end;
      CL022_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_achi_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_nhif_package:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_achi_chapter:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_nhif_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_achi_block:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL022Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL022Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL022Item>);
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

procedure TCL022Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL022Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL022Search.Count]);

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

procedure TCL022Coll.SortByIndexAnsiString;
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

procedure TCL022Coll.SortByIndexInt;
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

procedure TCL022Coll.SortByIndexWord;
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

procedure TCL022Coll.SortByIndexValue(propIndex: TCL022Item.TPropertyIndex);
begin
  case propIndex of
    CL022_Key: SortByIndexAnsiString;
      CL022_Description: SortByIndexAnsiString;
      CL022_DescriptionEn: SortByIndexAnsiString;
      CL022_achi_code: SortByIndexAnsiString;
      CL022_nhif_package: SortByIndexAnsiString;
      CL022_achi_chapter: SortByIndexAnsiString;
      CL022_nhif_code: SortByIndexAnsiString;
      CL022_achi_block: SortByIndexAnsiString;
  end;
end;

end.