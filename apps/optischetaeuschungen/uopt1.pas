unit uopt1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PB1: TPaintBox;
    Button1: TButton;
    Timer1: TTimer;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

var zyklus:integer;
    pnr:integer;
{$R *.DFM}

procedure TForm1.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
    r,b,h:integer;

//Yin_Yang
procedure yinyang;
const r=250; t=35;
var f,w,diff:real;
    pu:array[0..1200] of tpoint;
    anz:integer;
begin
    f:=cos(zyklus*pi/180);
    bitmap.Canvas.pen.color:=clblack;
    bitmap.Canvas.Ellipse(round(b-f*r),round(h-r),round(b+f*r+1),round(h+r+1));
    w:=0;
    anz:=0;
    diff:=360/pi/r;
    repeat
      pu[anz].x:=round(b-f*r/2*sin(w*pi/180));
      pu[anz].y:=round(h+r/2+r/2*cos(w*pi/180));
      inc(anz);
      w:=w+diff;
    until w>=180;
    w:=0;
    repeat
      pu[anz].x:=round(b+f*r/2*sin(w*pi/180));
      pu[anz].y:=round(h-r/2+r/2*cos(w*pi/180));
      inc(anz);
      w:=w+diff;
    until w>=180;
    w:=180;
    repeat
      pu[anz].x:=round(b-f*r*sin(w*pi/180));
      pu[anz].y:=round(h+r*cos(w*pi/180));
      inc(anz);
      w:=w-diff;
    until w<=0;
    bitmap.Canvas.brush.color:=clblack;
    bitmap.canvas.polygon(slice(pu,anz));
    bitmap.canvas.Ellipse(round(b-t*f),round(h+r/2-t),round(b+t*f+1),round(h+r/2+t+1));
    bitmap.Canvas.brush.color:=clwhite;
    bitmap.canvas.Ellipse(round(b-t*f),round(h-r/2-t),round(b+t*f+1),round(h-r/2+t+1));
end;
//Shapiro
procedure shapiro;
const nn:integer=12;
var z,w,i:integer;
    r1,r2,r3,wi:real;
    pp:array[0..3] of tpoint;
begin
    nn:=8;
    bitmap.canvas.Brush.color:=$00c0c0c0;
    bitmap.canvas.rectangle(-1,-1,2*b+1,2*h+1);
    wi:=2*pi/nn;
    r1:=h-60;
    r2:=r1-40;
    r3:=r1-2*(r1-r2*cos(wi/2));
    z:=zyklus mod 100;
    for i:=0 to nn-1 do
    begin
      if z<50 then w:=z else w:=99-z;
      bitmap.canvas.Pen.width:=1;
      pp[0].x:=b+round(r1*cos(i*wi));
      pp[0].y:=h-round(r1*sin(i*wi));
      pp[2].x:=b+round(r3*cos(i*wi));
      pp[2].y:=h-round(r3*sin(i*wi));
      pp[1].x:=b+round(r2*cos(i*wi+wi/2));
      pp[1].y:=h-round(r2*sin(i*wi+wi/2));
      pp[3].x:=b+round(r2*cos(i*wi-wi/2));
      pp[3].y:=h-round(r2*sin(i*wi-wi/2));
      if not odd(i) then
        bitmap.canvas.brush.color:=rgb(153+w*2,153+w*2,153+w*2)
      else
        bitmap.canvas.brush.color:=rgb(153+102-w*2,153+102-w*2,153+102-w*2);
      bitmap.canvas.Polygon(slice(pp,4));
      bitmap.canvas.Pen.width:=2;
      if not odd(i) then
        bitmap.canvas.Pen.color:=clwhite
      else
        bitmap.canvas.Pen.color:=cldkgray;
      bitmap.canvas.moveto(pp[3].x,pp[3].y);
      bitmap.canvas.lineto(pp[0].x,pp[0].y);
      bitmap.canvas.lineto(pp[1].x,pp[1].y);
      if not odd(i) then
        bitmap.canvas.Pen.color:=cldkgray
      else
        bitmap.canvas.Pen.color:=clwhite;
      bitmap.canvas.moveto(pp[3].x,pp[3].y);
      bitmap.canvas.lineto(pp[2].x,pp[2].y);
      bitmap.canvas.lineto(pp[1].x,pp[1].y);
      z:=(z+(100 div nn)) mod 100;
    end;
end;
//Speichen
procedure speichen;
var i,j,f:integer;
    po:array[0..60] of tpoint;
