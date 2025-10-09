unit HistoryThread;
     // save<
interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, IBX.IBSQL, Aspects.Types,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections, DM, Winapi.ActiveX, system.Variants, VirtualTrees,
  IBX.IBEvents,
  DBCollection.Patient, DBCollection.Pregled, DBCollection.Diagnosis, DBCollection.MedNapr,
  VCLTee.Grid, Tee.Grid.Ticker, Aspects.Collections,
  RealObj.RealHipp, VirtualStringTreeAspect, Table.Unfav, Table.PregledNew, Table.PatientNew,
  Table.Doctor,
  DbHelper
  ;

type

THistoryThread = class(TThread)
  private
    FGuid: TGUID;
    FBuf: Pointer;
    FDataPos: Cardinal;
    ib: TIBSQL;
    NewID: Integer;
    FStop: Boolean;
    FOnEventAlert: TNotifyEvent;
    FOnIndexedPregled: TNotifyEvent;
    FBufLink: Pointer;
    FOnDeleteEvent: TNotifyEvent;
    function GetComputerNam: string;

    procedure UpdateDoctor(id: Integer);
    procedure InsertDoctor(id: Integer);
    procedure DeleteDoctor(id: Integer);

    procedure UpdateUnfav(id: Integer);
    procedure InsertUnfav(id: Integer);
    procedure DeleteUnfav(id: Integer);

    procedure UpdatePregled(id: Integer);
    procedure InsertPregled(id: Integer);
    procedure DeletePregled(id: Integer);

    procedure UpdatePatient(id: Integer);
    procedure InsertPatient(id: Integer);
    procedure DeletePatient(id: Integer);

    function FindItemADB(Id: Integer; ABuf, ABufLink: Pointer; VV: TVtrVid): TBaseItem;
    procedure SetBuf(const Value: Pointer);
    procedure SetDataPos(const Value: Cardinal);
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    Fdm: TDUNzis;
    ibvnts1: TIBEvents;
    procedure Execute; override;
    procedure DoTerminate; override;
    procedure ibvnts1EventAlert(Sender: TObject; EventName: string; EventCount: Integer; var CancelAlerts: Boolean);
    procedure GetChanges(IdHistory: integer);
  public
    FCollUnfav: TRealUnfavColl;
    FCollPregled: TRealPregledNewColl;
    FCollDoctor: TRealDoctorColl;
    FCollPatient: TRealPatientNewColl;
    FCollDiag: TRealDiagnosisColl;
    FDBHelper: TDbHelper;

    FGrid: VCLTee.Grid.TTeeGrid;
    FVTR: TVirtualStringTreeAspect;

    Ticker : TGridTicker;
    cmdFile: TFileStream;
    constructor Create(CreateSuspended: Boolean; DbName: string);
    destructor Destroy; override;
    procedure TickerChange(Acol, ARow: Integer);
    property GUID: TGUID read FGuid write FGuid;
    property Buf: Pointer read FBuf write SetBuf;
    property BufLink: Pointer read FBufLink write FBufLink;
    property DataPos: Cardinal read FDataPos write SetDataPos;
    property Stop: Boolean read FStop write FStop;
    property OnEventAlert :TNotifyEvent read FOnEventAlert write FOnEventAlert;
    property OnDeleteEvent: TNotifyEvent read FOnDeleteEvent write FOnDeleteEvent;
    property OnIndexedPregled: TNotifyEvent read FOnIndexedPregled write FOnIndexedPregled;
  end;

implementation

{ TLoadDBThread }

constructor THistoryThread.Create(CreateSuspended: Boolean; DbName: string);
begin
  inherited Create(CreateSuspended);

  FCollPatient := TRealPatientNewColl.Create(TRealPatientNewItem);
  FStop := False;
  Fdm := TDUNzis.Create(nil);
  Fdm.InitDb(DbName);
  ib:= TIBSQL.Create(nil);
  ib.Database := Fdm.DBMain;
  ib.Transaction := Fdm.traMain;


  ibvnts1 := TIBEvents.Create(nil);

  ibvnts1.Name := 'ibvnts1';
  ibvnts1.AutoRegister := False;
  ibvnts1.Database := Fdm.DBMain;
  ibvnts1.Registered := False;
  ibvnts1.OnEventAlert := ibvnts1EventAlert;


  Fdm.traMain.Active := True;
  NewID := 0;

