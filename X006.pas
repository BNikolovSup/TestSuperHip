
{********************************************}
{                                            }
{              XML Data Binding              }
{                                            }
{         Generated on: 03/08/2022 4:47:52   }
{       Generated from: D:\X006.xml          }
{   Settings stored in: D:\X006.xdb          }
{                                            }
{********************************************}

unit X006;

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
  IXMLFoundNumberType = interface;
  IXMLResultsType = interface;
  IXMLResultsTypeList = interface;
  IXMLExaminationType = interface;
  IXMLNrnExaminationType = interface;
  IXMLLrnType = interface;
  IXMLStatusType = interface;
  IXMLOpenDateType = interface;
  IXMLCloseDateType = interface;
  IXMLBasedOnType = interface;
  IXMLDirectedByType = interface;
  IXMLClassType = interface;
  IXMLPurposeType = interface;
  IXMLCorrectionDateType = interface;
  IXMLCorrectionReasonType = interface;
  IXMLIncidentalVisitType = interface;
  IXMLIsSecondaryType = interface;
  IXMLFinancingSourceType = interface;
  IXMLRhifAreaNumberType = interface;
  IXMLAdverseConditionsType = interface;
  IXMLMotherHealthcareType = interface;
  IXMLIsPregnantType = interface;
  IXMLIsBreastFeedingType = interface;
  IXMLGestationalWeekType = interface;
  IXMLChildHealthcareType = interface;
  IXMLAgeType = interface;
  IXMLNrnConsultationType = interface;
  IXMLNrnConsultationTypeList = interface;
  IXMLNrnConsultationType2 = interface;
  IXMLQualificationType = interface;
  IXMLDirectedOnType = interface;
  IXMLPerformedOnType = interface;
  IXMLNoteType = interface;
  IXMLDocumentsType = interface;
  IXMLNrnImmunizationType = interface;
  IXMLNrnImmunizationTypeList = interface;
  IXMLNrnReferralType = interface;
  IXMLNrnReferralTypeList = interface;
  IXMLNrnPrescriptionType = interface;
  IXMLNrnPrescriptionTypeList = interface;
  IXMLIssuedTelkDocumentType = interface;
  IXMLIssuedQuickNoticeType = interface;
  IXMLIssuedInterimReportType = interface;
  IXMLIssuedMedicalNoticeType = interface;
  IXMLSickLeaveType = interface;
  IXMLSickLeaveTypeList = interface;
  IXMLNumberType = interface;
  IXMLDaysType = interface;
  IXMLReasonCodeType = interface;
  IXMLFromDateType = interface;
  IXMLToDateType = interface;
  IXMLIsInitialType = interface;
  IXMLDiagnosisType = interface;
  IXMLCodeType = interface;
  IXMLCodeTypeList = interface;
  IXMLAdditionalCodeType = interface;
  IXMLUseType = interface;
  IXMLRankType = interface;
  IXMLClinicalStatusType = interface;
  IXMLVerificationStatusType = interface;
  IXMLOnsetDateTimeType = interface;
  IXMLComorbidityType = interface;
  IXMLComorbidityTypeList = interface;
  IXMLMedicalHistoryType = interface;
  IXMLObjectiveConditionType = interface;
  IXMLAssessmentType = interface;
  IXMLAssessmentTypeList = interface;
  IXMLNrnExecutionType = interface;
  IXMLNrnExecutionTypeList = interface;
  IXMLDiagnosticReportType = interface;
  IXMLDiagnosticReportTypeList = interface;
  IXMLNumberPerformedType = interface;
  IXMLResultType = interface;
  IXMLResultTypeList = interface;
  IXMLValueScaleType = interface;
  IXMLValueNomenclatureType = interface;
  IXMLValueQuantityType = interface;
  IXMLValueUnitType = interface;
  IXMLValueDateTimeType = interface;
  IXMLReferenceRangeType = interface;
  IXMLLowType = interface;
  IXMLHighType = interface;
  IXMLTextType = interface;
  IXMLInterpretationType = interface;
  IXMLInterpretationTypeList = interface;
  IXMLMethodType = interface;
  IXMLCategoryType = interface;
  IXMLConclusionType = interface;
  IXMLDischargeDispositionType = interface;
  IXMLTherapyType = interface;
  IXMLMedicationCodeType = interface;
  IXMLMedicationCodeTypeList = interface;
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
  IXMLPostalCodeType = interface;
  IXMLNationalityType = interface;
  IXMLPhoneType = interface;
  IXMLEmailType = interface;
  IXMLPerformerType = interface;
  IXMLPmiType = interface;
  IXMLPracticeNumberType = interface;
  IXMLPmiDeputyType = interface;
  IXMLRoleType = interface;
  IXMLNhifNumberType = interface;
  IXMLAccompanyingType = interface;
  IXMLAccompanyingTypeList = interface;
  IXMLWarningsType = interface;
  IXMLDescriptionType = interface;
  IXMLSourceType = interface;
  IXMLNrnTargetType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{EBAEBDA6-A728-45E5-983B-BFD7D8AA1E1E}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    function Get_Warnings: IXMLWarningsType;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
    property Warnings: IXMLWarningsType read Get_Warnings;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{38DDA265-DC1E-448F-AC17-DCE87CC3B97A}']
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
    ['{678FEEBE-6A50-44C3-9706-8898CD94A1B9}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{EB093807-33ED-4957-81AF-AA60386B728B}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSenderISNameType }

  IXMLSenderISNameType = interface(IXMLNode)
    ['{0C9404A5-89FD-4528-9E12-27D23BC07485}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{FEF5F87D-3F41-4479-8FE9-7CDE9472097F}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{CCE71DBB-E2E0-4693-B2DA-653AB216C609}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{A55AF8F0-54E3-4911-BE1D-96FE9EFB39AB}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{7E71D3EE-AA48-4CBE-BF1F-01D7CA298E54}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{38520575-5155-4087-910A-65CBBA7D6976}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{390E6E5E-38E2-4DCB-B000-A6729424EDDB}']
    { Property Accessors }
    function Get_FoundNumber: IXMLFoundNumberType;
    function Get_Results: IXMLResultsTypeList;
    { Methods & Properties }
    property FoundNumber: IXMLFoundNumberType read Get_FoundNumber;
    property Results: IXMLResultsTypeList read Get_Results;
  end;

{ IXMLFoundNumberType }

  IXMLFoundNumberType = interface(IXMLNode)
    ['{9EEAD417-9D22-4B34-803D-324199F84659}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLResultsType }

  IXMLResultsType = interface(IXMLNode)
    ['{BB1DBC92-66AF-4669-9618-276D04B1522A}']
    { Property Accessors }
    function Get_Examination: IXMLExaminationType;
    function Get_Subject: IXMLSubjectType;
    function Get_Performer: IXMLPerformerType;
    { Methods & Properties }
    property Examination: IXMLExaminationType read Get_Examination;
    property Subject: IXMLSubjectType read Get_Subject;
    property Performer: IXMLPerformerType read Get_Performer;
  end;

{ IXMLResultsTypeList }

  IXMLResultsTypeList = interface(IXMLNodeCollection)
    ['{F6716B89-ECBD-4B41-BAD8-E1E80BF202D9}']
    { Methods & Properties }
    function Add: IXMLResultsType;
    function Insert(const Index: Integer): IXMLResultsType;

    function Get_Item(Index: Integer): IXMLResultsType;
    property Items[Index: Integer]: IXMLResultsType read Get_Item; default;
  end;

{ IXMLExaminationType }

  IXMLExaminationType = interface(IXMLNode)
    ['{69E9CF82-9C66-42BF-8E39-8B88427091DE}']
    { Property Accessors }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_Lrn: IXMLLrnType;
    function Get_Status: IXMLStatusType;
    function Get_OpenDate: IXMLOpenDateType;
    function Get_CloseDate: IXMLCloseDateType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_DirectedBy: IXMLDirectedByType;
    function Get_Class_: IXMLClassType;
    function Get_Purpose: IXMLPurposeType;
    function Get_CorrectionDate: IXMLCorrectionDateType;
    function Get_CorrectionReason: IXMLCorrectionReasonType;
    function Get_IncidentalVisit: IXMLIncidentalVisitType;
    function Get_IsSecondary: IXMLIsSecondaryType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_AdverseConditions: IXMLAdverseConditionsType;
    function Get_MotherHealthcare: IXMLMotherHealthcareType;
    function Get_ChildHealthcare: IXMLChildHealthcareType;
    function Get_NrnConsultation: IXMLNrnConsultationTypeList;
    function Get_Documents: IXMLDocumentsType;
    function Get_SickLeave: IXMLSickLeaveTypeList;
    function Get_Diagnosis: IXMLDiagnosisType;
    function Get_Comorbidity: IXMLComorbidityTypeList;
    function Get_MedicalHistory: IXMLMedicalHistoryType;
    function Get_ObjectiveCondition: IXMLObjectiveConditionType;
    function Get_Assessment: IXMLAssessmentTypeList;
    function Get_DiagnosticReport: IXMLDiagnosticReportTypeList;
    function Get_Conclusion: IXMLConclusionType;
    function Get_DischargeDisposition: IXMLDischargeDispositionType;
    function Get_Therapy: IXMLTherapyType;
    { Methods & Properties }
    property NrnExamination: IXMLNrnExaminationType read Get_NrnExamination;
    property Lrn: IXMLLrnType read Get_Lrn;
    property Status: IXMLStatusType read Get_Status;
    property OpenDate: IXMLOpenDateType read Get_OpenDate;
    property CloseDate: IXMLCloseDateType read Get_CloseDate;
    property BasedOn: IXMLBasedOnType read Get_BasedOn;
    property DirectedBy: IXMLDirectedByType read Get_DirectedBy;
    property Class_: IXMLClassType read Get_Class_;
    property Purpose: IXMLPurposeType read Get_Purpose;
    property CorrectionDate: IXMLCorrectionDateType read Get_CorrectionDate;
    property CorrectionReason: IXMLCorrectionReasonType read Get_CorrectionReason;
    property IncidentalVisit: IXMLIncidentalVisitType read Get_IncidentalVisit;
    property IsSecondary: IXMLIsSecondaryType read Get_IsSecondary;
    property FinancingSource: IXMLFinancingSourceType read Get_FinancingSource;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
    property AdverseConditions: IXMLAdverseConditionsType read Get_AdverseConditions;
    property MotherHealthcare: IXMLMotherHealthcareType read Get_MotherHealthcare;
    property ChildHealthcare: IXMLChildHealthcareType read Get_ChildHealthcare;
    property NrnConsultation: IXMLNrnConsultationTypeList read Get_NrnConsultation;
    property Documents: IXMLDocumentsType read Get_Documents;
    property SickLeave: IXMLSickLeaveTypeList read Get_SickLeave;
    property Diagnosis: IXMLDiagnosisType read Get_Diagnosis;
    property Comorbidity: IXMLComorbidityTypeList read Get_Comorbidity;
    property MedicalHistory: IXMLMedicalHistoryType read Get_MedicalHistory;
    property ObjectiveCondition: IXMLObjectiveConditionType read Get_ObjectiveCondition;
    property Assessment: IXMLAssessmentTypeList read Get_Assessment;
    property DiagnosticReport: IXMLDiagnosticReportTypeList read Get_DiagnosticReport;
    property Conclusion: IXMLConclusionType read Get_Conclusion;
    property DischargeDisposition: IXMLDischargeDispositionType read Get_DischargeDisposition;
    property Therapy: IXMLTherapyType read Get_Therapy;
  end;

{ IXMLNrnExaminationType }

  IXMLNrnExaminationType = interface(IXMLNode)
    ['{0423C7D1-3F20-49C8-8B29-AB732AB13E06}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLLrnType }

  IXMLLrnType = interface(IXMLNode)
    ['{61F4F15B-D51A-4076-9347-7947C1E97DB4}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLStatusType }

  IXMLStatusType = interface(IXMLNode)
    ['{0B01A44A-2E7C-45D4-8D94-AB5DA9967F94}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLOpenDateType }

  IXMLOpenDateType = interface(IXMLNode)
    ['{433AF57D-047F-40CC-856D-6DEBA422C3BB}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCloseDateType }

  IXMLCloseDateType = interface(IXMLNode)
    ['{A50D3A4C-3FEA-4F38-8B40-B770166D6716}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBasedOnType }

  IXMLBasedOnType = interface(IXMLNode)
    ['{CA1FE29D-1ED6-4043-8EA6-5185760A4E95}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDirectedByType }

  IXMLDirectedByType = interface(IXMLNode)
    ['{0AF427BE-EC41-445C-AF7C-B00D990471B0}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLClassType }

  IXMLClassType = interface(IXMLNode)
    ['{1518DE19-9582-4114-BBF3-B49E8A94E65B}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPurposeType }

  IXMLPurposeType = interface(IXMLNode)
    ['{B4FF060A-057E-404B-BAB0-B15CB4391299}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCorrectionDateType }

  IXMLCorrectionDateType = interface(IXMLNode)
    ['{6B2B2AD5-378A-4BA6-ADF2-AC03FE5589A5}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCorrectionReasonType }

  IXMLCorrectionReasonType = interface(IXMLNode)
    ['{89224B56-E2E6-4946-986F-EC62EF746E79}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIncidentalVisitType }

  IXMLIncidentalVisitType = interface(IXMLNode)
    ['{970F4D6B-E316-4A51-92F9-BBECFCC31741}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsSecondaryType }

  IXMLIsSecondaryType = interface(IXMLNode)
    ['{C36972B1-713D-4A9D-814A-7C6A875119AA}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFinancingSourceType }

  IXMLFinancingSourceType = interface(IXMLNode)
    ['{CB7525A7-1EA1-4CE6-A785-D24A408749EF}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRhifAreaNumberType }

  IXMLRhifAreaNumberType = interface(IXMLNode)
    ['{8DC89A5F-6B82-4489-B754-112CA92F2642}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAdverseConditionsType }

  IXMLAdverseConditionsType = interface(IXMLNode)
    ['{38408BD9-C6C6-4392-9548-54BE6F7E68D4}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMotherHealthcareType }

  IXMLMotherHealthcareType = interface(IXMLNode)
    ['{348C3F12-E9F4-4F3D-A168-799DC642A5BB}']
    { Property Accessors }
    function Get_IsPregnant: IXMLIsPregnantType;
    function Get_IsBreastFeeding: IXMLIsBreastFeedingType;
    function Get_GestationalWeek: IXMLGestationalWeekType;
    { Methods & Properties }
    property IsPregnant: IXMLIsPregnantType read Get_IsPregnant;
    property IsBreastFeeding: IXMLIsBreastFeedingType read Get_IsBreastFeeding;
    property GestationalWeek: IXMLGestationalWeekType read Get_GestationalWeek;
  end;

{ IXMLIsPregnantType }

  IXMLIsPregnantType = interface(IXMLNode)
    ['{13C125F5-B01F-4611-A160-DEC1A8B7AE13}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsBreastFeedingType }

  IXMLIsBreastFeedingType = interface(IXMLNode)
    ['{F2F18E9C-2C47-43F2-A871-2B731BB52B76}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGestationalWeekType }

  IXMLGestationalWeekType = interface(IXMLNode)
    ['{BEE2C9E6-98BC-4CD7-95CF-8E551744A9B4}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLChildHealthcareType }

  IXMLChildHealthcareType = interface(IXMLNode)
    ['{EFD25D18-C88A-472F-80BA-755929C00678}']
    { Property Accessors }
    function Get_Age: IXMLAgeType;
    { Methods & Properties }
    property Age: IXMLAgeType read Get_Age;
  end;

{ IXMLAgeType }

  IXMLAgeType = interface(IXMLNode)
    ['{6B0B8E8B-D7FC-4141-9684-1E7372EBE439}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnConsultationType }

  IXMLNrnConsultationType = interface(IXMLNode)
    ['{17D41E8D-E288-4DE2-A785-990021578248}']
    { Property Accessors }
    function Get_NrnConsultation: IXMLNrnConsultationType2;
    function Get_Qualification: IXMLQualificationType;
    function Get_DirectedOn: IXMLDirectedOnType;
    function Get_PerformedOn: IXMLPerformedOnType;
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property NrnConsultation: IXMLNrnConsultationType2 read Get_NrnConsultation;
    property Qualification: IXMLQualificationType read Get_Qualification;
    property DirectedOn: IXMLDirectedOnType read Get_DirectedOn;
    property PerformedOn: IXMLPerformedOnType read Get_PerformedOn;
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLNrnConsultationTypeList }

  IXMLNrnConsultationTypeList = interface(IXMLNodeCollection)
    ['{645BC017-9EDA-4F06-8890-388CB110837F}']
    { Methods & Properties }
    function Add: IXMLNrnConsultationType;
    function Insert(const Index: Integer): IXMLNrnConsultationType;

    function Get_Item(Index: Integer): IXMLNrnConsultationType;
    property Items[Index: Integer]: IXMLNrnConsultationType read Get_Item; default;
  end;

{ IXMLNrnConsultationType2 }

  IXMLNrnConsultationType2 = interface(IXMLNode)
    ['{B8BF0BF8-B3DE-4D5B-8FE7-6EE6B5A9B04C}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLQualificationType }

  IXMLQualificationType = interface(IXMLNode)
    ['{59A457E4-C6D6-4E4A-8504-A4228F534BB7}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_NhifCode: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    procedure Set_NhifCode(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
    property NhifCode: Integer read Get_NhifCode write Set_NhifCode;
  end;

{ IXMLDirectedOnType }

  IXMLDirectedOnType = interface(IXMLNode)
    ['{C79831AC-E644-4D10-864D-757A284E9458}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPerformedOnType }

  IXMLPerformedOnType = interface(IXMLNode)
    ['{3F8F0327-94A0-47F4-84E0-3B7484A0BD1F}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNoteType }

  IXMLNoteType = interface(IXMLNode)
    ['{A53B66A7-31D4-4699-A5B0-9885F7643BCF}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDocumentsType }

  IXMLDocumentsType = interface(IXMLNode)
    ['{9D2BDF27-0C0B-4353-B746-C9F595D995FE}']
    { Property Accessors }
    function Get_NrnImmunization: IXMLNrnImmunizationTypeList;
    function Get_NrnReferral: IXMLNrnReferralTypeList;
    function Get_NrnPrescription: IXMLNrnPrescriptionTypeList;
    function Get_IssuedTelkDocument: IXMLIssuedTelkDocumentType;
    function Get_IssuedQuickNotice: IXMLIssuedQuickNoticeType;
    function Get_IssuedInterimReport: IXMLIssuedInterimReportType;
    function Get_IssuedMedicalNotice: IXMLIssuedMedicalNoticeType;
    { Methods & Properties }
    property NrnImmunization: IXMLNrnImmunizationTypeList read Get_NrnImmunization;
    property NrnReferral: IXMLNrnReferralTypeList read Get_NrnReferral;
    property NrnPrescription: IXMLNrnPrescriptionTypeList read Get_NrnPrescription;
    property IssuedTelkDocument: IXMLIssuedTelkDocumentType read Get_IssuedTelkDocument;
    property IssuedQuickNotice: IXMLIssuedQuickNoticeType read Get_IssuedQuickNotice;
    property IssuedInterimReport: IXMLIssuedInterimReportType read Get_IssuedInterimReport;
    property IssuedMedicalNotice: IXMLIssuedMedicalNoticeType read Get_IssuedMedicalNotice;
  end;

{ IXMLNrnImmunizationType }

  IXMLNrnImmunizationType = interface(IXMLNode)
    ['{2CF30C0E-5283-4BCD-91A3-D626E0F5A1A2}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnImmunizationTypeList }

  IXMLNrnImmunizationTypeList = interface(IXMLNodeCollection)
    ['{956AD909-BE02-4297-B95B-BC14371F773D}']
    { Methods & Properties }
    function Add: IXMLNrnImmunizationType;
    function Insert(const Index: Integer): IXMLNrnImmunizationType;

    function Get_Item(Index: Integer): IXMLNrnImmunizationType;
    property Items[Index: Integer]: IXMLNrnImmunizationType read Get_Item; default;
  end;

{ IXMLNrnReferralType }

  IXMLNrnReferralType = interface(IXMLNode)
    ['{14A7AF06-6409-47C6-95FA-DC8461F559BC}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnReferralTypeList }

  IXMLNrnReferralTypeList = interface(IXMLNodeCollection)
    ['{3E3E2250-911D-4AE0-8FEF-DCA5FFA4BA77}']
    { Methods & Properties }
    function Add: IXMLNrnReferralType;
    function Insert(const Index: Integer): IXMLNrnReferralType;

    function Get_Item(Index: Integer): IXMLNrnReferralType;
    property Items[Index: Integer]: IXMLNrnReferralType read Get_Item; default;
  end;

{ IXMLNrnPrescriptionType }

  IXMLNrnPrescriptionType = interface(IXMLNode)
    ['{1649AF49-C9CB-4C17-B458-D93A831391D1}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnPrescriptionTypeList }

  IXMLNrnPrescriptionTypeList = interface(IXMLNodeCollection)
    ['{716570DA-5A17-4F56-9722-D8CF5212805B}']
    { Methods & Properties }
    function Add: IXMLNrnPrescriptionType;
    function Insert(const Index: Integer): IXMLNrnPrescriptionType;

    function Get_Item(Index: Integer): IXMLNrnPrescriptionType;
    property Items[Index: Integer]: IXMLNrnPrescriptionType read Get_Item; default;
  end;

{ IXMLIssuedTelkDocumentType }

  IXMLIssuedTelkDocumentType = interface(IXMLNode)
    ['{15B1AE8D-1405-4B7E-BC7C-6675F5AA32A3}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIssuedQuickNoticeType }

  IXMLIssuedQuickNoticeType = interface(IXMLNode)
    ['{859A197A-A174-4581-A5B1-281A66528EC7}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIssuedInterimReportType }

  IXMLIssuedInterimReportType = interface(IXMLNode)
    ['{F099EF55-91C5-4C35-9E37-E24F93B91185}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIssuedMedicalNoticeType }

  IXMLIssuedMedicalNoticeType = interface(IXMLNode)
    ['{A5961575-1AF3-42A6-B0B3-5109F025644A}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSickLeaveType }

  IXMLSickLeaveType = interface(IXMLNode)
    ['{C5E76CB0-DDEE-45ED-99A7-3E0A58639A9C}']
    { Property Accessors }
    function Get_Number: IXMLNumberType;
    function Get_Status: IXMLStatusType;
    function Get_Days: IXMLDaysType;
    function Get_ReasonCode: IXMLReasonCodeType;
    function Get_FromDate: IXMLFromDateType;
    function Get_ToDate: IXMLToDateType;
    function Get_IsInitial: IXMLIsInitialType;
    { Methods & Properties }
    property Number: IXMLNumberType read Get_Number;
    property Status: IXMLStatusType read Get_Status;
    property Days: IXMLDaysType read Get_Days;
    property ReasonCode: IXMLReasonCodeType read Get_ReasonCode;
    property FromDate: IXMLFromDateType read Get_FromDate;
    property ToDate: IXMLToDateType read Get_ToDate;
    property IsInitial: IXMLIsInitialType read Get_IsInitial;
  end;

{ IXMLSickLeaveTypeList }

  IXMLSickLeaveTypeList = interface(IXMLNodeCollection)
    ['{4193C514-8AEF-4A87-8B76-D3C2AD2BD46B}']
    { Methods & Properties }
    function Add: IXMLSickLeaveType;
    function Insert(const Index: Integer): IXMLSickLeaveType;

    function Get_Item(Index: Integer): IXMLSickLeaveType;
    property Items[Index: Integer]: IXMLSickLeaveType read Get_Item; default;
  end;

{ IXMLNumberType }

  IXMLNumberType = interface(IXMLNode)
    ['{5FA2A2AA-5859-4FFF-9BEE-9288F312EB89}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDaysType }

  IXMLDaysType = interface(IXMLNode)
    ['{3C93C0EF-2C0C-49EE-8C65-F6EC8C91C729}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLReasonCodeType }

  IXMLReasonCodeType = interface(IXMLNode)
    ['{BFC4F326-6C29-4389-B869-FA452F857972}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFromDateType }

  IXMLFromDateType = interface(IXMLNode)
    ['{DF36B782-8476-48F1-8B94-8B505155491D}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLToDateType }

  IXMLToDateType = interface(IXMLNode)
    ['{2B2DC26F-13C2-455F-BF2F-9950BA07D9C9}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLIsInitialType }

  IXMLIsInitialType = interface(IXMLNode)
    ['{6D24A550-CD98-4E2A-83B4-49C15B6C8B1B}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDiagnosisType }

  IXMLDiagnosisType = interface(IXMLNode)
    ['{195C0DD6-9A83-4337-AFCC-432F22CA7CDF}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_AdditionalCode: IXMLAdditionalCodeType;
    function Get_Note: IXMLNoteType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    function Get_ClinicalStatus: IXMLClinicalStatusType;
    function Get_VerificationStatus: IXMLVerificationStatusType;
    function Get_OnsetDateTime: IXMLOnsetDateTimeType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property AdditionalCode: IXMLAdditionalCodeType read Get_AdditionalCode;
    property Note: IXMLNoteType read Get_Note;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
    property ClinicalStatus: IXMLClinicalStatusType read Get_ClinicalStatus;
    property VerificationStatus: IXMLVerificationStatusType read Get_VerificationStatus;
    property OnsetDateTime: IXMLOnsetDateTimeType read Get_OnsetDateTime;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{14B87922-A700-44AE-99E0-191B869E4F87}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCodeTypeList }

  IXMLCodeTypeList = interface(IXMLNodeCollection)
    ['{0B4B3EEE-CA2B-4A38-BAE5-80AAC8FE454B}']
    { Methods & Properties }
    function Add: IXMLCodeType;
    function Insert(const Index: Integer): IXMLCodeType;

    function Get_Item(Index: Integer): IXMLCodeType;
    property Items[Index: Integer]: IXMLCodeType read Get_Item; default;
  end;

{ IXMLAdditionalCodeType }

  IXMLAdditionalCodeType = interface(IXMLNode)
    ['{1A62A803-44C0-40ED-A431-FFC6F9B0CAB8}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLUseType }

  IXMLUseType = interface(IXMLNode)
    ['{4BD51CE8-0717-4266-9BD8-543A4FA6577C}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRankType }

  IXMLRankType = interface(IXMLNode)
    ['{8A36FB08-06E2-47FE-8670-FB54B957B8B2}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLClinicalStatusType }

  IXMLClinicalStatusType = interface(IXMLNode)
    ['{23465122-538B-4783-8E87-18BAF6121679}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLVerificationStatusType }

  IXMLVerificationStatusType = interface(IXMLNode)
    ['{06835E53-4EE0-408D-90E7-EAB11C063CD9}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLOnsetDateTimeType }

  IXMLOnsetDateTimeType = interface(IXMLNode)
    ['{85966F1A-D636-42EF-A726-72A2C636F933}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLComorbidityType }

  IXMLComorbidityType = interface(IXMLNode)
    ['{46710383-183D-4963-9209-3DF592465C39}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_AdditionalCode: IXMLAdditionalCodeType;
    function Get_Note: IXMLNoteType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    function Get_ClinicalStatus: IXMLClinicalStatusType;
    function Get_VerificationStatus: IXMLVerificationStatusType;
    function Get_OnsetDateTime: IXMLOnsetDateTimeType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property AdditionalCode: IXMLAdditionalCodeType read Get_AdditionalCode;
    property Note: IXMLNoteType read Get_Note;
    property Use: IXMLUseType read Get_Use;
    property Rank: IXMLRankType read Get_Rank;
    property ClinicalStatus: IXMLClinicalStatusType read Get_ClinicalStatus;
    property VerificationStatus: IXMLVerificationStatusType read Get_VerificationStatus;
    property OnsetDateTime: IXMLOnsetDateTimeType read Get_OnsetDateTime;
  end;

{ IXMLComorbidityTypeList }

  IXMLComorbidityTypeList = interface(IXMLNodeCollection)
    ['{0D7AF2FD-8277-4571-B2A2-077E047D5C8A}']
    { Methods & Properties }
    function Add: IXMLComorbidityType;
    function Insert(const Index: Integer): IXMLComorbidityType;

    function Get_Item(Index: Integer): IXMLComorbidityType;
    property Items[Index: Integer]: IXMLComorbidityType read Get_Item; default;
  end;

{ IXMLMedicalHistoryType }

  IXMLMedicalHistoryType = interface(IXMLNode)
    ['{7DFBCBDD-320C-4CCB-8049-76BBE564805D}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLObjectiveConditionType }

  IXMLObjectiveConditionType = interface(IXMLNode)
    ['{8E1DAA9D-193B-46F1-BA6E-97D3D55B63A1}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAssessmentType }

  IXMLAssessmentType = interface(IXMLNode)
    ['{03C69D33-536E-4B86-B313-E06CA1908FE2}']
    { Property Accessors }
    function Get_NrnExecution: IXMLNrnExecutionTypeList;
    function Get_Code: IXMLCodeTypeList;
    function Get_DirectedOn: IXMLDirectedOnType;
    function Get_PerformedOn: IXMLPerformedOnType;
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property NrnExecution: IXMLNrnExecutionTypeList read Get_NrnExecution;
    property Code: IXMLCodeTypeList read Get_Code;
    property DirectedOn: IXMLDirectedOnType read Get_DirectedOn;
    property PerformedOn: IXMLPerformedOnType read Get_PerformedOn;
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLAssessmentTypeList }

  IXMLAssessmentTypeList = interface(IXMLNodeCollection)
    ['{C8580009-61E8-4528-9D54-61BCFE7BD162}']
    { Methods & Properties }
    function Add: IXMLAssessmentType;
    function Insert(const Index: Integer): IXMLAssessmentType;

    function Get_Item(Index: Integer): IXMLAssessmentType;
    property Items[Index: Integer]: IXMLAssessmentType read Get_Item; default;
  end;

{ IXMLNrnExecutionType }

  IXMLNrnExecutionType = interface(IXMLNode)
    ['{E65A5DCB-EFBC-48CA-8C47-C9E5B40D669C}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnExecutionTypeList }

  IXMLNrnExecutionTypeList = interface(IXMLNodeCollection)
    ['{B5F42685-F4A3-4C0B-9F8C-0419E54F2DFA}']
    { Methods & Properties }
    function Add: IXMLNrnExecutionType;
    function Insert(const Index: Integer): IXMLNrnExecutionType;

    function Get_Item(Index: Integer): IXMLNrnExecutionType;
    property Items[Index: Integer]: IXMLNrnExecutionType read Get_Item; default;
  end;

{ IXMLDiagnosticReportType }

  IXMLDiagnosticReportType = interface(IXMLNode)
    ['{7BD360F9-3421-42D1-B49C-0F6D9D02A321}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_Status: IXMLStatusType;
    function Get_NumberPerformed: IXMLNumberPerformedType;
    function Get_Result: IXMLResultTypeList;
    function Get_Conclusion: IXMLConclusionType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property Status: IXMLStatusType read Get_Status;
    property NumberPerformed: IXMLNumberPerformedType read Get_NumberPerformed;
    property Result: IXMLResultTypeList read Get_Result;
    property Conclusion: IXMLConclusionType read Get_Conclusion;
  end;

{ IXMLDiagnosticReportTypeList }

  IXMLDiagnosticReportTypeList = interface(IXMLNodeCollection)
    ['{FB57363F-DC5F-48A9-8033-5CBB8BC1C832}']
    { Methods & Properties }
    function Add: IXMLDiagnosticReportType;
    function Insert(const Index: Integer): IXMLDiagnosticReportType;

    function Get_Item(Index: Integer): IXMLDiagnosticReportType;
    property Items[Index: Integer]: IXMLDiagnosticReportType read Get_Item; default;
  end;

{ IXMLNumberPerformedType }

  IXMLNumberPerformedType = interface(IXMLNode)
    ['{F370453E-52D6-4410-91FD-BE32F036F1AB}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLResultType }

  IXMLResultType = interface(IXMLNode)
    ['{C0CEF35D-423B-4C70-A36A-AF077E26DCCA}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_ValueScale: IXMLValueScaleType;
    function Get_ValueNomenclature: IXMLValueNomenclatureType;
    function Get_ValueQuantity: IXMLValueQuantityType;
    function Get_ValueUnit: IXMLValueUnitType;
    function Get_ValueDateTime: IXMLValueDateTimeType;
    function Get_ReferenceRange: IXMLReferenceRangeType;
    function Get_Interpretation: IXMLInterpretationTypeList;
    function Get_Method: IXMLMethodType;
    function Get_Category: IXMLCategoryType;
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property ValueScale: IXMLValueScaleType read Get_ValueScale;
    property ValueNomenclature: IXMLValueNomenclatureType read Get_ValueNomenclature;
    property ValueQuantity: IXMLValueQuantityType read Get_ValueQuantity;
    property ValueUnit: IXMLValueUnitType read Get_ValueUnit;
    property ValueDateTime: IXMLValueDateTimeType read Get_ValueDateTime;
    property ReferenceRange: IXMLReferenceRangeType read Get_ReferenceRange;
    property Interpretation: IXMLInterpretationTypeList read Get_Interpretation;
    property Method: IXMLMethodType read Get_Method;
    property Category: IXMLCategoryType read Get_Category;
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLResultTypeList }

  IXMLResultTypeList = interface(IXMLNodeCollection)
    ['{C1F65170-90E6-436C-85CA-7365F8358CD1}']
    { Methods & Properties }
    function Add: IXMLResultType;
    function Insert(const Index: Integer): IXMLResultType;

    function Get_Item(Index: Integer): IXMLResultType;
    property Items[Index: Integer]: IXMLResultType read Get_Item; default;
  end;

{ IXMLValueScaleType }

  IXMLValueScaleType = interface(IXMLNode)
    ['{1ACA1D12-219B-4982-9226-A27F12F4E6A1}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLValueNomenclatureType }

  IXMLValueNomenclatureType = interface(IXMLNode)
    ['{2BCA632F-1122-4CBB-A927-172A48DE2430}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLValueQuantityType }

  IXMLValueQuantityType = interface(IXMLNode)
    ['{41A40AE5-E84C-4DC5-BFF0-7B2F4E0A5613}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLValueUnitType }

  IXMLValueUnitType = interface(IXMLNode)
    ['{10F72D07-65F6-4450-A24F-BF2CDE31A8FA}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLValueDateTimeType }

  IXMLValueDateTimeType = interface(IXMLNode)
    ['{6D81682C-21F8-4C66-8962-4DDEF7F59927}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLReferenceRangeType }

  IXMLReferenceRangeType = interface(IXMLNode)
    ['{766105A9-1D9A-4385-B081-BD4E54E22DF6}']
    { Property Accessors }
    function Get_Low: IXMLLowType;
    function Get_High: IXMLHighType;
    function Get_Text: IXMLTextType;
    { Methods & Properties }
    property Low: IXMLLowType read Get_Low;
    property High: IXMLHighType read Get_High;
    property Text: IXMLTextType read Get_Text;
  end;

{ IXMLLowType }

  IXMLLowType = interface(IXMLNode)
    ['{75CC1E58-7E39-4D19-900C-CA9C62FDF076}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLHighType }

  IXMLHighType = interface(IXMLNode)
    ['{9C6686D7-CFD0-4D42-8379-8389DE2B75D6}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTextType }

  IXMLTextType = interface(IXMLNode)
    ['{2711FB46-EF5C-42DD-9AF4-B7B446A546E7}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLInterpretationType }

  IXMLInterpretationType = interface(IXMLNode)
    ['{ECB691E6-AE3D-4896-A21D-9B35EA3D03D0}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLInterpretationTypeList }

  IXMLInterpretationTypeList = interface(IXMLNodeCollection)
    ['{98A210BD-117A-4AE8-8956-89D1617D9962}']
    { Methods & Properties }
    function Add: IXMLInterpretationType;
    function Insert(const Index: Integer): IXMLInterpretationType;

    function Get_Item(Index: Integer): IXMLInterpretationType;
    property Items[Index: Integer]: IXMLInterpretationType read Get_Item; default;
  end;

{ IXMLMethodType }

  IXMLMethodType = interface(IXMLNode)
    ['{C11A13FE-BC89-4204-801D-705AA154CFEA}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCategoryType }

  IXMLCategoryType = interface(IXMLNode)
    ['{C61440C7-622F-49AF-AA99-788023CE7B32}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLConclusionType }

  IXMLConclusionType = interface(IXMLNode)
    ['{397F5850-BC64-4F2F-9083-1C275CD2D83C}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDischargeDispositionType }

  IXMLDischargeDispositionType = interface(IXMLNode)
    ['{F2A645B6-DD08-4AF8-8B52-D2B5847E94DA}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLTherapyType }

  IXMLTherapyType = interface(IXMLNode)
    ['{89D03EAC-7C71-491A-8548-FBF9AB7DF48E}']
    { Property Accessors }
    function Get_NrnPrescription: IXMLNrnPrescriptionTypeList;
    function Get_MedicationCode: IXMLMedicationCodeTypeList;
    function Get_Note: IXMLNoteType;
    { Methods & Properties }
    property NrnPrescription: IXMLNrnPrescriptionTypeList read Get_NrnPrescription;
    property MedicationCode: IXMLMedicationCodeTypeList read Get_MedicationCode;
    property Note: IXMLNoteType read Get_Note;
  end;

{ IXMLMedicationCodeType }

  IXMLMedicationCodeType = interface(IXMLNode)
    ['{06E6FB64-39DF-4AE3-925B-1EB188F0C204}']
    { Property Accessors }
    function Get_Name: UnicodeString;
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Name: UnicodeString read Get_Name write Set_Name;
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMedicationCodeTypeList }

  IXMLMedicationCodeTypeList = interface(IXMLNodeCollection)
    ['{29CFE725-D10F-46E6-83BF-2DF4339A2146}']
    { Methods & Properties }
    function Add: IXMLMedicationCodeType;
    function Insert(const Index: Integer): IXMLMedicationCodeType;

    function Get_Item(Index: Integer): IXMLMedicationCodeType;
    property Items[Index: Integer]: IXMLMedicationCodeType read Get_Item; default;
  end;

{ IXMLSubjectType }

  IXMLSubjectType = interface(IXMLNode)
    ['{2DA3513B-6DAF-4F92-8364-78207C9FE3E9}']
    { Property Accessors }
    function Get_IdentifierType: IXMLIdentifierType;
    function Get_Identifier: IXMLIdentifierType;
    function Get_BirthDate: IXMLBirthDateType;
    function Get_Gender: IXMLGenderType;
    function Get_Name: IXMLNameType;
    function Get_Address: IXMLAddressType;
    function Get_Nationality: IXMLNationalityType;
    function Get_Phone: IXMLPhoneType;
    function Get_Email: IXMLEmailType;
    { Methods & Properties }
    property IdentifierType: IXMLIdentifierType read Get_IdentifierType;
    property Identifier: IXMLIdentifierType read Get_Identifier;
    property BirthDate: IXMLBirthDateType read Get_BirthDate;
    property Gender: IXMLGenderType read Get_Gender;
    property Name: IXMLNameType read Get_Name;
    property Address: IXMLAddressType read Get_Address;
    property Nationality: IXMLNationalityType read Get_Nationality;
    property Phone: IXMLPhoneType read Get_Phone;
    property Email: IXMLEmailType read Get_Email;
  end;

{ IXMLIdentifierType }

  IXMLIdentifierType = interface(IXMLNode)
    ['{D7A16D80-BB62-4B5A-A8CF-7EF1ECA62DEC}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLBirthDateType }

  IXMLBirthDateType = interface(IXMLNode)
    ['{98FF70E4-61FE-4B14-85B2-0A84FFF15702}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLGenderType }

  IXMLGenderType = interface(IXMLNode)
    ['{C392EC9E-11EF-48EE-8299-7C06DE5E6492}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{8A8BB472-5536-436A-B8CB-7A4E27E053B9}']
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
    ['{38C4E4DE-E9F0-4897-8CBE-6C20538DE8A9}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMiddleType }

  IXMLMiddleType = interface(IXMLNode)
    ['{2E19455A-262D-43CE-80D4-6B1AE377075F}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLFamilyType }

  IXMLFamilyType = interface(IXMLNode)
    ['{16B19764-52BA-42F3-AAE1-F282E55B53A1}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{FC1BCA0C-D9F8-4A0A-A3D3-55FF32C7EFD0}']
    { Property Accessors }
    function Get_Country: IXMLCountryType;
    function Get_County: IXMLCountyType;
    function Get_Ekatte: IXMLEkatteType;
    function Get_City: IXMLCityType;
    function Get_Line: IXMLLineType;
    function Get_PostalCode: IXMLPostalCodeType;
    { Methods & Properties }
    property Country: IXMLCountryType read Get_Country;
    property County: IXMLCountyType read Get_County;
    property Ekatte: IXMLEkatteType read Get_Ekatte;
    property City: IXMLCityType read Get_City;
    property Line: IXMLLineType read Get_Line;
    property PostalCode: IXMLPostalCodeType read Get_PostalCode;
  end;

{ IXMLCountryType }

  IXMLCountryType = interface(IXMLNode)
    ['{DC71EA05-7CE5-4B08-9A1A-E452DC0B17EE}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCountyType }

  IXMLCountyType = interface(IXMLNode)
    ['{EE7C731C-5ADA-4D21-9049-DF9781370AE4}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLEkatteType }

  IXMLEkatteType = interface(IXMLNode)
    ['{1851A6C7-9EBA-4DEF-B272-E55D8EE18B1A}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCityType }

  IXMLCityType = interface(IXMLNode)
    ['{841F9BB2-B169-4C03-9785-BE8AC8A548A6}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLLineType }

  IXMLLineType = interface(IXMLNode)
    ['{1AA9AF56-080E-4226-8703-EEAC9C7AB2F3}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPostalCodeType }

  IXMLPostalCodeType = interface(IXMLNode)
    ['{039FFAE2-01AB-4AD7-B98E-D972CD638843}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLNationalityType }

  IXMLNationalityType = interface(IXMLNode)
    ['{BD709E14-4242-45F1-894A-D3E4940C8F5C}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPhoneType }

  IXMLPhoneType = interface(IXMLNode)
    ['{9454B0AC-7BA9-44F4-9306-5036A4CCD7A4}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLEmailType }

  IXMLEmailType = interface(IXMLNode)
    ['{C5030D59-10CC-4D8B-BA94-A4EEDE56CA88}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPerformerType }

  IXMLPerformerType = interface(IXMLNode)
    ['{F712C754-11F1-4A57-9E47-76C6D2412586}']
    { Property Accessors }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
    function Get_Phone: IXMLPhoneType;
    function Get_Email: IXMLEmailType;
    function Get_PmiDeputy: IXMLPmiDeputyType;
    function Get_Role: IXMLRoleType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_NhifNumber: IXMLNhifNumberType;
    function Get_Accompanying: IXMLAccompanyingTypeList;
    { Methods & Properties }
    property Pmi: IXMLPmiType read Get_Pmi;
    property Qualification: IXMLQualificationType read Get_Qualification;
    property PracticeNumber: IXMLPracticeNumberType read Get_PracticeNumber;
    property Phone: IXMLPhoneType read Get_Phone;
    property Email: IXMLEmailType read Get_Email;
    property PmiDeputy: IXMLPmiDeputyType read Get_PmiDeputy;
    property Role: IXMLRoleType read Get_Role;
    property RhifAreaNumber: IXMLRhifAreaNumberType read Get_RhifAreaNumber;
    property NhifNumber: IXMLNhifNumberType read Get_NhifNumber;
    property Accompanying: IXMLAccompanyingTypeList read Get_Accompanying;
  end;

{ IXMLPmiType }

  IXMLPmiType = interface(IXMLNode)
    ['{9A985CB3-2842-4E2A-9282-B20287F8F233}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPracticeNumberType }

  IXMLPracticeNumberType = interface(IXMLNode)
    ['{FE4785FF-D04A-4E5B-97B6-57C6D1023128}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPmiDeputyType }

  IXMLPmiDeputyType = interface(IXMLNode)
    ['{664B1A97-29A2-4C18-9F08-C9AC7D2CA4B0}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRoleType }

  IXMLRoleType = interface(IXMLNode)
    ['{AFC0F2C2-15F6-43CA-9D8E-51EC21BC4477}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNhifNumberType }

  IXMLNhifNumberType = interface(IXMLNode)
    ['{CDAE1EB4-7ED1-4B14-84B1-268875CA78AB}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLAccompanyingType }

  IXMLAccompanyingType = interface(IXMLNode)
    ['{8B787310-0CDD-43C2-9DA7-C8B6680B68A3}']
    { Property Accessors }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    { Methods & Properties }
    property Pmi: IXMLPmiType read Get_Pmi;
    property Qualification: IXMLQualificationType read Get_Qualification;
  end;

{ IXMLAccompanyingTypeList }

  IXMLAccompanyingTypeList = interface(IXMLNodeCollection)
    ['{F2D65E0D-D715-42B3-8B02-5B9614AC52EB}']
    { Methods & Properties }
    function Add: IXMLAccompanyingType;
    function Insert(const Index: Integer): IXMLAccompanyingType;

    function Get_Item(Index: Integer): IXMLAccompanyingType;
    property Items[Index: Integer]: IXMLAccompanyingType read Get_Item; default;
  end;

{ IXMLWarningsType }

  IXMLWarningsType = interface(IXMLNode)
    ['{CC1D689F-BEDC-4A37-B819-9184746D7FEF}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_Description: IXMLDescriptionType;
    function Get_Source: IXMLSourceType;
    function Get_NrnTarget: IXMLNrnTargetType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property Description: IXMLDescriptionType read Get_Description;
    property Source: IXMLSourceType read Get_Source;
    property NrnTarget: IXMLNrnTargetType read Get_NrnTarget;
  end;

{ IXMLDescriptionType }

  IXMLDescriptionType = interface(IXMLNode)
    ['{D23CD6E6-AFA0-4080-A335-9D7A788402C4}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSourceType }

  IXMLSourceType = interface(IXMLNode)
    ['{BE3402C8-F2E2-42EB-ADF6-5966BF92648E}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnTargetType }

  IXMLNrnTargetType = interface(IXMLNode)
    ['{86670D3F-4618-40FB-AA26-CE99A7E7065E}']
    { Property Accessors }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property DataType: UnicodeString read Get_DataType write Set_DataType;
    property Value: UnicodeString read Get_Value write Set_Value;
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
  TXMLFoundNumberType = class;
  TXMLResultsType = class;
  TXMLResultsTypeList = class;
  TXMLExaminationType = class;
  TXMLNrnExaminationType = class;
  TXMLLrnType = class;
  TXMLStatusType = class;
  TXMLOpenDateType = class;
  TXMLCloseDateType = class;
  TXMLBasedOnType = class;
  TXMLDirectedByType = class;
  TXMLClassType = class;
  TXMLPurposeType = class;
  TXMLCorrectionDateType = class;
  TXMLCorrectionReasonType = class;
  TXMLIncidentalVisitType = class;
  TXMLIsSecondaryType = class;
  TXMLFinancingSourceType = class;
  TXMLRhifAreaNumberType = class;
  TXMLAdverseConditionsType = class;
  TXMLMotherHealthcareType = class;
  TXMLIsPregnantType = class;
  TXMLIsBreastFeedingType = class;
  TXMLGestationalWeekType = class;
  TXMLChildHealthcareType = class;
  TXMLAgeType = class;
  TXMLNrnConsultationType = class;
  TXMLNrnConsultationTypeList = class;
  TXMLNrnConsultationType2 = class;
  TXMLQualificationType = class;
  TXMLDirectedOnType = class;
  TXMLPerformedOnType = class;
  TXMLNoteType = class;
  TXMLDocumentsType = class;
  TXMLNrnImmunizationType = class;
  TXMLNrnImmunizationTypeList = class;
  TXMLNrnReferralType = class;
  TXMLNrnReferralTypeList = class;
  TXMLNrnPrescriptionType = class;
  TXMLNrnPrescriptionTypeList = class;
  TXMLIssuedTelkDocumentType = class;
  TXMLIssuedQuickNoticeType = class;
  TXMLIssuedInterimReportType = class;
  TXMLIssuedMedicalNoticeType = class;
  TXMLSickLeaveType = class;
  TXMLSickLeaveTypeList = class;
  TXMLNumberType = class;
  TXMLDaysType = class;
  TXMLReasonCodeType = class;
  TXMLFromDateType = class;
  TXMLToDateType = class;
  TXMLIsInitialType = class;
  TXMLDiagnosisType = class;
  TXMLCodeType = class;
  TXMLCodeTypeList = class;
  TXMLAdditionalCodeType = class;
  TXMLUseType = class;
  TXMLRankType = class;
  TXMLClinicalStatusType = class;
  TXMLVerificationStatusType = class;
  TXMLOnsetDateTimeType = class;
  TXMLComorbidityType = class;
  TXMLComorbidityTypeList = class;
  TXMLMedicalHistoryType = class;
  TXMLObjectiveConditionType = class;
  TXMLAssessmentType = class;
  TXMLAssessmentTypeList = class;
  TXMLNrnExecutionType = class;
  TXMLNrnExecutionTypeList = class;
  TXMLDiagnosticReportType = class;
  TXMLDiagnosticReportTypeList = class;
  TXMLNumberPerformedType = class;
  TXMLResultType = class;
  TXMLResultTypeList = class;
  TXMLValueScaleType = class;
  TXMLValueNomenclatureType = class;
  TXMLValueQuantityType = class;
  TXMLValueUnitType = class;
  TXMLValueDateTimeType = class;
  TXMLReferenceRangeType = class;
  TXMLLowType = class;
  TXMLHighType = class;
  TXMLTextType = class;
  TXMLInterpretationType = class;
  TXMLInterpretationTypeList = class;
  TXMLMethodType = class;
  TXMLCategoryType = class;
  TXMLConclusionType = class;
  TXMLDischargeDispositionType = class;
  TXMLTherapyType = class;
  TXMLMedicationCodeType = class;
  TXMLMedicationCodeTypeList = class;
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
  TXMLPostalCodeType = class;
  TXMLNationalityType = class;
  TXMLPhoneType = class;
  TXMLEmailType = class;
  TXMLPerformerType = class;
  TXMLPmiType = class;
  TXMLPracticeNumberType = class;
  TXMLPmiDeputyType = class;
  TXMLRoleType = class;
  TXMLNhifNumberType = class;
  TXMLAccompanyingType = class;
  TXMLAccompanyingTypeList = class;
  TXMLWarningsType = class;
  TXMLDescriptionType = class;
  TXMLSourceType = class;
  TXMLNrnTargetType = class;

{ TXMLMessageType }

  TXMLMessageType = class(TXMLNode, IXMLMessageType)
  protected
    { IXMLMessageType }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    function Get_Warnings: IXMLWarningsType;
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
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLSenderIdType }

  TXMLSenderIdType = class(TXMLNode, IXMLSenderIdType)
  protected
    { IXMLSenderIdType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLSenderISNameType }

  TXMLSenderISNameType = class(TXMLNode, IXMLSenderISNameType)
  protected
    { IXMLSenderISNameType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLRecipientType }

  TXMLRecipientType = class(TXMLNode, IXMLRecipientType)
  protected
    { IXMLRecipientType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLRecipientIdType }

  TXMLRecipientIdType = class(TXMLNode, IXMLRecipientIdType)
  protected
    { IXMLRecipientIdType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMessageIdType }

  TXMLMessageIdType = class(TXMLNode, IXMLMessageIdType)
  protected
    { IXMLMessageIdType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMessageType2 }

  TXMLMessageType2 = class(TXMLNode, IXMLMessageType2)
  protected
    { IXMLMessageType2 }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCreatedOnType }

  TXMLCreatedOnType = class(TXMLNode, IXMLCreatedOnType)
  protected
    { IXMLCreatedOnType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
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
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLResultsType }

  TXMLResultsType = class(TXMLNode, IXMLResultsType)
  protected
    { IXMLResultsType }
    function Get_Examination: IXMLExaminationType;
    function Get_Subject: IXMLSubjectType;
    function Get_Performer: IXMLPerformerType;
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

{ TXMLExaminationType }

  TXMLExaminationType = class(TXMLNode, IXMLExaminationType)
  private
    FNrnConsultation: IXMLNrnConsultationTypeList;
    FSickLeave: IXMLSickLeaveTypeList;
    FComorbidity: IXMLComorbidityTypeList;
    FAssessment: IXMLAssessmentTypeList;
    FDiagnosticReport: IXMLDiagnosticReportTypeList;
  protected
    { IXMLExaminationType }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_Lrn: IXMLLrnType;
    function Get_Status: IXMLStatusType;
    function Get_OpenDate: IXMLOpenDateType;
    function Get_CloseDate: IXMLCloseDateType;
    function Get_BasedOn: IXMLBasedOnType;
    function Get_DirectedBy: IXMLDirectedByType;
    function Get_Class_: IXMLClassType;
    function Get_Purpose: IXMLPurposeType;
    function Get_CorrectionDate: IXMLCorrectionDateType;
    function Get_CorrectionReason: IXMLCorrectionReasonType;
    function Get_IncidentalVisit: IXMLIncidentalVisitType;
    function Get_IsSecondary: IXMLIsSecondaryType;
    function Get_FinancingSource: IXMLFinancingSourceType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_AdverseConditions: IXMLAdverseConditionsType;
    function Get_MotherHealthcare: IXMLMotherHealthcareType;
    function Get_ChildHealthcare: IXMLChildHealthcareType;
    function Get_NrnConsultation: IXMLNrnConsultationTypeList;
    function Get_Documents: IXMLDocumentsType;
    function Get_SickLeave: IXMLSickLeaveTypeList;
    function Get_Diagnosis: IXMLDiagnosisType;
    function Get_Comorbidity: IXMLComorbidityTypeList;
    function Get_MedicalHistory: IXMLMedicalHistoryType;
    function Get_ObjectiveCondition: IXMLObjectiveConditionType;
    function Get_Assessment: IXMLAssessmentTypeList;
    function Get_DiagnosticReport: IXMLDiagnosticReportTypeList;
    function Get_Conclusion: IXMLConclusionType;
    function Get_DischargeDisposition: IXMLDischargeDispositionType;
    function Get_Therapy: IXMLTherapyType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNrnExaminationType }

  TXMLNrnExaminationType = class(TXMLNode, IXMLNrnExaminationType)
  protected
    { IXMLNrnExaminationType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLLrnType }

  TXMLLrnType = class(TXMLNode, IXMLLrnType)
  protected
    { IXMLLrnType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLStatusType }

  TXMLStatusType = class(TXMLNode, IXMLStatusType)
  protected
    { IXMLStatusType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLOpenDateType }

  TXMLOpenDateType = class(TXMLNode, IXMLOpenDateType)
  protected
    { IXMLOpenDateType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCloseDateType }

  TXMLCloseDateType = class(TXMLNode, IXMLCloseDateType)
  protected
    { IXMLCloseDateType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLBasedOnType }

  TXMLBasedOnType = class(TXMLNode, IXMLBasedOnType)
  protected
    { IXMLBasedOnType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDirectedByType }

  TXMLDirectedByType = class(TXMLNode, IXMLDirectedByType)
  protected
    { IXMLDirectedByType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLClassType }

  TXMLClassType = class(TXMLNode, IXMLClassType)
  protected
    { IXMLClassType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPurposeType }

  TXMLPurposeType = class(TXMLNode, IXMLPurposeType)
  protected
    { IXMLPurposeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCorrectionDateType }

  TXMLCorrectionDateType = class(TXMLNode, IXMLCorrectionDateType)
  protected
    { IXMLCorrectionDateType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCorrectionReasonType }

  TXMLCorrectionReasonType = class(TXMLNode, IXMLCorrectionReasonType)
  protected
    { IXMLCorrectionReasonType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIncidentalVisitType }

  TXMLIncidentalVisitType = class(TXMLNode, IXMLIncidentalVisitType)
  protected
    { IXMLIncidentalVisitType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIsSecondaryType }

  TXMLIsSecondaryType = class(TXMLNode, IXMLIsSecondaryType)
  protected
    { IXMLIsSecondaryType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLFinancingSourceType }

  TXMLFinancingSourceType = class(TXMLNode, IXMLFinancingSourceType)
  protected
    { IXMLFinancingSourceType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLRhifAreaNumberType }

  TXMLRhifAreaNumberType = class(TXMLNode, IXMLRhifAreaNumberType)
  protected
    { IXMLRhifAreaNumberType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLAdverseConditionsType }

  TXMLAdverseConditionsType = class(TXMLNode, IXMLAdverseConditionsType)
  protected
    { IXMLAdverseConditionsType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMotherHealthcareType }

  TXMLMotherHealthcareType = class(TXMLNode, IXMLMotherHealthcareType)
  protected
    { IXMLMotherHealthcareType }
    function Get_IsPregnant: IXMLIsPregnantType;
    function Get_IsBreastFeeding: IXMLIsBreastFeedingType;
    function Get_GestationalWeek: IXMLGestationalWeekType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIsPregnantType }

  TXMLIsPregnantType = class(TXMLNode, IXMLIsPregnantType)
  protected
    { IXMLIsPregnantType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIsBreastFeedingType }

  TXMLIsBreastFeedingType = class(TXMLNode, IXMLIsBreastFeedingType)
  protected
    { IXMLIsBreastFeedingType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLGestationalWeekType }

  TXMLGestationalWeekType = class(TXMLNode, IXMLGestationalWeekType)
  protected
    { IXMLGestationalWeekType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLChildHealthcareType }

  TXMLChildHealthcareType = class(TXMLNode, IXMLChildHealthcareType)
  protected
    { IXMLChildHealthcareType }
    function Get_Age: IXMLAgeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAgeType }

  TXMLAgeType = class(TXMLNode, IXMLAgeType)
  protected
    { IXMLAgeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnConsultationType }

  TXMLNrnConsultationType = class(TXMLNode, IXMLNrnConsultationType)
  protected
    { IXMLNrnConsultationType }
    function Get_NrnConsultation: IXMLNrnConsultationType2;
    function Get_Qualification: IXMLQualificationType;
    function Get_DirectedOn: IXMLDirectedOnType;
    function Get_PerformedOn: IXMLPerformedOnType;
    function Get_Note: IXMLNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNrnConsultationTypeList }

  TXMLNrnConsultationTypeList = class(TXMLNodeCollection, IXMLNrnConsultationTypeList)
  protected
    { IXMLNrnConsultationTypeList }
    function Add: IXMLNrnConsultationType;
    function Insert(const Index: Integer): IXMLNrnConsultationType;

    function Get_Item(Index: Integer): IXMLNrnConsultationType;
  end;

{ TXMLNrnConsultationType2 }

  TXMLNrnConsultationType2 = class(TXMLNode, IXMLNrnConsultationType2)
  protected
    { IXMLNrnConsultationType2 }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLQualificationType }

  TXMLQualificationType = class(TXMLNode, IXMLQualificationType)
  protected
    { IXMLQualificationType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_NhifCode: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    procedure Set_NhifCode(Value: Integer);
  end;

{ TXMLDirectedOnType }

  TXMLDirectedOnType = class(TXMLNode, IXMLDirectedOnType)
  protected
    { IXMLDirectedOnType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPerformedOnType }

  TXMLPerformedOnType = class(TXMLNode, IXMLPerformedOnType)
  protected
    { IXMLPerformedOnType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNoteType }

  TXMLNoteType = class(TXMLNode, IXMLNoteType)
  protected
    { IXMLNoteType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDocumentsType }

  TXMLDocumentsType = class(TXMLNode, IXMLDocumentsType)
  private
    FNrnImmunization: IXMLNrnImmunizationTypeList;
    FNrnReferral: IXMLNrnReferralTypeList;
    FNrnPrescription: IXMLNrnPrescriptionTypeList;
  protected
    { IXMLDocumentsType }
    function Get_NrnImmunization: IXMLNrnImmunizationTypeList;
    function Get_NrnReferral: IXMLNrnReferralTypeList;
    function Get_NrnPrescription: IXMLNrnPrescriptionTypeList;
    function Get_IssuedTelkDocument: IXMLIssuedTelkDocumentType;
    function Get_IssuedQuickNotice: IXMLIssuedQuickNoticeType;
    function Get_IssuedInterimReport: IXMLIssuedInterimReportType;
    function Get_IssuedMedicalNotice: IXMLIssuedMedicalNoticeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNrnImmunizationType }

  TXMLNrnImmunizationType = class(TXMLNode, IXMLNrnImmunizationType)
  protected
    { IXMLNrnImmunizationType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnImmunizationTypeList }

  TXMLNrnImmunizationTypeList = class(TXMLNodeCollection, IXMLNrnImmunizationTypeList)
  protected
    { IXMLNrnImmunizationTypeList }
    function Add: IXMLNrnImmunizationType;
    function Insert(const Index: Integer): IXMLNrnImmunizationType;

    function Get_Item(Index: Integer): IXMLNrnImmunizationType;
  end;

{ TXMLNrnReferralType }

  TXMLNrnReferralType = class(TXMLNode, IXMLNrnReferralType)
  protected
    { IXMLNrnReferralType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
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
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnPrescriptionTypeList }

  TXMLNrnPrescriptionTypeList = class(TXMLNodeCollection, IXMLNrnPrescriptionTypeList)
  protected
    { IXMLNrnPrescriptionTypeList }
    function Add: IXMLNrnPrescriptionType;
    function Insert(const Index: Integer): IXMLNrnPrescriptionType;

    function Get_Item(Index: Integer): IXMLNrnPrescriptionType;
  end;

{ TXMLIssuedTelkDocumentType }

  TXMLIssuedTelkDocumentType = class(TXMLNode, IXMLIssuedTelkDocumentType)
  protected
    { IXMLIssuedTelkDocumentType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIssuedQuickNoticeType }

  TXMLIssuedQuickNoticeType = class(TXMLNode, IXMLIssuedQuickNoticeType)
  protected
    { IXMLIssuedQuickNoticeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIssuedInterimReportType }

  TXMLIssuedInterimReportType = class(TXMLNode, IXMLIssuedInterimReportType)
  protected
    { IXMLIssuedInterimReportType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIssuedMedicalNoticeType }

  TXMLIssuedMedicalNoticeType = class(TXMLNode, IXMLIssuedMedicalNoticeType)
  protected
    { IXMLIssuedMedicalNoticeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLSickLeaveType }

  TXMLSickLeaveType = class(TXMLNode, IXMLSickLeaveType)
  protected
    { IXMLSickLeaveType }
    function Get_Number: IXMLNumberType;
    function Get_Status: IXMLStatusType;
    function Get_Days: IXMLDaysType;
    function Get_ReasonCode: IXMLReasonCodeType;
    function Get_FromDate: IXMLFromDateType;
    function Get_ToDate: IXMLToDateType;
    function Get_IsInitial: IXMLIsInitialType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSickLeaveTypeList }

  TXMLSickLeaveTypeList = class(TXMLNodeCollection, IXMLSickLeaveTypeList)
  protected
    { IXMLSickLeaveTypeList }
    function Add: IXMLSickLeaveType;
    function Insert(const Index: Integer): IXMLSickLeaveType;

    function Get_Item(Index: Integer): IXMLSickLeaveType;
  end;

{ TXMLNumberType }

  TXMLNumberType = class(TXMLNode, IXMLNumberType)
  protected
    { IXMLNumberType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDaysType }

  TXMLDaysType = class(TXMLNode, IXMLDaysType)
  protected
    { IXMLDaysType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLReasonCodeType }

  TXMLReasonCodeType = class(TXMLNode, IXMLReasonCodeType)
  protected
    { IXMLReasonCodeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLFromDateType }

  TXMLFromDateType = class(TXMLNode, IXMLFromDateType)
  protected
    { IXMLFromDateType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLToDateType }

  TXMLToDateType = class(TXMLNode, IXMLToDateType)
  protected
    { IXMLToDateType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLIsInitialType }

  TXMLIsInitialType = class(TXMLNode, IXMLIsInitialType)
  protected
    { IXMLIsInitialType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDiagnosisType }

  TXMLDiagnosisType = class(TXMLNode, IXMLDiagnosisType)
  protected
    { IXMLDiagnosisType }
    function Get_Code: IXMLCodeType;
    function Get_AdditionalCode: IXMLAdditionalCodeType;
    function Get_Note: IXMLNoteType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    function Get_ClinicalStatus: IXMLClinicalStatusType;
    function Get_VerificationStatus: IXMLVerificationStatusType;
    function Get_OnsetDateTime: IXMLOnsetDateTimeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCodeType }

  TXMLCodeType = class(TXMLNode, IXMLCodeType)
  protected
    { IXMLCodeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCodeTypeList }

  TXMLCodeTypeList = class(TXMLNodeCollection, IXMLCodeTypeList)
  protected
    { IXMLCodeTypeList }
    function Add: IXMLCodeType;
    function Insert(const Index: Integer): IXMLCodeType;

    function Get_Item(Index: Integer): IXMLCodeType;
  end;

{ TXMLAdditionalCodeType }

  TXMLAdditionalCodeType = class(TXMLNode, IXMLAdditionalCodeType)
  protected
    { IXMLAdditionalCodeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLUseType }

  TXMLUseType = class(TXMLNode, IXMLUseType)
  protected
    { IXMLUseType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLRankType }

  TXMLRankType = class(TXMLNode, IXMLRankType)
  protected
    { IXMLRankType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLClinicalStatusType }

  TXMLClinicalStatusType = class(TXMLNode, IXMLClinicalStatusType)
  protected
    { IXMLClinicalStatusType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLVerificationStatusType }

  TXMLVerificationStatusType = class(TXMLNode, IXMLVerificationStatusType)
  protected
    { IXMLVerificationStatusType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLOnsetDateTimeType }

  TXMLOnsetDateTimeType = class(TXMLNode, IXMLOnsetDateTimeType)
  protected
    { IXMLOnsetDateTimeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLComorbidityType }

  TXMLComorbidityType = class(TXMLNode, IXMLComorbidityType)
  protected
    { IXMLComorbidityType }
    function Get_Code: IXMLCodeType;
    function Get_AdditionalCode: IXMLAdditionalCodeType;
    function Get_Note: IXMLNoteType;
    function Get_Use: IXMLUseType;
    function Get_Rank: IXMLRankType;
    function Get_ClinicalStatus: IXMLClinicalStatusType;
    function Get_VerificationStatus: IXMLVerificationStatusType;
    function Get_OnsetDateTime: IXMLOnsetDateTimeType;
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
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLObjectiveConditionType }

  TXMLObjectiveConditionType = class(TXMLNode, IXMLObjectiveConditionType)
  protected
    { IXMLObjectiveConditionType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLAssessmentType }

  TXMLAssessmentType = class(TXMLNode, IXMLAssessmentType)
  private
    FNrnExecution: IXMLNrnExecutionTypeList;
    FCode: IXMLCodeTypeList;
  protected
    { IXMLAssessmentType }
    function Get_NrnExecution: IXMLNrnExecutionTypeList;
    function Get_Code: IXMLCodeTypeList;
    function Get_DirectedOn: IXMLDirectedOnType;
    function Get_PerformedOn: IXMLPerformedOnType;
    function Get_Note: IXMLNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAssessmentTypeList }

  TXMLAssessmentTypeList = class(TXMLNodeCollection, IXMLAssessmentTypeList)
  protected
    { IXMLAssessmentTypeList }
    function Add: IXMLAssessmentType;
    function Insert(const Index: Integer): IXMLAssessmentType;

    function Get_Item(Index: Integer): IXMLAssessmentType;
  end;

{ TXMLNrnExecutionType }

  TXMLNrnExecutionType = class(TXMLNode, IXMLNrnExecutionType)
  protected
    { IXMLNrnExecutionType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnExecutionTypeList }

  TXMLNrnExecutionTypeList = class(TXMLNodeCollection, IXMLNrnExecutionTypeList)
  protected
    { IXMLNrnExecutionTypeList }
    function Add: IXMLNrnExecutionType;
    function Insert(const Index: Integer): IXMLNrnExecutionType;

    function Get_Item(Index: Integer): IXMLNrnExecutionType;
  end;

{ TXMLDiagnosticReportType }

  TXMLDiagnosticReportType = class(TXMLNode, IXMLDiagnosticReportType)
  private
    FResult: IXMLResultTypeList;
  protected
    { IXMLDiagnosticReportType }
    function Get_Code: IXMLCodeType;
    function Get_Status: IXMLStatusType;
    function Get_NumberPerformed: IXMLNumberPerformedType;
    function Get_Result: IXMLResultTypeList;
    function Get_Conclusion: IXMLConclusionType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDiagnosticReportTypeList }

  TXMLDiagnosticReportTypeList = class(TXMLNodeCollection, IXMLDiagnosticReportTypeList)
  protected
    { IXMLDiagnosticReportTypeList }
    function Add: IXMLDiagnosticReportType;
    function Insert(const Index: Integer): IXMLDiagnosticReportType;

    function Get_Item(Index: Integer): IXMLDiagnosticReportType;
  end;

{ TXMLNumberPerformedType }

  TXMLNumberPerformedType = class(TXMLNode, IXMLNumberPerformedType)
  protected
    { IXMLNumberPerformedType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLResultType }

  TXMLResultType = class(TXMLNode, IXMLResultType)
  private
    FInterpretation: IXMLInterpretationTypeList;
  protected
    { IXMLResultType }
    function Get_Code: IXMLCodeType;
    function Get_ValueScale: IXMLValueScaleType;
    function Get_ValueNomenclature: IXMLValueNomenclatureType;
    function Get_ValueQuantity: IXMLValueQuantityType;
    function Get_ValueUnit: IXMLValueUnitType;
    function Get_ValueDateTime: IXMLValueDateTimeType;
    function Get_ReferenceRange: IXMLReferenceRangeType;
    function Get_Interpretation: IXMLInterpretationTypeList;
    function Get_Method: IXMLMethodType;
    function Get_Category: IXMLCategoryType;
    function Get_Note: IXMLNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLResultTypeList }

  TXMLResultTypeList = class(TXMLNodeCollection, IXMLResultTypeList)
  protected
    { IXMLResultTypeList }
    function Add: IXMLResultType;
    function Insert(const Index: Integer): IXMLResultType;

    function Get_Item(Index: Integer): IXMLResultType;
  end;

{ TXMLValueScaleType }

  TXMLValueScaleType = class(TXMLNode, IXMLValueScaleType)
  protected
    { IXMLValueScaleType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLValueNomenclatureType }

  TXMLValueNomenclatureType = class(TXMLNode, IXMLValueNomenclatureType)
  protected
    { IXMLValueNomenclatureType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLValueQuantityType }

  TXMLValueQuantityType = class(TXMLNode, IXMLValueQuantityType)
  protected
    { IXMLValueQuantityType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLValueUnitType }

  TXMLValueUnitType = class(TXMLNode, IXMLValueUnitType)
  protected
    { IXMLValueUnitType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLValueDateTimeType }

  TXMLValueDateTimeType = class(TXMLNode, IXMLValueDateTimeType)
  protected
    { IXMLValueDateTimeType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLReferenceRangeType }

  TXMLReferenceRangeType = class(TXMLNode, IXMLReferenceRangeType)
  protected
    { IXMLReferenceRangeType }
    function Get_Low: IXMLLowType;
    function Get_High: IXMLHighType;
    function Get_Text: IXMLTextType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLowType }

  TXMLLowType = class(TXMLNode, IXMLLowType)
  protected
    { IXMLLowType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLHighType }

  TXMLHighType = class(TXMLNode, IXMLHighType)
  protected
    { IXMLHighType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLTextType }

  TXMLTextType = class(TXMLNode, IXMLTextType)
  protected
    { IXMLTextType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLInterpretationType }

  TXMLInterpretationType = class(TXMLNode, IXMLInterpretationType)
  protected
    { IXMLInterpretationType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLInterpretationTypeList }

  TXMLInterpretationTypeList = class(TXMLNodeCollection, IXMLInterpretationTypeList)
  protected
    { IXMLInterpretationTypeList }
    function Add: IXMLInterpretationType;
    function Insert(const Index: Integer): IXMLInterpretationType;

    function Get_Item(Index: Integer): IXMLInterpretationType;
  end;

{ TXMLMethodType }

  TXMLMethodType = class(TXMLNode, IXMLMethodType)
  protected
    { IXMLMethodType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCategoryType }

  TXMLCategoryType = class(TXMLNode, IXMLCategoryType)
  protected
    { IXMLCategoryType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLConclusionType }

  TXMLConclusionType = class(TXMLNode, IXMLConclusionType)
  protected
    { IXMLConclusionType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDischargeDispositionType }

  TXMLDischargeDispositionType = class(TXMLNode, IXMLDischargeDispositionType)
  protected
    { IXMLDischargeDispositionType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLTherapyType }

  TXMLTherapyType = class(TXMLNode, IXMLTherapyType)
  private
    FNrnPrescription: IXMLNrnPrescriptionTypeList;
    FMedicationCode: IXMLMedicationCodeTypeList;
  protected
    { IXMLTherapyType }
    function Get_NrnPrescription: IXMLNrnPrescriptionTypeList;
    function Get_MedicationCode: IXMLMedicationCodeTypeList;
    function Get_Note: IXMLNoteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMedicationCodeType }

  TXMLMedicationCodeType = class(TXMLNode, IXMLMedicationCodeType)
  protected
    { IXMLMedicationCodeType }
    function Get_Name: UnicodeString;
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMedicationCodeTypeList }

  TXMLMedicationCodeTypeList = class(TXMLNodeCollection, IXMLMedicationCodeTypeList)
  protected
    { IXMLMedicationCodeTypeList }
    function Add: IXMLMedicationCodeType;
    function Insert(const Index: Integer): IXMLMedicationCodeType;

    function Get_Item(Index: Integer): IXMLMedicationCodeType;
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
    function Get_Phone: IXMLPhoneType;
    function Get_Email: IXMLEmailType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIdentifierType }

  TXMLIdentifierType = class(TXMLNode, IXMLIdentifierType)
  protected
    { IXMLIdentifierType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLBirthDateType }

  TXMLBirthDateType = class(TXMLNode, IXMLBirthDateType)
  protected
    { IXMLBirthDateType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLGenderType }

  TXMLGenderType = class(TXMLNode, IXMLGenderType)
  protected
    { IXMLGenderType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
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
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMiddleType }

  TXMLMiddleType = class(TXMLNode, IXMLMiddleType)
  protected
    { IXMLMiddleType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLFamilyType }

  TXMLFamilyType = class(TXMLNode, IXMLFamilyType)
  protected
    { IXMLFamilyType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
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
    function Get_PostalCode: IXMLPostalCodeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCountryType }

  TXMLCountryType = class(TXMLNode, IXMLCountryType)
  protected
    { IXMLCountryType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCountyType }

  TXMLCountyType = class(TXMLNode, IXMLCountyType)
  protected
    { IXMLCountyType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLEkatteType }

  TXMLEkatteType = class(TXMLNode, IXMLEkatteType)
  protected
    { IXMLEkatteType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCityType }

  TXMLCityType = class(TXMLNode, IXMLCityType)
  protected
    { IXMLCityType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLLineType }

  TXMLLineType = class(TXMLNode, IXMLLineType)
  protected
    { IXMLLineType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPostalCodeType }

  TXMLPostalCodeType = class(TXMLNode, IXMLPostalCodeType)
  protected
    { IXMLPostalCodeType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLNationalityType }

  TXMLNationalityType = class(TXMLNode, IXMLNationalityType)
  protected
    { IXMLNationalityType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPhoneType }

  TXMLPhoneType = class(TXMLNode, IXMLPhoneType)
  protected
    { IXMLPhoneType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLEmailType }

  TXMLEmailType = class(TXMLNode, IXMLEmailType)
  protected
    { IXMLEmailType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPerformerType }

  TXMLPerformerType = class(TXMLNode, IXMLPerformerType)
  private
    FAccompanying: IXMLAccompanyingTypeList;
  protected
    { IXMLPerformerType }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
    function Get_PracticeNumber: IXMLPracticeNumberType;
    function Get_Phone: IXMLPhoneType;
    function Get_Email: IXMLEmailType;
    function Get_PmiDeputy: IXMLPmiDeputyType;
    function Get_Role: IXMLRoleType;
    function Get_RhifAreaNumber: IXMLRhifAreaNumberType;
    function Get_NhifNumber: IXMLNhifNumberType;
    function Get_Accompanying: IXMLAccompanyingTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPmiType }

  TXMLPmiType = class(TXMLNode, IXMLPmiType)
  protected
    { IXMLPmiType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPracticeNumberType }

  TXMLPracticeNumberType = class(TXMLNode, IXMLPracticeNumberType)
  protected
    { IXMLPracticeNumberType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLPmiDeputyType }

  TXMLPmiDeputyType = class(TXMLNode, IXMLPmiDeputyType)
  protected
    { IXMLPmiDeputyType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLRoleType }

  TXMLRoleType = class(TXMLNode, IXMLRoleType)
  protected
    { IXMLRoleType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNhifNumberType }

  TXMLNhifNumberType = class(TXMLNode, IXMLNhifNumberType)
  protected
    { IXMLNhifNumberType }
    function Get_DataType: UnicodeString;
    function Get_Value: Integer;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: Integer);
  end;

{ TXMLAccompanyingType }

  TXMLAccompanyingType = class(TXMLNode, IXMLAccompanyingType)
  protected
    { IXMLAccompanyingType }
    function Get_Pmi: IXMLPmiType;
    function Get_Qualification: IXMLQualificationType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAccompanyingTypeList }

  TXMLAccompanyingTypeList = class(TXMLNodeCollection, IXMLAccompanyingTypeList)
  protected
    { IXMLAccompanyingTypeList }
    function Add: IXMLAccompanyingType;
    function Insert(const Index: Integer): IXMLAccompanyingType;

    function Get_Item(Index: Integer): IXMLAccompanyingType;
  end;

{ TXMLWarningsType }

  TXMLWarningsType = class(TXMLNode, IXMLWarningsType)
  protected
    { IXMLWarningsType }
    function Get_Code: IXMLCodeType;
    function Get_Description: IXMLDescriptionType;
    function Get_Source: IXMLSourceType;
    function Get_NrnTarget: IXMLNrnTargetType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDescriptionType }

  TXMLDescriptionType = class(TXMLNode, IXMLDescriptionType)
  protected
    { IXMLDescriptionType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLSourceType }

  TXMLSourceType = class(TXMLNode, IXMLSourceType)
  protected
    { IXMLSourceType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnTargetType }

  TXMLNrnTargetType = class(TXMLNode, IXMLNrnTargetType)
  protected
    { IXMLNrnTargetType }
    function Get_DataType: UnicodeString;
    function Get_Value: UnicodeString;
    procedure Set_DataType(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
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
  RegisterChildNode('warnings', TXMLWarningsType);
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

function TXMLMessageType.Get_Warnings: IXMLWarningsType;
begin
  Result := ChildNodes['warnings'] as IXMLWarningsType;
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

function TXMLSenderType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLSenderType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLSenderType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSenderType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLSenderIdType }

function TXMLSenderIdType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLSenderIdType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLSenderIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSenderIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLSenderISNameType }

function TXMLSenderISNameType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLSenderISNameType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLSenderISNameType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSenderISNameType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLRecipientType }

function TXMLRecipientType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLRecipientType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLRecipientType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLRecipientType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLRecipientIdType }

function TXMLRecipientIdType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLRecipientIdType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLRecipientIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLRecipientIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMessageIdType }

function TXMLMessageIdType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLMessageIdType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLMessageIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMessageIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMessageType2 }

function TXMLMessageType2.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLMessageType2.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLMessageType2.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMessageType2.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCreatedOnType }

function TXMLCreatedOnType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCreatedOnType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

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

function TXMLFoundNumberType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLFoundNumberType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

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
  RegisterChildNode('examination', TXMLExaminationType);
  RegisterChildNode('subject', TXMLSubjectType);
  RegisterChildNode('performer', TXMLPerformerType);
  inherited;
end;

function TXMLResultsType.Get_Examination: IXMLExaminationType;
begin
  Result := ChildNodes['examination'] as IXMLExaminationType;
end;

function TXMLResultsType.Get_Subject: IXMLSubjectType;
begin
  Result := ChildNodes['subject'] as IXMLSubjectType;
end;

function TXMLResultsType.Get_Performer: IXMLPerformerType;
begin
  Result := ChildNodes['performer'] as IXMLPerformerType;
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

{ TXMLExaminationType }

procedure TXMLExaminationType.AfterConstruction;
begin
  RegisterChildNode('nrnExamination', TXMLNrnExaminationType);
  RegisterChildNode('lrn', TXMLLrnType);
  RegisterChildNode('status', TXMLStatusType);
  RegisterChildNode('openDate', TXMLOpenDateType);
  RegisterChildNode('closeDate', TXMLCloseDateType);
  RegisterChildNode('basedOn', TXMLBasedOnType);
  RegisterChildNode('directedBy', TXMLDirectedByType);
  RegisterChildNode('class', TXMLClassType);
  RegisterChildNode('purpose', TXMLPurposeType);
  RegisterChildNode('correctionDate', TXMLCorrectionDateType);
  RegisterChildNode('correctionReason', TXMLCorrectionReasonType);
  RegisterChildNode('incidentalVisit', TXMLIncidentalVisitType);
  RegisterChildNode('isSecondary', TXMLIsSecondaryType);
  RegisterChildNode('financingSource', TXMLFinancingSourceType);
  RegisterChildNode('rhifAreaNumber', TXMLRhifAreaNumberType);
  RegisterChildNode('adverseConditions', TXMLAdverseConditionsType);
  RegisterChildNode('motherHealthcare', TXMLMotherHealthcareType);
  RegisterChildNode('childHealthcare', TXMLChildHealthcareType);
  RegisterChildNode('nrnConsultation', TXMLNrnConsultationType);
  RegisterChildNode('documents', TXMLDocumentsType);
  RegisterChildNode('sickLeave', TXMLSickLeaveType);
  RegisterChildNode('diagnosis', TXMLDiagnosisType);
  RegisterChildNode('comorbidity', TXMLComorbidityType);
  RegisterChildNode('medicalHistory', TXMLMedicalHistoryType);
  RegisterChildNode('objectiveCondition', TXMLObjectiveConditionType);
  RegisterChildNode('assessment', TXMLAssessmentType);
  RegisterChildNode('diagnosticReport', TXMLDiagnosticReportType);
  RegisterChildNode('conclusion', TXMLConclusionType);
  RegisterChildNode('dischargeDisposition', TXMLDischargeDispositionType);
  RegisterChildNode('therapy', TXMLTherapyType);
  FNrnConsultation := CreateCollection(TXMLNrnConsultationTypeList, IXMLNrnConsultationType, 'nrnConsultation') as IXMLNrnConsultationTypeList;
  FSickLeave := CreateCollection(TXMLSickLeaveTypeList, IXMLSickLeaveType, 'sickLeave') as IXMLSickLeaveTypeList;
  FComorbidity := CreateCollection(TXMLComorbidityTypeList, IXMLComorbidityType, 'comorbidity') as IXMLComorbidityTypeList;
  FAssessment := CreateCollection(TXMLAssessmentTypeList, IXMLAssessmentType, 'assessment') as IXMLAssessmentTypeList;
  FDiagnosticReport := CreateCollection(TXMLDiagnosticReportTypeList, IXMLDiagnosticReportType, 'diagnosticReport') as IXMLDiagnosticReportTypeList;
  inherited;
end;

function TXMLExaminationType.Get_NrnExamination: IXMLNrnExaminationType;
begin
  Result := ChildNodes['nrnExamination'] as IXMLNrnExaminationType;
end;

function TXMLExaminationType.Get_Lrn: IXMLLrnType;
begin
  Result := ChildNodes['lrn'] as IXMLLrnType;
end;

function TXMLExaminationType.Get_Status: IXMLStatusType;
begin
  Result := ChildNodes['status'] as IXMLStatusType;
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

function TXMLExaminationType.Get_DirectedBy: IXMLDirectedByType;
begin
  Result := ChildNodes['directedBy'] as IXMLDirectedByType;
end;

function TXMLExaminationType.Get_Class_: IXMLClassType;
begin
  Result := ChildNodes['class'] as IXMLClassType;
end;

function TXMLExaminationType.Get_Purpose: IXMLPurposeType;
begin
  Result := ChildNodes['purpose'] as IXMLPurposeType;
end;

function TXMLExaminationType.Get_CorrectionDate: IXMLCorrectionDateType;
begin
  Result := ChildNodes['correctionDate'] as IXMLCorrectionDateType;
end;

function TXMLExaminationType.Get_CorrectionReason: IXMLCorrectionReasonType;
begin
  Result := ChildNodes['correctionReason'] as IXMLCorrectionReasonType;
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

function TXMLExaminationType.Get_MotherHealthcare: IXMLMotherHealthcareType;
begin
  Result := ChildNodes['motherHealthcare'] as IXMLMotherHealthcareType;
end;

function TXMLExaminationType.Get_ChildHealthcare: IXMLChildHealthcareType;
begin
  Result := ChildNodes['childHealthcare'] as IXMLChildHealthcareType;
end;

function TXMLExaminationType.Get_NrnConsultation: IXMLNrnConsultationTypeList;
begin
  Result := FNrnConsultation;
end;

function TXMLExaminationType.Get_Documents: IXMLDocumentsType;
begin
  Result := ChildNodes['documents'] as IXMLDocumentsType;
end;

function TXMLExaminationType.Get_SickLeave: IXMLSickLeaveTypeList;
begin
  Result := FSickLeave;
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

function TXMLExaminationType.Get_Assessment: IXMLAssessmentTypeList;
begin
  Result := FAssessment;
end;

function TXMLExaminationType.Get_DiagnosticReport: IXMLDiagnosticReportTypeList;
begin
  Result := FDiagnosticReport;
end;

function TXMLExaminationType.Get_Conclusion: IXMLConclusionType;
begin
  Result := ChildNodes['conclusion'] as IXMLConclusionType;
end;

function TXMLExaminationType.Get_DischargeDisposition: IXMLDischargeDispositionType;
begin
  Result := ChildNodes['dischargeDisposition'] as IXMLDischargeDispositionType;
end;

function TXMLExaminationType.Get_Therapy: IXMLTherapyType;
begin
  Result := ChildNodes['therapy'] as IXMLTherapyType;
end;

{ TXMLNrnExaminationType }

function TXMLNrnExaminationType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnExaminationType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNrnExaminationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnExaminationType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLLrnType }

function TXMLLrnType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLLrnType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLLrnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLrnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLStatusType }

function TXMLStatusType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLStatusType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLStatusType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLStatusType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLOpenDateType }

function TXMLOpenDateType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLOpenDateType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLOpenDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLOpenDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCloseDateType }

function TXMLCloseDateType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCloseDateType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCloseDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCloseDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLBasedOnType }

function TXMLBasedOnType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLBasedOnType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLBasedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLBasedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDirectedByType }

function TXMLDirectedByType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLDirectedByType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLDirectedByType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLDirectedByType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLClassType }

function TXMLClassType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLClassType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLClassType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLClassType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPurposeType }

function TXMLPurposeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPurposeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPurposeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLPurposeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCorrectionDateType }

function TXMLCorrectionDateType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCorrectionDateType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCorrectionDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCorrectionDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCorrectionReasonType }

function TXMLCorrectionReasonType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCorrectionReasonType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCorrectionReasonType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCorrectionReasonType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIncidentalVisitType }

function TXMLIncidentalVisitType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIncidentalVisitType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIncidentalVisitType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIncidentalVisitType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIsSecondaryType }

function TXMLIsSecondaryType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIsSecondaryType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIsSecondaryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIsSecondaryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLFinancingSourceType }

function TXMLFinancingSourceType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLFinancingSourceType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLFinancingSourceType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLFinancingSourceType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLRhifAreaNumberType }

function TXMLRhifAreaNumberType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLRhifAreaNumberType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLRhifAreaNumberType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLRhifAreaNumberType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLAdverseConditionsType }

function TXMLAdverseConditionsType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLAdverseConditionsType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLAdverseConditionsType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLAdverseConditionsType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMotherHealthcareType }

procedure TXMLMotherHealthcareType.AfterConstruction;
begin
  RegisterChildNode('isPregnant', TXMLIsPregnantType);
  RegisterChildNode('isBreastFeeding', TXMLIsBreastFeedingType);
  RegisterChildNode('gestationalWeek', TXMLGestationalWeekType);
  inherited;
end;

function TXMLMotherHealthcareType.Get_IsPregnant: IXMLIsPregnantType;
begin
  Result := ChildNodes['isPregnant'] as IXMLIsPregnantType;
end;

function TXMLMotherHealthcareType.Get_IsBreastFeeding: IXMLIsBreastFeedingType;
begin
  Result := ChildNodes['isBreastFeeding'] as IXMLIsBreastFeedingType;
end;

function TXMLMotherHealthcareType.Get_GestationalWeek: IXMLGestationalWeekType;
begin
  Result := ChildNodes['gestationalWeek'] as IXMLGestationalWeekType;
end;

{ TXMLIsPregnantType }

function TXMLIsPregnantType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIsPregnantType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIsPregnantType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIsPregnantType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIsBreastFeedingType }

function TXMLIsBreastFeedingType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIsBreastFeedingType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIsBreastFeedingType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIsBreastFeedingType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLGestationalWeekType }

function TXMLGestationalWeekType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLGestationalWeekType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLGestationalWeekType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLGestationalWeekType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLChildHealthcareType }

procedure TXMLChildHealthcareType.AfterConstruction;
begin
  RegisterChildNode('age', TXMLAgeType);
  inherited;
end;

function TXMLChildHealthcareType.Get_Age: IXMLAgeType;
begin
  Result := ChildNodes['age'] as IXMLAgeType;
end;

{ TXMLAgeType }

function TXMLAgeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLAgeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLAgeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLAgeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnConsultationType }

procedure TXMLNrnConsultationType.AfterConstruction;
begin
  RegisterChildNode('nrnConsultation', TXMLNrnConsultationType2);
  RegisterChildNode('qualification', TXMLQualificationType);
  RegisterChildNode('directedOn', TXMLDirectedOnType);
  RegisterChildNode('performedOn', TXMLPerformedOnType);
  RegisterChildNode('note', TXMLNoteType);
  inherited;
end;

function TXMLNrnConsultationType.Get_NrnConsultation: IXMLNrnConsultationType2;
begin
  Result := ChildNodes['nrnConsultation'] as IXMLNrnConsultationType2;
end;

function TXMLNrnConsultationType.Get_Qualification: IXMLQualificationType;
begin
  Result := ChildNodes['qualification'] as IXMLQualificationType;
end;

function TXMLNrnConsultationType.Get_DirectedOn: IXMLDirectedOnType;
begin
  Result := ChildNodes['directedOn'] as IXMLDirectedOnType;
end;

function TXMLNrnConsultationType.Get_PerformedOn: IXMLPerformedOnType;
begin
  Result := ChildNodes['performedOn'] as IXMLPerformedOnType;
end;

function TXMLNrnConsultationType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

{ TXMLNrnConsultationTypeList }

function TXMLNrnConsultationTypeList.Add: IXMLNrnConsultationType;
begin
  Result := AddItem(-1) as IXMLNrnConsultationType;
end;

function TXMLNrnConsultationTypeList.Insert(const Index: Integer): IXMLNrnConsultationType;
begin
  Result := AddItem(Index) as IXMLNrnConsultationType;
end;

function TXMLNrnConsultationTypeList.Get_Item(Index: Integer): IXMLNrnConsultationType;
begin
  Result := List[Index] as IXMLNrnConsultationType;
end;

{ TXMLNrnConsultationType2 }

function TXMLNrnConsultationType2.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnConsultationType2.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNrnConsultationType2.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnConsultationType2.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLQualificationType }

function TXMLQualificationType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLQualificationType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

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

{ TXMLDirectedOnType }

function TXMLDirectedOnType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLDirectedOnType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLDirectedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLDirectedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPerformedOnType }

function TXMLPerformedOnType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPerformedOnType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPerformedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLPerformedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNoteType }

function TXMLNoteType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNoteType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNoteType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNoteType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDocumentsType }

procedure TXMLDocumentsType.AfterConstruction;
begin
  RegisterChildNode('nrnImmunization', TXMLNrnImmunizationType);
  RegisterChildNode('nrnReferral', TXMLNrnReferralType);
  RegisterChildNode('nrnPrescription', TXMLNrnPrescriptionType);
  RegisterChildNode('issuedTelkDocument', TXMLIssuedTelkDocumentType);
  RegisterChildNode('issuedQuickNotice', TXMLIssuedQuickNoticeType);
  RegisterChildNode('issuedInterimReport', TXMLIssuedInterimReportType);
  RegisterChildNode('issuedMedicalNotice', TXMLIssuedMedicalNoticeType);
  FNrnImmunization := CreateCollection(TXMLNrnImmunizationTypeList, IXMLNrnImmunizationType, 'nrnImmunization') as IXMLNrnImmunizationTypeList;
  FNrnReferral := CreateCollection(TXMLNrnReferralTypeList, IXMLNrnReferralType, 'nrnReferral') as IXMLNrnReferralTypeList;
  FNrnPrescription := CreateCollection(TXMLNrnPrescriptionTypeList, IXMLNrnPrescriptionType, 'nrnPrescription') as IXMLNrnPrescriptionTypeList;
  inherited;
end;

function TXMLDocumentsType.Get_NrnImmunization: IXMLNrnImmunizationTypeList;
begin
  Result := FNrnImmunization;
end;

function TXMLDocumentsType.Get_NrnReferral: IXMLNrnReferralTypeList;
begin
  Result := FNrnReferral;
end;

function TXMLDocumentsType.Get_NrnPrescription: IXMLNrnPrescriptionTypeList;
begin
  Result := FNrnPrescription;
end;

function TXMLDocumentsType.Get_IssuedTelkDocument: IXMLIssuedTelkDocumentType;
begin
  Result := ChildNodes['issuedTelkDocument'] as IXMLIssuedTelkDocumentType;
end;

function TXMLDocumentsType.Get_IssuedQuickNotice: IXMLIssuedQuickNoticeType;
begin
  Result := ChildNodes['issuedQuickNotice'] as IXMLIssuedQuickNoticeType;
end;

function TXMLDocumentsType.Get_IssuedInterimReport: IXMLIssuedInterimReportType;
begin
  Result := ChildNodes['issuedInterimReport'] as IXMLIssuedInterimReportType;
end;

function TXMLDocumentsType.Get_IssuedMedicalNotice: IXMLIssuedMedicalNoticeType;
begin
  Result := ChildNodes['issuedMedicalNotice'] as IXMLIssuedMedicalNoticeType;
end;

{ TXMLNrnImmunizationType }

function TXMLNrnImmunizationType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnImmunizationType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNrnImmunizationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnImmunizationType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnImmunizationTypeList }

function TXMLNrnImmunizationTypeList.Add: IXMLNrnImmunizationType;
begin
  Result := AddItem(-1) as IXMLNrnImmunizationType;
end;

function TXMLNrnImmunizationTypeList.Insert(const Index: Integer): IXMLNrnImmunizationType;
begin
  Result := AddItem(Index) as IXMLNrnImmunizationType;
end;

function TXMLNrnImmunizationTypeList.Get_Item(Index: Integer): IXMLNrnImmunizationType;
begin
  Result := List[Index] as IXMLNrnImmunizationType;
end;

{ TXMLNrnReferralType }

function TXMLNrnReferralType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnReferralType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

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

function TXMLNrnPrescriptionType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnPrescriptionType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNrnPrescriptionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnPrescriptionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnPrescriptionTypeList }

function TXMLNrnPrescriptionTypeList.Add: IXMLNrnPrescriptionType;
begin
  Result := AddItem(-1) as IXMLNrnPrescriptionType;
end;

function TXMLNrnPrescriptionTypeList.Insert(const Index: Integer): IXMLNrnPrescriptionType;
begin
  Result := AddItem(Index) as IXMLNrnPrescriptionType;
end;

function TXMLNrnPrescriptionTypeList.Get_Item(Index: Integer): IXMLNrnPrescriptionType;
begin
  Result := List[Index] as IXMLNrnPrescriptionType;
end;

{ TXMLIssuedTelkDocumentType }

function TXMLIssuedTelkDocumentType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIssuedTelkDocumentType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIssuedTelkDocumentType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIssuedTelkDocumentType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIssuedQuickNoticeType }

function TXMLIssuedQuickNoticeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIssuedQuickNoticeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIssuedQuickNoticeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIssuedQuickNoticeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIssuedInterimReportType }

function TXMLIssuedInterimReportType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIssuedInterimReportType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIssuedInterimReportType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIssuedInterimReportType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIssuedMedicalNoticeType }

function TXMLIssuedMedicalNoticeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIssuedMedicalNoticeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIssuedMedicalNoticeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIssuedMedicalNoticeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLSickLeaveType }

procedure TXMLSickLeaveType.AfterConstruction;
begin
  RegisterChildNode('number', TXMLNumberType);
  RegisterChildNode('status', TXMLStatusType);
  RegisterChildNode('days', TXMLDaysType);
  RegisterChildNode('reasonCode', TXMLReasonCodeType);
  RegisterChildNode('fromDate', TXMLFromDateType);
  RegisterChildNode('toDate', TXMLToDateType);
  RegisterChildNode('isInitial', TXMLIsInitialType);
  inherited;
end;

function TXMLSickLeaveType.Get_Number: IXMLNumberType;
begin
  Result := ChildNodes['number'] as IXMLNumberType;
end;

function TXMLSickLeaveType.Get_Status: IXMLStatusType;
begin
  Result := ChildNodes['status'] as IXMLStatusType;
end;

function TXMLSickLeaveType.Get_Days: IXMLDaysType;
begin
  Result := ChildNodes['days'] as IXMLDaysType;
end;

function TXMLSickLeaveType.Get_ReasonCode: IXMLReasonCodeType;
begin
  Result := ChildNodes['reasonCode'] as IXMLReasonCodeType;
end;

function TXMLSickLeaveType.Get_FromDate: IXMLFromDateType;
begin
  Result := ChildNodes['fromDate'] as IXMLFromDateType;
end;

function TXMLSickLeaveType.Get_ToDate: IXMLToDateType;
begin
  Result := ChildNodes['toDate'] as IXMLToDateType;
end;

function TXMLSickLeaveType.Get_IsInitial: IXMLIsInitialType;
begin
  Result := ChildNodes['isInitial'] as IXMLIsInitialType;
end;

{ TXMLSickLeaveTypeList }

function TXMLSickLeaveTypeList.Add: IXMLSickLeaveType;
begin
  Result := AddItem(-1) as IXMLSickLeaveType;
end;

function TXMLSickLeaveTypeList.Insert(const Index: Integer): IXMLSickLeaveType;
begin
  Result := AddItem(Index) as IXMLSickLeaveType;
end;

function TXMLSickLeaveTypeList.Get_Item(Index: Integer): IXMLSickLeaveType;
begin
  Result := List[Index] as IXMLSickLeaveType;
end;

{ TXMLNumberType }

function TXMLNumberType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNumberType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNumberType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNumberType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDaysType }

function TXMLDaysType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLDaysType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLDaysType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLDaysType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLReasonCodeType }

function TXMLReasonCodeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLReasonCodeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLReasonCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLReasonCodeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLFromDateType }

function TXMLFromDateType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLFromDateType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLFromDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLFromDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLToDateType }

function TXMLToDateType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLToDateType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLToDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLToDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLIsInitialType }

function TXMLIsInitialType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIsInitialType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIsInitialType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIsInitialType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDiagnosisType }

procedure TXMLDiagnosisType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('additionalCode', TXMLAdditionalCodeType);
  RegisterChildNode('note', TXMLNoteType);
  RegisterChildNode('use', TXMLUseType);
  RegisterChildNode('rank', TXMLRankType);
  RegisterChildNode('clinicalStatus', TXMLClinicalStatusType);
  RegisterChildNode('verificationStatus', TXMLVerificationStatusType);
  RegisterChildNode('onsetDateTime', TXMLOnsetDateTimeType);
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

function TXMLDiagnosisType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

function TXMLDiagnosisType.Get_Use: IXMLUseType;
begin
  Result := ChildNodes['use'] as IXMLUseType;
end;

function TXMLDiagnosisType.Get_Rank: IXMLRankType;
begin
  Result := ChildNodes['rank'] as IXMLRankType;
end;

function TXMLDiagnosisType.Get_ClinicalStatus: IXMLClinicalStatusType;
begin
  Result := ChildNodes['clinicalStatus'] as IXMLClinicalStatusType;
end;

function TXMLDiagnosisType.Get_VerificationStatus: IXMLVerificationStatusType;
begin
  Result := ChildNodes['verificationStatus'] as IXMLVerificationStatusType;
end;

function TXMLDiagnosisType.Get_OnsetDateTime: IXMLOnsetDateTimeType;
begin
  Result := ChildNodes['onsetDateTime'] as IXMLOnsetDateTimeType;
end;

{ TXMLCodeType }

function TXMLCodeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCodeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCodeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCodeTypeList }

function TXMLCodeTypeList.Add: IXMLCodeType;
begin
  Result := AddItem(-1) as IXMLCodeType;
end;

function TXMLCodeTypeList.Insert(const Index: Integer): IXMLCodeType;
begin
  Result := AddItem(Index) as IXMLCodeType;
end;

function TXMLCodeTypeList.Get_Item(Index: Integer): IXMLCodeType;
begin
  Result := List[Index] as IXMLCodeType;
end;

{ TXMLAdditionalCodeType }

function TXMLAdditionalCodeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLAdditionalCodeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLAdditionalCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLAdditionalCodeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLUseType }

function TXMLUseType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLUseType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLUseType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLUseType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLRankType }

function TXMLRankType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLRankType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLRankType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRankType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLClinicalStatusType }

function TXMLClinicalStatusType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLClinicalStatusType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLClinicalStatusType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLClinicalStatusType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLVerificationStatusType }

function TXMLVerificationStatusType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLVerificationStatusType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLVerificationStatusType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLVerificationStatusType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLOnsetDateTimeType }

function TXMLOnsetDateTimeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLOnsetDateTimeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLOnsetDateTimeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLOnsetDateTimeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLComorbidityType }

procedure TXMLComorbidityType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('additionalCode', TXMLAdditionalCodeType);
  RegisterChildNode('note', TXMLNoteType);
  RegisterChildNode('use', TXMLUseType);
  RegisterChildNode('rank', TXMLRankType);
  RegisterChildNode('clinicalStatus', TXMLClinicalStatusType);
  RegisterChildNode('verificationStatus', TXMLVerificationStatusType);
  RegisterChildNode('onsetDateTime', TXMLOnsetDateTimeType);
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

function TXMLComorbidityType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

function TXMLComorbidityType.Get_Use: IXMLUseType;
begin
  Result := ChildNodes['use'] as IXMLUseType;
end;

function TXMLComorbidityType.Get_Rank: IXMLRankType;
begin
  Result := ChildNodes['rank'] as IXMLRankType;
end;

function TXMLComorbidityType.Get_ClinicalStatus: IXMLClinicalStatusType;
begin
  Result := ChildNodes['clinicalStatus'] as IXMLClinicalStatusType;
end;

function TXMLComorbidityType.Get_VerificationStatus: IXMLVerificationStatusType;
begin
  Result := ChildNodes['verificationStatus'] as IXMLVerificationStatusType;
end;

function TXMLComorbidityType.Get_OnsetDateTime: IXMLOnsetDateTimeType;
begin
  Result := ChildNodes['onsetDateTime'] as IXMLOnsetDateTimeType;
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

function TXMLMedicalHistoryType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLMedicalHistoryType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLMedicalHistoryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMedicalHistoryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLObjectiveConditionType }

function TXMLObjectiveConditionType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLObjectiveConditionType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

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
  RegisterChildNode('nrnExecution', TXMLNrnExecutionType);
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('directedOn', TXMLDirectedOnType);
  RegisterChildNode('performedOn', TXMLPerformedOnType);
  RegisterChildNode('note', TXMLNoteType);
  FNrnExecution := CreateCollection(TXMLNrnExecutionTypeList, IXMLNrnExecutionType, 'nrnExecution') as IXMLNrnExecutionTypeList;
  FCode := CreateCollection(TXMLCodeTypeList, IXMLCodeType, 'code') as IXMLCodeTypeList;
  inherited;
end;

function TXMLAssessmentType.Get_NrnExecution: IXMLNrnExecutionTypeList;
begin
  Result := FNrnExecution;
end;

function TXMLAssessmentType.Get_Code: IXMLCodeTypeList;
begin
  Result := FCode;
end;

function TXMLAssessmentType.Get_DirectedOn: IXMLDirectedOnType;
begin
  Result := ChildNodes['directedOn'] as IXMLDirectedOnType;
end;

function TXMLAssessmentType.Get_PerformedOn: IXMLPerformedOnType;
begin
  Result := ChildNodes['performedOn'] as IXMLPerformedOnType;
end;

function TXMLAssessmentType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

{ TXMLAssessmentTypeList }

function TXMLAssessmentTypeList.Add: IXMLAssessmentType;
begin
  Result := AddItem(-1) as IXMLAssessmentType;
end;

function TXMLAssessmentTypeList.Insert(const Index: Integer): IXMLAssessmentType;
begin
  Result := AddItem(Index) as IXMLAssessmentType;
end;

function TXMLAssessmentTypeList.Get_Item(Index: Integer): IXMLAssessmentType;
begin
  Result := List[Index] as IXMLAssessmentType;
end;

{ TXMLNrnExecutionType }

function TXMLNrnExecutionType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnExecutionType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNrnExecutionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnExecutionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnExecutionTypeList }

function TXMLNrnExecutionTypeList.Add: IXMLNrnExecutionType;
begin
  Result := AddItem(-1) as IXMLNrnExecutionType;
end;

function TXMLNrnExecutionTypeList.Insert(const Index: Integer): IXMLNrnExecutionType;
begin
  Result := AddItem(Index) as IXMLNrnExecutionType;
end;

function TXMLNrnExecutionTypeList.Get_Item(Index: Integer): IXMLNrnExecutionType;
begin
  Result := List[Index] as IXMLNrnExecutionType;
end;

{ TXMLDiagnosticReportType }

procedure TXMLDiagnosticReportType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('status', TXMLStatusType);
  RegisterChildNode('numberPerformed', TXMLNumberPerformedType);
  RegisterChildNode('result', TXMLResultType);
  RegisterChildNode('conclusion', TXMLConclusionType);
  FResult := CreateCollection(TXMLResultTypeList, IXMLResultType, 'result') as IXMLResultTypeList;
  inherited;
end;

function TXMLDiagnosticReportType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLDiagnosticReportType.Get_Status: IXMLStatusType;
begin
  Result := ChildNodes['status'] as IXMLStatusType;
end;

function TXMLDiagnosticReportType.Get_NumberPerformed: IXMLNumberPerformedType;
begin
  Result := ChildNodes['numberPerformed'] as IXMLNumberPerformedType;
end;

function TXMLDiagnosticReportType.Get_Result: IXMLResultTypeList;
begin
  Result := FResult;
end;

function TXMLDiagnosticReportType.Get_Conclusion: IXMLConclusionType;
begin
  Result := ChildNodes['conclusion'] as IXMLConclusionType;
end;

{ TXMLDiagnosticReportTypeList }

function TXMLDiagnosticReportTypeList.Add: IXMLDiagnosticReportType;
begin
  Result := AddItem(-1) as IXMLDiagnosticReportType;
end;

function TXMLDiagnosticReportTypeList.Insert(const Index: Integer): IXMLDiagnosticReportType;
begin
  Result := AddItem(Index) as IXMLDiagnosticReportType;
end;

function TXMLDiagnosticReportTypeList.Get_Item(Index: Integer): IXMLDiagnosticReportType;
begin
  Result := List[Index] as IXMLDiagnosticReportType;
end;

{ TXMLNumberPerformedType }

function TXMLNumberPerformedType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNumberPerformedType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNumberPerformedType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLNumberPerformedType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLResultType }

procedure TXMLResultType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('valueScale', TXMLValueScaleType);
  RegisterChildNode('valueNomenclature', TXMLValueNomenclatureType);
  RegisterChildNode('valueQuantity', TXMLValueQuantityType);
  RegisterChildNode('valueUnit', TXMLValueUnitType);
  RegisterChildNode('valueDateTime', TXMLValueDateTimeType);
  RegisterChildNode('referenceRange', TXMLReferenceRangeType);
  RegisterChildNode('interpretation', TXMLInterpretationType);
  RegisterChildNode('method', TXMLMethodType);
  RegisterChildNode('category', TXMLCategoryType);
  RegisterChildNode('note', TXMLNoteType);
  FInterpretation := CreateCollection(TXMLInterpretationTypeList, IXMLInterpretationType, 'interpretation') as IXMLInterpretationTypeList;
  inherited;
end;

function TXMLResultType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLResultType.Get_ValueScale: IXMLValueScaleType;
begin
  Result := ChildNodes['valueScale'] as IXMLValueScaleType;
end;

function TXMLResultType.Get_ValueNomenclature: IXMLValueNomenclatureType;
begin
  Result := ChildNodes['valueNomenclature'] as IXMLValueNomenclatureType;
end;

function TXMLResultType.Get_ValueQuantity: IXMLValueQuantityType;
begin
  Result := ChildNodes['valueQuantity'] as IXMLValueQuantityType;
end;

function TXMLResultType.Get_ValueUnit: IXMLValueUnitType;
begin
  Result := ChildNodes['valueUnit'] as IXMLValueUnitType;
end;

function TXMLResultType.Get_ValueDateTime: IXMLValueDateTimeType;
begin
  Result := ChildNodes['valueDateTime'] as IXMLValueDateTimeType;
end;

function TXMLResultType.Get_ReferenceRange: IXMLReferenceRangeType;
begin
  Result := ChildNodes['referenceRange'] as IXMLReferenceRangeType;
end;

function TXMLResultType.Get_Interpretation: IXMLInterpretationTypeList;
begin
  Result := FInterpretation;
end;

function TXMLResultType.Get_Method: IXMLMethodType;
begin
  Result := ChildNodes['method'] as IXMLMethodType;
end;

function TXMLResultType.Get_Category: IXMLCategoryType;
begin
  Result := ChildNodes['category'] as IXMLCategoryType;
end;

function TXMLResultType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

{ TXMLResultTypeList }

function TXMLResultTypeList.Add: IXMLResultType;
begin
  Result := AddItem(-1) as IXMLResultType;
end;

function TXMLResultTypeList.Insert(const Index: Integer): IXMLResultType;
begin
  Result := AddItem(Index) as IXMLResultType;
end;

function TXMLResultTypeList.Get_Item(Index: Integer): IXMLResultType;
begin
  Result := List[Index] as IXMLResultType;
end;

{ TXMLValueScaleType }

function TXMLValueScaleType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLValueScaleType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLValueScaleType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLValueScaleType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLValueNomenclatureType }

function TXMLValueNomenclatureType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLValueNomenclatureType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLValueNomenclatureType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLValueNomenclatureType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLValueQuantityType }

function TXMLValueQuantityType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLValueQuantityType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLValueQuantityType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLValueQuantityType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLValueUnitType }

function TXMLValueUnitType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLValueUnitType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLValueUnitType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLValueUnitType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLValueDateTimeType }

function TXMLValueDateTimeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLValueDateTimeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLValueDateTimeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLValueDateTimeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLReferenceRangeType }

procedure TXMLReferenceRangeType.AfterConstruction;
begin
  RegisterChildNode('low', TXMLLowType);
  RegisterChildNode('high', TXMLHighType);
  RegisterChildNode('text', TXMLTextType);
  inherited;
end;

function TXMLReferenceRangeType.Get_Low: IXMLLowType;
begin
  Result := ChildNodes['low'] as IXMLLowType;
end;

function TXMLReferenceRangeType.Get_High: IXMLHighType;
begin
  Result := ChildNodes['high'] as IXMLHighType;
end;

function TXMLReferenceRangeType.Get_Text: IXMLTextType;
begin
  Result := ChildNodes['text'] as IXMLTextType;
end;

{ TXMLLowType }

function TXMLLowType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLLowType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLLowType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLowType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLHighType }

function TXMLHighType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLHighType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLHighType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLHighType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLTextType }

function TXMLTextType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLTextType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLTextType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLTextType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLInterpretationType }

function TXMLInterpretationType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLInterpretationType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLInterpretationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLInterpretationType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLInterpretationTypeList }

function TXMLInterpretationTypeList.Add: IXMLInterpretationType;
begin
  Result := AddItem(-1) as IXMLInterpretationType;
end;

function TXMLInterpretationTypeList.Insert(const Index: Integer): IXMLInterpretationType;
begin
  Result := AddItem(Index) as IXMLInterpretationType;
end;

function TXMLInterpretationTypeList.Get_Item(Index: Integer): IXMLInterpretationType;
begin
  Result := List[Index] as IXMLInterpretationType;
end;

{ TXMLMethodType }

function TXMLMethodType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLMethodType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLMethodType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMethodType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCategoryType }

function TXMLCategoryType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCategoryType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCategoryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCategoryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLConclusionType }

function TXMLConclusionType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLConclusionType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLConclusionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLConclusionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDischargeDispositionType }

function TXMLDischargeDispositionType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLDischargeDispositionType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLDischargeDispositionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLDischargeDispositionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLTherapyType }

procedure TXMLTherapyType.AfterConstruction;
begin
  RegisterChildNode('nrnPrescription', TXMLNrnPrescriptionType);
  RegisterChildNode('medicationCode', TXMLMedicationCodeType);
  RegisterChildNode('note', TXMLNoteType);
  FNrnPrescription := CreateCollection(TXMLNrnPrescriptionTypeList, IXMLNrnPrescriptionType, 'nrnPrescription') as IXMLNrnPrescriptionTypeList;
  FMedicationCode := CreateCollection(TXMLMedicationCodeTypeList, IXMLMedicationCodeType, 'medicationCode') as IXMLMedicationCodeTypeList;
  inherited;
end;

function TXMLTherapyType.Get_NrnPrescription: IXMLNrnPrescriptionTypeList;
begin
  Result := FNrnPrescription;
end;

function TXMLTherapyType.Get_MedicationCode: IXMLMedicationCodeTypeList;
begin
  Result := FMedicationCode;
