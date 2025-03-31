unit AspectPerformerThread;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, Winapi.ActiveX, VirtualTrees, VirtualStringTreeAspect,
  VirtualStringTreeHipp, RealObj.RealHipp, System.Generics.Collections, System.Win.ScktComp,
  Aspects.Types, Aspects.Collections, VCLTee.Grid, Vcl.Dialogs,
  Table.CL088, Table.CL024, Table.CL038, Table.CL132, Table.CL134, Table.CL139,
  Table.CL142, Table.CL144, Table.PR001,
  Table.PatientNew, Table.PregledNew, Table.Doctor, Table.Diagnosis;

type
  TAspectPerformerThread = class(TThread)
  private
    FStop: Boolean;
    FStoped: Boolean;
    IsStart: Boolean;
    FIsClose: Boolean;

    DistrSocket: TCustomWinSocket;
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    scktClient: TClientSocket;
    ClientServerStream: TMemoryStream;
    stream: TWinSocketStream;
    procedure Execute; override;
    procedure DoTerminate; override;
    //procedure scktClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure scktDisconect(Sender: TObject; Socket: TCustomWinSocket);
    procedure sktServerClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ReadDistr;
    procedure AnswWhoAreYou();
    procedure AnswWhoAreYou1();
    procedure ActionCmdSizes(sizeBlock: Cardinal; SizeCmdADB, SizeCmdNzisNomen, SizeCmdHipNomen: Int64);
    procedure ADbUpdate(cmd: TCmdItem);
  public
    FCmdADB: TFileCMDStream;
    FCmdNzisNomen: TFileCMDStream;
    FCmdHipNomen: TFileCMDStream;
    AspectsNomFile : TMappedFile;

    AspectRole: TAspectRole;
    collCl024: TCL024Coll;
    collCl139: TCL139Coll;
    collCl132: TCL132Coll;
    collCl038: TCL038Coll;
    collCl088: TCL088Coll;
    collcl142: TCL142Coll;
    collcl144: TCL144Coll;
    collCl134: TCL134Coll;
    collPr001: TPR001Coll;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure Start;
    procedure InitAspectConnection;

  end;

implementation

{ TAspectPerformerThread }

procedure TAspectPerformerThread.ActionCmdSizes(sizeBlock: Cardinal; SizeCmdADB, SizeCmdNzisNomen,
  SizeCmdHipNomen: Int64);
var
  Astream: TMemoryStream;
  size: Cardinal;
begin
  if FCmdNzisNomen.Size = SizeCmdNzisNomen then  //  ако са равни, нищо не трябва да се прави
    Exit;



  if FCmdNzisNomen.Size > SizeCmdNzisNomen then  // трябва да се изпрати разликата на дистрибутора
  begin
    Astream := TMemoryStream.create;
    Astream.Position := 0;
    AspectRole := arNomenNzisUpload;
    Astream.Write(AspectRole, 2);
    FCmdNzisNomen.Position := SizeCmdNzisNomen; // зззззззззз това е опасно, защото може в тоя момент може друг да пише във файла
    Astream.Position := 6;
    Astream.CopyFrom(FCmdNzisNomen, FCmdNzisNomen.Size - SizeCmdNzisNomen);//
    FCmdNzisNomen.Position := FCmdNzisNomen.Size;
    Astream.Position := 2;
    size:= Astream.Size;
    Astream.Write(Size, 4);

    Astream.Position := 0;
    stream.CopyFrom(Astream, Astream.Size);
    Astream.Free;
  end
  else // тука трябва дистр. да е изпратил каквото трябва да се взима
  begin
    //stream.Position := 30;
    Astream := TMemoryStream.create;
    Astream.Size := sizeBlock;
    stream.Read(Astream.Memory, 30, Astream.Size);
    //Astream
  end;

end;

