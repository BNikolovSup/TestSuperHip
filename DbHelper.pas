unit DbHelper; //PREVENTIVE_TYPE

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, IBX.IBSQL,VirtualStringTreeAspect,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections, DM, Winapi.ActiveX, system.Variants, VirtualTrees,
  Aspects.Types, ProfGraph,
  Table.PatientNew, Table.Doctor, Table.Mkb, table.mdn,
  Table.PregledNew, Table.Unfav, Table.EventsManyTimes, Table.Exam_boln_list,
  RealObj.NzisNomen,
  RealObj.RealHipp, Aspects.Collections, Table.Diagnosis, Table.ExamAnalysis,
  table.ExamImmunization, Table.CL132, Table.CL022, Table.KARTA_PROFILAKTIKA2017,
  table.BLANKA_MED_NAPR;

  type
  TDbHelper = class (TObject)
  public
    CollPreg: TRealPregledNewColl;
    CollEbl: TRealExam_boln_listColl;
    CollDiag: TRealDiagnosisColl;
    collCl022: TCL022Coll;
    AdbHip: TMappedFile;
    AdbNomenNzis: TMappedFile;
    AdbLink: TMappedFile;
    cmdFile: TFileStream;
    Vtr: TVirtualStringTreeAspect;

    procedure InsertPregledField(ibsql: TIBSQL; TempItem: TRealPregledNewItem);
    procedure UpdatePregledField(ibsql: TIBSQL; TempItem: TRealPregledNewItem);
    procedure InsertExamAnalField(ibsql: TIBSQL; TempItem: TRealExamAnalysisItem);
    procedure UpdateExamAnalField(ibsql: TIBSQL; TempItem: TRealExamAnalysisItem);
    procedure InsertExamImunField(ibsql: TIBSQL; TempItem: TRealExamImmunizationItem);
    procedure UpdateExamImunField(ibsql: TIBSQL; TempItem: TRealExamImmunizationItem);
    procedure InsertKardProfField(ibsql: TIBSQL; TempItem: TRealKARTA_PROFILAKTIKA2017Item);
    procedure InsertMedNaprField(ibsql: TIBSQL; TempItem: TRealBLANKA_MED_NAPRItem);



    procedure InsertEBLField(ibsql: TIBSQL; TempItem: TRealExam_boln_listItem);
    procedure FindDiagInPregled(vPregled: PVirtualNode; var diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem);
    procedure UpdateDiagInPreg(diag: TRealDiagnosisItem; TempItem: TRealPregledNewItem; rank: word);

    //ADB
    procedure InsertAdbPregledField(TempItem: TRealPregledNewItem);
    procedure InsertAdbMdnField(TempItem: TRealMDNItem);
    procedure InsertAdbMnField(TempItem: TRealBLANKA_MED_NAPRItem);

    //saveToHip
    procedure SavePregledFDB(preg: TRealPregledNewItem; ibsql: TIBSQL);
    procedure SaveMdn(mdn: TRealMdnItem; ibsql: TIBSQL);
    procedure SaveExamAnals(ExamAnal: TRealExamAnalysisItem; ibsql: TIBSQL);

end;



implementation

procedure TDbHelper.FindDiagInPregled(vPregled: PVirtualNode; var diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem);
var
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TDiagnosisItem;
  buf: Pointer;
  datPos: Cardinal;
begin
  buf := Self.AdbHip.Buf;

  datpos := Self.AdbHip.FPosData;

  diagNode := vPregled.FirstChild;
  while diagNode <> nil do
  begin
    data := pointer(PByte(diagNode) + lenNode);
    case data.vid of
      vvDiag:
      begin
        diag := TRealDiagnosisItem.Create(CollDiag);
        diag.DataPos := data.DataPos;
        case diag.getWordMap(buf, datPos, word(Diagnosis_rank)) of
          0: //  основна диагноза
          begin
            diag0 := TRealDiagnosisItem.Create(CollDiag);
            diag0.Node := diagNode;
            diag0.DataPos := data.DataPos;
            diag0.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag0.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag0.Rank := 0;
          end;
          1: // първа придружаваща
          begin
            diag1 := TRealDiagnosisItem.Create(CollDiag);
            diag1.Node := diagNode;
            diag1.DataPos := data.DataPos;
            diag1.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag1.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag1.Rank := 1;
          end;
          2: // втора придружаваща
          begin
            diag2 := TRealDiagnosisItem.Create(CollDiag);
            diag2.Node := diagNode;
            diag2.DataPos := data.DataPos;
            diag2.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag2.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag2.Rank := 2;
          end;
          3: // трета придружаваща
          begin
            diag3 := TRealDiagnosisItem.Create(CollDiag);
            diag3.DataPos := data.DataPos;
            diag3.Node := diagNode;
            diag3.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag3.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag3.Rank := 3;
          end;
          4: // четвърта придружаваща
          begin
            diag4 := TRealDiagnosisItem.Create(CollDiag);
            diag4.Node := diagNode;
            diag4.DataPos := data.DataPos;
            diag4.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag4.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag4.Rank := 4;
          end;
        end;
      end;
    end;
    diagNode := diagNode.NextSibling;
  end;
end;

procedure TDbHelper.InsertAdbMdnField(TempItem: TRealMDNItem);
begin
  TempItem.PRecord.DATA := Date;
  Include(TempItem.PRecord.setProp, MDN_DATA);
  TempItem.PRecord.id := 0;
  Include(TempItem.PRecord.setProp, MDN_ID);
end;

procedure TDbHelper.InsertAdbMnField(TempItem: TRealBLANKA_MED_NAPRItem);
begin
  TempItem.PRecord.ISSUE_DATE := Date;
  Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_ISSUE_DATE);
  TempItem.PRecord.id := 0;
  Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_ID);
end;

procedure TDbHelper.InsertAdbPregledField(TempItem: TRealPregledNewItem);
var
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
  gr: TGraphPeriod132;
  LrnGuId: TGUID;
  LRN: string;
begin
  Include(TempItem.PRecord.setProp, PregledNew_Logical);
  TempItem.PRecord.Logical := [];

  gr := TempItem.Fpatient.lstGraph[TempItem.Fpatient.CurrentGraphIndex];
  case gr.Cl132.getAnsiStringMap(AdbNomenNzis.Buf, AdbNomenNzis.FPosData, word(CL132_CL047_Mapping))[1] of
    '3': //Детско здраве
    begin
      Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Childrens);
    end;
    '4':// Майчино здраве
    begin
      Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Maternal);
    end;
    '5':// Профилактика нa пълнолетни лица
    begin
      if true then  // zzzzzzzzzzzzzzz ако не е рисков пациент
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Adults);
      end
      else
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_RISK_GROUP);
      end;
    end;
  end;
  TempItem.PRecord.ID := 0;
  Include(TempItem.PRecord.setProp, PregledNew_ID);

  TempItem.PRecord.START_DATE := TempItem.StartDate;
  Include(TempItem.PRecord.setProp, PregledNew_START_DATE);

  TempItem.PRecord.AMB_LISTN := 0;
  Include(TempItem.PRecord.setProp, PregledNew_AMB_LISTN);
  // 12 интервала, за запазване на място НРН  и 36 GUID за ЛРН
  CreateGUID(LrnGuId);
  LRN := LrnGuId.ToString;
  LRN := Copy(LRN, 2, 36);
  TempItem.PRecord.NRN_LRN := '            ' + LRN;
  Include(TempItem.PRecord.setProp, PregledNew_NRN);

  TempItem.PRecord.NZIS_STATUS := 0;
  Include(TempItem.PRecord.setProp, PregledNew_NZIS_STATUS);

end;

procedure TDbHelper.InsertEBLField(ibsql: TIBSQL; TempItem: TRealExam_boln_listItem);
  var
    ibsqlExam_boln_list: TIBSQL;
    datPos: Cardinal;
  begin
    ibsqlExam_boln_list := ibsql;
    if not ibsqlExam_boln_list.Fields[0].IsNull then
    begin
       TempItem.PRecord.AMB_JOURNAL_NUMBER := ibsqlExam_boln_list.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_AMB_JOURNAL_NUMBER);
    end;
    if not ibsqlExam_boln_list.Fields[1].IsNull then
    begin
      TempItem.PRecord.ASSISTED_PERSON_NAME := ibsqlExam_boln_list.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_ASSISTED_PERSON_NAME);
    end;
    if not ibsqlExam_boln_list.Fields[2].IsNull then
    begin
      TempItem.PRecord.ASSISTED_PERSON_PID := ibsqlExam_boln_list.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_ASSISTED_PERSON_PID);
    end;
    if not ibsqlExam_boln_list.Fields[3].IsNull then
    begin
       TempItem.PRecord.CUSTOMIZE := ibsqlExam_boln_list.Fields[3].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_CUSTOMIZE);
    end;
    if not ibsqlExam_boln_list.Fields[4].IsNull then
    begin
      TempItem.PRecord.DATA := ibsqlExam_boln_list.Fields[4].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DATA);
    end;
    if not ibsqlExam_boln_list.Fields[5].IsNull then
    begin
      TempItem.PRecord.DATEOFBIRTH := ibsqlExam_boln_list.Fields[5].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DATEOFBIRTH);
    end;
    if not ibsqlExam_boln_list.Fields[6].IsNull then
    begin
      TempItem.PRecord.DAYS_FREE := ibsqlExam_boln_list.Fields[6].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DAYS_FREE);
    end;
    if not ibsqlExam_boln_list.Fields[7].IsNull then
    begin
      TempItem.PRecord.DAYS_HOME := ibsqlExam_boln_list.Fields[7].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DAYS_HOME);
    end;
    if not ibsqlExam_boln_list.Fields[8].IsNull then
    begin
      TempItem.PRecord.DAYS_HOSPITAL := ibsqlExam_boln_list.Fields[8].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DAYS_HOSPITAL);
    end;
    if not ibsqlExam_boln_list.Fields[9].IsNull then
    begin
      TempItem.PRecord.DAYS_IN_WORDS := ibsqlExam_boln_list.Fields[9].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DAYS_IN_WORDS);
    end;
    if not ibsqlExam_boln_list.Fields[10].IsNull then
    begin
      TempItem.PRecord.DAYS_SANATORIUM := ibsqlExam_boln_list.Fields[10].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_DAYS_SANATORIUM);
    end;
    if not ibsqlExam_boln_list.Fields[11].IsNull then
    begin
      TempItem.PRecord.EL_NUMBER := ibsqlExam_boln_list.Fields[11].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_EL_NUMBER);
    end;
    if not ibsqlExam_boln_list.Fields[12].IsNull then
    begin
      TempItem.PRecord.FORM_LETTER := ibsqlExam_boln_list.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_FORM_LETTER);
    end;
    if not ibsqlExam_boln_list.Fields[13].IsNull then
    begin
       TempItem.PRecord.FORM_NUMBER := ibsqlExam_boln_list.Fields[13].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_FORM_NUMBER);
    end;
    if not ibsqlExam_boln_list.Fields[14].IsNull then
    begin
      TempItem.PRecord.IAVIAVANE_PREGLED_DATE := ibsqlExam_boln_list.Fields[14].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_IAVIAVANE_PREGLED_DATE);
    end;
    if not ibsqlExam_boln_list.Fields[15].IsNull then
    begin
       TempItem.PRecord.ID := ibsqlExam_boln_list.Fields[15].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_ID);
    end;
    if not ibsqlExam_boln_list.Fields[16].IsNull then
    begin
      TempItem.PRecord.IST_ZABOL_NO := ibsqlExam_boln_list.Fields[16].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_IST_ZABOL_NO);
    end;
    if not ibsqlExam_boln_list.Fields[17].IsNull then
    begin
      TempItem.PRecord.IZDADEN_OT := ibsqlExam_boln_list.Fields[17].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_IZDADEN_OT);
    end;
    if not ibsqlExam_boln_list.Fields[18].IsNull then
    begin
       TempItem.PRecord.LAK_NUMBER := ibsqlExam_boln_list.Fields[18].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_LAK_NUMBER);
    end;
    if not ibsqlExam_boln_list.Fields[19].IsNull then
    begin
      TempItem.PRecord.LKK_TYPE := ibsqlExam_boln_list.Fields[19].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_LKK_TYPE);
    end;
    if not ibsqlExam_boln_list.Fields[20].IsNull then
    begin
      TempItem.PRecord.NERABOTOSP_ID := ibsqlExam_boln_list.Fields[20].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_NERABOTOSP_ID);
    end;
    if not ibsqlExam_boln_list.Fields[21].IsNull then
    begin
      TempItem.PRecord.NOTES := ibsqlExam_boln_list.Fields[21].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_NOTES);
    end;
    if not ibsqlExam_boln_list.Fields[22].IsNull then
    begin
       TempItem.PRecord.NOTES_ID := ibsqlExam_boln_list.Fields[22].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_NOTES_ID);
    end;
    if not ibsqlExam_boln_list.Fields[23].IsNull then
    begin
       TempItem.PRecord.NUMBER := ibsqlExam_boln_list.Fields[23].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_NUMBER);
    end;
    if not ibsqlExam_boln_list.Fields[24].IsNull then
    begin
      TempItem.PRecord.NUMBER_ANUL := ibsqlExam_boln_list.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_NUMBER_ANUL);
    end;
    if not ibsqlExam_boln_list.Fields[25].IsNull then
    begin
       TempItem.PRecord.OTHER_PRACTICA_ID := ibsqlExam_boln_list.Fields[25].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_OTHER_PRACTICA_ID);
    end;
    if not ibsqlExam_boln_list.Fields[26].IsNull then
    begin
      TempItem.PRecord.PATIENT_EGN := ibsqlExam_boln_list.Fields[26].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_PATIENT_EGN);
    end;
    if not ibsqlExam_boln_list.Fields[27].IsNull then
    begin
      TempItem.PRecord.PATIENT_LNCH := ibsqlExam_boln_list.Fields[27].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_PATIENT_LNCH);
    end;
    if not ibsqlExam_boln_list.Fields[28].IsNull then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlExam_boln_list.Fields[28].AsInteger;
       Include(TempItem.PRecord.setProp, Exam_boln_list_PREGLED_ID);
    end;
    if not ibsqlExam_boln_list.Fields[29].IsNull then
    begin
      TempItem.PRecord.REALATIONSHIP := ibsqlExam_boln_list.Fields[29].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_REALATIONSHIP);
    end;
    if not ibsqlExam_boln_list.Fields[30].IsNull then
    begin
      TempItem.PRecord.REL_SHIP_CODE := ibsqlExam_boln_list.Fields[30].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_REL_SHIP_CODE);
    end;
    if not ibsqlExam_boln_list.Fields[31].IsNull then
    begin
      TempItem.PRecord.RESHENIEDATE := ibsqlExam_boln_list.Fields[31].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_RESHENIEDATE);
    end;
    if not ibsqlExam_boln_list.Fields[32].IsNull then
    begin
      TempItem.PRecord.RESHENIEDATE_TELK := ibsqlExam_boln_list.Fields[32].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_RESHENIEDATE_TELK);
    end;
    if not ibsqlExam_boln_list.Fields[33].IsNull then
    begin
      TempItem.PRecord.RESHENIENO := ibsqlExam_boln_list.Fields[33].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_RESHENIENO);
    end;
    if not ibsqlExam_boln_list.Fields[34].IsNull then
    begin
      TempItem.PRecord.RESHENIENO_TELK := ibsqlExam_boln_list.Fields[34].AsString;
      Include(TempItem.PRecord.setProp, Exam_boln_list_RESHENIENO_TELK);
    end;
    if not ibsqlExam_boln_list.Fields[35].IsNull then
    begin
      TempItem.PRecord.SICK_LEAVE_END := ibsqlExam_boln_list.Fields[35].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_SICK_LEAVE_END);
    end;
    if not ibsqlExam_boln_list.Fields[36].IsNull then
    begin
      TempItem.PRecord.SICK_LEAVE_START := ibsqlExam_boln_list.Fields[36].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_SICK_LEAVE_START);
    end;
    if not ibsqlExam_boln_list.Fields[37].IsNull then
    begin
      TempItem.PRecord.TERMIN_DATE := ibsqlExam_boln_list.Fields[37].AsDate;
      Include(TempItem.PRecord.setProp, Exam_boln_list_TERMIN_DATE);
    end;
    if not ibsqlExam_boln_list.Fields[38].IsNull then
    begin
      TempItem.PRecord.TREATMENT_REGIMEN := ibsqlExam_boln_list.Fields[38].AsInteger;
      Include(TempItem.PRecord.setProp, Exam_boln_list_TREATMENT_REGIMEN);
    end;

    TempItem.PRecord.Logical := [];

  end;

  procedure TDbHelper.InsertExamAnalField(ibsql: TIBSQL; TempItem: TRealExamAnalysisItem);
