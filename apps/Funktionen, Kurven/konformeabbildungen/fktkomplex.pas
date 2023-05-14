unit fktkomplex;

interface

uses complexm, sysutils;

type
    tkomplexzahl = record re,im:extended end;

var
    fehlerkomplex : byte;
    q_k,p_k  : tkomplexzahl;
    function  funktionswertkomplex(term:string; z:tkomplexzahl):tkomplexzahl;
    procedure termkorrektur(var term:string);
    
implementation

uses math;

const ueberlauf:extended=1e30;
var   ax: ARRAY[1..6] OF TComplex;

procedure termkorrektur(var term:string);
begin
  while pos(',',term)<>0 do term[pos(',',term)]:='.';
  term:=trim(term);
  while (pos(' ',term)<>0) and (length(Term)>1) do delete(term,pos(' ',term),1);
  if term[1]='-' then term:='0'+term;
  if term[1]='+' then term:='0'+term;
end;

function funktionswertkomplex;
const zahlen: set of char=['0'..'9','.','é','i'];
  funktionen= 'SQR SQRT EXP LN ABS SIN COS TAN COSH SINH TANH GAMMA BI0 BJ0 '+
              'SEC CSC COT DN SN CN RIEMANN TRE TIM COTH EI DIGAMMA';
type  link=^stapelelement;
      stapelelement=record
                       re:tkomplexzahl;
                       ch:char;
                       by:byte;
                       next:link
                    end;

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
      dnuk,cnvkk,dnvkk,snvkk,snuk,cnuk,yr,xr,kr,are,aim:double;
    function zeta(a:tkomplexzahl):tkomplexzahl;
    var i:integer;
        po:extended;
    begin
      ax[6]:= CSet(1,0);
      ax[1]:= CSet(a.re,a.im);
      ax[2]:= CSet(1,0);
      i:=1;
      repeat
        ax[3]:= Cset(i+1,0);
        ax[4]:= CPower(ax[3],ax[1]);
        po:=ax[4].x*ax[4].x+ax[4].y*ax[4].y;
        ax[5]:= Cset(ax[4].x/po,-ax[4].y/po);// CDiv(ax[2],ax[4]);
        ax[6]:= CAdd(ax[6],ax[5]);
        inc(i);
      until i>47;
      zeta.re:=ax[6].x;
      zeta.im:=ax[6].y;
    end;

    Procedure E1Z(Var are,aim:double);
    Type COMPLEX = Array[1..2] of Double;
    Var  CE1, Z: COMPLEX;

      FUNCTION CABS(Z:COMPLEX): Double;
      Var X,Y,W: Double;
      Begin
        X:=ABS(Z[1]);
        Y:=ABS(Z[2]);
        IF X = 0.0 THEN W:=Y
        ELSE
          IF Y = 0.0 THEN W:=X
          ELSE
            IF X > Y THEN W:=X*SQRT(1.0+(Y/X)*(Y/X))
                     ELSE W:=Y*SQRT(1.0+(X/Y)*(Y/X));
        CABS:=W
      End;

      Procedure CDIV(Z1,Z2:Complex; Var Z:Complex);
      Var D:double;
      Begin
        D:=Z2[1]*Z2[1]+Z2[2]*Z2[2];
        if D<1e-12 then exit;
        Z[1]:=(Z1[1]*Z2[1]+Z1[2]*Z2[2])/D;
        Z[2]:=(Z1[2]*Z2[1]-Z1[1]*Z2[2])/D
      End;

      Procedure CEXP(Z:Complex; Var Z1:Complex);
      Var tmp:double;
      Begin
        if exp(Z[1]) > 1e16 then tmp:=1e16
                            else tmp:=exp(Z[1]);
        Z1[1]:=tmp*cos(Z[2]);
        Z1[2]:=tmp*sin(Z[2])
      End;

      Procedure CLOG(ZA:COMPLEX; var ZB:COMPLEX; var IERR:integer);
      Label 10,20,30,40,50,60,return;
      Var AR,AI,BR,BI,ZM, DTHETA, DPI, DHPI: double;
      Begin
        Br:=1;
        bi:=1;
        DPI := 3.141592653589793238462643383E+0000;
        DHPI:= 1.570796326794896619231321696E+0000;

        IERR:=0;
        AR:=ZA[1];
        AI:=ZA[2];
        IF AR = 0.0 THEN GOTO 10;
        IF AI = 0.0 THEN GOTO 20;
        DTHETA := ArcTan(AI/AR);
        IF DTHETA <= 0.0 THEN GOTO 40;
        IF AR < 0.0 THEN DTHETA := DTHETA - DPI;
        GOTO 50;
