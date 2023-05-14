unit fktint;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

const
    absolutea : real = -1e6;
    absoluteb : real = 1e6;
    absolutegesetzt : boolean = false;
    absoluteauto    : boolean = true;
var
    fehler,mfehler    : byte;
    q,p,r,deltas : real;
    o_        : array[1..5] of real;
    f         : array[1..10] of string;
    function  funktionswert(term:string; x:real):real;
    function sonderfunktion(nr:byte;a,b:real;var ffehler:boolean):real;

implementation

uses math;

const ueberlauf:real=1e10;

function sonderfunktion(nr:byte;a,b:real;var ffehler:boolean):real;
var r:real;
FUNCTION gammaln(xx: real): real;
CONST
   stp = 2.50662827465;
   fpf = 5.5;
VAR x,tmp,ser: double; j:integer;
   cof: ARRAY [1..6] OF double;
BEGIN
   gammaln:=0;
   cof[1] := 76.18009173;
   cof[2] := -86.50532033;
   cof[3] := 24.01409822;
   cof[4] := -1.231739516;
   cof[5] := 0.120858003e-2;
   cof[6] := -0.536382e-5;
   x := xx-1.0;
   tmp := x+fpf;
   if (tmp<=0) or (tmp>25) then begin ffehler:=true; exit end;
   tmp := (x+0.5)*ln(tmp)-tmp;
   ser := 1.0;
   FOR j := 1 TO 6 DO BEGIN
      x := x+1.0;
      if x=0 then begin ffehler:=true; exit end;
      ser := ser+cof[j]/x
   END;
   if stp*ser<=0 then begin ffehler:=true; exit end;
   gammaln := tmp+ln(stp*ser)
END;

FUNCTION beta(z,w: real): real;
BEGIN
   z := gammaln(z)+gammaln(w)-gammaln(z+w);
  if abs(z)<50 then beta := exp(z) else begin ffehler:=true; beta:=0 end;
END;

FUNCTION bessj0(x: real): real;
VAR
   ax,xx,z: real;  y,ans1,ans2: double;
BEGIN
   IF (abs(x) < 8.0) THEN BEGIN
      y := sqr(x);
      ans1 := 57568490574.0+y*(-13362590354.0+y*(651619640.7
         +y*(-11214424.18+y*(77392.33017+y*(-184.9052456)))));
      ans2 := 57568490411.0+y*(1029532985.0+y*(9494680.718
         +y*(59272.64853+y*(267.8532712+y))));
      bessj0 := ans1/ans2  END
   ELSE BEGIN
      ax := abs(x); z := 8.0/ax; y := sqr(z); xx := ax-0.785398164;
      ans1 := 1.0+y*(-0.1098628627e-2+y*(0.2734510407e-4
         +y*(-0.2073370639e-5+y*0.2093887211e-6)));
      ans2 := -0.1562499995e-1+y*(0.1430488765e-3
         +y*(-0.6911147651e-5+y*(0.7621095161e-6
         -y*0.934945152e-7)));
      bessj0 := sqrt(0.636619772/ax)*(cos(xx)*ans1-z*sin(xx)*ans2);
   END
END;

FUNCTION bessj1(x: real): real;
VAR  ax,xx,z: real;  y,ans1,ans2: double;
FUNCTION sign(x: real): real;
BEGIN IF x >= 0.0 THEN sign := 1.0 ELSE sign := -1.0; END;
BEGIN
   IF (abs(x) < 8.0) THEN BEGIN
      y := sqr(x);
      ans1 := x*(72362614232.0+y*(-7895059235.0+y*(242396853.1
         +y*(-2972611.439+y*(15704.48260+y*(-30.16036606))))));
      ans2 := 144725228442.0+y*(2300535178.0+y*(18583304.74
         +y*(99447.43394+y*(376.9991397+y))));
      bessj1 := ans1/ans2  END
   ELSE BEGIN
      ax := abs(x); z := 8.0/ax; y := sqr(z); xx := ax-2.356194491;
      ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4
         +y*(0.2457520174e-5+y*(-0.240337019e-6))));
      ans2 := 0.04687499995+y*(-0.2002690873e-3
         +y*(0.8449199096e-5+y*(-0.88228987e-6+y*0.105787412e-6)));
      bessj1 := sqrt(0.636619772/ax)*(cos(xx)*ans1
         -z*sin(xx)*ans2)*sign(x);
      END
END;

FUNCTION bessy0(x: real): real;
VAR xx,z: real;  y,ans1,ans2: double;
BEGIN
  bessy0 :=0;
 if x=0 then ffehler:=true else begin
   IF (x < 8.0) THEN BEGIN
      y := sqr(x);
      ans1 := -2957821389.0+y*(7062834065.0+y*(-512359803.6
         +y*(10879881.29+y*(-86327.92757+y*228.4622733))));
      ans2 := 40076544269.0+y*(745249964.8+y*(7189466.438
         +y*(47447.26470+y*(226.1030244+y))));
      bessy0 := (ans1/ans2)+0.636619772*bessj0(x)*ln(x);
      END
   ELSE BEGIN
      z := 8.0/x; y := sqr(z); xx := x-0.785398164;
      ans1 := 1.0+y*(-0.1098628627e-2+y*(0.2734510407e-4
         +y*(-0.2073370639e-5+y*0.2093887211e-6)));
      ans2 := -0.1562499995e-1+y*(0.1430488765e-3
         +y*(-0.6911147651e-5+y*(0.7621095161e-6+y*(-0.934945152e-7))));
      bessy0 := sqrt(0.636619772/x)* (sin(xx)*ans1+z*cos(xx)*ans2);
      END
END; end;