var
    ibsqlExamAnalysis: TIBSQL;
    diagNode: PVirtualNode;
    data: PAspRec;
    diag: TRealDiagnosisItem;
    dataPosition: Cardinal;
  begin
    ibsqlExamAnalysis := ibsql;

    if (not ibsqlExamAnalysis.Fields[0].IsNull)
    then
    begin
      TempItem.PRecord.ANALYSIS_ID := ibsqlExamAnalysis.Fields[0].AsInteger;
      Include(TempItem.PRecord.setProp, ExamAnalysis_ANALYSIS_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[1].IsNull)
    then
    begin
       TempItem.PRecord.BLANKA_MDN_ID := ibsqlExamAnalysis.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_BLANKA_MDN_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.DATA := ibsqlExamAnalysis.Fields[2].AsDate;
      Include(TempItem.PRecord.setProp, ExamAnalysis_DATA);
    end;
    if (not ibsqlExamAnalysis.Fields[3].IsNull)
    then
    begin
       TempItem.PRecord.EMDN_ID := ibsqlExamAnalysis.Fields[3].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_EMDN_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[4].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlExamAnalysis.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[5].IsNull)
    then
    begin
      TempItem.PRecord.NZIS_CODE_CL22 := ibsqlExamAnalysis.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_NZIS_CODE_CL22);
    end;
    if (not ibsqlExamAnalysis.Fields[6].IsNull)
    then
    begin
      TempItem.PRecord.NZIS_DESCRIPTION_CL22 := ibsqlExamAnalysis.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_NZIS_DESCRIPTION_CL22);
    end;
    if (not ibsqlExamAnalysis.Fields[7].IsNull)
    then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlExamAnalysis.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_PREGLED_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[8].IsNull)
    then
    begin
      TempItem.PRecord.RESULT := ibsqlExamAnalysis.Fields[8].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_RESULT);
    end;

     TempItem.MdnId := ibsqlExamAnalysis.Fields[1].AsInteger;
     TempItem.ExamAnalID := ibsqlExamAnalysis.Fields[4].AsInteger;
     TempItem.AnalId := ibsqlExamAnalysis.Fields[0].AsInteger;
     TempItem.Cl022 := ibsqlExamAnalysis.Fields[5].AsString
  end;

procedure TDbHelper.InsertExamImunField(ibsql: TIBSQL; TempItem: TRealExamImmunizationItem);
var
    ibsqlExamImmunization: TIBSQL;
    diagNode: PVirtualNode;
    data: PAspRec;
    diag: TRealDiagnosisItem;
    dataPosition: Cardinal;
  begin
    ibsqlExamImmunization := ibsql;

    if (not ibsqlExamImmunization.Fields[0].IsNull)
    then
    begin
      TempItem.PRecord.BASE_ON := ibsqlExamImmunization.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_BASE_ON);
    end;
    if (not ibsqlExamImmunization.Fields[1].IsNull)
    then
    begin
       TempItem.PRecord.BOOSTER := ibsqlExamImmunization.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_BOOSTER);
    end;
    if (not ibsqlExamImmunization.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.CERTIFICATE_NAME := ibsqlExamImmunization.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_CERTIFICATE_NAME);
    end;
    if (not ibsqlExamImmunization.Fields[3].IsNull)
    then
    begin
      TempItem.PRecord.DATA := ibsqlExamImmunization.Fields[3].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_DATA);
    end;
    if (not ibsqlExamImmunization.Fields[4].IsNull)
    then
    begin
      TempItem.PRecord.DOCTOR_NAME := ibsqlExamImmunization.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_DOCTOR_NAME);
    end;
    if (not ibsqlExamImmunization.Fields[5].IsNull)
    then
    begin
      TempItem.PRecord.DOCTOR_UIN := ibsqlExamImmunization.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_DOCTOR_UIN);
    end;
    if (not ibsqlExamImmunization.Fields[6].IsNull)
    then
    begin
      TempItem.PRecord.DOSE := ibsqlExamImmunization.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_DOSE);
    end;
    if (not ibsqlExamImmunization.Fields[7].IsNull)
    then
    begin
       TempItem.PRecord.DOSE_NUMBER := ibsqlExamImmunization.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_DOSE_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[8].IsNull)
    then
    begin
       TempItem.PRecord.DOSE_QUANTITY := ibsqlExamImmunization.Fields[8].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_DOSE_QUANTITY);
    end;
    if (not ibsqlExamImmunization.Fields[9].IsNull)
    then
    begin
      TempItem.PRecord.EXPIRATION_DATE := ibsqlExamImmunization.Fields[9].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXPIRATION_DATE);
    end;
    if (not ibsqlExamImmunization.Fields[10].IsNull)
    then
    begin
      TempItem.PRecord.EXT_AUTHORITY := ibsqlExamImmunization.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_AUTHORITY);
    end;
    if (not ibsqlExamImmunization.Fields[11].IsNull)
    then
    begin
      TempItem.PRecord.EXT_COUNTRY := ibsqlExamImmunization.Fields[11].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_COUNTRY);
    end;
    if (not ibsqlExamImmunization.Fields[12].IsNull)
    then
    begin
      TempItem.PRecord.EXT_LOT_NUMBER := ibsqlExamImmunization.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_LOT_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[13].IsNull)
    then
    begin
      TempItem.PRecord.EXT_OCCURRENCE := ibsqlExamImmunization.Fields[13].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_OCCURRENCE);
    end;
    if (not ibsqlExamImmunization.Fields[14].IsNull)
    then
    begin
       TempItem.PRecord.EXT_PREV_IMMUNIZATION := ibsqlExamImmunization.Fields[14].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_EXT_PREV_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[15].IsNull)
    then
    begin
      TempItem.PRecord.EXT_SERIAL_NUMBER := ibsqlExamImmunization.Fields[15].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_SERIAL_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[16].IsNull)
    then
    begin
      TempItem.PRecord.EXT_VACCINE_ATC := ibsqlExamImmunization.Fields[16].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_VACCINE_ATC);
    end;
    if (not ibsqlExamImmunization.Fields[17].IsNull)
    then
    begin
      TempItem.PRecord.EXT_VACCINE_INN := ibsqlExamImmunization.Fields[17].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_VACCINE_INN);
    end;
    if (not ibsqlExamImmunization.Fields[18].IsNull)
    then
    begin
      TempItem.PRecord.EXT_VACCINE_NAME := ibsqlExamImmunization.Fields[18].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_VACCINE_NAME);
    end;
    if (not ibsqlExamImmunization.Fields[19].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlExamImmunization.Fields[19].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_ID);
    end;
    if (not ibsqlExamImmunization.Fields[20].IsNull)
    then
    begin
      TempItem.PRecord.IMMUNIZATION_ID := ibsqlExamImmunization.Fields[20].AsInteger;
      Include(TempItem.PRecord.setProp, ExamImmunization_IMMUNIZATION_ID);
    end;
    if (not ibsqlExamImmunization.Fields[21].IsNull)
    then
    begin
       TempItem.PRecord.IMMUNIZATION_STATUS := ibsqlExamImmunization.Fields[21].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_IMMUNIZATION_STATUS);
    end;
    if (not ibsqlExamImmunization.Fields[22].IsNull)
    then
    begin
       TempItem.PRecord.IS_SPECIAL_CASE := ibsqlExamImmunization.Fields[22].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_IS_SPECIAL_CASE);
    end;
    if (not ibsqlExamImmunization.Fields[23].IsNull)
    then
    begin
      TempItem.PRecord.LOT_NUMBER := ibsqlExamImmunization.Fields[23].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_LOT_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[24].IsNull)
    then
    begin
      TempItem.PRecord.LRN := ibsqlExamImmunization.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_LRN);
    end;
    if (not ibsqlExamImmunization.Fields[25].IsNull)
    then
    begin
      TempItem.PRecord.NEXT_DOSE_DATE := ibsqlExamImmunization.Fields[25].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_NEXT_DOSE_DATE);
    end;
    if (not ibsqlExamImmunization.Fields[26].IsNull)
    then
    begin
      TempItem.PRecord.NOTE := ibsqlExamImmunization.Fields[26].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_NOTE);
    end;
    if (not ibsqlExamImmunization.Fields[27].IsNull)
    then
    begin
      TempItem.PRecord.NRN_IMMUNIZATION := ibsqlExamImmunization.Fields[27].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_NRN_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[28].IsNull)
    then
    begin
      TempItem.PRecord.NRN_PREV_IMMUNIZATION := ibsqlExamImmunization.Fields[28].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_NRN_PREV_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[29].IsNull)
    then
    begin
      TempItem.PRecord.PERSON_STATUS_CHANGE_ON_DATE := ibsqlExamImmunization.Fields[29].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE);
    end;
    if (not ibsqlExamImmunization.Fields[30].IsNull)
    then
    begin
      TempItem.PRecord.PERSON_STATUS_CHANGE_REASON := ibsqlExamImmunization.Fields[30].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_PERSON_STATUS_CHANGE_REASON);
    end;
    if (not ibsqlExamImmunization.Fields[31].IsNull)
    then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlExamImmunization.Fields[31].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_PREGLED_ID);
    end;
    if (not ibsqlExamImmunization.Fields[32].IsNull)
    then
    begin
       TempItem.PRecord.PRIMARY_SOURCE := ibsqlExamImmunization.Fields[32].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_PRIMARY_SOURCE);
    end;
    if (not ibsqlExamImmunization.Fields[33].IsNull)
    then
    begin
      TempItem.PRecord.QUALIFICATION := ibsqlExamImmunization.Fields[33].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_QUALIFICATION);
    end;
    if (not ibsqlExamImmunization.Fields[34].IsNull)
    then
    begin
      TempItem.PRecord.REASON_TO_CANCEL_IMMUNIZATION := ibsqlExamImmunization.Fields[34].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[35].IsNull)
    then
    begin
      TempItem.PRecord.RESULT := ibsqlExamImmunization.Fields[35].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_RESULT);
    end;
    if (not ibsqlExamImmunization.Fields[36].IsNull)
    then
    begin
      TempItem.PRecord.ROUTE := ibsqlExamImmunization.Fields[36].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_ROUTE);
    end;
    if (not ibsqlExamImmunization.Fields[37].IsNull)
    then
    begin
      TempItem.PRecord.SERIAL_NUMBER := ibsqlExamImmunization.Fields[37].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_SERIAL_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[38].IsNull)
    then
    begin
      TempItem.PRecord.SERIES := ibsqlExamImmunization.Fields[38].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_SERIES);
    end;
    if (not ibsqlExamImmunization.Fields[39].IsNull)
    then
    begin
       TempItem.PRecord.SERIES_DOSES := ibsqlExamImmunization.Fields[39].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_SERIES_DOSES);
    end;
    if (not ibsqlExamImmunization.Fields[40].IsNull)
    then
    begin
      TempItem.PRecord.SITE := ibsqlExamImmunization.Fields[40].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_SITE);
    end;
    if (not ibsqlExamImmunization.Fields[41].IsNull)
    then
    begin
       TempItem.PRecord.SOCIAL_GROUP := ibsqlExamImmunization.Fields[41].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_SOCIAL_GROUP);
    end;
    if (not ibsqlExamImmunization.Fields[42].IsNull)
    then
    begin
       TempItem.PRecord.SUBJECT_STATUS := ibsqlExamImmunization.Fields[42].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_SUBJECT_STATUS);
    end;
    if (not ibsqlExamImmunization.Fields[43].IsNull)
    then
    begin
       TempItem.PRecord.UPDATED := ibsqlExamImmunization.Fields[43].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_UPDATED);
    end;
    if (not ibsqlExamImmunization.Fields[44].IsNull)
    then
    begin
      TempItem.PRecord.UVCI := ibsqlExamImmunization.Fields[44].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_UVCI);
    end;
    if (not ibsqlExamImmunization.Fields[45].IsNull)
    then
    begin
       TempItem.PRecord.VACCINE_ID := ibsqlExamImmunization.Fields[45].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_VACCINE_ID);
    end;

    TempItem.PregledID := TempItem.PRecord.PREGLED_ID;
  end;

