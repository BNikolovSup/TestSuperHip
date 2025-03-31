unit StatusItem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, System.ImageList, FMX.ImgList, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type
  TfrmStatusItem = class(TForm)
    rctngl1: TRectangle;
    btn1: TSpeedButton;
    imgList1: TImageList;
    fltnmtn1: TFloatAnimation;
    crcl1: TCircle;
    txt1: TText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatusItem: TfrmStatusItem;

implementation

{$R *.fmx}

end.
