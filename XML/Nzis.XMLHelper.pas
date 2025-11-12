unit Nzis.XMLHelper; //oldPreg

interface
uses
  System.Classes, system.SysUtils, Aspects.Types,
  Xml.XMLIntf, Xml.XMLDoc, System.Variants,
  RealObj.RealHipp, RealNasMesto, Aspects.Functions,
  Table.NzisReqResp, Table.PatientNew, Table.PregledNew,
  Table.MDN, table.BLANKA_MED_NAPR, Table.ExamAnalysis,
  Table.HOSPITALIZATION, Table.EXAM_LKK,
  msgX001, msgX002, msgX003, msgX013, msgR001, msgR002,
  Vcl.Dialogs, HISXMLHelper;


type

TNzisXMLHelper = class(TObject)

public
  FNasMesto: TRealNasMestoAspects;
  msgColl: TNzisReqRespColl;
  constructor create;
  function FmsgX001(msg: TNzisReqRespItem): msgX001.IXMLMessageType;
  function FmsgX003(msg: TNzisReqRespItem): msgX003.IXMLMessageType;
  function FmsgX013(msg: TNzisReqRespItem): msgX013.IXMLMessageType;

  function FmsgR001(msg: TNzisReqRespItem): msgR001.IXMLMessageType;
  function FmsgR002(msg: TNzisReqRespItem): msgR002.IXMLMessageType;

  procedure FillX001InPat(msg: TNzisReqRespItem; pat: TRealPatientNewItem);
  procedure FillX001InPreg(msg: TNzisReqRespItem; preg: TRealPregledNewItem);
  procedure FillX003InPreg(msg: TNzisReqRespItem; preg: TRealPregledNewItem);
  procedure FillX013InPat(msg: TNzisReqRespItem; pat: TRealPatientNewItem);
  procedure FillX013InPreg(msg: TNzisReqRespItem; preg: TRealPregledNewItem);

  procedure FillR001InMDN(msg: TNzisReqRespItem; mdn: TRealMdnItem);
  procedure FillR002InMDN(msg: TNzisReqRespItem; mdn: TRealMdnItem);

  procedure FillR001InMN(msg: TNzisReqRespItem; mn: TRealBLANKA_MED_NAPRItem);
  procedure FillR002InMN(msg: TNzisReqRespItem; mn: TRealBLANKA_MED_NAPRItem);

  procedure FillR001InMNHosp(msg: TNzisReqRespItem; mn: TRealHOSPITALIZATIONItem);
  procedure FillR002InMNHosp(msg: TNzisReqRespItem; mn: TRealHOSPITALIZATIONItem);

  procedure FillR001InMNLkk(msg: TNzisReqRespItem; mn: TRealEXAM_LKKItem);
  procedure FillR002InMNLkk(msg: TNzisReqRespItem; mn: TRealEXAM_LKKItem);

end;

implementation
uses
  System.Math;
{ TNzisXMLHelper }

function SafeAttr(Node: IXMLNode; const AttrName: string): string;
begin
  Result := '';
  if Assigned(Node) and Node.HasAttribute(AttrName) then
    Result := VarToStrDef(Node.Attributes[AttrName], '');
end;

constructor TNzisXMLHelper.create;
begin
  inherited create;

end;

procedure TNzisXMLHelper.FillR001InMDN(msg: TNzisReqRespItem;
  mdn: TRealMdnItem);
var
  i: Integer;
  AmsgR001: msgR001.IXMLMessageType;
  type_MDN: Integer;
  anal: TRealExamAnalysisItem;
  diag: TRealDiagnosisItem;
