unit umondkal;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, moon;

type
  TForm1 = class(TForm)
    label1: TLabel;
    mc1: TDateTimePicker;
    Paintbox1: TPaintBox;
    Panel1: TPanel;
    image1: TImage;
    procedure Paintbox1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Paintbox1Paint(Sender: TObject);
var bitmap:tbitmap;
    dd,dx,i,j,b,h,b8,h8,wd,atage:integer;
    d:tdatetime;
    ja,mo,ta:word;
    k:string;
    xm,ym:integer;
    qrect,zrect:trect;
    mondnr,altenr:integer;
const wochentag : array[0..6] of string[10]
        = ('So','Mo','Di','Mi','Do','Fr','Sa');
      _monat : array[1..12] of string[9]
      = ('Januar','Februar','März','April','Mai','Juni',
         'Juli','August','September','Oktober','November','Dezember');
function schalt(jahr:integer):boolean;
begin
    schalt:=(jahr mod 4=0) and ((jahr mod 100 <>0) or (jahr mod 400=0))
end;
function tag(ist:boolean;monat:integer):integer;
var tage:integer;
begin
    tage:=0;
    case monat of
      1,3,5,7,8,10,12 : tage:=31;
         4,6,9,11     : tage:=30;
                    2 : if ist then tage:=29 else tage:=28
    end;
    tag:=tage;
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=Paintbox1.width;
    bitmap.height:=Paintbox1.height;
    b:=Paintbox1.width;
    h:=Paintbox1.height;

    b8:=b div 8;
    h8:=(h-40) div 7;
    d:=mc1.date;
    decodedate(d,ja,mo,ta);
    wd:=dayofweek(d)-ta;
    while wd<=1 do wd:=wd+7;

    with bitmap.canvas do
    begin
      brush.color:=$00a0ffff;
      rectangle(b8 div 2,24,b-b8 div 2,60);
      brush.color:=clwhite;
      rectangle(b8 div 2,61,b-b8 div 2,97);
      pen.color:=cldkgray;
      for i:=0 to 6 do
      begin
        for j:=0 to 5 do
        begin
          if (j*7+i)=ta+wd-1 then
          begin
            brush.color:=clblack
          end
          else
          begin
            brush.color:=clblack
          end;
          rectangle(b8 div 2+i*b8,98+j*h8,b8 div 2+(i+1)*b8+1,98+(j+1)*h8+1);
        end
      end;
      brush.style:=bsclear;
      font.name:='Verdana';
      font.style:=[fsbold];
      font.size:=18;
      textout(b8 div 2+10,27,_monat[mo]+' '+inttostr(ja));

      font.size:=18;
      for i:=0 to 6 do
      begin
        k:=wochentag[i];
        textout(b8+i*b8-textwidth(k) div 2,64,k);
      end;

      dd:=1;
      dx:=wd;
      atage:=tag(schalt(ja),mo);
      font.name:='Verdana';
      font.color:=$00f0f0f0;

      repeat
        j:=dx div 7;
        i:=dx mod 7;
        if i=0 then font.color:=clred;
        k:=inttostr(dd);
        textout(b8 div 2+i*b8+3,98+j*h8+3,k);
        font.color:=$00f0f0f0;
        inc(dx);
        inc(dd);
      until dd>atage;

//anfang mond
        font.style:=[];
        dd:=1;
        dx:=wd;
        atage:=tag(schalt(ja),mo);
        altenr:=-1;
        repeat
          mondnr:=trunc(28/29.530589*age_of_moon(encodedate(ja,mo,dd)+0.5));
          if mondnr<0 then mondnr:=mondnr+28;
          if mondnr>=28 then mondnr:=mondnr-28;
          if (mondnr=0) and (altenr=0) then mondnr:=1;
          j:=dx div 7;
          i:=dx mod 7;
          xm:=b8 div 2+(i+1)*b8-60;
          ym:=150+j*h8-32;
          qrect.left:=(mondnr mod 7)*86+18;
          qrect.top:=(mondnr div 7)*79+14;
          qrect.right:=qrect.left+52;
          qrect.bottom:=qrect.top+52;
          zrect.left:=round(xm);
          zrect.top:=round(ym);
          zrect.right:=round(xm+52);
          zrect.bottom:=round(ym+52);
          bitmap.canvas.copyrect(zrect,image1.canvas,qrect);
          altenr:=mondnr;
          inc(dx);
          inc(dd);
        until dd>atage;
//ende mond
    end;
    Paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    mc1.date:=date;
end;

end.
