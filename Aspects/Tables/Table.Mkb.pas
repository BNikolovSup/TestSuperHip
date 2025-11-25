unit Table.Mkb;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults;

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

TLogicalMkb = (
    IS_);
TlogicalMkbSet = set of TLogicalMkb;


TMkbItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Mkb_CODE
       , Mkb_NAME
       , Mkb_NOTE
       , Mkb_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecMkb = ^TRecMkb;
      TRecMkb = record
        CODE: AnsiString;
        NAME: AnsiString;
        NOTE: AnsiString;
        Logical: TlogicalMkbSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecMkb;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertMkb;
    procedure UpdateMkb;
    procedure SaveMkb(var dataPosition: Cardinal)overload;
	procedure SaveMkb(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TMkbColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TMkbItem;
    function GetItem(Index: Integer): TMkbItem;
    procedure SetItem(Index: Integer; const Value: TMkbItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TMkbItem>;
    ListMkbSearch: TList<TMkbItem>;
	PRecordSearch: ^TMkbItem.TRecMkb;
    ArrPropSearch: TArray<TMkbItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TMkbItem.TPropertyIndex>;
	VisibleColl: TMkbItem.TSetProp;
	ArrayPropOrder: TArray<TMkbItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TMkbItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Mkb: TMkbItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Mkb: TMkbItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TMkbItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function DisplayLogicalName(flagIndex: Integer): string;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode; override;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TMkbItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TMkbItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TMkbItem.TPropertyIndex);
    property Items[Index: Integer]: TMkbItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalMkbSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TMkbItem }

constructor TMkbItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TMkbItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TMkbItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
var
  paramField: TParamProp;
  setPropPat: TSetProp;
  i: Integer;
  PropertyIndex: TPropertyIndex;
begin
  i := 0;
  for paramField in SetOfProp do
  begin
    PropertyIndex := TPropertyIndex(byte(paramField));
    Include(Self.PRecord.setProp, PropertyIndex);
    //case PropertyIndex of
      //PatientNew_EGN: Self.PRecord.EGN := arrstr[i];
    //end;
    inc(i);
  end;
end;

function TMkbItem.GetCollType: TCollectionsType;
begin
  Result := ctMkb;
end;

function TMkbItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TMkbItem.InsertMkb;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctMkb;
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
            Mkb_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Mkb_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Mkb_NOTE: SaveData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
            Mkb_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TMkbItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TMkbItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TMkbItem;
begin
  Result := True;
  for i := 0 to Length(TMkbColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TMkbColl(coll).ArrPropSearchClc[i];
	ATempItem := TMkbColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Mkb_CODE: Result := IsFinded(ATempItem.PRecord.CODE, buf, FPosDataADB, word(Mkb_CODE), cot);
            Mkb_NAME: Result := IsFinded(ATempItem.PRecord.NAME, buf, FPosDataADB, word(Mkb_NAME), cot);
            Mkb_NOTE: Result := IsFinded(ATempItem.PRecord.NOTE, buf, FPosDataADB, word(Mkb_NOTE), cot);
            Mkb_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Mkb_Logical), cot);
      end;
    end;
  end;
end;

