
{**********************************************}
{                                              }
{               XML Data Binding               }
{                                              }
{         Generated on: 4.2.2025 ã. 12:56:14   }
{       Generated from: D:\NzisSpec\x004.xml   }
{   Settings stored in: D:\NzisSpec\x004.xdb   }
{                                              }
{**********************************************}

unit x004;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLMessageType = interface;
  IXMLHeaderType = interface;
  IXMLSenderType = interface;
  IXMLSenderIdType = interface;
  IXMLRecipientType = interface;
  IXMLRecipientIdType = interface;
  IXMLMessageIdType = interface;
  IXMLMessageType2 = interface;
  IXMLCreatedOnType = interface;
  IXMLContentsType = interface;
  IXMLNrnExaminationType = interface;
  IXMLStatusType = interface;
  IXMLWarningsType = interface;
  IXMLWarningsTypeList = interface;
  IXMLCodeType = interface;
  IXMLDescriptionType = interface;
  IXMLSourceType = interface;
  IXMLNrnTargetType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{E314DCAA-C3BD-4D15-ABE2-86180A354825}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    function Get_Warnings: IXMLWarningsTypeList;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
    property Warnings: IXMLWarningsTypeList read Get_Warnings;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{F7F6A83E-0B1F-4660-9494-0AD981B62708}']
    { Property Accessors }
    function Get_Sender: IXMLSenderType;
    function Get_SenderId: IXMLSenderIdType;
    function Get_Recipient: IXMLRecipientType;
    function Get_RecipientId: IXMLRecipientIdType;
    function Get_MessageId: IXMLMessageIdType;
    function Get_MessageType: IXMLMessageType2;
    function Get_CreatedOn: IXMLCreatedOnType;
    { Methods & Properties }
    property Sender: IXMLSenderType read Get_Sender;
    property SenderId: IXMLSenderIdType read Get_SenderId;
    property Recipient: IXMLRecipientType read Get_Recipient;
    property RecipientId: IXMLRecipientIdType read Get_RecipientId;
    property MessageId: IXMLMessageIdType read Get_MessageId;
    property MessageType: IXMLMessageType2 read Get_MessageType;
    property CreatedOn: IXMLCreatedOnType read Get_CreatedOn;
  end;

{ IXMLSenderType }

  IXMLSenderType = interface(IXMLNode)
    ['{37B0EDA6-B795-4905-8922-7B6A212E1816}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{39E71C76-50AF-414E-BBC2-F141D2720051}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{61139894-9F18-4B58-AEA0-377300ADC283}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{6E2AC784-3953-4E4C-AE99-8BCE9159A614}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{B40FCCBA-2E1A-4632-951C-44E157FB3862}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{F0BEC549-19DA-4866-BF49-FA8B5036580F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{B90B166B-2EA3-497C-8D2A-9C554A78FBDF}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{175D250C-C95F-4224-93B1-D0B2279B8800}']
    { Property Accessors }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_Status: IXMLStatusType;
    { Methods & Properties }
    property NrnExamination: IXMLNrnExaminationType read Get_NrnExamination;
    property Status: IXMLStatusType read Get_Status;
  end;

