unit Table.CL038;

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

TLogicalCL038 = (
    Is_);
TlogicalCL038Set = set of TLogicalCL038;


TCL038Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL038_Key
       , CL038_Description
       , CL038_DescriptionEn
       , CL038_immun_type
       , CL038_display_transfered_data
       , CL038_cl082
       , CL038_max_age
       , CL038_min_age
       , CL038_program_group
       , CL038_vaccine_code
       , CL038_dose_number
       , CL038_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL038 = ^TRecCL038;
      TRecCL038 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        immun_type: AnsiString;
        display_transfered_data: AnsiString;
        cl082: AnsiString;
        max_age: AnsiString;
        min_age: AnsiString;
        program_group: AnsiString;
        vaccine_code: AnsiString;
        dose_number: AnsiString;
        Logical: TlogicalCL038Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL038;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL038;
    procedure UpdateCL038;
    procedure SaveCL038(var dataPosition: Cardinal)overload;
	procedure SaveCL038(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL038(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL038Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL038Item;
    function GetItem(Index: Integer): TCL038Item;
    procedure SetItem(Index: Integer; const Value: TCL038Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL038Item>;
    ListCL038Search: TList<TCL038Item>;
	PRecordSearch: ^TCL038Item.TRecCL038;
    ArrPropSearch: TArray<TCL038Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL038Item.TPropertyIndex>;
	VisibleColl: TCL038Item.TSetProp;
	ArrayPropOrder: TArray<TCL038Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL038Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL038: TCL038Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL038: TCL038Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL038Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL038Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL038Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL038Item.TPropertyIndex);
    property Items[Index: Integer]: TCL038Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL038Set);
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

{ TCL038Item }

constructor TCL038Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL038Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL038Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCL038Item.GetCollType: TCollectionsType;
begin
  Result := ctCL038;
end;

function TCL038Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TCL038Item.InsertCL038;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL038;
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
            CL038_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL038_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL038_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL038_immun_type: SaveData(PRecord.immun_type, PropPosition, metaPosition, dataPosition);
            CL038_display_transfered_data: SaveData(PRecord.display_transfered_data, PropPosition, metaPosition, dataPosition);
            CL038_cl082: SaveData(PRecord.cl082, PropPosition, metaPosition, dataPosition);
            CL038_max_age: SaveData(PRecord.max_age, PropPosition, metaPosition, dataPosition);
            CL038_min_age: SaveData(PRecord.min_age, PropPosition, metaPosition, dataPosition);
            CL038_program_group: SaveData(PRecord.program_group, PropPosition, metaPosition, dataPosition);
            CL038_vaccine_code: SaveData(PRecord.vaccine_code, PropPosition, metaPosition, dataPosition);
            CL038_dose_number: SaveData(PRecord.dose_number, PropPosition, metaPosition, dataPosition);
            CL038_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TCL038Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL038Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL038Item;
begin
  Result := True;
  for i := 0 to Length(TCL038Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL038Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL038Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL038_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL038_Key), cot);
            CL038_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL038_Description), cot);
            CL038_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL038_DescriptionEn), cot);
            CL038_immun_type: Result := IsFinded(ATempItem.PRecord.immun_type, buf, FPosDataADB, word(CL038_immun_type), cot);
            CL038_display_transfered_data: Result := IsFinded(ATempItem.PRecord.display_transfered_data, buf, FPosDataADB, word(CL038_display_transfered_data), cot);
            CL038_cl082: Result := IsFinded(ATempItem.PRecord.cl082, buf, FPosDataADB, word(CL038_cl082), cot);
            CL038_max_age: Result := IsFinded(ATempItem.PRecord.max_age, buf, FPosDataADB, word(CL038_max_age), cot);
            CL038_min_age: Result := IsFinded(ATempItem.PRecord.min_age, buf, FPosDataADB, word(CL038_min_age), cot);
            CL038_program_group: Result := IsFinded(ATempItem.PRecord.program_group, buf, FPosDataADB, word(CL038_program_group), cot);
            CL038_vaccine_code: Result := IsFinded(ATempItem.PRecord.vaccine_code, buf, FPosDataADB, word(CL038_vaccine_code), cot);
            CL038_dose_number: Result := IsFinded(ATempItem.PRecord.dose_number, buf, FPosDataADB, word(CL038_dose_number), cot);
            CL038_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL038_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL038Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexCL038: TCL038Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL038Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCL038 := Low(TCL038Item.TPropertyIndex) to High(TCL038Item.TPropertyIndex) do
  begin
    if not (propindexCL038 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL038);
      dataCmdProp.vid := vvCL038;
    end;
    self.FillPropCL038(propindexCL038, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL038Item.FillPropCL038(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL038_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL038_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL038_DescriptionEn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.DescriptionEn, lenStr);
              stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
            end;
            CL038_immun_type:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.immun_type, lenStr);
              stream.Read(Self.PRecord.immun_type[1], lenStr);
            end;
            CL038_display_transfered_data:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.display_transfered_data, lenStr);
              stream.Read(Self.PRecord.display_transfered_data[1], lenStr);
            end;
            CL038_cl082:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl082, lenStr);
              stream.Read(Self.PRecord.cl082[1], lenStr);
            end;
            CL038_max_age:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.max_age, lenStr);
              stream.Read(Self.PRecord.max_age[1], lenStr);
            end;
            CL038_min_age:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.min_age, lenStr);
              stream.Read(Self.PRecord.min_age[1], lenStr);
            end;
            CL038_program_group:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.program_group, lenStr);
              stream.Read(Self.PRecord.program_group[1], lenStr);
            end;
            CL038_vaccine_code:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.vaccine_code, lenStr);
              stream.Read(Self.PRecord.vaccine_code[1], lenStr);
            end;
            CL038_dose_number:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.dose_number, lenStr);
              stream.Read(Self.PRecord.dose_number[1], lenStr);
            end;
            CL038_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL038Item.SaveCL038(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL038(dataPosition);
end;

procedure TCL038Item.SaveCL038(var dataPosition: Cardinal);
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
            CL038_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL038_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL038_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL038_immun_type: SaveData(PRecord.immun_type, PropPosition, metaPosition, dataPosition);
            CL038_display_transfered_data: SaveData(PRecord.display_transfered_data, PropPosition, metaPosition, dataPosition);
            CL038_cl082: SaveData(PRecord.cl082, PropPosition, metaPosition, dataPosition);
            CL038_max_age: SaveData(PRecord.max_age, PropPosition, metaPosition, dataPosition);
            CL038_min_age: SaveData(PRecord.min_age, PropPosition, metaPosition, dataPosition);
            CL038_program_group: SaveData(PRecord.program_group, PropPosition, metaPosition, dataPosition);
            CL038_vaccine_code: SaveData(PRecord.vaccine_code, PropPosition, metaPosition, dataPosition);
            CL038_dose_number: SaveData(PRecord.dose_number, PropPosition, metaPosition, dataPosition);
            CL038_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TCL038Item.UpdateCL038;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL038;
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
            CL038_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL038_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL038_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL038_immun_type: UpdateData(PRecord.immun_type, PropPosition, metaPosition, dataPosition);
            CL038_display_transfered_data: UpdateData(PRecord.display_transfered_data, PropPosition, metaPosition, dataPosition);
            CL038_cl082: UpdateData(PRecord.cl082, PropPosition, metaPosition, dataPosition);
            CL038_max_age: UpdateData(PRecord.max_age, PropPosition, metaPosition, dataPosition);
            CL038_min_age: UpdateData(PRecord.min_age, PropPosition, metaPosition, dataPosition);
            CL038_program_group: UpdateData(PRecord.program_group, PropPosition, metaPosition, dataPosition);
            CL038_vaccine_code: UpdateData(PRecord.vaccine_code, PropPosition, metaPosition, dataPosition);
            CL038_dose_number: UpdateData(PRecord.dose_number, PropPosition, metaPosition, dataPosition);
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

{ TCL038Coll }

function TCL038Coll.AddItem(ver: word): TCL038Item;
begin
  Result := TCL038Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL038Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL038Item;
begin
  ItemForSearch := TCL038Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL038Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCL038Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL038Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL038Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCL038Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL038Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (CL038_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_Key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_DescriptionEn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_immun_type in tempItem.PRecord.setProp) and (tempItem.PRecord.immun_type <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_immun_type))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_display_transfered_data in tempItem.PRecord.setProp) and (tempItem.PRecord.display_transfered_data <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_display_transfered_data))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_cl082 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl082 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_cl082))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_max_age in tempItem.PRecord.setProp) and (tempItem.PRecord.max_age <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_max_age))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_min_age in tempItem.PRecord.setProp) and (tempItem.PRecord.min_age <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_min_age))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_program_group in tempItem.PRecord.setProp) and (tempItem.PRecord.program_group <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_program_group))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_vaccine_code in tempItem.PRecord.setProp) and (tempItem.PRecord.vaccine_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_vaccine_code))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_dose_number in tempItem.PRecord.setProp) and (tempItem.PRecord.dose_number <> Self.getAnsiStringMap(tempItem.DataPos, word(CL038_dose_number))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL038_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL038_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCL038Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL038Item.Create(nil);
  ListCL038Search := TList<TCL038Item>.Create;
  ListForFinder := TList<TCL038Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL038Coll.destroy;
begin
  FreeAndNil(ListCL038Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL038Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_Key: Result := 'Key';
    CL038_Description: Result := 'Description';
    CL038_DescriptionEn: Result := 'DescriptionEn';
    CL038_immun_type: Result := 'immun_type';
    CL038_display_transfered_data: Result := 'display_transfered_data';
    CL038_cl082: Result := 'cl082';
    CL038_max_age: Result := 'max_age';
    CL038_min_age: Result := 'min_age';
    CL038_program_group: Result := 'program_group';
    CL038_vaccine_code: Result := 'vaccine_code';
    CL038_dose_number: Result := 'dose_number';
    CL038_Logical: Result := 'Logical';
  end;
end;

function TCL038Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL038Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCL038Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 12;
end;

function TCL038Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCL038Root then
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

function TCL038Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCL038Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCL038Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TCL038Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL038: TCL038Item;
  ACol: Integer;
  prop: TCL038Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL038 := Items[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(CL038.PRecord) and (prop in CL038.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL038, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL038, AValue);
  end;
end;

procedure TCL038Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TCL038Item.TPropertyIndex;
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

procedure TCL038Coll.GetCellFromRecord(propIndex: word; CL038: TCL038Item; var AValue: String);
var
  str: string;
begin
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_Key: str := (CL038.PRecord.Key);
    CL038_Description: str := (CL038.PRecord.Description);
    CL038_DescriptionEn: str := (CL038.PRecord.DescriptionEn);
    CL038_immun_type: str := (CL038.PRecord.immun_type);
    CL038_display_transfered_data: str := (CL038.PRecord.display_transfered_data);
    CL038_cl082: str := (CL038.PRecord.cl082);
    CL038_max_age: str := (CL038.PRecord.max_age);
    CL038_min_age: str := (CL038.PRecord.min_age);
    CL038_program_group: str := (CL038.PRecord.program_group);
    CL038_vaccine_code: str := (CL038.PRecord.vaccine_code);
    CL038_dose_number: str := (CL038.PRecord.dose_number);
    CL038_Logical: str := CL038.Logical08ToStr(TLogicalData08(CL038.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL038Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL038Item;
  ACol: Integer;
  prop: TCL038Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL038Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL038Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL038Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL038Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL038: TCL038Item;
  ACol: Integer;
  prop: TCL038Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL038 := ListCL038Search[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(CL038.PRecord) and (prop in CL038.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL038, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL038, AValue);
  end;
end;

function TCL038Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL038;
end;

function TCL038Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL038Del;
end;

procedure TCL038Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL038: TCL038Item;
  prop: TCL038Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL038 := Items[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(CL038.PRecord) and (prop in CL038.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL038, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL038, AFieldText);
  end;
end;

procedure TCL038Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL038: TCL038Item; var AValue: String);
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
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_Key: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_Description: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_DescriptionEn: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_immun_type: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_display_transfered_data: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_cl082: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_max_age: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_min_age: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_program_group: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_vaccine_code: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_dose_number: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_Logical: str :=  CL038.Logical08ToStr(CL038.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL038Coll.GetItem(Index: Integer): TCL038Item;
begin
  Result := TCL038Item(inherited GetItem(Index));
end;


procedure TCL038Coll.IndexValue(propIndex: TCL038Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL038Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL038_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL038_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_immun_type:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_display_transfered_data:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_cl082:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_max_age:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_min_age:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_program_group:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_vaccine_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_dose_number:
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

procedure TCL038Coll.IndexValueListNodes(propIndex: TCL038Item.TPropertyIndex);
begin

end;

function TCL038Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL038Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TCL038Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL038Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL038Item.Create(nil);
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
procedure TCL038Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL038Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL038Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL038Item.TPropertyIndex(Field) of
CL038_Key: ListForFinder[0].PRecord.Key := AText;
    CL038_Description: ListForFinder[0].PRecord.Description := AText;
    CL038_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
    CL038_immun_type: ListForFinder[0].PRecord.immun_type := AText;
    CL038_display_transfered_data: ListForFinder[0].PRecord.display_transfered_data := AText;
    CL038_cl082: ListForFinder[0].PRecord.cl082 := AText;
    CL038_max_age: ListForFinder[0].PRecord.max_age := AText;
    CL038_min_age: ListForFinder[0].PRecord.min_age := AText;
    CL038_program_group: ListForFinder[0].PRecord.program_group := AText;
    CL038_vaccine_code: ListForFinder[0].PRecord.vaccine_code := AText;
    CL038_dose_number: ListForFinder[0].PRecord.dose_number := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL038Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL038Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL038Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL038Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL038Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL038Item.TPropertyIndex(Field) of
    CL038_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL038(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL038(logIndex))   
    end;
  end;
end;


procedure TCL038Coll.OnSetTextSearchLog(Log: TlogicalCL038Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL038Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCL038Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_Key: Result := actAnsiString;
    CL038_Description: Result := actAnsiString;
    CL038_DescriptionEn: Result := actAnsiString;
    CL038_immun_type: Result := actAnsiString;
    CL038_display_transfered_data: Result := actAnsiString;
    CL038_cl082: Result := actAnsiString;
    CL038_max_age: Result := actAnsiString;
    CL038_min_age: Result := actAnsiString;
    CL038_program_group: Result := actAnsiString;
    CL038_vaccine_code: Result := actAnsiString;
    CL038_dose_number: Result := actAnsiString;
    CL038_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL038Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL038Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL038: TCL038Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL038 := Items[ARow];
  if not Assigned(CL038.PRecord) then
  begin
    New(CL038.PRecord);
    CL038.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL038Item.TPropertyIndex(ACol) of
      CL038_Key: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_Description: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_DescriptionEn: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_immun_type: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_display_transfered_data: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_cl082: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_max_age: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_min_age: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_program_group: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_vaccine_code: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL038_dose_number: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
    if CL038.PRecord.setProp = [] then
    begin
      Dispose(CL038.PRecord);
      CL038.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
  case TCL038Item.TPropertyIndex(ACol) of
    CL038_Key: CL038.PRecord.Key := AValue;
    CL038_Description: CL038.PRecord.Description := AValue;
    CL038_DescriptionEn: CL038.PRecord.DescriptionEn := AValue;
    CL038_immun_type: CL038.PRecord.immun_type := AValue;
    CL038_display_transfered_data: CL038.PRecord.display_transfered_data := AValue;
    CL038_cl082: CL038.PRecord.cl082 := AValue;
    CL038_max_age: CL038.PRecord.max_age := AValue;
    CL038_min_age: CL038.PRecord.min_age := AValue;
    CL038_program_group: CL038.PRecord.program_group := AValue;
    CL038_vaccine_code: CL038.PRecord.vaccine_code := AValue;
    CL038_dose_number: CL038.PRecord.dose_number := AValue;
    CL038_Logical: CL038.PRecord.Logical := tlogicalCL038Set(CL038.StrToLogical08(AValue));
  end;
end;

procedure TCL038Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL038: TCL038Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL038 := Items[ARow];
  if not Assigned(CL038.PRecord) then
  begin
    New(CL038.PRecord);
    CL038.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL038Item.TPropertyIndex(ACol) of
      CL038_Key: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_Description: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_DescriptionEn: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_immun_type: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_display_transfered_data: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_cl082: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_max_age: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_min_age: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_program_group: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_vaccine_code: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL038_dose_number: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
    if CL038.PRecord.setProp = [] then
    begin
      Dispose(CL038.PRecord);
      CL038.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
  case TCL038Item.TPropertyIndex(ACol) of
    CL038_Key: CL038.PRecord.Key := AFieldText;
    CL038_Description: CL038.PRecord.Description := AFieldText;
    CL038_DescriptionEn: CL038.PRecord.DescriptionEn := AFieldText;
    CL038_immun_type: CL038.PRecord.immun_type := AFieldText;
    CL038_display_transfered_data: CL038.PRecord.display_transfered_data := AFieldText;
    CL038_cl082: CL038.PRecord.cl082 := AFieldText;
    CL038_max_age: CL038.PRecord.max_age := AFieldText;
    CL038_min_age: CL038.PRecord.min_age := AFieldText;
    CL038_program_group: CL038.PRecord.program_group := AFieldText;
    CL038_vaccine_code: CL038.PRecord.vaccine_code := AFieldText;
    CL038_dose_number: CL038.PRecord.dose_number := AFieldText;
    CL038_Logical: CL038.PRecord.Logical := tlogicalCL038Set(CL038.StrToLogical08(AFieldText));
  end;
end;

procedure TCL038Coll.SetItem(Index: Integer; const Value: TCL038Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL038Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL038Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL038Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL038_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL038Search.Add(self.Items[i]);
  end;
end;
      CL038_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_immun_type:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_display_transfered_data:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_cl082:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_max_age:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_min_age:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_program_group:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_vaccine_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_dose_number:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL038Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL038Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL038Item>);
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

procedure TCL038Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL038Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL038Search.Count]);

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

procedure TCL038Coll.SortByIndexAnsiString;
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

procedure TCL038Coll.SortByIndexInt;
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

procedure TCL038Coll.SortByIndexWord;
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

procedure TCL038Coll.SortByIndexValue(propIndex: TCL038Item.TPropertyIndex);
begin
  case propIndex of
    CL038_Key: SortByIndexAnsiString;
      CL038_Description: SortByIndexAnsiString;
      CL038_DescriptionEn: SortByIndexAnsiString;
      CL038_immun_type: SortByIndexAnsiString;
      CL038_display_transfered_data: SortByIndexAnsiString;
      CL038_cl082: SortByIndexAnsiString;
      CL038_max_age: SortByIndexAnsiString;
      CL038_min_age: SortByIndexAnsiString;
      CL038_program_group: SortByIndexAnsiString;
      CL038_vaccine_code: SortByIndexAnsiString;
      CL038_dose_number: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL038Coll.ImportXMLNzis(cl000: TObject);
var
 Acl000 : TCL000EntryCollection;
 entry : TCL000EntryItem;
 item : TCL038Item;
 i, idxOld, j: Integer;
 idx : array of Integer;
 propIdx: TCL038Item.TPropertyIndex;
 propName, xmlName, oldValue, newValue: string;
 kindDiff: TDiffKind; pCardinalData: PCardinal;
 dataPosition: Cardinal; IsNew: Boolean;
begin
  Acl000 := TCL000EntryCollection(cl000);
  IsNew := Count = 0;

  for i := 0 to Count - 1 do
  begin
    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ctCL038Del) then
      Continue;
    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ctCL038Old);
  end;

  BuildKeyDict(Ord(CL038_Key));

  j := 0;
  SetLength(idx, 0);

  for propIdx := Low(TCL038Item.TPropertyIndex) to High(TCL038Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    if SameText(propName, 'CL038_Key') then Continue;
    if SameText(propName, 'CL038_Description') then Continue;
    if SameText(propName, 'CL038_Logical') then Continue;

    xmlName := propName.Substring(Length('CL038_'));
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
      item := TCL038Item(Add);
      kindDiff := dkNew;
    end;

    if item.PRecord <> nil then
      Dispose(item.PRecord);
    New(item.PRecord);
    item.PRecord.setProp := [];

    newValue := entry.Key;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_Key));
    item.PRecord.Key := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL038_Key);

    newValue := entry.Descr;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_Description));
    item.PRecord.Description := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL038_Description);

    j := 0;
    // DescriptionEn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_DescriptionEn));

      Item.PRecord.DescriptionEn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_DescriptionEn);
    end;
    Inc(j);

    // immun_type
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_immun_type));

      Item.PRecord.immun_type := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_immun_type);
    end;
    Inc(j);

    // display_transfered_data
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_display_transfered_data));

      Item.PRecord.display_transfered_data := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_display_transfered_data);
    end;
    Inc(j);

    // cl082
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_cl082));

      Item.PRecord.cl082 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_cl082);
    end;
    Inc(j);

    // max_age
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_max_age));

      Item.PRecord.max_age := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_max_age);
    end;
    Inc(j);

    // min_age
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_min_age));

      Item.PRecord.min_age := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_min_age);
    end;
    Inc(j);

    // program_group
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_program_group));

      Item.PRecord.program_group := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_program_group);
    end;
    Inc(j);

    // vaccine_code
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_vaccine_code));

      Item.PRecord.vaccine_code := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_vaccine_code);
    end;
    Inc(j);

    // dose_number
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL038_dose_number));

      Item.PRecord.dose_number := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL038_dose_number);
    end;
    Inc(j);

    // NEW
    if kindDiff = dkNew then
    begin
      if IsNew then
      begin
        item.InsertCL038;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL038);
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
          item.SaveCL038(dataPosition);
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL038);
          Self.streamComm.Len := Self.streamComm.Size;
          Self.cmdFile.CopyFrom(Self.streamComm, 0);
          pCardinalData^ := dataPosition - PosData;
        end
        else
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL038);
      end
      else
      begin
        Dispose(item.PRecord);
        item.PRecord := nil;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL038);
      end;
    end;
  end;