FUNCTION bessy1(x: real): real;
VAR xx,z: real;  y,ans1,ans2: double;
BEGIN
  bessy1 :=0;
  if x=0 then ffehler:=true else begin
   IF (x < 8.0) THEN BEGIN
      y := sqr(x);
      ans1 := x*(-0.4900604943e13+y*(0.1275274390e13
         +y*(-0.5153438139e11+y*(0.7349264551e9
         +y*(-0.4237922726e7+y*0.8511937935e4)))));
      ans2 := 0.2499580570e14+y*(0.4244419664e12
         +y*(0.3733650367e10+y*(0.2245904002e8
         +y*(0.1020426050e6+y*(0.3549632885e3+y)))));
      bessy1 := (ans1/ans2)+0.636619772*(bessj1(x)*ln(x)-1.0/x);
      END
   ELSE BEGIN
      z := 8.0/x; y := sqr(z); xx := x-2.356194491;
      ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4
         +y*(0.2457520174e-5+y*(-0.240337019e-6))));
      ans2 := 0.04687499995+y*(-0.2002690873e-3
         +y*(0.8449199096e-5+y*(-0.88228987e-6+y*0.105787412e-6)));
      bessy1 := sqrt(0.636619772/x)*(sin(xx)*ans1+z*cos(xx)*ans2);
      END
END; end;

FUNCTION bessj(n: integer; x: real): real;
CONST
   iacc=40;
   bigno=1.0e10;
   bigni=1.0e-10;
VAR
   bj,bjm,bjp,sum,tox,ans: real;    j,jsum,m: integer;
BEGIN
   IF (n < 2) THEN BEGIN
      ffehler:=true;  END;
   IF (x=0.0) THEN ans := 0.0
   ELSE IF (abs(x) > 1.0*n) THEN BEGIN
      tox := 2.0/abs(x);
      bjm := bessj0(abs(x));
      bj := bessj1(abs(x));
      FOR j := 1 TO n-1 DO BEGIN
         bjp := j*tox*bj-bjm;
         bjm := bj;
         bj := bjp
      END;
      ans := bj
   END ELSE BEGIN
      tox := 2.0/abs(x);
      m := 2*((n+trunc(sqrt(1.0*(iacc*n)))) DIV 2);
      ans := 0.0;
      jsum := 0;
      sum := 0.0;
      bjp := 0.0;
      bj := 1.0;
      FOR j := m DOWNTO 1 DO BEGIN
         bjm := j*tox*bj-bjp;
         bjp := bj;
         bj := bjm;
         IF (abs(bj) > bigno) THEN BEGIN
            bj := bj*bigni;
            bjp := bjp*bigni;
            ans := ans*bigni;
            sum := sum*bigni
         END;
         IF (jsum <> 0) THEN sum := sum+bj;
         jsum := 1-jsum;
         IF (j = n) THEN ans := bjp
      END;
      sum := 2.0*sum-bj;
      ans := ans/sum
   END;
   IF (x<0.0) AND ((n MOD 2)=1) THEN ans := -ans;
   bessj := ans
END;

FUNCTION bessy(n: integer; x: real): real;
VAR
   by,bym,byp,tox: real;
   j: integer;
BEGIN
  bessy :=0;
   IF (n < 2) THEN BEGIN
      bessy:=0; ffehler:=true; exit
   END;
  if x=0 then ffehler:=true else begin
   tox := 2.0/x;
   by := bessy1(x);
   bym := bessy0(x);
   FOR j := 1 TO n-1 DO BEGIN
      byp := j*tox*by-bym;
      bym := by;  by := byp
   END;
   bessy := by
END; end;

FUNCTION bessi0(x: real): real;
VAR ax: real;  y: double;
BEGIN
   IF (abs(x) < 3.75) THEN BEGIN
      y := sqr(x/3.75);
      bessi0 := 1.0+y*(3.5156229+y*(3.0899424+y*(1.2067492+y*
         (0.2659732+y*(0.360768e-1+y*0.45813e-2)))))  END
   ELSE BEGIN
      ax := abs(x);  y := 3.75/ax;
      bessi0 := (exp(ax)/sqrt(ax))*(0.39894228+y*(0.1328592e-1
         +y*(0.225319e-2+y*(-0.157565e-2+y*(0.916281e-2
         +y*(-0.2057706e-1+y*(0.2635537e-1+y*(-0.1647633e-1
         +y*0.392377e-2))))))))  END;
END;

FUNCTION bessi1(x: real): real;
VAR
   ax: real;  y,ans: double;
BEGIN
   IF (abs(x) < 3.75) THEN BEGIN
      y := sqr(x/3.75);
      ans := x*(0.5+y*(0.87890594+y*(0.51498869+y*(0.15084934
         +y*(0.2658733e-1+y*(0.301532e-2+y*0.32411e-3)))))) END
   ELSE BEGIN
      ax := abs(x); y := 3.75/ax;
      ans := 0.2282967e-1+y*(-0.2895312e-1+y*(0.1787654e-1-y*0.420059e-2));
      ans := 0.39894228+y*(-0.3988024e-1+y*(-0.362018e-2
         +y*(0.163801e-2+y*(-0.1031555e-1+y*ans))));
      ans := (exp(ax)/sqrt(ax))*ans;
      IF (x<0.0) THEN ans := -ans  END;
   bessi1 := ans
END;
FUNCTION bessk0(x: real): real;
VAR
   y,ans: double;
BEGIN
  bessk0 :=0;
 if x=0 then ffehler:=true else begin
   IF (x <= 2.0) THEN BEGIN
      y := x*x/4.0;
      ans := (-ln(x/2.0)*bessi0(x))+(-0.57721566+y*(0.42278420
         +y*(0.23069756+y*(0.3488590e-1+y*(0.262698e-2
         +y*(0.10750e-3+y*0.74e-5))))))  END
   ELSE BEGIN
      y := (2.0/x);
      ans := (exp(-x)/sqrt(x))*(1.25331414+y*(-0.7832358e-1
         +y*(0.2189568e-1+y*(-0.1062446e-1+y*(0.587872e-2
         +y*(-0.251540e-2+y*0.53208e-3))))))  END;
   bessk0 := ans
