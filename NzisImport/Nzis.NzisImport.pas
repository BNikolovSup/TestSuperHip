unit Nzis.NzisImport; //find

interface
uses
  system.Classes, system.SysUtils, System.Diagnostics, System.TimeSpan,
  System.Generics.Collections, system.Rtti,
  Vcl.Forms, Xml.XMLDoc, Xml.XMLIntf,
  SynEdit, Parnassus.FMXContainer,
  Vcl.StdCtrls, Vcl.ComCtrls,
  RoleBar, fmxImportNzisForm,
  VirtualStringTreeHipp, VirtualTrees,  Nzis.XMLHelper,
  RealObj.RealHipp, RealObj.NzisNomen, RealNasMesto,
  msgX001, msgX002, msgX003, msgX013, msgR001, msgR002, msgR016, x014,
  Aspects.Types, Aspects.Collections,
  Table.NzisReqResp, Table.PatientNew, Table.PregledNew, Table.Diagnosis,
  Table.MDN, Table.INC_NAPR, Table.OtherDoctor, Table.Practica,
  Table.BLANKA_MED_NAPR, Table.BLANKA_MED_NAPR_3A, Table.HOSPITALIZATION,
  table.exam_Lkk, ADB_DataUnit
  ;
type
  TPatImportNzisNodes = class
    patNode: PVirtualNode;
    docNode: PVirtualNode;
    addresses: TList<PVirtualNode>;
    ExamAnals: TList<PVirtualNode>;
    diags: TList<PVirtualNode>;
    pregs: TList<PVirtualNode>;
    CollDiag: TRealDiagnosisColl;

    constructor create;
    destructor destroy; override;

    function GetNZISPidType(buf: pointer; posdata: cardinal): TNZISidentifierType;
    procedure SortDiag(SortIsAsc: Boolean);
  end;


  TNzisImport = class(TObject)
  private
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    FVtrImport: TVirtualStringTreeHipp;

    msgColl: TNzisReqRespColl;
    FmmoTest: TMemo;
    FFmxRoleBar: TfrmRolebar;
    FAspectsHipFile: TMappedFile;
    FAspectsLinkPatPregFile: TMappedLinkFile;
    FCollOtherDoctor: TRealOtherDoctorColl;
    LstXXXX: TList<TNzisReqRespItem>;
    LstRMDN: TList<TNzisReqRespItem>;
    LstRMN: TList<TNzisReqRespItem>;
    lstRVSD: TList<TNzisReqRespItem>;
    lstRHosp: TList<TNzisReqRespItem>;
    lstRMedExpert: TList<TNzisReqRespItem>;
    LstRIncMN: TList<TRealINC_NAPRItem>;
    vPatImportNzis, vImportNzis,
    vImportNzisPregled, vImportNzisNapr, vImportNzisRec, vImportNzisImun,
    vImportNzisHosp, vImportNzisObshti: PVirtualNode;
    FsyndtNzisReq: TSynEdit;
    FsyndtNzisResp: TSynEdit;
    FFmxImportNzisFrm: TfrmImportNzis;
    FfmxCntrDyn: TFireMonkeyContainer;
    FProcChangeWorkTS: TProc<TTabSheet>;
    FtsFMXForm: TTabSheet;
    FNasMesto: TRealNasMestoAspects;
    FProcChangeTreeTS: TProc<TTabSheet>;
    FProcAddNewPat: TProc<TRealPatientNewItem, PVirtualNode>;
    FCollPractica: TPracticaColl;
    FRCZSelf: string;
    FCollDoctor: TRealDoctorColl;
    //FProcAddNewPreg: TProc<TRealPregledNewItem, PVirtualNode>;
    procedure AddNzisImport(FileName: TFileName);
    procedure FillRespInReq;
    procedure FillADBInMsgColl;
    procedure FillIncDoctor;
    procedure LoopXml;
    procedure Delete99;
    procedure FillMsgXXXInPregled;
    procedure FillMsgRIncMNInIncMN;
    procedure FillIncDoctorInIncNapr;
    procedure AddNewIncDoctorMDN;
    procedure AddNewIncDoctorMN;
    procedure AddNewPreg;
    procedure FillPregInPat;
    procedure FillAddrInPat;
    procedure AddNewPatXXX;
    procedure FillPregledInIncMN;
    procedure FillMsgRMdnInMdn;
    procedure AddNewMdn;
    procedure AddNewMN;
    procedure AddNewMN3;
    procedure AddNewMNHosp;
    procedure AddNewMNExpert;
    procedure FillReferalMdnInPreg;
    procedure FillReferalMnInPreg;
    procedure FillReferalMn3InPreg;
    procedure FillReferalMnHospInPreg;
    procedure FillReferalMnExpertInPreg;
    procedure FillDiagInPreg;

    procedure LoadTempVtrMSG4;

    procedure vtrTempGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrTempChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SetVtrImport(const Value: TVirtualStringTreeHipp);
    procedure SetNasMesto(const Value: TRealNasMestoAspects);
    procedure SetCollPractica(const Value: TPracticaColl);
    procedure SetCollDoctor(const Value: TRealDoctorColl);
  public
    FnzisXml: TNzisXMLHelper;
    Adb_DM: TADBDataModule;
    constructor create;
    destructor destroy;
    procedure ImportNzis(FileName: TFileName);
    procedure LoopPat;
    procedure ExportNzisToDB;
    property VtrImport: TVirtualStringTreeHipp read FVtrImport write SetVtrImport;
    property mmoTest: TMemo read FmmoTest write FmmoTest;
    property FmxRoleBar: TfrmRolebar read FFmxRoleBar write FFmxRoleBar;
    property AspectsHipFile: TMappedFile read FAspectsHipFile write FAspectsHipFile;
    property AspectsLinkPatPregFile: TMappedLinkFile read FAspectsLinkPatPregFile write FAspectsLinkPatPregFile;
    property CollOtherDoctor: TRealOtherDoctorColl read FCollOtherDoctor write FCollOtherDoctor;
    property syndtNzisReq: TSynEdit read FsyndtNzisReq write FsyndtNzisReq;
    property syndtNzisResp: TSynEdit read FsyndtNzisResp write FsyndtNzisResp;
    property FmxImportNzisFrm: TfrmImportNzis read FFmxImportNzisFrm write FFmxImportNzisFrm;
    property fmxCntrDyn: TFireMonkeyContainer read FfmxCntrDyn write FfmxCntrDyn;
    property tsFMXForm: TTabSheet read FtsFMXForm write FtsFMXForm;
    property ProcChangeWorkTS: TProc<TTabSheet> read FProcChangeWorkTS write FProcChangeWorkTS;
    property ProcChangeTreeTS: TProc<TTabSheet> read FProcChangeTreeTS write FProcChangeTreeTS;
    property ProcAddNewPat: TProc<TRealPatientNewItem, PVirtualNode> read FProcAddNewPat write FProcAddNewPat;
    //property ProcAddNewPat: TProc<TRealPatientNewItem, PVirtualNode> read FProcAddNewPat write FProcAddNewPat;
    //property ProcAddNewPreg: TProc<TRealPregledNewItem, PVirtualNode> read FProcAddNewPreg write FProcAddNewPreg;
    property NasMesto: TRealNasMestoAspects read FNasMesto write SetNasMesto;
    property CollPractica: TPracticaColl read FCollPractica write SetCollPractica;
    property CollDoctor: TRealDoctorColl read FCollDoctor write SetCollDoctor;
    property RCZSelf: string read FRCZSelf;
  end;

implementation

{ TNzisImport }

procedure TNzisImport.AddNewIncDoctorMDN;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMdn: TRealMDNItem;
begin
  msgColl.SortListByNRN(LstRMDN);
  CurrentNrn := '';
  for i := 0 to LstRMDN.Count - 1 do
  begin
    msg := LstRMDN[i];
    if msg.Mdn = nil then
    begin
       if CurrentNrn <> LstRMDN[i].PRecord.NRN then
       begin
         currentMdn := TRealMDNItem(msgColl.CollMdn.Add);
         CurrentNrn := LstRMDN[i].PRecord.NRN;
         currentMdn.FLstMsgImportNzis.Add(msg);
         currentMdn.NRN := CurrentNrn;
         currentMdn.PregledNRN := LstRMDN[i].PRecord.BaseOn;
         LstRMDN[i].Mdn := currentMdn;
       end
       else
       begin
         currentMdn.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewIncDoctorMN;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMn: TRealBLANKA_MED_NAPRItem;
begin
  msgColl.SortListByNRN(LstRMN);
  CurrentNrn := '';
  for i := 0 to LstRMN.Count - 1 do
  begin
    msg := LstRMN[i];
    if msg.Mdn = nil then
    begin
       if CurrentNrn <> LstRMN[i].PRecord.NRN then
       begin
         currentMn := TRealBLANKA_MED_NAPRItem(msgColl.CollMN.Add);
         CurrentNrn := LstRMN[i].PRecord.NRN;
         currentMn.FLstMsgImportNzis.Add(msg);
         currentMn.NRN := CurrentNrn;
         currentMn.PregledNRN := LstRMN[i].PRecord.BaseOn;
         LstRMN[i].Mn := currentMn;
       end
       else
       begin
         currentMn.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewMdn;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMdn: TRealMDNItem;
begin
  msgColl.SortListByNRN(LstRMDN);
  CurrentNrn := '';
  for i := 0 to LstRMDN.Count - 1 do
  begin
    msg := LstRMDN[i];
    if msg.Mdn = nil then
    begin
       if CurrentNrn <> LstRMDN[i].PRecord.NRN then
       begin
         currentMdn := TRealMDNItem(msgColl.CollMdn.Add);
         CurrentNrn := LstRMDN[i].PRecord.NRN;
         currentMdn.FLstMsgImportNzis.Add(msg);
         currentMdn.NRN := CurrentNrn;
         currentMdn.PregledNRN := LstRMDN[i].PRecord.BaseOn;
         LstRMDN[i].Mdn := currentMdn;
       end
       else
       begin
         currentMdn.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewMN;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMN: TRealBLANKA_MED_NAPRItem;
begin
  msgColl.SortListByNRN(LstRMN);
  CurrentNrn := '';
  for i := 0 to LstRMN.Count - 1 do
  begin
    msg := LstRMN[i];
    if msg.MN = nil then
    begin
       if CurrentNrn <> LstRMN[i].PRecord.NRN then
       begin
         currentMN := TRealBLANKA_MED_NAPRItem(msgColl.CollMN.Add);
         CurrentNrn := LstRMN[i].PRecord.NRN;
         currentMN.FLstMsgImportNzis.Add(msg);
         currentMN.NRN := CurrentNrn;
         currentMN.PregledNRN := LstRMN[i].PRecord.BaseOn;
         LstRMN[i].Mn := currentMN;
       end
       else
       begin
         currentMN.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewMN3;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMN3: TRealBLANKA_MED_NAPR_3AItem;
begin
  msgColl.SortListByNRN(lstRVSD);
  CurrentNrn := '';
  for i := 0 to lstRVSD.Count - 1 do
  begin
    msg := lstRVSD[i];
    if msg.MN3 = nil then
    begin
       if CurrentNrn <> lstRVSD[i].PRecord.NRN then
       begin
         currentMN3 := TRealBLANKA_MED_NAPR_3AItem(msgColl.CollMN.Add);
         CurrentNrn := lstRVSD[i].PRecord.NRN;
         currentMN3.FLstMsgImportNzis.Add(msg);
         currentMN3.NRN := CurrentNrn;
         currentMN3.PregledNRN := lstRVSD[i].PRecord.BaseOn;
         lstRVSD[i].Mn3 := currentMN3;
       end
       else
       begin
         currentMN3.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewMNExpert;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMNExpert: TRealEXAM_LKKItem;
begin
  msgColl.SortListByNRN(lstRMedExpert);
  CurrentNrn := '';
  for i := 0 to lstRMedExpert.Count - 1 do
  begin
    msg := lstRMedExpert[i];
    mmoTest.Lines.Add(lstRMedExpert[i].PRecord.NRN);
    if msg.MNLkk = nil then
    begin
       if CurrentNrn <> lstRMedExpert[i].PRecord.NRN then
       begin
         currentMNExpert := TRealEXAM_LKKItem(msgColl.CollMnExpert.Add);
         CurrentNrn := lstRMedExpert[i].PRecord.NRN;
         currentMNExpert.FLstMsgImportNzis.Add(msg);
         currentMNExpert.NRN := CurrentNrn;
         currentMNExpert.PregledNRN := lstRMedExpert[i].PRecord.BaseOn;
         lstRMedExpert[i].MNLkk := currentMNExpert;
       end
       else
       begin
         currentMNExpert.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewMNHosp;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMNHosp: TRealHOSPITALIZATIONItem;
begin
  msgColl.SortListByNRN(lstRHosp);
  CurrentNrn := '';
  for i := 0 to lstRHosp.Count - 1 do
  begin
    msg := lstRHosp[i];
    if msg.MNHosp = nil then
    begin
       if CurrentNrn <> lstRHosp[i].PRecord.NRN then
       begin
         currentMNHosp := TRealHOSPITALIZATIONItem(msgColl.CollMnHosp.Add);
         CurrentNrn := lstRHosp[i].PRecord.NRN;
         currentMNHosp.FLstMsgImportNzis.Add(msg);
         currentMNHosp.NRN := CurrentNrn;
         currentMNHosp.PregledNRN := lstRHosp[i].PRecord.BaseOn;
         lstRHosp[i].MNHosp := currentMNHosp;
       end
       else
       begin
         currentMNHosp.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TNzisImport.AddNewPatXXX;
