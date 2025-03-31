unit Nzis.Types;

interface
uses
  System.SysUtils, Xml.XMLDoc, Xml.xmldom, Winapi.msxml, Winapi.Messages;


  const
    WM_IS_FILED_TO_NZIS = WM_USER + 12;// '¬ече има подаден преглед с този номер'
    WM_OPENED = WM_USER + 13;
    WM_CLOSE_SPEC_FORM = WM_USER + 14;
    WM_ERR_TOKEN = WM_USER + 15;
    WM_CLOSE_NRN_FORM = WM_USER + 16;
    WM_OPTION_ONE_DAY = WM_USER + 17;
    WM_GET_NZIS_CL22KEY = WM_USER + 18;




type
  TOnResponsePregFromNZIS = procedure(preg, PregMessage: TObject) of object;
  TOnResponseMDNFromNZIS = procedure(MDN, MDNMessage: TObject) of object;

  tmessageType = (NNNN=0,
                  C001=825241667, C003=858796099, C005=892350531, C007=925904963, C009=959459395,
                  C011=825307203, C013=858861635, C015=892416067, C041=825503811, C023=0,
                  C045=892612675,
                  X001=825241688, X003=858796120, X005=892350552, X007=925904984, X009=959459416,
                  X011=825307224, X013=858861656,
                  R001=825241682, R003=858796114, R005=892350546, R007=925904978, R009=959459410,
                  R011=825307218, R015=892416082, R017=925970514,
                  I001=825241673, I003=858796105, I005=892350537, I007=925904969, I009=959459401,
                  I011=825307209, I013=858861641,
                  P001=825241680, P003=858796112, P005=892350544, P007=925904976, P009=959459408,
                  P011=825307216, P013=858861648, P015=892416080,
                  H001=825241672, H011= 825307208);

  TReasonGenX00All = (rgXSendNzis, rgXSignOnly, rgXSendPrevSign);
  TReasonGenR00All = (rgRSendNzis, rgRSignOnly, rgRSendPrevSign);

  TGetTokenNZIS =  function (serNum: PAnsiChar; isTest: Boolean): PAnsiChar; stdcall;
  TSendXmlToNZIS = function(URL,  Token, XMLtoSend, serNum: PAnsiChar; isTest: Boolean): PAnsiChar; stdcall;
  TSignXmlForNZIS = function(XMLtoSign, serNum: PAnsiChar): PAnsiChar; stdcall;
  TSendSignedXmlToNZIS = function(URL,  Token, XMLtoSend, serNum: PAnsiChar; isTest: Boolean): PAnsiChar; stdcall;
  TVidNode = (vnDoctorRoot, vnPregledRoot, vnPacientRoot,
            vnDoctor, vnPregled, vnPacient, vnDocs,
            vnDeputRoot, vnDeput, vnDeputPeriod,
            vnMDDRoot, vnMddPack, vnMDD, vnAnal);

  PNodeRec = ^TNodeRec;
  TNodeRec = record
    index: Integer;
    vid: TVidNode;
  end;


  TVidDocument = (vdImmun, vdMDN, vdEmdn, vdFreeRec, vdExamLkk,
                  vdNaprTelk, vdFastNot, vdMedBel, vdEBL, vdMN, vdMN3, vdHosp,
                  vdPresc,
                  vdNone = 1000);

  TidentifierTypeBaseCL004 = (itbEGN=1, itbLNZ=2, itbSSN=3, itbPASS=4, itbOther=5, itbNBN=6);
  TGenderBase = (gbMale=1, gbFemale=2, gbOther=3, gbUnknown=4);
  TPregledType = (ptAMB=1, ptEMER=2, ptFLD=3, ptHH=4, ptIMP=5, ptOBSENC=6, ptPRENC=7, ptSS=8, ptVR=9);
  TFinancingSource = (fsMZ=1, fsNHIF=2, fsFund=3, fsPatient=4, fsBudget=5, fsNOI=6, fsBEZ=7);

  TPurposeBase =  (pbConsult=1, pbProf=2, pbChildHealthcare=3, pbMotherHealthcare=4, pbProfFrom18=5,
                   pbProfRisk=6, pbDisp=7, pbVSD=8, pbHosp=9, pbExpert=10, pbTelk=11, pbSkrining=12);
  TDiagnosisUseBase = (dubAdmission=1, dubDischarge=2, dubChiefComplaint=3, dubComorbidity=4, dubPre_op=5,
                       dubPost_op=6, dubBilling=7);
  TDiagnosisClinicalStatusBase = (dcsActive=10, dcsRecurrence=11, dcsRelapse=12, dcsInactive=20, dcsRemission=21, dcsResolved=22);

  TDiagnosisVerificationStatusBase = (dvsUnconfirmed=10, dvsProvisional=11, dvsDifferential=12,
                                      dvsConfirmed=20, dvsRefuted=30, dvsEnteredInError=40);
  TMdaStatus = (msRegistered=10, msPartial=20, msPreliminary=21, msFinal=30, msAmended=40, msCorrected=41,
                msAppended=42, msCancelled=50, msEnteredInError=60, msUnknown=70);
  TValueScaleBase = (vsQN=1, vsNOM=2, vsNAR=3);

  TValueCodeBase = (vcPositive=1, vcNegative=2, vcIndeterminate=3);
  TProcedureCategoryBase = (pcSOC, pcVIT, pcIMG, pcLAB, pcPRC, pcSRV, pcEXM, pcTRP, pcACT);
  TExaminationStatusBase = (esOpen=1, esClosed=2, esCanceled=3);
  TDeputyRoleBase = (drMain=1, drDeputizing=2, drHired=3);
  TAdmissionType  = (Planned=1, Emergency=2);
  THospStatusType = (hstNone=0, hstPlanned=1, hstActive=2, hstTerminated=3, hstCompleted=4);


  TVisitType = (vtBlanka3, vtBlanka3A, vtBlanka6, vtSvoboden, vtSpeshen, vtNZOKBez, vtNeotlogen,
       vtCovidOtd, vtCovidZona, vtSkrining2024, vtSkrining2024NZOK);
  THipPregledStatus = (hpsNone, hpsValid, hpsNoValid, hpsStartOpen, hpsErr, hpsOpen, hpsClosed, hpsCancel);
  THipMdnStatus = (hmsNone, hmsValid, hmsNoValid, hmsSended, hmsErr, hmsCancel, hmsEdited);
  THipMdnLabStatus = (hmlsNone, hmlsActive, hmlsIzpuln, hmlsNotValid, hmlsCancel, hmlsIztegleno, hmlsZaObrabotka, hmlsPoluIzpuln, hmlsOtkazano, hmlsErr, hmlsIzvetrel);

  TNzisPregledInfo = record
    NRN: string[12];
    LRN: string[36];
    PregledID: Integer;
    Status: THipPregledStatus;
    Err: string[255];
  end;

  TNzisMDDInfo = record
    NRN: string[12];
    LRN: string[36];
    MddID: Integer;
    Status: THipMdnLabStatus;
    Err: string[255];
  end;

  TNzisMDNInfo = record
    NRN: string[12];
    LRN: string[36];
    MDN_ID: Integer;
    Status: THipMdnStatus;
    Err: string[255];
  end;

  TNzisAnalInfo = record
    key22: string [8];
    descr: string [255];
  end;

  TNzisResultInfo = record
    result: string;
    analCode: string;
    data: TDate;
    NRN_EXECUTION: string;
  end;

  TNzisBebeInfo = record
    FName: string[255];
    SName: string[255];
    LName: string[255];
    identifierNZIS: string[12];
  end;

  TNzisBebetaInfo = record
    count: Integer;
    bebe: array [0..11] of TNzisBebeInfo;
  end;

  TNzisHospInfo = record
    PatEGN: string[20];
    NRN: string[12];
    status: THospStatusType;
    authoredOn: TDate;
  end;

  TNzisHospsInfo = record
    count: Integer;
    hsp: array [0..19] of TNzisHospInfo;
  end;

  EXMLDOMValidationError = class(Exception)
  public
    FSrcText: DOMString;
    FURL: DOMString;
    FReason: DOMString;
    FErrorCode: Integer;
    FLine: Integer;
    FLinePos: Integer;
    FFilePos: Integer;
  public
    constructor Create(const ValidationError: IXMLDOMParseError);
    property ErrorCode: Integer read FErrorCode;
    property URL: DOMString read FURL;
    property Reason: DOMString read FReason;
    property SrcText: DOMString read FSrcText;
    property Line: Integer read FLine;
    property LinePos: Integer read FLinePos;
    property FilePos: Integer read FFilePos;
  end;
implementation

{ EXMLDOMValidationError }

constructor EXMLDOMValidationError.Create(const ValidationError: IXMLDOMParseError);
begin
  FSrcText := ValidationError.srcText;
  FURL := ValidationError.url;
  FReason := ValidationError.reason;
  FErrorCode := ValidationError.errorCode;
  FLine := ValidationError.line;
  FLinePos := ValidationError.linepos;
  FFilePos := ValidationError.filepos;
end;

end.
