unit Table.CL139;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control;

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


TCL139Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL139_Key
, CL139_Description
, CL139_DescriptionEn
, CL139_cl138
);
	  
      TSetProp = set of TPropertyIndex;
      PRecCL139 = ^TRecCL139;
      TRecCL139 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        cl138: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL139;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL139;
    procedure UpdateCL139;
    procedure SaveCL139(var dataPosition: Cardinal);
  	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
    procedure FillPropCl139(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL139Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL139Item;
    procedure SetItem(Index: Integer; const Value: TCL139Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL139Item;
	ListForFDB: TList<TCL139Item>;
    ListCL139Search: TList<TCL139Item>;
	PRecordSearch: ^TCL139Item.TRecCL139;
    ArrPropSearch: TArray<TCL139Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL139Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL139Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL139: TCL139Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL139: TCL139Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL139Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL139Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL139Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL139Item.TPropertyIndex);
    property Items[Index: Integer]: TCL139Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    //procedure OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
    //procedure OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
    //procedure OnSetTextSearchCnk(Chk: TCheckBoxDyn);
   // procedure OnSetTextSearchLog(Log: TlogicalCL139Set);
  end;

implementation

{ TCL139Item }

constructor TCL139Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL139Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL139Item.FillPropCl139(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL139_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL139_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL139_DescriptionEn:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.DescriptionEn, lenstr);
      stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
    end;
    CL139_cl138:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl138, lenstr);
      stream.Read(Self.PRecord.cl138[1], lenStr);
    end;
  end;
end;

procedure TCL139Item.InsertCL139;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL139;
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
	  Self.DataPos := metaPosition;
	  
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            CL139_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL139_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL139_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL139_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
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

function  TCL139Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL139Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL139Item;
begin
  Result := True;
  for i := 0 to Length(TCL139Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL139Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL139Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL139_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL139_Key), cot);
            CL139_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL139_Description), cot);
            CL139_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL139_DescriptionEn), cot);
            CL139_cl138: Result := IsFinded(ATempItem.PRecord.cl138, buf, FPosDataADB, word(CL139_cl138), cot);
      end;
    end;
  end;
end;