END; end;
FUNCTION bessk1(x: real): real;
VAR
   y,ans: double;
BEGIN
  bessk1 :=0;
 if x=0 then ffehler:=true else begin
   IF  (x <= 2.0)  THEN BEGIN
      y := x*x/4.0;
      ans := (ln(x/2.0)*bessi1(x))+(1.0/x)*(1.0+y*(0.15443144
         +y*(-0.67278579+y*(-0.18156897+y*(-0.1919402e-1
         +y*(-0.110404e-2+y*(-0.4686e-4)))))))  END
   ELSE BEGIN
      y := 2.0/x;
      ans := (exp(-x)/sqrt(x))*(1.25331414+y*(0.23498619
         +y*(-0.3655620e-1+y*(0.1504268e-1+y*(-0.780353e-2
         +y*(0.325614e-2+y*(-0.68245e-3)))))))  END;
   bessk1 := ans
END; end;

FUNCTION bessi(n: integer; x: real): real;
CONST
   iacc=40;
   bigno=1.0e10;
   bigni=1.0e-10;
VAR
   bi,bim,bip,tox,ans: real;
   j,m: integer;
BEGIN
   IF  (n < 2) THEN BEGIN
      ffehler:=true;
   END;
   IF (x=0.0) THEN bessi := 0.0
   ELSE BEGIN
      ans := 0.0;
      tox := 2.0/abs(x);
      bip := 0.0;
      bi := 1.0;
      m := 2*(n+trunc(sqrt(iacc*n)));
      FOR j := m DOWNTO 1 DO BEGIN
         bim := bip+j*tox*bi;
         bip := bi;
         bi := bim;
         IF (abs(bi) > bigno) THEN BEGIN
            ans := ans*bigni;
            bi := bi*bigni;
            bip := bip*bigni
         END;
         IF (j=n) THEN ans := bip
      END;
      IF (x<0.0) AND ((n MOD 2)=1) THEN ans := -ans;
      bessi := ans*bessi0(x)/bi
   END
END;

FUNCTION bessk(n: integer; x: real): real;
VAR
   tox,bkp,bkm,bk: real;
   j: integer;
BEGIN
  bessk :=0;
   IF (n < 2) THEN BEGIN
      bessk:=0; ffehler:=true; exit
   END;
 if x=0 then ffehler:=true else begin
   tox := 2.0/x;
   bkm := bessk0(x);
   bk := bessk1(x);
   FOR j := 1 TO n-1 DO BEGIN
      bkp := bkm+j*tox*bk;
      bkm := bk;
      bk := bkp
   END;
   bessk := bk
END; end;

begin
  ffehler:=false; fehler:=0; sonderfunktion:=0;
  case nr of
    2 : sonderfunktion:=gammaln(a);
    1 : begin r:=gammaln(a); if abs(r)<25 then sonderfunktion:=exp(r)
        else begin sonderfunktion:=0; ffehler:=true end;
        end;                       //2
    3 : sonderfunktion:=beta(a,b);
    4 : sonderfunktion:=bessj0(a); //4
    5 : sonderfunktion:=bessj1(a); //5
    6 : sonderfunktion:=bessy0(a);
    7 : sonderfunktion:=bessy1(a);
    8 : sonderfunktion:=bessj(round(b),a);
    9 : sonderfunktion:=bessy(round(b),a);
   10 : sonderfunktion:=bessi0(a);
   11 : sonderfunktion:=bessi1(a);
   12 : sonderfunktion:=bessk0(a);
   13 : sonderfunktion:=bessk1(a);
   14 : sonderfunktion:=bessi(round(b),a);
   15 : sonderfunktion:=bessk(round(b),a);
 end;
 if fehler<>0 then ffehler:=true;
end;

procedure Airy(x : Double;var Ai : Double; var Bi : Double);
var
    z : Double;
    zz : Double;
    t : Double;
    f : Double;
    g : Double;
    uf : Double;
    ug : Double;
    k : Double;
    zeta : Double;
    theta : Double;
    domflg : integer;
    c1 : Double;
    c2 : Double;
    sqrt3 : Double;
    sqpii : Double;
    AFN : Double;
    AFD : Double;
    AGN : Double;
    AGD : Double;
    AN : Double;
    AD : Double;
    BN16 : Double;
    BD16 : Double;
