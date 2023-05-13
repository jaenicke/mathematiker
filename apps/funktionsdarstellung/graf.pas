unit graf;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, fktint, ComCtrls, Menus, clipbrd,
  printers, uableitung, zlib, gifimage;

type
  TFGraf = class(TForm)
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel7: TPanel;
    MainMenu1: TMainMenu;
    M02: TMenuItem;
    M_ksystem: TMenuItem;
    grundeinstellung: TMenuItem;
    aufloesunganpassen: TMenuItem;
    intervallverkleinern: TMenuItem;
    intervallvergroessern: TMenuItem;
    Panel4: TPanel;
    PaintBox1: TPaintBox;
    Panel9: TPanel;
    ed_f1: TEdit;
    ed_f2: TEdit;
    ed_f3: TEdit;
    ed_f4: TEdit;
    Bearbeiten1: TMenuItem;
    Vektorgrafikkopieren1: TMenuItem;
    Vektorgrafikdrucken1: TMenuItem;
    ed_von: TEdit;
    ed_bis: TEdit;
    Label9: TLabel;
    b_animation: TButton;
    Timer1: TTimer;
    c_punktA: TCheckBox;
    ed_A: TEdit;
    Label11: TLabel;
    rb_punkta: TRadioButton;
    rb_parameter: TRadioButton;
    c_normale: TCheckBox;
    N1: TMenuItem;
    Zeichnen1: TMenuItem;
    slinks: TSpeedButton;
    srechts: TSpeedButton;
    shoch: TSpeedButton;
    srunter: TSpeedButton;
    sgroesser: TSpeedButton;
    skleiner: TSpeedButton;
    Label12: TLabel;
    c_punktB: TCheckBox;
    ed_B: TEdit;
    Label10: TLabel;
    c_tangente: TCheckBox;
    c_sekante: TCheckBox;
    c_integral: TCheckBox;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    c_1ableitung: TCheckBox;
    c_2ableitung: TCheckBox;
    c_stammfunktion: TCheckBox;
    ed_breite: TEdit;
    UpDown1: TUpDown;
    ed_xvon: TEdit;
    ed_xbis: TEdit;
    ed_parameter: TEdit;
    b_zeichnen: TButton;
    Label14: TLabel;
    Label15: TLabel;
    sgrundeinstellung: TSpeedButton;
    c_nullstellen: TCheckBox;
    c_extrema: TCheckBox;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    c_wendepunkte: TCheckBox;
    button_fstrich: TButton;
    ed_delta: TEdit;
    Label16: TLabel;
    c_wendetangente: TCheckBox;
    c_f1: TCheckBox;
    c_f2: TCheckBox;
    c_f3: TCheckBox;
    c_f4: TCheckBox;
    c_schnittpunkte: TCheckBox;
    c_pktanzeige: TCheckBox;
    Mergebnis: TMemo;
    c_ergebnisliste: TCheckBox;
    N2: TMenuItem;
    M1: TMenuItem;
    rb_punktB: TRadioButton;
    M2: TMenuItem;
    spiegelungxachse: TMenuItem;
    spiegelungursprung: TMenuItem;
    spiegelungyachse: TMenuItem;
    N3: TMenuItem;
    nacheinanderausfuehrung: TMenuItem;
    funktionsaddition: TMenuItem;
    funktionsmultiplikation: TMenuItem;
    N4: TMenuItem;
    verschiebungxachse: TMenuItem;
    streckungxachse: TMenuItem;
    N5: TMenuItem;
    Umkehrkurvezuf1x1: TMenuItem;
    verschiebungyachse: TMenuItem;
    streckungyachse: TMenuItem;
    c_schar: TCheckBox;
    Label4: TLabel;
    ed_q: TEdit;
    UpDown5: TUpDown;
    ed_schardiff: TEdit;
    button_f2strich: TButton;
    N6: TMenuItem;
    MAchsen1: TMenuItem;
    MAchsen21: TMenuItem;
    M_rahmen: TMenuItem;
    M_winkel: TMenuItem;
    M_bogen: TMenuItem;
    N7: TMenuItem;
    m_raster: TMenuItem;
    m_mmraster: TMenuItem;
    m_terme: TMenuItem;
    m_farbe: TMenuItem;
    c_wertetabelle: TCheckBox;
    funktionsdivision1: TMenuItem;
    funktionssubtraktion1: TMenuItem;
    Speichern1: TMenuItem;
    SD1: TSaveDialog;
    Animation1: TMenuItem;
    procedure SEndeClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure slinksClick(Sender: TObject);
    procedure srechtsClick(Sender: TObject);
    procedure shochClick(Sender: TObject);
    procedure srunterClick(Sender: TObject);
    procedure sgroesserClick(Sender: TObject);
    procedure SkleinerClick(Sender: TObject);
    procedure SgrundClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TB1Change(Sender: TObject);
    procedure koordinatensystem(can: Tcanvas);
    procedure zeichnen(canvas: Tcanvas);
    procedure S31Click(Sender: TObject);
    procedure alsWMFkopieren1Click(Sender: TObject);
    procedure GrafikdruckenClick(Sender: TObject);
    procedure b_zeichnenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure b_animationClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UpDown2ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure UpDown3ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure UpDown4ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure button_fstrichClick(Sender: TObject);
    procedure Bergebnis(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListekopierenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Menueinstellungen(Sender: TObject);
    procedure UpDown5ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure button_f2strichClick(Sender: TObject);
    procedure Speichern1Click(Sender: TObject);
  private
    _x,_y,_xv,_yv:integer;
    fx,fy,wbx,wby:double;
    grafb,grafh:integer;
    ergebnisliste:tstringlist;
    procedure Darstellung(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGraf: TFGraf;
  ldatei : tstringlist;
  _x1,_x2,_y1,_y2:double;
  steigen : boolean;

implementation

var rahmen:boolean;
    punktziehen:byte;
    _xx0,_yy0,_xx1,_yy1,hi:integer;
    xdef1,xdef2:double;
    fww,fwf:double;
    ldateizeiger : integer =0;
    nullstelle,extrema,wendepunkte,schnittpunkte :array[0..25] of double;
    nullstellenzahl, extremazahl, wendepunktzahl, schnittpunktzahl :integer;
    farbig:boolean;

{$R *.DFM}

//Hilfsroutine formatierte Ausgabe
function _strkomma(a:double;b,c:byte):string;
var ks:string;
begin
  str(a:b:c,ks);
  if c<>0 then begin
    while (length(ks)>1) and (ks[length(ks)]='0') do delete(ks,length(ks),1);
    if (length(ks)>1) and (ks[length(ks)]='.') then delete(ks,length(ks),1);
  end;
  if ks='-0' then ks:='0';
  if pos('.',ks)>0 then ks[pos('.',ks)]:=',';
  _strkomma:=ks;
end;

//Hilfsroutine Eingabe
function ein_double(const edit:tedit):double;
var kk:string;
    i:integer;
    we:double;
begin
  kk:=edit.text;
  if kk<>'' then
    for i:=1 to length(kk) do kk[i]:=upcase(kk[i]);
  while pos(',',kk)<>0 do kk[pos(',',kk)]:='.';
  fehler:=0;
  we:=funktionswert(kk,1);
  if fehler<>0 then we:=0;
  ein_double:=we;
end;

//Hilfsdateien zum Lesen der Liste der Funktionen
function leof:boolean;
begin
  leof := (ldateizeiger>=ldatei.count)
end;
function lreadln:string;
var s:string;
begin
  if not leof then begin
    s:=ldatei[ldateizeiger];
    inc(ldateizeiger);
    lreadln:=s;
  end
  else lreadln:='';
end;
procedure lwriteln(const s:string);
begin
  ldatei.add(s);
  inc(ldateizeiger)
end;
procedure lclear;
begin
  ldatei.clear;
  ldateizeiger:=0;
end;
procedure lreset;
begin
  ldateizeiger:=0;
end;

//Hilfsroutinen zum Zusammenfassen von Termen
function vereinfachen(sabl:string):string;
var pkk,pkp:string;
    lnr,i:integer;
    liste:tstringlist;
  //Text aus Ressource lesen
  procedure DecompressStream(inpStream, outStream: TStream);
  var
    InpBuf, OutBuf: Pointer;
    OutBytes, sz: Integer;
  begin
    InpBuf := nil;
    OutBuf := nil;
    sz     := inpStream.Size - inpStream.Position;
    if sz > 0 then
      try
        GetMem(InpBuf, sz);
        inpStream.Read(InpBuf^, sz);
        DecompressBuf(InpBuf, sz, 0, OutBuf, OutBytes);
        outStream.Write(OutBuf^, OutBytes);
      finally
        if InpBuf <> nil then FreeMem(InpBuf);
        if OutBuf <> nil then FreeMem(OutBuf);
      end;
    outStream.Position := 0;
  end;
  procedure listelesen;
  var ms1: TResourcestream; ms2: TMemoryStream;
  begin
    ms1 := TResourceStream.Create(hinstance,'wverein','RT_RCDATA');
    try
      ms2 := TMemoryStream.Create;
      try
        DecompressStream(ms1, ms2);
        liste.LoadFromStream(ms2);
      finally
        ms2.Free;
      end;
    finally
      ms1.Free;
    end;
  end;
begin
  if length(sabl)>1 then begin
    sabl:='<'+sabl+'>';
    liste:=tstringlist.create;
    listelesen;
    for i:=1 to 2 do begin
      lnr:=0;
      repeat
        pkk:=liste[lnr]; inc(lnr);
        if lnr<liste.count then begin
          pkp:=liste[lnr];
          inc(lnr);
        end;
        while (pos(pkk,sabl)<>0) and (length(sabl)>1) do begin
          sabl:=copy(sabl,1,pos(pkk,sabl)-1)+pkp+
          copy(sabl,pos(pkk,sabl)+length(pkk),255);
        end;
      until lnr>=liste.count;
    end;
    liste.free;
    delete(sabl,1,1);
    delete(sabl,length(sabl),1);
  end;
  vereinfachen:=sabl;
end;

//zusammengefasste Ableitung
function zableitung(const s:string):string;
begin
  zableitung:=vereinfachen(ableitung(s));
end;

procedure TFGraf.SEndeClick(Sender: TObject);
begin
  close;
end;

procedure TFGraf.PaintBox1Paint(Sender: TObject);
begin
  darstellung(sender);
  if Mergebnis.visible then Mergebnis.lines.assign(ergebnisliste);
end;

//Darstellung des Koordinatensystems
procedure tfgraf.koordinatensystem(can:tcanvas);
var k:string;
    sc,sx,sy:integer;
    kodiff:double;

//Pfeildarstellung
procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:double;
    x,y:integer;
    pfe:array[0..3] of tpoint;
    wcos,wsin:extended;
begin
  can.moveto(a,b);
  can.lineto(c,d);
  if (a<>c) or (b<>d) then begin
    if (c-a)<>0 then wi:=pi-arctan((d-b)/(c-a))
    else begin
      if d<b then wi:=-pi/2
             else wi:=pi/2;
    end;
    wsin:=sin(wi-xwi);
    wcos:=cos(wi-xwi);
    x:=round(14*wcos);
    y:=round(14*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[0].x:=c+x;
    pfe[0].y:=d-y;
    pfe[1].x:=c;
    pfe[1].y:=d;
    wsin:=sin(wi+xwi);
    wcos:=cos(wi+xwi);
    x:=round(14*wcos);
    y:=round(14*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[2].x:=c+x;
    pfe[2].y:=d-y;
    can.brush.style:=bssolid;
    can.brush.color:=can.pen.color;
    can.polygon(slice(pfe,3));
    can.brush.style:=bsclear;
  end;
end;
//Koordinatentransformation
function  malfx(const we:double):integer;
begin
  malfx:=round(we*fx+_x);
end;
function  malfy(const we:double):integer;
begin
  malfy:=round(-we*fy+_y);
end;
//mm-Gitter
procedure milliwaagerecht;
begin
  hi:=malfx(fww*fwf);
  can.moveto(hi,0);
  can.lineto(hi,grafh);
end;
procedure millisenkrecht;
begin
  hi:=malfy(-fww);
  can.moveto(0,hi);
  can.lineto(grafb,hi);
end;
//Gitter
procedure waagerecht;
begin
  can.pen.color:=$00d0d0d0;//clltgray;
  can.pen.style:=psdot;
  can.moveto(hi,0);
  can.lineto(hi,grafh);
  can.pen.color:=clblack;
  can.pen.style:=pssolid;
end;
procedure waa2;
var zuzu:integer;
    k:string;
begin
  hi:=malfx(fww*fwf);
  if M_winkel.checked or M_bogen.checked then
    if not M_bogen.checked then begin
      k:=_strkomma(fww*45,4,2);
      k:=k+'°'
    end
    else k:=_strkomma(fww/4,4,2)
  else k:=_strkomma(fww,4,3);
  if M_raster.checked then waagerecht;
  if M_rahmen.checked then begin
    can.moveto(hi,0);
    can.lineto(hi,5);
    can.moveto(hi,grafh);
    can.lineto(hi,grafh-6);
    can.textout(hi,6,k);
  end;
  if (Machsen1.checked) and (_y>-6) and (_y+6<grafh) and (hi<grafb-26) then begin
    can.moveto(hi,_y+6);
    can.lineto(hi,_y-6);
    can.textout(hi-10,_y+6,k);
    if M_bogen.checked then begin
      zuzu:=can.textwidth(k);
      can.font.name:='Symbol';
      can.textout(hi-10+zuzu+2,_y+6,'p');
      can.font.name:='Verdana';
    end;
  end;
end;
procedure senkrecht;
begin
  can.pen.color:=$00d0d0d0;//clltgray;
  can.pen.style:=psdot;
  can.moveto(0,hi);
  can.lineto(grafb,hi);
  can.pen.color:=clblack;
  can.pen.style:=pssolid;
end;
procedure sen2;
var zuzu:integer;
begin
  hi:=malfy(-fww);
  k:=_strkomma(-fww,4,3);
  if M_raster.checked then senkrecht;
  if M_rahmen.checked then begin
    can.textout(2,hi,k);
    can.moveto(0,hi);
    can.lineto(5,hi);
    can.moveto(grafb-6,hi);
    can.lineto(grafb,hi);
  end;
  if (Machsen1.checked) and (_x>16) and (_x-16<grafb) and (hi>26) then begin
    can.moveto(_x-6,hi);
    can.lineto(_x+6,hi);
    zuzu:=can.textextent(k).cx;
    can.textout(_x-6-zuzu,hi,k);
  end;
end;

//KSystem
begin
  can.font.color:=clblack;
  if not (M_winkel.checked or M_bogen.checked) then fwf:=1
                                               else fwf:=pi/4;
  //mm-Raster
  if m_mmraster.checked then begin
    can.pen.color:=$00f0f0f0;
    sc:=1;
    sy:=trunc(wby/20)+1;
    while abs(malfy(0)-malfy(sy/sc))>75 do begin
      sc:=2*sc;
      if sc=8 then sc:=10;
      if sc=80 then sc:=100;
    end;
    if sy<=0 then sy:=trunc(wby/20)+1;
    fww:=sy/sc;
    while malfy(-fww)>grafh do fww:=fww-sy/sc;
    while malfy(-fww)>0 do begin
      millisenkrecht;
      fww:=fww-sy/sc/5;
    end;
    fww:=sy/sc;
    while malfy(-fww)<0 do fww:=fww+sy/sc;
    while malfy(-fww)<grafb do begin
      millisenkrecht;
      fww:=fww+sy/sc/5;
    end;
    sc:=1;
    sx:=trunc(wbx/20)+1;
    while abs(malfx(0)-malfx(sx/sc))>80 do begin
      sc:=2*sc;
      if sc=8 then sc:=10;
      if sc=80 then sc:=100;
    end;
    if sx<=0 then sx:=trunc(wbx/20)+1;
    fww:=sx/sc;
    while malfx(fww*fwf)>grafb do fww:=fww-sx/sc/5;
    while malfx(fww*fwf)>0 do begin
      milliwaagerecht;
      fww:=fww-sx/sc/5;
    end;
    fww:=sx/sc;
    while malfx(fww*fwf)<0 do fww:=fww+sx/sc/5;
    while malfx(fww*fwf)<grafb do begin
      milliwaagerecht;
      fww:=fww+sx/sc/5;
    end;
    can.pen.color:=clblack;
  end;
  //Achsen
  if Machsen1.checked then begin
    if MAchsen21.checked then can.pen.width:=2
                         else can.pen.width:=1;
    can.pen.color:=clblack;
    if _x1*_x2<=0 then begin
      xpfeilvoll(can,_x,grafh-10,_x,10);
      can.pen.width:=1;
      can.brush.style:=bsclear;
      can.textout(_x-10-can.textwidth('y'),10,'y');
    end;
    if _y1*_y2<=0 then begin
      if MAchsen21.checked then can.pen.width:=2
                           else can.pen.width:=1;
      xpfeilvoll(can,10,_y,grafb-10,_y);
      can.pen.width:=1;
      can.brush.style:=bsclear;
      can.textout(grafb-10-can.textwidth('x'),_y-25,'x');
    end;
    can.pen.width:=1;
  end else begin
    if M_raster.checked then begin
      can.pen.width:=1;
      can.pen.color:=$00d0d0d0;//clltgray;
      can.pen.style:=psdot;
      if _x1*_x2<=0 then begin
        can.moveto(_x,grafh-10);
        can.lineto(_x,10);
      end;
      if _y1*_y2<=0 then begin
        can.moveto(10,_y);
        can.lineto(grafb-10,_y);
      end;
      can.pen.style:=pssolid;
    end;
  end;
  _xv:=0;
  _yv:=0;

  sc:=1;
  sx:=trunc(wbx/20)+1;
  while abs(malfx(0)-malfx(sx/sc))>80 do begin
    sc:=2*sc;
    if sc=8 then sc:=10;
    if sc=80 then sc:=100;
  end;
  if sx<=0 then sx:=trunc(wbx/20)+1;
  if (Machsen1.checked) and (_y>-6) and (_y+6<grafh) and
     (malfx(0)>10) and (malfx(0)-10<grafb) then can.textout(malfx(0)-10,_y+6,'0');
  if M_winkel.checked or M_bogen.checked then sc:=sc-1;
  if sc=0 then sc:=1;

  kodiff:=-sx/sc;
  fww:=kodiff;
  while malfx(fww*fwf)>grafb do fww:=fww+kodiff;
  while malfx(fww*fwf)>0 do begin
    waa2;
    fww:=fww+kodiff;
  end;
  kodiff:=sx/sc;
  fww:=kodiff;
  while malfx(fww*fwf)<0 do fww:=fww+kodiff;
  while malfx(fww*fwf)<grafb do begin
    waa2;
    fww:=fww+kodiff;
  end;
  sc:=1;
  sy:=trunc(wby/20)+1;
  while abs(malfy(0)-malfy(sy/sc))>75 do begin
    sc:=2*sc;
    if sc=8 then sc:=10;
    if sc=80 then sc:=100;
  end;
  if sy<=0 then sy:=trunc(wby/20)+1;

  kodiff:=-sy/sc;
  fww:=kodiff;
  while malfy(-fww)>grafh do fww:=fww+kodiff;
  while malfy(-fww)>0 do begin
    sen2;
    fww:=fww+kodiff;
  end;
  kodiff:=sy/sc;
  fww:=kodiff;
  while malfy(-fww)<0 do fww:=fww+kodiff;
  while malfy(-fww)<grafh do begin
    sen2;
    fww:=fww+kodiff;
  end;
  can.font.color:=clblack;
end;

//Funktion zeichnen
procedure tFGraf.zeichnen(canvas:tcanvas);
var s1,ts,ns,f5,f2,fabl,fabl2:string;
    funktionz,funktions,i:integer;
    pixelfarbe:longint;
    kx,ky,kx2,ky2,tm,tn,diff:double;
    wx,wy:integer;
    palt,scharp,schardiff:double;
    termausgabe:boolean;

//Farbe der Funktion
procedure farbe(z:integer);
begin
  inc(funktionz);
  if farbig then begin
    case z+1 mod 8 of
      1 : Canvas.pen.color:=clblue;
      2 : Canvas.pen.color:=clred;
      3 : Canvas.pen.color:=clgreen;
      4 : Canvas.pen.color:=clfuchsia;
      5 : canvas.pen.color:=clnavy;
      6 : Canvas.pen.color:=cllime;
      7 : canvas.pen.color:=clblack;
     else Canvas.pen.color:=clmaroon;
    end;
  end
  else canvas.pen.color:=clblack;
  canvas.Font.color:=Canvas.pen.color;
  pixelfarbe:=Canvas.pen.color;
  canvas.pen.width:=updown1.position;
end;

//Transformation von Koordinaten
function subx(x:integer):double;
begin
  subx:=(x-_x)/fx;
end;
function malfxr(const we:double):double;
begin
  malfxr:=we*fx+_x;
end;
function malfyr(const we:double):double;
begin
  malfyr:=-we*fy+_y;
end;
//Kontrolle auf Überlauf
function testwe(const we:double):boolean;
begin
  testwe:=abs(we)<maxint
end;

//Stammfunktion durch O
procedure stamm(const fkt:string);
var x,xhh,y:integer;
    we,we1,we2:double;
begin
  if fkt<>'' then begin
    x:=0;
    we2:=0;
    repeat
      we2:=we2-funktionswert(fkt,(1.0*x-_x)/fx)/fx;
      inc(x);
    until ((fehler=0) or (x>grafb)) and (subx(x)>xdef1);
    xhh:=x;
    we2:=0;
    for x:=xhh to _x do
      we2:=we2-funktionswert(fkt,(1.0*x-_x)/fx)/fx;
    we1:=-we2-funktionswert(fkt,-_x/fx)/fx;
    if testwe(we1)
      then canvas.moveto(xhh,round(malfyr(-we1)));
    we1:=-we2;
    for x:=xhh to grafb do begin
      fehler:=0;
      we1:=we1-funktionswert(fkt,(1.0*x-_x)/fx)/fx;
      if subx(x)>xdef2 then break;
      we:=malfyr(-we1);
      if testwe(we) and (fehler=0) then begin
        y:=round(we);  //trunc
        if (y<-100) or (y>grafh+100) then
          canvas.moveto(x,y)
        else
          canvas.lineto(x,y);
      end else
        canvas.moveto(x,_y)
    end;
  end;
  if termausgabe then canvas.textout(16,funktionz*16,'Stammfunktion zu f1');
end;

//Ableitungsfunktion und weitere
procedure fapaint(fkt:string;ueber:string;num:byte);
var we,we2,we3,kon:double;
    x,y:longint;
//Sonderfunktionen
procedure sonder;
begin
 case num of
   3 : we:=malfyr(funktionswert(fkt,-subx(x)));
   4 : we:=malfyr(-funktionswert(fkt,subx(x)));
   5 : we:=malfyr(-funktionswert(fkt,-subx(x)));
   6 : we:=malfyr(funktionswert(fkt,funktionswert(fkt,subx(x))));
   7 : we:=malfyr(funktionswert(fkt,subx(x)+p));
   8 : we:=malfyr(funktionswert(fkt,subx(x)*p));
   9 : we:=malfyr(funktionswert(fkt,subx(x))+p);
  10 : we:=malfyr(funktionswert(fkt,subx(x))*p);
  end;
end;
procedure ber1;
begin
  we:=-funktionswert(fkt,subx(x));
  we2:=-funktionswert(fkt,(x+2-_x)/fx);
  we3:=-funktionswert(fkt,(1+x-_x)/fx);
  we:=(we2+we-2*we3)*kon+_y;
end;
begin
  farbe(funktionz);
  if (num<3) then begin
    x:=-10;
    repeat
      inc(x);
      we:=-funktionswert(fkt,subx(x));
    until (((fehler<>1) and (fehler<>2)) or (x>grafb+10)) and (subx(x)>xdef1);

    if num=1 then begin
      kon:=fx*fy;
      we2:=-funktionswert(fkt,(1+x-_x)/fx);
      we:=(we2+funktionswert(fkt,subx(x)))*kon+_y;
      if testwe(we) then canvas.moveto(x,round(we));            ////trunc
      we:=we2;
    end;
    if num=2 then begin
      kon:=fx*fx*fy;
      ber1;
      if testwe(we) then canvas.moveto(x,round(we)); ///trunc
    end;
    x:=x+1;
    repeat
      if num=1 then begin
        we2:=-funktionswert(fkt,(x+1-_x)/fx);
        we:=(we2-we)*kon+_y;
      end;
      if num=2 then ber1;
      if testwe(we) then begin
        y:=round(we); //trunc
        if (y<-200) or (y>grafh+200) or (fehler>1) then
          if (fehler=3) then canvas.pixels[x,y]:=pixelfarbe
                        else canvas.moveto(x,y)
        else begin
          if M_winkel.checked or M_bogen.checked then canvas.pixels[x,y]:=pixelfarbe
                                                 else canvas.lineto(x,y);
        end;
      end;
      we:=we2;
      inc(x);
    until (x>grafb) or (subx(x)>xdef2);
    if termausgabe then canvas.textout(16,funktionz*16,ueber);
  end else begin
    x:=-2;
    repeat
      inc(x);
      sonder;
    until (((fehler<>1) and (fehler<>2)) or (x>grafb+10)) and (subx(x)>xdef1);
    if testwe(we) then canvas.moveto(x,round(we))
    else  //trunc
      if we>maxint then canvas.moveto(x,-1)
                   else canvas.moveto(x,800);
    inc(x);
    repeat
      sonder;
      if testwe(we) then begin
        y:=round(we); //trunc
        if (y<-200) or (y>grafh+200) or (fehler>1) then
          if (fehler=3) then canvas.Pixels[x,y]:=pixelfarbe
                        else canvas.moveto(x,y)
        else
          if M_winkel.checked or M_bogen.checked
            then canvas.Pixels[x,y]:=pixelfarbe
            else canvas.lineto(x,y);
      end
      else
        if we>maxint then canvas.moveto(x,-1)
                     else canvas.moveto(x,1000);
      inc(x);
    until (x>grafb+10) or (subx(x)>xdef2);
    if termausgabe then canvas.textout(16,funktionz*16,ueber);
  end;
end;

//Zeichenroutine einer Funktion
procedure funktion(const s2:string);
var x,y,yalt:integer;
    we:double;
//Kontrolle des Funktionswertes, inkl. Polstellen
procedure testzeichnen;
begin
  if testwe(we) then begin
    y:=round(we);
    if (abs(yalt-y)>grafh/2-10) then fehler:=2;
    if (y<-200) or (y>grafh+200) or (fehler>1) then
      if (fehler>=3) then canvas.pixels[x,y]:=canvas.pen.color
                     else canvas.moveto(x,y)
    else
      canvas.lineto(x,y);
  end
  else
    if we>maxint then begin
      canvas.moveto(x,-1);
      y:=-1;
    end else begin
      canvas.moveto(x,1000);
      y:=1000;
    end;
  inc(x);
  yalt:=y;
end;
begin
  farbe(funktionz);
  x:=-2;
  yalt:=-100;
  //Abfangen von nichtdefnierten Argumenten
  repeat
    inc(x);
    we:=malfyr(funktionswert(s2,subx(x)));
  until (((fehler<>1) and (fehler<>2)) or (x>grafb+10)) and (subx(x)>xdef1);
  //erste gültiger Anfangswert
  if testwe(we) then begin
    canvas.moveto(x,round(we));
    yalt:=round(we)
  end else //round
    if we>maxint then begin
      canvas.moveto(x,-200);
      yalt:=-200;
    end else begin
      canvas.moveto(x,grafh+200);
      yalt:=grafh+200;
    end;
  inc(x);
  //Zeichnen bis Fensterbreite
  repeat
    we:=malfyr(funktionswert(s2,subx(x)));
    testzeichnen;
  until (x>grafb+5) or (subx(x)>xdef2);
  if termausgabe and (s2<>' ') then
    canvas.textout(16,funktionz*16,'Y = '+s2);
end;

//Markieren der Fläche
procedure unterfuellen;
var hi,ix,iy,we1,we2:double;
begin
  ix:=kx2;
  iy:=kx;
  canvas.pen.color:=$000fffe;
  if ix<iy then begin
    hi:=malfxr(ix)+1;
    if hi<0 then hi:=-2;
    repeat
      we1:=malfyr(funktionswert(s1,(hi-_x)/fx));
      if we1<0 then we1:=-1;
      we2:=malfyr(funktionswert(f2,(hi-_x)/fx));
      if we2<0 then we2:=-1;
      canvas.moveto(round(hi),trunc(we1));
      canvas.lineto(round(hi),trunc(we2));//_y);
      hi:=hi+2;
    until (hi>=malfxr(iy)) or (hi>grafb);
  end else begin
    hi:=malfxr(ix)+1;
    if hi<0 then hi:=-2;
    repeat
      we1:=malfyr(funktionswert(s1,(hi-_x)/fx));
      if we1<0 then we1:=-1;
      we2:=malfyr(funktionswert(f2,(hi-_x)/fx));
      if we2<0 then we2:=-1;
      canvas.moveto(round(hi),trunc(we1));
      canvas.lineto(round(hi),trunc(we2));
      hi:=hi-2;
    until (hi<=malfxr(iy)) or (hi<0);
  end;
end;

//Flächen- und Integralberechnung
procedure gausslegendre;
var ss,sf,hi,ws,ix,iy,we:double;
function st(fx,xx:double):double;
begin
  st:=fx*(funktionswert(s1,ws*xx/2+hi)-funktionswert(f2,ws*xx/2+hi));
end;
function st2(fx,xx:double):double;
begin
  st2:=fx*abs(funktionswert(s1,ws*xx/2+hi)-funktionswert(f2,ws*xx/2+hi));
end;
begin
  ix:=kx2;
  iy:=kx;
  if ix<>iy then begin
    if ix>iy then begin
       hi:=ix; ix:=iy; iy:=hi;
    end;
    ws:=abs(iy-ix)/50;
    we:=ix;
    ss:=0;
    sf:=0;
    repeat
      hi:=we+ws/2;
      ss:=ss+ws/5*(st(1,sqrt(-sqrt(11)/12+5/12))+st(1,-sqrt(-sqrt(11)/12+5/12))
          +st(1,sqrt(sqrt(11)/12+5/12))+st(1,-sqrt(sqrt(11)/12+5/12))
          +(funktionswert(s1,hi)-funktionswert(f2,hi)));
      sf:=sf+ws/5*(st2(1,sqrt(-sqrt(11)/12+5/12))+st2(1,-sqrt(-sqrt(11)/12+5/12))
          +st2(1,sqrt(sqrt(11)/12+5/12))+st2(1,-sqrt(sqrt(11)/12+5/12))
          +abs(funktionswert(s1,hi)-funktionswert(f2,hi)));
      we:=we+ws;
    until we>iy-ws/2;
    label13.caption:='= '+_strkomma(ss,1,2);
    label15.caption:='= '+_strkomma(sf,1,2);
    if f2='0' then
      ergebnisliste.add('Fläche unter f1 von ('+_strkomma(ix,1,2)+' | '+_strkomma(iy,1,2)+')')
    else
      ergebnisliste.add('Fläche zwischen f1 und f2 von ('+_strkomma(ix,1,2)+' | '+_strkomma(iy,1,2)+')');
    ergebnisliste.add(#9+_strkomma(sf,1,2));
    if f2='0' then
      ergebnisliste.add('Bestimmtes Integral f1 von ('+_strkomma(ix,1,2)+' | '+_strkomma(iy,1,2)+')')
    else
      ergebnisliste.add('Bestimmtes Integral f1-f2 von ('+_strkomma(ix,1,2)+' | '+_strkomma(iy,1,2)+')');
    ergebnisliste.add(#9+_strkomma(ss,1,2));
  end;
end;

//Umkehrkurve
procedure umkehr(const s2:string);
var we:double;
    x,y:integer;
begin
  x:=0;
  repeat
    we:=malfxr(funktionswert(s2,-(x-_y)/fy));
    if testwe(we) then
      canvas.moveto(round(we),x);
    inc(x);
  until (fehler=0) or (x>grafh+10);
  repeat
    we:=malfxr(funktionswert(s2,-(x-_y)/fy));
    if testwe(we) then begin
      y:=round(we); //round
      if (y<-200) or (y>grafb+200) or (fehler>1) then
        if (fehler=3) then
          canvas.Pixels[y,x]:=canvas.pen.color
        else
          canvas.moveto(y,x)
      else
        if fehler<>1 then canvas.lineto(y,x)
                     else canvas.moveto(y,x);
    end;
    inc(x);
  until x>grafh+10;
  if termausgabe then canvas.textout(16,funktionz*16,'Umkehrkurve');
end;

//Schnelles Brent-Verfahren
function zbrent(x1,x2,tol:double; itmax:integer): double;
//label 99;
const
   eps=3.0e-6;
var
   a,b,c,d,e: double;
   min1,min2,min: double;
   fa,fb,fc,p,q,r: double;
   s,tol1,xm: double;
   iter: integer;
begin
  d := 0; e:= 0; c:=0;
  a := x1;
  b := x2;
  fa := funktionswert(f5,a);
  fb := funktionswert(f5,b);
  fc := fb;
  for iter := 1 to itmax do begin
    if (fb*fc > 0.0) then begin
      c := a;
      fc := fa;
      d := b-a;
      e := d
    end;
    if (abs(fc) < abs(fb)) then begin
      a := b;
      b := c;
      c := a;
      fa := fb;
      fb := fc;
      fc := fa
    end;
    tol1 := 2.0*eps*abs(b)+0.5*tol;
    xm := 0.5*(c-b);
    if ((abs(xm) <= tol1) OR (fb = 0.0)) then begin
      zbrent := b; exit end;
      if ((abs(e) >= tol1) AND (abs(fa) > abs(fb))) then begin
        s := fb/fa;
        if (a = c)  then begin
          p := 2.0*xm*s;
          q := 1.0-s
        end else begin
          q := fa/fc;
          r := fb/fc;
          p := s*(2.0*xm*q*(q-r)-(b-a)*(r-1.0));
          q := (q-1.0)*(r-1.0)*(s-1.0)
        end;
        if (p > 0.0) then  q := -q;
        p := abs(p);
        min1 := 3.0*xm*q-abs(tol1*q);
        min2 := abs(e*q);
        if (min1 < min2) then min := min1 else min := min2;
        if (2.0*p < min) then begin
          e := d;
          d := p/q
        end else begin
          d := xm;
          e := d
        end
      end else begin
        d := xm;
        e := d
      end;
      a := b;
      fa := fb;
      if (abs(d) > tol1) then begin
        b := b+d
      end else begin
        if (xm > 0) then begin
          b := b+abs(tol1)
        end else begin
          b := b-abs(tol1)
        end
      end;
      fb := funktionswert(f5,b);
    end;
  zbrent := b;
end;

procedure nullstellensuche;
var  a,b,ix,iy,w1,w2,w3,wl,ws,mittel:double;
//Nullstellen suchen
procedure nullstellen;
begin
   wl:=ix;
   ws:=(iy-ix)/1000;
   w1:=funktionswert(f5,wl);
   while (fehler=2) and (wl<iy) do begin
     wl:=wl+ws;
     w1:=funktionswert(f5,wl)
   end;
   if fehler=0 then begin
     wl:=wl+ws;
     w2:=funktionswert(f5,wl+ws);
     repeat
       w3:=funktionswert(f5,wl+2*ws);
       if (w1*w2<0) or ((w2-w1)*(w3-w2)<0) then begin
         if (abs(w1*w2)<100) then begin
           mittel:=zbrent(wl,wl+ws,(1.0e-6)*(wl+wl+ws)/2.0,50);
           if abs(funktionswert(f5,mittel))<1e-4 then begin
             nullstelle[nullstellenzahl]:=mittel;
             inc(nullstellenzahl);
             if nullstellenzahl>=24 then exit;
           end;
         end;
       end;
       wl:=wl+ws;
       w1:=w2;
       w2:=w3;
     until wl>iy;
   end;
end;
begin
  a:=ein_double(ed_von);
  b:=ein_double(ed_bis);
  p:=ein_double(ed_parameter);
  f5:=ed_f1.text;
  if f5<>'' then begin
    ix:=a-0.0001;
    iy:=b+0.0001;
    if abs(ix)>100 then ix:=-5.0001;
    if abs(iy)>100 then iy:=5.0001;
    nullstellenzahl:=0;
    nullstellen;
  end;
end;

//Extrema suchen
procedure extremasuche;
var  a,b,ix,iy,w1,w2,w3,wl,ws,mittel:double;
procedure extremstellen;
begin
  wl:=ix;
  ws:=(iy-ix)/2500;
  w1:=funktionswert(f5,wl);
  while (fehler=2) and (wl<iy) do begin
    wl:=wl+ws;
    w1:=funktionswert(f5,wl)
  end;
  if fehler=0 then begin
    wl:=wl+ws;
    w2:=funktionswert(f5,wl+ws);
    repeat
      w2:=funktionswert(f5,wl+ws);
      w3:=funktionswert(f5,wl+2*ws);
      if ((w2-w1)*(w3-w2)<0) then begin
        if (abs(w1*w2)<100) then begin
          mittel:=zbrent(wl,wl+ws,(1.0e-6)*(wl+wl+ws)/2.0,100);
          extrema[extremazahl]:=mittel;
          inc(extremazahl);
          if extremazahl>=24 then exit;
        end;
      end;
      wl:=wl+ws;
      w1:=w2;
      w2:=w3;
    until wl>iy;
  end;
end;
begin
  a:=ein_double(ed_von);
  b:=ein_double(ed_bis);
  p:=ein_double(ed_parameter);
  f5:=ed_f1.text;
  if f5<>'' then begin
    ix:=a-0.0001;
    iy:=b+0.0001;
    if abs(ix)>100 then ix:=-5.0001;
    if abs(iy)>100 then iy:=5.0001;
    extremazahl:=0;
    extremstellen;
  end;
end;

//Wendestellen suchen
procedure wendepunktsuche;
var  a,b,ix,iy,w1,w2,wl,ws,mittel:double;
procedure wendestellen;
begin
  wl:=ix;
  ws:=(iy-ix)/1000;
  w1:=funktionswert(f5,wl);
  while (fehler=2) and (wl<iy) do begin
    wl:=wl+ws;
    w1:=funktionswert(f5,wl)
  end;
  if fehler=0 then begin
    wl:=wl+ws;
    w2:=funktionswert(f5,wl+ws);
    repeat
      w2:=funktionswert(f5,wl+ws);
      if (w1*w2<0) then begin
        if (abs(w1*w2)<100) then begin
          mittel:=zbrent(wl,wl+ws,(1.0e-6)*(wl+wl+ws)/2.0,100);
          wendepunkte[wendepunktzahl]:=mittel;
          inc(wendepunktzahl);
          if wendepunktzahl>=24 then exit;
        end;
      end;
      wl:=wl+ws;
      w1:=w2;
    until wl>iy;
  end;
end;
begin
  a:=ein_double(ed_von);
  b:=ein_double(ed_bis);
  p:=ein_double(ed_parameter);
  f5:=fabl2;
  if f5<>'' then begin
    ix:=a-0.0001;
    iy:=b+0.0001;
    if abs(ix)>100 then ix:=-5.0001;
    if abs(iy)>100 then iy:=5.0001;
    wendepunktzahl:=0;
    wendestellen;
  end;
end;

//Schnittpunkte f1,f2 suchen
procedure schnittpunktsuche;
var  a,b,ix,iy,w1,w2,w3,wl,ws,mittel:double;
procedure schnitt;
begin
  wl:=ix;
  ws:=(iy-ix)/1000;
  w1:=funktionswert(f5,wl);
  while (fehler=2) and (wl<iy) do begin
    wl:=wl+ws;
    w1:=funktionswert(f5,wl)
  end;
  if fehler=0 then begin
    wl:=wl+ws;
    w2:=funktionswert(f5,wl+ws);
    repeat
      w3:=funktionswert(f5,wl+2*ws);
      if (w1*w2<0) or ((w2-w1)*(w3-w2)<0) then begin
        if (abs(w1*w2)<100) then begin
          mittel:=zbrent(wl,wl+ws,(1.0e-6)*(wl+wl+ws)/2.0,50);
          if abs(funktionswert(f5,mittel))<1e-4 then begin
            schnittpunkte[schnittpunktzahl]:=mittel;
            inc(schnittpunktzahl);
            if schnittpunktzahl>=24 then exit;
          end;
        end;
      end;
      wl:=wl+ws;
      w1:=w2;
      w2:=w3;
    until wl>iy;
  end;
end;
begin
  a:=ein_double(ed_von);
  b:=ein_double(ed_bis);
  p:=ein_double(ed_parameter);
  f5:=ed_f1.text+'-('+ed_f2.text+')';
  if f5<>'' then begin
    ergebnisliste.add('Schnittpunkte zwischen f1 und f2');
    ergebnisliste.add('Funktion f2: Y = '+ed_f2.text);
    ix:=a-0.0001;
    iy:=b+0.0001;
    if abs(ix)>100 then ix:=-5.0001;
    if abs(iy)>100 then iy:=5.0001;
    schnittpunktzahl:=0;
    schnitt;
  end;
end;

begin
  //Definitionsbereich
  ergebnisliste.clear;
  xdef1:=ein_double(ed_xvon);
  xdef2:=ein_double(ed_xbis);
  kx:=ein_double(ed_A);
  kx2:=ein_double(ed_B);
  termausgabe:=m_terme.checked;
  funktionz:=0;
  funktions:=0;

  if ldatei.count=0 then exit;
  lreset;
  //alle Funktionen zeichnen
  repeat
    s1:=lreadln;
    inc(funktionz);
    ergebnisliste.add('Funktion Y = '+s1);
    if funktionz=1 then begin
      fabl:=zableitung(s1);
      fabl2:=zableitung(fabl);
      ergebnisliste.add('Bereich ('+ed_von.text+' | '+ed_bis.text+')');
      ergebnisliste.add('1.Ableitung');
      ergebnisliste.add('Y = '+fabl);
      ergebnisliste.add('2.Ableitung');
      ergebnisliste.add('Y = '+fabl2);
    end;

  //evtl. Fläche füllen
  if (funktionz=1) and c_integral.checked then begin
    if c_f2.checked then begin
      f2:=ed_f2.text;
      if f2='' then f2:='0';
    end
    else f2:='0';
    unterfuellen;
    koordinatensystem(canvas);
    gausslegendre;
  end;
  //Funktion zeichnen
  dec(funktionz);
  funktion(s1);

  if funktionz=1 then begin
    //Nullstellen
    if c_nullstellen.checked then begin
      nullstellensuche;
      if nullstellenzahl>0 then begin
        ns:='';
        canvas.pen.color:=clblack;
        canvas.brush.color:=claqua;
        ergebnisliste.add('Nullstellen');
        for i:=0 to nullstellenzahl-1 do begin
          wx:=round(malfxr(nullstelle[i]));
          canvas.ellipse(wx-4,_y-4,wx+5,_y+5);
          ns:=ns+_strkomma(nullstelle[i],1,2)+' | ';
          ergebnisliste.add(#9+_strkomma(nullstelle[i],1,2));
        end;
        canvas.brush.color:=clwhite;
        delete(ns,length(ns)-2,20);
        if c_pktanzeige.checked then canvas.textout(16,grafh-30-funktions*16,'Nullstellen: '+ns);
        inc(funktions);
      end;
    end;

    //Extrema
    if c_extrema.checked then begin
      extremasuche;
      if extremazahl>0 then begin
        ns:='';
        canvas.pen.color:=clblack;
        canvas.brush.color:=clfuchsia;
        ergebnisliste.add('Extrempunkte');
        for i:=0 to extremazahl-1 do begin
          wx:=round(malfxr(extrema[i]));
          ky:=funktionswert(s1,extrema[i]);
          wy:=round(malfyr(ky));
          canvas.ellipse(wx-4,wy-4,wx+5,wy+5);
          ns:=ns+'('+_strkomma(extrema[i],1,2)+';'+_strkomma(ky,1,2)+') | ';
          if funktionswert(fabl2,extrema[i])>0
          then
            ergebnisliste.add(#9'Minimum'#9+'('+_strkomma(extrema[i],1,2)+';'+_strkomma(ky,1,2)+')')
          else
            ergebnisliste.add(#9'Maximum'#9+'('+_strkomma(extrema[i],1,2)+';'+_strkomma(ky,1,2)+')')
        end;
        canvas.brush.color:=clwhite;
        delete(ns,length(ns)-2,20);
        if c_pktanzeige.checked then canvas.textout(16,grafh-30-funktions*16,'Extrempunkte: '+ns);
        inc(funktions);
      end;
    end;

    //Wendestellen
    if c_wendepunkte.checked or c_wendetangente.checked then begin
      wendepunktsuche;
      if wendepunktzahl>0 then begin
        ergebnisliste.add('Wendepunkte');
        ns:='';
        for i:=0 to wendepunktzahl-1 do begin
          ky:=funktionswert(s1,wendepunkte[i]);
          //Wendetangenten
          if c_wendetangente.checked then begin
            canvas.brush.color:=clwhite;
            tm:=(funktionswert(s1,wendepunkte[i]+0.001)-ky)/0.001;
            tn:=ky-wendepunkte[i]*tm;
            ts:=_strkomma(tm,1,4)+'*X';
            if tn>0 then ts:=ts+'+'+_strkomma(tn,1,4)
                    else ts:=ts+_strkomma(tn,1,4);
            funktion(ts);
          end;
          if c_wendepunkte.checked then begin
            canvas.pen.color:=clblack;
            canvas.brush.color:=$008080ff;
            wx:=round(malfxr(wendepunkte[i]));
            wy:=round(malfyr(ky));
            canvas.ellipse(wx-4,wy-4,wx+5,wy+5);
            ns:=ns+'('+_strkomma(wendepunkte[i],1,2)+';'+_strkomma(ky,1,2)+') | ';
            ergebnisliste.add(#9+'('+_strkomma(wendepunkte[i],1,2)+';'+_strkomma(ky,1,2)+')');
          end;
        end;
        canvas.brush.color:=clwhite;
        canvas.font.color:=clred;
        if c_wendepunkte.checked then begin
          delete(ns,length(ns)-2,20);
          if c_pktanzeige.checked then canvas.textout(16,grafh-30-funktions*16,'Wendepunkte: '+ns);
          inc(funktions);
        end;
      end;
    end;
    //Schnittpunkte
    if c_schnittpunkte.checked then begin
      schnittpunktsuche;
      if schnittpunktzahl>0 then begin
        ns:='';
        canvas.pen.color:=clblack;
        canvas.brush.color:=clblue;
        ergebnisliste.add('Schnittpunkte');
        for i:=0 to schnittpunktzahl-1 do begin
          wx:=round(malfxr(schnittpunkte[i]));
          ky:=funktionswert(s1,schnittpunkte[i]);
          wy:=round(malfyr(ky));
          canvas.ellipse(wx-4,wy-4,wx+5,wy+5);
          ns:=ns+'('+_strkomma(schnittpunkte[i],1,2)+';'+_strkomma(ky,1,2)+') | ';
          ergebnisliste.add(#9+'('+_strkomma(schnittpunkte[i],1,2)+';'+_strkomma(ky,1,2)+')');
        end;
        canvas.brush.color:=clwhite;
        delete(ns,length(ns)-2,20);
        if c_pktanzeige.checked then canvas.textout(16,grafh-30-funktions*16,'Schnittpunkte: '+ns);
        inc(funktions);
      end;
    end;
    if c_1ableitung.checked then fapaint(s1,'1.Ableitung',1);
    if c_2ableitung.checked then fapaint(s1,'2.Ableitung',2);
    //Sonderfunktionen
    if spiegelungxachse.checked then fapaint(s1,'f(-x)',3);
    if spiegelungyachse.checked then fapaint(s1,'-f(x)',4);
    if spiegelungursprung.checked then fapaint(s1,'-f(-x)',5);
    if nacheinanderausfuehrung.checked then fapaint(s1,'f(f(x))',6);
    if verschiebungxachse.checked then fapaint(s1,'f(x+p)',7);
    if streckungxachse.checked then fapaint(s1,'f(p*x)',8);
    if verschiebungyachse.checked then fapaint(s1,'f(x)+p',9);
    if streckungyachse.checked then fapaint(s1,'p*f(x)',10);

    //Funktionsschar
    if c_schar.checked then begin
      termausgabe:=false;
      farbe(funktionz);
      palt:=p;
      scharp:=p;
      schardiff:=abs(ein_double(ed_schardiff));
      if schardiff<0.1 then schardiff:=0.1;
      q:=ein_double(ed_q);
      while scharp<=q do begin
        p:=scharp;
        dec(funktionz);
        funktion(s1);
        scharp:=scharp+schardiff;
      end;
      p:=palt;
      termausgabe:=m_terme.checked;
    end;

    //Stammfunktion
    if c_stammfunktion.checked then begin
      farbe(funktionz);
      stamm(s1);
    end;
    //Umkehrkurve
    if Umkehrkurvezuf1x1.checked then begin
      farbe(funktionz);
      umkehr(s1);
    end;
    //Funktionsverküpfung
    if funktionsaddition.checked then
      if ed_f2.text<>'' then funktion(s1+'+('+ed_f2.text+')');
    if funktionssubtraktion1.checked then
      if ed_f2.text<>'' then funktion(s1+'-('+ed_f2.text+')');
    if funktionsmultiplikation.checked then
      if ed_f2.text<>'' then funktion('('+s1+')*('+ed_f2.text+')');
    if funktionsdivision1.checked then
      if (ed_f2.text<>'') and (ed_f2.text<>'0') then funktion('('+s1+')/('+ed_f2.text+')');

    //Punkt A
    if c_punktA.checked or c_tangente.checked or
       c_normale.checked or c_sekante.checked then begin
      fehler:=0;
      ky:=funktionswert(s1,kx);
      if fehler<>0 then ky:=0;
      label11.caption:='; '+_strkomma(ky,1,2)+' )';
      //Tangente
      if c_tangente.checked then begin
        canvas.brush.color:=clwhite;
        tm:=(funktionswert(s1,kx+0.001)-funktionswert(s1,kx))/0.001;
        tn:=ky-kx*tm;
        ts:=_strkomma(tm,1,3)+'*X';
        if tn>0 then ts:=ts+'+'+_strkomma(tn,1,3)
                else ts:=ts+_strkomma(tn,1,3);
        funktion(ts);
      end;
      //Normale
      if c_normale.checked then begin
        canvas.brush.color:=clwhite;
        tm:=(funktionswert(s1,kx+0.001)-funktionswert(s1,kx))/0.001;
        if tm<>0 then begin
          tm:=-1/tm;
          tn:=ky-kx*tm;
          ts:=_strkomma(tm,1,3)+'*X';
          if tn>0 then ts:=ts+'+'+_strkomma(tn,1,3);
          if tn<0 then ts:=ts+_strkomma(tn,1,3);
          funktion(ts);
        end;
      end;
      wx:=round(malfxr(kx));
      wy:=round(malfyr(ky));
      canvas.pen.color:=clblack;
      canvas.brush.color:=clyellow;
      if c_punktA.checked then canvas.ellipse(wx-4,wy-4,wx+5,wy+5);
      canvas.brush.color:=clwhite;
    end;

    //Punkt B
    if c_punktB.checked or c_sekante.checked then begin
      fehler:=0;
      ky2:=funktionswert(s1,kx2);
      if fehler<>0 then ky2:=0;
      label10.caption:='; '+_strkomma(ky2,1,2)+' )';
      wx:=round(malfxr(kx2));
      wy:=round(malfyr(ky2));
      canvas.pen.color:=clblack;
      canvas.brush.color:=cllime;
      if c_punktB.checked then canvas.ellipse(wx-4,wy-4,wx+5,wy+5);
      canvas.brush.color:=clwhite;
    end;
    //Sekante
    if c_sekante.checked then begin
      canvas.brush.color:=clwhite;
      if (kx2-kx)<>0 then begin
        tm:=(ky2-ky)/(kx2-kx);
        tn:=ky-kx*tm;
        ts:=_strkomma(tm,1,4)+'*X';
        if tn>0 then ts:=ts+'+'+_strkomma(tn,1,3);
        if tn<0 then ts:=ts+_strkomma(tn,1,3);
        funktion(ts);
      end;
    end;

    //wertetabelle
    if (c_wertetabelle.checked) and (Mergebnis.visible) then begin
      ergebnisliste.add('');
      ergebnisliste.add('Wertetabelle');
      ergebnisliste.add('x'#9'f(x)'#9'f''(x)');
      diff:=ein_double(ed_delta);
      kx:=ein_double(ed_von);
      kx2:=ein_double(ed_bis);
      if diff<=0 then diff:=0.05;
      repeat
        ky:=funktionswert(s1,kx);
        if fehler<>0 then ky:=0;
        ky2:=funktionswert(fabl,kx);
        if fehler<>0 then ky2:=0;
        ergebnisliste.add(_strkomma(kx,1,2)+#9+_strkomma(ky,1,2)+#9+_strkomma(ky2,1,2));
        kx:=kx+diff;
      until kx>kx2;
    end;
  end;
  until leof;

  if c_ergebnisliste.checked then
    if (mergebnis.clientheight div (mergebnis.font.size+5))<ergebnisliste.count
      then mergebnis.scrollbars:=ssvertical
      else mergebnis.scrollbars:=ssnone;
end;

procedure TFGraf.darstellung(Sender: TObject);
var Bitmap: TBitmap;
begin
  farbig:=m_farbe.Checked;
  grafb:=paintbox1.width;
  grafh:=paintbox1.Height;

  //Initialisierung des Koordinatensystems
  wbx:=1.0*(_x2-_x1);
  wby:=1.0*(_y2-_y1);
  fx:=grafb/wbx;
  fy:=grafh/wby;
  _x:=round(-_x1*grafb/(_x2-_x1));
  _y:=round(grafh+_y1*grafh/(_y2-_y1));
  Bitmap := TBitmap.Create;
  Bitmap.Width := paintbox1.Width;
  Bitmap.Height := paintbox1.Height;
  bitmap.canvas.font.name:='Verdana';
  bitmap.canvas.font.size:=9;
  setbkmode(bitmap.canvas.handle,transparent);
  try
    koordinatensystem(bitmap.canvas);
    zeichnen(bitmap.canvas);
    paintbox1.canvas.draw(0,0,bitmap);
  finally
    Bitmap.Free;
  end;
end;

//Routinen zum Verschieben des Koordinatensystems
procedure TFGraf.slinksClick(Sender: TObject);
var b:double;
begin
  b:=(_x2-_x1)/5;
  _x1:=_x1+b;
  _x2:=_x2+b;
  darstellung(sender);
end;

procedure TFGraf.srechtsClick(Sender: TObject);
var b:double;
begin
  b:=(_x2-_x1)/5;
  _x1:=_x1-b;
  _x2:=_x2-b;
  darstellung(sender);
end;

procedure TFGraf.shochClick(Sender: TObject);
var b:double;
begin
  b:=(_y2-_y1)/5;
  _y1:=_y1-b;
  _y2:=_y2-b;
  darstellung(sender);
end;

procedure TFGraf.srunterClick(Sender: TObject);
var b:double;
begin
  b:=(_y2-_y1)/5;
  _y1:=_y1+b;
  _y2:=_y2+b;
  darstellung(sender);
end;

//Zoom-In und Out
procedure TFGraf.sgroesserClick(Sender: TObject);
var b:double;
    _x1old,_x2old,_y1old,_y2old:double;
begin
  _x1old:=_x1;
  _x2old:=_x2;
  _y1old:=_y1;
  _y2old:=_y2;
  b:=(_x2-_x1)/10;
  _x1:=_x1+b;
  _x2:=_x2-b;
  if abs(_x1-_x2)<0.05 then begin
    _x1:=_x1old;
    _x2:=_x2old;
  end;
  b:=(_y2-_y1)/10;
  _y1:=_y1+b;
  _y2:=_y2-b;
  if abs(_y1-_y2)<0.05 then begin
    _y1:=_y1old;
    _y2:=_y2old;
  end;
  darstellung(sender);
end;

procedure TFGraf.SkleinerClick(Sender: TObject);
var b:double;
begin
  b:=(_x2-_x1)/10;
  _x1:=_x1-b;
  _x2:=_x2+b;
  b:=(_y2-_y1)/10;
  _y1:=_y1-b;
  _y2:=_y2+b;
  darstellung(sender);
end;

//Grundeinstellung
procedure TFGraf.SgrundClick(Sender: TObject);
begin
  _x1:=-6;
  _x2:=6;
  _y1:=_x1*paintbox1.height/paintbox1.width;
  _y2:=_x2*paintbox1.height/paintbox1.width;
  darstellung(sender);
end;

//Anfang des Rahmens holen
procedure TFGraf.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if paintbox1.canvas.pixels[x,y]=clyellow then begin
    punktziehen:=1;
    _xx0:=x;
    exit;
  end;
  if paintbox1.canvas.pixels[x,y]=cllime then begin
    punktziehen:=2;
    _xx0:=x;
    exit;
  end;
  if button=mbleft then begin
    _xx0:=x; _yy0:=y;
    _xx1:=x; _yy1:=y;
    rahmen:=true;
  end;
end;

//Neues Koordinatensystem einstellen
procedure TFGraf.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var  b,h,_xn1,_xn2,_yn1,_yn2:double;
function subx(x:integer):double;
begin
  subx:=(x-_x)/fx;
end;
begin
  if punktziehen=1 then begin
    ed_A.text:=_strkomma(subx(x),1,2);
    punktziehen:=0;
    paintbox1paint(sender);
    exit;
  end;
  if punktziehen=2 then begin
    ed_B.text:=_strkomma(subx(x),1,2);
    punktziehen:=0;
    paintbox1paint(sender);
    exit;
  end;

  if rahmen and (abs(_xx1-_xx0)>10) and (abs(_yy1-_yy0)>10) then begin
    b:=paintbox1.width;
    h:=paintbox1.height;
    _xn1:=_x1+_xx0/b*(_x2-_x1);
    _xn2:=_x1+_xx1/b*(_x2-_x1);
    if _xn1<_xn2 then begin _x1:=_xn1; _x2:=_xn2; end
                 else begin _x2:=_xn1; _x1:=_xn2; end;
    if abs(_x1-_x2)<0.01 then _x2:=_x1+0.01;
    _yn1:=_y1+(h-_yy0)/h*(_y2-_y1);
    _yn2:=_y1+(h-_yy1)/h*(_y2-_y1);
    if _yn1<_yn2 then begin _y1:=_yn1; _y2:=_yn2; end
                 else begin _y2:=_yn1; _y1:=_yn2; end;
    if abs(_y1-_y2)<0.01 then _y2:=_y1+0.01;
    darstellung(sender);
  end;
  rahmen:=false;
end;

procedure TFGraf.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var e:tpenmode;
function subx(x:integer):double;
begin
  subx:=(x-_x)/fx;
end;
begin
  if (paintbox1.canvas.pixels[x,y]=clyellow) or
     (paintbox1.canvas.pixels[x,y]=cllime)   or (punktziehen>0) then begin
    paintbox1.cursor:=crhandpoint;
    if punktziehen=1 then begin
      ed_A.text:=_strkomma(subx(x),1,2);
      paintbox1paint(sender);
    end;
    if punktziehen=2 then begin
      ed_B.text:=_strkomma(subx(x),1,2);
      paintbox1paint(sender);
    end;
    exit;
  end else paintbox1.cursor:=crdefault;

  if rahmen then begin
    e:=paintbox1.canvas.pen.mode;
    paintbox1.canvas.pen.style:=psdot;
    paintbox1.canvas.pen.mode:=pmnot;
    paintbox1.canvas.pen.color:=clltgray;
    paintbox1.canvas.brush.style:=bsclear;
    paintbox1.canvas.rectangle(_xx0,_yy0,_xx1,_yy1);
    paintbox1.canvas.rectangle(_xx0,_yy0,x,y);
    paintbox1.canvas.pen.style:=pssolid;
    paintbox1.canvas.brush.style:=bssolid;
    paintbox1.canvas.pen.mode:=e;
    _xx1:=x;
    _yy1:=y;
  end;
end;

//Breite der Graphen
procedure TFGraf.TB1Change(Sender: TObject);
begin
  darstellung(sender);
end;

//gleiche Auflösung in x- und y-Richtung
procedure TFGraf.S31Click(Sender: TObject);
begin
  _y1:=_x1*paintbox1.height/paintbox1.width;
  _y2:=_x2*paintbox1.height/paintbox1.width;
  darstellung(sender);
end;

procedure TFGraf.alsWMFkopieren1Click(Sender: TObject);
var mymetafile:tmetafile;
    can:tmetafilecanvas;
    aformat:word;
    adata:thandle;
    apalette:hpalette;
begin
  MyMetafile := TMetafile.Create;
  mymetafile.enhanced:=true;
  mymetafile.height:=paintbox1.height;
  mymetafile.width:=paintbox1.width;
  can:=TMetafileCanvas.Create(MyMetafile, 0);
  can.font.name:='Verdana';
  can.font.size:=10;
  can.brush.color:=clwhite;
  can.Rectangle(-1,-1,paintbox1.width+2,paintbox1.height+2);
  can.brush.style:=bsclear;
  koordinatensystem(can);
  zeichnen(can);
  can.Free;

  mymetafile.savetoclipboardformat(aformat,adata,apalette);
  ClipBoard.SetAsHandle(aFormat,AData);
  mymetafile.free;
end;

procedure TFGraf.GrafikdruckenClick(Sender: TObject);
var rect:trect;
    breite:integer;
    mymetafile:tmetafile;
procedure metadatei;
var can:tmetafilecanvas;
begin
  grafb:=paintbox1.width;
  grafh:=paintbox1.height;
  mymetafile.height:=grafh;
  mymetafile.width:=grafb;
  wbx:=1.0*(_x2-_x1);
  wby:=1.0*(_y2-_y1);
  fx:=grafb/wbx;
  fy:=grafh/wby;
  _x:=round(-_x1*grafb/(_x2-_x1));
  _y:=round(grafh+_y1*grafh/(_y2-_y1));

  can:=TMetafileCanvas.Create(MyMetafile, 0);
  can.font.name:='Verdana';
  can.font.size:=10;
  can.brush.color:=clwhite;
  can.Rectangle(-1,-1,grafb+1,grafh+1);
  can.brush.style:=bsclear;
  koordinatensystem(can);
  zeichnen(can);

  can.brush.color:=clwhite;
  can.pen.style:=psclear;
  can.Rectangle(-20,-20,grafb+20,-1);
  can.Rectangle(-20,-20,-1,breite);
  can.Rectangle(grafb+1,-20,grafb+20,breite);
  can.Rectangle(-20,grafh+1,grafb+20,breite);
  can.Free;
end;
begin
  MyMetafile := TMetafile.Create;
  mymetafile.enhanced:=true;
  breite:=round(paintbox1.width/printer.pagewidth*printer.pageheight+20);
  metadatei;
  Printer.title:='Funktionsgraph';
  printer.begindoc;
  breite:=round((printer.pagewidth-20)/paintbox1.width*paintbox1.height);
  rect:=Bounds(20,20,printer.pagewidth-40,breite-20);
  printer.canvas.StretchDraw(Rect,mymetafile);
  printer.enddoc;
  mymetafile.free;
end;

procedure TFGraf.b_zeichnenClick(Sender: TObject);
begin
  lclear;
  if (ed_f1.text<>'') and c_f1.checked then lwriteln(ed_f1.text);
  if (ed_f2.text<>'') and c_f2.checked then lwriteln(ed_f2.text);
  if (ed_f3.text<>'') and c_f3.checked then lwriteln(ed_f3.text);
  if (ed_f4.text<>'') and c_f4.checked then lwriteln(ed_f4.text);
  if ed_parameter.text<>'' then p:=ein_double(ed_parameter);
  paintbox1paint(sender);
end;

procedure TFGraf.FormActivate(Sender: TObject);
begin
  rahmen:=false;
  punktziehen:=0;
  _x2:=6;
  _x1:=-6;
  _y1:=_x1*paintbox1.height/paintbox1.width;
  _y2:=_x2*paintbox1.height/paintbox1.width;
  b_zeichnenclick(sender);
end;

procedure TFGraf.b_animationClick(Sender: TObject);
begin
  timer1.enabled:=not timer1.enabled;
  if timer1.enabled then b_animation.caption:='Stopp'
  else begin
    b_animation.caption:='Animation';
    paintbox1paint(sender);
  end;
end;

//Bewegung der Punkt A, B / Änderung des Parameters P
procedure TFGraf.Timer1Timer(Sender: TObject);
var x,diff:double;
begin
  if rb_punkta.checked then begin
    diff:=ein_double(ed_delta);
    x:=ein_double(ed_A);
    if steigen then x:=x+diff
               else x:=x-diff;
    if (x>ein_double(ed_bis)) then steigen:=false;
    if (x<ein_double(ed_von)) then steigen:=true;
    ed_A.text:=_strkomma(x,1,2);
    paintbox1paint(sender);
    exit;
  end;
  if rb_punktb.checked then begin
    diff:=ein_double(ed_delta);
    x:=ein_double(ed_B);
    if steigen then x:=x+diff
               else x:=x-diff;
    if (x>ein_double(ed_bis)) then steigen:=false;
    if (x<ein_double(ed_von)) then steigen:=true;
    ed_B.text:=_strkomma(x,1,2)
  end else begin
    diff:=ein_double(ed_delta);
    if steigen then p:=p+diff
               else p:=p-diff;
    if (p>ein_double(ed_bis)) then steigen:=false;
    if (p<ein_double(ed_von)) then steigen:=true;
    ed_parameter.text:=_strkomma(p,1,2)
  end;
  paintbox1paint(sender);
end;

procedure TFGraf.UpDown2ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  p:=ein_double(ed_parameter);
  if direction=updUp then p:=p+0.01
                     else p:=p-0.01;
  ed_parameter.text:=_strkomma(p,1,2);
  paintbox1paint(sender);
end;

procedure TFGraf.UpDown3ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
var x:double;
begin
  x:=ein_double(ed_A);
  if direction=updUp then x:=x+0.01
                     else x:=x-0.01;
  ed_A.text:=_strkomma(x,1,2);
  paintbox1paint(sender);
end;

procedure TFGraf.UpDown4ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
var x:double;
begin
  x:=ein_double(ed_B);
  if direction=updUp then x:=x+0.01
                     else x:=x-0.01;
  ed_B.text:=_strkomma(x,1,2);
  paintbox1paint(sender);
end;

//1.Ableitung analytisch berechnen
procedure TFGraf.button_fstrichClick(Sender: TObject);
begin
  ed_f3.text:=zableitung(ed_f1.text);
  b_zeichnenclick(sender);
end;

//Ergebnisliste anzeigen
procedure TFGraf.Bergebnis(Sender: TObject);
begin
  Mergebnis.visible:=not Mergebnis.visible;
  m1.enabled:=Mergebnis.visible;
  _y1:=_x1*paintbox1.height/paintbox1.width;
  _y2:=_x2*paintbox1.height/paintbox1.width;
  if Mergebnis.visible then Mergebnis.lines.assign(ergebnisliste);
end;

procedure TFGraf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ergebnisliste.free
end;

//Ergebnisliste anzeigen
procedure TFGraf.FormCreate(Sender: TObject);
begin
  ergebnisliste:=tstringlist.create;
  Mergebnis.doublebuffered:=true;
end;

//Ergebnisliste kopieren
procedure TFGraf.ListekopierenClick(Sender: TObject);
begin
  Mergebnis.SelectAll;
  Mergebnis.CopyToClipboard;
end;

procedure TFGraf.FormResize(Sender: TObject);
begin
  _y1:=_x1*paintbox1.height/paintbox1.width;
  _y2:=_x2*paintbox1.height/paintbox1.width;
end;

procedure TFGraf.Menueinstellungen(Sender: TObject);
begin
  (sender as tmenuitem).checked:=not (sender as tmenuitem).checked;
  paintbox1paint(sender);
end;

procedure TFGraf.UpDown5ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  q:=ein_double(ed_q);
  if direction=updUp then q:=q+0.01
                     else q:=q-0.01;
  ed_q.text:=_strkomma(q,1,2);
  paintbox1paint(sender);
end;

procedure TFGraf.button_f2strichClick(Sender: TObject);
begin
  ed_f4.text:=zableitung(zableitung(ed_f1.text));
  b_zeichnenclick(sender);
end;

procedure TFGraf.Speichern1Click(Sender: TObject);
var f:tfilestream;
    Bitmap: TBitmap;
    myrect,birect:trect;
procedure metadatei;
var mymetafile:tmetafile;
    can:tmetafilecanvas;
begin
  MyMetafile := TMetafile.Create;
  mymetafile.enhanced:=true;
  mymetafile.height:=paintbox1.height;
  mymetafile.width:=paintbox1.width;
  can:=TMetafileCanvas.Create(MyMetafile, 0);
  can.font.name:='Verdana';
  can.font.size:=10;
  can.brush.color:=clwhite;
  can.Rectangle(-1,-1,paintbox1.width+1,paintbox1.height+1);
  can.brush.style:=bsclear;
  koordinatensystem(can);
  zeichnen(can);
  can.Free;
  f:=tfilestream.create(sd1.filename,fmcreate);
  mymetafile.savetostream(f);
  f.free;
  mymetafile.free;
end;
procedure gifsave(bitmap:tbitmap;const f:string);
var GIF	: TGIFImage;
begin
  GIF := TGIFImage.Create;
  try
    GIF.Assign(Bitmap);
    GIF.SaveToFile(f);
  finally
    GIF.Free;
  end;
end;
begin
  sd1.filterindex:=3;
  sd1.filename:='';
  if sd1.execute then begin
    try
      darstellung(sender);
    finally
      Bitmap := TBitmap.Create;
      Bitmap.Width := paintbox1.Width;
      Bitmap.Height := paintbox1.Height;
      birect.left:=0;
      birect.right:=paintbox1.width;
      birect.top:=0;
      birect.bottom:=paintbox1.height;
      myrect:=birect;
      bitmap.canvas.copyrect(biRect,paintbox1.Canvas, MyRect);
      if sd1.filterindex=2 then Bitmap.PixelFormat := pf4bit;
      if sd1.filterindex<3 then begin
        f:=tfilestream.create(sd1.filename,fmcreate);
        bitmap.savetostream(f);
        f.free;
      end;
      if sd1.filterindex=3 then gifsave(bitmap,sd1.filename);
      if sd1.filterindex=4 then metadatei;
      Bitmap.Free;
    end;
  end;
end;

initialization

  ldatei:=tstringlist.create;
  _x2:=6;
  _x1:=-6;
  _y2:=5;
  _y1:=-5;
  steigen:=true;

finalization

  ldatei.free;

end.

