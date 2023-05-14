unit fktint;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

var
    fehler: byte;
    q,p,r : double;
    function  funktionswert(term:string; x:double):double;

implementation

uses math;
const
     absolutea : double = -1e6;
     absoluteb : double = 1e6;

const ueberlauf:double=1e10;

function funktionswert;
const zahlen: set of char=['0'..'9','.','é'];
  funktionen= 'SQR SQRT EXP LN ABS SI SIN COS TAN ARCCOS LG ARCTAN SINH COSH TANH INT'+
              ' SGN F1 F2 F3 F4 COT LD ARCSIN ARSINH ARCOSH ARTANH SEC GAMMA GAUSS'+
              ' DIGAMMA CSC FRAC HEAVISIDE ARCCOT ARCSEC';
type  link=^stapelelement;
      stapelelement=record re:double; ch:char; by:byte; next:link end;

var zwischenwert,ergeb: double;
    zeiger,len,i : integer;
    operator,folgeoperator: char;
    prioritaet,folgeprioritaet: byte;
    stapel: link;

procedure push(wert:double; zeichen:char; priori:byte);
var p:link;
begin
  new(p);
  p^.re:=wert;
  p^.ch:=zeichen;
  p^.by:=priori;
  p^.next:=stapel;
  stapel:=p
end;
procedure pop(var wert:double; var zeichen:char; var priori:byte);
var p:link;
begin
  p:=stapel;
  stapel:=p^.next;
  wert:=p^.re;
  zeichen:=p^.ch;
  priori:=p^.by;
  dispose(p)
end;

function gesamtkette:double; forward;
function teilkette(zwischenwert:double):double; forward;

function zahl:double;
var z:double; c:integer;
begin
  i:=zeiger+1;
  while term[i] in zahlen do inc(i);
  val(copy(term,zeiger,i-zeiger),z,c);
  zahl:=z;
  zeiger:=i
end;

function funktionscode:integer;
var p:integer;
begin
  i:=zeiger;
  repeat inc(i) until (term[i]='(') or (i>len);
  p:=pos(copy(term,zeiger,i-zeiger),funktionen);
  if p=0 then {ungueltiger Funktionsaufruf} fehler:=1;
  funktionscode:=p; zeiger:=i+1;
end;

function funktion:double;
var a,b:double;
    ffehler:boolean;

function gamma(a:double):double;
var i:integer; gam:array[0..7] of double; cc,gg:double;
begin
  gam[0]:=1; gam[1]:=-0.577191652; gam[2]:=0.988205891;
  gam[3]:=-0.897056937; gam[4]:=0.918206857; gam[5]:=-0.756704078;
  gam[6]:=0.482199394; gam[7]:=-0.193527818;
  if ((a<=0) and (a=int(a))) or (a>43) then begin
    gamma:=0; fehler:=4
  end else begin
    cc:=1;
    while a>2 do begin
      a:=a-1; cc:=cc*a
    end;
    while a<1 do begin
      cc:=cc/a; a:=a+1
    end;
    a:=a-1;
    gg:=0.035868343;
    for i:=7 downto 0 do gg:=gg*a+gam[i];
    gamma:=cc*gg;
  end;
end;
function DiGamma(X : double) : double;
const
  c  = 20                     ;
  d1 = -0.57721566490153286061;
  s  = 0.00001                ;
const
  S2  =  0.08333333333333333333    ;
  S4  = -0.83333333333333333333E-2 ;
  S6  =  0.39682539682539682541E-2 ;
  S8  = -0.41666666666666666666E-2 ;
  S10 =  0.75757575757575757576E-2 ;
  S12 = -0.21092796092796092796E-1 ;
  S14 =  0.83333333333333333335E-1 ;
  S16 = -0.44325980392156862745    ;
var
  dg, p, r, y : double;
begin
  if x<0 then begin
    if frac(abs(x))<1e-5 then begin
      digamma:=0;
      ffehler:=true;
    end else digamma:=pi/tan(pi*(1-x))+digamma((1-x));
    exit;
  end;
  if x=0 then begin
    digamma:=0;
    ffehler:=true;
    exit
  end;
  if X = 1.0 then begin
    DiGamma := D1;
    Exit;
  end;
  if X <= s then dg := d1 - 1.0 / x
  else begin
    dg := 0.0;
    y := x ;
    while y < c do begin
      dg := dg - 1.0 / y;
      y := y + 1.0;
    end ;
    r := 1.0 / sqr ( y ) ;
    p := (((((((S16 * r + S14) * r + S12) * r + S10) * r + S8) * r +
               S6) * r + S4) * r + S2) * r ;
    dg := dg + ln ( y ) - 0.5 / y - p ;
  end ;
  DiGamma := dg ;
