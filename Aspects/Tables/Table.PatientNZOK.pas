unit Table.PatientNZOK;

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


TPatientNZOKItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (PatientNZOK_RZOK
, PatientNZOK_EGN
, PatientNZOK_LNC
, PatientNZOK_SNN
, PatientNZOK_EZOK
, PatientNZOK_SPOGODBA
, PatientNZOK_UIN
, PatientNZOK_RCZ_NUMBER
, PatientNZOK_FROM_DATE
, PatientNZOK_TO_DATE
, PatientNZOK_REG_TYPE
, PatientNZOK_REASON_OTP
, PatientNZOK_CHOICE_TYPE
, PatientNZOK_NAME_ZOL
, PatientNZOK_NAME_OPL
);
      TSetProp = set of TPropertyIndex;
      PRecPatientNZOK = ^TRecPatientNZOK;
      TRecPatientNZOK = record
        RZOK: AnsiString;
        EGN: AnsiString;
        LNC: AnsiString;
        SNN: AnsiString;
        EZOK: AnsiString;
        SPOGODBA: AnsiString;
        UIN: AnsiString;
        RCZ_NUMBER: AnsiString;
        FROM_DATE: AnsiString;
        TO_DATE: AnsiString;
        REG_TYPE: AnsiString;
        REASON_OTP: AnsiString;
        CHOICE_TYPE: AnsiString;
        NAME_ZOL: AnsiString;
        NAME_OPL: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPatientNZOK;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPatientNZOK;
    procedure UpdatePatientNZOK;
    procedure SavePatientNZOK(var dataPosition: Cardinal);
  end;


  TPatientNZOKColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TPatientNZOKItem;
    procedure SetItem(Index: Integer; const Value: TPatientNZOKItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListPatientNZOKSearch: TList<TPatientNZOKItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPatientNZOKItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; PatientNZOK: TPatientNZOKItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PatientNZOK: TPatientNZOKItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
    property Items[Index: Integer]: TPatientNZOKItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TPatientNZOKItem }

