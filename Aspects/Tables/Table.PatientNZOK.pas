unit Table.PatientNZOK;

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

TLogicalPatientNZOK = (
    Is_);
TlogicalPatientNZOKSet = set of TLogicalPatientNZOK;


TPatientNZOKItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       PatientNZOK_RZOK
       , PatientNZOK_EGN
       , PatientNZOK_LNC
       , PatientNZOK_SNN
       , PatientNZOK_EZOK
       , PatientNZOK_SPOGODBA
       , PatientNZOK_UIN
       , PatientNZOK_RCZ_NUMBER
       , PatientNZOK_FROM_DATE
       , PatientNZOK_TO_DATE
       , PatientNZOK_REG_TYPE
       , PatientNZOK_REASON_OTP
       , PatientNZOK_CHOICE_TYPE
       , PatientNZOK_NAME_ZOL
       , PatientNZOK_NAME_OPL
       , PatientNZOK_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecPatientNZOK = ^TRecPatientNZOK;
      TRecPatientNZOK = record
        RZOK: AnsiString;
        EGN: AnsiString;
        LNC: AnsiString;
        SNN: AnsiString;
        EZOK: AnsiString;
        SPOGODBA: AnsiString;
        UIN: AnsiString;
        RCZ_NUMBER: AnsiString;
        FROM_DATE: AnsiString;
        TO_DATE: AnsiString;
        REG_TYPE: AnsiString;
        REASON_OTP: AnsiString;
        CHOICE_TYPE: AnsiString;
        NAME_ZOL: AnsiString;
        NAME_OPL: AnsiString;
        Logical: TlogicalPatientNZOKSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPatientNZOK;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPatientNZOK;
    procedure UpdatePatientNZOK;
    procedure SavePatientNZOK(var dataPosition: Cardinal)overload;
	procedure SavePatientNZOK(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TPatientNZOKColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TPatientNZOKItem;
    function GetItem(Index: Integer): TPatientNZOKItem;
    procedure SetItem(Index: Integer; const Value: TPatientNZOKItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TPatientNZOKItem>;
    ListPatientNZOKSearch: TList<TPatientNZOKItem>;
	PRecordSearch: ^TPatientNZOKItem.TRecPatientNZOK;
    ArrPropSearch: TArray<TPatientNZOKItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TPatientNZOKItem.TPropertyIndex>;
	VisibleColl: TPatientNZOKItem.TSetProp;
	ArrayPropOrder: TArray<TPatientNZOKItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPatientNZOKItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; PatientNZOK: TPatientNZOKItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PatientNZOK: TPatientNZOKItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TPatientNZOKItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TPatientNZOKItem.TPropertyIndex);
    property Items[Index: Integer]: TPatientNZOKItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalPatientNZOKSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
  end;

implementation

{ TPatientNZOKItem }

constructor TPatientNZOKItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPatientNZOKItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPatientNZOKItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TPatientNZOKItem.GetCollType: TCollectionsType;
begin
  Result := ctPatientNZOK;
end;

function TPatientNZOKItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TPatientNZOKItem.InsertPatientNZOK;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPatientNZOK;
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
            PatientNZOK_RZOK: SaveData(PRecord.RZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_LNC: SaveData(PRecord.LNC, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SNN: SaveData(PRecord.SNN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EZOK: SaveData(PRecord.EZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SPOGODBA: SaveData(PRecord.SPOGODBA, PropPosition, metaPosition, dataPosition);
            PatientNZOK_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_RCZ_NUMBER: SaveData(PRecord.RCZ_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNZOK_FROM_DATE: SaveData(PRecord.FROM_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_TO_DATE: SaveData(PRecord.TO_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REG_TYPE: SaveData(PRecord.REG_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REASON_OTP: SaveData(PRecord.REASON_OTP, PropPosition, metaPosition, dataPosition);
            PatientNZOK_CHOICE_TYPE: SaveData(PRecord.CHOICE_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_ZOL: SaveData(PRecord.NAME_ZOL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_OPL: SaveData(PRecord.NAME_OPL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TPatientNZOKItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TPatientNZOKItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TPatientNZOKItem;
begin
  Result := True;
  for i := 0 to Length(TPatientNZOKColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TPatientNZOKColl(coll).ArrPropSearchClc[i];
	ATempItem := TPatientNZOKColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        PatientNZOK_RZOK: Result := IsFinded(ATempItem.PRecord.RZOK, buf, FPosDataADB, word(PatientNZOK_RZOK), cot);
            PatientNZOK_EGN: Result := IsFinded(ATempItem.PRecord.EGN, buf, FPosDataADB, word(PatientNZOK_EGN), cot);
            PatientNZOK_LNC: Result := IsFinded(ATempItem.PRecord.LNC, buf, FPosDataADB, word(PatientNZOK_LNC), cot);
            PatientNZOK_SNN: Result := IsFinded(ATempItem.PRecord.SNN, buf, FPosDataADB, word(PatientNZOK_SNN), cot);
            PatientNZOK_EZOK: Result := IsFinded(ATempItem.PRecord.EZOK, buf, FPosDataADB, word(PatientNZOK_EZOK), cot);
            PatientNZOK_SPOGODBA: Result := IsFinded(ATempItem.PRecord.SPOGODBA, buf, FPosDataADB, word(PatientNZOK_SPOGODBA), cot);
            PatientNZOK_UIN: Result := IsFinded(ATempItem.PRecord.UIN, buf, FPosDataADB, word(PatientNZOK_UIN), cot);
            PatientNZOK_RCZ_NUMBER: Result := IsFinded(ATempItem.PRecord.RCZ_NUMBER, buf, FPosDataADB, word(PatientNZOK_RCZ_NUMBER), cot);
            PatientNZOK_FROM_DATE: Result := IsFinded(ATempItem.PRecord.FROM_DATE, buf, FPosDataADB, word(PatientNZOK_FROM_DATE), cot);
            PatientNZOK_TO_DATE: Result := IsFinded(ATempItem.PRecord.TO_DATE, buf, FPosDataADB, word(PatientNZOK_TO_DATE), cot);
            PatientNZOK_REG_TYPE: Result := IsFinded(ATempItem.PRecord.REG_TYPE, buf, FPosDataADB, word(PatientNZOK_REG_TYPE), cot);
            PatientNZOK_REASON_OTP: Result := IsFinded(ATempItem.PRecord.REASON_OTP, buf, FPosDataADB, word(PatientNZOK_REASON_OTP), cot);
            PatientNZOK_CHOICE_TYPE: Result := IsFinded(ATempItem.PRecord.CHOICE_TYPE, buf, FPosDataADB, word(PatientNZOK_CHOICE_TYPE), cot);
            PatientNZOK_NAME_ZOL: Result := IsFinded(ATempItem.PRecord.NAME_ZOL, buf, FPosDataADB, word(PatientNZOK_NAME_ZOL), cot);
            PatientNZOK_NAME_OPL: Result := IsFinded(ATempItem.PRecord.NAME_OPL, buf, FPosDataADB, word(PatientNZOK_NAME_OPL), cot);
            PatientNZOK_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(PatientNZOK_Logical), cot);
      end;
    end;
  end;
end;

procedure TPatientNZOKItem.SavePatientNZOK(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SavePatientNZOK(dataPosition);
end;

procedure TPatientNZOKItem.SavePatientNZOK(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNZOK;
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
            PatientNZOK_RZOK: SaveData(PRecord.RZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_LNC: SaveData(PRecord.LNC, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SNN: SaveData(PRecord.SNN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EZOK: SaveData(PRecord.EZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SPOGODBA: SaveData(PRecord.SPOGODBA, PropPosition, metaPosition, dataPosition);
            PatientNZOK_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_RCZ_NUMBER: SaveData(PRecord.RCZ_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNZOK_FROM_DATE: SaveData(PRecord.FROM_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_TO_DATE: SaveData(PRecord.TO_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REG_TYPE: SaveData(PRecord.REG_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REASON_OTP: SaveData(PRecord.REASON_OTP, PropPosition, metaPosition, dataPosition);
            PatientNZOK_CHOICE_TYPE: SaveData(PRecord.CHOICE_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_ZOL: SaveData(PRecord.NAME_ZOL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_OPL: SaveData(PRecord.NAME_OPL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TPatientNZOKItem.UpdatePatientNZOK;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNZOK;
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
            PatientNZOK_RZOK: UpdateData(PRecord.RZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_LNC: UpdateData(PRecord.LNC, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SNN: UpdateData(PRecord.SNN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EZOK: UpdateData(PRecord.EZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SPOGODBA: UpdateData(PRecord.SPOGODBA, PropPosition, metaPosition, dataPosition);
            PatientNZOK_UIN: UpdateData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_RCZ_NUMBER: UpdateData(PRecord.RCZ_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNZOK_FROM_DATE: UpdateData(PRecord.FROM_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_TO_DATE: UpdateData(PRecord.TO_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REG_TYPE: UpdateData(PRecord.REG_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REASON_OTP: UpdateData(PRecord.REASON_OTP, PropPosition, metaPosition, dataPosition);
            PatientNZOK_CHOICE_TYPE: UpdateData(PRecord.CHOICE_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_ZOL: UpdateData(PRecord.NAME_ZOL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_OPL: UpdateData(PRecord.NAME_OPL, PropPosition, metaPosition, dataPosition);
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

{ TPatientNZOKColl }

function TPatientNZOKColl.AddItem(ver: word): TPatientNZOKItem;
begin
  Result := TPatientNZOKItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TPatientNZOKColl.AddItemForSearch: Integer;
var
  ItemForSearch: TPatientNZOKItem;
begin
  ItemForSearch := TPatientNZOKItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TPatientNZOKColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TPatientNZOKItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TPatientNZOKColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvPatientNZOKRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TPatientNZOKColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TPatientNZOKItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (PatientNZOK_RZOK in tempItem.PRecord.setProp) and (tempItem.PRecord.RZOK <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_RZOK))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_EGN in tempItem.PRecord.setProp) and (tempItem.PRecord.EGN <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_EGN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_LNC in tempItem.PRecord.setProp) and (tempItem.PRecord.LNC <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_LNC))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_SNN in tempItem.PRecord.setProp) and (tempItem.PRecord.SNN <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_SNN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_EZOK in tempItem.PRecord.setProp) and (tempItem.PRecord.EZOK <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_EZOK))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_SPOGODBA in tempItem.PRecord.setProp) and (tempItem.PRecord.SPOGODBA <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_SPOGODBA))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_UIN in tempItem.PRecord.setProp) and (tempItem.PRecord.UIN <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_UIN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_RCZ_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.RCZ_NUMBER <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_RCZ_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_FROM_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.FROM_DATE <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_FROM_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_TO_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.TO_DATE <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_TO_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_REG_TYPE in tempItem.PRecord.setProp) and (tempItem.PRecord.REG_TYPE <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_REG_TYPE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_REASON_OTP in tempItem.PRecord.setProp) and (tempItem.PRecord.REASON_OTP <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_REASON_OTP))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_CHOICE_TYPE in tempItem.PRecord.setProp) and (tempItem.PRecord.CHOICE_TYPE <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_CHOICE_TYPE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_NAME_ZOL in tempItem.PRecord.setProp) and (tempItem.PRecord.NAME_ZOL <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_NAME_ZOL))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_NAME_OPL in tempItem.PRecord.setProp) and (tempItem.PRecord.NAME_OPL <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNZOK_NAME_OPL))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNZOK_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(PatientNZOK_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TPatientNZOKColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TPatientNZOKItem.Create(nil);
  ListPatientNZOKSearch := TList<TPatientNZOKItem>.Create;
  ListForFinder := TList<TPatientNZOKItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TPatientNZOKColl.destroy;
begin
  FreeAndNil(ListPatientNZOKSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TPatientNZOKColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: Result := 'RZOK';
    PatientNZOK_EGN: Result := 'EGN';
    PatientNZOK_LNC: Result := 'LNC';
    PatientNZOK_SNN: Result := 'SNN';
    PatientNZOK_EZOK: Result := 'EZOK';
    PatientNZOK_SPOGODBA: Result := 'SPOGODBA';
    PatientNZOK_UIN: Result := 'UIN';
    PatientNZOK_RCZ_NUMBER: Result := 'RCZ_NUMBER';
    PatientNZOK_FROM_DATE: Result := 'FROM_DATE';
    PatientNZOK_TO_DATE: Result := 'TO_DATE';
    PatientNZOK_REG_TYPE: Result := 'REG_TYPE';
    PatientNZOK_REASON_OTP: Result := 'REASON_OTP';
    PatientNZOK_CHOICE_TYPE: Result := 'CHOICE_TYPE';
    PatientNZOK_NAME_ZOL: Result := 'NAME_ZOL';
    PatientNZOK_NAME_OPL: Result := 'NAME_OPL';
    PatientNZOK_Logical: Result := 'Logical';
  end;
end;

function TPatientNZOKColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TPatientNZOKColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TPatientNZOKColl.FieldCount: Integer; 
begin
  inherited;
  Result := 16;
end;

function TPatientNZOKColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvPatientNZOKRoot then
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

function TPatientNZOKColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TPatientNZOKColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TPatientNZOKColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TPatientNZOKColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNZOK: TPatientNZOKItem;
  ACol: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNZOK := Items[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if Assigned(PatientNZOK.PRecord) and (prop in PatientNZOK.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNZOK, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNZOK, AValue);
  end;
end;

procedure TPatientNZOKColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
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

procedure TPatientNZOKColl.GetCellFromRecord(propIndex: word; PatientNZOK: TPatientNZOKItem; var AValue: String);
var
  str: string;
begin
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: str := (PatientNZOK.PRecord.RZOK);
    PatientNZOK_EGN: str := (PatientNZOK.PRecord.EGN);
    PatientNZOK_LNC: str := (PatientNZOK.PRecord.LNC);
    PatientNZOK_SNN: str := (PatientNZOK.PRecord.SNN);
    PatientNZOK_EZOK: str := (PatientNZOK.PRecord.EZOK);
    PatientNZOK_SPOGODBA: str := (PatientNZOK.PRecord.SPOGODBA);
    PatientNZOK_UIN: str := (PatientNZOK.PRecord.UIN);
    PatientNZOK_RCZ_NUMBER: str := (PatientNZOK.PRecord.RCZ_NUMBER);
    PatientNZOK_FROM_DATE: str := (PatientNZOK.PRecord.FROM_DATE);
    PatientNZOK_TO_DATE: str := (PatientNZOK.PRecord.TO_DATE);
    PatientNZOK_REG_TYPE: str := (PatientNZOK.PRecord.REG_TYPE);
    PatientNZOK_REASON_OTP: str := (PatientNZOK.PRecord.REASON_OTP);
    PatientNZOK_CHOICE_TYPE: str := (PatientNZOK.PRecord.CHOICE_TYPE);
    PatientNZOK_NAME_ZOL: str := (PatientNZOK.PRecord.NAME_ZOL);
    PatientNZOK_NAME_OPL: str := (PatientNZOK.PRecord.NAME_OPL);
    PatientNZOK_Logical: str := PatientNZOK.Logical08ToStr(TLogicalData08(PatientNZOK.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPatientNZOKColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TPatientNZOKItem;
  ACol: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TPatientNZOKColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TPatientNZOKColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNZOK: TPatientNZOKItem;
  ACol: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNZOK := ListPatientNZOKSearch[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if Assigned(PatientNZOK.PRecord) and (prop in PatientNZOK.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNZOK, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNZOK, AValue);
  end;
end;

function TPatientNZOKColl.GetCollType: TCollectionsType;
begin
  Result := ctPatientNZOK;
end;

procedure TPatientNZOKColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PatientNZOK: TPatientNZOKItem;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PatientNZOK := Items[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if Assigned(PatientNZOK.PRecord) and (prop in PatientNZOK.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNZOK, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNZOK, AFieldText);
  end;
end;

procedure TPatientNZOKColl.GetCellFromMap(propIndex: word; ARow: Integer; PatientNZOK: TPatientNZOKItem; var AValue: String);
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
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_EGN: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_LNC: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_SNN: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_EZOK: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_SPOGODBA: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_UIN: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_RCZ_NUMBER: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_FROM_DATE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_TO_DATE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_REG_TYPE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_REASON_OTP: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_CHOICE_TYPE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_NAME_ZOL: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_NAME_OPL: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_Logical: str :=  PatientNZOK.Logical08ToStr(PatientNZOK.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPatientNZOKColl.GetItem(Index: Integer): TPatientNZOKItem;
begin
  Result := TPatientNZOKItem(inherited GetItem(Index));
end;


procedure TPatientNZOKColl.IndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPatientNZOKItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PatientNZOK_RZOK:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      PatientNZOK_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_LNC:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_SNN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_EZOK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_SPOGODBA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_UIN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_RCZ_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_FROM_DATE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_TO_DATE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_REG_TYPE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_REASON_OTP:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_CHOICE_TYPE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_NAME_ZOL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_NAME_OPL:
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

procedure TPatientNZOKColl.IndexValueListNodes(propIndex: TPatientNZOKItem.TPropertyIndex);
begin

end;

function TPatientNZOKColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TPatientNZOKItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TPatientNZOKColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TPatientNZOKItem;
begin
  if index < 0 then
  begin
    Tempitem := TPatientNZOKItem.Create(nil);
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
procedure TPatientNZOKColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TPatientNZOKItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TPatientNZOKItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TPatientNZOKItem.TPropertyIndex(Field) of
PatientNZOK_RZOK: ListForFinder[0].PRecord.RZOK := AText;
    PatientNZOK_EGN: ListForFinder[0].PRecord.EGN := AText;
    PatientNZOK_LNC: ListForFinder[0].PRecord.LNC := AText;
    PatientNZOK_SNN: ListForFinder[0].PRecord.SNN := AText;
    PatientNZOK_EZOK: ListForFinder[0].PRecord.EZOK := AText;
    PatientNZOK_SPOGODBA: ListForFinder[0].PRecord.SPOGODBA := AText;
    PatientNZOK_UIN: ListForFinder[0].PRecord.UIN := AText;
    PatientNZOK_RCZ_NUMBER: ListForFinder[0].PRecord.RCZ_NUMBER := AText;
    PatientNZOK_FROM_DATE: ListForFinder[0].PRecord.FROM_DATE := AText;
    PatientNZOK_TO_DATE: ListForFinder[0].PRecord.TO_DATE := AText;
    PatientNZOK_REG_TYPE: ListForFinder[0].PRecord.REG_TYPE := AText;
    PatientNZOK_REASON_OTP: ListForFinder[0].PRecord.REASON_OTP := AText;
    PatientNZOK_CHOICE_TYPE: ListForFinder[0].PRecord.CHOICE_TYPE := AText;
    PatientNZOK_NAME_ZOL: ListForFinder[0].PRecord.NAME_ZOL := AText;
    PatientNZOK_NAME_OPL: ListForFinder[0].PRecord.NAME_OPL := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TPatientNZOKColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TPatientNZOKItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TPatientNZOKItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TPatientNZOKColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TPatientNZOKItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TPatientNZOKItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TPatientNZOKColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TPatientNZOKItem.TPropertyIndex(Field) of
    PatientNZOK_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalPatientNZOK(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalPatientNZOK(logIndex))   
    end;
  end;
end;


procedure TPatientNZOKColl.OnSetTextSearchLog(Log: TlogicalPatientNZOKSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TPatientNZOKColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TPatientNZOKColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: Result := actAnsiString;
    PatientNZOK_EGN: Result := actAnsiString;
    PatientNZOK_LNC: Result := actAnsiString;
    PatientNZOK_SNN: Result := actAnsiString;
    PatientNZOK_EZOK: Result := actAnsiString;
    PatientNZOK_SPOGODBA: Result := actAnsiString;
    PatientNZOK_UIN: Result := actAnsiString;
    PatientNZOK_RCZ_NUMBER: Result := actAnsiString;
    PatientNZOK_FROM_DATE: Result := actAnsiString;
    PatientNZOK_TO_DATE: Result := actAnsiString;
    PatientNZOK_REG_TYPE: Result := actAnsiString;
    PatientNZOK_REASON_OTP: Result := actAnsiString;
    PatientNZOK_CHOICE_TYPE: Result := actAnsiString;
    PatientNZOK_NAME_ZOL: Result := actAnsiString;
    PatientNZOK_NAME_OPL: Result := actAnsiString;
    PatientNZOK_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TPatientNZOKColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TPatientNZOKColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PatientNZOK: TPatientNZOKItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  PatientNZOK := Items[ARow];
  if not Assigned(PatientNZOK.PRecord) then
  begin
    New(PatientNZOK.PRecord);
    PatientNZOK.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TPatientNZOKItem.TPropertyIndex(ACol) of
      PatientNZOK_RZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_EGN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_LNC: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_SNN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_EZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_SPOGODBA: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_UIN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_RCZ_NUMBER: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_FROM_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_TO_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_REG_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_REASON_OTP: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_CHOICE_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_NAME_ZOL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_NAME_OPL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
    if PatientNZOK.PRecord.setProp = [] then
    begin
      Dispose(PatientNZOK.PRecord);
      PatientNZOK.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
  case TPatientNZOKItem.TPropertyIndex(ACol) of
    PatientNZOK_RZOK: PatientNZOK.PRecord.RZOK := AValue;
    PatientNZOK_EGN: PatientNZOK.PRecord.EGN := AValue;
    PatientNZOK_LNC: PatientNZOK.PRecord.LNC := AValue;
    PatientNZOK_SNN: PatientNZOK.PRecord.SNN := AValue;
    PatientNZOK_EZOK: PatientNZOK.PRecord.EZOK := AValue;
    PatientNZOK_SPOGODBA: PatientNZOK.PRecord.SPOGODBA := AValue;
    PatientNZOK_UIN: PatientNZOK.PRecord.UIN := AValue;
    PatientNZOK_RCZ_NUMBER: PatientNZOK.PRecord.RCZ_NUMBER := AValue;
    PatientNZOK_FROM_DATE: PatientNZOK.PRecord.FROM_DATE := AValue;
    PatientNZOK_TO_DATE: PatientNZOK.PRecord.TO_DATE := AValue;
    PatientNZOK_REG_TYPE: PatientNZOK.PRecord.REG_TYPE := AValue;
    PatientNZOK_REASON_OTP: PatientNZOK.PRecord.REASON_OTP := AValue;
    PatientNZOK_CHOICE_TYPE: PatientNZOK.PRecord.CHOICE_TYPE := AValue;
    PatientNZOK_NAME_ZOL: PatientNZOK.PRecord.NAME_ZOL := AValue;
    PatientNZOK_NAME_OPL: PatientNZOK.PRecord.NAME_OPL := AValue;
    PatientNZOK_Logical: PatientNZOK.PRecord.Logical := tlogicalPatientNZOKSet(PatientNZOK.StrToLogical08(AValue));
  end;
end;

procedure TPatientNZOKColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PatientNZOK: TPatientNZOKItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  PatientNZOK := Items[ARow];
  if not Assigned(PatientNZOK.PRecord) then
  begin
    New(PatientNZOK.PRecord);
    PatientNZOK.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TPatientNZOKItem.TPropertyIndex(ACol) of
      PatientNZOK_RZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_EGN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_LNC: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_SNN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_EZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_SPOGODBA: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_UIN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_RCZ_NUMBER: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_FROM_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_TO_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_REG_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_REASON_OTP: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_CHOICE_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_NAME_ZOL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_NAME_OPL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
    if PatientNZOK.PRecord.setProp = [] then
    begin
      Dispose(PatientNZOK.PRecord);
      PatientNZOK.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
  case TPatientNZOKItem.TPropertyIndex(ACol) of
    PatientNZOK_RZOK: PatientNZOK.PRecord.RZOK := AFieldText;
    PatientNZOK_EGN: PatientNZOK.PRecord.EGN := AFieldText;
    PatientNZOK_LNC: PatientNZOK.PRecord.LNC := AFieldText;
    PatientNZOK_SNN: PatientNZOK.PRecord.SNN := AFieldText;
    PatientNZOK_EZOK: PatientNZOK.PRecord.EZOK := AFieldText;
    PatientNZOK_SPOGODBA: PatientNZOK.PRecord.SPOGODBA := AFieldText;
    PatientNZOK_UIN: PatientNZOK.PRecord.UIN := AFieldText;
    PatientNZOK_RCZ_NUMBER: PatientNZOK.PRecord.RCZ_NUMBER := AFieldText;
    PatientNZOK_FROM_DATE: PatientNZOK.PRecord.FROM_DATE := AFieldText;
    PatientNZOK_TO_DATE: PatientNZOK.PRecord.TO_DATE := AFieldText;
    PatientNZOK_REG_TYPE: PatientNZOK.PRecord.REG_TYPE := AFieldText;
    PatientNZOK_REASON_OTP: PatientNZOK.PRecord.REASON_OTP := AFieldText;
    PatientNZOK_CHOICE_TYPE: PatientNZOK.PRecord.CHOICE_TYPE := AFieldText;
    PatientNZOK_NAME_ZOL: PatientNZOK.PRecord.NAME_ZOL := AFieldText;
    PatientNZOK_NAME_OPL: PatientNZOK.PRecord.NAME_OPL := AFieldText;
    PatientNZOK_Logical: PatientNZOK.PRecord.Logical := tlogicalPatientNZOKSet(PatientNZOK.StrToLogical08(AFieldText));
  end;
end;

procedure TPatientNZOKColl.SetItem(Index: Integer; const Value: TPatientNZOKItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPatientNZOKColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPatientNZOKSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPatientNZOKItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  PatientNZOK_RZOK:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListPatientNZOKSearch.Add(self.Items[i]);
  end;
end;
      PatientNZOK_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_LNC:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_SNN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_EZOK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_SPOGODBA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_RCZ_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_FROM_DATE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_TO_DATE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_REG_TYPE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_REASON_OTP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_CHOICE_TYPE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_NAME_ZOL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_NAME_OPL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPatientNZOKColl.ShowGrid(Grid: TTeeGrid);
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

procedure TPatientNZOKColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TPatientNZOKItem>);
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

procedure TPatientNZOKColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPatientNZOKSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPatientNZOKSearch.Count]);

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

procedure TPatientNZOKColl.SortByIndexAnsiString;
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

procedure TPatientNZOKColl.SortByIndexInt;
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

procedure TPatientNZOKColl.SortByIndexWord;
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

procedure TPatientNZOKColl.SortByIndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
begin
  case propIndex of
    PatientNZOK_RZOK: SortByIndexAnsiString;
      PatientNZOK_EGN: SortByIndexAnsiString;
      PatientNZOK_LNC: SortByIndexAnsiString;
      PatientNZOK_SNN: SortByIndexAnsiString;
      PatientNZOK_EZOK: SortByIndexAnsiString;
      PatientNZOK_SPOGODBA: SortByIndexAnsiString;
      PatientNZOK_UIN: SortByIndexAnsiString;
      PatientNZOK_RCZ_NUMBER: SortByIndexAnsiString;
      PatientNZOK_FROM_DATE: SortByIndexAnsiString;
      PatientNZOK_TO_DATE: SortByIndexAnsiString;
      PatientNZOK_REG_TYPE: SortByIndexAnsiString;
      PatientNZOK_REASON_OTP: SortByIndexAnsiString;
      PatientNZOK_CHOICE_TYPE: SortByIndexAnsiString;
      PatientNZOK_NAME_ZOL: SortByIndexAnsiString;
      PatientNZOK_NAME_OPL: SortByIndexAnsiString;
  end;
end;

end.