begin
    with bitmap.canvas do
    begin
      pen.width:=1;
      po[0].x:=b;
      po[0].y:=h;
      for i:=0 to 15 do
      begin
        for j:=0 to 50 do
        begin
          po[j+1].x:=round(b+r*cos((i+j/50)*2*pi/16));
          po[j+1].y:=round(h-r*sin((i+j/50)*2*pi/16));
        end;
        f:=(i+zyklus) mod 16;
        if f<8 then
        begin
          pen.color:=rgb(160-f*8,160-f*8,160-f*8);
          brush.color:=rgb(160-f*8,160-f*8,160-f*8)
        end
        else
        begin
          brush.color:=rgb(160-(16-f)*8,160-(16-f)*8,160-(16-f)*8);
          pen.color:=rgb(160-(16-f)*8,160-(16-f)*8,160-(16-f)*8);
        end;
        polygon(slice(po,52));
      end;
      pen.color:=clgray;
      for i:=0 to 15 do
      begin
        moveto(b,h);
        lineto(round(b+r*cos(i*2*pi/16)),round(h-r*sin(i*2*pi/16)));
      end;
      brush.style:=bsclear;
      pen.color:=clblack;
      pen.width:=2;
      ellipse(b-r,h-r,b+r+1,h+r+1);
    end;
end;
//van der Helm
procedure helm;
var wi:real;
procedure stern(a:integer);
const eckenzahl=13;
var po:array[0..2*eckenzahl+2] of tpoint;
    i:Integer;
begin
    for i:=0 to eckenzahl-1 do
    begin
      po[2*i].x:=round(b+a*cos(i*2*pi/eckenzahl+wi));
      po[2*i].y:=round(h-a*sin(i*2*pi/eckenzahl+wi));
      po[2*i+1].x:=round(b+(a-20)*cos(i*2*pi/eckenzahl+pi/eckenzahl+wi));
      po[2*i+1].y:=round(h-(a-20)*sin(i*2*pi/eckenzahl+pi/eckenzahl+wi));
    end;
    bitmap.canvas.polygon(slice(po,2*eckenzahl));
end;
begin
    bitmap.canvas.pen.style:=psclear;
    wi:=0;
    bitmap.canvas.Brush.color:=clnavy;
    stern(260);
    bitmap.canvas.Brush.color:=clwhite;
    stern(220);
    wi:=-zyklus*pi/180;
    bitmap.canvas.Brush.color:=clred;
    stern(220);
    bitmap.canvas.Brush.color:=clwhite;
    stern(180);
    wi:=0;
    bitmap.canvas.Brush.color:=clnavy;
    stern(180);
end;
//Oszillierendes Quadrat
procedure oquadrat;
var xm,ym:real;
    po:array[0..4] of tpoint;
    i:integer;
procedure kquadrat;
begin
    po[0].x:=round(xm-100);  po[0].y:=round(ym-100);
    po[1].x:=round(xm+100);  po[1].y:=round(ym-100);
    po[2].x:=round(xm+100);  po[2].y:=round(ym+100);
    po[3].x:=round(xm-100);  po[3].y:=round(ym+100);
    bitmap.canvas.polygon(slice(po,4));
end;
begin
    with bitmap.canvas do
    begin
      brush.color:=clblue;
      pen.color:=clblue;
      for i:=0 to 3 do
      begin
        po[i].x:=round(b+170*cos(i*pi/2+zyklus*pi/180));
        po[i].y:=round(h-170*sin(i*pi/2+zyklus*pi/180));
      end;
      polygon(slice(po,4));
      pen.style:=psclear;
      if not checkbox1.checked then
      begin
        brush.color:=cllime;
        xm:=b-120;
        ym:=h-120;
        kquadrat;
        xm:=b+120;
        ym:=h-120;
        kquadrat;
        xm:=b+120;
        ym:=h+120;
        kquadrat;
        xm:=b-120;
        ym:=h+120;
        kquadrat;
      end;
    end;
end;
procedure stereo;
var w2,r2,rr,w,xm,ym:real;
procedure kkreis;
begin
    xm:=b+w*cos(zyklus*pi/180);
    ym:=h-w*sin(zyklus*pi/180);
    bitmap.canvas.ellipse(round(xm-rr),round(ym-rr),round(xm+rr+1),round(ym+rr+1));
end;
begin
    with bitmap.canvas do
    begin
      brush.color:=clblue;
      pen.color:=clblue;
      ellipse(b-r,h-r,b+r+1,h+r+1);
      rr:=214/250*r;
      w:=(2*r-2*rr-2)/2;
      brush.color:=clyellow;
      pen.color:=clyellow;
      kkreis;
      rr:=194/250*r;
      w:=(2*r-2*rr-4)/2;
      brush.color:=clblue;
      pen.color:=clblue;
      kkreis;
      rr:=156/250*r;
      w:=(2*r-2*rr-6)/2;
      brush.color:=clyellow;
      pen.color:=clyellow;
      kkreis;
      rr:=126/250*r;
      w:=(2*r-2*rr-8)/2;
      brush.color:=clblue;
      pen.color:=clblue;
      kkreis;
      r2:=rr;
      w2:=w;
      rr:=98/250*r;
      w:=w2-(r2-rr)+2;
      brush.color:=clyellow;
      pen.color:=clyellow;
      kkreis;
      rr:=78/250*r;
      w:=w2-(r2-rr)+4;
      brush.color:=clblue;
      pen.color:=clblue;
      kkreis;
      rr:=34/250*r;
      w:=w2-(r2-rr)+6;
      brush.color:=clyellow;
      pen.color:=clyellow;
      kkreis;
    end;
