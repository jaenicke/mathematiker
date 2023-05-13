unit uableitung;

(*-------------------------------------------------------------------------
 Analytische Bestimmung einer Ableitung
 (C) Copyright 1995-2012 Steffen Polster

 This software is provided 'as-is', without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it
 freely, subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software in
    a product, an acknowledgment in the product documentation would be
    appreciated but is not required.

 2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

 3. This notice may not be removed or altered from any source distribution.
----------------------------------------------------------------------------*)

{ Bedeutung der Knoten :
   0: Konstante
   1: x-Wert
   2: P
   8: Q
   9: R
  10: PI
   3..7: frei
  11: Addition          a+b
  12: Subtraktion       a-b
  13: Multiplikaton     a*b
  14: Division          a/b
  15: Potenz            a^b
  16: Wurze            SQR(a,b)  bûa
  17: Logarithmus       LLG(a,b)  Log. v. a zur Basis b
  21: Quadratwurzel     SQRT(a)
  22: nat. Logarithmus  LN(a)
  23: dec. Logarithmus  LG(a)
  24: e hoch a          EXP(a)
  25: Betrag            ABS(a)
  26: Signum            SGN(a)
  27: Ganzz. Anteil     INT(a)
  28: bin.Logarithmus   LD(x)
  31:                   SIN(a)
  32:                   COS(a)
  33:                   TAN(a)
  34:                   COT(a)
  41:                   SINH(a)
  42:                   COSH(a)
  43:                   TANH(a)
  44:                   COTH(a)
  51:                   ARCSIN(a)
  52:                   ARCCOS(a)
  53:                   ARCTAN(a)
  54:                   ARCCOT(a)
  61:                   ARSINH(a)
  62:                   ARCOSH(a)
  63:                   ARTANH(a)
  64:                   ARCOTH(a)
}

interface

type zeiger=^knoten;
     knoten=record
             opp:byte;
             konstante:double;
             links,rechts:zeiger;
             mitte:zeiger;
            end;
type hzeiger=^hknoten;
     hknoten=record
              h1:zeiger;
              h2:hzeiger;
             end;

const oppzeichen:array[11..15] of char = ('+','-','*','/','^');

var _fehler:boolean;

function ableitung(s1:string):string;
function machbaum(b:string):zeiger;
procedure machstring(a:zeiger;var b:string;var op:byte);
procedure _ableitung(a:zeiger;var b:zeiger);
procedure red(var us:string);

implementation

var
    j:integer;
    _start,abl:zeiger;
    wurzel,wa,wb:hzeiger;

procedure red(var us:string);
const
     kr: array[1..7] of string[4] = ('+1*','(1*','-1*','(0+','X^1)','X^1-','X^1+');
     kr2: array[1..8] of string[3] = ('+0)','+0+','+0-','-0)','*1)','*1*','*1+','*1-');
var il,ik:integer;
    expo:string[5];
    lz,ort,a,c:integer;
    kus:string;
    b:char;
