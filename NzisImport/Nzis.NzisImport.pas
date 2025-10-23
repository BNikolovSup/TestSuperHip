unit Nzis.NzisImport;

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
  Table.MDN, Table.INC_NAPR, Table.OtherDoctor
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
    procedure AddNzisImport(FileName: TFileName);
    procedure FillRespInReq;
    procedure FillADBInMsgColl;
    procedure FillIncDoctor;
    procedure LoopXml;
    procedure Delete99;
    procedure FillMsgXXXInPregled;
    procedure FillMsgRIncMNInIncMN;
    procedure AddNewPreg;
    procedure FillPregInPat;
    procedure FillAddrInPat;
    procedure AddNewPatXXX;
    procedure FillPregledInIncMN;
    procedure FillMsgRMdnInMdn;
    procedure AddNewMdn;
    procedure FillReferalMdnInPreg;
    procedure LoadTempVtrMSG4;

    procedure vtrTempGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrTempChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SetVtrImport(const Value: TVirtualStringTreeHipp);
    procedure SetNasMesto(const Value: TRealNasMestoAspects);
  public
    FnzisXml: TNzisXMLHelper;
    constructor create;
    destructor destroy;
    procedure ImportNzis(FileName: TFileName);
    procedure LoopPat;
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
    property NasMesto: TRealNasMestoAspects read FNasMesto write SetNasMesto;
  end;

implementation

{ TNzisImport }

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
    fileName := 'D:\HaknatFerdow\0200000824.txt';
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
      msg.PRecord.REQ := Arrstr[i];
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

            preg := TRealPregledNewItem(msgColl.CollPreg.Add);
            preg.DataPos := Data.DataPos;
            preg.nrn := msgColl.CollPreg.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
            preg.PatEGN := msgColl.CollPat.getAnsiStringMap(DataPat.DataPos, word(PatientNew_EGN));
            preg.FNode := RunNode;
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
    if msgColl.CollIncMN.Items[iIncMN].NRN = '25244A02FFD2' then
    begin

    end;
    if msgColl.CollIncMN.Items[iIncMN].NRN = LstRIncMN[iMsg].NRN then
    begin
      msg := TNzisReqRespItem (LstRIncMN[iMsg].msg);
      msg.IncMN := msgColl.CollIncMN.Items[iIncMN];
      msgColl.CollIncMN.Items[iIncMN].FLstMsgImportNzis.Add(msg);
      inc(iMsg);
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
        if msgColl.CollPreg.Items[iamb].NRN = '252462095FD4' then
        begin

        end;
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
    if LstRIncMN.Items[iMsg].nrn = '25244A02FFD2' then
    begin

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

  //FillIncMnInPatImport;// след това нещо, може да са останали прегледи на пациенти, които ги няма в базата
  AddNewPatXXX;// търсим новите
  // като имам всички прегледи сега трябва да намеря кои входящи направления са взети от лекаря. Трябва да е по басе-то
  FillPregledInIncMN;

  FillMsgRMdnInMdn; // попълва старите, които са в базата
  AddNewMdn;
  FillReferalMdnInPreg; // мдн-тата в прегледите


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
  vReq, vResp, vpat, vMsg, vPreg, vRun, vMdn, vIncMN, vIncDoc, vAddr: PVirtualNode;
  data, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  IncMN: TRealINC_NAPRItem;
  mdn: TRealMDNItem;
  //patNodes: TPatNodes;
  Dublikat: Boolean;
begin
  Stopwatch := TStopwatch.StartNew;
  VtrImport.NodeDataSize := SizeOf(tAspRec);
  VtrImport.BeginUpdate;
  VtrImport.Clear;

    vPatImportNzis := VtrImport.AddChild(nil, nil);
    data := VtrImport.GetNodeData(vPatImportNzis);
    data.vid := vvPatientRoot;
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

    end;
  end;

  VtrImport.FullExpand();
  VtrImport.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('LoadTempVtrMSG4 за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TNzisImport.LoopPat;
var
  RunPat, runInPat, runInMN, runMsg : PVirtualNode;
  dataPat, dataMsg, dataInPat, dataInMN: PAspRec;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  incMN: TRealINC_NAPRItem;
  msg: TNzisReqRespItem;
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
          runMsg := runInPat.FirstChild;
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
                      ProcAddNewPat(pat, treeLink);
                    end;
                  end;
                  13:  // x013
                  begin
                    if dataPat.DataPos = 0 then
                    begin
                      FnzisXml.FillX013InPat(msg, pat);
                      ProcAddNewPat(pat, treeLink);
                    end;
                  end;
                end;
              end;
            end;
            runMsg := runMsg.NextSibling
          end;
        end;
        vvIncMN:
        begin
          incMN := pat.FIncMNs[dataInPat.index];
          runInMN := runInPat.FirstChild;
          while runInMN <> nil do
          begin
            dataInMN := VtrImport.GetNodeData(runInMN);
            case dataInMN.vid of
              vvPregled:
              begin
                preg := pat.FPregledi[dataInMN.index];
                runMsg := runInMN.FirstChild;
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
                            ProcAddNewPat(pat, treeLink);
                          end;
                        end;
                        13:  // x013
                        begin
                          if dataPat.DataPos = 0 then
                          begin
                            FnzisXml.FillX013InPat(msg, pat);
                            ProcAddNewPat(pat, treeLink);
                          end;
                        end;
                      end;
                    end;
                  end;
                  runMsg := runMsg.NextSibling
                end;
              end;
            end;
            runInMN := runInMN.NextSibling;
          end;
        end;
      end;
      runInPat := runInPat.NextSibling;
    end;

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
  UinRCZSpec: string;
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
            msg.PRecord.patEgn := AmsgX001.Contents.Subject.Identifier.Value;
            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="X002"') then
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
            msg.PRecord.patEgn := AmsgX013.Contents.Subject.Identifier.Value;

            if oXml.Active then
            begin
              oXml.ChildNodes.Clear;
              oXml.Active := False;
            end;
            oxml := nil;

            if string(msg.PRecord.RESP).Contains('<nhis:messageType value="X014"') then
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
                IncMn.PRecord.setProp := [];
                IncMn.PRecord.Logical := [];
                IncMn.PRecord.AMB_LIST_NRN := AmsgR016.Contents.Results[j].Referral.BasedOn.Value;
                case AmsgR016.Contents.Results[j].Referral.Category.Value[2] of
                  '1': include(IncMn.PRecord.Logical, category_R1);
                  '2': include(IncMn.PRecord.Logical, category_R2);
                  '3': include(IncMn.PRecord.Logical, category_R3);
                  '4': include(IncMn.PRecord.Logical, category_R4);
                  '5': include(IncMn.PRecord.Logical, category_R5);
                end;
                IncMn.PatEgn := AmsgR016.Contents.Results[j].Subject.Identifier.Value;
                IncMn.nrn := AmsgR016.Contents.Results[j].Referral.NrnReferral.Value;
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
  data, dataPat, dataPreg, dataMdn, dataParent, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  vReq, vResp, run: PVirtualNode;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  mdn: TRealMDNItem;
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
      end;

    end;
  end;
end;

procedure TNzisImport.vtrTempGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataPat, dataPreg, dataMdn, DataParent, dataIncMN: PAspRec;
  msg: TNzisReqRespItem;
  patLogical: TlogicalPatientNewSet;
  pat: TRealPatientNewItem;
  addr: TRealAddresItem;
  preg: TRealPregledNewItem;
  incMN: TRealINC_NAPRItem;
  mdn: TRealMDNItem;
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
          vvPatientRoot: CellText := 'Пациенти от импорта';
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
