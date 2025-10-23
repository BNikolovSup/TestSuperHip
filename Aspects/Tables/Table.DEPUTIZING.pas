unit Table.DEPUTIZING;

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

TLogicalDEPUTIZING = (
    Is_Titul,
    Is_Zamestnik,
    Is_Naet,
    deputizing,
    deputizedBy);
TlogicalDEPUTIZINGSet = set of TLogicalDEPUTIZING;


TDEPUTIZINGItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       DEPUTIZING_BEGIN_AT
       , DEPUTIZING_DoctorDataPos
       , DEPUTIZING_DeputDataPos
       , DEPUTIZING_END_AT
       , DEPUTIZING_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecDEPUTIZING = ^TRecDEPUTIZING;
      TRecDEPUTIZING = record
        BEGIN_AT: TDate;
        DoctorDataPos: integer;
        DeputDataPos: integer;
        END_AT: TDate;
        Logical: TlogicalDEPUTIZINGSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecDEPUTIZING;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertDEPUTIZING;
    procedure UpdateDEPUTIZING;
    procedure SaveDEPUTIZING(var dataPosition: Cardinal)overload;
	procedure SaveDEPUTIZING(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TDEPUTIZINGColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TDEPUTIZINGItem;
    function GetItem(Index: Integer): TDEPUTIZINGItem;
    procedure SetItem(Index: Integer; const Value: TDEPUTIZINGItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TDEPUTIZINGItem>;
    ListDEPUTIZINGSearch: TList<TDEPUTIZINGItem>;
	PRecordSearch: ^TDEPUTIZINGItem.TRecDEPUTIZING;
    ArrPropSearch: TArray<TDEPUTIZINGItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TDEPUTIZINGItem.TPropertyIndex>;
	ArrayPropOrder: TArray<TDEPUTIZINGItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TDEPUTIZINGItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; DEPUTIZING: TDEPUTIZINGItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; DEPUTIZING: TDEPUTIZINGItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TDEPUTIZINGItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TDEPUTIZINGItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TDEPUTIZINGItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TDEPUTIZINGItem.TPropertyIndex);
    property Items[Index: Integer]: TDEPUTIZINGItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchLog(Log: TlogicalDEPUTIZINGSet);
  end;

implementation

{ TDEPUTIZINGItem }

constructor TDEPUTIZINGItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TDEPUTIZINGItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TDEPUTIZINGItem.InsertDEPUTIZING;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDEPUTIZING;
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
            DEPUTIZING_BEGIN_AT: SaveData(PRecord.BEGIN_AT, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_DoctorDataPos: SaveData(PRecord.DoctorDataPos, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_DeputDataPos: SaveData(PRecord.DeputDataPos, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_END_AT: SaveData(PRecord.END_AT, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TDEPUTIZINGItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TDEPUTIZINGItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TDEPUTIZINGItem;
begin
  Result := True;
  for i := 0 to Length(TDEPUTIZINGColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TDEPUTIZINGColl(coll).ArrPropSearchClc[i];
	ATempItem := TDEPUTIZINGColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        DEPUTIZING_BEGIN_AT: Result := IsFinded(ATempItem.PRecord.BEGIN_AT, buf, FPosDataADB, word(DEPUTIZING_BEGIN_AT), cot);
            DEPUTIZING_DoctorDataPos: Result := IsFinded(ATempItem.PRecord.DoctorDataPos, buf, FPosDataADB, word(DEPUTIZING_DoctorDataPos), cot);
            DEPUTIZING_DeputDataPos: Result := IsFinded(ATempItem.PRecord.DeputDataPos, buf, FPosDataADB, word(DEPUTIZING_DeputDataPos), cot);
            DEPUTIZING_END_AT: Result := IsFinded(ATempItem.PRecord.END_AT, buf, FPosDataADB, word(DEPUTIZING_END_AT), cot);
            DEPUTIZING_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(DEPUTIZING_Logical), cot);
      end;
    end;
  end;
end;

procedure TDEPUTIZINGItem.SaveDEPUTIZING(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveDEPUTIZING(dataPosition);
end;

procedure TDEPUTIZINGItem.SaveDEPUTIZING(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDEPUTIZING;
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
            DEPUTIZING_BEGIN_AT: SaveData(PRecord.BEGIN_AT, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_DoctorDataPos: SaveData(PRecord.DoctorDataPos, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_DeputDataPos: SaveData(PRecord.DeputDataPos, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_END_AT: SaveData(PRecord.END_AT, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TDEPUTIZINGItem.UpdateDEPUTIZING;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDEPUTIZING;
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
            DEPUTIZING_BEGIN_AT: UpdateData(PRecord.BEGIN_AT, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_DoctorDataPos: UpdateData(PRecord.DoctorDataPos, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_DeputDataPos: UpdateData(PRecord.DeputDataPos, PropPosition, metaPosition, dataPosition);
            DEPUTIZING_END_AT: UpdateData(PRecord.END_AT, PropPosition, metaPosition, dataPosition);
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

{ TDEPUTIZINGColl }

function TDEPUTIZINGColl.AddItem(ver: word): TDEPUTIZINGItem;
begin
  Result := TDEPUTIZINGItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TDEPUTIZINGColl.AddItemForSearch: Integer;
var
  ItemForSearch: TDEPUTIZINGItem;
begin
  ItemForSearch := TDEPUTIZINGItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

function TDEPUTIZINGColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvPregledRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
  linkOptions.AddNewNode(vvOptionSearchGrid, 0, Result , amAddChildLast, vOptionSearchGrid, linkPos);
  linkOptions.AddNewNode(vvOptionSearchCot, 0, Result , amAddChildLast, vOptionSearchCOT, linkPos);



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

constructor TDEPUTIZINGColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TDEPUTIZINGItem.Create(nil);
  ListDEPUTIZINGSearch := TList<TDEPUTIZINGItem>.Create;
  ListForFinder := TList<TDEPUTIZINGItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrder, FieldCount);
  SetLength(ArrayPropOrderSearchOptions, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrayPropOrder[i] := TDEPUTIZINGItem.TPropertyIndex(i);
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TDEPUTIZINGColl.destroy;
begin
  FreeAndNil(ListDEPUTIZINGSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TDEPUTIZINGColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TDEPUTIZINGItem.TPropertyIndex(propIndex) of
    DEPUTIZING_BEGIN_AT: Result := 'BEGIN_AT';
    DEPUTIZING_DoctorDataPos: Result := 'DoctorDataPos';
    DEPUTIZING_DeputDataPos: Result := 'DeputDataPos';
    DEPUTIZING_END_AT: Result := 'END_AT';
    DEPUTIZING_Logical: Result := 'Logical';
  end;
end;

procedure TDEPUTIZINGColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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
end;


function TDEPUTIZINGColl.FieldCount: Integer; 
begin
  inherited;
  Result := 5;
end;

function TDEPUTIZINGColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvPregledRoot then
    begin
      Result := Run;
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
end;

function TDEPUTIZINGColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TDEPUTIZINGColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TDEPUTIZINGColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TDEPUTIZINGColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  DEPUTIZING: TDEPUTIZINGItem;
  ACol: Integer;
  prop: TDEPUTIZINGItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  DEPUTIZING := Items[ARow];
  prop := TDEPUTIZINGItem.TPropertyIndex(ACol);
  if Assigned(DEPUTIZING.PRecord) and (prop in DEPUTIZING.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, DEPUTIZING, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, DEPUTIZING, AValue);
  end;
end;

procedure TDEPUTIZINGColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol, RowSelect: Integer;
  prop: TDEPUTIZINGItem.TPropertyIndex;
begin
  inherited;
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;
  try
    ACol := TVirtualModeData(Sender).IndexOf(AColumn);
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;

  GetCellFromMap(ArrayPropOrderSearchOptions[ACol], RowSelect, TempItem, AValue);
end;

procedure TDEPUTIZINGColl.GetCellFromRecord(propIndex: word; DEPUTIZING: TDEPUTIZINGItem; var AValue: String);
var
  str: string;
begin
  case TDEPUTIZINGItem.TPropertyIndex(propIndex) of
    DEPUTIZING_BEGIN_AT: str := AspDateToStr(DEPUTIZING.PRecord.BEGIN_AT);
    DEPUTIZING_DoctorDataPos: str := inttostr(DEPUTIZING.PRecord.DoctorDataPos);
    DEPUTIZING_DeputDataPos: str := inttostr(DEPUTIZING.PRecord.DeputDataPos);
    DEPUTIZING_END_AT: str := AspDateToStr(DEPUTIZING.PRecord.END_AT);
    DEPUTIZING_Logical: str := DEPUTIZING.Logical08ToStr(TLogicalData08(DEPUTIZING.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TDEPUTIZINGColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TDEPUTIZINGItem;
  ACol: Integer;
  prop: TDEPUTIZINGItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TDEPUTIZINGItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TDEPUTIZINGColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TDEPUTIZINGItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TDEPUTIZINGItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TDEPUTIZINGColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  DEPUTIZING: TDEPUTIZINGItem;
  ACol: Integer;
  prop: TDEPUTIZINGItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  DEPUTIZING := ListDEPUTIZINGSearch[ARow];
  prop := TDEPUTIZINGItem.TPropertyIndex(ACol);
  if Assigned(DEPUTIZING.PRecord) and (prop in DEPUTIZING.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, DEPUTIZING, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, DEPUTIZING, AValue);
  end;
end;

procedure TDEPUTIZINGColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  DEPUTIZING: TDEPUTIZINGItem;
  prop: TDEPUTIZINGItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  DEPUTIZING := Items[ARow];
  prop := TDEPUTIZINGItem.TPropertyIndex(ACol);
  if Assigned(DEPUTIZING.PRecord) and (prop in DEPUTIZING.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, DEPUTIZING, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, DEPUTIZING, AFieldText);
  end;
end;

procedure TDEPUTIZINGColl.GetCellFromMap(propIndex: word; ARow: Integer; DEPUTIZING: TDEPUTIZINGItem; var AValue: String);
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
  case TDEPUTIZINGItem.TPropertyIndex(propIndex) of
    DEPUTIZING_BEGIN_AT: str :=  AspDateToStr(DEPUTIZING.getDateMap(Self.Buf, Self.posData, propIndex));
    DEPUTIZING_DoctorDataPos: str :=  inttostr(DEPUTIZING.getIntMap(Self.Buf, Self.posData, propIndex));
    DEPUTIZING_DeputDataPos: str :=  inttostr(DEPUTIZING.getIntMap(Self.Buf, Self.posData, propIndex));
    DEPUTIZING_END_AT: str :=  AspDateToStr(DEPUTIZING.getDateMap(Self.Buf, Self.posData, propIndex));
    DEPUTIZING_Logical: str :=  DEPUTIZING.Logical08ToStr(DEPUTIZING.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TDEPUTIZINGColl.GetItem(Index: Integer): TDEPUTIZINGItem;
begin
  Result := TDEPUTIZINGItem(inherited GetItem(Index));
end;


procedure TDEPUTIZINGColl.IndexValue(propIndex: TDEPUTIZINGItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TDEPUTIZINGItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      DEPUTIZING_DoctorDataPos: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      DEPUTIZING_DeputDataPos: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TDEPUTIZINGColl.IndexValueListNodes(propIndex: TDEPUTIZINGItem.TPropertyIndex);
begin

end;

procedure TDEPUTIZINGColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TDEPUTIZINGItem;
begin
  if index < 0 then
  begin
    Tempitem := TDEPUTIZINGItem.Create(nil);
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

procedure TDEPUTIZINGColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TDEPUTIZINGItem.TPropertyIndex(Field));
  end
  else
  begin
    include(ListForFinder[0].PRecord.setProp, TDEPUTIZINGItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  if cotSens in Condition then
  begin
    //case TDEPUTIZINGItem.TPropertyIndex(Field) of
    //  DEPUTIZING_EGN: ListForFinder[0].PRecord.EGN  := Text;
    //  
    //end;
  end
  else
  begin
    //case TDEPUTIZINGItem.TPropertyIndex(Field) of
    //  DEPUTIZING_EGN: ListForFinder[0].PRecord.EGN  := AnsiUpperCase(Text);
    //end;
  end;
end;

procedure TDEPUTIZINGColl.OnSetTextSearchLog(Log: TlogicalDEPUTIZINGSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TDEPUTIZINGColl.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  run := FieldCollOptionNode.FirstChild;

  while run <> nil do
  begin
    Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy);
    ArrayPropOrderSearchOptions[run.index] :=  run.Dummy;
    run := run.NextSibling;
  end;

end;

function TDEPUTIZINGColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TDEPUTIZINGItem.TPropertyIndex(propIndex) of
    DEPUTIZING_BEGIN_AT: Result := actTDate;
    DEPUTIZING_DoctorDataPos: Result := actinteger;
    DEPUTIZING_DeputDataPos: Result := actinteger;
    DEPUTIZING_END_AT: Result := actTDate;
    DEPUTIZING_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TDEPUTIZINGColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TDEPUTIZINGColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  DEPUTIZING: TDEPUTIZINGItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  DEPUTIZING := Items[ARow];
  if not Assigned(DEPUTIZING.PRecord) then
  begin
    New(DEPUTIZING.PRecord);
    DEPUTIZING.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TDEPUTIZINGItem.TPropertyIndex(ACol) of
      DEPUTIZING_BEGIN_AT: isOld :=  DEPUTIZING.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    DEPUTIZING_DoctorDataPos: isOld :=  DEPUTIZING.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    DEPUTIZING_DeputDataPos: isOld :=  DEPUTIZING.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    DEPUTIZING_END_AT: isOld :=  DEPUTIZING.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(DEPUTIZING.PRecord.setProp, TDEPUTIZINGItem.TPropertyIndex(ACol));
    if DEPUTIZING.PRecord.setProp = [] then
    begin
      Dispose(DEPUTIZING.PRecord);
      DEPUTIZING.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(DEPUTIZING.PRecord.setProp, TDEPUTIZINGItem.TPropertyIndex(ACol));
  case TDEPUTIZINGItem.TPropertyIndex(ACol) of
    DEPUTIZING_BEGIN_AT: DEPUTIZING.PRecord.BEGIN_AT := StrToDate(AValue);
    DEPUTIZING_DoctorDataPos: DEPUTIZING.PRecord.DoctorDataPos := StrToInt(AValue);
    DEPUTIZING_DeputDataPos: DEPUTIZING.PRecord.DeputDataPos := StrToInt(AValue);
    DEPUTIZING_END_AT: DEPUTIZING.PRecord.END_AT := StrToDate(AValue);
    DEPUTIZING_Logical: DEPUTIZING.PRecord.Logical := tlogicalDEPUTIZINGSet(DEPUTIZING.StrToLogical08(AValue));
  end;
end;

procedure TDEPUTIZINGColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  DEPUTIZING: TDEPUTIZINGItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  DEPUTIZING := Items[ARow];
  if not Assigned(DEPUTIZING.PRecord) then
  begin
    New(DEPUTIZING.PRecord);
    DEPUTIZING.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TDEPUTIZINGItem.TPropertyIndex(ACol) of
      DEPUTIZING_BEGIN_AT: isOld :=  DEPUTIZING.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    DEPUTIZING_DoctorDataPos: isOld :=  DEPUTIZING.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    DEPUTIZING_DeputDataPos: isOld :=  DEPUTIZING.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    DEPUTIZING_END_AT: isOld :=  DEPUTIZING.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(DEPUTIZING.PRecord.setProp, TDEPUTIZINGItem.TPropertyIndex(ACol));
    if DEPUTIZING.PRecord.setProp = [] then
    begin
      Dispose(DEPUTIZING.PRecord);
      DEPUTIZING.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(DEPUTIZING.PRecord.setProp, TDEPUTIZINGItem.TPropertyIndex(ACol));
  case TDEPUTIZINGItem.TPropertyIndex(ACol) of
    DEPUTIZING_BEGIN_AT: DEPUTIZING.PRecord.BEGIN_AT := StrToDate(AFieldText);
    DEPUTIZING_DoctorDataPos: DEPUTIZING.PRecord.DoctorDataPos := StrToInt(AFieldText);
    DEPUTIZING_DeputDataPos: DEPUTIZING.PRecord.DeputDataPos := StrToInt(AFieldText);
    DEPUTIZING_END_AT: DEPUTIZING.PRecord.END_AT := StrToDate(AFieldText);
    DEPUTIZING_Logical: DEPUTIZING.PRecord.Logical := tlogicalDEPUTIZINGSet(DEPUTIZING.StrToLogical08(AFieldText));
  end;
end;

procedure TDEPUTIZINGColl.SetItem(Index: Integer; const Value: TDEPUTIZINGItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDEPUTIZINGColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListDEPUTIZINGSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TDEPUTIZINGItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  DEPUTIZING_DoctorDataPos: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDEPUTIZINGSearch.Add(self.Items[i]);
        end;
      end;
      DEPUTIZING_DeputDataPos: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDEPUTIZINGSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TDEPUTIZINGColl.ShowGrid(Grid: TTeeGrid);
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

procedure TDEPUTIZINGColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TDEPUTIZINGItem>);
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

procedure TDEPUTIZINGColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDEPUTIZINGSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDEPUTIZINGSearch.Count]);

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

procedure TDEPUTIZINGColl.SortByIndexAnsiString;
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

procedure TDEPUTIZINGColl.SortByIndexInt;
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

procedure TDEPUTIZINGColl.SortByIndexWord;
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

procedure TDEPUTIZINGColl.SortByIndexValue(propIndex: TDEPUTIZINGItem.TPropertyIndex);
begin
  case propIndex of
    DEPUTIZING_DoctorDataPos: SortByIndexInt;
      DEPUTIZING_DeputDataPos: SortByIndexInt;
  end;
end;

end.