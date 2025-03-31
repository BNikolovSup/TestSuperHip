unit DllSuperProcedures;

interface
uses
  Winapi.Windows, Winapi.Messages, system.Classes, system.SysUtils, System.DateUtils,System.Variants,
  Xml.XMLDoc,
  NzisSuperCollection, Nzis.Types, NZIS.Pregled.SuperMessages, NZIS.MDN.SuperMessages,
  R010, DM;
type
  TDllProcedure = class(TObject)
  private
    FOnX002: TOnResponsePregFromNZIS;
    FOnX006: TOnResponsePregFromNZIS;
    FOnX004: TOnResponsePregFromNZIS;
    FOnX008: TOnResponsePregFromNZIS;
    FOnX010: TOnResponsePregFromNZIS;
    FOnX014: TOnResponsePregFromNZIS;
    FOnX012: TOnResponsePregFromNZIS;
    FOnR010: TOnResponseMDNFromNZIS;
    FOnR002: TOnResponseMDNFromNZIS;
    FOnR008: TOnResponseMDNFromNZIS;
    FOnR004: TOnResponseMDNFromNZIS;
    FOnR012: TOnResponseMDNFromNZIS;

    FOnR002MN: TOnResponseMDNFromNZIS;
    FOnR008MN: TOnResponseMDNFromNZIS;
    FOnR004MN: TOnResponseMDNFromNZIS;

    FOnR002MN3A: TOnResponseMDNFromNZIS;
    FOnR004MN3A: TOnResponseMDNFromNZIS;
    FOnR008MN3A: TOnResponseMDNFromNZIS;

    FOnR002MN6: TOnResponseMDNFromNZIS;
    FOnR004MN6: TOnResponseMDNFromNZIS;
    FOnR008MN6: TOnResponseMDNFromNZIS;
    FOnR016MN: TOnResponseMDNFromNZIS;
    FOnR016MN_EGN: TOnResponseMDNFromNZIS;
    FOnR016MDN_EGN: TOnResponseMDNFromNZIS;
    FOnR006: TOnResponseMDNFromNZIS;
    FOnR018MDN: TOnResponseMDNFromNZIS;
    FOnR002Hosp: TOnResponseMDNFromNZIS;
    FOnR008MNHosp: TOnResponseMDNFromNZIS;
    FOnC010: TOnResponseMDNFromNZIS;
    FOnC008: TOnResponseMDNFromNZIS;
    FOnC042: TOnResponseMDNFromNZIS;
    FOnC024: TOnResponseMDNFromNZIS;
    FOnC046: TOnResponseMDNFromNZIS;


  public
    constructor create;
    procedure ProcOnX002(Pregled, PregMess: TObject);
    procedure ProcOnX004(Pregled, PregMess: TObject);
    procedure ProcOnX006(Pregled, PregMess: TObject);
    procedure ProcOnX008(Pregled, PregMess: TObject);
    procedure ProcOnX010(Pregled, PregMess: TObject);
    procedure ProcOnX012(Pregled, PregMess: TObject);
    procedure ProcOnX014(Pregled, PregMess: TObject);

    procedure ProcOnR010(MDN, MDNMess: TObject);
    procedure ProcOnR002(MDN, MDNMess: TObject);
    procedure ProcOnR002MN(MN, MDNMess: TObject);
    procedure ProcOnR002MN3A(MN, MDNMess: TObject);
    procedure ProcOnR002MN6(MN, MDNMess: TObject);
    procedure ProcOnR002Hosp(MN, MDNMess: TObject);

    procedure ProcOnR004(MDN, MDNMess: TObject);
    procedure ProcOnR004MN(MN, MDNMess: TObject);
    procedure ProcOnR008(MDN, MDNMess: TObject);
    procedure ProcOnR006(MDN, MDNMess: TObject);
    procedure ProcOnR008MN(MN, MDNMess: TObject);
    procedure ProcOnR008MN3A(MN, MDNMess: TObject);
    procedure ProcOnR008MN6(MN, MDNMess: TObject);
    procedure ProcOnR008MNHosp(MN, MDNMess: TObject);

    procedure ProcOnR012(MDN, MDNMess: TObject);
    procedure ProcOnR016MN(MN, MDNMess: TObject);
    procedure ProcOnR016MN_EGN(MN, MDNMess: TObject);
    procedure ProcOnR016MDN_EGN(MN, MDNMess: TObject);

    procedure ProcOnR018MDN(MN, MDNMess: TObject);
    procedure ProcOnC010(MDN, MDNMess: TObject);
    procedure ProcOnC042(MB, MBMess: TObject);
    procedure ProcOnC046(MB, MBMess: TObject);
    procedure ProcOnC024(Allergy, AllergyMess: TObject);


    procedure GenResult(MDNMess: TObject);
    function GetCl024NoteFromDB(code: string; mdnMessage: TMDNMessages): string;

    property OnX002: TOnResponsePregFromNZIS read FOnX002 write FOnX002;
    property OnX004: TOnResponsePregFromNZIS read FOnX004 write FOnX004;
    property OnX006: TOnResponsePregFromNZIS read FOnX006 write FOnX006;
    property OnX008: TOnResponsePregFromNZIS read FOnX008 write FOnX008;
    property OnX010: TOnResponsePregFromNZIS read FOnX010 write FOnX010;
    property OnX012: TOnResponsePregFromNZIS read FOnX012 write FOnX012;
    property OnX014: TOnResponsePregFromNZIS read FOnX014 write FOnX014;

    property OnR010: TOnResponseMDNFromNZIS read FOnR010 write FOnR010;
    property OnR002: TOnResponseMDNFromNZIS read FOnR002 write FOnR002;
    property OnR002MN: TOnResponseMDNFromNZIS read FOnR002MN write FOnR002MN;
    property OnR002MN3A: TOnResponseMDNFromNZIS read FOnR002MN3A write FOnR002MN3A;
    property OnR002MN6: TOnResponseMDNFromNZIS read FOnR002MN6 write FOnR002MN6;
    property OnR002Hosp: TOnResponseMDNFromNZIS read FOnR002Hosp write FOnR002Hosp;

    property OnR004: TOnResponseMDNFromNZIS read FOnR004 write FOnR004;
    property OnR004MN: TOnResponseMDNFromNZIS read FOnR004MN write FOnR004MN;
    property OnR004MN3A: TOnResponseMDNFromNZIS read FOnR004MN3A write FOnR004MN3A;
    property OnR004MN6: TOnResponseMDNFromNZIS read FOnR004MN6 write FOnR004MN6;

    property OnR006: TOnResponseMDNFromNZIS read FOnR006 write FOnR006;

    property OnR008: TOnResponseMDNFromNZIS read FOnR008 write FOnR008;
    property OnR008MN: TOnResponseMDNFromNZIS read FOnR008MN write FOnR008MN;
    property OnR008MN3A: TOnResponseMDNFromNZIS read FOnR008MN3A write FOnR008MN3A;
    property OnR008MN6: TOnResponseMDNFromNZIS read FOnR008MN6 write FOnR008MN6;
    property OnR008MNHosp: TOnResponseMDNFromNZIS read FOnR008MNHosp write FOnR008MNHosp;

    property OnR016MN_EGN: TOnResponseMDNFromNZIS read FOnR016MN_EGN write FOnR016MN_EGN;
    property OnR016MDN_EGN: TOnResponseMDNFromNZIS read FOnR016MDN_EGN write FOnR016MDN_EGN;

    property OnR012: TOnResponseMDNFromNZIS read FOnR012 write FOnR012;

    property OnR016MN: TOnResponseMDNFromNZIS read FOnR016MN write FOnR016MN;
    property OnR018MDN: TOnResponseMDNFromNZIS read FOnR018MDN write FOnR018MDN;

     property OnC010: TOnResponseMDNFromNZIS read FOnC010 write FOnC010;
     property OnC008: TOnResponseMDNFromNZIS read FOnC008 write FOnC008;
     property OnC042: TOnResponseMDNFromNZIS read FOnC042 write FOnC042;
     property OnC046: TOnResponseMDNFromNZIS read FOnC046 write FOnC046;
     property OnC024: TOnResponseMDNFromNZIS read FOnC024 write FOnC024;

   // property OnH012: TOnResponseMDNFromNZIS read FOnR018MDN write FOnR018MDN;
  end;

