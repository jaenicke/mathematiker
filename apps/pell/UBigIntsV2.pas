unit UBigIntsV2;
{ Copyright 2001-2012, Gary Darby, Intellitech Systems Inc., www.DelphiForFun.org
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses Forms, Dialogs, SysUtils, Windows;

type
  TDigits = array of int64;

  TInteger = class(TObject)
  protected

    Sign:    integer;
    fDigits: TDigits;
    Base:    integer;
    procedure AbsAdd(const I2: tinteger);
    function AbsCompare(I2: TInteger): integer; overload;
    procedure AbsSubtract(const i2: Tinteger);
    procedure AssignZero;
    function IsZero: boolean;
    function GetBasePower: integer;
    procedure Trim;
  public
    property Digits: TDigits Read fDigits;
    constructor Create;
    procedure Assign(const I2: TInteger); overload;
    procedure Assign(const I2: int64); overload;
    procedure Assign(const I2: string); overload;
    procedure Add(const I2: TInteger); overload;
    procedure Add(const I2: int64); overload;
    procedure Subtract(const I2: TInteger); overload;
    procedure Mult(const I2: TInteger); overload;
    procedure Mult(const I2: int64); overload;
    function Compare(I2: int64): integer; overload;
    function ConvertToDecimalString(commas: boolean): string;
    procedure ChangeSign;
    procedure assignsmall(i2: int64);
  end;

implementation

uses Math;

var
  BaseVal:   integer = 10;
  BasePower: integer = 1;

constructor TInteger.Create;
begin
  inherited;
  Base := BaseVal;
  AssignZero;
end;

procedure Tinteger.Subtract(const I2: TInteger);
begin
  i2.ChangeSign;
  Add(i2);
  i2.ChangeSign;
end;

procedure Tinteger.ChangeSign;
begin
  Sign := -Sign;
end;

procedure TInteger.Trim;
var
  i, j: integer;
begin
  i := high(fDigits);
  if i >= 0 then begin
    j := i;
    if (fDigits[0] <> 0) then
      while (fDigits[i] = 0) do
        Dec(i)
    else
      while (i > 0) and (fDigits[i] = 0) do
        Dec(i);
    if j <> i then
      SetLength(fDigits, i + 1);
    if (i = 0) and (self.Digits[0] = 0) then
      Sign := 0;
  end
  else
    AssignZero;
end;

function TInteger.GetBasePower: integer;
var
  n: integer;
begin
  if Base = BaseVal then
    Result := BasePower
  else begin
    Result := 0;
    n      := Base;
    while n > 1 do begin
      Inc(BasePower);
      n := n div 10;
    end;
  end;
end;

procedure TInteger.Assign(const I2: TInteger);
var
  len: integer;
begin
  if i2.Base = Base then begin
    len := length(i2.fDigits);
    SetLength(fDigits, len);
    move(i2.fdigits[0],fdigits[0], len*sizeof(int64));
    Sign := i2.Sign;
    Trim;
  end
  else
    self.Assign(i2.ConvertToDecimalString(False));
end;

procedure TInteger.Assign(const I2: int64);
var
  i:     integer;
  n, nn: int64;
begin
  if system.abs(i2) < Base then
    assignsmall(i2)
  else begin
    SetLength(fDigits, 20);
    n := system.abs(i2);
    i := 0;
    repeat
      nn := n div Base;
      fDigits[i] := n - nn * Base;
      n  := nn;
      Inc(i);
    until n = 0;
    if i2 < 0 then
      Sign := -1
    else
      if i2 = 0 then
        Sign := 0
      else
        if i2 > 0 then
          Sign := +1;
    SetLength(fDigits, i);
    Trim;
  end;
end;

procedure TInteger.Assign(const i2: string);
var
  i, j:    integer;
  zeroval: boolean;
  n, nn:   int64;
  pos:     integer;
begin
  n := length(I2) div GetBasePower + 1;
  SetLength(fDigits, n);
  for i := 0 to n - 1 do
    fDigits[i] := 0;
  Sign := +1;
  j   := 0;
  zeroval := True;
  n   := 0;
  pos := 1;
  for i := length(i2) downto 1 do begin
    if i2[i] in ['0'..'9'] then begin
      n   := n + pos * (Ord(i2[i]) - Ord('0'));
      pos := pos * 10;
      if pos > Base then begin
        nn  := n div Base;
        fDigits[j] := n - nn * Base;
        n   := nn;
        pos := 10;
        Inc(j);
        zeroval := False;
      end
    end
    else
      if i2[i] = '-' then
        Sign := -1;
  end;
  fDigits[j] := n;
  if zeroval and (n = 0) then
    Sign := 0;
  Trim;
end;

procedure TInteger.Add(const I2: TInteger);
var
  ii: TInteger;
begin
  if i2 = self then begin
    ii := TInteger.Create;
    ii.Assign(i2);
    if Sign <> ii.Sign then
      AbsSubtract(ii)
    else
      AbsAdd(ii);
    ii.Free;
  end else begin
    if Sign <> i2.Sign then
      AbsSubtract(i2)
    else
      AbsAdd(i2);
  end;
end;

procedure tinteger.AbsAdd(const i2: tinteger);
var
  i: integer;
  n, Carry: int64;
  i3:    TInteger;
begin
  i3 := Tinteger.Create;
  I3.Assign(self);
  SetLength(fDigits, max(length(fDigits), length(i2.fDigits)) + 1);
  i     := 0;
  Carry := 0;
  while i < min(length(i2.fDigits), length(i3.fDigits)) do begin
    n     := i2.fDigits[i] + i3.fDigits[i] + Carry;
    Carry := n div Base;
    fDigits[i] := n - Carry * Base;
    Inc(i);
  end;
  if length(i2.fDigits) > length(i3.fDigits) then
    while i <{=}length(i2.fDigits) do begin
      n     := i2.fDigits[i] + Carry;
      Carry := n div Base;
      fDigits[i] := n - Carry * Base;
      Inc(i);
    end
  else
    if length(i3.fDigits) > length(i2.fDigits) then begin
      while i <{=}length(i3.fDigits) do begin
        n     := i3.fDigits[i] + Carry;
        Carry := n div Base;
        fDigits[i] := n - Carry * Base;
        Inc(i);
      end;
    end;
  fDigits[i] := Carry;
  Trim;
  i3.free;
end;

procedure TInteger.Add(const I2: int64);
var iadd3: TInteger;
begin
  iadd3 := Tinteger.Create;
  IAdd3.Assign(I2);
  Add(IAdd3);
  iadd3.free;
end;

procedure TInteger.AbsSubtract(const i2: Tinteger);
var
  c:  integer;
  i3: TInteger;
  i, j, k: integer;
begin
  c  := AbsCompare(i2);
  i3 := TInteger.Create;
  if c < 0 then begin
    i3.Assign(self);
    Assign(i2);
  end
  else if c >= 0 then
     i3.Assign(i2);
  for i := 0 to high(i3.fDigits) do begin
    if fDigits[i] >= i3.fDigits[i] then
      fDigits[i] := fDigits[i] - i3.fDigits[i]
    else begin
      j := i + 1;
      while (j <= high(fDigits)) and (fDigits[j] = 0) do
        Inc(j);
      if j <= high(fDigits) then begin
        for k := j downto i + 1 do begin
          Dec(fDigits[k]);
          fDigits[k - 1] := fDigits[k - 1] + Base;
        end;
        fDigits[i] := fDigits[i] - i3.fDigits[i];
      end
    end;
  end;
  i3.Free;
  Trim;
end;

procedure TInteger.Mult(const I2: TInteger);
const
  ConstShift = 48;
var
  Carry, n, product: int64;
  xstart, ystart, i, j, k: integer;
  imult1:tinteger;
begin
  imult1 := Tinteger.Create;
  xstart := high(self.fDigits);
  ystart := high(i2.fDigits);
  imult1.AssignZero;
  imult1.Sign := i2.Sign * Sign;
  SetLength(imult1.fDigits, xstart + ystart + 3);
  for i := 0 to xstart do begin
    Carry := 0;
    for j := 0 to ystart do begin
      k     := i + j;
      product := i2.fDigits[j] * self.fDigits[i] + imult1.fDigits[k] + Carry;
      Carry := product shr ConstShift;
      if Carry = 0 then
        imult1.fDigits[k] := product
      else begin
        Carry := product div Base;
        imult1.fDigits[k] := product - Carry * Base;
      end;
    end;
    imult1.fDigits[ystart + i + 1] := Carry;
  end;
  xstart := length(imult1.fDigits) - 1;
  Carry  := 0;
  for i := 0 to xstart - 1 do begin
    n     := imult1.fDigits[i] + Carry;
    Carry := n div Base;
    imult1.fDigits[i] := n - Carry * Base;
  end;
  imult1.fDigits[xstart] := Carry;
  Assign(imult1);
  imult1.free;
end;

procedure TInteger.Mult(const I2: int64);
var
  Carry, n, d: int64;
  i:     integer;
  ITemp: TInteger;
begin
  d := system.abs(i2);
  if d > $ffffffff then begin
    itemp := TInteger.Create;
    itemp.Assign(i2);
    self.Mult(itemp);
    itemp.Free;
    exit;
  end;
  Carry := 0;
  for i := 0 to high(fDigits) do begin
    n     := fDigits[i] * d + Carry;
    Carry := n div Base;
    fDigits[i] := n - Carry * Base;
  end;
  if Carry <> 0 then begin
    i := high(fDigits) + 1;
    SetLength(fDigits, i + 11 div GetBasePower + 1);
    while Carry > 0 do begin
      n     := Carry;
      Carry := n div Base;
      fDigits[i] := n - Carry * Base;
      Inc(i);
    end;
  end;
  Trim;
end;

function TInteger.Compare(i2: int64): integer;
var icomp3: TInteger;
begin
  icomp3 := Tinteger.Create;
  icomp3.Assign(i2);
  if Sign < icomp3.Sign then
    Result := -1
  else if Sign > icomp3.Sign then
    Result := +1
  else if (self.Sign = 0) and (icomp3.Sign = 0) then
    Result := 0
  else begin
    Result := AbsCompare(icomp3);
    if Sign < 0 then
      Result := -Result;
  end;
  icomp3.free;
end;

function TInteger.AbsCompare(i2: Tinteger): integer;
var
  i: integer;
begin
  Result := 0;
  if (self.Sign = 0) and (i2.Sign = 0) then
    Result := 0
  else if length(fDigits) > length(i2.fDigits) then
    Result := +1
  else if length(fDigits) < length(i2.fDigits) then
    Result := -1
  else
    for i := high(fDigits) downto 0 do begin
      if fDigits[i] > i2.fDigits[i] then begin
        Result := +1;
        break;
      end
      else if fDigits[i] < i2.fDigits[i] then begin
        Result := -1;
        break;
      end;
    end;
end;

function TInteger.ConvertToDecimalString(commas: boolean): string;
var
  i, j, NumCommas, CurPos, StopPos, b, DigCount, NewPos, Top: integer;
  n, nn, last: int64;
  c: byte;

begin
  if length(fDigits) = 0 then
    AssignZero;
  if IsZero then begin
    Result := '0';
    exit;
  end;
  Result := '';
  b      := GetBasePower;
  Top    := high(self.Digits);
  Last   := fDigits[Top];
  DigCount := Top * b + 1 + trunc(Math.log10(Last));
  Dec(Top);
  if Sign > 0 then begin
    CurPos := DigCount;
    SetLength(Result, CurPos);
    StopPos := 0;
  end else begin
    CurPos := DigCount + 1;
    SetLength(Result, CurPos);
    Result[1] := '-';
    StopPos   := 1;
  end;
  for i := 0 to Top do begin
    n := fDigits[i];
    for j := 1 to b do begin
      nn := n div 10;
      c  := n - nn * 10;
      n  := nn;
      Result[CurPos] := char($30 + c);
      Dec(CurPos);
    end;
  end;
  repeat
    nn   := Last div 10;
    c    := Last - nn * 10;
    Last := nn;
    Result[CurPos] := char($30 + c);
    Dec(CurPos);
  until CurPos <= StopPos;
  if Commas then begin
    CurPos    := Length(Result);
    NumCommas := (DigCount - 1) div 3;
    if NumCommas > 0 then begin
      NewPos := CurPos + NumCommas;
      SetLength(Result, NewPos);
      for i := 1 to NumCommas do begin
        Result[NewPos]     := Result[CurPos];
        Result[NewPos - 1] := Result[CurPos - 1];
        Result[NewPos - 2] := Result[CurPos - 2];
        Result[NewPos - 3] := ' ';
        Dec(NewPos, 4);
        Dec(CurPos, 3);
      end;
    end;
  end;
end;

function TInteger.IsZero: boolean;
begin
  Result := self.Digits[high(self.Digits)] = 0;
end;

procedure TInteger.AssignZero;
begin
  SetLength(fDigits, 1);
  self.Sign := 0;
  self.fDigits[0] := 0;
end;

procedure TInteger.assignsmall(i2: int64);
begin
  if system.abs(i2) >= Base then
    Assign(i2)
  else if i2 = 0 then
    AssignZero
  else begin
    if i2 < 0 then begin
      self.Sign := -1;
      i2 := -i2;
    end
    else
      self.Sign := +1;
    SetLength(self.fDigits, 1);
    self.fDigits[0] := i2;
  end;
end;

end.
