unit Options;

interface
uses
  iniFiles, System.IOUtils, System.Classes, VirtualTrees, VirtualStringTreeHipp,
  Aspects.Types, Vcl.Controls, system.Types, Winapi.Messages, Vcl.StdCtrls, Winapi.Windows,
  Vcl.Mask, Vcl.ComCtrls, Vcl.Graphics, system.SysUtils,
  VTREditors;
type



TOptions = class
private
  FvtrOptions: TVirtualStringTreeHipp;
  FEnabledTableSearch: set of TTablesTypeHip;
    FLibTokenDll: string;
    FUserDate: TDate;
  procedure InitVTR;
  procedure SetvtrOptions(const Value: TVirtualStringTreeHipp);
  procedure LogOption(idOptions: integer);
    procedure SetLibTokenDll(const Value: string);
    procedure SetUserDate(const Value: TDate);
public // за лог на опциите. Които са тука се следят и където се използват се слагат в лог-а на опциите.
  dblist: TStringList;
public
  FIni: TIniFile;

  vtrRecentDB: TVirtualStringTreeHipp;
  vRootOptions: PVirtualNode;
  vOptionDB: PVirtualNode;
  vOptionGrids, vOptionGridsSearch: PVirtualNode;
  constructor create(AppDir: string);
  destructor destroy; override;

  procedure AddToDbList(dbName: string);
  procedure LoadVtrRecentDB;

  property  vtrOptions: TVirtualStringTreeHipp read  FvtrOptions write SetvtrOptions;
  property LibTokenDll: string read FLibTokenDll write SetLibTokenDll;
  property UserDate: TDate read FUserDate write SetUserDate;
end;

const
  WM_STARTEDITING = WM_USER + 778;

implementation

{ TOptions }

procedure TOptions.AddToDbList(dbName: string);
var
  stream: TMemoryStream;
  vRootRecentDB: PVirtualNode;
begin
  if self.dblist.IndexOf(dbName) < 0  then
  begin
    stream := TMemoryStream.Create;
    dblist.Add(dbName);
    dblist.SaveToStream(stream);
    stream.Position := 0;
    Fini.WriteBinaryStream('DB', 'DbList', stream);
    stream.Free;
    vRootRecentDB := vtrRecentDB.RootNode.FirstChild;
    vtrRecentDB.DeleteChildren(vRootRecentDB);
    LoadVtrRecentDB;
  end
  else
  begin

  end;
end;

constructor TOptions.create(AppDir: string);
var
  iniFileName: string;

  dblistStream: TMemoryStream;
begin
  inherited create;
  FEnabledTableSearch := [PACIENT, PREGLED, BLANKA_MDN];

  iniFileName := AppDir + '\supHip.ini';
  if not TFile.Exists(iniFileName) then
    tfile.Create(iniFileName);

  dblist := TStringList.Create;
  dblistStream := TMemoryStream.Create;
  FIni := TIniFile.Create(iniFileName);
  FIni.ReadBinaryStream('DB', 'DbList', dbListStream);
  dblistStream.Position := 0;
  dblist.LoadFromStream(dblistStream);
  dblistStream.Free;

  FLibTokenDll := FIni.ReadString('LibToken', 'LibTokenDll', '');
  //UserDate := StrToDate(FIni.ReadString('Test', 'UserDate', '01.01.1900'), ;
end;

destructor TOptions.destroy;
begin
  if dblist <> nil then
    dblist.Free;
  FIni.Free;
  inherited;
end;

procedure TOptions.InitVTR;
var
  v: PVirtualNode;
  data: POptionData;
  i: Integer;
  tableType: TTablesTypeHip;
begin
  FvtrOptions.NodeDataSize := SizeOf(TOptionData);
  vRootOptions := FvtrOptions.AddChild(nil, nil);
  Data := vtrOptions.GetNodeData(vRootOptions);
  data.vid := vvOptionRoot;
  data.index := -1;

  vOptionDB := FvtrOptions.AddChild(vRootOptions, nil);
  Data := vtrOptions.GetNodeData(vOptionDB);
  data.vid := vvOptionDB;
  data.index := -1;

  vOptionDB := FvtrOptions.AddChild(vRootOptions, nil);
  Data := vtrOptions.GetNodeData(vOptionDB);
  data.vid := vvOptionDB;
  data.index := -1;

  vOptionGrids := FvtrOptions.AddChild(vRootOptions, nil);
  Data := vtrOptions.GetNodeData(vOptionGrids);
  data.vid := vvOptionGrids;
  data.index := -1;

  vOptionGridsSearch := FvtrOptions.AddChild(vOptionGrids, nil);
  Data := vtrOptions.GetNodeData(vOptionGridsSearch);
  data.vid := vvOptionGridSearch;
  data.index := -1;


  for tableType in FEnabledTableSearch do
  begin
    v := FvtrOptions.AddChild(vOptionGridsSearch, nil);
    Data := vtrOptions.GetNodeData(v);
    data.vid := vvOptionGridSearch;
    data.index := word(tableType);
  end;


  //for i := 0 to 1000 do
//  begin
//    v := FvtrOptions.AddChild(vRootOptions, nil);
//    Data := FvtrOptions.GetNodeData(v);
//    Data.ValueType := TValueEditorsType(i mod 8);//vetString;
//    if Data.ValueType = vetDate then
//      Data.Value := DateToStr(Now)
//    else
//      Data.Value := '';
//  end;
  vtrOptions.FullExpand();
end;

procedure TOptions.LoadVtrRecentDB;
var
  i: Integer;
  data: PAspRec;
  v: PVirtualNode;
begin
  for i := 0 to dblist.Count - 1 do
  begin
    if not TFile.Exists(dblist[i]) then
      Continue;
    v := vtrRecentDB.AddChild(vtrRecentDB.RootNode.FirstChild, nil);
    data := vtrRecentDB.GetNodeData(v);
    data.index := i;
    data.vid := vvNone;
  end;
  vtrRecentDB.FullExpand();
end;

procedure TOptions.LogOption(idOptions: Integer);
begin

end;

procedure TOptions.SetLibTokenDll(const Value: string);
begin
  FLibTokenDll := Value;
  FIni.WriteString('LibToken', 'LibTokenDll', FLibTokenDll);
end;

procedure TOptions.SetUserDate(const Value: TDate);
begin
  FUserDate := Value;
  Aspects.Types.FUserDate := FUserDate;
end;

procedure TOptions.SetvtrOptions(const Value: TVirtualStringTreeHipp);
begin
  FvtrOptions := Value;
  InitVTR;
end;



end.
