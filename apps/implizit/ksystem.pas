var hi:integer;
    fww,fwf:double;

procedure koordinatensystem(can:tcanvas);
var k:string;
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
procedure milliwaagerecht;
begin
    hi:=malfx(fww*fwf);
    can.moveto(hi,0);
    can.lineto(hi,grafh);
end;
procedure millisenkrecht;
begin
    hi:=malfy(-fww);
    can.moveto(0,hi);
    can.lineto(grafb,hi);
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
begin
    hi:=malfx(fww*fwf);
    waagerecht;
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
begin
    hi:=malfy(-fww);
    k:=floattostr(-fww);
    senkrecht;
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

begin
    can.font.color:=clblack;
    fwf:=1;
    can.pen.width:=1;
    can.pen.color:=clblack;
    if _x1*_x2<=0 then
    begin
      xpfeilvoll(can,_x,grafh-10,_x,10);
      can.pen.width:=1;
      can.brush.style:=bsclear;
      can.textout(_x-10-can.textwidth('Y'),10,'Y');
    end;
    if _y1*_y2<=0 then
    begin
      xpfeilvoll(can,10,_y,grafb-10,_y);
      can.pen.width:=1;
      can.brush.style:=bsclear;
      can.textout(grafb-10-can.textwidth('X'),_y-5-can.textheight('X'),'X');
    end;

    sc:=1;
    sx:=trunc(wbx/20)+1;
    while abs(malfx(0)-malfx(sx/sc))>80 do
    begin
      sc:=2*sc;
      if sc=8 then sc:=10;
      if sc=80 then sc:=100;
    end;
    if sx<=0 then sx:=trunc(wbx/20)+1;
    can.textout(malfx(0)-3-can.textwidth('0'),_y+6,'0');
    if sc=0 then sc:=1;

    kodiff:=-sx/sc;
    fww:=kodiff;
    while malfx(fww*fwf)>grafb do fww:=fww+kodiff;
    while malfx(fww*fwf)>0 do
    begin
      waa2;
      fww:=fww+kodiff;
    end;
    kodiff:=sx/sc;
    fww:=kodiff;
    while malfx(fww*fwf)<0 do fww:=fww+kodiff;
    while malfx(fww*fwf)<grafb do
    begin
      waa2;
      fww:=fww+kodiff;
    end;

    sc:=1;
    sy:=trunc(wby/20)+1;
    while abs(malfy(0)-malfy(sy/sc))>75 do
    begin
      sc:=2*sc;
      if sc=8 then sc:=10;
      if sc=80 then sc:=100;
    end;
    if sy<=0 then sy:=trunc(wby/20)+1;

    kodiff:=-sy/sc;
    fww:=kodiff;
    while malfy(-fww)>grafh do fww:=fww+kodiff;
    while malfy(-fww)>0 do
    begin
      sen2;
      fww:=fww+kodiff;
    end;
    kodiff:=sy/sc;
    fww:=kodiff;
    while malfy(-fww)<0 do fww:=fww+kodiff;
    while malfy(-fww)<grafh do
    begin
      sen2;
      fww:=fww+kodiff;
    end;
    can.font.color:=clblack;
end;