end;

function TXMLTherapyType.Get_Note: IXMLNoteType;
begin
  Result := ChildNodes['note'] as IXMLNoteType;
end;

{ TXMLMedicationCodeType }

function TXMLMedicationCodeType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLMedicationCodeType.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLMedicationCodeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLMedicationCodeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLMedicationCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMedicationCodeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMedicationCodeTypeList }

function TXMLMedicationCodeTypeList.Add: IXMLMedicationCodeType;
begin
  Result := AddItem(-1) as IXMLMedicationCodeType;
end;

function TXMLMedicationCodeTypeList.Insert(const Index: Integer): IXMLMedicationCodeType;
begin
  Result := AddItem(Index) as IXMLMedicationCodeType;
end;

function TXMLMedicationCodeTypeList.Get_Item(Index: Integer): IXMLMedicationCodeType;
begin
  Result := List[Index] as IXMLMedicationCodeType;
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
  RegisterChildNode('phone', TXMLPhoneType);
  RegisterChildNode('email', TXMLEmailType);
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

function TXMLSubjectType.Get_Phone: IXMLPhoneType;
begin
  Result := ChildNodes['phone'] as IXMLPhoneType;
end;

function TXMLSubjectType.Get_Email: IXMLEmailType;
begin
  Result := ChildNodes['email'] as IXMLEmailType;
