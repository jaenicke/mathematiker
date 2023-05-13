unit fktint;

{$DEFINE FLOGG}

interface

type
    gfeld=array[0..25,0..25] of double;
const
    absolutea : double = -1e6;
    absoluteb : double = 1e6;
    absolutegesetzt : boolean = false;
    absoluteauto    : boolean = true;
var
    fehler,mfehler    : byte;
    q,p,r,deltas : double;
    o_           : array[1..5] of double;
    f            : array[1..10] of string;
{$IFDEF FLOGG}
    function  funktionswertl(term:string; x:double;nr:byte):double;
{$ENDIF}
    function  funktionswert(term:string; x:double):double;
    FUNCTION zbrent(x1,x2,tol: double;nr:byte;itmax:integer): double;
    procedure gaussv(var ko:gfeld;grad:integer;var det:double;var fehler:boolean);
    function sonderfunktion(nr:byte;a,b:double;var ffehler:boolean):double;
    procedure zetafunktion(t: extended; var re,im: extended);

implementation

uses math, sonderfunktionen;

const ueberlauf:double=1e10;

function PolEvalX(x: extended; const a: array of extended; n: integer): extended;
var
  i: integer;
  s: extended;
begin
  if n<=0 then begin
    PolEvalX := 0.0;
    exit;
  end;
  s := a[n-1];
  for i:=n-2 downto 0 do s := s*x + a[i];
  PolEvalX := s;
end;

function cterm(n: integer; z: extended): extended;
const
   n0=22;
   c0: array[0..n0-1] of extended = (
          +0.38268343236508977173,
          +0.43724046807752044936,
          +0.13237657548034352332,
          -0.01360502604767418865,
          -0.01356762197010358089,
          -0.00162372532314446528,
          +0.00029705353733379691,
          +0.00007943300879521470,
          +0.00000046556124614505,
          -0.00000143272516309551,
          -0.00000010354847112313,
          +0.00000001235792708386,
          +0.00000000178810838580,
          -0.00000000003391414390,
          -0.00000000001632663390,
          -0.00000000000037851093,
          +0.00000000000009327423,
          +0.00000000000000522184,
          -0.00000000000000033507,
          -0.00000000000000003412,
          +0.00000000000000000058,
          +0.00000000000000000015);
   n1=23;
   c1: array[0..n1-1] of extended = (
           -0.02682510262837534703,
           +0.01378477342635185305,
           +0.03849125048223508223,
           +0.00987106629906207647,
           -0.00331075976085840433,
           -0.00146478085779541508,
           -0.00001320794062487696,
           +0.00005922748701847141,
           +0.00000598024258537345,
           -0.00000096413224561698,
           -0.00000018334733722714,
           +0.00000000446708756272,
           +0.00000000270963508218,
           +0.00000000007785288654,
           -0.00000000002343762601,
           -0.00000000000158301728,
           +0.00000000000012119942,
           +0.00000000000001458378,
           -0.00000000000000028786,
           -0.00000000000000008663,
           -0.00000000000000000084,
           +0.00000000000000000036,
           +0.00000000000000000001);
   n2=24;
   c2: array[0..n2-1] of extended = (
           +0.00518854283029316849,
           +0.00030946583880634746,
           -0.01133594107822937338,
           +0.00223304574195814477,
           +0.00519663740886233021,
           +0.00034399144076208337,
           -0.00059106484274705828,
           -0.00010229972547935857,
           +0.00002088839221699276,
           +0.00000592766549309654,
           -0.00000016423838362436,
           -0.00000015161199700941,
           -0.00000000590780369821,
           +0.00000000209115148595,
           +0.00000000017815649583,
           -0.00000000001616407246,
           -0.00000000000238069625,
           +0.00000000000005398265,
           +0.00000000000001975014,
           +0.00000000000000023333,
           -0.00000000000000011188,
           -0.00000000000000000416,
           +0.00000000000000000044,
           +0.00000000000000000003);
   n3=24;
   c3: array[0..n3-1] of extended = (
           -0.00133971609071945690,
           +0.00374421513637939370,
           -0.00133031789193214681,
           -0.00226546607654717871,
           +0.00095484999985067304,
           +0.00060100384589636039,
           -0.00010128858286776622,
           -0.00006865733449299826,
           +0.00000059853667915386,
           +0.00000333165985123995,
           +0.00000021919289102435,
           -0.00000007890884245681,
           -0.00000000941468508130,
           +0.00000000095701162109,
           +0.00000000018763137453,
           -0.00000000000443783768,
           -0.00000000000224267385,
           -0.00000000000003627687,
           +0.00000000000001763981,
           +0.00000000000000079608,
           -0.00000000000000009420,
           -0.00000000000000000713,
           +0.00000000000000000033,
           +0.00000000000000000004);
   n4=25;
   c4: array[0..n4-1] of extended = (
           +0.00046483389361763382,
           -0.00100566073653404708,
           +0.00024044856573725793,
           +0.00102830861497023219,
           -0.00076578610717556442,
           -0.00020365286803084818,
           +0.00023212290491068728,
           +0.00003260214424386520,
           -0.00002557906251794953,
           -0.00000410746443891574,
           +0.00000117811136403713,
           +0.00000024456561422485,
           -0.00000002391582476734,
           -0.00000000750521420704,
           +0.00000000013312279416,
           +0.00000000013440626754,
           +0.00000000000351377004,
           -0.00000000000151915445,
           -0.00000000000008915418,
           +0.00000000000001119589,
           +0.00000000000000105160,
           -0.00000000000000005179,
           -0.00000000000000000807,
           +0.00000000000000000011,
           +0.00000000000000000004);
var
  q: extended;
