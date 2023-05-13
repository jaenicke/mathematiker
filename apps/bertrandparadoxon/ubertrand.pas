unit ubertrand;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, math;
{$J+}

type
  TForm1 = class(TForm)
    panel5: TPanel;
    panel4: TPanel;
    bertrand: TPanel;
    panel6: TPanel;
    panel2: TPanel;
    Panel3: TPanel;
    panel1: TPanel;
    Paintbox1: TPaintBox;
    Button1: TButton;
    Label15: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure M5Click(Sender: TObject);
    procedure bertrandResize(Sender: TObject);
    procedure Paintbox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;

implementation

const sabbruch : boolean = true;
var   br2,bb3,bb6,bh2:integer;
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   randomize;
end;

procedure TForm1.M5Click(Sender: TObject);
begin
   button1click(sender);
end;

procedure TForm1.bertrandResize(Sender: TObject);
begin
    panel1.width:=bertrand.width div 3;
    panel3.width:=bertrand.width div 3;
end;

procedure TForm1.Paintbox1Paint(Sender: TObject);
var bitmap:tbitmap;
    ziel:tcanvas;
    radius:integer;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=Paintbox1.width;
    bitmap.height:=Paintbox1.height;
    bb3:=bitmap.width div 3;
    bh2:=bitmap.height div 4;
    bb6:=bb3 div 2;
    radius:=bb6-10;
    if radius>bh2-10 then radius:=bh2-10;
    br2:=radius;

    ziel:=bitmap.canvas;
    ziel.pen.color:=clblue;
    ziel.ellipse(bb6-radius,bh2-radius,bb6+radius+1,bh2+radius+1);
    ziel.ellipse(bb6+bb3-radius,bh2-radius,bb6+bb3+radius+1,bh2+radius+1);
    ziel.ellipse(bb6+2*bb3-radius,bh2-radius,bb6+2*bb3+radius+1,bh2+radius+1);

    ziel.ellipse(bb6-radius,3*bh2-radius,bb6+radius+1,3*bh2+radius+1);
    ziel.ellipse(bb6+bb3-radius,3*bh2-radius,bb6+bb3+radius+1,3*bh2+radius+1);
    ziel.ellipse(bb6+2*bb3-radius,3*bh2-radius,bb6+2*bb3+radius+1,3*bh2+radius+1);

    ziel.font.name:='Verdana';
    ziel.font.size:=8;
    ziel.textout(bb6+radius div 2+1,bh2+radius-16,'Sehnen');
    ziel.textout(bb6+bb3+radius div 2+1,bh2+radius-16,'Sehnen');
    ziel.textout(bb6+2*bb3+radius div 2+1,bh2+radius-16,'Sehnen');

    ziel.textout(bb6+radius div 2+2,3*bh2+radius-16,'Mittelpunkte');
    ziel.textout(bb6+bb3+radius div 2+2,3*bh2+radius-16,'Mittelpunkte');
    ziel.textout(bb6+2*bb3+radius div 2+2,3*bh2+radius-16,'Mittelpunkte');

    Paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var vwert,diff,wi1,wi2,x1,y1,x2,y2,xm,ym,abstand:real;
    anz,treffer,treffer2,treffer3:integer;
begin
   if sabbruch=false then
     sabbruch:=true
   else
   begin
     sabbruch:=false;
     button1.caption:='Abbruch';
     Paintbox1paint(sender);
     vwert:=sqrt(3)*br2;
     anz:=1;
     treffer:=0;
     treffer2:=0;
     treffer3:=0;
     Paintbox1.canvas.brush.color:=clwhite;
     Paintbox1.canvas.pen.color:=clsilver;

   repeat
     wi1:=2*pi*random;
     wi2:=2*pi*random;

     x1:=br2*cos(wi1);
     y1:=br2*sin(wi1);
     x2:=br2*cos(wi2);
     y2:=br2*sin(wi2);
     abstand:=sqrt(sqr(x1-x2)+sqr(y1-y2));

     Paintbox1.canvas.moveto(round(bb6+x1),round(bh2-y1));
     if anz<500 then Paintbox1.canvas.lineto(round(bb6+x2),round(bh2-y2));
     if abstand>vwert then
       inc(treffer);
     xm:=(x1+x2)/2;
     ym:=(y1+y2)/2;
     Paintbox1.canvas.pixels[round(bb6+xm),round(3*bh2-ym)]:=clblue;
     label15.caption:=inttostr(anz);
     label1.caption:=inttostr(treffer);
     label2.caption:=format('%2.3f %%',[100*treffer/anz]);
//methode 2
     wi1:=2*pi*random;
     diff:=br2*random;
     wi2:=arccos(diff/br2);

     x1:=br2*cos(wi1-wi2);
     y1:=br2*sin(wi1-wi2);

     x2:=br2*cos(wi1+wi2);
     y2:=br2*sin(wi1+wi2);
     abstand:=sqrt(sqr(x1-x2)+sqr(y1-y2));

     Paintbox1.canvas.moveto(round(bb6+bb3+x1),round(bh2-y1));
     if anz<500 then Paintbox1.canvas.lineto(round(bb6+bb3+x2),round(bh2-y2));
     if abstand>vwert then
       inc(treffer2);
     xm:=(x1+x2)/2;
     ym:=(y1+y2)/2;
     Paintbox1.canvas.pixels[round(bb6+bb3+xm),round(3*bh2-ym)]:=clblue;
     label4.caption:=inttostr(treffer2);
     label5.caption:=format('%2.3f %%',[100*treffer2/anz]);
//
//methode 3
     repeat
       x1:=2*br2*random-br2;
       y1:=2*br2*random-br2;
       diff:=sqrt(sqr(x1)+sqr(y1));
     until diff<br2;

     wi1:=arctan2(y1,x1);
     wi2:=arccos(diff/br2);

     x1:=br2*cos(wi1-wi2);
     y1:=br2*sin(wi1-wi2);

     x2:=br2*cos(wi1+wi2);
     y2:=br2*sin(wi1+wi2);
     abstand:=sqrt(sqr(x1-x2)+sqr(y1-y2));

     Paintbox1.canvas.moveto(round(bb6+2*bb3+x1),round(bh2-y1));
     if anz<500 then Paintbox1.canvas.lineto(round(bb6+2*bb3+x2),round(bh2-y2));
     if abstand>vwert then
       inc(treffer3);
     xm:=(x1+x2)/2;
     ym:=(y1+y2)/2;
     Paintbox1.canvas.pixels[round(bb6+2*bb3+xm),round(3*bh2-ym)]:=clblue;
     label13.caption:=inttostr(treffer3);
     label14.caption:=format('%2.3f %%',[100*treffer3/anz]);
     if anz mod 10 = 0 then application.processmessages;
     inc(anz);
   until {(anz>anz0) or }sabbruch;
     sabbruch:=true;
     button1.caption:='Simulation';
   end;
end;

end.


