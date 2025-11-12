
{**********************************************************************************************************************************************************************************************************************************************}
{                                                                                                                                                                                                                                              }
{                                                                                                               XML Data Binding                                                                                                               }
{                                                                                                                                                                                                                                              }
{         Generated on: 31.10.2025 г. 15:35:57                                                                                                                                                                                                 }
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
  IXMLAdditionalCodeType = interface;
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
    ['{123BC8E5-8BC0-47E9-AD25-B49734D7D3FC}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{1330A1FA-003C-42C5-9A34-A6B064DE2012}']
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
    ['{7A4E7272-9E42-46EA-A754-2AAA3448DC99}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{DBB2D00D-E341-4D4E-9E6D-65C0BD012354}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{AA6E3141-394F-4CF5-82D4-97965FC53164}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{55FFBC5D-3AF1-493F-8507-B866FD96A2AA}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{17840815-B4B8-466B-97AF-079D494D2B37}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{87FAC11C-9F70-42B3-AF4F-131F2953AC88}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{DD5508BB-A612-4927-B784-57F7B211A627}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{F056093E-A446-4686-BB57-0EF018DC2EF6}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{79E0D4E0-867A-4F50-94F9-47E5E29A0E3B}']
    { Property Accessors }
    function Get_Examination: IXMLExaminationType;
    { Methods & Properties }
    property Examination: IXMLExaminationType read Get_Examination;
  end;

{ IXMLExaminationType }

  IXMLExaminationType = interface(IXMLNode)
    ['{D506A739-1E01-44B2-98F4-FB638E69D31C}']
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
    ['{6B5FD015-F250-4946-9473-FA783FE369A3}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{2F7DBF4B-1581-4A3A-B4C6-A8EBBE56F197}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsSecondaryType }

  IXMLIsSecondaryType = interface(IXMLNode)
    ['{C46FBD17-5E39-4977-8407-2A388A06B6D2}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCloseDateType }

  IXMLCloseDateType = interface(IXMLNode)
    ['{AB29A2D1-961C-4FD7-A1D1-130BD89475A4}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPurposeType }

  IXMLPurposeType = interface(IXMLNode)
    ['{76C1079C-5BEC-4A51-A19A-0959E443FE22}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLIncidentalVisitType }

  IXMLIncidentalVisitType = interface(IXMLNode)
    ['{17D8C129-DB4D-4D08-91DF-F46BCF8BDB6C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAdverseConditionsType }

  IXMLAdverseConditionsType = interface(IXMLNode)
    ['{9728D37E-C782-435E-B774-DEAC6DB12817}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDocumentsType }

  IXMLDocumentsType = interface(IXMLNode)
    ['{6D26B8D8-9737-4EC2-930B-B7BC40E3BE12}']
    { Property Accessors }
    function Get_NrnReferral: IXMLNrnReferralTypeList;
    function Get_NrnPrescription: IXMLNrnPrescriptionType;
    { Methods & Properties }
    property NrnReferral: IXMLNrnReferralTypeList read Get_NrnReferral;
    property NrnPrescription: IXMLNrnPrescriptionType read Get_NrnPrescription;
  end;

{ IXMLNrnReferralType }

  IXMLNrnReferralType = interface(IXMLNode)
    ['{A08D31F1-C1A9-496E-BDCD-E159B2B8C4BA}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnReferralTypeList }

  IXMLNrnReferralTypeList = interface(IXMLNodeCollection)
    ['{B1059727-CA57-44E5-A392-6270BDA24A3D}']
    { Methods & Properties }
    function Add: IXMLNrnReferralType;
    function Insert(const Index: Integer): IXMLNrnReferralType;

    function Get_Item(Index: Integer): IXMLNrnReferralType;
    property Items[Index: Integer]: IXMLNrnReferralType read Get_Item; default;
  end;

{ IXMLNrnPrescriptionType }

  IXMLNrnPrescriptionType = interface(IXMLNode)
    ['{6CF05385-27FF-44D9-B5DB-C144234E1423}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{89C504C1-4556-4E68-A53B-EF899F5253AC}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_AdditionalCode: IXMLAdditionalCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property AdditionalCode: IXMLAdditionalCodeType read Get_AdditionalCode;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{3A6E0283-A879-45B6-BD35-4B6BDB7BE0D0}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAdditionalCodeType }

  IXMLAdditionalCodeType = interface(IXMLNode)
    ['{AD37776F-24BC-4EDF-BF06-DB03A80DFC44}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{83833657-3150-4C32-988F-41C313942E94}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{778A111F-6C36-4C0A-A60E-B13B45626FFD}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLComorbidityType }

  IXMLComorbidityType = interface(IXMLNode)
    ['{C5F14C1E-8FD5-4A40-9ADB-F35E58832352}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_AdditionalCode: IXMLAdditionalCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property AdditionalCode: IXMLAdditionalCodeType read Get_AdditionalCode;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
  end;

{ IXMLComorbidityTypeList }

  IXMLComorbidityTypeList = interface(IXMLNodeCollection)
    ['{585596AA-9388-4015-B3B6-4CC054A4B4F8}']
    { Methods & Properties }
    function Add: IXMLComorbidityType;
    function Insert(const Index: Integer): IXMLComorbidityType;

    function Get_Item(Index: Integer): IXMLComorbidityType;
    property Items[Index: Integer]: IXMLComorbidityType read Get_Item; default;
  end;

{ IXMLMedicalHistoryType }

  IXMLMedicalHistoryType = interface(IXMLNode)
    ['{D6AE0566-7949-47F0-82DA-95954984078D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLObjectiveConditionType }

  IXMLObjectiveConditionType = interface(IXMLNode)
    ['{80FFFD05-787D-44F9-A9D4-BCA222132A7C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAssessmentType }

  IXMLAssessmentType = interface(IXMLNode)
    ['{546145BF-D23E-45AC-8BAA-978EE0AE8AC5}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLNoteType }

  IXMLNoteType = interface(IXMLNode)
    ['{F5B18FC9-8F68-4BFE-95FC-B980C593C9A7}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTherapyType }

  IXMLTherapyType = interface(IXMLNode)
    ['{3A56CD34-AA18-4092-82CE-C50E8244FD7B}']
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
  TXMLAdditionalCodeType = class;
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
    function Get_AdditionalCode: IXMLAdditionalCodeType;
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

{ TXMLAdditionalCodeType }

  TXMLAdditionalCodeType = class(TXMLNode, IXMLAdditionalCodeType)
  protected
    { IXMLAdditionalCodeType }
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
    function Get_AdditionalCode: IXMLAdditionalCodeType;
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
  RegisterChildNode('additionalCode', TXMLAdditionalCodeType);
  RegisterChildNode('use', TXMLUseType);
  RegisterChildNode('rank', TXMLRankType);
  inherited;
end;

function TXMLDiagnosisType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLDiagnosisType.Get_AdditionalCode: IXMLAdditionalCodeType;
begin
  Result := ChildNodes['additionalCode'] as IXMLAdditionalCodeType;
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

{ TXMLAdditionalCodeType }

function TXMLAdditionalCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLAdditionalCodeType.Set_Value(Value: UnicodeString);
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
  RegisterChildNode('additionalCode', TXMLAdditionalCodeType);
  RegisterChildNode('use', TXMLUseType);
  RegisterChildNode('rank', TXMLRankType);
  inherited;
end;

function TXMLComorbidityType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLComorbidityType.Get_AdditionalCode: IXMLAdditionalCodeType;
begin
  Result := ChildNodes['additionalCode'] as IXMLAdditionalCodeType;
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