unit Table.CL134;

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

TLogicalCL134 = (
    Is_);
TlogicalCL134Set = set of TLogicalCL134;


TCL134Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL134_Key
       , CL134_Description
       , CL134_DescriptionEn
       , CL134_cl133
       , CL134_answer_type
       , CL134_answer_nomenclature
       , CL134_multiple_choice
       , CL134_cl028
       , CL134_note
       , CL134_ask_once
       , CL134_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL134 = ^TRecCL134;
      TRecCL134 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        cl133: AnsiString;
        answer_type: AnsiString;
        answer_nomenclature: AnsiString;
        multiple_choice: AnsiString;
        cl028: AnsiString;
        note: AnsiString;
        ask_once: AnsiString;
        Logical: TlogicalCL134Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL134;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL134;
    procedure UpdateCL134;
    procedure SaveCL134(var dataPosition: Cardinal)overload;
	procedure SaveCL134(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL134(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL134Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL134Item;
    function GetItem(Index: Integer): TCL134Item;
    procedure SetItem(Index: Integer; const Value: TCL134Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL134Item>;
    ListCL134Search: TList<TCL134Item>;
	PRecordSearch: ^TCL134Item.TRecCL134;
    ArrPropSearch: TArray<TCL134Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL134Item.TPropertyIndex>;
	VisibleColl: TCL134Item.TSetProp;
	ArrayPropOrder: TArray<TCL134Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL134Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL134: TCL134Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL134: TCL134Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL134Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL134Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL134Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL134Item.TPropertyIndex);
    property Items[Index: Integer]: TCL134Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL134Set);
	procedure CheckForSave(var cnt: Integer); override;
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
	{NZIS_START}
	procedure ImportXMLNzis(cl000: TObject); override;
	procedure UpdateXMLNzis; override;
	function CellDiffKind(ACol, ARow: Integer): TDiffKind; override;
	procedure BuildKeyDict(PropIndex: Word);
	{NZIS_END}
  end;

implementation
{NZIS_START}
uses
  Nzis.Nomen.baseCL000, System.Rtti;
{NZIS_END}  

{ TCL134Item }

constructor TCL134Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL134Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL134Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCL134Item.GetCollType: TCollectionsType;
begin
  Result := ctCL134;
end;

function TCL134Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TCL134Item.InsertCL134;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL134;
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
            CL134_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL134_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL134_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL134_cl133: SaveData(PRecord.cl133, PropPosition, metaPosition, dataPosition);
            CL134_answer_type: SaveData(PRecord.answer_type, PropPosition, metaPosition, dataPosition);
            CL134_answer_nomenclature: SaveData(PRecord.answer_nomenclature, PropPosition, metaPosition, dataPosition);
            CL134_multiple_choice: SaveData(PRecord.multiple_choice, PropPosition, metaPosition, dataPosition);
            CL134_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL134_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL134_ask_once: SaveData(PRecord.ask_once, PropPosition, metaPosition, dataPosition);
            CL134_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TCL134Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL134Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL134Item;
begin
  Result := True;
  for i := 0 to Length(TCL134Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL134Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL134Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL134_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL134_Key), cot);
            CL134_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL134_Description), cot);
            CL134_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL134_DescriptionEn), cot);
            CL134_cl133: Result := IsFinded(ATempItem.PRecord.cl133, buf, FPosDataADB, word(CL134_cl133), cot);
            CL134_answer_type: Result := IsFinded(ATempItem.PRecord.answer_type, buf, FPosDataADB, word(CL134_answer_type), cot);
            CL134_answer_nomenclature: Result := IsFinded(ATempItem.PRecord.answer_nomenclature, buf, FPosDataADB, word(CL134_answer_nomenclature), cot);
            CL134_multiple_choice: Result := IsFinded(ATempItem.PRecord.multiple_choice, buf, FPosDataADB, word(CL134_multiple_choice), cot);
            CL134_cl028: Result := IsFinded(ATempItem.PRecord.cl028, buf, FPosDataADB, word(CL134_cl028), cot);
            CL134_note: Result := IsFinded(ATempItem.PRecord.note, buf, FPosDataADB, word(CL134_note), cot);
            CL134_ask_once: Result := IsFinded(ATempItem.PRecord.ask_once, buf, FPosDataADB, word(CL134_ask_once), cot);
            CL134_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL134_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL134Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexCL134: TCL134Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL134Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCL134 := Low(TCL134Item.TPropertyIndex) to High(TCL134Item.TPropertyIndex) do
  begin
    if not (propindexCL134 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL134);
      dataCmdProp.vid := vvCL134;
    end;
    self.FillPropCL134(propindexCL134, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL134Item.FillPropCL134(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL134_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL134_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL134_DescriptionEn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.DescriptionEn, lenStr);
              stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
            end;
            CL134_cl133:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl133, lenStr);
              stream.Read(Self.PRecord.cl133[1], lenStr);
            end;
            CL134_answer_type:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.answer_type, lenStr);
              stream.Read(Self.PRecord.answer_type[1], lenStr);
            end;
            CL134_answer_nomenclature:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.answer_nomenclature, lenStr);
              stream.Read(Self.PRecord.answer_nomenclature[1], lenStr);
            end;
            CL134_multiple_choice:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.multiple_choice, lenStr);
              stream.Read(Self.PRecord.multiple_choice[1], lenStr);
            end;
            CL134_cl028:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl028, lenStr);
              stream.Read(Self.PRecord.cl028[1], lenStr);
            end;
            CL134_note:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.note, lenStr);
              stream.Read(Self.PRecord.note[1], lenStr);
            end;
            CL134_ask_once:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.ask_once, lenStr);
              stream.Read(Self.PRecord.ask_once[1], lenStr);
            end;
            CL134_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL134Item.SaveCL134(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL134(dataPosition);
end;

procedure TCL134Item.SaveCL134(var dataPosition: Cardinal);
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
            CL134_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL134_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL134_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL134_cl133: SaveData(PRecord.cl133, PropPosition, metaPosition, dataPosition);
            CL134_answer_type: SaveData(PRecord.answer_type, PropPosition, metaPosition, dataPosition);
            CL134_answer_nomenclature: SaveData(PRecord.answer_nomenclature, PropPosition, metaPosition, dataPosition);
            CL134_multiple_choice: SaveData(PRecord.multiple_choice, PropPosition, metaPosition, dataPosition);
            CL134_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL134_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL134_ask_once: SaveData(PRecord.ask_once, PropPosition, metaPosition, dataPosition);
            CL134_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TCL134Item.UpdateCL134;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL134;
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
            CL134_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL134_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL134_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL134_cl133: UpdateData(PRecord.cl133, PropPosition, metaPosition, dataPosition);
            CL134_answer_type: UpdateData(PRecord.answer_type, PropPosition, metaPosition, dataPosition);
            CL134_answer_nomenclature: UpdateData(PRecord.answer_nomenclature, PropPosition, metaPosition, dataPosition);
            CL134_multiple_choice: UpdateData(PRecord.multiple_choice, PropPosition, metaPosition, dataPosition);
            CL134_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL134_note: UpdateData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL134_ask_once: UpdateData(PRecord.ask_once, PropPosition, metaPosition, dataPosition);
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

{ TCL134Coll }

function TCL134Coll.AddItem(ver: word): TCL134Item;
begin
  Result := TCL134Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL134Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL134Item;
begin
  ItemForSearch := TCL134Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL134Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCL134Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL134Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL134Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCL134Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL134Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (CL134_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_Key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_DescriptionEn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_cl133 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl133 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_cl133))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_answer_type in tempItem.PRecord.setProp) and (tempItem.PRecord.answer_type <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_answer_type))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_answer_nomenclature in tempItem.PRecord.setProp) and (tempItem.PRecord.answer_nomenclature <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_answer_nomenclature))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_multiple_choice in tempItem.PRecord.setProp) and (tempItem.PRecord.multiple_choice <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_multiple_choice))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_cl028 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl028 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_cl028))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_note in tempItem.PRecord.setProp) and (tempItem.PRecord.note <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_note))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_ask_once in tempItem.PRecord.setProp) and (tempItem.PRecord.ask_once <> Self.getAnsiStringMap(tempItem.DataPos, word(CL134_ask_once))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL134_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL134_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCL134Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL134Item.Create(nil);
  ListCL134Search := TList<TCL134Item>.Create;
  ListForFinder := TList<TCL134Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL134Coll.destroy;
begin
  FreeAndNil(ListCL134Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL134Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: Result := 'Key';
    CL134_Description: Result := 'Description';
    CL134_DescriptionEn: Result := 'DescriptionEn';
    CL134_cl133: Result := 'cl133';
    CL134_answer_type: Result := 'answer_type';
    CL134_answer_nomenclature: Result := 'answer_nomenclature';
    CL134_multiple_choice: Result := 'multiple_choice';
    CL134_cl028: Result := 'cl028';
    CL134_note: Result := 'note';
    CL134_ask_once: Result := 'ask_once';
    CL134_Logical: Result := 'Logical';
  end;
end;

function TCL134Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL134Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCL134Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 11;
end;

function TCL134Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCL134Root then
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

function TCL134Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCL134Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCL134Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TCL134Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL134: TCL134Item;
  ACol: Integer;
  prop: TCL134Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL134 := Items[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(CL134.PRecord) and (prop in CL134.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL134, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL134, AValue);
  end;
end;

procedure TCL134Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TCL134Item.TPropertyIndex;
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

procedure TCL134Coll.GetCellFromRecord(propIndex: word; CL134: TCL134Item; var AValue: String);
var
  str: string;
begin
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: str := (CL134.PRecord.Key);
    CL134_Description: str := (CL134.PRecord.Description);
    CL134_DescriptionEn: str := (CL134.PRecord.DescriptionEn);
    CL134_cl133: str := (CL134.PRecord.cl133);
    CL134_answer_type: str := (CL134.PRecord.answer_type);
    CL134_answer_nomenclature: str := (CL134.PRecord.answer_nomenclature);
    CL134_multiple_choice: str := (CL134.PRecord.multiple_choice);
    CL134_cl028: str := (CL134.PRecord.cl028);
    CL134_note: str := (CL134.PRecord.note);
    CL134_ask_once: str := (CL134.PRecord.ask_once);
    CL134_Logical: str := CL134.Logical08ToStr(TLogicalData08(CL134.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL134Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL134Item;
  ACol: Integer;
  prop: TCL134Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL134Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL134Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL134Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL134Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL134: TCL134Item;
  ACol: Integer;
  prop: TCL134Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL134 := ListCL134Search[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(CL134.PRecord) and (prop in CL134.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL134, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL134, AValue);
  end;
end;

function TCL134Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL134;
end;

function TCL134Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL134Del;
end;

procedure TCL134Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL134: TCL134Item;
  prop: TCL134Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL134 := Items[ARow];
  prop := TCL134Item.TPropertyIndex(ACol);
  if Assigned(CL134.PRecord) and (prop in CL134.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL134, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL134, AFieldText);
  end;
end;

procedure TCL134Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL134: TCL134Item; var AValue: String);
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
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Description: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_DescriptionEn: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_cl133: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_answer_type: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_answer_nomenclature: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_multiple_choice: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_cl028: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_note: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_ask_once: str :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL134_Logical: str :=  CL134.Logical08ToStr(CL134.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL134Coll.GetItem(Index: Integer): TCL134Item;
begin
  Result := TCL134Item(inherited GetItem(Index));
end;


procedure TCL134Coll.IndexValue(propIndex: TCL134Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL134Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL134_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL134_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_cl133:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_answer_type:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_answer_nomenclature:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_multiple_choice:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_cl028:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_note:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL134_ask_once:
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

procedure TCL134Coll.IndexValueListNodes(propIndex: TCL134Item.TPropertyIndex);
begin

end;

function TCL134Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL134Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TCL134Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL134Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL134Item.Create(nil);
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
procedure TCL134Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL134Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL134Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL134Item.TPropertyIndex(Field) of
CL134_Key: ListForFinder[0].PRecord.Key := AText;
    CL134_Description: ListForFinder[0].PRecord.Description := AText;
    CL134_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
    CL134_cl133: ListForFinder[0].PRecord.cl133 := AText;
    CL134_answer_type: ListForFinder[0].PRecord.answer_type := AText;
    CL134_answer_nomenclature: ListForFinder[0].PRecord.answer_nomenclature := AText;
    CL134_multiple_choice: ListForFinder[0].PRecord.multiple_choice := AText;
    CL134_cl028: ListForFinder[0].PRecord.cl028 := AText;
    CL134_note: ListForFinder[0].PRecord.note := AText;
    CL134_ask_once: ListForFinder[0].PRecord.ask_once := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL134Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL134Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL134Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL134Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL134Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL134Item.TPropertyIndex(Field) of
    CL134_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL134(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL134(logIndex))   
    end;
  end;
end;


procedure TCL134Coll.OnSetTextSearchLog(Log: TlogicalCL134Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL134Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCL134Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL134Item.TPropertyIndex(propIndex) of
    CL134_Key: Result := actAnsiString;
    CL134_Description: Result := actAnsiString;
    CL134_DescriptionEn: Result := actAnsiString;
    CL134_cl133: Result := actAnsiString;
    CL134_answer_type: Result := actAnsiString;
    CL134_answer_nomenclature: Result := actAnsiString;
    CL134_multiple_choice: Result := actAnsiString;
    CL134_cl028: Result := actAnsiString;
    CL134_note: Result := actAnsiString;
    CL134_ask_once: Result := actAnsiString;
    CL134_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL134Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL134Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL134: TCL134Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL134 := Items[ARow];
  if not Assigned(CL134.PRecord) then
  begin
    New(CL134.PRecord);
    CL134.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL134Item.TPropertyIndex(ACol) of
      CL134_Key: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_Description: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_DescriptionEn: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_cl133: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_answer_type: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_answer_nomenclature: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_multiple_choice: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_cl028: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_note: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL134_ask_once: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
    if CL134.PRecord.setProp = [] then
    begin
      Dispose(CL134.PRecord);
      CL134.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
  case TCL134Item.TPropertyIndex(ACol) of
    CL134_Key: CL134.PRecord.Key := AValue;
    CL134_Description: CL134.PRecord.Description := AValue;
    CL134_DescriptionEn: CL134.PRecord.DescriptionEn := AValue;
    CL134_cl133: CL134.PRecord.cl133 := AValue;
    CL134_answer_type: CL134.PRecord.answer_type := AValue;
    CL134_answer_nomenclature: CL134.PRecord.answer_nomenclature := AValue;
    CL134_multiple_choice: CL134.PRecord.multiple_choice := AValue;
    CL134_cl028: CL134.PRecord.cl028 := AValue;
    CL134_note: CL134.PRecord.note := AValue;
    CL134_ask_once: CL134.PRecord.ask_once := AValue;
    CL134_Logical: CL134.PRecord.Logical := tlogicalCL134Set(CL134.StrToLogical08(AValue));
  end;
end;

procedure TCL134Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL134: TCL134Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL134 := Items[ARow];
  if not Assigned(CL134.PRecord) then
  begin
    New(CL134.PRecord);
    CL134.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL134Item.TPropertyIndex(ACol) of
      CL134_Key: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_Description: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_DescriptionEn: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_cl133: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_answer_type: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_answer_nomenclature: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_multiple_choice: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_cl028: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_note: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL134_ask_once: isOld :=  CL134.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
    if CL134.PRecord.setProp = [] then
    begin
      Dispose(CL134.PRecord);
      CL134.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL134.PRecord.setProp, TCL134Item.TPropertyIndex(ACol));
  case TCL134Item.TPropertyIndex(ACol) of
    CL134_Key: CL134.PRecord.Key := AFieldText;
    CL134_Description: CL134.PRecord.Description := AFieldText;
    CL134_DescriptionEn: CL134.PRecord.DescriptionEn := AFieldText;
    CL134_cl133: CL134.PRecord.cl133 := AFieldText;
    CL134_answer_type: CL134.PRecord.answer_type := AFieldText;
    CL134_answer_nomenclature: CL134.PRecord.answer_nomenclature := AFieldText;
    CL134_multiple_choice: CL134.PRecord.multiple_choice := AFieldText;
    CL134_cl028: CL134.PRecord.cl028 := AFieldText;
    CL134_note: CL134.PRecord.note := AFieldText;
    CL134_ask_once: CL134.PRecord.ask_once := AFieldText;
    CL134_Logical: CL134.PRecord.Logical := tlogicalCL134Set(CL134.StrToLogical08(AFieldText));
  end;
end;

procedure TCL134Coll.SetItem(Index: Integer; const Value: TCL134Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL134Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL134Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL134Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL134_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL134Search.Add(self.Items[i]);
  end;
end;
      CL134_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_cl133:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_answer_type:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_answer_nomenclature:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_multiple_choice:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_cl028:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_note:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
      CL134_ask_once:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL134Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL134Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL134Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL134Item>);
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

procedure TCL134Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL134Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL134Search.Count]);

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

procedure TCL134Coll.SortByIndexAnsiString;
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

procedure TCL134Coll.SortByIndexInt;
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

procedure TCL134Coll.SortByIndexWord;
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

procedure TCL134Coll.SortByIndexValue(propIndex: TCL134Item.TPropertyIndex);
begin
  case propIndex of
    CL134_Key: SortByIndexAnsiString;
      CL134_Description: SortByIndexAnsiString;
      CL134_DescriptionEn: SortByIndexAnsiString;
      CL134_cl133: SortByIndexAnsiString;
      CL134_answer_type: SortByIndexAnsiString;
      CL134_answer_nomenclature: SortByIndexAnsiString;
      CL134_multiple_choice: SortByIndexAnsiString;
      CL134_cl028: SortByIndexAnsiString;
      CL134_note: SortByIndexAnsiString;
      CL134_ask_once: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL134Coll.ImportXMLNzis(cl000: TObject);
var
 Acl000 : TCL000EntryCollection;
 entry : TCL000EntryItem;
 item : TCL134Item;
 i, idxOld, j: Integer;
 idx : array of Integer;
 propIdx: TCL134Item.TPropertyIndex;
 propName, xmlName, oldValue, newValue: string;
 kindDiff: TDiffKind; pCardinalData: PCardinal;
 dataPosition: Cardinal; IsNew: Boolean;
begin
  Acl000 := TCL000EntryCollection(cl000);
  IsNew := Count = 0;

  for i := 0 to Count - 1 do
  begin
    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ctCL134Del) then
      Continue;
    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ctCL134Old);
  end;

  BuildKeyDict(Ord(CL134_Key));

  j := 0;
  SetLength(idx, 0);

  for propIdx := Low(TCL134Item.TPropertyIndex) to High(TCL134Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    if SameText(propName, 'CL134_Key') then Continue;
    if SameText(propName, 'CL134_Description') then Continue;
    if SameText(propName, 'CL134_Logical') then Continue;

    xmlName := propName.Substring(Length('CL134_'));
    xmlName := xmlName.Replace('_', ' ');

    for i := 0 to Acl000.FieldsNames.Count - 1 do
      if SameText(Acl000.FieldsNames[i], xmlName) or
         SameText(Acl000.FieldsNames[i], xmlName.Replace(' ', '_')) then
      begin
        SetLength(idx, Length(idx)+1);
        idx[High(idx)] := i;
        Break;
      end;
  end;

  for i := 0 to Acl000.Count - 1 do
  begin
    entry := Acl000.Items[i];

    if KeyDict.TryGetValue(entry.Key, idxOld) then
    begin
      item := Items[idxOld];
      kindDiff := dkChanged;
    end
    else
    begin
      item := TCL134Item(Add);
      kindDiff := dkNew;
    end;

    if item.PRecord <> nil then
      Dispose(item.PRecord);
    New(item.PRecord);
    item.PRecord.setProp := [];

    newValue := entry.Key;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_Key));
    item.PRecord.Key := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL134_Key);

    newValue := entry.Descr;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_Description));
    item.PRecord.Description := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL134_Description);

    j := 0;
    // DescriptionEn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_DescriptionEn));

      Item.PRecord.DescriptionEn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_DescriptionEn);
    end;
    Inc(j);

    // cl133
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_cl133));

      Item.PRecord.cl133 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_cl133);
    end;
    Inc(j);

    // answer_type
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_answer_type));

      Item.PRecord.answer_type := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_answer_type);
    end;
    Inc(j);

    // answer_nomenclature
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_answer_nomenclature));

      Item.PRecord.answer_nomenclature := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_answer_nomenclature);
    end;
    Inc(j);

    // multiple_choice
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_multiple_choice));

      Item.PRecord.multiple_choice := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_multiple_choice);
    end;
    Inc(j);

    // cl028
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_cl028));

      Item.PRecord.cl028 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_cl028);
    end;
    Inc(j);

    // note
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_note));

      Item.PRecord.note := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_note);
    end;
    Inc(j);

    // ask_once
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL134_ask_once));

      Item.PRecord.ask_once := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL134_ask_once);
    end;
    Inc(j);

    // NEW
    if kindDiff = dkNew then
    begin
      if IsNew then
      begin
        item.InsertCL134;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL134);
        Self.streamComm.Len := Self.streamComm.Size;
        Self.cmdFile.CopyFrom(Self.streamComm, 0);
        Dispose(item.PRecord);
        item.PRecord := nil;
      end;
    end
    else
    begin
      // UPDATE
      if item.PRecord.setProp <> [] then
      begin
        if IsNew then
        begin
          pCardinalData := pointer(PByte(Buf) + 12);
          dataPosition := pCardinalData^ + PosData;
          item.SaveCL134(dataPosition);
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL134);
          Self.streamComm.Len := Self.streamComm.Size;
          Self.cmdFile.CopyFrom(Self.streamComm, 0);
          pCardinalData^ := dataPosition - PosData;
        end
        else
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL134);
      end
      else
      begin
        Dispose(item.PRecord);
        item.PRecord := nil;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL134);
      end;
    end;
  end;
