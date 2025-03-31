unit RealObj.RealHipp; //LIFESENSOR_ID


interface

uses
  ExpanderDyn,
  system.DateUtils,
  Table.PregledNew, Table.PatientNew, Table.diagnosis, Table.MDN,
  Table.PatientNZOK, Table.doctor, Table.Unfav, table.EventsManyTimes,
  Table.Exam_boln_list, Table.ExamAnalysis, table.ExamImmunization, Table.CL142,
  Table.Procedures, Table.DiagnosticReport, RealObj.NzisNomen,
  Aspects.Collections, Aspects.Types, ProfGraph, VirtualTrees,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings, Vcl.Graphics,
  classes, system.SysUtils, windows, System.Generics.Collections, system.Math,
  fmx.EditDyn, SBX509;

type

TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  TRealPregledNewItem = class;
  TRealDiagnosisItem = class;
  TRealUnfavItem = class;
  TRealDiagnosisColl= class;
  TRealEventsManyTimesItem = class;
  TRealEventsManyTimesColl = class;
  TRealDoctorItem = class;
  TRealDoctorColl = class;
  TRealExamAnalysisColl = class;
  TRealExamAnalysisItem = class;
  TRealDiagnosticReportColl = class;

  TRealMDNItem = class(TMDNItem)
  private
    FPregledID: Integer;
    FMainMkb: string;
    FAddMkb: string;
    FMdnID: Integer;
    procedure SetAddMkb(const Value: string);
    procedure SetMainMkb(const Value: string);

  public
    FDiagnosis: TList<TRealDiagnosisItem>;
    FExamAnals: TList<TRealExamAnalysisItem>;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    property PregledID: Integer read FPregledID write FPregledID;
    property MainMkb: string read FMainMkb write SetMainMkb;
    property AddMkb: string read FAddMkb write SetAddMkb;
    property MdnId: Integer read FMdnID write FMdnID;
end;

TRealMDNColl = class(TMDNColl)
  private
    function GetItem(Index: Integer): TRealMDNItem;
    procedure SetItem(Index: Integer; const Value: TRealMDNItem);
  public
    FCollDiag: TRealDiagnosisColl;
    procedure SortByPregledId;
    procedure SortById;
    property Items[Index: Integer]: TRealMDNItem read GetItem write SetItem;
end;

TRealDiagnosisItem = class(TDiagnosisItem)
private
    FPregledID: Integer;
    FMainMkb: string;
    FAddMkb: string;
    FRank: Word;
    FPData: PAspRec;
    FIsDeleted: Boolean;
    FNode: PVirtualNode;

public
  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  property PregledID: Integer read FPregledID write FPregledID;
  property MainMkb: string read FMainMkb write FMainMkb;
  property AddMkb: string read FAddMkb write FAddMkb;
  property Rank: Word read FRank write FRank;
  property PData: PAspRec read FPData write FPData;
  property IsDeleted: Boolean read FIsDeleted write FIsDeleted;
  property Node: PVirtualNode read FNode write FNode;
end;

TRealDiagnosisColl = class(TDiagnosisColl)
  private
    function GetItem(Index: Integer): TRealDiagnosisItem;
    procedure SetItem(Index: Integer; const Value: TRealDiagnosisItem);
public
  cmdFile: TFileStream;
  procedure SortByPregledId;
  property Items[Index: Integer]: TRealDiagnosisItem read GetItem write SetItem;
end;

TPatientNewItemForFind = class(TPatientNewItem)

end;

TRealPatientNewItem = class(TPatientNewItemForFind)
private
  FPatID: Integer;
  FPatEGN: string;

  FTYPE_CERTIFICATE: AnsiString;
  FDATEISSUE: TDate;
  FDATE_OTPISVANE: TDate;
  FRZOKR: AnsiString;
  FDATETO: TDate;
  FPAT_KIND: word;
  FRZOK: AnsiString;
  FHEALTH_INSURANCE_NUMBER: AnsiString;
  FDATEFROM: TDate;
  FDATE_HEALTH_INSURANCE_CHECK: TDate;
  FOSIGUREN: boolean;
  FDATETO_TEXT: AnsiString;
  FOSIGNO: AnsiString;
  FPASS: AnsiString;
  FDATA_HEALTH_INSURANCE: AnsiString;
  FDATE_ZAPISVANE: TDate;
  FGRAJD: AnsiString;
  FIS_NEBL_USL: boolean;
  FHEALTH_INSURANCE_NAME: AnsiString;
  FFUND_ID: integer;
  FPREVIOUS_DOCTOR_ID: integer;
  FTIME_HEALTH_INSURANCE_CHECK: TTime;
  FIsAdded: Boolean;
  FDoctorId: Integer;
  FLastPregled: TRealPregledNewItem;
  FNoteProf: string;

public
  FDoctor: TRealDoctorItem;
  FPregledi: TList<TRealPregledNewItem>;
  FExamAnals: TList<TRealExamAnalysisItem>;
  FPatNzok: TPatientNZOKItem;
  FEventsPat: TList<TRealEventsManyTimesItem>;

  lstGraph: TList<TGraphPeriod132>;
  FClonings: TList<TRealPatientNewItem>;
  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  function CalcAge(CurrentDate, BirthDate: TDate): Integer;
  function CalcAgeDouble(CurrentDate, BirthDate: TDate): Double;

  property PatID: Integer read FPatID write FPatID;
  property PatEGN: string read FPatEGN write FPatEGN;
  property IsAdded: Boolean read FIsAdded write FIsAdded;
  property LastPregled: TRealPregledNewItem read FLastPregled write FLastPregled;
  property NoteProf: string read FNoteProf write FNoteProf;

  property HEALTH_INSURANCE_NAME: AnsiString read FHEALTH_INSURANCE_NAME write FHEALTH_INSURANCE_NAME;
  property HEALTH_INSURANCE_NUMBER: AnsiString read FHEALTH_INSURANCE_NUMBER write FHEALTH_INSURANCE_NUMBER;
  property DATA_HEALTH_INSURANCE: AnsiString read FDATA_HEALTH_INSURANCE write FDATA_HEALTH_INSURANCE;
  property DATE_HEALTH_INSURANCE_CHECK: TDate read FDATE_HEALTH_INSURANCE_CHECK write FDATE_HEALTH_INSURANCE_CHECK;
  property TIME_HEALTH_INSURANCE_CHECK: TTime read FTIME_HEALTH_INSURANCE_CHECK write FTIME_HEALTH_INSURANCE_CHECK;
  property DATE_OTPISVANE: TDate read FDATE_OTPISVANE write FDATE_OTPISVANE;
  property DATE_ZAPISVANE: TDate read FDATE_ZAPISVANE write FDATE_ZAPISVANE;
  property DATEFROM: TDate read FDATEFROM write FDATEFROM;
  property DATEISSUE: TDate read FDATEISSUE write FDATEISSUE;
  property DATETO: TDate read FDATETO write FDATETO;
  property DATETO_TEXT: AnsiString read FDATETO_TEXT write FDATETO_TEXT;
  property GRAJD: AnsiString read FGRAJD write FGRAJD;
  property IS_NEBL_USL: boolean read FIS_NEBL_USL write FIS_NEBL_USL;
  property OSIGNO: AnsiString read FOSIGNO write FOSIGNO;
  property OSIGUREN: boolean read FOSIGUREN write FOSIGUREN;
  property PASS: AnsiString read FPASS write FPASS;
  property PREVIOUS_DOCTOR_ID: integer read FPREVIOUS_DOCTOR_ID write FPREVIOUS_DOCTOR_ID;
  property TYPE_CERTIFICATE: AnsiString read FTYPE_CERTIFICATE write FTYPE_CERTIFICATE;
  property FUND_ID: integer read FFUND_ID write FFUND_ID;
  property PAT_KIND: word read FPAT_KIND write FPAT_KIND;
  property RZOK: AnsiString read FRZOK write FRZOK;
  property RZOKR: AnsiString read FRZOKR write FRZOKR;
  property DoctorId: Integer read FDoctorId write FDoctorId;
end;

TRealPatientNewColl = class(TPatientNewColl)
private

  function GetItem(Index: Integer): TRealPatientNewItem;
  procedure SetItem(Index: Integer; const Value: TRealPatientNewItem);