end ;

function intsin(x:double):double;
var j:integer; f,y,s,sold:double;
begin
  if (x>0) and (x<50) then begin
    s:=x;
    j:=1;
    f:=ln(x);
    repeat
      f:=f+2*ln(x)+ln(j)-ln(j+1)-2*ln(j+2);
      y:=exp(f);
      sold:=s;
      if odd((j-1) div 2) then s:=s+y
                          else s:=s-y;
      inc(j,2);
    until abs(s-sold)<0.0001;
    intsin:=s
  end else begin
    fehler:=2;
    intsin:=0;
  end;
end;

begin
  funktion:=0;
  case funktionscode of
    1: begin
         a:=gesamtkette;
         if a=0 then funktion:=0
         else
           if abs(a)<ueberlauf then funktion:=sqr(1.0*a)
           else begin
             funktion:=1e10;
             fehler:=2
           end
       end;
    5: begin
          a:=gesamtkette;
          if a>=0 then funktion:=sqrt(a)
          else begin
            funktion:=0;
            fehler:=2;
          end; {Radikand kleiner 0}
       end;
   10: begin
         a:=gesamtkette;
         if a>50 then begin a:=50; fehler:=4 end;
         if a<-50 then begin a:=-50; fehler:=4 end;
         funktion:=exp(a);
       end;
   14: begin
         a:=gesamtkette;
         if a>0 then funktion:=ln(a)
         else begin
           funktion:=0;
           fehler:=2;
         end; {LN(A<=0) nicht erlaubt}
       end;
   17: funktion:=abs(gesamtkette);
   21: funktion:=intsin(gesamtkette);
   24: funktion:=sin(gesamtkette);
   28: funktion:=cos(gesamtkette);
   32: begin
         a:=gesamtkette;
         if cos(a)<>0 then funktion:=tan(a);
       end;
   88: begin
         a:=gesamtkette;
         if sin(a)<>0 then funktion:=cos(a)/sin(a)
       end;
   36: begin
         a:=gesamtkette;
         if abs(a)<=1 then funktion:=arccos(a)
         else begin
           funktion:=0;
           fehler:=2
         end;
       end;
   43: begin
         a:=gesamtkette;
         if a>0 then funktion:=0.4342944819033*ln(a) {funktion:=log10(a)}
         else begin
           funktion:=0;
           fehler:=2;
         end;{LG(A<=0) nicht erlaubt}
       end;
   46: funktion:=arctan(gesamtkette);
   53: begin
         a:=gesamtkette;
         if abs(a)<50 then funktion:=sinh(a)//}(exp(a)-exp(-a))/2
         else begin
           funktion:=1e10;
           fehler:=2
         end
       end;
   58: begin
         a:=gesamtkette;
         if abs(a)<50 then funktion:=cosh(a)//}(exp(a)+exp(-a))/2
         else begin
           funktion:=1e10;
           fehler:=2
         end
       end;
   63: begin
         a:=gesamtkette;
         if abs(a)<50 then funktion:=tanh(a)//}1-exp(-a)/(exp(a)+exp(-a))*2
         else begin
           funktion:=1e10;
           fehler:=1
         end
       end;
   68: begin
         a:=gesamtkette;
         if a>=0 then funktion:=int(a)
                 else funktion:=int(a-1);
         fehler:=3
       end;
   72: begin
         a:=gesamtkette;
         fehler:=0;
         if a=0 then funktion:=0
                else funktion:=a/abs(a)
       end;
   92: begin
         a:=gesamtkette;
         if a>0 then funktion:={logn(2,a)}1.442695040889*ln(a)
         else begin
           funktion:=0;
           fehler:=2;
         end;{LG(A<=0) nicht erlaubt}
       end;
   95: begin
         a:=gesamtkette;
         if abs(a)<1 then funktion:=arcsin(a)//}arctan(a/sqrt(1-a*a))
         else
           if a=1 then funktion:=pi/2
           else
             if a=-1 then funktion:=-pi/2
             else begin funktion:=0; fehler:=2 end;
       end;
  102: begin
         a:=gesamtkette;
         funktion:=ln(a+sqrt(sqr(a)+1))
       end;
  109: begin
         a:=gesamtkette;
         if a>=1 then funktion:={arccosh(a)}ln(a+sqrt(sqr(a)-1))
         else begin
           funktion:=0;
           fehler:=2
         end;
       end;
  116: begin
         a:=gesamtkette;
         if abs(a)<1 then funktion:={arctanh(a)}ln((1+a)/(1-a))/2
         else begin
           funktion:=0;
           fehler:=2
         end;
       end;
  123: begin
         a:=gesamtkette;
         if cos(a)<>0 then funktion:={sec(a)}1/cos(a)
         else begin
           funktion:=0;
           fehler:=2
         end;
       end;
  127: funktion:=gamma(gesamtkette);
  133: begin
         a:=gesamtkette;
         if a>50 then begin a:=50; fehler:=4 end;
         if a<-50 then begin a:=-50; fehler:=4 end;
         funktion:=exp(-sqr(a)/2)/2.506628274631;
       end;
  139: begin
         ffehler:=false;
         funktion:=digamma(gesamtkette);
         if ffehler then fehler:=4
       end;
  147: begin
         a:=gesamtkette;
         if sin(a)<>0 then funktion:={csc(a)}1/sin(a)
         else begin
           funktion:=0;
           fehler:=2
         end;
       end;
  151: begin
         a:=gesamtkette;
         if abs(a)<1e10 then funktion:=frac(a) //frac
         else begin
           fehler:=2;
           funktion:=0
         end
       end;
  156: begin
         ffehler:=false; {heaviside}
         a:=gesamtkette;
         fehler:=3;
         if a=0 then funktion:=1/2
                else funktion:=(abs(a)/a+1)/2;
       end;
 166 : begin
         a:=gesamtkette;
         if abs(a)>1E-10 then funktion:=arctan(1.0/a)
                         else funktion:=Pi/2-arctan(x);
       end;
 173 : begin
         a:=gesamtkette;
         if abs(a)>=1 then begin
           b:=arctan(sqrt((a-1.0)*(a+1.0)));
           if a>0.0 then funktion:=b
                    else funktion:=Pi-b;
         end else begin
           funktion:=0;
           fehler:=2
         end
       end;
   else begin
           fehler:=1;
           funktion:=0
   end; {ungueltiger Funktionsaufruf}
  end