begin
  if us<>'' then begin
    for il:=1 to 2 do begin
      if us='(0)' then us:='0';
      if us='X/X' then us:='1';
      if us='(1-1)' then us:='(0)';
      if pos('(-1)*',us)=1 then begin
        delete(us,1,5);
        us:='-'+us
      end;
      if us='(-1)*SIN(X)' then us:='(-SIN(X))';
      while pos(' ',us)<>0 do delete(us,pos(' ',us),1);
      while pos('-)',us)<>0 do delete(us,pos('-)',us),1);

      for ik:=1 to 7 do
        while pos(kr[ik],us)<>0 do delete(us,pos(kr[ik],us)+1,2);
      for ik:=1 to 8 do
        while pos(kr2[ik],us)<>0 do delete(us,pos(kr2[ik],us),2);

      while pos('(-1*',us)<>0 do delete(us,pos('(-1*',us)+2,2);
      if pos('0*',us)=1 then us:='0';
      if pos('0/',us)=1 then us:='0';
      while pos('(0*',us)<>0 do begin
        lz:=pos('(0*',us)+1;
        delete(us,lz,1);
        while (lz<=length(us)) and (us[lz]<>'+') and (us[lz]<>'-')
          do delete(us,lz,1);
      end;
      while pos('(+',us)<>0 do delete(us,pos('(+',us)+1,1);
      while pos('(0-',us)<>0 do delete(us,pos('(0-',us)+1,1);
      while pos('+-',us)<>0 do delete(us,pos('+-',us),1);
      while pos('++',us)<>0 do delete(us,pos('++',us),1);
      while pos('--',us)<>0 do begin
        us[pos('--',us)]:='+';
        delete(us,pos('+-',us)+1,1);
      end;
      while pos('/(X)',us)<>0 do begin
        delete(us,pos('/(X)',us)+1,1);
        delete(us,pos('/X)',us)+2,1);
      end;
      while pos('-(X)',us)<>0 do begin
        delete(us,pos('-(X)',us)+1,1);
        delete(us,pos('-X)',us)+2,1);
      end;
      while pos('+(X)',us)<>0 do begin
        delete(us,pos('+(X)',us)+1,1);
        delete(us,pos('+X)',us)+2,1);
      end;
      while pos('*(X)',us)<>0 do begin
        delete(us,pos('*(X)',us)+1,1);
        delete(us,pos('*X)',us)+2,1);
      end;
      while pos('((X)',us)<>0 do begin
        lz:=pos('((X)',us);
        delete(us,lz+3,1);
        delete(us,lz+1,1);
      end;
      while pos('*1/',us)<>0 do delete(us,pos('*1/',us),2);
      while pos('()',us)<>0 do begin
        ort:=pos('()',us);
        delete(us,ort+1,1);
        us[ort]:='0'
      end;
      if us[1]='+' then delete(us,1,1);
      kus:=copy(us,length(us)-1,2);
      if (kus='+0') or (kus='*1') or (kus='-0')
        then delete(us,length(us)-1,2);
      kus:=copy(us,1,2);
      if (kus='0+') or (kus='1*') then delete(us,1,2);
      if kus='0-' then delete(us,1,1);
      if us[length(us)]='*' then delete(us,length(us),1);
      if us='(1/X)*X' then us:='1';
      if us='X/(X)' then us:='1';
      if us='1-1' then us:='0';
      if us[1]='Z' then begin
        expo:='';
        lz:=2;
        while us[lz]<>'(' do
        begin
          expo:=expo+us[lz];
          inc(lz)
        end;
        delete(us,1,lz-1);
        us:=us+'^'+expo;
      end;
      if us='(SIN(X))' then us:='SIN(X)';
      if us='(COS(X))' then us:='COS(X)';
    end;
    a:=pos('^(',us);
    if (a<>0) and (us[a+3]=')') then begin
      delete(us,a+3,1);
      delete(us,a+1,1);
    end;
    a:=pos('+(',us);
    if (a<>0) and (us[a+3]=')') then begin
      delete(us,a+3,1);
      delete(us,a+1,1);
    end;
    a:=pos('-(',us);
    if (a<>0) and (us[a+3]=')') then begin
      delete(us,a+3,1);
      delete(us,a+1,1);
    end;
    a:=pos('*(',us);
    if (a<>0) and (us[a+3]=')') then begin
      delete(us,a+3,1);
      delete(us,a+1,1);
    end;
    a:=pos('/(',us);
    if (a<>0) and (us[a+3]=')') then begin
      delete(us,a+3,1);
      delete(us,a+1,1);
    end;
    a:=pos('((',us);
    if (a<>0) and (us[a+3]=')') then begin
      delete(us,a+3,1);
      delete(us,a+1,1);
    end;
    if (us[1]='(') and (us[3]=')') then begin
      delete(us,3,1);
      delete(us,1,1)
    end;
    a:=pos('(COS(X))',us);
    b:=us[a-1];
    if (a=1) or ((a>1) and (b in ['+','-','*','/','^','('])) then begin
      delete(us,a+7,1);
      delete(us,a,1)
    end;

    a:=pos('(SIN(X))',us);
    b:=us[a-1];
    if (a=1) or ((a>1) and (b in ['+','-','*','/','^','('])) then begin
      delete(us,a+7,1);
      delete(us,a,1)
    end;
    a:=pos('(-SIN(X))',us);
    b:=us[a-1];
    if (a=1) or ((a>1) and (b='+')) then begin
      delete(us,a+7,1);
      delete(us,a,1);
      if b='+' then delete(us,a-1,1)
    end;
    a:=pos('(-SIN(X))',us);
    b:=us[a-1];
    if ((a>1) and (b='-')) then begin
      delete(us,a+7,1);
      delete(us,a,2);
      us[a-1]:='+'
    end;
    a:=pos('(LN(X))',us);
    b:=us[a-1];
    if (a=1) or ((a>1) and (b in ['+','-','*','/','^','('])) then begin
      delete(us,a+6,1);
      delete(us,a,1)
    end;
    a:=pos('(ABS(X))',us);
    b:=us[a-1];
    if (a=1) or ((a>1) and (b in ['+','-','*','/','^','('])) then begin
      delete(us,a+7,1);
      delete(us,a,1)
    end;
    a:=pos('(+',us);
    if a<>0 then delete(us,a+1,1);
    a:=pos('-(X+1))',us);
    if (a<>0) then begin
      delete(us,a+5,1);
      us[a+3]:='-';
      delete(us,a+1,1);
    end;
    a:=pos('(-COS(X))',us);
    if (a=1) then begin
      delete(us,9,1);
      delete(us,1,1)
    end;
    a:=pos('(-1)',us);
    b:=us[5];
    if (a=1) and not (b='^') then begin
      delete(us,4,1);
      delete(us,1,1)
    end;
    a:=pos('((-1)',us);
    b:=us[6];
    if (a=1) and not (b='^') then begin
      delete(us,5,1);
      delete(us,2,1)
    end;
    a:=pos('((',us);
    if (a=1) then begin
      c:=3;
      b:=us[c];
      while (b<>'(') and (b<>')') do begin
        inc(c);
        b:=us[c];
      end;
      b:=us[c];
      if b=')' then begin
        b:=us[c+1];
        if b in ['+','-',')'] then begin
          delete(us,c,1);
          delete(us,1,1)
        end;
      end;
    end;
  end;
