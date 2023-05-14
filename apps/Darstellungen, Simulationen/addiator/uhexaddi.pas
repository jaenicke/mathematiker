unit uhexaddi;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls;

type
  TForm1 = class(TForm)
    PB11: TPaintBox;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    procedure PB11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB11Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PB11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const
     schiebenaktiv : boolean = false;
var
     addiplus:boolean;
     waddi,yver:array[0..15] of integer;
     abstandadd:real;
     umdrehen,buegel,obenadd,untenadd,untenadd2,nummeradd:integer;
     addziehen,addziehen2:boolean;
     xstelle,ystelle:integer;

procedure TForm1.PB11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var f:int64;
    i,j,h:integer;
    xx,yy:integer;
procedure demo(xx,yy:integer);
var wi:integer;
begin
    schiebenaktiv:=true;

    if addiplus then
    begin //addition
      if waddi[xx]+yy<16 then
      begin
        wi:=0;
        repeat
          yver[xx]:=-wi;
          wi:=wi+2;
          pb11paint(sender);
          application.processmessages;
        until wi>abstandadd*yy;
        waddi[xx]:=waddi[xx]+yy;
        yver[xx]:=0;
        exit;
      end;
      if waddi[xx]+yy>15 then
      begin
        wi:=0;
        repeat
          yver[xx]:=wi;
          wi:=wi+2;
          pb11paint(sender);
          application.processmessages;
        until wi>abstandadd*(16-yy);
        waddi[xx]:=waddi[xx]+yy-16;
        yver[xx]:=0;
        pb11paint(sender);
        application.processmessages;
        wi:=0;
        repeat
          yver[xx+1]:=-wi;
          wi:=wi+2;
          pb11paint(sender);
          application.processmessages;
        until wi>abstandadd;
        waddi[xx+1]:=waddi[xx+1]+1;
        yver[xx+1]:=0;
        xx:=xx+1;
        while (waddi[xx]>15) and (xx<15) do
        begin
          wi:=0;
          repeat
            yver[xx]:=wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd*16;
          waddi[xx]:=0;
          yver[xx]:=0;
          pb11paint(sender);
          application.processmessages;
          wi:=0;
          repeat
            yver[xx+1]:=-wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd;
          waddi[xx+1]:=waddi[xx+1]+1;
          yver[xx+1]:=0;
          inc(xx);
        end;
        while (waddi[xx]<0) and (xx<15) do
        begin
          wi:=0;
          repeat
            yver[xx]:=-wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd*16;
          waddi[xx]:=15;
          yver[xx]:=0;
          pb11paint(sender);
          application.processmessages;
          wi:=0;
          repeat
            yver[xx+1]:=-wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd;
          waddi[xx+1]:=waddi[xx+1]+1;
          yver[xx+1]:=0;
          inc(xx);
        end;
        exit;
      end;
    end
    else
    begin //subtraktion
      if waddi[xx]-yy>=0 then
      begin
        wi:=0;
        repeat
          yver[xx]:=-wi;
          wi:=wi+2;
          pb11paint(sender);
          application.processmessages;
        until wi>abstandadd*yy;
        waddi[xx]:=waddi[xx]-yy;
        yver[xx]:=0;
        exit;
      end;
      if waddi[xx]-yy<=0 then
      begin
        wi:=0;
        repeat
          yver[xx]:=wi;
          wi:=wi+2;
          pb11paint(sender);
          application.processmessages;
        until wi>abstandadd*(16-yy);
        waddi[xx]:=waddi[xx]-yy+16;
        yver[xx]:=0;
        pb11paint(sender);
        application.processmessages;
        wi:=0;
        repeat
          yver[xx+1]:=-wi;
          wi:=wi+2;
          pb11paint(sender);
          application.processmessages;
        until wi>abstandadd;
        waddi[xx+1]:=waddi[xx+1]-1;
        yver[xx+1]:=0;
        xx:=xx+1;
        while (waddi[xx]>15) and (xx<15) do
        begin
          wi:=0;
          repeat
            yver[xx]:=-wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd*16;
          waddi[xx]:=0;
          yver[xx]:=0;
          pb11paint(sender);
          application.processmessages;
          wi:=0;
          repeat
            yver[xx+1]:=-wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd;
          waddi[xx+1]:=waddi[xx+1]-1;
          yver[xx+1]:=0;
          inc(xx);
        end;
        while (waddi[xx]<0) and (xx<15) do
        begin
          wi:=0;
          repeat
            yver[xx]:=+wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd*16;
          waddi[xx]:=15;
          yver[xx]:=0;
          pb11paint(sender);
          application.processmessages;
          wi:=0;
          repeat
            yver[xx+1]:=-wi;
            wi:=wi+2;
            pb11paint(sender);
            application.processmessages;
          until wi>abstandadd;
          waddi[xx+1]:=waddi[xx+1]-1;
          yver[xx+1]:=0;
          inc(xx);
        end;
        exit;
      end;
    end;
