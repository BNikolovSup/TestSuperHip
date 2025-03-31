unit RealObj.RealHipp; //PREVENTIVE_TYPE


interface

uses
  system.DateUtils,
  SBxTypes, SBxCertificateStorage,
  Table.PregledNew, Table.PatientNew, Table.diagnosis, Table.MDN,
  Table.PatientNZOK, Table.doctor, Table.Unfav, table.EventsManyTimes,
  Table.Exam_boln_list, Table.ExamAnalysis, table.ExamImmunization, Table.CL142,
  Table.CL134,
  Table.Procedures, Table.DiagnosticReport, Table.KARTA_PROFILAKTIKA2017,
  Table.BLANKA_MED_NAPR, table.NZIS_PLANNED_TYPE, table.NZIS_QUESTIONNAIRE_RESPONSE,
  Table.NZIS_QUESTIONNAIRE_ANSWER,Table.NZIS_ANSWER_VALUE, Table.NZIS_DIAGNOSTIC_REPORT,
  Table.NZIS_RESULT_DIAGNOSTIC_REPORT, Table.NzisToken,


  RealObj.NzisNomen,
  Aspects.Collections, Aspects.Types, ProfGraph, VirtualTrees,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings, Vcl.Graphics,
  classes, system.SysUtils, windows, System.Generics.Collections, system.Math,
  SBX509;
type
  TFullPorpuse = set of TlogicalPregledNew;


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
  TRealBLANKA_MED_NAPRItem = class;
  TRealNZIS_PLANNED_TYPEItem = class;
  TRealNZIS_ANSWER_VALUEItem = class;
  TRealKARTA_PROFILAKTIKA2017Item = class;

  TReqResp = class
    req: TStringList;
    resp: TStringList;
    constructor Create;
    destructor destroy; override;
  end;

  TRevision = class
    CollType: TCollectionsType;
    node: PVirtualNode;
    propIndex: Word;
  end;

  TRealMDNItem = class(TMDNItem)
  private
    FPregledID: Integer;
    FMainMkb: string;
    FAddMkb: string;
    FMdnID: Integer;
    FLinkNode: PVirtualNode;
    procedure SetAddMkb(const Value: string);
    procedure SetMainMkb(const Value: string);

  public
    FPregled: TRealPregledNewItem;
    FDiagnosis: TList<TRealDiagnosisItem>;
    FExamAnals: TList<TRealExamAnalysisItem>;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    property PregledID: Integer read FPregledID write FPregledID;
    property MainMkb: string read FMainMkb write SetMainMkb;
    property AddMkb: string read FAddMkb write SetAddMkb;
    property MdnId: Integer read FMdnID write FMdnID;
    property LinkNode: PVirtualNode read FLinkNode write FLinkNode;


end;

TRealMDNColl = class(TMDNColl)
  private
    function GetItem(Index: Integer): TRealMDNItem;
    procedure SetItem(Index: Integer; const Value: TRealMDNItem);
  public
    FCollDiag: TRealDiagnosisColl;
    procedure SortByPregledId;
    procedure SortById;
    function GetItemsFromDataPos(dataPos: Cardinal):TRealMDNItem;
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
  FCurrentGraphIndex: Integer;
  FListCurrentImun: TList<TGraphPeriod132>;
  FNAS_MQSTO: AnsiString;
    FRevisions: TList<TRevision>;


public
  FDoctor: TRealDoctorItem;
  FPregledi: TList<TRealPregledNewItem>;
  FExamAnals: TList<TRealExamAnalysisItem>;
  FPatNzok: TPatientNZOKItem;
  FEventsPat: TList<TRealEventsManyTimesItem>;
  FNode: PVirtualNode;

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
  property CurrentGraphIndex: Integer read FCurrentGraphIndex write FCurrentGraphIndex;
  property ListCurrentProf: TList<TGraphPeriod132> read FListCurrentImun  write FListCurrentImun;

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
  property NAS_MQSTO: AnsiString read FNAS_MQSTO write FNAS_MQSTO;

  property Revisions: TList<TRevision> read  FRevisions write FRevisions;

end;

TRealPatientNewColl = class(TPatientNewColl)
private

  function GetItem(Index: Integer): TRealPatientNewItem;
  procedure SetItem(Index: Integer; const Value: TRealPatientNewItem);
protected
  procedure Deleting(Item: TCollectionItem); override;
  procedure Added(var Item: TCollectionItem); override;
public
  public
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
    FLinkNode: PVirtualNode;
    FAnalID: Integer;
    FCl022: string;
    procedure SetMdnId(const Value: Integer);
    procedure SetCl132(const Value: TObject);
  public
    FMdn: TRealMDNItem;
    constructor Create(Collection: TCollection); override;
    property ExamAnalID: Integer read FExamAnalID write FExamAnalID;
    property MdnId: Integer read FMdnId write SetMdnId;
    property Cl132: TObject read FCl132 write SetCl132;
    property LinkNode: PVirtualNode read FLinkNode write FLinkNode;
    property AnalID: Integer read FAnalID write FAnalID;
    property Cl022: string read FCl022 write FCl022;
end;

TRealExamAnalysisColl = class(TExamAnalysisColl)
  private
    function GetItem(Index: Integer): TRealExamAnalysisItem;
    procedure SetItem(Index: Integer; const Value: TRealExamAnalysisItem);
  public
    procedure SortByMdnID;
    procedure SortByAnalID;
    procedure SortByCl022;
    function GetItemsFromDataPos(dataPos: Cardinal):TRealExamAnalysisItem;
    property Items[Index: Integer]: TRealExamAnalysisItem read GetItem write SetItem;
end;

TRealExamImmunizationItem = class(TExamImmunizationItem)
private
    FPregledID: Integer;
    FLinkNode: PVirtualNode;

  public
    FDiagnosis: TList<TRealDiagnosisItem>;
    FPregled: TRealPregledNewItem;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    property PregledID: Integer read FPregledID write FPregledID;
    property LinkNode: PVirtualNode read FLinkNode write FLinkNode;

  end;