procedure TDbHelper.InsertKardProfField(ibsql: TIBSQL;
  TempItem: TRealKARTA_PROFILAKTIKA2017Item);
var
  ibsqlKARTA_PROFILAKTIKA2017: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
  ibsqlKARTA_PROFILAKTIKA2017 := ibsql;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[0].IsNull)
    then
    begin
       TempItem.PRecord.BDDIASTOLNO43 := ibsqlKARTA_PROFILAKTIKA2017.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDDIASTOLNO43);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[1].IsNull)
    then
    begin
       TempItem.PRecord.BDGIRTWAIST44 := ibsqlKARTA_PROFILAKTIKA2017.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDGIRTWAIST44);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[2].IsNull)
    then
    begin
       TempItem.PRecord.BDHEIGHT39 := ibsqlKARTA_PROFILAKTIKA2017.Fields[2].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDHEIGHT39);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[4].IsNull)
    then
    begin
       TempItem.PRecord.BDSYSTOLNO42 := ibsqlKARTA_PROFILAKTIKA2017.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDSYSTOLNO42);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[5].IsNull)
    then
    begin
       TempItem.PRecord.BDWEIGHT40 := ibsqlKARTA_PROFILAKTIKA2017.Fields[5].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDWEIGHT40);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[6].IsNull)
    then
    begin
       TempItem.PRecord.CIGARETESCOUNT71 := ibsqlKARTA_PROFILAKTIKA2017.Fields[6].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[7].IsNull)
    then
    begin
       TempItem.PRecord.FINDRISK := ibsqlKARTA_PROFILAKTIKA2017.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_FINDRISK);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[8].IsNull)
    then
    begin
      TempItem.PRecord.ISSUE_DATE := ibsqlKARTA_PROFILAKTIKA2017.Fields[8].AsDate;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_ISSUE_DATE);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[9].IsNull)
    then
    begin
      TempItem.PRecord.MDIGLUCOSE48 := ibsqlKARTA_PROFILAKTIKA2017.Fields[9].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDIGLUCOSE48);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[10].IsNull)
    then
    begin
      TempItem.PRecord.MDIHDL50 := ibsqlKARTA_PROFILAKTIKA2017.Fields[10].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDIHDL50);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[11].IsNull)
    then
    begin
      TempItem.PRecord.MDILDL45 := ibsqlKARTA_PROFILAKTIKA2017.Fields[11].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDILDL45);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[12].IsNull)
    then
    begin
      TempItem.PRecord.MDINONHDL73 := ibsqlKARTA_PROFILAKTIKA2017.Fields[12].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDINONHDL73);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[13].IsNull)
    then
    begin
      TempItem.PRecord.MDIPSA49 := ibsqlKARTA_PROFILAKTIKA2017.Fields[13].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDIPSA49);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[14].IsNull)
    then
    begin
      TempItem.PRecord.MDITG47 := ibsqlKARTA_PROFILAKTIKA2017.Fields[14].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDITG47);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[15].IsNull)
    then
    begin
      TempItem.PRecord.MDITH46 := ibsqlKARTA_PROFILAKTIKA2017.Fields[15].AsDouble;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_MDITH46);
    end;


    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[16].IsNull)
    then
    begin
       TempItem.PRecord.NOMER := ibsqlKARTA_PROFILAKTIKA2017.Fields[16].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_NOMER);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[17].IsNull)
    then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlKARTA_PROFILAKTIKA2017.Fields[17].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_PREGLED_ID);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[18].IsNull)
    then
    begin
       TempItem.PRecord.SCORE := ibsqlKARTA_PROFILAKTIKA2017.Fields[18].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_SCORE);
    end;


  TempItem.PregledID := ibsqlKARTA_PROFILAKTIKA2017.Fields[17].AsInteger;

  TempItem.PRecord.Logical := [];

  TempItem.ADENOMA61 := ibsqlKARTA_PROFILAKTIKA2017.Fields[19].AsString = 'Y';

  TempItem.ANTIHIPERTENZIVNI67 := ibsqlKARTA_PROFILAKTIKA2017.Fields[20].AsString = 'Y';
  TempItem.BENIGNMAMMARY19 := ibsqlKARTA_PROFILAKTIKA2017.Fields[21].AsString = 'Y';
  TempItem.CELIACDISEASE25 := ibsqlKARTA_PROFILAKTIKA2017.Fields[22].AsString = 'Y';
  TempItem.COLORECTALCARCINOMA21 := ibsqlKARTA_PROFILAKTIKA2017.Fields[23].AsString = 'Y';
  TempItem.CROHN63 := ibsqlKARTA_PROFILAKTIKA2017.Fields[24].AsString = 'Y';
  TempItem.DIABETESRELATIVES31 := ibsqlKARTA_PROFILAKTIKA2017.Fields[25].AsString = 'Y';
  TempItem.DIABETESRELATIVESSECOND70 := ibsqlKARTA_PROFILAKTIKA2017.Fields[26].AsString = 'Y';
  TempItem.DYNAMISMPSA28 := ibsqlKARTA_PROFILAKTIKA2017.Fields[27].AsString = 'Y';
  TempItem.DYSLIPIDAEMIA11 := ibsqlKARTA_PROFILAKTIKA2017.Fields[28].AsString = 'Y';
  TempItem.FRUITSVEGETABLES66 := ibsqlKARTA_PROFILAKTIKA2017.Fields[29].AsString = 'Y';
  TempItem.HPVVAKSINA69 := ibsqlKARTA_PROFILAKTIKA2017.Fields[30].AsString = 'Y';
  TempItem.ILLNESSIBS_MSB29 := ibsqlKARTA_PROFILAKTIKA2017.Fields[31].AsString = 'Y';
  TempItem.IMMUNOSUPPRESSED15 := ibsqlKARTA_PROFILAKTIKA2017.Fields[32].AsString = 'Y';
  TempItem.ISFULL := ibsqlKARTA_PROFILAKTIKA2017.Fields[33].AsString = 'Y';
  TempItem.COLITIS64 := ibsqlKARTA_PROFILAKTIKA2017.Fields[34].AsString = 'Y';

  TempItem.IS_PRINTED := ibsqlKARTA_PROFILAKTIKA2017.Fields[35].AsString = 'Y';
  TempItem.MENARCHE07 := ibsqlKARTA_PROFILAKTIKA2017.Fields[36].AsString = 'Y';
  TempItem.NEOCERVIX32 := ibsqlKARTA_PROFILAKTIKA2017.Fields[37].AsString = 'Y';
  TempItem.NEOREKTOSIGMOIDE35 := ibsqlKARTA_PROFILAKTIKA2017.Fields[38].AsString = 'Y';
  TempItem.POLYP62 := ibsqlKARTA_PROFILAKTIKA2017.Fields[39].AsString = 'Y';
  TempItem.PREDIABETIC10 := ibsqlKARTA_PROFILAKTIKA2017.Fields[40].AsString = 'Y';
  TempItem.PREGNANCY08 := ibsqlKARTA_PROFILAKTIKA2017.Fields[41].AsString = 'Y';
  TempItem.PREGNANCYCHILDBIRTH68 := ibsqlKARTA_PROFILAKTIKA2017.Fields[42].AsString = 'Y';
  TempItem.PROLONGEDHRT04 := ibsqlKARTA_PROFILAKTIKA2017.Fields[43].AsString = 'Y';
  TempItem.PROSTATECARCINOMA38 := ibsqlKARTA_PROFILAKTIKA2017.Fields[44].AsString = 'Y';
  TempItem.RELATIVESBREAST33 := ibsqlKARTA_PROFILAKTIKA2017.Fields[45].AsString = 'Y';
  TempItem.SEDENTARYLIFE02 := ibsqlKARTA_PROFILAKTIKA2017.Fields[46].AsString = 'Y';
  TempItem.TYPE1DIABETES65 := ibsqlKARTA_PROFILAKTIKA2017.Fields[47].AsString = 'Y';
  TempItem.TYPE2DIABETES09 := ibsqlKARTA_PROFILAKTIKA2017.Fields[48].AsString = 'Y';
  TempItem.WOMENCANCERS18 := ibsqlKARTA_PROFILAKTIKA2017.Fields[49].AsString = 'Y';
  if TempItem.PRecord.Logical <> [] then
    Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_Logical);

end;

procedure TDbHelper.InsertMedNaprField(ibsql: TIBSQL;
  TempItem: TRealBLANKA_MED_NAPRItem);
var
  ibsqlBLANKA_MED_NAPR: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
  ibsqlBLANKA_MED_NAPR := ibsql;
 // if (not ibsqlBLANKA_MED_NAPR.Fields[0].IsNull)
//  then
 // begin
//    TempItem.PRecord.ATTACHED_DOCS := ibsqlBLANKA_MED_NAPR.Fields[0].AsString;
//    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_ATTACHED_DOCS);
//  end;
//  if (not ibsqlBLANKA_MED_NAPR.Fields[1].IsNull)
//  then
//  begin
//    TempItem.PRecord.DIAGNOSES := ibsqlBLANKA_MED_NAPR.Fields[1].AsString;
//    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_DIAGNOSES);
//  end;

  TempItem.ICD_CODE := ibsqlBLANKA_MED_NAPR.Fields[2].AsString;
  TempItem.ICD_CODE_ADD := ibsqlBLANKA_MED_NAPR.Fields[7].AsString;
  TempItem.ICD_CODE2 := ibsqlBLANKA_MED_NAPR.Fields[3].AsString;
  TempItem.ICD_CODE2_ADD := ibsqlBLANKA_MED_NAPR.Fields[4].AsString;
  TempItem.ICD_CODE3 := ibsqlBLANKA_MED_NAPR.Fields[5].AsString;
  TempItem.ICD_CODE3_ADD := ibsqlBLANKA_MED_NAPR.Fields[6].AsString;


  if (not ibsqlBLANKA_MED_NAPR.Fields[8].IsNull)
  then
  begin
     TempItem.PRecord.ID := ibsqlBLANKA_MED_NAPR.Fields[8].AsInteger;
     Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_ID);
  end;
  if (not ibsqlBLANKA_MED_NAPR.Fields[9].IsNull)
  then
  begin
    TempItem.PRecord.ISSUE_DATE := ibsqlBLANKA_MED_NAPR.Fields[9].AsDate;
    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_ISSUE_DATE);
  end;
  if (not ibsqlBLANKA_MED_NAPR.Fields[10].IsNull)
  then
  begin
    TempItem.PRecord.NRN := ibsqlBLANKA_MED_NAPR.Fields[10].AsString;
    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_NRN);
  end;
  if (not ibsqlBLANKA_MED_NAPR.Fields[11].IsNull)
  then
  begin
     TempItem.PRecord.NUMBER := ibsqlBLANKA_MED_NAPR.Fields[11].AsInteger;
     Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_NUMBER);
  end;
  if (not ibsqlBLANKA_MED_NAPR.Fields[12].IsNull)
  then
  begin
     TempItem.PRecord.PREGLED_ID := ibsqlBLANKA_MED_NAPR.Fields[12].AsInteger;
     Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_PREGLED_ID);
  end;
  if (not ibsqlBLANKA_MED_NAPR.Fields[13].IsNull)
  then
  begin
    TempItem.PRecord.REASON := ibsqlBLANKA_MED_NAPR.Fields[13].AsString;
    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_REASON);
  end;
  //if (not ibsqlBLANKA_MED_NAPR.Fields[14].IsNull)
//  then
//  begin
//    TempItem.PRecord.SPECIALIST_AMB_LIST_INFO := ibsqlBLANKA_MED_NAPR.Fields[14].AsString;
//    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_SPECIALIST_AMB_LIST_INFO);
//  end;
//  if (not ibsqlBLANKA_MED_NAPR.Fields[15].IsNull)
//  then
//  begin
//    TempItem.PRecord.SPECIALIST_DATE := ibsqlBLANKA_MED_NAPR.Fields[15].AsDate;
//    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_SPECIALIST_DATE);
//  end;
//  if (not ibsqlBLANKA_MED_NAPR.Fields[16].IsNull)
//  then
//  begin
//     TempItem.PRecord.SPECIALIST_ID := ibsqlBLANKA_MED_NAPR.Fields[16].AsInteger;
//     Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_SPECIALIST_ID);
//  end;
  if (not ibsqlBLANKA_MED_NAPR.Fields[17].IsNull)
  then
  begin
     TempItem.PRecord.SPECIALITY_ID := ibsqlBLANKA_MED_NAPR.Fields[17].AsInteger;
     Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_SPECIALITY_ID);
  end;
  TempItem.SpecNzis := ibsqlBLANKA_MED_NAPR.Fields[22].AsString;
  TempItem.PregledID := ibsqlBLANKA_MED_NAPR.Fields[12].AsInteger;


  TempItem.PRecord.Logical := [];
  if ibsqlBLANKA_MED_NAPR.Fields[18].AsString = 'Y' then
    Include(TempItem.PRecord.Logical, IS_PRINTED);
  if ibsqlBLANKA_MED_NAPR.Fields[19].AsString = 'Y' then
    Include(TempItem.PRecord.Logical, EXAMED_BY_SPECIALIST);
  case ibsqlBLANKA_MED_NAPR.Fields[20].Asinteger  of
    0: Include(TempItem.PRecord.Logical, NZIS_STATUS_None);
    3: Include(TempItem.PRecord.Logical, NZIS_STATUS_Sended);
    5: Include(TempItem.PRecord.Logical, NZIS_STATUS_Cancel);
  end;
  case ibsqlBLANKA_MED_NAPR.Fields[21].Asinteger  of
    1: Include(TempItem.PRecord.Logical, MED_NAPR_Ostro);
    2: Include(TempItem.PRecord.Logical, MED_NAPR_Hron);
    3: Include(TempItem.PRecord.Logical, MED_NAPR_Disp);
    4: Include(TempItem.PRecord.Logical, MED_NAPR_Prof);
    5: Include(TempItem.PRecord.Logical, MED_NAPR_Iskane_Telk);
    6: Include(TempItem.PRecord.Logical, MED_NAPR_Mother);
    7: Include(TempItem.PRecord.Logical, MED_NAPR_Child);
    9: Include(TempItem.PRecord.Logical, MED_NAPR_Eksp);
  end;



  if TempItem.PRecord.Logical <> [] then
    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_Logical);
end;

