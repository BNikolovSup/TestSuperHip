unit Table.Doctor;

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

TLogicalDoctor = (
    DOC_ACTIVE,
    DOG_RZOK,
    IS_DOGOVOR_NEOTLOGNA,
    IS_EGN,
    IS_EMERGENCY_CENTER,
    IS_NAET,
    IS_PODVIZHNO_LZ,
    IS_ZAMESTVASHT,
    IS_);
TlogicalDoctorSet = set of TLogicalDoctor;


TDoctorItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       Doctor_EGN
       , Doctor_FNAME
       , Doctor_ID
       , Doctor_LNAME
       , Doctor_SNAME
       , Doctor_UIN
       , Doctor_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecDoctor = ^TRecDoctor;
      TRecDoctor = record
        EGN: AnsiString;
        FNAME: AnsiString;
        ID: integer;
        LNAME: AnsiString;
        SNAME: AnsiString;
        UIN: AnsiString;
        Logical: TlogicalDoctorSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecDoctor;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertDoctor;
    procedure UpdateDoctor;
    procedure SaveDoctor(var dataPosition: Cardinal)overload;
	procedure SaveDoctor(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  procedure InsertDoctorToRole(ADBStream: TFileStream; var OtherDataPos: Cardinal);
  procedure AppendInsertDoctorCmdToRole(CmdStreamRole: TFileStream;NewDoctorDataPos: Cardinal);
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropDoctor(propindex: TPropertyIndex; stream: TStream);
  end;


  TDoctorColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TDoctorItem;
    function GetItem(Index: Integer): TDoctorItem;
    procedure SetItem(Index: Integer; const Value: TDoctorItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TDoctorItem>;
    ListDoctorSearch: TList<TDoctorItem>;
	PRecordSearch: ^TDoctorItem.TRecDoctor;
    ArrPropSearch: TArray<TDoctorItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TDoctorItem.TPropertyIndex>;
	VisibleColl: TDoctorItem.TSetProp;
	ArrayPropOrder: TArray<TDoctorItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TDoctorItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Doctor: TDoctorItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Doctor: TDoctorItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TDoctorItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TDoctorItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TDoctorItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TDoctorItem.TPropertyIndex);
    property Items[Index: Integer]: TDoctorItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalDoctorSet);
	procedure CheckForSave(var cnt: Integer); override;
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TDoctorItem }

constructor TDoctorItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TDoctorItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TDoctorItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TDoctorItem.GetCollType: TCollectionsType;
begin
  Result := ctDoctor;
end;

function TDoctorItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TDoctorItem.InsertDoctorToRole(ADBStream: TFileStream; var OtherDataPos: Cardinal);
var
  CollType: Word;
  metaPosition, dataPosition: Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  buf: Cardinal;
  propIndx: TPropertyIndex;
begin
  // 1. Четем header
  ADBStream.Seek(0, soBeginning);
  ADBStream.ReadBuffer(FPosMetaData, 4);
  ADBStream.ReadBuffer(FLenMetaData, 4);
  ADBStream.ReadBuffer(FPosData, 4);
  ADBStream.ReadBuffer(FLenData, 4);

  metaPosition := FPosMetaData + FLenMetaData;
  dataPosition := FPosData + FLenData;

  // 2. Записваме тип + версия
  CollType := Word(ctDoctor);
  ADBStream.Seek(metaPosition, soBeginning);
  ADBStream.WriteBuffer(CollType, 2);
  ADBStream.WriteBuffer(FVersion, 2);
  Inc(metaPosition, 4);

  // 3. Това е DataPos на доктора
  OtherDataPos := metaPosition; // ==> 104

  for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
begin
  if Assigned(PRecord) and (propIndx in PRecord.setProp) then
  begin
   // SaveHeaderDataToFile(ADBStream, PropPosition, dataPosition, Self.DataPos);

    case propIndx of
      Doctor_EGN:
        SaveDataToFile(PRecord.EGN, metaPosition, dataPosition, ADBStream, FPosData);
      Doctor_FNAME:
        SaveDataToFile(PRecord.FNAME, metaPosition, dataPosition, ADBStream, FPosData);
    end;
  end
  else
    SaveNullToFile(ADBStream, metaPosition);