TRealExamImmunizationColl = class(TExamImmunizationColl)
 private
    function GetItem(Index: Integer): TRealExamImmunizationItem;
    procedure SetItem(Index: Integer; const Value: TRealExamImmunizationItem);

  public
    procedure SortByPregID;
    function GetItemsFromDataPos(dataPos: Cardinal):TRealExamImmunizationItem;
    property Items[Index: Integer]: TRealExamImmunizationItem read GetItem write SetItem;
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
    FclcPorpuse: TNzisPregledPorpuse;
    FclcFinancingSource: TNZISFinancingSource;
    FCl132: TObject;
    FLRN: string;
    FAMB_LISTN: Integer;
    FPREVENTIVE_TYPE: Integer;

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
    procedure SetLrn(const Value: string);
    function GetPorpuse(Abuf: Pointer; Aposdata: cardinal): TLogicalPregledNew;
    procedure SetPorpuse(Abuf: Pointer; Aposdata: cardinal; const Value: TLogicalPregledNew);
    procedure SetPREVENTIVE_TYPE(const Value: Integer);
    function GetRevisions: TList<PVirtualNode>;

public
  FDiagnosis: TList<TRealDiagnosisItem>;
  FProcedures: TList<TRealProceduresItem>;
  FCodeOpis: TStringList;
  FDiagnosticReport: TList<TRealDiagnosticReportItem>;
  FMdns: TList<TRealMDNItem>;
  FMNs: TList<TRealBLANKA_MED_NAPRItem>;
  FImmuns: TList<TRealExamImmunizationItem>;
  FProfCards: TList<TRealKARTA_PROFILAKTIKA2017Item>;

  // нзис-ки работи
  ListNZIS_PLANNED_TYPEs: TList<TRealNZIS_PLANNED_TYPEItem>;

  Fpatient: TRealPatientNewItem;
  FDoctor: TRealDoctorItem;
  FDeput: TRealDoctorItem;
  FOwnerDoctor: TRealDoctorItem;
  FNode: PVirtualNode;
  FStreamNzis: TMemoryStream;
  FReqResps: TList<TReqResp>;

  constructor Create(Collection: TCollection); override;
  destructor Destroy; override;

  procedure CalcTypes(Abuf: Pointer; Aposdata: cardinal);
  procedure CalcPorpuse(Abuf: Pointer; Aposdata: cardinal);
  procedure RemoveDuplicateDiags;

  property Cl132: TObject read FCl132 write SetCl132;

  property PatID: Integer read FPatID write FPatID;
  property LRN: string read FLRN write SetLrn;
  property AMB_LISTN: Integer read FAMB_LISTN write FAMB_LISTN;
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

  property PREVENTIVE_TYPE: Integer read FPREVENTIVE_TYPE write SetPREVENTIVE_TYPE;

  property Porpuse[Abuf: Pointer; Aposdata: cardinal]: TLogicalPregledNew read GetPorpuse write SetPorpuse;

  property clcClass: TNzisPregledType read FclcClass;
  property clcPorpuse: TNzisPregledPorpuse read FclcPorpuse;
  property clcFinancingSource: TNZISFinancingSource read FclcFinancingSource;

  property RevisionsNodes: TList<PVirtualNode> read GetRevisions;


end;

TRealPregledNewColl = class(TPregledNewColl)
  private
    function GetItem(Index: Integer): TRealPregledNewItem;
    procedure SetItem(Index: Integer; const Value: TRealPregledNewItem);
  public
    FCollDiag: TRealDiagnosisColl;
    FCollDiagnRep: TRealDiagnosticReportColl;
    FCollProceduresPreg: TRealProceduresColl;
    FullPorpuse: set of TLogicalPregledNew;
    constructor Create(ItemClass: TCollectionItemClass);override;
    procedure SortByPatId;
    procedure SortByPatID_StartDate;
    procedure SortByPregledID;
    procedure SortByDoctorID;
    procedure SortByOwnerDoctorID;
    procedure SortByMainMkb;
    procedure SortByProcedureCodeOpis;
    function GetItemsFromDataPos(dataPos: Cardinal):TRealPregledNewItem;

    property Items[Index: Integer]: TRealPregledNewItem read GetItem write SetItem;
end;

TRealDoctorItem = class(TDoctorItem)
private
  FDoctorID: Integer;
  FFullName: string;
  FCert: TElX509Certificate;
  FTokenIsPlug: Boolean;
  FSlotTokenSerial: string;
    FSlotNom: Integer;
  function GetFullName: string;
  function GetDoctorID: Integer;
  procedure SetTokenIsPlug(const Value: Boolean);
    procedure SetCert(const Value: TElX509Certificate);