end;

{ TXMLIdentifierType }

function TXMLIdentifierType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLIdentifierType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLIdentifierType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLIdentifierType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLBirthDateType }

function TXMLBirthDateType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLBirthDateType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLBirthDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLBirthDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLGenderType }

function TXMLGenderType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLGenderType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLGenderType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLGenderType.Set_Value(Value: UnicodeString);
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

function TXMLGivenType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLGivenType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLGivenType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLGivenType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMiddleType }

function TXMLMiddleType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLMiddleType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLMiddleType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMiddleType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLFamilyType }

function TXMLFamilyType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLFamilyType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

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
  RegisterChildNode('postalCode', TXMLPostalCodeType);
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

function TXMLAddressType.Get_PostalCode: IXMLPostalCodeType;
begin
  Result := ChildNodes['postalCode'] as IXMLPostalCodeType;
end;

{ TXMLCountryType }

function TXMLCountryType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCountryType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCountryType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCountryType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCountyType }

function TXMLCountyType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCountyType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCountyType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCountyType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLEkatteType }

function TXMLEkatteType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLEkatteType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLEkatteType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLEkatteType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCityType }

function TXMLCityType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLCityType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLCityType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCityType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLLineType }

function TXMLLineType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLLineType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLLineType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLineType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPostalCodeType }

function TXMLPostalCodeType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPostalCodeType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPostalCodeType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPostalCodeType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLNationalityType }

function TXMLNationalityType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNationalityType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNationalityType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNationalityType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPhoneType }

function TXMLPhoneType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPhoneType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPhoneType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPhoneType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLEmailType }

function TXMLEmailType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLEmailType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLEmailType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLEmailType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPerformerType }

procedure TXMLPerformerType.AfterConstruction;
begin
  RegisterChildNode('pmi', TXMLPmiType);
  RegisterChildNode('qualification', TXMLQualificationType);
  RegisterChildNode('practiceNumber', TXMLPracticeNumberType);
  RegisterChildNode('phone', TXMLPhoneType);
  RegisterChildNode('email', TXMLEmailType);
  RegisterChildNode('pmiDeputy', TXMLPmiDeputyType);
  RegisterChildNode('role', TXMLRoleType);
  RegisterChildNode('rhifAreaNumber', TXMLRhifAreaNumberType);
  RegisterChildNode('nhifNumber', TXMLNhifNumberType);
  RegisterChildNode('accompanying', TXMLAccompanyingType);
  FAccompanying := CreateCollection(TXMLAccompanyingTypeList, IXMLAccompanyingType, 'accompanying') as IXMLAccompanyingTypeList;
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