begin
  AmsgR001 := self.FmsgR001(msg);
  if mdn.PRecord = nil then
  begin
    New(mdn.PRecord);
    mdn.PRecord.setProp := [MDN_Logical, MDN_ID];
    mdn.PRecord.Logical := [];
  end;
  type_MDN := AmsgR001.Contents.Referral.Type_.Value;
  case type_MDN of
    1: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Ostro);// Остро заболяване или състояние извън останалите типове
    2: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Hron);// Хронично заболяване, неподлежащо на диспансерно наблюдение
    3: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Izbor);//
    4: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Disp);//
    6: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Eksp);//
    7: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Prof);//
    8: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Iskane_Telk);//
    9: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Choice_Mother);//
    10: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Choice_Child);//
    11: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_PreChoice_Mother);//
    12: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_PreChoice_Child);//
    13: Include(mdn.PRecord.Logical, MED_DIAG_NAPR_Podg_Telk);//
  end;
  mdn.PRecord.ID := 0;
  mdn.PRecord.DATA := StrToDate(AmsgR001.Contents.Referral.AuthoredOn.Value, FS_Nzis);
  include(mdn.PRecord.setProp, MDN_DATA);
  for i := 0 to AmsgR001.Contents.Referral.Laboratory.Count - 1 do
  begin
    anal := TRealExamAnalysisItem.Create(nil);
    New(anal.PRecord);
    anal.PRecord.setProp := [ExamAnalysis_NZIS_CODE_CL22];
    anal.PRecord.NZIS_CODE_CL22 := AmsgR001.Contents.Referral.Laboratory.Code[i].Value;

    mdn.FExamAnals.Add(anal);
  end;
  diag := TRealDiagnosisItem.Create(nil);
  diag.MainMkb := AmsgR001.Contents.Referral.Diagnosis.Code.Value;
  mdn.FDiagnosis.Add (diag);
end;


procedure TNzisXMLHelper.FillR001InMN(msg: TNzisReqRespItem;
  mn: TRealBLANKA_MED_NAPRItem);
var
  AmsgR001: msgR001.IXMLMessageType;
  type_MDN: Integer;
begin
  AmsgR001 := self.FmsgR001(msg);
  if mn.PRecord = nil then
  begin
    New(mn.PRecord);
    mn.PRecord.setProp := [BLANKA_MED_NAPR_Logical];
    mn.PRecord.Logical := [];
  end;
  type_MDN := AmsgR001.Contents.Referral.Type_.Value;
  case type_MDN of
    1: Include(mn.PRecord.Logical, MED_NAPR_Ostro);// Остро заболяване или състояние извън останалите типове
    2: Include(mn.PRecord.Logical, MED_NAPR_Hron);// Хронично заболяване, неподлежащо на диспансерно наблюдение
    3: Include(mn.PRecord.Logical, MED_NAPR_Izbor);//
    4: Include(mn.PRecord.Logical, MED_NAPR_Disp);//
    6: Include(mn.PRecord.Logical, MED_NAPR_Eksp);//
    7: Include(mn.PRecord.Logical, MED_NAPR_Prof);//
    8: Include(mn.PRecord.Logical, MED_NAPR_Iskane_Telk);//
    9: Include(mn.PRecord.Logical, MED_NAPR_Choice_Mother);//
    10: Include(mn.PRecord.Logical, MED_NAPR_Choice_Child);//
    11: Include(mn.PRecord.Logical, MED_NAPR_PreChoice_Mother);//
    12: Include(mn.PRecord.Logical, MED_NAPR_PreChoice_Child);//
    13: Include(mn.PRecord.Logical, MED_NAPR_Podg_Telk);//
  end;
  mn.PRecord.ISSUE_DATE := StrToDate(AmsgR001.Contents.Referral.AuthoredOn.Value, FS_Nzis);
  include(mn.PRecord.setProp, BLANKA_MED_NAPR_ISSUE_DATE);
  mn.PRecord.REASON := AmsgR001.Contents.Referral.Consultation.Qualification[0].Value;
  include(mn.PRecord.setProp, BLANKA_MED_NAPR_REASON);
end;

procedure TNzisXMLHelper.FillR001InMNHosp(msg: TNzisReqRespItem;
  mn: TRealHOSPITALIZATIONItem);
var
  AmsgR001: msgR001.IXMLMessageType;
  type_MN: Integer;
  DIRECTED_BY: Integer;
  Adm: Integer;
