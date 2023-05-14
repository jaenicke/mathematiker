unit Unit1;
interface
uses Windows, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls;

type
  TfrmNegative = class(TForm)
    panBottom: TPanel;
    imgApple: TImage;
    btnConvert: TButton;
    Button1: TButton;
    procedure Convert(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

var frmNegative : TfrmNegative;

implementation
{$R *.dfm}

procedure TfrmNegative.Convert(Sender: TObject);
var color,blue,green,red,i,j : integer;
begin
  Screen.Cursor := crHourglass;
  for i:=0 to imgApple.Width-1 do
    for j:=0 to imgApple.Height-1 do begin
      color := imgApple.Canvas.Pixels[i,j];
      red := color and 255;                        // letzte 8 Bit
      green := (color and 65535) shr 8;            // mittl. 8 Bit
      blue := color shr 16;                        // ersten 8 Bit
      red := 255 - red;
      green := 255 - green;
      blue := 255 - blue;
      imgApple.Canvas.Pixels[i,j] := 65536*blue + 256*green + red;
      //imgApple.Canvas.Pixels[i,j] := 16777215 - imgApple.Canvas.Pixels[i,j];
    end;
  Screen.Cursor := crDefault;
end;

procedure TfrmNegative.Button1Click(Sender: TObject);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  imgApple.Picture.Bitmap.PixelFormat := pf24bit;
  for j := 0 to imgApple.Picture.Bitmap.Height-1 do begin
    row := imgApple.Picture.Bitmap.Scanline[j];
    for i := 0 to imgApple.Picture.Bitmap.Width-1 do begin
      row^.rgbtred   := 255-row^.rgbtred;
      row^.rgbtBlue  := 255-row^.rgbtblue;
      row^.rgbtgreen := 255-row^.rgbtgreen;
      inc(row);
    end;
  end;
  imgApple.invalidate;
end;

end.
