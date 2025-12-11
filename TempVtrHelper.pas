unit TempVtrHelper;

interface
  uses
    Winapi.Windows,
    System.Classes,
    system.Diagnostics,
    system.TimeSpan,
    System.Types,
    System.SysUtils,
    System.Generics.Collections,
    System.Math,

    ProfForm,
    FMX.StdCtrls,
    FMX.objects,

    Vcl.StdCtrls,
    Vcl.Graphics,
    Vcl.ImgList,



    VirtualTrees,
    Aspects.Types,
    Aspects.Collections,
    VirtualStringTreeHipp,
    VirtualStringTreeAspect,
    RealObj.RealHipp,
    ADB_DataUnit,
    WalkFunctions,
    WordBreakF,
    CertThread,

    Table.PregledNew,
    Table.Mkb,
    Table.ExamAnalysis,
    Table.Diagnosis,
    Table.PatientNew,
    Table.Doctor,

    Table.NZIS_PLANNED_TYPE,
    Table.CL132,
    Table.CL022,
    Table.AnalsNew
    ;
type
  TTempVtrHelper = class(TObject)
  private
    FVtr: TVirtualStringTreeHipp;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    //FCollMkb: TRealMkbColl;
    FAdb_DM: TADBDataModule;
    //FCollDiag: TRealDiagnosisColl;
    FmmoTest: TMemo;
    FvNomenMKB, vDiagPat, vDiagPreg: PVirtualNode;

    CurrentPregled: TRealPregledNewItem;
    FFmxProfForm: TfrmProfFormFMX;
    FvtrNewAnal: TVirtualStringTreeAspect;
    FFilterText: string;
    //FCollDoctor: TRealDoctorColl;
    FthrCert: TCertThread;

    function CompareStrings(const S1, S2: string): Integer;


    //procedure ShowPregledFMX(dataPat,dataPreg: PAspRec; linkPreg:PVirtualNode );
    procedure RemoveDiag(vPreg: PVirtualNode; diag: TRealDiagnosisItem); overload;
    procedure RemoveDiag(vPreg: PVirtualNode; diagDataPos: cardinal); overload;
    procedure IterateTempExpand(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateTempFullExpand(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateTempCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure SetVtr(const Value: TVirtualStringTreeHipp);
    procedure SetFmxProfForm(const Value: TfrmProfFormFMX);
    procedure InitVariableVtrAnal;
    procedure InitVariableVtrMkb;
    procedure InitVariableVtrNzisHist;
    procedure InitVariableVtrOldMenu;
    procedure InitVariableVtrDoctor;

  public
    //nodes
    vRootDoctor: PVirtualNode;
    vRootDoctorPrac: PVirtualNode;
    vRootDoctorSender: PVirtualNode;
    vRootDoctorConsult: PVirtualNode;
    vRootDoctorColege: PVirtualNode;


  public
    ListBlanki: TStringList;
    constructor Create(AVtr: TVirtualStringTreeHipp;
          ACollMkb: TRealMkbColl; AAdb_DM: TADBDataModule; ACollDiag: TRealDiagnosisColl;
          ACollDoctor: TRealDoctorColl;
          AmmoTest: TMemo; AvNomenMKB: PVirtualNode; AFmxProfForm: TfrmProfFormFMX);


    //MKB
    function FindMkbDataPosFromCode(const code: string; var Index: Integer): Boolean;
    function SplitMKB_Add(const str: string): TArray<Cardinal>;
    procedure FillMkbs;
    procedure ChoiceMKB(sender: TObject);
    procedure vtrChangeSelectMKB(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrMkbGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    //procedure vtrMKBChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrTempInitNodeMKB(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtrTempInitChildrenMKB(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var ChildCount: Cardinal);
    procedure vtrMeasureItemMkb(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vtrDrawTextMKB(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);




    //Oldmenu

    procedure ChoiceOldMenu(sender: TObject);
    procedure vtrChangeOldMenu(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrOldMenuGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrOldMenuChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrMeasureItemOldMenu(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vtrDrawTextOldMenu(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);

    //Anal

    procedure ChoiceAnal(sender: TObject);
    procedure vtrChangeSelectAnal(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrAnalGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrAnalChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrMeasureItemAnal(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vtrDrawTextAnal(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure vtrTempAnalLoadNode(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Stream: TStream);

    //HistNzis
    procedure ChoiceNzisHist(sender: TObject);

    // doctor
    procedure ChoiceDoctor(sender: TObject);
    procedure vtrChangeSelectDoctor(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrDoctorGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrDoctorGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex;
      var ImageList: TCustomImageList);
    procedure vtrDoctorChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrTempInitNodeDoctor(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtrTempInitChildrenDoctor(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var ChildCount: Cardinal);
    procedure vtrMeasureItemDoctor(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vtrDrawTextDoctor(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);







    procedure vtrExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrTempMeasureItem(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);






    property Vtr: TVirtualStringTreeHipp read FVtr write SetVtr;
    //property CollMkb: TRealMkbColl read FCollMkb write FCollMkb;
    property Adb_DM: TADBDataModule read FAdb_DM write FAdb_DM;
    //property CollDiag: TRealDiagnosisColl read FCollDiag write FCollDiag;
    //property CollDoctor: TRealDoctorColl read FCollDoctor write FCollDoctor;

    property mmoTest: TMemo read FmmoTest write FmmoTest;
    property vNomenMKB: PVirtualNode read FvNomenMKB write FvNomenMKB;
    property FmxProfForm: TfrmProfFormFMX read FFmxProfForm write SetFmxProfForm;
    property vtrNewAnal: TVirtualStringTreeAspect read FvtrNewAnal write FvtrNewAnal;
    property FilterText: string read FFilterText write FFilterText;
    property thrCert: TCertThread read FthrCert write FthrCert;
  end;

implementation

{ TTempVtrHelper }

procedure TTempVtrHelper.ChoiceAnal(sender: TObject);
begin

  Stopwatch := TStopwatch.StartNew;
  Fvtr.BeginUpdate;
  InitVariableVtrAnal;
  Fvtr.Clear;
  Fvtr.NodeDataSize := sizeof(TAspRec);
  vtrNewAnal.CopyTo(vtrNewAnal.RootNode.FirstChild, Fvtr, amInsertAfter, False);


  Fvtr.EndUpdate;
  FVtr.UpdateVerticalScrollBar(true);
  Elapsed := Stopwatch.Elapsed;

  mmotest.Lines.Add( 'CopyAnalTree ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TTempVtrHelper.ChoiceDoctor(sender: TObject);
var
  i: Integer;
  data: PAspRec;
  vDoctor: PVirtualNode;
begin
  Stopwatch := TStopwatch.StartNew;

  FVtr.BeginUpdate;
  FVtr.Tag := Word(vvDoctor);
  FVtr.Clear;
  InitVariableVtrDoctor;
  vRootDoctor := FVtr.AddChild(nil, nil);
  data := FVtr.GetNodeData(vRootDoctor);
  data.vid := vvRootdoctor;
  data.index := -1;
  vRootDoctorPrac := FVtr.AddChild(vRootDoctor, nil);
  data := FVtr.GetNodeData(vRootDoctorPrac);
  data.vid := vvRootDoctorPrac;
  data.index := -1;
  vRootDoctorSender := FVtr.AddChild(vRootDoctor, nil);
  data := FVtr.GetNodeData(vRootDoctorSender);
  data.vid := vvRootDoctorSender;
  data.index := -1;
  vRootDoctorConsult := FVtr.AddChild(vRootDoctor, nil);
  data := FVtr.GetNodeData(vRootDoctorConsult);
  data.vid := vvRootDoctorConsult;
  data.index := -1;
  vRootDoctorColege := FVtr.AddChild(vRootDoctor, nil);
  data := FVtr.GetNodeData(vRootDoctorColege);
  data.vid := vvRootDoctorColege;
  data.index := -1;

  for i := 0 to Adb_DM.CollDoctor.Count - 1 do
  begin
    vDoctor := FVtr.AddChild(vRootDoctorPrac, nil);
    data := FVtr.GetNodeData(vDoctor);
    data.vid := vvdoctor;
    data.DataPos := Adb_DM.CollDoctor.Items[i].DataPos;
    data.index := i;
  end;

  FVtr.Expanded[vRootDoctor] := True;
  FVtr.Expanded[vRootDoctorPrac] := True;

  FVtr.UpdateVerticalScrollBar(true);
  FVtr.EndUpdate;
  //FVtr.FullExpand();


  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'ChoiceDoctor ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TTempVtrHelper.ChoiceMKB(sender: TObject);
var
  LStream : TResourceStream;
  i, j, k, m: integer;
  startMkbGroup, endMkbGroup, startMkbSubGroup, endMkbSubGroup: string;
  vGroup, vSubGroup, vMkb: PVirtualNode;
  data, dataMkb: PAspRec;
  patNode: PVirtualNode;
  PatNodes: TPatNodes;
  mkbCode: string;
  diag: TRealDiagnosisItem;
begin
  Stopwatch := TStopwatch.StartNew;

  FVtr.BeginUpdate;
  FVtr.Tag := Word(vvDiag);
  FVtr.Clear;
  InitVariableVtrMkb;


  if not Adb_DM.CollMkb.IsSortedMKB then
  begin
    Adb_DM.CollMkb.IndexValue(Mkb_CODE);
    Adb_DM.CollMkb.SortByIndexValue(Mkb_CODE);
    Adb_DM.CollMkb.IsSortedMKB := True;
  end;
  if Adb_DM.CollMkb.MkbGroups.Count = 0 then
  begin
    LStream := TResourceStream.Create(HInstance, 'Resource_GroupMkb', RT_RCDATA);
    try
      Adb_DM.CollMkb.MkbGroups.LoadFromStream(LStream, TEncoding.UTF8);
    finally
      LStream.free;
    end;
  end;
  if Adb_DM.CollMkb.MkbSubGroups.Count = 0 then
  begin
    LStream := TResourceStream.Create(HInstance, 'Resource_SubGroupMkb', RT_RCDATA);
    try
      Adb_DM.CollMkb.MkbSubGroups.LoadFromStream(LStream, TEncoding.UTF8);
      //mmoTest.Lines.Add(CollMkb.MkbSubGroups[3].Split([#9])[2]);
    finally
      LStream.free;
    end;
  end;
  j := 0;
  endMkbSubGroup := '';
  k := 0;

  if sender is TRealDiagnosisItem then // има избрано мкб
  begin

  end;
  if sender is TList<TMnDiag> then  // няма избрано мкб
  begin
    //Stopwatch := TStopwatch.StartNew;
//    //vtrTemp.BeginUpdate;
//    vtrTemp.Clear;
//    //vtrTemp.NodeDataSize := sizeof(TAspRec);
//    vtrTemp.RootNodeCount := 4;
//    //vtrTemp.EndUpdate;
//    Elapsed := Stopwatch.Elapsed;
//    pgcTree.ActivePage := tsTempVTR;
//    mmotest.Lines.Add( 'ChoiceMKBAAAA ' + FloatToStr(Elapsed.TotalMilliseconds));
//    Exit;
  end;

  if sender is TRealPregledNewItem then //  натиснато е от прегледа. трябва да се покажат всички диагнози на пациента
  begin
    CurrentPregled := TRealPregledNewItem(sender);
    Stopwatch := TStopwatch.StartNew;
    //preg := TRealPregledNewItem(sender);
    patNode := CurrentPregled.FNode.Parent;
    PatNodes := Adb_DM.GetPatNodes(patNode);
    patNodes.CollDiag := Adb_DM.CollDiag;
    patNodes.SortDiag(true);

    Elapsed := Stopwatch.Elapsed;
    mkbCode := '';
    for i := 0 to PatNodes.diags.Count - 1 do
    begin
      data := Pointer(PByte(PatNodes.diags[i]) + lenNode);
      if Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011)) <> mkbCode then
      begin
        mkbCode := Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011));
        mmotest.Lines.Add(mkbCode);
      end;
    end;

    vDiagPat := FVtr.AddChild(nil, nil);
    vDiagPat.NodeHeight := 140;
    //Include(vDiagPat.States, vsMultiline);
    data := FVtr.GetNodeData(vDiagPat);
    data.vid := vvPatient;
    data.index := -1;

    vDiagPreg := FVtr.AddChild(nil, nil);
    data := FVtr.GetNodeData(vDiagPreg);
    data.vid := vvPregledNew;
    data.DataPos := CurrentPregled.DataPos;
    data.index := -1;

    mmotest.Lines.Add( 'PatNodes.diags.Count ' + inttostr(PatNodes.diags.Count));
    mmotest.Lines.Add( 'GetPatNodes ' + FloatToStr(Elapsed.TotalMilliseconds));
    //Exit;
  end;





  vNomenMKB := FVtr.AddChild(nil, nil);
  data := FVtr.GetNodeData(vNomenMKB);
  data.vid := vvNomenMkb;
  data.index := -1;
  for i := 0 to Adb_DM.CollMkb.MkbGroups.Count - 1 do
  begin
    startMkbGroup := Adb_DM.CollMkb.MkbGroups[i].Split([#9])[1];
    endMkbGroup := Copy(startMkbGroup, 6, 3) + '.99';
    startMkbGroup := Copy(startMkbGroup, 2, 3);
    vGroup := FVtr.AddChild(vNomenMKB, nil);
    data := FVtr.GetNodeData(vGroup);
    data.vid := vvMKBGroup;
    data.index := i;

    while (j < Adb_DM.CollMkb.MkbSubGroups.Count) and
          (endMkbSubGroup <= endMkbGroup) do
    begin
      startMkbSubGroup := Adb_DM.CollMkb.MkbSubGroups[j].Split([#9])[2];
      endMkbSubGroup := Copy(startMkbSubGroup, 5, 3) + '.99';
      startMkbSubGroup := Copy(startMkbSubGroup, 1, 3);
      if (endMkbSubGroup > endMkbGroup) then
        Break;
      vSubGroup := FVtr.AddChild(vGroup, nil);
      data := FVtr.GetNodeData(vSubGroup);
      data.vid := vvMKBSubGroup;
      data.index := j;
      Inc(j);

      while (k < Adb_DM.CollMkb.Count) and (Adb_DM.CollMkb.getAnsiStringMap(Adb_DM.CollMkb.Items[k].DataPos, Word(Mkb_CODE)) <= endMkbSubGroup) do
      begin
        //if CollMkb.Items[k].Version = 0 then
//        begin
//          inc(k);
//          Continue;
//        end;
        vMkb := FVtr.AddChild(vSubGroup, nil);
        if sender is TRealPregledNewItem then
        begin
          vMkb.CheckType := ctCheckBox;
        end
        else
        begin
          vMkb.CheckType := ctNone;
        end;
        vMkb.CheckState := csUncheckedNormal;
        data := FVtr.GetNodeData(vMkb);
        data.vid := vvMKB;
        data.index := k;
        data.DataPos := Adb_DM.CollMkb.Items[k].DataPos;
        if sender is TRealPregledNewItem then
        begin
          for m := 0 to CurrentPregled.FDiagnosis.Count - 1 do
          begin
            diag := CurrentPregled.FDiagnosis[m];
            if (diag <> nil) and  (Adb_DM.CollDiag.getCardMap(diag.DataPos, word(Diagnosis_MkbPos)) = data.DataPos) then
            begin
              vMkb.CheckState := csCheckedNormal;
              diag.MkbNode := vMkb;
              dataMkb := FVtr.GetNodeData(vMkb);
              data.index := diag.DataPos;

              vMkb := FVtr.AddChild(vDiagPreg, nil);
              vMkb.CheckType := ctCheckBox;
              vMkb.CheckState := csUncheckedNormal;
              data := FVtr.GetNodeData(vMkb);
              data.vid := vvMKB;
              data.DataPos := Adb_DM.CollMkb.Items[k].DataPos;
            end;
          end;
        end;
        inc(k);
      end;
    end;
  end;

  FVtr.Expanded[vNomenMKB] := True;
  //FVtr.Expanded[vDiagPat] := True;

  FVtr.UpdateVerticalScrollBar(true);
  FVtr.EndUpdate;
  //FVtr.FullExpand();


  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'ChoiceMKB ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TTempVtrHelper.ChoiceNzisHist(sender: TObject);
var
  i: Integer;
  NodesSendedToNzis: TNodesSendedToNzis;
begin
  Stopwatch := TStopwatch.StartNew;

  FVtr.BeginUpdate;
  FVtr.Tag := Word(vvNzisMessages);
  FVtr.Clear;
  InitVariableVtrNzisHist;
  NodesSendedToNzis := TNodesSendedToNzis.create(Adb_DM.AdbMainLink);
  NodesSendedToNzis.LoadFromFile('HistNzis.hst');
  //for i := 0 to Adb_DM.LstNodeSended.Count - 1 do
//  begin
//    NodesSendedToNzis := Adb_DM.LstNodeSended[i];
//    NodesSendedToNzis.SaveToFile('HistNzis.hst');
//    //NodesSendedToNzis.GetLinkPos;
//  end;
  fvtr.RootNodeCount := Adb_DM.LstNodeSended.Count;
  FVtr.EndUpdate;
end;

procedure TTempVtrHelper.ChoiceOldMenu(sender: TObject);
var
  i: Integer;
begin
  Stopwatch := TStopwatch.StartNew;

  FVtr.BeginUpdate;
  FVtr.Tag := Word(vvNzisMessages);
  FVtr.Clear;
  InitVariableVtrOldMenu;

  fvtr.RootNodeCount := ListBlanki.Count;
  FVtr.EndUpdate;
end;

function TTempVtrHelper.CompareStrings(const S1, S2: string): Integer;
begin
  Result := AnsiCompareStr(S1, S2);
end;

constructor TTempVtrHelper.Create(AVtr: TVirtualStringTreeHipp;
  ACollMkb: TRealMkbColl; AAdb_DM: TADBDataModule; ACollDiag: TRealDiagnosisColl;
  ACollDoctor: TRealDoctorColl;
  AmmoTest: TMemo; AvNomenMKB: PVirtualNode; AFmxProfForm: TfrmProfFormFMX);
begin
  Vtr := AVtr;
  FAdb_DM := AAdb_DM;
  FmmoTest := AmmoTest;
  FvNomenMKB := AvNomenMKB;
  FFmxProfForm := AFmxProfForm;


  CurrentPregled := nil;
  ListBlanki := TStringList.Create;
  ListBlanki.Text :=
      'Медицинско напр.' + #13#10 +
      'Мед. напр/Искане за' + #13#10 +
      'Искане за образно изследване' + #13#10 +
      'Медико-диагн. напр' + #13#10 +
      'Изследвания' + #13#10 +
      'Манипулации' + #13#10 +
      'Безплатни рецепти' + #13#10 +
      'Зелени рецепти' + #13#10 +
      'Жълти рецепти' + #13#10 +
      'Рецепти' + #13#10 +
      'НЗИС-Бели рецепти' + #13#10 +
      'Лична Здравно-Профилактична Карта' + #13#10 +
      'Рецепта за очила' + #13#10 +
      'Болничен лист' + #13#10 +
      'Бързо Известие' + #13#10 +
      'Имунизации' + #13#10 +
      'Медицинска бележка' + #13#10 +
      'Цитонамазка' + #13#10 +
      'Рег. карта за проф. преглед' + #13#10 +
      'Мед. напр. за ТЕЛК' + #13#10 +
      'Антропометрия' + #13#10 +
      'Анкетна карта' + #13#10 +
      'Талон за ЛКК' + #13#10 +
      'Хоспитализация' + #13#10 +
      'Бланка 3A' + #13#10 +
      'Удостоверение' + #13#10 +
      'Консултация' + #13#10 +
      'Протокол за лекарства' + #13#10 +
      'Протокол за ЛКК' + #13#10 +
      'Съобщение за смърт' + #13#10 +
      'Прикачени файлове' + #13#10 +
      'Служебна бележка' + #13#10 +
      'Информирано съгласие' + #13#10 +
      'Удостоверение за шофьор' + #13#10 +
      'Удостоверение за здравословно състояние-НЗИС' + #13#10 +
      'Бланка 8' + #13#10 +
      'Физиотерапия' + #13#10 +
      'Бланка за нежелани реакции след ваксинация' + #13#10 +
      'Медицинско напр. за дисп. набл.' + #13#10 +
      'Етапна епикриза' + #13#10 +
      'Карта за профилактика на ЗОЛ над 18 години' + #13#10 +
      'Карта за оценка на рисковите фактори за развитие на заболяване 2017' + #13#10 +
      'Медицинско за работа' + #13#10 +
      'Медицинско за встъпване в брак' + #13#10 +
      'Бланка за консултация при ТЕЛК' + #13#10 +
      'Искане за хистопатологично изследване' + #13#10 +
      'Информирано съгласие' + #13#10 +
      'Решение на ЛКК' + #13#10 +
      'Бланка 13' + #13#10 +
      'Бланка 12' + #13#10 +
      'Ехография на щитовидна жлеза' + #13#10 +
      'Ехокардиография' + #13#10 +
      'Направление за бременна до родилно отделение' + #13#10 +
      'Карта за шофьор';
end;

procedure TTempVtrHelper.FillMkbs;
begin

end;

function TTempVtrHelper.FindMkbDataPosFromCode(const code: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
  str: string;
begin
  Result := False;
  L := 0;
  H := Adb_DM.CollMkb.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    str := Adb_DM.CollMkb.getAnsiStringMap(Adb_DM.CollMkb.items[i].DataPos, word(Mkb_CODE));
    C := CompareStrings(Trim(str), code);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TTempVtrHelper.InitVariableVtrOldMenu;
begin
  FVtr.OnChange := vtrChangeOldMenu;
  FVtr.OnChecked := vtrOldMenuChecked;
  FVtr.OnMeasureItem := vtrMeasureItemOldMenu;
  FVtr.OnDrawText := vtrDrawTextOldMenu;
  FVtr.OnGetText := vtrOldMenuGetText;

  FVtr.NodeDataSize := sizeof(TAspRec);
  FVtr.Header.Columns.Items[0].Text := 'Прегледи';
  FVtr.Header.Columns.Items[0].Width := 133;
  FVtr.Header.Columns.Items[0].Tag := Integer(vvPrimaryMedDoc);
  FVtr.Header.AutoSizeIndex := 0;
  //FVtr.Header.Columns.Items[0].
end;

procedure TTempVtrHelper.InitVariableVtrAnal;
begin
  FVtr.OnChange := vtrChangeSelectAnal;
  FVtr.OnChecked := vtrAnalChecked;
  FVtr.OnMeasureItem := vtrMeasureItemAnal;
  FVtr.OnDrawText := vtrDrawTextAnal;
  Fvtr.OnGetText := vtrAnalGetText;
  FVtr.OnLoadNode := vtrTempAnalLoadNode;

  FVtr.NodeDataSize := sizeof(TAspRec);
  FVtr.Header.Columns.Items[0].Text := 'Изследвания';
  FVtr.Header.AutoSizeIndex := 1;
  FVtr.Header.Columns.Items[0].Width := 483;
  FVtr.Header.AutoSizeIndex := 0;
  FVtr.Header.Columns.Items[0].Tag := Integer(vvAnal);

end;

procedure TTempVtrHelper.InitVariableVtrDoctor;
begin
  FVtr.OnChange := vtrChangeSelectDoctor;
  FVtr.OnChecked := vtrDoctorChecked;
  FVtr.OnMeasureItem := vtrMeasureItemDoctor;
  FVtr.OnDrawText := vtrDrawTextDoctor;
  FVtr.OnGetText := vtrDoctorGetText;
  FVtr.OnInitNode := vtrTempInitNodeDoctor;
  FVtr.OnInitChildren := vtrTempInitChildrenDoctor;
  FVtr.OnGetImageIndexEx := vtrDoctorGetImageIndexEx;

  FVtr.NodeDataSize := sizeof(TAspRec);
  FVtr.DefaultNodeHeight := 33;
  FVtr.Header.Columns.Items[0].Text := 'Лекари';
  FVtr.Header.AutoSizeIndex := 1;
  FVtr.Header.Columns.Items[0].Width := 183;
  FVtr.Header.Columns.Items[0].Tag := Integer(vvDoctor);
  FVtr.Header.AutoSizeIndex := 0;
end;

procedure TTempVtrHelper.InitVariableVtrMkb;
begin
  FVtr.OnChange := vtrChangeSelectMKB;
  //FVtr.OnChecked := vtrMKBChecked;
  FVtr.OnMeasureItem := vtrMeasureItemMkb;
  FVtr.OnDrawText := vtrDrawTextMKB;
  FVtr.OnGetText := vtrMkbGetText;
  FVtr.OnInitNode := vtrTempInitNodeMKB;
  FVtr.OnInitChildren := vtrTempInitChildrenMKB;

  FVtr.NodeDataSize := sizeof(TAspRec);
  FVtr.Header.Columns.Items[0].Text := 'Диагнози';
  FVtr.Header.Columns.Items[0].Width := 133;
  FVtr.Header.Columns.Items[0].Tag := Integer(vvDiag);
  FVtr.Header.AutoSizeIndex := 1;
end;

procedure TTempVtrHelper.InitVariableVtrNzisHist;
begin
  FVtr.OnChange := nil;
  FVtr.OnChecked := nil;
  FVtr.OnMeasureItem := nil;
  FVtr.OnDrawText := nil;

  FVtr.NodeDataSize := sizeof(TAspRec);
  FVtr.Header.Columns.Items[0].Text := 'Нзис-комуникации';
  FVtr.Header.Columns.Items[0].Width := 133;
  FVtr.Header.Columns.Items[0].Tag := Integer(vvNzisMessages);
  FVtr.Header.AutoSizeIndex := 1;
end;

procedure TTempVtrHelper.IterateTempCollapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  AData: PAspRec;
begin
  AData := Sender.GetNodeData(node);
  if (AData.vid = PAspRec(Data).vid) then
  begin
    Sender.Expanded[Node] := false;
  end;
end;

procedure TTempVtrHelper.IterateTempExpand(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  AData: PAspRec;
begin
  AData := Sender.GetNodeData(node);
  if (AData.vid = PAspRec(Data).vid) then
  begin
    Sender.Expanded[Node] := True;
  end;
end;

procedure TTempVtrHelper.IterateTempFullExpand(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  AData: PAspRec;
begin
  AData := Sender.GetNodeData(node);
  //if (AData.vid = PAspRec(Data).vid) then
  begin
    Sender.Expanded[Node] := True;
  end;
end;

procedure TTempVtrHelper.RemoveDiag(vPreg: PVirtualNode;
  diag: TRealDiagnosisItem);
var
  RunNode: PVirtualNode;
  data, dataPat, dataPreg: PAspRec;
  tempViewportPosition: TPointF;
begin
  RunNode := vPreg.FirstChild;
  while RunNode <> nil do
  begin
    data := Pointer(PByte(RunNode) + lenNode);
    if data.vid = vvDiag then
    begin
      if diag.DataPos = Data.DataPos then
      begin
        Adb_DM.AdbMainLink.MarkDeletedNode(RunNode);
        dataPreg := Pointer(PByte(vPreg) + lenNode);
        dataPat :=  Pointer(PByte(vPreg.Parent) + lenNode);
        tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        //ShowPregledFMX(dataPat, dataPreg, vPreg);
        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        Break;
      end;
    end;
    RunNode := RunNode.NextSibling;
  end;
end;

procedure TTempVtrHelper.RemoveDiag(vPreg: PVirtualNode; diagDataPos: cardinal);
var
  RunNode: PVirtualNode;
  data, dataPat, dataPreg: PAspRec;
  tempViewportPosition: TPointF;
  i, j: integer;
  TempRect: FMX.objects.TRectangle;
  TempDiagLabel: TDiagLabel;
begin

  RunNode := vPreg.FirstChild;
  while RunNode <> nil do
  begin
    data := Pointer(PByte(RunNode) + lenNode);
    if data.vid = vvDiag then
    begin
      if diagDataPos = Data.DataPos then
      begin
        Adb_DM.AdbMainLink.MarkDeletedNode(RunNode);
        dataPreg := Pointer(PByte(vPreg) + lenNode);
        dataPat :=  Pointer(PByte(vPreg.Parent) + lenNode);
        //tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        //ShowPregledFMX(dataPat, dataPreg, vPreg);
        //FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        for j := 0 to FmxProfForm.LstDiags.count - 1 do
        begin
          TempRect := FmxProfForm.LstDiags[j];
          TempDiagLabel := TDiagLabel(TempRect.TagObject);
          if TempDiagLabel.node = RunNode then
          begin
            TempRect.Parent := nil;
            FmxProfForm.xpdrDiagn.RecalcSize;
            FmxProfForm.lytDiagFrame.Height := FmxProfForm.xpdrDiagn.Height + 30;
            Break;
          end;
        end;
        Break;
      end;
    end;
    RunNode := RunNode.NextSibling;
  end;
end;

procedure TTempVtrHelper.SetFmxProfForm(const Value: TfrmProfFormFMX);
begin
  FFmxProfForm := Value;
  FFmxProfForm.OnChoicerAnal := ChoiceAnal;
end;

procedure TTempVtrHelper.SetVtr(const Value: TVirtualStringTreeHipp);
begin
  FVtr := Value;
  FVtr.OnExpanded := vtrExpanded;
  FVtr.OnCollapsed := vtrCollapsed;
end;

//procedure TTempVtrHelper.ShowPregledFMX(dataPat, dataPreg: PAspRec;
//  linkPreg: PVirtualNode);
//var
//  edt: TEdit;
//  run, runAnal : PVirtualNode;
//  dataRun, dataAnal, dataFMXPreg: PAspRec;
//  diag: TRealDiagnosisItem;
//  performer: TRealDoctorItem;
//  mdn: TRealMDNItem;
//  mn: TRealBLANKA_MED_NAPRItem;
//  immun: TRealExamImmunizationItem;
//  anal: TRealExamAnalysisItem;
//  i, lastVacantPreg: Integer;
//  PosInNomen: integer;
//  vScrol: FMX.StdCtrls.TScrollBar;
//
//  nodePlan: PVirtualNode;
//  dataPlan: PAspRec;
//  cl132Key, cl136Key: string;
//  prNomen: string;
//  cl132pos, pr001Pos: Cardinal;
//  revis: TRevision;
//
//  p: PCardinal;
//  ofset: Cardinal;
//  dataPatRevision: PAspRec;
//  TempDiags: TList<TRealDiagnosisItem>;
//  TempMns: TList<TRealBLANKA_MED_NAPRItem>;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  FmxProfForm.ClearListsPreg;
//  TempDiags := TList<TRealDiagnosisItem>.Create;
//  TempMns := TList<TRealBLANKA_MED_NAPRItem>.Create;
//  FmxProfForm.linkPreg := linkPreg;
//
//  dataRun := pointer(PByte(linkPreg) + lenNode);
//  mmoTest.Lines.Add(format('Fill dataPreg = %d', [dataPreg.DataPos]));
//
//  run := linkPreg.Parent.FirstChild; //  събирам останалите прегледи на пациента
//  FmxProfForm.OtherPregleds.Clear;
//  while run <> nil do
//  begin
//    dataRun := pointer(PByte(run) + lenNode);
//    case dataRun.vid of
//      vvPregledNew:
//      begin
//        if run = linkPreg  then
//        begin
//          run:= run.NextSibling;
//          Continue;
//        end;
//        FmxProfForm.OtherPregleds.Add(run);
//      end;
//    end;
//
//    run:= run.NextSibling;
//  end;
//
//  run := linkPreg.FirstChild; // ще се обикалят всички неща по прегледа
//  while run <> nil do
//  begin
//    dataRun := pointer(PByte(run) + lenNode);
//    case dataRun.vid of
//      vvPerformer:
//      begin
//        FmxProfForm.Doctor.DataPos := dataRun.DataPos;
//      end;
//      vvDiag:
//      begin
//        if FmxProfForm.Pregled.CanDeleteDiag then
//        begin
//          diag := TRealDiagnosisItem.Create(nil);
//          diag.DataPos := dataRun.DataPos;
//          diag.Node := run;
//          TempDiags.Add(diag);
//        end
//        else
//        begin
//
//        end;
//      end;
//      vvMDN:
//      begin
//        mdn := Adb_DM.CollMDN.GetItemsFromDataPos(dataRun.DataPos);
//        if mdn = nil then
//        begin
//          mdn := TRealMdnItem.Create(nil);
//          mdn.DataPos := dataRun.DataPos;
//          mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
//          mdn.LinkNode := run;
//        end;
//        FmxProfForm.Pregled.FMdns.Add(mdn);
//
//
//        runAnal := run.FirstChild;
//        while runAnal <> nil do
//        begin
//          dataAnal := pointer(PByte(runAnal) + lenNode);
//          case dataAnal.vid of
//            vvExamAnal:
//            begin
//              anal := Adb_DM.CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
//              if anal = nil then
//              begin
//                anal := TRealExamAnalysisItem.Create(nil);
//                anal.DataPos := dataAnal.DataPos;
//                mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
//                PosInNomen := anal.getIntMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_PosDataNomen));
//                anal.LinkNode := runAnal;
//              end;
//              mdn.FExamAnals.Add(anal);
//            end;
//          end;
//          runAnal := runAnal.NextSibling;
//        end;
//      end;
//      vvNZIS_PLANNED_TYPE:
//      begin
//        nodePlan := run;
//        dataPlan := Pointer(PByte(nodePlan) + lenNode);
//        cl132Key := Adb_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
//        prNomen := Adb_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
//        cl132pos := Adb_DM.CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
//        cl136Key := Adb_DM.CL132Coll.getAnsiStringMap(cl132pos, word(CL132_cl136));
//        if (cl136Key = '2') and (nodePlan.CheckState = csCheckedNormal) then
//        begin
//          mdn := Adb_DM.CollMDN.GetItemsFromDataPos(dataRun.DataPos);
//          if mdn = nil then
//          begin
//            mdn := TRealMdnItem.Create(nil);
//            mdn.DataPos := dataRun.DataPos;
//            mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
//            mdn.LinkNode := run;
//          end;
//          FmxProfForm.Pregled.FMdns.Add(mdn);
//
//
//          runAnal := run.FirstChild;
//          while runAnal <> nil do
//          begin
//            dataAnal := pointer(PByte(runAnal) + lenNode);
//            case dataAnal.vid of
//              vvExamAnal:
//              begin
//                anal := Adb_DM.CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
//                if anal = nil then
//                begin
//                  anal := TRealExamAnalysisItem.Create(nil);
//                  anal.DataPos := dataAnal.DataPos;
//                  mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
//                  PosInNomen := anal.getIntMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_PosDataNomen));
//                  anal.LinkNode := runAnal;
//                end;
//                mdn.FExamAnals.Add(anal);
//              end;
//              vvMedNapr:
//              begin
//                mn := Adb_DM.CollMedNapr.GetItemsFromDataPos(dataAnal.DataPos);
//                if mn = nil then
//                begin
//                  mn := TRealBLANKA_MED_NAPRItem.Create(nil);
//                  mn.DataPos := dataAnal.DataPos;
//                  mn.LinkNode := run;
//                end;
//                //FmxProfForm.Pregled.FMNs.Add(mn);
//                TempMns.Add(mn);
//                //if oldPreg <> nil then
////                begin
////                  mn.FPregled := oldPreg;
////                end
////                else
////                begin
////                  mn.FPregled := FmxProfForm.Pregled;
////                end;
//              end;
//            end;
//            runAnal := runAnal.NextSibling;
//          end;
//        end
//        else
//        begin
//          nodePlan := run;
//          dataPlan := Pointer(PByte(nodePlan) + lenNode);
//          cl132Key := Adb_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
//          prNomen := Adb_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
//          cl132pos := Adb_DM.CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
//          cl136Key := Adb_DM.CL132Coll.getAnsiStringMap(cl132pos, word(CL132_cl136));
//          runAnal := run.FirstChild;
//          while runAnal <> nil do
//          begin
//            dataAnal := pointer(PByte(runAnal) + lenNode);
//            case dataAnal.vid of
//             // vvExamAnal:
////              begin
////                anal := CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
////                if anal = nil then
////                begin
////                  anal := TRealExamAnalysisItem.Create(nil);
////                  anal.DataPos := dataAnal.DataPos;
////                  mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
////                  PosInNomen := anal.getIntMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_PosDataNomen));
////                  anal.LinkNode := runAnal;
////                end;
////                mdn.FExamAnals.Add(anal);
////              end;
//              vvMedNapr:
//              begin
//                mn := Adb_DM.CollMedNapr.GetItemsFromDataPos(dataAnal.DataPos);
//                if mn = nil then
//                begin
//                  mn := TRealBLANKA_MED_NAPRItem.Create(nil);
//                  mn.DataPos := dataAnal.DataPos;
//                  mn.LinkNode := run;
//                end;
//                //FmxProfForm.Pregled.FMNs.Add(mn);
//                TempMns.Add(mn);
//                //if oldPreg <> nil then
////                begin
////                  mn.FPregled := oldPreg;
////                end
////                else
////                begin
////                  mn.FPregled := FmxProfForm.Pregled;
////                end;
//              end;
//            end;
//            runAnal := runAnal.NextSibling;
//          end;
//        end;
//
//      end;
//      vvMedNapr:
//      begin
//        mn := Adb_DM.CollMedNapr.GetItemsFromDataPos(dataRun.DataPos);
//        if mn = nil then
//        begin
//          mn := TRealBLANKA_MED_NAPRItem.Create(nil);
//          mn.DataPos := dataRun.DataPos;
//          //mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
//          mn.LinkNode := run;
//        end;
//        //FmxProfForm.Pregled.FMNs.Add(mn);
//        TempMns.Add(mn);
//        //if oldPreg <> nil then
////        begin
////          mn.FPregled := oldPreg;
////        end
////        else
////        begin
////          mn.FPregled := FmxProfForm.Pregled;
////        end;
//      end;
//      vvExamImun:
//      begin
//        immun := Adb_DM.CollExamImun.GetItemsFromDataPos(dataRun.DataPos);
//        if immun = nil then
//        begin
//          immun := TRealExamImmunizationItem.Create(nil);
//          immun.DataPos := dataRun.DataPos;
//          //mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
//          immun.LinkNode := run;
//        end;
//        FmxProfForm.Pregled.FImmuns.Add(immun);
//        immun.FPregled := FmxProfForm.Pregled;
//      end;
//      vvPatientRevision:
//      begin
//        revis := TRevision.Create;
//        revis.CollType := ctPatientNew;
//        revis.node := run;
//        revis.propIndex := run.Dummy;
//        dataPatRevision := Pointer(PByte(run) + lenNode);
//        ofset := dataPatRevision.index;
//        case run.Dummy of
//          word(PatientNew_FNAME):
//          begin
//            FmxProfForm.patNameF := Adb_DM.CollPatient.getAnsiStringMapOfset(ofset, word(PatientNew_FNAME));
//          end;
//        end;
//        //pat.Revisions.Add(revis);
//      end;
//    end;
//
//    run := run.NextSibling;
//  end;
//  //fmxCntrDyn.ChangeActiveForm(FmxProfForm);
//
//  //FmxProfForm.AspAdbBuf := AspectsHipFile.Buf;
////  FmxProfForm.AspAdbPosData := AspectsHipFile.FPosData;
//  FmxProfForm.Patient.DataPos := dataPat.DataPos;
//  if FmxProfForm.Pregled.FNode = nil then // не е избиран и редактиран до сега
//  begin
//    FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
//    FmxProfForm.Pregled.FNode := linkPreg;
//    dataPreg.index := 0;
//  end
//  else
//  begin
//    if FmxProfForm.Pregled.PRecord <> nil then // Редактиран е и трябва да се добави нов във колекцията
//    begin
//      FmxProfForm.RemoveLastVacantindexPreg;
//      if dataPreg.index < 0 then  // само че да не е ползван и незаписан преди
//      begin
//        lastVacantPreg := FmxProfForm.FindVacantIndexPreg();
//        if lastVacantPreg = -1 then
//        begin
//          //oldPreg := FmxProfForm.Pregled;
//          FmxProfForm.Pregled := TRealPregledNewItem(Adb_DM.CollPregled.Add);
//          dataPreg.index := Adb_DM.CollPregled.Count - 1;
//          ////  трябва да се вземат нещата от стария (попълненият) преглед
////          FmxProfForm.Pregled.FMNs.AddRange(oldPreg.FMNs);
////          FmxProfForm.Pregled.FDiagnosis.AddRange(oldPreg.FDiagnosis);
//        end
//        else
//        begin
//          FmxProfForm.Pregled := Adb_DM.CollPregled.Items[lastVacantPreg];
//
//          dataPreg.index := lastVacantPreg;
//
//        end;
//
//        FmxProfForm.Pregled.FNode := linkPreg;
//        FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
//      end
//      else
//      begin
//       // oldPreg := FmxProfForm.Pregled;
//        FmxProfForm.Pregled := Adb_DM.CollPregled.Items[dataPreg.index];
//        FmxProfForm.Pregled.FNode := linkPreg;
//        //dataPreg.index := dataPreg.index; // не трябва да се сменява
//        FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
//        ////  трябва да се вземат нещата от стария (попълненият) преглед
////        FmxProfForm.Pregled.FMNs.AddRange(oldPreg.FMNs);
////        FmxProfForm.Pregled.FDiagnosis.AddRange(oldPreg.FDiagnosis);
//      end;
//    end
//    else
//    begin
//      dataFMXPreg := pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode); // който е за редактиране
//      if dataPreg.index = - 1 then
//      begin
//        if FmxProfForm.FindVacantIndexPreg() = -1 then
//        begin// тука трябва да се записват някъде минусираните
//          FmxProfForm.AddVacantindexPreg(dataFMXPreg.index);
//        end;
//        dataPreg.index := dataFMXPreg.index;// заменям стария индекс със новия
//        dataFMXPreg.index := -1;// стария го минусирам :) за да се знае, че не е ползван
//        if dataPreg.index = -1 then
//        begin
//          //Caption := 'errrr';
//          Exit;
//        end;
//      end
//      else
//      begin
//        //Caption := 'errrr'; // zzzz
////        Exit;
//      end;
//
//
//      FmxProfForm.Pregled := Adb_DM.CollPregled.Items[dataPreg.index]; //взимам  прегледа и му слагам новите неща
//      FmxProfForm.Pregled.FNode := linkPreg;
//      FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
//
//    end;
//  end;
//
//  FmxProfForm.ClearBlanka;
//  FmxProfForm.Pregled.FDiagnosis.AddRange(TempDiags);
//  FmxProfForm.Pregled.FMNs.AddRange(TempMns);
//  for i := 0 to FmxProfForm.Pregled.FMNs.Count - 1 do
//    FmxProfForm.Pregled.FMNs[i].FPregled := FmxProfForm.Pregled;
//  TempDiags.Free;
//  TempMns.Free;
//
//
//  FmxProfForm.FillProfActivityPreg(linkPreg);
//  FmxProfForm.FillRightLYT(dataPreg);
//  FmxProfForm.rctNzisBTN.Repaint;
//  FmxProfForm.InitSetings;
//
//  Elapsed := Stopwatch.Elapsed;
//  //FmxProfForm.scldlyt1.endupdate;
//  mmoTest.Lines.Add( 'DYN ' + FloatToStr(Elapsed.TotalMilliseconds));
//end;

function TTempVtrHelper.SplitMKB_Add(const str: string): TArray<Cardinal>;
var
  i, IndexMkb: Integer;
  tempArrstr: TArray<string>;
  tempCard: TArray<Cardinal>;
  pred, sled, mkb: string;
begin

  if str.Contains(',') then // М07.—*, М09.—*
  begin
    tempArrstr := str.Split([',']);
    for i := 0 to length(tempArrstr) - 1 do
    begin
      tempArrstr[i] := Trim(tempArrstr[i]);
      if FindMkbDataPosFromCode(tempArrstr[i], IndexMkb) then
      begin
        SetLength(Result, length(Result) + 1);
        Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
      end
      else
      begin
        SetLength(tempCard, 0);
        tempCard := SplitMKB_Add(tempArrstr[i]);
        Result := Result + tempCard;
      end;
    end;
  end
  else if str.Contains('.-*') then // М07.—*, М09.—*
  begin
    pred := copy(str, 1, 4);
    for i := 0 to 99 do
    begin
      sled := Format('%d', [i]);
      mkb := pred + sled;
      if FindMkbDataPosFromCode(mkb, IndexMkb) then
      begin
        SetLength(Result, length(Result) + 1);
        Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
      end
    end;
    for i := 0 to 99 do
    begin
      sled := Format('%2.2d', [i]);
      mkb := pred + sled;
      if FindMkbDataPosFromCode(mkb, IndexMkb) then
      begin
        SetLength(Result, length(Result) + 1);
        Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
      end
    end;
  end
  else if str.Contains('.*') then // М07.—*, М09.—*
  begin
    pred := copy(str, 1, 4);
    for i := 0 to 99 do
    begin
      sled := Format('%d', [i]);
      mkb := pred + sled;
      if FindMkbDataPosFromCode(mkb, IndexMkb) then
      begin
        SetLength(Result, length(Result) + 1);
        Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
      end
    end;
    for i := 0 to 99 do
    begin
      sled := Format('%2.2d', [i]);
      mkb := pred + sled;
      if FindMkbDataPosFromCode(mkb, IndexMkb) then
      begin
        SetLength(Result, length(Result) + 1);
        Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
      end
    end;
  end
  else if str.Contains('N77.1-N77.1') then
  begin
    mkb := 'N77.1';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
  end
  else if str.Contains('G05.1-G05.2') then
  begin
    mkb := 'G05.1';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
    mkb := 'G05.2';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
  end
  else if str.Contains('M01.4-M01.5') then
  begin
    mkb := 'M01.4';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
    mkb := 'M01.5';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
  end
  else if str.Contains('M36.2-M36.3') then
  begin
    mkb := 'M36.2';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
    mkb := 'M36.3';
    if FindMkbDataPosFromCode(mkb, IndexMkb) then
    begin
      SetLength(Result, length(Result) + 1);
      Result[Length(Result) - 1] := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
    end;
  end;


end;

procedure TTempVtrHelper.vtrAnalChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrAnalGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
  posCl22: cardinal;//AspectsNomHipFile.Buf
begin
 // if Sender = vtrNewAnal then
    data := pointer(PByte(Node) + lenNode);
 // else
    data := Sender.GetNodeData(node);
  case data.vid of
    vvAnal, vvAnalPackage:
    begin
      case Column of
        0:
        begin
          CellText := Adb_DM.CollAnalsNew.getAnsiStringMap(data.DataPos, word(AnalsNew_AnalName));
        end;
        1:
        begin
          posCl22 := Adb_DM.CollAnalsNew.getcardMap(data.DataPos, word(AnalsNew_CL022_pos));
          if posCl22 > 0 then
          begin
            //Cl022temp.DataPos := posCl22;
            CellText := Adb_DM.CL022Coll.getAnsiStringMap(posCl22, word(CL022_Key));
            CellText := CellText + ' / ' + Adb_DM.CL022Coll.getAnsiStringMap(posCl22, word(CL022_nhif_code))
          end;
        end;
      end;

    end;
  end;

end;

procedure TTempVtrHelper.vtrChangeOldMenu(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrChangeSelectAnal(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrChangeSelectDoctor(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrChangeSelectMKB(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrCollapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  RunNode: PVirtualNode;
begin
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  dataAction := Sender.GetNodeData(node);
  Fvtr.OnCollapsed := nil;
  Fvtr.OnMeasureItem := nil;
  Sender.BeginUpdate;
  Fvtr.IterateSubtree(vNomenMKB, IterateTempcollapsed, dataAction);
  Sender.EndUpdate;
  Fvtr.OnCollapsed := vtrCollapsed;
  Fvtr.OnMeasureItem := vtrTempMeasureItem;
end;

procedure TTempVtrHelper.vtrDoctorChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrDoctorGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex;
  var ImageList: TCustomImageList);
var
  i: integer;
  data: PAspRec;
begin
  if Kind <> TVTImageKind.ikState then
    Exit;
  data := Sender.GetNodeData(node);
  case Column of
    0:
    begin
      case data.vid of
        vvDoctor:
        begin
          ImageIndex := 12;
        end;

      end;
    end;
    1:
    begin
      case data.vid of
        vvDoctor, vvPerformer, vvDeput:
        begin
          if thrCert = nil then  Exit;

          for i := 0 to thrCert.LstPlugCardDoctor.Count - 1 do
          begin
            if Data.DataPos = thrCert.LstPlugCardDoctor[i] then
            begin
              ImageIndex := 102;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;

end;

procedure TTempVtrHelper.vtrDoctorGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
begin
  data := Sender.GetNodeData(node);
  case Column of
    0:
    begin
      if data.index = -1 then
      begin
        case data.vid of
          vvRootdoctor: CellText := 'Лекари';
          vvRootDoctorPrac: CellText := 'Лекари от практиката';
          vvRootDoctorSender: CellText := 'Изпращащи лекари';
          vvRootDoctorConsult: CellText := 'Консултиращи лекари';
          vvRootDoctorColege: CellText := 'Колеги за заместване';
        end;
      end
      else
      begin
        case data.vid of
          vvDoctor:
          begin
            CellText := Adb_DM.CollDoctor.Items[data.index].FullName;
          end;



        end;

      end;
    end;
    1:
    begin
      case data.vid of
        vvDoctor:
        begin
          CellText := Adb_DM.CollDoctor.getAnsiStringMap(Data.DataPos, word(Doctor_UIN));
        end;
      else
        begin
          CellText := IntToStr(node.ChildCount);
        end;
      end;
    end;
  end;
end;

procedure TTempVtrHelper.vtrDrawTextAnal(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
begin

end;

procedure TTempVtrHelper.vtrDrawTextDoctor(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
begin

end;

procedure TTempVtrHelper.vtrDrawTextMKB(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  rText, r: TRect;
  i, p: Integer;
  wb: TWordBreakF;
  strPred, strSled, strFltr: string;
  data: PAspRec;
begin
  data := Sender.GetNodeData(node);
  if (Column <> 1) then
  begin
    case data.vid of
       vvMKBGroup, vvMKBSubGroup:
      begin
        DefaultDraw := true;
        Exit;
      end;
    end;

  end;
  rText := CellRect;

  //Exit;
  wb := TWordBreakF.create(TargetCanvas);
  wb.Inls.Text := Text;

  rText := CellRect;
  //if Column = 0 then
//  begin
//    rText.Top := 0;
//    rText.Height := 26;
//  end;
  wb.maxwidth := rText.Width;

  DefaultDraw := False;
  p := AnsiUpperCase(wb.Inls.Text).IndexOf((AnsiUpperCase(FFilterText)));
  if p > -1 then
  begin
    wb.StartFilter := p;
    wb.EndFilter := p + Length(FFilterText);
    wb.WrapMemo;
    for i := 0 to wb.ls.Count - 1 do
    begin
      if i = wb.ls.Count - 1 then
      begin
        Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls[i]), Length(wb.ls[i])- 1, rText, TA_LEFT );
      end
      else
      begin
        Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls[i]), Length(wb.ls[i] ), rText, TA_LEFT);
      end;

      if AnsiUpperCase(wb.ls[i]).Contains( AnsiUpperCase(FFilterText)) then
      begin
        p := AnsiUpperCase(wb.ls[i]).IndexOf((AnsiUpperCase(FFilterText)));
        strPred := Copy(wb.ls[i], 1, p);
        strFltr := copy(wb.ls[i], p + 1, length(FFilterText));
        strSled := copy(wb.ls[i], p+length(FFilterText) + 1, length(wb.ls[i]) + 1 -   (p+length(FFilterText)));

        SetTextColor(TargetCanvas.Handle, $00A00000);
        SetBkColor(TargetCanvas.Handle, $007DCFFB);
        SetBkMode(TargetCanvas.Handle, OPAQUE);
        r := rText;
        r.Left := r.Left + TargetCanvas.TextWidth(strPred);
        r.Width := TargetCanvas.TextWidth(strFltr);
        Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strFltr), Length(strFltr), r, TA_LEFT);
        SetTextColor(TargetCanvas.Handle, clBlack);
        SetBkMode(TargetCanvas.Handle, TRANSPARENT);
      end;
      if Integer(wb.ls.Objects[i]) <> 0 then
      begin
        p := length(wb.ls[i]) + Integer(wb.ls.Objects[i]);

        if Integer(wb.ls.Objects[i]) < 0 then
        begin
          strPred := Copy(wb.ls[i], 1, p - 1);
          strSled := copy(wb.ls[i], length(wb.ls[i]) + Integer(wb.ls.Objects[i]), - Integer(wb.ls.Objects[i]));
        end
        else
        begin
          strPred := '';
          strSled := copy(wb.ls[i], 1,  Integer(wb.ls.Objects[i]));
          if strSled.StartsWith('н') then
            strPred := '';
        end;

        SetTextColor(TargetCanvas.Handle, $00A00000);
        SetBkColor(TargetCanvas.Handle, $007DCFFB);
        SetBkMode(TargetCanvas.Handle, OPAQUE);
        r := rText;
        r.Left := r.Left + TargetCanvas.TextWidth(strPred);
        r.Width := TargetCanvas.TextWidth(strSled);
        Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strSled), Length(strSled), r, TA_LEFT);
        SetTextColor(TargetCanvas.Handle, clBlack);
        SetBkMode(TargetCanvas.Handle, TRANSPARENT);
      end;
      rText.Offset(0, 13);
    end;

  end
  else
  begin
    wb.WrapMemo;
    Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls.Text), Length(wb.ls.Text) - 3, rText, TA_LEFT);//43024);
  end;
  wb.Destroy;
end;

procedure TTempVtrHelper.vtrDrawTextOldMenu(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
begin

end;

procedure TTempVtrHelper.vtrExpanded(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  RunNode: PVirtualNode;
begin
  if (GetKeyState(VK_CONTROL) < 0) then
  begin
    Stopwatch := TStopwatch.StartNew;
    dataAction := Sender.GetNodeData(node);
    FVtr.OnExpanded := nil;
    Sender.BeginUpdate;
    FVtr.IterateSubtree(vNomenMKB, IterateTempExpand, dataAction);
    Sender.EndUpdate;
    FVtr.OnExpanded := vtrExpanded;
    FVtr.OnMeasureItem := vtrTempMeasureItem;
    Elapsed := Stopwatch.Elapsed;

    mmotest.Lines.Add( 'FVtr.IterateSubtree ' + FloatToStr(Elapsed.TotalMilliseconds));
    Exit;
  end;
  if (GetKeyState(VK_MENU) < 0) then
  begin
    Stopwatch := TStopwatch.StartNew;
    dataAction := Sender.GetNodeData(node.FirstChild);
    FVtr.OnExpanded := nil;
    //Sender.BeginUpdate;
    FVtr.FullExpand(node);
    //FVtr.IterateSubtree(vNomenMKB.FirstChild, IterateTempExpand, dataAction);
   // FVtr.IterateSubtree(vNomenMKB, IterateTempFullExpand, dataAction);
    //Sender.EndUpdate;
    FVtr.OnExpanded := vtrExpanded;
    FVtr.OnMeasureItem := vtrTempMeasureItem;
    Elapsed := Stopwatch.Elapsed;

    mmotest.Lines.Add( 'FVtr.FullExpand ' + FloatToStr(Elapsed.TotalMilliseconds));
    Exit;
  end;
end;

procedure TTempVtrHelper.vtrMeasureItemAnal(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
begin

end;

procedure TTempVtrHelper.vtrMeasureItemDoctor(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
begin

end;

procedure TTempVtrHelper.vtrMeasureItemMkb(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
var
  data: PAspRec;
  txt: string;
  textW: Integer;
  Acol: Integer;
  Rows: Integer;
begin
  inherited;
  data := Sender.GetNodeData(node);
  Acol := 1;
  case data.vid of
    vvPatient, vvPregledNew:
    begin
      Acol := 0;
    end;
  end;

  txt := Fvtr.Text[node, Acol];
  textW:= TargetCanvas.TextWidth(txt)  ;
  Rows :=(textW div (Fvtr.Header.Columns[Acol].Width - 10) + 2);
  if Rows = 1 then
    Rows := 2;

  NodeHeight := (rows * 13) ;
end;

procedure TTempVtrHelper.vtrMeasureItemOldMenu(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
begin

end;

//procedure TTempVtrHelper.vtrMKBChecked(Sender: TBaseVirtualTree;
//  Node: PVirtualNode);
//var
//  data, dataPreg, dataPat, dataMkb, dataMkbAdd1, dataMkbAdd2: PAspRec;
//  tempViewportPosition: TPointF;
//  i: integer;
//  pregled: TRealPregledNewItem;
//  vMkb, vmkbAdd1, vmkbAdd2: PVirtualNode;
//begin
//  data := Fvtr.GetNodeData(node);
//  CurrentPregled := FmxProfForm.Pregled;
//  case data.vid of
//    vvMKB:
//    begin
//      if (csCheckedNormal = Node.CheckState) then
//      begin
//        CurrentPregled.CanDeleteDiag := False;
//        //Caption := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
//        Adb_DM.AddNewDiag(CurrentPregled.FNode, Adb_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE)), '', CurrentPregled.FDiagnosis.Count, Data.DataPos);
//        CurrentPregled.FDiagnosis.Add(Adb_DM.CollDiag.Items[Adb_DM.CollDiag.Count - 1]);
//        dataPat := Pointer(PByte(CurrentPregled.FNode.Parent) + lenNode);
//        dataPreg := Pointer(PByte(CurrentPregled.FNode) + lenNode);
//        FmxProfForm.AddDiag(nil, nil, FmxProfForm.Pregled.FDiagnosis.Count, Adb_DM.CollDiag.Items[Adb_DM.CollDiag.Count - 1]);
//        FmxProfForm.xpdrDiagn.RecalcSize;
//        FmxProfForm.lytDiagFrame.Height := FmxProfForm.xpdrDiagn.Height + 30;
//        //tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
//        //ShowPregledFMX(dataPat, dataPreg, FmxProfForm.Pregled.FNode);
//        //FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
//        data.index := FmxProfForm.Pregled.FDiagnosis[FmxProfForm.Pregled.FDiagnosis.Count - 1].DataPos;
//        FmxProfForm.Pregled.FDiagnosis[FmxProfForm.Pregled.FDiagnosis.Count - 1].MkbNode := Node;
//        FmxProfForm.Pregled.CanDeleteDiag := true;
//
//        vMkb := FVtr.CopyTo(Node, vDiagPreg, amAddChildLast, false);
//        dataMkb := FVtr.GetNodeData(vMkb);
//        dataMkb.vid := vvMKB;
//        dataMkb.DataPos := data.DataPos;
//
//        vmkbAdd1 := Node.FirstChild;
//        vmkbAdd2 := vMkb.FirstChild;
//        while vmkbAdd2 <> nil do
//        begin
//          dataMkbAdd1 := FVtr.GetNodeData(vmkbAdd1);
//          dataMkbAdd2 := FVtr.GetNodeData(vmkbAdd2);
//          dataMkbAdd2.vid := dataMkbAdd1.vid;
//          dataMkbAdd2.DataPos := dataMkbAdd1.DataPos;
//
//          vmkbAdd1 := vmkbAdd1.NextSibling;
//          vmkbAdd2 := vmkbAdd2.NextSibling;
//        end;
//      end
//      else
//      begin
//        //Caption := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
//        FmxProfForm.Pregled.CanDeleteDiag := False;
//        for i := 0 to FmxProfForm.Pregled.FDiagnosis.Count - 1 do
//        begin
//          if FmxProfForm.Pregled.FDiagnosis[i].MkbNode = node then
//          begin
//
//            Adb_DM.CollPregled.streamComm.Size := 0;
//            Adb_DM.CollPregled.streamComm.OpType := toDeleteNode;
//            Adb_DM.CollPregled.streamComm.Size := 12 + 4;
//            Adb_DM.CollPregled.streamComm.Ver := 0;
//            Adb_DM.CollPregled.streamComm.Vid := ctLink;
//            Adb_DM.CollPregled.streamComm.DataPos := Cardinal(FmxProfForm.Pregled.FDiagnosis[i].Node);
//            Adb_DM.CollPregled.streamComm.Propertys := [];
//            Adb_DM.CollPregled.streamComm.Len := Adb_DM.CollPregled.streamComm.Size;
//            Adb_DM.cmdFile.CopyFrom(Adb_DM.CollPregled.streamComm, 0);
//            FmxProfForm.Pregled.FDiagnosis.Delete(i);
//            Break;
//          end;
//        end;
//
//        RemoveDiag(FmxProfForm.Pregled.FNode, cardinal(Data.index));
//
//        dataPat := Pointer(PByte(FmxProfForm.Pregled.FNode.Parent) + lenNode);
//        dataPreg := Pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode);
//        //tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
////        ShowPregledFMX(dataPat, dataPreg, FmxProfForm.Pregled.FNode);
////        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
//        FmxProfForm.Pregled.CanDeleteDiag := true;
//
//        vMkb := vDiagPreg.FirstChild;
//        while vMkb <> nil do
//        begin
//          dataMkb := FVtr.GetNodeData(vMkb);
//          if dataMkb.DataPos = Data.DataPos then
//          begin
//            FVtr.DeleteNode(vmkb);
//            Break;
//          end;
//          vMkb := vMkb.NextSibling;
//        end;
//      end;
//    end;
//  end;
//end;

procedure TTempVtrHelper.vtrMkbGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
  posCl22: cardinal;//AspectsNomHipFile.Buf
begin
  data := Sender.GetNodeData(node);
  case data.vid of
    vvPatient:
    begin
      case Column of
        0:
        begin
          CellText := 'Диагнози на пациента';
        end;
        1:
        begin

        end;
      end;
    end;
    vvPregledNew:
    begin
      case Column of
        0:
        begin
          CellText := 'Диагнози в текущия преглед';
        end;
        1:
        begin
          CellText := 'АЛ ' + IntToStr(data.DataPos);
        end;
      end;
    end;
    vvNomenMkb:
    begin
      case Column of
        0:
        begin
          CellText := 'МКБ - Номенклатура';
        end;
        1:
        begin

        end;
      end;
    end;
    vvMKBGroup:
    begin
      case Column of
        0:
        begin
          CellText := Adb_DM.CollMkb.MkbGroups[Data.index].Split([#9])[1];
        end;
        1:
        begin
          CellText := Adb_DM.CollMkb.MkbGroups[Data.index].Split([#9])[2];
        end;
      end;

    end;
    vvMKBSubGroup:
    begin
      case Column of
        0:
        begin
          CellText := Adb_DM.CollMkb.MkbSubGroups[Data.index].Split([#9])[2];
        end;
        1:
        begin
          CellText := Adb_DM.CollMkb.MkbSubGroups[Data.index].Split([#9])[3];
        end;
      end;

    end;
    vvMKB:
    begin
      case Column of
        0:
        begin
          CellText := Adb_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
        end;
        1:
        begin
          CellText := Adb_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_NAME));
        end;
        2:
        begin
          if true then
          begin
            //CellText := IntToStr(CollMkb.Items[Data.index].Version);
          end;
        end;
      end;
    end;
    vvMKBAdd:
    begin
      case Column of
        0:
        begin
          if data.DataPos > 0 then
          begin
            //data.index.ToString();
            CellText := Adb_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
          end;
        end;
        1:
        begin
          if data.DataPos > 0 then
          begin
            CellText := Adb_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_NAME));
          end;
        end;

      end;
    end;
  end;

end;

procedure TTempVtrHelper.vtrOldMenuChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin

end;

procedure TTempVtrHelper.vtrOldMenuGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
begin
  data := Sender.GetNodeData(node);
  CellText := ListBlanki[node.Index];
end;

procedure TTempVtrHelper.vtrTempAnalLoadNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Stream: TStream);
var
  data: PAspRec;
begin
  data := Sender.GetNodeData(node);
  Stream.read(data^, sizeof(TAspRec));
end;

procedure TTempVtrHelper.vtrTempInitChildrenDoctor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
begin

end;

procedure TTempVtrHelper.vtrTempInitChildrenMKB(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  data: PAspRec;
  mkbNote: string;
  arrstr: TArray<string>;
  i: integer;
begin
  data := Sender.GetNodeData(node);
  Node.States := node.States + [vsMultiline];
  case data.vid of
    vvMKB:
    begin
      mkbNote := Adb_DM.CollMkb.getAnsiStringMap(Data.DataPos, Word(Mkb_NOTE));
      if mkbNote.Contains('*)') then
         Sender.HasChildren[Node] := True;
      arrstr := mkbNote.Split(['(', ')']);
      for i := 0 to Length(arrstr) - 1 do
      begin
        if arrstr[i].EndsWith('*') then
        begin
           //inc(ChildCount);
          //ls.Add(arrstr[i].Replace('*', ''));
        end;
      end;
    end;
  end;
end;

procedure TTempVtrHelper.vtrTempInitNodeDoctor(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.States := node.States + [vsMultiline];
end;

procedure TTempVtrHelper.vtrTempInitNodeMKB(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  data, dataAdd: PAspRec;
  mkbNote: string;
  arrstr: TArray<string>;
  arrCard: TArray<Cardinal>;
  ls: TStringList;
  i, j, IndexMkb: Integer;
  vAddMkb: PVirtualNode;
begin
  data := Sender.GetNodeData(node);
  Node.States := node.States + [vsMultiline];
  case data.vid of
    vvMKB:
    begin
      mkbNote := Adb_DM.CollMkb.getAnsiStringMap(Data.DataPos, Word(Mkb_NOTE));
      if mkbNote.Contains('*)') then
      begin
        Sender.HasChildren[Node] := True;
        arrstr := mkbNote.Split(['(', ')']);
        for i := 0 to Length(arrstr) - 1 do
        begin

          if arrstr[i].EndsWith('*') then
          begin
            arrstr[i] := arrstr[i].Replace(' ', '');
            arrstr[i] := arrstr[i].Replace('—', '-');
            arrstr[i] := arrstr[i].Replace('М', 'M');
            arrstr[i] := arrstr[i].Replace('К', 'K');
            arrstr[i] := arrstr[i].Replace('Н', 'H');
            arrstr[i] := arrstr[i].Replace('I', 'I');
            if self.FindMkbDataPosFromCode(arrstr[i].Replace('*', ''), indexMkb) then
            begin
              vAddMkb := Sender.AddChild(Node, nil);
              vAddMkb.CheckType := ctRadioButton;
              dataAdd := Sender.GetNodeData(vAddMkb);
              dataAdd.vid := vvMKBAdd;
              dataAdd.DataPos := Adb_DM.CollMkb.Items[IndexMkb].DataPos;
            end
            else
            begin
              arrCard := self.SplitMKB_Add(arrstr[i]);
              if Length(arrCard) = 0 then
              begin
                //dataAdd.DataPos := 0;

                mmoTest.Lines.Add(Adb_DM.CollMkb.getAnsiStringMap(Data.DataPos, Word(Mkb_CODE)) + '...........' + arrstr[i]);
              end
              else
              begin
                for j := 0 to Length(arrCard) - 1 do
                begin
                  vAddMkb := Sender.AddChild(Node, nil);
                  vAddMkb.CheckType := ctRadioButton;
                  dataAdd := Sender.GetNodeData(vAddMkb);
                  dataAdd.vid := vvMKBAdd;
                  dataAdd.DataPos := arrCard[j];
                end;
              end;
            end;
          end;
        end;
      end;

    end;
    vvNone:
    begin
      //data.vid := vvMKBAdd;

      //Node.CheckType := ctRadioButton;
    end;
  end;
end;

procedure TTempVtrHelper.vtrTempMeasureItem(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
var
  h0, h1: integer;
  data: PAspRec;
  txt: string;
  textW, row: Integer;
begin
  inherited;
  data := Sender.GetNodeData(node);
  txt := Fvtr.Text[node, 1];
  textW:= TargetCanvas.TextWidth(txt)  ;

  NodeHeight := ((textW div (Fvtr.Header.Columns[1].Width - 10)) + 2) * 13 ;
end;

end.