public
  public
  ListEditDyn: TList<TEditDyn>;
  FUin: string;
  constructor Create(ItemClass: TCollectionItemClass);override;
  destructor destroy; override;
  procedure SortByPatId;
  procedure SortByDoctorID;
  procedure SortByPatEGN;
  property Items[Index: Integer]: TRealPatientNewItem read GetItem write SetItem;
  procedure OnGetTextPatNamesDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);


end;

TRealPatientNZOKItem = class(TPatientNZOKItem)
private
  FIsAdded: Boolean;
  FPatEGN: string;
  FPatHIP: TPatientNewItem;
public
  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  property PatEGN: string read FPatEGN write FPatEGN;
  property IsAdded: Boolean read FIsAdded write FIsAdded;
end;

TRealPatientNZOKColl = class(TPatientNZOKColl)
  private
    FUin: string;

    function GetItem(Index: Integer): TRealPatientNZOKItem;
    procedure SetItem(Index: Integer; const Value: TRealPatientNZOKItem);

public
  procedure SortByPatEGN;

  property Items[Index: Integer]: TRealPatientNZOKItem read GetItem write SetItem;
  property Uin: string read FUin write FUin;
end;

TRealExam_boln_listItem = class(TExam_boln_listItem)

end;

TRealExam_boln_listColl = class(TExam_boln_listColl)

end;

TRealDiagnosticReportItem = class(TDiagnosticReportItem)
  private
    FPregledID: Integer;
    FProcCode: string;
    FCl142: TCL142Item;
public
  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  property PregledID: Integer read FPregledID write FPregledID;
  property ProcCode: string read FProcCode write FProcCode;
  property CL142: TCL142Item read FCl142 write FCL142;
end;

TRealDiagnosticReportColl = class(TDiagnosticReportColl)
  private
    function GetItem(Index: Integer): TRealDiagnosticReportItem;
    procedure SetItem(Index: Integer; const Value: TRealDiagnosticReportItem);
public
  cmdFile: TFileStream;
  procedure SortByPregledId;
  property Items[Index: Integer]: TRealDiagnosticReportItem read GetItem write SetItem;
end;

TRealExamAnalysisItem = class(TExamAnalysisItem)
  private
    FExamAnalID: Integer;
    FMdnId: Integer;
    FCl132: TObject;
    procedure SetMdnId(const Value: Integer);
    procedure SetCl132(const Value: TObject);
  public
    constructor Create(Collection: TCollection); override;
    property ExamAnalID: Integer read FExamAnalID write FExamAnalID;
    property MdnId: Integer read FMdnId write SetMdnId;
    property Cl132: TObject read FCl132 write SetCl132;
end;

TRealExamAnalysisColl = class(TExamAnalysisColl)
  private
    function GetItem(Index: Integer): TRealExamAnalysisItem;
    procedure SetItem(Index: Integer; const Value: TRealExamAnalysisItem);
  public
    procedure SortByMdnID;
    property Items[Index: Integer]: TRealExamAnalysisItem read GetItem write SetItem;
end;

TRealExamImmunizationItem = class(TExamImmunizationItem)

end;

TRealExamImmunizationColl = class(TExamImmunizationColl)

end;

TRealProceduresItem = class(TProceduresItem)
  private
    FCodeOpis: string;
  public
    FCl142: TCl142Item;
    FPregled: TRealPregledNewItem;
    property CodeOpis: string read FCodeOpis write FCodeOpis;

end;

TRealProceduresColl = class(TProceduresColl)
  private
    function GetItem(Index: Integer): TRealProceduresItem;
    procedure SetItem(Index: Integer; const Value: TRealProceduresItem);
  public
    procedure SortByCodeOpis;
    property Items[Index: Integer]: TRealProceduresItem read GetItem write SetItem;

end;

TRealPregledNewItem = class(TPregledNewItem)
  private
    FPatID: Integer;
    FMainMKB: string;
    FMAIN_DIAG_MKB_ADD: string;
    FMAIN_DIAG_MKB_ADD1: string;
    FMAIN_DIAG_MKB_ADD4: string;
    FMainMKB2: string;
    FMainMKB3: string;
    FMainMKB1: string;
    FMAIN_DIAG_MKB_ADD2: string;
    FMainMKB4: string;
    FMAIN_DIAG_MKB_ADD3: string;
    FPregledID: Integer;
    FStartDate: TDate;
    FDoctorID: Integer;
    FIS_NAET: Boolean;
    FIS_ZAMESTVASHT: Boolean;
    FEXAM_BOLN_LIST_ID: Integer;
    FOWNER_DOCTOR_ID: Integer;
    FIS_MEDBELEJKA: Boolean;
    FIS_EXPERTIZA: Boolean;
    FIS_BABY_CARE: Boolean;
    FIS_CONSULTATION: Boolean;
    FIS_FORM_VALID: Boolean;
    FIS_EPIKRIZA: Boolean;
    FIS_DISPANSERY: Boolean;
    FIS_ANALYSIS: Boolean;
    FIS_MANIPULATION: Boolean;
    FINCIDENTALLY: Boolean;
    FIS_HOSPITALIZATION: Boolean;
    FIS_EMERGENCY: Boolean;
    FIS_PREVENTIVE: Boolean;
    FIS_OPERATION: Boolean;
    FIS_NO_DELAY: Boolean;
    FIS_VSD: Boolean;
    FIS_NAPR_TELK: Boolean;
    FIS_RISK_GROUP: Boolean;
    FIS_RECEPTA_HOSPIT: Boolean;
    FIS_PODVIZHNO_LZ: Boolean;
    FIS_NOTIFICATION: Boolean;
    FIS_REHABILITATION: Boolean;
    FIS_PRINTED: Boolean;
    FIS_NEW: Boolean;
    FIS_REGISTRATION: Boolean;
    FIS_TELK: Boolean;
    FTO_BE_DISPANSERED: Boolean;
    FPAY: Boolean;
    FRECKNNO: string;
    FPROCEDURE2_MKB: string;
    FPROCEDURE3_MKB: string;
    FPROCEDURE1_MKB: string;
    FPROCEDURE4_MKB: string;
    FclcClass: TNzisPregledType;
    FclcFinancingSource: TNZISFinancingSource;
    FCl132: TObject;
    procedure SetMAIN_DIAG_MKB_ADD(const Value: string);
    procedure SetMAIN_DIAG_MKB_ADD1(const Value: string);
    procedure SetMAIN_DIAG_MKB_ADD2(const Value: string);
    procedure SetMAIN_DIAG_MKB_ADD3(const Value: string);
    procedure SetMAIN_DIAG_MKB_ADD4(const Value: string);
    procedure SetINCIDENTALLY(const Value: Boolean);
    procedure SetIS_ANALYSIS(const Value: Boolean);
    procedure SetIS_BABY_CARE(const Value: Boolean);
    procedure SetIS_CONSULTATION(const Value: Boolean);
    procedure SetIS_DISPANSERY(const Value: Boolean);
    procedure SetIS_EMERGENCY(const Value: Boolean);
    procedure SetIS_EPIKRIZA(const Value: Boolean);
    procedure SetIS_EXPERTIZA(const Value: Boolean);
    procedure SetIS_FORM_VALID(const Value: Boolean);
    procedure SetIS_HOSPITALIZATION(const Value: Boolean);
    procedure SetIS_MANIPULATION(const Value: Boolean);
    procedure SetIS_MEDBELEJKA(const Value: Boolean);
    procedure SetIS_NAPR_TELK(const Value: Boolean);
    procedure SetIS_NEW(const Value: Boolean);
    procedure SetIS_NO_DELAY(const Value: Boolean);
    procedure SetIS_NOTIFICATION(const Value: Boolean);
    procedure SetIS_OPERATION(const Value: Boolean);
    procedure SetIS_PODVIZHNO_LZ(const Value: Boolean);
    procedure SetIS_PREVENTIVE(const Value: Boolean);
    procedure SetIS_PRINTED(const Value: Boolean);
    procedure SetIS_RECEPTA_HOSPIT(const Value: Boolean);
    procedure SetIS_REGISTRATION(const Value: Boolean);
    procedure SetIS_REHABILITATION(const Value: Boolean);
    procedure SetIS_RISK_GROUP(const Value: Boolean);
    procedure SetIS_TELK(const Value: Boolean);
    procedure SetIS_VSD(const Value: Boolean);
    procedure SetPAY(const Value: Boolean);
    procedure SetTO_BE_DISPANSERED(const Value: Boolean);
    procedure SetCl132(const Value: TObject);
    function GetStartDate: TDate;
    procedure SetPROCEDURE1_MKB(const Value: string);
    procedure SetPROCEDURE2_MKB(const Value: string);
    procedure SetPROCEDURE3_MKB(const Value: string);
    procedure SetPROCEDURE4_MKB(const Value: string);

