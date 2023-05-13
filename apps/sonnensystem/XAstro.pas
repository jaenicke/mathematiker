unit XAstro;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses Grids, StdCtrls, Classes, Math, SysUtils;

function sternzeit(gela, zeit, jd: real): real;
function helio(jd: real; planet: string): real;

implementation

const
  pino = pi / 180;
  pium = 180 / pi;

function sternzeit(gela, zeit, jd: real): real;
var
  zco, st: real;
begin
  zco := 6.6973745583 + 0.06570982442 * (jd - 2451545.0) + 1.938587419e-14 * sqr(jd - 2451545.0);
  st := zco + gela / 15 + 1.00273790935 * zeit;
  while st < 0 do
    st := st + 24;
  while st > 24 do
    st := st - 24;
  sternzeit := st;
end;

procedure stoer(plnt: string; jud: real; var rs, ls: real);
var
  xk, sin5, cos5, sin4, cos4, sin6, cos6, sin3, cos3, sin2, cos2: real;
begin
  xk := (jud - 2438000.5) * Pi / 9600;
  sin2 := sin(2 * xk);
  cos2 := cos(2 * xk);
  sin3 := sin(3 * xk);
  cos3 := cos(3 * xk);
  sin4 := sin(4 * xk);
  cos4 := cos(4 * xk);
  sin5 := sin(5 * xk);
  cos5 := cos(5 * xk);
  sin6 := sin(6 * xk);
  cos6 := cos(6 * xk);
  if plnt = 'Jupiter' then
  begin
    rs := 0.2 + 2.6 * sin5 + 1.6 * cos5 - 1.1 * (cos4 + sin6) - 1.0 * sin4 + 0.6 *
      (cos3 - cos(xk)) - 0.5 * cos2 - 0.4 * cos6 - 0.3 * (sin2 + sin(7 * xk)) + 0.2 *
      (sin3 + cos(7 * xk) + cos(9 * xk) + sin(8 * xk));
    ls := 3.0 + 3.9 * sin(xk) + 3.0 * cos5 - 1.9 * sin5 - 1.8 * cos4 - 1.5 * cos2 + 1.4 *
      sin(xk) - 1.3 * cos6 + 1.2 * sin2 - 1.0 * sin3 + 0.4 * (sin6 - cos(7 * xk)) - 0.3 * cos(xk) + 0.2 *
      (cos(8 * xk) + sin(10 * xk) - sin(9 * xk));
  end;
  if plnt = 'Saturn' then
  begin
    rs := -14.0 - 14.1 * cos2 + 10.6 * cos(xk) + 4.0 * (cos3 - sin2) + 3.7 * sin3 - 2.7 *
      sin(xk) + 0.8 * sin6 - 0.7 * sin5 + 0.5 * cos4 + 0.4 * (cos6 - sin(8 * xk)) + 0.2 * (sin4 - sin(11 * xk));
    ls := -8.4 - 14.0 * sin(xk) + 6.2 * sin2 - 2.5 * cos(xk) - 1.2 * cos2 + 0.8 * sin3 + 0.4 *
      (cos3 + cos6) - 0.3 * cos5 + 0.2 * (cos(7 * xk) - sin4 - sin6);
  end;
  if plnt = 'Uranus' then
  begin
    rs := -13.9 - 11.4 * cos(xk) - 11.2 * sin(xk) + 3.0 *
      (cos2 + cos3 - sin2) - 2.7 * cos4 - 1.4 * sin4 + 0.9 * sin5 + 0.8 * sin6 + 0.5 *
      (sin(7 * xk) - cos(8 * xk)) - 0.4 * cos(7 * xk) + 0.3 * (sin(8 * xk) - cos(9 * xk)) + 0.2 * (sin3 - cos(10 * xk));
    ls := -46.5 + 6.7 * sin(xk) - 3.1 * cos(xk) + 1.9 * sin2 + 0.9 * sin3 - 0.8 * cos2 -
      0.6 * sin4 + 0.4 * cos4 + 0.3 * (cos5 + cos6 + cos(7 * xk) + cos(8 * xk) - cos3) + 0.2 *
      (cos(9 * xk) - sin5 - sin6 - sin(7 * xk) - sin(8 * xk));
  end;
  if plnt = 'Neptun' then
  begin
    rs := -55.9 - 3.3 * cos4 + 2.9 * cos2 - 2.2 * sin4 + 1.4 * cos(xk) + 1.0 * cos3 + 0.8 *
      (cos5 + sin5) + 0.4 * (sin2 + sin6) + 0.3 * (sin3 + cos6) + 0.2 * (cos(7 * xk) + sin(7 * xk) - sin(xk));
    ls := 32.4 - 2.4 * sin(xk) - 0.6 * sin2 + 0.5 * cos(xk) + 0.4 * (cos4 - sin4) + 0.3 * cos2 + 0.2 *
      (cos3 + cos5 + cos6 + sin(7 * xk) - sin3 - sin6 - sin(7 * xk) - sin(8 * xk));
  end;
end;

procedure Eplanet(Plnet: string; t: real; var aer, exze, scd, ib, lauf, lper, ma: real);
var
  man: real;