begin
    sqpii := 5.64189583547756286948E-1;
    c1 := 0.35502805388781723926;
    c2 := 0.258819403792806798405;
    sqrt3 := 1.732050807568877293527;
    domflg := 0;
    if x>25.77 then
    begin
        ai := 0;
        bi := 1E10;
        Exit;
    end;
    if x<-2.09 then
    begin
        t := sqrt(-x);
        zeta := -2.0*x*t/3.0;
        t := sqrt(t);
        k := sqpii/t;
        z := 1.0/zeta;
        zz := z*z;
        AFN := -1.31696323418331795333E-1;
        AFN := AFN*zz-6.26456544431912369773E-1;
        AFN := AFN*zz-6.93158036036933542233E-1;
        AFN := AFN*zz-2.79779981545119124951E-1;
        AFN := AFN*zz-4.91900132609500318020E-2;
        AFN := AFN*zz-4.06265923594885404393E-3;
        AFN := AFN*zz-1.59276496239262096340E-4;
        AFN := AFN*zz-2.77649108155232920844E-6;
        AFN := AFN*zz-1.67787698489114633780E-8;
        AFD := 1.00000000000000000000E0;
        AFD := AFD*zz+1.33560420706553243746E1;
        AFD := AFD*zz+3.26825032795224613948E1;
        AFD := AFD*zz+2.67367040941499554804E1;
        AFD := AFD*zz+9.18707402907259625840E0;
        AFD := AFD*zz+1.47529146771666414581E0;
        AFD := AFD*zz+1.15687173795188044134E-1;
        AFD := AFD*zz+4.40291641615211203805E-3;
        AFD := AFD*zz+7.54720348287414296618E-5;
        AFD := AFD*zz+4.51850092970580378464E-7;
        uf := 1.0+zz*AFN/AFD;
        AGN := 1.97339932091685679179E-2;
        AGN := AGN*zz+3.91103029615688277255E-1;
        AGN := AGN*zz+1.06579897599595591108E0;
        AGN := AGN*zz+9.39169229816650230044E-1;
        AGN := AGN*zz+3.51465656105547619242E-1;
        AGN := AGN*zz+6.33888919628925490927E-2;
        AGN := AGN*zz+5.85804113048388458567E-3;
        AGN := AGN*zz+2.82851600836737019778E-4;
        AGN := AGN*zz+6.98793669997260967291E-6;
        AGN := AGN*zz+8.11789239554389293311E-8;
        AGN := AGN*zz+3.41551784765923618484E-10;
        AGD := 1.00000000000000000000E0;
        AGD := AGD*zz+9.30892908077441974853E0;
        AGD := AGD*zz+1.98352928718312140417E1;
        AGD := AGD*zz+1.55646628932864612953E1;
        AGD := AGD*zz+5.47686069422975497931E0;
        AGD := AGD*zz+9.54293611618961883998E-1;
        AGD := AGD*zz+8.64580826352392193095E-2;
        AGD := AGD*zz+4.12656523824222607191E-3;
        AGD := AGD*zz+1.01259085116509135510E-4;
        AGD := AGD*zz+1.17166733214413521882E-6;
        AGD := AGD*zz+4.91834570062930015649E-9;
        ug := z*AGN/AGD;
        theta := zeta+0.25*PI;
        f := sin(theta);
        g := cos(theta);
        ai := k*(f*uf-g*ug);
        bi := k*(g*uf+f*ug);
        Exit;
    end;
    if x>2.09 then
    begin
        domflg := 5;
        t := sqrt(x);
        zeta := 2.0*x*t/3.0;
        g := exp(zeta);
        t := sqrt(t);
        k := 2.0*t*g;
        z := 1.0/zeta;
        AN := 3.46538101525629032477E-1;
        AN := AN*z+1.20075952739645805542E1;
        AN := AN*z+7.62796053615234516538E1;
        AN := AN*z+1.68089224934630576269E2;
        AN := AN*z+1.59756391350164413639E2;
        AN := AN*z+7.05360906840444183113E1;
        AN := AN*z+1.40264691163389668864E1;
        AN := AN*z+9.99999999999999995305E-1;
        AD := 5.67594532638770212846E-1;
        AD := AD*z+1.47562562584847203173E1;
        AD := AD*z+8.45138970141474626562E1;
        AD := AD*z+1.77318088145400459522E2;
        AD := AD*z+1.64234692871529701831E2;
        AD := AD*z+7.14778400825575695274E1;
        AD := AD*z+1.40959135607834029598E1;
        AD := AD*z+1.00000000000000000470E0;
        f := AN/AD;
        ai := sqpii*f/k;
        if x>8.3203353 then
        begin
            BN16 := -2.53240795869364152689E-1;
            BN16 := BN16*z+5.75285167332467384228E-1;
            BN16 := BN16*z-3.29907036873225371650E-1;
            BN16 := BN16*z+6.44404068948199951727E-2;
            BN16 := BN16*z-3.82519546641336734394E-3;
            BD16 := 1.00000000000000000000E0;
            BD16 := BD16*z-7.15685095054035237902E0;
            BD16 := BD16*z+1.06039580715664694291E1;
            BD16 := BD16*z-5.23246636471251500874E0;
            BD16 := BD16*z+9.57395864378383833152E-1;
            BD16 := BD16*z-5.50828147163549611107E-2;
            f := z*BN16/BD16;
            k := sqpii*g;
            bi := k*(1.0+f)/t;
            Exit;
        end;
    end;
    f := 1.0;
    g := x;
    t := 1.0;
    uf := 1.0;
    ug := x;
    k := 1.0;
    z := x*x*x;
    while t>5e-8 do
    begin
        uf := uf*z;
        k := k+1.0;
        uf := uf/k;
        ug := ug*z;
        k := k+1.0;
        ug := ug/k;
        uf := uf/k;
        f := f+uf;
        k := k+1.0;
        ug := ug/k;
        g := g+ug;
        t := Abs(uf/f);
    end;
    uf := c1*f;
    ug := c2*g;
    if domflg mod 2=0 then
    begin
        ai := uf-ug;
    end;
    if domflg div 2 mod 2=0 then
    begin
        bi := sqrt3*(uf+ug);
    end;
    k := 4.0;
    uf := x*x/2.0;
    ug := z/3.0;
    f := uf;
    g := 1.0+ug;
    uf := uf/3.0;
    t := 1.0;
    while t>5e-8 do
    begin
        uf := uf*z;
        ug := ug/k;
        k := k+1.0;
        ug := ug*z;
        uf := uf/k;
        f := f+uf;
        k := k+1.0;
        ug := ug/k;
        uf := uf/k;
        g := g+ug;
        k := k+1.0;
        t := Abs(ug/g);
    end;
end;

function funktionswert;
const zahlen: set of char=['0'..'9','.','é'];
  funktionen= 'SQR SQRT EXP LN ABS SI SIN COS TAN ARCCOS LG ARCTAN SINH COSH TANH INT'+
              ' SGN F1 F2 F3 F4 COT LD ARCSIN ARSINH ARCOSH ARTANH SEC GAMMA GAUSS'+
              ' MCARLO CI EI BETA BESSJ0 BESSJ1 WURZEL WURZEL3 EHOCH WURZEL4 W3 W4 LOG CSC'+
              ' WP F5 VORZEICHEN FRAC EXPP GAMMALN HEAVISIDE SINW COSW TANW COTW ARCTANW'+
              ' ARCSINW GSUMME SN CN DN EULERPHI AI BI ARCCOT ARCSEC';
