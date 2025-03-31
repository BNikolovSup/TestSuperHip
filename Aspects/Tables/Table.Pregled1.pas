unit Table.Pregled;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows;

type

TTeeGRD = class(VCLTee.Grid.TTeeGrid);


TPregledItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Pregled_AMB_LISTN
, Pregled_AMB_PR
, Pregled_ANAMN
, Pregled_COPIED_FROM_NRN
, Pregled_DOCTOR_ID
, Pregled_DOM_PR
, Pregled_EXAM_BOLN_LIST_ID
, Pregled_FUND_ID
, Pregled_GS
, Pregled_ID
, Pregled_INCIDENTALLY
, Pregled_IS_ANALYSIS
, Pregled_IS_BABY_CARE
, Pregled_IS_CONSULTATION
, Pregled_IS_DISPANSERY
, Pregled_IS_EMERGENCY
, Pregled_IS_EPIKRIZA
, Pregled_IS_EXPERTIZA
, Pregled_IS_FORM_VALID
, Pregled_IS_HOSPITALIZATION
, Pregled_IS_MANIPULATION
, Pregled_IS_MEDBELEJKA
, Pregled_IS_NAET
, Pregled_IS_NAPR_TELK
, Pregled_IS_NEW
, Pregled_IS_NOTIFICATION
, Pregled_IS_NO_DELAY
, Pregled_IS_OPERATION
, Pregled_IS_PODVIZHNO_LZ
, Pregled_IS_PREVENTIVE
, Pregled_IS_PRINTED
, Pregled_IS_RECEPTA_HOSPIT
, Pregled_IS_REGISTRATION
, Pregled_IS_REHABILITATION
, Pregled_IS_RISK_GROUP
, Pregled_IS_TELK
, Pregled_IS_VSD
, Pregled_IS_ZAMESTVASHT
, Pregled_IZSL
, Pregled_LIFESENSOR_ID
, Pregled_LKK_KOMISII_ID
, Pregled_MAIN_DIAG_MKB
, Pregled_MAIN_DIAG_MKB_ADD
, Pregled_MAIN_DIAG_OPIS
, Pregled_MEDTRANSKM
, Pregled_NAPRAVLENIE_AMBL_NOMER
, Pregled_NAPR_TYPE_ID
, Pregled_NOMERBELEGKA
, Pregled_NOMERKASHAPARAT
, Pregled_NRD
, Pregled_NRN
, Pregled_NZIS_STATUS
, Pregled_OBSHTAPR
, Pregled_OWNER_DOCTOR_ID
, Pregled_PACIENT_ID
, Pregled_PATIENTOF_NEOTL
, Pregled_PATIENTOF_NEOTLID
, Pregled_PAY
, Pregled_PREVENTIVE_TYPE
, Pregled_PRIMARY_NOTE_ID
, Pregled_PROCEDURE1_ID
, Pregled_PROCEDURE1_MKB
, Pregled_PROCEDURE1_OPIS
, Pregled_PROCEDURE2_ID
, Pregled_PROCEDURE2_MKB
, Pregled_PROCEDURE2_OPIS
, Pregled_PROCEDURE3_ID
, Pregled_PROCEDURE3_MKB
, Pregled_PROCEDURE3_OPIS
, Pregled_PROCEDURE4_ID
, Pregled_PROCEDURE4_MKB
, Pregled_PROCEDURE4_OPIS
, Pregled_PR_ZAB1_MKB
, Pregled_PR_ZAB1_MKB_ADD
, Pregled_PR_ZAB1_OPIS
, Pregled_PR_ZAB2_MKB
, Pregled_PR_ZAB2_MKB_ADD
, Pregled_PR_ZAB2_OPIS
, Pregled_PR_ZAB3_MKB
, Pregled_PR_ZAB3_MKB_ADD
, Pregled_PR_ZAB3_OPIS
, Pregled_PR_ZAB4_MKB
, Pregled_PR_ZAB4_MKB_ADD
, Pregled_PR_ZAB4_OPIS
, Pregled_RECKNNO
, Pregled_REH_FINISHED_AT
, Pregled_REH_PROC1
, Pregled_REH_PROC2
, Pregled_REH_PROC3
, Pregled_REH_PROC4
, Pregled_SIMP_FORM_DATE
, Pregled_SIMP_IS_NAET
, Pregled_SIMP_IS_ZAMESTVASHT
, Pregled_SIMP_NAPR_ID
, Pregled_SIMP_NAPR_N
, Pregled_SIMP_NAPR_NRN
, Pregled_SIMP_NZOKNOMER
, Pregled_SIMP_PRAKTIKA
, Pregled_SIMP_PRIMARY_AMBLIST_DATE
, Pregled_SIMP_PRIMARY_AMBLIST_N
, Pregled_SIMP_PRIMARY_AMBLIST_NRN
, Pregled_SIMP_SPECIALITY_CODE
, Pregled_SIMP_UIN
, Pregled_SIMP_UIN_ZAMESTVASHT
, Pregled_START_DATE
, Pregled_START_TIME
, Pregled_SYST
, Pregled_TALON_LKK
, Pregled_TERAPY
, Pregled_THREAD_IDS
, Pregled_TO_BE_DISPANSERED
, Pregled_VISIT_ID
, Pregled_VISIT_TYPE_ID
, Pregled_VSD_TYPE
);
      TSetProp = set of TPropertyIndex;
      PRecPregled = ^TRecPregled;
      TRecPregled = record
        AMB_LISTN: integer;
        AMB_PR: word;
        ANAMN: AnsiString;
        COPIED_FROM_NRN: AnsiString;
        DOCTOR_ID: integer;
        DOM_PR: word;
        EXAM_BOLN_LIST_ID: integer;
        FUND_ID: integer;
        GS: word;
        ID: integer;
        INCIDENTALLY: boolean;
        IS_ANALYSIS: boolean;
        IS_BABY_CARE: boolean;
        IS_CONSULTATION: boolean;
        IS_DISPANSERY: boolean;
        IS_EMERGENCY: boolean;
        IS_EPIKRIZA: boolean;
        IS_EXPERTIZA: boolean;
        IS_FORM_VALID: boolean;
        IS_HOSPITALIZATION: boolean;
        IS_MANIPULATION: boolean;
        IS_MEDBELEJKA: boolean;
        IS_NAET: boolean;
        IS_NAPR_TELK: boolean;
        IS_NEW: boolean;
        IS_NOTIFICATION: boolean;
        IS_NO_DELAY: boolean;
        IS_OPERATION: boolean;
        IS_PODVIZHNO_LZ: boolean;
        IS_PREVENTIVE: boolean;
        IS_PRINTED: AnsiString;
        IS_RECEPTA_HOSPIT: boolean;
        IS_REGISTRATION: boolean;
        IS_REHABILITATION: boolean;
        IS_RISK_GROUP: boolean;
        IS_TELK: boolean;
        IS_VSD: boolean;
        IS_ZAMESTVASHT: boolean;
        IZSL: AnsiString;
        LIFESENSOR_ID: AnsiString;
        LKK_KOMISII_ID: integer;
        MAIN_DIAG_MKB: AnsiString;
        MAIN_DIAG_MKB_ADD: AnsiString;
        MAIN_DIAG_OPIS: AnsiString;
        MEDTRANSKM: integer;
        NAPRAVLENIE_AMBL_NOMER: AnsiString;
        NAPR_TYPE_ID: word;
        NOMERBELEGKA: AnsiString;
        NOMERKASHAPARAT: AnsiString;
        NRD: word;
        NRN: AnsiString;
        NZIS_STATUS: word;
        OBSHTAPR: word;
        OWNER_DOCTOR_ID: integer;
        PACIENT_ID: integer;
        PATIENTOF_NEOTL: AnsiString;
        PATIENTOF_NEOTLID: integer;
        PAY: boolean;
        PREVENTIVE_TYPE: word;
        PRIMARY_NOTE_ID: integer;
        PROCEDURE1_ID: integer;
        PROCEDURE1_MKB: AnsiString;
        PROCEDURE1_OPIS: AnsiString;
        PROCEDURE2_ID: integer;
        PROCEDURE2_MKB: AnsiString;
        PROCEDURE2_OPIS: AnsiString;
        PROCEDURE3_ID: integer;
        PROCEDURE3_MKB: AnsiString;
        PROCEDURE3_OPIS: AnsiString;
        PROCEDURE4_ID: integer;
        PROCEDURE4_MKB: AnsiString;
        PROCEDURE4_OPIS: AnsiString;
        PR_ZAB1_MKB: AnsiString;
        PR_ZAB1_MKB_ADD: AnsiString;
        PR_ZAB1_OPIS: AnsiString;
        PR_ZAB2_MKB: AnsiString;
        PR_ZAB2_MKB_ADD: AnsiString;
        PR_ZAB2_OPIS: AnsiString;
        PR_ZAB3_MKB: AnsiString;
        PR_ZAB3_MKB_ADD: AnsiString;
        PR_ZAB3_OPIS: AnsiString;
        PR_ZAB4_MKB: AnsiString;
        PR_ZAB4_MKB_ADD: AnsiString;
        PR_ZAB4_OPIS: AnsiString;
        RECKNNO: AnsiString;
        REH_FINISHED_AT: TDATE;
        REH_PROC1: integer;
        REH_PROC2: integer;
        REH_PROC3: integer;
        REH_PROC4: integer;
        SIMP_FORM_DATE: TDATE;
        SIMP_IS_NAET: boolean;
        SIMP_IS_ZAMESTVASHT: boolean;
        SIMP_NAPR_ID: integer;
        SIMP_NAPR_N: integer;
        SIMP_NAPR_NRN: AnsiString;
        SIMP_NZOKNOMER: AnsiString;
        SIMP_PRAKTIKA: AnsiString;
        SIMP_PRIMARY_AMBLIST_DATE: TDATE;
        SIMP_PRIMARY_AMBLIST_N: integer;
        SIMP_PRIMARY_AMBLIST_NRN: AnsiString;
        SIMP_SPECIALITY_CODE: AnsiString;
        SIMP_UIN: AnsiString;
        SIMP_UIN_ZAMESTVASHT: AnsiString;
        START_DATE: TDATE;
        START_TIME: TTIME;
        SYST: AnsiString;
        TALON_LKK: AnsiString;
        TERAPY: AnsiString;
        THREAD_IDS: AnsiString;
        TO_BE_DISPANSERED: boolean;
        VISIT_ID: integer;
        VISIT_TYPE_ID: word;
        VSD_TYPE: word;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPregled;
    function FieldCount: Integer;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPregled;
    procedure UpdatePregled;
    procedure SavePregled(var dataPosition: Cardinal);
  end;


  TPregledColl = class(TBaseCollection)
  private
    function GetItem(Index: Integer): TPregledItem;
    procedure SetItem(Index: Integer; const Value: TPregledItem);
  public
    function AddItem(ver: word):TPregledItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Pregled: TPregledItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Pregled: TPregledItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    function DisplayName(propIndex: Word): string;
    
    property Items[Index: Integer]: TPregledItem read GetItem write SetItem;
  end;

