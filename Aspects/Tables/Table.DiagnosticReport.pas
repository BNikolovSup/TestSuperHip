unit Table.DiagnosticReport;

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


TDiagnosticReportItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
DiagnosticReport_Code
, DiagnosticReport_NumberPerformed
, DiagnosticReport_Status
);
	  
      TSetProp = set of TPropertyIndex;
      PRecDiagnosticReport = ^TRecDiagnosticReport;
      TRecDiagnosticReport = record
        Code: AnsiString;
        NumberPerformed: word;
        Status: word;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecDiagnosticReport;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertDiagnosticReport;
    procedure UpdateDiagnosticReport;
    procedure SaveDiagnosticReport(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TDiagnosticReportColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TDiagnosticReportItem;
    procedure SetItem(Index: Integer; const Value: TDiagnosticReportItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TDiagnosticReportItem;
	ListForFDB: TList<TDiagnosticReportItem>;
    ListDiagnosticReportSearch: TList<TDiagnosticReportItem>;
	PRecordSearch: ^TDiagnosticReportItem.TRecDiagnosticReport;
    ArrPropSearch: TArray<TDiagnosticReportItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TDiagnosticReportItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TDiagnosticReportItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; DiagnosticReport: TDiagnosticReportItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; DiagnosticReport: TDiagnosticReportItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TDiagnosticReportItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TDiagnosticReportItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TDiagnosticReportItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TDiagnosticReportItem.TPropertyIndex);
    property Items[Index: Integer]: TDiagnosticReportItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    //procedure OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//    procedure OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
//    procedure OnSetTextSearchCnk(Chk: TCheckBoxDyn);
    //procedure OnSetTextSearchLog(Log: TlogicalDiagnosticReportSet);
  end;

implementation

{ TDiagnosticReportItem }

constructor TDiagnosticReportItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TDiagnosticReportItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TDiagnosticReportItem.InsertDiagnosticReport;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDiagnosticReport;
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
            DiagnosticReport_Code: SaveData(PRecord.Code, PropPosition, metaPosition, dataPosition);
            DiagnosticReport_NumberPerformed: SaveData(PRecord.NumberPerformed, PropPosition, metaPosition, dataPosition);
            DiagnosticReport_Status: SaveData(PRecord.Status, PropPosition, metaPosition, dataPosition);
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

function  TDiagnosticReportItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TDiagnosticReportItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TDiagnosticReportItem;
begin
  Result := True;
  for i := 0 to Length(TDiagnosticReportColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TDiagnosticReportColl(coll).ArrPropSearchClc[i];
	ATempItem := TDiagnosticReportColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        DiagnosticReport_Code: Result := IsFinded(ATempItem.PRecord.Code, buf, FPosDataADB, word(DiagnosticReport_Code), cot);
            DiagnosticReport_NumberPerformed: Result := IsFinded(ATempItem.PRecord.NumberPerformed, buf, FPosDataADB, word(DiagnosticReport_NumberPerformed), cot);
            DiagnosticReport_Status: Result := IsFinded(ATempItem.PRecord.Status, buf, FPosDataADB, word(DiagnosticReport_Status), cot);
      end;
    end;
  end;
end;

procedure TDiagnosticReportItem.SaveDiagnosticReport(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDiagnosticReport;
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
            DiagnosticReport_Code: SaveData(PRecord.Code, PropPosition, metaPosition, dataPosition);
            DiagnosticReport_NumberPerformed: SaveData(PRecord.NumberPerformed, PropPosition, metaPosition, dataPosition);
            DiagnosticReport_Status: SaveData(PRecord.Status, PropPosition, metaPosition, dataPosition);
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

procedure TDiagnosticReportItem.UpdateDiagnosticReport;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDiagnosticReport;
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
            DiagnosticReport_Code: UpdateData(PRecord.Code, PropPosition, metaPosition, dataPosition);
            DiagnosticReport_NumberPerformed: UpdateData(PRecord.NumberPerformed, PropPosition, metaPosition, dataPosition);
            DiagnosticReport_Status: UpdateData(PRecord.Status, PropPosition, metaPosition, dataPosition);
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

{ TDiagnosticReportColl }

function TDiagnosticReportColl.AddItem(ver: word): TDiagnosticReportItem;
begin
  Result := TDiagnosticReportItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TDiagnosticReportColl.AddItemForSearch: Integer;
var
  ItemForSearch: TDiagnosticReportItem;
begin
  ItemForSearch := TDiagnosticReportItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TDiagnosticReportColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TDiagnosticReportItem.Create(nil);
  ListDiagnosticReportSearch := TList<TDiagnosticReportItem>.Create;
  ListForFDB := TList<TDiagnosticReportItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TDiagnosticReportColl.destroy;
begin
  FreeAndNil(ListDiagnosticReportSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TDiagnosticReportColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TDiagnosticReportItem.TPropertyIndex(propIndex) of
    DiagnosticReport_Code: Result := 'Code';
    DiagnosticReport_NumberPerformed: Result := 'NumberPerformed';
    DiagnosticReport_Status: Result := 'Status';
  end;
end;

procedure TDiagnosticReportColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TDiagnosticReportItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TDiagnosticReportColl.FieldCount: Integer; 
begin
  inherited;
  Result := 3;
end;

procedure TDiagnosticReportColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  DiagnosticReport: TDiagnosticReportItem;
  ACol: Integer;
  prop: TDiagnosticReportItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  DiagnosticReport := Items[ARow];
  prop := TDiagnosticReportItem.TPropertyIndex(ACol);
  if Assigned(DiagnosticReport.PRecord) and (prop in DiagnosticReport.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, DiagnosticReport, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, DiagnosticReport, AValue);
  end;
end;

procedure TDiagnosticReportColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TDiagnosticReportItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TDiagnosticReportItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TDiagnosticReportColl.GetCellFromRecord(propIndex: word; DiagnosticReport: TDiagnosticReportItem; var AValue: String);
var
  str: string;
begin
  case TDiagnosticReportItem.TPropertyIndex(propIndex) of
    DiagnosticReport_Code: str := (DiagnosticReport.PRecord.Code);
    DiagnosticReport_NumberPerformed: str := inttostr(DiagnosticReport.PRecord.NumberPerformed);
    DiagnosticReport_Status: str := inttostr(DiagnosticReport.PRecord.Status);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TDiagnosticReportColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TDiagnosticReportItem;
  ACol: Integer;
  prop: TDiagnosticReportItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TDiagnosticReportItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TDiagnosticReportColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TDiagnosticReportItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TDiagnosticReportItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TDiagnosticReportColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  DiagnosticReport: TDiagnosticReportItem;
  ACol: Integer;
  prop: TDiagnosticReportItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  DiagnosticReport := ListDiagnosticReportSearch[ARow];
  prop := TDiagnosticReportItem.TPropertyIndex(ACol);
  if Assigned(DiagnosticReport.PRecord) and (prop in DiagnosticReport.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, DiagnosticReport, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, DiagnosticReport, AValue);
  end;
end;

procedure TDiagnosticReportColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  DiagnosticReport: TDiagnosticReportItem;
  prop: TDiagnosticReportItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  DiagnosticReport := Items[ARow];
  prop := TDiagnosticReportItem.TPropertyIndex(ACol);
  if Assigned(DiagnosticReport.PRecord) and (prop in DiagnosticReport.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, DiagnosticReport, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, DiagnosticReport, AFieldText);
  end;
end;

procedure TDiagnosticReportColl.GetCellFromMap(propIndex: word; ARow: Integer; DiagnosticReport: TDiagnosticReportItem; var AValue: String);
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
  case TDiagnosticReportItem.TPropertyIndex(propIndex) of
    DiagnosticReport_Code: str :=  DiagnosticReport.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    DiagnosticReport_NumberPerformed: str :=  inttostr(DiagnosticReport.getWordMap(Self.Buf, Self.posData, propIndex));
    DiagnosticReport_Status: str :=  inttostr(DiagnosticReport.getWordMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TDiagnosticReportColl.GetItem(Index: Integer): TDiagnosticReportItem;
begin
  Result := TDiagnosticReportItem(inherited GetItem(Index));
end;


procedure TDiagnosticReportColl.IndexValue(propIndex: TDiagnosticReportItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TDiagnosticReportItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      DiagnosticReport_Code:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      DiagnosticReport_NumberPerformed: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      DiagnosticReport_Status: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TDiagnosticReportColl.IndexValueListNodes(propIndex: TDiagnosticReportItem.TPropertyIndex);
begin

end;

procedure TDiagnosticReportColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TDiagnosticReportItem;
begin
  if index < 0 then
  begin
    Tempitem := TDiagnosticReportItem.Create(nil);
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

//procedure TDiagnosticReportColl.OnSetTextSearchCnk(Chk: TCheckBoxDyn);
//begin
//  if Chk.sta then
//
//end;
//
//procedure TDiagnosticReportColl.OnSetTextSearchDTEDT(DtEdt: TDateEditDyn);
//begin
//  if dtEdt.Date = 0 then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(dtEdt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(dtEdt.Field));
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  case TDiagnosticReportItem.TPropertyIndex(dtEdt.Field) of
//    DiagnosticReport_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := dtEdt.Date;
//  end;
//end;
//
//procedure TDiagnosticReportColl.OnSetTextSearchEDT(edt: fmx.EditDyn.TEditDyn);
//begin
//  if edt.Text = '' then
//  begin
//    Exclude(ListForFDB[0].PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(edt.Field));
//  end
//  else
//  begin
//    include(ListForFDB[0].PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(edt.Field));
//    //ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
//  end;
//  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
//  if cotSens in edt.Condition then
//  begin
//    case TDiagnosticReportItem.TPropertyIndex(edt.Field) of
//      DiagnosticReport_EGN: ListForFDB[0].PRecord.EGN  := edt.Text;
//      DiagnosticReport_FNAME: ListForFDB[0].PRecord.FNAME  := edt.Text;
//      DiagnosticReport_SNAME: ListForFDB[0].PRecord.SNAME  := edt.Text;
//      DiagnosticReport_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //DiagnosticReport_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end
//  else
//  begin
//    case TDiagnosticReportItem.TPropertyIndex(edt.Field) of
//      DiagnosticReport_EGN: ListForFDB[0].PRecord.EGN  := AnsiUpperCase(edt.Text);
//      DiagnosticReport_FNAME: ListForFDB[0].PRecord.FNAME  := AnsiUpperCase(edt.Text);
//      DiagnosticReport_SNAME: ListForFDB[0].PRecord.SNAME  := AnsiUpperCase(edt.Text);
//      DiagnosticReport_ID: ListForFDB[0].PRecord.ID  := StrToInt(edt.Text);
//      //DiagnosticReport_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
//    end;
//  end;
//end;
//
//procedure TDiagnosticReportColl.OnSetTextSearchLog(Log: TlogicalDiagnosticReportSet);
//begin
//  ListForFDB[0].PRecord.Logical := Log;
//end;

function TDiagnosticReportColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TDiagnosticReportItem.TPropertyIndex(propIndex) of
    DiagnosticReport_Code: Result := actAnsiString;
    DiagnosticReport_NumberPerformed: Result := actword;
    DiagnosticReport_Status: Result := actword;
  else
    Result := actNone;
  end
end;

procedure TDiagnosticReportColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  DiagnosticReport: TDiagnosticReportItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  DiagnosticReport := Items[ARow];
  if not Assigned(DiagnosticReport.PRecord) then
  begin
    New(DiagnosticReport.PRecord);
    DiagnosticReport.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TDiagnosticReportItem.TPropertyIndex(ACol) of
      DiagnosticReport_Code: isOld :=  DiagnosticReport.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    DiagnosticReport_NumberPerformed: isOld :=  DiagnosticReport.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    DiagnosticReport_Status: isOld :=  DiagnosticReport.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(DiagnosticReport.PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(ACol));
    if DiagnosticReport.PRecord.setProp = [] then
    begin
      Dispose(DiagnosticReport.PRecord);
      DiagnosticReport.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(DiagnosticReport.PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(ACol));
  case TDiagnosticReportItem.TPropertyIndex(ACol) of
    DiagnosticReport_Code: DiagnosticReport.PRecord.Code := AValue;
    DiagnosticReport_NumberPerformed: DiagnosticReport.PRecord.NumberPerformed := StrToInt(AValue);
    DiagnosticReport_Status: DiagnosticReport.PRecord.Status := StrToInt(AValue);
  end;
end;

procedure TDiagnosticReportColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  DiagnosticReport: TDiagnosticReportItem;
begin
  if Count = 0 then Exit;

  DiagnosticReport := Items[ARow];
  if not Assigned(DiagnosticReport.PRecord) then
  begin
    New(DiagnosticReport.PRecord);
    DiagnosticReport.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TDiagnosticReportItem.TPropertyIndex(ACol) of
      DiagnosticReport_Code: isOld :=  DiagnosticReport.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    DiagnosticReport_NumberPerformed: isOld :=  DiagnosticReport.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    DiagnosticReport_Status: isOld :=  DiagnosticReport.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(DiagnosticReport.PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(ACol));
    if DiagnosticReport.PRecord.setProp = [] then
    begin
      Dispose(DiagnosticReport.PRecord);
      DiagnosticReport.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(DiagnosticReport.PRecord.setProp, TDiagnosticReportItem.TPropertyIndex(ACol));
  case TDiagnosticReportItem.TPropertyIndex(ACol) of
    DiagnosticReport_Code: DiagnosticReport.PRecord.Code := AFieldText;
    DiagnosticReport_NumberPerformed: DiagnosticReport.PRecord.NumberPerformed := StrToInt(AFieldText);
    DiagnosticReport_Status: DiagnosticReport.PRecord.Status := StrToInt(AFieldText);
  end;
end;

procedure TDiagnosticReportColl.SetItem(Index: Integer; const Value: TDiagnosticReportItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDiagnosticReportColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListDiagnosticReportSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TDiagnosticReportItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  DiagnosticReport_Code:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListDiagnosticReportSearch.Add(self.Items[i]);
  end;
end;
      DiagnosticReport_NumberPerformed: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListDiagnosticReportSearch.Add(self.Items[i]);
        end;
      end;
      DiagnosticReport_Status: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListDiagnosticReportSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TDiagnosticReportColl.ShowGrid(Grid: TTeeGrid);
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

procedure TDiagnosticReportColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TDiagnosticReportItem>);
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

procedure TDiagnosticReportColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDiagnosticReportSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDiagnosticReportSearch.Count]);

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

procedure TDiagnosticReportColl.SortByIndexAnsiString;
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

procedure TDiagnosticReportColl.SortByIndexInt;
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

procedure TDiagnosticReportColl.SortByIndexWord;
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

procedure TDiagnosticReportColl.SortByIndexValue(propIndex: TDiagnosticReportItem.TPropertyIndex);
begin
  case propIndex of
    DiagnosticReport_Code: SortByIndexAnsiString;
      DiagnosticReport_NumberPerformed: SortByIndexWord;
      DiagnosticReport_Status: SortByIndexWord;
  end;
end;

end.