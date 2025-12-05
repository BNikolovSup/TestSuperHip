unit Table.PR001;

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

TLogicalPR001 = (
    Is_);
TlogicalPR001Set = set of TLogicalPR001;


TPR001Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       PR001_CL132
       , PR001_Nomenclature
       , PR001_Activity_ID
       , PR001_Description
       , PR001_Notes
       , PR001_Rules
       , PR001_Specialty_CL006
       , PR001_Valid_Until
       , PR001_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecPR001 = ^TRecPR001;
      TRecPR001 = record
        CL132: AnsiString;
        Nomenclature: AnsiString;
        Activity_ID: AnsiString;
        Description: AnsiString;
        Notes: AnsiString;
        Rules: AnsiString;
        Specialty_CL006: AnsiString;
        Valid_Until: AnsiString;
        Logical: TlogicalPR001Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPR001;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPR001;
    procedure UpdatePR001;
    procedure SavePR001(var dataPosition: Cardinal)overload;
	procedure SavePR001(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropPR001(propindex: TPropertyIndex; stream: TStream);
  end;


  TPR001Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TPR001Item;
    function GetItem(Index: Integer): TPR001Item;
    procedure SetItem(Index: Integer; const Value: TPR001Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TPR001Item>;
    ListPR001Search: TList<TPR001Item>;
	PRecordSearch: ^TPR001Item.TRecPR001;
    ArrPropSearch: TArray<TPR001Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TPR001Item.TPropertyIndex>;
	VisibleColl: TPR001Item.TSetProp;
	ArrayPropOrder: TArray<TPR001Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPR001Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; PR001: TPR001Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PR001: TPR001Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TPR001Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TPR001Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPR001Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TPR001Item.TPropertyIndex);
    property Items[Index: Integer]: TPR001Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalPR001Set);
	procedure CheckForSave(var cnt: Integer); override;
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TPR001Item }

constructor TPR001Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPR001Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPR001Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TPR001Item.GetCollType: TCollectionsType;
begin
  Result := ctPR001;
end;

function TPR001Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TPR001Item.InsertPR001;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPR001;
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
            PR001_CL132: SaveData(PRecord.CL132, PropPosition, metaPosition, dataPosition);
            PR001_Nomenclature: SaveData(PRecord.Nomenclature, PropPosition, metaPosition, dataPosition);
            PR001_Activity_ID: SaveData(PRecord.Activity_ID, PropPosition, metaPosition, dataPosition);
            PR001_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            PR001_Notes: SaveData(PRecord.Notes, PropPosition, metaPosition, dataPosition);
            PR001_Rules: SaveData(PRecord.Rules, PropPosition, metaPosition, dataPosition);
            PR001_Specialty_CL006: SaveData(PRecord.Specialty_CL006, PropPosition, metaPosition, dataPosition);
            PR001_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
            PR001_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TPR001Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TPR001Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TPR001Item;
begin
  Result := True;
  for i := 0 to Length(TPR001Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TPR001Coll(coll).ArrPropSearchClc[i];
	ATempItem := TPR001Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        PR001_CL132: Result := IsFinded(ATempItem.PRecord.CL132, buf, FPosDataADB, word(PR001_CL132), cot);
            PR001_Nomenclature: Result := IsFinded(ATempItem.PRecord.Nomenclature, buf, FPosDataADB, word(PR001_Nomenclature), cot);
            PR001_Activity_ID: Result := IsFinded(ATempItem.PRecord.Activity_ID, buf, FPosDataADB, word(PR001_Activity_ID), cot);
            PR001_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(PR001_Description), cot);
            PR001_Notes: Result := IsFinded(ATempItem.PRecord.Notes, buf, FPosDataADB, word(PR001_Notes), cot);
            PR001_Rules: Result := IsFinded(ATempItem.PRecord.Rules, buf, FPosDataADB, word(PR001_Rules), cot);
            PR001_Specialty_CL006: Result := IsFinded(ATempItem.PRecord.Specialty_CL006, buf, FPosDataADB, word(PR001_Specialty_CL006), cot);
            PR001_Valid_Until: Result := IsFinded(ATempItem.PRecord.Valid_Until, buf, FPosDataADB, word(PR001_Valid_Until), cot);
            PR001_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(PR001_Logical), cot);
      end;
    end;
  end;
end;

