unit DBCollection.Doctor;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls,
  system.Math, System.Generics.Collections, VirtualTrees;

type
  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  TUnfavItem = class(TCollectionItem)
  private
    FDoctorId: integer;
    FYear: word;
    FMonth: word;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property DoctorId: integer read FDoctorId write FDoctorId;
    property Month: word read FMonth write FMonth;
    property Year: word read FYear write FYear;
  end;

  TUnfavColl = class(TCollection)
    private
    FOwner : TComponent;
    FOnCurrentYearChange: TNotifyEvent;
    FCurrentYear: word;

    function GetItem(Index: Integer): TUnfavItem;
    procedure SetItem(Index: Integer; Value: TUnfavItem);
    procedure SetCurrentYear(const Value: word);
  protected
  public

    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    procedure SortByDoctorID;
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TUnfavItem read GetItem write SetItem;
    property CurrentYear: word read FCurrentYear write SetCurrentYear;
    property OnCurrentYearChange: TNotifyEvent read FOnCurrentYearChange write FOnCurrentYearChange;
  end;

  TDoctorItem = class(TCollectionItem)
  private
    FLName: string;
    FFName: string;
    FSName: string;
    FUin: string;
    FSpecialityNzis: Integer;
    FDoctorID: integer;
    FFullName: string;
    FNode: PVirtualNode;
    FSpecHip: string;
  public
    FListUnfav: TList<TUnfavItem>;
    FListUnfavDB: TList<TUnfavItem>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure FillFullName;

    property DoctorID: integer read FDoctorID write FDoctorID;
    property FName: string read FFName write FFName;
    property SName: string read FSName write FSName;
    property LName: string read FLName write FLName;
    property Uin: string read FUin write FUin;
    property SpecialityNzis: Integer read FSpecialityNzis write FSpecialityNzis;
    property SpecHip: string read FSpecHip write FSpecHip;
    property FullName: string read FFullName;
    property Node: PVirtualNode read FNode write FNode;
  end;

  TDoctorColl = class(TCollection)
    private
    FOwner : TComponent;
    FMaxLenDoctorName: integer;

    function GetItem(Index: Integer): TDoctorItem;
    procedure SetItem(Index: Integer; Value: TDoctorItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    procedure SortByID;
    function GetOwner : TPersistent; override;
    function MaxWidth(canvas: TCanvas): integer;
    property Items[Index: Integer]: TDoctorItem read GetItem write SetItem;
    property MaxLenDoctorName: integer read FMaxLenDoctorName;

  end;
implementation

{ TConsultationColl }

constructor TDoctorColl.Create(AOwner: TComponent);
begin
  inherited create(TDoctorItem);
  FOwner := AOwner;
  FMaxLenDoctorName := 0;
end;

destructor TDoctorColl.Destroy;
begin

  inherited;
end;

function TDoctorColl.GetItem(Index: Integer): TDoctorItem;
begin
  Result := TDoctorItem(inherited GetItem(Index));
end;

function TDoctorColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TDoctorColl.MaxWidth(canvas: TCanvas): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to count - 1 do
  begin
    result := max(result, canvas.TextWidth(items[i].FullName));
  end;
end;

procedure TDoctorColl.SetItem(Index: Integer; Value: TDoctorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDoctorColl.SortByID;
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
        while Items[I].FDoctorID < Items[P].FDoctorID do Inc(I);
        while Items[J].FDoctorID > Items[P].FDoctorID do Dec(J);
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

constructor TDoctorItem.Create(Collection: TCollection);
begin
  inherited;
  FListUnfav := TList<TUnfavItem>.Create;
  FListUnfavDB := TList<TUnfavItem>.Create;
  FListUnfav.Count := 120;
  FListUnfavDB.Count := 120;
end;

destructor TDoctorItem.Destroy;
begin
  FreeAndNil(FListUnfav);
  FreeAndNil(FListUnfavDB);
  inherited;
end;

procedure TDoctorItem.FillFullName;
begin
  FFullName := FFName + ' ' + FSname + ' ' + FLname;// + 'vdyebdenxuenuexexjexeixjex';
  TDoctorColl(collection).FMaxLenDoctorName := max(length(FFullName), TDoctorColl(collection).FMaxLenDoctorName);
end;

{ TUnfavItem }

constructor TUnfavItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TUnfavItem.Destroy;
begin

  inherited;
end;

{ TUnfavColl }

constructor TUnfavColl.Create(AOwner: TComponent);
begin
  inherited create(TUnfavItem);
  FOwner := AOwner;
end;

destructor TUnfavColl.Destroy;
begin

  inherited;
end;

function TUnfavColl.GetItem(Index: Integer): TUnfavItem;
begin
  Result := TUnfavItem(inherited GetItem(Index));
end;

function TUnfavColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TUnfavColl.SetCurrentYear(const Value: word);
begin
  FCurrentYear := Value;
  if assigned(FOnCurrentYearChange) then
  begin
    FOnCurrentYearChange(self);
  end;
end;

procedure TUnfavColl.SetItem(Index: Integer; Value: TUnfavItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TUnfavColl.SortByDoctorID;
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
        while Items[I].FDoctorID < Items[P].FDoctorID do Inc(I);
        while Items[J].FDoctorID > Items[P].FDoctorID do Dec(J);
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

end.
