program WordBreak;

uses
  Vcl.Forms,
  MainWordBreak in 'MainWordBreak.pas' {Form1},
  WordBreakF in '..\..\WordBreakF.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