end;

function wert:double;
var a:double;
begin
  case term[zeiger] of
   'A'..'J','L'..'O','S'..'T','V','W': wert:=funktion;
   '0'..'9','.': wert:=zahl;
   'É': begin wert:=exp(1); inc(zeiger) end;
   'X': begin wert:=x; inc(zeiger) end;
   'Q': begin wert:=q; inc(zeiger) end;
   'R': begin wert:=r; inc(zeiger) end;
   'P': if length(term)=zeiger then begin
          wert:=p;
          inc(zeiger)
        end else begin
          if (term[zeiger+1]='I') then begin
            wert:=pi;
            inc(zeiger,2)
          end else begin
            if (term[zeiger+1]='H') and (term[zeiger+2]='I') then begin
              wert:=(sqrt(5)+1)/2;
              inc(zeiger,3)
            end else begin
              wert:=p;
              inc(zeiger)
            end;
          end;
        end;
  '(' : begin inc(zeiger); wert:=gesamtkette end;
  '|' : begin inc(zeiger); wert:=abs(gesamtkette) end;
  '[' : begin
          inc(zeiger);
          a:=gesamtkette;
          if a>=0 then wert:=int(a)
                  else wert:=int(a-1);
        end
    else begin fehler:=1; wert:=0 end;
  end
end;

procedure symbol(var z:char; var p:byte);
begin
  if zeiger<len then begin
    z:=term[zeiger];
    inc(zeiger);
    case z of '+','-'    : p:=1;
              '*','·','/': p:=2;
              '^'        : p:=3;
              ')',']','|': p:=0
      else begin fehler:=1; p:=0 end
    end
  end else p:=0
end;

function operand:double;
var op:double;
begin
  if term[zeiger]='-' then begin
    inc(zeiger);
    op:=-wert
  end else op:=wert;
  symbol(folgeoperator,folgeprioritaet);
  while folgeprioritaet>prioritaet do op:=teilkette(op);
  operand:=op
end;