begin
  q := sqr(z);
  case n of
    0: cterm :=   PolEvalX(q,c0,n0);
    1: cterm := z*PolEvalX(q,c1,n1);
    2: cterm :=   PolEvalX(q,c2,n2);
    3: cterm := z*PolEvalX(q,c3,n3);
  else cterm :=   PolEvalX(q,c4,n4);
  end;
end;

function theta(t:extended):extended;
  {-Riemann-Siegel-Theta}
var
  x,s: extended;
const
  c0 = 1.0/48.0;
  c1 = 7.0/5760.0;
  c2 = 31.0/80640.0;
  c3 = 127.0/430080.0;
begin
  x := 1.0/sqr(t);
  s := (((c3*x + c2)*x + c1)*x + c0)/t;
  theta := 0.5*t*(ln(t/(2*Pi)) - 1.0) - Pi/8 + s;
end;

{---------------------------------------------------------------------------}
procedure zetafunktion(t: extended; var re,im: extended);
  {-Berechne  re + i*im = Zeta(1/2 + i*t) mit Riemann-Siegel}
const
  m=2;  {Max. Ordnung der Korrekturterme, muß <= 4 sein}
var
  i,n: longint;
  axx,axy: extended;
  q,y,p,s,r,tt:extended;
begin
  q  := sqrt(t/(2*Pi));
  n  := trunc(q);
  {s = Summe cos-Terme}
  s  := 0.0;
  tt := theta(t);
  for i:=1 to n do begin
    s := s + 1/sqrt(i)*cos(tt - t*ln(i));
  end;
  s :=2*s;
  {r := Summe Rest-Terme}
  y := 1.0;
  r := 0.0;
  p := 2.0*(q-n) - 1.0;
  for i:=0 to m do begin
    r := r + cterm(i,p)*y;
    y := y/q;
  end;
  r := r/sqrt(q);
  if odd(n+1) then r := -r;
  sincos(-tt, axy, axx);
  re := (s + r)*axx;
  im := (s + r)*axy;
end;

