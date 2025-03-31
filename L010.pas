
{***********************************************}
{                                               }
{               XML Data Binding                }
{                                               }
{         Generated on: 31.1.2025 ã. 13:37:51   }
{       Generated from: D:\NzisSpec\L010.xml    }
{   Settings stored in: D:\NzisSpec\L010.xdb    }
{  test git                                             }
{***********************************************}

unit L010;

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
  IXMLPlannedExaminationType = interface;
  IXMLPlannedType = interface;
  IXMLPlannedCategoryType = interface;
  IXMLPlannedStatusType = interface;
  IXMLFromDateType = interface;
  IXMLToDateType = interface;
  IXMLActivitiesType = interface;
  IXMLActivitiesTypeList = interface;
  IXMLNomenclatureType = interface;
  IXMLCodeType = interface;
  IXMLDescriptionType = interface;
  IXMLSpecialtyType = interface;
  IXMLSpecialtyTypeList = interface;
  IXMLNrnType = interface;

{ IXMLMessageType }

  IXMLMessageType = interface(IXMLNode)
    ['{8A9773BA-6F32-4717-B33A-9E27EB961532}']
    { Property Accessors }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
    { Methods & Properties }
    property Header: IXMLHeaderType read Get_Header;
    property Contents: IXMLContentsType read Get_Contents;
  end;

