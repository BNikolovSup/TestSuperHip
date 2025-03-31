unit NZIS.MDN.SuperMessages;
             //d:\
interface
uses
  System.SysUtils, system.Classes,Winapi.Windows, System.Generics.Collections,system.StrUtils,
  NzisSuperCollection, NZISSuperAddress, Nzis.Types, NZIS.nomenklatura, NZIS.Functions,
  NZIS.XMLschems, NZIS.SuperMessages,
  Xml.XMLIntf, Xml.XMLDoc,
  IBX.IBSQL, Vcl.Dialogs;

type
  TMDNMessages = class(TNZISMessages)
  private
    FIsR001: Boolean;
  public
    CL024: TStringList;
    AnalIDs: TStringList;
    constructor create;override;
    destructor destroy;override;
    procedure FindSender(senderId: integer);

    procedure AddFullMDN(mdn: TMdnItem);
    procedure AddFullMN(mn: TMnItem);
    procedure AddFullMN3A(mn: TMn3AItem);
    procedure AddFullMN6(mn: TMn6Item);
    procedure AddFullHosp(mn: TMnHospItem);
    function GetDevice1064: integer;
    function GetDevice0512: Integer;
    procedure SaveExamAnal;
    procedure GenerateR001(mdn: TMdnItem);
    procedure GenerateR003(mdn: TMdnItem);
    procedure GenerateR005(mdn: TMdnItem);
    procedure GenerateR007(mdn: TMdnItem);

    procedure GenerateR009(mdns: TList<TMdnItem>);
    procedure GenerateR009MN(mn: TMnItem);
    procedure GenerateR011(mdn: TMdnItem);


    procedure GenerateR001MN(mn: TMnItem);
    procedure GenerateR003MN(mn: TMnItem);
    procedure GenerateR007MN(mn: TMnItem);

    procedure GenerateR001MN3A(mn: TMn3AItem);
    procedure GenerateR003MN3A(mn: TMn3AItem);
    procedure GenerateR007MN3A(mn: TMn3AItem);

    procedure GenerateR001MN6(mn: TMn6Item);
    procedure GenerateR003MN6(mn: TMn6Item);
    procedure GenerateR007MN6(mn: TMn6Item);


    procedure GenerateR001Hosp(mn: TMnHospItem);
    procedure GenerateR003Hosp(mn: TMnHospItem);
    procedure GenerateR007Hosp(mn: TMnHospItem);

    procedure GenerateR015MN(mn: TMnItem);
    procedure GenerateR015MN_EGN(mn: TMnItem);
    procedure GenerateR015MDN_EGN(mdn: TMdnItem);

    procedure GenerateR017MDN(mdn: TMdnItem);

    procedure GenerateC009(mdn: TMdnItem);
    procedure GenerateC007(mdn: TMdnItem);

    property IsR001: Boolean read  FIsR001 write FIsR001;

  end;

implementation

{ TMDNMessages }

function TMDNMessages.GetDevice0512: Integer;
begin
  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
    'select cl56.id from nzis_cl056 cl56' + #13#10 +
    'where cl56.is_perform = ''Y'' and cl56."Type_Test" = ''Antigen''';
  ibsqlCommand.ExecQuery;
  Result := ibsqlCommand.Fields[0].AsInteger;
  ibsqlCommand.Close;
end;

function TMDNMessages.GetDevice1064: integer;
begin
  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
    'select cl56.id from nzis_cl056 cl56' + #13#10 +
    'where cl56.is_perform = ''Y'' and cl56."Type_Test" = ''PCR''';
  ibsqlCommand.ExecQuery;
  Result := ibsqlCommand.Fields[0].AsInteger;
  ibsqlCommand.Close;
end;

procedure TMDNMessages.AddFullHosp(mn: TMnHospItem);
var

  i, j, k: Integer;
  obl: TOblastItem;
  obsht: TObshtinaItem;
  nasMesto: TNasMestoItem;

  DiagReport: TDiagnosticReport;
  Diag: TDiagnosisBasic;
  anal: TAnalItem;
begin
  ibsqlCommand.Close;
  if PregledColl.FNzisNomen = nil then
    PregledColl.FNzisNomen := TNzisNomen.create;
  ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'PREGLED_ID,' + #13#10 +  //0
      'DIRECTED_BY,' + #13#10 +
      'HAS_NHIF_CONTRACT,' + #13#10 +
      'IS_URGENT,' + #13#10 +
      'IS_PLANNED,' + #13#10 +
      'CLINICAL_PATH,' + #13#10 +  //5
      'DIRECT_DIAGNOSIS_1,' + #13#10 +
      'DIRECT_MKB_1,' + #13#10 +
      'DIRECT_DIAGNOSIS_2,' + #13#10 +
      'DIRECT_MKB_2,' + #13#10 +
      'DIRECT_DATE,' + #13#10 + //10
      'NOTES,' + #13#10 +
      'DIRECT_MKB_1_ADD,' + #13#10 +
      'DIRECT_MKB_2_ADD,' + #13#10 +
      'ICD_AREA,' + #13#10 +
      'IS_REJECTED,' + #13#10 + //15
      'IS_PRINTED,' + #13#10 +
      'AMB_PROCEDURE,' + #13#10 +
      'IS_MZ,' + #13#10 +
      'NUMBER,' + #13#10 +
      'NRN,' + #13#10 + //20
      'NZIS_STATUS,' + #13#10 +
      'ID' + #13#10 + //22
      '' + #13#10 +
      '' + #13#10 +
      '' + #13#10 +
      'from hospitalization emn' + #13#10 +
      'where emn.id = :emn_id';

  ibsqlCommand.ParamByName('emn_id').AsInteger := mn.MnID;
  ibsqlCommand.ExecQuery;

  mn.Nomer := ibsqlCommand.Fields[19].AsInteger;
  mn.DateMn := ibsqlCommand.Fields[10].AsDate;
  mn.ICD_CODE := ibsqlCommand.Fields[7].AsString;
  mn.MED_DIAG_NAPR_TYPE_ID := -1;
  mn.ICD_CODE_ADD := ibsqlCommand.Fields[12].AsString;
  mn.ICD_CODE2 := ibsqlCommand.Fields[9].AsString;
  mn.ICD_CODE2_ADD := ibsqlCommand.Fields[13].AsString;
  mn.IsPlanned := ibsqlCommand.Fields[4].AsString = 'Y';
  mn.CLINICAL_PATH  := ibsqlCommand.Fields[5].AsString;
  mn.AMB_PROCEDURE  := ibsqlCommand.Fields[17].AsString;


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
  ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.DoctorID;
  ibsqlCommand.ExecQuery;

  mn.FPregled.Performer.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.Performer.RzokR  := ibsqlCommand.Fields[1].AsString;

  if  mn.FPregled.Fdeput <> nil then
  begin
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.Fdeput.DoctorID;
    ibsqlCommand.ExecQuery;

    mn.FPregled.Fdeput.Rzok  := ibsqlCommand.Fields[0].AsString;
    mn.FPregled.Fdeput.RzokR  := ibsqlCommand.Fields[1].AsString;
  end
  else
  begin

  end;


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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
  end;
  ibsqlCommand.ExecQuery;

  mn.FPregled.FPatient.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.FPatient.RzokR  := ibsqlCommand.Fields[1].AsString;
  mn.FPregled.FPatient.birthDate.Date  := ibsqlCommand.Fields[2].AsDate;
  if mn.FPregled.Purpose = pbChildHealthcare then
  begin
    mn.FPregled.ChildHealthcare.Age := CalcAge(mn.FPregled.StartDate, mn.FPregled.FPatient.birthDate.Date);
  end;
  mn.FPregled.FPatient.gender.GenderDB  := ibsqlCommand.Fields[3].AsInteger;
  mn.FPregled.FPatient.Address.City := ibsqlCommand.Fields[4].AsString;
  mn.FPregled.FPatient.Address.Obshtina := ibsqlCommand.Fields[5].AsString;
  mn.FPregled.FPatient.Address.Country := ibsqlCommand.Fields[6].AsString;
  if IsGP then
  begin
    mn.FPregled.FPatient.DoctorID := ibsqlCommand.Fields[7].AsInteger;
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    begin
      mn.FPregled.DeputDoctorID := mn.FPregled.DoctorID;
      mn.FPregled.DoctorID := mn.FPregled.FPatient.DoctorID;
      for i := 0 to DoctorColl.Count - 1 do
      begin
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DeputDoctorID then
        begin
          mn.FPregled.Fdeput := DoctorColl.Items[i];
          if mn.FPregled.IS_ZAMESTVASHT then
            mn.FPregled.Fdeput.Role := drDeputizing
          else
            mn.FPregled.Fdeput.Role := drHired;
        end;

        if DoctorColl.Items[i].DoctorId = mn.FPregled.DoctorID then
          mn.FPregled.Performer := DoctorColl.Items[i];
      end;
    end;

  end;

  for i := 0 to oblastColl.Count - 1 do
  begin
    if StrToInt(mn.FPregled.FPatient.RZOK) = oblastColl.Items[i].OblID then
    begin
      obl := oblastColl.Items[i];
      mn.FPregled.FPatient.Address.County := obl.OblNzis;
      for j := 0 to obl.Obshtini.Count - 1 do
      begin
        obsht := TObshtinaItem(obl.Obshtini[j]);
        if AnsiUpperCase(mn.FPregled.FPatient.Address.Obshtina) = AnsiUpperCase(obsht.ObshName) then
        begin
          //pat.Obshtina := obsht.ObshName;
          for k := 0 to obsht.NasMesta.Count - 1 do
          begin
            nasMesto := TNasMestoItem(obsht.NasMesta[k]);
            if AnsiUpperCase(mn.FPregled.FPatient.Address.City) = AnsiUpperCase(nasMesto.NasMestoName) then
            begin
              mn.FPregled.FPatient.Address.City := nasMesto.NasMestoName;
              mn.FPregled.FPatient.Address.PostalCode := nasMesto.ZIP;
              mn.FPregled.FPatient.Address.Ekatte := nasMesto.EKATTE;
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
  mn.IsAddedFull := True;