procedure TCL139Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds08: TLogicalData08;
  propindexcl139: TCL139Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData08);
  stream.Read(flds08, sizeof(TLogicalData08));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl139Item.TSetProp(flds08);// тука се записва какво има като полета


  for propindexcl139 := Low(Tcl139Item.TPropertyIndex) to High(Tcl139Item.TPropertyIndex) do
  begin
    if not (propindexcl139 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl139);
      dataCmdProp.vid := vvCl139;
    end;
    self.FillPropCl139(propindexcl139, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL139Item.SaveCL139(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL139;
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
            CL139_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL139_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL139_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL139_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
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

procedure TCL139Item.UpdateCL139;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL139;
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
            CL139_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL139_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL139_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL139_cl138: UpdateData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
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

{ TCL139Coll }

function TCL139Coll.AddItem(ver: word): TCL139Item;
begin
  Result := TCL139Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL139Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL139Item;
begin
  ItemForSearch := TCL139Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL139Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL139Item.Create(nil);
  ListCL139Search := TList<TCL139Item>.Create;
  ListForFDB := TList<TCL139Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL139Coll.destroy;
begin
  FreeAndNil(ListCL139Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL139Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL139Item.TPropertyIndex(propIndex) of
    CL139_Key: Result := 'Key';
    CL139_Description: Result := 'Description';
    CL139_DescriptionEn: Result := 'DescriptionEn';
    CL139_cl138: Result := 'cl138';
  end;
end;

procedure TCL139Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL139Item.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TCL139Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 4;
end;

procedure TCL139Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL139: TCL139Item;
  ACol: Integer;
  prop: TCL139Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL139 := Items[ARow];
  prop := TCL139Item.TPropertyIndex(ACol);
  if Assigned(CL139.PRecord) and (prop in CL139.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL139, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL139, AValue);
  end;
end;

procedure TCL139Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL139Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TCL139Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL139Coll.GetCellFromRecord(propIndex: word; CL139: TCL139Item; var AValue: String);
var
  str: string;
begin
  case TCL139Item.TPropertyIndex(propIndex) of
    CL139_Key: str := (CL139.PRecord.Key);
    CL139_Description: str := (CL139.PRecord.Description);
    CL139_DescriptionEn: str := (CL139.PRecord.DescriptionEn);
    CL139_cl138: str := (CL139.PRecord.cl138);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL139Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL139Item;
  ACol: Integer;
  prop: TCL139Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL139Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL139Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL139Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL139Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL139Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL139: TCL139Item;
  ACol: Integer;
  prop: TCL139Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL139 := ListCL139Search[ARow];
  prop := TCL139Item.TPropertyIndex(ACol);
  if Assigned(CL139.PRecord) and (prop in CL139.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL139, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL139, AValue);
  end;
end;

procedure TCL139Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL139: TCL139Item;
  prop: TCL139Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL139 := Items[ARow];
  prop := TCL139Item.TPropertyIndex(ACol);
  if Assigned(CL139.PRecord) and (prop in CL139.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL139, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL139, AFieldText);
  end;
end;

procedure TCL139Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL139: TCL139Item; var AValue: String);
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
  case TCL139Item.TPropertyIndex(propIndex) of
    CL139_Key: str :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL139_Description: str :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL139_DescriptionEn: str :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL139_cl138: str :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL139Coll.GetItem(Index: Integer): TCL139Item;
begin
  Result := TCL139Item(inherited GetItem(Index));
end;


procedure TCL139Coll.IndexValue(propIndex: TCL139Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL139Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL139_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL139_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL139_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL139_cl138:
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

procedure TCL139Coll.IndexValueListNodes(propIndex: TCL139Item.TPropertyIndex);
begin

end;

procedure TCL139Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL139Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL139Item.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(field, -1, Tempitem, value);
    Tempitem.Free;
  end
  else
  begin
    Tempitem := Self.Items[index];
    if Assigned(Tempitem.PRecord) then
    begin
      GetCellFromRecord(field, Tempitem, value);
    end
    else
    begin
      GetCellFromMap(field, index, Tempitem, value);
    end;
  end;
end;

//procedure TCL139Coll.OnSetTextSearchCnk(Chk: TCheckBoxDyn);
//begin
// // if Chk.sta then
//
//end;

//procedure TCL139Coll.OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
//begin
//  if dtEdt.Date = 0 then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TCL139Item.TPropertyIndex(dtEdt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TCL139Item.TPropertyIndex(dtEdt.Field));
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  case TCL139Item.TPropertyIndex(dtEdt.Field) of
//    CL139_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := dtEdt.Date;
//  end;
//end;
//
//procedure TCL139Coll.OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//begin
//  if edt.Text = '' then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TCL139Item.TPropertyIndex(edt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TCL139Item.TPropertyIndex(edt.Field));
//    //ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  if cotSens in edt.Condition then
//  begin
//    case TCL139Item.TPropertyIndex(edt.Field) of
//      CL139_EGN: ListForFDB[0].PRecord.EGN  := edt.Text;
//      CL139_FNAME: ListForFDB[0].PRecord.FNAME  := edt.Text;
//      CL139_SNAME: ListForFDB[0].PRecord.SNAME  := edt.Text;
//      CL139_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //CL139_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end
//  else
//  begin
//    case TCL139Item.TPropertyIndex(edt.Field) of
//      CL139_EGN: ListForFDB[0].PRecord.EGN  := AnsiUpperCase(edt.Text);
//      CL139_FNAME: ListForFDB[0].PRecord.FNAME  := AnsiUpperCase(edt.Text);
//      CL139_SNAME: ListForFDB[0].PRecord.SNAME  := AnsiUpperCase(edt.Text);
//      CL139_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //CL139_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end;
//end;

//procedure TCL139Coll.OnSetTextSearchLog(Log: TlogicalCL139Set);
//begin
//  ListForFDB[0].PRecord.Logical := Log;
//end;

function TCL139Coll.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TCL139Item.TPropertyIndex(propIndex) of
    CL139_Key: Result := actAnsiString;
    CL139_Description: Result := actAnsiString;
    CL139_DescriptionEn: Result := actAnsiString;
    CL139_cl138: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL139Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL139: TCL139Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL139 := Items[ARow];
  if not Assigned(CL139.PRecord) then
  begin
    New(CL139.PRecord);
    CL139.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL139Item.TPropertyIndex(ACol) of
      CL139_Key: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL139_Description: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL139_DescriptionEn: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL139_cl138: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL139.PRecord.setProp, TCL139Item.TPropertyIndex(ACol));
    if CL139.PRecord.setProp = [] then
    begin
      Dispose(CL139.PRecord);
      CL139.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL139.PRecord.setProp, TCL139Item.TPropertyIndex(ACol));
  case TCL139Item.TPropertyIndex(ACol) of
    CL139_Key: CL139.PRecord.Key := AValue;
    CL139_Description: CL139.PRecord.Description := AValue;
    CL139_DescriptionEn: CL139.PRecord.DescriptionEn := AValue;
    CL139_cl138: CL139.PRecord.cl138 := AValue;
  end;
end;

procedure TCL139Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL139: TCL139Item;
begin
  if Count = 0 then Exit;

  CL139 := Items[ARow];
  if not Assigned(CL139.PRecord) then
  begin
    New(CL139.PRecord);
    CL139.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL139Item.TPropertyIndex(ACol) of
      CL139_Key: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL139_Description: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL139_DescriptionEn: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL139_cl138: isOld :=  CL139.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL139.PRecord.setProp, TCL139Item.TPropertyIndex(ACol));
    if CL139.PRecord.setProp = [] then
    begin
      Dispose(CL139.PRecord);
      CL139.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL139.PRecord.setProp, TCL139Item.TPropertyIndex(ACol));
  case TCL139Item.TPropertyIndex(ACol) of
    CL139_Key: CL139.PRecord.Key := AFieldText;
    CL139_Description: CL139.PRecord.Description := AFieldText;
    CL139_DescriptionEn: CL139.PRecord.DescriptionEn := AFieldText;
    CL139_cl138: CL139.PRecord.cl138 := AFieldText;
  end;