procedure TDbHelper.InsertPregledField(ibsql: TIBSQL; TempItem: TRealPregledNewItem);
  var
    ibsqlPregledNew: TIBSQL;
    diagNode: PVirtualNode;
    data: PAspRec;
    diag: TRealDiagnosisItem;
    dataPosition: Cardinal;
  begin
    ibsqlPregledNew := ibsql;

    if (not ibsqlPregledNew.Fields[0].IsNull)
    then
    begin
       TempItem.PRecord.AMB_LISTN := ibsqlPregledNew.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_AMB_LISTN);
    end;
    if (not ibsqlPregledNew.Fields[1].IsNull)
    then
    begin
      TempItem.PRecord.ANAMN := ibsqlPregledNew.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_ANAMN);
    end;
    if (not ibsqlPregledNew.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.COPIED_FROM_NRN := ibsqlPregledNew.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_COPIED_FROM_NRN);
    end;
    if (not ibsqlPregledNew.Fields[3].IsNull)
    then
    begin
      TempItem.PRecord.GS := ibsqlPregledNew.Fields[3].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_GS);
    end;
    if (not ibsqlPregledNew.Fields[4].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlPregledNew.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_ID);
    end;
    if (not ibsqlPregledNew.Fields[5].IsNull)
    then
    begin
      TempItem.PRecord.IZSL := ibsqlPregledNew.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_IZSL);
    end;
    if (not ibsqlPregledNew.Fields[6].IsNull)
    then
    begin
       TempItem.PRecord.MEDTRANSKM := ibsqlPregledNew.Fields[6].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_MEDTRANSKM);
    end;
    if (not ibsqlPregledNew.Fields[7].IsNull)
    then
    begin
      TempItem.PRecord.NAPRAVLENIE_AMBL_NOMER := ibsqlPregledNew.Fields[7].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NAPRAVLENIE_AMBL_NOMER);
    end;
    if (not ibsqlPregledNew.Fields[8].IsNull)
    then
    begin
      if ibsqlPregledNew.Fields[8].Asstring <> #0 then
      begin
        TempItem.PRecord.NAPR_TYPE_ID := ibsqlPregledNew.Fields[8].AsInteger;
        Include(TempItem.PRecord.setProp, PregledNew_NAPR_TYPE_ID);
      end;
    end;
    if (not ibsqlPregledNew.Fields[9].IsNull)
    then
    begin
      TempItem.PRecord.NOMERBELEGKA := ibsqlPregledNew.Fields[9].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NOMERBELEGKA);
    end;
    if (not ibsqlPregledNew.Fields[10].IsNull)
    then
    begin
      TempItem.PRecord.NOMERKASHAPARAT := ibsqlPregledNew.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NOMERKASHAPARAT);
    end;
    if (not ibsqlPregledNew.Fields[11].IsNull)
    then
    begin
      TempItem.PRecord.NRD := ibsqlPregledNew.Fields[11].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_NRD);
    end;
    if (not ibsqlPregledNew.Fields[12].IsNull)
    then
    begin
      TempItem.PRecord.NRN_LRN := ibsqlPregledNew.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NRN);
    end;
    if (not ibsqlPregledNew.Fields[13].IsNull)
    then
    begin
      TempItem.PRecord.NZIS_STATUS := ibsqlPregledNew.Fields[13].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_NZIS_STATUS);
    end;
    if (not ibsqlPregledNew.Fields[14].IsNull)
    then
    begin
      TempItem.PRecord.OBSHTAPR := ibsqlPregledNew.Fields[14].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_OBSHTAPR);
    end;
    if (not ibsqlPregledNew.Fields[15].IsNull)
    then
    begin
      TempItem.PRecord.PATIENTOF_NEOTL := ibsqlPregledNew.Fields[15].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_PATIENTOF_NEOTL);
    end;
    if (not ibsqlPregledNew.Fields[16].IsNull)
    then
    begin
       TempItem.PRecord.PATIENTOF_NEOTLID := ibsqlPregledNew.Fields[16].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_PATIENTOF_NEOTLID);
    end;
    if (not ibsqlPregledNew.Fields[17].IsNull)
    then
    begin
      TempItem.PRecord.PREVENTIVE_TYPE := ibsqlPregledNew.Fields[17].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_PREVENTIVE_TYPE);
    end;
    if (not ibsqlPregledNew.Fields[18].IsNull)
    then
    begin
      TempItem.PRecord.REH_FINISHED_AT := ibsqlPregledNew.Fields[18].AsDate;
      Include(TempItem.PRecord.setProp, PregledNew_REH_FINISHED_AT);
    end;
    if (not ibsqlPregledNew.Fields[19].IsNull)
    then
    begin
      TempItem.PRecord.START_DATE := ibsqlPregledNew.Fields[19].AsDate;
      Include(TempItem.PRecord.setProp, PregledNew_START_DATE);
    end;
    if (not ibsqlPregledNew.Fields[20].IsNull)
    then
    begin
      TempItem.PRecord.START_TIME := ibsqlPregledNew.Fields[20].AsTime;
      Include(TempItem.PRecord.setProp, PregledNew_START_TIME);
    end;
    if (not ibsqlPregledNew.Fields[21].IsNull)
    then
    begin
      TempItem.PRecord.SYST := ibsqlPregledNew.Fields[21].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_SYST);
    end;
    if (not ibsqlPregledNew.Fields[22].IsNull)
    then
    begin
      TempItem.PRecord.TALON_LKK := ibsqlPregledNew.Fields[22].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_TALON_LKK);
    end;
    if (not ibsqlPregledNew.Fields[23].IsNull)
    then
    begin
      TempItem.PRecord.TERAPY := ibsqlPregledNew.Fields[23].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_TERAPY);
    end;
    if (not ibsqlPregledNew.Fields[24].IsNull)
    then
    begin
      TempItem.PRecord.THREAD_IDS := ibsqlPregledNew.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_THREAD_IDS);
    end;
    if (not ibsqlPregledNew.Fields[25].IsNull)
    then
    begin
       TempItem.PRecord.VISIT_ID := ibsqlPregledNew.Fields[25].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_VISIT_ID);
    end;
    if (not ibsqlPregledNew.Fields[26].IsNull)
    then
    begin
      TempItem.PRecord.VISIT_TYPE_ID := ibsqlPregledNew.Fields[26].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_VISIT_TYPE_ID);
    end;
    if (not ibsqlPregledNew.Fields[27].IsNull)
    then
    begin
      TempItem.PRecord.VSD_TYPE := ibsqlPregledNew.Fields[27].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_VSD_TYPE);
    end;

    TempItem.PregledID := ibsqlPregledNew.Fields[4].AsInteger;
    TempItem.PatID := ibsqlPregledNew.Fields[28].AsInteger;
    TempItem.StartDate := ibsqlPregledNew.Fields[19].AsDate;

    TempItem.MainMKB := ibsqlPregledNew.Fields[29].AsString;
    TempItem.MAIN_DIAG_MKB_ADD := ibsqlPregledNew.Fields[30].AsString;
    TempItem.MainMKB1 := ibsqlPregledNew.Fields[31].AsString;
    TempItem.MAIN_DIAG_MKB_ADD1 := ibsqlPregledNew.Fields[32].AsString;
    TempItem.MainMKB2 := ibsqlPregledNew.Fields[33].AsString;
    TempItem.MAIN_DIAG_MKB_ADD2 := ibsqlPregledNew.Fields[34].AsString;
    TempItem.MainMKB3 := ibsqlPregledNew.Fields[35].AsString;
    TempItem.MAIN_DIAG_MKB_ADD3 := ibsqlPregledNew.Fields[36].AsString;
    TempItem.MainMKB4 := ibsqlPregledNew.Fields[37].AsString;
    TempItem.MAIN_DIAG_MKB_ADD4 := ibsqlPregledNew.Fields[38].AsString;


    TempItem.PRecord.Logical := [];

    case ibsqlPregledNew.Fields[39].Asinteger  of
      1:
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
      end;
      2:
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
      end;
    end;

    case ibsqlPregledNew.Fields[40].Asinteger  of
      1:
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
      end;
    end;



    TempItem.DoctorID := ibsqlPregledNew.Fields[41].Asinteger;

    TempItem.IS_ZAMESTVASHT := ibsqlPregledNew.Fields[42].AsString = 'Y';
    TempItem.IS_NAET := ibsqlPregledNew.Fields[43].AsString = 'Y';
    TempItem.OWNER_DOCTOR_ID := ibsqlPregledNew.Fields[44].Asinteger;
    TempItem.EXAM_BOLN_LIST_ID := ibsqlPregledNew.Fields[45].Asinteger;

    TempItem.INCIDENTALLY := ibsqlPregledNew.Fields[46].AsString = 'Y';
    TempItem.IS_ANALYSIS := ibsqlPregledNew.Fields[47].AsString = 'Y';
    TempItem.IS_BABY_CARE := ibsqlPregledNew.Fields[48].AsString = 'Y';
    TempItem.IS_CONSULTATION := ibsqlPregledNew.Fields[49].AsString = 'Y';
    TempItem.IS_DISPANSERY := ibsqlPregledNew.Fields[50].AsString = 'Y';
    TempItem.IS_EMERGENCY := ibsqlPregledNew.Fields[51].AsString = 'Y';
    TempItem.IS_EPIKRIZA := ibsqlPregledNew.Fields[52].AsString = 'Y';
    TempItem.IS_EXPERTIZA := ibsqlPregledNew.Fields[53].AsString = 'Y';
    TempItem.IS_FORM_VALID := ibsqlPregledNew.Fields[54].AsString = 'Y';
    TempItem.IS_HOSPITALIZATION := ibsqlPregledNew.Fields[55].AsString = 'Y';
    TempItem.IS_MANIPULATION := ibsqlPregledNew.Fields[56].AsString = 'Y';
    TempItem.IS_MEDBELEJKA := ibsqlPregledNew.Fields[57].AsString = 'Y';

    TempItem.IS_NAPR_TELK := ibsqlPregledNew.Fields[58].AsString = 'Y';
    TempItem.IS_NEW := ibsqlPregledNew.Fields[59].AsString = 'Y';
    TempItem.IS_NOTIFICATION := ibsqlPregledNew.Fields[60].AsString = 'Y';
    TempItem.IS_NO_DELAY := ibsqlPregledNew.Fields[61].AsString = 'Y';
    TempItem.IS_OPERATION := ibsqlPregledNew.Fields[62].AsString = 'Y';
    TempItem.IS_PODVIZHNO_LZ := ibsqlPregledNew.Fields[63].AsString = 'Y';
    TempItem.IS_PREVENTIVE := ibsqlPregledNew.Fields[64].AsString = 'Y';
    TempItem.IS_PRINTED := ibsqlPregledNew.Fields[65].AsString = 'Y';
    TempItem.IS_RECEPTA_HOSPIT := ibsqlPregledNew.Fields[66].AsString = 'Y';
    TempItem.IS_REGISTRATION := ibsqlPregledNew.Fields[67].AsString = 'Y';
    TempItem.IS_REHABILITATION := ibsqlPregledNew.Fields[68].AsString = 'Y';
    TempItem.IS_RISK_GROUP := ibsqlPregledNew.Fields[69].AsString = 'Y';
    TempItem.IS_TELK := ibsqlPregledNew.Fields[70].AsString = 'Y';
    TempItem.IS_VSD := ibsqlPregledNew.Fields[71].AsString = 'Y';
    TempItem.PAY := ibsqlPregledNew.Fields[72].AsString = 'Y';
    TempItem.TO_BE_DISPANSERED := ibsqlPregledNew.Fields[73].AsString = 'Y';
    TempItem.PROCEDURE1_MKB := ibsqlPregledNew.Fields[74].AsString;
    TempItem.PROCEDURE2_MKB := ibsqlPregledNew.Fields[75].AsString;
    TempItem.PROCEDURE3_MKB := ibsqlPregledNew.Fields[76].AsString;
    TempItem.PROCEDURE4_MKB := ibsqlPregledNew.Fields[77].AsString;
    TempItem.RECKNNO := ibsqlPregledNew.Fields[78].AsString;
    TempItem.PREVENTIVE_TYPE := ibsqlPregledNew.Fields[17].AsInteger;//1-детско, 2-над 18, 3-майчино

    //TempItem.CalcPorpuse(AdbHip.Buf, AdbHip.FPosData);



    if TempItem.PRecord.Logical <> [] then
      Include(TempItem.PRecord.setProp, PregledNew_Logical);

  end;

procedure TDbHelper.SaveExamAnals(ExamAnal: TRealExamAnalysisItem;
  ibsql: TIBSQL);
var
  //logData24: TLogicalData24;
  //logMdn: TlogicalMDNSet;
  i: Integer;
  PosInNomen: Cardinal;
  cl22Code, CL022NHIFCode: string;
  //amb
begin
  //logData24 := mdn.getLogical24Map(AdbHip.Buf, AdbHip.FPosData, word(Mdn_Logical));
  //logMdn := TlogicalMDNSet(logData24);
  ibsql.Close;
  ibsql.SQL.Text := 'select gen_id(GEN_EXAM_ANALYSIS_ID, 1) from rdb$database';
  ibsql.ExecQuery;
  ExamAnal.ExamAnalID  := ibsql.Fields[0].AsInteger;
  cl22Code := ExamAnal.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(ExamAnalysis_NZIS_CODE_CL22));
  if cl22Code.Contains  ('.') then
  begin
    for i := 0 to collCl022.Count - 1 do
    begin
      if collCl022.Items[i].getAnsiStringMap(AdbNomenNzis.Buf, AdbNomenNzis.FPosData, word(CL022_NHIF_Code)) = cl22Code then
      begin
        cl22Code := collCl022.Items[i].getAnsiStringMap(AdbNomenNzis.Buf, AdbNomenNzis.FPosData, word(CL022_Key));
        Break;
      end;
    end;
  end;

  PosInNomen := ExamAnal.getCardMap(AdbHip.Buf, AdbHip.FPosData, word(ExamAnalysis_PosDataNomen));
  ExamAnal.SetIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_ID), ExamAnal.ExamAnalID); // трябва инсърта в АДБ да му е направил място
  //ExamAnal.GetIntMap(AdbHip.Buf, AdbHip.FPosData, word(ExamAnalysis_ID));
  ibsql.Close;
  ibsql.SQL.Text :=
  'insert into EXAM_ANALYSIS (ID, PREGLED_ID, ANALYSIS_ID, BLANKA_MDN_ID, RESULT, DATA, EMDN_ID, NZIS_CODE_CL22,' + #13#10 +
                           'NZIS_DESCRIPTION_CL22, NRN_EXECUTION)' + #13#10 +
  'values (:ID, :PREGLED_ID, (select first 1 a.id from analysis a where a.cl22 = :NZIS_CODE_CL22 and a.code > 0), :BLANKA_MDN_ID, :RESULT, :DATA, :EMDN_ID, :NZIS_CODE_CL22,' + #13#10 +
                           ':NZIS_DESCRIPTION_CL22, :NRN_EXECUTION);';

  for i := 0 to ibsql.Params.Count - 1 do
  begin
    ibsql.Params[i].Clear;
  end;
  ibsql.ParamByName('ID').AsInteger := ExamAnal.ExamAnalID;
  ibsql.ParamByName('PREGLED_ID').AsInteger :=  ExamAnal.FMdn.PregledID;
  ibsql.ParamByName('BLANKA_MDN_ID').AsInteger := ExamAnal.FMdn.MdnId;
  ibsql.ParamByName('DATA').AsDate := ExamAnal.FMdn.FPregled.getdateMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_START_DATE));
  ibsql.ParamByName('NZIS_CODE_CL22').AsString := cl22Code; //ExamAnal.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(ExamAnalysis_NZIS_CODE_CL22));
  ibsql.ParamByName('NZIS_DESCRIPTION_CL22').AsString := ExamAnal.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(ExamAnalysis_NZIS_DESCRIPTION_CL22));

  ibsql.ExecQuery;
  ibsql.Transaction.CommitRetaining;