end;

procedure TMDNMessages.AddFullMDN(mdn: TMdnItem);
var

  i, j, k: Integer;
  obl: TOblastItem;
  obsht: TObshtinaItem;
  nasMesto: TNasMestoItem;

  DiagReport: TDiagnosticReport;
  Diag: TDiagnosisBasic;
  anal: TAnalItem;
  ArrAnals: TArray<TList<TAnalItem>>;
  //CountUniqAnal: Integer;
  ExAnalCode: string;
  NzisInfo: TNzisAnalInfo;
  indexAnal: Integer;
begin
  ibsqlCommand.Close;
  if PregledColl.FNzisNomen = nil then
    PregledColl.FNzisNomen := TNzisNomen.create;
  ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'mdn.ID,' + #13#10 +
      'mdn.PREGLED_ID,' + #13#10 +
      'mdn.NUMBER,' + #13#10 +
      'mdn.DATA,' + #13#10 +
      'mdn.ICD_CODE,' + #13#10 +
      'mdn.IS_LKK,' + #13#10 +
      'mdn.MED_DIAG_NAPR_TYPE_ID,' + #13#10 +
      'mdn.ICD_CODE_ADD,' + #13#10 +
      'mdn.IS_PRINTED,' + #13#10 +
      'mdn.OTHER_DOCTOR_ID,' + #13#10 +
      'mdn.TAKENFROMARENAL' + #13#10 +

      'from blanka_mdn mdn' + #13#10 +
      'where mdn.id = :mdn_id';

  ibsqlCommand.ParamByName('mdn_id').AsInteger := mdn.MdnID;
  ibsqlCommand.ExecQuery;

  mdn.Nomer := ibsqlCommand.Fields[2].AsInteger;
  mdn.DateMdn := ibsqlCommand.Fields[3].AsDate;
  mdn.ICD_CODE := ibsqlCommand.Fields[4].AsString;
  mdn.MED_DIAG_NAPR_TYPE_ID := ibsqlCommand.Fields[6].AsInteger;
  mdn.ICD_CODE_ADD := ibsqlCommand.Fields[7].AsString;


  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
      'select a.package, a.code, cl22.key_022 as cl22, cl22.description, a.id from exam_analysis ea' + #13#10 +
      'inner join analysis a on a.id = ea.analysis_id' + #13#10 +
      'left join nzis_cl022 cl22 on cl22.nhif_code = lpad (a.package,2,  ''0'') || ''.'' || lpad (a.code,2,  ''0'')' + #13#10 +
      'where ea.blanka_mdn_id = :mdn_id and cl22.key_022 not in (''0C-111'', ''0C-110'', ''0C-103'', ''0C-102'', ''0C-101'', ''0C-100'',' + #13#10 +
                                                                '''0F-112'', ''0F-113'', ''0F-114'', ''0F-115'', ''0F-116'', ''0F-117'', ''0F-118'', ''0F-119'', ''0F-11A'', ''0F-11B'', ''0F-11C'',' + #13#10 +
                                                                '''0F-130'', ''0F-131'', ''0F-132'', ''0F-133'', ''0F-134'', ''0F-135'', ''0F-136'', ''0F-137'', ''0F-138'', ''0F-139'', ''0F-13A'')';

  ibsqlCommand.ParamByName('mdn_id').AsInteger := mdn.MdnID;
  ibsqlCommand.ExecQuery;

  //CountUniqAnal := -1;
  ExAnalCode := '';

  while not ibsqlCommand.Eof do
  begin


    anal := TAnalItem.Create(nil);
    anal.Code := Format('%.*d.%.*d',
       [2, ibsqlCommand.Fields[0].AsInteger, 2, ibsqlCommand.Fields[1].AsInteger]);
    anal.NzisCode := ibsqlCommand.Fields[2].AsString;
    anal.AnalID := ibsqlCommand.Fields[4].AsInteger;

    //if (ExAnalCode <> anal.Code) and ((anal.Code = '06.29') or (anal.Code = '10.02')or (anal.Code = '10.92')) then
    begin
      //inc(CountUniqAnal);
      SetLength(ArrAnals, length(ArrAnals) + 1);
      ArrAnals[length(ArrAnals) - 1] := TList<TAnalItem>.Create;
      ExAnalCode := anal.Code;
    end;
    ArrAnals[length(ArrAnals) - 1].Add(anal);

    ibsqlCommand.Next;
  end;
  for i := 0 to Length(ArrAnals) - 1 do
  begin
    if (ArrAnals[i].Count > 1) and (Self.IsR001) then
    begin

      if ArrAnals[i][0].Code = '06.29' then
      begin
        //if ArrAnals[i][0].NzisCode = '0C-112' then

          ArrAnals[i][0].NzisCode := '0C-112';
          mdn.Anals.Add(ArrAnals[i][0]);
      end
      else if ArrAnals[i][0].Code = '10.02' then
      begin
        ArrAnals[i][0].NzisCode := '0F-11D';
        mdn.Anals.Add(ArrAnals[i][0]);
      end
      else if ArrAnals[i][0].Code = '10.92' then
      begin
        ArrAnals[i][0].NzisCode := '0F-11E';
        mdn.Anals.Add(ArrAnals[i][0]);
      end
      else
        mdn.Anals.Add(ArrAnals[i][0]);


      //06.29         58108-00    0C-112       Рентгенография на гръбначния стълб, 4 отдела (НЗИС)/ Рентгенография на гръбначни прешлени (по НЗОК - ПРИЛОЖЕНИЕ № 10а)
