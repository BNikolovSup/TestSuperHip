unit DM;

interface

uses
  System.SysUtils, System.Classes, IBX.IBSQL, IBX.IBDatabase, Data.DB,
   Winapi.Windows, dialogs, System.Generics.Collections, RealObj.RealHipp,
  IBX.IBScript;

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
    ibsqlDiag: TIBSQL;
    ibscrpt1: TIBScript;
    ibsqlMedNapr3A: TIBSQL;
    ibsqlIncMDN: TIBSQL;
    ibsqlMedNaprHosp: TIBSQL;
    ibsqlMedNaprLKK: TIBSQL;
    ibsqlIncMN: TIBSQL;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ibsqlCommandSQLChanging(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DBMainAfterConnect(Sender: TObject);
  private
    FIsGP: Boolean;

    function GetComputerNam: string;
  public
    FGuidDB: TList<TGUID>;
    procedure InitDb(DBName: string);
    function GetDoctorNameFromDB(uin: string): string;
    procedure InsertDiag(posData, posDataPreg: cardinal; collDiag: TRealDiagnosisColl; collPreg: TRealPregledNewColl);
    property IsGP: Boolean read FIsGP;

  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDU }

uses
  Table.PregledNew, Table.Diagnosis;

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

procedure TDUNzis.DBMainAfterConnect(Sender: TObject);
begin
  ibscrpt1.ExecuteScript;
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

procedure TDUNzis.InsertDiag(posData, posDataPreg: cardinal; collDiag: TRealDiagnosisColl;
      collPreg: TRealPregledNewColl);
var
  StatDiag: TlogicalDiagnosisSet;
  statDiagInt: Integer;
begin


  ibsqlDiag.Close;
  ibsqlDiag.ParamByName('DOKUMENT_ID').AsInteger := collPreg.getIntMap(posDataPreg, word(PregledNew_ID));
  ibsqlDiag.ParamByName('DOKUMENT_TYPE').AsInteger := 0;
  ibsqlDiag.ParamByName('DIAGNOSIS_CODE_CL011').AsString := collDiag.getAnsiStringMap(posData, word(Diagnosis_code_CL011));
  ibsqlDiag.ParamByName('DIAGNOSIS_ADDITIONALCODE_CL011').AsString := collDiag.getAnsiStringMap(posData, word(DIAGNOSIS_ADDITIONALCODE_CL011));
  ibsqlDiag.ParamByName('DIAGNOSIS_RANK').AsInteger := collDiag.getWordMap(posData, word(DIAGNOSIS_RANK));
  ibsqlDiag.ParamByName('DIAGNOSIS_ONSETDATETIME').AsDateTime := collPreg.getDateMap(posDataPreg, word(PregledNew_START_DATE)) +
     collPreg.getDateMap(posDataPreg, word(PregledNew_START_TIME));
  ibsqlDiag.ParamByName('DIAGNOSIS_MKBPOS').AsInteger := collDiag.getIntMap(posData, word(DIAGNOSIS_MKBPOS));

  StatDiag := [];
  if ibsqlDiag.ParamByName('DIAGNOSIS_RANK').AsInteger = 0 then
    Include(StatDiag, TlogicalDiagnosis.use_CL076_Chief_Complaint)
  else
    Include(StatDiag, TlogicalDiagnosis.use_CL076_Comorbidity);

  Include(StatDiag, TlogicalDiagnosis.ClinicalStatus_Relapse);
  Include(StatDiag, TlogicalDiagnosis.VerificationStatusDifferential);
  statDiagInt := Integer(word(StatDiag));
  ibsqlDiag.ParamByName('DIAGNOSIS_LOGICAL').AsInteger := statDiagInt;


  ibsqlDiag.ExecQuery;

end;

end.