10:     IF AI = 0.0 THEN GOTO 60;
        BI := DHPI;
        BR := Ln(ABS(AI));
        IF AI < 0.0 THEN BI := -BI;
        GOTO RETURN;
20:     IF AR > 0.0 THEN GOTO 30;
        BR := Ln(ABS(AR));
        BI := DPI;
        GOTO RETURN;
30:     BR := Ln(AR);
        BI := 0.0;
        GOTO RETURN;
40:     IF AR < 0.0 THEN DTHETA := DTHETA + DPI;
50:     ZM := CABS(ZA);
        BR := Ln(ZM);
        BI := DTHETA;
        GOTO RETURN;
60:     IERR:=1;
return: ZB[1]:=BR; ZB[2]:=BI;
      End; {CLOG}

      Procedure CMUL(Z1,Z2:Complex; Var Z:Complex);
      Begin
        Z[1]:=Z1[1]*Z2[1] - Z1[2]*Z2[2];
        Z[2]:=Z1[1]*Z2[2] + Z1[2]*Z2[1]
      End;

    Label 15;
    Var A0,EL: Double;
        CK,CONE,CR,CT,CT0,TMP,TMP1: COMPLEX;
        IERR,K:Integer;
        x: Double;
    Begin
      Z[1]:=are;
      Z[2]:=aim;
      EL:=0.5772156649015328;
      X:=Z[1];
      A0:=CABS(Z);
      IF A0 = 0.0 THEN begin
        CE1[1]:=1.0E+10;
        CE1[2]:=0.0
      end ELSE
        IF ((A0 <= 10.0) OR (X < 0.0) AND (A0 <20.0)) THEN begin
          CE1[1]:=1.0;
          CE1[2]:=0.0;
          CR[1]:=1.0;
          CR[2]:=0.0;
          For K:=1 to 150 do begin
            CMUL(CR,Z,CR);
            CR[1]:=-K*CR[1]/Sqr(K+1.0);
            CR[2]:=-K*CR[2]/Sqr(K+1.0);
            CE1[1]:=CE1[1]+CR[1];
            CE1[2]:=CE1[2]+CR[2];
            IF CABS(CR) <= CABS(CE1)*1.0E-15 Then GOTO 15
          end;
