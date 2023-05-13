unit urstab;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}
{$J+}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Grids;

type
  TForm1 = class(TForm)
    rechenst: TPanel;
    PB1: TPaintBox;
    Panel3: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    RG1: TRadioGroup;
    SG1: TStringGrid;
    procedure PB1Paint(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1DblClick(Sender: TObject);
    procedure PB1Paintwmf(canvas:tcanvas);
    procedure FormActivate(Sender: TObject);
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
  Form1: TForm1;

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

procedure TForm1.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
begin
     bitmap:=tbitmap.create;
     bitmap.width:=pb1.width;
     bitmap.height:=pb1.height;
     PB1Paintwmf(bitmap.canvas);
     pb1.canvas.draw(0,0,bitmap);
     bitmap.free;
end;

procedure TForm1.PB1PaintWMF(canvas:tcanvas);
const
    rehoehe:integer=120;
var stabbreite,fakk:integer;
    wert,wert1,wert2:real;
    k:string;
    code:integer;

procedure stab(x,y:integer;v:integer);
var xbr,vbr:real;
    i:integer;
procedure linie(x:real;l:integer);
var l2:integer;
begin
    l2:=round(rehoehe/120*l);
    if v=0 then
    begin
      canvas.MoveTo(round(x),y+rehoehe);
      canvas.lineTo(round(x),y+rehoehe-l2);
    end
    else
    begin
      canvas.MoveTo(round(x),y);
      canvas.lineTo(round(x),y+l2);
    end;
end;
procedure text(x:real;l:integer;const k:string);
var l2:integer;
begin
    l2:=round(rehoehe/120*l);
    if v=0 then
      canvas.textout(round(x),y+rehoehe-l2,k)
    else
     canvas.textout(round(x),y+l2-12,k)
end;
begin
    canvas.font.name:='Verdana';
    canvas.font.size:=9;
    canvas.pen.color:=clgray;
    canvas.pen.width:=1;
    canvas.roundrect(20+x,y,20+x+stabbreite,y+rehoehe+2,10,10);
    canvas.pen.color:=clmaroon;
    linie(40+x,80);
    linie(x+stabbreite,80);
    canvas.pen.width:=1;
    canvas.brush.style:=bsclear;
    xbr:=stabbreite-40;

    //logarithmische Skalen
    if v=0 then text(46+x,115,'Skale C')
           else text(46+x,115,'Skale D');
    if y=392 then fakk:=10 else fakk:=0;
    if rg1.itemindex=1 then
    begin
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
    end
    else
    begin

      //lineare skalen
      text(36+x,98,inttostr(fakk+0));
      text(x+stabbreite-10,98,inttostr(fakk+10));
      for i:=1 to 199 do
      begin
        vbr:=(i/20)/10*xbr;
        linie(40+x+vbr,10);
      end;
      for i:=1 to 99 do
      begin
        vbr:=(i/10)/10*xbr;
        linie(40+x+vbr,20);
      end;
      for i:=1 to 9 do
      begin
        vbr:=i/10*xbr;
        linie(40+x+vbr,80);
        text(37+x+vbr,96,_strkomma(fakk+i,1,0));
      end;
      for i:=1 to 10 do
      begin
        vbr:=(i-0.5)/10*xbr;
        linie(40+x+vbr,50);
        text(30+x+vbr,68,_strkomma(fakk+i-0.5,1,1));
      end;
      canvas.pen.width:=1;
    end;
end;

begin
    if rg1.itemindex=1 then
    begin
      sg1.cells[0,1]:='obere Einheit';
      sg1.cells[0,2]:='untere Einheit';
    end
    else
    begin
      sg1.cells[0,1]:='obere Null';
      sg1.cells[0,2]:='untere Null';
    end;

    stabbreite:=pb1.width-40;

    //Skalen
    rehoehe:=(pb1.height-60) div 4;
    canvas.brush.color:=$00c0ffff;
    stab(rechenverschiebung,20,0);
    canvas.brush.color:=$00ffffc0;
    stab(0,22+rehoehe,1);
    canvas.brush.color:=$00c0ffff;
    stab(stabbreite-40+rechenverschiebung,pb1.height div 2,0);
    canvas.brush.color:=$00c0ffff;
    stab(-stabbreite+40+rechenverschiebung,pb1.height div 2,0);
    canvas.brush.color:=$00ffffc0;
    stab(0,pb1.height div 2+2+rehoehe,1);

    //Läufer
    canvas.brush.style:=bsclear;
    canvas.pen.color:=clblue;
    canvas.pen.width:=1;
    Canvas.rectangle(lauferverschiebung-5,10,lauferverschiebung+125,pb1.height div 2+2*rehoehe+14);
    canvas.pen.width:=1;
    Canvas.roundrect(lauferverschiebung+6,16,lauferverschiebung+114,pb1.height div 2+2*rehoehe+8{520},40,40);
    canvas.brush.color:=$0040ffff;//clyellow;
    Canvas.floodfill(lauferverschiebung+4,12,clblue,fsborder);
    Canvas.floodfill(lauferverschiebung+112,12,clblue,fsborder);
    canvas.brush.style:=bsclear;
    canvas.pen.width:=1;
    canvas.pen.style:=psdot;
    canvas.pen.color:=clgray;
    Canvas.moveto(lauferverschiebung+60,16);
    Canvas.lineto(lauferverschiebung+60,pb1.height div 2+2*rehoehe+8{520});

    //Rechnung
    if rg1.itemindex=1 then
    begin
      wert:=rechenverschiebung/(stabbreite-40);
      wert:=exp(ln(10)*wert);
      if wert<1 then wert:=10*wert;
      if wert>10 then wert:=wert/10;
      sg1.cells[2,2]:='1';
      sg1.cells[2,1]:=_strkomma(wert,1,2);
      sg1.cells[1,1]:='1';
      wert:=10/wert;
      if wert<1 then wert:=10*wert;
      if wert>10 then wert:=wert/10;
      sg1.cells[1,2]:=_strkomma(wert,1,2);

      wert:=exp(ln(10)*(lauferverschiebung+20)/(stabbreite-40));
      if wert<1 then wert:=10*wert;
      if wert>10 then wert:=wert/10;
      sg1.cells[2,3]:=_strkomma(wert,1,2);

      wert:=exp(ln(10)*(lauferverschiebung+20-rechenverschiebung)/(stabbreite-40));
      if wert<1 then wert:=10*wert;
      if wert>10 then wert:=wert/10;
      sg1.cells[1,3]:=_strkomma(wert,1,2);
    end
    else
    begin
      wert:=10*rechenverschiebung/(stabbreite-40);
      sg1.cells[2,2]:='0';
      if wert<0 then wert:=wert+10;
      sg1.cells[2,1]:=_strkomma(wert,1,2);
      sg1.cells[1,1]:='0';
      wert:=10-wert;
      sg1.cells[1,2]:=_strkomma(wert,1,2);

      wert:=10*(lauferverschiebung+20)/(stabbreite-40);
      if wert<0 then wert:=wert+10;
      sg1.cells[2,3]:=_strkomma(wert,1,2);

      wert:=10*(lauferverschiebung+20-rechenverschiebung)/(stabbreite-40);
      if wert<0 then wert:=wert+10;
      sg1.cells[1,3]:=_strkomma(wert,1,2);
    end;

    k:=sg1.cells[2,1];
    if rg1.itemindex=1 then
    begin
      k:=k+' · ';
      val(komma(sg1.cells[2,1]),wert1,code);
      val(komma(sg1.cells[1,3]),wert2,code);
      val(komma(sg1.cells[2,3]),wert,code);
      if wert1*wert2>10 then wert:=10*wert;
      label2.caption:=k+sg1.cells[1,3]+' = '+_strkomma(wert,1,2);
    end
    else
    begin
      k:=k+'+';
      val(komma(sg1.cells[2,1]),wert1,code);
      val(komma(sg1.cells[1,3]),wert2,code);
      val(komma(sg1.cells[2,3]),wert,code);
      if wert1+wert2>10 then wert:=10+wert;
      label2.caption:=k+sg1.cells[1,3]+' = '+_strkomma(wert,1,2);
    end;
end;

procedure TForm1.PB1MouseDown(Sender: TObject; Button: TMouseButton;
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
     if ((y>20) and (y<22+rehoehe)) or ((y>(pb1.height div 2)) and (y<(pb1.height div 2+2+rehoehe))) then
     begin
       gedrueckt:=true;
       xrelativ:=x-rechenverschiebung;
     end;
end;

procedure TForm1.PB1MouseMove(Sender: TObject; Shift: TShiftState;
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

procedure TForm1.PB1MouseUp(Sender: TObject; Button: TMouseButton;
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

procedure TForm1.PB1DblClick(Sender: TObject);
begin
      Panel3.visible:=not Panel3.visible;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
      gedrueckt := false;
      gedruecktlaufer := false;
      sg1.cells[1,0]:='obere Skale';
      sg1.cells[2,0]:='untere Skale';
      sg1.cells[0,3]:='Läufer';
      rechenverschiebung:=0;
      lauferverschiebung:=150;
end;

end.

