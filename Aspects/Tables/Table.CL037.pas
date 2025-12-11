unit Table.CL037;

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

TLogicalCL037 = (
    Is_);
TlogicalCL037Set = set of TLogicalCL037;


TCL037Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL037_Key
       , CL037_Description
       , CL037_DescriptionEn
       , CL037_number_of_doses
       , CL037_mh_code
       , CL037_inn
       , CL037_days_to_next_dose
       , CL037_permit_number
       , CL037_permit_owner
       , CL037_target_disease
       , CL037_doses_in_pack
       , CL037_dose_quantity
       , CL037_nhif_vaccine_code
       , CL037_cert_text
       , CL037_permit_owner_id
       , CL037_dose_quantity_in_pack
       , CL037_days_to_next_dose_booster_special
       , CL037_atc
       , CL037_days_to_next_dose_booster
       , CL037_vaccine_group
       , CL037_medicament
       , CL037_vaccine_code_lot_number
       , CL037_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL037 = ^TRecCL037;
      TRecCL037 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        number_of_doses: AnsiString;
        mh_code: AnsiString;
        inn: AnsiString;
        days_to_next_dose: AnsiString;
        permit_number: AnsiString;
        permit_owner: AnsiString;
        target_disease: AnsiString;
        doses_in_pack: AnsiString;
        dose_quantity: AnsiString;
        nhif_vaccine_code: AnsiString;
        cert_text: AnsiString;
        permit_owner_id: AnsiString;
        dose_quantity_in_pack: AnsiString;
        days_to_next_dose_booster_special: AnsiString;
        atc: AnsiString;
        days_to_next_dose_booster: AnsiString;
        vaccine_group: AnsiString;
        medicament: AnsiString;
        vaccine_code_lot_number: AnsiString;
        Logical: TlogicalCL037Set;
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
    procedure SaveCL037(var dataPosition: Cardinal)overload;
	procedure SaveCL037(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL037(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL037Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL037Item;
    function GetItem(Index: Integer): TCL037Item;
    procedure SetItem(Index: Integer; const Value: TCL037Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL037Item>;
    ListCL037Search: TList<TCL037Item>;
	PRecordSearch: ^TCL037Item.TRecCL037;
    ArrPropSearch: TArray<TCL037Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL037Item.TPropertyIndex>;
	VisibleColl: TCL037Item.TSetProp;
	ArrayPropOrder: TArray<TCL037Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL037Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL037: TCL037Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL037: TCL037Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL037Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL037Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL037Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL037Item.TPropertyIndex);
    property Items[Index: Integer]: TCL037Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL037Set);
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

procedure TCL037Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCL037Item.GetCollType: TCollectionsType;
begin
  Result := ctCL037;
end;

function TCL037Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
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
            CL037_number_of_doses: SaveData(PRecord.number_of_doses, PropPosition, metaPosition, dataPosition);
            CL037_mh_code: SaveData(PRecord.mh_code, PropPosition, metaPosition, dataPosition);
            CL037_inn: SaveData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose: SaveData(PRecord.days_to_next_dose, PropPosition, metaPosition, dataPosition);
            CL037_permit_number: SaveData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner: SaveData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL037_target_disease: SaveData(PRecord.target_disease, PropPosition, metaPosition, dataPosition);
            CL037_doses_in_pack: SaveData(PRecord.doses_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity: SaveData(PRecord.dose_quantity, PropPosition, metaPosition, dataPosition);
            CL037_nhif_vaccine_code: SaveData(PRecord.nhif_vaccine_code, PropPosition, metaPosition, dataPosition);
            CL037_cert_text: SaveData(PRecord.cert_text, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner_id: SaveData(PRecord.permit_owner_id, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity_in_pack: SaveData(PRecord.dose_quantity_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster_special: SaveData(PRecord.days_to_next_dose_booster_special, PropPosition, metaPosition, dataPosition);
            CL037_atc: SaveData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster: SaveData(PRecord.days_to_next_dose_booster, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_group: SaveData(PRecord.vaccine_group, PropPosition, metaPosition, dataPosition);
            CL037_medicament: SaveData(PRecord.medicament, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_code_lot_number: SaveData(PRecord.vaccine_code_lot_number, PropPosition, metaPosition, dataPosition);
            CL037_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
	ATempItem := TCL037Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL037_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL037_Key), cot);
            CL037_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL037_Description), cot);
            CL037_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL037_DescriptionEn), cot);
            CL037_number_of_doses: Result := IsFinded(ATempItem.PRecord.number_of_doses, buf, FPosDataADB, word(CL037_number_of_doses), cot);
            CL037_mh_code: Result := IsFinded(ATempItem.PRecord.mh_code, buf, FPosDataADB, word(CL037_mh_code), cot);
            CL037_inn: Result := IsFinded(ATempItem.PRecord.inn, buf, FPosDataADB, word(CL037_inn), cot);
            CL037_days_to_next_dose: Result := IsFinded(ATempItem.PRecord.days_to_next_dose, buf, FPosDataADB, word(CL037_days_to_next_dose), cot);
            CL037_permit_number: Result := IsFinded(ATempItem.PRecord.permit_number, buf, FPosDataADB, word(CL037_permit_number), cot);
            CL037_permit_owner: Result := IsFinded(ATempItem.PRecord.permit_owner, buf, FPosDataADB, word(CL037_permit_owner), cot);
            CL037_target_disease: Result := IsFinded(ATempItem.PRecord.target_disease, buf, FPosDataADB, word(CL037_target_disease), cot);
            CL037_doses_in_pack: Result := IsFinded(ATempItem.PRecord.doses_in_pack, buf, FPosDataADB, word(CL037_doses_in_pack), cot);
            CL037_dose_quantity: Result := IsFinded(ATempItem.PRecord.dose_quantity, buf, FPosDataADB, word(CL037_dose_quantity), cot);
            CL037_nhif_vaccine_code: Result := IsFinded(ATempItem.PRecord.nhif_vaccine_code, buf, FPosDataADB, word(CL037_nhif_vaccine_code), cot);
            CL037_cert_text: Result := IsFinded(ATempItem.PRecord.cert_text, buf, FPosDataADB, word(CL037_cert_text), cot);
            CL037_permit_owner_id: Result := IsFinded(ATempItem.PRecord.permit_owner_id, buf, FPosDataADB, word(CL037_permit_owner_id), cot);
            CL037_dose_quantity_in_pack: Result := IsFinded(ATempItem.PRecord.dose_quantity_in_pack, buf, FPosDataADB, word(CL037_dose_quantity_in_pack), cot);
            CL037_days_to_next_dose_booster_special: Result := IsFinded(ATempItem.PRecord.days_to_next_dose_booster_special, buf, FPosDataADB, word(CL037_days_to_next_dose_booster_special), cot);
            CL037_atc: Result := IsFinded(ATempItem.PRecord.atc, buf, FPosDataADB, word(CL037_atc), cot);
            CL037_days_to_next_dose_booster: Result := IsFinded(ATempItem.PRecord.days_to_next_dose_booster, buf, FPosDataADB, word(CL037_days_to_next_dose_booster), cot);
            CL037_vaccine_group: Result := IsFinded(ATempItem.PRecord.vaccine_group, buf, FPosDataADB, word(CL037_vaccine_group), cot);
            CL037_medicament: Result := IsFinded(ATempItem.PRecord.medicament, buf, FPosDataADB, word(CL037_medicament), cot);
            CL037_vaccine_code_lot_number: Result := IsFinded(ATempItem.PRecord.vaccine_code_lot_number, buf, FPosDataADB, word(CL037_vaccine_code_lot_number), cot);
            CL037_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL037_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL037Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds24: TLogicalData24;
  propindexCL037: TCL037Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData24);
  stream.Read(flds24, sizeof(TLogicalData24));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL037Item.TSetProp(flds24);// тука се записва какво има като полета


  for propindexCL037 := Low(TCL037Item.TPropertyIndex) to High(TCL037Item.TPropertyIndex) do
  begin
    if not (propindexCL037 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL037);
      dataCmdProp.vid := vvCL037;
    end;
    self.FillPropCL037(propindexCL037, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL037Item.FillPropCL037(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL037_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL037_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL037_DescriptionEn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.DescriptionEn, lenStr);
              stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
            end;
            CL037_number_of_doses:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.number_of_doses, lenStr);
              stream.Read(Self.PRecord.number_of_doses[1], lenStr);
            end;
            CL037_mh_code:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.mh_code, lenStr);
              stream.Read(Self.PRecord.mh_code[1], lenStr);
            end;
            CL037_inn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.inn, lenStr);
              stream.Read(Self.PRecord.inn[1], lenStr);
            end;
            CL037_days_to_next_dose:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.days_to_next_dose, lenStr);
              stream.Read(Self.PRecord.days_to_next_dose[1], lenStr);
            end;
            CL037_permit_number:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.permit_number, lenStr);
              stream.Read(Self.PRecord.permit_number[1], lenStr);
            end;
            CL037_permit_owner:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.permit_owner, lenStr);
              stream.Read(Self.PRecord.permit_owner[1], lenStr);
            end;
            CL037_target_disease:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.target_disease, lenStr);
              stream.Read(Self.PRecord.target_disease[1], lenStr);
            end;
            CL037_doses_in_pack:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.doses_in_pack, lenStr);
              stream.Read(Self.PRecord.doses_in_pack[1], lenStr);
            end;
            CL037_dose_quantity:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.dose_quantity, lenStr);
              stream.Read(Self.PRecord.dose_quantity[1], lenStr);
            end;
            CL037_nhif_vaccine_code:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.nhif_vaccine_code, lenStr);
              stream.Read(Self.PRecord.nhif_vaccine_code[1], lenStr);
            end;
            CL037_cert_text:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cert_text, lenStr);
              stream.Read(Self.PRecord.cert_text[1], lenStr);
            end;
            CL037_permit_owner_id:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.permit_owner_id, lenStr);
              stream.Read(Self.PRecord.permit_owner_id[1], lenStr);
            end;
            CL037_dose_quantity_in_pack:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.dose_quantity_in_pack, lenStr);
              stream.Read(Self.PRecord.dose_quantity_in_pack[1], lenStr);
            end;
            CL037_days_to_next_dose_booster_special:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.days_to_next_dose_booster_special, lenStr);
              stream.Read(Self.PRecord.days_to_next_dose_booster_special[1], lenStr);
            end;
            CL037_atc:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.atc, lenStr);
              stream.Read(Self.PRecord.atc[1], lenStr);
            end;
            CL037_days_to_next_dose_booster:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.days_to_next_dose_booster, lenStr);
              stream.Read(Self.PRecord.days_to_next_dose_booster[1], lenStr);
            end;
            CL037_vaccine_group:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.vaccine_group, lenStr);
              stream.Read(Self.PRecord.vaccine_group[1], lenStr);
            end;
            CL037_medicament:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.medicament, lenStr);
              stream.Read(Self.PRecord.medicament[1], lenStr);
            end;
            CL037_vaccine_code_lot_number:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.vaccine_code_lot_number, lenStr);
              stream.Read(Self.PRecord.vaccine_code_lot_number[1], lenStr);
            end;
            CL037_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL037Item.SaveCL037(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL037(dataPosition);
end;

procedure TCL037Item.SaveCL037(var dataPosition: Cardinal);
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
            CL037_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL037_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL037_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL037_number_of_doses: SaveData(PRecord.number_of_doses, PropPosition, metaPosition, dataPosition);
            CL037_mh_code: SaveData(PRecord.mh_code, PropPosition, metaPosition, dataPosition);
            CL037_inn: SaveData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose: SaveData(PRecord.days_to_next_dose, PropPosition, metaPosition, dataPosition);
            CL037_permit_number: SaveData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner: SaveData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL037_target_disease: SaveData(PRecord.target_disease, PropPosition, metaPosition, dataPosition);
            CL037_doses_in_pack: SaveData(PRecord.doses_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity: SaveData(PRecord.dose_quantity, PropPosition, metaPosition, dataPosition);
            CL037_nhif_vaccine_code: SaveData(PRecord.nhif_vaccine_code, PropPosition, metaPosition, dataPosition);
            CL037_cert_text: SaveData(PRecord.cert_text, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner_id: SaveData(PRecord.permit_owner_id, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity_in_pack: SaveData(PRecord.dose_quantity_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster_special: SaveData(PRecord.days_to_next_dose_booster_special, PropPosition, metaPosition, dataPosition);
            CL037_atc: SaveData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster: SaveData(PRecord.days_to_next_dose_booster, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_group: SaveData(PRecord.vaccine_group, PropPosition, metaPosition, dataPosition);
            CL037_medicament: SaveData(PRecord.medicament, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_code_lot_number: SaveData(PRecord.vaccine_code_lot_number, PropPosition, metaPosition, dataPosition);
            CL037_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
            CL037_number_of_doses: UpdateData(PRecord.number_of_doses, PropPosition, metaPosition, dataPosition);
            CL037_mh_code: UpdateData(PRecord.mh_code, PropPosition, metaPosition, dataPosition);
            CL037_inn: UpdateData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose: UpdateData(PRecord.days_to_next_dose, PropPosition, metaPosition, dataPosition);
            CL037_permit_number: UpdateData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner: UpdateData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL037_target_disease: UpdateData(PRecord.target_disease, PropPosition, metaPosition, dataPosition);
            CL037_doses_in_pack: UpdateData(PRecord.doses_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity: UpdateData(PRecord.dose_quantity, PropPosition, metaPosition, dataPosition);
            CL037_nhif_vaccine_code: UpdateData(PRecord.nhif_vaccine_code, PropPosition, metaPosition, dataPosition);
            CL037_cert_text: UpdateData(PRecord.cert_text, PropPosition, metaPosition, dataPosition);
            CL037_permit_owner_id: UpdateData(PRecord.permit_owner_id, PropPosition, metaPosition, dataPosition);
            CL037_dose_quantity_in_pack: UpdateData(PRecord.dose_quantity_in_pack, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster_special: UpdateData(PRecord.days_to_next_dose_booster_special, PropPosition, metaPosition, dataPosition);
            CL037_atc: UpdateData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL037_days_to_next_dose_booster: UpdateData(PRecord.days_to_next_dose_booster, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_group: UpdateData(PRecord.vaccine_group, PropPosition, metaPosition, dataPosition);
            CL037_medicament: UpdateData(PRecord.medicament, PropPosition, metaPosition, dataPosition);
            CL037_vaccine_code_lot_number: UpdateData(PRecord.vaccine_code_lot_number, PropPosition, metaPosition, dataPosition);
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
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL037Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCL037Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL037Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL037Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCL037Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL037Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (CL037_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_Key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_DescriptionEn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_number_of_doses in tempItem.PRecord.setProp) and (tempItem.PRecord.number_of_doses <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_number_of_doses))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_mh_code in tempItem.PRecord.setProp) and (tempItem.PRecord.mh_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_mh_code))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_inn in tempItem.PRecord.setProp) and (tempItem.PRecord.inn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_inn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_days_to_next_dose in tempItem.PRecord.setProp) and (tempItem.PRecord.days_to_next_dose <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_days_to_next_dose))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_permit_number in tempItem.PRecord.setProp) and (tempItem.PRecord.permit_number <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_permit_number))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_permit_owner in tempItem.PRecord.setProp) and (tempItem.PRecord.permit_owner <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_permit_owner))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_target_disease in tempItem.PRecord.setProp) and (tempItem.PRecord.target_disease <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_target_disease))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_doses_in_pack in tempItem.PRecord.setProp) and (tempItem.PRecord.doses_in_pack <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_doses_in_pack))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_dose_quantity in tempItem.PRecord.setProp) and (tempItem.PRecord.dose_quantity <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_dose_quantity))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_nhif_vaccine_code in tempItem.PRecord.setProp) and (tempItem.PRecord.nhif_vaccine_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_nhif_vaccine_code))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_cert_text in tempItem.PRecord.setProp) and (tempItem.PRecord.cert_text <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_cert_text))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_permit_owner_id in tempItem.PRecord.setProp) and (tempItem.PRecord.permit_owner_id <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_permit_owner_id))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_dose_quantity_in_pack in tempItem.PRecord.setProp) and (tempItem.PRecord.dose_quantity_in_pack <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_dose_quantity_in_pack))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_days_to_next_dose_booster_special in tempItem.PRecord.setProp) and (tempItem.PRecord.days_to_next_dose_booster_special <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_days_to_next_dose_booster_special))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_atc in tempItem.PRecord.setProp) and (tempItem.PRecord.atc <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_atc))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_days_to_next_dose_booster in tempItem.PRecord.setProp) and (tempItem.PRecord.days_to_next_dose_booster <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_days_to_next_dose_booster))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_vaccine_group in tempItem.PRecord.setProp) and (tempItem.PRecord.vaccine_group <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_vaccine_group))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_medicament in tempItem.PRecord.setProp) and (tempItem.PRecord.medicament <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_medicament))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_vaccine_code_lot_number in tempItem.PRecord.setProp) and (tempItem.PRecord.vaccine_code_lot_number <> Self.getAnsiStringMap(tempItem.DataPos, word(CL037_vaccine_code_lot_number))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL037_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL037_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCL037Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL037Item.Create(nil);
  ListCL037Search := TList<TCL037Item>.Create;
  ListForFinder := TList<TCL037Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL037Coll.destroy;
begin
  FreeAndNil(ListCL037Search);
  FreeAndNil(ListForFinder);
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
    CL037_number_of_doses: Result := 'number_of_doses';
    CL037_mh_code: Result := 'mh_code';
    CL037_inn: Result := 'inn';
    CL037_days_to_next_dose: Result := 'days_to_next_dose';
    CL037_permit_number: Result := 'permit_number';
    CL037_permit_owner: Result := 'permit_owner';
    CL037_target_disease: Result := 'target_disease';
    CL037_doses_in_pack: Result := 'doses_in_pack';
    CL037_dose_quantity: Result := 'dose_quantity';
    CL037_nhif_vaccine_code: Result := 'nhif_vaccine_code';
    CL037_cert_text: Result := 'cert_text';
    CL037_permit_owner_id: Result := 'permit_owner_id';
    CL037_dose_quantity_in_pack: Result := 'dose_quantity_in_pack';
    CL037_days_to_next_dose_booster_special: Result := 'days_to_next_dose_booster_special';
    CL037_atc: Result := 'atc';
    CL037_days_to_next_dose_booster: Result := 'days_to_next_dose_booster';
    CL037_vaccine_group: Result := 'vaccine_group';
    CL037_medicament: Result := 'medicament';
    CL037_vaccine_code_lot_number: Result := 'vaccine_code_lot_number';
    CL037_Logical: Result := 'Logical';
  end;
end;

function TCL037Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL037Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCL037Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 23;
end;

function TCL037Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCL037Root then
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

function TCL037Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCL037Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCL037Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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
  RowSelect: Integer;
  prop: TCL037Item.TPropertyIndex;
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

procedure TCL037Coll.GetCellFromRecord(propIndex: word; CL037: TCL037Item; var AValue: String);
var
  str: string;
begin
  case TCL037Item.TPropertyIndex(propIndex) of
    CL037_Key: str := (CL037.PRecord.Key);
    CL037_Description: str := (CL037.PRecord.Description);
    CL037_DescriptionEn: str := (CL037.PRecord.DescriptionEn);
    CL037_number_of_doses: str := (CL037.PRecord.number_of_doses);
    CL037_mh_code: str := (CL037.PRecord.mh_code);
    CL037_inn: str := (CL037.PRecord.inn);
    CL037_days_to_next_dose: str := (CL037.PRecord.days_to_next_dose);
    CL037_permit_number: str := (CL037.PRecord.permit_number);
    CL037_permit_owner: str := (CL037.PRecord.permit_owner);
    CL037_target_disease: str := (CL037.PRecord.target_disease);
    CL037_doses_in_pack: str := (CL037.PRecord.doses_in_pack);
    CL037_dose_quantity: str := (CL037.PRecord.dose_quantity);
    CL037_nhif_vaccine_code: str := (CL037.PRecord.nhif_vaccine_code);
    CL037_cert_text: str := (CL037.PRecord.cert_text);
    CL037_permit_owner_id: str := (CL037.PRecord.permit_owner_id);
    CL037_dose_quantity_in_pack: str := (CL037.PRecord.dose_quantity_in_pack);
    CL037_days_to_next_dose_booster_special: str := (CL037.PRecord.days_to_next_dose_booster_special);
    CL037_atc: str := (CL037.PRecord.atc);
    CL037_days_to_next_dose_booster: str := (CL037.PRecord.days_to_next_dose_booster);
    CL037_vaccine_group: str := (CL037.PRecord.vaccine_group);
    CL037_medicament: str := (CL037.PRecord.medicament);
    CL037_vaccine_code_lot_number: str := (CL037.PRecord.vaccine_code_lot_number);
    CL037_Logical: str := CL037.Logical08ToStr(TLogicalData08(CL037.PRecord.Logical));
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
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
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

function TCL037Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL037;
end;

function TCL037Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL037Del;
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
    CL037_number_of_doses: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_mh_code: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_inn: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_days_to_next_dose: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_permit_number: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_permit_owner: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_target_disease: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_doses_in_pack: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_dose_quantity: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_nhif_vaccine_code: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_cert_text: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_permit_owner_id: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_dose_quantity_in_pack: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_days_to_next_dose_booster_special: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_atc: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_days_to_next_dose_booster: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_vaccine_group: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_medicament: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_vaccine_code_lot_number: str :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL037_Logical: str :=  CL037.Logical08ToStr(CL037.getLogical08Map(Self.Buf, Self.posData, propIndex));
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
    end;
  end;
end;

procedure TCL037Coll.IndexValueListNodes(propIndex: TCL037Item.TPropertyIndex);
begin

end;

function TCL037Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL037Item.TPropertyIndex(PropIndex) in  VisibleColl;
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

{=== TEXT SEARCH HANDLER ===}
procedure TCL037Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL037Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL037Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL037Item.TPropertyIndex(Field) of
CL037_Key: ListForFinder[0].PRecord.Key := AText;
    CL037_Description: ListForFinder[0].PRecord.Description := AText;
    CL037_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
    CL037_number_of_doses: ListForFinder[0].PRecord.number_of_doses := AText;
    CL037_mh_code: ListForFinder[0].PRecord.mh_code := AText;
    CL037_inn: ListForFinder[0].PRecord.inn := AText;
    CL037_days_to_next_dose: ListForFinder[0].PRecord.days_to_next_dose := AText;
    CL037_permit_number: ListForFinder[0].PRecord.permit_number := AText;
    CL037_permit_owner: ListForFinder[0].PRecord.permit_owner := AText;
    CL037_target_disease: ListForFinder[0].PRecord.target_disease := AText;
    CL037_doses_in_pack: ListForFinder[0].PRecord.doses_in_pack := AText;
    CL037_dose_quantity: ListForFinder[0].PRecord.dose_quantity := AText;
    CL037_nhif_vaccine_code: ListForFinder[0].PRecord.nhif_vaccine_code := AText;
    CL037_cert_text: ListForFinder[0].PRecord.cert_text := AText;
    CL037_permit_owner_id: ListForFinder[0].PRecord.permit_owner_id := AText;
    CL037_dose_quantity_in_pack: ListForFinder[0].PRecord.dose_quantity_in_pack := AText;
    CL037_days_to_next_dose_booster_special: ListForFinder[0].PRecord.days_to_next_dose_booster_special := AText;
    CL037_atc: ListForFinder[0].PRecord.atc := AText;
    CL037_days_to_next_dose_booster: ListForFinder[0].PRecord.days_to_next_dose_booster := AText;
    CL037_vaccine_group: ListForFinder[0].PRecord.vaccine_group := AText;
    CL037_medicament: ListForFinder[0].PRecord.medicament := AText;
    CL037_vaccine_code_lot_number: ListForFinder[0].PRecord.vaccine_code_lot_number := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL037Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL037Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL037Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL037Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL037Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL037Item.TPropertyIndex(Field) of
    CL037_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL037(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL037(logIndex))   
    end;
  end;
end;


procedure TCL037Coll.OnSetTextSearchLog(Log: TlogicalCL037Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL037Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCL037Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL037Item.TPropertyIndex(propIndex) of
    CL037_Key: Result := actAnsiString;
    CL037_Description: Result := actAnsiString;
    CL037_DescriptionEn: Result := actAnsiString;
    CL037_number_of_doses: Result := actAnsiString;
    CL037_mh_code: Result := actAnsiString;
    CL037_inn: Result := actAnsiString;
    CL037_days_to_next_dose: Result := actAnsiString;
    CL037_permit_number: Result := actAnsiString;
    CL037_permit_owner: Result := actAnsiString;
    CL037_target_disease: Result := actAnsiString;
    CL037_doses_in_pack: Result := actAnsiString;
    CL037_dose_quantity: Result := actAnsiString;
    CL037_nhif_vaccine_code: Result := actAnsiString;
    CL037_cert_text: Result := actAnsiString;
    CL037_permit_owner_id: Result := actAnsiString;
    CL037_dose_quantity_in_pack: Result := actAnsiString;
    CL037_days_to_next_dose_booster_special: Result := actAnsiString;
    CL037_atc: Result := actAnsiString;
    CL037_days_to_next_dose_booster: Result := actAnsiString;
    CL037_vaccine_group: Result := actAnsiString;
    CL037_medicament: Result := actAnsiString;
    CL037_vaccine_code_lot_number: Result := actAnsiString;
    CL037_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL037Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL037Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL037: TCL037Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL037 := Items[ARow];
  if not Assigned(CL037.PRecord) then
  begin
    New(CL037.PRecord);
    CL037.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL037Item.TPropertyIndex(ACol) of
      CL037_Key: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_Description: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_DescriptionEn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_number_of_doses: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_mh_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_inn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_days_to_next_dose: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_permit_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_permit_owner: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_target_disease: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_doses_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_dose_quantity: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_nhif_vaccine_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_cert_text: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_permit_owner_id: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_dose_quantity_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_days_to_next_dose_booster_special: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_atc: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_days_to_next_dose_booster: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_vaccine_group: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_medicament: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL037_vaccine_code_lot_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
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
    CL037_number_of_doses: CL037.PRecord.number_of_doses := AValue;
    CL037_mh_code: CL037.PRecord.mh_code := AValue;
    CL037_inn: CL037.PRecord.inn := AValue;
    CL037_days_to_next_dose: CL037.PRecord.days_to_next_dose := AValue;
    CL037_permit_number: CL037.PRecord.permit_number := AValue;
    CL037_permit_owner: CL037.PRecord.permit_owner := AValue;
    CL037_target_disease: CL037.PRecord.target_disease := AValue;
    CL037_doses_in_pack: CL037.PRecord.doses_in_pack := AValue;
    CL037_dose_quantity: CL037.PRecord.dose_quantity := AValue;
    CL037_nhif_vaccine_code: CL037.PRecord.nhif_vaccine_code := AValue;
    CL037_cert_text: CL037.PRecord.cert_text := AValue;
    CL037_permit_owner_id: CL037.PRecord.permit_owner_id := AValue;
    CL037_dose_quantity_in_pack: CL037.PRecord.dose_quantity_in_pack := AValue;
    CL037_days_to_next_dose_booster_special: CL037.PRecord.days_to_next_dose_booster_special := AValue;
    CL037_atc: CL037.PRecord.atc := AValue;
    CL037_days_to_next_dose_booster: CL037.PRecord.days_to_next_dose_booster := AValue;
    CL037_vaccine_group: CL037.PRecord.vaccine_group := AValue;
    CL037_medicament: CL037.PRecord.medicament := AValue;
    CL037_vaccine_code_lot_number: CL037.PRecord.vaccine_code_lot_number := AValue;
    CL037_Logical: CL037.PRecord.Logical := tlogicalCL037Set(CL037.StrToLogical08(AValue));
  end;
end;

procedure TCL037Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL037: TCL037Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL037 := Items[ARow];
  if not Assigned(CL037.PRecord) then
  begin
    New(CL037.PRecord);
    CL037.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL037Item.TPropertyIndex(ACol) of
      CL037_Key: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_Description: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_DescriptionEn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_number_of_doses: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_mh_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_inn: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_days_to_next_dose: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_permit_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_permit_owner: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_target_disease: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_doses_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_dose_quantity: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_nhif_vaccine_code: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_cert_text: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_permit_owner_id: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_dose_quantity_in_pack: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_days_to_next_dose_booster_special: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_atc: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_days_to_next_dose_booster: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_vaccine_group: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_medicament: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL037_vaccine_code_lot_number: isOld :=  CL037.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
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
    CL037_number_of_doses: CL037.PRecord.number_of_doses := AFieldText;
    CL037_mh_code: CL037.PRecord.mh_code := AFieldText;
    CL037_inn: CL037.PRecord.inn := AFieldText;
    CL037_days_to_next_dose: CL037.PRecord.days_to_next_dose := AFieldText;
    CL037_permit_number: CL037.PRecord.permit_number := AFieldText;
    CL037_permit_owner: CL037.PRecord.permit_owner := AFieldText;
    CL037_target_disease: CL037.PRecord.target_disease := AFieldText;
    CL037_doses_in_pack: CL037.PRecord.doses_in_pack := AFieldText;
    CL037_dose_quantity: CL037.PRecord.dose_quantity := AFieldText;
    CL037_nhif_vaccine_code: CL037.PRecord.nhif_vaccine_code := AFieldText;
    CL037_cert_text: CL037.PRecord.cert_text := AFieldText;
    CL037_permit_owner_id: CL037.PRecord.permit_owner_id := AFieldText;
    CL037_dose_quantity_in_pack: CL037.PRecord.dose_quantity_in_pack := AFieldText;
    CL037_days_to_next_dose_booster_special: CL037.PRecord.days_to_next_dose_booster_special := AFieldText;
    CL037_atc: CL037.PRecord.atc := AFieldText;
    CL037_days_to_next_dose_booster: CL037.PRecord.days_to_next_dose_booster := AFieldText;
    CL037_vaccine_group: CL037.PRecord.vaccine_group := AFieldText;
    CL037_medicament: CL037.PRecord.medicament := AFieldText;
    CL037_vaccine_code_lot_number: CL037.PRecord.vaccine_code_lot_number := AFieldText;
    CL037_Logical: CL037.PRecord.Logical := tlogicalCL037Set(CL037.StrToLogical08(AFieldText));
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
      CL037_number_of_doses:
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
      CL037_inn:
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
      CL037_permit_number:
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
      CL037_target_disease:
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
      CL037_dose_quantity:
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
      CL037_cert_text:
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
      CL037_dose_quantity_in_pack:
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
      CL037_atc:
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
      CL037_vaccine_group:
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
      CL037_vaccine_code_lot_number:
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

procedure TCL037Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL037Item>);
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
      CL037_number_of_doses: SortByIndexAnsiString;
      CL037_mh_code: SortByIndexAnsiString;
      CL037_inn: SortByIndexAnsiString;
      CL037_days_to_next_dose: SortByIndexAnsiString;
      CL037_permit_number: SortByIndexAnsiString;
      CL037_permit_owner: SortByIndexAnsiString;
      CL037_target_disease: SortByIndexAnsiString;
      CL037_doses_in_pack: SortByIndexAnsiString;
      CL037_dose_quantity: SortByIndexAnsiString;
      CL037_nhif_vaccine_code: SortByIndexAnsiString;
      CL037_cert_text: SortByIndexAnsiString;
      CL037_permit_owner_id: SortByIndexAnsiString;
      CL037_dose_quantity_in_pack: SortByIndexAnsiString;
      CL037_days_to_next_dose_booster_special: SortByIndexAnsiString;
      CL037_atc: SortByIndexAnsiString;
      CL037_days_to_next_dose_booster: SortByIndexAnsiString;
      CL037_vaccine_group: SortByIndexAnsiString;
      CL037_medicament: SortByIndexAnsiString;
      CL037_vaccine_code_lot_number: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL037Coll.ImportXMLNzis(cl000: TObject);
var
 Acl000 : TCL000EntryCollection;
 entry : TCL000EntryItem;
 item : TCL037Item;
 i, idxOld, j: Integer;
 idx : array of Integer;
 propIdx: TCL037Item.TPropertyIndex;
 propName, xmlName, oldValue, newValue: string;
 kindDiff: TDiffKind; pCardinalData: PCardinal;
 dataPosition: Cardinal; IsNew: Boolean;
begin
  Acl000 := TCL000EntryCollection(cl000);
  IsNew := Count = 0;

  for i := 0 to Count - 1 do
  begin
    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ctCL037Del) then
      Continue;
    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ctCL037Old);
  end;

  BuildKeyDict(Ord(CL037_Key));

  j := 0;
  SetLength(idx, 0);

  for propIdx := Low(TCL037Item.TPropertyIndex) to High(TCL037Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    if SameText(propName, 'CL037_Key') then Continue;
    if SameText(propName, 'CL037_Description') then Continue;
    if SameText(propName, 'CL037_Logical') then Continue;

    xmlName := propName.Substring(Length('CL037_'));
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
      item := TCL037Item(Add);
      kindDiff := dkNew;
    end;

    if item.PRecord <> nil then
      Dispose(item.PRecord);
    New(item.PRecord);
    item.PRecord.setProp := [];

    newValue := entry.Key;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_Key));
    item.PRecord.Key := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL037_Key);

    newValue := entry.Descr;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_Description));
    item.PRecord.Description := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL037_Description);

    j := 0;
    // DescriptionEn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_DescriptionEn));

      Item.PRecord.DescriptionEn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_DescriptionEn);
    end;
    Inc(j);

    // number_of_doses
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_number_of_doses));

      Item.PRecord.number_of_doses := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_number_of_doses);
    end;
    Inc(j);

    // mh_code
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_mh_code));

      Item.PRecord.mh_code := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_mh_code);
    end;
    Inc(j);

    // inn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_inn));

      Item.PRecord.inn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_inn);
    end;
    Inc(j);

    // days_to_next_dose
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_days_to_next_dose));

      Item.PRecord.days_to_next_dose := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_days_to_next_dose);
    end;
    Inc(j);

    // permit_number
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_permit_number));

      Item.PRecord.permit_number := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_permit_number);
    end;
    Inc(j);

    // permit_owner
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_permit_owner));

      Item.PRecord.permit_owner := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_permit_owner);
    end;
    Inc(j);

    // target_disease
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_target_disease));

      Item.PRecord.target_disease := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_target_disease);
    end;
    Inc(j);

    // doses_in_pack
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_doses_in_pack));

      Item.PRecord.doses_in_pack := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_doses_in_pack);
    end;
    Inc(j);

    // dose_quantity
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_dose_quantity));

      Item.PRecord.dose_quantity := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_dose_quantity);
    end;
    Inc(j);

    // nhif_vaccine_code
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_nhif_vaccine_code));

      Item.PRecord.nhif_vaccine_code := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_nhif_vaccine_code);
    end;
    Inc(j);

    // cert_text
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_cert_text));

      Item.PRecord.cert_text := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_cert_text);
    end;
    Inc(j);

    // permit_owner_id
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_permit_owner_id));

      Item.PRecord.permit_owner_id := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_permit_owner_id);
    end;
    Inc(j);

    // dose_quantity_in_pack
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_dose_quantity_in_pack));

      Item.PRecord.dose_quantity_in_pack := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_dose_quantity_in_pack);
    end;
    Inc(j);

    // days_to_next_dose_booster_special
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_days_to_next_dose_booster_special));

      Item.PRecord.days_to_next_dose_booster_special := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_days_to_next_dose_booster_special);
    end;
    Inc(j);

    // atc
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_atc));

      Item.PRecord.atc := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_atc);
    end;
    Inc(j);

    // days_to_next_dose_booster
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_days_to_next_dose_booster));

      Item.PRecord.days_to_next_dose_booster := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_days_to_next_dose_booster);
    end;
    Inc(j);

    // vaccine_group
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_vaccine_group));

      Item.PRecord.vaccine_group := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_vaccine_group);
    end;
    Inc(j);

    // medicament
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_medicament));

      Item.PRecord.medicament := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_medicament);
    end;
    Inc(j);

    // vaccine_code_lot_number
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL037_vaccine_code_lot_number));

      Item.PRecord.vaccine_code_lot_number := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL037_vaccine_code_lot_number);
    end;
    Inc(j);

    // NEW
    if kindDiff = dkNew then
    begin
      if IsNew then
      begin
        item.InsertCL037;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL037);
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
          item.SaveCL037(dataPosition);
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL037);
          Self.streamComm.Len := Self.streamComm.Size;
          Self.cmdFile.CopyFrom(Self.streamComm, 0);
          pCardinalData^ := dataPosition - PosData;
        end
        else
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL037);
      end
      else
      begin
        Dispose(item.PRecord);
        item.PRecord := nil;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL037);
      end;
    end;
  end;
