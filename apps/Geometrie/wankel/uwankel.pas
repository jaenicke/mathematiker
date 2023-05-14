unit uwankel;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    temp:real;
    geschw:integer;
    groesse:integer;
    punkteoriginal:array[0..1182] of record x,y:extended end;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    breite,hoehe,xmitte,ymitte:integer;
    can:tcanvas;

    i,j:integer;
    w12,wert1,wert2,speichen:integer;
    wireuleaux,xm,ym,wi:real;
    exzent,radius:extended;

    kurve:array[0..362] of record x,y:extended end;
    bahn:array[0..362] of tpoint;
    ecken:array[0..3] of record x,y:extended end;

procedure huelle;
var j:Integer;
    punkte:array[0..1182] of tpoint;
begin
    can.brush.style:=bsbdiagonal;
    can.brush.color:=clyellow;
    can.rectangle(-1,-1,breite+1,hoehe+1);
    for j:=0 to 1080 do begin
      punkte[j].x:=round(xmitte+groesse/60*punkteoriginal[j].x);
      punkte[j].y:=round(ymitte+groesse/60*punkteoriginal[j].y);
    end;
    can.brush.style:=bssolid;
    can.pen.color:=clblue;
    can.brush.color:=clwhite;
    can.polygon(slice(punkte,1080));
end;

procedure zahnrad(xm,ym,r:real;za:integer;wi:real);
var i:integer;
    ww,piza:real;
    pu:array[0..600] of tpoint;
begin
    ww:=2/r;
    piza:=pi/za;
    for i:=0 to za-1 do
    begin
      pu[4*i].x:=round(xm+r*cos(2*i*piza-ww+wi));
      pu[4*i].y:=round(ym-r*sin(2*i*piza-ww+wi));
      pu[4*i+1].x:=round(xm+(r-10)*cos(2*i*piza+ww+wi));
      pu[4*i+1].y:=round(ym-(r-10)*sin(2*i*piza+ww+wi));
      pu[4*i+2].x:=round(xm+(r-10)*cos((2*i+1)*piza-ww+wi));
      pu[4*i+2].y:=round(ym-(r-10)*sin((2*i+1)*piza-ww+wi));
      pu[4*i+3].x:=round(xm+r*cos((2*i+1)*piza+ww+wi));
      pu[4*i+3].y:=round(ym-r*sin((2*i+1)*piza+ww+wi));
    end;
    can.polygon(slice(pu,4*za));
end;