end;

procedure THistoryThread.DeleteDoctor(id: Integer);
begin

end;

procedure THistoryThread.DeletePatient(id: Integer);
var
  i: Integer;
  TempItem: TRealPatientNewItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  PWordData: PWord;
begin
  TempItem := TRealPatientNewItem.Create(nil);
  TempItem.PatID := id;
  if assigned(FOnDeleteEvent) then
    FOnDeleteEvent(TempItem);

  FreeAndNil(TempItem);

  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
end;

procedure THistoryThread.DeletePregled(id: Integer);
var
  i: Integer;
  TempItem: TRealPregledNewItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  PWordData: PWord;
begin
  TempItem := TRealPregledNewItem.Create(nil);
  TempItem.PregledID := id;
  if assigned(FOnDeleteEvent) then
    FOnDeleteEvent(TempItem);

  FreeAndNil(TempItem);
  //for i := 0 to FCollPregled.Count - 1 do
//  begin
//    TempItem := FCollPregled.Items[i];
//    if TempItem.getIntMap(Fbuf, FDataPos, word(PregledNew_ID)) = id then
//    begin
//      if assigned(FOnDeleteEvent) then
//        FOnDeleteEvent(TempItem);
//      PWordData := Pointer(pbyte(Buf) + TempItem.DataPos - 4);
//      PWordData^ := word(ctPregeledDel);
//      //FCollPregled.Delete(i);
//      Break;
//    end;
//  end;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
end;

procedure THistoryThread.DeleteUnfav(id: Integer);
var
  i: Integer;
  TempItem: TRealUnfavItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  PWordData: PWord;
begin
  for i := 0 to FCollUnfav.Count - 1 do
  begin
    TempItem := FCollUnfav.Items[i];
    if TempItem.getIntMap(Fbuf, FDataPos, word(Unfav_ID)) = id then
    begin
      PWordData := Pointer(pbyte(Buf) + TempItem.DataPos - 4);
      PWordData^ := word(ctUnfavDel);
      FCollUnfav.Delete(i);
      Break;
    end;
  end;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
end;

destructor THistoryThread.Destroy;
begin
  ibvnts1.Registered := False;
  FreeAndNil(ibvnts1);
  FreeAndNil(ib);
  FreeAndNil(fdm);
  FreeAndNil(FCollPatient);

  inherited;
end;

procedure THistoryThread.DoTerminate;
begin
  inherited;

end;

procedure THistoryThread.Execute;
var
  comInitStatus: THandle;
  b: Boolean;
  IsIndexedPregled: Boolean;
begin
  ReturnValue := 0;
  comInitStatus := S_FALSE;

  try
    comInitStatus := CoInitializeEx(nil, COINIT_MULTITHREADED);
    inherited;
    IsIndexedPregled := False;
    ibvnts1EventAlert(nil, '', 0, b);
    while  not Terminated do
    begin
      if Fstop then Break;

      if not ibvnts1.Registered then
      begin
        ibvnts1.Events.Clear;
        ibvnts1.Events.Add('Hist' + FGuid.ToString);
        ibvnts1.RegisterEvents;
      end;
      Sleep(50);
      //zzzzzzzzzzzzzzzzzzzz  това съм го закоментирал защото трие колекцията
      //if not IsIndexedPregled then
//      begin
//        FCollPregled.IndexValue(TPregledNewItem.TPropertyIndex.PregledNew_ANAMN);
//        FCollPregled.Clear;
//        if Assigned(FOnIndexedPregled) then
//        begin
//          FOnIndexedPregled(Self);
//        end;
//        IsIndexedPregled := True;
//      end;
    end;
  finally
    case comInitStatus of
      S_OK, S_FALSE: CoUninitialize;
    end;
  end;

end;


function THistoryThread.FindItemADB(Id: Integer; ABuf, ABufLink: Pointer; VV: TVtrVid): TBaseItem;
var
  linkPos, maxLinkPos: Cardinal;
  pCardinalData: PCardinal;
  ANode, runNode: PVirtualNode;
  data, runData: PAspRec;
  evnt: TRealEventsManyTimesItem;
  //ATempItem: TBaseItem;