end;
begin
    f:=pb11.canvas.pixels[x,y];

    if (f=rgb(124,124,124)) then
    begin
      for i:=0 to 30 do begin
        yver[i]:=0;
        for j:=0 to 8 do begin
          if waddi[j]>(18-i) div 2 then waddi[j]:=(18-i) div 2;
        end;
        buegel:=i;
        pb11paint(sender);
      end;
      fillchar(waddi,sizeof(waddi),0);
      fillchar(yver,sizeof(yver),0);
      addziehen:=false;
      addziehen2:=false;
      xstelle:=0;
      ystelle:=0;
      pb11paint(sender);
      for i:=30 downto 0 do begin
        buegel:=i;
        pb11paint(sender);
      end;
      exit;
    end;

    if (f=rgb(203,203,203)) and (schiebenaktiv=false) then
    begin
      umdrehen:=0;
      repeat
        umdrehen:=umdrehen+8;
        pb11paint(sender);
      until umdrehen>90;
      addiplus:=not addiplus;
      umdrehen:=-90;
      repeat
        umdrehen:=umdrehen+8;
        pb11paint(sender);
      until umdrehen>0;
      umdrehen:=0;
      pb11paint(sender);
      exit
    end;

//  Automatik !!!!!
    if checkbox1.checked then
    begin
      if (schiebenaktiv=false) then
      begin
        for h:=0 to 8 do
          if f=rgb(1,1,h) then begin xx:=h end;
        if abstandadd<>0 then yy:=round((untenadd-y)/abstandadd);
        if (xx>=0) and (xx<15) and (yy>0) and (yy<16) then demo(xx,yy);
        pb11paint(sender);
        schiebenaktiv:=false;
      end;
      exit;
    end;

   //keine Automatik
   addziehen:=false;
   addziehen2:=false;
   for h:=0 to 8 do
   if f=rgb(1,1,h) then
   begin
     xstelle:=x;
     ystelle:=y;
     addziehen:=true;
     nummeradd:=h
   end;
   for h:=0 to 8 do
     if f=rgb(1,2,h) then
     begin
       xstelle:=x;
       ystelle:=y;
       addziehen2:=true;
       nummeradd:=h+1
     end;
end;

procedure TForm1.PB11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var f:int64;
    w,zahl:integer;
begin
    f:=pb11.canvas.pixels[x,y];

    if (f=rgb(203,203,203)) or
      (f=rgb(1,1,1)) or (f=rgb(1,1,2)) or (f=rgb(1,1,3))
      or (f=rgb(1,1,4)) or (f=rgb(1,1,5)) or (f=rgb(1,1,6)) or (f=rgb(1,1,7))
      or (f=rgb(1,1,8)) or (f=rgb(1,1,0)) or
      (f=rgb(1,2,1)) or (f=rgb(1,2,2)) or (f=rgb(1,2,3))
      or (f=rgb(1,2,4)) or (f=rgb(1,2,5)) or (f=rgb(1,2,6)) or (f=rgb(1,2,7))
      or (f=rgb(1,2,8)) or (f=rgb(1,2,0))
      or (f=rgb(124,124,124))
      then
        pb11.cursor:=crhandpoint
      else
        pb11.cursor:=crdefault;

