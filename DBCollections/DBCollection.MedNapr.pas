unit DBCollection.MedNapr;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections;

type
  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  TMedNaprItem = class(TCollectionItem)
  private
    FPregledID: Integer;
    FIdMedNapr: Integer;
    FNumber: Integer;
  public
    FPregled: TObject;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property PregledID: Integer read FPregledID  write FPregledID;
    property IdMedNapr: Integer read FIdMedNapr write FIdMedNapr;
    property Number: Integer read FNumber write FNumber;
  end;

  TMedNaprColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TMedNaprItem;
    procedure SetItem(Index: Integer; Value: TMedNaprItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;

    procedure SortByPregledID;

    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TMedNaprItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TMedNaprColl.Create(AOwner: TComponent);
begin
  inherited create(TMedNaprItem);
  FOwner := AOwner;
end;

destructor TMedNaprColl.Destroy;
begin

  inherited;
end;

function TMedNaprColl.GetItem(Index: Integer): TMedNaprItem;
begin
  Result := TMedNaprItem(inherited GetItem(Index));
end;

function TMedNaprColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TMedNaprColl.SetItem(Index: Integer; Value: TMedNaprItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TMedNaprColl.SortByPregledID;
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
        while (Items[I]).FPregledID < (Items[P]).FPregledID do Inc(I);
        while (Items[J]).FPregledID > (Items[P]).FPregledID do Dec(J);
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

{ TConsulatationItem }

constructor TMedNaprItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TMedNaprItem.Destroy;
begin

  inherited;
end;

end.

