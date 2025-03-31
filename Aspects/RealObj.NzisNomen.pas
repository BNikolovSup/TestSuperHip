unit RealObj.NzisNomen;

interface
uses
  System.Generics.Collections, system.SysUtils, system.Classes,
  Aspects.Types, VirtualTrees,
  table.CL132, table.CL134, Table.PR001, table.CL050, table.cl142,
  table.cl088,
  Table.NomenNzis;

type
  TCL133 = (CL133_none= 0, CL133_RiskFactors= 1, CL133_SocialDataPerson =2, CL133_FamilySocialData =3,
             CL133_NutritionalStatus = 4, CL133_Neuropsycholog0to12 = 5, CL133_Neuropsycholog13to36 = 6, CL133_Pregnancy = 7);

  TCL028 = (CL028_QN = 1, CL028_NOM = 2, CL028_NAR = 3, CL028_DATE = 4, CL028_BOOL = 5);

  TCL137 = (CL137_Pending = 1, CL137_PartiallyCompleted = 2, CL137_Completed = 3);


TRealPR001Item = class;

TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;


 TRealCl132Item = class(TCL132Item)
  private
    FJoinKey: string;
    FCl136: string;
    FCL137: TCL137;
    FStartDate: TDate;
    FEndDate: TDate;
    function GetJoinKey: string;
    function GetStartDate: TDate;
    function GetCl136: string;
 public
   FListPr001: TList<TRealPR001Item>;
   FPatient: TObject;
   FPregled: TObject;
   FExamAnal: TObject;
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
   procedure FindPregled(patNode: PVirtualNode; linkBuf, hipBuf: Pointer);
   property JoinKey: string read GetJoinKey;
   property StartDate: TDate read FStartDate write FStartDate;
   property EndDate: TDate read FEndDate write FEndDate;
   property CL136: string read GetCl136 write FCl136;
   property CL137: TCL137 read FCL137 write FCL137;
   //property Nomen: T
 end;

 TRealCL132Coll = class(TCL132Coll)
  private
    function GetItem(Index: Integer): TRealCL132Item;
    procedure SetItem(Index: Integer; const Value: TRealCL132Item);

 public
   procedure SortByDataPos;
   property Items[Index: Integer]: TRealCL132Item read GetItem write SetItem;

 end;

 TRealCl088Item = class(TCL088Item)
  private
 public
   CL138: TStringList;
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

 TRealCL088Coll = class(TCL088Coll)
  private
    function GetItem(Index: Integer): TRealCL088Item;
    procedure SetItem(Index: Integer; const Value: TRealCL088Item);

 public
   property Items[Index: Integer]: TRealCL088Item read GetItem write SetItem;

 end;

 TRealCl142Item = class(TCL142Item)
  private
 public
   FListCL088: TList<TRealCL088Item>;

   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

 TRealCL142Coll = class(TCL142Coll)
  private
    function GetItem(Index: Integer): TRealCL142Item;
    procedure SetItem(Index: Integer; const Value: TRealCL142Item);

 public
   property Items[Index: Integer]: TRealCL142Item read GetItem write SetItem;

 end;

  TRealPR001Item = class(TPr001Item)
  private
    FRules: string;
    procedure SetRules(const Value: string);
 public
   CL050: TCL050Item;
   CL133: TCL133;
   CL142: TRealCl142Item;
   FExamAnal: TObject;
   LstCl134: TList<TCl134Item>;

   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
   //procedure ProcRules(vid: TVtrVid);
   property Rules: string read FRules write SetRules;

 end;

 TRealPR001Coll = class(TPR001Coll)
  private
    function GetItem(Index: Integer): TRealPR001Item;
    procedure SetItem(Index: Integer; const Value: TRealPR001Item);

 public
   procedure SortListByActId(lst: TList<TRealPR001Item>);
   property Items[Index: Integer]: TRealPR001Item read GetItem write SetItem;

 end;

  TRealNomenNzisItem = class(TNomenNzisItem)
 public
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

 TRealNomenNzisColl = class(TNomenNzisColl)
  private
    function GetItem(Index: Integer): TRealNomenNzisItem;
    procedure SetItem(Index: Integer; const Value: TRealNomenNzisItem);

 public
   property Items[Index: Integer]: TRealNomenNzisItem read GetItem write SetItem;

 end;



implementation
uses
  RealObj.RealHipp;
{ TRealCL132Coll }

function TRealCL132Coll.GetItem(Index: Integer): TRealCL132Item;
begin
   Result := TRealCL132Item(inherited GetItem(Index));
end;

