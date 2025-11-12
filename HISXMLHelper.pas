unit HISXMLHelper;

interface

uses
  XMLIntf, XMLDoc, SysUtils, System.Variants;

type
  THISXMLHelper = class
  public
    class function LoadXML(const AXml: string): IXMLDocument;
    class function FindNodeNoNS(const Parent: IXMLNode; const LocalName: string): IXMLNode;
    class function GetAttrValue(const Node: IXMLNode; const AttrName: string): string;
    class function GetChildValue(const Parent: IXMLNode; const LocalName: string): string;
  end;

implementation

{ THISXMLHelper }

class function THISXMLHelper.LoadXML(const AXml: string): IXMLDocument;
begin
  Result := TXMLDocument.Create(nil);
  Result.Options := Result.Options + [doNamespaceDecl];
  Result.ParseOptions := [poResolveExternals];
  //Result.Encoding := 'UTF-8';
  Result.Active := False;
  Result.LoadFromXML(AXml);
  Result.Active := True;
end;

class function THISXMLHelper.FindNodeNoNS(const Parent: IXMLNode; const LocalName: string): IXMLNode;
var
  I: Integer;
  C: IXMLNode;
begin
  Result := nil;
  if Parent = nil then Exit;

  for I := 0 to Parent.ChildNodes.Count - 1 do
  begin
    C := Parent.ChildNodes[I];
    if SameText(C.LocalName, LocalName) then
      Exit(C);

    // рекурсивно търсене в под-дървото
    Result := FindNodeNoNS(C, LocalName);
    if Assigned(Result) then
      Exit;
  end;
end;


class function THISXMLHelper.GetAttrValue(const Node: IXMLNode; const AttrName: string): string;
begin
  Result := '';
  if Assigned(Node) and Node.HasAttribute(AttrName) then
    Result := VarToStr(Node.Attributes[AttrName]);
end;

class function THISXMLHelper.GetChildValue(const Parent: IXMLNode; const LocalName: string): string;
var
  Node: IXMLNode;
begin
  Result := '';
  Node := FindNodeNoNS(Parent, LocalName);
  if Assigned(Node) then
  begin
    if Node.HasAttribute('value') then
      Result := VarToStr(Node.Attributes['value'])
    else
      Result := Trim(Node.Text);
  end;
end;

end.

