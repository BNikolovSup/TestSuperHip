unit DbHelper; //date_zapisvane

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, IBX.IBSQL,VirtualStringTreeAspect,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections, DM, Winapi.ActiveX, system.Variants, VirtualTrees,
  Aspects.Types, ProfGraph,
  Table.PatientNew, Table.Doctor, Table.Mkb, table.mdn,
  Table.PregledNew, Table.Unfav, Table.Exam_boln_list,
  RealObj.NzisNomen, ADB_DataUnit,
  RealObj.RealHipp, RealNasMesto, Table.NasMesto, Table.Oblast, Table.Obshtina,
  Aspects.Collections, Table.Diagnosis, Table.ExamAnalysis, Table.Addres,
  table.ExamImmunization, Table.CL132, Table.CL022, Table.KARTA_PROFILAKTIKA2017,
  table.BLANKA_MED_NAPR, Table.BLANKA_MED_NAPR_3A, Table.Practica, Table.INC_MDN,
  Table.HOSPITALIZATION, Table.EXAM_LKK, Table.INC_NAPR, Table.OtherDoctor;

  type
  TDbHelper = class (TObject)
  private



  public

    AdbHip: TMappedFile;
    AdbNomenNzis: TMappedFile;
    AdbLink: TMappedFile;
    cmdFile: TFileStream;
    Vtr: TVirtualStringTreeAspect;
    Fdm: TDUNzis;
    NasMesto: TRealNasMestoAspects;
    Adb_DM: TADBDataModule;
    mkbColl: TRealMkbColl;


    procedure InsertPracticaField(ibsql: TIBSQL; TempItem: TPracticaItem);
    procedure UpdatePracticaField(ibsql: TIBSQL; TempItem: TPracticaItem);
    procedure InsertPregledField(ibsql: TIBSQL; TempItem: TRealPregledNewItem);
    procedure UpdatePregledField(ibsql: TIBSQL; TempItem: TRealPregledNewItem);
    procedure InsertDoctorField(ibsql: TIBSQL; TempItem: TRealDoctorItem);
    procedure UpdateDoctorField(ibsql: TIBSQL; TempItem: TRealDoctorItem);
    procedure InsertPatientField(ibsql: TIBSQL; TempItem: TRealPatientNewItem);
    procedure UpdatePatientField(ibsql: TIBSQL; TempItem: TRealPatientNewItem);
    procedure InsertExamAnalField(ibsql: TIBSQL; TempItem: TRealExamAnalysisItem);
    procedure UpdateExamAnalField(ibsql: TIBSQL; TempItem: TRealExamAnalysisItem);
    procedure InsertExamImunField(ibsql: TIBSQL; TempItem: TRealExamImmunizationItem);
    procedure UpdateExamImunField(ibsql: TIBSQL; TempItem: TRealExamImmunizationItem);
    procedure InsertKardProfField(ibsql: TIBSQL; TempItem: TRealKARTA_PROFILAKTIKA2017Item);
    procedure UpdateKardProfField(ibsql: TIBSQL; TempItem: TRealKARTA_PROFILAKTIKA2017Item);
    procedure InsertMedNaprField(ibsql: TIBSQL; TempItem: TRealBLANKA_MED_NAPRItem);
    procedure InsertMedNapr3AField(ibsql: TIBSQL; TempItem: TRealBLANKA_MED_NAPR_3AItem);
    procedure InsertMedNaprHospField(ibsql: TIBSQL; TempItem: TRealHOSPITALIZATIONItem);
    procedure InsertMedNaprLkkField(ibsql: TIBSQL; TempItem: TRealEXAM_LKKItem);
    procedure InsertIncMdnField(ibsql: TIBSQL; TempItem: TRealINC_MDNItem);
    procedure InsertIncMNField(ibsql: TIBSQL; TempItem: TRealINC_NAPRItem);
    procedure InsertIncDocField(ibsql: TIBSQL; TempItem: TRealOtherDoctorItem);



    procedure InsertEBLField(ibsql: TIBSQL; TempItem: TRealExam_boln_listItem);
    procedure FindDiagInPregled(vPregled: PVirtualNode; var diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem);
    procedure UpdateDiagInPreg(diag: TRealDiagnosisItem; TempItem: TRealPregledNewItem; rank: word);

    //ADB
    procedure InsertAdbPregledField(TempItem: TRealPregledNewItem);
    procedure InsertAdbMdnField(TempItem: TRealMDNItem);
    procedure InsertAdbMnField(TempItem: TRealBLANKA_MED_NAPRItem);

    //saveToHip
    procedure SavePatientFDB(Pat: TRealPatientNewItem; ibsql: TIBSQL);
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
        diag := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
        diag.DataPos := data.DataPos;
        case diag.getWordMap(buf, datPos, word(Diagnosis_rank)) of
          0: //  основна диагноза
          begin
            diag0 := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
            diag0.Node := diagNode;
            diag0.DataPos := data.DataPos;
            diag0.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag0.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag0.Rank := 0;
          end;
          1: // първа придружаваща
          begin
            diag1 := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
            diag1.Node := diagNode;
            diag1.DataPos := data.DataPos;
            diag1.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag1.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag1.Rank := 1;
          end;
          2: // втора придружаваща
          begin
            diag2 := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
            diag2.Node := diagNode;
            diag2.DataPos := data.DataPos;
            diag2.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag2.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag2.Rank := 2;
          end;
          3: // трета придружаваща
          begin
            diag3 := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
            diag3.DataPos := data.DataPos;
            diag3.Node := diagNode;
            diag3.MainMkb := Diag.getAnsiStringMap(buf, datPos, word(Diagnosis_code_CL011));
            diag3.AddMkb := diag.getAnsiStringMap(buf, datPos, word(Diagnosis_additionalCode_CL011));
            diag3.Rank := 3;
          end;
          4: // четвърта придружаваща
          begin
            diag4 := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
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
  TempItem.PRecord.DATA := UserDate;
  Include(TempItem.PRecord.setProp, MDN_DATA);
  TempItem.PRecord.id := 0;
  Include(TempItem.PRecord.setProp, MDN_ID);
end;

procedure TDbHelper.InsertAdbMnField(TempItem: TRealBLANKA_MED_NAPRItem);
begin
  TempItem.PRecord.ISSUE_DATE := UserDate;
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

  TempItem.PRecord.START_TIME := TempItem.StartTime;
  Include(TempItem.PRecord.setProp, PregledNew_START_TIME);

  TempItem.PRecord.AMB_LISTN := 0;
  Include(TempItem.PRecord.setProp, PregledNew_AMB_LISTN);
  // 12 интервала, за запазване на място НРН  и 36 GUID за ЛРН
  CreateGUID(LrnGuId);
  LRN := LrnGuId.ToString;
  LRN := Copy(LRN, 2, 36);
  TempItem.PRecord.NRN_LRN := '            ' + LRN;
  Include(TempItem.PRecord.setProp, PregledNew_NRN_LRN);

  TempItem.PRecord.NZIS_STATUS := 0;
  Include(TempItem.PRecord.setProp, PregledNew_NZIS_STATUS);

end;

procedure TDbHelper.InsertDoctorField(ibsql: TIBSQL; TempItem: TRealDoctorItem);
var
  ibsqlDoctor: TIBSQL;
  data: PAspRec;
  dataPosition: Cardinal;
  iEvn: Integer;
begin
  ibsqlDoctor := ibsql;
    TempItem := TRealDoctorItem(Adb_DM.CollDoctor.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    if not ibsqlDoctor.Fields[0].IsNull then
    begin
      TempItem.PRecord.EGN := ibsqlDoctor.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, Doctor_EGN);
    end;
    if not ibsqlDoctor.Fields[1].IsNull then
    begin
      TempItem.PRecord.FNAME := ibsqlDoctor.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Doctor_FNAME);
    end;
    if not ibsqlDoctor.Fields[2].IsNull then
    begin
       TempItem.PRecord.ID := ibsqlDoctor.Fields[2].AsInteger;
       Include(TempItem.PRecord.setProp, Doctor_ID);
    end;
    if not ibsqlDoctor.Fields[3].IsNull then
    begin
      TempItem.PRecord.LNAME := ibsqlDoctor.Fields[3].AsString;
      Include(TempItem.PRecord.setProp, Doctor_LNAME);
    end;
    if not ibsqlDoctor.Fields[4].IsNull then
    begin
      TempItem.PRecord.SNAME := ibsqlDoctor.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, Doctor_SNAME);
    end;
    if not ibsqlDoctor.Fields[5].IsNull then
    begin
      TempItem.PRecord.UIN := ibsqlDoctor.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, Doctor_UIN);
    end;

    TempItem.DoctorID := ibsqlDoctor.Fields[2].AsInteger;


    TempItem.InsertDoctor;
    Adb_DM.CollDoctor.streamComm.Len := Adb_DM.CollDoctor.streamComm.Size;
    CmdFile.CopyFrom(Adb_DM.CollDoctor.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlDoctor.Next;



  if TempItem.PRecord.Logical <> [] then
    Include(TempItem.PRecord.setProp, Doctor_Logical);

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

   // if (not ibsqlExamAnalysis.Fields[0].IsNull)
//    then
//    begin
//      TempItem.PRecord.ANALYSIS_ID := ibsqlExamAnalysis.Fields[0].AsInteger;
//      Include(TempItem.PRecord.setProp, ExamAnalysis_ANALYSIS_ID);
//    end;
//    if (not ibsqlExamAnalysis.Fields[1].IsNull)
//    then
//    begin
//       TempItem.PRecord.BLANKA_MDN_ID := ibsqlExamAnalysis.Fields[1].AsInteger;
//       Include(TempItem.PRecord.setProp, ExamAnalysis_BLANKA_MDN_ID);
//    end;
    if (not ibsqlExamAnalysis.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.DATA := ibsqlExamAnalysis.Fields[2].AsDate;
      Include(TempItem.PRecord.setProp, ExamAnalysis_DATA);
    end;
    //if (not ibsqlExamAnalysis.Fields[3].IsNull)
//    then
//    begin
//       TempItem.PRecord.EMDN_ID := ibsqlExamAnalysis.Fields[3].AsInteger;
//       Include(TempItem.PRecord.setProp, ExamAnalysis_EMDN_ID);
//    end;
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
    //if (not ibsqlExamAnalysis.Fields[7].IsNull)
//    then
//    begin
//       TempItem.PRecord.PREGLED_ID := ibsqlExamAnalysis.Fields[7].AsInteger;
//       Include(TempItem.PRecord.setProp, ExamAnalysis_PREGLED_ID);
//    end;
    if (not ibsqlExamAnalysis.Fields[8].IsNull)
    then
    begin
      TempItem.PRecord.RESULT := ibsqlExamAnalysis.Fields[8].AsString;
      Include(TempItem.PRecord.setProp, ExamAnalysis_RESULT);
    end;

    TempItem.PRecord.PosDataNomen := 0;
    Include(TempItem.PRecord.setProp, ExamAnalysis_PosDataNomen);

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

procedure TDbHelper.InsertIncDocField(ibsql: TIBSQL;
  TempItem: TRealOtherDoctorItem);
var
  ibsqlOtherDoctor: TIBSQL;
begin
    ibsqlOtherDoctor := ibsql;
    if (not ibsqlOtherDoctor.Fields[1].IsNull)
    then
    begin
      TempItem.PRecord.FNAME := ibsqlOtherDoctor.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, OtherDoctor_FNAME);
    end;
    if (not ibsqlOtherDoctor.Fields[0].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlOtherDoctor.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, OtherDoctor_ID);
    end;
    if (not ibsqlOtherDoctor.Fields[3].IsNull)
    then
    begin
      TempItem.PRecord.LNAME := ibsqlOtherDoctor.Fields[3].AsString;
      Include(TempItem.PRecord.setProp, OtherDoctor_LNAME);
    end;
//    if (not ibsqlOtherDoctor.Fields[7].IsNull)
//    then
//    begin
//       TempItem.PRecord.KOD_RAJON := ibsqlOtherDoctor.Fields[7].AsInteger;
//       Include(TempItem.PRecord.setProp, OtherDoctor_KOD_RAJON);
//    end;
//    if (not ibsqlOtherDoctor.Fields[6].IsNull)
//    then
//    begin
//       TempItem.PRecord.KOD_RZOK := ibsqlOtherDoctor.Fields[6].AsInteger;
//       Include(TempItem.PRecord.setProp, OtherDoctor_KOD_RZOK);
//    end;
    if (not ibsqlOtherDoctor.Fields[8].IsNull)
    then
    begin
      TempItem.PRecord.NOMER_LZ := ibsqlOtherDoctor.Fields[8].AsString;
      Include(TempItem.PRecord.setProp, OtherDoctor_NOMER_LZ);
    end;
    if (not ibsqlOtherDoctor.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.SNAME := ibsqlOtherDoctor.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, OtherDoctor_SNAME);
    end;
    if (not ibsqlOtherDoctor.Fields[5].IsNull)
    then
    begin
       TempItem.PRecord.SPECIALITY := ibsqlOtherDoctor.Fields[5].AsInteger;
       Include(TempItem.PRecord.setProp, OtherDoctor_SPECIALITY);
    end;
    if (not ibsqlOtherDoctor.Fields[4].IsNull)
    then
    begin
      TempItem.PRecord.UIN := ibsqlOtherDoctor.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, OtherDoctor_UIN);
    end;

    TempItem.DoctorID  := ibsqlOtherDoctor.Fields[0].AsInteger;
end;