public
  FDiagnosis: TList<TRealDiagnosisItem>;
  FProcedures: TList<TRealProceduresItem>;
  FCodeOpis: TStringList;
  FDiagnosticReport: TList<TRealDiagnosticReportItem>;
  FMdns: TList<TRealMDNItem>;

  Fpatient: TRealPatientNewItem;
  FDoctor: TRealDoctorItem;
  FDeput: TRealDoctorItem;
  FOwnerDoctor: TRealDoctorItem;
  FNode: PVirtualNode;
  constructor Create(Collection: TCollection); override;
  destructor Destroy; override;

  procedure CalcTypes(Abuf: Pointer; Aposdata: cardinal);

  property Cl132: TObject read FCl132 write SetCl132;

  property PatID: Integer read FPatID write FPatID;
  property PregledID: Integer read FPregledID write FPregledID;
  property StartDate: TDate read FStartDate write FStartdate;
  property DoctorID: Integer read FDoctorID write FDoctorID;
  property IS_NAET: Boolean read FIS_NAET write FIS_NAET;
  property IS_ZAMESTVASHT: Boolean read FIS_ZAMESTVASHT write FIS_ZAMESTVASHT;
  property OWNER_DOCTOR_ID: Integer read FOWNER_DOCTOR_ID write FOWNER_DOCTOR_ID;
  property EXAM_BOLN_LIST_ID: Integer read FEXAM_BOLN_LIST_ID write FEXAM_BOLN_LIST_ID;


  property MainMKB: string read FMainMKB write FMainMKB;
  property MAIN_DIAG_MKB_ADD: string read FMAIN_DIAG_MKB_ADD write SetMAIN_DIAG_MKB_ADD;
  property MainMKB1: string read FMainMKB1 write FMainMKB1;
  property MAIN_DIAG_MKB_ADD1: string read FMAIN_DIAG_MKB_ADD1 write SetMAIN_DIAG_MKB_ADD1;
  property MainMKB2: string read FMainMKB2 write FMainMKB2;
  property MAIN_DIAG_MKB_ADD2: string read FMAIN_DIAG_MKB_ADD2 write SetMAIN_DIAG_MKB_ADD2;
  property MainMKB3: string read FMainMKB3 write FMainMKB3;
  property MAIN_DIAG_MKB_ADD3: string read FMAIN_DIAG_MKB_ADD3 write SetMAIN_DIAG_MKB_ADD3;
  property MainMKB4: string read FMainMKB4 write FMainMKB4;
  property MAIN_DIAG_MKB_ADD4: string read FMAIN_DIAG_MKB_ADD4 write SetMAIN_DIAG_MKB_ADD4;

  property INCIDENTALLY: Boolean read FINCIDENTALLY write SetINCIDENTALLY;
  property IS_ANALYSIS: Boolean read FIS_ANALYSIS write SetIS_ANALYSIS;
  property IS_BABY_CARE: Boolean read FIS_BABY_CARE write SetIS_BABY_CARE;
  property IS_CONSULTATION: Boolean read FIS_CONSULTATION write SetIS_CONSULTATION;
  property IS_DISPANSERY: Boolean read FIS_DISPANSERY write SetIS_DISPANSERY;
  property IS_EMERGENCY: Boolean read FIS_EMERGENCY write SetIS_EMERGENCY;
  property IS_EPIKRIZA: Boolean read FIS_EPIKRIZA write SetIS_EPIKRIZA;
  property IS_EXPERTIZA: Boolean read FIS_EXPERTIZA write SetIS_EXPERTIZA;
  property IS_FORM_VALID: Boolean read FIS_FORM_VALID write SetIS_FORM_VALID;
  property IS_HOSPITALIZATION: Boolean read FIS_HOSPITALIZATION write SetIS_HOSPITALIZATION;
  property IS_MANIPULATION: Boolean read FIS_MANIPULATION write SetIS_MANIPULATION;
  property IS_MEDBELEJKA: Boolean read FIS_MEDBELEJKA write SetIS_MEDBELEJKA;

  property IS_NAPR_TELK: Boolean read FIS_NAPR_TELK write SetIS_NAPR_TELK;
  property IS_NEW: Boolean read FIS_NEW write SetIS_NEW;
  property IS_NOTIFICATION: Boolean read FIS_NOTIFICATION write SetIS_NOTIFICATION;
  property IS_NO_DELAY: Boolean read FIS_NO_DELAY write SetIS_NO_DELAY;
  property IS_OPERATION: Boolean read FIS_OPERATION write SetIS_OPERATION;
  property IS_PODVIZHNO_LZ: Boolean read FIS_PODVIZHNO_LZ write SetIS_PODVIZHNO_LZ;
  property IS_PREVENTIVE: Boolean read FIS_PREVENTIVE write SetIS_PREVENTIVE;
  property IS_PRINTED: Boolean read FIS_PRINTED write SetIS_PRINTED;
  property IS_RECEPTA_HOSPIT: Boolean read FIS_RECEPTA_HOSPIT write SetIS_RECEPTA_HOSPIT;
  property IS_REGISTRATION: Boolean read FIS_REGISTRATION write SetIS_REGISTRATION;
  property IS_REHABILITATION: Boolean read FIS_REHABILITATION write SetIS_REHABILITATION;
  property IS_RISK_GROUP: Boolean read FIS_RISK_GROUP write SetIS_RISK_GROUP;
  property IS_TELK: Boolean read FIS_TELK write SetIS_TELK;
  property IS_VSD: Boolean read FIS_VSD write SetIS_VSD;
  property PAY: Boolean read FPAY write SetPAY;
  property TO_BE_DISPANSERED: Boolean read FTO_BE_DISPANSERED write SetTO_BE_DISPANSERED;

  property RECKNNO: string read FRECKNNO write FRECKNNO;
  property PROCEDURE1_MKB: string read FPROCEDURE1_MKB write SetPROCEDURE1_MKB;
  property PROCEDURE2_MKB: string read FPROCEDURE2_MKB write SetPROCEDURE2_MKB;
  property PROCEDURE3_MKB: string read FPROCEDURE3_MKB write SetPROCEDURE3_MKB;
  property PROCEDURE4_MKB: string read FPROCEDURE4_MKB write SetPROCEDURE4_MKB;

  property clcClass: TNzisPregledType read FclcClass;
  property clcFinancingSource: TNZISFinancingSource read FclcFinancingSource;
end;

TRealPregledNewColl = class(TPregledNewColl)
  private
    function GetItem(Index: Integer): TRealPregledNewItem;
    procedure SetItem(Index: Integer; const Value: TRealPregledNewItem);
public
  FCollDiag: TRealDiagnosisColl;
  FCollDiagnRep: TRealDiagnosticReportColl;
  FCollProceduresPreg: TRealProceduresColl;
  procedure SortByPatId;
  procedure SortByPatID_StartDate;
  procedure SortByPregledID;
  procedure SortByDoctorID;
  procedure SortByOwnerDoctorID;
  procedure SortByMainMkb;
  procedure SortByProcedureCodeOpis;

  property Items[Index: Integer]: TRealPregledNewItem read GetItem write SetItem;
end;

TRealDoctorItem = class(TDoctorItem)
private
    FDoctorID: Integer;
    FFullName: string;
    FCert: TElX509Certificate;
    function GetFullName: string;
    function GetDoctorID: Integer;
public
  node: PVirtualNode;
  FPatients: TList<TRealPatientNewItem>;
  FListUnfav: TList<TRealUnfavItem>;
  FListUnfavDB: TList<TRealUnfavItem>;
  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  property FullName: string read GetFullName;
  property DoctorID: Integer read GetDoctorID write FDoctorID;
  property Cert: TElX509Certificate read FCert write FCert;
end;

TRealDoctorColl = class(TDoctorColl)
  private
    FMaxLenDoctorName: integer;
    function GetItem(Index: Integer): TRealDoctorItem;
    procedure SetItem(Index: Integer; const Value: TRealDoctorItem);
  public
    function MaxWidth(canvas: TCanvas): integer;
    procedure SortByDoctorID;
    procedure ClearUnfav;

    property Items[Index: Integer]: TRealDoctorItem read GetItem write SetItem;
    property MaxLenDoctorName: integer read FMaxLenDoctorName;

end;

