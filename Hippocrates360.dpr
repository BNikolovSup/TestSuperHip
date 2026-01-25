program Hippocrates360;



{$R *.dres}

uses
  Vcl.Controls,
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  System.StrUtils,
  Vcl.Themes,
  Vcl.Styles,
  SuperHipp in 'SuperHipp.pas' {frmSuperHip},
  TitleBar in '..\Popup\TitleBar.pas' {frmTitlebar},
  Options in 'Options.pas',
  DbHelper in 'DbHelper.pas',
  VTREditors in 'VTREditors.pas',
  HistoryNav in 'HistoryNav.pas',
  NZISSuperAddress in 'NZISSuperAddress.pas',
  DlgSuperCert23 in 'DlgSuperCert23.pas',
  FILE_SUBM_PL in 'FILE_SUBM_PL.pas',
  Fmx.HipTypes in 'Fmx.HipTypes.pas',
  DM in 'DM.pas',
  FmxWelcomeScreen in 'FmxWelcomeScreen.pas' {frmWelcomeScreen},
  AspectPerformerThread in 'AspectPerformerThread.pas',
  CertThread in 'CertThread.pas',
  RoleBar in '..\Popup\RoleBar.pas' {frmRolebar},
  RolePanels in '..\Popup\RolePanels.pas' {frmRolePanels},
  OptionsForm in '..\Popup\OptionsForm.pas' {frmOptionsForm},
  TempVtrHelper in 'TempVtrHelper.pas',
  DynamicButtons in 'DynamicButtons.pas',
  Execute.libPDFium in 'Execute.libPDFium.pas',
  PDFium.Frame in 'PDFium.Frame.pas',
  msgR002 in 'msgR002.pas',
  msgR016 in 'msgR016.pas',
  fmxImportNzisForm in '..\Popup\fmxImportNzisForm.pas' {frmImportNzis},
  uFuzzyMatch in 'uFuzzyMatch.pas',
  Nzis.NzisImport in 'NzisImport\Nzis.NzisImport.pas',
  HISXMLHelper in 'HISXMLHelper.pas',
  FilterFieldGenerator in 'FilterFieldGenerator.pas',
  FastSearch in 'FastSearch.pas',
  FmxAspectSchedule in '..\Popup\FmxAspectSchedule.pas' {frmScheduleFmx},
  FmxControls in '..\FMX\FmxControls.pas',
  RegisterBrushObject in '..\..\Source\RegisterBrushObject.pas';

{frmScheduleFmx}
  //Aspects.Interfaces in '..\..\Aspects\Aspects.Interfaces.pas';

{$R *.dres}
{$R *.res}
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}
begin
  Application.Initialize;
  Screen.HintFont.Size := 20;
  //HintWindowClass := THintWindowClass(TBalloonHint);
  Application.ShowMainForm := False;

  //Application.MainFormOnTaskbar := true;
  //reportMemoryLeaksOnShutdown  := true;
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ShortDateFormat := 'DD.MM.YYYY';
  Application.UpdateFormatSettings := False;
  LoadKeyBoardLayout('00040402',1);//https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-language-pack-default-values?view=windows-11

  Application.CreateForm(TfrmFmxControls, frmFmxControls);

  Application.CreateForm(TfrmSuperHip, frmSuperHip);
  //Application.CreateForm(TfrmTitlebar, frmTitlebar);
  Application.CreateForm(TfrmImportNzis, frmImportNzis);
  //Application.CreateForm(TfrmRolePanels, frmRolePanels);
  //Application.CreateForm(TfrmOptionsForm, frmOptionsForm);
  if ParamStr(1) <> '' then
  begin
    frmSuperHip.HipHandle := StrToInt(ParamStr(1));
    frmSuperHip.BorderStyle := bsNone;
    SendMessage(frmSuperHip.HipHandle, WM_Super_Start, frmSuperHip.Handle, 0);
    ShowWindow(Application.Handle, SW_HIDE);
  end
  else
  begin
    //frmSuperHip.BorderStyle := bsSizeable;
  end;

  //Application.CreateForm(TfrmFilter, frmFilter);
//  Application.CreateForm(TfrmFMXCalcPregled, frmFMXCalcPregled);
//  Application.CreateForm(TfrmFinder, frmFinder);
//  Application.CreateForm(TfrmCertDlg, frmCertDlg);
//  Application.CreateForm(TfrmProfFormFMX, frmProfFormFMX);
  //frmSuperHip.BorderStyle := bsSizeable;
  Application.Run;
end.
