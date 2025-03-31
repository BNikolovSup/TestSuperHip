unit NZISSuperAddress;

interface
uses
  System.Classes, System.Generics.Collections, system.SysUtils, System.StrUtils;


type
  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;



  TOblastItem = class(TCollectionItem)
  private
    FOblName: string;
    FOblId: integer;
    function GetOblNzis: string;
  public
    Obshtini: TList;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property OblName: string read FOblName write FOblName;
    property OblID: integer read FOblId write FOblID;
    property OblNzis: string read GetOblNzis;
end;

  TOblastCollection = class(TCollection)
  private
    FOwner : TComponent;
  protected
    function GetOwner : TPersistent; override;
    function GetItem(Index: Integer): TOblastItem;
    procedure SetItem(Index: Integer; Value: TOblastItem);
  public
    constructor Create(AOwner : TComponent);
    procedure LoadFromFile(FileName: string);
    procedure SortByID;
    property Items[Index: Integer]: TOblastItem read GetItem write SetItem;
  end;

  TObshtinaItem = class(TCollectionItem)
  private
    FObshName: string;
    FObshId: integer;
    FRZOKR: string;
    FOblId: Integer;
  public
    FObl: TOblastItem;
    NasMesta: TList;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

  published
    property ObshName: string read FObshName write FObshName;
    property ObshID: integer read FObshId write FObshID;
    property OblID: Integer read FOblId write FOblID;
    property RZOKR: string read FRZOKR write FRZOKR;
end;

  TObshtinaCollection = class(TCollection)
  private
    FOwner : TComponent;
  protected
    function GetOwner : TPersistent; override;
    function GetItem(Index: Integer): TObshtinaItem;
    procedure SetItem(Index: Integer; Value: TObshtinaItem);
  public
    constructor Create(AOwner : TComponent);
    procedure LoadFromFile(FileName: string);
    procedure SortByOblIDAndID;
    procedure SortByOblId;
    procedure SortByOblId_RZOKR;
    procedure FillObshtinaInOblast(obl: TOblastCollection);
    property Items[Index: Integer]: TObshtinaItem read GetItem write SetItem;
  end;

  TNasMestoItem = class(TCollectionItem)
  private
    FNasMestoName: string;
    FObshId: integer;
    FOblId: Integer;
    FEKATTE: string;
    FZIP: string;
  public
    FObl: TOblastItem;
    FObsh: TObshtinaItem;
  published
    property NasMestoName: string read FNasMestoName write FNasMestoName;
    property ObshID: integer read FObshId write FObshID;
    property OblID: Integer read FOblId write FOblID;
    property EKATTE: string read FEKATTE write FEKATTE;
    property ZIP: string read FZIP write FZIP;
end;

  TNasMestoCollection = class(TCollection)
  private
    FOwner : TComponent;
  protected
    function GetOwner : TPersistent; override;
    function GetItem(Index: Integer): TNasMestoItem;
    procedure SetItem(Index: Integer; Value: TNasMestoItem);
  public
    constructor Create(AOwner : TComponent);
    procedure LoadFromFile(FileName: string);
    procedure FillNasMestoInObshtina(obsh: TObshtinaCollection; obl: TOblastCollection);
    procedure SortByOblIDObshID;
    procedure SortByNameAndEKT;
    procedure SortByNamOblObsht;
    property Items[Index: Integer]: TNasMestoItem read GetItem write SetItem;

    function NasMestoFromName(oblName, ObshName, nasMestoName: string): TNasMestoItem ;
    function IndexNasMestoFromName(oblName, ObshName, nasMestoName: string): integer ;
  end;




implementation

{ TOblastCollection }

constructor TOblastCollection.Create(AOwner: TComponent);
begin
  inherited Create(TOblastItem);
  FOwner := AOwner;
end;

function TOblastCollection.GetItem(Index: Integer): TOblastItem;
begin
  Result := TOblastItem(inherited GetItem(Index));
end;

function TOblastCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TOblastCollection.LoadFromFile(FileName: string);
var
  ls: TStringList;
  i: Integer;
  line: string;
  arrStr: TArray<string> ;
  obl: TOblastItem;
