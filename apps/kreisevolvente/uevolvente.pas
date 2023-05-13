unit uevolvente;
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
    UpDown1: TUpDown;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
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
    can:tcanvas;
    breite,hoehe,xm,ym:integer;
    radius:integer;
    wi,bogen,winkel,abstand,xp,yp,x0,y0,xt,yt:real;
    punkte:array[1..3] of tpoint;

function ein_int(const edit:tedit;a,b:integer):integer;
var kk:string;
    x,code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    if x<a then x:=a;
    if x>b then x:=b;
    ein_int:=x;
end;
procedure kline(a,b,c,d:integer);
begin
    can.moveto(a,b);
    can.lineto(c,d);
end;
procedure pkreis(a,b:integer);
begin
    can.Ellipse(a-3,b-3,a+4,b+4);
end;
procedure punktx(x:integer;c:char);
begin
    can.Brush.Color := clyellow;
    pkreis(punkte[x].x,punkte[x].y);
    can.brush.style := bsclear;
    can.TextOut(punkte[x].x+4,punkte[x].y+4,c);
end;

procedure senkrechte2(p0x,p0y,p10x,p10y,p1x,p1y:real;var x0,y0:real);
var m1,m2,n1,n2:real;
begin
     x0:=-1000; y0:=-1000;
     if (p0x-p10x<>0) and (p0y-p10y<>0) then
     begin
       m1:=(p0y-p10y)/(p0x-p10x);
       if m1>1000 then m1:=1000;
       if m1<-1000 then m1:=-1000;
       n1:=p0y-p0x*m1;
       m2:=-1/m1;
       n2:=p1y-m2*p1x;
       x0:=m1*(n2-n1)/(1+sqr(m1))+100;
       y0:=m2*x0+n2;
     end;
     if (p0x-p10x=0) and (p0y-p10y<>0) then
     begin
       x0:=p10x-20;
       y0:=p1y;
     end;
     if (p0x-p10x<>0) and (p0y-p10y=0) then
     begin
       x0:=p1x;
       y0:=p10y-20;
     end;
end;

begin
    breite:=paintbox1.width;
    hoehe:=paintbox1.height;
    bitmap:=tbitmap.create;
    bitmap.width:=breite;
    bitmap.height:=hoehe;
    xm:=breite div 2;
    ym:=hoehe div 2;

    can:=bitmap.canvas;
    can.font.name:='Verdana';
    can.font.size:=9;

    winkel:=ein_int(edit1,0,7200)*pi/180;
    radius:=ein_int(edit2,5,120);

    can.brush.style:=bsclear;
    can.pen.color:=clblue;
    can.ellipse(xm-radius,ym-radius,xm+radius+1,ym+radius+1);

    can.pen.color:=clred;
    wi:=0;
    repeat
      bogen:=wi*radius;

      xp:=xm+radius*cos(wi+pi/2);
      yp:=ym-radius*sin(wi+pi/2);
      punkte[2].x:=round(xp);
      punkte[2].y:=round(yp);
      senkrechte2(xp,yp,xm,ym,xp,yp,xt,yt);
      abstand:=sqrt(sqr(xp-xt)+sqr(yp-yt));

      if yp<=ym then
      begin
        x0:=xp+bogen/abstand*(xt-xp);
        y0:=yp+bogen/abstand*(yt-yp)
      end
      else
      begin
        x0:=xp-bogen/abstand*(xt-xp);
        y0:=yp-bogen/abstand*(yt-yp);
      end;  
      punkte[3].x:=round(x0);
      punkte[3].y:=round(y0);
      if wi=0 then
        can.moveto(punkte[3].x,punkte[3].y)
      else
        can.lineto(punkte[3].x,punkte[3].y);
      wi:=wi+0.01;
    until wi>winkel;

    if sqr(x0-xm)+sqr(y0-ym)>sqr(breite)/2 then updown1.position:=0;
    
    punkte[1].x:=round(xm);
    punkte[1].y:=round(ym);

    can.pen.color:=cllime;
    kline(punkte[2].x,punkte[2].y,punkte[3].x,punkte[3].y);

    can.pen.color:=clblack;
    punktx(1,' ');
    punktx(2,' ');
    punktx(3,'E');
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
var a:integer;
begin
    a:=updown1.position+1;
    if a>updown1.max then a:=updown1.min;
    updown1.position:=a;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    updown1.position:=0;
    paintbox1paint(sender);
end;

end.
