unit usterne;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Mask, Zlib, Spin;

type
  TFpoly = class(TForm)
    Panel3: TPanel;
    Panel4: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    S2: TSpeedButton;
    S3: TSpeedButton;
    S1: TSpeedButton;
    Panel7: TPanel;
    Panel6: TPanel;
    PB1: TPaintBox;
    Timer1: TTimer;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    CB2: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Timer2: TTimer;
    R5: TRadioButton;
    R2: TRadioButton;
    R4: TRadioButton;
    LB1: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Rx1: TSpinEdit;
    Rx2: TSpinEdit;
    procedure LB1C(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure B1C(Sender: TObject);
    procedure zeichnen(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure B2C(Sender: TObject);
    procedure S8C(Sender: TObject);
    procedure S9C(Sender: TObject);
    procedure S1C(Sender: TObject);
    procedure PB1MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MM(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB1MU(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure zeichnenx(canvas:tcanvas);
    procedure T3C(Sender: TObject);
    procedure Rx1Change(Sender: TObject);
    procedure CB2C(Sender: TObject);
    procedure Rx2Change(Sender: TObject);
    procedure D3C(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure drehen(x,y,z:double);
    procedure FormShow(Sender: TObject);
  private
    kabbruch:boolean;
    listenr:integer;
    nichtschalten:boolean;
    supersternzahl:integer;
    superfaktor:double;
    aktuellefarbennummer:integer;
    live:boolean;
    x_alt:integer;
    y_alt:integer;
    hpunkte:boolean;
    vrichtung:boolean;
    polyedernummer:integer;
    winkelx,winkely,winkelz,
    winkelax,winkelay,winkelaz:double;
    z:double;
    sanzahl,verdecktzahl,vx,vy:integer;
    filelines:array[0..500] of string;
    mittel:array[0..500] of record x,y,z:double; f:integer end;
    stumpfpunkte:array[1..210] of record a,b:integer end;
    listempoly1,listempoly2:tstringlist;
    Bitmap: TBitmap;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPoly: TFPoly;

implementation

uses  math;

const pino = pi/180;
      farben: array[0..28] of longint =
         ($00000000,$00800000,$000000FF,$00FF00FF,$00008000,$00800080,$0000FFFF,$00404040,
          $0000FF00,$00cccccc,$00808080,$00ff0000,$00000080,$00ffff00,$00008080,$00c0c0c0,
          $00808000,$000000c0,$0000c000,$00c00000,$0000c0c0,$00c000c0,$00c0c000,$00FFFFCC,
          $00CCFFFF,$00CCFFCC,$00CCCCFF,$00ffffff,$00cccc99);

type ttriple=record x,y,z:double end;
var  t:array[0..260] of ttriple;
{$R *.DFM}

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

procedure listeres(liste:tstringlist;const kk:string);
var ms1: TResourcestream;
    ms2: TMemoryStream;
begin
    ms1 := TResourceStream.Create(hinstance,kk,RT_RCDATA);
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

procedure split3(kk:string;var a,b,c:double);
var code:integer;
begin
  val(copy(kk,1,pos(' ',kk)-1),a,code);
  if code>0 then a:=0;
  delete(kk,1,pos(' ',kk));
  val(copy(kk,1,pos(' ',kk)-1),b,code);
  if code>0 then b:=0;
  delete(kk,1,pos(' ',kk));
  val(kk,c,code);
  if code>0 then c:=0;
end;

procedure TFpoly.LB1C(Sender: TObject);
begin
  timer1.interval:=0;
  timer2.enabled:=false;
  button2.caption:='Rotation';
  formshow(sender);
  b1c(sender);
end;

procedure TFpoly.FormCreate(Sender: TObject);
begin
  Bitmap := TBitmap.Create;
  Bitmap.pixelformat := pf32bit;
  listempoly1:=tstringlist.create;
  listeres(listempoly1,'mpoly1');
  listempoly2:=tstringlist.create;
  listeres(listempoly2,'mpoly2');

  lb1.DoubleBuffered:=true;
  lb1.itemindex:=0;
  polyedernummer:=0;
  winkelx:=0.25;
  winkely:=0;
  winkelz:=0;
  z:=150;
  kabbruch:=true;
  timer1.interval:=0;
  timer2.enabled:=false;
  button2.caption:='Rotation';
  rx2.value:=50;
  rx2.minvalue:=-50;
  rx2.maxvalue:=200;
  r4.checked:=true;
  polyedernummer:=0;
  formshow(sender);
end;

procedure TFpoly.B1C(Sender: TObject);
var i:integer;
    kk:string;
    maxz:double;

  procedure sternbildung;
  var i,m,anz,sanzahlalt,p,jx,xxx:integer;
      k:string;
      faktor,qx,qy,qz:double;
      filelinesneu:array[0..500] of string;
  begin
    for i:=1 to 210 do begin
      stumpfpunkte[i].a:=-1;
      stumpfpunkte[i].b:=-1
    end;
    sanzahlalt:=sanzahl;
    faktor:=rx2.value/100;
    anz:=sanzahl-1;
    supersternzahl:=verdecktzahl;
    superfaktor:=faktor;
    for i:=0 to sANZAHLalt-1 do filelinesneu[i]:=filelines[i]+filelines[i][1];
    for i:=0 to anz do begin
      k:=filelinesneu[i];
      t[verdecktzahl].x:=mittel[i].x+mittel[i].x*faktor;
      t[verdecktzahl].y:=mittel[i].y+mittel[i].y*faktor;
      t[verdecktzahl].z:=mittel[i].z+mittel[i].z*faktor;
      for m:=1 to length(k)-1 do begin
        filelines[sanzahl]:=k[m]+k[m+1]+chr(verdecktzahl+48);
        inc(sanzahl);
      end;
      inc(verdecktzahl);
    end;

    for i:=sanzahlalt to sanzahl do
      filelines[i-sanzahlalt]:=filelines[i];
    sanzahl:=sanzahl-sanzahlalt;
    rx1.maxvalue:=sanzahl;
    rx1.value:=sanzahl;
    for i:=0 to sANZAHL-1 do begin
      kk:=filelines[i];
      xxx:=length(kk);
      qx:=0;
      qy:=0;
      qz:=0;
      for jx:=1 to xxx do begin
        p:=ord(kk[jx])-48;
        qx:=qx+t[p].x;
        qy:=qy+t[p].y;
        qz:=qz+t[p].z;
      end;
      mittel[i].x:=qx/xxx;
      mittel[i].y:=qy/xxx;
      mittel[i].z:=qz/xxx;
      mittel[i].f:=(i mod 18)+1;
    end;
  end;

  procedure zusatzflaechen;
  var i,jx,xxx,p:integer;
      kk,kl:string;
      qx,qy,qz:double;
  begin
    listenr:=0;
    kk:='['+inttostr(polyedernummer)+']';
    listenr:=listempoly2.indexof(kk)+1;
    sanzahl:=strtoint(listempoly2[listenr]);
    inc(listenr);
    rx1.maxvalue:=sanzahl;
    rx1.value:=sanzahl;
    for i:=0 to sANZAHL-1 do begin
      kk:=listempoly2[listenr];
      inc(listenr);
      kl:=kk;
      kk:=trimleft(kk);
      xxx:=length(kk);
      qx:=0;
      qy:=0;
      qz:=0;
      for jx:=1 to xxx do begin
        p:=ord(kk[jx])-48;
        qx:=qx+t[p].x;
        qy:=qy+t[p].y;
        qz:=qz+t[p].z;
      end;
      mittel[i].x:=qx/xxx;
      mittel[i].y:=qy/xxx;
      mittel[i].z:=qz/xxx;
      mittel[i].f:=(i mod 23)+1;
      filelines[i]:=kl;
    end;
  end;

  procedure vordrehen2;
  var i:integer;
      x0,y0:double;
      swi,swi2,cwi2,cwi:extended;
  begin
    SinCos(pino*20,swi,cwi);
    SinCos(-pino*80,swi2,cwi2);
    for i:=0 to verdecktzahl-1 do begin
      x0:=cwi*t[i].x-swi*t[i].y;
      t[i].y:=swi*t[i].x+cwi*t[i].y;
      t[i].x:=x0;
      y0:=cwi2*t[i].y-swi2*t[i].z;
      t[i].z:=swi2*t[i].y+cwi2*t[i].z;
      t[i].y:=y0;
    end;
    for i:=0 to sanzahl-1 do begin
      x0:=cwi*mittel[i].x-swi*mittel[i].y;
      mittel[i].y:=swi*mittel[i].x+cwi*mittel[i].y;
      mittel[i].x:=x0;
      y0:=cwi2*mittel[i].y-swi2*mittel[i].z;
      mittel[i].z:=swi2*mittel[i].y+cwi2*mittel[i].z;
      mittel[i].y:=y0;
    end;
  end;
  procedure eckeladen(i:integer);
  begin
    kk:=listempoly1[listenr];
    inc(listenr);
    split3(kk,t[i].x,t[i].y,t[i].z);
    maxz:=max(1.0*t[i].x,maxz);
    maxz:=max(1.0*t[i].y,maxz);
    maxz:=max(1.0*t[i].z,maxz);
  end;
begin
  nichtschalten:=true;
  winkelax:=0;
  winkelay:=0;
  kk:='['+inttostr(polyedernummer)+']';
  listenr:=listempoly1.indexof(kk)+1;
  verdecktzahl:=strtoint(listempoly1[listenr]); inc(listenr);
  maxz:=0;
  for i:=0 to verdecktzahl-1 do begin
    eckeladen(i);
    t[i].x:=z*t[i].x;
    t[i].y:=z*t[i].y;
    t[i].z:=z*t[i].z;
  end;
  zusatzflaechen;
  sternbildung;
  vordrehen2;
  zeichnen(sender);
  nichtschalten:=false;
end;

procedure tfpoly.zeichnenx(canvas:tcanvas);
var sanzahl_a:integer;
procedure farbeholen(anz:integer);
begin
  if r4.checked then
    canvas.brush.color:= farben[aktuellefarbennummer];
end;

procedure bildmalen;
var k,j,xxx:integer;
  procedure setstart(nr:integer);
  begin
    canvas.MoveTo(round(t[nr].x+vx),round(t[nr].y+vy));
  end;
  procedure drawline(nr:integer);
  begin
    canvas.lineTo(round(t[nr].x)+vx,round(t[nr].y)+vy);
    if hpunkte then begin
      canvas.brush.color:=clyellow;
      canvas.ellipse(round(t[nr].x)+vx-4,round(t[nr].y)+vy-4,round(t[nr].x)+vx+5,round(t[nr].y)+vy+5);
      canvas.brush.style:=bsclear;
    end;
  end;

  procedure drawpoly(const flx:string);
  var poi:array[0..100] of tpoint;
      anz,i,p,altfarbe:integer;
  begin
    anz:=length(flx);
    farbeholen(anz);
    for i:=1 to anz do begin
      p:=ord(flx[i])-48;
      poi[i-1].x:=round(t[p].x+vx);
      poi[i-1].y:=round(t[p].y+vy);
    end;
    canvas.polygon(slice(poi,anz));
    if hpunkte then begin
      altfarbe:=canvas.brush.color;
      canvas.brush.color:=clyellow;
      for i:=1 to anz do begin
        p:=ord(flx[i])-48;
        canvas.ellipse(round(t[p].x+vx-4),round(t[p].y+vy-4),round(t[p].x+vx+5),round(t[p].y+vy+5));
      end;
      canvas.brush.color:=altfarbe;
    end;
  end;

  procedure unsichtbar;
  var reihe:array[0..400] of real;
      reihenfarbe:array[0..400] of integer;
      reihenfolge:array[0..400] of integer;
      i,j,k,janz,hf,hg:integer;
      h,h0:real;
  begin
    janz:=0;
    for i:=0 to sanzahl_a-1 do begin
      reihe[janz]:=mittel[i].z;
      reihenfarbe[janz]:=mittel[i].f;
      reihenfolge[janz]:=janz;
      inc(janz);
    end;
    for i:=0 to janz-1 do begin
      h:=reihe[i];
      hf:=reihenfolge[i];
      hg:=reihenfarbe[i];
      k:=i;
      for j:=i+1 to janz-1 do begin
        h0:=reihe[j];
        if h0>h then begin
          k:=j;
          h:=h0;
          hf:=reihenfolge[j];
          hg:=reihenfarbe[j]
        end;
      end;
      reihe[k]:=reihe[i];
      reihenfarbe[k]:=reihenfarbe[i];
      reihenfolge[k]:=reihenfolge[i];
      aktuellefarbennummer:=hg;
      drawpoly(filelines[hf]);
    end;
  end;

begin
  if r5.checked then begin
    for k:=0 to sanzahl_a-1 do begin
      xxx:=ord(filelines[k][1])-48;
      setstart(xxx);
      for j:=2 to length(filelines[k]) do drawline(ord(filelines[k][j])-48);
      drawline(xxx);
    end;
  end
  else unsichtbar;
end;

begin
  vx:=pb1.width div 2;
  vy:=pb1.height div 2;
  sanzahl_a:=round(rx1.value);
  bildmalen;
end;

procedure TFpoly.zeichnen(Sender: TObject);
begin
  Bitmap.Width := panel6.Width;
  Bitmap.Height := panel6.Height;
  bitmap.canvas.Brush.color:=clwhite;
  bitmap.canvas.rectangle(-1,-1,bitmap.width+1,bitmap.height+1);
  zeichnenx(bitmap.canvas);
  pb1.canvas.draw(0,0,bitmap);
end;

procedure TFpoly.drehen(x,y,z:double);
var i:integer;
    x0,y0:double;
    swi,swi2,cwi2,swi3,cwi3,cwi:extended;
begin
  SinCos(pino*x,swi,cwi);
  SinCos(pino*y,swi2,cwi2);
  SinCos(pino*z,swi3,cwi3);
  for i:=0 to verdecktzahl-1 do begin
    x0:=cwi*t[i].x-swi*t[i].y;
    t[i].y:=swi*t[i].x+cwi*t[i].y;
    t[i].x:=x0;
    y0:=cwi2*t[i].y-swi2*t[i].z;
    t[i].z:=swi2*t[i].y+cwi2*t[i].z;
    t[i].y:=y0;
    y0:=cwi3*t[i].x-swi3*t[i].z;
    t[i].z:=swi3*t[i].x+cwi3*t[i].z;
    t[i].x:=y0;
  end;
  for i:=0 to sanzahl-1 do begin
    x0:=cwi*mittel[i].x-swi*mittel[i].y;
    mittel[i].y:=swi*mittel[i].x+cwi*mittel[i].y;
    mittel[i].x:=x0;
    y0:=cwi2*mittel[i].y-swi2*mittel[i].z;
    mittel[i].z:=swi2*mittel[i].y+cwi2*mittel[i].z;
    mittel[i].y:=y0;
    y0:=cwi3*mittel[i].x-swi3*mittel[i].z;
    mittel[i].z:=swi3*mittel[i].x+cwi3*mittel[i].z;
    mittel[i].x:=y0;
  end;
end;

procedure TFpoly.Timer1Timer(Sender: TObject);
begin
  winkelax:=winkelax+winkelx;
  winkelay:=winkelay+winkely;
  winkelaz:=winkelaz+winkelz;
  drehen(winkelx,winkely,winkelz);
  zeichnen(sender);
end;

procedure TFpoly.B2C(Sender: TObject);
begin
  if timer1.interval=0 then begin
    timer1.interval:=1;
    button2.caption:='Abbruch';
    if (winkelx=0) and (winkely=0) and (winkelz=0) then winkelz:=0.25;
  end else begin
    timer1.interval:=0;
    button2.caption:='Rotation';
  end;
end;

procedure TFpoly.S8C(Sender: TObject);
var i:integer;
begin
  Z:=1.1*z;
  for i:=0 to verdecktzahl-1 do begin
    t[i].x:=1.1*t[i].x;
    t[i].y:=1.1*t[i].y;
    t[i].z:=1.1*t[i].z;
  end;
  zeichnen(sender);
end;

procedure TFpoly.S9C(Sender: TObject);
var i:integer;
begin
  Z:=z/1.1;
  for i:=0 to verdecktzahl-1 do begin
    t[i].x:=t[i].x/1.1;
    t[i].y:=t[i].y/1.1;
    t[i].z:=t[i].z/1.1;
  end;
  zeichnen(sender);
end;

procedure TFpoly.S1C(Sender: TObject);
var i:integer;
begin
  for i:=0 to verdecktzahl-1 do begin
    t[i].x:=t[i].x/z*150;
    t[i].y:=t[i].y/z*150;
    t[i].z:=t[i].z/z*150;
  end;
  z:=150;
  zeichnen(sender);
end;

procedure TFpoly.PB1MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button=mbleft then begin
    live:=true;
    x_alt:=x;
    y_alt:=y;
  end;
end;

procedure TFpoly.PB1MM(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if live then begin
    if (x<>x_alt) or (y<>y_alt) then begin
      drehen(x_alt-x,y_alt-y,0);
      zeichnen(sender);
      x_alt:=x;
      y_alt:=y;
    end;
  end;
end;

procedure TFpoly.PB1MU(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  live:=false;
  x_alt:=0;
  y_alt:=0;
end;

procedure TFpoly.T3C(Sender: TObject);
begin
  if sender=spinedit1 then winkelx:=spinedit1.value*0.25;
  if sender=spinedit2 then winkely:=spinedit2.value*0.25;
  if sender=spinedit3 then winkelz:=spinedit3.value*0.25;
  if kabbruch then zeichnen(sender);
end;

procedure TFpoly.Rx1Change(Sender: TObject);
begin
  if kabbruch and (not nichtschalten) then zeichnen(sender);
end;

procedure TFpoly.CB2C(Sender: TObject);
begin
  hpunkte:=cb2.checked;
  zeichnen(sender);
end;

procedure TFpoly.Rx2Change(Sender: TObject);
var i:integer;
    faktor:double;
begin
  if (not nichtschalten) then begin
      faktor:=rx2.value/100;
      for i:=supersternzahl to verdecktzahl-1 do begin
        t[i].x:=(1+faktor)*t[i].x/(1+superfaktor);
        t[i].y:=(1+faktor)*t[i].y/(1+superfaktor);
        t[i].z:=(1+faktor)*t[i].z/(1+superfaktor);
      end;
      superfaktor:=faktor;
      zeichnen(sender);
  end;
end;

procedure TFpoly.D3C(Sender: TObject);
begin
  timer2.enabled:=not timer2.enabled;
end;

procedure TFpoly.Timer2Timer(Sender: TObject);
begin
  if vrichtung then begin
    rx2.value:=rx2.value-1;
    if rx2.value=rx2.MinValue then vrichtung:=not vrichtung;
  end else begin
    rx2.value:=rx2.value+1;
    if rx2.value=rx2.MaxValue then vrichtung:=not vrichtung;
  end;
end;

procedure TFpoly.FormDestroy(Sender: TObject);
begin
  listempoly1.free;
  listempoly2.free;
  Bitmap.Free;
end;

procedure TFpoly.FormShow(Sender: TObject);
var k2:string;
begin
  k2:=lb1.Items.strings[lb1.itemindex];
  polyedernummer:=strtoint(copy(k2,pos(#9,k2)+1,10));
end;

end.

