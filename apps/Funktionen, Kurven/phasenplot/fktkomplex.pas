unit fktkomplex;
// Komplexer Funktionsinterpreter 2011
// Copyright: 2011, Steffen Polster

interface

uses complexmathlibrary, sysutils;

type
    tkomplexzahl = record re,im:real end;

var
    fehlerkomplex : byte;
    p_k  : tkomplexzahl;
    parameter_reell : double;
    function  funktionswertkomplex(term:string; z:tkomplexzahl):tkomplexzahl;
    procedure termkorrektur(var term:string);

implementation

uses math;

const ueberlauf:extended=1e32;
var   ax: ARRAY[1..4] OF TComplex;

procedure termkorrektur(var term:string);
begin
    while pos(',',term)<>0 do term[pos(',',term)]:='.';
    term:=trim(term);
    while (pos(' ',term)<>0) and (length(Term)>1) do delete(term,pos(' ',term),1);
    if term[1]='-' then term:='0'+term;
    if term[1]='+' then delete(term,1,1);
end;

function funktionswertkomplex;
const zahlen: set of char=['0'..'9','.','é','i'];
  funktionen= 'SQR SQRT EXP LN ABS SIN COS TAN COSH SINH TANH GAMMA BI0 BJ0 '+
              'SEC CSC COT DN SN CN';
type  link=^stapelelement;
      stapelelement=record re:tkomplexzahl; ch:char; by:byte; next:link end;

var zwischenwert,ergeb: tkomplexzahl;
    zeiger,len,i : integer;
    operator,folgeoperator: char;
    prioritaet,folgeprioritaet: byte;
    stapel: link;

procedure push(wert:tkomplexzahl; zeichen:char; priori:byte);
var p:link;
begin
    new(p);
    p^.re.re:=wert.re;
    p^.re.im:=wert.im;
    p^.ch:=zeichen;
    p^.by:=priori;
    p^.next:=stapel;
    stapel:=p
end;
procedure pop(var wert:tkomplexzahl; var zeichen:char; var priori:byte);
var p:link;
begin
    p:=stapel;
    stapel:=p^.next;
    wert.re:=p^.re.re;
    wert.im:=p^.re.im;
    zeichen:=p^.ch;
    priori:=p^.by;
    dispose(p)
end;

function gesamtkette:tkomplexzahl; forward;
function teilkette(zwischenwert:tkomplexzahl):tkomplexzahl; forward;

function zahl:tkomplexzahl;
var z:tkomplexzahl;
    c:integer;
begin
    i:=zeiger+1;
    while term[i] in zahlen do inc(i);
    val(copy(term,zeiger,i-zeiger),z.re,c);
    z.im:=0;
    zahl:=z;
    zeiger:=i
end;

function funktionscode:integer;
var p:integer;
begin
    i:=zeiger;
    repeat
      inc(i)
    until (term[i]='(') or (i>len);
    p:=pos(copy(term,zeiger,i-zeiger),funktionen);
    if p=0 then {ungueltiger Funktionsaufruf} fehlerkomplex:=1;
    funktionscode:=p;
    zeiger:=i+1;
end;

function funktion:tkomplexzahl;
var a:tkomplexzahl;
    dnuk,cnvkk,dnvkk,snvkk,snuk,cnuk,yr,xr,kr:real;
PROCEDURE sncndn(uu,emmc: real; VAR sn,cn,dn: real);
LABEL 1;
CONST
   ca=0.0003;
VAR
   a,b,c,d,emc,u: real;
   i,ii,l: integer;
   bo: boolean;
   em,en: ARRAY [1..13] OF real;
FUNCTION cosh(u: real): real;
BEGIN
    cosh := 0.5*(exp(u)+exp(-u))
END;
FUNCTION tanh(u: real): real;
   VAR
      u2,epu,emu: real;
BEGIN
    epu := exp(u);
    emu := 1.0/epu;
    IF (abs(u)<0.3) THEN
    BEGIN
      u2 := u*u;
      tanh := 2*u*(1+u2/6*(1+u2/20*(1+u2/42*(1+u2/72))))/(epu+emu)
    END
    ELSE
    BEGIN
      tanh := (epu-emu)/(epu+emu)
    END
END;
BEGIN
    emc := emmc;
    u := uu;
    IF (emc <> 0.0) THEN
    BEGIN
      bo := (emc < 0.0);
      IF (bo) THEN
      BEGIN
        d := 1.0-emc;
        emc := -emc/d;
        d := sqrt(d);
        u := d*u
      END;
      a := 1.0;
      dn := 1.0;
      FOR i := 1 TO 13 DO
      BEGIN
        l := i;
        em[i] := a;
        emc := sqrt(emc);
        en[i] := emc;
        c := 0.5*(a+emc);
        IF (abs(a-emc) <= ca*a) THEN GOTO 1;
        emc := a*emc;
        a := c
      END;