type  link=^stapelelement;
      stapelelement=record re:real; ch:char; by:byte; next:link end;

var zwischenwert,ergeb: real;
    zeiger,len,i : integer;
    operator,folgeoperator: char;
    prioritaet,folgeprioritaet: byte;
    stapel: link;

procedure push(wert:real; zeichen:char; priori:byte);
var p:link;
begin new(p); p^.re:=wert; p^.ch:=zeichen; p^.by:=priori;
      p^.next:=stapel; stapel:=p
end;
procedure pop(var wert:real; var zeichen:char; var priori:byte);
var p:link;
begin p:=stapel; stapel:=p^.next; wert:=p^.re;
      zeichen:=p^.ch; priori:=p^.by; dispose(p)
end;

function gesamtkette:real; forward;
function teilkette(zwischenwert:real):real; forward;

function zahl:real;
var z:real; c:integer;
begin i:=zeiger+1; while term[i] in zahlen do inc(i);
 val(copy(term,zeiger,i-zeiger),z,c);
 zahl:=z; zeiger:=i
end;

function funktionscode:integer;
var p:integer;
begin i:=zeiger; repeat inc(i) until (term[i]='(') or (i>len);
 p:=pos(copy(term,zeiger,i-zeiger),funktionen);
 if p=0 then {ungueltiger Funktionsaufruf} fehler:=1;
 funktionscode:=p; zeiger:=i+1;
end;

function funktion:real;
var a,b,sn,cn,dn:real; ffehler:boolean;
    ai,Bi : Double;
function gamma(a:real):real;
var i:integer; gam:array[0..7] of real; cc,gg:real;
begin
   gam[0]:=1; gam[1]:=-0.577191652; gam[2]:=0.988205891;
   gam[3]:=-0.897056937; gam[4]:=0.918206857; gam[5]:=-0.756704078;
   gam[6]:=0.482199394; gam[7]:=-0.193527818;
 if ((a<=0) and (a=int(a))) or (a>43) then begin gamma:=0; fehler:=4 end
   else begin
  cc:=1; while a>2 do begin a:=a-1; cc:=cc*a end;
  while a<1 do begin cc:=cc/a; a:=a+1 end;
  a:=a-1; gg:=0.035868343;
  for i:=7 downto 0 do gg:=gg*a+gam[i];
  gamma:=cc*gg;
    end;
end;
function intsin(x:real):real;
var j:integer; f,y,s,sold:real;
begin
if (x>0) and (x<50) then begin
   s:=x; j:=1; f:=ln(x);
   repeat
     f:=f+2*ln(x)+ln(j)-ln(j+1)-2*ln(j+2);
     y:=exp(f); sold:=s;
     if odd((j-1) div 2) then s:=s+y else s:=s-y;
     inc(j,2);
    until abs(s-sold)<0.0001;
  intsin:=s end else begin fehler:=2; intsin:=0; end;
end;
function intcos(x:real):real;
var j:integer; f,y,s,sold:real;
begin
if (x>0) and (x<50) then begin
  s:=ln(x)+0.57722-sqr(x)/4; j:=2; f:=2*ln(x/2);
 repeat
  f:=f+2*ln(x)+ln(j)-ln(j+1)-2*ln(j+2);
  y:=exp(f); sold:=s;
  if odd(j div 2) then s:=s+y else s:=s-y;
  inc(j,2);
 until abs(s-sold)<0.0001;
  intcos:=s; end else begin fehler:=2; intcos:=0; end;
end;
function eulerphi(zz:real):real;
var z,anz,i:integer;
function ggt(faktor,rest:integer):integer;
var r,s,t:longint;
begin
 if faktor*rest<>0 then begin
     s:=faktor; t:=rest;
     if s<t then begin r:=s; s:=t; t:=r end;
     repeat
        r:=s mod t; s:=t; t:=r;
     until r=0; ggt:=s;
     end else ggt:=1;
end;
begin
   z:=round(zz);
   if (z<1) or (z>10000) then begin fehler:=1; eulerphi:=0; exit end;
   anz:=0;
   i:=1;
   repeat
     if ggt(i,z)=1 then inc(anz);
    inc(i);
   until (i>=z) or (anz>32000);
   if anz>32000 then begin fehler:=1; eulerphi:=0; end else eulerphi:=anz;
end;
function intexp(x:real):real;
var j:integer; f,s,sold:real;
begin
if (x>0) and (x<40) then begin
  s:=x+ln(x)+0.57722156649+sqr(x)/4; j:=2; f:=2*ln(x/2);
 repeat
  f:=f+ln(x)+ln(j)-2*ln(j+1);
  sold:=s; s:=s+exp(f); inc(j);
 until abs(s-sold)<0.0001;
  intexp:=s; end else begin fehler:=2; intexp:=0; end;
end;
PROCEDURE sncndn(uu,emmc: real; VAR sn,cn,dn: real);
LABEL 1;
CONST
   ca=0.0003;
VAR
   a,b,c,d,emc,u: real;
   i,ii,l: integer;
   bo: boolean;
   em,en: ARRAY [1..13] OF real;
