unit Table.Exam_boln_list;

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
TLogicalExam_boln_list = (
    ASSISTED_PERSON_IS_EGN,
    EFFECTIVE,
    IS_CHECKED_NOI,
    IS_LKK,
    IS_PRIMARY,
    IS_PRINTED,
    IS_SENDED_NOI,
    PATIENT_IS_EGN,
    PATIENT_SEX_TYPE_M);
TlogicalExam_boln_listSet = set of TLogicalExam_boln_list;


TExam_boln_listItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Exam_boln_list_AMB_JOURNAL_NUMBER
, Exam_boln_list_ASSISTED_PERSON_NAME
, Exam_boln_list_ASSISTED_PERSON_PID
, Exam_boln_list_CUSTOMIZE
, Exam_boln_list_DATA
, Exam_boln_list_DATEOFBIRTH
, Exam_boln_list_DAYS_FREE
, Exam_boln_list_DAYS_HOME
, Exam_boln_list_DAYS_HOSPITAL
, Exam_boln_list_DAYS_IN_WORDS
, Exam_boln_list_DAYS_SANATORIUM
, Exam_boln_list_EL_NUMBER
, Exam_boln_list_FORM_LETTER
, Exam_boln_list_FORM_NUMBER
, Exam_boln_list_IAVIAVANE_PREGLED_DATE
, Exam_boln_list_ID
, Exam_boln_list_IST_ZABOL_NO
, Exam_boln_list_IZDADEN_OT
, Exam_boln_list_LAK_NUMBER
, Exam_boln_list_LKK_TYPE
, Exam_boln_list_NERABOTOSP_ID
, Exam_boln_list_NOTES
, Exam_boln_list_NOTES_ID
, Exam_boln_list_NUMBER
, Exam_boln_list_NUMBER_ANUL
, Exam_boln_list_OTHER_PRACTICA_ID
, Exam_boln_list_PATIENT_EGN
, Exam_boln_list_PATIENT_LNCH
, Exam_boln_list_PREGLED_ID
, Exam_boln_list_REALATIONSHIP
, Exam_boln_list_REL_SHIP_CODE
, Exam_boln_list_RESHENIEDATE
, Exam_boln_list_RESHENIEDATE_TELK
, Exam_boln_list_RESHENIENO
, Exam_boln_list_RESHENIENO_TELK
, Exam_boln_list_SICK_LEAVE_END
, Exam_boln_list_SICK_LEAVE_START
, Exam_boln_list_TERMIN_DATE
, Exam_boln_list_TREATMENT_REGIMEN
, Exam_boln_list_Logical
);
      TSetProp = set of TPropertyIndex;
      PRecExam_boln_list = ^TRecExam_boln_list;
      TRecExam_boln_list = record
        AMB_JOURNAL_NUMBER: integer;
        ASSISTED_PERSON_NAME: AnsiString;
        ASSISTED_PERSON_PID: AnsiString;
        CUSTOMIZE: integer;
        DATA: TDate;
        DATEOFBIRTH: TDate;
        DAYS_FREE: word;
        DAYS_HOME: word;
        DAYS_HOSPITAL: word;
        DAYS_IN_WORDS: AnsiString;
        DAYS_SANATORIUM: word;
        EL_NUMBER: AnsiString;
        FORM_LETTER: AnsiString;
        FORM_NUMBER: integer;
        IAVIAVANE_PREGLED_DATE: TDate;
        ID: integer;
        IST_ZABOL_NO: AnsiString;
        IZDADEN_OT: AnsiString;
        LAK_NUMBER: integer;
        LKK_TYPE: AnsiString;
        NERABOTOSP_ID: word;
        NOTES: AnsiString;
        NOTES_ID: integer;
        NUMBER: integer;
        NUMBER_ANUL: AnsiString;
        OTHER_PRACTICA_ID: integer;
        PATIENT_EGN: AnsiString;
        PATIENT_LNCH: AnsiString;
        PREGLED_ID: integer;
        REALATIONSHIP: AnsiString;
        REL_SHIP_CODE: word;
        RESHENIEDATE: TDate;
        RESHENIEDATE_TELK: TDate;
        RESHENIENO: AnsiString;
        RESHENIENO_TELK: AnsiString;
        SICK_LEAVE_END: TDate;
        SICK_LEAVE_START: TDate;
        TERMIN_DATE: TDate;
        TREATMENT_REGIMEN: word;
        Logical: TlogicalExam_boln_listSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecExam_boln_list;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertExam_boln_list;
    procedure UpdateExam_boln_list;
    procedure SaveExam_boln_list(var dataPosition: Cardinal);
  end;


  TExam_boln_listColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TExam_boln_listItem;
    procedure SetItem(Index: Integer; const Value: TExam_boln_listItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TExam_boln_listItem;
    ListExam_boln_listSearch: TList<TExam_boln_listItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TExam_boln_listItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Exam_boln_list: TExam_boln_listItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Exam_boln_list: TExam_boln_listItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TExam_boln_listItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TExam_boln_listItem.TPropertyIndex);
    property Items[Index: Integer]: TExam_boln_listItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TExam_boln_listItem }