//
//10.02         90901-08    0F-11D       Магнитно резонансна томография на друго място (НЗИС)/ Ядрено-магнитен резонанс (НЗОК)
//
//10.92         90901-11     0F-11E       Магнитно резонансна томография на друго място под обща


      //indexAnal := SendMessage(HandleHip, WM_GET_NZIS_CL22KEY, 0, ArrAnals[i][0].AnalID);
//      if indexAnal > -1 then
//      begin
//        ibsqlCommand.Close;
//        ibsqlCommand.SQL.Text :=
//                'select cl22.key_022, cl22.description from nzis_cl022 cl22' + #13#10 +
//                'inner join analysis a on cl22.nhif_code = lpad (a.package,2,  ''0'') || ''.'' || lpad (a.code,2,  ''0'')' + #13#10 +
//                'where a.id = :id'   + #13#10 +
//                'order by cl22.key_022';
//        ibsqlCommand.ParamByName('ID').AsInteger := ArrAnals[i][0].AnalID;
//        ibsqlCommand.ExecQuery;
//
//        while not ibsqlCommand.Eof do
//        begin
//          if (ibsqlCommand.RecordCount - 1) = indexAnal then
//          begin
//            ArrAnals[i][0].NzisCode := ibsqlCommand.Fields[0].AsString;
//            mdn.Anals.Add(ArrAnals[i][0]);
//            Break;
//          end;
//          ibsqlCommand.Next;
//        end;
//
//      end;

    end
    else
    begin
      mdn.Anals.Add(ArrAnals[i][0]);
    end;

  end;

  //

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
  ibsqlCommand.ParamByName('id').AsInteger := mdn.FPregled.DoctorID;
  ibsqlCommand.ExecQuery;

  mdn.FPregled.Performer.Rzok  := ibsqlCommand.Fields[0].AsString;
  mdn.FPregled.Performer.RzokR  := ibsqlCommand.Fields[1].AsString;

  if mdn.FPregled.Fdeput <> nil then
  begin
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
    ibsqlCommand.ParamByName('id').AsInteger := mdn.FPregled.Fdeput.DoctorID;
    ibsqlCommand.ExecQuery;

    mdn.FPregled.Fdeput.Rzok  := ibsqlCommand.Fields[0].AsString;
    mdn.FPregled.Fdeput.RzokR  := ibsqlCommand.Fields[1].AsString;
  end;


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
    ibsqlCommand.ParamByName('id').AsInteger := mdn.FPregled.PatientID;
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
    ibsqlCommand.ParamByName('id').AsInteger := mdn.FPregled.PatientID;
  end;
  ibsqlCommand.ExecQuery;

  mdn.FPregled.FPatient.Rzok  := ibsqlCommand.Fields[0].AsString;
  mdn.FPregled.FPatient.RzokR  := ibsqlCommand.Fields[1].AsString;
  mdn.FPregled.FPatient.birthDate.Date  := ibsqlCommand.Fields[2].AsDate;
  if mdn.FPregled.Purpose = pbChildHealthcare then
  begin
    mdn.FPregled.ChildHealthcare.Age := CalcAge(mdn.FPregled.StartDate, mdn.FPregled.FPatient.birthDate.Date);
  end;
  mdn.FPregled.FPatient.gender.GenderDB  := ibsqlCommand.Fields[3].AsInteger;
  mdn.FPregled.FPatient.Address.City := ibsqlCommand.Fields[4].AsString;
  mdn.FPregled.FPatient.Address.Obshtina := ibsqlCommand.Fields[5].AsString;
  mdn.FPregled.FPatient.Address.Country := ibsqlCommand.Fields[6].AsString;
  if IsGP then
  begin
    mdn.FPregled.FPatient.DoctorID := ibsqlCommand.Fields[7].AsInteger;
    if mdn.FPregled.IS_ZAMESTVASHT or mdn.FPregled.IS_NAET then
    begin
      mdn.FPregled.DeputDoctorID := mdn.FPregled.DoctorID;
      mdn.FPregled.DoctorID := mdn.FPregled.FPatient.DoctorID;
      for i := 0 to DoctorColl.Count - 1 do
      begin
        if DoctorColl.Items[i].DoctorId = mdn.FPregled.DeputDoctorID then
        begin
          mdn.FPregled.Fdeput := DoctorColl.Items[i];
          if mdn.FPregled.IS_ZAMESTVASHT then
            mdn.FPregled.Fdeput.Role := drDeputizing
          else
            mdn.FPregled.Fdeput.Role := drHired;
        end;
        if DoctorColl.Items[i].DoctorId = mdn.FPregled.DoctorID then
          mdn.FPregled.Performer := DoctorColl.Items[i];
      end;
    end;

  end;

  for i := 0 to oblastColl.Count - 1 do
  begin
    if StrToInt(mdn.FPregled.FPatient.RZOK) = oblastColl.Items[i].OblID then
    begin
      obl := oblastColl.Items[i];
      mdn.FPregled.FPatient.Address.County := obl.OblNzis;
      for j := 0 to obl.Obshtini.Count - 1 do
      begin
        obsht := TObshtinaItem(obl.Obshtini[j]);
        if AnsiUpperCase(mdn.FPregled.FPatient.Address.Obshtina) = AnsiUpperCase(obsht.ObshName) then
        begin
          //pat.Obshtina := obsht.ObshName;
          for k := 0 to obsht.NasMesta.Count - 1 do
          begin
            nasMesto := TNasMestoItem(obsht.NasMesta[k]);
            if AnsiUpperCase(mdn.FPregled.FPatient.Address.City) = AnsiUpperCase(nasMesto.NasMestoName) then
            begin
              mdn.FPregled.FPatient.Address.City := nasMesto.NasMestoName;
              mdn.FPregled.FPatient.Address.PostalCode := nasMesto.ZIP;
              mdn.FPregled.FPatient.Address.Ekatte := nasMesto.EKATTE;
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
  mdn.IsAddedFull := True;
