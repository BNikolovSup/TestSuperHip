unit MainWordBreak;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WordBreakF;

const
  gl: set of AnsiChar = ['А', 'Е', 'Ё', 'И', 'О', 'У', 'Ы', 'Э', 'Ю', 'Я'];
  r_sogl: set of AnsiChar = ['Ъ', 'Ь'];
  spaces: set of AnsiChar = [' ', '.', ',', '-'];
   type
  TWordBreaks = AnsiString;
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    memo1, SMemo: TStringList;
    FWrapped: Boolean;
    VHeight: Integer;
    TextHeight: Integer;
    procedure WrapMemo;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function BreakWord(s: AnsiString): TWordBreaks;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  r: TRect;
begin
  memo1 := TStringList.Create;
  SMemo := TStringList.Create;
  memo1.Text := 'Функция Wordwrap сканира текстов буфер, който съдържа текст за изпращане на екрана, като търси първата дума, която не се побира в текущия ред на екрана. Функцията Wordwrap поставя тази дума в началото на следващия ред на екрана.' ;
  FWrapped := false;
  WrapMemo;
  //ShowMessage(SMemo.Text);
  r := rect(0,0, 400, 400);
  Canvas.Rectangle(r);
  DrawText(Canvas.Handle, SMemo.Text, Length(SMemo.Text),r, TA_LEFT);

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  rText: TRect;
  i: Integer;
  w, h: Integer;
  text: string;
begin
  memo1 := TStringList.Create;
  SMemo := TStringList.Create;
  rText := Rect(0, 0, 180 + Random(120), 100);
  w:= rText.Width;
  h:= rText.Height;
  memo1.Text := 'Функция Wordwrap сканира текстов буфер, който съдържа текст за изпращане на екрана, като търси първата дума, която не се побира в текущия ред на екрана. Функцията Wordwrap поставя тази дума в началото на следващия ред на екрана.' ;
  WordBreakF.WrapMemo(Canvas, memo1, SMemo, w, h);
  rText.Width:= w ;
  rText.Height:= 13;
  Repaint;
  //Canvas.Rectangle(rtext);
  rText.Offset(2, 2);
  for i := 0 to SMemo.Count - 1 do
  begin
    //Canvas.Rectangle(rtext);
    text := SMemo[i];
    DrawText(Canvas.Handle, SMemo[i], Length(SMemo[i]),rtext, TA_LEFT);
    rText.Offset(0, 13);
  end;
  //DrawText(Canvas.Handle, SMemo.Text, Length(SMemo.Text),rtext, TA_LEFT);

end;

procedure TForm1.WrapMemo;
var
  size, size1, maxwidth: Integer;
  b: TWordBreaks;

  procedure OutLine(const str: AnsiString);
  begin
    SMemo.Add(str);
    Inc(size, size1);
  end;

  procedure WrapLine(const s: AnsiString);
  var
    i, cur, beg, last, LoopPos: Integer;
    WasBreak, CRLF: Boolean;
  begin
    CRLF := False;
    LoopPos := 0;
    for i := 1 to Length(s) do
      if s[i] in [#10, #13] then
      begin
        CRLF := True;
        break;
      end;
    last := 1; beg := 1;
    if not CRLF and ((Length(s) <= 1) or (Canvas.TextWidth(s) <= maxwidth)) then
      OutLine(s + #1)
    else
    begin
      cur := 1;
      while cur <= Length(s) do
      begin
        if s[cur] in [#10, #13] then
        begin
          OutLine(Copy(s, beg, cur - beg) + #1);
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
            OutLine(Copy(s, beg, last - beg + 1) + '-')
          else if s[last] = ' ' then
            OutLine(Copy(s, beg, last - beg)) else
          begin
            OutLine(Copy(s, beg, last - beg));
            Dec(last);
          end;
          if true and not WasBreak and (last = cur - 1) then
            if LoopPos = cur then
            begin
              beg := cur + 1;
              cur := Length(s);
              break;
            end
            else
              LoopPos := cur;
          beg := last + 1; last := beg;
        end;
        if s[cur] = ' ' then last := cur;
        Inc(cur);
      end;
      if beg <> cur then OutLine(Copy(s, beg, cur - beg + 1) + #1);
    end;
  end;

  procedure OutMemo;
  var
    i: Integer;
    posHippHeigth: Integer;
  begin
    size := 120;// височина
    size1 := -Canvas.Font.Height ;
    maxwidth := 240 ; // широчина


      for i := 0 to Memo1.Count - 1 do
        if FWrapped then
          OutLine(Memo1[i])
        else
          if true then
            WrapLine(Memo1[i])
          else
            OutLine(Memo1[i] + #1);
        VHeight := size - 120 ; // височината
    TextHeight := size1;
  end;

begin

  SMemo.Clear;
  OutMemo;
end;

end.