{ IXMLHeaderType }

  IXMLHeaderType = interface(IXMLNode)
    ['{6FA5ACFB-5A97-41D3-A48F-44C19F5E27DA}']
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
    ['{28C1A773-DCF5-41D2-BFBB-3C98FD07BFAD}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSenderIdType }

  IXMLSenderIdType = interface(IXMLNode)
    ['{CE53E1C7-7682-4F3B-8EBC-397B531BDC11}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLRecipientType }

  IXMLRecipientType = interface(IXMLNode)
    ['{8CB0D48A-8B5A-49A0-BA45-283ED03B79E7}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLRecipientIdType }

  IXMLRecipientIdType = interface(IXMLNode)
    ['{98E2593E-73BA-4919-9B33-C1EEBCFDB09D}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLMessageIdType }

  IXMLMessageIdType = interface(IXMLNode)
    ['{4DE53BB0-E39F-475C-9EBC-956C8CF02F04}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLMessageType2 }

  IXMLMessageType2 = interface(IXMLNode)
    ['{64BE022E-7B8E-4FBA-BDD0-7C1413D97B68}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCreatedOnType }

  IXMLCreatedOnType = interface(IXMLNode)
    ['{84E7940C-31F3-4F4B-8319-3004F2F79BA3}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLContentsType }

  IXMLContentsType = interface(IXMLNodeCollection)
    ['{50CC1A65-21C2-4CBA-983C-F5C8F5EA6DD4}']
    { Property Accessors }
    function Get_PlannedExamination(Index: Integer): IXMLPlannedExaminationType;
    { Methods & Properties }
    function Add: IXMLPlannedExaminationType;
    function Insert(const Index: Integer): IXMLPlannedExaminationType;
    property PlannedExamination[Index: Integer]: IXMLPlannedExaminationType read Get_PlannedExamination; default;
  end;

{ IXMLPlannedExaminationType }

  IXMLPlannedExaminationType = interface(IXMLNode)
    ['{F86710B0-A2CD-4318-A334-446D86ED2177}']
    { Property Accessors }
    function Get_PlannedType: IXMLPlannedType;
    function Get_PlannedCategory: IXMLPlannedCategoryType;
    function Get_PlannedStatus: IXMLPlannedStatusType;
    function Get_FromDate: IXMLFromDateType;
    function Get_ToDate: IXMLToDateType;
    function Get_Activities: IXMLActivitiesTypeList;
    { Methods & Properties }
    property PlannedType: IXMLPlannedType read Get_PlannedType;
    property PlannedCategory: IXMLPlannedCategoryType read Get_PlannedCategory;
    property PlannedStatus: IXMLPlannedStatusType read Get_PlannedStatus;
    property FromDate: IXMLFromDateType read Get_FromDate;
    property ToDate: IXMLToDateType read Get_ToDate;
    property Activities: IXMLActivitiesTypeList read Get_Activities;
  end;

{ IXMLPlannedType }

  IXMLPlannedType = interface(IXMLNode)
    ['{AE137A51-CF01-4FF7-BD52-2ECE1F1838BC}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLPlannedCategoryType }

  IXMLPlannedCategoryType = interface(IXMLNode)
    ['{AEC2A8EF-965D-408C-B61D-189145B7E5DD}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLPlannedStatusType }

  IXMLPlannedStatusType = interface(IXMLNode)
    ['{53F5ECD4-E272-4F1E-B4BE-3AF789FA38D9}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLFromDateType }

  IXMLFromDateType = interface(IXMLNode)
    ['{1D53053D-F55F-4DA1-81EC-DA5D350A9E79}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLToDateType }

  IXMLToDateType = interface(IXMLNode)
    ['{B716CCF6-8840-4E64-BA2D-1D44A30D0A2A}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLActivitiesType }

  IXMLActivitiesType = interface(IXMLNode)
    ['{33446D3F-ED50-45A1-AD91-A2FE14F928C6}']
    { Property Accessors }
    function Get_Nomenclature: IXMLNomenclatureType;
    function Get_Code: IXMLCodeType;
    function Get_Description: IXMLDescriptionType;
    function Get_Note: UnicodeString;
    function Get_Specialty: IXMLSpecialtyTypeList;
    function Get_Nrn: IXMLNrnType;
    procedure Set_Note(Value: UnicodeString);
    { Methods & Properties }
    property Nomenclature: IXMLNomenclatureType read Get_Nomenclature;
    property Code: IXMLCodeType read Get_Code;
    property Description: IXMLDescriptionType read Get_Description;
    property Note: UnicodeString read Get_Note write Set_Note;
    property Specialty: IXMLSpecialtyTypeList read Get_Specialty;
    property Nrn: IXMLNrnType read Get_Nrn;
  end;

{ IXMLActivitiesTypeList }

  IXMLActivitiesTypeList = interface(IXMLNodeCollection)
    ['{FCDC99F5-58B8-4E96-860A-FF954627F4CD}']
    { Methods & Properties }
    function Add: IXMLActivitiesType;
    function Insert(const Index: Integer): IXMLActivitiesType;

    function Get_Item(Index: Integer): IXMLActivitiesType;
    property Items[Index: Integer]: IXMLActivitiesType read Get_Item; default;
  end;

{ IXMLNomenclatureType }

  IXMLNomenclatureType = interface(IXMLNode)
    ['{15D0912E-DC3E-4AED-B429-4F1A0B1A3ADD}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLCodeType }

  IXMLCodeType = interface(IXMLNode)
    ['{CD09EDF1-7917-4967-8707-2960B6A54CF4}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLDescriptionType }

  IXMLDescriptionType = interface(IXMLNode)
    ['{082AB751-5741-4A08-8BE0-901022E85E13}']
    { Property Accessors }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
    { Methods & Properties }
    property Value: UnicodeString read Get_Value write Set_Value;
  end;

{ IXMLSpecialtyType }

  IXMLSpecialtyType = interface(IXMLNode)
    ['{AB4C3492-7A61-40E7-8805-AFA070703B73}']
    { Property Accessors }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
    { Methods & Properties }
    property Value: Integer read Get_Value write Set_Value;
  end;

{ IXMLSpecialtyTypeList }

  IXMLSpecialtyTypeList = interface(IXMLNodeCollection)
    ['{E35BD7AE-8B7A-45F3-8650-379420EFE5CA}']
    { Methods & Properties }
    function Add: IXMLSpecialtyType;
    function Insert(const Index: Integer): IXMLSpecialtyType;

    function Get_Item(Index: Integer): IXMLSpecialtyType;
    property Items[Index: Integer]: IXMLSpecialtyType read Get_Item; default;
  end;

{ IXMLNrnType }

  IXMLNrnType = interface(IXMLNode)
    ['{FDDE55F6-9F6C-4FD0-916F-77FFB3AFDD8F}']
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
  TXMLPlannedExaminationType = class;
  TXMLPlannedType = class;
  TXMLPlannedCategoryType = class;
  TXMLPlannedStatusType = class;
  TXMLFromDateType = class;
  TXMLToDateType = class;
  TXMLActivitiesType = class;
  TXMLActivitiesTypeList = class;
  TXMLNomenclatureType = class;
  TXMLCodeType = class;
  TXMLDescriptionType = class;
  TXMLSpecialtyType = class;
  TXMLSpecialtyTypeList = class;
  TXMLNrnType = class;

{ TXMLMessageType }

  TXMLMessageType = class(TXMLNode, IXMLMessageType)
  protected
    { IXMLMessageType }
    function Get_Header: IXMLHeaderType;
    function Get_Contents: IXMLContentsType;
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

  TXMLContentsType = class(TXMLNodeCollection, IXMLContentsType)
  protected
    { IXMLContentsType }
    function Get_PlannedExamination(Index: Integer): IXMLPlannedExaminationType;
    function Add: IXMLPlannedExaminationType;
    function Insert(const Index: Integer): IXMLPlannedExaminationType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPlannedExaminationType }

  TXMLPlannedExaminationType = class(TXMLNode, IXMLPlannedExaminationType)
  private
    FActivities: IXMLActivitiesTypeList;
  protected
    { IXMLPlannedExaminationType }
    function Get_PlannedType: IXMLPlannedType;
    function Get_PlannedCategory: IXMLPlannedCategoryType;
    function Get_PlannedStatus: IXMLPlannedStatusType;
    function Get_FromDate: IXMLFromDateType;
    function Get_ToDate: IXMLToDateType;
    function Get_Activities: IXMLActivitiesTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPlannedType }

  TXMLPlannedType = class(TXMLNode, IXMLPlannedType)
  protected
    { IXMLPlannedType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLPlannedCategoryType }

  TXMLPlannedCategoryType = class(TXMLNode, IXMLPlannedCategoryType)
  protected
    { IXMLPlannedCategoryType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLPlannedStatusType }

  TXMLPlannedStatusType = class(TXMLNode, IXMLPlannedStatusType)
  protected
    { IXMLPlannedStatusType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLFromDateType }

  TXMLFromDateType = class(TXMLNode, IXMLFromDateType)
  protected
    { IXMLFromDateType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLToDateType }

  TXMLToDateType = class(TXMLNode, IXMLToDateType)
  protected
    { IXMLToDateType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
  end;

{ TXMLActivitiesType }

  TXMLActivitiesType = class(TXMLNode, IXMLActivitiesType)
  private
    FSpecialty: IXMLSpecialtyTypeList;
  protected
    { IXMLActivitiesType }
    function Get_Nomenclature: IXMLNomenclatureType;
    function Get_Code: IXMLCodeType;
    function Get_Description: IXMLDescriptionType;
    function Get_Note: UnicodeString;
    function Get_Specialty: IXMLSpecialtyTypeList;
    function Get_Nrn: IXMLNrnType;
    procedure Set_Note(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLActivitiesTypeList }

  TXMLActivitiesTypeList = class(TXMLNodeCollection, IXMLActivitiesTypeList)
  protected
    { IXMLActivitiesTypeList }
    function Add: IXMLActivitiesType;
    function Insert(const Index: Integer): IXMLActivitiesType;

    function Get_Item(Index: Integer): IXMLActivitiesType;
  end;

{ TXMLNomenclatureType }

  TXMLNomenclatureType = class(TXMLNode, IXMLNomenclatureType)
  protected
    { IXMLNomenclatureType }
    function Get_Value: UnicodeString;
    procedure Set_Value(Value: UnicodeString);
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

{ TXMLSpecialtyType }

  TXMLSpecialtyType = class(TXMLNode, IXMLSpecialtyType)
  protected
    { IXMLSpecialtyType }
    function Get_Value: Integer;
    procedure Set_Value(Value: Integer);
  end;

{ TXMLSpecialtyTypeList }

  TXMLSpecialtyTypeList = class(TXMLNodeCollection, IXMLSpecialtyTypeList)
  protected
    { IXMLSpecialtyTypeList }
    function Add: IXMLSpecialtyType;
    function Insert(const Index: Integer): IXMLSpecialtyType;

    function Get_Item(Index: Integer): IXMLSpecialtyType;
  end;

{ TXMLNrnType }

  TXMLNrnType = class(TXMLNode, IXMLNrnType)
  protected
    { IXMLNrnType }
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
  RegisterChildNode('plannedExamination', TXMLPlannedExaminationType);
  ItemTag := 'plannedExamination';
  ItemInterface := IXMLPlannedExaminationType;
  inherited;
end;

function TXMLContentsType.Get_PlannedExamination(Index: Integer): IXMLPlannedExaminationType;
begin
  Result := List[Index] as IXMLPlannedExaminationType;
end;

function TXMLContentsType.Add: IXMLPlannedExaminationType;
begin
  Result := AddItem(-1) as IXMLPlannedExaminationType;
end;

function TXMLContentsType.Insert(const Index: Integer): IXMLPlannedExaminationType;
begin
  Result := AddItem(Index) as IXMLPlannedExaminationType;
end;

{ TXMLPlannedExaminationType }

procedure TXMLPlannedExaminationType.AfterConstruction;
begin
  RegisterChildNode('plannedType', TXMLPlannedType);
  RegisterChildNode('plannedCategory', TXMLPlannedCategoryType);
  RegisterChildNode('plannedStatus', TXMLPlannedStatusType);
  RegisterChildNode('fromDate', TXMLFromDateType);
  RegisterChildNode('toDate', TXMLToDateType);
  RegisterChildNode('activities', TXMLActivitiesType);
  FActivities := CreateCollection(TXMLActivitiesTypeList, IXMLActivitiesType, 'activities') as IXMLActivitiesTypeList;
  inherited;
end;

function TXMLPlannedExaminationType.Get_PlannedType: IXMLPlannedType;
begin
  Result := ChildNodes['plannedType'] as IXMLPlannedType;
end;

function TXMLPlannedExaminationType.Get_PlannedCategory: IXMLPlannedCategoryType;
begin
  Result := ChildNodes['plannedCategory'] as IXMLPlannedCategoryType;
end;

function TXMLPlannedExaminationType.Get_PlannedStatus: IXMLPlannedStatusType;
begin
  Result := ChildNodes['plannedStatus'] as IXMLPlannedStatusType;
end;

function TXMLPlannedExaminationType.Get_FromDate: IXMLFromDateType;
begin
  Result := ChildNodes['fromDate'] as IXMLFromDateType;
end;

function TXMLPlannedExaminationType.Get_ToDate: IXMLToDateType;
begin
  Result := ChildNodes['toDate'] as IXMLToDateType;
end;

function TXMLPlannedExaminationType.Get_Activities: IXMLActivitiesTypeList;
begin
  Result := FActivities;
end;

{ TXMLPlannedType }

function TXMLPlannedType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLPlannedType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLPlannedCategoryType }

function TXMLPlannedCategoryType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPlannedCategoryType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLPlannedStatusType }

function TXMLPlannedStatusType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLPlannedStatusType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLFromDateType }

function TXMLFromDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLFromDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLToDateType }

function TXMLToDateType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLToDateType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

{ TXMLActivitiesType }

procedure TXMLActivitiesType.AfterConstruction;
begin
  RegisterChildNode('nomenclature', TXMLNomenclatureType);
  RegisterChildNode('code', TXMLCodeType);
  RegisterChildNode('description', TXMLDescriptionType);
  RegisterChildNode('specialty', TXMLSpecialtyType);
  RegisterChildNode('nrn', TXMLNrnType);
  FSpecialty := CreateCollection(TXMLSpecialtyTypeList, IXMLSpecialtyType, 'specialty') as IXMLSpecialtyTypeList;
  inherited;
end;

function TXMLActivitiesType.Get_Nomenclature: IXMLNomenclatureType;
begin
  Result := ChildNodes['nomenclature'] as IXMLNomenclatureType;
end;

function TXMLActivitiesType.Get_Code: IXMLCodeType;
begin
  Result := ChildNodes['code'] as IXMLCodeType;
end;

function TXMLActivitiesType.Get_Description: IXMLDescriptionType;
begin
  Result := ChildNodes['description'] as IXMLDescriptionType;
end;

function TXMLActivitiesType.Get_Note: UnicodeString;
begin
  Result := ChildNodes['note'].Text;
end;

procedure TXMLActivitiesType.Set_Note(Value: UnicodeString);
begin
  ChildNodes['note'].NodeValue := Value;
end;

function TXMLActivitiesType.Get_Specialty: IXMLSpecialtyTypeList;
begin
  Result := FSpecialty;
end;

function TXMLActivitiesType.Get_Nrn: IXMLNrnType;
begin
  Result := ChildNodes['nrn'] as IXMLNrnType;
end;

{ TXMLActivitiesTypeList }

function TXMLActivitiesTypeList.Add: IXMLActivitiesType;
begin
  Result := AddItem(-1) as IXMLActivitiesType;
end;

function TXMLActivitiesTypeList.Insert(const Index: Integer): IXMLActivitiesType;
begin
  Result := AddItem(Index) as IXMLActivitiesType;
end;

function TXMLActivitiesTypeList.Get_Item(Index: Integer): IXMLActivitiesType;
begin
  Result := List[Index] as IXMLActivitiesType;
end;

{ TXMLNomenclatureType }

function TXMLNomenclatureType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNomenclatureType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
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

{ TXMLSpecialtyType }

function TXMLSpecialtyType.Get_Value: Integer;
begin
  Result := AttributeNodes['value'].NodeValue;
end;

procedure TXMLSpecialtyType.Set_Value(Value: Integer);
begin
  SetAttribute('value', Value);
end;

{ TXMLSpecialtyTypeList }

function TXMLSpecialtyTypeList.Add: IXMLSpecialtyType;
begin
  Result := AddItem(-1) as IXMLSpecialtyType;
end;

function TXMLSpecialtyTypeList.Insert(const Index: Integer): IXMLSpecialtyType;
begin
  Result := AddItem(Index) as IXMLSpecialtyType;
end;

function TXMLSpecialtyTypeList.Get_Item(Index: Integer): IXMLSpecialtyType;
begin
  Result := List[Index] as IXMLSpecialtyType;
end;

{ TXMLNrnType }

function TXMLNrnType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLNrnType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

end.