unit ugalakt;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, math, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    CheckBox2: TCheckBox;
    Label9: TLabel;
    Edit9: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
var j,mon,t,h,m,s,ms:word;
begin
    DecodeDate(date,j,mon,t);
    DecodeTime(now,h,m,s,ms);
    edit3.text:=inttostr(t);
    edit4.text:=inttostr(mon);
    edit5.text:=inttostr(j);
    edit6.text:=inttostr(h);
    edit7.text:=inttostr(m);
    edit8.text:=inttostr(s);
end;

procedure Eplanet(t:real;var aer,exze,scd,ib,lauf,lper,ma:real);
var man:real;
begin
    aer:=1.000001018;
    exze:=0.01670862-0.000042037*t;
    scd:=0;
    ib:=0;
    lauf:=0;
    lper:=102.937348+1.7195269*t;
    man:=357.5291+35640*t+359.0503*t;
    ma:=man-(int(man/360)*360);
    if ma<0 then ma:=ma+360;
end;

//Exzentrische Anomalie
function ExzAn(MitAno,exz:real):real;
var i:byte;
    ExA:array[0..40] of real;
begin
    i:=0;
    Exa[0]:=0;
    repeat
      ExA[i+1]:=MitAno+exz*sin(Exa[i]);
      inc(i);
    until (abs(ExA[i]-ExA[i-1])<1e-7) or (i>38);
    ExzAn:=ExA[i];
end;

//
procedure Berechnung(jd:real;planet:string;
         gebr,gela,koz:real;var lhelz,rav:real);
var aera,exzd,iba,laufa,lpera,maa,mar,ExzA,vwa,ubr : real;
    ubl,ibl,sche : real;
    ti,hgr,lhel:real;
    lst,rst:real;
const zieljd=2451545;
begin
    ti:=(jd-2451545.0)/36525;
    rst:=0;
    lst:=0;

    Eplanet(ti,aera,exzd,sche,iba,laufa,lpera,maa);
    mar:=maa*pi/180;
    ExzA:=ExzAn(mar,exzd);
    rav:=aera*(1-exzd*cos(ExzA));
    vwa:=2*arctan(sqrt(abs((1+exzd)/(1-exzd)))*sin(ExzA/2)/cos(ExzA/2));
    vwa:=vwa*180/pi;
    ubr:=vwa+lpera-laufa;
    ubl:=ubr*pi/180;

    ibl:=iba*pi/180;
    hgr:=180/pi*arctan(sin(ubl)*cos(ibl)/cos(ubl));
    lhel:=laufa+hgr;
    if cos(ubl)<0 then lhel:=lhel+180;
    if lhel<0 then lhel:=lhel+360;
    lhelz:=lhel+0.01396*(zieljd-jd)/365.25;
    lhelz:=lhelz+lst/60;
    rav:=rav+rst/1000;
    if lhelz<0 then lhelz:=lhelz+360;
    if lhelz>360 then lhelz:=lhelz-360;
    {'hel.Laenge = ',lhelz 'Radiusvektor = ',rav}
end;

procedure horizont(stw,y,br:real; var hoehe:real);
//procedure horizont(stw,y:real; var azimut,hoehe:real);
var z:real;
begin
    z:=sin(br*pi/180)*sin(y)+cos(br*pi/180)*cos(y)*cos(stw);
    if abs(z)<=1 then hoehe:=arcsin(z)
                 else hoehe:=pi/2;
{    z1:=cos(y)*sin(stw)/cos(arcsin(z));
    z2:=(-cos(gebr*pino)*sin(y)+sin(gebr*pino)*cos(y)*cos(stw))/cos(arcsin(z));
    if z2>0 then z:=arcsin(z1)*pium
            else z:=180-arcsin(z1)*pium;
    if z<0 then z:=z+360;
    z:=azimut;} // wird nicht gebraucht
end;

function  juldat(const jahr,mon,tag:integer):real;
var y,m,k:longint;
    a,b:real;
