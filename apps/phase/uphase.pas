unit uphase;

{-----------------------------------------------------------------------------
 Unit Name: uphase
 Author:    W.Ehrhardt based on Steffen Polster's unit
 Purpose:   Compute and plot phase portraits of complex functions

 History:

 Original   by Steffen Polster (https://mathematikalpha.de/phasenplot)

 Oct, 2018  (D)AMath routines and parser
            OnPaint for paintbox
            Fast mode (half width/height)
            Coordinate display with OnMouseMove
            Adjust color scale to Wegert colors (exchange blue and green)
            Separate color mapping procedures
            Rocchini and gray scale maps
            checkboxes Contour and Progress
            Size 512 x 512, Help
            ComboBox with examples
            Improved Rocchini map
            Assign evr.X/Y
            Wegert methods
            Copy function strings to clipboard if parsed without errors
            Copy bitmap to clipboard pop-up menu
-----------------------------------------------------------------------------}

{$include std.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, clipbrd, Menus;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    BT_Plot: TButton;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    L64: TLabel;
    L95: TLabel;
    L94: TLabel;
    L96: TLabel;
    L93: TLabel;
    edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    CB_Fast: TCheckBox;
    Label2: TLabel;
    Bt_Help: TButton;
    FuncCombo: TComboBox;
    RBPanel: TPanel;
    RB_Standard: TRadioButton;
    RB_Wegert: TRadioButton;
    RB_Rocchini: TRadioButton;
    RB_W10: TRadioButton;
    PopupMenu1: TPopupMenu;
    copytoclipboard: TMenuItem;
    procedure BT_PlotClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: integer);
    procedure Bt_HelpClick(Sender: TObject);
    procedure copytoclipboardClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    { Public-Deklarationen }
    bitmap: TBitmap;
    x1,x2,y1,y2: double;
    Z_Display, ComputedWithFast: boolean;
    procedure calc_and_plot;
  end;

var
  Form1: TForm1;

var
  separator: char;

implementation

uses BTypes,AMath, AMCmplx, AMCcalc;

{$R *.DFM}

const

HlpStr: String =

't_pphase - Phase plot of complex functions  (c) W.Ehrhardt 2018'#13#10#10+

'Demo program for (D)AMath complex function units; based on ideas of Steffen Polster, Claudio Rocchini, Elias Wegert'#13#10#10+

'Operators, constants, avariables: + - * / ^ e i pi x y z'#13#10#10+

'Functions: '+
'abs, '+
'agm, '+
'arccos, '+
'arccosh, '+
'arccot, '+
'arccotc, '+
'arccoth, '+
'arccsc, '+
'arccsch, '+
'arcsec, '+
'arcsech, '+
'arcsin, '+
'arcsinh, '+
'arctan, '+
'arctanh, '+
'arg, '+
'cbrt, '+
'ck, '+
'cn, '+
'conj, '+
'cos, '+
'cosh, '+
'cot, '+
'coth, '+
'csc, '+
'csch, '+
'dilog, '+
'dn, '+
'ee, '+
'ek, '+
'erf, '+
'erfc, '+
'exp, '+
'expm1, '+
'gamma, '+
'im, '+
'lambertw, '+
'ln, '+
'ln1p, '+
'lngamma, '+
'log10, '+
'psi, '+
're, '+
'rstheta, '+
'sec, '+
'sech, '+
'sin, '+
'sinh, '+
'sn, '+
'sqr, '+
'sqrt, '+
'tan, '+
'tanh, '+
'wk'+#13#10#10+
'Numbers in formulas must be entered with a "." as decimal separator. '+
'Function strings are copied to clipboard if parsed without errors.';


{-------------------------------------------------------------}
function imin(x,y: integer): integer;
begin
  if x < y then imin := x
  else imin := y;
end;

{-------------------------------------------------------------}
procedure hsv2rgb(h,s,v: double; var r,g,b: double);
  {Onvert HSV to RGB, -0 <= h <= 1, 0 <= s <=1, 0 <=v <= 1; r,g,b in [0..1]}
var
  f,p,q,t: double;
  i: integer;
begin
  if (s <= 0 ) then begin
    r := v; g := v; b := v;
  end
  else begin
    h := 6*h;
    i := floor(h);
    f := h - i;
    p := v * (1 - s);
    q := v * (1 - s * f);
    t := v * (1 - s * (1 - f));
    case i of
        0: begin r := v; g := t; b := p; end;
        1: begin r := q; g := v; b := p; end;
        2: begin r := p; g := v; b := t; end;
        3: begin r := p; g := q; b := v; end;
        4: begin r := t; g := p; b := v; end;
      else begin r := v; g := p; b := q; end;
    end;
  end;
end;

{-------------------------------------------------------------}
procedure map_polster(const z: complex; var r,g,b: integer);
var
  h: double;
  w, f: integer;
begin
  {https://mathematikalpha.de/phasenplot}
  h := 3*rem_2pi(arctan2(z.im,z.re))/Pi;
  w := floor(h);
  f := imin(255, trunc(256*(h - w)));
  case w of
     0 : begin r := 255;    g := f;      b := 0;      end;
     1 : begin r := 255-f;  g := 255;    b := 0;      end;
     2 : begin r := 0;      g := 255;    b := f;      end;
     3 : begin r := 0;      g := 255-f;  b := 255;    end;
     4 : begin r := f;      g := 0;      b := 255;    end;
    else begin r := 255;    g := 0;      b := 255-f;  end;
  end;
end;

{-------------------------------------------------------------}
procedure map_rocchini_org(const z: complex; var r,g,b: integer);
var
  hue,sat,value,mag,p,q,dr,dg,db: double;
const
  M_E = 2.71828182845904523536028747135;
begin
  {based on a c++ program by Claudio Rocchini                   }
  {http://commons.wikimedia.org/wiki/File:Color_complex_plot.jpg}
  mag := hypot(z.re, z.im);
  hue := rem_2pi(arctan2(z.im,z.re))/TwoPi;
  if mag <= M_E then mag := mag/M_E
  else begin
    mag := ln(mag);
    mag := mag - int(mag);
  end;
  if mag < 0.5 then p := 2*mag else p := 2*(1-mag);
  q := 1.0 - p;
  sat := 0.4 + 0.6*(1.0 - q*q*q);
  value := 0.6 + 0.4*(1.0 - p*p*p);
  hsv2rgb(hue,sat,value,dr,dg,db);
  {Some dr,dg,db may be = 1}
  r := trunc(256*dr);  if r>255 then r := 255;
  g := trunc(256*dg);  if g>255 then g := 255;
  b := trunc(256*db);  if b>255 then b := 255;
end;

{-------------------------------------------------------------}
procedure map_wegert(const z: complex; res: integer; var r,g,b: integer);
var
  x,hue,mag,dr,dg,db: double;
begin
  {E. Wegert: Phase Plots of Complex Functions:a Journey in Illustration; https://arxiv.org/pdf/1007.2295.pdf}
  {E. Wegert: Complex Function Explorer; https://de.mathworks.com/matlabcentral/fileexchange/45464-complex-function-explorer}
  mag := hypot(z.re, z.im);
  hue := rem_2pi(arctan2(z.im,z.re))/TwoPi;
  if mag>0 then begin
    mag := ln(mag);
  end;
  x := mag*res/TwoPi;
  x := 0.75+ 0.25*(x-floorx(x));
  hsv2rgb(hue,1,1,dr,dg,db);
  dr := x*dr;
  dg := x*dg;
  db := x*db;
  {Some dr,dg,db may be = 1}
  r := trunc(256*dr);  if r>255 then r := 255;
  g := trunc(256*dg);  if g>255 then g := 255;
  b := trunc(256*db);  if b>255 then b := 255;
end;

{-------------------------------------------------------------}
procedure map_rocchini(const z: complex; var r,g,b: integer);
var
  hue,sat,value,mag,p,q,dr,dg,db: double;
const
  cf=1.000; {Small correction factor to avoid artifacts if f(0)=1}
begin
  {based on a c++ program by Claudio Rocchini                   }
  {http://commons.wikimedia.org/wiki/File:Color_complex_plot.jpg}
  mag := hypot(z.re, z.im);
  hue := rem_2pi(arctan2(z.im,z.re))/TwoPi;
  if mag>0 then begin
    mag := frac(abs(ln(cf*mag)));
  end;
  if mag < 0.5 then p := 2*mag else p := 2*(1-mag);
  q := 1.0 - p;
  sat := 0.4 + 0.6*(1.0 - q*q*q);
  value := 0.6 + 0.4*(1.0 - p*p*p);
  hsv2rgb(hue,sat,value,dr,dg,db);
  {Some dr,dg,db may be = 1}
  r := trunc(256*dr);  if r>255 then r := 255;
  g := trunc(256*dg);  if g>255 then g := 255;
  b := trunc(256*db);  if b>255 then b := 255;
end;

{-------------------------------------------------------------}
procedure map_gray_mag(const z: complex; var r,g,b: integer);
var
  m: double;
begin
  m := hypot(z.re, z.im);
  r := imin(trunc(256/(1+m)),255);
  r := 255-r;
  g := r;
  b := r;
end;

{-------------------------------------------------------------}
procedure map_gray_arg(const z: complex; var r,g,b: integer);
var
  a: double;
begin
  a := rem_2pi(arctan2(z.im,z.re));
  r := imin(trunc(256*a/TwoPi),255);
  r := 255-r;
  g := r;
  b := r;
end;

{-------------------------------------------------------------}
procedure TForm1.calc_and_plot;
var
  i,j,b,h,pcolor: integer;
  k1: ansistring;
  emsg: string;
  dx,dy,eps,t:  double;
  red,green,blue: integer;
  progress, evalerr:  boolean;
  evr: TFEval;
  kx,ky: complex;
  method: integer;
var
  e: PFExpr;
  psz,pc: pchar8;
  EPos: integer;
begin
  amc_init_eval(evr);

  {parse function string}
  k1:=ansistring(FuncCombo.text);
  e := nil;
  psz := pchar8(k1);
  pc := amc_parse(psz,e,evr.Err);
  EPos := (pc-psz)+1;

  if evr.Err<>0 then begin
    emsg := string(amc_calc_errorstr(evr.Err))+ ' at pos '+IntToStr(Epos);
    if Epos > 1 then emsg := emsg + ': '#13#10 + copy(k1,1,EPos-1);
    ShowMessage(emsg);
    amc_clear_expr(e);
    exit;
  end;
  {Save in clipboard}
{$ifdef unicode}
  clipboard.SetTextBuf(pWideChar(FuncCombo.text));
{$else}
  clipboard.SetTextBuf(psz);
{$endif}

  {grid constants}
  b  := bitmap.width;
  h  := bitmap.height;
  if CB_fast.Checked then begin
    b := b div 2;
    h := h div 2;
  end;
  dx := (x2-x1)/b;
  dy := (y2-y1)/h;
  eps := 4*eps_d;

  {compute and plot}
  if RB_Rocchini.checked then method := 1
  else if RB_Wegert.checked then method := 2
  else if RB_W10.checked then method := 3
  else method := 0;
  progress := true;
  evr.X.im := 0.0;
  evr.Y.im := 0.0;
  for i:=0 to b do begin
    kx.re := x1+i*dx;
    evr.X.re := kx.re;
    for j:=0 to h do begin
      kx.im    := y1+j*dy;
      evr.Z    := kx;
      evr.Y.re := kx.im;
      evalerr  := false;
      pcolor   := clBlack;
      try
        amc_eval(e, evr);
        ky := evr.Res;
        if IsNanOrInf(ky.re) or IsNanOrInf(ky.im) then evalerr := true
        else begin
          {Suppress very small values}
          t := eps*hypot(ky.re, ky.im);
          if abs(ky.im) < t then ky.im := 0.0;
          if abs(ky.re) < t then ky.re := 0.0;
          case method of
              1:  map_rocchini(ky, red,green,blue);
              2:  map_wegert(ky, 20, red,green,blue);
              3:  map_wegert(ky, 10, red,green,blue);
            else  map_polster(ky, red,green,blue);
          end;
          pcolor := rgb(red,green,blue);
        end;
      except
        evalerr := true;
      end;
      if evalerr then pcolor := clBlack;
      bitmap.Canvas.pixels[i,h-j]:=pcolor;
    end;
    if progress then paintbox1.canvas.draw(0,0,bitmap);
  end;
  amc_clear_expr(e);
  Z_Display := true;
  ComputedWithFast  := CB_fast.Checked;
end;


{$ifdef D15Plus}
  {--------------------------------}
  function getseparator: char;
  begin
    getseparator := FormatSettings.DecimalSeparator;
  end;
{$else}
  {--------------------------------}
  function getseparator: char;
  begin
    getseparator := DecimalSeparator;
  end;
{$endif}

{-------------------------------------------------------------}
function clrsep(s: string): string;
var
  i: integer;
begin
  if Separator<>'.' then begin
    for i:=1 to length(s) do begin
      if s[i]=Separator then s[i]:='.';
    end;
  end;
  clrsep := s;
end;

{-------------------------------------------------------------}
procedure TForm1.BT_PlotClick(Sender: TObject);
var
  cx1,cx2,cy1,cy2: integer;
begin
  {get and check argument ranges}
  separator := GetSeparator;
  val(clrsep(edit1.text), x1, cx1);
  val(clrsep(edit2.text), x2, cx2);
  val(clrsep(edit3.text), y1, cy1);
  val(clrsep(edit4.text), y2, cy2);

  if cx1<>0 then ShowMessage('Invalid x1');
  if cx2<>0 then ShowMessage('Invalid x2');
  if cy1<>0 then ShowMessage('Invalid y1');
  if cy2<>0 then ShowMessage('Invalid y2');
  if (cx1 or cx2 or cy1 or cy2) <> 0 then exit;

  if x2<x1 then begin
    ShowMessage('x2 < x1');
    exit;
  end;
  if y2<y1 then begin
    ShowMessage('y2 < y1');
    exit;
  end;

  {clear paintbox}
  if bitmap<>nil then bitmap.free;
  bitmap := tbitmap.create;
  bitmap.width  := paintbox1.width;
  bitmap.height := paintbox1.height;

  {Calculate and plot}
  BT_Plot.Enabled := false;
  calc_and_plot;
  BT_Plot.Enabled := true;
  paintbox1.canvas.draw(0,0,bitmap);
end;


{-------------------------------------------------------------}
procedure TForm1.FormCreate(Sender: TObject);
begin
  Z_Display := false;
  bitmap := tbitmap.create;
  bitmap.width  := paintbox1.width;
  bitmap.height := paintbox1.height;
{$ifdef CONDITIONALEXPRESSIONS}  {D6+}
  form1.Position := poScreenCenter;
{$endif}
end;


{-------------------------------------------------------------}
procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  paintbox1.canvas.draw(0,0,bitmap);
end;

{-------------------------------------------------------------}
procedure TForm1.FormDestroy(Sender: TObject);
begin
  bitmap.free;
end;

{-------------------------------------------------------------}
procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: integer);
var
  px, py: double;
  sx,sy: string;
begin
  if not Z_Display or (CB_Fast.Checked<>ComputedWithFast) then begin
    label2.Caption := '';
    exit;
  end;
  with PaintBox1 do begin
    if CB_Fast.Checked then begin
      x := 2*x;
      y := 2*y;
      if (x >= Width) or (y >= Height) then begin
        label2.Caption := '';
        exit;
      end;
    end;
    px := x1 + x/pred(Width)*(x2-x1);
    py := y2 - (y/pred(Height))*(y2-y1);
  end;
  str(px:5:3,sx);
  str(abs(py):5:3,sy);
  if py < 0.0 then sx := sx + ' - ' + sy
  else  sx := sx + ' + ' + sy;
  label2.Caption := sx + ' i';
end;

{-------------------------------------------------------------}
procedure TForm1.Bt_HelpClick(Sender: TObject);
begin
  ShowMessage(HlpStr);
end;

{-------------------------------------------------------------}
procedure TForm1.copytoclipboardClick(Sender: TObject);
begin
  clipboard.Assign(bitmap);
end;

{-------------------------------------------------------------}
procedure TForm1.FormShow(Sender: TObject);
begin
{$ifdef CONDITIONALEXPRESSIONS}  {D6+}
  FuncCombo.AutoComplete := false;
{$endif}
end;

end.
