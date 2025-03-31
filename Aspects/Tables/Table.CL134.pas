unit Table.CL134;

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


TCL134Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (CL134_Key
, CL134_Description
, CL134_Display_Value_BG
, CL134_Display_Value_EN
, CL134_Note
, CL134_CL133
, CL134_Multiple_Choice
, CL134_CL028
, CL134_Answer_Nomenclature
, CL134_Since
, CL134_Valid_Until
);
      TSetProp = set of TPropertyIndex;
      PRecCL134 = ^TRecCL134;
      TRecCL134 = record
        Key: AnsiString;
        Description: AnsiString;
        Display_Value_BG: AnsiString;
        Display_Value_EN: AnsiString;
        Note: AnsiString;
        CL133: AnsiString;
        Multiple_Choice: AnsiString;
        CL028: AnsiString;
        Answer_Nomenclature: AnsiString;
        Since: AnsiString;
        Valid_Until: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL134;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL134;
    procedure UpdateCL134;
    procedure SaveCL134(var dataPosition: Cardinal);
    procedure FillPropCl134(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL134Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL134Item;
    procedure SetItem(Index: Integer; const Value: TCL134Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListCL134Search: TList<TCL134Item>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL134Item;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; CL134: TCL134Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL134: TCL134Item; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL134Item.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL134Item.TPropertyIndex);
    property Items[Index: Integer]: TCL134Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TCL134Item }

constructor TCL134Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL134Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL134Item.FillPropCl134(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL134_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL134_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL134_Display_Value_BG:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Display_Value_BG, lenstr);
      stream.Read(Self.PRecord.Display_Value_BG[1], lenStr);
    end;
    CL134_Display_Value_EN:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Display_Value_EN, lenstr);
      stream.Read(Self.PRecord.Display_Value_EN[1], lenStr);
    end;

    CL134_Note:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Note, lenstr);
      stream.Read(Self.PRecord.Note[1], lenStr);
    end;
    CL134_CL133:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.CL133, lenstr);
      stream.Read(Self.PRecord.CL133[1], lenStr);
    end;
    CL134_Multiple_Choice:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Multiple_Choice, lenstr);
      stream.Read(Self.PRecord.Multiple_Choice[1], lenStr);
    end;
    CL134_CL028:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.CL028, lenstr);
      stream.Read(Self.PRecord.CL028[1], lenStr);
    end;

    CL134_Answer_Nomenclature:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Answer_Nomenclature, lenstr);
      stream.Read(Self.PRecord.Answer_Nomenclature[1], lenStr);
    end;
    CL134_Since:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Since, lenstr);
      stream.Read(Self.PRecord.Since[1], lenStr);
    end;
    CL134_Valid_Until:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Valid_Until, lenstr);
      stream.Read(Self.PRecord.Valid_Until[1], lenStr);
    end;
  end;
end;