end;

procedure TCL134Coll.UpdateXMLNzis;
var
  i: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].PRecord = nil then
    begin
      if Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ = ord(ctCL134Old) then
        Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ := ord(ctCL134Del);
        Continue;
    end;


    if Items[i].DataPos = 0 then
    begin
      Items[i].InsertCL134;
      Self.streamComm.Len := Self.streamComm.Size;
      Self.cmdFile.CopyFrom(Self.streamComm, 0);
      Dispose(Items[i].PRecord);
      Items[i].PRecord := nil;
    end
    else
    begin
      pCardinalData := pointer(PByte(self.Buf) + 12);
      dataPosition := pCardinalData^ + self.PosData;
      Items[i].SaveCL134(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      pCardinalData := pointer(PByte(Buf) + 12);
      pCardinalData^  := dataPosition - self.PosData;
    end;

  end;
end;

procedure TCL134Coll.BuildKeyDict(PropIndex: Word);
var
  i      : Integer;
  item   : TCL134Item;
  keyStr : string;
  pIdx   : TCL134Item.TPropertyIndex;
begin
  // общата част – алокация / чистене на речника
  inherited BuildKeyDict(PropIndex);

  // кастваме Word > enum на генерирания клас
  pIdx := TCL134Item.TPropertyIndex(PropIndex);

  for i := 0 to Count - 1 do
  begin
    item := Items[i];
    if Pword(PByte(Buf) + item.DataPos +  - 4)^ = ord(ctCL134Del) then
      Continue;
    keyStr := self.getAnsiStringMap(item.datapos,PropIndex);

    if keyStr <> '' then
    begin
      // ако има дубликати – последният печели (полезно за "последна версия")
      KeyDict.AddOrSetValue(keyStr, i);
    end;
  end;
end;

function TCL134Coll.CellDiffKind(ACol, ARow: Integer): TDiffKind;
begin
  if (ARow > count) or (ARow < 0) then
    Exit;


  if items[ARow].DataPos = 0 then
  begin
    Result := dkNew;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL134Old)) then
  begin
    Result := dkForDeleted;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL134Del)) then
  begin
    Result := dkDeleted;
    Exit;
  end;

  if Items[ARow].PRecord = nil then
  begin
    Result := dkNone;
    Exit;
  end;

  if TCL134Item.TPropertyIndex(ACol) in Items[ARow].PRecord.setProp then
  begin
    Result := dkChanged;
    Exit;
  end;
  //test

end;

{NZIS_END}

end.