var
  i: Integer;
  msg: TNzisReqRespItem;
  preg: TRealPregledNewItem;
  pat: TRealPatientNewItem;
  addr: TRealAddresItem;
  CurrentEgn: string;
  currentPat: TRealPatientNewItem;
begin
  msgColl.CollPreg.SortByPatEGN;
  CurrentEgn := 'aaaaaaaaaaaaaaaaaaaa';
  currentPat := nil;
  for i := 0 to msgColl.CollPreg.Count - 1 do
  begin
    preg := msgColl.CollPreg.Items[i];
    if preg.PatEgn = '' then
      Continue;
    if preg.FLstMsgImportNzis.Count = 0 then Continue;
    if preg.Fpatient = nil then
    begin
      if CurrentEgn <> preg.PatEgn then
      begin
        pat := TRealPatientNewItem(msgColl.CollPat.Add);
        pat.DataPos := 0;
        addr := TRealAddresItem.Create(nil);
        addr.DataPos := 0;
        pat.FAdresi.Add(addr);
        preg.Fpatient := pat;
        if preg.NRN = '252462095FD4' then
        begin

        end;
        pat.FPregledi.Add(preg);
        pat.PatEGN := preg.PatEgn;
        CurrentEgn := preg.PatEgn;
        currentPat := pat;
      end
      else
      begin
        preg.Fpatient := currentPat;
        if preg.NRN = '252462095FD4' then
        begin

        end;
        currentPat.FPregledi.Add(preg);
      end;
    end;
  end;
end;

procedure TNzisImport.AddNewPreg;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentPreg: TRealPregledNewItem;
begin
  msgColl.SortListByNRN(LstXXXX);
  CurrentNrn := '';
  for i := 0 to LstXXXX.Count - 1 do
  begin
    msg := LstXXXX[i];
    if msg.Preg = nil then
    begin
       if CurrentNrn <> LstXXXX[i].PRecord.NRN then
       begin
         currentPreg := TRealPregledNewItem(msgColl.CollPreg.Add);
         CurrentNrn := LstXXXX[i].PRecord.NRN;
         currentPreg.FLstMsgImportNzis.Add(msg);
         currentPreg.NRN := CurrentNrn;
         if msg.PRecord.msgNom in[3, 13] then
         begin
           currentPreg.COPIED_FROM_NRN := msg.PRecord.BaseOn;
         end;
         LstXXXX[i].Preg := currentPreg;
         if msg.PRecord.msgNom in [1, 13] then
         begin
           currentPreg.PatEgn := msg.PRecord.patEgn;
         end;


       end
       else
       begin
         currentPreg.FLstMsgImportNzis.Add(msg);
         if msg.PRecord.msgNom in [1, 13] then
         begin
           currentPreg.PatEgn := msg.PRecord.patEgn;
         end;
         if msg.PRecord.msgNom in[3, 13] then
         begin
           currentPreg.COPIED_FROM_NRN := msg.PRecord.BaseOn;
         end;
       end;
    end;
  end;
end;

procedure TNzisImport.AddNzisImport(FileName: TFileName);
var
  List: TStringList;
  i, j: Integer;
  cnt: Integer;
  startX, endX, signX: Integer;
  Arrstr: TArray<string>;
  p1, p2, pEnd: Integer;

  XNom1, XNom2: Byte;

  msg: TNzisReqRespItem;

  lstMsgType: TStringList;

begin
  Stopwatch := TStopwatch.StartNew;
  //if dlgOpenNZIS.Execute then  // openDlg
  begin
    if msgColl = nil then
    begin
      msgColl := TNzisReqRespColl.Create(TNzisReqRespItem);
    end
    else
    begin
      msgColl.Clear;
    end;
    List := TStringList.Create;
    lstMsgType := TStringList.Create;
    //fileName := 'C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\';
    //fileName := fileName + '1900000356org.txt';
    //fileName := 'D:\HaknatFerdow\0200000824.txt';
    //fileName := dlgOpenNZIS.FileName;
    List.LoadFromFile(fileName);

    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add(Format('зареждане на файла: %f', [Elapsed.TotalMilliseconds]));

    Stopwatch := TStopwatch.StartNew;
    Arrstr := List.Text.Split(['<?','?>']);
    List.Free;
    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add(Format('разделяне на файла на съобщения за %f ', [Elapsed.TotalMilliseconds]));


    Stopwatch := TStopwatch.StartNew;
    for i := 1 to Length(Arrstr)- 1 do
    begin

      if (i mod 300) = 0 then
      begin
        FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/Length(Arrstr));
        FmxRoleBar.rctProgres.EndUpdate;
        Application.ProcessMessages;
      end;
      p1 := Pos('<nhis:messageType value="', Arrstr[i]) + 25 ;
      if p1 = 25 then
        Continue;
      p2 := Pos('<nhis:messageId value="', Arrstr[i]) + 23 ;
      lstMsgType.Add(Copy(arrstr[i],p1 , 4));
      XNom1 := StrToInt(Copy(arrstr[i],p1 + 1, 3));
      msg := TNzisReqRespItem(msgColl.Add);
      pEnd := Pos('</nhis:message>', Arrstr[i]) + 15 ;
      SetLength(Arrstr[i], pEnd);
      New(msg.PRecord);
      msg.PRecord.setProp := [NzisReqResp_REQ, NzisReqResp_messageId, NzisReqResp_msgNom, NzisReqResp_Logical];
      msg.PRecord.REQ := '<?xml version="1.0" encoding="UTF-8"?>' + #13#10 +  Arrstr[i];
      msg.PRecord.messageId := Copy(arrstr[i],p2, 36);
      msg.PRecord.msgNom := XNom1;
      case arrstr[i][p1] of
        'X':
        begin
          msg.PRecord.Logical := [Is_X];
        end;
        'R': msg.PRecord.Logical := [Is_R];
        'P': msg.PRecord.Logical := [Is_P];
        'I': msg.PRecord.Logical := [Is_I];
        'H': msg.PRecord.Logical := [Is_H];
        'C': msg.PRecord.Logical := [Is_C];
      end;
    end;
    lstMsgType.Free;
    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add(Format('запис на съобщенията в колекцията за %f ', [Elapsed.TotalMilliseconds]));
    mmoTest.Lines.Add('msgColl ' + IntToStr(msgColl.Count));
  end;
end;

constructor TNzisImport.create;
begin
  inherited create;
  FnzisXml := Nzis.XMLHelper.TNzisXMLHelper.Create;

  msgColl := TNzisReqRespColl.Create(TNzisReqRespItem);
  FnzisXml.msgColl := msgColl;
  LstXXXX := TList<TNzisReqRespItem>.Create;
  LstRMDN := TList<TNzisReqRespItem>.Create;
  LstRMN := TList<TNzisReqRespItem>.Create;
  lstRVSD := TList<TNzisReqRespItem>.Create;
  lstRHosp := TList<TNzisReqRespItem>.Create;
  lstRMedExpert := TList<TNzisReqRespItem>.Create;
  LstRIncMN := TList<TRealINC_NAPRItem>.Create;
end;



destructor TNzisImport.destroy;
begin
  FreeAndNil(FnzisXml);
  FreeAndNil(msgColl);
  FreeAndNil(LstXXXX);
  FreeAndNil(LstRIncMN);
  FreeAndNil(LstRMDN);
  FreeAndNil(LstRMN);
  FreeAndNil(lstRVSD);
  FreeAndNil(lstRHosp);
  FreeAndNil(lstRMedExpert);
end;

procedure TNzisImport.ExportNzisToDB;
var
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  node, nodePat: PVirtualNode;
  data: PAspRec;
  collPatExport: TRealPatientNewColl;
begin
  Stopwatch := TStopwatch.StartNew;
  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  collPatExport := TRealPatientNewColl.Create(TRealPatientNewItem);
  collPatExport.Buf := AspectsHipFile.Buf;
  collPatExport.posData := AspectsHipFile.FPosData;
  while linkPos < FPosLinkData do
  begin
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := Pointer(PByte(node)+ lenNode);
    if data.vid = vvPatient then
    begin
      if collPatExport.getintMap(data.DataPos, Word(PatientNew_ID)) = 0 then //now pacient
      begin
        mmoTest.Lines.Add('нов пациент ' + collPatExport.getAnsiStringMap(data.DataPos, Word(PatientNew_EGN)));
      end
      else
      begin

      end;
    end;
    inc(linkPos, LenData);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'exportDB ' + FloatToStr(Elapsed.TotalMilliseconds));

end;

procedure TNzisImport.Delete99;
var
  i: Integer;
begin
  for i := msgColl.Count - 1 downto 0 do
  begin
    if (i mod 300) = 0 then
    begin
      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/msgColl.Count);
      FmxRoleBar.rctProgres.EndUpdate;
      Application.ProcessMessages;
    end;
    if string(msgColl.Items[i].PRecord.RESP).Contains('<nhis:messageType value="X099"') then
      msgColl.Delete(i);
  end;
end;

procedure TNzisImport.FillADBInMsgColl;
var
  data, dataAction, dataPat, dataPreg: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode, patNode: PVirtualNode;
  node: PVirtualNode;

  pat: TRealPatientNewItem;
  addr: TRealAddresItem;
  preg: TRealPregledNewItem;
  diag: TRealDiagnosisItem;
  mdn: TRealMDNItem;
  IncMN: TRealINC_NAPRItem;

begin
  msgColl.CollPat.posData := AspectsHipFile.FPosData;
  msgColl.CollPat.buf := AspectsHipFile.Buf;
  msgColl.CollPreg.posData := AspectsHipFile.FPosData;
  msgColl.CollPreg.buf := AspectsHipFile.Buf;
  msgColl.CollIncMN.posData := AspectsHipFile.FPosData;
  msgColl.CollIncMN.buf := AspectsHipFile.Buf;
  msgColl.CollIncDoc.posData := AspectsHipFile.FPosData;
  msgColl.CollIncDoc.buf := AspectsHipFile.Buf;
  msgColl.CollMdn.posData := AspectsHipFile.FPosData;
  msgColl.CollMdn.buf := AspectsHipFile.Buf;

  bufLink := AspectsLinkPatPregFile.Buf;
  begin
    linkPos := 100;
    pCardinalData := pointer(PByte(bufLink));
    FPosLinkData := pCardinalData^;
    while linkpos < FPosLinkData do
    begin
      RunNode := pointer(PByte(bufLink) + linkpos);
      data := pointer(PByte(RunNode) + lenNode);
      case data.vid of
        vvPatient:
        begin
          pat := TRealPatientNewItem(msgColl.CollPat.Add);
          pat.DataPos := Data.DataPos;
          pat.PatEGN := msgColl.CollPat.getAnsiStringMap(Data.DataPos, word(PatientNew_EGN));
          pat.FNode := RunNode;
        end;
        vvAddres:
        begin
          addr := TRealAddresItem.Create(nil);
          addr.DataPos := Data.DataPos;
          //pat.FAdresi.Add(addr);
        end;
        vvPregled:
        begin
          if msgColl.CollPreg.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN)) <> '' then
          begin
            dataPat := pointer(PByte(RunNode.Parent) + lenNode);
            if dataPat.vid = vvIncMN then
              dataPat := pointer(PByte(RunNode.Parent.Parent) + lenNode);


            preg := TRealPregledNewItem(msgColl.CollPreg.Add);
            preg.DataPos := Data.DataPos;
            preg.nrn := msgColl.CollPreg.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
            preg.PatEGN := msgColl.CollPat.getAnsiStringMap(DataPat.DataPos, word(PatientNew_EGN));
            preg.FNode := RunNode;
          end;
        end;
        vvDiag:
        begin
          //if msgColl.collDiag.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN)) <> '' then
          begin
            datapreg := pointer(PByte(RunNode.Parent) + lenNode);
            diag := TRealDiagnosisItem(msgColl.collDiag.Add);
            diag.DataPos := Data.DataPos;
            diag.Node := RunNode;
            diag.PregNode := RunNode.Parent;
          end;
        end;
        vvmdn:
        begin
          if msgColl.CollMDN.getAnsiStringMap(Data.DataPos, word(MDN_NRN)) <> '' then
          begin
            dataPreg := pointer(PByte(RunNode.Parent) + lenNode);

            mdn := TRealMDNItem(msgColl.CollMdn.Add);
            mdn.DataPos := Data.DataPos;
            mdn.NRN :=  msgColl.CollMDN.getAnsiStringMap(Data.DataPos, word(MDN_NRN));
            mdn.PregledNRN := msgColl.CollPat.getAnsiStringMap(DataPreg.DataPos, word(PregledNew_NRN_LRN));
            mdn.LinkNode := RunNode;
          end;
        end;
        vvIncMN:
        begin
          if msgColl.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN)) <> '' then
          begin
            dataPat := pointer(PByte(RunNode.Parent) + lenNode);

            IncMN := TRealINC_NAPRItem(msgColl.CollIncMN.Add);
            IncMN.DataPos := Data.DataPos;
            IncMN.NRN :=  msgColl.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN));
            IncMN.PatEgn := msgColl.CollPat.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));
            IncMN.LinkNode := RunNode;
          end;
        end;

      end;
      Inc(linkPos, LenData);
    end;
  end;