implementation

{ TPregledItem }

constructor TPregledItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPregledItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

function TPregledItem.FieldCount: Integer;
begin
  Result := 114;
end;

procedure TPregledItem.InsertPregled;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := ctPregled;
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
            Pregled_AMB_LISTN: SaveData(PRecord.AMB_LISTN, PropPosition, metaPosition, dataPosition);
            Pregled_AMB_PR: SaveData(PRecord.AMB_PR, PropPosition, metaPosition, dataPosition);
            Pregled_ANAMN: SaveData(PRecord.ANAMN, PropPosition, metaPosition, dataPosition);
            Pregled_COPIED_FROM_NRN: SaveData(PRecord.COPIED_FROM_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_DOCTOR_ID: SaveData(PRecord.DOCTOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_DOM_PR: SaveData(PRecord.DOM_PR, PropPosition, metaPosition, dataPosition);
            Pregled_EXAM_BOLN_LIST_ID: SaveData(PRecord.EXAM_BOLN_LIST_ID, PropPosition, metaPosition, dataPosition);
            Pregled_FUND_ID: SaveData(PRecord.FUND_ID, PropPosition, metaPosition, dataPosition);
            Pregled_GS: SaveData(PRecord.GS, PropPosition, metaPosition, dataPosition);
            Pregled_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Pregled_INCIDENTALLY: SaveData(PRecord.INCIDENTALLY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_ANALYSIS: SaveData(PRecord.IS_ANALYSIS, PropPosition, metaPosition, dataPosition);
            Pregled_IS_BABY_CARE: SaveData(PRecord.IS_BABY_CARE, PropPosition, metaPosition, dataPosition);
            Pregled_IS_CONSULTATION: SaveData(PRecord.IS_CONSULTATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_DISPANSERY: SaveData(PRecord.IS_DISPANSERY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EMERGENCY: SaveData(PRecord.IS_EMERGENCY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EPIKRIZA: SaveData(PRecord.IS_EPIKRIZA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EXPERTIZA: SaveData(PRecord.IS_EXPERTIZA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_FORM_VALID: SaveData(PRecord.IS_FORM_VALID, PropPosition, metaPosition, dataPosition);
            Pregled_IS_HOSPITALIZATION: SaveData(PRecord.IS_HOSPITALIZATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_MANIPULATION: SaveData(PRecord.IS_MANIPULATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_MEDBELEJKA: SaveData(PRecord.IS_MEDBELEJKA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NAET: SaveData(PRecord.IS_NAET, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NAPR_TELK: SaveData(PRecord.IS_NAPR_TELK, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NEW: SaveData(PRecord.IS_NEW, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NOTIFICATION: SaveData(PRecord.IS_NOTIFICATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NO_DELAY: SaveData(PRecord.IS_NO_DELAY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_OPERATION: SaveData(PRecord.IS_OPERATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PODVIZHNO_LZ: SaveData(PRecord.IS_PODVIZHNO_LZ, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PREVENTIVE: SaveData(PRecord.IS_PREVENTIVE, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PRINTED: SaveData(PRecord.IS_PRINTED, PropPosition, metaPosition, dataPosition);
            Pregled_IS_RECEPTA_HOSPIT: SaveData(PRecord.IS_RECEPTA_HOSPIT, PropPosition, metaPosition, dataPosition);
            Pregled_IS_REGISTRATION: SaveData(PRecord.IS_REGISTRATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_REHABILITATION: SaveData(PRecord.IS_REHABILITATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_RISK_GROUP: SaveData(PRecord.IS_RISK_GROUP, PropPosition, metaPosition, dataPosition);
            Pregled_IS_TELK: SaveData(PRecord.IS_TELK, PropPosition, metaPosition, dataPosition);
            Pregled_IS_VSD: SaveData(PRecord.IS_VSD, PropPosition, metaPosition, dataPosition);
            Pregled_IS_ZAMESTVASHT: SaveData(PRecord.IS_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_IZSL: SaveData(PRecord.IZSL, PropPosition, metaPosition, dataPosition);
            Pregled_LIFESENSOR_ID: SaveData(PRecord.LIFESENSOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_LKK_KOMISII_ID: SaveData(PRecord.LKK_KOMISII_ID, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_MKB: SaveData(PRecord.MAIN_DIAG_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_MKB_ADD: SaveData(PRecord.MAIN_DIAG_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_OPIS: SaveData(PRecord.MAIN_DIAG_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_MEDTRANSKM: SaveData(PRecord.MEDTRANSKM, PropPosition, metaPosition, dataPosition);
            Pregled_NAPRAVLENIE_AMBL_NOMER: SaveData(PRecord.NAPRAVLENIE_AMBL_NOMER, PropPosition, metaPosition, dataPosition);
            Pregled_NAPR_TYPE_ID: SaveData(PRecord.NAPR_TYPE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_NOMERBELEGKA: SaveData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            Pregled_NOMERKASHAPARAT: SaveData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            Pregled_NRD: SaveData(PRecord.NRD, PropPosition, metaPosition, dataPosition);
            Pregled_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            Pregled_NZIS_STATUS: SaveData(PRecord.NZIS_STATUS, PropPosition, metaPosition, dataPosition);
            Pregled_OBSHTAPR: SaveData(PRecord.OBSHTAPR, PropPosition, metaPosition, dataPosition);
            Pregled_OWNER_DOCTOR_ID: SaveData(PRecord.OWNER_DOCTOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PACIENT_ID: SaveData(PRecord.PACIENT_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PATIENTOF_NEOTL: SaveData(PRecord.PATIENTOF_NEOTL, PropPosition, metaPosition, dataPosition);
            Pregled_PATIENTOF_NEOTLID: SaveData(PRecord.PATIENTOF_NEOTLID, PropPosition, metaPosition, dataPosition);
            Pregled_PAY: SaveData(PRecord.PAY, PropPosition, metaPosition, dataPosition);
            Pregled_PREVENTIVE_TYPE: SaveData(PRecord.PREVENTIVE_TYPE, PropPosition, metaPosition, dataPosition);
            Pregled_PRIMARY_NOTE_ID: SaveData(PRecord.PRIMARY_NOTE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_ID: SaveData(PRecord.PROCEDURE1_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_MKB: SaveData(PRecord.PROCEDURE1_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_OPIS: SaveData(PRecord.PROCEDURE1_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_ID: SaveData(PRecord.PROCEDURE2_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_MKB: SaveData(PRecord.PROCEDURE2_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_OPIS: SaveData(PRecord.PROCEDURE2_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_ID: SaveData(PRecord.PROCEDURE3_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_MKB: SaveData(PRecord.PROCEDURE3_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_OPIS: SaveData(PRecord.PROCEDURE3_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_ID: SaveData(PRecord.PROCEDURE4_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_MKB: SaveData(PRecord.PROCEDURE4_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_OPIS: SaveData(PRecord.PROCEDURE4_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_MKB: SaveData(PRecord.PR_ZAB1_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_MKB_ADD: SaveData(PRecord.PR_ZAB1_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_OPIS: SaveData(PRecord.PR_ZAB1_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_MKB: SaveData(PRecord.PR_ZAB2_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_MKB_ADD: SaveData(PRecord.PR_ZAB2_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_OPIS: SaveData(PRecord.PR_ZAB2_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_MKB: SaveData(PRecord.PR_ZAB3_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_MKB_ADD: SaveData(PRecord.PR_ZAB3_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_OPIS: SaveData(PRecord.PR_ZAB3_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_MKB: SaveData(PRecord.PR_ZAB4_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_MKB_ADD: SaveData(PRecord.PR_ZAB4_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_OPIS: SaveData(PRecord.PR_ZAB4_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_RECKNNO: SaveData(PRecord.RECKNNO, PropPosition, metaPosition, dataPosition);
            Pregled_REH_FINISHED_AT: SaveData(PRecord.REH_FINISHED_AT, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC1: SaveData(PRecord.REH_PROC1, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC2: SaveData(PRecord.REH_PROC2, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC3: SaveData(PRecord.REH_PROC3, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC4: SaveData(PRecord.REH_PROC4, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_FORM_DATE: SaveData(PRecord.SIMP_FORM_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_IS_NAET: SaveData(PRecord.SIMP_IS_NAET, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_IS_ZAMESTVASHT: SaveData(PRecord.SIMP_IS_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_ID: SaveData(PRecord.SIMP_NAPR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_N: SaveData(PRecord.SIMP_NAPR_N, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_NRN: SaveData(PRecord.SIMP_NAPR_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NZOKNOMER: SaveData(PRecord.SIMP_NZOKNOMER, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRAKTIKA: SaveData(PRecord.SIMP_PRAKTIKA, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_DATE: SaveData(PRecord.SIMP_PRIMARY_AMBLIST_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_N: SaveData(PRecord.SIMP_PRIMARY_AMBLIST_N, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_NRN: SaveData(PRecord.SIMP_PRIMARY_AMBLIST_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_SPECIALITY_CODE: SaveData(PRecord.SIMP_SPECIALITY_CODE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_UIN: SaveData(PRecord.SIMP_UIN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_UIN_ZAMESTVASHT: SaveData(PRecord.SIMP_UIN_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_START_DATE: SaveData(PRecord.START_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_START_TIME: SaveData(PRecord.START_TIME, PropPosition, metaPosition, dataPosition);
            Pregled_SYST: SaveData(PRecord.SYST, PropPosition, metaPosition, dataPosition);
            Pregled_TALON_LKK: SaveData(PRecord.TALON_LKK, PropPosition, metaPosition, dataPosition);
            Pregled_TERAPY: SaveData(PRecord.TERAPY, PropPosition, metaPosition, dataPosition);
            Pregled_THREAD_IDS: SaveData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            Pregled_TO_BE_DISPANSERED: SaveData(PRecord.TO_BE_DISPANSERED, PropPosition, metaPosition, dataPosition);
            Pregled_VISIT_ID: SaveData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            Pregled_VISIT_TYPE_ID: SaveData(PRecord.VISIT_TYPE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_VSD_TYPE: SaveData(PRecord.VSD_TYPE, PropPosition, metaPosition, dataPosition);
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

procedure TPregledItem.SavePregled(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPregled;
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
            Pregled_AMB_LISTN: SaveData(PRecord.AMB_LISTN, PropPosition, metaPosition, dataPosition);
            Pregled_AMB_PR: SaveData(PRecord.AMB_PR, PropPosition, metaPosition, dataPosition);
            Pregled_ANAMN: SaveData(PRecord.ANAMN, PropPosition, metaPosition, dataPosition);
            Pregled_COPIED_FROM_NRN: SaveData(PRecord.COPIED_FROM_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_DOCTOR_ID: SaveData(PRecord.DOCTOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_DOM_PR: SaveData(PRecord.DOM_PR, PropPosition, metaPosition, dataPosition);
            Pregled_EXAM_BOLN_LIST_ID: SaveData(PRecord.EXAM_BOLN_LIST_ID, PropPosition, metaPosition, dataPosition);
            Pregled_FUND_ID: SaveData(PRecord.FUND_ID, PropPosition, metaPosition, dataPosition);
            Pregled_GS: SaveData(PRecord.GS, PropPosition, metaPosition, dataPosition);
            Pregled_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Pregled_INCIDENTALLY: SaveData(PRecord.INCIDENTALLY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_ANALYSIS: SaveData(PRecord.IS_ANALYSIS, PropPosition, metaPosition, dataPosition);
            Pregled_IS_BABY_CARE: SaveData(PRecord.IS_BABY_CARE, PropPosition, metaPosition, dataPosition);
            Pregled_IS_CONSULTATION: SaveData(PRecord.IS_CONSULTATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_DISPANSERY: SaveData(PRecord.IS_DISPANSERY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EMERGENCY: SaveData(PRecord.IS_EMERGENCY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EPIKRIZA: SaveData(PRecord.IS_EPIKRIZA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EXPERTIZA: SaveData(PRecord.IS_EXPERTIZA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_FORM_VALID: SaveData(PRecord.IS_FORM_VALID, PropPosition, metaPosition, dataPosition);
            Pregled_IS_HOSPITALIZATION: SaveData(PRecord.IS_HOSPITALIZATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_MANIPULATION: SaveData(PRecord.IS_MANIPULATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_MEDBELEJKA: SaveData(PRecord.IS_MEDBELEJKA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NAET: SaveData(PRecord.IS_NAET, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NAPR_TELK: SaveData(PRecord.IS_NAPR_TELK, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NEW: SaveData(PRecord.IS_NEW, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NOTIFICATION: SaveData(PRecord.IS_NOTIFICATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NO_DELAY: SaveData(PRecord.IS_NO_DELAY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_OPERATION: SaveData(PRecord.IS_OPERATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PODVIZHNO_LZ: SaveData(PRecord.IS_PODVIZHNO_LZ, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PREVENTIVE: SaveData(PRecord.IS_PREVENTIVE, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PRINTED: SaveData(PRecord.IS_PRINTED, PropPosition, metaPosition, dataPosition);
            Pregled_IS_RECEPTA_HOSPIT: SaveData(PRecord.IS_RECEPTA_HOSPIT, PropPosition, metaPosition, dataPosition);
            Pregled_IS_REGISTRATION: SaveData(PRecord.IS_REGISTRATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_REHABILITATION: SaveData(PRecord.IS_REHABILITATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_RISK_GROUP: SaveData(PRecord.IS_RISK_GROUP, PropPosition, metaPosition, dataPosition);
            Pregled_IS_TELK: SaveData(PRecord.IS_TELK, PropPosition, metaPosition, dataPosition);
            Pregled_IS_VSD: SaveData(PRecord.IS_VSD, PropPosition, metaPosition, dataPosition);
            Pregled_IS_ZAMESTVASHT: SaveData(PRecord.IS_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_IZSL: SaveData(PRecord.IZSL, PropPosition, metaPosition, dataPosition);
            Pregled_LIFESENSOR_ID: SaveData(PRecord.LIFESENSOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_LKK_KOMISII_ID: SaveData(PRecord.LKK_KOMISII_ID, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_MKB: SaveData(PRecord.MAIN_DIAG_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_MKB_ADD: SaveData(PRecord.MAIN_DIAG_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_OPIS: SaveData(PRecord.MAIN_DIAG_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_MEDTRANSKM: SaveData(PRecord.MEDTRANSKM, PropPosition, metaPosition, dataPosition);
            Pregled_NAPRAVLENIE_AMBL_NOMER: SaveData(PRecord.NAPRAVLENIE_AMBL_NOMER, PropPosition, metaPosition, dataPosition);
            Pregled_NAPR_TYPE_ID: SaveData(PRecord.NAPR_TYPE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_NOMERBELEGKA: SaveData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            Pregled_NOMERKASHAPARAT: SaveData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            Pregled_NRD: SaveData(PRecord.NRD, PropPosition, metaPosition, dataPosition);
            Pregled_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            Pregled_NZIS_STATUS: SaveData(PRecord.NZIS_STATUS, PropPosition, metaPosition, dataPosition);
            Pregled_OBSHTAPR: SaveData(PRecord.OBSHTAPR, PropPosition, metaPosition, dataPosition);
            Pregled_OWNER_DOCTOR_ID: SaveData(PRecord.OWNER_DOCTOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PACIENT_ID: SaveData(PRecord.PACIENT_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PATIENTOF_NEOTL: SaveData(PRecord.PATIENTOF_NEOTL, PropPosition, metaPosition, dataPosition);
            Pregled_PATIENTOF_NEOTLID: SaveData(PRecord.PATIENTOF_NEOTLID, PropPosition, metaPosition, dataPosition);
            Pregled_PAY: SaveData(PRecord.PAY, PropPosition, metaPosition, dataPosition);
            Pregled_PREVENTIVE_TYPE: SaveData(PRecord.PREVENTIVE_TYPE, PropPosition, metaPosition, dataPosition);
            Pregled_PRIMARY_NOTE_ID: SaveData(PRecord.PRIMARY_NOTE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_ID: SaveData(PRecord.PROCEDURE1_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_MKB: SaveData(PRecord.PROCEDURE1_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_OPIS: SaveData(PRecord.PROCEDURE1_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_ID: SaveData(PRecord.PROCEDURE2_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_MKB: SaveData(PRecord.PROCEDURE2_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_OPIS: SaveData(PRecord.PROCEDURE2_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_ID: SaveData(PRecord.PROCEDURE3_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_MKB: SaveData(PRecord.PROCEDURE3_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_OPIS: SaveData(PRecord.PROCEDURE3_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_ID: SaveData(PRecord.PROCEDURE4_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_MKB: SaveData(PRecord.PROCEDURE4_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_OPIS: SaveData(PRecord.PROCEDURE4_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_MKB: SaveData(PRecord.PR_ZAB1_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_MKB_ADD: SaveData(PRecord.PR_ZAB1_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_OPIS: SaveData(PRecord.PR_ZAB1_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_MKB: SaveData(PRecord.PR_ZAB2_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_MKB_ADD: SaveData(PRecord.PR_ZAB2_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_OPIS: SaveData(PRecord.PR_ZAB2_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_MKB: SaveData(PRecord.PR_ZAB3_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_MKB_ADD: SaveData(PRecord.PR_ZAB3_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_OPIS: SaveData(PRecord.PR_ZAB3_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_MKB: SaveData(PRecord.PR_ZAB4_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_MKB_ADD: SaveData(PRecord.PR_ZAB4_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_OPIS: SaveData(PRecord.PR_ZAB4_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_RECKNNO: SaveData(PRecord.RECKNNO, PropPosition, metaPosition, dataPosition);
            Pregled_REH_FINISHED_AT: SaveData(PRecord.REH_FINISHED_AT, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC1: SaveData(PRecord.REH_PROC1, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC2: SaveData(PRecord.REH_PROC2, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC3: SaveData(PRecord.REH_PROC3, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC4: SaveData(PRecord.REH_PROC4, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_FORM_DATE: SaveData(PRecord.SIMP_FORM_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_IS_NAET: SaveData(PRecord.SIMP_IS_NAET, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_IS_ZAMESTVASHT: SaveData(PRecord.SIMP_IS_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_ID: SaveData(PRecord.SIMP_NAPR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_N: SaveData(PRecord.SIMP_NAPR_N, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_NRN: SaveData(PRecord.SIMP_NAPR_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NZOKNOMER: SaveData(PRecord.SIMP_NZOKNOMER, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRAKTIKA: SaveData(PRecord.SIMP_PRAKTIKA, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_DATE: SaveData(PRecord.SIMP_PRIMARY_AMBLIST_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_N: SaveData(PRecord.SIMP_PRIMARY_AMBLIST_N, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_NRN: SaveData(PRecord.SIMP_PRIMARY_AMBLIST_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_SPECIALITY_CODE: SaveData(PRecord.SIMP_SPECIALITY_CODE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_UIN: SaveData(PRecord.SIMP_UIN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_UIN_ZAMESTVASHT: SaveData(PRecord.SIMP_UIN_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_START_DATE: SaveData(PRecord.START_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_START_TIME: SaveData(PRecord.START_TIME, PropPosition, metaPosition, dataPosition);
            Pregled_SYST: SaveData(PRecord.SYST, PropPosition, metaPosition, dataPosition);
            Pregled_TALON_LKK: SaveData(PRecord.TALON_LKK, PropPosition, metaPosition, dataPosition);
            Pregled_TERAPY: SaveData(PRecord.TERAPY, PropPosition, metaPosition, dataPosition);
            Pregled_THREAD_IDS: SaveData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            Pregled_TO_BE_DISPANSERED: SaveData(PRecord.TO_BE_DISPANSERED, PropPosition, metaPosition, dataPosition);
            Pregled_VISIT_ID: SaveData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            Pregled_VISIT_TYPE_ID: SaveData(PRecord.VISIT_TYPE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_VSD_TYPE: SaveData(PRecord.VSD_TYPE, PropPosition, metaPosition, dataPosition);
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

procedure TPregledItem.UpdatePregled;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPregled;
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
            Pregled_AMB_LISTN: UpdateData(PRecord.AMB_LISTN, PropPosition, metaPosition, dataPosition);
            Pregled_AMB_PR: UpdateData(PRecord.AMB_PR, PropPosition, metaPosition, dataPosition);
            Pregled_ANAMN: UpdateData(PRecord.ANAMN, PropPosition, metaPosition, dataPosition);
            Pregled_COPIED_FROM_NRN: UpdateData(PRecord.COPIED_FROM_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_DOCTOR_ID: UpdateData(PRecord.DOCTOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_DOM_PR: UpdateData(PRecord.DOM_PR, PropPosition, metaPosition, dataPosition);
            Pregled_EXAM_BOLN_LIST_ID: UpdateData(PRecord.EXAM_BOLN_LIST_ID, PropPosition, metaPosition, dataPosition);
            Pregled_FUND_ID: UpdateData(PRecord.FUND_ID, PropPosition, metaPosition, dataPosition);
            Pregled_GS: UpdateData(PRecord.GS, PropPosition, metaPosition, dataPosition);
            Pregled_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Pregled_INCIDENTALLY: UpdateData(PRecord.INCIDENTALLY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_ANALYSIS: UpdateData(PRecord.IS_ANALYSIS, PropPosition, metaPosition, dataPosition);
            Pregled_IS_BABY_CARE: UpdateData(PRecord.IS_BABY_CARE, PropPosition, metaPosition, dataPosition);
            Pregled_IS_CONSULTATION: UpdateData(PRecord.IS_CONSULTATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_DISPANSERY: UpdateData(PRecord.IS_DISPANSERY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EMERGENCY: UpdateData(PRecord.IS_EMERGENCY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EPIKRIZA: UpdateData(PRecord.IS_EPIKRIZA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_EXPERTIZA: UpdateData(PRecord.IS_EXPERTIZA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_FORM_VALID: UpdateData(PRecord.IS_FORM_VALID, PropPosition, metaPosition, dataPosition);
            Pregled_IS_HOSPITALIZATION: UpdateData(PRecord.IS_HOSPITALIZATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_MANIPULATION: UpdateData(PRecord.IS_MANIPULATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_MEDBELEJKA: UpdateData(PRecord.IS_MEDBELEJKA, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NAET: UpdateData(PRecord.IS_NAET, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NAPR_TELK: UpdateData(PRecord.IS_NAPR_TELK, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NEW: UpdateData(PRecord.IS_NEW, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NOTIFICATION: UpdateData(PRecord.IS_NOTIFICATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_NO_DELAY: UpdateData(PRecord.IS_NO_DELAY, PropPosition, metaPosition, dataPosition);
            Pregled_IS_OPERATION: UpdateData(PRecord.IS_OPERATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PODVIZHNO_LZ: UpdateData(PRecord.IS_PODVIZHNO_LZ, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PREVENTIVE: UpdateData(PRecord.IS_PREVENTIVE, PropPosition, metaPosition, dataPosition);
            Pregled_IS_PRINTED: UpdateData(PRecord.IS_PRINTED, PropPosition, metaPosition, dataPosition);
            Pregled_IS_RECEPTA_HOSPIT: UpdateData(PRecord.IS_RECEPTA_HOSPIT, PropPosition, metaPosition, dataPosition);
            Pregled_IS_REGISTRATION: UpdateData(PRecord.IS_REGISTRATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_REHABILITATION: UpdateData(PRecord.IS_REHABILITATION, PropPosition, metaPosition, dataPosition);
            Pregled_IS_RISK_GROUP: UpdateData(PRecord.IS_RISK_GROUP, PropPosition, metaPosition, dataPosition);
            Pregled_IS_TELK: UpdateData(PRecord.IS_TELK, PropPosition, metaPosition, dataPosition);
            Pregled_IS_VSD: UpdateData(PRecord.IS_VSD, PropPosition, metaPosition, dataPosition);
            Pregled_IS_ZAMESTVASHT: UpdateData(PRecord.IS_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_IZSL: UpdateData(PRecord.IZSL, PropPosition, metaPosition, dataPosition);
            Pregled_LIFESENSOR_ID: UpdateData(PRecord.LIFESENSOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_LKK_KOMISII_ID: UpdateData(PRecord.LKK_KOMISII_ID, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_MKB: UpdateData(PRecord.MAIN_DIAG_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_MKB_ADD: UpdateData(PRecord.MAIN_DIAG_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_MAIN_DIAG_OPIS: UpdateData(PRecord.MAIN_DIAG_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_MEDTRANSKM: UpdateData(PRecord.MEDTRANSKM, PropPosition, metaPosition, dataPosition);
            Pregled_NAPRAVLENIE_AMBL_NOMER: UpdateData(PRecord.NAPRAVLENIE_AMBL_NOMER, PropPosition, metaPosition, dataPosition);
            Pregled_NAPR_TYPE_ID: UpdateData(PRecord.NAPR_TYPE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_NOMERBELEGKA: UpdateData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            Pregled_NOMERKASHAPARAT: UpdateData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            Pregled_NRD: UpdateData(PRecord.NRD, PropPosition, metaPosition, dataPosition);
            Pregled_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            Pregled_NZIS_STATUS: UpdateData(PRecord.NZIS_STATUS, PropPosition, metaPosition, dataPosition);
            Pregled_OBSHTAPR: UpdateData(PRecord.OBSHTAPR, PropPosition, metaPosition, dataPosition);
            Pregled_OWNER_DOCTOR_ID: UpdateData(PRecord.OWNER_DOCTOR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PACIENT_ID: UpdateData(PRecord.PACIENT_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PATIENTOF_NEOTL: UpdateData(PRecord.PATIENTOF_NEOTL, PropPosition, metaPosition, dataPosition);
            Pregled_PATIENTOF_NEOTLID: UpdateData(PRecord.PATIENTOF_NEOTLID, PropPosition, metaPosition, dataPosition);
            Pregled_PAY: UpdateData(PRecord.PAY, PropPosition, metaPosition, dataPosition);
            Pregled_PREVENTIVE_TYPE: UpdateData(PRecord.PREVENTIVE_TYPE, PropPosition, metaPosition, dataPosition);
            Pregled_PRIMARY_NOTE_ID: UpdateData(PRecord.PRIMARY_NOTE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_ID: UpdateData(PRecord.PROCEDURE1_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_MKB: UpdateData(PRecord.PROCEDURE1_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE1_OPIS: UpdateData(PRecord.PROCEDURE1_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_ID: UpdateData(PRecord.PROCEDURE2_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_MKB: UpdateData(PRecord.PROCEDURE2_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE2_OPIS: UpdateData(PRecord.PROCEDURE2_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_ID: UpdateData(PRecord.PROCEDURE3_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_MKB: UpdateData(PRecord.PROCEDURE3_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE3_OPIS: UpdateData(PRecord.PROCEDURE3_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_ID: UpdateData(PRecord.PROCEDURE4_ID, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_MKB: UpdateData(PRecord.PROCEDURE4_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PROCEDURE4_OPIS: UpdateData(PRecord.PROCEDURE4_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_MKB: UpdateData(PRecord.PR_ZAB1_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_MKB_ADD: UpdateData(PRecord.PR_ZAB1_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB1_OPIS: UpdateData(PRecord.PR_ZAB1_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_MKB: UpdateData(PRecord.PR_ZAB2_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_MKB_ADD: UpdateData(PRecord.PR_ZAB2_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB2_OPIS: UpdateData(PRecord.PR_ZAB2_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_MKB: UpdateData(PRecord.PR_ZAB3_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_MKB_ADD: UpdateData(PRecord.PR_ZAB3_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB3_OPIS: UpdateData(PRecord.PR_ZAB3_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_MKB: UpdateData(PRecord.PR_ZAB4_MKB, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_MKB_ADD: UpdateData(PRecord.PR_ZAB4_MKB_ADD, PropPosition, metaPosition, dataPosition);
            Pregled_PR_ZAB4_OPIS: UpdateData(PRecord.PR_ZAB4_OPIS, PropPosition, metaPosition, dataPosition);
            Pregled_RECKNNO: UpdateData(PRecord.RECKNNO, PropPosition, metaPosition, dataPosition);
            Pregled_REH_FINISHED_AT: UpdateData(PRecord.REH_FINISHED_AT, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC1: UpdateData(PRecord.REH_PROC1, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC2: UpdateData(PRecord.REH_PROC2, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC3: UpdateData(PRecord.REH_PROC3, PropPosition, metaPosition, dataPosition);
            Pregled_REH_PROC4: UpdateData(PRecord.REH_PROC4, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_FORM_DATE: UpdateData(PRecord.SIMP_FORM_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_IS_NAET: UpdateData(PRecord.SIMP_IS_NAET, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_IS_ZAMESTVASHT: UpdateData(PRecord.SIMP_IS_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_ID: UpdateData(PRecord.SIMP_NAPR_ID, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_N: UpdateData(PRecord.SIMP_NAPR_N, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NAPR_NRN: UpdateData(PRecord.SIMP_NAPR_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_NZOKNOMER: UpdateData(PRecord.SIMP_NZOKNOMER, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRAKTIKA: UpdateData(PRecord.SIMP_PRAKTIKA, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_DATE: UpdateData(PRecord.SIMP_PRIMARY_AMBLIST_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_N: UpdateData(PRecord.SIMP_PRIMARY_AMBLIST_N, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_PRIMARY_AMBLIST_NRN: UpdateData(PRecord.SIMP_PRIMARY_AMBLIST_NRN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_SPECIALITY_CODE: UpdateData(PRecord.SIMP_SPECIALITY_CODE, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_UIN: UpdateData(PRecord.SIMP_UIN, PropPosition, metaPosition, dataPosition);
            Pregled_SIMP_UIN_ZAMESTVASHT: UpdateData(PRecord.SIMP_UIN_ZAMESTVASHT, PropPosition, metaPosition, dataPosition);
            Pregled_START_DATE: UpdateData(PRecord.START_DATE, PropPosition, metaPosition, dataPosition);
            Pregled_START_TIME: UpdateData(PRecord.START_TIME, PropPosition, metaPosition, dataPosition);
            Pregled_SYST: UpdateData(PRecord.SYST, PropPosition, metaPosition, dataPosition);
            Pregled_TALON_LKK: UpdateData(PRecord.TALON_LKK, PropPosition, metaPosition, dataPosition);
            Pregled_TERAPY: UpdateData(PRecord.TERAPY, PropPosition, metaPosition, dataPosition);
            Pregled_THREAD_IDS: UpdateData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            Pregled_TO_BE_DISPANSERED: UpdateData(PRecord.TO_BE_DISPANSERED, PropPosition, metaPosition, dataPosition);
            Pregled_VISIT_ID: UpdateData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            Pregled_VISIT_TYPE_ID: UpdateData(PRecord.VISIT_TYPE_ID, PropPosition, metaPosition, dataPosition);
            Pregled_VSD_TYPE: UpdateData(PRecord.VSD_TYPE, PropPosition, metaPosition, dataPosition);
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

{ TPregledColl }

function TPregledColl.AddItem(ver: word): TPregledItem;
begin
  Result := TPregledItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


function TPregledColl.DisplayName(propIndex: Word): string;
begin
  case TPregledItem.TPropertyIndex(propIndex) of
    Pregled_AMB_LISTN: Result := 'AMB_LISTN';
    Pregled_AMB_PR: Result := 'AMB_PR';
    Pregled_ANAMN: Result := 'ANAMN';
    Pregled_COPIED_FROM_NRN: Result := 'COPIED_FROM_NRN';
    Pregled_DOCTOR_ID: Result := 'DOCTOR_ID';
    Pregled_DOM_PR: Result := 'DOM_PR';
    Pregled_EXAM_BOLN_LIST_ID: Result := 'EXAM_BOLN_LIST_ID';
    Pregled_FUND_ID: Result := 'FUND_ID';
    Pregled_GS: Result := 'GS';
    Pregled_ID: Result := 'ID';
    Pregled_INCIDENTALLY: Result := 'INCIDENTALLY';
    Pregled_IS_ANALYSIS: Result := 'IS_ANALYSIS';
    Pregled_IS_BABY_CARE: Result := 'IS_BABY_CARE';
    Pregled_IS_CONSULTATION: Result := 'IS_CONSULTATION';
    Pregled_IS_DISPANSERY: Result := 'IS_DISPANSERY';
    Pregled_IS_EMERGENCY: Result := 'IS_EMERGENCY';
    Pregled_IS_EPIKRIZA: Result := 'IS_EPIKRIZA';
    Pregled_IS_EXPERTIZA: Result := 'IS_EXPERTIZA';
    Pregled_IS_FORM_VALID: Result := 'IS_FORM_VALID';
    Pregled_IS_HOSPITALIZATION: Result := 'IS_HOSPITALIZATION';
    Pregled_IS_MANIPULATION: Result := 'IS_MANIPULATION';
    Pregled_IS_MEDBELEJKA: Result := 'IS_MEDBELEJKA';
    Pregled_IS_NAET: Result := 'IS_NAET';
    Pregled_IS_NAPR_TELK: Result := 'IS_NAPR_TELK';
    Pregled_IS_NEW: Result := 'IS_NEW';
    Pregled_IS_NOTIFICATION: Result := 'IS_NOTIFICATION';
    Pregled_IS_NO_DELAY: Result := 'IS_NO_DELAY';
    Pregled_IS_OPERATION: Result := 'IS_OPERATION';
    Pregled_IS_PODVIZHNO_LZ: Result := 'IS_PODVIZHNO_LZ';
    Pregled_IS_PREVENTIVE: Result := 'IS_PREVENTIVE';
    Pregled_IS_PRINTED: Result := 'IS_PRINTED';
    Pregled_IS_RECEPTA_HOSPIT: Result := 'IS_RECEPTA_HOSPIT';
    Pregled_IS_REGISTRATION: Result := 'IS_REGISTRATION';
    Pregled_IS_REHABILITATION: Result := 'IS_REHABILITATION';
    Pregled_IS_RISK_GROUP: Result := 'IS_RISK_GROUP';
    Pregled_IS_TELK: Result := 'IS_TELK';
    Pregled_IS_VSD: Result := 'IS_VSD';
    Pregled_IS_ZAMESTVASHT: Result := 'IS_ZAMESTVASHT';
    Pregled_IZSL: Result := 'IZSL';
    Pregled_LIFESENSOR_ID: Result := 'LIFESENSOR_ID';
    Pregled_LKK_KOMISII_ID: Result := 'LKK_KOMISII_ID';
    Pregled_MAIN_DIAG_MKB: Result := 'MAIN_DIAG_MKB';
    Pregled_MAIN_DIAG_MKB_ADD: Result := 'MAIN_DIAG_MKB_ADD';
    Pregled_MAIN_DIAG_OPIS: Result := 'MAIN_DIAG_OPIS';
    Pregled_MEDTRANSKM: Result := 'MEDTRANSKM';
    Pregled_NAPRAVLENIE_AMBL_NOMER: Result := 'NAPRAVLENIE_AMBL_NOMER';
    Pregled_NAPR_TYPE_ID: Result := 'NAPR_TYPE_ID';
    Pregled_NOMERBELEGKA: Result := 'NOMERBELEGKA';
    Pregled_NOMERKASHAPARAT: Result := 'NOMERKASHAPARAT';
    Pregled_NRD: Result := 'NRD';
    Pregled_NRN: Result := 'NRN';
    Pregled_NZIS_STATUS: Result := 'NZIS_STATUS';
    Pregled_OBSHTAPR: Result := 'OBSHTAPR';
    Pregled_OWNER_DOCTOR_ID: Result := 'OWNER_DOCTOR_ID';
    Pregled_PACIENT_ID: Result := 'PACIENT_ID';
    Pregled_PATIENTOF_NEOTL: Result := 'PATIENTOF_NEOTL';
    Pregled_PATIENTOF_NEOTLID: Result := 'PATIENTOF_NEOTLID';
    Pregled_PAY: Result := 'PAY';
    Pregled_PREVENTIVE_TYPE: Result := 'PREVENTIVE_TYPE';
    Pregled_PRIMARY_NOTE_ID: Result := 'PRIMARY_NOTE_ID';
    Pregled_PROCEDURE1_ID: Result := 'PROCEDURE1_ID';
    Pregled_PROCEDURE1_MKB: Result := 'PROCEDURE1_MKB';
    Pregled_PROCEDURE1_OPIS: Result := 'PROCEDURE1_OPIS';
    Pregled_PROCEDURE2_ID: Result := 'PROCEDURE2_ID';
    Pregled_PROCEDURE2_MKB: Result := 'PROCEDURE2_MKB';
    Pregled_PROCEDURE2_OPIS: Result := 'PROCEDURE2_OPIS';
    Pregled_PROCEDURE3_ID: Result := 'PROCEDURE3_ID';
    Pregled_PROCEDURE3_MKB: Result := 'PROCEDURE3_MKB';
    Pregled_PROCEDURE3_OPIS: Result := 'PROCEDURE3_OPIS';
    Pregled_PROCEDURE4_ID: Result := 'PROCEDURE4_ID';
    Pregled_PROCEDURE4_MKB: Result := 'PROCEDURE4_MKB';
    Pregled_PROCEDURE4_OPIS: Result := 'PROCEDURE4_OPIS';
    Pregled_PR_ZAB1_MKB: Result := 'PR_ZAB1_MKB';
    Pregled_PR_ZAB1_MKB_ADD: Result := 'PR_ZAB1_MKB_ADD';
    Pregled_PR_ZAB1_OPIS: Result := 'PR_ZAB1_OPIS';
    Pregled_PR_ZAB2_MKB: Result := 'PR_ZAB2_MKB';
    Pregled_PR_ZAB2_MKB_ADD: Result := 'PR_ZAB2_MKB_ADD';
    Pregled_PR_ZAB2_OPIS: Result := 'PR_ZAB2_OPIS';
    Pregled_PR_ZAB3_MKB: Result := 'PR_ZAB3_MKB';
    Pregled_PR_ZAB3_MKB_ADD: Result := 'PR_ZAB3_MKB_ADD';
    Pregled_PR_ZAB3_OPIS: Result := 'PR_ZAB3_OPIS';
    Pregled_PR_ZAB4_MKB: Result := 'PR_ZAB4_MKB';
    Pregled_PR_ZAB4_MKB_ADD: Result := 'PR_ZAB4_MKB_ADD';
    Pregled_PR_ZAB4_OPIS: Result := 'PR_ZAB4_OPIS';
    Pregled_RECKNNO: Result := 'RECKNNO';
    Pregled_REH_FINISHED_AT: Result := 'REH_FINISHED_AT';
    Pregled_REH_PROC1: Result := 'REH_PROC1';
    Pregled_REH_PROC2: Result := 'REH_PROC2';
    Pregled_REH_PROC3: Result := 'REH_PROC3';
    Pregled_REH_PROC4: Result := 'REH_PROC4';
    Pregled_SIMP_FORM_DATE: Result := 'SIMP_FORM_DATE';
    Pregled_SIMP_IS_NAET: Result := 'SIMP_IS_NAET';
    Pregled_SIMP_IS_ZAMESTVASHT: Result := 'SIMP_IS_ZAMESTVASHT';
    Pregled_SIMP_NAPR_ID: Result := 'SIMP_NAPR_ID';
    Pregled_SIMP_NAPR_N: Result := 'SIMP_NAPR_N';
    Pregled_SIMP_NAPR_NRN: Result := 'SIMP_NAPR_NRN';
    Pregled_SIMP_NZOKNOMER: Result := 'SIMP_NZOKNOMER';
    Pregled_SIMP_PRAKTIKA: Result := 'SIMP_PRAKTIKA';
    Pregled_SIMP_PRIMARY_AMBLIST_DATE: Result := 'SIMP_PRIMARY_AMBLIST_DATE';
    Pregled_SIMP_PRIMARY_AMBLIST_N: Result := 'SIMP_PRIMARY_AMBLIST_N';
    Pregled_SIMP_PRIMARY_AMBLIST_NRN: Result := 'SIMP_PRIMARY_AMBLIST_NRN';
    Pregled_SIMP_SPECIALITY_CODE: Result := 'SIMP_SPECIALITY_CODE';
    Pregled_SIMP_UIN: Result := 'SIMP_UIN';
    Pregled_SIMP_UIN_ZAMESTVASHT: Result := 'SIMP_UIN_ZAMESTVASHT';
    Pregled_START_DATE: Result := 'START_DATE';
    Pregled_START_TIME: Result := 'START_TIME';
    Pregled_SYST: Result := 'SYST';
    Pregled_TALON_LKK: Result := 'TALON_LKK';
    Pregled_TERAPY: Result := 'TERAPY';
    Pregled_THREAD_IDS: Result := 'THREAD_IDS';
    Pregled_TO_BE_DISPANSERED: Result := 'TO_BE_DISPANSERED';
    Pregled_VISIT_ID: Result := 'VISIT_ID';
    Pregled_VISIT_TYPE_ID: Result := 'VISIT_TYPE_ID';
    Pregled_VSD_TYPE: Result := 'VSD_TYPE';
  end;
end;

procedure TPregledColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Pregled: TPregledItem;
  ACol: Integer;
  prop: TPregledItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Pregled := Items[ARow];
  prop := TPregledItem.TPropertyIndex(ACol);
  if Assigned(Pregled.PRecord) and (prop in Pregled.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Pregled, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Pregled, AValue);
  end;
end;

procedure TPregledColl.GetCellFromRecord(propIndex: word; Pregled: TPregledItem; var AValue: String);
var
  str: string;
begin
  case TPregledItem.TPropertyIndex(propIndex) of
    Pregled_AMB_LISTN: str := inttostr(Pregled.PRecord.AMB_LISTN);
    Pregled_AMB_PR: str := inttostr(Pregled.PRecord.AMB_PR);
    Pregled_ANAMN: str := (Pregled.PRecord.ANAMN);
    Pregled_COPIED_FROM_NRN: str := (Pregled.PRecord.COPIED_FROM_NRN);
    Pregled_DOCTOR_ID: str := inttostr(Pregled.PRecord.DOCTOR_ID);
    Pregled_DOM_PR: str := inttostr(Pregled.PRecord.DOM_PR);
    Pregled_EXAM_BOLN_LIST_ID: str := inttostr(Pregled.PRecord.EXAM_BOLN_LIST_ID);
    Pregled_FUND_ID: str := inttostr(Pregled.PRecord.FUND_ID);
    Pregled_GS: str := inttostr(Pregled.PRecord.GS);
    Pregled_ID: str := inttostr(Pregled.PRecord.ID);
    Pregled_INCIDENTALLY: str := BoolToStr(Pregled.PRecord.INCIDENTALLY, True);
    Pregled_IS_ANALYSIS: str := BoolToStr(Pregled.PRecord.IS_ANALYSIS, True);
    Pregled_IS_BABY_CARE: str := BoolToStr(Pregled.PRecord.IS_BABY_CARE, True);
    Pregled_IS_CONSULTATION: str := BoolToStr(Pregled.PRecord.IS_CONSULTATION, True);
    Pregled_IS_DISPANSERY: str := BoolToStr(Pregled.PRecord.IS_DISPANSERY, True);
    Pregled_IS_EMERGENCY: str := BoolToStr(Pregled.PRecord.IS_EMERGENCY, True);
    Pregled_IS_EPIKRIZA: str := BoolToStr(Pregled.PRecord.IS_EPIKRIZA, True);
    Pregled_IS_EXPERTIZA: str := BoolToStr(Pregled.PRecord.IS_EXPERTIZA, True);
    Pregled_IS_FORM_VALID: str := BoolToStr(Pregled.PRecord.IS_FORM_VALID, True);
    Pregled_IS_HOSPITALIZATION: str := BoolToStr(Pregled.PRecord.IS_HOSPITALIZATION, True);
    Pregled_IS_MANIPULATION: str := BoolToStr(Pregled.PRecord.IS_MANIPULATION, True);
    Pregled_IS_MEDBELEJKA: str := BoolToStr(Pregled.PRecord.IS_MEDBELEJKA, True);
    Pregled_IS_NAET: str := BoolToStr(Pregled.PRecord.IS_NAET, True);
    Pregled_IS_NAPR_TELK: str := BoolToStr(Pregled.PRecord.IS_NAPR_TELK, True);
    Pregled_IS_NEW: str := BoolToStr(Pregled.PRecord.IS_NEW, True);
    Pregled_IS_NOTIFICATION: str := BoolToStr(Pregled.PRecord.IS_NOTIFICATION, True);
    Pregled_IS_NO_DELAY: str := BoolToStr(Pregled.PRecord.IS_NO_DELAY, True);
    Pregled_IS_OPERATION: str := BoolToStr(Pregled.PRecord.IS_OPERATION, True);
    Pregled_IS_PODVIZHNO_LZ: str := BoolToStr(Pregled.PRecord.IS_PODVIZHNO_LZ, True);
    Pregled_IS_PREVENTIVE: str := BoolToStr(Pregled.PRecord.IS_PREVENTIVE, True);
    Pregled_IS_PRINTED: str := (Pregled.PRecord.IS_PRINTED);
    Pregled_IS_RECEPTA_HOSPIT: str := BoolToStr(Pregled.PRecord.IS_RECEPTA_HOSPIT, True);
    Pregled_IS_REGISTRATION: str := BoolToStr(Pregled.PRecord.IS_REGISTRATION, True);
    Pregled_IS_REHABILITATION: str := BoolToStr(Pregled.PRecord.IS_REHABILITATION, True);
    Pregled_IS_RISK_GROUP: str := BoolToStr(Pregled.PRecord.IS_RISK_GROUP, True);
    Pregled_IS_TELK: str := BoolToStr(Pregled.PRecord.IS_TELK, True);
    Pregled_IS_VSD: str := BoolToStr(Pregled.PRecord.IS_VSD, True);
    Pregled_IS_ZAMESTVASHT: str := BoolToStr(Pregled.PRecord.IS_ZAMESTVASHT, True);
    Pregled_IZSL: str := (Pregled.PRecord.IZSL);
    Pregled_LIFESENSOR_ID: str := (Pregled.PRecord.LIFESENSOR_ID);
    Pregled_LKK_KOMISII_ID: str := inttostr(Pregled.PRecord.LKK_KOMISII_ID);
    Pregled_MAIN_DIAG_MKB: str := (Pregled.PRecord.MAIN_DIAG_MKB);
    Pregled_MAIN_DIAG_MKB_ADD: str := (Pregled.PRecord.MAIN_DIAG_MKB_ADD);
    Pregled_MAIN_DIAG_OPIS: str := (Pregled.PRecord.MAIN_DIAG_OPIS);
    Pregled_MEDTRANSKM: str := inttostr(Pregled.PRecord.MEDTRANSKM);
    Pregled_NAPRAVLENIE_AMBL_NOMER: str := (Pregled.PRecord.NAPRAVLENIE_AMBL_NOMER);
    Pregled_NAPR_TYPE_ID: str := inttostr(Pregled.PRecord.NAPR_TYPE_ID);
    Pregled_NOMERBELEGKA: str := (Pregled.PRecord.NOMERBELEGKA);
    Pregled_NOMERKASHAPARAT: str := (Pregled.PRecord.NOMERKASHAPARAT);
    Pregled_NRD: str := inttostr(Pregled.PRecord.NRD);
    Pregled_NRN: str := (Pregled.PRecord.NRN);
    Pregled_NZIS_STATUS: str := inttostr(Pregled.PRecord.NZIS_STATUS);
    Pregled_OBSHTAPR: str := inttostr(Pregled.PRecord.OBSHTAPR);
    Pregled_OWNER_DOCTOR_ID: str := inttostr(Pregled.PRecord.OWNER_DOCTOR_ID);
    Pregled_PACIENT_ID: str := inttostr(Pregled.PRecord.PACIENT_ID);
    Pregled_PATIENTOF_NEOTL: str := (Pregled.PRecord.PATIENTOF_NEOTL);
    Pregled_PATIENTOF_NEOTLID: str := inttostr(Pregled.PRecord.PATIENTOF_NEOTLID);
    Pregled_PAY: str := BoolToStr(Pregled.PRecord.PAY, True);
    Pregled_PREVENTIVE_TYPE: str := inttostr(Pregled.PRecord.PREVENTIVE_TYPE);
    Pregled_PRIMARY_NOTE_ID: str := inttostr(Pregled.PRecord.PRIMARY_NOTE_ID);
    Pregled_PROCEDURE1_ID: str := inttostr(Pregled.PRecord.PROCEDURE1_ID);
    Pregled_PROCEDURE1_MKB: str := (Pregled.PRecord.PROCEDURE1_MKB);
    Pregled_PROCEDURE1_OPIS: str := (Pregled.PRecord.PROCEDURE1_OPIS);
    Pregled_PROCEDURE2_ID: str := inttostr(Pregled.PRecord.PROCEDURE2_ID);
    Pregled_PROCEDURE2_MKB: str := (Pregled.PRecord.PROCEDURE2_MKB);
    Pregled_PROCEDURE2_OPIS: str := (Pregled.PRecord.PROCEDURE2_OPIS);
    Pregled_PROCEDURE3_ID: str := inttostr(Pregled.PRecord.PROCEDURE3_ID);
    Pregled_PROCEDURE3_MKB: str := (Pregled.PRecord.PROCEDURE3_MKB);
    Pregled_PROCEDURE3_OPIS: str := (Pregled.PRecord.PROCEDURE3_OPIS);
    Pregled_PROCEDURE4_ID: str := inttostr(Pregled.PRecord.PROCEDURE4_ID);
    Pregled_PROCEDURE4_MKB: str := (Pregled.PRecord.PROCEDURE4_MKB);
    Pregled_PROCEDURE4_OPIS: str := (Pregled.PRecord.PROCEDURE4_OPIS);
    Pregled_PR_ZAB1_MKB: str := (Pregled.PRecord.PR_ZAB1_MKB);
    Pregled_PR_ZAB1_MKB_ADD: str := (Pregled.PRecord.PR_ZAB1_MKB_ADD);
    Pregled_PR_ZAB1_OPIS: str := (Pregled.PRecord.PR_ZAB1_OPIS);
    Pregled_PR_ZAB2_MKB: str := (Pregled.PRecord.PR_ZAB2_MKB);
    Pregled_PR_ZAB2_MKB_ADD: str := (Pregled.PRecord.PR_ZAB2_MKB_ADD);
    Pregled_PR_ZAB2_OPIS: str := (Pregled.PRecord.PR_ZAB2_OPIS);
    Pregled_PR_ZAB3_MKB: str := (Pregled.PRecord.PR_ZAB3_MKB);
    Pregled_PR_ZAB3_MKB_ADD: str := (Pregled.PRecord.PR_ZAB3_MKB_ADD);
    Pregled_PR_ZAB3_OPIS: str := (Pregled.PRecord.PR_ZAB3_OPIS);
    Pregled_PR_ZAB4_MKB: str := (Pregled.PRecord.PR_ZAB4_MKB);
    Pregled_PR_ZAB4_MKB_ADD: str := (Pregled.PRecord.PR_ZAB4_MKB_ADD);
    Pregled_PR_ZAB4_OPIS: str := (Pregled.PRecord.PR_ZAB4_OPIS);
    Pregled_RECKNNO: str := (Pregled.PRecord.RECKNNO);
    Pregled_REH_FINISHED_AT: str := DateToStr(Pregled.PRecord.REH_FINISHED_AT);
    Pregled_REH_PROC1: str := inttostr(Pregled.PRecord.REH_PROC1);
    Pregled_REH_PROC2: str := inttostr(Pregled.PRecord.REH_PROC2);
    Pregled_REH_PROC3: str := inttostr(Pregled.PRecord.REH_PROC3);
    Pregled_REH_PROC4: str := inttostr(Pregled.PRecord.REH_PROC4);
    Pregled_SIMP_FORM_DATE: str := DateToStr(Pregled.PRecord.SIMP_FORM_DATE);
    Pregled_SIMP_IS_NAET: str := BoolToStr(Pregled.PRecord.SIMP_IS_NAET, True);
    Pregled_SIMP_IS_ZAMESTVASHT: str := BoolToStr(Pregled.PRecord.SIMP_IS_ZAMESTVASHT, True);
    Pregled_SIMP_NAPR_ID: str := inttostr(Pregled.PRecord.SIMP_NAPR_ID);
    Pregled_SIMP_NAPR_N: str := inttostr(Pregled.PRecord.SIMP_NAPR_N);
    Pregled_SIMP_NAPR_NRN: str := (Pregled.PRecord.SIMP_NAPR_NRN);
    Pregled_SIMP_NZOKNOMER: str := (Pregled.PRecord.SIMP_NZOKNOMER);
    Pregled_SIMP_PRAKTIKA: str := (Pregled.PRecord.SIMP_PRAKTIKA);
    Pregled_SIMP_PRIMARY_AMBLIST_DATE: str := DateToStr(Pregled.PRecord.SIMP_PRIMARY_AMBLIST_DATE);
    Pregled_SIMP_PRIMARY_AMBLIST_N: str := inttostr(Pregled.PRecord.SIMP_PRIMARY_AMBLIST_N);
    Pregled_SIMP_PRIMARY_AMBLIST_NRN: str := (Pregled.PRecord.SIMP_PRIMARY_AMBLIST_NRN);
    Pregled_SIMP_SPECIALITY_CODE: str := (Pregled.PRecord.SIMP_SPECIALITY_CODE);
    Pregled_SIMP_UIN: str := (Pregled.PRecord.SIMP_UIN);
    Pregled_SIMP_UIN_ZAMESTVASHT: str := (Pregled.PRecord.SIMP_UIN_ZAMESTVASHT);
    Pregled_START_DATE: str := DateToStr(Pregled.PRecord.START_DATE);
    Pregled_START_TIME: str := TimeToStr(Pregled.PRecord.START_TIME);
    Pregled_SYST: str := (Pregled.PRecord.SYST);
    Pregled_TALON_LKK: str := (Pregled.PRecord.TALON_LKK);
    Pregled_TERAPY: str := (Pregled.PRecord.TERAPY);
    Pregled_THREAD_IDS: str := (Pregled.PRecord.THREAD_IDS);
    Pregled_TO_BE_DISPANSERED: str := BoolToStr(Pregled.PRecord.TO_BE_DISPANSERED, True);
    Pregled_VISIT_ID: str := inttostr(Pregled.PRecord.VISIT_ID);
    Pregled_VISIT_TYPE_ID: str := inttostr(Pregled.PRecord.VISIT_TYPE_ID);
    Pregled_VSD_TYPE: str := inttostr(Pregled.PRecord.VSD_TYPE);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPregledColl.GetCellFromMap(propIndex: word; ARow: Integer; Pregled: TPregledItem; var AValue: String);
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
  case TPregledItem.TPropertyIndex(propIndex) of
    Pregled_AMB_LISTN: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_AMB_PR: str := inttostr(Pregled.getWordMap(Self.Buf, Self.posData, propIndex));
    Pregled_ANAMN: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_COPIED_FROM_NRN: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_DOCTOR_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_EXAM_BOLN_LIST_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_FUND_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_INCIDENTALLY: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_ANALYSIS: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_BABY_CARE: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_CONSULTATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_DISPANSERY: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_EMERGENCY: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_EPIKRIZA: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_EXPERTIZA: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_FORM_VALID: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_HOSPITALIZATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_MANIPULATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_MEDBELEJKA: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_NAET: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_NAPR_TELK: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_NEW: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_NOTIFICATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_NO_DELAY: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_OPERATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_PODVIZHNO_LZ: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_PREVENTIVE: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_PRINTED: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_IS_RECEPTA_HOSPIT: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_REGISTRATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_REHABILITATION: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_RISK_GROUP: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_TELK: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_VSD: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IS_ZAMESTVASHT: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_IZSL: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_LIFESENSOR_ID: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_LKK_KOMISII_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_MAIN_DIAG_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_MAIN_DIAG_MKB_ADD: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_MAIN_DIAG_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_MEDTRANSKM: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_NAPRAVLENIE_AMBL_NOMER: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_NOMERBELEGKA: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_NOMERKASHAPARAT: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_NRN: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_OWNER_DOCTOR_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PACIENT_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PATIENTOF_NEOTL: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PATIENTOF_NEOTLID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PAY: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_PRIMARY_NOTE_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PROCEDURE1_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PROCEDURE1_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE1_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE2_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PROCEDURE2_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE2_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE3_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PROCEDURE3_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE3_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE4_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_PROCEDURE4_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PROCEDURE4_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB1_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB1_MKB_ADD: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB1_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB2_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB2_MKB_ADD: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB2_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB3_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB3_MKB_ADD: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB3_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB4_MKB: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB4_MKB_ADD: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_PR_ZAB4_OPIS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_RECKNNO: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_REH_FINISHED_AT: str :=  DateToStr(Pregled.getDateMap(Self.Buf, Self.posData, propIndex));
    Pregled_REH_PROC1: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_REH_PROC2: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_REH_PROC3: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_REH_PROC4: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_SIMP_FORM_DATE: str :=  DateToStr(Pregled.getDateMap(Self.Buf, Self.posData, propIndex));
    Pregled_SIMP_IS_NAET: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_SIMP_IS_ZAMESTVASHT: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_SIMP_NAPR_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_SIMP_NAPR_N: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_SIMP_NAPR_NRN: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_SIMP_NZOKNOMER: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_SIMP_PRAKTIKA: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_SIMP_PRIMARY_AMBLIST_DATE: str :=  DateToStr(Pregled.getDateMap(Self.Buf, Self.posData, propIndex));
    Pregled_SIMP_PRIMARY_AMBLIST_N: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
    Pregled_SIMP_PRIMARY_AMBLIST_NRN: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_SIMP_SPECIALITY_CODE: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_SIMP_UIN: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_SIMP_UIN_ZAMESTVASHT: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_START_DATE: str :=  DateToStr(Pregled.getDateMap(Self.Buf, Self.posData, propIndex));
    Pregled_START_TIME: str :=  TimeToStr(Pregled.getTimeMap(Self.Buf, Self.posData, propIndex));
    Pregled_SYST: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_TALON_LKK: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_TERAPY: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_THREAD_IDS: str :=  Pregled.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Pregled_TO_BE_DISPANSERED: str :=  BoolToStr(Pregled.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Pregled_VISIT_ID: str :=  inttostr(Pregled.getIntMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow);
    end;
  end;
  AValue := str;
end;

function TPregledColl.GetItem(Index: Integer): TPregledItem;
begin
  Result := TPregledItem(inherited GetItem(Index));
end;


procedure TPregledColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Pregled: TPregledItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := AColumn.Index;

  Pregled := Items[ARow];
  if not Assigned(Pregled.PRecord) then
  begin
    New(Pregled.PRecord);
    Pregled.PRecord.setProp := [];
  end;
  Include(Pregled.PRecord.setProp, TPregledItem.TPropertyIndex(ACol));
  case TPregledItem.TPropertyIndex(ACol) of
    Pregled_AMB_LISTN: Pregled.PRecord.AMB_LISTN := StrToInt(AValue);
    Pregled_AMB_PR: Pregled.PRecord.AMB_PR := StrToInt(AValue);
    Pregled_ANAMN: Pregled.PRecord.ANAMN := AValue;
    Pregled_COPIED_FROM_NRN: Pregled.PRecord.COPIED_FROM_NRN := AValue;
    Pregled_DOCTOR_ID: Pregled.PRecord.DOCTOR_ID := StrToInt(AValue);
    Pregled_DOM_PR: Pregled.PRecord.DOM_PR := StrToInt(AValue);
    Pregled_EXAM_BOLN_LIST_ID: Pregled.PRecord.EXAM_BOLN_LIST_ID := StrToInt(AValue);
    Pregled_FUND_ID: Pregled.PRecord.FUND_ID := StrToInt(AValue);
    Pregled_GS: Pregled.PRecord.GS := StrToInt(AValue);
    Pregled_ID: Pregled.PRecord.ID := StrToInt(AValue);
    Pregled_INCIDENTALLY: Pregled.PRecord.INCIDENTALLY := StrToBool(AValue);
    Pregled_IS_ANALYSIS: Pregled.PRecord.IS_ANALYSIS := StrToBool(AValue);
    Pregled_IS_BABY_CARE: Pregled.PRecord.IS_BABY_CARE := StrToBool(AValue);
    Pregled_IS_CONSULTATION: Pregled.PRecord.IS_CONSULTATION := StrToBool(AValue);
    Pregled_IS_DISPANSERY: Pregled.PRecord.IS_DISPANSERY := StrToBool(AValue);
    Pregled_IS_EMERGENCY: Pregled.PRecord.IS_EMERGENCY := StrToBool(AValue);
    Pregled_IS_EPIKRIZA: Pregled.PRecord.IS_EPIKRIZA := StrToBool(AValue);
    Pregled_IS_EXPERTIZA: Pregled.PRecord.IS_EXPERTIZA := StrToBool(AValue);
    Pregled_IS_FORM_VALID: Pregled.PRecord.IS_FORM_VALID := StrToBool(AValue);
    Pregled_IS_HOSPITALIZATION: Pregled.PRecord.IS_HOSPITALIZATION := StrToBool(AValue);
    Pregled_IS_MANIPULATION: Pregled.PRecord.IS_MANIPULATION := StrToBool(AValue);
    Pregled_IS_MEDBELEJKA: Pregled.PRecord.IS_MEDBELEJKA := StrToBool(AValue);
    Pregled_IS_NAET: Pregled.PRecord.IS_NAET := StrToBool(AValue);
    Pregled_IS_NAPR_TELK: Pregled.PRecord.IS_NAPR_TELK := StrToBool(AValue);
    Pregled_IS_NEW: Pregled.PRecord.IS_NEW := StrToBool(AValue);
    Pregled_IS_NOTIFICATION: Pregled.PRecord.IS_NOTIFICATION := StrToBool(AValue);
    Pregled_IS_NO_DELAY: Pregled.PRecord.IS_NO_DELAY := StrToBool(AValue);
    Pregled_IS_OPERATION: Pregled.PRecord.IS_OPERATION := StrToBool(AValue);
    Pregled_IS_PODVIZHNO_LZ: Pregled.PRecord.IS_PODVIZHNO_LZ := StrToBool(AValue);
    Pregled_IS_PREVENTIVE: Pregled.PRecord.IS_PREVENTIVE := StrToBool(AValue);
    Pregled_IS_PRINTED: Pregled.PRecord.IS_PRINTED := AValue;
    Pregled_IS_RECEPTA_HOSPIT: Pregled.PRecord.IS_RECEPTA_HOSPIT := StrToBool(AValue);
    Pregled_IS_REGISTRATION: Pregled.PRecord.IS_REGISTRATION := StrToBool(AValue);
    Pregled_IS_REHABILITATION: Pregled.PRecord.IS_REHABILITATION := StrToBool(AValue);
    Pregled_IS_RISK_GROUP: Pregled.PRecord.IS_RISK_GROUP := StrToBool(AValue);
    Pregled_IS_TELK: Pregled.PRecord.IS_TELK := StrToBool(AValue);
    Pregled_IS_VSD: Pregled.PRecord.IS_VSD := StrToBool(AValue);
    Pregled_IS_ZAMESTVASHT: Pregled.PRecord.IS_ZAMESTVASHT := StrToBool(AValue);
    Pregled_IZSL: Pregled.PRecord.IZSL := AValue;
    Pregled_LIFESENSOR_ID: Pregled.PRecord.LIFESENSOR_ID := AValue;
    Pregled_LKK_KOMISII_ID: Pregled.PRecord.LKK_KOMISII_ID := StrToInt(AValue);
    Pregled_MAIN_DIAG_MKB: Pregled.PRecord.MAIN_DIAG_MKB := AValue;
    Pregled_MAIN_DIAG_MKB_ADD: Pregled.PRecord.MAIN_DIAG_MKB_ADD := AValue;
    Pregled_MAIN_DIAG_OPIS: Pregled.PRecord.MAIN_DIAG_OPIS := AValue;
    Pregled_MEDTRANSKM: Pregled.PRecord.MEDTRANSKM := StrToInt(AValue);
    Pregled_NAPRAVLENIE_AMBL_NOMER: Pregled.PRecord.NAPRAVLENIE_AMBL_NOMER := AValue;
    Pregled_NAPR_TYPE_ID: Pregled.PRecord.NAPR_TYPE_ID := StrToInt(AValue);
    Pregled_NOMERBELEGKA: Pregled.PRecord.NOMERBELEGKA := AValue;
    Pregled_NOMERKASHAPARAT: Pregled.PRecord.NOMERKASHAPARAT := AValue;
    Pregled_NRD: Pregled.PRecord.NRD := StrToInt(AValue);
    Pregled_NRN: Pregled.PRecord.NRN := AValue;
    Pregled_NZIS_STATUS: Pregled.PRecord.NZIS_STATUS := StrToInt(AValue);
    Pregled_OBSHTAPR: Pregled.PRecord.OBSHTAPR := StrToInt(AValue);
    Pregled_OWNER_DOCTOR_ID: Pregled.PRecord.OWNER_DOCTOR_ID := StrToInt(AValue);
    Pregled_PACIENT_ID: Pregled.PRecord.PACIENT_ID := StrToInt(AValue);
    Pregled_PATIENTOF_NEOTL: Pregled.PRecord.PATIENTOF_NEOTL := AValue;
    Pregled_PATIENTOF_NEOTLID: Pregled.PRecord.PATIENTOF_NEOTLID := StrToInt(AValue);
    Pregled_PAY: Pregled.PRecord.PAY := StrToBool(AValue);
    Pregled_PREVENTIVE_TYPE: Pregled.PRecord.PREVENTIVE_TYPE := StrToInt(AValue);
    Pregled_PRIMARY_NOTE_ID: Pregled.PRecord.PRIMARY_NOTE_ID := StrToInt(AValue);
    Pregled_PROCEDURE1_ID: Pregled.PRecord.PROCEDURE1_ID := StrToInt(AValue);
    Pregled_PROCEDURE1_MKB: Pregled.PRecord.PROCEDURE1_MKB := AValue;
    Pregled_PROCEDURE1_OPIS: Pregled.PRecord.PROCEDURE1_OPIS := AValue;
    Pregled_PROCEDURE2_ID: Pregled.PRecord.PROCEDURE2_ID := StrToInt(AValue);
    Pregled_PROCEDURE2_MKB: Pregled.PRecord.PROCEDURE2_MKB := AValue;
    Pregled_PROCEDURE2_OPIS: Pregled.PRecord.PROCEDURE2_OPIS := AValue;
    Pregled_PROCEDURE3_ID: Pregled.PRecord.PROCEDURE3_ID := StrToInt(AValue);
    Pregled_PROCEDURE3_MKB: Pregled.PRecord.PROCEDURE3_MKB := AValue;
    Pregled_PROCEDURE3_OPIS: Pregled.PRecord.PROCEDURE3_OPIS := AValue;
    Pregled_PROCEDURE4_ID: Pregled.PRecord.PROCEDURE4_ID := StrToInt(AValue);
    Pregled_PROCEDURE4_MKB: Pregled.PRecord.PROCEDURE4_MKB := AValue;
    Pregled_PROCEDURE4_OPIS: Pregled.PRecord.PROCEDURE4_OPIS := AValue;
    Pregled_PR_ZAB1_MKB: Pregled.PRecord.PR_ZAB1_MKB := AValue;
    Pregled_PR_ZAB1_MKB_ADD: Pregled.PRecord.PR_ZAB1_MKB_ADD := AValue;
    Pregled_PR_ZAB1_OPIS: Pregled.PRecord.PR_ZAB1_OPIS := AValue;
    Pregled_PR_ZAB2_MKB: Pregled.PRecord.PR_ZAB2_MKB := AValue;
    Pregled_PR_ZAB2_MKB_ADD: Pregled.PRecord.PR_ZAB2_MKB_ADD := AValue;
    Pregled_PR_ZAB2_OPIS: Pregled.PRecord.PR_ZAB2_OPIS := AValue;
    Pregled_PR_ZAB3_MKB: Pregled.PRecord.PR_ZAB3_MKB := AValue;
    Pregled_PR_ZAB3_MKB_ADD: Pregled.PRecord.PR_ZAB3_MKB_ADD := AValue;
    Pregled_PR_ZAB3_OPIS: Pregled.PRecord.PR_ZAB3_OPIS := AValue;
    Pregled_PR_ZAB4_MKB: Pregled.PRecord.PR_ZAB4_MKB := AValue;
    Pregled_PR_ZAB4_MKB_ADD: Pregled.PRecord.PR_ZAB4_MKB_ADD := AValue;
    Pregled_PR_ZAB4_OPIS: Pregled.PRecord.PR_ZAB4_OPIS := AValue;
    Pregled_RECKNNO: Pregled.PRecord.RECKNNO := AValue;
    Pregled_REH_FINISHED_AT: Pregled.PRecord.REH_FINISHED_AT := StrToDate(AValue);
    Pregled_REH_PROC1: Pregled.PRecord.REH_PROC1 := StrToInt(AValue);
    Pregled_REH_PROC2: Pregled.PRecord.REH_PROC2 := StrToInt(AValue);
    Pregled_REH_PROC3: Pregled.PRecord.REH_PROC3 := StrToInt(AValue);
    Pregled_REH_PROC4: Pregled.PRecord.REH_PROC4 := StrToInt(AValue);
    Pregled_SIMP_FORM_DATE: Pregled.PRecord.SIMP_FORM_DATE := StrToInt(AValue);
    Pregled_SIMP_IS_NAET: Pregled.PRecord.SIMP_IS_NAET := StrToBool(AValue);
    Pregled_SIMP_IS_ZAMESTVASHT: Pregled.PRecord.SIMP_IS_ZAMESTVASHT := StrToBool(AValue);
    Pregled_SIMP_NAPR_ID: Pregled.PRecord.SIMP_NAPR_ID := StrToInt(AValue);
    Pregled_SIMP_NAPR_N: Pregled.PRecord.SIMP_NAPR_N := StrToInt(AValue);
    Pregled_SIMP_NAPR_NRN: Pregled.PRecord.SIMP_NAPR_NRN := AValue;
    Pregled_SIMP_NZOKNOMER: Pregled.PRecord.SIMP_NZOKNOMER := AValue;
    Pregled_SIMP_PRAKTIKA: Pregled.PRecord.SIMP_PRAKTIKA := AValue;
    Pregled_SIMP_PRIMARY_AMBLIST_DATE: Pregled.PRecord.SIMP_PRIMARY_AMBLIST_DATE := StrToDate(AValue);
    Pregled_SIMP_PRIMARY_AMBLIST_N: Pregled.PRecord.SIMP_PRIMARY_AMBLIST_N := StrToInt(AValue);
    Pregled_SIMP_PRIMARY_AMBLIST_NRN: Pregled.PRecord.SIMP_PRIMARY_AMBLIST_NRN := AValue;
    Pregled_SIMP_SPECIALITY_CODE: Pregled.PRecord.SIMP_SPECIALITY_CODE := AValue;
    Pregled_SIMP_UIN: Pregled.PRecord.SIMP_UIN := AValue;
    Pregled_SIMP_UIN_ZAMESTVASHT: Pregled.PRecord.SIMP_UIN_ZAMESTVASHT := AValue;
    Pregled_START_DATE: Pregled.PRecord.START_DATE := StrToDate(AValue);
    Pregled_START_TIME: Pregled.PRecord.START_TIME := StrToTime(AValue);
    Pregled_SYST: Pregled.PRecord.SYST := AValue;
    Pregled_TALON_LKK: Pregled.PRecord.TALON_LKK := AValue;
    Pregled_TERAPY: Pregled.PRecord.TERAPY := AValue;
    Pregled_THREAD_IDS: Pregled.PRecord.THREAD_IDS := AValue;
    Pregled_TO_BE_DISPANSERED: Pregled.PRecord.TO_BE_DISPANSERED := StrToBool(AValue);
    Pregled_VISIT_ID: Pregled.PRecord.VISIT_ID := StrToInt(AValue);
    Pregled_VISIT_TYPE_ID: Pregled.PRecord.VISIT_TYPE_ID := StrToInt(AValue);
    Pregled_VSD_TYPE: Pregled.PRecord.VSD_TYPE := StrToInt(AValue);
  end;
end;

procedure TPregledColl.SetItem(Index: Integer; const Value: TPregledItem);
begin
  inherited SetItem(Index, Value);
end;


end.