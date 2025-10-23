unit uFuzzyMatch;

interface

uses
  System.SysUtils, System.Math, System.Generics.Collections, System.Classes;

type
  TFuzzyMatchResult = record
    BestMatch: string;
    SimilarityScore: Double; // от 0.0 до 1.0
  end;

function LevenshteinDistance(const S, T: string): Integer;
function StringSimilarity(const S1, S2: string): Double;
function FindBestMatch(const Query: string; const Candidates: TArray<string>): TFuzzyMatchResult;
function FindBestMatchNasMesto(const Query: string; const obsht: TObject): TFuzzyMatchResult;

implementation
uses
  RealNasMesto;

function LevenshteinDistance(const S, T: string): Integer;
var
  d: array of array of Integer;
  n, m, i, j, cost: Integer;
begin
  n := Length(S);
  m := Length(T);
  if n = 0 then Exit(m);
  if m = 0 then Exit(n);

  SetLength(d, n + 1, m + 1);

  for i := 0 to n do
    d[i, 0] := i;
  for j := 0 to m do
    d[0, j] := j;

  for i := 1 to n do
    for j := 1 to m do
    begin
      if S[i] = T[j] then
        cost := 0
      else
        cost := 1;
      d[i, j] := Min(Min(d[i - 1, j] + 1, d[i, j - 1] + 1), d[i - 1, j - 1] + cost);
    end;

  Result := d[n, m];
end;

function StringSimilarity(const S1, S2: string): Double;
var
  dist, maxLen: Integer;
begin
  if (S1 = '') and (S2 = '') then Exit(1.0);
  maxLen := Max(Length(S1), Length(S2));
  if maxLen = 0 then Exit(1.0);
  dist := LevenshteinDistance(LowerCase(S1), LowerCase(S2));
  Result := 1.0 - (dist / maxLen);
  if Result < 0 then
    Result := 0;
end;

function FindBestMatch(const Query: string; const Candidates: TArray<string>): TFuzzyMatchResult;
var
  s: string;
  bestScore, score: Double;
  bestMatch: string;
begin
  bestMatch := '';
  bestScore := 0.0;

  for s in Candidates do
  begin
    score := StringSimilarity(Query, s);
    if score > bestScore then
    begin
      bestScore := score;
      bestMatch := s;
    end;
  end;

  Result.BestMatch := bestMatch;
  Result.SimilarityScore := bestScore;
end;

function FindBestMatchNasMesto(const Query: string; const obsht: TObject): TFuzzyMatchResult;
var
  s: TRealNasMestoItem;
  bestScore, score: Double;
  bestMatch: string;
  Obshtina: TRealObshtinaItem;
begin
  bestMatch := '';
  bestScore := 0.0;
  Obshtina := TRealObshtinaItem(obsht);
  for s in Obshtina.NasMesta do
  begin
    score := StringSimilarity(Query, AnsiUpperCase(s.NasMestoName));
    if score > bestScore then
    begin
      bestScore := score;
      bestMatch := s.NasMestoName;
    end;
  end;

  Result.BestMatch := bestMatch;
  Result.SimilarityScore := bestScore;
end;

end.