begin
  //ATempItem := TBaseItem.Create(nil);
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(ABufLink));
  maxLinkPos := pCardinalData^;
  Anode := pointer(PByte(ABufLink) + linkPos);

  while linkPos < maxLinkPos  do
  begin
    ANode := pointer(PByte(ABufLink) + linkPos);
    data := pointer(PByte(ANode) + lenNode);
    if data.vid = VV then
    begin
      //ATempItem.DataPos := data.DataPos;
      case VV of
        vvPregled:
        begin
          if FCollPregled.getIntMap(Data.DataPos, word(PregledNew_ID)) = id then
          begin
            //FreeAndNil(ATempItem);
            Result := TRealPregledNewItem(FCollPregled.Add);
            Result.DataPos := data.DataPos;
            TRealPregledNewItem(Result).FNode := ANode;
            Exit;
          end;
        end;
        vvPatient:
        begin
          if FCollPatient.getIntMap(Data.DataPos, word(PatientNew_ID)) = id then
          begin
            //FreeAndNil(ATempItem);
            Result := TRealPatientNewItem(FCollPatient.Add);
            Result.DataPos := data.DataPos;
            TRealPatientNewItem(Result).FNode := ANode;
            runNode := ANode.FirstChild;
            while runNode <> nil do
            begin
              runData := pointer(PByte(runNode) + lenNode);
              if runData.vid = vvEvnt then
              begin
                evnt := TRealEventsManyTimesItem.Create(nil);
                evnt.DataPos := runData.DataPos;
                TRealPatientNewItem(Result).FEventsPat.Add(evnt);
              end;
              runNode := runNode.NextSibling;
            end;
            Exit;
          end;
        end;
        vvDoctor:
        begin
          if FCollDoctor.getIntMap(Data.DataPos, word(Doctor_ID)) = id then
          begin
            //FreeAndNil(ATempItem);
            Result := TRealDoctorItem(FCollDoctor.Add);
            Result.DataPos := data.DataPos;
            TRealDoctorItem(Result).node := ANode;
            Exit;
          end;
        end;
      end;
    end;
    Inc(linkPos, LenData);
  end;
end;

procedure THistoryThread.GetChanges(IdHistory: integer);
begin

end;

function THistoryThread.GetComputerNam: string;
var
  namSize: dword;
  compName: array[0..MAX_PATH] of AnsiChar;
begin
  namSize := MAX_PATH - 1;
  GetComputerNameA(compName, namSize);
  Result := compName;
end;

procedure THistoryThread.ibvnts1EventAlert(Sender: TObject; EventName: string; EventCount: Integer; var CancelAlerts: Boolean);
var
  TableName: AnsiString;
  TableAction: Byte;
  pCardinalData: PCardinal;
begin
  pCardinalData := pointer(PByte(FBuf) + 32);
  NewID := pCardinalData^;
  Fdm.ibsqlCommand.Close;
  Fdm.ibsqlCommand.SQL.Text :=
    'select * from history h' + #13#10 +
    'where h.id > :id';
  Fdm.ibsqlCommand.ParamByName('id').AsInteger := NewID;
  Fdm.ibsqlCommand.ExecQuery;
  while not Fdm.ibsqlCommand.Eof do
  begin
    TableName := Fdm.ibsqlCommand.Fields[1].AsString;
    TableAction := Fdm.ibsqlCommand.Fields[2].AsInteger;
    NewID := Fdm.ibsqlCommand.Fields[0].AsInteger;
    case TableName[1] of
      'D':
      begin
        case TableAction of
          21: DeleteDoctor(Fdm.ibsqlCommand.Fields[3].AsInteger);
          22: UpdateDoctor(Fdm.ibsqlCommand.Fields[3].AsInteger);
          23: InsertDoctor(Fdm.ibsqlCommand.Fields[3].AsInteger);
        end;
      end;
      'U':
      begin
        case TableAction of
          21: DeleteUnfav(Fdm.ibsqlCommand.Fields[3].AsInteger);
          22: UpdateUnfav(Fdm.ibsqlCommand.Fields[3].AsInteger);
          23: InsertUnfav(Fdm.ibsqlCommand.Fields[3].AsInteger);
        end;
      end;
      'P':
      begin
        case TableName[2] of
          'R': // pregled
          begin
            case TableAction of
              21: DeletePregled(Fdm.ibsqlCommand.Fields[3].AsInteger);
              22: UpdatePregled(Fdm.ibsqlCommand.Fields[3].AsInteger);
              23: InsertPregled(Fdm.ibsqlCommand.Fields[3].AsInteger);
            end;
          end;
        end;
        case TableName[2] of
          'A': //pacient
          begin
            case TableAction of
              21: DeletePatient(Fdm.ibsqlCommand.Fields[3].AsInteger);
              22: UpdatePatient(Fdm.ibsqlCommand.Fields[3].AsInteger);
              23: InsertPatient(Fdm.ibsqlCommand.Fields[3].AsInteger);
            end;
          end;
        end;
      end;
    end;

    Fdm.ibsqlCommand.Next;
  end;
  if Assigned(FOnEventAlert) then
    FOnEventAlert(Self);
