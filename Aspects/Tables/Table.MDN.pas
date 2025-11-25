unit Table.MDN;

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

TLogicalMDN = (
    IS_LKK,
    IS_PRINTED,
    TAKENFROMARENAL,
    NZIS_STATUS_None,
    NZIS_STATUS_Valid,
    NZIS_STATUS_NoValid,
    NZIS_STATUS_Sended,
    NZIS_STATUS_Err,
    NZIS_STATUS_Cancel,
    NZIS_STATUS_Edited,
    MED_DIAG_NAPR_Ostro,
    MED_DIAG_NAPR_Hron,
    MED_DIAG_NAPR_Izbor,
    MED_DIAG_NAPR_Disp,
    MED_DIAG_NAPR_Eksp,
    MED_DIAG_NAPR_Prof,
    MED_DIAG_NAPR_Iskane_Telk,
    MED_DIAG_NAPR_Choice_Mother,
    MED_DIAG_NAPR_Choice_Child,
    MED_DIAG_NAPR_PreChoice_Mother,
    MED_DIAG_NAPR_PreChoice_Child,
    MED_DIAG_NAPR_Podg_Telk);
TlogicalMDNSet = set of TLogicalMDN;


TMDNItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       MDN_DATA
       , MDN_ID
       , MDN_NRN
       , MDN_NUMBER
       , MDN_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecMDN = ^TRecMDN;
      TRecMDN = record
        DATA: TDate;
        ID: integer;
        NRN: AnsiString;
        NUMBER: integer;
        Logical: TlogicalMDNSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecMDN;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertMDN;
    procedure UpdateMDN;
    procedure SaveMDN(var dataPosition: Cardinal)overload;
	procedure SaveMDN(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TMDNColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TMDNItem;
    function GetItem(Index: Integer): TMDNItem;
    procedure SetItem(Index: Integer; const Value: TMDNItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TMDNItem>;
    ListMDNSearch: TList<TMDNItem>;
	PRecordSearch: ^TMDNItem.TRecMDN;
    ArrPropSearch: TArray<TMDNItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TMDNItem.TPropertyIndex>;
	VisibleColl: TMDNItem.TSetProp;
	ArrayPropOrder: TArray<TMDNItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TMDNItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; MDN: TMDNItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; MDN: TMDNItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TMDNItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TMDNItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TMDNItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TMDNItem.TPropertyIndex);
    property Items[Index: Integer]: TMDNItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalMDNSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
  end;

implementation

{ TMDNItem }

constructor TMDNItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TMDNItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TMDNItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TMDNItem.GetCollType: TCollectionsType;
begin
  Result := ctMDN;
end;

function TMDNItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TMDNItem.InsertMDN;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctMDN;
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
            MDN_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            MDN_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            MDN_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            MDN_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            MDN_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TMDNItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TMDNItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TMDNItem;
begin
  Result := True;
  for i := 0 to Length(TMDNColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TMDNColl(coll).ArrPropSearchClc[i];
	ATempItem := TMDNColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        MDN_DATA: Result := IsFinded(ATempItem.PRecord.DATA, buf, FPosDataADB, word(MDN_DATA), cot);
            MDN_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(MDN_ID), cot);
            MDN_NRN: Result := IsFinded(ATempItem.PRecord.NRN, buf, FPosDataADB, word(MDN_NRN), cot);
            MDN_NUMBER: Result := IsFinded(ATempItem.PRecord.NUMBER, buf, FPosDataADB, word(MDN_NUMBER), cot);
            MDN_Logical: Result := IsFinded(TLogicalData32(ATempItem.PRecord.Logical), buf, FPosDataADB, word(MDN_Logical), cot);
      end;
    end;
  end;
end;

procedure TMDNItem.SaveMDN(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveMDN(dataPosition);
end;

procedure TMDNItem.SaveMDN(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMDN;
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
            MDN_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            MDN_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            MDN_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            MDN_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            MDN_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TMDNItem.UpdateMDN;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMDN;
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
            MDN_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            MDN_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            MDN_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            MDN_NUMBER: UpdateData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
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

{ TMDNColl }

function TMDNColl.AddItem(ver: word): TMDNItem;
begin
  Result := TMDNItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TMDNColl.AddItemForSearch: Integer;
var
  ItemForSearch: TMDNItem;
begin
  ItemForSearch := TMDNItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TMDNColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TMDNItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TMDNColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvMDNRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TMDNColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TMDNItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (MDN_DATA in tempItem.PRecord.setProp) and (tempItem.PRecord.DATA <> Self.getDateMap(tempItem.DataPos, word(MDN_DATA))) then
  begin
    inc(cnt);
    exit;
  end;

  if (MDN_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(MDN_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (MDN_NRN in tempItem.PRecord.setProp) and (tempItem.PRecord.NRN <> Self.getAnsiStringMap(tempItem.DataPos, word(MDN_NRN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (MDN_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.NUMBER <> Self.getIntMap(tempItem.DataPos, word(MDN_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (MDN_Logical in tempItem.PRecord.setProp) and (TLogicalData32(tempItem.PRecord.Logical) <> Self.getLogical32Map(tempItem.DataPos, word(MDN_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TMDNColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TMDNItem.Create(nil);
  ListMDNSearch := TList<TMDNItem>.Create;
  ListForFinder := TList<TMDNItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TMDNColl.destroy;
begin
  FreeAndNil(ListMDNSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TMDNColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: Result := 'DATA';
    MDN_ID: Result := 'ID';
    MDN_NRN: Result := 'NRN';
    MDN_NUMBER: Result := 'NUMBER';
    MDN_Logical: Result := 'Logical';
  end;
end;

function TMDNColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IS_LKK';
    1: Result := 'IS_PRINTED';
    2: Result := 'TAKENFROMARENAL';
    3: Result := 'NZIS_STATUS_None';
    4: Result := 'NZIS_STATUS_Valid';
    5: Result := 'NZIS_STATUS_NoValid';
    6: Result := 'NZIS_STATUS_Sended';
    7: Result := 'NZIS_STATUS_Err';
    8: Result := 'NZIS_STATUS_Cancel';
    9: Result := 'NZIS_STATUS_Edited';
    10: Result := 'MED_DIAG_NAPR_Ostro';
    11: Result := 'MED_DIAG_NAPR_Hron';
    12: Result := 'MED_DIAG_NAPR_Izbor';
    13: Result := 'MED_DIAG_NAPR_Disp';
    14: Result := 'MED_DIAG_NAPR_Eksp';
    15: Result := 'MED_DIAG_NAPR_Prof';
    16: Result := 'MED_DIAG_NAPR_Iskane_Telk';
    17: Result := 'MED_DIAG_NAPR_Choice_Mother';
    18: Result := 'MED_DIAG_NAPR_Choice_Child';
    19: Result := 'MED_DIAG_NAPR_PreChoice_Mother';
    20: Result := 'MED_DIAG_NAPR_PreChoice_Child';
    21: Result := 'MED_DIAG_NAPR_Podg_Telk';
  else
    Result := '???';
  end;
end;


procedure TMDNColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TMDNColl.FieldCount: Integer; 
begin
  inherited;
  Result := 5;
end;

function TMDNColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvMDNRoot then
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

function TMDNColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TMDNColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TMDNColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TMDNColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  MDN: TMDNItem;
  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  MDN := Items[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(MDN.PRecord) and (prop in MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, MDN, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, MDN, AValue);
  end;
end;

procedure TMDNColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TMDNItem.TPropertyIndex;
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

procedure TMDNColl.GetCellFromRecord(propIndex: word; MDN: TMDNItem; var AValue: String);
var
  str: string;
begin
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: str := AspDateToStr(MDN.PRecord.DATA);
    MDN_ID: str := inttostr(MDN.PRecord.ID);
    MDN_NRN: str := (MDN.PRecord.NRN);
    MDN_NUMBER: str := inttostr(MDN.PRecord.NUMBER);
    MDN_Logical: str := MDN.Logical32ToStr(TLogicalData32(MDN.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TMDNColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TMDNItem;
  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TMDNColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TMDNItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TMDNColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  MDN: TMDNItem;
  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  MDN := ListMDNSearch[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(MDN.PRecord) and (prop in MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, MDN, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, MDN, AValue);
  end;
end;

function TMDNColl.GetCollType: TCollectionsType;
begin
  Result := ctMDN;
end;

procedure TMDNColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  MDN: TMDNItem;
  prop: TMDNItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  MDN := Items[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(MDN.PRecord) and (prop in MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, MDN, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, MDN, AFieldText);
  end;
end;

procedure TMDNColl.GetCellFromMap(propIndex: word; ARow: Integer; MDN: TMDNItem; var AValue: String);
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
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: str :=  AspDateToStr(MDN.getDateMap(Self.Buf, Self.posData, propIndex));
    MDN_ID: str :=  inttostr(MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    MDN_NRN: str :=  MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    MDN_NUMBER: str :=  inttostr(MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    MDN_Logical: str :=  MDN.Logical32ToStr(MDN.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TMDNColl.GetItem(Index: Integer): TMDNItem;
begin
  Result := TMDNItem(inherited GetItem(Index));
end;


procedure TMDNColl.IndexValue(propIndex: TMDNItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TMDNItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      MDN_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      MDN_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      MDN_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TMDNColl.IndexValueListNodes(propIndex: TMDNItem.TPropertyIndex);
begin

end;

function TMDNColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TMDNItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TMDNColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TMDNItem;
begin
  if index < 0 then
  begin
    Tempitem := TMDNItem.Create(nil);
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
procedure TMDNColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TMDNItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TMDNItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TMDNItem.TPropertyIndex(Field) of
MDN_NRN: ListForFinder[0].PRecord.NRN := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TMDNColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TMDNItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TMDNItem.TPropertyIndex(Field) of
MDN_DATA: ListForFinder[0].PRecord.DATA := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TMDNColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TMDNItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TMDNItem.TPropertyIndex(Field) of
MDN_ID: ListForFinder[0].PRecord.ID := Value;
    MDN_NUMBER: ListForFinder[0].PRecord.NUMBER := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TMDNColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TMDNItem.TPropertyIndex(Field) of
    MDN_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalMDN(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalMDN(logIndex))   
    end;
  end;
end;


procedure TMDNColl.OnSetTextSearchLog(Log: TlogicalMDNSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TMDNColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TMDNColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: Result := actTDate;
    MDN_ID: Result := actinteger;
    MDN_NRN: Result := actAnsiString;
    MDN_NUMBER: Result := actinteger;
    MDN_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TMDNColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TMDNColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  MDN: TMDNItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  MDN := Items[ARow];
  if not Assigned(MDN.PRecord) then
  begin
    New(MDN.PRecord);
    MDN.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TMDNItem.TPropertyIndex(ACol) of
      MDN_DATA: isOld :=  MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    MDN_ID: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    MDN_NRN: isOld :=  MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    MDN_NUMBER: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
    if MDN.PRecord.setProp = [] then
    begin
      Dispose(MDN.PRecord);
      MDN.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
  case TMDNItem.TPropertyIndex(ACol) of
    MDN_DATA: MDN.PRecord.DATA := StrToDate(AValue);
    MDN_ID: MDN.PRecord.ID := StrToInt(AValue);
    MDN_NRN: MDN.PRecord.NRN := AValue;
    MDN_NUMBER: MDN.PRecord.NUMBER := StrToInt(AValue);
    MDN_Logical: MDN.PRecord.Logical := tlogicalMDNSet(MDN.StrToLogical32(AValue));
  end;
end;

procedure TMDNColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  MDN: TMDNItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  MDN := Items[ARow];
  if not Assigned(MDN.PRecord) then
  begin
    New(MDN.PRecord);
    MDN.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TMDNItem.TPropertyIndex(ACol) of
      MDN_DATA: isOld :=  MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    MDN_ID: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    MDN_NRN: isOld :=  MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    MDN_NUMBER: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
    if MDN.PRecord.setProp = [] then
    begin
      Dispose(MDN.PRecord);
      MDN.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
  case TMDNItem.TPropertyIndex(ACol) of
    MDN_DATA: MDN.PRecord.DATA := StrToDate(AFieldText);
    MDN_ID: MDN.PRecord.ID := StrToInt(AFieldText);
    MDN_NRN: MDN.PRecord.NRN := AFieldText;
    MDN_NUMBER: MDN.PRecord.NUMBER := StrToInt(AFieldText);
    MDN_Logical: MDN.PRecord.Logical := tlogicalMDNSet(MDN.StrToLogical32(AFieldText));
  end;
end;

procedure TMDNColl.SetItem(Index: Integer; const Value: TMDNItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TMDNColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListMDNSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TMDNItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  MDN_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListMDNSearch.Add(self.Items[i]);
        end;
      end;
      MDN_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListMDNSearch.Add(self.Items[i]);
        end;
      end;
      MDN_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListMDNSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TMDNColl.ShowGrid(Grid: TTeeGrid);
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

procedure TMDNColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TMDNItem>);
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

procedure TMDNColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListMDNSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListMDNSearch.Count]);

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

procedure TMDNColl.SortByIndexAnsiString;
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

procedure TMDNColl.SortByIndexInt;
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

procedure TMDNColl.SortByIndexWord;
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

procedure TMDNColl.SortByIndexValue(propIndex: TMDNItem.TPropertyIndex);
begin
  case propIndex of
    MDN_ID: SortByIndexInt;
      MDN_NRN: SortByIndexAnsiString;
      MDN_NUMBER: SortByIndexInt;
  end;
end;

end.