unit ugraph;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, fktint, ComCtrls, math, RXSpin;

type
  TFGraph = class(TForm)
    PaintBox1: TPaintBox;
    procedure S1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure koordinatensystem(can: Tcanvas);
    procedure komplett(can: Tcanvas);
    procedure zeichnen(canvas: Tcanvas);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure Darstellung(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure graphikinitialisieren(w,h:integer;x2,x1,x2b,x1b:real);
  procedure graphikschliessen;
  function  malfx(const we:real):integer;
  function  malfy(const we:real):integer;
  function  malfxr(const we:real):real;
  function  malfyr(const we:real):real;
  procedure lwritelnreal(n:real);
  procedure lwritelnint(n:integer);
  procedure lwriteln(const s:string);
  procedure lclear;
  procedure lreset;

var
  FGraph: TFGraph;
  _x1,_x2,_y1,_y2,
  _x2alt,_x1alt,_y2alt,_y1alt,
  fx,fy,wbx,wby:real;
  _x,_y,_xv,_yv:integer;
  grafb,grafh:integer;
  ldatei : tstringlist;
const
  ldateizeiger : integer =0;
  farbig:boolean=true;
  funktionsnummer:integer=0;
  c10:boolean=true;
  c10m:boolean=false;

implementation

const richtung:real = -1;
      geschwindigkeit:real =0.01;
      autoeinheit:boolean = true;
      xauto:real=1.0;
      yauto:real=1.0;

var _kegel,rahmen:boolean;
    hi:integer;
    xdef1,xdef2:real;
    fww,fwf,phi:real;
    funkbez:array[1..30] of tpoint;
    funkbezanz,funkbeznr:integer;
    gx2alt,gx1alt,gy2alt,gy1alt:real;

{$R *.DFM}

function  leof:boolean;
begin
    leof := (ldateizeiger>=ldatei.count)
end;

function lreadlnreal:real;
var s:string;
    r:real;
    code:integer;
begin
    if not leof then
    begin
      s:=ldatei.strings[ldateizeiger];
      inc(ldateizeiger);
      val(s,r,code);
      lreadlnreal:=r;
    end
    else lreadlnreal:=0;
end;
function lreadlnint:integer;
var s:string;
    code,n:integer;
begin
    if not leof then
    begin
      s:=ldatei.strings[ldateizeiger];
      inc(ldateizeiger);
      val(s,n,code);
      lreadlnint:=n;
    end
    else lreadlnint:=0;
end;
function lreadln:string;
var s:string;
begin
    if not leof then
    begin
      s:=ldatei.strings[ldateizeiger];
      inc(ldateizeiger);
      lreadln:=s;
    end
    else lreadln:='';
end;
procedure lwritelnreal(n:real);
var s:string;
begin
     str(n,s);
     ldatei.add(s);
     inc(ldateizeiger)
end;
procedure lwritelnint(n:integer);
var s:string;
begin
    str(n,s);
    ldatei.add(s);
    inc(ldateizeiger)
end;
procedure lwriteln(const s:string);
begin
    ldatei.add(s);
    inc(ldateizeiger)
end;
procedure lclear;
begin
    ldatei.clear;
    ldateizeiger:=0;
end;
procedure lreset;
begin
    ldateizeiger:=0;
end;

function  malfx(const we:real):integer;
begin
    malfx:=trunc(we*fx+_x);
end;
function  malfy(const we:real):integer;
begin
    malfy:=trunc(-we*fy+_y);
end;
function  malfxr(const we:real):real;
begin
    malfxr:=we*fx+_x;
end;
function  malfyr(const we:real):real;
begin
    malfyr:=-we*fy+_y;
end;

procedure graphikschliessen;
begin
    _x2:=gx2alt;
    _x1:=gx1alt;
    _y2:=gy2alt;
    _y1:=gy1alt;
end;
procedure graphikinitialisieren(w,h:integer;x2,x1,x2b,x1b:real);
begin
    grafb:=w;
    grafh:=H;
    gx2alt:=_x2;
    gx1alt:=_x1;
    gy2alt:=_y2;
    gy1alt:=_y1;
    _x2:=x2;
    _x1:=x1;
    _y2:=h/w*_x2;
    _y1:=h/w*_x1;
    wbx:=1.0*(_x2-_x1);
    wby:=1.0*(_y2-_y1);
    fx:=grafb/wbx;
    fy:=grafh/wby;
    _x:=round(-_x1*grafb/(_x2-_x1));
    _y:=round(grafh+_y1*grafh/(_y2-_y1));
end;

procedure TFGraph.S1Click(Sender: TObject);
begin
   close;
end;

procedure TFGraph.PaintBox1Paint(Sender: TObject);
begin
   darstellung(sender);
end;

function  _strkomma(a:real;b,c:byte):string;
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
procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:real;
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
   if (a<>c) or (b<>d) then
     begin
       if (c-a)<>0 then
                   wi:=pi-arctan((d-b)/(c-a))
          else
          begin
            if d<b then wi:=-pi/2 else wi:=pi/2;
          end;
   sincos(wi-xwi,wsin,wcos);
   x:=round(14*wcos);
   y:=round(14*wsin);
   if c<a then
     begin
       x:=-x;
       y:=-y
     end;
   pfe[0].x:=c+x;
   pfe[0].y:=d-y;
   pfe[1].x:=c;
   pfe[1].y:=d;
   sincos(wi+xwi,wsin,wcos);
   x:=round(14*wcos);
   y:=round(14*wsin);
   if c<a then
     begin
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

{$I ksystem}

procedure tFGraph.zeichnen(canvas:tcanvas);
var s1,s2:string;
    ra,rb,rc:real;
    w1,funktionz:integer;
    wahl:byte;
    pixelfarbe:longint;

procedure farbe(z:integer);
begin
   if farbig then
   begin
     case z of
      1 : canvas.pen.color:=clblack;
      2 : Canvas.pen.color:=clblue;
      3 : Canvas.pen.color:=clred;
      4 : Canvas.pen.color:=clfuchsia;
     end;
   end
   else canvas.pen.color:=clblack;
   canvas.Font.color:=Canvas.pen.color;
   pixelfarbe:=Canvas.pen.color;
end;

function  subx(x:integer):reaL;
begin
    subx:=(x-_x)/fx;
end;
function  testwe(const we:real):boolean;
begin
    testwe:=abs(we)<maxint
end;

procedure funktion(const s2:string);
var x,y,yalt:integer;
    we:real;
procedure testzeichnen;
begin
   if testwe(we) then
   begin
     y:=round(we);//trunc(we);
     if (abs(yalt-y)>grafh/2-10) then fehler:=2;
     if (y<-200) or (y>grafh+200) or (fehler>1) then
       if (fehler>=3) then canvas.pixels[x,y]:=canvas.pen.color
                      else canvas.moveto(x,y)
     else
       canvas.lineto(x,y);
   end
   else
     if we>maxint then
     begin
       canvas.moveto(x,-1);
       y:=-1;
     end
     else
     begin
       canvas.moveto(x,1000);
       y:=1000;
     end;
   inc(x);
   yalt:=y;
end;
begin
    x:=-2;
    yalt:=-100;
    repeat
      inc(x);
      we:=malfyr(funktionswert(s2,subx(x)));
    until (((fehler<>1) and (fehler<>2)) or (x>grafb+10)) and (subx(x)>xdef1);
    if testwe(we) then
    begin
      canvas.moveto(x,round(we));
      yalt:=round(we)
    end
    else //round
      if we>maxint then
      begin
        canvas.moveto(x,-200);
        yalt:=-200;
      end
      else
      begin
        canvas.moveto(x,grafh+200);
        yalt:=grafh+200;
      end;
    inc(x);
    repeat
      we:=malfyr(funktionswert(s2,subx(x)));
      testzeichnen;
    until (x>grafb+5) or (subx(x)>xdef2);
    if (s2<>' ') then
    begin
      canvas.textout(funkbez[funktionz+1].x,funkbez[funktionz+1].y,'Y = '+s2);
      funkbezanz:=funktionz+1;
    end
end;

procedure aus(var ft:string;a,b:char);
begin
    while pos(a,ft)<>0 do ft[pos(a,ft)]:=b;
end;
procedure aus_r(var ft:string;const a,b:string);
var lz:byte;
begin
  while pos(a,ft)<>0 do
  begin
     lz:=pos(a,ft);
     delete(ft,lz,length(a));
     insert(b,ft,lz)
  end;
end;
procedure aus_(q:byte;a:char);
begin
    aus(f[q],a,'X');
end;
procedure _aus(q:byte;a:char);
begin
    aus(f[q],'X',a);
end;

procedure kurve;
var  pp,we1,we2,kla,wey,wex:real;
     x,y:longint;
procedure funkkegel;
begin
   we1:=funktionswert(f[6],kla);
   we2:=-funktionswert(f[7],kla);
   if _kegel and (phi<>0) then
   begin
     wex:=we1;
     wey:=we2;
     we1:=wex*cos(-phi)-wey*sin(-phi);
     we2:=wex*sin(-phi)+wey*cos(-phi);
   end;
   we1:=malfxr(we1);
   wey:=malfyr(-we2);
end;
procedure normal(a:byte);
begin
   if testwe(we1) and testwe(wey) then
   begin
     x:=round(we1);
     y:=round(wey);//trunc
     if (y<-200) or (y>grafh+200) or (x<0) or (x>grafb) or (fehler>1) then
       if fehler=3 then canvas.pixels[x,y]:=clblue
                   else canvas.moveto(x,y)
     else canvas.lineto(x,y);
   end;
   kla:=kla+rc;
end;
procedure _test;
begin
   if testwe(we1) and testwe(wey) then
   begin
     x:=round(we1);
     y:=round(wey)
   end
   else
   begin
     x:=-20;
     y:=-20
   end;
   canvas.moveto(x,y);
end;
{prozedur hauptteil}
begin
   aus_(6,'K');
   aus_(7,'K');
   kla:=ra-rc;
   repeat
     kla:=kla+rc;
     funkkegel;
   until ((fehler<>1) and (fehler<>2)) or (kla>rb);
   funkkegel;
   _test;
   repeat
     funkkegel;
     normal(15);
   until (kla>rb);

   if (wahl and 1)=1 then
   begin
     pp:=p;
     repeat
       kla:=ra-rc;
       repeat
         kla:=kla+rc;
         funkkegel;
       until ((fehler<>1) and (fehler<>2)) or (kla>rb);
       funkkegel;
       _test;
       repeat
         funkkegel;
         normal(15);
       until (kla>rb);
       p:=p+r;
     until p>q;
     p:=pp;
   end;

   _aus(6,'K');
   _aus(7,'K');
       canvas.textout(funkbez[funktionz+1].x,funkbez[funktionz+1].y,'X = '+f[6]);
       canvas.textout(funkbez[funktionz+2].x,funkbez[funktionz+2].y,'Y = '+f[7]);
       funkbezanz:=funktionz+2;
end;

procedure kurveninversion;
var pp,we1,we2,kla,wey,rx,ry,rra:real;
    x,y:longint;
procedure inversfunktion(xr,yr:real);
var ab,abi:extended;
begin
    ab:=sqrt(abs(sqr(xr-rx)+sqr(yr-ry)));
    if ab<>0 then
    begin
      abi:=rra*rra/ab;
      we1:=abi/ab*(xr-rx)+rx;
      we2:=-(abi/ab*(yr-ry)+ry);
    end
    else
    begin
      we1:=1000;
      we2:=1000;
      fehler:=1;
    end;
end;
procedure funkkegel;
begin
    we1:=funktionswert(f[6],kla);
    we2:=funktionswert(f[7],kla);
    inversfunktion(we1,we2);
    we1:=malfxr(we1);
    wey:=malfyr(-we2);
end;
procedure normal(a:byte);
begin
    if testwe(we1) and testwe(wey) then
    begin
      x:=round(we1);
      y:=round(wey);
      if (y<-200) or (y>grafh+200) or (x<0) or (x>grafb) or (fehler>1) then
        if fehler=3 then canvas.pixels[x,y]:=clblue
                    else canvas.moveto(x,y)
      else canvas.lineto(x,y);
    end;
    kla:=kla+rc;
end;
procedure _test;
begin
    if testwe(we1) and testwe(wey) then
    begin
      x:=round(we1);
      y:=round(wey)
    end
    else
    begin
      x:=-20;
      y:=-20
    end;
    canvas.moveto(x,y);
end;
{prozedur hauptteil}
begin
    rx:=lreadlnreal;
    ry:=lreadlnreal;
    rra:=lreadlnreal;
    aus_(6,'K');
    aus_(7,'K');
    kla:=ra-rc;
    repeat
      kla:=kla+rc;
      funkkegel;
    until ((fehler<>1) and (fehler<>2)) or (kla>rb);
    funkkegel;
    _test;
    repeat
      funkkegel;
      normal(15);
    until (kla>rb);
    if (wahl and 1)=1 then
    begin
      pp:=p;
      repeat
        kla:=ra-rc;
        repeat
          kla:=kla+rc;
          funkkegel;
        until ((fehler<>1) and (fehler<>2)) or (kla>rb);
        funkkegel;
        _test;
        repeat
          funkkegel;
          normal(15);
        until (kla>rb);
        p:=p+r;
      until p>q;
      p:=pp;
    end;
    _aus(6,'K');
    _aus(7,'K');
    canvas.brush.style:=bsclear;
    canvas.pen.color:=clgreen;
    canvas.Ellipse(malfx(rx-rra),malfy(ry-rra),malfx(rx+rra)+1,malfy(ry+rra)+1);
    canvas.brush.color:=clyellow;
    canvas.pen.color:=clblack;
    canvas.Ellipse(malfx(rx)-3,malfy(ry)-3,malfx(rx)+4,malfy(ry)+4);
end;

procedure inverspolar;
var pp,we,we1,we2,kla,rx,ry,rra:real;
    x,y:longint;
procedure inversfunktion(xr,yr:real);
var ab,abi:extended;
begin
    ab:=sqrt(abs(sqr(xr-rx)+sqr(yr-ry)));
    if ab<>0 then
    begin
      abi:=rra*rra/ab;
      we1:=abi/ab*(xr-rx)+rx;
      we2:=abi/ab*(yr-ry)+ry;
    end
    else
    begin
      we1:=1000;
      we2:=1000;
      fehler:=1;
    end;
end;
procedure funk;
begin
    we:=funktionswert(f[8],kla);
    we1:=we*cos(kla);
    we2:=we*sin(kla);
    inversfunktion(we1,we2);
end;
begin
    rx:=lreadlnreal;
    ry:=lreadlnreal;
    rra:=lreadlnreal;
    aus_r(f[8],'W','(X)');
    kla:=ra;
    funk;
    if testwe(we1) and testwe(we2) then
    begin
      x:=malfx(we1);
      y:=malfy(we2)
    end
    else
    begin
      x:=-20;
      y:=-20
    end;
    canvas.moveto(x,y);
    repeat
      funk;
      we1:=malfxr(we1);
      we2:=malfyr(we2);
      if testwe(we1) and testwe(we2) then
      begin
        x:=round(we1);
        y:=round(we2);
        if (y<-200) or (y>grafh+200) or (x<0) or (x>grafb) or (fehler>1) then
          if fehler=3 then canvas.pixels[x,y]:=clblue
                      else canvas.moveto(x,y)
        else canvas.lineto(x,y);
      end;
      kla:=kla+rc;
    until (kla>rb);

    if (wahl and 1)=1 then
    begin
      pp:=p;
      repeat
        kla:=ra;
        funk;
        if testwe(we1) and testwe(we2) then
        begin
          x:=malfx(we1);
          y:=malfy(we2)
        end
        else
        begin
          x:=-20;
          y:=-20
        end;
        canvas.moveto(x,y);
        repeat
          funk;
          we1:=malfxr(we1);
          we2:=malfyr(we2);
          if testwe(we1) and testwe(we2) then
          begin
            x:=round(we1);
            y:=round(we2);
            if (y<-200) or (y>grafh+200) or (x<0) or (x>grafb) or (fehler>1) then
              if fehler=3 then canvas.pixels[x,y]:=clblue
                          else canvas.moveto(x,y)
            else canvas.lineto(x,y);
          end;
          kla:=kla+rc;
        until (kla>rb);
        p:=p+r;
      until p>q;
      p:=pp;
    end;
    aus_r(f[8],'(X)','W');
    canvas.brush.style:=bsclear;
    canvas.pen.color:=clgreen;
    canvas.Ellipse(malfx(rx-rra),malfy(ry-rra),malfx(rx+rra)+1,malfy(ry+rra)+1);
    canvas.brush.color:=clyellow;
    canvas.pen.color:=clblack;
    canvas.Ellipse(malfx(rx)-3,malfy(ry)-3,malfx(rx)+4,malfy(ry)+4);
end;

procedure polar(f8:string);
var pp,we,we1,we2,kla:real;
    x,y:longint;
procedure funk;
begin
   we:=funktionswert(f8,kla);
   we1:=we*cos(kla);
   we2:=we*sin(kla);
end;
begin
     aus_r(f8,'W','(X)');
     kla:=ra;
     funk;
     if testwe(we1) and testwe(we2) then
     begin
       x:=malfx(we1);
       y:=malfy(we2)
     end
     else
     begin
       x:=-20;
       y:=-20
     end;
     canvas.moveto(x,y);
     repeat
       funk;
       we1:=malfxr(we1);
       we2:=malfyr(we2);
       if testwe(we1) and testwe(we2) then
       begin
         x:=round(we1);
         y:=round(we2);
         if (y<-200) or (y>grafh+200) or (x<0) or (x>grafb) or (fehler>1) then
           if fehler=3 then canvas.pixels[x,y]:=clblue
                       else canvas.moveto(x,y)
         else canvas.lineto(x,y);
       end;
       kla:=kla+rc;
     until (kla>rb);

     if (wahl and 1)=1 then
     begin
       pp:=p;
       repeat
         kla:=ra;
         funk;
         if testwe(we1) and testwe(we2) then
         begin
           x:=malfx(we1);
           y:=malfy(we2)
         end
         else
         begin
           x:=-20;
           y:=-20
         end;
         canvas.moveto(x,y);
         repeat
           funk;
           we1:=malfxr(we1);
           we2:=malfyr(we2);
           if testwe(we1) and testwe(we2) then
           begin
             x:=round(we1);
             y:=round(we2);
             if (y<-200) or (y>grafh+200) or (x<0) or (x>grafb) or (fehler>1) then
               if fehler=3 then canvas.pixels[x,y]:=clblue
                           else canvas.moveto(x,y)
             else canvas.lineto(x,y);
           end;
           kla:=kla+rc;
         until (kla>rb);
         p:=p+r;
       until p>q;
       p:=pp;
     end;

     aus_r(f8,'(X)','W');
       canvas.textout(funkbez[funktionz+1].x,funkbez[funktionz+1].y,'F(P,W) = '+f8);
       funkbezanz:=funktionz+1;
end;

begin
   funktionsnummer:=1;
   funkbezanz:=0;
   xdef1:=-10000;
   xdef2:=10000;
   funktionz:=0;
   if ldatei.count=0 then exit;
   lreset;
   repeat
     s1:=lreadln;
     s2:=lreadln;
     case s1[2] of
       'F' : begin
               inc(funktionz);
               farbe(funktionz);
               funktion(s2);
             end;
       'i' : begin
               inc(funktionz);
               farbe(funktionz);
               ra:=lreadlnreal;
               rb:=lreadlnreal;
               rc:=lreadlnreal;
               wahl:=lreadlnint;
               w1:=lreadlnint;
               kurve;
               inc(funktionz);
               farbe(funktionz);
               ra:=lreadlnreal;
               rb:=lreadlnreal;
               kurveninversion;
             end;
       'p' : begin
               inc(funktionz);
               farbe(funktionz);
               ra:=lreadlnreal;
               rb:=lreadlnreal;
               rc:=lreadlnreal;
               wahl:=lreadlnint;
               w1:=lreadlnint;
               polar(f[8]);
               inc(funktionz);
               farbe(funktionz);
               ra:=lreadlnreal;
               rb:=lreadlnreal;
               inverspolar;
             end;
           end;
         until leof;
end;

procedure TFGraph.darstellung(Sender: TObject);
var Bitmap: TBitmap;
    myrect,birect:trect;
begin
   farbig:=true;
   grafb:=paintbox1.width+1;
   grafh:=paintbox1.Height+1;
   wbx:=1.0*(_x2-_x1);
   wby:=1.0*(_y2-_y1);
   fx:=grafb/wbx;
   fy:=grafh/wby;
   _x:=round(-_x1*grafb/(_x2-_x1));
   _y:=round(grafh+_y1*grafh/(_y2-_y1));
   Bitmap := TBitmap.Create;
   Bitmap.Width := paintbox1.Width;
   Bitmap.Height := paintbox1.Height;
   bitmap.canvas.font.name:='Verdana';
   bitmap.canvas.font.size:=10;
   birect.left:=0;
   birect.right:=paintbox1.width;
   birect.top:=0;
   birect.bottom:=paintbox1.height;
   myrect:=birect;
   setbkmode(bitmap.canvas.handle,transparent);
  try
    komplett(bitmap.canvas);
    paintbox1.canvas.CopyRect(biRect,bitmap.Canvas, MyRect);
  finally
    Bitmap.Free;
  end;

end;

procedure TFGraph.FormCreate(Sender: TObject);
var i:integer;
begin
   fgraph.width:=480;
   fgraph.height:=360;
   for i:=1 to 30 do
   begin
     funkbez[i].x:=10;
     funkbez[i].y:=(i-1)*20-30;
   end;
   funkbezanz:=0;
end;

procedure TFGraph.FormActivate(Sender: TObject);
var i:integer;
begin
   for i:=1 to 30 do
   begin
     funkbez[i].x:=10;
     funkbez[i].y:=(i-1)*20-30;
   end;
   funkbezanz:=0;
end;

procedure TFGraph.FormDeactivate(Sender: TObject);
var i:integer;
begin
   for i:=1 to 30 do
   begin
     funkbez[i].x:=10;
     funkbez[i].y:=(i-1)*20-30;
   end;
   funkbezanz:=0;
end;

procedure tfgraph.komplett(can: Tcanvas);
begin
  koordinatensystem(can);
  zeichnen(can);
end;

end.

