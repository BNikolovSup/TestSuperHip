
{******************************************************************************************}
{                                                                                          }
{                                     XML Data Binding                                     }
{                                                                                          }
{         Generated on: 14/10/2024 11:30:31                                                }
{       Generated from: D:\down3108\Downloads\PL_Todorka\FILE_SUBM_PL_20240831104652.xml   }
{   Settings stored in: D:\down3108\Downloads\PL_Todorka\FILE_SUBM_PL_20240831104652.xdb   }
{                                                                                          }
{******************************************************************************************}

unit FILE_SUBM_PL;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLPracticeType = interface;
  IXMLDoctorType = interface;
  IXMLIDENTITYType = interface;
  IXMLDoctorsPatientType = interface;
  IXMLDoctorsPatientTypeList = interface;
  IXMLPatientType = interface;
  IXMLADDRESSType = interface;
  IXMLRepresentativeType = interface;

{ IXMLPracticeType }

  IXMLPracticeType = interface(IXMLNode)
    ['{3DF34FEA-448D-45EC-A270-A9FCF0344DFF}']
    { Property Accessors }
    function Get_PracticeCode: Integer;
    function Get_PracticeName: UnicodeString;
    function Get_ContractNO: Integer;
    function Get_ContractDate: UnicodeString;
    function Get_ReportingDate: UnicodeString;
    function Get_RegCode: Integer;
    function Get_DateFrom: UnicodeString;
    function Get_DateTo: UnicodeString;
    function Get_Doctor: IXMLDoctorType;
    procedure Set_PracticeCode(Value: Integer);
    procedure Set_PracticeName(Value: UnicodeString);
    procedure Set_ContractNO(Value: Integer);
    procedure Set_ContractDate(Value: UnicodeString);
    procedure Set_ReportingDate(Value: UnicodeString);
    procedure Set_RegCode(Value: Integer);
    procedure Set_DateFrom(Value: UnicodeString);
    procedure Set_DateTo(Value: UnicodeString);
    { Methods & Properties }
    property PracticeCode: Integer read Get_PracticeCode write Set_PracticeCode;
    property PracticeName: UnicodeString read Get_PracticeName write Set_PracticeName;
    property ContractNO: Integer read Get_ContractNO write Set_ContractNO;
    property ContractDate: UnicodeString read Get_ContractDate write Set_ContractDate;
    property ReportingDate: UnicodeString read Get_ReportingDate write Set_ReportingDate;
    property RegCode: Integer read Get_RegCode write Set_RegCode;
    property DateFrom: UnicodeString read Get_DateFrom write Set_DateFrom;
    property DateTo: UnicodeString read Get_DateTo write Set_DateTo;
    property Doctor: IXMLDoctorType read Get_Doctor;
  end;

{ IXMLDoctorType }

  IXMLDoctorType = interface(IXMLNode)
    ['{D9D23462-54AE-4CA2-998C-1CCF9D22991B}']
    { Property Accessors }
    function Get_UIN: Integer;
    function Get_IDENTITY: IXMLIDENTITYType;
    function Get_FullName: UnicodeString;
    function Get_SIMPCode: Integer;
    function Get_DoctorsPatient: IXMLDoctorsPatientTypeList;
    procedure Set_UIN(Value: Integer);
    procedure Set_FullName(Value: UnicodeString);
    procedure Set_SIMPCode(Value: Integer);
    { Methods & Properties }
    property UIN: Integer read Get_UIN write Set_UIN;
    property IDENTITY: IXMLIDENTITYType read Get_IDENTITY;
    property FullName: UnicodeString read Get_FullName write Set_FullName;
    property SIMPCode: Integer read Get_SIMPCode write Set_SIMPCode;
    property DoctorsPatient: IXMLDoctorsPatientTypeList read Get_DoctorsPatient;
  end;