begin
  AmsgR001 := self.FmsgR001(msg);
  if mn.PRecord = nil then
  begin
    New(mn.PRecord);
    mn.PRecord.setProp := [HOSPITALIZATION_Logical];
    mn.PRecord.Logical := [];
  end;

  mn.PRecord.DIRECT_DATE := StrToDate(AmsgR001.Contents.Referral.AuthoredOn.Value, FS_Nzis);
  include(mn.PRecord.setProp, HOSPITALIZATION_DIRECT_DATE);
  mn.PRecord.CLINICAL_PATH := AmsgR001.Contents.Referral.Hospitalization.ClinicalPathway.Value;
  include(mn.PRecord.setProp, HOSPITALIZATION_CLINICAL_PATH);
  mn.PRecord.AMB_PROCEDURE := AmsgR001.Contents.Referral.Hospitalization.OutpatientProcedure.Value;
  include(mn.PRecord.setProp, HOSPITALIZATION_AMB_PROCEDURE);

  DIRECTED_BY := AmsgR001.Contents.Referral.Hospitalization.DirectedBy.Value;
  case DIRECTED_BY of
    1: Include( mn.PRecord.Logical, DIRECTED_BY_OPL);
    2: Include( mn.PRecord.Logical, DIRECTED_BY_SIMP);
    3: Include( mn.PRecord.Logical, DIRECTED_BY_HOSP);
    4: Include( mn.PRecord.Logical, DIRECTED_BY_EMERG);
  end;
  Adm := AmsgR001.Contents.Referral.Hospitalization.AdmissionType.Value;
  case adm of
    1: Include( mn.PRecord.Logical, IS_PLANNED);
    2: Include( mn.PRecord.Logical, IS_URGENT);
  end;
end;

procedure TNzisXMLHelper.FillR001InMNLkk(msg: TNzisReqRespItem;
  mn: TRealEXAM_LKKItem);
var
  AmsgR001: msgR001.IXMLMessageType;
  type_MN: Integer;
  i: Integer;
begin
  AmsgR001 := self.FmsgR001(msg);
  if mn.PRecord = nil then
  begin
    New(mn.PRecord);
    mn.PRecord.setProp := [EXAM_LKK_Logical];
    mn.PRecord.Logical := [];
  end;

  mn.PRecord.DATA := StrToDate(AmsgR001.Contents.Referral.AuthoredOn.Value, FS_Nzis);
  include(mn.PRecord.setProp, EXAM_LKK_DATA);
  type_MN := AmsgR001.Contents.Referral.MedicalExpertise.ExamType[0].Value;
  case type_MN of
    1: Include(mn.PRecord.Logical, LKK_TYPE_PodgLkk);
    2: Include(mn.PRecord.Logical, LKK_TYPE_Lkk);
    3: Include(mn.PRecord.Logical, LKK_TYPE_IskLkk);
    4: Include(mn.PRecord.Logical, LKK_TYPE_Telk);
  end;
  for i := 0 to AmsgR001.Contents.Referral.MedicalExpertise.Qualification.Count - 1 do
  begin
    case i of
      0:
      begin
        mn.PRecord.Spec1Pos := StrToInt(AmsgR001.Contents.Referral.MedicalExpertise.Qualification[i].Value);
        include(mn.PRecord.setProp, EXAM_LKK_Spec1Pos);
      end;
      1:
      begin
        mn.PRecord.Spec2Pos := StrToInt(AmsgR001.Contents.Referral.MedicalExpertise.Qualification[i].Value);
        include(mn.PRecord.setProp, EXAM_LKK_Spec2Pos);
      end;
      2:
      begin
        mn.PRecord.Spec3Pos := StrToInt(AmsgR001.Contents.Referral.MedicalExpertise.Qualification[i].Value);
        include(mn.PRecord.setProp, EXAM_LKK_Spec3Pos);
      end;
      3:
      begin
        mn.PRecord.Spec4Pos := StrToInt(AmsgR001.Contents.Referral.MedicalExpertise.Qualification[i].Value);
        include(mn.PRecord.setProp, EXAM_LKK_Spec4Pos);
      end;
      4:
      begin
        mn.PRecord.Spec5Pos := StrToInt(AmsgR001.Contents.Referral.MedicalExpertise.Qualification[i].Value);
        include(mn.PRecord.setProp, EXAM_LKK_Spec5Pos);
      end;
    end;
  end;
end;