//von langer zur kurzer
    if addziehen and ((f=rgb(1,2,1)) or (f=rgb(1,2,2)) or (f=rgb(1,2,3))
       or (f=rgb(1,2,4)) or (f=rgb(1,2,5)) or (f=rgb(1,2,6)) or (f=rgb(1,2,7))
       or (f=rgb(1,2,8)) or (f=rgb(1,2,0))) then
    begin
      if (y<=obenadd) then y:=obenadd;
      if (y>=untenadd) then y:=untenadd;
      w:=round(abstandadd*round((ystelle-y)/abstandadd));
      if addiplus then
        waddi[nummeradd]:=waddi[nummeradd]-round(w/abstandadd)
      else
        waddi[nummeradd]:=waddi[nummeradd]+round(w/abstandadd);
      if waddi[nummeradd]<0 then waddi[nummeradd]:=0;
      yver[nummeradd]:=0;
      addziehen:=false;
      pb11paint(sender);
      ystelle:=y;
      inc(nummeradd);
      addziehen2:=true;
    end;

//ende lang zu kurz
//von kurzer zur langer
    if addziehen2 and ((f=rgb(1,1,1)) or (f=rgb(1,1,2)) or (f=rgb(1,1,3))
       or (f=rgb(1,1,4)) or (f=rgb(1,1,5)) or (f=rgb(1,1,6)) or (f=rgb(1,1,7))
       or (f=rgb(1,1,8)) or (f=rgb(1,1,0))) then
    begin
      if (y<=obenadd) then y:=obenadd;
      if (y>=untenadd2) then y:=untenadd2;
      w:=round(abstandadd*round((ystelle-y)/abstandadd));
      if addiplus then
        waddi[nummeradd]:=waddi[nummeradd]-round(w/abstandadd)
      else
        waddi[nummeradd]:=waddi[nummeradd]+round(w/abstandadd);
      if waddi[nummeradd]<0 then waddi[nummeradd]:=0;
      yver[nummeradd]:=0;
      addziehen2:=false;
      pb11paint(sender);
      ystelle:=y;
      dec(nummeradd);
      addziehen:=true;
    end;

//ende kurz zu lang
//lange
    if addziehen then
    begin
      if (y>obenadd) and (y<untenadd) then
      begin
        w:=round(abstandadd*round((ystelle-y)/abstandadd));
        if addiplus then
          zahl:=waddi[nummeradd]-round(w/abstandadd)
        else
          zahl:=waddi[nummeradd]+round(w/abstandadd);
        if (zahl>-1) and (zahl<11) then yver[nummeradd]:=ystelle-y;
      end;
      pb11paint(sender);
      exit;
    end;
//kurze
    if addziehen2 then
    begin
      if (y>obenadd) and (y<untenadd2) then
      begin
        w:=round(abstandadd*round((ystelle-y)/abstandadd));
        if addiplus then
          zahl:=waddi[nummeradd]-round(w/abstandadd)
        else
          zahl:=waddi[nummeradd]+round(w/abstandadd);
        if (zahl>-2) and (zahl<11) then yver[nummeradd]:=ystelle-y;
      end;
      pb11paint(sender);
    end;
end;

procedure TForm1.PB11Paint(Sender: TObject);
const v=12;
var bitmap,bitmap2:tbitmap;
    bb,b,h,xoffset,yoffset,ho,hu,hux,hux2,hua,i:integer;
    k:string;
    b2,b2e,ab,ab2:integer;
    can:tcanvas;
    zrect,qrect:trect;

procedure gerade(s,t,u:integer);
begin
    if (t>obenadd) and (t<untenadd) then
    begin
      can.moveto(s,t);
      can.lineto(u,t);
    end;
end;
procedure gerade2(s,t,u:integer);
begin
    if (t>obenadd) and (t<untenadd2) then
    begin
      can.moveto(s,t);
      can.lineto(u,t);
    end;
end;
procedure gerade3(s,t,u:integer);
begin
    if t<obenadd then t:=obenadd;
    if t>=untenadd then t:=untenadd;
    if u>=untenadd then u:=untenadd;
    if u<obenadd then u:=obenadd;
    can.moveto(s,t);
    can.lineto(s,u);
end;
procedure spalte(a:integer);
var li,lil,re,i,j,zahl:integer;
    invers:boolean;
    hq:real;