TRealUnfavItem = class(TUnfavItem)
private
  FDoctorID: word;
  FYear: Word;
  FMonth: Word;
    function GetDoctorID: Word;
    function GetMoth: Word;
    function GetYear: Word;
public

  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  property DoctorID: Word read GetDoctorID;
  property Year: Word read GetYear;
  property Month: Word read GetMoth;
end;

TRealUnfavColl = class(TUnfavColl)
  private
    FCurrentYear: word;
    FOnCurrentYearChange: TNotifyEvent;
    function GetItem(Index: Integer): TRealUnfavItem;
    procedure SetItem(Index: Integer; const Value: TRealUnfavItem);
    procedure SetCurrentYear(const Value: word);
  public
    procedure SortByDoctorID;
    procedure InsertAUnfav(doctorID, monthUF, YearUF: Word);
    procedure DeleteAUnfav(doctorID, monthUF, YearUF: Word);
    procedure ClearReal;
    property Items[Index: Integer]: TRealUnfavItem read GetItem write SetItem;
    property CurrentYear: word read FCurrentYear write SetCurrentYear;
    property OnCurrentYearChange: TNotifyEvent read FOnCurrentYearChange write FOnCurrentYearChange;
  end;

  TRealEventsManyTimesItem = class(TEventsManyTimesItem)
  private
    FPatID: Integer;

  public
    property PatID: Integer read FPatID write FPatID;

  end;

  TRealEventsManyTimesColl = class(TEventsManyTimesColl)
  private
    function GetItem(Index: Integer): TRealEventsManyTimesItem;
    procedure SetItem(Index: Integer; const Value: TRealEventsManyTimesItem);

  public
    procedure SortByPatID;
    property Items[Index: Integer]: TRealEventsManyTimesItem read GetItem write SetItem;
  end;



implementation

{ TRealPregledColl }



{ TRealPregledNewColl }

function TRealPregledNewColl.GetItem(Index: Integer): TRealPregledNewItem;
begin
  Result := TRealPregledNewItem(inherited GetItem(Index));
end;

procedure TRealPregledNewColl.SetItem(Index: Integer; const Value: TRealPregledNewItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealPregledNewColl.SortByDoctorID;
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
        while (Items[I]).FDoctorID < (Items[P]).FDoctorID do Inc(I);
        while (Items[J]).FDoctorID > (Items[P]).FDoctorID do Dec(J);
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

procedure TRealPregledNewColl.SortByMainMkb;
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
        while (Items[I]).FMainMKB < (Items[P]).FMainMKB do Inc(I);
        while (Items[J]).FMainMKB > (Items[P]).FMainMKB do Dec(J);
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

procedure TRealPregledNewColl.SortByOwnerDoctorID;
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
        while (Items[I]).FOWNER_DOCTOR_ID < (Items[P]).FOWNER_DOCTOR_ID do Inc(I);
        while (Items[J]).FOWNER_DOCTOR_ID > (Items[P]).FOWNER_DOCTOR_ID do Dec(J);
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

procedure TRealPregledNewColl.SortByPatId;
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
        while (Items[I]).FPatID < (Items[P]).FPatID do Inc(I);
        while (Items[J]).FPatID > (Items[P]).FPatID do Dec(J);
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


procedure TRealPregledNewColl.SortByPatID_StartDate;
var
  sc : TList<TCollectionItem>;

  function conditionI(i, p: integer): Boolean;
  begin
    if Items[i].FPatID <> Items[P].FPatID then
      Result := Items[i].FPatID < Items[P].FPatID
    else
      Result := Items[i].FStartDate < Items[P].FStartDate;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if Items[j].FPatID <> Items[P].FPatID then
      Result := Items[j].FPatID > Items[P].FPatID
    else
      Result := Items[j].FStartDate > Items[P].FStartDate;
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TCollectionItem;
  begin
    repeat
      i := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
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

procedure TRealPregledNewColl.SortByPregledID;
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
        while (Items[I]).FPregledID < (Items[P]).FPregledID do Inc(I);
        while (Items[J]).FPregledID > (Items[P]).FPregledID do Dec(J);
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

procedure TRealPregledNewColl.SortByProcedureCodeOpis;
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
        while (Items[I]).FPregledID < (Items[P]).FPregledID do Inc(I);
        while (Items[J]).FPregledID > (Items[P]).FPregledID do Dec(J);
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

{ TRealPatientNewColl }

constructor TRealPatientNewColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListEditDyn := TList<TEditDyn>.Create;
  ArrPropSearch := [
         PatientNew_ID
       , PatientNew_EGN
       , PatientNew_NZIS_BEBE
       , PatientNew_BABY_NUMBER
       , PatientNew_NZIS_PID
       , PatientNew_BIRTH_DATE
       , PatientNew_FNAME
       , PatientNew_SNAME
       , PatientNew_LNAME
       , PatientNew_DIE_DATE
       , PatientNew_DIE_FROM
       , PatientNew_DOSIENOMER
       , PatientNew_DZI_NUMBER
       , PatientNew_EHIC_NO
       , PatientNew_LAK_NUMBER
       , PatientNew_RACE
       , PatientNew_Logical
       ];
end;

destructor TRealPatientNewColl.destroy;
begin
  FreeAndNil(ListEditDyn);
  inherited;
end;

function TRealPatientNewColl.GetItem(Index: Integer): TRealPatientNewItem;
begin
  Result := TRealPatientNewItem(inherited GetItem(Index));
end;

procedure TRealPatientNewColl.OnGetTextPatNamesDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TPatientNewItem;
  Fname,  Sname, LName: string;
begin
  if index < 0 then
  begin
    Tempitem := TPatientNewItem.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(word(PatientNew_FNAME), -1, Tempitem, Fname);
    GetCellFromMap(word(PatientNew_SNAME), -1, Tempitem, Sname);
    GetCellFromMap(word(PatientNew_LNAME), -1, Tempitem, Lname);
    value := value.Join(' ', [Fname, Sname, Lname]);
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

procedure TRealPatientNewColl.SetItem(Index: Integer; const Value: TRealPatientNewItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealPatientNewColl.SortByDoctorID;
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
        while (Items[I]).FDoctorId < (Items[P]).FDoctorId do Inc(I);
        while (Items[J]).FDoctorId > (Items[P]).FDoctorId do Dec(J);
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

procedure TRealPatientNewColl.SortByPatEGN;
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
        while (Items[I]).FPatEGN < (Items[P]).FPatEGN do Inc(I);
        while (Items[J]).FPatEGN > (Items[P]).FPatEGN do Dec(J);
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

procedure TRealPatientNewColl.SortByPatId;
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
        while (Items[I]).FPatID < (Items[P]).FPatID do Inc(I);
        while (Items[J]).FPatID > (Items[P]).FPatID do Dec(J);
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

{ TRealPatientNewItem }

function TRealPatientNewItem.CalcAge(CurrentDate, BirthDate: TDate): Integer;
var
  d, m, y: Word;
  d1, m1, y1: Word;
begin
  DecodeDate(BirthDate, y, m, d);
  DecodeDate(CurrentDate, y1, m1, d1);
  if (d1 = d) and (m1 = m) then
  begin
    if CurrentDate > BirthDate then
      Result := y1 - y
    else
      Result := -y1 + y;
    Exit;
  end;

  if CurrentDate > BirthDate then
    Result := Trunc(System.DateUtils.YearSpan(CurrentDate, BirthDate))
  else
    Result := Trunc(-System.DateUtils.YearSpan(BirthDate, CurrentDate));
end;


function TRealPatientNewItem.CalcAgeDouble(CurrentDate, BirthDate: TDate): Double;
var
  d, m, y: Word;
  d1, m1, y1: Word;
begin
  DecodeDate(BirthDate, y, m, d);
  DecodeDate(CurrentDate, y1, m1, d1);
  if (d1 = d) and (m1 = m) then
  begin
    if CurrentDate > BirthDate then
      Result := y1 - y
    else
      Result := -y1 + y;
    Exit;
  end;

  if CurrentDate > BirthDate then
    Result := (System.DateUtils.YearSpan(CurrentDate, BirthDate))
  else
    Result := (-System.DateUtils.YearSpan(BirthDate, CurrentDate));
end;

constructor TRealPatientNewItem.Create(Collection: TCollection);
begin
  inherited;
  FPatID := -1;
  FPregledi := TList<TRealPregledNewItem>.Create;
  FExamAnals := TList<TRealExamAnalysisItem>.Create;;
  FEventsPat := TList<TRealEventsManyTimesItem>.Create;
  FClonings := TList<TRealPatientNewItem>.Create;
  FIsAdded := False;
  FNoteProf := 'Няма неизвършени дейности по профилактиката.';
  lstGraph := TList<TGraphPeriod132>.Create;
end;

destructor TRealPatientNewItem.destroy;
begin
  FreeAndNil(FPregledi);
  FreeAndNil(FEventsPat);
  FreeAndNil(lstGraph);
  FreeAndNil(FClonings);
  FreeAndNil(FExamAnals);
  if Assigned(PRecord) then
  begin
    Dispose(PRecord);
    PRecord := nil;
  end;
  inherited;
end;

//function TRealPatientNewItem.GetPidType: TNZISidentifierType;
//var
//  APydType: string;
//begin
//
//  case FIdentifierTypeDB[1] of
//    'E': FIdentifierTypeBaseCL004 := itbEGN;
//    'L': FIdentifierTypeBaseCL004 := itbLNZ;
//    'S': FIdentifierTypeBaseCL004 := itbSSN;
//    'F': FIdentifierTypeBaseCL004 := itbOther;
//    'B': FIdentifierTypeBaseCL004 := itbNBN;
//  end;
//end;

{ TRealPregledNewItem }

procedure TRealPregledNewItem.CalcTypes(Abuf: Pointer; Aposdata: cardinal);
var
  log: TlogicalPregledNewSet;
begin
  self.getLogical40Map(Abuf, Aposdata, word(PregledNew_Logical));
  if TLogicalPregledNew.IS_AMB_PR in log then FclcClass := ptAMB
  else if TLogicalPregledNew.IS_DOM_PR in log then FclcClass := ptHH
  else if TLogicalPregledNew.IS_DOM_PR in log then FclcClass := ptHH
  else if TLogicalPregledNew.IS_DISPANSERY in log then FclcClass := ptIMP;

  if TLogicalPregledNew.pay in log then FclcFinancingSource := fsNHIF  // zzzzzzzzzzzzzzzzzz има още
  else FclcFinancingSource := fsPatient;

end;

constructor TRealPregledNewItem.Create(Collection: TCollection);
begin
  inherited;
  FCl132 := nil;
  FDiagnosis := TList<TRealDiagnosisItem>.Create;
  FProcedures := TList<TRealProceduresItem>.Create;
  FCodeOpis := TStringList.Create;
  FDiagnosticReport := TList<TRealDiagnosticReportItem>.create;
  FMdns := TList<TRealMDNItem>.Create;
  FDoctor := nil;
  FOwnerDoctor := nil;
  FDeput := nil;
end;

destructor TRealPregledNewItem.Destroy;
var
  i: Integer;
  //diag: TDiagnosisItem;
begin
  //for i := 0 to FDiagnosis.Count - 1 do
//  begin
//    diag := FDiagnosis[i];
//    FreeAndNil(diag);
//  end;
  FreeAndNil(FDiagnosis);
  FreeAndNil(FProcedures);
  FreeAndNil(FCodeOpis);
  FreeAndNil(FDiagnosticReport);
  FreeAndNil(FMdns);
  inherited;
end;

function TRealPregledNewItem.GetStartDate: TDate;
begin
  //if FStartdate <> 0 then
//  begin
//    Result := FStartdate;
//  end
//  else
//  begin
//    Result := Self.getDateMap()
//  end;
end;

procedure TRealPregledNewItem.SetCl132(const Value: TObject);
begin
  FCl132 := Value;
end;

procedure TRealPregledNewItem.SetPROCEDURE2_MKB(const Value: string);
var
  procColl: TRealProceduresColl;
  Proc: TRealProceduresItem;
begin
  if Value = '' then
    exit;
  procColl := TRealPregledNewColl(Collection).FCollProceduresPreg;// Глобална колекция за процедурите
  FPROCEDURE2_MKB := Value.Split(['|'])[0]; // само кода на процедурата
  Proc := TRealProceduresItem(procColl.Add); // само го добавям без да се записва
  Proc.FPregled := Self;
 // Self.FProcedures.Add(Proc); //всеки преглед да си има списък с процедури

  Proc.FCodeOpis := Value;// тука е и описанието за мапване
end;

procedure TRealPregledNewItem.SetPROCEDURE3_MKB(const Value: string);
var
  procColl: TRealProceduresColl;
  Proc: TRealProceduresItem;
begin
  if Value = '' then
    exit;
  procColl := TRealPregledNewColl(Collection).FCollProceduresPreg;// Глобална колекция за процедурите
  FPROCEDURE3_MKB := Value.Split(['|'])[0]; // само кода на процедурата
  Proc := TRealProceduresItem(procColl.Add); // само го добавям без да се записва
  Proc.FPregled := Self;
  //Self.FProcedures.Add(Proc); //всеки преглед да си има списък с процедури

  Proc.FCodeOpis := Value;// тука е и описанието за мапване
end;

procedure TRealPregledNewItem.SetPROCEDURE4_MKB(const Value: string);
var
  procColl: TRealProceduresColl;
  Proc: TRealProceduresItem;
begin
  if Value = '' then
    exit ;
  procColl := TRealPregledNewColl(Collection).FCollProceduresPreg;// Глобална колекция за процедурите
  FPROCEDURE4_MKB := Value.Split(['|'])[0]; // само кода на процедурата
  Proc := TRealProceduresItem(procColl.Add); // само го добавям без да се записва
  Proc.FPregled := Self;
  //Self.FProcedures.Add(Proc); //всеки преглед да си има списък с процедури

  Proc.FCodeOpis := Value;// тука е и описанието за мапване
end;

procedure TRealPregledNewItem.SetINCIDENTALLY(const Value: Boolean);
begin
  FINCIDENTALLY := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.INCIDENTALLY);

end;

procedure TRealPregledNewItem.SetIS_ANALYSIS(const Value: Boolean);
begin
  FIS_ANALYSIS := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_ANALYSIS);