procedure TPR001Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexPR001: TPR001Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TPR001Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexPR001 := Low(TPR001Item.TPropertyIndex) to High(TPR001Item.TPropertyIndex) do
  begin
    if not (propindexPR001 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexPR001);
      dataCmdProp.vid := vvPR001;
    end;
    self.FillPropPR001(propindexPR001, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TPR001Item.FillPropPR001(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    PR001_CL132:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.CL132, lenStr);
          stream.Read(Self.PRecord.CL132[1], lenStr);
        end;
            PR001_Nomenclature:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Nomenclature, lenStr);
              stream.Read(Self.PRecord.Nomenclature[1], lenStr);
            end;
            PR001_Activity_ID:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Activity_ID, lenStr);
              stream.Read(Self.PRecord.Activity_ID[1], lenStr);
            end;
            PR001_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            PR001_Notes:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Notes, lenStr);
              stream.Read(Self.PRecord.Notes[1], lenStr);
            end;
            PR001_Rules:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Rules, lenStr);
              stream.Read(Self.PRecord.Rules[1], lenStr);
            end;
            PR001_Specialty_CL006:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Specialty_CL006, lenStr);
              stream.Read(Self.PRecord.Specialty_CL006[1], lenStr);
            end;
            PR001_Valid_Until:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Valid_Until, lenStr);
              stream.Read(Self.PRecord.Valid_Until[1], lenStr);
            end;
            PR001_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TPR001Item.SavePR001(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SavePR001(dataPosition);
end;

procedure TPR001Item.SavePR001(var dataPosition: Cardinal);
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
            PR001_CL132: SaveData(PRecord.CL132, PropPosition, metaPosition, dataPosition);
            PR001_Nomenclature: SaveData(PRecord.Nomenclature, PropPosition, metaPosition, dataPosition);
            PR001_Activity_ID: SaveData(PRecord.Activity_ID, PropPosition, metaPosition, dataPosition);
            PR001_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            PR001_Notes: SaveData(PRecord.Notes, PropPosition, metaPosition, dataPosition);
            PR001_Rules: SaveData(PRecord.Rules, PropPosition, metaPosition, dataPosition);
            PR001_Specialty_CL006: SaveData(PRecord.Specialty_CL006, PropPosition, metaPosition, dataPosition);
            PR001_Valid_Until: SaveData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
            PR001_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TPR001Item.UpdatePR001;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPR001;
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
            PR001_CL132: UpdateData(PRecord.CL132, PropPosition, metaPosition, dataPosition);
            PR001_Nomenclature: UpdateData(PRecord.Nomenclature, PropPosition, metaPosition, dataPosition);
            PR001_Activity_ID: UpdateData(PRecord.Activity_ID, PropPosition, metaPosition, dataPosition);
            PR001_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            PR001_Notes: UpdateData(PRecord.Notes, PropPosition, metaPosition, dataPosition);
            PR001_Rules: UpdateData(PRecord.Rules, PropPosition, metaPosition, dataPosition);
            PR001_Specialty_CL006: UpdateData(PRecord.Specialty_CL006, PropPosition, metaPosition, dataPosition);
            PR001_Valid_Until: UpdateData(PRecord.Valid_Until, PropPosition, metaPosition, dataPosition);
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

{ TPR001Coll }

function TPR001Coll.AddItem(ver: word): TPR001Item;
begin
  Result := TPR001Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TPR001Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TPR001Item;
begin
  ItemForSearch := TPR001Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TPR001Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TPR001Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TPR001Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvPR001Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TPR001Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TPR001Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (PR001_CL132 in tempItem.PRecord.setProp) and (tempItem.PRecord.CL132 <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_CL132))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Nomenclature in tempItem.PRecord.setProp) and (tempItem.PRecord.Nomenclature <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Nomenclature))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Activity_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.Activity_ID <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Activity_ID))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Notes in tempItem.PRecord.setProp) and (tempItem.PRecord.Notes <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Notes))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Rules in tempItem.PRecord.setProp) and (tempItem.PRecord.Rules <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Rules))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Specialty_CL006 in tempItem.PRecord.setProp) and (tempItem.PRecord.Specialty_CL006 <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Specialty_CL006))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Valid_Until in tempItem.PRecord.setProp) and (tempItem.PRecord.Valid_Until <> Self.getAnsiStringMap(tempItem.DataPos, word(PR001_Valid_Until))) then
      begin
        inc(cnt);
        exit;
      end;

      if (PR001_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(PR001_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TPR001Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TPR001Item.Create(nil);
  ListPR001Search := TList<TPR001Item>.Create;
  ListForFinder := TList<TPR001Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TPR001Coll.destroy;
begin
  FreeAndNil(ListPR001Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TPR001Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: Result := 'CL132';
    PR001_Nomenclature: Result := 'Nomenclature';
    PR001_Activity_ID: Result := 'Activity_ID';
    PR001_Description: Result := 'Description';
    PR001_Notes: Result := 'Notes';
    PR001_Rules: Result := 'Rules';
    PR001_Specialty_CL006: Result := 'Specialty_CL006';
    PR001_Valid_Until: Result := 'Valid_Until';
    PR001_Logical: Result := 'Logical';
  end;
end;

function TPR001Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TPR001Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TPR001Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 9;
end;

function TPR001Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvPR001Root then
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

function TPR001Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TPR001Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TPR001Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TPR001Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PR001: TPR001Item;
  ACol: Integer;
  prop: TPR001Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PR001 := Items[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(PR001.PRecord) and (prop in PR001.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PR001, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PR001, AValue);
  end;
end;

procedure TPR001Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TPR001Item.TPropertyIndex;
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

procedure TPR001Coll.GetCellFromRecord(propIndex: word; PR001: TPR001Item; var AValue: String);
var
  str: string;
begin
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: str := (PR001.PRecord.CL132);
    PR001_Nomenclature: str := (PR001.PRecord.Nomenclature);
    PR001_Activity_ID: str := (PR001.PRecord.Activity_ID);
    PR001_Description: str := (PR001.PRecord.Description);
    PR001_Notes: str := (PR001.PRecord.Notes);
    PR001_Rules: str := (PR001.PRecord.Rules);
    PR001_Specialty_CL006: str := (PR001.PRecord.Specialty_CL006);
    PR001_Valid_Until: str := (PR001.PRecord.Valid_Until);
    PR001_Logical: str := PR001.Logical08ToStr(TLogicalData08(PR001.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPR001Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TPR001Item;
  ACol: Integer;
  prop: TPR001Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TPR001Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TPR001Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TPR001Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TPR001Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PR001: TPR001Item;
  ACol: Integer;
  prop: TPR001Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PR001 := ListPR001Search[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(PR001.PRecord) and (prop in PR001.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PR001, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PR001, AValue);
  end;
end;

function TPR001Coll.GetCollType: TCollectionsType;
begin
  Result := ctPR001;
end;

function TPR001Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctPR001Del;
end;

procedure TPR001Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PR001: TPR001Item;
  prop: TPR001Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PR001 := Items[ARow];
  prop := TPR001Item.TPropertyIndex(ACol);
  if Assigned(PR001.PRecord) and (prop in PR001.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PR001, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PR001, AFieldText);
  end;
end;

procedure TPR001Coll.GetCellFromMap(propIndex: word; ARow: Integer; PR001: TPR001Item; var AValue: String);
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
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Nomenclature: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Activity_ID: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Description: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Notes: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Rules: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Specialty_CL006: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Valid_Until: str :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PR001_Logical: str :=  PR001.Logical08ToStr(PR001.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPR001Coll.GetItem(Index: Integer): TPR001Item;
begin
  Result := TPR001Item(inherited GetItem(Index));
end;


procedure TPR001Coll.IndexValue(propIndex: TPR001Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPR001Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PR001_CL132:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      PR001_Nomenclature:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Activity_ID:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Notes:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Rules:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Specialty_CL006:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PR001_Valid_Until:
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

procedure TPR001Coll.IndexValueListNodes(propIndex: TPR001Item.TPropertyIndex);
begin

end;

function TPR001Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TPR001Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TPR001Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TPR001Item;
begin
  if index < 0 then
  begin
    Tempitem := TPR001Item.Create(nil);
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
procedure TPR001Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TPR001Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TPR001Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TPR001Item.TPropertyIndex(Field) of
PR001_CL132: ListForFinder[0].PRecord.CL132 := AText;
    PR001_Nomenclature: ListForFinder[0].PRecord.Nomenclature := AText;
    PR001_Activity_ID: ListForFinder[0].PRecord.Activity_ID := AText;
    PR001_Description: ListForFinder[0].PRecord.Description := AText;
    PR001_Notes: ListForFinder[0].PRecord.Notes := AText;
    PR001_Rules: ListForFinder[0].PRecord.Rules := AText;
    PR001_Specialty_CL006: ListForFinder[0].PRecord.Specialty_CL006 := AText;
    PR001_Valid_Until: ListForFinder[0].PRecord.Valid_Until := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TPR001Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TPR001Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TPR001Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TPR001Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TPR001Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TPR001Item.TPropertyIndex(Field) of
    PR001_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalPR001(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalPR001(logIndex))   
    end;
  end;
end;


procedure TPR001Coll.OnSetTextSearchLog(Log: TlogicalPR001Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TPR001Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TPR001Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TPR001Item.TPropertyIndex(propIndex) of
    PR001_CL132: Result := actAnsiString;
    PR001_Nomenclature: Result := actAnsiString;
    PR001_Activity_ID: Result := actAnsiString;
    PR001_Description: Result := actAnsiString;
    PR001_Notes: Result := actAnsiString;
    PR001_Rules: Result := actAnsiString;
    PR001_Specialty_CL006: Result := actAnsiString;
    PR001_Valid_Until: Result := actAnsiString;
    PR001_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TPR001Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TPR001Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PR001: TPR001Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  PR001 := Items[ARow];
  if not Assigned(PR001.PRecord) then
  begin
    New(PR001.PRecord);
    PR001.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TPR001Item.TPropertyIndex(ACol) of
      PR001_CL132: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Nomenclature: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Activity_ID: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Description: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Notes: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Rules: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Specialty_CL006: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PR001_Valid_Until: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
    if PR001.PRecord.setProp = [] then
    begin
      Dispose(PR001.PRecord);
      PR001.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
  case TPR001Item.TPropertyIndex(ACol) of
    PR001_CL132: PR001.PRecord.CL132 := AValue;
    PR001_Nomenclature: PR001.PRecord.Nomenclature := AValue;
    PR001_Activity_ID: PR001.PRecord.Activity_ID := AValue;
    PR001_Description: PR001.PRecord.Description := AValue;
    PR001_Notes: PR001.PRecord.Notes := AValue;
    PR001_Rules: PR001.PRecord.Rules := AValue;
    PR001_Specialty_CL006: PR001.PRecord.Specialty_CL006 := AValue;
    PR001_Valid_Until: PR001.PRecord.Valid_Until := AValue;
    PR001_Logical: PR001.PRecord.Logical := tlogicalPR001Set(PR001.StrToLogical08(AValue));
  end;
end;

procedure TPR001Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PR001: TPR001Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  PR001 := Items[ARow];
  if not Assigned(PR001.PRecord) then
  begin
    New(PR001.PRecord);
    PR001.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TPR001Item.TPropertyIndex(ACol) of
      PR001_CL132: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Nomenclature: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Activity_ID: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Description: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Notes: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Rules: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Specialty_CL006: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PR001_Valid_Until: isOld :=  PR001.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
    if PR001.PRecord.setProp = [] then
    begin
      Dispose(PR001.PRecord);
      PR001.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PR001.PRecord.setProp, TPR001Item.TPropertyIndex(ACol));
  case TPR001Item.TPropertyIndex(ACol) of
    PR001_CL132: PR001.PRecord.CL132 := AFieldText;
    PR001_Nomenclature: PR001.PRecord.Nomenclature := AFieldText;
    PR001_Activity_ID: PR001.PRecord.Activity_ID := AFieldText;
    PR001_Description: PR001.PRecord.Description := AFieldText;
    PR001_Notes: PR001.PRecord.Notes := AFieldText;
    PR001_Rules: PR001.PRecord.Rules := AFieldText;
    PR001_Specialty_CL006: PR001.PRecord.Specialty_CL006 := AFieldText;
    PR001_Valid_Until: PR001.PRecord.Valid_Until := AFieldText;
    PR001_Logical: PR001.PRecord.Logical := tlogicalPR001Set(PR001.StrToLogical08(AFieldText));
  end;
end;

procedure TPR001Coll.SetItem(Index: Integer; const Value: TPR001Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TPR001Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPR001Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPR001Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  PR001_CL132:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListPR001Search.Add(self.Items[i]);
  end;
end;
      PR001_Nomenclature:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Activity_ID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Notes:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Rules:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Specialty_CL006:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
      PR001_Valid_Until:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPR001Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPR001Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TPR001Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TPR001Item>);
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

procedure TPR001Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPR001Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPR001Search.Count]);

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

procedure TPR001Coll.SortByIndexAnsiString;
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

procedure TPR001Coll.SortByIndexInt;
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

procedure TPR001Coll.SortByIndexWord;
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

procedure TPR001Coll.SortByIndexValue(propIndex: TPR001Item.TPropertyIndex);
begin
  case propIndex of
    PR001_CL132: SortByIndexAnsiString;
      PR001_Nomenclature: SortByIndexAnsiString;
      PR001_Activity_ID: SortByIndexAnsiString;
      PR001_Description: SortByIndexAnsiString;
      PR001_Notes: SortByIndexAnsiString;
      PR001_Rules: SortByIndexAnsiString;
      PR001_Specialty_CL006: SortByIndexAnsiString;
      PR001_Valid_Until: SortByIndexAnsiString;
  end;
end;


end.