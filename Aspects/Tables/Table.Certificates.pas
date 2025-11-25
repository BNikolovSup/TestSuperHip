unit Table.Certificates;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, sbxtypes;

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


TCertificatesItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
Certificates_CERT_ID
, Certificates_SLOT_ID
, Certificates_VALID_FROM_DATE
, Certificates_VALID_TO_DATE
, Certificates_SlotNom
, Certificates_Pin
);

      TSetProp = set of TPropertyIndex;
      PRecCertificates = ^TRecCertificates;
      TRecCertificates = record
        CERT_ID: AnsiString;
        SLOT_ID: AnsiString;
        VALID_FROM_DATE: TDate;
        VALID_TO_DATE: TDate;
        SlotNom: Integer;
        Pin: AnsiString;
        setProp: TSetProp;
      end;
  private
    FCertPlug: TsbxCertificate;

  public
    PRecord: ^TRecCertificates;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCertificates;
    procedure UpdateCertificates;
    procedure SaveCertificates(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  property CertPlug: TsbxCertificate read FCertPlug write FCertPlug;
  end;


  TCertificatesColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCertificatesItem;
    procedure SetItem(Index: Integer; const Value: TCertificatesItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCertificatesItem;
	ListForFDB: TList<TCertificatesItem>;
    ListCertificatesSearch: TList<TCertificatesItem>;
	PRecordSearch: ^TCertificatesItem.TRecCertificates;
    ArrPropSearch: TArray<TCertificatesItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCertificatesItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCertificatesItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; Certificates: TCertificatesItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Certificates: TCertificatesItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCertificatesItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCertificatesItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCertificatesItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCertificatesItem.TPropertyIndex);
    property Items[Index: Integer]: TCertificatesItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);

  end;

implementation

{ TCertificatesItem }