procedure TAspectPerformerThread.ADbUpdate(cmd: TCmdItem);
var
  cl088: TCL088Item;
  cl024: TCL024Item;
  cl139: TCL139Item;
  cl132: TCL132Item;
  cl038: TCL038Item;
  cl142: TCL142Item;
  cl144: TCL144Item;
  cl134: TCL134Item;
  pr001: TPR001Item;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  case cmd.collType of
      ctCL088:
      begin
        cl088 := TCL088Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl088.InsertCL088;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl088.Buf) + 12);
            dataPosition := pCardinalData^ + collCl088.posData;
            cl088.SaveCL088(dataPosition);
            pCardinalData := pointer(PByte(collCl088.Buf) + 12);
            pCardinalData^  := dataPosition - collCl088.PosData;
          end;
        end;
      end;
      ctCL024:
      begin
        cl024 := TCL024Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl024.InsertCL024;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl024.Buf) + 12);
            dataPosition := pCardinalData^ + collCl024.posData;
            cl024.SaveCL024(dataPosition);
            pCardinalData := pointer(PByte(collCl024.Buf) + 12);
            pCardinalData^  := dataPosition - collCl024.PosData;
          end;
        end;
      end;
      ctCL139:
      begin
        cl139 := TCL139Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl139.InsertCL139;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl139.Buf) + 12);
            dataPosition := pCardinalData^ + collCl139.posData;
            cl139.SaveCL139(dataPosition);
            pCardinalData := pointer(PByte(collCl139.Buf) + 12);
            pCardinalData^  := dataPosition - collCl139.PosData;
          end;
        end;
      end;
      ctCL132:
      begin
        cl132 := TCL132Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl132.InsertCL132;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl132.Buf) + 12);
            dataPosition := pCardinalData^ + collCl132.posData;
            cl132.SaveCL132(dataPosition);
            pCardinalData := pointer(PByte(collCl132.Buf) + 12);
            pCardinalData^  := dataPosition - collCl132.PosData;
          end;
        end;
      end;
      ctCL038:
      begin
        cl038 := TCL038Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl038.InsertCL038;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl038.Buf) + 12);
            dataPosition := pCardinalData^ + collCl038.posData;
            cl038.SaveCL038(dataPosition);
            pCardinalData := pointer(PByte(collCl038.Buf) + 12);
            pCardinalData^  := dataPosition - collCl038.PosData;
          end;
        end;
      end;
      ctCL142:
      begin
        cl142 := TCL142Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl142.InsertCL142;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl142.Buf) + 12);
            dataPosition := pCardinalData^ + collCl142.posData;
            cl142.SaveCL142(dataPosition);
            pCardinalData := pointer(PByte(collCl142.Buf) + 12);
            pCardinalData^  := dataPosition - collCl142.PosData;
          end;
        end;
      end;
      ctCL144:
      begin
        cl144 := TCL144Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl144.InsertCL144;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl144.Buf) + 12);
            dataPosition := pCardinalData^ + collCl144.posData;
            cl144.SaveCL144(dataPosition);
            pCardinalData := pointer(PByte(collCl144.Buf) + 12);
            pCardinalData^  := dataPosition - collCl144.PosData;
          end;
        end;
      end;
      ctCL134:
      begin
        cl134 := TCL134Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: cl134.InsertCL134;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collCl134.Buf) + 12);
            dataPosition := pCardinalData^ + collCl134.posData;
            cl134.SaveCL134(dataPosition);
            pCardinalData := pointer(PByte(collCl134.Buf) + 12);
            pCardinalData^  := dataPosition - collCl134.PosData;
          end;
        end;

      end;
      ctPR001:
      begin
        pr001 := TPR001Item(cmd.AdbItem);
        case cmd.OpType of
          toInsert: pr001.Insertpr001;
          toUpdate:
          begin
            pCardinalData := pointer(PByte(collpr001.Buf) + 12);
            dataPosition := pCardinalData^ + collpr001.posData;
            pr001.Savepr001(dataPosition);
            pCardinalData := pointer(PByte(collpr001.Buf) + 12);
            pCardinalData^  := dataPosition - collpr001.PosData;
          end;
        end;

      end;
    end;