{ IXMLNrnExaminationType }

  IXMLNrnExaminationType = interface(IXMLNode)
    ['{03D4552A-60A0-4B71-A2D7-E2810E9D4075}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLStatusType }

  IXMLStatusType = interface(IXMLNode)
    ['{53FBA254-8CF5-4C73-B54A-2E19E064D8C7}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLWarningsType }

  IXMLWarningsType = interface(IXMLNode)
    ['{B3E70778-D8E2-43C5-8417-83448FE21C17}']
    { Property Accessors }
    function Get_Code: IXMLCodeType;
    function Get_Description: IXMLDescriptionType;
    function Get_Source: IXMLSourceType;
    function Get_NrnTarget: IXMLNrnTargetType;
    { Methods & Properties }
    property Code: IXMLCodeType read Get_Code;
    property Description: IXMLDescriptionType read Get_Description;
    property Source: IXMLSourceType read Get_Source;
    property NrnTarget: IXMLNrnTargetType read Get_NrnTarget;
  end;

{ IXMLWarningsTypeList }

  IXMLWarningsTypeList = interface(IXMLNodeCollection)
    ['{9382E4E2-B1B8-4E98-B5C8-1833DB0930F4}']
    { Methods & Properties }
    function Add: IXMLWarningsType;
    function Insert(const Index: Integer): IXMLWarningsType;

    function Get_Item(Index: Integer): IXMLWarningsType;
    property Items[Index: Integer]: IXMLWarningsType read Get_Item; default;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{01F0A125-80E1-4878-88AD-CEADE18DD3BD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDescriptionType }

  IXMLDescriptionType = interface(IXMLNode)
    ['{10E344CF-A986-4242-97BE-F0D191F040F1}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSourceType }

  IXMLSourceType = interface(IXMLNode)
    ['{069C27C4-3D14-42EC-990F-969BBDB95B97}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnTargetType }

  IXMLNrnTargetType = interface(IXMLNode)
    ['{E7F2F20C-A6A7-4F02-96D1-2EE35C06750F}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ Forward Decls }

  TXMLMessageType = class;
  TXMLHeaderType = class;
  TXMLSenderType = class;
  TXMLSenderIdType = class;
  TXMLRecipientType = class;
  TXMLRecipientIdType = class;
  TXMLMessageIdType = class;
  TXMLMessageType2 = class;
  TXMLCreatedOnType = class;
  TXMLContentsType = class;
  TXMLNrnExaminationType = class;
  TXMLStatusType = class;
  TXMLWarningsType = class;
  TXMLWarningsTypeList = class;
  TXMLCodeType = class;
  TXMLDescriptionType = class;
  TXMLSourceType = class;
  TXMLNrnTargetType = class;

{ TXMLMessageType }

  TXMLMessageType = class(TXMLNode, IXMLMessageType)
  private
    FWarnings: IXMLWarningsTypeList;
  protected
    { IXMLMessageType }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    function Get_Warnings: IXMLWarningsTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLHeaderType }

  TXMLHeaderType = class(TXMLNode, IXMLHeaderType)
  protected
    { IXMLHeaderType }
    function Get_Sender: IXMLSenderType;
    function Get_SenderId: IXMLSenderIdType;
    function Get_Recipient: IXMLRecipientType;
    function Get_RecipientId: IXMLRecipientIdType;
    function Get_MessageId: IXMLMessageIdType;
    function Get_MessageType: IXMLMessageType2;
    function Get_CreatedOn: IXMLCreatedOnType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSenderType }

  TXMLSenderType = class(TXMLNode, IXMLSenderType)
  protected
    { IXMLSenderType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLSenderIdType }

  TXMLSenderIdType = class(TXMLNode, IXMLSenderIdType)
  protected
    { IXMLSenderIdType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLRecipientType }

  TXMLRecipientType = class(TXMLNode, IXMLRecipientType)
  protected
    { IXMLRecipientType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLRecipientIdType }

  TXMLRecipientIdType = class(TXMLNode, IXMLRecipientIdType)
  protected
    { IXMLRecipientIdType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLMessageIdType }

  TXMLMessageIdType = class(TXMLNode, IXMLMessageIdType)
  protected
    { IXMLMessageIdType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLMessageType2 }

  TXMLMessageType2 = class(TXMLNode, IXMLMessageType2)
  protected
    { IXMLMessageType2 }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLCreatedOnType }

  TXMLCreatedOnType = class(TXMLNode, IXMLCreatedOnType)
  protected
    { IXMLCreatedOnType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLContentsType }

  TXMLContentsType = class(TXMLNode, IXMLContentsType)
  protected
    { IXMLContentsType }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_Status: IXMLStatusType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNrnExaminationType }

  TXMLNrnExaminationType = class(TXMLNode, IXMLNrnExaminationType)
  protected
    { IXMLNrnExaminationType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLStatusType }

  TXMLStatusType = class(TXMLNode, IXMLStatusType)
  protected
    { IXMLStatusType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLWarningsType }

  TXMLWarningsType = class(TXMLNode, IXMLWarningsType)
  protected
    { IXMLWarningsType }
    function Get_Code: IXMLCodeType;
    function Get_Description: IXMLDescriptionType;
    function Get_Source: IXMLSourceType;
    function Get_NrnTarget: IXMLNrnTargetType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLWarningsTypeList }

  TXMLWarningsTypeList = class(TXMLNodeCollection, IXMLWarningsTypeList)
  protected
    { IXMLWarningsTypeList }
    function Add: IXMLWarningsType;
    function Insert(const Index: Integer): IXMLWarningsType;

    function Get_Item(Index: Integer): IXMLWarningsType;
  end;

