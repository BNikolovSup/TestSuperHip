unit Table.ExamImmunization;

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

TLogicalExamImmunization = (
    Is_);
TlogicalExamImmunizationSet = set of TLogicalExamImmunization;


TExamImmunizationItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       ExamImmunization_BASE_ON
       , ExamImmunization_BOOSTER
       , ExamImmunization_CERTIFICATE_NAME
       , ExamImmunization_DATA
       , ExamImmunization_DOCTOR_NAME
       , ExamImmunization_DOCTOR_UIN
       , ExamImmunization_DOSE
       , ExamImmunization_DOSE_NUMBER
       , ExamImmunization_DOSE_QUANTITY
       , ExamImmunization_EXPIRATION_DATE
       , ExamImmunization_EXT_AUTHORITY
       , ExamImmunization_EXT_COUNTRY
       , ExamImmunization_EXT_LOT_NUMBER
       , ExamImmunization_EXT_OCCURRENCE
       , ExamImmunization_EXT_PREV_IMMUNIZATION
       , ExamImmunization_EXT_SERIAL_NUMBER
       , ExamImmunization_EXT_VACCINE_ATC
       , ExamImmunization_EXT_VACCINE_INN
       , ExamImmunization_EXT_VACCINE_NAME
       , ExamImmunization_ID
       , ExamImmunization_IMMUNIZATION_ID
       , ExamImmunization_IMMUNIZATION_STATUS
       , ExamImmunization_IS_SPECIAL_CASE
       , ExamImmunization_LOT_NUMBER
       , ExamImmunization_LRN
       , ExamImmunization_NEXT_DOSE_DATE
       , ExamImmunization_NOTE
       , ExamImmunization_NRN_IMMUNIZATION
       , ExamImmunization_NRN_PREV_IMMUNIZATION
       , ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE
       , ExamImmunization_PERSON_STATUS_CHANGE_REASON
       , ExamImmunization_PREGLED_ID
       , ExamImmunization_PRIMARY_SOURCE
       , ExamImmunization_QUALIFICATION
       , ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION
       , ExamImmunization_RESULT
       , ExamImmunization_ROUTE
       , ExamImmunization_SERIAL_NUMBER
       , ExamImmunization_SERIES
       , ExamImmunization_SERIES_DOSES
       , ExamImmunization_SITE
       , ExamImmunization_SOCIAL_GROUP
       , ExamImmunization_SUBJECT_STATUS
       , ExamImmunization_UPDATED
       , ExamImmunization_UVCI
       , ExamImmunization_VACCINE_ID
       , ExamImmunization_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecExamImmunization = ^TRecExamImmunization;
      TRecExamImmunization = record
        BASE_ON: AnsiString;
        BOOSTER: integer;
        CERTIFICATE_NAME: AnsiString;
        DATA: TDate;
        DOCTOR_NAME: AnsiString;
        DOCTOR_UIN: AnsiString;
        DOSE: AnsiString;
        DOSE_NUMBER: integer;
        DOSE_QUANTITY: integer;
        EXPIRATION_DATE: TDate;
        EXT_AUTHORITY: AnsiString;
        EXT_COUNTRY: AnsiString;
        EXT_LOT_NUMBER: AnsiString;
        EXT_OCCURRENCE: TDate;
        EXT_PREV_IMMUNIZATION: integer;
        EXT_SERIAL_NUMBER: AnsiString;
        EXT_VACCINE_ATC: AnsiString;
        EXT_VACCINE_INN: AnsiString;
        EXT_VACCINE_NAME: AnsiString;
        ID: integer;
        IMMUNIZATION_ID: word;
        IMMUNIZATION_STATUS: integer;
        IS_SPECIAL_CASE: integer;
        LOT_NUMBER: AnsiString;
        LRN: AnsiString;
        NEXT_DOSE_DATE: TDate;
        NOTE: AnsiString;
        NRN_IMMUNIZATION: AnsiString;
        NRN_PREV_IMMUNIZATION: AnsiString;
        PERSON_STATUS_CHANGE_ON_DATE: TDate;
        PERSON_STATUS_CHANGE_REASON: AnsiString;
        PREGLED_ID: integer;
        PRIMARY_SOURCE: integer;
        QUALIFICATION: AnsiString;
        REASON_TO_CANCEL_IMMUNIZATION: AnsiString;
        RESULT: AnsiString;
        ROUTE: AnsiString;
        SERIAL_NUMBER: AnsiString;
        SERIES: AnsiString;
        SERIES_DOSES: integer;
        SITE: AnsiString;
        SOCIAL_GROUP: integer;
        SUBJECT_STATUS: integer;
        UPDATED: integer;
        UVCI: AnsiString;
        VACCINE_ID: integer;
        Logical: TlogicalExamImmunizationSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecExamImmunization;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertExamImmunization;
    procedure UpdateExamImmunization;
    procedure SaveExamImmunization(var dataPosition: Cardinal)overload;
	procedure SaveExamImmunization(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TExamImmunizationColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TExamImmunizationItem;
    function GetItem(Index: Integer): TExamImmunizationItem;
    procedure SetItem(Index: Integer; const Value: TExamImmunizationItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TExamImmunizationItem>;
    ListExamImmunizationSearch: TList<TExamImmunizationItem>;
	PRecordSearch: ^TExamImmunizationItem.TRecExamImmunization;
    ArrPropSearch: TArray<TExamImmunizationItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TExamImmunizationItem.TPropertyIndex>;
	VisibleColl: TExamImmunizationItem.TSetProp;
	ArrayPropOrder: TArray<TExamImmunizationItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TExamImmunizationItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; ExamImmunization: TExamImmunizationItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; ExamImmunization: TExamImmunizationItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TExamImmunizationItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamImmunizationItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TExamImmunizationItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TExamImmunizationItem.TPropertyIndex);
    property Items[Index: Integer]: TExamImmunizationItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalExamImmunizationSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TExamImmunizationItem }

constructor TExamImmunizationItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TExamImmunizationItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TExamImmunizationItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TExamImmunizationItem.GetCollType: TCollectionsType;
begin
  Result := ctExamImmunization;
end;

function TExamImmunizationItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TExamImmunizationItem.InsertExamImmunization;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctExamImmunization;
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
            ExamImmunization_BASE_ON: SaveData(PRecord.BASE_ON, PropPosition, metaPosition, dataPosition);
            ExamImmunization_BOOSTER: SaveData(PRecord.BOOSTER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_CERTIFICATE_NAME: SaveData(PRecord.CERTIFICATE_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOCTOR_NAME: SaveData(PRecord.DOCTOR_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOCTOR_UIN: SaveData(PRecord.DOCTOR_UIN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE: SaveData(PRecord.DOSE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE_NUMBER: SaveData(PRecord.DOSE_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE_QUANTITY: SaveData(PRecord.DOSE_QUANTITY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXPIRATION_DATE: SaveData(PRecord.EXPIRATION_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_AUTHORITY: SaveData(PRecord.EXT_AUTHORITY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_COUNTRY: SaveData(PRecord.EXT_COUNTRY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_LOT_NUMBER: SaveData(PRecord.EXT_LOT_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_OCCURRENCE: SaveData(PRecord.EXT_OCCURRENCE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_PREV_IMMUNIZATION: SaveData(PRecord.EXT_PREV_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_SERIAL_NUMBER: SaveData(PRecord.EXT_SERIAL_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_ATC: SaveData(PRecord.EXT_VACCINE_ATC, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_INN: SaveData(PRecord.EXT_VACCINE_INN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_NAME: SaveData(PRecord.EXT_VACCINE_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IMMUNIZATION_ID: SaveData(PRecord.IMMUNIZATION_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IMMUNIZATION_STATUS: SaveData(PRecord.IMMUNIZATION_STATUS, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IS_SPECIAL_CASE: SaveData(PRecord.IS_SPECIAL_CASE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_LOT_NUMBER: SaveData(PRecord.LOT_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_LRN: SaveData(PRecord.LRN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NEXT_DOSE_DATE: SaveData(PRecord.NEXT_DOSE_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NOTE: SaveData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NRN_IMMUNIZATION: SaveData(PRecord.NRN_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NRN_PREV_IMMUNIZATION: SaveData(PRecord.NRN_PREV_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: SaveData(PRecord.PERSON_STATUS_CHANGE_ON_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PERSON_STATUS_CHANGE_REASON: SaveData(PRecord.PERSON_STATUS_CHANGE_REASON, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PRIMARY_SOURCE: SaveData(PRecord.PRIMARY_SOURCE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_QUALIFICATION: SaveData(PRecord.QUALIFICATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: SaveData(PRecord.REASON_TO_CANCEL_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_RESULT: SaveData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamImmunization_ROUTE: SaveData(PRecord.ROUTE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIAL_NUMBER: SaveData(PRecord.SERIAL_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIES: SaveData(PRecord.SERIES, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIES_DOSES: SaveData(PRecord.SERIES_DOSES, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SITE: SaveData(PRecord.SITE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SOCIAL_GROUP: SaveData(PRecord.SOCIAL_GROUP, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SUBJECT_STATUS: SaveData(PRecord.SUBJECT_STATUS, PropPosition, metaPosition, dataPosition);
            ExamImmunization_UPDATED: SaveData(PRecord.UPDATED, PropPosition, metaPosition, dataPosition);
            ExamImmunization_UVCI: SaveData(PRecord.UVCI, PropPosition, metaPosition, dataPosition);
            ExamImmunization_VACCINE_ID: SaveData(PRecord.VACCINE_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TExamImmunizationItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TExamImmunizationItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TExamImmunizationItem;
begin
  Result := True;
  for i := 0 to Length(TExamImmunizationColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TExamImmunizationColl(coll).ArrPropSearchClc[i];
	ATempItem := TExamImmunizationColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        ExamImmunization_BASE_ON: Result := IsFinded(ATempItem.PRecord.BASE_ON, buf, FPosDataADB, word(ExamImmunization_BASE_ON), cot);
            ExamImmunization_BOOSTER: Result := IsFinded(ATempItem.PRecord.BOOSTER, buf, FPosDataADB, word(ExamImmunization_BOOSTER), cot);
            ExamImmunization_CERTIFICATE_NAME: Result := IsFinded(ATempItem.PRecord.CERTIFICATE_NAME, buf, FPosDataADB, word(ExamImmunization_CERTIFICATE_NAME), cot);
            ExamImmunization_DATA: Result := IsFinded(ATempItem.PRecord.DATA, buf, FPosDataADB, word(ExamImmunization_DATA), cot);
            ExamImmunization_DOCTOR_NAME: Result := IsFinded(ATempItem.PRecord.DOCTOR_NAME, buf, FPosDataADB, word(ExamImmunization_DOCTOR_NAME), cot);
            ExamImmunization_DOCTOR_UIN: Result := IsFinded(ATempItem.PRecord.DOCTOR_UIN, buf, FPosDataADB, word(ExamImmunization_DOCTOR_UIN), cot);
            ExamImmunization_DOSE: Result := IsFinded(ATempItem.PRecord.DOSE, buf, FPosDataADB, word(ExamImmunization_DOSE), cot);
            ExamImmunization_DOSE_NUMBER: Result := IsFinded(ATempItem.PRecord.DOSE_NUMBER, buf, FPosDataADB, word(ExamImmunization_DOSE_NUMBER), cot);
            ExamImmunization_DOSE_QUANTITY: Result := IsFinded(ATempItem.PRecord.DOSE_QUANTITY, buf, FPosDataADB, word(ExamImmunization_DOSE_QUANTITY), cot);
            ExamImmunization_EXPIRATION_DATE: Result := IsFinded(ATempItem.PRecord.EXPIRATION_DATE, buf, FPosDataADB, word(ExamImmunization_EXPIRATION_DATE), cot);
            ExamImmunization_EXT_AUTHORITY: Result := IsFinded(ATempItem.PRecord.EXT_AUTHORITY, buf, FPosDataADB, word(ExamImmunization_EXT_AUTHORITY), cot);
            ExamImmunization_EXT_COUNTRY: Result := IsFinded(ATempItem.PRecord.EXT_COUNTRY, buf, FPosDataADB, word(ExamImmunization_EXT_COUNTRY), cot);
            ExamImmunization_EXT_LOT_NUMBER: Result := IsFinded(ATempItem.PRecord.EXT_LOT_NUMBER, buf, FPosDataADB, word(ExamImmunization_EXT_LOT_NUMBER), cot);
            ExamImmunization_EXT_OCCURRENCE: Result := IsFinded(ATempItem.PRecord.EXT_OCCURRENCE, buf, FPosDataADB, word(ExamImmunization_EXT_OCCURRENCE), cot);
            ExamImmunization_EXT_PREV_IMMUNIZATION: Result := IsFinded(ATempItem.PRecord.EXT_PREV_IMMUNIZATION, buf, FPosDataADB, word(ExamImmunization_EXT_PREV_IMMUNIZATION), cot);
            ExamImmunization_EXT_SERIAL_NUMBER: Result := IsFinded(ATempItem.PRecord.EXT_SERIAL_NUMBER, buf, FPosDataADB, word(ExamImmunization_EXT_SERIAL_NUMBER), cot);
            ExamImmunization_EXT_VACCINE_ATC: Result := IsFinded(ATempItem.PRecord.EXT_VACCINE_ATC, buf, FPosDataADB, word(ExamImmunization_EXT_VACCINE_ATC), cot);
            ExamImmunization_EXT_VACCINE_INN: Result := IsFinded(ATempItem.PRecord.EXT_VACCINE_INN, buf, FPosDataADB, word(ExamImmunization_EXT_VACCINE_INN), cot);
            ExamImmunization_EXT_VACCINE_NAME: Result := IsFinded(ATempItem.PRecord.EXT_VACCINE_NAME, buf, FPosDataADB, word(ExamImmunization_EXT_VACCINE_NAME), cot);
            ExamImmunization_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(ExamImmunization_ID), cot);
            ExamImmunization_IMMUNIZATION_ID: Result := IsFinded(ATempItem.PRecord.IMMUNIZATION_ID, buf, FPosDataADB, word(ExamImmunization_IMMUNIZATION_ID), cot);
            ExamImmunization_IMMUNIZATION_STATUS: Result := IsFinded(ATempItem.PRecord.IMMUNIZATION_STATUS, buf, FPosDataADB, word(ExamImmunization_IMMUNIZATION_STATUS), cot);
            ExamImmunization_IS_SPECIAL_CASE: Result := IsFinded(ATempItem.PRecord.IS_SPECIAL_CASE, buf, FPosDataADB, word(ExamImmunization_IS_SPECIAL_CASE), cot);
            ExamImmunization_LOT_NUMBER: Result := IsFinded(ATempItem.PRecord.LOT_NUMBER, buf, FPosDataADB, word(ExamImmunization_LOT_NUMBER), cot);
            ExamImmunization_LRN: Result := IsFinded(ATempItem.PRecord.LRN, buf, FPosDataADB, word(ExamImmunization_LRN), cot);
            ExamImmunization_NEXT_DOSE_DATE: Result := IsFinded(ATempItem.PRecord.NEXT_DOSE_DATE, buf, FPosDataADB, word(ExamImmunization_NEXT_DOSE_DATE), cot);
            ExamImmunization_NOTE: Result := IsFinded(ATempItem.PRecord.NOTE, buf, FPosDataADB, word(ExamImmunization_NOTE), cot);
            ExamImmunization_NRN_IMMUNIZATION: Result := IsFinded(ATempItem.PRecord.NRN_IMMUNIZATION, buf, FPosDataADB, word(ExamImmunization_NRN_IMMUNIZATION), cot);
            ExamImmunization_NRN_PREV_IMMUNIZATION: Result := IsFinded(ATempItem.PRecord.NRN_PREV_IMMUNIZATION, buf, FPosDataADB, word(ExamImmunization_NRN_PREV_IMMUNIZATION), cot);
            ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: Result := IsFinded(ATempItem.PRecord.PERSON_STATUS_CHANGE_ON_DATE, buf, FPosDataADB, word(ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE), cot);
            ExamImmunization_PERSON_STATUS_CHANGE_REASON: Result := IsFinded(ATempItem.PRecord.PERSON_STATUS_CHANGE_REASON, buf, FPosDataADB, word(ExamImmunization_PERSON_STATUS_CHANGE_REASON), cot);
            ExamImmunization_PREGLED_ID: Result := IsFinded(ATempItem.PRecord.PREGLED_ID, buf, FPosDataADB, word(ExamImmunization_PREGLED_ID), cot);
            ExamImmunization_PRIMARY_SOURCE: Result := IsFinded(ATempItem.PRecord.PRIMARY_SOURCE, buf, FPosDataADB, word(ExamImmunization_PRIMARY_SOURCE), cot);
            ExamImmunization_QUALIFICATION: Result := IsFinded(ATempItem.PRecord.QUALIFICATION, buf, FPosDataADB, word(ExamImmunization_QUALIFICATION), cot);
            ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: Result := IsFinded(ATempItem.PRecord.REASON_TO_CANCEL_IMMUNIZATION, buf, FPosDataADB, word(ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION), cot);
            ExamImmunization_RESULT: Result := IsFinded(ATempItem.PRecord.RESULT, buf, FPosDataADB, word(ExamImmunization_RESULT), cot);
            ExamImmunization_ROUTE: Result := IsFinded(ATempItem.PRecord.ROUTE, buf, FPosDataADB, word(ExamImmunization_ROUTE), cot);
            ExamImmunization_SERIAL_NUMBER: Result := IsFinded(ATempItem.PRecord.SERIAL_NUMBER, buf, FPosDataADB, word(ExamImmunization_SERIAL_NUMBER), cot);
            ExamImmunization_SERIES: Result := IsFinded(ATempItem.PRecord.SERIES, buf, FPosDataADB, word(ExamImmunization_SERIES), cot);
            ExamImmunization_SERIES_DOSES: Result := IsFinded(ATempItem.PRecord.SERIES_DOSES, buf, FPosDataADB, word(ExamImmunization_SERIES_DOSES), cot);
            ExamImmunization_SITE: Result := IsFinded(ATempItem.PRecord.SITE, buf, FPosDataADB, word(ExamImmunization_SITE), cot);
            ExamImmunization_SOCIAL_GROUP: Result := IsFinded(ATempItem.PRecord.SOCIAL_GROUP, buf, FPosDataADB, word(ExamImmunization_SOCIAL_GROUP), cot);
            ExamImmunization_SUBJECT_STATUS: Result := IsFinded(ATempItem.PRecord.SUBJECT_STATUS, buf, FPosDataADB, word(ExamImmunization_SUBJECT_STATUS), cot);
            ExamImmunization_UPDATED: Result := IsFinded(ATempItem.PRecord.UPDATED, buf, FPosDataADB, word(ExamImmunization_UPDATED), cot);
            ExamImmunization_UVCI: Result := IsFinded(ATempItem.PRecord.UVCI, buf, FPosDataADB, word(ExamImmunization_UVCI), cot);
            ExamImmunization_VACCINE_ID: Result := IsFinded(ATempItem.PRecord.VACCINE_ID, buf, FPosDataADB, word(ExamImmunization_VACCINE_ID), cot);
            ExamImmunization_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(ExamImmunization_Logical), cot);
      end;
    end;
  end;
end;

procedure TExamImmunizationItem.SaveExamImmunization(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveExamImmunization(dataPosition);
end;

procedure TExamImmunizationItem.SaveExamImmunization(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExamImmunization;
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
            ExamImmunization_BASE_ON: SaveData(PRecord.BASE_ON, PropPosition, metaPosition, dataPosition);
            ExamImmunization_BOOSTER: SaveData(PRecord.BOOSTER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_CERTIFICATE_NAME: SaveData(PRecord.CERTIFICATE_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOCTOR_NAME: SaveData(PRecord.DOCTOR_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOCTOR_UIN: SaveData(PRecord.DOCTOR_UIN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE: SaveData(PRecord.DOSE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE_NUMBER: SaveData(PRecord.DOSE_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE_QUANTITY: SaveData(PRecord.DOSE_QUANTITY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXPIRATION_DATE: SaveData(PRecord.EXPIRATION_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_AUTHORITY: SaveData(PRecord.EXT_AUTHORITY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_COUNTRY: SaveData(PRecord.EXT_COUNTRY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_LOT_NUMBER: SaveData(PRecord.EXT_LOT_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_OCCURRENCE: SaveData(PRecord.EXT_OCCURRENCE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_PREV_IMMUNIZATION: SaveData(PRecord.EXT_PREV_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_SERIAL_NUMBER: SaveData(PRecord.EXT_SERIAL_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_ATC: SaveData(PRecord.EXT_VACCINE_ATC, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_INN: SaveData(PRecord.EXT_VACCINE_INN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_NAME: SaveData(PRecord.EXT_VACCINE_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IMMUNIZATION_ID: SaveData(PRecord.IMMUNIZATION_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IMMUNIZATION_STATUS: SaveData(PRecord.IMMUNIZATION_STATUS, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IS_SPECIAL_CASE: SaveData(PRecord.IS_SPECIAL_CASE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_LOT_NUMBER: SaveData(PRecord.LOT_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_LRN: SaveData(PRecord.LRN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NEXT_DOSE_DATE: SaveData(PRecord.NEXT_DOSE_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NOTE: SaveData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NRN_IMMUNIZATION: SaveData(PRecord.NRN_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NRN_PREV_IMMUNIZATION: SaveData(PRecord.NRN_PREV_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: SaveData(PRecord.PERSON_STATUS_CHANGE_ON_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PERSON_STATUS_CHANGE_REASON: SaveData(PRecord.PERSON_STATUS_CHANGE_REASON, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PRIMARY_SOURCE: SaveData(PRecord.PRIMARY_SOURCE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_QUALIFICATION: SaveData(PRecord.QUALIFICATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: SaveData(PRecord.REASON_TO_CANCEL_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_RESULT: SaveData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamImmunization_ROUTE: SaveData(PRecord.ROUTE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIAL_NUMBER: SaveData(PRecord.SERIAL_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIES: SaveData(PRecord.SERIES, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIES_DOSES: SaveData(PRecord.SERIES_DOSES, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SITE: SaveData(PRecord.SITE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SOCIAL_GROUP: SaveData(PRecord.SOCIAL_GROUP, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SUBJECT_STATUS: SaveData(PRecord.SUBJECT_STATUS, PropPosition, metaPosition, dataPosition);
            ExamImmunization_UPDATED: SaveData(PRecord.UPDATED, PropPosition, metaPosition, dataPosition);
            ExamImmunization_UVCI: SaveData(PRecord.UVCI, PropPosition, metaPosition, dataPosition);
            ExamImmunization_VACCINE_ID: SaveData(PRecord.VACCINE_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TExamImmunizationItem.UpdateExamImmunization;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExamImmunization;
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
            ExamImmunization_BASE_ON: UpdateData(PRecord.BASE_ON, PropPosition, metaPosition, dataPosition);
            ExamImmunization_BOOSTER: UpdateData(PRecord.BOOSTER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_CERTIFICATE_NAME: UpdateData(PRecord.CERTIFICATE_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOCTOR_NAME: UpdateData(PRecord.DOCTOR_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOCTOR_UIN: UpdateData(PRecord.DOCTOR_UIN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE: UpdateData(PRecord.DOSE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE_NUMBER: UpdateData(PRecord.DOSE_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_DOSE_QUANTITY: UpdateData(PRecord.DOSE_QUANTITY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXPIRATION_DATE: UpdateData(PRecord.EXPIRATION_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_AUTHORITY: UpdateData(PRecord.EXT_AUTHORITY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_COUNTRY: UpdateData(PRecord.EXT_COUNTRY, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_LOT_NUMBER: UpdateData(PRecord.EXT_LOT_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_OCCURRENCE: UpdateData(PRecord.EXT_OCCURRENCE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_PREV_IMMUNIZATION: UpdateData(PRecord.EXT_PREV_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_SERIAL_NUMBER: UpdateData(PRecord.EXT_SERIAL_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_ATC: UpdateData(PRecord.EXT_VACCINE_ATC, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_INN: UpdateData(PRecord.EXT_VACCINE_INN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_EXT_VACCINE_NAME: UpdateData(PRecord.EXT_VACCINE_NAME, PropPosition, metaPosition, dataPosition);
            ExamImmunization_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IMMUNIZATION_ID: UpdateData(PRecord.IMMUNIZATION_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IMMUNIZATION_STATUS: UpdateData(PRecord.IMMUNIZATION_STATUS, PropPosition, metaPosition, dataPosition);
            ExamImmunization_IS_SPECIAL_CASE: UpdateData(PRecord.IS_SPECIAL_CASE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_LOT_NUMBER: UpdateData(PRecord.LOT_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_LRN: UpdateData(PRecord.LRN, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NEXT_DOSE_DATE: UpdateData(PRecord.NEXT_DOSE_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NOTE: UpdateData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NRN_IMMUNIZATION: UpdateData(PRecord.NRN_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_NRN_PREV_IMMUNIZATION: UpdateData(PRecord.NRN_PREV_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: UpdateData(PRecord.PERSON_STATUS_CHANGE_ON_DATE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PERSON_STATUS_CHANGE_REASON: UpdateData(PRecord.PERSON_STATUS_CHANGE_REASON, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            ExamImmunization_PRIMARY_SOURCE: UpdateData(PRecord.PRIMARY_SOURCE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_QUALIFICATION: UpdateData(PRecord.QUALIFICATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: UpdateData(PRecord.REASON_TO_CANCEL_IMMUNIZATION, PropPosition, metaPosition, dataPosition);
            ExamImmunization_RESULT: UpdateData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamImmunization_ROUTE: UpdateData(PRecord.ROUTE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIAL_NUMBER: UpdateData(PRecord.SERIAL_NUMBER, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIES: UpdateData(PRecord.SERIES, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SERIES_DOSES: UpdateData(PRecord.SERIES_DOSES, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SITE: UpdateData(PRecord.SITE, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SOCIAL_GROUP: UpdateData(PRecord.SOCIAL_GROUP, PropPosition, metaPosition, dataPosition);
            ExamImmunization_SUBJECT_STATUS: UpdateData(PRecord.SUBJECT_STATUS, PropPosition, metaPosition, dataPosition);
            ExamImmunization_UPDATED: UpdateData(PRecord.UPDATED, PropPosition, metaPosition, dataPosition);
            ExamImmunization_UVCI: UpdateData(PRecord.UVCI, PropPosition, metaPosition, dataPosition);
            ExamImmunization_VACCINE_ID: UpdateData(PRecord.VACCINE_ID, PropPosition, metaPosition, dataPosition);
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

{ TExamImmunizationColl }

function TExamImmunizationColl.AddItem(ver: word): TExamImmunizationItem;
begin
  Result := TExamImmunizationItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TExamImmunizationColl.AddItemForSearch: Integer;
var
  ItemForSearch: TExamImmunizationItem;
begin
  ItemForSearch := TExamImmunizationItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TExamImmunizationColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TExamImmunizationItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TExamImmunizationColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvExamImmunizationRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TExamImmunizationColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TExamImmunizationItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (ExamImmunization_BASE_ON in tempItem.PRecord.setProp) and (tempItem.PRecord.BASE_ON <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_BASE_ON))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_BOOSTER in tempItem.PRecord.setProp) and (tempItem.PRecord.BOOSTER <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_BOOSTER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_CERTIFICATE_NAME in tempItem.PRecord.setProp) and (tempItem.PRecord.CERTIFICATE_NAME <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_CERTIFICATE_NAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_DATA in tempItem.PRecord.setProp) and (tempItem.PRecord.DATA <> Self.getDateMap(tempItem.DataPos, word(ExamImmunization_DATA))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_DOCTOR_NAME in tempItem.PRecord.setProp) and (tempItem.PRecord.DOCTOR_NAME <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_DOCTOR_NAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_DOCTOR_UIN in tempItem.PRecord.setProp) and (tempItem.PRecord.DOCTOR_UIN <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_DOCTOR_UIN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_DOSE in tempItem.PRecord.setProp) and (tempItem.PRecord.DOSE <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_DOSE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_DOSE_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.DOSE_NUMBER <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_DOSE_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_DOSE_QUANTITY in tempItem.PRecord.setProp) and (tempItem.PRecord.DOSE_QUANTITY <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_DOSE_QUANTITY))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXPIRATION_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.EXPIRATION_DATE <> Self.getDateMap(tempItem.DataPos, word(ExamImmunization_EXPIRATION_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_AUTHORITY in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_AUTHORITY <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_AUTHORITY))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_COUNTRY in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_COUNTRY <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_COUNTRY))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_LOT_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_LOT_NUMBER <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_LOT_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_OCCURRENCE in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_OCCURRENCE <> Self.getDateMap(tempItem.DataPos, word(ExamImmunization_EXT_OCCURRENCE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_PREV_IMMUNIZATION in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_PREV_IMMUNIZATION <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_EXT_PREV_IMMUNIZATION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_SERIAL_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_SERIAL_NUMBER <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_SERIAL_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_VACCINE_ATC in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_VACCINE_ATC <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_VACCINE_ATC))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_VACCINE_INN in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_VACCINE_INN <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_VACCINE_INN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_EXT_VACCINE_NAME in tempItem.PRecord.setProp) and (tempItem.PRecord.EXT_VACCINE_NAME <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_EXT_VACCINE_NAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_IMMUNIZATION_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.IMMUNIZATION_ID <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_IMMUNIZATION_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_IMMUNIZATION_STATUS in tempItem.PRecord.setProp) and (tempItem.PRecord.IMMUNIZATION_STATUS <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_IMMUNIZATION_STATUS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_IS_SPECIAL_CASE in tempItem.PRecord.setProp) and (tempItem.PRecord.IS_SPECIAL_CASE <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_IS_SPECIAL_CASE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_LOT_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.LOT_NUMBER <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_LOT_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_LRN in tempItem.PRecord.setProp) and (tempItem.PRecord.LRN <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_LRN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_NEXT_DOSE_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.NEXT_DOSE_DATE <> Self.getDateMap(tempItem.DataPos, word(ExamImmunization_NEXT_DOSE_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_NOTE in tempItem.PRecord.setProp) and (tempItem.PRecord.NOTE <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_NOTE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_NRN_IMMUNIZATION in tempItem.PRecord.setProp) and (tempItem.PRecord.NRN_IMMUNIZATION <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_NRN_IMMUNIZATION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_NRN_PREV_IMMUNIZATION in tempItem.PRecord.setProp) and (tempItem.PRecord.NRN_PREV_IMMUNIZATION <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_NRN_PREV_IMMUNIZATION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.PERSON_STATUS_CHANGE_ON_DATE <> Self.getDateMap(tempItem.DataPos, word(ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_PERSON_STATUS_CHANGE_REASON in tempItem.PRecord.setProp) and (tempItem.PRecord.PERSON_STATUS_CHANGE_REASON <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_PERSON_STATUS_CHANGE_REASON))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_PREGLED_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.PREGLED_ID <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_PREGLED_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_PRIMARY_SOURCE in tempItem.PRecord.setProp) and (tempItem.PRecord.PRIMARY_SOURCE <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_PRIMARY_SOURCE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_QUALIFICATION in tempItem.PRecord.setProp) and (tempItem.PRecord.QUALIFICATION <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_QUALIFICATION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION in tempItem.PRecord.setProp) and (tempItem.PRecord.REASON_TO_CANCEL_IMMUNIZATION <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_RESULT in tempItem.PRecord.setProp) and (tempItem.PRecord.RESULT <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_RESULT))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_ROUTE in tempItem.PRecord.setProp) and (tempItem.PRecord.ROUTE <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_ROUTE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_SERIAL_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.SERIAL_NUMBER <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_SERIAL_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_SERIES in tempItem.PRecord.setProp) and (tempItem.PRecord.SERIES <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_SERIES))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_SERIES_DOSES in tempItem.PRecord.setProp) and (tempItem.PRecord.SERIES_DOSES <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_SERIES_DOSES))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_SITE in tempItem.PRecord.setProp) and (tempItem.PRecord.SITE <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_SITE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_SOCIAL_GROUP in tempItem.PRecord.setProp) and (tempItem.PRecord.SOCIAL_GROUP <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_SOCIAL_GROUP))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_SUBJECT_STATUS in tempItem.PRecord.setProp) and (tempItem.PRecord.SUBJECT_STATUS <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_SUBJECT_STATUS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_UPDATED in tempItem.PRecord.setProp) and (tempItem.PRecord.UPDATED <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_UPDATED))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_UVCI in tempItem.PRecord.setProp) and (tempItem.PRecord.UVCI <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamImmunization_UVCI))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_VACCINE_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.VACCINE_ID <> Self.getIntMap(tempItem.DataPos, word(ExamImmunization_VACCINE_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamImmunization_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(ExamImmunization_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TExamImmunizationColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TExamImmunizationItem.Create(nil);
  ListExamImmunizationSearch := TList<TExamImmunizationItem>.Create;
  ListForFinder := TList<TExamImmunizationItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TExamImmunizationColl.destroy;
begin
  FreeAndNil(ListExamImmunizationSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TExamImmunizationColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TExamImmunizationItem.TPropertyIndex(propIndex) of
    ExamImmunization_BASE_ON: Result := 'BASE_ON';
    ExamImmunization_BOOSTER: Result := 'BOOSTER';
    ExamImmunization_CERTIFICATE_NAME: Result := 'CERTIFICATE_NAME';
    ExamImmunization_DATA: Result := 'DATA';
    ExamImmunization_DOCTOR_NAME: Result := 'DOCTOR_NAME';
    ExamImmunization_DOCTOR_UIN: Result := 'DOCTOR_UIN';
    ExamImmunization_DOSE: Result := 'DOSE';
    ExamImmunization_DOSE_NUMBER: Result := 'DOSE_NUMBER';
    ExamImmunization_DOSE_QUANTITY: Result := 'DOSE_QUANTITY';
    ExamImmunization_EXPIRATION_DATE: Result := 'EXPIRATION_DATE';
    ExamImmunization_EXT_AUTHORITY: Result := 'EXT_AUTHORITY';
    ExamImmunization_EXT_COUNTRY: Result := 'EXT_COUNTRY';
    ExamImmunization_EXT_LOT_NUMBER: Result := 'EXT_LOT_NUMBER';
    ExamImmunization_EXT_OCCURRENCE: Result := 'EXT_OCCURRENCE';
    ExamImmunization_EXT_PREV_IMMUNIZATION: Result := 'EXT_PREV_IMMUNIZATION';
    ExamImmunization_EXT_SERIAL_NUMBER: Result := 'EXT_SERIAL_NUMBER';
    ExamImmunization_EXT_VACCINE_ATC: Result := 'EXT_VACCINE_ATC';
    ExamImmunization_EXT_VACCINE_INN: Result := 'EXT_VACCINE_INN';
    ExamImmunization_EXT_VACCINE_NAME: Result := 'EXT_VACCINE_NAME';
    ExamImmunization_ID: Result := 'ID';
    ExamImmunization_IMMUNIZATION_ID: Result := 'IMMUNIZATION_ID';
    ExamImmunization_IMMUNIZATION_STATUS: Result := 'IMMUNIZATION_STATUS';
    ExamImmunization_IS_SPECIAL_CASE: Result := 'IS_SPECIAL_CASE';
    ExamImmunization_LOT_NUMBER: Result := 'LOT_NUMBER';
    ExamImmunization_LRN: Result := 'LRN';
    ExamImmunization_NEXT_DOSE_DATE: Result := 'NEXT_DOSE_DATE';
    ExamImmunization_NOTE: Result := 'NOTE';
    ExamImmunization_NRN_IMMUNIZATION: Result := 'NRN_IMMUNIZATION';
    ExamImmunization_NRN_PREV_IMMUNIZATION: Result := 'NRN_PREV_IMMUNIZATION';
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: Result := 'PERSON_STATUS_CHANGE_ON_DATE';
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: Result := 'PERSON_STATUS_CHANGE_REASON';
    ExamImmunization_PREGLED_ID: Result := 'PREGLED_ID';
    ExamImmunization_PRIMARY_SOURCE: Result := 'PRIMARY_SOURCE';
    ExamImmunization_QUALIFICATION: Result := 'QUALIFICATION';
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: Result := 'REASON_TO_CANCEL_IMMUNIZATION';
    ExamImmunization_RESULT: Result := 'RESULT';
    ExamImmunization_ROUTE: Result := 'ROUTE';
    ExamImmunization_SERIAL_NUMBER: Result := 'SERIAL_NUMBER';
    ExamImmunization_SERIES: Result := 'SERIES';
    ExamImmunization_SERIES_DOSES: Result := 'SERIES_DOSES';
    ExamImmunization_SITE: Result := 'SITE';
    ExamImmunization_SOCIAL_GROUP: Result := 'SOCIAL_GROUP';
    ExamImmunization_SUBJECT_STATUS: Result := 'SUBJECT_STATUS';
    ExamImmunization_UPDATED: Result := 'UPDATED';
    ExamImmunization_UVCI: Result := 'UVCI';
    ExamImmunization_VACCINE_ID: Result := 'VACCINE_ID';
    ExamImmunization_Logical: Result := 'Logical';
  end;
end;

function TExamImmunizationColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TExamImmunizationColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TExamImmunizationColl.FieldCount: Integer; 
begin
  inherited;
  Result := 47;
end;

function TExamImmunizationColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvExamImmunizationRoot then
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

function TExamImmunizationColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TExamImmunizationColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TExamImmunizationColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TExamImmunizationColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ExamImmunization: TExamImmunizationItem;
  ACol: Integer;
  prop: TExamImmunizationItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  ExamImmunization := Items[ARow];
  prop := TExamImmunizationItem.TPropertyIndex(ACol);
  if Assigned(ExamImmunization.PRecord) and (prop in ExamImmunization.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamImmunization, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamImmunization, AValue);
  end;
end;

procedure TExamImmunizationColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TExamImmunizationItem.TPropertyIndex;
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

procedure TExamImmunizationColl.GetCellFromRecord(propIndex: word; ExamImmunization: TExamImmunizationItem; var AValue: String);
var
  str: string;
begin
  case TExamImmunizationItem.TPropertyIndex(propIndex) of
    ExamImmunization_BASE_ON: str := (ExamImmunization.PRecord.BASE_ON);
    ExamImmunization_BOOSTER: str := inttostr(ExamImmunization.PRecord.BOOSTER);
    ExamImmunization_CERTIFICATE_NAME: str := (ExamImmunization.PRecord.CERTIFICATE_NAME);
    ExamImmunization_DATA: str := AspDateToStr(ExamImmunization.PRecord.DATA);
    ExamImmunization_DOCTOR_NAME: str := (ExamImmunization.PRecord.DOCTOR_NAME);
    ExamImmunization_DOCTOR_UIN: str := (ExamImmunization.PRecord.DOCTOR_UIN);
    ExamImmunization_DOSE: str := (ExamImmunization.PRecord.DOSE);
    ExamImmunization_DOSE_NUMBER: str := inttostr(ExamImmunization.PRecord.DOSE_NUMBER);
    ExamImmunization_DOSE_QUANTITY: str := inttostr(ExamImmunization.PRecord.DOSE_QUANTITY);
    ExamImmunization_EXPIRATION_DATE: str := AspDateToStr(ExamImmunization.PRecord.EXPIRATION_DATE);
    ExamImmunization_EXT_AUTHORITY: str := (ExamImmunization.PRecord.EXT_AUTHORITY);
    ExamImmunization_EXT_COUNTRY: str := (ExamImmunization.PRecord.EXT_COUNTRY);
    ExamImmunization_EXT_LOT_NUMBER: str := (ExamImmunization.PRecord.EXT_LOT_NUMBER);
    ExamImmunization_EXT_OCCURRENCE: str := AspDateToStr(ExamImmunization.PRecord.EXT_OCCURRENCE);
    ExamImmunization_EXT_PREV_IMMUNIZATION: str := inttostr(ExamImmunization.PRecord.EXT_PREV_IMMUNIZATION);
    ExamImmunization_EXT_SERIAL_NUMBER: str := (ExamImmunization.PRecord.EXT_SERIAL_NUMBER);
    ExamImmunization_EXT_VACCINE_ATC: str := (ExamImmunization.PRecord.EXT_VACCINE_ATC);
    ExamImmunization_EXT_VACCINE_INN: str := (ExamImmunization.PRecord.EXT_VACCINE_INN);
    ExamImmunization_EXT_VACCINE_NAME: str := (ExamImmunization.PRecord.EXT_VACCINE_NAME);
    ExamImmunization_ID: str := inttostr(ExamImmunization.PRecord.ID);
    ExamImmunization_IMMUNIZATION_ID: str := inttostr(ExamImmunization.PRecord.IMMUNIZATION_ID);
    ExamImmunization_IMMUNIZATION_STATUS: str := inttostr(ExamImmunization.PRecord.IMMUNIZATION_STATUS);
    ExamImmunization_IS_SPECIAL_CASE: str := inttostr(ExamImmunization.PRecord.IS_SPECIAL_CASE);
    ExamImmunization_LOT_NUMBER: str := (ExamImmunization.PRecord.LOT_NUMBER);
    ExamImmunization_LRN: str := (ExamImmunization.PRecord.LRN);
    ExamImmunization_NEXT_DOSE_DATE: str := AspDateToStr(ExamImmunization.PRecord.NEXT_DOSE_DATE);
    ExamImmunization_NOTE: str := (ExamImmunization.PRecord.NOTE);
    ExamImmunization_NRN_IMMUNIZATION: str := (ExamImmunization.PRecord.NRN_IMMUNIZATION);
    ExamImmunization_NRN_PREV_IMMUNIZATION: str := (ExamImmunization.PRecord.NRN_PREV_IMMUNIZATION);
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: str := AspDateToStr(ExamImmunization.PRecord.PERSON_STATUS_CHANGE_ON_DATE);
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: str := (ExamImmunization.PRecord.PERSON_STATUS_CHANGE_REASON);
    ExamImmunization_PREGLED_ID: str := inttostr(ExamImmunization.PRecord.PREGLED_ID);
    ExamImmunization_PRIMARY_SOURCE: str := inttostr(ExamImmunization.PRecord.PRIMARY_SOURCE);
    ExamImmunization_QUALIFICATION: str := (ExamImmunization.PRecord.QUALIFICATION);
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: str := (ExamImmunization.PRecord.REASON_TO_CANCEL_IMMUNIZATION);
    ExamImmunization_RESULT: str := (ExamImmunization.PRecord.RESULT);
    ExamImmunization_ROUTE: str := (ExamImmunization.PRecord.ROUTE);
    ExamImmunization_SERIAL_NUMBER: str := (ExamImmunization.PRecord.SERIAL_NUMBER);
    ExamImmunization_SERIES: str := (ExamImmunization.PRecord.SERIES);
    ExamImmunization_SERIES_DOSES: str := inttostr(ExamImmunization.PRecord.SERIES_DOSES);
    ExamImmunization_SITE: str := (ExamImmunization.PRecord.SITE);
    ExamImmunization_SOCIAL_GROUP: str := inttostr(ExamImmunization.PRecord.SOCIAL_GROUP);
    ExamImmunization_SUBJECT_STATUS: str := inttostr(ExamImmunization.PRecord.SUBJECT_STATUS);
    ExamImmunization_UPDATED: str := inttostr(ExamImmunization.PRecord.UPDATED);
    ExamImmunization_UVCI: str := (ExamImmunization.PRecord.UVCI);
    ExamImmunization_VACCINE_ID: str := inttostr(ExamImmunization.PRecord.VACCINE_ID);
    ExamImmunization_Logical: str := ExamImmunization.Logical08ToStr(TLogicalData08(ExamImmunization.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TExamImmunizationColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TExamImmunizationItem;
  ACol: Integer;
  prop: TExamImmunizationItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TExamImmunizationItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TExamImmunizationColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TExamImmunizationItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TExamImmunizationItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TExamImmunizationColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ExamImmunization: TExamImmunizationItem;
  ACol: Integer;
  prop: TExamImmunizationItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  ExamImmunization := ListExamImmunizationSearch[ARow];
  prop := TExamImmunizationItem.TPropertyIndex(ACol);
  if Assigned(ExamImmunization.PRecord) and (prop in ExamImmunization.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamImmunization, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamImmunization, AValue);
  end;
end;

function TExamImmunizationColl.GetCollType: TCollectionsType;
begin
  Result := ctExamImmunization;
end;

function TExamImmunizationColl.GetCollDelType: TCollectionsType;
begin
  Result := ctExamImmunizationDel;
end;

procedure TExamImmunizationColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  ExamImmunization: TExamImmunizationItem;
  prop: TExamImmunizationItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  ExamImmunization := Items[ARow];
  prop := TExamImmunizationItem.TPropertyIndex(ACol);
  if Assigned(ExamImmunization.PRecord) and (prop in ExamImmunization.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamImmunization, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamImmunization, AFieldText);
  end;
end;

procedure TExamImmunizationColl.GetCellFromMap(propIndex: word; ARow: Integer; ExamImmunization: TExamImmunizationItem; var AValue: String);
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
  case TExamImmunizationItem.TPropertyIndex(propIndex) of
    ExamImmunization_BASE_ON: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_BOOSTER: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_CERTIFICATE_NAME: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DATA: str :=  AspDateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_DOCTOR_NAME: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DOCTOR_UIN: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DOSE: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DOSE_NUMBER: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_DOSE_QUANTITY: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_EXPIRATION_DATE: str :=  AspDateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_EXT_AUTHORITY: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_COUNTRY: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_LOT_NUMBER: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_OCCURRENCE: str :=  AspDateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_EXT_PREV_IMMUNIZATION: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_EXT_SERIAL_NUMBER: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_VACCINE_ATC: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_VACCINE_INN: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_VACCINE_NAME: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_ID: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_IMMUNIZATION_ID: str :=  inttostr(ExamImmunization.getWordMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_IMMUNIZATION_STATUS: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_IS_SPECIAL_CASE: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_LOT_NUMBER: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_LRN: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_NEXT_DOSE_DATE: str :=  AspDateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_NOTE: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_NRN_IMMUNIZATION: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_NRN_PREV_IMMUNIZATION: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: str :=  AspDateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_PREGLED_ID: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_PRIMARY_SOURCE: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_QUALIFICATION: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_RESULT: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_ROUTE: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_SERIAL_NUMBER: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_SERIES: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_SERIES_DOSES: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_SITE: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_SOCIAL_GROUP: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_SUBJECT_STATUS: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_UPDATED: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_UVCI: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_VACCINE_ID: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_Logical: str :=  ExamImmunization.Logical08ToStr(ExamImmunization.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TExamImmunizationColl.GetItem(Index: Integer): TExamImmunizationItem;
begin
  Result := TExamImmunizationItem(inherited GetItem(Index));
end;


procedure TExamImmunizationColl.IndexValue(propIndex: TExamImmunizationItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TExamImmunizationItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      ExamImmunization_BASE_ON:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      ExamImmunization_BOOSTER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_CERTIFICATE_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_DOCTOR_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_DOCTOR_UIN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_DOSE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_DOSE_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_DOSE_QUANTITY: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_EXT_AUTHORITY:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_EXT_COUNTRY:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_EXT_LOT_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_EXT_PREV_IMMUNIZATION: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_EXT_SERIAL_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_EXT_VACCINE_ATC:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_EXT_VACCINE_INN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_EXT_VACCINE_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_IMMUNIZATION_ID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_IMMUNIZATION_STATUS: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_IS_SPECIAL_CASE: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_LOT_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_LRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_NOTE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_NRN_IMMUNIZATION:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_NRN_PREV_IMMUNIZATION:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_PERSON_STATUS_CHANGE_REASON:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_PRIMARY_SOURCE: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_QUALIFICATION:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_RESULT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_ROUTE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_SERIAL_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_SERIES:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_SERIES_DOSES: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_SITE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_SOCIAL_GROUP: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_SUBJECT_STATUS: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_UPDATED: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamImmunization_UVCI:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamImmunization_VACCINE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TExamImmunizationColl.IndexValueListNodes(propIndex: TExamImmunizationItem.TPropertyIndex);
begin

end;

function TExamImmunizationColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TExamImmunizationItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TExamImmunizationColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TExamImmunizationItem;
begin
  if index < 0 then
  begin
    Tempitem := TExamImmunizationItem.Create(nil);
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
procedure TExamImmunizationColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TExamImmunizationItem.TPropertyIndex(Field) of
ExamImmunization_BASE_ON: ListForFinder[0].PRecord.BASE_ON := AText;
    ExamImmunization_CERTIFICATE_NAME: ListForFinder[0].PRecord.CERTIFICATE_NAME := AText;
    ExamImmunization_DOCTOR_NAME: ListForFinder[0].PRecord.DOCTOR_NAME := AText;
    ExamImmunization_DOCTOR_UIN: ListForFinder[0].PRecord.DOCTOR_UIN := AText;
    ExamImmunization_DOSE: ListForFinder[0].PRecord.DOSE := AText;
    ExamImmunization_EXT_AUTHORITY: ListForFinder[0].PRecord.EXT_AUTHORITY := AText;
    ExamImmunization_EXT_COUNTRY: ListForFinder[0].PRecord.EXT_COUNTRY := AText;
    ExamImmunization_EXT_LOT_NUMBER: ListForFinder[0].PRecord.EXT_LOT_NUMBER := AText;
    ExamImmunization_EXT_SERIAL_NUMBER: ListForFinder[0].PRecord.EXT_SERIAL_NUMBER := AText;
    ExamImmunization_EXT_VACCINE_ATC: ListForFinder[0].PRecord.EXT_VACCINE_ATC := AText;
    ExamImmunization_EXT_VACCINE_INN: ListForFinder[0].PRecord.EXT_VACCINE_INN := AText;
    ExamImmunization_EXT_VACCINE_NAME: ListForFinder[0].PRecord.EXT_VACCINE_NAME := AText;
    ExamImmunization_LOT_NUMBER: ListForFinder[0].PRecord.LOT_NUMBER := AText;
    ExamImmunization_LRN: ListForFinder[0].PRecord.LRN := AText;
    ExamImmunization_NOTE: ListForFinder[0].PRecord.NOTE := AText;
    ExamImmunization_NRN_IMMUNIZATION: ListForFinder[0].PRecord.NRN_IMMUNIZATION := AText;
    ExamImmunization_NRN_PREV_IMMUNIZATION: ListForFinder[0].PRecord.NRN_PREV_IMMUNIZATION := AText;
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: ListForFinder[0].PRecord.PERSON_STATUS_CHANGE_REASON := AText;
    ExamImmunization_QUALIFICATION: ListForFinder[0].PRecord.QUALIFICATION := AText;
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: ListForFinder[0].PRecord.REASON_TO_CANCEL_IMMUNIZATION := AText;
    ExamImmunization_RESULT: ListForFinder[0].PRecord.RESULT := AText;
    ExamImmunization_ROUTE: ListForFinder[0].PRecord.ROUTE := AText;
    ExamImmunization_SERIAL_NUMBER: ListForFinder[0].PRecord.SERIAL_NUMBER := AText;
    ExamImmunization_SERIES: ListForFinder[0].PRecord.SERIES := AText;
    ExamImmunization_SITE: ListForFinder[0].PRecord.SITE := AText;
    ExamImmunization_UVCI: ListForFinder[0].PRecord.UVCI := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TExamImmunizationColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TExamImmunizationItem.TPropertyIndex(Field) of
ExamImmunization_DATA: ListForFinder[0].PRecord.DATA := Value;
    ExamImmunization_EXPIRATION_DATE: ListForFinder[0].PRecord.EXPIRATION_DATE := Value;
    ExamImmunization_EXT_OCCURRENCE: ListForFinder[0].PRecord.EXT_OCCURRENCE := Value;
    ExamImmunization_NEXT_DOSE_DATE: ListForFinder[0].PRecord.NEXT_DOSE_DATE := Value;
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: ListForFinder[0].PRecord.PERSON_STATUS_CHANGE_ON_DATE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TExamImmunizationColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TExamImmunizationItem.TPropertyIndex(Field) of
ExamImmunization_BOOSTER: ListForFinder[0].PRecord.BOOSTER := Value;
    ExamImmunization_DOSE_NUMBER: ListForFinder[0].PRecord.DOSE_NUMBER := Value;
    ExamImmunization_DOSE_QUANTITY: ListForFinder[0].PRecord.DOSE_QUANTITY := Value;
    ExamImmunization_EXT_PREV_IMMUNIZATION: ListForFinder[0].PRecord.EXT_PREV_IMMUNIZATION := Value;
    ExamImmunization_ID: ListForFinder[0].PRecord.ID := Value;
    ExamImmunization_IMMUNIZATION_ID: ListForFinder[0].PRecord.IMMUNIZATION_ID := Value;
    ExamImmunization_IMMUNIZATION_STATUS: ListForFinder[0].PRecord.IMMUNIZATION_STATUS := Value;
    ExamImmunization_IS_SPECIAL_CASE: ListForFinder[0].PRecord.IS_SPECIAL_CASE := Value;
    ExamImmunization_PREGLED_ID: ListForFinder[0].PRecord.PREGLED_ID := Value;
    ExamImmunization_PRIMARY_SOURCE: ListForFinder[0].PRecord.PRIMARY_SOURCE := Value;
    ExamImmunization_SERIES_DOSES: ListForFinder[0].PRecord.SERIES_DOSES := Value;
    ExamImmunization_SOCIAL_GROUP: ListForFinder[0].PRecord.SOCIAL_GROUP := Value;
    ExamImmunization_SUBJECT_STATUS: ListForFinder[0].PRecord.SUBJECT_STATUS := Value;
    ExamImmunization_UPDATED: ListForFinder[0].PRecord.UPDATED := Value;
    ExamImmunization_VACCINE_ID: ListForFinder[0].PRecord.VACCINE_ID := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TExamImmunizationColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TExamImmunizationItem.TPropertyIndex(Field) of
    ExamImmunization_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalExamImmunization(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalExamImmunization(logIndex))   
    end;
  end;
end;


procedure TExamImmunizationColl.OnSetTextSearchLog(Log: TlogicalExamImmunizationSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TExamImmunizationColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TExamImmunizationColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TExamImmunizationItem.TPropertyIndex(propIndex) of
    ExamImmunization_BASE_ON: Result := actAnsiString;
    ExamImmunization_BOOSTER: Result := actinteger;
    ExamImmunization_CERTIFICATE_NAME: Result := actAnsiString;
    ExamImmunization_DATA: Result := actTDate;
    ExamImmunization_DOCTOR_NAME: Result := actAnsiString;
    ExamImmunization_DOCTOR_UIN: Result := actAnsiString;
    ExamImmunization_DOSE: Result := actAnsiString;
    ExamImmunization_DOSE_NUMBER: Result := actinteger;
    ExamImmunization_DOSE_QUANTITY: Result := actinteger;
    ExamImmunization_EXPIRATION_DATE: Result := actTDate;
    ExamImmunization_EXT_AUTHORITY: Result := actAnsiString;
    ExamImmunization_EXT_COUNTRY: Result := actAnsiString;
    ExamImmunization_EXT_LOT_NUMBER: Result := actAnsiString;
    ExamImmunization_EXT_OCCURRENCE: Result := actTDate;
    ExamImmunization_EXT_PREV_IMMUNIZATION: Result := actinteger;
    ExamImmunization_EXT_SERIAL_NUMBER: Result := actAnsiString;
    ExamImmunization_EXT_VACCINE_ATC: Result := actAnsiString;
    ExamImmunization_EXT_VACCINE_INN: Result := actAnsiString;
    ExamImmunization_EXT_VACCINE_NAME: Result := actAnsiString;
    ExamImmunization_ID: Result := actinteger;
    ExamImmunization_IMMUNIZATION_ID: Result := actword;
    ExamImmunization_IMMUNIZATION_STATUS: Result := actinteger;
    ExamImmunization_IS_SPECIAL_CASE: Result := actinteger;
    ExamImmunization_LOT_NUMBER: Result := actAnsiString;
    ExamImmunization_LRN: Result := actAnsiString;
    ExamImmunization_NEXT_DOSE_DATE: Result := actTDate;
    ExamImmunization_NOTE: Result := actAnsiString;
    ExamImmunization_NRN_IMMUNIZATION: Result := actAnsiString;
    ExamImmunization_NRN_PREV_IMMUNIZATION: Result := actAnsiString;
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: Result := actTDate;
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: Result := actAnsiString;
    ExamImmunization_PREGLED_ID: Result := actinteger;
    ExamImmunization_PRIMARY_SOURCE: Result := actinteger;
    ExamImmunization_QUALIFICATION: Result := actAnsiString;
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: Result := actAnsiString;
    ExamImmunization_RESULT: Result := actAnsiString;
    ExamImmunization_ROUTE: Result := actAnsiString;
    ExamImmunization_SERIAL_NUMBER: Result := actAnsiString;
    ExamImmunization_SERIES: Result := actAnsiString;
    ExamImmunization_SERIES_DOSES: Result := actinteger;
    ExamImmunization_SITE: Result := actAnsiString;
    ExamImmunization_SOCIAL_GROUP: Result := actinteger;
    ExamImmunization_SUBJECT_STATUS: Result := actinteger;
    ExamImmunization_UPDATED: Result := actinteger;
    ExamImmunization_UVCI: Result := actAnsiString;
    ExamImmunization_VACCINE_ID: Result := actinteger;
    ExamImmunization_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TExamImmunizationColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TExamImmunizationColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  ExamImmunization: TExamImmunizationItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  ExamImmunization := Items[ARow];
  if not Assigned(ExamImmunization.PRecord) then
  begin
    New(ExamImmunization.PRecord);
    ExamImmunization.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TExamImmunizationItem.TPropertyIndex(ACol) of
      ExamImmunization_BASE_ON: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_BOOSTER: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_CERTIFICATE_NAME: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_DATA: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamImmunization_DOCTOR_NAME: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_DOCTOR_UIN: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_DOSE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_DOSE_NUMBER: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_DOSE_QUANTITY: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_EXPIRATION_DATE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamImmunization_EXT_AUTHORITY: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_EXT_COUNTRY: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_EXT_LOT_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_EXT_OCCURRENCE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamImmunization_EXT_PREV_IMMUNIZATION: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_EXT_SERIAL_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_EXT_VACCINE_ATC: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_EXT_VACCINE_INN: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_EXT_VACCINE_NAME: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_ID: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_IMMUNIZATION_ID: isOld :=  ExamImmunization.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_IMMUNIZATION_STATUS: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_IS_SPECIAL_CASE: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_LOT_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_LRN: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_NEXT_DOSE_DATE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamImmunization_NOTE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_NRN_IMMUNIZATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_NRN_PREV_IMMUNIZATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_PREGLED_ID: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_PRIMARY_SOURCE: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_QUALIFICATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_RESULT: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_ROUTE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_SERIAL_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_SERIES: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_SERIES_DOSES: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_SITE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_SOCIAL_GROUP: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_SUBJECT_STATUS: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_UPDATED: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamImmunization_UVCI: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamImmunization_VACCINE_ID: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(ExamImmunization.PRecord.setProp, TExamImmunizationItem.TPropertyIndex(ACol));
    if ExamImmunization.PRecord.setProp = [] then
    begin
      Dispose(ExamImmunization.PRecord);
      ExamImmunization.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(ExamImmunization.PRecord.setProp, TExamImmunizationItem.TPropertyIndex(ACol));
  case TExamImmunizationItem.TPropertyIndex(ACol) of
    ExamImmunization_BASE_ON: ExamImmunization.PRecord.BASE_ON := AValue;
    ExamImmunization_BOOSTER: ExamImmunization.PRecord.BOOSTER := StrToInt(AValue);
    ExamImmunization_CERTIFICATE_NAME: ExamImmunization.PRecord.CERTIFICATE_NAME := AValue;
    ExamImmunization_DATA: ExamImmunization.PRecord.DATA := StrToDate(AValue);
    ExamImmunization_DOCTOR_NAME: ExamImmunization.PRecord.DOCTOR_NAME := AValue;
    ExamImmunization_DOCTOR_UIN: ExamImmunization.PRecord.DOCTOR_UIN := AValue;
    ExamImmunization_DOSE: ExamImmunization.PRecord.DOSE := AValue;
    ExamImmunization_DOSE_NUMBER: ExamImmunization.PRecord.DOSE_NUMBER := StrToInt(AValue);
    ExamImmunization_DOSE_QUANTITY: ExamImmunization.PRecord.DOSE_QUANTITY := StrToInt(AValue);
    ExamImmunization_EXPIRATION_DATE: ExamImmunization.PRecord.EXPIRATION_DATE := StrToDate(AValue);
    ExamImmunization_EXT_AUTHORITY: ExamImmunization.PRecord.EXT_AUTHORITY := AValue;
    ExamImmunization_EXT_COUNTRY: ExamImmunization.PRecord.EXT_COUNTRY := AValue;
    ExamImmunization_EXT_LOT_NUMBER: ExamImmunization.PRecord.EXT_LOT_NUMBER := AValue;
    ExamImmunization_EXT_OCCURRENCE: ExamImmunization.PRecord.EXT_OCCURRENCE := StrToDate(AValue);
    ExamImmunization_EXT_PREV_IMMUNIZATION: ExamImmunization.PRecord.EXT_PREV_IMMUNIZATION := StrToInt(AValue);
    ExamImmunization_EXT_SERIAL_NUMBER: ExamImmunization.PRecord.EXT_SERIAL_NUMBER := AValue;
    ExamImmunization_EXT_VACCINE_ATC: ExamImmunization.PRecord.EXT_VACCINE_ATC := AValue;
    ExamImmunization_EXT_VACCINE_INN: ExamImmunization.PRecord.EXT_VACCINE_INN := AValue;
    ExamImmunization_EXT_VACCINE_NAME: ExamImmunization.PRecord.EXT_VACCINE_NAME := AValue;
    ExamImmunization_ID: ExamImmunization.PRecord.ID := StrToInt(AValue);
    ExamImmunization_IMMUNIZATION_ID: ExamImmunization.PRecord.IMMUNIZATION_ID := StrToInt(AValue);
    ExamImmunization_IMMUNIZATION_STATUS: ExamImmunization.PRecord.IMMUNIZATION_STATUS := StrToInt(AValue);
    ExamImmunization_IS_SPECIAL_CASE: ExamImmunization.PRecord.IS_SPECIAL_CASE := StrToInt(AValue);
    ExamImmunization_LOT_NUMBER: ExamImmunization.PRecord.LOT_NUMBER := AValue;
    ExamImmunization_LRN: ExamImmunization.PRecord.LRN := AValue;
    ExamImmunization_NEXT_DOSE_DATE: ExamImmunization.PRecord.NEXT_DOSE_DATE := StrToDate(AValue);
    ExamImmunization_NOTE: ExamImmunization.PRecord.NOTE := AValue;
    ExamImmunization_NRN_IMMUNIZATION: ExamImmunization.PRecord.NRN_IMMUNIZATION := AValue;
    ExamImmunization_NRN_PREV_IMMUNIZATION: ExamImmunization.PRecord.NRN_PREV_IMMUNIZATION := AValue;
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: ExamImmunization.PRecord.PERSON_STATUS_CHANGE_ON_DATE := StrToDate(AValue);
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: ExamImmunization.PRecord.PERSON_STATUS_CHANGE_REASON := AValue;
    ExamImmunization_PREGLED_ID: ExamImmunization.PRecord.PREGLED_ID := StrToInt(AValue);
    ExamImmunization_PRIMARY_SOURCE: ExamImmunization.PRecord.PRIMARY_SOURCE := StrToInt(AValue);
    ExamImmunization_QUALIFICATION: ExamImmunization.PRecord.QUALIFICATION := AValue;
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: ExamImmunization.PRecord.REASON_TO_CANCEL_IMMUNIZATION := AValue;
    ExamImmunization_RESULT: ExamImmunization.PRecord.RESULT := AValue;
    ExamImmunization_ROUTE: ExamImmunization.PRecord.ROUTE := AValue;
    ExamImmunization_SERIAL_NUMBER: ExamImmunization.PRecord.SERIAL_NUMBER := AValue;
    ExamImmunization_SERIES: ExamImmunization.PRecord.SERIES := AValue;
    ExamImmunization_SERIES_DOSES: ExamImmunization.PRecord.SERIES_DOSES := StrToInt(AValue);
    ExamImmunization_SITE: ExamImmunization.PRecord.SITE := AValue;
    ExamImmunization_SOCIAL_GROUP: ExamImmunization.PRecord.SOCIAL_GROUP := StrToInt(AValue);
    ExamImmunization_SUBJECT_STATUS: ExamImmunization.PRecord.SUBJECT_STATUS := StrToInt(AValue);
    ExamImmunization_UPDATED: ExamImmunization.PRecord.UPDATED := StrToInt(AValue);
    ExamImmunization_UVCI: ExamImmunization.PRecord.UVCI := AValue;
    ExamImmunization_VACCINE_ID: ExamImmunization.PRecord.VACCINE_ID := StrToInt(AValue);
    ExamImmunization_Logical: ExamImmunization.PRecord.Logical := tlogicalExamImmunizationSet(ExamImmunization.StrToLogical08(AValue));
  end;
end;

procedure TExamImmunizationColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  ExamImmunization: TExamImmunizationItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  ExamImmunization := Items[ARow];
  if not Assigned(ExamImmunization.PRecord) then
  begin
    New(ExamImmunization.PRecord);
    ExamImmunization.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TExamImmunizationItem.TPropertyIndex(ACol) of
      ExamImmunization_BASE_ON: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_BOOSTER: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_CERTIFICATE_NAME: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_DATA: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamImmunization_DOCTOR_NAME: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_DOCTOR_UIN: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_DOSE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_DOSE_NUMBER: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_DOSE_QUANTITY: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_EXPIRATION_DATE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamImmunization_EXT_AUTHORITY: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_EXT_COUNTRY: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_EXT_LOT_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_EXT_OCCURRENCE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamImmunization_EXT_PREV_IMMUNIZATION: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_EXT_SERIAL_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_EXT_VACCINE_ATC: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_EXT_VACCINE_INN: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_EXT_VACCINE_NAME: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_ID: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_IMMUNIZATION_ID: isOld :=  ExamImmunization.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_IMMUNIZATION_STATUS: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_IS_SPECIAL_CASE: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_LOT_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_LRN: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_NEXT_DOSE_DATE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamImmunization_NOTE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_NRN_IMMUNIZATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_NRN_PREV_IMMUNIZATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: isOld :=  ExamImmunization.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_PREGLED_ID: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_PRIMARY_SOURCE: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_QUALIFICATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_RESULT: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_ROUTE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_SERIAL_NUMBER: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_SERIES: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_SERIES_DOSES: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_SITE: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_SOCIAL_GROUP: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_SUBJECT_STATUS: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_UPDATED: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamImmunization_UVCI: isOld :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamImmunization_VACCINE_ID: isOld :=  ExamImmunization.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(ExamImmunization.PRecord.setProp, TExamImmunizationItem.TPropertyIndex(ACol));
    if ExamImmunization.PRecord.setProp = [] then
    begin
      Dispose(ExamImmunization.PRecord);
      ExamImmunization.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(ExamImmunization.PRecord.setProp, TExamImmunizationItem.TPropertyIndex(ACol));
  case TExamImmunizationItem.TPropertyIndex(ACol) of
    ExamImmunization_BASE_ON: ExamImmunization.PRecord.BASE_ON := AFieldText;
    ExamImmunization_BOOSTER: ExamImmunization.PRecord.BOOSTER := StrToInt(AFieldText);
    ExamImmunization_CERTIFICATE_NAME: ExamImmunization.PRecord.CERTIFICATE_NAME := AFieldText;
    ExamImmunization_DATA: ExamImmunization.PRecord.DATA := StrToDate(AFieldText);
    ExamImmunization_DOCTOR_NAME: ExamImmunization.PRecord.DOCTOR_NAME := AFieldText;
    ExamImmunization_DOCTOR_UIN: ExamImmunization.PRecord.DOCTOR_UIN := AFieldText;
    ExamImmunization_DOSE: ExamImmunization.PRecord.DOSE := AFieldText;
    ExamImmunization_DOSE_NUMBER: ExamImmunization.PRecord.DOSE_NUMBER := StrToInt(AFieldText);
    ExamImmunization_DOSE_QUANTITY: ExamImmunization.PRecord.DOSE_QUANTITY := StrToInt(AFieldText);
    ExamImmunization_EXPIRATION_DATE: ExamImmunization.PRecord.EXPIRATION_DATE := StrToDate(AFieldText);
    ExamImmunization_EXT_AUTHORITY: ExamImmunization.PRecord.EXT_AUTHORITY := AFieldText;
    ExamImmunization_EXT_COUNTRY: ExamImmunization.PRecord.EXT_COUNTRY := AFieldText;
    ExamImmunization_EXT_LOT_NUMBER: ExamImmunization.PRecord.EXT_LOT_NUMBER := AFieldText;
    ExamImmunization_EXT_OCCURRENCE: ExamImmunization.PRecord.EXT_OCCURRENCE := StrToDate(AFieldText);
    ExamImmunization_EXT_PREV_IMMUNIZATION: ExamImmunization.PRecord.EXT_PREV_IMMUNIZATION := StrToInt(AFieldText);
    ExamImmunization_EXT_SERIAL_NUMBER: ExamImmunization.PRecord.EXT_SERIAL_NUMBER := AFieldText;
    ExamImmunization_EXT_VACCINE_ATC: ExamImmunization.PRecord.EXT_VACCINE_ATC := AFieldText;
    ExamImmunization_EXT_VACCINE_INN: ExamImmunization.PRecord.EXT_VACCINE_INN := AFieldText;
    ExamImmunization_EXT_VACCINE_NAME: ExamImmunization.PRecord.EXT_VACCINE_NAME := AFieldText;
    ExamImmunization_ID: ExamImmunization.PRecord.ID := StrToInt(AFieldText);
    ExamImmunization_IMMUNIZATION_ID: ExamImmunization.PRecord.IMMUNIZATION_ID := StrToInt(AFieldText);
    ExamImmunization_IMMUNIZATION_STATUS: ExamImmunization.PRecord.IMMUNIZATION_STATUS := StrToInt(AFieldText);
    ExamImmunization_IS_SPECIAL_CASE: ExamImmunization.PRecord.IS_SPECIAL_CASE := StrToInt(AFieldText);
    ExamImmunization_LOT_NUMBER: ExamImmunization.PRecord.LOT_NUMBER := AFieldText;
    ExamImmunization_LRN: ExamImmunization.PRecord.LRN := AFieldText;
    ExamImmunization_NEXT_DOSE_DATE: ExamImmunization.PRecord.NEXT_DOSE_DATE := StrToDate(AFieldText);
    ExamImmunization_NOTE: ExamImmunization.PRecord.NOTE := AFieldText;
    ExamImmunization_NRN_IMMUNIZATION: ExamImmunization.PRecord.NRN_IMMUNIZATION := AFieldText;
    ExamImmunization_NRN_PREV_IMMUNIZATION: ExamImmunization.PRecord.NRN_PREV_IMMUNIZATION := AFieldText;
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: ExamImmunization.PRecord.PERSON_STATUS_CHANGE_ON_DATE := StrToDate(AFieldText);
    ExamImmunization_PERSON_STATUS_CHANGE_REASON: ExamImmunization.PRecord.PERSON_STATUS_CHANGE_REASON := AFieldText;
    ExamImmunization_PREGLED_ID: ExamImmunization.PRecord.PREGLED_ID := StrToInt(AFieldText);
    ExamImmunization_PRIMARY_SOURCE: ExamImmunization.PRecord.PRIMARY_SOURCE := StrToInt(AFieldText);
    ExamImmunization_QUALIFICATION: ExamImmunization.PRecord.QUALIFICATION := AFieldText;
    ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: ExamImmunization.PRecord.REASON_TO_CANCEL_IMMUNIZATION := AFieldText;
    ExamImmunization_RESULT: ExamImmunization.PRecord.RESULT := AFieldText;
    ExamImmunization_ROUTE: ExamImmunization.PRecord.ROUTE := AFieldText;
    ExamImmunization_SERIAL_NUMBER: ExamImmunization.PRecord.SERIAL_NUMBER := AFieldText;
    ExamImmunization_SERIES: ExamImmunization.PRecord.SERIES := AFieldText;
    ExamImmunization_SERIES_DOSES: ExamImmunization.PRecord.SERIES_DOSES := StrToInt(AFieldText);
    ExamImmunization_SITE: ExamImmunization.PRecord.SITE := AFieldText;
    ExamImmunization_SOCIAL_GROUP: ExamImmunization.PRecord.SOCIAL_GROUP := StrToInt(AFieldText);
    ExamImmunization_SUBJECT_STATUS: ExamImmunization.PRecord.SUBJECT_STATUS := StrToInt(AFieldText);
    ExamImmunization_UPDATED: ExamImmunization.PRecord.UPDATED := StrToInt(AFieldText);
    ExamImmunization_UVCI: ExamImmunization.PRecord.UVCI := AFieldText;
    ExamImmunization_VACCINE_ID: ExamImmunization.PRecord.VACCINE_ID := StrToInt(AFieldText);
    ExamImmunization_Logical: ExamImmunization.PRecord.Logical := tlogicalExamImmunizationSet(ExamImmunization.StrToLogical08(AFieldText));
  end;
end;

procedure TExamImmunizationColl.SetItem(Index: Integer; const Value: TExamImmunizationItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TExamImmunizationColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListExamImmunizationSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TExamImmunizationItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  ExamImmunization_BASE_ON:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListExamImmunizationSearch.Add(self.Items[i]);
  end;
end;
      ExamImmunization_BOOSTER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_CERTIFICATE_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_DOCTOR_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_DOCTOR_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_DOSE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_DOSE_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_DOSE_QUANTITY: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_AUTHORITY:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_COUNTRY:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_LOT_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_PREV_IMMUNIZATION: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_SERIAL_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_VACCINE_ATC:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_VACCINE_INN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_EXT_VACCINE_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_IMMUNIZATION_ID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_IMMUNIZATION_STATUS: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_IS_SPECIAL_CASE: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_LOT_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_LRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_NOTE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_NRN_IMMUNIZATION:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_NRN_PREV_IMMUNIZATION:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_PERSON_STATUS_CHANGE_REASON:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_PREGLED_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_PRIMARY_SOURCE: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_QUALIFICATION:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_RESULT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_ROUTE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_SERIAL_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_SERIES:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_SERIES_DOSES: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_SITE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_SOCIAL_GROUP: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_SUBJECT_STATUS: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_UPDATED: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_UVCI:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
      ExamImmunization_VACCINE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamImmunizationSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TExamImmunizationColl.ShowGrid(Grid: TTeeGrid);
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

procedure TExamImmunizationColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamImmunizationItem>);
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

procedure TExamImmunizationColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListExamImmunizationSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListExamImmunizationSearch.Count]);

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

procedure TExamImmunizationColl.SortByIndexAnsiString;
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

procedure TExamImmunizationColl.SortByIndexInt;
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

procedure TExamImmunizationColl.SortByIndexWord;
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

procedure TExamImmunizationColl.SortByIndexValue(propIndex: TExamImmunizationItem.TPropertyIndex);
begin
  case propIndex of
    ExamImmunization_BASE_ON: SortByIndexAnsiString;
      ExamImmunization_BOOSTER: SortByIndexInt;
      ExamImmunization_CERTIFICATE_NAME: SortByIndexAnsiString;
      ExamImmunization_DOCTOR_NAME: SortByIndexAnsiString;
      ExamImmunization_DOCTOR_UIN: SortByIndexAnsiString;
      ExamImmunization_DOSE: SortByIndexAnsiString;
      ExamImmunization_DOSE_NUMBER: SortByIndexInt;
      ExamImmunization_DOSE_QUANTITY: SortByIndexInt;
      ExamImmunization_EXT_AUTHORITY: SortByIndexAnsiString;
      ExamImmunization_EXT_COUNTRY: SortByIndexAnsiString;
      ExamImmunization_EXT_LOT_NUMBER: SortByIndexAnsiString;
      ExamImmunization_EXT_PREV_IMMUNIZATION: SortByIndexInt;
      ExamImmunization_EXT_SERIAL_NUMBER: SortByIndexAnsiString;
      ExamImmunization_EXT_VACCINE_ATC: SortByIndexAnsiString;
      ExamImmunization_EXT_VACCINE_INN: SortByIndexAnsiString;
      ExamImmunization_EXT_VACCINE_NAME: SortByIndexAnsiString;
      ExamImmunization_ID: SortByIndexInt;
      ExamImmunization_IMMUNIZATION_ID: SortByIndexWord;
      ExamImmunization_IMMUNIZATION_STATUS: SortByIndexInt;
      ExamImmunization_IS_SPECIAL_CASE: SortByIndexInt;
      ExamImmunization_LOT_NUMBER: SortByIndexAnsiString;
      ExamImmunization_LRN: SortByIndexAnsiString;
      ExamImmunization_NOTE: SortByIndexAnsiString;
      ExamImmunization_NRN_IMMUNIZATION: SortByIndexAnsiString;
      ExamImmunization_NRN_PREV_IMMUNIZATION: SortByIndexAnsiString;
      ExamImmunization_PERSON_STATUS_CHANGE_REASON: SortByIndexAnsiString;
      ExamImmunization_PREGLED_ID: SortByIndexInt;
      ExamImmunization_PRIMARY_SOURCE: SortByIndexInt;
      ExamImmunization_QUALIFICATION: SortByIndexAnsiString;
      ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION: SortByIndexAnsiString;
      ExamImmunization_RESULT: SortByIndexAnsiString;
      ExamImmunization_ROUTE: SortByIndexAnsiString;
      ExamImmunization_SERIAL_NUMBER: SortByIndexAnsiString;
      ExamImmunization_SERIES: SortByIndexAnsiString;
      ExamImmunization_SERIES_DOSES: SortByIndexInt;
      ExamImmunization_SITE: SortByIndexAnsiString;
      ExamImmunization_SOCIAL_GROUP: SortByIndexInt;
      ExamImmunization_SUBJECT_STATUS: SortByIndexInt;
      ExamImmunization_UPDATED: SortByIndexInt;
      ExamImmunization_UVCI: SortByIndexAnsiString;
      ExamImmunization_VACCINE_ID: SortByIndexInt;
  end;
end;

end.