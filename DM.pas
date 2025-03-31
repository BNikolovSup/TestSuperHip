unit DM;

interface

uses
  System.SysUtils, System.Classes, IBX.IBSQL, IBX.IBDatabase, Data.DB,
   Winapi.Windows, dialogs, System.Generics.Collections;

type
  TDUNzis = class(TDataModule)
    DBMain: TIBDatabase;
    traMain: TIBTransaction;
    ibsqlCommand: TIBSQL;
    ibsqlDocLite: TIBSQL;
    ibsqlPregledLite: TIBSQL;
    ibsqlPatLite: TIBSQL;
    ibsqlPrac: TIBSQL;
    ibsqlDokuments: TIBSQL;
    ibsqlDocumentPat: TIBSQL;
    ibsqlPreg: TIBSQL;
    ibsqlMDNLite: TIBSQL;
    ibsqlEmdnOne: TIBSQL;
    ibsqlEMNOne: TIBSQL;
    ibsqlAnal: TIBSQL;
    ibsqlMn3AOne: TIBSQL;
    ibsqlEMN6One: TIBSQL;
    ibsqlOneHosp: TIBSQL;
    IBTransaction1: TIBTransaction;
    ibsqlMedbelOne: TIBSQL;
    ibsqlCommandUdost: TIBSQL;
    ibsqlPregNew_GP: TIBSQL;
    ibsqlPatNew_S: TIBSQL;
    ibsqlMKBNew: TIBSQL;
    ibsqlMedNaprNew: TIBSQL;
    ibsqlDoctorNew: TIBSQL;
    ibsqlUnfavNew: TIBSQL;
    ibsqlMDNNew: TIBSQL;
    ibsqlExamAnalNew: TIBSQL;
    ibsqlPatNew_GP: TIBSQL;
    ibsqlPracNew: TIBSQL;
    ibsqlEBLNew: TIBSQL;
    ibsqlPregNew_S: TIBSQL;
    ibsqlExamInun: TIBSQL;
    ibsqlProceduresGP: TIBSQL;
    ibsqlProcedures_S: TIBSQL;
    ibsqlKardProf: TIBSQL;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ibsqlCommandSQLChanging(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FIsGP: Boolean;

    function GetComputerNam: string;
  public
    FGuidDB: TList<TGUID>;
    procedure InitDb(DBName: string);
    function GetDoctorNameFromDB(uin: string): string;
    property IsGP: Boolean read FIsGP;

  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDU }

procedure TDUNzis.DataModuleCreate(Sender: TObject);
begin
  FGuidDB := TList<TGUID>.Create;
  //FGuidDB := TGUID.Empty;
end;

procedure TDUNzis.DataModuleDestroy(Sender: TObject);
begin
  self.DBMain.Connected := False;
  FreeAndNil(FGuidDB);
end;

function TDUNzis.GetComputerNam: string;
var
  namSize: dword;
  compName: array[0..MAX_PATH] of AnsiChar;
begin
  namSize := MAX_PATH - 1;
  GetComputerNameA(compName, namSize);
  Result := compName;
end;

function TDUNzis.GetDoctorNameFromDB(uin: string): string;
begin
  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
    'select doc.fname || '' '' || doc.sname || '' '' || doc.lname from doctor doc' + #13#10 +
    'where doc.uin = :UIN';
  ibsqlCommand.ParamByName('UIN').AsString := uin;
  ibsqlCommand.ExecQuery;
  Result := ibsqlCommand.Fields[0].AsString;
end;

procedure TDUNzis.ibsqlCommandSQLChanging(Sender: TObject);
begin
  ibsqlCommand.Transaction.TransactionID;
end;

procedure TDUNzis.InitDb(DBName: string);
var
  compName: string;
begin
  try
    self.DBMain.Connected := False;
  except
    on E: Exception do
    begin

      Exit;
    end;
  end;
  self.DBMain.DatabaseName := DBName;
  try
    self.DBMain.Connected := True;
  except
    on E: Exception do
    begin
    end;
  end;
  self.traMain.Active := True;
  self.traMain.Commit;
  self.traMain.Active := True;
  FGuidDB.Clear;
  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
       'select ini.ini_value from ini where ini.ini_section =  ''Version'' and ini.ini_key = ''ProgramName'' ;';
  ibsqlCommand.ExecQuery;
  FIsGP := Trim(ibsqlCommand.Fields[0].AsString) <> 'Хипократ-S';

  compName := GetComputerNam;

  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
        'select hu.guid_adb from history_users hu' + #13#10 +
          'where hu.comp_name = :compName';
  ibsqlCommand.ParamByName('compName').AsString := compName;
  ibsqlCommand.ExecQuery;

  while not ibsqlCommand.Eof do
  begin
    FGuidDB.Add(StringToGUID(Trim(ibsqlCommand.Fields[0].AsString)));
    ibsqlCommand.Next;
  end;
end;

end.
