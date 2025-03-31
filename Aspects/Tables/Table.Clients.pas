unit Table.Clients;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows;

type

TTeeGRD = class(VCLTee.Grid.TTeeGrid);
TLogicalClients = (
    INCIDENTALLY,
    IS_ANALYSIS,
    IS_BABY_CARE,
    IS_CONSULTATION,
    IS_DISPANSERY,
    IS_EMERGENCY,
    IS_EPIKRIZA,
    IS_EXPERTIZA,
    IS_FORM_VALID,
    IS_HOSPITALIZATION,
    IS_MANIPULATION,
    IS_MEDBELEJKA,
    IS_NAET,
    IS_NAPR_TELK,
    IS_NEW,
    IS_NOTIFICATION,
    IS_NO_DELAY,
    IS_OPERATION,
    IS_PODVIZHNO_LZ,
    IS_PREVENTIVE,
    IS_PRINTED,
    IS_RECEPTA_HOSPIT,
    IS_REGISTRATION,
    IS_REHABILITATION,
    IS_RISK_GROUP,
    IS_TELK,
    IS_VSD,
    IS_ZAMESTVASHT);
TlogicalClientsSet = set of TLogicalClients;

TClientsItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Clients_piNumber
                      , Clients_piEik
                      , Clients_piRegisterDate
                      , Clients_piActive
                      , Clients_piLogical
                      );
      TSetProp = set of TPropertyIndex;
      PRecClients = ^TRecClients;
      TRecClients = record
        piNumber: integer;
        piEik: String;
        piRegisterDate: TDate;
        piActive: boolean;
        piLogical: TlogicalClientsSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecClients;
    function FieldCount: Integer;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertClients;
    procedure UpdateClients;
    procedure SaveClients(var dataPosition: Cardinal);
  end;


  TClientsColl = class(TBaseCollection)
  private
    function GetItem(Index: Integer): TClientsItem;
    procedure SetItem(Index: Integer; const Value: TClientsItem);
  public
    function AddItem(ver: word):TClientsItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Clients: TClientsItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Clients: TClientsItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    function DisplayName(propIndex: Word): string;
    property Items[Index: Integer]: TClientsItem read GetItem write SetItem;

  end;

implementation

{ TClientsItem }



constructor TClientsItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TClientsItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

function TClientsItem.FieldCount: Integer;
begin
  Result := 5;
end;

