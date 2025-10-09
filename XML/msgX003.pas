
{**********************************************************************************************************************************************************************************************************************************************}
{                                                                                                                                                                                                                                              }
{                                                                                                               XML Data Binding                                                                                                               }
{                                                                                                                                                                                                                                              }
{         Generated on: 22.9.2025 г. 0:17:48                                                                                                                                                                                                   }
{       Generated from: C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\X003.xml   }
{   Settings stored in: C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\X003.xdb   }
{                                                                                                                                                                                                                                              }
{**********************************************************************************************************************************************************************************************************************************************}

unit msgX003;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLMessageType = interface;
  IXMLHeaderType = interface;
  IXMLSenderType = interface;
  IXMLSenderIdType = interface;
  IXMLSenderISNameType = interface;
  IXMLRecipientType = interface;
  IXMLRecipientIdType = interface;
  IXMLMessageIdType = interface;
  IXMLMessageType2 = interface;
  IXMLCreatedOnType = interface;
  IXMLContentsType = interface;
  IXMLExaminationType = interface;
  IXMLNrnExaminationType = interface;
  IXMLBasedOnType = interface;
  IXMLIsSecondaryType = interface;
  IXMLCloseDateType = interface;
  IXMLPurposeType = interface;
  IXMLIncidentalVisitType = interface;
  IXMLAdverseConditionsType = interface;
  IXMLDocumentsType = interface;
  IXMLNrnReferralType = interface;
  IXMLNrnReferralTypeList = interface;
  IXMLNrnPrescriptionType = interface;
  IXMLDiagnosisType = interface;
  IXMLCodeType = interface;
  IXMLUseType = interface;
  IXMLRankType = interface;
  IXMLComorbidityType = interface;
  IXMLComorbidityTypeList = interface;
  IXMLMedicalHistoryType = interface;
  IXMLObjectiveConditionType = interface;
  IXMLAssessmentType = interface;
  IXMLNoteType = interface;
  IXMLTherapyType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{62AD1456-188D-4001-8AC8-3477389D007A}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{A8C5BE9E-B281-4E27-ADF8-9B97EE18AB50}']
    { Property Accessors }
    function Get_Sender: IXMLSenderType;
    function Get_SenderId: IXMLSenderIdType;
    function Get_SenderISName: IXMLSenderISNameType;
    function Get_Recipient: IXMLRecipientType;
    function Get_RecipientId: IXMLRecipientIdType;
    function Get_MessageId: IXMLMessageIdType;
    function Get_MessageType: IXMLMessageType2;
    function Get_CreatedOn: IXMLCreatedOnType;
    { Methods & Properties }
    property Sender: IXMLSenderType read Get_Sender;
    property SenderId: IXMLSenderIdType read Get_SenderId;
    property SenderISName: IXMLSenderISNameType read Get_SenderISName;
    property Recipient: IXMLRecipientType read Get_Recipient;
    property RecipientId: IXMLRecipientIdType read Get_RecipientId;
    property MessageId: IXMLMessageIdType read Get_MessageId;
    property MessageType: IXMLMessageType2 read Get_MessageType;
    property CreatedOn: IXMLCreatedOnType read Get_CreatedOn;
  end;

{ IXMLSenderType }

  IXMLSenderType = interface(IXMLNode)
    ['{74B1CD96-E0FC-47F2-A9D0-4F2559E3E580}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{F0506DDD-A6C6-47CF-9E30-94239862C290}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{5B897141-2043-4117-8027-D1A93C8C22BB}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{885BD94D-C46B-4460-8083-3E6A4813D00B}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{01874A16-3365-4085-A133-22FDD5BE9B80}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{B82F7E77-549B-4527-BBEF-9BF3E1E12A1E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{2EFECEBD-E566-4B05-95B6-39D89D7F8B1E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{A225BE8C-3DE6-4894-8574-17F4F0E8D31B}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{B125978D-82FC-4637-BC3C-401EAA339FFD}']
    { Property Accessors }
    function Get_Examination: IXMLExaminationType;
    { Methods & Properties }
    property Examination: IXMLExaminationType read Get_Examination;
  end;

