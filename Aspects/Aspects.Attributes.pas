unit Aspects.Attributes;

{
  Това звено съдържа ВСИЧКИ атрибути, използвани в Аспектската система.
  Атрибутите представляват метаданни върху класове/типове, които задават
  източник на колекция, специално поведение или допълнителна информация.

  Тук НЯМА никакви зависимости към UI, VirtualTree, колекции или други
  тежки модули — това позволява лесна рефлексия и ясна архитектура.
}

interface

uses
  System.SysUtils,
  System.Classes;

type
  // от Aspects.Types
  TADBSource = (adbMain, adbNomenNzis, adbNomenHip, adbNomenNzok);

  {------------------------------------------------------------------------------}
  {  ADBCollection                                                                }
  {  Използва се в декларацията на генерирания клас, за да маркира:              }
  {   - Коя е ITEM-класът                                                         }
  {   - От кой ADB файл чете колекцията                                          }
  {   Пример:                                                                    }
  {     [ADBCollection(TRealPregledNewItem, adbMain)]                             }
  {     TRealPregledNewColl = class(TBaseCollection) ...                         }
  {------------------------------------------------------------------------------}
  ADBCollection = class(TCustomAttribute)
  private
    FItemClass: TClass;
    FSource: TADBSource;
  public
    constructor Create(AItemClass: TClass; ASource: TADBSource = adbMain);

    property ItemClass: TClass read FItemClass;
    property Source: TADBSource read FSource;
  end;


  {------------------------------------------------------------------------------}
  {  ADBIgnore                                                                    }
  {  Маркира свойство/поле, което НЕ трябва да участва в сериализация или        }
  {  обработка от аспектските процеси.                                           }
  {------------------------------------------------------------------------------}
  ADBIgnore = class(TCustomAttribute)
  public
    constructor Create;
  end;


  {------------------------------------------------------------------------------}
  {  ADBComputed                                                                  }
  {  Маркира поле, което ВСЕ още не съществува в ADB файла, а е изчислимо.        }
  {  Използва се за виртуални свойства.                                           }
  {------------------------------------------------------------------------------}
  ADBComputed = class(TCustomAttribute)
  public
    constructor Create;
  end;


implementation

{ ADBCollection }

constructor ADBCollection.Create(AItemClass: TClass; ASource: TADBSource);
begin
  inherited Create;
  FItemClass := AItemClass;
  FSource := ASource;
end;

{ ADBIgnore }

constructor ADBIgnore.Create;
begin
  inherited Create;
end;

{ ADBComputed }

constructor ADBComputed.Create;
begin
  inherited Create;
end;

end.

