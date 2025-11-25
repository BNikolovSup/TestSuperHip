unit Table.Procedures;

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

TLogicalProcedures = (
    ARTICLE_147,
    EFFECTIVE,
    HI_SPECIALIZED,
    IS_EXAM_TYPE,
    IS_HOSPITAL,
    FIZIO_GROUP_minus1,
    FIZIO_GROUP_0,
    FIZIO_GROUP_1,
    FIZIO_GROUP_2);
TlogicalProceduresSet = set of TLogicalProcedures;


TProceduresItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Procedures_CODE
       , Procedures_HI_EQUIPMENT
       , Procedures_HI_REQUIREMENTS
       , Procedures_ID
       , Procedures_KSMP
       , Procedures_NAME
       , Procedures_PACKAGE_ID
       , Procedures_PRICE
       , Procedures_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecProcedures = ^TRecProcedures;
      TRecProcedures = record
        CODE: AnsiString;
        HI_EQUIPMENT: AnsiString;
        HI_REQUIREMENTS: AnsiString;
        ID: integer;
        KSMP: AnsiString;
        NAME: AnsiString;
        PACKAGE_ID: integer;
        PRICE: double;
        Logical: TlogicalProceduresSet;
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
    procedure SaveProcedures(var dataPosition: Cardinal)overload;
	procedure SaveProcedures(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TProceduresColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TProceduresItem;
    function GetItem(Index: Integer): TProceduresItem;
    procedure SetItem(Index: Integer; const Value: TProceduresItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TProceduresItem>;
    ListProceduresSearch: TList<TProceduresItem>;
	PRecordSearch: ^TProceduresItem.TRecProcedures;
    ArrPropSearch: TArray<TProceduresItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TProceduresItem.TPropertyIndex>;
	VisibleColl: TProceduresItem.TSetProp;
	ArrayPropOrder: TArray<TProceduresItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TProceduresItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Procedures: TProceduresItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Procedures: TProceduresItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TProceduresItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TProceduresItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TProceduresItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TProceduresItem.TPropertyIndex);
    property Items[Index: Integer]: TProceduresItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalProceduresSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
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

procedure TProceduresItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TProceduresItem.GetCollType: TCollectionsType;
begin
  Result := ctProcedures;
end;

function TProceduresItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
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
            Procedures_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Procedures_HI_EQUIPMENT: SaveData(PRecord.HI_EQUIPMENT, PropPosition, metaPosition, dataPosition);
            Procedures_HI_REQUIREMENTS: SaveData(PRecord.HI_REQUIREMENTS, PropPosition, metaPosition, dataPosition);
            Procedures_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Procedures_KSMP: SaveData(PRecord.KSMP, PropPosition, metaPosition, dataPosition);
            Procedures_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Procedures_PACKAGE_ID: SaveData(PRecord.PACKAGE_ID, PropPosition, metaPosition, dataPosition);
            Procedures_PRICE: SaveData(PRecord.PRICE, PropPosition, metaPosition, dataPosition);
            Procedures_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
	ATempItem := TProceduresColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Procedures_CODE: Result := IsFinded(ATempItem.PRecord.CODE, buf, FPosDataADB, word(Procedures_CODE), cot);
            Procedures_HI_EQUIPMENT: Result := IsFinded(ATempItem.PRecord.HI_EQUIPMENT, buf, FPosDataADB, word(Procedures_HI_EQUIPMENT), cot);
            Procedures_HI_REQUIREMENTS: Result := IsFinded(ATempItem.PRecord.HI_REQUIREMENTS, buf, FPosDataADB, word(Procedures_HI_REQUIREMENTS), cot);
            Procedures_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(Procedures_ID), cot);
            Procedures_KSMP: Result := IsFinded(ATempItem.PRecord.KSMP, buf, FPosDataADB, word(Procedures_KSMP), cot);
            Procedures_NAME: Result := IsFinded(ATempItem.PRecord.NAME, buf, FPosDataADB, word(Procedures_NAME), cot);
            Procedures_PACKAGE_ID: Result := IsFinded(ATempItem.PRecord.PACKAGE_ID, buf, FPosDataADB, word(Procedures_PACKAGE_ID), cot);
            Procedures_PRICE: Result := IsFinded(ATempItem.PRecord.PRICE, buf, FPosDataADB, word(Procedures_PRICE), cot);
            Procedures_Logical: Result := IsFinded(TLogicalData16(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Procedures_Logical), cot);
      end;
    end;
  end;
