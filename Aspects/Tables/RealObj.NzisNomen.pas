unit RealObj.NzisNomen;

interface
uses
  System.Generics.Collections, system.SysUtils, system.Classes,
  Aspects.Types, VirtualTrees,
  Table.CL024, Table.CL011, table.CL009,
  table.CL132, table.CL134, Table.PR001, table.CL050, table.cl142,
  table.cl088, Table.CL139, Table.CL144, Table.CL038, Table.CL037,
  Table.CL022, table.cl006,
  Table.NomenNzis;

type
  TCL133 = (CL133_none= 0, CL133_RiskFactors= 1, CL133_SocialDataPerson =2, CL133_FamilySocialData =3,
             CL133_NutritionalStatus = 4, CL133_Neuropsycholog0to12 = 5, CL133_Neuropsycholog13to36 = 6, CL133_Pregnancy = 7);

  TCL028 = (CL028_QN = 1, CL028_NOM = 2, CL028_NAR = 3, CL028_DATE = 4, CL028_BOOL = 5);

  TCL137 = (CL137_Pending = 1, CL137_PartiallyCompleted = 2, CL137_Completed = 3);
  //TCL087 = ()


TRealPR001Item = class;
TRealCl144Item = class;

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
    function GetCl136: string;
 public
   FListPr001: TList<TRealPR001Item>;
   FPatient: TObject;
   FPregled: TObject;
   FExamAnal: TObject;
   CL047: TStringList;
   test: string;
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
   procedure FindPregled(patNode: PVirtualNode; linkBuf, hipBuf: Pointer);
   property JoinKey: string read GetJoinKey;
   property StartDate: TDate read FStartDate write FStartDate;
   property EndDate: TDate read FEndDate write FEndDate;
   property CL136: string read GetCl136 write FCl136;
   property CL137: TCL137 read FCL137 write FCL137;

 end;
TRealCl006Item = class(TCL006Item)
  private
 public
 end;

 TRealCL006Coll = class(TCL006Coll)
 private
    function GetItem(Index: Integer): TRealCL006Item;
    procedure SetItem(Index: Integer; const Value: TRealCL006Item);

 public
   function GetDataPosFromKey(key: string): Cardinal;
   property Items[Index: Integer]: TRealCL006Item read GetItem write SetItem;

 end;

 TRealCl011Item = class(TCL011Item)
  private
 public
 end;

 TRealCL011Coll = class(TCL011Coll)
 private
    function GetItem(Index: Integer): TRealCL011Item;
    procedure SetItem(Index: Integer; const Value: TRealCL011Item);

 public
   function GetDataPosFromKey(key: string): Cardinal;
   property Items[Index: Integer]: TRealCL011Item read GetItem write SetItem;

 end;

 TRealCl009Item = class(TCL009Item)
  private
 public
 end;

 TRealCL009Coll = class(TCL009Coll)
 private
    function GetItem(Index: Integer): TRealCL009Item;
    procedure SetItem(Index: Integer; const Value: TRealCL009Item);

 public
   function GetDataPosFromKey(key: string): Cardinal;
   property Items[Index: Integer]: TRealCL009Item read GetItem write SetItem;

 end;

 TRealCl022Item = class(TCL022Item)
  private
 public
 end;

 TRealCL022Coll = class(TCL022Coll)
 private
    function GetItem(Index: Integer): TRealCL022Item;
    procedure SetItem(Index: Integer; const Value: TRealCL022Item);

 public
   function GetDataPosFromKey(key: string): Cardinal;
   procedure UpdateCL022;
   property Items[Index: Integer]: TRealCL022Item read GetItem write SetItem;

 end;

 TRealCl024Item = class(TCL024Item)
  private
 public
   //constructor Create(Collection: TCollection); override;
