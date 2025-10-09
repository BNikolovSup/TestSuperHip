
{**********************************************************************************************************************************************************************************************************************************************}
{                                                                                                                                                                                                                                              }
{                                                                                                               XML Data Binding                                                                                                               }
{                                                                                                                                                                                                                                              }
{         Generated on: 1.10.2025 г. 9:26:17                                                                                                                                                                                                   }
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
    ['{2BD1AF19-09BD-445C-AE38-C8E17E9F1C7C}']
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
    ['{02320D46-F400-48CD-9102-1A8E01422F0A}']
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
    ['{83099306-A1C5-4EC1-8E6D-51096C1EC628}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{2F1B74A2-9CAB-4BCC-B104-668B178D9278}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{261ACB78-819F-45BA-9EA6-2DCF5C976E9B}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{B5974367-25EB-44F0-AA47-ADFE5B06973A}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{AD8EA11D-92AE-44D3-9088-8E9321243297}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{D99EFD0F-5078-4277-99A5-2D9CB9D3A098}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{82554CD0-9D50-4C6D-8BE5-3207EC5E9C34}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{53568DA1-F175-46A1-BA23-67C6A232AC4F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{28BD6C34-45CD-44B7-8F05-394C1FFD6161}']
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
    ['{A5E3E93A-4502-462F-B496-4E27C5847649}']
    { Property Accessors }
    function Get_Lrn: IXMLLrnType;
    function Get_AuthoredOn: IXMLAuthoredOnType;
    function Get_Category: IXMLCategoryType;
    function Get_Type_: IXMLTypeType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_Laboratory: IXMLLaboratoryType;
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
    property Diagnosis: IXMLDiagnosisType read Get_Diagnosis;
  end;