15:       CLOG(Z,TMP,IERR);
          CMUL(Z,CE1,TMP1);
          CE1[1]:=-EL-TMP[1]+TMP1[1];
          CE1[2]:=   -TMP[2]+TMP1[2];
        end ELSE begin
          CT0[1]:=0.0;
          CT0[2]:=0.0;
          For K:=120 Downto 1 do begin
            CK[1]:=1.0*K;
            CK[2]:=0.0;
            TMP[1]:=1.0+CK[1];
            TMP[2]:=0.0;
            TMP1[1]:=Z[1]+CT0[1];
            TMP1[2]:=Z[2]+CT0[2];
            CDIV(TMP,TMP1,TMP);
            CDIV(CK,TMP,CT0)
          end;
          CONE[1]:=1.0;
          CONE[2]:=0.0;
          TMP[1]:=Z[1]+CT0[1];
          TMP[2]:=Z[2]+CT0[2];
          CDIV(CONE,TMP,CT);
          TMP[1]:=-Z[1];
          TMP[2]:=-Z[2];
          CEXP(TMP,TMP1);
          CMUL(TMP1,CT,CE1);
          IF (X <= 0.0) AND (Z[2] = 0.0) Then begin
            TMP[1]:=0.0;
            TMP[2]:=1.0;
            CE1[1]:=CE1[1]-PI*TMP[1];
            CE1[2]:=CE1[2]-PI*TMP[2]
          end
        end;
      are:=ce1[1];
      aim:=ce1[2];
    end;

    Procedure digamma(var are,aim:Double);
    Var  aa,E,X,Y,Z,PSR,PSI: Double;
         Ac, W: Array[1..9] of DOUBLE;

      Function IPower(x:double; n:integer): double;
      var i,m : integer;
          res :double;
      begin
        res := 1.0;
        if n=0 then begin
          IPower:=res;
          exit
        end;
        m:=  n;
        if n<0 then m:=-n;
        for i:=1 to m do res :=x*res;
        IPower :=res;
        if n<0 then IPower:=1.0/res
      end;

      Procedure WCoeffs(X:DOUBLE);
      Var I:Integer;
      Begin
        aa:=0.5;
        Z:=X;
        for I:=1 to 9 do begin
          W[I]:=0.0;
          if Z>aa then W[I]:=1.0;
          Z:=Z-W[I]*aa;
          aa:=aa/2.0
        end
      End;

      Procedure Coeffs;
      Begin
        E:=Exp(1.0);
        Ac[1]:=1.648721270700128;
        Ac[2]:=1.284025416687742;
        Ac[3]:=1.133148453066826;
        Ac[4]:=1.064494458917859;
        Ac[5]:=1.031743407499103;
        Ac[6]:=1.015747708586686;
        Ac[7]:=1.007843097206448;
        Ac[8]:=1.003913889338348;
        Ac[9]:=1.001955033591003
      End;

      Function XExp(X:DOUBLE): DOUBLE;
      Label fin;
      Var Y:DOUBLE;
          I,K:Integer;
      Begin
        Coeffs;
        K:=Round(INT(X));
        X:=X-K;
        WCoeffs(X);
        Y:=1.0;
        for I:=1 to 9 do
          if W[I]>0.0 then Y:=Y*Ac[I];
        Y:=Y*(1.0+Z*(1.0+Z/2.0*(1.0+Z/3.0*(1.0+Z/4.0))));
        if K<0 then E:=1.0/E;
        if ABS(K)<1 then goto fin;
        for I:=1 to ABS(Round(K)) do Y:=Y*E;
fin:    XExp:=Y
      End;

      Function SinH(X:DOUBLE): DOUBLE;
      Label 10,fin;
      Var Y:DOUBLE;
          I:Integer;
      Begin
        if ABS(X)<0.35 then goto 10;
        Y:=XExp(X);
        Y:=(Y-(1.0/Y))/2.0;
        goto fin;
10:     Z:=1.0;
        Y:=1.0;
        for I:=1 to 8 do begin
          Z:=Z*X*X/((2*I)*(2*I+1));
          Y:=Y+Z
        end;
        Y:=X*Y;