BEGIN
   emc := emmc;
   d:=1;
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
    funktion:=0;
 case funktionscode of
 302 : begin a:=gesamtkette; sncndn(a,1-q*q,sn,cn,dn); funktion:=sn end;
 305 : begin a:=gesamtkette; sncndn(a,1-q*q,sn,cn,dn); funktion:=cn end;
 308 : begin a:=gesamtkette; sncndn(a,1-q*q,sn,cn,dn); funktion:=dn end;
 326 : begin a:=gesamtkette; if abs(a)>1E-10 then funktion:=arctan(1.0/a)
             else funktion:=Pi/2-arctan(x);
       end;
 333 : begin a:=gesamtkette;
         if abs(a)>=1 then begin
           b:=arctan(sqrt((a-1.0)*(a+1.0)));
           if a>0.0 then funktion:=b else funktion:=Pi-b;
         end else
         begin funktion:=0; fehler:=2 end
       end;
 231 : begin a:=gesamtkette; if abs(a)<1e10 then funktion:=frac(a) else begin fehler:=2; funktion:=0 end end;
 236 : begin a:=gesamtkette; if p<0 then begin funktion:=0; fehler:=2 end
             else begin
              if a*ln(p)<50 then funktion:=exp(a*ln(p)) else begin funktion:=0; fehler:=2 end
             end;
       end;
  1: begin a:=gesamtkette;
           if a=0 then funktion:=0 else
           if abs(a)<ueberlauf then funktion:=sqr(1.0*a)
                          else begin funktion:=1e10; fehler:=2 end end;
  5,171: begin a:=gesamtkette; if a>=0 then funktion:=sqrt(a)
       else begin funktion:=0; fehler:=2; end; {Radikand kleiner 0} end;
  178,200: begin a:=gesamtkette;
           if a>0 then funktion:=exp(ln(a)/3);
           if a=0 then funktion:=0;
           if a<0 then funktion:=-exp(ln(-a)/3);
        end;
  192,203: begin a:=gesamtkette;
           if a>0 then funktion:=exp(ln(a)/4);
           if a=0 then funktion:=0;
           if a<0 then begin funktion:=0; fehler:=2 end;
        end;
  10,186: begin a:=gesamtkette; if a>50 then begin a:=50; fehler:=4 end;
                            if a<-50 then begin a:=-50; fehler:=4 end;
       funktion:=exp(a); end;
  14: begin a:=gesamtkette; if a>0 then funktion:=ln(a)
       else begin funktion:=0; fehler:=2; end; {LN(A<=0) nicht erlaubt} end;
  17: funktion:=abs(gesamtkette);
  21: funktion:=intsin(gesamtkette);
  24: funktion:=sin(gesamtkette);
 259: funktion:=sin(gesamtkette*pi/180);
  28: funktion:=cos(gesamtkette);
 264: funktion:=cos(gesamtkette*pi/180);
  32: begin a:=gesamtkette; if cos(a)<>0 then funktion:=tan(a); end;
 269: begin a:=gesamtkette*pi/180; if cos(a)<>0 then funktion:=tan(a); end;
  88: begin a:=gesamtkette;  if sin(a)<>0 then funktion:=cos(a)/sin(a) end;
 274: begin a:=gesamtkette*pi/180;  if sin(a)<>0 then funktion:=cos(a)/sin(a) end;
 295: begin a:=gesamtkette;
         b:=1/2*SQRT(1-1/30*(7*EXP(-a*a/2)+16*EXP(-a*a*(2-SQRT(2)))+(7+1/4*PI*a*a)*EXP(-a*a)));
         if a<0 then funktion:=0.5-b;
         if a=0 then funktion:=0.5;
         if a>0 then funktion:=0.5+b;
      end;
  36: begin a:=gesamtkette; if abs(a)<=1 then
            funktion:=arccos(a)
            else begin funktion:=0; fehler:=2 end;
       end;
  43: begin a:=gesamtkette; if a>0 then funktion:=0.4342944819033*ln(a) {funktion:=log10(a)}
       else begin funktion:=0; fehler:=2; end;{LG(A<=0) nicht erlaubt} end;
 206: begin a:=gesamtkette; if (a>0) and (p>0) and (p<>1) then funktion:=ln(a)/ln(p)
       else begin funktion:=0; fehler:=2; end;{LG(A<=0) nicht erlaubt} end;
  46: funktion:=arctan(gesamtkette);
 279: begin a:=arctan(gesamtkette); if a<0 then a:=a+pi; funktion:=a; end;
  53: begin a:=gesamtkette;
            if abs(a)<50 then funktion:=sinh(a)//}(exp(a)-exp(-a))/2
                           else begin funktion:=1e10; fehler:=2 end
            end;
  58: begin a:=gesamtkette;
            if abs(a)<50 then funktion:=cosh(a)//}(exp(a)+exp(-a))/2
                           else begin funktion:=1e10; fehler:=2 end
            end;
  63: begin a:=gesamtkette;
            if abs(a)<50 then funktion:=tanh(a)//}1-exp(-a)/(exp(a)+exp(-a))*2
                           else begin funktion:=1e10; fehler:=1 end
            end;
  68: begin a:=gesamtkette; if a>=0 then funktion:=int(a) else funktion:=int(a-1);
            fehler:=3 end;
  72,220: begin a:=gesamtkette; fehler:=0;
            if a=0 then funktion:=0 else funktion:=a/abs(a) end;
  76: funktion:=funktionswert(f[1],gesamtkette);
  79: funktion:=funktionswert(f[2],gesamtkette);
  82: funktion:=funktionswert(f[3],gesamtkette);
  85: funktion:=funktionswert(f[4],gesamtkette);
  92: begin a:=gesamtkette; if a>0 then funktion:={logn(2,a)}1.442695040889*ln(a)
       else begin funktion:=0; fehler:=2; end;{LG(A<=0) nicht erlaubt} end;
  95: begin a:=gesamtkette;
            if abs(a)<1 then funktion:=arcsin(a)//}arctan(a/sqrt(1-a*a))
             else if a=1 then funktion:=pi/2
             else if a=-1 then funktion:=-pi/2
                  else begin funktion:=0; fehler:=2 end;
       end;
 287: begin a:=gesamtkette;
            if abs(a)<1 then begin b:={arcsin(a)}arctan(a/sqrt(1-a*a));
               if b<0 then b:=pi/2-b; funktion:=b;
              end
             else if a=1 then funktion:=pi/2
             else if a=-1 then funktion:=pi/2
                  else begin funktion:=0; fehler:=2 end;
       end;
 102: begin a:=gesamtkette; funktion:=ln(a+sqrt(sqr(a)+1)) end;
 109: begin a:=gesamtkette; if a>=1 then funktion:={arccosh(a)}ln(a+sqrt(sqr(a)-1))
            else begin funktion:=0; fehler:=2 end;
       end;
 116: begin a:=gesamtkette; if abs(a)<1 then funktion:={arctanh(a)}ln((1+a)/(1-a))/2
            else begin funktion:=0; fehler:=2 end;
       end;
 123: begin a:=gesamtkette; if cos(a)<>0 then funktion:={sec(a)}1/cos(a)
            else begin funktion:=0; fehler:=2 end;
       end;
 210: begin a:=gesamtkette; if sin(a)<>0 then funktion:=1/sin(a)
            else begin funktion:=0; fehler:=2 end;
       end;
 214: begin a:=gesamtkette;
         if (a>0) and (p<>0) then begin
           if abs(ln(a)/p)<50 then funktion:=exp(ln(a)/p)
            else begin funktion:=0; fehler:=2 end;
            end
            else begin funktion:=0; fehler:=2 end;
       end;
 127: funktion:=gamma(gesamtkette);
 133: begin a:=gesamtkette; if a>50 then begin a:=50; fehler:=4 end;
                            if a<-50 then begin a:=-50; fehler:=4 end;
      funktion:=exp(-sqr(a)/2)/2.506628274631; end;
 139: begin a:=gesamtkette;
          if a=0 then funktion:=random else funktion:=random(trunc(a)) end;
 311: funktion:=eulerphi(gesamtkette);
 320: begin a:=gesamtkette; airy(a,Ai,Bi); funktion:=ai; end;
 323: begin a:=gesamtkette; airy(a,Ai,Bi); funktion:=bi; end;
 146: funktion:=intcos(gesamtkette);
 149: funktion:=intexp(gesamtkette);
 152: begin a:=gesamtkette; b:=gamma(a+p);
        if b<>0 then funktion:=gamma(a)*gamma(p)/b
                else begin funktion:=0; fehler:=4 end end;
 157 : begin ffehler:=false;
      funktion:=sonderfunktion(4,gesamtkette,0,ffehler);
      if ffehler then fehler:=4 end;
 164 : begin ffehler:=false;
      funktion:=sonderfunktion(5,gesamtkette,0,ffehler);
      if ffehler then fehler:=4 end;
 241 : begin ffehler:=false; {gammaln}
      funktion:=sonderfunktion(2,gesamtkette,0,ffehler);
      if ffehler then fehler:=4 end;
 249 : begin ffehler:=false; {heaviside} a:=gesamtkette; fehler:=3;
      if a=0 then funktion:=1/2 else funktion:=(abs(a)/a+1)/2;
      end;
 217: funktion:=funktionswert(f[5],gesamtkette);
   else begin fehler:=1; funktion:=0 end; {ungueltiger Funktionsaufruf}
 end
