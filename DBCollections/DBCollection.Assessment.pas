unit DBCollection.Assessment;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math;

type
  TAssessmentItem = class(TCollectionItem)
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  TAssessmentColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TAssessmentItem;
    procedure SetItem(Index: Integer; Value: TAssessmentItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TAssessmentItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TAssessmentColl.Create(AOwner: TComponent);
begin
  inherited create(TAssessmentItem);
  FOwner := AOwner;
end;

destructor TAssessmentColl.Destroy;
begin

  inherited;
end;

function TAssessmentColl.GetItem(Index: Integer): TAssessmentItem;
begin
  Result := TAssessmentItem(inherited GetItem(Index));
end;

function TAssessmentColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TAssessmentColl.SetItem(Index: Integer; Value: TAssessmentItem);
begin
  inherited SetItem(Index, Value);
end;

{ TConsulatationItem }

constructor TAssessmentItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TAssessmentItem.Destroy;
begin

  inherited;
end;

end.