{ IXMLExaminationType }

  IXMLExaminationType = interface(IXMLNode)
    ['{D13EE638-86D9-41BA-B5BE-25E9FBDD0D58}']
    { Property Accessors }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_IsSecondary: IXMLIsSecondaryType;
    function Get_CloseDate: IXMLCloseDateType;
    function Get_Purpose: IXMLPurposeType;
    function Get_IncidentalVisit: IXMLIncidentalVisitType;
    function Get_AdverseConditions: IXMLAdverseConditionsType;
    function Get_Documents: IXMLDocumentsType;
    function Get_Diagnosis: IXMLDiagnosisType;
    function Get_Comorbidity: IXMLComorbidityTypeList;
    function Get_MedicalHistory: IXMLMedicalHistoryType;
    function Get_ObjectiveCondition: IXMLObjectiveConditionType;
    function Get_Assessment: IXMLAssessmentType;
    function Get_Therapy: IXMLTherapyType;
    { Methods & Properties }
    property NrnExamination: IXMLNrnExaminationType read Get_NrnExamination;
    property BasedOn: IXMLBasedOnType read Get_BasedOn;
    property IsSecondary: IXMLIsSecondaryType read Get_IsSecondary;
    property CloseDate: IXMLCloseDateType read Get_CloseDate;
    property Purpose: IXMLPurposeType read Get_Purpose;
    property IncidentalVisit: IXMLIncidentalVisitType read Get_IncidentalVisit;
    property AdverseConditions: IXMLAdverseConditionsType read Get_AdverseConditions;
    property Documents: IXMLDocumentsType read Get_Documents;
    property Diagnosis: IXMLDiagnosisType read Get_Diagnosis;
    property Comorbidity: IXMLComorbidityTypeList read Get_Comorbidity;
    property MedicalHistory: IXMLMedicalHistoryType read Get_MedicalHistory;
    property ObjectiveCondition: IXMLObjectiveConditionType read Get_ObjectiveCondition;
    property Assessment: IXMLAssessmentType read Get_Assessment;
    property Therapy: IXMLTherapyType read Get_Therapy;
  end;