procedure TNzisXMLHelper.FillR002InMDN(msg: TNzisReqRespItem;
  mdn: TRealMdnItem);
var
  AmsgR002: msgR002.IXMLMessageType;
begin
  AmsgR002 := self.FmsgR002(msg);
  if mdn.PRecord = nil then
  begin
    New(mdn.PRecord);
    mdn.PRecord.setProp := [MDN_Logical];
    mdn.PRecord.Logical := [];
  end;

  mdn.PRecord.NRN := AmsgR002.Contents.NrnReferral.Value;
  include(mdn.PRecord.setProp, MDN_NRN);
end;

procedure TNzisXMLHelper.FillR002InMN(msg: TNzisReqRespItem;
  mn: TRealBLANKA_MED_NAPRItem);
var
  AmsgR002: msgR002.IXMLMessageType;
begin
  AmsgR002 := self.FmsgR002(msg);
  if mn.PRecord = nil then
  begin
    New(mn.PRecord);
    mn.PRecord.setProp := [BLANKA_MED_NAPR_Logical];
    mn.PRecord.Logical := [];
  end;

  mn.PRecord.NRN := AmsgR002.Contents.NrnReferral.Value;
  include(mn.PRecord.setProp, BLANKA_MED_NAPR_NRN);
end;

procedure TNzisXMLHelper.FillR002InMNHosp(msg: TNzisReqRespItem;
  mn: TRealHOSPITALIZATIONItem);
var
  AmsgR002: msgR002.IXMLMessageType;
begin
  AmsgR002 := self.FmsgR002(msg);
  if mn.PRecord = nil then
  begin
    New(mn.PRecord);
    mn.PRecord.setProp := [HOSPITALIZATION_Logical];
    mn.PRecord.Logical := [];
  end;

  mn.PRecord.NRN := AmsgR002.Contents.NrnReferral.Value;
  include(mn.PRecord.setProp, HOSPITALIZATION_NRN);
end;

procedure TNzisXMLHelper.FillR002InMNLkk(msg: TNzisReqRespItem;
  mn: TRealEXAM_LKKItem);
var
  AmsgR002: msgR002.IXMLMessageType;
begin
  AmsgR002 := self.FmsgR002(msg);
  if mn.PRecord = nil then
  begin
    New(mn.PRecord);
    mn.PRecord.setProp := [EXAM_LKK_NRN];
    mn.PRecord.Logical := [];
  end;

  mn.PRecord.NRN := AmsgR002.Contents.NrnReferral.Value;
  include(mn.PRecord.setProp, EXAM_LKK_NRN);
end;

procedure TNzisXMLHelper.FillX001InPat(msg: TNzisReqRespItem;
  pat: TRealPatientNewItem);
var
  AmsgX001: msgX001.IXMLMessageType;
  brdDateStr: string;
  PidType: Byte;
  ekatte: string;
  nsM: string;
  nasMest: TRealNasMestoItem;
begin
  AmsgX001 := self.FmsgX001(msg);
  if pat.PRecord = nil then
  begin
    New(pat.PRecord);
    pat.PRecord.Logical := [];
  end;


  pat.PRecord.EGN := AmsgX001.Contents.Subject.Identifier.Value;
  pat.PRecord.FNAME := AmsgX001.Contents.Subject.Name.Given.Value;
  pat.PRecord.SNAME := AmsgX001.Contents.Subject.Name.Middle.Value;
  pat.PRecord.LNAME := AmsgX001.Contents.Subject.Name.Family.Value;
  brdDateStr := AmsgX001.Contents.Subject.BirthDate.Value;
  pat.PRecord.BIRTH_DATE := ASPStrToDate(brdDateStr);
  PidType := StrToInt(AmsgX001.Contents.Subject.IdentifierType.Value);
  case PidType of
    1: Include(pat.PRecord.Logical, PID_TYPE_E);
    2: Include(pat.PRecord.Logical, PID_TYPE_L);
    3: Include(pat.PRecord.Logical, PID_TYPE_S);
    5: Include(pat.PRecord.Logical, PID_TYPE_F);
    6: Include(pat.PRecord.Logical, PID_TYPE_B);
  end;
  ekatte := SafeAttr(AmsgX001.Contents.Subject.Address.Ekatte as IXMLNode, 'value');
  nsM := SafeAttr(AmsgX001.Contents.Subject.Address.City as IXMLNode, 'value');
  pat.FAdresi[0].Ekatte := ekatte;

  nasMest := FNasMesto.FindNasMestFromEkatte(ekatte);
  if nasMest <> nil then
  begin
    pat.FAdresi[0].FObl := nasMest.FObl;
    pat.FAdresi[0].FObsht := nasMest.FObsh;
    pat.FAdresi[0].RZOKR := nasMest.RzokR;
    pat.FAdresi[0].NasMesto := nasMest.NasMestoName;
    pat.FAdresi[0].LinkNasMesto := nasMest.DataPos;
  end
  else
  begin
    nasMest := FNasMesto.FindNasMestFromNasMesto(nsM);
  end;