end;

function ableitung;
const
   kr: array[1..4] of string[4] = ('X^1*','X^1)','X^1-','X^1+');
var s2,sabl:string;
    x,i:byte;
begin
  new(wurzel);
  new(wa);
  inc(j);
  inc(j);
  inc(j);
  wurzel^.h1:=nil;
  wurzel^.h2:=wa;
  wa^.h1:=nil;
  wa^.h2:=nil;
  _fehler:=false;
  while pos(',',s1)<>0 do s1[pos(',',s1)]:='.';
  while (pos(' ',s1)<>0) and (length(s1)>1) do delete(s1,pos(' ',s1),1);
  _start:=machbaum(s1);

  if _fehler then sabl:=''
  else begin
    x:=0;
    _ableitung(_start,abl);
    if _fehler then sabl:=''
    else begin
      machstring(abl,s2,x);
      red(s2);
      sabl:=s2;
    end;
  end;

  wa:=wurzel^.h2;
  repeat
    if wa^.h1<>nil then begin
      dispose(wa^.h1);
      dec(j)
    end;
    wb:=wa^.h2;
    dispose(wa);
    dec(j);
    wa:=wb;
  until wa^.h2=nil;
  if (j>0) and (wurzel<>nil) then begin
    dispose(wurzel);
    dec(j)
  end;
  if (j>0) and (wa<>nil) then begin
    dispose(wa);
    dec(j)
  end;
  if (j>0) and (wb<>wa) then begin
    dispose(wb);
    dec(j)
  end;

  for i:=1 to 4 do
    while pos(kr[i],sabl)<>0 do delete(sabl,pos(kr[i],sabl)+1,2);
  if copy(sabl,length(sabl)-1,2)='^1' then delete(sabl,length(sabl)-1,2);
  ableitung:=sabl;