implementation


{ TDllProcedure }

constructor TDllProcedure.create;
begin
  inherited;
  OnX002 := ProcOnX002;
  OnX004 := ProcOnX004;
  OnX006 := ProcOnX006;
  OnX008 := ProcOnX008;
  OnX010 := ProcOnX010;
  OnX012 := ProcOnX012;
  OnX014 := ProcOnX014;

  OnR010 := ProcOnR002MN;
  OnR002 := ProcOnR002;
  OnR002MN := ProcOnR002MN;
  OnR002MN3A := ProcOnR002MN3A;
  OnR002MN6 := ProcOnR002MN6;
  OnR002Hosp := ProcOnR002Hosp;

  OnR004 := ProcOnR004;
  OnR008 := ProcOnR008;
  OnR006 := ProcOnR006;
  OnR008MN := ProcOnR008MN;
  OnR008MN3A := ProcOnR008MN3A;
  OnR008MN6 := ProcOnR008MN6;
  OnR008MNHosp := ProcOnR008MNHosp;

  OnR016MN_EGN := ProcOnR016MN_EGN;
  OnR016MDN_EGN := ProcOnR016MDN_EGN;

  OnR012 := ProcOnR012;
  OnR016MN := ProcOnR002MN;
  OnC042 := ProcOnC042;
  OnC046 := ProcOnC046;
  OnC024 := ProcOnC024;
