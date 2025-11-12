
{**********************************************************************************************************************************************************************************************************************************************}
{                                                                                                                                                                                                                                              }
{                                                                                                               XML Data Binding                                                                                                               }
{                                                                                                                                                                                                                                              }
{         Generated on: 3.11.2025 г. 12:09:46                                                                                                                                                                                                  }
{       Generated from: C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\R001.xml   }
{   Settings stored in: C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\R001.xdb   }
{                                                                                                                                                                                                                                              }
{**********************************************************************************************************************************************************************************************************************************************}

unit msgR001;

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
  IXMLReferralType = interface;
  IXMLLrnType = interface;
  IXMLAuthoredOnType = interface;
  IXMLCategoryType = interface;
  IXMLTypeType = interface;
  IXMLRhifAreaNumberType = interface;
  IXMLBasedOnType = interface;
  IXMLFinancingSourceType = interface;
  IXMLLaboratoryType = interface;
  IXMLCodeType = interface;
  IXMLConsultationType = interface;
  IXMLQualificationType = interface;
  IXMLQualificationTypeList = interface;
  IXMLHospitalizationType = interface;
  IXMLAdmissionType = interface;
  IXMLDirectedByType = interface;
  IXMLClinicalPathwayType = interface;
  IXMLOutpatientProcedureType = interface;
  IXMLMedicalExpertiseType = interface;
  IXMLExamType = interface;
  IXMLExamTypeList = interface;
  IXMLDiagnosisType = interface;
  IXMLUseType = interface;
  IXMLRankType = interface;
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
  IXMLRequesterType = interface;
  IXMLPmiType = interface;
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
    ['{A89A82A6-B757-47F6-A98C-2E2BF8E4E073}']
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
    ['{5A8FCDBA-C979-492F-9E25-DE623F7ADAF4}']
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
    ['{2E101232-1369-4D60-BB3E-5FD2156E76A0}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{359B3C73-EC75-471C-9AE9-49392010CB96}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{82703A49-E97D-47AE-A825-36451D489B6E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{F06C1B12-4308-4BA5-AED2-DD7EE240AAF8}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{B3E5AC86-9474-4F29-A18D-79C720A476D4}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{D970C57C-059C-466F-852F-AB3653B48052}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{C3F74167-FD21-45AA-A0E4-DCD983533FFE}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{2633020E-E188-4999-9610-9C793D8590A9}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{AF03B11E-233E-4BE2-8C34-5A0096C4FF96}']
    { Property Accessors }
    function Get_Referral: IXMLReferralType;
    function Get_Subject: IXMLSubjectType;
    function Get_Requester: IXMLRequesterType;
    { Methods & Properties }
    property Referral: IXMLReferralType read Get_Referral;
    property Subject: IXMLSubjectType read Get_Subject;
    property Requester: IXMLRequesterType read Get_Requester;
  end;

{ IXMLReferralType }

  IXMLReferralType = interface(IXMLNode)
    ['{7C95D5A5-63A6-45AE-86FB-9CACC50402F4}']
    { Property Accessors }
    function Get_Lrn: IXMLLrnType;
    function Get_AuthoredOn: IXMLAuthoredOnType;
    function Get_Category: IXMLCategoryType;
    function Get_Type_: IXMLTypeType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_Laboratory: IXMLLaboratoryType;
    function Get_Consultation: IXMLConsultationType;
    function Get_Hospitalization: IXMLHospitalizationType;
    function Get_MedicalExpertise: IXMLMedicalExpertiseType;
    function Get_Diagnosis: IXMLDiagnosisType;
    { Methods & Properties }
    property Lrn: IXMLLrnType read Get_Lrn;
    property AuthoredOn: IXMLAuthoredOnType read Get_AuthoredOn;
    property Category: IXMLCategoryType read Get_Category;
    property Type_: IXMLTypeType read Get_Type_;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
    property BasedOn: IXMLBasedOnType read Get_BasedOn;
    property FinancingSource: IXMLFinancingSourceType read Get_FinancingSource;
    property Laboratory: IXMLLaboratoryType read Get_Laboratory;
    property Consultation: IXMLConsultationType read Get_Consultation;
    property Hospitalization: IXMLHospitalizationType read Get_Hospitalization;
    property MedicalExpertise: IXMLMedicalExpertiseType read Get_MedicalExpertise;
    property Diagnosis: IXMLDiagnosisType read Get_Diagnosis;
  end;

