unit Table.Diagnosis;

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

TLogicalDiagnosis = (
    use_CL076_Chief_Complaint,
    use_CL076_Comorbidity,
    RegisterForObservation,
    ClinicalStatus_Active,
    ClinicalStatus_Recurrence,
    ClinicalStatus_Relapse,
    ClinicalStatus_Inactive,
    ClinicalStatus_Remission,
    ClinicalStatus_Resolved,
    VerificationStatusUnconfirmed,
    VerificationStatusProvisional,
    VerificationStatusDifferential,
    VerificationStatusConfirmed,
    VerificationStatusRefuted,
    VerificationStatusEntered_Error);
TlogicalDiagnosisSet = set of TLogicalDiagnosis;


TDiagnosisItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Diagnosis_code_CL011
       , Diagnosis_additionalCode_CL011
       , Diagnosis_rank
       , Diagnosis_onsetDateTime
       , Diagnosis_CL011Pos
       , Diagnosis_MkbPos
       , Diagnosis_MkbAddPos
       , Diagnosis_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecDiagnosis = ^TRecDiagnosis;
      TRecDiagnosis = record
        code_CL011: AnsiString;
        additionalCode_CL011: AnsiString;
        rank: word;
        onsetDateTime: TDate;
        CL011Pos: cardinal;
        MkbPos: cardinal;
        MkbAddPos: cardinal;
        Logical: TlogicalDiagnosisSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecDiagnosis;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertDiagnosis;
    procedure UpdateDiagnosis;
    procedure SaveDiagnosis(var dataPosition: Cardinal)overload;
	procedure SaveDiagnosis(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;


  end;


  TDiagnosisColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TDiagnosisItem;
    function GetItem(Index: Integer): TDiagnosisItem;
    procedure SetItem(Index: Integer; const Value: TDiagnosisItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TDiagnosisItem>;
    ListDiagnosisSearch: TList<TDiagnosisItem>;
	PRecordSearch: ^TDiagnosisItem.TRecDiagnosis;
    ArrPropSearch: TArray<TDiagnosisItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TDiagnosisItem.TPropertyIndex>;
	VisibleColl: TDiagnosisItem.TSetProp;
	ArrayPropOrder: TArray<TDiagnosisItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TDiagnosisItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Diagnosis: TDiagnosisItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Diagnosis: TDiagnosisItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TDiagnosisItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TDiagnosisItem.TPropertyIndex);
    property Items[Index: Integer]: TDiagnosisItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalDiagnosisSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
  function GetCollDelType: TCollectionsType; override;

  end;

implementation

{ TDiagnosisItem }

constructor TDiagnosisItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TDiagnosisItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TDiagnosisItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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


function TDiagnosisItem.GetCollType: TCollectionsType;
begin
  Result := ctDiagnosis;
end;

function TDiagnosisItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TDiagnosisItem.InsertDiagnosis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDiagnosis;
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
            Diagnosis_code_CL011: SaveData(PRecord.code_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_additionalCode_CL011: SaveData(PRecord.additionalCode_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_rank: SaveData(PRecord.rank, PropPosition, metaPosition, dataPosition);
            Diagnosis_onsetDateTime: SaveData(PRecord.onsetDateTime, PropPosition, metaPosition, dataPosition);
            Diagnosis_CL011Pos: SaveData(PRecord.CL011Pos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbPos: SaveData(PRecord.MkbPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbAddPos: SaveData(PRecord.MkbAddPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TDiagnosisItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TDiagnosisItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TDiagnosisItem;
begin
  Result := True;
  for i := 0 to Length(TDiagnosisColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TDiagnosisColl(coll).ArrPropSearchClc[i];
	ATempItem := TDiagnosisColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Diagnosis_code_CL011: Result := IsFinded(ATempItem.PRecord.code_CL011, buf, FPosDataADB, word(Diagnosis_code_CL011), cot);
            Diagnosis_additionalCode_CL011: Result := IsFinded(ATempItem.PRecord.additionalCode_CL011, buf, FPosDataADB, word(Diagnosis_additionalCode_CL011), cot);
            Diagnosis_rank: Result := IsFinded(ATempItem.PRecord.rank, buf, FPosDataADB, word(Diagnosis_rank), cot);
            Diagnosis_onsetDateTime: Result := IsFinded(ATempItem.PRecord.onsetDateTime, buf, FPosDataADB, word(Diagnosis_onsetDateTime), cot);
            Diagnosis_CL011Pos: Result := IsFinded(ATempItem.PRecord.CL011Pos, buf, FPosDataADB, word(Diagnosis_CL011Pos), cot);
            Diagnosis_MkbPos: Result := IsFinded(ATempItem.PRecord.MkbPos, buf, FPosDataADB, word(Diagnosis_MkbPos), cot);
            Diagnosis_MkbAddPos: Result := IsFinded(ATempItem.PRecord.MkbAddPos, buf, FPosDataADB, word(Diagnosis_MkbAddPos), cot);
            Diagnosis_Logical: Result := IsFinded(TLogicalData16(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Diagnosis_Logical), cot);
      end;
    end;
  end;
end;



procedure TDiagnosisItem.SaveDiagnosis(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveDiagnosis(dataPosition);
end;

procedure TDiagnosisItem.SaveDiagnosis(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDiagnosis;
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
            Diagnosis_code_CL011: SaveData(PRecord.code_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_additionalCode_CL011: SaveData(PRecord.additionalCode_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_rank: SaveData(PRecord.rank, PropPosition, metaPosition, dataPosition);
            Diagnosis_onsetDateTime: SaveData(PRecord.onsetDateTime, PropPosition, metaPosition, dataPosition);
            Diagnosis_CL011Pos: SaveData(PRecord.CL011Pos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbPos: SaveData(PRecord.MkbPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbAddPos: SaveData(PRecord.MkbAddPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TDiagnosisItem.UpdateDiagnosis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDiagnosis;
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
            Diagnosis_code_CL011: UpdateData(PRecord.code_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_additionalCode_CL011: UpdateData(PRecord.additionalCode_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_rank: UpdateData(PRecord.rank, PropPosition, metaPosition, dataPosition);
            Diagnosis_onsetDateTime: UpdateData(PRecord.onsetDateTime, PropPosition, metaPosition, dataPosition);
            Diagnosis_CL011Pos: UpdateData(PRecord.CL011Pos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbPos: UpdateData(PRecord.MkbPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbAddPos: UpdateData(PRecord.MkbAddPos, PropPosition, metaPosition, dataPosition);
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

{ TDiagnosisColl }

function TDiagnosisColl.AddItem(ver: word): TDiagnosisItem;
begin
  Result := TDiagnosisItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TDiagnosisColl.AddItemForSearch: Integer;
var
  ItemForSearch: TDiagnosisItem;
begin
  ItemForSearch := TDiagnosisItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TDiagnosisColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TDiagnosisItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TDiagnosisColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvDiagnosisRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TDiagnosisColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TDiagnosisItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (Diagnosis_code_CL011 in tempItem.PRecord.setProp) and (tempItem.PRecord.code_CL011 <> Self.getAnsiStringMap(tempItem.DataPos, word(Diagnosis_code_CL011))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_additionalCode_CL011 in tempItem.PRecord.setProp) and (tempItem.PRecord.additionalCode_CL011 <> Self.getAnsiStringMap(tempItem.DataPos, word(Diagnosis_additionalCode_CL011))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_rank in tempItem.PRecord.setProp) and (tempItem.PRecord.rank <> Self.getIntMap(tempItem.DataPos, word(Diagnosis_rank))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_onsetDateTime in tempItem.PRecord.setProp) and (tempItem.PRecord.onsetDateTime <> Self.getDateMap(tempItem.DataPos, word(Diagnosis_onsetDateTime))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_CL011Pos in tempItem.PRecord.setProp) and (tempItem.PRecord.CL011Pos <> Self.getIntMap(tempItem.DataPos, word(Diagnosis_CL011Pos))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_MkbPos in tempItem.PRecord.setProp) and (tempItem.PRecord.MkbPos <> Self.getIntMap(tempItem.DataPos, word(Diagnosis_MkbPos))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_MkbAddPos in tempItem.PRecord.setProp) and (tempItem.PRecord.MkbAddPos <> Self.getIntMap(tempItem.DataPos, word(Diagnosis_MkbAddPos))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Diagnosis_Logical in tempItem.PRecord.setProp) and (TLogicalData16(tempItem.PRecord.Logical) <> Self.getLogical16Map(tempItem.DataPos, word(Diagnosis_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TDiagnosisColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TDiagnosisItem.Create(nil);
  ListDiagnosisSearch := TList<TDiagnosisItem>.Create;
  ListForFinder := TList<TDiagnosisItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TDiagnosisColl.destroy;
begin
  FreeAndNil(ListDiagnosisSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TDiagnosisColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: Result := 'code_CL011';
    Diagnosis_additionalCode_CL011: Result := 'additionalCode_CL011';
    Diagnosis_rank: Result := 'rank';
    Diagnosis_onsetDateTime: Result := 'onsetDateTime';
    Diagnosis_CL011Pos: Result := 'CL011Pos';
    Diagnosis_MkbPos: Result := 'MkbPos';
    Diagnosis_MkbAddPos: Result := 'MkbAddPos';
    Diagnosis_Logical: Result := 'Logical';
  end;
end;

function TDiagnosisColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'use_CL076_Chief_Complaint';
    1: Result := 'use_CL076_Comorbidity';
    2: Result := 'RegisterForObservation';
    3: Result := 'ClinicalStatus_Active';
    4: Result := 'ClinicalStatus_Recurrence';
    5: Result := 'ClinicalStatus_Relapse';
    6: Result := 'ClinicalStatus_Inactive';
    7: Result := 'ClinicalStatus_Remission';
    8: Result := 'ClinicalStatus_Resolved';
    9: Result := 'VerificationStatusUnconfirmed';
    10: Result := 'VerificationStatusProvisional';
    11: Result := 'VerificationStatusDifferential';
    12: Result := 'VerificationStatusConfirmed';
    13: Result := 'VerificationStatusRefuted';
    14: Result := 'VerificationStatusEntered_Error';
  else
    Result := '???';
  end;
end;


procedure TDiagnosisColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TDiagnosisColl.FieldCount: Integer; 
begin
  inherited;
  Result := 8;
end;

function TDiagnosisColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvDiagnosisRoot then
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

function TDiagnosisColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TDiagnosisColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TDiagnosisColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TDiagnosisColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Diagnosis: TDiagnosisItem;
  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Diagnosis := Items[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(Diagnosis.PRecord) and (prop in Diagnosis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Diagnosis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Diagnosis, AValue);
  end;
end;

procedure TDiagnosisColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
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

procedure TDiagnosisColl.GetCellFromRecord(propIndex: word; Diagnosis: TDiagnosisItem; var AValue: String);
var
  str: string;
begin
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: str := (Diagnosis.PRecord.code_CL011);
    Diagnosis_additionalCode_CL011: str := (Diagnosis.PRecord.additionalCode_CL011);
    Diagnosis_rank: str := inttostr(Diagnosis.PRecord.rank);
    Diagnosis_onsetDateTime: str := AspDateToStr(Diagnosis.PRecord.onsetDateTime);
    Diagnosis_CL011Pos: str := inttostr(Diagnosis.PRecord.CL011Pos);
    Diagnosis_MkbPos: str := inttostr(Diagnosis.PRecord.MkbPos);
    Diagnosis_MkbAddPos: str := inttostr(Diagnosis.PRecord.MkbAddPos);
    Diagnosis_Logical: str := Diagnosis.Logical16ToStr(TLogicalData16(Diagnosis.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TDiagnosisColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TDiagnosisItem;
  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TDiagnosisColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TDiagnosisColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Diagnosis: TDiagnosisItem;
  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Diagnosis := ListDiagnosisSearch[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(Diagnosis.PRecord) and (prop in Diagnosis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Diagnosis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Diagnosis, AValue);
  end;
end;

function TDiagnosisColl.GetCollDelType: TCollectionsType;
begin
  Result := ctDiagnosisDel;
end;

function TDiagnosisColl.GetCollType: TCollectionsType;
begin
  Result := ctDiagnosis;
end;

procedure TDiagnosisColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Diagnosis: TDiagnosisItem;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Diagnosis := Items[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(Diagnosis.PRecord) and (prop in Diagnosis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Diagnosis, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Diagnosis, AFieldText);
  end;
end;

procedure TDiagnosisColl.GetCellFromMap(propIndex: word; ARow: Integer; Diagnosis: TDiagnosisItem; var AValue: String);
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
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: str :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Diagnosis_additionalCode_CL011: str :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Diagnosis_rank: str :=  inttostr(Diagnosis.getWordMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_onsetDateTime: str :=  AspDateToStr(Diagnosis.getDateMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_CL011Pos: str :=  inttostr(Diagnosis.getIntMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_MkbPos: str :=  inttostr(Diagnosis.getIntMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_MkbAddPos: str :=  inttostr(Diagnosis.getIntMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_Logical: str :=  Diagnosis.Logical16ToStr(Diagnosis.getLogical16Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TDiagnosisColl.GetItem(Index: Integer): TDiagnosisItem;
begin
  Result := TDiagnosisItem(inherited GetItem(Index));
end;


procedure TDiagnosisColl.IndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TDiagnosisItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Diagnosis_code_CL011:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Diagnosis_additionalCode_CL011:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Diagnosis_rank: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TDiagnosisColl.IndexValueListNodes(propIndex: TDiagnosisItem.TPropertyIndex);
begin

end;

function TDiagnosisColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TDiagnosisItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;




procedure TDiagnosisColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TDiagnosisItem;
begin
  if index < 0 then
  begin
    Tempitem := TDiagnosisItem.Create(nil);
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
procedure TDiagnosisColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TDiagnosisItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TDiagnosisItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TDiagnosisItem.TPropertyIndex(Field) of
Diagnosis_code_CL011: ListForFinder[0].PRecord.code_CL011 := AText;
    Diagnosis_additionalCode_CL011: ListForFinder[0].PRecord.additionalCode_CL011 := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TDiagnosisColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TDiagnosisItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TDiagnosisItem.TPropertyIndex(Field) of
Diagnosis_onsetDateTime: ListForFinder[0].PRecord.onsetDateTime := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TDiagnosisColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TDiagnosisItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TDiagnosisItem.TPropertyIndex(Field) of
Diagnosis_rank: ListForFinder[0].PRecord.rank := Value;
    Diagnosis_CL011Pos: ListForFinder[0].PRecord.CL011Pos := Value;
    Diagnosis_MkbPos: ListForFinder[0].PRecord.MkbPos := Value;
    Diagnosis_MkbAddPos: ListForFinder[0].PRecord.MkbAddPos := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TDiagnosisColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TDiagnosisItem.TPropertyIndex(Field) of
    Diagnosis_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalDiagnosis(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalDiagnosis(logIndex))   
    end;
  end;
end;


procedure TDiagnosisColl.OnSetTextSearchLog(Log: TlogicalDiagnosisSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TDiagnosisColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TDiagnosisColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: Result := actAnsiString;
    Diagnosis_additionalCode_CL011: Result := actAnsiString;
    Diagnosis_rank: Result := actword;
    Diagnosis_onsetDateTime: Result := actTDate;
    Diagnosis_CL011Pos: Result := actcardinal;
    Diagnosis_MkbPos: Result := actcardinal;
    Diagnosis_MkbAddPos: Result := actcardinal;
    Diagnosis_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TDiagnosisColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TDiagnosisColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Diagnosis: TDiagnosisItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Diagnosis := Items[ARow];
  if not Assigned(Diagnosis.PRecord) then
  begin
    New(Diagnosis.PRecord);
    Diagnosis.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TDiagnosisItem.TPropertyIndex(ACol) of
      Diagnosis_code_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Diagnosis_additionalCode_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Diagnosis_rank: isOld :=  Diagnosis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Diagnosis_onsetDateTime: isOld :=  Diagnosis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Diagnosis_CL011Pos: isOld :=  Diagnosis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Diagnosis_MkbPos: isOld :=  Diagnosis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Diagnosis_MkbAddPos: isOld :=  Diagnosis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
    if Diagnosis.PRecord.setProp = [] then
    begin
      Dispose(Diagnosis.PRecord);
      Diagnosis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
  case TDiagnosisItem.TPropertyIndex(ACol) of
    Diagnosis_code_CL011: Diagnosis.PRecord.code_CL011 := AValue;
    Diagnosis_additionalCode_CL011: Diagnosis.PRecord.additionalCode_CL011 := AValue;
    Diagnosis_rank: Diagnosis.PRecord.rank := StrToInt(AValue);
    Diagnosis_onsetDateTime: Diagnosis.PRecord.onsetDateTime := StrToDate(AValue);
    Diagnosis_CL011Pos: Diagnosis.PRecord.CL011Pos := StrToInt(AValue);
    Diagnosis_MkbPos: Diagnosis.PRecord.MkbPos := StrToInt(AValue);
    Diagnosis_MkbAddPos: Diagnosis.PRecord.MkbAddPos := StrToInt(AValue);
    Diagnosis_Logical: Diagnosis.PRecord.Logical := tlogicalDiagnosisSet(Diagnosis.StrToLogical16(AValue));
  end;
end;

procedure TDiagnosisColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Diagnosis: TDiagnosisItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Diagnosis := Items[ARow];
  if not Assigned(Diagnosis.PRecord) then
  begin
    New(Diagnosis.PRecord);
    Diagnosis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TDiagnosisItem.TPropertyIndex(ACol) of
      Diagnosis_code_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Diagnosis_additionalCode_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Diagnosis_rank: isOld :=  Diagnosis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Diagnosis_onsetDateTime: isOld :=  Diagnosis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Diagnosis_CL011Pos: isOld :=  Diagnosis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Diagnosis_MkbPos: isOld :=  Diagnosis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Diagnosis_MkbAddPos: isOld :=  Diagnosis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
    if Diagnosis.PRecord.setProp = [] then
    begin
      Dispose(Diagnosis.PRecord);
      Diagnosis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
  case TDiagnosisItem.TPropertyIndex(ACol) of
    Diagnosis_code_CL011: Diagnosis.PRecord.code_CL011 := AFieldText;
    Diagnosis_additionalCode_CL011: Diagnosis.PRecord.additionalCode_CL011 := AFieldText;
    Diagnosis_rank: Diagnosis.PRecord.rank := StrToInt(AFieldText);
    Diagnosis_onsetDateTime: Diagnosis.PRecord.onsetDateTime := StrToDate(AFieldText);
    Diagnosis_CL011Pos: Diagnosis.PRecord.CL011Pos := StrToInt(AFieldText);
    Diagnosis_MkbPos: Diagnosis.PRecord.MkbPos := StrToInt(AFieldText);
    Diagnosis_MkbAddPos: Diagnosis.PRecord.MkbAddPos := StrToInt(AFieldText);
    Diagnosis_Logical: Diagnosis.PRecord.Logical := tlogicalDiagnosisSet(Diagnosis.StrToLogical16(AFieldText));
  end;
end;

procedure TDiagnosisColl.SetItem(Index: Integer; const Value: TDiagnosisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDiagnosisColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListDiagnosisSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TDiagnosisItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Diagnosis_code_CL011:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListDiagnosisSearch.Add(self.Items[i]);
  end;
end;
      Diagnosis_additionalCode_CL011:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
      Diagnosis_rank: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TDiagnosisColl.ShowGrid(Grid: TTeeGrid);
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

procedure TDiagnosisColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TDiagnosisItem>);
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

procedure TDiagnosisColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDiagnosisSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDiagnosisSearch.Count]);

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

procedure TDiagnosisColl.SortByIndexAnsiString;
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

procedure TDiagnosisColl.SortByIndexInt;
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

procedure TDiagnosisColl.SortByIndexWord;
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

procedure TDiagnosisColl.SortByIndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
begin
  case propIndex of
    Diagnosis_code_CL011: SortByIndexAnsiString;
      Diagnosis_additionalCode_CL011: SortByIndexAnsiString;
      Diagnosis_rank: SortByIndexWord;
  end;
end;

end.