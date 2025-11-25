unit uFilterTreeGenerator2;

interface

uses
  System.SysUtils, System.Generics.Collections,
  VirtualTrees, VirtualStringTreeAspect, Aspects.Types,
  Aspects.Collections;

type
  TAddNewNodeFilter = procedure(NewNode, AdbNode: PVirtualNode) of object;

  TFilterTreeGenerator2 = class
  private
    FAdbTree: TVirtualStringTreeAspect;
    FFilterTree: TVirtualStringTreeAspect;
    FLinkFile: TMappedLinkFile;

    FOnAddNewNodeFilter: TAddNewNodeFilter;

    FPathToNode: TDictionary<UInt64, PVirtualNode>;
    FEmptyHash: UInt64;

    procedure ClearMaps;
    procedure AddRootAndItem(out ItemNode: PVirtualNode);
    function CombineHash(Hash: UInt64; Vid: TVtrVid): UInt64;
    function IsObjectVid(Vid: TVtrVid): Boolean;
    procedure ProcessAdbNode(AdbNode: PVirtualNode; ParentHash: UInt64;
                             ParentFilterNode: PVirtualNode);
    function AddFilterObject(ParentFilter: PVirtualNode;
                             Vid: TVtrVid;
                             AdbNode: PVirtualNode): PVirtualNode;

  public
    constructor Create(AAdbTree, AFilterTree: TVirtualStringTreeAspect;
                       ALink: TMappedLinkFile);
    destructor Destroy; override;

    procedure BuildFilterTree;

    property OnAddNewNodeFilter: TAddNewNodeFilter
      read FOnAddNewNodeFilter write FOnAddNewNodeFilter;
  end;

implementation

const
  FNV_OFFSET = UInt64($CBF29CE484222325);
  FNV_PRIME  = UInt64($100000001B3);

function TVidToU64(v: TVtrVid): UInt64;
begin
  Result := UInt64(Ord(v));
end;

constructor TFilterTreeGenerator2.Create(AAdbTree, AFilterTree: TVirtualStringTreeAspect;
                                        ALink: TMappedLinkFile);
begin
  inherited Create;
  FAdbTree := AAdbTree;
  FFilterTree := AFilterTree;
  FLinkFile := ALink;

  FPathToNode := TDictionary<UInt64, PVirtualNode>.Create;
  FEmptyHash := FNV_OFFSET;
end;

destructor TFilterTreeGenerator2.Destroy;
begin
  FPathToNode.Free;
  inherited;
end;

procedure TFilterTreeGenerator2.ClearMaps;
begin
  FPathToNode.Clear;
end;

function TFilterTreeGenerator2.CombineHash(Hash: UInt64; Vid: TVtrVid): UInt64;
begin
  Result := (Hash xor TVidToU64(Vid)) * FNV_PRIME;
end;

function TFilterTreeGenerator2.IsObjectVid(Vid: TVtrVid): Boolean;
begin
  Result := vid <> vvPatientNewRoot;
end;

procedure TFilterTreeGenerator2.AddRootAndItem(out ItemNode: PVirtualNode);
var
  Root: PVirtualNode;
  linkPos: Cardinal;
begin
  Root := FFilterTree.RootNode.FirstChild;
  if Root = nil then
    raise Exception.Create('No vvRootFilter in filter tree.');

  FLinkFile.AddNewNode(vvFilterItem, 0, Root,
                       amAddChildLast, ItemNode, linkPos);

  ItemNode.CheckType := ctCheckBox;
  ItemNode.CheckState := csUncheckedNormal;

  FPathToNode.Add(FEmptyHash, ItemNode);
end;

function TFilterTreeGenerator2.AddFilterObject
       (ParentFilter: PVirtualNode; Vid: TVtrVid; AdbNode: PVirtualNode): PVirtualNode;
var
  linkPos: Cardinal;
begin
  FLinkFile.AddNewNode(Vid, 0, ParentFilter,
                       amAddChildLast, Result, linkPos);

  Result.CheckType := ctCheckBox;
  Result.CheckState := csUncheckedNormal;

  if Assigned(FOnAddNewNodeFilter) then
    FOnAddNewNodeFilter(Result, AdbNode);
end;

procedure TFilterTreeGenerator2.ProcessAdbNode
  (AdbNode: PVirtualNode; ParentHash: UInt64; ParentFilterNode: PVirtualNode);
var
  Asp: PAspRec;
  Vid: TVtrVid;
  Hash, NewHash: UInt64;
  ObjNode, FieldNode, ObjGroup: PVirtualNode;
  LinkPos: Cardinal;
  Child: PVirtualNode;
begin
  Asp := PAspRec(PByte(AdbNode) + lenNode);
  if Asp = nil then Exit;

  Vid := Asp.vid;


  // OBJ nodes only create path
  if IsObjectVid(Vid) then
  begin
    NewHash := CombineHash(ParentHash, Vid);

    if not FPathToNode.TryGetValue(NewHash, ObjNode) then
    begin
      ObjNode := AddFilterObject(ParentFilterNode, Vid, AdbNode);

      // 1) Fields first
      // Already added in OnAddNewNodeFilter

      // 2) Add ObjectGroup
      FLinkFile.AddNewNode(vvObjectGroup, 0, ObjNode,
                           amAddChildLast, ObjGroup, LinkPos);

      ObjGroup.CheckType := ctCheckBox;
      ObjGroup.CheckState := csUncheckedNormal;

      FPathToNode.Add(NewHash, ObjNode);
    end;

    ParentFilterNode := ObjNode;   // descend
    ParentHash := NewHash;

    // Now process children into ObjGroup
    ObjGroup := ObjNode.LastChild;

    Child := AdbNode.FirstChild;
    while Child <> nil do
    begin
      ProcessAdbNode(Child, ParentHash,
                     ObjGroup);  // children go under ObjectGroup
      Child := Child.NextSibling;
    end;
  end
  else
  begin
    // FIELD/VSTOP → Already handled by OnAddNewNodeFilter, do NOT recurse in hash
    Child := AdbNode.FirstChild;
    while Child <> nil do
    begin
      ProcessAdbNode(Child, ParentHash, ParentFilterNode);
      Child := Child.NextSibling;
    end;
  end;
end;

procedure TFilterTreeGenerator2.BuildFilterTree;
var
  ItemNode: PVirtualNode;
  Child: PVirtualNode;
begin
  ClearMaps;

  AddRootAndItem(ItemNode);

  Child := FAdbTree.RootNode.FirstChild;
  while Child <> nil do
  begin
    ProcessAdbNode(Child, FEmptyHash, ItemNode);
    Child := Child.NextSibling;
  end;
end;

end.

