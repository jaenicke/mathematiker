unit uulam;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PB1: TPaintBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    archimedisch: TCheckBox;
    procedure PB1Paint(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.PB1Paint(Sender: TObject);
const gg:integer=2;
      maxlaenge:integer=360;
var bitmap:tbitmap;
    b,h,i,z,w,maxzahl:integer;
    prim:array of boolean;
procedure ulam;
var gga,dd,w,x,y,z,i:integer;
    wi,gesamtlaenge:real;
procedure zahlzeichnen;
begin
    inc(z);
    if prim[z] then bitmap.canvas.ellipse(b+2*x-gg,h-2*y-gg,b+2*x+gg+1,h-2*y+gg+1);
end;
begin
    bitmap.canvas.pen.color:=clsilver;
    bitmap.canvas.brush.color:=clblue;

    //archimedische Spirale
    if archimedisch.checked then
    begin
      //Länge der archimedischen Spirale ermitteln
      z:=2;
      wi:=0.3;
      repeat
        wi:=wi+0.3/sqrt(wi);
        inc(z);
      until z>maxzahl;
      gesamtlaenge:=wi;

      //Spirale zeichnen
      wi:=0;
      bitmap.canvas.moveto(b,h);
      bitmap.canvas.pen.style:=pssolid;
      repeat
        x:=round(b+gg/2*wi*cos(wi));
        y:=round(h-gg/2*wi*sin(wi));
        bitmap.canvas.lineto(x,y);
        wi:=wi+0.1;
      until wi>gesamtlaenge;

      //Primzahlen eintragen
      bitmap.canvas.pen.style:=psclear;
      gga:=gg;
      //maximale Größe der Kreise einstellen
      if gga>8 then gga:=8;
      z:=2;
      wi:=0.3;
      repeat
        x:=round(b+gg/2*wi*cos(wi));
        y:=round(h-gg/2*wi*sin(wi));
        if prim[z] then bitmap.canvas.ellipse(x-gga,y-gga,x+gga+1,y+gga+1);
        inc(z);
        //Sicherstellen, dass die Bogenlänge zwischen 2 Primzahlen konstant bleibt
        wi:=wi+0.3/sqrt(wi);
      until z>maxzahl;
      exit; //Abbruch bei archimedischer Spirale
    end;

    //Konstruktion der Ulam-Spirale
    x:=0;
    y:=0;
    bitmap.canvas.moveto(b+2*x,h-2*y);
    dd:=gg;
    bitmap.canvas.pen.style:=pssolid;
    repeat
      //noch oben
      inc(y,dd);
      bitmap.canvas.lineto(b+2*x,h-2*y);
      //noch rechts
      inc(x,dd);
      bitmap.canvas.lineto(b+2*x,h-2*y);
      inc(dd,gg);
      //noch unten
      dec(y,dd);
      bitmap.canvas.lineto(b+2*x,h-2*y);
      //nach links
      dec(x,dd);
      bitmap.canvas.lineto(b+2*x,h-2*y);
      inc(dd,gg);
    until dd>maxlaenge; //maximale Länge einer Spiralenstrecke

    //Eintragen der Primzahlen
    bitmap.canvas.pen.style:=psclear;
    x:=0;
    y:=0;
    z:=0;
    //Start mit Zahl 1
    zahlzeichnen;
    w:=1;
    //nach jeweils 2 Schritten oben,rechts,unten,links
    //verlängert sich die Spiralstrecke um gg Länge und 1 Zahl
    repeat
      //w Zahlen nach oben testen
      i:=1;
      repeat inc(y,gg); zahlzeichnen; inc(i); until i>w;
      //w Zahlen nach rechts testen
      i:=1;
      repeat inc(x,gg); zahlzeichnen; inc(i); until i>w;
      inc(w);
      //w Zahlen nach unten testen
      i:=1;
      repeat dec(y,gg); zahlzeichnen; inc(i); until i>w;
      //w Zahlen nach links testen
      i:=1;
      repeat dec(x,gg); zahlzeichnen; inc(i); until i>w;
      inc(w);
    until w>maxlaenge div gg;
end;
begin
    gg:=strtoint(edit1.text);
    maxlaenge:=strtoint(edit2.text);
    maxzahl:=round((maxlaenge/gg+2)*((maxlaenge/gg+2)+1));

    //Primzahlsieb
    setlength(prim,maxzahl+1);
    for i:=0 to maxzahl do prim[i]:=true;
    //gerade Zahlen >2 ausfiltern
    for i:=2 to maxzahl div 2 do prim[i+i]:=false;
    prim[1]:=false;
    z:=3;
    repeat
      w:=z+z;
      repeat
        prim[w]:=false;
        w:=w+z;
      until w>maxzahl;
      inc(z,2);
      while prim[z]=false do inc(z,2);
    until z>sqrt(maxzahl);

    bitmap:=tbitmap.create;
    bitmap.width:=PB1.width;
    bitmap.height:=PB1.height;
    b:=bitmap.width div 2;
    h:=bitmap.height div 2;
    //Linienabstand
    //Spirale
    ulam;

    PB1.canvas.draw(0,0,bitmap);
    bitmap.free;
    setlength(prim,0);
end;

end.
