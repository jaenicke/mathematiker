unit uerde;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    BDrehung: TButton;
    CheckHori: TCheckBox;
    CheckVert: TCheckBox;
    Spinhori: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpinVert: TSpinEdit;
    CheckTran: TCheckBox;
    CheckEqua: TCheckBox;
    CheckNull: TCheckBox;
    CheckBkreis: TCheckBox;
    CheckLKreis: TCheckBox;
    CheckAchse: TCheckBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure BDrehungClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TvertChange(Sender: TObject);
    procedure ThoriChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

const eneigung = -23.4*pi/180;

{$R *.DFM}

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    d:textfile;
    modus,xmitte,ymitte,xpos,ypos,radius:integer;
    ebreite,elaenge,glaenge,gbreite,yp,xp:double;
    cosgbreite,sinyp,cosyp:double;
    transparent:boolean;
procedure erdachse(var xpos,ypos:integer);
var x,y,x0,y0:double;
begin
  x:=cosgbreite*sin(xp-glaenge);
  y:=sin(yp-gbreite)-cosgbreite*(1-cos(xp-glaenge))*sinyp;
  if checkachse.checked then begin
    x0:=cos(eneigung)*x+sin(eneigung)*y;
    y0:=-sin(eneigung)*x+cos(eneigung)*y;
    xpos:=round(xmitte+x0*radius);
    ypos:=round(ymitte+y0*radius);
  end else begin
    xpos:=round(xmitte+radius*x);
    ypos:=round(ymitte+radius*y);
  end;
end;
begin
  bitmap:=tbitmap.create;
  bitmap.width:=paintbox1.width;
  bitmap.height:=paintbox1.height;
  transparent:=checktran.checked;
  xmitte:=paintbox1.width div 2;
  ymitte:=paintbox1.height div 2;
  yp:=-pi/180*spinhori.value;
  xp:=pi/180*spinvert.value;
  sinyp:=sin(yp);
  cosyp:=cos(yp);
  radius:=paintbox1.height div 2-10;
  bitmap.canvas.Pen.color:=clblack;
  bitmap.canvas.ellipse(xmitte-radius,ymitte-radius,xmitte+radius+1,ymitte+radius+1);

  if checkequa.checked or checkbkreis.Checked then begin
    if checkbkreis.checked then ebreite:=-75
                           else ebreite:=0;
    repeat
      gbreite:=pi/180*ebreite;
      cosgbreite:=cos(gbreite);
      modus:=0;
      elaenge:=0;
      bitmap.Canvas.Pen.color:=clblue;
      repeat
        glaenge:=pi/180*elaenge;
        erdachse(xpos,ypos);
        if ((sinyp*sin(gbreite)+cosyp*cosgbreite*cos(xp-glaenge)>0)
             and not transparent) or (modus=0)
        then begin
          bitmap.canvas.moveto(xpos,ypos);
          modus:=1;
        end else
          bitmap.canvas.lineto(xpos,ypos);
        elaenge:=elaenge+2;
      until elaenge>360;
      ebreite:=ebreite+15;
    until (ebreite>75) or (not checkbkreis.Checked);
  end;
  if checknull.checked or checklkreis.Checked then begin
    bitmap.Canvas.Pen.color:=clblue;
    elaenge:=0;
    repeat
      modus:=0;
      ebreite:=0;
      glaenge:=pi/180*elaenge;
      repeat
        gbreite:=pi/180*ebreite;
        cosgbreite:=cos(gbreite);
        erdachse(xpos,ypos);
        if ((sinyp*sin(gbreite)+cosyp*cosgbreite*cos(xp-glaenge)>0)
               and not transparent) or (modus=0)
        then begin
          bitmap.canvas.moveto(xpos,ypos);
          modus:=1;
        end else
          bitmap.canvas.lineto(xpos,ypos);
        ebreite:=ebreite+2;
      until ebreite>360;
      elaenge:=elaenge+30;
    until (elaenge>355) or (not checklkreis.checked);
  end;

  bitmap.canvas.Pen.color:=clblack;
  assignfile(d,'erde2.000');
  reset(d);
  repeat
    readln(d,ebreite,elaenge,modus);
    gbreite:=pi/180*ebreite;
    glaenge:=pi/180*elaenge;
    cosgbreite:=cos(gbreite);
    erdachse(xpos,ypos);
    if (modus=0)
        or ((sinyp*sin(gbreite)+cosyp*cosgbreite*cos(xp-glaenge)>0)
           and not transparent)
    then
      bitmap.canvas.moveto(xpos,ypos)
    else
      bitmap.canvas.lineto(xpos,ypos);
  until eof(d);
  closefile(d);

  paintbox1.canvas.draw(0,0,bitmap);
  bitmap.Free;
end;

procedure TForm1.BDrehungClick(Sender: TObject);
begin
  timer1.enabled:=not timer1.enabled;
  if timer1.enabled then BDrehung.caption:='Stopp'
                    else BDrehung.caption:='Drehung';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var z:integer;
begin
  if checkhori.checked then begin
    z:=spinvert.value;
    inc(z);
    if z>360 then z:=0;
    spinvert.value:=z;
  end;
  if checkvert.checked then begin
    z:=spinhori.value;
    inc(z);
    if z>180 then z:=-180;
    spinhori.value:=z;
  end;
  paintbox1paint(sender);
end;

procedure TForm1.TvertChange(Sender: TObject);
begin
   if timer1.enabled=false then paintbox1paint(sender);
end;

procedure TForm1.ThoriChange(Sender: TObject);
begin
   if timer1.enabled=false then paintbox1paint(sender);
end;

end.