end;

function wert:real;
var knr:integer; code:integer; a:real;
begin
 case term[zeiger] of
  'A'..'J','L'..'O','S'..'T','V','W': wert:=funktion;
  '0'..'9','.': wert:=zahl;
  'É': begin wert:=exp(1); inc(zeiger) end;
  'X': begin wert:=x; inc(zeiger) end;
  'Q': begin wert:=q; inc(zeiger) end;
  'R': begin wert:=r; inc(zeiger) end;
  'K': begin val(term[zeiger+1],knr,code);
         case knr of
            1..5 : wert:=o_[knr];
         else wert:=0;
         end;
       inc(zeiger,2) end;
  'P': if length(term)=zeiger
         then begin wert:=p; inc(zeiger) end
         else begin
              if (term[zeiger+1]='I')
                 then begin wert:=pi; inc(zeiger,2) end
                 else begin
                    if (term[zeiger+1]='H') and (term[zeiger+2]='I') then
                         begin wert:=(sqrt(5)+1)/2; inc(zeiger,3) end
                         else begin wert:=p; inc(zeiger) end;
                 end;
         end;
  '(' : begin inc(zeiger); wert:=gesamtkette end;
  '|' : begin inc(zeiger); wert:=abs(gesamtkette) end;
  '[' : begin inc(zeiger); a:=gesamtkette;
        if a>=0 then wert:=int(a) else wert:=int(a-1); end
  else begin fehler:=1; wert:=0 end;
 end
end;

procedure symbol(var z:char; var p:byte);
begin
 if zeiger<len then begin z:=term[zeiger]; inc(zeiger);
    case z of '+','-','<','>','&','#': p:=1;
              '*','·','/','~','%': p:=2;
              '^','\'    : p:=3;
              ')',']','|': p:=0
    else begin fehler:=1; p:=0 end
  end end else p:=0
end;

function operand:real;
var op:real;
begin
 if term[zeiger]='-' then begin inc(zeiger); op:=-wert end
                     else op:=wert;
 symbol(folgeoperator,folgeprioritaet);
 while folgeprioritaet>prioritaet do op:=teilkette(op);
 operand:=op
end;