end;

procedure TDbHelper.SaveMdn(mdn: TRealMdnItem; ibsql: TIBSQL);
var
  logData24: TLogicalData24;
  logMdn: TlogicalMDNSet;
  i: Integer;
  //amb
begin
  logData24 := mdn.getLogical24Map(AdbHip.Buf, AdbHip.FPosData, word(Mdn_Logical));
  logMdn := TlogicalMDNSet(logData24);
  ibsql.Close;
  ibsql.SQL.Text := 'select gen_id(gen_blanka_mdn, 1) from rdb$database';
  ibsql.ExecQuery;
  mdn.MdnId  := ibsql.Fields[0].AsInteger;
  mdn.SetIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_ID), mdn.MdnId); // трябва инсърта в АДБ да му е направил място
  //mdn.GetIntMap(AdbHip.Buf, AdbHip.FPosData, word(mdn_ID));
  ibsql.Close;
  ibsql.SQL.Text :=
  'insert into BLANKA_MDN (ID, PREGLED_ID, NUMBER, DATA, ICD_CODE, IS_LKK, MED_DIAG_NAPR_TYPE_ID, ICD_CODE_ADD, IS_PRINTED,' + #13#10 +
                        'OTHER_DOCTOR_ID, TAKENFROMARENAL, NRN, NZIS_STATUS)' + #13#10 +
  'values (:ID, :PREGLED_ID, :NUMBER, :DATA, :ICD_CODE, :IS_LKK, :MED_DIAG_NAPR_TYPE_ID, :ICD_CODE_ADD, :IS_PRINTED,' + #13#10 +
                        ':OTHER_DOCTOR_ID, :TAKENFROMARENAL, :NRN, :NZIS_STATUS);';

  for i := 0 to ibsql.Params.Count - 1 do
  begin
    ibsql.Params[i].Clear;
  end;
  ibsql.ParamByName('ID').AsInteger := mdn.MdnId;
  ibsql.ParamByName('PREGLED_ID').AsInteger := mdn.PregledID;
  ibsql.ParamByName('NUMBER').AsInteger := mdn.getIntMap(AdbHip.Buf, AdbHip.FPosData, word(MDN_NUMBER));
  ibsql.ParamByName('DATA').AsDate := mdn.FPregled.getdateMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_START_DATE));      //  mdn.getdateMap(AdbHip.Buf, AdbHip.FPosData, word(MDN_DATA));
  ibsql.ParamByName('NRN').AsString := mdn.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(MDN_NRN));
  ibsql.ParamByName('NZIS_STATUS').Asinteger := 3;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  ibsql.ParamByName('MED_DIAG_NAPR_TYPE_ID').AsInteger := 1;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  ibsql.ParamByName('IS_PRINTED').Asstring := 'N';


  ibsql.ExecQuery;
  ibsql.Transaction.CommitRetaining;
end;

procedure TDbHelper.SavePregledFDB(preg: TRealPregledNewItem; ibsql: TIBSQL);
var
  logData40: TLogicalData40;
  logPreg: TlogicalPregledNewSet;
  i: Integer;
  SetProp: TPregledNewItem.TSetProp;
begin
  logData40 := preg.getLogical40Map(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_Logical));
  logPreg := TlogicalPregledNewSet(logData40);
  ibsql.Close;
  ibsql.SQL.Text := 'select gen_id(gen_pregled, 1) from rdb$database';
  ibsql.ExecQuery;
  preg.PregledID  := ibsql.Fields[0].AsInteger;

  ibsql.Close;
  ibsql.SQL.Text :=
    'update NUMERATION_COUNTER set VAL = VAL + 1' + #13#10 +
      'where ID = (select first 1 NUM.NUMERATION_COUNTER_ID' + #13#10 +
                  'from NUMERATION NUM' + #13#10 +
                  'where NUM.NUMERATION_CLASS_ID = 1 and' + #13#10 +
                        'NUM.DOCTOR_ID = :DOCTORID) returning new.VAL';
  preg.DoctorID := preg.FDoctor.getIntMap(AdbHip.Buf, AdbHip.FPosData, word(Doctor_ID));
  ibsql.ParamByName('DOCTORID').AsInteger := preg.DoctorID;
  ibsql.ExecQuery;
  preg.AMB_LISTN  := ibsql.Fields[0].AsInteger;
  ibsql.Transaction.CommitRetaining;

  preg.SetIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_ID), preg.PregledID); // трябва инсърта в АДБ да му е направил място
  //preg.GetIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_ID));
  preg.SetIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_AMB_LISTN), preg.AMB_LISTN);

  // място му е направено, но няма кой да го запише в цмд-то. Затова пишемммм.
  SetProp := [PregledNew_AMB_LISTN, PregledNew_ID];
  preg.SaveAnyStreamCommand(@SetProp, SizeOf(SetProp), ctPregledNew, toChange, preg.Version, preg.DataPos);
  CollPreg.streamComm.Write(preg.AMB_LISTN, 4);
  CollPreg.streamComm.Write(preg.PregledID, 4);

  CollPreg.streamComm.Len := CollPreg.streamComm.Size;
  cmdFile.CopyFrom(CollPreg.streamComm, 0);


  ibsql.Close;
  ibsql.SQL.Text :=
    'insert into PREGLED (ID, PACIENT_ID, DOCTOR_ID, START_DATE, START_TIME, AMB_LISTN, OBSHTAPR, AMB_PR, DOM_PR,' + #13#10 +
                     'IS_DISPANSERY, IS_NO_DELAY, IS_EMERGENCY, IS_PREVENTIVE, IS_CONSULTATION, IS_ANALYSIS,' + #13#10 +
                     'IS_MANIPULATION, IS_OPERATION, IS_NOTIFICATION, IS_EPIKRIZA, IS_HOSPITALIZATION, IS_REHABILITATION,' + #13#10 +
                     'TALON_LKK, MAIN_DIAG_MKB, MAIN_DIAG_OPIS, IS_NEW, MEDTRANSKM, PR_ZAB1_MKB, PR_ZAB1_OPIS,' + #13#10 +
                     'PR_ZAB2_MKB, PR_ZAB2_OPIS, PR_ZAB3_MKB, PR_ZAB3_OPIS, PR_ZAB4_MKB, PR_ZAB4_OPIS, PROCEDURE1_MKB,' + #13#10 +
                     'PROCEDURE1_OPIS, PROCEDURE2_MKB, PROCEDURE2_OPIS, PROCEDURE3_MKB, PROCEDURE3_OPIS, ANAMN, SYST,' + #13#10 +
                     'IZSL, TERAPY, IS_FORM_VALID, RECKNNO, IS_PODVIZHNO_LZ, MAIN_DIAG_MKB_ADD, PR_ZAB1_MKB_ADD,' + #13#10 +
                     'PR_ZAB2_MKB_ADD, PR_ZAB3_MKB_ADD, PR_ZAB4_MKB_ADD, IS_ZAMESTVASHT, IS_NAET, PREVENTIVE_TYPE, GS,' + #13#10 +
                     'IS_VSD, VSD_TYPE, IS_RECEPTA_HOSPIT, IS_EXPERTIZA, IS_TELK, NRD, EXAM_BOLN_LIST_ID, IS_NAPR_TELK,' + #13#10 +
                     'IS_RISK_GROUP, PROCEDURE4_MKB, PROCEDURE4_OPIS, IS_PRINTED, LIFESENSOR_ID, PAY, INCIDENTALLY,' + #13#10 +
                     'IS_REGISTRATION, AMB_JOURNALN, TO_BE_DISPANSERED, NOMERBELEGKA, NOMERKASHAPARAT, SIMP_NZOKNOMER,' + #13#10 +
                     'IS_MEDBELEJKA, PATIENTOF_NEOTL, PATIENTOF_NEOTLID, NRN, NZIS_STATUS, COPIED_FROM_NRN,' + #13#10 +
                     'SIMP_NAPR_NRN, SIMP_PRIMARY_AMBLIST_NRN, IS_BABY_CARE, PRIMARY_NOTE_ID, THREAD_IDS, PROCEDURE1_ID,' + #13#10 +
                     'PROCEDURE2_ID, PROCEDURE3_ID, PROCEDURE4_ID)' + #13#10 +
                     '' + #13#10 +
                     'values' + #13#10 +
                     '' + #13#10 +
                     '(:ID, :PACIENT_ID, :DOCTOR_ID, :START_DATE, :START_TIME, :AMB_LISTN, :OBSHTAPR, :AMB_PR, :DOM_PR, :IS_DISPANSERY,' + #13#10 +
                     ':IS_NO_DELAY, :IS_EMERGENCY, :IS_PREVENTIVE, :IS_CONSULTATION, :IS_ANALYSIS, :IS_MANIPULATION, :IS_OPERATION,' + #13#10 +
                     ':IS_NOTIFICATION, :IS_EPIKRIZA, :IS_HOSPITALIZATION, :IS_REHABILITATION, :TALON_LKK, :MAIN_DIAG_MKB, :MAIN_DIAG_OPIS,' + #13#10 +
                     ':IS_NEW, :MEDTRANSKM, :PR_ZAB1_MKB, :PR_ZAB1_OPIS, :PR_ZAB2_MKB, :PR_ZAB2_OPIS, :PR_ZAB3_MKB, :PR_ZAB3_OPIS,' + #13#10 +
                     ':PR_ZAB4_MKB, :PR_ZAB4_OPIS, :PROCEDURE1_MKB, :PROCEDURE1_OPIS, :PROCEDURE2_MKB, :PROCEDURE2_OPIS, :PROCEDURE3_MKB,' + #13#10 +
                     ':PROCEDURE3_OPIS, :ANAMN, :SYST, :IZSL, :TERAPY, :IS_FORM_VALID, :RECKNNO, :IS_PODVIZHNO_LZ, :MAIN_DIAG_MKB_ADD,' + #13#10 +
                     ':PR_ZAB1_MKB_ADD, :PR_ZAB2_MKB_ADD, :PR_ZAB3_MKB_ADD, :PR_ZAB4_MKB_ADD, :IS_ZAMESTVASHT, :IS_NAET, :PREVENTIVE_TYPE,' + #13#10 +
                     ':GS, :IS_VSD, :VSD_TYPE, :IS_RECEPTA_HOSPIT, :IS_EXPERTIZA, :IS_TELK, :NRD, :EXAM_BOLN_LIST_ID, :IS_NAPR_TELK,' + #13#10 +
                     ':IS_RISK_GROUP, :PROCEDURE4_MKB, :PROCEDURE4_OPIS, :IS_PRINTED, :LIFESENSOR_ID, :PAY, :INCIDENTALLY, :IS_REGISTRATION,' + #13#10 +
                     ':AMB_JOURNALN, :TO_BE_DISPANSERED, :NOMERBELEGKA, :NOMERKASHAPARAT, :SIMP_NZOKNOMER, :IS_MEDBELEJKA, :PATIENTOF_NEOTL,' + #13#10 +
                     ':PATIENTOF_NEOTLID, :NRN, :NZIS_STATUS, :COPIED_FROM_NRN, :SIMP_NAPR_NRN, :SIMP_PRIMARY_AMBLIST_NRN, :IS_BABY_CARE,' + #13#10 +
                     ':PRIMARY_NOTE_ID, :THREAD_IDS, :PROCEDURE1_ID, :PROCEDURE2_ID, :PROCEDURE3_ID, :PROCEDURE4_ID);';
  for i := 0 to ibsql.Params.Count - 1 do
  begin
    ibsql.Params[i].Clear;
  end;

  for i := 0 to preg.FDiagnosis.Count - 1 do
  begin
    if i = 0 then
    begin
      ibsql.ParamByName('main_diag_mkb').Asstring := preg.FDiagnosis[i].getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(Diagnosis_code_CL011));
      preg.FDiagnosis[i].AddMkb := preg.FDiagnosis[i].getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(Diagnosis_additionalCode_CL011));
      if preg.FDiagnosis[i].AddMkb <> '' then
      ibsql.ParamByName('main_diag_mkb_add').Asstring := preg.FDiagnosis[i].AddMkb;
    end
    else
    begin
      ibsql.ParamByName('PR_ZAB' + IntToStr(i) + '_MKB').Asstring := preg.FDiagnosis[i].getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(Diagnosis_code_CL011));
      preg.FDiagnosis[i].AddMkb := preg.FDiagnosis[i].getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(Diagnosis_additionalCode_CL011));
      if preg.FDiagnosis[i].AddMkb <> '' then
      ibsql.ParamByName('PR_ZAB' + IntToStr(i) + '_MKB_ADD').Asstring := preg.FDiagnosis[i].AddMkb;
    end;
  end;

  ibsql.ParamByName('ID').AsInteger := preg.PregledID;
  ibsql.ParamByName('AMB_JOURNALN').AsInteger := 0;
  ibsql.ParamByName('DOCTOR_ID').AsInteger := preg.DoctorID;


  ibsql.ParamByName('AMB_LISTN').AsInteger := preg.getIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_AMB_LISTN));
  ibsql.ParamByName('NRN').AsString := preg.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_NRN));
  ibsql.ParamByName('NZIS_STATUS').AsInteger := preg.getWordMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_NZIS_STATUS));
  ibsql.ParamByName('START_DATE').AsDate := preg.getDateMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_START_DATE));
  ibsql.ParamByName('START_TIME').AsTime := preg.getTimeMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_START_TIME));
  ibsql.ParamByName('PACIENT_ID').AsInteger := preg.Fpatient.getIntMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_ID));
  ibsql.ParamByName('ANAMN').AsString := preg.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_ANAMN));
  ibsql.ParamByName('SYST').AsString := preg.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_SYST));
  ibsql.ParamByName('IZSL').AsString := preg.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_IZSL));
  ibsql.ParamByName('TERAPY').AsString := preg.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_TERAPY));

  ibsql.ParamByName('NRD').AsInteger := 2006;
  if IS_REGISTRATION in logPreg then
    ibsql.ParamByName('IS_REGISTRATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_REGISTRATION').AsString := 'N';
  if INCIDENTALLY in logPreg then
    ibsql.ParamByName('INCIDENTALLY').AsString := 'Y'
  else
    ibsql.ParamByName('INCIDENTALLY').AsString := 'N';
  if PAY in logPreg then
    ibsql.ParamByName('PAY').AsString := 'Y'
  else
    ibsql.ParamByName('PAY').AsString := 'N';
  if IS_RISK_GROUP in logPreg then
    ibsql.ParamByName('IS_RISK_GROUP').AsString := 'Y'
  else
    ibsql.ParamByName('IS_RISK_GROUP').AsString := 'N';
  if IS_NAPR_TELK in logPreg then
    ibsql.ParamByName('IS_NAPR_TELK').AsString := 'Y'
  else
    ibsql.ParamByName('IS_NAPR_TELK').AsString := 'N';
  if IS_TELK in logPreg then
    ibsql.ParamByName('IS_TELK').AsString := 'Y'
  else
    ibsql.ParamByName('IS_TELK').AsString := 'N';
  if IS_EXPERTIZA in logPreg then
    ibsql.ParamByName('IS_EXPERTIZA').AsString := 'Y'
  else
    ibsql.ParamByName('IS_EXPERTIZA').AsString := 'N';
  if IS_RECEPTA_HOSPIT in logPreg then
    ibsql.ParamByName('IS_RECEPTA_HOSPIT').AsString := 'Y'
  else
    ibsql.ParamByName('IS_RECEPTA_HOSPIT').AsString := 'N';
  if IS_REHABILITATION in logPreg then
    ibsql.ParamByName('IS_REHABILITATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_REHABILITATION').AsString := 'N';
  if IS_HOSPITALIZATION in logPreg then
    ibsql.ParamByName('IS_HOSPITALIZATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_HOSPITALIZATION').AsString := 'N';
  if IS_EPIKRIZA in logPreg then
    ibsql.ParamByName('IS_EPIKRIZA').AsString := 'Y'
  else
    ibsql.ParamByName('IS_EPIKRIZA').AsString := 'N';
  if IS_NOTIFICATION in logPreg then
    ibsql.ParamByName('IS_NOTIFICATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_NOTIFICATION').AsString := 'N';
  if IS_OPERATION in logPreg then
    ibsql.ParamByName('IS_OPERATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_OPERATION').AsString := 'N';
  if IS_MANIPULATION in logPreg then
    ibsql.ParamByName('IS_MANIPULATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_MANIPULATION').AsString := 'N';
  if IS_ANALYSIS in logPreg then
    ibsql.ParamByName('IS_ANALYSIS').AsString := 'Y'
  else
    ibsql.ParamByName('IS_ANALYSIS').AsString := 'N';
  if IS_CONSULTATION in logPreg then
    ibsql.ParamByName('IS_CONSULTATION').AsString := 'Y'
  else
    ibsql.ParamByName('IS_CONSULTATION').AsString := 'N';
  if IS_PREVENTIVE in logPreg then
    ibsql.ParamByName('IS_PREVENTIVE').AsString := 'Y'
  else
    ibsql.ParamByName('IS_PREVENTIVE').AsString := 'N';
  if IS_EMERGENCY in logPreg then
    ibsql.ParamByName('IS_EMERGENCY').AsString := 'Y'
  else
    ibsql.ParamByName('IS_EMERGENCY').AsString := 'N';
  if IS_NO_DELAY in logPreg then
    ibsql.ParamByName('IS_NO_DELAY').AsString := 'Y'
  else
    ibsql.ParamByName('IS_NO_DELAY').AsString := 'N';
  if IS_DISPANSERY in logPreg then
    ibsql.ParamByName('IS_DISPANSERY').AsString := 'Y'
  else
    ibsql.ParamByName('IS_DISPANSERY').AsString := 'N';
  if IS_VSD in logPreg then
    ibsql.ParamByName('IS_VSD').AsString := 'Y'
  else
    ibsql.ParamByName('IS_VSD').AsString := 'N';
  if IS_NAET in logPreg then
    ibsql.ParamByName('IS_NAET').AsString := 'Y'
  else
    ibsql.ParamByName('IS_NAET').AsString := 'N';
  if IS_ZAMESTVASHT in logPreg then
    ibsql.ParamByName('IS_ZAMESTVASHT').AsString := 'Y'
  else
    ibsql.ParamByName('IS_ZAMESTVASHT').AsString := 'N';
  if IS_PODVIZHNO_LZ in logPreg then
    ibsql.ParamByName('IS_PODVIZHNO_LZ').AsString := 'Y'
  else
    ibsql.ParamByName('IS_PODVIZHNO_LZ').AsString := 'N';
  if TO_BE_DISPANSERED in logPreg then
    ibsql.ParamByName('TO_BE_DISPANSERED').AsString := 'Y'
  else
    ibsql.ParamByName('TO_BE_DISPANSERED').AsString := 'N';
  if IS_MEDBELEJKA in logPreg then
    ibsql.ParamByName('IS_MEDBELEJKA').AsString := 'Y'
  else
    ibsql.ParamByName('IS_MEDBELEJKA').AsString := 'N';
  if IS_NEW in logPreg then
    ibsql.ParamByName('IS_NEW').AsString := 'Y'
  else
    ibsql.ParamByName('IS_NEW').AsString := 'N';
  if IS_FORM_VALID in logPreg then
    ibsql.ParamByName('IS_FORM_VALID').AsString := 'Y'
  else
    ibsql.ParamByName('IS_FORM_VALID').AsString := 'N';
  if IS_BABY_CARE in logPreg then
    ibsql.ParamByName('IS_BABY_CARE').AsString := 'Y'
  else
    ibsql.ParamByName('IS_BABY_CARE').AsString := 'N';

  if IS_AMB_PR in logPreg then
  begin
    ibsql.ParamByName('DOM_PR').Clear;
    if TLogicalPregledNew.IS_PRIMARY  in logPreg then
      ibsql.ParamByName('AMB_PR').AsInteger := 1
    else
      ibsql.ParamByName('AMB_PR').AsInteger := 2
  end
  else
  begin
    ibsql.ParamByName('AMB_PR').Clear;
    if TLogicalPregledNew.IS_PRIMARY  in logPreg then
      ibsql.ParamByName('DOM_PR').AsInteger := 1
    else
      ibsql.ParamByName('DOM_PR').AsInteger := 2
  end;





  ibsql.ExecQuery;
  ibsql.Transaction.CommitRetaining;

