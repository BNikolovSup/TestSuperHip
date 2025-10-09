unit Table.AnalResult;

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



TAnalResultItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       AnalResult_ArrResult
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecAnalResult = ^TRecAnalResult;
      TRecAnalResult = record
        ArrResult: TArrInt;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecAnalResult;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertAnalResult;
    procedure UpdateAnalResult;
    procedure SaveAnalResult(var dataPosition: Cardinal)overload;
	procedure SaveAnalResult(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TAnalResultColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TAnalResultItem;
    function GetItem(Index: Integer): TAnalResultItem;
    procedure SetItem(Index: Integer; const Value: TAnalResultItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TAnalResultItem>;
    ListAnalResultSearch: TList<TAnalResultItem>;
	PRecordSearch: ^TAnalResultItem.TRecAnalResult;
    ArrPropSearch: TArray<TAnalResultItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TAnalResultItem.TPropertyIndex>;
	ArrayPropOrder: TArray<TAnalResultItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TAnalResultItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; AnalResult: TAnalResultItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; AnalResult: TAnalResultItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TAnalResultItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
    function FindRootCollOptionNode(): PVirtualNode;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TAnalResultItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TAnalResultItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TAnalResultItem.TPropertyIndex);
    property Items[Index: Integer]: TAnalResultItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    //procedure OnSetTextSearchLog(Log: TlogicalAnalResultSet);
  end;

implementation

{ TAnalResultItem }

constructor TAnalResultItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TAnalResultItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TAnalResultItem.InsertAnalResult;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctAnalResult;
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
            AnalResult_ArrResult: SaveData(PRecord.ArrResult, PropPosition, metaPosition, dataPosition);
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

function  TAnalResultItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TAnalResultItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TAnalResultItem;
begin
  Result := True;
  for i := 0 to Length(TAnalResultColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TAnalResultColl(coll).ArrPropSearchClc[i];
	ATempItem := TAnalResultColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        AnalResult_ArrResult:;// Result := IsFinded(ATempItem.PRecord.ArrResult, buf, FPosDataADB, word(AnalResult_ArrResult), cot);
      end;
    end;
  end;
end;

procedure TAnalResultItem.SaveAnalResult(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveAnalResult(dataPosition);
end;

procedure TAnalResultItem.SaveAnalResult(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAnalResult;
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
            AnalResult_ArrResult: SaveData(PRecord.ArrResult, PropPosition, metaPosition, dataPosition);
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

procedure TAnalResultItem.UpdateAnalResult;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAnalResult;
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
            AnalResult_ArrResult: UpdateData(PRecord.ArrResult, PropPosition, metaPosition, dataPosition);
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

{ TAnalResultColl }

function TAnalResultColl.AddItem(ver: word): TAnalResultItem;
begin
  Result := TAnalResultItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TAnalResultColl.AddItemForSearch: Integer;
var
  ItemForSearch: TAnalResultItem;
begin
  ItemForSearch := TAnalResultItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

function TAnalResultColl.CreateRootCollOptionNode(): PVirtualNode;
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

constructor TAnalResultColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TAnalResultItem.Create(nil);
  ListAnalResultSearch := TList<TAnalResultItem>.Create;
  ListForFinder := TList<TAnalResultItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrder, FieldCount);
  SetLength(ArrayPropOrderSearchOptions, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrayPropOrder[i] := TAnalResultItem.TPropertyIndex(i);
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TAnalResultColl.destroy;
begin
  FreeAndNil(ListAnalResultSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TAnalResultColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TAnalResultItem.TPropertyIndex(propIndex) of
    AnalResult_ArrResult: Result := 'ArrResult';
  end;
end;

procedure TAnalResultColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TAnalResultColl.FieldCount: Integer; 
begin
  inherited;
  Result := 1;
end;

function TAnalResultColl.FindRootCollOptionNode(): PVirtualNode;
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

function TAnalResultColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TAnalResultColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TAnalResultColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TAnalResultColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AnalResult: TAnalResultItem;
  ACol: Integer;
  prop: TAnalResultItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  AnalResult := Items[ARow];
  prop := TAnalResultItem.TPropertyIndex(ACol);
  if Assigned(AnalResult.PRecord) and (prop in AnalResult.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AnalResult, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AnalResult, AValue);
  end;
end;

procedure TAnalResultColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol, RowSelect: Integer;
  prop: TAnalResultItem.TPropertyIndex;
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

procedure TAnalResultColl.GetCellFromRecord(propIndex: word; AnalResult: TAnalResultItem; var AValue: String);
var
  str: string;
begin
  case TAnalResultItem.TPropertyIndex(propIndex) of
    AnalResult_ArrResult:;// str := AnalResult.PRecord.ArrResult);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TAnalResultColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TAnalResultItem;
  ACol: Integer;
  prop: TAnalResultItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TAnalResultItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TAnalResultColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TAnalResultItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TAnalResultItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TAnalResultColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AnalResult: TAnalResultItem;
  ACol: Integer;
  prop: TAnalResultItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  AnalResult := ListAnalResultSearch[ARow];
  prop := TAnalResultItem.TPropertyIndex(ACol);
  if Assigned(AnalResult.PRecord) and (prop in AnalResult.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AnalResult, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AnalResult, AValue);
  end;
end;

procedure TAnalResultColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  AnalResult: TAnalResultItem;
  prop: TAnalResultItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  AnalResult := Items[ARow];
  prop := TAnalResultItem.TPropertyIndex(ACol);
  if Assigned(AnalResult.PRecord) and (prop in AnalResult.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AnalResult, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AnalResult, AFieldText);
  end;
end;

procedure TAnalResultColl.GetCellFromMap(propIndex: word; ARow: Integer; AnalResult: TAnalResultItem; var AValue: String);
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
  case TAnalResultItem.TPropertyIndex(propIndex) of
    AnalResult_ArrResult:;
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TAnalResultColl.GetItem(Index: Integer): TAnalResultItem;
begin
  Result := TAnalResultItem(inherited GetItem(Index));
end;


procedure TAnalResultColl.IndexValue(propIndex: TAnalResultItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TAnalResultItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      AnalResult_ArrResult:;
    end;
  end;
end;

procedure TAnalResultColl.IndexValueListNodes(propIndex: TAnalResultItem.TPropertyIndex);
begin

end;

procedure TAnalResultColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TAnalResultItem;
begin
  if index < 0 then
  begin
    Tempitem := TAnalResultItem.Create(nil);
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





procedure TAnalResultColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TAnalResultItem.TPropertyIndex(Field));
  end
  else
  begin
    include(ListForFinder[0].PRecord.setProp, TAnalResultItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  if cotSens in Condition then
  begin
    case TAnalResultItem.TPropertyIndex(Field) of
      AnalResult_ArrResult:;
    end;
  end
  else
  begin
    case TAnalResultItem.TPropertyIndex(Field) of
      AnalResult_ArrResult:;
    end;
  end;
end;

//procedure TAnalResultColl.OnSetTextSearchLog(Log: TlogicalAnalResultSet);
//begin
//  ListForFinder[0].PRecord.Logical := Log;
//end;

procedure TAnalResultColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TAnalResultColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TAnalResultItem.TPropertyIndex(propIndex) of
    AnalResult_ArrResult: Result := actTArrInt;
  else
    Result := actNone;
  end
end;

procedure TAnalResultColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  AnalResult: TAnalResultItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  AnalResult := Items[ARow];
  if not Assigned(AnalResult.PRecord) then
  begin
    New(AnalResult.PRecord);
    AnalResult.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TAnalResultItem.TPropertyIndex(ACol) of
      AnalResult_ArrResult:;
    end;
  end;
  if isOld then
  begin
    Exclude(AnalResult.PRecord.setProp, TAnalResultItem.TPropertyIndex(ACol));
    if AnalResult.PRecord.setProp = [] then
    begin
      Dispose(AnalResult.PRecord);
      AnalResult.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(AnalResult.PRecord.setProp, TAnalResultItem.TPropertyIndex(ACol));
  case TAnalResultItem.TPropertyIndex(ACol) of
    AnalResult_ArrResult:;// AnalResult.PRecord.ArrResult
  end;
end;

procedure TAnalResultColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  AnalResult: TAnalResultItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  AnalResult := Items[ARow];
  if not Assigned(AnalResult.PRecord) then
  begin
    New(AnalResult.PRecord);
    AnalResult.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TAnalResultItem.TPropertyIndex(ACol) of
      AnalResult_ArrResult:;
    end;
  end;
  if isOld then
  begin
    Exclude(AnalResult.PRecord.setProp, TAnalResultItem.TPropertyIndex(ACol));
    if AnalResult.PRecord.setProp = [] then
    begin
      Dispose(AnalResult.PRecord);
      AnalResult.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(AnalResult.PRecord.setProp, TAnalResultItem.TPropertyIndex(ACol));
  case TAnalResultItem.TPropertyIndex(ACol) of
    AnalResult_ArrResult:;// AnalResult.PRecord.ArrResult
  end;
end;

procedure TAnalResultColl.SetItem(Index: Integer; const Value: TAnalResultItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TAnalResultColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListAnalResultSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TAnalResultItem.TPropertyIndex(self.FindedRes.PropIndex) of
	    AnalResult_ArrResult:;
    end;
  end;
end;

procedure TAnalResultColl.ShowGrid(Grid: TTeeGrid);
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

procedure TAnalResultColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TAnalResultItem>);
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

procedure TAnalResultColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListAnalResultSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListAnalResultSearch.Count]);

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

procedure TAnalResultColl.SortByIndexAnsiString;
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

procedure TAnalResultColl.SortByIndexInt;
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

procedure TAnalResultColl.SortByIndexWord;
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

procedure TAnalResultColl.SortByIndexValue(propIndex: TAnalResultItem.TPropertyIndex);
begin
  case propIndex of
    AnalResult_ArrResult:;
  end;
end;

end.