unit uwythoff;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, ComCtrls, Buttons, Spin, Math;

type
  Tfrmwythoff = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Me1: TMemo;
    Button1: TButton;
    Check1: TCheckBox;
    pb1: TPaintBox;
    Timer1: TTimer;
    Check2: TCheckBox;
    Label3: TLabel;
    LB1: TListBox;
    Spin1: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure NewGame(sender:tobject);
    procedure TrackBar1Change(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure pb1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure ausgabe(s:boolean; sender:tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmwythoff: Tfrmwythoff;

implementation

var
  Squares,aktuell : Integer;
  Moves   : array [0..50] of record
   Col : Integer;
   Row : Integer;
  end;
  computer:boolean;
  hilfe:boolean;
const w=24; r=12;

{$R *.DFM}

procedure Tfrmwythoff.FormCreate(Sender: TObject);
begin
  Squares := 25;
  randomize;
  hilfe:=false;
  NewGame(sender);
end;

procedure Tfrmwythoff.NewGame;
begin
  moves[0].col:=random(squares div 2)+squares div 2+1;
  repeat
    moves[0].row:=random(squares div 2);
  until squares-moves[0].row<>moves[0].col;
  lb1.clear;
  timer1.enabled:=true;
  aktuell:=0;
  computer:=Check1.checked;
  pb1paint(sender);
end;

procedure Tfrmwythoff.TrackBar1Change(Sender: TObject);
begin
  Squares := Spin1.value;
  newgame(sender);
end;

procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:double;
    x,y:integer;
    pfe:array[0..3] of tpoint;
    wcos,wsin:extended;
  procedure kline(a,b,c,d:integer);
  begin
    can.moveto(a,b);
    can.lineto(c,d);
  end;
begin
  kline(a,b,c,d);
  if (a<>c) or (b<>d) then begin
    if (c-a)<>0 then
      wi:=pi-arctan((d-b)/(c-a))
    else begin
      if d<b then wi:=-pi/2
             else wi:=pi/2;
    end;
    sincos(wi-xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[0].x:=c+x;
    pfe[0].y:=d-y;
    pfe[1].x:=c;
    pfe[1].y:=d;
    sincos(wi+xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[2].x:=c+x;
    pfe[2].y:=d-y;
    can.brush.color:=can.pen.color;
    can.polygon(slice(pfe,3));
    can.brush.style:=bsclear;
  end;
end;

procedure Tfrmwythoff.pb1Paint(Sender: TObject);
var bitmap:tbitmap; k:string;
    x,y,b,h,i,j,xoffset,yoffset:integer;
  procedure hilfekreuze;
  var phi:double;
      i,m,n,x,y:integer;
  begin
    phi:=(1+sqrt(5))/2;
    for i:=0 to 45 do begin
      m:=trunc(i*phi);
      n:=squares-trunc(i*phi*phi);
      x:=xoffset+m*w;
      y:=yoffset+n*w;
      if (m<=squares) and (n>=0) then
        bitmap.canvas.rectangle(x-5,y-5,x+6,y+6);
      m:=trunc(i*phi*phi);
      n:=squares-trunc(i*phi);
      x:=xoffset+m*w;
      y:=yoffset+n*w;
      if (m<=squares) and (n>=0) then
        bitmap.canvas.rectangle(x-5,y-5,x+6,y+6);
    end;
  end;
begin
  bitmap:=tbitmap.create;
  bitmap.width:=pb1.width;
  bitmap.height:=pb1.height;
  b:=bitmap.width;
  h:=bitmap.height;
  xoffset:=(b-squares*w) div 2;
  yoffset:=(h-squares*w) div 2-10;
  with bitmap.canvas do begin
    pen.color:=clblue;
    pen.width:=1;
    for i:=0 to squares do begin
      moveto(xoffset+i*w,yoffset);
      lineto(xoffset+i*w,yoffset+squares*w);
      moveto(xoffset,yoffset+i*w);
      lineto(xoffset+squares*w,yoffset+i*w);
    end;
    brush.style:=bsclear;
    font.name:='Verdana';
    font.size:=8;
    for i:=0 to squares do begin
      k:=chr(65+i);
      if i>25 then k:='A'+chr(39+i);
      textout(xoffset+i*w-textwidth(k) div 2,yoffset+squares*w+4,k);
      k:=chr(65+squares-i);
      if 65+squares-i>90 then k:='A'+chr(39+squares-i);
      textout(xoffset-12-textwidth(k),yoffset+i*w-textheight(k) div 2,k);
    end;
    pen.width:=2;
    pen.color:=clblack;
    brush.color:=clwhite;
    for i:=0 to aktuell-1 do begin
      x:=xoffset+moves[i].col*w;
      y:=yoffset+moves[i].row*w;
      ellipse(x-10,y-10,x+11,y+11);
    end;
    pen.color:=clred;
    for i:=0 to aktuell-1 do begin
      xpfeilvoll(bitmap.canvas,xoffset+moves[i].col*w,yoffset+moves[i].row*w,
                 xoffset+moves[i+1].col*w,yoffset+moves[i+1].row*w);
    end;
    pen.width:=2;
    x:=xoffset+moves[aktuell].col*w;
    y:=yoffset+moves[aktuell].row*w;
    if Check2.checked then begin
      pen.color:=clred;
      xpfeilvoll(bitmap.canvas,x,y,x-2*(w-3),y);
      xpfeilvoll(bitmap.canvas,x,y,x,y+2*(w-3));
      xpfeilvoll(bitmap.canvas,x,y,x-2*(w-3),y+2*(w-3));
    end;
    pen.color:=clblack;
    brush.color:=clyellow;
    ellipse(x-r,y-r,x+r+1,y+r+1);
    if hilfe then hilfekreuze;
    brush.color:=clblack;
    if moves[aktuell].col>0 then begin
      i:=moves[aktuell].col-1;
      repeat
        x:=xoffset+i*w;
        y:=yoffset+moves[aktuell].row*w;
        if i>=0 then ellipse(x-4,y-4,x+5,y+5);
        dec(i);
      until i<0;
    end;
    if moves[aktuell].row<squares then begin
      i:=moves[aktuell].row+1;
      repeat
        x:=xoffset+moves[aktuell].col*w;
        y:=yoffset+i*w;
        if i<=squares then ellipse(x-4,y-4,x+5,y+5);
        inc(i);
      until i>squares;
    end;
    if (moves[aktuell].row<squares) or (moves[aktuell].col>0) then begin
      i:=moves[aktuell].col-1;
      j:=moves[aktuell].row+1;
      repeat
        x:=xoffset+i*w;
        y:=yoffset+j*w;
        if (i>=0) and (j<=squares) then ellipse(x-4,y-4,x+5,y+5);
        dec(i);
        inc(j);
      until (i<0) or (j>squares);
    end;
  end;
  pb1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure Tfrmwythoff.pb1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i,m,n,b,h,xoffset,yoffset:integer; korrekt:boolean;
begin
  b:=pb1.width;
  h:=pb1.height;
  xoffset:=(b-squares*w) div 2;
  yoffset:=(h-squares*w) div 2-10;
  m:=xoffset+moves[aktuell].col*w;
  n:=yoffset+moves[aktuell].row*w;
  korrekt:=false;
  for i:=1 to 36 do korrekt:=korrekt or ((abs(m-i*w-x)<16) and (abs(n-y)<16));
  for i:=1 to 36 do korrekt:=korrekt or ((abs(m-x)<16) and (abs(n-y+i*w)<16));
  for i:=1 to 36 do korrekt:=korrekt or ((abs(m-i*w-x)<16) and (abs(n-y+i*w)<16));
  if (moves[aktuell].col-round((m-x)/w)>=0)
         and (moves[aktuell].row-round((n-y)/w)<=squares) and korrekt
         then pb1.cursor:=crhandpoint else pb1.cursor:=crdefault;
end;

procedure Tfrmwythoff.ausgabe(s:boolean; sender:tobject);
var z:integer; k1,k2:string[5];
begin
  z:=65+moves[aktuell].col;
  if z>90 then k1:='A'+chr(z-26) else k1:=chr(z);
  z:=65+squares-moves[aktuell].row;
  if z>90 then k2:='A'+chr(z-26) else k2:=chr(z);
  if s then lb1.items.add('Spieler'#9+'('+k1+'|'+k2+')')
       else lb1.items.add('Computer'#9+'('+k1+'|'+k2+')');
end;

procedure Tfrmwythoff.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,m,n,b,h,xoffset,yoffset:integer; korrekt:boolean;
begin
  b:=pb1.width;
  h:=pb1.height;
  xoffset:=(b-squares*w) div 2;
  yoffset:=(h-squares*w) div 2-10;
  m:=xoffset+moves[aktuell].col*w;
  n:=yoffset+moves[aktuell].row*w;
  korrekt:=false;
  for i:=1 to 36 do korrekt:=korrekt or ((abs(m-i*w-x)<16) and (abs(n-y)<16));
  for i:=1 to 36 do korrekt:=korrekt or ((abs(m-x)<16) and (abs(n-y+i*w)<16));
  for i:=1 to 36 do korrekt:=korrekt or ((abs(m-i*w-x)<16) and (abs(n-y+i*w)<16));
  if korrekt then begin
    if (moves[aktuell].col-round((m-x)/w)>=0)
       and (moves[aktuell].row-round((n-y)/w)<=squares) then begin
      aktuell:=aktuell+1;
      moves[aktuell].col:=moves[aktuell-1].col-round((m-x)/w);
      moves[aktuell].row:=moves[aktuell-1].row-round((n-y)/w);
      ausgabe(true,sender);
      pb1paint(sender);
      if (moves[aktuell].col=0) and (moves[aktuell].row=squares) then begin
        timer1.enabled:=false; showmessage('Gratulation! Du hast gewonnen!');
      end
      else computer:=true;
    end;
  end;
end;

procedure Tfrmwythoff.Timer1Timer(Sender: TObject);
var a,b,i,z,j:integer; phi:double;
    zug:array[0..100] of tpoint;
    zug0:tpoint; gefunden:boolean;
function test:boolean;
begin
  test:=false;
  if (zug[z].x=a) and (b<zug[z].y) then begin test:=true; exit end;
  if (zug[z].y=b) and (a>zug[z].x) then begin test:=true; exit end;
  if (abs(zug[z].y-b)=abs(zug[z].x-a)) and (a>zug[z].x) and (b<zug[z].y)
    then begin test:=true; exit end;
end;
begin
  if computer then begin
    phi:=(1+sqrt(5))/2;
    for i:=0 to 45 do begin
      zug[2*i].x:=trunc(i*phi);
      zug[2*i].y:=squares-trunc(i*phi*phi);
      zug[2*i+1].y:=squares-trunc(i*phi);
      zug[2*i+1].x:=trunc(i*phi*phi);
    end;
    for i:=0 to 90 do begin
      for j:=1 to 91 do begin
        if zug[i].x>zug[j].x then begin
          zug0:=zug[i]; zug[i]:=zug[j]; zug[j]:=zug0
        end;
      end;
    end;
    a:=moves[aktuell].col;
    b:=moves[aktuell].row;
    z:=91; gefunden:=false;
    repeat
      if test then begin
        inc(aktuell);
        moves[aktuell].col:=zug[z].x;
        moves[aktuell].row:=zug[z].y;
        gefunden:=true;
      end;
      dec(z);
    until (z<0) or gefunden;
    if not gefunden then begin
      inc(aktuell);
      if moves[aktuell-1].col>0 then begin
        moves[aktuell].col:=moves[aktuell-1].col-1;
        moves[aktuell].row:=moves[aktuell-1].row;
      end else begin
        moves[aktuell].col:=moves[aktuell-1].col;
        moves[aktuell].row:=moves[aktuell-1].row+1;
      end;
    end;
    ausgabe(false,sender);
    pb1paint(sender);
    if (moves[aktuell].col=0) and (moves[aktuell].row=squares) then begin
      timer1.enabled:=false;
      showmessage('Der Computer hat gewonnen!');
    end;
    computer:=false;
  end;
end;

end.
