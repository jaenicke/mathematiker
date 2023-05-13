unit uellzyk;
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
    UpDown2: TUpDown;
    Edit2: TEdit;
    Label2: TLabel;
    UpDown3: TUpDown;
    Edit3: TEdit;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
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

var temp:real;
    spurmaximum:integer;
    spur:array of record x,y:real end;
    spurlaenge:integer;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    breite,hoehe,rand:integer;
    can:tcanvas;
    ww,wv,x,y,xv,yv,stre,wd,wdx,xn:real;
    unten:boolean;
    nr,i:integer;
    pu:array[0..100] of tpoint;
    punkte:array[1..4] of tpoint;
    wert1,wert2,wert3:integer;

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

function rechteck:real;
const iwert=2500;
var hg,eps,ix,iy,we,ws,s1,w11,hi:real;
function funktion(x:real):real;
begin
    funktion:=sqrt(1-eps*sqr(sin(x)));
end;
function st(fx,xx:real):real;
begin
    st:=fx*funktion(ws*xx/2+hi)
end;
begin
    ix:=pi/2;
    iy:=wv+pi/2;
    if wv=0 then
    begin
      rechteck:=0;
      exit
    end;
    w11:=sqrt(11)/12;
    eps:=(wert1*wert1-wert2*wert2)/(wert1*wert1);
    ws:=(iy-ix)/iwert;
    if ws<0.001 then ws:=0.001;
    we:=ix;
    s1:=0;
    repeat
      hi:=we+ws/2;
      hg:=sqrt(-w11+5/12);
      s1:=s1+ws/5*(st(1,hg)+st(1,-hg)+st(1,sqrt(w11+5/12))+st(1,-sqrt(w11+5/12))+funktion(hi));
      we:=we+ws;
    until we>iy-ws/2;
    rechteck:=wert1*s1;
end;

procedure kline(a,b,c,d:integer);
begin
    can.moveto(a,b);
    can.lineto(c,d);
end;

procedure pkreis(a,b:integer);
begin
    can.Ellipse(a-4,b-4,a+5,b+5);
end;
procedure punktx(x:integer;c:char);
begin
    can.Brush.Color := clyellow;
    pkreis(punkte[x].x,punkte[x].y);
    can.Brush.style := bsclear;
    can.TextOut(punkte[x].x+4,punkte[x].y+4,c);
end;

begin
    breite:=paintbox1.width;
    hoehe:=paintbox1.height;
    rand:=hoehe-80;
    bitmap:=tbitmap.create;
    bitmap.width:=breite;
    bitmap.height:=hoehe;

    can:=bitmap.canvas;
    wert1:=ein_int(edit1,25,160);
    wert2:=ein_int(edit2,25,160);
    wert3:=ein_int(edit3,0,160);

    can.brush.color:=$00ff8080;
    can.brush.style:=bsfdiagonal;
    can.pen.style:=psclear;
    can.rectangle(0,rand,breite+1,hoehe+1);
    can.brush.style:=bssolid;
    can.pen.style:=pssolid;
    can.brush.color:=$00d0ffff;
    can.pen.color:=clblue;
    can.pen.width:=2;
    kline(0,rand+1,breite,rand+1);
    can.pen.width:=1;
    can.pen.color:=clblack;

    wv:=temp;
    unten:=false;
    for i:=0 to 6 do
      if ((wv>=(4*i+1)*pi/2) and (wv<(4*i+3)/2*pi)) then unten:=true;
    wdx:=arctan(wert1*sin(wv)/(wert2*cos(wv)));
    if unten then wd:=wdx-pi/2
             else wd:=pi/2+wdx;
    stre:=rechteck;
    xv:=wert1*cos(wv);
    yv:=wert2*sin(wv);
    ww:=0; nr:=0;
    repeat
      x:=wert1*cos(ww);
      y:=wert2*sin(ww);
      x:=x-xv;
      y:=y-yv;
      xn:=x*cos(wd)+y*sin(wd);
      y:=-x*sin(wd)+y*cos(wd);
      x:=xn+stre;
      y:=rand-y;

      pu[nr].x:=round(x);
      pu[nr].y:=round(y);
      inc(nr);
      ww:=ww+0.1;
    until ww>2*pi+0.05;
    if checkbox3.checked then can.polygon(slice(pu,nr));

    x:=-xv;
    y:=-yv;
    xn:=x*cos(wd)+y*sin(wd);
    y:=-x*sin(wd)+y*cos(wd);
    x:=xn+stre;
    y:=rand-y;
    punkte[1].x:=round(x);
    punkte[1].y:=round(y);

    if wert1>=wert2 then
    begin
      x:=sqrt(abs(sqr(wert1)-sqr(wert2)))-xv;
      y:=-yv;
    end
    else
    begin
      x:=-xv;
      y:=sqrt(abs(sqr(wert2)-sqr(wert1)))-yv;
    end;

    xn:=x*cos(wd)+y*sin(wd);
    y:=-x*sin(wd)+y*cos(wd);
    x:=xn+stre;
    y:=rand-y;
    punkte[3].x:=round(x);
    punkte[3].y:=round(y);
    x:=wert3-xv;
    y:=-yv;
    xn:=x*cos(wd)+y*sin(wd);
    y:=-x*sin(wd)+y*cos(wd);
    x:=xn+stre;
    y:=rand-y;

    spur[spurlaenge].x:=x;
    spur[spurlaenge].y:=y;
    inc(spurlaenge);
    can.pen.color:=clblue;
    can.moveto(round(spur[0].x),round(spur[0].y));
    if checkbox1.checked then
      for i:=1 to spurlaenge-1 do can.lineto(round(spur[i].x),round(spur[i].y));
    if spurlaenge>spurmaximum then spurlaenge:=0;

    punkte[2].x:=round(x);
    punkte[2].y:=round(y);
    if checkbox3.checked then
    begin
      kline(punkte[1].x,punkte[1].y,punkte[2].x,punkte[2].y);
      can.pen.color:=clblack;
      punktx(1,'M');
      punktx(3,'F');
      punktx(2,'P');
    end;

    if timer1.enabled and (stre>paintbox1.width+max(wert1,wert2)) then
    begin
      temp:=0;
      spurlaenge:=0
    end;
    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    setlength(spur,0);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then button1.caption:='Abbruch'
                      else button1.caption:='Simulation';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    temp:=temp+1/40;
    paintbox1paint(sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    temp:=pi/2;
    setlength(spur,paintbox1.width+600);
    spurmaximum:=paintbox1.width+590;
    spurlaenge:=0;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
    spurlaenge:=0;
    paintbox1paint(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    temp:=pi/2;
    spurlaenge:=0;
    paintbox1paint(sender);
end;

end.