end;

procedure TAspectPerformerThread.AnswWhoAreYou();
var
  Astream: TMemoryStream;
  pMem: Pointer;
  size: cardinal;
  cmdSize: Int64;
  dataPosADB, dataPosNzisNomen, dataPosHipNomen: Int64;
begin
  dataPosADB := FCmdADB.AspectDataPos;
  dataPosNzisNomen := FCmdNzisNomen.AspectDataPos;
  dataPosHipNomen := 0;//FCmdHipNomen.AspectDataPos;
  Astream := TMemoryStream.create;
  //Astream.LoadFromFile('d:\dumNegrevska.sql');
  //size := 18;
  //Astream.Size := size;
  Astream.Position := 0;
  AspectRole := arNomenNzis;
  Astream.Write(AspectRole, 2);
  Astream.Write(size, 4);
  Astream.Write(dataPosADB, 8);  //14
  Astream.Write(dataPosNzisNomen, 8);
  Astream.Write(dataPosHipNomen, 8);

  cmdSize := FCmdADB.Size;
  Astream.Write(cmdSize, 8);
  cmdSize := FCmdNzisNomen.Size;//tuka eeeeeeeee  38
  Astream.Write(cmdSize, 8);   //46
  cmdSize :=0;
  Astream.Write(cmdSize, 8);//(FCmdHipNomen.Size, 4);


  Astream.Position := 2;
  size :=Astream.Size;
  Astream.Write(size, 4);

  //Astream.Position := 0;
  //Astream.SaveToFile('d:\testClientCMD.cmd');
  Astream.Position := 0;
  stream.CopyFrom(Astream, Astream.Size);


  Astream.Free;
end;

procedure TAspectPerformerThread.AnswWhoAreYou1;
var
  Astream: TMemoryStream;
  pMem: Pointer;
  size: cardinal;
  cmdSize: Int64;
  dataPosADB, dataPosNzisNomen, dataPosHipNomen: Int64;
begin
  dataPosADB := FCmdADB.AspectDataPos;
  dataPosNzisNomen := FCmdNzisNomen.AspectDataPos;
  dataPosHipNomen := 0;//FCmdHipNomen.AspectDataPos;
  Astream := TMemoryStream.create;
  //size := 18;
  //Astream.Size := size;
  Astream.Position := 0;
  AspectRole := arNomenNzis;
  Astream.Write(AspectRole, 2);
  Astream.Write(size, 4);
  Astream.Write(dataPosADB, 8);
  Astream.Write(dataPosNzisNomen, 8);
  Astream.Write(dataPosHipNomen, 8);

  cmdSize := FCmdADB.Size;
  Astream.Write(cmdSize, 8);
  cmdSize := FCmdNzisNomen.Size;//tuka eeeeeeeee
  Astream.Write(cmdSize, 8);
  cmdSize :=0;
  Astream.Write(cmdSize, 8);//(FCmdHipNomen.Size, 4);

  Astream.Position := 2;
  size :=Astream.Size;
  Astream.Write(size, 4);

  Astream.Position := 0;
  stream.CopyFrom(Astream, Astream.Size);


  Astream.Free;
end;


constructor TAspectPerformerThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  DistrSocket := nil;
  IsStart := true;
  FStop := True;
  FStoped := False;
  FIsClose := False;

  
end;

destructor TAspectPerformerThread.Destroy;
begin
  FreeAndNil(collCl024);
  inherited;
end;

procedure TAspectPerformerThread.DoTerminate;
begin
  inherited;

end;

procedure TAspectPerformerThread.Execute;
var
  comInitStatus: THandle;

