unit Table.PR001;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees;

type
TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

TFindedResult = record
  PropIndex: Word;
  DataPos: Cardinal;
end;

TTeeGRD = class(VCLTee.Grid.TTeeGrid);


TPR001Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (PR001_CL132
, PR001_Nomenclature
, PR001_Activity_ID
, PR001_Description
, PR001_Notes
, PR001_Rules
, PR001_Specialty_CL006
, PR001_Valid_Until
);
      TSetProp = set of TPropertyIndex;
      PRecPR001 = ^TRecPR001;
      TRecPR001 = record
        CL132: AnsiString;
        Nomenclature: AnsiString;
        Activity_ID: AnsiString;
        Description: AnsiString;
        Notes: AnsiString;
        Rules: AnsiString;
        Specialty_CL006: AnsiString;
        Valid_Until: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPR001;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPR001;
    procedure UpdatePR001;
    procedure SavePR001(var dataPosition: Cardinal);
    procedure FillPropPR001(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TPR001Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TPR001Item;
    procedure SetItem(Index: Integer; const Value: TPR001Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListPR001Search: TList<TPR001Item>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPR001Item;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; PR001: TPR001Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PR001: TPR001Item; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TPR001Item.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPR001Item.TPropertyIndex);
    property Items[Index: Integer]: TPR001Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TPR001Item }

constructor TPR001Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPR001Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPR001Item.FillPropPR001(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    PR001_CL132:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.CL132, lenstr);
      stream.Read(Self.PRecord.CL132[1], lenStr);
    end;
    PR001_Nomenclature:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Nomenclature, lenstr);
      stream.Read(Self.PRecord.Nomenclature[1], lenStr);
    end;
    PR001_Activity_ID:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Activity_ID, lenstr);
      stream.Read(Self.PRecord.Activity_ID[1], lenStr);
    end;
    PR001_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;

    PR001_Notes:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Notes, lenstr);
      stream.Read(Self.PRecord.Notes[1], lenStr);
    end;
    PR001_Rules:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Rules, lenstr);
      stream.Read(Self.PRecord.Rules[1], lenStr);
    end;
    PR001_Specialty_CL006:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Specialty_CL006, lenstr);
      stream.Read(Self.PRecord.Specialty_CL006[1], lenStr);
    end;
    PR001_Valid_Until:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Valid_Until, lenstr);
      stream.Read(Self.PRecord.Valid_Until[1], lenStr);
    end;
  end;
end;

