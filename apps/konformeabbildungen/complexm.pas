UNIT complexm;

INTERFACE

  USES Dialogs, SysUtils;

  TYPE
    Tdouble        = double;
    TComplexForm = (cfPolar, cfRectangular);
    TComplex     =
      RECORD
        CASE form:  TComplexForm OF
          cfRectangular:  (x,y    :  Tdouble);
          cfPolar      :  (r,theta:  Tdouble);
      END;

    TComplexFunction = FUNCTION (CONST z:  TComplex):  TComplex;
    EComplexLnZero     = CLASS(Exception);
    EComplexZeroDivide = CLASS(Exception);
    EComplexInvalidOp  = CLASS(Exception);

  FUNCTION  CConvert (CONST z:  TComplex; f:  TComplexForm):  TComplex;
  FUNCTION  CSet (CONST a,b:  Tdouble; CONST f:  TComplexForm = cfRectangular):  TComplex;
  FUNCTION  CToPolarStrwinkel (CONST z:  TComplex; CONST w,d:  BYTE):  STRING;
  FUNCTION  CToPolarStr (CONST z:  TComplex; CONST w,d:  BYTE;
                         CONST FormatString:  STRING = '%*.*f · CIS(%*.*f)'):  STRING;
  FUNCTION  CToRectStr  (CONST z:  TComplex; CONST w,d:  BYTE;
                         CONST FormatString:  STRING = '%*.*f +%*.*f i'):  STRING;
  FUNCTION  CAdd  (CONST a,b:  TComplex):  TComplex;
  FUNCTION  CDiv  (CONST a,b:  TComplex):  TComplex;
  FUNCTION  CMult (CONST a,b:  TComplex):  TComplex;
  FUNCTION  CSub  (CONST a,b:  TComplex):  TComplex;

  FUNCTION  CAbs (CONST z:  TComplex):  Tdouble;
  FUNCTION  CAbsSqr (CONST z:  TComplex):  Tdouble;
  FUNCTION  CConjugate (CONST a:  TComplex):  TComplex;

  FUNCTION  CDeFuzz (CONST z:  TComplex):  TComplex;
  FUNCTION  DeFuzz (CONST x:  Tdouble):  Tdouble;
  FUNCTION  CLn   (CONST a:  TComplex):  TComplex;
  FUNCTION  CExp  (CONST a:  TComplex):  TComplex;

  FUNCTION  CPower(CONST a,b:  TComplex):  TComplex;
  FUNCTION  CIntPower  (CONST a:  TComplex; CONST n:  INTEGER):  TComplex;
  FUNCTION  CdoublePower (CONST a:  TComplex; CONST x:  Tdouble):  TComplex;

  FUNCTION  CRoot (CONST a:  TComplex; CONST k,n:  WORD):  TComplex;
  FUNCTION  CSqr  (CONST a  :  TComplex):  TComplex;
  FUNCTION  CCos  (CONST a:  TComplex):  TComplex;
  FUNCTION  CSin  (CONST a:  TComplex):  TComplex;
  FUNCTION  CTan  (CONST a:  TComplex):  TComplex;
  FUNCTION  CSec  (CONST a:  TComplex):  TComplex;
  FUNCTION  CCsc  (CONST a:  TComplex):  TComplex;
  FUNCTION  CCot  (CONST a:  TComplex):  TComplex;
  FUNCTION  CCosh (CONST a:  TComplex):  TComplex;
  FUNCTION  CSinh (CONST a:  TComplex):  TComplex;
  FUNCTION  CTanh (CONST a:  TComplex):  TComplex;
  FUNCTION  CCoth (CONST a:  TComplex):  TComplex;
  FUNCTION  CLnGamma (CONST a:  TComplex):  TComplex;
  FUNCTION  CGamma   (CONST a:  TComplex):  TComplex;
  FUNCTION  FixAngle (CONST theta:  Tdouble):  Tdouble;
  FUNCTION  CI0 (CONST a:  TComplex):  TComplex;
  FUNCTION  CJ0 (CONST a:  TComplex):  TComplex;

