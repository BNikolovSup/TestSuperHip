unit RealObj.RealNzis;

interface

uses
  Table.PregledNew, Table.PatientNew, Table.diagnosis, Table.MDN,
  Table.PatientNZOK, Table.doctor, Table.Unfav, table.EventsManyTimes,
  Aspects.Collections, Aspects.Types, ProfGraph, VirtualTrees,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings, Vcl.Graphics,
  classes, system.SysUtils, windows, System.Generics.Collections, system.Math,
  Nzis.Types;

type

TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  TRealNzisPregledNewItem = class;

  //TRealNzisDiagnosisItem = class;
  //TRealNzisDiagnosisColl= class;

  TRealNzisPregledNewItem = class(TPregledNewItem)
  private
    FVisitTypeId: TVisitType;
    FClass: TPregledType;
    FFinancingSource: TFinancingSource;
    FPurpose: TPurposeBase;
    FLRN: string;
    function GetTagClass: string;
    function GetTagFinancingSource: string;
    function GetTagLrn: string;
    function GetTagOpenDate: string;
    function GetTagRhifAreaNumber: string;
    function GetTagScreening: string;
    function GetVisitTypeId: TVisitType;
    procedure SetClass(const Value: TPregledType);
    procedure SetPurpose(const Value: TPurposeBase);
    function GetLrn: string;
  public
    AdbDataPos: Cardinal;
    XMLStream: TStringStream;

    constructor Create(Collection: TCollection); override;
    destructor destroy; override;

    property VisitTypeId: TVisitType read GetVisitTypeId;
    property _Class: TPregledType read FClass write SetClass;
    property FinancingSource: TFinancingSource read FFinancingSource write FFinancingSource;
    property Purpose:TPurposeBase read FPurpose write SetPurpose;
    property LRN: string read GetLrn write FLRN;
    //property Performer: TPerformerItem read FPerformer write SetPerformer;

    property TagLrn: string read GetTagLrn;
    property TagOpenDate: string read GetTagOpenDate;
    property TagClass: string read GetTagClass;
    property TagFinancingSource: string read GetTagFinancingSource;
    property TagScreening: string read GetTagScreening;
    property TagRhifAreaNumber: string read GetTagRhifAreaNumber;

  end;

  TRealNzisPregledNewColl = class (TPregledNewColl)

  end;


implementation

{ TRealNzisPregledNewItem }

constructor TRealNzisPregledNewItem.Create(Collection: TCollection);
begin
  inherited;
  FClass := ptAMB;
  XMLStream := TStringStream.Create('', TEncoding.UTF8);
end;

destructor TRealNzisPregledNewItem.destroy;
begin
  FreeAndNil(XMLStream);
  inherited;
end;

function TRealNzisPregledNewItem.GetLrn: string;
begin
  //FLRN := FormatDateTime('YYYY-', self.FOpenDate);
//  if FPerformer.FPmiDeputy = nil then
//  begin
//    FLRN := FLRN + FPerformer.FPmi.Value;
//  end
//  else
//  begin
//    FLRN := FLRN + FPerformer.FPmiDeputy.Value;// zzzzzzzzzzzzzzzzzzz  да се влезе тук
//  end;
//  FLRN := FLRN + '-' + IntToStr(FAmbLstN);
//  Result := FLRN ;
end;

function TRealNzisPregledNewItem.GetTagClass: string;
begin

end;

function TRealNzisPregledNewItem.GetTagFinancingSource: string;
begin

end;

function TRealNzisPregledNewItem.GetTagLrn: string;
begin

end;

function TRealNzisPregledNewItem.GetTagOpenDate: string;
begin

end;

function TRealNzisPregledNewItem.GetTagRhifAreaNumber: string;
begin

end;

function TRealNzisPregledNewItem.GetTagScreening: string;
begin

end;



function TRealNzisPregledNewItem.GetVisitTypeId: TVisitType;
var
  w: Word;
begin
  w := getWordMap(Self.buf, AdbDataPos, word(PregledNew_VISIT_TYPE_ID));
  Result := TVisitType(w);
  case Result of
    vtBlanka3, vtBlanka3A, vtBlanka6:
    begin
      FFinancingSource := fsNHIF;
    end;
    vtCovidOtd, vtCovidZona:
    begin
      FFinancingSource := fsMZ;
    end;
    vtSpeshen, vtNeotlogen:
    begin
      FFinancingSource := fsMZ;
      FClass := ptEMER;
    end;
    vtSvoboden, vtNZOKBez:
    begin
      FFinancingSource := fsPatient;
    end;
    vtSkrining2024:
    begin
      FFinancingSource := fsMZ;
      FClass := ptAMB;
      FPurpose := pbSkrining;
    end;
    vtSkrining2024NZOK:
    begin
      FFinancingSource := fsNHIF;
      FClass := ptAMB;
      FPurpose := pbSkrining;
    end;
  end;
end;



procedure TRealNzisPregledNewItem.SetClass(const Value: TPregledType);
begin
  FClass := Value;
end;

procedure TRealNzisPregledNewItem.SetPurpose(const Value: TPurposeBase);
begin
  FPurpose := Value;
end;

end.