//   destructor destroy; override;
 end;

 TRealCL024Coll = class(TCL024Coll)
 private
    function GetItem(Index: Integer): TRealCL024Item;
    procedure SetItem(Index: Integer; const Value: TRealCL024Item);

 public
   procedure UpdateCL024;
   property Items[Index: Integer]: TRealCL024Item read GetItem write SetItem;

 end;

 TRealCl038Item = class(TCL038Item)
  private
 public
 end;

 TRealCL038Coll = class(TCL038Coll)
 private
    function GetItem(Index: Integer): TRealCL038Item;
    procedure SetItem(Index: Integer; const Value: TRealCL038Item);

 public
   procedure UpdateCL038;
   property Items[Index: Integer]: TRealCL038Item read GetItem write SetItem;

 end;

 TRealCl037Item = class(TCL037Item)
  private
 public
 end;

 TRealCL037Coll = class(TCL037Coll)
 private
    function GetItem(Index: Integer): TRealCL037Item;
    procedure SetItem(Index: Integer; const Value: TRealCL037Item);

 public
   procedure UpdateCL037;
   property Items[Index: Integer]: TRealCL037Item read GetItem write SetItem;

 end;

 TRealCL132Coll = class(TCL132Coll)
  private
    function GetItem(Index: Integer): TRealCL132Item;
    procedure SetItem(Index: Integer; const Value: TRealCL132Item);

 public
   procedure SortByDataPos;
   procedure UpdateCL132;
   property Items[Index: Integer]: TRealCL132Item read GetItem write SetItem;

 end;

 TRealCl134Item = class(TCL134Item)
 public

   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

  TRealCL134Coll = class(TCL134Coll)
  private
    function GetItem(Index: Integer): TRealCl134Item;
    procedure SetItem(Index: Integer; const Value: TRealCl134Item);

  public
    procedure UpdateCL134;
    procedure sortListByKey(lst: TList<TRealCL134Item>);
    property Items[Index: Integer]: TRealCl134Item read GetItem write SetItem;

 end;

 TRealCl139Item = class(TCL139Item)
 public
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

  TRealCL139Coll = class(TCL139Coll)
  private
    function GetItem(Index: Integer): TRealCl139Item;
    procedure SetItem(Index: Integer; const Value: TRealCl139Item);
  public
    procedure UpdateCL139;
    function GetDataPosFromKey(key: string): Cardinal;
    property Items[Index: Integer]: TRealCl139Item read GetItem write SetItem;

 end;

 TRealCl088Item = class(TCL088Item)
  private
 public
   CL138: TStringList;
   FItemUp: TRealCl088Item;
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

 TRealCL088Coll = class(TCL088Coll)
 private
    function GetItem(Index: Integer): TRealCL088Item;
    procedure SetItem(Index: Integer; const Value: TRealCL088Item);

 public
   FCL088New: TRealCL088Coll;
   procedure SortByKeyRec;
   procedure CompareUpdate;
   procedure UpdateCL088;
   property Items[Index: Integer]: TRealCL088Item read GetItem write SetItem;

 end;

 TRealCl142Item = class(TCL142Item)
  private
 public
   FListCL088: TList<TRealCL088Item>;
   FListCL144: TList<TRealCL144Item>;

   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

 TRealCL142Coll = class(TCL142Coll)
  private
    function GetItem(Index: Integer): TRealCL142Item;
    procedure SetItem(Index: Integer; const Value: TRealCL142Item);
    function GetDataPosFromKey(key: string): Cardinal;
    function Get144DataPosFromKey(key: string): Cardinal;

 public
   procedure UpdateCL142;
   property Items[Index: Integer]: TRealCL142Item read GetItem write SetItem;

 end;

 TRealCl144Item = class(TCL144Item)
  private
 public
   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
 end;

 TRealCL144Coll = class(TCL144Coll)
  private
    function GetItem(Index: Integer): TRealCL144Item;
    procedure SetItem(Index: Integer; const Value: TRealCL144Item);

 public
   procedure UpdateCL144;
   property Items[Index: Integer]: TRealCL144Item read GetItem write SetItem;

 end;

  TRealPR001Item = class(TPr001Item)
  private
    FRules: string;
    procedure SetRules(const Value: string);
 public
   CL133: TCL133;
   CL142: TRealCl142Item;
   FExamAnal: TObject;
   LstCl134: TList<TRealCl134Item>;

   constructor Create(Collection: TCollection); override;
   destructor destroy; override;
   //procedure GenerateMedNapr(mednapr)

   property Rules: string read FRules write SetRules;

 end;

 TRealPR001Coll = class(TPR001Coll)
  private
    function GetItem(Index: Integer): TRealPR001Item;
    procedure SetItem(Index: Integer; const Value: TRealPR001Item);

 public
   procedure SortListByActId(lst: TList<TRealPR001Item>);
   procedure sortByCl134(col134: TRealCL134Coll);
   procedure UpdatePr001;
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

