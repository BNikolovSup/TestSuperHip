unit uFilterMagicIndex;

interface

uses
  System.SysUtils, System.Generics.Collections, VirtualTrees,
  Aspects.Types, Aspects.Collections;

type
  // Прост wrapper, който прави PathIndex за филтърното дърво (в TMappedLinkFile има PathIndex за ADB)
  TFilterMagicIndex = class
  private
    FLinkFile: TMappedLinkFile; // mapped link file за филтърното дърво
  public
    constructor Create(const ALinkFile: TMappedLinkFile);
    procedure BuildFilterPathIndex; // пълно rebuild
    function GetBucketBySig(const Sig: UInt64): TList<PVirtualNode>;
    function ComputeSigForFilterNode(Node: PVirtualNode): UInt64;
  end;

implementation

uses
  System.Classes;

{ TFilterMagicIndex }

constructor TFilterMagicIndex.Create(const ALinkFile: TMappedLinkFile);
begin
  if ALinkFile = nil then
    raise Exception.Create('TFilterMagicIndex: ALinkFile = nil');
  FLinkFile := ALinkFile;
end;

procedure TFilterMagicIndex.BuildFilterPathIndex;
var
  linkPos: Cardinal;
  node: PVirtualNode;
  sig: UInt64;
  lst: TList<PVirtualNode>;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  testData: PAspRec;
begin
  // Изчисти старото (ако има)
  for lst in FLinkFile.PathIndex.Values do
    lst.Free;
  FLinkFile.PathIndex.Clear;

  // Обхождаме link-file последователно (във вашия формат)
  pCardinalData := pointer(PByte(FLinkFile.Buf));
  FPosLinkData := pCardinalData^;
  linkPos := 100;
  while linkPos < FPosLinkData do
  begin
    node := pointer(PByte(FLinkFile.Buf) + linkPos);
    Inc(linkPos, LenData);
    testData := pointer(PByte(node) + lenNode);
    if node = nil then Continue;

    sig := FLinkFile.ComputeNodePathSig(node);
    if not FLinkFile.PathIndex.TryGetValue(sig, lst) then
    begin
      lst := TList<PVirtualNode>.Create;
      FLinkFile.PathIndex.Add(sig, lst);
    end;
    lst.Add(node);
  end;
end;

function TFilterMagicIndex.ComputeSigForFilterNode(Node: PVirtualNode): UInt64;
begin
  // Използваме същата ComputeNodePathSig реализирана в TMappedLinkFile
  Result := FLinkFile.ComputeNodePathSig(Node);
end;

function TFilterMagicIndex.GetBucketBySig(const Sig: UInt64): TList<PVirtualNode>;
var
  lst: TList<PVirtualNode>;
begin
  if FLinkFile.PathIndex.TryGetValue(Sig, lst) then
    Result := lst
  else
    Result := nil;
end;

end.

