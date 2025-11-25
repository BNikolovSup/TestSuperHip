unit Aspects.Functions;

interface
uses
  System.SysUtils;


  function ASPDateToStr(dat: TDate): string;
  function ASPStrToDate(str: string): TDate;
  function ASPStrToDateTime(str: string): TDateTime;
  function CompareMemRange(p1, p2: PAnsiChar; len: Integer): Integer; inline;
  procedure DebugMsg(const S: string);
  function CeltextFilterObjectFromVid(vid: Word): string;

implementation
uses Aspects.Types, System.DateUtils, Winapi.Windows;

function CeltextFilterObjectFromVid(vid: Word): string;
var
  CellText: string;
begin
  case TVtrVid(vid) of
    vvNone:                         CellText := '';

    vvOrders:                       CellText := 'Заявки';
    vvAspects:                      CellText := 'Аспекти';
    vvOPL:                          CellText := 'ОПЛ';
    vvPrimaryMedDoc:                CellText := 'Първични мед. документи';
    vvSupto:                        CellText := 'СУПТО';
    vvOrderSuptoOPL:                CellText := 'Заявки СУПТО ОПЛ';
    vvSuptoCash:                    CellText := 'СУПТО каса';
    vvCash:                         CellText := 'Каса';
    vvClients:                      CellText := 'Клиенти';
    vvRgClients:                    CellText := 'Регистрирани клиенти';
    vvNotRgClients:                 CellText := 'Нерегистрирани клиенти';

    vvPacketFunctRoot:              CellText := 'Пакет функционалности';
    vvPacket:                       CellText := 'Пакет';
    vvPacketTemp:                   CellText := 'Временен пакет';
    vvPacketIndex:                  CellText := 'Индекс на пакета';
    vvFunctionaly:                  CellText := 'Функционалности';
    vvTables:                       CellText := 'Таблици';

    vvPatientNewRoot:               CellText := 'Пациенти';
    vvPatient:                      CellText := 'Пациент';
    vvPregled:                      CellText := 'Прегледи';

    vvNomenNzis:                    CellText := 'Номенклатура НЗИС';
    vvCl132:                        CellText := 'CL132';
    vvPR001:                        CellText := 'PR001';
    vvCl134:                        CellText := 'CL134';

    vvDiag:                         CellText := 'Диагнози';
    vvMDN:                          CellText := 'МДН';
    vvPregledNewRoot:               CellText := 'Прегледи';

    vvRole:                         CellText := 'Роли';
    vvMedNapr:                      CellText := 'Мед. направления';
    vvDoctor:                       CellText := 'Лекар';

    vvNzisBiznes:                   CellText := 'НЗИС бизнес правила';

    vvAnalPackage:                  CellText := 'Анализ пакет';
    vvAnalRoot:                     CellText := 'Анализи';
    vvAnal:                         CellText := 'Анализ';

    vvPerformerRoot:                CellText := 'Изпълнители';
    vvPerformer:                    CellText := 'Изпълнител';

    vvCMDRoot:                      CellText := 'ЦМД';
    vvCMD:                          CellText := 'ЦМД';

    vvMKB:                          CellText := 'МКБ';

    vvEvnt:                         CellText := 'Събитие';
    vvUnfav:                        CellText := 'Нежелани реакции';

    vvOptionRoot:                   CellText := 'Опции';
    vvOptionDB:                     CellText := 'Опции база данни';
    vvOptionGrids:                  CellText := 'Опции гридове';
    vvOptionGridSearch:             CellText := 'Опции търсене / грид';

    vvCloning:                      CellText := 'Клониране';
    vvDeput:                        CellText := 'Заместници';
    vvEbl:                          CellText := 'ЕБЛ';
    vvLink:                         CellText := 'Линкове';

    vvDoctorRoot:                   CellText := 'Лекари';
    vvCert:                         CellText := 'Сертификати';
    vvCL142:                        CellText := 'CL142';
    vvCL088:                        CellText := 'CL088';

    vvExamAnal:                     CellText := 'Изследвания / анализи';
    vvEvntList:                     CellText := 'Списък събития';
    vvExamImun:                     CellText := 'Имунизации';
    vvProcedures:                   CellText := 'Процедури';

    vvNZIS_PLANNED_TYPE:            CellText := 'НЗИС тип планиране';
    vvNZIS_QUESTIONNAIRE_RESPONSE:  CellText := 'Анкета - отговор';
    vvNZIS_DIAGNOSTIC_REPORT:       CellText := 'Диагностичен репорт';
    vvNZIS_QUESTIONNAIRE_ANSWER:    CellText := 'Анкета - отговор';
    vvNZIS_ANSWER_VALUE:            CellText := 'Анкета - стойност';
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:CellText := 'Резултат диагностичен репорт';

    vvCL144:                        CellText := 'CL144';
    vvNomenNzisUpdate:              CellText := 'Ъпдейт номенклатура НЗИС';
    vvCL024:                        CellText := 'CL024';
    vvCL139:                        CellText := 'CL139';
    vvCL038:                        CellText := 'CL038';
    vvCL022:                        CellText := 'CL022';

    vvProfCard:                     CellText := 'Профилактична карта';
    vvRootDeput:                    CellText := 'Заместници';
    vvPatientRevision:              CellText := 'Ревизия пациент';

    vvRootOptions:                  CellText := 'Настройки';
    vvOptionSearchGrid:             CellText := 'Опции търсене';
    vvFieldSearchGridOption:        CellText := 'Поле на търсачка';
    vvOptionSearchCot:              CellText := 'Опции СОТ';

    vvMKBGroup:                     CellText := 'МКБ група';
    vvMKBSubGroup:                  CellText := 'МКБ подгрупа';
    vvNomenMkb:                     CellText := 'Номенклатура МКБ';

    vvPractica:                     CellText := 'Практика';
    vvKARTA_PROFILAKTIKA2017:       CellText := 'Карта профилактика 2017';
    vvMKBAdd:                       CellText := 'МКБ допълнителни';

    vvNzisMessages:                 CellText := 'НЗИС съобщения';

    vvRecepta:                      CellText := 'Рецепти';
    vvHosp:                         CellText := 'Хоспитализации';
    vvObshti:                       CellText := 'Общи';

    vvMedNapr3A:                    CellText := 'Мед. направление 3А';
    vvIncMdn:                       CellText := 'МДН инцидент';
    vvMedNaprHosp:                  CellText := 'Мед. напр. хосп.';
    vvMedNaprLkk:                   CellText := 'Мед. напр. ЛКК';
    vvIncMN:                        CellText := 'Инцидент МН';

    vvOtherDoctor:                  CellText := 'Друг лекар';

    vvRootNasMesta:                 CellText := 'Населени места';
    vvOblast:                       CellText := 'Област';
    vvObshtina:                     CellText := 'Община';
    vvNasMesto:                     CellText := 'Населено място';
    vvAddres:                       CellText := 'Адрес';

    vvRootdoctor:                   CellText := 'Лекари';
    vvRootDoctorPrac:               CellText := 'Практики';
    vvRootDoctorSender:             CellText := 'Изпращащи лекари';
    vvRootDoctorConsult:            CellText := 'Консултанти';
    vvRootDoctorColege:             CellText := 'Колеги лекари';

    vvRootFilter:                   CellText := 'Филтри';

  else
    //raise Exception.Create('Непознат Vid: ' + TRttiEnumerationType.GetName(data.vid));
  end;
  Result := CellText;
end;

procedure DebugMsg(const S: string);
begin
  OutputDebugString(PChar(S)); // само в дебъгера, не блокира нишката
end;

  function ASPDateToStr(dat: TDate): string;
  begin
    if dat = 0 then
    begin
      Result := '';
    end
    else
    begin
      Result := DateToStr(dat);
    end;
  end;

  function ASPStrToDate(str: string): TDate;
  begin
    result := StrToDate(str, FS_Nzis);
  end;

  function ASPStrToDateTime(str: string): TDateTime;
  begin
    Result := ISO8601ToDate(str, true);
  end;

  function CompareMemRange(p1, p2: PAnsiChar; len: Integer): Integer; inline;
var
  i: Integer;
  c1, c2: Byte;
begin
  for i := 0 to len - 1 do
  begin
    c1 := Byte(p1[i]);
    c2 := Byte(p2[i]);
    if c1 <> c2 then
    begin
      Result := c1 - c2;
      Exit;
    end;
  end;
  Result := 0;
end;




end.
