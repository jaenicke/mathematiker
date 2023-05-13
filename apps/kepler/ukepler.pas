unit ukepler;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    PaintBox1: TPaintBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    SpinEdit3: TSpinEdit;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Paintbox1P(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    kep1,kep2:integer;
    ob,ob2:array[0..160] of tpoint;
    totalzeit1,totalzeit2,totalzeit3,totalzeit4,
    frequenz,abbruchtime:TLargeInteger;       // Zählerstand 1
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Paintbox1P(Sender: TObject);
var a,b,e,epsilon,wkepler,
    wi,
    a2,e2,b2,epsilon2,wkepler2:double;
    i,mx,my,xp,yp,xp2,yp2:integer;
    punkte:array[0..460] of tpoint;
    k:string;
    bitmap:tbitmap;
    can:tcanvas;

 //Lösung der Kepler-Gleichung
 function keplerg(m,e:double):double;
  var ea,eo:double;
  begin
    ea:=m;
    eo:=0;
    while abs(eo-ea)>0.007 do begin
      eo:=ea;
      ea:=m+e*sin(ea);
    end;
    keplerg:=ea;
    //wahre anomalie
  end;

begin
  bitmap:=tbitmap.create;
  bitmap.width:=paintbox1.width;
  bitmap.height:=paintbox1.height;
  can:=bitmap.canvas;
  can.Font.name:='Verdana';

  QueryPerformanceFrequency (frequenz);      // Frequenz des Zählers
  abbruchtime:=frequenz div 2;

  xp2:=0;
  yp2:=0;
  //Werte der Planetenbahnen
  epsilon:=spinedit1.value/100;
  a:=(bitmap.width-150)/2;
  e:=a*epsilon;
  b:=sqrt(a*a-e*e);
  if b>(bitmap.height-80)/2 then begin
    b:=(bitmap.height-80)/2;
    a:=sqrt(b*b/(1-epsilon*epsilon));
    e:=a*epsilon;
  end;
  epsilon2:=spinedit2.value/100;
  a2:=a*0.629961;
  e2:=a2*epsilon2;
  b2:=sqrt(a2*a2-e2*e2);

  //Halbachsen
  mx:=bitmap.width div 2;
  my:=bitmap.height div 2;
  can.pen.color:=clgreen;
  can.moveto(round(mx-a-10),my);
  can.lineto(round(mx+a+10),my);
  can.moveto(mx,round(my-b-10));
  can.lineto(mx,round(my+b+10));

  //Zeichnung der Ellipsensegmente beim 2.Gesetz
  if radiobutton2.checked then begin
    can.pen.color:=clgray;
    //1.Fläche
    if kep1>0 then begin
      can.brush.style:=bsbdiagonal;
      can.brush.color:=clyellow;
      for i:=0 to kep1-1 do begin
        punkte[i].x:=ob[i].x;
        punkte[i].y:=ob[i].y;
      end;
      punkte[kep1].x:=round(mx-e);
      punkte[kep1].y:=my;
      can.polygon(slice(punkte,kep1+1));
    end;
    //2.Fläche
    if kep2>0 then begin
      can.brush.style:=bsbdiagonal;
      can.brush.color:=cllime;
      for i:=0 to kep2-1 do begin
        punkte[i].x:=ob2[i].x;
        punkte[i].y:=ob2[i].y;
      end;
      punkte[kep2].x:=round(mx-e);
      punkte[kep2].y:=my;
      can.polygon(slice(punkte,kep2+1));
    end;
    can.brush.style:=bssolid;
    if (spinedit3.value>300) and (spinedit3.value<310) then begin
      kep1:=0;
      kep2:=0;
    end;
  end;

  //Planetenbahnen
  can.pen.color:=clblue;
  can.brush.style:=bsclear;
  can.ellipse(round(mx-a),round(my-b),round(mx+a+1),round(my+b+1));
  if radiobutton3.checked then
    can.ellipse(round(mx-e+e2-a2),round(my-b2),round(mx-e+e2+a2+1),round(my+b2+1));

  //Berechnung des 1.Planeten
  wi:=spinedit3.value*pi/180;
  wkepler:=keplerg(wi,epsilon);
  xp:=round(mx-a*cos(wkepler));
  yp:=round(my-b*sin(wkepler));
  can.pen.color:=clfuchsia;
  can.moveto(round(mx-e),my);
  can.lineto(xp,yp);
  can.pen.color:=clyellow;
  can.brush.color:=clyellow;
  can.ellipse(round(mx-e-10),my-10,round(mx-e+11),my+11);
  //v(r) = sqrt(g M (2/r - 1/a))
  can.pen.color:=clblack;
  can.brush.color:=clred;
  can.ellipse(xp-5,yp-5,xp+6,yp+6);

  //Lage des 2.Planeten
  if radiobutton3.checked then begin
    wi:=2*spinedit3.value*pi/180+pi/4;
    wkepler2:=keplerg(wi,epsilon2);
    xp2:=round(mx-e+e2-a2*cos(wkepler2));
    yp2:=round(my-b2*sin(wkepler2));
    can.brush.color:=clnavy;
    can.ellipse(xp2-5,yp2-5,xp2+6,yp2+6);
  end;

  //Zeitabhängige Flächen beim 2.Gesetz ermitteln
  if radiobutton2.checked then begin
    if (spinedit3.value=20) then begin
      kep1:=0;
      QueryPerformanceCounter(totalzeit1);       // Zählerstand 1
    end;
    if (spinedit3.value>20) then begin
      QueryPerformanceCounter(totalzeit2);
      if totalzeit2-totalzeit1<abbruchtime then begin
        ob[kep1].x:=xp;
        ob[kep1].y:=yp;
        inc(kep1);
      end;
    end;
    if spinedit3.value=round(180+20*(1+epsilon)) then begin
      kep2:=0;
      QueryPerformanceCounter(totalzeit3);       // Zählerstand 1
    end;
    if (spinedit3.value>round(180+20*(1+epsilon))) then begin
      QueryPerformanceCounter(totalzeit4);
      if totalzeit4-totalzeit3<abbruchtime then begin
        ob2[kep2].x:=xp;
        ob2[kep2].y:=yp;
        inc(kep2);
      end;
    end;
  end;

  can.brush.style:=bsclear;
  can.font.color:=clblack;
  k:='Sonne';
  can.textout(round(mx-e-can.textwidth(k) div 2),my+10,k);
  k:='Planet';
  can.textout(xp-can.textwidth(k) div 2,yp+9,k);
  if radiobutton3.checked then
    can.textout(xp2-can.textwidth(k) div 2,yp2+9,k);
  paintbox1.Canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   kep1:=0;
   kep2:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   timer1.Enabled:=not timer1.Enabled;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var x:integer;
begin
   x:=spinedit3.value+1;
   if x>spinedit3.MaxValue then x:=spinedit3.minvalue;
   spinedit3.Value:=x;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
   kep1:=0;
   kep2:=0;
   paintbox1p(sender);
end;

end.
