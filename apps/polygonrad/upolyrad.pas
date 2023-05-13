unit upolyrad;
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
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    geschw:real;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

var temp:real;

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

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    breite,hoehe,rand:integer;
    can:tcanvas;
    i:integer;
    wert1,wert2:integer;

    nr,tt,xx,yy,s,x2:integer;
    yyr,apo,wix,gg,r,bc,w1,wi,a,xp,yp,vw,cotn:real;
    poly:array[0..10] of tpoint;
    bahn:array[0..1700] of tpoint;

begin
    breite:=paintbox1.width;
    hoehe:=paintbox1.height;
    rand:=hoehe-80;
    bitmap:=tbitmap.create;
    bitmap.width:=breite;
    bitmap.height:=hoehe;

    can:=bitmap.canvas;
    wert2:=ein_int(edit2,3,16);

    wert1:=ein_int(edit1,10,60);

    s:=wert2;
    case s of
      3 : vw:=pi/6;
      4 : vw:=pi/4;
      5 : vw:=-pi/10;
      7 : vw:=pi/14;
      8 : vw:=pi/8;
      9 : vw:=-pi/18;
     else vw:=0;
    end;

    a:=3*wert1*(2*sin(pi/s));
    w1:=2*pi/s;
    r:=a/(2*sin(pi/s));
    apo:=r*cos(pi/s);
    cotn:=cos(pi/s);
    can.pen.color:=clblue;
    can.pen.width:=1;
    i:=-1;
    gg:=(r*cotn)*arccosh((r-apo)/(r*cotn)+1);
    bc:=4*gg;
    repeat
      xp:=i;
      while xp>gg do xp:=xp-2*gg;
      yp:=(r-apo)-cotn*r*(cosh(xp/(r*cotn))-1);
      bahn[i+1].x:=i;
      bahn[i+1].y:=round(rand-yp);
      inc(i);
    until i>breite;
    
    bahn[i+1].x:=i;
    bahn[i+1].y:=hoehe;
    bahn[i+2].x:=-1;
    bahn[i+2].y:=hoehe;

    can.brush.color:=$00ff8080;
    can.brush.style:=bsfdiagonal;
    can.polygon(slice(bahn,i+3));

    tt:=round(temp);

    can.brush.style:=bssolid;
    can.brush.color:=$00c0ffc0;
    yyr:=rand-r;
    can.rectangle(round(tt-apo),round(yyr-30),round(tt+bc+apo),round(yyr+30));

    can.brush.color:=$007fffff;
    can.pen.color:=clred;
    can.pen.width:=1;
    xp:=tt;
    while xp>gg do xp:=xp-2*gg;
    while xp<-gg do xp:=xp+2*gg;

    if s=3 then r:=r-1;
    wix:=arctan(sinh(xp/(r*cotn)));

    for i:=0 to s-1 do
    begin
      wi:=wix-i*w1+vw;
      poly[i].x:=round(temp+r*cos(wi));
      poly[i].y:=round(rand-r+r*sin(wi)-1);
    end;
    can.polygon(slice(poly,s));

    for i:=0 to s-1 do
    begin
      wi:=wix-i*w1+vw;
      poly[i].x:=round(temp+bc+r*cos(wi));
      poly[i].y:=round(rand-r+r*sin(wi)-1);
    end;
    can.polygon(slice(poly,s));

    if checkbox1.checked then
    begin
      xx:=tt;
      i:=-100;
      can.pen.color:=clred;
      repeat
        xp:=i;
        nr:=0;
        while xp>gg do
        begin
          xp:=xp-2*gg;
          dec(nr)
        end;
        while xp<-gg do
        begin
          xp:=xp+2*gg;
          inc(nr)
        end;
        wix:=arctan(sinh(xp/(r*cotn)));
        wi:=wix-nr*w1+vw;
        x2:=round(i+r*cos(wi));
        yy:=round(rand-r+r*sin(wi));
        if i=-100 then can.moveto(x2,yy)
                  else can.lineto(x2,yy);
        inc(i);
      until i>xx;
    end;

    can.pen.width:=1;
    can.brush.color:=clblack;
    xx:=tt;
    yy:=round(rand-r);
    can.ellipse(xx-4,yy-4,xx+5,yy+5);
    xx:=round(tt+bc);
    can.ellipse(xx-4,yy-4,xx+5,yy+5);

    if xx>breite+bc+60 then
    begin
      temp:=-bc-40;
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
    temp:=80;
    geschw:=ein_int(edit3,1,50)/10;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
    geschw:=ein_int(edit3,1,50)/10;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    temp:=80;
    paintbox1paint(sender);
end;

end.
