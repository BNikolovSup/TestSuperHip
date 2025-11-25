unit uFilterTreeLoader;

interface

uses
  System.SysUtils, System.Classes, VirtualTrees,
  Aspects.Types, Aspects.Collections, VirtualStringTreeAspect;

const
  DEFAULT_LINKFILTERS_SIZE = 2000000; // 2 MB by default, лесно сменяш

type
  TFilterTreeLoader = class
  public
    class function LoadLinkFilters(const AFileName: string;
      AFilterTree: TVirtualStringTreeAspect;
      out ALinkFile: TMappedLinkFile;
      ADesiredSize: Int64 = DEFAULT_LINKFILTERS_SIZE): Boolean;
  end;

implementation

{ TFilterTreeLoader }

class function TFilterTreeLoader.LoadLinkFilters(const AFileName: string;
  AFilterTree: TVirtualStringTreeAspect; out ALinkFile: TMappedLinkFile;
  ADesiredSize: Int64): Boolean;
var
  fs: TFileStream;
  linkPos: Cardinal;
  vRoot: PVirtualNode;
  pCardinalData: PCardinal;
begin
  Result := False;
  ALinkFile := nil;

  if Assigned(AFilterTree) = False then
    Exit;

  // Ако вече е отворен — затваряме го (caller трябва да е сигурен)
  if FileExists(AFileName) then
  begin
    // отваряме като read-only mapped (false) — TMappedLinkFile ще се грижи за OpenLinkFile
    ALinkFile := TMappedLinkFile.Create(AFileName, False, TGUID.Empty);
    ALinkFile.FVTR := AFilterTree;
  end
  else
  begin
    // създаваме празен файл с желан размер
    fs := TFileStream.Create(AFileName, fmCreate);
    try
      fs.Size := ADesiredSize;
    finally
      fs.Free;
    end;

    // създаваме мап файла (create = true) и записваме началния root
    ALinkFile := TMappedLinkFile.Create(AFileName, True, TGUID.Empty);
    try
      ALinkFile.FVTR := AFilterTree;

      // създаваме root node (на offset = 100)
      linkPos := 100;
      ALinkFile.AddNewNode(vvRootFilter, 0, AFilterTree.RootNode, amAddChildLast, vRoot, linkPos);

      // bootstrap: запазваме някои пойнтъри в header, по подобие на твоя пример
      // (тук приемаме, че ALinkFile.Buf е валидна и поне 12 байта)
      if Assigned(ALinkFile.Buf) then
      begin
        // [4] <- base ptr to buffer (по твоя код)
        pCardinalData := Pointer(PByte(ALinkFile.Buf) + 4);
        pCardinalData^ := Cardinal(ALinkFile.Buf);

        // [8] <- pointer to root node structure (понеже VirtualTree root node pointer)
        pCardinalData := Pointer(PByte(ALinkFile.Buf) + 8);
        pCardinalData^ := Cardinal(AFilterTree.RootNode);
      end;

      AFilterTree.InternalDisconnectNode(AFilterTree.RootNode.FirstChild, false);

      // Освобождаваме и след това отваряме в нормален режим (read-only mapping)
      ALinkFile.Free;
      ALinkFile := TMappedLinkFile.Create(AFileName, False, TGUID.Empty);
      ALinkFile.FVTR := AFilterTree;
    except
      ALinkFile.Free;
      ALinkFile := nil;
      raise;
    end;
  end;

  // гарантираме, че map файла е отворен и дървото е инициализирано
  if Assigned(ALinkFile) then
  begin
    // OpenLinkFile ще реконструира VST възлите спрямо map буфера
    ALinkFile.OpenLinkFile;
    Result := True;
  end;
end;

end.