function sonderfunktion(nr:byte;a,b:double;var ffehler:boolean):double;
var r:double;

  FUNCTION gammaln(xx: double): double;
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
    if (tmp<=0) or (tmp>25) then begin
      ffehler:=true;
      exit
    end;
    tmp := (x+0.5)*ln(tmp)-tmp;
    ser := 1.0;
    FOR j := 1 TO 6 DO BEGIN
      x := x+1.0;
      if x=0 then begin
        ffehler:=true;
        exit
      end;
      ser := ser+cof[j]/x
    END;
    if stp*ser<=0 then begin
      ffehler:=true;
      exit
    end;
    gammaln := tmp+ln(stp*ser)
  END;

  FUNCTION beta(z,w: double): double;
  BEGIN
    z := gammaln(z)+gammaln(w)-gammaln(z+w);
    if abs(z)<50 then beta := exp(z)
    else begin
      ffehler:=true;
      beta:=0
    end;
  END;

  FUNCTION bessj0(x: double): double;
  VAR
    ax,xx,z: double;
    y,ans1,ans2: double;
  BEGIN
    IF (abs(x) < 8.0) THEN BEGIN
      y := sqr(x);
      ans1 := 57568490574.0+y*(-13362590354.0+y*(651619640.7
          +y*(-11214424.18+y*(77392.33017+y*(-184.9052456)))));
      ans2 := 57568490411.0+y*(1029532985.0+y*(9494680.718
          +y*(59272.64853+y*(267.8532712+y))));
      bessj0 := ans1/ans2
    END ELSE BEGIN
      ax := abs(x);
      z := 8.0/ax;
      y := sqr(z);
      xx := ax-0.785398164;
      ans1 := 1.0+y*(-0.1098628627e-2+y*(0.2734510407e-4
          +y*(-0.2073370639e-5+y*0.2093887211e-6)));
      ans2 := -0.1562499995e-1+y*(0.1430488765e-3
          +y*(-0.6911147651e-5+y*(0.7621095161e-6
          -y*0.934945152e-7)));
      bessj0 := sqrt(0.636619772/ax)*(cos(xx)*ans1-z*sin(xx)*ans2);
    END
  END;

  FUNCTION bessj1(x: double): double;
  VAR  ax,xx,z: double;
       y,ans1,ans2: double;
    FUNCTION sign(x: double): double;
    BEGIN
      IF x >= 0.0 THEN sign := 1.0
                  ELSE sign := -1.0;
    END;
  BEGIN
    IF (abs(x) < 8.0) THEN BEGIN
      y := sqr(x);
      ans1 := x*(72362614232.0+y*(-7895059235.0+y*(242396853.1
         +y*(-2972611.439+y*(15704.48260+y*(-30.16036606))))));
      ans2 := 144725228442.0+y*(2300535178.0+y*(18583304.74
         +y*(99447.43394+y*(376.9991397+y))));
      bessj1 := ans1/ans2
    END ELSE BEGIN
      ax := abs(x);
      z := 8.0/ax;
      y := sqr(z);
      xx := ax-2.356194491;
      ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4
         +y*(0.2457520174e-5+y*(-0.240337019e-6))));
      ans2 := 0.04687499995+y*(-0.2002690873e-3
         +y*(0.8449199096e-5+y*(-0.88228987e-6+y*0.105787412e-6)));
      bessj1 := sqrt(0.636619772/ax)*(cos(xx)*ans1
         -z*sin(xx)*ans2)*sign(x);
    END
  END;

  FUNCTION bessy0(x: double): double;
  VAR xx,z: double;
      y,ans1,ans2: double;
  BEGIN
    bessy0 :=0;
    if x=0 then ffehler:=true
    else
    begin
      IF (x < 8.0) THEN BEGIN
        y := sqr(x);
        ans1 := -2957821389.0+y*(7062834065.0+y*(-512359803.6
           +y*(10879881.29+y*(-86327.92757+y*228.4622733))));
        ans2 := 40076544269.0+y*(745249964.8+y*(7189466.438
           +y*(47447.26470+y*(226.1030244+y))));
        bessy0 := (ans1/ans2)+0.636619772*bessj0(x)*ln(x);
      END ELSE BEGIN
        z := 8.0/x;
        y := sqr(z);
        xx := x-0.785398164;
        ans1 := 1.0+y*(-0.1098628627e-2+y*(0.2734510407e-4
           +y*(-0.2073370639e-5+y*0.2093887211e-6)));
        ans2 := -0.1562499995e-1+y*(0.1430488765e-3
           +y*(-0.6911147651e-5+y*(0.7621095161e-6+y*(-0.934945152e-7))));
        bessy0 := sqrt(0.636619772/x)* (sin(xx)*ans1+z*cos(xx)*ans2);
      END
    END;
  end;

  FUNCTION bessy1(x: double): double;
  VAR xx,z: double;
      y,ans1,ans2: double;
  BEGIN
    bessy1 :=0;
    if x=0 then ffehler:=true
    else begin
      IF (x < 8.0) THEN BEGIN
        y := sqr(x);
        ans1 := x*(-0.4900604943e13+y*(0.1275274390e13
           +y*(-0.5153438139e11+y*(0.7349264551e9
           +y*(-0.4237922726e7+y*0.8511937935e4)))));
        ans2 := 0.2499580570e14+y*(0.4244419664e12
           +y*(0.3733650367e10+y*(0.2245904002e8
           +y*(0.1020426050e6+y*(0.3549632885e3+y)))));
        bessy1 := (ans1/ans2)+0.636619772*(bessj1(x)*ln(x)-1.0/x);
      END ELSE BEGIN
        z := 8.0/x;
        y := sqr(z);
        xx := x-2.356194491;
        ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4
           +y*(0.2457520174e-5+y*(-0.240337019e-6))));
        ans2 := 0.04687499995+y*(-0.2002690873e-3
           +y*(0.8449199096e-5+y*(-0.88228987e-6+y*0.105787412e-6)));
        bessy1 := sqrt(0.636619772/x)*(sin(xx)*ans1+z*cos(xx)*ans2);
      END
    END;
  end;

  FUNCTION bessj(n: integer; x: double): double;
  CONST
    iacc=40;
    bigno=1.0e10;
    bigni=1.0e-10;
  VAR
     bj,bjm,bjp,sum,tox,ans: double;    j,jsum,m: integer;
  BEGIN
    IF (n < 2) THEN BEGIN
      ffehler:=true;
    END;
    IF (x=0.0) THEN ans := 0.0
    ELSE
      IF (abs(x) > 1.0*n) THEN BEGIN
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

  FUNCTION bessy(n: integer; x: double): double;
  VAR
     by,bym,byp,tox: double;
     j: integer;
  BEGIN
    bessy :=0;
    IF (n < 2) THEN BEGIN
      bessy:=0;
      ffehler:=true;
      exit
    END;
    if x=0 then ffehler:=true
    else begin
      tox := 2.0/x;
      by := bessy1(x);
      bym := bessy0(x);
      FOR j := 1 TO n-1 DO BEGIN
        byp := j*tox*by-bym;
        bym := by;
        by := byp
      END;
      bessy := by
    END;
  end;

  FUNCTION bessi0(x: double): double;
  VAR ax: double;
      y: double;
  BEGIN
    IF (abs(x) < 3.75) THEN BEGIN
      y := sqr(x/3.75);
      bessi0 := 1.0+y*(3.5156229+y*(3.0899424+y*(1.2067492+y*
         (0.2659732+y*(0.360768e-1+y*0.45813e-2)))))
    END ELSE BEGIN
      ax := abs(x);
      y := 3.75/ax;
      bessi0 := (exp(ax)/sqrt(ax))*(0.39894228+y*(0.1328592e-1
         +y*(0.225319e-2+y*(-0.157565e-2+y*(0.916281e-2
         +y*(-0.2057706e-1+y*(0.2635537e-1+y*(-0.1647633e-1
         +y*0.392377e-2))))))))
    END;
  END;

  FUNCTION bessi1(x: double): double;
  VAR
     ax: double;
     y,ans: double;
  BEGIN
    IF (abs(x) < 3.75) THEN BEGIN
      y := sqr(x/3.75);
      ans := x*(0.5+y*(0.87890594+y*(0.51498869+y*(0.15084934
         +y*(0.2658733e-1+y*(0.301532e-2+y*0.32411e-3))))))
    END ELSE BEGIN
      ax := abs(x);
      y := 3.75/ax;
      ans := 0.2282967e-1+y*(-0.2895312e-1+y*(0.1787654e-1-y*0.420059e-2));
      ans := 0.39894228+y*(-0.3988024e-1+y*(-0.362018e-2
         +y*(0.163801e-2+y*(-0.1031555e-1+y*ans))));
      ans := (exp(ax)/sqrt(ax))*ans;
      IF (x<0.0) THEN ans := -ans
    END;
    bessi1 := ans
  END;
  FUNCTION bessk0(x: double): double;
  VAR
     y,ans: double;
  BEGIN
    bessk0 :=0;
    if x=0 then ffehler:=true
    else begin
      IF (x <= 2.0) THEN BEGIN
        y := x*x/4.0;
        ans := (-ln(x/2.0)*bessi0(x))+(-0.57721566+y*(0.42278420
           +y*(0.23069756+y*(0.3488590e-1+y*(0.262698e-2
           +y*(0.10750e-3+y*0.74e-5))))))
      END ELSE BEGIN
        y := (2.0/x);
        ans := (exp(-x)/sqrt(x))*(1.25331414+y*(-0.7832358e-1
           +y*(0.2189568e-1+y*(-0.1062446e-1+y*(0.587872e-2
           +y*(-0.251540e-2+y*0.53208e-3))))))
      END;
      bessk0 := ans
    END;
  end;

  FUNCTION bessk1(x: double): double;
  VAR
     y,ans: double;
  BEGIN
    bessk1 :=0;
    if x=0 then ffehler:=true
    else begin
      IF  (x <= 2.0)  THEN BEGIN
        y := x*x/4.0;
        ans := (ln(x/2.0)*bessi1(x))+(1.0/x)*(1.0+y*(0.15443144
           +y*(-0.67278579+y*(-0.18156897+y*(-0.1919402e-1
           +y*(-0.110404e-2+y*(-0.4686e-4)))))))
      END ELSE BEGIN
        y := 2.0/x;
        ans := (exp(-x)/sqrt(x))*(1.25331414+y*(0.23498619
           +y*(-0.3655620e-1+y*(0.1504268e-1+y*(-0.780353e-2
           +y*(0.325614e-2+y*(-0.68245e-3)))))))
      END;
      bessk1 := ans
    END;
  end;

  FUNCTION bessi(n: integer; x: double): double;
  CONST
     iacc=40;
     bigno=1.0e10;
     bigni=1.0e-10;
  VAR
     bi,bim,bip,tox,ans: double;
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
        eND;
        IF (j=n) THEN ans := bip
      END;
      IF (x<0.0) AND ((n MOD 2)=1) THEN ans := -ans;
      bessi := ans*bessi0(x)/bi
    END
  END;

  FUNCTION bessk(n: integer; x: double): double;
  VAR
     tox,bkp,bkm,bk: double;
     j: integer;
  BEGIN
    bessk :=0;
    IF (n < 2) THEN BEGIN
      bessk:=0;
      ffehler:=true;
      exit
    eND;
    if x=0 then ffehler:=true
    else begin
      tox := 2.0/x;
      bkm := bessk0(x);
      bk := bessk1(x);
      FOR j := 1 TO n-1 DO BEGIN
        bkp := bkm+j*tox*bk;
        bkm := bk;
        bk := bkp
      END;
      bessk := bk
    END;
  end;

  function DiGamma(X : double) : double;
  const
    c  = 20                     ;
    d1 = -0.57721566490153286061;
    s  = 0.00001                ;
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
      end
      else
        digamma:=pi/tan(pi*(1-x))+digamma((1-x));
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
  end;