{ IXMLNrnExaminationType }

  IXMLNrnExaminationType = interface(IXMLNode)
    ['{00159027-6FED-486F-ACEB-3851C94B004C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{6C0F3DAA-CDEE-4E50-840A-5ED296110CEF}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsSecondaryType }

  IXMLIsSecondaryType = interface(IXMLNode)
    ['{493A6784-DE4D-4A2D-B849-CE2154D81154}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCloseDateType }

  IXMLCloseDateType = interface(IXMLNode)
    ['{FECFB62D-20C8-4820-AAF4-1C678203D336}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPurposeType }

  IXMLPurposeType = interface(IXMLNode)
    ['{36B96EAB-E6CD-4C92-919E-0F938ED4556B}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLIncidentalVisitType }

  IXMLIncidentalVisitType = interface(IXMLNode)
    ['{10A39F83-69CA-43C7-B6D4-2AA5DC3D793A}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAdverseConditionsType }

  IXMLAdverseConditionsType = interface(IXMLNode)
    ['{0FC89335-C132-4A89-9B70-556060613CF4}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDocumentsType }

  IXMLDocumentsType = interface(IXMLNode)
    ['{8D6DC694-3269-4B9E-83FF-A2CBBF1DA60B}']
    { Property Accessors }
    function Get_NrnReferral: IXMLNrnReferralTypeList;
    function Get_NrnPrescription: IXMLNrnPrescriptionType;
    { Methods & Properties }
    property NrnReferral: IXMLNrnReferralTypeList read Get_NrnReferral;
    property NrnPrescription: IXMLNrnPrescriptionType read Get_NrnPrescription;
  end;

{ IXMLNrnReferralType }

  IXMLNrnReferralType = interface(IXMLNode)
    ['{AE14C320-F39C-452B-86DB-075BD6C4470E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnReferralTypeList }

  IXMLNrnReferralTypeList = interface(IXMLNodeCollection)
    ['{B9004032-08B5-4FE6-86D3-E0CDD11687B8}']
    { Methods & Properties }
    function Add: IXMLNrnReferralType;
    function Insert(const Index: Integer): IXMLNrnReferralType;

    function Get_Item(Index: Integer): IXMLNrnReferralType;
    property Items[Index: Integer]: IXMLNrnReferralType read Get_Item; default;
  end;

{ IXMLNrnPrescriptionType }

  IXMLNrnPrescriptionType = interface(IXMLNode)
    ['{40F099AE-C650-4005-AC5F-E2036F7FB6AD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{265A9A5A-D69D-4192-A9AB-8E081053492A}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{83DBD4C7-4C2F-4AA2-A22A-E1B6FF3383AD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{CF62C1F3-9A32-4ABF-B9F1-80AD29E58798}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{888AC0CA-AA2B-4F0B-9166-0A1499593D39}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLComorbidityType }

  IXMLComorbidityType = interface(IXMLNode)
    ['{456BA648-B505-4FC8-BA7A-46E6D64A7567}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
  end;

{ IXMLComorbidityTypeList }

  IXMLComorbidityTypeList = interface(IXMLNodeCollection)
    ['{C8B857FB-AD3F-4FA9-B76E-F98FDB20D0DA}']
    { Methods & Properties }
    function Add: IXMLComorbidityType;
    function Insert(const Index: Integer): IXMLComorbidityType;

    function Get_Item(Index: Integer): IXMLComorbidityType;
    property Items[Index: Integer]: IXMLComorbidityType read Get_Item; default;
  end;

{ IXMLMedicalHistoryType }

  IXMLMedicalHistoryType = interface(IXMLNode)
    ['{8BB1E0FF-D862-4CBB-B93D-7FE27AB70069}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLObjectiveConditionType }

  IXMLObjectiveConditionType = interface(IXMLNode)
    ['{6BE4FDC2-9FC9-4C1E-8EF6-6B54DCBE31B9}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAssessmentType }

  IXMLAssessmentType = interface(IXMLNode)
    ['{0CD0E2DA-0ACF-4CCA-9ABC-4B5D923CE05E}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLNoteType }

  IXMLNoteType = interface(IXMLNode)
    ['{563597F1-81DB-4109-90F1-7F82CBC3FDD5}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTherapyType }

  IXMLTherapyType = interface(IXMLNode)
    ['{8D7F3104-0988-498C-A454-4C3B3D4C6E6E}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ Forward Decls }

  TXMLMessageType = class;
  TXMLHeaderType = class;
  TXMLSenderType = class;
  TXMLSenderIdType = class;
  TXMLSenderISNameType = class;
  TXMLRecipientType = class;
  TXMLRecipientIdType = class;
  TXMLMessageIdType = class;
  TXMLMessageType2 = class;
  TXMLCreatedOnType = class;
  TXMLContentsType = class;
  TXMLExaminationType = class;
  TXMLNrnExaminationType = class;
  TXMLBasedOnType = class;
  TXMLIsSecondaryType = class;
  TXMLCloseDateType = class;
  TXMLPurposeType = class;
  TXMLIncidentalVisitType = class;
  TXMLAdverseConditionsType = class;
  TXMLDocumentsType = class;
  TXMLNrnReferralType = class;
  TXMLNrnReferralTypeList = class;
  TXMLNrnPrescriptionType = class;
  TXMLDiagnosisType = class;
  TXMLCodeType = class;
  TXMLUseType = class;
  TXMLRankType = class;
  TXMLComorbidityType = class;
  TXMLComorbidityTypeList = class;
  TXMLMedicalHistoryType = class;
  TXMLObjectiveConditionType = class;
  TXMLAssessmentType = class;
  TXMLNoteType = class;
  TXMLTherapyType = class;

{ TXMLMessageType }

  TXMLMessageType = class(TXMLNode, IXMLMessageType)
  protected
    { IXMLMessageType }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLHeaderType }

  TXMLHeaderType = class(TXMLNode, IXMLHeaderType)
  protected
    { IXMLHeaderType }
    function Get_Sender: IXMLSenderType;
    function Get_SenderId: IXMLSenderIdType;
    function Get_SenderISName: IXMLSenderISNameType;
    function Get_Recipient: IXMLRecipientType;
    function Get_RecipientId: IXMLRecipientIdType;
    function Get_MessageId: IXMLMessageIdType;
    function Get_MessageType: IXMLMessageType2;
    function Get_CreatedOn: IXMLCreatedOnType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSenderType }

  TXMLSenderType = class(TXMLNode, IXMLSenderType)
  protected
    { IXMLSenderType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLSenderIdType }

  TXMLSenderIdType = class(TXMLNode, IXMLSenderIdType)
  protected
    { IXMLSenderIdType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLSenderISNameType }

  TXMLSenderISNameType = class(TXMLNode, IXMLSenderISNameType)
  protected
    { IXMLSenderISNameType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLRecipientType }

  TXMLRecipientType = class(TXMLNode, IXMLRecipientType)
  protected
    { IXMLRecipientType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLRecipientIdType }

  TXMLRecipientIdType = class(TXMLNode, IXMLRecipientIdType)
  protected
    { IXMLRecipientIdType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMessageIdType }

  TXMLMessageIdType = class(TXMLNode, IXMLMessageIdType)
  protected
    { IXMLMessageIdType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMessageType2 }

  TXMLMessageType2 = class(TXMLNode, IXMLMessageType2)
  protected
    { IXMLMessageType2 }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCreatedOnType }

  TXMLCreatedOnType = class(TXMLNode, IXMLCreatedOnType)
  protected
    { IXMLCreatedOnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLContentsType }

  TXMLContentsType = class(TXMLNode, IXMLContentsType)
  protected
    { IXMLContentsType }
    function Get_Examination: IXMLExaminationType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLExaminationType }

  TXMLExaminationType = class(TXMLNode, IXMLExaminationType)
  private
    FComorbidity: IXMLComorbidityTypeList;
  protected
    { IXMLExaminationType }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_IsSecondary: IXMLIsSecondaryType;
    function Get_CloseDate: IXMLCloseDateType;
    function Get_Purpose: IXMLPurposeType;
    function Get_IncidentalVisit: IXMLIncidentalVisitType;
    function Get_AdverseConditions: IXMLAdverseConditionsType;
    function Get_Documents: IXMLDocumentsType;
    function Get_Diagnosis: IXMLDiagnosisType;
    function Get_Comorbidity: IXMLComorbidityTypeList;
    function Get_MedicalHistory: IXMLMedicalHistoryType;
    function Get_ObjectiveCondition: IXMLObjectiveConditionType;
    function Get_Assessment: IXMLAssessmentType;
    function Get_Therapy: IXMLTherapyType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNrnExaminationType }

  TXMLNrnExaminationType = class(TXMLNode, IXMLNrnExaminationType)
  protected
    { IXMLNrnExaminationType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLBasedOnType }

  TXMLBasedOnType = class(TXMLNode, IXMLBasedOnType)
  protected
    { IXMLBasedOnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIsSecondaryType }

  TXMLIsSecondaryType = class(TXMLNode, IXMLIsSecondaryType)
  protected
    { IXMLIsSecondaryType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCloseDateType }

  TXMLCloseDateType = class(TXMLNode, IXMLCloseDateType)
  protected
    { IXMLCloseDateType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPurposeType }

  TXMLPurposeType = class(TXMLNode, IXMLPurposeType)
  protected
    { IXMLPurposeType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLIncidentalVisitType }

  TXMLIncidentalVisitType = class(TXMLNode, IXMLIncidentalVisitType)
  protected
    { IXMLIncidentalVisitType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLAdverseConditionsType }

  TXMLAdverseConditionsType = class(TXMLNode, IXMLAdverseConditionsType)
  protected
    { IXMLAdverseConditionsType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDocumentsType }

  TXMLDocumentsType = class(TXMLNode, IXMLDocumentsType)
  private
    FNrnReferral: IXMLNrnReferralTypeList;
  protected
    { IXMLDocumentsType }
    function Get_NrnReferral: IXMLNrnReferralTypeList;
    function Get_NrnPrescription: IXMLNrnPrescriptionType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNrnReferralType }

  TXMLNrnReferralType = class(TXMLNode, IXMLNrnReferralType)
  protected
    { IXMLNrnReferralType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnReferralTypeList }

  TXMLNrnReferralTypeList = class(TXMLNodeCollection, IXMLNrnReferralTypeList)
  protected
    { IXMLNrnReferralTypeList }
    function Add: IXMLNrnReferralType;
    function Insert(const Index: Integer): IXMLNrnReferralType;

    function Get_Item(Index: Integer): IXMLNrnReferralType;
  end;

{ TXMLNrnPrescriptionType }

  TXMLNrnPrescriptionType = class(TXMLNode, IXMLNrnPrescriptionType)
  protected
    { IXMLNrnPrescriptionType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDiagnosisType }

  TXMLDiagnosisType = class(TXMLNode, IXMLDiagnosisType)
  protected
    { IXMLDiagnosisType }
    function Get_Code: IXMLCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCodeType }

  TXMLCodeType = class(TXMLNode, IXMLCodeType)
  protected
    { IXMLCodeType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLUseType }

  TXMLUseType = class(TXMLNode, IXMLUseType)
  protected
    { IXMLUseType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLRankType }

  TXMLRankType = class(TXMLNode, IXMLRankType)
  protected
    { IXMLRankType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLComorbidityType }

  TXMLComorbidityType = class(TXMLNode, IXMLComorbidityType)
  protected
    { IXMLComorbidityType }
    function Get_Code: IXMLCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComorbidityTypeList }

  TXMLComorbidityTypeList = class(TXMLNodeCollection, IXMLComorbidityTypeList)
  protected
    { IXMLComorbidityTypeList }
    function Add: IXMLComorbidityType;
    function Insert(const Index: Integer): IXMLComorbidityType;

    function Get_Item(Index: Integer): IXMLComorbidityType;
  end;

{ TXMLMedicalHistoryType }

  TXMLMedicalHistoryType = class(TXMLNode, IXMLMedicalHistoryType)
  protected
    { IXMLMedicalHistoryType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLObjectiveConditionType }

  TXMLObjectiveConditionType = class(TXMLNode, IXMLObjectiveConditionType)
  protected
    { IXMLObjectiveConditionType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLAssessmentType }

  TXMLAssessmentType = class(TXMLNode, IXMLAssessmentType)
  protected
    { IXMLAssessmentType }
    function Get_Note: IXMLNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNoteType }

  TXMLNoteType = class(TXMLNode, IXMLNoteType)
  protected
    { IXMLNoteType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLTherapyType }

  TXMLTherapyType = class(TXMLNode, IXMLTherapyType)
  protected
    { IXMLTherapyType }
    function Get_Note: IXMLNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function Getmessage(Doc: IXMLDocument): IXMLMessageType;
function Loadmessage(const FileName: string): IXMLMessageType;
function Newmessage: IXMLMessageType;

const
  TargetNamespace = 'https://www.his.bg';

implementation

{ Global Functions }

function Getmessage(Doc: IXMLDocument): IXMLMessageType;
begin
  Result := Doc.GetDocBinding('message', TXMLMessageType, TargetNamespace) as IXMLMessageType;
end;

function Loadmessage(const FileName: string): IXMLMessageType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('message', TXMLMessageType, TargetNamespace) as IXMLMessageType;
end;

function Newmessage: IXMLMessageType;
begin
  Result := NewXMLDocument.GetDocBinding('message', TXMLMessageType, TargetNamespace) as IXMLMessageType;
end;

{ TXMLMessageType }

procedure TXMLMessageType.AfterConstruction;
begin
  RegisterChildNode('header', TXMLHeaderType);
  RegisterChildNode('contents', TXMLContentsType);
  inherited;
end;

function TXMLMessageType.Get_Header: IXMLHeaderType;
begin
  Result := ChildNodes['header'] as IXMLHeaderType;
end;

function TXMLMessageType.Get_Contents: IXMLContentsType;
begin
  Result := ChildNodes['contents'] as IXMLContentsType;
end;

{ TXMLHeaderType }

procedure TXMLHeaderType.AfterConstruction;
begin
  RegisterChildNode('sender', TXMLSenderType);
  RegisterChildNode('senderId', TXMLSenderIdType);
  RegisterChildNode('senderISName', TXMLSenderISNameType);
  RegisterChildNode('recipient', TXMLRecipientType);
  RegisterChildNode('recipientId', TXMLRecipientIdType);
  RegisterChildNode('messageId', TXMLMessageIdType);
  RegisterChildNode('messageType', TXMLMessageType2);
  RegisterChildNode('createdOn', TXMLCreatedOnType);
  inherited;
end;

function TXMLHeaderType.Get_Sender: IXMLSenderType;
begin
  Result := ChildNodes['sender'] as IXMLSenderType;
end;

function TXMLHeaderType.Get_SenderId: IXMLSenderIdType;
begin
  Result := ChildNodes['senderId'] as IXMLSenderIdType;
end;

function TXMLHeaderType.Get_SenderISName: IXMLSenderISNameType;
begin
  Result := ChildNodes['senderISName'] as IXMLSenderISNameType;
end;

function TXMLHeaderType.Get_Recipient: IXMLRecipientType;
begin
  Result := ChildNodes['recipient'] as IXMLRecipientType;
end;

function TXMLHeaderType.Get_RecipientId: IXMLRecipientIdType;
begin
  Result := ChildNodes['recipientId'] as IXMLRecipientIdType;
end;

function TXMLHeaderType.Get_MessageId: IXMLMessageIdType;
begin
  Result := ChildNodes['messageId'] as IXMLMessageIdType;
end;

function TXMLHeaderType.Get_MessageType: IXMLMessageType2;
begin
  Result := ChildNodes['messageType'] as IXMLMessageType2;
end;

function TXMLHeaderType.Get_CreatedOn: IXMLCreatedOnType;
begin
  Result := ChildNodes['createdOn'] as IXMLCreatedOnType;
end;

{ TXMLSenderType }

function TXMLSenderType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLSenderType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLSenderIdType }

function TXMLSenderIdType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLSenderIdType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLSenderISNameType }

function TXMLSenderISNameType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSenderISNameType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLRecipientType }

function TXMLRecipientType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRecipientType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLRecipientIdType }

function TXMLRecipientIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLRecipientIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMessageIdType }

function TXMLMessageIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMessageIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMessageType2 }

function TXMLMessageType2.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMessageType2.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCreatedOnType }

function TXMLCreatedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCreatedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLContentsType }

procedure TXMLContentsType.AfterConstruction;
begin
  RegisterChildNode('examination', TXMLExaminationType);
  inherited;
end;

function TXMLContentsType.Get_Examination: IXMLExaminationType;
begin
  Result := ChildNodes['examination'] as IXMLExaminationType;
end;

{ TXMLExaminationType }

procedure TXMLExaminationType.AfterConstruction;
begin
  RegisterChildNode('nrnExamination', TXMLNrnExaminationType);
  RegisterChildNode('basedOn', TXMLBasedOnType);
  RegisterChildNode('isSecondary', TXMLIsSecondaryType);
  RegisterChildNode('closeDate', TXMLCloseDateType);
  RegisterChildNode('purpose', TXMLPurposeType);
  RegisterChildNode('incidentalVisit', TXMLIncidentalVisitType);
  RegisterChildNode('adverseConditions', TXMLAdverseConditionsType);
  RegisterChildNode('documents', TXMLDocumentsType);
  RegisterChildNode('diagnosis', TXMLDiagnosisType);
  RegisterChildNode('comorbidity', TXMLComorbidityType);
  RegisterChildNode('medicalHistory', TXMLMedicalHistoryType);
  RegisterChildNode('objectiveCondition', TXMLObjectiveConditionType);
  RegisterChildNode('assessment', TXMLAssessmentType);
  RegisterChildNode('therapy', TXMLTherapyType);
  FComorbidity := CreateCollection(TXMLComorbidityTypeList, IXMLComorbidityType, 'comorbidity') as IXMLComorbidityTypeList;
  inherited;
