
{***********************************************}
{                                               }
{               XML Data Binding                }
{                                               }
{         Generated on: 15.2.2025 ã. 17:08:25   }
{       Generated from: D:\X014.xml             }
{   Settings stored in: D:\X014.xdb             }
{                                               }
{***********************************************}

unit X014;

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
  IXMLLrnType = interface;
  IXMLStatusType = interface;
  IXMLWarningsType = interface;
  IXMLWarningsTypeList = interface;
  IXMLCodeType = interface;
  IXMLDescriptionType = interface;
  IXMLSourceType = interface;
  IXMLNrnTargetType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{27B1870A-6E6F-43D3-8664-0F0EC6431CDE}']
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
    ['{3442490D-8D26-4B47-8E34-95EEAD6D8458}']
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
    ['{B21F9789-3E8C-43E0-84C4-3398BF08758B}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{99457AEC-A427-472F-A9BD-330B318E03AF}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{E7A2C70B-25FD-44D6-9F4A-BC17AE0506CE}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{19C2A64B-00CE-4C3E-9D5E-DDB942859A75}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{C20A305B-02D3-4F88-AC56-7E374B3B1B19}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{754C5187-F1D6-4803-80F9-AE335EB7D19F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{13E7E136-731C-43D3-8806-39B0FFFE959C}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNode)
    ['{05E3E090-8EB6-4F3C-B1D5-1A233527AA79}']
    { Property Accessors }
    function Get_NrnExamination: IXMLNrnExaminationType;
    function Get_Lrn: IXMLLrnType;
    function Get_Status: IXMLStatusType;
    { Methods & Properties }
    property NrnExamination: IXMLNrnExaminationType read Get_NrnExamination;
    property Lrn: IXMLLrnType read Get_Lrn;
    property Status: IXMLStatusType read Get_Status;
  end;

{ IXMLNrnExaminationType }

  IXMLNrnExaminationType = interface(IXMLNode)
    ['{BC4BCEDC-C232-4518-8689-8DA32BFD7D2F}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLLrnType }

  IXMLLrnType = interface(IXMLNode)
    ['{7FEFB3B5-5225-43AF-94B0-AAA36215C5E5}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLStatusType }

  IXMLStatusType = interface(IXMLNode)
    ['{A840862E-EF89-40D1-94B9-96FDBFDFCF25}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLWarningsType }

  IXMLWarningsType = interface(IXMLNode)
    ['{704C221C-AAC3-4F3B-9F20-7E2D2352253E}']
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
    ['{548BAED6-4650-4227-8F4B-10DDB0E18C46}']
    { Methods & Properties }
    function Add: IXMLWarningsType;
    function Insert(const Index: Integer): IXMLWarningsType;

    function Get_Item(Index: Integer): IXMLWarningsType;
    property Items[Index: Integer]: IXMLWarningsType read Get_Item; default;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{B3EC30A3-F204-4DBA-9FD8-14AD25EFADA9}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDescriptionType }

  IXMLDescriptionType = interface(IXMLNode)
    ['{20D551F7-CDAB-46AA-8686-EF3065878919}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSourceType }

  IXMLSourceType = interface(IXMLNode)
    ['{22F3CEC7-3D25-4701-9042-81F1D41BE6A0}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLNrnTargetType }

  IXMLNrnTargetType = interface(IXMLNode)
    ['{B9CC4FD8-DC7A-4381-9555-B47E47BB378E}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
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
  TXMLLrnType = class;
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
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
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
    function Get_Lrn: IXMLLrnType;
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

{ TXMLLrnType }

  TXMLLrnType = class(TXMLNode, IXMLLrnType)
  protected
    { IXMLLrnType }
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
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
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

function TXMLRecipientIdType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLRecipientIdType.Set_Value(Value: UnicodeString);
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
  RegisterChildNode('lrn', TXMLLrnType);
  RegisterChildNode('status', TXMLStatusType);
  inherited;
end;

function TXMLContentsType.Get_NrnExamination: IXMLNrnExaminationType;
begin
  Result := ChildNodes['nrnExamination'] as IXMLNrnExaminationType;
end;

function TXMLContentsType.Get_Lrn: IXMLLrnType;
begin
  Result := ChildNodes['lrn'] as IXMLLrnType;
end;

function TXMLContentsType.Get_Status: IXMLStatusType;
begin
  Result := ChildNodes['status'] as IXMLStatusType;
end;

{ TXMLNrnExaminationType }

function TXMLNrnExaminationType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnExaminationType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLLrnType }

function TXMLLrnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLLrnType.Set_Value(Value: UnicodeString);
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

function TXMLNrnTargetType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnTargetType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

end.