function TXMLPerformerType.Get_PracticeNumber: IXMLPracticeNumberType;
begin
  Result := ChildNodes['practiceNumber'] as IXMLPracticeNumberType;
end;

function TXMLPerformerType.Get_Phone: IXMLPhoneType;
begin
  Result := ChildNodes['phone'] as IXMLPhoneType;
end;

function TXMLPerformerType.Get_Email: IXMLEmailType;
begin
  Result := ChildNodes['email'] as IXMLEmailType;
end;

function TXMLPerformerType.Get_PmiDeputy: IXMLPmiDeputyType;
begin
  Result := ChildNodes['pmiDeputy'] as IXMLPmiDeputyType;
end;

function TXMLPerformerType.Get_Role: IXMLRoleType;
begin
  Result := ChildNodes['role'] as IXMLRoleType;
end;

function TXMLPerformerType.Get_RhifAreaNumber: IXMLRhifAreaNumberType;
begin
  Result := ChildNodes['rhifAreaNumber'] as IXMLRhifAreaNumberType;
end;

function TXMLPerformerType.Get_NhifNumber: IXMLNhifNumberType;
begin
  Result := ChildNodes['nhifNumber'] as IXMLNhifNumberType;
end;

function TXMLPerformerType.Get_Accompanying: IXMLAccompanyingTypeList;
begin
  Result := FAccompanying;