end;

procedure TMDNMessages.AddFullMN(mn: TMnItem);
var

  i, j, k: Integer;
  obl: TOblastItem;
  obsht: TObshtinaItem;
  nasMesto: TNasMestoItem;

  DiagReport: TDiagnosticReport;
  Diag: TDiagnosisBasic;
  anal: TAnalItem;
begin
  ibsqlCommand.Close;
  if PregledColl.FNzisNomen = nil then
    PregledColl.FNzisNomen := TNzisNomen.create;
  ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'emn.id,' + #13#10 +
      'emn.pregled_id,' + #13#10 +
      'emn.number,' + #13#10 +
      'emn.issue_date,' + #13#10 +
      'emn.icd_code,' + #13#10 +
      'emn.med_napr_type_id,' + #13#10 +
      'emn.icd_code_add,' + #13#10 +
      '(select sp.specnziscode from speciality sp where sp.id = emn.speciality_id),' + #13#10 +
      'emn.icd_code2,' + #13#10 +
      'emn.icd_code2_add,' + #13#10 +
      'emn.icd_code3,' + #13#10 +
      'emn.icd_code3_add' + #13#10 +
      '' + #13#10 +
      'from blanka_med_napr emn' + #13#10 +
      'where emn.id = :emn_id';

  ibsqlCommand.ParamByName('emn_id').AsInteger := mn.MnID;
  ibsqlCommand.ExecQuery;

  mn.Nomer := ibsqlCommand.Fields[2].AsInteger;
  mn.DateMn := ibsqlCommand.Fields[3].AsDate;
  mn.ICD_CODE := ibsqlCommand.Fields[4].AsString;
  mn.MED_DIAG_NAPR_TYPE_ID := ibsqlCommand.Fields[5].AsInteger;
  mn.ICD_CODE_ADD := ibsqlCommand.Fields[6].AsString;
  mn.ForSpec := ibsqlCommand.Fields[7].AsString;
  mn.ICD_CODE2 := ibsqlCommand.Fields[8].AsString;
  mn.ICD_CODE2_ADD := ibsqlCommand.Fields[9].AsString;
  mn.ICD_CODE3 := ibsqlCommand.Fields[10].AsString;
  mn.ICD_CODE3_ADD := ibsqlCommand.Fields[11].AsString;

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
  ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.DoctorID;
  ibsqlCommand.ExecQuery;

  mn.FPregled.Performer.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.Performer.RzokR  := ibsqlCommand.Fields[1].AsString;

  if  mn.FPregled.Fdeput <> nil then
  begin
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.Fdeput.DoctorID;
    ibsqlCommand.ExecQuery;

    mn.FPregled.Fdeput.Rzok  := ibsqlCommand.Fields[0].AsString;
    mn.FPregled.Fdeput.RzokR  := ibsqlCommand.Fields[1].AsString;
  end
  else
  begin

  end;


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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
  end;
  ibsqlCommand.ExecQuery;

  mn.FPregled.FPatient.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.FPatient.RzokR  := ibsqlCommand.Fields[1].AsString;
  mn.FPregled.FPatient.birthDate.Date  := ibsqlCommand.Fields[2].AsDate;
  if mn.FPregled.Purpose = pbChildHealthcare then
  begin
    mn.FPregled.ChildHealthcare.Age := CalcAge(mn.FPregled.StartDate, mn.FPregled.FPatient.birthDate.Date);
  end;
  mn.FPregled.FPatient.gender.GenderDB  := ibsqlCommand.Fields[3].AsInteger;
  mn.FPregled.FPatient.Address.City := ibsqlCommand.Fields[4].AsString;
  mn.FPregled.FPatient.Address.Obshtina := ibsqlCommand.Fields[5].AsString;
  mn.FPregled.FPatient.Address.Country := ibsqlCommand.Fields[6].AsString;
  if IsGP then
  begin
    mn.FPregled.FPatient.DoctorID := ibsqlCommand.Fields[7].AsInteger;
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    begin
      mn.FPregled.DeputDoctorID := mn.FPregled.DoctorID;
      mn.FPregled.DoctorID := mn.FPregled.FPatient.DoctorID;
      for i := 0 to DoctorColl.Count - 1 do
      begin
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DeputDoctorID then
        begin
          mn.FPregled.Fdeput := DoctorColl.Items[i];
          if mn.FPregled.IS_ZAMESTVASHT then
            mn.FPregled.Fdeput.Role := drDeputizing
          else
            mn.FPregled.Fdeput.Role := drHired;
        end;
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DoctorID then
          mn.FPregled.Performer := DoctorColl.Items[i];
      end;
    end;

  end;

  for i := 0 to oblastColl.Count - 1 do
  begin
    if StrToInt(mn.FPregled.FPatient.RZOK) = oblastColl.Items[i].OblID then
    begin
      obl := oblastColl.Items[i];
      mn.FPregled.FPatient.Address.County := obl.OblNzis;
      for j := 0 to obl.Obshtini.Count - 1 do
      begin
        obsht := TObshtinaItem(obl.Obshtini[j]);
        if AnsiUpperCase(mn.FPregled.FPatient.Address.Obshtina) = AnsiUpperCase(obsht.ObshName) then
        begin
          //pat.Obshtina := obsht.ObshName;
          for k := 0 to obsht.NasMesta.Count - 1 do
          begin
            nasMesto := TNasMestoItem(obsht.NasMesta[k]);
            if AnsiUpperCase(mn.FPregled.FPatient.Address.City) = AnsiUpperCase(nasMesto.NasMestoName) then
            begin
              mn.FPregled.FPatient.Address.City := nasMesto.NasMestoName;
              mn.FPregled.FPatient.Address.PostalCode := nasMesto.ZIP;
              mn.FPregled.FPatient.Address.Ekatte := nasMesto.EKATTE;
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
  mn.IsAddedFull := True;
end;

procedure TMDNMessages.AddFullMN3A(mn: TMn3AItem);
var
  i, j, k: Integer;
  obl: TOblastItem;
  obsht: TObshtinaItem;
  nasMesto: TNasMestoItem;

  DiagReport: TDiagnosticReport;
  Diag: TDiagnosisBasic;
  anal: TAnalItem;