end;

function suchk(a:zeiger):byte;
var b,c:byte;
begin
  b:=a^.opp;
  if b<10 then begin
    if a^.opp=0 then c:=1
                else c:=0;
  end else begin
    if b<20 then begin
      if a^.links^.opp=0 then c:=3
                         else c:=2;
      if a^.rechts^.opp=0 then inc(c,2);
      if c=2 then c:=0;
    end else begin
      if a^.mitte^.opp=0 then c:=2
                         else c:=0;
    end;
  end;
  suchk:=c;
end;

function konstin(b:double):zeiger;
var a:zeiger;
begin
  new(a);
  a.links:=nil;
  a.rechts:=nil;
  a.mitte:=nil;
  inc(j);
  wa^.h1:=a;
  new(wb);
  wb^.h1:=nil;
  wb^.h2:=nil;
  wa^.h2:=wb;
  inc(j);
  wa:=wb;
  a^.opp:=0;
  a^.konstante:=b;
  konstin:=a;
end;

procedure oppin(var a:zeiger;b:byte);
begin
  new(a);
  a.links:=nil;
  a.rechts:=nil;
  a.mitte:=nil;
  inc(j);
  wa^.h1:=a;
  new(wb);
  wa^.h2:=wb;inc(j);
  wb^.h1:=nil;
  wb^.h2:=nil;
  wa:=wb;
  a^.opp:=b;
end;

procedure kopie(a:zeiger;var b:zeiger);
begin
  new(b);
  b^.links:=nil;
  b^.rechts:=nil;
  b^.mitte:=nil;
  inc(j);
  wa^.h1:=b;
  new(wb);
  wa^.h2:=wb;inc(j);
  wb^.h1:=nil;
  wb^.h2:=nil;
  wa:=wb;
  b^.opp:=a^.opp;
  if a^.opp=0 then b^.konstante:=a^.konstante;
  if (a^.opp>10) and (a^.opp<20) then begin
    kopie(a^.links,b^.links);
    kopie(a^.rechts,b^.rechts);
  end;
  if a^.opp>20 then kopie(a^.mitte,b^.mitte);
end;

function machbaum(b:string):zeiger;
var lauf,opnr:byte;
    gefunden:boolean;
    klammer:shortint;
    code:integer;
    zahl:double;
    a:zeiger;

function trigon(trg:string):byte;
begin
  trigon:=0;
  if trg='SIN' then trigon:=1;
  if trg='COS' then trigon:=2;
  if trg='TAN' then trigon:=3;
  if trg='COT' then trigon:=4;
end;

