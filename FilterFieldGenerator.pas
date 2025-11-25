unit FilterFieldGenerator;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  VirtualTrees, Aspects.Types, VirtualStringTreeAspect, Aspects.Collections;


type
  // Интерфейс за доставчик на колекции (adapter pattern).
  // Имплементирай този интерфейс да връща инстанция на колекция по TCollectionsType.
  IFilterCollectionProvider = interface
    ['{A6B9E7E2-9C2A-4F12-8B2E-9F0C9A1A1234}']
    function GetCollectionByType(ACollType: Word): TObject; // връща конкретния collection object (cast-ни сам)
    function GetADBBuffer: Pointer; // връща ADB.Buf (за четене преди DataPos)
  end;

  // Описание на едно поле (минимално)
  TFilterFieldDef = record
    FieldID: Integer;    // TPropertyIndex (enum ordinal)
    DisplayName: string; // име за GetText (може да е enum-name или локализация)
  end;
  PFilterFieldDef = ^TFilterFieldDef;

  // Основен генератор за field nodes
  TFilterFieldGenerator = class
  private
    FFilterTree: TVirtualStringTreeAspect;
    FLinkFile: TMappedLinkFile;
    FProvider: IFilterCollectionProvider;

    // кеш (PathHash << 32) xor FieldID  -> Boolean (exists)
    FVisitedFields: TDictionary<UInt64, Boolean>;

    // пом. функции
    function MakeFieldKey(const PathHash: UInt64; const FieldID: Integer): UInt64; inline;
    function GetCollectionTypeFromDataPos(const DataPos: Cardinal; const Buf: Pointer): Word; inline;
    procedure AddFieldsForObjectNode(const PathHash: UInt64; ObjectNode: PVirtualNode);
    procedure AddFieldNodeUnder(ObjectNode: PVirtualNode; const Field: TFilterFieldDef);
    function TryGetFieldsFromCollection(AColl: TObject; out Fields: TArray<TFilterFieldDef>): Boolean;
  public
    constructor Create(AFilterTree: TVirtualStringTreeAspect; ALinkFile: TMappedLinkFile; AProvider: IFilterCollectionProvider);
    destructor Destroy; override;

    // Обхожда вече създаденото filter tree и добавя field nodes под всеки object node.
    procedure AddFieldNodes;
  end;

implementation

uses
  // за минимални операции
  System.Rtti;

{ TFilterFieldGenerator }

constructor TFilterFieldGenerator.Create(AFilterTree: TVirtualStringTreeAspect; ALinkFile: TMappedLinkFile; AProvider: IFilterCollectionProvider);
begin
  if (AFilterTree = nil) or (ALinkFile = nil) or (AProvider = nil) then
    raise Exception.Create('TFilterFieldGenerator.Create: invalid parameters');

  FFilterTree := AFilterTree;
  FLinkFile := ALinkFile;
  FProvider := AProvider;

  FVisitedFields := TDictionary<UInt64, Boolean>.Create;
end;

destructor TFilterFieldGenerator.Destroy;
begin
  FVisitedFields.Free;
  inherited;
end;

function TFilterFieldGenerator.MakeFieldKey(const PathHash: UInt64; const FieldID: Integer): UInt64;
begin
  // simple combine: high 32 bits = PathHash truncated, low 32 bits = FieldID
  // PathHash is 64-bit; to minimize collisions we xor high and low parts
  Result := (PathHash xor (PathHash shr 32)) shl 32;
  Result := Result xor (UInt64(Cardinal(FieldID) and $FFFFFFFF));
end;

function TFilterFieldGenerator.GetCollectionTypeFromDataPos(const DataPos: Cardinal; const Buf: Pointer): Word;
begin
  // Assumes Buf points to ADB buffer and DataPos >= 4
  if (Buf = nil) or (DataPos < 4) then
    Exit(0);
  // two bytes before DataPos = collection type (Word)
  Result := PWord(PByte(Buf) + DataPos - 4)^;
end;

procedure TFilterFieldGenerator.AddFieldNodes;
var
  // Enumerate all nodes in filter tree and for those nodes that are object nodes (vid != vvRootFilter, vvFieldFilter, vvNone) add fields
  Node, ch, cur: PVirtualNode;
  Asp, a: PAspRec;
  PathHash: UInt64;
  stack: TList<PVirtualNode>;
  vids: array of TVtrVid;
  cnt, i: Integer;
  h: UInt64;
  // We'll assume the filter-tree generator (uFilterTreeGenerator1) has registered path-hash -> node mapping in a dictionary.
  // If not, we can compute pathHash by walking parent chain and using same CombineHashWithVid as generator.