end;

procedure TDllProcedure.GenResult(MDNMess: TObject);
var
  AR010: R010.IXMLMessageType;
  ResReferal: IXMLResultsType;
  Proc: IXMLProcedureType;
  izsl: IXMLObservationType;
  i, j, k, m, n, c: Integer;
  KeyCL024: Integer;
  strCL024: string;

  mdnMessage: TMDNMessages;
  MDN: TMdnItem;
  xmlDoc: TXMLDocument;
  ls: TStringList;
  resInfo: TNzisResultInfo;
begin
  mdnMessage := TMDNMessages(MDNMess);
  //Amdn := TMdnItem(MDN);
  xmlDoc := TXMLDocument.Create(nil);
  xmlDoc.XML.Assign(mdnMessage.ResultNzis);
  AR010 := R010.Getmessage(xmlDoc);
  ls := TStringList.Create;

  try
    for i := 0 to AR010.Contents.Results.Count - 1 do
    begin
      MDN := nil;
      ls.Clear;
      ResReferal :=  AR010.Contents.Results[i];
      for m := 0 to mdnMessage.emdnColl.count - 1 do
      begin
        if ResReferal.Referral.NrnReferral.Value = mdnMessage.emdnColl.Items[m].NRN then
        begin
          MDN := mdnMessage.emdnColl.Items[m];
          Break;
        end;
      end;
      if mdn = nil then Continue;

      //ls.Add('НРН: ' + ResReferal.Referral.NrnReferral.Value);
      for j  := 0 to ResReferal.Execution.Count - 1 do
      begin
        for n := 0 to ResReferal.Execution.Items[j].Procedure_.Count - 1 do
        begin
          Proc := ResReferal.Execution.Items[j].Procedure_[n];
          //for c := 0 to Proc.ChildNodes.Count - 1 do