end;

procedure TNzisXMLHelper.FillX001InPreg(msg: TNzisReqRespItem;
  preg: TRealPregledNewItem);
var
  AmsgX001: msgX001.IXMLMessageType;
  StartDateStr: string;
  PidType: Byte;
  ekatte: string;
  nsM: string;
  nasMest: TRealNasMestoItem;
  startDateTime: TDateTime;
  lrn: string;
begin
  AmsgX001 := self.FmsgX001(msg);
  if preg.PRecord = nil then
  begin
    New(preg.PRecord);
    preg.PRecord.setProp := [PregledNew_Logical];
    preg.PRecord.Logical := [IS_AMB_PR];
  end;


  preg.FDoctor := msgColl.CollDoctor.FindDoctorFromUinSpec(AmsgX001.Contents.Performer.Pmi.Value);
  if preg.FDoctor = nil then
  begin
    preg.FDoctor := TRealDoctorItem(msgColl.CollDoctor.Add);
    New(preg.FDoctor.PRecord);
    preg.FDoctor.PRecord.setProp := [];
    preg.FDoctor.PRecord.UIN := AmsgX001.Contents.Performer.Pmi.Value;
  end;

  lrn := AmsgX001.Contents.Examination.Lrn.Value.Split(['-'])[2];
  StartDateStr := AmsgX001.Contents.Examination.OpenDate.Value;
  startDateTime := ASPStrToDateTime(StartDateStr);
  preg.PRecord.START_DATE := Floor(startDateTime);
  Include(preg.PRecord.setProp, PregledNew_START_DATE);

  preg.PRecord.AMB_LISTN := StrToInt(lrn);
  Include(preg.PRecord.setProp, PregledNew_AMB_LISTN);
  preg.PRecord.START_TIME := startDateTime - preg.PRecord.START_DATE;
  Include(preg.PRecord.setProp, PregledNew_START_TIME);

end;

procedure TNzisXMLHelper.FillX003InPreg(msg: TNzisReqRespItem;
  preg: TRealPregledNewItem);
var
  AmsgX003: msgX003.IXMLMessageType;
  diag: TRealDiagnosisItem;
  performer: TRealDoctorItem;
  i: Integer;
  isSeq: Boolean;
  Purpose: Integer;