end;


  // 5. Обновяваме header дължините
  ADBStream.Seek(4, soBeginning);
  buf :=  metaPosition - FPosMetaData;
  ADBStream.WriteBuffer(buf, 4);

  ADBStream.Seek(12, soBeginning);
  buf :=  dataPosition - FPosData;
  ADBStream.WriteBuffer(buf, 4);
end;

procedure TDoctorItem.AppendInsertDoctorCmdToRole(
  CmdStreamRole: TFileStream;
  NewDoctorDataPos: Cardinal
);
var
  Props: TLogicalData16;
  LenPos: Int64;
  RecStart: Int64;
  RecEnd: Int64;
  RecLen: Word;
begin
  // 1) Props bitmap: само Doctor_EGN
  //Props := [];
//  Include(Props, Ord(Doctor_EGN)); // ако Doctor_EGN е enum 0..N
//
//  // 2) Пишем header + props
//  RecStart := CmdStreamRole.Position;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), ctDoctor, toInsert, FVersion, NewDoctorDataPos);
  SaveStringForCmdFile(PRecord.EGN);
  TBaseCollection(Collection).streamComm.Len := TBaseCollection(Collection).streamComm.Size;
  CmdStreamRole.Seek(0, soEnd);
  CmdStreamRole.CopyFrom(TBaseCollection(Collection).streamComm, 0);

  //WriteCmdHeaderToFile_Props16(
//    CmdStreamRole,
//    ctDoctor,
//    toInsert,
//    FVersion,
//    NewDoctorDataPos,
//    Props,
//    LenPos
//  );

  // 3) Payload (само EGN)
  //SaveStringToCmdFile(CmdStreamRole, PRecord.EGN);

  // 4) Backpatch Len
  //RecEnd := CmdStreamRole.Position;
//  RecLen := Word(RecEnd - RecStart);
//  PatchCmdRecordLen(CmdStreamRole, LenPos, RecLen);
end;




procedure TDoctorItem.InsertDoctor;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDoctor;
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
            Doctor_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Doctor_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Doctor_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Doctor_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Doctor_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Doctor_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            Doctor_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TDoctorItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TDoctorItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TDoctorItem;
begin
  Result := True;
  for i := 0 to Length(TDoctorColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TDoctorColl(coll).ArrPropSearchClc[i];
	ATempItem := TDoctorColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Doctor_EGN: Result := IsFinded(ATempItem.PRecord.EGN, buf, FPosDataADB, word(Doctor_EGN), cot);
            Doctor_FNAME: Result := IsFinded(ATempItem.PRecord.FNAME, buf, FPosDataADB, word(Doctor_FNAME), cot);
            Doctor_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(Doctor_ID), cot);
            Doctor_LNAME: Result := IsFinded(ATempItem.PRecord.LNAME, buf, FPosDataADB, word(Doctor_LNAME), cot);
            Doctor_SNAME: Result := IsFinded(ATempItem.PRecord.SNAME, buf, FPosDataADB, word(Doctor_SNAME), cot);
            Doctor_UIN: Result := IsFinded(ATempItem.PRecord.UIN, buf, FPosDataADB, word(Doctor_UIN), cot);
            Doctor_Logical: Result := IsFinded(TLogicalData16(ATempItem.PRecord.Logical), buf, FPosDataADB, word(Doctor_Logical), cot);
      end;
    end;
  end;
end;

