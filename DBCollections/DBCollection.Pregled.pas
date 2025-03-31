unit DBCollection.Pregled;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections, DBCollection.Diagnosis, DBCollection.MedNapr, DBCollection.Types,
  VirtualTrees, Aspects.Collections, Table.Clients, Aspects.Types;

type
  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  TGroupField = (gfNone, gfAmbListNo, gfStartDate);
  TFilterFields = set of TGroupField;

  TPregledItem = class(TClientsItem)
  private
    FDoctorId: Integer;
    FPatientID: Integer;
    FIdPregled: Integer;
    FAmbListNo: Integer;
    FStartTime: TTime;
    FStartDate: TDate;
    FNRN: string;
    FAMB_PR: Integer;
    FSIMP_PRIMARY_AMBLIST_N: Integer;
    FSIMP_PRIMARY_AMBLIST_DATE: TDate;
    FGroupField: TGroupField;
    FListGroup: TList<TPregledItem>;
    FFilterFields: TFilterFields;
    function GetDiagnosisStr: string;
    function GetMedNaprStr: string;
  public
    FPatient: TObject;
    FPrimary: TPregledItem;
    FDiagnosis: TList<TDiagnosisItem>;
    FMedNaprs: TList<TMedNaprItem>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property IdPregled: Integer read FIdPregled write FIdPregled;
    property PatientID: Integer read FPatientID write FPatientID;
    property DoctorId: Integer read FDoctorId write FDoctorId;

    property AmbListNo: Integer read FAmbListNo write FAmbListNo;
    property StartDate: TDate read FStartDate write FStartDate;
    property StartTime: TTime read FStartTime write FStartTime;
    property NRN: string read FNRN write FNRN;
    property AMB_PR: Integer read FAMB_PR write FAMB_PR;
    property SIMP_PRIMARY_AMBLIST_N: Integer read FSIMP_PRIMARY_AMBLIST_N write FSIMP_PRIMARY_AMBLIST_N;
    property SIMP_PRIMARY_AMBLIST_DATE: TDate read FSIMP_PRIMARY_AMBLIST_DATE write FSIMP_PRIMARY_AMBLIST_DATE;

    property DiagnosisStr: string read GetDiagnosisStr;
    property MedNaprStr: string read GetMedNaprStr;
    property GroupField: TGroupField read FGroupField write FGroupField;
    property ListGroup: TList<TPregledItem> read FListGroup write FListGroup;
    property FilterFields: TFilterFields read FFilterFields write FFilterFields;

  end;

  TPregledColl = class(TCollection)
    private
    FOwner : TComponent;

    function GetItem(Index: Integer): TPregledItem;
    procedure SetItem(Index: Integer; Value: TPregledItem);
  protected
  public
    ListPregledForFilter: TList<TPregledItem>;

    constructor Create(AOwner : TComponent);
    destructor Destroy; override;

    procedure SortByDoctorID;
    procedure SortByDeputDoctorID;

    procedure SortByPatientID;
    procedure SortByPregledID;
    procedure SortByNRN;
    procedure SortByForPrimaryOptim;
    procedure SortListByForPrimaryOptim(list: TList<TPregledItem>);
    procedure SortListByForPrimaryOptim1(list: TList<TPregledItem>);
    procedure SortListByStartDate(list: TList<TPregledItem>);
    procedure SortListByAmbListNo(list: TList<TPregledItem>);

    procedure vtrFilterGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
         Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);

    function GetOwner : TPersistent; override;
    property Items[Index: Integer]: TPregledItem read GetItem write SetItem;
  end;
implementation

{ TConsultationColl }

constructor TPregledColl.Create(AOwner: TComponent);
begin
  inherited create(TPregledItem);
  ListPregledForFilter := TList<TPregledItem>.Create;
  FOwner := AOwner;
end;

destructor TPregledColl.Destroy;
begin
  FreeAndNil(ListPregledForFilter);
  inherited;
end;

function TPregledColl.GetItem(Index: Integer): TPregledItem;
begin
  Result := TPregledItem(inherited GetItem(Index));
end;