public
  node: PVirtualNode;
  FPatients: TList<TRealPatientNewItem>;
  FListUnfav: TList<TRealUnfavItem>;
  FListUnfavDB: TList<TRealUnfavItem>;
  CertStorage: TsbxCertificateStorage;
  constructor Create(Collection: TCollection); override;
  destructor destroy; override;
  property FullName: string read GetFullName;
  property DoctorID: Integer read GetDoctorID write FDoctorID;
  property Cert: TElX509Certificate read FCert write SetCert;
  property SlotNom: Integer read FSlotNom write FSlotNom;
  property SlotTokenSerial: string read FSlotTokenSerial write FSlotTokenSerial;
  property TokenIsPlug: Boolean read FTokenIsPlug write SetTokenIsPlug;

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
    procedure UpdateDoctors;
    function FindDoctorFromDataPos(dataPos: cardinal): TRealDoctorItem;

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

  TRealKARTA_PROFILAKTIKA2017Item = class(TKARTA_PROFILAKTIKA2017Item)
  private
    FPregledID: Integer;
    FCOLITIS64: boolean;
    FIMMUNOSUPPRESSED15: boolean;
    FANTIHIPERTENZIVNI67: boolean;
    FSEDENTARYLIFE02: boolean;
    FMENARCHE07: boolean;
    FDYSLIPIDAEMIA11: boolean;
    FBENIGNMAMMARY19: boolean;
    FPREDIABETIC10: boolean;
    FTYPE2DIABETES09: boolean;
    FFRUITSVEGETABLES66: boolean;
    FCOLORECTALCARCINOMA21: boolean;
    FCELIACDISEASE25: boolean;
    FISFULL: boolean;
    FHPVVAKSINA69: boolean;
    FRELATIVESBREAST33: boolean;
    FILLNESSIBS_MSB29: boolean;
    FPROSTATECARCINOMA38: boolean;
    FADENOMA61: boolean;
    FPROLONGEDHRT04: boolean;
    FDYNAMISMPSA28: boolean;
    FDIABETESRELATIVES31: boolean;
    FTYPE1DIABETES65: boolean;
    FCROHN63: boolean;
    FPREGNANCYCHILDBIRTH68: boolean;
    FIS_PRINTED: boolean;
    FWOMENCANCERS18: boolean;
    FDIABETESRELATIVESSECOND70: boolean;
    FPREGNANCY08: boolean;
    FNEOREKTOSIGMOIDE35: boolean;
    FPOLYP62: boolean;
    FNEOCERVIX32: boolean;
    procedure SetADENOMA61(const Value: boolean);
    procedure SetANTIHIPERTENZIVNI67(const Value: boolean);
    procedure SetBENIGNMAMMARY19(const Value: boolean);
    procedure SetCOLITIS64(const Value: boolean);
    procedure SetCOLORECTALCARCINOMA21(const Value: boolean);
    procedure SetCROHN63(const Value: boolean);
    procedure SetDIABETESRELATIVES31(const Value: boolean);
    procedure SetDIABETESRELATIVESSECOND70(const Value: boolean);
    procedure SetDYNAMISMPSA28(const Value: boolean);
    procedure SetDYSLIPIDAEMIA11(const Value: boolean);
    procedure SetFRUITSVEGETABLES66(const Value: boolean);
    procedure SetHPVVAKSINA69(const Value: boolean);
    procedure SetILLNESSIBS_MSB29(const Value: boolean);
    procedure SetIMMUNOSUPPRESSED15(const Value: boolean);
    procedure SetIS_PRINTED(const Value: boolean);
    procedure SetISFULL(const Value: boolean);
    procedure SetMENARCHE07(const Value: boolean);
    procedure SetNEOCERVIX32(const Value: boolean);
    procedure SetNEOREKTOSIGMOIDE35(const Value: boolean);
    procedure SetPOLYP62(const Value: boolean);
    procedure SetPREDIABETIC10(const Value: boolean);
    procedure SetPREGNANCY08(const Value: boolean);
    procedure SetPREGNANCYCHILDBIRTH68(const Value: boolean);
    procedure SetPROLONGEDHRT04(const Value: boolean);
    procedure SetPROSTATECARCINOMA38(const Value: boolean);
    procedure SetRELATIVESBREAST33(const Value: boolean);
    procedure SetSEDENTARYLIFE02(const Value: boolean);
    procedure SetTYPE1DIABETES65(const Value: boolean);
    procedure SetTYPE2DIABETES09(const Value: boolean);
    procedure SetWOMENCANCERS18(const Value: boolean);

  public
    property PregledID: Integer read FPregledID write FPregledID;
    property ADENOMA61: boolean read FADENOMA61 write SetADENOMA61;
    property ANTIHIPERTENZIVNI67: boolean read FANTIHIPERTENZIVNI67 write SetANTIHIPERTENZIVNI67;
    property BENIGNMAMMARY19: boolean read FBENIGNMAMMARY19 write SetBENIGNMAMMARY19;
    property CELIACDISEASE25: boolean read FCELIACDISEASE25 write FCELIACDISEASE25;
    property COLORECTALCARCINOMA21: boolean read FCOLORECTALCARCINOMA21 write SetCOLORECTALCARCINOMA21;
    property CROHN63: boolean read FCROHN63 write SetCROHN63;
    property DIABETESRELATIVES31: boolean read FDIABETESRELATIVES31 write SetDIABETESRELATIVES31;
    property DIABETESRELATIVESSECOND70: boolean read FDIABETESRELATIVESSECOND70 write SetDIABETESRELATIVESSECOND70;
    property DYNAMISMPSA28: boolean read FDYNAMISMPSA28 write SetDYNAMISMPSA28;
    property DYSLIPIDAEMIA11: boolean read FDYSLIPIDAEMIA11 write SetDYSLIPIDAEMIA11;
    property FRUITSVEGETABLES66: boolean read FFRUITSVEGETABLES66 write SetFRUITSVEGETABLES66;
    property HPVVAKSINA69: boolean read FHPVVAKSINA69 write SetHPVVAKSINA69;
    property ILLNESSIBS_MSB29: boolean read FILLNESSIBS_MSB29 write SetILLNESSIBS_MSB29;
    property IMMUNOSUPPRESSED15: boolean read FIMMUNOSUPPRESSED15 write SetIMMUNOSUPPRESSED15;
    property ISFULL: boolean read FISFULL write SetISFULL;
    property COLITIS64: boolean read FCOLITIS64  write SetCOLITIS64;
    property IS_PRINTED: boolean read FIS_PRINTED write SetIS_PRINTED;
    property MENARCHE07: boolean read FMENARCHE07 write SetMENARCHE07;
    property NEOCERVIX32: boolean read FNEOCERVIX32 write SetNEOCERVIX32;
    property NEOREKTOSIGMOIDE35: boolean read FNEOREKTOSIGMOIDE35 write SetNEOREKTOSIGMOIDE35;
    property POLYP62: boolean read FPOLYP62 write SetPOLYP62;
    property PREDIABETIC10: boolean read FPREDIABETIC10 write SetPREDIABETIC10;
    property PREGNANCY08: boolean read FPREGNANCY08 write SetPREGNANCY08;
    property PREGNANCYCHILDBIRTH68: boolean read FPREGNANCYCHILDBIRTH68 write SetPREGNANCYCHILDBIRTH68;
    property PROLONGEDHRT04: boolean read FPROLONGEDHRT04 write SetPROLONGEDHRT04;
    property PROSTATECARCINOMA38: boolean read FPROSTATECARCINOMA38 write SetPROSTATECARCINOMA38;
    property RELATIVESBREAST33: boolean  read FRELATIVESBREAST33 write SetRELATIVESBREAST33;
    property SEDENTARYLIFE02: boolean read FSEDENTARYLIFE02 write SetSEDENTARYLIFE02;
    property TYPE1DIABETES65: boolean read FTYPE1DIABETES65 write SetTYPE1DIABETES65;
    property TYPE2DIABETES09: boolean read FTYPE2DIABETES09 write SetTYPE2DIABETES09;
    property WOMENCANCERS18: boolean read FWOMENCANCERS18 write SetWOMENCANCERS18;
  end;

  TRealKARTA_PROFILAKTIKA2017Coll = class(TKARTA_PROFILAKTIKA2017Coll)
  private
    function GetItem(Index: Integer): TRealKARTA_PROFILAKTIKA2017Item;
    procedure SetItem(Index: Integer; const Value: TRealKARTA_PROFILAKTIKA2017Item);

  public
    procedure SortByPregID;
    property Items[Index: Integer]: TRealKARTA_PROFILAKTIKA2017Item read GetItem write SetItem;
  end;

  TRealBLANKA_MED_NAPRItem = class(TBLANKA_MED_NAPRItem)
  private
    FPregledID: Integer;
    FLinkNode: PVirtualNode;
    FSpecNzis: string;

  public
    FDiagnosis: TList<TRealDiagnosisItem>;
    FPregled: TRealPregledNewItem;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    property PregledID: Integer read FPregledID write FPregledID;
    property SpecNzis: string read FSpecNzis write FSpecNzis;
    property LinkNode: PVirtualNode read FLinkNode write FLinkNode;

  end;

  TRealBLANKA_MED_NAPRColl = class(TBLANKA_MED_NAPRColl)
  private
    function GetItem(Index: Integer): TRealBLANKA_MED_NAPRItem;
    procedure SetItem(Index: Integer; const Value: TRealBLANKA_MED_NAPRItem);

  public
    procedure SortByPregID;
    procedure SortBySpecNzis;
    function GetItemsFromDataPos(dataPos: Cardinal):TRealBLANKA_MED_NAPRItem;
    property Items[Index: Integer]: TRealBLANKA_MED_NAPRItem read GetItem write SetItem;
  end;

  TRealNZIS_PLANNED_TYPEItem = class(TNZIS_PLANNED_TYPEItem)
  private
    FPregledID: Integer;
    FEndDate: TDate;
    FStartDate: TDate;
    FStatus: Word;
    FCl136: Integer;
    FCl132Key: string;
    FCl132Pos: Cardinal;
    FNode: PVirtualNode;
    function GetIsNzisPregled: Boolean;

  public
    property PregledID: Integer read FPregledID write FPregledID;
    property StartDate: TDate read FStartDate write FStartDate;
    property EndDate: TDate read FEndDate write FEndDate;
    property Status: Word read FStatus write Fstatus;
    property Cl136: Integer read FCl136 write FCl136;
    property CL132Key: string read FCl132Key write FCl132Key;
    property CL132Pos: Cardinal read FCl132Pos write FCl132Pos;
    property Node: PVirtualNode read FNode write FNode;
    property IsNzisPregled: Boolean read GetIsNzisPregled;
  end;

  TRealNZIS_PLANNED_TYPEColl = class(TNZIS_PLANNED_TYPEColl)
  private
    function GetItem(Index: Integer): TRealNZIS_PLANNED_TYPEItem;
    procedure SetItem(Index: Integer; const Value: TRealNZIS_PLANNED_TYPEItem);

  public
    procedure SortByPregID;
    procedure SortListByEndDate_posData_cl136( lst: TList<TRealNZIS_PLANNED_TYPEItem>);
    property Items[Index: Integer]: TRealNZIS_PLANNED_TYPEItem read GetItem write SetItem;
  end;

  TRealNZIS_QUESTIONNAIRE_RESPONSEItem = class(TNZIS_QUESTIONNAIRE_RESPONSEItem)
  private
  public
  end;

  TRealNZIS_QUESTIONNAIRE_RESPONSEColl = class(TNZIS_QUESTIONNAIRE_RESPONSEColl)
  private
    function GetItem(Index: Integer): TRealNZIS_QUESTIONNAIRE_RESPONSEItem;
    procedure SetItem(Index: Integer; const Value: TRealNZIS_QUESTIONNAIRE_RESPONSEItem);

  public
    property Items[Index: Integer]: TRealNZIS_QUESTIONNAIRE_RESPONSEItem read GetItem write SetItem;
  end;

  TRealNZIS_QUESTIONNAIRE_ANSWERItem = class(TNZIS_QUESTIONNAIRE_ANSWERItem)
  private
    Fcl134: TCl134Item;
    Fcl028: Integer;
  public
    //FAnswerValues: TList<TRealNZIS_ANSWER_VALUEItem>;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    property cl134: TCl134Item read Fcl134 write Fcl134;
    property cl028: Integer read Fcl028 write Fcl028;
  end;

  TRealNZIS_QUESTIONNAIRE_ANSWERColl = class(TNZIS_QUESTIONNAIRE_ANSWERColl)
  private
    function GetItem(Index: Integer): TRealNZIS_QUESTIONNAIRE_ANSWERItem;
    procedure SetItem(Index: Integer; const Value: TRealNZIS_QUESTIONNAIRE_ANSWERItem);

  public
    property Items[Index: Integer]: TRealNZIS_QUESTIONNAIRE_ANSWERItem read GetItem write SetItem;
  end;

  TRealNZIS_ANSWER_VALUEItem = class(TNZIS_ANSWER_VALUEItem)
  private

  public
   procedure InsertNZIS_ANSWER_VALUE; override;
  end;

  TRealNZIS_ANSWER_VALUEColl = class(TNZIS_ANSWER_VALUEColl)
  private
    function GetItem(Index: Integer): TRealNZIS_ANSWER_VALUEItem;
    procedure SetItem(Index: Integer; const Value: TRealNZIS_ANSWER_VALUEItem);

  public
    procedure UpdateNZIS_ANSWER_VALUEs;
    property Items[Index: Integer]: TRealNZIS_ANSWER_VALUEItem read GetItem write SetItem;
  end;

  TRealNZIS_DIAGNOSTIC_REPORTItem = class(TNZIS_DIAGNOSTIC_REPORTItem)
  private
  public

  end;

  TRealNZIS_DIAGNOSTIC_REPORTColl = class(TNZIS_DIAGNOSTIC_REPORTColl)
  private
    function GetItem(Index: Integer): TRealNZIS_DIAGNOSTIC_REPORTItem;
    procedure SetItem(Index: Integer; const Value: TRealNZIS_DIAGNOSTIC_REPORTItem);

  public
    property Items[Index: Integer]: TRealNZIS_DIAGNOSTIC_REPORTItem read GetItem write SetItem;
  end;

  TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem = class(TNZIS_RESULT_DIAGNOSTIC_REPORTItem)
  private
    Fcl028: Integer;
  public
    property cl028: Integer read Fcl028 write Fcl028;

  end;

  TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl = class(TNZIS_RESULT_DIAGNOSTIC_REPORTColl)
  private
    function GetItem(Index: Integer): TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
    procedure SetItem(Index: Integer; const Value: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem);

  public
    procedure UpdateRESULT_DIAGNOSTIC_REPORT;
    property Items[Index: Integer]: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem read GetItem write SetItem;
  end;


