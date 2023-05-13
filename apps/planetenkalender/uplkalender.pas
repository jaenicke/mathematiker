unit uplkalender;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, Menus;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    planetenkal: TPanel;
    Paintbox1: TPaintBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Mc1: TDateTimePicker;
    Mc2: TDateTimePicker;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure PB3P(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
  mc2.date:=now;
end;

procedure TForm1.PB3P(Sender: TObject);
const planet:array[1..8] of string[7] =
        ('Merkur','Venus','Erde','Mars','Jupiter','Saturn','Uranus','Neptun');
var bitmap:tbitmap;
    ziel:tcanvas;
    b,h,i:integer;
    d,d2,d3:tdatetime;
    jy,my,ty,ja,mo,ta:word;
    zrect,qrect:trect;
  function _strkomma(a:double;b,c:byte):string;
  begin
    str(a:b:c,result);
    if c<>0 then begin
      while (length(result)>1) and (result[length(result)]='0') do delete(result,length(result),1);
      if (length(result)>1) and (result[length(result)]='.') then delete(result,length(result),1);
    end;
    if result='-0' then result:='0';
    if pos('.',result)>0 then result[pos('.',result)]:=',';
  end;
  procedure ausg(x,y:integer;s:string);
  begin
    ziel.textout(x-ziel.textwidth(s) div 2,y+10,s);
  end;
  procedure ausg2(x,y:integer;u,r:double;s:string);
  var w:double;
  begin
    ausg(x,y+25,_strkomma(d/u/365.25636042,1,2)+' '+s+'jahre');
    ausg(x,y+49,_strkomma(d/r,1,2)+' '+s+'tage');
    w:=(1-frac(d/u/365.24219879))*u*365.24219879;
    d3:=d2+w;
    ausg(x,y+73,'Jahrestag am ');
    if s='Erd' then begin
      decodedate(mc1.date,ja,mo,ta);
      decodedate(d3,jy,my,ty);
      if (mo=2) and (ta=29) then ta:=28;
      ausg(x,y+97,datetostr(encodedate(jy,mo,ta)));
    end
    else
      ausg(x,y+97,datetostr(d3));
  end;
begin
  d2:=mc2.date;
  d:=d2-mc1.date;
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=paintbox1.width;
  bitmap.height:=paintbox1.height;
  ziel:=bitmap.canvas;

  b:=paintbox1.width div 8;
  h:=paintbox1.height div 15;
  ziel.font.name:='Verdana';
  ziel.font.size:=14;
  ziel.font.style:=[fsbold];

  for i:=1 to 4 do begin
    zrect.Left:=(2*i-1)*b-60;
    zrect.right:=zrect.left+117;
    zrect.Top:=2*h-30;
    zrect.Bottom:=zrect.top+117;
    qrect.left:=(i-1)*117;
    qrect.Right:=qrect.left+117;
    qrect.top:=0;
    qrect.Bottom:=117;
    ziel.copyrect(zrect,image1.picture.bitmap.canvas,qrect);
    ausg((2*i-1)*b,2*h+90,planet[i]);

    zrect.Left:=(2*i-1)*b-60;
    zrect.right:=zrect.left+117;
    zrect.Top:=9*h-30;
    zrect.Bottom:=zrect.top+117;
    qrect.left:=(i+3)*117;
    qrect.Right:=qrect.left+117;
    qrect.top:=0;
    qrect.Bottom:=117;
    ziel.copyrect(zrect,image1.picture.bitmap.canvas,qrect);
    ausg((2*i-1)*b,9*h+90,planet[i+4]);
  end;
  ziel.font.style:=[];
  ausg2(b,2*h+90,0.2408467,58.646225,planet[1]);
  ausg2(3*b,2*h+90,0.61519726,243.0187,planet[2]);
  ausg2(5*b,2*h+90,1,1,'Erd');
  ausg2(7*b,2*h+90,1.8808476,1.02595675,planet[4]);
  ausg2(b,9*h+90,11.862615,0.41354,planet[5]);
  ausg2(3*b,9*h+90,29.447498,0.44401,planet[6]);
  ausg2(5*b,9*h+90,84.016846,0.71833,planet[7]);
  ausg2(7*b,9*h+90,164.79132,0.67125,planet[8]);
  paintbox1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

end.