end;

function TXMLExaminationType.Get_NrnExamination: IXMLNrnExaminationType;
begin
  Result := ChildNodes['nrnExamination'] as IXMLNrnExaminationType;
end;

function TXMLExaminationType.Get_BasedOn: IXMLBasedOnType;
begin
  Result := ChildNodes['basedOn'] as IXMLBasedOnType;
end;

function TXMLExaminationType.Get_IsSecondary: IXMLIsSecondaryType;
begin
  Result := ChildNodes['isSecondary'] as IXMLIsSecondaryType;
end;

function TXMLExaminationType.Get_CloseDate: IXMLCloseDateType;
begin
  Result := ChildNodes['closeDate'] as IXMLCloseDateType;
end;

function TXMLExaminationType.Get_Purpose: IXMLPurposeType;
begin
  Result := ChildNodes['purpose'] as IXMLPurposeType;
end;

function TXMLExaminationType.Get_IncidentalVisit: IXMLIncidentalVisitType;
begin
  Result := ChildNodes['incidentalVisit'] as IXMLIncidentalVisitType;
end;

function TXMLExaminationType.Get_AdverseConditions: IXMLAdverseConditionsType;
begin
  Result := ChildNodes['adverseConditions'] as IXMLAdverseConditionsType;
end;

function TXMLExaminationType.Get_Documents: IXMLDocumentsType;
begin
  Result := ChildNodes['documents'] as IXMLDocumentsType;
