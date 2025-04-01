unit AspectiTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, system.Diagnostics, system.TimeSpan,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.GIFImg, VirtualTrees, system.Rtti,
  VirtualStringTreeAspect,
  Aspects.Types,
  Aspects.Collections,

  Table.PregledNew
  ;

type
  TForm5 = class(TForm)
    btnOpenLNK: TButton;
    mmoTest: TMemo;
    spl1: TSplitter;
    vtrPregledPat: TVirtualStringTreeAspect;
    spl2: TSplitter;
    procedure btnOpenLNKClick(Sender: TObject);
    procedure vtrPregledPatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    AspectsLinkPatPregFile: TMappedLinkFile;
    AspectsHipFile: TMappedFile;

    CollPregled: TPregledNewColl;
  public
    procedure OpenADB(ADB: TMappedFile);
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

{ TForm5 }

procedure TForm5.btnOpenLNKClick(Sender: TObject);
var
  fileLinkName, fileAdbName: string;
begin
  //test git hub11113333444455555
  Stopwatch := TStopwatch.StartNew;
  fileLinkName := 'D:\VSS\Hippocrates40\bin\Hippocrates360\AspHip{1AA755B0-D6DF-4B98-BAC8-99036AD8009F}.lnk';
  fileAdbName := 'D:\VSS\Hippocrates40\bin\Hippocrates360\AspHip{1AA755B0-D6DF-4B98-BAC8-99036AD8009F}.adb';
  AspectsHipFile := TMappedFile.Create(fileAdbName, false, TGUID.Empty);
  AspectsLinkPatPregFile := TMappedLinkFile.Create(fileLinkName, false, TGUID.Empty);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  AspectsLinkPatPregFile.FVTR := vtrPregledPat;
  Stopwatch := TStopwatch.StartNew;
  AspectsLinkPatPregFile.OpenLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrPregledPat.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

  OpenADB(AspectsHipFile);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  CollPregled := TPregledNewColl.Create(TPregledNewItem);
end;

procedure TForm5.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CollPregled);
end;

procedure TForm5.OpenADB(ADB: TMappedFile);
var
  collType: TCollectionsType;
  aspVersion: Word;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  pg: PGUID;
begin
  Stopwatch := TStopwatch.StartNew;
  if ADB.Buf <> nil then
  begin
    pCardinalData := pointer(PByte(ADB.Buf));
    ADB.FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 4);
    ADB.FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 8);
    ADB.FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 12);
    ADB.FLenData := pCardinalData^;
    Pg := pointer(PByte(ADB.Buf) + 16 );
    ADB.GUID := pg^;
    mmoTest.Lines.Add(pg^.ToString);
    mmoTest.Lines.Add(inttostr(SizeOf(tguid)));

    aspPos := ADB.FPosMetaData;
    CollPregled.Buf := ADB.Buf;
    CollPregled.posData := ADB.FPosData;
  end;


  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('Зареждане за %f',[Elapsed.TotalMilliseconds]));

end;



procedure TForm5.vtrPregledPatGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  case Column of
    0:
    begin
      case data.vid of
        vvPregled:
        begin
          CellText := CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_NRN));
        end;
      end;
    end;
    1:
    begin
      CellText := IntToStr(Data.DataPos);
    end;
    2:
    begin
      CellText := TRttiEnumerationType.GetName(Data.vid);
    end;
  end;
end;

end.
