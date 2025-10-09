unit WordBreakF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Dialogs, Vcl.StdCtrls;

type
  TWordBreaks = AnsiString;

  TWordBreakF = class(TObject)
  private
    b: TWordBreaks;
    canvas: TCanvas;

    Fmaxwidth: Integer;
    Fsize1: Integer;
    Fsize: Integer;
    FStartFilter: Integer;
    FEndFilter: Integer;
    procedure WrapLine(const s: AnsiString);

  public
    ls: TStringList;
    Inls: TStringList;
    constructor create(Acanvas: TCanvas);
    destructor destroy; override;
    function BreakWord(s: AnsiString): TWordBreaks;
    procedure WrapMemo;
    procedure OutLine(const str: AnsiString; cntBreakChar: Integer);
    procedure OutMemo;

    property size: Integer read Fsize write Fsize;
    property size1: Integer read Fsize1 write Fsize1;
    property maxwidth: Integer read Fmaxwidth write Fmaxwidth;
    property StartFilter: Integer read FStartFilter write FStartFilter;
    property EndFilter: Integer read FEndFilter write FEndFilter;
  end;

const
  gl: set of AnsiChar = ['А', 'Е', 'Ё', 'И', 'О', 'У', 'Ы', 'Э', 'Ю', 'Я', 'A', 'E'];
  r_sogl: set of AnsiChar = ['Ъ', 'Ь'];
  spaces: set of AnsiChar = [' ', '.', ',', '-'];




implementation


function TWordBreakF.BreakWord(s: AnsiString): TWordBreaks;
var
  i: Integer;
  CanBreak: Boolean;
begin
  Result := '';
  s := AnsiUpperCase(s);
  if Length(s) >= 4 then
  begin
    i := 2;
    repeat
      CanBreak := False;
      if s[i] in gl then
      begin
        if (s[i + 1] in gl) or (s[i + 2] in gl) then CanBreak := True;
      end
      else
      begin
        if not (s[i + 1] in gl) and not (s[i + 1] in r_sogl) and
           (s[i + 2] in gl) then
          CanBreak := True;
      end;
      if CanBreak then
        Result := Result + Chr(i);
      Inc(i);
    until i > Length(s) - 2;
  end;
end;

constructor TWordBreakF.create(Acanvas: TCanvas);
begin
  canvas := Acanvas;
  ls := TStringList.Create;
  inls := TStringList.Create;
end;

destructor TWordBreakF.destroy;
begin
  ls.Free;
  inls.Free;
  inherited;
end;

procedure TWordBreakF.OutLine(const str: AnsiString; cntBreakChar: Integer);
begin
  ls.AddObject(str, TObject(cntBreakChar));
  Inc(Fsize, Fsize1);
end;
procedure TWordBreakF.WrapLine(const s: AnsiString);
  var
    i, cur, beg, last, LoopPos: Integer;
    WasBreak, CRLF: Boolean;
    delta: Integer;
  begin
    CRLF := False;
    LoopPos := 0;
    for i := 1 to Length(s) do
    begin
      if s[i] in [#10, #13] then
      begin
        CRLF := True;
        break;
      end;
    end;
    last := 1; beg := 1;
    if not CRLF and ((Length(s) <= 1) or (Canvas.TextWidth(s) <= maxwidth)) then
      OutLine(s + #1, 0)
    else
    begin
      cur := 1;
      while cur <= Length(s) do
      begin
        delta := 0;
        if s[cur] in [#10, #13] then
        begin
          if (FStartFilter < last) and (last < FEndFilter) then
          begin
            delta := FStartFilter -last;
          end
          else
          if (FStartFilter < beg) and (beg < FEndFilter) then
          begin
            delta := FEndFilter - beg + 1;
          end;
          OutLine(Copy(s, beg, cur - beg) + #1, delta);
          while (cur < Length(s)) and (s[cur] in [#10, #13]) do Inc(cur);
          beg := cur; last := beg;
          if s[cur] in [#13, #10] then
            Exit else
            continue;
        end;
        if s[cur] <> ' ' then
        if Canvas.TextWidth(Copy(s, beg, cur - beg + 1)) > maxwidth then
        begin
          WasBreak := False;
          if true then // zzzzzz
          begin
            i := cur;
            while (i <= Length(s)) and not (s[i] in spaces) do
              Inc(i);
            b := BreakWord(Copy(s, last + 1, i - last - 1));
            if Length(b) > 0 then
            begin
              i := 1;
              cur := last;
              while (i <= Length(b)) and
                (Canvas.TextWidth(Copy(s, beg, last - beg + 1 + Ord(b[i])) + '-') <= maxwidth) do
              begin
                WasBreak := True;
                cur := last + Ord(b[i]);
                Inc(i);
              end;
              last := cur;
            end;
          end
          else
            if last = beg then last := cur;
          if WasBreak then
          begin
            if (FStartFilter < last) and (last < FEndFilter) then
            begin
              delta := FStartFilter -last;
            end
            else
            if (FStartFilter < beg) and (beg <= FEndFilter) then
            begin
              delta := FEndFilter - beg + 1;
            end;
            //else // тука идва, когато има търсеното на няколко места
//            if s[beg] = s[FEndFilter] then
//            begin
//              delta := 1;
//            end;
            OutLine(Copy(s, beg, last - beg + 1) + '-', delta)
          end
          else
          if s[last] = ' ' then
          begin
            if (FStartFilter < last) and (last < FEndFilter) then
            begin
              delta := FStartFilter -last;
            end
            else
            if (FStartFilter < beg) and (beg <= FEndFilter) then
            begin
              delta := FEndFilter - beg + 1;
            end;
            OutLine(Copy(s, beg, last - beg), delta)
          end
          else
          begin
            if (FStartFilter < last) and (last < FEndFilter) then
            begin
              delta := FStartFilter -last;
            end
            else
            if (FStartFilter < beg) and (beg <= FEndFilter) then
            begin
              delta := FEndFilter - beg + 1;
            end;
            OutLine(Copy(s, beg, last - beg), delta);
            Dec(last);
          end;
          if WasBreak and (last = cur - 1) then
          begin
            if LoopPos = cur then
            begin
              beg := cur + 1;
              cur := Length(s);
              break;
            end
            else
              LoopPos := cur;
          end;
          beg := last + 1; last := beg;
        end;
        if s[cur] = ' ' then last := cur;
        Inc(cur);
      end;
      if beg <> cur then
      if (FStartFilter < beg) and (beg <= FEndFilter) then
      begin
        delta := FEndFilter - beg + 1;
      end;
      begin
        OutLine(Copy(s, beg, cur - beg + 1) + #1, delta);
      end;
    end;
  end;

  procedure TWordBreakF.OutMemo;
  var
    i: Integer;
    posHippHeigth: Integer;
  begin
    size := 0;// височина
    size1 := - Canvas.Font.Height ;
    //maxwidth := AWidth ; // широчина

    for i := 0 to InLs.Count - 1 do
    begin
      WrapLine(InLs[i])
    end;
  end;

procedure TWordBreakF.WrapMemo;
begin

  ls.Clear;
  OutMemo;
  //AHeight := size;
end;
end.