end;

function TXMLExaminationType.Get_Diagnosis: IXMLDiagnosisType;
begin
  Result := ChildNodes['diagnosis'] as IXMLDiagnosisType;
end;

function TXMLExaminationType.Get_Comorbidity: IXMLComorbidityTypeList;
begin
  Result := FComorbidity;
end;

function TXMLExaminationType.Get_MedicalHistory: IXMLMedicalHistoryType;
begin
  Result := ChildNodes['medicalHistory'] as IXMLMedicalHistoryType;
end;

function TXMLExaminationType.Get_ObjectiveCondition: IXMLObjectiveConditionType;
begin
  Result := ChildNodes['objectiveCondition'] as IXMLObjectiveConditionType;
end;

function TXMLExaminationType.Get_Assessment: IXMLAssessmentType;
begin
  Result := ChildNodes['assessment'] as IXMLAssessmentType;
end;

function TXMLExaminationType.Get_Therapy: IXMLTherapyType;
begin
  Result := ChildNodes['therapy'] as IXMLTherapyType;
end;

{ TXMLNrnExaminationType }

function TXMLNrnExaminationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnExaminationType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLBasedOnType }

function TXMLBasedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLBasedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIsSecondaryType }

function TXMLIsSecondaryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIsSecondaryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCloseDateType }

function TXMLCloseDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCloseDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPurposeType }

function TXMLPurposeType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPurposeType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLIncidentalVisitType }

function TXMLIncidentalVisitType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIncidentalVisitType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLAdverseConditionsType }

function TXMLAdverseConditionsType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLAdverseConditionsType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDocumentsType }

procedure TXMLDocumentsType.AfterConstruction;
begin
  RegisterChildNode('nrnReferral', TXMLNrnReferralType);
  RegisterChildNode('nrnPrescription', TXMLNrnPrescriptionType);
  FNrnReferral := CreateCollection(TXMLNrnReferralTypeList, IXMLNrnReferralType, 'nrnReferral') as IXMLNrnReferralTypeList;
  inherited;
end;

function TXMLDocumentsType.Get_NrnReferral: IXMLNrnReferralTypeList;
begin
  Result := FNrnReferral;
end;

function TXMLDocumentsType.Get_NrnPrescription: IXMLNrnPrescriptionType;
begin
  Result := ChildNodes['nrnPrescription'] as IXMLNrnPrescriptionType;
end;

{ TXMLNrnReferralType }

function TXMLNrnReferralType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnReferralType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnReferralTypeList }

function TXMLNrnReferralTypeList.Add: IXMLNrnReferralType;
begin
  Result := AddItem(-1) as IXMLNrnReferralType;