implementation

{ TRealPregledColl }



{ TRealPregledNewColl }

constructor TRealPregledNewColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  FullPorpuse :=
   [TLogicalPregledNew.IS_CONSULTATION,
    TLogicalPregledNew.IS_DISPANSERY,
    TLogicalPregledNew.IS_EXPERTIZA,
    TLogicalPregledNew.IS_RECEPTA_HOSPIT,
    TLogicalPregledNew.IS_RISK_GROUP,
    TLogicalPregledNew.IS_TELK,
    TLogicalPregledNew.IS_VSD,
    TLogicalPregledNew.IS_PREVENTIVE,
    TLogicalPregledNew.IS_PREVENTIVE_Maternal,
    TLogicalPregledNew.IS_PREVENTIVE_Childrens,
    TLogicalPregledNew.IS_PREVENTIVE_Adults,
    TLogicalPregledNew.IS_Screening];
end;

function TRealPregledNewColl.GetItem(Index: Integer): TRealPregledNewItem;
begin
  Result := TRealPregledNewItem(inherited GetItem(Index));
end;

function TRealPregledNewColl.GetItemsFromDataPos(
  dataPos: Cardinal): TRealPregledNewItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].DataPos = dataPos then
    begin
      Result := Items[i];
      Break;
    end;
  end;
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

