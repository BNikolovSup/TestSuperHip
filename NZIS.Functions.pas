unit NZIS.Functions;

interface
uses
  System.SysUtils, System.DateUtils, System.Classes,
  Nzis.Types,
  Winapi.MSXMLIntf, Winapi.msxml, system.IniFiles, System.IOUtils, Winapi.Windows;

  function CalcAge(CurrentDate, BirthDate: TDate): double;
  function GetURLFromXML(xmlStr: string; var msgType: tmessageType; IsTest: Boolean): string;
  procedure CheckValidationError(vXML: IXMLDOMDocument3; var err: EXMLDOMValidationError);
  procedure ValidateXMLText(XMLText: string; vSchemaX00Y: IXMLDOMDocument3;
       NameSpaceSchema: string; var err: EXMLDOMValidationError);
  function LibraryPath: String;

implementation



function LibraryPath: String;
var  lpBuffer:   Array [0..MAX_PATH] of wideChar;
begin

  // Return the dll's path
  if IsLibrary then
  begin
     GetModuleFileName(hInstance, lpBuffer, SizeOf(lpBuffer));
     result:=ExcludeTrailingBackslash(ExtractFilePath(lpBuffer));
  end
  else
     // Not a library
     result:='';

end;

procedure CheckValidationError(vXML: IXMLDOMDocument3; var err: EXMLDOMValidationError);
var
  ValidationError: IXMLDOMParseError;
  //hs: THipStatus;
begin
  ValidationError := vXML.parseError;
  if ValidationError.errorCode <> 0 then
  begin
    err := EXMLDOMValidationError.Create(ValidationError);
  end;
end;

procedure ValidateXMLText(XMLText: string; vSchemaX00Y: IXMLDOMDocument3;
      NameSpaceSchema: string; var err: EXMLDOMValidationError);
var
  vXML: IXMLDOMDocument3;
  vSchemaCollection: IXMLDOMSchemaCollection2;
begin
  Exit;
  vSchemaCollection := CoXMLSchemaCache60.Create;
  vSchemaCollection.add(NameSpaceSchema, vSchemaX00Y);

  vXML := CoDOMDocument60.Create;
  vXML.async := False;
  vXML.validateOnParse := True;
  vXML.schemas := vSchemaCollection;
  vXML.loadXML(XMLText);

  CheckValidationError(vXML, err);
end;

function CalcAge(CurrentDate, BirthDate: TDate): double;
var
  d, m, y: Word;
  d1, m1, y1: Word;
begin
  DecodeDate(BirthDate, y, m, d);
  DecodeDate(CurrentDate, y1, m1, d1);
  if (d1 = d) and (m1 = m) then
  begin
    if CurrentDate > BirthDate then
      Result := y1 - y
    else
      Result := -y1 + y;
    Exit;
  end;

  if CurrentDate > BirthDate then
    Result := (System.DateUtils.YearSpan(CurrentDate, BirthDate))
  else
    Result := (-System.DateUtils.YearSpan(BirthDate, CurrentDate));
end;

function GetURLFromXML(xmlStr: string; var msgType: tmessageType; IsTest: Boolean): string;
var
  str: AnsiString;
  intStr: Cardinal;
  pos1, len: Integer;
  stream: TMemoryStream;
  url: string;
  ini: TIniFile;
  libPath, addUrl: string;
  isProxy: boolean;
  //https://download.kontrax.bg/proxy/auth.his.bg/
  //https://download.kontrax.bg/proxy/api.his.bg/
