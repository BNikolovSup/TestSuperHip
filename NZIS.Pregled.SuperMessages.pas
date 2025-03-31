unit NZIS.Pregled.SuperMessages;
                      //postmessage    baseon  pacient
interface
uses
  System.SysUtils, system.Classes,Winapi.Windows, System.Generics.Collections,
  NzisSuperCollection, NZISSuperAddress, Nzis.Types, NZIS.nomenklatura, NZIS.Functions,
  NZIS.XMLschems, NZIS.SuperMessages,
  Xml.XMLIntf, Xml.XMLDoc,
  IBX.IBSQL;

type
  TPregledMessages = class(TNZISMessages)
  private
  public
    constructor create;override;
    destructor destroy;override;
    procedure FindSender(senderId: integer);

    procedure AddFullPregled(preg: TPregledNzisItem);
    procedure GenerateX001(preg: TPregledNzisItem);
    procedure GenerateX003(preg: TPregledNzisItem);
    procedure GenerateX005(preg: TPregledNzisItem);
    procedure GenerateX005EGN(dateExam: TDate; egn: string; PidType: Integer);
    procedure GenerateX005NRN(NRN: string);
    procedure GenerateX005LRN(LRN: string; fromDate: TDate);
    procedure GenerateX007(preg: TPregledNzisItem);
    procedure GenerateX009(preg: TPregledNzisItem);
    procedure GenerateX011(preg: TPregledNzisItem);
    procedure GenerateX013(preg: TPregledNzisItem);
  end;

implementation

{ TPregledMessages }

procedure TPregledMessages.AddFullPregled(preg: TPregledNzisItem);
var

  i, j, k: Integer;
  obl: TOblastItem;
  obsht: TObshtinaItem;
  nasMesto: TNasMestoItem;

  DiagReport: TDiagnosticReport;
  Diag: TDiagnosisBasic;

