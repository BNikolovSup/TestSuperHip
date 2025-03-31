unit DBCollection.Diagnosis;

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

  TDiagnosisItem = class(TCollectionItem)
  private
    FMKB: string;
    FNameMKB: string;
    FNote: string;
    FPregID: Integer;
    FRank: Integer;
    FIsMain: Boolean;
    FAddMkb: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property PregID: Integer read FPregID write FPregID;
    property Rank: Integer read FRank write FRank;
    property IsMain: Boolean read FIsMain write FIsMain;
    property MKB: string read FMKB write FMKB;
    property AddMkb: string read FAddMkb write FAddMkb;
    property NameMKB: string read FNameMKB write FNameMKB;
    property Note: string read FNote write FNote;
  end;

  TDiagnosisColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TDiagnosisItem;
    procedure SetItem(Index: Integer; Value: TDiagnosisItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    procedure SortByMKB;
    procedure SortListByMkb(list: TList<TDiagnosisItem>);
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TDiagnosisItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TDiagnosisColl.Create(AOwner: TComponent);
begin
  inherited create(TDiagnosisItem);
  FOwner := AOwner;
end;

destructor TDiagnosisColl.Destroy;
begin

  inherited;
end;

function TDiagnosisColl.GetItem(Index: Integer): TDiagnosisItem;
begin
  Result := TDiagnosisItem(inherited GetItem(Index));
end;

function TDiagnosisColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TDiagnosisColl.SetItem(Index: Integer; Value: TDiagnosisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDiagnosisColl.SortByMKB;
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
        while (Items[I]).MKB < (Items[P]).MKB do Inc(I);
        while (Items[J]).MKB > (Items[P]).MKB do Dec(J);
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

procedure TDiagnosisColl.SortListByMkb(list: TList<TDiagnosisItem>);
  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TDiagnosisItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (list[I]).MKB < (list[P]).MKB do Inc(I);
        while (list[J]).MKB > (list[P]).MKB do Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] := list[J];
          list[J] := Save;
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
    QuickSort(0,count-1);
  end;
end;

{ TConsulatationItem }

constructor TDiagnosisItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TDiagnosisItem.Destroy;
begin

  inherited;
end;

end.
