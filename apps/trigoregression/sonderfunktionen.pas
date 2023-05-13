unit sonderfunktionen;

interface

PROCEDURE sncndn(uu,emmc: double; VAR sn,cn,dn: double);
procedure Airy(x : Double;var Ai : Double; var Bi : Double);
FUNCTION LogTen( X: double ) : double;

implementation

uses math;

FUNCTION LogTen( X: double ) : double;
BEGIN (* LogTen *)
  IF X <= 0.0 THEN
    LogTen := 0.0
  ELSE
    LogTen := LN( X ) * 0.4342944819032520;
END   (* LogTen *);

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
  if x>25.77 then begin
    ai := 0;
    bi := 1E10;
    Exit;
  end;
  if x<-2.09 then begin
    t := sqrt(-x);
    zeta := -2.0*x*t/3.0;
    t := sqrt(t);
    k := sqpii/t;
    z := 1.0/zeta;
    zz := z*z;
    AFN := (((((((-1.31696323418331795333E-1*zz-6.26456544431912369773E-1)
                 *zz-6.93158036036933542233E-1)
                 *zz-2.79779981545119124951E-1)
                 *zz-4.91900132609500318020E-2)
                 *zz-4.06265923594885404393E-3)
                 *zz-1.59276496239262096340E-4)
                 *zz-2.77649108155232920844E-6)
                 *zz-1.67787698489114633780E-8;
    AFD := ((((((((1.00E0*zz+1.33560420706553243746E1)
                 *zz+3.26825032795224613948E1)
                 *zz+2.67367040941499554804E1)
                 *zz+9.18707402907259625840E0)
                 *zz+1.47529146771666414581E0)
                 *zz+1.15687173795188044134E-1)
                 *zz+4.40291641615211203805E-3)
                 *zz+7.54720348287414296618E-5)
                 *zz+4.51850092970580378464E-7;
    uf := 1.0+zz*AFN/AFD;
    AGN := (((((((((1.97339932091685679179E-2*zz+3.91103029615688277255E-1)
                 *zz+1.06579897599595591108E0)
                 *zz+9.39169229816650230044E-1)
                 *zz+3.51465656105547619242E-1)
                 *zz+6.33888919628925490927E-2)
                 *zz+5.85804113048388458567E-3)
                 *zz+2.82851600836737019778E-4)
                 *zz+6.98793669997260967291E-6)
                 *zz+8.11789239554389293311E-8)
                 *zz+3.41551784765923618484E-10;
    AGD := (((((((((1.00E0*zz+9.30892908077441974853E0)
                 *zz+1.98352928718312140417E1)
                 *zz+1.55646628932864612953E1)
                 *zz+5.47686069422975497931E0)
                 *zz+9.54293611618961883998E-1)
                 *zz+8.64580826352392193095E-2)
                 *zz+4.12656523824222607191E-3)
                 *zz+1.01259085116509135510E-4)
                 *zz+1.17166733214413521882E-6)
                 *zz+4.91834570062930015649E-9;
    ug := z*AGN/AGD;
    theta := zeta+0.25*PI;
    f := sin(theta);
    g := cos(theta);
    ai := k*(f*uf-g*ug);
    bi := k*(g*uf+f*ug);
    Exit;
  end;
  if x>2.09 then begin
    domflg := 5;
    t := sqrt(x);
    zeta := 2.0*x*t/3.0;
    g := exp(zeta);
    t := sqrt(t);
    k := 2.0*t*g;
    z := 1.0/zeta;
    AN := ((((((3.46538101525629032477E-1*z+1.20075952739645805542E1)
               *z+7.62796053615234516538E1)
               *z+1.68089224934630576269E2)
               *z+1.59756391350164413639E2)
               *z+7.05360906840444183113E1)
               *z+1.40264691163389668864E1)
               *z+9.99999999999999995305E-1;
    AD := ((((((5.67594532638770212846E-1*z+1.47562562584847203173E1)
               *z+8.45138970141474626562E1)
               *z+1.77318088145400459522E2)
               *z+1.64234692871529701831E2)
               *z+7.14778400825575695274E1)
               *z+1.40959135607834029598E1)
               *z+1.00000000000000000470E0;
    f := AN/AD;
    ai := sqpii*f/k;
    if x>8.3203353 then begin
      BN16 := (((-2.53240795869364152689E-1*z+5.75285167332467384228E-1)
                     *z-3.29907036873225371650E-1)
                     *z+6.44404068948199951727E-2)
                     *z-3.82519546641336734394E-3;
      BD16 := ((((1.00E0*z-7.15685095054035237902E0)
                     *z+1.06039580715664694291E1)
                     *z-5.23246636471251500874E0)
                     *z+9.57395864378383833152E-1)
                     *z-5.50828147163549611107E-2;
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
  while t>5e-8 do begin
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
  if domflg mod 2=0 then begin
    ai := uf-ug;
  end;
  if domflg div 2 mod 2=0 then begin
    bi := sqrt3*(uf+ug);
  end;
  k := 4.0;
  uf := x*x/2.0;
  ug := z/3.0;
  f := uf;
  g := 1.0+ug;
  uf := uf/3.0;
  t := 1.0;
  while t>5e-8 do begin
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

PROCEDURE sncndn(uu,emmc: double; VAR sn,cn,dn: double);
LABEL 1;
CONST
   ca=0.0003;
VAR
   a,b,c,d,emc,u: double;
   i,ii,l: integer;
   bo: boolean;
   em,en: ARRAY [1..13] OF double;
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
1:  u := c*u;
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
      ELSE
        sn := a;
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

end.

