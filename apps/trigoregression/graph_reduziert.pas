unit graph_reduziert;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, _grund, Menus;

  procedure koordinatensystem(can: Tcanvas);
  procedure zeichnen(canvas: Tcanvas);
  procedure graphikinitialisieren(w,h:integer;x2,x1,x2b,x1b:double);
  procedure graphikschliessen;

var
//  FGraph: TFGraph;
  Bitmap: TBitmap;
  _x1,_x2,_y1,_y2,_x2alt,_x1alt,_y2alt,_y1alt,wbx,wby,fx,fy,_xv,_yv:double;
  grafb,grafh,logg,_x,_y:integer;
const
  farbig:boolean=true;
  funktionsnummer:integer=0;
  grafikschrift: integer = 10;
  grafikspeed : double = 0.01;

implementation

uses
    fktint, math;

const autoeinheit:boolean = true;
      xauto:double=1.0;
      yauto:double=1.0;

var hi:integer;
    xdef1,xdef2:double;
    fww,fwf:double;
    gx2alt,gx1alt,gy2alt,gy1alt:double;

procedure graphikschliessen;
begin
  _x2:=gx2alt;
  _x1:=gx1alt;
  _y2:=gy2alt;
  _y1:=gy1alt;
end;
procedure graphikinitialisieren(w,h:integer;x2,x1,x2b,x1b:double);
begin
  logg:=0;
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

procedure koordinatensystem(can:tcanvas);
var k:string;
    xs:string;
    sc,sx,sy:integer;
    kodiff:real;
  function  malfx(const we:real):integer;
  begin
    malfx:=round(we*fx+_x);
  end;
  function  malfy(const we:real):integer;
  begin
    malfy:=round(-we*fy+_y);
  end;
  procedure waagerecht;
  begin
    can.pen.color:=$00d0d0d0;//clltgray;
    can.pen.style:=psdot;
    can.moveto(hi,0);
    can.lineto(hi,grafh);
    can.pen.color:=clblack;
    can.pen.style:=pssolid;
  end;
  procedure waa2;
  var k:string;
  begin
    hi:=malfx(fww*fwf);
    k:=_strkomma(fww,4,3);
    waagerecht;
    if (_y>-6) and (_y+6<grafh) and (hi<grafb-26) then begin
      can.moveto(hi,_y+6);
      can.lineto(hi,_y-6);
      can.textout(hi-10,_y+6,k);
    end;
  end;
  procedure senkrecht;
  begin
    can.pen.color:=$00d0d0d0;//clltgray;
    can.pen.style:=psdot;
    can.moveto(0,hi);
    can.lineto(grafb,hi);
    can.pen.color:=clblack;
    can.pen.style:=pssolid;
  end;
  procedure sen2;
  var zuzu:integer;
  begin
    hi:=malfy(-fww);
    k:=_strkomma(-fww,4,3);
    senkrecht;
    if (_x>16) and (_x-16<grafb) and (hi>26) then begin
      can.moveto(_x-6,hi);
      can.lineto(_x+6,hi);
      zuzu:=can.textextent(k).cx;
      can.textout(_x-6-zuzu,hi,k);
    end;
  end;

