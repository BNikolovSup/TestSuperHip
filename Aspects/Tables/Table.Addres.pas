unit Table.Addres;

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

TLogicalAddres = (
    IS_permanent,
    IS_current,
    IS_temporary,
    USE_JK,
    USE_ULICA,
    USE_NOMER,
    USE_BL,
    USE_VH,
    USE_ET,
    USE_AP,
    USE_DTEL,
    USE_EMAIL,
    USE_PKUT);
TlogicalAddresSet = set of TLogicalAddres;


TAddresItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Addres_AP
       , Addres_BL
       , Addres_DTEL
       , Addres_EMAIL
       , Addres_ET
       , Addres_JK
       , Addres_NOMER
       , Addres_PKUT
       , Addres_ULICA
       , Addres_VH
       , Addres_LinkPos
       , Addres_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecAddres = ^TRecAddres;
      TRecAddres = record
        AP: AnsiString;
        BL: AnsiString;
        DTEL: AnsiString;
        EMAIL: AnsiString;
        ET: AnsiString;
        JK: AnsiString;
        NOMER: AnsiString;
        PKUT: AnsiString;
        ULICA: AnsiString;
        VH: AnsiString;
        LinkPos: integer;
        Logical: TlogicalAddresSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecAddres;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertAddres;
    procedure UpdateAddres;
    procedure SaveAddres(var dataPosition: Cardinal)overload;
	procedure SaveAddres(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TAddresColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TAddresItem;
    function GetItem(Index: Integer): TAddresItem;
    procedure SetItem(Index: Integer; const Value: TAddresItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TAddresItem>;
    ListAddresSearch: TList<TAddresItem>;
	PRecordSearch: ^TAddresItem.TRecAddres;
    ArrPropSearch: TArray<TAddresItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TAddresItem.TPropertyIndex>;
	ArrayPropOrder: TArray<TAddresItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TAddresItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Addres: TAddresItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Addres: TAddresItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TAddresItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TAddresItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TAddresItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TAddresItem.TPropertyIndex);
    property Items[Index: Integer]: TAddresItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchLog(Log: TlogicalAddresSet);
  end;

implementation

{ TAddresItem }

constructor TAddresItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TAddresItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TAddresItem.InsertAddres;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctAddres;
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
            Addres_AP: SaveData(PRecord.AP, PropPosition, metaPosition, dataPosition);
            Addres_BL: SaveData(PRecord.BL, PropPosition, metaPosition, dataPosition);
            Addres_DTEL: SaveData(PRecord.DTEL, PropPosition, metaPosition, dataPosition);
            Addres_EMAIL: SaveData(PRecord.EMAIL, PropPosition, metaPosition, dataPosition);
            Addres_ET: SaveData(PRecord.ET, PropPosition, metaPosition, dataPosition);
            Addres_JK: SaveData(PRecord.JK, PropPosition, metaPosition, dataPosition);
            Addres_NOMER: SaveData(PRecord.NOMER, PropPosition, metaPosition, dataPosition);
            Addres_PKUT: SaveData(PRecord.PKUT, PropPosition, metaPosition, dataPosition);
            Addres_ULICA: SaveData(PRecord.ULICA, PropPosition, metaPosition, dataPosition);
            Addres_VH: SaveData(PRecord.VH, PropPosition, metaPosition, dataPosition);
            Addres_LinkPos: SaveData(PRecord.LinkPos, PropPosition, metaPosition, dataPosition);
            Addres_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TAddresItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TAddresItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TAddresItem;
begin
  Result := True;
  for i := 0 to Length(TAddresColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TAddresColl(coll).ArrPropSearchClc[i];
	ATempItem := TAddresColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Addres_AP: Result := IsFinded(ATempItem.PRecord.AP, buf, FPosDataADB, word(Addres_AP), cot);
            Addres_BL: Result := IsFinded(ATempItem.PRecord.BL, buf, FPosDataADB, word(Addres_BL), cot);
            Addres_DTEL: Result := IsFinded(ATempItem.PRecord.DTEL, buf, FPosDataADB, word(Addres_DTEL), cot);
            Addres_EMAIL: Result := IsFinded(ATempItem.PRecord.EMAIL, buf, FPosDataADB, word(Addres_EMAIL), cot);
            Addres_ET: Result := IsFinded(ATempItem.PRecord.ET, buf, FPosDataADB, word(Addres_ET), cot);
            Addres_JK: Result := IsFinded(ATempItem.PRecord.JK, buf, FPosDataADB, word(Addres_JK), cot);
            Addres_NOMER: Result := IsFinded(ATempItem.PRecord.NOMER, buf, FPosDataADB, word(Addres_NOMER), cot);
            Addres_PKUT: Result := IsFinded(ATempItem.PRecord.PKUT, buf, FPosDataADB, word(Addres_PKUT), cot);
            Addres_ULICA: Result := IsFinded(ATempItem.PRecord.ULICA, buf, FPosDataADB, word(Addres_ULICA), cot);
            Addres_VH: Result := IsFinded(ATempItem.PRecord.VH, buf, FPosDataADB, word(Addres_VH), cot);
            Addres_LinkPos: Result := IsFinded(ATempItem.PRecord.LinkPos, buf, FPosDataADB, word(Addres_LinkPos), cot);
            Addres_Logical: Result := IsFinded(TLogicalData16(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Addres_Logical), cot);
      end;
    end;
  end;
end;

procedure TAddresItem.SaveAddres(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveAddres(dataPosition);
end;

procedure TAddresItem.SaveAddres(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAddres;
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
            Addres_AP: SaveData(PRecord.AP, PropPosition, metaPosition, dataPosition);
            Addres_BL: SaveData(PRecord.BL, PropPosition, metaPosition, dataPosition);
            Addres_DTEL: SaveData(PRecord.DTEL, PropPosition, metaPosition, dataPosition);
            Addres_EMAIL: SaveData(PRecord.EMAIL, PropPosition, metaPosition, dataPosition);
            Addres_ET: SaveData(PRecord.ET, PropPosition, metaPosition, dataPosition);
            Addres_JK: SaveData(PRecord.JK, PropPosition, metaPosition, dataPosition);
            Addres_NOMER: SaveData(PRecord.NOMER, PropPosition, metaPosition, dataPosition);
            Addres_PKUT: SaveData(PRecord.PKUT, PropPosition, metaPosition, dataPosition);
            Addres_ULICA: SaveData(PRecord.ULICA, PropPosition, metaPosition, dataPosition);
            Addres_VH: SaveData(PRecord.VH, PropPosition, metaPosition, dataPosition);
            Addres_LinkPos: SaveData(PRecord.LinkPos, PropPosition, metaPosition, dataPosition);
            Addres_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TAddresItem.UpdateAddres;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAddres;
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
            Addres_AP: UpdateData(PRecord.AP, PropPosition, metaPosition, dataPosition);
            Addres_BL: UpdateData(PRecord.BL, PropPosition, metaPosition, dataPosition);
            Addres_DTEL: UpdateData(PRecord.DTEL, PropPosition, metaPosition, dataPosition);
            Addres_EMAIL: UpdateData(PRecord.EMAIL, PropPosition, metaPosition, dataPosition);
            Addres_ET: UpdateData(PRecord.ET, PropPosition, metaPosition, dataPosition);
            Addres_JK: UpdateData(PRecord.JK, PropPosition, metaPosition, dataPosition);
            Addres_NOMER: UpdateData(PRecord.NOMER, PropPosition, metaPosition, dataPosition);
            Addres_PKUT: UpdateData(PRecord.PKUT, PropPosition, metaPosition, dataPosition);
            Addres_ULICA: UpdateData(PRecord.ULICA, PropPosition, metaPosition, dataPosition);
            Addres_VH: UpdateData(PRecord.VH, PropPosition, metaPosition, dataPosition);
            Addres_LinkPos: UpdateData(PRecord.LinkPos, PropPosition, metaPosition, dataPosition);
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

{ TAddresColl }

function TAddresColl.AddItem(ver: word): TAddresItem;
begin
  Result := TAddresItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TAddresColl.AddItemForSearch: Integer;
var
  ItemForSearch: TAddresItem;
begin
  ItemForSearch := TAddresItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

function TAddresColl.CreateRootCollOptionNode(): PVirtualNode;
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

constructor TAddresColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TAddresItem.Create(nil);
  ListAddresSearch := TList<TAddresItem>.Create;
  ListForFinder := TList<TAddresItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrder, FieldCount);
  SetLength(ArrayPropOrderSearchOptions, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrayPropOrder[i] := TAddresItem.TPropertyIndex(i);
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TAddresColl.destroy;
begin
  FreeAndNil(ListAddresSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TAddresColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TAddresItem.TPropertyIndex(propIndex) of
    Addres_AP: Result := 'AP';
    Addres_BL: Result := 'BL';
    Addres_DTEL: Result := 'DTEL';
    Addres_EMAIL: Result := 'EMAIL';
    Addres_ET: Result := 'ET';
    Addres_JK: Result := 'JK';
    Addres_NOMER: Result := 'NOMER';
    Addres_PKUT: Result := 'PKUT';
    Addres_ULICA: Result := 'ULICA';
    Addres_VH: Result := 'VH';
    Addres_LinkPos: Result := 'LinkPos';
    Addres_Logical: Result := 'Logical';
  end;
end;

procedure TAddresColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TAddresColl.FieldCount: Integer; 
begin
  inherited;
  Result := 12;
end;

function TAddresColl.FindRootCollOptionNode(): PVirtualNode;
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

function TAddresColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TAddresColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TAddresColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TAddresColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Addres: TAddresItem;
  ACol: Integer;
  prop: TAddresItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Addres := Items[ARow];
  prop := TAddresItem.TPropertyIndex(ACol);
  if Assigned(Addres.PRecord) and (prop in Addres.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Addres, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Addres, AValue);
  end;
end;

procedure TAddresColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol, RowSelect: Integer;
  prop: TAddresItem.TPropertyIndex;
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

procedure TAddresColl.GetCellFromRecord(propIndex: word; Addres: TAddresItem; var AValue: String);
var
  str: string;
begin
  case TAddresItem.TPropertyIndex(propIndex) of
    Addres_AP: str := (Addres.PRecord.AP);
    Addres_BL: str := (Addres.PRecord.BL);
    Addres_DTEL: str := (Addres.PRecord.DTEL);
    Addres_EMAIL: str := (Addres.PRecord.EMAIL);
    Addres_ET: str := (Addres.PRecord.ET);
    Addres_JK: str := (Addres.PRecord.JK);
    Addres_NOMER: str := (Addres.PRecord.NOMER);
    Addres_PKUT: str := (Addres.PRecord.PKUT);
    Addres_ULICA: str := (Addres.PRecord.ULICA);
    Addres_VH: str := (Addres.PRecord.VH);
    Addres_LinkPos: str := inttostr(Addres.PRecord.LinkPos);
    Addres_Logical: str := Addres.Logical16ToStr(TLogicalData16(Addres.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TAddresColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TAddresItem;
  ACol: Integer;
  prop: TAddresItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TAddresItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TAddresColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TAddresItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TAddresItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TAddresColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Addres: TAddresItem;
  ACol: Integer;
  prop: TAddresItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Addres := ListAddresSearch[ARow];
  prop := TAddresItem.TPropertyIndex(ACol);
  if Assigned(Addres.PRecord) and (prop in Addres.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Addres, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Addres, AValue);
  end;
end;

procedure TAddresColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Addres: TAddresItem;
  prop: TAddresItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Addres := Items[ARow];
  prop := TAddresItem.TPropertyIndex(ACol);
  if Assigned(Addres.PRecord) and (prop in Addres.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Addres, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Addres, AFieldText);
  end;
end;

procedure TAddresColl.GetCellFromMap(propIndex: word; ARow: Integer; Addres: TAddresItem; var AValue: String);
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
  case TAddresItem.TPropertyIndex(propIndex) of
    Addres_AP: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_BL: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_DTEL: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_EMAIL: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_ET: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_JK: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_NOMER: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_PKUT: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_ULICA: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_VH: str :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Addres_LinkPos: str :=  inttostr(Addres.getIntMap(Self.Buf, Self.posData, propIndex));
    Addres_Logical: str :=  Addres.Logical16ToStr(Addres.getLogical16Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TAddresColl.GetItem(Index: Integer): TAddresItem;
begin
  Result := TAddresItem(inherited GetItem(Index));
end;


procedure TAddresColl.IndexValue(propIndex: TAddresItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TAddresItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Addres_AP:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Addres_BL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_DTEL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_EMAIL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_ET:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_JK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_NOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_PKUT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_ULICA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_VH:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Addres_LinkPos: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TAddresColl.IndexValueListNodes(propIndex: TAddresItem.TPropertyIndex);
begin

end;

procedure TAddresColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TAddresItem;
begin
  if index < 0 then
  begin
    Tempitem := TAddresItem.Create(nil);
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

procedure TAddresColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TAddresItem.TPropertyIndex(Field));
  end
  else
  begin
    include(ListForFinder[0].PRecord.setProp, TAddresItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  if cotSens in Condition then
  begin
    //case TAddresItem.TPropertyIndex(Field) of
    //  Addres_EGN: ListForFinder[0].PRecord.EGN  := Text;
    //  
    //end;
  end
  else
  begin
    //case TAddresItem.TPropertyIndex(Field) of
    //  Addres_EGN: ListForFinder[0].PRecord.EGN  := AnsiUpperCase(Text);
    //end;
  end;
end;

procedure TAddresColl.OnSetTextSearchLog(Log: TlogicalAddresSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TAddresColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TAddresColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TAddresItem.TPropertyIndex(propIndex) of
    Addres_AP: Result := actAnsiString;
    Addres_BL: Result := actAnsiString;
    Addres_DTEL: Result := actAnsiString;
    Addres_EMAIL: Result := actAnsiString;
    Addres_ET: Result := actAnsiString;
    Addres_JK: Result := actAnsiString;
    Addres_NOMER: Result := actAnsiString;
    Addres_PKUT: Result := actAnsiString;
    Addres_ULICA: Result := actAnsiString;
    Addres_VH: Result := actAnsiString;
    Addres_LinkPos: Result := actinteger;
    Addres_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TAddresColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TAddresColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Addres: TAddresItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Addres := Items[ARow];
  if not Assigned(Addres.PRecord) then
  begin
    New(Addres.PRecord);
    Addres.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TAddresItem.TPropertyIndex(ACol) of
      Addres_AP: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_BL: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_DTEL: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_EMAIL: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_ET: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_JK: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_NOMER: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_PKUT: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_ULICA: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_VH: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Addres_LinkPos: isOld :=  Addres.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Addres.PRecord.setProp, TAddresItem.TPropertyIndex(ACol));
    if Addres.PRecord.setProp = [] then
    begin
      Dispose(Addres.PRecord);
      Addres.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Addres.PRecord.setProp, TAddresItem.TPropertyIndex(ACol));
  case TAddresItem.TPropertyIndex(ACol) of
    Addres_AP: Addres.PRecord.AP := AValue;
    Addres_BL: Addres.PRecord.BL := AValue;
    Addres_DTEL: Addres.PRecord.DTEL := AValue;
    Addres_EMAIL: Addres.PRecord.EMAIL := AValue;
    Addres_ET: Addres.PRecord.ET := AValue;
    Addres_JK: Addres.PRecord.JK := AValue;
    Addres_NOMER: Addres.PRecord.NOMER := AValue;
    Addres_PKUT: Addres.PRecord.PKUT := AValue;
    Addres_ULICA: Addres.PRecord.ULICA := AValue;
    Addres_VH: Addres.PRecord.VH := AValue;
    Addres_LinkPos: Addres.PRecord.LinkPos := StrToInt(AValue);
    Addres_Logical: Addres.PRecord.Logical := tlogicalAddresSet(Addres.StrToLogical16(AValue));
  end;
end;

procedure TAddresColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Addres: TAddresItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Addres := Items[ARow];
  if not Assigned(Addres.PRecord) then
  begin
    New(Addres.PRecord);
    Addres.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TAddresItem.TPropertyIndex(ACol) of
      Addres_AP: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_BL: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_DTEL: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_EMAIL: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_ET: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_JK: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_NOMER: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_PKUT: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_ULICA: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_VH: isOld :=  Addres.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Addres_LinkPos: isOld :=  Addres.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Addres.PRecord.setProp, TAddresItem.TPropertyIndex(ACol));
    if Addres.PRecord.setProp = [] then
    begin
      Dispose(Addres.PRecord);
      Addres.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Addres.PRecord.setProp, TAddresItem.TPropertyIndex(ACol));
  case TAddresItem.TPropertyIndex(ACol) of
    Addres_AP: Addres.PRecord.AP := AFieldText;
    Addres_BL: Addres.PRecord.BL := AFieldText;
    Addres_DTEL: Addres.PRecord.DTEL := AFieldText;
    Addres_EMAIL: Addres.PRecord.EMAIL := AFieldText;
    Addres_ET: Addres.PRecord.ET := AFieldText;
    Addres_JK: Addres.PRecord.JK := AFieldText;
    Addres_NOMER: Addres.PRecord.NOMER := AFieldText;
    Addres_PKUT: Addres.PRecord.PKUT := AFieldText;
    Addres_ULICA: Addres.PRecord.ULICA := AFieldText;
    Addres_VH: Addres.PRecord.VH := AFieldText;
    Addres_LinkPos: Addres.PRecord.LinkPos := StrToInt(AFieldText);
    Addres_Logical: Addres.PRecord.Logical := tlogicalAddresSet(Addres.StrToLogical16(AFieldText));
  end;
end;

procedure TAddresColl.SetItem(Index: Integer; const Value: TAddresItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TAddresColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListAddresSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TAddresItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Addres_AP:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListAddresSearch.Add(self.Items[i]);
  end;
end;
      Addres_BL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_DTEL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_EMAIL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_ET:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_JK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_NOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_PKUT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_ULICA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_VH:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
      Addres_LinkPos: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListAddresSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TAddresColl.ShowGrid(Grid: TTeeGrid);
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

procedure TAddresColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TAddresItem>);
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

procedure TAddresColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListAddresSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListAddresSearch.Count]);

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

procedure TAddresColl.SortByIndexAnsiString;
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

procedure TAddresColl.SortByIndexInt;
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

procedure TAddresColl.SortByIndexWord;
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

procedure TAddresColl.SortByIndexValue(propIndex: TAddresItem.TPropertyIndex);
begin
  case propIndex of
    Addres_AP: SortByIndexAnsiString;
      Addres_BL: SortByIndexAnsiString;
      Addres_DTEL: SortByIndexAnsiString;
      Addres_EMAIL: SortByIndexAnsiString;
      Addres_ET: SortByIndexAnsiString;
      Addres_JK: SortByIndexAnsiString;
      Addres_NOMER: SortByIndexAnsiString;
      Addres_PKUT: SortByIndexAnsiString;
      Addres_ULICA: SortByIndexAnsiString;
      Addres_VH: SortByIndexAnsiString;
      Addres_LinkPos: SortByIndexInt;
  end;
end;

end.