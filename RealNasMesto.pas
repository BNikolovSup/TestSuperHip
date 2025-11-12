unit RealNasMesto;

interface
uses
  classes, system.SysUtils, windows, System.Generics.Collections, system.Math,
  Vcl.StdCtrls, Vcl.Dialogs,
  Table.Oblast, Table.Obshtina, Table.NasMesto, Table.Addres,
  VirtualStringTreeHipp, uFuzzyMatch,
  VirtualTrees, VirtualStringTreeAspect,
  Aspects.Collections, Aspects.Types;
type
  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  TRealOblastColl = class;
  TRealOblastItem = class;
  TRealObshtinaColl = class;
  TRealObshtinaItem = class;
  TRealNasMestoColl = class;
  TRealNasMestoItem = class;

  TRealAddresItem = class(TAddresItem)
  private
    FEkatte: string;
    FNasMesto: string;
    FRZOKR: string;
    FLinkNasMesto: Cardinal;
    FPatId: Integer;
    procedure SetEkatte(const Value: string);
  public
    FObl: TRealOblastItem;
    FObsht: TRealObshtinaItem;
    constructor Create(Collection: TCollection); override;
    property Ekatte: string read FEkatte write SetEkatte;
    property NasMesto: string read FNasMesto write FNasMesto;
    property RZOKR: string read FRZOKR write FRZOKR;
    property LinkNasMesto: Cardinal read FLinkNasMesto write FLinkNasMesto;
    property PatId: Integer read FPatId  write FPatId;

  end;

  TRealAddresColl = class(TAddresColl)
  private
    function GetItem(Index: Integer): TRealAddresItem;
    procedure SetItem(Index: Integer; const Value: TRealAddresItem);
  public
    procedure SortByRzokR;
    procedure SortByEkatte;
    function GetFullAddres(dataPos: cardinal): string;
    property Items[Index: Integer]: TRealAddresItem read GetItem write SetItem;
  end;

  TRealNasMestoAspects = class(TObject)
  private
    FMemotest: TMemo;
  public
    OblColl: TRealOblastColl;
    obshtColl: TRealObshtinaColl;
    nasMestoColl: TRealNasMestoColl;
    addresColl: TRealAddresColl;
    AspectsNasMestaLinkFile: TMappedLinkFile;
    AspectsNasMestaADBFile: TMappedFile;
    VTRNasMesta: TVirtualStringTreeAspect;
    vNasMestaRoot: PVirtualNode;
    LstNasMestoDataPos: TList<TRealNasMestoItem>;
    LstNasMestoEkatte: TList<TRealNasMestoItem>;


    constructor Create(vtr: TVirtualStringTreeAspect);
    destructor Destroy; override;
    procedure FillLinkNasMestoInAddres;
    procedure LoadVtr(vtr: TVirtualStringTreeHipp);
    procedure LoadVtrSelf;
    procedure OpenLink;
    procedure OpenAdb;

    procedure FindMach;
    procedure FindMachNasMesto;
    procedure LinkToColl;
    procedure SortListByDataPos;
    procedure SortListByEkatte;
    function FindNasMestFromDataPos(datapos: Integer): TRealNasMestoItem;
    function FindNasMestFromEkatte(ekatte: string): TRealNasMestoItem;
    function FindNasMestFromNasMesto(nasMst: string): TRealNasMestoItem;
    property MemoTest: TMemo read FMemotest write FMemotest;
  end;


  TRealNasMestoItem = class(TNasMestoItem)
  private
    FEKATTE: string;
    FZIP: string;
    FNasMestoName: string;
    FObshId: Integer;
    FOblId: Integer;
    FRzokR: string;
    FNode: PVirtualNode;
  public
    FObl: TRealOblastItem;
    FObsh: TRealObshtinaItem;
    property OblId: Integer read FOblId write FOblId;
    property OObshId: Integer read FObshId write FObshId;
    property NasMestoName: string read FNasMestoName write FNasMestoName;
    property ZIP: string read FZIP write FZIP;
    property EKATTE: string read FEKATTE write FEKATTE;
    property RzokR: string read FRzokR write FRzokR;
    property Node: PVirtualNode read FNode write FNode;
  end;

  TRealNasMestoColl = class(TNasMestoColl)
  private
    function GetItem(Index: Integer): TRealNasMestoItem;
    procedure SetItem(Index: Integer; const Value: TRealNasMestoItem);
  public
    Settlements: TArray<string>;
    procedure LoadFromFile(FileName: string);
    procedure SortByOblIDObshID;
    procedure SortByRzokRName;

    procedure FillNasMestoInObshtina(obsh: TRealObshtinaColl; obl: TRealOblastColl);
    property Items[Index: Integer]: TRealNasMestoItem read GetItem write SetItem;

  end;

  TRealObshtinaItem = class(TObshtinaItem)
  private
    FRZOKR: string;
    FObshName: string;
    FObshId: Integer;
    FOblId: Integer;
  public
    FObl: TRealOblastItem;
    NasMesta: TList<TRealNasMestoItem>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property OblId: Integer read FOblId write FOblId;
    property OObshId: Integer read FObshId write FObshId;
    property ObshName: string read FObshName write FObshName;
    property RZOKR: string read FRZOKR write FRZOKR;

  end;

  TRealObshtinaColl = class(TObshtinaColl)
  private
    function GetItem(Index: Integer): TRealObshtinaItem;
    procedure SetItem(Index: Integer; const Value: TRealObshtinaItem);
  public
    procedure LoadFromFile(FileName: string);
    procedure FillObshtinaInOblast(obl: TRealOblastColl);
    procedure SortByOblId;
    procedure SortByOblIDAndID;
    property Items[Index: Integer]: TRealObshtinaItem read GetItem write SetItem;
  end;



  TRealOblastItem = class(TOblastItem)
  private
    FOblId: Integer;
    FOblName: string;
  public
    Obshtini: TList<TRealObshtinaItem>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property OblId: Integer read FOblId write FOblId;
    property OblName: string read FOblName write FOblName;
  end;

  TRealOblastColl = class(TOblastColl)
  private
    function GetItem(Index: Integer): TRealOblastItem;
    procedure SetItem(Index: Integer; const Value: TRealOblastItem);
  public

    procedure LoadFromFile(FileName: string);
    procedure SortByID;
    property Items[Index: Integer]: TRealOblastItem read GetItem write SetItem;
  end;