{ TXMLCodeType }

  TXMLCodeType = class(TXMLNode, IXMLCodeType)
  protected
    { IXMLCodeType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLDescriptionType }

  TXMLDescriptionType = class(TXMLNode, IXMLDescriptionType)
  protected
    { IXMLDescriptionType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLSourceType }

  TXMLSourceType = class(TXMLNode, IXMLSourceType)
  protected
    { IXMLSourceType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLNrnTargetType }

  TXMLNrnTargetType = class(TXMLNode, IXMLNrnTargetType)
  protected
    { IXMLNrnTargetType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ Global Functions }

function Getmessage(Doc: IXMLDocument): IXMLMessageType;
function Loadmessage(const FileName: string): IXMLMessageType;
function Newmessage: IXMLMessageType;

const
  TargetNamespace = 'https://www.his.bg';

implementation

{ Global Functions }

function Getmessage(Doc: IXMLDocument): IXMLMessageType;
begin
  Result := Doc.GetDocBinding('message', TXMLMessageType, TargetNamespace) as IXMLMessageType;
end;

function Loadmessage(const FileName: string): IXMLMessageType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('message', TXMLMessageType, TargetNamespace) as IXMLMessageType;
end;

function Newmessage: IXMLMessageType;
begin
  Result := NewXMLDocument.GetDocBinding('message', TXMLMessageType, TargetNamespace) as IXMLMessageType;
end;

{ TXMLMessageType }

procedure TXMLMessageType.AfterConstruction;
begin
  RegisterChildNode('header', TXMLHeaderType);
  RegisterChildNode('contents', TXMLContentsType);
  RegisterChildNode('warnings', TXMLWarningsType);
  FWarnings := CreateCollection(TXMLWarningsTypeList, IXMLWarningsType, 'warnings') as IXMLWarningsTypeList;
  inherited;
end;

function TXMLMessageType.Get_Header: IXMLHeaderType;
begin
  Result := ChildNodes['header'] as IXMLHeaderType;
end;

function TXMLMessageType.Get_Contents: IXMLContentsType;
begin
  Result := ChildNodes['contents'] as IXMLContentsType;
end;

function TXMLMessageType.Get_Warnings: IXMLWarningsTypeList;
begin
  Result := FWarnings;
end;

{ TXMLHeaderType }

procedure TXMLHeaderType.AfterConstruction;
begin
  RegisterChildNode('sender', TXMLSenderType);
  RegisterChildNode('senderId', TXMLSenderIdType);
  RegisterChildNode('recipient', TXMLRecipientType);
  RegisterChildNode('recipientId', TXMLRecipientIdType);
  RegisterChildNode('messageId', TXMLMessageIdType);
  RegisterChildNode('messageType', TXMLMessageType2);
  RegisterChildNode('createdOn', TXMLCreatedOnType);
  inherited;
end;