//          begin
//            if Proc.ChildNodes.Nodes[c].NodeName = 'nhis:observation' then
//                Continue;
//            if Proc.ChildNodes.Nodes[c].NodeName = 'nhis:code' then
//            begin
//              ls.Add(Proc.ChildNodes.Nodes[c].AttributeNodes['value'].Text);
//              //if not varisnull(Proc.ChildNodes.Nodes[c].NodeValue) then
////              begin
////                ls.Add(Proc.ChildNodes.Nodes[c].NodeValue);
////              end;
//
//            end;
//          end;
          ls.Add(Proc.Code.Value);
          for k := 0 to Proc.Observation.Count - 1 do
          begin
            izsl := Proc.Observation[k];
            if izsl.Code.Value <> '00-F00-00' then
            begin
              strCL024 := GetCl024NoteFromDB(izsl.Code.Value, mdnMessage) + ': ';
            end
            else
            begin
              strCL024 := '';
            end;
            case izsl.ValueScale.Value[1] of
              '1':
              begin
                ls.Add(strCL024 +  izsl.ValueQuantity.Value + ' ' + izsl.ValueUnit.Value);
              end;
              '2':
              begin
                case izsl.ValueCode.Value of
                  1: ls.Add(strCL024 +  'Позитивен');
                  2: ls.Add(strCL024 +  'Негативен');
                  3: ls.Add(strCL024 +  'Неопределим');
                  4: ls.Add(strCL024 +  'РАР I - Нормални клетки');
                  5: ls.Add(strCL024 +  'РАР II - Клетки показващи най-често възпалителни промени или метаплазия (доброкачествени промени), HPV инфекция');
                  6: ls.Add(strCL024 +  'РАР III - Граничен резултат');
                  7: ls.Add(strCL024 +  'РАР ІІІА - Тежко възпалено или дегенеративно изменение');
                  8: ls.Add(strCL024 +  'РАР ІІІВ - Лека до среднотежка дисплазия (ЦИН I или II). Няма наличие на ракови клетки. Измененията могат да се развият до раков процес');
                  9: ls.Add(strCL024 +  'РАР IV - Тежка дисплазия, наличие на единични ракови клетки');
                  10: ls.Add(strCL024 +  'РАР V - Наличие на множество ракови клетки, инвазивен карцином');
                end;
              end;
              '3':
              begin
                ls.Add(strCL024 +  izsl.ValueString.Value);
              end;

            end;

            if Proc <> nil then
            begin
              resInfo.result := ls.Text;
              resInfo.analCode := proc.Code.Value;
              resInfo.NRN_EXECUTION := ResReferal.Execution[j].NrnExecution.Value;
              resInfo.data := ISO8601ToDate(Proc.PerformedDateTime.Value);
              MDN.ResultHip.Add(resInfo);
            end;
          end;
          ls.Clear;
        end;
      end;
    end;
  finally
    ls.Free;
    //xmlDoc.Free;
  end;
end;

function TDllProcedure.GetCl024NoteFromDB(code: string; mdnMessage: TMDNMessages): string;
begin
  mdnMessage.ibsqlCommand.Close;
  mdnMessage.ibsqlCommand.SQL.Text :=
        'select cl24.description from nzis_cl024 cl24' + #13#10 +
        'where cl24."KEY" = :key';
  mdnMessage.ibsqlCommand.ParamByName('key').AsString := code;
  mdnMessage.ibsqlCommand.ExecQuery;
  Result := mdnMessage.ibsqlCommand.Fields[0].AsString;
  mdnMessage.ibsqlCommand.Close;
end;

procedure TDllProcedure.ProcOnC010(MDN, MDNMess: TObject);
begin
//
end;