procedure TMkbItem.SaveMkb(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveMkb(dataPosition);
end;

procedure TMkbItem.SaveMkb(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMkb;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, dataPosition);
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
            Mkb_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Mkb_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Mkb_NOTE: SaveData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
            Mkb_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TMkbItem.UpdateMkb;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMkb;
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
            Mkb_CODE: UpdateData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Mkb_NAME: UpdateData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Mkb_NOTE: UpdateData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
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

{ TMkbColl }

function TMkbColl.AddItem(ver: word): TMkbItem;
begin
  Result := TMkbItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TMkbColl.AddItemForSearch: Integer;
var
  ItemForSearch: TMkbItem;
begin
  ItemForSearch := TMkbItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TMkbColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
var
  run: PVirtualNode;
  data: PAspRec;
begin
  VisibleColl := [];

  run := RootNode.FirstChild;
  while run <> nil do
  begin
    data := PAspRec(PByte(run) + lenNode);

    if run.CheckState = csCheckedNormal then
      Include(VisibleColl, TMkbItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TMkbColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvMkbRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
  linkOptions.AddNewNode(vvOptionSearchGrid, 0, Result , amAddChildLast, vOptionSearchGrid, linkPos);
  linkOptions.AddNewNode(vvOptionSearchCot, 0, Result , amAddChildLast, vOptionSearchCOT, linkPos);

  vOptionSearchGrid.CheckType := ctTriStateCheckBox;

  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i + 1;
	  run.CheckType := ctCheckBox;
      run.CheckState := csCheckedNormal;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;  
end;

procedure TMkbColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TMkbItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (Mkb_CODE in tempItem.PRecord.setProp) and (tempItem.PRecord.CODE <> Self.getAnsiStringMap(tempItem.DataPos, word(Mkb_CODE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Mkb_NAME in tempItem.PRecord.setProp) and (tempItem.PRecord.NAME <> Self.getAnsiStringMap(tempItem.DataPos, word(Mkb_NAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Mkb_NOTE in tempItem.PRecord.setProp) and (tempItem.PRecord.NOTE <> Self.getAnsiStringMap(tempItem.DataPos, word(Mkb_NOTE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Mkb_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(Mkb_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TMkbColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TMkbItem.Create(nil);
  ListMkbSearch := TList<TMkbItem>.Create;
  ListForFinder := TList<TMkbItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TMkbColl.destroy;
begin
  FreeAndNil(ListMkbSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TMkbColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: Result := 'CODE';
    Mkb_NAME: Result := 'NAME';
    Mkb_NOTE: Result := 'NOTE';
    Mkb_Logical: Result := 'Logical';
  end;
end;

function TMkbColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IS_';
  else
    Result := '???';
  end;
end;


procedure TMkbColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
var
  FieldCollOptionNode, run: PVirtualNode;
  pSource, pTarget: PVirtualNode;
begin
  inherited;
  if linkOptions = nil then Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionGridNode;
  run := FieldCollOptionNode.FirstChild;
  pSource := nil;
  pTarget := nil;
  while run <> nil do
  begin
    if run.Index = NewPos - 1 then
    begin
      pTarget := run;
    end;
    if run.index = OldPos - 1 then
    begin
      pSource := run;
    end;
    run := run.NextSibling;
  end;

  if pTarget = nil then Exit;
  if pSource = nil then Exit;
  //ShowMessage(Format('pSource = %d, pTarget = %d', [pSource.Index, pTarget.Index]));
  if pSource.Index < pTarget.Index then
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertAfter, False);
  end
  else
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertBefore, False);
  end;
  run := FieldCollOptionNode.FirstChild;
  while run <> nil do
  begin
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end; 
end;


function TMkbColl.FieldCount: Integer; 
begin
  inherited;
  Result := 4;
end;

function TMkbColl.FindRootCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  PosLinkData: Cardinal;
  Run: PVirtualNode;
  data: PAspRec;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(linkOptions.Buf));
  PosLinkData := pCardinalData^;

  while linkPos <= PosLinkData do
  begin
    Run := pointer(PByte(linkOptions.Buf) + linkpos);
    data := Pointer(PByte(Run)+ lenNode);
    if data.vid = vvMkbRoot then
    begin
      Result := Run;
	  data := Pointer(PByte(Result)+ lenNode);
      data.DataPos := Cardinal(Self);
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
  if Result <> nil then
  begin
    data := Pointer(PByte(Result)+ lenNode);
    data.DataPos := Cardinal(Self);
  end;
end;

function TMkbColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchCot: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TMkbColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();

  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TMkbColl.FindSearchFieldCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  run, vOptionSearchGrid, vOptionSearchCOT, vRootPregOptions: PVirtualNode;
  i: Integer;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  if vRootPregOptions = nil then
    vRootPregOptions := CreateRootCollOptionNode;
  vOptionSearchGrid := nil;
  vOptionSearchCOT := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: vOptionSearchGrid := run;
      vvOptionSearchCot: vOptionSearchCOT := run;
    end;

    run := run.NextSibling;
  end;
  if vOptionSearchGrid = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchGrid, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;
  if vOptionSearchCOT = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchCot, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;

  Result := vOptionSearchGrid;
  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;
end;

procedure TMkbColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Mkb: TMkbItem;
  ACol: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Mkb := Items[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(Mkb.PRecord) and (prop in Mkb.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Mkb, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Mkb, AValue);
  end;
end;

procedure TMkbColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  inherited;
 
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;
  try
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;

  GetCellFromMap(ArrayPropOrderSearchOptions[AColumn.Index], RowSelect, TempItem, AValue);
end;

procedure TMkbColl.GetCellFromRecord(propIndex: word; Mkb: TMkbItem; var AValue: String);
var
  str: string;
begin
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: str := (Mkb.PRecord.CODE);
    Mkb_NAME: str := (Mkb.PRecord.NAME);
    Mkb_NOTE: str := (Mkb.PRecord.NOTE);
    Mkb_Logical: str := Mkb.Logical08ToStr(TLogicalData08(Mkb.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TMkbColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TMkbItem;
  ACol: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TMkbColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TMkbItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TMkbColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Mkb: TMkbItem;
  ACol: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Mkb := ListMkbSearch[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(Mkb.PRecord) and (prop in Mkb.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Mkb, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Mkb, AValue);
  end;
end;

function TMkbColl.GetCollType: TCollectionsType;
begin
  Result := ctMkb;
end;

function TMkbColl.GetCollDelType: TCollectionsType;
begin
  Result := ctMkbDel;
end;

procedure TMkbColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Mkb: TMkbItem;
  prop: TMkbItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Mkb := Items[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(Mkb.PRecord) and (prop in Mkb.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Mkb, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Mkb, AFieldText);
  end;
end;

procedure TMkbColl.GetCellFromMap(propIndex: word; ARow: Integer; Mkb: TMkbItem; var AValue: String);
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
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: str :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Mkb_NAME: str :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Mkb_NOTE: str :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Mkb_Logical: str :=  Mkb.Logical08ToStr(Mkb.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TMkbColl.GetItem(Index: Integer): TMkbItem;
begin
  Result := TMkbItem(inherited GetItem(Index));
end;


procedure TMkbColl.IndexValue(propIndex: TMkbItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TMkbItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Mkb_CODE:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Mkb_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Mkb_NOTE:
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

procedure TMkbColl.IndexValueListNodes(propIndex: TMkbItem.TPropertyIndex);
begin

end;

function TMkbColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TMkbItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TMkbColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TMkbItem;
begin
  if index < 0 then
  begin
    Tempitem := TMkbItem.Create(nil);
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

{=== TEXT SEARCH HANDLER ===}
procedure TMkbColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TMkbItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TMkbItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TMkbItem.TPropertyIndex(Field) of
Mkb_CODE: ListForFinder[0].PRecord.CODE := AText;
    Mkb_NAME: ListForFinder[0].PRecord.NAME := AText;
    Mkb_NOTE: ListForFinder[0].PRecord.NOTE := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TMkbColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TMkbItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TMkbItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TMkbColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TMkbItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TMkbItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TMkbColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TMkbItem.TPropertyIndex(Field) of
    Mkb_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalMkb(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalMkb(logIndex))   
    end;
  end;
end;


procedure TMkbColl.OnSetTextSearchLog(Log: TlogicalMkbSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TMkbColl.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  ApplyVisibilityFromTree(FieldCollOptionNode);
  run := FieldCollOptionNode.FirstChild;

  while run <> nil do
  begin
    Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy - 1);
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end;

end;

function TMkbColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: Result := actAnsiString;
    Mkb_NAME: Result := actAnsiString;
    Mkb_NOTE: Result := actAnsiString;
    Mkb_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TMkbColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TMkbColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Mkb: TMkbItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Mkb := Items[ARow];
  if not Assigned(Mkb.PRecord) then
  begin
    New(Mkb.PRecord);
    Mkb.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TMkbItem.TPropertyIndex(ACol) of
      Mkb_CODE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Mkb_NAME: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Mkb_NOTE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
    if Mkb.PRecord.setProp = [] then
    begin
      Dispose(Mkb.PRecord);
      Mkb.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
  case TMkbItem.TPropertyIndex(ACol) of
    Mkb_CODE: Mkb.PRecord.CODE := AValue;
    Mkb_NAME: Mkb.PRecord.NAME := AValue;
    Mkb_NOTE: Mkb.PRecord.NOTE := AValue;
    Mkb_Logical: Mkb.PRecord.Logical := tlogicalMkbSet(Mkb.StrToLogical08(AValue));
  end;
end;

procedure TMkbColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Mkb: TMkbItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Mkb := Items[ARow];
  if not Assigned(Mkb.PRecord) then
  begin
    New(Mkb.PRecord);
    Mkb.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TMkbItem.TPropertyIndex(ACol) of
      Mkb_CODE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Mkb_NAME: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Mkb_NOTE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
    if Mkb.PRecord.setProp = [] then
    begin
      Dispose(Mkb.PRecord);
      Mkb.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
  case TMkbItem.TPropertyIndex(ACol) of
    Mkb_CODE: Mkb.PRecord.CODE := AFieldText;
    Mkb_NAME: Mkb.PRecord.NAME := AFieldText;
    Mkb_NOTE: Mkb.PRecord.NOTE := AFieldText;
    Mkb_Logical: Mkb.PRecord.Logical := tlogicalMkbSet(Mkb.StrToLogical08(AFieldText));
  end;
end;

procedure TMkbColl.SetItem(Index: Integer; const Value: TMkbItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TMkbColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListMkbSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TMkbItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Mkb_CODE:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListMkbSearch.Add(self.Items[i]);
  end;
end;
      Mkb_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListMkbSearch.Add(self.Items[i]);
        end;
      end;
      Mkb_NOTE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListMkbSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TMkbColl.ShowGrid(Grid: TTeeGrid);
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

procedure TMkbColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TMkbItem>);
var
  i: word;

begin
  ListForFinder := LST;
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

procedure TMkbColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListMkbSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListMkbSearch.Count]);

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

procedure TMkbColl.SortByIndexAnsiString;
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
        while (Items[I].IndexAnsiStr1) < (Items[P].IndexAnsiStr1) do Inc(I);
        while (Items[J].IndexAnsiStr1) > (Items[P].IndexAnsiStr1) do Dec(J);
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

procedure TMkbColl.SortByIndexInt;
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

procedure TMkbColl.SortByIndexWord;
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

procedure TMkbColl.SortByIndexValue(propIndex: TMkbItem.TPropertyIndex);
begin
  case propIndex of
    Mkb_CODE: SortByIndexAnsiString;
      Mkb_NAME: SortByIndexAnsiString;
      Mkb_NOTE: SortByIndexAnsiString;
  end;
end;

end.