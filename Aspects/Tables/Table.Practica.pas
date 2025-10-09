unit Table.Practica;

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


TPracticaItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Practica_ADDRESS_ACT
, Practica_ADDRESS_DOGNZOK
, Practica_ADRES
, Practica_BANKA
, Practica_BANKOW_KOD
, Practica_BULSTAT
, Practica_COMPANYNAME
, Practica_CONTRACT_DATE
, Practica_CONTRACT_RZOK
, Practica_CONTRACT_TYPE
, Practica_DAN_NOMER
, Practica_EGN
, Practica_FNAME
, Practica_FULLNAME
, Practica_INVOICECOMPANY
, Practica_ISSUER_TYPE
, Practica_IS_SAMOOSIG
, Practica_KOD_RAJON
, Practica_KOD_RZOK
, Practica_LNAME
, Practica_LNCH
, Practica_NAME
, Practica_NAS_MQSTO
, Practica_NEBL_USL
, Practica_NOMER_LZ
, Practica_NOM_NAP
, Practica_NZOK_NOMER
, Practica_OBLAST
, Practica_OBSHTINA
, Practica_SELF_INSURED_DECLARATION
, Practica_SMETKA
, Practica_SNAME
, Practica_UPRAVITEL
, Practica_VIDFIRMA
, Practica_VID_IDENT
, Practica_VID_PRAKTIKA
, Practica_HIP_TYPE
);
      TSetProp = set of TPropertyIndex;
      PRecPractica = ^TRecPractica;
      TRecPractica = record
        ADDRESS_ACT: AnsiString;
        ADDRESS_DOGNZOK: AnsiString;
        ADRES: AnsiString;
        BANKA: AnsiString;
        BANKOW_KOD: AnsiString;
        BULSTAT: AnsiString;
        COMPANYNAME: AnsiString;
        CONTRACT_DATE: TDate;
        CONTRACT_RZOK: AnsiString;
        CONTRACT_TYPE: word;
        DAN_NOMER: AnsiString;
        EGN: AnsiString;
        FNAME: AnsiString;
        FULLNAME: AnsiString;
        INVOICECOMPANY: boolean;
        ISSUER_TYPE: boolean;
        IS_SAMOOSIG: boolean;
        KOD_RAJON: AnsiString;
        KOD_RZOK: AnsiString;
        LNAME: AnsiString;
        LNCH: AnsiString;
        NAME: AnsiString;
        NAS_MQSTO: AnsiString;
        NEBL_USL: double;
        NOMER_LZ: AnsiString;
        NOM_NAP: AnsiString;
        NZOK_NOMER: AnsiString;
        OBLAST: AnsiString;
        OBSHTINA: AnsiString;
        SELF_INSURED_DECLARATION: boolean;
        SMETKA: AnsiString;
        SNAME: AnsiString;
        UPRAVITEL: AnsiString;
        VIDFIRMA: AnsiString;
        VID_IDENT: AnsiString;
        VID_PRAKTIKA: AnsiString;
        HIP_TYPE: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPractica;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;

    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPractica;
    procedure UpdatePractica;
    procedure SavePractica(var dataPosition: Cardinal);
  end;


  TPracticaColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TPracticaItem;
    procedure SetItem(Index: Integer; const Value: TPracticaItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListPracticaSearch: TList<TPracticaItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPracticaItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Practica: TPracticaItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Practica: TPracticaItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TPracticaItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
  //function GetTableName: string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);

    procedure IndexValue(propIndex: TPracticaItem.TPropertyIndex);
    property Items[Index: Integer]: TPracticaItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TPracticaItem }