begin
   k:=10000*jahr+100*mon+tag;
   b:=-63.5;
   y:=jahr+4712;
   m:=mon+1;
   if mon<=2 then
     begin
       dec(y);
       inc(m,12);
     end;
   if k>=15821015 then
     begin
       A:=int((y+88)/100);
       b:=b+38-A+int(0.25*A);
     end;
   juldat:=int(365.25*y)+int(30.6001*m)+tag+b;
end;

function sternzeit(gela,zeit,jd:real):real;
var zco,st:real;
begin
    zco:=6.6973745583+0.06570982442*(jd-2451545.0)+ 1.938587419e-14*sqr(jd-2451545.0);
    st:=zco+gela/15+1.00273790935*zeit;
    while st<0 do st:=st+24;
    while st>24 do st:=st-24;
    sternzeit:=st;
end;

procedure galakt(x,y:real;var gl,gb:real);
var l,b:real;
begin
    l:=303*pi/180-
      arctan(sin(192.25*pi/180-x)/(cos(192.25*pi/180-x)*sin(27.4*pi/180)
        -tan(y)*cos(27.4*pi/180)));
    if (cos(192.25*pi/180-x)*sin(27.4*pi/180)-tan(y)*cos(27.4*pi/180))<0 then l:=l+pi;
    if l>2*pi then l:=l-2*pi;
    if l<0 then l:=l+2*pi;
    b:=arcsin(sin(y)*sin(27.4*pi/180)+cos(y)*cos(27.4*pi/180)*cos(192.25*pi/180-x));
    gl:=l*180/pi;
    gb:=b*180/pi;
end;

procedure eklipt(x,y:real;var el,eb:real);
var l,b:real;
begin
    if cos(x)<>0 then
      l:=arctan((sin(x)*cos(23.446*pi/180)+tan(y)*sin(23.446*pi/180))/cos(x))
    else l:=pi/2;
    if cos(x)<0 then l:=l+pi;
    if l>2*pi then l:=l-2*pi;
    if l<0 then l:=l+2*pi;
    b:=arcsin(sin(y)*cos(23.446*pi/180)-cos(y)*sin(23.446*pi/180)*sin(x));
    el:=l*180/pi;
    eb:=b*180/pi;
end;

procedure TForm1.Button1Click(Sender: TObject);
var j,mon,t,h,m,s:integer;
    br,la,stw,hoehe,hoehenn,entfern,entfernx:real;
    jd,szeit,winkel,winkelh:extended;
    eb,el,gb,gl,st,stu,zrek,zdek:real;
    xastro1,xastro2:real;
    ausgabe:string;
    wert:extended;
procedure linesadd(s:string);
begin
    ausgabe:=ausgabe+s+#13+#10;