end;

procedure TDbHelper.UpdateDiagInPreg(diag: TRealDiagnosisItem; TempItem: TRealPregledNewItem; rank: word);
var
  pCardinalData: PCardinal;
  dataposition, datPos, linkpos: Cardinal;
  buf: Pointer;
  TreeLink, test: PVirtualNode;
  data: PAspRec;
  cmdStream: TCommandStream;
  bt, Bttest: array[0..63] of Byte;
  bts: TBytes;
  tempPos: Cardinal;

  MainMkb: string;
  MAIN_DIAG_MKB_ADD: string;
begin
  buf := Self.AdbHip.Buf;
  datPos := Self.AdbHip.FPosData;
  case rank of
    0:
    begin
      MainMkb := TempItem.MainMKB;
      MAIN_DIAG_MKB_ADD := TempItem.MAIN_DIAG_MKB_ADD;
    end;
    1:
    begin
      MainMkb := TempItem.MainMKB1;
      MAIN_DIAG_MKB_ADD := TempItem.MAIN_DIAG_MKB_ADD1;
    end;
    2:
    begin
      MainMkb := TempItem.MainMKB2;
      MAIN_DIAG_MKB_ADD := TempItem.MAIN_DIAG_MKB_ADD2;
    end;
    3:
    begin
      MainMkb := TempItem.MainMKB3;
      MAIN_DIAG_MKB_ADD := TempItem.MAIN_DIAG_MKB_ADD3;
    end;
    4:
    begin
      MainMkb := TempItem.MainMKB4;
      MAIN_DIAG_MKB_ADD := TempItem.MAIN_DIAG_MKB_ADD4;
    end;
  end;

  if diag = nil then
  begin
    // diag e nil, ако и MainMkb е нищо, то значи, че нищо не трябва да се прави
    if MainMkb = '' then Exit;

    diag := TRealDiagnosisItem.Create(CollDiag);
    diag.MainMkb := '';
    diag.AddMkb := '';
    diag.rank := rank;
    diag.DataPos := 0;
  end
  else
  begin
    diag.MainMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
    diag.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
    diag.rank := rank;
  end;
  if MainMkb <> diag.MainMkb then
  begin
    if MainMkb <> '' then
    begin
      New(diag.PRecord);
      diag.PRecord.setProp := [];
      diag.PRecord.code_CL011 := MainMKB;
      Include(diag.PRecord.setProp, Diagnosis_code_CL011);
    end
    else //  тука вкарвам логиката, че ако няма основна диагноза, то няма никаква. Маркирам я за изтрита
    begin
      diag.MarkDelete;
      diag.IsDeleted := True;
    end;
  end;
  if MAIN_DIAG_MKB_ADD <> diag.AddMkb then
  begin
    if diag.PRecord = nil then
    begin
      New(diag.PRecord);
      diag.PRecord.setProp := [];
    end;
    diag.PRecord.additionalCode_CL011 := MAIN_DIAG_MKB_ADD;
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
  end;
  if diag.DataPos = 0 then // добавена диагноза. Трябва да се сложи и в линк-а
  begin
    diag.PRecord.rank := rank;
    Include(diag.PRecord.setProp, Diagnosis_rank);
    diag.InsertDiagnosis;
    CollDiag.streamComm.Len := CollDiag.streamComm.Size;
    CmdFile.CopyFrom(CollDiag.streamComm, 0);// това е за диагнозата
    Dispose(diag.PRecord);
    diag.PRecord := nil;

    pCardinalData := pointer(PByte(AdbLink.buf));// взима се края на дървото, после се бележи по-долу
    linkpos := pCardinalData^;
    TreeLink := pointer(PByte(AdbLink.Buf) + linkpos);
    data := pointer(PByte(AdbLink.Buf) + linkpos + lenNode);
    data.DataPos := diag.DataPos;
    data.vid := vvDiag;
    data.index := -1;
    inc(linkpos, LenData); // трябва да се отбележи в хедъра на линк файла
    pCardinalData := pointer(PByte(AdbLink.Buf));
    pCardinalData^ := linkpos;

    TreeLink.TotalCount := 1;
    TreeLink.TotalHeight := 27;
    TreeLink.NodeHeight := 27;
    TreeLink.States := [vsVisible];
    TreeLink.Align := 50;
    TreeLink.Dummy := 0;
    vtr.InitNode(TreeLink);
    vtr.InternalConnectNode_cmd(TreeLink, TempItem.FNode, vtr, amAddChildLast, CmdFile);
  end
  else
  begin
    if (diag.PRecord <> nil)  then
    begin
      diag.SaveDiagnosis(buf, dataPosition);
      CollDiag.streamComm.Len := CollDiag.streamComm.Size;
      CmdFile.CopyFrom(CollDiag.streamComm, 0);
      pCardinalData := pointer(PByte(buf) + 12);
      pCardinalData^  := dataPosition - datPos;
    end;
    if diag.IsDeleted then
    begin
      FillMemory(@bt, LenData, 0);
      CopyMemory(@bt, diag.Node, LenData );
      vtr.InternalDisconnectNode(diag.Node, true);
      cmdStream := TCommandStream.Create;
      cmdStream.OpType := toDeleteNode;
      cmdStream.Size := 10 + LenData ; //  delNode
      cmdStream.Ver := 0;
      cmdStream.Vid := ctLink;
      cmdStream.DataPos := cardinal(AdbLink.Buf);// тука това е буфера на настящето дърво
      cmdStream.Propertys := [];
      cmdStream.Position := 10;
      cmdStream.Write(bt, LenData);

      cmdStream.Len := cmdStream.Size;
      CmdFile.CopyFrom(cmdStream, 0);
      cmdStream.Free;
    end;
  end;
end;