begin
  Clear;
  ls := TStringList.Create;
  ls.LoadFromFile(FileName);
  for i := 0 to ls.Count - 1 do
  begin
    line := ls[i];
    if line = EmptyStr then Continue;
    arrStr := line.Split([#9]);
    obl := TOblastItem(Add);
    obl.FOblId := StrToInt(arrStr[0]);
    obl.FOblName := arrStr[1];
  end;
  ls.Free;
end;

procedure TOblastCollection.SetItem(Index: Integer; Value: TOblastItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TOblastCollection.SortByID;
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
        while Items[I].FOblId < Items[P].FOblId do Inc(I);
        while Items[J].FOblId > Items[P].FOblId do Dec(J);
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

{ TObshtinaCollection }

constructor TObshtinaCollection.Create(AOwner: TComponent);
begin
  inherited Create(TObshtinaItem);
  FOwner := AOwner;
end;

procedure TObshtinaCollection.FillObshtinaInOblast(obl: TOblastCollection);
var
  iObsh, iObl: integer;
begin
  iObsh := 0;
  iObl := 0;
  SortByOblId;
  obl.SortByID;
  while (iObl < obl.Count) and (iObsh < Count) do
  begin
    if Items[iObsh].FOblId = obl.Items[iObl].FOblId then
    begin
      obl.Items[iObl].Obshtini.Add(Items[iObsh]);
      Items[iObsh].FObl := obl.Items[iObl];
      inc(iObsh);
    end
    else if Items[iObsh].FOblId > obl.Items[iObl].FOblId then
    begin
      inc(iObl);
    end
    else if Items[iObsh].FOblId < obl.Items[iObl].FOblId then
    begin
      inc(iObsh);
    end;
  end;
end;

function TObshtinaCollection.GetItem(Index: Integer): TObshtinaItem;
begin
  Result := TObshtinaItem(inherited GetItem(Index));
end;

function TObshtinaCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TObshtinaCollection.LoadFromFile(FileName: string);
var
  ls: TStringList;
  i: Integer;
  line: string;
  arrStr: TArray<string> ;
  obshtina: TObshtinaItem;
begin
  Clear;
  ls := TStringList.Create;
  ls.LoadFromFile(FileName);
  for i := 0 to ls.Count - 1 do
  begin
    line := ls[i];
    if line = EmptyStr then Continue;
    arrStr := line.Split([#9]);
    obshtina := TObshtinaItem(Add);
    obshtina.FOblId := StrToInt(arrStr[0]);
    obshtina.FObshId := StrToInt(arrStr[1]);
    obshtina.FRZOKR := arrStr[2];
    obshtina.FObshName := arrStr[3];
  end;
  ls.Free;
end;

procedure TObshtinaCollection.SetItem(Index: Integer; Value: TObshtinaItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TObshtinaCollection.SortByOblIDAndID;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  function conditionI(i, p: integer): Boolean;
  begin
    if Items[I].FOblId <> Items[P].FOblId then
      Result := Items[I].FOblId < Items[P].FOblId
    else
      Result := Items[I].FObshId < Items[P].FObshId;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if Items[J].FOblId <> Items[P].FOblId then
      Result := Items[J].FOblId > Items[P].FOblId
    else
      Result := Items[J].FObshId > Items[P].FObshId;
  end;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
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


procedure TObshtinaCollection.SortByOblId_RZOKR;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  function conditionI(i, p: integer): Boolean;
  begin
    if Items[I].FOblId <> Items[P].FOblId then
      Result := Items[I].FOblId < Items[P].FOblId
    else
      Result := Items[I].FRZOKR < Items[P].FRZOKR;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if Items[J].FOblId <> Items[P].FOblId then
      Result := Items[J].FOblId > Items[P].FOblId
    else
      Result := Items[J].FRZOKR > Items[P].FRZOKR;
  end;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
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


procedure TObshtinaCollection.SortByOblId;
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
        while Items[I].FOblId < Items[P].FOblId do Inc(I);
        while Items[J].FOblId > Items[P].FOblId do Dec(J);
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

{ TNasMestoCollection }

constructor TNasMestoCollection.Create(AOwner: TComponent);
begin
  inherited Create(TNasMestoItem);
  FOwner := AOwner;
end;

procedure TNasMestoCollection.FillNasMestoInObshtina(obsh: TObshtinaCollection; obl: TOblastCollection);
var
  iobsh, inas: integer;
  counter: Integer;
begin
  obsh.FillObshtinaInOblast(obl);
  iobsh := 0;
  inas := 0;
  obsh.SortByOblIDAndID;
  SortByOblIDObshID;

  while (inas < Count) and (iobsh < obsh.Count) do
  begin
    if (Items[inas].FOblId = obsh.Items[iobsh].FOblId) and
       (Items[inas].FObshId = obsh.Items[iobsh].FObshId) then
    begin
      Items[inas].FObl := obsh.Items[iobsh].FObl;
      Items[inas].FObsh := obsh.Items[iobsh];
      obsh.Items[iobsh].NasMesta.Add(Items[inas]);
      //Memo1.Lines.Add(IntToStr(ambs.Items[iamb].AmbListId));
      inc(inas);
    end
    else
    if (obsh.Items[iobsh].FOblId < Items[inas].FOblId) then
    begin
      inc(iobsh);
    end
    else
    if (obsh.Items[iobsh].FOblId > Items[inas].FOblId) then
    begin
      inc(inas);
    end
    else
    if (obsh.Items[iobsh].FObshId < Items[inas].FObshId) then
    begin
      inc(iobsh);
    end
    else
    if (obsh.Items[iobsh].FObshId > Items[inas].FObshId) then
    begin
      inc(inas);
    end;
  end;
end;

function TNasMestoCollection.GetItem(Index: Integer): TNasMestoItem;
begin
  Result := TNasMestoItem(inherited GetItem(Index));
end;

function TNasMestoCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TNasMestoCollection.LoadFromFile(FileName: string);
var
  ls: TStringList;
  i: Integer;
  line: string;
  arrStr: TArray<string> ;
  NasMesto: TNasMestoItem;
begin
  Clear;
  ls := TStringList.Create;
  ls.LoadFromFile(FileName);
  for i := 0 to ls.Count - 1 do
  begin
    line := ls[i];
    if line = EmptyStr then Continue;

    arrStr := line.Split([#9]);
    NasMesto := TNasMestoItem(Add);
    NasMesto.FOblId := StrToInt(arrStr[0]);
    NasMesto.FObshId := StrToInt(arrStr[1]);
    NasMesto.FEKATTE := arrStr[2];
    NasMesto.FZIP := arrStr[3];
    NasMesto.FNasMestoName := arrStr[4];
  end;
  ls.Free;
end;

function TNasMestoCollection.IndexNasMestoFromName(oblName, ObshName,
  nasMestoName: string): integer;
var
  i: Integer;
  nasMesto: TNasMestoItem;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    nasMesto := TNasMestoItem(Items[i]);
    if nasMesto.FNasMestoName = nasMestoName then
    begin
      if nasMesto.FObl.FOblName = oblName then
      begin
        if nasMesto.FObsh.FObshName = ObshName then
        begin
          Result := i;
          Exit;
        end;
      end;
    end;
  end;
end;

function TNasMestoCollection.NasMestoFromName(oblName, ObshName,
  nasMestoName: string): TNasMestoItem;
var
  i: Integer;
  nasMesto: TNasMestoItem;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    nasMesto := TNasMestoItem(Items[i]);
    if nasMesto.FNasMestoName = nasMestoName then
    begin
      if nasMesto.FObl.FOblName = oblName then
      begin
        if nasMesto.FObsh.FObshName = ObshName then
        begin
          Result := nasMesto;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TNasMestoCollection.SetItem(Index: Integer; Value: TNasMestoItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNasMestoCollection.SortByNameAndEKT;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
    varI, varJ, varP: string;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      varP := Items[P].FNasMestoName + Items[P].FEKATTE;
      repeat
        while (Items[I].FNasMestoName + Items[I].FEKATTE) < varP do Inc(I);
        while (Items[J].FNasMestoName + Items[J].FEKATTE) > varP do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          varP := Items[P].FNasMestoName + Items[P].FEKATTE;
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

procedure TNasMestoCollection.SortByNamOblObsht;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
    varP: string;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      varP := Items[P].FNasMestoName + Items[P].FObl.FOblName + Items[P].FObsh.FObshName;
      repeat
        while (Items[I].FNasMestoName + Items[I].FObl.FOblName + Items[I].FObsh.FObshName) < varP do Inc(I);
        while (Items[J].FNasMestoName + Items[J].FObl.FOblName + Items[J].FObsh.FObshName) > varP do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          varP := Items[P].FNasMestoName + Items[P].FObl.FOblName + Items[P].FObsh.FObshName;
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

procedure TNasMestoCollection.SortByOblIDObshID;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  function conditionI(i, p: integer): Boolean;
  begin
    if Items[I].FOblId <> Items[P].FOblId then
      Result := Items[I].FOblId < Items[P].FOblId
    else
      Result := Items[I].FObshId < Items[P].FObshId;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if Items[J].FOblId <> Items[P].FOblId then
      Result := Items[J].FOblId > Items[P].FOblId
    else
      Result := Items[J].FObshId > Items[P].FObshId;
  end;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
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

{ TObshtinaItem }

constructor TObshtinaItem.Create(Collection: TCollection);
begin
  inherited;
  NasMesta := TList.Create;
end;

destructor TObshtinaItem.Destroy;
begin
  FreeAndNil(NasMesta);
  inherited;
end;



{ TOblastItem }

constructor TOblastItem.Create(Collection: TCollection);
begin
  inherited;
  Obshtini := TList.Create;
end;

destructor TOblastItem.Destroy;
begin
  FreeAndNil(Obshtini);
  inherited;
end;

function TOblastItem.GetOblNzis: string;
begin
  case OblID of
    1: Result := 'BLG';
    2: Result := 'BGS';
    3: Result := 'VAR';
    4: Result := 'VTR';
    5: Result := 'VID';
    6: Result := 'VRC';
    7: Result := 'GAB';
    8: Result := 'DOB';
    9: Result := 'KRZ';
    10: Result := 'KNL';
    11: Result := 'LOV';
    12: Result := 'MON';
    13: Result := 'PAZ';
    14: Result := 'PER';
    15: Result := 'PVN';
    16: Result := 'PDV';
    17: Result := 'RAZ';
    18: Result := 'RSE';
    19: Result := 'SLS';
    20: Result := 'SLV';
    21: Result := 'SML';
    22: Result := 'SOF';
    23: Result := 'SFO';
    24: Result := 'SZR';
    25: Result := 'TGV';
    26: Result := 'HKV';
    27: Result := 'SHU';
    28: Result := 'JAM';
  end;
end;

end.
