unit Table.ExamImmunization;

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
);
	  
      TSetProp = set of TPropertyIndex;
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
    procedure SaveExamImmunization(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TExamImmunizationColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TExamImmunizationItem;
    procedure SetItem(Index: Integer; const Value: TExamImmunizationItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TExamImmunizationItem;
	ListForFDB: TList<TExamImmunizationItem>;
    ListExamImmunizationSearch: TList<TExamImmunizationItem>;
	PRecordSearch: ^TExamImmunizationItem.TRecExamImmunization;
    ArrPropSearch: TArray<TExamImmunizationItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TExamImmunizationItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TExamImmunizationItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; ExamImmunization: TExamImmunizationItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; ExamImmunization: TExamImmunizationItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TExamImmunizationItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamImmunizationItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TExamImmunizationItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TExamImmunizationItem.TPropertyIndex);
    property Items[Index: Integer]: TExamImmunizationItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    //procedure OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//    procedure OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);

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
	  ATempItem := TExamImmunizationColl(coll).ListForFDB.Items[0];
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
      end;
    end;
  end;
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
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TExamImmunizationColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TExamImmunizationItem.Create(nil);
  ListExamImmunizationSearch := TList<TExamImmunizationItem>.Create;
  ListForFDB := TList<TExamImmunizationItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TExamImmunizationColl.destroy;
begin
  FreeAndNil(ListExamImmunizationSearch);
  FreeAndNil(ListForFDB);
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
  end;
end;

procedure TExamImmunizationColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TExamImmunizationItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TExamImmunizationColl.FieldCount: Integer; 
begin
  inherited;
  Result := 46;
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
  ACol: Integer;
  prop: TExamImmunizationItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TExamImmunizationItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TExamImmunizationColl.GetCellFromRecord(propIndex: word; ExamImmunization: TExamImmunizationItem; var AValue: String);
var
  str: string;
begin
  case TExamImmunizationItem.TPropertyIndex(propIndex) of
    ExamImmunization_BASE_ON: str := (ExamImmunization.PRecord.BASE_ON);
    ExamImmunization_BOOSTER: str := inttostr(ExamImmunization.PRecord.BOOSTER);
    ExamImmunization_CERTIFICATE_NAME: str := (ExamImmunization.PRecord.CERTIFICATE_NAME);
    ExamImmunization_DATA: str := DateToStr(ExamImmunization.PRecord.DATA);
    ExamImmunization_DOCTOR_NAME: str := (ExamImmunization.PRecord.DOCTOR_NAME);
    ExamImmunization_DOCTOR_UIN: str := (ExamImmunization.PRecord.DOCTOR_UIN);
    ExamImmunization_DOSE: str := (ExamImmunization.PRecord.DOSE);
    ExamImmunization_DOSE_NUMBER: str := inttostr(ExamImmunization.PRecord.DOSE_NUMBER);
    ExamImmunization_DOSE_QUANTITY: str := inttostr(ExamImmunization.PRecord.DOSE_QUANTITY);
    ExamImmunization_EXPIRATION_DATE: str := DateToStr(ExamImmunization.PRecord.EXPIRATION_DATE);
    ExamImmunization_EXT_AUTHORITY: str := (ExamImmunization.PRecord.EXT_AUTHORITY);
    ExamImmunization_EXT_COUNTRY: str := (ExamImmunization.PRecord.EXT_COUNTRY);
    ExamImmunization_EXT_LOT_NUMBER: str := (ExamImmunization.PRecord.EXT_LOT_NUMBER);
    ExamImmunization_EXT_OCCURRENCE: str := DateToStr(ExamImmunization.PRecord.EXT_OCCURRENCE);
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
    ExamImmunization_NEXT_DOSE_DATE: str := DateToStr(ExamImmunization.PRecord.NEXT_DOSE_DATE);
    ExamImmunization_NOTE: str := (ExamImmunization.PRecord.NOTE);
    ExamImmunization_NRN_IMMUNIZATION: str := (ExamImmunization.PRecord.NRN_IMMUNIZATION);
    ExamImmunization_NRN_PREV_IMMUNIZATION: str := (ExamImmunization.PRecord.NRN_PREV_IMMUNIZATION);
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: str := DateToStr(ExamImmunization.PRecord.PERSON_STATUS_CHANGE_ON_DATE);
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
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
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
    ExamImmunization_DATA: str :=  DateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_DOCTOR_NAME: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DOCTOR_UIN: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DOSE: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_DOSE_NUMBER: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_DOSE_QUANTITY: str :=  inttostr(ExamImmunization.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_EXPIRATION_DATE: str :=  DateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_EXT_AUTHORITY: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_COUNTRY: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_LOT_NUMBER: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_EXT_OCCURRENCE: str :=  DateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
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
    ExamImmunization_NEXT_DOSE_DATE: str :=  DateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamImmunization_NOTE: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_NRN_IMMUNIZATION: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_NRN_PREV_IMMUNIZATION: str :=  ExamImmunization.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE: str :=  DateToStr(ExamImmunization.getDateMap(Self.Buf, Self.posData, propIndex));
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



//procedure TExamImmunizationColl.OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
//begin
//  if dtEdt.Date = 0 then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(dtEdt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(dtEdt.Field));
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  case TExamImmunizationItem.TPropertyIndex(dtEdt.Field) of
//    //ExamImmunization_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := dtEdt.Date;
//  end;
//end;
//
//procedure TExamImmunizationColl.OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//begin
//  if edt.Text = '' then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(edt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TExamImmunizationItem.TPropertyIndex(edt.Field));
//    //ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  if cotSens in edt.Condition then
//  begin
//    case TExamImmunizationItem.TPropertyIndex(edt.Field) of
//      ExamImmunization_EGN: ListForFDB[0].PRecord.EGN  := edt.Text;
//      ExamImmunization_FNAME: ListForFDB[0].PRecord.FNAME  := edt.Text;
//      ExamImmunization_SNAME: ListForFDB[0].PRecord.SNAME  := edt.Text;
//      ExamImmunization_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //ExamImmunization_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end
//  else
//  begin
//    case TExamImmunizationItem.TPropertyIndex(edt.Field) of
//      ExamImmunization_EGN: ListForFDB[0].PRecord.EGN  := AnsiUpperCase(edt.Text);
//      ExamImmunization_FNAME: ListForFDB[0].PRecord.FNAME  := AnsiUpperCase(edt.Text);
//      ExamImmunization_SNAME: ListForFDB[0].PRecord.SNAME  := AnsiUpperCase(edt.Text);
//      ExamImmunization_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //ExamImmunization_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end;
//end;



function TExamImmunizationColl.PropType(propIndex: Word): TAsectTypeKind;
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
  else
    Result := actNone;
  end
end;

procedure TExamImmunizationColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  ExamImmunization: TExamImmunizationItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  ExamImmunization := Items[ARow];
  if not Assigned(ExamImmunization.PRecord) then
  begin
    New(ExamImmunization.PRecord);
    ExamImmunization.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
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
  end;
end;

procedure TExamImmunizationColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  ExamImmunization: TExamImmunizationItem;
begin
  if Count = 0 then Exit;

  ExamImmunization := Items[ARow];
  if not Assigned(ExamImmunization.PRecord) then
  begin
    New(ExamImmunization.PRecord);
    ExamImmunization.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
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