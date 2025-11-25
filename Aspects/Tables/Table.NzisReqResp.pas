unit Table.NzisReqResp;//birthDate

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults,
  RealObj.RealHipp, RealNasMesto,
  Table.PatientNew, Table.PregledNew
  ;



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

TLogicalNzisReqResp = (
    Is_X,
    Is_R,
    Is_P,
    Is_I,
    Is_H,
    Is_C);
TlogicalNzisReqRespSet = set of TLogicalNzisReqResp;


TNzisReqRespItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       NzisReqResp_REQ
       , NzisReqResp_RESP
       , NzisReqResp_messageId
       , NzisReqResp_msgNom
       , NzisReqResp_patEgn
       , NzisReqResp_LRN
       , NzisReqResp_NRN
       , NzisReqResp_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecNzisReqResp = ^TRecNzisReqResp;
      TRecNzisReqResp = record
        REQ: AnsiString;
        RESP: AnsiString;
        messageId: AnsiString;
        msgNom: Word;
        patEgn: AnsiString;
        LRN: AnsiString;
        NRN: AnsiString;
        BaseOn: AnsiString;
        category: AnsiString;
        Logical: TlogicalNzisReqRespSet;
        setProp: TSetProp;
      end;
  private
    FNode: PVirtualNode;
    FNomMsg: Byte;
    FPat: TRealPatientNewItem;
    FPreg: TRealPregledNewItem;
    FMdn: TRealMDNItem;
    F: TRealINC_NAPRItem;
    FIncMN: TRealINC_NAPRItem;
    FMN: TRealBLANKA_MED_NAPRItem;
    FMN3: TRealBLANKA_MED_NAPR_3AItem;
    FMNHosp: TRealHOSPITALIZATIONItem;
    FMNLkk: TRealEXAM_LKKItem;

  public
    FIncMns: TList<TRealINC_NAPRItem>;
    PRecord: ^TRecNzisReqResp;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNzisReqResp;
    procedure UpdateNzisReqResp;
    procedure SaveNzisReqResp(var dataPosition: Cardinal)overload;
	procedure SaveNzisReqResp(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  property Node: PVirtualNode read FNode write FNode;
  property Pat: TRealPatientNewItem read FPat write Fpat;
  property Preg: TRealPregledNewItem read FPreg write FPreg;
  property Mdn: TRealMDNItem read FMdn write FMdn;
  property IncMN: TRealINC_NAPRItem read FIncMN write FIncMN;
  property MN: TRealBLANKA_MED_NAPRItem read FMN write FMN;
  property MN3: TRealBLANKA_MED_NAPR_3AItem read FMN3 write FMN3;
  property MNHosp: TRealHOSPITALIZATIONItem read FMNHosp write FMNHosp;
  property MNLkk: TRealEXAM_LKKItem read FMNLkk write FMNLkk;
  end;


  TNzisReqRespColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TNzisReqRespItem;
    function GetItem(Index: Integer): TNzisReqRespItem;
    procedure SetItem(Index: Integer; const Value: TNzisReqRespItem);
    procedure SetSearchingValue(const Value: string);
  public
    CollPat: TRealPatientNewColl;
    CollDoctor: TRealDoctorColl;
    collAddres: TRealAddresColl;
    CollPreg: TRealPregledNewColl;
    collDiag: TRealDiagnosisColl;
    CollMdn: TRealMDNColl;
    CollMN: TRealBLANKA_MED_NAPRColl;
    CollMN3: TRealBLANKA_MED_NAPR_3AColl;
    CollMnExpert: TRealEXAM_LKKColl;
    CollMnHosp: TRealHOSPITALIZATIONColl;
    CollIncMN: TRealINC_NAPRColl;
    CollIncDoc: TRealOtherDoctorColl;

    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TNzisReqRespItem>;
    ListNzisReqRespSearch: TList<TNzisReqRespItem>;
	PRecordSearch: ^TNzisReqRespItem.TRecNzisReqResp;
    ArrPropSearch: TArray<TNzisReqRespItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNzisReqRespItem.TPropertyIndex>;
	ArrayPropOrder: TArray<TNzisReqRespItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNzisReqRespItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NzisReqResp: TNzisReqRespItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NzisReqResp: TNzisReqRespItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNzisReqRespItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
  procedure SortByMessageId;
  procedure SortByMessageId_nom;
  procedure SortByPatEgn;
  procedure SortByNrn;
  procedure SortListByNRN(lst: TList<TNzisReqRespItem>);
  //procedure SortListBy
  procedure SortLstNrn(lst: TList<string>);
  procedure SortListByEGN(lst: TList<TNzisReqRespItem>);
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch(Grid: TTeeGrid);override;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNzisReqRespItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNzisReqRespItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNzisReqRespItem.TPropertyIndex);
    property Items[Index: Integer]: TNzisReqRespItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchLog(Log: TlogicalNzisReqRespSet);
  end;