procedure TDbHelper.InsertIncMdnField(ibsql: TIBSQL; TempItem: TRealINC_MDNItem);
var
  ibsqlInc_MDN: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
  ibsqlInc_MDN := ibsql;
  if not ibsqlINC_MDN.Fields[0].IsNull then
  begin
     TempItem.PRecord.ACCOUNT_ID := ibsqlINC_MDN.Fields[0].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_ACCOUNT_ID);
  end;
  if not ibsqlINC_MDN.Fields[1].IsNull then
  begin
     TempItem.PRecord.AMBJOURNALN := ibsqlINC_MDN.Fields[1].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_AMBJOURNALN);
  end;
  if not ibsqlINC_MDN.Fields[2].IsNull then
  begin
     TempItem.PRecord.AMBJOURNALN_PAYED := ibsqlINC_MDN.Fields[2].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_AMBJOURNALN_PAYED);
  end;
  if not ibsqlINC_MDN.Fields[3].IsNull then
  begin
     TempItem.PRecord.AMBLISTN := ibsqlINC_MDN.Fields[3].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_AMBLISTN);
  end;
  if not ibsqlINC_MDN.Fields[4].IsNull then
  begin
    TempItem.PRecord.AMB_NRN := ibsqlINC_MDN.Fields[4].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_AMB_NRN);
  end;
  if not ibsqlINC_MDN.Fields[5].IsNull then
  begin
    TempItem.PRecord.ASSIGMENT_TIME := ibsqlINC_MDN.Fields[5].AsTime;
    Include(TempItem.PRecord.setProp, INC_MDN_ASSIGMENT_TIME);
  end;
  if not ibsqlINC_MDN.Fields[6].IsNull then
  begin
    TempItem.PRecord.DATA := ibsqlINC_MDN.Fields[6].AsDate;
    Include(TempItem.PRecord.setProp, INC_MDN_DATA);
  end;
  if not ibsqlINC_MDN.Fields[7].IsNull then
  begin
    TempItem.PRecord.DATE_EXECUTION := ibsqlINC_MDN.Fields[7].AsDate;
    Include(TempItem.PRecord.setProp, INC_MDN_DATE_EXECUTION);
  end;
  if not ibsqlINC_MDN.Fields[8].IsNull then
  begin
    TempItem.PRecord.DATE_PROBOVZEMANE := ibsqlINC_MDN.Fields[8].AsDate;
    Include(TempItem.PRecord.setProp, INC_MDN_DATE_PROBOVZEMANE);
  end;
  if not ibsqlINC_MDN.Fields[9].IsNull then
  begin
    TempItem.PRecord.DESCRIPTION := ibsqlINC_MDN.Fields[9].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_DESCRIPTION);
  end;
  if not ibsqlINC_MDN.Fields[10].IsNull then
  begin
    TempItem.PRecord.EXECUTION_TIME := ibsqlINC_MDN.Fields[10].AsTime;
    Include(TempItem.PRecord.setProp, INC_MDN_EXECUTION_TIME);
  end;
  if not ibsqlINC_MDN.Fields[11].IsNull then
  begin
     TempItem.PRecord.FUND_ID := ibsqlINC_MDN.Fields[11].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_FUND_ID);
  end;
  if not ibsqlINC_MDN.Fields[12].IsNull then
  begin
     TempItem.PRecord.ID := ibsqlINC_MDN.Fields[12].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_ID);
  end;
  if not ibsqlINC_MDN.Fields[13].IsNull then
  begin
    TempItem.PRecord.NOMERBELEGKA := ibsqlINC_MDN.Fields[13].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_NOMERBELEGKA);
  end;
  if not ibsqlINC_MDN.Fields[14].IsNull then
  begin
    TempItem.PRecord.NOMERKASHAPARAT := ibsqlINC_MDN.Fields[14].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_NOMERKASHAPARAT);
  end;
  if not ibsqlINC_MDN.Fields[15].IsNull then
  begin
    TempItem.PRecord.NRN := ibsqlINC_MDN.Fields[15].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_NRN);
  end;
  if not ibsqlINC_MDN.Fields[16].IsNull then
  begin
     TempItem.PRecord.NUMBER := ibsqlINC_MDN.Fields[16].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_NUMBER);
  end;
  if not ibsqlINC_MDN.Fields[17].IsNull then
  begin
    TempItem.PRecord.NZOK_NOMER := ibsqlINC_MDN.Fields[17].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_NZOK_NOMER);
  end;
  if not ibsqlINC_MDN.Fields[18].IsNull then
  begin
    TempItem.PRecord.PACKAGE := ibsqlINC_MDN.Fields[18].AsInteger;
    Include(TempItem.PRecord.setProp, INC_MDN_PACKAGE);
  end;
  if not ibsqlINC_MDN.Fields[19].IsNull then
  begin
    TempItem.PRecord.PASS := ibsqlINC_MDN.Fields[19].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_PASS);
  end;
  if not ibsqlINC_MDN.Fields[20].IsNull then
  begin
    TempItem.PRecord.SEND_MAIL_DATE := ibsqlINC_MDN.Fields[20].AsDate;
    Include(TempItem.PRecord.setProp, INC_MDN_SEND_MAIL_DATE);
  end;
  if not ibsqlINC_MDN.Fields[21].IsNull then
  begin
    TempItem.PRecord.THREAD_IDS := ibsqlINC_MDN.Fields[21].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_THREAD_IDS);
  end;
  if not ibsqlINC_MDN.Fields[22].IsNull then
  begin
    TempItem.PRecord.TIME_PROBOVZEMANE := ibsqlINC_MDN.Fields[22].AsTime;
    Include(TempItem.PRecord.setProp, INC_MDN_TIME_PROBOVZEMANE);
  end;
  if not ibsqlINC_MDN.Fields[23].IsNull then
  begin
    TempItem.PRecord.TOKEN_RESULT := ibsqlINC_MDN.Fields[23].AsString;
    Include(TempItem.PRecord.setProp, INC_MDN_TOKEN_RESULT);
  end;
  if not ibsqlINC_MDN.Fields[24].IsNull then
  begin
     TempItem.PRecord.VISIT_ID := ibsqlINC_MDN.Fields[24].AsInteger;
     Include(TempItem.PRecord.setProp, INC_MDN_VISIT_ID);
  end;

  TempItem.ICD_CODE := ibsqlINC_MDN.Fields[36].AsString;
  TempItem.ICD_CODE_ADD := ibsqlINC_MDN.Fields[37].AsString;
  TempItem.PatientID := ibsqlINC_MDN.Fields[52].AsInteger;
end;

procedure TDbHelper.InsertIncMNField(ibsql: TIBSQL;
  TempItem: TRealINC_NAPRItem);
var
  ibsqlINC_NAPR: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
    ibsqlINC_NAPR := ibsql;
    if (not ibsqlINC_NAPR.Fields[0].IsNull)
    then
    begin
       TempItem.PRecord.AMB_LISTN := ibsqlINC_NAPR.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, INC_NAPR_AMB_LISTN);
    end;
    if (not ibsqlINC_NAPR.Fields[1].IsNull)
    then
    begin
      TempItem.PRecord.AMB_LIST_NRN := ibsqlINC_NAPR.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, INC_NAPR_AMB_LIST_NRN);
    end;
    if (not ibsqlINC_NAPR.Fields[2].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlINC_NAPR.Fields[2].AsInteger;
       Include(TempItem.PRecord.setProp, INC_NAPR_ID);
    end;
    if (not ibsqlINC_NAPR.Fields[3].IsNull)
    then
    begin
      TempItem.PRecord.ISSUE_DATE := ibsqlINC_NAPR.Fields[3].AsDate;
      Include(TempItem.PRecord.setProp, INC_NAPR_ISSUE_DATE);
    end;
    if (not ibsqlINC_NAPR.Fields[4].IsNull)
    then
    begin
      TempItem.PRecord.ISSUE_TIME := ibsqlINC_NAPR.Fields[4].AsTime;
      Include(TempItem.PRecord.setProp, INC_NAPR_ISSUE_TIME);
    end;
    if (not ibsqlINC_NAPR.Fields[5].IsNull)
    then
    begin
      TempItem.PRecord.NOMERBELEGKA := ibsqlINC_NAPR.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, INC_NAPR_NOMERBELEGKA);
    end;
    if (not ibsqlINC_NAPR.Fields[6].IsNull)
    then
    begin
      TempItem.PRecord.NOMERKASHAPARAT := ibsqlINC_NAPR.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, INC_NAPR_NOMERKASHAPARAT);
    end;
    if (not ibsqlINC_NAPR.Fields[7].IsNull)
    then
    begin
      TempItem.PRecord.NRN := ibsqlINC_NAPR.Fields[7].AsString;
      Include(TempItem.PRecord.setProp, INC_NAPR_NRN);
    end;
    if (not ibsqlINC_NAPR.Fields[8].IsNull)
    then
    begin
       TempItem.PRecord.NUMBER := ibsqlINC_NAPR.Fields[8].AsInteger;
       Include(TempItem.PRecord.setProp, INC_NAPR_NUMBER);
    end;
    if (not ibsqlINC_NAPR.Fields[9].IsNull)
    then
    begin
      TempItem.PRecord.REASON := ibsqlINC_NAPR.Fields[9].AsString;
      Include(TempItem.PRecord.setProp, INC_NAPR_REASON);
    end;

  TempItem.ICD_CODE := ibsqlINC_NAPR.Fields[13].AsString;
  TempItem.ICD_CODE_ADD := ibsqlINC_NAPR.Fields[18].AsString;
  TempItem.ICD_CODE2 := ibsqlINC_NAPR.Fields[14].AsString;
  TempItem.ICD_CODE2_ADD := ibsqlINC_NAPR.Fields[15].AsString;
  TempItem.ICD_CODE3 := ibsqlINC_NAPR.Fields[16].AsString;
  TempItem.ICD_CODE3_ADD := ibsqlINC_NAPR.Fields[17].AsString;
  TempItem.PatientID := ibsqlINC_NAPR.Fields[23].AsInteger;
  if TempItem.PatientID = 85386 then
    TempItem.PatientID := 85386;
  TempItem.NRN := ibsqlINC_NAPR.Fields[7].AsString;
  TempItem.Nomer := ibsqlINC_NAPR.Fields[8].AsInteger;
  TempItem.IncDoctorId := ibsqlINC_NAPR.Fields[19].AsInteger;

  TempItem.Spec1 := ibsqlINC_NAPR.Fields[34].AsString;
  TempItem.Spec2 := ibsqlINC_NAPR.Fields[35].AsString;
  TempItem.Spec3 := ibsqlINC_NAPR.Fields[36].AsString;
  TempItem.Spec4 := ibsqlINC_NAPR.Fields[37].AsString;
  TempItem.Spec5 := ibsqlINC_NAPR.Fields[38].AsString;


  TempItem.NAPR_TYPE_ID := ibsqlINC_NAPR.Fields[21].AsInteger;
  TempItem.VISIT_TYPE_ID := ibsqlINC_NAPR.Fields[31].AsInteger;

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

procedure TDbHelper.InsertMedNapr3AField(ibsql: TIBSQL;
  TempItem: TRealBLANKA_MED_NAPR_3AItem);
var
  ibsqlBLANKA_MED_NAPR_3A: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
  ibsqlBLANKA_MED_NAPR_3A := ibsql;


  TempItem.ICD_CODE := ibsqlBLANKA_MED_NAPR_3A.Fields[9].AsString;
  TempItem.ICD_CODE_ADD := ibsqlBLANKA_MED_NAPR_3A.Fields[14].AsString;
  TempItem.ICD_CODE2 := ibsqlBLANKA_MED_NAPR_3A.Fields[10].AsString;
  TempItem.ICD_CODE2_ADD := ibsqlBLANKA_MED_NAPR_3A.Fields[11].AsString;
  TempItem.ICD_CODE3 := ibsqlBLANKA_MED_NAPR_3A.Fields[12].AsString;
  TempItem.ICD_CODE3_ADD := ibsqlBLANKA_MED_NAPR_3A.Fields[13].AsString;


  if not ibsqlBLANKA_MED_NAPR_3A.Fields[0].IsNull then
    begin
      TempItem.PRecord.ATTACHED_DOCS := ibsqlBLANKA_MED_NAPR_3A.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_ATTACHED_DOCS);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[1].IsNull then
    begin
       TempItem.PRecord.ID := ibsqlBLANKA_MED_NAPR_3A.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_ID);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[2].IsNull then
    begin
      TempItem.PRecord.ISSUE_DATE := ibsqlBLANKA_MED_NAPR_3A.Fields[2].AsDate;
      Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_ISSUE_DATE);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[3].IsNull then
    begin
      TempItem.PRecord.NRN := ibsqlBLANKA_MED_NAPR_3A.Fields[3].AsString;
      Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_NRN);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[4].IsNull then
    begin
       TempItem.PRecord.NUMBER := ibsqlBLANKA_MED_NAPR_3A.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_NUMBER);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[5].IsNull then
    begin
      TempItem.PRecord.REASON := ibsqlBLANKA_MED_NAPR_3A.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_REASON);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[6].IsNull then
    begin
       TempItem.PRecord.SPECIALITY_ID := ibsqlBLANKA_MED_NAPR_3A.Fields[6].AsInteger;
       Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_SPECIALITY_ID);
    end;
    if not ibsqlBLANKA_MED_NAPR_3A.Fields[7].IsNull then
    begin
      TempItem.PRecord.VSD_CODE := ibsqlBLANKA_MED_NAPR_3A.Fields[7].AsString;
      Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_VSD_CODE);
    end;

  TempItem.SpecNzis := ibsqlBLANKA_MED_NAPR_3A.Fields[20].AsString;
  TempItem.PregledID := ibsqlBLANKA_MED_NAPR_3A.Fields[18].AsInteger;


  TempItem.PRecord.Logical := [];
  //if ibsqlBLANKA_MED_NAPR_3A.Fields[18].AsString = 'Y' then
//    Include(TempItem.PRecord.Logical, IS_PRINTED);
//  if ibsqlBLANKA_MED_NAPR_3A.Fields[19].AsString = 'Y' then
//    Include(TempItem.PRecord.Logical, EXAMED_BY_SPECIALIST);
  case ibsqlBLANKA_MED_NAPR_3A.Fields[17].Asinteger  of
    0: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.NZIS_STATUS_None);
    3: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.NZIS_STATUS_Sended);
    5: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.NZIS_STATUS_Cancel);
  end;
  case ibsqlBLANKA_MED_NAPR_3A.Fields[19].Asinteger  of
    1: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Ostro);
    2: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Hron);
    3: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Disp);
    4: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Prof);
    5: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Iskane_Telk);
    6: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Choice_Mother);
    7: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Choice_Child);
    9: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR_3A.MED_NAPR_3A_Eksp);
  end;



  if TempItem.PRecord.Logical <> [] then
    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_3A_Logical);
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
  if (not ibsqlBLANKA_MED_NAPR.Fields[22].IsNull)
  then
  begin
     TempItem.PRecord.SpecDataPos := ibsqlBLANKA_MED_NAPR.Fields[22].AsInteger;
     Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_SpecDataPos);
  end;

  TempItem.SpecNzis := ibsqlBLANKA_MED_NAPR.Fields[22].AsString;
  TempItem.PregledID := ibsqlBLANKA_MED_NAPR.Fields[12].AsInteger;


  TempItem.PRecord.Logical := [];
  if ibsqlBLANKA_MED_NAPR.Fields[18].AsString = 'Y' then
    Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR.IS_PRINTED);
  if ibsqlBLANKA_MED_NAPR.Fields[19].AsString = 'Y' then
    Include(TempItem.PRecord.Logical, EXAMED_BY_SPECIALIST);
  case ibsqlBLANKA_MED_NAPR.Fields[20].Asinteger  of
    0: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR.NZIS_STATUS_None);
    3: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR.NZIS_STATUS_Sended);
    5: Include(TempItem.PRecord.Logical, TLogicalBLANKA_MED_NAPR.NZIS_STATUS_Cancel);
  end;
  case ibsqlBLANKA_MED_NAPR.Fields[21].Asinteger  of
    1: Include(TempItem.PRecord.Logical, MED_NAPR_Ostro);
    2: Include(TempItem.PRecord.Logical, MED_NAPR_Hron);
    3: Include(TempItem.PRecord.Logical, MED_NAPR_Disp);
    4: Include(TempItem.PRecord.Logical, MED_NAPR_Prof);
    5: Include(TempItem.PRecord.Logical, MED_NAPR_Iskane_Telk);
    6: Include(TempItem.PRecord.Logical, MED_NAPR_Choice_Mother);
    7: Include(TempItem.PRecord.Logical, MED_NAPR_Choice_Child);
    9: Include(TempItem.PRecord.Logical, MED_NAPR_Eksp);
  end;



  if TempItem.PRecord.Logical <> [] then
    Include(TempItem.PRecord.setProp, BLANKA_MED_NAPR_Logical);
