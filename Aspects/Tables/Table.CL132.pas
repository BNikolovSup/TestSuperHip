unit Table.CL132;

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


TCL132Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (CL132_Key
, CL132_Description
, CL132_Display_Value_BG
, CL132_Display_Value_EN
, CL132_CL047_Mapping
, CL132_CL136_Mapping
, CL132_CL011_Mapping
, CL132_Event_Trigger
, CL132_Common_index
, CL132_Min_interval_from_common_index
, CL132_Max_interval_from_common_index
, CL132_Age
, CL132_Max_Age
, CL132_Recurring
, CL132_Repeat_Every_x_Years
, CL132_Gender
, CL132_Group
, CL132_Valid_Until
);
      TSetProp = set of TPropertyIndex;
      PRecCL132 = ^TRecCL132;
      TRecCL132 = record
        Key: AnsiString;
        Description: AnsiString;
        Display_Value_BG: AnsiString;
        Display_Value_EN: AnsiString;
        CL047_Mapping: AnsiString;
        CL136_Mapping: AnsiString;
        CL011_Mapping: AnsiString;
        Event_Trigger: AnsiString;
        Common_index: AnsiString;
        Min_interval_from_common_index: AnsiString;
        Max_interval_from_common_index: AnsiString;
        Age: AnsiString;
        Max_Age: AnsiString;
        Recurring: AnsiString;
        Repeat_Every_x_Years: AnsiString;
        Gender: AnsiString;
        Group: AnsiString;
        Valid_Until: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL132;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL132;
    procedure UpdateCL132;
    procedure SaveCL132(var dataPosition: Cardinal);
    procedure FillPropCl132(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL132Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL132Item;
    procedure SetItem(Index: Integer; const Value: TCL132Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListCL132Search: TList<TCL132Item>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL132Item;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellRow(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; CL132: TCL132Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL132: TCL132Item; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL132Item.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
  procedure ShowRow(Grid: TTeeGrid; item: TBaseItem);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL132Item.TPropertyIndex);
    property Items[Index: Integer]: TCL132Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;

  end;

implementation

{ TCL132Item }

constructor TCL132Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL132Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL132Item.FillPropCl132(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL132_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL132_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL132_Display_Value_BG:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Display_Value_BG, lenstr);
      stream.Read(Self.PRecord.Display_Value_BG[1], lenStr);
    end;
    CL132_Display_Value_EN:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Display_Value_EN, lenstr);
      stream.Read(Self.PRecord.Display_Value_EN[1], lenStr);
    end;
    CL132_CL047_Mapping:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.CL047_Mapping, lenstr);
      stream.Read(Self.PRecord.CL047_Mapping[1], lenStr);
    end;
    CL132_CL136_Mapping:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.CL136_Mapping, lenstr);
      stream.Read(Self.PRecord.CL136_Mapping[1], lenStr);
    end;
    CL132_CL011_Mapping:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.CL011_Mapping, lenstr);
      stream.Read(Self.PRecord.CL011_Mapping[1], lenStr);
    end;
    CL132_Event_Trigger:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Event_Trigger, lenstr);
      stream.Read(Self.PRecord.Event_Trigger[1], lenStr);
    end;

    CL132_Common_index:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Common_index, lenstr);
      stream.Read(Self.PRecord.Common_index[1], lenStr);
    end;
    CL132_Min_interval_from_common_index:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Min_interval_from_common_index, lenstr);
      stream.Read(Self.PRecord.Min_interval_from_common_index[1], lenStr);
    end;
    CL132_Max_interval_from_common_index:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Max_interval_from_common_index, lenstr);
      stream.Read(Self.PRecord.Max_interval_from_common_index[1], lenStr);
    end;
    CL132_Age:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Age, lenstr);
      stream.Read(Self.PRecord.Age[1], lenStr);
    end;
    CL132_Max_Age:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Max_Age, lenstr);
      stream.Read(Self.PRecord.Max_Age[1], lenStr);
    end;
    CL132_Recurring:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Recurring, lenstr);
      stream.Read(Self.PRecord.Recurring[1], lenStr);
    end;
    CL132_Repeat_Every_x_Years:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Repeat_Every_x_Years, lenstr);
      stream.Read(Self.PRecord.Repeat_Every_x_Years[1], lenStr);
    end;
    CL132_Gender:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Gender, lenstr);
      stream.Read(Self.PRecord.Gender[1], lenStr);
    end;
    CL132_Group:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Group, lenstr);
      stream.Read(Self.PRecord.Group[1], lenStr);
    end;
    CL132_Valid_Until:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Valid_Until, lenstr);
      stream.Read(Self.PRecord.Valid_Until[1], lenStr);
    end;

  end;
