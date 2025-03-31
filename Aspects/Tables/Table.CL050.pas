unit Table.CL050;

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


TCL050Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (CL050_Key
, CL050_Description
, CL050_Display_Value_BG
, CL050_Display_Value_EN
, CL050_ACHI_Chapter
, CL050_ACHI_Block
, CL050_ACHI_Code
, CL050_NHIF_Code
, CL050_CL048
, CL050_CL006
, CL050_Since
, CL050_Valid_Until
);
      TSetProp = set of TPropertyIndex;
      PRecCL050 = ^TRecCL050;
      TRecCL050 = record
        Key: AnsiString;
        Description: AnsiString;
        Display_Value_BG: AnsiString;
        Display_Value_EN: AnsiString;
        ACHI_Chapter: AnsiString;
        ACHI_Block: AnsiString;
        ACHI_Code: AnsiString;
        NHIF_Code: AnsiString;
        CL048: AnsiString;
        CL006: AnsiString;
        Since: AnsiString;
        Valid_Until: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL050;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL050;
    procedure UpdateCL050;
    procedure SaveCL050(var dataPosition: Cardinal);
  end;


  TCL050Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL050Item;
    procedure SetItem(Index: Integer; const Value: TCL050Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListCL050Search: TList<TCL050Item>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL050Item;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; CL050: TCL050Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL050: TCL050Item; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL050Item.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL050Item.TPropertyIndex);
    property Items[Index: Integer]: TCL050Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TCL050Item }