{ IXMLIDENTITYType }

  IXMLIDENTITYType = interface(IXMLNode)
    ['{B632F083-418F-4AD3-8AD7-B51E8105464A}']
    { Property Accessors }
    function Get_IDTYPE: Integer;
    function Get_PID: UnicodeString;
    procedure Set_IDTYPE(Value: Integer);
    procedure Set_PID(Value: UnicodeString);
    { Methods & Properties }
    property IDTYPE: Integer read Get_IDTYPE write Set_IDTYPE;
    property PID: UnicodeString read Get_PID write Set_PID;
  end;

{ IXMLDoctorsPatientType }

  IXMLDoctorsPatientType = interface(IXMLNode)
    ['{04F3084A-D542-4AD5-A3DF-0DCDB6A7ED36}']
    { Property Accessors }
    function Get_Patient: IXMLPatientType;
    function Get_REGISTRATION: UnicodeString;
    function Get_RegDate: UnicodeString;
    function Get_TypeOfChoice: Integer;
    function Get_Representative: IXMLRepresentativeType;
    function Get_NoOfHealthBookBG: Integer;
    procedure Set_REGISTRATION(Value: UnicodeString);
    procedure Set_RegDate(Value: UnicodeString);
    procedure Set_TypeOfChoice(Value: Integer);
    procedure Set_NoOfHealthBookBG(Value: Integer);
    { Methods & Properties }
    property Patient: IXMLPatientType read Get_Patient;
    property REGISTRATION: UnicodeString read Get_REGISTRATION write Set_REGISTRATION;
    property RegDate: UnicodeString read Get_RegDate write Set_RegDate;
    property TypeOfChoice: Integer read Get_TypeOfChoice write Set_TypeOfChoice;
    property Representative: IXMLRepresentativeType read Get_Representative;
    property NoOfHealthBookBG: Integer read Get_NoOfHealthBookBG write Set_NoOfHealthBookBG;
  end;

{ IXMLDoctorsPatientTypeList }

  IXMLDoctorsPatientTypeList = interface(IXMLNodeCollection)
    ['{AE126BA8-F56D-42AB-AA6E-5D227F24B9AD}']
    { Methods & Properties }
    function Add: IXMLDoctorsPatientType;
    function Insert(const Index: Integer): IXMLDoctorsPatientType;

    function Get_Item(Index: Integer): IXMLDoctorsPatientType;
    property Items[Index: Integer]: IXMLDoctorsPatientType read Get_Item; default;
  end;

{ IXMLPatientType }

  IXMLPatientType = interface(IXMLNode)
    ['{9CFF398B-CE1C-4010-AB8A-3AA43A1B949F}']
    { Property Accessors }
    function Get_IDENTITY: IXMLIDENTITYType;
    function Get_FIRSTNAME: UnicodeString;
    function Get_FAMILYNAME: UnicodeString;
    function Get_SEX: UnicodeString;
    function Get_BIRTH_DATE: UnicodeString;
    function Get_CITIZENSHIP: UnicodeString;
    function Get_ADDRESS: IXMLADDRESSType;
    function Get_SECONDNAME: UnicodeString;
    procedure Set_FIRSTNAME(Value: UnicodeString);
    procedure Set_FAMILYNAME(Value: UnicodeString);
    procedure Set_SEX(Value: UnicodeString);
    procedure Set_BIRTH_DATE(Value: UnicodeString);
    procedure Set_CITIZENSHIP(Value: UnicodeString);
    procedure Set_SECONDNAME(Value: UnicodeString);
    { Methods & Properties }
    property IDENTITY: IXMLIDENTITYType read Get_IDENTITY;
    property FIRSTNAME: UnicodeString read Get_FIRSTNAME write Set_FIRSTNAME;
    property FAMILYNAME: UnicodeString read Get_FAMILYNAME write Set_FAMILYNAME;
    property SEX: UnicodeString read Get_SEX write Set_SEX;
    property BIRTH_DATE: UnicodeString read Get_BIRTH_DATE write Set_BIRTH_DATE;
    property CITIZENSHIP: UnicodeString read Get_CITIZENSHIP write Set_CITIZENSHIP;
    property ADDRESS: IXMLADDRESSType read Get_ADDRESS;
    property SECONDNAME: UnicodeString read Get_SECONDNAME write Set_SECONDNAME;
  end;