end;

procedure THistoryThread.InsertDoctor(id: Integer);
begin

end;

procedure THistoryThread.InsertPatient(id: Integer);
begin

end;

procedure THistoryThread.InsertPregled(id: Integer);
var
  i: Integer;
  TempPregItem: TRealPregledNewItem;
  TempPatItem: TRealPatientNewItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  diag, diag0, diag1, diag2, diag3, diag4: TRealDiagnosisItem;
  dataPosition, linkpos: Cardinal;
  TreeLink, nodePat: PVirtualNode;
  data: PAspRec;
  ibsqlPregledNew: TIBSQL;

begin
  TempPregItem := TRealPregledNewItem(FindItemADB(id, Buf, BufLink, vvPregled));
  if TempPregItem <> nil then
  begin
    pCardinalData := pointer(PByte(FBuf) + 32);
    pCardinalData^  := NewID;
    Exit;
  end;
  if Fdm.IsGP then
  begin
    ibsqlPregledNew := Fdm.ibsqlPregNew_GP;
  end
  else
  begin
    ibsqlPregledNew := Fdm.ibsqlPregNew_S;
  end;
  ibsqlPregledNew.Close;
  if not ibsqlPregledNew.SQL.Text.Contains('where') then
  begin
    if Fdm.IsGP then
    begin
      ibsqlPregledNew.SQL.Text := Fdm.ibsqlPregNew_GP.SQL.Text + #13#10 +
       'where id = :id;';
    end
    else
    begin
      ibsqlPregledNew.SQL.Text := Fdm.ibsqlPregNew_S.SQL.Text + #13#10 +
       'where id = :id;';
    end;
  end;

  ibsqlPregledNew.Params[0].AsInteger := id;
  ibsqlPregledNew.ExecQuery;

  TempPregItem := TRealPregledNewItem(FCollPregled.Add);
  New(TempPregItem.PRecord);
  TempPregItem.PRecord.setProp := [];
  FCollPregled.FCollDiag := FCollDiag;
  FCollDiag.cmdFile := cmdFile;
  FDBHelper.InsertPregledField(ibsqlPregledNew, TempPregItem);
  TempPatItem := TRealPatientNewItem(FindItemADB(TempPregItem.PatID, Buf, BufLink, vvPatient));
  nodePat := TempPatItem.FNode;

  TempPregItem.InsertPregledNew;

  FCollPregled.streamComm.Len := FCollPregled.streamComm.Size;
  CmdFile.CopyFrom(FCollPregled.streamComm, 0);


  Dispose(TempPregItem.PRecord);
  TempPregItem.PRecord := nil;


  pCardinalData := pointer(PByte(FBufLink));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(FBufLink) + linkpos);
  data := pointer(PByte(FBufLink) + linkpos + lenNode);
  data.index := -1;
  data.vid := vvPregled;
  data.DataPos := TempPregItem.DataPos;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := 222;

  FVTR.InitNode(TreeLink);
  FVTR.InternalConnectNode_cmd(TreeLink, nodePat,
                    FVTR, amAddChildLast);
  TempPregItem.FNode := TreeLink;

  pCardinalData := FBufLink;
  pCardinalData^ := linkpos;

  if TempPregItem.FNode <> nil then
  begin
    diag0 := nil;
    diag1 := nil;
    diag2 := nil;
    diag3 := nil;
    diag4 := nil;
    FDBHelper.FindDiagInPregled(TempPregItem.FNode, diag0, diag1, diag2, diag3, diag4);
    //if TempItem.MainMKB <> '' then
    begin
      FDBHelper.UpdateDiagInPreg(diag0, TempPregItem, 0);
    end;
    //if TempItem.MainMKB1 <> '' then
    begin
      FDBHelper.UpdateDiagInPreg(diag1, TempPregItem, 1);
    end;
    //if TempItem.MainMKB2 <> '' then
    begin
      FDBHelper.UpdateDiagInPreg(diag2, TempPregItem, 2);
    end;
    //if TempItem.MainMKB3 <> '' then
    begin
      FDBHelper.UpdateDiagInPreg(diag3, TempPregItem, 3);
    end;
    //if TempItem.MainMKB4 <> '' then
    begin
      FDBHelper.UpdateDiagInPreg(diag4, TempPregItem, 4);
    end;
  end;
  FCollPregled.Delete(TempPregItem.Index);
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;