procedure TClientsItem.InsertClients;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := ctClients;
  pCardinalData := pointer(PByte(buf));
  FPosMetaData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 4);
  FLenMetaData := pCardinalData^;
  metaPosition :=  FPosMetaData + FLenMetaData;

  pCardinalData := pointer(PByte(buf) + 8);
  FPosData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 12);
  FLenData := pCardinalData^;
  dataPosition :=  FPosData + FLenData;
  case FVersion of
    0:
    begin
      pWordData := pointer(PByte(buf) + metaPosition);
      pWordData^  := word(CollType);
      pWordData := pointer(PByte(buf) + metaPosition + 2);
      pWordData^  := FVersion;
      inc(metaPosition, 4);

      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            Clients_piNumber: SaveData(PRecord.piNumber, PropPosition, metaPosition, dataPosition);
            Clients_piEik: SaveData(PRecord.piEik, PropPosition, metaPosition, dataPosition);
            Clients_piRegisterDate: SaveData(PRecord.piRegisterDate, PropPosition, metaPosition, dataPosition);
            Clients_piActive: SaveData(PRecord.piActive, PropPosition, metaPosition, dataPosition);
            Clients_piLogical: SaveData(Cardinal(PRecord.piLogical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          SaveNull(metaPosition);
        end;
      end;
      pCardinalData := pointer(PByte(buf) + 4);
      pCardinalData^  := metaPosition - FPosMetaData;
      pCardinalData := pointer(PByte(buf) + 12);
      pCardinalData^  := dataPosition - FPosData;
    end;
  end;
end;

procedure TClientsItem.SaveClients(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  
  CollType := ctClients;
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          SaveHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            Clients_piNumber: SaveData(PRecord.piNumber, PropPosition, metaPosition, dataPosition);
            Clients_piEik: SaveData(PRecord.piEik, PropPosition, metaPosition, dataPosition);
            Clients_piRegisterDate: SaveData(PRecord.piRegisterDate, PropPosition, metaPosition, dataPosition);
            Clients_piActive: SaveData(PRecord.piActive, PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

procedure TClientsItem.UpdateClients;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctClients;
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          UpdateHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            Clients_piNumber: UpdateData(PRecord.piNumber, PropPosition, metaPosition, dataPosition);
            Clients_piEik: UpdateData(PRecord.piEik, PropPosition, metaPosition, dataPosition);
            Clients_piRegisterDate: UpdateData(PRecord.piRegisterDate, PropPosition, metaPosition, dataPosition);
            Clients_piActive: UpdateData(PRecord.piActive, PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

{ TClientsColl }

function TClientsColl.AddItem(ver: word): TClientsItem;
begin
  Result := TClientsItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


function TClientsColl.DisplayName(propIndex: Word): string;
begin
  case TClientsItem.TPropertyIndex(propIndex) of
    Clients_piNumber: Result := 'piNumber';
    Clients_piEik: Result := 'piEik';
    Clients_piRegisterDate: Result := 'piRegisterDate';
    Clients_piActive: Result := 'piActive';
  end;
end;

procedure TClientsColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Clients: TClientsItem;
  ACol: Integer;
  prop: TClientsItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Clients := Items[ARow];
  prop := TClientsItem.TPropertyIndex(ACol);
  if Assigned(Clients.PRecord) and (prop in Clients.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Clients, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Clients, AValue);
  end;
end;

procedure TClientsColl.GetCellFromRecord(propIndex: word; Clients: TClientsItem; var AValue: String);
var
  str: string;
begin
  case TClientsItem.TPropertyIndex(propIndex) of
    Clients_piNumber: str := inttostr(Clients.PRecord.piNumber);
    Clients_piEik: str := (Clients.PRecord.piEik);
    Clients_piRegisterDate: str := DateTostr(Clients.PRecord.piRegisterDate);
    Clients_piActive: str := BoolToStr(Clients.PRecord.piActive, True);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TClientsColl.GetCellFromMap(propIndex: word; ARow: Integer; Clients: TClientsItem; var AValue: String);
var
  str: string;
  len: Word;
  int: PInt;
  wrd: PWord;
  bt: PByte;
  pstr: pchar;
  pDbl: PDouble;
  pbl: PBoolean;
begin
  case TClientsItem.TPropertyIndex(propIndex) of

    Clients_piNumber: str := inttostr(Clients.getIntMap(Self.Buf, Self.posData, propIndex));
    Clients_piEik: str := Clients.getStringMap(Self.Buf, Self.posData, propIndex);
    Clients_piRegisterDate: str := DateToStr(Clients.getDateMap(Self.Buf, Self.posData, propIndex));
    Clients_piActive: str := BoolToStr( Clients.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
  else
    begin
      str := IntToStr(ARow);
    end;
  end;
  AValue := str;
end;

function TClientsColl.GetItem(Index: Integer): TClientsItem;
begin
  Result := TClientsItem(inherited GetItem(Index));
end;

procedure TClientsColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  grd: TTeeGrid;
  isOld: Boolean;
  Clients: TClientsItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  grd := TTeeGrid(Sender);
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  Clients := Items[ARow];
  if not Assigned(Clients.PRecord) then
  begin
    New(Clients.PRecord);
    Clients.PRecord.setProp := [];
    CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TClientsItem.TPropertyIndex(ACol) of
      Clients_piNumber: isOld  := Clients.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      Clients_piEik: isOld  := Clients.getStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Clients_piRegisterDate: isOld  := Clients.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      Clients_piActive: isOld  := Clients.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    end;
    if isOld then
    begin
      Exclude(Clients.PRecord.setProp, TClientsItem.TPropertyIndex(ACol));
      if Clients.PRecord.setProp = [] then
      begin
        Dispose(Clients.PRecord);
        Clients.PRecord := nil;
        CntUpdates := CntUpdates - 1;
        Exit;
      end;
    end;
  end;
  Include(Clients.PRecord.setProp, TClientsItem.TPropertyIndex(ACol));
  case TClientsItem.TPropertyIndex(ACol) of
    Clients_piNumber: Clients.PRecord.piNumber := StrToInt(AValue);
    Clients_piEik: Clients.PRecord.piEik := AValue;
    Clients_piRegisterDate: Clients.PRecord.piRegisterDate := StrToDate(AValue);
    Clients_piActive: Clients.PRecord.piActive := StrToBool(AValue);
  end;
end;

procedure TClientsColl.SetItem(Index: Integer; const Value: TClientsItem);
begin
  inherited SetItem(Index, Value);
end;


end.