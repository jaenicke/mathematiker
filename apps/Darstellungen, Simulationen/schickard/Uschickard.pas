unit Uschickard;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  ExtCtrls, StdCtrls, Grids, Buttons;

type
  Tfschickard = class(TForm)
    Panel4: TPanel;
    Label1: TLabel;
    schickard: TPanel;
    Panel3: TPanel;
    I1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Timer2: TTimer;
    Button2: TButton;
    Label2: TLabel;
    I3: TImage;
    Label5: TLabel;
    Edit2: TEdit;
    Edit1: TEdit;
    Button3: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Paintbox1: TPaintBox;
    procedure S7C(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PB8P(Sender: TObject);
    procedure PB8Paintwmf(can:tcanvas);
    procedure PB8MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D15C(Sender: TObject);
    procedure PB8MM(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure D16C(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure D18C(Sender: TObject);
  private
  { Private declarations }
  public
    { Public declarations }
  end;

var  fschickard: Tfschickard;

implementation

uses math;

const wert: double=1000;
      seite:integer=40;
      farbe1:integer=$007FFFFF;
      farbe2:integer=$00ff8000;
      farbe3:integer=$000080FF;
      farbe4:integer=clyellow;
      steigen:boolean = true;
      fehlerjetzt:boolean=false;
      schickzaehler:integer=0;
var
    schick1,schick2,schick3,schickaz,schickbz:array[0..6] of integer;
    schieber:array[0..9] of boolean;
    schicka,schickb:integer;
    pfeil,pfeil2,pfeil3:integer;

{$R *.DFM}

procedure Tfschickard.S7C(Sender: TObject);
begin
  close;
end;

procedure Tfschickard.FormShow(Sender: TObject);
begin
  randomize;
  timer2.enabled:=false;
  schickzaehler:=0;
  fillchar(schick1,sizeof(schick1),0);
  fillchar(schick2,sizeof(schick2),0);
  fillchar(schick3,sizeof(schick3),0);
  fillchar(schieber,sizeof(schieber),false);
  schicka:=random(990)+10;
  edit2.text:=inttostr(schicka);
  schickb:=random(990)+10;
  edit1.text:=inttostr(schickb);
end;

procedure Tfschickard.PB8P(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=Paintbox1.width;
  bitmap.height:=Paintbox1.height;
  pb8paintwmf(bitmap.canvas);
  Paintbox1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

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

procedure Tfschickard.PB8Paintwmf(can:tcanvas);
var i,ii,j,ho,bo,p:integer;
    k:string;
begin
  can.font.name:='Verdana';
  bo:=(Paintbox1.width-i1.width) div 2+10;
  ho:=(Paintbox1.height-i1.height) div 2-20;
  can.draw(bo,ho,i1.picture.bitmap);
  can.brush.color:=$00c0c0c0;//rgb(231,214,140);
  can.font.size:=16;
  for ii:=0 to 7 do begin
    if schieber[ii+2] then begin
      can.rectangle(bo-37,ho+68+ii*36,bo+63,ho+102+ii*36);
      can.rectangle(bo+463,ho+68+ii*36,bo+511,ho+102+ii*36);
      can.textout(bo-27,ho+72+ii*36,inttostr(ii+2));
      can.textout(bo+489,ho+72+ii*36,inttostr(ii+2));
    end else begin
      can.rectangle(bo+15,ho+68+ii*36,bo+63,ho+102+ii*36);
      can.rectangle(bo+463,ho+68+ii*36,bo+561,ho+102+ii*36);
      can.textout(bo+25,ho+72+ii*36,inttostr(ii+2));
      can.textout(bo+539,ho+72+ii*36,inttostr(ii+2));
    end;
  end;
  for j:=2 to 9 do
    if schieber[j] then begin
      can.brush.color:=$00c0ffff;
      can.pen.style:=psclear;
      for ii:=0 to 5 do
        can.rectangle(bo+85+ii*61,ho+67+(j-2)*36,bo+138+ii*61,ho+103+(j-2)*36);
    end;
  can.pen.style:=pssolid;
  can.brush.style:=bsclear;
  can.font.size:=16;
  can.font.color:=clblack;
  for i:=0 to 5 do can.textout(bo+410-61*i,ho+41,inttostr(schick1[i]));
  for i:=0 to 5 do can.textout(bo+410-61*i,ho+48+420-28,inttostr(schick2[i]));

  can.font.color:=clblack;
  can.font.size:=14;
  for i:=0 to 5 do begin
    for j:=2 to 9 do begin
      p:=j*schick1[i];
      k:=inttostr(p div 10)+'/'+inttostr(p mod 10);
      can.textout(bo-61*i+415-can.textwidth(k) div 2,ho+85+(j-2)*36-
                  can.textheight(k) div 2,k);
    end;
  end;
  can.font.size:=24;
  can.font.color:=clblue;
  for i:=0 to 5 do can.textout(bo+405-61*i,ho+41+420-97,inttostr(schick3[i]));
  if timer2.enabled and (pfeil>0) then begin
    can.CopyMode:=cmsrcand;
    case pfeil of
      1..3 : can.draw(bo+492-pfeil*61,ho+62,i3.picture.bitmap);
      4..6 : can.draw(bo+492-(pfeil-3)*61,ho+486,i3.picture.bitmap);
     7..12 : can.draw(bo+492-(pfeil-6)*61,ho+399,i3.picture.bitmap);
    end;
    can.CopyMode:=cmsrccopy;
    can.pen.color:=cllime;
    can.pen.width:=2;
    case pfeil of
      7..12 : xpfeilvoll(can,bo+415-61*pfeil2,ho+36*pfeil3+30,bo+415-61*(pfeil-7),ho+41+420-93);
    end;
    can.pen.width:=1;
  end;
end;

procedure Tfschickard.PB8MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var bo,ho:integer;
  procedure plus(a:integer);
  begin
    schick1[a]:=(schick1[a]+1) mod 10;
  end;
  procedure minus(a:integer);
  begin
    schick1[a]:=schick1[a]-1;
    if schick1[a]<0 then schick1[a]:=schick1[a]+10
  end;
  procedure plus2(a:integer);
  begin
    schick2[a]:=(schick2[a]+1) mod 10;
  end;
  procedure minus2(a:integer);
  begin
    schick2[a]:=schick2[a]-1;
    if schick2[a]<0 then schick2[a]:=schick2[a]+10
  end;
  procedure plus3(a:integer);
  var i:integer;
  begin
    inc(schick3[a]);
    for i:=a to 5 do begin
      if schick3[i]>9 then begin
        schick3[i]:=schick3[i]-10;
        inc(schick3[i+1])
      end;
    end;
  end;
  procedure minus3(a:integer);
  var i,z:integer;
  begin
    schick3[a]:=schick3[a]-1;
    z:=0;
    for i:=5 downto 0 do z:=10*z+schick3[i];
    if z<0 then z:=0;
    for i:=0 to 5 do begin
      schick3[i]:=z mod 10;
      z:=z div 10
    end;
  end;
begin
  if timer2.enabled then exit;
  bo:=(Paintbox1.width-i1.width) div 2+10;
  ho:=(Paintbox1.height-i1.height) div 2-20;
  if (12<y-ho) and (y-ho<30) then begin
    case x-bo of
        417..439 : plus(0);
        356..388 : plus(1);
        295..327 : plus(2);
        234..266 : plus(3);
        173..205 : plus(4);
        112..144 : plus(5);
        392..415 : minus(0);
        331..354 : minus(1);
        270..293 : minus(2);
        209..232 : minus(3);
        148..171 : minus(4);
         87..110 : minus(5);
    end;
  end;
  if (498-30<y-ho) and (y-ho<516-30) then begin
    case x-bo of
       417..439 : plus2(0);
       356..388 : plus2(1);
       295..327 : plus2(2);
       234..266 : plus2(3);
       173..205 : plus2(4);
       112..144 : plus2(5);
       392..415 : minus2(0);
       331..354 : minus2(1);
       270..293 : minus2(2);
       209..232 : minus2(3);
       148..171 : minus2(4);
        87..110 : minus2(5);
    end;
  end;
  if (428-16<y-ho) and (y-ho<445-16) then begin
    case x-bo of
       417..439 : plus3(0);
       356..388 : plus3(1);
       295..327 : plus3(2);
       234..266 : plus3(3);
       173..205 : plus3(4);
       112..144 : plus3(5);
       392..415 : minus3(0);
       331..354 : minus3(1);
       270..293 : minus3(2);
       209..232 : minus3(3);
       148..171 : minus3(4);
        87..110 : minus3(5);
    end;
  end;
  if ((465<x-bo) and (x-bo<585)) or ((18<x-bo) and (x-bo<61)) then begin
    case y-ho of
       70..100 : schieber[2]:=not schieber[2];
       106..136 : schieber[3]:=not schieber[3];
       142..172 : schieber[4]:=not schieber[4];
       178..208 : schieber[5]:=not schieber[5];
       214..244 : schieber[6]:=not schieber[6];
       250..280 : schieber[7]:=not schieber[7];
       286..316 : schieber[8]:=not schieber[8];
       322..352 : schieber[9]:=not schieber[9];
    end;
  end;
  pb8p(sender);
end;

procedure Tfschickard.D15C(Sender: TObject);
begin
  fillchar(schick1,sizeof(schick1),0);
  fillchar(schick2,sizeof(schick2),0);
  fillchar(schick3,sizeof(schick3),0);
  fillchar(schieber,sizeof(schieber),false);
  pb8p(sender);
end;

procedure Tfschickard.PB8MM(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var bo,ho:integer;
    maus:boolean;
begin
  bo:=(Paintbox1.width-i1.width) div 2+10;
  ho:=(Paintbox1.height-i1.height) div 2-20;
  maus:=false;
  if ((12<y-ho) and (y-ho<30)) or ((498-30<y-ho) and (y-ho<516-30)) or
    ((428-16<y-ho) and (y-ho<445-16)) then begin
    case x-bo of
     417..439,356..388,295..327,234..266,173..205,112..144,392..415,
     331..354,270..293,209..232,148..171,87..110 : maus:=true;
    end;
  end;
  if ((465<x-bo) and (x-bo<585)) or ((18<x-bo) and (x-bo<61)) then begin
    case y-ho of
     70..100,106..136,142..172,178..208,214..244,250..280, 286..316, 322..352 : maus:=true;
    end;
  end;
  if maus then Paintbox1.cursor:=crhandpoint else Paintbox1.cursor:=crdefault;
end;

procedure Tfschickard.D16C(Sender: TObject);
var k:string;
    i:integer;
begin
  D15C(Sender);
  schickzaehler:=0;
  pfeil:=0;
  schicka:=strtoint(edit2.text);
  if schicka=0 then begin
    schicka:=random(990)+10;
    edit2.text:=inttostr(schicka);
  end;
  schickb:=strtoint(edit1.text);
  if schickb=0 then begin
    schickb:=random(990)+10;
    edit1.text:=inttostr(schickb);
  end;
  k:=inttostr(schicka);
  fillchar(schickaz,sizeof(schickaz),0);
  for i:=1 to length(k) do schickaz[i-1]:=strtoint(k[length(k)-i+1]);
  k:=inttostr(schickb);
  fillchar(schickbz,sizeof(schickbz),0);
  for i:=1 to length(k) do schickbz[i-1]:=strtoint(k[length(k)-i+1]);
  timer2.enabled:=not timer2.enabled;
  if timer2.enabled then button2.caption:='Abbruch'
                    else button2.caption:='Multiplikation';
  if timer2.enabled then
    label5.caption:=' ·             = '+inttostr(schicka*schickb);
  pb8p(sender);
end;

procedure Tfschickard.Timer2Timer(Sender: TObject);
var g1,g2,gr,gr2,gr3,gr4,zu,nr,p,i:integer;
begin
  g1:=schickaz[0]+schickaz[1]+schickaz[2];
  g2:=schickbz[0]+schickbz[1]+schickbz[2];
  inc(schickzaehler);
//zahl a
  if (schickzaehler<=g1) then begin
    if schickzaehler<=schickaz[0] then begin
      inc(schick1[0]);
      pfeil:=1
    end else begin
      if schickzaehler<=schickaz[0]+schickaz[1] then begin
        inc(schick1[1]);
        pfeil:=2
      end else begin
        if schickzaehler<=schickaz[0]+schickaz[1]+schickaz[2] then begin
          inc(schick1[2]);
          pfeil:=3
        end;
      end;
    end;
  end;
//zahl b
  if (schickzaehler>g1) and (schickzaehler<=g1+g2) then begin
    if schickzaehler<=g1+schickbz[0] then begin
      inc(schick2[0]);
      pfeil:=4
    end else begin
      if schickzaehler<=g1+schickbz[0]+schickbz[1] then begin
        inc(schick2[1]);
        pfeil:=5
      end else begin
        if schickzaehler<=g1+schickbz[0]+schickbz[1]+schickbz[2] then begin
          inc(schick2[2]);
          pfeil:=6
        end
      end;
    end;
  end;
//1.schieber
  for i:=2 to 9 do schieber[i]:=false;
  gr:=g1+g2;
  gr2:=gr+(schick1[0]*schick2[0]) mod 10 +(schick1[0]*schick2[0]) div 10
         +(schick1[1]*schick2[0]) mod 10 +(schick1[1]*schick2[0]) div 10
         +(schick1[2]*schick2[0]) mod 10 +(schick1[2]*schick2[0]) div 10;
  gr3:=gr2+(schick1[0]*schick2[1]) mod 10 +(schick1[0]*schick2[1]) div 10
         +(schick1[1]*schick2[1]) mod 10 +(schick1[1]*schick2[1]) div 10
         +(schick1[2]*schick2[1]) mod 10 +(schick1[2]*schick2[1]) div 10;
  gr4:=gr3+(schick1[0]*schick2[2]) mod 10 +(schick1[0]*schick2[2]) div 10
         +(schick1[1]*schick2[2]) mod 10 +(schick1[1]*schick2[2]) div 10
         +(schick1[2]*schick2[2]) mod 10 +(schick1[2]*schick2[2]) div 10;
  if (schickzaehler>gr) and (schickzaehler<=gr2) then begin
    pfeil3:=schick2[0];
    pfeil2:=0;
    if schick2[0]>1 then schieber[schick2[0]]:=true;
    p:=schick1[0]*schick2[0];
    if schickzaehler<=gr+(p mod 10) then begin
      inc(schick3[0]);
      pfeil:=7
    end;
    if (schickzaehler>gr+(p mod 10)) and (schickzaehler<=gr+(p mod 10)+(p div 10)) then begin
      inc(schick3[1]);
      pfeil:=8
    end;
    if schickzaehler>gr+(p mod 10)+(p div 10) then begin
      pfeil2:=1;
      gr:=gr+(p mod 10)+(p div 10);
      p:=schick1[1]*schick2[0];
      if schickzaehler<=gr+(p mod 10) then begin
        inc(schick3[1]);
        pfeil:=8
      end;
      if (schickzaehler>gr+(p mod 10)) and (schickzaehler<=gr+(p mod 10)+p div 10) then begin
        inc(schick3[2]);
        pfeil:=9
      end;
      if schickzaehler>gr+(p mod 10)+(p div 10) then begin
        pfeil2:=2;
        gr:=gr+(p mod 10)+p div 10;
        p:=schick1[2]*schick2[0];
        if schickzaehler<=gr+(p mod 10) then begin
          inc(schick3[2]);
          pfeil:=9
        end;
        if (schickzaehler>gr+(p mod 10)) and (schickzaehler<=gr+(p mod 10)+p div 10) then begin
          inc(schick3[3]);
          pfeil:=10
        end;
      end;
    end;
  end;
  if (schickzaehler>gr2) and (schickzaehler<=gr3) then begin
    pfeil3:=schick2[1];
    pfeil2:=0;
    if schick2[1]>1 then schieber[schick2[1]]:=true;
    p:=schick1[0]*schick2[1];
    if schickzaehler<=gr2+(p mod 10) then begin
      inc(schick3[1]);
      pfeil:=8
    end;
    if (schickzaehler>gr2+(p mod 10)) and (schickzaehler<=gr2+(p mod 10)+(p div 10)) then begin
      inc(schick3[2]);
      pfeil:=9
    end;
    if schickzaehler>gr2+(p mod 10)+(p div 10) then begin
      pfeil2:=1;
      gr2:=gr2+(p mod 10)+(p div 10);
      p:=schick1[1]*schick2[1];
      if schickzaehler<=gr2+(p mod 10) then begin
        inc(schick3[2]);
        pfeil:=9
      end;
      if (schickzaehler>gr2+(p mod 10)) and (schickzaehler<=gr2+(p mod 10)+p div 10) then begin
        inc(schick3[3]);
        pfeil:=10
      end;
      if schickzaehler>gr2+(p mod 10)+(p div 10) then begin
        pfeil2:=2;
        gr2:=gr2+(p mod 10)+p div 10;
        p:=schick1[2]*schick2[1];
        if schickzaehler<=gr2+(p mod 10) then begin
          inc(schick3[3]);
          pfeil:=10
        end;
        if (schickzaehler>gr2+(p mod 10)) and (schickzaehler<=gr2+(p mod 10)+p div 10) then begin
          inc(schick3[4]);
          pfeil:=11
        end;
      end;
    end;
  end;
  if (schickzaehler>gr3) then begin
    pfeil3:=schick2[2];
    pfeil2:=0;
    if schick2[2]>1 then schieber[schick2[2]]:=true;
    p:=schick1[0]*schick2[2];
    if schickzaehler<=gr3+(p mod 10) then begin
      inc(schick3[2]);
      pfeil:=9
    end;
    if (schickzaehler>gr3+(p mod 10)) and (schickzaehler<=gr3+(p mod 10)+(p div 10)) then begin
      inc(schick3[3]);
      pfeil:=10
    end;
    if schickzaehler>gr3+(p mod 10)+(p div 10) then begin
      pfeil2:=1;
      gr3:=gr3+(p mod 10)+(p div 10);
      p:=schick1[1]*schick2[2];
      if schickzaehler<=gr3+(p mod 10) then begin
        inc(schick3[3]);
        pfeil:=10
      end;
      if (schickzaehler>gr3+(p mod 10)) and (schickzaehler<=gr3+(p mod 10)+p div 10) then begin
        inc(schick3[4]);
        pfeil:=11
      end;
      if schickzaehler>gr3+(p mod 10)+(p div 10) then begin
        pfeil2:=2;
        gr3:=gr3+(p mod 10)+p div 10;
        p:=schick1[2]*schick2[2];
        if schickzaehler<=gr3+(p mod 10) then begin
          inc(schick3[4]);
          pfeil:=11
        end;
        if (schickzaehler>gr3+(p mod 10)) and (schickzaehler<=gr3+(p mod 10)+p div 10) then begin
          inc(schick3[5]);
          pfeil:=12
        end;
      end;
    end;
  end;
  if (schickzaehler>gr4) then begin
    timer2.enabled:=false;
    for i:=2 to 9 do schieber[i]:=false;
    button2.caption:='Multiplikation';
  end;
  for i:=1 to 5 do begin
    if schick3[i]>9 then begin
      schick3[i]:=schick3[i]-10;
      inc(schick3[i+1])
    end;
  end;
  pb8p(sender);
end;

procedure Tfschickard.D18C(Sender: TObject);
begin
  schicka:=random(990)+10;
  edit2.text:=inttostr(schicka);
  schickb:=random(990)+10;
  edit1.text:=inttostr(schickb);
  d16c(sender);
end;

end.
