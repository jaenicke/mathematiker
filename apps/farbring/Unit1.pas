unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
uses Windows, SysUtils,Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls;
const ri = 75; ra = 100;
type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    panDown: TPanel;
    panColor: TPanel;
    procedure Init(Sender: TObject);
    procedure Ring(Sender: TObject);
    procedure Square(Sender:TObject; Button:TMouseButton; Shift:TShiftState; x,y:integer);
    procedure GetRGB(Sender:TObject; Shift:TShiftState; x,y:integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    xm,ym : integer;
    BkColor : Tcolor;
    bm : TBitmap;
  end;
var Form1: TForm1;

implementation
{$R *.dfm}

procedure TForm1.Init(Sender: TObject);
begin
  xm := PaintBox1.Width div 2;
  ym := PaintBox1.Height div 2;
  bm := TBitmap.Create;
  bm.Width := 2*xm;
  bm.Height := 2*ym;
  bm.Canvas.Brush.Color := clBtnFace;
  bm.Canvas.Rectangle (0, 0, bm.Width, bm.Height);
  bm.Canvas.Brush.Style := bsClear;                          // keine Füllfarbe
end;

procedure TForm1.Ring(Sender: TObject);
var Red,Green,Blue : integer;
       f,r,dx,dy,w : integer;
                 a : double;
begin
  BkColor := Paintbox1.Canvas.Pixels [xm,ym];         // Hintergrundfarbe merken
  for r:=ri to ra do begin
    a := 0;
    repeat
      dx := round (r*sin(a));
      dy := round (r*cos(a));
      w := trunc(3*a/pi);
      f := round(3*255/pi*(a-w*pi/3));  
      case w of
        0 : begin Red := 255; Green := 0; Blue := f end;
        1 : begin Red := 255-f; Green := 0; Blue := 255 end;
        2 : begin Red := 0; Green := f; Blue := 255 end;
        3 : begin Red := 0; Green := 255; Blue := 255-f end;
        4 : begin Red := f; Green := 255; Blue := 0 end;
       else begin Red := 255; Green := 255-f; Blue := 0 end;
      end;
      bm.Canvas.Pixels [xm+dx, ym-dy] := 65536*Blue + 256*Green + Red;
      a := a + 0.005;
    until a > 2*pi;
  end;
  PaintBox1.Canvas.Draw (0,0,bm);
end;

procedure TForm1.Square(Sender:TObject; Button:TMouseButton; Shift:TShiftState; x,y:integer);
var a,col,Rot,Gruen,Blau,xo,yo : integer;
                     fx,fy,r,w : double;
begin
  col := Paintbox1.Canvas.Pixels [x,y];
  a := trunc (ri/sqrt(2)) - 1;                 // halbe Seitenlänge des Quadrats
  r := sqrt(sqr(x-xm) + sqr(y-ym));
  if (r >= ri) and (r <= ra)
    then begin                                            // Stelle kennzeichnen
        Ring (sender);
        if y=ym then if x>xm then w := pi/2
                             else w := 3*pi/2
                else begin
                       w := arctan ((x-xm)/(ym-y));
                       if (y<ym) and (x<xm) then w := w + 2*pi;
                       if y>ym then w := w + pi;
                     end;
        xo := xm + round ((ra+ri)/2 * sin(w));
        yo := ym - round ((ra+ri)/2 * cos(w));
        bm.Canvas.Pen.Color := 16777216 - col;
        bm.Canvas.Ellipse (xo-5,yo-5,xo+5,yo+5);
        for x := xm-a to xm+a do                             // Quadrat zeichnen
          for y := ym-a to ym+a do
            begin
              Rot := col and $FF;
              Gruen := (col and $FF00) shr 8;
              Blau := col shr 16;
              // nach rechts werden die Farben satter
              fx :=  (x-xm+a) / (2*a);                            // fx = 0 .. 1
              Rot := round(Rot * fx);
              Gruen := round(Gruen * fx);
              Blau := round(Blau * fx);
              // nach unten werden die Farben immer heller
              fy := 1 - (y-ym+a) / (2*a);                         // fy = 1 .. 0
              Rot := 255 - round((255-Rot)*fy);
              Gruen := 255 - round((255-Gruen)*fy);
              Blau := 255 - round((255-Blau)* fy);
              bm.Canvas.Pixels[x, y] := 65536*Blau + 256*Gruen + Rot;
            end;
            PaintBox1.Canvas.Draw (0,0,bm);
     end
   else if (abs(x-xm) <= a) and (abs(y-ym) <= a) and (col <> BkColor) then begin
     panColor.Color := col;
     PaintBox1.Canvas.Draw (0,0,bm);
     PaintBox1.Canvas.Pen.Color := 16777216 - col;
     PaintBox1.Canvas.Brush.Style := bsClear;
     PaintBox1.Canvas.Ellipse (x-5,y-5,x+5,y+5);
   end;
end;

function Value (w: byte): string;
var s : string[5];
begin
  s := IntToStr (w);
  if w < 100 then s := '  ' + s;
  if w <  10 then s := '  ' + s;
  Value := s;
end;

procedure TForm1.GetRGB(Sender:TObject; Shift:TShiftState; x,y:integer);
var col, Rot,Gruen,Blau : integer;
begin
  col := Paintbox1.Canvas.Pixels [x,y];
  Rot := col and $FF;
  Gruen := (col and $FF00) shr 8;
  Blau := col shr 16;
  if col = BkColor then panDown.Caption := '   '
                   else panDown.Caption := '   R:' + Value(Rot) + '   G:' + Value(Gruen) + '   B:' + Value(Blau);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.Free;
end;

end.