begin
  ffehler:=false;
  fehler:=0;
  sonderfunktion:=0;
  case nr of
    2 : sonderfunktion:=gammaln(a);
    1 : begin
          r:=gammaln(a);
          if abs(r)<25 then sonderfunktion:=exp(r)
          else begin
            sonderfunktion:=0;
            ffehler:=true
          end;
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
   16 : sonderfunktion:=digamma(a);
  end;
  if fehler<>0 then ffehler:=true;
end;

function funktionswert;
const zahlen: set of char=['0'..'9','.','é'];
  funktionen= 'SQR SQRT EXP LN ABS SI SIN COS TAN ARCCOS LG ARCTAN SINH COSH TANH INT'+
              ' SGN F1 F2 F3 F4 COT LD ARCSIN ARSINH ARCOSH ARTANH SEC GAMMA GAUSS'+
              ' MCARLO CI EI BETA BESSJ0 BESSJ1 WURZEL WURZEL3 EHOCH WURZEL4 W3 W4 LOG CSC'+
              ' WP F5 VORZEICHEN FRAC EXPP GAMMALN HEAVISIDE SINW COSW TANW COTW ARCTANW'+
              ' ARCSINW GSUMME SN CN DN EULERPHI AI BI ARCCOT ARCSEC DIGAMMA TIME ARCCSC COTH';
