unit Aspects.Types;

interface
uses
  System.Generics.Collections, system.Classes; // VirtualTrees,
type
  PTime = ^Double;
  Blob = TStream;

  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  {$Z2}
  TEditTextNotify =  procedure (Sender:TObject; AValue:String) of object;

  TAsectTypeKind = (actNone, actAnsiString, actString,actAnsiString_L, actString_L, actInteger,
                    actTDate, actTime, actDouble, actWord, actBool, actLogical, actCardinal,
                    actINT64, actTIMESTAMP);

  TServerResponse = (srNone, srWhoAreYou, srCmdSizes, srCmdUpload, srYouAre);
  TAspectRole = (arNone, arNomenNzis, arDoctorOPL, arNomenNzisUpload);

  TCollectionsType = (ctAspect, ctConnection, ctIncMdnAnal, ctNewTable,
                      ctCommands, ctClients, ctPacket, ctPacketPacket,
                      ctFuncPacket, ctTreeLinkPacket, ctTreeLink, ctPregled, ctPregledNew,
                      ctPatient, ctTestGoro,
                      ctCL132, ctPR001, ctCL050, ctCL134, ctCL022, ctCL038, ctPatientNew,
                      ctDiagnosis, ctMDN, ctRole, ctPatientNZOK, ctDoctor, ctUnfav, ctMkb,
                      ctUnfavDel,
                      ctEventsManyTimes, ctAnalsNew, ctCL024, ctNomenNzis, ctAspPerformers,
                      ctPregeledDel, ctOblast, ctObshtina, ctNasMesto, ctPractica, ctExam_boln_list,
                      ctLink, ctDiagnosisDel, ctCL142, ctCL088, ctExamAnalysis, ctExamImmunization, ctProcedures,
                      ctDiagnosticReport, ctCL139, ctKARTA_PROFILAKTIKA2017, ctBLANKA_MED_NAPR,
                      ctNZIS_PLANNED_TYPE, ctNZIS_QUESTIONNAIRE_RESPONSE, ctNZIS_QUESTIONNAIRE_ANSWER,
                      ctNZIS_ANSWER_VALUE, ctNZIS_RESULT_DIAGNOSTIC_REPORT, ctNZIS_DIAGNOSTIC_REPORT,
                      ctCL144, ctCL037, ctCL006, ctNzisToken, ctCertificates );

  TOperationType = (toInsert, toUpdate, toInsertBefore, toInsertAfter, toAddChildFirst, toAddChildLast, toDeleteNode, toChange);  // 2, 3, 4, 5 са за линк-а

  TConditionType = (cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
                    cotIsNull, cotAny, cotContain, cotNotContain, cotStarting, cotEnding,
                    cotNotStarting, cotNotEnding, cotNotIsNull, cotNotSmallerEqual, cotNotBiggerEqual,
                    cotNotSmaller, cotNotBigger, cotSens);

  TDokumentSignType = (dtAmbListNzis, dtPatientDeklarator, dtMDNNzis);

  TNzisPregledType = (ptAMB=1, ptEMER=2, ptFLD=3, ptHH=4, ptIMP=5, ptOBSENC=6, ptPRENC=7, ptSS=8, ptVR=9);
  TNzisPregledPorpuse = (ppConsultation =1, ppGeneralPrevention =2, ppChildrensHealth =3, ppMaternalHealth =4,
                        ppPreventionAdults =5, ppPreventionRiskFactors =6, ppDispensary =7, ppHighlySpecialized =8,
                        ppPrescriptionHospitalized =9, ppExpertise =10, ppAtRequestExpertise =11, ppScreening =12);


  TNZISFinancingSource = (fsMZ=1, fsNHIF=2, fsFund=3, fsPatient=4, fsBudget=5, fsNOI=6, fsBEZ=7);
  TNZISidentifierType = (itbEGN=1, itbLNZ=2, itbSSN=3, itbPASS=4, itbOther=5, itbNBN=6);
  TNzisGender = (gbMale=1, gbFemale=2, gbOther=3, gbUnknown=4);
  TSourceAnsw = (saNone, saPatient, saOther, saDoktor, saNotApp, saNotAnsw);


  TConditionSet = set of TConditionType;
  TCondition = record
    CndType: TConditionType;

  end;



  TActionClient = (acNone, acEmptyClient, acRegClient);
  TDirectionFinder = (dfNone, dfForward, dfBackward);

  TVtrVid = (vvNone, vvOrders, vvAspects, vvOPL, vvPrimaryMedDoc, vvSupto,
             vvOrderSuptoOPL, vvSuptoCash, vvCash, vvClients,
             vvRgClients,
             vvNotRgClients,
             vvPacketFunctRoot,
             vvPacket, vvPacketTemp, vvPacketIndex,
             vvFunctionaly,
             vvTables,
             vvPatientRoot,
             vvPatient,
             vvPregled,
             vvNomenNzis,
             vvCl132,
             vvPR001,
             vvCl134,
             vvDiag,
             vvMDN,
             vvPregledRoot,
             vvRole,
             vvMedNapr,
             vvDoctor,
             vvNzisBiznes,
             vvAnalPackage,
             vvAnalRoot,
             vvAnal,
             vvPerformerRoot,
             vvPerformer,
             vvCMDRoot,
             vvCMD,
             vvMKB,
             vvEvnt,
             vvUnfav,
             vvOptionRoot,
             vvOptionDB,
             vvOptionGrids,
             vvOptionGridSearch,
             vvCloning,
             vvDeput,
             vvEbl,
             vvLink,
             vvDoctorRoot,
             vvCert,
             vvCL142,
             vvCL088,
             vvExamAnal,
             vvEvntList,
             vvExamImun,
             vvProcedures,
             vvNZIS_PLANNED_TYPE,
             vvNZIS_QUESTIONNAIRE_RESPONSE,
             vvNZIS_DIAGNOSTIC_REPORT,
             vvNZIS_QUESTIONNAIRE_ANSWER,
             vvNZIS_ANSWER_VALUE,
             vvNZIS_RESULT_DIAGNOSTIC_REPORT,
             vvCL144,
             vvNomenNzisUpdate,
             vvCL024,
             vvCL139,
             vvCL038,
             vvCL022,
             vvProfCard,
             vvRootDeput,
             vvPatientRevision);



             //vvAnalTest=1000, vvTableTest=2000);


  //TCommandVid = (cmdInsert, cmdUpdate, cmdDelete);

  TCmdItem = class(TObject)

      AdbItem: TObject;
      OpType: TOperationType;
      collType: TCollectionsType;
    end;

  PAspRec = ^TAspRec;
  TAspRec = record
    index: integer;
    vid: TVtrVid;
    DataPos: Cardinal;
  end;

  PAspRecLink = ^TAspRecLink;
  TAspRecLink = record
    DataPos: cardinal;
    vid: TVtrVid;
  end;

  //PVrtNodeWithData = ^TVrtNodeWithData;