end;
begin
    t:=strtoint(edit3.text);
    mon:=strtoint(edit4.text);
    j:=strtoint(edit5.text);
    h:=strtoint(edit6.text);
    m:=strtoint(edit7.text);
    s:=strtoint(edit8.text);

    la:=strtofloat(edit1.text);
    br:=strtofloat(edit2.text);
    hoehenn:=strtofloat(edit9.text);

    ausgabe:='';

    linesadd('geograf.Länge'#9+edit1.text);
    linesadd('geograf.Breite'#9+edit2.text);
    linesadd('Datum'#9#9+datetostr(encodedate(j,mon,t)));
    linesadd('Weltzeit'#9#9+timetostr(encodetime(h,m,s,0)));

    jd:=juldat(j,mon,t)+h/24+m/24/60+s/24/3600;
    linesadd('Julianisches Datum'#9+floattostr(jd));

    szeit:=sternzeit(la,h+m/60+s/3600-1,jd);
    linesadd('Sternzeit'#9#9+timetostr(szeit/24));

    Berechnung(jd,'Erde',br,la,0,xastro1,xastro2);
    if xastro2=0 then xastro2:=1;

    zrek:=xastro1/15+12;
    zdek:=23.45*sin(pi*(xastro1+180)/180);
    linesadd('');
    linesadd('Sonne');
    linesadd(format('Rektaszension'#9'%.8f h',[zrek]));
    linesadd(format('Deklination'#9'%.8f°',[zdek]));

    stw:=szeit/12*pi-zrek/12*pi;
    if stw<0 then stw:=stw+2*pi;
    horizont(stw,zdek*pi/180,br,hoehe);
    linesadd(format('Hoehe'#9#9'%.8f°',[hoehe*180/pi]));
    linesadd(format('Polabstand'#9'%.8f°',[90-hoehe*180/pi]));

    st:=xastro1/15;
    stu:=-23.45*sin(pi*(xastro1+180)/180);
    linesadd('Entfernung Erde-Sonne');
    linesadd(#9#9+floattostr(xastro2)+' AE');

    linesadd('Entfernung Ort-Erdmittelpunkt');
    entfern:=6378.137-abs(sin(br*pi/180)*(6378.137-6356.7523142))+hoehenn/1000;
    linesadd(format(#9#9+'%.3f km',[entfern]));

    wert:=sin(pi/2+hoehe)*entfern/(xastro2*149597870700);
    if abs(wert)<=1 then
    begin
      winkel:=arcsin(wert);
      if sin(pi/2+hoehe)<>0 then
      begin
        entfernx:=xastro2*sin(pi-winkel-pi/2-hoehe)/sin(pi/2+hoehe);
        wert:=sin(stu*pi/180+br*pi/180)*entfern/(entfernx*149597870700);
        if abs(wert)<=1 then
        begin
          winkelh:=arcsin(wert);

          linesadd('Rek-Winkel Erdmittelpunkt-Sonne-Ort');
          linesadd(format(#9#9+'%.9f °',[winkel*180/pi]));
          linesadd('Dek-Winkel Erdmittelpunkt-Sonne-Ort');
          linesadd(format(#9#9+'%.9f °',[winkelh*180/pi]));

          linesadd('Entfernung Ort-Sonnenmittelpunkt');
          linesadd(#9#9+floattostr(entfernx)+' AE');
          linesadd(format('Differenz'#9#9+'%.3f km',[(xastro2-entfernx)*149597870700]));

          //Korrektur der Koodinaten für den Ort
          st:=st+winkel*180/pi/15;
          stu:=stu+winkelh*180/pi;

          linesadd('');
          linesadd('heliozentrische Koordinaten des Ortes');
          linesadd(format('Rektaszension'#9'%.8f h',[st]));
          linesadd(format('Deklination'#9'%.8f°',[stu]));


          galakt(st/12*pi,stu*pi/180,gl,gb);

          linesadd('galaktische Koordinaten des Ortes');
          linesadd(format('Länge'#9#9'%.8f°',[gl]));
          linesadd(format('Breite'#9#9'%.8f°',[gb]));

          eklipt(st/12*pi,stu*pi/180,el,eb);

          linesadd('ekliptische Koordinaten des Ortes');
          linesadd(format('Länge'#9#9'%.8f°',[el]));
          linesadd(format('Breite'#9#9'%.8f°',[eb]));
        end;
      end;
    end;

    if checkbox2.checked then
    begin
      linesadd('');
      linesadd('Äquatorkoordinaten von Kronos');
      st:=9+14/60+21.8/3600;
      stu:=2+18/60+51/3600;
      linesadd(format('Rektaszension'#9'%.8f h',[st]));
      linesadd(format('Deklination'#9'%.8f°',[stu]));

      galakt(st/12*pi,stu*pi/180,gl,gb);

      linesadd('galaktische Koordinaten Kronos');
      linesadd(format('Länge'#9#9'%.8f°',[gl]));
      linesadd(format('Breite'#9#9'%.8f°',[gb]));
    end;

    memo1.text:=ausgabe;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
    timer1.enabled:=checkbox1.checked;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var j,mon,t,h,m,s,ms:word;
begin
    DecodeDate(date,j,mon,t);
    DecodeTime(now,h,m,s,ms);
    edit3.text:=inttostr(t);
    edit4.text:=inttostr(mon);
    edit5.text:=inttostr(j);
    edit6.text:=inttostr(h);
    edit7.text:=inttostr(m);
    edit8.text:=inttostr(s);
    button1click(sender);
end;

end.