end;

procedure TDbHelper.InsertMedNaprHospField(ibsql: TIBSQL;
  TempItem: TRealHOSPITALIZATIONItem);
var
  ibsqlHospitalization: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
    ibsqlHospitalization := ibsql;
    if (not ibsqlHOSPITALIZATION.Fields[0].IsNull)
    then
    begin
      TempItem.PRecord.AMB_PROCEDURE := ibsqlHOSPITALIZATION.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, HOSPITALIZATION_AMB_PROCEDURE);
    end;
    if (not ibsqlHOSPITALIZATION.Fields[1].IsNull)
    then
    begin
      TempItem.PRecord.CLINICAL_PATH := ibsqlHOSPITALIZATION.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, HOSPITALIZATION_CLINICAL_PATH);
    end;
    if (not ibsqlHOSPITALIZATION.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.DIRECT_DATE := ibsqlHOSPITALIZATION.Fields[2].AsDate;
      Include(TempItem.PRecord.setProp, HOSPITALIZATION_DIRECT_DATE);
    end;
    if (not ibsqlHOSPITALIZATION.Fields[3].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlHOSPITALIZATION.Fields[3].AsInteger;
       Include(TempItem.PRecord.setProp, HOSPITALIZATION_ID);
    end;
    if (not ibsqlHOSPITALIZATION.Fields[4].IsNull)
    then
    begin
      TempItem.PRecord.NOTES := ibsqlHOSPITALIZATION.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, HOSPITALIZATION_NOTES);
    end;
    if (not ibsqlHOSPITALIZATION.Fields[5].IsNull)
    then
    begin
      TempItem.PRecord.NRN := ibsqlHOSPITALIZATION.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, HOSPITALIZATION_NRN);
    end;
    if (not ibsqlHOSPITALIZATION.Fields[6].IsNull)
    then
    begin
       TempItem.PRecord.NUMBER := ibsqlHOSPITALIZATION.Fields[6].AsInteger;
       Include(TempItem.PRecord.setProp, HOSPITALIZATION_NUMBER);
    end;
    if ibsqlHOSPITALIZATION.Fields[18].AsString = 'Y' then
       Include(TempItem.PRecord.Logical, IS_PLANNED);
    if ibsqlHOSPITALIZATION.Fields[21].AsString = 'Y' then
       Include(TempItem.PRecord.Logical, IS_URGENT);
    case ibsqlHOSPITALIZATION.Fields[7].Asinteger of
      1: Include(TempItem.PRecord.Logical, DIRECTED_BY_OPL);
      2: Include(TempItem.PRecord.Logical, DIRECTED_BY_SIMP);
      3: Include(TempItem.PRecord.Logical, DIRECTED_BY_HOSP);
      4: Include(TempItem.PRecord.Logical, DIRECTED_BY_EMERG);
    end;

    case ibsqlHOSPITALIZATION.Fields[22].Asinteger  of
      0: Include(TempItem.PRecord.Logical, TLogicalHOSPITALIZATION.NZIS_STATUS_None);
      3: Include(TempItem.PRecord.Logical, TLogicalHOSPITALIZATION.NZIS_STATUS_Sended);
      5: Include(TempItem.PRecord.Logical, TLogicalHOSPITALIZATION.NZIS_STATUS_Cancel);
    end;


  TempItem.ICD_CODE := ibsqlHOSPITALIZATION.Fields[10].AsString;
  TempItem.ICD_CODE_ADD := ibsqlHOSPITALIZATION.Fields[11].AsString;
  TempItem.ICD_CODE2 := ibsqlHOSPITALIZATION.Fields[12].AsString;
  TempItem.ICD_CODE2_ADD := ibsqlHOSPITALIZATION.Fields[13].AsString;
  TempItem.PregledID := ibsqlHOSPITALIZATION.Fields[23].AsInteger;



end;

procedure TDbHelper.InsertMedNaprLkkField(ibsql: TIBSQL;
  TempItem: TRealEXAM_LKKItem);
var
  ibsqlEXAM_LKK: TIBSQL;
  diagNode: PVirtualNode;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  dataPosition: Cardinal;
begin
    ibsqlEXAM_LKK := ibsql;
    if (not ibsqlEXAM_LKK.Fields[0].IsNull)
    then
    begin
      TempItem.PRecord.DATA := ibsqlEXAM_LKK.Fields[0].AsDate;
      Include(TempItem.PRecord.setProp, EXAM_LKK_DATA);
    end;
    if (not ibsqlEXAM_LKK.Fields[1].IsNull)
    then
    begin
       TempItem.PRecord.ID := ibsqlEXAM_LKK.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, EXAM_LKK_ID);
    end;
    if (not ibsqlEXAM_LKK.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.NRN := ibsqlEXAM_LKK.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, EXAM_LKK_NRN);
    end;
    if (not ibsqlEXAM_LKK.Fields[3].IsNull)
    then
    begin
       TempItem.PRecord.NUMBER := ibsqlEXAM_LKK.Fields[3].AsInteger;
       Include(TempItem.PRecord.setProp, EXAM_LKK_NUMBER);
    end;

  TempItem.ICD_CODE := ibsqlEXAM_LKK.Fields[4].AsString;
  TempItem.ICD_CODE_ADD := ibsqlEXAM_LKK.Fields[6].AsString;
  TempItem.ICD_CODE2 := ibsqlEXAM_LKK.Fields[5].AsString;
  TempItem.ICD_CODE2_ADD := ibsqlEXAM_LKK.Fields[7].AsString;
  TempItem.PregledID := ibsqlEXAM_LKK.Fields[12].AsInteger;

end;

procedure TDbHelper.InsertPatientField(ibsql: TIBSQL;
  TempItem: TRealPatientNewItem);
var
  ibsqlPatientNew: TIBSQL;
  data: PAspRec;
  dataPosition: Cardinal;
  iEvn: Integer;
  BLOOD_TYPE: string;
  PidType: string;
  adres: TRealAddresItem;
begin
  ibsqlPatientNew := ibsql;
  if not ibsqlPatientNew.Fields[0].IsNull then
  begin
     TempItem.PRecord.BABY_NUMBER := ibsqlPatientNew.Fields[0].AsInteger;
     Include(TempItem.PRecord.setProp, PatientNew_BABY_NUMBER);
  end;
  if not ibsqlPatientNew.Fields[1].IsNull then
  begin
    TempItem.PRecord.BIRTH_DATE := ibsqlPatientNew.Fields[1].AsDate;
    Include(TempItem.PRecord.setProp, PatientNew_BIRTH_DATE);
  end;
  if not ibsqlPatientNew.Fields[2].IsNull then
  begin
    TempItem.PRecord.DIE_DATE := ibsqlPatientNew.Fields[2].AsDate;
    Include(TempItem.PRecord.setProp, PatientNew_DIE_DATE);
  end;
  if not ibsqlPatientNew.Fields[3].IsNull then
  begin
    TempItem.PRecord.DIE_FROM := ibsqlPatientNew.Fields[3].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_DIE_FROM);
  end;
  if not ibsqlPatientNew.Fields[4].IsNull then
  begin
    TempItem.PRecord.DOSIENOMER := ibsqlPatientNew.Fields[4].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_DOSIENOMER);
  end;
  if not ibsqlPatientNew.Fields[5].IsNull then
  begin
    TempItem.PRecord.DZI_NUMBER := ibsqlPatientNew.Fields[5].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_DZI_NUMBER);
  end;
  if not ibsqlPatientNew.Fields[6].IsNull then
  begin
    TempItem.PRecord.EGN := ibsqlPatientNew.Fields[6].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_EGN);
  end;
  if not ibsqlPatientNew.Fields[7].IsNull then
  begin
    TempItem.PRecord.EHIC_NO := ibsqlPatientNew.Fields[7].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_EHIC_NO);
  end;
  if not ibsqlPatientNew.Fields[8].IsNull then
  begin
    TempItem.PRecord.FNAME := Trim(ibsqlPatientNew.Fields[8].AsString);
    Include(TempItem.PRecord.setProp, PatientNew_FNAME);
  end;
  if not ibsqlPatientNew.Fields[9].IsNull then
  begin
     TempItem.PRecord.ID := ibsqlPatientNew.Fields[9].AsInteger;
     Include(TempItem.PRecord.setProp, PatientNew_ID);
  end;
  if not ibsqlPatientNew.Fields[10].IsNull then
  begin
     TempItem.PRecord.LAK_NUMBER := ibsqlPatientNew.Fields[10].AsInteger;
     Include(TempItem.PRecord.setProp, PatientNew_LAK_NUMBER);
  end;
  if not ibsqlPatientNew.Fields[11].IsNull then
  begin
    TempItem.PRecord.LNAME := Trim(ibsqlPatientNew.Fields[11].AsString);
    Include(TempItem.PRecord.setProp, PatientNew_LNAME);
  end;
  if not ibsqlPatientNew.Fields[12].IsNull then
  begin
    TempItem.PRecord.NZIS_BEBE := ibsqlPatientNew.Fields[12].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_NZIS_BEBE);
  end;
  if not ibsqlPatientNew.Fields[13].IsNull then
  begin
    TempItem.PRecord.NZIS_PID := ibsqlPatientNew.Fields[13].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_NZIS_PID);
  end;
  if not ibsqlPatientNew.Fields[14].IsNull then
  begin
    TempItem.PRecord.RACE := ibsqlPatientNew.Fields[14].AsDouble;
    Include(TempItem.PRecord.setProp, PatientNew_RACE);
  end;

  if not ibsqlPatientNew.Fields[15].IsNull then
  begin
    TempItem.PRecord.SNAME := Trim(ibsqlPatientNew.Fields[15].AsString);
    Include(TempItem.PRecord.setProp, PatientNew_SNAME);
  end;



  TempItem.PatID := ibsqlPatientNew.Fields[9].AsInteger;
  TempItem.PatEGN := ibsqlPatientNew.Fields[6].AsString;

  if not ibsqlPatientNew.Fields[16].IsNull then
  begin
    tempitem.HEALTH_INSURANCE_NAME := ibsqlPatientNew.Fields[16].AsString;
    //if evn = nil then
//    begin
//      evn := AddEvents(tempitem.HEALTH_INSURANCE_NAME, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NAME);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, tempitem.HEALTH_INSURANCE_NAME, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NAME);
//    end;
   // iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.HEALTH_INSURANCE_NAME, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NAME));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[17].IsNull) and (ibsqlPatientNew.Fields[17].AsString <> '') then
  begin
    tempitem.HEALTH_INSURANCE_NUMBER := ibsqlPatientNew.Fields[17].AsString;
    //if evn = nil then
//    begin
//      evn := AddEvents(tempitem.HEALTH_INSURANCE_NUMBER, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NUMBER);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, tempitem.HEALTH_INSURANCE_NUMBER, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NUMBER);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.HEALTH_INSURANCE_NUMBER, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NUMBER));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[18].IsNull) and (ibsqlPatientNew.Fields[18].AsString <> '') then
  begin
    tempitem.DATA_HEALTH_INSURANCE := ibsqlPatientNew.Fields[18].AsString;
    //if evn = nil then
//    begin
//      evn := AddEvents(tempitem.DATA_HEALTH_INSURANCE, 0, 0 ,0 , False, 0, DATA_HEALTH_INSURANCE);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, tempitem.DATA_HEALTH_INSURANCE, 0, 0 ,0 , False, 0, DATA_HEALTH_INSURANCE);
//    end;
//
//      iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.DATA_HEALTH_INSURANCE, 0, 0 ,0 , False, 0, DATA_HEALTH_INSURANCE));
//      TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[19].IsNull) and (ibsqlPatientNew.Fields[19].AsDate  <> 0) then
  begin
    tempitem.DATE_HEALTH_INSURANCE_CHECK := ibsqlPatientNew.Fields[19].AsDate;
    //if evn = nil then
//    begin
//      evn := AddEvents('', tempitem.DATE_HEALTH_INSURANCE_CHECK, 0 ,0 , False, 0, DATE_HEALTH_INSURANCE_CHECK);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, '', tempitem.DATE_HEALTH_INSURANCE_CHECK, 0 ,0 , False, 0, DATE_HEALTH_INSURANCE_CHECK);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATE_HEALTH_INSURANCE_CHECK, 0 ,0 , False, 0, DATE_HEALTH_INSURANCE_CHECK));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[20].IsNull) and (ibsqlPatientNew.Fields[20].AsTime  <> 0) and (ibsqlPatientNew.Fields[19].AsDate  <> 0) then
  begin
    tempitem.TIME_HEALTH_INSURANCE_CHECK := ibsqlPatientNew.Fields[20].AsTime;
    //if evn = nil then
//    begin
//      evn := AddEvents('',0 , 0 ,tempitem.TIME_HEALTH_INSURANCE_CHECK , False, 0, TIME_HEALTH_INSURANCE_CHECK);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, '',0 , 0 ,tempitem.TIME_HEALTH_INSURANCE_CHECK , False, 0, TIME_HEALTH_INSURANCE_CHECK);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('',0 , 0 ,tempitem.TIME_HEALTH_INSURANCE_CHECK , False, 0, TIME_HEALTH_INSURANCE_CHECK));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;

  if (not ibsqlPatientNew.Fields[21].IsNull) and (ibsqlPatientNew.Fields[21].AsDate  <> 0) then
  begin
    tempitem.DATE_OTPISVANE := ibsqlPatientNew.Fields[21].AsDate;
    //if evn = nil then
//    begin
//      evn := AddEvents('', tempitem.DATE_OTPISVANE, 0 ,0 , False, 0, DATE_OTPISVANE);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, '', tempitem.DATE_OTPISVANE, 0 ,0 , False, 0, DATE_OTPISVANE);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATE_OTPISVANE, 0 ,0 , False, 0, DATE_OTPISVANE));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[22].IsNull) and (ibsqlPatientNew.Fields[22].AsDate  <> 0) then
  begin
    tempitem.DATE_ZAPISVANE := ibsqlPatientNew.Fields[22].AsDate;
    TempItem.PRecord.DATE_ZAPISVANE := ibsqlPatientNew.Fields[22].AsDate;
    Include(TempItem.PRecord.setProp, PatientNew_DATE_ZAPISVANE);
//    if evn = nil then
//    begin
//      evn := AddEvents('', tempitem.DATE_ZAPISVANE, 0 ,0 , False, 0, DATE_ZAPISVANE);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, '', tempitem.DATE_ZAPISVANE, 0 ,0 , False, 0, DATE_ZAPISVANE);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATE_ZAPISVANE, 0 ,0 , False, 0, DATE_ZAPISVANE));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[23].IsNull) and (ibsqlPatientNew.Fields[23].AsDate  <> 0) then
  begin
    tempitem.DATEFROM := ibsqlPatientNew.Fields[23].AsDate;
    //if evn = nil then
