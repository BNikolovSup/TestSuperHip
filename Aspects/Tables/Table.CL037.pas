unit Table.CL037;

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


TCL037Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL037_Key
, CL037_Description
, CL037_DescriptionEn
, CL037_target_disease
, CL037_permit_owner
, CL037_permit_number
, CL037_days_to_next_dose
, CL037_inn
, CL037_atc
, CL037_vaccine_group
, CL037_days_to_next_dose_booster
, CL037_mh_code
, CL037_number_of_doses
, CL037_vaccine_code_lot_number
, CL037_cert_text
, CL037_medicament
, CL037_permit_owner_id
, CL037_dose_quantity
, CL037_days_to_next_dose_booster_special
, CL037_dose_quantity_in_pack
, CL037_nhif_vaccine_code
, CL037_doses_in_pack
);
	  
      TSetProp = set of TPropertyIndex;
      PRecCL037 = ^TRecCL037;
      TRecCL037 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        target_disease: AnsiString;
        permit_owner: AnsiString;
        permit_number: AnsiString;
        days_to_next_dose: AnsiString;
        inn: AnsiString;
        atc: AnsiString;
        vaccine_group: AnsiString;
        days_to_next_dose_booster: AnsiString;
        mh_code: AnsiString;
        number_of_doses: AnsiString;
        vaccine_code_lot_number: AnsiString;
        cert_text: AnsiString;
        medicament: AnsiString;
        permit_owner_id: AnsiString;
        dose_quantity: AnsiString;
        days_to_next_dose_booster_special: AnsiString;
        dose_quantity_in_pack: AnsiString;
        nhif_vaccine_code: AnsiString;
        doses_in_pack: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL037;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL037;
    procedure UpdateCL037;
    procedure SaveCL037(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TCL037Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL037Item;
    procedure SetItem(Index: Integer; const Value: TCL037Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL037Item;
	ListForFDB: TList<TCL037Item>;
    ListCL037Search: TList<TCL037Item>;
	PRecordSearch: ^TCL037Item.TRecCL037;
    ArrPropSearch: TArray<TCL037Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL037Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL037Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL037: TCL037Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL037: TCL037Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL037Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL037Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL037Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL037Item.TPropertyIndex);
    property Items[Index: Integer]: TCL037Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);

  end;

implementation

{ TCL037Item }

