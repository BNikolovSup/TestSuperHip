unit Table.OtherDoctor;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults;

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

TLogicalOtherDoctor = (
    IS_Sender,
    IS_Consultant,
    IS_Colege);
TlogicalOtherDoctorSet = set of TLogicalOtherDoctor;


TOtherDoctorItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       OtherDoctor_FNAME
       , OtherDoctor_ID
       , OtherDoctor_LNAME
       , OtherDoctor_KOD_RAJON
       , OtherDoctor_KOD_RZOK
       , OtherDoctor_NOMER_LZ
       , OtherDoctor_NZOK_NOMER
       , OtherDoctor_SNAME
       , OtherDoctor_SPECIALITY
       , OtherDoctor_UIN
       , OtherDoctor_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecOtherDoctor = ^TRecOtherDoctor;
      TRecOtherDoctor = record
        FNAME: AnsiString;
        ID: integer;
        LNAME: AnsiString;
        KOD_RAJON: integer;
        KOD_RZOK: integer;
        NOMER_LZ: AnsiString;
        NZOK_NOMER: AnsiString;
        SNAME: AnsiString;
        SPECIALITY: integer;
        UIN: AnsiString;
        Logical: TlogicalOtherDoctorSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecOtherDoctor;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertOtherDoctor;
    procedure UpdateOtherDoctor;
    procedure SaveOtherDoctor(var dataPosition: Cardinal)overload;
	procedure SaveOtherDoctor(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TOtherDoctorColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TOtherDoctorItem;
    function GetItem(Index: Integer): TOtherDoctorItem;
    procedure SetItem(Index: Integer; const Value: TOtherDoctorItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TOtherDoctorItem>;
    ListOtherDoctorSearch: TList<TOtherDoctorItem>;
	PRecordSearch: ^TOtherDoctorItem.TRecOtherDoctor;
    ArrPropSearch: TArray<TOtherDoctorItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TOtherDoctorItem.TPropertyIndex>;
	VisibleColl: TOtherDoctorItem.TSetProp;
	ArrayPropOrder: TArray<TOtherDoctorItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TOtherDoctorItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; OtherDoctor: TOtherDoctorItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; OtherDoctor: TOtherDoctorItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TOtherDoctorItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function DisplayLogicalName(flagIndex: Integer): string;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode; override;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TOtherDoctorItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TOtherDoctorItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TOtherDoctorItem.TPropertyIndex);
    property Items[Index: Integer]: TOtherDoctorItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalOtherDoctorSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TOtherDoctorItem }

constructor TOtherDoctorItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TOtherDoctorItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TOtherDoctorItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
var
  paramField: TParamProp;
  setPropPat: TSetProp;
  i: Integer;
  PropertyIndex: TPropertyIndex;
begin
  i := 0;
  for paramField in SetOfProp do
  begin
    PropertyIndex := TPropertyIndex(byte(paramField));
    Include(Self.PRecord.setProp, PropertyIndex);
    //case PropertyIndex of
      //PatientNew_EGN: Self.PRecord.EGN := arrstr[i];
    //end;
    inc(i);
  end;
end;

function TOtherDoctorItem.GetCollType: TCollectionsType;
begin
  Result := ctOtherDoctor;
end;

function TOtherDoctorItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TOtherDoctorItem.InsertOtherDoctor;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctOtherDoctor;
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
            OtherDoctor_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            OtherDoctor_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_KOD_RAJON: SaveData(PRecord.KOD_RAJON, PropPosition, metaPosition, dataPosition);
            OtherDoctor_KOD_RZOK: SaveData(PRecord.KOD_RZOK, PropPosition, metaPosition, dataPosition);
            OtherDoctor_NOMER_LZ: SaveData(PRecord.NOMER_LZ, PropPosition, metaPosition, dataPosition);
            OtherDoctor_NZOK_NOMER: SaveData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            OtherDoctor_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_SPECIALITY: SaveData(PRecord.SPECIALITY, PropPosition, metaPosition, dataPosition);
            OtherDoctor_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            OtherDoctor_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TOtherDoctorItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TOtherDoctorItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TOtherDoctorItem;