//    begin
//      evn := AddEvents('', tempitem.DATEFROM, 0 ,0 , False, 0, DATEFROM);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, '', tempitem.DATEFROM, 0 ,0 , False, 0, DATEFROM);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATEFROM, 0 ,0 , False, 0, DATEFROM));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;



  tempitem.DATEISSUE := ibsqlPatientNew.Fields[24].AsDate;
  tempitem.DATETO := ibsqlPatientNew.Fields[25].AsDate;
  tempitem.DATETO_TEXT := ibsqlPatientNew.Fields[26].AsString;
  tempitem.GRAJD := ibsqlPatientNew.Fields[27].AsString;
  tempitem.IS_NEBL_USL := ibsqlPatientNew.Fields[28].AsString = 'Y';
  tempitem.OSIGNO := ibsqlPatientNew.Fields[29].AsString;
  tempitem.OSIGUREN := ibsqlPatientNew.Fields[30].AsString = 'Y';
  tempitem.PASS := ibsqlPatientNew.Fields[31].AsString;
  tempitem.PREVIOUS_DOCTOR_ID := ibsqlPatientNew.Fields[32].AsInteger;
  tempitem.TYPE_CERTIFICATE := ibsqlPatientNew.Fields[33].AsString;
  tempitem.FUND_ID := ibsqlPatientNew.Fields[34].AsInteger;
  tempitem.PAT_KIND := ibsqlPatientNew.Fields[35].AsInteger;
  if (not ibsqlPatientNew.Fields[36].IsNull) then
  begin
    tempitem.RZOK := ibsqlPatientNew.Fields[36].AsString;
//    if evn = nil then
//    begin
//      evn := AddEvents(tempitem.RZOK, UserDate, 0 ,0 , False, 0, RZOK);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, tempitem.RZOK, UserDate, 0 ,0 , False, 0, RZOK);
//    end;
   // iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.RZOK, UserDate, 0 ,0 , False, 0, RZOK));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[37].IsNull) then
  begin
    tempitem.RZOKR := ibsqlPatientNew.Fields[37].AsString;
    //if evn = nil then
//    begin
//      evn := AddEvents(tempitem.RZOKR, UserDate, 0 ,0 , False, 0, RZOKR);
//      evn.PatID := TempItem.PatID;
//      TempItem.FEventsPat.Add(evn);
//    end
//    else
//    begin
//      evn := AppendEvents(evn, tempitem.RZOKR, UserDate, 0 ,0 , False, 0, RZOKR);
//    end;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.RZOKR, UserDate, 0 ,0 , False, 0, RZOKR));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[48].IsNull) then
  begin
    tempitem.NAS_MQSTO := ibsqlPatientNew.Fields[48].AsString; // трябва да е последно или да направя отделно поле да инсъртва адреса
    adres := TempItem.FAdresi[0];//  при импорта има само един адрес;
    if (not ibsqlPatientNew.Fields[49].IsNull) then
    begin
      adres.PRecord.AP := ibsqlPatientNew.Fields[49].AsString;
      Include(adres.PRecord.setProp, Addres_AP);
      Include(adres.PRecord.Logical, USE_AP);
    end;
    if (not ibsqlPatientNew.Fields[50].IsNull) then
    begin
      adres.PRecord.BL := ibsqlPatientNew.Fields[50].AsString;
      Include(adres.PRecord.setProp, Addres_BL);
      Include(adres.PRecord.Logical, USE_BL);
    end;
    if (not ibsqlPatientNew.Fields[51].IsNull) then
    begin
      adres.PRecord.DTEL := ibsqlPatientNew.Fields[51].AsString;
      Include(adres.PRecord.setProp, Addres_DTEL);

    end;
    if (not ibsqlPatientNew.Fields[52].IsNull) then
    begin
      adres.PRecord.EMAIL := ibsqlPatientNew.Fields[52].AsString;
      Include(adres.PRecord.setProp, Addres_EMAIL);
    end;
    if (not ibsqlPatientNew.Fields[53].IsNull) then
    begin
      adres.PRecord.ET := ibsqlPatientNew.Fields[53].AsString;
      Include(adres.PRecord.setProp, Addres_ET);
      Include(adres.PRecord.Logical, USE_ET);
    end;
    if (not ibsqlPatientNew.Fields[54].IsNull) then
    begin
      adres.PRecord.JK := ibsqlPatientNew.Fields[54].AsString;
      Include(adres.PRecord.setProp, Addres_JK);
      Include(adres.PRecord.Logical, USE_JK);
    end;
    if (not ibsqlPatientNew.Fields[55].IsNull) then
    begin
      adres.PRecord.NOMER := ibsqlPatientNew.Fields[55].AsString;
      Include(adres.PRecord.setProp, Addres_NOMER);
      Include(adres.PRecord.Logical, USE_NOMER);
    end;
    if (not ibsqlPatientNew.Fields[56].IsNull) then
    begin
      adres.PRecord.PKUT := ibsqlPatientNew.Fields[56].AsString;
      Include(adres.PRecord.setProp, Addres_PKUT);
    end;
    if (not ibsqlPatientNew.Fields[57].IsNull) then
    begin
      adres.PRecord.ULICA := ibsqlPatientNew.Fields[57].AsString;
      Include(adres.PRecord.setProp, Addres_ULICA);
      Include(adres.PRecord.Logical, USE_ULICA);
    end;
    if (not ibsqlPatientNew.Fields[58].IsNull) then
    begin
      adres.PRecord.VH := ibsqlPatientNew.Fields[58].AsString;
      Include(adres.PRecord.setProp, Addres_VH);
      Include(adres.PRecord.Logical, USE_VH);
    end;
  end;
  tempitem.DoctorId := ibsqlPatientNew.Fields[47].AsInteger;
  // logical
  TempItem.PRecord.Logical := [];
  BLOOD_TYPE := Trim(ibsqlPatientNew.Fields[38].AsString);
  if BLOOD_TYPE = '0' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_0);
  if BLOOD_TYPE = 'A' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A);
  if BLOOD_TYPE = 'A1' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A1);
  if BLOOD_TYPE = 'A2' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A2);
  if BLOOD_TYPE = 'A1B' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A1B);
  if BLOOD_TYPE = 'A2B' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A2B);
  if BLOOD_TYPE = 'AB' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_AB);
  if BLOOD_TYPE = 'B' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_B);



  if ibsqlPatientNew.Fields[39].Asinteger = 1 then
    Include(TempItem.PRecord.Logical, SEX_TYPE_M)
  else
    Include(TempItem.PRecord.Logical, SEX_TYPE_F);

  PidType := Trim(ibsqlPatientNew.Fields[45].AsString);
  if PidType = 'E' then
    Include(TempItem.PRecord.Logical, PID_TYPE_E);
  if PidType = 'B' then
    Include(TempItem.PRecord.Logical, PID_TYPE_B);
  if PidType = 'L' then
    Include(TempItem.PRecord.Logical, PID_TYPE_L);
  if PidType = 'S' then
    Include(TempItem.PRecord.Logical, PID_TYPE_S);
  if PidType = 'F' then
    Include(TempItem.PRecord.Logical, PID_TYPE_F);

   case TempItem.PAT_KIND of
     1: Include(TempItem.PRecord.Logical, PAT_KIND_REG);
     2: Include(TempItem.PRecord.Logical, PAT_KIND_NOREG);
     3: Include(TempItem.PRecord.Logical, PAT_KIND_TEMP_REG);
   end;



  if TempItem.PRecord.Logical <> [] then
    Include(TempItem.PRecord.setProp, PatientNew_Logical);

end;

procedure TDbHelper.InsertPracticaField(ibsql: TIBSQL; TempItem: TPracticaItem);
 var
    ibsqlPractica: TIBSQL;
    diagNode: PVirtualNode;
    data: PAspRec;
    diag: TRealDiagnosisItem;
    dataPosition: Cardinal;
begin
  ibsqlPractica := ibsql;
      if (not ibsqlPractica.Fields[0].IsNull)
    then
    begin
      TempItem.PRecord.ADDRESS_ACT := ibsqlPractica.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, Practica_ADDRESS_ACT);
    end;
    if (not ibsqlPractica.Fields[1].IsNull)
    then
    begin
      TempItem.PRecord.ADDRESS_DOGNZOK := ibsqlPractica.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Practica_ADDRESS_DOGNZOK);
    end;
    if (not ibsqlPractica.Fields[2].IsNull)
    then
    begin
      TempItem.PRecord.ADRES := ibsqlPractica.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, Practica_ADRES);
    end;
    if (not ibsqlPractica.Fields[3].IsNull)
    then
    begin
      TempItem.PRecord.BANKA := ibsqlPractica.Fields[3].AsString;
      Include(TempItem.PRecord.setProp, Practica_BANKA);
    end;
    if (not ibsqlPractica.Fields[4].IsNull)
    then
    begin
      TempItem.PRecord.BANKOW_KOD := ibsqlPractica.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, Practica_BANKOW_KOD);
    end;
    if (not ibsqlPractica.Fields[5].IsNull)
    then
    begin
      TempItem.PRecord.BULSTAT := ibsqlPractica.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, Practica_BULSTAT);
    end;
    if (not ibsqlPractica.Fields[6].IsNull)
    then
    begin
      TempItem.PRecord.COMPANYNAME := ibsqlPractica.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, Practica_COMPANYNAME);
    end;
    if (not ibsqlPractica.Fields[7].IsNull)
    then
    begin
      TempItem.PRecord.CONTRACT_DATE := ibsqlPractica.Fields[7].AsDate;
      Include(TempItem.PRecord.setProp, Practica_CONTRACT_DATE);
    end;
    if (not ibsqlPractica.Fields[8].IsNull)
    then
    begin
      TempItem.PRecord.CONTRACT_RZOK := ibsqlPractica.Fields[8].AsString;
      Include(TempItem.PRecord.setProp, Practica_CONTRACT_RZOK);
    end;
    if (not ibsqlPractica.Fields[9].IsNull)
    then
    begin
      TempItem.PRecord.CONTRACT_TYPE := ibsqlPractica.Fields[9].AsInteger;
      Include(TempItem.PRecord.setProp, Practica_CONTRACT_TYPE);
    end;
    if (not ibsqlPractica.Fields[10].IsNull)
    then
    begin
      TempItem.PRecord.DAN_NOMER := ibsqlPractica.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, Practica_DAN_NOMER);
    end;
    if (not ibsqlPractica.Fields[11].IsNull)
    then
    begin
      TempItem.PRecord.EGN := ibsqlPractica.Fields[11].AsString;
      Include(TempItem.PRecord.setProp, Practica_EGN);
    end;
    if (not ibsqlPractica.Fields[12].IsNull)
    then
    begin
      TempItem.PRecord.FNAME := ibsqlPractica.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, Practica_FNAME);
    end;
    if (not ibsqlPractica.Fields[13].IsNull)
    then
    begin
      TempItem.PRecord.FULLNAME := ibsqlPractica.Fields[13].AsString;
      Include(TempItem.PRecord.setProp, Practica_FULLNAME);
    end;
    if (not ibsqlPractica.Fields[14].IsNull)
    then
    begin
      //TempItem.PRecord.INVOICECOMPANY := ibsqlPractica.Fields[14].AsString = 'Y';
//      Include(TempItem.PRecord.setProp, Practica_INVOICECOMPANY);
    end;
    if (not ibsqlPractica.Fields[15].IsNull)
    then
    begin
      //TempItem.PRecord.ISSUER_TYPE := ibsqlPractica.Fields[15].AsString = 'Y';
//      Include(TempItem.PRecord.setProp, Practica_ISSUER_TYPE);
    end;
    if (not ibsqlPractica.Fields[16].IsNull)
    then
    begin
      //TempItem.PRecord.IS_SAMOOSIG := ibsqlPractica.Fields[16].AsString = 'Y';
//      Include(TempItem.PRecord.setProp, Practica_IS_SAMOOSIG);
    end;
    if (not ibsqlPractica.Fields[17].IsNull)
    then
    begin
      TempItem.PRecord.KOD_RAJON := ibsqlPractica.Fields[17].AsString;
      Include(TempItem.PRecord.setProp, Practica_KOD_RAJON);
    end;
    if (not ibsqlPractica.Fields[18].IsNull)
    then
    begin
      TempItem.PRecord.KOD_RZOK := ibsqlPractica.Fields[18].AsString;
      Include(TempItem.PRecord.setProp, Practica_KOD_RZOK);
    end;
    if (not ibsqlPractica.Fields[19].IsNull)
    then
    begin
      TempItem.PRecord.LNAME := ibsqlPractica.Fields[19].AsString;
      Include(TempItem.PRecord.setProp, Practica_LNAME);
    end;
    if (not ibsqlPractica.Fields[20].IsNull)
    then
    begin
      TempItem.PRecord.LNCH := ibsqlPractica.Fields[20].AsString;
      Include(TempItem.PRecord.setProp, Practica_LNCH);
    end;
    if (not ibsqlPractica.Fields[21].IsNull)
    then
    begin
      TempItem.PRecord.NAME := ibsqlPractica.Fields[21].AsString;
      Include(TempItem.PRecord.setProp, Practica_NAME);
    end;
    if (not ibsqlPractica.Fields[22].IsNull)
    then
    begin
      TempItem.PRecord.NAS_MQSTO := ibsqlPractica.Fields[22].AsString;
      Include(TempItem.PRecord.setProp, Practica_NAS_MQSTO);
    end;
    if (not ibsqlPractica.Fields[24].IsNull)
    then
    begin
      TempItem.PRecord.NOMER_LZ := ibsqlPractica.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, Practica_NOMER_LZ);
    end;
    if (not ibsqlPractica.Fields[25].IsNull)
    then
    begin
      TempItem.PRecord.NOM_NAP := ibsqlPractica.Fields[25].AsString;
      Include(TempItem.PRecord.setProp, Practica_NOM_NAP);
    end;
    if (not ibsqlPractica.Fields[26].IsNull)
    then
    begin
      TempItem.PRecord.NZOK_NOMER := ibsqlPractica.Fields[26].AsString;
      Include(TempItem.PRecord.setProp, Practica_NZOK_NOMER);
    end;
    if (not ibsqlPractica.Fields[27].IsNull)
    then
    begin
      TempItem.PRecord.OBLAST := ibsqlPractica.Fields[27].AsString;
      Include(TempItem.PRecord.setProp, Practica_OBLAST);
    end;
    if (not ibsqlPractica.Fields[28].IsNull)
    then
    begin
      TempItem.PRecord.OBSHTINA := ibsqlPractica.Fields[28].AsString;
      Include(TempItem.PRecord.setProp, Practica_OBSHTINA);
    end;
    if (not ibsqlPractica.Fields[29].IsNull)
    then
    begin
      //TempItem.PRecord.SELF_INSURED_DECLARATION := ibsqlPractica.Fields[29].AsString = 'Y';
