unit DBCollection.Patient;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections,
  DBCollection.Addres, DBCollection.Pregled;

type
  TRegType = (rtPost, rtVrem);
  TChoceType = (ctSelf, ctRoditel, ctNastoinik);
  TInPisDB = (inNone, inPis, inDB, inDBPIS);

  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;


  TPatientItem = class(TCollectionItem)
  private
    FLName: string;
    FFName: string;
    FSName: string;
    FFullName: string;
    FIdPatient: Integer;
    FEgn: string;
    FLNC: string;
    FEZOK: string;
    FSNC: string;
    FSpogodba: string;
    FToDate: TDate;
    FFromDate: TDate;
    FRegType: TRegType;
    FReasonOtp: string;
    FChoceType: TChoceType;
    FInPisDB: TInPisDB;
    function GetFullName: string;
  public
    FAddresses: TList<TAddresItem>;
    FPregledi: TList<TPregledItem>;

    //MainGroup: TDynGroup;
//    FEditEgn: TDynEditData;
//    FEditFullName: TDynEditData;
    
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    //procedure LoadToDynPanel(Dyn: TDynWinPanel);

    property IdPatient: Integer read FIdPatient write FIdPatient;
    property EGN: string read FEgn write FEgn;
    property LNC: string read FLNC write FLNC;
    property SNC: string read FSNC write FSNC;
    property EZOK: string read FEZOK write FEZOK;
    property Spogodba: string read FSpogodba write FSpogodba;
    property FName: string read FFName write FFName;
    property SName: string read FSName write FSName;
    property LName: string read FLName write FLName;
    property FullName: string read GetFullName;
    property FromDate: TDate read FFromDate write FFromDate;
    property ToDate: TDate read FToDate write FToDate;
    property RegType: TRegType read FRegType write FRegType;
    property ReasonOtp: string read FReasonOtp write FReasonOtp;
    property ChoceType: TChoceType read FChoceType write FChoceType;
    property InPisDB: TInPisDB read FInPisDB write FInPisDB;
  end;

  TPatientColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TPatientItem;
    procedure SetItem(Index: Integer; Value: TPatientItem);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
    procedure SortByPatientID;
    procedure SortByEgn;
    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TPatientItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TPatientColl.Create(AOwner: TComponent);
begin
  inherited create(TPatientItem);
  FOwner := AOwner;
end;

destructor TPatientColl.Destroy;
begin

  inherited;
end;

function TPatientColl.GetItem(Index: Integer): TPatientItem;
begin
  Result := TPatientItem(inherited GetItem(Index));
end;

function TPatientColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TPatientColl.SetItem(Index: Integer; Value: TPatientItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPatientColl.SortByEgn;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I]).EGN < (Items[P]).EGN do Inc(I);
        while (Items[J]).EGN > (Items[P]).EGN do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TPatientColl.SortByPatientID;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I]).IdPatient < (Items[P]).IdPatient do Inc(I);
        while (Items[J]).IdPatient > (Items[P]).IdPatient do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

{ TConsulatationItem }

constructor TPatientItem.Create(Collection: TCollection);
begin
  inherited;
  FFullName := '';
  FAddresses := TList<TAddresItem>.Create;
  FPregledi := TList<TPregledItem>.Create;
end;

destructor TPatientItem.Destroy;
begin
  FreeAndNil(FAddresses);
  FreeAndNil(FPregledi);
  inherited;
end;

function TPatientItem.GetFullName: string;
begin
  if FFullName = '' then
  begin
    Result := FFName;
    if FSName <> '' then
      Result := Result + FSName;
    Result := Result + FLName;
  end
  else
  begin
    Result := FFullName;
  end;
end;

//procedure TPatientItem.LoadToDynPanel(Dyn: TDynWinPanel);
//var
//  i: Integer;
//  OffsetAddr: Integer;
//begin
//  MainGroup := DYN.AddRunTimeDynGroup(76, 37, 286, 176, 99, 14, 'Пациент');
//  FEditFullName := DYN.AddRunTimeDynEditRelative(MainGroup, 10, 40, 203, 57, 21, 12,
//      'Име, презиме и фамилия по л.к.');
//
//  FEditEgn := DYN.AddRunTimeDynEditRelative(MainGroup, 10, 15, 81, 32, 22, 12, 'EGN');
//  OffsetAddr := 10;
//  for i := 0 to FAddresses.Count - 1 do
//  begin
//    FAddresses[i].LoadToDynPanel(Dyn, MainGroup, offsetAddr);
//    OffsetAddr := OffsetAddr + 10 + (FAddresses[i].FGroupAddres.DynBottom - FAddresses[i].FGroupAddres.DynTop);
//  end;
//  MainGroup.DynBottom := FAddresses[FAddresses.Count - 1].FGroupAddres.DynBottom + 10;
//  TDynGroupBox(MainGroup.FDynGroupBox).FRect.Height := MainGroup.DynBottom - MainGroup.DynTop;
//
//  //FGroupAddres := DYN.AddRunTimeDynGrpRelative(MainGroup, 7, 67, 200, 135, 100, 14, 'Адрес');
////  FMemoAddress := DYN.AddRunTimeDynMemoRelative(MainGroup, 9, 81, 196, 117, 335, 12,
////      'по време на изпълнение, каквото има за адреса');
//end;

end.