end;

procedure THistoryThread.InsertUnfav(id: Integer);
var
  i: Integer;
  uf: TRealUnfavItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  dataPosition: Cardinal;
begin
  uf := TRealUnfavItem(FCollUnfav.add);
  ib.Close;
  ib.SQL.Text :=

  'select' + #13#10 +
  'ID,' + #13#10 +
  'DOCTOR_ID_PRAC,' + #13#10 +
  'YEAR_UNFAV,' + #13#10 +
  'MONTH_UNFAV' + #13#10 +
  'from unfav' + #13#10 +
   'where unfav.id = :id;';
  ib.Params[0].AsInteger := id;
  ib.ExecQuery;
  New(uf.PRecord);
  uf.PRecord.setProp := [];

  if not ib.Fields[0].IsNull then
  begin
     uf.PRecord.ID := ib.Fields[0].AsInteger;
     Include(uf.PRecord.setProp, Unfav_ID);
  end;
  if not ib.Fields[2].IsNull then
  begin
    uf.PRecord.DOCTOR_ID_PRAC := ib.Fields[1].AsInteger;
    Include(uf.PRecord.setProp, Unfav_DOCTOR_ID_PRAC);
  end;
  if not ib.Fields[2].IsNull then
  begin
    uf.PRecord.YEAR_UNFAV := ib.Fields[2].AsInteger;
    Include(uf.PRecord.setProp, Unfav_YEAR_UNFAV);
  end;
  if not ib.Fields[3].IsNull then
  begin
    uf.PRecord.MONTH_UNFAV := ib.Fields[3].AsInteger;
    Include(uf.PRecord.setProp, Unfav_MONTH_UNFAV);
  end;


  cnt := 0;
  pCardinalData := pointer(PByte(FBuf) + 8);
  FPosData := pCardinalData^;
  pCardinalData := pointer(PByte(FBuf) + 12);
  FLenData := pCardinalData^;
  dataPosition :=  FPosData + FLenData;
  uf.InsertUnfav;
  Dispose(uf.PRecord);
  uf.PRecord := nil;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
end;

procedure THistoryThread.SetBuf(const Value: Pointer);
begin
  FBuf := Value;
  FCollPatient.Buf := FBuf;

end;

procedure THistoryThread.SetDataPos(const Value: Cardinal);
begin
  FDataPos := Value;
  FCollPatient.posData := FDataPos;
end;

procedure THistoryThread.TickerChange(Acol, ARow: Integer);
begin
  if Assigned(Ticker) then
  begin
    Ticker.Change(Acol, ARow,0);
  end;
end;

procedure THistoryThread.UpdateDoctor(id: Integer);
var
  i: Integer;
  TempItem: TRealDoctorItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData, dataPosition: Cardinal;
  ibsqlDoctor: TIBSQL;