1:    u := c*u;
      sn := sin(u);
      cn := cos(u);
      IF (sn <> 0.0) THEN
      BEGIN
        a := cn/sn;
        c := a*c;
        FOR ii := l DOWNTO 1 DO
        BEGIN
          b := em[ii];
          a := c*a;
          c := dn*c;
          dn := (en[ii]+a)/(b+a);
          a := c/b
        END;
        a := 1.0/sqrt(sqr(c)+1.0);
        IF (sn < 0.0) THEN sn := -a
                      ELSE sn := a;
        cn := c*sn
      END;
      IF (bo) THEN
      BEGIN
        a := dn;
        dn := cn;
        cn := a;
        sn := sn/d
      END;
    END
    ELSE
    BEGIN
      cn := 1.0/cosh(u);
      dn := cn;
      sn := tanh(u)
    END
END;
begin
    funktion.re:=0;
    funktion.im:=0;
    case funktionscode of
      1: begin
           a:=gesamtkette;
           if (a.re=0) and (a.im=0) then
           begin
             funktion.re:=0;
             funktion.im:=0
           end
           else
             if abs(a.re)<ueberlauf then
             begin
               funktion.re:=sqr(1.0*a.re)+sqr(1.0*a.im);
               funktion.im:=2.0*a.re*a.im;
             end
             else
             begin
               funktion.re:=1e10;
               fehlerkomplex:=2
             end
         end;
      5: begin
           a:=gesamtkette;
           ax[1]:=CSet(a.re,a.im);
           ax[2]:=CRoot(ax[1],0,2);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     10: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           try
             ax[2]:= CExp(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           except
             funktion.re:=1e5;
             fehlerkomplex:=4
           end;
         end;
     14: begin
           a:=gesamtkette;
           if (a.re<>0) or (a.im<>0) then
           begin
             funktion.re:=1/2*ln(a.re*a.re+a.im*a.im);
             if a.re<>0 then funktion.im:=arctan(a.im/a.re)
             else
             begin
               if a.im<0 then funktion.im:=-pi/2
                         else funktion.im:=pi/2
             end;
           end
           else
           begin
             funktion.re:=0;
             fehlerkomplex:=2
           end;
         end;
     17: begin
           funktion.re:=sqrt(sqr(gesamtkette.re)+sqr(gesamtkette.im));
           funktion.im:=0;
         end;
     21: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           if (abs(a.re)<100) and (abs(a.im)<100) then
           begin
             ax[2]:= CSin(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end
           else
           begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     25: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           if (abs(a.re)<100) and (abs(a.im)<100) then
           begin
             ax[2]:= CCos(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end
           else
           begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     29: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= CTan(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     33: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           if (abs(a.re)<100) and (abs(a.im)<100) then
           begin
             ax[2]:= Ccosh(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end
           else
           begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     38: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           if (abs(a.re)<100) and (abs(a.im)<100) then
           begin
             ax[2]:= Csinh(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end
           else
           begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     43: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= Ctanh(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     48: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= Cgamma(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     54: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= CI0(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     58: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= CJ0(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     62: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= CSEC(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
     66: begin
           a:=gesamtkette;
           if (a.re<>0) or (a.im<>0) then
           begin
             ax[1]:= CSet(a.re,a.im);
             ax[2]:= CCSC(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end
           else
           begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     74: begin
           a:=gesamtkette;
           //xr:=0.2;
           xr:=parameter_reell;
           kr:=1-xr*xr;
           sncndn(a.re,kr,snuk,cnuk,dnuk);
           sncndn(a.im,sqrt(1-kr*kr),snvkk,cnvkk,dnvkk);
           yr:=1-dnuk*dnuk*snvkk*snvkk;
           funktion.re:=dnuk*cnvkk*dnvkk/yr;
           funktion.im:=-kr*kr*snuk*cnuk*snvkk/yr;
         end;
     77: begin
           a:=gesamtkette;
           //xr:=0.2;
           xr:=parameter_reell;
           kr:=1-xr*xr;
           sncndn(a.re,kr,snuk,cnuk,dnuk);
           sncndn(a.im,sqrt(1-kr*kr),snvkk,cnvkk,dnvkk);
           yr:=1-dnuk*dnuk*snvkk*snvkk;
           funktion.re:=snuk*dnvkk/yr;
           funktion.im:=cnuk*dnuk*snvkk*cnvkk/yr;
         end;
     80: begin
           a:=gesamtkette;
           //xr:=0.2;
           xr:=parameter_reell;
           kr:=1-xr*xr;
           sncndn(a.re,kr,snuk,cnuk,dnuk);
           sncndn(a.im,sqrt(1-kr*kr),snvkk,cnvkk,dnvkk);
           yr:=1-dnuk*dnuk*snvkk*snvkk;
           funktion.re:=cnuk*cnvkk/yr;
           funktion.im:=snuk*dnuk*snvkk*dnvkk/yr;
         end;
     70: begin
           a:=gesamtkette;
           if (a.re<>0) or (a.im<>0) then
           begin
             ax[1]:= CSet(a.re,a.im);
             ax[2]:= CCOT(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end
           else
           begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
    else begin
           fehlerkomplex:=1;
           funktion.re:=0;
           funktion.im:=0
         end; {ungueltiger Funktionsaufruf}
    end
end;

function wert:tkomplexzahl;
begin
    case term[zeiger] of
      'A'..'H','L'..'O','Q'..'T','V','W': wert:=funktion;
      '0'..'9','.': wert:=zahl;
      'É': begin
             wert.re:=exp(1);
             wert.im:=0;
             inc(zeiger)
           end;
      'I': begin
             wert.re:=0;
             wert.im:=1;
             inc(zeiger)
           end;
      'Z': begin
             wert.re:=z.re;
             wert.im:=z.im;
             inc(zeiger)
           end;
      'P': if length(term)=zeiger then
           begin
             wert:=p_k;
             inc(zeiger)
           end
           else
           begin
             if (term[zeiger+1]='I') then
             begin
               wert.re:=pi;
               wert.im:=0;
               inc(zeiger,2)
             end
           end;
     '(' : begin
             inc(zeiger);
             wert:=gesamtkette
           end;
     '|' : begin
             inc(zeiger);
             wert.re:=sqrt(sqr(gesamtkette.re)+sqr(gesamtkette.im))
           end;
      else begin
             fehlerkomplex:=1;
             wert.re:=0;
             wert.im:=0;
           end;
      end
end;

procedure symbol(var z:char; var p:byte);
begin
    if zeiger<len then
    begin
      z:=term[zeiger];
      inc(zeiger);
      case z of
        '+','-'     : p:=1;
        '*','·','/' : p:=2;
        '^'         : p:=3;
        ')',']','|' : p:=0
        else
        begin
          fehlerkomplex:=1;
          p:=0
        end
      end
    end
    else p:=0
end;

function operand:tkomplexzahl;
var op:tkomplexzahl;
begin
    if term[zeiger]='-' then
    begin
      inc(zeiger);
      op.re:=-wert.re;
      op.im:=wert.im
    end
    else op:=wert;
    symbol(folgeoperator,folgeprioritaet);
    while folgeprioritaet>prioritaet do op:=teilkette(op);
    operand:=op
end;

function ergebnis(a,b:tkomplexzahl; z:char):tkomplexzahl;
begin
    ergebnis.re:=0;
    ergebnis.im:=0;
    ax[1] := CSet(a.re,a.im);
    ax[2] := CSet(b.re,b.im);
    case z of
      '+': begin
             ax[3]:=CAdd(ax[1],ax[2]);
             ergebnis.re:=ax[3].x;
             ergebnis.im:=ax[3].y;
           end;
      '-': begin
             ax[3]:=CSub(ax[1],ax[2]);
             ergebnis.re:=ax[3].x;
             ergebnis.im:=ax[3].y;
           end;
  '*','·': begin
             if (abs(a.re)<ueberlauf) and (abs(b.re)<ueberlauf) then
             begin
               ax[3]:=CMult(ax[1],ax[2]);
               ergebnis.re:=ax[3].x;
               ergebnis.im:=ax[3].y;
             end
             else
             begin
               ergebnis.re:=1e10;
               fehlerkomplex:=2
             end;
           end;
      '/': if (cabs(ax[2])<>0) then
           begin
             ax[3]:= CDiv(ax[1],ax[2]);
             ergebnis.re:=ax[3].x;
             ergebnis.im:=ax[3].y;
           end
           else
           begin
             ergebnis.re:=1e10;
             fehlerkomplex:=2
           end;
      '^': begin
             if fehlerkomplex>1 then
             begin
               ergebnis.re:=0;
               fehlerkomplex:=2
             end
             else
             begin
               if (b.re=0) and (b.im=0) then
               begin
                 ergebnis.re:=1;
                 ergebnis.im:=0
               end
               else
               begin
                 ax[3]:=CPower(ax[1],ax[2]);
                 ergebnis.re:=ax[3].x;
                 ergebnis.im:=ax[3].y;
               end;
             end;
          end;
     end
end;

function teilkette;
var op1,op2: tkomplexzahl;
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
    if term<>'' then
    begin
      while pos(',',term)<>0 do term[pos(',',term)]:='.';
      while pos('(-',term)<>0 do term:=copy(term,1,pos('(-',term))
                                  +'0'+copy(term,pos('(-',term)+1,255);
      fehlerkomplex:=0;
      zeiger:=1;
      len:=length(term);
      stapel:=nil;
      ergeb:=gesamtkette;
      if ergeb.re*ergeb.re+ergeb.im*ergeb.im>ueberlauf then
      begin
        funktionswertkomplex.re:=ueberlauf;
        fehlerkomplex:=4
      end
      else funktionswertkomplex:=ergeb;
    end
    else
    begin
      funktionswertkomplex.re:=0;
      funktionswertkomplex.im:=0;
      fehlerkomplex:=1
    end;
end;

end.