//      Include(TempItem.PRecord.setProp, Practica_SELF_INSURED_DECLARATION);
    end;
    if (not ibsqlPractica.Fields[30].IsNull)
    then
    begin
      TempItem.PRecord.SMETKA := ibsqlPractica.Fields[30].AsString;
      Include(TempItem.PRecord.setProp, Practica_SMETKA);
    end;
    if (not ibsqlPractica.Fields[31].IsNull)
    then
    begin
      TempItem.PRecord.SNAME := ibsqlPractica.Fields[31].AsString;
      Include(TempItem.PRecord.setProp, Practica_SNAME);
    end;
    if (not ibsqlPractica.Fields[32].IsNull)
    then
    begin
      TempItem.PRecord.UPRAVITEL := ibsqlPractica.Fields[32].AsString;
      Include(TempItem.PRecord.setProp, Practica_UPRAVITEL);
    end;
    if (not ibsqlPractica.Fields[33].IsNull)
    then
    begin
      TempItem.PRecord.VIDFIRMA := ibsqlPractica.Fields[33].AsString;
      Include(TempItem.PRecord.setProp, Practica_VIDFIRMA);
    end;
    if (not ibsqlPractica.Fields[34].IsNull)
    then
    begin
      TempItem.PRecord.VID_IDENT := ibsqlPractica.Fields[34].AsString;
      Include(TempItem.PRecord.setProp, Practica_VID_IDENT);
    end;
    if (not ibsqlPractica.Fields[35].IsNull)
    then
    begin
      TempItem.PRecord.VID_PRAKTIKA := ibsqlPractica.Fields[35].AsString;
      Include(TempItem.PRecord.setProp, Practica_VID_PRAKTIKA);
    end;


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
      Include(TempItem.PRecord.setProp, PregledNew_NRN_LRN);
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

    TempItem.COPIED_FROM_NRN := ibsqlPregledNew.Fields[2].AsString;
    if not Fdm.IsGP then
    begin
      TempItem.IncNaprNom := ibsqlPregledNew.Fields[79].AsInteger;
    end;

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
    for i := 0 to Adb_DM.CL022Coll.Count - 1 do
    begin
      if Adb_DM.CL022Coll.Items[i].getAnsiStringMap(AdbNomenNzis.Buf, AdbNomenNzis.FPosData, word(CL022_NHIF_Code)) = cl22Code then
      begin
        cl22Code := Adb_DM.CL022Coll.Items[i].getAnsiStringMap(AdbNomenNzis.Buf, AdbNomenNzis.FPosData, word(CL022_Key));
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
  run, DiagNode: PVirtualNode;
  rundata, DiagData:  PAspRec;
  diagStr, diagAddStr: string;
begin
  Exit;
  run := mdn.FNode.FirstChild;
  while run <> nil do
  begin
    rundata := Pointer(PByte(run) + lenNode);
    case rundata.vid of
      vvDiag:
      begin
        DiagData := rundata;
        diagStr := Adb_DM.CollDiag.getAnsiStringMap(DiagData.DataPos, word(Diagnosis_code_CL011));
        diagAddStr := Adb_DM.CollDiag.getAnsiStringMap(DiagData.DataPos, word(Diagnosis_additionalCode_CL011));
      end;
      vvAnal:
      begin

      end;
    end;
     run := run.NextSibling;
  end;
  logData24 := Adb_DM.CollMdn.getLogical24Map(mdn.DataPos, word(Mdn_Logical));
  logMdn := TlogicalMDNSet(logData24);
  ibsql.Close;
  ibsql.SQL.Text := 'select gen_id(gen_blanka_mdn, 1) from rdb$database';
  ibsql.ExecQuery;
  mdn.MdnId  := ibsql.Fields[0].AsInteger;
  Adb_DM.CollMdn.SetIntMap(mdn.DataPos, word(MDN_ID), mdn.MdnId); // трябва инсърта в АДБ да му е направил място
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
  ibsql.ParamByName('PREGLED_ID').AsInteger := mdn.FPregled.PregledID;
  ibsql.ParamByName('NUMBER').AsInteger := Adb_DM.CollMdn.getIntMap(mdn.DataPos, word(MDN_NUMBER));
  ibsql.ParamByName('DATA').AsDate := Adb_DM.CollMdn.getDateMap(mdn.DataPos, word(MDN_DATA));      //  mdn.getdateMap(AdbHip.Buf, AdbHip.FPosData, word(MDN_DATA));
  ibsql.ParamByName('NRN').AsString := Adb_DM.CollMdn.getAnsiStringMap(mdn.DataPos, word(MDN_NRN));
  ibsql.ParamByName('NZIS_STATUS').Asinteger := 3;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  ibsql.ParamByName('MED_DIAG_NAPR_TYPE_ID').AsInteger := 1;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  ibsql.ParamByName('IS_PRINTED').Asstring := 'Y';
  ibsql.ParamByName('ICD_CODE').Asstring := diagStr; //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  ibsql.ExecQuery;
  ibsql.Transaction.CommitRetaining;
end;

procedure TDbHelper.SavePatientFDB(Pat: TRealPatientNewItem; ibsql: TIBSQL);
var
  logData40: TLogicalData40;
  logPat: TlogicalPatientNewSet;
  i, AddresLinkPos: Integer;
  SetProp: TPregledNewItem.TSetProp;
  addr: TRealAddresItem;
  rhifAreaNumber: string;
  PatNodes: TPatNodes;
  dataDoc, dataAddr: PAspRec;
  nasMest: TRealNasMestoItem;
begin
  PatNodes := Adb_DM.GetPatNodes(Pat.FNode);
  dataDoc := Pointer(PByte(PatNodes.docNode) + lenNode);
  dataAddr := Pointer(PByte(PatNodes.addresses[0]) + lenNode);
  nasMest := NasMesto.FindNasMestFromDataPos(AddresLinkPos);

  logData40 := pat.getLogical40Map(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_Logical));
  logPat := TlogicalPatientNewSet(logData40);
  ibsql.Close;
  ibsql.SQL.Text := 'select gen_id(gen_pacient, 1) from rdb$database';
  ibsql.ExecQuery;
  pat.PatID  := ibsql.Fields[0].AsInteger;
  ibsql.Close;
  if Fdm.IsGP then
  begin
    pat.DoctorID := Adb_DM.CollDoctor.getIntMap(dataDoc.DataPos, word(Doctor_ID));
  end;
  //addr := Pat.FAdresi[0];
  AddresLinkPos := NasMesto.addresColl.getIntMap(dataAddr.DataPos, word(Addres_LinkPos));
  rhifAreaNumber := NasMesto.nasMestoColl.getAnsiStringMap(AddresLinkPos, word(NasMesto_RCZR));



  ibsql.Close;
  if Fdm.IsGP then
  begin
    ibsql.SQL.Text :=
      'insert into PACIENT (ID, BIRTH_DATE, FNAME, SNAME, LNAME, PAT_KIND, DOCTOR_ID, RZOK, RZOKR,' + #13#10 +
                       'DATE_ZAPISVANE, SEX_TYPE, NAS_MQSTO, OBLAST, OBSHTINA, GRAJD, COUNTRY,' + #13#10 +
                       'PID_TYPE, EGN, EKATTE_RESIDENTIAL_ADDRESS)' + #13#10 +
                       'values (:ID, :BIRTH_DATE, :FNAME, :SNAME, :LNAME, :PAT_KIND, :DOCTOR_ID, :RZOK, :RZOKR,' + #13#10 +
                       ':DATE_ZAPISVANE, :SEX_TYPE, :NAS_MQSTO, :OBLAST, :OBSHTINA, :GRAJD, :COUNTRY,' + #13#10 +
                       ':PID_TYPE, :EGN, :EKATTE_RESIDENTIAL_ADDRESS);';
  end
  else
  begin
    ibsql.SQL.Text :=
      'insert into PACIENT (ID, BIRTH_DATE, FNAME, SNAME, LNAME, PAT_KIND,  RZOK, RZOKR,' + #13#10 +
                       'DATE_ZAPISVANE, SEX_TYPE, NAS_MQSTO, OBLAST, OBSHTINA, GRAJD, COUNTRY,' + #13#10 +
                       'PID_TYPE, EGN, EKATTE_RESIDENTIAL_ADDRESS)' + #13#10 +
                       'values (:ID, :BIRTH_DATE, :FNAME, :SNAME, :LNAME, :PAT_KIND,  :RZOK, :RZOKR,' + #13#10 +
                       ':DATE_ZAPISVANE, :SEX_TYPE, :NAS_MQSTO, :OBLAST, :OBSHTINA, :GRAJD, :COUNTRY,' + #13#10 +
                       ':PID_TYPE, :EGN, :EKATTE_RESIDENTIAL_ADDRESS);';
  end;
  for i := 0 to ibsql.Params.Count - 1 do
  begin
    ibsql.Params[i].Clear;
  end;



  ibsql.ParamByName('ID').AsInteger := pat.PatID;
  if fdm.IsGP then
  begin
    ibsql.ParamByName('DOCTOR_ID').AsInteger := pat.DoctorID;
  end;


  ibsql.ParamByName('BIRTH_DATE').AsDate := pat.getDateMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_BIRTH_DATE));
  ibsql.ParamByName('FNAME').AsString := pat.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_FNAME));
  ibsql.ParamByName('SNAME').AsString := pat.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_SNAME));
  ibsql.ParamByName('LNAME').AsString := pat.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_LNAME));

  ibsql.ParamByName('PAT_KIND').AsInteger := 1;  //zzzzzzzzzzzzzzzzzzzzzz registr
  ibsql.ParamByName('RZOK').AsString := Copy(rhifAreaNumber, 1, 2);
  ibsql.ParamByName('RZOKR').AsString := Copy(rhifAreaNumber, 3, 2);
  ibsql.ParamByName('DATE_ZAPISVANE').AsDate := pat.getDateMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_DATE_ZAPISVANE));
  if TLogicalPatientNew(PATIENT_SEX_TYPE_M) in logPat then
    ibsql.ParamByName('SEX_TYPE').AsInteger := 1
  else
    ibsql.ParamByName('SEX_TYPE').AsInteger := 0;
  ibsql.ParamByName('NAS_MQSTO').AsString := NasMesto.nasMestoColl.getAnsiStringMap(AddresLinkPos, word(NasMesto_NasMestoName));
  ibsql.ParamByName('OBLAST').AsString := NasMesto.OblColl.getAnsiStringMap(nasMest.FObl.DataPos, word(Oblast_OblastName));
  ibsql.ParamByName('OBSHTINA').AsString :=  NasMesto.obshtColl.getAnsiStringMap(nasMest.FObsh.DataPos, word(Obshtina_ObshtinaName));
  ibsql.ParamByName('EKATTE_RESIDENTIAL_ADDRESS').AsString := NasMesto.nasMestoColl.getAnsiStringMap(nasMest.DataPos, word(NasMesto_EKATTE));
  ibsql.ParamByName('GRAJD').AsString := 'българско';
  ibsql.ParamByName('PID_TYPE').AsString := 'E';  //zzzzzzzzzzzzzzzzzzzzz
  ibsql.ParamByName('EGN').AsString := pat.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PatientNew_EGN));
  if ibsql.ParamByName('EGN').AsString = '8811130099' then  Exit;

  ibsql.ExecQuery;
  ibsql.Transaction.CommitRetaining;
  Adb_DM.CollPatient.SetIntMap(Pat.DataPos, word(PatientNew_ID), pat.PatID);
end;
//////////////////////////////////////////////////////////////////////////////

procedure TDbHelper.SavePregledFDB(preg: TRealPregledNewItem; ibsql: TIBSQL);
var
  logData40: TLogicalData40;
  logPreg: TlogicalPregledNewSet;
  i: Integer;
  SetProp: TPregledNewItem.TSetProp;
  pregNodes: TPregledNodes;
  dataDoc, dataDiag, datapat, dataIncMN, dataRequester, dataPreg: PAspRec;
  rankDiag: Integer;
  mkb: string;
  mkbPos: Cardinal;
  IncNaprlog: TlogicalINC_NAPRSet;
  intSet: TNaprType;
