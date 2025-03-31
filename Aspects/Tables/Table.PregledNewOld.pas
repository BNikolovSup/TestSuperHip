unit Table.PregledNew;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows;

type

TTeeGRD = class(VCLTee.Grid.TTeeGrid);


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
, PregledNew_NRN
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
);
      TSetProp = set of TPropertyIndex;
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
        NRN: AnsiString;
        NZIS_STATUS: word;
        OBSHTAPR: word;
        PATIENTOF_NEOTL: AnsiString;
        PATIENTOF_NEOTLID: integer;
        PREVENTIVE_TYPE: word;
        REH_FINISHED_AT: TDATE;
        START_DATE: TDATE;
        START_TIME: TTIME;
        SYST: AnsiString;
        TALON_LKK: AnsiString;
        TERAPY: AnsiString;
        THREAD_IDS: AnsiString;
        VISIT_ID: integer;
        VISIT_TYPE_ID: word;
        VSD_TYPE: word;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPregledNew;
    function FieldCount: Integer;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPregledNew;
    procedure UpdatePregledNew;
    procedure SavePregledNew(var dataPosition: Cardinal);
  end;


  TPregledNewColl = class(TBaseCollection)
  private
    function GetItem(Index: Integer): TPregledNewItem;
    procedure SetItem(Index: Integer; const Value: TPregledNewItem);
  public
    function AddItem(ver: word):TPregledNewItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; PregledNew: TPregledNewItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PregledNew: TPregledNewItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    function DisplayName(propIndex: Word): string;
    
    property Items[Index: Integer]: TPregledNewItem read GetItem write SetItem;
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

function TPregledNewItem.FieldCount: Integer;
begin
  Result := 28;
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
  CollType := ctPregledNew;
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
            PregledNew_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
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

procedure TPregledNewItem.SavePregledNew(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
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
            PregledNew_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
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
            PregledNew_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
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


function TPregledNewColl.DisplayName(propIndex: Word): string;
begin
  case TPregledNewItem.TPropertyIndex(propIndex) of
    PregledNew_AMB_LISTN: Result := 'AMB_LISTN';
    PregledNew_ANAMN: Result := 'ANAMN';
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
    PregledNew_NRN: Result := 'NRN';
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
    PregledNew_NRN: str := (PregledNew.PRecord.NRN);
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
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
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
    PregledNew_NRN: str :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
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
  else
    begin
      str := IntToStr(ARow);
    end;
  end;
  AValue := str;
end;

function TPregledNewColl.GetItem(Index: Integer): TPregledNewItem;
begin
  Result := TPregledNewItem(inherited GetItem(Index));
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
    PregledNew_NRN: isOld :=  PregledNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
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
    PregledNew_NRN: PregledNew.PRecord.NRN := AValue;
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
  end;
end;

procedure TPregledNewColl.SetItem(Index: Integer; const Value: TPregledNewItem);
begin
  inherited SetItem(Index, Value);
end;


end.