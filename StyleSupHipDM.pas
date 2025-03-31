unit StyleSupHipDM;

interface

uses
  System.SysUtils, System.Classes, FMX.Controls;

type
  TDataModule1 = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

initialization
  RegisterClass(TStyleBook);

end.
