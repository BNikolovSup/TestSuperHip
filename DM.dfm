object DUNzis: TDUNzis
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 571
  Width = 1245
  object DBMain: TIBDatabase
    Connected = True
    DatabaseName = 'D:\Biser\bazaDanni\HIPPOCRATES_Evtimova\HIPPOCRATES.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = traMain
    ServerType = 'IBServer'
    AfterConnect = DBMainAfterConnect
    Left = 63
    Top = 32
  end
  object traMain: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 127
    Top = 40
  end
  object ibsqlCommand: TIBSQL
    Database = DBMain
    SQL.Strings = (
      '')
    Transaction = traMain
    OnSQLChanging = ibsqlCommandSQLChanging
    Left = 103
    Top = 123
  end
  object ibsqlDocLite: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'doc.id,'
      'doc.fname,'
      'doc.sname,'
      'doc.lname,'
      'doc.uin,'
      'sp.code,'
      'sp.specnziscode,'
      '   token.id,'
      '   token.doctor_id,'
      '   token.to_time,'
      '   token."VALUE",'
      'doc.egn'
      'from doctor doc'
      'left join nzis_tokens token on token.doctor_id = doc.id'
      'inner join speciality sp on sp.id = doc.speciality_id')
    Transaction = traMain
    Left = 191
    Top = 40
  end
  object ibsqlPregledLite: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'pr.id, '
      'pr.pacient_id,'
      'pr.doctor_id,'
      'pr.start_date,'
      'pr.amb_listn,'
      'pr.is_zamestvasht,'
      'pr.is_naet,'
      'pr.owner_doctor_id'
      ''
      ' from pregled pr2'
      'where pr.start_date > '#39'01.01.2020'#39
      '--and pr.main_diag_mkb in ('#39'Z39.2'#39', '#39'Z34.0'#39', '#39'Z34.8'#39', '#39'Z34.9'#39')'
      '--and (pr.is_zamestvasht = '#39'Y'#39')'
      'and pr.procedure1_mkb is  not null')
    Transaction = traMain
    Left = 271
    Top = 40
  end
  object ibsqlPatLite: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'pa.id,'
      'pa.fname,'
      'pa.sname,'
      'pa.lname,'
      'case pa.pid_type'
      '     when '#39'B'#39' then coalesce(pa.nzis_bebe, pa.egn)'
      '     else pa.egn'
      'end as EGN,'
      'pa.pid_type,'
      'pa.NZIS_PID,'
      'pa.NZIS_PID_TYPE,'
      'pa.birth_date,'
      'pa.sex_type,'
      'pa.nas_mqsto,'
      'pa.obshtina,'
      'pa.country,'
      'pa.rzok,'
      'pa.rzokr'
      ''
      ''
      'from pacient pa'
      'where pa.id = :Pa_id')
    Transaction = traMain
    Left = 375
    Top = 40
  end
  object ibsqlPrac: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select ini.INI_VALUE, practica.nomer_lz, practica.nzok_nomer'
      'from ini, practica'
      
        'WHERE (ini.INI_SECTION = '#39'Version'#39') AND (ini.INI_KEY = '#39'ProgramN' +
        'ame'#39');')
    Transaction = traMain
    Left = 447
    Top = 40
  end
  object ibsqlDokuments: TIBSQL
    Database = DBMain
    SQL.Strings = (
      
        'select fr.id, fr.data, fr.pregled_id, fr.form_number, fr.nzis_nr' +
        'n, 3 as Vid, -1 as status, fr.rec_status as Str_status from free' +
        '_recipe fr'
      'where fr.data >= :starDate and fr.data <= :endDate'
      'union'
      
        'select im.id, im.data, im.pregled_id, im.immunization_id, im.nrn' +
        '_immunization, 0 as Vid, im. IMMUNIZATION_STATUS as status, '#39#39' a' +
        's Str_status  from exam_immunization im'
      'where im.data >= :starDate and im.data <= :endDate'
      'union'
      
        'select mdn.id, mdn.data, mdn.pregled_id, mdn.number, mdn.nrn, 1 ' +
        'as Vid, mdn.nzis_status as status, '#39#39' as Str_status from blanka_' +
        'mdn mdn'
      'where mdn.data >= :starDate and mdn.data <= :endDate'
      'union'
      
        'select Emdn.id, cast(Emdn.date_created as date), Emdn.pregled_id' +
        ', 0, emdn.nrn, 2 as Vid, emdn.nzis_status as status, '#39#39' as Str_s' +
        'tatus from nzis_mdn Emdn'
      
        'where cast(Emdn.date_created as date) >= :starDate and cast(Emdn' +
        '.date_created as date) <= :endDate'
      'union'
      
        'select lkk.id, lkk.data, lkk.pregled_id, lkk.number, '#39#39', 4 as Vi' +
        'd, -1 as status, '#39#39' as Str_status from exam_lkk lkk'
      'where lkk.data >= :starDate and lkk.data <= :endDate'
      'union'
      
        'select -1, bnt.create_date, bnt.pregled_id, bnt.nomer, '#39#39', 5 as ' +
        'Vid, -1 as status, '#39#39' as Str_status from blanka_napr_telk bnt'
      
        'where bnt.create_date >= :starDate and bnt.create_date <= :endDa' +
        'te'
      'union'
      
        'select -1, fn.fast_notify_fill_date, fn.pregled_id, 0, '#39#39', 6 as ' +
        'Vid, -1 as status, '#39#39' as Str_status from fast_notify fn'
      
        'where fn.fast_notify_fill_date >= :starDate and fn.fast_notify_f' +
        'ill_date <= :endDate'
      'union'
      
        'select mb.id, mb.data, mb.pregled_id, 0, '#39#39', 7 as Vid, -1 as sta' +
        'tus, '#39#39' as Str_status from med_belejka mb'
      'where mb.data >= :starDate and mb.data <= :endDate'
      'union'
      
        'select ebl.id, ebl.data, ebl.pregled_id, ebl.el_number, '#39#39', 8 as' +
        ' Vid, -1 as status, '#39#39' as Str_status from exam_boln_list ebl'
      'where ebl.data >= :starDate and ebl.data <= :endDate'
      '')
    Transaction = traMain
    Left = 287
    Top = 144
  end
  object ibsqlDocumentPat: TIBSQL
    Database = DBMain
    SQL.Strings = (
      
        'select fr.id, fr.data, fr.pregled_id, fr.form_number, fr.nzis_nr' +
        'n, 3 as Vid, -1 as status, fr.rec_status as Str_status from free' +
        '_recipe fr'
      
        'inner join pregled pr on pr.id = fr.pregled_id and pr.pacient_id' +
        ' = :PatId'
      'union'
      
        'select im.id, im.data, im.pregled_id, im.immunization_id, im.nrn' +
        '_immunization, 0 as Vid, im. IMMUNIZATION_STATUS as status, '#39#39' a' +
        's Str_status from exam_immunization im'
      
        'inner join pregled pr on pr.id = im.pregled_id and pr.pacient_id' +
        ' = :PatId'
      'union'
      
        'select mdn.id, mdn.data, mdn.pregled_id, mdn.number, mdn.nrn, 1 ' +
        'as Vid, mdn.nzis_status as status, '#39#39' as Str_status from blanka_' +
        'mdn mdn'
      
        'inner join pregled pr on pr.id = mdn.pregled_id and pr.pacient_i' +
        'd = :PatId'
      'union'
      
        'select Emdn.id, cast(Emdn.date_created as date), Emdn.pregled_id' +
        ', 0, emdn.nrn, 2 as Vid, emdn.nzis_status as status, '#39#39' as Str_s' +
        'tatus from nzis_mdn Emdn'
      
        'inner join pregled pr on pr.id = emdn.pregled_id and pr.pacient_' +
        'id = :PatId'
      'union'
      
        'select lkk.id, lkk.data, lkk.pregled_id, lkk.number, '#39#39', 4 as Vi' +
        'd, -1 as status, '#39#39' as Str_status from exam_lkk lkk'
      
        'inner join pregled pr on pr.id = lkk.pregled_id and pr.pacient_i' +
        'd = :PatId'
      'union'
      
        'select -1, bnt.create_date, bnt.pregled_id, bnt.nomer, '#39#39', 5 as ' +
        'Vid, -1 as status, '#39#39' as Str_status from blanka_napr_telk bnt'
      
        'inner join pregled pr on pr.id = bnt.pregled_id and pr.pacient_i' +
        'd = :PatId'
      'union'
      
        'select -1, fn.fast_notify_fill_date, fn.pregled_id, 0, '#39#39', 6 as ' +
        'Vid, -1 as status, '#39#39' as Str_status from fast_notify fn'
      
        'inner join pregled pr on pr.id = fn.pregled_id and pr.pacient_id' +
        ' = :PatId'
      'union'
      
        'select mb.id, mb.data, mb.pregled_id, 0, '#39#39', 7 as Vid, -1 as sta' +
        'tus, '#39#39' as Str_status from med_belejka mb'
      
        'inner join pregled pr on pr.id = mb.pregled_id and pr.pacient_id' +
        ' = :PatId'
      'union'
      
        'select ebl.id, ebl.data, ebl.pregled_id, ebl.el_number, '#39#39', 8 as' +
        ' Vid, -1 as status, '#39#39' as Str_status from exam_boln_list ebl'
      
        'inner join pregled pr on pr.id = ebl.pregled_id and pr.pacient_i' +
        'd = :PatId'
      '')
    Transaction = traMain
    Left = 383
    Top = 144
  end
  object ibsqlPreg: TIBSQL
    Database = DBMain
    SQL.Strings = (
      
        'select fr.id, fr.data, fr.pregled_id, fr.form_number, fr.nzis_nr' +
        'n, 3 as Vid, fr.status, fr.rec_status as Str_status from free_re' +
        'cipe fr'
      'where fr.pregled_id = :pr_id'
      'union'
      
        'select im.id, im.data, im.pregled_id, im.immunization_id, im.nrn' +
        '_immunization, 0 as Vid, im. IMMUNIZATION_STATUS as status, '#39#39' a' +
        's Str_status  from exam_immunization im'
      'where im.pregled_id = :pr_id'
      'union'
      
        'select mdn.id, mdn.data, mdn.pregled_id, mdn.number, mdn.nrn, 1 ' +
        'as Vid, mdn.nzis_status as status, '#39#39' as Str_status from blanka_' +
        'mdn mdn'
      'where mdn.pregled_id = :pr_id'
      'union'
      
        'select Emdn.id, cast(Emdn.date_created as date), Emdn.pregled_id' +
        ', 0, emdn.nrn, 2 as Vid, emdn.nzis_status as status, '#39#39' as Str_s' +
        'tatus from nzis_mdn Emdn'
      'where emdn.pregled_id = :pr_id'
      'union'
      
        'select lkk.id, lkk.data, lkk.pregled_id, lkk.number, '#39#39', 4 as Vi' +
        'd, -1 as status, '#39#39' as Str_status from exam_lkk lkk'
      'where lkk.pregled_id = :pr_id'
      'union'
      
        'select -1, bnt.create_date, bnt.pregled_id, bnt.nomer, '#39#39', 5 as ' +
        'Vid, bnt.nzis_status as status, '#39#39' as Str_status from blanka_nap' +
        'r_telk bnt'
      'where bnt.pregled_id = :pr_id'
      'union'
      
        'select -1, fn.fast_notify_fill_date, fn.pregled_id, 0, '#39#39', 6 as ' +
        'Vid, -1 as status, '#39#39' as Str_status from fast_notify fn'
      'where fn.pregled_id = :pr_id'
      'union'
      
        'select mb.id, mb.data, mb.pregled_id, 0, '#39#39', 7 as Vid, -1 as sta' +
        'tus, '#39#39' as Str_status from med_belejka mb'
      'where mb.pregled_id = :pr_id'
      'union'
      
        'select ebl.id, ebl.data, ebl.pregled_id, ebl.el_number, '#39#39', 8 as' +
        ' Vid, -1 as status, '#39#39' as Str_status from exam_boln_list ebl'
      'where ebl.pregled_id = :pr_id'
      'union'
      
        'select mn.id, mn.issue_date, mn.pregled_id, mn.number, mn.nrn, 9' +
        ' as Vid, mn.nzis_status as status, '#39#39' as Str_status from blanka_' +
        'med_napr mn'
      'where mn.pregled_id = :pr_id'
      'union'
      
        'select mn3.id, mn3.issue_date, mn3.pregled_id, mn3.number, mn3.n' +
        'rn, 10 as Vid, mn3.nzis_status as status, '#39#39' as Str_status from ' +
        'blanka_med_napr_3a mn3'
      'where mn3.pregled_id = :pr_id'
      'union'
      
        'select hosp.id, hosp.direct_date, hosp.pregled_id, hosp.number, ' +
        'hosp.nrn, 11 as Vid, hosp.nzis_status as status, '#39#39' as Str_statu' +
        's from hospitalization hosp'
      'where hosp.pregled_id = :pr_id')
    Transaction = traMain
    Left = 503
    Top = 144
  end
  object ibsqlMDNLite: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'emdn.id,'
      'emdn.pregled_id,'
      'emdn.nrn,'
      'doc.uin,'
      'null, --pr.zam_uin,'
      'pr.doctor_id'
      ''
      'from blanka_mdn  emdn'
      'inner join pregled pr on pr.id = emdn.pregled_id'
      'inner join doctor doc on doc.id = pr.doctor_id'
      'where emdn.nrn is not null'
      'and emdn.nrn <> '#39#39
      'and emdn.pregled_id = :pr_id')
    Transaction = traMain
    Left = 55
    Top = 280
  end
  object ibsqlEmdnOne: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'emdn.id,'
      'emdn.pregled_id,'
      'emdn.nrn'
      ''
      ''
      'from blanka_mdn emdn'
      'where emdn.id = :emdn_id')
    Transaction = traMain
    Left = 159
    Top = 272
  end
  object ibsqlEMNOne: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'emn.id,'
      'emn.pregled_id,'
      'emn.nrn'
      ''
      ''
      'from blanka_med_napr emn'
      'where emn.id = :emn_id')
    Transaction = traMain
    Left = 271
    Top = 280
  end
  object ibsqlAnal: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select distinct'
      'a.ID,'
      'a.PARENT_ID,'
      'a.PACKAGE,'
      'a.CODE,'
      'a.NAME,'
      'a.EFFECTIVE,'
      'a.PRICE,'
      'a.MIN_VALUE,'
      'a.MAX_VALUE,'
      'a.UNIT,'
      'a.ROOT_PACKAGE,'
      'a.MIN_VALUE_MALE,'
      'a.MAX_VALUE_MALE,'
      'a.MIN_VALUE_FEMALE,'
      'a.MAX_VALUE_FEMALE,'
      'a.IS_HIGH_SPECIALIZED,'
      'a.PRINTABLE_NAME,'
      'a.DECDIGITS,'
      'a.CATEGORY_ID,'
      'a.REF_VALS_DESCR,'
      'a.NOT_NZOK,'
      'a.DATE_ACTIVATION,'
      'a.DATE_DEACTIVATION,'
      'a.LOINC_CODE,'
      'a.RANK,'
      'a.ISPI_ID,'
      'a.TEST_PLACE,'
      'cl22.KEY_022 as CL22'
      '  from analysis a'
      
        'left join nzis_cl022 cl22 on cl22.nhif_code = lpad (a.package,2,' +
        '  '#39'0'#39') || '#39'.'#39' || lpad (a.code,2,  '#39'0'#39')'
      'where a.effective = '#39'Y'#39)
    Transaction = traMain
    Left = 56
    Top = 360
  end
  object ibsqlMn3AOne: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'emn.id,'
      'emn.pregled_id,'
      'emn.nrn'
      ''
      ''
      'from blanka_med_napr_3a emn'
      'where emn.id = :emn_id')
    Transaction = traMain
    Left = 375
    Top = 280
  end
  object ibsqlEMN6One: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'emn.id,'
      'emn.pregled_id,'
      'emn.nrn'
      ''
      ''
      'from EXAM_LKK emn'
      'where emn.id = :emn_id')
    Transaction = traMain
    Left = 495
    Top = 288
  end
  object ibsqlOneHosp: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'emn.id,'
      'emn.pregled_id,'
      'emn.nrn'
      ''
      ''
      'from hospitalization emn'
      'where emn.id = :emn_id')
    Transaction = traMain
    Left = 535
    Top = 40
  end
  object IBTransaction1: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 608
    Top = 272
  end
  object ibsqlMedbelOne: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'mb.ID,'
      'mb.PREGLED_ID,'
      'mb.PACIENT_ID,'
      'mb.DOCTOR_ID,'
      'mb.DIAGNOZA,'
      'mb.DATA,'
      'mb.PREDNAZNACHENIE,'
      'mb.NUJDA,'
      'mb.PATIENT_STREET,'
      'mb.PATIENT_STREET_NUMBER,'
      'mb.NRN,'
      'mb.NZIS_STATUS,'
      ''
      'pr.main_diag_mkb,'
      'mb.reason,'
      'mb.location,'
      'mb.Valid_from_date,'
      'mb.valid_to_date'
      ''
      ''
      'from med_belejka  mb'
      'inner join pregled pr on pr.id = mb.pregled_id'
      ''
      ''
      'where mb.ID = :ID')
    Transaction = traMain
    Left = 719
    Top = 280
  end
  object ibsqlCommandUdost: TIBSQL
    Database = DBMain
    SQL.Strings = (
      '')
    Transaction = traMain
    OnSQLChanging = ibsqlCommandSQLChanging
    Left = 159
    Top = 355
  end
  object ibsqlPregNew_GP: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select-- first 10000'
      'pr.AMB_LISTN,'
      'pr.ANAMN,'
      'pr.COPIED_FROM_NRN,'
      'pr.GS,'
      'pr.ID,'
      'pr.IZSL,'
      'pr.MEDTRANSKM,'
      'null as NAPRAVLENIE_AMBL_NOMER,'
      'null as NAPR_TYPE_ID,'
      'pr.NOMERBELEGKA,'
      'pr.NOMERKASHAPARAT,'
      'pr.NRD,'
      'pr.NRN,'
      'pr.NZIS_STATUS,'
      'pr.OBSHTAPR,'
      'pr.PATIENTOF_NEOTL,'
      'pr.PATIENTOF_NEOTLID,'
      'pr.PREVENTIVE_TYPE,'
      'null as REH_FINISHED_AT,'
      'pr.START_DATE,'
      'pr.START_TIME,'
      'pr.SYST,'
      'pr.TALON_LKK,'
      'pr.TERAPY,'
      'pr.THREAD_IDS,'
      'null as VISIT_ID,'
      'null as VISIT_TYPE_ID,'
      'pr.VSD_TYPE,'
      ''
      'pr.PACIENT_ID,'
      'pr.MAIN_DIAG_MKB,'
      'pr.MAIN_DIAG_MKB_ADD,'
      'pr.pr_zab1_mkb,'
      'pr.pr_zab1_mkb_add,'
      'pr.pr_zab2_mkb,'
      'pr.pr_zab2_mkb_add,'
      'pr.pr_zab3_mkb,'
      'pr.pr_zab3_mkb_add,'
      'pr.pr_zab4_mkb,'
      'pr.pr_zab4_mkb_add,'
      ''
      'pr.AMB_PR,'
      'pr.DOM_PR,'
      'pr.doctor_id,'
      'pr.is_zamestvasht,'
      'pr.is_naet,'
      'null as owner_doctor_id,'
      'pr.EXAM_BOLN_LIST_ID,'
      'pr.INCIDENTALLY,'
      'pr.IS_ANALYSIS,'
      'pr.IS_BABY_CARE,'
      'pr.IS_CONSULTATION,'
      'pr.IS_DISPANSERY,'
      'pr.IS_EMERGENCY,'
      'pr.IS_EPIKRIZA,'
      'pr.IS_EXPERTIZA,'
      'pr.IS_FORM_VALID,'
      'pr.IS_HOSPITALIZATION,'
      'pr.IS_MANIPULATION,'
      'pr.IS_MEDBELEJKA,'
      ''
      'pr.IS_NAPR_TELK,'
      'pr.IS_NEW,'
      'pr.IS_NOTIFICATION,'
      'pr.IS_NO_DELAY,'
      'pr.IS_OPERATION,'
      'pr.IS_PODVIZHNO_LZ,'
      'pr.IS_PREVENTIVE,'
      'pr.IS_PRINTED,'
      'pr.IS_RECEPTA_HOSPIT,'
      'pr.IS_REGISTRATION,'
      'pr.IS_REHABILITATION,'
      'pr.IS_RISK_GROUP,'
      'pr.IS_TELK,'
      'pr.IS_VSD,'
      'pr.PAY,'
      'pr.TO_BE_DISPANSERED,'
      'pr.procedure1_mkb || '#39'|'#39' || pr.procedure1_opis,'
      'pr.procedure2_mkb || '#39'|'#39' || pr.procedure2_opis,'
      'pr.procedure3_mkb || '#39'|'#39' ||pr.procedure2_opis,'
      'pr.procedure4_mkb || '#39'|'#39' || pr.procedure2_opis,'
      'pr.RECKNNO'
      ''
      'from pregled pr'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Transaction = traMain
    Left = 47
    Top = 496
  end
  object ibsqlPatNew_S: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      ''
      '  pa.BABY_NUMBER'
      ', pa.BIRTH_DATE'
      ', pa.DIE_DATE'
      ', pa.DIE_FROM'
      ', pa.DOSIENOMER'
      ', pa.DZI_NUMBER'
      ', pa.EGN'
      ', pa.EHIC_NO'
      ', pa.FNAME'
      ', pa.ID'
      ', pa.LAK_NUMBER'
      ', pa.LNAME'
      ', pa.NZIS_BEBE'
      ', pa.NZIS_PID'
      ', pa.RACE'
      ', pa.SNAME'
      ''
      '----------'
      ''
      ',pa.HEALTH_INSURANCE_NAME'
      ',pa.HEALTH_INSURANCE_NUMBER'
      ',pa.DATA_HEALTH_INSURANCE'
      ',pa.DATE_HEALTH_INSURANCE_CHECK'
      ',pa.TIME_HEALTH_INSURANCE_CHECK'
      ',pa.DATE_OTPISVANE'
      ',pa.DATE_ZAPISVANE'
      ',pa.DATEFROM'
      ',pa.DATEISSUE'
      ',pa.DATETO'
      ',pa.DATETO_TEXT'
      ',pa.GRAJD'
      ',pa.IS_NEBL_USL'
      ',pa.OSIGNO'
      ',pa.OSIGUREN'
      ',pa.PASS'
      ',pa.PREVIOUS_DOCTOR_ID'
      ',pa.TYPE_CERTIFICATE'
      ',pa.FUND_ID'
      ',pa.PAT_KIND'
      ',pa.RZOK'
      ',pa.RZOKR'
      ''
      ',BLOOD_TYPE'
      ',SEX_TYPE'
      ',NZIS_PID'
      ',EHRH_PATIENT'
      ',GDPR_PRINTED'
      ',KYRMA3MES'
      ',KYRMA6MES'
      ',PID_TYPE'
      ',RH'
      ',null as "Doctor_id"'
      ',coalesce(pa.NAS_MQSTO, pa.ulica, pa.jk)'
      ',pa.AP'
      ',pa.BL'
      ',pa.DTEL'
      ',pa.EMAIL'
      ',pa.ET'
      ',pa.JK'
      ',pa.NOMER'
      ',pa.PKUT'
      ',pa.ULICA'
      ',pa.VH'
      ''
      ''
      'from pacient pa')
    Transaction = traMain
    Left = 143
    Top = 496
  end
  object ibsqlMKBNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select mkb.code, mkb.name, mkb.note from icd10cm mkb')
    Transaction = traMain
    Left = 239
    Top = 496
  end
  object ibsqlMedNaprNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'MN.ATTACHED_DOCS,'
      'MN.DIAGNOSES,'
      'MN.ICD_CODE,'
      'MN.ICD_CODE2,'
      'MN.ICD_CODE2_ADD,'
      'MN.ICD_CODE3,'
      'MN.ICD_CODE3_ADD,'
      'MN.ICD_CODE_ADD,'
      'MN.ID,'
      'MN.ISSUE_DATE,'
      'MN.NRN,'
      'MN.NUMBER,'
      'MN.PREGLED_ID,'
      'MN.REASON,'
      'MN.SPECIALIST_AMB_LIST_INFO,'
      'MN.specialist_date,'
      'MN.SPECIALIST_ID,'
      'MN.SPECIALITY_ID,'
      'MN.IS_PRINTED,'
      'MN.EXAMED_BY_SPECIALIST,'
      'MN.NZIS_STATUS,'
      'MN.MED_NAPR_TYPE_ID,'
      'sp.specnziscode'
      'from blanka_med_napr mn'
      'inner join speciality sp on sp.id = MN.SPECIALITY_ID')
    Transaction = traMain
    Left = 335
    Top = 504
  end
  object ibsqlDoctorNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'EGN,'
      'FNAME,'
      'ID,'
      'LNAME,'
      'SNAME,'
      'UIN'
      ' from doctor ')
    Transaction = traMain
    Left = 447
    Top = 496
  end
  object ibsqlUnfavNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'ID,'
      'DOCTOR_ID_PRAC,'
      'YEAR_UNFAV,'
      'MONTH_UNFAV'
      'from unfav')
    Transaction = traMain
    Left = 527
    Top = 496
  end
  object ibsqlMDNNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      '    DATA,'
      '    ID,'
      '    NRN,'
      '    NUMBER,'
      ''
      ''
      '    PREGLED_ID,'
      '    ICD_CODE,'
      '    IS_LKK,'
      '    MED_DIAG_NAPR_TYPE_ID,'
      '    ICD_CODE_ADD,'
      '    IS_PRINTED,'
      '    OTHER_DOCTOR_ID,'
      '    TAKENFROMARENAL,'
      '    NZIS_STATUS'
      ''
      ' from blanka_mdn mdn')
    Transaction = traMain
    Left = 608
    Top = 504
  end
  object ibsqlExamAnalNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'ea.ANALYSIS_ID,'
      'ea.BLANKA_MDN_ID,'
      'ea.DATA,'
      'ea.EMDN_ID,'
      'ea.ID,'
      
        'coalesce (ea.NZIS_CODE_CL22, a.cl22, lpad(a.package, 2, 0) || '#39'.' +
        #39' || lpad(a.code, 2, 0)),'
      'ea.NZIS_DESCRIPTION_CL22,'
      'ea.PREGLED_ID,'
      'ea.RESULT'
      'from exam_analysis ea'
      'inner join analysis a on a.id = ea.ANALYSIS_ID')
    Transaction = traMain
    Left = 704
    Top = 496
  end
  object ibsqlPatNew_GP: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      ''
      '  pa.BABY_NUMBER'
      ', pa.BIRTH_DATE'
      ', pa.DIE_DATE'
      ', pa.DIE_FROM'
      ', pa.DOSIENOMER'
      ', pa.DZI_NUMBER  --5'
      ', pa.EGN'
      ', pa.EHIC_NO'
      ', pa.FNAME'
      ', pa.ID'
      ', pa.LAK_NUMBER --10'
      ', pa.LNAME'
      ', pa.NZIS_BEBE'
      ', pa.NZIS_PID'
      ', pa.RACE'
      ', pa.SNAME'
      ''
      '----------'
      ''
      ',pa.HEALTH_INSURANCE_NAME'
      ',pa.HEALTH_INSURANCE_NUMBER'
      ',pa.DATA_HEALTH_INSURANCE'
      ',pa.DATE_HEALTH_INSURANCE_CHECK'
      ',pa.TIME_HEALTH_INSURANCE_CHECK'
      ',pa.DATE_OTPISVANE'
      ',pa.DATE_ZAPISVANE'
      ',pa.DATEFROM'
      ',pa.DATEISSUE'
      ',pa.DATETO'
      ',pa.DATETO_TEXT'
      ',pa.GRAJD'
      ',pa.IS_NEBL_USL'
      ',pa.OSIGNO'
      ',pa.OSIGUREN'
      ',pa.PASS'
      ',pa.PREVIOUS_DOCTOR_ID'
      ',pa.TYPE_CERTIFICATE'
      ',pa.FUND_ID'
      ',pa.PAT_KIND'
      ',pa.RZOK'
      ',pa.RZOKR'
      ''
      ',pa.BLOOD_TYPE'
      ',pa.SEX_TYPE'
      ',pa.NZIS_PID'
      ',pa.EHRH_PATIENT'
      ',pa.GDPR_PRINTED'
      ',pa.KYRMA3MES'
      ',pa.KYRMA6MES'
      ',pa.PID_TYPE'
      ',pa.RH'
      ',pa.Doctor_ID'
      ',coalesce(pa.NAS_MQSTO, pa.ulica, pa.jk)'
      ',pa.AP'
      ',pa.BL'
      ',pa.DTEL'
      ',pa.EMAIL'
      ',pa.ET'
      ',pa.JK'
      ',pa.NOMER'
      ',pa.PKUT'
      ',pa.ULICA'
      ',pa.VH'
      ''
      'from pacient pa')
    Transaction = traMain
    Left = 151
    Top = 432
  end
  object ibsqlPracNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'practica.ADDRESS_ACT,'
      'practica.ADDRESS_DOGNZOK,'
      'practica.ADRES,'
      'practica.BANKA,'
      'practica.BANKOW_KOD,'
      'practica.BULSTAT,'
      'practica.COMPANYNAME,'
      'practica.CONTRACT_DATE,'
      'practica.CONTRACT_RZOK,'
      'practica.CONTRACT_TYPE,'
      'practica.DAN_NOMER,'
      'practica.EGN,'
      'practica.FNAME,'
      'practica.FULLNAME,'
      'practica.INVOICECOMPANY,'
      'practica.ISSUER_TYPE,'
      'practica.IS_SAMOOSIG,'
      'practica.KOD_RAJON,'
      'practica.KOD_RZOK,'
      'practica.LNAME,'
      'practica.LNCH,'
      'practica.NAME,'
      'practica.NAS_MQSTO,'
      'practica.NEBL_USL,'
      'practica.NOMER_LZ,'
      'practica.NOM_NAP,'
      'practica.NZOK_NOMER,'
      'practica.OBLAST,'
      'practica.OBSHTINA,'
      'practica.SELF_INSURED_DECLARATION,'
      'practica.SMETKA,'
      'practica.SNAME,'
      'practica.UPRAVITEL,'
      'practica.VIDFIRMA,'
      'practica.VID_IDENT,'
      'practica.VID_PRAKTIKA,'
      'ini.INI_VALUE'
      'from ini, practica'
      
        'WHERE (ini.INI_SECTION = '#39'Version'#39') AND (ini.INI_KEY = '#39'ProgramN' +
        'ame'#39');')
    Transaction = traMain
    Left = 791
    Top = 496
  end
  object ibsqlEBLNew: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      ''
      'ebl.AMB_JOURNAL_NUMBER,'
      'ebl.ASSISTED_PERSON_NAME,'
      'ebl.ASSISTED_PERSON_PID,'
      'ebl.CUSTOMIZE,'
      'ebl.DATA,'
      'ebl.DATEOFBIRTH,'
      'ebl.DAYS_FREE,'
      'ebl.DAYS_HOME,'
      'ebl.DAYS_HOSPITAL,'
      'ebl.DAYS_IN_WORDS,'
      'ebl.DAYS_SANATORIUM,'
      'ebl.EL_NUMBER,'
      'ebl.FORM_LETTER,'
      'ebl.FORM_NUMBER,'
      'ebl.IAVIAVANE_PREGLED_DATE,'
      'ebl.ID,'
      'ebl.IST_ZABOL_NO,'
      'ebl.IZDADEN_OT,'
      'ebl.LAK_NUMBER,'
      'ebl.LKK_TYPE,'
      'ebl.NERABOTOSP_ID,'
      'ebl.NOTES,'
      'ebl.NOTES_ID,'
      'ebl.NUMBER,'
      'ebl.NUMBER_ANUL,'
      'ebl.OTHER_PRACTICA_ID,'
      'ebl.PATIENT_EGN,'
      'ebl.PATIENT_LNCH,'
      'ebl.PREGLED_ID,'
      'ebl.REALATIONSHIP,'
      'ebl.REL_SHIP_CODE,'
      'ebl.RESHENIEDATE,'
      'ebl.RESHENIEDATE_TELK,'
      'ebl.RESHENIENO,'
      'ebl.RESHENIENO_TELK,'
      'ebl.SICK_LEAVE_END,'
      'ebl.SICK_LEAVE_START,'
      'ebl.TERMIN_DATE,'
      'ebl.TREATMENT_REGIMEN,'
      'ebl.PATIENT_CITY,'
      'ebl.PATIENT_ID,'
      'ebl.PATIENT_FULLNAME,'
      'ebl.PATIENT_FULL_ADDRESS,'
      'ebl.PATIENT_JK,'
      'ebl.PATIENT_STREET,'
      'ebl.PATIENT_STREETNUMBER,'
      'ebl.WORK_CITY,'
      'ebl.WORK_COMPANY,'
      'ebl.WORK_JK,'
      'ebl.WORK_POSITION,'
      'ebl.WORK_PROFESSION,'
      'ebl.WORK_STREET_NAME,'
      'ebl.WORK_STREET_NO,'
      'ebl.ASSISTED_PERSON_IS_EGN,'
      'ebl.EFFECTIVE,'
      'ebl.IS_CHECKED_NOI,'
      'ebl.IS_LKK,'
      'ebl.IS_PRIMARY,'
      'ebl.IS_PRINTED,'
      'ebl.IS_SENDED_NOI,'
      'ebl.PATIENT_IS_EGN,'
      'ebl.PATIENT_SEX_TYPE,'
      'ebl.DIAGNOSIS,'
      'ebl.DOCTOR1_UIN,'
      'ebl.DOCTOR2_UIN,'
      'ebl.DOCTOR3_UIN,'
      'ebl.DOCTORNAME1,'
      'ebl.DOCTORNAME2,'
      'ebl.DOCTORNAME3,'
      'ebl.DOCTOR_KOMISIA,'
      'ebl.ICD_CODE'
      ''
      'from exam_boln_list ebl'
      ''
      ''
      '')
    Transaction = traMain
    Left = 903
    Top = 24
  end
  object ibsqlPregNew_S: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select-- first 10000'
      'pr.AMB_LISTN,'
      'pr.ANAMN,'
      'pr.COPIED_FROM_NRN,'
      'pr.GS,'
      'pr.ID,'
      'pr.IZSL,'
      'pr.MEDTRANSKM,'
      'pr.NAPRAVLENIE_AMBL_NOMER,'
      'pr.NAPR_TYPE_ID,'
      'pr.NOMERBELEGKA,'
      'pr.NOMERKASHAPARAT,'
      'pr.NRD,'
      'pr.NRN,'
      'pr.NZIS_STATUS,'
      'pr.OBSHTAPR,'
      'pr.PATIENTOF_NEOTL,'
      'pr.PATIENTOF_NEOTLID,'
      'pr.PREVENTIVE_TYPE,'
      'pr.REH_FINISHED_AT,'
      'pr.START_DATE,'
      'pr.START_TIME,'
      'pr.SYST,'
      'pr.TALON_LKK,'
      'pr.TERAPY,'
      'pr.THREAD_IDS,'
      'pr.VISIT_ID,'
      'pr.VISIT_TYPE_ID,'
      'pr.VSD_TYPE,'
      ''
      'pr.PACIENT_ID,'
      'pr.MAIN_DIAG_MKB,'
      'pr.MAIN_DIAG_MKB_ADD,'
      'pr.pr_zab1_mkb,'
      'pr.pr_zab1_mkb_add,'
      'pr.pr_zab2_mkb,'
      'pr.pr_zab2_mkb_add,'
      'pr.pr_zab3_mkb,'
      'pr.pr_zab3_mkb_add,'
      'pr.pr_zab4_mkb,'
      'pr.pr_zab4_mkb_add,'
      ''
      'pr.AMB_PR,'
      'pr.DOM_PR,'
      'pr.doctor_id,'
      'pr.is_zamestvasht,'
      'pr.is_naet,'
      'pr.owner_doctor_id,'
      'pr.EXAM_BOLN_LIST_ID,'
      'pr.INCIDENTALLY,'
      'pr.IS_ANALYSIS,'
      'pr.IS_BABY_CARE,'
      'pr.IS_CONSULTATION,'
      'pr.IS_DISPANSERY,'
      'pr.IS_EMERGENCY,'
      'pr.IS_EPIKRIZA,'
      'pr.IS_EXPERTIZA,'
      'pr.IS_FORM_VALID,'
      'pr.IS_HOSPITALIZATION,'
      'pr.IS_MANIPULATION,'
      'pr.IS_MEDBELEJKA,'
      ''
      'pr.IS_NAPR_TELK,'
      'pr.IS_NEW,'
      'pr.IS_NOTIFICATION,'
      'pr.IS_NO_DELAY,'
      'pr.IS_OPERATION,'
      'pr.IS_PODVIZHNO_LZ,'
      'pr.IS_PREVENTIVE,'
      'pr.IS_PRINTED,'
      'pr.IS_RECEPTA_HOSPIT,'
      'pr.IS_REGISTRATION,'
      'pr.IS_REHABILITATION,'
      'pr.IS_RISK_GROUP,'
      'pr.IS_TELK,'
      'pr.IS_VSD,'
      'pr.PAY,'
      'pr.TO_BE_DISPANSERED,'
      'pr.procedure1_mkb || pr.procedure1_opis,'
      'pr.procedure2_mkb || pr.procedure2_opis,'
      'pr.procedure3_mkb || pr.procedure2_opis,'
      'pr.procedure4_mkb || pr.procedure2_opis,'
      'pr.RECKNNO,'
      'pr.simp_napr_n'
      ''
      'from pregled pr'
      '')
    Transaction = traMain
    Left = 39
    Top = 432
  end
  object ibsqlExamInun: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      '        BASE_ON,'
      '        BOOSTER,'
      '        CERTIFICATE_NAME,'
      '        DATA,'
      '        DOCTOR_NAME,'
      '        DOCTOR_UIN,'
      '        DOSE,'
      '        DOSE_NUMBER,'
      '        DOSE_QUANTITY,'
      '        EXPIRATION_DATE,'
      '        EXT_AUTHORITY,'
      '        EXT_COUNTRY,'
      '        EXT_LOT_NUMBER,'
      '        EXT_OCCURRENCE,'
      '        EXT_PREV_IMMUNIZATION,'
      '        EXT_SERIAL_NUMBER,'
      '        EXT_VACCINE_ATC,'
      '        EXT_VACCINE_INN,'
      '        EXT_VACCINE_NAME,'
      '        ID,'
      '        IMMUNIZATION_ID,'
      '        IMMUNIZATION_STATUS,'
      '        IS_SPECIAL_CASE,'
      '        LOT_NUMBER,'
      '        LRN,'
      '        NEXT_DOSE_DATE,'
      '        NOTE,'
      '        NRN_IMMUNIZATION,'
      '        NRN_PREV_IMMUNIZATION,'
      '        PERSON_STATUS_CHANGE_ON_DATE,'
      '        PERSON_STATUS_CHANGE_REASON,'
      '        PREGLED_ID,'
      '        PRIMARY_SOURCE,'
      '        QUALIFICATION,'
      '        REASON_TO_CANCEL_IMMUNIZATION,'
      '        RESULT,'
      '        ROUTE,'
      '        SERIAL_NUMBER,'
      '        SERIES,'
      '        SERIES_DOSES,'
      '        SITE,'
      '        SOCIAL_GROUP,'
      '        SUBJECT_STATUS,'
      '        UPDATED,'
      '        UVCI,'
      '        VACCINE_ID'
      'from exam_immunization'
      '        ')
    Transaction = traMain
    Left = 880
    Top = 480
  end
  object ibsqlProceduresGP: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      '        null as ARTICLE_147 ,'
      '       CODE, '
      '        EFFECTIVE,'
      '        null as FIZIO_GROUP,'
      '        HI_EQUIPMENT,'
      '        HI_REQUIREMENTS,'
      '        HI_SPECIALIZED,'
      '        ID,'
      '        IS_EXAM_TYPE,'
      '        IS_HOSPITAL,'
      '        KSMP,'
      '        NAME,'
      '        PACKAGE_ID,'
      '        PRICE,'
      '         CODE || '#39'|'#39' || name'
      ''
      '        from procedures')
    Transaction = traMain
    Left = 984
    Top = 488
  end
  object ibsqlProcedures_S: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      '        ARTICLE_147 ,'
      '        CODE,'
      '        EFFECTIVE,'
      '        FIZIO_GROUP,'
      '        HI_EQUIPMENT,'
      '        HI_REQUIREMENTS,'
      '        HI_SPECIALIZED,'
      '        ID,'
      '        IS_EXAM_TYPE,'
      '        IS_HOSPITAL,'
      '        KSMP,'
      '        NAME,'
      '        PACKAGE_ID,'
      '        PRICE'
      '        from procedures')
    Transaction = traMain
    Left = 1088
    Top = 488
  end
  object ibsqlKardProf: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select '
      'kp.BDDIASTOLNO43,'
      'kp.BDGIRTWAIST44,'
      'kp.BDHEIGHT39,'
      'kp.BDITM41,'
      'kp.BDSYSTOLNO42,'
      'kp.BDWEIGHT40,'
      'kp.CIGARETESCOUNT71,'
      'kp.FINDRISK,'
      'kp.ISSUE_DATE,'
      'kp.MDIGLUCOSE48,'
      'kp.MDIHDL50,'
      'kp.MDILDL45,'
      'kp.MDINONHDL73,'
      'kp.MDIPSA49,'
      'kp.MDITG47,'
      'kp.MDITH46,'
      'kp.NOMER,'
      'kp.PREGLED_ID,'
      'kp.SCORE,'
      ''
      'kp.ADENOMA61,'
      'kp.ANTIHIPERTENZIVNI67,'
      'kp.BENIGNMAMMARY19,'
      'kp.CELIACDISEASE25,'
      'kp.COLORECTALCARCINOMA21,'
      'kp.CROHN63,'
      'kp.DIABETESRELATIVES31,'
      'kp.DIABETESRELATIVESSECOND70,'
      'kp.DYNAMISMPSA28,'
      'kp.DYSLIPIDAEMIA11,'
      'kp.FRUITSVEGETABLES66,'
      'kp.HPVVAKSINA69,'
      'kp.ILLNESSIBS_MSB29,'
      'kp.IMMUNOSUPPRESSED15,'
      'kp.ISFULL,'
      'kp.COLITIS64,'
      'kp.IS_PRINTED,'
      'kp.MENARCHE07,'
      'kp.NEOCERVIX32,'
      'kp.NEOREKTOSIGMOIDE35,'
      'kp.POLYP62,'
      'kp.PREDIABETIC10,'
      'kp.PREGNANCY08,'
      'kp.PREGNANCYCHILDBIRTH68,'
      'kp.PROLONGEDHRT04,'
      'kp.PROSTATECARCINOMA38,'
      'kp.RELATIVESBREAST33,'
      'kp.SEDENTARYLIFE02,'
      'kp.TYPE1DIABETES65,'
      'kp.TYPE2DIABETES09,'
      'kp.WOMENCANCERS18'
      'from karta_profilaktika2017 kp')
    Transaction = traMain
    Left = 239
    Top = 440
  end
  object ibsqlDiag: TIBSQL
    Database = DBMain
    SQL.Strings = (
      
        'insert into DIAGNOSIS (ID, DOKUMENT_ID, DOKUMENT_TYPE, DIAGNOSIS' +
        '_CODE_CL011, DIAGNOSIS_ADDITIONALCODE_CL011,'
      
        '                       DIAGNOSIS_RANK, DIAGNOSIS_ONSETDATETIME, ' +
        'DIAGNOSIS_CL011POS, DIAGNOSIS_LOGICAL, DIAGNOSIS_MKBPOS)'
      
        'values (gen_id(gen_diag, 1), :DOKUMENT_ID, :DOKUMENT_TYPE, :DIAG' +
        'NOSIS_CODE_CL011, :DIAGNOSIS_ADDITIONALCODE_CL011,'
      
        '                       :DIAGNOSIS_RANK, :DIAGNOSIS_ONSETDATETIME' +
        ', :DIAGNOSIS_CL011POS, :DIAGNOSIS_LOGICAL, :DIAGNOSIS_MKBPOS);')
    Transaction = traMain
    Left = 959
    Top = 200
  end
  object ibscrpt1: TIBScript
    Database = DBMain
    Transaction = traMain
    Terminator = ';'
    Script.Strings = (
      'SET TERM ^ ;'
      ''
      'CREATE OR ALTER TRIGGER HISTORY_USERS_AU_HIST FOR HISTORY_USERS'
      'ACTIVE AFTER UPDATE POSITION 0'
      'AS'
      'begin'
      ' POST_EVENT '#39'Hist'#39'|| new.guid_adb;'
      'end'
      '^'
      ''
      'SET TERM ; ^'
      ''
      'SET TERM ^ ;'
      ''
      ''
      ''
      'CREATE OR ALTER TRIGGER HISTORY_AI0 FOR HISTORY'
      'ACTIVE AFTER INSERT POSITION 0'
      'AS'
      'begin'
      ' update history_users hu'
      '  set hu.comp_name = hu.comp_name;'
      'end'
      '^'
      ''
      'SET TERM ; ^')
    Left = 704
    Top = 112
  end
  object ibsqlMedNapr3A: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'VSD.ATTACHED_DOCS,'
      'VSD.ID,'
      'VSD.ISSUE_DATE,'
      'VSD.NRN,'
      'VSD.NUMBER,'
      'VSD.REASON,'
      'VSD.SPECIALITY_ID,'
      'VSD.VSD_CODE,'
      'VSD.DIAGNOSES,'
      'VSD.ICD_CODE,'
      'VSD.ICD_CODE2,'
      'VSD.ICD_CODE2_ADD,'
      'VSD.ICD_CODE3,'
      'VSD.ICD_CODE3_ADD,'
      'VSD.ICD_CODE_ADD,'
      'VSD.IS_BOLNICHNA,'
      'VSD.MED_NAPR_TYPE_ID,'
      'VSD.NZIS_STATUS,'
      'VSD.PREGLED_ID,'
      'sp.code,'
      'sp.specnziscode'
      ' from BLANKA_MED_NAPR_3A  vsd'
      ' inner join speciality sp on sp.id = vsd.speciality_id')
    Transaction = traMain
    Left = 1031
    Top = 424
  end
  object ibsqlIncMDN: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'ACCOUNT_ID,'
      'AMBJOURNALN,'
      'AMBJOURNALN_PAYED,'
      'AMBLISTN,'
      'AMB_NRN,'
      'ASSIGMENT_TIME,'
      'DATA,'
      'DATE_EXECUTION,'
      'DATE_PROBOVZEMANE,'
      'DESCRIPTION,'
      'EXECUTION_TIME,'
      'FUND_ID,'
      'ID,'
      'NOMERBELEGKA,'
      'NOMERKASHAPARAT,'
      'NRN,'
      'NUMBER,'
      'NZOK_NOMER,'
      'PACKAGE,'
      'PASS,'
      'SEND_MAIL_DATE,'
      'THREAD_IDS,'
      'TIME_PROBOVZEMANE,'
      'TOKEN_RESULT,'
      'VISIT_ID,'
      ''
      ''
      ''
      ''
      'ARENAL_ID,'
      'BLANKA_MDN_ID,'
      'DOCTOR_DEPUTY_UIN,'
      'DOCTOR_EGN,'
      'DOCTOR_FNAME,'
      'DOCTOR_LNAME,'
      'DOCTOR_REG_NUMBER,'
      'DOCTOR_SNAME,'
      'DOCTOR_SPECIALITY_ID,'
      'DOCTOR_UIN,'
      'FINANCING_SOURCE,'
      'ICD_CODE,'
      'ICD_CODE_ADD,'
      'INC_DOCTOR_ID,'
      'INTEGRATED_ORDER_ID,'
      'IS_BONUS,'
      'IS_FORM_VALID,'
      'IS_INSIDE,'
      'IS_LKK,'
      'IS_NAET,'
      'IS_NZOK,'
      'IS_PODVIZHNO_LZ,'
      'IS_REJECTED_BY_RZOK,'
      'IS_STACIONAR,'
      'IS_ZAMESTVASHT,'
      'MED_DIAG_NAPR_TYPE_ID,'
      'NZIS_STATUS,'
      'PACIENT_ID,'
      'PARTNER_ID,'
      'TARIFF_ID'
      ''
      ' from inc_mdn'
      '--where id = 32')
    Transaction = traMain
    Left = 320
    Top = 440
  end
  object ibsqlMedNaprHosp: TIBSQL
    Database = DBMain
    SQL.Strings = (
      '    select distinct'
      '    hosp.AMB_PROCEDURE,'
      '    hosp.CLINICAL_PATH,'
      '    hosp.DIRECT_DATE,'
      '    hosp.ID,'
      '    hosp.NOTES,'
      '    hosp.NRN,'
      '    hosp.NUMBER,'
      ''
      '    hosp.DIRECTED_BY,'
      '    hosp.DIRECT_DIAGNOSIS_1,'
      '    hosp.DIRECT_DIAGNOSIS_2,'
      '    hosp.DIRECT_MKB_1,'
      '    hosp.DIRECT_MKB_1_ADD,'
      '    hosp.DIRECT_MKB_2,'
      '    hosp.DIRECT_MKB_2_ADD,'
      '    hosp.GRAJDANSTVO,'
      '    hosp.HAS_NHIF_CONTRACT,'
      '    hosp.ICD_AREA,'
      '    hosp.IS_MZ,'
      '    hosp.IS_PLANNED,'
      '    hosp.IS_PRINTED,'
      '    hosp.IS_REJECTED,'
      '    hosp.IS_URGENT,'
      '    hosp.NZIS_STATUS,'
      '    hosp.PREGLED_ID,'
      '    clinP.code,'
      '    ambpr.code,'
      '    hosp.SEM_POLOJ'
      ''
      '     from hospitalization hosp'
      
        '     left join amb_procedures ambpr on ambpr.code = hosp.AMB_PRO' +
        'CEDURE'
      
        '     left join clinic_paths clinP on clinP.code = hosp.CLINICAL_' +
        'PATH')
    Transaction = traMain
    Left = 415
    Top = 432
  end
  object ibsqlMedNaprLKK: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'lkk.DATA,'
      'lkk.ID,'
      'lkk.NRN,'
      'lkk.NUMBER,'
      'lkk.ICD_CODE,'
      'lkk.ICD_CODE2,'
      'lkk.ICD_CODE2_ADD,'
      'lkk.ICD_CODE_ADD,'
      'lkk.ICD_CODE_OPIS,'
      'lkk.IS_PRINTED,'
      'lkk.LKK_TYPE_ID,'
      'lkk.NZIS_STATUS,'
      'lkk.PREGLED_ID'
      ''
      'from exam_lkk lkk')
    Transaction = traMain
    Left = 519
    Top = 432
  end
  object ibsqlIncMN: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'incMN.amb_listn,'
      'incMN.AMB_LIST_NRN,'
      'incMN.ID,'
      'incMN.ISSUE_DATE,'
      'incMN.ISSUE_TIME,'
      'incMN.NOMERBELEGKA,'
      'incMN.NOMERKASHAPARAT,'
      'incMN.NRN,'
      'incMN.NUMBER,'
      'incMN.REASON,'
      ''
      ''
      ''
      'incMN.ATTACHED_DOCS,'
      'incMN.CH_BOLNICHNA,'
      'incMN.DIAGNOSES,'
      'incMN.ICD_CODE,'
      'incMN.ICD_CODE2,'
      'incMN.ICD_CODE2_ADD,'
      'incMN.ICD_CODE3,'
      'incMN.ICD_CODE3_ADD,'
      'incMN.ICD_CODE_ADD,'
      'incMN.INC_DOCTOR_ID,'
      'incMN.IS_ZAMESTNIK,'
      'incMN.NAPR_TYPE_ID,'
      'incMN.NZIS_STATUS,'
      'incMN.PACIENT_ID,'
      'incMN.PAYMENT_ID,'
      'incMN.SPECIALITY_ID,'
      'incMN.SPECIALITY_ID_2,'
      'incMN.SPECIALITY_ID_3,'
      'incMN.SPECIALITY_ID_4,'
      'incMN.SPECIALITY_ID_5,'
      'incMN.UIN_ZAMESTNIK,'
      'incMN.VISIT_TYPE_ID,'
      'incMN.VSD1,'
      'incMN.VSD2,'
      'sp.specnziscode,'
      'sp2.specnziscode,'
      'sp3.specnziscode,'
      'sp4.specnziscode,'
      'sp5.specnziscode'
      ''
      'from inc_napr incMN'
      'left join speciality sp on sp.id = incMN.SPECIALITY_ID'
      'left join speciality sp2 on sp.id = incMN.SPECIALITY_ID_2'
      'left join speciality sp3 on sp.id = incMN.SPECIALITY_ID_3'
      'left join speciality sp4 on sp.id = incMN.SPECIALITY_ID_4'
      'left join speciality sp5 on sp.id = incMN.SPECIALITY_ID_5')
    Transaction = traMain
    Left = 623
    Top = 432
  end
  object ibsqlOtherDoctor: TIBSQL
    Database = DBMain
    SQL.Strings = (
      'select'
      'IncDoc.ID,'
      'IncDoc.FNAME,'
      'IncDoc.SNAME,'
      'IncDoc.LNAME,'
      'IncDoc.UIN,'
      'sp.specnziscode,'
      'IncDoc.RZOK,'
      'IncDoc.RZOKR,'
      'IncDoc.REG_NUMBER'
      'from inc_doctor IncDoc'
      'inner join speciality sp on sp.id = incDoc.speciality_id')
    Transaction = traMain
    Left = 695
    Top = 432
  end
end
