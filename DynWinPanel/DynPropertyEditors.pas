unit DynPropertyEditors;

interface

uses
  System.SysUtils, DesignIntf, DesignConst, DesignEditors, system.Classes, DynDatabase;
type
  TDynStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TDynFieldProperty = class(TDynStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TDynTableProperty = class(TDynStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;


  

  procedure Register;
implementation
  uses
    DynGroup;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string), TDynGroup, 'DynTableName', TDynTableProperty);
  RegisterPropertyEditor(TypeInfo(string), TDynGroup, 'FieldName', TDynFieldProperty);
end;



{ TDynStringProperty }

function TDynStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDynStringProperty.GetValueList(List: TStrings);
begin

end;

procedure TDynStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ TDynFieldProperty }

procedure TDynFieldProperty.GetValueList(List: TStrings);
var
  dynDb: TDynDatabase;
begin
  inherited;
  if TDynGroup(GetComponent(0)).DynTableName = '' then Exit;

  dynDb := TDynDatabase.Create;
  List.Assign(dynDb.FieldNames[TDynGroup(GetComponent(0)).DynTableName]);
  FreeAndNil(dynDb);
end;

{ TDynTableProperty }

procedure TDynTableProperty.GetValueList(List: TStrings);
var
  dynDb: TDynDatabase;
begin
  inherited;
  dynDb := TDynDatabase.Create;
  List.Assign(dynDb.TableNames);
  FreeAndNil(dynDb);
end;

end.