{ IXMLADDRESSType }

  IXMLADDRESSType = interface(IXMLNode)
    ['{7F22247E-143C-4A6E-8079-6F6DEB81B50B}']
    { Property Accessors }
    function Get_ZIPCode: Integer;
    function Get_EKATTECode: Integer;
    function Get_No: Integer;
    function Get_Street: Integer;
    function Get_City: UnicodeString;
    procedure Set_ZIPCode(Value: Integer);
    procedure Set_EKATTECode(Value: Integer);
    procedure Set_No(Value: Integer);
    procedure Set_Street(Value: Integer);
    procedure Set_City(Value: UnicodeString);
    { Methods & Properties }
    property ZIPCode: Integer read Get_ZIPCode write Set_ZIPCode;
    property EKATTECode: Integer read Get_EKATTECode write Set_EKATTECode;
    property No: Integer read Get_No write Set_No;
    property Street: Integer read Get_Street write Set_Street;
    property City: UnicodeString read Get_City write Set_City;
  end;

{ IXMLRepresentativeType }

  IXMLRepresentativeType = interface(IXMLNode)
    ['{D467C0F7-D5B3-4AD8-AA0E-1F977B89294C}']
    { Property Accessors }
    function Get_IDENTITY: IXMLIDENTITYType;
    function Get_FIRSTNAME: UnicodeString;
    function Get_SECONDNAME: UnicodeString;
    function Get_FAMILYNAME: UnicodeString;
    function Get_SEX: UnicodeString;
    function Get_BIRTH_DATE: UnicodeString;
    function Get_CITIZENSHIP: UnicodeString;
    function Get_ADDRESS: IXMLADDRESSType;
    procedure Set_FIRSTNAME(Value: UnicodeString);
    procedure Set_SECONDNAME(Value: UnicodeString);
    procedure Set_FAMILYNAME(Value: UnicodeString);
    procedure Set_SEX(Value: UnicodeString);
    procedure Set_BIRTH_DATE(Value: UnicodeString);
    procedure Set_CITIZENSHIP(Value: UnicodeString);
    { Methods & Properties }
    property IDENTITY: IXMLIDENTITYType read Get_IDENTITY;
    property FIRSTNAME: UnicodeString read Get_FIRSTNAME write Set_FIRSTNAME;
    property SECONDNAME: UnicodeString read Get_SECONDNAME write Set_SECONDNAME;
    property FAMILYNAME: UnicodeString read Get_FAMILYNAME write Set_FAMILYNAME;
    property SEX: UnicodeString read Get_SEX write Set_SEX;
    property BIRTH_DATE: UnicodeString read Get_BIRTH_DATE write Set_BIRTH_DATE;
    property CITIZENSHIP: UnicodeString read Get_CITIZENSHIP write Set_CITIZENSHIP;
    property ADDRESS: IXMLADDRESSType read Get_ADDRESS;
  end;

{ Forward Decls }

  TXMLPracticeType = class;
  TXMLDoctorType = class;
  TXMLIDENTITYType = class;
  TXMLDoctorsPatientType = class;
  TXMLDoctorsPatientTypeList = class;
  TXMLPatientType = class;
  TXMLADDRESSType = class;
  TXMLRepresentativeType = class;