end;
procedure blinien;
var xm,ym:real;
    po:array[0..4] of tpoint;
procedure kquadrat;
begin
    po[0].x:=round(xm-100);  po[0].y:=round(ym);
    po[1].x:=round(xm);  po[1].y:=round(ym-100);
    po[2].x:=round(xm+100);  po[2].y:=round(ym);
    po[3].x:=round(xm);  po[3].y:=round(ym+100);
    bitmap.canvas.polygon(slice(po,4));
end;
begin
    with bitmap.canvas do
    begin
      xm:=b+40*cos(zyklus*pi/180);
      ym:=h-40*sin(zyklus*pi/180);
      brush.color:=clwhite;
      pen.color:=clblue;
      pen.width:=3;
      po[0].x:=round(xm-200);  po[0].y:=round(ym);
      po[1].x:=round(xm);  po[1].y:=round(ym-200);
      po[2].x:=round(xm+200);  po[2].y:=round(ym);
      po[3].x:=round(xm);  po[3].y:=round(ym+200);
      polygon(slice(po,4));
      pen.width:=1;
      pen.style:=psclear;
      if not checkbox1.checked then brush.color:=clwhite
                               else brush.color:=clgreen;
      xm:=b-200;
      ym:=h;
      kquadrat;
      xm:=b+200;
      ym:=h;
      kquadrat;
      xm:=b;
      ym:=h-200;
      kquadrat;
      xm:=b;
      ym:=h+200;
      kquadrat;
      pen.style:=pssolid;
    end;
end;
procedure shapiro2;
var mm,r1,r2,b1,b2:integer;
begin
    r1:=150;
    r2:=75;
    b1:=b-r1-20;
    b2:=b+r1+20;
    bitmap.canvas.pen.style:=psclear;
    if not checkbox1.checked then
    begin
      bitmap.canvas.Brush.color:=$00d0d0d0;
      bitmap.canvas.ellipse(b1-r1,h-r1,b1+r1+1,h+r1+1);
      bitmap.canvas.Brush.color:=clblack;
      bitmap.canvas.ellipse(b2-r1,h-r1,b2+r1+1,h+r1+1);
    end;
    if zyklus<32 then mm:=zyklus
                 else mm:=63-zyklus;
    bitmap.canvas.Brush.color:=rgb(8*mm,8*mm,8*mm);
    bitmap.canvas.ellipse(b1-r2,h-r2,b1+r2+1,h+r2+1);
    bitmap.canvas.ellipse(b2-r2,h-r2,b2+r2+1,h+r2+1);
end;

//Steuerung
begin
    bitmap:=tbitmap.create;
    bitmap.width:=PB1.width;
    bitmap.height:=PB1.height;
    b:=bitmap.width div 2;
    h:=bitmap.height div 2;

    case pnr of
      0 : yinyang;
      1 : shapiro;
      2 : begin
            r:=h-60;
            zyklus:=zyklus mod 16;
            speichen;
          end;
      3 : begin
            zyklus:=zyklus mod 360;
            helm;
          end;
      4 : begin
            zyklus:=zyklus mod 360;
            oquadrat;
          end;
      5 : begin
            r:=h-90;
            zyklus:=zyklus mod 360;
            stereo;
          end;
      6 : begin
            r:=r-50;
            zyklus:=zyklus mod 360;
            blinien;
          end;
      7 : begin
            inc(zyklus);
            zyklus:=zyklus mod 64;
            shapiro2;
          end;
    end;

    PB1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    inc(zyklus,updown1.position);
    PB1paint(sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then button1.caption:='Stop'
                      else button1.caption:='Start';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    zyklus:=0;
    pnr:=0;
    combobox1.itemindex:=0;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var h:integer;
begin
    checkbox1.visible:=false;
    h:=combobox1.itemindex;
    if h>=0 then begin
      pnr:=h;
      case pnr of
        0,5 : edit1.text:='5';
          1 : edit1.text:='2';
        2,3 : edit1.text:='1';
        4,7 : begin
                checkbox1.visible:=true;
                edit1.text:='1';
              end;
          6 : begin
                checkbox1.visible:=true;
                edit1.text:='5';
              end;
      end;
      form1.caption:=combobox1.text;
      pb1paint(sender);
    end;
end;

end.
