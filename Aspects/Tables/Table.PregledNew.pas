unit Table.PregledNew;    //datapos

interface
uses
  Aspects.Collections, Aspects.Types, Vcl.Dialogs,
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

TLogicalPregledNew = (
    INCIDENTALLY,
    IS_ANALYSIS,
    IS_BABY_CARE,
    IS_CONSULTATION,
    IS_DISPANSERY,
    IS_EMERGENCY,
    IS_EPIKRIZA,
    IS_EXPERTIZA,
    IS_FORM_VALID,
    IS_HOSPITALIZATION,
    IS_MANIPULATION,
    IS_MEDBELEJKA,
    IS_NAET,
    IS_NAPR_TELK,
    IS_NEW,
    IS_NOTIFICATION,
    IS_NO_DELAY,
    IS_OPERATION,
    IS_PODVIZHNO_LZ,
    IS_PREVENTIVE,
    IS_PRINTED,
    IS_RECEPTA_HOSPIT,
    IS_REGISTRATION,
    IS_REHABILITATION,
    IS_RISK_GROUP,
    IS_TELK,
    IS_VSD,
    IS_ZAMESTVASHT,
    IS_PRIMARY,
    IS_AMB_PR,
    IS_DOM_PR,
    PAY,
    TO_BE_DISPANSERED,
    IS_PREVENTIVE_Maternal,
    IS_PREVENTIVE_Childrens,
    IS_PREVENTIVE_Adults,
    IS_Screening);
TlogicalPregledNewSet = set of TLogicalPregledNew;


TPregledNewItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       PregledNew_AMB_LISTN
       , PregledNew_ANAMN
       , PregledNew_COPIED_FROM_NRN
       , PregledNew_GS
       , PregledNew_ID
       , PregledNew_IZSL
       , PregledNew_MEDTRANSKM
       , PregledNew_NAPRAVLENIE_AMBL_NOMER
       , PregledNew_NAPR_TYPE_ID
       , PregledNew_NOMERBELEGKA
       , PregledNew_NOMERKASHAPARAT
       , PregledNew_NRD
       , PregledNew_NRN_LRN
       , PregledNew_NZIS_STATUS
       , PregledNew_OBSHTAPR
       , PregledNew_PATIENTOF_NEOTL
       , PregledNew_PATIENTOF_NEOTLID
       , PregledNew_PREVENTIVE_TYPE
       , PregledNew_REH_FINISHED_AT
       , PregledNew_START_DATE
       , PregledNew_START_TIME
       , PregledNew_SYST
       , PregledNew_TALON_LKK
       , PregledNew_TERAPY
       , PregledNew_THREAD_IDS
       , PregledNew_VISIT_ID
       , PregledNew_VISIT_TYPE_ID
       , PregledNew_VSD_TYPE
       , PregledNew_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecPregledNew = ^TRecPregledNew;
      TRecPregledNew = record
        AMB_LISTN: integer;
        ANAMN: AnsiString;
        COPIED_FROM_NRN: AnsiString;
        GS: word;
        ID: integer;
        IZSL: AnsiString;
        MEDTRANSKM: integer;
        NAPRAVLENIE_AMBL_NOMER: AnsiString;
        NAPR_TYPE_ID: word;
        NOMERBELEGKA: AnsiString;
        NOMERKASHAPARAT: AnsiString;
        NRD: word;
        NRN_LRN: AnsiString;
        NZIS_STATUS: word;
        OBSHTAPR: word;
        PATIENTOF_NEOTL: AnsiString;
        PATIENTOF_NEOTLID: integer;
        PREVENTIVE_TYPE: word;
        REH_FINISHED_AT: TDate;
        START_DATE: TDate;
        START_TIME: TTime;
        SYST: AnsiString;
        TALON_LKK: AnsiString;
        TERAPY: AnsiString;
        THREAD_IDS: AnsiString;
        VISIT_ID: integer;
        VISIT_TYPE_ID: word;
        VSD_TYPE: word;
        Logical: TlogicalPregledNewSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPregledNew;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPregledNew;
    procedure UpdatePregledNew;
    procedure SavePregledNew(var dataPosition: Cardinal)overload;
	procedure SavePregledNew(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TPregledNewColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TPregledNewItem;
    function GetItem(Index: Integer): TPregledNewItem;
    procedure SetItem(Index: Integer; const Value: TPregledNewItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TPregledNewItem>;
    ListPregledNewSearch: TList<TPregledNewItem>;
	PRecordSearch: ^TPregledNewItem.TRecPregledNew;
    ArrPropSearch: TArray<TPregledNewItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TPregledNewItem.TPropertyIndex>;
	ArrayPropOrder: TArray<TPregledNewItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPregledNewItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; PregledNew: TPregledNewItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PregledNew: TPregledNewItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TPregledNewItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TPregledNewItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPregledNewItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TPregledNewItem.TPropertyIndex);
    property Items[Index: Integer]: TPregledNewItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchLog(Log: TlogicalPregledNewSet);
    procedure OnSetTextSearchDateEdt(date: TDate; field: Word; Condition: TConditionSet);
  end;

implementation

{ TPregledNewItem }

constructor TPregledNewItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPregledNewItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPregledNewItem.InsertPregledNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPregledNew;
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
            PregledNew_AMB_LISTN: SaveData(PRecord.AMB_LISTN, PropPosition, metaPosition, dataPosition);
            PregledNew_ANAMN: SaveData(PRecord.ANAMN, PropPosition, metaPosition, dataPosition);
            PregledNew_COPIED_FROM_NRN: SaveData(PRecord.COPIED_FROM_NRN, PropPosition, metaPosition, dataPosition);
            PregledNew_GS: SaveData(PRecord.GS, PropPosition, metaPosition, dataPosition);
            PregledNew_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PregledNew_IZSL: SaveData(PRecord.IZSL, PropPosition, metaPosition, dataPosition);
            PregledNew_MEDTRANSKM: SaveData(PRecord.MEDTRANSKM, PropPosition, metaPosition, dataPosition);
            PregledNew_NAPRAVLENIE_AMBL_NOMER: SaveData(PRecord.NAPRAVLENIE_AMBL_NOMER, PropPosition, metaPosition, dataPosition);
            PregledNew_NAPR_TYPE_ID: SaveData(PRecord.NAPR_TYPE_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_NOMERBELEGKA: SaveData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            PregledNew_NOMERKASHAPARAT: SaveData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            PregledNew_NRD: SaveData(PRecord.NRD, PropPosition, metaPosition, dataPosition);
            PregledNew_NRN_LRN: SaveData(PRecord.NRN_LRN, PropPosition, metaPosition, dataPosition);
            PregledNew_NZIS_STATUS: SaveData(PRecord.NZIS_STATUS, PropPosition, metaPosition, dataPosition);
            PregledNew_OBSHTAPR: SaveData(PRecord.OBSHTAPR, PropPosition, metaPosition, dataPosition);
            PregledNew_PATIENTOF_NEOTL: SaveData(PRecord.PATIENTOF_NEOTL, PropPosition, metaPosition, dataPosition);
            PregledNew_PATIENTOF_NEOTLID: SaveData(PRecord.PATIENTOF_NEOTLID, PropPosition, metaPosition, dataPosition);
            PregledNew_PREVENTIVE_TYPE: SaveData(PRecord.PREVENTIVE_TYPE, PropPosition, metaPosition, dataPosition);
            PregledNew_REH_FINISHED_AT: SaveData(PRecord.REH_FINISHED_AT, PropPosition, metaPosition, dataPosition);
            PregledNew_START_DATE: SaveData(PRecord.START_DATE, PropPosition, metaPosition, dataPosition);
            PregledNew_START_TIME: SaveData(PRecord.START_TIME, PropPosition, metaPosition, dataPosition);
            PregledNew_SYST: SaveData(PRecord.SYST, PropPosition, metaPosition, dataPosition);
            PregledNew_TALON_LKK: SaveData(PRecord.TALON_LKK, PropPosition, metaPosition, dataPosition);
            PregledNew_TERAPY: SaveData(PRecord.TERAPY, PropPosition, metaPosition, dataPosition);
            PregledNew_THREAD_IDS: SaveData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            PregledNew_VISIT_ID: SaveData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_VISIT_TYPE_ID: SaveData(PRecord.VISIT_TYPE_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_VSD_TYPE: SaveData(PRecord.VSD_TYPE, PropPosition, metaPosition, dataPosition);
            PregledNew_Logical: SaveData(TLogicalData40(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TPregledNewItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TPregledNewItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TPregledNewItem;
begin
  Result := True;
  for i := 0 to Length(TPregledNewColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TPregledNewColl(coll).ArrPropSearchClc[i];
   	ATempItem := TPregledNewColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        PregledNew_AMB_LISTN: Result := IsFinded(ATempItem.PRecord.AMB_LISTN, buf, FPosDataADB, word(PregledNew_AMB_LISTN), cot);
            PregledNew_ANAMN: Result := IsFinded(ATempItem.PRecord.ANAMN, buf, FPosDataADB, word(PregledNew_ANAMN), cot);
            PregledNew_COPIED_FROM_NRN: Result := IsFinded(ATempItem.PRecord.COPIED_FROM_NRN, buf, FPosDataADB, word(PregledNew_COPIED_FROM_NRN), cot);
            PregledNew_GS: Result := IsFinded(ATempItem.PRecord.GS, buf, FPosDataADB, word(PregledNew_GS), cot);
            PregledNew_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(PregledNew_ID), cot);
            PregledNew_IZSL: Result := IsFinded(ATempItem.PRecord.IZSL, buf, FPosDataADB, word(PregledNew_IZSL), cot);
            PregledNew_MEDTRANSKM: Result := IsFinded(ATempItem.PRecord.MEDTRANSKM, buf, FPosDataADB, word(PregledNew_MEDTRANSKM), cot);
            PregledNew_NAPRAVLENIE_AMBL_NOMER: Result := IsFinded(ATempItem.PRecord.NAPRAVLENIE_AMBL_NOMER, buf, FPosDataADB, word(PregledNew_NAPRAVLENIE_AMBL_NOMER), cot);
            PregledNew_NAPR_TYPE_ID: Result := IsFinded(ATempItem.PRecord.NAPR_TYPE_ID, buf, FPosDataADB, word(PregledNew_NAPR_TYPE_ID), cot);
            PregledNew_NOMERBELEGKA: Result := IsFinded(ATempItem.PRecord.NOMERBELEGKA, buf, FPosDataADB, word(PregledNew_NOMERBELEGKA), cot);
            PregledNew_NOMERKASHAPARAT: Result := IsFinded(ATempItem.PRecord.NOMERKASHAPARAT, buf, FPosDataADB, word(PregledNew_NOMERKASHAPARAT), cot);
            PregledNew_NRD: Result := IsFinded(ATempItem.PRecord.NRD, buf, FPosDataADB, word(PregledNew_NRD), cot);
            PregledNew_NRN_LRN: Result := IsFinded(ATempItem.PRecord.NRN_LRN, buf, FPosDataADB, word(PregledNew_NRN_LRN), cot);
            PregledNew_NZIS_STATUS: Result := IsFinded(ATempItem.PRecord.NZIS_STATUS, buf, FPosDataADB, word(PregledNew_NZIS_STATUS), cot);
            PregledNew_OBSHTAPR: Result := IsFinded(ATempItem.PRecord.OBSHTAPR, buf, FPosDataADB, word(PregledNew_OBSHTAPR), cot);
            PregledNew_PATIENTOF_NEOTL: Result := IsFinded(ATempItem.PRecord.PATIENTOF_NEOTL, buf, FPosDataADB, word(PregledNew_PATIENTOF_NEOTL), cot);
            PregledNew_PATIENTOF_NEOTLID: Result := IsFinded(ATempItem.PRecord.PATIENTOF_NEOTLID, buf, FPosDataADB, word(PregledNew_PATIENTOF_NEOTLID), cot);
            PregledNew_PREVENTIVE_TYPE: Result := IsFinded(ATempItem.PRecord.PREVENTIVE_TYPE, buf, FPosDataADB, word(PregledNew_PREVENTIVE_TYPE), cot);
            PregledNew_REH_FINISHED_AT: Result := IsFinded(ATempItem.PRecord.REH_FINISHED_AT, buf, FPosDataADB, word(PregledNew_REH_FINISHED_AT), cot);
            PregledNew_START_DATE: Result := IsFinded(ATempItem.PRecord.START_DATE, buf, FPosDataADB, word(PregledNew_START_DATE), cot);
            PregledNew_START_TIME: Result := IsFinded(ATempItem.PRecord.START_TIME, buf, FPosDataADB, word(PregledNew_START_TIME), cot);
            PregledNew_SYST: Result := IsFinded(ATempItem.PRecord.SYST, buf, FPosDataADB, word(PregledNew_SYST), cot);
            PregledNew_TALON_LKK: Result := IsFinded(ATempItem.PRecord.TALON_LKK, buf, FPosDataADB, word(PregledNew_TALON_LKK), cot);
            PregledNew_TERAPY: Result := IsFinded(ATempItem.PRecord.TERAPY, buf, FPosDataADB, word(PregledNew_TERAPY), cot);
            PregledNew_THREAD_IDS: Result := IsFinded(ATempItem.PRecord.THREAD_IDS, buf, FPosDataADB, word(PregledNew_THREAD_IDS), cot);
            PregledNew_VISIT_ID: Result := IsFinded(ATempItem.PRecord.VISIT_ID, buf, FPosDataADB, word(PregledNew_VISIT_ID), cot);
            PregledNew_VISIT_TYPE_ID: Result := IsFinded(ATempItem.PRecord.VISIT_TYPE_ID, buf, FPosDataADB, word(PregledNew_VISIT_TYPE_ID), cot);
            PregledNew_VSD_TYPE: Result := IsFinded(ATempItem.PRecord.VSD_TYPE, buf, FPosDataADB, word(PregledNew_VSD_TYPE), cot);
            PregledNew_Logical: Result := IsFinded(TLogicalData40(ATempItem.PRecord.Logical), buf, FPosDataADB, word(PregledNew_Logical), cot);
      end;
    end;
  end;
end;

procedure TPregledNewItem.SavePregledNew(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SavePregledNew(dataPosition);
end;

procedure TPregledNewItem.SavePregledNew(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPregledNew;
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
            PregledNew_AMB_LISTN: SaveData(PRecord.AMB_LISTN, PropPosition, metaPosition, dataPosition);
            PregledNew_ANAMN: SaveData(PRecord.ANAMN, PropPosition, metaPosition, dataPosition);
            PregledNew_COPIED_FROM_NRN: SaveData(PRecord.COPIED_FROM_NRN, PropPosition, metaPosition, dataPosition);
            PregledNew_GS: SaveData(PRecord.GS, PropPosition, metaPosition, dataPosition);
            PregledNew_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PregledNew_IZSL: SaveData(PRecord.IZSL, PropPosition, metaPosition, dataPosition);
            PregledNew_MEDTRANSKM: SaveData(PRecord.MEDTRANSKM, PropPosition, metaPosition, dataPosition);
            PregledNew_NAPRAVLENIE_AMBL_NOMER: SaveData(PRecord.NAPRAVLENIE_AMBL_NOMER, PropPosition, metaPosition, dataPosition);
            PregledNew_NAPR_TYPE_ID: SaveData(PRecord.NAPR_TYPE_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_NOMERBELEGKA: SaveData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            PregledNew_NOMERKASHAPARAT: SaveData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            PregledNew_NRD: SaveData(PRecord.NRD, PropPosition, metaPosition, dataPosition);
            PregledNew_NRN_LRN: SaveData(PRecord.NRN_LRN, PropPosition, metaPosition, dataPosition);
            PregledNew_NZIS_STATUS: SaveData(PRecord.NZIS_STATUS, PropPosition, metaPosition, dataPosition);
            PregledNew_OBSHTAPR: SaveData(PRecord.OBSHTAPR, PropPosition, metaPosition, dataPosition);
            PregledNew_PATIENTOF_NEOTL: SaveData(PRecord.PATIENTOF_NEOTL, PropPosition, metaPosition, dataPosition);
            PregledNew_PATIENTOF_NEOTLID: SaveData(PRecord.PATIENTOF_NEOTLID, PropPosition, metaPosition, dataPosition);
            PregledNew_PREVENTIVE_TYPE: SaveData(PRecord.PREVENTIVE_TYPE, PropPosition, metaPosition, dataPosition);
            PregledNew_REH_FINISHED_AT: SaveData(PRecord.REH_FINISHED_AT, PropPosition, metaPosition, dataPosition);
            PregledNew_START_DATE: SaveData(PRecord.START_DATE, PropPosition, metaPosition, dataPosition);
            PregledNew_START_TIME: SaveData(PRecord.START_TIME, PropPosition, metaPosition, dataPosition);
            PregledNew_SYST: SaveData(PRecord.SYST, PropPosition, metaPosition, dataPosition);
            PregledNew_TALON_LKK: SaveData(PRecord.TALON_LKK, PropPosition, metaPosition, dataPosition);
            PregledNew_TERAPY: SaveData(PRecord.TERAPY, PropPosition, metaPosition, dataPosition);
            PregledNew_THREAD_IDS: SaveData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            PregledNew_VISIT_ID: SaveData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_VISIT_TYPE_ID: SaveData(PRecord.VISIT_TYPE_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_VSD_TYPE: SaveData(PRecord.VSD_TYPE, PropPosition, metaPosition, dataPosition);
            PregledNew_Logical: SaveData(TLogicalData40(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TPregledNewItem.UpdatePregledNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPregledNew;
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
            PregledNew_AMB_LISTN: UpdateData(PRecord.AMB_LISTN, PropPosition, metaPosition, dataPosition);
            PregledNew_ANAMN: UpdateData(PRecord.ANAMN, PropPosition, metaPosition, dataPosition);
            PregledNew_COPIED_FROM_NRN: UpdateData(PRecord.COPIED_FROM_NRN, PropPosition, metaPosition, dataPosition);
            PregledNew_GS: UpdateData(PRecord.GS, PropPosition, metaPosition, dataPosition);
            PregledNew_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PregledNew_IZSL: UpdateData(PRecord.IZSL, PropPosition, metaPosition, dataPosition);
            PregledNew_MEDTRANSKM: UpdateData(PRecord.MEDTRANSKM, PropPosition, metaPosition, dataPosition);
            PregledNew_NAPRAVLENIE_AMBL_NOMER: UpdateData(PRecord.NAPRAVLENIE_AMBL_NOMER, PropPosition, metaPosition, dataPosition);
            PregledNew_NAPR_TYPE_ID: UpdateData(PRecord.NAPR_TYPE_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_NOMERBELEGKA: UpdateData(PRecord.NOMERBELEGKA, PropPosition, metaPosition, dataPosition);
            PregledNew_NOMERKASHAPARAT: UpdateData(PRecord.NOMERKASHAPARAT, PropPosition, metaPosition, dataPosition);
            PregledNew_NRD: UpdateData(PRecord.NRD, PropPosition, metaPosition, dataPosition);
            PregledNew_NRN_LRN: UpdateData(PRecord.NRN_LRN, PropPosition, metaPosition, dataPosition);
            PregledNew_NZIS_STATUS: UpdateData(PRecord.NZIS_STATUS, PropPosition, metaPosition, dataPosition);
            PregledNew_OBSHTAPR: UpdateData(PRecord.OBSHTAPR, PropPosition, metaPosition, dataPosition);
            PregledNew_PATIENTOF_NEOTL: UpdateData(PRecord.PATIENTOF_NEOTL, PropPosition, metaPosition, dataPosition);
            PregledNew_PATIENTOF_NEOTLID: UpdateData(PRecord.PATIENTOF_NEOTLID, PropPosition, metaPosition, dataPosition);
            PregledNew_PREVENTIVE_TYPE: UpdateData(PRecord.PREVENTIVE_TYPE, PropPosition, metaPosition, dataPosition);
            PregledNew_REH_FINISHED_AT: UpdateData(PRecord.REH_FINISHED_AT, PropPosition, metaPosition, dataPosition);
            PregledNew_START_DATE: UpdateData(PRecord.START_DATE, PropPosition, metaPosition, dataPosition);
            PregledNew_START_TIME: UpdateData(PRecord.START_TIME, PropPosition, metaPosition, dataPosition);
            PregledNew_SYST: UpdateData(PRecord.SYST, PropPosition, metaPosition, dataPosition);
            PregledNew_TALON_LKK: UpdateData(PRecord.TALON_LKK, PropPosition, metaPosition, dataPosition);
            PregledNew_TERAPY: UpdateData(PRecord.TERAPY, PropPosition, metaPosition, dataPosition);
            PregledNew_THREAD_IDS: UpdateData(PRecord.THREAD_IDS, PropPosition, metaPosition, dataPosition);
            PregledNew_VISIT_ID: UpdateData(PRecord.VISIT_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_VISIT_TYPE_ID: UpdateData(PRecord.VISIT_TYPE_ID, PropPosition, metaPosition, dataPosition);
            PregledNew_VSD_TYPE: UpdateData(PRecord.VSD_TYPE, PropPosition, metaPosition, dataPosition);
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

{ TPregledNewColl }

function TPregledNewColl.AddItem(ver: word): TPregledNewItem;
begin
  Result := TPregledNewItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TPregledNewColl.AddItemForSearch: Integer;
var
  ItemForSearch: TPregledNewItem;
begin
  ItemForSearch := TPregledNewItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

function TPregledNewColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvPregledRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

constructor TPregledNewColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TPregledNewItem.Create(nil);
  ListPregledNewSearch := TList<TPregledNewItem>.Create;
  ListForFinder := TList<TPregledNewItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrder, FieldCount);
  SetLength(ArrayPropOrderSearchOptions, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrayPropOrder[i] := TPregledNewItem.TPropertyIndex(i);
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TPregledNewColl.destroy;
begin
  FreeAndNil(ListPregledNewSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  //ArrayPropOrderSearchOptions.Free;
  //ArrayPropOrder.free;
  inherited;
end;

function TPregledNewColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TPregledNewItem.TPropertyIndex(propIndex) of
    PregledNew_AMB_LISTN: Result := 'AMB_LISTN';
    PregledNew_ANAMN: Result := 'Анамнеза';
    PregledNew_COPIED_FROM_NRN: Result := 'COPIED_FROM_NRN';
    PregledNew_GS: Result := 'GS';
    PregledNew_ID: Result := 'ID';
    PregledNew_IZSL: Result := 'IZSL';
    PregledNew_MEDTRANSKM: Result := 'MEDTRANSKM';
    PregledNew_NAPRAVLENIE_AMBL_NOMER: Result := 'NAPRAVLENIE_AMBL_NOMER';
    PregledNew_NAPR_TYPE_ID: Result := 'NAPR_TYPE_ID';
    PregledNew_NOMERBELEGKA: Result := 'NOMERBELEGKA';
    PregledNew_NOMERKASHAPARAT: Result := 'NOMERKASHAPARAT';
    PregledNew_NRD: Result := 'NRD';
    PregledNew_NRN_LRN: Result := 'NRN_LRN';
    PregledNew_NZIS_STATUS: Result := 'NZIS_STATUS';
    PregledNew_OBSHTAPR: Result := 'OBSHTAPR';
    PregledNew_PATIENTOF_NEOTL: Result := 'PATIENTOF_NEOTL';
    PregledNew_PATIENTOF_NEOTLID: Result := 'PATIENTOF_NEOTLID';
    PregledNew_PREVENTIVE_TYPE: Result := 'PREVENTIVE_TYPE';
    PregledNew_REH_FINISHED_AT: Result := 'REH_FINISHED_AT';
    PregledNew_START_DATE: Result := 'START_DATE';
    PregledNew_START_TIME: Result := 'START_TIME';
    PregledNew_SYST: Result := 'SYST';
    PregledNew_TALON_LKK: Result := 'TALON_LKK';
    PregledNew_TERAPY: Result := 'TERAPY';
    PregledNew_THREAD_IDS: Result := 'THREAD_IDS';
    PregledNew_VISIT_ID: Result := 'VISIT_ID';
    PregledNew_VISIT_TYPE_ID: Result := 'VISIT_TYPE_ID';
    PregledNew_VSD_TYPE: Result := 'VSD_TYPE';
    PregledNew_Logical: Result := 'Logical';
  end;
end;

procedure TPregledNewColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TPregledNewColl.FieldCount: Integer; 
begin
  inherited;
  Result := 29;
end;

function TPregledNewColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvPregledRoot then
    begin
      Result := Run;
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
end;

function TPregledNewColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TPregledNewColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TPregledNewColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TPregledNewColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PregledNew: TPregledNewItem;
  ACol: Integer;
  prop: TPregledNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PregledNew := Items[ARow];
  prop := TPregledNewItem.TPropertyIndex(ACol);
  if Assigned(PregledNew.PRecord) and (prop in PregledNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PregledNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PregledNew, AValue);
  end;
end;

procedure TPregledNewColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol, RowSelect: Integer;
  prop: TPregledNewItem.TPropertyIndex;
begin
  inherited;
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;

  //TVirtualModeData(Sender).ColumnList[0].TagObject
  try
    ACol := TVirtualModeData(Sender).IndexOf(AColumn);
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;



  //prop := ArrayPropOrderSearchOptions[ACol];
  //prop := TPregledNewItem.TPropertyIndex(ACol);
  GetCellFromMap(ArrayPropOrderSearchOptions[ACol], RowSelect, TempItem, AValue);
end;

procedure TPregledNewColl.GetCellFromRecord(propIndex: word; PregledNew: TPregledNewItem; var AValue: String);
var
  str: string;
begin
  case TPregledNewItem.TPropertyIndex(propIndex) of
    PregledNew_AMB_LISTN: str := inttostr(PregledNew.PRecord.AMB_LISTN);
    PregledNew_ANAMN: str := (PregledNew.PRecord.ANAMN);
    PregledNew_COPIED_FROM_NRN: str := (PregledNew.PRecord.COPIED_FROM_NRN);
    PregledNew_GS: str := inttostr(PregledNew.PRecord.GS);
    PregledNew_ID: str := inttostr(PregledNew.PRecord.ID);
    PregledNew_IZSL: str := (PregledNew.PRecord.IZSL);
    PregledNew_MEDTRANSKM: str := inttostr(PregledNew.PRecord.MEDTRANSKM);
    PregledNew_NAPRAVLENIE_AMBL_NOMER: str := (PregledNew.PRecord.NAPRAVLENIE_AMBL_NOMER);
    PregledNew_NAPR_TYPE_ID: str := inttostr(PregledNew.PRecord.NAPR_TYPE_ID);
    PregledNew_NOMERBELEGKA: str := (PregledNew.PRecord.NOMERBELEGKA);
    PregledNew_NOMERKASHAPARAT: str := (PregledNew.PRecord.NOMERKASHAPARAT);
    PregledNew_NRD: str := inttostr(PregledNew.PRecord.NRD);
    PregledNew_NRN_LRN: str := (PregledNew.PRecord.NRN_LRN);
    PregledNew_NZIS_STATUS: str := inttostr(PregledNew.PRecord.NZIS_STATUS);
    PregledNew_OBSHTAPR: str := inttostr(PregledNew.PRecord.OBSHTAPR);
    PregledNew_PATIENTOF_NEOTL: str := (PregledNew.PRecord.PATIENTOF_NEOTL);
    PregledNew_PATIENTOF_NEOTLID: str := inttostr(PregledNew.PRecord.PATIENTOF_NEOTLID);
    PregledNew_PREVENTIVE_TYPE: str := inttostr(PregledNew.PRecord.PREVENTIVE_TYPE);
    PregledNew_REH_FINISHED_AT: str := DateToStr(PregledNew.PRecord.REH_FINISHED_AT);
    PregledNew_START_DATE: str := DateToStr(PregledNew.PRecord.START_DATE);
    PregledNew_START_TIME: str := TimeToStr(PregledNew.PRecord.START_TIME);
    PregledNew_SYST: str := (PregledNew.PRecord.SYST);
    PregledNew_TALON_LKK: str := (PregledNew.PRecord.TALON_LKK);
    PregledNew_TERAPY: str := (PregledNew.PRecord.TERAPY);
    PregledNew_THREAD_IDS: str := (PregledNew.PRecord.THREAD_IDS);
    PregledNew_VISIT_ID: str := inttostr(PregledNew.PRecord.VISIT_ID);
    PregledNew_VISIT_TYPE_ID: str := inttostr(PregledNew.PRecord.VISIT_TYPE_ID);
    PregledNew_VSD_TYPE: str := inttostr(PregledNew.PRecord.VSD_TYPE);
    PregledNew_Logical: str := PregledNew.Logical40ToStr(TLogicalData40(PregledNew.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPregledNewColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TPregledNewItem;
  ACol: Integer;
  prop: TPregledNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TPregledNewItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TPregledNewColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TPregledNewItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TPregledNewItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TPregledNewColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PregledNew: TPregledNewItem;
  ACol: Integer;
  prop: TPregledNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PregledNew := ListPregledNewSearch[ARow];
  prop := TPregledNewItem.TPropertyIndex(ACol);
  if Assigned(PregledNew.PRecord) and (prop in PregledNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PregledNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PregledNew, AValue);
  end;
end;

procedure TPregledNewColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PregledNew: TPregledNewItem;
  prop: TPregledNewItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PregledNew := Items[ARow];
  prop := TPregledNewItem.TPropertyIndex(ACol);
  if Assigned(PregledNew.PRecord) and (prop in PregledNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PregledNew, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PregledNew, AFieldText);
  end;
end;

procedure TPregledNewColl.GetCellFromMap(propIndex: word; ARow: Integer; PregledNew: TPregledNewItem; var AValue: String);
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
  case TPregledNewItem.TPropertyIndex(propIndex) of
    PregledNew_AMB_LISTN: str :=  inttostr(PregledNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PregledNew_ANAMN: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_COPIED_FROM_NRN: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_GS: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_ID: str :=  inttostr(PregledNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PregledNew_IZSL: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_MEDTRANSKM: str :=  inttostr(PregledNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PregledNew_NAPRAVLENIE_AMBL_NOMER: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_NAPR_TYPE_ID: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_NOMERBELEGKA: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_NOMERKASHAPARAT: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_NRD: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_NRN_LRN: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_NZIS_STATUS: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_OBSHTAPR: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_PATIENTOF_NEOTL: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_PATIENTOF_NEOTLID: str :=  inttostr(PregledNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PregledNew_PREVENTIVE_TYPE: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_REH_FINISHED_AT: str :=  DateToStr(PregledNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PregledNew_START_DATE: str :=  DateToStr(PregledNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PregledNew_START_TIME: str :=  TimeToStr(PregledNew.getTimeMap(Self.Buf, Self.posData, propIndex));
    PregledNew_SYST: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_TALON_LKK: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_TERAPY: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_THREAD_IDS: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PregledNew_VISIT_ID: str :=  inttostr(PregledNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PregledNew_VISIT_TYPE_ID: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_VSD_TYPE: str :=  inttostr(PregledNew.getWordMap(Self.Buf, Self.posData, propIndex));
    PregledNew_Logical: str :=  PregledNew.Logical40ToStr(PregledNew.getLogical40Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPregledNewColl.GetItem(Index: Integer): TPregledNewItem;
begin
  Result := TPregledNewItem(inherited GetItem(Index));
end;


procedure TPregledNewColl.IndexValue(propIndex: TPregledNewItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPregledNewItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PregledNew_AMB_LISTN: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_ANAMN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_COPIED_FROM_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_GS: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_IZSL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_MEDTRANSKM: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_NAPRAVLENIE_AMBL_NOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_NAPR_TYPE_ID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_NOMERBELEGKA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_NOMERKASHAPARAT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_NRD: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_NRN_LRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_NZIS_STATUS: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_OBSHTAPR: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_PATIENTOF_NEOTL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_PATIENTOF_NEOTLID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_PREVENTIVE_TYPE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_SYST:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_TALON_LKK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_TERAPY:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_THREAD_IDS:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PregledNew_VISIT_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_VISIT_TYPE_ID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      PregledNew_VSD_TYPE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TPregledNewColl.IndexValueListNodes(propIndex: TPregledNewItem.TPropertyIndex);
begin

end;
procedure TPregledNewColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TPregledNewItem;
begin
  if index < 0 then
  begin
    Tempitem := TPregledNewItem.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(field, -1, Tempitem, value);
    //value := Tempitem.getAnsiStringMap(Buf, posData, field);
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

procedure TPregledNewColl.OnSetTextSearchDateEdt(date: TDate; field: Word;
  Condition: TConditionSet);
begin
  if date = 0 then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TPregledNewItem.TPropertyIndex(Field));
  end
  else
  begin
    include(ListForFinder[0].PRecord.setProp, TPregledNewItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TPregledNewItem.TPropertyIndex(Field) of
    PregledNew_START_DATE: ListForFinder[0].PRecord.START_DATE  := date;
  end;
end;

procedure TPregledNewColl.OnSetTextSearchEDT(Text: string; field: Word;
  Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TPregledNewItem.TPropertyIndex(Field));
  end
  else
  begin
    if cotSens in Condition then
    begin
      AText := AnsiUpperCase(Text);
    end
    else
    begin
      AText := Text;
    end;
    include(ListForFinder[0].PRecord.setProp, TPregledNewItem.TPropertyIndex(Field));
    //ListForFinder[0].ArrCondition[Field] := [cotNotContain]; //  не му е тука мястото. само за тест е. трябва да се получава от финдера
  end;
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  case TPregledNewItem.TPropertyIndex(Field) of
    PregledNew_ANAMN: ListForFinder[0].PRecord.ANAMN  := AText;
    PregledNew_IZSL: ListForFinder[0].PRecord.IZSL  := AText;
    PregledNew_NRN_LRN: ListForFinder[0].PRecord.NRN_LRN  :=AText;
    //PregledNew_ID: ListForFinder[0].PRecord.ID  := Aext;
  end;
end;

procedure TPregledNewColl.OnSetTextSearchLog(Log: TlogicalPregledNewSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TPregledNewColl.OrderFieldsSearch(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  lstNode: TList<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  Comparison :=
    function(const Left, Right: PVirtualNode): Integer
    begin
      Result := Right.Dummy  - Left.Dummy;
    end;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  run := FieldCollOptionNode.FirstChild;
  lstNode := TList<PVirtualNode>.create;
  SetLength(ArrCol, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    ArrCol[i] := Grid.Columns[i+ 1];
  end;
  for i := 1 to Length(ArrCol) - 1 do
  begin
    index := TVirtualModeData(Grid.Data).IndexOf(ArrCol[i]);
    ArrCol[i].Header.Text := ArrCol[i].Header.Text  + ' ' + IntToStr(index);
    ArrCol[index].Index := run.Dummy ;
    run := run.NextSibling;
  end;
  //Grid.Columns.beginUpdate;
  while run <> nil do
  begin
    lstNode.Add(run);
    //index := TVirtualModeData(Grid.Data).IndexOf(Grid.Columns[run.index + 1]);
    //Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy);
    //TVirtualModeData(Grid.Data).IndexOf(Grid.Columns[run.index + 1]);
    //Grid.Columns[run.index].tag := run.Dummy + 1;
    //ArrayPropOrderSearchOptions[run.index] :=  run.Dummy;
    //Grid.Columns[index].Index:= run.Dummy + 1;
    run := run.NextSibling;
  end;
  //Grid.Columns.EndUpdate;
  //lstNode.Sort(TComparer<PVirtualNode>.Construct(Comparison));
//  for i := 1 to lstNode.Count - 1 do
//  begin
//    rank := lstNode[i].Dummy + 1;
//    index :=  lstNode[i].Index + 1;
//    Grid.Columns.Items[i].Index := rank;
//   // Grid.Columns[index].Index:= rank;
//  end;
  lstNode.Free;
  //Grid.Columns[5].Index:= 1;
  //Grid.Columns[2].Visible:= False;
//  Grid.Columns[6].Visible:= False;
//  Grid.Columns[0].Locked := TColumnLocked.Left;
//  Grid.Columns[1].Locked := TColumnLocked.Left;
//  Grid.Columns[2].Locked := TColumnLocked.Left;
end;

procedure TPregledNewColl.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  Exit;
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

function TPregledNewColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TPregledNewItem.TPropertyIndex(propIndex) of
    PregledNew_AMB_LISTN: Result := actinteger;
    PregledNew_ANAMN: Result := actAnsiString;
    PregledNew_COPIED_FROM_NRN: Result := actAnsiString;
    PregledNew_GS: Result := actword;
    PregledNew_ID: Result := actinteger;
    PregledNew_IZSL: Result := actAnsiString;
    PregledNew_MEDTRANSKM: Result := actinteger;
    PregledNew_NOMERBELEGKA: Result := actAnsiString;
    PregledNew_NOMERKASHAPARAT: Result := actAnsiString;
    PregledNew_NRD: Result := actword;
    PregledNew_NRN_LRN: Result := actAnsiString;
    PregledNew_NZIS_STATUS: Result := actword;
    PregledNew_OBSHTAPR: Result := actword;
    PregledNew_PATIENTOF_NEOTL: Result := actAnsiString;
    PregledNew_PATIENTOF_NEOTLID: Result := actinteger;
    PregledNew_PREVENTIVE_TYPE: Result := actword;
    PregledNew_START_DATE: Result := actTDate;
    PregledNew_START_TIME: Result := actTime;
    PregledNew_SYST: Result := actAnsiString;
    PregledNew_TALON_LKK: Result := actAnsiString;
    PregledNew_TERAPY: Result := actAnsiString;
    PregledNew_THREAD_IDS: Result := actAnsiString;
    PregledNew_VSD_TYPE: Result := actword;
    PregledNew_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TPregledNewColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TPregledNewColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PregledNew: TPregledNewItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  PregledNew := Items[ARow];
  if not Assigned(PregledNew.PRecord) then
  begin
    New(PregledNew.PRecord);
    PregledNew.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPregledNewItem.TPropertyIndex(ACol) of
      PregledNew_AMB_LISTN: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_ANAMN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_COPIED_FROM_NRN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_GS: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_ID: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_IZSL: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_MEDTRANSKM: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_NAPRAVLENIE_AMBL_NOMER: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_NAPR_TYPE_ID: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_NOMERBELEGKA: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_NOMERKASHAPARAT: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_NRD: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_NRN_LRN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_NZIS_STATUS: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_OBSHTAPR: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_PATIENTOF_NEOTL: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_PATIENTOF_NEOTLID: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_PREVENTIVE_TYPE: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_REH_FINISHED_AT: isOld :=  PregledNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PregledNew_START_DATE: isOld :=  PregledNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PregledNew_START_TIME: isOld :=  PregledNew.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);
    PregledNew_SYST: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_TALON_LKK: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_TERAPY: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_THREAD_IDS: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PregledNew_VISIT_ID: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_VISIT_TYPE_ID: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PregledNew_VSD_TYPE: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(PregledNew.PRecord.setProp, TPregledNewItem.TPropertyIndex(ACol));
    if PregledNew.PRecord.setProp = [] then
    begin
      Dispose(PregledNew.PRecord);
      PregledNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PregledNew.PRecord.setProp, TPregledNewItem.TPropertyIndex(ACol));
  case TPregledNewItem.TPropertyIndex(ACol) of
    PregledNew_AMB_LISTN: PregledNew.PRecord.AMB_LISTN := StrToInt(AValue);
    PregledNew_ANAMN: PregledNew.PRecord.ANAMN := AValue;
    PregledNew_COPIED_FROM_NRN: PregledNew.PRecord.COPIED_FROM_NRN := AValue;
    PregledNew_GS: PregledNew.PRecord.GS := StrToInt(AValue);
    PregledNew_ID: PregledNew.PRecord.ID := StrToInt(AValue);
    PregledNew_IZSL: PregledNew.PRecord.IZSL := AValue;
    PregledNew_MEDTRANSKM: PregledNew.PRecord.MEDTRANSKM := StrToInt(AValue);
    PregledNew_NAPRAVLENIE_AMBL_NOMER: PregledNew.PRecord.NAPRAVLENIE_AMBL_NOMER := AValue;
    PregledNew_NAPR_TYPE_ID: PregledNew.PRecord.NAPR_TYPE_ID := StrToInt(AValue);
    PregledNew_NOMERBELEGKA: PregledNew.PRecord.NOMERBELEGKA := AValue;
    PregledNew_NOMERKASHAPARAT: PregledNew.PRecord.NOMERKASHAPARAT := AValue;
    PregledNew_NRD: PregledNew.PRecord.NRD := StrToInt(AValue);
    PregledNew_NRN_LRN: PregledNew.PRecord.NRN_LRN := AValue;
    PregledNew_NZIS_STATUS: PregledNew.PRecord.NZIS_STATUS := StrToInt(AValue);
    PregledNew_OBSHTAPR: PregledNew.PRecord.OBSHTAPR := StrToInt(AValue);
    PregledNew_PATIENTOF_NEOTL: PregledNew.PRecord.PATIENTOF_NEOTL := AValue;
    PregledNew_PATIENTOF_NEOTLID: PregledNew.PRecord.PATIENTOF_NEOTLID := StrToInt(AValue);
    PregledNew_PREVENTIVE_TYPE: PregledNew.PRecord.PREVENTIVE_TYPE := StrToInt(AValue);
    PregledNew_REH_FINISHED_AT: PregledNew.PRecord.REH_FINISHED_AT := StrToDate(AValue);
    PregledNew_START_DATE: PregledNew.PRecord.START_DATE := StrToDate(AValue);
    PregledNew_START_TIME: PregledNew.PRecord.START_TIME := StrToTime(AValue);
    PregledNew_SYST: PregledNew.PRecord.SYST := AValue;
    PregledNew_TALON_LKK: PregledNew.PRecord.TALON_LKK := AValue;
    PregledNew_TERAPY: PregledNew.PRecord.TERAPY := AValue;
    PregledNew_THREAD_IDS: PregledNew.PRecord.THREAD_IDS := AValue;
    PregledNew_VISIT_ID: PregledNew.PRecord.VISIT_ID := StrToInt(AValue);
    PregledNew_VISIT_TYPE_ID: PregledNew.PRecord.VISIT_TYPE_ID := StrToInt(AValue);
    PregledNew_VSD_TYPE: PregledNew.PRecord.VSD_TYPE := StrToInt(AValue);
    PregledNew_Logical: PregledNew.PRecord.Logical := tlogicalPregledNewSet(PregledNew.StrToLogical40(AValue));
  end;
end;

procedure TPregledNewColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PregledNew: TPregledNewItem;
begin
  if Count = 0 then Exit;

  PregledNew := Items[ARow];
  if not Assigned(PregledNew.PRecord) then
  begin
    New(PregledNew.PRecord);
    PregledNew.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPregledNewItem.TPropertyIndex(ACol) of
      PregledNew_AMB_LISTN: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_ANAMN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_COPIED_FROM_NRN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_GS: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_ID: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_IZSL: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_MEDTRANSKM: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_NAPRAVLENIE_AMBL_NOMER: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_NAPR_TYPE_ID: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_NOMERBELEGKA: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_NOMERKASHAPARAT: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_NRD: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_NRN_LRN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_NZIS_STATUS: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_OBSHTAPR: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_PATIENTOF_NEOTL: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_PATIENTOF_NEOTLID: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_PREVENTIVE_TYPE: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_REH_FINISHED_AT: isOld :=  PregledNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PregledNew_START_DATE: isOld :=  PregledNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PregledNew_START_TIME: isOld :=  PregledNew.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AFieldText);
    PregledNew_SYST: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_TALON_LKK: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_TERAPY: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_THREAD_IDS: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PregledNew_VISIT_ID: isOld :=  PregledNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_VISIT_TYPE_ID: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PregledNew_VSD_TYPE: isOld :=  PregledNew.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(PregledNew.PRecord.setProp, TPregledNewItem.TPropertyIndex(ACol));
    if PregledNew.PRecord.setProp = [] then
    begin
      Dispose(PregledNew.PRecord);
      PregledNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PregledNew.PRecord.setProp, TPregledNewItem.TPropertyIndex(ACol));
  case TPregledNewItem.TPropertyIndex(ACol) of
    PregledNew_AMB_LISTN: PregledNew.PRecord.AMB_LISTN := StrToInt(AFieldText);
    PregledNew_ANAMN: PregledNew.PRecord.ANAMN := AFieldText;
    PregledNew_COPIED_FROM_NRN: PregledNew.PRecord.COPIED_FROM_NRN := AFieldText;
    PregledNew_GS: PregledNew.PRecord.GS := StrToInt(AFieldText);
    PregledNew_ID: PregledNew.PRecord.ID := StrToInt(AFieldText);
    PregledNew_IZSL: PregledNew.PRecord.IZSL := AFieldText;
    PregledNew_MEDTRANSKM: PregledNew.PRecord.MEDTRANSKM := StrToInt(AFieldText);
    PregledNew_NAPRAVLENIE_AMBL_NOMER: PregledNew.PRecord.NAPRAVLENIE_AMBL_NOMER := AFieldText;
    PregledNew_NAPR_TYPE_ID: PregledNew.PRecord.NAPR_TYPE_ID := StrToInt(AFieldText);
    PregledNew_NOMERBELEGKA: PregledNew.PRecord.NOMERBELEGKA := AFieldText;
    PregledNew_NOMERKASHAPARAT: PregledNew.PRecord.NOMERKASHAPARAT := AFieldText;
    PregledNew_NRD: PregledNew.PRecord.NRD := StrToInt(AFieldText);
    PregledNew_NRN_LRN: PregledNew.PRecord.NRN_LRN := AFieldText;
    PregledNew_NZIS_STATUS: PregledNew.PRecord.NZIS_STATUS := StrToInt(AFieldText);
    PregledNew_OBSHTAPR: PregledNew.PRecord.OBSHTAPR := StrToInt(AFieldText);
    PregledNew_PATIENTOF_NEOTL: PregledNew.PRecord.PATIENTOF_NEOTL := AFieldText;
    PregledNew_PATIENTOF_NEOTLID: PregledNew.PRecord.PATIENTOF_NEOTLID := StrToInt(AFieldText);
    PregledNew_PREVENTIVE_TYPE: PregledNew.PRecord.PREVENTIVE_TYPE := StrToInt(AFieldText);
    PregledNew_REH_FINISHED_AT: PregledNew.PRecord.REH_FINISHED_AT := StrToDate(AFieldText);
    PregledNew_START_DATE: PregledNew.PRecord.START_DATE := StrToDate(AFieldText);
    PregledNew_START_TIME: PregledNew.PRecord.START_TIME := StrToTime(AFieldText);
    PregledNew_SYST: PregledNew.PRecord.SYST := AFieldText;
    PregledNew_TALON_LKK: PregledNew.PRecord.TALON_LKK := AFieldText;
    PregledNew_TERAPY: PregledNew.PRecord.TERAPY := AFieldText;
    PregledNew_THREAD_IDS: PregledNew.PRecord.THREAD_IDS := AFieldText;
    PregledNew_VISIT_ID: PregledNew.PRecord.VISIT_ID := StrToInt(AFieldText);
    PregledNew_VISIT_TYPE_ID: PregledNew.PRecord.VISIT_TYPE_ID := StrToInt(AFieldText);
    PregledNew_VSD_TYPE: PregledNew.PRecord.VSD_TYPE := StrToInt(AFieldText);
    PregledNew_Logical: PregledNew.PRecord.Logical := tlogicalPregledNewSet(PregledNew.StrToLogical40(AFieldText));
  end;
end;

procedure TPregledNewColl.SetItem(Index: Integer; const Value: TPregledNewItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPregledNewColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPregledNewSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPregledNewItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  PregledNew_AMB_LISTN: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListPregledNewSearch.Add(self.Items[i]);
  end;
end;
      PregledNew_ANAMN:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_COPIED_FROM_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_GS: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_IZSL:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_MEDTRANSKM: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NAPRAVLENIE_AMBL_NOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NAPR_TYPE_ID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NOMERBELEGKA:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NOMERKASHAPARAT:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NRD: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NRN_LRN:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_NZIS_STATUS: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_OBSHTAPR: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_PATIENTOF_NEOTL:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_PATIENTOF_NEOTLID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_PREVENTIVE_TYPE: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_SYST:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_TALON_LKK:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_TERAPY:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_THREAD_IDS:
      begin
        if string(self.Items[i].IndexAnsiStr).Contains(FSearchingValue) then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_VISIT_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_VISIT_TYPE_ID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
      PregledNew_VSD_TYPE: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPregledNewSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPregledNewColl.ShowGrid(Grid: TTeeGrid);
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
  Grid.Columns[self.FieldCount].Selectable := False;
end;

procedure TPregledNewColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TPregledNewItem>);
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

procedure TPregledNewColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPregledNewSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPregledNewSearch.Count]);

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

procedure TPregledNewColl.SortByIndexAnsiString;
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
  //Items[Count - 1].IndexAnsiStr1;
end;

procedure TPregledNewColl.SortByIndexInt;
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

procedure TPregledNewColl.SortByIndexWord;
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

procedure TPregledNewColl.SortByIndexValue(propIndex: TPregledNewItem.TPropertyIndex);
begin
  case propIndex of
    PregledNew_AMB_LISTN: SortByIndexInt;
      PregledNew_ANAMN: SortByIndexAnsiString;
      PregledNew_COPIED_FROM_NRN: SortByIndexAnsiString;
      PregledNew_GS: SortByIndexWord;
      PregledNew_ID: SortByIndexInt;
      PregledNew_IZSL: SortByIndexAnsiString;
      PregledNew_MEDTRANSKM: SortByIndexInt;
      PregledNew_NAPRAVLENIE_AMBL_NOMER: SortByIndexAnsiString;
      PregledNew_NAPR_TYPE_ID: SortByIndexWord;
      PregledNew_NOMERBELEGKA: SortByIndexAnsiString;
      PregledNew_NOMERKASHAPARAT: SortByIndexAnsiString;
      PregledNew_NRD: SortByIndexWord;
      PregledNew_NRN_LRN: SortByIndexAnsiString;
      PregledNew_NZIS_STATUS: SortByIndexWord;
      PregledNew_OBSHTAPR: SortByIndexWord;
      PregledNew_PATIENTOF_NEOTL: SortByIndexAnsiString;
      PregledNew_PATIENTOF_NEOTLID: SortByIndexInt;
      PregledNew_PREVENTIVE_TYPE: SortByIndexWord;
      PregledNew_SYST: SortByIndexAnsiString;
      PregledNew_TALON_LKK: SortByIndexAnsiString;
      PregledNew_TERAPY: SortByIndexAnsiString;
      PregledNew_THREAD_IDS: SortByIndexAnsiString;
      PregledNew_VISIT_ID: SortByIndexInt;
      PregledNew_VISIT_TYPE_ID: SortByIndexWord;
      PregledNew_VSD_TYPE: SortByIndexWord;
  end;
end;

end.

{
PATIENTOF_NEOTL=AnsiString
PATIENTOF_NEOTLID=integer
PREVENTIVE_TYPE=word
REH_FINISHED_AT=TDate
START_DATE=TDate
START_TIME=TTime
SYST=AnsiString
TALON_LKK=AnsiString
TERAPY=AnsiString
THREAD_IDS=AnsiString
VISIT_ID=integer
VISIT_TYPE_ID=word
VSD_TYPE=word
Logical=tLogicalSet:INCIDENTALLY,IS_ANALYSIS,IS_BABY_CARE,IS_CONSULTATION, IS_DISPANSERY,IS_EMERGENCY,IS_EPIKRIZA,IS_EXPERTIZA,IS_FORM_VALID,   IS_HOSPITALIZATION,IS_MANIPULATION,IS_MEDBELEJKA,IS_NAET,IS_NAPR_TELK,IS_NEW,              IS_NOTIFICATION,IS_NO_DELAY,IS_OPERATION,IS_PODVIZHNO_LZ,IS_PREVENTIVE,IS_PRINTED,          IS_RECEPTA_HOSPIT,IS_REGISTRATION,IS_REHABILITATION,IS_RISK_GROUP,IS_TELK,IS_VSD,IS_ZAMESTVASHT,IS_PRIMARY,IS_AMB_PR,           IS_DOM_PR,PAY,TO_BE_DISPANSERED,IS_PREVENTIVE_Maternal,IS_PREVENTIVE_Childrens,IS_PREVENTIVE_Adults,IS_Screening
}