constructor TCL050Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL050Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL050Item.InsertCL050;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL050;
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
  case FVersion of
    0:
    begin
      pWordData := pointer(PByte(buf) + metaPosition);
      pWordData^  := word(CollType);
      pWordData := pointer(PByte(buf) + metaPosition + 2);
      pWordData^  := FVersion;
      inc(metaPosition, 4);
	  
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            CL050_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL050_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL050_Display_Value_BG: SaveData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL050_Display_Value_EN: SaveData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Chapter: SaveData(PRecord.ACHI_Chapter, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Block: SaveData(PRecord.ACHI_Block, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Code: SaveData(PRecord.ACHI_Code, PropPosition, metaPosition, dataPosition);
            CL050_NHIF_Code: SaveData(PRecord.NHIF_Code, PropPosition, metaPosition, dataPosition);
            CL050_CL048: SaveData(PRecord.CL048, PropPosition, metaPosition, dataPosition);
            CL050_CL006: SaveData(PRecord.CL006, PropPosition, metaPosition, dataPosition);
            CL050_Since: SaveData(PRecord.Since, PropPosition, metaPosition, dataPosition);
            CL050_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TCL050Item.SaveCL050(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL050;
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
            CL050_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL050_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL050_Display_Value_BG: SaveData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL050_Display_Value_EN: SaveData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Chapter: SaveData(PRecord.ACHI_Chapter, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Block: SaveData(PRecord.ACHI_Block, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Code: SaveData(PRecord.ACHI_Code, PropPosition, metaPosition, dataPosition);
            CL050_NHIF_Code: SaveData(PRecord.NHIF_Code, PropPosition, metaPosition, dataPosition);
            CL050_CL048: SaveData(PRecord.CL048, PropPosition, metaPosition, dataPosition);
            CL050_CL006: SaveData(PRecord.CL006, PropPosition, metaPosition, dataPosition);
            CL050_Since: SaveData(PRecord.Since, PropPosition, metaPosition, dataPosition);
            CL050_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TCL050Item.UpdateCL050;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL050;
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
            CL050_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL050_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL050_Display_Value_BG: UpdateData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL050_Display_Value_EN: UpdateData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Chapter: UpdateData(PRecord.ACHI_Chapter, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Block: UpdateData(PRecord.ACHI_Block, PropPosition, metaPosition, dataPosition);
            CL050_ACHI_Code: UpdateData(PRecord.ACHI_Code, PropPosition, metaPosition, dataPosition);
            CL050_NHIF_Code: UpdateData(PRecord.NHIF_Code, PropPosition, metaPosition, dataPosition);
            CL050_CL048: UpdateData(PRecord.CL048, PropPosition, metaPosition, dataPosition);
            CL050_CL006: UpdateData(PRecord.CL006, PropPosition, metaPosition, dataPosition);
            CL050_Since: UpdateData(PRecord.Since, PropPosition, metaPosition, dataPosition);
            CL050_Valid_Until: UpdateData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

{ TCL050Coll }

function TCL050Coll.AddItem(ver: word): TCL050Item;
begin
  Result := TCL050Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TCL050Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListCL050Search := TList<TCL050Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TCL050Coll.destroy;
begin
  FreeAndNil(ListCL050Search);
  inherited;
end;

function TCL050Coll.DisplayName(propIndex: Word): string;
begin
  case TCL050Item.TPropertyIndex(propIndex) of
    CL050_Key: Result := 'Key';
    CL050_Description: Result := 'Description';
    CL050_Display_Value_BG: Result := 'Display_Value_BG';
    CL050_Display_Value_EN: Result := 'DescriptionEn';
    CL050_ACHI_Chapter: Result := 'achi_chapter';
    CL050_ACHI_Block: Result := 'achi_block';
    CL050_ACHI_Code: Result := 'achi_code';
    CL050_NHIF_Code: Result := 'nhif_code';
    CL050_CL048: Result := 'cl048';
    CL050_CL006: Result := 'cl006';
    CL050_Since: Result := 'Since';
    CL050_Valid_Until: Result := 'Valid_Until';
  end;
end;

procedure TCL050Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL050Item.TPropertyIndex(self.FindedRes.PropIndex));
  //Self.SortByIndexValue;
end;

function TCL050Coll.FieldCount: Integer;
begin
  Result := 12;
end;

procedure TCL050Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL050: TCL050Item;
  ACol: Integer;
  prop: TCL050Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL050 := Items[ARow];
  prop := TCL050Item.TPropertyIndex(ACol);
  if Assigned(CL050.PRecord) and (prop in CL050.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL050, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL050, AValue);
  end;
end;

procedure TCL050Coll.GetCellFromRecord(propIndex: word; CL050: TCL050Item; var AValue: String);
var
  str: string;
begin
  case TCL050Item.TPropertyIndex(propIndex) of
    CL050_Key: str := (CL050.PRecord.Key);
    CL050_Description: str := (CL050.PRecord.Description);
    CL050_Display_Value_BG: str := (CL050.PRecord.Display_Value_BG);
    CL050_Display_Value_EN: str := (CL050.PRecord.Display_Value_EN);
    CL050_ACHI_Chapter: str := (CL050.PRecord.ACHI_Chapter);
    CL050_ACHI_Block: str := (CL050.PRecord.ACHI_Block);
    CL050_ACHI_Code: str := (CL050.PRecord.ACHI_Code);
    CL050_NHIF_Code: str := (CL050.PRecord.NHIF_Code);
    CL050_CL048: str := (CL050.PRecord.CL048);
    CL050_CL006: str := (CL050.PRecord.CL006);
    CL050_Since: str := (CL050.PRecord.Since);
    CL050_Valid_Until: str := (CL050.PRecord.Valid_Until);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL050Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL050: TCL050Item;
  ACol: Integer;
  prop: TCL050Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL050 := ListCL050Search[ARow];
  prop := TCL050Item.TPropertyIndex(ACol);
  if Assigned(CL050.PRecord) and (prop in CL050.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL050, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL050, AValue);
  end;
end;

procedure TCL050Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL050: TCL050Item;
  prop: TCL050Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL050 := Items[ARow];
  prop := TCL050Item.TPropertyIndex(ACol);
  if Assigned(CL050.PRecord) and (prop in CL050.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL050, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL050, AFieldText);
  end;
end;

procedure TCL050Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL050: TCL050Item; var AValue: String);
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
  case TCL050Item.TPropertyIndex(propIndex) of
    CL050_Key: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_Description: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_Display_Value_BG: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_Display_Value_EN: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_ACHI_Chapter: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_ACHI_Block: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_ACHI_Code: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_NHIF_Code: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_CL048: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_CL006: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_Since: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL050_Valid_Until: str :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL050Coll.GetItem(Index: Integer): TCL050Item;
begin
  Result := TCL050Item(inherited GetItem(Index));
end;


procedure TCL050Coll.IndexValue(propIndex: TCL050Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL050Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL050_Key:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_Display_Value_BG:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_Display_Value_EN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_ACHI_Chapter:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_ACHI_Block:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_ACHI_Code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_NHIF_Code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_CL048:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_CL006:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_Since:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL050_Valid_Until:
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

procedure TCL050Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL050: TCL050Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL050 := Items[ARow];
  if not Assigned(CL050.PRecord) then
  begin
    New(CL050.PRecord);
    CL050.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL050Item.TPropertyIndex(ACol) of
      CL050_Key: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_Description: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_Display_Value_BG: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_Display_Value_EN: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_ACHI_Chapter: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_ACHI_Block: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_ACHI_Code: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_NHIF_Code: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_CL048: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_CL006: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_Since: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL050_Valid_Until: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL050.PRecord.setProp, TCL050Item.TPropertyIndex(ACol));
    if CL050.PRecord.setProp = [] then
    begin
      Dispose(CL050.PRecord);
      CL050.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL050.PRecord.setProp, TCL050Item.TPropertyIndex(ACol));
  case TCL050Item.TPropertyIndex(ACol) of
    CL050_Key: CL050.PRecord.Key := AValue;
    CL050_Description: CL050.PRecord.Description := AValue;
    CL050_Display_Value_BG: CL050.PRecord.Display_Value_BG := AValue;
    CL050_Display_Value_EN: CL050.PRecord.Display_Value_EN := AValue;
    CL050_ACHI_Chapter: CL050.PRecord.ACHI_Chapter := AValue;
    CL050_ACHI_Block: CL050.PRecord.ACHI_Block := AValue;
    CL050_ACHI_Code: CL050.PRecord.ACHI_Code := AValue;
    CL050_NHIF_Code: CL050.PRecord.NHIF_Code := AValue;
    CL050_CL048: CL050.PRecord.CL048 := AValue;
    CL050_CL006: CL050.PRecord.CL006 := AValue;
    CL050_Since: CL050.PRecord.Since := AValue;
    CL050_Valid_Until: CL050.PRecord.Valid_Until := AValue;
  end;
end;

procedure TCL050Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL050: TCL050Item;
begin
  if Count = 0 then Exit;

  CL050 := Items[ARow];
  if not Assigned(CL050.PRecord) then
  begin
    New(CL050.PRecord);
    CL050.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL050Item.TPropertyIndex(ACol) of
      CL050_Key: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_Description: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_Display_Value_BG: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_Display_Value_EN: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_ACHI_Chapter: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_ACHI_Block: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_ACHI_Code: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_NHIF_Code: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_CL048: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_CL006: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_Since: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL050_Valid_Until: isOld :=  CL050.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL050.PRecord.setProp, TCL050Item.TPropertyIndex(ACol));
    if CL050.PRecord.setProp = [] then
    begin
      Dispose(CL050.PRecord);
      CL050.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL050.PRecord.setProp, TCL050Item.TPropertyIndex(ACol));
  case TCL050Item.TPropertyIndex(ACol) of
    CL050_Key: CL050.PRecord.Key := AFieldText;
    CL050_Description: CL050.PRecord.Description := AFieldText;
    CL050_Display_Value_BG: CL050.PRecord.Display_Value_BG := AFieldText;
    CL050_Display_Value_EN: CL050.PRecord.Display_Value_EN := AFieldText;
    CL050_ACHI_Chapter: CL050.PRecord.ACHI_Chapter := AFieldText;
    CL050_ACHI_Block: CL050.PRecord.ACHI_Block := AFieldText;
    CL050_ACHI_Code: CL050.PRecord.ACHI_Code := AFieldText;
    CL050_NHIF_Code: CL050.PRecord.NHIF_Code := AFieldText;
    CL050_CL048: CL050.PRecord.CL048 := AFieldText;
    CL050_CL006: CL050.PRecord.CL006 := AFieldText;
    CL050_Since: CL050.PRecord.Since := AFieldText;
    CL050_Valid_Until: CL050.PRecord.Valid_Until := AFieldText;
  end;
end;

procedure TCL050Coll.SetItem(Index: Integer; const Value: TCL050Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL050Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL050Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL050Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL050_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL050Search.Add(self.Items[i]);
  end;
end;
      CL050_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_Display_Value_BG:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_Display_Value_EN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_ACHI_Chapter:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_ACHI_Block:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_ACHI_Code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_NHIF_Code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_CL048:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_CL006:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_Since:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
      CL050_Valid_Until:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL050Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL050Coll.ShowGrid(Grid: TTeeGrid);
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

end;

procedure TCL050Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL050Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL050Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL050Coll.SortByIndexAnsiString;
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

procedure TCL050Coll.SortByIndexInt;
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

procedure TCL050Coll.SortByIndexValue(propIndex: TCL050Item.TPropertyIndex);
begin
  case propIndex of
    CL050_Key: SortByIndexAnsiString;
      CL050_Description: SortByIndexAnsiString;
      CL050_Display_Value_BG: SortByIndexAnsiString;
      CL050_Display_Value_EN: SortByIndexAnsiString;
      CL050_ACHI_Chapter: SortByIndexAnsiString;
      CL050_ACHI_Block: SortByIndexAnsiString;
      CL050_ACHI_Code: SortByIndexAnsiString;
      CL050_NHIF_Code: SortByIndexAnsiString;
      CL050_CL048: SortByIndexAnsiString;
      CL050_CL006: SortByIndexAnsiString;
      CL050_Since: SortByIndexAnsiString;
      CL050_Valid_Until: SortByIndexAnsiString;
  end;
end;

end.