begin
  TempItem := TRealDoctorItem(FindItemADB(id, Buf, BufLink, vvDoctor));
  if TempItem <> nil then
  begin
    ibsqlDoctor := Fdm.ibsqlDoctorNew;
    ibsqlDoctor.Close;
    if not ibsqlDoctor.SQL.Text.Contains('where') then
    begin
      ibsqlDoctor.SQL.Text := ibsqlDoctor.SQL.Text + #13#10 +
        'where id = :id;';
    end;

    ibsqlDoctor.Params[0].AsInteger := id;
    ibsqlDoctor.ExecQuery;

    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

    FDBHelper.UpdateDoctorField(ibsqlDoctor, TempItem);
  end;
  cnt := 0;
  for i := 0 to FCollDoctor.Count - 1 do
  begin
    TempItem := FCollDoctor.Items[i];
    if TempItem.PRecord <> nil then
    begin
      TempItem.SaveDoctor(FBuf, dataPosition);
      FCollDoctor.streamComm.Len := FCollDoctor.streamComm.Size;
      CmdFile.CopyFrom(FCollDoctor.streamComm, 0);
      inc(cnt);
    end;

  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(FBuf) + 12);
    pCardinalData^  := dataPosition - self.FDataPos;
  end;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
  FCollDoctor.CntUpdates := 0;

end;

procedure THistoryThread.UpdatePatient(id: Integer);
var
  i: Integer;
  TempItem: TRealPatientNewItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData, dataPosition: Cardinal;
  ibsqlPatientNew: TIBSQL;
begin
  TempItem := TRealPatientNewItem(FindItemADB(id, Buf, BufLink, vvPatient));
  if TempItem <> nil then
  begin
    if Fdm.IsGP then
    begin
      ibsqlPatientNew := Fdm.ibsqlPatNew_GP;
    end
    else
    begin
      ibsqlPatientNew := Fdm.ibsqlPatNew_S;
    end;
    ibsqlPatientNew.Close;
    if not Fdm.ibsqlPatNew_GP.SQL.Text.Contains('where') then
    begin
      if Fdm.IsGP then
      begin
        ibsqlPatientNew.SQL.Text := Fdm.ibsqlPatNew_GP.SQL.Text + #13#10 +
        'where id = :id;';
      end
      else
      begin
        ibsqlPatientNew.SQL.Text := Fdm.ibsqlPatNew_S.SQL.Text + #13#10 +
        'where id = :id;';
      end;
    end;

    ibsqlPatientNew.Params[0].AsInteger := id;
    ibsqlPatientNew.ExecQuery;

    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

    FDBHelper.UpdatePatientField(ibsqlPatientNew, TempItem);
  end;
  cnt := 0;
  for i := FCollPatient.Count - 1 downto 0 do
  begin
    TempItem := FCollPatient.Items[i];
    if (TempItem.PRecord <> nil) and (TempItem.PRecord.setProp <> []) then
    begin
      TempItem.SavePatientNew(dataPosition);
      FCollPatient.streamComm.Len := FCollPatient.streamComm.Size;
      CmdFile.CopyFrom(FCollPatient.streamComm, 0);
      inc(cnt);
    end
    else
    begin
      FCollPatient.Delete(i);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(FBuf) + 12);
    pCardinalData^  := dataPosition - self.FDataPos;
  end;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
  FCollPatient.CntUpdates := 0;

end;

procedure THistoryThread.UpdatePregled(id: Integer);
var
  i: Integer;
  TempItem: TRealPregledNewItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData, dataPosition: Cardinal;
  ibsqlPregledNew: TIBSQL;