procedure TRealCL132Coll.SetItem(Index: Integer; const Value: TRealCL132Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL132Coll.SortByDataPos;
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
        while ((Items[I]).FDataPos) < ((Items[P]).FDataPos) do Inc(I);
        while ((Items[J]).FDataPos) > ((Items[P]).FDataPos) do Dec(J);
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

{ TRealCl132Item }

constructor TRealCl132Item.Create(Collection: TCollection);
begin
  inherited;
  FJoinKey := '';
  FCl136 := '';
  FListPr001 := TList<TRealPR001Item>.Create;
  FPatient := nil;
  FPregled := nil;
  FExamAnal := nil;

end;

destructor TRealCl132Item.destroy;
begin
  FreeAndNil(FListPr001);
  inherited;
end;

procedure TRealCl132Item.FindPregled(patNode: PVirtualNode; linkBuf, hipBuf: Pointer);
var
  pat: TRealPatientNewItem;
  pregNode: PVirtualNode;
begin
  pregNode := patNode.FirstChild;
  while pregNode <> nil do
  begin

    pregNode := pregNode.NextSibling;
  end;
end;

function TRealCl132Item.GetCl136: string;
begin
  if FCl136 <> '' then
  begin
    Result := FCl136;
  end
  else
  begin
    Result := Self.getAnsiStringMap(TRealCL132Coll(Collection).Buf, TRealCL132Coll(Collection).posData, word(CL132_CL136_Mapping));
  end;
end;

function TRealCl132Item.GetJoinKey: string;
begin
 // Result := getAnsiStringMap(TRealCL132Coll(Collection).Buf, TRealCL132Coll(Collection).posData, word(CL132_Key)) +

end;

function TRealCl132Item.GetStartDate: TDate;
var
  key: string;
begin
  Result := 0;
  Exit;
  key := Self.getAnsiStringMap(TRealCL132Coll(Collection).Buf, TRealCL132Coll(Collection).posData, word(CL132_Key));
  if key = 'C61' then
  begin
    key := 'C61';
    Result := Date + 200*365 ;
  end;
end;

{ TRealPR001Item }

constructor TRealPR001Item.Create(Collection: TCollection);
begin
  inherited;
  CL050 := nil;
  CL142 := nil;
  CL133 := CL133_none;
  LstCl134  := TList<TCl134Item>.create;
  FExamAnal := nil;
end;

destructor TRealPR001Item.destroy;
begin
  FreeAndNil(LstCl134);
  inherited;
end;

procedure TRealPR001Item.SetRules(const Value: string);
var
  ArrStr: TArray<string>;
begin
  //if Value = '' then Exit;

  //ArrStr := value.Split()
  FRules := Value;
end;

{ TRealPR001Coll }

function TRealPR001Coll.GetItem(Index: Integer): TRealPR001Item;
begin
  Result := TRealPR001Item(inherited GetItem(Index));
end;

procedure TRealPR001Coll.SetItem(Index: Integer; const Value: TRealPR001Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealPR001Coll.SortListByActId(lst: TList<TRealPR001Item>);

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TRealPR001Item;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while lst[I].getAnsiStringMap(Self.Buf, Self.posData, word(PR001_Activity_ID)) < lst[P].getAnsiStringMap(Self.Buf, Self.posData, word(PR001_Activity_ID)) do Inc(I);
        while lst[J].getAnsiStringMap(Self.Buf, Self.posData, word(PR001_Activity_ID)) > lst[P].getAnsiStringMap(Self.Buf, Self.posData, word(PR001_Activity_ID)) do Dec(J);
        if I <= J then begin
          Save := lst[I];
          lst[I] := lst[J];
          lst[J] := Save;
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
  if (lst.count >1 ) then
  begin
    QuickSort(0,lst.count-1);
  end;
end;

{ TRealNomenNzisItem }

constructor TRealNomenNzisItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TRealNomenNzisItem.destroy;
begin

  inherited;
end;

{ TRealNomenNzisColl }

function TRealNomenNzisColl.GetItem(Index: Integer): TRealNomenNzisItem;
begin
  Result := TRealNomenNzisItem(inherited GetItem(Index));
end;

procedure TRealNomenNzisColl.SetItem(Index: Integer; const Value: TRealNomenNzisItem);
begin
  inherited SetItem(Index, Value);
end;


{ TRealCl142Item }

constructor TRealCl142Item.Create(Collection: TCollection);
begin
  inherited;
  FListCL088  := TList<TRealCL088Item>.Create;
end;

destructor TRealCl142Item.destroy;
begin
  FreeAndNil(FListCL088);
  inherited;
end;

{ TRealCL142Coll }

function TRealCL142Coll.GetItem(Index: Integer): TRealCL142Item;
begin
  Result := TRealCL142Item(inherited GetItem(Index));
end;

procedure TRealCL142Coll.SetItem(Index: Integer; const Value: TRealCL142Item);
begin
  inherited SetItem(Index, Value);
end;

{ TRealCl088Item }

constructor TRealCl088Item.Create(Collection: TCollection);
begin
  inherited;
  cl138 := TStringList.Create;
  CL138.Text :=
      'Резултат от физикален преглед' + #13#10 +
      'Оценка на нервно-психическото развитие' + #13#10 +
      'Стадий на Танер' + #13#10 +
      'Оценка на физическото развитие' + #13#10 +
      'Развитие на зъби' + #13#10 +
      'Образование' + #13#10 +
      'Битово-санитарни условия' + #13#10 +
      'Статус на кърмене' + #13#10 +
      'Режим на кърмене' + #13#10 +
      'Метод на ентерално хранене' + #13#10 +
      'Прием на течности' + #13#10 +
      'Готовност за захранване' + #13#10 +
      'Захранващи и допълнителни храни' + #13#10 +
      'Отговор на пациента към здравна информация';
end;

destructor TRealCl088Item.destroy;
begin
  CL138.Free;
  inherited;
end;

{ TRealCL088Coll }

function TRealCL088Coll.GetItem(Index: Integer): TRealCL088Item;
begin
  Result := TRealCL088Item(inherited GetItem(Index));
end;

procedure TRealCL088Coll.SetItem(Index: Integer; const Value: TRealCL088Item);
begin
  inherited SetItem(Index, Value);
end;

end.