type  link=^stapelelement;
      stapelelement=record
                       re:double;
                       ch:char;
                       by:byte;
                       next:link
                    end;

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
  var z:double;
      c:integer;
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
    repeat
      inc(i)
    until (term[i]='(') or (i>len);
    p:=pos(copy(term,zeiger,i-zeiger),funktionen);
    if p=0 then {ungueltiger Funktionsaufruf} fehler:=1;
    funktionscode:=p;
    zeiger:=i+1;
  end;

  function funktion:double;
  var a,b,sn,cn,dn:double;
      ffehler:boolean;
      ai,Bi : Double;
    function gamma(a:double):double;
    var i:integer;
        gam:array[0..7] of double;
        cc,gg:double;
    begin
      gam[0]:=1;
      gam[1]:=-0.577191652;
      gam[2]:=0.988205891;
      gam[3]:=-0.897056937;
      gam[4]:=0.918206857;
      gam[5]:=-0.756704078;
      gam[6]:=0.482199394;
      gam[7]:=-0.193527818;
      if ((a<=0) and (a=int(a))) or (a>43) then begin
        gamma:=0;
        fehler:=4
      end else begin
        cc:=1;
        while a>2 do begin
          a:=a-1;
          cc:=cc*a
        end;
        while a<1 do begin
          cc:=cc/a;
          a:=a+1
        end;
        a:=a-1;
        gg:=0.035868343;
        for i:=7 downto 0 do gg:=gg*a+gam[i];
        gamma:=cc*gg;
      end;
    end;

    function intsin(x:double):double;
    var j:integer;
      f,y,s,sold:double;
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
    function intcos(x:double):double;
    var j:integer;
        f,y,s,sold:double;
    begin
      if (x>0) and (x<50) then begin
        s:=ln(x)+0.57722-sqr(x)/4;
        j:=2;
        f:=2*ln(x/2);
        repeat
          f:=f+2*ln(x)+ln(j)-ln(j+1)-2*ln(j+2);
          y:=exp(f);
          sold:=s;
          if odd(j div 2) then s:=s+y
                          else s:=s-y;
          inc(j,2);
        until abs(s-sold)<0.0001;
        intcos:=s;
      end else begin
        fehler:=2;
        intcos:=0;
      end;
    end;

    function eulerphi(zz:double):double;
    var z,anz,i:integer;
      function ggt(faktor,rest:integer):integer;
      var r,s,t:longint;
      begin
        if faktor*rest<>0 then begin
          s:=faktor;
          t:=rest;
          repeat
            r:=s mod t;
            s:=t;
            t:=r;
          until r=0;
          ggt:=s;
        end
        else ggt:=1;
      end;
    begin
      z:=round(zz);
      if (z<1) or (z>10000) then begin
        fehler:=1;
        eulerphi:=0;
        exit
      end;
      anz:=0;
      i:=1;
      repeat
        if ggt(i,z)=1 then inc(anz);
        inc(i);
      until (i>=z) or (anz>32000);
      if anz>32000 then begin
        fehler:=1;
        eulerphi:=0;
      end
      else eulerphi:=anz;
    end;

    function intexp(x:double):double;
    var j:integer;
        f,s,sold:double;
    begin
      if (x>0) and (x<40) then begin
        s:=x+ln(x)+0.57722156649+sqr(x)/4;
        j:=2;
        f:=2*ln(x/2);
        repeat
          f:=f+ln(x)+ln(j)-2*ln(j+1);
          sold:=s;
          s:=s+exp(f);
          inc(j);
        until abs(s-sold)<0.0001;
        intexp:=s;
      end else begin
        fehler:=2;
        intexp:=0;
      end;
    end;

    procedure funktion02;
    begin
      funktion:=0;
      fehler:=2
    end;
  begin
    funktion:=0;
    case funktionscode of
      302 : begin
              a:=gesamtkette;
              sncndn(a,1-q*q,sn,cn,dn);
              funktion:=sn
            end;
      305 : begin
              a:=gesamtkette;
              sncndn(a,1-q*q,sn,cn,dn);
              funktion:=cn
            end;
      308 : begin
              a:=gesamtkette;
              sncndn(a,1-q*q,sn,cn,dn);
              funktion:=dn
            end;
      326 : begin
              a:=gesamtkette;
              if abs(a)>1E-10 then funktion:=arctan(1.0/a)
                              else funktion:=Pi/2-arctan(x);
            end;
      333 : begin
              a:=gesamtkette;
              if abs(a)>=1 then begin
                b:=arctan(sqrt((a-1.0)*(a+1.0)));
                if a>0.0 then funktion:=b
                         else funktion:=Pi-b;
              end
              else funktion02;
            end;
      231 : begin
              a:=gesamtkette;
              if abs(a)<1e10 then funktion:=frac(a)
              else
                funktion02;
            end;
      236 : begin
              a:=gesamtkette;
              if p<0 then
                funktion02
              else begin
                if a*ln(p)<50 then funktion:=exp(a*ln(p))
                else
                  funktion02;
              end;
            end;
         1: begin
              a:=gesamtkette;
              if a=0 then funktion:=0
              else
                if abs(a)<ueberlauf then funktion:=sqr(1.0*a)
                else begin
                  funktion:=1e10;
//                  fehler:=2
                end
            end;
     5,171: begin
              a:=gesamtkette;
              if a>=0 then funktion:=sqrt(a)
              else
                funktion02; {Radikand kleiner 0}
            end;
   178,200: begin
              a:=gesamtkette;
              if a>0 then funktion:=exp(ln(a)/3);
              if a=0 then funktion:=0;
              if a<0 then funktion:=-exp(ln(-a)/3);
            end;
   192,203: begin
              a:=gesamtkette;
             if a>0 then funktion:=exp(ln(a)/4);
             if a=0 then funktion:=0;
             if a<0 then
               funktion02;
           end;
   10,186: begin
             a:=gesamtkette;
             if a>100 then begin
               a:=100;
//               fehler:=2
             end;
             if a<-100 then begin
               a:=-100;
//               fehler:=2
             end;
             funktion:=exp(a);
           end;
       14: begin
             a:=gesamtkette;
             if a>0 then funktion:=ln(a)
             else
               funktion02; {LN(A<=0) nicht erlaubt}
           end;
       17: funktion:=abs(gesamtkette);
       21: funktion:=intsin(gesamtkette);
       24: funktion:=sin(gesamtkette);
      259: funktion:=sin(gesamtkette*pi/180);
       28: funktion:=cos(gesamtkette);
      264: funktion:=cos(gesamtkette*pi/180);
       32: begin
             a:=gesamtkette;
             if cos(a)<>0 then funktion:=tan(a);
           end;
      269: begin
             a:=gesamtkette*pi/180;
             if cos(a)<>0 then funktion:=tan(a);
           end;
       88: begin
             a:=gesamtkette;
             if sin(a)<>0 then funktion:=cos(a)/sin(a)
           end;
      274: begin
             a:=gesamtkette*pi/180;
             if sin(a)<>0 then funktion:=cos(a)/sin(a)
           end;
      295: begin
             a:=gesamtkette;
             b:=1/2*SQRT(1-1/30*(7*EXP(-a*a/2)+16*EXP(-a*a*(2-SQRT(2)))+(7+1/4*PI*a*a)*EXP(-a*a)));
             if a<0 then funktion:=0.5-b;
             if a=0 then funktion:=0.5;
             if a>0 then funktion:=0.5+b;
           end;
       36: begin
             a:=gesamtkette;
             if abs(a)<=1 then
               funktion:=arccos(a)
             else
               funktion02;
           end;
       43: begin
             a:=gesamtkette;
             if a>0 then funktion:=0.4342944819033*ln(a) {funktion:=log10(a)}
             else
               funktion02; {LG(A<=0) nicht erlaubt}
           end;
      206: begin
             a:=gesamtkette;
             if (a>0) and (p>0) and (p<>1) then funktion:=ln(a)/ln(p)
             else
               funktion02; {LG(A<=0) nicht erlaubt}
           end;
       46: funktion:=arctan(gesamtkette);
      279: begin
             a:=arctan(gesamtkette);
             if a<0 then a:=a+pi;
             funktion:=a;
           end;
       53: begin
             a:=gesamtkette;
             if abs(a)<50 then funktion:=sinh(a)//}(exp(a)-exp(-a))/2
             else begin
               funktion:=1e10;