constructor TPracticaItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPracticaItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPracticaItem.InsertPractica;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPractica;
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
            Practica_ADDRESS_ACT: SaveData(PRecord.ADDRESS_ACT, PropPosition, metaPosition, dataPosition);
            Practica_ADDRESS_DOGNZOK: SaveData(PRecord.ADDRESS_DOGNZOK, PropPosition, metaPosition, dataPosition);
            Practica_ADRES: SaveData(PRecord.ADRES, PropPosition, metaPosition, dataPosition);
            Practica_BANKA: SaveData(PRecord.BANKA, PropPosition, metaPosition, dataPosition);
            Practica_BANKOW_KOD: SaveData(PRecord.BANKOW_KOD, PropPosition, metaPosition, dataPosition);
            Practica_BULSTAT: SaveData(PRecord.BULSTAT, PropPosition, metaPosition, dataPosition);
            Practica_COMPANYNAME: SaveData(PRecord.COMPANYNAME, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_DATE: SaveData(PRecord.CONTRACT_DATE, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_RZOK: SaveData(PRecord.CONTRACT_RZOK, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_TYPE: SaveData(PRecord.CONTRACT_TYPE, PropPosition, metaPosition, dataPosition);
            Practica_DAN_NOMER: SaveData(PRecord.DAN_NOMER, PropPosition, metaPosition, dataPosition);
            Practica_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Practica_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Practica_FULLNAME: SaveData(PRecord.FULLNAME, PropPosition, metaPosition, dataPosition);
            Practica_INVOICECOMPANY: SaveData(PRecord.INVOICECOMPANY, PropPosition, metaPosition, dataPosition);
            Practica_ISSUER_TYPE: SaveData(PRecord.ISSUER_TYPE, PropPosition, metaPosition, dataPosition);
            Practica_IS_SAMOOSIG: SaveData(PRecord.IS_SAMOOSIG, PropPosition, metaPosition, dataPosition);
            Practica_KOD_RAJON: SaveData(PRecord.KOD_RAJON, PropPosition, metaPosition, dataPosition);
            Practica_KOD_RZOK: SaveData(PRecord.KOD_RZOK, PropPosition, metaPosition, dataPosition);
            Practica_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Practica_LNCH: SaveData(PRecord.LNCH, PropPosition, metaPosition, dataPosition);
            Practica_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Practica_NAS_MQSTO: SaveData(PRecord.NAS_MQSTO, PropPosition, metaPosition, dataPosition);
            Practica_NEBL_USL: SaveData(PRecord.NEBL_USL, PropPosition, metaPosition, dataPosition);
            Practica_NOMER_LZ: SaveData(PRecord.NOMER_LZ, PropPosition, metaPosition, dataPosition);
            Practica_NOM_NAP: SaveData(PRecord.NOM_NAP, PropPosition, metaPosition, dataPosition);
            Practica_NZOK_NOMER: SaveData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            Practica_OBLAST: SaveData(PRecord.OBLAST, PropPosition, metaPosition, dataPosition);
            Practica_OBSHTINA: SaveData(PRecord.OBSHTINA, PropPosition, metaPosition, dataPosition);
            Practica_SELF_INSURED_DECLARATION: SaveData(PRecord.SELF_INSURED_DECLARATION, PropPosition, metaPosition, dataPosition);
            Practica_SMETKA: SaveData(PRecord.SMETKA, PropPosition, metaPosition, dataPosition);
            Practica_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Practica_UPRAVITEL: SaveData(PRecord.UPRAVITEL, PropPosition, metaPosition, dataPosition);
            Practica_VIDFIRMA: SaveData(PRecord.VIDFIRMA, PropPosition, metaPosition, dataPosition);
            Practica_VID_IDENT: SaveData(PRecord.VID_IDENT, PropPosition, metaPosition, dataPosition);
            Practica_VID_PRAKTIKA: SaveData(PRecord.VID_PRAKTIKA, PropPosition, metaPosition, dataPosition);
            Practica_HIP_TYPE: SaveData(PRecord.HIP_TYPE, PropPosition, metaPosition, dataPosition);
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

procedure TPracticaItem.SavePractica(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPractica;
  SaveStreamCommand(TLogicalData40(PRecord.setProp), CollType, toUpdate, FVersion, dataPosition);
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
            Practica_ADDRESS_ACT: SaveData(PRecord.ADDRESS_ACT, PropPosition, metaPosition, dataPosition);
            Practica_ADDRESS_DOGNZOK: SaveData(PRecord.ADDRESS_DOGNZOK, PropPosition, metaPosition, dataPosition);
            Practica_ADRES: SaveData(PRecord.ADRES, PropPosition, metaPosition, dataPosition);
            Practica_BANKA: SaveData(PRecord.BANKA, PropPosition, metaPosition, dataPosition);
            Practica_BANKOW_KOD: SaveData(PRecord.BANKOW_KOD, PropPosition, metaPosition, dataPosition);
            Practica_BULSTAT: SaveData(PRecord.BULSTAT, PropPosition, metaPosition, dataPosition);
            Practica_COMPANYNAME: SaveData(PRecord.COMPANYNAME, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_DATE: SaveData(PRecord.CONTRACT_DATE, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_RZOK: SaveData(PRecord.CONTRACT_RZOK, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_TYPE: SaveData(PRecord.CONTRACT_TYPE, PropPosition, metaPosition, dataPosition);
            Practica_DAN_NOMER: SaveData(PRecord.DAN_NOMER, PropPosition, metaPosition, dataPosition);
            Practica_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Practica_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Practica_FULLNAME: SaveData(PRecord.FULLNAME, PropPosition, metaPosition, dataPosition);
            Practica_INVOICECOMPANY: SaveData(PRecord.INVOICECOMPANY, PropPosition, metaPosition, dataPosition);
            Practica_ISSUER_TYPE: SaveData(PRecord.ISSUER_TYPE, PropPosition, metaPosition, dataPosition);
            Practica_IS_SAMOOSIG: SaveData(PRecord.IS_SAMOOSIG, PropPosition, metaPosition, dataPosition);
            Practica_KOD_RAJON: SaveData(PRecord.KOD_RAJON, PropPosition, metaPosition, dataPosition);
            Practica_KOD_RZOK: SaveData(PRecord.KOD_RZOK, PropPosition, metaPosition, dataPosition);
            Practica_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Practica_LNCH: SaveData(PRecord.LNCH, PropPosition, metaPosition, dataPosition);
            Practica_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Practica_NAS_MQSTO: SaveData(PRecord.NAS_MQSTO, PropPosition, metaPosition, dataPosition);
            Practica_NEBL_USL: SaveData(PRecord.NEBL_USL, PropPosition, metaPosition, dataPosition);
            Practica_NOMER_LZ: SaveData(PRecord.NOMER_LZ, PropPosition, metaPosition, dataPosition);
            Practica_NOM_NAP: SaveData(PRecord.NOM_NAP, PropPosition, metaPosition, dataPosition);
            Practica_NZOK_NOMER: SaveData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            Practica_OBLAST: SaveData(PRecord.OBLAST, PropPosition, metaPosition, dataPosition);
            Practica_OBSHTINA: SaveData(PRecord.OBSHTINA, PropPosition, metaPosition, dataPosition);
            Practica_SELF_INSURED_DECLARATION: SaveData(PRecord.SELF_INSURED_DECLARATION, PropPosition, metaPosition, dataPosition);
            Practica_SMETKA: SaveData(PRecord.SMETKA, PropPosition, metaPosition, dataPosition);
            Practica_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Practica_UPRAVITEL: SaveData(PRecord.UPRAVITEL, PropPosition, metaPosition, dataPosition);
            Practica_VIDFIRMA: SaveData(PRecord.VIDFIRMA, PropPosition, metaPosition, dataPosition);
            Practica_VID_IDENT: SaveData(PRecord.VID_IDENT, PropPosition, metaPosition, dataPosition);
            Practica_VID_PRAKTIKA: SaveData(PRecord.VID_PRAKTIKA, PropPosition, metaPosition, dataPosition);
            Practica_HIP_TYPE: SaveData(PRecord.HIP_TYPE, PropPosition, metaPosition, dataPosition);
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

procedure TPracticaItem.UpdatePractica;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPractica;
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
            Practica_ADDRESS_ACT: UpdateData(PRecord.ADDRESS_ACT, PropPosition, metaPosition, dataPosition);
            Practica_ADDRESS_DOGNZOK: UpdateData(PRecord.ADDRESS_DOGNZOK, PropPosition, metaPosition, dataPosition);
            Practica_ADRES: UpdateData(PRecord.ADRES, PropPosition, metaPosition, dataPosition);
            Practica_BANKA: UpdateData(PRecord.BANKA, PropPosition, metaPosition, dataPosition);
            Practica_BANKOW_KOD: UpdateData(PRecord.BANKOW_KOD, PropPosition, metaPosition, dataPosition);
            Practica_BULSTAT: UpdateData(PRecord.BULSTAT, PropPosition, metaPosition, dataPosition);
            Practica_COMPANYNAME: UpdateData(PRecord.COMPANYNAME, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_DATE: UpdateData(PRecord.CONTRACT_DATE, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_RZOK: UpdateData(PRecord.CONTRACT_RZOK, PropPosition, metaPosition, dataPosition);
            Practica_CONTRACT_TYPE: UpdateData(PRecord.CONTRACT_TYPE, PropPosition, metaPosition, dataPosition);
            Practica_DAN_NOMER: UpdateData(PRecord.DAN_NOMER, PropPosition, metaPosition, dataPosition);
            Practica_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            Practica_FNAME: UpdateData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            Practica_FULLNAME: UpdateData(PRecord.FULLNAME, PropPosition, metaPosition, dataPosition);
            Practica_INVOICECOMPANY: UpdateData(PRecord.INVOICECOMPANY, PropPosition, metaPosition, dataPosition);
            Practica_ISSUER_TYPE: UpdateData(PRecord.ISSUER_TYPE, PropPosition, metaPosition, dataPosition);
            Practica_IS_SAMOOSIG: UpdateData(PRecord.IS_SAMOOSIG, PropPosition, metaPosition, dataPosition);
            Practica_KOD_RAJON: UpdateData(PRecord.KOD_RAJON, PropPosition, metaPosition, dataPosition);
            Practica_KOD_RZOK: UpdateData(PRecord.KOD_RZOK, PropPosition, metaPosition, dataPosition);
            Practica_LNAME: UpdateData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            Practica_LNCH: UpdateData(PRecord.LNCH, PropPosition, metaPosition, dataPosition);
            Practica_NAME: UpdateData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Practica_NAS_MQSTO: UpdateData(PRecord.NAS_MQSTO, PropPosition, metaPosition, dataPosition);
            Practica_NEBL_USL: UpdateData(PRecord.NEBL_USL, PropPosition, metaPosition, dataPosition);
            Practica_NOMER_LZ: UpdateData(PRecord.NOMER_LZ, PropPosition, metaPosition, dataPosition);
            Practica_NOM_NAP: UpdateData(PRecord.NOM_NAP, PropPosition, metaPosition, dataPosition);
            Practica_NZOK_NOMER: UpdateData(PRecord.NZOK_NOMER, PropPosition, metaPosition, dataPosition);
            Practica_OBLAST: UpdateData(PRecord.OBLAST, PropPosition, metaPosition, dataPosition);
            Practica_OBSHTINA: UpdateData(PRecord.OBSHTINA, PropPosition, metaPosition, dataPosition);
            Practica_SELF_INSURED_DECLARATION: UpdateData(PRecord.SELF_INSURED_DECLARATION, PropPosition, metaPosition, dataPosition);
            Practica_SMETKA: UpdateData(PRecord.SMETKA, PropPosition, metaPosition, dataPosition);
            Practica_SNAME: UpdateData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            Practica_UPRAVITEL: UpdateData(PRecord.UPRAVITEL, PropPosition, metaPosition, dataPosition);
            Practica_VIDFIRMA: UpdateData(PRecord.VIDFIRMA, PropPosition, metaPosition, dataPosition);
            Practica_VID_IDENT: UpdateData(PRecord.VID_IDENT, PropPosition, metaPosition, dataPosition);
            Practica_VID_PRAKTIKA: UpdateData(PRecord.VID_PRAKTIKA, PropPosition, metaPosition, dataPosition);
            Practica_HIP_TYPE: UpdateData(PRecord.HIP_TYPE, PropPosition, metaPosition, dataPosition);
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

{ TPracticaColl }

function TPracticaColl.AddItem(ver: word): TPracticaItem;
begin
  Result := TPracticaItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TPracticaColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListPracticaSearch := TList<TPracticaItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TPracticaColl.destroy;
begin
  FreeAndNil(ListPracticaSearch);
  inherited;
end;

function TPracticaColl.DisplayName(propIndex: Word): string;
begin
  case TPracticaItem.TPropertyIndex(propIndex) of
    Practica_ADDRESS_ACT: Result := 'ADDRESS_ACT';
    Practica_ADDRESS_DOGNZOK: Result := 'ADDRESS_DOGNZOK';
    Practica_ADRES: Result := 'ADRES';
    Practica_BANKA: Result := 'BANKA';
    Practica_BANKOW_KOD: Result := 'BANKOW_KOD';
    Practica_BULSTAT: Result := 'BULSTAT';
    Practica_COMPANYNAME: Result := 'COMPANYNAME';
    Practica_CONTRACT_DATE: Result := 'CONTRACT_DATE';
    Practica_CONTRACT_RZOK: Result := 'CONTRACT_RZOK';
    Practica_CONTRACT_TYPE: Result := 'CONTRACT_TYPE';
    Practica_DAN_NOMER: Result := 'DAN_NOMER';
    Practica_EGN: Result := 'EGN';
    Practica_FNAME: Result := 'FNAME';
    Practica_FULLNAME: Result := 'FULLNAME';
    Practica_INVOICECOMPANY: Result := 'INVOICECOMPANY';
    Practica_ISSUER_TYPE: Result := 'ISSUER_TYPE';
    Practica_IS_SAMOOSIG: Result := 'IS_SAMOOSIG';
    Practica_KOD_RAJON: Result := 'KOD_RAJON';
    Practica_KOD_RZOK: Result := 'KOD_RZOK';
    Practica_LNAME: Result := 'LNAME';
    Practica_LNCH: Result := 'LNCH';
    Practica_NAME: Result := 'NAME';
    Practica_NAS_MQSTO: Result := 'NAS_MQSTO';
    Practica_NEBL_USL: Result := 'NEBL_USL';
    Practica_NOMER_LZ: Result := 'NOMER_LZ';
    Practica_NOM_NAP: Result := 'NOM_NAP';
    Practica_NZOK_NOMER: Result := 'NZOK_NOMER';
    Practica_OBLAST: Result := 'OBLAST';
    Practica_OBSHTINA: Result := 'OBSHTINA';
    Practica_SELF_INSURED_DECLARATION: Result := 'SELF_INSURED_DECLARATION';
    Practica_SMETKA: Result := 'SMETKA';
    Practica_SNAME: Result := 'SNAME';
    Practica_UPRAVITEL: Result := 'UPRAVITEL';
    Practica_VIDFIRMA: Result := 'VIDFIRMA';
    Practica_VID_IDENT: Result := 'VID_IDENT';
    Practica_VID_PRAKTIKA: Result := 'VID_PRAKTIKA';
    Practica_HIP_TYPE: Result := 'HIP_TYPE';
  end;
end;

procedure TPracticaColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TPracticaItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TPracticaColl.FieldCount: Integer;
begin
  Result := 37;
end;

procedure TPracticaColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Practica: TPracticaItem;
  ACol: Integer;
  prop: TPracticaItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Practica := Items[ARow];
  prop := TPracticaItem.TPropertyIndex(ACol);
  if Assigned(Practica.PRecord) and (prop in Practica.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Practica, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Practica, AValue);
  end;
end;

procedure TPracticaColl.GetCellFromRecord(propIndex: word; Practica: TPracticaItem; var AValue: String);
var
  str: string;
begin
  case TPracticaItem.TPropertyIndex(propIndex) of
    Practica_ADDRESS_ACT: str := (Practica.PRecord.ADDRESS_ACT);
    Practica_ADDRESS_DOGNZOK: str := (Practica.PRecord.ADDRESS_DOGNZOK);
    Practica_ADRES: str := (Practica.PRecord.ADRES);
    Practica_BANKA: str := (Practica.PRecord.BANKA);
    Practica_BANKOW_KOD: str := (Practica.PRecord.BANKOW_KOD);
    Practica_BULSTAT: str := (Practica.PRecord.BULSTAT);
    Practica_COMPANYNAME: str := (Practica.PRecord.COMPANYNAME);
    Practica_CONTRACT_DATE: str := DateToStr(Practica.PRecord.CONTRACT_DATE);
    Practica_CONTRACT_RZOK: str := (Practica.PRecord.CONTRACT_RZOK);
    Practica_CONTRACT_TYPE: str := inttostr(Practica.PRecord.CONTRACT_TYPE);
    Practica_DAN_NOMER: str := (Practica.PRecord.DAN_NOMER);
    Practica_EGN: str := (Practica.PRecord.EGN);
    Practica_FNAME: str := (Practica.PRecord.FNAME);
    Practica_FULLNAME: str := (Practica.PRecord.FULLNAME);
    Practica_INVOICECOMPANY: str := BoolToStr(Practica.PRecord.INVOICECOMPANY, True);
    Practica_ISSUER_TYPE: str := BoolToStr(Practica.PRecord.ISSUER_TYPE, True);
    Practica_IS_SAMOOSIG: str := BoolToStr(Practica.PRecord.IS_SAMOOSIG, True);
    Practica_KOD_RAJON: str := (Practica.PRecord.KOD_RAJON);
    Practica_KOD_RZOK: str := (Practica.PRecord.KOD_RZOK);
    Practica_LNAME: str := (Practica.PRecord.LNAME);
    Practica_LNCH: str := (Practica.PRecord.LNCH);
    Practica_NAME: str := (Practica.PRecord.NAME);
    Practica_NAS_MQSTO: str := (Practica.PRecord.NAS_MQSTO);
    Practica_NEBL_USL: str := FloatToStr(Practica.PRecord.NEBL_USL);
    Practica_NOMER_LZ: str := (Practica.PRecord.NOMER_LZ);
    Practica_NOM_NAP: str := (Practica.PRecord.NOM_NAP);
    Practica_NZOK_NOMER: str := (Practica.PRecord.NZOK_NOMER);
    Practica_OBLAST: str := (Practica.PRecord.OBLAST);
    Practica_OBSHTINA: str := (Practica.PRecord.OBSHTINA);
    Practica_SELF_INSURED_DECLARATION: str := BoolToStr(Practica.PRecord.SELF_INSURED_DECLARATION, True);
    Practica_SMETKA: str := (Practica.PRecord.SMETKA);
    Practica_SNAME: str := (Practica.PRecord.SNAME);
    Practica_UPRAVITEL: str := (Practica.PRecord.UPRAVITEL);
    Practica_VIDFIRMA: str := (Practica.PRecord.VIDFIRMA);
    Practica_VID_IDENT: str := (Practica.PRecord.VID_IDENT);
    Practica_VID_PRAKTIKA: str := (Practica.PRecord.VID_PRAKTIKA);
    Practica_HIP_TYPE: str := (Practica.PRecord.HIP_TYPE);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPracticaColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Practica: TPracticaItem;
  ACol: Integer;
  prop: TPracticaItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Practica := ListPracticaSearch[ARow];
  prop := TPracticaItem.TPropertyIndex(ACol);
  if Assigned(Practica.PRecord) and (prop in Practica.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Practica, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Practica, AValue);
  end;
end;

procedure TPracticaColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Practica: TPracticaItem;
  prop: TPracticaItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Practica := Items[ARow];
  prop := TPracticaItem.TPropertyIndex(ACol);
  if Assigned(Practica.PRecord) and (prop in Practica.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Practica, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Practica, AFieldText);
  end;
end;

procedure TPracticaColl.GetCellFromMap(propIndex: word; ARow: Integer; Practica: TPracticaItem; var AValue: String);
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
  case TPracticaItem.TPropertyIndex(propIndex) of
    Practica_ADDRESS_ACT: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_ADDRESS_DOGNZOK: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_ADRES: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_BANKA: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_BANKOW_KOD: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_BULSTAT: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_COMPANYNAME: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_CONTRACT_DATE: str :=  DateToStr(Practica.getDateMap(Self.Buf, Self.posData, propIndex));
    Practica_CONTRACT_RZOK: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_CONTRACT_TYPE: str :=  inttostr(Practica.getWordMap(Self.Buf, Self.posData, propIndex));
    Practica_DAN_NOMER: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_EGN: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_FNAME: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_FULLNAME: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_INVOICECOMPANY: str :=  BoolToStr(Practica.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Practica_ISSUER_TYPE: str :=  BoolToStr(Practica.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Practica_IS_SAMOOSIG: str :=  BoolToStr(Practica.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Practica_KOD_RAJON: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_KOD_RZOK: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_LNAME: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_LNCH: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_NAME: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_NAS_MQSTO: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_NOMER_LZ: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_NOM_NAP: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_NZOK_NOMER: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_OBLAST: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_OBSHTINA: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_SELF_INSURED_DECLARATION: str :=  BoolToStr(Practica.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    Practica_SMETKA: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_SNAME: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_UPRAVITEL: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_VIDFIRMA: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_VID_IDENT: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_VID_PRAKTIKA: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Practica_HIP_TYPE: str :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPracticaColl.GetItem(Index: Integer): TPracticaItem;
begin
  Result := TPracticaItem(inherited GetItem(Index));
end;


//function TPracticaColl.GetTableName: string;
//begin
//  Result := 'Practica';
//end;

procedure TPracticaColl.IndexValue(propIndex: TPracticaItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPracticaItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Practica_ADDRESS_ACT:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Practica_ADDRESS_DOGNZOK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_ADRES:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_BANKA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_BANKOW_KOD:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_BULSTAT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_COMPANYNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_CONTRACT_RZOK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_CONTRACT_TYPE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Practica_DAN_NOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_FNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_FULLNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_KOD_RAJON:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_KOD_RZOK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_LNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_LNCH:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_NAS_MQSTO:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_NOMER_LZ:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_NOM_NAP:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_NZOK_NOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_OBLAST:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_OBSHTINA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_SMETKA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_SNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_UPRAVITEL:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_VIDFIRMA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_VID_IDENT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_VID_PRAKTIKA:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Practica_HIP_TYPE:
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



procedure TPracticaColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Practica: TPracticaItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Practica := Items[ARow];
  if not Assigned(Practica.PRecord) then
  begin
    New(Practica.PRecord);
    Practica.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPracticaItem.TPropertyIndex(ACol) of
      Practica_ADDRESS_ACT: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_ADDRESS_DOGNZOK: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_ADRES: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_BANKA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_BANKOW_KOD: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_BULSTAT: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_COMPANYNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_CONTRACT_DATE: isOld :=  Practica.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    Practica_CONTRACT_RZOK: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_CONTRACT_TYPE: isOld :=  Practica.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Practica_DAN_NOMER: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_EGN: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_FNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_FULLNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_INVOICECOMPANY: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Practica_ISSUER_TYPE: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Practica_IS_SAMOOSIG: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Practica_KOD_RAJON: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_KOD_RZOK: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_LNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_LNCH: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_NAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_NAS_MQSTO: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_NOMER_LZ: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_NOM_NAP: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_NZOK_NOMER: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_OBLAST: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_OBSHTINA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_SELF_INSURED_DECLARATION: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    Practica_SMETKA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_SNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_UPRAVITEL: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_VIDFIRMA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_VID_IDENT: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_VID_PRAKTIKA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Practica_HIP_TYPE: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Practica.PRecord.setProp, TPracticaItem.TPropertyIndex(ACol));
    if Practica.PRecord.setProp = [] then
    begin
      Dispose(Practica.PRecord);
      Practica.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Practica.PRecord.setProp, TPracticaItem.TPropertyIndex(ACol));
  case TPracticaItem.TPropertyIndex(ACol) of
    Practica_ADDRESS_ACT: Practica.PRecord.ADDRESS_ACT := AValue;
    Practica_ADDRESS_DOGNZOK: Practica.PRecord.ADDRESS_DOGNZOK := AValue;
    Practica_ADRES: Practica.PRecord.ADRES := AValue;
    Practica_BANKA: Practica.PRecord.BANKA := AValue;
    Practica_BANKOW_KOD: Practica.PRecord.BANKOW_KOD := AValue;
    Practica_BULSTAT: Practica.PRecord.BULSTAT := AValue;
    Practica_COMPANYNAME: Practica.PRecord.COMPANYNAME := AValue;
    Practica_CONTRACT_DATE: Practica.PRecord.CONTRACT_DATE := StrToDate(AValue);
    Practica_CONTRACT_RZOK: Practica.PRecord.CONTRACT_RZOK := AValue;
    Practica_CONTRACT_TYPE: Practica.PRecord.CONTRACT_TYPE := StrToInt(AValue);
    Practica_DAN_NOMER: Practica.PRecord.DAN_NOMER := AValue;
    Practica_EGN: Practica.PRecord.EGN := AValue;
    Practica_FNAME: Practica.PRecord.FNAME := AValue;
    Practica_FULLNAME: Practica.PRecord.FULLNAME := AValue;
    Practica_INVOICECOMPANY: Practica.PRecord.INVOICECOMPANY := StrToBool(AValue);
    Practica_ISSUER_TYPE: Practica.PRecord.ISSUER_TYPE := StrToBool(AValue);
    Practica_IS_SAMOOSIG: Practica.PRecord.IS_SAMOOSIG := StrToBool(AValue);
    Practica_KOD_RAJON: Practica.PRecord.KOD_RAJON := AValue;
    Practica_KOD_RZOK: Practica.PRecord.KOD_RZOK := AValue;
    Practica_LNAME: Practica.PRecord.LNAME := AValue;
    Practica_LNCH: Practica.PRecord.LNCH := AValue;
    Practica_NAME: Practica.PRecord.NAME := AValue;
    Practica_NAS_MQSTO: Practica.PRecord.NAS_MQSTO := AValue;
    Practica_NEBL_USL: Practica.PRecord.NEBL_USL := StrToFloat(AValue);
    Practica_NOMER_LZ: Practica.PRecord.NOMER_LZ := AValue;
    Practica_NOM_NAP: Practica.PRecord.NOM_NAP := AValue;
    Practica_NZOK_NOMER: Practica.PRecord.NZOK_NOMER := AValue;
    Practica_OBLAST: Practica.PRecord.OBLAST := AValue;
    Practica_OBSHTINA: Practica.PRecord.OBSHTINA := AValue;
    Practica_SELF_INSURED_DECLARATION: Practica.PRecord.SELF_INSURED_DECLARATION := StrToBool(AValue);
    Practica_SMETKA: Practica.PRecord.SMETKA := AValue;
    Practica_SNAME: Practica.PRecord.SNAME := AValue;
    Practica_UPRAVITEL: Practica.PRecord.UPRAVITEL := AValue;
    Practica_VIDFIRMA: Practica.PRecord.VIDFIRMA := AValue;
    Practica_VID_IDENT: Practica.PRecord.VID_IDENT := AValue;
    Practica_VID_PRAKTIKA: Practica.PRecord.VID_PRAKTIKA := AValue;
    Practica_HIP_TYPE: Practica.PRecord.HIP_TYPE := AValue;
  end;
end;

procedure TPracticaColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Practica: TPracticaItem;
begin
  if Count = 0 then Exit;

  Practica := Items[ARow];
  if not Assigned(Practica.PRecord) then
  begin
    New(Practica.PRecord);
    Practica.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TPracticaItem.TPropertyIndex(ACol) of
      Practica_ADDRESS_ACT: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_ADDRESS_DOGNZOK: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_ADRES: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_BANKA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_BANKOW_KOD: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_BULSTAT: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_COMPANYNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_CONTRACT_DATE: isOld :=  Practica.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    Practica_CONTRACT_RZOK: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_CONTRACT_TYPE: isOld :=  Practica.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Practica_DAN_NOMER: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_EGN: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_FNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_FULLNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_INVOICECOMPANY: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Practica_ISSUER_TYPE: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Practica_IS_SAMOOSIG: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Practica_KOD_RAJON: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_KOD_RZOK: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_LNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_LNCH: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_NAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_NAS_MQSTO: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_NOMER_LZ: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_NOM_NAP: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_NZOK_NOMER: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_OBLAST: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_OBSHTINA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_SELF_INSURED_DECLARATION: isOld :=  Practica.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    Practica_SMETKA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_SNAME: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_UPRAVITEL: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_VIDFIRMA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_VID_IDENT: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_VID_PRAKTIKA: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Practica_HIP_TYPE: isOld :=  Practica.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Practica.PRecord.setProp, TPracticaItem.TPropertyIndex(ACol));
    if Practica.PRecord.setProp = [] then
    begin
      Dispose(Practica.PRecord);
      Practica.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Practica.PRecord.setProp, TPracticaItem.TPropertyIndex(ACol));
  case TPracticaItem.TPropertyIndex(ACol) of
    Practica_ADDRESS_ACT: Practica.PRecord.ADDRESS_ACT := AFieldText;
    Practica_ADDRESS_DOGNZOK: Practica.PRecord.ADDRESS_DOGNZOK := AFieldText;
    Practica_ADRES: Practica.PRecord.ADRES := AFieldText;
    Practica_BANKA: Practica.PRecord.BANKA := AFieldText;
    Practica_BANKOW_KOD: Practica.PRecord.BANKOW_KOD := AFieldText;
    Practica_BULSTAT: Practica.PRecord.BULSTAT := AFieldText;
    Practica_COMPANYNAME: Practica.PRecord.COMPANYNAME := AFieldText;
    Practica_CONTRACT_DATE: Practica.PRecord.CONTRACT_DATE := StrToDate(AFieldText);
    Practica_CONTRACT_RZOK: Practica.PRecord.CONTRACT_RZOK := AFieldText;
    Practica_CONTRACT_TYPE: Practica.PRecord.CONTRACT_TYPE := StrToInt(AFieldText);
    Practica_DAN_NOMER: Practica.PRecord.DAN_NOMER := AFieldText;
    Practica_EGN: Practica.PRecord.EGN := AFieldText;
    Practica_FNAME: Practica.PRecord.FNAME := AFieldText;
    Practica_FULLNAME: Practica.PRecord.FULLNAME := AFieldText;
    Practica_INVOICECOMPANY: Practica.PRecord.INVOICECOMPANY := StrToBool(AFieldText);
    Practica_ISSUER_TYPE: Practica.PRecord.ISSUER_TYPE := StrToBool(AFieldText);
    Practica_IS_SAMOOSIG: Practica.PRecord.IS_SAMOOSIG := StrToBool(AFieldText);
    Practica_KOD_RAJON: Practica.PRecord.KOD_RAJON := AFieldText;
    Practica_KOD_RZOK: Practica.PRecord.KOD_RZOK := AFieldText;
    Practica_LNAME: Practica.PRecord.LNAME := AFieldText;
    Practica_LNCH: Practica.PRecord.LNCH := AFieldText;
    Practica_NAME: Practica.PRecord.NAME := AFieldText;
    Practica_NAS_MQSTO: Practica.PRecord.NAS_MQSTO := AFieldText;
    Practica_NEBL_USL: Practica.PRecord.NEBL_USL := StrToFloat(AFieldText);
    Practica_NOMER_LZ: Practica.PRecord.NOMER_LZ := AFieldText;
    Practica_NOM_NAP: Practica.PRecord.NOM_NAP := AFieldText;
    Practica_NZOK_NOMER: Practica.PRecord.NZOK_NOMER := AFieldText;
    Practica_OBLAST: Practica.PRecord.OBLAST := AFieldText;
    Practica_OBSHTINA: Practica.PRecord.OBSHTINA := AFieldText;
    Practica_SELF_INSURED_DECLARATION: Practica.PRecord.SELF_INSURED_DECLARATION := StrToBool(AFieldText);
    Practica_SMETKA: Practica.PRecord.SMETKA := AFieldText;
    Practica_SNAME: Practica.PRecord.SNAME := AFieldText;
    Practica_UPRAVITEL: Practica.PRecord.UPRAVITEL := AFieldText;
    Practica_VIDFIRMA: Practica.PRecord.VIDFIRMA := AFieldText;
    Practica_VID_IDENT: Practica.PRecord.VID_IDENT := AFieldText;
    Practica_VID_PRAKTIKA: Practica.PRecord.VID_PRAKTIKA := AFieldText;
    Practica_HIP_TYPE: Practica.PRecord.HIP_TYPE := AFieldText;
  end;
end;

procedure TPracticaColl.SetItem(Index: Integer; const Value: TPracticaItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPracticaColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPracticaSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPracticaItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Practica_ADDRESS_ACT:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListPracticaSearch.Add(self.Items[i]);
  end;
end;
      Practica_ADDRESS_DOGNZOK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_ADRES:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_BANKA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_BANKOW_KOD:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_BULSTAT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_COMPANYNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_CONTRACT_RZOK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_CONTRACT_TYPE: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_DAN_NOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_FNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_FULLNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_KOD_RAJON:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_KOD_RZOK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_LNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_LNCH:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_NAS_MQSTO:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_NOMER_LZ:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_NOM_NAP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_NZOK_NOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_OBLAST:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_OBSHTINA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_SMETKA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_SNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_UPRAVITEL:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_VIDFIRMA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_VID_IDENT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_VID_PRAKTIKA:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
      Practica_HIP_TYPE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPracticaSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPracticaColl.ShowGrid(Grid: TTeeGrid);
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

procedure TPracticaColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPracticaSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPracticaSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TPracticaColl.SortByIndexAnsiString;
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

procedure TPracticaColl.SortByIndexInt;
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

procedure TPracticaColl.SortByIndexWord;
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

procedure TPracticaColl.SortByIndexValue(propIndex: TPracticaItem.TPropertyIndex);
begin
  case propIndex of
    Practica_ADDRESS_ACT: SortByIndexAnsiString;
      Practica_ADDRESS_DOGNZOK: SortByIndexAnsiString;
      Practica_ADRES: SortByIndexAnsiString;
      Practica_BANKA: SortByIndexAnsiString;
      Practica_BANKOW_KOD: SortByIndexAnsiString;
      Practica_BULSTAT: SortByIndexAnsiString;
      Practica_COMPANYNAME: SortByIndexAnsiString;
      Practica_CONTRACT_RZOK: SortByIndexAnsiString;
      Practica_CONTRACT_TYPE: SortByIndexWord;
      Practica_DAN_NOMER: SortByIndexAnsiString;
      Practica_EGN: SortByIndexAnsiString;
      Practica_FNAME: SortByIndexAnsiString;
      Practica_FULLNAME: SortByIndexAnsiString;
      Practica_KOD_RAJON: SortByIndexAnsiString;
      Practica_KOD_RZOK: SortByIndexAnsiString;
      Practica_LNAME: SortByIndexAnsiString;
      Practica_LNCH: SortByIndexAnsiString;
      Practica_NAME: SortByIndexAnsiString;
      Practica_NAS_MQSTO: SortByIndexAnsiString;
      Practica_NOMER_LZ: SortByIndexAnsiString;
      Practica_NOM_NAP: SortByIndexAnsiString;
      Practica_NZOK_NOMER: SortByIndexAnsiString;
      Practica_OBLAST: SortByIndexAnsiString;
      Practica_OBSHTINA: SortByIndexAnsiString;
      Practica_SMETKA: SortByIndexAnsiString;
      Practica_SNAME: SortByIndexAnsiString;
      Practica_UPRAVITEL: SortByIndexAnsiString;
      Practica_VIDFIRMA: SortByIndexAnsiString;
      Practica_VID_IDENT: SortByIndexAnsiString;
      Practica_VID_PRAKTIKA: SortByIndexAnsiString;
      Practica_HIP_TYPE: SortByIndexAnsiString;
  end;
end;

end.
{



ADDRESS_ACT=AnsiString
ADDRESS_DOGNZOK=AnsiString
ADRES=AnsiString
BANKA=AnsiString
BANKOW_KOD=AnsiString
BULSTAT=AnsiString
COMPANYNAME=AnsiString
CONTRACT_DATE=TDate
CONTRACT_RZOK=AnsiString
CONTRACT_TYPE=word
DAN_NOMER=AnsiString
EGN=AnsiString
FNAME=AnsiString
FULLNAME=AnsiString
INVOICECOMPANY=boolean
ISSUER_TYPE=boolean
IS_SAMOOSIG=boolean
KOD_RAJON=AnsiString
KOD_RZOK=AnsiString
LNAME=AnsiString
LNCH=AnsiString
NAME=AnsiString
NAS_MQSTO=AnsiString
NEBL_USL=double
NOMER_LZ=AnsiString
NOM_NAP=AnsiString
NZOK_NOMER=AnsiString
OBLAST=AnsiString
OBSHTINA=AnsiString
SELF_INSURED_DECLARATION=boolean
SMETKA=AnsiString
SNAME=AnsiString
UPRAVITEL=AnsiString
VIDFIRMA=AnsiString
VID_IDENT=AnsiString
VID_PRAKTIKA=AnsiString
}