begin
  addUrl := '';
  if IsTest then
  begin
    url := 'https://ptest-api.his.bg/';
    //url := 'https://download.kontrax.bg/proxy/ptest-api.his.bg/';
  end
  else       //hospital.api.his.bg //
  begin
    url := 'https://api.his.bg/';
    //url := 'https://download.kontrax.bg/proxy/api.his.bg/';
  end;
  try
    libPath := LibraryPath;
    ini := TIniFile.Create(libPath + '\nzis.ini');
    isProxy := ini.ReadBool('Options', 'Proxy1', false);
    ini.Free;
    if isProxy then
      addUrl := 'download.kontrax.bg/proxy/';
    if IsTest then
    begin
      url := 'https://' + addUrl +'ptest-api.his.bg/';
      //url := 'https://download.kontrax.bg/proxy/ptest-api.his.bg/';
    end
    else       //hospital.api.his.bg //
    begin
      url := 'https://' + addUrl +'api.his.bg/';
      //url := 'https://download.kontrax.bg/proxy/api.his.bg/';
    end;
  except

  end;

  try
    stream := TMemoryStream.Create;
    len := Length('<nhis:messageType value="');
    pos1 := Pos('<nhis:messageType value="', xmlStr) + len;
    if Pos1 > len then
    begin
      str := Copy(xmlStr, pos1, 4);
    end;
    stream.Position := 0;
    stream.Write(str[1], 4);
    stream.Position := 0;
    stream.Read(intstr, 4);
    msgType := tmessageType(intStr);
    case msgType of
      C001: Result := url + 'v1/nomenclatures/all/get';
      C003: Result := url + 'v1/nomenclatures/all/vaccinelotnumber';
      C005: Result := url + 'v1/eimmunization/immunization/addreaction';
      C007: //Result := url + 'v2/ereferral/laboratory/resultswitoutreferal';
      begin
        if (LoadStr(0) = 'NzisURL=') or (LoadStr(0) = '') then
        begin
           Result := url + 'v2/ereferral/laboratory/resultswitoutreferal';
        end
        else
        begin
          Result := LoadStr(0).Replace('NzisURL=', '');
        end;
      end;
      //C007: Result := 'https://iistest.kontrax.bg/Dimitrovgrad/api/laboratory/results';
     // C007: Result := 'http://smartmed.dimitrovgrad.bg/api/laboratory/results';
      //C007: Result := 'http://localhost/api/laboratory/results';
      C009: Result := url + 'v2/ereferral/laboratory/batchexecution';
      C011: Result := url + 'v1/ereferral/laboratory/batchexecutionfetch';
      C013: Result := url + 'v1/commons/doctor/update-deputization';
      C015: Result := url + 'v1/commons/doctor/check-deputization';
      C041: Result := url + 'v3/commons/doctor/medical-notice-issue';
      C045: Result := url + 'v3/commons/doctor/medical-notice-cancel';

      X001: Result := url + 'v2/eexamination/examination/open';
      X003: Result := url + 'v2/eexamination/examination/close';
      X005: Result := url + 'v2/eexamination/examination/fetch';
      X007: Result := url + 'v2/eexamination/examination/cancel';
      X009: Result := url + 'v2/eexamination/examination/correct';
      X011: Result := url + 'v2/eexamination/examination/sickleave';
      X013: Result := url + 'v2/eexamination/examination/submit-offline';

      R001: Result := url + 'v2/ereferral/doctor/issue';
      R003: Result := url + 'v3/ereferral/laboratory/fetch';
      R005: Result := url + 'v2/ereferral/laboratory/results';
      R007: Result := url + 'v2/ereferral/doctor/cancel';
      R009: Result := url + 'v3/ereferral/doctor/check';
      R011: Result := url + 'v2/ereferral/laboratory/progress';
      R015: Result := url + 'v3/ereferral/doctor/fetch';
      R017: Result := url + 'v2/ereferral/doctor/reject';

      I001: Result := url + 'v1/eimmunization/immunization/issue';
      I003: Result := url + 'v1/eimmunization/immunization/fetch';
      I005: Result := url + 'v1/eimmunization/immunization/addreaction';
      I007: Result := url + '';
      I009: Result := url + '';
      I011: Result := url + 'v1/eimmunization/immunization/stornoimmunization';
      I013: Result := url + 'v1/eimmunization/immunization/certificate';

      P001: Result := url + 'v3/eprescription/doctor/issue';
      P003: Result := url + 'v3/eprescription/pharmacy/fetch';
      P005: Result := url + 'v3/eprescription/pharmacy/dispense';
      P007: Result := url + 'v3/eprescription/doctor/cancel';
      P009: Result := url + 'v3/eprescription/pharmacy/reject';
      P011: Result := url + 'v3/eprescription/pharmacy/dispense-offline';
      P013: Result := url + 'v3/eprescription/pharmacy/fetchdispense';
      P015: Result := url + 'v3/eprescription/pharmacy/canceldispense';

      H001: Result := url + 'v1/ehospitalization/hospitalization/fetch';
      H011: Result := url + 'v1/ehospitalization/hospitalization/fetch-births';
    end;
  finally
    stream.Free;
  end;

end;

end.