constructor TExam_boln_listItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TExam_boln_listItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TExam_boln_listItem.InsertExam_boln_list;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctExam_boln_list;
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
            Exam_boln_list_AMB_JOURNAL_NUMBER: SaveData(PRecord.AMB_JOURNAL_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ASSISTED_PERSON_NAME: SaveData(PRecord.ASSISTED_PERSON_NAME, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ASSISTED_PERSON_PID: SaveData(PRecord.ASSISTED_PERSON_PID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_CUSTOMIZE: SaveData(PRecord.CUSTOMIZE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DATEOFBIRTH: SaveData(PRecord.DATEOFBIRTH, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_FREE: SaveData(PRecord.DAYS_FREE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_HOME: SaveData(PRecord.DAYS_HOME, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_HOSPITAL: SaveData(PRecord.DAYS_HOSPITAL, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_IN_WORDS: SaveData(PRecord.DAYS_IN_WORDS, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_SANATORIUM: SaveData(PRecord.DAYS_SANATORIUM, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_EL_NUMBER: SaveData(PRecord.EL_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_FORM_LETTER: SaveData(PRecord.FORM_LETTER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_FORM_NUMBER: SaveData(PRecord.FORM_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IAVIAVANE_PREGLED_DATE: SaveData(PRecord.IAVIAVANE_PREGLED_DATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IST_ZABOL_NO: SaveData(PRecord.IST_ZABOL_NO, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IZDADEN_OT: SaveData(PRecord.IZDADEN_OT, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_LAK_NUMBER: SaveData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_LKK_TYPE: SaveData(PRecord.LKK_TYPE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NERABOTOSP_ID: SaveData(PRecord.NERABOTOSP_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NOTES: SaveData(PRecord.NOTES, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NOTES_ID: SaveData(PRecord.NOTES_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NUMBER_ANUL: SaveData(PRecord.NUMBER_ANUL, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_OTHER_PRACTICA_ID: SaveData(PRecord.OTHER_PRACTICA_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PATIENT_EGN: SaveData(PRecord.PATIENT_EGN, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PATIENT_LNCH: SaveData(PRecord.PATIENT_LNCH, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_REALATIONSHIP: SaveData(PRecord.REALATIONSHIP, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_REL_SHIP_CODE: SaveData(PRecord.REL_SHIP_CODE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIEDATE: SaveData(PRecord.RESHENIEDATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIEDATE_TELK: SaveData(PRecord.RESHENIEDATE_TELK, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIENO: SaveData(PRecord.RESHENIENO, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIENO_TELK: SaveData(PRecord.RESHENIENO_TELK, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_SICK_LEAVE_END: SaveData(PRecord.SICK_LEAVE_END, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_SICK_LEAVE_START: SaveData(PRecord.SICK_LEAVE_START, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_TERMIN_DATE: SaveData(PRecord.TERMIN_DATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_TREATMENT_REGIMEN: SaveData(PRecord.TREATMENT_REGIMEN, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TExam_boln_listItem.SaveExam_boln_list(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExam_boln_list;
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
            Exam_boln_list_AMB_JOURNAL_NUMBER: SaveData(PRecord.AMB_JOURNAL_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ASSISTED_PERSON_NAME: SaveData(PRecord.ASSISTED_PERSON_NAME, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ASSISTED_PERSON_PID: SaveData(PRecord.ASSISTED_PERSON_PID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_CUSTOMIZE: SaveData(PRecord.CUSTOMIZE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DATEOFBIRTH: SaveData(PRecord.DATEOFBIRTH, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_FREE: SaveData(PRecord.DAYS_FREE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_HOME: SaveData(PRecord.DAYS_HOME, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_HOSPITAL: SaveData(PRecord.DAYS_HOSPITAL, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_IN_WORDS: SaveData(PRecord.DAYS_IN_WORDS, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_SANATORIUM: SaveData(PRecord.DAYS_SANATORIUM, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_EL_NUMBER: SaveData(PRecord.EL_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_FORM_LETTER: SaveData(PRecord.FORM_LETTER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_FORM_NUMBER: SaveData(PRecord.FORM_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IAVIAVANE_PREGLED_DATE: SaveData(PRecord.IAVIAVANE_PREGLED_DATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IST_ZABOL_NO: SaveData(PRecord.IST_ZABOL_NO, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IZDADEN_OT: SaveData(PRecord.IZDADEN_OT, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_LAK_NUMBER: SaveData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_LKK_TYPE: SaveData(PRecord.LKK_TYPE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NERABOTOSP_ID: SaveData(PRecord.NERABOTOSP_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NOTES: SaveData(PRecord.NOTES, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NOTES_ID: SaveData(PRecord.NOTES_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NUMBER_ANUL: SaveData(PRecord.NUMBER_ANUL, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_OTHER_PRACTICA_ID: SaveData(PRecord.OTHER_PRACTICA_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PATIENT_EGN: SaveData(PRecord.PATIENT_EGN, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PATIENT_LNCH: SaveData(PRecord.PATIENT_LNCH, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_REALATIONSHIP: SaveData(PRecord.REALATIONSHIP, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_REL_SHIP_CODE: SaveData(PRecord.REL_SHIP_CODE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIEDATE: SaveData(PRecord.RESHENIEDATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIEDATE_TELK: SaveData(PRecord.RESHENIEDATE_TELK, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIENO: SaveData(PRecord.RESHENIENO, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIENO_TELK: SaveData(PRecord.RESHENIENO_TELK, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_SICK_LEAVE_END: SaveData(PRecord.SICK_LEAVE_END, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_SICK_LEAVE_START: SaveData(PRecord.SICK_LEAVE_START, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_TERMIN_DATE: SaveData(PRecord.TERMIN_DATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_TREATMENT_REGIMEN: SaveData(PRecord.TREATMENT_REGIMEN, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TExam_boln_listItem.UpdateExam_boln_list;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExam_boln_list;
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
            Exam_boln_list_AMB_JOURNAL_NUMBER: UpdateData(PRecord.AMB_JOURNAL_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ASSISTED_PERSON_NAME: UpdateData(PRecord.ASSISTED_PERSON_NAME, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ASSISTED_PERSON_PID: UpdateData(PRecord.ASSISTED_PERSON_PID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_CUSTOMIZE: UpdateData(PRecord.CUSTOMIZE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DATEOFBIRTH: UpdateData(PRecord.DATEOFBIRTH, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_FREE: UpdateData(PRecord.DAYS_FREE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_HOME: UpdateData(PRecord.DAYS_HOME, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_HOSPITAL: UpdateData(PRecord.DAYS_HOSPITAL, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_IN_WORDS: UpdateData(PRecord.DAYS_IN_WORDS, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_DAYS_SANATORIUM: UpdateData(PRecord.DAYS_SANATORIUM, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_EL_NUMBER: UpdateData(PRecord.EL_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_FORM_LETTER: UpdateData(PRecord.FORM_LETTER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_FORM_NUMBER: UpdateData(PRecord.FORM_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IAVIAVANE_PREGLED_DATE: UpdateData(PRecord.IAVIAVANE_PREGLED_DATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IST_ZABOL_NO: UpdateData(PRecord.IST_ZABOL_NO, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_IZDADEN_OT: UpdateData(PRecord.IZDADEN_OT, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_LAK_NUMBER: UpdateData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_LKK_TYPE: UpdateData(PRecord.LKK_TYPE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NERABOTOSP_ID: UpdateData(PRecord.NERABOTOSP_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NOTES: UpdateData(PRecord.NOTES, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NOTES_ID: UpdateData(PRecord.NOTES_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NUMBER: UpdateData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_NUMBER_ANUL: UpdateData(PRecord.NUMBER_ANUL, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_OTHER_PRACTICA_ID: UpdateData(PRecord.OTHER_PRACTICA_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PATIENT_EGN: UpdateData(PRecord.PATIENT_EGN, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PATIENT_LNCH: UpdateData(PRecord.PATIENT_LNCH, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_REALATIONSHIP: UpdateData(PRecord.REALATIONSHIP, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_REL_SHIP_CODE: UpdateData(PRecord.REL_SHIP_CODE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIEDATE: UpdateData(PRecord.RESHENIEDATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIEDATE_TELK: UpdateData(PRecord.RESHENIEDATE_TELK, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIENO: UpdateData(PRecord.RESHENIENO, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_RESHENIENO_TELK: UpdateData(PRecord.RESHENIENO_TELK, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_SICK_LEAVE_END: UpdateData(PRecord.SICK_LEAVE_END, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_SICK_LEAVE_START: UpdateData(PRecord.SICK_LEAVE_START, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_TERMIN_DATE: UpdateData(PRecord.TERMIN_DATE, PropPosition, metaPosition, dataPosition);
            Exam_boln_list_TREATMENT_REGIMEN: UpdateData(PRecord.TREATMENT_REGIMEN, PropPosition, metaPosition, dataPosition);
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

{ TExam_boln_listColl }

function TExam_boln_listColl.AddItem(ver: word): TExam_boln_listItem;
begin
  Result := TExam_boln_listItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TExam_boln_listColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListExam_boln_listSearch := TList<TExam_boln_listItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  tempItem := TExam_boln_listItem.Create(nil);
end;

destructor TExam_boln_listColl.destroy;
begin
  FreeAndNil(ListExam_boln_listSearch);
  FreeAndNil(tempItem);
  inherited;
end;

function TExam_boln_listColl.DisplayName(propIndex: Word): string;
begin
  case TExam_boln_listItem.TPropertyIndex(propIndex) of
    Exam_boln_list_AMB_JOURNAL_NUMBER: Result := 'AMB_JOURNAL_NUMBER';
    Exam_boln_list_ASSISTED_PERSON_NAME: Result := 'ASSISTED_PERSON_NAME';
    Exam_boln_list_ASSISTED_PERSON_PID: Result := 'ASSISTED_PERSON_PID';
    Exam_boln_list_CUSTOMIZE: Result := 'CUSTOMIZE';
    Exam_boln_list_DATA: Result := 'DATA';
    Exam_boln_list_DATEOFBIRTH: Result := 'DATEOFBIRTH';
    Exam_boln_list_DAYS_FREE: Result := 'DAYS_FREE';
    Exam_boln_list_DAYS_HOME: Result := 'DAYS_HOME';
    Exam_boln_list_DAYS_HOSPITAL: Result := 'DAYS_HOSPITAL';
    Exam_boln_list_DAYS_IN_WORDS: Result := 'DAYS_IN_WORDS';
    Exam_boln_list_DAYS_SANATORIUM: Result := 'DAYS_SANATORIUM';
    Exam_boln_list_EL_NUMBER: Result := 'EL_NUMBER';
    Exam_boln_list_FORM_LETTER: Result := 'FORM_LETTER';
    Exam_boln_list_FORM_NUMBER: Result := 'FORM_NUMBER';
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: Result := 'IAVIAVANE_PREGLED_DATE';
    Exam_boln_list_ID: Result := 'ID';
    Exam_boln_list_IST_ZABOL_NO: Result := 'IST_ZABOL_NO';
    Exam_boln_list_IZDADEN_OT: Result := 'IZDADEN_OT';
    Exam_boln_list_LAK_NUMBER: Result := 'LAK_NUMBER';
    Exam_boln_list_LKK_TYPE: Result := 'LKK_TYPE';
    Exam_boln_list_NERABOTOSP_ID: Result := 'NERABOTOSP_ID';
    Exam_boln_list_NOTES: Result := 'NOTES';
    Exam_boln_list_NOTES_ID: Result := 'NOTES_ID';
    Exam_boln_list_NUMBER: Result := 'NUMBER';
    Exam_boln_list_NUMBER_ANUL: Result := 'NUMBER_ANUL';
    Exam_boln_list_OTHER_PRACTICA_ID: Result := 'OTHER_PRACTICA_ID';
    Exam_boln_list_PATIENT_EGN: Result := 'PATIENT_EGN';
    Exam_boln_list_PATIENT_LNCH: Result := 'PATIENT_LNCH';
    Exam_boln_list_PREGLED_ID: Result := 'PREGLED_ID';
    Exam_boln_list_REALATIONSHIP: Result := 'REALATIONSHIP';
    Exam_boln_list_REL_SHIP_CODE: Result := 'REL_SHIP_CODE';
    Exam_boln_list_RESHENIEDATE: Result := 'RESHENIEDATE';
    Exam_boln_list_RESHENIEDATE_TELK: Result := 'RESHENIEDATE_TELK';
    Exam_boln_list_RESHENIENO: Result := 'RESHENIENO';
    Exam_boln_list_RESHENIENO_TELK: Result := 'RESHENIENO_TELK';
    Exam_boln_list_SICK_LEAVE_END: Result := 'SICK_LEAVE_END';
    Exam_boln_list_SICK_LEAVE_START: Result := 'SICK_LEAVE_START';
    Exam_boln_list_TERMIN_DATE: Result := 'TERMIN_DATE';
    Exam_boln_list_TREATMENT_REGIMEN: Result := 'TREATMENT_REGIMEN';
    Exam_boln_list_Logical: Result := 'Logical';
  end;
end;

procedure TExam_boln_listColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TExam_boln_listItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TExam_boln_listColl.FieldCount: Integer; 
begin
  Result := 40;
end;

procedure TExam_boln_listColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Exam_boln_list: TExam_boln_listItem;
  ACol: Integer;
  prop: TExam_boln_listItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Exam_boln_list := Items[ARow];
  prop := TExam_boln_listItem.TPropertyIndex(ACol);
  if Assigned(Exam_boln_list.PRecord) and (prop in Exam_boln_list.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Exam_boln_list, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Exam_boln_list, AValue);
  end;
end;

procedure TExam_boln_listColl.GetCellFromRecord(propIndex: word; Exam_boln_list: TExam_boln_listItem; var AValue: String);
var
  str: string;
begin
  case TExam_boln_listItem.TPropertyIndex(propIndex) of
    Exam_boln_list_AMB_JOURNAL_NUMBER: str := inttostr(Exam_boln_list.PRecord.AMB_JOURNAL_NUMBER);
    Exam_boln_list_ASSISTED_PERSON_NAME: str := (Exam_boln_list.PRecord.ASSISTED_PERSON_NAME);
    Exam_boln_list_ASSISTED_PERSON_PID: str := (Exam_boln_list.PRecord.ASSISTED_PERSON_PID);
    Exam_boln_list_CUSTOMIZE: str := inttostr(Exam_boln_list.PRecord.CUSTOMIZE);
    Exam_boln_list_DATA: str := DateToStr(Exam_boln_list.PRecord.DATA);
    Exam_boln_list_DATEOFBIRTH: str := DateToStr(Exam_boln_list.PRecord.DATEOFBIRTH);
    Exam_boln_list_DAYS_FREE: str := inttostr(Exam_boln_list.PRecord.DAYS_FREE);
    Exam_boln_list_DAYS_HOME: str := inttostr(Exam_boln_list.PRecord.DAYS_HOME);
    Exam_boln_list_DAYS_HOSPITAL: str := inttostr(Exam_boln_list.PRecord.DAYS_HOSPITAL);
    Exam_boln_list_DAYS_IN_WORDS: str := (Exam_boln_list.PRecord.DAYS_IN_WORDS);
    Exam_boln_list_DAYS_SANATORIUM: str := inttostr(Exam_boln_list.PRecord.DAYS_SANATORIUM);
    Exam_boln_list_EL_NUMBER: str := (Exam_boln_list.PRecord.EL_NUMBER);
    Exam_boln_list_FORM_LETTER: str := (Exam_boln_list.PRecord.FORM_LETTER);
    Exam_boln_list_FORM_NUMBER: str := inttostr(Exam_boln_list.PRecord.FORM_NUMBER);
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: str := DateToStr(Exam_boln_list.PRecord.IAVIAVANE_PREGLED_DATE);
    Exam_boln_list_ID: str := inttostr(Exam_boln_list.PRecord.ID);
    Exam_boln_list_IST_ZABOL_NO: str := (Exam_boln_list.PRecord.IST_ZABOL_NO);
    Exam_boln_list_IZDADEN_OT: str := (Exam_boln_list.PRecord.IZDADEN_OT);
    Exam_boln_list_LAK_NUMBER: str := inttostr(Exam_boln_list.PRecord.LAK_NUMBER);
    Exam_boln_list_LKK_TYPE: str := (Exam_boln_list.PRecord.LKK_TYPE);
    Exam_boln_list_NERABOTOSP_ID: str := inttostr(Exam_boln_list.PRecord.NERABOTOSP_ID);
    Exam_boln_list_NOTES: str := (Exam_boln_list.PRecord.NOTES);
    Exam_boln_list_NOTES_ID: str := inttostr(Exam_boln_list.PRecord.NOTES_ID);
    Exam_boln_list_NUMBER: str := inttostr(Exam_boln_list.PRecord.NUMBER);
    Exam_boln_list_NUMBER_ANUL: str := (Exam_boln_list.PRecord.NUMBER_ANUL);
    Exam_boln_list_OTHER_PRACTICA_ID: str := inttostr(Exam_boln_list.PRecord.OTHER_PRACTICA_ID);
    Exam_boln_list_PATIENT_EGN: str := (Exam_boln_list.PRecord.PATIENT_EGN);
    Exam_boln_list_PATIENT_LNCH: str := (Exam_boln_list.PRecord.PATIENT_LNCH);
    Exam_boln_list_PREGLED_ID: str := inttostr(Exam_boln_list.PRecord.PREGLED_ID);
    Exam_boln_list_REALATIONSHIP: str := (Exam_boln_list.PRecord.REALATIONSHIP);
    Exam_boln_list_REL_SHIP_CODE: str := inttostr(Exam_boln_list.PRecord.REL_SHIP_CODE);
    Exam_boln_list_RESHENIEDATE: str := DateToStr(Exam_boln_list.PRecord.RESHENIEDATE);
    Exam_boln_list_RESHENIEDATE_TELK: str := DateToStr(Exam_boln_list.PRecord.RESHENIEDATE_TELK);
    Exam_boln_list_RESHENIENO: str := (Exam_boln_list.PRecord.RESHENIENO);
    Exam_boln_list_RESHENIENO_TELK: str := (Exam_boln_list.PRecord.RESHENIENO_TELK);
    Exam_boln_list_SICK_LEAVE_END: str := DateToStr(Exam_boln_list.PRecord.SICK_LEAVE_END);
    Exam_boln_list_SICK_LEAVE_START: str := DateToStr(Exam_boln_list.PRecord.SICK_LEAVE_START);
    Exam_boln_list_TERMIN_DATE: str := DateToStr(Exam_boln_list.PRecord.TERMIN_DATE);
    Exam_boln_list_TREATMENT_REGIMEN: str := inttostr(Exam_boln_list.PRecord.TREATMENT_REGIMEN);
    Exam_boln_list_Logical: str := Exam_boln_list.Logical16ToStr(TLogicalData16(Exam_boln_list.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TExam_boln_listColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var

  ACol: Integer;
  prop: TExam_boln_listItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  tempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TExam_boln_listItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, tempItem, AValue);
end;

procedure TExam_boln_listColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Exam_boln_list: TExam_boln_listItem;
  ACol: Integer;
  prop: TExam_boln_listItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Exam_boln_list := ListExam_boln_listSearch[ARow];
  prop := TExam_boln_listItem.TPropertyIndex(ACol);
  if Assigned(Exam_boln_list.PRecord) and (prop in Exam_boln_list.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Exam_boln_list, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Exam_boln_list, AValue);
  end;
end;

procedure TExam_boln_listColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Exam_boln_list: TExam_boln_listItem;
  prop: TExam_boln_listItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Exam_boln_list := Items[ARow];
  prop := TExam_boln_listItem.TPropertyIndex(ACol);
  if Assigned(Exam_boln_list.PRecord) and (prop in Exam_boln_list.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Exam_boln_list, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Exam_boln_list, AFieldText);
  end;
end;

procedure TExam_boln_listColl.GetCellFromMap(propIndex: word; ARow: Integer; Exam_boln_list: TExam_boln_listItem; var AValue: String);
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
  case TExam_boln_listItem.TPropertyIndex(propIndex) of
    Exam_boln_list_AMB_JOURNAL_NUMBER: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_ASSISTED_PERSON_NAME: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_ASSISTED_PERSON_PID: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_CUSTOMIZE: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_DATA: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_DATEOFBIRTH: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_DAYS_FREE: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_DAYS_HOME: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_DAYS_HOSPITAL: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_DAYS_IN_WORDS: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_DAYS_SANATORIUM: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_EL_NUMBER: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_FORM_LETTER: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_FORM_NUMBER: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_ID: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_IST_ZABOL_NO: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_IZDADEN_OT: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_LAK_NUMBER: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_LKK_TYPE: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_NERABOTOSP_ID: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_NOTES: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_NOTES_ID: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_NUMBER: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_NUMBER_ANUL: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_OTHER_PRACTICA_ID: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_PATIENT_EGN: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_PATIENT_LNCH: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_PREGLED_ID: str :=  inttostr(Exam_boln_list.getIntMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_REALATIONSHIP: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_REL_SHIP_CODE: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_RESHENIEDATE: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_RESHENIEDATE_TELK: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_RESHENIENO: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_RESHENIENO_TELK: str :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Exam_boln_list_SICK_LEAVE_END: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_SICK_LEAVE_START: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_TERMIN_DATE: str :=  DateToStr(Exam_boln_list.getDateMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_TREATMENT_REGIMEN: str :=  inttostr(Exam_boln_list.getWordMap(Self.Buf, Self.posData, propIndex));
    Exam_boln_list_Logical: str :=  Exam_boln_list.Logical32ToStr(Exam_boln_list.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TExam_boln_listColl.GetItem(Index: Integer): TExam_boln_listItem;
begin
  Result := TExam_boln_listItem(inherited GetItem(Index));
end;


procedure TExam_boln_listColl.IndexValue(propIndex: TExam_boln_listItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TExam_boln_listItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Exam_boln_list_AMB_JOURNAL_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_ASSISTED_PERSON_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_ASSISTED_PERSON_PID:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_CUSTOMIZE: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_DAYS_FREE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_DAYS_HOME: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_DAYS_HOSPITAL: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_DAYS_IN_WORDS:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_DAYS_SANATORIUM: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_EL_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_FORM_LETTER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_FORM_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_IST_ZABOL_NO:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_IZDADEN_OT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_LAK_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_LKK_TYPE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_NERABOTOSP_ID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_NOTES:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_NOTES_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_NUMBER_ANUL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_OTHER_PRACTICA_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_PATIENT_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_PATIENT_LNCH:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_REALATIONSHIP:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_REL_SHIP_CODE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Exam_boln_list_RESHENIENO:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_RESHENIENO_TELK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Exam_boln_list_TREATMENT_REGIMEN: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TExam_boln_listColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Exam_boln_list: TExam_boln_listItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Exam_boln_list := Items[ARow];
  if not Assigned(Exam_boln_list.PRecord) then
  begin
    New(Exam_boln_list.PRecord);
    Exam_boln_list.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TExam_boln_listItem.TPropertyIndex(ACol) of
      Exam_boln_list_AMB_JOURNAL_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_ASSISTED_PERSON_NAME: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_ASSISTED_PERSON_PID: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_CUSTOMIZE: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_DATA: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_DATEOFBIRTH: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_DAYS_FREE: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_DAYS_HOME: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_DAYS_HOSPITAL: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_DAYS_IN_WORDS: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_DAYS_SANATORIUM: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_EL_NUMBER: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_FORM_LETTER: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_FORM_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_IST_ZABOL_NO: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_IZDADEN_OT: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_LAK_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_LKK_TYPE: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_NERABOTOSP_ID: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_NOTES: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_NOTES_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_NUMBER_ANUL: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_OTHER_PRACTICA_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_PATIENT_EGN: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_PATIENT_LNCH: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_PREGLED_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_REALATIONSHIP: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_REL_SHIP_CODE: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Exam_boln_list_RESHENIEDATE: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_RESHENIEDATE_TELK: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_RESHENIENO: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_RESHENIENO_TELK: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Exam_boln_list_SICK_LEAVE_END: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_SICK_LEAVE_START: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_TERMIN_DATE: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Exam_boln_list_TREATMENT_REGIMEN: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Exam_boln_list.PRecord.setProp, TExam_boln_listItem.TPropertyIndex(ACol));
    if Exam_boln_list.PRecord.setProp = [] then
    begin
      Dispose(Exam_boln_list.PRecord);
      Exam_boln_list.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Exam_boln_list.PRecord.setProp, TExam_boln_listItem.TPropertyIndex(ACol));
  case TExam_boln_listItem.TPropertyIndex(ACol) of
    Exam_boln_list_AMB_JOURNAL_NUMBER: Exam_boln_list.PRecord.AMB_JOURNAL_NUMBER := StrToInt(AValue);
    Exam_boln_list_ASSISTED_PERSON_NAME: Exam_boln_list.PRecord.ASSISTED_PERSON_NAME := AValue;
    Exam_boln_list_ASSISTED_PERSON_PID: Exam_boln_list.PRecord.ASSISTED_PERSON_PID := AValue;
    Exam_boln_list_CUSTOMIZE: Exam_boln_list.PRecord.CUSTOMIZE := StrToInt(AValue);
    Exam_boln_list_DATA: Exam_boln_list.PRecord.DATA := StrToDate(AValue);
    Exam_boln_list_DATEOFBIRTH: Exam_boln_list.PRecord.DATEOFBIRTH := StrToDate(AValue);
    Exam_boln_list_DAYS_FREE: Exam_boln_list.PRecord.DAYS_FREE := StrToInt(AValue);
    Exam_boln_list_DAYS_HOME: Exam_boln_list.PRecord.DAYS_HOME := StrToInt(AValue);
    Exam_boln_list_DAYS_HOSPITAL: Exam_boln_list.PRecord.DAYS_HOSPITAL := StrToInt(AValue);
    Exam_boln_list_DAYS_IN_WORDS: Exam_boln_list.PRecord.DAYS_IN_WORDS := AValue;
    Exam_boln_list_DAYS_SANATORIUM: Exam_boln_list.PRecord.DAYS_SANATORIUM := StrToInt(AValue);
    Exam_boln_list_EL_NUMBER: Exam_boln_list.PRecord.EL_NUMBER := AValue;
    Exam_boln_list_FORM_LETTER: Exam_boln_list.PRecord.FORM_LETTER := AValue;
    Exam_boln_list_FORM_NUMBER: Exam_boln_list.PRecord.FORM_NUMBER := StrToInt(AValue);
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: Exam_boln_list.PRecord.IAVIAVANE_PREGLED_DATE := StrToDate(AValue);
    Exam_boln_list_ID: Exam_boln_list.PRecord.ID := StrToInt(AValue);
    Exam_boln_list_IST_ZABOL_NO: Exam_boln_list.PRecord.IST_ZABOL_NO := AValue;
    Exam_boln_list_IZDADEN_OT: Exam_boln_list.PRecord.IZDADEN_OT := AValue;
    Exam_boln_list_LAK_NUMBER: Exam_boln_list.PRecord.LAK_NUMBER := StrToInt(AValue);
    Exam_boln_list_LKK_TYPE: Exam_boln_list.PRecord.LKK_TYPE := AValue;
    Exam_boln_list_NERABOTOSP_ID: Exam_boln_list.PRecord.NERABOTOSP_ID := StrToInt(AValue);
    Exam_boln_list_NOTES: Exam_boln_list.PRecord.NOTES := AValue;
    Exam_boln_list_NOTES_ID: Exam_boln_list.PRecord.NOTES_ID := StrToInt(AValue);
    Exam_boln_list_NUMBER: Exam_boln_list.PRecord.NUMBER := StrToInt(AValue);
    Exam_boln_list_NUMBER_ANUL: Exam_boln_list.PRecord.NUMBER_ANUL := AValue;
    Exam_boln_list_OTHER_PRACTICA_ID: Exam_boln_list.PRecord.OTHER_PRACTICA_ID := StrToInt(AValue);
    Exam_boln_list_PATIENT_EGN: Exam_boln_list.PRecord.PATIENT_EGN := AValue;
    Exam_boln_list_PATIENT_LNCH: Exam_boln_list.PRecord.PATIENT_LNCH := AValue;
    Exam_boln_list_PREGLED_ID: Exam_boln_list.PRecord.PREGLED_ID := StrToInt(AValue);
    Exam_boln_list_REALATIONSHIP: Exam_boln_list.PRecord.REALATIONSHIP := AValue;
    Exam_boln_list_REL_SHIP_CODE: Exam_boln_list.PRecord.REL_SHIP_CODE := StrToInt(AValue);
    Exam_boln_list_RESHENIEDATE: Exam_boln_list.PRecord.RESHENIEDATE := StrToDate(AValue);
    Exam_boln_list_RESHENIEDATE_TELK: Exam_boln_list.PRecord.RESHENIEDATE_TELK := StrToDate(AValue);
    Exam_boln_list_RESHENIENO: Exam_boln_list.PRecord.RESHENIENO := AValue;
    Exam_boln_list_RESHENIENO_TELK: Exam_boln_list.PRecord.RESHENIENO_TELK := AValue;
    Exam_boln_list_SICK_LEAVE_END: Exam_boln_list.PRecord.SICK_LEAVE_END := StrToDate(AValue);
    Exam_boln_list_SICK_LEAVE_START: Exam_boln_list.PRecord.SICK_LEAVE_START := StrToDate(AValue);
    Exam_boln_list_TERMIN_DATE: Exam_boln_list.PRecord.TERMIN_DATE := StrToDate(AValue);
    Exam_boln_list_TREATMENT_REGIMEN: Exam_boln_list.PRecord.TREATMENT_REGIMEN := StrToInt(AValue);
    Exam_boln_list_Logical: Exam_boln_list.PRecord.Logical := tlogicalExam_boln_listSet(Exam_boln_list.StrToLogical16(AValue));
  end;
end;

procedure TExam_boln_listColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Exam_boln_list: TExam_boln_listItem;
begin
  if Count = 0 then Exit;

  Exam_boln_list := Items[ARow];
  if not Assigned(Exam_boln_list.PRecord) then
  begin
    New(Exam_boln_list.PRecord);
    Exam_boln_list.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TExam_boln_listItem.TPropertyIndex(ACol) of
      Exam_boln_list_AMB_JOURNAL_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_ASSISTED_PERSON_NAME: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_ASSISTED_PERSON_PID: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_CUSTOMIZE: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_DATA: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_DATEOFBIRTH: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_DAYS_FREE: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_DAYS_HOME: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_DAYS_HOSPITAL: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_DAYS_IN_WORDS: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_DAYS_SANATORIUM: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_EL_NUMBER: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_FORM_LETTER: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_FORM_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_IST_ZABOL_NO: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_IZDADEN_OT: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_LAK_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_LKK_TYPE: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_NERABOTOSP_ID: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_NOTES: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_NOTES_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_NUMBER: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_NUMBER_ANUL: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_OTHER_PRACTICA_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_PATIENT_EGN: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_PATIENT_LNCH: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_PREGLED_ID: isOld :=  Exam_boln_list.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_REALATIONSHIP: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_REL_SHIP_CODE: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Exam_boln_list_RESHENIEDATE: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_RESHENIEDATE_TELK: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_RESHENIENO: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_RESHENIENO_TELK: isOld :=  Exam_boln_list.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Exam_boln_list_SICK_LEAVE_END: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_SICK_LEAVE_START: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_TERMIN_DATE: isOld :=  Exam_boln_list.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Exam_boln_list_TREATMENT_REGIMEN: isOld :=  Exam_boln_list.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Exam_boln_list.PRecord.setProp, TExam_boln_listItem.TPropertyIndex(ACol));
    if Exam_boln_list.PRecord.setProp = [] then
    begin
      Dispose(Exam_boln_list.PRecord);
      Exam_boln_list.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Exam_boln_list.PRecord.setProp, TExam_boln_listItem.TPropertyIndex(ACol));
  case TExam_boln_listItem.TPropertyIndex(ACol) of
    Exam_boln_list_AMB_JOURNAL_NUMBER: Exam_boln_list.PRecord.AMB_JOURNAL_NUMBER := StrToInt(AFieldText);
    Exam_boln_list_ASSISTED_PERSON_NAME: Exam_boln_list.PRecord.ASSISTED_PERSON_NAME := AFieldText;
    Exam_boln_list_ASSISTED_PERSON_PID: Exam_boln_list.PRecord.ASSISTED_PERSON_PID := AFieldText;
    Exam_boln_list_CUSTOMIZE: Exam_boln_list.PRecord.CUSTOMIZE := StrToInt(AFieldText);
    Exam_boln_list_DATA: Exam_boln_list.PRecord.DATA := StrToDate(AFieldText);
    Exam_boln_list_DATEOFBIRTH: Exam_boln_list.PRecord.DATEOFBIRTH := StrToDate(AFieldText);
    Exam_boln_list_DAYS_FREE: Exam_boln_list.PRecord.DAYS_FREE := StrToInt(AFieldText);
    Exam_boln_list_DAYS_HOME: Exam_boln_list.PRecord.DAYS_HOME := StrToInt(AFieldText);
    Exam_boln_list_DAYS_HOSPITAL: Exam_boln_list.PRecord.DAYS_HOSPITAL := StrToInt(AFieldText);
    Exam_boln_list_DAYS_IN_WORDS: Exam_boln_list.PRecord.DAYS_IN_WORDS := AFieldText;
    Exam_boln_list_DAYS_SANATORIUM: Exam_boln_list.PRecord.DAYS_SANATORIUM := StrToInt(AFieldText);
    Exam_boln_list_EL_NUMBER: Exam_boln_list.PRecord.EL_NUMBER := AFieldText;
    Exam_boln_list_FORM_LETTER: Exam_boln_list.PRecord.FORM_LETTER := AFieldText;
    Exam_boln_list_FORM_NUMBER: Exam_boln_list.PRecord.FORM_NUMBER := StrToInt(AFieldText);
    Exam_boln_list_IAVIAVANE_PREGLED_DATE: Exam_boln_list.PRecord.IAVIAVANE_PREGLED_DATE := StrToDate(AFieldText);
    Exam_boln_list_ID: Exam_boln_list.PRecord.ID := StrToInt(AFieldText);
    Exam_boln_list_IST_ZABOL_NO: Exam_boln_list.PRecord.IST_ZABOL_NO := AFieldText;
    Exam_boln_list_IZDADEN_OT: Exam_boln_list.PRecord.IZDADEN_OT := AFieldText;
    Exam_boln_list_LAK_NUMBER: Exam_boln_list.PRecord.LAK_NUMBER := StrToInt(AFieldText);
    Exam_boln_list_LKK_TYPE: Exam_boln_list.PRecord.LKK_TYPE := AFieldText;
    Exam_boln_list_NERABOTOSP_ID: Exam_boln_list.PRecord.NERABOTOSP_ID := StrToInt(AFieldText);
    Exam_boln_list_NOTES: Exam_boln_list.PRecord.NOTES := AFieldText;
    Exam_boln_list_NOTES_ID: Exam_boln_list.PRecord.NOTES_ID := StrToInt(AFieldText);
    Exam_boln_list_NUMBER: Exam_boln_list.PRecord.NUMBER := StrToInt(AFieldText);
    Exam_boln_list_NUMBER_ANUL: Exam_boln_list.PRecord.NUMBER_ANUL := AFieldText;
    Exam_boln_list_OTHER_PRACTICA_ID: Exam_boln_list.PRecord.OTHER_PRACTICA_ID := StrToInt(AFieldText);
    Exam_boln_list_PATIENT_EGN: Exam_boln_list.PRecord.PATIENT_EGN := AFieldText;
    Exam_boln_list_PATIENT_LNCH: Exam_boln_list.PRecord.PATIENT_LNCH := AFieldText;
    Exam_boln_list_PREGLED_ID: Exam_boln_list.PRecord.PREGLED_ID := StrToInt(AFieldText);
    Exam_boln_list_REALATIONSHIP: Exam_boln_list.PRecord.REALATIONSHIP := AFieldText;
    Exam_boln_list_REL_SHIP_CODE: Exam_boln_list.PRecord.REL_SHIP_CODE := StrToInt(AFieldText);
    Exam_boln_list_RESHENIEDATE: Exam_boln_list.PRecord.RESHENIEDATE := StrToDate(AFieldText);
    Exam_boln_list_RESHENIEDATE_TELK: Exam_boln_list.PRecord.RESHENIEDATE_TELK := StrToDate(AFieldText);
    Exam_boln_list_RESHENIENO: Exam_boln_list.PRecord.RESHENIENO := AFieldText;
    Exam_boln_list_RESHENIENO_TELK: Exam_boln_list.PRecord.RESHENIENO_TELK := AFieldText;
    Exam_boln_list_SICK_LEAVE_END: Exam_boln_list.PRecord.SICK_LEAVE_END := StrToDate(AFieldText);
    Exam_boln_list_SICK_LEAVE_START: Exam_boln_list.PRecord.SICK_LEAVE_START := StrToDate(AFieldText);
    Exam_boln_list_TERMIN_DATE: Exam_boln_list.PRecord.TERMIN_DATE := StrToDate(AFieldText);
    Exam_boln_list_TREATMENT_REGIMEN: Exam_boln_list.PRecord.TREATMENT_REGIMEN := StrToInt(AFieldText);
    Exam_boln_list_Logical: Exam_boln_list.PRecord.Logical := tlogicalExam_boln_listSet(Exam_boln_list.StrToLogical16(AFieldText));
  end;
end;

procedure TExam_boln_listColl.SetItem(Index: Integer; const Value: TExam_boln_listItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TExam_boln_listColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListExam_boln_listSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TExam_boln_listItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Exam_boln_list_AMB_JOURNAL_NUMBER: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListExam_boln_listSearch.Add(self.Items[i]);
  end;
end;
      Exam_boln_list_ASSISTED_PERSON_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_ASSISTED_PERSON_PID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_CUSTOMIZE: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_DAYS_FREE: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_DAYS_HOME: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_DAYS_HOSPITAL: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_DAYS_IN_WORDS:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_DAYS_SANATORIUM: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_EL_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_FORM_LETTER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_FORM_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_IST_ZABOL_NO:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_IZDADEN_OT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_LAK_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_LKK_TYPE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_NERABOTOSP_ID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_NOTES:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_NOTES_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_NUMBER_ANUL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_OTHER_PRACTICA_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_PATIENT_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_PATIENT_LNCH:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_PREGLED_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_REALATIONSHIP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_REL_SHIP_CODE: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_RESHENIENO:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_RESHENIENO_TELK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
      Exam_boln_list_TREATMENT_REGIMEN: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListExam_boln_listSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TExam_boln_listColl.ShowGrid(Grid: TTeeGrid);
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

procedure TExam_boln_listColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListExam_boln_listSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListExam_boln_listSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TExam_boln_listColl.SortByIndexAnsiString;
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

procedure TExam_boln_listColl.SortByIndexInt;
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

procedure TExam_boln_listColl.SortByIndexWord;
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

procedure TExam_boln_listColl.SortByIndexValue(propIndex: TExam_boln_listItem.TPropertyIndex);
begin
  case propIndex of
    Exam_boln_list_AMB_JOURNAL_NUMBER: SortByIndexInt;
      Exam_boln_list_ASSISTED_PERSON_NAME: SortByIndexAnsiString;
      Exam_boln_list_ASSISTED_PERSON_PID: SortByIndexAnsiString;
      Exam_boln_list_CUSTOMIZE: SortByIndexInt;
      Exam_boln_list_DAYS_FREE: SortByIndexWord;
      Exam_boln_list_DAYS_HOME: SortByIndexWord;
      Exam_boln_list_DAYS_HOSPITAL: SortByIndexWord;
      Exam_boln_list_DAYS_IN_WORDS: SortByIndexAnsiString;
      Exam_boln_list_DAYS_SANATORIUM: SortByIndexWord;
      Exam_boln_list_EL_NUMBER: SortByIndexAnsiString;
      Exam_boln_list_FORM_LETTER: SortByIndexAnsiString;
      Exam_boln_list_FORM_NUMBER: SortByIndexInt;
      Exam_boln_list_ID: SortByIndexInt;
      Exam_boln_list_IST_ZABOL_NO: SortByIndexAnsiString;
      Exam_boln_list_IZDADEN_OT: SortByIndexAnsiString;
      Exam_boln_list_LAK_NUMBER: SortByIndexInt;
      Exam_boln_list_LKK_TYPE: SortByIndexAnsiString;
      Exam_boln_list_NERABOTOSP_ID: SortByIndexWord;
      Exam_boln_list_NOTES: SortByIndexAnsiString;
      Exam_boln_list_NOTES_ID: SortByIndexInt;
      Exam_boln_list_NUMBER: SortByIndexInt;
      Exam_boln_list_NUMBER_ANUL: SortByIndexAnsiString;
      Exam_boln_list_OTHER_PRACTICA_ID: SortByIndexInt;
      Exam_boln_list_PATIENT_EGN: SortByIndexAnsiString;
      Exam_boln_list_PATIENT_LNCH: SortByIndexAnsiString;
      Exam_boln_list_PREGLED_ID: SortByIndexInt;
      Exam_boln_list_REALATIONSHIP: SortByIndexAnsiString;
      Exam_boln_list_REL_SHIP_CODE: SortByIndexWord;
      Exam_boln_list_RESHENIENO: SortByIndexAnsiString;
      Exam_boln_list_RESHENIENO_TELK: SortByIndexAnsiString;
      Exam_boln_list_TREATMENT_REGIMEN: SortByIndexWord;
  end;
end;

end.