//  TVrtNodeWithData = record
//    Node: TVirtualNode;
//    Data: TAspRecLink;
//  end;

  TCommandsFill = record
    CommandType: Byte;
    DataPos: Cardinal;
    len: Word;
  end;

  TCommandType = (cmdInsert, cmdUpdate);
  TArrWord = array of Word;
  TArrInt = array of Integer;

  TAspectsCommands = record
    ver: Byte;
    CommandType: TCommandType;
  end;

  TCmd = record
    cmdType: Byte;
    cmdLenData: Word;
    cmdPosData: cardinal;
    cmdData: Pointer;
  end;

  TValueEditorsType = (
    vetNone,
    vetString,
    vetPickString,
    vetNumber,
    vetPickNumber,
    vetMemo,
    vetDate,
    vetCheck
  );


  TTablesTypeHip = (
                ACCOUNT,
                ADV_CAMPAIGN,
                AGEGROUPS,
                AGE_MEDICINE,
                ALKOHOL,
                ALLERGIES,
                ALLERGY,
                ALLERGY_TYPES,
                AMB_PROCEDURES,
                ANALYSIS,
                ANTROPO,
                ANTROPOMETRIQ_F,
                ANTROPOMETRIQ_M,
                ANUL_BOLN_LIST,
                ARENAL_CARD,
                ARENAL_IZDATEL,
                ARENAL_PROVIDER,
                ARENAL_RESULT,
                ASSIGNMENTS,
                ATTACHMENTS,
                BANNERS,
                BLANKAUDOSTOVERENIE,
                BLANKA_DEATH,
                BLANKA_INQUIRY,
                BLANKA_MDN,
                BLANKA_MED_NAPR,
                BLANKA_MED_NAPR_3A,
                BLANKA_MED_NAPR_8,
                BLANKA_MED_NAPR_DISP_NABL,
                BLANKA_MED_NAPR_ISK,
                BLANKA_NAPR_TELK,
                BLANKA_NRV,
                BLANKA_OBRAZNO_IZSLEDVANE,
                BREMENNOST,
                BREMENNOST_CONSULTATION,
                BREMENNOST_CONSULTATION_GROUPS,
                BREMENNOST_EXAMINE_GROUPS,
                BREMENNOST_MDI_GROUPS,
                BREMENNOST_NECESSARY_MDI,
                BREMENNOST_NECESSARY_PREGLED,
                CAMPAIGN_MEDICINES,
                CAMPAIGN_STATISTICS,
                CERTIFICATES,
                CERTIFICATE_OF_MARRIAGE,
                CHARGES,
                CHARGES_CATEGORY,
                CHARGES_TARIFF,
                CHILDREN_HEALTH_REGISTER,
                CHILDREN_NECESSARY_IMUN,
                CHILDREN_NECESSARY_MDD,
                CHILDREN_NECESSARY_MDD_GROUPS,
                CHILDREN_NECESSARY_PREGLED,
                CHILDREN_NECESSARY_PREGLED_GR,
                CHOICE_MAKER,
                CIGARI,
                CITONAMAZKA,
                CLINICAL_PROCEDURES,
                CLINIC_PATHS,
                CLINIC_PATHS_NUMENKLATURA,
                CONNECTIONS,
                CONSULTATION_ANALYSIS,
                CONTRACTOR,
                COUNTRY_CODES,
                DATE_TO_NOI,
                DEPUTIZING,
                DIFFERENTIAL_DIAGNOSE,
                DISPANSERIZACIQ,
                DISP_ANALYSIS,
                DISP_CONSULT,
                DISP_INCOMPATIBLE_ICDS,
                DISP_NAREDBA,
                DISP_NOMENKLATURA,
                DISP_OTCHET,
                DISP_UNREGISTER_REASON,
                DOCTOR,
                DOCUMENTS,
                DOCUMENT_CALIBRATION,
                DOHOD,
                DRIVERS_HEALTH_CARD,
                DRIVER_HEALTH_CERTIFICATE,
                DRUGS,
                EBL_NOTES,
                EDS,
                EKATTE,
                ERB,
                ERB_DIAGNOSES,
                ETAPNA_EPIKRIZA,
                EXAM_ANALYSIS,
                EXAM_BOLN_LIST,
                EXAM_IMMUNIZATION,
                EXAM_LKK,
                EXAM_LKK_DOCTOR,
                EXAM_MANIPULATION,
                EXEMPT_FROM_CHARGE,
                EXEMPT_FROM_CHARGE_ICD,
                EXEMPT_FROM_CHARGE_REASON,
                FACTURA_ROWS,
                FAMILY_HISTORY,
                FAMILY_HISTORY_CONDITIONS,
                FAST_NOTIFY,
                FREE_MEDICINE,
                FREE_RECIPE,
                GDPR_NOMENKLATURA,
                GOOD,
                GRAFIK,
                GREEN_RECIPE,
                GROUP_LIST,
                GROUP_RIGHTS,
                HEALTH_CERTIFICATE,
                HEALTH_CERTIFICATE_ITEMS,
                HERALD,
                HERALD_USERS,
                HIPLOG,
                HOSPITALIZATION,
                ICD10CM,
                ICD10_AREA,
                ICD10_SUBAREA,
                ICD9CM,
                ICD9_AREA,
                ICD9_SUBAREA,
                ICD_MEDICINE,
                ICD_SPEC,
                IMMUNIZATION,
                IMMUNIZATION_DOSES_MAP,
                IMUN_CALENDAR,
                IMUN_DECREE,
                INI,
                INVOICE,
                INVOICE_DETAILS,
                IST_ZABOL,
                KARTA_PROFILAKTIKA2017,
                LEKARSTVA,
                LEKFORMS,
                LEKROUTE,
                LIC_HIP,
                LOCK_PREGLED,
                MANIPULATION,
                MAPER_CL_PATH2016,
                MEDICINE,
                MEDICINE_MEASURE_UNITS,
                MED_BELEJKA,
                MED_RABOTA,
                NERABOTOSP,
                NOMDOSES,
                NOMENS,
                NRV_APPLIED_VACCINES,
                NRV_OTHER_APPLIED_VACCINES,
                NRV_OTHER_PREVIOUS_DOSE,
                NRV_PREVIOUS_DOSE,
                NUMBER_EBL,
                NUMERATION,
                NUMERATION_CLASS,
                NUMERATION_COUNTER,
                NZIS_CL022,
                NZIS_CL024,
                NZIS_MDN,
                NZIS_RECRESULTS,
                NZIS_RESULT,
                NZIS_TOKENS,
                OBEKTI,
                OSIG_INFO,
                OTHER_PRACTICA,
                PACIENT,
                PATTERNS,
                PAYMENTS,
                PIS_EL_INVOICE,
                PIS_EL_INV_SENDED,
                PIS_MONTH_NOTIF,
                PIS_MONTH_NOTIF_NEW,
                PRACTICA,
                PRAKTIKA,
                PREFERED_CLINIC_PATHS,
                PREFERRED_DRUGS,
                PREFERRED_FREE_MEDICINE,
                PREFERRED_ICD10CM,
                PREFERRED_ICD9CM,
                PREFERRED_LEKARSTVA,
                PREFERRED_MEDICINE,
                PREGLED,
                PREVIOUS_DOCTOR,
                PRINTABLE_DECLARATIONS,
                PROCEDURES,
                PROCEDURE_PACKAGES,
                PROF_ADULTS_MDI,
                PROF_CARD,
                PROF_CARD_ADULTS,
                PROF_DIAGNOSES,
                RABMESTA,
                RECIPEROWS,
                REC_KNIJKA_VET,
                REC_KNIJKA_WAR_VIKT,
                REGISTER_ADMIN,
                REGISTER_ISKANE,
                REGISTER_PROBLEMS,
                REGISTER_USER,
                REGISTRATION_FOR_EINVOICE,
                REG_KARTA_PROF,
                REMIND,
                RESULT_NOI_FROM_FILE,
                RIGHTS_LIST,
                RISKGROUP,
                RISKGROUP_TYPES,
                RODITELI,
                RODIT_HISTORY,
                ROD_WRYZKA,
                RZOK_TABLE,
                SEM_POLOJ,
                SENDED_XML_NOI,
                SHKAF,
                SIGN_DOCUMENT,
                SIMPDISP,
                SLUJ_BELEJKA,
                SOC_POLOJ,
                SPECIALIST,
                SPECIALITY,
                SPEC_CONSULTATION,
                SPEC_PACKAGE,
                STDRECEPT,
                TARIFF,
                TAXEXEMPTION,
                UNFAV,
                UNITS,
                UPDATER_MEDICINE,
                VACCINE,
                VACCINE_IMMUNIZATIONS_MAP,
                VACCINE_LOTS,
                VACCINE_REACTIONS,
                VISIT,
                WAREHOUSE_IMMUNIZATION,
                WHITERECEPT,
                WORKINTERVAL,
                WORKPLAN,
                WORKPLAN_TYPE,
                YELLOW_RECIPE,
                eGFR,
                Asp_Diag,
                Asp_PL_NZOK,
                Asp_EventManyTimes,
                NZIS_PLANNED_TYPE,
                NZIS_QUESTIONNAIRE_RESPONSE,
                NZIS_QUESTIONNAIRE_ANSWER,
                NZIS_ANSWER_VALUE,
                NZIS_DIAGNOSTIC_REPORT,
                NZIS_RESULT_DIAGNOSTIC_REPORT,
                NzisToken
          );
   TPlanedStatus = (psNew, psInNzis, psMain, psNzisPending, psNzisPartiallyCompleted, psNzisCompleted);
   TPlanedStatusSet = set of TPlanedStatus;


   const

    LenData = 64;
    lenNode = 52;

    NzisPregNotPreg = '|A4|C22|C32|C42|C52|C62|';
    RL090 = '|A1|A30|A31|A32|A33|A34|A35|A36|A37|A38|A39|C21|C23|C31|C33|C41|C43|C51|C53|C61|C63|';
    NzisConsult = '|S1|S3|B12|A30|A31|A32|A33|A34|A35|A36|A37|A38|A39|A4|';




implementation

  
end.