end;

{ TXMLPmiType }

function TXMLPmiType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPmiType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPmiType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPmiType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPracticeNumberType }

function TXMLPracticeNumberType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPracticeNumberType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPracticeNumberType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPracticeNumberType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLPmiDeputyType }

function TXMLPmiDeputyType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLPmiDeputyType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLPmiDeputyType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPmiDeputyType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLRoleType }

function TXMLRoleType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLRoleType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLRoleType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLRoleType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNhifNumberType }

function TXMLNhifNumberType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNhifNumberType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNhifNumberType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLNhifNumberType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLAccompanyingType }

procedure TXMLAccompanyingType.AfterConstruction;
begin
  RegisterChildNode('pmi', TXMLPmiType);
  RegisterChildNode('qualification', TXMLQualificationType);
  inherited;
end;

function TXMLAccompanyingType.Get_Pmi: IXMLPmiType;
begin
  Result := ChildNodes['pmi'] as IXMLPmiType;
end;

function TXMLAccompanyingType.Get_Qualification: IXMLQualificationType;
begin
  Result := ChildNodes['qualification'] as IXMLQualificationType;
end;

{ TXMLAccompanyingTypeList }

function TXMLAccompanyingTypeList.Add: IXMLAccompanyingType;
begin
  Result := AddItem(-1) as IXMLAccompanyingType;
