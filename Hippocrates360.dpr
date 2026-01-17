program Hippocrates360;



{$R *.dres}

uses
  Vcl.Controls,
  Parnassus.FMXContainer in 'FMX\Parnassus.FMXContainer.pas',
  Parnassus.FMXContainerReg in 'FMX\Parnassus.FMXContainerReg.pas',
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
  ADB_DataUnit in 'ADB_DataUnit.pas',
  Fmx.HipTypes in 'Fmx.HipTypes.pas',
  ProfForm in 'FMX\ProfForm.pas',
  DM in 'DM.pas',
  FinderFormFMX in 'FMX\FinderFormFMX.pas',
  FmxWelcomeScreen in 'FmxWelcomeScreen.pas' {frmWelcomeScreen},
  AspectPerformerThread in 'AspectPerformerThread.pas',
  WalkFunctions in 'WalkFunctions.pas',
  CertThread in 'CertThread.pas',
  Tokens in 'FMX\Tokens.pas' {frmFmxTokens},
  RoleBar in '..\Popup\RoleBar.pas' {frmRolebar},
  RolePanels in '..\Popup\RolePanels.pas' {frmRolePanels},
  OptionsForm in '..\Popup\OptionsForm.pas' {frmOptionsForm},
  FMX.GifUtils in 'C:\Users\Administrator1\Downloads\FMXGif\FMX.GifUtils.pas',
  RegisterBrushObject in '..\--component\RegisterBrushObject.pas',
  TempVtrHelper in 'TempVtrHelper.pas',
  DynamicButtons in 'DynamicButtons.pas',
  Execute.libPDFium in 'Execute.libPDFium.pas',
  PDFium.Frame in 'PDFium.Frame.pas',
  FmxControls in '..\Popup\FmxControls.pas' {frmFmxControls},
  msgR002 in 'msgR002.pas',
  msgR016 in 'msgR016.pas',
  fmxImportNzisForm in '..\Popup\fmxImportNzisForm.pas' {frmImportNzis},
  uFuzzyMatch in 'uFuzzyMatch.pas',
  Nzis.NzisImport in 'NzisImport\Nzis.NzisImport.pas',
  HISXMLHelper in 'HISXMLHelper.pas',
  FilterFieldGenerator in 'FilterFieldGenerator.pas',
  FastSearch in 'FastSearch.pas',
  FmxAspectSchedule in '..\Popup\FmxAspectSchedule.pas'; {frmScheduleFmx}
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


  Application.CreateForm(TfrmSuperHip, frmSuperHip);
  //Application.CreateForm(TfrmTitlebar, frmTitlebar);
  Application.CreateForm(TfrmFmxControls, frmFmxControls);
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