end;

procedure TProceduresItem.SaveProcedures(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveProcedures(dataPosition);
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
            Procedures_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Procedures_HI_EQUIPMENT: SaveData(PRecord.HI_EQUIPMENT, PropPosition, metaPosition, dataPosition);
            Procedures_HI_REQUIREMENTS: SaveData(PRecord.HI_REQUIREMENTS, PropPosition, metaPosition, dataPosition);
            Procedures_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Procedures_KSMP: SaveData(PRecord.KSMP, PropPosition, metaPosition, dataPosition);
            Procedures_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Procedures_PACKAGE_ID: SaveData(PRecord.PACKAGE_ID, PropPosition, metaPosition, dataPosition);
            Procedures_PRICE: SaveData(PRecord.PRICE, PropPosition, metaPosition, dataPosition);
            Procedures_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
            Procedures_CODE: UpdateData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Procedures_HI_EQUIPMENT: UpdateData(PRecord.HI_EQUIPMENT, PropPosition, metaPosition, dataPosition);
            Procedures_HI_REQUIREMENTS: UpdateData(PRecord.HI_REQUIREMENTS, PropPosition, metaPosition, dataPosition);
            Procedures_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
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
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TProceduresColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TProceduresItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TProceduresColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvProceduresRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TProceduresColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TProceduresItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (Procedures_CODE in tempItem.PRecord.setProp) and (tempItem.PRecord.CODE <> Self.getAnsiStringMap(tempItem.DataPos, word(Procedures_CODE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_HI_EQUIPMENT in tempItem.PRecord.setProp) and (tempItem.PRecord.HI_EQUIPMENT <> Self.getAnsiStringMap(tempItem.DataPos, word(Procedures_HI_EQUIPMENT))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_HI_REQUIREMENTS in tempItem.PRecord.setProp) and (tempItem.PRecord.HI_REQUIREMENTS <> Self.getAnsiStringMap(tempItem.DataPos, word(Procedures_HI_REQUIREMENTS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(Procedures_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_KSMP in tempItem.PRecord.setProp) and (tempItem.PRecord.KSMP <> Self.getAnsiStringMap(tempItem.DataPos, word(Procedures_KSMP))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_NAME in tempItem.PRecord.setProp) and (tempItem.PRecord.NAME <> Self.getAnsiStringMap(tempItem.DataPos, word(Procedures_NAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_PACKAGE_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.PACKAGE_ID <> Self.getIntMap(tempItem.DataPos, word(Procedures_PACKAGE_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_PRICE in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.PRICE - Self.getDoubleMap(tempItem.DataPos, word(Procedures_PRICE))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (Procedures_Logical in tempItem.PRecord.setProp) and (TLogicalData16(tempItem.PRecord.Logical) <> Self.getLogical16Map(tempItem.DataPos, word(Procedures_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TProceduresColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TProceduresItem.Create(nil);
  ListProceduresSearch := TList<TProceduresItem>.Create;
  ListForFinder := TList<TProceduresItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TProceduresColl.destroy;
begin
  FreeAndNil(ListProceduresSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TProceduresColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_CODE: Result := 'CODE';
    Procedures_HI_EQUIPMENT: Result := 'HI_EQUIPMENT';
    Procedures_HI_REQUIREMENTS: Result := 'HI_REQUIREMENTS';
    Procedures_ID: Result := 'ID';
    Procedures_KSMP: Result := 'KSMP';
    Procedures_NAME: Result := 'NAME';
    Procedures_PACKAGE_ID: Result := 'PACKAGE_ID';
    Procedures_PRICE: Result := 'PRICE';
    Procedures_Logical: Result := 'Logical';
  end;
end;

function TProceduresColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'ARTICLE_147';
    1: Result := 'EFFECTIVE';
    2: Result := 'HI_SPECIALIZED';
    3: Result := 'IS_EXAM_TYPE';
    4: Result := 'IS_HOSPITAL';
    5: Result := 'FIZIO_GROUP_minus1';
    6: Result := 'FIZIO_GROUP_0';
    7: Result := 'FIZIO_GROUP_1';
    8: Result := 'FIZIO_GROUP_2';
  else
    Result := '???';
  end;
end;


procedure TProceduresColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TProceduresColl.FieldCount: Integer; 
begin
  inherited;
  Result := 9;
end;

function TProceduresColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvProceduresRoot then
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

function TProceduresColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TProceduresColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TProceduresColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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
  RowSelect: Integer;
  prop: TProceduresItem.TPropertyIndex;
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

procedure TProceduresColl.GetCellFromRecord(propIndex: word; Procedures: TProceduresItem; var AValue: String);
var
  str: string;
begin
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_CODE: str := (Procedures.PRecord.CODE);
    Procedures_HI_EQUIPMENT: str := (Procedures.PRecord.HI_EQUIPMENT);
    Procedures_HI_REQUIREMENTS: str := (Procedures.PRecord.HI_REQUIREMENTS);
    Procedures_ID: str := inttostr(Procedures.PRecord.ID);
    Procedures_KSMP: str := (Procedures.PRecord.KSMP);
    Procedures_NAME: str := (Procedures.PRecord.NAME);
    Procedures_PACKAGE_ID: str := inttostr(Procedures.PRecord.PACKAGE_ID);
    Procedures_PRICE: str := FloatToStr(Procedures.PRecord.PRICE);
    Procedures_Logical: str := Procedures.Logical16ToStr(TLogicalData16(Procedures.PRecord.Logical));
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
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
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

function TProceduresColl.GetCollType: TCollectionsType;
begin
  Result := ctProcedures;
end;

function TProceduresColl.GetCollDelType: TCollectionsType;
begin
  Result := ctProceduresDel;
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
    Procedures_CODE: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_HI_EQUIPMENT: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_HI_REQUIREMENTS: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_ID: str :=  inttostr(Procedures.getIntMap(Self.Buf, Self.posData, propIndex));
    Procedures_KSMP: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_NAME: str :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Procedures_PACKAGE_ID: str :=  inttostr(Procedures.getIntMap(Self.Buf, Self.posData, propIndex));
    Procedures_Logical: str :=  Procedures.Logical16ToStr(Procedures.getLogical16Map(Self.Buf, Self.posData, propIndex));
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

function TProceduresColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TProceduresItem.TPropertyIndex(PropIndex) in  VisibleColl;
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

{=== TEXT SEARCH HANDLER ===}
procedure TProceduresColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TProceduresItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TProceduresItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TProceduresItem.TPropertyIndex(Field) of
Procedures_CODE: ListForFinder[0].PRecord.CODE := AText;
    Procedures_HI_EQUIPMENT: ListForFinder[0].PRecord.HI_EQUIPMENT := AText;
    Procedures_HI_REQUIREMENTS: ListForFinder[0].PRecord.HI_REQUIREMENTS := AText;
    Procedures_KSMP: ListForFinder[0].PRecord.KSMP := AText;
    Procedures_NAME: ListForFinder[0].PRecord.NAME := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TProceduresColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TProceduresItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TProceduresItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TProceduresColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TProceduresItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TProceduresItem.TPropertyIndex(Field) of
Procedures_ID: ListForFinder[0].PRecord.ID := Value;
    Procedures_PACKAGE_ID: ListForFinder[0].PRecord.PACKAGE_ID := Value;
    Procedures_PRICE: ListForFinder[0].PRecord.PRICE := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TProceduresColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TProceduresItem.TPropertyIndex(Field) of
    Procedures_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalProcedures(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalProcedures(logIndex))   
    end;
  end;
end;


procedure TProceduresColl.OnSetTextSearchLog(Log: TlogicalProceduresSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TProceduresColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TProceduresColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TProceduresItem.TPropertyIndex(propIndex) of
    Procedures_CODE: Result := actAnsiString;
    Procedures_HI_EQUIPMENT: Result := actAnsiString;
    Procedures_HI_REQUIREMENTS: Result := actAnsiString;
    Procedures_ID: Result := actinteger;
    Procedures_KSMP: Result := actAnsiString;
    Procedures_NAME: Result := actAnsiString;
    Procedures_PACKAGE_ID: Result := actinteger;
    Procedures_PRICE: Result := actdouble;
    Procedures_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TProceduresColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TProceduresColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Procedures: TProceduresItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Procedures := Items[ARow];
  if not Assigned(Procedures.PRecord) then
  begin
    New(Procedures.PRecord);
    Procedures.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TProceduresItem.TPropertyIndex(ACol) of
      Procedures_CODE: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_HI_EQUIPMENT: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_HI_REQUIREMENTS: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Procedures_ID: isOld :=  Procedures.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
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
    Procedures_CODE: Procedures.PRecord.CODE := AValue;
    Procedures_HI_EQUIPMENT: Procedures.PRecord.HI_EQUIPMENT := AValue;
    Procedures_HI_REQUIREMENTS: Procedures.PRecord.HI_REQUIREMENTS := AValue;
    Procedures_ID: Procedures.PRecord.ID := StrToInt(AValue);
    Procedures_KSMP: Procedures.PRecord.KSMP := AValue;
    Procedures_NAME: Procedures.PRecord.NAME := AValue;
    Procedures_PACKAGE_ID: Procedures.PRecord.PACKAGE_ID := StrToInt(AValue);
    Procedures_PRICE: Procedures.PRecord.PRICE := StrToFloat(AValue);
    Procedures_Logical: Procedures.PRecord.Logical := tlogicalProceduresSet(Procedures.StrToLogical16(AValue));
  end;
end;

procedure TProceduresColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Procedures: TProceduresItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Procedures := Items[ARow];
  if not Assigned(Procedures.PRecord) then
  begin
    New(Procedures.PRecord);
    Procedures.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TProceduresItem.TPropertyIndex(ACol) of
      Procedures_CODE: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_HI_EQUIPMENT: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_HI_REQUIREMENTS: isOld :=  Procedures.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Procedures_ID: isOld :=  Procedures.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
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
    Procedures_CODE: Procedures.PRecord.CODE := AFieldText;
    Procedures_HI_EQUIPMENT: Procedures.PRecord.HI_EQUIPMENT := AFieldText;
    Procedures_HI_REQUIREMENTS: Procedures.PRecord.HI_REQUIREMENTS := AFieldText;
    Procedures_ID: Procedures.PRecord.ID := StrToInt(AFieldText);
    Procedures_KSMP: Procedures.PRecord.KSMP := AFieldText;
    Procedures_NAME: Procedures.PRecord.NAME := AFieldText;
    Procedures_PACKAGE_ID: Procedures.PRecord.PACKAGE_ID := StrToInt(AFieldText);
    Procedures_PRICE: Procedures.PRecord.PRICE := StrToFloat(AFieldText);
    Procedures_Logical: Procedures.PRecord.Logical := tlogicalProceduresSet(Procedures.StrToLogical16(AFieldText));
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
      Procedures_HI_EQUIPMENT: SortByIndexAnsiString;
      Procedures_HI_REQUIREMENTS: SortByIndexAnsiString;
      Procedures_ID: SortByIndexInt;
      Procedures_KSMP: SortByIndexAnsiString;
      Procedures_NAME: SortByIndexAnsiString;
      Procedures_PACKAGE_ID: SortByIndexInt;
  end;
end;

end.