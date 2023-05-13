procedure tfgraph.koordinatensystem(can:tcanvas);
var k:string;
    sc,sx,sy,j,k1,ff:integer;
    kodiff:real;
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
var k:string;
begin
   hi:=malfx(fww*fwf);
   k:=_strkomma(fww,4,3);
   if c10 then waagerecht;
   if (_y>-6) and (_y+6<grafh) and (hi<grafb-26) then
   begin
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
   if c10 then senkrecht;
   if (_x>16) and (_x-16<grafb) and (hi>26) then
   begin
     can.moveto(_x-6,hi);
     can.lineto(_x+6,hi);
     zuzu:=can.textextent(k).cx;
     can.textout(_x-6-zuzu,hi,k);
   end;
end;
begin
   can.font.color:=clblack;
   for j:=0 to 5 do
   begin
     ff:=1;
     for k1:=0 to j do ff:=ff*10;
     ff:=ff div 10;
   end;
   fwf:=1;

   if c10m then
   begin
     can.pen.color:=$00f0f0f0;
     sc:=1;
     sy:=trunc(wby/20)+1;
     while abs(malfy(0)-malfy(sy/sc))>75 do
     begin
       sc:=2*sc;
       if sc=8 then sc:=10;
       if sc=80 then sc:=100;
     end;
     if sy<=0 then sy:=trunc(wby/20)+1;
     fww:=sy/sc;
     while malfy(-fww)>grafh do fww:=fww-sy/sc;
     while malfy(-fww)>0 do
     begin
       millisenkrecht;
       fww:=fww-sy/sc/5;
     end;
     fww:=sy/sc;
     while malfy(-fww)<0 do fww:=fww+sy/sc;
     while malfy(-fww)<grafb do
     begin
       millisenkrecht;
       fww:=fww+sy/sc/5;
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
     fww:=sx/sc;
     while malfx(fww*fwf)>grafb do fww:=fww-sx/sc/5;
     while malfx(fww*fwf)>0 do
     begin
       milliwaagerecht;
       fww:=fww-sx/sc/5;
     end;
     fww:=sx/sc;
     while malfx(fww*fwf)<0 do fww:=fww+sx/sc/5;
     while malfx(fww*fwf)<grafb do
     begin
       milliwaagerecht;
       fww:=fww+sx/sc/5;
     end;
     can.pen.color:=clblack;
   end;

     can.pen.width:=1;
     can.pen.color:=clblack;
     if _x1*_x2<=0 then
     begin
       xpfeilvoll(can,_x,grafh-10,_x,10);
       can.pen.width:=1;
       can.brush.style:=bsclear;
       can.textout(_x-10-can.textwidth('y'),10,'y');
     end;
     if _y1*_y2<=0 then
     begin
       can.pen.width:=1;
       xpfeilvoll(can,10,_y,grafb-10,_y);
       can.pen.width:=1;
       can.brush.style:=bsclear;
       can.textout(grafb-10-can.textwidth('x'),_y-25,'x');
     end;
     can.pen.width:=1;

   _xv:=0; _yv:=0;

            sc:=1;
            sx:=trunc(wbx/20)+1;
            while abs(malfx(0)-malfx(sx/sc))>80 do
            begin
              sc:=2*sc;
              if sc=8 then sc:=10;
              if sc=80 then sc:=100;
            end;
            if sx<=0 then sx:=trunc(wbx/20)+1;
            if (_y>-6) and (_y+6<grafh) and
               (malfx(0)>10) and (malfx(0)-10<grafb) then can.textout(malfx(0)-10,_y+6,'0');
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
            if not autoeinheit then kodiff:=-yauto;
            fww:=kodiff;
            while malfy(-fww)>grafh do fww:=fww+kodiff;
            while malfy(-fww)>0 do
            begin
              sen2;
              fww:=fww+kodiff;
            end;
            kodiff:=sy/sc;
            if not autoeinheit then kodiff:=yauto;
            fww:=kodiff;
            while malfy(-fww)<0 do fww:=fww+kodiff;
            while malfy(-fww)<grafh do
            begin
              sen2;
              fww:=fww+kodiff;
            end;
   can.font.color:=clblack;
end;