procedure TDbHelper.UpdateExamAnalField(ibsql: TIBSQL; TempItem: TRealExamAnalysisItem);
var
    ibsqlExamAnalysis: TIBSQL;
    data: PAspRec;
    dataPosition: Cardinal;
    buf: Pointer;
    datPos, linkPos: Cardinal;
    pCardinalData: PCardinal;
  begin
    ibsqlExamAnalysis := ibsql;
    buf := AdbHip.Buf;
    datPos := AdbHip.FPosData;

    if (not ibsqlExamAnalysis.Fields[0].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(ExamAnalysis_ANALYSIS_ID))<>ibsqlExamAnalysis.Fields[0].AsInteger)
    then
    begin
      TempItem.PRecord.ANALYSIS_ID := ibsqlExamAnalysis.Fields[0].AsInteger;
      Include(TempItem.PRecord.setProp, ExamAnalysis_ANALYSIS_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[1].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_BLANKA_MDN_ID))<>ibsqlExamAnalysis.Fields[1].AsInteger)
    then
    begin
       TempItem.PRecord.BLANKA_MDN_ID := ibsqlExamAnalysis.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_BLANKA_MDN_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[2].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamAnalysis_DATA))<>ibsqlExamAnalysis.Fields[2].AsDate)
    then
    begin
      TempItem.PRecord.DATA := ibsqlExamAnalysis.Fields[2].AsDate;
      Include(TempItem.PRecord.setProp, ExamAnalysis_DATA);
    end;
    if (not ibsqlExamAnalysis.Fields[3].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_EMDN_ID))<>ibsqlExamAnalysis.Fields[3].AsInteger)
    then
    begin
       TempItem.PRecord.EMDN_ID := ibsqlExamAnalysis.Fields[3].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_EMDN_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[4].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_ID))<>ibsqlExamAnalysis.Fields[4].AsInteger)
    then
    begin
       TempItem.PRecord.ID := ibsqlExamAnalysis.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[5].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamAnalysis_NZIS_CODE_CL22))<>ibsqlExamAnalysis.Fields[5].AsString)
    then
    begin
      TempItem.PRecord.NZIS_CODE_CL22 := ibsqlExamAnalysis.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_NZIS_CODE_CL22);
    end;
    if (not ibsqlExamAnalysis.Fields[6].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamAnalysis_NZIS_DESCRIPTION_CL22))<>ibsqlExamAnalysis.Fields[6].AsString)
    then
    begin
      TempItem.PRecord.NZIS_DESCRIPTION_CL22 := ibsqlExamAnalysis.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_NZIS_DESCRIPTION_CL22);
    end;
    if (not ibsqlExamAnalysis.Fields[7].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_PREGLED_ID))<>ibsqlExamAnalysis.Fields[7].AsInteger)
    then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlExamAnalysis.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, ExamAnalysis_PREGLED_ID);
    end;
    if (not ibsqlExamAnalysis.Fields[8].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamAnalysis_RESULT))<>ibsqlExamAnalysis.Fields[8].AsString)
    then
    begin
      TempItem.PRecord.RESULT := ibsqlExamAnalysis.Fields[8].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_RESULT);
    end;
  end;

procedure TDbHelper.UpdateExamImunField(ibsql: TIBSQL; TempItem: TRealExamImmunizationItem);
var
    ibsqlExamImmunization: TIBSQL;
    data: PAspRec;
    dataPosition: Cardinal;
    buf: Pointer;
    datPos, linkPos: Cardinal;
    pCardinalData: PCardinal;
  begin
    ibsqlExamImmunization := ibsql;
    buf := AdbHip.Buf;
    datPos := AdbHip.FPosData;

    if (not ibsqlExamImmunization.Fields[0].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_BASE_ON))<>ibsqlExamImmunization.Fields[0].AsString)
    then
    begin
      TempItem.PRecord.BASE_ON := ibsqlExamImmunization.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_BASE_ON);
    end;
    if (not ibsqlExamImmunization.Fields[1].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_BOOSTER))<>ibsqlExamImmunization.Fields[1].AsInteger)
    then
    begin
       TempItem.PRecord.BOOSTER := ibsqlExamImmunization.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_BOOSTER);
    end;
    if (not ibsqlExamImmunization.Fields[2].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_CERTIFICATE_NAME))<>ibsqlExamImmunization.Fields[2].AsString)
    then
    begin
      TempItem.PRecord.CERTIFICATE_NAME := ibsqlExamImmunization.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_CERTIFICATE_NAME);
    end;
    if (not ibsqlExamImmunization.Fields[3].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamImmunization_DATA))<>ibsqlExamImmunization.Fields[3].AsDate)
    then
    begin
      TempItem.PRecord.DATA := ibsqlExamImmunization.Fields[3].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_DATA);
    end;
    if (not ibsqlExamImmunization.Fields[4].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_DOCTOR_NAME))<>ibsqlExamImmunization.Fields[4].AsString)
    then
    begin
      TempItem.PRecord.DOCTOR_NAME := ibsqlExamImmunization.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_DOCTOR_NAME);
    end;
    if (not ibsqlExamImmunization.Fields[5].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_DOCTOR_UIN))<>ibsqlExamImmunization.Fields[5].AsString)
    then
    begin
      TempItem.PRecord.DOCTOR_UIN := ibsqlExamImmunization.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_DOCTOR_UIN);
    end;
    if (not ibsqlExamImmunization.Fields[6].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_DOSE))<>ibsqlExamImmunization.Fields[6].AsString)
    then
    begin
      TempItem.PRecord.DOSE := ibsqlExamImmunization.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_DOSE);
    end;
    if (not ibsqlExamImmunization.Fields[7].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_DOSE_NUMBER))<>ibsqlExamImmunization.Fields[7].AsInteger)
    then
    begin
       TempItem.PRecord.DOSE_NUMBER := ibsqlExamImmunization.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_DOSE_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[8].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_DOSE_QUANTITY))<>ibsqlExamImmunization.Fields[8].AsInteger)
    then
    begin
       TempItem.PRecord.DOSE_QUANTITY := ibsqlExamImmunization.Fields[8].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_DOSE_QUANTITY);
    end;
    if (not ibsqlExamImmunization.Fields[9].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamImmunization_EXPIRATION_DATE))<>ibsqlExamImmunization.Fields[9].AsDate)
    then
    begin
      TempItem.PRecord.EXPIRATION_DATE := ibsqlExamImmunization.Fields[9].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXPIRATION_DATE);
    end;
    if (not ibsqlExamImmunization.Fields[10].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_AUTHORITY))<>ibsqlExamImmunization.Fields[10].AsString)
    then
    begin
      TempItem.PRecord.EXT_AUTHORITY := ibsqlExamImmunization.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_AUTHORITY);
    end;
    if (not ibsqlExamImmunization.Fields[11].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_COUNTRY))<>ibsqlExamImmunization.Fields[11].AsString)
    then
    begin
      TempItem.PRecord.EXT_COUNTRY := ibsqlExamImmunization.Fields[11].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_COUNTRY);
    end;
    if (not ibsqlExamImmunization.Fields[12].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_LOT_NUMBER))<>ibsqlExamImmunization.Fields[12].AsString)
    then
    begin
      TempItem.PRecord.EXT_LOT_NUMBER := ibsqlExamImmunization.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_LOT_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[13].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamImmunization_EXT_OCCURRENCE))<>ibsqlExamImmunization.Fields[13].AsDate)
    then
    begin
      TempItem.PRecord.EXT_OCCURRENCE := ibsqlExamImmunization.Fields[13].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_OCCURRENCE);
    end;
    if (not ibsqlExamImmunization.Fields[14].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_EXT_PREV_IMMUNIZATION))<>ibsqlExamImmunization.Fields[14].AsInteger)
    then
    begin
       TempItem.PRecord.EXT_PREV_IMMUNIZATION := ibsqlExamImmunization.Fields[14].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_EXT_PREV_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[15].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_SERIAL_NUMBER))<>ibsqlExamImmunization.Fields[15].AsString)
    then
    begin
      TempItem.PRecord.EXT_SERIAL_NUMBER := ibsqlExamImmunization.Fields[15].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_SERIAL_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[16].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_VACCINE_ATC))<>ibsqlExamImmunization.Fields[16].AsString)
    then
    begin
      TempItem.PRecord.EXT_VACCINE_ATC := ibsqlExamImmunization.Fields[16].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_VACCINE_ATC);
    end;
    if (not ibsqlExamImmunization.Fields[17].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_VACCINE_INN))<>ibsqlExamImmunization.Fields[17].AsString)
    then
    begin
      TempItem.PRecord.EXT_VACCINE_INN := ibsqlExamImmunization.Fields[17].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_VACCINE_INN);
    end;
    if (not ibsqlExamImmunization.Fields[18].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_EXT_VACCINE_NAME))<>ibsqlExamImmunization.Fields[18].AsString)
    then
    begin
      TempItem.PRecord.EXT_VACCINE_NAME := ibsqlExamImmunization.Fields[18].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_EXT_VACCINE_NAME);
    end;
    if (not ibsqlExamImmunization.Fields[19].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_ID))<>ibsqlExamImmunization.Fields[19].AsInteger)
    then
    begin
       TempItem.PRecord.ID := ibsqlExamImmunization.Fields[19].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_ID);
    end;
    if (not ibsqlExamImmunization.Fields[20].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(ExamImmunization_IMMUNIZATION_ID))<>ibsqlExamImmunization.Fields[20].AsInteger)
    then
    begin
      TempItem.PRecord.IMMUNIZATION_ID := ibsqlExamImmunization.Fields[20].AsInteger;
      Include(TempItem.PRecord.setProp, ExamImmunization_IMMUNIZATION_ID);
    end;
    if (not ibsqlExamImmunization.Fields[21].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_IMMUNIZATION_STATUS))<>ibsqlExamImmunization.Fields[21].AsInteger)
    then
    begin
       TempItem.PRecord.IMMUNIZATION_STATUS := ibsqlExamImmunization.Fields[21].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_IMMUNIZATION_STATUS);
    end;
    if (not ibsqlExamImmunization.Fields[22].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_IS_SPECIAL_CASE))<>ibsqlExamImmunization.Fields[22].AsInteger)
    then
    begin
       TempItem.PRecord.IS_SPECIAL_CASE := ibsqlExamImmunization.Fields[22].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_IS_SPECIAL_CASE);
    end;
    if (not ibsqlExamImmunization.Fields[23].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_LOT_NUMBER))<>ibsqlExamImmunization.Fields[23].AsString)
    then
    begin
      TempItem.PRecord.LOT_NUMBER := ibsqlExamImmunization.Fields[23].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_LOT_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[24].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_LRN))<>ibsqlExamImmunization.Fields[24].AsString)
    then
    begin
      TempItem.PRecord.LRN := ibsqlExamImmunization.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_LRN);
    end;
    if (not ibsqlExamImmunization.Fields[25].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamImmunization_NEXT_DOSE_DATE))<>ibsqlExamImmunization.Fields[25].AsDate)
    then
    begin
      TempItem.PRecord.NEXT_DOSE_DATE := ibsqlExamImmunization.Fields[25].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_NEXT_DOSE_DATE);
    end;
    if (not ibsqlExamImmunization.Fields[26].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_NOTE))<>ibsqlExamImmunization.Fields[26].AsString)
    then
    begin
      TempItem.PRecord.NOTE := ibsqlExamImmunization.Fields[26].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_NOTE);
    end;
    if (not ibsqlExamImmunization.Fields[27].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_NRN_IMMUNIZATION))<>ibsqlExamImmunization.Fields[27].AsString)
    then
    begin
      TempItem.PRecord.NRN_IMMUNIZATION := ibsqlExamImmunization.Fields[27].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_NRN_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[28].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_NRN_PREV_IMMUNIZATION))<>ibsqlExamImmunization.Fields[28].AsString)
    then
    begin
      TempItem.PRecord.NRN_PREV_IMMUNIZATION := ibsqlExamImmunization.Fields[28].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_NRN_PREV_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[29].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE))<>ibsqlExamImmunization.Fields[29].AsDate)
    then
    begin
      TempItem.PRecord.PERSON_STATUS_CHANGE_ON_DATE := ibsqlExamImmunization.Fields[29].AsDate;
      Include(TempItem.PRecord.setProp, ExamImmunization_PERSON_STATUS_CHANGE_ON_DATE);
    end;
    if (not ibsqlExamImmunization.Fields[30].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_PERSON_STATUS_CHANGE_REASON))<>ibsqlExamImmunization.Fields[30].AsString)
    then
    begin
      TempItem.PRecord.PERSON_STATUS_CHANGE_REASON := ibsqlExamImmunization.Fields[30].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_PERSON_STATUS_CHANGE_REASON);
    end;
    if (not ibsqlExamImmunization.Fields[31].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_PREGLED_ID))<>ibsqlExamImmunization.Fields[31].AsInteger)
    then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlExamImmunization.Fields[31].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_PREGLED_ID);
    end;
    if (not ibsqlExamImmunization.Fields[32].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_PRIMARY_SOURCE))<>ibsqlExamImmunization.Fields[32].AsInteger)
    then
    begin
       TempItem.PRecord.PRIMARY_SOURCE := ibsqlExamImmunization.Fields[32].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_PRIMARY_SOURCE);
    end;
    if (not ibsqlExamImmunization.Fields[33].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_QUALIFICATION))<>ibsqlExamImmunization.Fields[33].AsString)
    then
    begin
      TempItem.PRecord.QUALIFICATION := ibsqlExamImmunization.Fields[33].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_QUALIFICATION);
    end;
    if (not ibsqlExamImmunization.Fields[34].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION))<>ibsqlExamImmunization.Fields[34].AsString)
    then
    begin
      TempItem.PRecord.REASON_TO_CANCEL_IMMUNIZATION := ibsqlExamImmunization.Fields[34].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_REASON_TO_CANCEL_IMMUNIZATION);
    end;
    if (not ibsqlExamImmunization.Fields[35].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_RESULT))<>ibsqlExamImmunization.Fields[35].AsString)
    then
    begin
      TempItem.PRecord.RESULT := ibsqlExamImmunization.Fields[35].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_RESULT);
    end;
    if (not ibsqlExamImmunization.Fields[36].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_ROUTE))<>ibsqlExamImmunization.Fields[36].AsString)
    then
    begin
      TempItem.PRecord.ROUTE := ibsqlExamImmunization.Fields[36].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_ROUTE);
    end;
    if (not ibsqlExamImmunization.Fields[37].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_SERIAL_NUMBER))<>ibsqlExamImmunization.Fields[37].AsString)
    then
    begin
      TempItem.PRecord.SERIAL_NUMBER := ibsqlExamImmunization.Fields[37].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_SERIAL_NUMBER);
    end;
    if (not ibsqlExamImmunization.Fields[38].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_SERIES))<>ibsqlExamImmunization.Fields[38].AsString)
    then
    begin
      TempItem.PRecord.SERIES := ibsqlExamImmunization.Fields[38].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_SERIES);
    end;
    if (not ibsqlExamImmunization.Fields[39].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_SERIES_DOSES))<>ibsqlExamImmunization.Fields[39].AsInteger)
    then
    begin
       TempItem.PRecord.SERIES_DOSES := ibsqlExamImmunization.Fields[39].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_SERIES_DOSES);
    end;
    if (not ibsqlExamImmunization.Fields[40].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_SITE))<>ibsqlExamImmunization.Fields[40].AsString)
    then
    begin
      TempItem.PRecord.SITE := ibsqlExamImmunization.Fields[40].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_SITE);
    end;
    if (not ibsqlExamImmunization.Fields[41].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_SOCIAL_GROUP))<>ibsqlExamImmunization.Fields[41].AsInteger)
    then
    begin
       TempItem.PRecord.SOCIAL_GROUP := ibsqlExamImmunization.Fields[41].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_SOCIAL_GROUP);
    end;
    if (not ibsqlExamImmunization.Fields[42].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_SUBJECT_STATUS))<>ibsqlExamImmunization.Fields[42].AsInteger)
    then
    begin
       TempItem.PRecord.SUBJECT_STATUS := ibsqlExamImmunization.Fields[42].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_SUBJECT_STATUS);
    end;
    if (not ibsqlExamImmunization.Fields[43].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_UPDATED))<>ibsqlExamImmunization.Fields[43].AsInteger)
    then
    begin
       TempItem.PRecord.UPDATED := ibsqlExamImmunization.Fields[43].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_UPDATED);
    end;
    if (not ibsqlExamImmunization.Fields[44].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(ExamImmunization_UVCI))<>ibsqlExamImmunization.Fields[44].AsString)
    then
    begin
      TempItem.PRecord.UVCI := ibsqlExamImmunization.Fields[44].AsString;
      Include(TempItem.PRecord.setProp, ExamImmunization_UVCI);
    end;
    if (not ibsqlExamImmunization.Fields[45].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(ExamImmunization_VACCINE_ID))<>ibsqlExamImmunization.Fields[45].AsInteger)
    then
    begin
       TempItem.PRecord.VACCINE_ID := ibsqlExamImmunization.Fields[45].AsInteger;
       Include(TempItem.PRecord.setProp, ExamImmunization_VACCINE_ID);
    end;
  end;

