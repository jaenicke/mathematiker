UNIT compli;

INTERFACE

CONST
    Infinity = 1/0;
  CONST
    dSignMask     = $8000000000000000;
    dExponentMask = $7FF0000000000000;
    dMantissaMask = $000FFFFFFFFFFFFF;

  FUNCTION NAN:  DOUBLE;
  FUNCTION PositiveInfinity:  DOUBLE;
  FUNCTION SignedInfinity (CONST d:  DOUBLE):  DOUBLE;
  FUNCTION IsNAN(CONST d:  DOUBLE):  BOOLEAN;
  FUNCTION IsInfinity(CONST d:  DOUBLE): BOOLEAN;

IMPLEMENTATION

  USES
    SysUtils;

  CONST
    NANQuietBits        :  Int64 = dExponentMask OR dMantissaMask;
    PositiveInfinityBits:  Int64 = dExponentMask;
    NegativeInfinityBits:  Int64 = dExponentMask OR dSignMask;

  VAR
    dNANQuiet           :  DOUBLE ABSOLUTE NANQuietBits;
    dPositiveInfinity   :  DOUBLE ABSOLUTE PositiveInfinityBits;
    dNegativeInfinity   :  DOUBLE ABSOLUTE NegativeInfinityBits;

  FUNCTION IsNAN(CONST D:  DOUBLE):  BOOLEAN;
    VAR
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    RESULT := ((Overlay AND dExponentMask) =  dExponentMask)  AND
              ((Overlay AND dMantissaMask) <> 0)
  END {IsNAN};

  FUNCTION IsInfinity(CONST d:  DOUBLE):  BOOLEAN;
    var
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    Result := ((Overlay AND dExponentMask) = dExponentMask)  AND
              ((Overlay AND dMantissaMask) = 0)
  END {IsInfinity};

  FUNCTION NAN:  DOUBLE;
  BEGIN
    RESULT := dNANQuiet
  END {NAN};

  FUNCTION PositiveInfinity:  DOUBLE;
  BEGIN
    RESULT := dPositiveInfinity
  END {PositiveInfinity};

  FUNCTION SignedInfinity(CONST d:  DOUBLE):  DOUBLE;
  BEGIN
    IF   d < 0.0
    THEN RESULT := dNegativeInfinity
    ELSE RESULT := dPositiveInfinity
  END {SignedInfinity};

END.
