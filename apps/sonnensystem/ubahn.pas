unit ubahn;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, Buttons, Math, ComCtrls, CheckLst;

type
  tBahnDat = record
    bdkn,
    bda,
    bdex,
    bdlpe,
    bdum: double;
    col: tColor;
  end;

  { Tform1 }

  Tform1 = class(TForm)
    P2: TPanel;
    P3: TPanel;
    pbahn: TPanel;
    PB1: TPaintBox;
    P6: TPanel;
    L24: TLabel;
    L25: TLabel;
    L26: TLabel;
    L27: TLabel;
    L28: TLabel;
    S1: TSpeedButton;
    S3: TSpeedButton;
    S2: TSpeedButton;
    Button2: TButton;
    Button1: TButton;
    CL1: TCheckListBox;
    E1: TEdit;
    E3: TEdit;
    L20: TLabel;
    L19: TLabel;
    L1: TLabel;
    L29: TLabel;
    MM1: TMainMenu;
    M1: TMenuItem;
    M5: TMenuItem;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    liste: TListBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    E2: TEdit;
    procedure DateChange(Sender: TObject);
    procedure S7C(Sender: TObject);
    procedure NewOrbitals(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure S8C(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
    Fbitmap: tbitmap;
    FBmpOrbital: tbitmap;
    Fziel: tcanvas;
    Fbirect, Fmyrect: trect;
    FarrChecked: array of integer;
    FarrBahnDat: array of tBahnDat;
    Fbx, Fhx : integer;

    FDatum : TDateTime;
    FJuldat: double;
    FsYear, FsMonth, FsDay: string;
    Fyear, Fmonth, Fday: word;
  public
    { Public-Deklarationen }
  end;

  const farb: array[0..14] of longint =
           ($00f0f0f0, $0000ff00, $00ff0000, $000000ff, $00ffff00, $00ff00ff,
            $0000ffff, $00ff7fff, $007fffff, $00ffff7f, $00ff7f00, $00ff007f,
            $00ff7f7f, $0000ff7f, $07f7fff);

var
  form1: Tform1;

implementation

uses XAstro;

{$R *.dfm}

var
  wert: double;

const
  pino = pi / 180;

procedure Tform1.S7C(Sender: TObject);
begin
  FBitmap.Free;
  FBmpOrbital.free;
  Close;
end;

procedure kalende1(var ta,mo,ja:longint);
var sc:boolean;
begin
    if ((ta=32) and (mo in [1,3,5,7,8,10,12])) or
       ((ta=31) and (mo in [4,6,9,11])) then
    begin
      inc(mo);
      ta:=1;
    end;
    if mo=2 then
    begin
      sc:=(ja mod 4=0);
      if (ja mod 100=0) and not(ja mod 400=0) then sc:=not sc;
      if sc and (ta=30) then
      begin
        inc(mo);
        ta:=1;
      end;
      if not sc and (ta=29) then
      begin
        inc(mo);
        ta:=1;
      end;
    end;
    if mo=13 then
    begin
      inc(ja);
      mo:=1
    end;

    if ((ta=0) and (mo in [2,4,6,8,9,11,1])) then
    begin
      dec(mo);
      ta:=31;
    end;
    if ((ta=0) and (mo in [5,7,10,12])) then
    begin
      dec(mo);
      ta:=30;
    end;
    if mo=3 then
    begin
      sc:=(ja mod 4=0);
      if (ja mod 100=0) and not(ja mod 400=0) then sc:=not sc;
      if sc and (ta=0) then
      begin
        dec(mo);
        ta:=29;
      end;
      if not sc and (ta=0) then
      begin
        dec(mo);
        ta:=28;
      end;
    end;
    if mo=0 then
    begin
      dec(ja);
      mo:=12;
      ta:=31;
    end;
end;

function juldat(const jahr, mon, tag: integer): real;
var
  y, m, k: longint;
  a, b: real;
begin
  k := 10000 * jahr + 100 * mon + tag;
  b := -63.5;
  y := jahr + 4712;
  m := mon + 1;
  if mon <= 2 then
  begin
    Dec(y);
    Inc(m, 12);
  end;
  if k >= 15821015 then
  begin
    A := int((y + 88) / 100);
    b := b + 38 - A + int(0.25 * A);
  end;
  juldat := int(365.25 * y) + int(30.6001 * m) + tag + b - 1 / 24;
end;

procedure Tform1.PB1paint(Sender: TObject);

var
  kp: string;
  um, kn, ex, r, a, e, p, po, lpe: real;
  x, y, xp, yp, xa, ya: integer;
  i, j: integer;

  sini, cosi: extended;
begin
  Fziel.CopyRect(fbirect,FBmpOrbital.Canvas,fbirect);
  for i := 1 to FarrChecked[0] do
  begin
    j := FarrChecked[i];
    kp := cl1.items.strings[j];
    with FarrBahnDat[j] do
    begin
      kn := bdkn;
      a := bda;
      ex := bdex;
      lpe := bdlpe;
      um := bdum;
      fziel.brush.color := col;
    end;
    e := a * ex;
    p := a-sqr(e)/ a;

    po := FJuldat;
    if (kp[1] <> 'K') and (kp[1] <> 'A') and (kp[1] <> 'P') then
    begin
      po := helio(FJuldat, kp);
      r := wert * p / (1 + ex * cos(pino * (po - kn)));
      sincos(pino * po, sini, cosi);
      x := Fbx + round(r * cosi);
      y := Fhx - round(r * sini);
      fziel.ellipse(x - 3, y - 3, x + 4, y + 4);
      fziel.brush.style := bsclear;
      fziel.textout(x - 6, y + 4, kp);
    end
    Else
      if (pos('Pluto', kp) <> 0) then
      begin
        po := po - juldat(trunc(lpe), round(365.25 * frac(lpe)), 1);
        po := kn + 360.0 * po / 365.25 / um;
        while po > 360 do
          po := po - 360;
        r := wert * p / (1 + ex * cos(pino * (po - kn)));
        sincos(pino * po, sini, cosi);
        x := Fbx + round(r * cosi);
        y := Fhx - round(r * sini);
        fziel.brush.style := bssolid;
        fziel.ellipse(x - 4, y - 4, x + 4, y + 4);
        fziel.brush.style := bsclear;
        fziel.textout(x - 6, y + 4, 'Pluto');
      end
      else
      begin
      r := wert * p / (1 + ex);
      sincos(pino * kn, sini, cosi);
      xp := Fbx + round(r * cosi);
      yp := Fhx - round(r * sini);

      r := wert * p / (1 + ex * cos(pi));
      sincos(pino * (180 + kn), sini, cosi);
      xa := Fbx + round(r * cosi);
      ya := Fhx - round(r * sini);
      xp := (xp + xa) div 2;
      yp := (yp + ya) div 2;

      po := FJuldat;
      po := po - juldat(trunc(lpe), round(365.25 * frac(lpe) / 30),
        round(30.0 * frac(365.25 * frac(lpe) / 30)));

      po := kn + 180.0 + 360.0 * po / 365.25 / um;
      while po > 360 do
        po := po - 360;
      r := wert * p / (1 + ex * cos(pino * (po - kn)));
      sincos(pino * po, sini, cosi);
      x := Fbx + round(r * cosi);
      y := Fhx - round(r * sini);
      x := 2 * xp - x;
      y := 2 * yp - y;
      fziel.brush.style := bssolid;
      fziel.ellipse(x - 4, y - 4, x + 4, y + 4);
      if pos(' ', kp) > 0 then
        kp := copy(kp, pos(' ', kp) + 1, 255);
      fziel.brush.style := bsclear;
      fziel.textout(x - 6, y + 4, kp);
    end;
  end;

  PB1.Canvas.copyrect(fbirect, fziel, fmyrect);
end;

procedure Tform1.S8C(Sender: TObject);
begin
  if Sender = s1 then
    wert := wert * sqrt(2);
  if Sender = s3 then
    wert := wert / sqrt(2);
  if Sender = s2 then
    wert := 60;
  if wert > 500 then
    wert := 500;
  NewOrbitals(Sender);
end;

procedure Tform1.Button2Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
  if not Timer1.Enabled then
    button2.Caption := 'Simulation'
  else
  begin
    DateChange(sender);
    button2.Caption := 'Stopp';
  end;
end;

procedure Tform1.Timer1Timer(Sender: TObject);
var _year,_month,_day,i,diff:integer;
begin
    FDatum := Fdatum+updown1.position;
    _year:=strtoint(e3.text);
    _month:=strtoint(e2.text);
    _day:=strtoint(e1.text);
    diff:=updown1.position;
    if diff>0 then
      for i:=1 to diff do
      begin
        inc(_day);
        kalende1(_day,_month,_year);
      end;
    if diff<0 then
      for i:=diff to -1 do
      begin
        dec(_day);
        kalende1(_day,_month,_year);
      end;
    e1.text:=inttostr(_day);
    e2.text:=inttostr(_month);
    e3.text:=inttostr(_year);
    FJuldat := JulDat(_Year, _Month, _Day);
    PB1paint(sender);
end;
{  DecodeDate(FDatum,Fyear ,Fmonth,Fday);
  FsYear  := IntToStr(Fyear);
  FsMonth := IntToStr(Fmonth);
  FsDay   := IntToStr(Fday);
  FJuldat := JulDat(FYear, FMonth, FDay);
  e1.Text := FsDay;
  e2.Text := FsMonth;
  e3.Text := FsYear;
  PB1paint(Sender);
end; }

procedure TForm1.NewOrbitals(Sender: TObject);
var
 sini, cosi :extended;
  p, e, kn, a, ex, r: double;
  i, j,x, y: integer;
  cnv: tCanvas;
begin
  DateChange(Sender);
  cnv := FBmpOrbital.canvas;
  with cnv do
  begin
    Brush.Style:= bsSolid;
    Brush.color := 0;
    FillRect(fmyrect);
  end;
  i := 1;
  for j := 0 to cl1.items.Count - 1 do
    if cl1.Checked[j] then
    begin
      FarrChecked[i] := j;
      Inc(i);
    end;
  FarrChecked[0] := i - 1;

  for i := 1 to FarrChecked[0] do
  begin
    j:=FarrChecked[i];
    cnv.pen.color   := farb[j mod 15];
    cnv.brush.color := farb[j mod 15];
    with FarrBahnDat[j] do
    begin
      col :=farb[j mod 15];
      kn := bdkn;
      a := bda;
      ex := bdex;
      {
      lpe := bdlpe;
      um := bdum;
      }
    end;
    e := a * ex;
//    b := sqrt(sqr(a) - sqr(e));
    p := a-sqr(e) / a;
    r := wert * p / (1 + ex * cos(0));
    sincos(pino * kn, sini, cosi);
    x := Fbx + round(r * cosi);
    y := Fhx - round(r * sini);

    cnv.moveto(x, y);
    for j := 1 to 360 do
    begin
      r := wert * p / (1 + ex * cos(pino * j));
      sincos(pino * (j + kn), sini, cosi);
      x := Fbx + round(r * cosi);
      y := Fhx - round(r * sini);
      cnv.lineto(x, y);
    end;
  end;

  if checkbox1.Checked then
  begin
    cnv.Brush.style := bsclear;
    cnv.pen.color := clred;
    cnv.pen.style := psdot;
    cnv.ellipse(round(Fbx - wert * 3.4), round(Fhx - wert * 3.4),
      round(fbx + wert * 3.4 + 1), round(Fhx + wert * 3.4 + 1));
    cnv.ellipse(round(Fbx - wert * 2), round(Fhx - wert * 2),
      round(Fbx + wert * 2 + 1), round(Fhx + wert * 2 + 1));
    cnv.ellipse(round(Fbx - wert * 30), round(Fhx - wert * 30),
      round(Fbx + wert * 30 + 1), round(Fhx + wert * 30 + 1));
    cnv.ellipse(round(Fbx - wert * 50), round(Fhx - wert * 50),
      round(Fbx + wert * 50 + 1), round(Fhx + wert * 50 + 1));
    cnv.pen.style := pssolid;
  end;

//  x :=round(50/wert);
{  if x<4 then
    a:=50/wert
  else
    a := x;    }

  cnv.pen.color := $00ffffff;
  cnv.moveto(10, 10);
  cnv.brush.style := bsclear;
{  cnv.font.color := clwhite;
  cnv.font.size := 8;
  cnv.textout(15, 6, Format('  %7.4f AE', [a])); }
  cnv.brush.color := clyellow;
  cnv.ellipse(Fbx - 4, Fhx - 4, Fbx + 5, Fhx + 5);

  PB1paint(self);
end;

procedure Tform1.DateChange(Sender: TObject);
var _year,_month,_day : word;
    _juldat:real;
begin
  Fsday   := E1.text;
  Fsmonth := E2.text;
  FsYear  := E3.text;
  Fday    := StrToInt(Fsday);
  Fmonth  := StrToInt(FsMonth);
  FYear   := StrToInt(FsYear);
  FJuldat := JulDat(FYear, FMonth, FDay);

  decodedate(now,_year,_month,_day);
  _Juldat := JulDat(_Year, _Month, _Day);
  FDatum  := now+FJuldat-_Juldat;
end;


procedure Tform1.FormShow(Sender: TObject);
var
  kk: string;
  i, lnr: integer;
  oldDecSep : char;
begin
  Timer1.Enabled := False;

  if fbitmap<>nil then fbitmap.free;
  Fbitmap := tbitmap.Create;
  Fbitmap.Width := PB1.Width;
  Fbitmap.Height := PB1.Height;

  if fbmporbital<>nil then fbmporbital.free;
  FBmpOrbital := tbitmap.Create;
  FBmpOrbital.Width := PB1.Width;
  FBmpOrbital.Height := PB1.Height;

  Fbx := PB1.Width div 2;
  Fhx := PB1.Height div 2;

  fZiel   := Fbitmap.Canvas;
  fmyrect := PB1.clientrect;
  fbirect := fmyrect;
  fziel.font.color := clwhite;
  fziel.font.Name := 'Verdana';
  fziel.font.size := 8;

  cl1.Clear;
  lnr := 0;
  i := 0;
  repeat
    kk := liste.items[lnr];
    Inc(lnr);
    if kk[1] <> '[' then
    begin
      cl1.items.add(kk);
      if (i<8) or (i=23) then cl1.Checked[i]:= true;
      inc(i);
      Inc(lnr, 5);
    end;
  until (lnr > liste.items.Count - 1) or (kk[1] = '[');
  oldDecSep := DecimalSeparator;
  DecimalSeparator := '.';
  Setlength(FarrBahnDat, i);
  for i := 0 to cl1.items.Count - 1 do
  begin
    lnr := i * 6 + 1;
    with  FarrBahnDat[i] do
    begin
      bdkn:= strtofloat(liste.items[lnr]);
      bda :=strtofloat(liste.items[lnr+1]);
      bdex :=strtofloat(liste.items[lnr+2]);
      bdlpe :=strtofloat(liste.items[lnr+3]);
      bdUm  :=strtofloat(liste.items[lnr+4]);
    end;
  end;
  setlength(FarrChecked, length(FarrBahnDat) + 1);
  DecimalSeparator := oldDecSep;
  NewOrbitals(self);
end;

procedure Tform1.FormActivate(Sender: TObject);
var year,month,day:word;
begin
  FDatum := date;
  decodedate(date, year, month, day);
  Fday := day;
  Fmonth := month;
  FYear := year;
  FJuldat := JulDat(FYear, FMonth, FDay);

  FsYear := IntToStr(Fyear);
  FsMonth := IntToStr(Fmonth);
  FsDay := IntToStr(Fday);
  e1.Text := Fsday;
  e2.Text := Fsmonth;
  e3.Text := FsYear;

  wert := 60;
end;

end.