FUNCTION x_hoch_y (x, y: double): double;
VAR ganz_y: INTEGER;
BEGIN
  IF (x <> 0.0) OR (y <> 0.0) THEN
    IF x > 0.0 THEN
      if abs(y*ln(abs(x))) > 16.0 THEN begin
        x_hoch_y:=0;
        fehler:=2
      end else x_hoch_y := Exp(y * Ln(x))
    ELSE BEGIN
      ganz_y := Trunc(y);
      IF ABS(y) > ABS(ganz_y) THEN begin
        x_hoch_y:=0;
        fehler:=2
      end ELSE
        IF x <> 0.0 THEN
          IF (ganz_y MOD 2) = 0 THEN
            if abs(y*ln(abs(x))) > 15.0 THEN begin
              x_hoch_y:=0;
              fehler:=2
            end else x_hoch_y :=  Exp(Ln(ABS(x)) * y)
          ELSE
            if abs(y*ln(abs(x))) > 15.0 THEN begin
              x_hoch_y:=0;
              fehler:=2
            end else x_hoch_y := -Exp(Ln(ABS(x)) * y)       (* ungerader Exponent *)
        ELSE
          x_hoch_y := 0
      END ELSE
        x_hoch_y := 1.0
END;

function ergebnis(a,b:double; z:char):double;
var za:integer;
    zw:double;
begin
  ergebnis:=0;
  case z of
    '+': ergebnis:=a+b;
    '-': ergebnis:=a-b;
    '*','·': if (abs(a)<ueberlauf) and (abs(b)<ueberlauf) then ergebnis:=a*b
         else begin
           ergebnis:=1e10;
           fehler:=2
         end;
    '/': if b<>0 then ergebnis:=a/b
         else begin
           ergebnis:=1e10;
           fehler:=2
         end;
    '^': begin
           if fehler>1 then begin
             ergebnis:=0;
             fehler:=2
           end else
             if b=0 then ergebnis:=1
             else
               if b=1 then ergebnis:=a
               else
                 if b=2 then ergebnis:=sqr(a)
                 else
                   if b=3 then ergebnis:=sqr(a)*a
                   else
                     if b=4 then ergebnis:=sqr(sqr(a))
                     else
                       if (b>4) and (abs(b)<maxint) and (frac(b)=0) then begin
                         zw:=a;
                         za:=2;
                         repeat
                           zw:=zw*a;
                           if zw>ueberlauf then fehler:=4;
                           inc(za);
                         until (za>trunc(b)) or (fehler=4);
                         if fehler<>4 then ergebnis:=zw
                                      else ergebnis:=ueberlauf;
                       end else
                         if a=0 then begin
                           ergebnis:=0
                         end else
                           if (abs(ln(abs(a))*b)>16) then begin
                             ergebnis:=0;
                             fehler:=2
                           end else begin
                             if a<0 then ergebnis:=x_hoch_y(a,b)
                                    else ergebnis:=exp(ln(a)*b)
                           end;
         end;
       end
end;

function teilkette;
var op1,op2: double;
begin
  push(op1,operator,prioritaet);
  repeat
    op1:=zwischenwert;
    operator:=folgeoperator;
    prioritaet:=folgeprioritaet;
    op2:=operand;
    zwischenwert:=ergebnis(op1,op2,operator)
  until folgeprioritaet<prioritaet;
  teilkette:=zwischenwert;
  pop(op1,operator,prioritaet)
end;

function gesamtkette;
begin
  zwischenwert:=operand;
  while folgeprioritaet>0 do
    zwischenwert:=teilkette(zwischenwert);
  gesamtkette:=zwischenwert
end;

begin
  if ((x>=absolutea) and (x<=absoluteb)) then begin
    if term<>'' then begin
      while pos(',',term)<>0 do term[pos(',',term)]:='.';
      while (pos(' ',term)<>0) and (length(Term)>1) do delete(term,pos(' ',term),1);
      if term[1]='-' then term:='0'+term;
      if term[1]='+' then term:='0'+term;
      while pos('(-X^',term)<>0 do term:=copy(term,1,pos('(-X^',term))
                +'0'+copy(term,pos('(-X^',term)+1,255);
      fehler:=0;
      zeiger:=1;
      len:=length(term);
      stapel:=nil;
      ergeb:=gesamtkette;
      if ergeb>ueberlauf then begin
        funktionswert:=ueberlauf;
        fehler:=4
      end else funktionswert:=ergeb;
    end else begin
      funktionswert:=0;
      fehler:=1
    end;
  end else begin
    funktionswert:=0;
    if x<absolutea then fehler:=1
                   else fehler:=3
  end;
end;

end.