begin
  pregNodes := Adb_DM.GetPregNodes(preg.FNode);
  datapat := Pointer(PByte(pregNodes.patNode) + lenNode);
  dataPreg :=  Pointer(PByte(pregNodes.pregNode) + lenNode);
  logData40 := preg.getLogical40Map(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_Logical));
  logPreg := TlogicalPregledNewSet(logData40);
  ibsql.Close;
  ibsql.SQL.Text := 'select gen_id(gen_pregled, 1) from rdb$database';
  ibsql.ExecQuery;
  preg.PregledID  := ibsql.Fields[0].AsInteger;
  Adb_DM.CollPregled.SetIntMap(dataPreg.DataPos, word(PregledNew_ID), preg.PregledID);

  ibsql.Close;
  ibsql.SQL.Text :=
    'update NUMERATION_COUNTER set VAL = VAL + 1' + #13#10 +
      'where ID = (select first 1 NUM.NUMERATION_COUNTER_ID' + #13#10 +
                  'from NUMERATION NUM' + #13#10 +
                  'where NUM.NUMERATION_CLASS_ID = 1 and' + #13#10 +
                        'NUM.DOCTOR_ID = :DOCTORID) returning new.VAL';
  dataDoc := Pointer(PByte(pregNodes.perfNode) + lenNode);

  if preg.FDoctor <> nil then
  begin
    preg.DoctorID := preg.FDoctor.getIntMap(AdbHip.Buf, AdbHip.FPosData, word(Doctor_ID));
  end
  else
  begin
    preg.DoctorID := Adb_DM.CollDoctor.getIntMap(dataDoc.DataPos, word(Doctor_ID));
  end;
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
  Adb_DM.CollPregled.streamComm.Write(preg.AMB_LISTN, 4);
  Adb_DM.CollPregled.streamComm.Write(preg.PregledID, 4);

  Adb_DM.CollPregled.streamComm.Len := Adb_DM.CollPregled.streamComm.Size;
  cmdFile.CopyFrom(Adb_DM.CollPregled.streamComm, 0);


  ibsql.Close;  //simp_napr
  if Fdm.IsGP then
  begin
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
  end
  else
  begin
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
                       'IS_REGISTRATION, TO_BE_DISPANSERED, NOMERBELEGKA, NOMERKASHAPARAT, SIMP_NZOKNOMER,' + #13#10 +
                       'IS_MEDBELEJKA, PATIENTOF_NEOTL, PATIENTOF_NEOTLID, NRN, NZIS_STATUS, COPIED_FROM_NRN,' + #13#10 +
                       'SIMP_NAPR_NRN, SIMP_PRIMARY_AMBLIST_NRN, IS_BABY_CARE, PRIMARY_NOTE_ID, THREAD_IDS, PROCEDURE1_ID,' + #13#10 +
                       'PROCEDURE2_ID, PROCEDURE3_ID, PROCEDURE4_ID, simp_form_date,' + #13#10 +
                       'simp_praktika, simp_uin, napr_type_id, simp_speciality_code, simp_napr_n, simp_primary_amblist_date)' + #13#10 +

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
                       ':TO_BE_DISPANSERED, :NOMERBELEGKA, :NOMERKASHAPARAT, :SIMP_NZOKNOMER, :IS_MEDBELEJKA, :PATIENTOF_NEOTL,' + #13#10 +
                       ':PATIENTOF_NEOTLID, :NRN, :NZIS_STATUS, :COPIED_FROM_NRN, :SIMP_NAPR_NRN, :SIMP_PRIMARY_AMBLIST_NRN, :IS_BABY_CARE,' + #13#10 +
                       ':PRIMARY_NOTE_ID, :THREAD_IDS, :PROCEDURE1_ID, :PROCEDURE2_ID, :PROCEDURE3_ID, :PROCEDURE4_ID,' + #13#10 +
                       ':simp_form_date, :simp_praktika, :simp_uin, :napr_type_id, (select sp.code from speciality sp where sp.specnziscode = :simp_speciality_code), 1,' + #13#10 +
                       '(select pr.start_date from pregled pr where pr.nrn = :PrimNrn));';




  end;
  for i := 0 to ibsql.Params.Count - 1 do
  begin
    ibsql.Params[i].Clear;
  end;

  for i := 0 to pregNodes.diags.Count - 1 do
  begin
    dataDiag := Pointer(PByte(pregNodes.diags[i]) + lenNode);
    mkb  := Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_code_CL011));
    rankDiag := Adb_DM.CollDiag.getwordMap(dataDiag.DataPos, word(Diagnosis_rank));
    mkbPos := Adb_DM.CollDiag.getCardMap(dataDiag.DataPos, word(Diagnosis_MkbPos));

    if rankDiag = 0 then
    begin
      if mkbPos > 100 then
    begin
      ibsql.ParamByName('MAIN_DIAG_OPIS').Asstring := MKBColl.getAnsiStringMap(mkbPos, word(Mkb_NAME));
      //mkbNote := MKBColl.getAnsiStringMap(mkbPos, word(Mkb_NOTE));
    end;
      ibsql.ParamByName('main_diag_mkb').Asstring := Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_code_CL011));
      if Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_additionalCode_CL011)) <> '' then
        ibsql.ParamByName('main_diag_mkb_add').Asstring := Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_additionalCode_CL011));
    end
    else
    begin
      if mkbPos > 100 then
      begin
        ibsql.ParamByName('PR_ZAB' + IntToStr(rankDiag) + '_OPIS').Asstring := MKBColl.getAnsiStringMap(mkbPos, word(Mkb_NAME));
        //mkbNote := MKBColl.getAnsiStringMap(mkbPos, word(Mkb_NOTE));
      end;
      ibsql.ParamByName('PR_ZAB' + IntToStr(rankDiag) + '_MKB').Asstring := Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_code_CL011));
      if Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_additionalCode_CL011)) <> '' then
        ibsql.ParamByName('PR_ZAB' + IntToStr(rankDiag) + '_MKB_ADD').Asstring := Adb_DM.CollDiag.getAnsiStringMap(datadiag.DataPos, word(Diagnosis_additionalCode_CL011));
    end;
  end;
  ibsql.ParamByName('PrimNrn').Asstring := '---------';
  ibsql.ParamByName('ID').AsInteger := preg.PregledID;
  //ibsql.ParamByName('AMB_JOURNALN').AsInteger := 0;
  ibsql.ParamByName('DOCTOR_ID').AsInteger := preg.DoctorID;
  if pregNodes.incNaprNode <> nil then
  begin
    dataIncMN :=  Pointer(PByte(pregNodes.incNaprNode) + lenNode);
    dataRequester :=  Pointer(PByte(pregNodes.ReqesterNode) + lenNode);

    ibsql.ParamByName('copied_from_nrn').AsString :=
         Adb_DM.CollPregled.getAnsiStringMap(dataIncMN.DataPos, word(INC_NAPR_NRN));
    //ibsql.ParamByName('simp_napr_nrn').AsString :=
//         CollPreg.getAnsiStringMap(dataIncMN.DataPos, word(INC_NAPR_AMB_LIST_NRN));
    ibsql.ParamByName('simp_form_date').AsDate :=
         Adb_DM.CollPregled.getDateMap(dataIncMN.DataPos, word(INC_NAPR_ISSUE_DATE));
    ibsql.ParamByName('simp_praktika').AsString :=
         Adb_DM.CollPregled.getAnsiStringMap(dataRequester.DataPos, word(OtherDoctor_NOMER_LZ));
    ibsql.ParamByName('simp_uin').AsString :=
         Adb_DM.CollPregled.getAnsiStringMap(dataRequester.DataPos, word(OtherDoctor_UIN));
    ibsql.ParamByName('simp_speciality_code').AsInteger :=
         Adb_DM.CollPregled.getIntMap(dataRequester.DataPos, word(OtherDoctor_SPECIALITY));

    IncNaprlog := TlogicalINC_NAPRSet(Adb_DM.CollPregled.getLogical24Map(dataIncMN.DataPos, Word(INC_NAPR_Logical)));
  //intSet := IncNaprColl.GetNaprCode_Quick(IncNaprlog);
    intSet := NativeUInt(NaprGroup * IncNaprLog);
    case intSet of
      TNaprType(NaprMask_Ostro): ibsql.ParamByName('napr_type_id').Asinteger := 1; //txt.Text := 'Остро заболяване или състояние извън останалите типове';
      TNaprType(NaprMask_Hron): ibsql.ParamByName('napr_type_id').Asinteger := 2; //txt.Text := 'Хронично заболяване, неподлежащо на диспансерно наблюдение';
      TNaprType(NaprMask_Izbor): ibsql.ParamByName('napr_type_id').Asinteger := 3; //txt.Text := 'Избор на специалист за диспансерно наблюдение';
      TNaprType(NaprMask_Disp): ibsql.ParamByName('napr_type_id').Asinteger := 4; //txt.Text := 'Диспансерно наблюдение';
      TNaprType(NaprMask_Eksp): ibsql.ParamByName('napr_type_id').Asinteger := 5; //txt.Text := 'Медицинска експертиза';
      TNaprType(NaprMask_Prof): ibsql.ParamByName('napr_type_id').Asinteger := 6; //txt.Text := 'Профилактика нa пълнолетни лица';
      TNaprType(NaprMask_Iskane_Telk): ibsql.ParamByName('napr_type_id').Asinteger := 7; //txt.Text := 'По искане на ТЕЛК (НЕЛК)';
      TNaprType(NaprMask_Choice_Mother): ibsql.ParamByName('napr_type_id').Asinteger := 8; //txt.Text := 'Избор на специалист за майчино здравеопазване';
      TNaprType(NaprMask_Choice_Child): ibsql.ParamByName('napr_type_id').Asinteger := 9; //txt.Text := 'Избор на специалист за детско здравеопазване';
      TNaprType(NaprMask_PreChoice_Mother): ibsql.ParamByName('napr_type_id').Asinteger := 10; //txt.Text := 'Преизбор на специалист за майчино здравеопазване';
      TNaprType(NaprMask_PreChoice_Child): ibsql.ParamByName('napr_type_id').Asinteger := 11; //txt.Text := 'Преизбор на специалист за детско здравеопазване';
      TNaprType(NaprMask_Podg_Telk): ibsql.ParamByName('napr_type_id').Asinteger := 12; //txt.Text := 'Подготовка за ТЕЛК';
      TNaprType(NaprMask_Podg_LKK): ibsql.ParamByName('napr_type_id').Asinteger := 13; //txt.Text := 'Подготовка за ЛКК';
    end;
  end;


  ibsql.ParamByName('AMB_LISTN').AsInteger := preg.getIntMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_AMB_LISTN));
  ibsql.ParamByName('NRN').AsString := preg.getAnsiStringMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_NRN_LRN));
  ibsql.ParamByName('NZIS_STATUS').AsInteger := 6;//zzzzzzzzzzzzzzzzz preg.getWordMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_NZIS_STATUS));
  ibsql.ParamByName('START_DATE').AsDate := preg.getDateMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_START_DATE));
  ibsql.ParamByName('START_TIME').AsTime := 3 + preg.getTimeMap(AdbHip.Buf, AdbHip.FPosData, word(PregledNew_START_TIME));
  ibsql.ParamByName('PACIENT_ID').AsInteger := Adb_DM.CollPregled.getIntMap(datapat.DataPos, word(PatientNew_ID));
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
    ibsql.ParamByName('PAY').AsString := 'Y';//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
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
  if TLogicalPregledNew.IS_NAET in logPreg then
    ibsql.ParamByName('IS_NAET').AsString := 'Y'
  else
    ibsql.ParamByName('IS_NAET').AsString := 'N';
  if TLogicalPregledNew.IS_ZAMESTVASHT in logPreg then
    ibsql.ParamByName('IS_ZAMESTVASHT').AsString := 'Y'
  else
    ibsql.ParamByName('IS_ZAMESTVASHT').AsString := 'N';
  if TLogicalPregledNew.IS_PODVIZHNO_LZ in logPreg then
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
  if TLogicalPregledNew.IS_FORM_VALID in logPreg then
    ibsql.ParamByName('IS_FORM_VALID').AsString := 'Y'
  else
    ibsql.ParamByName('IS_FORM_VALID').AsString := 'Y';//zzzzzzzzzzzzzzzzzzzzzzz
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
    begin
      ibsql.ParamByName('AMB_PR').AsInteger := 2;
      ibsql.ParamByName('SIMP_PRIMARY_AMBLIST_NRN').Asstring := Adb_DM.CollPregled.getAnsiStringMap(dataPreg.DataPos, word(PregledNew_COPIED_FROM_NRN));
      ibsql.ParamByName('PrimNrn').Asstring := Adb_DM.CollPregled.getAnsiStringMap(dataPreg.DataPos, word(PregledNew_COPIED_FROM_NRN));
    end;
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

    diag := TRealDiagnosisItem.Create(Adb_DM.CollDiag);
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
      Adb_DM.CollDiag.MarkDelete(diag.DataPos);
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
    Adb_DM.CollDiag.streamComm.Len := Adb_DM.CollDiag.streamComm.Size;
    CmdFile.CopyFrom(Adb_DM.CollDiag.streamComm, 0);// това е за диагнозата
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
      Adb_DM.CollDiag.streamComm.Len := Adb_DM.CollDiag.streamComm.Size;
      CmdFile.CopyFrom(Adb_DM.CollDiag.streamComm, 0);
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
      cmdStream.Size := 12 + LenData ; //  delNode
      cmdStream.Ver := 0;
      cmdStream.Vid := ctLink;
      cmdStream.DataPos := cardinal(AdbLink.Buf);// тука това е буфера на настящето дърво
      cmdStream.Propertys := [];
      cmdStream.Position := 12;
      cmdStream.Write(bt, LenData);

      cmdStream.Len := cmdStream.Size;
      CmdFile.CopyFrom(cmdStream, 0);
      cmdStream.Free;
    end;
  end;
end;

procedure TDbHelper.UpdateDoctorField(ibsql: TIBSQL; TempItem: TRealDoctorItem);
var
  ibsqlDoctor: TIBSQL;
  data: PAspRec;
  dataPosition: Cardinal;
  buf: Pointer;
  datPos, linkPos: Cardinal;
  pCardinalData: PCardinal;
begin
  ibsqlDoctor := ibsql;
  buf := AdbHip.Buf;
  datPos := AdbHip.FPosData;

  if (not ibsqlDoctor.Fields[0].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(Doctor_EGN))<>ibsqlDoctor.Fields[0].AsString)
  then
  begin
     TempItem.PRecord.EGN := ibsqlDoctor.Fields[0].AsString;
     Include(TempItem.PRecord.setProp, Doctor_EGN);
  end;
  if (not ibsqlDoctor.Fields[1].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(Doctor_FNAME))<>ibsqlDoctor.Fields[1].AsString)
  then
  begin
     TempItem.PRecord.FNAME := ibsqlDoctor.Fields[1].AsString;
     Include(TempItem.PRecord.setProp, Doctor_FNAME);
  end;
  if (not ibsqlDoctor.Fields[2].IsNull)
      and (TempItem.getIntMap(buf, datPos, word(Doctor_ID))<>ibsqlDoctor.Fields[2].AsInteger)
  then
  begin
     TempItem.PRecord.ID := ibsqlDoctor.Fields[2].AsInteger;
     Include(TempItem.PRecord.setProp, Doctor_ID);
  end;
  if (not ibsqlDoctor.Fields[3].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(Doctor_LNAME))<>ibsqlDoctor.Fields[3].AsString)
  then
  begin
     TempItem.PRecord.LNAME := ibsqlDoctor.Fields[3].AsString;
     Include(TempItem.PRecord.setProp, Doctor_LNAME);
  end;
  if (not ibsqlDoctor.Fields[4].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(Doctor_SNAME))<>ibsqlDoctor.Fields[4].AsString)
  then
  begin
     TempItem.PRecord.SNAME := ibsqlDoctor.Fields[4].AsString;
     Include(TempItem.PRecord.setProp, Doctor_SNAME);
  end;
  if (not ibsqlDoctor.Fields[5].IsNull)
        and (TempItem.getAnsiStringMap(buf, datPos, word(Doctor_UIN))<>ibsqlDoctor.Fields[5].AsString)
  then
  begin
     TempItem.PRecord.UIN := ibsqlDoctor.Fields[5].AsString;
     Include(TempItem.PRecord.setProp, Doctor_UIN);
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

    //if (not ibsqlExamAnalysis.Fields[0].IsNull)
//        and (TempItem.getWordMap(buf, datPos, word(ExamAnalysis_ANALYSIS_ID))<>ibsqlExamAnalysis.Fields[0].AsInteger)
//    then
//    begin
//      TempItem.PRecord.ANALYSIS_ID := ibsqlExamAnalysis.Fields[0].AsInteger;
//      Include(TempItem.PRecord.setProp, ExamAnalysis_ANALYSIS_ID);
//    end;
//    if (not ibsqlExamAnalysis.Fields[1].IsNull)
//        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_BLANKA_MDN_ID))<>ibsqlExamAnalysis.Fields[1].AsInteger)
//    then
//    begin
//       TempItem.PRecord.BLANKA_MDN_ID := ibsqlExamAnalysis.Fields[1].AsInteger;
//       Include(TempItem.PRecord.setProp, ExamAnalysis_BLANKA_MDN_ID);
//    end;
    if (not ibsqlExamAnalysis.Fields[2].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(ExamAnalysis_DATA))<>ibsqlExamAnalysis.Fields[2].AsDate)
    then
    begin
      TempItem.PRecord.DATA := ibsqlExamAnalysis.Fields[2].AsDate;
      Include(TempItem.PRecord.setProp, ExamAnalysis_DATA);
    end;
    //if (not ibsqlExamAnalysis.Fields[3].IsNull)
//        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_EMDN_ID))<>ibsqlExamAnalysis.Fields[3].AsInteger)
//    then
//    begin
//       TempItem.PRecord.EMDN_ID := ibsqlExamAnalysis.Fields[3].AsInteger;
//       Include(TempItem.PRecord.setProp, ExamAnalysis_EMDN_ID);
//    end;
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
    //if (not ibsqlExamAnalysis.Fields[7].IsNull)
