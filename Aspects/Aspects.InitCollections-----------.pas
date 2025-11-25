unit Aspects.InitCollections;

interface

uses
  System.SysUtils, System.TypInfo, System.Rtti,
  Aspects.Attributes,
  Aspects.Types,
  Aspects.Collections,
  ADB_DataUnit;

type
  TAspectsInitCollections = class
  public
    class procedure Initialize(ADM: TADBDataModule);
  end;

implementation

{ TAspectsInitCollections }

class procedure TAspectsInitCollections.Initialize(ADM: TADBDataModule);
var
  ctx: TRttiContext;
  t: TRttiType;
  attr: TCustomAttribute;
  collAttr: ADBCollection;
  collClass: TBaseCollectionClass;
  coll: TBaseCollection;
  adb: TMappedFile;
  collType: TCollectionsType;
begin
  if ADM = nil then
    raise Exception.Create('TAspectsInitCollections.Initialize: ADM = nil');

  ctx := TRttiContext.Create;

  for t in ctx.GetTypes do
  for attr in t.GetAttributes do
    if attr is ADBCollection then
    begin
      collAttr := ADBCollection(attr);

      collClass := TBaseCollectionClass(t.AsInstance.MetaclassType);
      itemClass := collAttr.ItemClass;

      // Създаваме колекцията
      coll := collClass.Create(itemClass);

      // Регистрираме я
      lstColl[Ord(coll.GetCollType)] := coll;

      // Връзка към правилния ADB-файл
      case collAttr.Source of
        adbMain:
        begin
          coll.Buf := AdbMain.Buf;
          coll.posData := AdbMain.FPosData;
        end;

        adbNomenNzis:
        begin
          coll.Buf := AdbNomenNzis.Buf;
          coll.posData := AdbNomenNzis.FPosData;
        end;

        // ... останалите
      end;
    end;


  ctx.Free;
end;

end.