//               fehler:=2
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
   72,220: begin
             a:=gesamtkette;
             fehler:=0;
             if a=0 then funktion:=0
                    else funktion:=a/abs(a)
           end;
       76: funktion:=funktionswert(f[1],gesamtkette);
       79: funktion:=funktionswert(f[2],gesamtkette);
       82: funktion:=funktionswert(f[3],gesamtkette);
       85: funktion:=funktionswert(f[4],gesamtkette);
       92: begin
             a:=gesamtkette;
             if a>0 then funktion:={logn(2,a)}1.442695040889*ln(a)
             else
               funktion02; {LG(A<=0) nicht erlaubt}
           end;
       95: begin
             a:=gesamtkette;
             if abs(a)<1 then funktion:=arcsin(a)//}arctan(a/sqrt(1-a*a))
             else
               if a=1 then funktion:=pi/2
               else
                 if a=-1 then funktion:=-pi/2
                 else
                   funktion02;
           end;
      287: begin
             a:=gesamtkette;
             if abs(a)<1 then begin
               b:={arcsin(a)}arctan(a/sqrt(1-a*a));
               if b<0 then b:=pi/2-b;
               funktion:=b;
             end
             else
               if a=1 then funktion:=pi/2
               else
                 if a=-1 then funktion:=pi/2
                 else
                   funktion02;
           end;
      102: begin
             a:=gesamtkette;
             funktion:=ln(a+sqrt(sqr(a)+1))
           end;
      109: begin
             a:=gesamtkette;
             if a>=1 then funktion:={arccosh(a)}ln(a+sqrt(sqr(a)-1))
             else
               funktion02;
           end;
      116: begin
             a:=gesamtkette;
             if abs(a)<1 then funktion:={arctanh(a)}ln((1+a)/(1-a))/2
             else
               funktion02;
           end;
      123: begin
             a:=gesamtkette;
             if cos(a)<>0 then funktion:={sec(a)}1/cos(a)
             else
               funktion02;
           end;
      210: begin
             a:=gesamtkette;
             if sin(a)<>0 then funktion:=1/sin(a)
             else
               funktion02;
           end;
      214: begin
             a:=gesamtkette;
             if (a>0) and (p<>0) then begin
               if abs(ln(a)/p)<50 then funktion:=exp(ln(a)/p)
               else
                 funktion02;
             end
             else
               funktion02;
           end;
      127: funktion:=gamma(gesamtkette);
      133: begin
             a:=gesamtkette;
             if a>50 then begin
               a:=50;
               fehler:=4
             end;
             if a<-50 then begin
               a:=-50;
               fehler:=4
             end;
             funktion:=exp(-sqr(a)/2)/2.506628274631;
           end;
      139: begin
             a:=gesamtkette;
             if a=0 then funktion:=random
                    else funktion:=random(trunc(a))
           end;
      311: funktion:=eulerphi(gesamtkette);
      320: begin
             a:=gesamtkette;
             airy(a,Ai,Bi);
             funktion:=ai;
           end;
      323: begin
             a:=gesamtkette;
             airy(a,Ai,Bi);
             funktion:=bi;
           end;
      146: funktion:=intcos(gesamtkette);
      149: funktion:=intexp(gesamtkette);
      152: begin
             a:=gesamtkette;
             b:=gamma(a+p);
             if b<>0 then funktion:=gamma(a)*gamma(p)/b
             else begin
               funktion:=0;
               fehler:=4
             end
           end;
     157 : begin
             ffehler:=false;
             funktion:=sonderfunktion(4,gesamtkette,0,ffehler);
             if ffehler then fehler:=4
           end;
     164 : begin
             ffehler:=false;
             funktion:=sonderfunktion(5,gesamtkette,0,ffehler);
             if ffehler then fehler:=4
           end;
     241 : begin
             ffehler:=false; {gammaln}
             funktion:=sonderfunktion(2,gesamtkette,0,ffehler);
             if ffehler then fehler:=4
           end;
     249 : begin
             ffehler:=false; {heaviside}
             a:=gesamtkette;
             fehler:=3;
             if a=0 then funktion:=1/2
                    else funktion:=(abs(a)/a+1)/2;
           end;
      217: funktion:=funktionswert(f[5],gesamtkette);
     340 : begin
             ffehler:=false; {digamma}
             funktion:=sonderfunktion(16,gesamtkette,0,ffehler);
             if ffehler then fehler:=4
           end;
     348 : begin
             ffehler:=false;
             a:=gesamtkette;
             while a>24 do a:=a-24;
             while a<0 do a:=a+24;
             funktion:=a
           end;
     353 : begin
             a:=gesamtkette;
             if (a>=1) or (a<=-1) then funktion:=arcsin(1/a)
             else
               funktion02;
          end;
     360 : begin
             a:=gesamtkette;
             if (abs(a)<50) and (tanh(a)<>0) then funktion:=1/tanh(a)//}1-exp(-a)/(exp(a)+exp(-a))*2
             else begin
               funktion:=1e10;
               fehler:=1
             end
          end;
     else begin
            fehler:=1;
            funktion:=0
          end; {ungueltiger Funktionsaufruf}
    end
  end;

  function wert:double;
  var knr:integer;
      code:integer;
      a:double;
  begin
    case term[zeiger] of
      'A'..'J','L'..'O','S'..'T','V','W': wert:=funktion;
      '0'..'9','.': wert:=zahl;
      'É': begin
             wert:=exp(1);
             inc(zeiger)
           end;
      'X': begin
             wert:=x;
             inc(zeiger)
           end;
      'Q': begin
             wert:=q;
             inc(zeiger)
           end;
      'R': begin
             wert:=r;
             inc(zeiger)
           end;
      'K': begin
             val(term[zeiger+1],knr,code);
             case knr of
               1..5 : wert:=o_[knr];
                 else wert:=0;
             end;
             inc(zeiger,2)
           end;
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
     '(' : begin
             inc(zeiger);
             wert:=gesamtkette
           end;
     '|' : begin
             inc(zeiger);
             wert:=abs(gesamtkette)
           end;
     '[' : begin
             inc(zeiger);
             a:=gesamtkette;
             if a>=0 then wert:=int(a)
                     else wert:=int(a-1);
           end
      else begin
             fehler:=1;
             wert:=0
           end;
    end
  end;

  procedure symbol(var z:char; var p:byte);
  begin
    if zeiger<len then begin
      z:=term[zeiger];
      inc(zeiger);
      case z of '+','-','<','>','&','#',';': p:=1;
                        '*','·','/','~','%': p:=2;
                                '^','\'    : p:=3;
                                ')',']','|': p:=0
        else begin
          fehler:=1;
          p:=0
        end
      end
    end
    else p:=0
  end;

  function operand:double;
  var op:double;
  begin
    if term[zeiger]='-' then begin
      inc(zeiger);
      op:=-wert
    end
    else op:=wert;
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
        end
        else
          x_hoch_y := Exp(y * Ln(x))
      ELSE BEGIN
        ganz_y := Trunc(y);
        IF ABS(y) > ABS(ganz_y) THEN begin
          x_hoch_y:=0;
          fehler:=2
        end
        ELSE
          IF x <> 0.0 THEN
            IF (ganz_y MOD 2) = 0 THEN
              if abs(y*ln(abs(x))) > 15.0 THEN begin
                x_hoch_y:=0;
                fehler:=2
              end
              else x_hoch_y :=  Exp(Ln(ABS(x)) * y)
            ELSE
              if abs(y*ln(abs(x))) > 15.0 THEN begin
                x_hoch_y:=0;
                fehler:=2
              end
              else x_hoch_y := -Exp(Ln(ABS(x)) * y)       (* ungerader Exponent *)
          ELSE
            x_hoch_y := 0
      END
    ELSE
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
      ';': begin
             ergebnis:=a;
             p:=b
           end;
      '>': if a>b then ergebnis:=a
                  else ergebnis:=b;
      '<': if a>b then ergebnis:=b
                  else ergebnis:=a;
      '&': ergebnis:=(a+b)/2;
      '#': if a*b<0 then begin
             ergebnis:=0;
             fehler:=2
           end
           else
             ergebnis:=sqrt(a*b);
  '*','·': if (abs(a)<ueberlauf) and (abs(b)<ueberlauf) then ergebnis:=a*b
           else begin
             ergebnis:=1e10;
             fehler:=2
           end;
      '~': begin
             zw:=1;
             repeat
               if b<>0 then zw:=zw*a/b
                       else fehler:=2;
               if zw>ueberlauf then fehler:=2;
               a:=a-1;
               b:=b-1;
             until (b<=0) or (fehler>0);
             if fehler=0 then ergebnis:=zw
                         else ergebnis:=1e10;
           end;
      '/': if b<>0 then ergebnis:=a/b
           else begin
             ergebnis:=1e10;
             fehler:=2
           end;
      '%': if b<>0 then ergebnis:=round(a) mod round(b)
           else begin
             ergebnis:=1e10;
             fehler:=2
           end;
      '^': begin
             if fehler>1 then begin
               ergebnis:=0;
               fehler:=2
             end
             else
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
                        end
                        else
                          if a=0 then begin
                            ergebnis:=0
                          end
                          else
                            if (abs(ln(abs(a))*b)>16) then begin
                              ergebnis:=0;
                              fehler:=2
                            end else begin
                              if a<0 then ergebnis:=x_hoch_y(a,b)
                                     else ergebnis:=exp(ln(a)*b)
                            end;
           end;
      '\': begin
             if b=0 then begin
               ergebnis:=0;
               fehler:=2
             end else begin
               b:=1/b;
               if fehler>1 then begin
                 ergebnis:=0;
                 fehler:=2
               end
               else
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
                           end
                           else
                             if a=0 then ergebnis:=0
                             else
                               if (abs(ln(abs(a))*b)>15) then begin
                                 ergebnis:=0;
                                 fehler:=2
                               end else begin
                                 if a<0 then ergebnis:=x_hoch_y(a,b)
                                        else ergebnis:=exp(ln(a)*b)
                               end;
                         end
                       end
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
  if (not absolutegesetzt) or ((x>=absolutea) and (x<=absoluteb)) then begin
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
      end
      else funktionswert:=ergeb;
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