//        and (TempItem.getIntMap(buf, datPos, word(ExamAnalysis_PREGLED_ID))<>ibsqlExamAnalysis.Fields[7].AsInteger)
//    then
//    begin
//       TempItem.PRecord.PREGLED_ID := ibsqlExamAnalysis.Fields[7].AsInteger;
//       Include(TempItem.PRecord.setProp, ExamAnalysis_PREGLED_ID);
//    end;
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

procedure TDbHelper.UpdateKardProfField(ibsql: TIBSQL;
  TempItem: TRealKARTA_PROFILAKTIKA2017Item);
var
  ibsqlKARTA_PROFILAKTIKA2017: TIBSQL;
  diagNode, TreeLink: PVirtualNode;
  data: PAspRec;
  dataPosition: Cardinal;
  buf: Pointer;
  datPos, linkPos: Cardinal;
  pCardinalData: PCardinal;
begin
  ibsqlKARTA_PROFILAKTIKA2017 := ibsql;
  buf := AdbHip.Buf;
  datPos := AdbHip.FPosData;
      if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[0].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_BDDIASTOLNO43))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[0].AsInteger)
    then
    begin
       TempItem.PRecord.BDDIASTOLNO43 := ibsqlKARTA_PROFILAKTIKA2017.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDDIASTOLNO43);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[1].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_BDGIRTWAIST44))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[1].AsInteger)
    then
    begin
       TempItem.PRecord.BDGIRTWAIST44 := ibsqlKARTA_PROFILAKTIKA2017.Fields[1].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDGIRTWAIST44);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[2].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_BDHEIGHT39))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[2].AsInteger)
    then
    begin
       TempItem.PRecord.BDHEIGHT39 := ibsqlKARTA_PROFILAKTIKA2017.Fields[2].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDHEIGHT39);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[4].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_BDSYSTOLNO42))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[4].AsInteger)
    then
    begin
       TempItem.PRecord.BDSYSTOLNO42 := ibsqlKARTA_PROFILAKTIKA2017.Fields[4].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDSYSTOLNO42);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[5].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_BDWEIGHT40))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[5].AsInteger)
    then
    begin
       TempItem.PRecord.BDWEIGHT40 := ibsqlKARTA_PROFILAKTIKA2017.Fields[5].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_BDWEIGHT40);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[6].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[6].AsInteger)
    then
    begin
       TempItem.PRecord.CIGARETESCOUNT71 := ibsqlKARTA_PROFILAKTIKA2017.Fields[6].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[7].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_FINDRISK))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[7].AsInteger)
    then
    begin
       TempItem.PRecord.FINDRISK := ibsqlKARTA_PROFILAKTIKA2017.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_FINDRISK);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[8].IsNull)
        and (TempItem.getDateMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_ISSUE_DATE))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[8].AsDate)
    then
    begin
      TempItem.PRecord.ISSUE_DATE := ibsqlKARTA_PROFILAKTIKA2017.Fields[8].AsDate;
      Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_ISSUE_DATE);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[16].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_NOMER))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[16].AsInteger)
    then
    begin
       TempItem.PRecord.NOMER := ibsqlKARTA_PROFILAKTIKA2017.Fields[16].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_NOMER);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[17].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_PREGLED_ID))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[17].AsInteger)
    then
    begin
       TempItem.PRecord.PREGLED_ID := ibsqlKARTA_PROFILAKTIKA2017.Fields[17].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_PREGLED_ID);
    end;
    if (not ibsqlKARTA_PROFILAKTIKA2017.Fields[18].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(KARTA_PROFILAKTIKA2017_SCORE))<>ibsqlKARTA_PROFILAKTIKA2017.Fields[18].AsInteger)
    then
    begin
       TempItem.PRecord.SCORE := ibsqlKARTA_PROFILAKTIKA2017.Fields[18].AsInteger;
       Include(TempItem.PRecord.setProp, KARTA_PROFILAKTIKA2017_SCORE);
    end;
end;

procedure TDbHelper.UpdatePatientField(ibsql: TIBSQL;
  TempItem: TRealPatientNewItem);
var
  i: Integer;
  ibsqlPatientNew: TIBSQL;
  diagNode, TreeLink: PVirtualNode;
  data: PAspRec;
  diag, diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem;
  dataPosition: Cardinal;
  buf: Pointer;
  datPos, linkPos: Cardinal;
  pCardinalData: PCardinal;
  iEvn: Integer;
  BLOOD_TYPE: string;
  PidType: string;
  Is_change: Boolean;
begin
  ibsqlPatientNew := ibsql;
  buf := AdbHip.Buf;
  datPos := AdbHip.FPosData;
  if (not ibsqlPatientNew.Fields[0].IsNull)
        and (TempItem.getIntMap(buf, datPos, word(PatientNew_BABY_NUMBER))<>ibsqlPatientNew.Fields[0].AsInteger)
  then
  begin
     TempItem.PRecord.BABY_NUMBER := ibsqlPatientNew.Fields[0].AsInteger;
     Include(TempItem.PRecord.setProp, PatientNew_BABY_NUMBER);
  end;
  if (not ibsqlPatientNew.Fields[1].IsNull)
      and (TempItem.getDateMap(buf, datPos, word(PatientNew_BIRTH_DATE))<>ibsqlPatientNew.Fields[1].AsDate)
  then
  begin
    TempItem.PRecord.BIRTH_DATE := ibsqlPatientNew.Fields[1].AsDate;
    Include(TempItem.PRecord.setProp, PatientNew_BIRTH_DATE);
  end;
  if (not ibsqlPatientNew.Fields[2].IsNull)
      and (TempItem.getDateMap(buf, datPos, word(PatientNew_DIE_DATE))<>ibsqlPatientNew.Fields[2].AsDate)
  then
  begin
    TempItem.PRecord.DIE_DATE := ibsqlPatientNew.Fields[2].AsDate;
    Include(TempItem.PRecord.setProp, PatientNew_DIE_DATE);
  end;
  if (not ibsqlPatientNew.Fields[3].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_DIE_FROM))<>ibsqlPatientNew.Fields[3].AsString)
  then
  begin
    TempItem.PRecord.DIE_FROM := ibsqlPatientNew.Fields[3].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_DIE_FROM);
  end;
  if (not ibsqlPatientNew.Fields[4].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_DOSIENOMER))<>ibsqlPatientNew.Fields[4].AsString)
  then
  begin
    TempItem.PRecord.DOSIENOMER := ibsqlPatientNew.Fields[4].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_DOSIENOMER);
  end;
  if (not ibsqlPatientNew.Fields[5].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_DZI_NUMBER))<>ibsqlPatientNew.Fields[5].AsString)
  then
  begin
    TempItem.PRecord.DZI_NUMBER := ibsqlPatientNew.Fields[5].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_DZI_NUMBER);
  end;
  if (not ibsqlPatientNew.Fields[6].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_EGN))<>ibsqlPatientNew.Fields[6].AsString)
  then
  begin
    TempItem.PRecord.EGN := ibsqlPatientNew.Fields[6].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_EGN);
  end;
  if (not ibsqlPatientNew.Fields[7].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_EHIC_NO))<>ibsqlPatientNew.Fields[7].AsString)
  then
  begin
    TempItem.PRecord.EHIC_NO := ibsqlPatientNew.Fields[7].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_EHIC_NO);
  end;
  if (not ibsqlPatientNew.Fields[8].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_FNAME))<>ibsqlPatientNew.Fields[8].AsString)
  then
  begin
    TempItem.PRecord.FNAME := ibsqlPatientNew.Fields[8].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_FNAME);
  end;
  if (not ibsqlPatientNew.Fields[9].IsNull)
      and (TempItem.getIntMap(buf, datPos, word(PatientNew_ID))<>ibsqlPatientNew.Fields[9].AsInteger)
  then
  begin
     TempItem.PRecord.ID := ibsqlPatientNew.Fields[9].AsInteger;
     Include(TempItem.PRecord.setProp, PatientNew_ID);
  end;
  if (not ibsqlPatientNew.Fields[10].IsNull)
      and (TempItem.getIntMap(buf, datPos, word(PatientNew_LAK_NUMBER))<>ibsqlPatientNew.Fields[10].AsInteger)
  then
  begin
     TempItem.PRecord.LAK_NUMBER := ibsqlPatientNew.Fields[10].AsInteger;
     Include(TempItem.PRecord.setProp, PatientNew_LAK_NUMBER);
  end;
  if (not ibsqlPatientNew.Fields[11].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_LNAME))<>ibsqlPatientNew.Fields[11].AsString)
  then
  begin
    TempItem.PRecord.LNAME := ibsqlPatientNew.Fields[11].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_LNAME);
  end;
  if (not ibsqlPatientNew.Fields[12].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_NZIS_BEBE))<>ibsqlPatientNew.Fields[12].AsString)
  then
  begin
    TempItem.PRecord.NZIS_BEBE := ibsqlPatientNew.Fields[12].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_NZIS_BEBE);
  end;
  if (not ibsqlPatientNew.Fields[13].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_NZIS_PID))<>ibsqlPatientNew.Fields[13].AsString)
  then
  begin
    TempItem.PRecord.NZIS_PID := ibsqlPatientNew.Fields[13].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_NZIS_PID);
  end;
  if (not ibsqlPatientNew.Fields[15].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(PatientNew_SNAME))<>ibsqlPatientNew.Fields[15].AsString)
  then
  begin
    TempItem.PRecord.SNAME := ibsqlPatientNew.Fields[15].AsString;
    Include(TempItem.PRecord.setProp, PatientNew_SNAME);
  end;

  TempItem.PatID := ibsqlPatientNew.Fields[9].AsInteger;
  TempItem.PatEGN := ibsqlPatientNew.Fields[6].AsString;

  if not ibsqlPatientNew.Fields[16].IsNull then
  begin
    tempitem.HEALTH_INSURANCE_NAME := ibsqlPatientNew.Fields[16].AsString;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.HEALTH_INSURANCE_NAME, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NAME));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[17].IsNull) and (ibsqlPatientNew.Fields[17].AsString <> '') then
  begin
    tempitem.HEALTH_INSURANCE_NUMBER := ibsqlPatientNew.Fields[17].AsString;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.HEALTH_INSURANCE_NUMBER, 0, 0 ,0 , False, 0, HEALTH_INSURANCE_NUMBER));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[18].IsNull) and (ibsqlPatientNew.Fields[18].AsString <> '') then
  begin
    tempitem.DATA_HEALTH_INSURANCE := ibsqlPatientNew.Fields[18].AsString;
    //evn := AddEvents(tempitem.DATA_HEALTH_INSURANCE, 0, 0 ,0 , False, 0, DATA_HEALTH_INSURANCE);
//    evn.PatID := TempItem.PatID;
//    TempItem.FEventsPat.Add(evn);
//      iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.DATA_HEALTH_INSURANCE, 0, 0 ,0 , False, 0, DATA_HEALTH_INSURANCE));
     // TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[19].IsNull) and (ibsqlPatientNew.Fields[19].AsDate  <> 0) then
  begin
    tempitem.DATE_HEALTH_INSURANCE_CHECK := ibsqlPatientNew.Fields[19].AsDate;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATE_HEALTH_INSURANCE_CHECK, 0 ,0 , False, 0, DATE_HEALTH_INSURANCE_CHECK));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[20].IsNull) and (ibsqlPatientNew.Fields[20].AsTime  <> 0) and (ibsqlPatientNew.Fields[19].AsDate  <> 0) then
  begin
    tempitem.TIME_HEALTH_INSURANCE_CHECK := ibsqlPatientNew.Fields[20].AsTime;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('',0 , 0 ,tempitem.TIME_HEALTH_INSURANCE_CHECK , False, 0, TIME_HEALTH_INSURANCE_CHECK));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;

  if (not ibsqlPatientNew.Fields[21].IsNull) and (ibsqlPatientNew.Fields[21].AsDate  <> 0) then
  begin
    tempitem.DATE_OTPISVANE := ibsqlPatientNew.Fields[21].AsDate;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATE_OTPISVANE, 0 ,0 , False, 0, DATE_OTPISVANE));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[22].IsNull) and (ibsqlPatientNew.Fields[22].AsDate  <> 0) then
  begin
    tempitem.DATE_ZAPISVANE := ibsqlPatientNew.Fields[22].AsDate;
    //Is_change := True;
//    for i := 0 to TempItem.FEventsPat.Count - 1 do
//    begin
//      if (TlogicalEventsManyTimesSet(TempItem.FEventsPat[i].getLogical24Map(buf, AdbHip.FPosData, word(EventsManyTimes_Logical))) = [DATE_ZAPISVANE])
//          and (TempItem.FEventsPat[i].getDateMap(buf, AdbHip.FPosData, word(EventsManyTimes_valTDate)) = tempitem.DATE_ZAPISVANE) then
//      begin
//        Is_change := False;
//        Break;
//      end;
//    end;
//    if Is_change then
//    begin
//      iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATE_ZAPISVANE, 0 ,0 , False, 0, DATE_ZAPISVANE));
//      TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
//    end;
  end;
  if (not ibsqlPatientNew.Fields[23].IsNull) and (ibsqlPatientNew.Fields[23].AsDate  <> 0) then
  begin
    tempitem.DATEFROM := ibsqlPatientNew.Fields[23].AsDate;
    //iEvn := TempItem.FEventsPat.Add(AddEvents('', tempitem.DATEFROM, 0 ,0 , False, 0, DATEFROM));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;



  tempitem.DATEISSUE := ibsqlPatientNew.Fields[24].AsDate;
  tempitem.DATETO := ibsqlPatientNew.Fields[25].AsDate;
  tempitem.DATETO_TEXT := ibsqlPatientNew.Fields[26].AsString;
  tempitem.GRAJD := ibsqlPatientNew.Fields[27].AsString;
  tempitem.IS_NEBL_USL := ibsqlPatientNew.Fields[28].AsString = 'Y';
  tempitem.OSIGNO := ibsqlPatientNew.Fields[29].AsString;
  tempitem.OSIGUREN := ibsqlPatientNew.Fields[30].AsString = 'Y';
  tempitem.PASS := ibsqlPatientNew.Fields[31].AsString;
  tempitem.PREVIOUS_DOCTOR_ID := ibsqlPatientNew.Fields[32].AsInteger;
  tempitem.TYPE_CERTIFICATE := ibsqlPatientNew.Fields[33].AsString;
  tempitem.FUND_ID := ibsqlPatientNew.Fields[34].AsInteger;
  tempitem.PAT_KIND := ibsqlPatientNew.Fields[35].AsInteger;
  if (not ibsqlPatientNew.Fields[36].IsNull) then
  begin
    tempitem.RZOK := ibsqlPatientNew.Fields[36].AsString;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.RZOK, UserDate, 0 ,0 , False, 0, RZOK));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[37].IsNull) then
  begin
    tempitem.RZOKR := ibsqlPatientNew.Fields[37].AsString;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.RZOKR, UserDate, 0 ,0 , False, 0, RZOKR));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  if (not ibsqlPatientNew.Fields[48].IsNull) then
  begin
    tempitem.NAS_MQSTO := ibsqlPatientNew.Fields[48].AsString;
    //iEvn := TempItem.FEventsPat.Add(AddEvents(tempitem.NAS_MQSTO, UserDate, 0 ,0 , False, 0, NAS_MQSTO));