end;

function TXMLAccompanyingTypeList.Insert(const Index: Integer): IXMLAccompanyingType;
begin
  Result := AddItem(Index) as IXMLAccompanyingType;
end;

function TXMLAccompanyingTypeList.Get_Item(Index: Integer): IXMLAccompanyingType;
begin
  Result := List[Index] as IXMLAccompanyingType;
end;

{ TXMLWarningsType }

procedure TXMLWarningsType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('description', TXMLDescriptionType);
  RegisterChildNode('source', TXMLSourceType);
  RegisterChildNode('nrnTarget', TXMLNrnTargetType);
  inherited;
end;

function TXMLWarningsType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLWarningsType.Get_Description: IXMLDescriptionType;
begin
  Result := ChildNodes['description'] as IXMLDescriptionType;
end;

function TXMLWarningsType.Get_Source: IXMLSourceType;
begin
  Result := ChildNodes['source'] as IXMLSourceType;
end;

function TXMLWarningsType.Get_NrnTarget: IXMLNrnTargetType;
begin
  Result := ChildNodes['nrnTarget'] as IXMLNrnTargetType;
end;

{ TXMLDescriptionType }

function TXMLDescriptionType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLDescriptionType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLDescriptionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLDescriptionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLSourceType }

function TXMLSourceType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLSourceType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLSourceType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSourceType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnTargetType }

function TXMLNrnTargetType.Get_DataType: UnicodeString;
begin
  Result := AttributeNodes['dataType'].Text;
end;

procedure TXMLNrnTargetType.Set_DataType(Value: UnicodeString);
begin
  SetAttribute('dataType', Value);
end;

function TXMLNrnTargetType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnTargetType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

end.