procedure TRealPatientNewColl.Added(var Item: TCollectionItem);
begin
  inherited;

end;

constructor TRealPatientNewColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
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

procedure TRealPatientNewColl.Deleting(Item: TCollectionItem);
begin
  inherited;

end;

destructor TRealPatientNewColl.destroy;
begin
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
  FListCurrentImun := TList<TGraphPeriod132>.Create;
  CurrentGraphIndex := -1;
  FRevisions := TList<TRevision>.Create;
end;

destructor TRealPatientNewItem.destroy;
begin
  FreeAndNil(FPregledi);
  FreeAndNil(FEventsPat);
  FreeAndNil(lstGraph);
  FreeAndNil(FListCurrentImun);
  FreeAndNil(FClonings);
  FreeAndNil(FExamAnals);
  FreeAndNil(FRevisions);
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

procedure TRealPregledNewItem.CalcPorpuse(Abuf: Pointer; Aposdata: cardinal);
var
  log: TlogicalPregledNewSet;
begin
  log := TlogicalPregledNewSet(self.getLogical40Map(Abuf, Aposdata, word(PregledNew_Logical)));



end;

procedure TRealPregledNewItem.CalcTypes(Abuf: Pointer; Aposdata: cardinal);
var
  log: TlogicalPregledNewSet;
begin
  log := TlogicalPregledNewSet(self.getLogical40Map(Abuf, Aposdata, word(PregledNew_Logical)));
  if TLogicalPregledNew.IS_AMB_PR in log then FclcClass := ptAMB
  else if TLogicalPregledNew.IS_DOM_PR in log then FclcClass := ptHH
  else if TLogicalPregledNew.IS_DOM_PR in log then FclcClass := ptHH
  else if TLogicalPregledNew.IS_DISPANSERY in log then FclcClass := ptIMP
  else
  if TLogicalPregledNew.IS_PREVENTIVE_Childrens in log then
  begin;
    FclcClass := ptAMB;
    FclcPorpuse := ppChildrensHealth;
  end
  else
  if TLogicalPregledNew.IS_PREVENTIVE_Adults in log then
  begin
    FclcClass := ptAMB;
    FclcPorpuse := ppPreventionAdults;
  end
  else if TLogicalPregledNew.IS_PREVENTIVE_Maternal in log then
  begin
    FclcClass := ptAMB;
    FclcPorpuse := ppMaternalHealth;
  end

  ;

  FclcFinancingSource := fsNHIF;
  //if TLogicalPregledNew.pay in log then FclcFinancingSource := fsNHIF  // zzzzzzzzzzzzzzzzzz има още
  //else FclcFinancingSource := fsPatient;

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
  FMNs := TList<TRealBLANKA_MED_NAPRItem>.Create;
  FImmuns := TList<TRealExamImmunizationItem>.create;
  FProfCards := TList<TRealKARTA_PROFILAKTIKA2017Item>.create;

  ListNZIS_PLANNED_TYPEs := TList<TRealNZIS_PLANNED_TYPEItem>.create;

  FDoctor := nil;
  FOwnerDoctor := nil;
  FDeput := nil;
  FStreamNzis := TMemoryStream.Create;
  FReqResps := TList<TReqResp>.Create;

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
  FreeAndNil(FMns);
  FreeAndNil(FImmuns);
  FreeAndNil(FProfCards);
  FreeAndNil(ListNZIS_PLANNED_TYPEs);
  FreeAndNil(FStreamNzis);
  FreeAndNil(FReqResps);
  inherited;
end;



function TRealPregledNewItem.GetPorpuse(Abuf: Pointer; Aposdata: cardinal): TLogicalPregledNew;
var
  full, Res: TlogicalPregledNewSet;
  log: TlogicalPregledNewSet;
  cnt: Integer;