begin
  preg.DiagnosticReport.Clear;
  preg.Comorbidity.Clear;
  FPerformer := preg.Performer;
  ibsqlCommand.Close;
  if PregledColl.FNzisNomen = nil then
    PregledColl.FNzisNomen := TNzisNomen.create;
  if not IsGP then
  begin
    ibsqlCommand.SQL.Text :=
        'select' + #13#10 +
        'START_TIME,' + #13#10 +
        'AMB_PR,' + #13#10 +
        'DOM_PR,' + #13#10 +
        'IS_DISPANSERY,' + #13#10 +
        'VISIT_ID,' + #13#10 +
        'VISIT_TYPE_ID,' + #13#10 +
        'FUND_ID,' + #13#10 +
        'is_consultation,' + #13#10 +
        'IS_PREVENTIVE,' + #13#10 +
        'PREVENTIVE_TYPE,' + #13#10 +
        'is_dispansery,' + #13#10 +  //10
        'is_vsd,' + #13#10 +
        'is_hospitalization,' + #13#10 +
        'is_expertiza,' + #13#10 +
        'is_telk,' + #13#10 +
        'procedure1_mkb,' + #13#10 + //15
        'procedure2_mkb,' + #13#10 +
        'procedure3_mkb,' + #13#10 +
        'procedure4_mkb,' + #13#10 +
        'main_diag_mkb,' + #13#10 +
        'main_diag_mkb_add,' + #13#10 + //20
        'gs,' + #13#10 +
        'pr_zab1_mkb,' + #13#10 +
        'pr_zab2_mkb,' + #13#10 +
        'pr_zab3_mkb,' + #13#10 +
        'pr_zab4_mkb,' + #13#10 + //25
        'pr_zab1_mkb_add,' + #13#10 +
        'pr_zab2_mkb_add,' + #13#10 +
        'pr_zab3_mkb_add,' + #13#10 +
        'pr_zab4_mkb_add,' + #13#10 +
        'IS_RECEPTA_HOSPIT,' + #13#10 + //30
        'coalesce(simp_napr_n, simp_primary_amblist_n) as PrevAL,' + #13#10 +

         'lkk_komisii_id,' + #13#10 +
         'reh_finished_at,' + #13#10 +
         'reh_proc1,' + #13#10 +
         'reh_proc2,' + #13#10 + //35
         'reh_proc3,' + #13#10 +
         'reh_proc4,' + #13#10 +
         'is_risk_group, ' + #13#10 +
         'SIMP_PRIMARY_AMBLIST_DATE, ' + #13#10 +
         'COPIED_FROM_NRN, ' + #13#10 +
         'ANAMN, ' + #13#10 +
         'SYST, ' + #13#10 +
         'TERAPY, ' + #13#10 +
         'IZSL, ' + #13#10 +
         'sd.sign_picture ' + #13#10 +
        'from pregled' + #13#10 +
        'left join sign_document sd on sd.document_id = pregled.id and sd.document_type = 0 '   + #13#10 +
        'where pregled.id= :id';


    ibsqlCommand.ParamByName('id').AsInteger := preg.PregledId;
    ibsqlCommand.ExecQuery;



    preg.OpenDate := Int(preg.StartDate) + ibsqlCommand.Fields[0].AsTime;
    preg.AMB_PR := ibsqlCommand.Fields[1].AsInteger;
    preg.DOM_PR := ibsqlCommand.Fields[2].AsInteger;
    preg.IS_DISPANSERY := ibsqlCommand.Fields[3].AsString = 'Y';
    preg.VISIT_ID := ibsqlCommand.Fields[4].AsInteger;

    preg.FUND_ID := ibsqlCommand.Fields[6].AsInteger;
    if ibsqlCommand.Fields[7].AsString = 'Y' then
      preg.Purpose := pbConsult;
    if ibsqlCommand.Fields[8].AsString = 'Y' then
    begin
      case ibsqlCommand.Fields[9].AsInteger of
        1:
        begin
          preg.Purpose := pbChildHealthcare;
          preg.ChildHealthcare := TChildHealthcare.Create;
        end;
        2:
        begin
          if ibsqlCommand.Fields[38].AsString = 'Y' then
            preg.Purpose := pbProfRisk
          else
            preg.Purpose := pbProfFrom18;
        end;
        3:
        begin
          preg.Purpose := pbMotherHealthcare;
          preg.MotherHealthcare := TMotherHealthcare.Create;
          if preg.Diagnosis.Code <> 'Z39.2' then
          begin
            preg.MotherHealthcare.IsPregnant := True;
            preg.MotherHealthcare.GestationalWeek := ibsqlCommand.Fields[21].AsInteger;
            preg.MotherHealthcare.IsBreastFeeding := False;
          end
          else
          begin
            preg.MotherHealthcare.IsPregnant := false;
            preg.MotherHealthcare.GestationalWeek := 0;
            preg.MotherHealthcare.IsBreastFeeding := true;
          end;
        end;
      end;
    end;

    if ibsqlCommand.Fields[10].AsString = 'Y' then
      preg.Purpose := pbDisp;
    if ibsqlCommand.Fields[11].AsString = 'Y' then
      preg.Purpose := pbVSD;
    if ibsqlCommand.Fields[12].AsString = 'Y' then
      preg.Purpose := pbHosp;
    if ibsqlCommand.Fields[13].AsString = 'Y' then
      preg.Purpose := pbExpert;
    if ibsqlCommand.Fields[14].AsString = 'Y' then
      preg.Purpose := pbTelk;

    if not ibsqlCommand.Fields[15].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[15].AsString;
      if not ibsqlCommand.Fields[34].IsNull then
        DiagReport.NumberPerformed := ibsqlCommand.Fields[34].AsInteger
      else
        DiagReport.NumberPerformed := 1;
      if ibsqlCommand.Fields[33].AsDate = 0 then
        DiagReport.Status := msRegistered
      else
        DiagReport.Status := msFinal;

      preg.DiagnosticReport.add(DiagReport)
    end;

    if not ibsqlCommand.Fields[16].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[16].AsString;
      if not ibsqlCommand.Fields[35].IsNull then
        DiagReport.NumberPerformed := ibsqlCommand.Fields[35].AsInteger
      else
        DiagReport.NumberPerformed := 1;
      if ibsqlCommand.Fields[33].AsDate = 0 then
        DiagReport.Status := msRegistered
      else
        DiagReport.Status := msFinal;
      preg.DiagnosticReport.add(DiagReport)
    end;

    if not ibsqlCommand.Fields[17].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[17].AsString;
      if not ibsqlCommand.Fields[36].IsNull then
        DiagReport.NumberPerformed := ibsqlCommand.Fields[36].AsInteger
      else
        DiagReport.NumberPerformed := 1;
      if ibsqlCommand.Fields[33].AsDate = 0 then
        DiagReport.Status := msRegistered
      else
        DiagReport.Status := msFinal;
      preg.DiagnosticReport.add(DiagReport)
    end;

    if not ibsqlCommand.Fields[18].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[18].AsString;
      if not ibsqlCommand.Fields[37].IsNull then
        DiagReport.NumberPerformed := ibsqlCommand.Fields[37].AsInteger
      else
        DiagReport.NumberPerformed := 1;
      if ibsqlCommand.Fields[33].AsDate = 0 then
        DiagReport.Status := msRegistered
      else
        DiagReport.Status := msFinal;
      preg.DiagnosticReport.add(DiagReport)
    end;
    preg.Diagnosis.Code := ibsqlCommand.Fields[19].AsString;
    preg.Diagnosis.Use := dubChiefComplaint;
    preg.Diagnosis.Rank := 1;
    preg.Diagnosis.AdditionalCode := ibsqlCommand.Fields[20].AsString;

    if not ibsqlCommand.Fields[22].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[22].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[26].AsString;
    end;

    if not ibsqlCommand.Fields[23].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[23].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[27].AsString;
    end;

    if not ibsqlCommand.Fields[24].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[24].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[28].AsString;
    end;

    if not ibsqlCommand.Fields[25].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[25].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[29].AsString;
    end;
    if ibsqlCommand.Fields[30].AsString = 'Y' then
      preg.Purpose := pbHosp;

    preg.BasedOn := TAlphanumericString.Create;
    preg.BasedOn.Value := ibsqlCommand.Fields[31].AsString;
    preg.PrevAmbDate := ibsqlCommand.Fields[39].AsDate;
    preg.COPIED_FROM_NRN := ibsqlCommand.Fields[40].AsString;
    preg.MedicalHistory := ibsqlCommand.Fields[41].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.ObjectiveCondition := ibsqlCommand.Fields[42].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.Therapy := ibsqlCommand.Fields[43].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.Assessment := ibsqlCommand.Fields[44].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.PatientSignature := preg.StrOfFieldSign(ibsqlCommand.Fields[45]);


    preg.LkkId := ibsqlCommand.Fields[32].AsInteger;
    preg.VisitTypeId := TVisitType(ibsqlCommand.Fields[5].AsInteger); // сложено е тука, че да може да заамаже всички останали пурпосе-та


    if preg.LkkId > 0 then
    begin
      preg.Accompanying := TList<TPerformerItem>.create;
      ibsqlCommand.Close;
      ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'lkk.doctor1_id,' + #13#10 +
      'lkk.doctor2_id,' + #13#10 +
      'lkk.doctor3_id,' + #13#10 +
      'lkk.doctor4_id,' + #13#10 +
      'lkk.doctor5_id' + #13#10 +
      '' + #13#10 +
      'from lkk_komisii lkk' + #13#10 +
      'where lkk.id = :Lkk_id';
      ibsqlCommand.ParamByName('Lkk_id').AsInteger := preg.LkkId;
      ibsqlCommand.ExecQuery;
      while not ibsqlCommand.Eof do
      begin
        for i := 1 to 4 do
        begin
          if not ibsqlCommand.Fields[i].IsNull then
          begin
            for j := 0 to DoctorColl.Count - 1 do
            begin
              if DoctorColl.Items[j].DoctorId = ibsqlCommand.Fields[i].AsInteger then
              begin
                preg.Accompanying.Add(DoctorColl.Items[j]);
                Break;
              end;
            end;
          end;
        end;
        ibsqlCommand.Next;
      end;
    end;

  end
  else
  begin
    ibsqlCommand.SQL.Text :=
        'select' + #13#10 +
        'START_TIME,' + #13#10 +
        'AMB_PR,' + #13#10 +
        'DOM_PR,' + #13#10 +
        'IS_DISPANSERY,' + #13#10 +
        'pay,' + #13#10 +
        'doctor_id,' + #13#10 +  //5
        'doctor_id,' + #13#10 +// за изравн€ване

        'is_consultation,' + #13#10 +
        'IS_PREVENTIVE,' + #13#10 +
        'PREVENTIVE_TYPE,' + #13#10 +
        'is_dispansery,' + #13#10 + //10
        'is_vsd,' + #13#10 +
        'is_hospitalization,' + #13#10 +
        'is_expertiza,' + #13#10 +
        'is_telk,' + #13#10 +
        'procedure1_mkb,' + #13#10 +  //15
        'procedure2_mkb,' + #13#10 +
        'procedure3_mkb,' + #13#10 +
        'procedure4_mkb,' + #13#10 +
        'main_diag_mkb,' + #13#10 +
        'main_diag_mkb_add,' + #13#10 + //20
        'gs,' + #13#10 +
        'pr_zab1_mkb,' + #13#10 +
        'pr_zab2_mkb,' + #13#10 +
        'pr_zab3_mkb,' + #13#10 +
        'pr_zab4_mkb,' + #13#10 +  //25
        'pr_zab1_mkb_add,' + #13#10 +
        'pr_zab2_mkb_add,' + #13#10 +
        'pr_zab3_mkb_add,' + #13#10 +
        'pr_zab4_mkb_add,' + #13#10 +
        'IS_RECEPTA_HOSPIT, ' + #13#10 + //30
        'is_risk_group, ' + #13#10 +
        'IS_BABY_CARE, ' + #13#10 +
        'ANAMN, ' + #13#10 +
        'SYST, ' + #13#10 +
        'TERAPY, ' + #13#10 +  //35
        'IZSL, ' + #13#10 +

        'sd.sign_picture ' + #13#10 +  //37
        'from pregled ' + #13#10 +
        'left join sign_document sd on sd.document_id = pregled.id and sd.document_type = 0 '   + #13#10 +
        'where pregled.id= :id';

    ibsqlCommand.ParamByName('id').AsInteger := preg.PregledId;
    ibsqlCommand.ExecQuery;

    preg.OpenDate := Int(preg.StartDate) + ibsqlCommand.Fields[0].AsTime;
    preg.AMB_PR := ibsqlCommand.Fields[1].AsInteger;
    preg.DOM_PR := ibsqlCommand.Fields[2].AsInteger;
    preg.IS_DISPANSERY := ibsqlCommand.Fields[3].AsString = 'Y';
    if ibsqlCommand.Fields[4].AsString = 'Y' then
      preg.FinancingSource := fsNHIF
    else
      preg.FinancingSource := fsPatient;
    preg.DoctorID := ibsqlCommand.Fields[5].AsInteger;



   if ibsqlCommand.Fields[7].AsString = 'Y' then
      preg.Purpose := pbConsult;
    if ibsqlCommand.Fields[8].AsString = 'Y' then
    begin
      case ibsqlCommand.Fields[9].AsInteger of
        1: //детско
        begin
          preg.Purpose := pbChildHealthcare;
          preg.ChildHealthcare := TChildHealthcare.Create;
        end;
        2:
        begin
          if ibsqlCommand.Fields[31].AsString = 'Y' then
            preg.Purpose := pbProfRisk
          else
            preg.Purpose := pbProfFrom18;
        end;
        3: // майчино
        begin
          preg.Purpose := pbMotherHealthcare;
          preg.MotherHealthcare := TMotherHealthcare.Create;
          if preg.Diagnosis.Code <> 'Z39.2' then
          begin
            preg.MotherHealthcare.IsPregnant := True;
            preg.MotherHealthcare.GestationalWeek := ibsqlCommand.Fields[21].AsInteger;
            preg.MotherHealthcare.IsBreastFeeding := False;
          end
          else
          begin
            preg.MotherHealthcare.IsPregnant := false;
            preg.MotherHealthcare.GestationalWeek := 0;
            preg.MotherHealthcare.IsBreastFeeding := true;
          end;
        end;
      end;
    end;
    if ibsqlCommand.Fields[10].AsString = 'Y' then
      preg.Purpose := pbDisp;
    if ibsqlCommand.Fields[11].AsString = 'Y' then
      preg.Purpose := pbVSD;
    if ibsqlCommand.Fields[12].AsString = 'Y' then
      preg.Purpose := pbHosp;
    if ibsqlCommand.Fields[13].AsString = 'Y' then
      preg.Purpose := pbExpert;
    if ibsqlCommand.Fields[14].AsString = 'Y' then
      preg.Purpose := pbTelk;

    if not ibsqlCommand.Fields[15].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[15].AsString;
      preg.DiagnosticReport.add(DiagReport)
    end;

    if not ibsqlCommand.Fields[16].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[16].AsString;
      preg.DiagnosticReport.add(DiagReport)
    end;

    if not ibsqlCommand.Fields[17].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[17].AsString;
      preg.DiagnosticReport.add(DiagReport)
    end;

    if not ibsqlCommand.Fields[18].IsNull then
    begin
      DiagReport := TDiagnosticReport.Create;
      DiagReport.Code := ibsqlCommand.Fields[18].AsString;
      preg.DiagnosticReport.add(DiagReport);
    end;

    preg.Diagnosis.Code := ibsqlCommand.Fields[19].AsString;
    preg.Diagnosis.Use := dubChiefComplaint;
    preg.Diagnosis.Rank := 1;
    preg.Diagnosis.AdditionalCode := ibsqlCommand.Fields[20].AsString;

    if not ibsqlCommand.Fields[22].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[22].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[26].AsString;
    end;

    if not ibsqlCommand.Fields[23].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[23].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[27].AsString;
    end;

    if not ibsqlCommand.Fields[24].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[24].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[28].AsString;
    end;

    if not ibsqlCommand.Fields[25].IsNull then
    begin
      Diag := TDiagnosisBasic.Create;
      Diag.Code := ibsqlCommand.Fields[25].AsString;
      Diag.Use := dubComorbidity;
      Diag.Rank := preg.Comorbidity.add(Diag) + 2;
      Diag.AdditionalCode := ibsqlCommand.Fields[29].AsString;
    end;
    if ibsqlCommand.Fields[30].AsString = 'Y' then
      preg.Purpose := pbHosp;

    preg.IsBabyCare := ibsqlCommand.Fields[32].AsString = 'Y';
    preg.MedicalHistory := ibsqlCommand.Fields[33].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.ObjectiveCondition := ibsqlCommand.Fields[34].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.Therapy := ibsqlCommand.Fields[35].AsString.Replace('"', '&quot;', [rfReplaceAll]);
    preg.Assessment := ibsqlCommand.Fields[36].AsString.Replace('"', '&quot;', [rfReplaceAll]);

    preg.PatientSignature := preg.StrOfFieldSign(ibsqlCommand.Fields[37]);
    preg.PatientSignature := 'test';
  end;


  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'doc.rzok,' + #13#10 +
      'doc.rzokR,' + #13#10 +
      'sp.specnziscode,' + #13#10 +
      'sp.code' + #13#10 +

      '' + #13#10 +
      'from doctor doc ' + #13#10 +
      'inner join speciality sp on sp.id = doc.speciality_id ' + #13#10 +
      'where doc.id= :id';
  ibsqlCommand.ParamByName('id').AsInteger := preg.DoctorID;
  ibsqlCommand.ExecQuery;

  preg.Performer.Rzok  := ibsqlCommand.Fields[0].AsString;
  preg.Performer.RzokR  := ibsqlCommand.Fields[1].AsString;


  ibsqlCommand.Close;
  if IsGP then
  begin
    ibsqlCommand.SQL.Text :=
        'select' + #13#10 +
        'rzok,' + #13#10 +
        'rzokr,' + #13#10 +
        'birth_date,' + #13#10 +
        'sex_type,' + #13#10 +
        'nas_mqsto,' + #13#10 +
        'obshtina,' + #13#10 +
        'country,' + #13#10 +
        'doctor_id' + #13#10 +

        'from pacient' + #13#10 +

        'where pacient.id= :id';
    ibsqlCommand.ParamByName('id').AsInteger := preg.PatientID;
  end
  else
  begin
    ibsqlCommand.SQL.Text :=
        'select' + #13#10 +
        'rzok,' + #13#10 +
        'rzokr,' + #13#10 +
        'birth_date,' + #13#10 +
        'sex_type,' + #13#10 +
        'nas_mqsto,' + #13#10 +
        'obshtina,' + #13#10 +
        'country' + #13#10 +
        '' + #13#10 +
        'from pacient where pacient.id= :id';
    ibsqlCommand.ParamByName('id').AsInteger := preg.PatientID;
  end;
  ibsqlCommand.ExecQuery;

  preg.FPatient.Rzok  := ibsqlCommand.Fields[0].AsString;
  preg.FPatient.RzokR  := ibsqlCommand.Fields[1].AsString;
  preg.FPatient.birthDate.Date  := ibsqlCommand.Fields[2].AsDate;
  if preg.Purpose = pbChildHealthcare then
  begin
    preg.ChildHealthcare.Age := CalcAge(preg.StartDate, preg.FPatient.birthDate.Date);
  end;
  preg.FPatient.gender.GenderDB  := ibsqlCommand.Fields[3].AsInteger;
  preg.FPatient.Address.City := ibsqlCommand.Fields[4].AsString;
  preg.FPatient.Address.Obshtina := ibsqlCommand.Fields[5].AsString;
  preg.FPatient.Address.Country := ibsqlCommand.Fields[6].AsString;
  if IsGP then
  begin
    preg.FPatient.DoctorID := ibsqlCommand.Fields[7].AsInteger;
    if preg.IS_ZAMESTVASHT or preg.IS_NAET then
    begin
      preg.DeputDoctorID := preg.DoctorID;
      preg.DoctorID := preg.FPatient.DoctorID;
      for i := 0 to DoctorColl.Count - 1 do
      begin
        if DoctorColl.Items[i].DoctorId = preg.DeputDoctorID then
          preg.Fdeput := DoctorColl.Items[i];
        if DoctorColl.Items[i].DoctorId = preg.DoctorID then
          preg.Performer := DoctorColl.Items[i];
      end;
    end;

  end;

  for i := 0 to oblastColl.Count - 1 do
  begin
    if StrToInt(preg.FPatient.RZOK) = oblastColl.Items[i].OblID then
    begin
      obl := oblastColl.Items[i];
      preg.FPatient.Address.County := obl.OblNzis;
      for j := 0 to obl.Obshtini.Count - 1 do
      begin
        obsht := TObshtinaItem(obl.Obshtini[j]);
        if AnsiUpperCase(preg.FPatient.Address.Obshtina) = AnsiUpperCase(obsht.ObshName) then
        begin
          //pat.Obshtina := obsht.ObshName;
          for k := 0 to obsht.NasMesta.Count - 1 do
          begin
            nasMesto := TNasMestoItem(obsht.NasMesta[k]);
            if AnsiUpperCase(preg.FPatient.Address.City) = AnsiUpperCase(nasMesto.NasMestoName) then
            begin
              preg.FPatient.Address.City := nasMesto.NasMestoName;
              preg.FPatient.Address.PostalCode := nasMesto.ZIP;
              preg.FPatient.Address.Ekatte := nasMesto.EKATTE;
              Break;
            end;
          end;
          Break;
        end;
      end;
      Break
    end;
  end;

  ibsqlCommand.Close;

  if preg.IsSecondary  and (preg.Performer.Qualification.Value.Value = '1043') then
  begin
    ibsqlCommand.SQL.Text :=
        'select first 1 pr.nrn,  pr.amb_listn from pregled pr' + #13#10 +
        'where' + #13#10 +
            'pr.main_diag_mkb = :mkb' + #13#10 +
            'and pr.doctor_id = :doctorID' + #13#10 +
            'and pr.pacient_id = :pacID' + #13#10 +
            'and pr.id <> :pr_ID' + #13#10 +
            'and (pr.NZIS_status in (0, 1, 3, 5, 6) or (pr.NZIS_status is null))' + #13#10 +
            'order by pr.start_date desc';
    ibsqlCommand.ParamByName('mkb').AsString := preg.Diagnosis.Code;
    ibsqlCommand.ParamByName('doctorID').AsInteger := preg.DoctorID;
    ibsqlCommand.ParamByName('pacID').AsInteger := preg.PatientID;
    ibsqlCommand.ParamByName('pr_ID').AsInteger := preg.PregledId;

    ibsqlCommand.ExecQuery;

    preg.BasedOn := TAlphanumericString.Create;
    if ibsqlCommand.RecordCount > 0 then
    begin
      if ibsqlCommand.Fields[0].AsString <> '' then
      begin
        preg.BasedOn.Value := ibsqlCommand.Fields[0].AsString;
      end
      else
      begin
        preg.BasedOn.Value := ibsqlCommand.Fields[1].AsString;
      end;
    end
    else
    begin
      preg.BasedOn.Value := '1234567890';
    end;
    ibsqlCommand.Close;
  end
  else
  if preg.IsSecondary and (not IsGP) and (preg.FinancingSource = fsNHIF) then  // вторичен на специалист
  begin
    ibsqlCommand.SQL.Text :=
        'select first 1 pr.nrn,  pr.amb_listn from pregled pr' + #13#10 +
        'where' + #13#10 +
            ' pr.doctor_id = :doctorID' + #13#10 +
            'and pr.pacient_id = :pacID' + #13#10 +
            'and pr.id <> :pr_ID' + #13#10 +
            'and pr.AMB_LISTN = :AMB_LISTN' + #13#10 +
            'and pr.START_DATE = :START_DATE' + #13#10 +
            'order by pr.start_date desc';
    ibsqlCommand.ParamByName('doctorID').AsInteger := preg.DoctorID;
    ibsqlCommand.ParamByName('pacID').AsInteger := preg.PatientID;
    ibsqlCommand.ParamByName('pr_ID').AsInteger := preg.PregledId;
    ibsqlCommand.ParamByName('AMB_LISTN').AsInteger := StrToInt(preg.BasedOn.Value);
    ibsqlCommand.ParamByName('START_DATE').AsDate := preg.PrevAmbDate;
    ibsqlCommand.ExecQuery;

    if ibsqlCommand.RecordCount > 0 then
    begin
      if ibsqlCommand.Fields[0].AsString <> '' then
      begin
        preg.BasedOn.Value := ibsqlCommand.Fields[0].AsString;
      end
      else
      begin
        preg.BasedOn.Value := ibsqlCommand.Fields[1].AsString;
      end;
    end
    else
    begin
      preg.BasedOn.Value := '1234567890';
    end;
    ibsqlCommand.Close;
    ibsqlCommand.ExecQuery;

  end;

  ibsqlCommand.Close;
  if preg.FEbls.Count > 0 then
  begin
    for i := 0 to preg.FEbls.Count - 1 do
    begin
      ibsqlCommand.SQL.Text :=
          'select' + #13#10 +
          'ebl.data,' + #13#10 +
          'ebl.is_primary,' + #13#10 +
          'ebl.sick_leave_start,' + #13#10 +
          'ebl.sick_leave_end,' + #13#10 +
          'ebl.days_hospital + ebl.days_home + ebl.days_sanatorium + ebl.days_free,' + #13#10 +
          'ebl.icd_code' + #13#10 +
          'from exam_boln_list ebl' + #13#10 +
          'where ebl.id = :Ebl_ID';
      ibsqlCommand.ParamByName('Ebl_ID').AsInteger := preg.FEbls[i].EblId;
      ibsqlCommand.ExecQuery;
      preg.FEbls[i].FromDate := ibsqlCommand.Fields[2].AsDate;
      preg.FEbls[i].ToDate := ibsqlCommand.Fields[3].AsDate;
      preg.FEbls[i].Status := true; // zzzzzzzzzzzzzzzzzzzzzz  за сега са само такива
      preg.FEbls[i].Days := ibsqlCommand.Fields[4].AsInteger;
      preg.FEbls[i].IsInitial := ibsqlCommand.Fields[1].AsString = 'Y';
      preg.FEbls[i].ReasonCode := ibsqlCommand.Fields[5].AsString;

      ibsqlCommand.Close;
    end;
  end;
  preg.IsAddedFull := True;
  Self.FPerformer.DeputDoctorID := preg.DeputDoctorID;