fin:    SinH:=Y
      End;

      Function CosH(X:DOUBLE): DOUBLE;
      Var Y:DOUBLE;
      Begin
        Y:=XExp(X);
        Y:=(Y+(1.0/Y))/2.0;
        CosH:=Y
      End;

      Function TanH(X:DOUBLE): DOUBLE;
      Var V,Y: DOUBLE;
      Begin
        V:=SinH(X);
        Y:=CosH(X);
        TanH:=V/Y
      End;

    Var A: array[1..8] of Double;
        CT2,RI,RR,TH,TM,TN,X0,X1,{Y1,}Z0,Z2:Double;
        K,N:Integer;
    Begin
      x:=are;
      y:=aim;
      th:=1;
      n:=1;
      x1:=0;
      A[1]:=-0.8333333333333E-01;
      A[2]:=0.83333333333333333E-02;
      A[3]:=-0.39682539682539683E-02;
      A[4]:=0.41666666666666667E-02;
      A[5]:=-0.75757575757575758E-02;
      A[6]:=0.21092796092796093E-01;
      A[7]:=-0.83333333333333333E-01;
      A[8]:=0.4432598039215686;

      IF (Y = 0.0) AND (X = INT(X)) AND (X <= 0.0) THEN begin
        PSR:=1.0E+10;
        PSI:=0.0
      end ELSE begin
        IF X < 0.0 THEN begin
          X1:=X;
          X:=-X;
          Y:=-Y
        end;
        X0:=X;
        IF X < 8.0 THEN begin
          N:=8-Round(INT(X));
          X0:=X+1.0*N
        end;
        IF (X0 = 0.0) AND (Y <> 0.0) Then TH:=0.5*PI;
        IF X0 <> 0.0 Then TH:=ArcTan(Y/X0);
        Z2:=X0*X0+Y*Y;
        Z0:=SQRT(Z2);
        PSR:=Ln(Z0)-0.5*X0/Z2;
        PSI:=TH+0.5*Y/Z2;
        For K:=1 to 8 do begin
          PSR:=PSR+A[K]*IPower(Z2,-K)*COS(2.0*K*TH);
          PSI:=PSI-A[K]*IPower(Z2,-K)*SIN(2.0*K*TH)
        end;
        IF X < 8.0 THEN begin
          RR:=0.0;
          RI:=0.0;
          For K:=1 to N do begin
            RR:=RR+(X0-K)/(Sqr(X0-K)+Y*Y);
            RI:=RI+Y/(Sqr(X0-K)+Y*Y)
          end;
          PSR:=PSR-RR;
          PSI:=PSI+RI
        end;
        IF X1 < 0.0 THEN begin
          TN:=SIN(PI*X)/COS(PI*X);
          TM:=TANH(PI*Y);
          CT2:=TN*TN+TM*TM;
          PSR:=PSR+X/(X*X+Y*Y)+PI*(TN-TN*TM*TM)/CT2;
          PSI:=PSI-Y/(X*X+Y*Y)-PI*TM*(1.0+TN*TN)/CT2;
        end
      end;
      are:=psr;
      aim:=psi;
    End; {CPSI}

    PROCEDURE sncndn(uu,emmc: double; VAR sn,cn,dn: double);
    LABEL 1;
    CONST
       ca=0.0003;
    VAR
       a,b,c,d,emc,u: double;
       i,ii,l: integer;
       bo: boolean;
       em,en: ARRAY [1..13] OF double;
      FUNCTION cosh(u: double): double;
      BEGIN
        cosh := 0.5*(exp(u)+exp(-u))
      END;
      FUNCTION tanh(u: double): double;
      VAR
         u2,epu,emu: double;
      BEGIN
        epu := exp(u);
        emu := 1.0/epu;
        IF (abs(u)<0.3) THEN BEGIN
          u2 := u*u;
          tanh := 2*u*(1+u2/6*(1+u2/20*(1+u2/42*(1+u2/72))))/(epu+emu)
        END
        ELSE
          tanh := (epu-emu)/(epu+emu)
      END;
    BEGIN
      d:=1;
      emc := emmc;
      u := uu;
      IF (emc <> 0.0) THEN BEGIN
        bo := (emc < 0.0);
        IF (bo) THEN BEGIN
          d := 1.0-emc;
          emc := -emc/d;
          d := sqrt(d);
          u := d*u
        END;
        a := 1.0;
        dn := 1.0;
        FOR i := 1 TO 13 DO BEGIN
          l := i;
          em[i] := a;
          emc := sqrt(emc);
          en[i] := emc;
          c := 0.5*(a+emc);
          IF (abs(a-emc) <= ca*a) THEN GOTO 1;
          emc := a*emc;
          a := c
        END;