implementation


{ TRealOblastColl }

function TRealOblastColl.GetItem(Index: Integer): TRealOblastItem;
begin
  Result := TRealOblastItem(inherited GetItem(Index));
end;

procedure TRealOblastColl.LoadFromFile(FileName: string);
var
  ls: TStringList;
  i: Integer;
  line: string;
  arrStr: TArray<string> ;
  obl: TRealOblastItem;
begin
  Clear;
  ls := TStringList.Create;
  ls.LoadFromFile(FileName);
  for i := 0 to ls.Count - 1 do
  begin
    line := ls[i];
    if line = EmptyStr then Continue;
    arrStr := line.Split([#9]);
    obl := TRealOblastItem(Add);
    obl.FOblId := StrToInt(arrStr[0]);
    obl.FOblName := arrStr[1];
  end;
  ls.Free;
end;

procedure TRealOblastColl.SetItem(Index: Integer; const Value: TRealOblastItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealOblastColl.SortByID;
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

{ TRealObshtinaColl }

procedure TRealObshtinaColl.FillObshtinaInOblast(obl: TRealOblastColl);
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

function TRealObshtinaColl.GetItem(Index: Integer): TRealObshtinaItem;
begin
  Result := TRealObshtinaItem(inherited GetItem(Index));
end;

procedure TRealObshtinaColl.LoadFromFile(FileName: string);
var
  ls: TStringList;
  i: Integer;
  line: string;
  arrStr: TArray<string> ;
  obshtina: TRealObshtinaItem;
begin
  Clear;
  ls := TStringList.Create;
  ls.LoadFromFile(FileName);
  for i := 0 to ls.Count - 1 do
  begin
    line := ls[i];
    if line = EmptyStr then Continue;
    arrStr := line.Split([#9]);
    obshtina := TRealObshtinaItem(Add);
    obshtina.FOblId := StrToInt(arrStr[0]);
    obshtina.FObshId := StrToInt(arrStr[1]);
    obshtina.FRZOKR := arrStr[2];
    obshtina.FObshName := arrStr[3];
  end;
  ls.Free;
end;

procedure TRealObshtinaColl.SetItem(Index: Integer;
  const Value: TRealObshtinaItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealObshtinaColl.SortByOblId;
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

procedure TRealObshtinaColl.SortByOblIDAndID;
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

{ TRealNasMestoColl }

procedure TRealNasMestoColl.FillNasMestoInObshtina(obsh: TRealObshtinaColl;
  obl: TRealOblastColl);
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

function TRealNasMestoColl.GetItem(Index: Integer): TRealNasMestoItem;
begin
  Result := TRealNasMestoItem(inherited GetItem(Index));
end;

procedure TRealNasMestoColl.LoadFromFile(FileName: string);
var
  ls: TStringList;
  i, cnt: Integer;
  line: string;
  arrStr: TArray<string> ;
  NasMesto: TRealNasMestoItem;
begin
  Clear;
  ls := TStringList.Create;
  ls.LoadFromFile(FileName);
  SetLength(Settlements, ls.Count);
  cnt := 0;
  for i := 0 to ls.Count - 1 do
  begin
    line := ls[i];
    if line = EmptyStr then Continue;

    arrStr := line.Split([#9]);
    NasMesto := TRealNasMestoItem(Add);
    NasMesto.FOblId := StrToInt(arrStr[0]);
    NasMesto.FObshId := StrToInt(arrStr[1]);
    NasMesto.FEKATTE := arrStr[2];
    NasMesto.FZIP := arrStr[3];
    NasMesto.FNasMestoName := arrStr[4];
    Settlements[cnt] := AnsiUpperCase(arrStr[4]);
    inc(cnt);
  end;
  SetLength(Settlements, self.Count);
  ls.Free;
end;

procedure TRealNasMestoColl.SetItem(Index: Integer;
  const Value: TRealNasMestoItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealNasMestoColl.SortByOblIDObshID;
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



procedure TRealNasMestoColl.SortByRzokRName;
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
        while (Items[I].FRZOKR + Items[i].FNasMestoName) < (Items[P].FRZOKR + Items[p].FNasMestoName) do Inc(I);
        while (Items[J].FRZOKR + Items[j].FNasMestoName) > (Items[P].FRZOKR + Items[p].FNasMestoName) do Dec(J);
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

{ TRealOblastItem }
constructor TRealOblastItem.create(Collection: TCollection);
begin
  inherited;
  Obshtini := TList<TRealObshtinaItem>.Create;;
end;

destructor TRealOblastItem.destroy;
begin
  FreeAndNil(Obshtini);
  inherited;
end;

{ TRealObshtinaItem }

constructor TRealObshtinaItem.Create(Collection: TCollection);
begin
  inherited;
  FObl := nil;
  NasMesta := TList<TRealNasMestoItem>.create;
end;

destructor TRealObshtinaItem.Destroy;
begin
  FreeAndNil(NasMesta);
  inherited;
end;

{ TRealNasMestoAspects }

constructor TRealNasMestoAspects.Create(vtr: TVirtualStringTreeAspect);
begin
  OblColl := TRealOblastColl.Create(TRealOblastItem);
  obshtColl := TRealObshtinaColl.Create(TRealObshtinaItem);
  nasMestoColl := TRealNasMestoColl.Create(TRealNasMestoItem);
  addresColl := TRealAddresColl.Create(TRealAddresItem);
  VTRNasMesta := vtr;
  OpenLink;
  OpenAdb;
  OblColl.Buf := AspectsNasMestaADBFile.Buf;
  OblColl.posData := AspectsNasMestaADBFile.FPosData;
  obshtColl.Buf := AspectsNasMestaADBFile.Buf;
  obshtColl.posData := AspectsNasMestaADBFile.FPosData;
  nasMestoColl.Buf := AspectsNasMestaADBFile.Buf;
  nasMestoColl.posData := AspectsNasMestaADBFile.FPosData;
  LstNasMestoDataPos := TList<TRealNasMestoItem>.Create;
  LstNasMestoEkatte := TList<TRealNasMestoItem>.create;
end;

destructor TRealNasMestoAspects.Destroy;
begin
  FreeAndNil(OblColl);
  FreeAndNil(obshtColl);
  FreeAndNil(nasMestoColl);
  FreeAndNil(addresColl);
  FreeAndNil(LstNasMestoDataPos);
  FreeAndNil(LstNasMestoEkatte);
  if AspectsNasMestaLinkFile <> nil then
  begin
    if VTRNasMesta.RootNode.FirstChild <> nil then
    begin
      VTRNasMesta.InternalDisconnectNode(VTRNasMesta.RootNode.FirstChild, false);
    end;
    AspectsNasMestaLinkFile.Free;
    AspectsNasMestaLinkFile := nil;
  end;
  if AspectsNasMestaADBFile <> nil then
  begin
    AspectsNasMestaADBFile.Free;
    AspectsNasMestaADBFile := nil;
  end;
  inherited;
end;

procedure TRealNasMestoAspects.FillLinkNasMestoInAddres;
var
  iNasMesto, iAddres: integer;
begin
  iNasMesto := 0;
  iAddres := 0;
  nasMestoColl.SortByRzokRName;
  addresColl.SortByRzokR;
  while (iAddres < addresColl.Count) and (iNasMesto < nasMestoColl.Count) do
  begin
    if (nasMestoColl.Items[iNasMesto].FRzokR + AnsiUpperCase(nasMestoColl.Items[iNasMesto].FNasMestoName)) = addresColl.Items[iAddres].FRZOKR + AnsiUpperCase(addresColl.Items[iAddres].FNasMesto) then
    begin
      addresColl.Items[iAddres].FLinkNasMesto := nasMestoColl.Items[iNasMesto].DataPos;
      addresColl.SetIntMap(addresColl.Items[iAddres].DataPos, word(Addres_LinkPos), nasMestoColl.Items[iNasMesto].DataPos);
      addresColl.Items[iAddres].FObl := nasMestoColl.Items[iNasMesto].FObl;
      addresColl.Items[iAddres].FObsht := nasMestoColl.Items[iNasMesto].FObsh;
      inc(iAddres);
    end
    else if (nasMestoColl.Items[iNasMesto].FRzokR + AnsiUpperCase(nasMestoColl.Items[iNasMesto].FNasMestoName)) > addresColl.Items[iAddres].FRZOKR + AnsiUpperCase(addresColl.Items[iAddres].FNasMesto) then
    begin
      inc(iAddres);
    end
    else if (nasMestoColl.Items[iNasMesto].FRzokR + AnsiUpperCase(nasMestoColl.Items[iNasMesto].FNasMestoName)) < addresColl.Items[iAddres].FRZOKR + AnsiUpperCase(addresColl.Items[iAddres].FNasMesto) then
    begin
      inc(iNasMesto);
    end;
  end;
end;
{ TRealAddresItem }

constructor TRealAddresItem.Create(Collection: TCollection);
begin
  inherited;
  FLinkNasMesto := 0;
end;


procedure TRealNasMestoAspects.FindMach  ;
var
  i: Integer;
  Input: string;
  ResultMatch: TFuzzyMatchResult;
begin
  FMemotest.Lines.BeginUpdate;
  //if nasMestoColl.Count = 0 then
//  begin
//    OblColl.LoadFromFile('cdsOblast.csv');
//    obshtColl.LoadFromFile('cdsObshtina.csv');
//    nasMestoColl.LoadFromFile('cdsNas_mqsto.csv');
//
//    nasMestoColl.FillNasMestoInObshtina(obshtColl, OblColl);
//  end;

  nasMestoColl.LoadFromFile('cdsNas_mqsto.csv');
  for i := 0 to addresColl.Count - 1 do
  begin
    if addresColl.Items[i].LinkNasMesto > 0 then
    begin
      Input := '';
      Continue;
    end;

    Input := AnsiUpperCase(addresColl.Items[i].FNasMesto);
    ResultMatch := FindBestMatch(Input, nasMestoColl.Settlements);
    //if ResultMatch.SimilarityScore <> 1 then
    begin
      FMemoTest.Lines.Add(Format('%s Най-близко съвпадение: %s (%.1f%% сходство)',
          [Input,ResultMatch.BestMatch, ResultMatch.SimilarityScore * 100]))
    end;
  end;
  FMemotest.Lines.EndUpdate;
end;

procedure TRealNasMestoAspects.FindMachNasMesto;
var
  i, j: Integer;
  Input: string;
  ResultMatch: TFuzzyMatchResult;
begin
  FMemotest.Lines.BeginUpdate;
  for i := 0 to addresColl.Count - 1 do
  begin
    if addresColl.Items[i].LinkNasMesto > 0 then continue ;

    for j := 0 to obshtColl.Count - 1 do
    begin
      if obshtColl.Items[j].FRZOKR <> addresColl.Items[i].FRZOKR then Continue;

      Input := AnsiUpperCase(addresColl.Items[i].FNasMesto);
      ResultMatch := FindBestMatchNasMesto(Input, obshtColl.Items[j]);
      if ResultMatch.SimilarityScore <> 1 then
      begin
        FMemoTest.Lines.Add(Format('%s Най-близко съвпадение: %s (%.1f%% сходство)',
            [Input,ResultMatch.BestMatch, ResultMatch.SimilarityScore * 100]))
      end;
    end;

  end;
  FMemotest.Lines.EndUpdate;
end;

function TRealNasMestoAspects.FindNasMestFromDataPos(datapos: Integer): TRealNasMestoItem;
var
  L, H: Integer;
  mid: Integer;
  isFind: Boolean;
begin
  Result := nil;
  isFind := False;
  L := 0;
  H := LstNasMestoDataPos.Count - 1;
  while L <= H do
  begin
    mid := L + (H - L) shr 1;
    //cmp := Comparer.Compare(Values[mid], Item);
    if LstNasMestoDataPos[mid].FDataPos < datapos then
      L := mid + 1
    else
    begin
      H := mid - 1;
      if LstNasMestoDataPos[mid].FDataPos = datapos then
      begin
        result := LstNasMestoDataPos[Mid];
        Exit;
      end;
    end;
  end;
  result := LstNasMestoDataPos[L];
end;

function TRealNasMestoAspects.FindNasMestFromEkatte(
  ekatte: string): TRealNasMestoItem;
var
  L, H: Integer;
  mid: Integer;
  isFind: Boolean;
begin
  Result := nil;
  isFind := False;
  L := 0;
  H := LstNasMestoEkatte.Count - 1;
  while L <= H do
  begin
    mid := L + (H - L) shr 1;
    //cmp := Comparer.Compare(Values[mid], Item);
    if LstNasMestoEkatte[mid].FEKATTE < ekatte then
      L := mid + 1
    else
    begin
      H := mid - 1;
      if LstNasMestoEkatte[mid].FEKATTE = ekatte then
      begin
        result := LstNasMestoEkatte[Mid];
        Exit;
      end;
    end;
  end;
  result := LstNasMestoEkatte[L];
end;

function TRealNasMestoAspects.FindNasMestFromNasMesto(
  nasMst: string): TRealNasMestoItem;
begin

end;

procedure TRealNasMestoAspects.LinkToColl;
var
  runObl, runObshtina, runNasMesto: PVirtualNode;
  obl: TRealOblastItem;
  obsht: TRealObshtinaItem;
  nasMest: TRealNasMestoItem;
  data: PAspRec;
begin
  runObl := vNasMestaRoot.FirstChild;
  while runObl <> nil  do
  begin
    data := Pointer(PByte(runObl) + lenNode);
    obl := TRealOblastItem(OblColl.Add);
    obl.DataPos := data.DataPos;
    runObshtina := runObl.FirstChild;
    while runObshtina <> nil do
    begin
      data := Pointer(PByte(runObshtina) + lenNode);
      obsht := TRealObshtinaItem(obshtColl.Add);
      obl.Obshtini.Add(obsht);
      obsht.DataPos := data.DataPos;
      obsht.FRZOKR := Format('%.2d',[OblColl.getWordMap(obl.DataPos, word(Oblast_OblastID))])+ Format('%.2d',[obshtColl.getWordMap(data.DataPos, word(Obshtina_RZOKR))]);
      runNasMesto := runObshtina.FirstChild;
      while runNasMesto <> nil do
      begin
        data := Pointer(PByte(runNasMesto) + lenNode);
        nasMest := TRealNasMestoItem(nasMestoColl.Add);
        nasMest.DataPos := data.DataPos;
        nasMest.FNasMestoName := nasMestoColl.getAnsiStringMap(data.DataPos, word(NasMesto_NasMestoName));
        nasMest.FEKATTE := nasMestoColl.getAnsiStringMap(data.DataPos, word(NasMesto_EKATTE));
        nasMest.RzokR := obsht.FRZOKR;
        nasMest.FNode := runNasMesto;
        nasMest.FObl := obl;
        nasMest.FObsh := obsht;
        LstNasMestoDataPos.Add(nasMest);
        LstNasMestoEkatte.Add(nasMest);
        obsht.NasMesta.Add(nasMest);
        runNasMesto := runNasMesto.NextSibling
      end;

      runObshtina := runObshtina.NextSibling;
    end;

    runObl := runObl.NextSibling;
  end;
  SortListByDataPos;
  SortListByEkatte;
end;

procedure TRealNasMestoAspects.LoadVtr(vtr: TVirtualStringTreeHipp);
var
  i, j, k: Integer;
  vRootNasMesta, vObl, vObsht, vNasMesto: PVirtualNode;

  obl: TRealOblastItem;
  obsht: TRealObshtinaItem;
  nasMesto: TRealNasMestoItem;
begin
  if OblColl.Count = 0 then
  begin
    OblColl.LoadFromFile('cdsOblast.csv');
    obshtColl.LoadFromFile('cdsObshtina.csv');
    nasMestoColl.LoadFromFile('cdsNas_mqsto.csv');

    nasMestoColl.FillNasMestoInObshtina(obshtColl, OblColl);
  end
  else
  begin

  end;
  vtr.BeginUpdate;
  vRootNasMesta := vtr.AddChild(nil, nil);
  for i := 0 to OblColl.Count - 1 do
  begin
    obl := OblColl.Items[i];
    obl.InsertOblast;
    vObl := vtr.AddChild(vRootNasMesta, nil);
    for j := 0 to obl.Obshtini.Count - 1 do
    begin
      obsht := obl.Obshtini[j];
      vObsht := vtr.AddChild(vObl, nil);
      for k := 0 to obsht.NasMesta.Count - 1 do
      begin
        nasMesto := obsht.NasMesta[k];
        vNasMesto := vtr.AddChild(vObsht, nil);
      end;
    end;
  end;
  vtr.FullExpand();
  vtr.EndUpdate;
end;

procedure TRealNasMestoAspects.LoadVtrSelf;
var
  i, j, k: Integer;
  vObl, vObsht, vNasMesto: PVirtualNode;

  obl: TRealOblastItem;
  obsht: TRealObshtinaItem;
  nasMesto: TRealNasMestoItem;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
begin
  if OblColl.Count = 0 then
  begin
    OblColl.LoadFromFile('cdsOblast.csv');
    obshtColl.LoadFromFile('cdsObshtina.csv');
    nasMestoColl.LoadFromFile('cdsNas_mqsto.csv');

    nasMestoColl.FillNasMestoInObshtina(obshtColl, OblColl);
  end
  else
  begin

  end;

  VTRNasMesta.BeginUpdate;
  for i := 0 to OblColl.Count - 1 do
  begin
    obl := OblColl.Items[i];
    New(obl.PRecord);
    obl.PRecord.setProp := [Oblast_OblastID, Oblast_OblastName];
    obl.PRecord.OblastName:= obl.FOblName;
    obl.PRecord.OblastID:= obl.FOblId;
    obl.InsertOblast;
    Dispose(obl.PRecord);
    obl.PRecord := nil;
    AspectsNasMestaLinkFile.AddNewNode(vvoblast, obl.DataPos, vNasMestaRoot, amAddChildLast, vObl, linkPos);

    for j := 0 to obl.Obshtini.Count - 1 do
    begin
      obsht := obl.Obshtini[j];
      New(obsht.PRecord);
      obsht.PRecord.setProp := [Obshtina_ObshtinaName, Obshtina_RZOKR];
      obsht.PRecord.ObshtinaName:= obsht.FObshName;
      obsht.PRecord.RZOKR:= StrToInt(obsht.FRZOKR);
      obsht.InsertObshtina;
      Dispose(obsht.PRecord);
      obsht.PRecord := nil;
      AspectsNasMestaLinkFile.AddNewNode(vvObshtina, obsht.DataPos, vObl, amAddChildLast, vObsht, linkPos);
      for k := 0 to obsht.NasMesta.Count - 1 do
      begin
        nasMesto := obsht.NasMesta[k];
        New(nasMesto.PRecord);
        nasMesto.PRecord.setProp := [NasMesto_NasMestoName, NasMesto_EKATTE, NasMesto_ZIP, NasMesto_RCZR];
        nasMesto.PRecord.NasMestoName:= nasMesto.FNasMestoName;
        nasMesto.PRecord.EKATTE:= nasMesto.FEKATTE;
        nasMesto.PRecord.ZIP:= nasMesto.FZIP;
        nasMesto.PRecord.RCZR:= Format('%.2d',[obl.OblId]) + Format('%.2d',[StrToInt(obsht.FRZOKR)]);
        nasMesto.InsertNasMesto;
        Dispose(nasMesto.PRecord);
        nasMesto.PRecord := nil;
        AspectsNasMestaLinkFile.AddNewNode(vvNasMesto, nasMesto.DataPos, vObsht, amAddChildLast, vNasMesto, linkPos);
      end;
    end;
  end;
  pCardinalData := pointer(PByte(AspectsNasMestaLinkFile.Buf) + 4);
  pCardinalData^ := Cardinal(AspectsNasMestaLinkFile.Buf);

  pCardinalData := pointer(PByte(AspectsNasMestaLinkFile.Buf) + 8);
  pCardinalData^ := Cardinal(VTRNasMesta.RootNode);

  VTRNasMesta.FullExpand();
  VTRNasMesta.EndUpdate;
end;

procedure TRealNasMestoAspects.OpenAdb;
var
  fileNameNew: string;
  fileStr: TFileStream;
begin
  fileNameNew :='AspNasMesta.adb';
  if FileExists(fileNameNew) then
  begin
    AspectsNasMestaADBFile := TMappedFile.Create(fileNameNew, false, TGUID.Empty);

  end
  else
  begin
    fileStr := TFileStream.Create(fileNameNew, fmCreate);
    fileStr.Size := 1000000;
    fileStr.Free;
    AspectsNasMestaADBFile := TMappedFile.Create(fileNameNew, true, TGUID.Empty);
  end;
end;

procedure TRealNasMestoAspects.OpenLink;
var
  fileLinkNasMestoName: string;
  Fstream: TFileStream;
  linkpos: Cardinal;
  pCardinalData: PCardinal;

begin
  fileLinkNasMestoName := 'LinkNasMesta.lnk';

  if FileExists(fileLinkNasMestoName) then
  begin
    AspectsNasMestaLinkFile := TMappedLinkFile.Create(fileLinkNasMestoName, false, TGUID.Empty);
    AspectsNasMestaLinkFile.FVTR := VTRNasMesta;
    AspectsNasMestaLinkFile.OpenLinkFile;
    vNasMestaRoot := VTRNasMesta.RootNode.FirstChild;
  end
  else
  begin
    Fstream := TFileStream.Create(fileLinkNasMestoName,fmCreate);
    Fstream.Size := 420000;
    Fstream.Free;
    AspectsNasMestaLinkFile := TMappedLinkFile.Create(fileLinkNasMestoName, true, TGUID.Empty);
    AspectsNasMestaLinkFile.FVTR := VTRNasMesta;
    linkpos := 100;
    AspectsNasMestaLinkFile.AddNewNode(vvRootNasMesta, 0, VTRNasMesta.RootNode, amAddChildLast, vNasMestaRoot, linkPos);
    pCardinalData := pointer(PByte(AspectsNasMestaLinkFile.Buf) + 4);
    pCardinalData^ := Cardinal(AspectsNasMestaLinkFile.Buf);

    pCardinalData := pointer(PByte(AspectsNasMestaLinkFile.Buf) + 8);
    pCardinalData^ := Cardinal(VTRNasMesta.RootNode);

    VTRNasMesta.EndUpdate;
    VTRNasMesta.UpdateScrollBars(true);
    VTRNasMesta.InvalidateToBottom(VTRNasMesta.RootNode);

    VTRNasMesta.InternalDisconnectNode(VTRNasMesta.RootNode.FirstChild, false);
    AspectsNasMestaLinkFile.Free;
    AspectsNasMestaLinkFile := nil;

    AspectsNasMestaLinkFile := TMappedLinkFile.Create(fileLinkNasMestoName, false, TGUID.Empty);
    AspectsNasMestaLinkFile.FVTR := VTRNasMesta;
  end;
end;

procedure TRealNasMestoAspects.SortListByDataPos;
 procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TRealNasMestoItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while LstNasMestoDataPos[I].DataPos < LstNasMestoDataPos[P].DataPos do Inc(I);
        while LstNasMestoDataPos[J].DataPos > LstNasMestoDataPos[P].DataPos do Dec(J);
        if I <= J then begin
          Save := LstNasMestoDataPos[I];
          LstNasMestoDataPos[I] := LstNasMestoDataPos[J];
          LstNasMestoDataPos[J] := Save;
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
  if (LstNasMestoDataPos.count >1 ) then
  begin
    QuickSort(0,LstNasMestoDataPos.count-1);
  end;
end;

procedure TRealNasMestoAspects.SortListByEkatte;
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TRealNasMestoItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while LstNasMestoEkatte[I].FEKATTE < LstNasMestoEkatte[P].FEKATTE do Inc(I);
        while LstNasMestoEkatte[J].FEKATTE > LstNasMestoEkatte[P].FEKATTE do Dec(J);
        if I <= J then begin
          Save := LstNasMestoEkatte[I];
          LstNasMestoEkatte[I] := LstNasMestoEkatte[J];
          LstNasMestoEkatte[J] := Save;
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
  if (LstNasMestoEkatte.count >1 ) then
  begin
    QuickSort(0,LstNasMestoEkatte.count-1);
  end;
end;

procedure TRealAddresItem.SetEkatte(const Value: string);
begin
  FEkatte := Value;
end;

{ TRealAddresColl }

function TRealAddresColl.GetFullAddres(dataPos: cardinal): string;
var
  LogAddres: TlogicalAddresSet;
  logAdres16: TLogicalData16;
  Use_Element: TLogicalAddres;
begin
  Result := '';
  LogAddres := TlogicalAddresSet(self.GetLogical16Map(dataPos, word(Addres_Logical)));
  for Use_Element in LogAddres do
  begin
    case Use_Element of
      USE_JK: Result := Result + 'жк. ' + self.getAnsiStringMap(dataPos, word(Addres_JK)) + ', ';
      USE_ULICA: Result := Result + 'ул. ' + self.getAnsiStringMap(dataPos, word(Addres_ULICA)) + ', ';
      USE_NOMER: Result := Result + '№. ' + self.getAnsiStringMap(dataPos, word(Addres_NOMER)) + ', ';
      USE_VH: Result := Result + 'вх. ' + self.getAnsiStringMap(dataPos, word(Addres_VH)) + ', ';
      USE_ET: Result := Result + 'ет. ' + self.getAnsiStringMap(dataPos, word(Addres_ET)) + ', ';
      USE_AP: Result := Result + 'ап. ' + self.getAnsiStringMap(dataPos, word(Addres_AP)) + ', ';
    end;
  end;
  if Length(Result) > 2 then
    SetLength(Result, Length(Result) - 2);
end;

function TRealAddresColl.GetItem(Index: Integer): TRealAddresItem;
begin
   Result := TRealAddresItem(inherited GetItem(Index));
end;

procedure TRealAddresColl.SetItem(Index: Integer; const Value: TRealAddresItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRealAddresColl.SortByEkatte;
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
        //while self.getAnsiStringMap(Items[I].DataPos, word(addres < Items[P].FEkatte do Inc(I);
        //while Items[J].FEkatte > Items[P].FEkatte do Dec(J);
        while Items[I].FEkatte < Items[P].FEkatte do Inc(I);
        while Items[J].FEkatte > Items[P].FEkatte do Dec(J);
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

procedure TRealAddresColl.SortByRzokR;
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
        while (Items[I].FRZOKR + AnsiUpperCase(Items[i].FNasMesto)) < (Items[P].FRZOKR + AnsiUpperCase(Items[p].FNasMesto)) do Inc(I);
        while (Items[J].FRZOKR + AnsiUpperCase(Items[j].FNasMesto)) > (Items[P].FRZOKR + AnsiUpperCase(Items[p].FNasMesto)) do Dec(J);
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