end;

procedure TCL037Coll.UpdateXMLNzis;
var
  i: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].PRecord = nil then
    begin
      if Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ = ord(ctCL037Old) then
        Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ := ord(ctCL037Del);
        Continue;
    end;


    if Items[i].DataPos = 0 then
    begin
      Items[i].InsertCL037;
      Self.streamComm.Len := Self.streamComm.Size;
      Self.cmdFile.CopyFrom(Self.streamComm, 0);
      Dispose(Items[i].PRecord);
      Items[i].PRecord := nil;
    end
    else
    begin
      pCardinalData := pointer(PByte(self.Buf) + 12);
      dataPosition := pCardinalData^ + self.PosData;
      Items[i].SaveCL037(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      pCardinalData := pointer(PByte(Buf) + 12);
      pCardinalData^  := dataPosition - self.PosData;
    end;

  end;
end;

procedure TCL037Coll.BuildKeyDict(PropIndex: Word);
var
  i      : Integer;
  item   : TCL037Item;
  keyStr : string;
  pIdx   : TCL037Item.TPropertyIndex;
begin
  // общата част – алокация / чистене на речника
  inherited BuildKeyDict(PropIndex);

  // кастваме Word > enum на генерирания клас
  pIdx := TCL037Item.TPropertyIndex(PropIndex);

  for i := 0 to Count - 1 do
  begin
    item := Items[i];
    if Pword(PByte(Buf) + item.DataPos +  - 4)^ = ord(ctCL037Del) then
      Continue;
    keyStr := self.getAnsiStringMap(item.datapos,PropIndex);

    if keyStr <> '' then
    begin
      // ако има дубликати – последният печели (полезно за "последна версия")
      KeyDict.AddOrSetValue(keyStr, i);
    end;
  end;
end;

function TCL037Coll.CellDiffKind(ACol, ARow: Integer): TDiffKind;
begin
  if (ARow > count) or (ARow < 0) then
    Exit;


  if items[ARow].DataPos = 0 then
  begin
    Result := dkNew;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL037Old)) then
  begin
    Result := dkForDeleted;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL037Del)) then
  begin
    Result := dkDeleted;
    Exit;
  end;

  if Items[ARow].PRecord = nil then
  begin
    Result := dkNone;
    Exit;
  end;

  if TCL037Item.TPropertyIndex(ACol) in Items[ARow].PRecord.setProp then
  begin
    Result := dkChanged;
    Exit;
  end;
  //test

end;

{NZIS_END}

end.