begin
  if b='' then b:=' ';
  if b[1]='-' then b:='0'+b;
  _fehler:=false;
  new(a);
  a.links:=nil;
  a.rechts:=nil;
  a.mitte:=nil;
  inc(j);
  wa^.h1:=a;
  new(wb);
  wa^.h2:=wb;inc(j);
  wb^.h1:=nil;
  wb^.h2:=nil;
  wa:=wb;
  lauf:=length(b);
  if lauf=0 then _fehler:=true
  else begin
    klammer:=0;
    gefunden:=true;
    repeat
      case b[lauf] of
        ')': inc(klammer);
        '(': dec(klammer);
        else if klammer=0 then gefunden:=false;
      end;
      dec(lauf);
      if klammer<0 then _fehler:=true;
    until _fehler or(lauf=0);
    if klammer>0 then _fehler:=true;
    if not(_fehler) then begin
      lauf:=length(b);
      if gefunden then a:=machbaum(copy(b,2,lauf-2))
      else begin
        opnr:=10;
        repeat
          inc(opnr);
          klammer:=0;
          repeat
            if(klammer=0)and(b[lauf]=oppzeichen[opnr]) then gefunden:=true;
            if b[lauf]=')' then inc(klammer);
            if b[lauf]='(' then dec(klammer);
            if not(gefunden) then dec(lauf);
          until gefunden or(lauf=0);
          if not(gefunden) then lauf:=length(b);
        until gefunden or(opnr=15);
        if gefunden then begin
          a^.opp:=opnr;
          if lauf>1 then a^.links:=machbaum(copy(b,1,lauf-1))
          else begin
            if opnr>12 then _fehler:=true
            else begin
              a^.links^.opp:=0;
              a^.links^.konstante:=0;
            end
          end;
          if lauf=length(b) then _fehler:=true;
          if not(_fehler) then a^.rechts:=machbaum(copy(b,lauf+1,length(b)-lauf));
        end else begin
          if b[lauf]=')' then begin
            klammer:=0;
            opnr:=0;
            repeat
              case b[lauf] of
                ',':if klammer=1 then opnr:=lauf;
                ')':inc(klammer);
                 '(':dec(klammer);
              end;
              dec(lauf);
            until klammer=0;
            if opnr>0 then begin
              if lauf<>3 then _fehler:=true
              else begin
                if copy(b,1,3)='SQR' then begin
                  gefunden:=true;
                  a^.opp:=16;
                end;
                if copy(b,1,3)='LLG' then begin
                  gefunden:=true;
                  a^.opp:=17;
                end;
                if not(gefunden) then _fehler:=true
                else begin
                  if (opnr<6)or(opnr>length(b)-2) then _fehler:=true
                  else begin
                    a^.links:=machbaum(copy(b,5,opnr-5));
                    if not(_fehler) then a^.rechts:=machbaum(copy(b,opnr+1,length(b)-opnr-1));
                  end
                end
              end
            end else begin
              opnr:=20;
              case lauf of
                2: if b[1]='L' then begin
                     if b[2]='N' then opnr:=22;
                     if b[2]='G' then opnr:=23;
                     if b[2]='D' then opnr:=28;
                   end;
                3: begin
                     opnr:=30+trigon(copy(b,1,3));
                     if opnr=30 then begin
                       if copy(b,1,3)='EXP' then opnr:=24;
                       if copy(b,1,3)='ABS' then opnr:=25;
                       if copy(b,1,3)='SGN' then opnr:=26;
                       if copy(b,1,3)='INT' then opnr:=27;
                       if copy(b,1,3)='LOG' then opnr:=29;
                     end
                   end;
                4: if b[4]='H' then opnr:=40+trigon(copy(b,1,3))
                   else
                     if b[4]='T' then opnr:=21;
                5: if b[1]='E' then opnr:=24;
                6: if b[1]='W' then opnr:=21
                   else begin
                     if b[6]<>'H' then begin
                       if copy(b,1,3)='ARC' then opnr:=50+trigon(copy(b,4,3));
                     end else begin
                       if copy(b,1,2)='AR' then opnr:=60+trigon(copy(b,3,3));
                     end;
                   end;
              end;
              if opnr mod 10 = 0 then _fehler:=true
              else begin
                a^.opp:=opnr;
                a^.mitte:=machbaum(copy(b,lauf+2,length(b)-lauf-2));
              end
            end
          end else begin
            case b[1] of
              'É': if length(b)=1 then a:=konstin(exp(1.00))
                                  else _fehler:=true;
              'P': if b='PI' then a^.opp:=9
                             else  a^.opp:=2;
              'Y': a^.opp:=7;
              'Q': if length(b)=1 then a^.opp:=8
                                  else _fehler:=true;
              'X': if length(b)=1 then a^.opp:=1 else _fehler:=true;
              else begin
                   val(b,zahl,code);
                   if code<>0 then _fehler:=true else a:=konstin(zahl);
              end
            end
          end
        end
      end
    end
  end;
  if not _fehler then machbaum:=a else machbaum:=nil;
end;

procedure machstring(a:zeiger;var b:string;var op:byte);
var s1,s2:string;
    oppalt1,oppalt2 : byte;

 procedure in_Klammern(var s:string);
 begin
   s:='('+s+')'
 end;
 function klammernoetig(alt,neu:byte; althinten:boolean):boolean;
 const feld: array[11..15,11..15]of byte = ( ( 0, 0, 0, 0, 0 ),
                                             ( 2, 2, 0, 0, 0 ),
                                             ( 3, 3, 0, 1, 0 ),
                                             ( 3, 3, 2, 3, 0 ),
                                             ( 3, 3, 3, 3, 3 ) );
 var k:boolean;
 begin
   k:=false;
   if (alt>10)and(alt<16) then
     case feld[neu,alt] of
       1: if not althinten then k:=true;
       2: if althinten then k:=true;
       3: k:=true
     end;
   klammernoetig:=k;
 end;

