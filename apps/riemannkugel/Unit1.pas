unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, jpeg;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    Image1: TImage;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const bb=960;
var i,j,waagerecht,senkrecht:integer;
    xk,yk,q,xi,yi,sq:double;
    xm,ym:integer;
    bitmap,bitmap2,bitmapz:tbitmap;
    rect:trect;
    P : PByteArray;
procedure ladejpg(const FileName: String; Bild: TBitMap);
var Jpeg: TJpegImage;
begin
  Jpeg:=TJpegImage.Create;
  jpeg.LoadFromFile(filename);
  Bild.Assign(Jpeg);
  jpeg.free;
end;
begin
   //Verschiebung des Spiegelsmittelpunkts
   ladejpg(combobox1.text+'.jpg',image1.Picture.Bitmap);
   application.ProcessMessages;
   waagerecht:=spinedit1.value;
   senkrecht:=spinedit2.value;
   bitmap2:=tbitmap.create;
   bitmap2.assign(image1.Picture.Bitmap);
   bitmap2.PixelFormat:=pf32bit;

   bitmap:=tbitmap.Create;
   bitmap.width:=bb;
   bitmap.height:=bb;
   //Abbildung auf doppelte Größe strecken
   rect.left:=0;
   rect.Top:=0;
   rect.right:=bb;
   rect.Bottom:=bb;
   bitmap.canvas.copyrect(rect,bitmap2.Canvas,image1.clientrect);
   //Mittelpunkt
   xm:=paintbox1.Width div 2;
   ym:=paintbox1.height div 2;

   bitmapz:=tbitmap.Create;
   bitmapz.Width:=paintbox1.Width;
   bitmapz.height:=paintbox1.height;
   bitmapz.PixelFormat:=pf32bit;

   bitmapz.Canvas.Brush.Color:=clwhite;
   bitmapz.Canvas.Rectangle(-1,-1,961,961);
   //zeilenweise pixel ermitteln
   for i:=0 to bb-1 do begin
     P := BitMap.ScanLine[i];
     yi:=(2*i-senkrecht)/bb;
     for j:=0 to bb-1 do begin
       //Umwandeln in komplexe Koordinaten
       xi:=(2*j-waagerecht)/bb;
       //Transformation auf die Riemann-Kugel
       sq := sqr(xi)+sqr(yi);
       //nur zeichnen, wenn in unterer Hälfte der Riemann-Kugel
       if sq<1.0 then begin
         q:=1+xi*xi+yi*yi;
//         xk:=xi/q;
//         yk:=yi/q;
         bitmapz.Canvas.pixels[trunc(xm+480*xi/q),trunc(ym+480*yi/q)]:=rgb(p[4*j+2],p[4*j+1],p[4*j]);
//         bitmapz.Canvas.pixels[trunc(xm+480*xk),trunc(ym+480*yk)]:=p[j];
       end;
     end;
     paintbox1.Canvas.Draw(0,0,bitmapz);
   end;
   bitmap.free;
   bitmap2.free;
   bitmapz.free;
end;

end.