begin
  ibsqlCommand.Close;
  if PregledColl.FNzisNomen = nil then
    PregledColl.FNzisNomen := TNzisNomen.create;
  ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'emn.id,' + #13#10 +
      'emn.pregled_id,' + #13#10 +
      'emn.number,' + #13#10 +
      'emn.issue_date,' + #13#10 +
      'emn.icd_code,' + #13#10 +
      'emn.med_napr_type_id,' + #13#10 +
      'emn.icd_code_add,' + #13#10 +
      '(select sp.specnziscode from speciality sp where sp.id = emn.speciality_id),'  + #13#10 +
      'emn.VSD_CODE, ' + #13#10 +
      'emn.icd_code2,' + #13#10 +
      'emn.icd_code2_add,' + #13#10 +
      'emn.icd_code3,' + #13#10 +
      'emn.icd_code3_add' + #13#10 +
      '' + #13#10 +
      '' + #13#10 +
      '' + #13#10 +
      'from blanka_med_napr_3a emn' + #13#10 +
      'where emn.id = :emn_id';

  ibsqlCommand.ParamByName('emn_id').AsInteger := mn.MnID;
  ibsqlCommand.ExecQuery;

  mn.Nomer := ibsqlCommand.Fields[2].AsInteger;
  mn.DateMn := ibsqlCommand.Fields[3].AsDate;
  mn.ICD_CODE := ibsqlCommand.Fields[4].AsString;
  mn.MED_DIAG_NAPR_TYPE_ID := ibsqlCommand.Fields[5].AsInteger;
  mn.ICD_CODE_ADD := ibsqlCommand.Fields[6].AsString;
  mn.ForSpec := ibsqlCommand.Fields[7].AsString;
  mn.VSD_CODE := ibsqlCommand.Fields[8].AsString;
  mn.ICD_CODE2 := ibsqlCommand.Fields[9].AsString;
  mn.ICD_CODE2_ADD := ibsqlCommand.Fields[10].AsString;
  mn.ICD_CODE3 := ibsqlCommand.Fields[11].AsString;
  mn.ICD_CODE3_ADD := ibsqlCommand.Fields[12].AsString;



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
  ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.DoctorID;
  ibsqlCommand.ExecQuery;

  mn.FPregled.Performer.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.Performer.RzokR  := ibsqlCommand.Fields[1].AsString;

  if  mn.FPregled.Fdeput <> nil then
  begin
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.Fdeput.DoctorID;
    ibsqlCommand.ExecQuery;

    mn.FPregled.Fdeput.Rzok  := ibsqlCommand.Fields[0].AsString;
    mn.FPregled.Fdeput.RzokR  := ibsqlCommand.Fields[1].AsString;
  end
  else
  begin

  end;


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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
  end;
  ibsqlCommand.ExecQuery;

  mn.FPregled.FPatient.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.FPatient.RzokR  := ibsqlCommand.Fields[1].AsString;
  mn.FPregled.FPatient.birthDate.Date  := ibsqlCommand.Fields[2].AsDate;
  if mn.FPregled.Purpose = pbChildHealthcare then
  begin
    mn.FPregled.ChildHealthcare.Age := CalcAge(mn.FPregled.StartDate, mn.FPregled.FPatient.birthDate.Date);
  end;
  mn.FPregled.FPatient.gender.GenderDB  := ibsqlCommand.Fields[3].AsInteger;
  mn.FPregled.FPatient.Address.City := ibsqlCommand.Fields[4].AsString;
  mn.FPregled.FPatient.Address.Obshtina := ibsqlCommand.Fields[5].AsString;
  mn.FPregled.FPatient.Address.Country := ibsqlCommand.Fields[6].AsString;
  if IsGP then
  begin
    mn.FPregled.FPatient.DoctorID := ibsqlCommand.Fields[7].AsInteger;
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    begin
      mn.FPregled.DeputDoctorID := mn.FPregled.DoctorID;
      mn.FPregled.DoctorID := mn.FPregled.FPatient.DoctorID;
      for i := 0 to DoctorColl.Count - 1 do
      begin
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DeputDoctorID then
        begin
          mn.FPregled.Fdeput := DoctorColl.Items[i];
          if mn.FPregled.IS_ZAMESTVASHT then
            mn.FPregled.Fdeput.Role := drDeputizing
          else
            mn.FPregled.Fdeput.Role := drHired;
        end;
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DoctorID then
          mn.FPregled.Performer := DoctorColl.Items[i];
      end;
    end;

  end;

  for i := 0 to oblastColl.Count - 1 do
  begin
    if StrToInt(mn.FPregled.FPatient.RZOK) = oblastColl.Items[i].OblID then
    begin
      obl := oblastColl.Items[i];
      mn.FPregled.FPatient.Address.County := obl.OblNzis;
      for j := 0 to obl.Obshtini.Count - 1 do
      begin
        obsht := TObshtinaItem(obl.Obshtini[j]);
        if AnsiUpperCase(mn.FPregled.FPatient.Address.Obshtina) = AnsiUpperCase(obsht.ObshName) then
        begin
          //pat.Obshtina := obsht.ObshName;
          for k := 0 to obsht.NasMesta.Count - 1 do
          begin
            nasMesto := TNasMestoItem(obsht.NasMesta[k]);
            if AnsiUpperCase(mn.FPregled.FPatient.Address.City) = AnsiUpperCase(nasMesto.NasMestoName) then
            begin
              mn.FPregled.FPatient.Address.City := nasMesto.NasMestoName;
              mn.FPregled.FPatient.Address.PostalCode := nasMesto.ZIP;
              mn.FPregled.FPatient.Address.Ekatte := nasMesto.EKATTE;
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
  mn.IsAddedFull := True;
end;

procedure TMDNMessages.AddFullMN6(mn: TMn6Item);
var
  i, j, k: Integer;
  obl: TOblastItem;
  obsht: TObshtinaItem;
  nasMesto: TNasMestoItem;

  DiagReport: TDiagnosticReport;
  Diag: TDiagnosisBasic;
  anal: TAnalItem;
begin
  ibsqlCommand.Close;
  if PregledColl.FNzisNomen = nil then
    PregledColl.FNzisNomen := TNzisNomen.create;
  ibsqlCommand.SQL.Text :=
      'select' + #13#10 +
      'emn.id,' + #13#10 +
      'emn.pregled_id,' + #13#10 +
      'emn.number,' + #13#10 +
      'emn.data,' + #13#10 +
      'emn.icd_code,' + #13#10 +
      'emn.lkk_type_id,' + #13#10 +
      'emn.icd_code_add,' + #13#10 +
      '(select sp.specnziscode from speciality sp where sp.id = d.speciality_id), ' + #13#10 +
      'emn.icd_code2,' + #13#10 +
      'emn.icd_code2_add' + #13#10 +


      '' + #13#10 +
      'from exam_lkk emn' + #13#10 +
      'inner join exam_lkk_doctor d on d.exam_lkk_id = emn.id' + #13#10 +
      'where emn.id = :emn_id;';

  ibsqlCommand.ParamByName('emn_id').AsInteger := mn.MnID;
  ibsqlCommand.ExecQuery;

  while not ibsqlCommand.eof do
  begin
    mn.Nomer := ibsqlCommand.Fields[2].AsInteger;
    mn.DateMn := ibsqlCommand.Fields[3].AsDate;
    mn.ICD_CODE := ibsqlCommand.Fields[4].AsString;
    mn.LkkType := ibsqlCommand.Fields[5].AsInteger;
    mn.ICD_CODE_ADD := ibsqlCommand.Fields[6].AsString;
    mn.FForSpecArr.add(ibsqlCommand.Fields[7].AsString);
    mn.ICD_CODE2 := ibsqlCommand.Fields[8].AsString;
    mn.ICD_CODE2_ADD := ibsqlCommand.Fields[9].AsString;
    //mn.ICD_CODE3 := ibsqlCommand.Fields[10].AsString;