end;

procedure TCL139Coll.SetItem(Index: Integer; const Value: TCL139Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL139Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL139Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL139Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL139_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL139Search.Add(self.Items[i]);
  end;
end;
      CL139_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL139Search.Add(self.Items[i]);
        end;
      end;
      CL139_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL139Search.Add(self.Items[i]);
        end;
      end;
      CL139_cl138:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL139Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL139Coll.ShowGrid(Grid: TTeeGrid);
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
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL139Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL139Item>);
var
  i: word;

begin
  ListForFDB := LST;
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, LST.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellList;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL139Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL139Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL139Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
end;

procedure TCL139Coll.SortByIndexAnsiString;
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

procedure TCL139Coll.SortByIndexInt;
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

procedure TCL139Coll.SortByIndexWord;
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
        while (Items[I]).IndexWord < (Items[P]).IndexWord do Inc(I);
        while (Items[J]).IndexWord > (Items[P]).IndexWord do Dec(J);
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

procedure TCL139Coll.SortByIndexValue(propIndex: TCL139Item.TPropertyIndex);
begin
  case propIndex of
    CL139_Key: SortByIndexAnsiString;
      CL139_Description: SortByIndexAnsiString;
      CL139_DescriptionEn: SortByIndexAnsiString;
      CL139_cl138: SortByIndexAnsiString;
  end;
end;

end.