function TPregledColl.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TPregledColl.SetItem(Index: Integer; Value: TPregledItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPregledColl.SortByDeputDoctorID;
begin

end;

procedure TPregledColl.SortByDoctorID;
begin

end;

procedure TPregledColl.SortByForPrimaryOptim;
var
  sc : TList<TCollectionItem>;

  function conditionI(i, p: integer): Boolean;
  begin
    if Items[i].FPatientID <> Items[P].FPatientID then
      Result := Items[i].FPatientID < Items[P].FPatientID
    else
    if Items[i].FDoctorId <> Items[P].FDoctorId then
      Result := Items[i].FDoctorId < Items[P].FDoctorId
    else
    if Items[i].FAmbListNo <> Items[P].FAmbListNo then
      Result := Items[i].FAmbListNo < Items[P].FAmbListNo
    else
      Result := Items[i].FStartDate < Items[P].FStartDate
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if Items[J].FPatientID <> Items[P].FPatientID then
      Result := Items[J].FPatientID > Items[P].FPatientID
    else
    if Items[J].FDoctorId <> Items[P].FDoctorId then
      Result := Items[J].FDoctorId > Items[P].FDoctorId
    else
    if Items[J].FAmbListNo <> Items[P].FAmbListNo then
      Result := Items[J].FAmbListNo > Items[P].FAmbListNo
    else
      Result := Items[J].FStartDate > Items[P].FStartDate
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TCollectionItem;
  begin
    repeat
      i := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
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

procedure TPregledColl.SortByNRN;
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
        while TPregledItem(Items[I]).FDiagnosis[0].MKB < TPregledItem(Items[P]).FDiagnosis[0].MKB do Inc(I);
        while TPregledItem(Items[J]).FDiagnosis[0].MKB > TPregledItem(Items[P]).FDiagnosis[0].MKB do Dec(J);
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

procedure TPregledColl.SortByPatientID;
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
        while TPregledItem(Items[I]).FPatientID < TPregledItem(Items[P]).FPatientID do Inc(I);
        while TPregledItem(Items[J]).FPatientID > TPregledItem(Items[P]).FPatientID do Dec(J);
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

procedure TPregledColl.SortByPregledID;
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
        while TPregledItem(Items[I]).FIdPregled < TPregledItem(Items[P]).FIdPregled do Inc(I);
        while TPregledItem(Items[J]).FIdPregled > TPregledItem(Items[P]).FIdPregled do Dec(J);
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

procedure TPregledColl.SortListByAmbListNo(list: TList<TPregledItem>);
function conditionI(i, p: integer): Boolean;
  begin
      Result := (list[i].AmbListNo) < (list[P].AmbListNo);

      //Result := AnsiCompareText(list[i].FDiagnosis[0].NameMKB, list[P].FDiagnosis[0].NameMKB)> 0;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
      Result := (list[J].AmbListNo) > (list[P].AmbListNo);
      //Result := AnsiCompareText(list[j].FDiagnosis[0].NameMKB, list[P].FDiagnosis[0].NameMKB)< 0
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TPregledItem;
  begin
    repeat
      i := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] :=list[J];
          list[J] := Save;
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
  if (list.Count >1 ) then
  begin
    QuickSort(0,list.count-1);
  end;
end;

procedure TPregledColl.SortListByForPrimaryOptim(list: TList<TPregledItem>);

  function conditionI(i, p: integer): Boolean;
  begin
    if list[i].FPatientID <> list[P].FPatientID then
      Result := list[i].FPatientID < list[P].FPatientID
    else
    if list[i].FDoctorId <> list[P].FDoctorId then
      Result := list[i].FDoctorId < list[P].FDoctorId
    else
    if list[i].FAmbListNo <> list[P].FAmbListNo then
      Result := list[i].FAmbListNo < list[P].FAmbListNo
    else
      Result := list[i].FStartDate < list[P].FStartDate
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if list[J].FPatientID <> list[P].FPatientID then
      Result := list[J].FPatientID > list[P].FPatientID
    else
    if list[J].FDoctorId <> list[P].FDoctorId then
      Result := list[J].FDoctorId > list[P].FDoctorId
    else
    if list[J].FAmbListNo <> list[P].FAmbListNo then
      Result := list[J].FAmbListNo > list[P].FAmbListNo
    else
      Result := list[J].FStartDate > list[P].FStartDate
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TPregledItem;
  begin
    repeat
      i := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] :=list[J];
          list[J] := Save;
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
  if (list.Count >1 ) then
  begin
    QuickSort(0,list.count-1);
  end;
end;

procedure TPregledColl.SortListByForPrimaryOptim1(list: TList<TPregledItem>);
function conditionI(i, p: integer): Boolean;
  begin
    if list[i].FPatientID <> list[P].FPatientID then
      Result := list[i].FPatientID < list[P].FPatientID
    else
    if list[i].FDoctorId <> list[P].FDoctorId then
      Result := list[i].FDoctorId < list[P].FDoctorId
    else
    if list[i].FSIMP_PRIMARY_AMBLIST_N <> list[P].FSIMP_PRIMARY_AMBLIST_N then
      Result := list[i].FSIMP_PRIMARY_AMBLIST_N < list[P].FSIMP_PRIMARY_AMBLIST_N
    else
      Result := list[i].FSIMP_PRIMARY_AMBLIST_DATE < list[P].FSIMP_PRIMARY_AMBLIST_DATE
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
    if list[J].FPatientID <> list[P].FPatientID then
      Result := list[J].FPatientID > list[P].FPatientID
    else
    if list[J].FDoctorId <> list[P].FDoctorId then
      Result := list[J].FDoctorId > list[P].FDoctorId
    else
    if list[J].FSIMP_PRIMARY_AMBLIST_N <> list[P].FSIMP_PRIMARY_AMBLIST_N then
      Result := list[J].FSIMP_PRIMARY_AMBLIST_N > list[P].FSIMP_PRIMARY_AMBLIST_N
    else
      Result := list[J].FSIMP_PRIMARY_AMBLIST_DATE > list[P].FSIMP_PRIMARY_AMBLIST_DATE
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TPregledItem;
  begin
    repeat
      i := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] :=list[J];
          list[J] := Save;
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
  if (list.Count >1 ) then
  begin
    QuickSort(0,list.count-1);
  end;
