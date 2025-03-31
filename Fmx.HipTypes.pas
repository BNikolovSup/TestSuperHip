unit Fmx.HipTypes;

interface
uses
{$IFDEF HAS_VCL}
    Aspects.Types,
{$ENDIF}
FMX.Types;

type
  TFormMode = (fmNone, fmSearch, fmFilter);
{$IFDEF HAS_VCL}
    TOnSetTextSearch = procedure(sender: TObject; VidTable: TVtrVid; Field: word) of object;
{$ENDIF}

implementation

end.
