unit DBCollection.Therapy;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math;

type
  TTherapyItem = class(TCollectionItem)
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  TTherapyColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TTherapyItem;
    procedure SetItem(Index: Integer; Value: TTherapyItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TTherapyItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TTherapyColl.Create(AOwner: TComponent);
begin
  inherited create(TTherapyItem);
  FOwner := AOwner;
end;

destructor TTherapyColl.Destroy;
begin

  inherited;
end;

function TTherapyColl.GetItem(Index: Integer): TTherapyItem;
begin
  Result := TTherapyItem(inherited GetItem(Index));
end;

function TTherapyColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TTherapyColl.SetItem(Index: Integer; Value: TTherapyItem);
begin
  inherited SetItem(Index, Value);
end;

{ TConsulatationItem }

constructor TTherapyItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TTherapyItem.Destroy;
begin

  inherited;
end;

end.

