unit umerkur;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, math, Mask, Spin;

type
  TForm1 = class(TForm)
    Panel3: TPanel;
    Panel1: TPanel;
    perihel: TPanel;
    Panel2: TPanel;
    Label7: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Speed2: TSpeedButton;
    Speed3: TSpeedButton;
    Speed1: TSpeedButton;
    Paintbox1: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    Spin1: TSpinEdit;
    procedure S13Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Paintbox1Paint(Sender: TObject);
    procedure Speed2Click(Sender: TObject);
    procedure Speed1Click(Sender: TObject);
    procedure Speed3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

const xfaktor: real = 100;
      bahnlinien  : boolean = true;
      sabbruch : boolean = true;
      simula:boolean = false;
      einmal:boolean = false;
var   zeit:double;
      wert,verschiebung : real;
{$R *.DFM}

procedure TForm1.S13Click(Sender: TObject);
begin
   if sabbruch=false then
   begin
     sabbruch:=true;
     button1.caption:='Simulation';
   end
   else
     close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   sabbruch:=true;
   randomize;
   einmal:=false;
   zeit:=0;
   wert:=400;
   verschiebung:=0;
end;

procedure TForm1.Paintbox1Paint(Sender: TObject);
const links=0;
var bitmap,speicher:tbitmap;
    qrect,zrect:trect;
    mx,my:integer;
function wertx(x:real):integer;
begin
    wertx:=round(x);{round(1.95*(x-30));}
end;
procedure pic2(const can:tcanvas;a,b:integer;nr:integer);
var bild:tbitmap;
begin
  bild:=tbitmap.create;
  bild.loadfromresourceid(hinstance,nr);
  can.draw(a,b,bild);
  bild.free;
end;

var zab:real;
    kn,ex,r,p:real;
    i,x,y:integer;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=Paintbox1.width;
    bitmap.height:=Paintbox1.height;

    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.style:=[fsbold];
    mx:=Paintbox1.width div 2;
    my:=Paintbox1.height div 2;
    qrect:=Paintbox1.clientrect;
    zrect:=qrect;
    speicher:=tbitmap.create;
    speicher.width:=Paintbox1.width;
    speicher.height:=Paintbox1.height;
    speicher.canvas.brush.color:=clblack;
    speicher.canvas.rectangle(-1,-1,bitmap.width+1,bitmap.height+1);

    with bitmap.canvas do
    begin
      repeat
        if einmal then
        begin
          speicher.canvas.brush.color:=clblack;
          speicher.canvas.rectangle(-1,-1,bitmap.width+1,bitmap.height+1);
          einmal:=false;
        end;
        brush.color:=clblack;
        rectangle(-1,-1,bitmap.width+1,bitmap.height+1);
        zab:=round(Spin1.value)/100;
        if zab=0 then zab:=1;
        if (not sabbruch) then
        begin
          bitmap.canvas.copyrect(qrect,speicher.canvas,zrect);
          application.processmessages;
        end;
          p:=strtofloat(edit1.text);
          ex:=strtofloat(edit2.text);
        if (ex<0) or (ex>0.99) then
        begin
          ex:=0.207;
          edit2.text:='0.207';
        end;
        p:=p*(1+ex);
        kn:=0+verschiebung;
        pen.color:=$0000ffff;
        if sabbruch then
        begin
          r:=wert*p/(1+ex*cos(0));
          x:=wertx(mx+links+r*cos(pi/180*kn));
          y:=wertx(my-r*sin(pi/180*kn));
          moveto(x,y);
          for i:=1 to 180 do
          begin
            r:=wert*p/(1+ex*cos(2*pi/180*i));
            x:=wertx(mx+links+r*cos(pi/180*(2*i+kn)));
            y:=wertx(my-r*sin(pi/180*(2*i+kn)));
            lineto(x,y);
          end;
        end;
        r:=wert*p/(1+ex*cos(2*pi/180*zeit));
        x:=wertx(mx+links+r*cos(pi/180*(2*zeit+kn)));
        y:=wertx(my-r*sin(pi/180*(2*zeit+kn)));
        pic2(bitmap.canvas,wertx(mx-10+links),wertx(my-10),1244);
        if sabbruch then
        begin
          brush.color:=clred;
          pen.Color:=clred;
          ellipse(x-5,y-5,x+6,y+6);
          brush.Style:=bsclear;
          textout(x+4,y+4,'Merkur');
        end
        else
        begin
          pen.color:=$0000ffff;
          brush.color:=$0000ffff;
          pixels[x,y]:=$0000ffff;
          speicher.canvas.CopyRect(qrect,bitmap.canvas,zrect);
          brush.color:=clred;
          pen.Color:=clred;
          ellipse(x-5,y-5,x+6,y+6);
          brush.Style:=bsclear;
        end;
        label1.caption:=format('%.2f " in 100 Jahren',[9.912945/sqrt(p*p*p)/(1-ex*ex)*sqrt((1+ex)*(1+ex)*(1+ex))]);
        paintbox1.canvas.copyrect(qrect,bitmap.canvas,zrect);
        application.ProcessMessages;
        zeit:=zeit+zab;
        verschiebung:=verschiebung+zab/50;
      until sabbruch;
    end;
    bitmap.free;
    speicher.free;
    sabbruch:=true;
    button1.caption:='Simulation';
end;

procedure TForm1.Speed2Click(Sender: TObject);
begin
    einmal:=true;
    wert:=1.1*wert;
    if wert>600 then wert:=600;
    if sabbruch then Paintbox1Paint(Sender);
end;

procedure TForm1.Speed1Click(Sender: TObject);
begin
    einmal:=true;
    wert:=wert/1.1;
    if sabbruch then Paintbox1Paint(Sender);
end;

procedure TForm1.Speed3Click(Sender: TObject);
begin
    einmal:=true;
    wert:=400;
    if sabbruch then Paintbox1Paint(Sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    if sabbruch=true then
    begin
      sabbruch:=false;
      button1.caption:='Abbruch';
      application.processmessages;
      Paintbox1Paint(Sender);
    end
    else
    begin
      sabbruch:=true;
      button1.caption:='Simulation';
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    einmal:=true;
    if sabbruch then Paintbox1Paint(Sender);
end;

end.