constructor TCertificatesItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCertificatesItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCertificatesItem.InsertCertificates;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCertificates;
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
            Certificates_CERT_ID: SaveData(PRecord.CERT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_SLOT_ID: SaveData(PRecord.SLOT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_FROM_DATE: SaveData(PRecord.VALID_FROM_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_TO_DATE: SaveData(PRecord.VALID_TO_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_SlotNom: SaveData(PRecord.SlotNom, PropPosition, metaPosition, dataPosition);
            Certificates_Pin: SaveData(PRecord.Pin, PropPosition, metaPosition, dataPosition);
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

function  TCertificatesItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCertificatesItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCertificatesItem;
begin
  Result := True;
  for i := 0 to Length(TCertificatesColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCertificatesColl(coll).ArrPropSearchClc[i];
	ATempItem := TCertificatesColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        Certificates_CERT_ID: Result := IsFinded(ATempItem.PRecord.CERT_ID, buf, FPosDataADB, word(Certificates_CERT_ID), cot);
        Certificates_SLOT_ID: Result := IsFinded(ATempItem.PRecord.SLOT_ID, buf, FPosDataADB, word(Certificates_SLOT_ID), cot);
        Certificates_VALID_FROM_DATE: Result := IsFinded(ATempItem.PRecord.VALID_FROM_DATE, buf, FPosDataADB, word(Certificates_VALID_FROM_DATE), cot);
        Certificates_VALID_TO_DATE: Result := IsFinded(ATempItem.PRecord.VALID_TO_DATE, buf, FPosDataADB, word(Certificates_VALID_TO_DATE), cot);
        Certificates_SlotNom: Result := IsFinded(ATempItem.PRecord.SlotNom, buf, FPosDataADB, word(Certificates_SlotNom), cot);
        Certificates_Pin: Result := IsFinded(ATempItem.PRecord.Pin, buf, FPosDataADB, word(Certificates_Pin), cot);
      end;
    end;
  end;
end;

procedure TCertificatesItem.SaveCertificates(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCertificates;
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
            Certificates_CERT_ID: SaveData(PRecord.CERT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_SLOT_ID: SaveData(PRecord.SLOT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_FROM_DATE: SaveData(PRecord.VALID_FROM_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_TO_DATE: SaveData(PRecord.VALID_TO_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_SlotNom: SaveData(PRecord.SlotNom, PropPosition, metaPosition, dataPosition);
            Certificates_Pin: SaveData(PRecord.Pin, PropPosition, metaPosition, dataPosition);
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

procedure TCertificatesItem.UpdateCertificates;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCertificates;
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
            Certificates_CERT_ID: UpdateData(PRecord.CERT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_SLOT_ID: UpdateData(PRecord.SLOT_ID, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_FROM_DATE: UpdateData(PRecord.VALID_FROM_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_VALID_TO_DATE: UpdateData(PRecord.VALID_TO_DATE, PropPosition, metaPosition, dataPosition);
            Certificates_SlotNom: UpdateData(PRecord.SlotNom, PropPosition, metaPosition, dataPosition);
            Certificates_Pin: UpdateData(PRecord.Pin, PropPosition, metaPosition, dataPosition);
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

{ TCertificatesColl }

function TCertificatesColl.AddItem(ver: word): TCertificatesItem;
begin
  Result := TCertificatesItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCertificatesColl.AddItemForSearch: Integer;
var
  ItemForSearch: TCertificatesItem;
begin
  ItemForSearch := TCertificatesItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCertificatesColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCertificatesItem.Create(nil);
  ListCertificatesSearch := TList<TCertificatesItem>.Create;
  ListForFDB := TList<TCertificatesItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCertificatesColl.destroy;
begin
  FreeAndNil(ListCertificatesSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCertificatesColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: Result := 'CERT_ID';
    Certificates_SLOT_ID: Result := 'SLOT_ID';
    Certificates_VALID_FROM_DATE: Result := 'VALID_FROM_DATE';
    Certificates_VALID_TO_DATE: Result := 'VALID_TO_DATE';
    Certificates_SlotNom: Result := 'SlotNom';
    Certificates_Pin: Result := 'PIN';
  end;
end;



function TCertificatesColl.FieldCount: Integer;
begin
  inherited;
  Result := 6;
end;

procedure TCertificatesColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Certificates: TCertificatesItem;
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Certificates := Items[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(Certificates.PRecord) and (prop in Certificates.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Certificates, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Certificates, AValue);
  end;
end;

procedure TCertificatesColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TCertificatesItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCertificatesColl.GetCellFromRecord(propIndex: word; Certificates: TCertificatesItem; var AValue: String);
var
  str: string;
begin
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: str := (Certificates.PRecord.CERT_ID);
    Certificates_SLOT_ID: str := (Certificates.PRecord.SLOT_ID);
    Certificates_VALID_FROM_DATE: str := DateToStr(Certificates.PRecord.VALID_FROM_DATE);
    Certificates_VALID_TO_DATE: str := DateToStr(Certificates.PRecord.VALID_TO_DATE);
    Certificates_SlotNom: str := inttostr(Certificates.PRecord.SlotNom);
    Certificates_Pin: str := (Certificates.PRecord.Pin);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCertificatesColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCertificatesItem;
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCertificatesColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCertificatesItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCertificatesColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Certificates: TCertificatesItem;
  ACol: Integer;
  prop: TCertificatesItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Certificates := ListCertificatesSearch[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(Certificates.PRecord) and (prop in Certificates.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Certificates, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Certificates, AValue);
  end;
end;

procedure TCertificatesColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Certificates: TCertificatesItem;
  prop: TCertificatesItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Certificates := Items[ARow];
  prop := TCertificatesItem.TPropertyIndex(ACol);
  if Assigned(Certificates.PRecord) and (prop in Certificates.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Certificates, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Certificates, AFieldText);
  end;
end;

procedure TCertificatesColl.GetCellFromMap(propIndex: word; ARow: Integer; Certificates: TCertificatesItem; var AValue: String);
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
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: str :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Certificates_SLOT_ID: str :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Certificates_VALID_FROM_DATE: str :=  DateToStr(Certificates.getDateMap(Self.Buf, Self.posData, propIndex));
    Certificates_VALID_TO_DATE: str :=  DateToStr(Certificates.getDateMap(Self.Buf, Self.posData, propIndex));
    Certificates_SlotNom: str :=  IntToStr(Certificates.getIntMap(Self.Buf, Self.posData, propIndex));
    Certificates_Pin: str :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCertificatesColl.GetItem(Index: Integer): TCertificatesItem;
begin
  Result := TCertificatesItem(inherited GetItem(Index));
end;


procedure TCertificatesColl.IndexValue(propIndex: TCertificatesItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCertificatesItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Certificates_CERT_ID:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Certificates_SLOT_ID:
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

procedure TCertificatesColl.IndexValueListNodes(propIndex: TCertificatesItem.TPropertyIndex);
begin

end;

procedure TCertificatesColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCertificatesItem;
begin
  if index < 0 then
  begin
    Tempitem := TCertificatesItem.Create(nil);
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



function TCertificatesColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCertificatesItem.TPropertyIndex(propIndex) of
    Certificates_CERT_ID: Result := actAnsiString;
    Certificates_SLOT_ID: Result := actAnsiString;
    Certificates_VALID_FROM_DATE: Result := actTDate;
    Certificates_VALID_TO_DATE: Result := actTDate;
    Certificates_SlotNom: Result := actInteger;
    Certificates_Pin: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCertificatesColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Certificates: TCertificatesItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Certificates := Items[ARow];
  if not Assigned(Certificates.PRecord) then
  begin
    New(Certificates.PRecord);
    Certificates.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCertificatesItem.TPropertyIndex(ACol) of
      Certificates_CERT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Certificates_SLOT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      Certificates_VALID_FROM_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      Certificates_VALID_TO_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      Certificates_SlotNom: isOld :=  Certificates.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      Certificates_Pin: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
    if Certificates.PRecord.setProp = [] then
    begin
      Dispose(Certificates.PRecord);
      Certificates.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
  case TCertificatesItem.TPropertyIndex(ACol) of
    Certificates_CERT_ID: Certificates.PRecord.CERT_ID := AValue;
    Certificates_SLOT_ID: Certificates.PRecord.SLOT_ID := AValue;
    Certificates_VALID_FROM_DATE: Certificates.PRecord.VALID_FROM_DATE := StrToDate(AValue);
    Certificates_VALID_TO_DATE: Certificates.PRecord.VALID_TO_DATE := StrToDate(AValue);
    Certificates_SlotNom: Certificates.PRecord.SlotNom := StrToInt(AValue);
    Certificates_Pin: Certificates.PRecord.Pin := AValue;
  end;
end;

procedure TCertificatesColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Certificates: TCertificatesItem;
begin
  if Count = 0 then Exit;

  Certificates := Items[ARow];
  if not Assigned(Certificates.PRecord) then
  begin
    New(Certificates.PRecord);
    Certificates.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCertificatesItem.TPropertyIndex(ACol) of
      Certificates_CERT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      Certificates_SLOT_ID: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      Certificates_VALID_FROM_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
      Certificates_VALID_TO_DATE: isOld :=  Certificates.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
      Certificates_SlotNom: isOld :=  Certificates.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      Certificates_Pin: isOld :=  Certificates.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
    if Certificates.PRecord.setProp = [] then
    begin
      Dispose(Certificates.PRecord);
      Certificates.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Certificates.PRecord.setProp, TCertificatesItem.TPropertyIndex(ACol));
  case TCertificatesItem.TPropertyIndex(ACol) of
    Certificates_CERT_ID: Certificates.PRecord.CERT_ID := AFieldText;
    Certificates_SLOT_ID: Certificates.PRecord.SLOT_ID := AFieldText;
    Certificates_VALID_FROM_DATE: Certificates.PRecord.VALID_FROM_DATE := StrToDate(AFieldText);
    Certificates_VALID_TO_DATE: Certificates.PRecord.VALID_TO_DATE := StrToDate(AFieldText);
    Certificates_SlotNom: Certificates.PRecord.SlotNom := StrToInt(AFieldText);
    Certificates_Pin: Certificates.PRecord.Pin := AFieldText;
  end;
end;

procedure TCertificatesColl.SetItem(Index: Integer; const Value: TCertificatesItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TCertificatesColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCertificatesSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCertificatesItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Certificates_CERT_ID:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCertificatesSearch.Add(self.Items[i]);
  end;
end;
      Certificates_SLOT_ID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCertificatesSearch.Add(self.Items[i]);
        end;
      end;

    end;
  end;
end;

procedure TCertificatesColl.ShowGrid(Grid: TTeeGrid);
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

procedure TCertificatesColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCertificatesItem>);
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

procedure TCertificatesColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCertificatesSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCertificatesSearch.Count]);

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

procedure TCertificatesColl.SortByIndexAnsiString;
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

procedure TCertificatesColl.SortByIndexInt;
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

procedure TCertificatesColl.SortByIndexWord;
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

procedure TCertificatesColl.SortByIndexValue(propIndex: TCertificatesItem.TPropertyIndex);
begin
  case propIndex of
    Certificates_CERT_ID: SortByIndexAnsiString;
      Certificates_SLOT_ID: SortByIndexAnsiString;
  end;
end;

end.