end;

procedure TRealPregledNewItem.SetIS_BABY_CARE(const Value: Boolean);
begin
  FIS_BABY_CARE := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_BABY_CARE);
end;

procedure TRealPregledNewItem.SetIS_CONSULTATION(const Value: Boolean);
begin
  FIS_CONSULTATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_CONSULTATION);
end;

procedure TRealPregledNewItem.SetIS_DISPANSERY(const Value: Boolean);
begin
  FIS_DISPANSERY := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_DISPANSERY);
end;

procedure TRealPregledNewItem.SetIS_EMERGENCY(const Value: Boolean);
begin
  FIS_EMERGENCY := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_EMERGENCY);
end;

procedure TRealPregledNewItem.SetIS_EPIKRIZA(const Value: Boolean);
begin
  FIS_EPIKRIZA := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_EPIKRIZA);
end;

procedure TRealPregledNewItem.SetIS_EXPERTIZA(const Value: Boolean);
begin
  FIS_EXPERTIZA := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_EXPERTIZA);
end;

procedure TRealPregledNewItem.SetIS_FORM_VALID(const Value: Boolean);
begin
  FIS_FORM_VALID := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_FORM_VALID);
end;

procedure TRealPregledNewItem.SetIS_HOSPITALIZATION(const Value: Boolean);
begin
  FIS_HOSPITALIZATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_HOSPITALIZATION);
end;

procedure TRealPregledNewItem.SetIS_MANIPULATION(const Value: Boolean);
begin
  FIS_MANIPULATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_MANIPULATION);
end;

procedure TRealPregledNewItem.SetIS_MEDBELEJKA(const Value: Boolean);
begin
  FIS_MEDBELEJKA := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.INCIDENTALLY);
end;
/////////////////////////////////////
procedure TRealPregledNewItem.SetIS_NAPR_TELK(const Value: Boolean);
begin
  FIS_NAPR_TELK := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_NAPR_TELK);
end;

procedure TRealPregledNewItem.SetIS_NEW(const Value: Boolean);
begin
  FIS_NEW := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_NEW);
end;

procedure TRealPregledNewItem.SetIS_NOTIFICATION(const Value: Boolean);
begin
  FIS_NOTIFICATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_NOTIFICATION);
end;

procedure TRealPregledNewItem.SetIS_NO_DELAY(const Value: Boolean);
begin
  FIS_NO_DELAY := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_NO_DELAY);
end;