begin
  log := TlogicalPregledNewSet(self.getLogical40Map(Abuf, Aposdata, word(PregledNew_Logical)));
  if Collection <> nil then
  begin
    full := TRealPregledNewColl(Collection).FullPorpuse;
  end
  else
  begin
    full :=
   [TLogicalPregledNew.IS_CONSULTATION,
    TLogicalPregledNew.IS_DISPANSERY,
    TLogicalPregledNew.IS_EXPERTIZA,
    TLogicalPregledNew.IS_RECEPTA_HOSPIT,
    TLogicalPregledNew.IS_RISK_GROUP,
    TLogicalPregledNew.IS_TELK,
    TLogicalPregledNew.IS_VSD,
    TLogicalPregledNew.IS_PREVENTIVE,
    TLogicalPregledNew.IS_PREVENTIVE_Maternal,
    TLogicalPregledNew.IS_PREVENTIVE_Childrens,
    TLogicalPregledNew.IS_PREVENTIVE_Adults,
    TLogicalPregledNew.IS_Screening];
  end;
  Res := log * full;
  Res := Res - [TLogicalPregledNew.IS_PREVENTIVE];
  cnt := 0;
  for Result in  res do
  begin
    inc(cnt);
  end;
end;

function TRealPregledNewItem.GetRevisions: TList<PVirtualNode>;
var
  run: PVirtualNode;
  data: PAspRec;
begin
  Result := TList<PVirtualNode>.Create;
  run := FNode.FirstChild;
  while run <> nil do
  begin
    Data := Pointer(PByte(run) + lenNode);
    if data.vid in [vvPatientRevision] then
    begin
      Result.Add(run);
    end;
    run := run.NextSibling;
  end;
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

procedure TRealPregledNewItem.RemoveDuplicateDiags;
begin
  //Self.FDiagnosis.Sort
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

procedure TRealPregledNewItem.SetLrn(const Value: string);
var
  arrStr: TArray<string>;
begin
  FLRN := Value;
  arrStr := FLRN.Split(['-']);
  if Length(arrStr) < 3 then
  begin
    AMB_LISTN := 1;
    Exit;
  end;
  try
    AMB_LISTN := StrToIntDef(arrStr[2], 1);
  except

  end;
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

procedure TRealPregledNewItem.SetPorpuse(Abuf: Pointer; Aposdata: cardinal; const Value: TLogicalPregledNew);
begin

end;

procedure TRealPregledNewItem.SetPREVENTIVE_TYPE(const Value: Integer);
begin
  FPREVENTIVE_TYPE := Value;
  case FPREVENTIVE_TYPE of
    1: Include(self.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Childrens);
    2: Include(self.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Adults);
    3: Include(self.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Maternal);
  end;
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

function TRealMDNColl.GetItemsFromDataPos(dataPos: Cardinal): TRealMDNItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].DataPos = dataPos then
    begin
      Result := Items[i];
      Break;
    end;
  end;
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
  FCert := nil;// TElX509Certificate.Create(nil);
end;

destructor TRealDoctorItem.destroy;
begin
  if Self.CertStorage <> nil then
  begin
    FreeAndNil(Self.CertStorage);
  end;
  FreeAndNil(FListUnfav);
  FreeAndNil(FListUnfavDB);
  if FCert <> nil then
    FreeAndNil(FCert);
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

procedure TRealDoctorItem.SetCert(const Value: TElX509Certificate);
begin
  FCert := Value;
end;

procedure TRealDoctorItem.SetTokenIsPlug(const Value: Boolean);
begin
  FTokenIsPlug := Value;
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

function TRealDoctorColl.FindDoctorFromDataPos(dataPos: cardinal): TRealDoctorItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if dataPos = Items[i].DataPos then
    begin
      Result := Items[i];
      Exit;
    end;
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

procedure TRealDoctorColl.UpdateDoctors;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  doc: TRealDoctorItem;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    doc := Items[i];
    if doc.PRecord <> nil then
    begin
      doc.SaveDoctor(dataPosition);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
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

function TRealExamAnalysisColl.GetItemsFromDataPos(dataPos: Cardinal): TRealExamAnalysisItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].DataPos = dataPos then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

procedure TRealExamAnalysisColl.SetItem(Index: Integer; const Value: TRealExamAnalysisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealExamAnalysisColl.SortByAnalID;
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
        while (Items[I]).FAnalID < (Items[P]).FAnalID do Inc(I);
        while (Items[J]).FAnalID > (Items[P]).FAnalID do Dec(J);
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

procedure TRealExamAnalysisColl.SortByCl022;
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
        while (Items[I]).FCl022 < (Items[P]).FCl022 do Inc(I);
        while (Items[J]).FCl022 > (Items[P]).FCl022 do Dec(J);
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


{ TRealKARTA_PROFILAKTIKA2017Coll }

function TRealKARTA_PROFILAKTIKA2017Coll.GetItem(
  Index: Integer): TRealKARTA_PROFILAKTIKA2017Item;
begin
  Result := TRealKARTA_PROFILAKTIKA2017Item(inherited GetItem(Index));
end;

procedure TRealKARTA_PROFILAKTIKA2017Coll.SetItem(Index: Integer;
  const Value: TRealKARTA_PROFILAKTIKA2017Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealKARTA_PROFILAKTIKA2017Coll.SortByPregID;
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

{ TRealKARTA_PROFILAKTIKA2017Item }

procedure TRealKARTA_PROFILAKTIKA2017Item.SetADENOMA61(const Value: boolean);
begin
  FADENOMA61 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.ADENOMA61);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetANTIHIPERTENZIVNI67(
  const Value: boolean);
begin
  FANTIHIPERTENZIVNI67 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.ANTIHIPERTENZIVNI67);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetBENIGNMAMMARY19(
  const Value: boolean);
begin
  FBENIGNMAMMARY19 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.BENIGNMAMMARY19);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetCOLITIS64(const Value: boolean);
begin
  FCOLITIS64 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.COLITIS64);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetCOLORECTALCARCINOMA21(
  const Value: boolean);
begin
  FCOLORECTALCARCINOMA21 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.COLORECTALCARCINOMA21);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetCROHN63(const Value: boolean);
