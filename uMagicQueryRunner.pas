unit uMagicQueryRunner;

interface

uses
  System.SysUtils, System.Generics.Collections, VirtualTrees, Aspects.Types,
  VirtualStringTreeAspect,
  uFilterMagicIndex, Aspects.Collections, System.Generics.Defaults, Aspects.Functions;


type
  TMagicQueryRunner = class
  public
    // FilterLinkFile  - mapped link file за филтърното дърво (с PathIndex)
    // AdbLinkFile     - mapped link file за ADB дървото (с PathIndex)
    // FilterRoot      - възел (vvFilterItem или vvRootFilter->FirstChild) за който изпълняваме филтъра
    class function ExecuteFilter(FilterLinkFile, AdbLinkFile: TMappedLinkFile;
      FilterRoot: PVirtualNode): TList<PVirtualNode>;
  end;

implementation

uses
  System.Rtti, TypInfo;

type
  TBucketComparer = class(TInterfacedObject, IComparer<TList<PVirtualNode>>)
  public
    function Compare(const A, B: TList<PVirtualNode>): Integer;
  end;

function TBucketComparer.Compare(const A, B: TList<PVirtualNode>): Integer;
begin
  Result := A.Count - B.Count;
end;

// Helper: кои видове са "object nodes" (трябва да съвпадат с ADB)
function IsObjectVid(const v: TVtrVid): Boolean;
begin
  case v of
    vvNone,
    vvFieldFilter, vvFieldOrGroup, vvOperator,
    vvFilterItem, vvObjectGroup, vvRootFilter:
      Exit(False);
  end;
  Result := True;
end;

// Връща броя object-възли в пътя от root до този filterNode (използва lenNode + PAspRecFilter layout)
function ComputeObjectDepthFilterNode(const FilterNode: PVirtualNode; vtr: TVirtualStringTreeAspect): Integer;
var
  cur: PVirtualNode;
  data: PAspRecFilter;
begin
  Result := 0;
  cur := FilterNode;
  while Assigned(cur) and (cur <> vtr.RootNode.FirstChild) do
  begin
    data := PAspRecFilter(PByte(cur) + lenNode);
    if IsObjectVid(data.vid) then
      Inc(Result);
    cur := cur.Parent;
  end;
end;

// За ADB node: намери ancestor-родител, изкачвайки се `stepsUpObjectNodes` object-стъпки (броим само object-видове)
function GetAncestorByObjectDepth_ADB(node: PVirtualNode; stepsUpObjectNodes: Integer): PVirtualNode;
var
  cur: PVirtualNode;
  data: PAspRec;
  cnt: Integer;
begin
  Result := nil;
  if node = nil then Exit;
  cur := node;
  cnt := 0;
  while Assigned(cur) and (cnt < stepsUpObjectNodes) do
  begin
    cur := cur.Parent;
    if not Assigned(cur) then Break;
    data := PAspRec(PByte(cur) + lenNode);
    if IsObjectVid(data.vid) then
      Inc(cnt);
  end;
  Result := cur;
end;

class function TMagicQueryRunner.ExecuteFilter(FilterLinkFile, AdbLinkFile: TMappedLinkFile;
  FilterRoot: PVirtualNode): TList<PVirtualNode>;
var
  activeFilters: TList<PVirtualNode>;
  filterNode: PVirtualNode;
  dataFilter: PAspRecFilter;
  sig: UInt64;
  aBucket: TList<PVirtualNode>;
  tmpBucket: TList<PVirtualNode>;
  buckets: TList<TList<PVirtualNode>>;
  dictAnc: TDictionary<Pointer, Byte>;
  idx, i, depth, stepsUp: Integer;
  adbChild: PVirtualNode;
  dict, otherDict: TDictionary<Pointer, Byte>;
  kv: TPair<Pointer, Byte>;
  // debug
  dbgCountBefore, dbgCountAfter: Integer;
  // local helpers
  procedure CollectActiveObjectFilters(ANode: PVirtualNode; L: TList<PVirtualNode>);
  var
    ch: PVirtualNode;
    d: PAspRecFilter;
  begin
    if ANode = nil then Exit;
    ch := ANode.FirstChild;
    while Assigned(ch) do
    begin
      d := PAspRecFilter(PByte(ch) + lenNode);
      if IsObjectVid(d.vid) then
      begin
        // CheckState used by UI as primary activation; we also accept nodes where any child is active
        if ch.CheckState = csCheckedNormal then
          L.Add(ch);
      end;
      // recurse
      CollectActiveObjectFilters(ch, L);
      ch := ch.NextSibling;
    end;
  end;

  // проектция: от листовите ADB nodes -> проектираме на ancestor с depth (stepsUp = depth-1)
  function ProjectBucketToAncestors(bucket: TList<PVirtualNode>; stepsUp: Integer): TList<PVirtualNode>;
  var
    i: Integer;
    anc: PVirtualNode;
    ancDict: TDictionary<Pointer, Byte>;
    node: PVirtualNode;
    kv: TPair<Pointer, Byte>;
  begin
    Result := TList<PVirtualNode>.Create;
    ancDict := TDictionary<Pointer, Byte>.Create;
    try
      for i := 0 to bucket.Count - 1 do
      begin
        node := bucket[i];
        anc := GetAncestorByObjectDepth_ADB(node, stepsUp);
        if anc <> nil then
        begin
          if not ancDict.ContainsKey(anc) then
            ancDict.Add(anc, 1);
        end;
      end;
      // transfer keys into list
      for kv in ancDict do
        Result.Add(PVirtualNode(kv.Key));
    finally
      ancDict.Free;
    end;
  end;