procedure TDllProcedure.ProcOnC024(Allergy, AllergyMess: TObject);
var
  eAllergy: TAllergyItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  //eAllergy := TMedBelItem(Allergy);
  if eAllergy.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := eAllergy.LRN.Value;
    NzisInfo.MDN_ID := eAllergy.AllergyID;
    NzisInfo.Status := eAllergy.HipStatus;
    NzisInfo.err := eAllergy.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(eAllergy.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if eAllergy.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := eAllergy.NRN;
    NzisInfo.LRN := eAllergy.LRN.Value;
    NzisInfo.MDN_ID := eAllergy.AllergyID;
    NzisInfo.Status := eAllergy.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(eAllergy.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnC042(MB, MBMess: TObject);
var
  eMedBel: TMedBelItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  eMedBel := TMedBelItem(MB);
  if eMedBel.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := eMedBel.LRN.Value;
    NzisInfo.MDN_ID := eMedBel.MedBelID;
    NzisInfo.Status := eMedBel.HipStatus;
    NzisInfo.err := eMedBel.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(eMedBel.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if eMedBel.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := eMedBel.NRN;
    NzisInfo.LRN := eMedBel.LRN.Value;
    NzisInfo.MDN_ID := eMedBel.MedBelID;
    NzisInfo.Status := eMedBel.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(eMedBel.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnC046(MB, MBMess: TObject);
var
  eMedBel: TMedBelItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  eMedBel := TMedBelItem(MB);
  if eMedBel.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := eMedBel.NRN;
    NzisInfo.LRN := eMedBel.LRN.Value;
    NzisInfo.MDN_ID := eMedBel.MedBelID;
    NzisInfo.Status := eMedBel.HipStatus;
    NzisInfo.err := eMedBel.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(eMedBel.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if eMedBel.HipStatus = hmsCancel then
  begin
    NzisInfo.NRN := eMedBel.NRN;
    NzisInfo.LRN := eMedBel.LRN.Value;
    NzisInfo.MDN_ID := eMedBel.MedBelID;
    NzisInfo.Status := eMedBel.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(eMedBel.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR002(MDN, MDNMess: TObject);
var
  emdn: TMdnItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emdn := TMdnItem(MDN);
  if emdn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := emdn.LRN.Value;
    NzisInfo.MDN_ID := emdn.MdnID;
    NzisInfo.Status := emdn.HipStatus;
    NzisInfo.err := emdn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emdn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emdn.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := emdn.NRN;
    NzisInfo.LRN := emdn.LRN.Value;
    NzisInfo.MDN_ID := emdn.MdnID;
    NzisInfo.Status := emdn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emdn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR002Hosp(MN, MDNMess: TObject);
var
  emn: TMnHospItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMnHospItem(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR002MN(MN, MDNMess: TObject);
var
  emn: TMnItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMnItem(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR002MN3A(MN, MDNMess: TObject);
var
  emn: TMn3AItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMn3AItem(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR002MN6(MN, MDNMess: TObject);
var
  emn: TMn6Item;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMn6Item(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := '';
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsSended then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR004(MDN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR004MN(MN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR006(MDN, MDNMess: TObject);
begin
  //
end;

procedure TDllProcedure.ProcOnR008(MDN, MDNMess: TObject);
var
  emdn: TMdnItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emdn := TMdnItem(MDN);
  if emdn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := emdn.NRN;
    NzisInfo.LRN := emdn.LRN.Value;
    NzisInfo.MDN_ID := emdn.MdnID;
    NzisInfo.Status := emdn.HipStatus;
    NzisInfo.err := emdn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emdn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emdn.HipStatus = hmsCancel then
  begin
    NzisInfo.NRN := emdn.NRN;
    NzisInfo.LRN := emdn.LRN.Value;
    NzisInfo.MDN_ID := emdn.MdnID;
    NzisInfo.Status := emdn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emdn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR008MN(MN, MDNMess: TObject);
var
  emn: TMnItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMnItem(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    //if emn.ErrReason = 'Това направление не в статус Активно' then
//    begin
//      emn.ErrReason := '';
//      emn.HipStatus := hmsCancel;
//      ProcOnR008MN(MN, MDNMess);
//      Exit;
//    end;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsCancel then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR008MN3A(MN, MDNMess: TObject);
var
  emn: TMn3AItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMn3AItem(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsCancel then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR008MN6(MN, MDNMess: TObject);
var
  emn: TMn6Item;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMn6Item(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsCancel then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR008MNHosp(MN, MDNMess: TObject);
var
  emn: TMnHospItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisMDNInfo;
begin
  emn := TMnHospItem(MN);
  if emn.HipStatus = hmsErr then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := emn.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if emn.HipStatus = hmsCancel then
  begin
    NzisInfo.NRN := emn.NRN;
    NzisInfo.LRN := emn.LRN.Value;
    NzisInfo.MDN_ID := emn.MnID;
    NzisInfo.Status := emn.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(emn.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnR010(MDN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR012(MDN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR016MDN_EGN(MN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR016MN(MN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR016MN_EGN(MN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnR018MDN(MN, MDNMess: TObject);
begin

end;

procedure TDllProcedure.ProcOnX002(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  if preg.HipStatus = hpsErr then
  begin
    if preg.NrnExamination <> nil then
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
    end
    else
    begin
      NzisInfo.NRN := '';
    end;
    NzisInfo.LRN := preg.LRN;
    NzisInfo.PregledID := preg.PregledId;
    NzisInfo.Status := preg.HipStatus;
    NzisInfo.err := preg.ErrReason;

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end
  else
  if preg.HipStatus = hpsOpen then
  begin
    NzisInfo.NRN := preg.NrnExamination.Value;
    NzisInfo.LRN := preg.LRN;
    NzisInfo.PregledID := preg.PregledId;
    NzisInfo.Status := preg.HipStatus;
    NzisInfo.err := '';

    copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
    copyDataStruct.cbData := SizeOf(NzisInfo);
    copyDataStruct.lpData := @NzisInfo;
    SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
  end;
end;

procedure TDllProcedure.ProcOnX004(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  case preg.HipStatus of
    hpsNone:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := hpsErr;
      NzisInfo.err := 'Неуспешна комуникация';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsErr:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := preg.ErrReason;

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsClosed:
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := '';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
  end;
end;

procedure TDllProcedure.ProcOnX006(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  case preg.HipStatus of
    hpsErr:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := preg.ErrReason;

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsOpen, hpsClosed, hpsCancel:
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := '';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
  end;
end;

procedure TDllProcedure.ProcOnX008(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  case preg.HipStatus of
    hpsErr:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := preg.ErrReason;

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsCancel:
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := '';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
  end;
end;

procedure TDllProcedure.ProcOnX010(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  case preg.HipStatus of
    hpsNone:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := hpsErr;
      NzisInfo.err := 'Неуспешна комуникация';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsErr:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := preg.ErrReason;
      if NzisInfo.err = 'Не е намерен преглед с подадената комбинация НРН и ЛРН' then
      begin
        NzisInfo.err := 'Не е намерен преглед за корекция';
      end;

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsOpen, hpsClosed:
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := '';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
  end;
end;

procedure TDllProcedure.ProcOnX012(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  case preg.HipStatus of
    hpsErr:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := preg.ErrReason;

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsOpen, hpsClosed:
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := '';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
  end;
end;

procedure TDllProcedure.ProcOnX014(Pregled, PregMess: TObject);
var
  preg: TPregledNzisItem;
  copyDataStruct: TCopyDataStruct;
  NzisInfo: TNzisPregledInfo;
begin
  preg := TPregledNzisItem(Pregled);
  case preg.HipStatus of
    hpsNone:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := hpsErr;
      NzisInfo.err := 'Неуспешна комуникация';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsErr:
    begin
      if preg.NrnExamination <> nil then
      begin
        NzisInfo.NRN := preg.NrnExamination.Value;
      end
      else
      begin
        NzisInfo.NRN := '';
      end;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := preg.ErrReason;

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
    hpsOpen, hpsClosed:
    begin
      NzisInfo.NRN := preg.NrnExamination.Value;
      NzisInfo.LRN := preg.LRN;
      NzisInfo.PregledID := preg.PregledId;
      NzisInfo.Status := preg.HipStatus;
      NzisInfo.err := '';

      copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(NzisInfo);
      copyDataStruct.lpData := @NzisInfo;
      SendMessage(preg.HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
    end;
  end;
end;

end.
