unit uFilterTreeUtils;

interface

uses
  System.SysUtils, VirtualTrees, Aspects.Types, Aspects.Collections, VirtualStringTreeAspect;

type
  // Някои помощни функции за работа с твоите структури
  TFilterUtils = class
  public
    class function GetAspRec(ATree: TVirtualStringTreeAspect; Node: PVirtualNode): PAspRec; static;
    class function GetVid(ATree: TVirtualStringTreeAspect; Node: PVirtualNode): TVtrVid; static;
    class function NodeHasVid(ATree: TVirtualStringTreeAspect; Node: PVirtualNode; const AVid: TVtrVid): Boolean; static;
  end;

implementation

{ TFilterUtils }

class function TFilterUtils.GetAspRec(ATree: TVirtualStringTreeAspect; Node: PVirtualNode): PAspRec;
begin
  if (ATree = nil) or (Node = nil) then
    Exit(nil);
  // предполага се, че GetNodeData връща PAspRec или pointer към TAspRec
  // Ако в твоя проект функцията се казва различно, просто коригирай тук
  Result := PAspRec(ATree.GetNodeData(Node));
end;

class function TFilterUtils.GetVid(ATree: TVirtualStringTreeAspect; Node: PVirtualNode): TVtrVid;
var
  Asp: PAspRec;
begin
  Asp := GetAspRec(ATree, Node);
  if Asp = nil then
    Result := vvNone
  else
    Result := Asp.vid;
end;

class function TFilterUtils.NodeHasVid(ATree: TVirtualStringTreeAspect; Node: PVirtualNode; const AVid: TVtrVid): Boolean;
begin
  Result := GetVid(ATree, Node) = AVid;
end;

end.