begin
    if a in [2,3,4] then invers:=true
                    else invers:=false;
    li:=xoffset+bb-2*v-a*b2e-b2e;
    lil:=xoffset+bb-2*v-(a-1)*b2e-b2e;
    re:=yoffset+ho;
    hq:=(ab-10-ab2)/33;//21;
    obenadd:=re+ab2;
    untenadd:=re+ab-10;
    untenadd2:=round(re+ab2+3*hq);
    abstandadd:=2*hq;

    if a=8 then li:=li+8;

    if addiplus then
      zahl:=waddi[a]-round(yver[a]/abstandadd)
    else
      zahl:=waddi[a]+round(yver[a]/abstandadd);
    can.brush.color:=rgb(204,204,204);
    can.pen.color:=rgb(204,204,204);
    can.ellipse(li+b2e-b2 div 18-8-1,
                re+23-1,
                li+b2e-8+1,
                re+23+b2 div 18+1);
    if (zahl>=0) and (zahl<16) then
    begin
      can.font.size:=12;
      can.font.color:=clblack;
      k:=inttostr(zahl);
      if zahl>9 then k:=chr(55+zahl);
      can.textout(li+b2e-b2 div 18+b2 div 36-8-can.textwidth(k) div 2,
                  re+23+b2 div 36-can.textheight(k) div 2,k);
    end
    else
    begin //überlauf
      can.font.size:=10;
      can.font.color:=clred;
      can.font.name:='Symbol';
      if zahl>15 then
      begin
        if addiplus then k:='­' else k:='¯';
      end
      else
      begin
        if addiplus then k:='¯' else k:='­';
      end;
      can.textout(li+b2e-b2 div 18+b2 div 36-8-can.textwidth(k) div 2,
                  re+23+b2 div 36-can.textheight(k) div 2,k);
      can.font.name:='Arial';
      can.font.size:=12;
    end;

    if a=8 then
    begin
      can.pen.style:=pssolid;
      can.pen.width:=1;
      for i:=-31 to 31 do
      begin
        if ((addiplus) and (waddi[a]+i>15)) or ((not addiplus) and (waddi[a]-i<0)) then
        begin
          can.brush.color:=clred;
          can.pen.color:=clred;
        end
        else
        begin
          can.brush.color:=$00f0f0f0;
          can.pen.color:=$00f0f0f0;
        end;
        for j:=0 to round(hq-2) do
        begin
          if a>0 then gerade2(lil+b2e div 3-b2e div 4-4,round(re+ab-10-2*hq*(i+1)+j-yver[a]),
                              lil+b2e div 3-6);
        end;
        if can.pen.color=clred then
        begin
          for j:=0 to 3 do
          begin
            if a>0 then
              gerade2(lil+b2e div 3-b2e div 4-4,round(re+ab-10-2*hq*(i+1)+j-yver[a]),
                      lil+b2e div 3-6);
          end;
        end;
      end;
      exit;
    end;
    can.brush.color:=rgb(1,1,a);
    can.pen.style:=psclear;
    can.rectangle(li+b2e div 3,re+ab2,li+b2e div 3+b2e div 4,re+ab-10+2);
    can.rectangle(li+b2e div 3-b2e div 4-4,re+ab2,li+b2e div 3+1,re+ab2+b2e div 4);
    can.brush.color:=rgb(1,2,a);
    can.rectangle(li+b2e div 3-b2e div 4-4,re+ab2,li+b2e div 3-4,round(re+ab2+3*hq));

    can.pen.style:=pssolid;
    can.pen.width:=1;
    for i:=-31 to 31 do
    begin
      if ((addiplus) and (waddi[a]+i>15)) or ((not addiplus) and (waddi[a]-i<0)) then
      begin
        can.brush.color:=clred;
        can.pen.color:=clred;
      end
      else
      begin
        can.brush.color:=clwhite;
        can.pen.color:=clwhite;
      end;
      gerade3(li+b2e div 3+b2e div 4-2,round(re+ab-10-2*hq*(i)-1-yver[a]),
                round(re+ab-10-2*hq*(i+1)-hq-yver[a]));
      if ((addiplus) and (waddi[a]+i>15)) or ((not addiplus) and (waddi[a]-i<0)) then
      begin
        can.brush.color:=clred;
        can.pen.color:=clred;
      end
      else
      begin
        can.brush.color:=$00f0f0f0;
        can.pen.color:=$00f0f0f0;
      end;
      for j:=0 to round(hq-2) do
      begin
        gerade(li+b2e div 3,round(re+ab-10-2*hq*(i+1)+j-yver[a]),li+b2e div 3+b2e div 4-1);
        if a>0 then gerade2(lil+b2e div 3-b2e div 4-4,round(re+ab-10-2*hq*(i+1)+j-yver[a]),
                            lil+b2e div 3-6);
      end;
      if can.pen.color=clred then
      begin
        for j:=0 to 3 do
        begin
          gerade(li+b2e div 3,round(re+ab-10-2*hq*(i)+j-yver[a]),li+b2e div 3+b2e div 4-1);
          if a>0 then
            gerade2(lil+b2e div 3-b2e div 4-4,round(re+ab-10-2*hq*(i+1)+j-yver[a]),
                    lil+b2e div 3-6);
        end;
      end;
    end;

    can.brush.style:=bsclear;
    if invers then can.font.color:=clblack
              else can.font.color:=clwhite;
    can.font.size:=10;
    for i:=0 to 14 do
    begin
      k:=inttostr(i);
      if i>9 then k:=chr(55+i);
      can.textout(li+b2e div 3-can.textwidth(k)-5,round(re+ab-10+3-2*hq*i-can.textheight(k)),k);
    end;
    k:='F';//inttostr(9);
    can.textout(li+b2e div 3+b2e div 4+can.textwidth(k) div 2,round(re+ab-10+2-2*hq*15-can.textheight(k)),k);
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb11.width;
    bitmap.height:=pb11.height;
    zrect:=pb11.clientrect;
    qrect:=zrect;
    can:=bitmap.canvas;
    can.font.name:='Arial';

    b:=pb11.width;
    h:=pb11.height-50;
    bb:=round(320/460*h);
    xoffset:=(b-bb) div 2;
    yoffset:=30+10;
    can.pen.color:=rgb(124,124,124);
    can.brush.color:=rgb(124,124,124);
    can.rectangle(xoffset+10,yoffset-8-buegel,xoffset+18,yoffset);
    can.rectangle(xoffset+bb+1-18,yoffset-8-buegel,xoffset+bb+1-10,yoffset);
    can.roundrect(xoffset+10,yoffset-14-buegel,xoffset+bb+1-10,yoffset-4-buegel,8,8);

    can.pen.color:=clblack;
    can.brush.color:=rgb(204,204,204);
    can.roundrect(xoffset,yoffset,xoffset+bb+1,yoffset+h+1,20,20);
    can.brush.color:=rgb(185,185,185);
    can.pen.color:=can.brush.color;
    can.rectangle(xoffset+v,yoffset+v,xoffset+bb+1-v,yoffset+h+1-v);
    can.brush.color:=rgb(102,102,102);
    can.pen.color:=clblack;
    can.pen.width:=6;
    can.roundrect(xoffset+2*v,yoffset+2*v,xoffset+bb+1-2*v,yoffset+h+1-2*v,20,20);
    ho:=round((120-3*17)/430*(h-4*v))+2*v;
    hu:=round((290+3*17)/430*(h-4*v))+2*v;
    hua:=abs(hu-h+2*v);
    hux:=hu+hua div 3;
    hux2:=hu+(2*hua) div 3;
    ab:=round((hu-ho));
    ab2:=round(3/17*(hu-ho));
    b2:=bb-4*v;
    b2e:=round((bb-4*v)/8.5);

    can.brush.color:=rgb(155,155,155);
    can.pen.color:=rgb(155,155,155);
    can.pen.width:=1;
    can.rectangle(round(xoffset+2*v+3.4*b2e),yoffset+ho,round(xoffset+2*v+6.4*b2e),yoffset+hu);
    can.pen.color:=clblack;
    can.pen.width:=6;
    can.moveto(xoffset+2*v,yoffset+ho);
    can.lineto(xoffset+bb-2*v,yoffset+ho);
    can.moveto(xoffset+2*v,yoffset+hu+4);
    can.lineto(xoffset+bb-2*v,yoffset+hu+4);

    can.brush.color:=rgb(51,51,51);
    can.pen.color:=rgb(204,204,204);
    can.font.size:=28;
    can.font.style:=[fsbold];
    can.font.color:=rgb(204,204,204);
    can.pen.width:=4;
    k:='HEXADAT';
    can.roundrect(xoffset+bb div 2-can.textwidth(k) div 2-10,
                  yoffset+(2*ho div 3)-can.textheight(k) div 2-9,
                  xoffset+bb div 2+can.textwidth(k) div 2+10+1,
                  yoffset+(2*ho div 3)+can.textheight(k) div 2+1+4-5,
                  10,10);
    can.textout(xoffset+bb div 2-can.textwidth(k) div 2,
                yoffset+(2*ho div 3)-can.textheight(k) div 2-5,k);

    can.pen.width:=1;
    can.brush.color:=rgb(204,204,204);
    can.pen.color:=rgb(204,204,204);
    can.ellipse(xoffset+bb div 2-hua div 6,yoffset+hux-hua div 6,
               xoffset+bb div 2+hua div 6+1,yoffset+hux+hua div 6+1);
    can.brush.color:=rgb(51,51,51);
    can.pen.color:=rgb(51,51,51);
    can.ellipse(xoffset+bb div 2-hua div 6+4,yoffset+hux-hua div 6+4,
               xoffset+bb div 2+hua div 6+1-4,yoffset+hux+hua div 6+1-4);

    can.brush.color:=rgb(203,203,203);
    can.pen.color:=rgb(203,203,203);
    can.rectangle(xoffset+bb div 2-hua div 6+2+8,yoffset+hux-2,
               xoffset+bb div 2+hua div 6+1-2-8,yoffset+hux+2+1);
    if addiplus then
      can.rectangle(xoffset+bb div 2-2,yoffset+hux-hua div 6+2+8,
                  xoffset+bb div 2+1+2,yoffset+hux+hua div 6+1-2-8);
    can.font.size:=18;
    if addiplus then k:='ADDITION'
                else k:='SUBTRAKTION';
    can.brush.color:=rgb(102,102,102);
    can.textout(xoffset+bb div 2-can.textwidth(k) div 2,
                yoffset+hux2-can.textheight(k) div 2,k);
    for i:=0 to 8 do spalte(i);
    can.pen.width:=1;

   if umdrehen<>0 then begin
      zrect.left:=round(bitmap.width/2*(1-cos(umdrehen*pi/180)));
      zrect.right:=round(bitmap.width-bitmap.width/2*(1-cos(umdrehen*pi/180)));
      bitmap2:=tbitmap.create;
      bitmap2.width:=pb11.width;
      bitmap2.height:=pb11.height;
      bitmap2.canvas.copyrect(zrect,bitmap.canvas,qrect);
      bitmap.canvas.draw(0,0,bitmap2);
      bitmap2.free;
    end;
    pb11.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    addiplus:=true;
    buegel:=0;
    umdrehen:=0;
    xstelle:=0;
    ystelle:=0;
    addziehen:=false;
    addziehen2:=false;
    fillchar(yver,sizeof(yver),0);
    fillchar(waddi,sizeof(waddi),0);