begin
  AmsgX003 := self.FmsgX003(msg);
  if preg.PRecord = nil then
  begin
    New(preg.PRecord);
    preg.PRecord.setProp := [PregledNew_Logical];
    preg.PRecord.Logical := [IS_AMB_PR];
  end;
  Purpose := AmsgX003.Contents.Examination.Purpose.Value;
  case Purpose of
    1: Include(preg.PRecord.Logical, IS_CONSULTATION);
    2: Include(preg.PRecord.Logical, IS_PREVENTIVE);
    3: Include(preg.PRecord.Logical, IS_PREVENTIVE_Childrens);
    4: Include(preg.PRecord.Logical, IS_PREVENTIVE_Maternal);
    5: Include(preg.PRecord.Logical, IS_PREVENTIVE_Adults);
    6: Include(preg.PRecord.Logical, IS_RISK_GROUP);
    7: Include(preg.PRecord.Logical, IS_DISPANSERY);
    8: Include(preg.PRecord.Logical, IS_VSD);
    9: Include(preg.PRecord.Logical, IS_RECEPTA_HOSPIT);
    10: Include(preg.PRecord.Logical, IS_EXPERTIZA);
    11: Include(preg.PRecord.Logical, IS_TELK);
    12: Include(preg.PRecord.Logical, IS_Screening);
  end;


  preg.PRecord.ANAMN := AmsgX003.Contents.Examination.MedicalHistory.Value;
  Include(preg.PRecord.setProp, PregledNew_ANAMN);
  preg.PRecord.NRN_LRN := AmsgX003.Contents.Examination.NrnExamination.Value;
  Include(preg.PRecord.setProp, PregledNew_NRN_LRN);
  preg.PRecord.IZSL := SafeAttr(AmsgX003.Contents.Examination.Assessment.Note as IXMLNode, 'value');
  Include(preg.PRecord.setProp, PregledNew_IZSL);
  preg.PRecord.SYST := AmsgX003.Contents.Examination.ObjectiveCondition.Value;
  Include(preg.PRecord.setProp, PregledNew_SYST);
  preg.PRecord.TERAPY := SafeAttr(AmsgX003.Contents.Examination.Therapy.Note as IXMLNode, 'value');
  Include(preg.PRecord.setProp, PregledNew_TERAPY);

  diag := TRealDiagnosisItem.Create(msgColl.collDiag);
  diag.Rank := AmsgX003.Contents.Examination.Diagnosis.Rank.Value - 1;
  preg.FDiagnosis.Add(diag);
  diag.MainMkb := SafeAttr(AmsgX003.Contents.Examination.Diagnosis.Code as IXMLNode, 'value');
  diag.AddMkb := SafeAttr(AmsgX003.Contents.Examination.Diagnosis.AdditionalCode as IXMLNode, 'value');

  for i := 0 to AmsgX003.Contents.Examination.Comorbidity.Count - 1 do
  begin
    diag := TRealDiagnosisItem.Create(msgColl.collDiag);
    preg.FDiagnosis.Add(diag);
    diag.Rank := AmsgX003.Contents.Examination.Diagnosis.Rank.Value - 1;
    diag.MainMkb := SafeAttr(AmsgX003.Contents.Examination.Comorbidity[i].Code as IXMLNode, 'value');
    diag.AddMkb := SafeAttr(AmsgX003.Contents.Examination.Comorbidity[i].AdditionalCode as IXMLNode, 'value');
  end;
  preg.PRecord.COPIED_FROM_NRN := preg.COPIED_FROM_NRN;
  Include(preg.PRecord.setProp, PregledNew_COPIED_FROM_NRN);
  isSeq := AmsgX003.Contents.Examination.IsSecondary.Value = 'true';
  if not isSeq then
    Include(preg.PRecord.Logical, IS_PRIMARY);
end;

procedure TNzisXMLHelper.FillX013InPat(msg: TNzisReqRespItem;
  pat: TRealPatientNewItem);
var
  AmsgX013: msgX013.IXMLMessageType;
  brdDateStr: string;
  PidType: Byte;
  ekatte: string;
  nsM: string;
  nasMest: TRealNasMestoItem;
