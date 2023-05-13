unit urstab2;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls;

type
  TFrstab = class(TForm)
    rechenst: TPanel;
    PB1: TPaintBox;
    MainMenu1: TMainMenu;
    m1: TMenuItem;
    procedure PB1Paint(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1Paintwmf(canvas:tcanvas);
    procedure FormActivate(Sender: TObject);
    procedure m1Click(Sender: TObject);
  private
    rechenverschiebung, lauferverschiebung:integer;
    xrelativ:integer;
    gedrueckt : boolean;
    gedruecktlaufer : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frstab: TFrstab;

implementation

{$R *.DFM}

function _strkomma(a:real;b,c:byte):string;
var ks:string;
begin
   str(a:b:c,ks);
   if c<>0 then
   begin
      while (length(ks)>1) and (ks[length(ks)]='0') do delete(ks,length(ks),1);
      if (length(ks)>1) and (ks[length(ks)]='.') then delete(ks,length(ks),1);
   end;
   if ks='-0' then ks:='0';
   if pos('.',ks)>0 then ks[pos('.',ks)]:=',';
   _strkomma:=ks;
end;

function komma(s:string):string;
var i:integer;
begin
    if s<>'' then
       for i:=1 to length(s) do s[i]:=upcase(s[i]);
    if s<>'' then
       while pos(',',s)<>0 do s[pos(',',s)]:='.';
    komma:=s;
end;

procedure TFrstab.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
begin
     bitmap:=tbitmap.create;
     bitmap.width:=pb1.width;
     bitmap.height:=pb1.height;
     PB1Paintwmf(bitmap.canvas);
     pb1.canvas.draw(0,0,bitmap);
     bitmap.free;
end;

procedure TFrstab.PB1PaintWMF(canvas:tcanvas);
const
    rehoehe:integer=120;
var stabbreite,fakk:integer;
    cfverschiebung:integer;
    nichtzeichnen:boolean;

procedure stab(x,y:integer;v:integer);
var xbr,vbr:real;
    i:integer;
procedure linie(x:real;l:integer);
var l2:integer;
begin
    l2:=round(rehoehe/120*l);
    if (cfverschiebung<>0) then begin
       if v=1 then
       begin
          if x+cfverschiebung>stabbreite+rechenverschiebung then x:=x-stabbreite+40;
       end
       else
          if x+cfverschiebung>stabbreite then x:=x-stabbreite+40;
    end;

    if v=0 then
    begin
      canvas.MoveTo(round(x+cfverschiebung),y+rehoehe);
      canvas.lineTo(round(x+cfverschiebung),y+rehoehe-l2);
    end
    else
    begin
      canvas.MoveTo(round(x+cfverschiebung),y);
      canvas.lineTo(round(x+cfverschiebung),y+l2);
    end;
end;
procedure text(x:real;l:integer;const k:string);
var l2:integer;
begin
    l2:=round(rehoehe/120*l);
    if (cfverschiebung<>0) then begin
       if v=1 then
       begin
          if x+cfverschiebung>stabbreite+rechenverschiebung then x:=x-stabbreite+40;
       end
       else
          if x+cfverschiebung>stabbreite then x:=x-stabbreite+40;
    end;

    if v=0 then
      canvas.textout(round(x+cfverschiebung),y+rehoehe-l2,k)
    else
     canvas.textout(round(x+cfverschiebung),y+l2-12,k)
end;
begin
    canvas.font.name:='Verdana';
    canvas.font.size:=9;
    canvas.pen.color:=clgray;
    canvas.pen.width:=1;
  if not nichtzeichnen then begin
      if canvas.brush.color=$00c0ffff then
        canvas.roundrect(20+x,y,20+x+stabbreite,y+2*rehoehe+2,10,10)
      else
        canvas.roundrect(20+x,y,20+x+stabbreite,y+rehoehe+2,10,10);
    end;
    canvas.pen.color:=clmaroon;
    linie(40+x,80);
    linie(x+stabbreite,80);
    canvas.pen.width:=1;
    canvas.brush.style:=bsclear;
    xbr:=stabbreite-40;

    //logarithmische Skalen
    if cfverschiebung=0 then
    begin
      if v=0 then text(46+x,115,'Skale C')
             else text(46+x,115,'Skale D');
    end
    else
    begin
      if v=0 then text(46+x,115,'Skale CF')
             else text(46+x,115,'Skale DF');
    end;
    if y=392 then fakk:=10 else fakk:=0;

      if (cfverschiebung=0) then
        text(x+stabbreite-10,98,'10');
      text(36+x,98,'1');
      for i:=101 to 149 do
      begin
        vbr:=ln(i/100)/ln(10)*xbr;
        linie(40+x+vbr,10);
      end;
      for i:=76 to 149 do
      begin
        vbr:=ln(i/50)/ln(10)*xbr;
        linie(40+x+vbr,10);
      end;
      for i:=61 to 199 do
      begin
        vbr:=ln(i/20)/ln(10)*xbr;
        linie(40+x+vbr,10);
      end;
      for i:=11 to 99 do
      begin
        vbr:=ln(i/10)/ln(10)*xbr;
        linie(40+x+vbr,20);
        if i in [11..14,16..19] then
          text(30+x+vbr,36,_strkomma(i/10,1,1));
      end;
      for i:=2 to 9 do
      begin
        vbr:=ln(i)/ln(10)*xbr;
        linie(40+x+vbr,80);
        text(37+x+vbr,96,_strkomma(i,1,0));
      end;
      for i:=1 to 9 do
      begin
        vbr:=ln(i+0.5)/ln(10)*xbr;
        linie(40+x+vbr,50);
        text(30+x+vbr,68,_strkomma(i+0.5,1,1));
      end;
      canvas.pen.width:=1;
end;

begin
    stabbreite:=pb1.width-40;

    //Skalen
    rehoehe:=(pb1.height-60) div 4;

    //Läufer
    canvas.brush.color:=$0040ffff;
    canvas.pen.color:=clblue;
    canvas.pen.width:=1;
    Canvas.roundrect(lauferverschiebung-5,6,lauferverschiebung+125,4*rehoehe+38,10,10);
    canvas.brush.color:=clwhite;
    Canvas.roundrect(lauferverschiebung+15,26,lauferverschiebung+105,4*rehoehe+18,10,10);

    nichtzeichnen:=false;
    canvas.brush.color:=$00c0ffff;
    cfverschiebung:=round(ln(pi)/ln(10)*(stabbreite-40));
    stab(rechenverschiebung,22+rehoehe,1);

    nichtzeichnen:=true;
    cfverschiebung:=0;
    canvas.brush.color:=$00c0ffff;
    stab(rechenverschiebung,22+2*rehoehe,0);

    nichtzeichnen:=false;
    canvas.brush.color:=$00ffffc0;
    stab(0,24+3*rehoehe,1);

    nichtzeichnen:=false;
    cfverschiebung:=round(ln(pi)/ln(10)*(stabbreite-40));
    canvas.brush.color:=$00ffffc0;
    stab(0,20,0);

    //Läuferstab
    canvas.pen.width:=1;
    canvas.pen.style:=pssolid;
    canvas.pen.color:=clblue;
    Canvas.moveto(lauferverschiebung+60,18);
    Canvas.lineto(lauferverschiebung+60,4*rehoehe+27);
end;

procedure TFrstab.PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var rehoehe:integer;
begin
   rehoehe:=(pb1.height-60) div 4;
   if pb1.canvas.pixels[x,y]=$0040ffff then
   begin
     gedruecktlaufer:=true;
     xrelativ:=x-lauferverschiebung;
   end
   else
     if ((y>20+rehoehe) and (y<22+3*rehoehe)) then
     begin
       gedrueckt:=true;
       xrelativ:=x-rechenverschiebung;
     end;
end;

procedure TFrstab.PB1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    if gedrueckt then
    begin
      rechenverschiebung:=x-xrelativ;
      pb1paint(sender)
    end;
    if gedruecktlaufer then
    begin
      lauferverschiebung:=x-xrelativ;
      if lauferverschiebung<-20 then lauferverschiebung:=-20;
      if lauferverschiebung>pb1.width-100 then lauferverschiebung:=pb1.width-100;
      pb1paint(sender)
    end;
end;

procedure TFrstab.PB1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if gedrueckt then
    begin
      gedrueckt:=false;
      rechenverschiebung:=x-xrelativ;
      pb1paint(sender);
    end;
    if gedruecktlaufer then
    begin
      gedruecktlaufer:=false;
      lauferverschiebung:=x-xrelativ;
      if lauferverschiebung<-20 then lauferverschiebung:=-20;
      if lauferverschiebung>pb1.width-100 then lauferverschiebung:=pb1.width-100;
      pb1paint(sender);
    end;
end;

procedure TFrstab.FormActivate(Sender: TObject);
begin
      gedrueckt := false;
      gedruecktlaufer := false;
      rechenverschiebung:=0;
      lauferverschiebung:=150;
end;

procedure TFrstab.m1Click(Sender: TObject);
begin
   close
end;

end.