{ TXMLPracticeType }

  TXMLPracticeType = class(TXMLNode, IXMLPracticeType)
  protected
    { IXMLPracticeType }
    function Get_PracticeCode: Integer;
    function Get_PracticeName: UnicodeString;
    function Get_ContractNO: Integer;
    function Get_ContractDate: UnicodeString;
    function Get_ReportingDate: UnicodeString;
    function Get_RegCode: Integer;
    function Get_DateFrom: UnicodeString;
    function Get_DateTo: UnicodeString;
    function Get_Doctor: IXMLDoctorType;
    procedure Set_PracticeCode(Value: Integer);
    procedure Set_PracticeName(Value: UnicodeString);
    procedure Set_ContractNO(Value: Integer);
    procedure Set_ContractDate(Value: UnicodeString);
    procedure Set_ReportingDate(Value: UnicodeString);
    procedure Set_RegCode(Value: Integer);
    procedure Set_DateFrom(Value: UnicodeString);
    procedure Set_DateTo(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDoctorType }

  TXMLDoctorType = class(TXMLNode, IXMLDoctorType)
  private
    FDoctorsPatient: IXMLDoctorsPatientTypeList;
  protected
    { IXMLDoctorType }
    function Get_UIN: Integer;
    function Get_IDENTITY: IXMLIDENTITYType;
    function Get_FullName: UnicodeString;
    function Get_SIMPCode: Integer;
    function Get_DoctorsPatient: IXMLDoctorsPatientTypeList;
    procedure Set_UIN(Value: Integer);
    procedure Set_FullName(Value: UnicodeString);
    procedure Set_SIMPCode(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIDENTITYType }

  TXMLIDENTITYType = class(TXMLNode, IXMLIDENTITYType)
  protected
    { IXMLIDENTITYType }
    function Get_IDTYPE: Integer;
    function Get_PID: UnicodeString;
    procedure Set_IDTYPE(Value: Integer);
    procedure Set_PID(Value: UnicodeString);
  end;

{ TXMLDoctorsPatientType }

  TXMLDoctorsPatientType = class(TXMLNode, IXMLDoctorsPatientType)
  protected
    { IXMLDoctorsPatientType }
    function Get_Patient: IXMLPatientType;
    function Get_REGISTRATION: UnicodeString;
    function Get_RegDate: UnicodeString;
    function Get_TypeOfChoice: Integer;
    function Get_Representative: IXMLRepresentativeType;
    function Get_NoOfHealthBookBG: Integer;
    procedure Set_REGISTRATION(Value: UnicodeString);
    procedure Set_RegDate(Value: UnicodeString);
    procedure Set_TypeOfChoice(Value: Integer);
    procedure Set_NoOfHealthBookBG(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDoctorsPatientTypeList }

  TXMLDoctorsPatientTypeList = class(TXMLNodeCollection, IXMLDoctorsPatientTypeList)
  protected
    { IXMLDoctorsPatientTypeList }
    function Add: IXMLDoctorsPatientType;
    function Insert(const Index: Integer): IXMLDoctorsPatientType;

    function Get_Item(Index: Integer): IXMLDoctorsPatientType;
  end;

{ TXMLPatientType }

  TXMLPatientType = class(TXMLNode, IXMLPatientType)
  protected
    { IXMLPatientType }
    function Get_IDENTITY: IXMLIDENTITYType;
    function Get_FIRSTNAME: UnicodeString;
    function Get_FAMILYNAME: UnicodeString;
    function Get_SEX: UnicodeString;
    function Get_BIRTH_DATE: UnicodeString;
    function Get_CITIZENSHIP: UnicodeString;
    function Get_ADDRESS: IXMLADDRESSType;
    function Get_SECONDNAME: UnicodeString;
    procedure Set_FIRSTNAME(Value: UnicodeString);
    procedure Set_FAMILYNAME(Value: UnicodeString);
    procedure Set_SEX(Value: UnicodeString);
    procedure Set_BIRTH_DATE(Value: UnicodeString);
    procedure Set_CITIZENSHIP(Value: UnicodeString);
    procedure Set_SECONDNAME(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLADDRESSType }

  TXMLADDRESSType = class(TXMLNode, IXMLADDRESSType)
  protected
    { IXMLADDRESSType }
    function Get_ZIPCode: Integer;
    function Get_EKATTECode: Integer;
    function Get_No: Integer;
    function Get_Street: Integer;
    function Get_City: UnicodeString;
    procedure Set_ZIPCode(Value: Integer);
    procedure Set_EKATTECode(Value: Integer);
    procedure Set_No(Value: Integer);
    procedure Set_Street(Value: Integer);
    procedure Set_City(Value: UnicodeString);
  end;