FUNCTION x_hoch_y (x, y: REAL): REAL;
VAR ganz_y: INTEGER;
BEGIN
  IF (x <> 0.0) OR (y <> 0.0) THEN
    IF x > 0.0 THEN
    if abs(y*ln(abs(x))) > 16.0 THEN begin x_hoch_y:=0; fehler:=2 end
     else  x_hoch_y := Exp(y * Ln(x))
    ELSE
      BEGIN
        ganz_y := Trunc(y);
        IF ABS(y) > ABS(ganz_y) THEN begin x_hoch_y:=0; fehler:=2 end
        ELSE
          IF x <> 0.0 THEN
            IF (ganz_y MOD 2) = 0 THEN
              if abs(y*ln(abs(x))) > 15.0 THEN begin x_hoch_y:=0; fehler:=2 end
              else x_hoch_y :=  Exp(Ln(ABS(x)) * y)
            ELSE
             if abs(y*ln(abs(x))) > 15.0 THEN begin x_hoch_y:=0; fehler:=2 end
             else x_hoch_y := -Exp(Ln(ABS(x)) * y)       (* ungerader Exponent *)
          ELSE
            x_hoch_y := 0
      END
  ELSE
    x_hoch_y := 1.0
END;

function ergebnis(a,b:real; z:char):real;
var za:integer; zw:real;
begin
        ergebnis:=0;
 case z of
   '+': ergebnis:=a+b;
   '-': ergebnis:=a-b;
   '>': if a>b then ergebnis:=a else ergebnis:=b;
   '<': if a>b then ergebnis:=b else ergebnis:=a;
   '&': ergebnis:=(a+b)/2;
   '#': if a*b<0 then begin ergebnis:=0; fehler:=2 end else
           ergebnis:=sqrt(a*b);
   '*','·': if (abs(a)<ueberlauf) and (abs(b)<ueberlauf) then ergebnis:=a*b
        else begin ergebnis:=1e10; fehler:=2 end;
   '~': begin zw:=1;
        repeat
          if b<>0 then zw:=zw*a/b else fehler:=2;
          if zw>ueberlauf then fehler:=2;
          a:=a-1; b:=b-1;
        until (b<=0) or (fehler>0);
        if fehler=0 then ergebnis:=zw else ergebnis:=1e10;
        end;
   '/': if b<>0 then ergebnis:=a/b else begin ergebnis:=1e10; fehler:=2 end;
   '%': if b<>0 then ergebnis:=round(a) mod round(b) else begin ergebnis:=1e10; fehler:=2 end;
   '^': begin
        if fehler>1 then begin ergebnis:=0; fehler:=2 end
           else if b=0 then ergebnis:=1
           else if b=1 then ergebnis:=a
           else if b=2 then ergebnis:=sqr(a)
           else if b=3 then ergebnis:=sqr(a)*a
           else if b=4 then ergebnis:=sqr(sqr(a))
           else
        if (b>4) and (abs(b)<maxint) and (frac(b)=0) then begin zw:=a; za:=2;
                        repeat zw:=zw*a; if zw>ueberlauf then fehler:=4;
                               inc(za);
                        until (za>trunc(b)) or (fehler=4);
                                 if fehler<>4 then ergebnis:=zw else ergebnis:=ueberlauf; end
               else
        if a=0 then begin
                 ergebnis:=0
                 end else
                 if (abs(ln(abs(a))*b)>16) then begin ergebnis:=0; fehler:=2 end else begin
        if a<0 then ergebnis:=x_hoch_y(a,b) else ergebnis:=exp(ln(a)*b) end;
        end;
   '\': begin
        if b=0 then begin ergebnis:=0; fehler:=2 end else
        begin
        b:=1/b;
        if fehler>1 then begin ergebnis:=0; fehler:=2 end
           else if b=0 then ergebnis:=1
           else if b=1 then ergebnis:=a
           else if b=2 then ergebnis:=sqr(a)
           else if b=3 then ergebnis:=sqr(a)*a
           else if b=4 then ergebnis:=sqr(sqr(a))
           else
        if (b>4) and (abs(b)<maxint) and (frac(b)=0) then begin zw:=a; za:=2;
                        repeat zw:=zw*a; if zw>ueberlauf then fehler:=4;
                               inc(za);
                        until (za>trunc(b)) or (fehler=4);
                                 if fehler<>4 then ergebnis:=zw else ergebnis:=ueberlauf; end
               else
          if a=0 then ergebnis:=0 else
                 if (abs(ln(abs(a))*b)>15) then begin ergebnis:=0; fehler:=2 end else begin
        if a<0 then ergebnis:=x_hoch_y(a,b) else ergebnis:=exp(ln(a)*b) end;
        end
        end
 end
end;

function teilkette;
var op1,op2: real;
begin
 push(op1,operator,prioritaet);
 repeat op1:=zwischenwert;
  operator:=folgeoperator; prioritaet:=folgeprioritaet;
  op2:=operand; zwischenwert:=ergebnis(op1,op2,operator)
 until folgeprioritaet<prioritaet;
 teilkette:=zwischenwert; pop(op1,operator,prioritaet)
end;

function gesamtkette;
begin
 zwischenwert:=operand; while folgeprioritaet>0 do
   zwischenwert:=teilkette(zwischenwert);
 gesamtkette:=zwischenwert
end;

begin
if (not absolutegesetzt) or ((x>=absolutea) and (x<=absoluteb))
   then begin
if term<>'' then begin
 while pos(',',term)<>0 do term[pos(',',term)]:='.';
 while (pos(' ',term)<>0) and (length(Term)>1) do delete(term,pos(' ',term),1);
 if term[1]='-' then term:='0'+term;
 if term[1]='+' then term:='0'+term;

 while pos('(-X^',term)<>0 do term:=copy(term,1,pos('(-X^',term))
             +'0'+copy(term,pos('(-X^',term)+1,255);
 fehler:=0; zeiger:=1; len:=length(term); stapel:=nil;
 ergeb:=gesamtkette;
 if ergeb>ueberlauf then begin funktionswert:=ueberlauf; fehler:=4 end else funktionswert:=ergeb;
    end else begin funktionswert:=0; fehler:=1 end;
    end else begin funktionswert:=0;
        if x<absolutea then fehler:=1 else fehler:=3 end;
end;

begin
   f[1]:='';
   f[2]:='';
   f[3]:='';
   f[4]:='';
   f[5]:='';
end.
