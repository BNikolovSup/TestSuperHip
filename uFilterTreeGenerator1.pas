unit uFilterTreeGenerator1;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  VirtualTrees, Aspects.Types, VirtualStringTreeAspect, Aspects.Collections;

type
  TAddNewNodeFilter = procedure(NewNode, adnNode: PVirtualNode) of object;
  /// Нов генератор: уникалност по ПЪЛЕН път (Path of TVtrVid)
  TFilterTreeGenerator1 = class
  private
    FAdbTree: TVirtualStringTreeAspect;
    FFilterTree: TVirtualStringTreeAspect;
    FLinkFile: TMappedLinkFile;

    // map: PathHash -> FilterNode (PVirtualNode)
    FPathToNode: TDictionary<UInt64, PVirtualNode>;

    // set of created (PathHash) used to avoid double-creation (not strictly necessary
    // because FPathToNode checks existence, but kept for clarity)
    FCreatedPathHashes: TDictionary<UInt64, Boolean>;

    // temporary stack for path vids during recursion
    FPathStack: TArray<TVtrVid>;
    FPathStackLength: Integer;
    FEmptyPathHash: UInt64;
    FOnAddNewNodeFilter: TAddNewNodeFilter;

    procedure ClearMaps;
    procedure EnsureRootPresent;
    procedure BuildFromAdb;
    procedure ProcessAdbNode(AdbNode: PVirtualNode; ParentPathHash: UInt64);
    procedure PushVid(v: TVtrVid; out NewHash: UInt64);
    procedure PopVid;
    function CombineHashWithVid(const BaseHash: UInt64; v: TVtrVid): UInt64;
    function CurrentPathHash: UInt64;
  public
    constructor Create(const AAdbTree, AFilterTree: TVirtualStringTreeAspect; const ALinkFile: TMappedLinkFile);
    destructor Destroy; override;

    procedure BuildFilterTree;

    property OnAddNewNodeFilter: TAddNewNodeFilter read FOnAddNewNodeFilter write FOnAddNewNodeFilter;
  end;

implementation

{ TFilterTreeGenerator1 }

uses
  // no heavy units here
  System.Math;

const
  // FNV-1a 64-bit constants
  FNV_OFFSET_BASIS: UInt64 = UInt64($CBF29CE484222325);
  FNV_PRIME: UInt64 = UInt64($100000001B3);

function VidToUInt64(v: TVtrVid): UInt64;
begin
  Result := UInt64(Ord(v));
end;

constructor TFilterTreeGenerator1.Create(const AAdbTree, AFilterTree: TVirtualStringTreeAspect; const ALinkFile: TMappedLinkFile);
begin
  if (AAdbTree = nil) or (AFilterTree = nil) or (ALinkFile = nil) then
    raise Exception.Create('TFilterTreeGenerator1.Create: invalid parameters');

  FAdbTree := AAdbTree;
  FFilterTree := AFilterTree;
  FLinkFile := ALinkFile;

  FPathToNode := TDictionary<UInt64, PVirtualNode>.Create;
  FCreatedPathHashes := TDictionary<UInt64, Boolean>.Create;

  SetLength(FPathStack, 32); // usually shallow, 32 is more than enough
  FPathStackLength := 0;

  // empty path hash = FNV offset (no vids hashed yet)
  FEmptyPathHash := FNV_OFFSET_BASIS;
end;

destructor TFilterTreeGenerator1.Destroy;
begin
  FPathToNode.Free;
  FCreatedPathHashes.Free;
  inherited;
end;

procedure TFilterTreeGenerator1.ClearMaps;
begin
  FPathToNode.Clear;
  FCreatedPathHashes.Clear;
  FPathStackLength := 0;
end;

procedure TFilterTreeGenerator1.EnsureRootPresent;
var
  rootChild: PVirtualNode;
  initialHash: UInt64;
begin
  // Filter tree must already have vvRootFilter created by loader
  if (FFilterTree = nil) or (FFilterTree.RootNode = nil) or (FFilterTree.RootNode.FirstChild = nil) then
    raise Exception.Create('TFilterTreeGenerator1.EnsureRootPresent: vvRootFilter not present. Call loader first.');

  rootChild := FFilterTree.RootNode.FirstChild;

  // Map empty path hash -> rootChild
  initialHash := FEmptyPathHash;
  if not FPathToNode.ContainsKey(initialHash) then
    FPathToNode.Add(initialHash, rootChild);

  if not FCreatedPathHashes.ContainsKey(initialHash) then
    FCreatedPathHashes.Add(initialHash, True);
end;

procedure TFilterTreeGenerator1.BuildFilterTree;
begin
  ClearMaps;
  EnsureRootPresent;
  BuildFromAdb;
end;

