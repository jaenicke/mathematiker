unit ulissa;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Timer1: TTimer;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    UpDown4: TUpDown;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    temp:real;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const delta:real=0.02;

function ein_int(const edit:tedit;wmin,wmax:integer):integer;
var kk:string;
    x,code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    if x<wmin then
    begin
      x:=wmin;
      edit.text:=inttostr(x)
    end;
    if x>wmax then
    begin
      x:=wmax;
      edit.text:=inttostr(x)
    end;
    ein_int:=x;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then
    begin
      button1.caption:='Abbruch';
      if radiogroup1.itemindex=0 then temp:=0;
    end
    else button1.caption:='Simulation';
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
const pihalbe=pi/2;
var bitmap:tbitmap;
    can:tcanvas;
    punkte:array[1..5] of tpoint;
    puxxx : array[1..6] of record x,y:real end;

    wimax,wix,drift,ab12,abst,laenge,la,wi,vwi,vwi2,awi,x0,y0,wi2,phase:real;
    x1,y1,x2,y2,x3,y3,x4,y4,alpha,bg:real;
    rr2,r1,x,y,i,sti,sti2:integer;

    innen,start:boolean;
    b2,h2,gg,n2:integer;

procedure kreis(x,y,r:integer);
begin
    can.ellipse(x-r,y-r,x+r+1,y+r+1);
end;
procedure punktx(x:integer;c:char);
begin
    can.Brush.Color := clyellow;
    kreis(punkte[x].x,punkte[x].y,4);
    can.Brush.style := bsclear;
    can.TextOut(punkte[x].x+4,punkte[x].y+4,c);
end;
procedure kline(a,b,c,d:integer);
begin
    can.moveto(a,b);
    can.lineto(c,d);
end;
procedure line(a,b:integer);
begin
    kline(punkte[a].x,punkte[a].y,punkte[b].x,punkte[b].y);
end;
function ArcTan2(Y, X: Extended): Extended;
asm
        FLD     Y
        FLD     X
        FPATAN
        FWAIT
end;
function ggt(faktor,rest:integer):integer;
var r,s,t:longint;
begin
       s:=faktor;
       t:=rest;
       if s<t then
       begin
          r:=s;
          s:=t;
          t:=r
       end;
       repeat
          r:=s mod t;
          s:=t;
          t:=r;
       until r=0;
       ggt:=s;
end;

begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox1.width;
    bitmap.height:=paintbox1.height;
    can:=bitmap.canvas;
    can.font.name:='Verdana';
    can.font.size:=9;
    
    b2:=bitmap.width div 2;
    h2:=bitmap.height div 2;
    punkte[1].x:=b2-190; punkte[1].y:=h2-170;
    punkte[2].x:=b2+190; punkte[2].y:=h2+170;

    innen:=radiogroup2.itemindex=0;
    wi:=temp;
    r1:=120;
//    Radius 2
    rr2:=ein_int(edit1,30,160);