begin
  FCROHN63 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.CROHN63);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetDIABETESRELATIVES31(
  const Value: boolean);
begin
  FDIABETESRELATIVES31 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.DIABETESRELATIVES31);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetDIABETESRELATIVESSECOND70(
  const Value: boolean);
begin
  FDIABETESRELATIVESSECOND70 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.DIABETESRELATIVESSECOND70);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetDYNAMISMPSA28(
  const Value: boolean);
begin
  FDYNAMISMPSA28 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.DYNAMISMPSA28);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetDYSLIPIDAEMIA11(
  const Value: boolean);
begin
  FDYSLIPIDAEMIA11 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.DYSLIPIDAEMIA11);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetFRUITSVEGETABLES66(
  const Value: boolean);
begin
  FFRUITSVEGETABLES66 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.FRUITSVEGETABLES66);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetHPVVAKSINA69(const Value: boolean);
begin
  FHPVVAKSINA69 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.HPVVAKSINA69);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetILLNESSIBS_MSB29(
  const Value: boolean);
begin
  FILLNESSIBS_MSB29 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.ILLNESSIBS_MSB29);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetIMMUNOSUPPRESSED15(
  const Value: boolean);
begin
  FIMMUNOSUPPRESSED15 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.IMMUNOSUPPRESSED15);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetISFULL(const Value: boolean);
begin
  FISFULL := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.ISFULL);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetIS_PRINTED(const Value: boolean);
begin
  FIS_PRINTED := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.IS_PRINTED);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetMENARCHE07(const Value: boolean);
begin
  FMENARCHE07 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.MENARCHE07);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetNEOCERVIX32(const Value: boolean);
begin
  FNEOCERVIX32 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.NEOCERVIX32);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetNEOREKTOSIGMOIDE35(
  const Value: boolean);
begin
  FNEOREKTOSIGMOIDE35 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.NEOREKTOSIGMOIDE35);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetPOLYP62(const Value: boolean);
begin
  FPOLYP62 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.POLYP62);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetPREDIABETIC10(
  const Value: boolean);
begin
  FPREDIABETIC10 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.PREDIABETIC10);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetPREGNANCY08(const Value: boolean);
begin
  FPREGNANCY08 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.PREGNANCY08);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetPREGNANCYCHILDBIRTH68(
  const Value: boolean);
begin
  FPREGNANCYCHILDBIRTH68 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.PREGNANCYCHILDBIRTH68);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetPROLONGEDHRT04(
  const Value: boolean);
begin
  FPROLONGEDHRT04 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.PROLONGEDHRT04);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetPROSTATECARCINOMA38(
  const Value: boolean);
begin
  FPROSTATECARCINOMA38 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.PROSTATECARCINOMA38);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetRELATIVESBREAST33(
  const Value: boolean);
begin
  FRELATIVESBREAST33 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.RELATIVESBREAST33);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetSEDENTARYLIFE02(
  const Value: boolean);
begin
  FSEDENTARYLIFE02 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.SEDENTARYLIFE02);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetTYPE1DIABETES65(
  const Value: boolean);
begin
  FTYPE1DIABETES65 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.TYPE1DIABETES65);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetTYPE2DIABETES09(
  const Value: boolean);
begin
  FTYPE2DIABETES09 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.TYPE2DIABETES09);
end;

procedure TRealKARTA_PROFILAKTIKA2017Item.SetWOMENCANCERS18(
  const Value: boolean);
begin
  FWOMENCANCERS18 := Value;
  if Value then
    Include(self.PRecord.Logical, TLogicalKARTA_PROFILAKTIKA2017.WOMENCANCERS18);
end;

{ TRealBLANKA_MED_NAPRColl }

procedure TRealBLANKA_MED_NAPRColl.SortBySpecNzis;
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
        while (Items[I]).FSpecNzis < (Items[P]).FSpecNzis do Inc(I);
        while (Items[J]).FSpecNzis > (Items[P]).FSpecNzis do Dec(J);
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

function TRealBLANKA_MED_NAPRColl.GetItem(
  Index: Integer): TRealBLANKA_MED_NAPRItem;
begin
  Result := TRealBLANKA_MED_NAPRItem(inherited GetItem(Index));
end;

function TRealBLANKA_MED_NAPRColl.GetItemsFromDataPos(
  dataPos: Cardinal): TRealBLANKA_MED_NAPRItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].DataPos = dataPos then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