procedure TPR001Item.InsertPR001;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPR001;
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
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toInsert, FVersion, metaPosition + 4);
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
            PR001_CL132: SaveData(PRecord.CL132, PropPosition, metaPosition, dataPosition);
            PR001_Nomenclature: SaveData(PRecord.Nomenclature, PropPosition, metaPosition, dataPosition);
            PR001_Activity_ID: SaveData(PRecord.Activity_ID, PropPosition, metaPosition, dataPosition);
            PR001_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            PR001_Notes: SaveData(PRecord.Notes, PropPosition, metaPosition, dataPosition);
            PR001_Rules: SaveData(PRecord.Rules, PropPosition, metaPosition, dataPosition);
            PR001_Specialty_CL006: SaveData(PRecord.Specialty_CL006, PropPosition, metaPosition, dataPosition);
            PR001_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TPR001Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds08: TLogicalData08;
  propindexPR001: TPR001Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData08);
  stream.Read(flds08, sizeof(TLogicalData08));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TPR001Item.TSetProp(flds08);// тука се записва какво има като полета


  for propindexPR001 := Low(TPR001Item.TPropertyIndex) to High(TPR001Item.TPropertyIndex) do
  begin
    if not (propindexPR001 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexPR001);
      dataCmdProp.vid := vvPR001;
    end;
    self.FillPropPR001(propindexPR001, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TPR001Item.SavePR001(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPR001;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, FDataPos);
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
            PR001_CL132: SaveData(PRecord.CL132, PropPosition, metaPosition, dataPosition);
            PR001_Nomenclature: SaveData(PRecord.Nomenclature, PropPosition, metaPosition, dataPosition);
            PR001_Activity_ID: SaveData(PRecord.Activity_ID, PropPosition, metaPosition, dataPosition);
            PR001_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            PR001_Notes: SaveData(PRecord.Notes, PropPosition, metaPosition, dataPosition);
            PR001_Rules: SaveData(PRecord.Rules, PropPosition, metaPosition, dataPosition);
            PR001_Specialty_CL006: SaveData(PRecord.Specialty_CL006, PropPosition, metaPosition, dataPosition);
            PR001_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TPR001Item.UpdatePR001;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPR001;
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
            PR001_CL132: UpdateData(PRecord.CL132, PropPosition, metaPosition, dataPosition);
            PR001_Nomenclature: UpdateData(PRecord.Nomenclature, PropPosition, metaPosition, dataPosition);
            PR001_Activity_ID: UpdateData(PRecord.Activity_ID, PropPosition, metaPosition, dataPosition);
            PR001_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            PR001_Notes: UpdateData(PRecord.Notes, PropPosition, metaPosition, dataPosition);
            PR001_Rules: UpdateData(PRecord.Rules, PropPosition, metaPosition, dataPosition);
            PR001_Specialty_CL006: UpdateData(PRecord.Specialty_CL006, PropPosition, metaPosition, dataPosition);
            PR001_Valid_Until: UpdateData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

{ TPR001Coll }

function TPR001Coll.AddItem(ver: word): TPR001Item;
begin
  Result := TPR001Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TPR001Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListPR001Search := TList<TPR001Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TPR001Coll.destroy;
begin
  FreeAndNil(ListPR001Search);
  inherited;
end;

function TPR001Coll.DisplayName(propIndex: Word): string;
begin
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: Result := 'CL132';
    PR001_Nomenclature: Result := 'Nomenclature';
    PR001_Activity_ID: Result := 'Activity_ID';
    PR001_Description: Result := 'Description';
    PR001_Notes: Result := 'Notes';
    PR001_Rules: Result := 'Rules';
    PR001_Specialty_CL006: Result := 'Specialty_CL006';
    PR001_Valid_Until: Result := 'Valid_Until';
  end;
end;

procedure TPR001Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TPR001Item.TPropertyIndex(self.FindedRes.PropIndex));
  //Self.SortByIndexValue;
end;

function TPR001Coll.FieldCount: Integer;
begin
  Result := 8;
end;