begin
  Result := True;
  for i := 0 to Length(TOtherDoctorColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TOtherDoctorColl(coll).ArrPropSearchClc[i];
	ATempItem := TOtherDoctorColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        OtherDoctor_FNAME: Result := IsFinded(ATempItem.PRecord.FNAME, buf, FPosDataADB, word(OtherDoctor_FNAME), cot);
            OtherDoctor_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(OtherDoctor_ID), cot);
            OtherDoctor_LNAME: Result := IsFinded(ATempItem.PRecord.LNAME, buf, FPosDataADB, word(OtherDoctor_LNAME), cot);
            OtherDoctor_KOD_RAJON: Result := IsFinded(ATempItem.PRecord.KOD_RAJON, buf, FPosDataADB, word(OtherDoctor_KOD_RAJON), cot);
            OtherDoctor_KOD_RZOK: Result := IsFinded(ATempItem.PRecord.KOD_RZOK, buf, FPosDataADB, word(OtherDoctor_KOD_RZOK), cot);
            OtherDoctor_NOMER_LZ: Result := IsFinded(ATempItem.PRecord.NOMER_LZ, buf, FPosDataADB, word(OtherDoctor_NOMER_LZ), cot);
            OtherDoctor_NZOK_NOMER: Result := IsFinded(ATempItem.PRecord.NZOK_NOMER, buf, FPosDataADB, word(OtherDoctor_NZOK_NOMER), cot);
            OtherDoctor_SNAME: Result := IsFinded(ATempItem.PRecord.SNAME, buf, FPosDataADB, word(OtherDoctor_SNAME), cot);
            OtherDoctor_SPECIALITY: Result := IsFinded(ATempItem.PRecord.SPECIALITY, buf, FPosDataADB, word(OtherDoctor_SPECIALITY), cot);
            OtherDoctor_UIN: Result := IsFinded(ATempItem.PRecord.UIN, buf, FPosDataADB, word(OtherDoctor_UIN), cot);
            OtherDoctor_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(OtherDoctor_Logical), cot);
      end;
    end;
  end;
end;