constructor TCL037Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL037Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL037Item.InsertCL037;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL037;
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
            CL037_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL037_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL037_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL037_target_disease: SaveData(PRecord.target_disease, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner: SaveData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL037_permit_number: SaveData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose: SaveData(PRecord.days_to_next_dose, PropPosition, metaPosition, dataPosition);
            CL037_inn: SaveData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL037_atc: SaveData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_group: SaveData(PRecord.vaccine_group, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster: SaveData(PRecord.days_to_next_dose_booster, PropPosition, metaPosition, dataPosition);
            CL037_mh_code: SaveData(PRecord.mh_code, PropPosition, metaPosition, dataPosition);
            CL037_number_of_doses: SaveData(PRecord.number_of_doses, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_code_lot_number: SaveData(PRecord.vaccine_code_lot_number, PropPosition, metaPosition, dataPosition);
            CL037_cert_text: SaveData(PRecord.cert_text, PropPosition, metaPosition, dataPosition);
            CL037_medicament: SaveData(PRecord.medicament, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner_id: SaveData(PRecord.permit_owner_id, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity: SaveData(PRecord.dose_quantity, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster_special: SaveData(PRecord.days_to_next_dose_booster_special, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity_in_pack: SaveData(PRecord.dose_quantity_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_nhif_vaccine_code: SaveData(PRecord.nhif_vaccine_code, PropPosition, metaPosition, dataPosition);
            CL037_doses_in_pack: SaveData(PRecord.doses_in_pack, PropPosition, metaPosition, dataPosition);
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

function  TCL037Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL037Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL037Item;
begin
  Result := True;
  for i := 0 to Length(TCL037Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL037Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL037Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL037_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL037_Key), cot);
            CL037_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL037_Description), cot);
            CL037_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL037_DescriptionEn), cot);
            CL037_target_disease: Result := IsFinded(ATempItem.PRecord.target_disease, buf, FPosDataADB, word(CL037_target_disease), cot);
            CL037_permit_owner: Result := IsFinded(ATempItem.PRecord.permit_owner, buf, FPosDataADB, word(CL037_permit_owner), cot);
            CL037_permit_number: Result := IsFinded(ATempItem.PRecord.permit_number, buf, FPosDataADB, word(CL037_permit_number), cot);
            CL037_days_to_next_dose: Result := IsFinded(ATempItem.PRecord.days_to_next_dose, buf, FPosDataADB, word(CL037_days_to_next_dose), cot);
            CL037_inn: Result := IsFinded(ATempItem.PRecord.inn, buf, FPosDataADB, word(CL037_inn), cot);
            CL037_atc: Result := IsFinded(ATempItem.PRecord.atc, buf, FPosDataADB, word(CL037_atc), cot);
            CL037_vaccine_group: Result := IsFinded(ATempItem.PRecord.vaccine_group, buf, FPosDataADB, word(CL037_vaccine_group), cot);
            CL037_days_to_next_dose_booster: Result := IsFinded(ATempItem.PRecord.days_to_next_dose_booster, buf, FPosDataADB, word(CL037_days_to_next_dose_booster), cot);
            CL037_mh_code: Result := IsFinded(ATempItem.PRecord.mh_code, buf, FPosDataADB, word(CL037_mh_code), cot);
            CL037_number_of_doses: Result := IsFinded(ATempItem.PRecord.number_of_doses, buf, FPosDataADB, word(CL037_number_of_doses), cot);
            CL037_vaccine_code_lot_number: Result := IsFinded(ATempItem.PRecord.vaccine_code_lot_number, buf, FPosDataADB, word(CL037_vaccine_code_lot_number), cot);
            CL037_cert_text: Result := IsFinded(ATempItem.PRecord.cert_text, buf, FPosDataADB, word(CL037_cert_text), cot);
            CL037_medicament: Result := IsFinded(ATempItem.PRecord.medicament, buf, FPosDataADB, word(CL037_medicament), cot);
            CL037_permit_owner_id: Result := IsFinded(ATempItem.PRecord.permit_owner_id, buf, FPosDataADB, word(CL037_permit_owner_id), cot);
            CL037_dose_quantity: Result := IsFinded(ATempItem.PRecord.dose_quantity, buf, FPosDataADB, word(CL037_dose_quantity), cot);
            CL037_days_to_next_dose_booster_special: Result := IsFinded(ATempItem.PRecord.days_to_next_dose_booster_special, buf, FPosDataADB, word(CL037_days_to_next_dose_booster_special), cot);
            CL037_dose_quantity_in_pack: Result := IsFinded(ATempItem.PRecord.dose_quantity_in_pack, buf, FPosDataADB, word(CL037_dose_quantity_in_pack), cot);
            CL037_nhif_vaccine_code: Result := IsFinded(ATempItem.PRecord.nhif_vaccine_code, buf, FPosDataADB, word(CL037_nhif_vaccine_code), cot);
            CL037_doses_in_pack: Result := IsFinded(ATempItem.PRecord.doses_in_pack, buf, FPosDataADB, word(CL037_doses_in_pack), cot);
      end;
    end;
  end;
end;

procedure TCL037Item.SaveCL037(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL037;
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
            CL037_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL037_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL037_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL037_target_disease: SaveData(PRecord.target_disease, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner: SaveData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL037_permit_number: SaveData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose: SaveData(PRecord.days_to_next_dose, PropPosition, metaPosition, dataPosition);
            CL037_inn: SaveData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL037_atc: SaveData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_group: SaveData(PRecord.vaccine_group, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster: SaveData(PRecord.days_to_next_dose_booster, PropPosition, metaPosition, dataPosition);
            CL037_mh_code: SaveData(PRecord.mh_code, PropPosition, metaPosition, dataPosition);
            CL037_number_of_doses: SaveData(PRecord.number_of_doses, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_code_lot_number: SaveData(PRecord.vaccine_code_lot_number, PropPosition, metaPosition, dataPosition);
            CL037_cert_text: SaveData(PRecord.cert_text, PropPosition, metaPosition, dataPosition);
            CL037_medicament: SaveData(PRecord.medicament, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner_id: SaveData(PRecord.permit_owner_id, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity: SaveData(PRecord.dose_quantity, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster_special: SaveData(PRecord.days_to_next_dose_booster_special, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity_in_pack: SaveData(PRecord.dose_quantity_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_nhif_vaccine_code: SaveData(PRecord.nhif_vaccine_code, PropPosition, metaPosition, dataPosition);
            CL037_doses_in_pack: SaveData(PRecord.doses_in_pack, PropPosition, metaPosition, dataPosition);
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

procedure TCL037Item.UpdateCL037;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL037;
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
            CL037_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL037_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL037_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL037_target_disease: UpdateData(PRecord.target_disease, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner: UpdateData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL037_permit_number: UpdateData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose: UpdateData(PRecord.days_to_next_dose, PropPosition, metaPosition, dataPosition);
            CL037_inn: UpdateData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL037_atc: UpdateData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_group: UpdateData(PRecord.vaccine_group, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster: UpdateData(PRecord.days_to_next_dose_booster, PropPosition, metaPosition, dataPosition);
            CL037_mh_code: UpdateData(PRecord.mh_code, PropPosition, metaPosition, dataPosition);
            CL037_number_of_doses: UpdateData(PRecord.number_of_doses, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_code_lot_number: UpdateData(PRecord.vaccine_code_lot_number, PropPosition, metaPosition, dataPosition);
            CL037_cert_text: UpdateData(PRecord.cert_text, PropPosition, metaPosition, dataPosition);
            CL037_medicament: UpdateData(PRecord.medicament, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner_id: UpdateData(PRecord.permit_owner_id, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity: UpdateData(PRecord.dose_quantity, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster_special: UpdateData(PRecord.days_to_next_dose_booster_special, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity_in_pack: UpdateData(PRecord.dose_quantity_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_nhif_vaccine_code: UpdateData(PRecord.nhif_vaccine_code, PropPosition, metaPosition, dataPosition);
            CL037_doses_in_pack: UpdateData(PRecord.doses_in_pack, PropPosition, metaPosition, dataPosition);
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

{ TCL037Coll }

function TCL037Coll.AddItem(ver: word): TCL037Item;
begin
  Result := TCL037Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL037Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL037Item;
begin
  ItemForSearch := TCL037Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL037Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL037Item.Create(nil);
  ListCL037Search := TList<TCL037Item>.Create;
  ListForFDB := TList<TCL037Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL037Coll.destroy;
begin
  FreeAndNil(ListCL037Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL037Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL037Item.TPropertyIndex(propIndex) of
    CL037_Key: Result := 'Key';
    CL037_Description: Result := 'Description';
    CL037_DescriptionEn: Result := 'DescriptionEn';
    CL037_target_disease: Result := 'target_disease';
    CL037_permit_owner: Result := 'permit_owner';
    CL037_permit_number: Result := 'permit_number';
    CL037_days_to_next_dose: Result := 'days_to_next_dose';
    CL037_inn: Result := 'inn';
    CL037_atc: Result := 'atc';
    CL037_vaccine_group: Result := 'vaccine_group';
    CL037_days_to_next_dose_booster: Result := 'days_to_next_dose_booster';
    CL037_mh_code: Result := 'mh_code';
    CL037_number_of_doses: Result := 'number_of_doses';
    CL037_vaccine_code_lot_number: Result := 'vaccine_code_lot_number';
    CL037_cert_text: Result := 'cert_text';
    CL037_medicament: Result := 'medicament';
    CL037_permit_owner_id: Result := 'permit_owner_id';
    CL037_dose_quantity: Result := 'dose_quantity';
    CL037_days_to_next_dose_booster_special: Result := 'days_to_next_dose_booster_special';
    CL037_dose_quantity_in_pack: Result := 'dose_quantity_in_pack';
    CL037_nhif_vaccine_code: Result := 'nhif_vaccine_code';
    CL037_doses_in_pack: Result := 'doses_in_pack';
  end;
end;

procedure TCL037Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  self.IndexValue(TCL037Item.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TCL037Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 22;
end;

procedure TCL037Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL037: TCL037Item;
  ACol: Integer;
  prop: TCL037Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL037 := Items[ARow];
  prop := TCL037Item.TPropertyIndex(ACol);
  if Assigned(CL037.PRecord) and (prop in CL037.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL037, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL037, AValue);
  end;
end;

procedure TCL037Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL037Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TCL037Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL037Coll.GetCellFromRecord(propIndex: word; CL037: TCL037Item; var AValue: String);
var
  str: string;
begin
  case TCL037Item.TPropertyIndex(propIndex) of
    CL037_Key: str := (CL037.PRecord.Key);
    CL037_Description: str := (CL037.PRecord.Description);
    CL037_DescriptionEn: str := (CL037.PRecord.DescriptionEn);
    CL037_target_disease: str := (CL037.PRecord.target_disease);
    CL037_permit_owner: str := (CL037.PRecord.permit_owner);
    CL037_permit_number: str := (CL037.PRecord.permit_number);
    CL037_days_to_next_dose: str := (CL037.PRecord.days_to_next_dose);
    CL037_inn: str := (CL037.PRecord.inn);
    CL037_atc: str := (CL037.PRecord.atc);
    CL037_vaccine_group: str := (CL037.PRecord.vaccine_group);
    CL037_days_to_next_dose_booster: str := (CL037.PRecord.days_to_next_dose_booster);
    CL037_mh_code: str := (CL037.PRecord.mh_code);
    CL037_number_of_doses: str := (CL037.PRecord.number_of_doses);
    CL037_vaccine_code_lot_number: str := (CL037.PRecord.vaccine_code_lot_number);
    CL037_cert_text: str := (CL037.PRecord.cert_text);
    CL037_medicament: str := (CL037.PRecord.medicament);
    CL037_permit_owner_id: str := (CL037.PRecord.permit_owner_id);
    CL037_dose_quantity: str := (CL037.PRecord.dose_quantity);
    CL037_days_to_next_dose_booster_special: str := (CL037.PRecord.days_to_next_dose_booster_special);
    CL037_dose_quantity_in_pack: str := (CL037.PRecord.dose_quantity_in_pack);
    CL037_nhif_vaccine_code: str := (CL037.PRecord.nhif_vaccine_code);
    CL037_doses_in_pack: str := (CL037.PRecord.doses_in_pack);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL037Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL037Item;
  ACol: Integer;
  prop: TCL037Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL037Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL037Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL037Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL037Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL037Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL037: TCL037Item;
  ACol: Integer;
  prop: TCL037Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL037 := ListCL037Search[ARow];
  prop := TCL037Item.TPropertyIndex(ACol);
  if Assigned(CL037.PRecord) and (prop in CL037.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL037, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL037, AValue);
  end;
end;

procedure TCL037Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL037: TCL037Item;
  prop: TCL037Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL037 := Items[ARow];
  prop := TCL037Item.TPropertyIndex(ACol);
  if Assigned(CL037.PRecord) and (prop in CL037.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL037, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL037, AFieldText);
  end;
end;

procedure TCL037Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL037: TCL037Item; var AValue: String);
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
  case TCL037Item.TPropertyIndex(propIndex) of
    CL037_Key: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_Description: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_DescriptionEn: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_target_disease: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_permit_owner: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_permit_number: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_days_to_next_dose: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_inn: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_atc: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_vaccine_group: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_days_to_next_dose_booster: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_mh_code: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_number_of_doses: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_vaccine_code_lot_number: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_cert_text: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_medicament: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_permit_owner_id: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_dose_quantity: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_days_to_next_dose_booster_special: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_dose_quantity_in_pack: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_nhif_vaccine_code: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_doses_in_pack: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL037Coll.GetItem(Index: Integer): TCL037Item;
begin
  Result := TCL037Item(inherited GetItem(Index));
end;


procedure TCL037Coll.IndexValue(propIndex: TCL037Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL037Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL037_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL037_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_target_disease:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_permit_owner:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_permit_number:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_days_to_next_dose:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_inn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_atc:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_vaccine_group:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_days_to_next_dose_booster:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_mh_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_number_of_doses:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_vaccine_code_lot_number:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_cert_text:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_medicament:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_permit_owner_id:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_dose_quantity:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_days_to_next_dose_booster_special:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_dose_quantity_in_pack:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_nhif_vaccine_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL037_doses_in_pack:
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

procedure TCL037Coll.IndexValueListNodes(propIndex: TCL037Item.TPropertyIndex);
begin

end;

procedure TCL037Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL037Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL037Item.Create(nil);
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



function TCL037Coll.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TCL037Item.TPropertyIndex(propIndex) of
    CL037_Key: Result := actAnsiString;
    CL037_Description: Result := actAnsiString;
    CL037_DescriptionEn: Result := actAnsiString;
    CL037_target_disease: Result := actAnsiString;
    CL037_permit_owner: Result := actAnsiString;
    CL037_permit_number: Result := actAnsiString;
    CL037_days_to_next_dose: Result := actAnsiString;
    CL037_inn: Result := actAnsiString;
    CL037_atc: Result := actAnsiString;
    CL037_vaccine_group: Result := actAnsiString;
    CL037_days_to_next_dose_booster: Result := actAnsiString;
    CL037_mh_code: Result := actAnsiString;
    CL037_number_of_doses: Result := actAnsiString;
    CL037_vaccine_code_lot_number: Result := actAnsiString;
    CL037_cert_text: Result := actAnsiString;
    CL037_medicament: Result := actAnsiString;
    CL037_permit_owner_id: Result := actAnsiString;
    CL037_dose_quantity: Result := actAnsiString;
    CL037_days_to_next_dose_booster_special: Result := actAnsiString;
    CL037_dose_quantity_in_pack: Result := actAnsiString;
    CL037_nhif_vaccine_code: Result := actAnsiString;
    CL037_doses_in_pack: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL037Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL037: TCL037Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL037 := Items[ARow];
  if not Assigned(CL037.PRecord) then
  begin
    New(CL037.PRecord);
    CL037.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL037Item.TPropertyIndex(ACol) of
      CL037_Key: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_Description: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_DescriptionEn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_target_disease: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_permit_owner: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_permit_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_days_to_next_dose: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_inn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_atc: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_vaccine_group: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_days_to_next_dose_booster: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_mh_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_number_of_doses: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_vaccine_code_lot_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_cert_text: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_medicament: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_permit_owner_id: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_dose_quantity: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_days_to_next_dose_booster_special: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_dose_quantity_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_nhif_vaccine_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_doses_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL037.PRecord.setProp, TCL037Item.TPropertyIndex(ACol));
    if CL037.PRecord.setProp = [] then
    begin
      Dispose(CL037.PRecord);
      CL037.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL037.PRecord.setProp, TCL037Item.TPropertyIndex(ACol));
  case TCL037Item.TPropertyIndex(ACol) of
    CL037_Key: CL037.PRecord.Key := AValue;
    CL037_Description: CL037.PRecord.Description := AValue;
    CL037_DescriptionEn: CL037.PRecord.DescriptionEn := AValue;
    CL037_target_disease: CL037.PRecord.target_disease := AValue;
    CL037_permit_owner: CL037.PRecord.permit_owner := AValue;
    CL037_permit_number: CL037.PRecord.permit_number := AValue;
    CL037_days_to_next_dose: CL037.PRecord.days_to_next_dose := AValue;
    CL037_inn: CL037.PRecord.inn := AValue;
    CL037_atc: CL037.PRecord.atc := AValue;
    CL037_vaccine_group: CL037.PRecord.vaccine_group := AValue;
    CL037_days_to_next_dose_booster: CL037.PRecord.days_to_next_dose_booster := AValue;
    CL037_mh_code: CL037.PRecord.mh_code := AValue;
    CL037_number_of_doses: CL037.PRecord.number_of_doses := AValue;
    CL037_vaccine_code_lot_number: CL037.PRecord.vaccine_code_lot_number := AValue;
    CL037_cert_text: CL037.PRecord.cert_text := AValue;
    CL037_medicament: CL037.PRecord.medicament := AValue;
    CL037_permit_owner_id: CL037.PRecord.permit_owner_id := AValue;
    CL037_dose_quantity: CL037.PRecord.dose_quantity := AValue;
    CL037_days_to_next_dose_booster_special: CL037.PRecord.days_to_next_dose_booster_special := AValue;
    CL037_dose_quantity_in_pack: CL037.PRecord.dose_quantity_in_pack := AValue;
    CL037_nhif_vaccine_code: CL037.PRecord.nhif_vaccine_code := AValue;
    CL037_doses_in_pack: CL037.PRecord.doses_in_pack := AValue;
  end;
end;

procedure TCL037Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL037: TCL037Item;
begin
  if Count = 0 then Exit;

  CL037 := Items[ARow];
  if not Assigned(CL037.PRecord) then
  begin
    New(CL037.PRecord);
    CL037.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL037Item.TPropertyIndex(ACol) of
      CL037_Key: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_Description: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_DescriptionEn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_target_disease: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_permit_owner: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_permit_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_days_to_next_dose: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_inn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_atc: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_vaccine_group: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_days_to_next_dose_booster: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_mh_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_number_of_doses: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_vaccine_code_lot_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_cert_text: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_medicament: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_permit_owner_id: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_dose_quantity: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_days_to_next_dose_booster_special: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_dose_quantity_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_nhif_vaccine_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_doses_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL037.PRecord.setProp, TCL037Item.TPropertyIndex(ACol));
    if CL037.PRecord.setProp = [] then
    begin
      Dispose(CL037.PRecord);
      CL037.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL037.PRecord.setProp, TCL037Item.TPropertyIndex(ACol));
  case TCL037Item.TPropertyIndex(ACol) of
    CL037_Key: CL037.PRecord.Key := AFieldText;
    CL037_Description: CL037.PRecord.Description := AFieldText;
    CL037_DescriptionEn: CL037.PRecord.DescriptionEn := AFieldText;
    CL037_target_disease: CL037.PRecord.target_disease := AFieldText;
    CL037_permit_owner: CL037.PRecord.permit_owner := AFieldText;
    CL037_permit_number: CL037.PRecord.permit_number := AFieldText;
    CL037_days_to_next_dose: CL037.PRecord.days_to_next_dose := AFieldText;
    CL037_inn: CL037.PRecord.inn := AFieldText;
    CL037_atc: CL037.PRecord.atc := AFieldText;
    CL037_vaccine_group: CL037.PRecord.vaccine_group := AFieldText;
    CL037_days_to_next_dose_booster: CL037.PRecord.days_to_next_dose_booster := AFieldText;
    CL037_mh_code: CL037.PRecord.mh_code := AFieldText;
    CL037_number_of_doses: CL037.PRecord.number_of_doses := AFieldText;
    CL037_vaccine_code_lot_number: CL037.PRecord.vaccine_code_lot_number := AFieldText;
    CL037_cert_text: CL037.PRecord.cert_text := AFieldText;
    CL037_medicament: CL037.PRecord.medicament := AFieldText;
    CL037_permit_owner_id: CL037.PRecord.permit_owner_id := AFieldText;
    CL037_dose_quantity: CL037.PRecord.dose_quantity := AFieldText;
    CL037_days_to_next_dose_booster_special: CL037.PRecord.days_to_next_dose_booster_special := AFieldText;
    CL037_dose_quantity_in_pack: CL037.PRecord.dose_quantity_in_pack := AFieldText;
    CL037_nhif_vaccine_code: CL037.PRecord.nhif_vaccine_code := AFieldText;
    CL037_doses_in_pack: CL037.PRecord.doses_in_pack := AFieldText;
  end;
end;

procedure TCL037Coll.SetItem(Index: Integer; const Value: TCL037Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL037Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL037Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL037Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL037_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL037Search.Add(self.Items[i]);
  end;
end;
      CL037_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_target_disease:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_permit_owner:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_permit_number:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_days_to_next_dose:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_inn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_atc:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_vaccine_group:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_days_to_next_dose_booster:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_mh_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_number_of_doses:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_vaccine_code_lot_number:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_cert_text:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_medicament:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_permit_owner_id:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_dose_quantity:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_days_to_next_dose_booster_special:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_dose_quantity_in_pack:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_nhif_vaccine_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
      CL037_doses_in_pack:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL037Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL037Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL037Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL037Item>);
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

procedure TCL037Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL037Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL037Search.Count]);

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

procedure TCL037Coll.SortByIndexAnsiString;
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

procedure TCL037Coll.SortByIndexInt;
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

procedure TCL037Coll.SortByIndexWord;
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

procedure TCL037Coll.SortByIndexValue(propIndex: TCL037Item.TPropertyIndex);
begin
  case propIndex of
    CL037_Key: SortByIndexAnsiString;
      CL037_Description: SortByIndexAnsiString;
      CL037_DescriptionEn: SortByIndexAnsiString;
      CL037_target_disease: SortByIndexAnsiString;
      CL037_permit_owner: SortByIndexAnsiString;
      CL037_permit_number: SortByIndexAnsiString;
      CL037_days_to_next_dose: SortByIndexAnsiString;
      CL037_inn: SortByIndexAnsiString;
      CL037_atc: SortByIndexAnsiString;
      CL037_vaccine_group: SortByIndexAnsiString;
      CL037_days_to_next_dose_booster: SortByIndexAnsiString;
      CL037_mh_code: SortByIndexAnsiString;
      CL037_number_of_doses: SortByIndexAnsiString;
      CL037_vaccine_code_lot_number: SortByIndexAnsiString;
      CL037_cert_text: SortByIndexAnsiString;
      CL037_medicament: SortByIndexAnsiString;
      CL037_permit_owner_id: SortByIndexAnsiString;
      CL037_dose_quantity: SortByIndexAnsiString;
      CL037_days_to_next_dose_booster_special: SortByIndexAnsiString;
      CL037_dose_quantity_in_pack: SortByIndexAnsiString;
      CL037_nhif_vaccine_code: SortByIndexAnsiString;
      CL037_doses_in_pack: SortByIndexAnsiString;
  end;
end;

end.