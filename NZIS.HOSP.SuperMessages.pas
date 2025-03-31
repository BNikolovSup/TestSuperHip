unit NZIS.HOSP.SuperMessages;

interface
uses
  System.SysUtils, system.Classes,Winapi.Windows, System.Generics.Collections,system.StrUtils,
  NzisSuperCollection, NZISSuperAddress, Nzis.Types, NZIS.nomenklatura, NZIS.Functions,
  NZIS.XMLschems, NZIS.SuperMessages,
  Xml.XMLIntf, Xml.XMLDoc,
  IBX.IBSQL, Vcl.Dialogs;

type
  THospMessages = class(TNZISMessages)
  public
    procedure GenerateH011(egn: string; pidType: TidentifierTypeBaseCL004);
    procedure GenerateH001(egn, practiceNumber: string; pidType: TidentifierTypeBaseCL004);
  end;
implementation

{ TMDNMessages }

procedure THospMessages.GenerateH001(egn, practiceNumber: string; pidType: TidentifierTypeBaseCL004);
var
  mess: TMessageH001;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageH001.Create;
  mess.Sender := Self.FPerformer;
  mess.EGN := Egn;
  mess.PidType := PidType;
  mess.Doctor := Self.FPerformer;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

procedure THospMessages.GenerateH011(egn: string; pidType: TidentifierTypeBaseCL004);
var
  mess: TMessageH011;
  oXml: IXMLDocument;
  i: Integer;
begin
  GenXML.Clear;
  mess := TMessageH011.Create;
  mess.Sender := Self.FPerformer;
  mess.EGN := Egn;
  mess.PidType := PidType;
  mess.Doctor := Self.FPerformer;

  mess.FillXmlSream;
  mess.XMLStream.Position := 0;
  oXml := TXMLDocument.Create(nil);
  oXml.LoadFromStream(mess.XMLStream);
  oXml.Encoding := 'UTF-8';
  mess.XMLStream.Size := 0;
  oXml.SaveToStream(mess.XMLStream);
  mess.XMLStream.Position := 0;
  GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
end;

end.
