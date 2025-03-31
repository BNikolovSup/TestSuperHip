unit Table.Procedures;

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


TProceduresItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
Procedures_ARTICLE_147
, Procedures_CODE
, Procedures_EFFECTIVE
, Procedures_FIZIO_GROUP
, Procedures_HI_EQUIPMENT
, Procedures_HI_REQUIREMENTS
, Procedures_HI_SPECIALIZED
, Procedures_ID
, Procedures_IS_EXAM_TYPE
, Procedures_IS_HOSPITAL
, Procedures_KSMP
, Procedures_NAME
, Procedures_PACKAGE_ID
, Procedures_PRICE
);
	  
      TSetProp = set of TPropertyIndex;
      PRecProcedures = ^TRecProcedures;
      TRecProcedures = record
        ARTICLE_147: boolean;
        CODE: AnsiString;
        EFFECTIVE: boolean;
        FIZIO_GROUP: word;
        HI_EQUIPMENT: AnsiString;
        HI_REQUIREMENTS: AnsiString;
        HI_SPECIALIZED: boolean;
        ID: integer;
        IS_EXAM_TYPE: boolean;
        IS_HOSPITAL: boolean;
        KSMP: AnsiString;
        NAME: AnsiString;
        PACKAGE_ID: integer;
        PRICE: double;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecProcedures;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertProcedures;
    procedure UpdateProcedures;
    procedure SaveProcedures(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TProceduresColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TProceduresItem;
    procedure SetItem(Index: Integer; const Value: TProceduresItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TProceduresItem;
	ListForFDB: TList<TProceduresItem>;
    ListProceduresSearch: TList<TProceduresItem>;
	PRecordSearch: ^TProceduresItem.TRecProcedures;
    ArrPropSearch: TArray<TProceduresItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TProceduresItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TProceduresItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Procedures: TProceduresItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Procedures: TProceduresItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TProceduresItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TProceduresItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TProceduresItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TProceduresItem.TPropertyIndex);
    property Items[Index: Integer]: TProceduresItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    //procedure OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//    procedure OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
//    procedure OnSetTextSearchCnk(Chk: TCheckBoxDyn);
    //procedure OnSetTextSearchLog(Log: TlogicalProceduresSet);
  end;

implementation

{ TProceduresItem }

constructor TProceduresItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TProceduresItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TProceduresItem.InsertProcedures;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctProcedures;
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
            Procedures_ARTICLE_147: SaveData(PRecord.ARTICLE_147, PropPosition, metaPosition, dataPosition);
            Procedures_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Procedures_EFFECTIVE: SaveData(PRecord.EFFECTIVE, PropPosition, metaPosition, dataPosition);
            Procedures_FIZIO_GROUP: SaveData(PRecord.FIZIO_GROUP, PropPosition, metaPosition, dataPosition);
            Procedures_HI_EQUIPMENT: SaveData(PRecord.HI_EQUIPMENT, PropPosition, metaPosition, dataPosition);
            Procedures_HI_REQUIREMENTS: SaveData(PRecord.HI_REQUIREMENTS, PropPosition, metaPosition, dataPosition);
            Procedures_HI_SPECIALIZED: SaveData(PRecord.HI_SPECIALIZED, PropPosition, metaPosition, dataPosition);
            Procedures_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Procedures_IS_EXAM_TYPE: SaveData(PRecord.IS_EXAM_TYPE, PropPosition, metaPosition, dataPosition);
            Procedures_IS_HOSPITAL: SaveData(PRecord.IS_HOSPITAL, PropPosition, metaPosition, dataPosition);
            Procedures_KSMP: SaveData(PRecord.KSMP, PropPosition, metaPosition, dataPosition);
            Procedures_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Procedures_PACKAGE_ID: SaveData(PRecord.PACKAGE_ID, PropPosition, metaPosition, dataPosition);
            Procedures_PRICE: SaveData(PRecord.PRICE, PropPosition, metaPosition, dataPosition);
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

function  TProceduresItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TProceduresItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TProceduresItem;
begin
  Result := True;
  for i := 0 to Length(TProceduresColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TProceduresColl(coll).ArrPropSearchClc[i];
	ATempItem := TProceduresColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
            Procedures_ARTICLE_147: Result := IsFinded(ATempItem.PRecord.ARTICLE_147, buf, FPosDataADB, word(Procedures_ARTICLE_147), cot);
            Procedures_CODE: Result := IsFinded(ATempItem.PRecord.CODE, buf, FPosDataADB, word(Procedures_CODE), cot);
            Procedures_EFFECTIVE: Result := IsFinded(ATempItem.PRecord.EFFECTIVE, buf, FPosDataADB, word(Procedures_EFFECTIVE), cot);
            Procedures_FIZIO_GROUP: Result := IsFinded(ATempItem.PRecord.FIZIO_GROUP, buf, FPosDataADB, word(Procedures_FIZIO_GROUP), cot);
            Procedures_HI_EQUIPMENT: Result := IsFinded(ATempItem.PRecord.HI_EQUIPMENT, buf, FPosDataADB, word(Procedures_HI_EQUIPMENT), cot);
            Procedures_HI_REQUIREMENTS: Result := IsFinded(ATempItem.PRecord.HI_REQUIREMENTS, buf, FPosDataADB, word(Procedures_HI_REQUIREMENTS), cot);
            Procedures_HI_SPECIALIZED: Result := IsFinded(ATempItem.PRecord.HI_SPECIALIZED, buf, FPosDataADB, word(Procedures_HI_SPECIALIZED), cot);
            Procedures_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(Procedures_ID), cot);
            Procedures_IS_EXAM_TYPE: Result := IsFinded(ATempItem.PRecord.IS_EXAM_TYPE, buf, FPosDataADB, word(Procedures_IS_EXAM_TYPE), cot);
            Procedures_IS_HOSPITAL: Result := IsFinded(ATempItem.PRecord.IS_HOSPITAL, buf, FPosDataADB, word(Procedures_IS_HOSPITAL), cot);
            Procedures_KSMP: Result := IsFinded(ATempItem.PRecord.KSMP, buf, FPosDataADB, word(Procedures_KSMP), cot);
            Procedures_NAME: Result := IsFinded(ATempItem.PRecord.NAME, buf, FPosDataADB, word(Procedures_NAME), cot);
            Procedures_PACKAGE_ID: Result := IsFinded(ATempItem.PRecord.PACKAGE_ID, buf, FPosDataADB, word(Procedures_PACKAGE_ID), cot);
            Procedures_PRICE: Result := IsFinded(ATempItem.PRecord.PRICE, buf, FPosDataADB, word(Procedures_PRICE), cot);
      end;
    end;
  end;
end;

procedure TProceduresItem.SaveProcedures(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctProcedures;
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
            Procedures_ARTICLE_147: SaveData(PRecord.ARTICLE_147, PropPosition, metaPosition, dataPosition);
            Procedures_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Procedures_EFFECTIVE: SaveData(PRecord.EFFECTIVE, PropPosition, metaPosition, dataPosition);
            Procedures_FIZIO_GROUP: SaveData(PRecord.FIZIO_GROUP, PropPosition, metaPosition, dataPosition);
            Procedures_HI_EQUIPMENT: SaveData(PRecord.HI_EQUIPMENT, PropPosition, metaPosition, dataPosition);
            Procedures_HI_REQUIREMENTS: SaveData(PRecord.HI_REQUIREMENTS, PropPosition, metaPosition, dataPosition);
            Procedures_HI_SPECIALIZED: SaveData(PRecord.HI_SPECIALIZED, PropPosition, metaPosition, dataPosition);
            Procedures_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Procedures_IS_EXAM_TYPE: SaveData(PRecord.IS_EXAM_TYPE, PropPosition, metaPosition, dataPosition);
            Procedures_IS_HOSPITAL: SaveData(PRecord.IS_HOSPITAL, PropPosition, metaPosition, dataPosition);
            Procedures_KSMP: SaveData(PRecord.KSMP, PropPosition, metaPosition, dataPosition);
            Procedures_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Procedures_PACKAGE_ID: SaveData(PRecord.PACKAGE_ID, PropPosition, metaPosition, dataPosition);
            Procedures_PRICE: SaveData(PRecord.PRICE, PropPosition, metaPosition, dataPosition);
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

procedure TProceduresItem.UpdateProcedures;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctProcedures;
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
            Procedures_ARTICLE_147: UpdateData(PRecord.ARTICLE_147, PropPosition, metaPosition, dataPosition);
            Procedures_CODE: UpdateData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Procedures_EFFECTIVE: UpdateData(PRecord.EFFECTIVE, PropPosition, metaPosition, dataPosition);
            Procedures_FIZIO_GROUP: UpdateData(PRecord.FIZIO_GROUP, PropPosition, metaPosition, dataPosition);
            Procedures_HI_EQUIPMENT: UpdateData(PRecord.HI_EQUIPMENT, PropPosition, metaPosition, dataPosition);
            Procedures_HI_REQUIREMENTS: UpdateData(PRecord.HI_REQUIREMENTS, PropPosition, metaPosition, dataPosition);
            Procedures_HI_SPECIALIZED: UpdateData(PRecord.HI_SPECIALIZED, PropPosition, metaPosition, dataPosition);
            Procedures_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Procedures_IS_EXAM_TYPE: UpdateData(PRecord.IS_EXAM_TYPE, PropPosition, metaPosition, dataPosition);
            Procedures_IS_HOSPITAL: UpdateData(PRecord.IS_HOSPITAL, PropPosition, metaPosition, dataPosition);
            Procedures_KSMP: UpdateData(PRecord.KSMP, PropPosition, metaPosition, dataPosition);
            Procedures_NAME: UpdateData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Procedures_PACKAGE_ID: UpdateData(PRecord.PACKAGE_ID, PropPosition, metaPosition, dataPosition);
            Procedures_PRICE: UpdateData(PRecord.PRICE, PropPosition, metaPosition, dataPosition);
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

{ TProceduresColl }

function TProceduresColl.AddItem(ver: word): TProceduresItem;
begin
  Result := TProceduresItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TProceduresColl.AddItemForSearch: Integer;
var
  ItemForSearch: TProceduresItem;
begin
  ItemForSearch := TProceduresItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TProceduresColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TProceduresItem.Create(nil);
  ListProceduresSearch := TList<TProceduresItem>.Create;
  ListForFDB := TList<TProceduresItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TProceduresColl.destroy;
begin
  FreeAndNil(ListProceduresSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TProceduresColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_ARTICLE_147: Result := 'ARTICLE_147';
    Procedures_CODE: Result := 'CODE';
    Procedures_EFFECTIVE: Result := 'EFFECTIVE';
    Procedures_FIZIO_GROUP: Result := 'FIZIO_GROUP';
    Procedures_HI_EQUIPMENT: Result := 'HI_EQUIPMENT';
    Procedures_HI_REQUIREMENTS: Result := 'HI_REQUIREMENTS';
    Procedures_HI_SPECIALIZED: Result := 'HI_SPECIALIZED';
    Procedures_ID: Result := 'ID';
    Procedures_IS_EXAM_TYPE: Result := 'IS_EXAM_TYPE';
    Procedures_IS_HOSPITAL: Result := 'IS_HOSPITAL';
    Procedures_KSMP: Result := 'KSMP';
    Procedures_NAME: Result := 'NAME';
    Procedures_PACKAGE_ID: Result := 'PACKAGE_ID';
    Procedures_PRICE: Result := 'PRICE';
  end;
end;

procedure TProceduresColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TProceduresItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TProceduresColl.FieldCount: Integer; 
begin
  inherited;
  Result := 14;
end;

procedure TProceduresColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Procedures: TProceduresItem;
  ACol: Integer;
  prop: TProceduresItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Procedures := Items[ARow];
  prop := TProceduresItem.TPropertyIndex(ACol);
  if Assigned(Procedures.PRecord) and (prop in Procedures.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Procedures, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Procedures, AValue);
  end;
end;

procedure TProceduresColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TProceduresItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TProceduresItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TProceduresColl.GetCellFromRecord(propIndex: word; Procedures: TProceduresItem; var AValue: String);
var
  str: string;
begin
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_ARTICLE_147: str := BoolToStr(Procedures.PRecord.ARTICLE_147, True);
    Procedures_CODE: str := (Procedures.PRecord.CODE);
    Procedures_EFFECTIVE: str := BoolToStr(Procedures.PRecord.EFFECTIVE, True);
    Procedures_FIZIO_GROUP: str := inttostr(Procedures.PRecord.FIZIO_GROUP);
    Procedures_HI_EQUIPMENT: str := (Procedures.PRecord.HI_EQUIPMENT);
    Procedures_HI_REQUIREMENTS: str := (Procedures.PRecord.HI_REQUIREMENTS);
    Procedures_HI_SPECIALIZED: str := BoolToStr(Procedures.PRecord.HI_SPECIALIZED, True);
    Procedures_ID: str := inttostr(Procedures.PRecord.ID);
    Procedures_IS_EXAM_TYPE: str := BoolToStr(Procedures.PRecord.IS_EXAM_TYPE, True);
    Procedures_IS_HOSPITAL: str := BoolToStr(Procedures.PRecord.IS_HOSPITAL, True);
    Procedures_KSMP: str := (Procedures.PRecord.KSMP);
    Procedures_NAME: str := (Procedures.PRecord.NAME);
    Procedures_PACKAGE_ID: str := inttostr(Procedures.PRecord.PACKAGE_ID);
    Procedures_PRICE: str := FloatToStr(Procedures.PRecord.PRICE);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TProceduresColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TProceduresItem;
  ACol: Integer;
  prop: TProceduresItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TProceduresItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TProceduresColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TProceduresItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TProceduresItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TProceduresColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Procedures: TProceduresItem;
  ACol: Integer;
  prop: TProceduresItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Procedures := ListProceduresSearch[ARow];
  prop := TProceduresItem.TPropertyIndex(ACol);
  if Assigned(Procedures.PRecord) and (prop in Procedures.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Procedures, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Procedures, AValue);
  end;
end;

procedure TProceduresColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Procedures: TProceduresItem;
  prop: TProceduresItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Procedures := Items[ARow];
  prop := TProceduresItem.TPropertyIndex(ACol);
  if Assigned(Procedures.PRecord) and (prop in Procedures.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Procedures, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Procedures, AFieldText);
  end;
end;

procedure TProceduresColl.GetCellFromMap(propIndex: word; ARow: Integer; Procedures: TProceduresItem; var AValue: String);
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
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_ARTICLE_147: str :=  BoolToStr(Procedures.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Procedures_CODE: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_EFFECTIVE: str :=  BoolToStr(Procedures.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Procedures_FIZIO_GROUP: str :=  inttostr(Procedures.getWordMap(Self.Buf, Self.posData, propIndex));
    Procedures_HI_EQUIPMENT: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_HI_REQUIREMENTS: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_HI_SPECIALIZED: str :=  BoolToStr(Procedures.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Procedures_ID: str :=  inttostr(Procedures.getIntMap(Self.Buf, Self.posData, propIndex));
    Procedures_IS_EXAM_TYPE: str :=  BoolToStr(Procedures.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Procedures_IS_HOSPITAL: str :=  BoolToStr(Procedures.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Procedures_KSMP: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_NAME: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_PACKAGE_ID: str :=  inttostr(Procedures.getIntMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TProceduresColl.GetItem(Index: Integer): TProceduresItem;
begin
  Result := TProceduresItem(inherited GetItem(Index));
end;


procedure TProceduresColl.IndexValue(propIndex: TProceduresItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TProceduresItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Procedures_CODE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Procedures_FIZIO_GROUP: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Procedures_HI_EQUIPMENT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Procedures_HI_REQUIREMENTS:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Procedures_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Procedures_KSMP:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Procedures_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Procedures_PACKAGE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TProceduresColl.IndexValueListNodes(propIndex: TProceduresItem.TPropertyIndex);
begin

end;

procedure TProceduresColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TProceduresItem;
begin
  if index < 0 then
  begin
    Tempitem := TProceduresItem.Create(nil);
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

//procedure TProceduresColl.OnSetTextSearchCnk(Chk: TCheckBoxDyn);
//begin
// // if Chk.sta then
//
//end;

//procedure TProceduresColl.OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
//begin
//  if dtEdt.Date = 0 then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TProceduresItem.TPropertyIndex(dtEdt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TProceduresItem.TPropertyIndex(dtEdt.Field));
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  case TProceduresItem.TPropertyIndex(dtEdt.Field) of
//    Procedures_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := dtEdt.Date;
//  end;
//end;
//
//procedure TProceduresColl.OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//begin
//  if edt.Text = '' then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TProceduresItem.TPropertyIndex(edt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TProceduresItem.TPropertyIndex(edt.Field));
//    //ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  if cotSens in edt.Condition then
//  begin
//    case TProceduresItem.TPropertyIndex(edt.Field) of
//      Procedures_EGN: ListForFDB[0].PRecord.EGN  := edt.Text;
//      Procedures_FNAME: ListForFDB[0].PRecord.FNAME  := edt.Text;
//      Procedures_SNAME: ListForFDB[0].PRecord.SNAME  := edt.Text;
//      Procedures_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //Procedures_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end
//  else
//  begin
//    case TProceduresItem.TPropertyIndex(edt.Field) of
//      Procedures_EGN: ListForFDB[0].PRecord.EGN  := AnsiUpperCase(edt.Text);
//      Procedures_FNAME: ListForFDB[0].PRecord.FNAME  := AnsiUpperCase(edt.Text);
//      Procedures_SNAME: ListForFDB[0].PRecord.SNAME  := AnsiUpperCase(edt.Text);
//      Procedures_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //Procedures_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end;
//end;

//procedure TProceduresColl.OnSetTextSearchLog(Log: TlogicalProceduresSet);
//begin
//  ListForFDB[0].PRecord.Logical := Log;
//end;

function TProceduresColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_ARTICLE_147: Result := actBool;
    Procedures_CODE: Result := actAnsiString;
    Procedures_EFFECTIVE: Result := actBool;
    Procedures_FIZIO_GROUP: Result := actword;
    Procedures_HI_EQUIPMENT: Result := actAnsiString;
    Procedures_HI_REQUIREMENTS: Result := actAnsiString;
    Procedures_HI_SPECIALIZED: Result := actBool;
    Procedures_ID: Result := actinteger;
    Procedures_IS_EXAM_TYPE: Result := actBool;
    Procedures_IS_HOSPITAL: Result := actBool;
    Procedures_KSMP: Result := actAnsiString;
    Procedures_NAME: Result := actAnsiString;
    Procedures_PACKAGE_ID: Result := actinteger;
    Procedures_PRICE: Result := actdouble;
  else
    Result := actNone;
  end
end;

procedure TProceduresColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Procedures: TProceduresItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Procedures := Items[ARow];
  if not Assigned(Procedures.PRecord) then
  begin
    New(Procedures.PRecord);
    Procedures.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TProceduresItem.TPropertyIndex(ACol) of
      Procedures_ARTICLE_147: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Procedures_CODE: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_EFFECTIVE: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Procedures_FIZIO_GROUP: isOld :=  Procedures.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Procedures_HI_EQUIPMENT: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_HI_REQUIREMENTS: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_HI_SPECIALIZED: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Procedures_ID: isOld :=  Procedures.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Procedures_IS_EXAM_TYPE: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Procedures_IS_HOSPITAL: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Procedures_KSMP: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_NAME: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_PACKAGE_ID: isOld :=  Procedures.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Procedures.PRecord.setProp, TProceduresItem.TPropertyIndex(ACol));
    if Procedures.PRecord.setProp = [] then
    begin
      Dispose(Procedures.PRecord);
      Procedures.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Procedures.PRecord.setProp, TProceduresItem.TPropertyIndex(ACol));
  case TProceduresItem.TPropertyIndex(ACol) of
    Procedures_ARTICLE_147: Procedures.PRecord.ARTICLE_147 := StrToBool(AValue);
    Procedures_CODE: Procedures.PRecord.CODE := AValue;
    Procedures_EFFECTIVE: Procedures.PRecord.EFFECTIVE := StrToBool(AValue);
    Procedures_FIZIO_GROUP: Procedures.PRecord.FIZIO_GROUP := StrToInt(AValue);
    Procedures_HI_EQUIPMENT: Procedures.PRecord.HI_EQUIPMENT := AValue;
    Procedures_HI_REQUIREMENTS: Procedures.PRecord.HI_REQUIREMENTS := AValue;
    Procedures_HI_SPECIALIZED: Procedures.PRecord.HI_SPECIALIZED := StrToBool(AValue);
    Procedures_ID: Procedures.PRecord.ID := StrToInt(AValue);
    Procedures_IS_EXAM_TYPE: Procedures.PRecord.IS_EXAM_TYPE := StrToBool(AValue);
    Procedures_IS_HOSPITAL: Procedures.PRecord.IS_HOSPITAL := StrToBool(AValue);
    Procedures_KSMP: Procedures.PRecord.KSMP := AValue;
    Procedures_NAME: Procedures.PRecord.NAME := AValue;
    Procedures_PACKAGE_ID: Procedures.PRecord.PACKAGE_ID := StrToInt(AValue);
    Procedures_PRICE: Procedures.PRecord.PRICE := StrToFloat(AValue);
  end;
end;

procedure TProceduresColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Procedures: TProceduresItem;
begin
  if Count = 0 then Exit;

  Procedures := Items[ARow];
  if not Assigned(Procedures.PRecord) then
  begin
    New(Procedures.PRecord);
    Procedures.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TProceduresItem.TPropertyIndex(ACol) of
      Procedures_ARTICLE_147: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Procedures_CODE: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_EFFECTIVE: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Procedures_FIZIO_GROUP: isOld :=  Procedures.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Procedures_HI_EQUIPMENT: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_HI_REQUIREMENTS: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_HI_SPECIALIZED: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Procedures_ID: isOld :=  Procedures.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Procedures_IS_EXAM_TYPE: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Procedures_IS_HOSPITAL: isOld :=  Procedures.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Procedures_KSMP: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_NAME: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_PACKAGE_ID: isOld :=  Procedures.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Procedures.PRecord.setProp, TProceduresItem.TPropertyIndex(ACol));
    if Procedures.PRecord.setProp = [] then
    begin
      Dispose(Procedures.PRecord);
      Procedures.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Procedures.PRecord.setProp, TProceduresItem.TPropertyIndex(ACol));
  case TProceduresItem.TPropertyIndex(ACol) of
    Procedures_ARTICLE_147: Procedures.PRecord.ARTICLE_147 := StrToBool(AFieldText);
    Procedures_CODE: Procedures.PRecord.CODE := AFieldText;
    Procedures_EFFECTIVE: Procedures.PRecord.EFFECTIVE := StrToBool(AFieldText);
    Procedures_FIZIO_GROUP: Procedures.PRecord.FIZIO_GROUP := StrToInt(AFieldText);
    Procedures_HI_EQUIPMENT: Procedures.PRecord.HI_EQUIPMENT := AFieldText;
    Procedures_HI_REQUIREMENTS: Procedures.PRecord.HI_REQUIREMENTS := AFieldText;
    Procedures_HI_SPECIALIZED: Procedures.PRecord.HI_SPECIALIZED := StrToBool(AFieldText);
    Procedures_ID: Procedures.PRecord.ID := StrToInt(AFieldText);
    Procedures_IS_EXAM_TYPE: Procedures.PRecord.IS_EXAM_TYPE := StrToBool(AFieldText);
    Procedures_IS_HOSPITAL: Procedures.PRecord.IS_HOSPITAL := StrToBool(AFieldText);
    Procedures_KSMP: Procedures.PRecord.KSMP := AFieldText;
    Procedures_NAME: Procedures.PRecord.NAME := AFieldText;
    Procedures_PACKAGE_ID: Procedures.PRecord.PACKAGE_ID := StrToInt(AFieldText);
    Procedures_PRICE: Procedures.PRecord.PRICE := StrToFloat(AFieldText);
  end;
end;

procedure TProceduresColl.SetItem(Index: Integer; const Value: TProceduresItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TProceduresColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListProceduresSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TProceduresItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Procedures_CODE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_FIZIO_GROUP: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_HI_EQUIPMENT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_HI_REQUIREMENTS:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_KSMP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
      Procedures_PACKAGE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListProceduresSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TProceduresColl.ShowGrid(Grid: TTeeGrid);
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

procedure TProceduresColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TProceduresItem>);
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

procedure TProceduresColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListProceduresSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListProceduresSearch.Count]);

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

procedure TProceduresColl.SortByIndexAnsiString;
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

procedure TProceduresColl.SortByIndexInt;
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

procedure TProceduresColl.SortByIndexWord;
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

procedure TProceduresColl.SortByIndexValue(propIndex: TProceduresItem.TPropertyIndex);
begin
  case propIndex of
    Procedures_CODE: SortByIndexAnsiString;
      Procedures_FIZIO_GROUP: SortByIndexWord;
      Procedures_HI_EQUIPMENT: SortByIndexAnsiString;
      Procedures_HI_REQUIREMENTS: SortByIndexAnsiString;
      Procedures_ID: SortByIndexInt;
      Procedures_KSMP: SortByIndexAnsiString;
      Procedures_NAME: SortByIndexAnsiString;
      Procedures_PACKAGE_ID: SortByIndexInt;
  end;
end;

end.