procedure TPR001Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PR001: TPR001Item;
  ACol: Integer;
  prop: TPR001Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PR001 := Items[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(PR001.PRecord) and (prop in PR001.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PR001, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PR001, AValue);
  end;
end;

procedure TPR001Coll.GetCellFromRecord(propIndex: word; PR001: TPR001Item; var AValue: String);
var
  str: string;
begin
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: str := (PR001.PRecord.CL132);
    PR001_Nomenclature: str := (PR001.PRecord.Nomenclature);
    PR001_Activity_ID: str := (PR001.PRecord.Activity_ID);
    PR001_Description: str := (PR001.PRecord.Description);
    PR001_Notes: str := (PR001.PRecord.Notes);
    PR001_Rules: str := (PR001.PRecord.Rules);
    PR001_Specialty_CL006: str := (PR001.PRecord.Specialty_CL006);
    PR001_Valid_Until: str := (PR001.PRecord.Valid_Until);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPR001Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PR001: TPR001Item;
  ACol: Integer;
  prop: TPR001Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PR001 := ListPR001Search[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(PR001.PRecord) and (prop in PR001.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PR001, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PR001, AValue);
  end;
end;

procedure TPR001Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PR001: TPR001Item;
  prop: TPR001Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PR001 := Items[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(PR001.PRecord) and (prop in PR001.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PR001, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PR001, AFieldText);
  end;
end;

procedure TPR001Coll.GetCellFromMap(propIndex: word; ARow: Integer; PR001: TPR001Item; var AValue: String);
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
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Nomenclature: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Activity_ID: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Description: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Notes: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Rules: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Specialty_CL006: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Valid_Until: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPR001Coll.GetItem(Index: Integer): TPR001Item;
begin
  Result := TPR001Item(inherited GetItem(Index));
end;


procedure TPR001Coll.IndexValue(propIndex: TPR001Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPR001Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PR001_CL132:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      PR001_Nomenclature:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Activity_ID:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Notes:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Rules:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Specialty_CL006:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Valid_Until:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
    end;
  end;
end;

procedure TPR001Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PR001: TPR001Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  PR001 := Items[ARow];
  if not Assigned(PR001.PRecord) then
  begin
    New(PR001.PRecord);
    PR001.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPR001Item.TPropertyIndex(ACol) of
      PR001_CL132: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Nomenclature: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Activity_ID: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Description: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Notes: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Rules: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Specialty_CL006: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Valid_Until: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
    if PR001.PRecord.setProp = [] then
    begin
      Dispose(PR001.PRecord);
      PR001.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
  case TPR001Item.TPropertyIndex(ACol) of
    PR001_CL132: PR001.PRecord.CL132 := AValue;
    PR001_Nomenclature: PR001.PRecord.Nomenclature := AValue;
    PR001_Activity_ID: PR001.PRecord.Activity_ID := AValue;
    PR001_Description: PR001.PRecord.Description := AValue;
    PR001_Notes: PR001.PRecord.Notes := AValue;
    PR001_Rules: PR001.PRecord.Rules := AValue;
    PR001_Specialty_CL006: PR001.PRecord.Specialty_CL006 := AValue;
    PR001_Valid_Until: PR001.PRecord.Valid_Until := AValue;
  end;
end;

procedure TPR001Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PR001: TPR001Item;
begin
  if Count = 0 then Exit;

  PR001 := Items[ARow];
  if not Assigned(PR001.PRecord) then
  begin
    New(PR001.PRecord);
    PR001.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPR001Item.TPropertyIndex(ACol) of
      PR001_CL132: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Nomenclature: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Activity_ID: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Description: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Notes: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Rules: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Specialty_CL006: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Valid_Until: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
    if PR001.PRecord.setProp = [] then
    begin
      Dispose(PR001.PRecord);
      PR001.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
  case TPR001Item.TPropertyIndex(ACol) of
    PR001_CL132: PR001.PRecord.CL132 := AFieldText;
    PR001_Nomenclature: PR001.PRecord.Nomenclature := AFieldText;
    PR001_Activity_ID: PR001.PRecord.Activity_ID := AFieldText;
    PR001_Description: PR001.PRecord.Description := AFieldText;
    PR001_Notes: PR001.PRecord.Notes := AFieldText;
    PR001_Rules: PR001.PRecord.Rules := AFieldText;
    PR001_Specialty_CL006: PR001.PRecord.Specialty_CL006 := AFieldText;
    PR001_Valid_Until: PR001.PRecord.Valid_Until := AFieldText;
  end;
end;

procedure TPR001Coll.SetItem(Index: Integer; const Value: TPR001Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TPR001Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPR001Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPR001Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  PR001_CL132:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListPR001Search.Add(self.Items[i]);
  end;
end;
      PR001_Nomenclature:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Activity_ID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Notes:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Rules:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Specialty_CL006:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Valid_Until:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPR001Coll.ShowGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCell;
  TVirtualModeData(Grid.Data).OnSetValue:=self.SetCell;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TPR001Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPR001Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPR001Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TPR001Coll.SortByIndexAnsiString;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while ((Items[I]).IndexAnsiStr1) < ((Items[P]).IndexAnsiStr1) do Inc(I);
        while ((Items[J]).IndexAnsiStr1) > ((Items[P]).IndexAnsiStr1) do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
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
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TPR001Coll.SortByIndexInt;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I]).IndexInt < (Items[P]).IndexInt do Inc(I);
        while (Items[J]).IndexInt > (Items[P]).IndexInt do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
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
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TPR001Coll.SortByIndexValue(propIndex: TPR001Item.TPropertyIndex);
begin
  case propIndex of
    PR001_CL132: SortByIndexAnsiString;
      PR001_Nomenclature: SortByIndexAnsiString;
      PR001_Activity_ID: SortByIndexAnsiString;
      PR001_Description: SortByIndexAnsiString;
      PR001_Notes: SortByIndexAnsiString;
      PR001_Rules: SortByIndexAnsiString;
      PR001_Specialty_CL006: SortByIndexAnsiString;
      PR001_Valid_Until: SortByIndexAnsiString;
  end;
end;

end.