program AspTest;

uses
  Vcl.Forms,
  Winapi.Windows,
  AspectiTest in 'AspectiTest.pas' {Form5},
  Aspects.Collections in 'Aspects\Aspects.Collections.pas',
  Aspects.Types in 'Aspects\Aspects.Types.pas';

{$R *.res}

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