{ IXMLLrnType }

  IXMLLrnType = interface(IXMLNode)
    ['{943949B3-CEB9-40A2-91CE-5A5658E1C80D}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAuthoredOnType }

  IXMLAuthoredOnType = interface(IXMLNode)
    ['{C526A760-B0C3-42CA-AD9A-D606A2420C04}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCategoryType }

  IXMLCategoryType = interface(IXMLNode)
    ['{0B18ED74-5617-4F9A-98E1-5DA471A8CEE4}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTypeType }

  IXMLTypeType = interface(IXMLNode)
    ['{D8EA603C-C3CF-435F-B2AA-647B49751F7E}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRhifAreaNumberType }

  IXMLRhifAreaNumberType = interface(IXMLNode)
    ['{3B60C340-9DCD-4161-A58A-34BBB7B63E9E}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{1877B6FA-D1EE-4FDD-AAC5-8EFC0E830882}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFinancingSourceType }

  IXMLFinancingSourceType = interface(IXMLNode)
    ['{422FBFEE-719A-4265-B738-E48C3C8E616C}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLLaboratoryType }

  IXMLLaboratoryType = interface(IXMLNodeCollection)
    ['{4D4EB79F-F02D-4FF6-B6C0-8AFAD1F6843E}']
    { Property Accessors }
    function Get_Code(Index: Integer): IXMLCodeType;
    { Methods & Properties }
    function Add: IXMLCodeType;
    function Insert(const Index: Integer): IXMLCodeType;
    property Code[Index: Integer]: IXMLCodeType read Get_Code; default;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{CA285A29-DFFF-451E-B008-97850BF33981}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{CC5C1A48-0D2A-462B-AB3F-AAB01802BE25}']
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
    ['{A5F90156-D7A0-4BF8-A061-9B86D14D0035}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{7D1F4EE4-7E9F-499B-97C3-3AE16C599B4F}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSubjectType }

  IXMLSubjectType = interface(IXMLNode)
    ['{108EFC05-4393-4F0E-B36B-C096CBD6801C}']
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
    ['{68B25182-F382-4819-87CB-4E33A0F649D8}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLBirthDateType }

  IXMLBirthDateType = interface(IXMLNode)
    ['{D5974A12-EA61-4491-A6DC-8F23EEC0526A}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGenderType }

  IXMLGenderType = interface(IXMLNode)
    ['{88AF50B1-E5F1-4794-9633-07FAE5D15DE3}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{D254845A-44DE-47FD-BB97-064D13CEA166}']
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
    ['{7D10F2BC-281C-4C13-91B4-1C6071A693AF}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMiddleType }

  IXMLMiddleType = interface(IXMLNode)
    ['{224C37A3-1EFE-4C36-89C5-7CDE57990E53}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFamilyType }

  IXMLFamilyType = interface(IXMLNode)
    ['{D64F685D-2792-4A9F-ADA1-035D45D89089}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{AAAF877B-AB9D-4B4C-841B-38D188A72528}']
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
    ['{D5E505B8-C14F-4F33-9A24-C865634B4C36}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCountyType }

  IXMLCountyType = interface(IXMLNode)
    ['{F868A0D8-D4E8-4F13-A905-B5B8DBF4F264}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLEkatteType }

  IXMLEkatteType = interface(IXMLNode)
    ['{7E7AB407-2091-4D0C-B7DC-5D84F22F7340}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLCityType }

  IXMLCityType = interface(IXMLNode)
    ['{F3110389-8E48-4AA9-938F-0CBFBEC6E522}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRequesterType }

  IXMLRequesterType = interface(IXMLNode)
    ['{118EC4BB-2164-430E-ADB1-1B02AE91625C}']
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
    ['{0A6C280C-396B-4E17-A3EF-4E82B99B8EA7}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLQualificationType }

  IXMLQualificationType = interface(IXMLNode)
    ['{EFF5E271-5220-49BB-8D20-220F5E7A1227}']
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
    ['{2D2AA4C4-2D76-4E3B-9A8A-368F83D2E25F}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPracticeNumberType }

  IXMLPracticeNumberType = interface(IXMLNode)
    ['{E06C3682-B5DC-48BB-9AF2-8B6D84C985B8}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{58485109-4396-4558-A34F-5856364794C7}']
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
    ['{48730A18-17EB-4235-BDDE-DD6E924F4DC2}']
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
    ['{609B6864-8643-4CEC-9D85-FEEC013C3D82}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethodType }

  IXMLSignatureMethodType = interface(IXMLNode)
    ['{12F29BC6-4779-4DF6-AF69-6D701D0AB299}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{D69B1707-EBE2-4A5F-96C8-F40F517AFFA8}']
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
    ['{FBC0CEDA-CEE0-44F8-9E7B-79F21AAF93E7}']
    { Property Accessors }
    function Get_Transform: IXMLTransformType;
    { Methods & Properties }
    property Transform: IXMLTransformType read Get_Transform;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNode)
    ['{7700BE84-B129-4676-BD88-D0BE2D93355F}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLDigestMethodType }

  IXMLDigestMethodType = interface(IXMLNode)
    ['{EB007857-7CCE-4276-89C4-1D872CF1ACCB}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{DA465015-C838-4160-A97D-F8B3CE53FD6E}']
    { Property Accessors }
    function Get_KeyValue: IXMLKeyValueType;
    function Get_X509Data: IXMLX509DataType;
    { Methods & Properties }
    property KeyValue: IXMLKeyValueType read Get_KeyValue;
    property X509Data: IXMLX509DataType read Get_X509Data;
  end;

{ IXMLKeyValueType }

  IXMLKeyValueType = interface(IXMLNode)
    ['{AB231DD3-F5A5-4C57-A7DA-A77D87741095}']
    { Property Accessors }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
    { Methods & Properties }
    property RSAKeyValue: IXMLRSAKeyValueType read Get_RSAKeyValue;
  end;

{ IXMLRSAKeyValueType }

  IXMLRSAKeyValueType = interface(IXMLNode)
    ['{F9426E67-F64B-4CE7-A344-24E92B14ACE0}']
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
    ['{F314E413-490A-4E45-9F37-A01365BE4BFD}']
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