begin
  op:=a^.opp;
  case op of
    0: if a^.konstante=pi then b:='ã'
       else begin
         if a^.konstante=exp(1.00) then b:='É'
         else begin
           str(a^.konstante:5:10,b);
           if pos('.',b)<>0 then begin
             while (length(b)>1) and (b[length(b)]='0') do delete(b,length(b),1);
             if b[length(b)]='.' then delete(b,length(b),1);
           end;
         end
       end;
    1: b:='X';
    2: b:='P';
    8: b:='Q';
    9: b:='PI';
    7: b:='Y';
 11..20: begin
         machstring(a^.links,s1,oppalt1);
         machstring(a^.rechts,s2,oppalt2);
         case op of
           16: b:='SQR('+s1+','+s2+')';
           17: b:='LOG('+s1+')';
          else begin
               if klammernoetig(oppalt1,op,false) then in_Klammern(s1);
               if klammernoetig(oppalt2,op,true) then in_Klammern(s2);
               red(s1);
               red(s2);
               if (op in [13,14]) and (s2[1]='-') then s2:='('+s2+')';
               if s1='-1' then s1:='(-1)';
               if s2<>'0' then begin
                 if (op=11) and (s1=s2) and (s1<>'-SIN(X)') then begin
                   s1:='2';
                   op:=13;
                 end;
                 if (op=12) and (s1=s2) then begin
                   s1:='0';
                   s2:='0';
                 end;
                 if (op=14) and (s1=s2) then begin
                   s1:='1';
                   s2:='1';
                 end;
                 if (op=13) and (s1=s2) and (s1<>'1') then begin
                   s2:='2';
                   op:=15;
                 end;
                 if (op=15) and (s2='1') then b:=s1
                                         else b:=s1+oppzeichen[op]+s2;
               end else
                 case op of
                    11,12 : b:=s1;
                    13,14 : b:='0';
                    15    : b:='1';
                 end;
               end
          end
         end else begin
           machstring(a^.mitte,s1,oppalt1);
           if op<30 then
             case op of
               21: s2:='SQRT';
               22: s2:='LN';
               23: s2:='LG';
               24: s2:='EXP';
               25: s2:='ABS';
               26: s2:='SGN';
               27: s2:='INT';
               28: s2:='LD';
               29: s2:='1/LN(P)*1/';
             end
           else begin
             case (op mod 10) of
               1: s2:='SIN';
               2: s2:='COS';
               3: s2:='TAN';
               4: s2:='COT';
             end;
             case (op div 10) of
               4: s2:=s2+'H';
               5: s2:='ARC'+s2;
               6: s2:='AR'+s2+'H';
             end;
           end;
           b:=s2+'('+s1+')';
           red(b);
     end
   end
end;

