unit ukaleido;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  ExtCtrls, StdCtrls, Buttons, Spin;

type
  Tfkaleido = class(TForm)
    Panel1: TPanel;
    kaleido: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Paintbox1: TPaintBox;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    Label5: TLabel;
    Checkbox1: TCheckBox;
    Label1: TLabel;
    Memo1: TMemo;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Button3: TButton;
    procedure S7C(Sender: TObject);
    procedure Paintbox1Paint(Sender: TObject);
    procedure Paintwmf(can:tcanvas);
    procedure kaleidober(Sender: TObject);
    procedure D29C(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    pu,mi1,mi2,mi3,mix:array[0..90] of record x,y,z:double end;
    fla:array[0..90] of record a,b,c,m:integer; end;
    puzahl,flazahl:integer;
    superwi:double;
    ufaktor:double;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fkaleido: Tfkaleido;

implementation

uses math;
{$R *.DFM}

procedure Tfkaleido.S7C(Sender: TObject);
begin
  close;
end;

procedure Tfkaleido.Paintbox1Paint(Sender: TObject);
var bitmap:tbitmap;
begin
  kaleidober(sender);
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=Paintbox1.width;
  bitmap.height:=Paintbox1.height;
  paintwmf(bitmap.canvas);
  Paintbox1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure tfkaleido.kaleidober(Sender: TObject);
const radius=200;
      laenge:integer=140;
var i,anz:integer;
begin
  anz:=spinedit1.value;
  laenge:=spinedit3.value;
  superwi:=spinedit4.value*pi/180;
  for i:=0 to anz-1 do begin
    if not odd(i) then begin
      pu[2*i].x:=(radius-cos(superwi)*laenge)*cos(i*2*pi/anz+pi/32);
      pu[2*i].y:=(radius-cos(superwi)*laenge)*sin(i*2*pi/anz+pi/32);
      pu[2*i+1].x:=(radius+cos(superwi)*laenge)*cos(i*2*pi/anz+pi/32);
      pu[2*i+1].y:=(radius+cos(superwi)*laenge)*sin(i*2*pi/anz+pi/32);
      pu[2*i].z:=sin(superwi)*laenge;
      pu[2*i+1].z:=-sin(superwi)*laenge;
    end else begin
      pu[2*i].x:=(radius-sin(superwi)*laenge)*cos(i*2*pi/anz+pi/32);
      pu[2*i].y:=(radius-sin(superwi)*laenge)*sin(i*2*pi/anz+pi/32);
      pu[2*i+1].x:=(radius+sin(superwi)*laenge)*cos(i*2*pi/anz+pi/32);
      pu[2*i+1].y:=(radius+sin(superwi)*laenge)*sin(i*2*pi/anz+pi/32);
      pu[2*i].z:=-cos(superwi)*laenge;
      pu[2*i+1].z:=cos(superwi)*laenge;
    end;
  end;
  puzahl:=2*anz;
  for i:=puzahl to puzahl+8 do pu[i]:=pu[i-puzahl];

  flazahl:=0;
  for i:=0 to anz-1 do begin
    if odd(i) then begin
      fla[flazahl].a:=2*i;
      fla[flazahl].b:=2*i+1;
      fla[flazahl].c:=2*i+2;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
      fla[flazahl].a:=2*i;
      fla[flazahl].b:=2*i+3;
      fla[flazahl].c:=2*i+1;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
      fla[flazahl].a:=2*i;
      fla[flazahl].b:=2*i+2;
      fla[flazahl].c:=2*i+3;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
      fla[flazahl].a:=2*i+1;
      fla[flazahl].b:=2*i+3;
      fla[flazahl].c:=2*i+2;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
    end else begin
      fla[flazahl].a:=2*i;
      fla[flazahl].b:=2*i+2;
      fla[flazahl].c:=2*i+1;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
      fla[flazahl].a:=2*i;
      fla[flazahl].b:=2*i+1;
      fla[flazahl].c:=2*i+3;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
      fla[flazahl].a:=2*i;
      fla[flazahl].b:=2*i+3;
      fla[flazahl].c:=2*i+2;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
      fla[flazahl].a:=2*i+1;
      fla[flazahl].b:=2*i+2;
      fla[flazahl].c:=2*i+3;
      fla[flazahl].m:=flazahl;
      inc(flazahl);
    end;
  end;
  for i:=0 to flazahl-1 do begin
    mi1[i].x:=(2*pu[fla[i].a].x+pu[fla[i].b].x+pu[fla[i].c].x)/4;
    mi1[i].y:=(2*pu[fla[i].a].y+pu[fla[i].b].y+pu[fla[i].c].y)/4;
    mi1[i].z:=(2*pu[fla[i].a].z+pu[fla[i].b].z+pu[fla[i].c].z)/4;
    mi2[i].x:=(pu[fla[i].a].x+2*pu[fla[i].b].x+pu[fla[i].c].x)/4;
    mi2[i].y:=(pu[fla[i].a].y+2*pu[fla[i].b].y+pu[fla[i].c].y)/4;
    mi2[i].z:=(pu[fla[i].a].z+2*pu[fla[i].b].z+pu[fla[i].c].z)/4;
    mi3[i].x:=(pu[fla[i].a].x+pu[fla[i].b].x+2*pu[fla[i].c].x)/4;
    mi3[i].y:=(pu[fla[i].a].y+pu[fla[i].b].y+2*pu[fla[i].c].y)/4;
    mi3[i].z:=(pu[fla[i].a].z+pu[fla[i].b].z+2*pu[fla[i].c].z)/4;
  end;
end;

procedure Tfkaleido.Paintwmf(can:tcanvas);
var ff,mx,my,i:integer;
    wi:double;
    pp:array[0..100] of tpoint;
    reihenfolge:array[0..100] of integer;
    dr:array[0..5] of tpoint;
  procedure drehen;
  var i:integer;
      x,z:double;
  begin
    for i:=0 to puzahl+4 do begin
      x:=cos(wi)*pu[i].x+sin(wi)*pu[i].z;
      z:=-sin(wi)*pu[i].x+cos(wi)*pu[i].z;
      pu[i].x:=x;
      pu[i].z:=z;
    end;
    for i:=0 to flazahl-1 do begin
      x:=cos(wi)*mi1[i].x+sin(wi)*mi1[i].z;
      z:=-sin(wi)*mi1[i].x+cos(wi)*mi1[i].z;
      mi1[i].x:=x;
      mi1[i].z:=z;
      x:=cos(wi)*mi2[i].x+sin(wi)*mi2[i].z;
      z:=-sin(wi)*mi2[i].x+cos(wi)*mi2[i].z;
      mi2[i].x:=x;
      mi2[i].z:=z;
      x:=cos(wi)*mi3[i].x+sin(wi)*mi3[i].z;
      z:=-sin(wi)*mi3[i].x+cos(wi)*mi3[i].z;
      mi3[i].x:=x;
      mi3[i].z:=z;
    end;
  end;
  procedure sortieren;
  var i,j,h:integer;
      hr:double;
  begin
    for i:=0 to flazahl-2 do begin
      for j:=i+1 to flazahl-1 do begin
        if mix[i].x>mix[j].x then begin
          h:=reihenfolge[i];
          reihenfolge[i]:=reihenfolge[j];
          reihenfolge[j]:=h;
          hr:=mix[i].x;
          mix[i].x:=mix[j].x;
          mix[j].x:=hr;
        end;
      end;
    end;
  end;
  function test(a,b,c:integer):boolean;
  var ay,az,by,bz,vx:double;
  begin
    test:=true;
    ay:=pu[b].y-pu[a].y;
    az:=pu[b].z-pu[a].z;
    by:=pu[c].y-pu[a].y;
    bz:=pu[c].z-pu[a].z;
    vx:=ay*bz-az*by;
    if vx<0 then test:=false;
  end;
begin
  mx:=Paintbox1.width div 2;
  my:=Paintbox1.height div 2;
  wi:=spinedit2.value*pi/180;
  superwi:=spinedit4.value*pi/180;
  drehen;
  for i:=0 to puzahl-1 do begin
    pp[i].x:=round(mx+pu[i].y/ufaktor);
    pp[i].y:=round(my-pu[i].z/ufaktor);
  end;
  for i:=puzahl to puzahl+8 do pp[i]:=pp[i-puzahl];
  for i:=0 to flazahl-1 do reihenfolge[i]:=i;
  for i:=0 to flazahl-1 do
    mix[i].x:=max(mi1[i].x,max(mi2[i].x,mi3[i].x));
  sortieren;
  can.pen.color:=clnavy;
  for i:=0 to flazahl-1 do begin
    ff:=255-(102 div flazahl)*abs(flazahl-i);
    if test(fla[reihenfolge[i]].a,fla[reihenfolge[i]].b,fla[reihenfolge[i]].c) then begin
      dr[0].x:=pp[fla[reihenfolge[i]].a].x;
      dr[0].y:=pp[fla[reihenfolge[i]].a].y;
      dr[1].x:=pp[fla[reihenfolge[i]].b].x;
      dr[1].y:=pp[fla[reihenfolge[i]].b].y;
      dr[2].x:=pp[fla[reihenfolge[i]].c].x;
      dr[2].y:=pp[fla[reihenfolge[i]].c].y;
      can.brush.color:=rgb(ff,ff,255);
      can.polygon(slice(dr,3));
    end;
  end;
end;

procedure Tfkaleido.D29C(Sender: TObject);
begin
  timer1.enabled:=not timer1.enabled;
  if timer1.enabled then button2.caption:='Abbruch'
                    else button2.caption:='Animation';
end;

procedure Tfkaleido.Timer1Timer(Sender: TObject);
var x:integer;
begin
  if not Checkbox1.checked then begin
    x:=spinedit4.value-1;
    if x<0 then x:=359;
  end else begin
    x:=spinedit4.value+1;
    if x>spinedit4.maxvalue then x:=1;
  end;
  spinedit4.value:=x;
end;

procedure Tfkaleido.Button3Click(Sender: TObject);
begin
  ufaktor:=ufaktor*1.1;
  paintbox1paint(sender);
end;

procedure Tfkaleido.Button1Click(Sender: TObject);
begin
  ufaktor:=ufaktor/1.1;
  paintbox1paint(sender);
end;

procedure Tfkaleido.FormShow(Sender: TObject);
begin
  ufaktor:=1.0;
end;

end.

