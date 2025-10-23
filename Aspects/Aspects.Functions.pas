unit Aspects.Functions;

interface
uses
  System.SysUtils;


  function ASPDateToStr(dat: TDate): string;
  function ASPStrToDate(str: string): TDate;

implementation
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
  var
    fs: TFormatSettings;
  begin
    fs := TFormatSettings.Create();
    fs.DateSeparator := '-';
    fs.ShortDateFormat := 'YYYY-MM-DD';

    result := StrToDate(str, fs);
  end;
end.
