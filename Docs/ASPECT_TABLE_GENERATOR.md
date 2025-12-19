**🧩 ASPECT TABLE GENERATOR - Кратка, но Пълна Документация**

**📌 1. Цел на генератора**

Aspect Table Generator автоматично създава _генерирани класове_ (файлове .pas2), които:

**✔ описват бизнес-таблици / АДБ колекции**

**✔ наследяват TBaseItem и TBaseCollection**

**✔ съдържат целия boilerplate-код за:**

- работа с рекордите (Record Layout)
- индексни полета
- зареждане/запис в ADB файл
- работа с TeeGrid
- филтриране / търсене
- сравнения
- сортиране
- сериализация
- импорт на данни (ReadCmd, FillProp…)

Така реалните класове (наследниците) се концентрират само върху бизнес логиката.

**📌 2. Входни данни за генератора**

Генераторът използва 3 основни входа:

**2.1. DDL файл (.ddl)**

Пример:

AMB_LISTN=integer

GS=word

...

Logical=tLogicalSet:IS_NEW,IS_EMERGENCY, ...

DDL дефинира:

- полета
- типове
- логически флагове
- техния ред (важен за record layout)
- имената за PropertyIndex

**2.2. Template.tmp**

Шаблон с placeholders:

!TableName!

!FieldCount!

!TRec!

!PropertyIndex!

!ProcInsert!

!ProcFillProp!

...

Генераторът заменя тези placeholder-и със сгенериран код.

**2.3. MainGenerator.pas**

Съдържа:

- всички "getProc…" функции
- код за зареждане на DDL
- изчисляване на логикал размер (logSizeStr)
- попълване на vlsProp
- BuildPass2 (основният метод)
- механика за произвеждане на финалния .pas2

**📌 3. Какво генерира Table Generator-ът?**

Генераторът създава два класа:

T&lt;TableName&gt;Item = class(TBaseItem)

T&lt;TableName&gt;Coll = class(TBaseCollection)

**🧱 4. Структура на генерирания Item-клас**

**✔ 4.1. Record структура**

Генерира се:

type

TRec&lt;TableName&gt; = record

&lt;всички полета&gt;

setProp: TSetProp;

Logical: Tlogical&lt;TableName&gt;Set;

end;

**✔ 4.2. PropertyIndex enum**

TPropertyIndex = (

&lt;Field1&gt;,

&lt;Field2&gt;,

...

&lt;LogicalField&gt;

);

**✔ 4.3. Генерирани методи в Item**

| **Метод** | **Роля** |
| --- | --- |
| **Create / Destroy** | алокация/освобождаване на PRecord |
| **FillPRecord** | динамично попълване по стойности |
| **Insert&lt;Table&gt;** | записване в ADB при нов запис |
| **Save&lt;Table&gt;** | записване при редакт. |
| **Update&lt;Table&gt;** | актуализация на ADB header/data |
| **IsFullFinded** | проверка за match според search-условия |
| **GetPRecord** | връща pointer към record |
| **ReadCmd** | чете структури от командния файл |
| **FillProp&lt;Table&gt;** | попълва конкретно поле от stream |

**📌 5. Структура на генерирания Coll-клас**

T&lt;TableName&gt;Coll = class(TBaseCollection)

**Основни автоматично генерирани части:**

**✔ 5.1. Работа с елементи**

function AddItem(ver): T&lt;TableName&gt;Item;

function GetItem(i);

procedure SetItem(i, value);

**✔ 5.2. Index-системи**

Генераторът прави:

- IndexInt
- IndexWord
- IndexAnsiStr
- и методи:
  - SortByIndexInt
  - SortByIndexWord
  - SortByIndexAnsiString
  - SortByIndexValue

**✔ 5.3. Грид поддръжка**

Генерират се:

- ShowGrid
- GetCell
- SetCell
- FieldCount
- DisplayName
- PropType
- OrderFieldsSearch1
- GetCellFromMap
- GetCellFromRecord

**✔ 5.4. Търсене / филтриране**

Генераторът добавя:

- ListForFinder
- List&lt;TableName&gt;Search
- ArrPropSearch
- ArrPropSearchClc

и методи:

- OnSetTextSearchEDT
- OnSetNumSearchEDT
- OnSetDateSearchEDT
- OnSetLogicalSearchEDT
- IsFullFinded
- SetSearchingValue

**✔ 5.5. Visibility / Options Tree**

Генерира:

- FindRootCollOptionNode
- FindSearchFieldCollOptionNode
- ApplyVisibilityFromTree

**📌 6. „getProc" функции (сърцето на генератора)**

В MainGenerator има функции:

- getProcInsert
- getProcSave
- getProcUpdate
- getProcIndexValue
- getProcCellFromRecord
- getProcCellFromMap
- getProcPropType
- getProcSetCell
- getProcCompareOldCell
- getProcCompareOldField
- **и новите:**
  - getProcReadCmd
  - getProcFillProp

Всяка от тези функции връща string или TStringList с готов Delphi-код за вмъкване в шаблона.

**📌 7. Логически полета (tLogicalSet)**

Генераторът изчислява:

- брой флагове
- необходимия byte-size
- тип TLogicalDataNN

и вмъква:

Logical=tLogicalSet:FLAG1,FLAG2,...

в:

- TPropertyIndex
- TRec
- FillProp / ReadCmd
- Insert/Save section

**📌 8. Output на генератора**

Файлове .pas2, винаги съдържащи:

- генерираните класове
- коментар „Generated from &lt;DDL name&gt;"
- всички секции попълнени динамично

Ти сравняваш .pas2 със .pas и пренасяш само полезните промени.

**📌 9. Жизнен цикъл**

- Зареждане на DDL
- Попълване на vlsProp
- Изчисляване на логикален размер
- Заместване на placeholders в Template.tmp
- Извикване на _getProc…_ функции
- Генериране на .pas2

**📌 10. Обобщение - какво прави генераторът?**

**✔ Генерира boilerplate код за АДБ колекции**

**✔ Премахва 95% от copy/paste грешките**

**✔ Поддържа индексни полета и сортировки**

**✔ Поддържа търсене, филтри, TeeGrid**

**✔ Поддържа билдване на record layouts**

**✔ Поддържа командни операции (ReadCmd, FillProp)**

**✔ Автоматично адаптира логически полета**

**✔ Генерира типове според DDL**

**✔ Е изцяло разширяем чрез _getProc_ функции**