procedure TCL134Item.InsertCL134;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL134;
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
            CL134_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL134_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL134_Display_Value_BG: SaveData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL134_Display_Value_EN: SaveData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL134_Note: SaveData(PRecord.Note, PropPosition, metaPosition, dataPosition);
            CL134_CL133: SaveData(PRecord.CL133, PropPosition, metaPosition, dataPosition);
            CL134_Multiple_Choice: SaveData(PRecord.Multiple_Choice, PropPosition, metaPosition, dataPosition);
            CL134_CL028: SaveData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            CL134_Answer_Nomenclature: SaveData(PRecord.Answer_Nomenclature, PropPosition, metaPosition, dataPosition);
            CL134_Since: SaveData(PRecord.Since, PropPosition, metaPosition, dataPosition);
            CL134_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TCL134Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexcl134: TCL134Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl134Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexcl134 := Low(Tcl134Item.TPropertyIndex) to High(Tcl134Item.TPropertyIndex) do
  begin
    if not (propindexcl134 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl134);
      dataCmdProp.vid := vvCl134;
    end;
    self.FillPropCl134(propindexcl134, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL134Item.SaveCL134(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL134;
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
            CL134_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL134_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL134_Display_Value_BG: SaveData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL134_Display_Value_EN: SaveData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL134_Note: SaveData(PRecord.Note, PropPosition, metaPosition, dataPosition);
            CL134_CL133: SaveData(PRecord.CL133, PropPosition, metaPosition, dataPosition);
            CL134_Multiple_Choice: SaveData(PRecord.Multiple_Choice, PropPosition, metaPosition, dataPosition);
            CL134_CL028: SaveData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            CL134_Answer_Nomenclature: SaveData(PRecord.Answer_Nomenclature, PropPosition, metaPosition, dataPosition);
            CL134_Since: SaveData(PRecord.Since, PropPosition, metaPosition, dataPosition);
            CL134_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TCL134Item.UpdateCL134;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL134;
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
            CL134_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL134_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL134_Display_Value_BG: UpdateData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL134_Display_Value_EN: UpdateData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL134_Note: UpdateData(PRecord.Note, PropPosition, metaPosition, dataPosition);
            CL134_CL133: UpdateData(PRecord.CL133, PropPosition, metaPosition, dataPosition);
            CL134_Multiple_Choice: UpdateData(PRecord.Multiple_Choice, PropPosition, metaPosition, dataPosition);
            CL134_CL028: UpdateData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            CL134_Answer_Nomenclature: UpdateData(PRecord.Answer_Nomenclature, PropPosition, metaPosition, dataPosition);
            CL134_Since: UpdateData(PRecord.Since, PropPosition, metaPosition, dataPosition);
            CL134_Valid_Until: UpdateData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

{ TCL134Coll }

function TCL134Coll.AddItem(ver: word): TCL134Item;
begin
  Result := TCL134Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TCL134Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListCL134Search := TList<TCL134Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TCL134Coll.destroy;
begin
  FreeAndNil(ListCL134Search);
  inherited;
end;

function TCL134Coll.DisplayName(propIndex: Word): string;
begin
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: Result := 'Key';
    CL134_Description: Result := 'Description';
    CL134_Display_Value_BG: Result := 'Display_Value_BG';
    CL134_Display_Value_EN: Result := 'Display_Value_EN';
    CL134_Note: Result := 'Note';
    CL134_CL133: Result := 'CL133';
    CL134_Multiple_Choice: Result := 'Multiple_Choice';
    CL134_CL028: Result := 'CL028';
    CL134_Answer_Nomenclature: Result := 'Answer_Nomenclature';
    CL134_Since: Result := 'Since';
    CL134_Valid_Until: Result := 'Valid_Until';
  end;
end;

procedure TCL134Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL134Item.TPropertyIndex(self.FindedRes.PropIndex));
  //Self.SortByIndexValue;
end;

function TCL134Coll.FieldCount: Integer;
begin
  Result := 11;
end;

procedure TCL134Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL134: TCL134Item;
  ACol: Integer;
  prop: TCL134Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL134 := Items[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(CL134.PRecord) and (prop in CL134.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL134, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL134, AValue);
  end;
end;

procedure TCL134Coll.GetCellFromRecord(propIndex: word; CL134: TCL134Item; var AValue: String);
var
  str: string;
begin
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: str := (CL134.PRecord.Key);
    CL134_Description: str := (CL134.PRecord.Description);
    CL134_Display_Value_BG: str := (CL134.PRecord.Display_Value_BG);
    CL134_Display_Value_EN: str := (CL134.PRecord.Display_Value_EN);
    CL134_Note: str := (CL134.PRecord.Note);
    CL134_CL133: str := (CL134.PRecord.CL133);
    CL134_Multiple_Choice: str := (CL134.PRecord.Multiple_Choice);
    CL134_CL028: str := (CL134.PRecord.CL028);
    CL134_Answer_Nomenclature: str := (CL134.PRecord.Answer_Nomenclature);
    CL134_Since: str := (CL134.PRecord.Since);
    CL134_Valid_Until: str := (CL134.PRecord.Valid_Until);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL134Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL134: TCL134Item;
  ACol: Integer;
  prop: TCL134Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL134 := ListCL134Search[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(CL134.PRecord) and (prop in CL134.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL134, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL134, AValue);
  end;
end;

procedure TCL134Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL134: TCL134Item;
  prop: TCL134Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL134 := Items[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(CL134.PRecord) and (prop in CL134.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL134, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL134, AFieldText);
  end;
end;

procedure TCL134Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL134: TCL134Item; var AValue: String);
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
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Description: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Display_Value_BG: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Display_Value_EN: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Note: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_CL133: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Multiple_Choice: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_CL028: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Answer_Nomenclature: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Since: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Valid_Until: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL134Coll.GetItem(Index: Integer): TCL134Item;
begin
  Result := TCL134Item(inherited GetItem(Index));
end;


procedure TCL134Coll.IndexValue(propIndex: TCL134Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL134Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL134_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL134_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Display_Value_BG:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Display_Value_EN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Note:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_CL133:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Multiple_Choice:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_CL028:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Answer_Nomenclature:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Since:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_Valid_Until:
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

procedure TCL134Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL134: TCL134Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL134 := Items[ARow];
  if not Assigned(CL134.PRecord) then
  begin
    New(CL134.PRecord);
    CL134.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL134Item.TPropertyIndex(ACol) of
      CL134_Key: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Description: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Display_Value_BG: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Display_Value_EN: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Note: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_CL133: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Multiple_Choice: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_CL028: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Answer_Nomenclature: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Since: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Valid_Until: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
    if CL134.PRecord.setProp = [] then
    begin
      Dispose(CL134.PRecord);
      CL134.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
  case TCL134Item.TPropertyIndex(ACol) of
    CL134_Key: CL134.PRecord.Key := AValue;
    CL134_Description: CL134.PRecord.Description := AValue;
    CL134_Display_Value_BG: CL134.PRecord.Display_Value_BG := AValue;
    CL134_Display_Value_EN: CL134.PRecord.Display_Value_EN := AValue;
    CL134_Note: CL134.PRecord.Note := AValue;
    CL134_CL133: CL134.PRecord.CL133 := AValue;
    CL134_Multiple_Choice: CL134.PRecord.Multiple_Choice := AValue;
    CL134_CL028: CL134.PRecord.CL028 := AValue;
    CL134_Answer_Nomenclature: CL134.PRecord.Answer_Nomenclature := AValue;
    CL134_Since: CL134.PRecord.Since := AValue;
    CL134_Valid_Until: CL134.PRecord.Valid_Until := AValue;
  end;
end;

procedure TCL134Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL134: TCL134Item;
begin
  if Count = 0 then Exit;

  CL134 := Items[ARow];
  if not Assigned(CL134.PRecord) then
  begin
    New(CL134.PRecord);
    CL134.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL134Item.TPropertyIndex(ACol) of
      CL134_Key: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Description: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Display_Value_BG: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Display_Value_EN: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Note: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_CL133: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Multiple_Choice: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_CL028: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Answer_Nomenclature: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Since: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Valid_Until: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
    if CL134.PRecord.setProp = [] then
    begin
      Dispose(CL134.PRecord);
      CL134.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
  case TCL134Item.TPropertyIndex(ACol) of
    CL134_Key: CL134.PRecord.Key := AFieldText;
    CL134_Description: CL134.PRecord.Description := AFieldText;
    CL134_Display_Value_BG: CL134.PRecord.Display_Value_BG := AFieldText;
    CL134_Display_Value_EN: CL134.PRecord.Display_Value_EN := AFieldText;
    CL134_Note: CL134.PRecord.Note := AFieldText;
    CL134_CL133: CL134.PRecord.CL133 := AFieldText;
    CL134_Multiple_Choice: CL134.PRecord.Multiple_Choice := AFieldText;
    CL134_CL028: CL134.PRecord.CL028 := AFieldText;
    CL134_Answer_Nomenclature: CL134.PRecord.Answer_Nomenclature := AFieldText;
    CL134_Since: CL134.PRecord.Since := AFieldText;
    CL134_Valid_Until: CL134.PRecord.Valid_Until := AFieldText;
  end;
end;

procedure TCL134Coll.SetItem(Index: Integer; const Value: TCL134Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL134Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL134Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL134Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL134_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL134Search.Add(self.Items[i]);
  end;
end;
      CL134_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Display_Value_BG:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Display_Value_EN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Note:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_CL133:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Multiple_Choice:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_CL028:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Answer_Nomenclature:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Since:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_Valid_Until:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL134Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL134Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL134Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL134Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL134Coll.SortByIndexAnsiString;
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

procedure TCL134Coll.SortByIndexInt;
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

procedure TCL134Coll.SortByIndexValue(propIndex: TCL134Item.TPropertyIndex);
begin
  case propIndex of
    CL134_Key: SortByIndexAnsiString;
      CL134_Description: SortByIndexAnsiString;
      CL134_Display_Value_BG: SortByIndexAnsiString;
      CL134_Display_Value_EN: SortByIndexAnsiString;
      CL134_Note: SortByIndexAnsiString;
      CL134_CL133: SortByIndexAnsiString;
      CL134_Multiple_Choice: SortByIndexAnsiString;
      CL134_CL028: SortByIndexAnsiString;
      CL134_Answer_Nomenclature: SortByIndexAnsiString;
      CL134_Since: SortByIndexAnsiString;
      CL134_Valid_Until: SortByIndexAnsiString;
  end;
end;

end.