implementation

{ TNzisReqRespItem }

constructor TNzisReqRespItem.Create(Collection: TCollection);
begin
  inherited;
  FIncMns := TList<TRealINC_NAPRItem>.create;
  Node := nil;
  FPat := nil;
  FPreg := nil;
end;

destructor TNzisReqRespItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  FreeAndNil(FIncMns);
  inherited;
end;

procedure TNzisReqRespItem.InsertNzisReqResp;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNzisReqResp;
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
            NzisReqResp_REQ: SaveData(PRecord.REQ, PropPosition, metaPosition, dataPosition);
            NzisReqResp_RESP: SaveData(PRecord.RESP, PropPosition, metaPosition, dataPosition);
            NzisReqResp_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TNzisReqRespItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNzisReqRespItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNzisReqRespItem;
begin
  Result := True;
  for i := 0 to Length(TNzisReqRespColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNzisReqRespColl(coll).ArrPropSearchClc[i];
	ATempItem := TNzisReqRespColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NzisReqResp_REQ: Result := IsFinded(ATempItem.PRecord.REQ, buf, FPosDataADB, word(NzisReqResp_REQ), cot);
            NzisReqResp_RESP: Result := IsFinded(ATempItem.PRecord.RESP, buf, FPosDataADB, word(NzisReqResp_RESP), cot);
            NzisReqResp_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(NzisReqResp_Logical), cot);
      end;
    end;
  end;
end;

