
{**********************************************************************************************************************************************************************************************************************************************}
{                                                                                                                                                                                                                                              }
{                                                                                                               XML Data Binding                                                                                                               }
{                                                                                                                                                                                                                                              }
{         Generated on: 1.10.2025 г. 0:21:33                                                                                                                                                                                                   }
{       Generated from: C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\X013.xml   }
{   Settings stored in: C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\X013.xdb   }
{                                                                                                                                                                                                                                              }
{**********************************************************************************************************************************************************************************************************************************************}

unit msgX013;

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
  IXMLLrnType = interface;
  IXMLOpenDateType = interface;
  IXMLCloseDateType = interface;
  IXMLBasedOnType = interface;
  IXMLClassType = interface;
  IXMLPurposeType = interface;
  IXMLIncidentalVisitType = interface;
  IXMLIsSecondaryType = interface;
  IXMLFinancingSourceType = interface;
  IXMLRhifAreaNumberType = interface;
  IXMLAdverseConditionsType = interface;
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
  IXMLSubjectType = interface;
  IXMLIdentifierType = interface;
  IXMLBirthDateType = interface;
  IXMLGenderType = interface;
  IXMLNameType = interface;
  IXMLGivenType = interface;
  IXMLMiddleType = interface;
  IXMLFamilyType = interface;
  IXMLAddressType = interface;
  IXMLCountryType = interface;
  IXMLCountyType = interface;
  IXMLEkatteType = interface;
  IXMLCityType = interface;
  IXMLPerformerType = interface;
  IXMLPmiType = interface;
  IXMLQualificationType = interface;
  IXMLRoleType = interface;
  IXMLPracticeNumberType = interface;
  IXMLSignatureType = interface;
  IXMLSignedInfoType = interface;
  IXMLCanonicalizationMethodType = interface;
  IXMLSignatureMethodType = interface;
  IXMLReferenceType = interface;
  IXMLTransformsType = interface;
  IXMLTransformType = interface;
  IXMLDigestMethodType = interface;
  IXMLKeyInfoType = interface;
  IXMLKeyValueType = interface;
  IXMLRSAKeyValueType = interface;
  IXMLX509DataType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{FE1D501E-2A0C-46FE-A7AE-F0ADE7DAFA16}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    function Get_Signature: IXMLSignatureType;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
    property Signature: IXMLSignatureType read Get_Signature;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{5E36DA03-BBF0-41CF-B06E-7D0B9B25BC5C}']
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
    ['{CF53588B-0610-421B-8444-7829890076B6}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{877A06E0-F6B1-4AF1-A828-E6A15702D064}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{3DC96AAC-5EC6-4C8E-A700-ACA10FBC2B2C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{D9946C74-0DC6-4ED1-A8F2-9B0884718C94}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{C9D0459F-0E48-4CAC-A4B4-A905C7D0189B}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{4C1C817B-0702-4C5C-A385-841AC49B7015}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{E66DEE26-E1D4-44FC-9397-179C80D7E01C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{1E2DA9E7-1A37-45AD-9CFE-C2960090511F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{4006ECC8-E132-43CE-9134-D09C9D805908}']
    { Property Accessors }
    function Get_Examination: IXMLExaminationType;
    function Get_Subject: IXMLSubjectType;
    function Get_Performer: IXMLPerformerType;
    { Methods & Properties }
    property Examination: IXMLExaminationType read Get_Examination;
    property Subject: IXMLSubjectType read Get_Subject;
    property Performer: IXMLPerformerType read Get_Performer;
  end;

{ IXMLExaminationType }

  IXMLExaminationType = interface(IXMLNode)
    ['{F022691A-0F53-416F-A00E-1955F5A68E7E}']
    { Property Accessors }
    function Get_Lrn: IXMLLrnType;
    function Get_OpenDate: IXMLOpenDateType;
    function Get_CloseDate: IXMLCloseDateType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_Class_: IXMLClassType;
    function Get_Purpose: IXMLPurposeType;
    function Get_IncidentalVisit: IXMLIncidentalVisitType;
    function Get_IsSecondary: IXMLIsSecondaryType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_AdverseConditions: IXMLAdverseConditionsType;
    function Get_Diagnosis: IXMLDiagnosisType;
    function Get_Comorbidity: IXMLComorbidityTypeList;
    function Get_MedicalHistory: IXMLMedicalHistoryType;
    function Get_ObjectiveCondition: IXMLObjectiveConditionType;
    function Get_Assessment: IXMLAssessmentType;
    function Get_Therapy: IXMLTherapyType;
    { Methods & Properties }
    property Lrn: IXMLLrnType read Get_Lrn;
    property OpenDate: IXMLOpenDateType read Get_OpenDate;
    property CloseDate: IXMLCloseDateType read Get_CloseDate;
    property BasedOn: IXMLBasedOnType read Get_BasedOn;
    property Class_: IXMLClassType read Get_Class_;
    property Purpose: IXMLPurposeType read Get_Purpose;
    property IncidentalVisit: IXMLIncidentalVisitType read Get_IncidentalVisit;
    property IsSecondary: IXMLIsSecondaryType read Get_IsSecondary;
    property FinancingSource: IXMLFinancingSourceType read Get_FinancingSource;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
    property AdverseConditions: IXMLAdverseConditionsType read Get_AdverseConditions;
    property Diagnosis: IXMLDiagnosisType read Get_Diagnosis;
    property Comorbidity: IXMLComorbidityTypeList read Get_Comorbidity;
    property MedicalHistory: IXMLMedicalHistoryType read Get_MedicalHistory;
    property ObjectiveCondition: IXMLObjectiveConditionType read Get_ObjectiveCondition;
    property Assessment: IXMLAssessmentType read Get_Assessment;
    property Therapy: IXMLTherapyType read Get_Therapy;
  end;