constructor TPatientNZOKItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPatientNZOKItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPatientNZOKItem.InsertPatientNZOK;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPatientNZOK;
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
            PatientNZOK_RZOK: SaveData(PRecord.RZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_LNC: SaveData(PRecord.LNC, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SNN: SaveData(PRecord.SNN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EZOK: SaveData(PRecord.EZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SPOGODBA: SaveData(PRecord.SPOGODBA, PropPosition, metaPosition, dataPosition);
            PatientNZOK_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_RCZ_NUMBER: SaveData(PRecord.RCZ_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNZOK_FROM_DATE: SaveData(PRecord.FROM_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_TO_DATE: SaveData(PRecord.TO_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REG_TYPE: SaveData(PRecord.REG_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REASON_OTP: SaveData(PRecord.REASON_OTP, PropPosition, metaPosition, dataPosition);
            PatientNZOK_CHOICE_TYPE: SaveData(PRecord.CHOICE_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_ZOL: SaveData(PRecord.NAME_ZOL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_OPL: SaveData(PRecord.NAME_OPL, PropPosition, metaPosition, dataPosition);
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

procedure TPatientNZOKItem.SavePatientNZOK(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNZOK;
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
            PatientNZOK_RZOK: SaveData(PRecord.RZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_LNC: SaveData(PRecord.LNC, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SNN: SaveData(PRecord.SNN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EZOK: SaveData(PRecord.EZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SPOGODBA: SaveData(PRecord.SPOGODBA, PropPosition, metaPosition, dataPosition);
            PatientNZOK_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_RCZ_NUMBER: SaveData(PRecord.RCZ_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNZOK_FROM_DATE: SaveData(PRecord.FROM_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_TO_DATE: SaveData(PRecord.TO_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REG_TYPE: SaveData(PRecord.REG_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REASON_OTP: SaveData(PRecord.REASON_OTP, PropPosition, metaPosition, dataPosition);
            PatientNZOK_CHOICE_TYPE: SaveData(PRecord.CHOICE_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_ZOL: SaveData(PRecord.NAME_ZOL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_OPL: SaveData(PRecord.NAME_OPL, PropPosition, metaPosition, dataPosition);
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

procedure TPatientNZOKItem.UpdatePatientNZOK;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNZOK;
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
            PatientNZOK_RZOK: UpdateData(PRecord.RZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_LNC: UpdateData(PRecord.LNC, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SNN: UpdateData(PRecord.SNN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_EZOK: UpdateData(PRecord.EZOK, PropPosition, metaPosition, dataPosition);
            PatientNZOK_SPOGODBA: UpdateData(PRecord.SPOGODBA, PropPosition, metaPosition, dataPosition);
            PatientNZOK_UIN: UpdateData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            PatientNZOK_RCZ_NUMBER: UpdateData(PRecord.RCZ_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNZOK_FROM_DATE: UpdateData(PRecord.FROM_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_TO_DATE: UpdateData(PRecord.TO_DATE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REG_TYPE: UpdateData(PRecord.REG_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_REASON_OTP: UpdateData(PRecord.REASON_OTP, PropPosition, metaPosition, dataPosition);
            PatientNZOK_CHOICE_TYPE: UpdateData(PRecord.CHOICE_TYPE, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_ZOL: UpdateData(PRecord.NAME_ZOL, PropPosition, metaPosition, dataPosition);
            PatientNZOK_NAME_OPL: UpdateData(PRecord.NAME_OPL, PropPosition, metaPosition, dataPosition);
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

{ TPatientNZOKColl }

function TPatientNZOKColl.AddItem(ver: word): TPatientNZOKItem;
begin
  Result := TPatientNZOKItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TPatientNZOKColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListPatientNZOKSearch := TList<TPatientNZOKItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TPatientNZOKColl.destroy;
begin
  FreeAndNil(ListPatientNZOKSearch);
  inherited;
end;

function TPatientNZOKColl.DisplayName(propIndex: Word): string;
begin
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: Result := 'RZOK';
    PatientNZOK_EGN: Result := 'EGN';
    PatientNZOK_LNC: Result := 'LNC';
    PatientNZOK_SNN: Result := 'SNN';
    PatientNZOK_EZOK: Result := 'EZOK';
    PatientNZOK_SPOGODBA: Result := 'SPOGODBA';
    PatientNZOK_UIN: Result := 'UIN';
    PatientNZOK_RCZ_NUMBER: Result := 'RCZ_NUMBER';
    PatientNZOK_FROM_DATE: Result := 'FROM_DATE';
    PatientNZOK_TO_DATE: Result := 'TO_DATE';
    PatientNZOK_REG_TYPE: Result := 'REG_TYPE';
    PatientNZOK_REASON_OTP: Result := 'REASON_OTP';
    PatientNZOK_CHOICE_TYPE: Result := 'CHOICE_TYPE';
    PatientNZOK_NAME_ZOL: Result := 'NAME_ZOL';
    PatientNZOK_NAME_OPL: Result := 'NAME_OPL';
  end;
end;

procedure TPatientNZOKColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TPatientNZOKItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TPatientNZOKColl.FieldCount: Integer;
begin
  Result := 15;
end;

procedure TPatientNZOKColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNZOK: TPatientNZOKItem;
  ACol: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNZOK := Items[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if ACol = Self.FieldCount then
  begin
    AValue := IntToStr(ARow + 1);
    Exit;
  end;
  if Assigned(PatientNZOK.PRecord) and (prop in PatientNZOK.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNZOK, AValue);
  end
  else
  begin
    try
      if self.Buf = nil then Exit;
      GetCellFromMap(ACol, ARow, PatientNZOK, AValue);
    except

    end;
  end;
end;

procedure TPatientNZOKColl.GetCellFromRecord(propIndex: word; PatientNZOK: TPatientNZOKItem; var AValue: String);
var
  str: string;
begin
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: str := (PatientNZOK.PRecord.RZOK);
    PatientNZOK_EGN: str := (PatientNZOK.PRecord.EGN);
    PatientNZOK_LNC: str := (PatientNZOK.PRecord.LNC);
    PatientNZOK_SNN: str := (PatientNZOK.PRecord.SNN);
    PatientNZOK_EZOK: str := (PatientNZOK.PRecord.EZOK);
    PatientNZOK_SPOGODBA: str := (PatientNZOK.PRecord.SPOGODBA);
    PatientNZOK_UIN: str := (PatientNZOK.PRecord.UIN);
    PatientNZOK_RCZ_NUMBER: str := (PatientNZOK.PRecord.RCZ_NUMBER);
    PatientNZOK_FROM_DATE: str := (PatientNZOK.PRecord.FROM_DATE);
    PatientNZOK_TO_DATE: str := (PatientNZOK.PRecord.TO_DATE);
    PatientNZOK_REG_TYPE: str := (PatientNZOK.PRecord.REG_TYPE);
    PatientNZOK_REASON_OTP: str := (PatientNZOK.PRecord.REASON_OTP);
    PatientNZOK_CHOICE_TYPE: str := (PatientNZOK.PRecord.CHOICE_TYPE);
    PatientNZOK_NAME_ZOL: str := (PatientNZOK.PRecord.NAME_ZOL);
    PatientNZOK_NAME_OPL: str := (PatientNZOK.PRecord.NAME_OPL);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPatientNZOKColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNZOK: TPatientNZOKItem;
  ACol: Integer;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNZOK := ListPatientNZOKSearch[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if Assigned(PatientNZOK.PRecord) and (prop in PatientNZOK.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNZOK, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNZOK, AValue);
  end;
end;

procedure TPatientNZOKColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PatientNZOK: TPatientNZOKItem;
  prop: TPatientNZOKItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PatientNZOK := Items[ARow];
  prop := TPatientNZOKItem.TPropertyIndex(ACol);
  if Assigned(PatientNZOK.PRecord) and (prop in PatientNZOK.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNZOK, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNZOK, AFieldText);
  end;
end;

procedure TPatientNZOKColl.GetCellFromMap(propIndex: word; ARow: Integer; PatientNZOK: TPatientNZOKItem; var AValue: String);
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
  case TPatientNZOKItem.TPropertyIndex(propIndex) of
    PatientNZOK_RZOK: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_EGN: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_LNC: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_SNN: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_EZOK: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_SPOGODBA: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_UIN: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_RCZ_NUMBER: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_FROM_DATE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_TO_DATE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_REG_TYPE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_REASON_OTP: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_CHOICE_TYPE: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_NAME_ZOL: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNZOK_NAME_OPL: str :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPatientNZOKColl.GetItem(Index: Integer): TPatientNZOKItem;
begin
  Result := TPatientNZOKItem(inherited GetItem(Index));
end;


procedure TPatientNZOKColl.IndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPatientNZOKItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PatientNZOK_RZOK:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      PatientNZOK_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_LNC:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_SNN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_EZOK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_SPOGODBA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_UIN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_RCZ_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_FROM_DATE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_TO_DATE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_REG_TYPE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_REASON_OTP:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_CHOICE_TYPE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_NAME_ZOL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNZOK_NAME_OPL:
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

procedure TPatientNZOKColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PatientNZOK: TPatientNZOKItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  PatientNZOK := Items[ARow];
  if not Assigned(PatientNZOK.PRecord) then
  begin
    New(PatientNZOK.PRecord);
    PatientNZOK.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPatientNZOKItem.TPropertyIndex(ACol) of
      PatientNZOK_RZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_EGN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_LNC: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_SNN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_EZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_SPOGODBA: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_UIN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_RCZ_NUMBER: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_FROM_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_TO_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_REG_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_REASON_OTP: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_CHOICE_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_NAME_ZOL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNZOK_NAME_OPL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
    if PatientNZOK.PRecord.setProp = [] then
    begin
      Dispose(PatientNZOK.PRecord);
      PatientNZOK.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
  case TPatientNZOKItem.TPropertyIndex(ACol) of
    PatientNZOK_RZOK: PatientNZOK.PRecord.RZOK := AValue;
    PatientNZOK_EGN: PatientNZOK.PRecord.EGN := AValue;
    PatientNZOK_LNC: PatientNZOK.PRecord.LNC := AValue;
    PatientNZOK_SNN: PatientNZOK.PRecord.SNN := AValue;
    PatientNZOK_EZOK: PatientNZOK.PRecord.EZOK := AValue;
    PatientNZOK_SPOGODBA: PatientNZOK.PRecord.SPOGODBA := AValue;
    PatientNZOK_UIN: PatientNZOK.PRecord.UIN := AValue;
    PatientNZOK_RCZ_NUMBER: PatientNZOK.PRecord.RCZ_NUMBER := AValue;
    PatientNZOK_FROM_DATE: PatientNZOK.PRecord.FROM_DATE := AValue;
    PatientNZOK_TO_DATE: PatientNZOK.PRecord.TO_DATE := AValue;
    PatientNZOK_REG_TYPE: PatientNZOK.PRecord.REG_TYPE := AValue;
    PatientNZOK_REASON_OTP: PatientNZOK.PRecord.REASON_OTP := AValue;
    PatientNZOK_CHOICE_TYPE: PatientNZOK.PRecord.CHOICE_TYPE := AValue;
    PatientNZOK_NAME_ZOL: PatientNZOK.PRecord.NAME_ZOL := AValue;
    PatientNZOK_NAME_OPL: PatientNZOK.PRecord.NAME_OPL := AValue;
  end;
end;

procedure TPatientNZOKColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PatientNZOK: TPatientNZOKItem;
begin
  if Count = 0 then Exit;

  PatientNZOK := Items[ARow];
  if not Assigned(PatientNZOK.PRecord) then
  begin
    New(PatientNZOK.PRecord);
    PatientNZOK.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPatientNZOKItem.TPropertyIndex(ACol) of
      PatientNZOK_RZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_EGN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_LNC: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_SNN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_EZOK: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_SPOGODBA: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_UIN: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_RCZ_NUMBER: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_FROM_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_TO_DATE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_REG_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_REASON_OTP: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_CHOICE_TYPE: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_NAME_ZOL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNZOK_NAME_OPL: isOld :=  PatientNZOK.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
    if PatientNZOK.PRecord.setProp = [] then
    begin
      Dispose(PatientNZOK.PRecord);
      PatientNZOK.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNZOK.PRecord.setProp, TPatientNZOKItem.TPropertyIndex(ACol));
  case TPatientNZOKItem.TPropertyIndex(ACol) of
    PatientNZOK_RZOK: PatientNZOK.PRecord.RZOK := AFieldText;
    PatientNZOK_EGN: PatientNZOK.PRecord.EGN := AFieldText;
    PatientNZOK_LNC: PatientNZOK.PRecord.LNC := AFieldText;
    PatientNZOK_SNN: PatientNZOK.PRecord.SNN := AFieldText;
    PatientNZOK_EZOK: PatientNZOK.PRecord.EZOK := AFieldText;
    PatientNZOK_SPOGODBA: PatientNZOK.PRecord.SPOGODBA := AFieldText;
    PatientNZOK_UIN: PatientNZOK.PRecord.UIN := AFieldText;
    PatientNZOK_RCZ_NUMBER: PatientNZOK.PRecord.RCZ_NUMBER := AFieldText;
    PatientNZOK_FROM_DATE: PatientNZOK.PRecord.FROM_DATE := AFieldText;
    PatientNZOK_TO_DATE: PatientNZOK.PRecord.TO_DATE := AFieldText;
    PatientNZOK_REG_TYPE: PatientNZOK.PRecord.REG_TYPE := AFieldText;
    PatientNZOK_REASON_OTP: PatientNZOK.PRecord.REASON_OTP := AFieldText;
    PatientNZOK_CHOICE_TYPE: PatientNZOK.PRecord.CHOICE_TYPE := AFieldText;
    PatientNZOK_NAME_ZOL: PatientNZOK.PRecord.NAME_ZOL := AFieldText;
    PatientNZOK_NAME_OPL: PatientNZOK.PRecord.NAME_OPL := AFieldText;
  end;
end;

procedure TPatientNZOKColl.SetItem(Index: Integer; const Value: TPatientNZOKItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPatientNZOKColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPatientNZOKSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPatientNZOKItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  PatientNZOK_RZOK:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListPatientNZOKSearch.Add(self.Items[i]);
  end;
end;
      PatientNZOK_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_LNC:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_SNN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_EZOK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_SPOGODBA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_RCZ_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_FROM_DATE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_TO_DATE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_REG_TYPE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_REASON_OTP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_CHOICE_TYPE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_NAME_ZOL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
      PatientNZOK_NAME_OPL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNZOKSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPatientNZOKColl.ShowGrid(Grid: TTeeGrid);
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

procedure TPatientNZOKColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPatientNZOKSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPatientNZOKSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TPatientNZOKColl.SortByIndexAnsiString;
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

procedure TPatientNZOKColl.SortByIndexInt;
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

procedure TPatientNZOKColl.SortByIndexValue(propIndex: TPatientNZOKItem.TPropertyIndex);
begin
  case propIndex of
    PatientNZOK_RZOK: SortByIndexAnsiString;
      PatientNZOK_EGN: SortByIndexAnsiString;
      PatientNZOK_LNC: SortByIndexAnsiString;
      PatientNZOK_SNN: SortByIndexAnsiString;
      PatientNZOK_EZOK: SortByIndexAnsiString;
      PatientNZOK_SPOGODBA: SortByIndexAnsiString;
      PatientNZOK_UIN: SortByIndexAnsiString;
      PatientNZOK_RCZ_NUMBER: SortByIndexAnsiString;
      PatientNZOK_FROM_DATE: SortByIndexAnsiString;
      PatientNZOK_TO_DATE: SortByIndexAnsiString;
      PatientNZOK_REG_TYPE: SortByIndexAnsiString;
      PatientNZOK_REASON_OTP: SortByIndexAnsiString;
      PatientNZOK_CHOICE_TYPE: SortByIndexAnsiString;
      PatientNZOK_NAME_ZOL: SortByIndexAnsiString;
      PatientNZOK_NAME_OPL: SortByIndexAnsiString;
  end;
end;

end.