procedure TNzisReqRespItem.SaveNzisReqResp(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveNzisReqResp(dataPosition);
end;

procedure TNzisReqRespItem.SaveNzisReqResp(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNzisReqResp;
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
            NzisReqResp_REQ: SaveData(PRecord.REQ, PropPosition, metaPosition, dataPosition);
            NzisReqResp_RESP: SaveData(PRecord.RESP, PropPosition, metaPosition, dataPosition);
            NzisReqResp_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TNzisReqRespItem.UpdateNzisReqResp;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNzisReqResp;
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
            NzisReqResp_REQ: UpdateData(PRecord.REQ, PropPosition, metaPosition, dataPosition);
            NzisReqResp_RESP: UpdateData(PRecord.RESP, PropPosition, metaPosition, dataPosition);
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

{ TNzisReqRespColl }

function TNzisReqRespColl.AddItem(ver: word): TNzisReqRespItem;
begin
  Result := TNzisReqRespItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNzisReqRespColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNzisReqRespItem;
begin
  ItemForSearch := TNzisReqRespItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

function TNzisReqRespColl.CreateRootCollOptionNode(): PVirtualNode;
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

constructor TNzisReqRespColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TNzisReqRespItem.Create(nil);
  ListNzisReqRespSearch := TList<TNzisReqRespItem>.Create;
  ListForFinder := TList<TNzisReqRespItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrder, FieldCount);
  SetLength(ArrayPropOrderSearchOptions, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrayPropOrder[i] := TNzisReqRespItem.TPropertyIndex(i);
    ArrayPropOrderSearchOptions[i] := i;
  end;
  CollPat := TRealPatientNewColl.Create(TRealPatientNewItem);
  //CollDoctor := TRealDoctorColl.Create(TRealDoctorItem);
  collAddres := TRealAddresColl.Create(TRealAddresItem);
  CollPreg := TRealPregledNewColl.Create(TRealPregledNewItem);
  CollMdn := TRealMDNColl.Create(TRealMDNItem);
  CollIncMN := TRealINC_NAPRColl.Create(TRealINC_NAPRItem);
  CollIncDoc := TRealOtherDoctorColl.Create(TRealOtherDoctorItem);
  collDiag := TRealDiagnosisColl.Create(TRealDiagnosisItem);
  CollMN := TRealBLANKA_MED_NAPRColl.create(TRealBLANKA_MED_NAPRItem);
  CollMN3 := TRealBLANKA_MED_NAPR_3AColl.Create(TRealBLANKA_MED_NAPR_3AItem);
  CollMnExpert := TRealEXAM_LKKColl.Create(TRealEXAM_LKKItem);
  CollMnHosp := TRealHOSPITALIZATIONColl.Create(TRealHOSPITALIZATIONItem);
end;

destructor TNzisReqRespColl.destroy;
begin
  FreeAndNil(ListNzisReqRespSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  FreeAndNil(CollPat);
  //FreeAndNil(CollDoctor);
  FreeAndNil(collAddres);
  FreeAndNil(CollPreg);
  FreeAndNil(CollMdn);
  FreeAndNil(CollIncMN);
  FreeAndNil(CollIncDoc);
  FreeAndNil(collDiag);
  FreeAndNil(CollMN);
  FreeAndNil(CollMN3);
  FreeAndNil(CollMnExpert);
  FreeAndNil(CollMnHosp);

  Dispose(PRecordSearch);
  PRecordSearch := nil;

  inherited;
end;

function TNzisReqRespColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNzisReqRespItem.TPropertyIndex(propIndex) of
    NzisReqResp_REQ: Result := 'REQ';
    NzisReqResp_RESP: Result := 'RESP';
    NzisReqResp_Logical: Result := 'Logical';
  end;
end;

procedure TNzisReqRespColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


procedure TNzisReqRespColl.SortLstNrn(lst: TList<string>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : string;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while lst[I] < lst[P] do Inc(I);
        while lst[J] > lst[P] do Dec(J);
        if I <= J then begin
          Save := lst[I];
          lst[I] := lst[J];
          lst[J] := Save;
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
  if (lst.count >1 ) then
  begin
    QuickSort(0,lst.count-1);
  end;
end;

function TNzisReqRespColl.FieldCount: Integer;
begin
  inherited;
  Result := 3;
end;

function TNzisReqRespColl.FindRootCollOptionNode(): PVirtualNode;
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

function TNzisReqRespColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TNzisReqRespColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TNzisReqRespColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TNzisReqRespColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NzisReqResp: TNzisReqRespItem;
  ACol: Integer;
  prop: TNzisReqRespItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NzisReqResp := Items[ARow];
  prop := TNzisReqRespItem.TPropertyIndex(ACol);
  if Assigned(NzisReqResp.PRecord) and (prop in NzisReqResp.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NzisReqResp, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NzisReqResp, AValue);
  end;
end;

procedure TNzisReqRespColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol, RowSelect: Integer;
  prop: TNzisReqRespItem.TPropertyIndex;
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

procedure TNzisReqRespColl.GetCellFromRecord(propIndex: word; NzisReqResp: TNzisReqRespItem; var AValue: String);
var
  str: string;
begin
  case TNzisReqRespItem.TPropertyIndex(propIndex) of
    NzisReqResp_REQ: str := (NzisReqResp.PRecord.REQ);
    NzisReqResp_RESP: str := (NzisReqResp.PRecord.RESP);
    NzisReqResp_Logical: str := NzisReqResp.Logical08ToStr(TLogicalData08(NzisReqResp.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNzisReqRespColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNzisReqRespItem;
  ACol: Integer;
  prop: TNzisReqRespItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TNzisReqRespItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNzisReqRespColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNzisReqRespItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNzisReqRespItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNzisReqRespColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NzisReqResp: TNzisReqRespItem;
  ACol: Integer;
  prop: TNzisReqRespItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NzisReqResp := ListNzisReqRespSearch[ARow];
  prop := TNzisReqRespItem.TPropertyIndex(ACol);
  if Assigned(NzisReqResp.PRecord) and (prop in NzisReqResp.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NzisReqResp, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NzisReqResp, AValue);
  end;
end;

procedure TNzisReqRespColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NzisReqResp: TNzisReqRespItem;
  prop: TNzisReqRespItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NzisReqResp := Items[ARow];
  prop := TNzisReqRespItem.TPropertyIndex(ACol);
  if Assigned(NzisReqResp.PRecord) and (prop in NzisReqResp.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NzisReqResp, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NzisReqResp, AFieldText);
  end;
end;

procedure TNzisReqRespColl.GetCellFromMap(propIndex: word; ARow: Integer; NzisReqResp: TNzisReqRespItem; var AValue: String);
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
  case TNzisReqRespItem.TPropertyIndex(propIndex) of
    NzisReqResp_REQ: str :=  NzisReqResp.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NzisReqResp_RESP: str :=  NzisReqResp.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NzisReqResp_Logical: str :=  NzisReqResp.Logical16ToStr(NzisReqResp.getLogical16Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNzisReqRespColl.GetItem(Index: Integer): TNzisReqRespItem;
begin
  Result := TNzisReqRespItem(inherited GetItem(Index));
end;


procedure TNzisReqRespColl.IndexValue(propIndex: TNzisReqRespItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNzisReqRespItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NzisReqResp_REQ:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NzisReqResp_RESP:
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

procedure TNzisReqRespColl.IndexValueListNodes(propIndex: TNzisReqRespItem.TPropertyIndex);
begin

end;

procedure TNzisReqRespColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNzisReqRespItem;
begin
  if index < 0 then
  begin
    Tempitem := TNzisReqRespItem.Create(nil);
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





procedure TNzisReqRespColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TNzisReqRespItem.TPropertyIndex(Field));
  end
  else
  begin
    include(ListForFinder[0].PRecord.setProp, TNzisReqRespItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  if cotSens in Condition then
  begin
    case TNzisReqRespItem.TPropertyIndex(Field) of
      NzisReqResp_REQ: ListForFinder[0].PRecord.REQ  := Text;
      NzisReqResp_RESP: ListForFinder[0].PRecord.RESP  := Text;
      //NzisReqResp_BIRTH_DATE: ListForFinder[0].PRecord.BIRTH_DATE  := StrToInt(Text);
    end;
  end
  else
  begin
    case TNzisReqRespItem.TPropertyIndex(Field) of
      NzisReqResp_REQ: ListForFinder[0].PRecord.REQ  := AnsiUpperCase(Text);
      NzisReqResp_RESP: ListForFinder[0].PRecord.RESP  := AnsiUpperCase(Text);
      //NzisReqResp_BIRTH_DATE: ListForFinder[0].PRecord.BIRTH_DATE  := StrToInt(Text);
    end;
  end;
end;

procedure TNzisReqRespColl.OnSetTextSearchLog(Log: TlogicalNzisReqRespSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TNzisReqRespColl.OrderFieldsSearch(Grid: TTeeGrid);
begin
  inherited;
  //
end;

procedure TNzisReqRespColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TNzisReqRespColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNzisReqRespItem.TPropertyIndex(propIndex) of
    NzisReqResp_REQ: Result := actAnsiString;
    NzisReqResp_RESP: Result := actAnsiString;
    NzisReqResp_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TNzisReqRespColl.RankSortOption(propIndex: Word): cardinal;
begin

end;

procedure TNzisReqRespColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NzisReqResp: TNzisReqRespItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  NzisReqResp := Items[ARow];
  if not Assigned(NzisReqResp.PRecord) then
  begin
    New(NzisReqResp.PRecord);
    NzisReqResp.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNzisReqRespItem.TPropertyIndex(ACol) of
      NzisReqResp_REQ: isOld :=  NzisReqResp.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NzisReqResp_RESP: isOld :=  NzisReqResp.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(NzisReqResp.PRecord.setProp, TNzisReqRespItem.TPropertyIndex(ACol));
    if NzisReqResp.PRecord.setProp = [] then
    begin
      Dispose(NzisReqResp.PRecord);
      NzisReqResp.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NzisReqResp.PRecord.setProp, TNzisReqRespItem.TPropertyIndex(ACol));
  case TNzisReqRespItem.TPropertyIndex(ACol) of
    NzisReqResp_REQ: NzisReqResp.PRecord.REQ := AValue;
    NzisReqResp_RESP: NzisReqResp.PRecord.RESP := AValue;
    NzisReqResp_Logical: NzisReqResp.PRecord.Logical := tlogicalNzisReqRespSet(NzisReqResp.StrToLogical08(AValue));
  end;
end;

procedure TNzisReqRespColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NzisReqResp: TNzisReqRespItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  NzisReqResp := Items[ARow];
  if not Assigned(NzisReqResp.PRecord) then
  begin
    New(NzisReqResp.PRecord);
    NzisReqResp.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNzisReqRespItem.TPropertyIndex(ACol) of
      NzisReqResp_REQ: isOld :=  NzisReqResp.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NzisReqResp_RESP: isOld :=  NzisReqResp.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(NzisReqResp.PRecord.setProp, TNzisReqRespItem.TPropertyIndex(ACol));
    if NzisReqResp.PRecord.setProp = [] then
    begin
      Dispose(NzisReqResp.PRecord);
      NzisReqResp.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NzisReqResp.PRecord.setProp, TNzisReqRespItem.TPropertyIndex(ACol));
  case TNzisReqRespItem.TPropertyIndex(ACol) of
    NzisReqResp_REQ: NzisReqResp.PRecord.REQ := AFieldText;
    NzisReqResp_RESP: NzisReqResp.PRecord.RESP := AFieldText;
    NzisReqResp_Logical: NzisReqResp.PRecord.Logical := tlogicalNzisReqRespSet(NzisReqResp.StrToLogical08(AFieldText));
  end;
end;

procedure TNzisReqRespColl.SetItem(Index: Integer; const Value: TNzisReqRespItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNzisReqRespColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNzisReqRespSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNzisReqRespItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NzisReqResp_REQ:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNzisReqRespSearch.Add(self.Items[i]);
  end;
end;
      NzisReqResp_RESP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNzisReqRespSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNzisReqRespColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNzisReqRespColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNzisReqRespItem>);
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

procedure TNzisReqRespColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNzisReqRespSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNzisReqRespSearch.Count]);

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

procedure TNzisReqRespColl.SortByIndexAnsiString;
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

procedure TNzisReqRespColl.SortByIndexInt;
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

procedure TNzisReqRespColl.SortByIndexWord;
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

procedure TNzisReqRespColl.SortByMessageId;
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
        while (Items[I]).PRecord.messageId < (Items[P]).PRecord.messageId do Inc(I);
        while (Items[J]).PRecord.messageId > (Items[P]).PRecord.messageId do Dec(J);
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

procedure TNzisReqRespColl.SortByMessageId_nom;
var
  sc : TList<TCollectionItem>;
  function conditionI(i, p: integer): Boolean;
  begin
    if Items[i].PRecord.messageId <> Items[P].PRecord.messageId then
      Result := Items[i].PRecord.messageId < Items[P].PRecord.messageId
    else
      Result := Items[i].PRecord.msgNom < Items[P].PRecord.msgNom;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if Items[j].PRecord.messageId <> Items[P].PRecord.messageId then
      Result := Items[j].PRecord.messageId > Items[P].PRecord.messageId
    else
      Result := Items[j].PRecord.msgNom > Items[P].PRecord.msgNom;
  end;
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
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
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

procedure TNzisReqRespColl.SortByNrn;
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
        while (Items[I]).PRecord.NRN < (Items[P]).PRecord.NRN do Inc(I);
        while (Items[J]).PRecord.NRN > (Items[P]).PRecord.NRN do Dec(J);
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

procedure TNzisReqRespColl.SortByPatEgn;
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
        while (Items[I]).PRecord.patEgn < (Items[P]).PRecord.patEgn do Inc(I);
        while (Items[J]).PRecord.patEgn > (Items[P]).PRecord.patEgn do Dec(J);
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

procedure TNzisReqRespColl.SortListByEGN(lst: TList<TNzisReqRespItem>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TNzisReqRespItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while lst[I].PRecord.patEgn < lst[P].PRecord.patEgn do Inc(I);
        while lst[J].PRecord.patEgn > lst[P].PRecord.patEgn do Dec(J);
        if I <= J then begin
          Save := lst[I];
          lst[I] := lst[J];
          lst[J] := Save;
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
  if (lst.count >1 ) then
  begin
    QuickSort(0,lst.count-1);
  end;
end;

procedure TNzisReqRespColl.SortListByNRN(lst: TList<TNzisReqRespItem>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TNzisReqRespItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while lst[I].PRecord.NRN < lst[P].PRecord.NRN do Inc(I);
        while lst[J].PRecord.NRN > lst[P].PRecord.NRN do Dec(J);
        if I <= J then begin
          Save := lst[I];
          lst[I] := lst[J];
          lst[J] := Save;
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
  if (lst.count >1 ) then
  begin
    QuickSort(0,lst.count-1);
  end;
end;

procedure TNzisReqRespColl.SortByIndexValue(propIndex: TNzisReqRespItem.TPropertyIndex);
begin
  case propIndex of
    NzisReqResp_REQ: SortByIndexAnsiString;
      NzisReqResp_RESP: SortByIndexAnsiString;
  end;
end;

end.