IMPLEMENTATION

 USES
    Math,compli;
  VAR
    ComplexOne :  TComplex;
    ComplexZero:  TComplex;
  const
    TwoPI = 2*PI;

  FUNCTION CConvert (CONST z:  TComplex; f:  TComplexForm):  TComplex;
  VAR a:  TComplex;
  BEGIN
    IF   IsInfinity(z.x) OR IsInfinity(z.y) THEN BEGIN
      CASE f OF
        cfPolar:        RESULT := CSet(Infinity, 0.0, cfPolar);
        cfRectangular:  RESULT := CSet(Infinity, Infinity)
      END
    END ELSE BEGIN
      IF   IsNan(z.x) OR IsNan(z.y)
      THEN RESULT := CSet(NaN, NaN)
      ELSE BEGIN
        IF   z.form = f
        THEN RESULT := z
        ELSE BEGIN
          CASE z.form OF
            cfPolar:
              BEGIN
                a.form := cfRectangular;
                a.x := z.r * COS(z.theta);
                a.y := z.r * SIN(z.theta)
              END;
            cfRectangular:
              BEGIN
                a.form := cfPolar;
                a.r := Cabs(z);
                a.theta := ARCTAN2(z.y, z.x);
              END;
          END;
          RESULT := a
        END
      END
    END
END {CConvert};

  FUNCTION CSet (CONST a,b:  Tdouble; CONST f:  TComplexForm):  TComplex;
  BEGIN
    RESULT.form := f;
    CASE f OF
      cfRectangular:
        BEGIN
          RESULT.x := a;
          RESULT.y := b
        END;
     cfPolar:
        BEGIN
          RESULT.r := a;
          RESULT.theta := b
        END
    END
  END {CSet};

FUNCTION  CToPolarStr (CONST z:  TComplex;
                         CONST w,d:  BYTE;
                         CONST FormatString:  STRING):  STRING;
VAR u :  TComplex;
BEGIN
  u := CConvert (z, cfPolar);
  RESULT := Format(FormatString, [w,d,u.r, w,d,u.theta]);
END {CToPolarStr};
FUNCTION  CToPolarStrwinkel (CONST z:  TComplex;
                         CONST w,d:  BYTE):  STRING;
VAR u :  TComplex;
BEGIN
  u := CConvert (z, cfPolar);
