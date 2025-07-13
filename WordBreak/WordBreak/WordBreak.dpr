program WordBreak;

uses
  Vcl.Forms,
  MainWordBreak in 'MainWordBreak.pas' {Form1},
  WordBreak in '..\..\WordBreak.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