end;

function TXMLNrnReferralTypeList.Insert(const Index: Integer): IXMLNrnReferralType;
begin
  Result := AddItem(Index) as IXMLNrnReferralType;
end;

function TXMLNrnReferralTypeList.Get_Item(Index: Integer): IXMLNrnReferralType;
begin
  Result := List[Index] as IXMLNrnReferralType;
end;

{ TXMLNrnPrescriptionType }

function TXMLNrnPrescriptionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnPrescriptionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDiagnosisType }

procedure TXMLDiagnosisType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('use', TXMLUseType);
  RegisterChildNode('rank', TXMLRankType);
  inherited;
end;

function TXMLDiagnosisType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLDiagnosisType.Get_Use: IXMLUseType;
begin
  Result := ChildNodes['use'] as IXMLUseType;
end;

function TXMLDiagnosisType.Get_Rank: IXMLRankType;
begin
  Result := ChildNodes['rank'] as IXMLRankType;
end;

{ TXMLCodeType }

function TXMLCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCodeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLUseType }

function TXMLUseType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLUseType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLRankType }

function TXMLRankType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRankType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLComorbidityType }

procedure TXMLComorbidityType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('use', TXMLUseType);
  RegisterChildNode('rank', TXMLRankType);
  inherited;
end;

function TXMLComorbidityType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLComorbidityType.Get_Use: IXMLUseType;
begin
  Result := ChildNodes['use'] as IXMLUseType;
end;

function TXMLComorbidityType.Get_Rank: IXMLRankType;
begin
  Result := ChildNodes['rank'] as IXMLRankType;
end;

{ TXMLComorbidityTypeList }

function TXMLComorbidityTypeList.Add: IXMLComorbidityType;
begin
  Result := AddItem(-1) as IXMLComorbidityType;
end;

function TXMLComorbidityTypeList.Insert(const Index: Integer): IXMLComorbidityType;
begin
  Result := AddItem(Index) as IXMLComorbidityType;
end;

function TXMLComorbidityTypeList.Get_Item(Index: Integer): IXMLComorbidityType;
begin
  Result := List[Index] as IXMLComorbidityType;
end;

{ TXMLMedicalHistoryType }

function TXMLMedicalHistoryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMedicalHistoryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLObjectiveConditionType }

function TXMLObjectiveConditionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLObjectiveConditionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLAssessmentType }

procedure TXMLAssessmentType.AfterConstruction;
begin
  RegisterChildNode('note', TXMLNoteType);
  inherited;
end;

function TXMLAssessmentType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

{ TXMLNoteType }

function TXMLNoteType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNoteType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLTherapyType }

procedure TXMLTherapyType.AfterConstruction;
begin
  RegisterChildNode('note', TXMLNoteType);
  inherited;
end;

function TXMLTherapyType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

end.