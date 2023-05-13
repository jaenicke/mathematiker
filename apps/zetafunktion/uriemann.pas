unit uriemann;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, complexm, ComCtrls, StdCtrls, math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    ListBox1: TListBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

//Nachfolgende Lösung von Gammatester
{---------------------------------------------------------------------------}
function PolEvalX(x: extended; const a: array of extended; n: integer): extended;
  {-Evaluate polynomial; return a[0] + a[1]*x + ... + a[n-1]*x^(n-1)}
var
  i: integer;
  s: extended;
begin
  if n<=0 then begin
    PolEvalX := 0.0;
    exit;
  end;
  s := a[n-1];
  for i:=n-2 downto 0 do s := s*x + a[i];
  PolEvalX := s;
end;

{---------------------------------------------------------------------------}
function cterm(n: integer; z: extended): extended;
  {-Coefficients of remainder terms; n can range from 0 to 4}
  { Improved Pascal code from http://web.viu.ca/pughg/thesis.d/zetaHalfPlusIt.c}
const
   n0=22;
   c0: array[0..n0-1] of extended = (
          +0.38268343236508977173,
          +0.43724046807752044936,
          +0.13237657548034352332,
          -0.01360502604767418865,
          -0.01356762197010358089,
          -0.00162372532314446528,
          +0.00029705353733379691,
          +0.00007943300879521470,
          +0.00000046556124614505,
          -0.00000143272516309551,
          -0.00000010354847112313,
          +0.00000001235792708386,
          +0.00000000178810838580,
          -0.00000000003391414390,
          -0.00000000001632663390,
          -0.00000000000037851093,
          +0.00000000000009327423,
          +0.00000000000000522184,
          -0.00000000000000033507,
          -0.00000000000000003412,
          +0.00000000000000000058,
          +0.00000000000000000015);

   n1=23;
   c1: array[0..n1-1] of extended = (
           -0.02682510262837534703,
           +0.01378477342635185305,
           +0.03849125048223508223,
           +0.00987106629906207647,
           -0.00331075976085840433,
           -0.00146478085779541508,
           -0.00001320794062487696,
           +0.00005922748701847141,
           +0.00000598024258537345,
           -0.00000096413224561698,
           -0.00000018334733722714,
           +0.00000000446708756272,
           +0.00000000270963508218,
           +0.00000000007785288654,
           -0.00000000002343762601,
           -0.00000000000158301728,
           +0.00000000000012119942,
           +0.00000000000001458378,
           -0.00000000000000028786,
           -0.00000000000000008663,
           -0.00000000000000000084,
           +0.00000000000000000036,
           +0.00000000000000000001);

   n2=24;
   c2: array[0..n2-1] of extended = (
           +0.00518854283029316849,
           +0.00030946583880634746,
           -0.01133594107822937338,
           +0.00223304574195814477,
           +0.00519663740886233021,
           +0.00034399144076208337,
           -0.00059106484274705828,
           -0.00010229972547935857,
           +0.00002088839221699276,
           +0.00000592766549309654,
           -0.00000016423838362436,
           -0.00000015161199700941,
           -0.00000000590780369821,
           +0.00000000209115148595,
           +0.00000000017815649583,
           -0.00000000001616407246,
           -0.00000000000238069625,
           +0.00000000000005398265,
           +0.00000000000001975014,
           +0.00000000000000023333,
           -0.00000000000000011188,
           -0.00000000000000000416,
           +0.00000000000000000044,
           +0.00000000000000000003);
   n3=24;
   c3: array[0..n3-1] of extended = (
           -0.00133971609071945690,
           +0.00374421513637939370,
           -0.00133031789193214681,
           -0.00226546607654717871,
           +0.00095484999985067304,
           +0.00060100384589636039,
           -0.00010128858286776622,
           -0.00006865733449299826,
           +0.00000059853667915386,
           +0.00000333165985123995,
           +0.00000021919289102435,
           -0.00000007890884245681,
           -0.00000000941468508130,
           +0.00000000095701162109,
           +0.00000000018763137453,
           -0.00000000000443783768,
           -0.00000000000224267385,
           -0.00000000000003627687,
           +0.00000000000001763981,
           +0.00000000000000079608,
           -0.00000000000000009420,
           -0.00000000000000000713,
           +0.00000000000000000033,
           +0.00000000000000000004);

   n4=25;
   c4: array[0..n4-1] of extended = (
           +0.00046483389361763382,
           -0.00100566073653404708,
           +0.00024044856573725793,
           +0.00102830861497023219,
           -0.00076578610717556442,
           -0.00020365286803084818,
           +0.00023212290491068728,
           +0.00003260214424386520,
           -0.00002557906251794953,
           -0.00000410746443891574,
           +0.00000117811136403713,
           +0.00000024456561422485,
           -0.00000002391582476734,
           -0.00000000750521420704,
           +0.00000000013312279416,
           +0.00000000013440626754,
           +0.00000000000351377004,
           -0.00000000000151915445,
           -0.00000000000008915418,
           +0.00000000000001119589,
           +0.00000000000000105160,
           -0.00000000000000005179,
           -0.00000000000000000807,
           +0.00000000000000000011,
           +0.00000000000000000004);
var
  q: extended;
begin
  q := sqr(z);
  case n of
      0: cterm :=   PolEvalX(q,c0,n0);
      1: cterm := z*PolEvalX(q,c1,n1);
      2: cterm :=   PolEvalX(q,c2,n2);
      3: cterm := z*PolEvalX(q,c3,n3);
    else cterm :=   PolEvalX(q,c4,n4);
  end;
end;

{---------------------------------------------------------------------------}
function theta(t:extended):extended;
  {-Riemann-Siegel-Theta}
var
  x,s: extended;
const
  c0 = 1.0/48.0;
  c1 = 7.0/5760.0;
  c2 = 31.0/80640.0;
  c3 = 127.0/430080.0;
begin
  x := 1.0/sqr(t);
  s := (((c3*x + c2)*x + c1)*x + c0)/t;
  theta := 0.5*t*(ln(t/(2*Pi)) - 1.0) - Pi/8 + s;
end;

{---------------------------------------------------------------------------}
procedure zetacrit(t: extended; var re,im: extended);
  {-Berechne  re + i*im = Zeta(1/2 + i*t) mit Riemann-Siegel}
const
  m=2;  {Max. Ordnung der Korrekturterme, muß <= 4 sein}
var
  i,n: longint;
  axx,axy: extended;
  q,y,p,s,r,tt:extended;
begin
  q  := sqrt(t/(2*Pi));
  n  := trunc(q);

  {s = Summe cos-Terme}
  s  := 0.0;
  tt := theta(t);
  for i:=1 to n do begin
    s := s + 1/sqrt(i)*cos(tt - t*ln(i));
  end;
  s :=2*s;

  {r := Summe Rest-Terme}
  y := 1.0;
  r := 0.0;
  p := 2.0*(q-n) - 1.0;
  for i:=0 to m do begin
    r := r + cterm(i,p)*y;
    y := y/q;
  end;
  r := r/sqrt(q);
  if odd(n+1) then r := -r;

  sincos(-tt, axy, axx);

  re := (s + r)*axx;
  im := (s + r)*axy;
end;

//ursprüngliche, wesentlich langsamere Lösung
{procedure zeta(t:extended;var re,im:extended);
var i,n:integer;
    ax:tcomplex;
    p,c0,c1,c2,s,r:extended;
function theta(t:extended):extended;
begin
    theta:=t/2*ln(t/(2*pi))-t/2-pi/8+1/(48*t)+7/(5760*t*t*t)
           +31/80640/(t*t*t*t*t)+127/430080/(t*t*t*t*t*t*t);
end;
function c_term(p:extended):extended;
begin
    c_term:=cos(2*pi*(p*p-p-1/16))/cos(2*pi*p);
end;
function zweiteableitung(p:extended):extended;
const h=0.0001;
begin
    zweiteableitung:=(-c_term(p-2*h)+16*c_term(p-h)
                      -30*c_term(p)+16*c_term(p+h)-c_term(p+2*h))/(12*sqr(h));
end;
function dritteableitung(p:extended):extended;
const h=0.0001;
begin
    dritteableitung:=-(c_term(p-h)-3*c_term(p)+3*c_term(p+h)-c_term(p+2*h))/(h*h*h);
end;
function sechsteableitung(p:extended):extended;
const h=0.001;
begin
    sechsteableitung:=(-150*c_term(p)-c_term(p-4*h)+12*c_term(p-3*h)-52*c_term(p-2*h)+116*c_term(p-h)
                      -c_term(p+4*h)+12*c_term(p+3*h)-52*c_term(p+2*h)+116*c_term(p+h)
     )/(4*sqr(h*h*h));
end;
begin
    n:=trunc(sqrt(t/(2*pi)));
    p:=sqrt(t/(2*pi))-n;
    c0:=c_term(p);
    c1:=-1/(96*pi*pi)*dritteableitung(p);
    c2:=1/(64*pi*pi)*zweiteableitung(p)+1/(18432*sqr(pi*pi))*sechsteableitung(p);
    s:=0;
    for i:=1 to n do s:=s+1/sqrt(i)*cos(theta(t)-t*ln(i));
    s:=2*s;

    if odd(n-1) then r:=-1
                else r:=1;
//1.rest    r:=r*1/sqrt(sqrt(t/(2*pi)))*c0;
//2.rest    r:=r*1/sqrt(sqrt(t/(2*pi)))*(c0+c1/sqrt(t/(2*pi)));
//3.rest    mit 2. und 6.Ableitung
    r:=r*1/sqrt(sqrt(t/(2*pi)))*(c0+c1/sqrt(t/(2*pi))+c2/(t/(2*pi)));
    ax:=CExp(Cset(0,-theta(t)));
    re:=(s+r)*ax.x;
    im:=(s+r)*ax.y;
end;}

procedure TForm1.PaintBox1Paint(Sender: TObject);
const start=0.5;
      pino=pi/180;
var bitmap:tbitmap;
    can:tcanvas;

    xm,ym,x1,y1,x2,y2,
    i,j,
    tmax,breite   :integer;
    x,y:extended;

    t,u,v,xi,yi,xa,ya,
    u1,v1,u2,v2,h,
    breite2,abstand,
    fa,fb,fc,fd   :real;
    punkte:array[0..4] of tpoint;
    k:string;

procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:real;
    x,y:integer;
    pfe:array[0..3] of tpoint;
    wcos,wsin:extended;
procedure kline(a,b,c,d:integer);
begin
    can.moveto(a,b);
    can.lineto(c,d);
end;
begin
   kline(a,b,c,d);
   if (a<>c) or (b<>d) then
   begin
     if (c-a)<>0 then wi:=pi-arctan((d-b)/(c-a))
     else
     begin
       if d<b then wi:=-pi/2 else wi:=pi/2;
     end;
   sincos(wi-xwi,wsin,wcos);
   x:=round(14*wcos);
   y:=round(14*wsin);
   if c<a then
     begin
       x:=-x;
       y:=-y
     end;
   pfe[0].x:=c+x;
   pfe[0].y:=d-y;
   pfe[1].x:=c;
   pfe[1].y:=d;
   sincos(wi+xwi,wsin,wcos);
   x:=round(14*wcos);
   y:=round(14*wsin);
   if c<a then
     begin
       x:=-x;
       y:=-y
     end;
   pfe[2].x:=c+x;
   pfe[2].y:=d-y;
   can.brush.color:=can.pen.color;
   can.polygon(slice(pfe,3));
   can.brush.style:=bsclear;
  end;
end;

procedure nullstelle;
var i:integer;
    null:real;
begin
    can.brush.color:=clyellow;
    i:=0;
    repeat
      null:=strtofloat(listbox1.items[i]);
      if null<tmax then
        can.ellipse(xm-5,round(ym-h*null-5),xm+6,round(ym-h*null+6));
      inc(i);
    until (null>tmax) or (i>listbox1.items.count-1);
end;
procedure nullstelle2;
var i,w:integer;
    null:real;
begin
    can.brush.color:=clyellow;
    i:=0;
    repeat
      null:=strtofloat(listbox1.items[i]);
      if null<tmax then
      begin
        w:=round((null-1)/tmax*(paintbox1.width-20)+20);
        can.ellipse(w-4,ym-4,w+5,ym+5);
      end;
      inc(i);
    until (null>tmax) or (i>listbox1.items.count-1);
    can.brush.style:=bsclear;
end;

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

begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox1.width;
    bitmap.height:=paintbox1.height;
    can:=bitmap.canvas;

    can.font.name:='Verdana';
    can.font.size:=9;
    can.brush.style:=bsclear;
    tmax:=ein_int(edit1,20,120);
    breite:=ein_int(edit2,40,200);

    xm:=bitmap.width div 2;

    if radiobutton1.checked then
    begin
      ym:=bitmap.height div 2;
      breite2:=breite/2;

      xpfeilvoll(can,20,ym,bitmap.width-20,ym);
      xpfeilvoll(can,20,bitmap.height-20,20,20);
      j:=1;
      i:=round(breite2*j);

      repeat
        can.moveto(14,ym-i);
        can.lineto(26,ym-i);
        can.textout(26,ym-i,inttostr(j));
        can.moveto(14,ym+i);
        can.lineto(26,ym+i);
        can.textout(26,ym+i,inttostr(-j));
        inc(j);
        i:=round(breite2*j);
      until i>(paintbox1.height div 2)-20;

      j:=10;
      repeat
        i:=round((j-1)/tmax*(paintbox1.width-20));
        can.moveto(i+20,ym-5);
        can.lineto(i+20,ym+5);
        k:=inttostr(j);
        can.textout(i+20-can.textwidth(k) div 2,ym+6,k);
        j:=j+10;
      until i+20>paintbox1.width-20;

      i:=20;
      can.pen.color:=clred;
      repeat
        t:=1+(i-20)/(paintbox1.width-20)*tmax;
        zetacrit(t,x,y);
        if i=20 then can.moveto(i,round(ym-breite2*x))
                else can.lineto(i,round(ym-breite2*x));
        Inc(i);
      until i>paintbox1.width-20;

      i:=20;
      can.pen.color:=clblue;
      repeat
        t:=1+(i-20)/(paintbox1.width-20)*tmax;
        zetacrit(t,x,y);
        if i=20 then can.moveto(i,round(ym-breite2*y))
                else can.lineto(i,round(ym-breite2*y));
        Inc(i);
      until i>paintbox1.width-20;
      if checkbox1.checked then nullstelle2;
      can.font.color:=clred;
      can.textout(50,40,'Realteil ');
      can.font.color:=clblue;
      can.textout(50,60,'Imaginärteil ');
      can.font.color:=clblack;
    end
    else //räumlich
    begin

      ym:=bitmap.height-40;
      h:=(bitmap.height-120)/tmax;

      xpfeilvoll(can,xm,ym,xm,20);
      can.textout(xm+10,20,'t');

      fa:=0.5*cos(198*pino);
      fb:=0.5*sin(198*pino);
      fc:=0.9*cos(355*pino);
      fd:=0.9*sin(355*pino);

      u:=-fa*400;
      v:=-fb*400;
      x1:=round(xm+u);
      y1:=round(ym-v);
      x2:=round(xm-u);
      y2:=round(ym+v);
      xpfeilvoll(can,x2,y2,x1,y1);
      can.textout(x1+5,y1,'Re(z)');

      u:=-fc*300;
      v:=-fd*300;
      x1:=round(xm+u);
      y1:=round(ym-v);
      x2:=round(xm-u);
      y2:=round(ym+v);
      xpfeilvoll(can,x2,y2,x1,y1);
      can.textout(x1-20,y1+5,'Im(z)');

      t:=start;
      can.brush.color:=$00fff040;
      can.pen.color:=clnavy;
      can.pen.width:=2;
      repeat
        zetacrit(t,x,y);
        x:=-breite*x;
        y:=-breite*y;

        abstand:=sqrt(x*x+y*y);
        xi:=x-abstand/10;
        yi:=y-abstand/10;
        u1:=fa*xi+fc*yi;
        v1:=fb*xi+fd*yi+h*t;
        xa:=x+abstand/10;
        ya:=y+abstand/10;
        u2:=fa*xa+fc*ya;
        v2:=fb*xa+fd*ya+h*t;
        can.pen.style:=psclear;
        if t=start then
        begin
           punkte[0].x:=round(xm+u1);
           punkte[0].y:=round(ym-v1);
           punkte[1].x:=round(xm+u2);
           punkte[1].y:=round(ym-v2);
        end
        else
        begin
           punkte[2].x:=round(xm+u2);
           punkte[2].y:=round(ym-v2);
           punkte[3].x:=round(xm+u1);
           punkte[3].y:=round(ym-v1);
           can.polygon(slice(punkte,4));
           punkte[0]:=punkte[3];
           punkte[1]:=punkte[2];
        end;

        can.pen.style:=pssolid;
        u:=fa*x+fc*y;
        v:=fb*x+fd*y+h*t;
        if t=start then can.moveto(round(xm+u),round(ym-v))
                   else can.lineto(round(xm+u),round(ym-v));
        t:=t+0.06;
      until t>tmax;
      can.pen.width:=1;
      can.brush.color:=clred;
      if checkbox1.checked then nullstelle;
    end;

    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var t,x,y,y1,y2,ym:extended;
begin
    listbox1.clear;
    t:=10;
    repeat
      zetacrit(t,x,y);
      if y<0 then
      begin
        while y<0 do
        begin
          t:=t+0.01;
          zetacrit(t,x,y);
        end;
        y2:=t;
        y1:=t-0.01;
        repeat
          ym:=(y1+y2)/2;
          zetacrit(ym,x,y);
          if y<0 then y1:=ym
                 else y2:=ym;
        until (abs(y1-y2)<0.0000001);
        listbox1.items.add(format('%.4n',[(y1+y2)/2]));
      end;
      t:=t+0.1;
    until t>130;
{Nullstellen zur Kontrolle
           14.134725142, 21.022039639, 25.010857580, 30.424876126, 32.935061588,
           37.586178159, 40.918719012, 43.327073281, 48.005150881, 49.773832478,
           52.970321478, 56.446247697, 59.347044003, 60.831778525, 65.112544048,
           67.079810529, 69.546401711, 72.067157674, 75.704690699, 77.144840069,
           79.337375020, 82.910380854, 84.735492981, 87.425274613, 88.809111208,
           92.491899271, 94.651344041, 95.870634228, 98.831194218
}
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
    if listbox1.items.count=0 then button1click(sender);
    paintbox1paint(sender);
end;

end.