//    mn.ICD_CODE3_ADD := ibsqlCommand.Fields[11].AsString;
    ibsqlCommand.Next;
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
  ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.DoctorID;
  ibsqlCommand.ExecQuery;

  mn.FPregled.Performer.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.Performer.RzokR  := ibsqlCommand.Fields[1].AsString;

  if  mn.FPregled.Fdeput <> nil then
  begin
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.Fdeput.DoctorID;
    ibsqlCommand.ExecQuery;

    mn.FPregled.Fdeput.Rzok  := ibsqlCommand.Fields[0].AsString;
    mn.FPregled.Fdeput.RzokR  := ibsqlCommand.Fields[1].AsString;
  end
  else
  begin

  end;


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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
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
    ibsqlCommand.ParamByName('id').AsInteger := mn.FPregled.PatientID;
  end;
  ibsqlCommand.ExecQuery;

  mn.FPregled.FPatient.Rzok  := ibsqlCommand.Fields[0].AsString;
  mn.FPregled.FPatient.RzokR  := ibsqlCommand.Fields[1].AsString;
  mn.FPregled.FPatient.birthDate.Date  := ibsqlCommand.Fields[2].AsDate;
  if mn.FPregled.Purpose = pbChildHealthcare then
  begin
    mn.FPregled.ChildHealthcare.Age := CalcAge(mn.FPregled.StartDate, mn.FPregled.FPatient.birthDate.Date);
  end;
  mn.FPregled.FPatient.gender.GenderDB  := ibsqlCommand.Fields[3].AsInteger;
  mn.FPregled.FPatient.Address.City := ibsqlCommand.Fields[4].AsString;
  mn.FPregled.FPatient.Address.Obshtina := ibsqlCommand.Fields[5].AsString;
  mn.FPregled.FPatient.Address.Country := ibsqlCommand.Fields[6].AsString;
  if IsGP then
  begin
    mn.FPregled.FPatient.DoctorID := ibsqlCommand.Fields[7].AsInteger;
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    begin
      mn.FPregled.DeputDoctorID := mn.FPregled.DoctorID;
      mn.FPregled.DoctorID := mn.FPregled.FPatient.DoctorID;
      for i := 0 to DoctorColl.Count - 1 do
      begin
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DeputDoctorID then
        begin
          mn.FPregled.Fdeput := DoctorColl.Items[i];
          if mn.FPregled.IS_ZAMESTVASHT then
            mn.FPregled.Fdeput.Role := drDeputizing
          else
            mn.FPregled.Fdeput.Role := drHired;
        end;
        if DoctorColl.Items[i].DoctorId = mn.FPregled.DoctorID then
          mn.FPregled.Performer := DoctorColl.Items[i];
      end;
    end;

  end;

  for i := 0 to oblastColl.Count - 1 do
  begin
    if StrToInt(mn.FPregled.FPatient.RZOK) = oblastColl.Items[i].OblID then
    begin
      obl := oblastColl.Items[i];
      mn.FPregled.FPatient.Address.County := obl.OblNzis;
      for j := 0 to obl.Obshtini.Count - 1 do
      begin
        obsht := TObshtinaItem(obl.Obshtini[j]);
        if AnsiUpperCase(mn.FPregled.FPatient.Address.Obshtina) = AnsiUpperCase(obsht.ObshName) then
        begin
          //pat.Obshtina := obsht.ObshName;
          for k := 0 to obsht.NasMesta.Count - 1 do
          begin
            nasMesto := TNasMestoItem(obsht.NasMesta[k]);
            if AnsiUpperCase(mn.FPregled.FPatient.Address.City) = AnsiUpperCase(nasMesto.NasMestoName) then
            begin
              mn.FPregled.FPatient.Address.City := nasMesto.NasMestoName;
              mn.FPregled.FPatient.Address.PostalCode := nasMesto.ZIP;
              mn.FPregled.FPatient.Address.Ekatte := nasMesto.EKATTE;
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
  mn.IsAddedFull := True;
end;

constructor TMDNMessages.create;
begin
  inherited;
  IsR001 := False;
  CL024 := TStringList.Create;
  CL024.Text :=
      '' + #13#10 +
      'Левкоцити (WBC)' + #13#10 +
      'Еритроцити (RBC)' + #13#10 +
      'Хемоглобин (HGB)' + #13#10 +
      'Хематокрит (HCT)' + #13#10 +
      'Среден обем на еритроцитите (MCV)' + #13#10 +
      'Средно съдържание на хемоглобин в еритроцита (MCH)' + #13#10 +
      'Средна концентрация на хемоглобин в еритроцитите (MCHC)' + #13#10 +
      'Тромбоцити (PLT)' + #13#10 +
      'СУЕ (ESR)' + #13#10 +
      'RT-PCR' + #13#10 +
      'Време на кървене' + #13#10 +
      'Протромбиново време' + #13#10 +
      'C-реактивен протеин (CRP)' + #13#10 +
      'Разчитане на рентгенова снимка на гръден кош и бял дроб' + #13#10 +
      'Неутрофили' + #13#10 +
      'Лимфоцити' + #13#10 +
      'Моноцити' + #13#10 +
      'Еозинофили' + #13#10 +
      'Базофили' + #13#10 +
      'Пръчкоядрени неутрофили (St)' + #13#10 +
      'Ширина на разпределение на еритроцитите (RDW)' + #13#10 +
      'Среден обем на тромбоцитите (MPV)' + #13#10 +
      'Ширина на разпределение на тромбоцитите (PDW)' + #13#10 +
      'Тромбокрит (PCT)' + #13#10 +
      'Бърз антигенен тест';

  AnalIDs := TStringList.Create;

end;

destructor TMDNMessages.destroy;
begin
  FreeAndNil(CL024);
  FreeAndNil(AnalIDs);
  inherited;
end;



procedure TMDNMessages.FindSender(senderId: integer);
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

procedure TMDNMessages.GenerateC007(mdn: TMdnItem);
var
  mess: TMessageC007;
  oXml: IXMLDocument;
begin
  GenXML.Clear;
  mdn.Device1064 := GetDevice1064;
  mdn.Device0512 := GetDevice0512;
  mess := TMessageC007.Create;
  mdn.FMessage := mess;

  mess.mdn := mdn;
  mess.Header.SenderID := FPerformer.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  try
    oXml.LoadFromStream(mess.XMLStream);
  except
    ShowMessage('Има невалиден символ в текста на резултата!');
  end;
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateC009(mdn: TMdnItem);
var
  mess: TMessageC009;
  oXml: IXMLDocument;
begin
  //if not mdn.IsAddedFull then
//  begin
//    AddFullMDN(mdn);
//  end;

  GenXML.Clear;
  //ibsqlCommand
  mdn.Device1064 := GetDevice1064;
  mdn.Device0512 := GetDevice0512;
  mess := TMessageC009.Create;
  mdn.FMessage := mess;

  mess.mdn := mdn;
  mess.Header.SenderID := FPerformer.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  try
    oXml.LoadFromStream(mess.XMLStream);
  except
    ShowMessage('Има невалиден символ в текста на резултата!');
  end;
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR001(mdn: TMdnItem);
var
  mess: TMessageR001;
  oXml: IXMLDocument;
  aDeput: TPerformerItem;
