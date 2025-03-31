unit NZIS.MedObshti.SuperMessages;

interface
uses
  System.SysUtils, system.Classes,Winapi.Windows, System.Generics.Collections,system.StrUtils,
  NzisSuperCollection, NZISSuperAddress, Nzis.Types, NZIS.nomenklatura, NZIS.Functions,
  NZIS.XMLschems, NZIS.SuperMessages,
  Xml.XMLIntf, Xml.XMLDoc,
  IBX.IBSQL, Vcl.Dialogs;

type
  TMedObshtiMessages = class(TNZISMessages)
  public
    procedure GenerateC015(UIN: string; fromDate, toDate: TDate);
    procedure GenerateC041(medBel: TMedBelItem);
    procedure GenerateC045(medBel: TMedBelItem);
    procedure GenerateC023(Allergy: TAllergyItem);

  end;
implementation

{ TMedObshtiMessages }

procedure TMedObshtiMessages.GenerateC015(UIN: string; fromDate, toDate: TDate);
var
  mess: TMessageC015;
  oXml: IXMLDocument;
  i: Integer;
begin
  try
    GenXML.Clear;
    mess := TMessageC015.Create;

    mess.Sender := Self.FPerformer;
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
  finally
    FreeAndNil(mess);
  end;

end;

procedure TMedObshtiMessages.GenerateC023(Allergy: TAllergyItem);
var
  mess: TMessageC041;
  oXml: IXMLDocument;
  i: Integer;
begin
  try
    GenXML.Clear;
    mess := TMessageC041.Create;

    mess.Sender := Self.FPerformer;
    mess.Doctor := Self.FPerformer;
    //mess.MedBel := medBel;

    mess.FillXmlSream;
    mess.XMLStream.Position := 0;
    oXml := TXMLDocument.Create(nil);
    oXml.LoadFromStream(mess.XMLStream);
    oXml.Encoding := 'UTF-8';
    mess.XMLStream.Size := 0;
    oXml.SaveToStream(mess.XMLStream);
    mess.XMLStream.Position := 0;
    GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  finally
    FreeAndNil(mess);
  end;

end;

procedure TMedObshtiMessages.GenerateC041(medBel: TMedBelItem);
var
  mess: TMessageC041;
  oXml: IXMLDocument;
  i: Integer;
begin
  try
    GenXML.Clear;
    mess := TMessageC041.Create;

    mess.Sender := Self.FPerformer;
    mess.Doctor := Self.FPerformer;
    mess.MedBel := medBel;

    mess.FillXmlSream;
    mess.XMLStream.Position := 0;
    oXml := TXMLDocument.Create(nil);
    oXml.LoadFromStream(mess.XMLStream);
    oXml.Encoding := 'UTF-8';
    mess.XMLStream.Size := 0;
    oXml.SaveToStream(mess.XMLStream);
    mess.XMLStream.Position := 0;
    GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  finally
    FreeAndNil(mess);
  end;

end;

procedure TMedObshtiMessages.GenerateC045(medBel: TMedBelItem);
var
  mess: TMessageC045;
  oXml: IXMLDocument;
  i: Integer;
begin
  try
    GenXML.Clear;
    mess := TMessageC045.Create;

    mess.Sender := Self.FPerformer;
    mess.Doctor := Self.FPerformer;
    mess.MedBel := medBel;

    mess.FillXmlSream;
    mess.XMLStream.Position := 0;
    oXml := TXMLDocument.Create(nil);
    oXml.LoadFromStream(mess.XMLStream);
    oXml.Encoding := 'UTF-8';
    mess.XMLStream.Size := 0;
    oXml.SaveToStream(mess.XMLStream);
    mess.XMLStream.Position := 0;
    GenXML.LoadFromStream(mess.XMLStream, TEncoding.UTF8);
  finally
    FreeAndNil(mess);
  end;

end;

end.
