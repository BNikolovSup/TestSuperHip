unit Table.Unfav;

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

TLogicalUnfav = (
    IS_);
TlogicalUnfavSet = set of TLogicalUnfav;


TUnfavItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Unfav_ID
       , Unfav_DOCTOR_ID_PRAC
       , Unfav_YEAR_UNFAV
       , Unfav_MONTH_UNFAV
       , Unfav_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecUnfav = ^TRecUnfav;
      TRecUnfav = record
        ID: integer;
        DOCTOR_ID_PRAC: word;
        YEAR_UNFAV: word;
        MONTH_UNFAV: word;
        Logical: TlogicalUnfavSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecUnfav;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertUnfav;
    procedure UpdateUnfav;
    procedure SaveUnfav(var dataPosition: Cardinal)overload;
	procedure SaveUnfav(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TUnfavColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TUnfavItem;
    function GetItem(Index: Integer): TUnfavItem;
    procedure SetItem(Index: Integer; const Value: TUnfavItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TUnfavItem>;
    ListUnfavSearch: TList<TUnfavItem>;
	PRecordSearch: ^TUnfavItem.TRecUnfav;
    ArrPropSearch: TArray<TUnfavItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TUnfavItem.TPropertyIndex>;
	VisibleColl: TUnfavItem.TSetProp;
	ArrayPropOrder: TArray<TUnfavItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TUnfavItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Unfav: TUnfavItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Unfav: TUnfavItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TUnfavItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TUnfavItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TUnfavItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TUnfavItem.TPropertyIndex);
    property Items[Index: Integer]: TUnfavItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalUnfavSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
  end;

implementation

{ TUnfavItem }

constructor TUnfavItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TUnfavItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TUnfavItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TUnfavItem.GetCollType: TCollectionsType;
begin
  Result := ctUnfav;
end;

function TUnfavItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TUnfavItem.InsertUnfav;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctUnfav;
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
            Unfav_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Unfav_DOCTOR_ID_PRAC: SaveData(PRecord.DOCTOR_ID_PRAC, PropPosition, metaPosition, dataPosition);
            Unfav_YEAR_UNFAV: SaveData(PRecord.YEAR_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_MONTH_UNFAV: SaveData(PRecord.MONTH_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TUnfavItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TUnfavItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TUnfavItem;
begin
  Result := True;
  for i := 0 to Length(TUnfavColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TUnfavColl(coll).ArrPropSearchClc[i];
	ATempItem := TUnfavColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Unfav_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(Unfav_ID), cot);
            Unfav_DOCTOR_ID_PRAC: Result := IsFinded(ATempItem.PRecord.DOCTOR_ID_PRAC, buf, FPosDataADB, word(Unfav_DOCTOR_ID_PRAC), cot);
            Unfav_YEAR_UNFAV: Result := IsFinded(ATempItem.PRecord.YEAR_UNFAV, buf, FPosDataADB, word(Unfav_YEAR_UNFAV), cot);
            Unfav_MONTH_UNFAV: Result := IsFinded(ATempItem.PRecord.MONTH_UNFAV, buf, FPosDataADB, word(Unfav_MONTH_UNFAV), cot);
            Unfav_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Unfav_Logical), cot);
      end;
    end;
  end;
end;

procedure TUnfavItem.SaveUnfav(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveUnfav(dataPosition);
end;

procedure TUnfavItem.SaveUnfav(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctUnfav;
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
            Unfav_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Unfav_DOCTOR_ID_PRAC: SaveData(PRecord.DOCTOR_ID_PRAC, PropPosition, metaPosition, dataPosition);
            Unfav_YEAR_UNFAV: SaveData(PRecord.YEAR_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_MONTH_UNFAV: SaveData(PRecord.MONTH_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TUnfavItem.UpdateUnfav;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctUnfav;
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
            Unfav_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Unfav_DOCTOR_ID_PRAC: UpdateData(PRecord.DOCTOR_ID_PRAC, PropPosition, metaPosition, dataPosition);
            Unfav_YEAR_UNFAV: UpdateData(PRecord.YEAR_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_MONTH_UNFAV: UpdateData(PRecord.MONTH_UNFAV, PropPosition, metaPosition, dataPosition);
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

{ TUnfavColl }

function TUnfavColl.AddItem(ver: word): TUnfavItem;
begin
  Result := TUnfavItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TUnfavColl.AddItemForSearch: Integer;
var
  ItemForSearch: TUnfavItem;
begin
  ItemForSearch := TUnfavItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TUnfavColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TUnfavItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TUnfavColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvUnfavRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TUnfavColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TUnfavItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (Unfav_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(Unfav_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Unfav_DOCTOR_ID_PRAC in tempItem.PRecord.setProp) and (tempItem.PRecord.DOCTOR_ID_PRAC <> Self.getIntMap(tempItem.DataPos, word(Unfav_DOCTOR_ID_PRAC))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Unfav_YEAR_UNFAV in tempItem.PRecord.setProp) and (tempItem.PRecord.YEAR_UNFAV <> Self.getIntMap(tempItem.DataPos, word(Unfav_YEAR_UNFAV))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Unfav_MONTH_UNFAV in tempItem.PRecord.setProp) and (tempItem.PRecord.MONTH_UNFAV <> Self.getIntMap(tempItem.DataPos, word(Unfav_MONTH_UNFAV))) then
  begin
    inc(cnt);
    exit;
  end;

  if (Unfav_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(Unfav_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TUnfavColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TUnfavItem.Create(nil);
  ListUnfavSearch := TList<TUnfavItem>.Create;
  ListForFinder := TList<TUnfavItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TUnfavColl.destroy;
begin
  FreeAndNil(ListUnfavSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TUnfavColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: Result := 'ID';
    Unfav_DOCTOR_ID_PRAC: Result := 'DOCTOR_ID_PRAC';
    Unfav_YEAR_UNFAV: Result := 'YEAR_UNFAV';
    Unfav_MONTH_UNFAV: Result := 'MONTH_UNFAV';
    Unfav_Logical: Result := 'Logical';
  end;
end;

function TUnfavColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IS_';
  else
    Result := '???';
  end;
end;


procedure TUnfavColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TUnfavColl.FieldCount: Integer; 
begin
  inherited;
  Result := 5;
end;

function TUnfavColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvUnfavRoot then
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

function TUnfavColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TUnfavColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TUnfavColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TUnfavColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Unfav: TUnfavItem;
  ACol: Integer;
  prop: TUnfavItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Unfav := Items[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(Unfav.PRecord) and (prop in Unfav.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Unfav, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Unfav, AValue);
  end;
end;

procedure TUnfavColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TUnfavItem.TPropertyIndex;
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

procedure TUnfavColl.GetCellFromRecord(propIndex: word; Unfav: TUnfavItem; var AValue: String);
var
  str: string;
begin
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: str := inttostr(Unfav.PRecord.ID);
    Unfav_DOCTOR_ID_PRAC: str := inttostr(Unfav.PRecord.DOCTOR_ID_PRAC);
    Unfav_YEAR_UNFAV: str := inttostr(Unfav.PRecord.YEAR_UNFAV);
    Unfav_MONTH_UNFAV: str := inttostr(Unfav.PRecord.MONTH_UNFAV);
    Unfav_Logical: str := Unfav.Logical08ToStr(TLogicalData08(Unfav.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TUnfavColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TUnfavItem;
  ACol: Integer;
  prop: TUnfavItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TUnfavColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TUnfavItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TUnfavItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TUnfavColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Unfav: TUnfavItem;
  ACol: Integer;
  prop: TUnfavItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Unfav := ListUnfavSearch[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(Unfav.PRecord) and (prop in Unfav.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Unfav, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Unfav, AValue);
  end;
end;

function TUnfavColl.GetCollType: TCollectionsType;
begin
  Result := ctUnfav;
end;

procedure TUnfavColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Unfav: TUnfavItem;
  prop: TUnfavItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Unfav := Items[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(Unfav.PRecord) and (prop in Unfav.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Unfav, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Unfav, AFieldText);
  end;
end;

procedure TUnfavColl.GetCellFromMap(propIndex: word; ARow: Integer; Unfav: TUnfavItem; var AValue: String);
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
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: str :=  inttostr(Unfav.getIntMap(Self.Buf, Self.posData, propIndex));
    Unfav_DOCTOR_ID_PRAC: str :=  inttostr(Unfav.getWordMap(Self.Buf, Self.posData, propIndex));
    Unfav_YEAR_UNFAV: str :=  inttostr(Unfav.getWordMap(Self.Buf, Self.posData, propIndex));
    Unfav_MONTH_UNFAV: str :=  inttostr(Unfav.getWordMap(Self.Buf, Self.posData, propIndex));
    Unfav_Logical: str :=  Unfav.Logical08ToStr(Unfav.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TUnfavColl.GetItem(Index: Integer): TUnfavItem;
begin
  Result := TUnfavItem(inherited GetItem(Index));
end;


procedure TUnfavColl.IndexValue(propIndex: TUnfavItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TUnfavItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Unfav_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Unfav_DOCTOR_ID_PRAC: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Unfav_YEAR_UNFAV: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Unfav_MONTH_UNFAV: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TUnfavColl.IndexValueListNodes(propIndex: TUnfavItem.TPropertyIndex);
begin

end;

function TUnfavColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TUnfavItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TUnfavColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TUnfavItem;
begin
  if index < 0 then
  begin
    Tempitem := TUnfavItem.Create(nil);
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
procedure TUnfavColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TUnfavItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TUnfavItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TUnfavItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TUnfavColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TUnfavItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TUnfavItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TUnfavColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TUnfavItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TUnfavItem.TPropertyIndex(Field) of
Unfav_ID: ListForFinder[0].PRecord.ID := Value;
    Unfav_DOCTOR_ID_PRAC: ListForFinder[0].PRecord.DOCTOR_ID_PRAC := Value;
    Unfav_YEAR_UNFAV: ListForFinder[0].PRecord.YEAR_UNFAV := Value;
    Unfav_MONTH_UNFAV: ListForFinder[0].PRecord.MONTH_UNFAV := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TUnfavColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TUnfavItem.TPropertyIndex(Field) of
    Unfav_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalUnfav(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalUnfav(logIndex))   
    end;
  end;
end;


procedure TUnfavColl.OnSetTextSearchLog(Log: TlogicalUnfavSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TUnfavColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TUnfavColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: Result := actinteger;
    Unfav_DOCTOR_ID_PRAC: Result := actword;
    Unfav_YEAR_UNFAV: Result := actword;
    Unfav_MONTH_UNFAV: Result := actword;
    Unfav_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TUnfavColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TUnfavColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Unfav: TUnfavItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Unfav := Items[ARow];
  if not Assigned(Unfav.PRecord) then
  begin
    New(Unfav.PRecord);
    Unfav.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TUnfavItem.TPropertyIndex(ACol) of
      Unfav_ID: isOld :=  Unfav.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Unfav_DOCTOR_ID_PRAC: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Unfav_YEAR_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Unfav_MONTH_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
    if Unfav.PRecord.setProp = [] then
    begin
      Dispose(Unfav.PRecord);
      Unfav.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
  case TUnfavItem.TPropertyIndex(ACol) of
    Unfav_ID: Unfav.PRecord.ID := StrToInt(AValue);
    Unfav_DOCTOR_ID_PRAC: Unfav.PRecord.DOCTOR_ID_PRAC := StrToInt(AValue);
    Unfav_YEAR_UNFAV: Unfav.PRecord.YEAR_UNFAV := StrToInt(AValue);
    Unfav_MONTH_UNFAV: Unfav.PRecord.MONTH_UNFAV := StrToInt(AValue);
    Unfav_Logical: Unfav.PRecord.Logical := tlogicalUnfavSet(Unfav.StrToLogical08(AValue));
  end;
end;

procedure TUnfavColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Unfav: TUnfavItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Unfav := Items[ARow];
  if not Assigned(Unfav.PRecord) then
  begin
    New(Unfav.PRecord);
    Unfav.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TUnfavItem.TPropertyIndex(ACol) of
      Unfav_ID: isOld :=  Unfav.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Unfav_DOCTOR_ID_PRAC: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Unfav_YEAR_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Unfav_MONTH_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
    if Unfav.PRecord.setProp = [] then
    begin
      Dispose(Unfav.PRecord);
      Unfav.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
  case TUnfavItem.TPropertyIndex(ACol) of
    Unfav_ID: Unfav.PRecord.ID := StrToInt(AFieldText);
    Unfav_DOCTOR_ID_PRAC: Unfav.PRecord.DOCTOR_ID_PRAC := StrToInt(AFieldText);
    Unfav_YEAR_UNFAV: Unfav.PRecord.YEAR_UNFAV := StrToInt(AFieldText);
    Unfav_MONTH_UNFAV: Unfav.PRecord.MONTH_UNFAV := StrToInt(AFieldText);
    Unfav_Logical: Unfav.PRecord.Logical := tlogicalUnfavSet(Unfav.StrToLogical08(AFieldText));
  end;
end;

procedure TUnfavColl.SetItem(Index: Integer; const Value: TUnfavItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TUnfavColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListUnfavSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TUnfavItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Unfav_ID: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListUnfavSearch.Add(self.Items[i]);
  end;
end;
      Unfav_DOCTOR_ID_PRAC: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListUnfavSearch.Add(self.Items[i]);
        end;
      end;
      Unfav_YEAR_UNFAV: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListUnfavSearch.Add(self.Items[i]);
        end;
      end;
      Unfav_MONTH_UNFAV: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListUnfavSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TUnfavColl.ShowGrid(Grid: TTeeGrid);
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

procedure TUnfavColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TUnfavItem>);
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

procedure TUnfavColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListUnfavSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListUnfavSearch.Count]);

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

procedure TUnfavColl.SortByIndexAnsiString;
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

procedure TUnfavColl.SortByIndexInt;
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

procedure TUnfavColl.SortByIndexWord;
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

procedure TUnfavColl.SortByIndexValue(propIndex: TUnfavItem.TPropertyIndex);
begin
  case propIndex of
    Unfav_ID: SortByIndexInt;
      Unfav_DOCTOR_ID_PRAC: SortByIndexWord;
      Unfav_YEAR_UNFAV: SortByIndexWord;
      Unfav_MONTH_UNFAV: SortByIndexWord;
  end;
end;

end.