function TXMLHeaderType.Get_Sender: IXMLSenderType;
begin
  Result := ChildNodes['sender'] as IXMLSenderType;
end;

function TXMLHeaderType.Get_SenderId: IXMLSenderIdType;
begin
  Result := ChildNodes['senderId'] as IXMLSenderIdType;
end;

function TXMLHeaderType.Get_Recipient: IXMLRecipientType;
begin
  Result := ChildNodes['recipient'] as IXMLRecipientType;
end;

function TXMLHeaderType.Get_RecipientId: IXMLRecipientIdType;
begin
  Result := ChildNodes['recipientId'] as IXMLRecipientIdType;
end;

function TXMLHeaderType.Get_MessageId: IXMLMessageIdType;
begin
  Result := ChildNodes['messageId'] as IXMLMessageIdType;
end;

function TXMLHeaderType.Get_MessageType: IXMLMessageType2;
begin
  Result := ChildNodes['messageType'] as IXMLMessageType2;
end;

function TXMLHeaderType.Get_CreatedOn: IXMLCreatedOnType;
begin
  Result := ChildNodes['createdOn'] as IXMLCreatedOnType;
end;

{ TXMLSenderType }

function TXMLSenderType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLSenderType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLSenderIdType }

function TXMLSenderIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSenderIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLRecipientType }

function TXMLRecipientType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRecipientType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLRecipientIdType }

function TXMLRecipientIdType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLRecipientIdType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLMessageIdType }

function TXMLMessageIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMessageIdType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLMessageType2 }

function TXMLMessageType2.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLMessageType2.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLCreatedOnType }

function TXMLCreatedOnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCreatedOnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLContentsType }

procedure TXMLContentsType.AfterConstruction;
begin
  RegisterChildNode('nrnExamination', TXMLNrnExaminationType);
  RegisterChildNode('status', TXMLStatusType);
  inherited;
end;

function TXMLContentsType.Get_NrnExamination: IXMLNrnExaminationType;
begin
  Result := ChildNodes['nrnExamination'] as IXMLNrnExaminationType;
end;

function TXMLContentsType.Get_Status: IXMLStatusType;
begin
  Result := ChildNodes['status'] as IXMLStatusType;
end;

{ TXMLNrnExaminationType }

function TXMLNrnExaminationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLNrnExaminationType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLStatusType }

function TXMLStatusType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLStatusType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLWarningsType }

procedure TXMLWarningsType.AfterConstruction;
begin
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('description', TXMLDescriptionType);
  RegisterChildNode('source', TXMLSourceType);
  RegisterChildNode('nrnTarget', TXMLNrnTargetType);
  inherited;
end;

function TXMLWarningsType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLWarningsType.Get_Description: IXMLDescriptionType;
begin
  Result := ChildNodes['description'] as IXMLDescriptionType;
end;

function TXMLWarningsType.Get_Source: IXMLSourceType;
begin
  Result := ChildNodes['source'] as IXMLSourceType;
end;

function TXMLWarningsType.Get_NrnTarget: IXMLNrnTargetType;
begin
  Result := ChildNodes['nrnTarget'] as IXMLNrnTargetType;
end;

{ TXMLWarningsTypeList }

function TXMLWarningsTypeList.Add: IXMLWarningsType;
begin
  Result := AddItem(-1) as IXMLWarningsType;
end;

function TXMLWarningsTypeList.Insert(const Index: Integer): IXMLWarningsType;
begin
  Result := AddItem(Index) as IXMLWarningsType;
end;

function TXMLWarningsTypeList.Get_Item(Index: Integer): IXMLWarningsType;
begin
  Result := List[Index] as IXMLWarningsType;
end;

{ TXMLCodeType }

function TXMLCodeType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCodeType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLDescriptionType }

function TXMLDescriptionType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLDescriptionType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLSourceType }

function TXMLSourceType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLSourceType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLNrnTargetType }

function TXMLNrnTargetType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLNrnTargetType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

end.