begin
  comInitStatus := S_FALSE;
  try
    comInitStatus := CoInitializeEx(nil, COINIT_MULTITHREADED);
    inherited;
    try
      collCl024 := TCL024Coll.Create(TCL024Item);
      collCl038 := TCL038Coll.Create(TCL038Item);
      collCl088 := TCL088Coll.Create(TCL088Item);
      collCl132 := TCL132Coll.Create(TCL132Item);
      collCl134 := TCL134Coll.Create(TCL134Item);
      collCl139 := TCL139Coll.Create(TCL139Item);
      collCl142 := TCL142Coll.Create(TCL142Item);
      collCl144 := TCL144Coll.Create(TCL144Item);
      collPr001 := TPr001Coll.Create(TPr001Item);




      collCl088.Buf := AspectsNomFile.Buf;
      collCl088.posData := AspectsNomFile.FPosData;
      collCl024.Buf := AspectsNomFile.Buf;
      collCl024.posData := AspectsNomFile.FPosData;
      collCl139.Buf := AspectsNomFile.Buf;
      collCl139.posData := AspectsNomFile.FPosData;
      collCl132.Buf := AspectsNomFile.Buf;
      collCl132.posData := AspectsNomFile.FPosData;
      collCl038.Buf := AspectsNomFile.Buf;
      collCl038.posData := AspectsNomFile.FPosData;
      collCl142.Buf := AspectsNomFile.Buf;
      collCl142.posData := AspectsNomFile.FPosData;
      collCl144.Buf := AspectsNomFile.Buf;
      collCl144.posData := AspectsNomFile.FPosData;
      collCl134.Buf := AspectsNomFile.Buf;
      collCl134.posData := AspectsNomFile.FPosData;
      collPr001.Buf := AspectsNomFile.Buf;
      collPr001.posData := AspectsNomFile.FPosData;
      InitAspectConnection;
      stream := TWinSocketStream.Create(scktClient.Socket, 60000);
      while not Terminated do
      begin
        if (not IsStart)  then
        begin
          IsStart := True;
        end;
        ReadDistr;
        if FIsClose then
          Exit;
        if not scktClient.Socket.Connected then
        begin
          Sleep(3000);
          try
            scktClient.Active := True;
          except

          end;
        end;

        Sleep(10);
      end;
    except
      Exit;
    end;
  finally
    case comInitStatus of
      S_OK, S_FALSE: CoUninitialize;
    end;
  end;
end;

procedure TAspectPerformerThread.InitAspectConnection;
var
  data: PAspRec;

begin

  scktClient := TClientSocket.Create(nil);

  scktClient.Address := '127.0.0.1';
  //scktClient.Address := '63.177.219.207';
  scktClient.ClientType := ctBlocking;

  scktClient.Port := 3333;
  scktClient.OnError := sktServerClientError;
  scktClient.OnDisconnect := scktDisconect;
  try
    scktClient.Active := True;
  except

  end;

  ClientServerStream := TMemoryStream.Create;
end;

procedure TAspectPerformerThread.ReadDistr;
var
  cl088: TCL088Item;
  cl024: TCL024Item;
  cl139: TCL139Item;
  cl132: TCL132Item;
  cl038: TCL038Item;
  cl142: TCL142Item;
  cl144: TCL144Item;
  cl134: TCL134Item;
  pr001: TPR001Item;
  pCardinalData: PCardinal;
  dataPosition, posLen: Cardinal;

  data: PAspRec;
  sresp: TServerResponse;
  size: Cardinal;
  nomenSize: Int64;
  AStream: TMemoryStream;
  //buf: TBytes;
  bb: Pointer;
  lenRead: Integer;
  len, ver, lenSt: Word;
  OpType: TOperationType;
  colType: TCollectionsType;
  APosData: Cardinal;
  CmdItem: TCmdItem;