begin
  AmsgX013 := self.FmsgX013(msg);
  if pat.PRecord = nil then
  begin
    New(pat.PRecord);
    pat.PRecord.Logical := [];
  end;


  pat.PRecord.EGN := AmsgX013.Contents.Subject.Identifier.Value;
  pat.PRecord.FNAME := AmsgX013.Contents.Subject.Name.Given.Value;
  pat.PRecord.SNAME := AmsgX013.Contents.Subject.Name.Middle.Value;
  pat.PRecord.LNAME := AmsgX013.Contents.Subject.Name.Family.Value;
  brdDateStr := AmsgX013.Contents.Subject.BirthDate.Value;
  pat.PRecord.BIRTH_DATE := ASPStrToDate(brdDateStr);
  PidType := StrToInt(AmsgX013.Contents.Subject.IdentifierType.Value);
  case PidType of
    1: Include(pat.PRecord.Logical, PID_TYPE_E);
    2: Include(pat.PRecord.Logical, PID_TYPE_L);
    3: Include(pat.PRecord.Logical, PID_TYPE_S);
    5: Include(pat.PRecord.Logical, PID_TYPE_F);
    6: Include(pat.PRecord.Logical, PID_TYPE_B);
  end;
  ekatte := SafeAttr(AmsgX013.Contents.Subject.Address.Ekatte as IXMLNode, 'value');
  nsM := SafeAttr(AmsgX013.Contents.Subject.Address.City as IXMLNode, 'value');
  pat.FAdresi[0].Ekatte := ekatte;

  nasMest := FNasMesto.FindNasMestFromEkatte(ekatte);
  if nasMest <> nil then
  begin
    pat.FAdresi[0].FObl := nasMest.FObl;
    pat.FAdresi[0].FObsht := nasMest.FObsh;
    pat.FAdresi[0].RZOKR := nasMest.RzokR;
    pat.FAdresi[0].NasMesto := nasMest.NasMestoName;
    pat.FAdresi[0].LinkNasMesto := nasMest.DataPos;
  end
  else
  begin
    nasMest := FNasMesto.FindNasMestFromNasMesto(nsM);
  end;
end;

procedure TNzisXMLHelper.FillX013InPreg(msg: TNzisReqRespItem;
  preg: TRealPregledNewItem);
var
  AmsgX013: msgX013.IXMLMessageType;
  StartDateStr: string;
  PidType: Byte;
  ekatte: string;
  nsM: string;
  nasMest: TRealNasMestoItem;
  startDateTime: TDateTime;
  diag: TRealDiagnosisItem;
  i: Integer;
  isSeq: Boolean;
  Purpose: Integer;
begin
  AmsgX013 := self.FmsgX013(msg);
  if preg.PRecord = nil then
  begin
    New(preg.PRecord);
    preg.PRecord.setProp := [PregledNew_Logical];
    preg.PRecord.Logical := [IS_AMB_PR];
  end;
  preg.FDoctor := msgColl.CollDoctor.FindDoctorFromUinSpec(AmsgX013.Contents.Performer.Pmi.Value);
  if preg.FDoctor = nil then
  begin
    preg.FDoctor := TRealDoctorItem(msgColl.CollDoctor.Add);
    New(preg.FDoctor.PRecord);
    preg.FDoctor.PRecord.setProp := [];
    preg.FDoctor.PRecord.UIN := AmsgX013.Contents.Performer.Pmi.Value;
  end;

  Purpose := AmsgX013.Contents.Examination.Purpose.Value;
  case Purpose of
    1: Include(preg.PRecord.Logical, IS_CONSULTATION);
    2: Include(preg.PRecord.Logical, IS_PREVENTIVE);
    3: Include(preg.PRecord.Logical, IS_PREVENTIVE_Childrens);
    4: Include(preg.PRecord.Logical, IS_PREVENTIVE_Maternal);
    5: Include(preg.PRecord.Logical, IS_PREVENTIVE_Adults);
    6: Include(preg.PRecord.Logical, IS_RISK_GROUP);
    7: Include(preg.PRecord.Logical, IS_DISPANSERY);
    8: Include(preg.PRecord.Logical, IS_VSD);
    9: Include(preg.PRecord.Logical, IS_RECEPTA_HOSPIT);
    10: Include(preg.PRecord.Logical, IS_EXPERTIZA);
    11: Include(preg.PRecord.Logical, IS_TELK);
    12: Include(preg.PRecord.Logical, IS_Screening);
  end;

  StartDateStr := AmsgX013.Contents.Examination.OpenDate.Value;

  startDateTime := ASPStrToDateTime(StartDateStr);
  preg.PRecord.START_DATE := Floor(startDateTime);
  Include(preg.PRecord.setProp, PregledNew_START_DATE);
  preg.PRecord.START_TIME := startDateTime - preg.PRecord.START_DATE;
  Include(preg.PRecord.setProp, PregledNew_START_TIME);

  preg.PRecord.ANAMN := AmsgX013.Contents.Examination.MedicalHistory.Value;
  Include(preg.PRecord.setProp, PregledNew_ANAMN);
  preg.PRecord.NRN_LRN := preg.NRN;
  Include(preg.PRecord.setProp, PregledNew_NRN_LRN);
  preg.PRecord.IZSL := SafeAttr(AmsgX013.Contents.Examination.Assessment.Note as IXMLNode, 'value');
  Include(preg.PRecord.setProp, PregledNew_IZSL);
  preg.PRecord.SYST := AmsgX013.Contents.Examination.ObjectiveCondition.Value;
  Include(preg.PRecord.setProp, PregledNew_SYST);
  preg.PRecord.TERAPY := SafeAttr(AmsgX013.Contents.Examination.Therapy.Note as IXMLNode, 'value');
  Include(preg.PRecord.setProp, PregledNew_TERAPY);


  diag := TRealDiagnosisItem.Create(msgColl.collDiag);
  diag.Rank := AmsgX013.Contents.Examination.Diagnosis.Rank.Value - 1;
  preg.FDiagnosis.Add(diag);
  diag.MainMkb := SafeAttr(AmsgX013.Contents.Examination.Diagnosis.Code as IXMLNode, 'value');
  diag.AddMkb := SafeAttr(AmsgX013.Contents.Examination.Diagnosis.AdditionalCode as IXMLNode, 'value');

  for i := 0 to AmsgX013.Contents.Examination.Comorbidity.Count - 1 do
  begin
    diag := TRealDiagnosisItem.Create(msgColl.collDiag);
    diag.Rank := AmsgX013.Contents.Examination.Diagnosis.Rank.Value - 1;
    preg.FDiagnosis.Add(diag);
    diag.MainMkb := SafeAttr(AmsgX013.Contents.Examination.Comorbidity[i].Code as IXMLNode, 'value');
    diag.AddMkb := SafeAttr(AmsgX013.Contents.Examination.Comorbidity[i].AdditionalCode as IXMLNode, 'value');
  end;

  preg.PRecord.COPIED_FROM_NRN := preg.COPIED_FROM_NRN;
  Include(preg.PRecord.setProp, PregledNew_COPIED_FROM_NRN);
  isSeq := AmsgX013.Contents.Examination.IsSecondary.Value = 'true';
  if not isSeq then
  begin
    Include(preg.PRecord.Logical, IS_PRIMARY);

  end;