begin
  if FFilterTree = nil then Exit;

  // iterate all nodes under root (skip root)
  Node := FFilterTree.RootNode.FirstChild;
  if Node = nil then Exit;

  // We'll walk tree depth-first and compute path hash incrementally.
  // For simplicity/robustness, compute pathHash for each node by walking parent chain and calling provider buffer/Combine same algorithm.
  // Assume provider does not expose hash; we recompute per node (cost is small compared to IO).

  stack := TList<PVirtualNode>.Create;
  try
    stack.Add(Node);
    while stack.Count > 0 do
    begin
      Node := stack.Extract(stack[stack.Count-1]);
      // push children
      ch := Node.FirstChild;
      while Assigned(ch) do
      begin
        stack.Add(ch);
        ch := ch.NextSibling;
      end;

      // get AspRec for this node
      Asp := PAspRec(PByte(Node) + lenNode);
      if Asp = nil then Continue;

      // skip root & field nodes & empties
      if Asp.vid = vvRootFilter then Continue;
      if Asp.vid = vvFieldFilter then Continue;
      if Asp.vid = vvNone then Continue;

      // compute path hash by walking up parents and combining vids
      cur := Node;
      cnt := 0;
      while (cur <> nil) and (cur.Parent <> nil) do
      begin
        a := PAspRec(PByte(cur) + lenNode);
        if Assigned(a) and (a.vid <> vvPatientNewRoot) then
        begin
          SetLength(vids, cnt+1);
          vids[cnt] := a.vid;
          Inc(cnt);
        end;
        cur := cur.Parent;
      end;
      // vids currently are from node up to root; reverse to root->node
      i := 0;
      h := UInt64($CBF29CE484222325); // same FNV base as generator
      for i := cnt-1 downto 0 do
      begin
        // combine same as generator: xor ordinal and multiply by prime
        h := (h xor UInt64(Ord(vids[i]))) * UInt64($100000001B3);
      end;

      PathHash := h;

      // now add fields for this object node
      AddFieldsForObjectNode(PathHash, Node);
    end;
  finally
    stack.Free;
  end;
end;

procedure TFilterFieldGenerator.AddFieldsForObjectNode(const PathHash: UInt64; ObjectNode: PVirtualNode);
var
  Asp: PAspRec;
  buf: Pointer;
  collType: Word;
  collObj: TObject;
  fields: TArray<TFilterFieldDef>;
  i: Integer;
  key: UInt64;
begin
  if ObjectNode = nil then Exit;
  Asp := PAspRec(PByte(ObjectNode) + lenNode);
  if Asp = nil then Exit;

  buf := FProvider.GetADBBuffer;
  collType := GetCollectionTypeFromDataPos(Asp.DataPos, buf);
  if collType = 0 then Exit;

  collObj := FProvider.GetCollectionByType(collType);
  if collObj = nil then Exit;

  if not TryGetFieldsFromCollection(collObj, fields) then Exit;

  for i := 0 to Length(fields)-1 do
  begin
    key := MakeFieldKey(PathHash, fields[i].FieldID);
    if not FVisitedFields.ContainsKey(key) then
    begin
      AddFieldNodeUnder(ObjectNode, fields[i]);
      FVisitedFields.Add(key, True);
    end;
  end;
end;

procedure TFilterFieldGenerator.AddFieldNodeUnder(ObjectNode: PVirtualNode; const Field: TFilterFieldDef);
var
  newNode: PVirtualNode;
  linkPos: Cardinal;
  asp: PAspRec;
begin
  if (ObjectNode = nil) or (FFilterTree = nil) then Exit;

  // Add mapped node: vid = vvFieldFilter, DataPos we store FieldID for convenience
  FLinkFile.AddNewNode(vvFieldFilter, Cardinal(Field.FieldID), ObjectNode, amAddChildLast, newNode, linkPos);

  // Optionally we can set some node properties (Dummy = FieldID)
  if Assigned(newNode) then
    newNode^.Dummy := Field.FieldID;

  // We don't need to write more into AspRec (filter tree's TaspRec is only vid for filter tree)
  // but since DataPos was set to FieldID in AddNewNode above, GetText can use Dummy or DataPos to show name.
end;

// Helper: try to extract fields from the collection object.
// This routine must be adapted to your real collection types.
// By default we try to detect methods/property names via RTTI:
// expected: method 'GetFieldCount' : Integer and 'GetFieldByIndex(Index: Integer): TPropertyIndex'
// Or a property 'FieldCount' and 'Fields[Index]'.
// If the collection type exposes a known interface/class, adapt here.
function TFilterFieldGenerator.TryGetFieldsFromCollection(AColl: TObject; out Fields: TArray<TFilterFieldDef>): Boolean;
var
  ctx: TRttiContext;
  rtype: TRttiType;
  m: TRttiMethod;
  cnt: Integer;
  i: Integer;
  // fallback: try published property 'FieldCount' and 'FieldName' style
  propCnt: TRttiProperty;
  methName: string;
begin
  Result := False;
  SetLength(Fields, 0);

  if AColl = nil then Exit;

  // Try to find method 'FieldCount' (function or property)
  ctx := TRttiContext.Create;
  try
    rtype := ctx.GetType(AColl.ClassType);

    // --- variant 1: property FieldCount and method GetFieldName(Index)
    propCnt := rtype.GetProperty('FieldCount');
    if Assigned(propCnt) then
    begin
      cnt := Integer(propCnt.GetValue(AColl).AsInteger);
      if cnt > 0 then
      begin
        SetLength(Fields, cnt);
        // try method 'GetFieldName' or 'FieldName'
        for i := 0 to cnt - 1 do
        begin
          Fields[i].FieldID := i; // fallback — actual FieldID should be retrieved from collection
          Fields[i].DisplayName := Format('Field %d', [i]);
        end;
        Result := True;
        Exit;
      end;
    end;

    // --- variant 2: method 'GetFieldCount' + 'GetFieldByIndex'
    m := rtype.GetMethod('GetFieldCount');
    if Assigned(m) then
    begin
      cnt := Integer(m.Invoke(AColl, []).AsInteger);
      if cnt > 0 then
      begin
        SetLength(Fields, cnt);
        for i := 0 to cnt - 1 do
        begin
          Fields[i].FieldID := i;
          Fields[i].DisplayName := Format('Field %d', [i]);
        end;
        Result := True;
        Exit;
      end;
    end;

    // If nothing found, try common published array 'Fields' (rare)
    // (omitted for brevity)

  finally
    ctx.Free;
  end;

  // If we reach here, we couldn't determine fields automatically
  Result := False;
end;

end.