begin
  if stream.WaitForData(6000) and (scktClient.Socket.connected) then
  begin
    if stream.Read(sresp, 2) > 0 then
    begin
      //showmessage('uraaaa');
      case sresp of
        srWhoAreYou:
        begin
          AnswWhoAreYou1();
        end;
        srYouAre:
        begin
          stream.Read(APosData, 4);
          FCmdNzisNomen.Position := 0;
          FCmdNzisNomen.Write(APosData, 4);
          FCmdNzisNomen.Position := FCmdNzisNomen.Size;
        end;
        srCmdSizes:
        begin
          stream.Read(size, 4);
          stream.Read(nomenSize, 8);
          stream.Read(nomenSize, 8);
          ActionCmdSizes(size, 0, nomenSize, 0);
        end;
        srCmdUpload: // трябва да се качва разликата
        begin
          AStream := TMemoryStream.Create;
          AStream.write(sresp, 2);
          stream.Read(size, 4);
          AStream.write(size, 4);
          AStream.Size := size;
         // AStream.Position := 0;
          while AStream.Position < AStream.Size  do
          begin
            bb := Pointer(pbyte(AStream.Memory) + AStream.Position);
            lenRead := stream.Read(bb^, 1024 * 4);
            AStream.Position := AStream.Position + lenRead;
          end;
          AStream.Position := 0;
          AStream.SaveToFile('d:\cmd1000Client.cmd');
          //Exit;
          AStream.Position := 30;
          Astream.Read(len, 2);


          while (Astream.Position + len - 2)  <= Astream.Size do
          begin
            posLen := Astream.Position + len - 2;
            Astream.Read(optype, 2);
            Astream.Read(ver, 2);
            Astream.Read(colType, 2);
            Astream.Read(APosData, 4);


            CmdItem := TCmdItem.Create;
            CmdItem.OpType := OpType;
            CmdItem.collType := colType;

            case colType of
              ctCL088:
              begin
                cl088 := TCL088Item(collCl088.Add);
                cl088.ReadCmd(Astream, nil, nil, CmdItem);
                cl088.DataPos := APosData;
              end;
              ctCL024:
              begin
                cl024 := TCL024Item(collCl024.Add);
                cl024.ReadCmd(Astream, nil, nil, CmdItem);
                cl024.DataPos := APosData;
              end;
              ctCL139:
              begin
                cl139 := TCL139Item(collCl139.Add);
                cl139.ReadCmd(Astream, nil, nil, CmdItem);
                cl139.DataPos := APosData;
              end;
              ctCL132:
              begin
                cl132 := TCL132Item(collCl132.Add);
                cl132.ReadCmd(Astream, nil, nil, CmdItem);
                cl132.DataPos := APosData;
              end;
              ctCL038:
              begin
                cl038 := TCL038Item(collCl038.Add);
                cl038.ReadCmd(Astream, nil, nil, CmdItem);
                cl038.DataPos := APosData;
              end;
              ctCL142:
              begin
                cl142 := TCL142Item(collCl142.Add);
                cl142.ReadCmd(Astream, nil, nil, CmdItem);
                cl142.DataPos := APosData;
              end;
              ctCL144:
              begin
                cl144 := TCL144Item(collCl144.Add);
                cl144.ReadCmd(Astream, nil, nil, CmdItem);
                cl144.DataPos := APosData;
              end;
              ctCL134:
              begin
                cl134 := TCL134Item(collCl134.Add);
                cl134.ReadCmd(Astream, nil, nil, CmdItem);
                cl134.DataPos := APosData;
              end;
              ctPr001:
              begin
                pr001 := TPR001Item(collPr001.Add);
                pr001.ReadCmd(Astream, nil, nil, CmdItem);
                pr001.DataPos := APosData;
              end;
            else
              begin
                scktClient.Active := False;
                Exit;
              end;
            end;



            ADbUpdate(CmdItem);
            AStream.Position := posLen;
            AStream.Read(len, 2);
          end;

        end;
      end;
    end
    else
    begin
      scktClient.Active := False;
    end;
  end;

end;

procedure TAspectPerformerThread.scktDisconect(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;

procedure TAspectPerformerThread.sktServerClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  //
end;

procedure TAspectPerformerThread.Start;
begin

end;

end.
