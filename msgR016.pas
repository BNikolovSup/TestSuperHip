
{*****************************************************}
{                                                     }
{                  XML Data Binding                   }
{                                                     }
{         Generated on: 6.10.2025 ã. 11:28:33         }
{       Generated from: D:\HaknatFerdow\msgR016.xml   }
{   Settings stored in: D:\HaknatFerdow\msgR016.xdb   }
{                                                     }
{*****************************************************}

unit msgR016;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLMessageType = interface;
  IXMLHeaderType = interface;
  IXMLSenderType = interface;
  IXMLSenderIdType = interface;
  IXMLRecipientType = interface;
  IXMLRecipientIdType = interface;
  IXMLMessageIdType = interface;
  IXMLMessageType2 = interface;
  IXMLCreatedOnType = interface;
  IXMLContentsType = interface;
  IXMLFoundNumberType = interface;
  IXMLResultsType = interface;
  IXMLResultsTypeList = interface;
  IXMLReferralType = interface;
  IXMLNrnReferralType = interface;
  IXMLLrnType = interface;
  IXMLStatusType = interface;
  IXMLAuthoredOnType = interface;
  IXMLCategoryType = interface;
  IXMLTypeType = interface;
  IXMLRhifAreaNumberType = interface;
  IXMLBasedOnType = interface;
  IXMLFinancingSourceType = interface;
  IXMLConsultationType = interface;
  IXMLQualificationType = interface;
  IXMLDiagnosisType = interface;
  IXMLCodeType = interface;
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
  IXMLLineType = interface;
  IXMLNationalityType = interface;
  IXMLRequesterType = interface;
  IXMLPmiType = interface;
  IXMLRoleType = interface;
  IXMLPracticeNumberType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{A692E66A-7517-4376-823E-131E7D510565}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{BDE3F237-4C93-4594-A5CF-F33C7B9F8D11}']
    { Property Accessors }
    function Get_Sender: IXMLSenderType;
    function Get_SenderId: IXMLSenderIdType;
    function Get_Recipient: IXMLRecipientType;
    function Get_RecipientId: IXMLRecipientIdType;
    function Get_MessageId: IXMLMessageIdType;
    function Get_MessageType: IXMLMessageType2;
    function Get_CreatedOn: IXMLCreatedOnType;
    { Methods & Properties }
    property Sender: IXMLSenderType read Get_Sender;
    property SenderId: IXMLSenderIdType read Get_SenderId;
    property Recipient: IXMLRecipientType read Get_Recipient;
    property RecipientId: IXMLRecipientIdType read Get_RecipientId;
    property MessageId: IXMLMessageIdType read Get_MessageId;
    property MessageType: IXMLMessageType2 read Get_MessageType;
    property CreatedOn: IXMLCreatedOnType read Get_CreatedOn;
  end;

{ IXMLSenderType }

  IXMLSenderType = interface(IXMLNode)
    ['{9959BE1C-CB75-44F2-9D57-7DEFC208312C}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{BB2F2CEB-9813-4FE1-9385-B3F742A91439}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{7424969C-888A-4171-A0A2-94598348303C}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{135C133E-D6B1-498A-80B9-99712618F4B2}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{9A4599EE-5F15-48B7-BB35-0FAB5151B38E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{C510CBFF-04B6-445F-8119-4F56DA082B98}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{50C0E991-D78A-47EF-9ADC-05093F4B19FE}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{4C3C16FF-3C15-4A8F-B21D-D635027055C0}']
    { Property Accessors }
    function Get_FoundNumber: IXMLFoundNumberType;
    function Get_Results: IXMLResultsTypeList;
    { Methods & Properties }
    property FoundNumber: IXMLFoundNumberType read Get_FoundNumber;
    property Results: IXMLResultsTypeList read Get_Results;
  end;

