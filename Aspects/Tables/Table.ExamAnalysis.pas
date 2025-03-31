unit Table.ExamAnalysis;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control;

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


TExamAnalysisItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
ExamAnalysis_ANALYSIS_ID
, ExamAnalysis_BLANKA_MDN_ID
, ExamAnalysis_DATA
, ExamAnalysis_EMDN_ID
, ExamAnalysis_ID
, ExamAnalysis_NZIS_CODE_CL22
, ExamAnalysis_NZIS_DESCRIPTION_CL22
, ExamAnalysis_PREGLED_ID
, ExamAnalysis_RESULT
, ExamAnalysis_PosDataNomen
);
	  
      TSetProp = set of TPropertyIndex;
      PRecExamAnalysis = ^TRecExamAnalysis;
      TRecExamAnalysis = record
        ANALYSIS_ID: word;
        BLANKA_MDN_ID: integer;
        DATA: TDate;
        EMDN_ID: integer;
        ID: integer;
        NZIS_CODE_CL22: AnsiString;
        NZIS_DESCRIPTION_CL22: AnsiString;
        PREGLED_ID: integer;
        RESULT: AnsiString;
        PosDataNomen: cardinal;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecExamAnalysis;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertExamAnalysis;
    procedure UpdateExamAnalysis;
    procedure SaveExamAnalysis(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TExamAnalysisColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TExamAnalysisItem;
    procedure SetItem(Index: Integer; const Value: TExamAnalysisItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TExamAnalysisItem;
	ListForFDB: TList<TExamAnalysisItem>;
    ListExamAnalysisSearch: TList<TExamAnalysisItem>;
	PRecordSearch: ^TExamAnalysisItem.TRecExamAnalysis;
    ArrPropSearch: TArray<TExamAnalysisItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TExamAnalysisItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TExamAnalysisItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; ExamAnalysis: TExamAnalysisItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; ExamAnalysis: TExamAnalysisItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamAnalysisItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TExamAnalysisItem.TPropertyIndex);
    property Items[Index: Integer]: TExamAnalysisItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
  end;

implementation

{ TExamAnalysisItem }

constructor TExamAnalysisItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TExamAnalysisItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TExamAnalysisItem.InsertExamAnalysis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctExamAnalysis;
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
            ExamAnalysis_ANALYSIS_ID: SaveData(PRecord.ANALYSIS_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_BLANKA_MDN_ID: SaveData(PRecord.BLANKA_MDN_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_EMDN_ID: SaveData(PRecord.EMDN_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_CODE_CL22: SaveData(PRecord.NZIS_CODE_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: SaveData(PRecord.NZIS_DESCRIPTION_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_RESULT: SaveData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PosDataNomen: SaveData(PRecord.PosDataNomen, PropPosition, metaPosition, dataPosition);
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

function  TExamAnalysisItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TExamAnalysisItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TExamAnalysisItem;
begin
  Result := True;
  for i := 0 to Length(TExamAnalysisColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TExamAnalysisColl(coll).ArrPropSearchClc[i];
	ATempItem := TExamAnalysisColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        ExamAnalysis_ANALYSIS_ID: Result := IsFinded(ATempItem.PRecord.ANALYSIS_ID, buf, FPosDataADB, word(ExamAnalysis_ANALYSIS_ID), cot);
            ExamAnalysis_BLANKA_MDN_ID: Result := IsFinded(ATempItem.PRecord.BLANKA_MDN_ID, buf, FPosDataADB, word(ExamAnalysis_BLANKA_MDN_ID), cot);
            ExamAnalysis_DATA: Result := IsFinded(ATempItem.PRecord.DATA, buf, FPosDataADB, word(ExamAnalysis_DATA), cot);
            ExamAnalysis_EMDN_ID: Result := IsFinded(ATempItem.PRecord.EMDN_ID, buf, FPosDataADB, word(ExamAnalysis_EMDN_ID), cot);
            ExamAnalysis_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(ExamAnalysis_ID), cot);
            ExamAnalysis_NZIS_CODE_CL22: Result := IsFinded(ATempItem.PRecord.NZIS_CODE_CL22, buf, FPosDataADB, word(ExamAnalysis_NZIS_CODE_CL22), cot);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: Result := IsFinded(ATempItem.PRecord.NZIS_DESCRIPTION_CL22, buf, FPosDataADB, word(ExamAnalysis_NZIS_DESCRIPTION_CL22), cot);
            ExamAnalysis_PREGLED_ID: Result := IsFinded(ATempItem.PRecord.PREGLED_ID, buf, FPosDataADB, word(ExamAnalysis_PREGLED_ID), cot);
            ExamAnalysis_RESULT: Result := IsFinded(ATempItem.PRecord.RESULT, buf, FPosDataADB, word(ExamAnalysis_RESULT), cot);
            ExamAnalysis_PosDataNomen: Result := IsFinded(ATempItem.PRecord.PosDataNomen, buf, FPosDataADB, word(ExamAnalysis_PosDataNomen), cot);
      end;
    end;
  end;
end;

procedure TExamAnalysisItem.SaveExamAnalysis(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExamAnalysis;
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
            ExamAnalysis_ANALYSIS_ID: SaveData(PRecord.ANALYSIS_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_BLANKA_MDN_ID: SaveData(PRecord.BLANKA_MDN_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_EMDN_ID: SaveData(PRecord.EMDN_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_CODE_CL22: SaveData(PRecord.NZIS_CODE_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: SaveData(PRecord.NZIS_DESCRIPTION_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_RESULT: SaveData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PosDataNomen: SaveData(PRecord.PosDataNomen, PropPosition, metaPosition, dataPosition);
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

procedure TExamAnalysisItem.UpdateExamAnalysis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExamAnalysis;
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
            ExamAnalysis_ANALYSIS_ID: UpdateData(PRecord.ANALYSIS_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_BLANKA_MDN_ID: UpdateData(PRecord.BLANKA_MDN_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_EMDN_ID: UpdateData(PRecord.EMDN_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_CODE_CL22: UpdateData(PRecord.NZIS_CODE_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: UpdateData(PRecord.NZIS_DESCRIPTION_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_RESULT: UpdateData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PosDataNomen: UpdateData(PRecord.PosDataNomen, PropPosition, metaPosition, dataPosition);
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

{ TExamAnalysisColl }

function TExamAnalysisColl.AddItem(ver: word): TExamAnalysisItem;
begin
  Result := TExamAnalysisItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TExamAnalysisColl.AddItemForSearch: Integer;
var
  ItemForSearch: TExamAnalysisItem;
begin
  ItemForSearch := TExamAnalysisItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TExamAnalysisColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TExamAnalysisItem.Create(nil);
  ListExamAnalysisSearch := TList<TExamAnalysisItem>.Create;
  ListForFDB := TList<TExamAnalysisItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TExamAnalysisColl.destroy;
begin
  FreeAndNil(ListExamAnalysisSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TExamAnalysisColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_ANALYSIS_ID: Result := 'ANALYSIS_ID';
    ExamAnalysis_BLANKA_MDN_ID: Result := 'BLANKA_MDN_ID';
    ExamAnalysis_DATA: Result := 'DATA';
    ExamAnalysis_EMDN_ID: Result := 'EMDN_ID';
    ExamAnalysis_ID: Result := 'ID';
    ExamAnalysis_NZIS_CODE_CL22: Result := 'NZIS_CODE_CL22';
    ExamAnalysis_NZIS_DESCRIPTION_CL22: Result := 'NZIS_DESCRIPTION_CL22';
    ExamAnalysis_PREGLED_ID: Result := 'PREGLED_ID';
    ExamAnalysis_RESULT: Result := 'RESULT';
    ExamAnalysis_PosDataNomen: Result := 'PosDataNomen';
  end;
end;

procedure TExamAnalysisColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  self.IndexValue(TExamAnalysisItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TExamAnalysisColl.FieldCount: Integer; 
begin
  inherited;
  Result := 10;
end;

procedure TExamAnalysisColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ExamAnalysis: TExamAnalysisItem;
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  ExamAnalysis := Items[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(ExamAnalysis.PRecord) and (prop in ExamAnalysis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamAnalysis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamAnalysis, AValue);
  end;
end;

procedure TExamAnalysisColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TExamAnalysisColl.GetCellFromRecord(propIndex: word; ExamAnalysis: TExamAnalysisItem; var AValue: String);
var
  str: string;
begin
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_ANALYSIS_ID: str := inttostr(ExamAnalysis.PRecord.ANALYSIS_ID);
    ExamAnalysis_BLANKA_MDN_ID: str := inttostr(ExamAnalysis.PRecord.BLANKA_MDN_ID);
    ExamAnalysis_DATA: str := DateToStr(ExamAnalysis.PRecord.DATA);
    ExamAnalysis_EMDN_ID: str := inttostr(ExamAnalysis.PRecord.EMDN_ID);
    ExamAnalysis_ID: str := inttostr(ExamAnalysis.PRecord.ID);
    ExamAnalysis_NZIS_CODE_CL22: str := (ExamAnalysis.PRecord.NZIS_CODE_CL22);
    ExamAnalysis_NZIS_DESCRIPTION_CL22: str := (ExamAnalysis.PRecord.NZIS_DESCRIPTION_CL22);
    ExamAnalysis_PREGLED_ID: str := inttostr(ExamAnalysis.PRecord.PREGLED_ID);
    ExamAnalysis_RESULT: str := (ExamAnalysis.PRecord.RESULT);
    ExamAnalysis_PosDataNomen: str := inttostr(ExamAnalysis.PRecord.PosDataNomen);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TExamAnalysisColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TExamAnalysisItem;
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TExamAnalysisColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TExamAnalysisColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ExamAnalysis: TExamAnalysisItem;
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  ExamAnalysis := ListExamAnalysisSearch[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(ExamAnalysis.PRecord) and (prop in ExamAnalysis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamAnalysis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamAnalysis, AValue);
  end;
end;

procedure TExamAnalysisColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  ExamAnalysis: TExamAnalysisItem;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  ExamAnalysis := Items[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(ExamAnalysis.PRecord) and (prop in ExamAnalysis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamAnalysis, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamAnalysis, AFieldText);
  end;
end;

procedure TExamAnalysisColl.GetCellFromMap(propIndex: word; ARow: Integer; ExamAnalysis: TExamAnalysisItem; var AValue: String);
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
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_ANALYSIS_ID: str :=  inttostr(ExamAnalysis.getWordMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_BLANKA_MDN_ID: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_DATA: str :=  DateToStr(ExamAnalysis.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_EMDN_ID: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_ID: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_NZIS_CODE_CL22: str :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamAnalysis_NZIS_DESCRIPTION_CL22: str :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamAnalysis_PREGLED_ID: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_RESULT: str :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamAnalysis_PosDataNomen: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TExamAnalysisColl.GetItem(Index: Integer): TExamAnalysisItem;
begin
  Result := TExamAnalysisItem(inherited GetItem(Index));
end;


procedure TExamAnalysisColl.IndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TExamAnalysisItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      ExamAnalysis_ANALYSIS_ID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      ExamAnalysis_BLANKA_MDN_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamAnalysis_EMDN_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamAnalysis_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamAnalysis_NZIS_CODE_CL22:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamAnalysis_NZIS_DESCRIPTION_CL22:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamAnalysis_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamAnalysis_RESULT:
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

procedure TExamAnalysisColl.IndexValueListNodes(propIndex: TExamAnalysisItem.TPropertyIndex);
begin

end;

procedure TExamAnalysisColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TExamAnalysisItem;
begin
  if index < 0 then
  begin
    Tempitem := TExamAnalysisItem.Create(nil);
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

function TExamAnalysisColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_ANALYSIS_ID: Result := actword;
    ExamAnalysis_BLANKA_MDN_ID: Result := actinteger;
    ExamAnalysis_DATA: Result := actTDate;
    ExamAnalysis_EMDN_ID: Result := actinteger;
    ExamAnalysis_ID: Result := actinteger;
    ExamAnalysis_NZIS_CODE_CL22: Result := actAnsiString;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: Result := actAnsiString;
    ExamAnalysis_PREGLED_ID: Result := actinteger;
    ExamAnalysis_RESULT: Result := actAnsiString;
    ExamAnalysis_PosDataNomen: Result := actcardinal;
  else
    Result := actNone;
  end
end;

procedure TExamAnalysisColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  ExamAnalysis: TExamAnalysisItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  ExamAnalysis := Items[ARow];
  if not Assigned(ExamAnalysis.PRecord) then
  begin
    New(ExamAnalysis.PRecord);
    ExamAnalysis.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TExamAnalysisItem.TPropertyIndex(ACol) of
      ExamAnalysis_ANALYSIS_ID: isOld :=  ExamAnalysis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamAnalysis_BLANKA_MDN_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamAnalysis_DATA: isOld :=  ExamAnalysis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamAnalysis_EMDN_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamAnalysis_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamAnalysis_NZIS_CODE_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamAnalysis_PREGLED_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamAnalysis_RESULT: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamAnalysis_PosDataNomen: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
    if ExamAnalysis.PRecord.setProp = [] then
    begin
      Dispose(ExamAnalysis.PRecord);
      ExamAnalysis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
  case TExamAnalysisItem.TPropertyIndex(ACol) of
    ExamAnalysis_ANALYSIS_ID: ExamAnalysis.PRecord.ANALYSIS_ID := StrToInt(AValue);
    ExamAnalysis_BLANKA_MDN_ID: ExamAnalysis.PRecord.BLANKA_MDN_ID := StrToInt(AValue);
    ExamAnalysis_DATA: ExamAnalysis.PRecord.DATA := StrToDate(AValue);
    ExamAnalysis_EMDN_ID: ExamAnalysis.PRecord.EMDN_ID := StrToInt(AValue);
    ExamAnalysis_ID: ExamAnalysis.PRecord.ID := StrToInt(AValue);
    ExamAnalysis_NZIS_CODE_CL22: ExamAnalysis.PRecord.NZIS_CODE_CL22 := AValue;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: ExamAnalysis.PRecord.NZIS_DESCRIPTION_CL22 := AValue;
    ExamAnalysis_PREGLED_ID: ExamAnalysis.PRecord.PREGLED_ID := StrToInt(AValue);
    ExamAnalysis_RESULT: ExamAnalysis.PRecord.RESULT := AValue;
    ExamAnalysis_PosDataNomen: ExamAnalysis.PRecord.PosDataNomen := StrToInt(AValue);
  end;
end;

procedure TExamAnalysisColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  ExamAnalysis: TExamAnalysisItem;
begin
  if Count = 0 then Exit;

  ExamAnalysis := Items[ARow];
  if not Assigned(ExamAnalysis.PRecord) then
  begin
    New(ExamAnalysis.PRecord);
    ExamAnalysis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TExamAnalysisItem.TPropertyIndex(ACol) of
      ExamAnalysis_ANALYSIS_ID: isOld :=  ExamAnalysis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamAnalysis_BLANKA_MDN_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamAnalysis_DATA: isOld :=  ExamAnalysis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamAnalysis_EMDN_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamAnalysis_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamAnalysis_NZIS_CODE_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamAnalysis_PREGLED_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamAnalysis_RESULT: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamAnalysis_PosDataNomen: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
    if ExamAnalysis.PRecord.setProp = [] then
    begin
      Dispose(ExamAnalysis.PRecord);
      ExamAnalysis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
  case TExamAnalysisItem.TPropertyIndex(ACol) of
    ExamAnalysis_ANALYSIS_ID: ExamAnalysis.PRecord.ANALYSIS_ID := StrToInt(AFieldText);
    ExamAnalysis_BLANKA_MDN_ID: ExamAnalysis.PRecord.BLANKA_MDN_ID := StrToInt(AFieldText);
    ExamAnalysis_DATA: ExamAnalysis.PRecord.DATA := StrToDate(AFieldText);
    ExamAnalysis_EMDN_ID: ExamAnalysis.PRecord.EMDN_ID := StrToInt(AFieldText);
    ExamAnalysis_ID: ExamAnalysis.PRecord.ID := StrToInt(AFieldText);
    ExamAnalysis_NZIS_CODE_CL22: ExamAnalysis.PRecord.NZIS_CODE_CL22 := AFieldText;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: ExamAnalysis.PRecord.NZIS_DESCRIPTION_CL22 := AFieldText;
    ExamAnalysis_PREGLED_ID: ExamAnalysis.PRecord.PREGLED_ID := StrToInt(AFieldText);
    ExamAnalysis_RESULT: ExamAnalysis.PRecord.RESULT := AFieldText;
    ExamAnalysis_PosDataNomen: ExamAnalysis.PRecord.PosDataNomen := StrToInt(AFieldText);
  end;
end;

procedure TExamAnalysisColl.SetItem(Index: Integer; const Value: TExamAnalysisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TExamAnalysisColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListExamAnalysisSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TExamAnalysisItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  ExamAnalysis_ANALYSIS_ID: 
begin
  if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
  begin
    ListExamAnalysisSearch.Add(self.Items[i]);
  end;
end;
      ExamAnalysis_BLANKA_MDN_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_EMDN_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_NZIS_CODE_CL22:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_NZIS_DESCRIPTION_CL22:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_PREGLED_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_RESULT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TExamAnalysisColl.ShowGrid(Grid: TTeeGrid);
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

procedure TExamAnalysisColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamAnalysisItem>);
var
  i: word;

begin
  ListForFDB := LST;
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

procedure TExamAnalysisColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListExamAnalysisSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListExamAnalysisSearch.Count]);

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

procedure TExamAnalysisColl.SortByIndexAnsiString;
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

procedure TExamAnalysisColl.SortByIndexInt;
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

procedure TExamAnalysisColl.SortByIndexWord;
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

procedure TExamAnalysisColl.SortByIndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
begin
  case propIndex of
    ExamAnalysis_ANALYSIS_ID: SortByIndexWord;
      ExamAnalysis_BLANKA_MDN_ID: SortByIndexInt;
      ExamAnalysis_EMDN_ID: SortByIndexInt;
      ExamAnalysis_ID: SortByIndexInt;
      ExamAnalysis_NZIS_CODE_CL22: SortByIndexAnsiString;
      ExamAnalysis_NZIS_DESCRIPTION_CL22: SortByIndexAnsiString;
      ExamAnalysis_PREGLED_ID: SortByIndexInt;
      ExamAnalysis_RESULT: SortByIndexAnsiString;
  end;
end;

end.