procedure TDoctorItem.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds08: TLogicalData08;
  propindexDoctor: TDoctorItem.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData08);
  stream.Read(flds08, sizeof(TLogicalData08));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TDoctorItem.TSetProp(flds08);// тука се записва какво има като полета


  for propindexDoctor := Low(TDoctorItem.TPropertyIndex) to High(TDoctorItem.TPropertyIndex) do
  begin
    if not (propindexDoctor in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexDoctor);
      dataCmdProp.vid := vvDoctor;
    end;
    self.FillPropDoctor(propindexDoctor, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TDoctorItem.FillPropDoctor(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    Doctor_EGN:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.EGN, lenStr);
          stream.Read(Self.PRecord.EGN[1], lenStr);
        end;
            Doctor_FNAME:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.FNAME, lenStr);
              stream.Read(Self.PRecord.FNAME[1], lenStr);
            end;
            Doctor_ID: stream.Read(Self.PRecord.ID, SizeOf(Integer));
            Doctor_LNAME:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.LNAME, lenStr);
              stream.Read(Self.PRecord.LNAME[1], lenStr);
            end;
            Doctor_SNAME:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.SNAME, lenStr);
              stream.Read(Self.PRecord.SNAME[1], lenStr);
            end;
            Doctor_UIN:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.UIN, lenStr);
              stream.Read(Self.PRecord.UIN[1], lenStr);
            end;
            Doctor_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData16));
  end;
end;