{ IXMLLrnType }

  IXMLLrnType = interface(IXMLNode)
    ['{612FDA81-AD86-4E96-9CEB-D5CD16084F0D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAuthoredOnType }

  IXMLAuthoredOnType = interface(IXMLNode)
    ['{817310F2-12A6-4577-B08B-93671BCAE0E5}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCategoryType }

  IXMLCategoryType = interface(IXMLNode)
    ['{D574A5CC-17DC-4828-B9BF-06157A7A4A9A}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTypeType }

  IXMLTypeType = interface(IXMLNode)
    ['{B0B66E19-28D8-40A6-BD44-B4F26A893A3D}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRhifAreaNumberType }

  IXMLRhifAreaNumberType = interface(IXMLNode)
    ['{E3B36C7F-9A3B-4242-80D7-B7E72984E240}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{61C8AC3F-A547-49A8-B116-3468680DA978}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFinancingSourceType }

  IXMLFinancingSourceType = interface(IXMLNode)
    ['{7929A3E1-EF2F-4475-AFBC-859622903F13}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLLaboratoryType }

  IXMLLaboratoryType = interface(IXMLNodeCollection)
    ['{AEAE1E3F-AC1E-4F34-8880-B8932CA0F44C}']
    { Property Accessors }
    function Get_Code(Index: Integer): IXMLCodeType;
    { Methods & Properties }
    function Add: IXMLCodeType;
    function Insert(const Index: Integer): IXMLCodeType;
    property Code[Index: Integer]: IXMLCodeType read Get_Code; default;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{110D7498-48E3-4391-B9FA-A415440212C3}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLConsultationType }

  IXMLConsultationType = interface(IXMLNodeCollection)
    ['{32607EB2-B865-4B44-805A-D0C22C21A5AB}']
    { Property Accessors }
    function Get_Qualification(Index: Integer): IXMLQualificationType;
    { Methods & Properties }
    function Add: IXMLQualificationType;
    function Insert(const Index: Integer): IXMLQualificationType;
    property Qualification[Index: Integer]: IXMLQualificationType read Get_Qualification; default;
  end;

{ IXMLQualificationType }

  IXMLQualificationType = interface(IXMLNode)
    ['{2617D857-A6F8-4CA0-889F-A105F85B275F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    function Get_NhifCode: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    procedure Set_NhifCode(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
    property NhifCode: UnicodeString read Get_NhifCode write Set_NhifCode;
  end;

{ IXMLQualificationTypeList }

  IXMLQualificationTypeList = interface(IXMLNodeCollection)
    ['{9380AB77-F29F-4B73-AAC5-7FCEBFCFFBB1}']
    { Methods & Properties }
    function Add: IXMLQualificationType;
    function Insert(const Index: Integer): IXMLQualificationType;

    function Get_Item(Index: Integer): IXMLQualificationType;
    property Items[Index: Integer]: IXMLQualificationType read Get_Item; default;
  end;

{ IXMLHospitalizationType }

  IXMLHospitalizationType = interface(IXMLNode)
    ['{5981F905-FFA9-4427-84FF-2BB5603B64BC}']
    { Property Accessors }
    function Get_AdmissionType: IXMLAdmissionType;
    function Get_DirectedBy: IXMLDirectedByType;
    function Get_ClinicalPathway: IXMLClinicalPathwayType;
    function Get_OutpatientProcedure: IXMLOutpatientProcedureType;
    { Methods & Properties }
    property AdmissionType: IXMLAdmissionType read Get_AdmissionType;
    property DirectedBy: IXMLDirectedByType read Get_DirectedBy;
    property ClinicalPathway: IXMLClinicalPathwayType read Get_ClinicalPathway;
    property OutpatientProcedure: IXMLOutpatientProcedureType read Get_OutpatientProcedure;
  end;

{ IXMLAdmissionType }

  IXMLAdmissionType = interface(IXMLNode)
    ['{9269219D-4C35-4CE2-9EE1-46BC2FEC53E4}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLDirectedByType }

  IXMLDirectedByType = interface(IXMLNode)
    ['{DB3EB0D7-1926-4544-AB20-C0A55D7DBA68}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLClinicalPathwayType }

  IXMLClinicalPathwayType = interface(IXMLNode)
    ['{823A4120-4CD4-4395-A7AB-2BE6DFCD1BAF}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLOutpatientProcedureType }

  IXMLOutpatientProcedureType = interface(IXMLNode)
    ['{135C68D8-575F-41C9-A4EB-E5EB847C9CC3}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMedicalExpertiseType }

  IXMLMedicalExpertiseType = interface(IXMLNode)
    ['{0169B8B4-A987-4C3D-8CB8-178F7CB551E3}']
    { Property Accessors }
    function Get_Qualification: IXMLQualificationTypeList;
    function Get_ExamType: IXMLExamTypeList;
    { Methods & Properties }
    property Qualification: IXMLQualificationTypeList read Get_Qualification;
    property ExamType: IXMLExamTypeList read Get_ExamType;
  end;

{ IXMLExamType }

  IXMLExamType = interface(IXMLNode)
    ['{15C10A4F-D08C-4775-A660-2BE2B8C2A9D4}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLExamTypeList }

  IXMLExamTypeList = interface(IXMLNodeCollection)
    ['{563FF60A-4437-45B9-A431-D81CE441267E}']
    { Methods & Properties }
    function Add: IXMLExamType;
    function Insert(const Index: Integer): IXMLExamType;

    function Get_Item(Index: Integer): IXMLExamType;
    property Items[Index: Integer]: IXMLExamType read Get_Item; default;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{C1C966B8-97D8-42AB-A07D-2DBDB9BB483D}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{AB27DCA3-91EB-48C6-AF7C-AFA247DD116A}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{039FB089-8690-442B-A389-2AFBD5403112}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSubjectType }

  IXMLSubjectType = interface(IXMLNode)
    ['{E76ECE74-3649-4738-851A-F45F3B22B92B}']
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
    ['{95E30A73-D832-4091-9721-F37B528A1DF3}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLBirthDateType }

  IXMLBirthDateType = interface(IXMLNode)
    ['{BEF1F222-EEEC-45A7-A94E-52EBB3F8515D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGenderType }

  IXMLGenderType = interface(IXMLNode)
    ['{C4B80AFF-9618-4239-922E-94D666D6B513}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{023461B6-8D41-48C2-B25A-2D63675F299C}']
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
    ['{72414576-7BC2-498E-A2CD-0EF1D8898453}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMiddleType }

  IXMLMiddleType = interface(IXMLNode)
    ['{180F2C21-BE23-419D-98BE-3876889CA210}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFamilyType }

  IXMLFamilyType = interface(IXMLNode)
    ['{CEDA7059-B1EF-4F4C-99B4-69E44D229578}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{5CC94DA6-8424-4C04-A1A6-CAE4D7887BB4}']
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
    ['{8917B4AB-F35F-490E-9CCA-86D1E7F25BD8}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCountyType }

  IXMLCountyType = interface(IXMLNode)
    ['{6BF23047-6680-415A-8548-DA561F6476CA}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLEkatteType }

  IXMLEkatteType = interface(IXMLNode)
    ['{A682E5ED-056B-4D86-AFA5-D159F6AC0107}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLCityType }

  IXMLCityType = interface(IXMLNode)
    ['{1943B0F1-C18A-4D9B-9710-A9B77F86E748}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRequesterType }

  IXMLRequesterType = interface(IXMLNode)
    ['{A51C3245-C497-4632-90B7-EF59DACEAC3D}']
    { Property Accessors }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_Role: IXMLRoleType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    { Methods & Properties }
    property Pmi: IXMLPmiType read Get_Pmi;
    property Qualification: IXMLQualificationType read Get_Qualification;
    property Role: IXMLRoleType read Get_Role;
    property PracticeNumber: IXMLPracticeNumberType read Get_PracticeNumber;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
  end;

{ IXMLPmiType }

  IXMLPmiType = interface(IXMLNode)
    ['{F5D7D231-C820-42EC-98DC-052706495134}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRoleType }

  IXMLRoleType = interface(IXMLNode)
    ['{000CC94A-0FAE-4198-8973-6A82C0851F4E}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPracticeNumberType }

  IXMLPracticeNumberType = interface(IXMLNode)
    ['{0A54647C-D846-4AD9-99CE-2B612C8B7ADB}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{D1B80D26-C0EC-4B1C-890B-4B882465FF57}']
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
    ['{C896C382-DA14-47C8-820A-9924AAE4F904}']
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
    ['{1B6E4F52-29C0-4436-ACCF-48DF195D869C}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethodType }

  IXMLSignatureMethodType = interface(IXMLNode)
    ['{046A0406-FE21-444F-9EF7-124A14E14FC9}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{719AB9BA-88FD-4A44-BC60-5D3E1B0DF2DE}']
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
    ['{D25A9CB1-A01F-4EE7-AC9F-5A79E90880D3}']
    { Property Accessors }
    function Get_Transform: IXMLTransformType;
    { Methods & Properties }
    property Transform: IXMLTransformType read Get_Transform;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNode)
    ['{40BA1D1F-871B-41D6-BC98-B3B5AFCD46C7}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLDigestMethodType }

  IXMLDigestMethodType = interface(IXMLNode)
    ['{F6D80A4A-CD39-4E2C-9129-BBB8DE64C63F}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{4B89E602-3EC5-40DE-B394-22C15B8D5195}']
    { Property Accessors }
    function Get_KeyValue: IXMLKeyValueType;
    function Get_X509Data: IXMLX509DataType;
    { Methods & Properties }
    property KeyValue: IXMLKeyValueType read Get_KeyValue;
    property X509Data: IXMLX509DataType read Get_X509Data;
  end;

{ IXMLKeyValueType }

  IXMLKeyValueType = interface(IXMLNode)
    ['{48B9EF67-9BF4-432E-BAAB-02663EBC605B}']
    { Property Accessors }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
    { Methods & Properties }
    property RSAKeyValue: IXMLRSAKeyValueType read Get_RSAKeyValue;
  end;

{ IXMLRSAKeyValueType }

  IXMLRSAKeyValueType = interface(IXMLNode)
    ['{0E63AACF-06ED-4251-BE11-6C10F9FD318A}']
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
    ['{EA59A019-6DE3-4022-AF83-E6A61E9BB763}']
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
  TXMLReferralType = class;
  TXMLLrnType = class;
  TXMLAuthoredOnType = class;
  TXMLCategoryType = class;
  TXMLTypeType = class;
  TXMLRhifAreaNumberType = class;
  TXMLBasedOnType = class;
  TXMLFinancingSourceType = class;
  TXMLLaboratoryType = class;
  TXMLCodeType = class;
  TXMLConsultationType = class;
  TXMLQualificationType = class;
  TXMLQualificationTypeList = class;
  TXMLHospitalizationType = class;
  TXMLAdmissionType = class;
  TXMLDirectedByType = class;
  TXMLClinicalPathwayType = class;
  TXMLOutpatientProcedureType = class;
  TXMLMedicalExpertiseType = class;
  TXMLExamType = class;
  TXMLExamTypeList = class;
  TXMLDiagnosisType = class;
  TXMLUseType = class;
  TXMLRankType = class;
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
  TXMLRequesterType = class;
  TXMLPmiType = class;
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
    function Get_Referral: IXMLReferralType;
    function Get_Subject: IXMLSubjectType;
    function Get_Requester: IXMLRequesterType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLReferralType }

  TXMLReferralType = class(TXMLNode, IXMLReferralType)
  protected
    { IXMLReferralType }
    function Get_Lrn: IXMLLrnType;
    function Get_AuthoredOn: IXMLAuthoredOnType;
    function Get_Category: IXMLCategoryType;
    function Get_Type_: IXMLTypeType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_Laboratory: IXMLLaboratoryType;
    function Get_Consultation: IXMLConsultationType;
    function Get_Hospitalization: IXMLHospitalizationType;
    function Get_MedicalExpertise: IXMLMedicalExpertiseType;
    function Get_Diagnosis: IXMLDiagnosisType;
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

{ TXMLAuthoredOnType }

  TXMLAuthoredOnType = class(TXMLNode, IXMLAuthoredOnType)
  protected
    { IXMLAuthoredOnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCategoryType }

  TXMLCategoryType = class(TXMLNode, IXMLCategoryType)
  protected
    { IXMLCategoryType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLTypeType }

  TXMLTypeType = class(TXMLNode, IXMLTypeType)
  protected
    { IXMLTypeType }
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

{ TXMLBasedOnType }

  TXMLBasedOnType = class(TXMLNode, IXMLBasedOnType)
  protected
    { IXMLBasedOnType }
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

{ TXMLLaboratoryType }

  TXMLLaboratoryType = class(TXMLNodeCollection, IXMLLaboratoryType)
  protected
    { IXMLLaboratoryType }
    function Get_Code(Index: Integer): IXMLCodeType;
    function Add: IXMLCodeType;
    function Insert(const Index: Integer): IXMLCodeType;
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

{ TXMLConsultationType }

  TXMLConsultationType = class(TXMLNodeCollection, IXMLConsultationType)
  protected
    { IXMLConsultationType }
    function Get_Qualification(Index: Integer): IXMLQualificationType;
    function Add: IXMLQualificationType;
    function Insert(const Index: Integer): IXMLQualificationType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLQualificationType }

  TXMLQualificationType = class(TXMLNode, IXMLQualificationType)
  protected
    { IXMLQualificationType }
    function Get_Value: UnicodeString;
    function Get_NhifCode: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    procedure Set_NhifCode(Value: UnicodeString);
  end;

{ TXMLQualificationTypeList }

  TXMLQualificationTypeList = class(TXMLNodeCollection, IXMLQualificationTypeList)
  protected
    { IXMLQualificationTypeList }
    function Add: IXMLQualificationType;
    function Insert(const Index: Integer): IXMLQualificationType;

    function Get_Item(Index: Integer): IXMLQualificationType;
  end;

{ TXMLHospitalizationType }

  TXMLHospitalizationType = class(TXMLNode, IXMLHospitalizationType)
  protected
    { IXMLHospitalizationType }
    function Get_AdmissionType: IXMLAdmissionType;
    function Get_DirectedBy: IXMLDirectedByType;
    function Get_ClinicalPathway: IXMLClinicalPathwayType;
    function Get_OutpatientProcedure: IXMLOutpatientProcedureType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAdmissionType }

  TXMLAdmissionType = class(TXMLNode, IXMLAdmissionType)
  protected
    { IXMLAdmissionType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLDirectedByType }

  TXMLDirectedByType = class(TXMLNode, IXMLDirectedByType)
  protected
    { IXMLDirectedByType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLClinicalPathwayType }

  TXMLClinicalPathwayType = class(TXMLNode, IXMLClinicalPathwayType)
  protected
    { IXMLClinicalPathwayType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLOutpatientProcedureType }

  TXMLOutpatientProcedureType = class(TXMLNode, IXMLOutpatientProcedureType)
  protected
    { IXMLOutpatientProcedureType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMedicalExpertiseType }

  TXMLMedicalExpertiseType = class(TXMLNode, IXMLMedicalExpertiseType)
  private
    FQualification: IXMLQualificationTypeList;
    FExamType: IXMLExamTypeList;
  protected
    { IXMLMedicalExpertiseType }
    function Get_Qualification: IXMLQualificationTypeList;
    function Get_ExamType: IXMLExamTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLExamType }

  TXMLExamType = class(TXMLNode, IXMLExamType)
  protected
    { IXMLExamType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLExamTypeList }

  TXMLExamTypeList = class(TXMLNodeCollection, IXMLExamTypeList)
  protected
    { IXMLExamTypeList }
    function Add: IXMLExamType;
    function Insert(const Index: Integer): IXMLExamType;

    function Get_Item(Index: Integer): IXMLExamType;
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
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
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

{ TXMLRequesterType }

  TXMLRequesterType = class(TXMLNode, IXMLRequesterType)
  protected
    { IXMLRequesterType }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_Role: IXMLRoleType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
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
  RegisterChildNode('referral', TXMLReferralType);
  RegisterChildNode('subject', TXMLSubjectType);
  RegisterChildNode('requester', TXMLRequesterType);
  inherited;
end;

function TXMLContentsType.Get_Referral: IXMLReferralType;
begin
  Result := ChildNodes['referral'] as IXMLReferralType;
end;

function TXMLContentsType.Get_Subject: IXMLSubjectType;
begin
  Result := ChildNodes['subject'] as IXMLSubjectType;
end;

function TXMLContentsType.Get_Requester: IXMLRequesterType;
begin
  Result := ChildNodes['requester'] as IXMLRequesterType;
end;

{ TXMLReferralType }

procedure TXMLReferralType.AfterConstruction;
begin
  RegisterChildNode('lrn', TXMLLrnType);
  RegisterChildNode('authoredOn', TXMLAuthoredOnType);
  RegisterChildNode('category', TXMLCategoryType);
  RegisterChildNode('type', TXMLTypeType);
  RegisterChildNode('rhifAreaNumber', TXMLRhifAreaNumberType);
  RegisterChildNode('basedOn', TXMLBasedOnType);
  RegisterChildNode('financingSource', TXMLFinancingSourceType);
  RegisterChildNode('laboratory', TXMLLaboratoryType);
  RegisterChildNode('consultation', TXMLConsultationType);
  RegisterChildNode('hospitalization', TXMLHospitalizationType);
  RegisterChildNode('medicalExpertise', TXMLMedicalExpertiseType);
  RegisterChildNode('diagnosis', TXMLDiagnosisType);
  inherited;
end;

function TXMLReferralType.Get_Lrn: IXMLLrnType;
begin
  Result := ChildNodes['lrn'] as IXMLLrnType;
end;

function TXMLReferralType.Get_AuthoredOn: IXMLAuthoredOnType;
begin
  Result := ChildNodes['authoredOn'] as IXMLAuthoredOnType;
end;

function TXMLReferralType.Get_Category: IXMLCategoryType;
begin
  Result := ChildNodes['category'] as IXMLCategoryType;
end;

function TXMLReferralType.Get_Type_: IXMLTypeType;
begin
  Result := ChildNodes['type'] as IXMLTypeType;
end;

function TXMLReferralType.Get_RhifAreaNumber: IXMLRhifAreaNumberType;
begin
  Result := ChildNodes['rhifAreaNumber'] as IXMLRhifAreaNumberType;
end;

function TXMLReferralType.Get_BasedOn: IXMLBasedOnType;
begin
  Result := ChildNodes['basedOn'] as IXMLBasedOnType;
end;

function TXMLReferralType.Get_FinancingSource: IXMLFinancingSourceType;
begin
  Result := ChildNodes['financingSource'] as IXMLFinancingSourceType;
end;

function TXMLReferralType.Get_Laboratory: IXMLLaboratoryType;
begin
  Result := ChildNodes['laboratory'] as IXMLLaboratoryType;
end;

function TXMLReferralType.Get_Consultation: IXMLConsultationType;
begin
  Result := ChildNodes['consultation'] as IXMLConsultationType;
end;

function TXMLReferralType.Get_Hospitalization: IXMLHospitalizationType;
begin
  Result := ChildNodes['hospitalization'] as IXMLHospitalizationType;
end;

function TXMLReferralType.Get_MedicalExpertise: IXMLMedicalExpertiseType;
begin
  Result := ChildNodes['medicalExpertise'] as IXMLMedicalExpertiseType;
end;

function TXMLReferralType.Get_Diagnosis: IXMLDiagnosisType;
begin
  Result := ChildNodes['diagnosis'] as IXMLDiagnosisType;
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

{ TXMLAuthoredOnType }

function TXMLAuthoredOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLAuthoredOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCategoryType }

function TXMLCategoryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCategoryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLTypeType }

function TXMLTypeType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLTypeType.Set_Value(Value: Integer);
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

{ TXMLBasedOnType }

function TXMLBasedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLBasedOnType.Set_Value(Value: UnicodeString);
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

{ TXMLLaboratoryType }

procedure TXMLLaboratoryType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  ItemTag := 'code';
  ItemInterface := IXMLCodeType;
  inherited;
end;

function TXMLLaboratoryType.Get_Code(Index: Integer): IXMLCodeType;
begin
  Result := List[Index] as IXMLCodeType;
end;

function TXMLLaboratoryType.Add: IXMLCodeType;
begin
  Result := AddItem(-1) as IXMLCodeType;
end;

function TXMLLaboratoryType.Insert(const Index: Integer): IXMLCodeType;
begin
  Result := AddItem(Index) as IXMLCodeType;
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

{ TXMLConsultationType }

procedure TXMLConsultationType.AfterConstruction;
begin
  RegisterChildNode('qualification', TXMLQualificationType);
  ItemTag := 'qualification';
  ItemInterface := IXMLQualificationType;
  inherited;
end;

function TXMLConsultationType.Get_Qualification(Index: Integer): IXMLQualificationType;
begin
  Result := List[Index] as IXMLQualificationType;
end;

function TXMLConsultationType.Add: IXMLQualificationType;
begin
  Result := AddItem(-1) as IXMLQualificationType;
end;

function TXMLConsultationType.Insert(const Index: Integer): IXMLQualificationType;
begin
  Result := AddItem(Index) as IXMLQualificationType;
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

function TXMLQualificationType.Get_NhifCode: UnicodeString;
begin
  Result := AttributeNodes['nhifCode'].Text;
end;

procedure TXMLQualificationType.Set_NhifCode(Value: UnicodeString);
begin
  SetAttribute('nhifCode', Value);
end;

{ TXMLQualificationTypeList }

function TXMLQualificationTypeList.Add: IXMLQualificationType;
begin
  Result := AddItem(-1) as IXMLQualificationType;
end;

function TXMLQualificationTypeList.Insert(const Index: Integer): IXMLQualificationType;
begin
  Result := AddItem(Index) as IXMLQualificationType;
end;

function TXMLQualificationTypeList.Get_Item(Index: Integer): IXMLQualificationType;
begin
  Result := List[Index] as IXMLQualificationType;
end;

{ TXMLHospitalizationType }

procedure TXMLHospitalizationType.AfterConstruction;
begin
  RegisterChildNode('admissionType', TXMLAdmissionType);
  RegisterChildNode('directedBy', TXMLDirectedByType);
  RegisterChildNode('clinicalPathway', TXMLClinicalPathwayType);
  RegisterChildNode('outpatientProcedure', TXMLOutpatientProcedureType);
  inherited;
end;

function TXMLHospitalizationType.Get_AdmissionType: IXMLAdmissionType;
begin
  Result := ChildNodes['admissionType'] as IXMLAdmissionType;
end;

function TXMLHospitalizationType.Get_DirectedBy: IXMLDirectedByType;
begin
  Result := ChildNodes['directedBy'] as IXMLDirectedByType;
end;

function TXMLHospitalizationType.Get_ClinicalPathway: IXMLClinicalPathwayType;
begin
  Result := ChildNodes['clinicalPathway'] as IXMLClinicalPathwayType;
end;

function TXMLHospitalizationType.Get_OutpatientProcedure: IXMLOutpatientProcedureType;
begin
  Result := ChildNodes['outpatientProcedure'] as IXMLOutpatientProcedureType;
end;

{ TXMLAdmissionType }

function TXMLAdmissionType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLAdmissionType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLDirectedByType }

function TXMLDirectedByType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLDirectedByType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLClinicalPathwayType }

function TXMLClinicalPathwayType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLClinicalPathwayType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLOutpatientProcedureType }

function TXMLOutpatientProcedureType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLOutpatientProcedureType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMedicalExpertiseType }

procedure TXMLMedicalExpertiseType.AfterConstruction;
begin
  RegisterChildNode('qualification', TXMLQualificationType);
  RegisterChildNode('examType', TXMLExamType);
  FQualification := CreateCollection(TXMLQualificationTypeList, IXMLQualificationType, 'qualification') as IXMLQualificationTypeList;
  FExamType := CreateCollection(TXMLExamTypeList, IXMLExamType, 'examType') as IXMLExamTypeList;
  inherited;
end;

function TXMLMedicalExpertiseType.Get_Qualification: IXMLQualificationTypeList;
begin
  Result := FQualification;
end;

function TXMLMedicalExpertiseType.Get_ExamType: IXMLExamTypeList;
begin
  Result := FExamType;
end;

{ TXMLExamType }

function TXMLExamType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLExamType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLExamTypeList }

function TXMLExamTypeList.Add: IXMLExamType;
begin
  Result := AddItem(-1) as IXMLExamType;
end;

function TXMLExamTypeList.Insert(const Index: Integer): IXMLExamType;
begin
  Result := AddItem(Index) as IXMLExamType;
end;

function TXMLExamTypeList.Get_Item(Index: Integer): IXMLExamType;
begin
  Result := List[Index] as IXMLExamType;
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

function TXMLIdentifierType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLIdentifierType.Set_Value(Value: Integer);
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

{ TXMLRequesterType }

procedure TXMLRequesterType.AfterConstruction;
begin
  RegisterChildNode('pmi', TXMLPmiType);
  RegisterChildNode('qualification', TXMLQualificationType);
  RegisterChildNode('role', TXMLRoleType);
  RegisterChildNode('practiceNumber', TXMLPracticeNumberType);
  RegisterChildNode('rhifAreaNumber', TXMLRhifAreaNumberType);
  inherited;
end;

function TXMLRequesterType.Get_Pmi: IXMLPmiType;
begin
  Result := ChildNodes['pmi'] as IXMLPmiType;
end;

function TXMLRequesterType.Get_Qualification: IXMLQualificationType;
begin
  Result := ChildNodes['qualification'] as IXMLQualificationType;
end;

function TXMLRequesterType.Get_Role: IXMLRoleType;
begin
  Result := ChildNodes['role'] as IXMLRoleType;
end;

function TXMLRequesterType.Get_PracticeNumber: IXMLPracticeNumberType;
begin
  Result := ChildNodes['practiceNumber'] as IXMLPracticeNumberType;
end;

function TXMLRequesterType.Get_RhifAreaNumber: IXMLRhifAreaNumberType;
begin
  Result := ChildNodes['rhifAreaNumber'] as IXMLRhifAreaNumberType;
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