{ IXMLLrnType }

  IXMLLrnType = interface(IXMLNode)
    ['{6BD3292F-919B-4618-ADD9-D12591F3671D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLOpenDateType }

  IXMLOpenDateType = interface(IXMLNode)
    ['{7CDBE9DB-4529-4EE8-9BEA-DF60D3D72C0C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCloseDateType }

  IXMLCloseDateType = interface(IXMLNode)
    ['{FC27CE79-552D-4F52-A9C7-D92363CF5549}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{8AC104DD-9785-441C-8EF6-5AAA7A0158BB}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLClassType }

  IXMLClassType = interface(IXMLNode)
    ['{5EF531AA-790B-401C-9459-D920DD4535AC}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPurposeType }

  IXMLPurposeType = interface(IXMLNode)
    ['{B3C06102-4B53-4A3D-BE24-8C5759EC78E3}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLIncidentalVisitType }

  IXMLIncidentalVisitType = interface(IXMLNode)
    ['{2453C543-E0E4-4E3B-BFA6-E5C74B11432F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsSecondaryType }

  IXMLIsSecondaryType = interface(IXMLNode)
    ['{62106343-7275-48FD-B424-21C1F05845AC}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFinancingSourceType }

  IXMLFinancingSourceType = interface(IXMLNode)
    ['{D0ED89C5-00CE-45FE-A019-284A4A112288}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRhifAreaNumberType }

  IXMLRhifAreaNumberType = interface(IXMLNode)
    ['{FED2F993-5509-4EE8-B5EA-3A940895CAE0}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLAdverseConditionsType }

  IXMLAdverseConditionsType = interface(IXMLNode)
    ['{E4575C39-9360-4156-820A-D9BBD0512693}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{B0DCB14F-B2FE-4AC3-A675-5ED7CE2EE416}']
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
    ['{5FDD6BBE-0AD0-4F7D-B7CE-A92B9F4E3C3F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{9624370F-CA14-443F-9B9D-92EF40CD77D1}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{A2A8CC31-2AFD-4F39-BCC4-F06EDD529AB7}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLComorbidityType }

  IXMLComorbidityType = interface(IXMLNode)
    ['{2C07CAAD-F66E-456A-B80C-3BC4170A71C3}']
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
    ['{1822F449-9EC8-4957-AEC4-A74AD29387EB}']
    { Methods & Properties }
    function Add: IXMLComorbidityType;
    function Insert(const Index: Integer): IXMLComorbidityType;

    function Get_Item(Index: Integer): IXMLComorbidityType;
    property Items[Index: Integer]: IXMLComorbidityType read Get_Item; default;
  end;

{ IXMLMedicalHistoryType }

  IXMLMedicalHistoryType = interface(IXMLNode)
    ['{95020A10-CF5A-43E4-AFEB-26C3283392EE}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLObjectiveConditionType }

  IXMLObjectiveConditionType = interface(IXMLNode)
    ['{EFB49139-CAF0-4872-80B3-D5A180C6DDBC}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAssessmentType }

  IXMLAssessmentType = interface(IXMLNode)
    ['{53BAF70B-A138-4759-9DDE-2A274933E0E1}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLNoteType }

  IXMLNoteType = interface(IXMLNode)
    ['{95D6B1CD-00FC-4437-9B53-858A0E123E9C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTherapyType }

  IXMLTherapyType = interface(IXMLNode)
    ['{FA808AA6-9CAD-4BB1-92CA-5F60516AFF1B}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLSubjectType }

  IXMLSubjectType = interface(IXMLNode)
    ['{B42D9228-5BC4-4A9B-B6B0-44FB3049E9BD}']
    { Property Accessors }
    function Get_IdentifierType: IXMLIdentifierType;
    function Get_Identifier: IXMLIdentifierType;
    function Get_BirthDate: IXMLBirthDateType;
    function Get_Gender: IXMLGenderType;
    function Get_Name: IXMLNameType;
    function Get_Address: IXMLAddressType;
    { Methods & Properties }
    property IdentifierType: IXMLIdentifierType read Get_IdentifierType;
    property Identifier: IXMLIdentifierType read Get_Identifier;
    property BirthDate: IXMLBirthDateType read Get_BirthDate;
    property Gender: IXMLGenderType read Get_Gender;
    property Name: IXMLNameType read Get_Name;
    property Address: IXMLAddressType read Get_Address;
  end;

{ IXMLIdentifierType }

  IXMLIdentifierType = interface(IXMLNode)
    ['{523215F2-6C64-4D5F-B71F-BD16CAE88D18}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBirthDateType }

  IXMLBirthDateType = interface(IXMLNode)
    ['{E945807D-5A6A-4C2A-95E5-AFDEFFD2A7BC}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGenderType }

  IXMLGenderType = interface(IXMLNode)
    ['{3AA626A3-51B8-47D6-8112-11B80D0EBB27}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{9B092A68-22E8-4E63-8B4B-724BD233399B}']
    { Property Accessors }
    function Get_Given: IXMLGivenType;
    function Get_Middle: IXMLMiddleType;
    function Get_Family: IXMLFamilyType;
    { Methods & Properties }
    property Given: IXMLGivenType read Get_Given;
    property Middle: IXMLMiddleType read Get_Middle;
    property Family: IXMLFamilyType read Get_Family;
  end;

{ IXMLGivenType }

  IXMLGivenType = interface(IXMLNode)
    ['{1C704CB6-2A08-4EBF-9F67-75E45D9FCEDF}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMiddleType }

  IXMLMiddleType = interface(IXMLNode)
    ['{760F2A39-57FB-42D1-9228-126CC13B8DAD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFamilyType }

  IXMLFamilyType = interface(IXMLNode)
    ['{71F68A7D-E149-4C2E-82E4-24AE5F0808E8}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{A2082CF8-AB3A-49B1-8021-70B73554F914}']
    { Property Accessors }
    function Get_Country: IXMLCountryType;
    function Get_County: IXMLCountyType;
    function Get_Ekatte: IXMLEkatteType;
    function Get_City: IXMLCityType;
    { Methods & Properties }
    property Country: IXMLCountryType read Get_Country;
    property County: IXMLCountyType read Get_County;
    property Ekatte: IXMLEkatteType read Get_Ekatte;
    property City: IXMLCityType read Get_City;
  end;

{ IXMLCountryType }

  IXMLCountryType = interface(IXMLNode)
    ['{E722D145-CBE0-4055-9B79-8624FBEDEE80}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCountyType }

  IXMLCountyType = interface(IXMLNode)
    ['{C31DA376-E31F-470D-8873-86EA6DE464A2}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLEkatteType }

  IXMLEkatteType = interface(IXMLNode)
    ['{4D2F74CB-67B3-4809-AD27-D1696C448781}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLCityType }

  IXMLCityType = interface(IXMLNode)
    ['{95B1B427-FEDE-492A-A67D-C03F101BDFBE}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPerformerType }

  IXMLPerformerType = interface(IXMLNode)
    ['{3A84271E-7687-460D-9B1B-B5962BE1A625}']
    { Property Accessors }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_Role: IXMLRoleType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
    { Methods & Properties }
    property Pmi: IXMLPmiType read Get_Pmi;
    property Qualification: IXMLQualificationType read Get_Qualification;
    property Role: IXMLRoleType read Get_Role;
    property PracticeNumber: IXMLPracticeNumberType read Get_PracticeNumber;
  end;

{ IXMLPmiType }

  IXMLPmiType = interface(IXMLNode)
    ['{AE6558A8-49C5-490A-BD45-CC6BDDB94FD8}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLQualificationType }

  IXMLQualificationType = interface(IXMLNode)
    ['{B87E3517-B1F4-44FB-839D-8D5AE8360F26}']
    { Property Accessors }
    function Get_Value: Integer;
    function Get_NhifCode: Integer;
    procedure Set_Value(Value: Integer);
    procedure Set_NhifCode(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
    property NhifCode: Integer read Get_NhifCode write Set_NhifCode;
  end;

{ IXMLRoleType }

  IXMLRoleType = interface(IXMLNode)
    ['{A00E4F01-97A1-4D92-B5BA-5DDC0412576A}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPracticeNumberType }

  IXMLPracticeNumberType = interface(IXMLNode)
    ['{43C4F3A7-A645-48E9-94B8-1631585E7FCF}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{68DB1C20-FF7A-4135-BBE9-66DEB5E900B6}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: UnicodeString;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Xmlns(Value: UnicodeString);
    procedure Set_SignatureValue(Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
    property SignedInfo: IXMLSignedInfoType read Get_SignedInfo;
    property SignatureValue: UnicodeString read Get_SignatureValue write Set_SignatureValue;
    property KeyInfo: IXMLKeyInfoType read Get_KeyInfo;
  end;

{ IXMLSignedInfoType }

  IXMLSignedInfoType = interface(IXMLNode)
    ['{BA0E337F-48CC-4666-AD44-C0BB5B190FBE}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethodType;
    function Get_SignatureMethod: IXMLSignatureMethodType;
    function Get_Reference: IXMLReferenceType;
    procedure Set_Xmlns(Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
    property CanonicalizationMethod: IXMLCanonicalizationMethodType read Get_CanonicalizationMethod;
    property SignatureMethod: IXMLSignatureMethodType read Get_SignatureMethod;
    property Reference: IXMLReferenceType read Get_Reference;
  end;

{ IXMLCanonicalizationMethodType }

  IXMLCanonicalizationMethodType = interface(IXMLNode)
    ['{A3F376D6-6719-4925-89EE-CEDE14A58B17}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethodType }

  IXMLSignatureMethodType = interface(IXMLNode)
    ['{B7EDEF09-76A0-4170-AFD6-1A7BBE870D5C}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{E7974C12-C97C-4A0A-BC77-EF6461680F4D}']
    { Property Accessors }
    function Get_URI: UnicodeString;
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethodType;
    function Get_DigestValue: UnicodeString;
    procedure Set_URI(Value: UnicodeString);
    procedure Set_DigestValue(Value: UnicodeString);
    { Methods & Properties }
    property URI: UnicodeString read Get_URI write Set_URI;
    property Transforms: IXMLTransformsType read Get_Transforms;
    property DigestMethod: IXMLDigestMethodType read Get_DigestMethod;
    property DigestValue: UnicodeString read Get_DigestValue write Set_DigestValue;
  end;

{ IXMLTransformsType }

  IXMLTransformsType = interface(IXMLNode)
    ['{8F4FBCB2-330E-4157-A0DA-CF0C1B8366F5}']
    { Property Accessors }
    function Get_Transform: IXMLTransformType;
    { Methods & Properties }
    property Transform: IXMLTransformType read Get_Transform;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNode)
    ['{F24FB5D1-718D-4F9D-96D7-0854A3B7F468}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLDigestMethodType }

  IXMLDigestMethodType = interface(IXMLNode)
    ['{B1EF378D-9C56-461B-B220-70E8243F5882}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{A8D7C1AD-7FC0-4B5D-BEF2-C3C7869C0AD2}']
    { Property Accessors }
    function Get_KeyValue: IXMLKeyValueType;
    function Get_X509Data: IXMLX509DataType;
    { Methods & Properties }
    property KeyValue: IXMLKeyValueType read Get_KeyValue;
    property X509Data: IXMLX509DataType read Get_X509Data;
  end;

{ IXMLKeyValueType }

  IXMLKeyValueType = interface(IXMLNode)
    ['{FF30DFA7-02AE-4873-9D27-E1FD504891E3}']
    { Property Accessors }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
    { Methods & Properties }
    property RSAKeyValue: IXMLRSAKeyValueType read Get_RSAKeyValue;
  end;

{ IXMLRSAKeyValueType }

  IXMLRSAKeyValueType = interface(IXMLNode)
    ['{5A1E1D82-3A64-494A-97CE-F31E196965E8}']
    { Property Accessors }
    function Get_Modulus: UnicodeString;
    function Get_Exponent: UnicodeString;
    procedure Set_Modulus(Value: UnicodeString);
    procedure Set_Exponent(Value: UnicodeString);
    { Methods & Properties }
    property Modulus: UnicodeString read Get_Modulus write Set_Modulus;
    property Exponent: UnicodeString read Get_Exponent write Set_Exponent;
  end;

{ IXMLX509DataType }

  IXMLX509DataType = interface(IXMLNode)
    ['{CAD78756-7DB1-4A10-B82C-AF797ED7B42F}']
    { Property Accessors }
    function Get_X509Certificate: UnicodeString;
    procedure Set_X509Certificate(Value: UnicodeString);
    { Methods & Properties }
    property X509Certificate: UnicodeString read Get_X509Certificate write Set_X509Certificate;
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
  TXMLLrnType = class;
  TXMLOpenDateType = class;
  TXMLCloseDateType = class;
  TXMLBasedOnType = class;
  TXMLClassType = class;
  TXMLPurposeType = class;
  TXMLIncidentalVisitType = class;
  TXMLIsSecondaryType = class;
  TXMLFinancingSourceType = class;
  TXMLRhifAreaNumberType = class;
  TXMLAdverseConditionsType = class;
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
  TXMLSubjectType = class;
  TXMLIdentifierType = class;
  TXMLBirthDateType = class;
  TXMLGenderType = class;
  TXMLNameType = class;
  TXMLGivenType = class;
  TXMLMiddleType = class;
  TXMLFamilyType = class;
  TXMLAddressType = class;
  TXMLCountryType = class;
  TXMLCountyType = class;
  TXMLEkatteType = class;
  TXMLCityType = class;
  TXMLPerformerType = class;
  TXMLPmiType = class;
  TXMLQualificationType = class;
  TXMLRoleType = class;
  TXMLPracticeNumberType = class;
  TXMLSignatureType = class;
  TXMLSignedInfoType = class;
  TXMLCanonicalizationMethodType = class;
  TXMLSignatureMethodType = class;
  TXMLReferenceType = class;
  TXMLTransformsType = class;
  TXMLTransformType = class;
  TXMLDigestMethodType = class;
  TXMLKeyInfoType = class;
  TXMLKeyValueType = class;
  TXMLRSAKeyValueType = class;
  TXMLX509DataType = class;

{ TXMLMessageType }

  TXMLMessageType = class(TXMLNode, IXMLMessageType)
  protected
    { IXMLMessageType }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    function Get_Signature: IXMLSignatureType;
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
    function Get_Subject: IXMLSubjectType;
    function Get_Performer: IXMLPerformerType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLExaminationType }

  TXMLExaminationType = class(TXMLNode, IXMLExaminationType)
  private
    FComorbidity: IXMLComorbidityTypeList;
  protected
    { IXMLExaminationType }
    function Get_Lrn: IXMLLrnType;
    function Get_OpenDate: IXMLOpenDateType;
    function Get_CloseDate: IXMLCloseDateType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_Class_: IXMLClassType;
    function Get_Purpose: IXMLPurposeType;
    function Get_IncidentalVisit: IXMLIncidentalVisitType;
    function Get_IsSecondary: IXMLIsSecondaryType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_AdverseConditions: IXMLAdverseConditionsType;
    function Get_Diagnosis: IXMLDiagnosisType;
    function Get_Comorbidity: IXMLComorbidityTypeList;
    function Get_MedicalHistory: IXMLMedicalHistoryType;
    function Get_ObjectiveCondition: IXMLObjectiveConditionType;
    function Get_Assessment: IXMLAssessmentType;
    function Get_Therapy: IXMLTherapyType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLrnType }

  TXMLLrnType = class(TXMLNode, IXMLLrnType)
  protected
    { IXMLLrnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLOpenDateType }

  TXMLOpenDateType = class(TXMLNode, IXMLOpenDateType)
  protected
    { IXMLOpenDateType }
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

{ TXMLBasedOnType }

  TXMLBasedOnType = class(TXMLNode, IXMLBasedOnType)
  protected
    { IXMLBasedOnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLClassType }

  TXMLClassType = class(TXMLNode, IXMLClassType)
  protected
    { IXMLClassType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
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

{ TXMLIsSecondaryType }

  TXMLIsSecondaryType = class(TXMLNode, IXMLIsSecondaryType)
  protected
    { IXMLIsSecondaryType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLFinancingSourceType }

  TXMLFinancingSourceType = class(TXMLNode, IXMLFinancingSourceType)
  protected
    { IXMLFinancingSourceType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLRhifAreaNumberType }

  TXMLRhifAreaNumberType = class(TXMLNode, IXMLRhifAreaNumberType)
  protected
    { IXMLRhifAreaNumberType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLAdverseConditionsType }

  TXMLAdverseConditionsType = class(TXMLNode, IXMLAdverseConditionsType)
  protected
    { IXMLAdverseConditionsType }
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

{ TXMLSubjectType }

  TXMLSubjectType = class(TXMLNode, IXMLSubjectType)
  protected
    { IXMLSubjectType }
    function Get_IdentifierType: IXMLIdentifierType;
    function Get_Identifier: IXMLIdentifierType;
    function Get_BirthDate: IXMLBirthDateType;
    function Get_Gender: IXMLGenderType;
    function Get_Name: IXMLNameType;
    function Get_Address: IXMLAddressType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIdentifierType }

  TXMLIdentifierType = class(TXMLNode, IXMLIdentifierType)
  protected
    { IXMLIdentifierType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLBirthDateType }

  TXMLBirthDateType = class(TXMLNode, IXMLBirthDateType)
  protected
    { IXMLBirthDateType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLGenderType }

  TXMLGenderType = class(TXMLNode, IXMLGenderType)
  protected
    { IXMLGenderType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLNameType }

  TXMLNameType = class(TXMLNode, IXMLNameType)
  protected
    { IXMLNameType }
    function Get_Given: IXMLGivenType;
    function Get_Middle: IXMLMiddleType;
    function Get_Family: IXMLFamilyType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGivenType }

  TXMLGivenType = class(TXMLNode, IXMLGivenType)
  protected
    { IXMLGivenType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMiddleType }

  TXMLMiddleType = class(TXMLNode, IXMLMiddleType)
  protected
    { IXMLMiddleType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLFamilyType }

  TXMLFamilyType = class(TXMLNode, IXMLFamilyType)
  protected
    { IXMLFamilyType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLAddressType }

  TXMLAddressType = class(TXMLNode, IXMLAddressType)
  protected
    { IXMLAddressType }
    function Get_Country: IXMLCountryType;
    function Get_County: IXMLCountyType;
    function Get_Ekatte: IXMLEkatteType;
    function Get_City: IXMLCityType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCountryType }

  TXMLCountryType = class(TXMLNode, IXMLCountryType)
  protected
    { IXMLCountryType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCountyType }

  TXMLCountyType = class(TXMLNode, IXMLCountyType)
  protected
    { IXMLCountyType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLEkatteType }

  TXMLEkatteType = class(TXMLNode, IXMLEkatteType)
  protected
    { IXMLEkatteType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLCityType }

  TXMLCityType = class(TXMLNode, IXMLCityType)
  protected
    { IXMLCityType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPerformerType }

  TXMLPerformerType = class(TXMLNode, IXMLPerformerType)
  protected
    { IXMLPerformerType }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_Role: IXMLRoleType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPmiType }

  TXMLPmiType = class(TXMLNode, IXMLPmiType)
  protected
    { IXMLPmiType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLQualificationType }

  TXMLQualificationType = class(TXMLNode, IXMLQualificationType)
  protected
    { IXMLQualificationType }
    function Get_Value: Integer;
    function Get_NhifCode: Integer;
    procedure Set_Value(Value: Integer);
    procedure Set_NhifCode(Value: Integer);
  end;

{ TXMLRoleType }

  TXMLRoleType = class(TXMLNode, IXMLRoleType)
  protected
    { IXMLRoleType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLPracticeNumberType }

  TXMLPracticeNumberType = class(TXMLNode, IXMLPracticeNumberType)
  protected
    { IXMLPracticeNumberType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLSignatureType }

  TXMLSignatureType = class(TXMLNode, IXMLSignatureType)
  protected
    { IXMLSignatureType }
    function Get_Xmlns: UnicodeString;
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: UnicodeString;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Xmlns(Value: UnicodeString);
    procedure Set_SignatureValue(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSignedInfoType }

  TXMLSignedInfoType = class(TXMLNode, IXMLSignedInfoType)
  protected
    { IXMLSignedInfoType }
    function Get_Xmlns: UnicodeString;
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethodType;
    function Get_SignatureMethod: IXMLSignatureMethodType;
    function Get_Reference: IXMLReferenceType;
    procedure Set_Xmlns(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCanonicalizationMethodType }

  TXMLCanonicalizationMethodType = class(TXMLNode, IXMLCanonicalizationMethodType)
  protected
    { IXMLCanonicalizationMethodType }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
  end;

{ TXMLSignatureMethodType }

  TXMLSignatureMethodType = class(TXMLNode, IXMLSignatureMethodType)
  protected
    { IXMLSignatureMethodType }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
  end;

{ TXMLReferenceType }

  TXMLReferenceType = class(TXMLNode, IXMLReferenceType)
  protected
    { IXMLReferenceType }
    function Get_URI: UnicodeString;
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethodType;
    function Get_DigestValue: UnicodeString;
    procedure Set_URI(Value: UnicodeString);
    procedure Set_DigestValue(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformsType }

  TXMLTransformsType = class(TXMLNode, IXMLTransformsType)
  protected
    { IXMLTransformsType }
    function Get_Transform: IXMLTransformType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformType }

  TXMLTransformType = class(TXMLNode, IXMLTransformType)
  protected
    { IXMLTransformType }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
  end;

{ TXMLDigestMethodType }

  TXMLDigestMethodType = class(TXMLNode, IXMLDigestMethodType)
  protected
    { IXMLDigestMethodType }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
  end;

{ TXMLKeyInfoType }

  TXMLKeyInfoType = class(TXMLNode, IXMLKeyInfoType)
  protected
    { IXMLKeyInfoType }
    function Get_KeyValue: IXMLKeyValueType;
    function Get_X509Data: IXMLX509DataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLKeyValueType }

  TXMLKeyValueType = class(TXMLNode, IXMLKeyValueType)
  protected
    { IXMLKeyValueType }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRSAKeyValueType }

  TXMLRSAKeyValueType = class(TXMLNode, IXMLRSAKeyValueType)
  protected
    { IXMLRSAKeyValueType }
    function Get_Modulus: UnicodeString;
    function Get_Exponent: UnicodeString;
    procedure Set_Modulus(Value: UnicodeString);
    procedure Set_Exponent(Value: UnicodeString);
  end;

{ TXMLX509DataType }

  TXMLX509DataType = class(TXMLNode, IXMLX509DataType)
  protected
    { IXMLX509DataType }
    function Get_X509Certificate: UnicodeString;
    procedure Set_X509Certificate(Value: UnicodeString);
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
  RegisterChildNode('Signature', TXMLSignatureType);
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

function TXMLMessageType.Get_Signature: IXMLSignatureType;
begin
  Result := ChildNodes['Signature'] as IXMLSignatureType;
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
  RegisterChildNode('subject', TXMLSubjectType);
  RegisterChildNode('performer', TXMLPerformerType);
  inherited;
end;

function TXMLContentsType.Get_Examination: IXMLExaminationType;
begin
  Result := ChildNodes['examination'] as IXMLExaminationType;
end;

function TXMLContentsType.Get_Subject: IXMLSubjectType;
begin
  Result := ChildNodes['subject'] as IXMLSubjectType;
end;

function TXMLContentsType.Get_Performer: IXMLPerformerType;
begin
  Result := ChildNodes['performer'] as IXMLPerformerType;
end;

{ TXMLExaminationType }

procedure TXMLExaminationType.AfterConstruction;
begin
  RegisterChildNode('lrn', TXMLLrnType);
  RegisterChildNode('openDate', TXMLOpenDateType);
  RegisterChildNode('closeDate', TXMLCloseDateType);
  RegisterChildNode('basedOn', TXMLBasedOnType);
  RegisterChildNode('class', TXMLClassType);
  RegisterChildNode('purpose', TXMLPurposeType);
  RegisterChildNode('incidentalVisit', TXMLIncidentalVisitType);
  RegisterChildNode('isSecondary', TXMLIsSecondaryType);
  RegisterChildNode('financingSource', TXMLFinancingSourceType);
  RegisterChildNode('rhifAreaNumber', TXMLRhifAreaNumberType);
  RegisterChildNode('adverseConditions', TXMLAdverseConditionsType);
  RegisterChildNode('diagnosis', TXMLDiagnosisType);
  RegisterChildNode('comorbidity', TXMLComorbidityType);
  RegisterChildNode('medicalHistory', TXMLMedicalHistoryType);
  RegisterChildNode('objectiveCondition', TXMLObjectiveConditionType);
  RegisterChildNode('assessment', TXMLAssessmentType);
  RegisterChildNode('therapy', TXMLTherapyType);
  FComorbidity := CreateCollection(TXMLComorbidityTypeList, IXMLComorbidityType, 'comorbidity') as IXMLComorbidityTypeList;
  inherited;
end;

function TXMLExaminationType.Get_Lrn: IXMLLrnType;
begin
  Result := ChildNodes['lrn'] as IXMLLrnType;
end;

function TXMLExaminationType.Get_OpenDate: IXMLOpenDateType;
begin
  Result := ChildNodes['openDate'] as IXMLOpenDateType;
end;

function TXMLExaminationType.Get_CloseDate: IXMLCloseDateType;
begin
  Result := ChildNodes['closeDate'] as IXMLCloseDateType;
end;

function TXMLExaminationType.Get_BasedOn: IXMLBasedOnType;
begin
  Result := ChildNodes['basedOn'] as IXMLBasedOnType;
end;

function TXMLExaminationType.Get_Class_: IXMLClassType;
begin
  Result := ChildNodes['class'] as IXMLClassType;
end;

function TXMLExaminationType.Get_Purpose: IXMLPurposeType;
begin
  Result := ChildNodes['purpose'] as IXMLPurposeType;
end;

function TXMLExaminationType.Get_IncidentalVisit: IXMLIncidentalVisitType;
begin
  Result := ChildNodes['incidentalVisit'] as IXMLIncidentalVisitType;
end;

function TXMLExaminationType.Get_IsSecondary: IXMLIsSecondaryType;
begin
  Result := ChildNodes['isSecondary'] as IXMLIsSecondaryType;
end;

function TXMLExaminationType.Get_FinancingSource: IXMLFinancingSourceType;
begin
  Result := ChildNodes['financingSource'] as IXMLFinancingSourceType;
end;

function TXMLExaminationType.Get_RhifAreaNumber: IXMLRhifAreaNumberType;
begin
  Result := ChildNodes['rhifAreaNumber'] as IXMLRhifAreaNumberType;
end;

function TXMLExaminationType.Get_AdverseConditions: IXMLAdverseConditionsType;
begin
  Result := ChildNodes['adverseConditions'] as IXMLAdverseConditionsType;
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

{ TXMLLrnType }

function TXMLLrnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLrnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLOpenDateType }

function TXMLOpenDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLOpenDateType.Set_Value(Value: UnicodeString);
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

{ TXMLBasedOnType }

function TXMLBasedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLBasedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLClassType }

function TXMLClassType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLClassType.Set_Value(Value: Integer);
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

{ TXMLIsSecondaryType }

function TXMLIsSecondaryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIsSecondaryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLFinancingSourceType }

function TXMLFinancingSourceType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLFinancingSourceType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLRhifAreaNumberType }

function TXMLRhifAreaNumberType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRhifAreaNumberType.Set_Value(Value: Integer);
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

{ TXMLSubjectType }

procedure TXMLSubjectType.AfterConstruction;
begin
  RegisterChildNode('identifierType', TXMLIdentifierType);
  RegisterChildNode('identifier', TXMLIdentifierType);
  RegisterChildNode('birthDate', TXMLBirthDateType);
  RegisterChildNode('gender', TXMLGenderType);
  RegisterChildNode('name', TXMLNameType);
  RegisterChildNode('address', TXMLAddressType);
  inherited;
end;

function TXMLSubjectType.Get_IdentifierType: IXMLIdentifierType;
begin
  Result := ChildNodes['identifierType'] as IXMLIdentifierType;
end;

function TXMLSubjectType.Get_Identifier: IXMLIdentifierType;
begin
  Result := ChildNodes['identifier'] as IXMLIdentifierType;
end;

function TXMLSubjectType.Get_BirthDate: IXMLBirthDateType;
begin
  Result := ChildNodes['birthDate'] as IXMLBirthDateType;
end;

function TXMLSubjectType.Get_Gender: IXMLGenderType;
begin
  Result := ChildNodes['gender'] as IXMLGenderType;
end;

function TXMLSubjectType.Get_Name: IXMLNameType;
begin
  Result := ChildNodes['name'] as IXMLNameType;
end;

function TXMLSubjectType.Get_Address: IXMLAddressType;
begin
  Result := ChildNodes['address'] as IXMLAddressType;
end;

{ TXMLIdentifierType }

function TXMLIdentifierType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLIdentifierType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLBirthDateType }

function TXMLBirthDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLBirthDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLGenderType }

function TXMLGenderType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLGenderType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLNameType }

procedure TXMLNameType.AfterConstruction;
begin
  RegisterChildNode('given', TXMLGivenType);
  RegisterChildNode('middle', TXMLMiddleType);
  RegisterChildNode('family', TXMLFamilyType);
  inherited;
end;

function TXMLNameType.Get_Given: IXMLGivenType;
begin
  Result := ChildNodes['given'] as IXMLGivenType;
end;

function TXMLNameType.Get_Middle: IXMLMiddleType;
begin
  Result := ChildNodes['middle'] as IXMLMiddleType;
end;

function TXMLNameType.Get_Family: IXMLFamilyType;
begin
  Result := ChildNodes['family'] as IXMLFamilyType;
end;

{ TXMLGivenType }

function TXMLGivenType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLGivenType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMiddleType }

function TXMLMiddleType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMiddleType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLFamilyType }

function TXMLFamilyType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLFamilyType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLAddressType }

procedure TXMLAddressType.AfterConstruction;
begin
  RegisterChildNode('country', TXMLCountryType);
  RegisterChildNode('county', TXMLCountyType);
  RegisterChildNode('ekatte', TXMLEkatteType);
  RegisterChildNode('city', TXMLCityType);
  inherited;
end;

function TXMLAddressType.Get_Country: IXMLCountryType;
begin
  Result := ChildNodes['country'] as IXMLCountryType;
end;

function TXMLAddressType.Get_County: IXMLCountyType;
begin
  Result := ChildNodes['county'] as IXMLCountyType;
end;

function TXMLAddressType.Get_Ekatte: IXMLEkatteType;
begin
  Result := ChildNodes['ekatte'] as IXMLEkatteType;
end;

function TXMLAddressType.Get_City: IXMLCityType;
begin
  Result := ChildNodes['city'] as IXMLCityType;
end;

{ TXMLCountryType }

function TXMLCountryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCountryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCountyType }

function TXMLCountyType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCountyType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLEkatteType }

function TXMLEkatteType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLEkatteType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLCityType }

function TXMLCityType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCityType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPerformerType }

procedure TXMLPerformerType.AfterConstruction;
begin
  RegisterChildNode('pmi', TXMLPmiType);
  RegisterChildNode('qualification', TXMLQualificationType);
  RegisterChildNode('role', TXMLRoleType);
  RegisterChildNode('practiceNumber', TXMLPracticeNumberType);
  inherited;
end;

function TXMLPerformerType.Get_Pmi: IXMLPmiType;
begin
  Result := ChildNodes['pmi'] as IXMLPmiType;
end;

function TXMLPerformerType.Get_Qualification: IXMLQualificationType;
begin
  Result := ChildNodes['qualification'] as IXMLQualificationType;
end;

function TXMLPerformerType.Get_Role: IXMLRoleType;
begin
  Result := ChildNodes['role'] as IXMLRoleType;
end;

function TXMLPerformerType.Get_PracticeNumber: IXMLPracticeNumberType;
begin
  Result := ChildNodes['practiceNumber'] as IXMLPracticeNumberType;
end;

{ TXMLPmiType }

function TXMLPmiType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPmiType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLQualificationType }

function TXMLQualificationType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLQualificationType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

function TXMLQualificationType.Get_NhifCode: Integer;
begin
  Result := AttributeNodes['nhifCode'].NodeValue;
end;

procedure TXMLQualificationType.Set_NhifCode(Value: Integer);
begin
  SetAttribute('nhifCode', Value);
end;

{ TXMLRoleType }

function TXMLRoleType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRoleType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLPracticeNumberType }

function TXMLPracticeNumberType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPracticeNumberType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLSignatureType }

procedure TXMLSignatureType.AfterConstruction;
begin
  RegisterChildNode('SignedInfo', TXMLSignedInfoType);
  RegisterChildNode('KeyInfo', TXMLKeyInfoType);
  inherited;
end;

function TXMLSignatureType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLSignatureType.Set_Xmlns(Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

function TXMLSignatureType.Get_SignedInfo: IXMLSignedInfoType;
begin
  Result := ChildNodes['SignedInfo'] as IXMLSignedInfoType;
end;

function TXMLSignatureType.Get_SignatureValue: UnicodeString;
begin
  Result := ChildNodes['SignatureValue'].Text;
end;

procedure TXMLSignatureType.Set_SignatureValue(Value: UnicodeString);
begin
  ChildNodes['SignatureValue'].NodeValue := Value;
end;

function TXMLSignatureType.Get_KeyInfo: IXMLKeyInfoType;
begin
  Result := ChildNodes['KeyInfo'] as IXMLKeyInfoType;
end;

{ TXMLSignedInfoType }

procedure TXMLSignedInfoType.AfterConstruction;
begin
  RegisterChildNode('CanonicalizationMethod', TXMLCanonicalizationMethodType);
  RegisterChildNode('SignatureMethod', TXMLSignatureMethodType);
  RegisterChildNode('Reference', TXMLReferenceType);
  inherited;
end;

function TXMLSignedInfoType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLSignedInfoType.Set_Xmlns(Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

function TXMLSignedInfoType.Get_CanonicalizationMethod: IXMLCanonicalizationMethodType;
begin
  Result := ChildNodes['CanonicalizationMethod'] as IXMLCanonicalizationMethodType;
end;

function TXMLSignedInfoType.Get_SignatureMethod: IXMLSignatureMethodType;
begin
  Result := ChildNodes['SignatureMethod'] as IXMLSignatureMethodType;
end;

function TXMLSignedInfoType.Get_Reference: IXMLReferenceType;
begin
  Result := ChildNodes['Reference'] as IXMLReferenceType;
end;

{ TXMLCanonicalizationMethodType }

function TXMLCanonicalizationMethodType.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLCanonicalizationMethodType.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLSignatureMethodType }

function TXMLSignatureMethodType.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLSignatureMethodType.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLReferenceType }

procedure TXMLReferenceType.AfterConstruction;
begin
  RegisterChildNode('Transforms', TXMLTransformsType);
  RegisterChildNode('DigestMethod', TXMLDigestMethodType);
  inherited;
end;

function TXMLReferenceType.Get_URI: UnicodeString;
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TXMLReferenceType.Set_URI(Value: UnicodeString);
begin
  SetAttribute('URI', Value);
end;

function TXMLReferenceType.Get_Transforms: IXMLTransformsType;
begin
  Result := ChildNodes['Transforms'] as IXMLTransformsType;
end;

function TXMLReferenceType.Get_DigestMethod: IXMLDigestMethodType;
begin
  Result := ChildNodes['DigestMethod'] as IXMLDigestMethodType;
end;

function TXMLReferenceType.Get_DigestValue: UnicodeString;
begin
  Result := ChildNodes['DigestValue'].Text;
end;

procedure TXMLReferenceType.Set_DigestValue(Value: UnicodeString);
begin
  ChildNodes['DigestValue'].NodeValue := Value;
end;

{ TXMLTransformsType }

procedure TXMLTransformsType.AfterConstruction;
begin
  RegisterChildNode('Transform', TXMLTransformType);
  inherited;
end;

function TXMLTransformsType.Get_Transform: IXMLTransformType;
begin
  Result := ChildNodes['Transform'] as IXMLTransformType;
end;

{ TXMLTransformType }

function TXMLTransformType.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLTransformType.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLDigestMethodType }

function TXMLDigestMethodType.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLDigestMethodType.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLKeyInfoType }

procedure TXMLKeyInfoType.AfterConstruction;
begin
  RegisterChildNode('KeyValue', TXMLKeyValueType);
  RegisterChildNode('X509Data', TXMLX509DataType);
  inherited;
end;

function TXMLKeyInfoType.Get_KeyValue: IXMLKeyValueType;
begin
  Result := ChildNodes['KeyValue'] as IXMLKeyValueType;
end;

function TXMLKeyInfoType.Get_X509Data: IXMLX509DataType;
begin
  Result := ChildNodes['X509Data'] as IXMLX509DataType;
end;

{ TXMLKeyValueType }

procedure TXMLKeyValueType.AfterConstruction;
begin
  RegisterChildNode('RSAKeyValue', TXMLRSAKeyValueType);
  inherited;
end;

function TXMLKeyValueType.Get_RSAKeyValue: IXMLRSAKeyValueType;
begin
  Result := ChildNodes['RSAKeyValue'] as IXMLRSAKeyValueType;
end;

{ TXMLRSAKeyValueType }

function TXMLRSAKeyValueType.Get_Modulus: UnicodeString;
begin
  Result := ChildNodes['Modulus'].Text;
end;

procedure TXMLRSAKeyValueType.Set_Modulus(Value: UnicodeString);
begin
  ChildNodes['Modulus'].NodeValue := Value;
end;

function TXMLRSAKeyValueType.Get_Exponent: UnicodeString;
begin
  Result := ChildNodes['Exponent'].Text;
end;

procedure TXMLRSAKeyValueType.Set_Exponent(Value: UnicodeString);
begin
  ChildNodes['Exponent'].NodeValue := Value;
end;

{ TXMLX509DataType }

function TXMLX509DataType.Get_X509Certificate: UnicodeString;
begin
  Result := ChildNodes['X509Certificate'].Text;
end;

procedure TXMLX509DataType.Set_X509Certificate(Value: UnicodeString);
begin
  ChildNodes['X509Certificate'].NodeValue := Value;
end;

end.