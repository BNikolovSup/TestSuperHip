unit Aspects.Collections;
      //arrcond
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Dialogs, VirtualTrees, VirtualStringTreeAspect, Tee.Grid.Columns,
  System.Generics.Collections, Aspects.Types, VCLTee.Grid, Tee.Grid.Header, Tee.Renders ,
  Tee.GridData.Strings, Vcl.StdCtrls, System.Win.ScktComp, Vcl.Controls,
  Vcl.Graphics, InterruptibleSort, System.StrUtils, System.Math, uKeyThrottle, uVSTSyncHelper,
  Vcl.ExtCtrls, Vcl.Menus;
type
  TBaseItem = class;
  TDiffKind = (dkSame, dkChanged, dkNew, dkDeleted);

  TDiffField = record
    FieldIndex: Integer;
    OldValue: string;
    NewValue: string;
  end;

  TDiffItem = class
    Key: string;
    Kind: TDiffKind;
    Fields: TList<TDiffField>;
    OldItem: TBaseItem;
    NewItem: TBaseItem;
  end;

  TDiffResult = class
    Items: TObjectList<TDiffItem>;
  end;


  TParamProp = 0..255;
  TParamSetProp = set of TParamProp;
  PParamSetProp = ^TParamSetProp;

  tPathIndex = record
    path: UInt64;
    v: PVirtualNode;
  end;

TNumerEdit = class(TEdit)
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure WMCharToItem(var Message: TWMCharToItem); message WM_CHARTOITEM;
  public
    constructor Create(AOwner: TComponent); override;
end;

TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

  {$Z2}
  tvtr = class(TVirtualStringTreeAspect)

  end;

  TCmdRec = record
    CollectionType: TCollectionsType;
    IndexFromCollection: Cardinal;
    IndexDataLink: Cardinal;
    PRec: Pointer;
  end;



  TForLaterSave = record
    posStream: Cardinal;
    TreeLink: TObject;
    vTreeLink: PVirtualNode;
  end;

  TGridForSrarch = class(TTeeGrid);


  TOnCntUpdates = procedure (sender: TObject; cnt: Integer) of object;

  TLog08 = 0..7;
  TLogicalData08 = set of TLog08;
  PLogicalData08 = ^TLogicalData08;
  TLog16 = 0..15;
  TLogicalData16 = set of TLog16;
  PLogicalData16 = ^TLogicalData16;
  TLog24 = 0..23;
  TLogicalData24 = set of TLog24;
  PLogicalData24 = ^TLogicalData24;
  TLog32 = 0..31;
  TLogicalData32 = set of TLog32;
  PLogicalData32 = ^TLogicalData32;

  TLog40 = 0..39;
  TLogicalData40 = set of TLog40;
  PLogicalData40 = ^TLogicalData40;

  TLog48 = 0..47;
  TLogicalData48 = set of TLog48;
  PLogicalData48 = ^TLogicalData48;
  TLog64 = 0..63;
  TLogicalData64 = set of TLog64;
  TLog128 = 0..127;
  TLogicalData128 = set of TLog128;

  TNzisToken  = record
    Bearer: string[255];
    fromDatTime: TDateTime;
    ToDatTime: TDateTime;
    CertID: string[255];
  end;

  TMappedFile = class
    // първите 4 байта са за началото на метаданните (обикновено 100) - 0
    // вторите 4 байта са за дължината на метаданните -4
    // 4 байта са началото на данните  -8
    // 4 байта са за дължина на данните -12
    // 16 байта за ГУИД -16
    // 8 байта за дължината на командния файл - 32
  private

    FBuf: Pointer;
    FSize: Integer;
    FGUID: TGUID;
    FFileName: string;
    procedure MapFileBuf(const AFileName: WideString; IsNew: Boolean);
    function GetSizeCMD: LONG64;

  public
    FPosMetaData, FLenMetaData, FPosData, FLenData, FFileSize: Cardinal;
    FMapping: THandle;
    constructor Create(const AFileName: WideString; IsNew: Boolean; AGuid: TGUID);virtual;
    destructor Destroy; override;
    function GetLenLinkData: cardinal;
    function GetLenMetaData: cardinal;
    function GetLenData: cardinal;
    property Buf: Pointer read FBuf;
    property Size: Integer read FSize;
    property GUID: TGUID read FGUID write FGUID;
    property FileName: string read FFileName;
    property SizeCMD: LONG64 read GetSizeCMD;

  end;

   // Един bucket → един PathSig → списък от реални ADB възли + един FilterNode
  TJoinBucket = record
    Sig: UInt64;                  // ключът по пътя
    AdbList: TList<PVirtualNode>; // всички ADB възли с този path
    FilterNode: PVirtualNode;     // точно един филтърен възел (дете на ObjectGroup или Object)
  end;


  TMappedLinkFile = class(TMappedFile)
  private
    FSearchPopupMenu: TPopupMenu;
    FCurrentFilter: PVirtualNode;
    procedure SetCurrentFilter(const Value: PVirtualNode);
    procedure SetSearchPopupMenu(const Value: TPopupMenu);
  public
    FVTR: TVirtualStringTreeAspect;
    FStreamCmdFile: TFileStream;
    // ако това е АДБ-дърво → FFilterLink сочи към филтърното дърво
    FFilterLink: TMappedLinkFile;


    // MAGIC / STRUCTURE INDEX
    PathIndex: TDictionary<UInt64, TList<PVirtualNode>>;

    // JOIN резултат — създава се само за ADB файла
    JoinResult: TList<TJoinBucket>;

    constructor Create(const AFileName: WideString; IsNew: Boolean; AGuid: TGUID);override;
    destructor Destroy; override;

    // Построяване на структура индекс
    procedure BuildPathIndex;
    procedure AddPathIndexNode(Node: PVirtualNode; Sig: UInt64);

    // Генериране на ключ от пътя
    function ComputeNodePathSig(Node: PVirtualNode): UInt64;

    // Сортиране на ключовете по стойност → за merge join
    procedure SortPathIndexKeys(var Keys: TArray<UInt64>);

    // Основен JOIN метод (много бърз)
    procedure JoinWith(FilterFile: TMappedLinkFile);


    // добавяне/премахване на възли
    procedure AddNewNode(const vv: TVtrVid; dataPos: Cardinal; TargetNode: PVirtualNode; Mode: TVTNodeAttachMode;
       var TreeLink: PVirtualNode; var linkPos: cardinal; dum: Byte = 0);
    procedure MarkDeletedNode(var TreeLink: PVirtualNode);
    procedure OpenLinkFile;
    procedure PopulateSearchPopup(Menu: TPopupMenu);
    procedure InternalMenuPopup(Sender: TObject);
    procedure InternalMenuItemClick(Sender: TObject);

    property SearchPopupMenu: TPopupMenu read FSearchPopupMenu write SetSearchPopupMenu;
    property CurrentFilter: PVirtualNode read FCurrentFilter write SetCurrentFilter;
  end;

  TCommandStream = class(TMemoryStream)
  private
    FVer: word;
    FVid: TCollectionsType;
    FLen: word;
    FPropertys: TLogicalData128;
    FOpType: TOperationType;
    FDataPos: Cardinal;
    procedure SetLen(const Value: word);
    procedure SetVer(const Value: word);
    procedure SetVid(const Value: TCollectionsType);
    procedure SetPropertys(const Value: TLogicalData128);
    procedure SetOpType(const Value: TOperationType);
    procedure SetDataPos(const Value: Cardinal);
  public
    property Len: word read FLen write SetLen;
    property Ver: word read FVer write SetVer;
    property Vid: TCollectionsType read FVid write SetVid;
    property DataPos: Cardinal read FDataPos write SetDataPos;
    property Propertys: TLogicalData128 read FPropertys write SetPropertys;
    property OpType: TOperationType read FOpType write SetOpType;
  end;

  TXmlStream = class(TStringStream)
  private
    FCurrentLine: Integer;
  public
    performer: TObject;
    property CurrentLine: Integer read FCurrentLine write FCurrentLine;
  end;

  TFileCMDStream = class(TFileStream)
  private
    FAspectDataPos: Cardinal;
    FGuid: TGUID;
    procedure SetGuid(const Value: TGUID);
  protected
    ClientServerStream: TMemoryStream;
    procedure scktClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure scktDisconect(Sender: TObject; Socket: TCustomWinSocket);
    procedure AnswWhoAreYou(Socket: TCustomWinSocket);
    procedure EndOfRead;
  public
    scktClient: TClientSocket;
    constructor Create(const AFileName: string; Mode: Word);
    destructor Destroy; override;
    procedure InitAspectConnection;
    Procedure CopyFromCmdStream(cmdStream: TCommandStream; SendToAspect: Boolean = false);
    property AspectDataPos: Cardinal read FAspectDataPos write FAspectDataPos;
    property Guid: TGUID read FGuid write SetGuid;
  end;

  TBaseItem = class(TCollectionItem)
  public
    FVersion: Word;
    FDataPos: Cardinal;
    //CollFromSearch: TCollection;
    function buf: Pointer;

    function getCardMap(buf: pointer; posData: cardinal; propIndex: word): Cardinal;
    function getPCardMap(buf: pointer; posData: cardinal; propIndex: word): PCardinal;

    //function stream: TAspectStream; virtual;
    //function getInt(propIndex: word): integer;
    function getIntMap(buf: pointer; posData: cardinal; propIndex: word): integer;
    procedure SetIntMap(buf: pointer; posData: cardinal; propIndex: word; Aint: integer);// специално за неща като ид-та
    //function getPInt(propIndex: word): PInt;
    function getPIntMap(buf: pointer; posData: cardinal; propIndex: word): PInt;
    //procedure setInt(propIndex: word; intData: integer);

    //function getWord(propIndex: word): Word;
    //function getPWord(propIndex: word): PWord;
    function getWordMap(buf: pointer; posData: cardinal; propIndex: word): Word;
    function getPWordMap(buf: pointer; posData: cardinal; propIndex: word): PWord;


    //function getByte(propIndex: word): Byte;
    //function getPByte(propIndex: word): PByte;
    function getByteMap(buf: pointer; posData: cardinal; propIndex: word): Byte;
    function getPByteMap(buf: pointer; posData: cardinal; propIndex: word): PByte;

    //function getString(propIndex: word): string;
    //function getPString(propIndex: word; var len: word): PChar;

    function getStringMap(buf: pointer; posData: cardinal; propIndex: word): PChar;

    //function getAnsiString(propIndex: word): AnsiString;
    function getAnsiStringMap(buf: pointer; posData: cardinal; propIndex: word): AnsiString;
    //function getPAnsiString(propIndex: word; var len: word): PAnsiChar;
    function getPAnsiStringMap(buf: pointer; posData: cardinal; propIndex: word; var len: word): PAnsiChar;

    //function getDouble(propIndex: word): Double;
    //function getPDouble(propIndex: word): PDouble;
    function getDoubleMap(buf: pointer; posData: cardinal; propIndex: word): Double;
    function getPDoubleMap(buf: pointer; posData: cardinal; propIndex: word): PDouble;

    //function getDate(propIndex: word): TDate;
    //function getPDate(propIndex: word): PDate;
    function getDateMap(buf: pointer; posData: cardinal; propIndex: word): TDate;
    function getPDateMap(buf: pointer; posData: cardinal; propIndex: word): PDate;

    //function getTime(propIndex: word): TTime;
    //function getPTime(propIndex: word): PTime;
    function getTimeMap(buf: pointer; posData: cardinal; propIndex: word): TTime;
    function getPTimeMap(buf: pointer; posData: cardinal; propIndex: word): PDateTime;


    //function getBoolean(propIndex: word): boolean;
    //function getPBoolean(propIndex: word): PBoolean;
    function getBooleanMap(buf: pointer; posData: cardinal; propIndex: word): boolean;
    function getPBooleanMap(buf: pointer; posData: cardinal; propIndex: word): PBoolean;

    function getLogical08Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData08;
    function getPLogical08Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData08;

    function getLogical16Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData16;
    function getPLogical16Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData16;

    function getLogical24Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData24;
    function getPLogical24Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData24;

    function getLogical32Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData32;
    function getPLogical32Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData32;

    function getLogical40Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData40;
    function getPLogical40Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData40;


    function getLogical48Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData48;
    function getPLogical48Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData48;

    function getBlobMap(buf: pointer; posData: cardinal; propIndex: word): TStream;
    function getPBlobMap(buf: pointer; posData: cardinal; propIndex: word): Pointer;


    //function getPVirtualNode(propIndex: word): PVirtualNode;

    function ValueToString(propIndex: word; valInt: PInt): string; overload;
    function ValueToString(propIndex: word; valWord: Pword): string; overload;
    function ValueToString(propIndex: word; valByte: PByte): string; overload;
    function ValueToString(propIndex: word; valString: PChar; len: Word): string; overload;
    function ValueToString(propIndex: word; valString: PAnsiChar; len: Word): string; overload;
    function ValueToString(propIndex: word; valBoolean: PBoolean): string; overload;
    function ValueToString(propIndex: word; valDouble: PDouble): string; overload;
    function ValueToString(propIndex: word; valTreeLink: PVirtualNode): string; overload;

    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valInt: PInt): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valWord: Pword): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valByte: PByte): string; overload;
//    function ValueToString(propIndex: word; valString: PChar; len: Word): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valString: PAnsiChar; len: Word): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valBoolean: PBoolean): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valDate: PDate): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valTime: PDateTime): string; overload;
    function ValueToStringMap(buf: pointer; posData: cardinal; propIndex: word; valDouble: PDouble): string; overload;