procedure TOtherDoctorItem.SaveOtherDoctor(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveOtherDoctor(dataPosition);
end;

procedure TOtherDoctorItem.SaveOtherDoctor(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctOtherDoctor;
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
            OtherDoctor_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            OtherDoctor_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_KOD_RAJON: SaveData(PRecord.KOD_RAJON, PropPosition, metaPosition, dataPosition);
            OtherDoctor_KOD_RZOK: SaveData(PRecord.KOD_RZOK, PropPosition, metaPosition, dataPosition);
            OtherDoctor_NOMER_LZ: SaveData(PRecord.NOMER_LZ, PropPosition, metaPosition, dataPosition);
            OtherDoctor_NZOK_NOMER: SaveData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            OtherDoctor_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_SPECIALITY: SaveData(PRecord.SPECIALITY, PropPosition, metaPosition, dataPosition);
            OtherDoctor_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            OtherDoctor_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TOtherDoctorItem.UpdateOtherDoctor;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctOtherDoctor;
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
            OtherDoctor_FNAME: UpdateData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            OtherDoctor_LNAME: UpdateData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_KOD_RAJON: UpdateData(PRecord.KOD_RAJON, PropPosition, metaPosition, dataPosition);
            OtherDoctor_KOD_RZOK: UpdateData(PRecord.KOD_RZOK, PropPosition, metaPosition, dataPosition);
            OtherDoctor_NOMER_LZ: UpdateData(PRecord.NOMER_LZ, PropPosition, metaPosition, dataPosition);
            OtherDoctor_NZOK_NOMER: UpdateData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            OtherDoctor_SNAME: UpdateData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            OtherDoctor_SPECIALITY: UpdateData(PRecord.SPECIALITY, PropPosition, metaPosition, dataPosition);
            OtherDoctor_UIN: UpdateData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
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

{ TOtherDoctorColl }

function TOtherDoctorColl.AddItem(ver: word): TOtherDoctorItem;
begin
  Result := TOtherDoctorItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TOtherDoctorColl.AddItemForSearch: Integer;
var
  ItemForSearch: TOtherDoctorItem;
begin
  ItemForSearch := TOtherDoctorItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TOtherDoctorColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
var
  run: PVirtualNode;
  data: PAspRec;
begin
  VisibleColl := [];

  run := RootNode.FirstChild;
  while run <> nil do
  begin
    data := PAspRec(PByte(run) + lenNode);

    if run.CheckState = csCheckedNormal then
      Include(VisibleColl, TOtherDoctorItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TOtherDoctorColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvOtherDoctorRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
  linkOptions.AddNewNode(vvOptionSearchGrid, 0, Result , amAddChildLast, vOptionSearchGrid, linkPos);
  linkOptions.AddNewNode(vvOptionSearchCot, 0, Result , amAddChildLast, vOptionSearchCOT, linkPos);

  vOptionSearchGrid.CheckType := ctTriStateCheckBox;

  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i + 1;
	  run.CheckType := ctCheckBox;
      run.CheckState := csCheckedNormal;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;  
end;

procedure TOtherDoctorColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TOtherDoctorItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (OtherDoctor_FNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.FNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(OtherDoctor_FNAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(OtherDoctor_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_LNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.LNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(OtherDoctor_LNAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_KOD_RAJON in tempItem.PRecord.setProp) and (tempItem.PRecord.KOD_RAJON <> Self.getIntMap(tempItem.DataPos, word(OtherDoctor_KOD_RAJON))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_KOD_RZOK in tempItem.PRecord.setProp) and (tempItem.PRecord.KOD_RZOK <> Self.getIntMap(tempItem.DataPos, word(OtherDoctor_KOD_RZOK))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_NOMER_LZ in tempItem.PRecord.setProp) and (tempItem.PRecord.NOMER_LZ <> Self.getAnsiStringMap(tempItem.DataPos, word(OtherDoctor_NOMER_LZ))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_NZOK_NOMER in tempItem.PRecord.setProp) and (tempItem.PRecord.NZOK_NOMER <> Self.getAnsiStringMap(tempItem.DataPos, word(OtherDoctor_NZOK_NOMER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_SNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.SNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(OtherDoctor_SNAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_SPECIALITY in tempItem.PRecord.setProp) and (tempItem.PRecord.SPECIALITY <> Self.getIntMap(tempItem.DataPos, word(OtherDoctor_SPECIALITY))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_UIN in tempItem.PRecord.setProp) and (tempItem.PRecord.UIN <> Self.getAnsiStringMap(tempItem.DataPos, word(OtherDoctor_UIN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (OtherDoctor_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(OtherDoctor_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TOtherDoctorColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TOtherDoctorItem.Create(nil);
  ListOtherDoctorSearch := TList<TOtherDoctorItem>.Create;
  ListForFinder := TList<TOtherDoctorItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TOtherDoctorColl.destroy;
begin
  FreeAndNil(ListOtherDoctorSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TOtherDoctorColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TOtherDoctorItem.TPropertyIndex(propIndex) of
    OtherDoctor_FNAME: Result := 'FNAME';
    OtherDoctor_ID: Result := 'ID';
    OtherDoctor_LNAME: Result := 'LNAME';
    OtherDoctor_KOD_RAJON: Result := 'KOD_RAJON';
    OtherDoctor_KOD_RZOK: Result := 'KOD_RZOK';
    OtherDoctor_NOMER_LZ: Result := 'NOMER_LZ';
    OtherDoctor_NZOK_NOMER: Result := 'NZOK_NOMER';
    OtherDoctor_SNAME: Result := 'SNAME';
    OtherDoctor_SPECIALITY: Result := 'SPECIALITY';
    OtherDoctor_UIN: Result := 'UIN';
    OtherDoctor_Logical: Result := 'Logical';
  end;
end;

function TOtherDoctorColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IS_Sender';
    1: Result := 'IS_Consultant';
    2: Result := 'IS_Colege';
  else
    Result := '???';
  end;
end;


procedure TOtherDoctorColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
var
  FieldCollOptionNode, run: PVirtualNode;
  pSource, pTarget: PVirtualNode;
begin
  inherited;
  if linkOptions = nil then Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionGridNode;
  run := FieldCollOptionNode.FirstChild;
  pSource := nil;
  pTarget := nil;
  while run <> nil do
  begin
    if run.Index = NewPos - 1 then
    begin
      pTarget := run;
    end;
    if run.index = OldPos - 1 then
    begin
      pSource := run;
    end;
    run := run.NextSibling;
  end;

  if pTarget = nil then Exit;
  if pSource = nil then Exit;
  //ShowMessage(Format('pSource = %d, pTarget = %d', [pSource.Index, pTarget.Index]));
  if pSource.Index < pTarget.Index then
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertAfter, False);
  end
  else
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertBefore, False);
  end;
  run := FieldCollOptionNode.FirstChild;
  while run <> nil do
  begin
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end; 
end;


function TOtherDoctorColl.FieldCount: Integer; 
begin
  inherited;
  Result := 11;
end;

function TOtherDoctorColl.FindRootCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  PosLinkData: Cardinal;
  Run: PVirtualNode;
  data: PAspRec;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(linkOptions.Buf));
  PosLinkData := pCardinalData^;

  while linkPos <= PosLinkData do
  begin
    Run := pointer(PByte(linkOptions.Buf) + linkpos);
    data := Pointer(PByte(Run)+ lenNode);
    if data.vid = vvOtherDoctorRoot then
    begin
      Result := Run;
	  data := Pointer(PByte(Result)+ lenNode);
      data.DataPos := Cardinal(Self);
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
  if Result <> nil then
  begin
    data := Pointer(PByte(Result)+ lenNode);
    data.DataPos := Cardinal(Self);
  end;
end;

function TOtherDoctorColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchCot: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TOtherDoctorColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();

  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TOtherDoctorColl.FindSearchFieldCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  run, vOptionSearchGrid, vOptionSearchCOT, vRootPregOptions: PVirtualNode;
  i: Integer;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  if vRootPregOptions = nil then
    vRootPregOptions := CreateRootCollOptionNode;
  vOptionSearchGrid := nil;
  vOptionSearchCOT := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: vOptionSearchGrid := run;
      vvOptionSearchCot: vOptionSearchCOT := run;
    end;

    run := run.NextSibling;
  end;
  if vOptionSearchGrid = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchGrid, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;
  if vOptionSearchCOT = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchCot, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;

  Result := vOptionSearchGrid;
  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;
end;

procedure TOtherDoctorColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  OtherDoctor: TOtherDoctorItem;
  ACol: Integer;
  prop: TOtherDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  OtherDoctor := Items[ARow];
  prop := TOtherDoctorItem.TPropertyIndex(ACol);
  if Assigned(OtherDoctor.PRecord) and (prop in OtherDoctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, OtherDoctor, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, OtherDoctor, AValue);
  end;
end;

procedure TOtherDoctorColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TOtherDoctorItem.TPropertyIndex;
begin
  inherited;
 
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;
  try
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;

  GetCellFromMap(ArrayPropOrderSearchOptions[AColumn.Index], RowSelect, TempItem, AValue);
end;

procedure TOtherDoctorColl.GetCellFromRecord(propIndex: word; OtherDoctor: TOtherDoctorItem; var AValue: String);
var
  str: string;
begin
  case TOtherDoctorItem.TPropertyIndex(propIndex) of
    OtherDoctor_FNAME: str := (OtherDoctor.PRecord.FNAME);
    OtherDoctor_ID: str := inttostr(OtherDoctor.PRecord.ID);
    OtherDoctor_LNAME: str := (OtherDoctor.PRecord.LNAME);
    OtherDoctor_KOD_RAJON: str := inttostr(OtherDoctor.PRecord.KOD_RAJON);
    OtherDoctor_KOD_RZOK: str := inttostr(OtherDoctor.PRecord.KOD_RZOK);
    OtherDoctor_NOMER_LZ: str := (OtherDoctor.PRecord.NOMER_LZ);
    OtherDoctor_NZOK_NOMER: str := (OtherDoctor.PRecord.NZOK_NOMER);
    OtherDoctor_SNAME: str := (OtherDoctor.PRecord.SNAME);
    OtherDoctor_SPECIALITY: str := inttostr(OtherDoctor.PRecord.SPECIALITY);
    OtherDoctor_UIN: str := (OtherDoctor.PRecord.UIN);
    OtherDoctor_Logical: str := OtherDoctor.Logical08ToStr(TLogicalData08(OtherDoctor.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TOtherDoctorColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TOtherDoctorItem;
  ACol: Integer;
  prop: TOtherDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TOtherDoctorItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TOtherDoctorColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TOtherDoctorItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TOtherDoctorItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TOtherDoctorColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  OtherDoctor: TOtherDoctorItem;
  ACol: Integer;
  prop: TOtherDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  OtherDoctor := ListOtherDoctorSearch[ARow];
  prop := TOtherDoctorItem.TPropertyIndex(ACol);
  if Assigned(OtherDoctor.PRecord) and (prop in OtherDoctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, OtherDoctor, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, OtherDoctor, AValue);
  end;
end;

function TOtherDoctorColl.GetCollType: TCollectionsType;
begin
  Result := ctOtherDoctor;
end;

function TOtherDoctorColl.GetCollDelType: TCollectionsType;
begin
  Result := ctOtherDoctorDel;
end;

procedure TOtherDoctorColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  OtherDoctor: TOtherDoctorItem;
  prop: TOtherDoctorItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  OtherDoctor := Items[ARow];
  prop := TOtherDoctorItem.TPropertyIndex(ACol);
  if Assigned(OtherDoctor.PRecord) and (prop in OtherDoctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, OtherDoctor, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, OtherDoctor, AFieldText);
  end;
end;

procedure TOtherDoctorColl.GetCellFromMap(propIndex: word; ARow: Integer; OtherDoctor: TOtherDoctorItem; var AValue: String);
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
  case TOtherDoctorItem.TPropertyIndex(propIndex) of
    OtherDoctor_FNAME: str :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    OtherDoctor_ID: str :=  inttostr(OtherDoctor.getIntMap(Self.Buf, Self.posData, propIndex));
    OtherDoctor_LNAME: str :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    OtherDoctor_KOD_RAJON: str :=  inttostr(OtherDoctor.getIntMap(Self.Buf, Self.posData, propIndex));
    OtherDoctor_KOD_RZOK: str :=  inttostr(OtherDoctor.getIntMap(Self.Buf, Self.posData, propIndex));
    OtherDoctor_NOMER_LZ: str :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    OtherDoctor_NZOK_NOMER: str :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    OtherDoctor_SNAME: str :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    OtherDoctor_SPECIALITY: str :=  inttostr(OtherDoctor.getIntMap(Self.Buf, Self.posData, propIndex));
    OtherDoctor_UIN: str :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    OtherDoctor_Logical: str :=  OtherDoctor.Logical08ToStr(OtherDoctor.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TOtherDoctorColl.GetItem(Index: Integer): TOtherDoctorItem;
begin
  Result := TOtherDoctorItem(inherited GetItem(Index));
end;


procedure TOtherDoctorColl.IndexValue(propIndex: TOtherDoctorItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TOtherDoctorItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      OtherDoctor_FNAME:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      OtherDoctor_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      OtherDoctor_LNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      OtherDoctor_KOD_RAJON: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      OtherDoctor_KOD_RZOK: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      OtherDoctor_NOMER_LZ:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      OtherDoctor_NZOK_NOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      OtherDoctor_SNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      OtherDoctor_SPECIALITY: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      OtherDoctor_UIN:
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

procedure TOtherDoctorColl.IndexValueListNodes(propIndex: TOtherDoctorItem.TPropertyIndex);
begin

end;

function TOtherDoctorColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TOtherDoctorItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TOtherDoctorColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TOtherDoctorItem;
begin
  if index < 0 then
  begin
    Tempitem := TOtherDoctorItem.Create(nil);
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

{=== TEXT SEARCH HANDLER ===}
procedure TOtherDoctorColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TOtherDoctorItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TOtherDoctorItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TOtherDoctorItem.TPropertyIndex(Field) of
OtherDoctor_FNAME: ListForFinder[0].PRecord.FNAME := AText;
    OtherDoctor_LNAME: ListForFinder[0].PRecord.LNAME := AText;
    OtherDoctor_NOMER_LZ: ListForFinder[0].PRecord.NOMER_LZ := AText;
    OtherDoctor_NZOK_NOMER: ListForFinder[0].PRecord.NZOK_NOMER := AText;
    OtherDoctor_SNAME: ListForFinder[0].PRecord.SNAME := AText;
    OtherDoctor_UIN: ListForFinder[0].PRecord.UIN := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TOtherDoctorColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TOtherDoctorItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TOtherDoctorItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TOtherDoctorColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TOtherDoctorItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TOtherDoctorItem.TPropertyIndex(Field) of
OtherDoctor_ID: ListForFinder[0].PRecord.ID := Value;
    OtherDoctor_KOD_RAJON: ListForFinder[0].PRecord.KOD_RAJON := Value;
    OtherDoctor_KOD_RZOK: ListForFinder[0].PRecord.KOD_RZOK := Value;
    OtherDoctor_SPECIALITY: ListForFinder[0].PRecord.SPECIALITY := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TOtherDoctorColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TOtherDoctorItem.TPropertyIndex(Field) of
    OtherDoctor_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalOtherDoctor(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalOtherDoctor(logIndex))   
    end;
  end;
end;


procedure TOtherDoctorColl.OnSetTextSearchLog(Log: TlogicalOtherDoctorSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TOtherDoctorColl.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  ApplyVisibilityFromTree(FieldCollOptionNode);
  run := FieldCollOptionNode.FirstChild;

  while run <> nil do
  begin
    Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy - 1);
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end;

end;

function TOtherDoctorColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TOtherDoctorItem.TPropertyIndex(propIndex) of
    OtherDoctor_FNAME: Result := actAnsiString;
    OtherDoctor_ID: Result := actinteger;
    OtherDoctor_LNAME: Result := actAnsiString;
    OtherDoctor_KOD_RAJON: Result := actinteger;
    OtherDoctor_KOD_RZOK: Result := actinteger;
    OtherDoctor_NOMER_LZ: Result := actAnsiString;
    OtherDoctor_NZOK_NOMER: Result := actAnsiString;
    OtherDoctor_SNAME: Result := actAnsiString;
    OtherDoctor_SPECIALITY: Result := actinteger;
    OtherDoctor_UIN: Result := actAnsiString;
    OtherDoctor_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TOtherDoctorColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TOtherDoctorColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  OtherDoctor: TOtherDoctorItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  OtherDoctor := Items[ARow];
  if not Assigned(OtherDoctor.PRecord) then
  begin
    New(OtherDoctor.PRecord);
    OtherDoctor.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TOtherDoctorItem.TPropertyIndex(ACol) of
      OtherDoctor_FNAME: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    OtherDoctor_ID: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    OtherDoctor_LNAME: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    OtherDoctor_KOD_RAJON: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    OtherDoctor_KOD_RZOK: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    OtherDoctor_NOMER_LZ: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    OtherDoctor_NZOK_NOMER: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    OtherDoctor_SNAME: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    OtherDoctor_SPECIALITY: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    OtherDoctor_UIN: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(OtherDoctor.PRecord.setProp, TOtherDoctorItem.TPropertyIndex(ACol));
    if OtherDoctor.PRecord.setProp = [] then
    begin
      Dispose(OtherDoctor.PRecord);
      OtherDoctor.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(OtherDoctor.PRecord.setProp, TOtherDoctorItem.TPropertyIndex(ACol));
  case TOtherDoctorItem.TPropertyIndex(ACol) of
    OtherDoctor_FNAME: OtherDoctor.PRecord.FNAME := AValue;
    OtherDoctor_ID: OtherDoctor.PRecord.ID := StrToInt(AValue);
    OtherDoctor_LNAME: OtherDoctor.PRecord.LNAME := AValue;
    OtherDoctor_KOD_RAJON: OtherDoctor.PRecord.KOD_RAJON := StrToInt(AValue);
    OtherDoctor_KOD_RZOK: OtherDoctor.PRecord.KOD_RZOK := StrToInt(AValue);
    OtherDoctor_NOMER_LZ: OtherDoctor.PRecord.NOMER_LZ := AValue;
    OtherDoctor_NZOK_NOMER: OtherDoctor.PRecord.NZOK_NOMER := AValue;
    OtherDoctor_SNAME: OtherDoctor.PRecord.SNAME := AValue;
    OtherDoctor_SPECIALITY: OtherDoctor.PRecord.SPECIALITY := StrToInt(AValue);
    OtherDoctor_UIN: OtherDoctor.PRecord.UIN := AValue;
    OtherDoctor_Logical: OtherDoctor.PRecord.Logical := tlogicalOtherDoctorSet(OtherDoctor.StrToLogical08(AValue));
  end;
end;

procedure TOtherDoctorColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  OtherDoctor: TOtherDoctorItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  OtherDoctor := Items[ARow];
  if not Assigned(OtherDoctor.PRecord) then
  begin
    New(OtherDoctor.PRecord);
    OtherDoctor.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TOtherDoctorItem.TPropertyIndex(ACol) of
      OtherDoctor_FNAME: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    OtherDoctor_ID: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    OtherDoctor_LNAME: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    OtherDoctor_KOD_RAJON: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    OtherDoctor_KOD_RZOK: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    OtherDoctor_NOMER_LZ: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    OtherDoctor_NZOK_NOMER: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    OtherDoctor_SNAME: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    OtherDoctor_SPECIALITY: isOld :=  OtherDoctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    OtherDoctor_UIN: isOld :=  OtherDoctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(OtherDoctor.PRecord.setProp, TOtherDoctorItem.TPropertyIndex(ACol));
    if OtherDoctor.PRecord.setProp = [] then
    begin
      Dispose(OtherDoctor.PRecord);
      OtherDoctor.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(OtherDoctor.PRecord.setProp, TOtherDoctorItem.TPropertyIndex(ACol));
  case TOtherDoctorItem.TPropertyIndex(ACol) of
    OtherDoctor_FNAME: OtherDoctor.PRecord.FNAME := AFieldText;
    OtherDoctor_ID: OtherDoctor.PRecord.ID := StrToInt(AFieldText);
    OtherDoctor_LNAME: OtherDoctor.PRecord.LNAME := AFieldText;
    OtherDoctor_KOD_RAJON: OtherDoctor.PRecord.KOD_RAJON := StrToInt(AFieldText);
    OtherDoctor_KOD_RZOK: OtherDoctor.PRecord.KOD_RZOK := StrToInt(AFieldText);
    OtherDoctor_NOMER_LZ: OtherDoctor.PRecord.NOMER_LZ := AFieldText;
    OtherDoctor_NZOK_NOMER: OtherDoctor.PRecord.NZOK_NOMER := AFieldText;
    OtherDoctor_SNAME: OtherDoctor.PRecord.SNAME := AFieldText;
    OtherDoctor_SPECIALITY: OtherDoctor.PRecord.SPECIALITY := StrToInt(AFieldText);
    OtherDoctor_UIN: OtherDoctor.PRecord.UIN := AFieldText;
    OtherDoctor_Logical: OtherDoctor.PRecord.Logical := tlogicalOtherDoctorSet(OtherDoctor.StrToLogical08(AFieldText));
  end;
end;

procedure TOtherDoctorColl.SetItem(Index: Integer; const Value: TOtherDoctorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TOtherDoctorColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListOtherDoctorSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TOtherDoctorItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  OtherDoctor_FNAME:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListOtherDoctorSearch.Add(self.Items[i]);
  end;
end;
      OtherDoctor_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_LNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_KOD_RAJON: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_KOD_RZOK: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_NOMER_LZ:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_NZOK_NOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_SNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_SPECIALITY: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
      OtherDoctor_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListOtherDoctorSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TOtherDoctorColl.ShowGrid(Grid: TTeeGrid);
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

procedure TOtherDoctorColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TOtherDoctorItem>);
var
  i: word;

begin
  ListForFinder := LST;
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

procedure TOtherDoctorColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListOtherDoctorSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListOtherDoctorSearch.Count]);

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

procedure TOtherDoctorColl.SortByIndexAnsiString;
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
        while (Items[I].IndexAnsiStr1) < (Items[P].IndexAnsiStr1) do Inc(I);
        while (Items[J].IndexAnsiStr1) > (Items[P].IndexAnsiStr1) do Dec(J);
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

procedure TOtherDoctorColl.SortByIndexInt;
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

procedure TOtherDoctorColl.SortByIndexWord;
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

procedure TOtherDoctorColl.SortByIndexValue(propIndex: TOtherDoctorItem.TPropertyIndex);
begin
  case propIndex of
    OtherDoctor_FNAME: SortByIndexAnsiString;
      OtherDoctor_ID: SortByIndexInt;
      OtherDoctor_LNAME: SortByIndexAnsiString;
      OtherDoctor_KOD_RAJON: SortByIndexInt;
      OtherDoctor_KOD_RZOK: SortByIndexInt;
      OtherDoctor_NOMER_LZ: SortByIndexAnsiString;
      OtherDoctor_NZOK_NOMER: SortByIndexAnsiString;
      OtherDoctor_SNAME: SortByIndexAnsiString;
      OtherDoctor_SPECIALITY: SortByIndexInt;
      OtherDoctor_UIN: SortByIndexAnsiString;
  end;
end;

end.