{ TXMLRepresentativeType }

  TXMLRepresentativeType = class(TXMLNode, IXMLRepresentativeType)
  protected
    { IXMLRepresentativeType }
    function Get_IDENTITY: IXMLIDENTITYType;
    function Get_FIRSTNAME: UnicodeString;
    function Get_SECONDNAME: UnicodeString;
    function Get_FAMILYNAME: UnicodeString;
    function Get_SEX: UnicodeString;
    function Get_BIRTH_DATE: UnicodeString;
    function Get_CITIZENSHIP: UnicodeString;
    function Get_ADDRESS: IXMLADDRESSType;
    procedure Set_FIRSTNAME(Value: UnicodeString);
    procedure Set_SECONDNAME(Value: UnicodeString);
    procedure Set_FAMILYNAME(Value: UnicodeString);
    procedure Set_SEX(Value: UnicodeString);
    procedure Set_BIRTH_DATE(Value: UnicodeString);
    procedure Set_CITIZENSHIP(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function GetPractice(Doc: IXMLDocument): IXMLPracticeType;
function LoadPractice(const FileName: string): IXMLPracticeType;
function NewPractice: IXMLPracticeType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetPractice(Doc: IXMLDocument): IXMLPracticeType;
begin
  Result := Doc.GetDocBinding('Practice', TXMLPracticeType, TargetNamespace) as IXMLPracticeType;
end;

function LoadPractice(const FileName: string): IXMLPracticeType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Practice', TXMLPracticeType, TargetNamespace) as IXMLPracticeType;
end;

function NewPractice: IXMLPracticeType;
begin
  Result := NewXMLDocument.GetDocBinding('Practice', TXMLPracticeType, TargetNamespace) as IXMLPracticeType;
end;

{ TXMLPracticeType }

procedure TXMLPracticeType.AfterConstruction;
begin
  RegisterChildNode('Doctor', TXMLDoctorType);
  inherited;
end;

function TXMLPracticeType.Get_PracticeCode: Integer;
begin
  Result := ChildNodes['PracticeCode'].NodeValue;
end;

procedure TXMLPracticeType.Set_PracticeCode(Value: Integer);
begin
  ChildNodes['PracticeCode'].NodeValue := Value;
end;

function TXMLPracticeType.Get_PracticeName: UnicodeString;
begin
  Result := ChildNodes['PracticeName'].Text;
end;

procedure TXMLPracticeType.Set_PracticeName(Value: UnicodeString);
begin
  ChildNodes['PracticeName'].NodeValue := Value;
end;

function TXMLPracticeType.Get_ContractNO: Integer;
begin
  Result := ChildNodes['ContractNO'].NodeValue;
end;

procedure TXMLPracticeType.Set_ContractNO(Value: Integer);
begin
  ChildNodes['ContractNO'].NodeValue := Value;
end;

function TXMLPracticeType.Get_ContractDate: UnicodeString;
begin
  Result := ChildNodes['ContractDate'].Text;
end;

procedure TXMLPracticeType.Set_ContractDate(Value: UnicodeString);
begin
  ChildNodes['ContractDate'].NodeValue := Value;
end;

function TXMLPracticeType.Get_ReportingDate: UnicodeString;
begin
  Result := ChildNodes['ReportingDate'].Text;
end;

procedure TXMLPracticeType.Set_ReportingDate(Value: UnicodeString);
begin
  ChildNodes['ReportingDate'].NodeValue := Value;
end;

function TXMLPracticeType.Get_RegCode: Integer;
begin
  Result := ChildNodes['RegCode'].NodeValue;
end;

procedure TXMLPracticeType.Set_RegCode(Value: Integer);
begin
  ChildNodes['RegCode'].NodeValue := Value;
end;

function TXMLPracticeType.Get_DateFrom: UnicodeString;
begin
  Result := ChildNodes['DateFrom'].Text;
end;

procedure TXMLPracticeType.Set_DateFrom(Value: UnicodeString);
begin
  ChildNodes['DateFrom'].NodeValue := Value;
end;

function TXMLPracticeType.Get_DateTo: UnicodeString;
begin
  Result := ChildNodes['DateTo'].Text;
end;

procedure TXMLPracticeType.Set_DateTo(Value: UnicodeString);
begin
  ChildNodes['DateTo'].NodeValue := Value;
end;

function TXMLPracticeType.Get_Doctor: IXMLDoctorType;
begin
  Result := ChildNodes['Doctor'] as IXMLDoctorType;
end;

{ TXMLDoctorType }

procedure TXMLDoctorType.AfterConstruction;
begin
  RegisterChildNode('IDENTITY', TXMLIDENTITYType);
  RegisterChildNode('DoctorsPatient', TXMLDoctorsPatientType);
  FDoctorsPatient := CreateCollection(TXMLDoctorsPatientTypeList, IXMLDoctorsPatientType, 'DoctorsPatient') as IXMLDoctorsPatientTypeList;
  inherited;
end;

function TXMLDoctorType.Get_UIN: Integer;
begin
  Result := ChildNodes['UIN'].NodeValue;
end;

procedure TXMLDoctorType.Set_UIN(Value: Integer);
begin
  ChildNodes['UIN'].NodeValue := Value;
end;

function TXMLDoctorType.Get_IDENTITY: IXMLIDENTITYType;
begin
  Result := ChildNodes['IDENTITY'] as IXMLIDENTITYType;
end;

function TXMLDoctorType.Get_FullName: UnicodeString;
begin
  Result := ChildNodes['FullName'].Text;
end;

procedure TXMLDoctorType.Set_FullName(Value: UnicodeString);
begin
  ChildNodes['FullName'].NodeValue := Value;
end;

function TXMLDoctorType.Get_SIMPCode: Integer;
begin
  Result := ChildNodes['SIMPCode'].NodeValue;
end;

procedure TXMLDoctorType.Set_SIMPCode(Value: Integer);
begin
  ChildNodes['SIMPCode'].NodeValue := Value;
end;

function TXMLDoctorType.Get_DoctorsPatient: IXMLDoctorsPatientTypeList;
begin
  Result := FDoctorsPatient;
end;

{ TXMLIDENTITYType }

function TXMLIDENTITYType.Get_IDTYPE: Integer;
begin
  Result := ChildNodes['IDTYPE'].NodeValue;
end;

procedure TXMLIDENTITYType.Set_IDTYPE(Value: Integer);
begin
  ChildNodes['IDTYPE'].NodeValue := Value;
end;

function TXMLIDENTITYType.Get_PID: UnicodeString;
begin
  Result := ChildNodes['PID'].NodeValue;
end;

procedure TXMLIDENTITYType.Set_PID(Value: UnicodeString);
begin
  ChildNodes['PID'].NodeValue := Value;
end;

{ TXMLDoctorsPatientType }

procedure TXMLDoctorsPatientType.AfterConstruction;
begin
  RegisterChildNode('Patient', TXMLPatientType);
  RegisterChildNode('Representative', TXMLRepresentativeType);
  inherited;
end;

function TXMLDoctorsPatientType.Get_Patient: IXMLPatientType;
begin
  Result := ChildNodes['Patient'] as IXMLPatientType;
end;

function TXMLDoctorsPatientType.Get_REGISTRATION: UnicodeString;
begin
  Result := ChildNodes['REGISTRATION'].Text;
end;

procedure TXMLDoctorsPatientType.Set_REGISTRATION(Value: UnicodeString);
begin
  ChildNodes['REGISTRATION'].NodeValue := Value;
end;

function TXMLDoctorsPatientType.Get_RegDate: UnicodeString;
begin
  Result := ChildNodes['RegDate'].Text;
end;

procedure TXMLDoctorsPatientType.Set_RegDate(Value: UnicodeString);
begin
  ChildNodes['RegDate'].NodeValue := Value;
end;

function TXMLDoctorsPatientType.Get_TypeOfChoice: Integer;
begin
  Result := ChildNodes['TypeOfChoice'].NodeValue;
end;

procedure TXMLDoctorsPatientType.Set_TypeOfChoice(Value: Integer);
begin
  ChildNodes['TypeOfChoice'].NodeValue := Value;
end;

function TXMLDoctorsPatientType.Get_Representative: IXMLRepresentativeType;
begin
  Result := ChildNodes['Representative'] as IXMLRepresentativeType;
end;

function TXMLDoctorsPatientType.Get_NoOfHealthBookBG: Integer;
begin
  Result := ChildNodes['NoOfHealthBookBG'].NodeValue;
end;

procedure TXMLDoctorsPatientType.Set_NoOfHealthBookBG(Value: Integer);
begin
  ChildNodes['NoOfHealthBookBG'].NodeValue := Value;
end;

{ TXMLDoctorsPatientTypeList }

function TXMLDoctorsPatientTypeList.Add: IXMLDoctorsPatientType;
begin
  Result := AddItem(-1) as IXMLDoctorsPatientType;
end;

function TXMLDoctorsPatientTypeList.Insert(const Index: Integer): IXMLDoctorsPatientType;
begin
  Result := AddItem(Index) as IXMLDoctorsPatientType;
end;

function TXMLDoctorsPatientTypeList.Get_Item(Index: Integer): IXMLDoctorsPatientType;
begin
  Result := List[Index] as IXMLDoctorsPatientType;
end;

{ TXMLPatientType }

procedure TXMLPatientType.AfterConstruction;
begin
  RegisterChildNode('IDENTITY', TXMLIDENTITYType);
  RegisterChildNode('ADDRESS', TXMLADDRESSType);
  inherited;
end;

function TXMLPatientType.Get_IDENTITY: IXMLIDENTITYType;
begin
  Result := ChildNodes['IDENTITY'] as IXMLIDENTITYType;
end;

function TXMLPatientType.Get_FIRSTNAME: UnicodeString;
begin
  Result := ChildNodes['FIRSTNAME'].Text;
end;

procedure TXMLPatientType.Set_FIRSTNAME(Value: UnicodeString);
begin
  ChildNodes['FIRSTNAME'].NodeValue := Value;
end;

function TXMLPatientType.Get_FAMILYNAME: UnicodeString;
begin
  Result := ChildNodes['FAMILYNAME'].Text;
end;

procedure TXMLPatientType.Set_FAMILYNAME(Value: UnicodeString);
begin
  ChildNodes['FAMILYNAME'].NodeValue := Value;
end;

function TXMLPatientType.Get_SEX: UnicodeString;
begin
  Result := ChildNodes['SEX'].Text;
end;

procedure TXMLPatientType.Set_SEX(Value: UnicodeString);
begin
  ChildNodes['SEX'].NodeValue := Value;
end;

function TXMLPatientType.Get_BIRTH_DATE: UnicodeString;
begin
  Result := ChildNodes['BIRTH_DATE'].Text;
end;

procedure TXMLPatientType.Set_BIRTH_DATE(Value: UnicodeString);
begin
  ChildNodes['BIRTH_DATE'].NodeValue := Value;
end;

function TXMLPatientType.Get_CITIZENSHIP: UnicodeString;
begin
  Result := ChildNodes['CITIZENSHIP'].Text;
end;

procedure TXMLPatientType.Set_CITIZENSHIP(Value: UnicodeString);
begin
  ChildNodes['CITIZENSHIP'].NodeValue := Value;
end;

function TXMLPatientType.Get_ADDRESS: IXMLADDRESSType;
begin
  Result := ChildNodes['ADDRESS'] as IXMLADDRESSType;
end;

function TXMLPatientType.Get_SECONDNAME: UnicodeString;
begin
  Result := ChildNodes['SECONDNAME'].Text;
end;

procedure TXMLPatientType.Set_SECONDNAME(Value: UnicodeString);
begin
  ChildNodes['SECONDNAME'].NodeValue := Value;
end;

{ TXMLADDRESSType }

function TXMLADDRESSType.Get_ZIPCode: Integer;
begin
  Result := ChildNodes['ZIPCode'].NodeValue;
end;

procedure TXMLADDRESSType.Set_ZIPCode(Value: Integer);
begin
  ChildNodes['ZIPCode'].NodeValue := Value;
end;

function TXMLADDRESSType.Get_EKATTECode: Integer;
begin
  Result := ChildNodes['EKATTECode'].NodeValue;
end;

procedure TXMLADDRESSType.Set_EKATTECode(Value: Integer);
begin
  ChildNodes['EKATTECode'].NodeValue := Value;
end;

function TXMLADDRESSType.Get_No: Integer;
begin
  Result := ChildNodes['No'].NodeValue;
end;

procedure TXMLADDRESSType.Set_No(Value: Integer);
begin
  ChildNodes['No'].NodeValue := Value;
end;

function TXMLADDRESSType.Get_Street: Integer;
begin
  Result := ChildNodes['Street'].NodeValue;
end;

procedure TXMLADDRESSType.Set_Street(Value: Integer);
begin
  ChildNodes['Street'].NodeValue := Value;
end;

function TXMLADDRESSType.Get_City: UnicodeString;
begin
  Result := ChildNodes['City'].Text;
end;

procedure TXMLADDRESSType.Set_City(Value: UnicodeString);
begin
  ChildNodes['City'].NodeValue := Value;
end;

{ TXMLRepresentativeType }

procedure TXMLRepresentativeType.AfterConstruction;
begin
  RegisterChildNode('IDENTITY', TXMLIDENTITYType);
  RegisterChildNode('ADDRESS', TXMLADDRESSType);
  inherited;
end;

function TXMLRepresentativeType.Get_IDENTITY: IXMLIDENTITYType;
begin
  Result := ChildNodes['IDENTITY'] as IXMLIDENTITYType;
end;

function TXMLRepresentativeType.Get_FIRSTNAME: UnicodeString;
begin
  Result := ChildNodes['FIRSTNAME'].Text;
end;

procedure TXMLRepresentativeType.Set_FIRSTNAME(Value: UnicodeString);
begin
  ChildNodes['FIRSTNAME'].NodeValue := Value;
end;

function TXMLRepresentativeType.Get_SECONDNAME: UnicodeString;
begin
  Result := ChildNodes['SECONDNAME'].Text;
end;

procedure TXMLRepresentativeType.Set_SECONDNAME(Value: UnicodeString);
begin
  ChildNodes['SECONDNAME'].NodeValue := Value;
end;

function TXMLRepresentativeType.Get_FAMILYNAME: UnicodeString;
begin
  Result := ChildNodes['FAMILYNAME'].Text;
end;

procedure TXMLRepresentativeType.Set_FAMILYNAME(Value: UnicodeString);
begin
  ChildNodes['FAMILYNAME'].NodeValue := Value;
end;

function TXMLRepresentativeType.Get_SEX: UnicodeString;
begin
  Result := ChildNodes['SEX'].Text;
end;

procedure TXMLRepresentativeType.Set_SEX(Value: UnicodeString);
begin
  ChildNodes['SEX'].NodeValue := Value;
end;

function TXMLRepresentativeType.Get_BIRTH_DATE: UnicodeString;
begin
  Result := ChildNodes['BIRTH_DATE'].Text;
end;

procedure TXMLRepresentativeType.Set_BIRTH_DATE(Value: UnicodeString);
begin
  ChildNodes['BIRTH_DATE'].NodeValue := Value;
end;

function TXMLRepresentativeType.Get_CITIZENSHIP: UnicodeString;
begin
  Result := ChildNodes['CITIZENSHIP'].Text;
end;

procedure TXMLRepresentativeType.Set_CITIZENSHIP(Value: UnicodeString);
begin
  ChildNodes['CITIZENSHIP'].NodeValue := Value;
end;

function TXMLRepresentativeType.Get_ADDRESS: IXMLADDRESSType;
begin
  Result := ChildNodes['ADDRESS'] as IXMLADDRESSType;
end;

end.