procedure TRealPregledNewItem.SetIS_OPERATION(const Value: Boolean);
begin
  FIS_OPERATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_OPERATION);
end;

procedure TRealPregledNewItem.SetIS_PODVIZHNO_LZ(const Value: Boolean);
begin
  FIS_PODVIZHNO_LZ := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_PODVIZHNO_LZ);
end;

procedure TRealPregledNewItem.SetIS_PREVENTIVE(const Value: Boolean);
begin
  FIS_PREVENTIVE := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE);
end;

procedure TRealPregledNewItem.SetIS_PRINTED(const Value: Boolean);
begin
  FIS_PRINTED := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_PRINTED);
end;

procedure TRealPregledNewItem.SetIS_RECEPTA_HOSPIT(const Value: Boolean);
begin
  FIS_RECEPTA_HOSPIT := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_RECEPTA_HOSPIT);
end;

procedure TRealPregledNewItem.SetIS_REGISTRATION(const Value: Boolean);
begin
  FIS_REGISTRATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_REGISTRATION);
end;

procedure TRealPregledNewItem.SetIS_REHABILITATION(const Value: Boolean);
begin
  FIS_REHABILITATION := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_REHABILITATION);
end;

procedure TRealPregledNewItem.SetIS_RISK_GROUP(const Value: Boolean);
begin
  FIS_RISK_GROUP := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_RISK_GROUP);
end;

procedure TRealPregledNewItem.SetIS_TELK(const Value: Boolean);
begin
  FIS_TELK := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_TELK);
end;

procedure TRealPregledNewItem.SetIS_VSD(const Value: Boolean);
begin
  FIS_VSD := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.IS_VSD);
end;

procedure TRealPregledNewItem.SetMAIN_DIAG_MKB_ADD(const Value: string);
var
  diag: TRealDiagnosisItem;
  //diagColl: TRealDiagnosisColl;
