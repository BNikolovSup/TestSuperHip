unit Table.Certificates;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults, Tee.Renders,
  uGridHelpers  ;

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

TLogicalCertificates = (
    Is_);
TlogicalCertificatesSet = set of TLogicalCertificates;


TCertificatesItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Certificates_CERT_ID
       , Certificates_SLOT_ID
       , Certificates_VALID_FROM_DATE
       , Certificates_VALID_TO_DATE
       , Certificates_SlotNom
       , Certificates_Pin
       , Certificates_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCertificates = ^TRecCertificates;
      TRecCertificates = record
        CERT_ID: AnsiString;
        SLOT_ID: AnsiString;
        VALID_FROM_DATE: TDate;
        VALID_TO_DATE: TDate;
        SlotNom: integer;
        Pin: AnsiString;
        Logical: TlogicalCertificatesSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCertificates;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCertificates;
    procedure UpdateCertificates;
    procedure SaveCertificates(var dataPosition: Cardinal)overload;
	procedure SaveCertificates(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCertificates(propindex: TPropertyIndex; stream: TStream);
  end;


  TCertificatesColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCertificatesItem;
    function GetItem(Index: Integer): TCertificatesItem;
    procedure SetItem(Index: Integer; const Value: TCertificatesItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCertificatesItem>;
    ListCertificatesSearch: TList<TCertificatesItem>;
	PRecordSearch: ^TCertificatesItem.TRecCertificates;
    ArrPropSearch: TArray<TCertificatesItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCertificatesItem.TPropertyIndex>;
	VisibleColl: TCertificatesItem.TSetProp;
	ArrayPropOrder: TArray<TCertificatesItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCertificatesItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Certificates: TCertificatesItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Certificates: TCertificatesItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCertificatesItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCertificatesItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCertificatesItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCertificatesItem.TPropertyIndex);
    property Items[Index: Integer]: TCertificatesItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCertificatesSet);
	procedure CheckForSave(var cnt: Integer); override;
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TCertificatesItem }

constructor TCertificatesItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCertificatesItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCertificatesItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCertificatesItem.GetCollType: TCollectionsType;
begin
  Result := ctCertificates;
end;

function TCertificatesItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TCertificatesItem.InsertCertificates;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCertificates;
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
            Certificates_CERT_ID: SaveData(PRecord.CERT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_SLOT_ID: SaveData(PRecord.SLOT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_FROM_DATE: SaveData(PRecord.VALID_FROM_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_TO_DATE: SaveData(PRecord.VALID_TO_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_SlotNom: SaveData(PRecord.SlotNom, PropPosition, metaPosition, dataPosition);
            Certificates_Pin: SaveData(PRecord.Pin, PropPosition, metaPosition, dataPosition);
            Certificates_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TCertificatesItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCertificatesItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCertificatesItem;
begin
  Result := True;
  for i := 0 to Length(TCertificatesColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCertificatesColl(coll).ArrPropSearchClc[i];
	ATempItem := TCertificatesColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Certificates_CERT_ID: Result := IsFinded(ATempItem.PRecord.CERT_ID, buf, FPosDataADB, word(Certificates_CERT_ID), cot);
            Certificates_SLOT_ID: Result := IsFinded(ATempItem.PRecord.SLOT_ID, buf, FPosDataADB, word(Certificates_SLOT_ID), cot);
            Certificates_VALID_FROM_DATE: Result := IsFinded(ATempItem.PRecord.VALID_FROM_DATE, buf, FPosDataADB, word(Certificates_VALID_FROM_DATE), cot);
            Certificates_VALID_TO_DATE: Result := IsFinded(ATempItem.PRecord.VALID_TO_DATE, buf, FPosDataADB, word(Certificates_VALID_TO_DATE), cot);
            Certificates_SlotNom: Result := IsFinded(ATempItem.PRecord.SlotNom, buf, FPosDataADB, word(Certificates_SlotNom), cot);
            Certificates_Pin: Result := IsFinded(ATempItem.PRecord.Pin, buf, FPosDataADB, word(Certificates_Pin), cot);
            Certificates_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Certificates_Logical), cot);
      end;
    end;
  end;
end;

procedure TCertificatesItem.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds08: TLogicalData08;
  propindexCertificates: TCertificatesItem.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData08);
  stream.Read(flds08, sizeof(TLogicalData08));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCertificatesItem.TSetProp(flds08);// тука се записва какво има като полета


  for propindexCertificates := Low(TCertificatesItem.TPropertyIndex) to High(TCertificatesItem.TPropertyIndex) do
  begin
    if not (propindexCertificates in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCertificates);
      dataCmdProp.vid := vvCertificates;
    end;
    self.FillPropCertificates(propindexCertificates, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCertificatesItem.FillPropCertificates(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    Certificates_CERT_ID:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.CERT_ID, lenStr);
          stream.Read(Self.PRecord.CERT_ID[1], lenStr);
        end;
            Certificates_SLOT_ID:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.SLOT_ID, lenStr);
              stream.Read(Self.PRecord.SLOT_ID[1], lenStr);
            end;
            Certificates_VALID_FROM_DATE: stream.Read(Self.PRecord.VALID_FROM_DATE, SizeOf(TDate));
            Certificates_VALID_TO_DATE: stream.Read(Self.PRecord.VALID_TO_DATE, SizeOf(TDate));
            Certificates_SlotNom: stream.Read(Self.PRecord.SlotNom, SizeOf(Integer));
            Certificates_Pin:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Pin, lenStr);
              stream.Read(Self.PRecord.Pin[1], lenStr);
            end;
            Certificates_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCertificatesItem.SaveCertificates(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCertificates(dataPosition);
end;

procedure TCertificatesItem.SaveCertificates(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := PCollectionsType(PByte(Buf) + DataPos - 4)^;
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
            Certificates_CERT_ID: SaveData(PRecord.CERT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_SLOT_ID: SaveData(PRecord.SLOT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_FROM_DATE: SaveData(PRecord.VALID_FROM_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_TO_DATE: SaveData(PRecord.VALID_TO_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_SlotNom: SaveData(PRecord.SlotNom, PropPosition, metaPosition, dataPosition);
            Certificates_Pin: SaveData(PRecord.Pin, PropPosition, metaPosition, dataPosition);
            Certificates_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TCertificatesItem.UpdateCertificates;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCertificates;
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
            Certificates_CERT_ID: UpdateData(PRecord.CERT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_SLOT_ID: UpdateData(PRecord.SLOT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_FROM_DATE: UpdateData(PRecord.VALID_FROM_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_TO_DATE: UpdateData(PRecord.VALID_TO_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_SlotNom: UpdateData(PRecord.SlotNom, PropPosition, metaPosition, dataPosition);
            Certificates_Pin: UpdateData(PRecord.Pin, PropPosition, metaPosition, dataPosition);
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

{ TCertificatesColl }

function TCertificatesColl.AddItem(ver: word): TCertificatesItem;
begin
  Result := TCertificatesItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCertificatesColl.AddItemForSearch: Integer;
var
  ItemForSearch: TCertificatesItem;
begin
  ItemForSearch := TCertificatesItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCertificatesColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCertificatesItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCertificatesColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCertificatesRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCertificatesColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCertificatesItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (Certificates_CERT_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.CERT_ID <> Self.getAnsiStringMap(tempItem.DataPos, word(Certificates_CERT_ID))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Certificates_SLOT_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.SLOT_ID <> Self.getAnsiStringMap(tempItem.DataPos, word(Certificates_SLOT_ID))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Certificates_VALID_FROM_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.VALID_FROM_DATE <> Self.getDateMap(tempItem.DataPos, word(Certificates_VALID_FROM_DATE))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Certificates_VALID_TO_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.VALID_TO_DATE <> Self.getDateMap(tempItem.DataPos, word(Certificates_VALID_TO_DATE))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Certificates_SlotNom in tempItem.PRecord.setProp) and (tempItem.PRecord.SlotNom <> Self.getIntMap(tempItem.DataPos, word(Certificates_SlotNom))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Certificates_Pin in tempItem.PRecord.setProp) and (tempItem.PRecord.Pin <> Self.getAnsiStringMap(tempItem.DataPos, word(Certificates_Pin))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Certificates_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(Certificates_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCertificatesColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCertificatesItem.Create(nil);
  ListCertificatesSearch := TList<TCertificatesItem>.Create;
  ListForFinder := TList<TCertificatesItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCertificatesColl.destroy;
begin
  FreeAndNil(ListCertificatesSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCertificatesColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: Result := 'CERT_ID';
    Certificates_SLOT_ID: Result := 'SLOT_ID';
    Certificates_VALID_FROM_DATE: Result := 'VALID_FROM_DATE';
    Certificates_VALID_TO_DATE: Result := 'VALID_TO_DATE';
    Certificates_SlotNom: Result := 'SlotNom';
    Certificates_Pin: Result := 'Pin';
    Certificates_Logical: Result := 'Logical';
  end;
end;

function TCertificatesColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCertificatesColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCertificatesColl.FieldCount: Integer; 
begin
  inherited;
  Result := 7;
end;

function TCertificatesColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCertificatesRoot then
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

function TCertificatesColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCertificatesColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCertificatesColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TCertificatesColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Certificates: TCertificatesItem;
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Certificates := Items[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(Certificates.PRecord) and (prop in Certificates.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Certificates, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Certificates, AValue);
  end;
end;

procedure TCertificatesColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TCertificatesItem.TPropertyIndex;
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

procedure TCertificatesColl.GetCellFromRecord(propIndex: word; Certificates: TCertificatesItem; var AValue: String);
var
  str: string;
begin
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: str := (Certificates.PRecord.CERT_ID);
    Certificates_SLOT_ID: str := (Certificates.PRecord.SLOT_ID);
    Certificates_VALID_FROM_DATE: str := AspDateToStr(Certificates.PRecord.VALID_FROM_DATE);
    Certificates_VALID_TO_DATE: str := AspDateToStr(Certificates.PRecord.VALID_TO_DATE);
    Certificates_SlotNom: str := inttostr(Certificates.PRecord.SlotNom);
    Certificates_Pin: str := (Certificates.PRecord.Pin);
    Certificates_Logical: str := Certificates.Logical08ToStr(TLogicalData08(Certificates.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCertificatesColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCertificatesItem;
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCertificatesColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCertificatesItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCertificatesColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Certificates: TCertificatesItem;
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Certificates := ListCertificatesSearch[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(Certificates.PRecord) and (prop in Certificates.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Certificates, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Certificates, AValue);
  end;
end;

function TCertificatesColl.GetCollType: TCollectionsType;
begin
  Result := ctCertificates;
end;

function TCertificatesColl.GetCollDelType: TCollectionsType;
begin
  Result := ctCertificatesDel;
end;

procedure TCertificatesColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Certificates: TCertificatesItem;
  prop: TCertificatesItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Certificates := Items[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(Certificates.PRecord) and (prop in Certificates.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Certificates, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Certificates, AFieldText);
  end;
end;

procedure TCertificatesColl.GetCellFromMap(propIndex: word; ARow: Integer; Certificates: TCertificatesItem; var AValue: String);
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
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: str :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Certificates_SLOT_ID: str :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Certificates_VALID_FROM_DATE: str :=  AspDateToStr(Certificates.getDateMap(Self.Buf, Self.posData, propIndex));
    Certificates_VALID_TO_DATE: str :=  AspDateToStr(Certificates.getDateMap(Self.Buf, Self.posData, propIndex));
    Certificates_SlotNom: str :=  inttostr(Certificates.getIntMap(Self.Buf, Self.posData, propIndex));
    Certificates_Pin: str :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Certificates_Logical: str :=  Certificates.Logical08ToStr(Certificates.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCertificatesColl.GetItem(Index: Integer): TCertificatesItem;
begin
  Result := TCertificatesItem(inherited GetItem(Index));
end;


procedure TCertificatesColl.IndexValue(propIndex: TCertificatesItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCertificatesItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Certificates_CERT_ID:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Certificates_SLOT_ID:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Certificates_SlotNom: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Certificates_Pin:
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

procedure TCertificatesColl.IndexValueListNodes(propIndex: TCertificatesItem.TPropertyIndex);
begin

end;

function TCertificatesColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCertificatesItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TCertificatesColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCertificatesItem;
begin
  if index < 0 then
  begin
    Tempitem := TCertificatesItem.Create(nil);
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
procedure TCertificatesColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCertificatesItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCertificatesItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCertificatesItem.TPropertyIndex(Field) of
Certificates_CERT_ID: ListForFinder[0].PRecord.CERT_ID := AText;
    Certificates_SLOT_ID: ListForFinder[0].PRecord.SLOT_ID := AText;
    Certificates_Pin: ListForFinder[0].PRecord.Pin := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCertificatesColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCertificatesItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  case TCertificatesItem.TPropertyIndex(Field) of
    Certificates_VALID_FROM_DATE: ListForFinder[0].PRecord.VALID_FROM_DATE := Value;
    Certificates_VALID_TO_DATE: ListForFinder[0].PRecord.VALID_TO_DATE := Value;
    end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCertificatesColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCertificatesItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
case TCertificatesItem.TPropertyIndex(Field) of
    Certificates_SlotNom: ListForFinder[0].PRecord.SlotNom := Value;
    end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCertificatesColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCertificatesItem.TPropertyIndex(Field) of
    Certificates_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCertificates(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCertificates(logIndex))   
    end;
  end;
end;


procedure TCertificatesColl.OnSetTextSearchLog(Log: TlogicalCertificatesSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCertificatesColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCertificatesColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: Result := actAnsiString;
    Certificates_SLOT_ID: Result := actAnsiString;
    Certificates_VALID_FROM_DATE: Result := actTDate;
    Certificates_VALID_TO_DATE: Result := actTDate;
    Certificates_SlotNom: Result := actinteger;
    Certificates_Pin: Result := actAnsiString;
    Certificates_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCertificatesColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCertificatesColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Certificates: TCertificatesItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Certificates := Items[ARow];
  if not Assigned(Certificates.PRecord) then
  begin
    New(Certificates.PRecord);
    Certificates.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCertificatesItem.TPropertyIndex(ACol) of
      Certificates_CERT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Certificates_SLOT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Certificates_VALID_FROM_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Certificates_VALID_TO_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Certificates_SlotNom: isOld :=  Certificates.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Certificates_Pin: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
    if Certificates.PRecord.setProp = [] then
    begin
      Dispose(Certificates.PRecord);
      Certificates.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
  case TCertificatesItem.TPropertyIndex(ACol) of
    Certificates_CERT_ID: Certificates.PRecord.CERT_ID := AValue;
    Certificates_SLOT_ID: Certificates.PRecord.SLOT_ID := AValue;
    Certificates_VALID_FROM_DATE: Certificates.PRecord.VALID_FROM_DATE := StrToDate(AValue);
    Certificates_VALID_TO_DATE: Certificates.PRecord.VALID_TO_DATE := StrToDate(AValue);
    Certificates_SlotNom: Certificates.PRecord.SlotNom := StrToInt(AValue);
    Certificates_Pin: Certificates.PRecord.Pin := AValue;
    Certificates_Logical: Certificates.PRecord.Logical := tlogicalCertificatesSet(Certificates.StrToLogical08(AValue));
  end;
end;

procedure TCertificatesColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Certificates: TCertificatesItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Certificates := Items[ARow];
  if not Assigned(Certificates.PRecord) then
  begin
    New(Certificates.PRecord);
    Certificates.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCertificatesItem.TPropertyIndex(ACol) of
      Certificates_CERT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Certificates_SLOT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Certificates_VALID_FROM_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Certificates_VALID_TO_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Certificates_SlotNom: isOld :=  Certificates.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Certificates_Pin: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
    if Certificates.PRecord.setProp = [] then
    begin
      Dispose(Certificates.PRecord);
      Certificates.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
  case TCertificatesItem.TPropertyIndex(ACol) of
    Certificates_CERT_ID: Certificates.PRecord.CERT_ID := AFieldText;
    Certificates_SLOT_ID: Certificates.PRecord.SLOT_ID := AFieldText;
    Certificates_VALID_FROM_DATE: Certificates.PRecord.VALID_FROM_DATE := StrToDate(AFieldText);
    Certificates_VALID_TO_DATE: Certificates.PRecord.VALID_TO_DATE := StrToDate(AFieldText);
    Certificates_SlotNom: Certificates.PRecord.SlotNom := StrToInt(AFieldText);
    Certificates_Pin: Certificates.PRecord.Pin := AFieldText;
    Certificates_Logical: Certificates.PRecord.Logical := tlogicalCertificatesSet(Certificates.StrToLogical08(AFieldText));
  end;
end;

procedure TCertificatesColl.SetItem(Index: Integer; const Value: TCertificatesItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TCertificatesColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCertificatesSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCertificatesItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Certificates_CERT_ID:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCertificatesSearch.Add(self.Items[i]);
  end;
end;
      Certificates_SLOT_ID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCertificatesSearch.Add(self.Items[i]);
        end;
      end;
      Certificates_SlotNom: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListCertificatesSearch.Add(self.Items[i]);
        end;
      end;
      Certificates_Pin:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCertificatesSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCertificatesColl.ShowGrid(Grid: TTeeGrid);
var
  i: word;
  clls: TDiffCellRenderer;
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
  
  clls := TDiffCellRenderer.Create(Grid.Cells.OnChange);
  clls.FGrid := Grid;
  clls.FCollAdb := Self;
  Grid.Cells := clls;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCertificatesColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCertificatesItem>);
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

procedure TCertificatesColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCertificatesSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCertificatesSearch.Count]);

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

procedure TCertificatesColl.SortByIndexAnsiString;
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

procedure TCertificatesColl.SortByIndexInt;
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

procedure TCertificatesColl.SortByIndexWord;
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

procedure TCertificatesColl.SortByIndexValue(propIndex: TCertificatesItem.TPropertyIndex);
begin
  case propIndex of
    Certificates_CERT_ID: SortByIndexAnsiString;
      Certificates_SLOT_ID: SortByIndexAnsiString;
      Certificates_SlotNom: SortByIndexInt;
      Certificates_Pin: SortByIndexAnsiString;
  end;
end;


end.