FUNCTION zbrent(x1,x2,tol: double;nr:byte;itmax:integer): double;
LABEL 99;
CONST
   eps=3.0e-8;
VAR
   a,b,c,d,e: double;
   min1,min2,min: double;
   fa,fb,fc,p,q,r: double;
   s,tol1,xm: double;
   iter: integer;
BEGIN
  d := 0;
  e:= 0;
  c:=0;
  a := x1;
  b := x2;
  fa := funktionswert(f[nr],a);
  fb := funktionswert(f[nr],b);
  fc := fb;
  FOR iter := 1 TO itmax DO BEGIN
    IF (fb*fc > 0.0) THEN BEGIN
      c := a;
      fc := fa;
      d := b-a;
      e := d
    END;
    IF (abs(fc) < abs(fb)) THEN BEGIN
      a := b;
      b := c;
      c := a;
      fa := fb;
      fb := fc;
      fc := fa
    END;
    tol1 := 2.0*eps*abs(b)+0.5*tol;
    xm := 0.5*(c-b);
    IF ((abs(xm) <= tol1) OR (fb = 0.0)) THEN BEGIN
      zbrent := b;
      GOTO 99
    END;
    IF ((abs(e) >= tol1) AND (abs(fa) > abs(fb))) THEN BEGIN
      s := fb/fa;
      IF (a = c)  THEN BEGIN
        p := 2.0*xm*s;
        q := 1.0-s
      END ELSE BEGIN
        q := fa/fc;
        r := fb/fc;
        p := s*(2.0*xm*q*(q-r)-(b-a)*(r-1.0));
        q := (q-1.0)*(r-1.0)*(s-1.0)
      END;
      IF (p > 0.0) THEN  q := -q;
      p := abs(p);
      min1 := 3.0*xm*q-abs(tol1*q);
      min2 := abs(e*q);
      IF (min1 < min2) THEN min := min1
                       eLSE min := min2;
      IF (2.0*p < min) THEN BEGIN
        e := d;
        d := p/q
      END ELSE BEGIN
        d := xm;
        e := d
      END
    END ELSE BEGIN
      d := xm;
      e := d
    END;
    a := b;
    fa := fb;
    IF (abs(d) > tol1) THEN BEGIN
      b := b+d
    END ELSE BEGIN
      IF (xm > 0) THEN BEGIN
        b := b+abs(tol1)
      END ELSE BEGIN
        b := b-abs(tol1)
      END
    END;
    fb := funktionswert(f[nr],b);
  END;
  zbrent := b;
