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