end;



constructor TPregledMessages.create;
begin
  inherited create;

end;

destructor TPregledMessages.destroy;
begin

  inherited;
end;

procedure TPregledMessages.FindSender(senderId: integer);
var
  i: integer;
begin
  if senderId = 0 then exit;

  for i := 0 to DoctorColl.Count - 1 do
  begin
    if DoctorColl.Items[i].DoctorId = senderId then
    begin
      self.Sender  := DoctorColl.Items[i];
    end;
  end;
end;

procedure TPregledMessages.GenerateX001(preg: TPregledNzisItem);
var
  mess: TMessageX001;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  //if not preg.IsAddedFull then
//  begin
//    AddFullPregled(preg);
//    preg.Fdeput := ADeput;
//  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX001.Create;
  preg.FMessage := mess;
  if sender = nil then
  begin
    if preg.IS_ZAMESTVASHT or preg.IS_NAET then
      mess.Sender := preg.Fdeput
    else
      mess.Sender := preg.Performer;
  end
  else
  begin
    mess.Sender := sender;
  end;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;
  mess.Exam.Sender := mess.Sender;
  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  try
    Self.Ferr := nil;
    //ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX001,'https://www.his.bg', Ferr);
  finally
    if err <> nil then
    begin
      preg.HipStatus := hpsNoValid;
    end
    else
    begin
      preg.HipStatus := hpsValid;
    end;
  end;
