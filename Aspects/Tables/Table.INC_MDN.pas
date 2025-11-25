unit Table.INC_MDN;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults;

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

TLogicalINC_MDN = (
    FINANCING_SOURCE_MZ,
    FINANCING_SOURCE_NHIF,
    FINANCING_SOURCE_Fund,
    FINANCING_SOURCE_Patient,
    FINANCING_SOURCE_Budget,
    FINANCING_SOURCE_NSSI,
    FINANCING_SOURCE_None,
    FINANCING_SOURCE_Screening,
    FINANCING_SOURCE_MON,
    IS_BONUS,
    IS_FORM_VALID,
    IS_INSIDE,
    IS_LKK,
    IS_NAET,
    IS_NZOK,
    IS_PODVIZHNO_LZ,
    IS_REJECTED_BY_RZOK,
    IS_STACIONAR,
    IS_ZAMESTVASHT,
    MED_DIAG_NAPR_Ostro,
    MED_DIAG_NAPR_Hron,
    MED_DIAG_NAPR_Izbor,
    MED_DIAG_NAPR_Disp,
    MED_DIAG_NAPR_Eksp,
    MED_DIAG_NAPR_Prof,
    MED_DIAG_NAPR_Iskane_Telk,
    MED_DIAG_NAPR_Choice_Mother,
    MED_DIAG_NAPR_Choice_Child,
    MED_DIAG_NAPR_PreChoice_Mother,
    MED_DIAG_NAPR_PreChoice_Child,
    MED_DIAG_NAPR_Podg_Telk,
    NZIS_STATUS_None,
    NZIS_STATUS_Active,
    NZIS_STATUS_Izpuln,
    NZIS_STATUS_NotValid,
    NZIS_STATUS_Cancel,
    NZIS_STATUS_Iztegleno,
    NZIS_STATUS_ZaObrabotka,
    NZIS_STATUS_PoluIzpuln,
    NZIS_STATUS_Err,
    NZIS_STATUS_Izvetrel );
TlogicalINC_MDNSet = set of TLogicalINC_MDN;


TINC_MDNItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       INC_MDN_ACCOUNT_ID
       , INC_MDN_AMBJOURNALN
       , INC_MDN_AMBJOURNALN_PAYED
       , INC_MDN_AMBLISTN
       , INC_MDN_AMB_NRN
       , INC_MDN_ASSIGMENT_TIME
       , INC_MDN_DATA
       , INC_MDN_DATE_EXECUTION
       , INC_MDN_DATE_PROBOVZEMANE
       , INC_MDN_DESCRIPTION
       , INC_MDN_EXECUTION_TIME
       , INC_MDN_FUND_ID
       , INC_MDN_ID
       , INC_MDN_NOMERBELEGKA
       , INC_MDN_NOMERKASHAPARAT
       , INC_MDN_NRN
       , INC_MDN_NUMBER
       , INC_MDN_NZOK_NOMER
       , INC_MDN_PACKAGE
       , INC_MDN_PASS
       , INC_MDN_SEND_MAIL_DATE
       , INC_MDN_THREAD_IDS
       , INC_MDN_TIME_PROBOVZEMANE
       , INC_MDN_TOKEN_RESULT
       , INC_MDN_VISIT_ID
       , INC_MDN_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecINC_MDN = ^TRecINC_MDN;
      TRecINC_MDN = record
        ACCOUNT_ID: integer;
        AMBJOURNALN: integer;
        AMBJOURNALN_PAYED: integer;
        AMBLISTN: integer;
        AMB_NRN: AnsiString;
        ASSIGMENT_TIME: TTime;
        DATA: TDate;
        DATE_EXECUTION: TDate;
        DATE_PROBOVZEMANE: TDate;
        DESCRIPTION: AnsiString;
        EXECUTION_TIME: TTime;
        FUND_ID: integer;
        ID: integer;
        NOMERBELEGKA: AnsiString;
        NOMERKASHAPARAT: AnsiString;
        NRN: AnsiString;
        NUMBER: integer;
        NZOK_NOMER: AnsiString;
        PACKAGE: word;
        PASS: AnsiString;
        SEND_MAIL_DATE: TDate;
        THREAD_IDS: AnsiString;
        TIME_PROBOVZEMANE: TTime;
        TOKEN_RESULT: AnsiString;
        VISIT_ID: integer;
        Logical: TlogicalINC_MDNSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecINC_MDN;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertINC_MDN;
    procedure UpdateINC_MDN;
    procedure SaveINC_MDN(var dataPosition: Cardinal)overload;
	procedure SaveINC_MDN(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TINC_MDNColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TINC_MDNItem;
    function GetItem(Index: Integer): TINC_MDNItem;
    procedure SetItem(Index: Integer; const Value: TINC_MDNItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TINC_MDNItem>;
    ListINC_MDNSearch: TList<TINC_MDNItem>;
	PRecordSearch: ^TINC_MDNItem.TRecINC_MDN;
    ArrPropSearch: TArray<TINC_MDNItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TINC_MDNItem.TPropertyIndex>;
	VisibleColl: TINC_MDNItem.TSetProp;
	ArrayPropOrder: TArray<TINC_MDNItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TINC_MDNItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; INC_MDN: TINC_MDNItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; INC_MDN: TINC_MDNItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TINC_MDNItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TINC_MDNItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TINC_MDNItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TINC_MDNItem.TPropertyIndex);
    property Items[Index: Integer]: TINC_MDNItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalINC_MDNSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TINC_MDNItem }

constructor TINC_MDNItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TINC_MDNItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TINC_MDNItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TINC_MDNItem.GetCollType: TCollectionsType;
begin
  Result := ctINC_MDN;
end;