begin
  can.font.color:=clblack;
  fwf:=1;

    can.pen.width:=1;
    can.pen.color:=clblack;
    if _x1*_x2<=0 then begin
      xpfeilvoll(can,_x,grafh-10,_x,10);
      can.pen.width:=1;
      can.brush.style:=bsclear;
      xs:='y';
      can.textout(_x-10-can.textwidth(xs),10,xs);
    end;
    if _y1*_y2<=0 then begin
      can.pen.width:=1;
      xpfeilvoll(can,10,_y,grafb-10,_y);
      can.pen.width:=1;
      can.brush.style:=bsclear;
      xs:='x';
      if logg in [1,3] then xs:='ln '+xs;
      can.textout(grafb-10-can.textwidth(xs),_y-5-can.textheight(xs),xs);
    end;
    can.pen.width:=1;
  _xv:=0;
  _yv:=0;

           sc:=1;
           sx:=trunc(wbx/20)+1;
           while abs(malfx(0)-malfx(sx/sc))>80 do begin
             sc:=2*sc;
             if sc=8 then sc:=10;
             if sc=80 then sc:=100;
           end;
           if sx<=0 then sx:=trunc(wbx/20)+1;
           if (_y>-6) and (_y+6<grafh) and
             (malfx(0)>10) and (malfx(0)-10<grafb)
             then can.textout(malfx(0)-3-can.textwidth('0'),_y+6,'0');
           if sc=0 then sc:=1;

           kodiff:=-sx/sc;
           if not autoeinheit then kodiff:=-xauto;
           fww:=kodiff;
           while malfx(fww*fwf)>grafb do fww:=fww+kodiff;
           while malfx(fww*fwf)>0 do begin
             waa2;
             fww:=fww+kodiff;
           end;
           kodiff:=sx/sc;
           if not autoeinheit then kodiff:=xauto;
           fww:=kodiff;
           while malfx(fww*fwf)<0 do fww:=fww+kodiff;
           while malfx(fww*fwf)<grafb do begin
             waa2;
             fww:=fww+kodiff;
           end;

           sc:=1;
           sy:=trunc(wby/20)+1;
           while abs(malfy(0)-malfy(sy/sc))>75 do begin
             sc:=2*sc;
             if sc=8 then sc:=10;
             if sc=80 then sc:=100;
           end;
           if sy<=0 then sy:=trunc(wby/20)+1;
           kodiff:=-sy/sc;
           if not autoeinheit then kodiff:=-yauto;
           fww:=kodiff;
           while malfy(-fww)>grafh do fww:=fww+kodiff;
           while malfy(-fww)>0 do begin
             sen2;
             fww:=fww+kodiff;
           end;
           kodiff:=sy/sc;
           if not autoeinheit then kodiff:=yauto;
           fww:=kodiff;
           while malfy(-fww)<0 do fww:=fww+kodiff;
           while malfy(-fww)<grafh do begin
             sen2;
             fww:=fww+kodiff;
           end;
   can.font.color:=clblack;
end;

function subx(const x:integer):double;
begin
  subx:=(x-_x)/fx;
end;
function  malfxr(const we:double):double;
begin
  malfxr:=we*fx+_x;
end;
function  malfyr(const we:double):double;
begin
  malfyr:=-we*fy+_y;
end;
function  testwe(const we:double):boolean;
begin
  testwe:=abs(we)<maxint
end;

procedure zeichnen(canvas:tcanvas);
var s1,s2,s3:string;
    ww:double;
    w1,w2:integer;

  procedure funktion(const s2:string);
  var x,y,yalt:integer;
      we:double;
    procedure testzeichnen;
    begin
      if testwe(we) then begin
        y:=round(we);//trunc(we);
        if (abs(yalt-y)>grafh/2-10) then fehler:=2;
        if (y<-200) or (y>grafh+200) or (fehler>1) then
          if (fehler>=3) then canvas.pixels[x,y]:=canvas.pen.color
                         else canvas.moveto(x,y)
        else
          canvas.lineto(x,y);
      end
      else
        if we>maxint then begin
          canvas.moveto(x,-1);
          y:=-1;
        end else begin
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
    if testwe(we) then begin
      canvas.moveto(x,round(we));
      yalt:=round(we)
    end
    else //round
      if we>maxint then begin
        canvas.moveto(x,-200);
        yalt:=-200;
      end else begin
        canvas.moveto(x,grafh+200);
        yalt:=grafh+200;
      end;
    inc(x);
    repeat
      we:=malfyr(funktionswert(s2,subx(x)));
      testzeichnen;
    until (x>grafb+5) or (subx(x)>xdef2);
  end;

var code:integer;
begin
  funktionsnummer:=1;
  xdef1:=-10000;
  xdef2:=10000;
  if ldatei.count=0 then exit;
  lreset;
  repeat
    s1:=lreadln;
    s2:=lreadln;
    case s1[2] of
     'F' : begin
             canvas.Pen.Color:=$00ff0000;
             funktion(s2);
           end;
     'm' : begin
             canvas.pen.color:=clblack;
             canvas.brush.color:=claqua;
             repeat
               s3:=lreadln;
               if s3<>'...' then begin
                 val(s3,ww,code);
                 w1:=round(malfxr(ww));
                 s3:=lreadln;
                 val(s3,ww,code);
                 w2:=round(malfyr(ww));
                 canvas.ellipse(w1-3,w2-3,w1+4,w2+4);
               end;
             until s3='...';
             canvas.brush.style:=bsclear;
           end;
    end;
  until leof;
end;

initialization
  Bitmap := TBitmap.Create;
  Bitmap.PixelFormat:=pf32bit;

finalization
  Bitmap.Free;

end.


