unit udreipyr;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, ExtDlgs, Menus, StdCtrls, Buttons, Dialogs;

type

  TForm1 = class(TForm)
    MM1: TMainMenu;
    M13: TMenuItem;
    M1: TMenuItem;
    M10: TMenuItem;
    Timer5: TTimer;
    P6: TPanel;
    tripeak: TPanel;
    PB9: TPaintBox;
    P8: TPanel;
    im1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    B1: TButton;
    D2: TButton;
    E1: TEdit;
    Memo1: TMemo;
    procedure S7C(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure PB9Paint(Sender: TObject);
    procedure PB9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D2Click(Sender: TObject);
    procedure E1Change(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
  private
    { Private declarations }
    procedure scoreauswerten(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

uses shellfolders, beste;

  {$R *.DFM}
var zeit,score,runde : integer;
    karten:array[1..53] of record
                             nr:integer;
                             offen:byte;
                             xy:tpoint;
                           end;
    stabellinks,stabelrechts:integer;

function  datenverzeichnissuchen:string;
begin
  Result := GetShellFolder(CSIDL_APPDATA);
  if (Result <> '') then
    Result := IncludeTrailingBackslash(IncludeTrailingBackslash(Result)+'Drei Pyramiden');
end;

procedure TForm1.S7C(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  datenverzeichnis:=datenverzeichnissuchen;
  if not directoryexists(datenverzeichnis) then createdir(datenverzeichnis);
  e1.text:=xname;
  spielname:='Drei Pyramiden';
  runde:=1;
  b1click(sender);
end;

procedure TForm1.B1Click(Sender: TObject);
var i,m,n,h:integer;
begin
  for i:=1 to 53 do begin
    karten[i].nr:=i;
    karten[i].offen:=2;
  end;
  stabellinks:=23;
  stabelrechts:=52;
  for i:=1 to 400 do begin
    m:=random(52)+1;
    n:=random(52)+1;
    h:=karten[m].nr;
    karten[m].nr:=karten[n].nr;
    karten[n].nr:=h;
  end;
  for i:=19 to 28 do
    karten[i].offen:=1;
  karten[52].offen:=1;
  if sender=b1 then begin
    score:=0;
    runde:=1;
  end;
  zeit:=0;
  timer5.enabled:=true;
  pb9paint(sender);
end;

procedure TForm1.PB9Paint(Sender: TObject);
var bitmap:tbitmap;
    can:tcanvas;
    i,b,h,xb,xh,xoff,yoff:integer;
    k:string;
  procedure xpic2d(a,b,n:integer);
  var qrect,zrect:trect;
  begin
    if (karten[n].offen=0) then exit;
    zrect.left:=a+xoff;
    zrect.top:=b+yoff;
    karten[n].xy.x:=a+xoff;
    karten[n].xy.y:=b+yoff;
    zrect.bottom:=zrect.top+96;
    zrect.right:=zrect.left+71;
    qrect.left:=((55-1) mod 8)*71;
    qrect.top:=((55-1) div 8)*96;
    qrect.bottom:=qrect.top+96;
    qrect.right:=qrect.left+71;
    can.CopyMode:=cmsrcpaint;
    can.copyrect(zrect,im1.picture.bitmap.canvas,qrect);
    if karten[n].offen=2 then begin
      qrect.left:=((53-1) mod 8)*71;
      qrect.top:=((53-1) div 8)*96;
    end else begin
      qrect.left:=((karten[n].nr-1) mod 8)*71;
      qrect.top:=((karten[n].nr-1) div 8)*96;
    end;
    qrect.bottom:=qrect.top+96;
    qrect.right:=qrect.left+71;
    can.CopyMode:=cmsrcand;
    can.copyrect(zrect,im1.picture.bitmap.canvas,qrect);
  end;

begin
  bitmap:=tbitmap.create;
  bitmap.width:=pb9.width;
  bitmap.height:=pb9.height;
  can:=bitmap.canvas;
  b:=bitmap.width;
  h:=bitmap.height;
  xb:=840 div 21;
  xh:=680 div 9;
  xoff:=(b-860) div 2;
  yoff:=(h-700) div 2;
  for i:=1 to 3 do begin
    xpic2d(-2*xb+6*i*xb,xh,i);
    xpic2d(-1*xb+6*i*xb,2*xh,3+2*i);
    xpic2d(-3*xb+6*i*xb,2*xh,2+2*i);

    xpic2d(-4*xb+6*i*xb,3*xh,7+3*i);
    xpic2d(-2*xb+6*i*xb,3*xh,8+3*i);
    xpic2d(0*xb+6*i*xb,3*xh,9+3*i);

    xpic2d(-5*xb+6*i*xb,4*xh,16+3*i);
    xpic2d(-3*xb+6*i*xb,4*xh,17+3*i);
    xpic2d(-1*xb+6*i*xb,4*xh,18+3*i);
  end;
  xpic2d(1*xb+6*3*xb,4*xh,28);
  can.brush.color:=clsilver;
  can.pen.color:=clsilver;
  can.rectangle(-6*xb+6*3*xb-10+xoff,6*xh-10+yoff,
                -6*xb+6*3*xb+10+71+xoff,6*xh+10+96+yoff);
  can.brush.style:=bsclear;
  xpic2d(-6*xb+6*3*xb,6*xh,stabelrechts);
  for i:=1 to stabellinks do
    xpic2d(-12*xb+6*3*xb+3*i,6*xh,53);
  can.font.name:='Verdana';
  can.font.color:=clnavy;
  can.font.style:=[fsbold,fsitalic];
  can.font.size:=18;
  if score>0 then k:=inttostr(score)+' Punkte / Runde '+inttostr(runde)
             else k:='0 Punkte / Runde '+inttostr(runde);
  can.textout(b div 2-can.textwidth(k) div 2,8*xh{-xh div 2}+yoff,k);
  pb9.canvas.draw(0,0,bitmap);
  bitmap.free;
  scoreauswerten(sender);
end;

procedure TForm1.PB9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,n,a:integer;
    gefunden:boolean;
procedure oeffnen(a,b,c:integer);
begin
  if (karten[a].offen=0) and (karten[b].offen=0) and (karten[c].offen<>0) then begin
    karten[c].offen:=1;
    score:=score+10;
  end;
end;
begin
  gefunden:=false;
  n:=0;
  for i:=1 to 52 do begin
    if (karten[i].offen=1) and (stabelrechts<>i) then begin
      if (x>karten[i].xy.x) and (x<karten[i].xy.x+72) and
         (y>karten[i].xy.y) and (y<karten[i].xy.y+96) then begin
         gefunden:=true;
         n:=i;
      end;
    end;
  end;
  if gefunden then begin
    a:=(130+karten[n].nr-karten[stabelrechts].nr) mod 13;
    if (a=1) or (a=12) then begin
      karten[n].offen:=0;
      if n in [1,2,3] then score:=score+500;
      karten[stabelrechts].nr:=karten[n].nr;
      score:=score+10;
      oeffnen(19,20,10);
      oeffnen(20,21,11);
      oeffnen(21,22,12);
      oeffnen(22,23,13);
      oeffnen(23,24,14);
      oeffnen(24,25,15);
      oeffnen(25,26,16);
      oeffnen(26,27,17);
      oeffnen(27,28,18);

      oeffnen(10,11,4);
      oeffnen(11,12,5);
      oeffnen(13,14,6);
      oeffnen(14,15,7);
      oeffnen(16,17,8);
      oeffnen(17,18,9);

      oeffnen(4,5,1);
      oeffnen(6,7,2);
      oeffnen(8,9,3);
      pb9paint(sender);
    end;
  end else score:=score-2;

  if stabellinks>0 then begin
    if (x>karten[53].xy.x) and (x<karten[53].xy.x+72) and
       (y>karten[53].xy.y) and (y<karten[53].xy.y+96) then begin
      karten[stabelrechts].nr:=karten[52-stabellinks].nr;
      dec(stabellinks);
      score:=score-2;
      pb9paint(sender);
    end;
  end;
end;

procedure TForm1.scoreauswerten(Sender: TObject);
var i,a:integer;
    noch:boolean;
    allesfrei:boolean;
begin
  noch:=false;
  allesfrei:=(karten[1].offen=0) and (karten[2].offen=0) and (karten[3].offen=0);
  if (stabellinks=0) or allesfrei then begin
    timer5.enabled:=false;
    for i:=1 to 52 do begin
      if karten[i].offen=1 then begin
        a:=(130+karten[i].nr-karten[stabelrechts].nr) mod 13;
        if a in [1,12] then noch:=true;
      end;
    end;
    if ((not noch) or allesfrei) and (runde<3) then begin
      inc(runde);
      showmessage('Runde '+inttostr(runde)+' starten');
      b1click(nil);
      exit;
    end;
    if (not noch) or allesfrei then begin
      spunkte:=score;
      score:=0;
      if spunkte>0 then begin
        Application.CreateForm(Tbestenliste, bestenliste);
        bestenliste.showmodal;
        bestenliste.release;
        spunkte:=0;
        score:=0;
      end;
    end;
  end;
end;

procedure TForm1.D2Click(Sender: TObject);
begin
  Application.CreateForm(Tbestenliste, bestenliste);
  bestenliste.showmodal;
  bestenliste.release;
end;

procedure TForm1.E1Change(Sender: TObject);
begin
  xname:=e1.text;
end;

procedure TForm1.Timer5Timer(Sender: TObject);
begin
  zeit:=zeit+1;
  score:=score-3;
  label4.caption:=timetostr(zeit/24/3600);
end;

end.