begin
  TempItem := TRealPregledNewItem(FindItemADB(id, Buf, BufLink, vvPregled));
  if TempItem <> nil then
  begin
    if Fdm.IsGP then
    begin
      ibsqlPregledNew := Fdm.ibsqlPregNew_GP;
    end
    else
    begin
      ibsqlPregledNew := Fdm.ibsqlPregNew_S;
    end;
    ibsqlPregledNew.Close;
    if not Fdm.ibsqlPregNew_GP.SQL.Text.Contains('where') then
    begin
      if Fdm.IsGP then
      begin
        ibsqlPregledNew.SQL.Text := Fdm.ibsqlPregNew_GP.SQL.Text + #13#10 +
        'where id = :id;';
      end
      else
      begin
        ibsqlPregledNew.SQL.Text := Fdm.ibsqlPregNew_S.SQL.Text + #13#10 +
        'where id = :id;';
      end;
    end;

    ibsqlPregledNew.Params[0].AsInteger := id;
    ibsqlPregledNew.ExecQuery;

    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

    FDBHelper.UpdatePregledField(ibsqlPregledNew, TempItem);
  end;
  cnt := 0;
  for i := 0 to FCollPregled.Count - 1 do
  begin
    TempItem := FCollPregled.Items[i];
    if TempItem.PRecord <> nil then
    begin
      TempItem.SavePregledNew(FBuf, dataPosition);
      //TempItem.SavePregledNew(dataPosition);
      FCollPregled.streamComm.Len := FCollPregled.streamComm.Size;
      CmdFile.CopyFrom(FCollPregled.streamComm, 0);
      //Dispose(TempItem.PRecord); //SavePregledNew го прави това, така че тука не трябва да го има
      //TempItem.PRecord := nil;
      inc(cnt);
    end;

  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(FBuf) + 12);
    pCardinalData^  := dataPosition - self.FDataPos;
  end;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
  FCollPregled.CntUpdates := 0;

end;

procedure THistoryThread.UpdateUnfav(id: Integer);
var
  i: Integer;
  uf: TRealUnfavItem;
  cnt: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to FCollUnfav.Count - 1 do
  begin
    uf := FCollUnfav.Items[i];
    if uf.getIntMap(Fbuf, FDataPos, word(Unfav_ID)) = id then
    begin
      ib.Close;
      ib.SQL.Text :=

      'select' + #13#10 +
      'ID,' + #13#10 +
      'DOCTOR_ID_PRAC,' + #13#10 +
      'YEAR_UNFAV,' + #13#10 +
      'MONTH_UNFAV' + #13#10 +
      'from unfav' + #13#10 +
       'where unfav.id = :id;';
      ib.Params[0].AsInteger := id;
      ib.ExecQuery;

      New(uf.PRecord);
      uf.PRecord.setProp := [];

      if ib.Fields[0].AsInteger <> uf.getIntMap(FBuf, FDataPos, word(Unfav_ID)) then
      begin
         uf.PRecord.ID := ib.Fields[0].AsInteger;
         Include(uf.PRecord.setProp, Unfav_ID);
         TickerChange(1,i);
      end;
      if ib.Fields[1].AsInteger <> uf.getWordMap(FBuf, FDataPos, word(Unfav_DOCTOR_ID_PRAC)) then
      begin
        uf.PRecord.DOCTOR_ID_PRAC := ib.Fields[1].AsInteger;
        Include(uf.PRecord.setProp, Unfav_DOCTOR_ID_PRAC);
        TickerChange(2,i);
      end;
      if ib.Fields[2].AsInteger <> uf.getWordMap(FBuf, FDataPos, word(Unfav_YEAR_UNFAV)) then
      begin
        uf.PRecord.YEAR_UNFAV := ib.Fields[2].AsInteger;
        Include(uf.PRecord.setProp, Unfav_YEAR_UNFAV);
        TickerChange(3,i);
      end;
      if ib.Fields[3].AsInteger <> uf.getWordMap(FBuf, FDataPos, word(Unfav_MONTH_UNFAV)) then
      begin
        uf.PRecord.MONTH_UNFAV := ib.Fields[3].AsInteger;
        Include(uf.PRecord.setProp, Unfav_MONTH_UNFAV);
        TickerChange(4,i);
      end;
    end;
  end;
  cnt := 0;
  pCardinalData := pointer(PByte(FBuf) + 8);
  FPosData := pCardinalData^;
  pCardinalData := pointer(PByte(FBuf) + 12);
  FLenData := pCardinalData^;
  dataPosition :=  FPosData + FLenData;
  for i := 0 to FCollUnfav.Count - 1 do
  begin
    uf := FCollUnfav.Items[i];
    if uf.PRecord <> nil then
    begin
      uf.SaveUnfav(dataPosition);
      Dispose(uf.PRecord);
      uf.PRecord := nil;
      inc(cnt);
    end;

  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(FBuf) + 12);
    pCardinalData^  := dataPosition - FPosData;
  end;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
  FCollUnfav.CntUpdates := 0;
end;

end.
