unit Table.NasMesto;

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

TLogicalNasMesto = (
    Is_Selo,
    IsGrad,
    IsManastir);
TlogicalNasMestoSet = set of TLogicalNasMesto;


TNasMestoItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       NasMesto_NasMestoName
       , NasMesto_ObshID
       , NasMesto_OblID
       , NasMesto_EKATTE
       , NasMesto_ZIP
       , NasMesto_RCZR
       , NasMesto_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecNasMesto = ^TRecNasMesto;
      TRecNasMesto = record
        NasMestoName: AnsiString;
        ObshID: word;
        OblID: word;
        EKATTE: AnsiString;
        ZIP: AnsiString;
        RCZR: AnsiString;
        Logical: TlogicalNasMestoSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNasMesto;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNasMesto;
    procedure UpdateNasMesto;
    procedure SaveNasMesto(var dataPosition: Cardinal)overload;
	procedure SaveNasMesto(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TNasMestoColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TNasMestoItem;
    function GetItem(Index: Integer): TNasMestoItem;
    procedure SetItem(Index: Integer; const Value: TNasMestoItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TNasMestoItem>;
    ListNasMestoSearch: TList<TNasMestoItem>;
	PRecordSearch: ^TNasMestoItem.TRecNasMesto;
    ArrPropSearch: TArray<TNasMestoItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNasMestoItem.TPropertyIndex>;
	ArrayPropOrder: TArray<TNasMestoItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNasMestoItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NasMesto: TNasMestoItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NasMesto: TNasMestoItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNasMestoItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNasMestoItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNasMestoItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNasMestoItem.TPropertyIndex);
    property Items[Index: Integer]: TNasMestoItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchLog(Log: TlogicalNasMestoSet);
  end;

implementation

{ TNasMestoItem }

constructor TNasMestoItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNasMestoItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNasMestoItem.InsertNasMesto;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNasMesto;
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
            NasMesto_NasMestoName: SaveData(PRecord.NasMestoName, PropPosition, metaPosition, dataPosition);
            NasMesto_ObshID: SaveData(PRecord.ObshID, PropPosition, metaPosition, dataPosition);
            NasMesto_OblID: SaveData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
            NasMesto_EKATTE: SaveData(PRecord.EKATTE, PropPosition, metaPosition, dataPosition);
            NasMesto_ZIP: SaveData(PRecord.ZIP, PropPosition, metaPosition, dataPosition);
            NasMesto_RCZR: SaveData(PRecord.RCZR, PropPosition, metaPosition, dataPosition);
            NasMesto_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TNasMestoItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNasMestoItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNasMestoItem;
begin
  Result := True;
  for i := 0 to Length(TNasMestoColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNasMestoColl(coll).ArrPropSearchClc[i];
	ATempItem := TNasMestoColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NasMesto_NasMestoName: Result := IsFinded(ATempItem.PRecord.NasMestoName, buf, FPosDataADB, word(NasMesto_NasMestoName), cot);
            NasMesto_ObshID: Result := IsFinded(ATempItem.PRecord.ObshID, buf, FPosDataADB, word(NasMesto_ObshID), cot);
            NasMesto_OblID: Result := IsFinded(ATempItem.PRecord.OblID, buf, FPosDataADB, word(NasMesto_OblID), cot);
            NasMesto_EKATTE: Result := IsFinded(ATempItem.PRecord.EKATTE, buf, FPosDataADB, word(NasMesto_EKATTE), cot);
            NasMesto_ZIP: Result := IsFinded(ATempItem.PRecord.ZIP, buf, FPosDataADB, word(NasMesto_ZIP), cot);
            NasMesto_RCZR: Result := IsFinded(ATempItem.PRecord.RCZR, buf, FPosDataADB, word(NasMesto_RCZR), cot);
            NasMesto_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(NasMesto_Logical), cot);
      end;
    end;
  end;
end;

procedure TNasMestoItem.SaveNasMesto(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveNasMesto(dataPosition);
end;

procedure TNasMestoItem.SaveNasMesto(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNasMesto;
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
            NasMesto_NasMestoName: SaveData(PRecord.NasMestoName, PropPosition, metaPosition, dataPosition);
            NasMesto_ObshID: SaveData(PRecord.ObshID, PropPosition, metaPosition, dataPosition);
            NasMesto_OblID: SaveData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
            NasMesto_EKATTE: SaveData(PRecord.EKATTE, PropPosition, metaPosition, dataPosition);
            NasMesto_ZIP: SaveData(PRecord.ZIP, PropPosition, metaPosition, dataPosition);
            NasMesto_RCZR: SaveData(PRecord.RCZR, PropPosition, metaPosition, dataPosition);
            NasMesto_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TNasMestoItem.UpdateNasMesto;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNasMesto;
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
            NasMesto_NasMestoName: UpdateData(PRecord.NasMestoName, PropPosition, metaPosition, dataPosition);
            NasMesto_ObshID: UpdateData(PRecord.ObshID, PropPosition, metaPosition, dataPosition);
            NasMesto_OblID: UpdateData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
            NasMesto_EKATTE: UpdateData(PRecord.EKATTE, PropPosition, metaPosition, dataPosition);
            NasMesto_ZIP: UpdateData(PRecord.ZIP, PropPosition, metaPosition, dataPosition);
            NasMesto_RCZR: UpdateData(PRecord.RCZR, PropPosition, metaPosition, dataPosition);
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

{ TNasMestoColl }

function TNasMestoColl.AddItem(ver: word): TNasMestoItem;
begin
  Result := TNasMestoItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNasMestoColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNasMestoItem;
begin
  ItemForSearch := TNasMestoItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

function TNasMestoColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvPregledNewRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

constructor TNasMestoColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TNasMestoItem.Create(nil);
  ListNasMestoSearch := TList<TNasMestoItem>.Create;
  ListForFinder := TList<TNasMestoItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrder, FieldCount);
  SetLength(ArrayPropOrderSearchOptions, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrayPropOrder[i] := TNasMestoItem.TPropertyIndex(i);
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TNasMestoColl.destroy;
begin
  FreeAndNil(ListNasMestoSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNasMestoColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: Result := 'NasMestoName';
    NasMesto_ObshID: Result := 'ObshID';
    NasMesto_OblID: Result := 'OblID';
    NasMesto_EKATTE: Result := 'EKATTE';
    NasMesto_ZIP: Result := 'ZIP';
    NasMesto_RCZR: Result := 'RCZR';
    NasMesto_Logical: Result := 'Logical';
  end;
end;

procedure TNasMestoColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TNasMestoColl.FieldCount: Integer; 
begin
  inherited;
  Result := 7;
end;

function TNasMestoColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvPregledNewRoot then
    begin
      Result := Run;
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
end;

function TNasMestoColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TNasMestoColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TNasMestoColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TNasMestoColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NasMesto: TNasMestoItem;
  ACol: Integer;
  prop: TNasMestoItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NasMesto := Items[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(NasMesto.PRecord) and (prop in NasMesto.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NasMesto, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NasMesto, AValue);
  end;
end;

procedure TNasMestoColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol, RowSelect: Integer;
  prop: TNasMestoItem.TPropertyIndex;
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

procedure TNasMestoColl.GetCellFromRecord(propIndex: word; NasMesto: TNasMestoItem; var AValue: String);
var
  str: string;
begin
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: str := (NasMesto.PRecord.NasMestoName);
    NasMesto_ObshID: str := inttostr(NasMesto.PRecord.ObshID);
    NasMesto_OblID: str := inttostr(NasMesto.PRecord.OblID);
    NasMesto_EKATTE: str := (NasMesto.PRecord.EKATTE);
    NasMesto_ZIP: str := (NasMesto.PRecord.ZIP);
    NasMesto_RCZR: str := (NasMesto.PRecord.RCZR);
    NasMesto_Logical: str := NasMesto.Logical08ToStr(TLogicalData08(NasMesto.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNasMestoColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNasMestoItem;
  ACol: Integer;
  prop: TNasMestoItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNasMestoColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNasMestoItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNasMestoItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNasMestoColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NasMesto: TNasMestoItem;
  ACol: Integer;
  prop: TNasMestoItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NasMesto := ListNasMestoSearch[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(NasMesto.PRecord) and (prop in NasMesto.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NasMesto, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NasMesto, AValue);
  end;
end;

procedure TNasMestoColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NasMesto: TNasMestoItem;
  prop: TNasMestoItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NasMesto := Items[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(NasMesto.PRecord) and (prop in NasMesto.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NasMesto, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NasMesto, AFieldText);
  end;
end;

procedure TNasMestoColl.GetCellFromMap(propIndex: word; ARow: Integer; NasMesto: TNasMestoItem; var AValue: String);
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
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NasMesto_ObshID: str :=  inttostr(NasMesto.getWordMap(Self.Buf, Self.posData, propIndex));
    NasMesto_OblID: str :=  inttostr(NasMesto.getWordMap(Self.Buf, Self.posData, propIndex));
    NasMesto_EKATTE: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NasMesto_ZIP: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NasMesto_RCZR: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NasMesto_Logical: str :=  NasMesto.Logical08ToStr(NasMesto.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNasMestoColl.GetItem(Index: Integer): TNasMestoItem;
begin
  Result := TNasMestoItem(inherited GetItem(Index));
end;


procedure TNasMestoColl.IndexValue(propIndex: TNasMestoItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNasMestoItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NasMesto_NasMestoName:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NasMesto_ObshID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NasMesto_OblID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NasMesto_EKATTE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NasMesto_ZIP:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NasMesto_RCZR:
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

procedure TNasMestoColl.IndexValueListNodes(propIndex: TNasMestoItem.TPropertyIndex);
begin

end;

procedure TNasMestoColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNasMestoItem;
begin
  if index < 0 then
  begin
    Tempitem := TNasMestoItem.Create(nil);
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

procedure TNasMestoColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TNasMestoItem.TPropertyIndex(Field));
  end
  else
  begin
    include(ListForFinder[0].PRecord.setProp, TNasMestoItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  if cotSens in Condition then
  begin
    //case TNasMestoItem.TPropertyIndex(Field) of
    //  NasMesto_EGN: ListForFinder[0].PRecord.EGN  := Text;
    //  
    //end;
  end
  else
  begin
    //case TNasMestoItem.TPropertyIndex(Field) of
    //  NasMesto_EGN: ListForFinder[0].PRecord.EGN  := AnsiUpperCase(Text);
    //end;
  end;
end;

procedure TNasMestoColl.OnSetTextSearchLog(Log: TlogicalNasMestoSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TNasMestoColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TNasMestoColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: Result := actAnsiString;
    NasMesto_ObshID: Result := actword;
    NasMesto_OblID: Result := actword;
    NasMesto_EKATTE: Result := actAnsiString;
    NasMesto_ZIP: Result := actAnsiString;
    NasMesto_RCZR: Result := actAnsiString;
    NasMesto_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TNasMestoColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TNasMestoColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NasMesto: TNasMestoItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  NasMesto := Items[ARow];
  if not Assigned(NasMesto.PRecord) then
  begin
    New(NasMesto.PRecord);
    NasMesto.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNasMestoItem.TPropertyIndex(ACol) of
      NasMesto_NasMestoName: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NasMesto_ObshID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NasMesto_OblID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NasMesto_EKATTE: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NasMesto_ZIP: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NasMesto_RCZR: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
    if NasMesto.PRecord.setProp = [] then
    begin
      Dispose(NasMesto.PRecord);
      NasMesto.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
  case TNasMestoItem.TPropertyIndex(ACol) of
    NasMesto_NasMestoName: NasMesto.PRecord.NasMestoName := AValue;
    NasMesto_ObshID: NasMesto.PRecord.ObshID := StrToInt(AValue);
    NasMesto_OblID: NasMesto.PRecord.OblID := StrToInt(AValue);
    NasMesto_EKATTE: NasMesto.PRecord.EKATTE := AValue;
    NasMesto_ZIP: NasMesto.PRecord.ZIP := AValue;
    NasMesto_RCZR: NasMesto.PRecord.RCZR := AValue;
    NasMesto_Logical: NasMesto.PRecord.Logical := tlogicalNasMestoSet(NasMesto.StrToLogical08(AValue));
  end;
end;

procedure TNasMestoColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NasMesto: TNasMestoItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  NasMesto := Items[ARow];
  if not Assigned(NasMesto.PRecord) then
  begin
    New(NasMesto.PRecord);
    NasMesto.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNasMestoItem.TPropertyIndex(ACol) of
      NasMesto_NasMestoName: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NasMesto_ObshID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NasMesto_OblID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NasMesto_EKATTE: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NasMesto_ZIP: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NasMesto_RCZR: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
    if NasMesto.PRecord.setProp = [] then
    begin
      Dispose(NasMesto.PRecord);
      NasMesto.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
  case TNasMestoItem.TPropertyIndex(ACol) of
    NasMesto_NasMestoName: NasMesto.PRecord.NasMestoName := AFieldText;
    NasMesto_ObshID: NasMesto.PRecord.ObshID := StrToInt(AFieldText);
    NasMesto_OblID: NasMesto.PRecord.OblID := StrToInt(AFieldText);
    NasMesto_EKATTE: NasMesto.PRecord.EKATTE := AFieldText;
    NasMesto_ZIP: NasMesto.PRecord.ZIP := AFieldText;
    NasMesto_RCZR: NasMesto.PRecord.RCZR := AFieldText;
    NasMesto_Logical: NasMesto.PRecord.Logical := tlogicalNasMestoSet(NasMesto.StrToLogical08(AFieldText));
  end;
end;

procedure TNasMestoColl.SetItem(Index: Integer; const Value: TNasMestoItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNasMestoColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNasMestoSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNasMestoItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NasMesto_NasMestoName:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNasMestoSearch.Add(self.Items[i]);
  end;
end;
      NasMesto_ObshID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_OblID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_EKATTE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_ZIP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_RCZR:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNasMestoColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNasMestoColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNasMestoItem>);
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

procedure TNasMestoColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNasMestoSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNasMestoSearch.Count]);

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

procedure TNasMestoColl.SortByIndexAnsiString;
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

procedure TNasMestoColl.SortByIndexInt;
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

procedure TNasMestoColl.SortByIndexWord;
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

procedure TNasMestoColl.SortByIndexValue(propIndex: TNasMestoItem.TPropertyIndex);
begin
  case propIndex of
    NasMesto_NasMestoName: SortByIndexAnsiString;
      NasMesto_ObshID: SortByIndexWord;
      NasMesto_OblID: SortByIndexWord;
      NasMesto_EKATTE: SortByIndexAnsiString;
      NasMesto_ZIP: SortByIndexAnsiString;
      NasMesto_RCZR: SortByIndexAnsiString;
  end;
end;

end.