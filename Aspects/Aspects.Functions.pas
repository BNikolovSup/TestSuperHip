unit Aspects.Functions;

interface
uses
  System.SysUtils;


  function ASPDateToStr(dat: TDate): string;

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
end.