procedure TDbHelper.UpdatePregledField(ibsql: TIBSQL; TempItem: TRealPregledNewItem);
var
    ibsqlPregledNew: TIBSQL;
    diagNode, TreeLink: PVirtualNode;
    data: PAspRec;
    diag, diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem;
    dataPosition: Cardinal;
    buf: Pointer;
    datPos, linkPos: Cardinal;
    pCardinalData: PCardinal;
  begin
    ibsqlPregledNew := ibsql;
    buf := AdbHip.Buf;
    datPos := AdbHip.FPosData;

    if (not ibsqlPregledNew.Fields[0].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(PregledNew_AMB_LISTN))<>ibsqlPregledNew.Fields[0].AsInteger)
    then
    begin
       TempItem.PRecord.AMB_LISTN := ibsqlPregledNew.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_AMB_LISTN);
    end;
    if (not ibsqlPregledNew.Fields[1].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_ANAMN))<>ibsqlPregledNew.Fields[1].AsString)
    then
    begin
      TempItem.PRecord.ANAMN := ibsqlPregledNew.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_ANAMN);
    end;
    if (not ibsqlPregledNew.Fields[2].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_COPIED_FROM_NRN))<>ibsqlPregledNew.Fields[2].AsString)
    then
    begin
      TempItem.PRecord.COPIED_FROM_NRN := ibsqlPregledNew.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_COPIED_FROM_NRN);
    end;
    if (not ibsqlPregledNew.Fields[3].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_GS))<>ibsqlPregledNew.Fields[3].AsInteger)
    then
    begin
      TempItem.PRecord.GS := ibsqlPregledNew.Fields[3].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_GS);
    end;
    if (not ibsqlPregledNew.Fields[4].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(PregledNew_ID))<>ibsqlPregledNew.Fields[4].AsInteger)
    then
    begin
       TempItem.PRecord.ID := ibsqlPregledNew.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_ID);
    end;
    if (not ibsqlPregledNew.Fields[5].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_IZSL))<>ibsqlPregledNew.Fields[5].AsString)
    then
    begin
      TempItem.PRecord.IZSL := ibsqlPregledNew.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_IZSL);
    end;
    if (not ibsqlPregledNew.Fields[6].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(PregledNew_MEDTRANSKM))<>ibsqlPregledNew.Fields[6].AsInteger)
    then
    begin
       TempItem.PRecord.MEDTRANSKM := ibsqlPregledNew.Fields[6].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_MEDTRANSKM);
    end;
    if (not ibsqlPregledNew.Fields[7].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_NAPRAVLENIE_AMBL_NOMER))<>ibsqlPregledNew.Fields[7].AsString)
    then
    begin
      TempItem.PRecord.NAPRAVLENIE_AMBL_NOMER := ibsqlPregledNew.Fields[7].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NAPRAVLENIE_AMBL_NOMER);
    end;
    if (not ibsqlPregledNew.Fields[8].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_NAPR_TYPE_ID))<>ibsqlPregledNew.Fields[8].AsInteger)
    then
    begin
      TempItem.PRecord.NAPR_TYPE_ID := ibsqlPregledNew.Fields[8].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_NAPR_TYPE_ID);
    end;
    if (not ibsqlPregledNew.Fields[9].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_NOMERBELEGKA))<>ibsqlPregledNew.Fields[9].AsString)
    then
    begin
      TempItem.PRecord.NOMERBELEGKA := ibsqlPregledNew.Fields[9].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NOMERBELEGKA);
    end;
    if (not ibsqlPregledNew.Fields[10].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_NOMERKASHAPARAT))<>ibsqlPregledNew.Fields[10].AsString)
    then
    begin
      TempItem.PRecord.NOMERKASHAPARAT := ibsqlPregledNew.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NOMERKASHAPARAT);
    end;
    if (not ibsqlPregledNew.Fields[11].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_NRD))<>ibsqlPregledNew.Fields[11].AsInteger)
    then
    begin
      TempItem.PRecord.NRD := ibsqlPregledNew.Fields[11].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_NRD);
    end;
    if (not ibsqlPregledNew.Fields[12].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_NRN))<>ibsqlPregledNew.Fields[12].AsString)
    then
    begin
      TempItem.PRecord.NRN_LRN := ibsqlPregledNew.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NRN);
    end;
    if (not ibsqlPregledNew.Fields[13].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_NZIS_STATUS))<>ibsqlPregledNew.Fields[13].AsInteger)
    then
    begin
      TempItem.PRecord.NZIS_STATUS := ibsqlPregledNew.Fields[13].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_NZIS_STATUS);
    end;
    if (not ibsqlPregledNew.Fields[14].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_OBSHTAPR))<>ibsqlPregledNew.Fields[14].AsInteger)
    then
    begin
      TempItem.PRecord.OBSHTAPR := ibsqlPregledNew.Fields[14].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_OBSHTAPR);
    end;
    if (not ibsqlPregledNew.Fields[15].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_PATIENTOF_NEOTL))<>ibsqlPregledNew.Fields[15].AsString)
    then
    begin
      TempItem.PRecord.PATIENTOF_NEOTL := ibsqlPregledNew.Fields[15].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_PATIENTOF_NEOTL);
    end;
    if (not ibsqlPregledNew.Fields[16].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(PregledNew_PATIENTOF_NEOTLID))<>ibsqlPregledNew.Fields[16].AsInteger)
    then
    begin
       TempItem.PRecord.PATIENTOF_NEOTLID := ibsqlPregledNew.Fields[16].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_PATIENTOF_NEOTLID);
    end;
    if (not ibsqlPregledNew.Fields[17].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_PREVENTIVE_TYPE))<>ibsqlPregledNew.Fields[17].AsInteger)
    then
    begin
      TempItem.PRecord.PREVENTIVE_TYPE := ibsqlPregledNew.Fields[17].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_PREVENTIVE_TYPE);
    end;
    if (not ibsqlPregledNew.Fields[18].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(PregledNew_REH_FINISHED_AT))<>ibsqlPregledNew.Fields[18].AsDate)
    then
    begin
      TempItem.PRecord.REH_FINISHED_AT := ibsqlPregledNew.Fields[18].AsDate;
      Include(TempItem.PRecord.setProp, PregledNew_REH_FINISHED_AT);
    end;
    if (not ibsqlPregledNew.Fields[19].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(PregledNew_START_DATE))<>ibsqlPregledNew.Fields[19].AsDate)
    then
    begin

      TempItem.PRecord.START_DATE := ibsqlPregledNew.Fields[19].AsDate;
      Include(TempItem.PRecord.setProp, PregledNew_START_DATE);
    end;
    if (not ibsqlPregledNew.Fields[20].IsNull)
        and (TempItem.getTimeMap(buf, datPos, word(PregledNew_START_TIME))<>ibsqlPregledNew.Fields[20].AsTime)
    then
    begin
      TempItem.PRecord.START_TIME := ibsqlPregledNew.Fields[20].AsTime;
      Include(TempItem.PRecord.setProp, PregledNew_START_TIME);
    end;
    if (not ibsqlPregledNew.Fields[21].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_SYST))<>ibsqlPregledNew.Fields[21].AsString)
    then
    begin
      TempItem.PRecord.SYST := ibsqlPregledNew.Fields[21].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_SYST);
    end;
    if (not ibsqlPregledNew.Fields[22].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_TALON_LKK))<>ibsqlPregledNew.Fields[22].AsString)
    then
    begin
      TempItem.PRecord.TALON_LKK := ibsqlPregledNew.Fields[22].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_TALON_LKK);
    end;
    if (not ibsqlPregledNew.Fields[23].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_TERAPY))<>ibsqlPregledNew.Fields[23].AsString)
    then
    begin
      TempItem.PRecord.TERAPY := ibsqlPregledNew.Fields[23].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_TERAPY);
    end;
    if (not ibsqlPregledNew.Fields[24].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_THREAD_IDS))<>ibsqlPregledNew.Fields[24].AsString)
    then
    begin
      TempItem.PRecord.THREAD_IDS := ibsqlPregledNew.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_THREAD_IDS);
    end;
    if (not ibsqlPregledNew.Fields[25].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(PregledNew_VISIT_ID))<>ibsqlPregledNew.Fields[25].AsInteger)
    then
    begin
       TempItem.PRecord.VISIT_ID := ibsqlPregledNew.Fields[25].AsInteger;
       Include(TempItem.PRecord.setProp, PregledNew_VISIT_ID);
    end;
    if (not ibsqlPregledNew.Fields[26].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_VISIT_TYPE_ID))<>ibsqlPregledNew.Fields[26].AsInteger)
    then
    begin
      TempItem.PRecord.VISIT_TYPE_ID := ibsqlPregledNew.Fields[26].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_VISIT_TYPE_ID);
    end;
    if (not ibsqlPregledNew.Fields[27].IsNull)
        and (TempItem.getWordMap(buf, datPos, word(PregledNew_VSD_TYPE))<>ibsqlPregledNew.Fields[27].AsInteger)
    then
    begin
      TempItem.PRecord.VSD_TYPE := ibsqlPregledNew.Fields[27].AsInteger;
      Include(TempItem.PRecord.setProp, PregledNew_VSD_TYPE);
    end;

    TempItem.PregledID := ibsqlPregledNew.Fields[4].AsInteger;
    TempItem.PatID := ibsqlPregledNew.Fields[28].AsInteger;
    TempItem.StartDate := ibsqlPregledNew.Fields[19].AsDate;

    TempItem.MainMKB := ibsqlPregledNew.Fields[29].AsString;
    TempItem.MAIN_DIAG_MKB_ADD := ibsqlPregledNew.Fields[30].AsString;
    TempItem.MainMKB1 := ibsqlPregledNew.Fields[31].AsString;
    TempItem.MAIN_DIAG_MKB_ADD1 := ibsqlPregledNew.Fields[32].AsString;
    TempItem.MainMKB2 := ibsqlPregledNew.Fields[33].AsString;
    TempItem.MAIN_DIAG_MKB_ADD2 := ibsqlPregledNew.Fields[34].AsString;
    TempItem.MainMKB3 := ibsqlPregledNew.Fields[35].AsString;
    TempItem.MAIN_DIAG_MKB_ADD3 := ibsqlPregledNew.Fields[36].AsString;
    TempItem.MainMKB4 := ibsqlPregledNew.Fields[37].AsString;
    TempItem.MAIN_DIAG_MKB_ADD4 := ibsqlPregledNew.Fields[38].AsString;
    if buf <> nil then
    begin
      if TempItem.FNode <> nil then
      begin
        diag0 := nil;
        diag1 := nil;
        diag2 := nil;
        diag3 := nil;
        diag4 := nil;
        FindDiagInPregled(TempItem.FNode, diag0, diag1, diag2, diag3, diag4);
        //if TempItem.MainMKB <> '' then
        begin
          UpdateDiagInPreg(diag0, TempItem, 0);
        end;
        //if TempItem.MainMKB1 <> '' then
        begin
          UpdateDiagInPreg(diag1, TempItem, 1);
        end;
        //if TempItem.MainMKB2 <> '' then
        begin
          UpdateDiagInPreg(diag2, TempItem, 2);
        end;
        //if TempItem.MainMKB3 <> '' then
        begin
          UpdateDiagInPreg(diag3, TempItem, 3);
        end;
        //if TempItem.MainMKB4 <> '' then
        begin
          UpdateDiagInPreg(diag4, TempItem, 4);
        end;
      end;
    end;

    TempItem.PRecord.Logical := TlogicalPregledNewSet(TempItem.getLogical40Map(buf, datPos, word(PregledNew_Logical)));

    case ibsqlPregledNew.Fields[39].Asinteger  of
      0:
      begin
        exclude(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
      end;
      1:
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
      end;
      2:
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
        exclude(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
      end;
    end;

    case ibsqlPregledNew.Fields[40].Asinteger  of
      1:
      begin
        Include(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
        exclude(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
      end;
      2:
      begin
        exclude(TempItem.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
        exclude(TempItem.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
      end;
    end;

    if  (buf <> nil) and (TempItem.getLogical32Map(buf, datPos, word(PregledNew_Logical))<> (TLogicalData40(TempItem.PRecord.Logical))) then
    begin
      Include(TempItem.PRecord.setProp, PregledNew_Logical);
    end;

    TempItem.DoctorID := ibsqlPregledNew.Fields[41].Asinteger;

    TempItem.IS_ZAMESTVASHT := ibsqlPregledNew.Fields[42].AsString = 'Y';
    TempItem.IS_NAET := ibsqlPregledNew.Fields[43].AsString = 'Y';
    TempItem.OWNER_DOCTOR_ID := ibsqlPregledNew.Fields[44].Asinteger;
    TempItem.EXAM_BOLN_LIST_ID := ibsqlPregledNew.Fields[45].Asinteger;

  end;

end.