begin
  if not mdn.IsAddedFull then
  begin
    aDeput := mdn.FPregled.Fdeput;
    AddFullMDN(mdn);
    mdn.FPregled.Fdeput := aDeput;
    mdn.FPerformer := aDeput;
  end;

  GenXML.Clear;
  mess := TMessageR001.Create;
  mdn.FMessage := mess;
  if mdn.FPregled.IS_ZAMESTVASHT or mdn.FPregled.IS_NAET then
    mess.Sender := mdn.FPregled.Fdeput
  else
    mess.Sender := mdn.FPregled.Performer;
  mess.mdn := mdn;
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
end;

procedure TMDNMessages.GenerateR001Hosp(mn: TMnHospItem);
var
  mess: TMessageR001;
  oXml: IXMLDocument;
begin
  //ShowMessage('GenerateR001Hosp');
  if not mn.IsAddedFull then
  begin
    AddFullHosp(mn);
  end;

  GenXML.Clear;
  mess := TMessageR001.Create;
  mn.FMessage := mess;
  if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    mess.Sender := mn.FPregled.Fdeput
  else
    mess.Sender := mn.FPregled.Performer;
  mess.Hosp := mn;
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
end;

procedure TMDNMessages.GenerateR001MN(mn: TMnItem);
var
  mess: TMessageR001;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN(mn);
  end;

  GenXML.Clear;
  mess := TMessageR001.Create;
  mn.FMessage := mess;
  if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    mess.Sender := mn.FPregled.Fdeput
  else
    mess.Sender := mn.FPregled.Performer;
  mess.mn := mn;
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
end;

procedure TMDNMessages.GenerateR001MN3A(mn: TMn3AItem);
var
  mess: TMessageR001;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN3A(mn);
  end;

  GenXML.Clear;
  mess := TMessageR001.Create;
  mn.FMessage := mess;
  if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    mess.Sender := mn.FPregled.Fdeput
  else
    mess.Sender := mn.FPregled.Performer;
  mess.mn3A := mn;
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
end;

procedure TMDNMessages.GenerateR001MN6(mn: TMn6Item);
var
  mess: TMessageR001;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN6(mn);
  end;

  GenXML.Clear;
  mess := TMessageR001.Create;
  mn.FMessage := mess;
  if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
    mess.Sender := mn.FPregled.Fdeput
  else
    mess.Sender := mn.FPregled.Performer;
  mess.mn6 := mn;
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
end;

procedure TMDNMessages.GenerateR003(mdn: TMdnItem);
var
  mess: TMessageR003;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageR003.Create;
  mdn.FMessage := mess;

  mess.mdn := mdn;
  mess.Header.SenderID := mdn.FSender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR003Hosp(mn: TMnHospItem);
begin

end;

procedure TMDNMessages.GenerateR003MN(mn: TMnItem);
var
  mess: TMessageR003;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageR003.Create;
  mn.FMessage := mess;

  mess.mn := mn;
  mess.Header.SenderID := mn.FSender.SenderID;
  mess.Header.MessageType := 'R015';

  mess.FillXmlSream;

  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR003MN3A(mn: TMn3AItem);
begin

end;

procedure TMDNMessages.GenerateR003MN6(mn: TMn6Item);
begin

end;

procedure TMDNMessages.GenerateR005(mdn: TMdnItem);
var
  mess: TMessageR005;
  oXml: IXMLDocument;
begin
  //if not mdn.IsAddedFull then
//  begin
//    AddFullMDN(mdn);
//  end;

  GenXML.Clear;
  //ibsqlCommand
  mdn.Device1064 := GetDevice1064;
  mdn.Device0512 := GetDevice0512;
  mess := TMessageR005.Create;
  mdn.FMessage := mess;
  //if mdn.FPregled.IS_ZAMESTVASHT or mdn.FPregled.IS_NAET then
//    mess.Sender := mdn.FPregled.Fdeput
//  else
//    mess.Sender := mdn.FPregled.FPerformer;
  mess.mdn := mdn;
  mess.Header.SenderID := FPerformer.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  try
    oXml.LoadFromStream(mess.XMLStream);
  except
    ShowMessage('Има невалиден символ в текста на резултата!');
  end;
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR007(mdn: TMdnItem);
var
  mess: TMessageR007;
  oXml: IXMLDocument;
begin
  if not mdn.IsAddedFull then
  begin
    AddFullMDN(mdn);
  end;

  GenXML.Clear;
  mess := TMessageR007.Create;
  mdn.FMessage := mess;
  if self.Sender = nil then
  begin
    if mdn.FPregled.IS_ZAMESTVASHT or mdn.FPregled.IS_NAET then
      mess.Sender := mdn.FPregled.Fdeput
    else
      mess.Sender := mdn.FPregled.Performer;
  end
  else
  begin
    mess.Sender := self.Sender;
  end;
  mess.mdn := mdn;
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
end;

procedure TMDNMessages.GenerateR007Hosp(mn: TMnHospItem);
var
  mess: TMessageR007;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullHosp(mn);
  end;

  GenXML.Clear;
  mess := TMessageR007.Create;
  mn.FMessage := mess;
  if self.sender = nil then
  begin
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
      mess.Sender := mn.FPregled.Fdeput
    else
      mess.Sender := mn.FPregled.Performer;
  end
  else
  begin
    mess.Sender := self.sender;
  end;
  mess.MNHosp := mn;
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
end;

procedure TMDNMessages.GenerateR007MN(mn: TMnItem);
var
  mess: TMessageR007;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN(mn);
  end;

  GenXML.Clear;
  mess := TMessageR007.Create;
  mn.FMessage := mess;
  if self.Sender = nil then
  begin
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
      mess.Sender := mn.FPregled.Fdeput
    else
      mess.Sender := mn.FPregled.Performer;
  end
  else
  begin
    mess.Sender := self.Sender;
  end;
  mess.mn := mn;
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
end;

procedure TMDNMessages.GenerateR007MN3A(mn: TMn3AItem);
var
  mess: TMessageR007;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN3A(mn);
  end;

  GenXML.Clear;
  mess := TMessageR007.Create;
  mn.FMessage := mess;
  if self.Sender = nil then
  begin
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
      mess.Sender := mn.FPregled.Fdeput
    else
      mess.Sender := mn.FPregled.Performer;
  end
  else
  begin
    mess.Sender := self.Sender;
  end;
  mess.MN3A := mn;
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
end;

procedure TMDNMessages.GenerateR007MN6(mn: TMn6Item);
var
  mess: TMessageR007;
  oXml: IXMLDocument;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN6(mn);
  end;

  GenXML.Clear;
  mess := TMessageR007.Create;
  mn.FMessage := mess;
  if self.Sender = nil then
  begin
    if mn.FPregled.IS_ZAMESTVASHT or mn.FPregled.IS_NAET then
      mess.Sender := mn.FPregled.Fdeput
    else
      mess.Sender := mn.FPregled.Performer;
  end
  else
  begin
    mess.Sender := self.Sender;
  end;
  mess.MN6 := mn;
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
end;

procedure TMDNMessages.GenerateR009(mdns: TList<TMdnItem>);
var
  mess: TMessageR009;
  oXml: IXMLDocument;
begin
  //if not mdn.IsAddedFull then
//  begin
//    AddFullMDN(mdn);
//  end;

  GenXML.Clear;
  mess := TMessageR009.Create;
  mess.MDNs := mdns;
 // if   .IS_ZAMESTVASHT or preg.IS_NAET then