end;

procedure TPregledMessages.GenerateX003(preg: TPregledNzisItem);
var
  mess: TMessageX003;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  if not preg.IsAddedFull then
  begin
    AddFullPregled(preg);
    preg.Fdeput := ADeput;
  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX003.Create;
  mess.hndSenderWindow := Self.HandleHip;
  preg.FMessage := mess;
  if self.Sender = nil then
  begin
    if preg.IS_ZAMESTVASHT or preg.IS_NAET then
      mess.Sender := preg.Fdeput
    else
      mess.Sender := preg.Performer;
  end
  else
  begin
    mess.Sender :=  self.Sender;
  end;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;

  if not mess.FillXmlSream then
    //preg.ReasonGenX00All := 1;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  preg.HipStatus := hpsValid;
  //try
//    Self.Ferr := nil;
//    ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX003,'https://www.his.bg', Ferr);
//  finally
//    if err <> nil then
//    begin
//      preg.HipStatus := hsNoValid;
//    end
//    else
//    begin
//      preg.HipStatus := hsValid;
//    end;
//  end;
end;

procedure TPregledMessages.GenerateX005(preg: TPregledNzisItem);
var
  mess: TMessageX005;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  if not preg.IsAddedFull then
  begin
    AddFullPregled(preg);
    preg.Fdeput := ADeput;
  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX005.Create;
  preg.FMessage := mess;
  if preg.IS_ZAMESTVASHT or preg.IS_NAET then
    mess.Sender := preg.Fdeput
  else
    mess.Sender := preg.Performer;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  try
    Self.Ferr := nil;
    ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX005,'https://www.his.bg', Ferr);
  finally
    if err <> nil then
    begin
      preg.HipStatus := hpsNoValid;
    end
    else
    begin
      preg.HipStatus := hpsValid;
    end;
  end;