end;

procedure TPregledColl.SortListByStartDate(list: TList<TPregledItem>);
function conditionI(i, p: integer): Boolean;
  begin
    //if list[i].FPatientID <> list[P].FPatientID then
//      Result := list[i].FPatientID < list[P].FPatientID
//    else
//    if list[i].FDoctorId <> list[P].FDoctorId then
//      Result := list[i].FDoctorId < list[P].FDoctorId
//    else
//    if list[i].FSIMP_PRIMARY_AMBLIST_N <> list[P].FSIMP_PRIMARY_AMBLIST_N then
//      Result := list[i].FSIMP_PRIMARY_AMBLIST_N < list[P].FSIMP_PRIMARY_AMBLIST_N
//    else
      Result := list[i].FStartDate < list[P].StartDate;
  end;

  function conditionJ(j, p: integer): Boolean;
  begin
   // if list[J].FPatientID <> list[P].FPatientID then
//      Result := list[J].FPatientID > list[P].FPatientID
//    else
//    if list[J].FDoctorId <> list[P].FDoctorId then
//      Result := list[J].FDoctorId > list[P].FDoctorId
//    else
//    if list[J].FSIMP_PRIMARY_AMBLIST_N <> list[P].FSIMP_PRIMARY_AMBLIST_N then
//      Result := list[J].FSIMP_PRIMARY_AMBLIST_N > list[P].FSIMP_PRIMARY_AMBLIST_N
//    else
      Result := list[J].FStartDate > list[P].FStartDate;
  end;

  procedure QuickSort(L, R: Integer);
  var
    i, J, P: Integer;
    Save: TPregledItem;
  begin
    repeat
      i := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] :=list[J];
          list[J] := Save;
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
  if (list.Count >1 ) then
  begin
    QuickSort(0,list.count-1);
  end;
end;

procedure TPregledColl.vtrFilterGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data, dataPat: PAspRec;
  preg: TPregledItem;
begin
  data := Sender.GetNodeData(node);
  case data.vid of
    vvPregled: //pregled
    begin
      preg := ListPregledForFilter[data.index];
      case Column of
        0:
        begin
          case preg.GroupField of
            gfStartDate: CellText := DateTimeToStr(preg.StartDate);
            gfAmbListNo: CellText := IntToStr(preg.AmbListNo);
          end;

        end;
        1: CellText := IntToStr(preg.FListGroup.Count);
      end;
    end;
  end;
end;

{ TConsulatationItem }

constructor TPregledItem.Create(Collection: TCollection);
begin
  inherited;
  FListGroup := TList<TPregledItem>.Create;
  FDiagnosis := TList<TDiagnosisItem>.create;
  FMedNaprs := TList<TMedNaprItem>.create;
  FPrimary := nil;
end;

destructor TPregledItem.Destroy;
begin
  FreeAndNil(FDiagnosis);
  FreeAndNil(FMedNaprs);
  FreeAndNil(FListGroup);
  inherited;
end;

function TPregledItem.GetDiagnosisStr: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FDiagnosis.Count - 1 do
  begin
    //if FDiagnosis[i].MKB = ''  then
//    begin
//      FDiagnosis[i].MKB := 'eeeee';
//      Continue;
//    end;
    if i < FDiagnosis.Count - 1 then
    begin
      Result := Result + FDiagnosis[i].MKB + ', ';
    end
    else
    begin
      Result := Result + FDiagnosis[i].MKB;
    end;
  end;
end;

function TPregledItem.GetMedNaprStr: string;
var
  i: Integer;
begin
  if FMedNaprs.Count > 0 then
  begin
    Result := 'ÌÍ: ';
  end
  else
  begin
    Result := '';
  end;
  for i := 0 to FMedNaprs.Count - 1 do
  begin
    if i < FMedNaprs.Count - 1 then
    begin
      Result := Result + IntToStr(FMedNaprs[i].Number) + ', ';
    end
    else
    begin
      Result := Result + IntToStr(FMedNaprs[i].Number);
    end;
  end;
end;

end.

