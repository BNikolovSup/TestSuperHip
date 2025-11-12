unit Aspects.Functions;

interface
uses
  System.SysUtils;


  function ASPDateToStr(dat: TDate): string;
  function ASPStrToDate(str: string): TDate;
  function ASPStrToDateTime(str: string): TDateTime;

implementation
uses Aspects.Types, System.DateUtils;
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

end.
