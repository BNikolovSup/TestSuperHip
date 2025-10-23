unit Nzis.XMLHelper;

interface
uses
  System.Classes, system.SysUtils,
  Xml.XMLIntf, Xml.XMLDoc, System.Variants,
  RealObj.RealHipp, RealNasMesto, Aspects.Functions,
  Table.NzisReqResp, Table.PatientNew,
  msgX001, msgX002, msgX003, msgX013;


type

TNzisXMLHelper = class(TObject)

public
  FNasMesto: TRealNasMestoAspects;
  constructor create;
  function FmsgX001(msg: TNzisReqRespItem): msgX001.IXMLMessageType;
  function FmsgX013(msg: TNzisReqRespItem): msgX013.IXMLMessageType;
  procedure FillX001InPat(msg: TNzisReqRespItem; pat: TRealPatientNewItem);
  procedure FillX013InPat(msg: TNzisReqRespItem; pat: TRealPatientNewItem);

end;

implementation

{ TNzisXMLHelper }

function SafeAttr(Node: IXMLNode; const AttrName: string): string;
begin
  Result := '';
  if Assigned(Node) and Node.HasAttribute(AttrName) then
    Result := VarToStrDef(Node.Attributes[AttrName], '');
end;

constructor TNzisXMLHelper.create;
begin
  inherited create;

end;

procedure TNzisXMLHelper.FillX001InPat(msg: TNzisReqRespItem;
  pat: TRealPatientNewItem);
var
  AmsgX001: msgX001.IXMLMessageType;
  brdDateStr: string;
  PidType: Byte;
  ekatte: string;
  nasMest: TRealNasMestoItem;
begin
  AmsgX001 := self.FmsgX001(msg);
  if pat.PRecord = nil then
  begin
    New(pat.PRecord);
    pat.PRecord.Logical := [];
  end;


  pat.PRecord.EGN := AmsgX001.Contents.Subject.Identifier.Value;
  pat.PRecord.FNAME := AmsgX001.Contents.Subject.Name.Given.Value;
  pat.PRecord.SNAME := AmsgX001.Contents.Subject.Name.Middle.Value;
  pat.PRecord.LNAME := AmsgX001.Contents.Subject.Name.Family.Value;
  brdDateStr := AmsgX001.Contents.Subject.BirthDate.Value;
  pat.PRecord.BIRTH_DATE := ASPStrToDate(brdDateStr);
  PidType := StrToInt(AmsgX001.Contents.Subject.IdentifierType.Value);
  case PidType of
    1: Include(pat.PRecord.Logical, PID_TYPE_E);
    2: Include(pat.PRecord.Logical, PID_TYPE_L);
    3: Include(pat.PRecord.Logical, PID_TYPE_S);
    5: Include(pat.PRecord.Logical, PID_TYPE_F);
    6: Include(pat.PRecord.Logical, PID_TYPE_B);
  end;
  ekatte := SafeAttr(AmsgX001.Contents.Subject.Address.Ekatte as IXMLNode, 'value');
  //if not  VarIsNull(AmsgX001.Contents.Subject.Address.Ekatte.NodeValue.['ekatte']) then
//  begin
//    ekatte := AmsgX001.Contents.Subject.Address.Ekatte.Value;
//  end
//  else
//  begin
//    Exit;
//  end;
  pat.FAdresi[0].Ekatte := ekatte;

  nasMest := FNasMesto.FindNasMestFromEkatte(ekatte);
  if nasMest <> nil then
  begin
    pat.FAdresi[0].FObl := nasMest.FObl;
    pat.FAdresi[0].FObsht := nasMest.FObsh;
    pat.FAdresi[0].RZOKR := nasMest.RzokR;
    pat.FAdresi[0].NasMesto := nasMest.NasMestoName;
  end;

end;

procedure TNzisXMLHelper.FillX013InPat(msg: TNzisReqRespItem;
  pat: TRealPatientNewItem);
var
  AmsgX013: msgX013.IXMLMessageType;
  brdDateStr: string;
  PidType: Byte;
  ekatte: string;
  nasMest: TRealNasMestoItem;
begin
  AmsgX013 := self.FmsgX013(msg);
  if pat.PRecord = nil then
  begin
    New(pat.PRecord);
    pat.PRecord.Logical := [];
  end;


  pat.PRecord.EGN := AmsgX013.Contents.Subject.Identifier.Value;
  pat.PRecord.FNAME := AmsgX013.Contents.Subject.Name.Given.Value;
  pat.PRecord.SNAME := AmsgX013.Contents.Subject.Name.Middle.Value;
  pat.PRecord.LNAME := AmsgX013.Contents.Subject.Name.Family.Value;
  brdDateStr := AmsgX013.Contents.Subject.BirthDate.Value;
  pat.PRecord.BIRTH_DATE := ASPStrToDate(brdDateStr);
  PidType := StrToInt(AmsgX013.Contents.Subject.IdentifierType.Value);
  case PidType of
    1: Include(pat.PRecord.Logical, PID_TYPE_E);
    2: Include(pat.PRecord.Logical, PID_TYPE_L);
    3: Include(pat.PRecord.Logical, PID_TYPE_S);
    5: Include(pat.PRecord.Logical, PID_TYPE_F);
    6: Include(pat.PRecord.Logical, PID_TYPE_B);
  end;
  ekatte := SafeAttr(AmsgX013.Contents.Subject.Address.Ekatte as IXMLNode, 'value');
  pat.FAdresi[0].Ekatte := ekatte;

  nasMest := FNasMesto.FindNasMestFromEkatte(ekatte);
  if nasMest <> nil then
  begin
    pat.FAdresi[0].FObl := nasMest.FObl;
    pat.FAdresi[0].FObsht := nasMest.FObsh;
    pat.FAdresi[0].RZOKR := nasMest.RzokR;
    pat.FAdresi[0].NasMesto := nasMest.NasMestoName;
  end;
end;

function TNzisXMLHelper.FmsgX001(msg: TNzisReqRespItem): msgX001.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
  try
    oXml.LoadFromStream(StringStream);

  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  result := msgX001.Getmessage(oXml);
  if oXml.Active then
  begin
    oXml.ChildNodes.Clear;
    oXml.Active := False;
  end;
  oxml := nil;
end;

function TNzisXMLHelper.FmsgX013(
  msg: TNzisReqRespItem): msgX013.IXMLMessageType;
var
  oXml: IXMLDocument;
  StringStream: TStringStream;
begin
  oXml := TXMLDocument.Create(nil);
  StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
  try
    oXml.LoadFromStream(StringStream);

  finally
    StringStream.Free;
  end;
  oXml.Encoding := 'UTF-8';
  result := msgX013.Getmessage(oXml);
  if oXml.Active then
  begin
    oXml.ChildNodes.Clear;
    oXml.Active := False;
  end;
  oxml := nil;
end;

end.
