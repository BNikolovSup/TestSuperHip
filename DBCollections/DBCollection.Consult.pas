unit DBCollection.Consult;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections,
  DBCollection.Addres, DBCollection.Assessment, DBCollection.Diagnosis,
  DBCollection.Doctor, DBCollection.Patient, DBCollection.Therapy

  ;

type
  TConsulatationItem = class(TCollectionItem)
  private
  public
    FDoctor: TDoctorItem;
    FPatient: TPatientItem;
    //FUdost: TUdostovItem;

    FAddreses: TList<TAddresItem>;
    FDiagnosis: TList<TDiagnosisItem>;
    FAssessments: TList<TAssessmentItem>;
    FTherapyes: TList<TTherapyItem>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;


  end;

  TConsultationColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TConsulatationItem;
    procedure SetItem(Index: Integer; Value: TConsulatationItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TConsulatationItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TConsultationColl.Create(AOwner: TComponent);
begin
  inherited create(TConsulatationItem);
  FOwner := AOwner;

end;

destructor TConsultationColl.Destroy;
begin

  inherited;
end;

function TConsultationColl.GetItem(Index: Integer): TConsulatationItem;
begin
  Result := TConsulatationItem(inherited GetItem(Index));
end;

function TConsultationColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TConsultationColl.SetItem(Index: Integer; Value: TConsulatationItem);
begin
  inherited SetItem(Index, Value);
end;

{ TConsulatationItem }

constructor TConsulatationItem.Create(Collection: TCollection);
begin
  inherited;
  FAddreses := TList<TAddresItem>.Create;
  FDiagnosis := TList<TDiagnosisItem>.Create;
  FAssessments := TList<TAssessmentItem>.Create;
  FTherapyes := TList<TTherapyItem>.Create;
end;

destructor TConsulatationItem.Destroy;
begin
  FreeAndNil(FAddreses);
  FreeAndNil(FDiagnosis);
  FreeAndNil(FAssessments);
  FreeAndNil(FTherapyes);

  inherited;
end;

end.