begin
  FMAIN_DIAG_MKB_ADD := Value;
  if TRealPregledNewColl(Collection).FCollDiag <> nil then
  begin
    diag := TRealDiagnosisItem(TRealPregledNewColl(Collection).FCollDiag.Add);
  end
  else
  begin
    Exit;
  end;


  diag.MainMkb := FMainMKB;
  diag.AddMkb := FMAIN_DIAG_MKB_ADD;
  diag.Rank := 0;

  New(diag.PRecord);
  diag.PRecord.setProp := [];
  if FMAIN_DIAG_MKB_ADD <> '' then
  begin
    diag.PRecord.additionalCode_CL011 := FMAIN_DIAG_MKB_ADD;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if FMainMKB <> '' then
  begin
    diag.PRecord.code_CL011 := FMainMKB;
    Include(diag.PRecord.setProp, Diagnosis_code_CL011);
  end;
  diag.PRecord.rank := diag.Rank;
  Include(diag.PRecord.setProp, Diagnosis_rank);

  diag.InsertDiagnosis;
  TRealPregledNewColl(Collection).FCollDiag.streamComm.Len := TRealPregledNewColl(Collection).FCollDiag.streamComm.Size;
  TRealPregledNewColl(Collection).FCollDiag.cmdFile.CopyFrom(TRealPregledNewColl(Collection).FCollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  Self.FDiagnosis.Add(diag);
end;

procedure TRealPregledNewItem.SetMAIN_DIAG_MKB_ADD1(const Value: string);
var
  diag: TRealDiagnosisItem;
 // diagColl: TRealDiagnosisColl;
begin
  FMAIN_DIAG_MKB_ADD1 := Value;
  if FMainMKB1 = '' then exit;
  if TRealPregledNewColl(Collection).FCollDiag <> nil then
  begin
    diag := TRealDiagnosisItem(TRealPregledNewColl(Collection).FCollDiag.Add);
  end
  else
  begin
    Exit;
  end;
  //diagColl := TRealPregledNewColl(Collection).FCollDiag;
  //diag := TRealDiagnosisItem(diagColl.Add);
  diag.MainMkb := FMainMKB1;
  diag.AddMkb := FMAIN_DIAG_MKB_ADD1;
  diag.Rank := 1;

  New(diag.PRecord);
  diag.PRecord.setProp := [];
  if FMAIN_DIAG_MKB_ADD1 <> '' then
  begin
    diag.PRecord.additionalCode_CL011 := FMAIN_DIAG_MKB_ADD1;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if FMainMKB1 <> '' then
  begin
    diag.PRecord.code_CL011 := FMainMKB1;
    Include(diag.PRecord.setProp, Diagnosis_code_CL011);
  end;
  diag.PRecord.rank := diag.Rank;
  Include(diag.PRecord.setProp, Diagnosis_rank);

  diag.InsertDiagnosis;
  TRealPregledNewColl(Collection).FCollDiag.streamComm.Len := TRealPregledNewColl(Collection).FCollDiag.streamComm.Size;
  TRealPregledNewColl(Collection).FCollDiag.cmdFile.CopyFrom(TRealPregledNewColl(Collection).FCollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  Self.FDiagnosis.Add(diag);
end;

procedure TRealPregledNewItem.SetMAIN_DIAG_MKB_ADD2(const Value: string);
var
  diag: TRealDiagnosisItem;
  //diagColl: TRealDiagnosisColl;
begin
  FMAIN_DIAG_MKB_ADD2 := Value;
  if FMainMKB2 = '' then exit;
  if TRealPregledNewColl(Collection).FCollDiag <> nil then
  begin
    diag := TRealDiagnosisItem(TRealPregledNewColl(Collection).FCollDiag.Add);
  end
  else
  begin
    Exit;
  end;
  //diagColl := TRealPregledNewColl(Collection).FCollDiag;
  //diag := TRealDiagnosisItem(diagColl.Add);
  diag.MainMkb := FMainMKB2;
  diag.AddMkb := FMAIN_DIAG_MKB_ADD2;
  diag.Rank := 2;

  New(diag.PRecord);
  diag.PRecord.setProp := [];
  if FMAIN_DIAG_MKB_ADD2 <> '' then
  begin
    diag.PRecord.additionalCode_CL011 := FMAIN_DIAG_MKB_ADD2;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if FMainMKB2 <> '' then
  begin
    diag.PRecord.code_CL011 := FMainMKB2;
    Include(diag.PRecord.setProp, Diagnosis_code_CL011);
  end;
  diag.PRecord.rank := diag.Rank;
  Include(diag.PRecord.setProp, Diagnosis_rank);

  diag.InsertDiagnosis;
  TRealPregledNewColl(Collection).FCollDiag.streamComm.Len := TRealPregledNewColl(Collection).FCollDiag.streamComm.Size;
  TRealPregledNewColl(Collection).FCollDiag.cmdFile.CopyFrom(TRealPregledNewColl(Collection).FCollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  Self.FDiagnosis.Add(diag);
end;

procedure TRealPregledNewItem.SetMAIN_DIAG_MKB_ADD3(const Value: string);
var
  diag: TRealDiagnosisItem;
  //diagColl: TRealDiagnosisColl;
begin
  FMAIN_DIAG_MKB_ADD3 := Value;
  if FMainMKB3 = '' then exit;
  if TRealPregledNewColl(Collection).FCollDiag <> nil then
  begin
    diag := TRealDiagnosisItem(TRealPregledNewColl(Collection).FCollDiag.Add);
  end
  else
  begin
    Exit;
  end;
  //diagColl := TRealPregledNewColl(Collection).FCollDiag;
  //diag := TRealDiagnosisItem(diagColl.Add);
  diag.MainMkb := FMainMKB3;
  diag.AddMkb := FMAIN_DIAG_MKB_ADD3;
  diag.Rank := 3;

  New(diag.PRecord);
  diag.PRecord.setProp := [];
  if FMAIN_DIAG_MKB_ADD3 <> '' then
  begin
    diag.PRecord.additionalCode_CL011 := FMAIN_DIAG_MKB_ADD3;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if FMainMKB3 <> '' then
  begin
    diag.PRecord.code_CL011 := FMainMKB3;
    Include(diag.PRecord.setProp, Diagnosis_code_CL011);
  end;
  diag.PRecord.rank := diag.Rank;
  Include(diag.PRecord.setProp, Diagnosis_rank);

  diag.InsertDiagnosis;
  TRealPregledNewColl(Collection).FCollDiag.streamComm.Len := TRealPregledNewColl(Collection).FCollDiag.streamComm.Size;
  TRealPregledNewColl(Collection).FCollDiag.cmdFile.CopyFrom(TRealPregledNewColl(Collection).FCollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  Self.FDiagnosis.Add(diag);
end;

procedure TRealPregledNewItem.SetMAIN_DIAG_MKB_ADD4(const Value: string);
var
  diag: TRealDiagnosisItem;
  //diagColl: TRealDiagnosisColl;
begin
  FMAIN_DIAG_MKB_ADD4 := Value;
  if FMainMKB4 = '' then exit;
  if TRealPregledNewColl(Collection).FCollDiag <> nil then
  begin
    diag := TRealDiagnosisItem(TRealPregledNewColl(Collection).FCollDiag.Add);
  end
  else
  begin
    Exit;
  end;
  //diagColl := TRealPregledNewColl(Collection).FCollDiag;

  //diag := TRealDiagnosisItem(diagColl.Add);
  diag.MainMkb := FMainMKB4;
  diag.AddMkb := FMAIN_DIAG_MKB_ADD4;
  diag.Rank := 4;

  New(diag.PRecord);
  diag.PRecord.setProp := [];
  if FMAIN_DIAG_MKB_ADD4 <> '' then
  begin
    diag.PRecord.additionalCode_CL011 := FMAIN_DIAG_MKB_ADD4;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if FMainMKB4 <> '' then
  begin
    diag.PRecord.code_CL011 := FMainMKB4;
    Include(diag.PRecord.setProp, Diagnosis_code_CL011);
  end;
  diag.PRecord.rank := diag.Rank;
  Include(diag.PRecord.setProp, Diagnosis_rank);

  diag.InsertDiagnosis;
  TRealPregledNewColl(Collection).FCollDiag.streamComm.Len := TRealPregledNewColl(Collection).FCollDiag.streamComm.Size;
  TRealPregledNewColl(Collection).FCollDiag.cmdFile.CopyFrom(TRealPregledNewColl(Collection).FCollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  Self.FDiagnosis.Add(diag);
end;

procedure TRealPregledNewItem.SetPAY(const Value: Boolean);
begin
  FPAY := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.PAY);
end;

procedure TRealPregledNewItem.SetPROCEDURE1_MKB(const Value: string);   //FPROCEDURE1_ID := Value;
var
  procColl: TRealProceduresColl;
  Proc: TRealProceduresItem;
begin
  if Value = '' then
    exit;
  procColl := TRealPregledNewColl(Collection).FCollProceduresPreg;// Глобална колекция за процедурите
  FPROCEDURE1_MKB := Value.Split(['|'])[0]; // само кода на процедурата
  Proc := TRealProceduresItem(procColl.Add); // само го добавям без да се записва
  Proc.FPregled := Self;
  //Self.FProcedures.Add(Proc); //всеки преглед да си има списък с процедури

  Proc.FCodeOpis := Value;// тука е и описанието за мапване
end;

procedure TRealPregledNewItem.SetTO_BE_DISPANSERED(const Value: Boolean);
begin
  FTO_BE_DISPANSERED := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalPregledNew.TO_BE_DISPANSERED);
end;

{ TRealDiagnosisItem }

constructor TRealDiagnosisItem.Create(Collection: TCollection);
begin
  inherited;
  FIsDeleted := False;
  FNode := nil;
end;

destructor TRealDiagnosisItem.destroy;
begin

  inherited;
end;

{ TRealDiagnosisColl }

function TRealDiagnosisColl.GetItem(Index: Integer): TRealDiagnosisItem;
begin
  Result := TRealDiagnosisItem(inherited GetItem(Index));
end;

procedure TRealDiagnosisColl.SetItem(Index: Integer; const Value: TRealDiagnosisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealDiagnosisColl.SortByPregledId;
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
        while (Items[I]).FPregledID < (Items[P]).FPregledID do Inc(I);
        while (Items[J]).FPregledID > (Items[P]).FPregledID do Dec(J);
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

{ TRealMDNItem }

constructor TRealMDNItem.Create(Collection: TCollection);
begin
  inherited;
  FDiagnosis := TList<TRealDiagnosisItem>.Create;
  FExamAnals := TList<TRealExamAnalysisItem>.Create;
end;

destructor TRealMDNItem.destroy;
begin
  FreeAndNil(FDiagnosis);
  FreeAndNil(FExamAnals);
  inherited;
end;

procedure TRealMDNItem.SetAddMkb(const Value: string);
var
  diag: TRealDiagnosisItem;
  diagColl: TRealDiagnosisColl;
begin
  diagColl := TRealMDNColl(Collection).FCollDiag;
  FAddMkb := Value;
  diag := TRealDiagnosisItem(diagColl.Add);
  diag.MainMkb := FMainMKB;
  diag.AddMkb := FAddMkb;
  diag.Rank := 0;

  New(diag.PRecord);
  diag.PRecord.setProp := [];
  if FAddMkb <> '' then
  begin
    diag.PRecord.additionalCode_CL011 := FAddMkb;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if FMainMKB <> '' then
  begin
    diag.PRecord.code_CL011 := FMainMKB;
    Include(diag.PRecord.setProp, Diagnosis_code_CL011);
  end;
  diag.PRecord.rank := diag.Rank;
  Include(diag.PRecord.setProp, Diagnosis_rank);

  diag.InsertDiagnosis;
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  Self.FDiagnosis.Add(diag);
end;

procedure TRealMDNItem.SetMainMkb(const Value: string);
begin
  FMainMkb := Value;
end;

{ TRealMDNColl }

function TRealMDNColl.GetItem(Index: Integer): TRealMDNItem;
begin
  Result := TRealMDNItem(inherited GetItem(Index));
end;

procedure TRealMDNColl.SetItem(Index: Integer; const Value: TRealMDNItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealMDNColl.SortById;
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
        while (Items[I]).FMdnID < (Items[P]).FMdnID do Inc(I);
        while (Items[J]).FMdnID > (Items[P]).FMdnID do Dec(J);
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

procedure TRealMDNColl.SortByPregledId;
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
        while (Items[I]).FPregledID < (Items[P]).FPregledID do Inc(I);
        while (Items[J]).FPregledID > (Items[P]).FPregledID do Dec(J);
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

{ TRealPatientNZOKItem }

constructor TRealPatientNZOKItem.Create(Collection: TCollection);
begin
  inherited;
  FIsAdded := False;
end;

destructor TRealPatientNZOKItem.destroy;
begin

  inherited;
end;

{ TRealPatientNZOKColl }

function TRealPatientNZOKColl.GetItem(Index: Integer): TRealPatientNZOKItem;
begin
  Result := TRealPatientNZOKItem(inherited GetItem(Index));
end;

procedure TRealPatientNZOKColl.SetItem(Index: Integer; const Value: TRealPatientNZOKItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealPatientNZOKColl.SortByPatEGN;
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
        while (Items[I]).FPatEGN < (Items[P]).FPatEGN do Inc(I);
        while (Items[J]).FPatEGN > (Items[P]).FPatEGN do Dec(J);
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

{ TRealDoctorItem }

constructor TRealDoctorItem.Create(Collection: TCollection);
begin
  inherited;
  FListUnfav := TList<TRealUnfavItem>.Create;
  FListUnfavDB := TList<TRealUnfavItem>.Create;
  FListUnfav.Count := 120;
  FListUnfavDB.Count := 120;
end;

destructor TRealDoctorItem.destroy;
begin
  FreeAndNil(FListUnfav);
  FreeAndNil(FListUnfavDB);
  inherited;
end;

function TRealDoctorItem.GetDoctorID: Integer;
var
  buf: Pointer;
  posdata: Cardinal;
begin
  if FDoctorID <> 0 then
  begin
    Result := FDoctorID;
    Exit;
  end
  else
  begin
    buf := TRealDoctorColl(Collection).Buf;
    posdata := TRealDoctorColl(Collection).posData;
    FDoctorID := getIntMap(buf, posdata, word(Doctor_ID));
    Result := FDoctorID;
  end;
end;

function TRealDoctorItem.GetFullName: string;
var
  buf: Pointer;
  posdata: Cardinal;
begin
  if FFullName <> '' then
  begin
    Result := FFullName;
    Exit;
  end
  else
  begin
    buf := TRealDoctorColl(Collection).Buf;
    posdata := TRealDoctorColl(Collection).posData;
    FFullName := getAnsiStringMap(buf, posdata, word(Doctor_FNAME)) + ' ' +
                 getAnsiStringMap(buf, posdata, word(Doctor_SNAME)) + ' ' +
                 getAnsiStringMap(buf, posdata, word(Doctor_LNAME));
    Result := FFullName;
  end;
end;

{ TRealDoctorColl }

procedure TRealDoctorColl.ClearUnfav;
var
  i, j: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    for j := 0 to Items[i].FListUnfav.Count - 1 do
      Items[i].FListUnfav[j] := nil;
    for j := 0 to Items[i].FListUnfavDB.Count - 1 do
      Items[i].FListUnfavDB[j] := nil;
  end;
end;

function TRealDoctorColl.GetItem(Index: Integer): TRealDoctorItem;
begin
  Result := TRealDoctorItem(inherited GetItem(Index));
end;

function TRealDoctorColl.MaxWidth(canvas: TCanvas): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to count - 1 do
  begin
    result := max(result, canvas.TextWidth(items[i].FullName));
  end;
end;

procedure TRealDoctorColl.SetItem(Index: Integer; const Value: TRealDoctorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealDoctorColl.SortByDoctorID;
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
        while (Items[I]).FDoctorId < (Items[P]).FDoctorId do Inc(I);
        while (Items[J]).FDoctorId > (Items[P]).FDoctorId do Dec(J);
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

{ TRealUnfavItem }

constructor TRealUnfavItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TRealUnfavItem.destroy;
begin

  inherited;
end;

function TRealUnfavItem.GetDoctorID: Word;
var
  buf: Pointer;
  posdata: Cardinal;
begin
  if FDoctorID <> 0 then
  begin
    Result := FDoctorID;
    Exit;
  end
  else
  begin
    buf := TRealUnfavColl(Collection).Buf;
    posdata := TRealUnfavColl(Collection).posData;
    FDoctorID := getWordMap(buf, posdata, word(Unfav_DOCTOR_ID_PRAC));
    Result := FDoctorID;
  end;
end;

function TRealUnfavItem.GetMoth: Word;
var
  buf: Pointer;
  posdata: Cardinal;
begin
  if FMonth <> 0 then
  begin
    Result := FMonth;
    Exit;
  end
  else
  begin
    buf := TRealUnfavColl(Collection).Buf;
    posdata := TRealUnfavColl(Collection).posData;
    FMonth := getWordMap(buf, posdata, word(Unfav_MONTH_UNFAV));
    Result := FMonth;
  end;
end;

function TRealUnfavItem.GetYear: Word;
var
  buf: Pointer;
  posdata: Cardinal;
begin
  if FYear <> 0 then
  begin
    Result := FYear;
    Exit;
  end
  else
  begin
    buf := TRealUnfavColl(Collection).Buf;
    posdata := TRealUnfavColl(Collection).posData;
    FYear := getWordMap(buf, posdata, word(Unfav_YEAR_UNFAV));
    Result := FYear;
  end;
end;

{ TRealUnfavColl }

procedure TRealUnfavColl.ClearReal;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].FMonth := 0;
    Items[i].FYear := 0;
    Items[i].FDoctorID := 0;
  end;
end;

procedure TRealUnfavColl.DeleteAUnfav(doctorID, monthUF, YearUF: Word);
var
  i: Integer;
  uf: TRealUnfavItem;
  cType: TCollectionsType;
  PWordData: PWord;
begin
  uf := nil;
  for i := 0 to Count - 1 do
  begin
    uf := Items[i];
    if (uf.getWordMap(buf, posData, word(Unfav_DOCTOR_ID_PRAC)) = doctorID) and
       (uf.getWordMap(buf, posData, word(Unfav_MONTH_UNFAV)) = monthUF) and
       (uf.getWordMap(buf, posData, word(Unfav_YEAR_UNFAV)) = YearUF)
    then Break;
  end;
  if uf <> nil then
  begin
    PWordData := Pointer(pbyte(Buf) + uf.DataPos - 4);
    PWordData^ := word(ctUnfavDel);
  end;
end;

function TRealUnfavColl.GetItem(Index: Integer): TRealUnfavItem;
begin
  Result := TRealUnfavItem(inherited GetItem(Index));
end;

procedure TRealUnfavColl.InsertAUnfav(doctorID, monthUF, YearUF: Word);
var
  i: Integer;
  uf: TRealUnfavItem;
begin

  for i := 0 to Count - 1 do
  begin
    uf := Items[i];
    if (uf.getWordMap(buf, posData, word(Unfav_DOCTOR_ID_PRAC)) = doctorID) and
       (uf.getWordMap(buf, posData, word(Unfav_MONTH_UNFAV)) = monthUF) and
       (uf.getWordMap(buf, posData, word(Unfav_YEAR_UNFAV)) = YearUF)
    then Exit;
  end;
  uf := TRealUnfavItem(self.Add);
  New(uf.PRecord);
  uf.PRecord.setProp := [Unfav_DOCTOR_ID_PRAC, Unfav_YEAR_UNFAV, Unfav_MONTH_UNFAV];
  uf.PRecord.DOCTOR_ID_PRAC := doctorID;
  uf.PRecord.YEAR_UNFAV := YearUF;
  uf.PRecord.MONTH_UNFAV := monthUF;
  uf.InsertUnfav;
  Dispose(uf.PRecord);
  uf.PRecord := nil;
end;

procedure TRealUnfavColl.SetCurrentYear(const Value: word);
begin
  FCurrentYear := Value;
  if assigned(FOnCurrentYearChange) then
  begin
    FOnCurrentYearChange(self);
  end;
end;

procedure TRealUnfavColl.SetItem(Index: Integer; const Value: TRealUnfavItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealUnfavColl.SortByDoctorID;
begin

end;

{ TRealEventsManyTimesColl }

function TRealEventsManyTimesColl.GetItem(Index: Integer): TRealEventsManyTimesItem;
begin
  Result := TRealEventsManyTimesItem(inherited GetItem(Index));
end;

procedure TRealEventsManyTimesColl.SetItem(Index: Integer; const Value: TRealEventsManyTimesItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealEventsManyTimesColl.SortByPatID;
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
        while (Items[I]).FPatID < (Items[P]).FPatID do Inc(I);
        while (Items[J]).FPatID > (Items[P]).FPatID do Dec(J);
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

{ TRealExamAnalysisColl }

function TRealExamAnalysisColl.GetItem(Index: Integer): TRealExamAnalysisItem;
begin
  Result := TRealExamAnalysisItem(inherited GetItem(Index));
end;

procedure TRealExamAnalysisColl.SetItem(Index: Integer; const Value: TRealExamAnalysisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealExamAnalysisColl.SortByMdnID;
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
        while (Items[I]).FMdnId < (Items[P]).FMdnId do Inc(I);
        while (Items[J]).FMdnId > (Items[P]).FMdnId do Dec(J);
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

{ TRealExamAnalysisItem }

constructor TRealExamAnalysisItem.Create(Collection: TCollection);
begin
  inherited;
  FCl132 := nil;
end;

procedure TRealExamAnalysisItem.SetCl132(const Value: TObject);
begin
  FCl132 := Value;
end;

procedure TRealExamAnalysisItem.SetMdnId(const Value: Integer);
begin
  FMdnId := Value;
end;

{ TRealDiagnosticReportColl }

function TRealDiagnosticReportColl.GetItem(Index: Integer): TRealDiagnosticReportItem;
begin
  Result := TRealDiagnosticReportItem(inherited GetItem(Index));
end;

procedure TRealDiagnosticReportColl.SetItem(Index: Integer; const Value: TRealDiagnosticReportItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealDiagnosticReportColl.SortByPregledId;
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
        while (Items[I]).FPregledID < (Items[P]).FPregledID do Inc(I);
        while (Items[J]).FPregledID > (Items[P]).FPregledID do Dec(J);
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

{ TRealDiagnosticReportItem }

constructor TRealDiagnosticReportItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TRealDiagnosticReportItem.destroy;
begin

  inherited;
end;

{ TRealProceduresColl }

function TRealProceduresColl.GetItem(Index: Integer): TRealProceduresItem;
begin
  Result := TRealProceduresItem(inherited GetItem(Index));
end;

procedure TRealProceduresColl.SetItem(Index: Integer; const Value: TRealProceduresItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealProceduresColl.SortByCodeOpis;
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
        while (Items[I]).FCodeOpis < (Items[P]).FCodeOpis do Inc(I);
        while (Items[J]).FCodeOpis > (Items[P]).FCodeOpis do Dec(J);
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


end.