end;

procedure TCL038Coll.UpdateXMLNzis;
var
  i: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].PRecord = nil then
    begin
      if Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ = ord(ctCL038Old) then
        Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ := ord(ctCL038Del);
        Continue;
    end;


    if Items[i].DataPos = 0 then
    begin
      Items[i].InsertCL038;
      Self.streamComm.Len := Self.streamComm.Size;
      Self.cmdFile.CopyFrom(Self.streamComm, 0);
      Dispose(Items[i].PRecord);
      Items[i].PRecord := nil;
    end
    else
    begin
      pCardinalData := pointer(PByte(self.Buf) + 12);
      dataPosition := pCardinalData^ + self.PosData;
      Items[i].SaveCL038(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      pCardinalData := pointer(PByte(Buf) + 12);
      pCardinalData^  := dataPosition - self.PosData;
    end;

  end;
end;

procedure TCL038Coll.BuildKeyDict(PropIndex: Word);
var
  i      : Integer;
  item   : TCL038Item;
  keyStr : string;
  pIdx   : TCL038Item.TPropertyIndex;
begin
  // общата част – алокация / чистене на речника
  inherited BuildKeyDict(PropIndex);

  // кастваме Word > enum на генерирания клас
  pIdx := TCL038Item.TPropertyIndex(PropIndex);

  for i := 0 to Count - 1 do
  begin
    item := Items[i];
    if Pword(PByte(Buf) + item.DataPos +  - 4)^ = ord(ctCL038Del) then
      Continue;
    keyStr := self.getAnsiStringMap(item.datapos,PropIndex);

    if keyStr <> '' then
    begin
      // ако има дубликати – последният печели (полезно за "последна версия")
      KeyDict.AddOrSetValue(keyStr, i);
    end;
  end;
end;

function TCL038Coll.CellDiffKind(ACol, ARow: Integer): TDiffKind;
begin
  if (ARow > count) or (ARow < 0) then
    Exit;


  if items[ARow].DataPos = 0 then
  begin
    Result := dkNew;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL038Old)) then
  begin
    Result := dkForDeleted;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL038Del)) then
  begin
    Result := dkDeleted;
    Exit;
  end;

  if Items[ARow].PRecord = nil then
  begin
    Result := dkNone;
    Exit;
  end;

  if TCL038Item.TPropertyIndex(ACol) in Items[ARow].PRecord.setProp then
  begin
    Result := dkChanged;
    Exit;
  end;
  //test

end;

{NZIS_END}

end.