//    function ValueToString(propIndex: word; valTreeLink: PVirtualNode): string; overload;


    procedure SaveNull(var metaPosition: cardinal);
    procedure SaveHeaderData(var PropPosition, dataPosition: Cardinal);
    procedure UpdateHeaderData(var PropPosition: cardinal; const dataPosition: Cardinal); virtual;

    procedure SaveData(const intData: Integer; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const CardData: Cardinal; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const wordData: word; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const byteData: byte; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const strData: String; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const strData: AnsiString; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const BoolData: boolean; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const DoubleData: Double; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const ArrWordData: TArrWord; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(const ArrIntData: TArrInt; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var TreeLink: PVirtualNode; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData08; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData16; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData24; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData32; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData40; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData48; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var LogicalData: TLogicalData64; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveData(var stream: TStream; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;

    procedure SaveData(var TreeLink: PVirtualNode; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal; vtrData: TAspRec;
                          Vtr: TVirtualStringTreeAspect = nil; parentNode: PVirtualNode = nil); overload;

    procedure SaveDataTemp(const intData: Integer; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const CardData: Cardinal; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const wordData: word; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const byteData: byte; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const strData: String; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const strData: AnsiString; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const BoolData: boolean; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const DoubleData: Double; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const ArrWordData: TArrWord; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(const ArrIntData: TArrInt; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var TreeLink: PVirtualNode; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData08; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData16; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData24; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData32; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData40; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData48; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var LogicalData: TLogicalData64; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure SaveDataTemp(var stream: TStream; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;

    procedure SaveDataTemp(var TreeLink: PVirtualNode; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal; vtrData: TAspRec;
                          Vtr: TVirtualStringTreeAspect = nil; parentNode: PVirtualNode = nil); overload;


    procedure UpdateData(const intData: Integer; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const CardData: Cardinal; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const wordData: word; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const byteData: byte; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const strData: String; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const BoolData: boolean; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const DoubleData: Double; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const ArrWordData: TArrWord; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const ArrIntData: TArrInt; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;
    procedure UpdateData(const TreeLink: PVirtualNode; parentIsRoot: boolean; isUpdate: boolean; PropPosition: cardinal;
                          var metaPosition, dataPosition: Cardinal); overload;

    procedure SetPosCMDTemp(posCmd: Cardinal); virtual;
  public
    ArrCondition: TArray<TConditionSet>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetPRecord: Pointer; virtual;
    function GetTableName: string; virtual;
    procedure NewPRecord; virtual;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); virtual;
    function GetCollType: TCollectionsType; virtual;
    function Logical32ToStr(log: TLogicalData32): string;
    function Logical24ToStr(log: TLogicalData24): string;
    function Logical40ToStr(log: TLogicalData40): string;
    function Logical48ToStr(log: TLogicalData48): string;
    function Logical16ToStr(log: TLogicalData16): string;
    function Logical08ToStr(log: TLogicalData08): string;
    function StrToLogical32(str: string):  TLogicalData32;
    function StrToLogical24(str: string):  TLogicalData24;
    function StrToLogical16(str: string):  TLogicalData16;
    function StrToLogical08(str: string):  TLogicalData08;
    function StrToLogical40(str: string):  TLogicalData40;
    function StrToLogical48(str: string):  TLogicalData48;
    function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; virtual;
    function IsFinded(PAnsFind: AnsiString; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean; overload; virtual;
    function IsFinded(PBoolFind: Boolean; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean; overload; virtual;
    function IsFinded(PIntFind: integer; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean; overload; virtual;
    function IsFinded(PDateFind: Tdate; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean; overload; virtual;
    function IsFinded(PLog32Find: TLogicalData32; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean; overload; virtual;


    //function PRec: Pointer; virtual;
    procedure AddForLaterSave(streamPos: Cardinal; obj: TObject; v: PVirtualNode);

    function SaveAnyStreamCommand(Props: Pointer; PropsSize: word; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;

    function SaveStreamCommand(Props: TLogicalData08; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommand(Props: TLogicalData16; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommand(Props: TLogicalData24; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommand(Props: TLogicalData32; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommand(Props: TLogicalData40; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommand(Props: TLogicalData48; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommand(Props: TLogicalData128; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;

    function SaveStreamCommandTemp(Props: TLogicalData128; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommandTemp(Props: TLogicalData48; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommandTemp(Props: TLogicalData32; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommandTemp(Props: TLogicalData08; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommandTemp(Props: TLogicalData40; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;
    function SaveStreamCommandTemp(Props: TLogicalData16; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal = 0): TCommandStream; overload;



    procedure AddTagToStream(stream:TStringStream; NameTag, ValueTag :string; amp: Boolean = true);

    property DataPos: Cardinal read FDataPos write FDataPos;
    property Version: Word read FVersion write FVersion;


  end;

  TBaseCollection = class(TCollection)
  private
    FCmdList: TList<TCmdRec>;
    FBuf: Pointer;
    FVtrLinkBuf: Pointer;
    FposData: Cardinal;
    FCntUpdates: Integer;
    FOnCntUpdates: TOnCntUpdates;
    FCntInADB: Integer;
    FTag: NativeInt;
    FoffsetBottom: Integer;
    FlastBottom: Integer;
    FfirstTop: Integer;
    FoffsetTop: Integer;
    //FSortAsc: Boolean;
    FColumnForSort: Integer;
    FOnSortCol: TNotifyEvent;
    FOnKeyUpGridSearch: TKeyEvent;
    FVTR: TBaseVirtualTree;
    ScrollTimer: TTimer;
    FGrid: TTeeGrid;
    ScrollDirection: Integer; // -1 = Up, +1 = Down
    procedure SetCntUpdates(const Value: Integer);
    procedure SetfirstTop(const Value: Integer);
    procedure SetlastBottom(const Value: Integer);
    procedure SetoffsetBottom(const Value: Integer);
    procedure SetoffsetTop(const Value: Integer);
  protected
    FForLaterSave: TList<TForLaterSave>;
    procedure HeaderCanSortBy(const AColumn: TColumn; var CanSort: Boolean);
    procedure HeaderSortBy(Sender: TObject; const AColumn: TColumn);
    procedure HeaderSortState(const AColumn:TColumn; var State:TSortState);
    procedure grdSearchClickedHeader(Sender: TObject);
  public
    streamComm: TCommandStream;
    StreamCommTemp: TCommandStream;
    cmdFile: TFileCMDStream;
    cmdFileTemp: TFileCMDStream;
    ListDataPos: TList<Pvirtualnode>; // за търсене
    ListNodes: TList<PAspRec>;

    ListAnsi: TList<AnsiString>;
    FSortFields: TSortFields;
    ArrayPropOrderSearchOptions: TArray<integer>;
    KeyDict: TDictionary<string,Integer>;


    constructor Create(ItemClass: TCollectionItemClass);virtual;

    destructor Destroy; override;

    class function GetStaticCollType: TCollectionsType; virtual; abstract;
    procedure SortListDataPos;
    procedure SortListNodes;
    function FindRootCollOptionNode(): PVirtualNode; virtual;
    procedure UpdateOrderArrayFromTree(Root: PVirtualNode);
    function getAnsiStringMap(dataPos: cardinal; propIndex: word): AnsiString;
    function getAnsiStringMap4(dataPos: cardinal; propIndex4: word): AnsiString;
    function getPAnsiStringMap(dataPos: cardinal; propIndex: word; var len: word): PAnsiChar;
    function getAnsiStringMapOfset(Ofset: cardinal; propIndex: word): AnsiString;
    function getDateMap(dataPos: cardinal; propIndex: word): Tdate;
    function getTimeMap(dataPos: cardinal; propIndex: word): TTime;
    function getDateMapPos(dataPos: cardinal; propIndex: word): Tdate;
    function getIntMap(dataPos: cardinal; propIndex: word): integer;
    function getWordMap(dataPos: cardinal; propIndex: word): word;
    function getCardMap(dataPos: cardinal; propIndex: word): cardinal;
    function getDoubleMap(dataPos: cardinal; propIndex: word): Double;
    function getLogical40Map(dataPos: cardinal; propIndex: word): TLogicalData40;
    function getLogical48Map(dataPos: cardinal; propIndex: word): TLogicalData48;
    function getLogical32Map(dataPos: cardinal; propIndex: word): TLogicalData32;
    function getLogical16Map(dataPos: cardinal; propIndex: word): TLogicalData16;
    function getLogical08Map(dataPos: cardinal; propIndex: word): TLogicalData08;
    function getLogical24Map(dataPos: cardinal; propIndex: word): TLogicalData24;

    procedure SetIntMap(dataPos: cardinal; propIndex: word; Aint: integer);// специално за неща като ид-та
    procedure SetCardMap(dataPos: cardinal; propIndex: word; ACard: Cardinal);// специално за неща като ид-та
    procedure SetAnsiStringMap(dataPos: cardinal; propIndex: word; AString: AnsiString);// специално за неща като НРН-та стрингове с определена дължина
    procedure SetWordMap(dataPos: cardinal; propIndex: word; AWord: word);// специално за неща като ид-та
    procedure SetLogical16Map(dataPos: cardinal; propIndex: word; ALog16: TLogicalData16);// специално за неща като ид-та
    procedure SetDateMap(dataPos: cardinal; propIndex: word; ADate: TDate);// специално за неща като ид-та
    procedure SetTimeMap(dataPos: cardinal; propIndex: word; ATime: TTime);// специално за неща като ид-та


    function FieldCount: Integer; virtual;
    function DisplayName(propIndex: Word): string; virtual;
    function DisplayLogicalName(flagIndex: Integer): string; virtual;
    function RankSortOption(propIndex: Word): cardinal; virtual;

    function PropType(propIndex: Word): TAspectTypeKind; virtual;
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);virtual;
    procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);virtual;
    function GetCollType: TCollectionsType; virtual;
    function GetCollDelType: TCollectionsType; virtual;
    procedure MarkDelete(FDataPos: cardinal);
    procedure SortListByDataPos(lst: TList<TBaseItem>);
    procedure ShowGrid(Grid: TTeeGrid);virtual;
    procedure IncCntInADB;
    procedure ShowLinksGrid(AGrid: TTeeGrid);virtual;
    procedure OrderFieldsSearch(Grid: TTeeGrid);virtual;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);virtual;
    procedure ShowListNodesGrid (Grid: TTeeGrid);virtual;
    procedure FillListNodes(Link: TMappedFile; vv: TVtrVid);
    procedure FillListLinks(Link: TMappedFile; vv: TVtrVid);
    function GetNodeFromDataPos(Link: TMappedFile; vv: TVtrVid; dataPos: cardinal): PVirtualNode;
    function FindItemFromDataPos(dataPos: cardinal): Integer;
    function GetNodeFromID(linkBuf: pointer; vv: TVtrVid; propIndex: Word; id: integer): PVirtualNode;
    procedure OpenAdbFull(var aspPos: Cardinal);
    function OrderProp(index: Integer): Integer;
    procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);virtual;
    procedure GrdSearhKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdSearhKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure DoCollSort(senedr: TObject);
    procedure SortAnsiListPropIndexCollNew(propIndex: word; SortIsAsc: Boolean);
    procedure SortAnsiPropInterruptible(PropIndex: Word; SortAsc: Boolean; StopFlag: PBoolean);
    procedure SortIntegerPropInterruptible(PropIndex: Word; SortAsc: Boolean; StopFlag: PBoolean);
    procedure SortDatePropInterruptible(PropIndex: Word; SortAsc: Boolean; StopFlag: PBoolean);

    procedure SortMultiColumnsOptimized( FStop: Pboolean);
    function IsCollVisible(PropIndex: Word): Boolean; virtual;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode); virtual;
    procedure ScrollTimerTimer(sender: tobject);
    function GetAllowedOperators(propIndex: Integer): TConditionTypeSet;
    procedure BuildKeyDict(PropIndex: Word); virtual;

    property CmdList: TList<TCmdRec> read FCmdList write FCmdList;
    property ForLaterSave: TList<TForLaterSave> read FForLaterSave write FForLaterSave;
    property Buf: Pointer read FBuf write FBuf;
    property VtrLinkBuf: Pointer read FVtrLinkBuf write FVtrLinkBuf;
    property posData: Cardinal read FposData write FposData;
    property CntUpdates: Integer read FCntUpdates write SetCntUpdates;
    property OnCntUpdates: TOnCntUpdates read FOnCntUpdates write FOnCntUpdates;
    property CntInADB: Integer read FCntInADB write FCntInADB;
    property Tag: NativeInt read FTag write FTag;
    property offsetTop: Integer read FoffsetTop write SetoffsetTop;
    property firstTop: Integer read FfirstTop write SetfirstTop;
    property lastBottom: Integer read FlastBottom write SetlastBottom;
    property offsetBottom: Integer read FoffsetBottom write SetoffsetBottom;
    //property SortAsc: Boolean read FSortAsc write FSortAsc;
    property ColumnForSort: Integer read FColumnForSort write FColumnForSort;

    property OnSortCol: TNotifyEvent read FOnSortCol write FOnSortCol;
    property OnKeyUpGridSearch: TKeyEvent read FOnKeyUpGridSearch write FOnKeyUpGridSearch;
    property VTR: TBaseVirtualTree read FVTR write FVTR;
    property Grid: TTeeGrid read FGrid write FGrid;
  end;

  TBaseCollectionClass = class of TBaseCollection;

  //TRevisionItem = class(TBaseItem)
//  public
//    property Len: word read FLen write SetLen;
//    property Ver: word read FVer write SetVer;
//    property Vid: TCollectionsType read FVid write SetVid;
//    property DataPos: Cardinal read FDataPos write SetDataPos;
//    property Propertys: TLogicalData128 read FPropertys write SetPropertys;
//    property OpType: TOperationType read FOpType write SetOpType;
//  end;


implementation
uses
   System.AnsiStrings, uGridHelpers;

procedure TBaseItem.AddForLaterSave(streamPos: Cardinal; obj: TObject; v: PVirtualNode);
var
  forLater: TForLaterSave;
begin
  forLater.posStream := streamPos;
  forLater.TreeLink := obj;
  forLater.vTreeLink := v;
  TBaseCollection(Collection).FForLaterSave.Add(forLater);
end;

procedure TBaseItem.AddTagToStream(stream:TStringStream; NameTag, ValueTag: string; amp: Boolean);
var
  ABuf, val: String;
begin
  val := ValueTag;
  if Val = '' then
    ABuf := '<'+(NameTag)+'>' + #13#10
  else
  begin
    if amp then
    begin
      Val:= Val.Replace('&', '&amp;', [rfReplaceAll]);
      Val := Val.Replace('<', '&lt;', [rfReplaceAll]);
      Val := Val.Replace('>', '&gt;', [rfReplaceAll]);
      Val := Val.Replace(#8, ' ', [rfReplaceAll]);
      Val := Val.Replace(#9, ' ', [rfReplaceAll]);
      Val := Val.Replace(#13#10, '&#xA;', [rfReplaceAll]);
      Val := Val.Replace(#10, '&#xA;', [rfReplaceAll]);
      //Val := Val.Replace('"', '&quot;', [rfReplaceAll]);

    end;
    ABuf :=  ('<'+(NameTag)+' '+(Val)+' />' + #13#10);
  end;
  Stream.WriteString(ABuf);
end;

function TBaseItem.buf: Pointer;
begin
  Result := TBaseCollection(Collection).FBuf;
end;

constructor TBaseItem.Create(Collection: TCollection);
begin
  inherited;
  FDataPos := 0;
  FVersion := 0;
  //if Assigned(self.Collection) then
//  begin
//    SetLength(ArrCondition, TBaseCollection(self.Collection).FieldCount);
//  end;
end;

destructor TBaseItem.Destroy;
begin
  
  inherited;
end;

procedure TBaseItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
begin

end;

//function TBaseItem.getAnsiString(propIndex: word): AnsiString;
//var
//  P: ^Integer;
//  PLen: ^Word;
//  pData: PAnsiChar;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + (FDataPos  + 4*propIndex));
//  if p^ = 0 then
//  begin
//    Result := '';
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  PLen := pointer(PByte(Stream.Memory) + ofset);
//  pData := pointer(PByte(Stream.Memory) + ofset + 2);
//  SetLength(Result, PLen^);
//  Result := PAnsiChar(pData);
//end;

function TBaseItem.getAnsiStringMap(buf: pointer; posData: cardinal;
  propIndex: word): AnsiString;
var
  P: ^Cardinal;
  PLen: ^Word;
  pData: PAnsiChar;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (FDataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := '';
    Exit;
  end;
  ofset := p^ + PosData;
  PLen := pointer(PByte(buf) + ofset);
  pData := pointer(PByte(buf) + ofset + 2);
  SetLength(Result, PLen^);
  Result := PAnsiChar(pData);
end;

//function TBaseItem.getBoolean(propIndex: word): boolean;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^Boolean;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset);
//  Result := pData^;
//end;

function TBaseItem.getBlobMap(buf: pointer; posData: cardinal; propIndex: word): TStream;
var
  P: ^Cardinal;
  PLen: ^Word;
  pData: PAnsiChar;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (FDataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  PLen := pointer(PByte(buf) + ofset);
  pData := pointer(PByte(buf) + ofset + 2);
  Result := TMemoryStream.Create;
  Result.Size := PLen^;
  Result.ReadData(pData, Result.Size);
end;

function TBaseItem.getBooleanMap(buf: pointer; posData: cardinal;
  propIndex: word): boolean;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Boolean;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

//function TBaseItem.getByte(propIndex: word): Byte;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^Byte;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset);
//  Result := pData^;
//end;

function TBaseItem.getByteMap(buf: pointer; posData: cardinal;
  propIndex: word): Byte;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Byte;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getCardMap(buf: pointer; posData: cardinal; propIndex: word): Cardinal;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

//function TBaseItem.getDate(propIndex: word): TDate;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^TDate;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex); //
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset); //
//  Result := pData^;
//end;

function TBaseItem.getDateMap(buf: pointer; posData: cardinal;
  propIndex: word): TDate;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TDate;
begin
 // p := pointer(PByte(buf) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := 0;
//    Exit;
//  end;
//  ofset := p^ + PosData;
//  pData := pointer(PByte(buf) + ofset);
//  Result := pData^;


  p := pointer(PByte(buf) + FDataPos + 4*propIndex); //
  if p^ = 0 then
  begin
    Result := MinDateTime;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset); //
  Result := pData^;
end;

//function TBaseItem.getDouble(propIndex: word): Double;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^Double;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex); //
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset); //
//  Result := pData^;
//end;

function TBaseItem.getDoubleMap(buf: pointer; posData: cardinal;
  propIndex: word): Double;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Double;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex); //
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset); //
  Result := pData^;
end;

//function TBaseItem.getInt(propIndex: word): integer;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^Integer;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := 0;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset);
//  Result := pData^;
//end;

function TBaseItem.getIntMap(buf: pointer; posData: cardinal; propIndex: word): integer;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Integer;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getLogical08Map(buf: pointer; posData: cardinal;
  propIndex: word): TLogicalData08;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData08;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getLogical16Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData16;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData16;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getLogical24Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData24;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData24;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getLogical32Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData32;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData32;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getLogical40Map(buf: pointer; posData: cardinal; propIndex: word): TLogicalData40;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData40;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.getLogical48Map(buf: pointer; posData: cardinal;
  propIndex: word): TLogicalData48;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData48;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

//function TBaseItem.getPAnsiString(propIndex: word; var len: word): PAnsiChar;
//var
//  P: ^Cardinal;
//  l: ^Word;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + (FDataPos  + 4*propIndex));
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  l := pointer(PByte(Stream.Memory) + ofset);
//  len := l^;
//  Result := pointer(PByte(Stream.Memory) + ofset + 2);
//end;

function TBaseItem.getPAnsiStringMap(buf: pointer; posData: cardinal;
  propIndex: word; var len: word): PAnsiChar;
var
  P: ^Cardinal;
  l: ^Word;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (FDataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  l := pointer(PByte(buf) + ofset);
  len := l^;
  Result := pointer(PByte(l)+ 2);// pointer(PByte(buf) + ofset + 2);
end;



//function TBaseItem.getPBoolean(propIndex: word): PBoolean;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPBlobMap(buf: pointer; posData: cardinal; propIndex: word): Pointer;
var
  P: ^Cardinal;
  l: ^Word;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (FDataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  l := pointer(PByte(buf) + ofset);
  Result := pointer(PByte(l)+ 2);
end;

function TBaseItem.getPBooleanMap(buf: pointer; posData: cardinal;
  propIndex: word): PBoolean;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

//function TBaseItem.getPByte(propIndex: word): PByte;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPByteMap(buf: pointer; posData: cardinal;
  propIndex: word): PByte;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

function TBaseItem.getPCardMap(buf: pointer; posData: cardinal; propIndex: word): PCardinal;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

//function TBaseItem.getPDate(propIndex: word): PDate;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPDateMap(buf: pointer; posData: cardinal;
  propIndex: word): PDate;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

//function TBaseItem.getPDouble(propIndex: word): PDouble;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPDoubleMap(buf: pointer; posData: cardinal;
  propIndex: word): PDouble;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

//function TBaseItem.getPInt(propIndex: word): PInt;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPIntMap(buf: pointer; posData: cardinal; propIndex: word): PInt;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

function TBaseItem.getPLogical08Map(buf: pointer; posData: cardinal;
  propIndex: word): PLogicalData08;
begin

end;

function TBaseItem.getPLogical16Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData16;
begin

end;

function TBaseItem.getPLogical24Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData24;
begin

end;

function TBaseItem.getPLogical32Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData32;
begin

end;

function TBaseItem.getPLogical40Map(buf: pointer; posData: cardinal; propIndex: word): PLogicalData40;
begin

end;

function TBaseItem.getPLogical48Map(buf: pointer; posData: cardinal;
  propIndex: word): PLogicalData48;
begin

end;

function TBaseItem.GetPRecord: Pointer;
begin

end;

//function TBaseItem.getPString(propIndex: word; var len: word): PChar;
//var
//  P: ^Cardinal;
//  l: ^Word;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + (FDataPos  + 4*propIndex));
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  l := pointer(PByte(Stream.Memory) + ofset);
//  len := l^;
//  Result := pointer(PByte(Stream.Memory) + ofset + 2);
//end;

//function TBaseItem.getPTime(propIndex: word): PTime;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPTimeMap(buf: pointer; posData: cardinal;
  propIndex: word): PDateTime;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

//function TBaseItem.getPVirtualNode(propIndex: word): PVirtualNode;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + (FDataPos  + 4*propIndex));
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  ofset := ofset + (ofset mod 2);
//
//  //showMessage(inttostr(stream.posData));
//  Result := pointer(PByte(Stream.Memory) + ofset);
//  //if Integer(Result) then
//
//end;

//function TBaseItem.getPWord(propIndex: word): PWord;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := nil;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  Result := pointer(PByte(Stream.Memory) + ofset);
//end;

function TBaseItem.getPWordMap(buf: pointer; posData: cardinal;
  propIndex: word): PWord;
var
  P: ^Cardinal;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  Result := pointer(PByte(buf) + ofset);
end;

function TBaseItem.getStringMap(buf: pointer; posData: cardinal; propIndex: word): PChar;
var
  P: ^Cardinal;
  PLen: ^Word;
  pData: Pointer;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (FDataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := '';
    Exit;
  end;
  ofset := p^ + PosData;
  PLen := pointer(PByte(buf) + ofset);
  Result := PChar(pointer(PByte(buf) + ofset + 2));
end;

function TBaseItem.GetTableName: string;
begin

end;

function TBaseItem.GetCollType: TCollectionsType;
begin

end;

//function TBaseItem.getString(propIndex: word): string;
//var
//  P: ^Integer;
//  PLen: ^Word;
//  pData: Pchar;
//  ofset: Cardinal;
//begin
//  p := pointer(PByte(Stream.Memory) + (FDataPos  + 4*propIndex));
//  if p^ = 0 then
//  begin
//    Result := '';
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  PLen := pointer(PByte(Stream.Memory) + ofset);
//  pData := pointer(PByte(Stream.Memory) + ofset + 2);
//  SetLength(Result, PLen^);
//  Result := PChar(pData);
//end;

//function TBaseItem.getTime(propIndex: word): TTime;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^TTime;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex); //
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset); //
//  Result := pData^;
//end;

function TBaseItem.getTimeMap(buf: pointer; posData: cardinal;
  propIndex: word): TTime;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TTime;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex); //
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset); //
  Result := pData^;
end;

//function TBaseItem.getWord(propIndex: word): Word;
//var
//  P: ^Integer;
//  ofset: Cardinal;
//  pData: ^Word;
//begin
//  p := pointer(PByte(Stream.Memory) + FDataPos + 4*propIndex);
//  if p^ = 0 then
//  begin
//    Result := 0;
//    Exit;
//  end;
//  ofset := p^ + stream.PosData;
//  pData := pointer(PByte(Stream.Memory) + ofset);
//  Result := pData^;
//end;

function TBaseItem.getWordMap(buf: pointer; posData: cardinal;
  propIndex: word): Word;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Word;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseItem.IsFinded(PAnsFind: AnsiString; buf: Pointer; FPosDataADB: Cardinal;
    FieldForFind: word; cot: TConditionSet): Boolean;
var
  PAnsBuf, pAnsBupTemp: PAnsiChar;
  len: Word;
  str: AnsiString;
  cotIdx: TConditionType;
  ACot: TConditionSet;
begin
  ACot := cot;

  if cotSens in cot then
  begin
    str := getAnsiStringMap(Buf, FPosDataADB, FieldForFind);
    Exclude(ACot, cotSens);
  end
  else
  begin
    str := AnsiUpperCase(getAnsiStringMap(Buf, FPosDataADB, FieldForFind));
  end;
  //Result := False;


  for cotIdx in cot do
  begin
    case  cotIdx of
      cotContain:
      begin
        if Pos(PAnsFind, str) > 0 then
           Exclude(ACot, cotContain);
      end;
      cotNotContain:
      begin
        if Pos(PAnsFind, str) = 0 then
          Exclude(ACot, cotNotContain);
      end;
      cotStarting:
      begin
        if Pos(PAnsFind, str) = 1 then
          Exclude(ACot, cotStarting);
      end;
      cotEnding:
      begin
        if string(str).EndsWith(PAnsFind) then
          Exclude(ACot, cotEnding);
      end;
      cotEqual:
      begin
        if str =  PAnsFind then
          Exclude(ACot, cotEqual);
      end;
      cotSmaller:
      begin
        if str <  PAnsFind then
          Exclude(ACot, cotSmaller);
      end;
      cotBigger:
      begin
        if str >  PAnsFind then
          Exclude(ACot, cotBigger);
      end;
    end;
  end;
  Result := ACot = [];
end;

function TBaseItem.IsFinded(PIntFind: Integer; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean;
var
  PIntBuf: PINT;
begin
  PIntBuf := getPIntMap(Buf, FPosDataADB, FieldForFind);
  Result := PIntFind = PIntBuf^;
end;

function TBaseItem.IsFinded(PDateFind: Tdate; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean;
var
  PDateBuf: PDate;
begin
  PDateBuf := getPDateMap(Buf, FPosDataADB, FieldForFind);
  Result := PDateFind = PDateBuf^;
end;

function TBaseItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
begin

end;

function TBaseItem.Logical08ToStr(log: TLogicalData08): string;
var
  i: Integer;
begin
  SetLength(Result, 8);
  for i := 1 to 8 do
  begin
    if TLog08(i - 1) in log then
      Result[i] := '1'
    else
      Result[i] := '0';
  end;
end;

function TBaseItem.Logical16ToStr(log: TLogicalData16): string;
var
  i: Integer;
begin
  SetLength(Result, 16);
  for i := 1 to 16 do
  begin
    if TLog16(i - 1) in log then
      Result[i] := '1'
    else
      Result[i] := '0';
  end;
end;

function TBaseItem.Logical24ToStr(log: TLogicalData24): string;
var
  i: Integer;
begin
  SetLength(Result, 24);
  for i := 1 to 24 do
  begin
    if TLog24(i - 1) in log then
      Result[i] := '1'
    else
      Result[i] := '0';
  end;
end;

function TBaseItem.Logical32ToStr(log: TLogicalData32): string;
var
  i: Integer;
begin
  SetLength(Result, 32);
  for i := 1 to 32 do
  begin
    if TLog32(i - 1) in log then
      Result[i] := '1'
    else
      Result[i] := '0';
  end;
end;

function TBaseItem.Logical40ToStr(log: TLogicalData40): string;
var
  i: Integer;
begin
  SetLength(Result, 40);
  for i := 1 to 40 do
  begin
    if TLog40(i - 1) in log then
      Result[i] := '1'
    else
      Result[i] := '0';
  end;
end;

function TBaseItem.Logical48ToStr(log: TLogicalData48): string;
var
  i: Integer;
begin
  SetLength(Result, 48);
  for i := 1 to 48 do
  begin
    if TLog40(i - 1) in log then
      Result[i] := '1'
    else
      Result[i] := '0';
  end;
end;

procedure TBaseItem.NewPRecord;
begin
//
end;

//function TBaseItem.PRec: Pointer;
//begin
//
//end;

procedure TBaseItem.SaveData(const BoolData: boolean;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos, datPos: cardinal;
  pCardinalData: ^Cardinal;
  pBoolData: ^Boolean;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pBoolData := pointer(PByte(buf) + ADataPos + DatPos);
  pBoolData^  := BoolData;
  //увеличавам dataPosition с 4 + 2 ; 2 за самата данна и 4 байта за историята.
  Inc(dataPosition, 6);
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  TBaseCollection(Collection).streamComm.Write(BoolData, 2);
end;

procedure TBaseItem.SaveData(const byteData: Byte; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
var
  ADataPos, datPos: cardinal;
  pCardinalData: ^Cardinal;
  pByteData: ^Byte;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pByteData := pointer(PByte(buf) + ADataPos + DatPos);
  pByteData^  := byteData;
  //увеличавам dataPosition с 4 + 2 ; 2 за самата данна и 4 байта за историята.
  Inc(dataPosition, 6);
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  TBaseCollection(Collection).streamComm.Write(byteData, 2);
end;

procedure TBaseItem.SaveData(const DoubleData:Double;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos, datPos: cardinal;
  pCardinalData: ^Cardinal;
  pDateData: ^Double;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pDateData := pointer(PByte(buf) + ADataPos + DatPos);
  pDateData^  := DoubleData;
  //увеличавам dataPosition с 4 + 8 ; 8 за самата данна и 4 байта за историята.
  Inc(dataPosition, 12);
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  TBaseCollection(Collection).streamComm.Write(DoubleData, 8);
end;

procedure TBaseItem.SaveHeaderData(var PropPosition, dataPosition: Cardinal);
var
  ADataPos, FPosData, FPosMetaData: cardinal;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  FPosData := pCardinalData^; // от къде започват данните
  pCardinalData := pointer(PByte(buf));
  FPosMetaData := pCardinalData^; // от къде започват мета-данните

  PropPosition := dataPosition - FPosData + 4; // тука ще върна адреса в мап-а
  ADataPos := FDataPos + FPosData + 4;


  pCardinalData := pointer(PByte(buf) + dataPosition);
  pCardinalData^  := ADataPos;
  inc(dataPosition, 4);
end;

procedure TBaseItem.SaveData(const intData: Integer; PropPosition: cardinal ; var metaPosition,
  dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  DatPos: Cardinal;
  streamComm: TCommandStream;
begin
  //pCardinalData := pointer(PByte(buf) + 0);

  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pCardinalData := pointer(PByte(buf) + ADataPos + datPos);
  pCardinalData^  := intData;
  //увеличавам dataPosition с 4 + 4 ; 4 за самата данна и 4 байта за историята.
  Inc(dataPosition, 8);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  TBaseCollection(Collection).streamComm.Write(IntData, 4);
end;

procedure TBaseItem.SaveNull(var metaPosition: cardinal);
var
  ADataPos, FPosData, FPosMetaData: cardinal;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := 0;
  inc(metaPosition, 4);


//  stream.Position := metaPosition;
//  stream.Write(Fnull, 4);
//  stream.FFileStream.Position := metaPosition;
//  stream.FFileStream.Write(Fnull, 4);
//  metaPosition := stream.Position;
end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData32; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 4;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

//function TBaseItem.SaveStreamCommand(Props: TLogicalData40; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
//begin
//  result := TBaseCollection(Collection).streamComm;
//  result.OpType := OpType;
//  result.Size := 10 + 5;
//  Result.Ver := ver;
//  Result.Vid := vid;
//  Result.DataPos := AdataPos;
//  Result.Propertys := props;
//end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData48; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 6;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData128; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 16;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData24;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 4;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.StrToLogical08(str: string): TLogicalData08;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to 7 do
  begin
    if str[i + 1] = '1' then
      Include(Result, TLog08(i));
  end;
end;

function TBaseItem.StrToLogical16(str: string): TLogicalData16;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to 15 do
  begin
    if str[i + 1] = '1' then
      Include(Result, TLog16(i));
  end;
end;

function TBaseItem.StrToLogical24(str: string): TLogicalData24;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to 23 do
  begin
    if str[i + 1] = '1' then
      Include(Result, TLog24(i));
  end;
end;

function TBaseItem.StrToLogical32(str: string): TLogicalData32;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to 31 do
  begin
    if str[i + 1] = '1' then
      Include(Result, TLog32(i));
  end;
end;

function TBaseItem.StrToLogical40(str: string): TLogicalData40;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to 39 do
  begin
    if str[i + 1] = '1' then
      Include(Result, TLog40(i));
  end;
end;

function TBaseItem.StrToLogical48(str: string): TLogicalData48;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to 47 do
  begin
    if str[i + 1] = '1' then
      Include(Result, TLog48(i));
  end;
end;

procedure TBaseItem.SaveData(const strData: String;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  Len: Word;
  ADataPos, datPos: cardinal;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
  pStr: Pointer;
  streamComm: TCommandStream;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  len :=  Length(strData) ;
  //намирам адреса на който ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам дължината на стринга на адреса
  pWordData := pointer(PByte(buf) + ADataPos + DatPos);
  pWordData^  := Len;

  //записвам самата данна на адреса
  pStr := pointer(PByte(buf) + ADataPos + DatPos + 2);
  //pStr  := @strData;
  StrCopy(pStr, PChar(strData));
  //увеличавам dataPosition със 2+ 4 + len*SizeOf(char) ; 2 за дължината на стринга; колкото толкова за стринга; и 4 байта за историята.
  Inc(dataPosition, 6 + len*SizeOf(char));
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  pWordData := pointer(PByte(buf) + dataPosition); // записвам 00 за край
  pWordData^  := 0;
  Inc(dataPosition, 2);

  streamComm := TBaseCollection(Collection).streamComm;
  streamComm.Write(len, 2);
  streamComm.Write(strData[1], len);
end;

procedure TBaseItem.SaveData(const strData: AnsiString;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  Len: Word;
  ADataPos, datPos: cardinal;
  pCardinalData, pCardinalHistData: ^Cardinal;
  pWordData: ^Word;
  pbyteData: ^Byte;
  pStr: Pointer;
  streamComm: TCommandStream;
begin

  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  len :=  Length(strData) ;
  //намирам адреса на който ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition); // тука е адреса на старата сойност
  //записвам историята
  pCardinalHistData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalHistData^  := (pCardinalData^); // при инсъртване понеже е първо e  нула
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам дължината на стринга на адреса
  pWordData := pointer(PByte(buf) + ADataPos + DatPos);
  pWordData^  := Len;

  //записвам самата данна на адреса
  pStr := pointer(PByte(buf) + ADataPos + DatPos + 2);
  //pStr  := @strData;
  System.SysUtils.StrCopy(pStr, PAnsiChar(strData));
  //увеличавам dataPosition със 2+ 4 + len*SizeOf(char) ; 2 за дължината на стринга; колкото толкова за стринга; и 4 байта за историята.
  Inc(dataPosition, 6 + len*SizeOf(AnsiChar));


  if (dataPosition mod 2) = 0 then
  begin
    pWordData := pointer(PByte(buf) + dataPosition); // записвам 00 за край
    pWordData^  := 0;
    Inc(dataPosition, 2);
  end
  else
  begin
    pWordData := pointer(PByte(buf) + dataPosition); // записвам 0 за край
    pWordData^  := 0;
    Inc(dataPosition, 1); //само единия байт, за да е четен адреса
  end;

  streamComm := TBaseCollection(Collection).streamComm;
  streamComm.Write(len, 2);
  streamComm.Write(strData[1], len);
end;

procedure TBaseItem.SaveData(const wordData: word; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
  DatPos: Cardinal;
begin
  //pCardinalData := pointer(PByte(buf) + 0);

  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pWordData := pointer(PByte(buf) + ADataPos + datPos);
  pWordData^  := wordData;
  //увеличавам dataPosition с 2 + 4 ; 2 за самата данна и 4 байта за историята.
  Inc(dataPosition, 6);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  TBaseCollection(Collection).streamComm.Write(worddata, 2);
end;


procedure TBaseItem.UpdateData(const byteData: byte; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin
  //stream.FFileStream.Position := stream.Position;
//  stream.Write(byteData, 1);
//  stream.FFileStream.Write(byteData, 1);
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 5;
end;

procedure TBaseItem.UpdateData(const wordData: word; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin
  //stream.FFileStream.Position := stream.Position;
//  stream.Write(wordData, 2);
//  stream.FFileStream.Write(wordData, 2);
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 6;
end;

procedure TBaseItem.UpdateData(const intData: Integer; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
begin
  //stream.FFileStream.Position := stream.Position;
//  stream.Write(intData, 4);
//  stream.FFileStream.Write(intData, 4);
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 8;
end;

procedure TBaseItem.UpdateData(const DoubleData: Double; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
begin
  //stream.FFileStream.Position := stream.Position;
//  stream.Write(DoubleData, SizeOf(DoubleData));
//  stream.FFileStream.Write(DoubleData, SizeOf(DoubleData));
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 4 + SizeOf(DoubleData);
end;


procedure TBaseItem.UpdateHeaderData(var PropPosition: cardinal; const dataPosition: Cardinal);
//var
  //strm: TAspectStream;
begin
  //strm := stream;
//  //strm.Position := dataPosition;
//  PropPosition := FDataPos - strm.PosData - Integer(strm.Memory) + 4;
//  //strm.Write(FDataPos, 4);
end;

function TBaseItem.ValueToString(propIndex: word; valTreeLink: PVirtualNode): string;
begin
  //valTreeLink := getPVirtualNode(propIndex);
//  if valTreeLink = nil  then
//    Result := 'nil'
//  else
//    Result := inttostr(Integer(valTreeLink.Parent));
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valDate: PDate): string;
begin
  try
    valDate := getPDateMap(buf, posData, propIndex);
    if valDate = nil  then
      Result := 'nil'
    else
      Result := DateToStr(valDate^);
  except
    Result := 'err';
  end;
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valTime: PDateTime): string;
begin
  try
    valTime := getPTimeMap(buf, posData, propIndex);
    if valTime = nil  then
      Result := 'nil'
    else
      Result := TimeToStr(valTime^);
  except
    Result := 'err';
  end;
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valString: PAnsiChar; len: Word): string;
begin
  valString := getPAnsiStringMap(buf, posData, propIndex, len);
  if valString = nil  then
    Result := 'nil'
  else
  begin
    Result := AnsiString(valString);
    SetLength(Result, len);
  end;
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;propIndex: word; valInt: PInt): string;
begin
  valInt := getPIntMap(buf, posData, propIndex);
  if valInt = nil  then
    Result := 'nil'
  else
    Result := inttostr(valInt^);
end;

function TBaseItem.ValueToString(propIndex: word; valByte: PByte): string;
begin
  //valByte := getPByte(propIndex);
//  if valByte = nil  then
//    Result := 'nil'
//  else
//    Result := inttostr(valByte^);
end;

function TBaseItem.ValueToString(propIndex: Word; valWord: Pword): string;
begin
  //valWord := getPWord(propIndex);
//  if valWord = nil  then
//    Result := 'nil'
//  else
//    Result := inttostr(valWord^);
end;

function TBaseItem.ValueToString(propIndex: word; valInt: PInt): string;
begin
  //valInt := getPInt(propIndex);
//  if valInt = nil  then
//    Result := 'nil'
//  else
//    Result := inttostr(valInt^);
end;

function TBaseItem.ValueToString(propIndex: word; valDouble: PDouble): string;
begin
  //try
//    valDouble := getPDouble(propIndex);
//    if valDouble = nil  then
//      Result := 'nil'
//    else
//      Result := FloatToStr(valDouble^);
//  except
//    Result := 'err';
//  end;
end;

function TBaseItem.ValueToString(propIndex: word; valBoolean: PBoolean): string;
begin
  //valBoolean := getPBoolean(propIndex);
//  if valBoolean = nil  then
//    Result := 'nil'
//  else
//    Result := BoolToStr(valBoolean^, true);
end;

function TBaseItem.ValueToString(propIndex: word; valString: PChar; Len: word): string;
begin
  //valString := getPString(propIndex, len);
//  if valString = nil  then
//    Result := 'nil'
//  else
//  begin
//    Result := string(valString);
//    SetLength(Result, len);
//  end;
end;

function TBaseItem.ValueToString(propIndex: word; valString: PAnsiChar; Len: word): string;
begin
  //valString := getPAnsiString(propIndex, len);
//  if valString = nil  then
//    Result := 'nil'
//  else
//  begin
//    Result := AnsiString(valString);
//    SetLength(Result, len);
//  end;
end;

procedure TBaseItem.UpdateData(const BoolData: boolean; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
var
  Len: Word;
  b: Byte;
begin
  //stream.FFileStream.Position := stream.Position;
//  stream.Write(BoolData, SizeOf(BoolData));
//  stream.FFileStream.Write(BoolData, SizeOf(BoolData));
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 5;
end;

procedure TBaseItem.UpdateData(const strData: String; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
var
  Len: Word;
  b: Byte;
begin
  //len :=  Length(strData) ;
//  stream.FFileStream.Position := stream.Position;
//  stream.Write(len, 2);
//  stream.Write(strData[1], len * SizeOf(char) + 2);
//  stream.FFileStream.Write(len, 2);
//  stream.FFileStream.Write(strData[1], len * SizeOf(char) + 2);
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 6 + (len * 2) + 2;
end;

procedure TBaseItem.SaveData(const ArrWordData: TArrWord; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveData(const ArrIntData: TArrInt; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
var
  Len: Word;
  ADataPos, datPos: cardinal;
  pCardinalData, pCardinalHistData: ^Cardinal;
  pWordData: ^Word;
  pbyteData: ^Byte;
  pArr: Pointer;
  streamComm: TCommandStream;
begin

  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  len :=  Length(ArrIntData) ;
  //намирам адреса на който ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition); // тука е адреса на старата сойност
  //записвам историята
  pCardinalHistData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalHistData^  := (pCardinalData^); // при инсъртване понеже е първо e  нула
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам дължината на масива на адреса
  pWordData := pointer(PByte(buf) + ADataPos + DatPos);
  pWordData^  := Len;

  //записвам самата данна на адреса
  pArr := pointer(PByte(buf) + ADataPos + DatPos + 2);
  MoveMemory(pArr, @ArrIntData[0], len * 4);
  //System.SysUtils.arr(pArr, PAnsiChar(strData));
  //увеличавам dataPosition със 2+ 4 + len*SizeOf(char) ; 2 за дължината на стринга; колкото толкова за стринга; и 4 байта за историята.
  Inc(dataPosition, 6 + len*4);


  //if (dataPosition mod 2) = 0 then
//  begin
//    pWordData := pointer(PByte(buf) + dataPosition); // записвам 00 за край
//    pWordData^  := 0;
//    Inc(dataPosition, 2);
//  end
//  else
//  begin
//    pWordData := pointer(PByte(buf) + dataPosition); // записвам 0 за край
//    pWordData^  := 0;
//    Inc(dataPosition, 1); //само единия байт, за да е четен адреса
//  end;

  streamComm := TBaseCollection(Collection).streamComm;
  streamComm.Write(len, 2);
  streamComm.Write(ArrIntData[0], len * 4);
end;

procedure TBaseItem.SaveData(const CardData: Cardinal; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  DatPos: Cardinal;
begin
  //pCardinalData := pointer(PByte(buf) + 0);

  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pCardinalData := pointer(PByte(buf) + ADataPos + datPos);
  pCardinalData^  := CardData;
  //увеличавам dataPosition с 4 + 4 ; 4 за самата данна и 4 байта за историята.
  Inc(dataPosition, 8);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  TBaseCollection(Collection).streamComm.Write(CardData, 4);
end;

procedure TBaseItem.UpdateData(const ArrWordData: TArrWord; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
begin

end;

procedure TBaseItem.UpdateData(const ArrIntData: TArrInt; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
begin

end;

procedure TBaseItem.UpdateData(const CardData: Cardinal; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
begin
  //stream.FFileStream.Position := stream.Position;
//  stream.Write(CardData, 4);
//  stream.FFileStream.Write(CardData, 4);
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  //stream.FFileStream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  //stream.FFileStream.Write(PropPosition, 4);
//  metaPosition := stream.Position;
//  stream.LenData := stream.LenData + 8;
end;

function TBaseItem.SaveAnyStreamCommand(Props: Pointer; PropsSize: word; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  case PropsSize of
    1: SaveStreamCommand(TLogicalData08(Props^), vid, OpType, ver, AdataPos);
    2: SaveStreamCommand(TLogicalData16(Props^), vid, OpType, ver, AdataPos);
    3: SaveStreamCommand(TLogicalData24(Props^), vid, OpType, ver, AdataPos);
    4: SaveStreamCommand(TLogicalData32(Props^), vid, OpType, ver, AdataPos);
    5: SaveStreamCommand(TLogicalData40(Props^), vid, OpType, ver, AdataPos);
    6: SaveStreamCommand(TLogicalData48(Props^), vid, OpType, ver, AdataPos);
  end;
end;

procedure TBaseItem.SaveData(var TreeLink: PVirtualNode; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal; vtrData: TAspRec;
  Vtr: TVirtualStringTreeAspect = nil; parentNode: PVirtualNode = nil);
var
  Mode: TVTNodeAttachMode;
  posTreeLinkParent, posTreeLinkData: cardinal;
  test: Cardinal;
  b: Byte;
  cmd: TCommandsFill;
begin
  b:= 0;
 // stream.Write(b, 1);
  //TreeLink := pointer(PByte(Stream.Memory) + stream.Position);//zzzz
  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27; //zzzzzz
  TreeLink.NodeHeight := 27;//zzzz
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.SetData(vtrData);
  if Assigned(Vtr) then
  begin
     Mode := TVTNodeAttachMode.amAddChildFirst;
  if not Assigned(parentNode) then
    vtr.InternalConnectNode_cmd(TreeLink, vtr.RootNode, vtr, Mode)
  else
    vtr.InternalConnectNode_cmd(TreeLink, parentNode, vtr, Mode);
  end;
  //stream.FFileStream.Position := dataPosition + 4;
//  stream.FFileStream.Write(b, 1);
//  stream.FFileStream.Write(TreeLink^, 60);
  //stream.AddCmd(10, 61, dataPosition + 4, Pointer(PByte(stream.Memory) + dataPosition + 4));

  if Assigned(Vtr) then
  begin
    if TreeLink.Parent = Vtr.NodeRoot then
    begin
      //posTreeLinkParent := Integer(@TreeLink.Parent) - Integer(Stream.Memory);
      //stream.FFileStream.Position := posTreeLinkParent;
      //stream.AddCmd(1, 20, posTreeLinkParent, nil);

      test := 0;
      //stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
    end
    else
    begin
      //posTreeLinkParent := Integer(@TreeLink.Parent) - Integer(Stream.Memory);
      //stream.FFileStream.Position := posTreeLinkParent;
      //test := Integer(TreeLink.Parent) - Integer(Stream.Memory);

      //stream.FFileStream.Write(test, 4);
      //stream.AddCmd(0, 4, posTreeLinkParent, @test);
      //stream.AddCmd(1, 16, posTreeLinkParent + 4, nil);
      test := 0;
      //stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
//      stream.FFileStream.Write(test, 4);
    end;
  end;
  dataPosition := dataPosition + 4 + 1 + 52;//zzzzz
  //stream.Position := metaPosition;
  //stream.Write(PropPosition, 4);
  //stream.FFileStream.Position := metaPosition;
//  stream.FFileStream.Write(PropPosition, 4);
  //stream.AddCmd(0, 4, metaPosition, @PropPosition);
  //metaPosition := stream.Position;
  //stream.LenData := stream.LenData + 4 + 1 + 52;
end;



procedure TBaseItem.SaveDataTemp(const BoolData: boolean;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(const strData: AnsiString;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(const DoubleData: Double;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(const ArrIntData: TArrInt;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(const ArrWordData: TArrWord;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(const CardData: Cardinal;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(const intData: Integer; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
begin
  SetPosCMDTemp(TBaseCollection(Collection).StreamCommTemp.Position);
  TBaseCollection(Collection).StreamCommTemp.Write(IntData, 4);
end;

procedure TBaseItem.SaveDataTemp(const wordData: word; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
begin
  TBaseCollection(Collection).StreamCommTemp.Write(wordData, 2);
end;

procedure TBaseItem.SaveDataTemp(const strData: String; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
var
  len: Word;
begin
  len := Length(strData);
  TBaseCollection(Collection).StreamCommTemp.Write(len, 2);
  TBaseCollection(Collection).StreamCommTemp.Write(strData[1], len);
end;

procedure TBaseItem.SaveDataTemp(const byteData: byte; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData48;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData40;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData64;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var TreeLink: PVirtualNode;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal;
  vtrData: TAspRec; Vtr: TVirtualStringTreeAspect; parentNode: PVirtualNode);
begin

end;

procedure TBaseItem.SaveDataTemp(var stream: TStream; PropPosition: cardinal;
  var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData08;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var TreeLink: PVirtualNode;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData16;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData32;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveDataTemp(var LogicalData: TLogicalData24;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
begin

end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData24;
  PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical24Data: ^TLogicalData24;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на който ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical24Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical24Data^  := LogicalData;
  //увеличавам dataPosition с 4 + 4 ; 4 за самата данна и 4 байта за историята.
  Inc(dataPosition, 8);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 4);
end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData40; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical40Data: ^TLogicalData40;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical40Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical40Data^  := LogicalData;
  //увеличавам dataPosition с 6 + 4 ; 6 за самата данна и 4 байта за историята.
  Inc(dataPosition, 10);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 5);
end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData08; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical16Data: ^TLogicalData16;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical16Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical16Data^  := LogicalData;
  //увеличавам dataPosition с 2 + 4 ; 2 за самата данна и 4 байта за историята.
  Inc(dataPosition, 6);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 1);
end;

procedure TBaseItem.SaveData(var stream: TStream; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  Len: Word;
  ADataPos, datPos: cardinal;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
  pStr: Pointer;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  len :=  stream.size ;
  //намирам адреса на който ще бъдат поставени данните
  ADataPos := dataPosition + 4 - datPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам дължината на потока на адреса
  pWordData := pointer(PByte(buf) + ADataPos + DatPos);
  pWordData^  := Len;

  //записвам самата данна на адреса
  pStr := pointer(PByte(buf) + ADataPos + DatPos + 2);
  //pStr  := @strData;
  stream.WriteData(pStr, Len);
  //увеличавам dataPosition със 2+ 4 + len*SizeOf(char) ; 2 за дължината на стринга; колкото толкова за стринга; и 4 байта за историята.
  Inc(dataPosition, 6 + len*SizeOf(AnsiChar));
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат

  pWordData := pointer(PByte(buf) + dataPosition); // записвам 00 за край
  pWordData^  := 0;
  Inc(dataPosition, 2);
end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData48; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical48Data: ^TLogicalData48;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical48Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical48Data^  := LogicalData;
  //увеличавам dataPosition с 6 + 4 ; 6 за самата данна и 4 байта за историята.
  Inc(dataPosition, 10);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 6);
end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData64; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical32Data: ^TLogicalData32;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical32Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical32Data^  := LogicalData;
  //увеличавам dataPosition с 8 + 4 ; 8 за самата данна и 4 байта за историята.
  Inc(dataPosition, 12);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 8);
end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData32; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical32Data: ^TLogicalData32;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical32Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical32Data^  := LogicalData;
  //увеличавам dataPosition с 4 + 4 ; 4 за самата данна и 4 байта за историята.
  Inc(dataPosition, 8);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 4);
end;

procedure TBaseItem.SaveData(var LogicalData: TLogicalData16; PropPosition: cardinal; var metaPosition, dataPosition: Cardinal);
var
  ADataPos: cardinal;
  pCardinalData: ^Cardinal;
  pLogical16Data: ^TLogicalData16;
  DatPos: Cardinal;
begin
  pCardinalData := pointer(PByte(buf) + 8);
  DatPos := pCardinalData^;
  //намирам адреса на койтом ще бъдат поставени данните
  ADataPos := dataPosition + 4 - DatPos;
  //записвам в мета-та адреса
  pCardinalData := pointer(PByte(buf) + metaPosition);
  pCardinalData^  := ADataPos;
  //увеличавам metaPosition с 4
  Inc(metaPosition, 4);
  //записвам самата данна на адреса
  pLogical16Data := pointer(PByte(buf) + ADataPos + datPos);
  pLogical16Data^  := LogicalData;
  //увеличавам dataPosition с 2 + 4 ; 2 за самата данна и 4 байта за историята.
  Inc(dataPosition, 6);
  pCardinalData := pointer(PByte(buf) + 12);
  pCardinalData^  := dataPosition;
  //записвам историята
  pCardinalData := pointer(PByte(buf) + ADataPos - 4 + DatPos);
  pCardinalData^  := ADataPos - 4; // при инсъртване понеже е първо двата адреса съвпадат
  TBaseCollection(Collection).streamComm.Write(LogicalData, 2);
end;

procedure TBaseItem.SaveData(var TreeLink: PVirtualNode; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
var
  Len: Word;
  cmd: TCommandsFill;
  p: ^Integer;
  t1,t2: Integer;
  ppp: Pointer;
  pTemp: PVirtualNode;
begin
  //ppp := Stream.Memory;
//  if (stream.Position mod 2) = 0 then
//  begin
//    len :=  54 ;
//    //stream.FFileStream.Position := stream.Position;
//  end
//  else
//  begin
//    len :=  55 ;
//    stream.Position := stream.Position + 1;
//    //stream.FFileStream.Position := stream.Position;
//  end;
//  stream.WriteBuffer(TreeLink^, 54); //записваме си го
//  //pTemp := pointer(PByte(ppp) + stream.Position - 60);
//
//  dataPosition := stream.Position;
//  stream.Position := metaPosition;
//  stream.Write(PropPosition, 4);
//  stream.FFileStream.Position := metaPosition;
//  metaPosition := stream.Position;
//  stream.FFileStream.Write(PropPosition, 4);
//  stream.LenData := stream.LenData + 4 + len;
end;

procedure TBaseItem.UpdateData(const TreeLink: PVirtualNode; parentIsRoot: boolean;
isUpdate: boolean; PropPosition: cardinal; var metaPosition,
  dataPosition: Cardinal);
var
  lenNode: Word;
  node: PVirtualNode;
  //posNode: Cardinal;
begin
  ////if not Assigned(PRecord) then Continue;
//  if (Integer(TreeLink) mod 2) = 0 then
//    lenNode := 60
//  else
//    lenNode := 61;
//  GetMem(node, lenNode);
//  MoveMemory(node, TreeLink, lenNode);
//  //if Assigned(node.Parent) then
////      node.Parent := Pointer(Integer(node.Parent) - integer(stream.Memory));
//  if not parentIsRoot and Assigned(node.Parent)  then
//  begin
//    node.Parent := Pointer(Integer(node.Parent) - integer(stream.Memory));
//  end
//  else
//  begin
//    node.Parent := nil;
//  end;
//  if node.PrevSibling <> nil then
//    node.PrevSibling := Pointer(Integer(node.PrevSibling) - integer(stream.Memory));
//  if node.NextSibling <> nil then
//    node.NextSibling := Pointer(Integer(node.NextSibling) - integer(stream.Memory));
//  if node.FirstChild <> nil then
//    node.FirstChild := Pointer(Integer(node.FirstChild) - integer(stream.Memory));
//  if node.LastChild <> nil then
//    node.LastChild := Pointer(Integer(node.LastChild) - integer(stream.Memory));
//
//  stream.FFileStream.Position :=Integer(TreeLink) - Integer(stream.Memory) - 4;
//  //posNode := stream.FFileStream.Position - stream.PosData;
//  stream.FFileStream.WriteBuffer(datapos, 4);
//  stream.FFileStream.WriteBuffer(node^, lenNode);
end;

{ TBaseCollection }

procedure TBaseCollection.ApplyVisibilityFromTree(RootNode: PVirtualNode);
begin

end;

function TBaseCollection.GetCollDelType: TCollectionsType;
begin
  Result := ctAspectDel;
end;

function TBaseCollection.GetCollType: TCollectionsType;
begin
  Result := ctAspect;
end;

procedure TBaseCollection.BuildKeyDict(PropIndex: Word);
begin
  if not Assigned(KeyDict) then
    KeyDict := TDictionary<string,Integer>.create
  else
    KeyDict.Clear;
end;

constructor TBaseCollection.Create(ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  streamComm := TCommandStream.Create;
  StreamCommTemp := TCommandStream.Create;
  FForLaterSave := TList<TForLaterSave>.Create;
  FCntUpdates := 0;
  FCntInADB := 0;
  ListDataPos := TList<PVirtualNode>.Create;
  ListNodes := TList<PAspRec>.Create;
  ListAnsi := TList<AnsiString>.Create;
  FoffsetTop := 0;
  FoffsetBottom := 0;
  FfirstTop := -1;
  FlastBottom := -1;
  FColumnForSort := -1;
  FSortFields := TSortFields.Create;
  ScrollTimer := TTimer.Create(nil);
  ScrollTimer.Interval := 35;
  ScrollTimer.OnTimer := ScrollTimerTimer;
  ScrollTimer.Enabled := false;
  ScrollDirection := 0;
  KeyDict := nil;
end;

destructor TBaseCollection.destroy;
begin
  FreeAndNil(FForLaterSave);
  FreeAndNil(ListDataPos);
  FreeAndNil(ListNodes);
  FreeAndNil(ListAnsi);
  FreeAndNil(FSortFields);
  streamComm.Free;
  StreamCommTemp.Free;
  ScrollTimer.Enabled := False;
  FreeAndNil(ScrollTimer);
  if Assigned(KeyDict) then
    FreeAndNil(KeyDict);

  inherited;
end;

function TBaseCollection.DisplayLogicalName(flagIndex: Integer): string;
begin

end;

function TBaseCollection.DisplayName(propIndex: Word): string;
begin

end;

function TBaseCollection.FieldCount: Integer;
begin
  Result := 0;
end;

procedure TBaseCollection.FillListLinks(Link: TMappedFile; vv: TVtrVid);
var
  linkPos, maxLinkPos: Cardinal;
  pCardinalData: PCardinal;
  node: PVirtualNode;
  data: PAspRec;
begin
  self.ListDataPos.Clear;
  linkPos := 100;
  pCardinalData := pointer(PByte(Link.Buf));
  maxLinkPos := pCardinalData^;
  node := pointer(PByte(link.Buf) + linkPos);

  while linkPos < maxLinkPos  do
  begin
    node := pointer(PByte(link.Buf) + linkPos);
    data := pointer(PByte(node) + lenNode);
    if data.vid = vv then
      self.ListDataPos.Add(node);
    Inc(linkPos, LenData);
  end;
end;

procedure TBaseCollection.FillListNodes(Link: TMappedFile; vv: TVtrVid);
var
  linkPos, maxLinkPos: Cardinal;
  pCardinalData: PCardinal;
  node: PVirtualNode;
  data: PAspRec;
begin
  self.ListNodes.Clear;
  linkPos := 100;
  pCardinalData := pointer(PByte(Link.Buf));
  maxLinkPos := pCardinalData^;
  node := pointer(PByte(link.Buf) + linkPos);

  while linkPos < maxLinkPos  do
  begin
    node := pointer(PByte(link.Buf) + linkPos);
    data := pointer(PByte(node) + lenNode);
    if data.vid = vv then
      self.ListNodes.Add(data);
    Inc(linkPos, LenData);
  end;

  SortListNodes;
end;

function TBaseCollection.FindItemFromDataPos(dataPos: cardinal): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if dataPos = TBaseItem(Items[i]).DataPos then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TBaseCollection.FindRootCollOptionNode: PVirtualNode;
begin
  Result := nil;
end;

function TBaseCollection.GetAllowedOperators(
  propIndex: Integer): TConditionTypeSet;
var
  kind: TAspectTypeKind;
begin
  kind := self.PropType(propIndex);
  Result := OperatorRules[kind];
end;

function TBaseCollection.getAnsiStringMap(dataPos: cardinal;
  propIndex: word): AnsiString;
var
  P: ^Cardinal;
  PLen: ^Word;
  pData: PAnsiChar;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (DataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := '';
    Exit;
  end;
  ofset := p^ + PosData;
  PLen := pointer(PByte(buf) + ofset);
  pData := pointer(PByte(buf) + ofset + 2);
  SetLength(Result, PLen^);
  Result := PAnsiChar(pData);
end;

function TBaseCollection.getAnsiStringMap4(dataPos: cardinal;
  propIndex4: word): AnsiString;
var
  P: ^Cardinal;
  PLen: ^Word;
  pData: PAnsiChar;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (DataPos  + propIndex4));
  if p^ = 0 then
  begin
    Result := '';
    Exit;
  end;
  ofset := p^ + PosData;
  PLen := pointer(PByte(buf) + ofset);
  pData := pointer(PByte(buf) + ofset + 2);
  SetLength(Result, PLen^);
  Result := PAnsiChar(pData);
end;

function TBaseCollection.getAnsiStringMapOfset(Ofset: cardinal;
  propIndex: word): AnsiString;
var
  P: ^Integer;
  PLen: ^Word;
  pData: PAnsiChar;
begin
  PLen := pointer(PByte(buf) + ofset);
  pData := pointer(PByte(buf) + ofset + 2);
  SetLength(Result, PLen^);
  Result := PAnsiChar(pData);
end;

function TBaseCollection.getCardMap(dataPos: cardinal;
  propIndex: word): cardinal;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Cardinal;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

procedure TBaseCollection.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
begin

end;

procedure TBaseCollection.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
begin

end;

function TBaseCollection.getDateMap(dataPos: cardinal; propIndex: word): Tdate;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TDate;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex); //
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset); //
  Result := pData^;
end;

function TBaseCollection.getDateMapPos(dataPos: cardinal;
  propIndex: word): Tdate;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TDate;
begin
  //p := pointer(PByte(buf) + dataPos + 4*propIndex); //
//  if p^ = 0 then
//  begin
//    Result := 0;
//    Exit;
//  end;
//  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset); //
  Result := pData^;
end;

function TBaseCollection.getDoubleMap(dataPos: cardinal;
  propIndex: word): Double;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Double;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.getIntMap(dataPos: cardinal; propIndex: word): integer;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Integer;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;


function TBaseCollection.getLogical08Map(dataPos: cardinal;
  propIndex: word): TLogicalData08;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData08;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.getLogical16Map(dataPos: cardinal;
  propIndex: word): TLogicalData16;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData16;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.getLogical24Map(dataPos: cardinal;
  propIndex: word): TLogicalData24;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData24;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.getLogical32Map(dataPos: cardinal;
  propIndex: word): TLogicalData32;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData32;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.getLogical40Map(dataPos: cardinal;
  propIndex: word): TLogicalData40;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData40;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.getLogical48Map(dataPos: cardinal;
  propIndex: word): TLogicalData48;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TLogicalData48;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := [];
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

function TBaseCollection.GetNodeFromID(linkBuf: pointer; vv: TVtrVid; propIndex: Word;
  id: integer): PVirtualNode;
var
  linkPos, maxLinkPos: Cardinal;
  pCardinalData: PCardinal;
  node: PVirtualNode;
  data: PAspRec;
  tempItem: TBaseItem;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(linkBuf));
  maxLinkPos := pCardinalData^;
  node := pointer(PByte(linkBuf) + linkPos);
  tempItem := TBaseItem.Create(nil);
  while linkPos < maxLinkPos  do
  begin
    node := pointer(PByte(linkBuf) + linkPos);
    data := pointer(PByte(node) + lenNode);
    tempItem.DataPos := data.DataPos;
    if (data.vid = vv) and (tempItem.getIntMap(Buf, FposData, propIndex) = id) then
    begin
      Result := node;
      Exit;
    end;
    Inc(linkPos, LenData);
  end;
end;

function TBaseCollection.GetNodeFromDataPos(Link: TMappedFile; vv: TVtrVid;
  dataPos: cardinal): PVirtualNode;
var
  linkPos, maxLinkPos: Cardinal;
  pCardinalData: PCardinal;
  node: PVirtualNode;
  data: PAspRec;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(Link.Buf));
  maxLinkPos := pCardinalData^;
  node := pointer(PByte(link.Buf) + linkPos);

  while linkPos < maxLinkPos  do
  begin
    node := pointer(PByte(link.Buf) + linkPos);
    data := pointer(PByte(node) + lenNode);
    if (data.vid = vv) and (data.DataPos = dataPos) then
    begin
      Result := node;
      Exit;
    end;
    Inc(linkPos, LenData);
  end;
end;

function TBaseCollection.getPAnsiStringMap(dataPos: cardinal;
  propIndex: word; var len: word): PAnsiChar;
var
  P: ^Cardinal;
  l: ^Word;
  ofset: Cardinal;
begin
  len := 0;
  p := pointer(PByte(buf) + (dataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Result := nil;
    Exit;
  end;
  ofset := p^ + PosData;
  l := pointer(PByte(buf) + ofset);
  len := l^;
  Result := pointer(PByte(l)+ 2);
end;

function TBaseCollection.getTimeMap(dataPos: cardinal; propIndex: word): TTime;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TTime;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex); //
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset); //
  Result := pData^;
end;

function TBaseCollection.getWordMap(dataPos: cardinal; propIndex: word): word;
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^word;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Result := 0;
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  Result := pData^;
end;

procedure TBaseCollection.grdSearchClickedHeader(Sender: TObject);
var
  APropIndex: Word; // това е индекса на колонката от колекцията
  sf: TSortField;
  i: Integer;
  Found: Boolean;
begin
  // грида не знае на коя колонка от нашата колекция е натисната. Неговата колонка е TColumn(Sender).
  APropIndex := ArrayPropOrderSearchOptions[TColumn(Sender).Index];
  Found := False;

  // Проверка дали Ctrl е натиснат
  if GetKeyState(VK_CONTROL) < 0 then
  begin
    // Търсим дали колоната вече участва
    for i := 0 to FSortFields.Count - 1 do
    begin
      if FSortFields[i].PropIndex = APropIndex then
      begin
        // Смяна на посоката при повторен клик
        sf := FSortFields[i];
        sf.SortAsc := not sf.SortAsc;
        FSortFields[i] := sf;
        Found := True;
        Break;
      end;
    end;

    if not Found then
    begin
      sf.PropIndex := APropIndex;
      sf.SortAsc := True;
      FSortFields.Add(sf);
    end;
  end
  else
  begin
    // Без Ctrl — започваме ново сортиране само по тази колона
    if (FSortFields.Count = 1) and (FSortFields[0].PropIndex = APropIndex) then
    begin
      // Смяна на посоката при повторен клик на единаствената колона
      sf := FSortFields[0];
      sf.SortAsc := not  FSortFields[0].SortAsc;
      FSortFields[0] := sf;
    end
    else
    begin
      FSortFields.Clear;
      sf.PropIndex := APropIndex;
      sf.SortAsc := True;
      FSortFields.Add(sf);
    end;
  end;

  // Обнови визуално стрелките на колоните
  TColumn(Sender).Header.Changed;

  // Извикай сортиране
  if Assigned(FOnSortCol) then
    FOnSortCol(Self);
end;


//procedure TBaseCollection.grdSearchClickedHeader(Sender: TObject);
//begin
//  //ar
//  FColumnForSort := TColumn(sender).tag;
//  TColumn(sender).Header.Changed;
//  if Assigned(FOnSortCol) then
//    FOnSortCol(Self);
//end;

procedure TBaseCollection.GrdSearhKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  nodeList: PVirtualNode;
  SelRow: Integer;
begin
  if Key = VK_UP then
  begin
    ScrollDirection := -1;
    ScrollTimer.Enabled := True;
    Key := 0;
  end
  else
  if Key = VK_DOWN then
  begin
    ScrollDirection := +1;
    ScrollTimer.Enabled := True;
    Key := 0;
  end;
  Exit;
  if not TKeyThrottle.CanExecute then
    Exit; // блокира повтарящите KeyDown-и при задържане

  SelRow := TTeeGrid(Sender).Selected.Row;
  if (self.ListDataPos.count - 1) < SelRow then
    Exit;
  if self.lastBottom = - 1 then
  begin
    nodeList := self.ListDataPos[SelRow];
  end
  else
  begin
    nodeList := self.ListDataPos[SelRow + self.offsetTop];
  end;

  case Key of
    VK_UP, VK_DOWN:
    begin
      // намери следващия/предишния record
      //nodeList := FindNodeForCurrentGridRow();
      TVSTSyncHelper.SyncToNode(VTR, nodeList);
    end;
  end;
end;

procedure TBaseCollection.GrdSearhKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  WMKey: TWMKey;
begin
  inherited;
  ScrollDirection := 0;
  ScrollTimer.Enabled := False;
  Exit;
  if Assigned(FOnKeyUpGridSearch)  then
    FOnKeyUpGridSearch(Sender, Key, Shift);

  //WMKey.Msg := WM_KEYUP;
//  WMKey.CharCode := VK_DOWN;
//  TGridForSrarch(Sender).DoKeyUp(WMKey);
end;

procedure TBaseCollection.HeaderCanSortBy(const AColumn: TColumn;
  var CanSort: Boolean);
begin
  CanSort:=(AColumn<>nil) and (FSortFields.Count > 0);
end;

procedure TBaseCollection.HeaderSortBy(Sender: TObject; const AColumn: TColumn);
begin
  //SortAsc:=not SortAsc;
end;

procedure TBaseCollection.HeaderSortState(const AColumn: TColumn;
  var State: TSortState);
var
  i: Integer;
  colInedx:Integer;
begin
  State := TSortState.None;
  colInedx := ArrayPropOrderSearchOptions[AColumn.Index];
  for i := 0 to FSortFields.Count - 1 do
  begin
    if FSortFields[i].PropIndex = colInedx then
    begin
      if not FSortFields[i].SortAsc then
        State := TSortState.Ascending
      else
        State := TSortState.Descending;
      Exit;
    end;
  end;
end;

procedure TBaseCollection.IncCntInADB;
begin
  inc(FCntInADB);
end;



function TBaseCollection.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result := True;
end;

procedure TBaseCollection.MarkDelete(FDataPos: cardinal);
var
  metaPosition: cardinal;
  pWordData: ^Word;
begin
  metaPosition := FDataPos - 4;
  pWordData := pointer(PByte(buf) + metaPosition);
  pWordData^  := word(Self.GetCollDelType);
end;

procedure TBaseCollection.DoCollSort(senedr: TObject);
var
  propIndex: Word;
begin
  //propIndex := self.ArrayPropOrderSearchOptions[collPreg.ColumnForSort];
//  propType := collPreg.PropType(propIndex);
//  case propType of
//    actAnsiString: SortAnsiListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
//    actInteger: SortIntListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
//    actTDate: SortDateListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
//    actTime: SortTimeListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
//    actLogical: SortLogical40ListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
//  end;
end;

procedure TBaseCollection.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
begin

end;




procedure TBaseCollection.OpenAdbFull(var aspPos: Cardinal);
var
  BaseItem: TBaseItem;
begin
  BaseItem := TBaseItem(self.Add);
  BaseItem.DataPos := aspPos;
  Inc(aspPos, (self.FieldCount) * 4);
  self.IncCntInADB;
end;

procedure TBaseCollection.OrderFieldsSearch(Grid: TTeeGrid);
begin

end;

procedure TBaseCollection.OrderFieldsSearch1(Grid: TTeeGrid);
begin

end;

function TBaseCollection.OrderProp(index: Integer): Integer;
begin

end;

function TBaseCollection.PropType(propIndex: Word): TAspectTypeKind;
begin
  Result := actNone;
end;

function TBaseCollection.RankSortOption(propIndex: Word): cardinal;
begin

end;

procedure TBaseCollection.ScrollTimerTimer(sender: tobject);
begin
  //if ScrollDirection = 0 then Exit;
  grid.Selected.Row := grid.Selected.Row + ScrollDirection;
end;

procedure TBaseCollection.SetAnsiStringMap(dataPos: cardinal; propIndex: word;
  AString: AnsiString);
var
  P: ^Cardinal;
  PLen: ^Word;
  pData: PAnsiChar;
  ofset: Cardinal;
begin
  p := pointer(PByte(buf) + (DataPos  + 4*propIndex));
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  //PLen := pointer(PByte(buf) + ofset);
 // PLen^ := Length(AString); // това трябва да го има и трябва да е точно толкова дълго, колкото е замислено за полето. Например 12 за НРН
  pData := pointer(PByte(buf) + ofset + 2); //двойката е за дължината
  //SetLength(Result, PLen^);
  System.SysUtils.StrCopy(pData, PAnsiChar(AString));
  //PAnsiChar(pData) := AString;
end;

procedure TBaseCollection.SetCardMap(dataPos: cardinal; propIndex: word;
  ACard: Cardinal);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Cardinal;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := ACard;
end;

procedure TBaseCollection.SetCntUpdates(const Value: Integer);
begin
  FCntUpdates := Value;
  if Assigned(FOnCntUpdates) then
    FOnCntUpdates(Self, FCntUpdates);
end;

procedure TBaseCollection.SetDateMap(dataPos: cardinal; propIndex: word;
  ADate: TDate);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TDate;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := ADate;
end;

procedure TBaseCollection.SetfirstTop(const Value: Integer);
begin
  FfirstTop := Value;
end;

procedure TBaseCollection.SetIntMap(dataPos: cardinal;
  propIndex: word; Aint: integer);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Integer;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := Aint;
end;

procedure TBaseCollection.SetlastBottom(const Value: Integer);
begin
  FlastBottom := Value;
  FoffsetTop := ListDataPos.Count - FlastBottom;
end;

procedure TBaseCollection.SetoffsetBottom(const Value: Integer);
begin
  FoffsetBottom := Value;
end;

procedure TBaseCollection.SetoffsetTop(const Value: Integer);
begin
  FoffsetTop := Value;
end;

procedure TBaseCollection.SetTimeMap(dataPos: cardinal; propIndex: word;
  ATime: TTime);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^TTime;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := ATime;
end;

procedure TBaseCollection.SetWordMap(dataPos: cardinal; propIndex, AWord: word);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Word;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := AWord;
end;

procedure TBaseCollection.SetLogical16Map(dataPos: cardinal; propIndex: word; ALog16: TLogicalData16);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: PLogicalData16;
begin
  p := pointer(PByte(buf) + dataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := ALog16;
end;

procedure TBaseCollection.ShowGrid(Grid: TTeeGrid);
begin

end;

procedure TBaseCollection.ShowLinksGrid(AGrid: TTeeGrid);
var
  i: word;
  hdr: TMultiSortableHeader;
  propIndex: Word;
begin
  if FGrid = nil then
    FGrid := AGrid;
  FGrid.ScrollBars.Horizontal.Visible := Tee.Control.TScrollBarVisible.Hide;
  if FlastBottom = - 1 then
  begin
    FGrid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListDataPos.Count - FoffsetTop - FoffsetBottom);
  end
  else
  begin
    FGrid.Data:=TVirtualModeData.Create(self.FieldCount + 1, FlastBottom);
  end;
  FGrid.OnClickedHeader := grdSearchClickedHeader;
  FGrid.Columns.OnMoved := DoColMoved;
  TGridForSrarch(FGrid).OnKeyUp := GrdSearhKeyUp;
  TGridForSrarch(FGrid).OnKeyDown := GrdSearhKeyDown;

  // използване на TMultiSortableHeader
  hdr := TMultiSortableHeader.Create(FGrid.Header.Changed);
  hdr.CollForSort := self;
  hdr.Grid := FGrid;
  FGrid.Header.SortRender := hdr;
  FGrid.Header.Sortable := True;
  // Set custom events
  TSortableHeader(FGrid.Header.SortRender).OnCanSort:=HeaderCanSortBy;
  TSortableHeader(FGrid.Header.SortRender).OnSortBy:=HeaderSortBy;
  TSortableHeader(FGrid.Header.SortRender).OnSortState:=HeaderSortState;

  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(FGrid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(FGrid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListDataPos.Count]);

  TVirtualModeData(FGrid.Data).OnGetValue:=self.GetCellDataPos;
  TVirtualModeData(FGrid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    FGrid.Columns[i].Width.Value := 110;
    FGrid.Columns[i].Tag := i;
  end;

  FGrid.Columns[self.FieldCount].Width.Value := 90;
  FGrid.Columns[self.FieldCount].Index := 0;

  OrderFieldsSearch1(FGrid);
  for i := 1 to FGrid.Columns.Count - 1 do
  begin
    propIndex := ArrayPropOrderSearchOptions[FGrid.Columns[i].Index];
    FGrid.Columns[i].Visible := self.IsCollVisible(propIndex);
  end;
  FGrid.ScrollBars.Horizontal.Visible := Tee.Control.TScrollBarVisible.Automatic;
  FGrid.Refresh;
end;

 //долното трябва да иде на опции
 // Grid.Columns[9].Index:= 1;
//  Grid.Columns[2].Visible:= False;
//  Grid.Columns[6].Visible:= False;
//  Grid.Columns[0].Locked := TColumnLocked.Left;
//  Grid.Columns[1].Locked := TColumnLocked.Left;
//  Grid.Columns[2].Locked := TColumnLocked.Left;

  //Grid.Columns[9].ta

procedure TBaseCollection.ShowListNodesGrid(Grid: TTeeGrid);
var
  i: word;
begin
  Grid.Tag := Integer(Self);
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNodes.Count);

  Grid.OnClickedHeader := grdSearchClickedHeader;
  Grid.Columns.OnMoved := DoColMoved;
  TGridForSrarch(Grid).OnKeyUp := GrdSearhKeyUp;
  Grid.Header.SortRender:= TSortableHeader.Create(Grid.Header.Changed);
  Grid.Header.Sortable := True;
  // Set custom events
  TSortableHeader(Grid.Header.SortRender).OnCanSort:=HeaderCanSortBy;
  TSortableHeader(Grid.Header.SortRender).OnSortBy:=HeaderSortBy;
  TSortableHeader(Grid.Header.SortRender).OnSortState:=HeaderSortState;

  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNodes.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellListNodes;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
  //grid.Columns[0].EditorClass:= TButton;
end;

procedure TBaseCollection.SortListDataPos;
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : PVirtualNode;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while PAspRec(Pointer(PByte(ListDataPos[I]) + lenNode)).DataPos > PAspRec(Pointer(PByte(ListDataPos[P]) + lenNode)).DataPos do Inc(I);
        while PAspRec(Pointer(PByte(ListDataPos[J]) + lenNode)).DataPos < PAspRec(Pointer(PByte(ListDataPos[P]) + lenNode)).DataPos do Dec(J);
        if I <= J then begin
          Save := ListDataPos[I];
          ListDataPos[I] := ListDataPos[J];
          ListDataPos[J] := Save;
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
  if (ListDataPos.count >1 ) then
  begin
    QuickSort(0,ListDataPos.count-1);
  end;
end;

procedure TBaseCollection.SortListNodes;
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : PAspRec;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while ListNodes[I].DataPos > ListNodes[P].DataPos do Inc(I);
        while ListNodes[J].DataPos < ListNodes[P].DataPos do Dec(J);
        if I <= J then begin
          Save := ListNodes[I];
          ListNodes[I] := ListNodes[J];
          ListNodes[J] := Save;
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
  if (ListNodes.count >1 ) then
  begin
    QuickSort(0,ListNodes.count-1);
  end;
end;

procedure TBaseCollection.SortMultiColumnsOptimized( FStop: Pboolean);
type
  TAnsiArr = TArray<AnsiString>;
  TIntArr  = TArray<Integer>;
  TFloatArr = TArray<Double>;
  TBoolArr = TArray<Byte>;
var
  Sorter: TInterruptibleQuickSort<Integer>;
  CompareFunc: TFunc<Integer, Integer, Integer>;
  ListDataPos: TList<PVirtualNode>;

  // Кеш по колона
  ArrAnsi: array of TAnsiArr;
  ArrInt: array of TIntArr;
  ArrFloat: array of TFloatArr;
  ArrBool: array of TBoolArr;
  ColType: array of TColumnType;

  i, j, c: Integer;
  IndexList: TList<Integer>;
  NewOrder: TList<PVirtualNode>;
  DataPos: Cardinal;
  test: Double;
begin
  if FSortFields.Count = 0 then Exit;

  ListDataPos := Self.ListDataPos;
  if ListDataPos.Count <= 1 then Exit;

  SetLength(ColType, FSortFields.Count);
  SetLength(ArrAnsi, FSortFields.Count);
  SetLength(ArrInt, FSortFields.Count);
  SetLength(ArrFloat, FSortFields.Count);
  SetLength(ArrBool, FSortFields.Count);

  // --- Предварително определяме типовете ---
  for c := 0 to FSortFields.Count - 1 do
  begin
    case Self.PropType(FSortFields[c].PropIndex) of
      actAnsiString: ColType[c] := ctAnsi;
      actInteger:    ColType[c] := ctInt;
      actTDate, actTime: ColType[c] := ctFloat;
      actLogical:    ColType[c] := ctBool;
    else
      ColType[c] := ctAnsi; // по подразбиране
    end;
  end;

  // --- Кеширане ---
  for c := 0 to FSortFields.Count - 1 do
  begin
    case ColType[c] of
      ctAnsi:
        begin
          SetLength(ArrAnsi[c], ListDataPos.Count);
          for i := 0 to ListDataPos.Count - 1 do
          begin
            DataPos := PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos;
            ArrAnsi[c][i] := Self.getAnsiStringMap(DataPos, FSortFields[c].PropIndex);
          end;
        end;

      ctInt:
        begin
          SetLength(ArrInt[c], ListDataPos.Count);
          for i := 0 to ListDataPos.Count - 1 do
          begin
            DataPos := PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos;
            ArrInt[c][i] := Self.getIntMap(DataPos, FSortFields[c].PropIndex);
          end;
        end;

      ctFloat:
        begin
          SetLength(ArrFloat[c], ListDataPos.Count);
          for i := 0 to ListDataPos.Count - 1 do
          begin
            DataPos := PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos;
            ArrFloat[c][i] := Self.getDateMap(DataPos, FSortFields[c].PropIndex);
          end;
        end;

      //ctBool:
//        begin
//          SetLength(ArrBool[c], ListDataPos.Count);
//          for i := 0 to ListDataPos.Count - 1 do
//          begin
//            DataPos := PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos;
//            ArrBool[c][i] := Ord(Self.getLogicalMap(DataPos, Columns[c].PropIndex));
//          end;
//        end;
    end;
  end;

  // --- Функция за сравнение ---
  CompareFunc := TFunc<Integer, Integer, Integer>(
    function(const A, B: Integer): Integer
    var
    col, cmp: Integer;
  begin
    Result := 0;
    for col := 0 to (FSortFields.Count - 1) do
    begin
      case ColType[col] of
        ctInt:
          begin
            if ArrInt[col][A] < ArrInt[col][B] then cmp := -1
            else if ArrInt[col][A] > ArrInt[col][B] then cmp := 1
            else cmp := 0;
          end;
        ctFloat:
          begin
            if Abs(ArrFloat[col][A] - ArrFloat[col][B]) < EPS then cmp := 0
            else if ArrFloat[col][A] < ArrFloat[col][B] then cmp := -1
            else cmp := 1;
          end;
        ctAnsi:
          cmp := System.AnsiStrings.StrComp(PAnsiChar(ArrAnsi[col][A]), PAnsiChar(ArrAnsi[col][B]));
      end;

      if not FSortFields[col].SortAsc then
        cmp := -cmp;

      //️Много важно:
      if cmp <> 0 then
      begin
        Result := cmp;
        Exit;
      end ;
    end;
  end);

  // --- Индекси ---
  IndexList := TList<Integer>.Create;
  try
    IndexList.Capacity := ListDataPos.Count;
    for i := 0 to ListDataPos.Count - 1 do
      IndexList.Add(i);

    Sorter := TInterruptibleQuickSort<Integer>.Create(FStop);
    try
      Sorter.Sort(IndexList, CompareFunc);
    finally
      Sorter.Free;
    end;

    // --- Пренареждане ---
    NewOrder := TList<PVirtualNode>.Create;
    try
      NewOrder.Capacity := ListDataPos.Count;
      for i := 0 to IndexList.Count - 1 do
        NewOrder.Add(ListDataPos[IndexList[i]]);

      ListDataPos.Clear;
      ListDataPos.AddRange(NewOrder);
    finally
      NewOrder.Free;
    end;
  finally
    IndexList.Free;
  end;
end;


procedure TBaseCollection.UpdateOrderArrayFromTree(Root: PVirtualNode);
var
  run: PVirtualNode;
begin
  run := Root.FirstChild.FirstChild;
  while run <> nil do
  begin
    ArrayPropOrderSearchOptions[run.Index + 1] := run.Dummy - 1;
    run := run.NextSibling;
  end;
end;

procedure TBaseCollection.SortAnsiListPropIndexCollNew(propIndex: word;
  SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : AnsiString;
    saveList: PVirtualNode;
  begin
    repeat
     // Sleep(1);//  за тесттване на бавно сортиране
      //if FStop then
//      begin
//        ListAnsi.Clear;
//        //ListAnsi.Free;
//        FStoped := True;
//        Exit;
//      end;
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while (ListAnsi[I])< (ListAnsi[P]) do Inc(I);
          while (ListAnsi[J]) > (ListAnsi[P]) do Dec(J);
        end
        else
        begin
          while (ListAnsi[I])> (ListAnsi[P]) do Inc(I);
          while (ListAnsi[J]) < (ListAnsi[P]) do Dec(J);
        end;
        if I <= J then begin
          Save := ListAnsi[I];
          saveList := ListDataPos[I];
          ListAnsi[I] := ListAnsi[J];
          ListDataPos[I] := ListDataPos[J];
          ListAnsi[J] := Save;
          ListDataPos[J] := saveList;
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
  ListDataPos := self.ListDataPos;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListAnsi.Add(self.getAnsiStringMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, propIndex));
    QuickSort(0,ListAnsi.count-1);
    ListAnsi.Clear;
    //ListAnsi.Free;
   // FStoped := True;
  end;
end;

procedure TBaseCollection.SortAnsiPropInterruptible(PropIndex: Word; SortAsc: Boolean; StopFlag: PBoolean);
var
  Sorter: TInterruptibleQuickSort<Integer>;
  CompareFunc: TFunc<Integer, Integer, Integer>;
  ArrAnsi: TArray<AnsiString>;
  IndexList: TList<Integer>;
  NewOrder: TList<PVirtualNode>;
  i: Integer;
begin
  if (ListDataPos = nil) or (ListDataPos.Count <= 1) then Exit;

  SetLength(ArrAnsi, ListDataPos.Count);
  for i := 0 to High(ArrAnsi) do
    ArrAnsi[i] := getAnsiStringMap(
      PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos,
      PropIndex
    );

  CompareFunc := TFunc<Integer, Integer, Integer>(
    function(const A, B: Integer): Integer
    begin
      if (StopFlag <> nil) and StopFlag^ then
        Exit(0);
      Result := System.AnsiStrings.StrComp(PAnsiChar(ArrAnsi[A]), PAnsiChar(ArrAnsi[B]));
      if not SortAsc then
        Result := -Result;
    end);

  IndexList := TList<Integer>.Create;
  try
    for i := 0 to ListDataPos.Count - 1 do
      IndexList.Add(i);

    Sorter := TInterruptibleQuickSort<Integer>.Create(StopFlag);
    try
      Sorter.Sort(IndexList, CompareFunc);
    finally
      Sorter.Free;
    end;

    NewOrder := TList<PVirtualNode>.Create;
    try
      for i := 0 to IndexList.Count - 1 do
        NewOrder.Add(ListDataPos[IndexList[i]]);
      ListDataPos.Clear;
      ListDataPos.AddRange(NewOrder);
    finally
      NewOrder.Free;
    end;
  finally
    IndexList.Free;
  end;
end;


procedure TBaseCollection.SortDatePropInterruptible(PropIndex: Word; SortAsc: Boolean; StopFlag: PBoolean);
var
  Sorter: TInterruptibleQuickSort<Integer>;
  CompareFunc: TFunc<Integer, Integer, Integer>;
  ArrDate: TArray<TDateTime>;
  IndexList: TList<Integer>;
  NewOrder: TList<PVirtualNode>;
  i: Integer;
begin
  if (ListDataPos = nil) or (ListDataPos.Count <= 1) then Exit;

  SetLength(ArrDate, ListDataPos.Count);
  for i := 0 to High(ArrDate) do
    ArrDate[i] := getDateMap(
      PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos,
      PropIndex
    );

  CompareFunc := TFunc<Integer, Integer, Integer>(
    function(const A, B: Integer): Integer
    begin
      if (StopFlag <> nil) and StopFlag^ then
        Exit(0);
      if ArrDate[A] < ArrDate[B] then Result := -1
      else if ArrDate[A] > ArrDate[B] then Result := 1
      else Result := 0;
      if not SortAsc then
        Result := -Result;
    end);

  IndexList := TList<Integer>.Create;
  try
    for i := 0 to ListDataPos.Count - 1 do
      IndexList.Add(i);

    Sorter := TInterruptibleQuickSort<Integer>.Create(StopFlag);
    try
      Sorter.Sort(IndexList, CompareFunc);
    finally
      Sorter.Free;
    end;

    NewOrder := TList<PVirtualNode>.Create;
    try
      for i := 0 to IndexList.Count - 1 do
        NewOrder.Add(ListDataPos[IndexList[i]]);
      ListDataPos.Clear;
      ListDataPos.AddRange(NewOrder);
    finally
      NewOrder.Free;
    end;
  finally
    IndexList.Free;
  end;
end;


procedure TBaseCollection.SortIntegerPropInterruptible(PropIndex: Word; SortAsc: Boolean; StopFlag: PBoolean);
var
  Sorter: TInterruptibleQuickSort<Integer>;
  CompareFunc: TFunc<Integer, Integer, Integer>;
  ArrInt: TArray<Integer>;
  IndexList: TList<Integer>;
  NewOrder: TList<PVirtualNode>;
  i: Integer;
begin
  if (ListDataPos = nil) or (ListDataPos.Count <= 1) then Exit;

  SetLength(ArrInt, ListDataPos.Count);
  for i := 0 to High(ArrInt) do
    ArrInt[i] := getIntMap(
      PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos,
      PropIndex
    );

  CompareFunc := TFunc<Integer, Integer, Integer>(
    function(const A, B: Integer): Integer
    begin
      if (StopFlag <> nil) and StopFlag^ then
        Exit(0);
      Result := ArrInt[A] - ArrInt[B];
      if not SortAsc then
        Result := -Result;
    end);

  IndexList := TList<Integer>.Create;
  try
    for i := 0 to ListDataPos.Count - 1 do
      IndexList.Add(i);

    Sorter := TInterruptibleQuickSort<Integer>.Create(StopFlag);
    try
      Sorter.Sort(IndexList, CompareFunc);
    finally
      Sorter.Free;
    end;

    NewOrder := TList<PVirtualNode>.Create;
    try
      for i := 0 to IndexList.Count - 1 do
        NewOrder.Add(ListDataPos[IndexList[i]]);
      ListDataPos.Clear;
      ListDataPos.AddRange(NewOrder);
    finally
      NewOrder.Free;
    end;
  finally
    IndexList.Free;
  end;
end;


procedure TBaseCollection.SortListByDataPos(lst: TList<TBaseItem>);

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TBaseItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (lst[I]).FDataPos < (lst[P]).FDataPos do Inc(I);
        while (lst[J]).FDataPos > (lst[P]).FDataPos do Dec(J);
        if I <= J then begin
          Save := lst[I];
          lst[I] := lst[J];
          lst[J] := Save;
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
  if (lst.count >1 ) then
  begin
    QuickSort(0,lst.count-1);
  end;
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valWord: Pword): string;
begin
  valWord := getPWordMap(buf, posData, propIndex);
  if valWord = nil  then
    Result := 'nil'
  else
    Result := inttostr(valWord^);
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valBoolean: PBoolean): string;
begin
  valBoolean := getPBooleanMap(buf, posData, propIndex);
  if valBoolean = nil  then
    Result := 'nil'
  else
    Result := BoolToStr(valBoolean^, true);
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valDouble: PDouble): string;
begin
  try
    valDouble := getPDoubleMap(buf, posData, propIndex);
    if valDouble = nil  then
      Result := 'nil'
    else
      Result := FloatToStr(valDouble^);
  except
    Result := 'err';
  end;
end;

function TBaseItem.ValueToStringMap(buf: pointer; posData: cardinal;
  propIndex: word; valByte: PByte): string;
begin
  valByte := getPByteMap(buf, posData, propIndex);
  if valByte = nil  then
    Result := 'nil'
  else
    Result := inttostr(valByte^);
end;

{ TMappedFile }

constructor TMappedFile.Create(const AFileName: WideString; IsNew: Boolean; AGuid: TGUID);
begin
  inherited Create;
  FGUID := AGuid;
  if FileExists(AFileName) or IsNew then
  begin
    MapFileBuf(AFileName, IsNew);
    FFileName  := AFileName;
  end
  else
    raise Exception.Create('Файлът "' + AFileName + '" не може да бъде намерен.');
end;

destructor TMappedFile.Destroy;
begin
  if Assigned(FBuf) then
  begin
    UnmapViewOfFile(FBuf);
    if FMapping  <> 0 then
    begin
      CloseHandle(FMapping);
    end;
  end;
  inherited;
end;

function TMappedFile.GetLenData: cardinal;
var
  pCardinalData: PCardinal;
begin
  pCardinalData := pointer(PByte(FBuf) + 12);
  result := pCardinalData^;
end;

function TMappedFile.GetLenLinkData: cardinal;
var
  pCardinalData: PCardinal;
begin
  pCardinalData := pointer(PByte(FBuf));
  result := pCardinalData^;
end;

function TMappedFile.GetLenMetaData: cardinal;
var
  pCardinalData: PCardinal;
begin
  pCardinalData := pointer(PByte(FBuf) + 4);
  result := pCardinalData^;
end;

function TMappedFile.GetSizeCMD: LONG64;
var
  pLONG64Data: PLONG64;
begin
  pLONG64Data := pointer(PByte(FBuf) + 32);
  result := pLONG64Data^;
end;

procedure TMappedFile.MapFileBuf(const AFileName: WideString; IsNew: Boolean);
var
  FileHandle: THandle;
  pCardinalData: ^Cardinal;
  bufer: Integer;
  i: Integer;
  Pg: PGUID;
  pgMem: UInt64;
  pgmemHi, pgmemLo: dword;
  p: PDWORD;

begin
  if false then
  begin
    FileHandle := CreateFileW(PWideChar(WideString('\\?\' + AFileName)), GENERIC_ALL, FILE_SHARE_READ or
        FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0); //FILE_FLAG_NO_BUFFERING  FILE_ATTRIBUTE_NORMAL
  end
  else
  begin
    FileHandle := CreateFileW(PWideChar(WideString(AFileName)), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE,
     nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);  //FILE_FLAG_NO_BUFFERING
  end;
  if (FileHandle <> 0) and (FileHandle <> invalid_handle_value) then
  try
    FSize := GetFileSize(FileHandle, nil);
    if FSize <> 0 then
    begin
      //pgmem := 5000000000;
//      p := @pgmem;
//      pgmemHi := p^;
//      inc(p, 4);
//      pgmemLo := p^;
      FMapping := CreateFileMappingW(FileHandle, nil, PAGE_READWRITE, 0, 0, nil);
     // Win32Check(FMapping <> 0);
    end;
  finally
    CloseHandle(FileHandle);
  end;
  if FSize = 0 then
    FBuf := nil
  else
  begin
    FBuf := MapViewOfFile(FMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    if FPosMetaData = 0 then
    begin
      FPosMetaData := 100;
      FLenMetaData := 0;
      FPosData := FSize div 4;
      FLenData := 0;
    end
    else
    begin
      // трябва да са въведени преди това
    end;

    if IsNew then
    begin
      pCardinalData := pointer(PByte(FBuf));
      pCardinalData^ := FPosMetaData;
      pCardinalData := pointer(PByte(FBuf) + 4);
      pCardinalData^ := FLenMetaData;
      pCardinalData := pointer(PByte(FBuf) + 8);
      pCardinalData^ := FPosData;
      pCardinalData := pointer(PByte(FBuf) + 12);
      pCardinalData^ := FLenData;
      Pg := pointer(PByte(FBuf) + 16);
      Pg^ := Self.GUID;
      //Win32Check(FBuf <> nil);
    end;
  end;
end;

{ TCommandStream }

procedure TCommandStream.SetDataPos(const Value: Cardinal);
begin
  FDataPos := Value;
  Position := 8;
  Write(FDataPos, 4);
end;

procedure TCommandStream.SetLen(const Value: word);
begin
  FLen := Value;
  Position := 0;
  Write(FLen, 2);
end;



procedure TCommandStream.SetOpType(const Value: TOperationType);
begin
  position := 2;
  FOpType := Value;
  Write(FOpType, 2);
end;

procedure TCommandStream.SetPropertys(const Value: TLogicalData128);
begin
  position := 12;
  FPropertys := Value;
  Write(FPropertys, sizeof(TLogicalData128));
end;

procedure TCommandStream.SetVer(const Value: word);
begin
  Position := 4;
  FVer := Value;
  Write(FVer, 2);
end;

procedure TCommandStream.SetVid(const Value: TCollectionsType);
begin
  position := 6;
  FVid := Value;
  if FVid = ctLink then
  begin
    FVid := Value;
  end;
  //if not(FVid in [ctDoctor, ctMkb]) then  // за тестове е
//  begin
//    FVid := Value;
//  end;

  Write(FVid, 2);
end;

function TBaseItem.IsFinded(PLog32Find: TLogicalData32; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean;
var
  PLog32Buf: TLogicalData32;
begin
  PLog32Buf := getLogical32Map(Buf, FPosDataADB, FieldForFind);
  //Result := (PLog32Find * PLog32Buf) = PLog32Find; // лявото и  дясното имат сечение, което е точно лявото
  Result := not(PLog32Find <= PLog32Buf) // лявото е(не е) подмножество на дясното
end;

function TBaseItem.IsFinded(PBoolFind: Boolean; buf: Pointer; FPosDataADB: Cardinal; FieldForFind: word; cot: TConditionSet): Boolean;
var
  PBoolBuf: PBoolean;
begin
  PBoolBuf := getPBooleanMap(Buf, FPosDataADB, FieldForFind);
  Result := PBoolFind = PBoolBuf^;
end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData08; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 2;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData40; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 6;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommand(Props: TLogicalData16; vid: TCollectionsType; OpType: TOperationType; ver: word; AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).streamComm;
  result.OpType := OpType;
  result.Size := 10 + 2;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommandTemp(Props: TLogicalData32;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).StreamCommTemp;
  result.OpType := OpType;
  result.Size := 10 + 4;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommandTemp(Props: TLogicalData48;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).StreamCommTemp;
  result.OpType := OpType;
  result.Size := 10 + 6;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommandTemp(Props: TLogicalData128;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).StreamCommTemp;
  result.OpType := OpType;
  result.Size := 10 + 16;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommandTemp(Props: TLogicalData16;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).StreamCommTemp;
  result.OpType := OpType;
  result.Size := 10 + 2;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommandTemp(Props: TLogicalData40;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).StreamCommTemp;
  result.OpType := OpType;
  result.Size := 10 + 5;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

function TBaseItem.SaveStreamCommandTemp(Props: TLogicalData08;
  vid: TCollectionsType; OpType: TOperationType; ver: word;
  AdataPos: cardinal): TCommandStream;
begin
  result := TBaseCollection(Collection).StreamCommTemp;
  result.OpType := OpType;
  result.Size := 10 + 1;
  Result.Ver := ver;
  Result.Vid := vid;
  Result.DataPos := AdataPos;
  Result.Propertys := props;
end;

procedure TBaseItem.SetIntMap(buf: pointer; posData: cardinal; propIndex: word;
  Aint: integer);
var
  P: ^Cardinal;
  ofset: Cardinal;
  pData: ^Integer;
begin
  p := pointer(PByte(buf) + FDataPos + 4*propIndex);
  if p^ = 0 then
  begin
    Exit;
  end;
  ofset := p^ + PosData;
  pData := pointer(PByte(buf) + ofset);
  pData^ := Aint;
end;



procedure TBaseItem.SetPosCMDTemp(posCmd: Cardinal);
begin

end;

{ TNumerEdit }

constructor TNumerEdit.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TNumerEdit.WMChar(var Message: TWMChar);
begin
  if (Message.CharCode in[1, 3, 22, 24, 26]) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    inherited;
    Exit;
  end;
  if Message.CharCode in [8, 48..57] then
    inherited;
end;

procedure TNumerEdit.WMCharToItem(var Message: TWMCharToItem);
begin
  inherited;
end;

procedure TNumerEdit.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
end;

procedure TNumerEdit.WMKeyUp(var Message: TWMKeyUp);
begin
  inherited;
end;

{ TMappedLinkFile }

procedure TMappedLinkFile.SetCurrentFilter(const Value: PVirtualNode);
begin
  FCurrentFilter := Value;

  if FCurrentFilter = nil then Exit;

  // филтърното дърво е това:
  //   Self = AspectsFilterLinkFile  (което съдържа FVTR)

  // 1) построяваме индекса само за филтърното дърво
  Self.BuildPathIndex;

  // 2) правим join спрямо ADB индекса
  //if Assigned(FFilterLink) then
//    Self.BuildJoinTable(FFilterLink); // или JoinWith(…)
end;

procedure TMappedLinkFile.SetSearchPopupMenu(const Value: TPopupMenu);
begin
  FSearchPopupMenu := Value;

  if FSearchPopupMenu <> nil then
  begin
    FSearchPopupMenu.OnPopup := InternalMenuPopup;
  end;
end;

procedure TMappedLinkFile.SortPathIndexKeys(var Keys: TArray<UInt64>);
  procedure QuickSort(L, R: Integer);
  var
    I, J: Integer;
    P, T: UInt64;
  begin
    I := L;
    J := R;
    P := Keys[(L + R) shr 1];
    repeat
      while Keys[I] < P do Inc(I);
      while Keys[J] > P do Dec(J);
      if I <= J then
      begin
        T := Keys[I];
        Keys[I] := Keys[J];
        Keys[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    if I < R then QuickSort(I, R);
  end;
begin
  if Length(Keys) > 1 then
    QuickSort(0, High(Keys));
end;

procedure TMappedLinkFile.JoinWith(FilterFile: TMappedLinkFile);
var
  AdbKeys, FilterKeys: TArray<UInt64>;

  i, j: Integer;
  adbSig, filterSig: UInt64;

  AList, FList: TList<PVirtualNode>;

  bucket: TJoinBucket;
  data: PAspRecFilter;
begin
  if FilterFile = nil then
    Exit;

  // изчистваме старите резултати
  if JoinResult = nil then
    JoinResult := TList<TJoinBucket>.Create
  else
    JoinResult.Clear;

  // взимаме ключовете
  AdbKeys := PathIndex.Keys.ToArray;
  FilterKeys := FilterFile.PathIndex.Keys.ToArray;

  // сортиране за merge-join
  SortPathIndexKeys(AdbKeys);
  SortPathIndexKeys(FilterKeys);

  i := 0;
  j := 0;

  // MERGE JOIN
  while (i < Length(AdbKeys)) and (j < Length(FilterKeys)) do
  begin
    adbSig := AdbKeys[i];
    filterSig := FilterKeys[j];

    if adbSig = filterSig then
    begin
      // взимаме списъка с ADB възлите
      if not PathIndex.TryGetValue(adbSig, AList) then
      begin
        Inc(i); Inc(j);
        Continue;
      end;

      // взимаме списъка с FILTER възлите (трябва да е точно 1)
      if not FilterFile.PathIndex.TryGetValue(filterSig, FList) then
      begin
        Inc(i); Inc(j);
        Continue;
      end;

      if FList.Count <> 1 then
      begin
        OutputDebugString(PChar(Format(
          'WARNING: Filter bucket with SIG=%d has %d nodes! Expected 1.',
          [filterSig, FList.Count])));
      end;

      FillChar(bucket, SizeOf(bucket), 0);

      bucket.Sig := adbSig;
      bucket.AdbList := AList;              // всички реални възли
      bucket.FilterNode := FList[0];        // точно един филтърен възел

      JoinResult.Add(bucket);

      // сложи bucket index в филтърния възел
      data := PAspRecFilter(PByte(bucket.FilterNode) + lenNode);
      data.index := JoinResult.Count - 1;

      Inc(i);
      //Inc(j);
    end
    else if adbSig < filterSig then
      Inc(i)
    else
      Inc(j);
  end;
end;



procedure TMappedLinkFile.AddNewNode(const vv: TVtrVid; dataPos: Cardinal; TargetNode: PVirtualNode; Mode: TVTNodeAttachMode;
   var TreeLink: PVirtualNode; var linkPos: cardinal; dum: Byte);
var
  pCardinalData: PCardinal;
  data: PAspRec;
begin
  if vv = vvNZIS_DIAGNOSTIC_REPORT then
  begin
    pCardinalData := pointer(PByte(self.Buf));
  end;
  pCardinalData := pointer(PByte(self.Buf));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(self.Buf) + linkpos);
  data := pointer(PByte(self.Buf) + linkpos + lenNode);
  data.index := -1;
  data.vid := vv;
  data.DataPos := DataPos;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := dum;
  //if TreeLink.Parent  <> nil then
  begin
    FVTR.InitNode(TreeLink);
  end;
  FVTR.InternalConnectNode_cmd(TreeLink, TargetNode, FVTR, mode, FStreamCmdFile);
  pCardinalData^ := linkpos;
end;



procedure TMappedLinkFile.AddPathIndexNode(Node: PVirtualNode; Sig: UInt64);
var
  lst: TList<PVirtualNode>;
begin
  if not PathIndex.TryGetValue(Sig, lst) then
  begin
    lst := TList<PVirtualNode>.Create;
    PathIndex.Add(Sig, lst);
  end;

  lst.Add(Node);
end;

procedure TMappedLinkFile.BuildPathIndex;
var
  linkPos: Cardinal;
  node: PVirtualNode;
  sig: UInt64;
  lst: TList<PVirtualNode>;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  testData: PAspRec;
begin
  // изчистваме предишните списъци
  for lst in PathIndex.Values do
    lst.Free;
  PathIndex.Clear;

  linkPos := 100;

  pCardinalData := pointer(PByte(self.buf));
  FPosLinkData := pCardinalData^;
  while linkpos < FPosLinkData do
  begin
    node := pointer(PByte(self.buf) + linkpos);
    Inc(linkPos, LenData);
    testData := pointer(PByte(node) + lenNode);
    if testData.vid = vvHosp then
    begin
      testData.vid := vvHosp;
    end;

    if node = nil then Continue;

    sig := ComputeNodePathSig(node);
    AddPathIndexNode(node, sig);
  end;
end;

function TMappedLinkFile.ComputeNodePathSig(Node: PVirtualNode): UInt64;
var
  cur: PVirtualNode;
  asp: PAspRec;
  h: UInt64;
  vid: TVtrVid;
begin
  h := FNV_OFFSET;

  cur := Node;

  // вървим нагоре, до корена на аспектското дърво
  while (cur <> nil) and (cur <> FVTR.RootNode.FirstChild) do
  begin
    asp := PAspRec(PByte(cur) + lenNode);
    vid := asp.vid;

    // включваме само ако вида го позволи
    if not(vid in IsFilterNode) then
      h := (h xor UInt64(Ord(vid))) * FNV_PRIME;

    cur := cur.Parent;
  end;

  Result := h;
end;


constructor TMappedLinkFile.Create(const AFileName: WideString; IsNew: Boolean;
  AGuid: TGUID);
var
  data: PAspRecFilter;
begin
  inherited Create(AFileName, IsNew,  AGuid);
  PathIndex := TDictionary<UInt64, TList<PVirtualNode>>.Create;
  //PathIndex1 := TList<tPathIndex>.create;

end;

destructor TMappedLinkFile.Destroy;
var
  list: TList<PVirtualNode>;
begin
  for list in PathIndex.Values do
    list.Free;
  PathIndex.Free;
  //PathIndex1.Free;
  inherited;
end;

procedure TMappedLinkFile.InternalMenuItemClick(Sender: TObject);
var
  item: TMenuItem;
  coll: TBaseCollection;
begin
  item := Sender as TMenuItem;
  coll := TBaseCollection(item.Tag);

  //Self.SelectedCollection := coll;
//
//  StartMagicSearch;
//
//  if Assigned(OnCollectionSelected) then
//    OnCollectionSelected(coll);
end;


procedure TMappedLinkFile.InternalMenuPopup(Sender: TObject);
begin
  if FSearchPopupMenu = nil then Exit;
  if FCurrentFilter = nil then Exit;

  PopulateSearchPopup(FSearchPopupMenu);
end;


procedure TMappedLinkFile.MarkDeletedNode(var TreeLink: PVirtualNode);
begin
  if TreeLink <> nil then
  begin
    FVTR.InternalDisconnectNode(TreeLink, false);
  end;
end;

procedure TMappedLinkFile.OpenLinkFile;
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosLinkData: Cardinal;
  node: PVirtualNode;
  linkPos: Cardinal;
  deltaBuf, oldBuf: Cardinal;
  oldRoot: Cardinal;
  fileNameLink: string;
  AInt64: Int64;
  data: PAspRec;
begin
  FVTR.BeginUpdate;

  pCardinalData := pointer(PByte(self.Buf) + 4);
  oldBuf := pCardinalData^;
  if Cardinal(self.Buf) >= oldBuf then
  begin
    deltaBuf := Cardinal(self.Buf) - oldBuf;
  end
  else
  begin
    deltaBuf := oldBuf - Cardinal(self.Buf);
  end;
  pCardinalData := pointer(PByte(self.Buf) + 4);
  pCardinalData^ := Cardinal(self.Buf);
  pCardinalData := pointer(PByte(self.Buf) + 8);
  oldRoot := pCardinalData^;

  //mmotest.Lines.Add(Format('BufLink  = %d', [cardinal(AspectsLinkPatPregFile.Buf)]));

  linkPos := 100;
  pCardinalData := pointer(PByte(self.Buf));
  FPosLinkData := pCardinalData^;
  node := pointer(PByte(self.Buf) + linkpos);

  Exclude(node.States, vsSelected);
  data := pointer(PByte(node) + lenNode);
  if not (data.vid in [vvPatientRevision]) then
    data.index := -1;
  i := 0;
  if Cardinal(self.Buf) > oldBuf then
  begin
    while linkPos <= FPosLinkData do
    begin
      if node.PrevSibling <> nil then
        node.PrevSibling := Pointer(Integer(deltaBuf) + Integer(node.PrevSibling));
      if node.NextSibling <> nil then
        node.NextSibling := Pointer(Integer(deltaBuf) + Integer(node.NextSibling));
      if node.FirstChild <> nil then
        node.FirstChild := Pointer(Integer(deltaBuf) + Integer(node.FirstChild));
      if node.LastChild <> nil then
        node.LastChild := Pointer(Integer(deltaBuf) + Integer(node.LastChild));

      if linkPos <> 100 then
      begin
        if (node.Parent <> nil)  then
          node.parent := Pointer(Integer(deltaBuf) + Integer(node.parent));
      end
      else
      begin
        node.parent := nil;
      end;
      Inc(linkPos, LenData);

      node := pointer(PByte(self.Buf) + linkpos);
      Exclude(node.States, vsSelected);
      //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
      data := pointer(PByte(node) + lenNode);
      if not (data.vid in [vvPatientRevision]) then
        data.index := -1;
      if data.vid = vvEvntList then
      begin
        data.DataPos := data.DataPos + deltaBuf;
      end;

    end;
  end
  else
  begin
    if deltaBuf <> 0 then
    begin
      while linkPos <= FPosLinkData do
      begin
        if node.PrevSibling <> nil then
            node.PrevSibling := Pointer(-Integer(deltaBuf) + Integer(node.PrevSibling));
        if node.NextSibling <> nil then
          node.NextSibling := Pointer(-Integer(deltaBuf) + Integer(node.NextSibling));
        if node.FirstChild <> nil then
          node.FirstChild := Pointer(-Integer(deltaBuf) + Integer(node.FirstChild));
        if node.LastChild <> nil then
          node.LastChild := Pointer(-Integer(deltaBuf) + Integer(node.LastChild));
        if linkPos <> 100 then
        begin
          if (node.Parent <> nil)  then
            node.parent := Pointer(-Integer(deltaBuf) + Integer(node.parent));
        end
        else
        begin
          node.Parent := nil;
        end;
        Inc(linkPos, LenData);
        node := pointer(PByte(self.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
        data := pointer(PByte(node) + lenNode);
        if data.vid = vvEvntList then
        begin
          data.DataPos := data.DataPos - deltaBuf;
        end;
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
      end;
    end
    else
    begin
      //PregledColl.Capacity := 1000000;
      while linkPos <= FPosLinkData do
      begin
        Inc(linkPos, LenData);
        node := pointer(PByte(self.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured];  // zzzzzzzzzzzzzzzzzzz за опция за редове
        //Exclude(node.States, vsInitialized);
        data := pointer(PByte(node) + lenNode);
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
      end;
    end;
  end;


  //pCardinalData := pointer(PByte(self.Buf));
//  pCardinalData^ := linkpos;
  node := pointer(PByte(self.Buf) + 100);

  FVTR.InternalConnectNode_cmd(node, FVTR.RootNode, FVTR, amAddChildFirst);
  FVTR.BufLink := self.Buf;
  //node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
  //vtrPregledPat.InternalDisconnectNode(node, false);
  pCardinalData := pointer(PByte(self.Buf) + 8);
  pCardinalData^ := Cardinal(FVTR.RootNode);
  FVTR.UpdateVerticalScrollBar(true);
  FVTR.EndUpdate;
  //vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
  //self.FVTR := FVTR;
  //AspectsLinkPatPregFile.FStreamCmdFile := streamCmdFile;
//  FDBHelper.AdbLink := AspectsLinkPatPregFile;
//  FmxProfForm.AspLink := AspectsLinkPatPregFile;
  //mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrPregledPat.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));
end;



procedure TMappedLinkFile.PopulateSearchPopup(Menu: TPopupMenu);
var
  key: UInt64;
  bucket: TList<PVirtualNode>;
  node: PVirtualNode;
  asp: PAspRecFilter;
  coll: TBaseCollection;
  item: TMenuItem;
begin
  Menu.Items.Clear;

  for key in PathIndex.Keys do
  begin
    bucket := PathIndex[key];
    if (bucket = nil) or (bucket.Count = 0) then
      Continue;

    node := bucket[0];
    if not(vsVisible in node.States) then
      Continue;

    asp := PAspRecFilter(PByte(node) + lenNode);
    if asp.CollType = ctAspect then
      Continue;

    //coll := GetCollectionByType(asp.CollType); //zzzzzzzzzzzzzzzzzzzzzzzzzzz
    if coll = nil then
      Continue;

    item := TMenuItem.Create(Menu);
    //item.Caption := coll.NameForUI;  //zzzzzzzzzzzzzzzzzzzzzzzzzz
    item.Tag := NativeInt(coll);
    item.OnClick := InternalMenuItemClick; // вътрешен метод
    Menu.Items.Add(item);
  end;
end;


{ TFileCMDStream }

procedure TFileCMDStream.AnswWhoAreYou(Socket: TCustomWinSocket);
var
  stream: TMemoryStream;
  pMem: Pointer;
  size: Cardinal;
  AspectRole: TAspectRole;
begin
  stream := TMemoryStream.create;
  size := 106;
  stream.Size := size;

  stream.Position := 0;
  AspectRole := arNomenNzis;
  stream.Write(AspectRole, 2);
  stream.Write(size, 4);
  Self.Position := 0;
  stream.CopyFrom(Self, 100);
  Self.Position := Self.Size;
  stream.Position := 0;
  Socket.SendStream(stream);
end;

procedure TFileCMDStream.CopyFromCmdStream(cmdStream: TCommandStream; SendToAspect: Boolean);
begin
  cmdStream.Len := cmdStream.Size;
  Self.CopyFrom(cmdStream, 0);
  if SendToAspect then
  begin
    if scktClient = nil then
    begin
      InitAspectConnection;
    end;
  end;
end;

constructor TFileCMDStream.Create(const AFileName: string; Mode: Word);
begin
  inherited  Create(AFileName, Mode);
end;

destructor TFileCMDStream.destroy;
begin
  if scktClient <> nil then
  begin
    scktClient.Active := False;
  end;
  FreeAndNil(ClientServerStream);
  FreeAndNil(scktClient);
  inherited;
end;

procedure TFileCMDStream.EndOfRead;
var
  ADataPos: Cardinal;
begin
  self.ClientServerStream.Position := 0;
  if Self.FAspectDataPos = 0 then //
  begin
    self.ClientServerStream.Read(self.FAspectDataPos, 4);
    Self.Position := 0;
    Self.Write(self.FAspectDataPos, 4);
    Self.Position := Self.Size;
  end;


  self.ClientServerStream.Size := 0;
end;

procedure TFileCMDStream.InitAspectConnection;
var
  data: PAspRec;

begin
  scktClient := TClientSocket.Create(nil);

  scktClient.Active := False;
  scktClient.Address := '127.0.0.1';
  scktClient.ClientType := ctNonBlocking;

  scktClient.Port := 3333;
  scktClient.OnRead := scktClientRead;
  scktClient.OnDisconnect := scktDisconect;
  scktClient.Active := True;
  ClientServerStream := TMemoryStream.Create;
end;

procedure TFileCMDStream.scktClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  BytesReceived: Longint;
  ChunkSize: Integer;
  PMem: Pointer;
  sz: Cardinal;
  ServerResp: TServerResponse;
const
  MaxChunkSize: Longint = 8192;
begin
  if (Socket.ReceiveLength = 2) and (ClientServerStream.Size = 0) then
  begin  // това са някакви въпроси от сървъра. Да не е луд да праща малко иначе. Може да са 2 за завършване на ... затова има проверка на стрийма
    Socket.ReceiveBuf(ServerResp, 2);
    case ServerResp of
      srWhoAreYou:
      begin
        AnswWhoAreYou(Socket);
      end;
    end;
    Exit;
  end;

  ChunkSize:= Socket.ReceiveLength;
  If ChunkSize > MaxChunkSize then
    ChunkSize:= MaxChunkSize;

  sz := ClientServerStream.Size;
  ClientServerStream.Size := ClientServerStream.Size + ChunkSize;
  pMem := pointer(PByte(ClientServerStream.Memory) + sz);
  BytesReceived:= Socket.ReceiveBuf(pMem^,ChunkSize);
  if Socket.ReceiveLength = 0 then
  begin
    EndOfRead;
  end;
end;

procedure TFileCMDStream.scktDisconect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  //
end;

procedure TFileCMDStream.SetGuid(const Value: TGUID);
var
  SavePos: Cardinal;
begin
  FGuid := Value;
  SavePos := Self.Position;
  Self.Position := 16;
  self.write(FGuid,16);

  Self.Position := SavePos;
end;

end.
