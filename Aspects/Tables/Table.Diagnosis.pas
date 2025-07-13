unit Table.Diagnosis;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees;

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
TLogicalDiagnosis = (
    use_CL076_Chief_Complaint,
    use_CL076_Comorbidity,
    RegisterForObservation,
    ClinicalStatus_Active,
    ClinicalStatus_Recurrence,
    ClinicalStatus_Relapse,
    ClinicalStatus_Inactive,
    ClinicalStatus_Remission,
    ClinicalStatus_Resolved,
    VerificationStatusUnconfirmed,
    VerificationStatusProvisional,
    VerificationStatusDifferential,
    VerificationStatusConfirmed,
    VerificationStatusRefuted,
    VerificationStatusEntered_Error);
TlogicalDiagnosisSet = set of TLogicalDiagnosis;


TDiagnosisItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
        Diagnosis_code_CL011
      , Diagnosis_additionalCode_CL011
      , Diagnosis_rank
      , Diagnosis_onsetDateTime
      , Diagnosis_CL011Pos
      , Diagnosis_Logical
      , Diagnosis_MkbPos
      , Diagnosis_MkbAddPos
      );
      TSetProp = set of TPropertyIndex;
      PRecDiagnosis = ^TRecDiagnosis;
      TRecDiagnosis = record
        code_CL011: AnsiString;
        additionalCode_CL011: AnsiString;
        rank: word;
        onsetDateTime: TDate;
        CL011Pos: Cardinal;
        Logical: TlogicalDiagnosisSet;
        MkbPos: Cardinal;
        MkbAddPos: Cardinal;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecDiagnosis;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertDiagnosis;
    procedure UpdateDiagnosis;
    procedure SaveDiagnosis(var dataPosition: Cardinal) overload;
    procedure SaveDiagnosis(Abuf: Pointer; var dataPosition: Cardinal) overload;
    procedure MarkDelete;
  end;


  TDiagnosisColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TDiagnosisItem;
    procedure SetItem(Index: Integer; const Value: TDiagnosisItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TDiagnosisItem;
    ListDiagnosisSearch: TList<TDiagnosisItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TDiagnosisItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Diagnosis: TDiagnosisItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Diagnosis: TDiagnosisItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);

    procedure IndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
    property Items[Index: Integer]: TDiagnosisItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TDiagnosisItem }

