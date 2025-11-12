
{**********************************************************************************************************************************************************************************************************************************************}
{                                                                                                                                                                                                                                              }
{                                                                                                               XML Data Binding                                                                                                               }
{                                                                                                                                                                                                                                              }
{         Generated on: 31.10.2025 г. 15:45:29                                                                                                                                                                                                 }
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
    ['{A98FAF96-BD44-433F-BC82-171F94DD91D5}']
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
    ['{F132747B-4DF8-46CC-A3A2-AC3D538DC2A1}']
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
    ['{35684E20-66DA-48F0-B292-2EC14D385FEA}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{B2D0D65E-8490-4861-B9CD-88DEB313FFB4}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{10EBAB4F-B3C0-407E-95F0-44D5F9821534}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{96F5697C-AAF3-45C7-B608-B85EFF0E38B1}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{62343CD7-C123-4211-9DF9-F2965BE9BC3D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{5F33338C-89A8-4EEE-A972-9B707A9364D7}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{12ABBD73-EED9-461B-8529-CBA8FB4864AA}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{61ED518C-C3F9-4D63-A088-C5ED6DC7AEBB}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{8CD2B82F-67DF-4A56-956B-0378329DFFAA}']
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
    ['{442987AD-B123-4BD9-8793-C75AEBDFE3A5}']
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
    ['{F76E92EE-02F5-4981-B637-99E14C21E4FE}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLOpenDateType }

  IXMLOpenDateType = interface(IXMLNode)
    ['{25816BE8-1EEE-4ED3-89A1-7CD5904954DD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCloseDateType }

  IXMLCloseDateType = interface(IXMLNode)
    ['{DC0B9020-27FA-431E-A17C-BE1CF89AE0A8}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{B4457065-E9B9-49C0-A88E-F661EEDB97C7}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLClassType }

  IXMLClassType = interface(IXMLNode)
    ['{3B6BA2B0-F78A-425C-9E21-0DC46A17D0CB}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPurposeType }

  IXMLPurposeType = interface(IXMLNode)
    ['{785350C4-EC87-4F20-AF3B-0186BD6D30E5}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLIncidentalVisitType }

  IXMLIncidentalVisitType = interface(IXMLNode)
    ['{09539D45-BFE3-49F7-9EF0-42D849296FE9}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsSecondaryType }

  IXMLIsSecondaryType = interface(IXMLNode)
    ['{42DB6071-B2C5-4C79-AD84-5E45898B39CC}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFinancingSourceType }

  IXMLFinancingSourceType = interface(IXMLNode)
    ['{A8055C43-05FB-453C-82E3-202CAE9BFC39}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRhifAreaNumberType }

  IXMLRhifAreaNumberType = interface(IXMLNode)
    ['{45EFA731-DF46-417D-9F56-3C740C537CB5}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLAdverseConditionsType }

  IXMLAdverseConditionsType = interface(IXMLNode)
    ['{33628B23-59FE-44A6-ABB8-73EC779CF7B0}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{931A7C24-5AC8-4552-AFBB-7D4D0DC0B3E6}']
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
    ['{03C0A567-6DE2-4597-9639-70A58C98937D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAdditionalCodeType }

  IXMLAdditionalCodeType = interface(IXMLNode)
    ['{E061AFF1-C973-4CC1-8DBD-7FBA332954B9}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{2AA1CDEC-132B-4106-AACB-3ADD9CF6E262}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{9ECB60AC-63CC-4EE5-83D0-22A7C0A9E116}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLComorbidityType }

  IXMLComorbidityType = interface(IXMLNode)
    ['{DC71B174-9982-4763-AFD2-278DAE856683}']
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
    ['{6226BA14-A4F4-45FB-AF33-D0C508C95FDB}']
    { Methods & Properties }
    function Add: IXMLComorbidityType;
    function Insert(const Index: Integer): IXMLComorbidityType;

    function Get_Item(Index: Integer): IXMLComorbidityType;
    property Items[Index: Integer]: IXMLComorbidityType read Get_Item; default;
  end;

{ IXMLMedicalHistoryType }

  IXMLMedicalHistoryType = interface(IXMLNode)
    ['{C729DAA6-118E-4C22-B8FA-329D41E8E71F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLObjectiveConditionType }

  IXMLObjectiveConditionType = interface(IXMLNode)
    ['{3512D618-31A9-4D7E-AC19-DE259779EC00}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAssessmentType }

  IXMLAssessmentType = interface(IXMLNode)
    ['{EBB6D5F1-B867-4C50-83B4-7785480A5470}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLNoteType }

  IXMLNoteType = interface(IXMLNode)
    ['{02AC2380-63C5-4678-BD9A-E1E0317E15B6}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTherapyType }

  IXMLTherapyType = interface(IXMLNode)
    ['{21D7485C-C56D-48A4-B8F2-078FA64BEA90}']
    { Property Accessors }
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLSubjectType }

  IXMLSubjectType = interface(IXMLNode)
    ['{DFB25D0B-CE0C-4819-A460-D17D043E6D85}']
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
    ['{278A1428-166D-4511-A9B4-3F5DF2D02C53}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBirthDateType }

  IXMLBirthDateType = interface(IXMLNode)
    ['{86933A6B-33F7-4C0F-8340-BB00DDB78457}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGenderType }

  IXMLGenderType = interface(IXMLNode)
    ['{D95E8696-0210-4C9D-AD68-E1EB2570A75F}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{0FE5CE26-4DBC-41C7-B0E8-AE79C3B297C5}']
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
    ['{E82922A7-6462-4D52-AF8D-6389B792FB7C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMiddleType }

  IXMLMiddleType = interface(IXMLNode)
    ['{5EE4914A-8CB3-4931-9629-5BA51EEAB7B7}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFamilyType }

  IXMLFamilyType = interface(IXMLNode)
    ['{06FC74F1-B274-4472-AB96-1396FA796B7B}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{B2EEA172-DA3F-4AB6-9089-66EAAEDF52D6}']
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
    ['{96C84D50-21F8-4D9B-8567-079464DD7E06}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCountyType }

  IXMLCountyType = interface(IXMLNode)
    ['{F2310993-04FC-4FDA-AA37-5DE6BEFB3E6C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLEkatteType }

  IXMLEkatteType = interface(IXMLNode)
    ['{19E87DB5-76F5-46DA-86B6-5493AE12C001}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCityType }

  IXMLCityType = interface(IXMLNode)
    ['{BD6C644C-D608-40C7-A809-C0E68136071A}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPerformerType }

  IXMLPerformerType = interface(IXMLNode)
    ['{7962CF22-1C58-4FEE-A27E-9683B5FFE1B8}']
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
    ['{56BE69BB-99B8-488B-97C4-0440FFA1A694}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLQualificationType }

  IXMLQualificationType = interface(IXMLNode)
    ['{B3E1CD6B-91FB-4C19-ADAF-E453836C7816}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    function Get_NhifCode: Integer;
    procedure Set_Value(Value: UnicodeString);
    procedure Set_NhifCode(Value: Integer);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
    property NhifCode: Integer read Get_NhifCode write Set_NhifCode;
  end;

{ IXMLRoleType }

  IXMLRoleType = interface(IXMLNode)
    ['{690E345F-A862-4CD3-9219-488A90F3DFAA}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPracticeNumberType }

  IXMLPracticeNumberType = interface(IXMLNode)
    ['{1BFFCE89-8F41-4059-A4C2-9EF691178C3E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{BA86B450-DD94-48C2-AD0C-CA6687E26D4D}']
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
    ['{A63E4FEC-791C-45BC-93FC-30DB9DE2EDAC}']
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
    ['{8D5B80EE-EFDF-4D76-8FE2-3A071BD74857}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethodType }

  IXMLSignatureMethodType = interface(IXMLNode)
    ['{DCAA703A-7927-4916-BAC7-E964794BD3AE}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{9499975C-DF6F-42E3-9FCF-E2E3950ADF5B}']
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
    ['{42813889-DF9D-42FE-993E-11B73DAC8B02}']
    { Property Accessors }
    function Get_Transform: IXMLTransformType;
    { Methods & Properties }
    property Transform: IXMLTransformType read Get_Transform;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNode)
    ['{5D66C328-96CC-4B04-A15E-8DB35DC921C4}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLDigestMethodType }

  IXMLDigestMethodType = interface(IXMLNode)
    ['{DE2345DE-3797-4CE9-A16A-60226D1C7712}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{9E37A28D-C9B6-4BDC-B43C-A49E854C5B80}']
    { Property Accessors }
    function Get_KeyValue: IXMLKeyValueType;
    function Get_X509Data: IXMLX509DataType;
    { Methods & Properties }
    property KeyValue: IXMLKeyValueType read Get_KeyValue;
    property X509Data: IXMLX509DataType read Get_X509Data;
  end;

{ IXMLKeyValueType }

  IXMLKeyValueType = interface(IXMLNode)
    ['{04832DC3-B5C1-4A88-A699-8CAEE4712658}']
    { Property Accessors }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
    { Methods & Properties }
    property RSAKeyValue: IXMLRSAKeyValueType read Get_RSAKeyValue;
  end;

{ IXMLRSAKeyValueType }

  IXMLRSAKeyValueType = interface(IXMLNode)
    ['{54BBFB28-E105-4078-9D74-8271D3AB1CC5}']
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
    ['{E3EED682-FBBD-4F81-B1F2-16F2012280ED}']
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
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
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
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLQualificationType }

  TXMLQualificationType = class(TXMLNode, IXMLQualificationType)
  protected
    { IXMLQualificationType }
    function Get_Value: UnicodeString;
    function Get_NhifCode: Integer;
    procedure Set_Value(Value: UnicodeString);
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
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
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
  Result := AttributeNodes['value'].Text;
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

function TXMLEkatteType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLEkatteType.Set_Value(Value: UnicodeString);
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

function TXMLPmiType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLPmiType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLQualificationType }

function TXMLQualificationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLQualificationType.Set_Value(Value: UnicodeString);
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

function TXMLPracticeNumberType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLPracticeNumberType.Set_Value(Value: UnicodeString);
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