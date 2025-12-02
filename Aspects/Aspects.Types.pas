unit Aspects.Types;

interface
uses
  System.Generics.Collections, system.Classes, System.SysUtils;
type
  PTime = ^Double;
  Blob = TStream;

  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  {$Z2}
  TCheckBoxState = (cbUnchecked, cbChecked, cbGrayed);
  TSortColumn = record
    PropIndex: Word;
    SortAsc: Boolean;
  end;
  TSortColumns = TArray<TSortColumn>;


  TSortField = TSortColumn;
  TSortFields = TList<TSortField>;


  TColumnType = (ctAnsi, ctInt, ctFloat, ctBool);

  TEditTextNotify =  procedure (Sender:TObject; AValue:String) of object;

  TAspectTypeKind = (actNone, actAnsiString, actString,actAnsiString_L, actString_L, actInteger,
                    actTDate, actTime, actDouble, actWord, actBool, actLogical, actCardinal,
                    actINT64, actTIMESTAMP, actTTime, actTArrInt);

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
                      ctCL144, ctCL037, ctCL006, ctNzisToken, ctCertificates, ctNzisReqResp, ctBLANKA_MED_NAPR_3A,
                      ctINC_MDN, ctAnalResult, ctHOSPITALIZATION, ctEXAM_LKK, ctINC_NAPR, ctOtherDoctor,
                      ctAddres, ctDEPUTIZING, ctAspectDel, ctExam_boln_listDel, ctExamAnalysisDel, ctExamImmunizationDel,
                      ctProceduresDel, ctKARTA_PROFILAKTIKA2017Del, ctBLANKA_MED_NAPRDel,
                      ctBLANKA_MED_NAPR_3ADel, ctHOSPITALIZATIONDel, ctEXAM_LKKDel,
                      ctINC_MDNDel, ctINC_NAPRDel, ctNZIS_PLANNED_TYPEDel, ctNZIS_QUESTIONNAIRE_RESPONSEDel,
                      ctNZIS_QUESTIONNAIRE_ANSWERDel, ctNZIS_ANSWER_VALUEDel, ctMkbDel, ctOtherDoctorDel,
                      ctCL142Del, ctPregledNewDel, ctCL006Del, ctCL022Del, ctCL024Del, ctNomenNzisDel,
                      ctCL011, ctCL011Del, ctCL009, ctCL009Del, ctCL006Old);

  TOperationType = (toInsert, toUpdate, toInsertBefore, toInsertAfter, toAddChildFirst, toAddChildLast, toDeleteNode, toChange);  // 2, 3, 4, 5 са за линк-а

  TConditionType = (
      cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
      cotIsNull, cotAny, cotContain, cotNotContain, cotStarting, cotEnding,
      cotNotStarting, cotNotEnding, cotNotIsNull, cotNotSmallerEqual,
      cotNotBiggerEqual, cotNotSmaller, cotNotBigger, cotSens,
      cotIn,          // нов
      cotNotIn,       // нов
      cotBetween      // нов
  );

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
  TConditionTypeSet = set of TConditionType;






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
             vvPatientNewRoot,
             vvPatient,
             vvPregledNew,
             vvNomenNzis,
             vvCl132,
             vvPR001,
             vvCl134,
             vvDiag,
             vvMDN,
             vvPregledNewRoot,
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
             vvPatientRevision,
             vvRootOptions,
             vvOptionSearchGrid,
             vvFieldSearchGridOption,
             vvOptionSearchCot,
             vvMKBGroup,
             vvMKBSubGroup,
             vvNomenMkb,
             vvPractica,
             vvKARTA_PROFILAKTIKA2017,
             vvMKBAdd,
             vvNzisMessages,
             vvRecepta,
             vvHosp,
             vvObshti,
             vvMedNapr3A,
             vvIncMdn,
             vvMedNaprHosp,
             vvMedNaprLkk,
             vvIncMN,
             vvOtherDoctor,
             vvRootNasMesta,
             vvOblast,
             vvObshtina,
             vvNasMesto,
             vvAddres,
             vvRootdoctor,
             vvRootDoctorPrac,
             vvRootDoctorSender,
             vvRootDoctorConsult,
             vvRootDoctorColege,
             vvRootFilter,
             vvFieldFilter,// поле
             vvOperator,
             vvCondition,          // конкретно условие върху поле
             vvFieldOrGroup,       // група OR (за поле)
             vvObjectFilter,       // обект възел (пациент, преглед…)
             vvObjectOrGroup,      // група OR на обекти
             vvObjectGroup,
             vvFilterItem,
             vvPracticaRoot,
             vvOtherDoctorRoot,
             vvUnfavRoot,
             vvPatientNZOKRoot,
             vvMDNRoot,
             vvDiagnosisRoot,
             vvExam_boln_listRoot,
             vvExamAnalysisRoot,
             vvExamImmunizationRoot,
             vvProceduresRoot,
             vvKARTA_PROFILAKTIKA2017Root,
             vvBLANKA_MED_NAPRRoot,
             vvBLANKA_MED_NAPR_3ARoot,
             vvHOSPITALIZATIONRoot,
             vvEXAM_LKKRoot,
             vvINC_MDNRoot,
             vvINC_NAPRRoot,
             vvNZIS_PLANNED_TYPERoot,
             vvNZIS_QUESTIONNAIRE_RESPONSERoot,
             vvNZIS_QUESTIONNAIRE_ANSWERRoot,
             vvNZIS_ANSWER_VALUERoot,
             vvMkbRoot,
             vvCL142Root,
             vvCL006Root,
             vvCL022Root,
             vvCL024Root,
             vvNomenNzisRoot,
             vvCL011Root,
             vvCL011,
             vvCL009,
             vvCL009Root,
             vvCL006
             );



             //vvAnalTest=1000, vvTableTest=2000);


  //TCommandVid = (cmdInsert, cmdUpdate, cmdDelete);

  TCmdItem = class(TObject)

      AdbItem: TObject;
      OpType: TOperationType;
      collType: TCollectionsType;
      datapos: Cardinal;
    end;

  PAspRec = ^TAspRec;
  TAspRec = record
    index: integer;
    vid: TVtrVid;
    DataPos: Cardinal;
  end;

  PAspRecFilter = ^TAspRecFilter;
  TAspRecFilter = record
    index: integer; // остава си така
    vid: TVtrVid; // остава си така
    CollType: TCollectionsType;// за типа на колекцията
    reserved: Word; // само за изравняване
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
                NzisToken,
                INC_MDN,
                INC_NAPR,
                Asp_Addres,
                Asp_OtherDoctor
          );
   TPlanedStatus = (psNew, psInNzis, psMain, psNzisPending, psNzisPartiallyCompleted, psNzisCompleted);
   TPlanedStatusSet = set of TPlanedStatus;
   Function UserDate: Tdate;

   const

    LenData = 64;
    lenNode = 52;
    FNV_OFFSET: UInt64 = $CBF29CE484222325;
    FNV_PRIME : UInt64 = $100000001B3;
    IsFilterNode = [vvFilterItem, vvObjectGroup, vvFieldFilter, vvOperator, vvRootFilter, vvFieldOrGroup];



    NzisPregNotPreg = '|A4|C22|C32|C42|C5|C52|C62|';
    RL090 = '|A1|A30|A31|A32|A33|A34|A35|A36|A37|A38|A39|C21|C23|C31|C33|C41|C43|C51|C53|C61|C63|';
    NzisConsult = '|S1|S3|B12|A30|A31|A32|A33|A34|A35|A36|A37|A38|A39|A4|';
    RL090Prev = '|C51|';
  const
  CRC32_TABLE: array[0..255] of Cardinal = (
    $00000000,$77073096,$EE0E612C,$990951BA,$076DC419,$706AF48F,$E963A535,$9E6495A3,
    $0EDB8832,$79DCB8A4,$E0D5E91E,$97D2D988,$09B64C2B,$7EB17CBD,$E7B82D07,$90BF1D91,
    $1DB71064,$6AB020F2,$F3B97148,$84BE41DE,$1ADAD47D,$6DDDE4EB,$F4D4B551,$83D385C7,
    $136C9856,$646BA8C0,$FD62F97A,$8A65C9EC,$14015C4F,$63066CD9,$FA0F3D63,$8D080DF5,
    $3B6E20C8,$4C69105E,$D56041E4,$A2677172,$3C03E4D1,$4B04D447,$D20D85FD,$A50AB56B,
    $35B5A8FA,$42B2986C,$DBBBC9D6,$ACBCF940,$32D86CE3,$45DF5C75,$DCD60DCF,$ABD13D59,
    $26D930AC,$51DE003A,$C8D75180,$BFD06116,$21B4F4B5,$56B3C423,$CFBA9599,$B8BDA50F,
    $2802B89E,$5F058808,$C60CD9B2,$B10BE924,$2F6F7C87,$58684C11,$C1611DAB,$B6662D3D,
    $76DC4190,$01DB7106,$98D220BC,$EFD5102A,$71B18589,$06B6B51F,$9FBFE4A5,$E8B8D433,
    $7807C9A2,$0F00F934,$9609A88E,$E10E9818,$7F6A0DBB,$086D3D2D,$91646C97,$E6635C01,
    $6B6B51F4,$1C6C6162,$856530D8,$F262004E,$6C0695ED,$1B01A57B,$8208F4C1,$F50FC457,
    $65B0D9C6,$12B7E950,$8BBEB8EA,$FCB9887C,$62DD1DDF,$15DA2D49,$8CD37CF3,$FBD44C65,
    $4DB26158,$3AB551CE,$A3BC0074,$D4BB30E2,$4ADFA541,$3DD895D7,$A4D1C46D,$D3D6F4FB,
    $4369E96A,$346ED9FC,$AD678846,$DA60B8D0,$44042D73,$33031DE5,$AA0A4C5F,$DD0D7CC9,
    $5005713C,$270241AA,$BE0B1010,$C90C2086,$5768B525,$206F85B3,$B966D409,$CE61E49F,
    $5EDEF90E,$29D9C998,$B0D09822,$C7D7A8B4,$59B33D17,$2EB40D81,$B7BD5C3B,$C0BA6CAD,
    $EDB88320,$9ABFB3B6,$03B6E20C,$74B1D29A,$EAD54739,$9DD277AF,$04DB2615,$73DC1683,
    $E3630B12,$94643B84,$0D6D6A2E,$7A6A5AA8,$E40ECF0B,$9309FF9D,$0A00AE27,$7D079EB1,
    $F00F9344,$8708A3D2,$1E01F268,$6906C2FE,$F762575D,$806567CB,$196C3671,$6E6B06E7,
    $FED41B76,$89D32BE0,$10DA7A5A,$67DD4ACC,$F9B9DF6F,$8EBEEFF9,$17B7BE43,$60B08ED5,
    $D6D6A3E8,$A1D1937E,$38D8C2C4,$4FDFF252,$D1BB67F1,$A6BC5767,$3FB506DD,$48B2364B,
    $D80D2BDA,$AF0A1B4C,$36034AF6,$41047A60,$DF60EFC3,$A867DF55,$316E8EEF,$4669BE79,
    $CB61B38C,$BC66831A,$256FD2A0,$5268E236,$CC0C7795,$BB0B4703,$220216B9,$5505262F,
    $C5BA3BBE,$B2BD0B28,$2BB45A92,$5CB36A04,$C2D7FFA7,$B5D0CF31,$2CD99E8B,$5BDEAE1D,
    $9B64C2B0,$EC63F226,$756AA39C,$026D930A,$9C0906A9,$EB0E363F,$72076785,$05005713,
    $95BF4A82,$E2B87A14,$7BB12BAE,$0CB61B38,$92D28E9B,$E5D5BE0D,$7CDCEFB7,$0BDBDF21,
    $86D3D2D4,$F1D4E242,$68DDB3F8,$1FDA836E,$81BE16CD,$F6B9265B,$6FB077E1,$18B74777,
    $88085AE6,$FF0F6A70,$66063BCA,$11010B5C,$8F659EFF,$F862AE69,$616BFFD3,$166CCF45,
    $A00AE278,$D70DD2EE,$4E048354,$3903B3C2,$A7672661,$D06016F7,$4969474D,$3E6E77DB,
    $AED16A4A,$D9D65ADC,$40DF0B66,$37D83BF0,$A9BCAE53,$DEBB9EC5,$47B2CF7F,$30B5FFE9,
    $BDBDF21C,$CABAC28A,$53B39330,$24B4A3A6,$BAD03605,$CDD70693,$54DE5729,$23D967BF,
    $B3667A2E,$C4614AB8,$5D681B02,$2A6F2B94,$B40BBE37,$C30C8EA1,$5A05DF1B,$2D02EF8D
  );

  const
  OperatorRules: array[TAspectTypeKind] of TConditionTypeSet = (
    // actNone
    [],

    // actAnsiString
    [cotEqual, cotNotEqual, cotContain, cotNotContain, cotStarting, cotEnding,
     cotNotStarting, cotNotEnding, cotIn, cotNotIn, cotIsNull, cotNotIsNull],

    // actString
    [cotEqual, cotNotEqual, cotContain, cotNotContain, cotStarting, cotEnding,
     cotNotStarting, cotNotEnding, cotIn, cotNotIn, cotIsNull, cotNotIsNull],

    // actAnsiString_L (long text)
    [cotContain, cotNotContain, cotStarting, cotEnding, cotNotStarting,
     cotNotEnding, cotIsNull, cotNotIsNull],

    // actString_L (long text)
    [cotContain, cotNotContain, cotStarting, cotEnding, cotNotStarting,
     cotNotEnding, cotIsNull, cotNotIsNull],

    // actInteger
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIn, cotNotIn, cotIsNull, cotNotIsNull],

    // actTDate
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIsNull, cotNotIsNull],

    // actTime
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIsNull, cotNotIsNull],

    // actDouble
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIsNull, cotNotIsNull],

    // actWord
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIn, cotNotIn, cotIsNull, cotNotIsNull],

    // actBool
    [cotEqual, cotNotEqual, cotIsNull, cotNotIsNull],

    // actLogical (същото като bool)
    [cotEqual, cotNotEqual, cotIsNull, cotNotIsNull],

    // actCardinal
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIn, cotNotIn, cotIsNull, cotNotIsNull],

    // actINT64
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIn, cotNotIn, cotIsNull, cotNotIsNull],

    // actTIMESTAMP
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIsNull, cotNotIsNull],

    // actTTime
    [cotEqual, cotNotEqual, cotBigger, cotSmaller, cotBiggerEqual, cotSmallerEqual,
     cotNotBigger, cotNotSmaller, cotNotBiggerEqual, cotNotSmallerEqual,
     cotBetween, cotIsNull, cotNotIsNull],

    // actTArrInt (списъци)
    [cotContain, cotNotContain, cotIn, cotNotIn, cotIsNull, cotNotIsNull]
  );


  var
    FUserDate: TDate = 0;
    FS_Nzis: TFormatSettings;
  const
  EPS = 1e-9;

implementation

Function UserDate: Tdate;
begin
  if FUserDate = 0 then
  begin
    Result := Date;
  end
  else
  begin
    Result := FUserDate;
  end;
end;

initialization
  FS_Nzis := TFormatSettings.Create;
  FS_Nzis.DecimalSeparator := '.';
  //FS_Nzis.ThousandSeparator := ',';
  FS_Nzis.DateSeparator := '-';
  FS_Nzis.ShortDateFormat := 'yyyy-mm-dd';
  FS_Nzis.LongTimeFormat := 'hh:nn:ss';
end.