constructor TDiagnosisItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TDiagnosisItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TDiagnosisItem.InsertDiagnosis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDiagnosis;
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
  //SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion);
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
            Diagnosis_code_CL011: SaveData(PRecord.code_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_additionalCode_CL011: SaveData(PRecord.additionalCode_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_rank: SaveData(PRecord.rank, PropPosition, metaPosition, dataPosition);
            Diagnosis_onsetDateTime: SaveData(PRecord.onsetDateTime, PropPosition, metaPosition, dataPosition);
            Diagnosis_CL011Pos: SaveData(PRecord.CL011Pos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbPos: SaveData(PRecord.MkbPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbAddPos: SaveData(PRecord.MkbAddPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TDiagnosisItem.MarkDelete;
var
  CollType: TCollectionsType;
  metaPosition: cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctDiagnosisDel;
  metaPosition := FDataPos - 4;
  pWordData := pointer(PByte(buf) + metaPosition);
  pWordData^  := word(CollType);
end;

// insert

procedure TDiagnosisItem.SaveDiagnosis(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  APosData + ALenData;
  SaveDiagnosis(dataPosition);
end;

procedure TDiagnosisItem.SaveDiagnosis(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDiagnosis;
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
            Diagnosis_code_CL011: SaveData(PRecord.code_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_additionalCode_CL011: SaveData(PRecord.additionalCode_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_rank: SaveData(PRecord.rank, PropPosition, metaPosition, dataPosition);
            Diagnosis_onsetDateTime: SaveData(PRecord.onsetDateTime, PropPosition, metaPosition, dataPosition);
            Diagnosis_CL011Pos: SaveData(PRecord.CL011Pos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbPos: SaveData(PRecord.MkbPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_MkbAddPos: SaveData(PRecord.MkbAddPos, PropPosition, metaPosition, dataPosition);
            Diagnosis_Logical: SaveData(TLogicalData16(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
end; //save

procedure TDiagnosisItem.UpdateDiagnosis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctDiagnosis;
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
            Diagnosis_code_CL011: UpdateData(PRecord.code_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_additionalCode_CL011: UpdateData(PRecord.additionalCode_CL011, PropPosition, metaPosition, dataPosition);
            Diagnosis_rank: UpdateData(PRecord.rank, PropPosition, metaPosition, dataPosition);
            Diagnosis_onsetDateTime: UpdateData(PRecord.onsetDateTime, PropPosition, metaPosition, dataPosition);
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

{ TDiagnosisColl }

function TDiagnosisColl.AddItem(ver: word): TDiagnosisItem;
begin
  Result := TDiagnosisItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TDiagnosisColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListDiagnosisSearch := TList<TDiagnosisItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  tempItem := TDiagnosisItem.Create(nil);
end;

destructor TDiagnosisColl.destroy;
begin
  FreeAndNil(ListDiagnosisSearch);
  FreeAndNil(tempItem);
  inherited;
end;

function TDiagnosisColl.DisplayName(propIndex: Word): string;
begin
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: Result := 'code_CL011';
    Diagnosis_additionalCode_CL011: Result := 'additionalCode_CL011';
    Diagnosis_rank: Result := 'rank';
    Diagnosis_onsetDateTime: Result := 'onsetDateTime';
    Diagnosis_CL011Pos: Result := 'CL011Pos';
    Diagnosis_MkbPos: Result := 'MkbPos';
    Diagnosis_MkbAddPos: Result := 'MkbAddPos';
    Diagnosis_Logical: Result := 'Logical';
  end;
end;

procedure TDiagnosisColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TDiagnosisItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TDiagnosisColl.FieldCount: Integer;
begin
  Result := 8;
end;

procedure TDiagnosisColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Diagnosis: TDiagnosisItem;
  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Diagnosis := Items[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(Diagnosis.PRecord) and (prop in Diagnosis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Diagnosis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Diagnosis, AValue);
  end;
end;

procedure TDiagnosisColl.GetCellFromRecord(propIndex: word; Diagnosis: TDiagnosisItem; var AValue: String);
var
  str: string;
begin
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: str := (Diagnosis.PRecord.code_CL011);
    Diagnosis_additionalCode_CL011: str := (Diagnosis.PRecord.additionalCode_CL011);
    Diagnosis_rank: str := inttostr(Diagnosis.PRecord.rank);
    Diagnosis_onsetDateTime: str := DateToStr(Diagnosis.PRecord.onsetDateTime);
    Diagnosis_CL011Pos: str := inttostr(Diagnosis.PRecord.CL011Pos);
    Diagnosis_MkbPos: str := inttostr(Diagnosis.PRecord.MkbPos);
    Diagnosis_MkbAddPos: str := inttostr(Diagnosis.PRecord.MkbAddPos);
    Diagnosis_Logical: str := Diagnosis.Logical16ToStr(TLogicalData16(Diagnosis.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TDiagnosisColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var

  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  tempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, tempItem, AValue);
end;

procedure TDiagnosisColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Diagnosis: TDiagnosisItem;
  ACol: Integer;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Diagnosis := ListDiagnosisSearch[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(Diagnosis.PRecord) and (prop in Diagnosis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Diagnosis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Diagnosis, AValue);
  end;
end;

procedure TDiagnosisColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Diagnosis: TDiagnosisItem;
  prop: TDiagnosisItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Diagnosis := Items[ARow];
  prop := TDiagnosisItem.TPropertyIndex(ACol);
  if Assigned(Diagnosis.PRecord) and (prop in Diagnosis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Diagnosis, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Diagnosis, AFieldText);
  end;
end;

procedure TDiagnosisColl.GetCellFromMap(propIndex: word; ARow: Integer; Diagnosis: TDiagnosisItem; var AValue: String);
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
  case TDiagnosisItem.TPropertyIndex(propIndex) of
    Diagnosis_code_CL011: str :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Diagnosis_additionalCode_CL011: str :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Diagnosis_rank: str :=  inttostr(Diagnosis.getWordMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_onsetDateTime: str :=  DateToStr(Diagnosis.getDateMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_CL011Pos: str :=  inttostr(Diagnosis.getCardMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_MkbPos: str :=  inttostr(Diagnosis.getCardMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_MkbAddPos: str :=  inttostr(Diagnosis.getCardMap(Self.Buf, Self.posData, propIndex));
    Diagnosis_Logical: str :=  Diagnosis.Logical32ToStr(Diagnosis.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TDiagnosisColl.GetItem(Index: Integer): TDiagnosisItem;
begin
  Result := TDiagnosisItem(inherited GetItem(Index));
end;


procedure TDiagnosisColl.IndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TDiagnosisItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Diagnosis_code_CL011:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Diagnosis_additionalCode_CL011:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Diagnosis_rank: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Diagnosis_CL011Pos: TempItem.IndexInt :=  TempItem.getPCardMap(Self.Buf, self.posData, word(propIndex))^;
      Diagnosis_MkbPos: TempItem.IndexInt :=  TempItem.getPCardMap(Self.Buf, self.posData, word(propIndex))^;
      Diagnosis_MkbAddPos: TempItem.IndexInt :=  TempItem.getPCardMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TDiagnosisColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Diagnosis: TDiagnosisItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Diagnosis := Items[ARow];
  if not Assigned(Diagnosis.PRecord) then
  begin
    New(Diagnosis.PRecord);
    Diagnosis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TDiagnosisItem.TPropertyIndex(ACol) of
      Diagnosis_code_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Diagnosis_additionalCode_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Diagnosis_rank: isOld :=  Diagnosis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      Diagnosis_onsetDateTime: isOld :=  Diagnosis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      Diagnosis_CL011Pos: isOld :=  Diagnosis.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      Diagnosis_MkbPos: isOld :=  Diagnosis.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      Diagnosis_MkbAddPos: isOld :=  Diagnosis.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
    if Diagnosis.PRecord.setProp = [] then
    begin
      Dispose(Diagnosis.PRecord);
      Diagnosis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
  case TDiagnosisItem.TPropertyIndex(ACol) of
    Diagnosis_code_CL011: Diagnosis.PRecord.code_CL011 := AValue;
    Diagnosis_additionalCode_CL011: Diagnosis.PRecord.additionalCode_CL011 := AValue;
    Diagnosis_rank: Diagnosis.PRecord.rank := StrToInt(AValue);
    Diagnosis_onsetDateTime: Diagnosis.PRecord.onsetDateTime := StrToDate(AValue);
    Diagnosis_CL011Pos: Diagnosis.PRecord.CL011Pos := StrToInt(AValue);
    Diagnosis_MkbPos: Diagnosis.PRecord.MkbPos := StrToInt(AValue);
    Diagnosis_MkbAddPos: Diagnosis.PRecord.MkbAddPos := StrToInt(AValue);
    Diagnosis_Logical: Diagnosis.PRecord.Logical := tlogicalDiagnosisSet(Diagnosis.StrToLogical16(AValue));
  end;
end;

procedure TDiagnosisColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Diagnosis: TDiagnosisItem;
begin
  if Count = 0 then Exit;

  Diagnosis := Items[ARow];
  if not Assigned(Diagnosis.PRecord) then
  begin
    New(Diagnosis.PRecord);
    Diagnosis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TDiagnosisItem.TPropertyIndex(ACol) of
      Diagnosis_code_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      Diagnosis_additionalCode_CL011: isOld :=  Diagnosis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      Diagnosis_rank: isOld :=  Diagnosis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      Diagnosis_onsetDateTime: isOld :=  Diagnosis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
      Diagnosis_CL011Pos: isOld :=  Diagnosis.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      Diagnosis_MkbPos: isOld :=  Diagnosis.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      Diagnosis_MkbAddPos: isOld :=  Diagnosis.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
    if Diagnosis.PRecord.setProp = [] then
    begin
      Dispose(Diagnosis.PRecord);
      Diagnosis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Diagnosis.PRecord.setProp, TDiagnosisItem.TPropertyIndex(ACol));
  case TDiagnosisItem.TPropertyIndex(ACol) of
    Diagnosis_code_CL011: Diagnosis.PRecord.code_CL011 := AFieldText;
    Diagnosis_additionalCode_CL011: Diagnosis.PRecord.additionalCode_CL011 := AFieldText;
    Diagnosis_rank: Diagnosis.PRecord.rank := StrToInt(AFieldText);
    Diagnosis_onsetDateTime: Diagnosis.PRecord.onsetDateTime := StrToDate(AFieldText);
    Diagnosis_CL011Pos: Diagnosis.PRecord.CL011Pos := StrToInt(AFieldText);
    Diagnosis_MkbPos: Diagnosis.PRecord.MkbPos := StrToInt(AFieldText);
    Diagnosis_MkbAddPos: Diagnosis.PRecord.MkbAddPos := StrToInt(AFieldText);
    Diagnosis_Logical: Diagnosis.PRecord.Logical := tlogicalDiagnosisSet(Diagnosis.StrToLogical16(AFieldText));
  end;
end;

procedure TDiagnosisColl.SetItem(Index: Integer; const Value: TDiagnosisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDiagnosisColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListDiagnosisSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TDiagnosisItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Diagnosis_code_CL011:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
      Diagnosis_additionalCode_CL011:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
      Diagnosis_rank:
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
      Diagnosis_CL011Pos:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
      Diagnosis_MkbPos:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
      Diagnosis_MkbAddPos:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListDiagnosisSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TDiagnosisColl.ShowGrid(Grid: TTeeGrid);
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

procedure TDiagnosisColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDiagnosisSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDiagnosisSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TDiagnosisColl.SortByIndexAnsiString;
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

procedure TDiagnosisColl.SortByIndexInt;
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

procedure TDiagnosisColl.SortByIndexWord;
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

procedure TDiagnosisColl.SortByIndexValue(propIndex: TDiagnosisItem.TPropertyIndex);
begin
  case propIndex of
    Diagnosis_code_CL011: SortByIndexAnsiString;
    Diagnosis_additionalCode_CL011: SortByIndexAnsiString;
    Diagnosis_rank: SortByIndexWord;
    Diagnosis_CL011Pos: SortByIndexInt;
    Diagnosis_MkbPos: SortByIndexInt;
    Diagnosis_MkbAddPos: SortByIndexInt;
  end;
end;



//CREATE TABLE DIAGNOSIS (
//    ID                              TID /* TID = INTEGER NOT NULL */,
//    DOKUMENT_ID                     INTEGER,
//    DOKUMENT_TYPE                   SMALLINT,
//    DIAGNOSIS_CODE_CL011            TICD /* TICD = VARCHAR(6) */,
//    DIAGNOSIS_ADDITIONALCODE_CL011  TICD /* TICD = VARCHAR(6) */,
//    DIAGNOSIS_RANK                  SMALLINT,
//    DIAGNOSIS_ONSETDATETIME         TIMESTAMP,
//    DIAGNOSIS_CL011POS              INTEGER,
//    DIAGNOSIS_LOGICAL               INTEGER,
//    DIAGNOSIS_MKBPOS                INTEGER
//);
//
//
//
//ALTER TABLE DIAGNOSIS ADD CONSTRAINT PK_DIAGNOSIS PRIMARY KEY (ID);

end.