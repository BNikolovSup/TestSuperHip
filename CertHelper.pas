unit CertHelper;
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.Math,

  SBStrUtils, SBConstants, SBX509, SBX509Ext, SBPKCS12, SBCustomCertStorage, SBWinCertStorage,
  SBRDN, SBMessages, SBTypes, SBUtils, SBAlgorithmIdentifier ;



function BuildHexString(St : ByteArray) : string;
function BuildHexString1(St : TArray<System.Byte>) : string;
function BuildByteArray(Str : string) : TArray<System.Byte>;


implementation

function BuildHexString(St : ByteArray) : string;
var i : integer;
begin
  Result:='';
  for I := Length(St) - 1 downto 0 do
    Result := Result + IntToHex(St[i], 2);
end;

function BuildByteArray(Str : string) : TArray<System.Byte>;
var
  i : integer;
  b: Byte;
  bs: string;
begin
  SetLength(Result,  Length(Str) div 2);
  for I := Length(Result) - 1 downto 0 do
  begin
    bs := Copy(Str, i*2, 2 );
    Result[i] := StrToInt('$' + bs);
  end;
end;

function BuildHexString1(St : TArray<System.Byte>) : string;
var i : integer;
begin
  Result:='';
  for I := Length(St) - 1 downto 0 do
    Result := Result + IntToHex(St[i], 2);
end;

end.
