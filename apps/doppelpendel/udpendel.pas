unit udpendel;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
    TVector = object
              werte:array[1..4] of real;
              procedure Copy(var Copier:TVector);
              procedure Mal(x:real);
              procedure Plus(var x:TVector);
            end;
    TVectorex = object
              werte:array[1..4] of extended;
              procedure Copy(var Copier:TVectorex);
              procedure Mal(x:extended);
              procedure Plus(var x:TVectorex);
            end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    paintbox1: TPaintBox;
    L1: TLabel;
    L2: TLabel;
    L12: TLabel;
    L9: TLabel;
    L10: TLabel;
    L11: TLabel;
    L3: TLabel;
    L5: TLabel;
    L6: TLabel;
    L7: TLabel;
    L13: TLabel;
    E1: TEdit;
    E2: TEdit;
    E4: TEdit;
    E5: TEdit;
    E7: TEdit;
    czwei: TCheckBox;
    d2: TButton;
    UpDown1: TUpDown;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown2: TUpDown;
    c_spur: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label2: TLabel;
    procedure d2Click(Sender: TObject);
    procedure d1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel2Resize(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const zweipi=2*pi;
var
    omegaq,deltat:real;
    XX,xx2,Deltax:TVector;
    xx2x,deltaex:tvectorex;
    ketteeinzel,abbruch:boolean;

function ein_real(const edit:tedit;min,max:real):real;
var kk:string;
    i,code:integer;
    we:real;
begin
    kk:=edit.text;
    if kk<>'' then
       for i:=1 to length(kk) do kk[i]:=upcase(kk[i]);
    while pos(',',kk)<>0 do kk[pos(',',kk)]:='.';
    val(kk,we,code);
    if code<>0 then we:=0;
    if we<min then we:=min;
    if we>max then we:=max;
    ein_real:=we;
end;

function  _strkomma(a:real;b,c:byte):string;
var ks:string;
begin
   str(a:b:c,ks);
   if c<>0 then
   begin
      while (length(ks)>1) and (ks[length(ks)]='0') do delete(ks,length(ks),1);
      if (length(ks)>1) and (ks[length(ks)]='.') then delete(ks,length(ks),1);
   end;
   if ks='-0' then ks:='0';
   if pos('.',ks)>0 then ks[pos('.',ks)]:=',';
   _strkomma:=ks;
end;

procedure GetDerivate(xAt:TVector; var Result: TVector);
var sin13,cos13:real;
begin
    with xAt do
    begin
      cos13:=cos(werte[1]-werte[3]);
      sin13:=sin(werte[3]-werte[1]);
      Result.werte[1]:=werte[2];
      Result.werte[3]:=werte[4];
      Result.werte[2]:=(( sqr(werte[4]) + sqr(werte[2])*cos13) *sin13
                   -1/omegaq*
                   (2*sin(werte[1])-cos13*sin(werte[3]) ))/(2-sqr(cos13));
      Result.werte[4]:=((werte[4]*werte[4]*cos13
                   +sqr(werte[2])*2)*sin13
                   -2/omegaq*
                   (sin(werte[1])*cos13-sin(werte[3])))/(sqr(cos13)-2);
    end;
end;
procedure GetDerivateex(xAt:TVectorex; var Result: TVectorex);
var sin13,cos13:extended;
begin
    with xAt do
    begin
      cos13:=cos(werte[1]-werte[3]);
      sin13:=sin(werte[3]-werte[1]);
      Result.werte[1]:=werte[2];
      Result.werte[3]:=werte[4];
      Result.werte[2]:=(( sqr(werte[4]) + sqr(werte[2])*cos13) *sin13
                   -1/omegaq*
                   (2*sin(werte[1])-cos13*sin(werte[3]) ))/(2-sqr(cos13));
      Result.werte[4]:=((werte[4]*werte[4]*cos13
                   +sqr(werte[2])*2)*sin13
                   -2/omegaq*
                   (sin(werte[1])*cos13-sin(werte[3])))/(sqr(cos13)-2);
    end;
end;

procedure TForm1.d2Click(Sender: TObject);
var bitmap,bitmap2,bitmap3,bild,bildrot:tbitmap;
    t,l:real;
    i,b,h,b2,h2,umsch:integer;
    p1,p2,dp1,dp2:tpoint;
    spur:boolean;
    spurlaenge:integer;
    xold,yold,xold2,yold2:array[1..1000] of smallint;

procedure RungeKutta4Delt(var xx:tvector);
var k1,k2,k3,k4,kh:TVector;
begin
  GetDerivate(Xx,k1);
  kh.Copy(k1);
  kh.Mal(Deltat/2);
  kh.Plus(Xx);
  GetDerivate(kh,k2);
  kh.Copy(k2);
  kh.Mal(Deltat/2);
  kh.Plus(Xx);
  GetDerivate(kh,k3);
  kh.Copy(k3);
  kh.Mal(Deltat);
  kh.Plus(Xx);
  GetDerivate(kh,k4);
  DeltaX.Copy(k1);
  DeltaX.Plus(k4);
  DeltaX.Mal(0.5);
  DeltaX.Plus(k2);
  DeltaX.Plus(k3);
  DeltaX.Mal(Deltat/3);
  xX.Plus(DeltaX);
  if xx.werte[1]<-pi then xx.werte[1]:=xx.werte[1]+zweipi;
  if xx.werte[3]<-pi then xx.werte[3]:=xx.werte[3]+zweipi;
  if xx.werte[1]>pi then xx.werte[1]:=xx.werte[1]-zweipi;
  if xx.werte[3]>pi then xx.werte[3]:=xx.werte[3]-zweipi;
end;
procedure RungeKutta4Deltex(var xx:tvectorex);
var k1,k2,k3,k4,kh:TVectorex;
begin
  GetDerivateex(Xx,k1);
  kh.Copy(k1);
  kh.Mal(Deltat/2);
  kh.Plus(Xx);
  GetDerivateex(kh,k2);
  kh.Copy(k2);
  kh.Mal(Deltat/2);
  kh.Plus(Xx);
  GetDerivateex(kh,k3);
  kh.Copy(k3);
  kh.Mal(Deltat);
  kh.Plus(Xx);
  GetDerivateex(kh,k4);
  Deltaex.Copy(k1);
  Deltaex.Plus(k4);
  Deltaex.Mal(0.5);
  Deltaex.Plus(k2);
  Deltaex.Plus(k3);
  Deltaex.Mal(Deltat/3);
  xX.Plus(Deltaex);
  if xx.werte[1]<-pi then xx.werte[1]:=xx.werte[1]+zweipi;
  if xx.werte[3]<-pi then xx.werte[3]:=xx.werte[3]+zweipi;
  if xx.werte[1]>pi then xx.werte[1]:=xx.werte[1]-zweipi;
  if xx.werte[3]>pi then xx.werte[3]:=xx.werte[3]-zweipi;
end;

procedure pendelzeichnen;
begin
  bitmap.canvas.MoveTo(b,h);
  bitmap.canvas.LineTo(p1.X,p1.y);
  bitmap.canvas.LineTo(p2.x,p2.y);
  bitmap.canvas.draw(p1.x-5,p1.y-5,bild);
  bitmap.canvas.draw(p2.x-5,p2.y-5,bild);
end;
procedure pendelzeichnen2;
begin
  bitmap.canvas.MoveTo(b,h);
  bitmap.canvas.LineTo(dp1.X,dp1.y);
  bitmap.canvas.LineTo(dp2.x,dp2.y);
  bitmap.canvas.draw(dp1.x-5,dp1.y-5,bildrot);
  bitmap.canvas.draw(dp2.x-5,dp2.y-5,bildrot);
end;

begin
   if abbruch=false then
   begin
     abbruch:=true;
     d2.caption:='Simulation';
   end
   else
   begin
     b:=paintbox1.width div 2;
     h:=paintbox1.height div 2;
     radiobutton1.enabled:=false;
     radiobutton2.enabled:=false;
     abbruch:=false;
     d2.caption:='Stopp !!!';
     bild:=tbitmap.create;
     bild.loadfromresourceid(hinstance,7006);
     bildrot:=tbitmap.create;
     bildrot.loadfromresourceid(hinstance,7007);

     spurlaenge:=round(ein_real(edit1,25,1000));
     xx.werte[1]:=ein_real(e2,-360,360)*pi/180;
     xx.werte[2]:=ein_real(e1,-5,5);
     xx.werte[3]:=ein_real(e5,-360,360)*pi/180;
     xx.werte[4]:=ein_real(e4,-5,5);
     if radiobutton1.checked then
     begin
       xx2:=xx;
       xx2.werte[4]:=ein_real(e4,-5,5)+0.001;
     end
     else begin
       xx2x.werte[1]:=ein_real(e2,-360,360)*pi/180;
       xx2x.werte[2]:=ein_real(e1,-5,5);
       xx2x.werte[3]:=ein_real(e5,-360,360)*pi/180;
       xx2x.werte[4]:=ein_real(e4,-5,5);
     end;
     omegaq:=0.8;

     l:=(h-60)/2;

     deltat:=ein_real(e7,5,40)/1000;
     if deltat>0.1 then deltat:=0.1;
     if deltat<=0 then deltat:=0.005;

     p1.x:=round(sin(xx.werte[1])*l);
     p1.y:=round(cos(xx.werte[1])*l);
     p2.x:=round(sin(xx.werte[3])*l+p1.X);
     p2.y:=round(cos(xx.werte[3])*l+p1.Y);
     for i:=1 to spurlaenge do
     begin
       xold[i]:=p2.x div 3;
       yold[i]:=p2.y div 3;
       xold2[i]:=p2.x div 3;
       yold2[i]:=p2.y div 3;
     end;
     updown2.enabled:=false;

     bitmap:=tbitmap.create;
     bitmap.width:=paintbox1.width;
     bitmap.height:=paintbox1.height;
     bitmap.canvas.copymode:=cmsrcand;

     bitmap2:=tbitmap.create;
     bitmap2.width:=paintbox2.width;
     bitmap2.height:=paintbox2.height;
     bitmap3:=tbitmap.create;
     bitmap3.width:=paintbox3.width;
     bitmap3.height:=paintbox3.height;
     bitmap2.canvas.pen.color:=clblue;
     bitmap3.canvas.pen.color:=clred;
     b2:=bitmap2.width div 2;
     h2:=bitmap2.height div 2;

     t:=0;
     umsch:=0;
     repeat
       spur:=c_spur.checked;

       bitmap.canvas.Rectangle(-1,-1,paintbox1.width+1,paintbox1.height+1);
       bitmap.canvas.moveto(b-28,h);
       bitmap.canvas.lineto(b+28,h);
       for i:=1 to 7 do begin
         bitmap.canvas.moveto(b+28-i*8,h);
         bitmap.canvas.lineto(b+28-i*8+10,h-10);
       end;

       p1.x:=round(sin(xx.werte[1])*l+b);
       p2.x:=round(sin(xx.werte[3])*l+sin(xx.werte[1])*l+b);
       p1.y:=round(cos(xx.werte[1])*l+h);
       p2.y:=round(cos(xx.werte[3])*l+cos(xx.werte[1])*l+h);
       if radiobutton1.checked then
       begin
         dp1.x:=round(sin(xx2.werte[1])*l+b);
         dp2.x:=round(sin(xx2.werte[3])*l+sin(xx2.werte[1])*l+b);
         dp1.y:=round(cos(xx2.werte[1])*l+h);
         dp2.y:=round(cos(xx2.werte[3])*l+cos(xx2.werte[1])*l+h);
       end
       else
       begin
         dp1.x:=round(sin(xx2x.werte[1])*l+b);
         dp2.x:=round(sin(xx2x.werte[3])*l+sin(xx2x.werte[1])*l+b);
         dp1.y:=round(cos(xx2x.werte[1])*l+h);
         dp2.y:=round(cos(xx2x.werte[3])*l+cos(xx2x.werte[1])*l+h);
       end;
       if umsch mod 6 = 0 then
       begin
         for i:=2 to spurlaenge do
         begin
           xold[i-1]:=xold[i];
           yold[i-1]:=yold[i];
           xold2[i-1]:=xold2[i];
           yold2[i-1]:=yold2[i];
         end;
         xold[spurlaenge]:=(p2.x-b) div 3;
         yold[spurlaenge]:=(p2.y-h) div 3;
         xold2[spurlaenge]:=(dp2.x-b) div 3;
         yold2[spurlaenge]:=(dp2.y-h) div 3;
       end;
       inc(umsch);

       if czwei.checked then pendelzeichnen2;
       pendelzeichnen;

       if spur then
       begin
         bitmap2.canvas.Rectangle(-1,-1,paintbox2.width+1,paintbox2.height+1);
         bitmap2.canvas.moveto(b2+xold[1],h2+yold[1]);
         for I:=2 to spurlaenge do bitmap2.canvas.lineto(b2+xold[i],h2+yold[i]);
         paintbox2.canvas.draw(0,0,bitmap2);
         if czwei.checked then
         begin
           bitmap3.canvas.Rectangle(-1,-1,paintbox2.width+1,paintbox2.height+1);
           bitmap3.canvas.moveto(b2+xold2[1],h2+yold2[1]);
           for I:=2 to spurlaenge do bitmap3.canvas.lineto(b2+xold2[i],h2+yold2[i]);
           paintbox3.canvas.draw(0,0,bitmap3);
         end;
       end;
       if not ketteeinzel then
       begin
         t:=t+deltat;
         l7.caption:=_strkomma(t,1,0);
       end;
       paintbox1.canvas.draw(0,0,bitmap);
       application.processmessages;
       rungekutta4delt(xx);
       if radiobutton1.checked then rungekutta4delt(xx2)
                               else rungekutta4deltex(xx2x);
     until abbruch or ketteeinzel;

     ketteeinzel:=false;
     bitmap.free;
     bitmap2.free;
     bitmap3.free;
     bild.free;
     bildrot.free;
     abbruch:=true;
     d2.caption:='Simulation';
     updown2.enabled:=true;
     radiobutton1.enabled:=true;
     radiobutton2.enabled:=true;
   end;
end;

procedure TForm1.d1Click(Sender: TObject);
begin
   ketteeinzel:=true;
   D2Click(Sender);
end;

procedure TVector.Copy(var Copier:TVector);
var i:integer;
begin
  for i:=1 to 4 do werte[i]:=Copier.werte[i];
end;
procedure TVector.Mal(x:real);
var i:integer;
begin
  for i:=1 to 4 do werte[i]:=x*werte[i];
end;
procedure TVector.Plus(var x:TVector);
var i:integer;
begin
  for i:=1 to 4 do werte[i]:=werte[i]+x.werte[i];
end;
procedure TVectorex.Copy(var Copier:TVectorex);
var i:integer;
begin
  for i:=1 to 4 do werte[i]:=Copier.werte[i];
end;
procedure TVectorex.Mal(x:extended);
var i:integer;
begin
  for i:=1 to 4 do werte[i]:=x*werte[i];
end;
procedure TVectorex.Plus(var x:TVectorex);
var i:integer;
begin
  for i:=1 to 4 do werte[i]:=werte[i]+x.werte[i];
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   abbruch:=true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if not abbruch then
    begin
      abbruch:=true;
      exit
    end;  
end;

procedure TForm1.Panel2Resize(Sender: TObject);
begin
    panel3.height:=panel2.height div 2;
end;

end.