procedure TRealBLANKA_MED_NAPRColl.SetItem(Index: Integer;
  const Value: TRealBLANKA_MED_NAPRItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealBLANKA_MED_NAPRColl.SortByPregID;
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

{ TReaNZIS_PLANNED_TYPEColl }

function TRealNZIS_PLANNED_TYPEColl.GetItem(
  Index: Integer): TRealNZIS_PLANNED_TYPEItem;
begin
  Result := TRealNZIS_PLANNED_TYPEItem(inherited GetItem(Index));
end;

procedure TRealNZIS_PLANNED_TYPEColl.SetItem(Index: Integer;
  const Value: TRealNZIS_PLANNED_TYPEItem);
begin
  inherited SetItem(Index, Value);
end;



procedure TRealNZIS_PLANNED_TYPEColl.SortByPregID;
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

procedure TRealNZIS_PLANNED_TYPEColl.SortListByEndDate_posData_cl136( lst: TList<TRealNZIS_PLANNED_TYPEItem>);

  function conditionI(i, p: integer): Boolean;
  begin
    if lst[i].EndDate <> lst[P].EndDate then
      Result := lst[i].EndDate < lst[P].EndDate
    else
    if lst[i].FCl136 <> lst[P].FCl136 then
      Result := lst[i].FCl136 < lst[P].FCl136
    else
      Result := lst[i].DataPos < lst[P].DataPos;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if lst[j].EndDate <> lst[P].EndDate then
      Result := lst[j].EndDate > lst[P].EndDate
    else
    if lst[j].FCl136 <> lst[P].FCl136 then
      Result := lst[j].FCl136 > lst[P].FCl136
    else
      Result := lst[j].DataPos > lst[P].DataPos;
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TRealNZIS_PLANNED_TYPEItem;
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
          Save := lst.Items[I];
          lst.Items[I] := lst.Items[J];
          lst.Items[J] := Save;
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
  if (lst.count >1 ) then
  begin
    QuickSort(0,lst.count-1);
  end;
end;


{ TReaNZIS_QUESTIONNAIRE_RESPONSEColl }

function TRealNZIS_QUESTIONNAIRE_RESPONSEColl.GetItem(
  Index: Integer): TRealNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  Result := TRealNZIS_QUESTIONNAIRE_RESPONSEItem(inherited GetItem(Index));
end;

procedure TRealNZIS_QUESTIONNAIRE_RESPONSEColl.SetItem(Index: Integer;
  const Value: TRealNZIS_QUESTIONNAIRE_RESPONSEItem);
begin
  inherited SetItem(Index, Value);
end;

{ TReaNZIS_QUESTIONNAIRE_ANSWERColl }

function TRealNZIS_QUESTIONNAIRE_ANSWERColl.GetItem(
  Index: Integer): TRealNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  Result := TRealNZIS_QUESTIONNAIRE_ANSWERItem(inherited GetItem(Index));
end;

procedure TRealNZIS_QUESTIONNAIRE_ANSWERColl.SetItem(Index: Integer;
  const Value: TRealNZIS_QUESTIONNAIRE_ANSWERItem);
begin
  inherited SetItem(Index, Value);
end;

{ TReaNZIS_ANSWER_VALUEColl }

function TRealNZIS_ANSWER_VALUEColl.GetItem(
  Index: Integer): TRealNZIS_ANSWER_VALUEItem;
begin
  Result := TRealNZIS_ANSWER_VALUEItem(inherited GetItem(Index));
end;

procedure TRealNZIS_ANSWER_VALUEColl.SetItem(Index: Integer;
  const Value: TRealNZIS_ANSWER_VALUEItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealNZIS_ANSWER_VALUEColl.UpdateNZIS_ANSWER_VALUEs;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  valAnsw: TRealNZIS_ANSWER_VALUEItem;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    valAnsw := Items[i];
    if valAnsw.PRecord <> nil then
    begin
      valAnsw.SaveNZIS_ANSWER_VALUE(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealNZIS_DIAGNOSTIC_REPORTColl }

function TRealNZIS_DIAGNOSTIC_REPORTColl.GetItem(
  Index: Integer): TRealNZIS_DIAGNOSTIC_REPORTItem;
begin
  Result := TRealNZIS_DIAGNOSTIC_REPORTItem(inherited GetItem(Index));
end;

procedure TRealNZIS_DIAGNOSTIC_REPORTColl.SetItem(Index: Integer;
  const Value: TRealNZIS_DIAGNOSTIC_REPORTItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl }

function TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetItem(
  Index: Integer): TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  Result := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(inherited GetItem(Index));
end;

procedure TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.SetItem(Index: Integer;
  const Value: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.UpdateRESULT_DIAGNOSTIC_REPORT;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  RESULT_DIAGNOSTIC_REPORT: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    RESULT_DIAGNOSTIC_REPORT := Items[i];
    if RESULT_DIAGNOSTIC_REPORT.PRecord <> nil then
    begin
      RESULT_DIAGNOSTIC_REPORT.SaveNZIS_RESULT_DIAGNOSTIC_REPORT(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealNZIS_QUESTIONNAIRE_ANSWERItem }

constructor TRealNZIS_QUESTIONNAIRE_ANSWERItem.Create(Collection: TCollection);
var
  i: Integer;
begin
  inherited;
  //FAnswerValues := TList<TRealNZIS_ANSWER_VALUEItem>.Create;
//  for i := 0 to 20 do
//    FAnswerValues.Add(nil);
end;

destructor TRealNZIS_QUESTIONNAIRE_ANSWERItem.destroy;
begin
  //FreeAndNil(FAnswerValues);
  inherited;
end;

{ TRealNZIS_ANSWER_VALUEItem }

procedure TRealNZIS_ANSWER_VALUEItem.InsertNZIS_ANSWER_VALUE;
begin
  inherited;
  if TBaseCollection(Collection).CmdFile <> nil then
  begin
    TBaseCollection(Collection).streamComm.Len := TBaseCollection(Collection).streamComm.Size;
    TBaseCollection(Collection).CmdFile.CopyFrom(TBaseCollection(Collection).streamComm, 0);
  end;
end;

{ TRealNZIS_PLANNED_TYPEItem }

function TRealNZIS_PLANNED_TYPEItem.GetIsNzisPregled: Boolean;
begin

end;

{ TRealBLANKA_MED_NAPRItem }

constructor TRealBLANKA_MED_NAPRItem.Create(Collection: TCollection);
begin
  inherited;
  FDiagnosis := TList<TRealDiagnosisItem>.Create;
end;

destructor TRealBLANKA_MED_NAPRItem.destroy;
begin
  FreeAndNil(FDiagnosis);
  inherited;
end;

{ TRealExamImmunizationItem }

constructor TRealExamImmunizationItem.Create(Collection: TCollection);
begin
  inherited;
  FDiagnosis := TList<TRealDiagnosisItem>.Create;
end;

destructor TRealExamImmunizationItem.destroy;
begin
  FreeAndNil(FDiagnosis);
  inherited;
end;

{ TRealExamImmunizationColl }

function TRealExamImmunizationColl.GetItem(Index: Integer): TRealExamImmunizationItem;
begin
  Result := TRealExamImmunizationItem(inherited GetItem(Index));
end;

function TRealExamImmunizationColl.GetItemsFromDataPos(
  dataPos: Cardinal): TRealExamImmunizationItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].DataPos = dataPos then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

procedure TRealExamImmunizationColl.SetItem(Index: Integer;
  const Value: TRealExamImmunizationItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealExamImmunizationColl.SortByPregID;
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

{ TReqResp }

constructor TReqResp.Create;
begin
  inherited;
  req := TStringList.Create;
  resp := TStringList.Create;
end;

destructor TReqResp.destroy;
begin
  req.Free;
  resp.Free;
  inherited;
end;

end.