//    Phasenwinkel
    phase:=ein_int(edit2,0,360)*pi/180;
    gg:=ggt(r1,rr2);
    n2:=rr2 div gg;

    can.pen.style:=psclear;
    can.brush.color:=$00ffd0d0;
    kreis(punkte[1].x,punkte[1].y,r1);

    can.pen.style:=pssolid;
    can.brush.color:=clwhite;
    can.pen.color:=clblack;
    kreis(punkte[2].x,punkte[2].y,r1);
    can.pen.style:=psclear;
    puxxx[3].x:=punkte[1].x+r1*cos(wi);
    puxxx[3].y:=punkte[1].y+r1*sin(wi);

    //Berührungspunkte der Tangenten
    if innen then
    begin
      puxxx[4].x:=punkte[2].x+r1*cos(-r1/rr2*wi+phase);
      puxxx[4].y:=punkte[2].y+r1*sin(-r1/rr2*wi+phase);
    end
    else
    begin
      puxxx[4].x:=punkte[2].x+r1*cos(r1/rr2*wi+phase);
      puxxx[4].y:=punkte[2].y+r1*sin(r1/rr2*wi+phase);
    end;

    can.brush.color:=$0a0ffa0;
    kreis(punkte[2].x,punkte[2].y,rr2);
    can.pen.style:=pssolid;
    can.brush.color:=clwhite;
    can.pen.color:=$00ffd0d0;
    kreis(punkte[1].x,punkte[1].y,r1-20);
    can.pen.color:=$0a0ffa0;

    sti2:=round(20*rr2/120);
    if sti2>20 then sti2:=20;
    kreis(punkte[2].x,punkte[2].y,rr2-sti2);

    drift:=arctan2(punkte[2].y-punkte[1].y,punkte[2].x-punkte[1].x);
    ab12:=sqrt(sqr(punkte[2].y-punkte[1].y)+sqr(punkte[2].x-punkte[1].x));

    //Räder
    sti:=round(18*r1/120);
    if sti>18 then sti:=18;
    can.pen.width:=sti;
    can.pen.color:=$00ffd0d0;
    for i:=0 to 7 do
    begin
      x:=round(punkte[1].x+(r1-10)*cos(wi+i*2*pi/8));
      y:=round(punkte[1].y+(r1-10)*sin(wi+i*2*pi/8));
      kline(punkte[1].x,punkte[1].y,x,y);
    end;

    sti:=round(18*rr2/120);
    if sti>18 then sti:=18;
    can.pen.width:=sti;
    can.pen.color:=$00a0ffa0;

    for i:=0 to 7 do
    begin
      if innen then
      begin
        x:=round(punkte[2].x+(rr2-10)*cos(-wi*r1/rr2+i*2*pi/8));
        y:=round(punkte[2].y+(rr2-10)*sin(-wi*r1/rr2+i*2*pi/8));
      end
      else
      begin
        x:=round(punkte[2].x+(rr2-10)*cos(wi*r1/rr2+i*2*pi/8));
        y:=round(punkte[2].y+(rr2-10)*sin(wi*r1/rr2+i*2*pi/8));
      end;
      kline(punkte[2].x,punkte[2].y,x,y);
    end;

    can.brush.style:=bsclear;
    can.pen.color:=$00ffd0d0;
    can.pen.width:=1;
    kreis(punkte[1].x,punkte[1].y,r1-20);
    can.pen.color:=$00a0ffa0;
    kreis(punkte[2].x,punkte[2].y,round(rr2-sti2));

    //Tangenten ermitteln, zeichnen
    if innen then alpha:=arcsin((r1+rr2)/ab12)
             else alpha:=arcsin((r1-rr2)/ab12);
    can.pen.color:=clblue;
    x1:=punkte[1].x+r1*cos(pihalbe-alpha-drift);
    y1:=punkte[1].y-r1*sin(pihalbe-alpha-drift);
    x2:=punkte[1].x+r1*cos(3*pihalbe+alpha-drift);
    y2:=punkte[1].y-r1*sin(3*pihalbe+alpha-drift);
    can.arc(punkte[1].x-r1,punkte[1].y-r1,punkte[1].x+r1+1,punkte[1].y+r1+1,
            round(x1),round(y1),round(x2+1),round(y2+1));

    if innen then
    begin
      x3:=punkte[2].x-rr2*cos(3*pihalbe+alpha+drift);
      x4:=punkte[2].x-rr2*cos(pihalbe-alpha+drift);
      y3:=punkte[2].y-rr2*sin(3*pihalbe+alpha+drift);
      y4:=punkte[2].y-rr2*sin(pihalbe-alpha+drift);
      can.arc(punkte[2].x-rr2,punkte[2].y-rr2,punkte[2].x+rr2+1,
              punkte[2].y+rr2+1,round(x3),round(y3),round(x4+1),round(y4+1));
    end
    else
    begin
      x3:=punkte[2].x+rr2*cos(pihalbe-alpha-drift);
      x4:=punkte[2].x+rr2*cos(3*pihalbe+alpha-drift);
      y3:=punkte[2].y-rr2*sin(pihalbe-alpha-drift);
      y4:=punkte[2].y-rr2*sin(3*pihalbe+alpha-drift);
      can.arc(punkte[2].x-rr2,punkte[2].y-rr2,
              punkte[2].x+rr2+1,punkte[2].y+rr2+1,
              round(x4),round(y4),round(x3+1),round(y3+1));
    end;
    kline(round(x1),round(y1),round(x3),round(y3));
    kline(round(x2),round(y2),round(x4),round(y4));

    if innen then laenge:=r1*(pi+2*alpha)+rr2*(pi+2*alpha)+2*ab12*cos(alpha)
             else laenge:=r1*(pi+2*alpha)+rr2*(pi-2*alpha)+2*ab12*cos(alpha);
    la:=laenge/ein_int(edit3,5,120);
    vwi:=la/r1;
    awi:=wi;
    while awi>vwi do awi:=awi-vwi;

    //Riemen mir Knoten
    can.brush.color:=clblue;
    x0:=punkte[1].x+r1*cos(pi-awi);
    y0:=punkte[1].y-r1*sin(pi-awi);
    if pi-awi>pihalbe-alpha-drift then
    begin
      kreis(round(x0),round(y0),3);
      awi:=awi+vwi;
      while pi-awi>pihalbe-alpha-drift do
      begin
        x0:=punkte[1].x+r1*cos(pi-awi);
        y0:=punkte[1].y-r1*sin(pi-awi);
        kreis(round(x0),round(y0),3);
        awi:=awi+vwi;
      end;
    end;

    abst:=sqrt(sqr(x1-x3)+sqr(y1-y3));
    bg:=r1*(pi/2-alpha-drift-(pi-awi));
    x0:=x1+bg/abst*(x3-x1);
    y0:=y1+bg/abst*(y3-y1);
    if x0<=x3 then
    begin
      kreis(round(x0),round(y0),3);
      repeat
        bg:=bg+la;
        x0:=x1+bg/abst*(x3-x1);
        y0:=y1+bg/abst*(y3-y1);
        if x0<=x3 then kreis(round(x0),round(y0),3);
      until x0>x3;
    end;

    bg:=bg-abst;
    vwi2:=la/rr2;
    if innen then
    begin
      wi2:=3*pi/2+alpha+drift-bg/rr2;
      x0:=punkte[2].x+rr2*cos(pi-wi2);
      y0:=punkte[2].y-rr2*sin(pi-wi2);
      if wi2>pi/2-alpha+drift then
      begin
        kreis(round(x0),round(y0),3);
        wi2:=wi2-vwi2;
        while wi2>pi/2-alpha+drift do
        begin
          x0:=punkte[2].x+rr2*cos(pi-wi2);
          y0:=punkte[2].y-rr2*sin(pi-wi2);
          kreis(round(x0),round(y0),3);
          wi2:=wi2-vwi2;
        end;
      end;

    end
    else
    begin
      wi2:=pi/2-alpha-drift-bg/rr2;
      x0:=punkte[2].x-rr2*cos(pi-wi2);
      y0:=punkte[2].y-rr2*sin(pi-wi2);
      if wi2>-pi/2+alpha-drift then
      begin
        kreis(round(x0),round(y0),3);
        wi2:=wi2-vwi2;
        while wi2>-pi/2+alpha-drift do
        begin
          x0:=punkte[2].x-rr2*cos(pi-wi2);
          y0:=punkte[2].y-rr2*sin(pi-wi2);
          kreis(round(x0),round(y0),3);
          wi2:=wi2-vwi2;
        end;
      end;
    end;

    awi:=wi;
    while awi>vwi do awi:=awi-vwi;
    awi:=awi-vwi;
    while pi-awi<3*pi/2+alpha-drift do
    begin
      x0:=punkte[1].x+r1*cos(pi-awi);
      y0:=punkte[1].y-r1*sin(pi-awi);
      kreis(round(x0),round(y0),3);
      awi:=awi-vwi;
    end;
    bg:=r1*((pi-awi)-3*pi/2+drift-alpha);
    x0:=x2+bg/abst*(x4-x2);
    y0:=y2+bg/abst*(y4-y2);
    if x0<=x4 then
    begin
      kreis(round(x0),round(y0),3);
      repeat
        bg:=bg+la;
        x0:=x2+bg/abst*(x4-x2);
        y0:=y2+bg/abst*(y4-y2);
        if x0<=x4 then kreis(round(x0),round(y0),3);
      until x0>x4;
    end;

    //Rahmen für Kurve
    can.pen.color:=clblue;
    can.brush.color:=$00f0f0f0;
    can.roundrect(punkte[2].x-135,punkte[1].y-135,punkte[2].x+135,punkte[1].y+135,10,10);
    can.brush.color:=clwhite;
    can.roundrect(punkte[2].x-130,punkte[1].y-130,punkte[2].x+130,punkte[1].y+130,10,10);

    //Maximale Winkelgröße
    wix:=0;
    wimax:=wi;
    start:=true;
    if wimax>2*n2*pi then wimax:=2*n2*pi;
    if wimax>16*pi then wimax:=16*pi;

    //Lissajousche Kurve
    can.pen.color:=clmaroon;
    repeat
      puxxx[5].y:=punkte[1].y+r1*sin(wix);
      if innen then
        puxxx[6].x:=punkte[2].x+r1*cos(-r1/rr2*wix+phase)
      else
        puxxx[6].x:=punkte[2].x+r1*cos(r1/rr2*wix+phase);
      if start then
      begin
        can.moveto(round(puxxx[6].x),round(puxxx[5].y));
        start:=false
      end
      else can.lineto(round(puxxx[6].x),round(puxxx[5].y));
      wix:=wix+0.02;
    until wix>wimax;

    // Hilfspunkte
    punkte[3].x:=round(puxxx[3].x);
    punkte[3].y:=round(puxxx[3].y);
    punkte[4].x:=round(puxxx[4].x);
    punkte[4].y:=round(puxxx[4].y);
    punkte[5].x:=punkte[4].x;
    punkte[5].y:=punkte[3].y;

    can.pen.color:=clblue;
    kline(punkte[3].x,punkte[3].y,punkte[4].x,punkte[3].y);
    kline(punkte[4].x,punkte[4].y,punkte[4].x,punkte[3].y);

    //Hilfslinien Punkte
    can.pen.color:=clblack;
    can.pen.width:=1;
    line(1,3);
    line(2,4);
    punktx(1,'A');
    punktx(2,'B');
    punktx(3,'P');
    punktx(4,'Q');
    punktx(5,'S');

    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    temp:=0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var phase:integer;
begin
    case radiogroup1.itemindex of
      0 : temp:=temp+delta;
      1 : begin
            phase:=ein_int(edit2,0,360)+1;
            if phase>360 then phase:=0;
            edit2.text:=inttostr(phase);
          end;
    end;
    paintbox1paint(sender);
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
    delta:=ein_int(edit4,1,100)/500;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    temp:=0;
    PaintBox1Paint(Sender);
end;

end.
