unit InterruptibleSort;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TInterruptibleQuickSort<T> = class
  private
    FStopFlag: PBoolean;
    procedure QuickSortArray(var Arr: array of T;
      L, R: Integer; const CompareFunc: TFunc<T, T, Integer>);
    procedure QuickSortList(List: TList<T>;
      L, R: Integer; const CompareFunc: TFunc<T, T, Integer>);
  public
    constructor Create(StopFlag: PBoolean);
    procedure Sort(List: TList<T>; const CompareFunc: TFunc<T, T, Integer>);
    procedure SortArray(var Arr: array of T;
      const CompareFunc: TFunc<T, T, Integer>);
  end;


implementation

constructor TInterruptibleQuickSort<T>.Create(StopFlag: PBoolean);
begin
  FStopFlag := StopFlag;
end;

procedure TInterruptibleQuickSort<T>.QuickSortArray(var Arr: array of T;
  L, R: Integer; const CompareFunc: TFunc<T, T, Integer>);
var
  I, J, P: Integer;
  Pivot, Temp: T;
begin
  repeat
    if (FStopFlag <> nil) and FStopFlag^ then
      Exit;

    I := L;
    J := R;
    P := (L + R) shr 1;
    Pivot := Arr[P];

    repeat
      while CompareFunc(Arr[I], Pivot) < 0 do Inc(I);
      while CompareFunc(Arr[J], Pivot) > 0 do Dec(J);

      if I <= J then
      begin
        Temp := Arr[I];
        Arr[I] := Arr[J];
        Arr[J] := Temp;

        if P = I then P := J
        else if P = J then P := I;

        Inc(I);
        Dec(J);
      end;
    until I > J;

    if L < J then QuickSortArray(Arr, L, J, CompareFunc);
    L := I;
  until I >= R;
end;

procedure TInterruptibleQuickSort<T>.QuickSortList(List: TList<T>;
  L, R: Integer; const CompareFunc: TFunc<T, T, Integer>);
var
  I, J, P: Integer;
  Pivot, Temp: T;
begin
  repeat
    if (FStopFlag <> nil) and FStopFlag^ then
      Exit;

    I := L;
    J := R;
    P := (L + R) shr 1;
    Pivot := List[P];

    repeat
      while CompareFunc(List[I], Pivot) < 0 do Inc(I);
      while CompareFunc(List[J], Pivot) > 0 do Dec(J);

      if I <= J then
      begin
        Temp := List[I];
        List[I] := List[J];
        List[J] := Temp;

        if P = I then P := J
        else if P = J then P := I;

        Inc(I);
        Dec(J);
      end;
    until I > J;

    if L < J then QuickSortList(List, L, J, CompareFunc);
    L := I;
  until I >= R;
end;

procedure TInterruptibleQuickSort<T>.Sort(List: TList<T>;
  const CompareFunc: TFunc<T, T, Integer>);
begin
  if (List = nil) or (List.Count <= 1) then Exit;
  QuickSortList(List, 0, List.Count - 1, CompareFunc);
end;

procedure TInterruptibleQuickSort<T>.SortArray(var Arr: array of T;
  const CompareFunc: TFunc<T, T, Integer>);
begin
  if Length(Arr) <= 1 then Exit;
  QuickSortArray(Arr, 0, High(Arr), CompareFunc);
end;



end.