begin
  Result := TList<PVirtualNode>.Create;
  buckets := TList<TList<PVirtualNode>>.Create;
  activeFilters := TList<PVirtualNode>.Create;
  try
    if (FilterLinkFile = nil) or (AdbLinkFile = nil) or (FilterRoot = nil) then
      Exit(Result);

    // Подготвяме активните обектни филтри (filter nodes)
    CollectActiveObjectFilters(FilterRoot, activeFilters);

    if activeFilters.Count = 0 then
    begin
      // Няма обектни филтри -> всички top-level adb children са кандидати (проектирани към себе си)
      adbChild := AdbLinkFile.FVTR.RootNode.FirstChild;
      while adbChild <> nil do
      begin
        Result.Add(adbChild);
        adbChild := adbChild.NextSibling;
      end;
      Exit(Result);
    end;

    // За всеки активен filterNode: взимаме неговия PathSig и получаваме ADB bucket
    for i := 0 to activeFilters.Count - 1 do
    begin
      filterNode := activeFilters[i];
      dataFilter := PAspRecFilter(PByte(filterNode) + lenNode);

      // колко object-стъпки има от корена до този filter node
      // depth = брой object-възли в пътя
      depth := ComputeObjectDepthFilterNode(filterNode, FilterLinkFile.FVTR);
      // stepsUp = depth - 1; ако depth=1 -> stepsUp=0 (вече сме на пациента)
      stepsUp := depth - 1;
      if stepsUp < 0 then stepsUp := 0;

      sig := FilterLinkFile.ComputeNodePathSig(filterNode); // filter-version на ComputeNodePathSig
      if not AdbLinkFile.PathIndex.TryGetValue(sig, aBucket) then
      begin
        // Няма кандидати за този филтър -> AND-intersection е празно
        for tmpBucket in buckets do tmpBucket.Free;
        buckets.Free;
        Exit(Result); // ще върне празен списък
      end;

      // Проектираме всеки ADB bucket на ancestor-нивото (patient или каквото е нужно)
      tmpBucket := ProjectBucketToAncestors(aBucket, stepsUp);
      buckets.Add(tmpBucket);
    end;

    // Сега имаме buckets от ancestor-sets (на една и съща височина) -> intersect
    // Оптимизация: започваме от най-малкия bucket
    buckets.Sort(TBucketComparer.Create);

    if buckets.Count = 0 then Exit(Result);

    // intersection, използвайки dict за намаляване

    dict := TDictionary<Pointer, Byte>.Create;
    try
      // напълни dict с първия bucket
      for i := 0 to buckets[0].Count - 1 do
        dict.Add(buckets[0][i], 1);

      for idx := 1 to buckets.Count - 1 do
      begin
        otherDict := TDictionary<Pointer, Byte>.Create;
        try
          // запиши само ключовете, които съществуват в dict
          for i := 0 to buckets[idx].Count - 1 do
          begin
            if dict.ContainsKey(buckets[idx][i]) then
            begin
              otherDict.Add(buckets[idx][i], 1);
            end;
          end;
          dict.Free;
          dict := otherDict;
          // mark otherDict taken
          otherDict := nil;
        finally
          if otherDict <> nil then otherDict.Free;
        end;

        if dict.Count = 0 then
          Break;
      end;

      // collect keys to Result
      for kv in dict do
        Result.Add(PVirtualNode(kv.Key));
    finally
      dict.Free;
    end;

  finally
    for tmpBucket in buckets do tmpBucket.Free;
    buckets.Free;
    activeFilters.Free;
  end;
end;

end.