end;

function TNzisXMLHelper.FmsgR001(
  msg: TNzisReqRespItem): msgR001.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
  try
    oXml.LoadFromStream(StringStream);

  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  result := msgR001.Getmessage(oXml);
end;

function TNzisXMLHelper.FmsgR002(
  msg: TNzisReqRespItem): msgR002.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(msg.PRecord.RESP, TEncoding.UTF8);
  try
    oXml.LoadFromStream(StringStream);

  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  result := msgR002.Getmessage(oXml);
end;

function TNzisXMLHelper.FmsgX001(msg: TNzisReqRespItem): msgX001.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
  try
    oXml.LoadFromStream(StringStream);

  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  result := msgX001.Getmessage(oXml);
  //if oXml.Active then
//  begin
//    oXml.ChildNodes.Clear;
//    oXml.Active := False;
//  end;
//  oxml := nil;
end;

function TNzisXMLHelper.FmsgX003(
  msg: TNzisReqRespItem): msgX003.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(string(msg.PRecord.REQ), TEncoding.UTF8);
  StringStream.Position := 0;
  try
    oXml.LoadFromStream(StringStream);


  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  //ShowMessage(oXml.DocumentElement.NodeName + ' | ' + oXml.DocumentElement.NamespaceURI);
  result := msgX003.Getmessage(oXml);
  //if oXml.Active then
//  begin
//    oXml.ChildNodes.Clear;
//    oXml.Active := False;
//  end;
//  oxml := nil;
end;

function TNzisXMLHelper.FmsgX013(
  msg: TNzisReqRespItem): msgX013.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
  try
    oXml.LoadFromStream(StringStream);

  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  result := msgX013.Getmessage(oXml);
  //if oXml.Active then
//  begin
//    oXml.ChildNodes.Clear;
//    oXml.Active := False;
//  end;
//  oxml := nil;
end;

end.