99:   END;

procedure gaussv(var ko:gfeld; grad:integer; var det:double; var fehler:boolean);
var v:array[0..25] of byte;
    i,j,k,g:byte;
    f,f0:double;
    tau:integer;
begin
  f0:=0;
  for i:=1 to grad do v[i]:=i;
  tau:=1;
  f:=1;
  for i:=1 to grad do f:=f*ko[i,i];
  if f<0 then tau:=-tau;
  for k:=1 to grad-1 do begin
    f:=abs(ko[k,k]);
    g:=k;
    for j:=k+1 to grad do begin
      if f<abs(ko[k,j]) then begin
        f:=abs(ko[k,j]);
        g:=j
      end;
    end;
    if g<>k then begin
      j:=v[k];
      v[k]:=v[g];
      v[g]:=j;
      tau:=-tau;
      for i:=1 to grad do begin
        f:=ko[i,k];
        ko[i,k]:=ko[i,g];
        ko[i,g]:=f;
      end;
    end;
    f0:=ko[k,k];
    if f0<>0 then begin
      for j:=k+1 to grad do begin
        f:=ko[j,k];
        for i:=1 to k-1 do f:=f-ko[j,i]*ko[i,k];
        ko[j,k]:=f/f0;
      end;
      for j:=k+1 to grad do begin
        f:=ko[k+1,j];
        for i:=1 to k do f:=f-ko[k+1,i]*ko[i,j];
        ko[k+1,j]:=f;
      end;
    end;
  end;
  f:=1;
  for k:=1 to grad do f:=f*abs(ko[k,k]);
  det:=f*tau;

  if (f<>0) and (f0<>0) and (abs(det)>0.000001) then begin
    for i:=2 to grad do begin
      f:=ko[i,0];
      for j:=1 to i-1 do f:=f-ko[j,0]*ko[i,j];
      ko[i,0]:=f;
    end;
    ko[grad,0]:=ko[grad,0]/ko[grad,grad];
    for i:=grad-1 downto 1 do begin
      f:=ko[i,0];
      for j:=i+1 to grad do f:=f-ko[i,j]*ko[j,0];
      ko[i,0]:=f/ko[i,i];
    end;
    for i:=1 to grad do begin
      if i=v[i] then ko[0,i]:=ko[i,0]
      else begin
        j:=i;
        k:=v[j];
        while i<>v[j] do begin
          k:=v[j];
          j:=v[j]
        end;
        ko[0,i]:=ko[k,0];
      end;
    end;
    fehler:=false;
  end
  else fehler:=true;
end;

{$IFDEF FLOGG}
function funktionswertl;
const ln10 =  2.30258509299405;
var y:double;
begin
    funktionswertl:=0;
    case nr of
      0 : funktionswertl:=funktionswert(term,x);
      1 : funktionswertl:=funktionswert(term,funktionswert('EXP(X)',x));
      2 : begin
            y:=funktionswert(term,x);
            if (fehler=0) and (y>0) then funktionswertl:=ln(y)
            else
            begin
              funktionswertl:=0;
              fehler:=2
            end;
          end;
      3 : begin
            y:=funktionswert(term,funktionswert('EXP(X)',x));
            if (fehler=0) and (y>0) then funktionswertl:=ln(y)
            else
            begin
              funktionswertl:=0;
              fehler:=2
            end;
          end
    end;
end;
{$ENDIF}

begin
  f[1]:='';
  f[2]:='';
  f[3]:='';
  f[4]:='';
  f[5]:='';
  f[6]:='';
end.
