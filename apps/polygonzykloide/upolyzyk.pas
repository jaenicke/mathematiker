unit upolyzyk;
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
    i:integer;
    punkte:array[1..4] of tpoint;
    wert1,wert2,wert3:integer;
    pu:array[0..22] of tpoint;
    wv,radius,iwi,awi,pbreite,xort,xd,yd,p1x,p1y:extended;

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
    wert2:=ein_int(edit2,3,20);
    wert3:=ein_int(edit3,0,200);

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
    iwi:=2.0*pi/wert2;
    awi:=iwi;
    radius:=wert1/cos(iwi/2);
    pbreite:=2.0*wert1*tan(iwi/2);

    xort:=0;
    while wv>awi do
    begin
      wv:=wv-awi;
      xort:=xort+pbreite
    end;

    xd:=-pbreite/2*cos(wv)+1.0*wert1*sin(wv)+xort+pbreite/2;
    yd:=-pbreite/2*sin(wv)-1.0*wert1*cos(wv)+rand;

    p1x:=xd;
    p1y:=yd;
    punkte[1].x:=round(xd);
    punkte[1].y:=round(yd);

    if checkbox3.checked then
    begin
      for i:=0 to wert2-1 do
      begin
        pu[i].x:=round(p1x+radius*cos(i*2*pi/wert2-(pi-iwi)/2-wv));
        pu[i].y:=round(p1y-radius*sin(i*2*pi/wert2-(pi-iwi)/2-wv));
      end;
      can.brush.color:=$00c0ffff;
      can.polygon(slice(pu,wert2));
      can.pen.color:=$0080cfcf;
      for i:=0 to wert2-1 do
      begin
        can.moveto(punkte[1].x,punkte[1].y);
        can.lineto(pu[i].x,pu[i].y);
      end;
    end;

    xd:=-1.0*wert3*sin(temp)+xd;
    yd:=1.0*wert3*cos(temp)+yd;
    spur[spurlaenge].x:=xd;
    spur[spurlaenge].y:=yd;
    inc(spurlaenge);

    punkte[3].x:=round(xd);
    punkte[3].y:=round(yd);

    can.pen.color:=clblue;
    can.moveto(round(spur[0].x),round(spur[0].y));
    if checkbox1.checked then
      for i:=1 to spurlaenge-1 do can.lineto(round(spur[i].x),round(spur[i].y));
    if spurlaenge>spurmaximum then spurlaenge:=0;

    can.pen.color:=clblack;
    if checkbox3.checked then
    begin
      kline(punkte[1].x,punkte[1].y,punkte[3].x,punkte[3].y);
      can.pen.color:=clblack;
      punktx(1,'M');
      punktx(3,'F');
    end;
    if punkte[1].x>breite+radius then
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