//    mess.Sender := preg.Fdeput
//  else
//    mess.Sender := preg.FPerformer;
  mess.Sender := mdns[0].FPerformer;
  Self.FPerformer := mdns[0].FPerformer;
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
end;

procedure TMDNMessages.GenerateR009MN(mn: TMnItem);
var
  mess: TMessageR009;
  oXml: IXMLDocument;
begin
  GenXML.Clear;
  mess := TMessageR009.Create;
  mess.Sender :=Self.FPerformer;
  //Self.FPerformer := mn.FPerformer;
  mess.Header.SenderID := mess.Sender.SenderID;
  mn.FPerformer := Self.FPerformer;
  mess.MN := mn;
  mess.FillXmlStreamMN;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR011(mdn: TMdnItem);
var
  mess: TMessageR011;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageR011.Create;
  mess.hndSenderWindow := Self.HandleHip;
  mdn.FMessage := mess;

  mess.mdn := mdn;
  mess.Header.SenderID := mdn.FSender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR015MDN_EGN(mdn: TMdnItem);
var
  mess: TMessageR015EGN;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageR015EGN.Create;

  mess.Header.SenderID := Self.FPerformer.Pmi;
  mess.Header.MessageType := 'R003';

  mess.Egn := Self.Egn;
  mess.FromDate := Self.FromDate;
  mess.PidType := Self.PidType;
  mess.Sender := Self.FPerformer;

  mess.FillXmlSream;

  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR015MN(mn: TMnItem);
var
  mess: TMessageR015;
  oXml: IXMLDocument;
  i: Integer;
begin
  if not mn.IsAddedFull then
  begin
    AddFullMN(mn);
  end;
  GenXML.Clear;
  mess := TMessageR015.Create;
  mn.FMessage := mess;

  mess.mn := mn;
  mess.Header.SenderID := mn.FSender.SenderID;
  mess.Header.MessageType := 'R015';

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR015MN_EGN(mn: TMnItem);
var
  mess: TMessageR015EGN;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageR015EGN.Create;

  mess.Header.SenderID := Self.FPerformer.Pmi;
  mess.Header.MessageType := 'R015';

  mess.Egn := Self.Egn;
  mess.FromDate := Self.FromDate;
  mess.PidType := Self.PidType;
  mess.Sender := Self.FPerformer;

  mess.FillXmlSream;

  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.GenerateR017MDN(mdn: TMdnItem);
var
  mess: TMessageR017;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageR017.Create;
  mdn.FMessage := mess;

  mess.mdn := mdn;
  mess.Header.SenderID := mdn.FSender.SenderID;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure TMDNMessages.SaveExamAnal;
var
  i, j: Integer;
  Mdn: TMdnItem;
  sql: string;
  resInfo: TNzisResultInfo;
  ExamAnalID, analID: Integer;
  streamResult: TMemoryStream;

begin
  for i := 0 to EmdnColl.Count - 1 do
  begin
    Mdn := EmdnColl.Items[i];
    for j := 0 to  Mdn.ResultHip.Count - 1 do
    begin
      resInfo := Mdn.ResultHip[j];

      ibsqlCommand.Close;
      ibsqlCommand.SQL.Text :=
      'select ea.id,  ea.analysis_id, cl22.key_022 from exam_analysis ea' + #13#10 +
      'inner join blanka_mdn mdn on mdn.id = ea.blanka_mdn_id' + #13#10 +
      'inner join analysis a on a.id = ea.analysis_id' + #13#10 +
      'left join nzis_cl022 cl22 on cl22.nhif_code = lpad (a.package,2,  ''0'') || ''.'' || lpad (a.code,2,  ''0'')' + #13#10 +
      'where mdn.id = :BLANKA_MDN_ID and  cl22.key_022 = :key_022';

      ibsqlCommand.ParamByName('BLANKA_MDN_ID').AsInteger := Mdn.MdnID;
      ibsqlCommand.ParamByName('key_022').AsString := resInfo.analCode;

      ibsqlCommand.ExecQuery;

      ExamAnalID := ibsqlCommand.Fields[0].AsInteger;
      analID := ibsqlCommand.Fields[1].AsInteger;

      ibsqlCommand.Close;
      ibsqlCommand.SQL.Text :=
      'SELECT RDB$FIELD_NAME AS FIELD_NAME' + #13#10 +
      'FROM RDB$RELATION_FIELDS' + #13#10 +
      'WHERE RDB$RELATION_NAME=''EXAM_ANALYSIS''' + #13#10 +
      'AND RDB$FIELD_NAME = ''NRN_EXECUTION'';';
      ibsqlCommand.ExecQuery;
      if ibsqlCommand.eof then
      begin
        ibsqlCommand.Close;
        ibsqlCommand.SQL.Text :=
        'ALTER TABLE EXAM_ANALYSIS' + #13#10 +
        'ADD NRN_EXECUTION VARCHAR(12);';
        ibsqlCommand.ExecQuery;
        ibsqlCommand.Transaction.CommitRetaining;
      end;



      ibsqlCommand.Close;
      ibsqlCommand.SQL.Text :=
      'update or insert INTO EXAM_ANALYSIS (ID, PREGLED_ID, ANALYSIS_ID, BLANKA_MDN_ID, RESULT, DATA, NRN_EXECUTION)' + #13#10 +
      'VALUES (gen_id(gen_exam_analysis_id, 1), :PREGLED_ID, :ANALYSIS_ID, :BLANKA_MDN_ID, :RESULT, :DATA, :NRN_EXECUTION)' + #13#10 +
      'matching (PREGLED_ID, ANALYSIS_ID, BLANKA_MDN_ID);';

      ibsqlCommand.ParamByName('PREGLED_ID').AsInteger := Mdn.PregledID;
      ibsqlCommand.ParamByName('ANALYSIS_ID').AsInteger := analID;
      ibsqlCommand.ParamByName('RESULT').AsString := LeftStr(resInfo.result, 999);
      ibsqlCommand.ParamByName('NRN_EXECUTION').AsString := resInfo.NRN_EXECUTION;
      ibsqlCommand.ParamByName('DATA').AsDate := resInfo.data;
      ibsqlCommand.ParamByName('BLANKA_MDN_ID').AsInteger := Mdn.MdnID;

      ibsqlCommand.ExecQuery;
      ibsqlCommand.Close;

      ibsqlCommand.Close;
      ibsqlCommand.SQL.Text :=
          'update or insert into nzis_result (exam_analysis_id, RESULT_ANAL) ' + #13#10 +
          'values(:exam_analysis_id, :result) ' + #13#10 +
          'matching (exam_analysis_id) ';
      ibsqlCommand.ParamByName('exam_analysis_id').AsInteger := ExamAnalID;
      //streamResult := TMemoryStream.Create;
//      streamResult.Position := 0;
//      streamResult.Write(resInfo.result[1], Length(resInfo.result)
      ibsqlCommand.ParamByName('result').AsString := resInfo.result;
      ibsqlCommand.ExecQuery;
    end;
  end;
  ibsqlCommand.Transaction.CommitRetaining;
end;

end.