end;

procedure TForm1.PB11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var w:integer;
begin
    if addziehen then
    begin
      if (y<=obenadd) then y:=obenadd;
      if (y>=untenadd) then y:=untenadd;
      w:=round(abstandadd*round((ystelle-y)/abstandadd));
      if addiplus then
        waddi[nummeradd]:=waddi[nummeradd]-round(w/abstandadd)
      else
        waddi[nummeradd]:=waddi[nummeradd]+round(w/abstandadd);
      if waddi[nummeradd]<0 then waddi[nummeradd]:=0;
      yver[nummeradd]:=0;
      addziehen:=false;
      pb11paint(sender);
      exit;
    end;

    if addziehen2 then
    begin
      if (y<=obenadd) then y:=obenadd;
      if (y>=untenadd2) then y:=untenadd2;
      w:=round(abstandadd*round((ystelle-y)/abstandadd));
      if addiplus then
        waddi[nummeradd]:=waddi[nummeradd]-round(w/abstandadd)
      else
        waddi[nummeradd]:=waddi[nummeradd]+round(w/abstandadd);
      if waddi[nummeradd]<-1 then waddi[nummeradd]:=-1;
      yver[nummeradd]:=0;
      addziehen2:=false;
      pb11paint(sender);
    end;
end;

end.
