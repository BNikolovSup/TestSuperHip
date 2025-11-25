unit FastSearch;

interface
uses
  System.SysUtils;

type
  TSearchMode = (smExact, smStartsWith, smContains);
  TCaseMode = (cmCaseSensitive, cmCaseInsensitive);

procedure BuildLowerMap(var M: array of Byte);
procedure BuildBMHTable(const pat: PAnsiChar; patLen: Integer; out table: array of Integer);
function ExactMatchFast(pData: PAnsiChar; dataLen: Integer; pat: PAnsiChar; patLen: Integer; caseMode: TCaseMode): Boolean;
function StartsWithFast(pData: PAnsiChar; dataLen: Integer; pat: PAnsiChar; patLen: Integer; caseMode: TCaseMode): Boolean;
function ContainsBMHFast(pData: PAnsiChar; dataLen: Integer; pat: PAnsiChar; patLen: Integer; caseMode: TCaseMode; const badChar: array of Integer): Boolean;

implementation

uses
  System.Types, Windows;

procedure BuildLowerMap(var M: array of Byte);
var
  i: Integer;
begin
  for i := 0 to 255 do
    // simple ASCII lower; for non-ASCII leaves as-is — matches your ADB which is likely ANSI/CP1251
    if (i >= Ord('A')) and (i <= Ord('Z')) then
      M[i] := Byte(Chr(i + 32))
    else
      M[i] := Byte(i);
end;

// Build bad-char table for BMH
procedure BuildBMHTable(const pat: PAnsiChar; patLen: Integer; out table: array of Integer);
var
  i: Integer;
begin
  // initialize with patLen
  for i := Low(table) to High(table) do
    table[i] := patLen;
  // fill with rightmost positions
  for i := 0 to patLen - 2 do
    table[Byte(pat[i])] := patLen - 1 - i;
end;

// exact comparison (fast) - case sensitive or insensitive using map
function ExactMatchFast(pData: PAnsiChar; dataLen: Integer; pat: PAnsiChar; patLen: Integer; caseMode: TCaseMode): Boolean;
  var
i: Integer;
lb: array[0..255] of Byte;
begin
  Result := False;
  if (pData = nil) or (pat = nil) then Exit;
  if dataLen <> patLen then Exit;
  if caseMode = cmCaseSensitive then
  begin
    Result := CompareMem(pData, pat, patLen);
  end
  else
  begin
    // byte-per-byte lowercase compare via small table (local static)
    // to keep zero allocations we use inline map


    BuildLowerMap(lb);
    for i := 0 to patLen - 1 do
      if lb[Byte(pData[i])] <> lb[Byte(pat[i])] then
        Exit(False);
    Result := True;
  end;
end;

// startsWith - very cheap
function StartsWithFast(pData: PAnsiChar; dataLen: Integer; pat: PAnsiChar; patLen: Integer; caseMode: TCaseMode): Boolean;
var
i: Integer;
     lb: array[0..255] of Byte;
begin
  Result := False;
  if (pData = nil) or (pat = nil) then Exit;
  if patLen > dataLen then Exit;
  if caseMode = cmCaseSensitive then
    Result := CompareMem(pData, pat, patLen)
  else
  begin

    BuildLowerMap(lb);
    for i := 0 to patLen - 1 do
      if lb[Byte(pData[i])] <> lb[Byte(pat[i])] then
        Exit(False);
    Result := True;
  end;
end;

// contains using Boyer-Moore-Horspool
function ContainsBMHFast(pData: PAnsiChar; dataLen: Integer; pat: PAnsiChar; patLen: Integer; caseMode: TCaseMode; const badChar: array of Integer): Boolean;
var
  i, j, shift: Integer;
  patLast: Integer;
  lb: array[0..255] of Byte;
begin
  Result := False;
  if (pData = nil) or (pat = nil) then Exit;
  if patLen = 0 then Exit(True);
  if patLen > dataLen then Exit(False);

  patLast := patLen - 1;
  if caseMode = cmCaseSensitive then
  begin
    i := 0;
    while i <= dataLen - patLen do
    begin
      // compare last char first
      if pData[i + patLast] = pat[patLast] then
      begin
        // verify whole
        j := 0;
        while (j < patLen) and (pData[i + j] = pat[j]) do Inc(j);
        if j = patLen then Exit(True);
      end;
      shift := badChar[Byte(pData[i + patLast])];
      Inc(i, shift);
    end;
    Exit(False);
  end
  else
  begin
    BuildLowerMap(lb);
    i := 0;
    while i <= dataLen - patLen do
    begin
      if lb[Byte(pData[i + patLast])] = lb[Byte(pat[patLast])] then
      begin
        j := 0;
        while (j < patLen) and (lb[Byte(pData[i + j])] = lb[Byte(pat[j])]) do Inc(j);
        if j = patLen then Exit(True);
      end;
      shift := badChar[Byte(pData[i + patLast])];
      Inc(i, shift);
    end;
    Exit(False);
  end;
end;

end.