function TINC_MDNItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TINC_MDNItem.InsertINC_MDN;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctINC_MDN;
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
            INC_MDN_ACCOUNT_ID: SaveData(PRecord.ACCOUNT_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBJOURNALN: SaveData(PRecord.AMBJOURNALN, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBJOURNALN_PAYED: SaveData(PRecord.AMBJOURNALN_PAYED, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBLISTN: SaveData(PRecord.AMBLISTN, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMB_NRN: SaveData(PRecord.AMB_NRN, PropPosition, metaPosition, dataPosition);
            INC_MDN_ASSIGMENT_TIME: SaveData(PRecord.ASSIGMENT_TIME, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATE_EXECUTION: SaveData(PRecord.DATE_EXECUTION, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATE_PROBOVZEMANE: SaveData(PRecord.DATE_PROBOVZEMANE, PropPosition, metaPosition, dataPosition);
            INC_MDN_DESCRIPTION: SaveData(PRecord.DESCRIPTION, PropPosition, metaPosition, dataPosition);
            INC_MDN_EXECUTION_TIME: SaveData(PRecord.EXECUTION_TIME, PropPosition, metaPosition, dataPosition);
            INC_MDN_FUND_ID: SaveData(PRecord.FUND_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_NOMERBELEGKA: SaveData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            INC_MDN_NOMERKASHAPARAT: SaveData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            INC_MDN_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            INC_MDN_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            INC_MDN_NZOK_NOMER: SaveData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            INC_MDN_PACKAGE: SaveData(PRecord.PACKAGE, PropPosition, metaPosition, dataPosition);
            INC_MDN_PASS: SaveData(PRecord.PASS, PropPosition, metaPosition, dataPosition);
            INC_MDN_SEND_MAIL_DATE: SaveData(PRecord.SEND_MAIL_DATE, PropPosition, metaPosition, dataPosition);
            INC_MDN_THREAD_IDS: SaveData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            INC_MDN_TIME_PROBOVZEMANE: SaveData(PRecord.TIME_PROBOVZEMANE, PropPosition, metaPosition, dataPosition);
            INC_MDN_TOKEN_RESULT: SaveData(PRecord.TOKEN_RESULT, PropPosition, metaPosition, dataPosition);
            INC_MDN_VISIT_ID: SaveData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_Logical: SaveData(TLogicalData48(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TINC_MDNItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TINC_MDNItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TINC_MDNItem;
begin
  Result := True;
  for i := 0 to Length(TINC_MDNColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TINC_MDNColl(coll).ArrPropSearchClc[i];
	ATempItem := TINC_MDNColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        INC_MDN_ACCOUNT_ID: Result := IsFinded(ATempItem.PRecord.ACCOUNT_ID, buf, FPosDataADB, word(INC_MDN_ACCOUNT_ID), cot);
            INC_MDN_AMBJOURNALN: Result := IsFinded(ATempItem.PRecord.AMBJOURNALN, buf, FPosDataADB, word(INC_MDN_AMBJOURNALN), cot);
            INC_MDN_AMBJOURNALN_PAYED: Result := IsFinded(ATempItem.PRecord.AMBJOURNALN_PAYED, buf, FPosDataADB, word(INC_MDN_AMBJOURNALN_PAYED), cot);
            INC_MDN_AMBLISTN: Result := IsFinded(ATempItem.PRecord.AMBLISTN, buf, FPosDataADB, word(INC_MDN_AMBLISTN), cot);
            INC_MDN_AMB_NRN: Result := IsFinded(ATempItem.PRecord.AMB_NRN, buf, FPosDataADB, word(INC_MDN_AMB_NRN), cot);
            INC_MDN_ASSIGMENT_TIME: Result := IsFinded(ATempItem.PRecord.ASSIGMENT_TIME, buf, FPosDataADB, word(INC_MDN_ASSIGMENT_TIME), cot);
            INC_MDN_DATA: Result := IsFinded(ATempItem.PRecord.DATA, buf, FPosDataADB, word(INC_MDN_DATA), cot);
            INC_MDN_DATE_EXECUTION: Result := IsFinded(ATempItem.PRecord.DATE_EXECUTION, buf, FPosDataADB, word(INC_MDN_DATE_EXECUTION), cot);
            INC_MDN_DATE_PROBOVZEMANE: Result := IsFinded(ATempItem.PRecord.DATE_PROBOVZEMANE, buf, FPosDataADB, word(INC_MDN_DATE_PROBOVZEMANE), cot);
            INC_MDN_DESCRIPTION: Result := IsFinded(ATempItem.PRecord.DESCRIPTION, buf, FPosDataADB, word(INC_MDN_DESCRIPTION), cot);
            INC_MDN_EXECUTION_TIME: Result := IsFinded(ATempItem.PRecord.EXECUTION_TIME, buf, FPosDataADB, word(INC_MDN_EXECUTION_TIME), cot);
            INC_MDN_FUND_ID: Result := IsFinded(ATempItem.PRecord.FUND_ID, buf, FPosDataADB, word(INC_MDN_FUND_ID), cot);
            INC_MDN_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(INC_MDN_ID), cot);
            INC_MDN_NOMERBELEGKA: Result := IsFinded(ATempItem.PRecord.NOMERBELEGKA, buf, FPosDataADB, word(INC_MDN_NOMERBELEGKA), cot);
            INC_MDN_NOMERKASHAPARAT: Result := IsFinded(ATempItem.PRecord.NOMERKASHAPARAT, buf, FPosDataADB, word(INC_MDN_NOMERKASHAPARAT), cot);
            INC_MDN_NRN: Result := IsFinded(ATempItem.PRecord.NRN, buf, FPosDataADB, word(INC_MDN_NRN), cot);
            INC_MDN_NUMBER: Result := IsFinded(ATempItem.PRecord.NUMBER, buf, FPosDataADB, word(INC_MDN_NUMBER), cot);
            INC_MDN_NZOK_NOMER: Result := IsFinded(ATempItem.PRecord.NZOK_NOMER, buf, FPosDataADB, word(INC_MDN_NZOK_NOMER), cot);
            INC_MDN_PACKAGE: Result := IsFinded(ATempItem.PRecord.PACKAGE, buf, FPosDataADB, word(INC_MDN_PACKAGE), cot);
            INC_MDN_PASS: Result := IsFinded(ATempItem.PRecord.PASS, buf, FPosDataADB, word(INC_MDN_PASS), cot);
            INC_MDN_SEND_MAIL_DATE: Result := IsFinded(ATempItem.PRecord.SEND_MAIL_DATE, buf, FPosDataADB, word(INC_MDN_SEND_MAIL_DATE), cot);
            INC_MDN_THREAD_IDS: Result := IsFinded(ATempItem.PRecord.THREAD_IDS, buf, FPosDataADB, word(INC_MDN_THREAD_IDS), cot);
            INC_MDN_TIME_PROBOVZEMANE: Result := IsFinded(ATempItem.PRecord.TIME_PROBOVZEMANE, buf, FPosDataADB, word(INC_MDN_TIME_PROBOVZEMANE), cot);
            INC_MDN_TOKEN_RESULT: Result := IsFinded(ATempItem.PRecord.TOKEN_RESULT, buf, FPosDataADB, word(INC_MDN_TOKEN_RESULT), cot);
            INC_MDN_VISIT_ID: Result := IsFinded(ATempItem.PRecord.VISIT_ID, buf, FPosDataADB, word(INC_MDN_VISIT_ID), cot);
            INC_MDN_Logical: Result := IsFinded(TLogicalData48(ATempItem.PRecord.Logical), buf, FPosDataADB, word(INC_MDN_Logical), cot);
      end;
    end;
  end;
end;

procedure TINC_MDNItem.SaveINC_MDN(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveINC_MDN(dataPosition);
end;

procedure TINC_MDNItem.SaveINC_MDN(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctINC_MDN;
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
            INC_MDN_ACCOUNT_ID: SaveData(PRecord.ACCOUNT_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBJOURNALN: SaveData(PRecord.AMBJOURNALN, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBJOURNALN_PAYED: SaveData(PRecord.AMBJOURNALN_PAYED, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBLISTN: SaveData(PRecord.AMBLISTN, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMB_NRN: SaveData(PRecord.AMB_NRN, PropPosition, metaPosition, dataPosition);
            INC_MDN_ASSIGMENT_TIME: SaveData(PRecord.ASSIGMENT_TIME, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATE_EXECUTION: SaveData(PRecord.DATE_EXECUTION, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATE_PROBOVZEMANE: SaveData(PRecord.DATE_PROBOVZEMANE, PropPosition, metaPosition, dataPosition);
            INC_MDN_DESCRIPTION: SaveData(PRecord.DESCRIPTION, PropPosition, metaPosition, dataPosition);
            INC_MDN_EXECUTION_TIME: SaveData(PRecord.EXECUTION_TIME, PropPosition, metaPosition, dataPosition);
            INC_MDN_FUND_ID: SaveData(PRecord.FUND_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_NOMERBELEGKA: SaveData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            INC_MDN_NOMERKASHAPARAT: SaveData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            INC_MDN_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            INC_MDN_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            INC_MDN_NZOK_NOMER: SaveData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            INC_MDN_PACKAGE: SaveData(PRecord.PACKAGE, PropPosition, metaPosition, dataPosition);
            INC_MDN_PASS: SaveData(PRecord.PASS, PropPosition, metaPosition, dataPosition);
            INC_MDN_SEND_MAIL_DATE: SaveData(PRecord.SEND_MAIL_DATE, PropPosition, metaPosition, dataPosition);
            INC_MDN_THREAD_IDS: SaveData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            INC_MDN_TIME_PROBOVZEMANE: SaveData(PRecord.TIME_PROBOVZEMANE, PropPosition, metaPosition, dataPosition);
            INC_MDN_TOKEN_RESULT: SaveData(PRecord.TOKEN_RESULT, PropPosition, metaPosition, dataPosition);
            INC_MDN_VISIT_ID: SaveData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_Logical: SaveData(TLogicalData48(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TINC_MDNItem.UpdateINC_MDN;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctINC_MDN;
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
            INC_MDN_ACCOUNT_ID: UpdateData(PRecord.ACCOUNT_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBJOURNALN: UpdateData(PRecord.AMBJOURNALN, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBJOURNALN_PAYED: UpdateData(PRecord.AMBJOURNALN_PAYED, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMBLISTN: UpdateData(PRecord.AMBLISTN, PropPosition, metaPosition, dataPosition);
            INC_MDN_AMB_NRN: UpdateData(PRecord.AMB_NRN, PropPosition, metaPosition, dataPosition);
            INC_MDN_ASSIGMENT_TIME: UpdateData(PRecord.ASSIGMENT_TIME, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATE_EXECUTION: UpdateData(PRecord.DATE_EXECUTION, PropPosition, metaPosition, dataPosition);
            INC_MDN_DATE_PROBOVZEMANE: UpdateData(PRecord.DATE_PROBOVZEMANE, PropPosition, metaPosition, dataPosition);
            INC_MDN_DESCRIPTION: UpdateData(PRecord.DESCRIPTION, PropPosition, metaPosition, dataPosition);
            INC_MDN_EXECUTION_TIME: UpdateData(PRecord.EXECUTION_TIME, PropPosition, metaPosition, dataPosition);
            INC_MDN_FUND_ID: UpdateData(PRecord.FUND_ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            INC_MDN_NOMERBELEGKA: UpdateData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            INC_MDN_NOMERKASHAPARAT: UpdateData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            INC_MDN_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            INC_MDN_NUMBER: UpdateData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            INC_MDN_NZOK_NOMER: UpdateData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            INC_MDN_PACKAGE: UpdateData(PRecord.PACKAGE, PropPosition, metaPosition, dataPosition);
            INC_MDN_PASS: UpdateData(PRecord.PASS, PropPosition, metaPosition, dataPosition);
            INC_MDN_SEND_MAIL_DATE: UpdateData(PRecord.SEND_MAIL_DATE, PropPosition, metaPosition, dataPosition);
            INC_MDN_THREAD_IDS: UpdateData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            INC_MDN_TIME_PROBOVZEMANE: UpdateData(PRecord.TIME_PROBOVZEMANE, PropPosition, metaPosition, dataPosition);
            INC_MDN_TOKEN_RESULT: UpdateData(PRecord.TOKEN_RESULT, PropPosition, metaPosition, dataPosition);
            INC_MDN_VISIT_ID: UpdateData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
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

{ TINC_MDNColl }

function TINC_MDNColl.AddItem(ver: word): TINC_MDNItem;
begin
  Result := TINC_MDNItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TINC_MDNColl.AddItemForSearch: Integer;
var
  ItemForSearch: TINC_MDNItem;
begin
  ItemForSearch := TINC_MDNItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TINC_MDNColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TINC_MDNItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TINC_MDNColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvINC_MDNRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TINC_MDNColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TINC_MDNItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (INC_MDN_ACCOUNT_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ACCOUNT_ID <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_ACCOUNT_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_AMBJOURNALN in tempItem.PRecord.setProp) and (tempItem.PRecord.AMBJOURNALN <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_AMBJOURNALN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_AMBJOURNALN_PAYED in tempItem.PRecord.setProp) and (tempItem.PRecord.AMBJOURNALN_PAYED <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_AMBJOURNALN_PAYED))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_AMBLISTN in tempItem.PRecord.setProp) and (tempItem.PRecord.AMBLISTN <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_AMBLISTN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_AMB_NRN in tempItem.PRecord.setProp) and (tempItem.PRecord.AMB_NRN <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_AMB_NRN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_ASSIGMENT_TIME in tempItem.PRecord.setProp) and (tempItem.PRecord.ASSIGMENT_TIME <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_ASSIGMENT_TIME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_DATA in tempItem.PRecord.setProp) and (tempItem.PRecord.DATA <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_DATA))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_DATE_EXECUTION in tempItem.PRecord.setProp) and (tempItem.PRecord.DATE_EXECUTION <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_DATE_EXECUTION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_DATE_PROBOVZEMANE in tempItem.PRecord.setProp) and (tempItem.PRecord.DATE_PROBOVZEMANE <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_DATE_PROBOVZEMANE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_DESCRIPTION in tempItem.PRecord.setProp) and (tempItem.PRecord.DESCRIPTION <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_DESCRIPTION))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_EXECUTION_TIME in tempItem.PRecord.setProp) and (tempItem.PRecord.EXECUTION_TIME <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_EXECUTION_TIME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_FUND_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.FUND_ID <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_FUND_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_NOMERBELEGKA in tempItem.PRecord.setProp) and (tempItem.PRecord.NOMERBELEGKA <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_NOMERBELEGKA))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_NOMERKASHAPARAT in tempItem.PRecord.setProp) and (tempItem.PRecord.NOMERKASHAPARAT <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_NOMERKASHAPARAT))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_NRN in tempItem.PRecord.setProp) and (tempItem.PRecord.NRN <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_NRN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.NUMBER <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_NZOK_NOMER in tempItem.PRecord.setProp) and (tempItem.PRecord.NZOK_NOMER <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_NZOK_NOMER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_PACKAGE in tempItem.PRecord.setProp) and (tempItem.PRecord.PACKAGE <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_PACKAGE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_PASS in tempItem.PRecord.setProp) and (tempItem.PRecord.PASS <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_PASS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_SEND_MAIL_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.SEND_MAIL_DATE <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_SEND_MAIL_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_THREAD_IDS in tempItem.PRecord.setProp) and (tempItem.PRecord.THREAD_IDS <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_THREAD_IDS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_TIME_PROBOVZEMANE in tempItem.PRecord.setProp) and (tempItem.PRecord.TIME_PROBOVZEMANE <> Self.getDateMap(tempItem.DataPos, word(INC_MDN_TIME_PROBOVZEMANE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_TOKEN_RESULT in tempItem.PRecord.setProp) and (tempItem.PRecord.TOKEN_RESULT <> Self.getAnsiStringMap(tempItem.DataPos, word(INC_MDN_TOKEN_RESULT))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_VISIT_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.VISIT_ID <> Self.getIntMap(tempItem.DataPos, word(INC_MDN_VISIT_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (INC_MDN_Logical in tempItem.PRecord.setProp) and (TLogicalData48(tempItem.PRecord.Logical) <> Self.getLogical48Map(tempItem.DataPos, word(INC_MDN_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TINC_MDNColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TINC_MDNItem.Create(nil);
  ListINC_MDNSearch := TList<TINC_MDNItem>.Create;
  ListForFinder := TList<TINC_MDNItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TINC_MDNColl.destroy;
begin
  FreeAndNil(ListINC_MDNSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TINC_MDNColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TINC_MDNItem.TPropertyIndex(propIndex) of
    INC_MDN_ACCOUNT_ID: Result := 'ACCOUNT_ID';
    INC_MDN_AMBJOURNALN: Result := 'AMBJOURNALN';
    INC_MDN_AMBJOURNALN_PAYED: Result := 'AMBJOURNALN_PAYED';
    INC_MDN_AMBLISTN: Result := 'AMBLISTN';
    INC_MDN_AMB_NRN: Result := 'AMB_NRN';
    INC_MDN_ASSIGMENT_TIME: Result := 'ASSIGMENT_TIME';
    INC_MDN_DATA: Result := 'DATA';
    INC_MDN_DATE_EXECUTION: Result := 'DATE_EXECUTION';
    INC_MDN_DATE_PROBOVZEMANE: Result := 'DATE_PROBOVZEMANE';
    INC_MDN_DESCRIPTION: Result := 'DESCRIPTION';
    INC_MDN_EXECUTION_TIME: Result := 'EXECUTION_TIME';
    INC_MDN_FUND_ID: Result := 'FUND_ID';
    INC_MDN_ID: Result := 'ID';
    INC_MDN_NOMERBELEGKA: Result := 'NOMERBELEGKA';
    INC_MDN_NOMERKASHAPARAT: Result := 'NOMERKASHAPARAT';
    INC_MDN_NRN: Result := 'NRN';
    INC_MDN_NUMBER: Result := 'NUMBER';
    INC_MDN_NZOK_NOMER: Result := 'NZOK_NOMER';
    INC_MDN_PACKAGE: Result := 'PACKAGE';
    INC_MDN_PASS: Result := 'PASS';
    INC_MDN_SEND_MAIL_DATE: Result := 'SEND_MAIL_DATE';
    INC_MDN_THREAD_IDS: Result := 'THREAD_IDS';
    INC_MDN_TIME_PROBOVZEMANE: Result := 'TIME_PROBOVZEMANE';
    INC_MDN_TOKEN_RESULT: Result := 'TOKEN_RESULT';
    INC_MDN_VISIT_ID: Result := 'VISIT_ID';
    INC_MDN_Logical: Result := 'Logical';
  end;
end;

function TINC_MDNColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'FINANCING_SOURCE_MZ';
    1: Result := 'FINANCING_SOURCE_NHIF';
    2: Result := 'FINANCING_SOURCE_Fund';
    3: Result := 'FINANCING_SOURCE_Patient';
    4: Result := 'FINANCING_SOURCE_Budget';
    5: Result := 'FINANCING_SOURCE_NSSI';
    6: Result := 'FINANCING_SOURCE_None';
    7: Result := 'FINANCING_SOURCE_Screening';
    8: Result := 'FINANCING_SOURCE_MON';
    9: Result := 'IS_BONUS';
    10: Result := 'IS_FORM_VALID';
    11: Result := 'IS_INSIDE';
    12: Result := 'IS_LKK';
    13: Result := 'IS_NAET';
    14: Result := 'IS_NZOK';
    15: Result := 'IS_PODVIZHNO_LZ';
    16: Result := 'IS_REJECTED_BY_RZOK';
    17: Result := 'IS_STACIONAR';
    18: Result := 'IS_ZAMESTVASHT';
    19: Result := 'MED_DIAG_NAPR_Ostro';
    20: Result := 'MED_DIAG_NAPR_Hron';
    21: Result := 'MED_DIAG_NAPR_Izbor';
    22: Result := 'MED_DIAG_NAPR_Disp';
    23: Result := 'MED_DIAG_NAPR_Eksp';
    24: Result := 'MED_DIAG_NAPR_Prof';
    25: Result := 'MED_DIAG_NAPR_Iskane_Telk';
    26: Result := 'MED_DIAG_NAPR_Choice_Mother';
    27: Result := 'MED_DIAG_NAPR_Choice_Child';
    28: Result := 'MED_DIAG_NAPR_PreChoice_Mother';
    29: Result := 'MED_DIAG_NAPR_PreChoice_Child';
    30: Result := 'MED_DIAG_NAPR_Podg_Telk';
    31: Result := 'NZIS_STATUS_None';
    32: Result := 'NZIS_STATUS_Active';
    33: Result := 'NZIS_STATUS_Izpuln';
    34: Result := 'NZIS_STATUS_NotValid';
    35: Result := 'NZIS_STATUS_Cancel';
    36: Result := 'NZIS_STATUS_Iztegleno';
    37: Result := 'NZIS_STATUS_ZaObrabotka';
    38: Result := 'NZIS_STATUS_PoluIzpuln';
    39: Result := 'NZIS_STATUS_Err';
    40: Result := 'NZIS_STATUS_Izvetrel';
  else
    Result := '???';
  end;
end;


procedure TINC_MDNColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TINC_MDNColl.FieldCount: Integer; 
begin
  inherited;
  Result := 26;
end;

function TINC_MDNColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvINC_MDNRoot then
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

function TINC_MDNColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TINC_MDNColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TINC_MDNColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TINC_MDNColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  INC_MDN: TINC_MDNItem;
  ACol: Integer;
  prop: TINC_MDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  INC_MDN := Items[ARow];
  prop := TINC_MDNItem.TPropertyIndex(ACol);
  if Assigned(INC_MDN.PRecord) and (prop in INC_MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, INC_MDN, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, INC_MDN, AValue);
  end;
end;

procedure TINC_MDNColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TINC_MDNItem.TPropertyIndex;
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

procedure TINC_MDNColl.GetCellFromRecord(propIndex: word; INC_MDN: TINC_MDNItem; var AValue: String);
var
  str: string;
begin
  case TINC_MDNItem.TPropertyIndex(propIndex) of
    INC_MDN_ACCOUNT_ID: str := inttostr(INC_MDN.PRecord.ACCOUNT_ID);
    INC_MDN_AMBJOURNALN: str := inttostr(INC_MDN.PRecord.AMBJOURNALN);
    INC_MDN_AMBJOURNALN_PAYED: str := inttostr(INC_MDN.PRecord.AMBJOURNALN_PAYED);
    INC_MDN_AMBLISTN: str := inttostr(INC_MDN.PRecord.AMBLISTN);
    INC_MDN_AMB_NRN: str := (INC_MDN.PRecord.AMB_NRN);
    INC_MDN_ASSIGMENT_TIME: str := TimeToStr(INC_MDN.PRecord.ASSIGMENT_TIME);
    INC_MDN_DATA: str := AspDateToStr(INC_MDN.PRecord.DATA);
    INC_MDN_DATE_EXECUTION: str := AspDateToStr(INC_MDN.PRecord.DATE_EXECUTION);
    INC_MDN_DATE_PROBOVZEMANE: str := AspDateToStr(INC_MDN.PRecord.DATE_PROBOVZEMANE);
    INC_MDN_DESCRIPTION: str := (INC_MDN.PRecord.DESCRIPTION);
    INC_MDN_EXECUTION_TIME: str := TimeToStr(INC_MDN.PRecord.EXECUTION_TIME);
    INC_MDN_FUND_ID: str := inttostr(INC_MDN.PRecord.FUND_ID);
    INC_MDN_ID: str := inttostr(INC_MDN.PRecord.ID);
    INC_MDN_NOMERBELEGKA: str := (INC_MDN.PRecord.NOMERBELEGKA);
    INC_MDN_NOMERKASHAPARAT: str := (INC_MDN.PRecord.NOMERKASHAPARAT);
    INC_MDN_NRN: str := (INC_MDN.PRecord.NRN);
    INC_MDN_NUMBER: str := inttostr(INC_MDN.PRecord.NUMBER);
    INC_MDN_NZOK_NOMER: str := (INC_MDN.PRecord.NZOK_NOMER);
    INC_MDN_PACKAGE: str := inttostr(INC_MDN.PRecord.PACKAGE);
    INC_MDN_PASS: str := (INC_MDN.PRecord.PASS);
    INC_MDN_SEND_MAIL_DATE: str := AspDateToStr(INC_MDN.PRecord.SEND_MAIL_DATE);
    INC_MDN_THREAD_IDS: str := (INC_MDN.PRecord.THREAD_IDS);
    INC_MDN_TIME_PROBOVZEMANE: str := TimeToStr(INC_MDN.PRecord.TIME_PROBOVZEMANE);
    INC_MDN_TOKEN_RESULT: str := (INC_MDN.PRecord.TOKEN_RESULT);
    INC_MDN_VISIT_ID: str := inttostr(INC_MDN.PRecord.VISIT_ID);
    INC_MDN_Logical: str := INC_MDN.Logical48ToStr(TLogicalData48(INC_MDN.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TINC_MDNColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TINC_MDNItem;
  ACol: Integer;
  prop: TINC_MDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TINC_MDNItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TINC_MDNColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TINC_MDNItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TINC_MDNItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TINC_MDNColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  INC_MDN: TINC_MDNItem;
  ACol: Integer;
  prop: TINC_MDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  INC_MDN := ListINC_MDNSearch[ARow];
  prop := TINC_MDNItem.TPropertyIndex(ACol);
  if Assigned(INC_MDN.PRecord) and (prop in INC_MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, INC_MDN, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, INC_MDN, AValue);
  end;
end;

function TINC_MDNColl.GetCollType: TCollectionsType;
begin
  Result := ctINC_MDN;
end;

function TINC_MDNColl.GetCollDelType: TCollectionsType;
begin
  Result := ctINC_MDNDel;
end;

procedure TINC_MDNColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  INC_MDN: TINC_MDNItem;
  prop: TINC_MDNItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  INC_MDN := Items[ARow];
  prop := TINC_MDNItem.TPropertyIndex(ACol);
  if Assigned(INC_MDN.PRecord) and (prop in INC_MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, INC_MDN, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, INC_MDN, AFieldText);
  end;
end;

procedure TINC_MDNColl.GetCellFromMap(propIndex: word; ARow: Integer; INC_MDN: TINC_MDNItem; var AValue: String);
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
  case TINC_MDNItem.TPropertyIndex(propIndex) of
    INC_MDN_ACCOUNT_ID: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_AMBJOURNALN: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_AMBJOURNALN_PAYED: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_AMBLISTN: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_AMB_NRN: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_ASSIGMENT_TIME: str :=  TimeToStr(INC_MDN.getTimeMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_DATA: str :=  AspDateToStr(INC_MDN.getDateMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_DATE_EXECUTION: str :=  AspDateToStr(INC_MDN.getDateMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_DATE_PROBOVZEMANE: str :=  AspDateToStr(INC_MDN.getDateMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_DESCRIPTION: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_EXECUTION_TIME: str :=  TimeToStr(INC_MDN.getTimeMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_FUND_ID: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_ID: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_NOMERBELEGKA: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_NOMERKASHAPARAT: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_NRN: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_NUMBER: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_NZOK_NOMER: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_PACKAGE: str :=  inttostr(INC_MDN.getWordMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_PASS: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_SEND_MAIL_DATE: str :=  AspDateToStr(INC_MDN.getDateMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_THREAD_IDS: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_TIME_PROBOVZEMANE: str :=  TimeToStr(INC_MDN.getTimeMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_TOKEN_RESULT: str :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    INC_MDN_VISIT_ID: str :=  inttostr(INC_MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    INC_MDN_Logical: str :=  INC_MDN.Logical48ToStr(INC_MDN.getLogical48Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TINC_MDNColl.GetItem(Index: Integer): TINC_MDNItem;
begin
  Result := TINC_MDNItem(inherited GetItem(Index));
end;


procedure TINC_MDNColl.IndexValue(propIndex: TINC_MDNItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TINC_MDNItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      INC_MDN_ACCOUNT_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_AMBJOURNALN: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_AMBJOURNALN_PAYED: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_AMBLISTN: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_AMB_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_DESCRIPTION:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_FUND_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_NOMERBELEGKA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_NOMERKASHAPARAT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_NZOK_NOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_PACKAGE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      INC_MDN_PASS:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_THREAD_IDS:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_TOKEN_RESULT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      INC_MDN_VISIT_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TINC_MDNColl.IndexValueListNodes(propIndex: TINC_MDNItem.TPropertyIndex);
begin

end;

function TINC_MDNColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TINC_MDNItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TINC_MDNColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TINC_MDNItem;
begin
  if index < 0 then
  begin
    Tempitem := TINC_MDNItem.Create(nil);
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
procedure TINC_MDNColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TINC_MDNItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TINC_MDNItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TINC_MDNItem.TPropertyIndex(Field) of
INC_MDN_AMB_NRN: ListForFinder[0].PRecord.AMB_NRN := AText;
    INC_MDN_DESCRIPTION: ListForFinder[0].PRecord.DESCRIPTION := AText;
    INC_MDN_NOMERBELEGKA: ListForFinder[0].PRecord.NOMERBELEGKA := AText;
    INC_MDN_NOMERKASHAPARAT: ListForFinder[0].PRecord.NOMERKASHAPARAT := AText;
    INC_MDN_NRN: ListForFinder[0].PRecord.NRN := AText;
    INC_MDN_NZOK_NOMER: ListForFinder[0].PRecord.NZOK_NOMER := AText;
    INC_MDN_PASS: ListForFinder[0].PRecord.PASS := AText;
    INC_MDN_THREAD_IDS: ListForFinder[0].PRecord.THREAD_IDS := AText;
    INC_MDN_TOKEN_RESULT: ListForFinder[0].PRecord.TOKEN_RESULT := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TINC_MDNColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TINC_MDNItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TINC_MDNItem.TPropertyIndex(Field) of
INC_MDN_ASSIGMENT_TIME: ListForFinder[0].PRecord.ASSIGMENT_TIME := Value;
    INC_MDN_DATA: ListForFinder[0].PRecord.DATA := Value;
    INC_MDN_DATE_EXECUTION: ListForFinder[0].PRecord.DATE_EXECUTION := Value;
    INC_MDN_DATE_PROBOVZEMANE: ListForFinder[0].PRecord.DATE_PROBOVZEMANE := Value;
    INC_MDN_EXECUTION_TIME: ListForFinder[0].PRecord.EXECUTION_TIME := Value;
    INC_MDN_SEND_MAIL_DATE: ListForFinder[0].PRecord.SEND_MAIL_DATE := Value;
    INC_MDN_TIME_PROBOVZEMANE: ListForFinder[0].PRecord.TIME_PROBOVZEMANE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TINC_MDNColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TINC_MDNItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TINC_MDNItem.TPropertyIndex(Field) of
INC_MDN_ACCOUNT_ID: ListForFinder[0].PRecord.ACCOUNT_ID := Value;
    INC_MDN_AMBJOURNALN: ListForFinder[0].PRecord.AMBJOURNALN := Value;
    INC_MDN_AMBJOURNALN_PAYED: ListForFinder[0].PRecord.AMBJOURNALN_PAYED := Value;
    INC_MDN_AMBLISTN: ListForFinder[0].PRecord.AMBLISTN := Value;
    INC_MDN_FUND_ID: ListForFinder[0].PRecord.FUND_ID := Value;
    INC_MDN_ID: ListForFinder[0].PRecord.ID := Value;
    INC_MDN_NUMBER: ListForFinder[0].PRecord.NUMBER := Value;
    INC_MDN_PACKAGE: ListForFinder[0].PRecord.PACKAGE := Value;
    INC_MDN_VISIT_ID: ListForFinder[0].PRecord.VISIT_ID := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TINC_MDNColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TINC_MDNItem.TPropertyIndex(Field) of
    INC_MDN_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalINC_MDN(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalINC_MDN(logIndex))   
    end;
  end;
end;


procedure TINC_MDNColl.OnSetTextSearchLog(Log: TlogicalINC_MDNSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TINC_MDNColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TINC_MDNColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TINC_MDNItem.TPropertyIndex(propIndex) of
    INC_MDN_ACCOUNT_ID: Result := actinteger;
    INC_MDN_AMBJOURNALN: Result := actinteger;
    INC_MDN_AMBJOURNALN_PAYED: Result := actinteger;
    INC_MDN_AMBLISTN: Result := actinteger;
    INC_MDN_AMB_NRN: Result := actAnsiString;
    INC_MDN_ASSIGMENT_TIME: Result := actTTime;
    INC_MDN_DATA: Result := actTDate;
    INC_MDN_DATE_EXECUTION: Result := actTDate;
    INC_MDN_DATE_PROBOVZEMANE: Result := actTDate;
    INC_MDN_DESCRIPTION: Result := actAnsiString;
    INC_MDN_EXECUTION_TIME: Result := actTTime;
    INC_MDN_FUND_ID: Result := actinteger;
    INC_MDN_ID: Result := actinteger;
    INC_MDN_NOMERBELEGKA: Result := actAnsiString;
    INC_MDN_NOMERKASHAPARAT: Result := actAnsiString;
    INC_MDN_NRN: Result := actAnsiString;
    INC_MDN_NUMBER: Result := actinteger;
    INC_MDN_NZOK_NOMER: Result := actAnsiString;
    INC_MDN_PACKAGE: Result := actword;
    INC_MDN_PASS: Result := actAnsiString;
    INC_MDN_SEND_MAIL_DATE: Result := actTDate;
    INC_MDN_THREAD_IDS: Result := actAnsiString;
    INC_MDN_TIME_PROBOVZEMANE: Result := actTTime;
    INC_MDN_TOKEN_RESULT: Result := actAnsiString;
    INC_MDN_VISIT_ID: Result := actinteger;
    INC_MDN_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TINC_MDNColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TINC_MDNColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  INC_MDN: TINC_MDNItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  INC_MDN := Items[ARow];
  if not Assigned(INC_MDN.PRecord) then
  begin
    New(INC_MDN.PRecord);
    INC_MDN.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TINC_MDNItem.TPropertyIndex(ACol) of
      INC_MDN_ACCOUNT_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_AMBJOURNALN: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_AMBJOURNALN_PAYED: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_AMBLISTN: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_AMB_NRN: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_ASSIGMENT_TIME: isOld :=  INC_MDN.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);
    INC_MDN_DATA: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    INC_MDN_DATE_EXECUTION: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    INC_MDN_DATE_PROBOVZEMANE: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    INC_MDN_DESCRIPTION: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_EXECUTION_TIME: isOld :=  INC_MDN.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);
    INC_MDN_FUND_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_NOMERBELEGKA: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_NOMERKASHAPARAT: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_NRN: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_NUMBER: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_NZOK_NOMER: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_PACKAGE: isOld :=  INC_MDN.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    INC_MDN_PASS: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_SEND_MAIL_DATE: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    INC_MDN_THREAD_IDS: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_TIME_PROBOVZEMANE: isOld :=  INC_MDN.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);
    INC_MDN_TOKEN_RESULT: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    INC_MDN_VISIT_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(INC_MDN.PRecord.setProp, TINC_MDNItem.TPropertyIndex(ACol));
    if INC_MDN.PRecord.setProp = [] then
    begin
      Dispose(INC_MDN.PRecord);
      INC_MDN.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(INC_MDN.PRecord.setProp, TINC_MDNItem.TPropertyIndex(ACol));
  case TINC_MDNItem.TPropertyIndex(ACol) of
    INC_MDN_ACCOUNT_ID: INC_MDN.PRecord.ACCOUNT_ID := StrToInt(AValue);
    INC_MDN_AMBJOURNALN: INC_MDN.PRecord.AMBJOURNALN := StrToInt(AValue);
    INC_MDN_AMBJOURNALN_PAYED: INC_MDN.PRecord.AMBJOURNALN_PAYED := StrToInt(AValue);
    INC_MDN_AMBLISTN: INC_MDN.PRecord.AMBLISTN := StrToInt(AValue);
    INC_MDN_AMB_NRN: INC_MDN.PRecord.AMB_NRN := AValue;
    INC_MDN_ASSIGMENT_TIME: INC_MDN.PRecord.ASSIGMENT_TIME := StrToTime(AValue);
    INC_MDN_DATA: INC_MDN.PRecord.DATA := StrToDate(AValue);
    INC_MDN_DATE_EXECUTION: INC_MDN.PRecord.DATE_EXECUTION := StrToDate(AValue);
    INC_MDN_DATE_PROBOVZEMANE: INC_MDN.PRecord.DATE_PROBOVZEMANE := StrToDate(AValue);
    INC_MDN_DESCRIPTION: INC_MDN.PRecord.DESCRIPTION := AValue;
    INC_MDN_EXECUTION_TIME: INC_MDN.PRecord.EXECUTION_TIME := StrToTime(AValue);
    INC_MDN_FUND_ID: INC_MDN.PRecord.FUND_ID := StrToInt(AValue);
    INC_MDN_ID: INC_MDN.PRecord.ID := StrToInt(AValue);
    INC_MDN_NOMERBELEGKA: INC_MDN.PRecord.NOMERBELEGKA := AValue;
    INC_MDN_NOMERKASHAPARAT: INC_MDN.PRecord.NOMERKASHAPARAT := AValue;
    INC_MDN_NRN: INC_MDN.PRecord.NRN := AValue;
    INC_MDN_NUMBER: INC_MDN.PRecord.NUMBER := StrToInt(AValue);
    INC_MDN_NZOK_NOMER: INC_MDN.PRecord.NZOK_NOMER := AValue;
    INC_MDN_PACKAGE: INC_MDN.PRecord.PACKAGE := StrToInt(AValue);
    INC_MDN_PASS: INC_MDN.PRecord.PASS := AValue;
    INC_MDN_SEND_MAIL_DATE: INC_MDN.PRecord.SEND_MAIL_DATE := StrToDate(AValue);
    INC_MDN_THREAD_IDS: INC_MDN.PRecord.THREAD_IDS := AValue;
    INC_MDN_TIME_PROBOVZEMANE: INC_MDN.PRecord.TIME_PROBOVZEMANE := StrToTime(AValue);
    INC_MDN_TOKEN_RESULT: INC_MDN.PRecord.TOKEN_RESULT := AValue;
    INC_MDN_VISIT_ID: INC_MDN.PRecord.VISIT_ID := StrToInt(AValue);
    INC_MDN_Logical: INC_MDN.PRecord.Logical := tlogicalINC_MDNSet(INC_MDN.StrToLogical48(AValue));
  end;
end;

procedure TINC_MDNColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  INC_MDN: TINC_MDNItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  INC_MDN := Items[ARow];
  if not Assigned(INC_MDN.PRecord) then
  begin
    New(INC_MDN.PRecord);
    INC_MDN.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TINC_MDNItem.TPropertyIndex(ACol) of
      INC_MDN_ACCOUNT_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_AMBJOURNALN: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_AMBJOURNALN_PAYED: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_AMBLISTN: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_AMB_NRN: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_ASSIGMENT_TIME: isOld :=  INC_MDN.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AFieldText);
    INC_MDN_DATA: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    INC_MDN_DATE_EXECUTION: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    INC_MDN_DATE_PROBOVZEMANE: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    INC_MDN_DESCRIPTION: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_EXECUTION_TIME: isOld :=  INC_MDN.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AFieldText);
    INC_MDN_FUND_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_NOMERBELEGKA: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_NOMERKASHAPARAT: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_NRN: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_NUMBER: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_NZOK_NOMER: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_PACKAGE: isOld :=  INC_MDN.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    INC_MDN_PASS: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_SEND_MAIL_DATE: isOld :=  INC_MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    INC_MDN_THREAD_IDS: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_TIME_PROBOVZEMANE: isOld :=  INC_MDN.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AFieldText);
    INC_MDN_TOKEN_RESULT: isOld :=  INC_MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    INC_MDN_VISIT_ID: isOld :=  INC_MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(INC_MDN.PRecord.setProp, TINC_MDNItem.TPropertyIndex(ACol));
    if INC_MDN.PRecord.setProp = [] then
    begin
      Dispose(INC_MDN.PRecord);
      INC_MDN.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(INC_MDN.PRecord.setProp, TINC_MDNItem.TPropertyIndex(ACol));
  case TINC_MDNItem.TPropertyIndex(ACol) of
    INC_MDN_ACCOUNT_ID: INC_MDN.PRecord.ACCOUNT_ID := StrToInt(AFieldText);
    INC_MDN_AMBJOURNALN: INC_MDN.PRecord.AMBJOURNALN := StrToInt(AFieldText);
    INC_MDN_AMBJOURNALN_PAYED: INC_MDN.PRecord.AMBJOURNALN_PAYED := StrToInt(AFieldText);
    INC_MDN_AMBLISTN: INC_MDN.PRecord.AMBLISTN := StrToInt(AFieldText);
    INC_MDN_AMB_NRN: INC_MDN.PRecord.AMB_NRN := AFieldText;
    INC_MDN_ASSIGMENT_TIME: INC_MDN.PRecord.ASSIGMENT_TIME := StrToTime(AFieldText);
    INC_MDN_DATA: INC_MDN.PRecord.DATA := StrToDate(AFieldText);
    INC_MDN_DATE_EXECUTION: INC_MDN.PRecord.DATE_EXECUTION := StrToDate(AFieldText);
    INC_MDN_DATE_PROBOVZEMANE: INC_MDN.PRecord.DATE_PROBOVZEMANE := StrToDate(AFieldText);
    INC_MDN_DESCRIPTION: INC_MDN.PRecord.DESCRIPTION := AFieldText;
    INC_MDN_EXECUTION_TIME: INC_MDN.PRecord.EXECUTION_TIME := StrToTime(AFieldText);
    INC_MDN_FUND_ID: INC_MDN.PRecord.FUND_ID := StrToInt(AFieldText);
    INC_MDN_ID: INC_MDN.PRecord.ID := StrToInt(AFieldText);
    INC_MDN_NOMERBELEGKA: INC_MDN.PRecord.NOMERBELEGKA := AFieldText;
    INC_MDN_NOMERKASHAPARAT: INC_MDN.PRecord.NOMERKASHAPARAT := AFieldText;
    INC_MDN_NRN: INC_MDN.PRecord.NRN := AFieldText;
    INC_MDN_NUMBER: INC_MDN.PRecord.NUMBER := StrToInt(AFieldText);
    INC_MDN_NZOK_NOMER: INC_MDN.PRecord.NZOK_NOMER := AFieldText;
    INC_MDN_PACKAGE: INC_MDN.PRecord.PACKAGE := StrToInt(AFieldText);
    INC_MDN_PASS: INC_MDN.PRecord.PASS := AFieldText;
    INC_MDN_SEND_MAIL_DATE: INC_MDN.PRecord.SEND_MAIL_DATE := StrToDate(AFieldText);
    INC_MDN_THREAD_IDS: INC_MDN.PRecord.THREAD_IDS := AFieldText;
    INC_MDN_TIME_PROBOVZEMANE: INC_MDN.PRecord.TIME_PROBOVZEMANE := StrToTime(AFieldText);
    INC_MDN_TOKEN_RESULT: INC_MDN.PRecord.TOKEN_RESULT := AFieldText;
    INC_MDN_VISIT_ID: INC_MDN.PRecord.VISIT_ID := StrToInt(AFieldText);
    INC_MDN_Logical: INC_MDN.PRecord.Logical := tlogicalINC_MDNSet(INC_MDN.StrToLogical48(AFieldText));
  end;
end;

procedure TINC_MDNColl.SetItem(Index: Integer; const Value: TINC_MDNItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TINC_MDNColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListINC_MDNSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TINC_MDNItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  INC_MDN_ACCOUNT_ID: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListINC_MDNSearch.Add(self.Items[i]);
  end;
end;
      INC_MDN_AMBJOURNALN: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_AMBJOURNALN_PAYED: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_AMBLISTN: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_AMB_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_DESCRIPTION:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_FUND_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_NOMERBELEGKA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_NOMERKASHAPARAT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_NZOK_NOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_PACKAGE: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_PASS:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_THREAD_IDS:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_TOKEN_RESULT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
      INC_MDN_VISIT_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListINC_MDNSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TINC_MDNColl.ShowGrid(Grid: TTeeGrid);
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

procedure TINC_MDNColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TINC_MDNItem>);
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

procedure TINC_MDNColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListINC_MDNSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListINC_MDNSearch.Count]);

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

procedure TINC_MDNColl.SortByIndexAnsiString;
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

procedure TINC_MDNColl.SortByIndexInt;
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

procedure TINC_MDNColl.SortByIndexWord;
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

procedure TINC_MDNColl.SortByIndexValue(propIndex: TINC_MDNItem.TPropertyIndex);
begin
  case propIndex of
    INC_MDN_ACCOUNT_ID: SortByIndexInt;
      INC_MDN_AMBJOURNALN: SortByIndexInt;
      INC_MDN_AMBJOURNALN_PAYED: SortByIndexInt;
      INC_MDN_AMBLISTN: SortByIndexInt;
      INC_MDN_AMB_NRN: SortByIndexAnsiString;
      INC_MDN_DESCRIPTION: SortByIndexAnsiString;
      INC_MDN_FUND_ID: SortByIndexInt;
      INC_MDN_ID: SortByIndexInt;
      INC_MDN_NOMERBELEGKA: SortByIndexAnsiString;
      INC_MDN_NOMERKASHAPARAT: SortByIndexAnsiString;
      INC_MDN_NRN: SortByIndexAnsiString;
      INC_MDN_NUMBER: SortByIndexInt;
      INC_MDN_NZOK_NOMER: SortByIndexAnsiString;
      INC_MDN_PACKAGE: SortByIndexWord;
      INC_MDN_PASS: SortByIndexAnsiString;
      INC_MDN_THREAD_IDS: SortByIndexAnsiString;
      INC_MDN_TOKEN_RESULT: SortByIndexAnsiString;
      INC_MDN_VISIT_ID: SortByIndexInt;
  end;
end;

end.