end;

procedure TNzisImport.FillAddrInPat;
var
  iAddr, iPac: integer;
begin
  msgColl.collAddres.SortByEkatte;
  msgColl.CollPat.SortByPatEGN;
  Stopwatch := TStopwatch.StartNew;
  iAddr := 0;
  iPac := 0;
  while (iAddr < msgColl.collAddres.Count) and (ipac < msgColl.CollPat.Count) do
  begin
    if msgColl.collAddres.Items[iAddr].Ekatte = msgColl.CollPat.Items[iPac].Ekatte then
    begin
      //if msgColl.collAddres.Items[iAddr].FLstMsgImportNzis.Count > 0 then
//      begin
//        if msgColl.collAddres.Items[iAddr].NRN = '252462095FD4' then
//        begin
//
//        end;
//        msgColl.CollPat.Items[iPac].FPregledi.Add(msgColl.CollPreg.Items[iAddr]);
//        msgColl.collAddres.Items[iAddr].FPatient := msgColl.CollPat.Items[iPac];
//        //msgColl.CollPreg.Items[iamb].FPatient
//      end;
      inc(iAddr);
    end
    else if msgColl.collAddres.Items[iAddr].Ekatte > msgColl.CollPat.Items[iPac].Ekatte then
    begin
      begin
        inc(iPac);

      end;
    end
    else if msgColl.collAddres.Items[iAddr].Ekatte < msgColl.CollPat.Items[iPac].Ekatte then
    begin
      inc(iAddr);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillAddrXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillDiagInPreg;
var
  iDiag, iAmb: integer;
begin
  msgColl.CollPreg.SortByNode;
  msgColl.collDiag.SortByPregNode;
  Stopwatch := TStopwatch.StartNew;
  iDiag := 0;
  iAmb := 0;
  while (iDiag < msgColl.collDiag.Count) and (iAmb < msgColl.CollPreg.Count) do
  begin
    if msgColl.collDiag.Items[iDiag].PregNode = msgColl.CollPreg.Items[iAmb].FNode then
    begin
      //if msgColl.collDiag.Items[iDiag].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPreg.Items[iAmb].FDiagnosis.Add(msgColl.collDiag.Items[iDiag]);
        //msgColl.collDiag.Items[iDiag].FPregled := msgColl.CollPreg.Items[iAmb];
      end;
      inc(iDiag);
    end
    else if Cardinal(msgColl.collDiag.Items[iDiag].PregNode) > Cardinal(msgColl.CollPreg.Items[iAmb].FNode) then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if Cardinal(msgColl.collDiag.Items[iDiag].PregNode) < Cardinal(msgColl.CollPreg.Items[iAmb].FNode) then
    begin
      inc(iDiag);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPregXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillIncDoctor;
var
  i: Integer;
  incDoc: TRealOtherDoctorItem;
begin
  for i := 0 to CollOtherDoctor.Count - 1 do
  begin
    incDoc := TRealOtherDoctorItem(msgColl.CollIncDoc.Add);
    incDoc.DataPos := CollOtherDoctor.Items[i].DataPos;
  end;
end;

procedure TNzisImport.FillIncDoctorInIncNapr;
begin

end;

procedure TNzisImport.FillMsgRIncMNInIncMN;
var
  iIncMN, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  //msgColl.SortListByNRN(LstRIncMN);
  msgColl.CollIncMN.SortLstByNRN(LstRIncMN);
  msgColl.CollIncMN.SortByNrn;
  Stopwatch := TStopwatch.StartNew;
  iIncMN := 0;
  iMsg := 0;
  while (iIncMN < msgColl.CollIncMN.Count) and (iMsg < LstRIncMN.Count) do
  begin
    if LstRIncMN[iMsg].NRN = '25244A01E0B6' then
    begin
      LstRIncMN[iMsg].NRN := '25244A01E0B6'
    end;
    if msgColl.CollIncMN.Items[iIncMN].NRN = LstRIncMN[iMsg].NRN then
    begin
      msg := TNzisReqRespItem (LstRIncMN[iMsg].msg);
      msg.IncMN := msgColl.CollIncMN.Items[iIncMN];
      msgColl.CollIncMN.Items[iIncMN].FLstMsgImportNzis.Add(msg);
      inc(iIncMN);
    end
    else if msgColl.CollIncMN.Items[iIncMN].NRN > LstRIncMN[iMsg].NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if msgColl.CollIncMN.Items[iIncMN].NRN < LstRIncMN[iMsg].NRN then
    begin
      inc(iIncMN);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMsgIn IncXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillMsgRMdnInMdn;
