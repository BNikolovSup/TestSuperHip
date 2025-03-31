unit Table.PatientNew;

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
TLogicalPatientNew = (
    BLOOD_TYPE_0,
    BLOOD_TYPE_A1,
    BLOOD_TYPE_A2,
    BLOOD_TYPE_B,
    BLOOD_TYPE_A1B,
    BLOOD_TYPE_A2B,
    BLOOD_TYPE_A,
    BLOOD_TYPE_AB,
    SEX_TYPE_F,
    SEX_TYPE_M,
    NZIS_PID_TYPE_1,
    NZIS_PID_TYPE_2,
    NZIS_PID_TYPE_3,
    NZIS_PID_TYPE_4,
    NZIS_PID_TYPE_5,
    EHRH_PATIENT,
    GDPR_PRINTED,
    KYRMA3MES,
    KYRMA6MES,
    PID_TYPE_B,
    PID_TYPE_E,
    PID_TYPE_L,
    PID_TYPE_S,
    PID_TYPE_F,
    RH_POS,
    RH_NEG);
TlogicalPatientNewSet = set of TLogicalPatientNew;


TPatientNewItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
PatientNew_BABY_NUMBER
, PatientNew_BIRTH_DATE
, PatientNew_DIE_DATE
, PatientNew_DIE_FROM
, PatientNew_DOSIENOMER
, PatientNew_DZI_NUMBER
, PatientNew_EGN
, PatientNew_EHIC_NO
, PatientNew_FNAME
, PatientNew_ID
, PatientNew_LAK_NUMBER
, PatientNew_LNAME
, PatientNew_NZIS_BEBE
, PatientNew_NZIS_PID
, PatientNew_RACE
, PatientNew_SNAME
, PatientNew_Logical
);
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecPatientNew = ^TRecPatientNew;
      TRecPatientNew = record
        BABY_NUMBER: integer;
        BIRTH_DATE: TDate;
        DIE_DATE: TDate;
        DIE_FROM: AnsiString;
        DOSIENOMER: AnsiString;
        DZI_NUMBER: AnsiString;
        EGN: AnsiString;
        EHIC_NO: AnsiString;
        FNAME: AnsiString;
        ID: integer;
        LAK_NUMBER: integer;
        LNAME: AnsiString;
        NZIS_BEBE: AnsiString;
        NZIS_PID: AnsiString;
        RACE: double;
        SNAME: AnsiString;
        Logical: TlogicalPatientNewSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPatientNew;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPatientNew;
    procedure UpdatePatientNew;
    procedure SavePatientNew(var dataPosition: Cardinal);
    procedure NewPRecord; override;
    function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
  	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
    function GetCollType: TCollectionsType; override;
  end;


  TPatientNewColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TPatientNewItem;
    procedure SetItem(Index: Integer; const Value: TPatientNewItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	  tempItem: TPatientNewItem;
	  ListForFDB: TList<TPatientNewItem>;
    ListPatientNewSearch: TList<TPatientNewItem>;
	  PRecordSearch: ^TPatientNewItem.TRecPatientNew;
    ArrPropSearch: TArray<TPatientNewItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TPatientNewItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPatientNewItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; PatientNew: TPatientNewItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PatientNew: TPatientNewItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TPatientNewItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;

	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TPatientNewItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPatientNewItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TPatientNewItem.TPropertyIndex);
    property Items[Index: Integer]: TPatientNewItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchLog(Log: TlogicalPatientNewSet);
  end;

implementation

{ TPatientNewItem }

constructor TPatientNewItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPatientNewItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPatientNewItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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
    case PropertyIndex of
      PatientNew_EGN: Self.PRecord.EGN := arrstr[i];
    end;
    inc(i);
  end;
end;

function TPatientNewItem.GetCollType: TCollectionsType;
begin
  Result := ctPatientNew;
end;

function TPatientNewItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TPatientNewItem.InsertPatientNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPatientNew;
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
            PatientNew_BABY_NUMBER: SaveData(PRecord.BABY_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_BIRTH_DATE: SaveData(PRecord.BIRTH_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_DATE: SaveData(PRecord.DIE_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_FROM: SaveData(PRecord.DIE_FROM, PropPosition, metaPosition, dataPosition);
            PatientNew_DOSIENOMER: SaveData(PRecord.DOSIENOMER, PropPosition, metaPosition, dataPosition);
            PatientNew_DZI_NUMBER: SaveData(PRecord.DZI_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNew_EHIC_NO: SaveData(PRecord.EHIC_NO, PropPosition, metaPosition, dataPosition);
            PatientNew_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PatientNew_LAK_NUMBER: SaveData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_BEBE: SaveData(PRecord.NZIS_BEBE, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_PID: SaveData(PRecord.NZIS_PID, PropPosition, metaPosition, dataPosition);
            PatientNew_RACE: SaveData(PRecord.RACE, PropPosition, metaPosition, dataPosition);
            PatientNew_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TPatientNewItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TPatientNewItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TPatientNewItem;
begin
  Result := True;
  for i := 0 to Length(TPatientNewColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TPatientNewColl(coll).ArrPropSearchClc[i];
	  ATempItem := TPatientNewColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        PatientNew_BABY_NUMBER: Result := IsFinded(ATempItem.PRecord.BABY_NUMBER, buf, FPosDataADB, word(PatientNew_BABY_NUMBER), cot);
            PatientNew_BIRTH_DATE: Result := IsFinded(ATempItem.PRecord.BIRTH_DATE, buf, FPosDataADB, word(PatientNew_BIRTH_DATE), cot);
            PatientNew_DIE_DATE: Result := IsFinded(ATempItem.PRecord.DIE_DATE, buf, FPosDataADB, word(PatientNew_DIE_DATE), cot);
            PatientNew_DIE_FROM: Result := IsFinded(ATempItem.PRecord.DIE_FROM, buf, FPosDataADB, word(PatientNew_DIE_FROM), cot);
            PatientNew_DOSIENOMER: Result := IsFinded(ATempItem.PRecord.DOSIENOMER, buf, FPosDataADB, word(PatientNew_DOSIENOMER), cot);
            PatientNew_DZI_NUMBER: Result := IsFinded(ATempItem.PRecord.DZI_NUMBER, buf, FPosDataADB, word(PatientNew_DZI_NUMBER), cot);
            PatientNew_EGN: Result := IsFinded(ATempItem.PRecord.EGN, buf, FPosDataADB, word(PatientNew_EGN), cot);
            PatientNew_EHIC_NO: Result := IsFinded(ATempItem.PRecord.EHIC_NO, buf, FPosDataADB, word(PatientNew_EHIC_NO), cot);
            PatientNew_FNAME: Result := IsFinded(ATempItem.PRecord.FNAME, buf, FPosDataADB, word(PatientNew_FNAME), cot);
            PatientNew_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(PatientNew_ID), cot);
            PatientNew_LAK_NUMBER: Result := IsFinded(ATempItem.PRecord.LAK_NUMBER, buf, FPosDataADB, word(PatientNew_LAK_NUMBER), cot);
            PatientNew_LNAME: Result := IsFinded(ATempItem.PRecord.LNAME, buf, FPosDataADB, word(PatientNew_LNAME), cot);
            PatientNew_NZIS_BEBE: Result := IsFinded(ATempItem.PRecord.NZIS_BEBE, buf, FPosDataADB, word(PatientNew_NZIS_BEBE), cot);
            PatientNew_NZIS_PID: Result := IsFinded(ATempItem.PRecord.NZIS_PID, buf, FPosDataADB, word(PatientNew_NZIS_PID), cot);
            PatientNew_RACE: Result := IsFinded(ATempItem.PRecord.RACE, buf, FPosDataADB, word(PatientNew_RACE), cot);
            PatientNew_SNAME: Result := IsFinded(ATempItem.PRecord.SNAME, buf, FPosDataADB, word(PatientNew_SNAME), cot);
            PatientNew_Logical: Result := IsFinded(TLogicalData32(ATempItem.PRecord.Logical), buf, FPosDataADB, word(PatientNew_Logical), cot);
      end;
    end;
  end;
end;

procedure TPatientNewItem.NewPrecord;
begin
  inherited;
  New(PRecord);
  PRecord.setProp := [];
end;

procedure TPatientNewItem.SavePatientNew(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNew;
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
            PatientNew_BABY_NUMBER: SaveData(PRecord.BABY_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_BIRTH_DATE: SaveData(PRecord.BIRTH_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_DATE: SaveData(PRecord.DIE_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_FROM: SaveData(PRecord.DIE_FROM, PropPosition, metaPosition, dataPosition);
            PatientNew_DOSIENOMER: SaveData(PRecord.DOSIENOMER, PropPosition, metaPosition, dataPosition);
            PatientNew_DZI_NUMBER: SaveData(PRecord.DZI_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNew_EHIC_NO: SaveData(PRecord.EHIC_NO, PropPosition, metaPosition, dataPosition);
            PatientNew_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PatientNew_LAK_NUMBER: SaveData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_BEBE: SaveData(PRecord.NZIS_BEBE, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_PID: SaveData(PRecord.NZIS_PID, PropPosition, metaPosition, dataPosition);
            PatientNew_RACE: SaveData(PRecord.RACE, PropPosition, metaPosition, dataPosition);
            PatientNew_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TPatientNewItem.UpdatePatientNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNew;
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
            PatientNew_BABY_NUMBER: UpdateData(PRecord.BABY_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_BIRTH_DATE: UpdateData(PRecord.BIRTH_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_DATE: UpdateData(PRecord.DIE_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_FROM: UpdateData(PRecord.DIE_FROM, PropPosition, metaPosition, dataPosition);
            PatientNew_DOSIENOMER: UpdateData(PRecord.DOSIENOMER, PropPosition, metaPosition, dataPosition);
            PatientNew_DZI_NUMBER: UpdateData(PRecord.DZI_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNew_EHIC_NO: UpdateData(PRecord.EHIC_NO, PropPosition, metaPosition, dataPosition);
            PatientNew_FNAME: UpdateData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PatientNew_LAK_NUMBER: UpdateData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_LNAME: UpdateData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_BEBE: UpdateData(PRecord.NZIS_BEBE, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_PID: UpdateData(PRecord.NZIS_PID, PropPosition, metaPosition, dataPosition);
            PatientNew_RACE: UpdateData(PRecord.RACE, PropPosition, metaPosition, dataPosition);
            PatientNew_SNAME: UpdateData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
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

{ TPatientNewColl }

function TPatientNewColl.AddItem(ver: word): TPatientNewItem;
begin
  Result := TPatientNewItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TPatientNewColl.AddItemForSearch: Integer;
var
  ItemForSearch: TPatientNewItem;
begin
  ItemForSearch := TPatientNewItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TPatientNewColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TPatientNewItem.Create(nil);
  ListPatientNewSearch := TList<TPatientNewItem>.Create;
  ListForFDB := TList<TPatientNewItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TPatientNewColl.destroy;
begin
  FreeAndNil(ListPatientNewSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TPatientNewColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: Result := 'BABY_NUMBER';
    PatientNew_BIRTH_DATE: Result := 'BIRTH_DATE';
    PatientNew_DIE_DATE: Result := 'DIE_DATE';
    PatientNew_DIE_FROM: Result := 'DIE_FROM';
    PatientNew_DOSIENOMER: Result := 'DOSIENOMER';
    PatientNew_DZI_NUMBER: Result := 'DZI_NUMBER';
    PatientNew_EGN: Result := 'EGN';
    PatientNew_EHIC_NO: Result := 'EHIC_NO';
    PatientNew_FNAME: Result := 'FNAME';
    PatientNew_ID: Result := 'ID';
    PatientNew_LAK_NUMBER: Result := 'LAK_NUMBER';
    PatientNew_LNAME: Result := 'LNAME';
    PatientNew_NZIS_BEBE: Result := 'NZIS_BEBE';
    PatientNew_NZIS_PID: Result := 'NZIS_PID';
    PatientNew_RACE: Result := 'RACE';
    PatientNew_SNAME: Result := 'SNAME';
    PatientNew_Logical: Result := 'Logical';
  end;
end;

procedure TPatientNewColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TPatientNewItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TPatientNewColl.FieldCount: Integer; 
begin
  inherited;
  Result := 17;
end;

procedure TPatientNewColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNew: TPatientNewItem;
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNew := Items[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(PatientNew.PRecord) and (prop in PatientNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNew, AValue);
  end;
end;

procedure TPatientNewColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TPatientNewItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TPatientNewColl.GetCellFromRecord(propIndex: word; PatientNew: TPatientNewItem; var AValue: String);
var
  str: string;
begin
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: str := inttostr(PatientNew.PRecord.BABY_NUMBER);
    PatientNew_BIRTH_DATE: str := DateToStr(PatientNew.PRecord.BIRTH_DATE);
    PatientNew_DIE_DATE: str := DateToStr(PatientNew.PRecord.DIE_DATE);
    PatientNew_DIE_FROM: str := (PatientNew.PRecord.DIE_FROM);
    PatientNew_DOSIENOMER: str := (PatientNew.PRecord.DOSIENOMER);
    PatientNew_DZI_NUMBER: str := (PatientNew.PRecord.DZI_NUMBER);
    PatientNew_EGN: str := (PatientNew.PRecord.EGN);
    PatientNew_EHIC_NO: str := (PatientNew.PRecord.EHIC_NO);
    PatientNew_FNAME: str := (PatientNew.PRecord.FNAME);
    PatientNew_ID: str := inttostr(PatientNew.PRecord.ID);
    PatientNew_LAK_NUMBER: str := inttostr(PatientNew.PRecord.LAK_NUMBER);
    PatientNew_LNAME: str := (PatientNew.PRecord.LNAME);
    PatientNew_NZIS_BEBE: str := (PatientNew.PRecord.NZIS_BEBE);
    PatientNew_NZIS_PID: str := (PatientNew.PRecord.NZIS_PID);
    PatientNew_RACE: str := FloatToStr(PatientNew.PRecord.RACE);
    PatientNew_SNAME: str := (PatientNew.PRecord.SNAME);
    PatientNew_Logical: str := PatientNew.Logical32ToStr(TLogicalData32(PatientNew.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPatientNewColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TPatientNewItem;
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TPatientNewColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TPatientNewItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TPatientNewColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNew: TPatientNewItem;
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNew := ListPatientNewSearch[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(PatientNew.PRecord) and (prop in PatientNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNew, AValue);
  end;
end;

procedure TPatientNewColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PatientNew: TPatientNewItem;
  prop: TPatientNewItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PatientNew := Items[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(PatientNew.PRecord) and (prop in PatientNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNew, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNew, AFieldText);
  end;
end;

procedure TPatientNewColl.GetCellFromMap(propIndex: word; ARow: Integer; PatientNew: TPatientNewItem; var AValue: String);
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
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: str :=  inttostr(PatientNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PatientNew_BIRTH_DATE: str :=  DateToStr(PatientNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PatientNew_DIE_DATE: str :=  DateToStr(PatientNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PatientNew_DIE_FROM: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_DOSIENOMER: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_DZI_NUMBER: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_EGN: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_EHIC_NO: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_FNAME: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_ID: str :=  inttostr(PatientNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PatientNew_LAK_NUMBER: str :=  inttostr(PatientNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PatientNew_LNAME: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_NZIS_BEBE: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_NZIS_PID: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_SNAME: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_Logical: str :=  PatientNew.Logical32ToStr(PatientNew.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPatientNewColl.GetItem(Index: Integer): TPatientNewItem;
begin
  Result := TPatientNewItem(inherited GetItem(Index));
end;


procedure TPatientNewColl.IndexValue(propIndex: TPatientNewItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPatientNewItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PatientNew_BABY_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PatientNew_DIE_FROM:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_DOSIENOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_DZI_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_EHIC_NO:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_FNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PatientNew_LAK_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PatientNew_LNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_NZIS_BEBE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_NZIS_PID:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_SNAME:
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

procedure TPatientNewColl.IndexValueListNodes(propIndex: TPatientNewItem.TPropertyIndex);
begin

end;

procedure TPatientNewColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TPatientNewItem;
begin
  if index < 0 then
  begin
    Tempitem := TPatientNewItem.Create(nil);
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



procedure TPatientNewColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
begin
  if Text = '' then
  begin
    Exclude(ListForFDB[0].PRecord.setProp, TPatientNewItem.TPropertyIndex(field));
  end
  else
  begin
    include(ListForFDB[0].PRecord.setProp, TPatientNewItem.TPropertyIndex(field));
    //ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFDB[0].PRecord.setProp;
  if cotSens in Condition then
  begin
    case TPatientNewItem.TPropertyIndex(field) of
      PatientNew_EGN: ListForFDB[0].PRecord.EGN  := Text;
      PatientNew_FNAME: ListForFDB[0].PRecord.FNAME  := Text;
      PatientNew_SNAME: ListForFDB[0].PRecord.SNAME  := Text;
      PatientNew_ID: ListForFDB[0].PRecord.ID  := StrToInt(Text);
      //PatientNew_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
    end;
  end
  else
  begin
    case TPatientNewItem.TPropertyIndex(field) of
      PatientNew_EGN: ListForFDB[0].PRecord.EGN  := AnsiUpperCase(Text);
      PatientNew_FNAME: ListForFDB[0].PRecord.FNAME  := AnsiUpperCase(Text);
      PatientNew_SNAME: ListForFDB[0].PRecord.SNAME  := AnsiUpperCase(Text);
      PatientNew_ID: ListForFDB[0].PRecord.ID  := StrToInt(Text);
      //PatientNew_BIRTH_DATE: ListForFDB[0].PRecord.BIRTH_DATE  := StrToInt(edt.Text);
    end;
  end;
end;

procedure TPatientNewColl.OnSetTextSearchLog(Log: TlogicalPatientNewSet);
begin
  ListForFDB[0].PRecord.Logical := Log;
end;

function TPatientNewColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: Result := actinteger;
    PatientNew_BIRTH_DATE: Result := actTDate;
    PatientNew_DIE_DATE: Result := actTDate;
    PatientNew_DIE_FROM: Result := actAnsiString;
    PatientNew_DOSIENOMER: Result := actAnsiString;
    PatientNew_DZI_NUMBER: Result := actAnsiString;
    PatientNew_EGN: Result := actAnsiString;
    PatientNew_EHIC_NO: Result := actAnsiString;
    PatientNew_FNAME: Result := actAnsiString;
    PatientNew_ID: Result := actinteger;
    PatientNew_LAK_NUMBER: Result := actinteger;
    PatientNew_LNAME: Result := actAnsiString;
    PatientNew_NZIS_BEBE: Result := actAnsiString;
    PatientNew_NZIS_PID: Result := actAnsiString;
    PatientNew_RACE: Result := actdouble;
    PatientNew_SNAME: Result := actAnsiString;
    PatientNew_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

procedure TPatientNewColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PatientNew: TPatientNewItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  PatientNew := Items[ARow];
  if not Assigned(PatientNew.PRecord) then
  begin
    New(PatientNew.PRecord);
    PatientNew.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPatientNewItem.TPropertyIndex(ACol) of
      PatientNew_BABY_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PatientNew_BIRTH_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PatientNew_DIE_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PatientNew_DIE_FROM: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_DOSIENOMER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_DZI_NUMBER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_EGN: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_EHIC_NO: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_FNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_ID: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PatientNew_LAK_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PatientNew_LNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_NZIS_BEBE: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_NZIS_PID: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_SNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
    if PatientNew.PRecord.setProp = [] then
    begin
      Dispose(PatientNew.PRecord);
      PatientNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
  case TPatientNewItem.TPropertyIndex(ACol) of
    PatientNew_BABY_NUMBER: PatientNew.PRecord.BABY_NUMBER := StrToInt(AValue);
    PatientNew_BIRTH_DATE: PatientNew.PRecord.BIRTH_DATE := StrToDate(AValue);
    PatientNew_DIE_DATE: PatientNew.PRecord.DIE_DATE := StrToDate(AValue);
    PatientNew_DIE_FROM: PatientNew.PRecord.DIE_FROM := AValue;
    PatientNew_DOSIENOMER: PatientNew.PRecord.DOSIENOMER := AValue;
    PatientNew_DZI_NUMBER: PatientNew.PRecord.DZI_NUMBER := AValue;
    PatientNew_EGN: PatientNew.PRecord.EGN := AValue;
    PatientNew_EHIC_NO: PatientNew.PRecord.EHIC_NO := AValue;
    PatientNew_FNAME: PatientNew.PRecord.FNAME := AValue;
    PatientNew_ID: PatientNew.PRecord.ID := StrToInt(AValue);
    PatientNew_LAK_NUMBER: PatientNew.PRecord.LAK_NUMBER := StrToInt(AValue);
    PatientNew_LNAME: PatientNew.PRecord.LNAME := AValue;
    PatientNew_NZIS_BEBE: PatientNew.PRecord.NZIS_BEBE := AValue;
    PatientNew_NZIS_PID: PatientNew.PRecord.NZIS_PID := AValue;
    PatientNew_RACE: PatientNew.PRecord.RACE := StrToFloat(AValue);
    PatientNew_SNAME: PatientNew.PRecord.SNAME := AValue;
    PatientNew_Logical: PatientNew.PRecord.Logical := tlogicalPatientNewSet(PatientNew.StrToLogical32(AValue));
  end;
end;

procedure TPatientNewColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PatientNew: TPatientNewItem;
begin
  if Count = 0 then Exit;

  PatientNew := Items[ARow];
  if not Assigned(PatientNew.PRecord) then
  begin
    New(PatientNew.PRecord);
    PatientNew.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPatientNewItem.TPropertyIndex(ACol) of
      PatientNew_BABY_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PatientNew_BIRTH_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PatientNew_DIE_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PatientNew_DIE_FROM: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_DOSIENOMER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_DZI_NUMBER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_EGN: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_EHIC_NO: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_FNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_ID: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PatientNew_LAK_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PatientNew_LNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_NZIS_BEBE: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_NZIS_PID: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_SNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
    if PatientNew.PRecord.setProp = [] then
    begin
      Dispose(PatientNew.PRecord);
      PatientNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
  case TPatientNewItem.TPropertyIndex(ACol) of
    PatientNew_BABY_NUMBER: PatientNew.PRecord.BABY_NUMBER := StrToInt(AFieldText);
    PatientNew_BIRTH_DATE: PatientNew.PRecord.BIRTH_DATE := StrToDate(AFieldText);
    PatientNew_DIE_DATE: PatientNew.PRecord.DIE_DATE := StrToDate(AFieldText);
    PatientNew_DIE_FROM: PatientNew.PRecord.DIE_FROM := AFieldText;
    PatientNew_DOSIENOMER: PatientNew.PRecord.DOSIENOMER := AFieldText;
    PatientNew_DZI_NUMBER: PatientNew.PRecord.DZI_NUMBER := AFieldText;
    PatientNew_EGN: PatientNew.PRecord.EGN := AFieldText;
    PatientNew_EHIC_NO: PatientNew.PRecord.EHIC_NO := AFieldText;
    PatientNew_FNAME: PatientNew.PRecord.FNAME := AFieldText;
    PatientNew_ID: PatientNew.PRecord.ID := StrToInt(AFieldText);
    PatientNew_LAK_NUMBER: PatientNew.PRecord.LAK_NUMBER := StrToInt(AFieldText);
    PatientNew_LNAME: PatientNew.PRecord.LNAME := AFieldText;
    PatientNew_NZIS_BEBE: PatientNew.PRecord.NZIS_BEBE := AFieldText;
    PatientNew_NZIS_PID: PatientNew.PRecord.NZIS_PID := AFieldText;
    PatientNew_RACE: PatientNew.PRecord.RACE := StrToFloat(AFieldText);
    PatientNew_SNAME: PatientNew.PRecord.SNAME := AFieldText;
    PatientNew_Logical: PatientNew.PRecord.Logical := tlogicalPatientNewSet(PatientNew.StrToLogical32(AFieldText));
  end;
end;

procedure TPatientNewColl.SetItem(Index: Integer; const Value: TPatientNewItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPatientNewColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPatientNewSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPatientNewItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  PatientNew_BABY_NUMBER: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListPatientNewSearch.Add(self.Items[i]);
  end;
end;
      PatientNew_DIE_FROM:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_DOSIENOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_DZI_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_EHIC_NO:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_FNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_LAK_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_LNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_NZIS_BEBE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_NZIS_PID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_SNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPatientNewColl.ShowGrid(Grid: TTeeGrid);
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

procedure TPatientNewColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TPatientNewItem>);
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

procedure TPatientNewColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPatientNewSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPatientNewSearch.Count]);

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

procedure TPatientNewColl.SortByIndexAnsiString;
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

procedure TPatientNewColl.SortByIndexInt;
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

procedure TPatientNewColl.SortByIndexWord;
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

procedure TPatientNewColl.SortByIndexValue(propIndex: TPatientNewItem.TPropertyIndex);
begin
  case propIndex of
    PatientNew_BABY_NUMBER: SortByIndexInt;
      PatientNew_DIE_FROM: SortByIndexAnsiString;
      PatientNew_DOSIENOMER: SortByIndexAnsiString;
      PatientNew_DZI_NUMBER: SortByIndexAnsiString;
      PatientNew_EGN: SortByIndexAnsiString;
      PatientNew_EHIC_NO: SortByIndexAnsiString;
      PatientNew_FNAME: SortByIndexAnsiString;
      PatientNew_ID: SortByIndexInt;
      PatientNew_LAK_NUMBER: SortByIndexInt;
      PatientNew_LNAME: SortByIndexAnsiString;
      PatientNew_NZIS_BEBE: SortByIndexAnsiString;
      PatientNew_NZIS_PID: SortByIndexAnsiString;
      PatientNew_SNAME: SortByIndexAnsiString;
  end;
end;

end.