end;

procedure TPregledMessages.GenerateX005EGN(dateExam: TDate; egn: string; PidType:integer);
var
  mess: TMessageX005;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  GenXML.Clear;
  mess := TMessageX005.Create;
  mess.Header.SenderID := FPerformer.Pmi;

  mess.FillXmlStreamEGN(dateExam, egn, PidType);
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);

end;

procedure TPregledMessages.GenerateX005LRN(LRN: string; fromDate: TDate);
var
  mess: TMessageX005;
  oXml: IXMLDocument;
begin
  GenXML.Clear;
  mess := TMessageX005.Create;
  mess.Header.SenderID := FPerformer.Pmi;

  mess.FillXmlStreamLRN(lrn, fromdate);
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);

end;

procedure TPregledMessages.GenerateX005NRN(NRN: string);
var
  mess: TMessageX005;
  oXml: IXMLDocument;
begin
  GenXML.Clear;
  mess := TMessageX005.Create;
  mess.Header.SenderID := FPerformer.Pmi;

  mess.FillXmlStreamNRN(nrn);
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);

end;

procedure TPregledMessages.GenerateX007(preg: TPregledNzisItem);
var
  mess: TMessageX007;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  if not preg.IsAddedFull then
  begin
    AddFullPregled(preg);
    preg.Fdeput := ADeput;
  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX007.Create;
  preg.FMessage := mess;
  if sender = nil then
  begin
    if preg.IS_ZAMESTVASHT or preg.IS_NAET then
      mess.Sender := preg.Fdeput
    else
      mess.Sender := preg.Performer;
  end
  else
  begin
    mess.Sender := sender;
  end;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  Self.Ferr := nil;
  preg.HipStatus := hpsValid;
  //try