procedure _ableitung(a:zeiger;var b:zeiger);
var c:zeiger;
begin
  c:=nil;
  case a^.opp of
      0: b:=konstin(0);
      1: b:=konstin(1);
   2..9: b:=konstin(0);
  11,12: begin
           oppin(b,a^.opp);
           _ableitung(a^.links,b^.links);
           _ableitung(a^.rechts,b^.rechts);
         end;
     13: case suchk(a) of
           3:begin   {Konstantenregel}
               oppin(b,13);
               kopie(a^.links,b^.links);
               _ableitung(a^.rechts,b^.rechts);
             end;
           4:begin   {Konstantenregel}
               oppin(b,13);
               kopie(a^.rechts,b^.links);
               _ableitung(a^.links,b^.rechts);
             end;
           0:begin   {Produktregel}
               oppin(b,11);oppin(c,13);
               _ableitung(a^.links,c^.links);
               kopie(a^.rechts,c^.rechts);
               b^.links:=c;
               oppin(c,13);
               kopie(a^.links,c^.links);
               _ableitung(a^.rechts,c^.rechts);
               b^.rechts:=c;
             end;
         else b:=konstin(0);
         end;
     14: case suchk(a) of
           3:begin   {Ableitung c/f(x)}
               oppin(b,13);
               b^.links:=konstin(-a^.links^.konstante);
               oppin(c,14);
               _ableitung(a^.rechts,c^.links);
               b^.rechts:=c;
               oppin(c,15);
               kopie(a^.rechts,c^.links);
               c^.rechts:=konstin(2);
               b^.rechts^.rechts:=c;
             end;
           4:begin   {Konstantenregel}
               oppin(b,14);
               kopie(a^.rechts,b^.rechts);
               _ableitung(a^.links,b^.links);
             end;
           0:begin   {Quotientenregel}
               oppin(b,14);
               oppin(b^.links,12);
               oppin(c,13);
               _ableitung(a^.links,c^.links);
               kopie(a^.rechts,c^.rechts);
               b^.links^.links:=c;
               oppin(c,13);
               kopie(a^.links,c^.links);
               _ableitung(a^.rechts,c^.rechts);
               b^.links^.rechts:=c;
               oppin(c,15);
               kopie(a^.rechts,c^.links);
               c^.rechts:=konstin(2);
               b^.rechts:=c;
             end;
           else b:=konstin(0);
         end;
     15: case suchk(a) of
           3:begin   {logarithmische Differenziation}
               oppin(b,13);
               _ableitung(a^.rechts,b^.rechts);oppin(b^.links,13);
               oppin(b^.links^.rechts,22);
               b^.links^.rechts^.mitte:=konstin(a^.links^.konstante);
               kopie(a,b^.links^.links);
             end;
           4:begin   {Kettenregel}
               oppin(b,13);
               _ableitung(a^.links,b^.rechts);
               oppin(b^.links,13);
               b^.links^.links:=konstin(a^.rechts^.konstante);
               oppin(b^.links^.rechts,15);
               b^.links^.rechts^.rechts:=konstin(a^.rechts^.konstante-1);
               kopie(a^.links,b^.links^.rechts^.links);
             end;
           0:begin   {logarithmische Differenziation}
               oppin(b,13);
               kopie(a,b^.links);
               oppin(c,11);
               oppin(c^.links,13);
               _ableitung(a^.rechts,c^.links^.links);
               oppin(c^.links^.rechts,22);
               kopie(a^.links,c^.links^.rechts^.mitte);
               oppin(c^.rechts,13);
               _ableitung(a^.links,c^.rechts^.links);
               oppin(c^.rechts^.rechts,14);
               kopie(a^.rechts,c^.rechts^.rechts^.links);
               kopie(a^.links,c^.rechts^.rechts^.rechts);
               kopie(c,b^.rechts);
             end;
           else b:=konstin(0);
         end;
     16: case suchk(a) of
           3,4,0:begin
               oppin(c,15);
               c^.links:=a^.links;
               oppin(c^.rechts,14);
               c^.rechts^.links:=konstin(1);
               kopie(a^.rechts,c^.rechts^.rechts);
               _ableitung(c,b);
           end;
           else b:=konstin(0);
         end;
     17: case suchk(a) of
           3,4,0:begin
               oppin(c,14);
               oppin(c^.links,22);
               kopie(a^.links,c^.links^.mitte);
               oppin(c^.rechts,22);
               kopie(a^.rechts,c^.rechts^.mitte);
               _ableitung(c,b);
           end;
          else b:=konstin(0);
        end;
   else begin         {Funktionen f(x)}
          case a^.opp of
          21:begin    {Wurzel}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,14);
               c^.links:=konstin(1);
               oppin(c^.rechts,13);
               c^.rechts^.links:=konstin(2);
               kopie(a,c^.rechts^.rechts);
               kopie(c,b^.rechts);
             end;
    22,23,28:begin    { lg(x) -> (1/ln(10))/x }
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,14);
               kopie(a^.mitte,c^.rechts);
               if (a^.opp=22) then c^.links:=konstin(1)
               else
                 if a^.opp=23 then c^.links:=konstin(1/ln(10.00))
                 else
                   c^.links:=konstin(1/ln(2.00));
               kopie(c,b^.rechts);
             end;
          29:begin    {exp(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               kopie(a,b^.rechts);
             end;
          24:begin
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               kopie(a,b^.rechts);
             end;
          25:begin   {abs(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(b^.rechts,26);
               kopie(a^.mitte,b^.rechts^.mitte);
             end;
       26,27:b:=konstin(0);
          31:begin    {sin(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(b^.rechts,32);
               kopie(a^.mitte,b^.rechts^.mitte);
             end;
          32:begin      {cos(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,13);
               c^.links:=konstin(-1);
               oppin(c^.rechts,31);
               kopie(a^.mitte,c^.rechts^.mitte);
               kopie(c,b^.rechts);
             end;
          33:begin      {tan(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,11);
               c^.links:=konstin(1);
               oppin(c^.rechts,15);
               kopie(a,c^.rechts^.links);
               c^.rechts^.rechts:=konstin(2);
               kopie(c,b^.rechts);
             end;
          34:begin      {cot(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,12);
               c^.links:=konstin(-1);
               oppin(c^.rechts,15);
               kopie(a,c^.rechts^.links);
               c^.rechts^.rechts:=konstin(2);
               kopie(c,b^.rechts);
             end;
       41,42:begin      {sinh(x)}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               if a^.opp=41 then oppin(c,42) else oppin(c,41);
               kopie(a^.mitte,c^.mitte);
               kopie(c,b^.rechts);
             end;
       43,44:begin
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,12); c^.links:=konstin(1);
               oppin(c^.rechts,15);
               kopie(a,c^.rechts^.links);
               c^.rechts^.rechts:=konstin(2);
               kopie(c,b^.rechts);
             end;
       51,52:begin      {arc}
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,14);
               oppin(c^.rechts,21);
               oppin(c^.rechts^.mitte,12);
               c^.rechts^.mitte^.links:=konstin(1);
               oppin(c^.rechts^.mitte^.rechts,15);
               kopie(a^.mitte,c^.rechts^.mitte^.rechts^.links);
               c^.rechts^.mitte^.rechts^.rechts:=konstin(2);
               if a^.opp=51 then c^.links:=konstin(1)
                            else c^.links:=konstin(-1);
               kopie(c,b^.rechts);
             end;
       53,54:begin
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,14);
               oppin(c^.rechts,11);
               c^.rechts^.links:=konstin(1);
               oppin(c^.rechts^.rechts,15);
               kopie(a^.mitte,c^.rechts^.rechts^.links);
               c^.rechts^.rechts^.rechts:=konstin(2);
               if a^.opp=53 then c^.links:=konstin(1)
                            else c^.links:=konstin(-1);
               kopie(c,b^.rechts);
             end;
       61,62:begin
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,14);
               oppin(c^.rechts,21);
               oppin(c^.rechts^.mitte,11);
               if a^.opp=61 then c^.rechts^.mitte^.links:=konstin(1)
                            else c^.rechts^.mitte^.links:=konstin(-1);
               oppin(c^.rechts^.mitte^.rechts,15);
               kopie(a^.mitte,c^.rechts^.mitte^.rechts^.links);
               c^.rechts^.mitte^.rechts^.rechts:=konstin(2);
               c^.links:=konstin(1);
               kopie(c,b^.rechts);
             end;
       63,64:begin
               oppin(b,13);
               _ableitung(a^.mitte,b^.links);
               oppin(c,14);
               oppin(c^.rechts,12);
               c^.rechts^.links:=konstin(1);
               oppin(c^.rechts^.rechts,15);
               kopie(a^.mitte,c^.rechts^.rechts^.links);
               c^.rechts^.rechts^.rechts:=konstin(2);
               c^.links:=konstin(1);
               kopie(c,b^.rechts);
             end;
       end
     end;
   end;
   c:=nil;
end;

end.