//    TempItem.FEventsPat[iEvn].PatID := TempItem.PatID;
  end;
  tempitem.DoctorId := ibsqlPatientNew.Fields[47].AsInteger;
  // logical
  TempItem.PRecord.Logical := [];
  BLOOD_TYPE := Trim(ibsqlPatientNew.Fields[38].AsString);
  if BLOOD_TYPE = '0' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_0);
  if BLOOD_TYPE = 'A' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A);
  if BLOOD_TYPE = 'A1' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A1);
  if BLOOD_TYPE = 'A2' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A2);
  if BLOOD_TYPE = 'A1B' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A1B);
  if BLOOD_TYPE = 'A2B' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_A2B);
  if BLOOD_TYPE = 'AB' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_AB);
  if BLOOD_TYPE = 'B' then
    Include(TempItem.PRecord.Logical, BLOOD_TYPE_B);



  if ibsqlPatientNew.Fields[39].Asinteger = 1 then
    Include(TempItem.PRecord.Logical, SEX_TYPE_M)
  else
    Include(TempItem.PRecord.Logical, SEX_TYPE_F);

  PidType := Trim(ibsqlPatientNew.Fields[45].AsString);
  if PidType = 'E' then
    Include(TempItem.PRecord.Logical, PID_TYPE_E);
  if PidType = 'B' then
    Include(TempItem.PRecord.Logical, PID_TYPE_B);
  if PidType = 'L' then
    Include(TempItem.PRecord.Logical, PID_TYPE_L);
  if PidType = 'S' then
    Include(TempItem.PRecord.Logical, PID_TYPE_S);
  if PidType = 'F' then
    Include(TempItem.PRecord.Logical, PID_TYPE_F);



  if (TempItem.PRecord.Logical <> [])
  and (TempItem.getLogical40map(buf, datPos, word(PatientNew_Logical))<> tlogicaldata40(TempItem.PRecord.Logical)) then
    Include(TempItem.PRecord.setProp, PatientNew_Logical);
end;

procedure TDbHelper.UpdatePracticaField(ibsql: TIBSQL;
  TempItem: TPracticaItem);
var
    ibsqlPractica: TIBSQL;
    diagNode, TreeLink: PVirtualNode;
    data: PAspRec;
    diag, diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem;
    dataPosition: Cardinal;
    buf: Pointer;
    datPos, linkPos: Cardinal;
    pCardinalData: PCardinal;
begin
  ibsqlPractica := ibsql;
  buf := AdbHip.Buf;
  datPos := AdbHip.FPosData;
  if (not ibsqlPractica.Fields[0].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_ADDRESS_ACT))<>ibsqlPractica.Fields[0].AsString)
  then
  begin
    TempItem.PRecord.ADDRESS_ACT := ibsqlPractica.Fields[0].AsString;
    Include(TempItem.PRecord.setProp, Practica_ADDRESS_ACT);
  end;
  if (not ibsqlPractica.Fields[1].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_ADDRESS_DOGNZOK))<>ibsqlPractica.Fields[1].AsString)
  then
  begin
    TempItem.PRecord.ADDRESS_DOGNZOK := ibsqlPractica.Fields[1].AsString;
    Include(TempItem.PRecord.setProp, Practica_ADDRESS_DOGNZOK);
  end;
  if (not ibsqlPractica.Fields[2].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_ADRES))<>ibsqlPractica.Fields[2].AsString)
  then
  begin
    TempItem.PRecord.ADRES := ibsqlPractica.Fields[2].AsString;
    Include(TempItem.PRecord.setProp, Practica_ADRES);
  end;
  if (not ibsqlPractica.Fields[3].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_BANKA))<>ibsqlPractica.Fields[3].AsString)
  then
  begin
    TempItem.PRecord.BANKA := ibsqlPractica.Fields[3].AsString;
    Include(TempItem.PRecord.setProp, Practica_BANKA);
  end;
  if (not ibsqlPractica.Fields[4].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_BANKOW_KOD))<>ibsqlPractica.Fields[4].AsString)
  then
  begin
    TempItem.PRecord.BANKOW_KOD := ibsqlPractica.Fields[4].AsString;
    Include(TempItem.PRecord.setProp, Practica_BANKOW_KOD);
  end;
  if (not ibsqlPractica.Fields[5].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_BULSTAT))<>ibsqlPractica.Fields[5].AsString)
  then
  begin
    TempItem.PRecord.BULSTAT := ibsqlPractica.Fields[5].AsString;
    Include(TempItem.PRecord.setProp, Practica_BULSTAT);
  end;
  if (not ibsqlPractica.Fields[6].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_COMPANYNAME))<>ibsqlPractica.Fields[6].AsString)
  then
  begin
    TempItem.PRecord.COMPANYNAME := ibsqlPractica.Fields[6].AsString;
    Include(TempItem.PRecord.setProp, Practica_COMPANYNAME);
  end;
  if (not ibsqlPractica.Fields[7].IsNull)
      and (TempItem.getDateMap(buf, datPos, word(Practica_CONTRACT_DATE))<>ibsqlPractica.Fields[7].AsDate)
  then
  begin
    TempItem.PRecord.CONTRACT_DATE := ibsqlPractica.Fields[7].AsDate;
    Include(TempItem.PRecord.setProp, Practica_CONTRACT_DATE);
  end;
  if (not ibsqlPractica.Fields[8].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_CONTRACT_RZOK))<>ibsqlPractica.Fields[8].AsString)
  then
  begin
    TempItem.PRecord.CONTRACT_RZOK := ibsqlPractica.Fields[8].AsString;
    Include(TempItem.PRecord.setProp, Practica_CONTRACT_RZOK);
  end;
  if (not ibsqlPractica.Fields[9].IsNull)
      and (TempItem.getWordMap(buf, datPos, word(Practica_CONTRACT_TYPE))<>ibsqlPractica.Fields[9].AsInteger)
  then
  begin
    TempItem.PRecord.CONTRACT_TYPE := ibsqlPractica.Fields[9].AsInteger;
    Include(TempItem.PRecord.setProp, Practica_CONTRACT_TYPE);
  end;
  if (not ibsqlPractica.Fields[10].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_DAN_NOMER))<>ibsqlPractica.Fields[10].AsString)
  then
  begin
    TempItem.PRecord.DAN_NOMER := ibsqlPractica.Fields[10].AsString;
    Include(TempItem.PRecord.setProp, Practica_DAN_NOMER);
  end;
  if (not ibsqlPractica.Fields[11].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_EGN))<>ibsqlPractica.Fields[11].AsString)
  then
  begin
    TempItem.PRecord.EGN := ibsqlPractica.Fields[11].AsString;
    Include(TempItem.PRecord.setProp, Practica_EGN);
  end;
  if (not ibsqlPractica.Fields[12].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_FNAME))<>ibsqlPractica.Fields[12].AsString)
  then
  begin
    TempItem.PRecord.FNAME := ibsqlPractica.Fields[12].AsString;
    Include(TempItem.PRecord.setProp, Practica_FNAME);
  end;
  if (not ibsqlPractica.Fields[13].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_FULLNAME))<>ibsqlPractica.Fields[13].AsString)
  then
  begin
    TempItem.PRecord.FULLNAME := ibsqlPractica.Fields[13].AsString;
    Include(TempItem.PRecord.setProp, Practica_FULLNAME);
  end;
  //if (not ibsqlPractica.Fields[14].IsNull)
//      and (TempItem.getBooleanMap(buf, datPos, word(Practica_INVOICECOMPANY))<>(ibsqlPractica.Fields[14].Asstring = 'Y'))
//  then
//  begin
//    TempItem.PRecord.INVOICECOMPANY := ibsqlPractica.Fields[14].AsString = 'Y';
//    Include(TempItem.PRecord.setProp, Practica_INVOICECOMPANY);
//  end;
//  if (not ibsqlPractica.Fields[15].IsNull)
//      and (TempItem.getBooleanMap(buf, datPos, word(Practica_ISSUER_TYPE))<>(ibsqlPractica.Fields[15].Asstring = 'Y'))
//  then
//  begin
//    TempItem.PRecord.ISSUER_TYPE := ibsqlPractica.Fields[15].AsString = 'Y';
//    Include(TempItem.PRecord.setProp, Practica_ISSUER_TYPE);
//  end;
//  if (not ibsqlPractica.Fields[16].IsNull)
//      and (TempItem.getBooleanMap(buf, datPos, word(Practica_IS_SAMOOSIG))<>(ibsqlPractica.Fields[16].Asstring = 'Y'))
//  then
//  begin
//    TempItem.PRecord.IS_SAMOOSIG := ibsqlPractica.Fields[16].AsString = 'Y';
//    Include(TempItem.PRecord.setProp, Practica_IS_SAMOOSIG);
//  end;
  if (not ibsqlPractica.Fields[17].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_KOD_RAJON))<>ibsqlPractica.Fields[17].AsString)
  then
  begin
    TempItem.PRecord.KOD_RAJON := ibsqlPractica.Fields[17].AsString;
    Include(TempItem.PRecord.setProp, Practica_KOD_RAJON);
  end;
  if (not ibsqlPractica.Fields[18].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_KOD_RZOK))<>ibsqlPractica.Fields[18].AsString)
  then
  begin
    TempItem.PRecord.KOD_RZOK := ibsqlPractica.Fields[18].AsString;
    Include(TempItem.PRecord.setProp, Practica_KOD_RZOK);
  end;
  if (not ibsqlPractica.Fields[19].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_LNAME))<>ibsqlPractica.Fields[19].AsString)
  then
  begin
    TempItem.PRecord.LNAME := ibsqlPractica.Fields[19].AsString;
    Include(TempItem.PRecord.setProp, Practica_LNAME);
  end;
  if (not ibsqlPractica.Fields[20].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_LNCH))<>ibsqlPractica.Fields[20].AsString)
  then
  begin
    TempItem.PRecord.LNCH := ibsqlPractica.Fields[20].AsString;
    Include(TempItem.PRecord.setProp, Practica_LNCH);
  end;
  if (not ibsqlPractica.Fields[21].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_NAME))<>ibsqlPractica.Fields[21].AsString)
  then
  begin
    TempItem.PRecord.NAME := ibsqlPractica.Fields[21].AsString;
    Include(TempItem.PRecord.setProp, Practica_NAME);
  end;
  if (not ibsqlPractica.Fields[22].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_NAS_MQSTO))<>ibsqlPractica.Fields[22].AsString)
  then
  begin
    TempItem.PRecord.NAS_MQSTO := ibsqlPractica.Fields[22].AsString;
    Include(TempItem.PRecord.setProp, Practica_NAS_MQSTO);
  end;
  if (not ibsqlPractica.Fields[24].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_NOMER_LZ))<>ibsqlPractica.Fields[24].AsString)
  then
  begin
    TempItem.PRecord.NOMER_LZ := ibsqlPractica.Fields[24].AsString;
    Include(TempItem.PRecord.setProp, Practica_NOMER_LZ);
  end;
  if (not ibsqlPractica.Fields[25].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_NOM_NAP))<>ibsqlPractica.Fields[25].AsString)
  then
  begin
    TempItem.PRecord.NOM_NAP := ibsqlPractica.Fields[25].AsString;
    Include(TempItem.PRecord.setProp, Practica_NOM_NAP);
  end;
  if (not ibsqlPractica.Fields[26].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_NZOK_NOMER))<>ibsqlPractica.Fields[26].AsString)
  then
  begin
    TempItem.PRecord.NZOK_NOMER := ibsqlPractica.Fields[26].AsString;
    Include(TempItem.PRecord.setProp, Practica_NZOK_NOMER);
  end;
  if (not ibsqlPractica.Fields[27].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_OBLAST))<>ibsqlPractica.Fields[27].AsString)
  then
  begin
    TempItem.PRecord.OBLAST := ibsqlPractica.Fields[27].AsString;
    Include(TempItem.PRecord.setProp, Practica_OBLAST);
  end;
  if (not ibsqlPractica.Fields[28].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_OBSHTINA))<>ibsqlPractica.Fields[28].AsString)
  then
  begin
    TempItem.PRecord.OBSHTINA := ibsqlPractica.Fields[28].AsString;
    Include(TempItem.PRecord.setProp, Practica_OBSHTINA);
  end;
  //if (not ibsqlPractica.Fields[29].IsNull)
//      and (TempItem.getBooleanMap(buf, datPos, word(Practica_SELF_INSURED_DECLARATION))<>(ibsqlPractica.Fields[29].Asstring = 'Y'))
//  then
//  begin
//    TempItem.PRecord.SELF_INSURED_DECLARATION := ibsqlPractica.Fields[29].AsString = 'Y';
//    Include(TempItem.PRecord.setProp, Practica_SELF_INSURED_DECLARATION);
//  end;
  if (not ibsqlPractica.Fields[30].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_SMETKA))<>ibsqlPractica.Fields[30].AsString)
  then
  begin
    TempItem.PRecord.SMETKA := ibsqlPractica.Fields[30].AsString;
    Include(TempItem.PRecord.setProp, Practica_SMETKA);
  end;
  if (not ibsqlPractica.Fields[31].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_SNAME))<>ibsqlPractica.Fields[31].AsString)
  then
  begin
    TempItem.PRecord.SNAME := ibsqlPractica.Fields[31].AsString;
    Include(TempItem.PRecord.setProp, Practica_SNAME);
  end;
  if (not ibsqlPractica.Fields[32].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_UPRAVITEL))<>ibsqlPractica.Fields[32].AsString)
  then
  begin
    TempItem.PRecord.UPRAVITEL := ibsqlPractica.Fields[32].AsString;
    Include(TempItem.PRecord.setProp, Practica_UPRAVITEL);
  end;
  if (not ibsqlPractica.Fields[33].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_VIDFIRMA))<>ibsqlPractica.Fields[33].AsString)
  then
  begin
    TempItem.PRecord.VIDFIRMA := ibsqlPractica.Fields[33].AsString;
    Include(TempItem.PRecord.setProp, Practica_VIDFIRMA);
  end;
  if (not ibsqlPractica.Fields[34].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_VID_IDENT))<>ibsqlPractica.Fields[34].AsString)
  then
  begin
    TempItem.PRecord.VID_IDENT := ibsqlPractica.Fields[34].AsString;
    Include(TempItem.PRecord.setProp, Practica_VID_IDENT);
  end;
  if (not ibsqlPractica.Fields[35].IsNull)
      and (TempItem.getAnsiStringMap(buf, datPos, word(Practica_VID_PRAKTIKA))<>ibsqlPractica.Fields[35].AsString)
  then
  begin
    TempItem.PRecord.VID_PRAKTIKA := ibsqlPractica.Fields[35].AsString;
    Include(TempItem.PRecord.setProp, Practica_VID_PRAKTIKA);
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
        and (TempItem.getAnsiStringMap(buf, datPos, word(PregledNew_NRN_LRN))<>ibsqlPregledNew.Fields[12].AsString)
    then
    begin
      TempItem.PRecord.NRN_LRN := ibsqlPregledNew.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, PregledNew_NRN_LRN);
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