procedure TRealCL132Coll.UpdateCL132;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl132: TRealCl132Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl132 := Items[i];
    if Cl132.PRecord <> nil then
    begin
      Cl132.SaveCL132(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
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
  cl047 := TStringList.Create;
  CL047.Text :=
      'Консултация' + #13#10 +
      'Обща профилактика' + #13#10 +
      'Детско здраве' + #13#10 +
      'Майчино здраве' + #13#10 +
      'Профилактика нa пълнолетни лица' + #13#10 +
      'Профилактика на лица с рискови фактори' + #13#10 +
      'Диспансерен преглед' + #13#10 +
      'Високо-специализирана дейност' + #13#10 +
      'Рецепта на хоспитализирано лице' + #13#10 +
      'Експертиза на работоспособността' + #13#10 +
      'По искане на ТЕЛК' + #13#10 +
      'Скрийнинг';

end;

destructor TRealCl132Item.destroy;
begin
  if Assigned (FListPr001) then
  begin
    FListPr001.Clear;
  end;
  FreeAndNil(FListPr001);
  FreeAndNil(FExamAnal);
  CL047.Free;
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
    Result := Self.getAnsiStringMap(TRealCL132Coll(Collection).Buf, TRealCL132Coll(Collection).posData, word(CL132_cl136));
  end;
end;

function TRealCl132Item.GetJoinKey: string;
begin
 // Result := getAnsiStringMap(TRealCL132Coll(Collection).Buf, TRealCL132Coll(Collection).posData, word(CL132_Key)) +

end;

{ TRealPR001Item }

constructor TRealPR001Item.Create(Collection: TCollection);
begin
  inherited;
  //CL050 := nil;
  CL142 := nil;
  CL133 := CL133_none;
  LstCl134  := TList<TRealCl134Item>.create;
  FExamAnal := nil;
end;

destructor TRealPR001Item.destroy;
begin
  LstCl134.Clear;
  FreeAndNil(LstCl134);
  FreeAndNil(FExamAnal);
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

procedure TRealPR001Coll.sortByCl134(col134: TRealCL134Coll);
var
  i: Integer;
  pr001: TRealPR001Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    pr001 := Self.Items[i];
    col134.sortListByKey(pr001.LstCl134);
    //pr001.LstCl134.
  end;
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

procedure TRealPR001Coll.UpdatePr001;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  PR001: TRealPR001Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    PR001 := Items[i];
    if PR001.PRecord <> nil then
    begin
      PR001.SavePR001(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
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
  FListCL144 := TList<TRealCL144Item>.create;
end;

destructor TRealCl142Item.destroy;
begin
  FreeAndNil(FListCL088);
  FreeAndNil(FListCL144);
  inherited;
end;

{ TRealCL142Coll }

function TRealCL142Coll.Get144DataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL139_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL142Coll.GetDataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL142_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL142Coll.GetItem(Index: Integer): TRealCL142Item;
begin
  Result := TRealCL142Item(inherited GetItem(Index));
end;

procedure TRealCL142Coll.SetItem(Index: Integer; const Value: TRealCL142Item);
begin
  inherited SetItem(Index, Value);

end;

procedure TRealCL142Coll.UpdateCL142;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl142: TRealCl142Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl142 := Items[i];
    if Cl142.PRecord <> nil then
    begin
      Cl142.SaveCL142(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
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

procedure TRealCL088Coll.CompareUpdate;
var
  i, j: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if Self.getAnsiStringMap(Items[i].DataPos, word(CL088_Description)) <>
       Items[i].FItemUp.PRecord.Description then
    begin

    end;
    if Self.getAnsiStringMap(Items[i].DataPos, word(CL088_DescriptionEn)) <>
       Items[i].FItemUp.PRecord.DescriptionEn then
    begin

    end;
  end;
end;

function TRealCL088Coll.GetItem(Index: Integer): TRealCL088Item;
begin
  Result := TRealCL088Item(inherited GetItem(Index));
end;

procedure TRealCL088Coll.SetItem(Index: Integer; const Value: TRealCL088Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL088Coll.SortByKeyRec;
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
        while ((Items[I]).PRecord.Key) < ((Items[P]).PRecord.Key) do Inc(I);
        while ((Items[J]).PRecord.Key) > ((Items[P]).PRecord.Key) do Dec(J);
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

procedure TRealCL088Coll.UpdateCL088;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl088: TRealCl088Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl088 := Items[i];
    if Cl088.PRecord <> nil then
    begin
      Cl088.SaveCL088(dataPosition);
      Self.CmdFile.CopyFromCmdStream(self.streamComm, false);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;


{ TRealCl134Item }

constructor TRealCl134Item.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TRealCl134Item.destroy;
begin

  inherited;
end;

{ TRealCL134Coll }

function TRealCL134Coll.GetItem(Index: Integer): TRealCl134Item;
begin
  Result := TRealCl134Item(inherited GetItem(Index));
end;

procedure TRealCL134Coll.SetItem(Index: Integer; const Value: TRealCl134Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL134Coll.sortListByKey(lst: TList<TRealCL134Item>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TRealCl134Item;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while lst[I].getAnsiStringMap(Self.Buf, Self.posData, word(CL134_Key)) < lst[P].getAnsiStringMap(Self.Buf, Self.posData, word(CL134_Key)) do Inc(I);
        while lst[J].getAnsiStringMap(Self.Buf, Self.posData, word(CL134_Key)) > lst[P].getAnsiStringMap(Self.Buf, Self.posData, word(CL134_Key)) do Dec(J);
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

procedure TRealCL134Coll.UpdateCL134;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl134: TRealCl134Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl134 := Items[i];
    if Cl134.PRecord <> nil then
    begin
      Cl134.SaveCL134(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealCl139Item }

constructor TRealCl139Item.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TRealCl139Item.destroy;
begin

  inherited;
end;

{ TRealCL139Coll }

function TRealCL139Coll.GetDataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL139_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL139Coll.GetItem(Index: Integer): TRealCl139Item;
begin
  Result := TRealCl139Item(inherited GetItem(Index));
end;

procedure TRealCL139Coll.SetItem(Index: Integer; const Value: TRealCl139Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL139Coll.UpdateCL139;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl139: TRealCl139Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl139 := Items[i];
    if Cl139.PRecord <> nil then
    begin
      Cl139.SaveCL139(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;


{ TRealCl144Item }

constructor TRealCl144Item.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TRealCl144Item.destroy;
begin

  inherited;
end;

{ TRealCL144Coll }

function TRealCL144Coll.GetItem(Index: Integer): TRealCL144Item;
begin
  Result := TRealCl144Item(inherited GetItem(Index));
end;

procedure TRealCL144Coll.SetItem(Index: Integer; const Value: TRealCL144Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL144Coll.UpdateCL144;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl144: TRealCl144Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl144 := Items[i];
    if Cl144.PRecord <> nil then
    begin
      Cl144.SaveCL144(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealCL024Coll }

function TRealCL024Coll.GetItem(Index: Integer): TRealCL024Item;
begin
  Result := TRealCL024Item(inherited GetItem(Index));
end;

procedure TRealCL024Coll.SetItem(Index: Integer; const Value: TRealCL024Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL024Coll.UpdateCL024;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl024: TRealCl024Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl024 := Items[i];
    if Cl024.PRecord <> nil then
    begin
      Cl024.SaveCL024(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;


{ TRealCL038Coll }

function TRealCL038Coll.GetItem(Index: Integer): TRealCL038Item;
begin
  Result := TRealCl038Item(inherited GetItem(Index));
end;

procedure TRealCL038Coll.SetItem(Index: Integer; const Value: TRealCL038Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL038Coll.UpdateCL038;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl038: TRealCl038Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl038 := Items[i];
    if Cl038.PRecord <> nil then
    begin
      Cl038.SaveCL038(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealCL037Coll }

function TRealCL037Coll.GetItem(Index: Integer): TRealCL037Item;
begin
  Result := TRealCl037Item(inherited GetItem(Index));

end;

procedure TRealCL037Coll.SetItem(Index: Integer; const Value: TRealCL037Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL037Coll.UpdateCL037;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl037: TRealCl037Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl037 := Items[i];
    if Cl037.PRecord <> nil then
    begin
      Cl037.SaveCL037(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealCL022Coll }

function TRealCL022Coll.GetDataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL022_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL022Coll.GetItem(Index: Integer): TRealCL022Item;
begin
  Result := TRealCl022Item(inherited GetItem(Index));
end;

procedure TRealCL022Coll.SetItem(Index: Integer; const Value: TRealCL022Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealCL022Coll.UpdateCL022;
var
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt, i: Integer;
  Cl022: TRealCl022Item;

begin
  cnt := 0;
  pCardinalData := pointer(PByte(Buf) + 12);
  dataPosition := pCardinalData^ + self.posData;
  for i := 0 to Count - 1 do
  begin
    Cl022 := Items[i];
    if Cl022.PRecord <> nil then
    begin
      Cl022.SaveCL022(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Buf) + 12);
    pCardinalData^  := dataPosition - self.PosData;
  end;
end;

{ TRealCL006Coll }

function TRealCL006Coll.GetDataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL006_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL006Coll.GetItem(Index: Integer): TRealCL006Item;
begin
  Result := TRealCl006Item(inherited GetItem(Index));
end;

procedure TRealCL006Coll.SetItem(Index: Integer; const Value: TRealCL006Item);
begin
  inherited SetItem(Index, Value);
end;



{ TRealCL011Coll }

function TRealCL011Coll.GetDataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL011_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL011Coll.GetItem(Index: Integer): TRealCL011Item;
begin
  Result := TRealCl011Item(inherited GetItem(Index));
end;

procedure TRealCL011Coll.SetItem(Index: Integer; const Value: TRealCL011Item);
begin
  inherited SetItem(Index, Value);
end;

{ TRealCL009Coll }

function TRealCL009Coll.GetDataPosFromKey(key: string): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].getAnsiStringMap(Self.Buf, Self.posData, Word(CL009_Key)) = key then
    begin
      Result := Items[i].DataPos;
      Exit;
    end;
  end;
end;

function TRealCL009Coll.GetItem(Index: Integer): TRealCL009Item;
begin
  Result := TRealCl009Item(inherited GetItem(Index));
end;

procedure TRealCL009Coll.SetItem(Index: Integer; const Value: TRealCL009Item);
begin
  inherited SetItem(Index, Value);
end;

end.