begin
  man := 0;
  if plnet = 'Erde' then
  begin
    aer := 1.000001018;
    exze := 0.01670862 - 0.000042037 * t;
    scd := 0;
    ib := 0;
    lauf := 0;
    lper := 102.937348 + 1.7195269 * t;
    man := 357.5291 + 35640 * t + 359.0503 * t;
  end;
  if Plnet = 'Merkur' then
  begin
    aer := 0.38709831;
    exze := 0.205632 + 0.000020406 * t;
    scd := 6.72;
    ib := 7.004986 + 0.0018215 * t;
    lauf := 48.330893 + 1.186189 * t;
    lper := 77.456119 + 1.5564775 * t;
    man := 174.7948 + 149400 * t + 72.5157 * t;
  end;
  if Plnet = 'Venus' then
  begin
    aer := 0.72332982;
    exze := 0.00677188 - 0.000047766 * t;
    scd := 16.68;
    ib := 3.394662 + 0.0010037 * t;
    lauf := 76.67992 + 0.901119 * t;
    lper := 131.563707 + 1.4022188 * t;
    man := 50.4161 + 58320 * t + 197.8108 * t;
  end;
  if Plnet = 'Mars' then
  begin
    aer := 1.523679342;
    exze := 0.09340062 + 0.000090483 * t;
    ib := 1.849726 - 0.0006010 * t;
    scd := 9.36;
    lauf := 49.558093 + 0.7720923 * t;
    lper := 336.060234 + 1.8410331 * t;
    man := 19.3730 + 19080 * t + 59.8554 * t;
  end;
  if Plnet = 'Jupiter' then
  begin
    ;
    aer := 5.202603;
    exze := 0.048495 + 0.000163 * t;
    ib := 1.3033 - 0.0055 * t;
    scd := 196.88;
    lauf := 100.464 + 1.021 * t;
    lper := 14.3313 + 1.6126 * t;
    man := 20.0202 + 3034.69015 * t;
  end;
  if Plnet = 'Saturn' then
  begin
    aer := 9.554910;
    exze := 0.055509 - 0.000347 * t;
    scd := 165.46;
    ib := 2.4889 - 0.0037 * t;
    lauf := 113.666 + 0.877 * t;
    lper := 93.0568 + 1.9638 * t;
    man := 317.0207 + 1221.54725 * t;
  end;
  if Plnet = 'Uranus' then
  begin
    aer := 19.218446;
    exze := 0.046296 - 0.000027 * t;
    scd := 70.04;
    ib := 0.7732 + 0.0008 * t;
    lauf := 74.006 + 0.521 * t;
    lper := 173.0052 + 1.4864 * t;
    man := 141.0499 + 428.37768 * t;
  end;
  if Plnet = 'Neptun' then
  begin
    aer := 30.110387;
    exze := 0.008988 + 0.000006 * t;
    scd := 67;
    ib := 1.7700 - 0.0093 * t;
    lauf := 131.784 + 1.102 * t;
    lper := 48.1237 + 1.4263 * t;
    man := 256.2250 + 218.45704 * t;
  end;
  ma := man - (int(man / 360) * 360);
  if ma < 0 then
    ma := ma + 360;
end;

function ExzAn(MitAno, exz: real): real;
var
  i: byte;
  ExA: array[0..40] of real;
begin
  i := 0;
  Exa[0] := 0;
  repeat
    ExA[i + 1] := MitAno + exz * sin(Exa[i]);
    Inc(i);
  until (abs(ExA[i] - ExA[i - 1]) < 1e-7) or (i > 38);
  ExzAn := ExA[i];
end;

function helio(jd: real; planet: string): real;
var
  aera, exzd, iba, laufa, lpera, maa, mar, ExzA, rav, vwa, ubr: array[0..3] of real;
  ubl, ibl, sche: array[0..3] of real;
  pli: array[1..2] of string;
  ti, hgr, lhel, lhelz, lst, rst: real;
  i: integer;
const
  zieljd = 2451545;
begin
  ti := (jd - 2451545.0) / 36525;
  rst := 0;
  lst := 0;
  if (planet <> 'Merkur') and (planet <> 'Erde') and (planet <> 'Venus') and
    (planet <> 'Mars') and (planet <> 'Jupiter') and (planet <> 'Saturn') and
    (planet <> 'Uranus') and (planet <> 'Neptun') and (planet <> 'Pluto') then
    planet := 'Venus';
  pli[1] := planet;
  pli[2] := 'Erde';
  for i := 1 to 2 do
  begin
    Eplanet(pli[i], ti, aera[i], exzd[i], sche[i], iba[i], laufa[i], lpera[i], maa[i]);
    mar[i] := maa[i] * pino;
    ExzA[i] := ExzAn(mar[i], exzd[i]);
    rav[i] := aera[i] * (1 - exzd[i] * cos(ExzA[i]));
    vwa[i] := 2 * arctan(sqrt(abs((1 + exzd[i]) / (1 - exzd[i]))) * sin(ExzA[i] / 2) / cos(ExzA[i] / 2));
    vwa[i] := vwa[i] * pium;
    ubr[i] := vwa[i] + lpera[i] - laufa[i];
    ubl[i] := ubr[1] * pino;
  end;
  ibl[1] := iba[1] * pino;
  hgr := pium * arctan(sin(ubl[1]) * cos(ibl[1]) / cos(ubl[1]));
  lhel := laufa[1] + hgr;
  if cos(ubl[1]) < 0 then
    lhel := lhel + 180;
  if lhel < 0 then
    lhel := lhel + 360;
  lhelz := lhel + 0.01396 * (zieljd - jd) / 365.25;
  if (pli[1] = 'Jupiter') or (pli[1] = 'Saturn') or (pli[1] = 'Neptun') or
    (pli[1] = 'Uranus') then
    stoer(planet, jd, rst, lst);
  lhelz := lhelz + lst / 60;
  rav[1] := rav[1] + rst / 1000;
  helio := lhelz;
end;

end.