end;

procedure TCL132Item.InsertCL132;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL132;
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
            CL132_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL132_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL132_Display_Value_BG: SaveData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL132_Display_Value_EN: SaveData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL132_CL047_Mapping: SaveData(PRecord.CL047_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_CL136_Mapping: SaveData(PRecord.CL136_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_CL011_Mapping: SaveData(PRecord.CL011_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_Event_Trigger: SaveData(PRecord.Event_Trigger, PropPosition, metaPosition, dataPosition);
            CL132_Common_index: SaveData(PRecord.Common_index, PropPosition, metaPosition, dataPosition);
            CL132_Min_interval_from_common_index: SaveData(PRecord.Min_interval_from_common_index, PropPosition, metaPosition, dataPosition);
            CL132_Max_interval_from_common_index: SaveData(PRecord.Max_interval_from_common_index, PropPosition, metaPosition, dataPosition);
            CL132_Age: SaveData(PRecord.Age, PropPosition, metaPosition, dataPosition);
            CL132_Max_Age: SaveData(PRecord.Max_Age, PropPosition, metaPosition, dataPosition);
            CL132_Recurring: SaveData(PRecord.Recurring, PropPosition, metaPosition, dataPosition);
            CL132_Repeat_Every_x_Years: SaveData(PRecord.Repeat_Every_x_Years, PropPosition, metaPosition, dataPosition);
            CL132_Gender: SaveData(PRecord.Gender, PropPosition, metaPosition, dataPosition);
            CL132_Group: SaveData(PRecord.Group, PropPosition, metaPosition, dataPosition);
            CL132_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TCL132Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds24: TLogicalData24;
  propindexcl132: TCL132Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData24);
  stream.Read(flds24, sizeof(TLogicalData24));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl132Item.TSetProp(flds24);// тука се записва какво има като полета


  for propindexcl132 := Low(Tcl132Item.TPropertyIndex) to High(Tcl132Item.TPropertyIndex) do
  begin
    if not (propindexcl132 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl132);
      dataCmdProp.vid := vvCl132;
    end;
    self.FillPropCl132(propindexcl132, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL132Item.SaveCL132(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL132;
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
            CL132_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL132_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL132_Display_Value_BG: SaveData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL132_Display_Value_EN: SaveData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL132_CL047_Mapping: SaveData(PRecord.CL047_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_CL136_Mapping: SaveData(PRecord.CL136_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_CL011_Mapping: SaveData(PRecord.CL011_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_Event_Trigger: SaveData(PRecord.Event_Trigger, PropPosition, metaPosition, dataPosition);
            CL132_Common_index: SaveData(PRecord.Common_index, PropPosition, metaPosition, dataPosition);
            CL132_Min_interval_from_common_index: SaveData(PRecord.Min_interval_from_common_index, PropPosition, metaPosition, dataPosition);
            CL132_Max_interval_from_common_index: SaveData(PRecord.Max_interval_from_common_index, PropPosition, metaPosition, dataPosition);
            CL132_Age: SaveData(PRecord.Age, PropPosition, metaPosition, dataPosition);
            CL132_Max_Age: SaveData(PRecord.Max_Age, PropPosition, metaPosition, dataPosition);
            CL132_Recurring: SaveData(PRecord.Recurring, PropPosition, metaPosition, dataPosition);
            CL132_Repeat_Every_x_Years: SaveData(PRecord.Repeat_Every_x_Years, PropPosition, metaPosition, dataPosition);
            CL132_Gender: SaveData(PRecord.Gender, PropPosition, metaPosition, dataPosition);
            CL132_Group: SaveData(PRecord.Group, PropPosition, metaPosition, dataPosition);
            CL132_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

procedure TCL132Item.UpdateCL132;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL132;
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
            CL132_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL132_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL132_Display_Value_BG: UpdateData(PRecord.Display_Value_BG, PropPosition, metaPosition, dataPosition);
            CL132_Display_Value_EN: UpdateData(PRecord.Display_Value_EN, PropPosition, metaPosition, dataPosition);
            CL132_CL047_Mapping: UpdateData(PRecord.CL047_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_CL136_Mapping: UpdateData(PRecord.CL136_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_CL011_Mapping: UpdateData(PRecord.CL011_Mapping, PropPosition, metaPosition, dataPosition);
            CL132_Event_Trigger: UpdateData(PRecord.Event_Trigger, PropPosition, metaPosition, dataPosition);
            CL132_Common_index: UpdateData(PRecord.Common_index, PropPosition, metaPosition, dataPosition);
            CL132_Min_interval_from_common_index: UpdateData(PRecord.Min_interval_from_common_index, PropPosition, metaPosition, dataPosition);
            CL132_Max_interval_from_common_index: UpdateData(PRecord.Max_interval_from_common_index, PropPosition, metaPosition, dataPosition);
            CL132_Age: UpdateData(PRecord.Age, PropPosition, metaPosition, dataPosition);
            CL132_Max_Age: UpdateData(PRecord.Max_Age, PropPosition, metaPosition, dataPosition);
            CL132_Recurring: UpdateData(PRecord.Recurring, PropPosition, metaPosition, dataPosition);
            CL132_Repeat_Every_x_Years: UpdateData(PRecord.Repeat_Every_x_Years, PropPosition, metaPosition, dataPosition);
            CL132_Gender: UpdateData(PRecord.Gender, PropPosition, metaPosition, dataPosition);
            CL132_Group: UpdateData(PRecord.Group, PropPosition, metaPosition, dataPosition);
            CL132_Valid_Until: UpdateData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

{ TCL132Coll }

function TCL132Coll.AddItem(ver: word): TCL132Item;
begin
  Result := TCL132Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TCL132Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListCL132Search := TList<TCL132Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TCL132Coll.destroy;
begin
  FreeAndNil(ListCL132Search);
  inherited;
end;

function TCL132Coll.DisplayName(propIndex: Word): string;
begin
  case TCL132Item.TPropertyIndex(propIndex) of
    CL132_Key: Result := 'Key';
    CL132_Description: Result := 'Description';
    CL132_Display_Value_BG: Result := 'Display_Value_BG';
    CL132_Display_Value_EN: Result := 'Display_Value_EN';
    CL132_CL047_Mapping: Result := 'CL047_Mapping';
    CL132_CL136_Mapping: Result := 'CL136_Mapping';
    CL132_CL011_Mapping: Result := 'CL011_Mapping';
    CL132_Event_Trigger: Result := 'Event_Trigger';
    CL132_Common_index: Result := 'Common_index';
    CL132_Min_interval_from_common_index: Result := 'Min_interval_from_common_index';
    CL132_Max_interval_from_common_index: Result := 'Max_interval_from_common_index';
    CL132_Age: Result := 'Age';
    CL132_Max_Age: Result := 'Max_Age';
    CL132_Recurring: Result := 'Recurring';
    CL132_Repeat_Every_x_Years: Result := 'Repeat_Every_x_Years';
    CL132_Gender: Result := 'Gender';
    CL132_Group: Result := 'Group';
    CL132_Valid_Until: Result := 'Valid_Until';
  end;
end;

procedure TCL132Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL132Item.TPropertyIndex(self.FindedRes.PropIndex));
  //Self.SortByIndexValue;
end;

function TCL132Coll.FieldCount: Integer;
begin
  Result := 18;
end;

procedure TCL132Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL132: TCL132Item;
  ACol: Integer;
  prop: TCL132Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL132 := Items[ARow];
  prop := TCL132Item.TPropertyIndex(ACol);
  if Assigned(CL132.PRecord) and (prop in CL132.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL132, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL132, AValue);
  end;
end;

procedure TCL132Coll.GetCellFromRecord(propIndex: word; CL132: TCL132Item; var AValue: String);
var
  str: string;
begin
  case TCL132Item.TPropertyIndex(propIndex) of
    CL132_Key: str := (CL132.PRecord.Key);
    CL132_Description: str := (CL132.PRecord.Description);
    CL132_Display_Value_BG: str := (CL132.PRecord.Display_Value_BG);
    CL132_Display_Value_EN: str := (CL132.PRecord.Display_Value_EN);
    CL132_CL047_Mapping: str := (CL132.PRecord.CL047_Mapping);
    CL132_CL136_Mapping: str := (CL132.PRecord.CL136_Mapping);
    CL132_CL011_Mapping: str := (CL132.PRecord.CL011_Mapping);
    CL132_Event_Trigger: str := (CL132.PRecord.Event_Trigger);
    CL132_Common_index: str := (CL132.PRecord.Common_index);
    CL132_Min_interval_from_common_index: str := (CL132.PRecord.Min_interval_from_common_index);
    CL132_Max_interval_from_common_index: str := (CL132.PRecord.Max_interval_from_common_index);
    CL132_Age: str := (CL132.PRecord.Age);
    CL132_Max_Age: str := (CL132.PRecord.Max_Age);
    CL132_Recurring: str := (CL132.PRecord.Recurring);
    CL132_Repeat_Every_x_Years: str := (CL132.PRecord.Repeat_Every_x_Years);
    CL132_Gender: str := (CL132.PRecord.Gender);
    CL132_Group: str := (CL132.PRecord.Group);
    CL132_Valid_Until: str := (CL132.PRecord.Valid_Until);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL132Coll.GetCellRow(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL132: TCL132Item;
  ACol: Integer;
  prop: TCL132Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL132 := Items[ARow];
  prop := TCL132Item.TPropertyIndex(ACol);
  if Assigned(CL132.PRecord) and (prop in CL132.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL132, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL132, AValue);
  end;
end;

procedure TCL132Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL132: TCL132Item;
  ACol: Integer;
  prop: TCL132Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL132 := ListCL132Search[ARow];
  prop := TCL132Item.TPropertyIndex(ACol);
  if Assigned(CL132.PRecord) and (prop in CL132.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL132, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL132, AValue);
  end;
end;

procedure TCL132Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL132: TCL132Item;
  prop: TCL132Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL132 := Items[ARow];
  prop := TCL132Item.TPropertyIndex(ACol);
  if Assigned(CL132.PRecord) and (prop in CL132.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL132, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL132, AFieldText);
  end;
end;

procedure TCL132Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL132: TCL132Item; var AValue: String);
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
  case TCL132Item.TPropertyIndex(propIndex) of
    CL132_Key: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Description: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Display_Value_BG: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Display_Value_EN: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_CL047_Mapping: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_CL136_Mapping: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_CL011_Mapping: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Event_Trigger: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Common_index: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Min_interval_from_common_index: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Max_interval_from_common_index: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Age: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Max_Age: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Recurring: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Repeat_Every_x_Years: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Gender: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Group: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL132_Valid_Until: str :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL132Coll.GetItem(Index: Integer): TCL132Item;
begin
  Result := TCL132Item(inherited GetItem(Index));
end;


procedure TCL132Coll.IndexValue(propIndex: TCL132Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL132Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL132_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL132_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Display_Value_BG:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Display_Value_EN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_CL047_Mapping:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_CL136_Mapping:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_CL011_Mapping:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Event_Trigger:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Common_index:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Min_interval_from_common_index:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Max_interval_from_common_index:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Age:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Max_Age:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Recurring:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Repeat_Every_x_Years:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Gender:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Group:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL132_Valid_Until:
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

procedure TCL132Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL132: TCL132Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL132 := Items[ARow];
  if not Assigned(CL132.PRecord) then
  begin
    New(CL132.PRecord);
    CL132.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL132Item.TPropertyIndex(ACol) of
      CL132_Key: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Description: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Display_Value_BG: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Display_Value_EN: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_CL047_Mapping: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_CL136_Mapping: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_CL011_Mapping: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Event_Trigger: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Common_index: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Min_interval_from_common_index: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Max_interval_from_common_index: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Age: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Max_Age: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Recurring: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Repeat_Every_x_Years: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Gender: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Group: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL132_Valid_Until: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL132.PRecord.setProp, TCL132Item.TPropertyIndex(ACol));
    if CL132.PRecord.setProp = [] then
    begin
      Dispose(CL132.PRecord);
      CL132.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL132.PRecord.setProp, TCL132Item.TPropertyIndex(ACol));
  case TCL132Item.TPropertyIndex(ACol) of
    CL132_Key: CL132.PRecord.Key := AValue;
    CL132_Description: CL132.PRecord.Description := AValue;
    CL132_Display_Value_BG: CL132.PRecord.Display_Value_BG := AValue;
    CL132_Display_Value_EN: CL132.PRecord.Display_Value_EN := AValue;
    CL132_CL047_Mapping: CL132.PRecord.CL047_Mapping := AValue;
    CL132_CL136_Mapping: CL132.PRecord.CL136_Mapping := AValue;
    CL132_CL011_Mapping: CL132.PRecord.CL011_Mapping := AValue;
    CL132_Event_Trigger: CL132.PRecord.Event_Trigger := AValue;
    CL132_Common_index: CL132.PRecord.Common_index := AValue;
    CL132_Min_interval_from_common_index: CL132.PRecord.Min_interval_from_common_index := AValue;
    CL132_Max_interval_from_common_index: CL132.PRecord.Max_interval_from_common_index := AValue;
    CL132_Age: CL132.PRecord.Age := AValue;
    CL132_Max_Age: CL132.PRecord.Max_Age := AValue;
    CL132_Recurring: CL132.PRecord.Recurring := AValue;
    CL132_Repeat_Every_x_Years: CL132.PRecord.Repeat_Every_x_Years := AValue;
    CL132_Gender: CL132.PRecord.Gender := AValue;
    CL132_Group: CL132.PRecord.Group := AValue;
    CL132_Valid_Until: CL132.PRecord.Valid_Until := AValue;
  end;
end;

procedure TCL132Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL132: TCL132Item;
begin
  if Count = 0 then Exit;

  CL132 := Items[ARow];
  if not Assigned(CL132.PRecord) then
  begin
    New(CL132.PRecord);
    CL132.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL132Item.TPropertyIndex(ACol) of
      CL132_Key: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Description: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Display_Value_BG: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Display_Value_EN: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_CL047_Mapping: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_CL136_Mapping: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_CL011_Mapping: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Event_Trigger: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Common_index: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Min_interval_from_common_index: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Max_interval_from_common_index: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Age: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Max_Age: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Recurring: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Repeat_Every_x_Years: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Gender: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Group: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL132_Valid_Until: isOld :=  CL132.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL132.PRecord.setProp, TCL132Item.TPropertyIndex(ACol));
    if CL132.PRecord.setProp = [] then
    begin
      Dispose(CL132.PRecord);
      CL132.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL132.PRecord.setProp, TCL132Item.TPropertyIndex(ACol));
  case TCL132Item.TPropertyIndex(ACol) of
    CL132_Key: CL132.PRecord.Key := AFieldText;
    CL132_Description: CL132.PRecord.Description := AFieldText;
    CL132_Display_Value_BG: CL132.PRecord.Display_Value_BG := AFieldText;
    CL132_Display_Value_EN: CL132.PRecord.Display_Value_EN := AFieldText;
    CL132_CL047_Mapping: CL132.PRecord.CL047_Mapping := AFieldText;
    CL132_CL136_Mapping: CL132.PRecord.CL136_Mapping := AFieldText;
    CL132_CL011_Mapping: CL132.PRecord.CL011_Mapping := AFieldText;
    CL132_Event_Trigger: CL132.PRecord.Event_Trigger := AFieldText;
    CL132_Common_index: CL132.PRecord.Common_index := AFieldText;
    CL132_Min_interval_from_common_index: CL132.PRecord.Min_interval_from_common_index := AFieldText;
    CL132_Max_interval_from_common_index: CL132.PRecord.Max_interval_from_common_index := AFieldText;
    CL132_Age: CL132.PRecord.Age := AFieldText;
    CL132_Max_Age: CL132.PRecord.Max_Age := AFieldText;
    CL132_Recurring: CL132.PRecord.Recurring := AFieldText;
    CL132_Repeat_Every_x_Years: CL132.PRecord.Repeat_Every_x_Years := AFieldText;
    CL132_Gender: CL132.PRecord.Gender := AFieldText;
    CL132_Group: CL132.PRecord.Group := AFieldText;
    CL132_Valid_Until: CL132.PRecord.Valid_Until := AFieldText;
  end;
end;

procedure TCL132Coll.SetItem(Index: Integer; const Value: TCL132Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL132Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL132Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL132Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL132_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL132Search.Add(self.Items[i]);
  end;
end;
      CL132_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Display_Value_BG:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Display_Value_EN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_CL047_Mapping:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_CL136_Mapping:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_CL011_Mapping:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Event_Trigger:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Common_index:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Min_interval_from_common_index:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Max_interval_from_common_index:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Age:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Max_Age:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Recurring:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Repeat_Every_x_Years:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Gender:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Group:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
      CL132_Valid_Until:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL132Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL132Coll.ShowGrid(Grid: TTeeGrid);
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
    //Grid.Columns[i].EditorClass := TNumerEdit;
    //Grid.Columns[i].ReadOnly := True;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL132Coll.ShowRow(Grid: TTeeGrid; item: TBaseItem);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, 1);
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
    Grid.Columns[i].ReadOnly := True;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL132Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL132Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL132Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL132Coll.SortByIndexAnsiString;
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

procedure TCL132Coll.SortByIndexInt;
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

procedure TCL132Coll.SortByIndexValue(propIndex: TCL132Item.TPropertyIndex);
begin
  case propIndex of
    CL132_Key: SortByIndexAnsiString;
      CL132_Description: SortByIndexAnsiString;
      CL132_Display_Value_BG: SortByIndexAnsiString;
      CL132_Display_Value_EN: SortByIndexAnsiString;
      CL132_CL047_Mapping: SortByIndexAnsiString;
      CL132_CL136_Mapping: SortByIndexAnsiString;
      CL132_CL011_Mapping: SortByIndexAnsiString;
      CL132_Event_Trigger: SortByIndexAnsiString;
      CL132_Common_index: SortByIndexAnsiString;
      CL132_Min_interval_from_common_index: SortByIndexAnsiString;
      CL132_Max_interval_from_common_index: SortByIndexAnsiString;
      CL132_Age: SortByIndexAnsiString;
      CL132_Max_Age: SortByIndexAnsiString;
      CL132_Recurring: SortByIndexAnsiString;
      CL132_Repeat_Every_x_Years: SortByIndexAnsiString;
      CL132_Gender: SortByIndexAnsiString;
      CL132_Group: SortByIndexAnsiString;
      CL132_Valid_Until: SortByIndexAnsiString;
  end;
end;

end.