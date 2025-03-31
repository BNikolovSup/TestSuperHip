unit DBCollection.Addres;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math;

type
  TAddresItem = class(TCollectionItem)
  private
    FCountry: string;
    FCity: string;
    FCounty: string;
    FApart: string;
    FEtag: string;
    FPostalCode: string;
    FBl: string;
    FNomer: string;
    FUlica: string;
    FVh: string;
    FJK: string;
    function GetAddressDetails: string;
  public
    //FGroupSubject: TDynGroup;

    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    //procedure LoadToDynPanel(Dyn: TDynWinPanel; SubjectGroup: TDynGroup; offset: Integer);

    property Country: string read FCountry write FCountry;
    property County: string read FCounty write FCounty;
    property City: string read FCity write FCity;
    property PostalCode: string read FPostalCode write FPostalCode;
    property Ulica: string read FUlica write FUlica;
    property Nomer: string read FNomer write FNomer;
    property JK: string read FJK write FJK;
    property BL: string read FBl write FBL;
    property Vh: string read FVh write FVh;
    property Etag: string read FEtag write FEtag;
    property Apart: string read FApart write FApart;

    property AddressDetails: string read GetAddressDetails;
  end;

  TAddresColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TAddresItem;
    procedure SetItem(Index: Integer; Value: TAddresItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TAddresItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TAddresColl.Create(AOwner: TComponent);
begin
  inherited create(TAddresItem);
  FOwner := AOwner;
end;

destructor TAddresColl.Destroy;
begin

  inherited;
end;

function TAddresColl.GetItem(Index: Integer): TAddresItem;
begin
  Result := TAddresItem(inherited GetItem(Index));
end;

function TAddresColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TAddresColl.SetItem(Index: Integer; Value: TAddresItem);
begin
  inherited SetItem(Index, Value);
end;

{ TConsulatationItem }

constructor TAddresItem.Create(Collection: TCollection);
begin
  inherited;

end;

destructor TAddresItem.Destroy;
begin

  inherited;
end;

function TAddresItem.GetAddressDetails: string;
begin

end;

//procedure TAddresItem.LoadToDynPanel(Dyn: TDynWinPanel; SubjectGroup: TDynGroup; offset: Integer);
//begin
//  FGroupAddres := DYN.AddRunTimeDynGrpRelative(SubjectGroup, 7, 67 + offset, 200, 135 + offset, 100, 14, 'Адрес');
//  FMemoAddress := DYN.AddRunTimeDynMemoRelative(SubjectGroup, 9, 81 + offset, 196, 117 + offset, 335, 12,
//      'по време на изпълнение, каквото има за адреса');
//end;

end.