//    Self.Ferr := nil;
//    ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX005,'https://www.his.bg', Ferr);
//  finally
//    if err <> nil then
//    begin
//      preg.HipStatus := hsNoValid;
//    end
//    else
//    begin
//      preg.HipStatus := hsValid;
//    end;
//  end;
end;

procedure TPregledMessages.GenerateX009(preg: TPregledNzisItem);
var
  mess: TMessageX009;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  if not preg.IsAddedFull then
  begin
    AddFullPregled(preg);
    preg.Fdeput := ADeput;
  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX009.Create;
  mess.hndSenderWindow := Self.HandleHip;
  mess.CorrectReason := 'ѕричина: ';
  preg.FMessage := mess;
  if self.Sender = nil then
  begin
    if preg.IS_ZAMESTVASHT or preg.IS_NAET then
      mess.Sender := preg.Fdeput
    else
      mess.Sender := preg.Performer;
  end
  else
  begin
    mess.Sender := self.Sender;
  end;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  try
    Self.Ferr := nil;
    ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX009,'https://www.his.bg', Ferr);
  finally
    if err <> nil then
    begin
      preg.HipStatus := hpsNoValid;
    end
    else
    begin
      preg.HipStatus := hpsValid;
    end;
  end;
end;

procedure TPregledMessages.GenerateX011(preg: TPregledNzisItem);
var
  mess: TMessageX011;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  if not preg.IsAddedFull then
  begin
    AddFullPregled(preg);
    preg.Fdeput := ADeput;
  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX011.Create;
  preg.FMessage := mess;
  if self.Sender = nil then
  begin
    if preg.IS_ZAMESTVASHT or preg.IS_NAET then
      mess.Sender := preg.Fdeput
    else
      mess.Sender := preg.Performer;
  end
  else
  begin
    mess.Sender := self.Sender;
  end;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  try
    Self.Ferr := nil;
    ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX011,'https://www.his.bg', Ferr);
  finally
    if err <> nil then
    begin
      preg.HipStatus := hpsNoValid;
    end
    else
    begin
      preg.HipStatus := hpsValid;
    end;
  end;
end;

procedure TPregledMessages.GenerateX013(preg: TPregledNzisItem);
var
  mess: TMessageX013;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  ADeput := preg.Fdeput;
  if not preg.IsAddedFull then
  begin
    AddFullPregled(preg);
    preg.Fdeput := ADeput;
  end;

  GenXML.Clear;
  //preg.FPatient.Name.Given := '......';
  mess := TMessageX013.Create;
  mess.hndSenderWindow := Self.HandleHip;
  preg.FMessage := mess;
  if preg.IS_ZAMESTVASHT or preg.IS_NAET then
    mess.Sender := preg.Fdeput
  else
    mess.Sender := preg.Performer;
  mess.Exam := preg;
  mess.Header.SenderID := mess.Sender.SenderID;

  mess.FillXmlSream;

  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  try
    Self.Ferr := nil;
    ValidateXMLText(GenXML.Text, NzisSchem.vSchemaX013,'https://www.his.bg', Ferr);
  finally
    if err <> nil then
    begin
      preg.HipStatus := hpsNoValid;
    end
    else
    begin
      preg.HipStatus := hpsValid;
    end;
  end;
end;

end.