//  RESULT := _strkomma(u.r,1,8)+' · CIS('+_str2komma(180/pi*u.theta)+'°)';
END {CToPolarStr};

  FUNCTION  CToRectStr (CONST z:  TComplex;
                        CONST w,d:  BYTE;
                        CONST FormatString:  STRING):  STRING;
  VAR NegativeFormat:  STRING;  u  :  TComplex;
  BEGIN
    IF   IsNan(z.x) OR IsNan(z.y)
    THEN RESULT := Format(FormatString, [w,d,NaN, w,d,NaN])
    ELSE BEGIN
      u := CConvert (z, cfRectangular);
      IF   u.y >= 0
      THEN RESULT := Format(FormatString, [w,d,u.x, w,d,u.y])
      ELSE BEGIN
        NegativeFormat := FormatString;
        IF   POS('+', NegativeFormat) > 0
        THEN NegativeFormat[ POS('+',NegativeFormat ) ] := '-';
        RESULT := Format(NegativeFormat, [w,d,u.x, w,d,ABS(u.y)])
      END
    END
  END {CToRectStr};

  FUNCTION CAdd  (CONST a,b:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      bTemp:  TComplex;
  BEGIN
    aTemp := CConvert(a, cfRectangular);
    bTemp := CConvert(b, cfRectangular);
    RESULT.form := cfRectangular;
    RESULT.x := aTemp.x + bTemp.x;
    RESULT.y := aTemp.y + bTemp.y
  END {CAdd};

  FUNCTION CSub  (CONST a,b:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      bTemp:  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    bTemp := CConvert (b,cfRectangular);
    RESULT.form := cfRectangular;
    RESULT.x := aTemp.x - bTemp.x;
    RESULT.y := aTemp.y - bTemp.y;
  END {CSub};

  FUNCTION CMult(CONST a,b:  TComplex):  TComplex;
    VAR
      bTemp:  TComplex;
  BEGIN
    bTemp := CConvert(b, a.form);
    RESULT.form := a.form;
    CASE a.form OF
      cfPolar:
        BEGIN
          RESULT.r := a.r * bTemp.r;
          RESULT.theta := FixAngle(a.theta + bTemp.theta)
        END;

      cfRectangular:
        BEGIN
          RESULT.x := a.x*bTemp.x - a.y*bTemp.y;
          RESULT.y := a.x*bTemp.y + a.y*bTemp.x
        END
    END
  END {CMult};

  FUNCTION CDiv  (CONST a,b:  TComplex):  TComplex;
    VAR
      bTemp:  TComplex;
      SumSquares:  Tdouble;
  BEGIN
    bTemp := CConvert(b, a.form);
    RESULT.form := a.form;
    CASE a.form OF
      cfPolar:
        BEGIN
            RESULT.r := a.r / bTemp.r;
            RESULT.theta := FixAngle(a.theta - bTemp.theta)
        END;
      cfRectangular:
        BEGIN
            SumSquares := SQR(bTemp.x) + SQR(bTemp.y);
            if sumsquares<>0 then begin
              RESULT.x := (a.x*bTemp.x + a.y*bTemp.y) / SumSquares;
              RESULT.y := (a.y*bTemp.x - a.x*bTemp.y) / SumSquares
            end else begin
              RESULT.x := 0;
              RESULT.y := 0
            end;
        END
    END
  END {CDiv};

  FUNCTION CAbs (CONST z:  TComplex):  Tdouble;
  BEGIN
    IF   z.form = cfRectangular
    THEN RESULT := SQRT( SQR(z.x) + SQR(z.y) )
    ELSE RESULT := z.r;  {cfPolar}
  END {CAbs};

  FUNCTION CAbsSqr (CONST z:  TComplex):  Tdouble;
  BEGIN
    CASE z.form OF
      cfRectangular:  CAbsSqr := SQR(z.x) + SQR(z.y);
      cfPolar:        CAbsSqr := SQR(z.r);
      ELSE
        RESULT := 0.0
    END
  END {CAbsSqr};

  FUNCTION CConjugate (CONST a:  TComplex):  TComplex;
  BEGIN
    RESULT.form := a.form;
    CASE a.form OF
      cfPolar:
        BEGIN
          RESULT.r := a.r;
          RESULT.theta := FixAngle(-a.theta)
        END;
      cfRectangular:
        BEGIN
          RESULT.x := a.x;
          RESULT.y := -a.y
        END
    END
  END {CConjugate};

  FUNCTION CDeFuzz (CONST z:  TComplex):  TComplex;
  BEGIN
    CASE z.form OF
      cfRectangular:
        BEGIN
          RESULT.form := cfRectangular;
          RESULT.x := DeFuzz(z.x);
          RESULT.y := DeFuzz(z.y);
        END;
      cfPolar:
        BEGIN
          RESULT.form := cfPolar;
          RESULT.r := DeFuzz(z.r);
          IF   RESULT.r = 0.0
          THEN RESULT.theta := 0.0
          ELSE RESULT.theta := DeFuzz(z.theta)
        END;
    END
  END {CDeFuzz};

  FUNCTION  DeFuzz (CONST x:  Tdouble):  Tdouble;
  BEGIN
    IF   ABS(x) < 1.0E-12
    THEN Defuzz := 0
    ELSE Defuzz := x
  END {Defuzz};

  FUNCTION CLn (CONST a:  TComplex):  TComplex;
  BEGIN
    RESULT := CConvert (a,cfPolar);
    RESULT.form := cfRectangular;
    if result.r>0 then begin
      RESULT.x := LN(RESULT.r);
      RESULT.y := FixAngle(RESULT.theta)
    end else begin
      RESULT.x := 0;
      RESULT.y := 0;
    END
  END;

  FUNCTION CExp  (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      rTemp:  Tdouble;
  BEGIN
    aTemp := CConvert(a,cfRectangular);
    rTemp := EXP(aTemp.x);
    RESULT := CSet(rTemp*COS(aTemp.y), rTemp*SIN(aTemp.y), cfRectangular)
  END {CExp};

  FUNCTION CPower  (CONST a,b:  TComplex):  TComplex;
    VAR
      blna,lna:  TComplex;
  BEGIN
    CDeFuzz (a);
    CDeFuzz (b);
    IF   CAbsSqr(a) = 0.0 THEN
      RESULT := ComplexZero
    ELSE BEGIN
      lna := CLn(a);
      blna := CMult(b, lna);
      RESULT := CExp(blna)
    END
  END {CPower};

  FUNCTION CIntPower (CONST a:  TComplex; CONST n:  INTEGER):  TComplex;
    VAR
      aTemp:  TComplex;
      rr,rtheta:double;
  BEGIN
    IF   CAbsSqr(a) = 0.0 THEN
      RESULT := ComplexZero
    ELSE BEGIN
      aTemp := CConvert (a,cfPolar);
      RESULT.form := cfPolar;
      rr := IntPower(aTemp.r,n);
      rtheta := FixAngle(n*aTemp.theta);
      RESULT.r := rr;
      RESULT.theta := rtheta;
      result.x := rr * COS(rtheta);
      result.y := rr * SIN(rtheta)
    END
  END {CIntPower};

  FUNCTION CdoublePower (CONST a:  TComplex; CONST x:  Tdouble):  TComplex;
    VAR
      aTemp:  TComplex;
      rr,rtheta:double;
  BEGIN
    IF   CAbsSqr(a) = 0.0 THEN
      RESULT := ComplexZero
    ELSE BEGIN
      aTemp := CConvert (a,cfPolar);
      RESULT.form := cfPolar;
      rr := Power(aTemp.r,x);
      rtheta := FixAngle(x*aTemp.theta);
      RESULT.r := rr;
      RESULT.theta := rtheta;
      result.x := rr * COS(rtheta);
      result.y := rr * SIN(rtheta)
    END
  END {CdoublePower};

  FUNCTION CRoot (CONST a:  TComplex; CONST k,n:  WORD):  TComplex;
    VAR
      aTemp:  TComplex;
      rr,rtheta:double;
  BEGIN
    IF   CAbs(a) = 0.0
    THEN RESULT := ComplexZero ELSE BEGIN
      aTemp := CConvert (a,cfPolar);
      RESULT.form := cfPolar;
      rr := Power(aTemp.r,1.0/n);
      rtheta := FixAngle((aTemp.theta + k*2.0*PI)/n);
      RESULT.r := rr;
      RESULT.theta := rtheta;
      result.x := rr * COS(rtheta);
      result.y := rr * SIN(rtheta)
    END
  END {CRoot};

  FUNCTION CSqr  (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    RESULT.form := cfRectangular;
    RESULT.x := SQR(aTemp.x) - SQR(aTemp.y);
    RESULT.y := 2*aTemp.x*aTemp.y
  END {CSqr};

  FUNCTION CCos (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
  BEGIN
    aTemp := CConvert(a, cfRectangular);
    RESULT := CSet ( COS(aTemp.x)*COSH(aTemp.y),
                    -SIN(aTemp.x)*SINH(aTemp.y))
  END {CCos};

  FUNCTION CSin (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
  BEGIN
    aTemp := CConvert(a, cfRectangular);
    RESULT := CSet(SIN(aTemp.x)*COSH(aTemp.y),
                   COS(aTemp.x)*SINH(aTemp.y))
  END {CSin};

  FUNCTION CTan (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      rTemp:  Tdouble;
  BEGIN
    aTemp := CConvert(a, cfRectangular);
    rTemp := COS(2.0*aTemp.x) + COSH(2.0*aTemp.y);
    if rtemp<>0 then
      RESULT := CSet(SIN(2.0*aTemp.x) /rTemp,
                     SINH(2.0*aTemp.y)/rTemp)
      else result:=complexzero;
  END {CTan};

  FUNCTION CSec (CONST a:  TComplex):  TComplex;
    VAR
      temp:  TComplex;
  BEGIN
    ComplexOne  := CSet(1.0, 0.0);
    temp := CCos(a);
    TRY
      RESULT := CDiv(ComplexOne, temp)
    EXCEPT
      ON EComplexZeroDivide DO
         RESULT := CSet(Infinity, Infinity);
      ON EComplexInvalidOp DO
         RESULT := CSet(Infinity, Infinity)
    END
  END {CSec};

  FUNCTION CCsc (CONST a:  TComplex):  TComplex;
    VAR
      temp:  TComplex;
  BEGIN
    ComplexOne  := CSet(1.0, 0.0);
    temp := CSin(a);
    TRY
      RESULT := CDiv(ComplexOne, temp)
    EXCEPT
      ON EComplexZeroDivide DO   // x/0
         RESULT := CSet(Infinity, Infinity);
      ON EComplexInvalidOp DO    // 0/0
         RESULT := CSet(Infinity, Infinity)
    END
  END {CCsc};

  FUNCTION CCot (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      Temp:  Tdouble;
  BEGIN
    aTemp := CConvert(a,cfRectangular);
    Temp := COSH(2.0*aTemp.y) - COS(2.0*aTemp.x);
    if temp<>0 then
      RESULT := CSet( SIN(2.0*aTemp.x)/Temp,
                     -SINH(2.0*aTemp.y)/Temp)
      else result:=complexzero;
  END {CCot};

  FUNCTION CCosh (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    RESULT := CSet(COSH(aTemp.x)*COS(aTemp.y),
                   SINH(aTemp.x)*SIN(aTemp.y))
  END {CCosh};

  FUNCTION CSinh (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    RESULT := CSet(SINH(aTemp.x)*COS(aTemp.y),
                   COSH(aTemp.x)*SIN(aTemp.y))
  END {CSinh};

  FUNCTION CTanh (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      temp :  Tdouble;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    temp := COSH(2.0*aTemp.x) + COS(2.0*aTemp.y);
    TRY
      RESULT := CSet(SINH(2.0*aTemp.x)/temp,
                     SIN(2.0*aTemp.y) /temp)
    EXCEPT
      RESULT := CSet( SignedInfinity(SINH(2.0*aTemp.x)),
                      SignedInfinity(SIN(2.0*aTemp.y)) );
    END
  END {CTanh};

  FUNCTION CCoth (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      temp :  Tdouble;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    temp := COSH(2.0*aTemp.x) - COS(2.0*aTemp.y);
    if temp=0 then temp:=0.0001;
    TRY
      RESULT := CSet(SINH(2.0*aTemp.x)/temp,
                     -SIN(2.0*aTemp.y) /temp)
    EXCEPT
      RESULT := CSet( SignedInfinity(SINH(2.0*aTemp.x)),
                      SignedInfinity(SIN(2.0*aTemp.y)) );
    END
  END {CCoth};

  FUNCTION CAsymptoticLnGamma (CONST a:  TComplex):  TComplex;
    CONST
      c:  ARRAY[1..8] OF Tdouble
       =  (1/12, -1/360, 1/1260, -1/1680, 1/1188, -691/360360,
           1/156, -3617/122400);
    VAR
      aTemp :  TComplex;
      i     :  WORD;
      powers:  ARRAY[1..8] OF TComplex;
      temp1 :  TComplex;
      temp2 :  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    temp1 := CLn(aTemp);
    temp2 := CSet (aTemp.x-0.5, aTemp.y, cfRectangular);
    RESULT := CMult(temp1, temp2);
    RESULT := CSub(RESULT, aTemp);
    RESULT.x := RESULT.x + 0.5*(LN(2*PI));
    temp1 := CSet(1.0, 0.0);
    powers[1] := CDiv(temp1, aTemp);
    temp2 := CMult(powers[1],powers[1]);
    FOR i := 2 TO 8 DO
      powers[i] := CMult(powers[i-1],temp2);
    FOR i := 8 DOWNTO 1 DO BEGIN
      temp1 := CSet(c[i]*powers[i].x, c[i]*powers[i].y, cfRectangular);
      RESULT := CAdd(RESULT, temp1);
    END
  END {CAsymptoticLnGamma};

  FUNCTION CLnGamma (CONST a:  TComplex):  TComplex;
    VAR
      aTemp:  TComplex;
      lna  :  TComplex;
      temp :  TComplex;
  BEGIN
    aTemp := CConvert (a, cfRectangular);
    IF   (aTemp.x <= 0.0) AND (DeFuzz(aTemp.y) = 0.0) THEN BEGIN
      IF   DeFuzz( Abs(Frac(aTemp.x)) ) = 0.0 THEN BEGIN
        RESULT := CSet(PositiveInfinity, PositiveInfinity);
        EXIT
      END
    END;
    IF   aTemp.y < 0.0 THEN BEGIN
      temp := CConjugate(aTemp);
      RESULT := CLnGamma(temp);
      RESULT := CConjugate(RESULT)
    END ELSE BEGIN
      IF   aTemp.x < 9.0 THEN BEGIN
        lna := CLn(aTemp);
        temp := CSet (aTemp.x+1.0, aTemp.y, cfRectangular);
        temp := CLnGamma(temp);
        RESULT := CSub(temp, lna)
      END
      ELSE RESULT := CAsymptoticLnGamma(aTemp)
    END
  END {CLnGamma};

  FUNCTION CGamma (CONST a:  TComplex):  TComplex;
    VAR
      lna:  TComplex;
  BEGIN
    lna := CLnGamma(a);
    IF   lna.x >= 75.0
    THEN RESULT := CSet(PositiveInfinity, PositiveInfinity)
    ELSE
      IF   lna.x < -200.0
      THEN RESULT := ComplexZero
      ELSE RESULT := CExp(lna);
  END {CGamma};

  FUNCTION FixAngle (CONST theta:  Tdouble):  Tdouble;
  BEGIN
    RESULT := theta;
    WHILE RESULT > PI DO BEGIN
      RESULT := RESULT - TwoPI;
    END;
    WHILE RESULT <= -PI DO BEGIN
      RESULT := RESULT + TwoPI;
    END
  END {FixAngle};

  FUNCTION CI0 (CONST a:  TComplex):  TComplex;
    CONST
      MaxTerm    : BYTE  = 35;
      EpsilonSqr : Tdouble = 1.0E-20;
    VAR
      aTemp  :  TComplex;
      i      :  BYTE;
      SizeSqr:  Tdouble;
      term   :  TComplex;
      zSQR25 :  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    RESULT :=  CSet(1.0, 0.0);
    zSQR25 := Cmult(aTemp,aTemp);
    zSQR25.x := 0.25 * zSQR25.x;
    zSQR25.y := 0.25 * zSQR25.y;
    term := zSQR25;
    RESULT := CAdd(RESULT, zSQR25);      // term 1
    i := 1;
    REPEAT
      term := CMult(zSQR25, term);
      INC (i);
      term.x := term.x / SQR(i);
      term.y := term.y / SQR(i);
      RESULT := CAdd(RESULT, term);          // sum := sum + term
      SizeSqr := SQR(term.x) + SQR(term.y)
    UNTIL (i > MaxTerm) OR (SizeSqr < EpsilonSqr)
  END {CI0};

  FUNCTION CJ0 (CONST a:  TComplex):  TComplex;
    CONST
      MaxTerm    : BYTE  = 35;
      EpsilonSqr : Tdouble = 1.0E-20;

    VAR
      addflag:  BOOLEAN;
      aTemp  :  TComplex;
      i      :  BYTE;
      SizeSqr:  Tdouble;
      term   :  TComplex;
      zSQR25 :  TComplex;
  BEGIN
    aTemp := CConvert (a,cfRectangular);
    RESULT := CSet(1.0, 0.0);
    zSQR25 := Cmult(aTemp, aTemp);
    zSQR25.x := 0.25 * zSQR25.x;
    zSQR25.y := 0.25 * zSQR25.y;
    term := zSQR25;
    RESULT := CSub(RESULT,zSQR25);       // term 1
    addflag := FALSE;
    i := 1;
    REPEAT
      term := CMult(zSQR25, term);
      INC (i);
      addflag := NOT addflag;
      term.x := term.x / SQR(i);
      term.y := term.y / SQR(i);
      IF   addflag
      THEN RESULT := CAdd(RESULT, term)        // sum := sum + term
      ELSE RESULT := CSub(RESULT, term);       // sum := sum - term
      SizeSqr := SQR(term.x) + SQR(term.y)
    UNTIL (i > MaxTerm) OR (SizeSqr < EpsilonSqr)
  END {CJ0};

INITIALIZATION
  ComplexZero := CSet(0.0, 0.0);
END.

