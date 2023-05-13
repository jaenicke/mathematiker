unit umandelbrot;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    Label1: TLabel;
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
const
    superfarben: array[0..29] of longint =
         ($00000000,$00800000,$000000FF,$00FF00FF,$00008000,$00800080,$0000FFFF,$00404040,
          $0000FF00,$00cccccc,$00808080,$00ff0000,$00000080,$00ffff00,$00008080,$00c0c0c0,
          $00808000,$000000c0,$0000c000,$00c00000,$0000c0c0,$00c000c0,$00c0c000,$00FFFFCC,
          $00CCFFFF,$00CCFFCC,$00CCCCFF,$00ffffff,$00cccc99,$00123456);

procedure TForm1.Button1Click(Sender: TObject);
var  bitmap:tbitmap;
     x,y,xneu,cx,cy,xa,ya,xbreite,yhoehe:double;
     i,j,iterationen,anzahl:integer;
     bildbreite,bildhoehe:integer;
begin
  //Bitmap herstellen
  bitmap:=tbitmap.Create;
  bitmap.Width:=paintbox1.Width;
  bitmap.Height:=paintbox1.Height;
  //Startwerte links und unten + Intervallbreite x und y
  xa:=-2.5;
  ya:=-1.5;
  xbreite:=4;
  yhoehe:=3;
  //Iterationszahl
  iterationen:=strtoint(edit1.Text);
  //Bildmaße
  bildbreite:=bitmap.Width;
  bildhoehe:=bitmap.Height;
  //Zwei Schleifen i = x und j = y
  for i:=0 to bildbreite do begin
    for j:=0 to bildhoehe do begin  //Achtung y läuft von oben nach unten
      //Koordinate des Punktes ermitteln, d.h. cx und cy
      cx:=i*xbreite/bildbreite + xa;
      cy:=j*yhoehe/bildhoehe + ya;
      //Berechnungen
      anzahl:=0;                    //Iterationszähler
      x:=0;                         //Startkoordinate (0,0)
      y:=0;
      repeat
        xneu:=x*x-y*y+cx;           //Realteil
        y:=2*x*y+cy;                //Imaginärteil
        x:=xneu;
        inc(anzahl);                //durchgeführte Iterationen
      until (x*x+y*y>4) or (anzahl>=iterationen);  //Abruch bei |z|>2
      //Farbe auswählen
      bitmap.Canvas.Pixels[i,j]:=superfarben[anzahl mod 30];
    end;
    //Zwischenanzeige des schon berechneten Bildes
    if i mod 100 = 0 then begin
      paintbox1.Canvas.draw(0,0,bitmap);
      application.ProcessMessages;
    end;
  end;
  //Bitmap kopieren
  paintbox1.Canvas.draw(0,0,bitmap);
  //Bitmap wieder löschen
  bitmap.Free;
end;

end.