procedure TDoctorItem.SaveDoctor(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveDoctor(dataPosition);
end;

procedure TDoctorItem.SaveDoctor(var dataPosition: Cardinal);
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
            Doctor_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Doctor_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Doctor_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Doctor_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Doctor_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Doctor_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            Doctor_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TDoctorItem.UpdateDoctor;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDoctor;
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
            Doctor_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Doctor_FNAME: UpdateData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Doctor_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Doctor_LNAME: UpdateData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Doctor_SNAME: UpdateData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Doctor_UIN: UpdateData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
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

{ TDoctorColl }

function TDoctorColl.AddItem(ver: word): TDoctorItem;
begin
  Result := TDoctorItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TDoctorColl.AddItemForSearch: Integer;
var
  ItemForSearch: TDoctorItem;
begin
  ItemForSearch := TDoctorItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TDoctorColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TDoctorItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TDoctorColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvDoctorRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TDoctorColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TDoctorItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (Doctor_EGN in tempItem.PRecord.setProp) and (tempItem.PRecord.EGN <> Self.getAnsiStringMap(tempItem.DataPos, word(Doctor_EGN))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Doctor_FNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.FNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(Doctor_FNAME))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Doctor_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(Doctor_ID))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Doctor_LNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.LNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(Doctor_LNAME))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Doctor_SNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.SNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(Doctor_SNAME))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Doctor_UIN in tempItem.PRecord.setProp) and (tempItem.PRecord.UIN <> Self.getAnsiStringMap(tempItem.DataPos, word(Doctor_UIN))) then
      begin
        inc(cnt);
        exit;
      end;

      if (Doctor_Logical in tempItem.PRecord.setProp) and (TLogicalData16(tempItem.PRecord.Logical) <> Self.getLogical16Map(tempItem.DataPos, word(Doctor_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TDoctorColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TDoctorItem.Create(nil);
  ListDoctorSearch := TList<TDoctorItem>.Create;
  ListForFinder := TList<TDoctorItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TDoctorColl.destroy;
begin
  FreeAndNil(ListDoctorSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TDoctorColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: Result := 'EGN';
    Doctor_FNAME: Result := 'FNAME';
    Doctor_ID: Result := 'ID';
    Doctor_LNAME: Result := 'LNAME';
    Doctor_SNAME: Result := 'SNAME';
    Doctor_UIN: Result := 'UIN';
    Doctor_Logical: Result := 'Logical';
  end;
end;

function TDoctorColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'DOC_ACTIVE';
    1: Result := 'DOG_RZOK';
    2: Result := 'IS_DOGOVOR_NEOTLOGNA';
    3: Result := 'IS_EGN';
    4: Result := 'IS_EMERGENCY_CENTER';
    5: Result := 'IS_NAET';
    6: Result := 'IS_PODVIZHNO_LZ';
    7: Result := 'IS_ZAMESTVASHT';
    8: Result := 'IS_';
  else
    Result := '???';
  end;
end;


procedure TDoctorColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TDoctorColl.FieldCount: Integer; 
begin
  inherited;
  Result := 7;
end;

function TDoctorColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvDoctorRoot then
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

function TDoctorColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TDoctorColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TDoctorColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TDoctorColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Doctor: TDoctorItem;
  ACol: Integer;
  prop: TDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Doctor := Items[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(Doctor.PRecord) and (prop in Doctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Doctor, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Doctor, AValue);
  end;
end;

procedure TDoctorColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TDoctorItem.TPropertyIndex;
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

procedure TDoctorColl.GetCellFromRecord(propIndex: word; Doctor: TDoctorItem; var AValue: String);
var
  str: string;
begin
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: str := (Doctor.PRecord.EGN);
    Doctor_FNAME: str := (Doctor.PRecord.FNAME);
    Doctor_ID: str := inttostr(Doctor.PRecord.ID);
    Doctor_LNAME: str := (Doctor.PRecord.LNAME);
    Doctor_SNAME: str := (Doctor.PRecord.SNAME);
    Doctor_UIN: str := (Doctor.PRecord.UIN);
    Doctor_Logical: str := Doctor.Logical16ToStr(TLogicalData16(Doctor.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TDoctorColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TDoctorItem;
  ACol: Integer;
  prop: TDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TDoctorColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TDoctorItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TDoctorItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TDoctorColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Doctor: TDoctorItem;
  ACol: Integer;
  prop: TDoctorItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Doctor := ListDoctorSearch[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(Doctor.PRecord) and (prop in Doctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Doctor, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Doctor, AValue);
  end;
end;

function TDoctorColl.GetCollType: TCollectionsType;
begin
  Result := ctDoctor;
end;

function TDoctorColl.GetCollDelType: TCollectionsType;
begin
  Result := ctDoctorDel;
end;

procedure TDoctorColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Doctor: TDoctorItem;
  prop: TDoctorItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Doctor := Items[ARow];
  prop := TDoctorItem.TPropertyIndex(ACol);
  if Assigned(Doctor.PRecord) and (prop in Doctor.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Doctor, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Doctor, AFieldText);
  end;
end;

procedure TDoctorColl.GetCellFromMap(propIndex: word; ARow: Integer; Doctor: TDoctorItem; var AValue: String);
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
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_FNAME: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_ID: str :=  inttostr(Doctor.getIntMap(Self.Buf, Self.posData, propIndex));
    Doctor_LNAME: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_SNAME: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_UIN: str :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Doctor_Logical: str :=  Doctor.Logical16ToStr(Doctor.getLogical16Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TDoctorColl.GetItem(Index: Integer): TDoctorItem;
begin
  Result := TDoctorItem(inherited GetItem(Index));
end;


procedure TDoctorColl.IndexValue(propIndex: TDoctorItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TDoctorItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Doctor_EGN:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Doctor_FNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Doctor_LNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_SNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Doctor_UIN:
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

procedure TDoctorColl.IndexValueListNodes(propIndex: TDoctorItem.TPropertyIndex);
begin

end;

function TDoctorColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TDoctorItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TDoctorColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TDoctorItem;
begin
  if index < 0 then
  begin
    Tempitem := TDoctorItem.Create(nil);
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
procedure TDoctorColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TDoctorItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TDoctorItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TDoctorItem.TPropertyIndex(Field) of
Doctor_EGN: ListForFinder[0].PRecord.EGN := AText;
    Doctor_FNAME: ListForFinder[0].PRecord.FNAME := AText;
    Doctor_LNAME: ListForFinder[0].PRecord.LNAME := AText;
    Doctor_SNAME: ListForFinder[0].PRecord.SNAME := AText;
    Doctor_UIN: ListForFinder[0].PRecord.UIN := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TDoctorColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TDoctorItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TDoctorColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TDoctorItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
case TDoctorItem.TPropertyIndex(Field) of
    Doctor_ID: ListForFinder[0].PRecord.ID := Value;
    end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TDoctorColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TDoctorItem.TPropertyIndex(Field) of
    Doctor_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalDoctor(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalDoctor(logIndex))   
    end;
  end;
end;


procedure TDoctorColl.OnSetTextSearchLog(Log: TlogicalDoctorSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TDoctorColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TDoctorColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TDoctorItem.TPropertyIndex(propIndex) of
    Doctor_EGN: Result := actAnsiString;
    Doctor_FNAME: Result := actAnsiString;
    Doctor_ID: Result := actinteger;
    Doctor_LNAME: Result := actAnsiString;
    Doctor_SNAME: Result := actAnsiString;
    Doctor_UIN: Result := actAnsiString;
    Doctor_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TDoctorColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TDoctorColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Doctor: TDoctorItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  Doctor := Items[ARow];
  if not Assigned(Doctor.PRecord) then
  begin
    New(Doctor.PRecord);
    Doctor.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TDoctorItem.TPropertyIndex(ACol) of
      Doctor_EGN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Doctor_FNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Doctor_ID: isOld :=  Doctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Doctor_LNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Doctor_SNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Doctor_UIN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
    if Doctor.PRecord.setProp = [] then
    begin
      Dispose(Doctor.PRecord);
      Doctor.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
  case TDoctorItem.TPropertyIndex(ACol) of
    Doctor_EGN: Doctor.PRecord.EGN := AValue;
    Doctor_FNAME: Doctor.PRecord.FNAME := AValue;
    Doctor_ID: Doctor.PRecord.ID := StrToInt(AValue);
    Doctor_LNAME: Doctor.PRecord.LNAME := AValue;
    Doctor_SNAME: Doctor.PRecord.SNAME := AValue;
    Doctor_UIN: Doctor.PRecord.UIN := AValue;
    Doctor_Logical: Doctor.PRecord.Logical := tlogicalDoctorSet(Doctor.StrToLogical16(AValue));
  end;
end;

procedure TDoctorColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Doctor: TDoctorItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  Doctor := Items[ARow];
  if not Assigned(Doctor.PRecord) then
  begin
    New(Doctor.PRecord);
    Doctor.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TDoctorItem.TPropertyIndex(ACol) of
      Doctor_EGN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_FNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_ID: isOld :=  Doctor.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Doctor_LNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_SNAME: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Doctor_UIN: isOld :=  Doctor.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
    if Doctor.PRecord.setProp = [] then
    begin
      Dispose(Doctor.PRecord);
      Doctor.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Doctor.PRecord.setProp, TDoctorItem.TPropertyIndex(ACol));
  case TDoctorItem.TPropertyIndex(ACol) of
    Doctor_EGN: Doctor.PRecord.EGN := AFieldText;
    Doctor_FNAME: Doctor.PRecord.FNAME := AFieldText;
    Doctor_ID: Doctor.PRecord.ID := StrToInt(AFieldText);
    Doctor_LNAME: Doctor.PRecord.LNAME := AFieldText;
    Doctor_SNAME: Doctor.PRecord.SNAME := AFieldText;
    Doctor_UIN: Doctor.PRecord.UIN := AFieldText;
    Doctor_Logical: Doctor.PRecord.Logical := tlogicalDoctorSet(Doctor.StrToLogical16(AFieldText));
  end;
end;

procedure TDoctorColl.SetItem(Index: Integer; const Value: TDoctorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDoctorColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListDoctorSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TDoctorItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Doctor_EGN:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListDoctorSearch.Add(self.Items[i]);
  end;
end;
      Doctor_FNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_LNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_SNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
      Doctor_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDoctorSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TDoctorColl.ShowGrid(Grid: TTeeGrid);
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

procedure TDoctorColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TDoctorItem>);
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

procedure TDoctorColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDoctorSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDoctorSearch.Count]);

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

procedure TDoctorColl.SortByIndexAnsiString;
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

procedure TDoctorColl.SortByIndexInt;
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

procedure TDoctorColl.SortByIndexWord;
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

procedure TDoctorColl.SortByIndexValue(propIndex: TDoctorItem.TPropertyIndex);
begin
  case propIndex of
    Doctor_EGN: SortByIndexAnsiString;
      Doctor_FNAME: SortByIndexAnsiString;
      Doctor_ID: SortByIndexInt;
      Doctor_LNAME: SortByIndexAnsiString;
      Doctor_SNAME: SortByIndexAnsiString;
      Doctor_UIN: SortByIndexAnsiString;
  end;
end;


end.