var
  iMdn, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  msgColl.SortListByNRN(LstRMDN);
  msgColl.CollMdn.SortByNrn;
  Stopwatch := TStopwatch.StartNew;
  iMdn := 0;
  iMsg := 0;
  while (iMdn < msgColl.CollMdn.Count) and (iMsg < LstRMDN.Count) do
  begin
    if msgColl.CollMdn.Items[iMdn].NRN = LstRMDN[iMsg].PRecord.NRN then
    begin

      msg := LstRMDN[iMsg];
      msg.Mdn := msgColl.CollMdn.Items[iMdn];
      if msg.PRecord.msgNom = 7 then
      begin

      end;
      msgColl.CollMdn.Items[iMdn].FLstMsgImportNzis.Add(msg);
      inc(iMsg);
    end
    else if msgColl.CollMdn.Items[iMdn].NRN > LstRMDN[iMsg].PRecord.NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if msgColl.CollMdn.Items[iMdn].NRN < LstRMDN[iMsg].PRecord.NRN then
    begin
      inc(iMdn);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  VtrImport.EndUpdate;
  mmotest.Lines.Add( 'FillMsgRMdnInMdn ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillMsgXXXInPregled;
var
  iPreg, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  msgColl.SortListByNRN(LstXXXX);
  msgColl.CollPreg.IndexValue(TPregledNewItem.TPropertyIndex.PregledNew_NRN_LRN);
  msgColl.CollPreg.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iPreg := 0;
  iMsg := 0;
  while (iPreg < msgColl.CollPreg.Count) and (iMsg < LstXXXX.Count) do
  begin
    if msgColl.CollPreg.Items[iPreg].IndexAnsiStr1 = LstXXXX[iMsg].PRecord.NRN then
    begin

      msg := LstXXXX[iMsg];
      msg.preg := msgColl.CollPreg.Items[iPreg];
      //if msg.PRecord.msgNom = 3 then
//      begin
//        msgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN := msg.PRecord.BaseOn;
//      end;
      msgColl.CollPreg.Items[iPreg].FLstMsgImportNzis.Add(msg);
      inc(iMsg);
    end
    else if msgColl.CollPreg.Items[iPreg].IndexAnsiStr1 > LstXXXX[iMsg].PRecord.NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if msgColl.CollPreg.Items[iPreg].IndexAnsiStr1 < LstXXXX[iMsg].PRecord.NRN then
    begin
      inc(iPreg);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  VtrImport.EndUpdate;
  mmotest.Lines.Add( 'fillMsgInPatXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillPregInPat;
var
  iamb, iPac: integer;
begin
  msgColl.CollPreg.SortByPatEGN;
  msgColl.CollPat.SortByPatEGN;
  Stopwatch := TStopwatch.StartNew;
  iamb := 0;
  iPac := 0;
  while (iamb < msgColl.CollPreg.Count) and (ipac < msgColl.CollPat.Count) do
  begin
    if msgColl.CollPreg.Items[iamb].PatEgn = msgColl.CollPat.Items[iPac].PatEgn then
    begin
      if msgColl.CollPreg.Items[iamb].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPat.Items[iPac].FPregledi.Add(msgColl.CollPreg.Items[iamb]);
        msgColl.CollPreg.Items[iamb].FPatient := msgColl.CollPat.Items[iPac];
        //msgColl.CollPreg.Items[iamb].FPatient
      end;
      inc(iamb);
    end
    else if msgColl.CollPreg.Items[iamb].PatEgn > msgColl.CollPat.Items[iPac].PatEgn then
    begin
      begin
        inc(iPac);

      end;
    end
    else if msgColl.CollPreg.Items[iamb].PatEgn < msgColl.CollPat.Items[iPac].PatEgn then
    begin
      inc(iamb);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPregXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillPregledInIncMN;
var
  iPreg, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
  DummyList: TList<RealObj.RealHipp.TRealINC_NAPRItem>;
  Dummy: RealObj.RealHipp.TRealINC_NAPRItem;
begin
  msgColl.CollIncMN.SortLstByNRN(LstRIncMN);
  msgColl.CollPreg.SortByCopyed;
  Stopwatch := TStopwatch.StartNew;
  iPreg := 0;
  iMsg := 0;

 // DummyList := nil;
//  if False then
//    Dummy := DummyList.Items[0]; // Принуждава Delphi да задържи GetItem
  while (iPreg < msgColl.CollPreg.Count) and (iMsg < LstRIncMN.Count) do
  begin
    if LstRIncMN.Items[iMsg].nrn = '25244905918D' then
    begin
      LstRIncMN.Items[iMsg].nrn := '25244905918D';
    end;
    if msgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN = '' then
    begin
      inc(iPreg);
      Continue;
    end;
    //Caption := LstRIncMN.items[iMsg].nrn;
    if msgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN = LstRIncMN.Items[iMsg].nrn then
    begin
      LstRIncMN[iMsg].FPregledi.Add(msgColl.CollPreg.Items[iPreg]);
      msgColl.CollPreg.Items[iPreg].Fpatient.FIncMNs.Add(LstRIncMN.Items[iMsg]);
      msgColl.CollPreg.Items[iPreg].FIncMN := LstRIncMN[iMsg];
      inc(iMsg);
    end
    else if msgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN > LstRIncMN[iMsg].nrn then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if msgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN < LstRIncMN[iMsg].nrn then
    begin
      inc(iPreg);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillpregInIncXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillReferalMdnInPreg;
var
  iMdn, iAmb: integer;
begin
  msgColl.CollPreg.SortByNrn;
  msgColl.CollMdn.SortByPregledNRN;
  Stopwatch := TStopwatch.StartNew;
  iMdn := 0;
  iAmb := 0;
  while (iMdn < msgColl.CollMdn.Count) and (iAmb < msgColl.CollPreg.Count) do
  begin
    if msgColl.CollMdn.Items[iMdn].PregledNRN = msgColl.CollPreg.Items[iAmb].NRN then
    begin
      if msgColl.CollMdn.Items[iMdn].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPreg.Items[iAmb].FMdns.Add(msgColl.CollMdn.Items[iMdn]);
        msgColl.CollMdn.Items[iMdn].FPregled := msgColl.CollPreg.Items[iAmb];
      end;
      inc(iMdn);
    end
    else if msgColl.CollMdn.Items[iMdn].PregledNRN > msgColl.CollPreg.Items[iAmb].NRN then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if msgColl.CollMdn.Items[iMdn].PregledNRN < msgColl.CollPreg.Items[iAmb].NRN then
    begin
      inc(iMdn);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPregXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillReferalMn3InPreg;
var
  iMn3, iAmb: integer;
begin
  msgColl.CollPreg.SortByNrn;
  msgColl.CollMN3.SortByPregledNRN;
  Stopwatch := TStopwatch.StartNew;
  iMn3 := 0;
  iAmb := 0;
  while (iMn3 < msgColl.CollMN3.Count) and (iAmb < msgColl.CollPreg.Count) do
  begin
    if msgColl.CollMN3.Items[iMn3].PregledNRN = msgColl.CollPreg.Items[iAmb].NRN then
    begin
      if msgColl.CollMN3.Items[iMn3].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPreg.Items[iAmb].FMNs3A.Add(msgColl.CollMN3.Items[iMn3]);
        msgColl.CollMN3.Items[iMn3].FPregled := msgColl.CollPreg.Items[iAmb];
      end;
      inc(iMn3);
    end
    else if msgColl.CollMN3.Items[iMn3].PregledNRN > msgColl.CollPreg.Items[iAmb].NRN then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if msgColl.CollMN3.Items[iMn3].PregledNRN < msgColl.CollPreg.Items[iAmb].NRN then
    begin
      inc(iMn3);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMN3 ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillReferalMnExpertInPreg;
var
  iMnLKK, iAmb: integer;
begin
  msgColl.CollPreg.SortByNrn;
  msgColl.CollMnExpert.SortByPregledNRN;
  Stopwatch := TStopwatch.StartNew;
  iMnLKK := 0;
  iAmb := 0;
  while (iMnLKK < msgColl.CollMnExpert.Count) and (iAmb < msgColl.CollPreg.Count) do
  begin
    if msgColl.CollMnExpert.Items[iMnLKK].PregledNRN = msgColl.CollPreg.Items[iAmb].NRN then
    begin
      if msgColl.CollMnExpert.Items[iMnLKK].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPreg.Items[iAmb].FMNsLKK.Add(msgColl.CollMnExpert.Items[iMnLKK]);
        msgColl.CollMnExpert.Items[iMnLKK].FPregled := msgColl.CollPreg.Items[iAmb];
      end;
      inc(iMnLKK);
    end
    else if msgColl.CollMnExpert.Items[iMnLKK].PregledNRN > msgColl.CollPreg.Items[iAmb].NRN then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if msgColl.CollMnExpert.Items[iMnLKK].PregledNRN < msgColl.CollPreg.Items[iAmb].NRN then
    begin
      inc(iMnLKK);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMNLKK ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillReferalMnHospInPreg;
var
  iMnHosp, iAmb: integer;
begin
  msgColl.CollPreg.SortByNrn;
  msgColl.CollMnHosp.SortByPregledNRN;
  Stopwatch := TStopwatch.StartNew;
  iMnHosp := 0;
  iAmb := 0;
  while (iMnHosp < msgColl.CollMnHosp.Count) and (iAmb < msgColl.CollPreg.Count) do
  begin
    if msgColl.CollMnHosp.Items[iMnHosp].PregledNRN = msgColl.CollPreg.Items[iAmb].NRN then
    begin
      if msgColl.CollMnHosp.Items[iMnHosp].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPreg.Items[iAmb].FMNsHosp.Add(msgColl.CollMnHosp.Items[iMnHosp]);
        msgColl.CollMnHosp.Items[iMnHosp].FPregled := msgColl.CollPreg.Items[iAmb];
      end;
      inc(iMnHosp);
    end
    else if msgColl.CollMnHosp.Items[iMnHosp].PregledNRN > msgColl.CollPreg.Items[iAmb].NRN then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if msgColl.CollMnHosp.Items[iMnHosp].PregledNRN < msgColl.CollPreg.Items[iAmb].NRN then
    begin
      inc(iMnHosp);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMN3 ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillReferalMnInPreg;
var
  iMn, iAmb: integer;
begin
  msgColl.CollPreg.SortByNrn;
  msgColl.CollMN.SortByPregledNRN;
  Stopwatch := TStopwatch.StartNew;
  iMn := 0;
  iAmb := 0;
  while (iMn < msgColl.CollMN.Count) and (iAmb < msgColl.CollPreg.Count) do
  begin
    if msgColl.CollMN.Items[iMn].PregledNRN = msgColl.CollPreg.Items[iAmb].NRN then
    begin
      if msgColl.CollMN.Items[iMn].FLstMsgImportNzis.Count > 0 then
      begin
        msgColl.CollPreg.Items[iAmb].FMNs.Add(msgColl.CollMN.Items[iMn]);
        msgColl.CollMN.Items[iMn].FPregled := msgColl.CollPreg.Items[iAmb];
      end;
      inc(iMn);
    end
    else if msgColl.CollMN.Items[iMn].PregledNRN > msgColl.CollPreg.Items[iAmb].NRN then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if msgColl.CollMN.Items[iMn].PregledNRN < msgColl.CollPreg.Items[iAmb].NRN then
    begin
      inc(iMn);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMN ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TNzisImport.FillRespInReq;
var
  msgReq, msgResp: TNzisReqRespItem;
  i: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  msgColl.SortByMessageId_nom;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('sort :двойкуване за %f ', [Elapsed.TotalMilliseconds]));
  Stopwatch := TStopwatch.StartNew;
  for i := 1 to msgColl.Count - 1 do
  begin
    if (i mod 300) = 0 then
    begin
      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/msgColl.Count);
      FmxRoleBar.rctProgres.EndUpdate;
      Application.ProcessMessages;
    end;
    if msgColl.Items[i].PRecord.messageId = msgColl.Items[i - 1].PRecord.messageId then  // двойка са
    begin
      msgColl.Items[i - 1].PRecord.RESP := msgColl.Items[i].PRecord.REQ;
      //SetLength(msgColl.Items[i -1].PRecord.RESP, length(msgColl.Items[i - 1].PRecord.RESP)-2);
      //msgColl.Items[i - 1].PRecord.NRN := msgColl.Items[i].PRecord.NRN
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  for i := msgColl.Count - 1 downto 0 do
  begin
    if (i mod 300) = 0 then
    begin
      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/msgColl.Count);
      FmxRoleBar.rctProgres.EndUpdate;
      Application.ProcessMessages;
    end;
    if msgColl.Items[i].PRecord.RESP = '' then  // двойка са
    begin
      msgColl.Delete(i);
    end;
  end;

  mmoTest.Lines.Add(Format('двойкуване за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TNzisImport.ImportNzis(FileName: TFileName);
begin
  VtrImport.DefaultNodeHeight := 30;
  VtrImport.Header.AutoSizeIndex := 1;
  VtrImport.Header.Columns.Items[0].Width := 240;
  VtrImport.Header.AutoSizeIndex := 0;

  VtrImport.Header.Columns.Items[0].Tag := Integer(vvNzisMessages);



  AddNzisImport(FileName); // попълва колекцията от msg
  FillRespInReq;// намира и сдвоява двойките
  FillADBInMsgColl; // не са само пациентите, а и другите работи. Попълват се колекциите от каквото има в базата
  FillAddrInPat;//
  FillIncDoctor;

  LoopXml;// определя кое съобщение какво е и му попълва нещата. Попълва списъка със всички нрн-та за прегледи, направления....
  Delete99; // премахване на двойките със грешка в отговора


  FillMsgXXXInPregled;// след това нещо, може да са останали в лстХХХХ такива съобщения, които нямат НРН в базата
  FillMsgRIncMNInIncMN;// LstRIncMN- списък със всички евентуални входящи направления
  AddNewPreg;// търсим новите съобщения и попълваме с нови прегледи



  FillPregInPat;// след това нещо, може да са останали прегледи на пациенти, които ги няма в базата
  FillDiagInPreg;

  //FillIncMnInPatImport;// след това нещо, може да са останали прегледи на пациенти, които ги няма в базата
  AddNewPatXXX;// търсим новите
  // като имам всички прегледи сега трябва да намеря кои входящи направления са взети от лекаря. Трябва да е по басе-то
  FillPregledInIncMN;

  FillMsgRMdnInMdn; // попълва старите, които са в базата
  AddNewMdn;
  AddNewMN;
  AddNewMN3;
  AddNewMNHosp;
  AddNewMNExpert;
  FillReferalMdnInPreg; // мдн-тата в прегледите
  FillReferalMnInPreg; // мн-тата в прегледите
  FillReferalMn3InPreg; // мн3-тата в прегледите
  FillReferalMnHospInPreg; // мн-тата в прегледите
  FillReferalMnExpertInPreg; // мн3-тата в прегледите

  LoadTempVtrMSG4;

 // pgcTree.ActivePage := tsTempVTR;
//  pnlNzisMessages.Visible := True;
//  pnlNzisMessages.Height := pnlWork.Height - 30;
//  pnlTree.Width := 580;
end;

procedure TNzisImport.LoadTempVtrMSG4;
var
  msgID: string;
  i, j, k, m, CurrentI: Integer;
  pyrvi, wtori: Integer;
  vReq, vResp, vpat, vMsg, vPreg, vRun, vMdn, vIncMN, vIncDoc, vAddr, vdiag, vMn, vMn3, vMnHosp, vMnLkk: PVirtualNode;
  data, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  IncMN: TRealINC_NAPRItem;
  mdn: TRealMDNItem;
  mn: TRealBLANKA_MED_NAPRItem;
  mn3: TRealBLANKA_MED_NAPR_3AItem;
  mnHosp: TRealHOSPITALIZATIONItem;
  mnLkk: TRealEXAM_LKKItem;
  diag: TRealDiagnosisItem;
  //patNodes: TPatNodes;
  Dublikat: Boolean;
begin
  Stopwatch := TStopwatch.StartNew;
  VtrImport.NodeDataSize := SizeOf(tAspRec);
  VtrImport.BeginUpdate;
  VtrImport.Clear;

    vPatImportNzis := VtrImport.AddChild(nil, nil);
    data := VtrImport.GetNodeData(vPatImportNzis);
    data.vid := vvPatientNewRoot;
    data.index := -1;

    vImportNzis := VtrImport.AddChild(nil, nil);
    data := VtrImport.GetNodeData(vImportNzis);
    data.vid := vvNone;
    data.index := -1;

    vImportNzisPregled := VtrImport.AddChild(vImportNzis, nil);
    data := VtrImport.GetNodeData(vImportNzisPregled);
    data.vid := vvPregledRoot;
    data.index := -1;
    vImportNzisNapr := VtrImport.AddChild(vImportNzis, nil);
    data := VtrImport.GetNodeData(vImportNzisNapr);
    data.vid := vvMDN;
    data.index := -1;
    vImportNzisRec := VtrImport.AddChild(vImportNzis, nil);
    data := VtrImport.GetNodeData(vImportNzisRec);
    data.vid := vvRecepta;
    data.index := -1;
    vImportNzisImun := VtrImport.AddChild(vImportNzis, nil);
    data := VtrImport.GetNodeData(vImportNzisImun);
    data.vid := vvExamImun;
    data.index := -1;
    vImportNzisHosp := VtrImport.AddChild(vImportNzis, nil);
    data := VtrImport.GetNodeData(vImportNzisHosp);
    data.vid := vvHosp;
    data.index := -1;
    vImportNzisObshti := VtrImport.AddChild(vImportNzis, nil);
    data := VtrImport.GetNodeData(vImportNzisObshti);
    data.vid := vvNomenNzis;
    data.index := -1;

  for i := 0 to msgColl.CollPat.Count - 1 do
  begin
    pat := msgColl.CollPat.Items[i];
    if pat.FPregledi.Count = 0 then Continue;
    //if pat.FIncMNs.Count = 0 then Continue;

    vpat := VtrImport.AddChild(vPatImportNzis, nil);
    data := VtrImport.GetNodeData(vpat);
    data.vid := vvPatient;
    data.DataPos := pat.DataPos;
    data.index := i;

    vAddr := VtrImport.AddChild(vpat, nil);
    data := VtrImport.GetNodeData(vAddr);
    data.vid := vvAddres;
    data.DataPos := 0;
    data.index := i;

    for j := 0 to pat.FIncMNs.Count - 1 do
    begin
      IncMN := pat.FIncMNs[j];
      if IncMN.NRN = '25244A02FFD2' then
      begin

      end;
      if IncMN.FPregledi.Count = 0 then Continue;

      vIncMN := VtrImport.AddChild(vPat, nil);
      data := VtrImport.GetNodeData(vIncMN);
      data.vid := vvIncMN;
      data.DataPos := IncMN.DataPos;
      data.index := j;

      vIncDoc := VtrImport.AddChild(vIncMN, nil);
      data := VtrImport.GetNodeData(vIncDoc);
      data.vid := vvOtherDoctor;
      data.DataPos := IncMN.FIncDoctor.DataPos;
      data.index := IncMN.FIncDoctor.id;

      IncMN.LinkNode := vIncMN;
    end;
    for j := 0 to pat.FPregledi.Count - 1 do
    begin
      preg := pat.FPregledi[j];
      if preg.FLstMsgImportNzis.Count = 0 then Continue;
      if preg.NRN = '252462095FD4' then
      begin

      end;

      if (preg.FIncMN <> nil) and (preg.FIncMN.LinkNode <> nil) then
      begin
        vPreg := VtrImport.AddChild(preg.FIncMN.LinkNode, nil);
      end
      else
      begin
        vPreg := VtrImport.AddChild(vPat, nil);
      end;
      data := VtrImport.GetNodeData(vPreg);
      data.vid := vvPregled;
      data.DataPos := Preg.DataPos;
      data.index := j;

      for k := 0 to Preg.FLstMsgImportNzis.Count - 1 do
      begin
        msg := Preg.FLstMsgImportNzis[k];
        vMsg := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vMsg);
        data.vid := vvNzisMessages;
        data.index := k;
        msg.Node := vMsg;
      end;

      for k := 0 to preg.FDiagnosis.Count - 1 do
      begin
        diag := preg.FDiagnosis[k];
        vdiag := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vdiag);
        data.vid := vvDiag;
        data.DataPos := diag.DataPos;
        data.index := k;
        if diag.DataPos = 0 then
        begin
          //Self.Tag := Integer(vMdn);
          //Caption := 'ddd';
        end;
      end;
      for k := 0 to preg.FMdns.Count - 1 do
      begin
        mdn := preg.FMdns[k];
        vMdn := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vMdn);
        data.vid := vvMDN;
        data.DataPos := mdn.DataPos;
        data.index := k;
        if mdn.DataPos = 0 then
        begin
          mdn.LinkNode := vMdn;
          //Self.Tag := Integer(vMdn);
          //Caption := 'ddd';
        end;

        for m := 0 to mdn.FLstMsgImportNzis.Count - 1 do
        begin
          msg := mdn.FLstMsgImportNzis[m];
          vMsg := VtrImport.AddChild(vMdn, nil);
          data := VtrImport.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := m;
          msg.Node := vMsg;
        end;
      end;
      for k := 0 to preg.FMns.Count - 1 do
      begin
        mn := preg.FMns[k];
        vMn := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vMn);
        data.vid := vvMedNapr;
        data.DataPos := mn.DataPos;
        data.index := k;
        if mn.DataPos = 0 then
        begin
          mn.LinkNode := vMn;
          //Self.Tag := Integer(vMdn);
          //Caption := 'ddd';
        end;

        for m := 0 to mn.FLstMsgImportNzis.Count - 1 do
        begin
          msg := mn.FLstMsgImportNzis[m];
          vMsg := VtrImport.AddChild(vMn, nil);
          data := VtrImport.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := m;
          msg.Node := vMsg;
        end;
      end;
      for k := 0 to preg.FMNs3A.Count - 1 do
      begin
        mn3 := preg.FMNs3A[k];
        vMn3 := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vMn3);
        data.vid := vvMedNapr3A;
        data.DataPos := mn3.DataPos;
        data.index := k;
        if mn3.DataPos = 0 then
        begin
          mn3.LinkNode := vMn3;
        end;

        for m := 0 to mn3.FLstMsgImportNzis.Count - 1 do
        begin
          msg := mn3.FLstMsgImportNzis[m];
          vMsg := VtrImport.AddChild(vMn3, nil);
          data := VtrImport.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := m;
          msg.Node := vMsg;
        end;
      end;
      for k := 0 to preg.FMNsHosp.Count - 1 do
      begin
        mnHosp := preg.FMNsHosp[k];
        vMnHosp := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vMnHosp);
        data.vid := vvMedNaprHosp;
        data.DataPos := mnHosp.DataPos;
        data.index := k;
        if mnHosp.DataPos = 0 then
        begin
          mnHosp.LinkNode := vMnHosp;
        end;

        for m := 0 to mnHosp.FLstMsgImportNzis.Count - 1 do
        begin
          msg := mnHosp.FLstMsgImportNzis[m];
          vMsg := VtrImport.AddChild(vMnHosp, nil);
          data := VtrImport.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := m;
          msg.Node := vMsg;
        end;
      end;
      for k := 0 to preg.FMNsLKK.Count - 1 do
      begin
        mnLkk := preg.FMNsLKK[k];
        vMnLkk := VtrImport.AddChild(vPreg, nil);
        data := VtrImport.GetNodeData(vMnLkk);
        data.vid := vvMedNaprLkk;
        data.DataPos := mnLkk.DataPos;
        data.index := k;
        if mnLkk.DataPos = 0 then
        begin
          mnLkk.LinkNode := vMnLkk;
        end;

        for m := 0 to mnLkk.FLstMsgImportNzis.Count - 1 do
        begin
          msg := mnLkk.FLstMsgImportNzis[m];
          vMsg := VtrImport.AddChild(vMnLkk, nil);
          data := VtrImport.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := m;
          msg.Node := vMsg;
        end;
      end;
    end;
  end;

  VtrImport.FullExpand();
  VtrImport.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('LoadTempVtrMSG4 за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TNzisImport.LoopPat;
var
  i: Integer;
  RunPat, runInPat, runInIncMN, runMsg, runInMDN, runInMN : PVirtualNode;
  dataPat, dataMsg, dataInPat, dataInIncMN, dataPreg, dataInMdn, dataInMN: PAspRec;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  incMN: TRealINC_NAPRItem;
  msg: TNzisReqRespItem;
  diag: TRealDiagnosisItem;
  treeLink: PVirtualNode;
begin
  Stopwatch := TStopwatch.StartNew;
  RunPat := vPatImportNzis.FirstChild;
  while RunPat <> nil do
  begin
    dataPat := VtrImport.GetNodeData(RunPat);
    case dataPat.vid of
      vvPatient:
      begin
        pat := msgColl.CollPat.Items[datapat.index];
      end;
    end;

    runInPat := RunPat.FirstChild;
    while runInPat <> nil do
    begin
      dataInPat := VtrImport.GetNodeData(runInPat);
      case dataInPat.vid of
        vvPregled:
        begin
          preg := pat.FPregledi[dataInPat.index];
          dataPreg := VtrImport.GetNodeData(runInPat);
          runMsg := runInPat.FirstChild;
          while runMsg <> nil do
          begin
            dataMsg := VtrImport.GetNodeData(runMsg);
            case dataMsg.vid of
              vvMDN:
              begin

              end;
              vvNzisMessages:
              begin
                msg := preg.FLstMsgImportNzis[dataMsg.index];
                case msg.PRecord.msgNom of
                  1:  // x001
                  begin
                    if dataPat.DataPos = 0 then
                    begin
                      FnzisXml.FillX001InPat(msg, pat);
                      FnzisXml.FillX001InPreg(msg, preg);
                    end
                    else
                    if dataPreg.DataPos = 0 then
                    begin
                      FnzisXml.FillX001InPreg(msg, preg);
                    end;
                  end;
                  3: // x003
                  begin
                    if dataPreg.DataPos = 0 then
                    begin
                      FnzisXml.FillX003InPreg(msg, preg);
                    end;
                  end;
                  13:  // x013
                  begin
                    if dataPat.DataPos = 0 then
                    begin
                      FnzisXml.FillX013InPat(msg, pat);
                    end
                    else
                    if dataPreg.DataPos = 0 then
                    begin
                      FnzisXml.FillX013InPreg(msg, preg);
                    end;

                  end;
                end;
              end;
            end;
            runMsg := runMsg.NextSibling
          end;
          for i := 0 to  preg.FMdns.Count - 1 do
          begin
            runInMDN := preg.FMdns[i].LinkNode.FirstChild;
            while runInMDN <> nil do
            begin
              dataInMdn := VtrImport.GetNodeData(runInMDN);
              case dataInMdn.vid of
                vvNzisMessages:
                begin
                  msg := preg.FMdns[i].FLstMsgImportNzis[dataInMdn.index];
                  case msg.PRecord.msgNom of
                    1:// R001
                    begin
                      FnzisXml.FillR001InMDN(msg, preg.FMdns[i]);
                      FnzisXml.FillR002InMDN(msg, preg.FMdns[i]);
                    end;

                  end;
                end;
              end;
              runInMDN := runInMDN.NextSibling;
            end;
          end;
          for i := 0 to  preg.FMNs.Count - 1 do
          begin
            runInMN := preg.FMNs[i].LinkNode.FirstChild;
            while runInMN <> nil do
            begin
              dataInMN := VtrImport.GetNodeData(runInMN);
              case dataInMN.vid of
                vvNzisMessages:
                begin
                  msg := preg.FMNs[i].FLstMsgImportNzis[dataInMN.index];
                  case msg.PRecord.msgNom of
                    1:// R001
                    begin
                      FnzisXml.FillR001InMN(msg, preg.FMns[i]);
                      FnzisXml.FillR002InMN(msg, preg.FMns[i]);
                    end;

                  end;
                end;
              end;
              runInMN := runInMN.NextSibling;
            end;
          end;
          for i := 0 to  preg.FMNsHosp.Count - 1 do
          begin
            runInMN := preg.FMNsHosp[i].LinkNode.FirstChild;
            while runInMN <> nil do
            begin
              dataInMN := VtrImport.GetNodeData(runInMN);
              case dataInMN.vid of
                vvNzisMessages:
                begin
                  msg := preg.FMNsHosp[i].FLstMsgImportNzis[dataInMN.index];
                  case msg.PRecord.msgNom of
                    1:// R001
                    begin
                      FnzisXml.FillR001InMNHosp(msg, preg.FMNsHosp[i]);
                      FnzisXml.FillR002InMNHosp(msg, preg.FMNsHosp[i]);
                    end;

                  end;
                end;
              end;
              runInMN := runInMN.NextSibling;
            end;
          end;

          for i := 0 to  preg.FMNsLKK.Count - 1 do
          begin
            runInMN := preg.FMNsLKK[i].LinkNode.FirstChild;
            while runInMN <> nil do
            begin
              dataInMN := VtrImport.GetNodeData(runInMN);
              case dataInMN.vid of
                vvNzisMessages:
                begin
                  msg := preg.FMNsLKK[i].FLstMsgImportNzis[dataInMN.index];
                  case msg.PRecord.msgNom of
                    1:// R001
                    begin
                      FnzisXml.FillR001InMNLkk(msg, preg.FMNsLKK[i]);
                      FnzisXml.FillR002InMNLkk(msg, preg.FMNsLKK[i]);
                    end;

                  end;
                end;
              end;
              runInMN := runInMN.NextSibling;
            end;
          end;
        end;
        vvIncMN:
        begin
          incMN := pat.FIncMNs[dataInPat.index];
          runInIncMN := runInPat.FirstChild;
          while runInIncMN <> nil do
          begin
            dataInIncMN := VtrImport.GetNodeData(runInIncMN);
            case dataInIncMN.vid of
              vvPregled:
              begin
                preg := pat.FPregledi[dataInIncMN.index];
                dataPreg := VtrImport.GetNodeData(runInIncMN);
                runMsg := runInIncMN.FirstChild;
                while runMsg <> nil do
                begin
                  dataMsg := VtrImport.GetNodeData(runMsg);
                  case dataMsg.vid of
                    vvNzisMessages:
                    begin
                      msg := preg.FLstMsgImportNzis[dataMsg.index];
                      case msg.PRecord.msgNom of
                        1:  // x001
                        begin
                          if dataPat.DataPos = 0 then
                          begin
                            FnzisXml.FillX001InPat(msg, pat);
                            FnzisXml.FillX001InPreg(msg, preg);
                          end
                          else
                          if dataPreg.DataPos = 0 then
                          begin
                            FnzisXml.FillX001InPreg(msg, preg);
                          end;
                        end;
                        3: // x003
                        begin
                          if dataPreg.DataPos = 0 then
                          begin
                            FnzisXml.FillX003InPreg(msg, preg);

                          end;
                        end;
                        13:  // x013
                        begin
                          if dataPat.DataPos = 0 then
                          begin
                            FnzisXml.FillX013InPat(msg, pat);
                            FnzisXml.FillX013InPreg(msg, preg);
                          end
                          else
                          if dataPreg.DataPos = 0 then
                          begin
                            FnzisXml.FillX013InPreg(msg, preg);
                          end;
                        end;
                      end;
                    end;
                  end;
                  runMsg := runMsg.NextSibling
                end;
                for i := 0 to  preg.FMdns.Count - 1 do
                begin
                  runInMDN := preg.FMdns[i].LinkNode.FirstChild;
                  while runInMDN <> nil do
                  begin
                    dataInMdn := VtrImport.GetNodeData(runInMDN);
                    case dataInMdn.vid of
                      vvNzisMessages:
                      begin
                        msg := preg.FMdns[i].FLstMsgImportNzis[dataInMdn.index];
                        case msg.PRecord.msgNom of
                          1:// R001
                          begin
                            FnzisXml.FillR001InMDN(msg, preg.FMdns[i]);
                            FnzisXml.FillR002InMDN(msg, preg.FMdns[i]);
                          end;

                        end;
                      end;
                    end;
                    runInMDN := runInMDN.NextSibling;
                  end;
                end;
                for i := 0 to  preg.FMNs.Count - 1 do
                begin
                  runInMN := preg.FMNs[i].LinkNode.FirstChild;
                  while runInMN <> nil do
                  begin
                    dataInMN := VtrImport.GetNodeData(runInMN);
                    case dataInMN.vid of
                      vvNzisMessages:
                      begin
                        msg := preg.FMNs[i].FLstMsgImportNzis[dataInMN.index];
                        case msg.PRecord.msgNom of
                          1:// R001
                          begin
                            FnzisXml.FillR001InMN(msg, preg.FMns[i]);
                            FnzisXml.FillR002InMN(msg, preg.FMns[i]);
                          end;

                        end;
                      end;
                    end;
                    runInMN := runInMN.NextSibling;
                  end;
                end;
                for i := 0 to  preg.FMNsHosp.Count - 1 do
                begin
                  runInMN := preg.FMNsHosp[i].LinkNode.FirstChild;
                  while runInMN <> nil do
                  begin
                    dataInMN := VtrImport.GetNodeData(runInMN);
                    case dataInMN.vid of
                      vvNzisMessages:
                      begin
                        msg := preg.FMNsHosp[i].FLstMsgImportNzis[dataInMN.index];
                        case msg.PRecord.msgNom of
                          1:// R001
                          begin
                            FnzisXml.FillR001InMNHosp(msg, preg.FMNsHosp[i]);
                            FnzisXml.FillR002InMNHosp(msg, preg.FMNsHosp[i]);
                          end;

                        end;
                      end;
                    end;
                    runInMN := runInMN.NextSibling;
                  end;
                end;

                for i := 0 to  preg.FMNsLKK.Count - 1 do
                begin
                  runInMN := preg.FMNsLKK[i].LinkNode.FirstChild;
                  while runInMN <> nil do
                  begin
                    dataInMN := VtrImport.GetNodeData(runInMN);
                    case dataInMN.vid of
                      vvNzisMessages:
                      begin
                        msg := preg.FMNsLKK[i].FLstMsgImportNzis[dataInMN.index];
                        case msg.PRecord.msgNom of
                          1:// R001
                          begin
                            FnzisXml.FillR001InMNLkk(msg, preg.FMNsLKK[i]);
                            FnzisXml.FillR002InMNLkk(msg, preg.FMNsLKK[i]);
                          end;

                        end;
                      end;
                    end;
                    runInMN := runInMN.NextSibling;
                  end;
                end;
              end;
            end;
            runInIncMN := runInIncMN.NextSibling;
          end;
        end;
      end;
      //
      runInPat := runInPat.NextSibling;
    end;
    ProcAddNewPat(pat, treeLink);
    RunPat := RunPat.NextSibling;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('LoopPat за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TNzisImport.LoopXml;
var
  i, p, j: Integer;
  msg: TNzisReqRespItem;
  AmsgX001: msgX001.IXMLMessageType;
  AmsgX002: msgX002.IXMLMessageType;
  AmsgX003: msgX003.IXMLMessageType;
  AmsgX013: msgX013.IXMLMessageType;
  AmsgX014: X014.IXMLMessageType;

  AmsgR001: msgR001.IXMLMessageType;
  AmsgR002: msgR002.IXMLMessageType;
  AmsgR016: msgR016.IXMLMessageType;
  //
  oXml: IXMLDocument;
  StringStream: TStringStream;
  cnt: Integer;
  IncMn: TRealINC_NAPRItem;
  UinRCZSpec, rcz: string;
begin
  Stopwatch := TStopwatch.StartNew;
  cnt := 0;

  for i := 0 to msgColl.Count - 1 do
  begin
    if (i mod 300) = 0 then
    begin
      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/msgColl.Count);
      FmxRoleBar.rctProgres.EndUpdate;
      Application.ProcessMessages;
    end;
    msg := msgColl.Items[i];
    case byte(msg.PRecord.Logical) of
      1: // X
      begin
        case msg.PRecord.msgNom of
          1: // X001
          begin
            inc(cnt);
            AmsgX001 := FnzisXml.FmsgX001(msg);
            rcz := AmsgX001.Contents.Performer.PracticeNumber.Value;
            msg.PRecord.patEgn := AmsgX001.Contents.Subject.Identifier.Value;
            if (FRCZSelf = rcz) and string(msg.PRecord.RESP).Contains('<nhis:messageType value="X002"') then
            begin

              oXml := TXMLDocument.Create(nil);
              StringStream := TStringStream.Create(msg.PRecord.RESP, TEncoding.UTF8);
              try
                oXml.LoadFromStream(StringStream);

              finally
                StringStream.Free;
              end;
              oXml.Encoding := 'UTF-8';
              AmsgX002 := msgX002.Getmessage(oXml);
              msg.PRecord.LRN := AmsgX002.Contents.Lrn.Value;
              msg.PRecord.NRN := AmsgX002.Contents.NrnExamination.Value;

              LstXXXX.Add(msg);
              if oXml.Active then
              begin
                oXml.ChildNodes.Clear;
                oXml.Active := False;
              end;
              oxml := nil;
            end;
          end;

          3: // X003
          begin
            inc(cnt);
            oXml := TXMLDocument.Create(nil);
            StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
            try
              oXml.LoadFromStream(StringStream);

            finally
              StringStream.Free;
            end;
            oXml.Encoding := 'UTF-8';
            AmsgX003 := msgX003.Getmessage(oXml);
            msg.PRecord.NRN := AmsgX003.Contents.Examination.NrnExamination.Value;
            msg.PRecord.BaseOn := AmsgX003.Contents.Examination.BasedOn.Value;
            if msg.PRecord.NRN = '' then
            begin

            end;


            if oXml.Active then
            begin
              oXml.ChildNodes.Clear;
              oXml.Active := False;
            end;
            oxml := nil;

            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="X004"') then
            begin
              LstXXXX.Add(msg);
            end;
          end;
          7: // X007
          begin
            inc(cnt);
            p := Pos('<nhis:nrnExamination value="', msg.PRecord.REQ) + 28;
            msg.PRecord.NRN := Copy(msg.PRecord.REQ, p, 12);

            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="X008"') then
            begin
              LstXXXX.Add(msg);
            end;


            if msg.PRecord.NRN = '25184B01C9D7' then
            begin

            end;
          end;
          9: // X009
          begin
            inc(cnt);
            p := Pos('<nhis:nrnExamination value="', msg.PRecord.REQ) + 28;
            msg.PRecord.NRN := Copy(msg.PRecord.REQ, p, 12);

            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="X010"') then
            begin
              LstXXXX.Add(msg);
            end;


            if msg.PRecord.NRN = '25184B01C9D7' then
            begin

            end;
          end;
          13: // X013
          begin
            inc(cnt);
            oXml := TXMLDocument.Create(nil);
            StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
            try
              oXml.LoadFromStream(StringStream);

            finally
              StringStream.Free;
            end;
            oXml.Encoding := 'UTF-8';
            AmsgX013 := msgX013.Getmessage(oXml);
            rcz := AmsgX013.Contents.Performer.PracticeNumber.Value;
            msg.PRecord.patEgn := AmsgX013.Contents.Subject.Identifier.Value;
            msg.PRecord.BaseOn := AmsgX013.Contents.Examination.BasedOn.Value;

            if oXml.Active then
            begin
              oXml.ChildNodes.Clear;
              oXml.Active := False;
            end;
            oxml := nil;

            if (FRCZSelf = rcz) and string(msg.PRecord.RESP).Contains('<nhis:messageType value="X014"') then
            begin

              oXml := TXMLDocument.Create(nil);
              StringStream := TStringStream.Create(msg.PRecord.RESP, TEncoding.UTF8);
              try
                oXml.LoadFromStream(StringStream);

              finally
                StringStream.Free;
              end;
              oXml.Encoding := 'UTF-8';
              AmsgX014 := X014.Getmessage(oXml);
              msg.PRecord.LRN := AmsgX014.Contents.Lrn.Value;
              msg.PRecord.NRN := AmsgX014.Contents.NrnExamination.Value;
              if msg.PRecord.NRN = '251909005065' then
              begin

              end;

              LstXXXX.Add(msg);
              if oXml.Active then
              begin
                oXml.ChildNodes.Clear;
                oXml.Active := False;
              end;
              oxml := nil;
            end;
          end;
        end;
      end;

      2: //R
      begin
        case msg.PRecord.msgNom of
          1: // R001
          begin
            inc(cnt);
            oXml := TXMLDocument.Create(nil);
            StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
            try
              oXml.LoadFromStream(StringStream);

            finally
              StringStream.Free;
            end;
            oXml.Encoding := 'UTF-8';
            AmsgR001 := msgR001.Getmessage(oXml);
            msg.PRecord.BaseOn := AmsgR001.Contents.Referral.BasedOn.Value;
            msg.PRecord.category := AmsgR001.Contents.Referral.Category.Value;

            if oXml.Active then
            begin
              oXml.ChildNodes.Clear;
              oXml.Active := False;
            end;
            oxml := nil;

            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="R002"') then
            begin

              oXml := TXMLDocument.Create(nil);
              StringStream := TStringStream.Create(msg.PRecord.RESP, TEncoding.UTF8);
              try
                oXml.LoadFromStream(StringStream);

              finally
                StringStream.Free;
              end;
              oXml.Encoding := 'UTF-8';
              AmsgR002 := msgR002.Getmessage(oXml);
              msg.PRecord.LRN := AmsgR002.Contents.Lrn.Value;
              msg.PRecord.NRN := AmsgR002.Contents.NrnReferral.Value;
              if msg.PRecord.NRN = '251909005065' then
              begin

              end;
              case msg.PRecord.category[2] of
                '1': LstRMDN.Add(msg);
                '2': LstRMN.Add(msg);
                '3': lstRVSD.Add(msg);
                '4': lstRHosp.Add(msg);
                '5': lstRMedExpert.Add(msg);
              else
               // Caption := 'ddd';
              end;

              if oXml.Active then
              begin
                oXml.ChildNodes.Clear;
                oXml.Active := False;
              end;
              oxml := nil;
            end;
          end;
          13: // хоспитал
          begin

          end;
          15: // теглене на МН
          begin
            inc(cnt);
            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="R016"') then
            begin

              oXml := TXMLDocument.Create(nil);
              StringStream := TStringStream.Create(msg.PRecord.RESP, TEncoding.UTF8);
              try
                oXml.LoadFromStream(StringStream);
              finally
                StringStream.Free;
              end;
              oXml.Encoding := 'UTF-8';
              AmsgR016 := msgR016.Getmessage(oXml);
              for j := 0 to AmsgR016.Contents.Results.Count - 1 do
              begin
                IncMn := TRealINC_NAPRItem.Create(msgColl.CollIncMN);
                UinRCZSpec := AmsgR016.Contents.Results[j].Requester.Pmi.Value +
                              AmsgR016.Contents.Results[j].Requester.PracticeNumber.Value +
                              IntToStr(AmsgR016.Contents.Results[j].Requester.Qualification.Value);
                IncMn.FIncDoctor := msgColl.CollIncDoc.FindDoctorFromUinRCZSpec(UinRCZSpec);
                if IncMn.FIncDoctor = nil then
                begin
                  IncMn.FIncDoctor := TRealOtherDoctorItem(msgColl.CollIncDoc.Add);
                  New(IncMn.FIncDoctor.PRecord);
                  IncMn.FIncDoctor.PRecord.setProp := [];
                  IncMn.FIncDoctor.PRecord.UIN := AmsgR016.Contents.Results[j].Requester.Pmi.Value;
                  IncMn.FIncDoctor.PRecord.NOMER_LZ := AmsgR016.Contents.Results[j].Requester.PracticeNumber.Value;
                  IncMn.FIncDoctor.PRecord.SPECIALITY := AmsgR016.Contents.Results[j].Requester.Qualification.Value;
                  IncMn.FIncDoctor.PRecord.ID := (msgColl.CollIncDoc.Count - 1);
                end;

                New(IncMn.PRecord);
                IncMn.PRecord.setProp := [INC_NAPR_AMB_LIST_NRN, INC_NAPR_ISSUE_DATE, INC_NAPR_NRN, INC_NAPR_Logical];
                IncMn.PRecord.Logical := [];
                IncMn.PRecord.AMB_LIST_NRN := AmsgR016.Contents.Results[j].Referral.BasedOn.Value;
                IncMn.PRecord.ISSUE_DATE := StrToDate(AmsgR016.Contents.Results[j].Referral.AuthoredOn.Value, FS_Nzis);
                IncMn.PRecord.NRN := AmsgR016.Contents.Results[j].Referral.NrnReferral.Value;
                case AmsgR016.Contents.Results[j].Referral.Category.Value[2] of
                  //'1': include(IncMn.PRecord.Logical, category_R1);
                  '2':
                  begin
                    include(IncMn.PRecord.Logical, category_R2);
                    case AmsgR016.Contents.Results[j].Referral.Type_.Value of
                      1: include(IncMn.PRecord.Logical, INC_MED_NAPR_Ostro); 	//Остро заболяване или състояние извън останалите типове
                      2: include(IncMn.PRecord.Logical, INC_MED_NAPR_Hron); 	//Хронично заболяване, неподлежащо на диспансерно наблюдение
                      3: include(IncMn.PRecord.Logical, INC_MED_NAPR_Izbor);	//Избор на специалист за диспансерно наблюдение
                      4: include(IncMn.PRecord.Logical, INC_MED_NAPR_Disp);	//Диспансерно наблюдение
                      6: include(IncMn.PRecord.Logical, INC_MED_NAPR_Eksp);	//	Медицинска експертиза
                      7: include(IncMn.PRecord.Logical, INC_MED_NAPR_Prof);	//	Профилактика нa пълнолетни лица
                      8: include(IncMn.PRecord.Logical, INC_MED_NAPR_Iskane_Telk);	//	По искане на ТЕЛК (НЕЛК)
                      9: include(IncMn.PRecord.Logical, INC_MED_NAPR_Choice_Mother);	//	Избор на специалист за майчино здравеопазване
                     10: include(IncMn.PRecord.Logical, INC_MED_NAPR_Choice_Child);	//	Избор на специалист за детско здравеопазване
                     11: include(IncMn.PRecord.Logical, INC_MED_NAPR_PreChoice_Mother);	//	Преизбор на специалист за майчино здравеопазване
                     12: include(IncMn.PRecord.Logical, INC_MED_NAPR_PreChoice_Child);	//	Преизбор на специалист за детско здравеопазване
                     13: include(IncMn.PRecord.Logical, INC_MED_NAPR_Podg_Telk);	//	Подготовка за ТЕЛК
                     //14:	Скрийнинг
                    end;
                  end;
                  '3':
                  begin
                    include(IncMn.PRecord.Logical, category_R3);
                    case AmsgR016.Contents.Results[j].Referral.Type_.Value of
                       1: include(IncMn.PRecord.Logical, INC_MED_NAPR_Ostro); 	//Остро заболяване или състояние извън останалите типове
                      2: include(IncMn.PRecord.Logical, INC_MED_NAPR_Hron); 	//Хронично заболяване, неподлежащо на диспансерно наблюдение
                      3: include(IncMn.PRecord.Logical, INC_MED_NAPR_Izbor);	//Избор на специалист за диспансерно наблюдение
                      4: include(IncMn.PRecord.Logical, INC_MED_NAPR_Disp);	//Диспансерно наблюдение
                      6: include(IncMn.PRecord.Logical, INC_MED_NAPR_Eksp);	//	Медицинска експертиза
                      7: include(IncMn.PRecord.Logical, INC_MED_NAPR_Prof);	//	Профилактика нa пълнолетни лица
                      8: include(IncMn.PRecord.Logical, INC_MED_NAPR_Iskane_Telk);	//	По искане на ТЕЛК (НЕЛК)
                      9: include(IncMn.PRecord.Logical, INC_MED_NAPR_Choice_Mother);	//	Избор на специалист за майчино здравеопазване
                     10: include(IncMn.PRecord.Logical, INC_MED_NAPR_Choice_Child);	//	Избор на специалист за детско здравеопазване
                     11: include(IncMn.PRecord.Logical, INC_MED_NAPR_PreChoice_Mother);	//	Преизбор на специалист за майчино здравеопазване
                     12: include(IncMn.PRecord.Logical, INC_MED_NAPR_PreChoice_Child);	//	Преизбор на специалист за детско здравеопазване
                     13: include(IncMn.PRecord.Logical, INC_MED_NAPR_Podg_Telk);	//	Подготовка за ТЕЛК
                     //14:	Скрийнинг
                    end;
                  end;
                  //'4': include(IncMn.PRecord.Logical, category_R4);
                  '5': include(IncMn.PRecord.Logical, category_R5);
                end;
                IncMn.PatEgn := AmsgR016.Contents.Results[j].Subject.Identifier.Value;
                IncMn.nrn := AmsgR016.Contents.Results[j].Referral.NrnReferral.Value;
                if IncMn.nrn = '25244A01E0B6' then
                  IncMn.nrn := '25244A01E0B6';
                IncMn.BaseOn := AmsgR016.Contents.Results[j].Referral.BasedOn.Value;
                LstRIncMN.Add(IncMn);
                IncMn.msg := msg;
                IncMn.ResultIndex := msg.FIncMns.Add(IncMn);
                if j = 0 then
                begin
                  msg.PRecord.patEgn := AmsgR016.Contents.Results[j].Subject.Identifier.Value;
                end;
              end;

              if oXml.Active then
              begin
                oXml.ChildNodes.Clear;
                oXml.Active := False;
              end;
              oxml := nil;
            end;
          end;

          7:;
        else
          begin
            //Caption := 'ddd';
          end;

        end;

      end;// R
      4:;// CellText := Format('P%.3d', [node.Dummy]);
      8:;// CellText := Format('I%.3d', [node.Dummy]);
      16:;// CellText := Format('H%.3d', [node.Dummy]);
      32:;// CellText := Format('C%.3d', [node.Dummy]);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('LoopXml  кое какво е за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TNzisImport.SetCollDoctor(const Value: TRealDoctorColl);
begin
  FCollDoctor := Value;
  msgColl.CollDoctor := FCollDoctor;
end;

procedure TNzisImport.SetCollPractica(const Value: TPracticaColl);
var
  dataPos: Cardinal;
begin
  FCollPractica := Value;
  dataPos := FCollPractica.Items[0].DataPos;
  FRCZSelf := FCollPractica.getAnsiStringMap(dataPos, word(Practica_NOMER_LZ));
end;

procedure TNzisImport.SetNasMesto(const Value: TRealNasMestoAspects);
begin
  FNasMesto := Value;
  FnzisXml.FNasMesto := FNasMesto;
  FNasMesto.SortListByEkatte;
end;

procedure TNzisImport.SetVtrImport(const Value: TVirtualStringTreeHipp);
begin
  FVtrImport := Value;
  FVtrImport.OnGetText := vtrTempGetText;
  FVtrImport.OnChange := vtrTempChange;
end;

procedure TNzisImport.vtrTempChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataPat, dataPreg, dataMdn, dataParent, dataRun, dataMn, dataMnHosp, dataMnLkk: PAspRec;
  msg: TNzisReqRespItem;
  vReq, vResp, run: PVirtualNode;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  mdn: TRealMDNItem;
  mn: TRealBLANKA_MED_NAPRItem;
  mn3: TRealBLANKA_MED_NAPR_3AItem;
  mnHosp: TRealHOSPITALIZATIONItem;
  mnLKK: TRealEXAM_LKKItem;
  incMn: TRealINC_NAPRItem;
begin
  if node = nil then Exit;

  data := sender.GetNodeData(node);

  case data.vid of
    vvPregled:
    begin
      Stopwatch := TStopwatch.StartNew;
      if FmxImportNzisFrm = nil then
      begin
        FmxImportNzisFrm := TfrmImportNzis.Create(nil);
      end;
      FProcChangeWorkTS(tsFMXForm);
      dataParent := sender.GetNodeData(node.parent);
      case dataParent.vid of
        vvPatient: dataPat := sender.GetNodeData(node.parent);
        vvIncMN: dataPat := sender.GetNodeData(node.parent.parent);
      end;

      dataPreg := sender.GetNodeData(node);
      pat := msgColl.CollPat.Items[dataPat.index];

      preg := pat.FPregledi[dataPreg.index];
      run := Node.FirstChild;
      while run <> nil do
      begin
        dataRun := sender.GetNodeData(run);
        case dataRun.vid of
          vvNzisMessages:
          begin
            msg := TNzisReqRespItem(preg.FLstMsgImportNzis[dataRun.index]);
            case msg.PRecord.msgNom of
              1:
              begin
                FnzisXml.FillX001InPat(msg, pat);
                Break;
              end;
            end;
          end;
        end;
        run := run.NextSibling;
      end;
      if pat.DataPos = 0 then
      begin
        //pat.PRecord.FNAME := pat.NoteProf
      end;
      FmxImportNzisFrm.Pregled := preg;
      fmxCntrDyn.ChangeActiveForm(FmxImportNzisFrm);
      Elapsed := Stopwatch.Elapsed;
      mmoTest.Lines.Add( 'FmxImportNzisFrm ' + FloatToStr(Elapsed.TotalMilliseconds));
    end;
    vvIncMN:
    begin
      dataPat := sender.GetNodeData(node.parent);
      pat := msgColl.CollPat.Items[dataPat.index];
      incMn := pat.FIncMNs[data.index];
      msg := TNzisReqRespItem(incMn.msg);
      syndtNzisReq.Lines.Text := msg.PRecord.REQ;
      syndtNzisResp.Lines.Text := msg.PRecord.RESP;
    end;
    vvNzisMessages:
    begin
      dataParent := sender.GetNodeData(node.parent);
      case dataParent.vid of
        vvPregled:
        begin
          dataPat := sender.GetNodeData(node.Parent.parent);
          if dataPat.vid = vvIncMN then
            dataPat := sender.GetNodeData(node.Parent.parent.parent);
          dataPreg := sender.GetNodeData(node.Parent);
          pat := msgColl.CollPat.Items[dataPat.index];
          preg := pat.FPregledi[dataPreg.index];
          msg := TNzisReqRespItem(preg.FLstMsgImportNzis[data.index]);
          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
        end;
        vvmdn:
        begin
          dataPat := sender.GetNodeData(node.Parent.parent.parent);
          if dataPat.vid = vvIncMN then
            dataPat := sender.GetNodeData(node.Parent.parent.parent.parent);
          dataPreg := sender.GetNodeData(node.Parent.parent);
          dataMdn := sender.GetNodeData(node.Parent);
          pat := msgColl.CollPat.Items[dataPat.index];
          preg := pat.FPregledi[dataPreg.index];
          mdn := preg.FMdns[dataMdn.index];
          msg := TNzisReqRespItem(mdn.FLstMsgImportNzis[data.index]);
          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
        end;
        vvMedNapr:
        begin
          dataPat := sender.GetNodeData(node.Parent.parent.parent);
          if dataPat.vid = vvIncMN then
            dataPat := sender.GetNodeData(node.Parent.parent.parent.parent);
          dataPreg := sender.GetNodeData(node.Parent.parent);
          dataMn := sender.GetNodeData(node.Parent);
          pat := msgColl.CollPat.Items[dataPat.index];
          preg := pat.FPregledi[dataPreg.index];
          mn := preg.FMns[dataMn.index];
          msg := TNzisReqRespItem(mn.FLstMsgImportNzis[data.index]);
          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
        end;
        vvMedNapr3A:
        begin
          dataPat := sender.GetNodeData(node.Parent.parent.parent);
          if dataPat.vid = vvIncMN then
            dataPat := sender.GetNodeData(node.Parent.parent.parent.parent);
          dataPreg := sender.GetNodeData(node.Parent.parent);
          dataMn := sender.GetNodeData(node.Parent);
          pat := msgColl.CollPat.Items[dataPat.index];
          preg := pat.FPregledi[dataPreg.index];
          mn3 := preg.FMNs3A[dataMn.index];
          msg := TNzisReqRespItem(mn3.FLstMsgImportNzis[data.index]);
          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
        end;
        vvMedNaprHosp:
        begin
          dataPat := sender.GetNodeData(node.Parent.parent.parent);
          if dataPat.vid = vvIncMN then
            dataPat := sender.GetNodeData(node.Parent.parent.parent.parent);
          dataPreg := sender.GetNodeData(node.Parent.parent);
          dataMnHosp := sender.GetNodeData(node.Parent);
          pat := msgColl.CollPat.Items[dataPat.index];
          preg := pat.FPregledi[dataPreg.index];
          mnHosp := preg.FMNsHosp[dataMnHosp.index];
          msg := TNzisReqRespItem(mnHosp.FLstMsgImportNzis[data.index]);
          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
        end;
        vvMedNaprLkk:
        begin
          dataPat := sender.GetNodeData(node.Parent.parent.parent);
          if dataPat.vid = vvIncMN then
            dataPat := sender.GetNodeData(node.Parent.parent.parent.parent);
          dataPreg := sender.GetNodeData(node.Parent.parent);
          dataMnLkk := sender.GetNodeData(node.Parent);
          pat := msgColl.CollPat.Items[dataPat.index];
          preg := pat.FPregledi[dataPreg.index];
          mnLKK := preg.FMNsLKK[dataMnLkk.index];
          msg := TNzisReqRespItem(mnLKK.FLstMsgImportNzis[data.index]);
          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
        end;

      end;

    end;
  end;
end;

procedure TNzisImport.vtrTempGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataPat, dataPreg, dataMdn, DataParent, dataIncMN, dataMN, dataMN3, dataMNHosp, dataMNLkk: PAspRec;
  msg: TNzisReqRespItem;
  patLogical: TlogicalPatientNewSet;
  pat: TRealPatientNewItem;
  addr: TRealAddresItem;
  preg: TRealPregledNewItem;
  incMN: TRealINC_NAPRItem;
  mdn: TRealMDNItem;
  mn: TRealBLANKA_MED_NAPRItem;
  mn3: TRealBLANKA_MED_NAPR_3AItem;
  mnHosp: TRealHOSPITALIZATIONItem;
  mnLkk: TRealEXAM_LKKItem;
begin
  data := Sender.GetNodeData(node);
  case Column of
    0:
    begin
      if data.index = -1 then
      begin
        case data.vid of
          vvPregledRoot: CellText := 'Прегледи';
          vvMDN: CellText := 'Направления';
          vvRecepta: CellText := 'Рецепти';
          vvExamImun: CellText := 'Имунизации';
          vvHosp: CellText := 'Хоспитализации';
          vvNomenNzis: CellText := 'Общи';
          vvPatientNewRoot: CellText := 'Пациенти от импорта';
          vvPatient:
          begin
            CellText := 'ЕГН ' + msgColl.CollPat.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
          end;
          vvPregled:
          begin
            //preg := msgColl.CollPreg.Items[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := msgColl.CollPreg.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
            end
            else
            begin
              CellText := 'Нов преглед';
            end;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvMdn:
          begin
            dataPat := sender.GetNodeData(node.parent.parent);

            if dataPat.vid = vvPatient then
            begin
              dataPreg := sender.GetNodeData(node.parent);
              dataMdn := Sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mdn := preg.FMdns[dataMdn.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMdn.getAnsiStringMap(Data.DataPos, word(MDN_NRN));
              end
              else
              begin
                CellText := 'Ново МДН ' + mdn.NRN;
              end;
            end
            else
            begin
              dataPat := sender.GetNodeData(node.parent.parent.parent);
              dataPreg := sender.GetNodeData(node.parent);
              dataMdn := sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mdn := preg.FMdns[dataMdn.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMdn.getAnsiStringMap(Data.DataPos, word(MDN_NRN));
              end
              else
              begin
                CellText := 'Ново МДН ' + mdn.NRN;
              end;
            end;
          end;
          vvMedNapr:
          begin
            dataPat := sender.GetNodeData(node.parent.parent);

            if dataPat.vid = vvPatient then
            begin
              dataPreg := sender.GetNodeData(node.parent);
              dataMN := Sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mn := preg.FMns[dataMN.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMN.getAnsiStringMap(Data.DataPos, word(BLANKA_MED_NAPR_NRN));
              end
              else
              begin
                CellText := 'Ново МН ' + mn.NRN;
              end;
            end
            else
            begin
              dataPat := sender.GetNodeData(node.parent.parent.parent);
              dataPreg := sender.GetNodeData(node.parent);
              dataMn := sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mn := preg.FMns[dataMn.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMn.getAnsiStringMap(Data.DataPos, word(BLANKA_MED_NAPR_NRN));
              end
              else
              begin
                CellText := 'Ново МН ' + mn.NRN;
              end;
            end;
          end;
          vvMedNapr3A:
          begin
            dataPat := sender.GetNodeData(node.parent.parent);

            if dataPat.vid = vvPatient then
            begin
              dataPreg := sender.GetNodeData(node.parent);
              dataMN3 := Sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mn3 := preg.FMNs3A[dataMN3.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMN3.getAnsiStringMap(Data.DataPos, word(BLANKA_MED_NAPR_3A_NRN));
              end
              else
              begin
                CellText := 'Ново МН3333 ' + mn3.NRN;
              end;
            end
            else
            begin
              dataPat := sender.GetNodeData(node.parent.parent.parent);
              dataPreg := sender.GetNodeData(node.parent);
              dataMn3 := sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mn := preg.FMns[dataMn3.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMN3.getAnsiStringMap(Data.DataPos, word(BLANKA_MED_NAPR_3A_NRN));
              end
              else
              begin
                CellText := 'Ново МН3333 ' + mn3.NRN;
              end;
            end;
          end;
          vvMedNaprHosp:
          begin
            dataPat := sender.GetNodeData(node.parent.parent);

            if dataPat.vid = vvPatient then
            begin
              dataPreg := sender.GetNodeData(node.parent);
              dataMNHosp := Sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mnHosp := preg.FMNsHosp[dataMNHosp.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMnHosp.getAnsiStringMap(Data.DataPos, word(HOSPITALIZATION_NRN));
              end
              else
              begin
                CellText := 'Ново МНHosp ' + mnHosp.NRN;
              end;
            end
            else
            begin
              dataPat := sender.GetNodeData(node.parent.parent.parent);
              dataPreg := sender.GetNodeData(node.parent);
              dataMNHosp := sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mnHosp := preg.FMNsHosp[dataMNHosp.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMnHosp.getAnsiStringMap(Data.DataPos, word(HOSPITALIZATION_NRN));
              end
              else
              begin
                CellText := 'Ново МНHosp ' + mnHosp.NRN;
              end;
            end;
          end;
          vvMedNaprLkk:
          begin
            dataPat := sender.GetNodeData(node.parent.parent);

            if dataPat.vid = vvPatient then
            begin
              dataPreg := sender.GetNodeData(node.parent);
              dataMNLkk := Sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mnLkk := preg.FMNsLKK[dataMNLkk.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMnExpert.getAnsiStringMap(Data.DataPos, word(EXAM_LKK_NRN));
              end
              else
              begin
                CellText := 'Ново МНLKK ' + mnLkk.NRN;
              end;
            end
            else
            begin
              dataPat := sender.GetNodeData(node.parent.parent.parent);
              dataPreg := sender.GetNodeData(node.parent);
              dataMNLkk := sender.GetNodeData(node);
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mnLkk := preg.FMNsLKK[dataMNLkk.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollMnExpert.getAnsiStringMap(Data.DataPos, word(EXAM_LKK_NRN));
              end
              else
              begin
                CellText := 'Ново МНLKK ' + mnLkk.NRN;
              end;
            end;
          end;
          vvPregled:
          begin
            dataPat := sender.GetNodeData(node.parent);
            if dataPat = nil then Exit;

            if dataPat.vid = vvPatient then
            begin
              pat := msgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[data.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollPreg.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
              end
              else
              begin
                CellText := 'Нов преглед ' + preg.NRN;
              end;
            end
            else
            begin
              dataPat := sender.GetNodeData(node.parent.parent);
              pat := msgColl.CollPat.Items[dataPat.index];
              dataIncMN := sender.GetNodeData(node.parent);
              incMN := pat.FIncMNs[dataIncMN.index];
              preg := pat.FPregledi[data.index];
              if Data.DataPos > 0 then
              begin
                CellText := msgColl.CollPreg.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
              end
              else
              begin
                CellText := 'Нов преглед ' + preg.NRN;
              end;
            end;
          end;
          vvOtherDoctor:
          begin
            if data.DataPos > 0 then
            begin
              CellText := CollOtherDoctor.getAnsiStringMap(Data.DataPos, word(OtherDoctor_UIN));
            end
            else
            begin
              CellText := msgColl.CollIncDoc.items[data.index].PRecord.UIN;
            end;
          end;
          vvIncMN:
          begin
            dataPat := sender.GetNodeData(node.parent);
            pat := msgColl.CollPat.Items[dataPat.index];
            incMN := pat.FIncMNs[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := msgColl.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN));
            end
            else
            begin
              CellText := 'Нова Консулт.  ' + incMN.NRN;
            end;
          end;
          vvPatient:
          begin
            pat := msgColl.CollPat.Items[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := msgColl.CollPat.getAnsiStringMap(Data.DataPos, word(PatientNew_EGN));
            end
            else
            begin
              CellText := 'Нов ' + pat.PatEGN;
            end;
          end;

          vvAddres:
          begin
            if  msgColl.CollPat.Items[data.index].FAdresi.Count = 0 then
            begin
              CellText := 'Без адрес ';
              exit;
            end;
            addr := msgColl.CollPat.Items[data.index].FAdresi[0];
            CellText := 'адрес ';
            if Data.DataPos > 0 then
            begin
              CellText := 'адрес ';
              //CellText := msgColl.CollPat.getAnsiStringMap(Data.DataPos, word(PatientNew_EGN));
            end
            else
            begin
              CellText := 'Нов адрес';
            end;
          end;

          vvNzisMessages:
          begin
            DataParent := sender.GetNodeData(node.parent);
            case DataParent.vid of
              vvpregled:
              begin
                dataPat := sender.GetNodeData(node.parent.parent);
                if dataPat = nil then Exit;

                if dataPat.vid = vvPatient then
                begin
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[DataParent.index];
                  msg := TNzisReqRespItem(preg.FLstMsgImportNzis[data.index]);
                  CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := sender.GetNodeData(node.parent.parent.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[DataParent.index];
                  msg := TNzisReqRespItem(preg.FLstMsgImportNzis[data.index]);
                  CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                end;
              end;
              vvMdn:
              begin
                dataPat := sender.GetNodeData(node.parent.parent.parent);
                if dataPat.vid = vvPatient then
                begin

                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMdn := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mdn := preg.FMdns[dataMdn.index];
                  msg := TNzisReqRespItem(mdn.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := sender.GetNodeData(node.parent.parent.parent.parent);
                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMdn := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mdn := preg.FMdns[dataMdn.index];
                  msg := TNzisReqRespItem(mdn.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end;
              end;

              vvMedNapr:
              begin
                dataPat := sender.GetNodeData(node.parent.parent.parent);
                if dataPat.vid = vvPatient then
                begin

                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMn := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mn := preg.FMns[dataMn.index];
                  msg := TNzisReqRespItem(mn.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := sender.GetNodeData(node.parent.parent.parent.parent);
                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMn := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mn := preg.FMns[dataMn.index];
                  msg := TNzisReqRespItem(mn.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end;
              end;
              vvMedNapr3A:
              begin
                dataPat := sender.GetNodeData(node.parent.parent.parent);
                if dataPat.vid = vvPatient then
                begin

                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMN3 := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mn3 := preg.FMNs3A[dataMN3.index];
                  msg := TNzisReqRespItem(mn3.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := sender.GetNodeData(node.parent.parent.parent.parent);
                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMN3 := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mn3 := preg.FMNs3A[dataMN3.index];
                  msg := TNzisReqRespItem(mn3.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end;
              end;

              vvMedNaprHosp:
              begin
                dataPat := sender.GetNodeData(node.parent.parent.parent);
                if dataPat.vid = vvPatient then
                begin

                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMNHosp := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mnHosp := preg.FMNsHosp[dataMNHosp.index];
                  msg := TNzisReqRespItem(mnHosp.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := sender.GetNodeData(node.parent.parent.parent.parent);
                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMNHosp := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mnHosp := preg.FMNsHosp[dataMNHosp.index];
                  msg := TNzisReqRespItem(mnHosp.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end;
              end;

              vvMedNaprLkk:
              begin
                dataPat := sender.GetNodeData(node.parent.parent.parent);
                if dataPat.vid = vvPatient then
                begin

                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMNLkk := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mnLkk := preg.FMNsLKK[dataMNLkk.index];
                  msg := TNzisReqRespItem(mnLkk.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := sender.GetNodeData(node.parent.parent.parent.parent);
                  dataPreg := sender.GetNodeData(node.parent.Parent);
                  dataMNLkk := sender.GetNodeData(node.parent);
                  pat := msgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mnLkk := preg.FMNsLKK[dataMNLkk.index];
                  msg := TNzisReqRespItem(mnLkk.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end;
              end;

            else
              begin
                //Caption := 'ddd';
              end;

            end;


          end;
        end;

      end;
    end;
    1:
    begin
      case data.vid of
        vvPatient:
        begin

          if Data.DataPos > 0 then
          begin
            CellText := msgColl.CollPat.getAnsiStringMap(Data.DataPos, word(PatientNew_FNAME));
            CellText := CellText + ' ' + msgColl.CollPat.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
            CellText := CellText + ' ' + msgColl.CollPat.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME));
            CellText := CellText + ' ID: ' + IntToStr(msgColl.CollPat.getIntMap(Data.DataPos, word(PatientNew_ID)));
          end
          else
          begin
            CellText := 'XML';
          end;
        end;
        vvAddres:
        begin
          if  msgColl.CollPat.Items[data.index].FAdresi.Count = 0 then
          begin
            exit;
          end;
          addr := msgColl.CollPat.Items[data.index].FAdresi[0];
          CellText := msgColl.CollPat.Items[data.index].FAdresi[0].NasMesto;
        end;
      else
        begin
          CellText := IntToStr(node.ChildCount);
        end;
      end;

    end;
    2:
    begin
      case data.vid of
        vvOrders:
        begin
          dataPat := sender.GetNodeData(node.parent);
          case dataPat.vid of
            vvPatient:
            begin
              pat := msgColl.CollPat.Items[dataPat.index];
              msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
            end;
            vvPregledRoot:
            begin
              msg := msgColl.items[data.index];
            end;
            vvpregled:
            begin
              //dataPat := vtrTemp.GetNodeData(node.parent.parent);
//              pat := msgColl.CollPat.Items[dataPat.index];
//              msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
            end;
          end;
          //CellText := msg.PRecord.NRN;
        end;

      else
        begin
          CellText := TRttiEnumerationType.GetName(TVtrVid(Integer(data.vid)));
          CellText := CellText + ': ' + IntToStr(node.Dummy);
        end;
      end;

    end;
  end;
end;

{ TPatImportNzisNodes }

constructor TPatImportNzisNodes.create;
begin
  inherited;
  addresses := TList<PVirtualNode>.create;
  ExamAnals := TList<PVirtualNode>.create;
  diags := TList<PVirtualNode>.create;
  pregs := TList<PVirtualNode>.create;
end;

destructor TPatImportNzisNodes.destroy;
begin
  FreeAndNil(addresses);
  FreeAndNil(ExamAnals);
  FreeAndNil(diags);
  FreeAndNil(pregs);
  inherited;
end;

function TPatImportNzisNodes.GetNZISPidType(buf: pointer;
  posdata: cardinal): TNZISidentifierType;
var
  logPat: TlogicalPatientNewSet;
  dataPat: PAspRec;
  pat: TRealPatientNewItem;
begin
  dataPat := pointer(PByte(patNode) + lenNode);
  pat := TRealPatientNewItem.Create(nil);
  pat.DataPos := dataPat.DataPos;
  logPat := TlogicalPatientNewSet(pat.getLogical40Map(buf, posdata, word(PatientNew_Logical)));
  if PID_TYPE_E in logPat then Result := TNZISidentifierType.itbEGN
  else if PID_TYPE_B in logPat then Result := TNZISidentifierType.itbNBN
  else if PID_TYPE_F in logPat then Result := TNZISidentifierType.itbOther
  else if PID_TYPE_L in logPat then Result := TNZISidentifierType.itbLNZ
  else if PID_TYPE_S in logPat then Result := TNZISidentifierType.itbSSN;
  FreeAndNil(pat);
end;

procedure TPatImportNzisNodes.SortDiag(SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;
 ListAnsi: TList<AnsiString>;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : AnsiString;
    saveList: PVirtualNode;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while (ListAnsi[I])< (ListAnsi[P]) do Inc(I);
          while (ListAnsi[J]) > (ListAnsi[P]) do Dec(J);
        end
        else
        begin
          while (ListAnsi[I])> (ListAnsi[P]) do Inc(I);
          while (ListAnsi[J]) < (ListAnsi[P]) do Dec(J);
        end;
        if I <= J then begin
          Save := ListAnsi[I];
          saveList := ListDataPos[I];
          ListAnsi[I] := ListAnsi[J];
          ListDataPos[I] := ListDataPos[J];
          ListAnsi[J] := Save;
          ListDataPos[J] := saveList;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  ListDataPos := Self.diags;
  ListAnsi := TList<AnsiString>.Create;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListAnsi.Add(CollDiag.getAnsiStringMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, word(Diagnosis_code_CL011)));
    QuickSort(0,ListAnsi.count-1);
    ListAnsi.Clear;
    ListAnsi.Free;
  end;
end;

end.
