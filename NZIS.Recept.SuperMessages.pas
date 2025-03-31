unit NZIS.Recept.SuperMessages;

interface
uses
  System.SysUtils, system.Classes,Winapi.Windows, System.Generics.Collections,
  NzisSuperCollection, NZISSuperAddress, Nzis.Types, NZIS.nomenklatura, NZIS.Functions,
  NZIS.XMLschems, NZIS.SuperMessages,
  Xml.XMLIntf, Xml.XMLDoc,
  IBX.IBSQL;

type
  TReceptMessages = class(TNZISMessages)
  private
  public
    constructor create;override;
    destructor destroy;override;
    procedure FindSender(senderId: integer);


    procedure GenerateP003EGN(dateRecept: TDate; egn: string; PidType: Integer);

  end;
implementation

{ TPregledMessages }

constructor TReceptMessages.create;
begin
  inherited create;
end;

destructor TReceptMessages.destroy;
begin

  inherited;
end;

procedure TReceptMessages.FindSender(senderId: integer);
var
  i: integer;
begin
  if senderId = 0 then exit;

  for i := 0 to DoctorColl.Count - 1 do
  begin
    if DoctorColl.Items[i].DoctorId = senderId then
    begin
      self.Sender  := DoctorColl.Items[i];
    end;
  end;
end;

procedure TReceptMessages.GenerateP003EGN(dateRecept: TDate; egn: string; PidType: Integer);
var
  mess: TMessageP003;
  oXml: IXMLDocument;
  ADeput: TPerformerItem;
begin
  GenXML.Clear;
  mess := TMessageP003.Create;
  mess.Header.SenderID := FPerformer.Pmi;

  mess.FillXmlStreamEGN(dateRecept, egn, PidType);
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
