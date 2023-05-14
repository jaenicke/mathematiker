unit ureuleaux;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Label1: TLabel;
    UpDown3: TUpDown;
    Edit3: TEdit;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    geschw:integer;
    temp:integer;
    xoffset:integer;
    spurlaenge:integer;
    spur:array of tpoint;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function ein_int(const edit:tedit;a,b:integer):integer;
var kk:string;
    x,code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    if x<a then x:=a;
    if x>b then x:=b;
    edit.text:=inttostr(x);
    ein_int:=x;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    breite,hoehe,rand:integer;
    can:tcanvas;
    z,i,j:integer;
    xx,yy,wert1:integer;
    wi, xp,yp:real;

    kurve,kurve2:array[0..362] of record x,y:extended end;
    bahn:array[0..362] of tpoint;
    ecken:array[0..10] of record x,y:extended end;
    radius,wminimum:extended;
    t360,minimum:integer;

begin
    breite:=paintbox1.width;
    hoehe:=paintbox1.height;

    //Abrollstrekce
    rand:=hoehe-80;

    bitmap:=tbitmap.create;
    bitmap.width:=breite;
    bitmap.height:=hoehe;
    can:=bitmap.canvas;

    //Eckenzahl
    z:=3;
    if radiobutton2.checked then z:=5;

    //Größe der seitenfläche
    wert1:=ein_int(edit1,60,250);
    xoffset:=-2*wert1;
    //Radius der Kreisbögen
    radius:=wert1*sin(180*pi/180*(z div 2)/z)/sin(180*pi/180/z);
    t360:=360 div z;

    can.pen.width:=1;
    can.pen.color:=clblue;
    can.brush.color:=$00ff8080;
    can.brush.style:=bsfdiagonal;
    //Abrollfläche
    can.rectangle(-1,rand,breite+1,hoehe+1);

    //untere Strecke
    can.pen.width:=2;
    can.moveto(-1,rand+1);
    can.lineto(breite+1,rand+1);
    //obere Strecke
    if checkbox2.checked then
    begin
      can.moveto(-1,round(rand-radius-1));
      can.lineto(breite+1,round(rand-radius-1));
    end;
    can.pen.width:=1;
    can.pen.color:=clred;
    can.brush.style:=bssolid;

    //Hilfspunkte Dreieck bzw. Fünfecke
    for i:=0 to z-1 do begin
      ecken[i].x:=wert1/2/sin(pi/z)*cos(i*2*pi/z);
      ecken[i].y:=-wert1/2/sin(pi/z)*sin(i*2*pi/z);
    end;

    //Konstruktion der Punkte des Reuleaux-Polygons
    for j:=0 to z-1 do begin
      for i:=0 to t360 do
      begin
        kurve[i+j*t360].x:=ecken[j].x+radius*cos((i/2+180-t360/4+j*t360)*pi/180);
        kurve[i+j*t360].y:=ecken[j].y-radius*sin((i/2+180-t360/4+j*t360)*pi/180);
      end;
    end;
    //Schwerpunkt
    kurve[361].x:=0;
    kurve[361].y:=0;

    //Abrollwinkel
    wi:=abs(temp)*pi/180;
    wminimum:=-10000;
    minimum:=-1;
    //alle Punkte um Winkel drehen
    for i:=0 to 361 do
    begin
      kurve2[i].x:=cos(wi)*kurve[i].x-sin(wi)*kurve[i].y;
      kurve2[i].y:=sin(wi)*kurve[i].x+cos(wi)*kurve[i].y;
      //Minimum des gedrehten Polygons suchen
      if i<>361 then
        if kurve2[i].y>wminimum then begin
          wminimum:=kurve2[i].y;
          minimum:=i;
        end;
    end;

    //Abrollweite
    xp:=temp*pi/180*radius/2;
    yp:=kurve2[minimum].y;

    //Polygonpunkte auf Fensterkoordinaten transformieren
    for i:=0 to 361 do begin
      bahn[i].x:=round(kurve2[i].x+xp+xoffset);
      bahn[i].y:=round(rand+kurve2[i].y-yp);
    end;

    //Mittelbalken
    if checkbox1.checked then
    begin
      can.brush.color:=clyellow;
      case z of
        5 : can.rectangle(bahn[361].x-wert1,bahn[361].y-20,bahn[361].x+2*wert1+80,bahn[361].y+20);
       else can.rectangle(bahn[361].x-wert1+20,bahn[361].y-20,bahn[361].x+2*wert1,bahn[361].y+20);
      end;
    end;

    //Reuleaux-Polygon
    can.brush.color:=$00b0ffb0;
    can.polygon(slice(bahn,360));

    //verschobenes Reuleaux-Polygon
    for i:=0 to 361 do begin
      case z of
       5 : bahn[i].x:=round(kurve2[i].x+xp+wert1+80+xoffset);
       else bahn[i].x:=round(kurve2[i].x+xp+wert1+20+xoffset);
      end;
      bahn[i].y:=round(rand+kurve2[i].y-yp);
    end;
    can.polygon(slice(bahn,360));

    //Spur zeichen
    can.pen.width:=1;
    if checkbox3.checked and (spurlaenge<high(spur)) and (spurlaenge>0) then begin
      can.pen.color:=clblue;
      can.moveto(spur[1].x,spur[1].y);
      for i:=1 to spurlaenge do
        can.lineto(spur[i].x,spur[i].y);
    end;

    can.pen.color:=clblack;
    can.brush.color:=clred;
    //Schwerpunktkoordinaten
    xx:=round(bahn[361].x);
    yy:=round(bahn[361].y);

    //neuen Spurpunkt speichern
    if spurlaenge<high(spur) then
    begin
      inc(spurlaenge);
      spur[spurlaenge].x:=xx;
      spur[spurlaenge].y:=yy;
    end;

    //Schwerpunkte zeichnen
    can.ellipse(xx-4,yy-4,xx+5,yy+5);
    case z of
      5 : can.ellipse(xx-4-wert1-80,yy-4,xx-wert1-80+5,yy+5);
      else can.ellipse(xx-4-wert1-20,yy-4,xx-wert1-20+5,yy+5);
    end;

    //Abbruchbedingung rechts
    if xp>breite+2*wert1-xoffset then
    begin
      temp:=30;
      spurlaenge:=0;
    end;
    
    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then button1.caption:='Abbruch'
                      else button1.caption:='Simulation';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    temp:=temp+geschw;
    paintbox1paint(sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    temp:=240;
    setlength(spur,form1.width+100);
    spurlaenge:=0;
    geschw:=ein_int(edit3,1,50);
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
    geschw:=ein_int(edit3,1,50);
    spurlaenge:=0;
    paintbox1paint(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    temp:=240;
    spurlaenge:=0;
    paintbox1paint(sender);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    setlength(spur,0);
end;

end.
