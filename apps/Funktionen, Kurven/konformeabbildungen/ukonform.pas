unit ukonform;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  ExtCtrls, StdCtrls, CheckLst, Grids, RXSpin, Buttons;

type
  Tfsortier = class(TForm)
    P4: TPanel;
    MM1: TMainMenu;
    M5: TMenuItem;
    konform: TPanel;
    P34: TPanel;
    P46: TPanel;
    P43: TPanel;
    P45: TPanel;
    PB12: TPaintBox;
    PB13: TPaintBox;
    Timer5: TTimer;
    P47: TPanel;
    L41: TLabel;
    D24: TButton;
    E18: TEdit;
    RB3: TRadioButton;
    RB4: TRadioButton;
    RB5: TRadioButton;
    P36: TPanel;
    D25: TButton;
    RG2: TRadioGroup;
    CL1: TCheckListBox;
    Rx13: TRxSpinEdit;
    L65: TLabel;
    RG3: TRadioGroup;
    RB6: TRadioButton;
    Rb7: TRadioButton;
    rb8: TRadioButton;
    S46: TSpeedButton;
    S47: TSpeedButton;
    S48: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure S7C(Sender: TObject);
    procedure x1C(Sender: TObject);
    procedure S46C(Sender: TObject);
    procedure S47C(Sender: TObject);
    procedure S48C(Sender: TObject);
    procedure P46Resize(Sender: TObject);
    procedure PB13P(Sender: TObject);
    procedure PB13Paintwmf(can:tcanvas);
    procedure PB12P(Sender: TObject);
    procedure PB12Paintwmf(can:tcanvas);
    procedure D24C(Sender: TObject);
    procedure konkoord(can:tcanvas;f:double);
    procedure PB12MM(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB12MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB12MU(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer5Timer(Sender: TObject);
    procedure D25C(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var  fsortier: Tfsortier;

implementation

uses math, fktkomplex;

{$R *.DFM}
const pium = 57.295779513082320876;
      pino = pi/180;

const akt:byte=0;
      ufaktor:double=1.0;
      xkonf:integer=0;
      ykonf:integer=0;
      zkonf:boolean=false;
      krichtung:integer=2;

procedure Tfsortier.FormShow(Sender: TObject);
begin
  timer5.enabled:=false;
  ufaktor:=1;
  cl1.checked[0]:=true;
  cl1.checked[1]:=true;
end;

procedure Tfsortier.S7C(Sender: TObject);
begin
  close;
end;

procedure Tfsortier.x1C(Sender: TObject);
begin
  d24c(Sender);
end;

procedure Tfsortier.S46C(Sender: TObject);
begin
  ufaktor:=ufaktor/1.1;
  pb13p(sender);
end;

procedure Tfsortier.S47C(Sender: TObject);
begin
  ufaktor:=1;
  pb13p(sender);
end;

procedure Tfsortier.S48C(Sender: TObject);
begin
  ufaktor:=ufaktor*1.1;
  pb13p(sender);
end;

procedure Tfsortier.P46Resize(Sender: TObject);
begin
  p43.width:=p46.width div 2;
  p47.width:=p46.width div 2;
  e18.width:=(p46.width div 2)-180;
  rg3.left:=(p46.width div 2)-100;
end;

procedure Tfsortier.PB13P(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=pb13.width;
  bitmap.height:=pb13.height;
  pb13paintwmf(bitmap.canvas);
  pb13.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure Tfsortier.PB13Paintwmf(can:tcanvas);
var anf,b,h,ma,br,i,gg:integer;
    fterm:string;
    ende:boolean;
    a,z:tkomplexzahl;
    wi,x,y,gr,fein:double;
  procedure komplexwert;
  begin
    a:=funktionswertkomplex(fterm,z);
    x:=b+a.re*10*br/ufaktor;
    y:=h-a.im*10*br/ufaktor;
    if (abs(x)<1000) and (abs(y)<1000) then begin
      if anf=0 then begin
        can.moveto(round(x),round(y));
        anf:=1;
      end
      else can.lineto(round(x),round(y));
    end
    else anf:=0;
  end;
  procedure geradesenkrecht(x1,y1,y2:double);
  begin
    wi:=y1;
    anf:=0;
    ende:=false;
    repeat
      if wi>y2 then begin
        wi:=y2;
        ende:=true
      end;
      z.re:=x1;
      z.im:=wi;
      komplexwert;
      wi:=wi+0.08*fein;
    until ende;
  end;
  procedure geradewaagerecht(x1,y1,y2:double);
  begin
    wi:=y1;
    anf:=0;
    ende:=false;
    repeat
      if wi>y2 then begin
        wi:=y2;
        ende:=true
      end;
      z.im:=x1;
      z.re:=wi;
      komplexwert;
      wi:=wi+0.08*fein;
    until ende;
  end;
  procedure kreiskonform(xm,ym,r:double);
  begin
    wi:=0;
    anf:=0;
    repeat
      z.re:=xm+r*cos(wi);
      z.im:=ym-r*sin(wi);
      komplexwert;
      wi:=wi+0.05*fein;
    until wi>2*pi+0.05*fein;
  end;
begin
  fein:=rx13.value/10;
  can.font.name:='Verdana';
  can.font.size:=10;
  b:=pb12.width div 2;
  h:=pb12.height div 2;
  ma:=b;
  if h<b then ma:=h;
  br:=(ma-40) div 10;
  fterm:=e18.text;
  can.pen.color:=clblue;
  if rb3.checked or rb4.checked then begin
    if rb4.checked then gr:=pi
                   else gr:=pi/2;
    for i:=1 to 10 do begin
      wi:=-gr;
      anf:=0;
      repeat
        z.re:=i/10*cos(wi);
        z.im:=i/10*sin(wi);
        komplexwert;
        wi:=wi+0.05*fein;
      until wi>gr+0.05*fein;
    end;
    if rb4.checked then gg:=18
                   else gg:=9;
    for i:=-gg to gg do begin
      wi:=0;
      anf:=0;
      ende:=false;
      repeat
        if wi>1 then begin
          wi:=1;
          ende:=true
        end;
        z.re:=wi*cos(i*10*pino);
        z.im:=wi*sin(i*10*pino);
        komplexwert;
        wi:=wi+0.08*fein;
      until ende;
    end;
  end;
  if rb5.checked then begin //quadrad
    for i:=0 to 20 do geradesenkrecht(-1+i/10,-1,1);
    for i:=0 to 20 do geradewaagerecht(-1+i/10,-1,1);
  end;   //ende rb5
  if rb6.checked then begin //figur
    geradesenkrecht(-0.5,-0.5,0.5);
    geradesenkrecht(0.5,-0.5,0.5);
    geradewaagerecht(-0.5,-0.5,0.5);
    geradewaagerecht(0.5,-0.5,0.5);
    geradewaagerecht(0.4,-0.4,-0.1);
    geradewaagerecht(0.1,-0.4,-0.1);
    geradesenkrecht(-0.4,0.1,0.4);
    geradesenkrecht(-0.1,0.1,0.4);

    wi:=-0.5;
    anf:=0;
    ende:=false;
    repeat
      if wi>0 then begin
        wi:=0;
        ende:=true
      end;
      z.re:=0.5+wi;
      z.im:=0.5-wi;
      komplexwert;
      wi:=wi+0.08*fein;
    until ende;
    wi:=-0.5;
    anf:=0;
    ende:=false;
    repeat
      if wi>0 then begin
        wi:=0;
        ende:=true
      end;
      z.re:=-0.5-wi;
      z.im:=0.5-wi;
      komplexwert;
      wi:=wi+0.08*fein;
    until ende;
    geradewaagerecht(-0.1,0.1,0.4);
    geradesenkrecht(0.1,-0.5,-0.1);
    geradesenkrecht(0.4,-0.5,-0.1);
  end;   //ende rb6

  if rb7.checked then begin //figur 2
    kreiskonform(0,0,1);
    kreiskonform(0,0,0.2);
    kreiskonform(-0.4,0.4,0.2);
    kreiskonform(0.4,0.4,0.2);
    geradewaagerecht(-0.4,-0.4,0.4);
    geradewaagerecht(-0.6,-0.4,0.4);
    geradesenkrecht(-0.4,-0.6,-0.4);
    geradesenkrecht(0.4,-0.6,-0.4);
  end; //ende figur 2
  if rb8.checked then begin //figur 3
    for i:=1 to 17 do geradewaagerecht(0.1*(9-i),-0.05*i,0.05*i);
  end;
  if cl1.checked[2] then begin
    can.pen.color:=cllime;
    for i:=-12 to 12 do begin
      wi:=0;
      anf:=0;
      ende:=false;
      repeat
        if wi>0.6 then begin
          wi:=0.6;
          ende:=true
        end;
        z.re:=xkonf/br/10+wi*cos(i*15*pino);
        z.im:=-ykonf/br/10-wi*sin(i*15*pino);
        komplexwert;
        wi:=wi+0.08*fein;
      until ende;
    end;
  end;
  konkoord(can,ufaktor);
  if cl1.checked[0] then begin
    can.brush.color:=clyellow;
    can.pen.color:=clblack;
    z.re:=xkonf/br/10;
    z.im:=-ykonf/br/10;
    a:=funktionswertkomplex(fterm,z);
    x:=b+a.re*10*br/ufaktor;
    y:=h-a.im*10*br/ufaktor;
    if (abs(x)<1000) and (abs(y)<1000) then
      can.ellipse(round(x-4),round(y-4),round(x+5),round(y+5));
  end;
end;

procedure Tfsortier.konkoord(can:tcanvas;f:double);
var b,h,ma,br:integer;
procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:double;
    x,y:integer;
    pfe:array[0..3] of tpoint;
    wcos,wsin:extended;
  procedure kline(a,b,c,d:integer);
  begin
    can.moveto(a,b);
    can.lineto(c,d);
  end;
begin
  kline(a,b,c,d);
  if (a<>c) or (b<>d) then begin
    if (c-a)<>0 then
      wi:=pi-arctan((d-b)/(c-a))
    else begin
      if d<b then wi:=-pi/2
             else wi:=pi/2;
    end;
    sincos(wi-xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[0].x:=c+x;
    pfe[0].y:=d-y;
    pfe[1].x:=c;
    pfe[1].y:=d;
    sincos(wi+xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[2].x:=c+x;
    pfe[2].y:=d-y;
    can.brush.color:=can.pen.color;
    can.polygon(slice(pfe,3));
    can.brush.style:=bsclear;
  end;
end;
begin
  if cl1.checked[1] then begin
    b:=pb12.width div 2;
    h:=pb12.height div 2;
    ma:=b;
    if h<b then ma:=h;
    br:=(ma-40) div 10;
    can.pen.color:=clblack;
    can.brush.style:=bsclear;
    xpfeilvoll(can,10,h,2*b-10,h);
    xpfeilvoll(can,b,2*h-10,b,10);
    can.textout(b-20,20,'Im');
    can.textout(2*b-30,h+10,'Re');
    can.moveto(round(b-10*br/f),h-4);
    can.lineto(round(b-10*br/f),h+4);
    can.moveto(round(b+10*br/f),h-4);
    can.lineto(round(b+10*br/f),h+4);
    can.textout(round(b-10*br/f)-10,h+5,'-1');
    can.textout(round(b+10*br/f),h+5,'1');
    can.moveto(b-4,round(h-10*br/f));
    can.lineto(b+4,round(h-10*br/f));
    can.moveto(b-4,round(h+10*br/f));
    can.lineto(b+4,round(h+10*br/f));
    can.textout(b-12,round(h-10*br/f)-8,'i');
    can.textout(b-20,round(h+10*br/f)-8,'-i');
  end;
end;

procedure Tfsortier.PB12P(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=pb12.width;
  bitmap.height:=pb12.height;
  pb12paintwmf(bitmap.canvas);
  pb12.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure Tfsortier.PB12Paintwmf(can:tcanvas);
var gg,b,h,ma,br,i,x,y:integer;
begin
  can.font.name:='Verdana';
  can.font.size:=10;
  b:=pb12.width div 2;
  h:=pb12.height div 2;
  ma:=b;
  if h<b then ma:=h;
  br:=(ma-40) div 10;
  can.pen.color:=clred;
  can.brush.style:=bsclear;
  if rb3.checked or rb4.checked then begin
    for i:=1 to 10 do begin
      if rb3.checked then
        can.arc(b-i*br,h-i*br,b+i*br+1,h+i*br+1,b,h+50,b,h-50)
      else
        can.ellipse(b-i*br,h-i*br,b+i*br+1,h+i*br+1)
    end;
    if rb4.checked then gg:=18
                   else gg:=9;
    for i:=-gg to gg do begin
      x:=round(b+10*br*cos(i*10*pino));
      y:=round(h-10*br*sin(i*10*pino));
      can.moveto(b,h);
      can.lineto(x,y);
    end;
  end;

  if rb5.checked then begin //quadrat
    for i:=0 to 20 do begin
      can.moveto(b-10*br+i*br,h-10*br);
      can.lineto(b-10*br+i*br,h+10*br);
      can.moveto(b-10*br,h-10*br+i*br);
      can.lineto(b+10*br,h-10*br+i*br);
    end;
  end;
  if cl1.checked[2] then begin
    can.pen.color:=clfuchsia;
    for i:=-12 to 12 do begin
      x:=round(b+xkonf+6*br*cos(i*15*pino));
      y:=round(h+ykonf-6*br*sin(i*15*pino));
      can.moveto(b+xkonf,h+ykonf);
      can.lineto(x,y);
    end;
  end;
  if rb6.checked then begin //figur
    can.moveto(b+5*br,h-5*br);
    can.lineto(b-5*br,h-5*br);
    can.lineto(b-5*br,h+5*br);
    can.lineto(b+5*br,h+5*br);
    can.lineto(b+5*br,h-5*br);
    can.lineto(b,h-10*br);
    can.lineto(b-5*br,h-5*br);
    can.moveto(b+1*br,h+5*br);
    can.lineto(b+1*br,h+1*br);
    can.lineto(b+4*br,h+1*br);
    can.lineto(b+4*br,h+5*br);
    can.rectangle(b-4*br,h-br,b-br+1,h-4*br+1);
  end;
  if rb7.checked then begin //figur
    can.ellipse(b-10*br,h-10*br,b+10*br+1,h+10*br+1);
    can.ellipse(b-2*br,h-2*br,b+2*br+1,h+2*br+1);
    can.ellipse(b-6*br,h-6*br,b-2*br+1,h-2*br+1);
    can.ellipse(b+2*br,h-6*br,b+6*br+1,h-2*br+1);
    can.rectangle(b-4*br,h+4*br,b+4*br+1,h+6*br+1);
  end;
  if rb8.checked then begin //figur3
    for i:=1 to 17 do begin
      can.moveto(b-i*br div 2,h-(9-i)*br);
      can.lineto(b+i*br div 2,h-(9-i)*br);
    end;
  end;
  if cl1.checked[2] then begin
    can.pen.color:=clfuchsia;
    for i:=-12 to 12 do begin
      x:=round(b+xkonf+6*br*cos(i*15*pino));
      y:=round(h+ykonf-6*br*sin(i*15*pino));
      can.moveto(b+xkonf,h+ykonf);
      can.lineto(x,y);
    end;
  end;
  konkoord(can,1);
  if cl1.checked[0] then begin
    can.brush.color:=clyellow;
    can.pen.color:=clblack;
    can.ellipse(b+xkonf-4,h+ykonf-4,b+xkonf+5,h+ykonf+5);
  end;
end;

procedure Tfsortier.D24C(Sender: TObject);
begin
  pb12p(sender);
  pb13p(sender);
end;

procedure Tfsortier.PB12MM(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var b,h:integer;
begin
  b:=pb12.width div 2;
  h:=pb12.height div 2;
  if (abs(xkonf-x+b)<5) and (abs(ykonf-y+h)<5) then
     pb12.cursor:=crhandpoint else pb12.cursor:=crdefault;
  if zkonf then begin
    xkonf:=x-b;
    ykonf:=y-h;
    pb12p(sender);
    pb13p(sender);
  end;
end;

procedure Tfsortier.PB12MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h:integer;
begin
  b:=pb12.width div 2;
  h:=pb12.height div 2;
  if (abs(xkonf-x+b)<5) and (abs(ykonf-y+h)<5) then zkonf:=true;
end;

procedure Tfsortier.PB12MU(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h:integer;
begin
  b:=pb12.width div 2;
  h:=pb12.height div 2;
  if zkonf then begin
    xkonf:=x-b;
    ykonf:=y-h;
    zkonf:=false;
    pb12p(sender);
    pb13p(sender);
  end;
end;

procedure Tfsortier.Timer5Timer(Sender: TObject);
var x,y:integer; r,wi:double;
begin
  case rg2.itemindex of
     0 : begin
           x:=xkonf+krichtung;
           if x>=pb12.width div 2 then krichtung:=-krichtung;
           if x<=-pb12.width div 2 then krichtung:=-krichtung;
           xkonf:=x;
           d24c(sender);
         end;
     1 : begin
           y:=ykonf+krichtung;
           if y>=pb12.height div 2 then krichtung:=-krichtung;
           if y<=-pb12.height div 2 then krichtung:=-krichtung;
           ykonf:=y;
           d24c(sender);
         end;
     2 : begin
           r:=sqrt(sqr(xkonf)+sqr(ykonf));
           wi:=arctan2(ykonf,xkonf)+0.03;
           xkonf:=round(r*cos(wi));
           ykonf:=round(r*sin(wi));
           d24c(sender);
         end;
  end;
end;

procedure Tfsortier.D25C(Sender: TObject);
begin
  timer5.enabled:=not timer5.enabled;
  if timer5.enabled then d25.caption:='Abbruch'
                    else d25.caption:='Simulation';
end;

end.