begin
    //Größen der Zahnräder
    wert2:=groesse;
    wert1:=3*(groesse div 2);

    bitmap:=tbitmap.create;
    breite:=paintbox1.width;
    hoehe:=paintbox1.height;
    xmitte:=breite div 2;
    ymitte:=hoehe div 2;
    bitmap.width:=breite;
    bitmap.height:=hoehe;
    can:=bitmap.canvas;

    //Drehwinkel
    wi:=-pi/180*temp;
    w12:=wert1-wert2;

    //Verschiebung des inneren Rades
    xm:=w12*cos(wi);
    ym:=-w12*sin(wi);

    //Hilfsecken für Reuleaux-Dreieck
    exzent:=4*wert1+w12;
    for i:=0 to 2 do begin
      ecken[i].x:=exzent/2/sin(pi/3)*cos(i*2*pi/3);
      ecken[i].y:=-exzent/2/sin(pi/3)*sin(i*2*pi/3);
    end;

    //Punkte des Reuleaux-Dreiecks
    radius:=exzent;
    for j:=0 to 2 do begin
      for i:=0 to 120 do
      begin
        kurve[i+j*120].x:=ecken[j].x+radius*cos((i/2+180-360/12+j*120)*pi/180);
        kurve[i+j*120].y:=ecken[j].y-radius*sin((i/2+180-360/12+j*120)*pi/180);
      end;
    end;

    //Motorraum
    huelle;

    //Reuleaux-Dreieck auf Fenster transformieren und Punkte drehen
    wireuleaux:=-wert2/wert1*wi+wi;
    for i:=0 to 360 do begin
      bahn[i].x:=round(xmitte+cos(wireuleaux)*kurve[i].x+sin(wireuleaux)*kurve[i].y-xm);
      bahn[i].y:=round(ymitte-sin(wireuleaux)*kurve[i].x+cos(wireuleaux)*kurve[i].y-ym);
    end;
    can.brush.color:=$00fff0f0;
    can.pen.color:=clmaroon;
    can.polygon(slice(bahn,360));

    //äußeres Zahnrad
    can.brush.color:=$00f0f0f0;
    can.pen.color:=$00ff0000;
    can.ellipse(round(xmitte-wert1-10-xm),round(ymitte-wert1-10-ym),
                round(xmitte+wert1+11-xm),round(ymitte+11+wert1-ym));
    can.brush.color:=clwhite;
    zahnrad(xmitte-xm,ymitte-ym,wert1,round(wert1/150*45),
            -round(wert2/150*45)/round(wert1/150*45)*wi+wi);

    //inneres Zahnrad
    can.brush.color:=$0080ffff;
    can.pen.color:=$000000ff;
    zahnrad(xmitte,ymitte,wert2-1,round(wert2/150*45),0);
    can.brush.color:=clwhite;
    can.ellipse(xmitte-wert2+20,ymitte-wert2+20,xmitte+wert2-19,ymitte+wert2-19);

    //inneres Rad
    can.brush.color:=$00f0f0f0;
    can.pen.color:=$00ff0000;
    can.ellipse(xmitte-wert2+24,ymitte-wert2+24,xmitte+wert2-23,ymitte+wert2-23);

    //Speichen
    speichen:=16;
    for i:=0 to speichen-1 do begin
      bahn[i].x:=round(xmitte+(wert2-26)*cos(wi+2*i*pi/speichen));
      bahn[i].y:=round(ymitte-(wert2-26)*sin(wi+2*i*pi/speichen));
    end;
    can.pen.color:=cldkgray;
    can.moveto(bahn[0].x,bahn[0].y);
    can.lineto(bahn[speichen div 2].x,bahn[speichen div 2].y);
    for i:=1 to (speichen-1) div 2 do begin
      can.pen.color:=clltgray;
      can.moveto(bahn[i].x,bahn[i].y);
      can.lineto(bahn[i+speichen div 2].x,bahn[i+speichen div 2].y);
    end;

    //Mittelpunkt
    can.brush.color:=$0080ffff;
    can.pen.color:=clblack;
    can.ellipse(round(xmitte-5),round(ymitte-5),round(xmitte+6),round(ymitte+6));

    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.FormCreate(Sender: TObject);
//Motorraum vorberechnen
procedure huelle;
var wix,kx,ky,wir:real;
    j,wert1,wert2,w12:Integer;
    exzent:extended;
    e0,k0:record x,y:extended end;
begin
    wert2:=60;
    wert1:=90;
    w12:=wert1-wert2;
    exzent:=4*wert1+w12;
    e0.x:=exzent/2/sin(pi/3);
    e0.y:=0;
    k0.x:=e0.x+exzent*cos(5*pi/6);
    k0.y:=e0.y-exzent*sin(5*pi/6);
    j:=0;
    repeat
      wix:=j*pi/180;
      wir:=-wert2/wert1*wix+wix;
      kx:=cos(wir)*k0.x+sin(wir)*k0.y;
      ky:=-sin(wir)*k0.x+cos(wir)*k0.y;
      punkteoriginal[j].x:=kx-w12*cos(wix);
      punkteoriginal[j].y:=ky+w12*sin(wix);
      inc(j);
    until j>=1081;
end;
begin
    temp:=0;
    geschw:=3;
    groesse:=60;
    huelle;
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

procedure TForm1.Edit1Change(Sender: TObject);
var x,code:integer;
begin
    val(edit1.text,x,code);
    if (x>0) and (x<11) then geschw:=x;
    val(edit2.text,x,code);
    if (x>4) and (x<26) then groesse:=4*x;
    paintbox1paint(sender);
end;

end.