{ IXMLFoundNumberType }

  IXMLFoundNumberType = interface(IXMLNode)
    ['{BEE9669B-54FC-4E09-BD18-48D57EAD5E8A}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLResultsType }

  IXMLResultsType = interface(IXMLNode)
    ['{FF37BEFB-F252-4838-9190-52C537CEDBE8}']
    { Property Accessors }
    function Get_Referral: IXMLReferralType;
    function Get_Subject: IXMLSubjectType;
    function Get_Requester: IXMLRequesterType;
    { Methods & Properties }
    property Referral: IXMLReferralType read Get_Referral;
    property Subject: IXMLSubjectType read Get_Subject;
    property Requester: IXMLRequesterType read Get_Requester;
  end;

{ IXMLResultsTypeList }

  IXMLResultsTypeList = interface(IXMLNodeCollection)
    ['{5B367707-134C-43D2-B550-842D78D9D5D2}']
    { Methods & Properties }
    function Add: IXMLResultsType;
    function Insert(const Index: Integer): IXMLResultsType;

    function Get_Item(Index: Integer): IXMLResultsType;
    property Items[Index: Integer]: IXMLResultsType read Get_Item; default;
  end;

{ IXMLReferralType }

  IXMLReferralType = interface(IXMLNode)
    ['{E5DD51D0-1B3F-4EA3-9646-459FE712EA8D}']
    { Property Accessors }
    function Get_NrnReferral: IXMLNrnReferralType;
    function Get_Lrn: IXMLLrnType;
    function Get_Status: IXMLStatusType;
    function Get_AuthoredOn: IXMLAuthoredOnType;
    function Get_Category: IXMLCategoryType;
    function Get_Type_: IXMLTypeType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_Consultation: IXMLConsultationType;
    function Get_Diagnosis: IXMLDiagnosisType;
    { Methods & Properties }
    property NrnReferral: IXMLNrnReferralType read Get_NrnReferral;
    property Lrn: IXMLLrnType read Get_Lrn;
    property Status: IXMLStatusType read Get_Status;
    property AuthoredOn: IXMLAuthoredOnType read Get_AuthoredOn;
    property Category: IXMLCategoryType read Get_Category;
    property Type_: IXMLTypeType read Get_Type_;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
    property BasedOn: IXMLBasedOnType read Get_BasedOn;
    property FinancingSource: IXMLFinancingSourceType read Get_FinancingSource;
    property Consultation: IXMLConsultationType read Get_Consultation;
    property Diagnosis: IXMLDiagnosisType read Get_Diagnosis;
  end;

{ IXMLNrnReferralType }

  IXMLNrnReferralType = interface(IXMLNode)
    ['{55610F30-DAE5-4773-9843-397C16D13BCD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLLrnType }

  IXMLLrnType = interface(IXMLNode)
    ['{F73C1899-D1C7-40A4-BBC4-291B96304AE4}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLStatusType }

  IXMLStatusType = interface(IXMLNode)
    ['{55BB8DCC-2B34-4727-8480-3F86CCB2AFB3}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLAuthoredOnType }

  IXMLAuthoredOnType = interface(IXMLNode)
    ['{621AA470-1257-48C0-87EF-23E954228C4C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCategoryType }

  IXMLCategoryType = interface(IXMLNode)
    ['{B4D0EC28-9D5C-41BD-8353-342AF80D7979}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTypeType }

  IXMLTypeType = interface(IXMLNode)
    ['{63F54622-9964-4271-B235-EC8524AA8D25}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRhifAreaNumberType }

  IXMLRhifAreaNumberType = interface(IXMLNode)
    ['{7A7C1F3C-FB16-4529-BF7D-87E323A4E816}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{D390460E-AEC2-4138-8B7D-0A1F40556E07}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFinancingSourceType }

  IXMLFinancingSourceType = interface(IXMLNode)
    ['{FCE59168-08B2-47B3-8A84-B65958FF0EFD}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLConsultationType }

  IXMLConsultationType = interface(IXMLNode)
    ['{95BE1387-5CC8-41BE-8924-9F56F2C72700}']
    { Property Accessors }
    function Get_Qualification: IXMLQualificationType;
    { Methods & Properties }
    property Qualification: IXMLQualificationType read Get_Qualification;
  end;

{ IXMLQualificationType }

  IXMLQualificationType = interface(IXMLNode)
    ['{86A5E230-AB66-452B-9216-EA433C731B7B}']
    { Property Accessors }
    function Get_Value: Integer;
    function Get_NhifCode: Integer;
    procedure Set_Value(Value: Integer);
    procedure Set_NhifCode(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
    property NhifCode: Integer read Get_NhifCode write Set_NhifCode;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{7B9F6C05-4CB1-48F4-A3E1-9EB8D6B272DB}']
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
    ['{6F6918B5-5F1F-4AFC-A6A1-06832680247D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{F3B467F1-EE77-436A-8FFB-3F4060037A66}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{79D1E579-F602-4040-B5A0-61576179D5C8}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSubjectType }

  IXMLSubjectType = interface(IXMLNode)
    ['{B60064A8-5673-4259-8925-F89AC20FDCD2}']
    { Property Accessors }
    function Get_IdentifierType: IXMLIdentifierType;
    function Get_Identifier: IXMLIdentifierType;
    function Get_BirthDate: IXMLBirthDateType;
    function Get_Gender: IXMLGenderType;
    function Get_Name: IXMLNameType;
    function Get_Address: IXMLAddressType;
    function Get_Nationality: IXMLNationalityType;
    { Methods & Properties }
    property IdentifierType: IXMLIdentifierType read Get_IdentifierType;
    property Identifier: IXMLIdentifierType read Get_Identifier;
    property BirthDate: IXMLBirthDateType read Get_BirthDate;
    property Gender: IXMLGenderType read Get_Gender;
    property Name: IXMLNameType read Get_Name;
    property Address: IXMLAddressType read Get_Address;
    property Nationality: IXMLNationalityType read Get_Nationality;
  end;

{ IXMLIdentifierType }

  IXMLIdentifierType = interface(IXMLNode)
    ['{D484E39F-5B7B-4BD8-B1C9-6A9092E13AD9}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBirthDateType }

  IXMLBirthDateType = interface(IXMLNode)
    ['{ABE7E9DA-D019-4D94-BD92-2DCB9CFE5192}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGenderType }

  IXMLGenderType = interface(IXMLNode)
    ['{D51AC832-EC2E-4747-AA16-E1725F11378F}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{A9B9F20C-65FA-40F0-AD5E-B88D86BBA480}']
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
    ['{2DD89FAD-24A1-413D-9CB1-F7B3BCE4CD7D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMiddleType }

  IXMLMiddleType = interface(IXMLNode)
    ['{7FA20FD5-7582-4960-AD93-6ABE7EB82217}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFamilyType }

  IXMLFamilyType = interface(IXMLNode)
    ['{2862378E-ADF1-4705-8DCF-3A487BB63458}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{B0E19858-8805-494D-BE86-DE0E5573A931}']
    { Property Accessors }
    function Get_Country: IXMLCountryType;
    function Get_County: IXMLCountyType;
    function Get_Ekatte: IXMLEkatteType;
    function Get_City: IXMLCityType;
    function Get_Line: IXMLLineType;
    { Methods & Properties }
    property Country: IXMLCountryType read Get_Country;
    property County: IXMLCountyType read Get_County;
    property Ekatte: IXMLEkatteType read Get_Ekatte;
    property City: IXMLCityType read Get_City;
    property Line: IXMLLineType read Get_Line;
  end;

{ IXMLCountryType }

  IXMLCountryType = interface(IXMLNode)
    ['{B5D08DE5-86A0-469C-8BB1-EFF05C1C429E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCountyType }

  IXMLCountyType = interface(IXMLNode)
    ['{615E6570-3F9F-4E42-8DFB-F5849861E65E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLEkatteType }

  IXMLEkatteType = interface(IXMLNode)
    ['{8DFA4A86-3979-499B-9132-65BD19D534BE}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLCityType }

  IXMLCityType = interface(IXMLNode)
    ['{15B989B8-432F-4210-9B42-1B89FCE5813B}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLLineType }

  IXMLLineType = interface(IXMLNode)
    ['{FF8F2FE1-E6C5-4278-BBCB-39E25380F313}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNationalityType }

  IXMLNationalityType = interface(IXMLNode)
    ['{F2D21757-DD57-4F3D-A44C-A902E9CE9B71}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRequesterType }

  IXMLRequesterType = interface(IXMLNode)
    ['{B5C58046-0A05-4539-BEE3-8FC1CA1D0FF5}']
    { Property Accessors }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_Role: IXMLRoleType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
    function Get_NhifNumber: UnicodeString;
    function Get_Phone: UnicodeString;
    function Get_Email: UnicodeString;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_Name: IXMLNameType;
    procedure Set_NhifNumber(Value: UnicodeString);
    procedure Set_Phone(Value: UnicodeString);
    procedure Set_Email(Value: UnicodeString);
    { Methods & Properties }
    property Pmi: IXMLPmiType read Get_Pmi;
    property Qualification: IXMLQualificationType read Get_Qualification;
    property Role: IXMLRoleType read Get_Role;
    property PracticeNumber: IXMLPracticeNumberType read Get_PracticeNumber;
    property NhifNumber: UnicodeString read Get_NhifNumber write Set_NhifNumber;
    property Phone: UnicodeString read Get_Phone write Set_Phone;
    property Email: UnicodeString read Get_Email write Set_Email;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
    property Name: IXMLNameType read Get_Name;
  end;

{ IXMLPmiType }

  IXMLPmiType = interface(IXMLNode)
    ['{10B4A739-CCC3-4672-B5A8-DAB632461F47}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRoleType }

  IXMLRoleType = interface(IXMLNode)
    ['{3EC1716A-767E-4F0A-9F22-263B3C1F5356}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPracticeNumberType }

  IXMLPracticeNumberType = interface(IXMLNode)
    ['{80AE65E4-5B29-4146-9DD2-E1001BA63514}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ Forward Decls }

  TXMLMessageType = class;
  TXMLHeaderType = class;
  TXMLSenderType = class;
  TXMLSenderIdType = class;
  TXMLRecipientType = class;
  TXMLRecipientIdType = class;
  TXMLMessageIdType = class;
  TXMLMessageType2 = class;
  TXMLCreatedOnType = class;
  TXMLContentsType = class;
  TXMLFoundNumberType = class;
  TXMLResultsType = class;
  TXMLResultsTypeList = class;
  TXMLReferralType = class;
  TXMLNrnReferralType = class;
  TXMLLrnType = class;
  TXMLStatusType = class;
  TXMLAuthoredOnType = class;
  TXMLCategoryType = class;
  TXMLTypeType = class;
  TXMLRhifAreaNumberType = class;
  TXMLBasedOnType = class;
  TXMLFinancingSourceType = class;
  TXMLConsultationType = class;
  TXMLQualificationType = class;
  TXMLDiagnosisType = class;
  TXMLCodeType = class;
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
  TXMLLineType = class;
  TXMLNationalityType = class;
  TXMLRequesterType = class;
  TXMLPmiType = class;
  TXMLRoleType = class;
  TXMLPracticeNumberType = class;

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
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
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
  private
    FResults: IXMLResultsTypeList;
  protected
    { IXMLContentsType }
    function Get_FoundNumber: IXMLFoundNumberType;
    function Get_Results: IXMLResultsTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFoundNumberType }

  TXMLFoundNumberType = class(TXMLNode, IXMLFoundNumberType)
  protected
    { IXMLFoundNumberType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLResultsType }

  TXMLResultsType = class(TXMLNode, IXMLResultsType)
  protected
    { IXMLResultsType }
    function Get_Referral: IXMLReferralType;
    function Get_Subject: IXMLSubjectType;
    function Get_Requester: IXMLRequesterType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLResultsTypeList }

  TXMLResultsTypeList = class(TXMLNodeCollection, IXMLResultsTypeList)
  protected
    { IXMLResultsTypeList }
    function Add: IXMLResultsType;
    function Insert(const Index: Integer): IXMLResultsType;

    function Get_Item(Index: Integer): IXMLResultsType;
  end;

{ TXMLReferralType }

  TXMLReferralType = class(TXMLNode, IXMLReferralType)
  protected
    { IXMLReferralType }
    function Get_NrnReferral: IXMLNrnReferralType;
    function Get_Lrn: IXMLLrnType;
    function Get_Status: IXMLStatusType;
    function Get_AuthoredOn: IXMLAuthoredOnType;
    function Get_Category: IXMLCategoryType;
    function Get_Type_: IXMLTypeType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_Consultation: IXMLConsultationType;
    function Get_Diagnosis: IXMLDiagnosisType;
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

{ TXMLLrnType }

  TXMLLrnType = class(TXMLNode, IXMLLrnType)
  protected
    { IXMLLrnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLStatusType }

  TXMLStatusType = class(TXMLNode, IXMLStatusType)
  protected
    { IXMLStatusType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
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

{ TXMLConsultationType }

  TXMLConsultationType = class(TXMLNode, IXMLConsultationType)
  protected
    { IXMLConsultationType }
    function Get_Qualification: IXMLQualificationType;
  public
    procedure AfterConstruction; override;
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
    function Get_Nationality: IXMLNationalityType;
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
    function Get_Line: IXMLLineType;
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

{ TXMLLineType }

  TXMLLineType = class(TXMLNode, IXMLLineType)
  protected
    { IXMLLineType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNationalityType }

  TXMLNationalityType = class(TXMLNode, IXMLNationalityType)
  protected
    { IXMLNationalityType }
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
    function Get_NhifNumber: UnicodeString;
    function Get_Phone: UnicodeString;
    function Get_Email: UnicodeString;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_Name: IXMLNameType;
    procedure Set_NhifNumber(Value: UnicodeString);
    procedure Set_Phone(Value: UnicodeString);
    procedure Set_Email(Value: UnicodeString);
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

function TXMLSenderIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSenderIdType.Set_Value(Value: UnicodeString);
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

function TXMLRecipientIdType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRecipientIdType.Set_Value(Value: Integer);
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
  RegisterChildNode('foundNumber', TXMLFoundNumberType);
  RegisterChildNode('results', TXMLResultsType);
  FResults := CreateCollection(TXMLResultsTypeList, IXMLResultsType, 'results') as IXMLResultsTypeList;
  inherited;
end;

function TXMLContentsType.Get_FoundNumber: IXMLFoundNumberType;
begin
  Result := ChildNodes['foundNumber'] as IXMLFoundNumberType;
end;

function TXMLContentsType.Get_Results: IXMLResultsTypeList;
begin
  Result := FResults;
end;

{ TXMLFoundNumberType }

function TXMLFoundNumberType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLFoundNumberType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLResultsType }

procedure TXMLResultsType.AfterConstruction;
begin
  RegisterChildNode('referral', TXMLReferralType);
  RegisterChildNode('subject', TXMLSubjectType);
  RegisterChildNode('requester', TXMLRequesterType);
  inherited;
end;

function TXMLResultsType.Get_Referral: IXMLReferralType;
begin
  Result := ChildNodes['referral'] as IXMLReferralType;
end;

function TXMLResultsType.Get_Subject: IXMLSubjectType;
begin
  Result := ChildNodes['subject'] as IXMLSubjectType;
end;

function TXMLResultsType.Get_Requester: IXMLRequesterType;
begin
  Result := ChildNodes['requester'] as IXMLRequesterType;
end;

{ TXMLResultsTypeList }

function TXMLResultsTypeList.Add: IXMLResultsType;
begin
  Result := AddItem(-1) as IXMLResultsType;
end;

function TXMLResultsTypeList.Insert(const Index: Integer): IXMLResultsType;
begin
  Result := AddItem(Index) as IXMLResultsType;
end;

function TXMLResultsTypeList.Get_Item(Index: Integer): IXMLResultsType;
begin
  Result := List[Index] as IXMLResultsType;
end;

{ TXMLReferralType }

procedure TXMLReferralType.AfterConstruction;
begin
  RegisterChildNode('nrnReferral', TXMLNrnReferralType);
  RegisterChildNode('lrn', TXMLLrnType);
  RegisterChildNode('status', TXMLStatusType);
  RegisterChildNode('authoredOn', TXMLAuthoredOnType);
  RegisterChildNode('category', TXMLCategoryType);
  RegisterChildNode('type', TXMLTypeType);
  RegisterChildNode('rhifAreaNumber', TXMLRhifAreaNumberType);
  RegisterChildNode('basedOn', TXMLBasedOnType);
  RegisterChildNode('financingSource', TXMLFinancingSourceType);
  RegisterChildNode('consultation', TXMLConsultationType);
  RegisterChildNode('diagnosis', TXMLDiagnosisType);
  inherited;
end;

function TXMLReferralType.Get_NrnReferral: IXMLNrnReferralType;
begin
  Result := ChildNodes['nrnReferral'] as IXMLNrnReferralType;
end;

function TXMLReferralType.Get_Lrn: IXMLLrnType;
begin
  Result := ChildNodes['lrn'] as IXMLLrnType;
end;

function TXMLReferralType.Get_Status: IXMLStatusType;
begin
  Result := ChildNodes['status'] as IXMLStatusType;
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

function TXMLReferralType.Get_Consultation: IXMLConsultationType;
begin
  Result := ChildNodes['consultation'] as IXMLConsultationType;
end;

function TXMLReferralType.Get_Diagnosis: IXMLDiagnosisType;
begin
  Result := ChildNodes['diagnosis'] as IXMLDiagnosisType;
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

{ TXMLLrnType }

function TXMLLrnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLrnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLStatusType }

function TXMLStatusType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLStatusType.Set_Value(Value: Integer);
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

{ TXMLConsultationType }

procedure TXMLConsultationType.AfterConstruction;
begin
  RegisterChildNode('qualification', TXMLQualificationType);
  inherited;
end;

function TXMLConsultationType.Get_Qualification: IXMLQualificationType;
begin
  Result := ChildNodes['qualification'] as IXMLQualificationType;
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

{ TXMLSubjectType }

procedure TXMLSubjectType.AfterConstruction;
begin
  RegisterChildNode('identifierType', TXMLIdentifierType);
  RegisterChildNode('identifier', TXMLIdentifierType);
  RegisterChildNode('birthDate', TXMLBirthDateType);
  RegisterChildNode('gender', TXMLGenderType);
  RegisterChildNode('name', TXMLNameType);
  RegisterChildNode('address', TXMLAddressType);
  RegisterChildNode('nationality', TXMLNationalityType);
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

function TXMLSubjectType.Get_Nationality: IXMLNationalityType;
begin
  Result := ChildNodes['nationality'] as IXMLNationalityType;
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
  RegisterChildNode('line', TXMLLineType);
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

function TXMLAddressType.Get_Line: IXMLLineType;
begin
  Result := ChildNodes['line'] as IXMLLineType;
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

{ TXMLLineType }

function TXMLLineType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLineType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNationalityType }

function TXMLNationalityType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNationalityType.Set_Value(Value: UnicodeString);
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
  RegisterChildNode('name', TXMLNameType);
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

function TXMLRequesterType.Get_NhifNumber: UnicodeString;
begin
  Result := ChildNodes['nhifNumber'].Text;
end;

procedure TXMLRequesterType.Set_NhifNumber(Value: UnicodeString);
begin
  ChildNodes['nhifNumber'].NodeValue := Value;
end;

function TXMLRequesterType.Get_Phone: UnicodeString;
begin
  Result := ChildNodes['phone'].Text;
end;

procedure TXMLRequesterType.Set_Phone(Value: UnicodeString);
begin
  ChildNodes['phone'].NodeValue := Value;
end;

function TXMLRequesterType.Get_Email: UnicodeString;
begin
  Result := ChildNodes['email'].Text;
end;

procedure TXMLRequesterType.Set_Email(Value: UnicodeString);
begin
  ChildNodes['email'].NodeValue := Value;
end;

function TXMLRequesterType.Get_RhifAreaNumber: IXMLRhifAreaNumberType;
begin
  Result := ChildNodes['rhifAreaNumber'] as IXMLRhifAreaNumberType;
end;

function TXMLRequesterType.Get_Name: IXMLNameType;
begin
  Result := ChildNodes['name'] as IXMLNameType;
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

end.