procedure TFilterTreeGenerator1.BuildFromAdb;
var
  node: PVirtualNode;
  // Start traversal from first top-level node under ADB root
  startNode: PVirtualNode;
  top: PVirtualNode;
begin
  // iterate over ADB's top-level children
  startNode := FAdbTree.RootNode.FirstChild;
  node := startNode;
  while Assigned(node) do
  begin
    // Process each child of the ADB root with empty parent path hash
    ProcessAdbNode(node, FEmptyPathHash);
    node := node.NextSibling;
  end;
end;

procedure TFilterTreeGenerator1.ProcessAdbNode(AdbNode: PVirtualNode; ParentPathHash: UInt64);
var
  Asp: PAspRec;
  vid: TVtrVid;
  childPathHash, parentHash, newHash: UInt64;
  parentFilterNode, newFilterNode: PVirtualNode;
  linkPos: Cardinal;
  child: PVirtualNode;
 // coll: TBaseCollection;
  // local copy of path length to avoid global changes if needed
begin
  if AdbNode = nil then Exit;

  // get AspRec by pointer arithmetic (lenNode is global)
  Asp := PAspRec(PByte(AdbNode) + lenNode);
  if Asp = nil then
  begin
    // continue with children but keep the same parent path
    child := AdbNode.FirstChild;
    while Assigned(child) do
    begin
      ProcessAdbNode(child, ParentPathHash);
      child := child.NextSibling;
    end;
    Exit;
  end;

  vid := Asp.vid;

  // If vid is vvPatientNewRoot, treat it as transparent: DO NOT add to path,
  // but continue processing children with same parent path.
  if vid = vvPatientNewRoot then
  begin
    child := AdbNode.FirstChild;
    while Assigned(child) do
    begin
      ProcessAdbNode(child, ParentPathHash);
      child := child.NextSibling;
    end;
    Exit;
  end;

  // compute child path hash = Combine(parentPathHash, vid)
  childPathHash := CombineHashWithVid(ParentPathHash, vid);

  // find parent filter node for ParentPathHash
  if not FPathToNode.TryGetValue(ParentPathHash, parentFilterNode) then
    raise Exception.CreateFmt('TFilterTreeGenerator1: parent filter node not found for hash %d', [ParentPathHash]);

  // If this path is not yet created in the filter tree, create it now
  if not FPathToNode.ContainsKey(childPathHash) then
  begin
    // Create mapped node in filter tree under parentFilterNode
    // тука се добавя всеки възел на обект;

    FLinkFile.AddNewNode(vid, 0, parentFilterNode, amAddChildLast, newFilterNode, linkPos);
    if Assigned(FOnAddNewNodeFilter) then
      FOnAddNewNodeFilter(newFilterNode, AdbNode);

    // register mapping: path hash -> node
    FPathToNode.Add(childPathHash, newFilterNode);
    FCreatedPathHashes.Add(childPathHash, True);
  end;

  // Whether created now or existed, we need to recurse into children using the new path
  // Get the filter node corresponding to this path (it must exist now)
  newFilterNode := FPathToNode[childPathHash];

  // recurse children: the parent hash is now childPathHash
  child := AdbNode.FirstChild;
  while Assigned(child) do
  begin
    ProcessAdbNode(child, childPathHash);
    child := child.NextSibling;
  end;
end;

// Push vid onto path stack and return the new hash (not used here because we compute
// child hash directly from parent hash). Provided for completeness / future use.
procedure TFilterTreeGenerator1.PushVid(v: TVtrVid; out NewHash: UInt64);
begin
  if FPathStackLength >= Length(FPathStack) then
    SetLength(FPathStack, Length(FPathStack) * 2);
  FPathStack[FPathStackLength] := v;
  Inc(FPathStackLength);
  // compute new hash incrementally
  NewHash := CurrentPathHash;
end;

procedure TFilterTreeGenerator1.PopVid;
begin
  if FPathStackLength > 0 then
    Dec(FPathStackLength);
end;

// Combine a base hash with an additional vid (FNV-1a style update)
function TFilterTreeGenerator1.CombineHashWithVid(const BaseHash: UInt64; v: TVtrVid): UInt64;
var
  h: UInt64;
begin
  // FNV-1a step: xor with byte(s) of vid then multiply by prime.
  // We'll xor with the ordinal (as low bits) and then multiply.
  h := BaseHash;
  h := (h xor VidToUInt64(v)) * FNV_PRIME;
  Result := h;
end;

function TFilterTreeGenerator1.CurrentPathHash: UInt64;
var
  i: Integer;
  h: UInt64;
begin
  h := FEmptyPathHash;
  for i := 0 to FPathStackLength - 1 do
    h := CombineHashWithVid(h, FPathStack[i]);
  Result := h;
end;

end.