1:      u := c*u;
        sn := sin(u);
        cn := cos(u);
        IF (sn <> 0.0) THEN BEGIN
          a := cn/sn;
          c := a*c;
          FOR ii := l DOWNTO 1 DO BEGIN
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
        IF (bo) THEN BEGIN
          a := dn;
          dn := cn;
          cn := a;
          sn := sn/d
        END;
      END ELSE BEGIN
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
           if (a.re=0) and (a.im=0) then begin
             funktion.re:=0;
             funktion.im:=0
           end
           else
             if abs(a.re)<ueberlauf then begin
               funktion.re:=sqr(1.0*a.re)+sqr(1.0*a.im);
               funktion.im:=2.0*a.re*a.im;
             end else begin
               funktion.re:=1e20;
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
           if (a.re<>0) or (a.im<>0) then begin
             funktion.re:=1/2*ln(a.re*a.re+a.im*a.im);
             if a.re<>0 then funktion.im:=arctan2(a.im,a.re)//arctan(a.im/a.re)//
             else begin
               if a.im<0 then funktion.im:=-pi/2
                         else funktion.im:=pi/2
             end;
           end else begin
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
           if (abs(a.re)<120) and (abs(a.im)<120) then begin
             ax[2]:= CSin(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end else begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     25: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           if (abs(a.re)<120) and (abs(a.im)<120) then begin
             ax[2]:= CCos(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end else begin
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
           if (abs(a.re)<120) and (abs(a.im)<120) then begin
             ax[2]:= Ccosh(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end else begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     38: begin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           if (abs(a.re)<120) and (abs(a.im)<120) then begin
             ax[2]:= Csinh(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end else begin
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
           if (a.re<>0) or (a.im<>0) then begin
             ax[1]:= CSet(a.re,a.im);
             ax[2]:= CCSC(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end else begin
             funktion.re:=0;
             funktion.im:=0;
           end;
         end;
     74: begin
           a:=gesamtkette;
           xr:=0.2;
           kr:=1-xr*xr;
           sncndn(a.re,kr,snuk,cnuk,dnuk);
           sncndn(a.im,sqrt(1-kr*kr),snvkk,cnvkk,dnvkk);
           yr:=1-dnuk*dnuk*snvkk*snvkk;
           funktion.re:=dnuk*cnvkk*dnvkk/yr;
           funktion.im:=-kr*kr*snuk*cnuk*snvkk/yr;
         end;
     77: begin
           a:=gesamtkette;
           xr:=0.2;
           kr:=1-xr*xr;
           sncndn(a.re,kr,snuk,cnuk,dnuk);
           sncndn(a.im,sqrt(1-kr*kr),snvkk,cnvkk,dnvkk);
           yr:=1-dnuk*dnuk*snvkk*snvkk;
           funktion.re:=snuk*dnvkk/yr;
           funktion.im:=cnuk*dnuk*snvkk*cnvkk/yr;
         end;
     80: begin
           a:=gesamtkette;
           xr:=0.2;
           kr:=1-xr*xr;
           sncndn(a.re,kr,snuk,cnuk,dnuk);
           sncndn(a.im,sqrt(1-kr*kr),snvkk,cnvkk,dnvkk);
           yr:=1-dnuk*dnuk*snvkk*snvkk;
           funktion.re:=cnuk*cnvkk/yr;
           funktion.im:=snuk*dnuk*snvkk*dnvkk/yr;
         end;
     83: begin
           a:=gesamtkette;
           funktion:=zeta(a);
         end;
     91: begin
           a:=gesamtkette;
           a.im:=0;
           funktion:=a;
         end;
     95: begin
           a:=gesamtkette;
           a.re:=0;
           funktion:=a;
         end;
     99: begin  //coth
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           ax[2]:= Ccoth(ax[1]);
           funktion.re:=ax[2].x;
           funktion.im:=ax[2].y;
         end;
    104: begin
           a:=gesamtkette;
           are:=a.re;
           aim:=a.im;
           e1z(are,aim);
           funktion.re:=are;
           funktion.im:=aim;
         end;
    107: begin //digamma
           a:=gesamtkette;
           are:=a.re;
           aim:=a.im;
           digamma(are,aim);
           funktion.re:=are;
           funktion.im:=aim;
         end;
{    104: begin  //arcsin
           a:=gesamtkette;
           ax[1]:= CSet(a.re,a.im);
           vz:=1;
           if a.re<0 then vz:=-1;
           funktion.re:=vz/2*arccos(sqrt( sqr(a.re*a.re+a.im*a.im-1)+4*a.im*a.im)
                                   -a.re*a.re-a.im*a.im);
           vz:=1;
           if ax[1].y<0 then vz:=-1;
           funktion.im:=vz/2*arccosh(sqrt( sqr(ax[1].x*ax[1].x+ax[1].y*ax[1].y-1)+4*ax[1].y*ax[1].y)
                                   +ax[1].x*ax[1].x+ax[1].y*ax[1].y);
         end;  }
     70: begin
           a:=gesamtkette;
           if (a.re<>0) or (a.im<>0) then begin
             ax[1]:= CSet(a.re,a.im);
             ax[2]:= CCOT(ax[1]);
             funktion.re:=ax[2].x;
             funktion.im:=ax[2].y;
           end else begin
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
      'A'..'H','L'..'O','R'..'T','V','W': wert:=funktion;
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
      'Q': begin
             wert:=q_k;
             inc(zeiger)
           end;
      'P': if length(term)=zeiger then begin
             wert:=p_k;
             inc(zeiger)
           end else begin
             if (term[zeiger+1]='I') then begin
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
    if zeiger<len then begin
      z:=term[zeiger];
      inc(zeiger);
      case z of
        '+','-','<','>','&','#': p:=1;
        '*','·','/','~','%': p:=2;
        '^','\'    : p:=3;
        ')',']','|': p:=0
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
    if term[zeiger]='-' then begin
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
             if (abs(a.re)<ueberlauf) and (abs(b.re)<ueberlauf) then begin
               ax[3]:=CMult(ax[1],ax[2]);
               ergebnis.re:=ax[3].x;
               ergebnis.im:=ax[3].y;
             end else begin
               ergebnis.re:=1e10;
               fehlerkomplex:=2
             end;
           end;
      '/': if (cabs(ax[2])<>0) then begin
             ax[3]:= CDiv(ax[1],ax[2]);
             ergebnis.re:=ax[3].x;
             ergebnis.im:=ax[3].y;
           end else begin
             ergebnis.re:=1e10;
             fehlerkomplex:=2
           end;
      '^': begin
             if fehlerkomplex>1 then begin
               ergebnis.re:=0;
               fehlerkomplex:=2
             end else begin
               if (b.re=0) and (b.im=0) then begin
                 ergebnis.re:=1;
                 ergebnis.im:=0
               end else begin
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
  if term<>'' then begin
    while pos(',',term)<>0 do term[pos(',',term)]:='.';
    while pos('(-',term)<>0 do term:=copy(term,1,pos('(-',term))
                                +'0'+copy(term,pos('(-',term)+1,255);
    fehlerkomplex:=0;
    zeiger:=1;
    len:=length(term);
    stapel:=nil;
    ergeb:=gesamtkette;
    if ergeb.re*ergeb.re+ergeb.im*ergeb.im>ueberlauf then begin
      funktionswertkomplex.re:=ueberlauf;
      fehlerkomplex:=4
    end
    else funktionswertkomplex:=ergeb;
  end else begin
    funktionswertkomplex.re:=0;
    funktionswertkomplex.im:=0;
    fehlerkomplex:=1
  end;
end;

end.
