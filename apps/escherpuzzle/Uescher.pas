unit Uescher;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, Buttons, ToolWin, ComCtrls, StdCtrls, ShellApi;

type
  Tfescher = class(TForm)
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    PaintBox1: TPaintBox;
    ListBox1: TListBox;
    Label2: TLabel;
    Label1: TLabel;
    LB2: TListBox;
    D1: TButton;
    S8: TSpeedButton;
    S9: TSpeedButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure S8Click(Sender: TObject);
    procedure S9Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fescher: Tfescher;

implementation

{$R *.DFM}
var teile,ziele : array[1..30] of
                  record
                    nr,x,y,rf:integer;
                    q:string[100];
                  end;
    aktivesteil,teilezahl,xalt,yalt:integer;
    zielzahl:integer;

const xaktiv:integer = 0;
      yaktiv:integer = 0;
      satznr:integer = 1;
      zeilenzahl:integer = 20;
      farbv:integer=1;
      farbensatz : array[1..3,1..3] of integer =
      ((clnavy,clblue,claqua),($00000a0,$0000f0,$0090f0),($000a000,$00f000,$90f000));

procedure Tfescher.FormCreate(Sender: TObject);
var k:string;
    nr:integer;
begin
   helpcontext:=772;
   listbox1.clear;
   nr:=0;
   repeat
     k:=lb2.items[nr];
     inc(nr);
     if k[1]<>'[' then listbox1.items.add(k);
   until k[1]='[';
   listbox1.itemindex:=0;
   d1click(sender);
end;

procedure Tfescher.D1Click(Sender: TObject);
var sel,i,nr:integer;
    k1,k2:string;
begin
    sel:=listbox1.itemindex;
    if sel>=0 then
    begin
      satznr:=random(3)+1;
      k1:='['+inttostr(sel);
      nr:=0;
      repeat
        k2:=lb2.items[nr];
        inc(nr);
      until k1=k2;
      if k1=k2 then
      begin
        teilezahl:=strtoint(lb2.items[nr]);
        inc(nr);
        for i:=1 to teilezahl do
        begin
          teile[i].x:=strtoint(lb2.items[nr]);
          inc(nr);
          teile[i].y:=strtoint(lb2.items[nr]);
          inc(nr);
          teile[i].nr:=i;
          teile[i].rf:=i;
          teile[i].q:=lb2.items[nr];
          inc(nr);
        end;
        zielzahl:=strtoint(lb2.items[nr]);
        inc(nr);
        for i:=1 to zielzahl do
        begin
          ziele[i].x:=strtoint(lb2.items[nr]);
          inc(nr);
          ziele[i].y:=strtoint(lb2.items[nr]);
          inc(nr);
          ziele[i].q:=lb2.items[nr];
          inc(nr);
        end;
      end;
      paintbox1paint(sender);
    end;
end;

procedure Tfescher.PaintBox1Paint(Sender: TObject);
const wa:real = 20;
      se:real = 20;
var bitmap:tbitmap;
    b,h,i,j,vx,vy,ii,xoffset,yoffset:integer;
    k:string;
    x,y:real;
    reihe:array[1..30] of integer;
    rnavy,rblue,raqua:boolean;
procedure wuerfel(x,y:real;nr:integer);
var po:array[0..4] of tpoint;
begin
    po[0].x:=round(x);
    po[0].y:=round(y);
    po[1].x:=round(x);
    po[1].y:=round(y+se);
    po[2].x:=round(x+wa);
    po[2].y:=round(y+se+se/2);
    po[3].x:=round(x+wa);
    po[3].y:=round(y+se/2);
    bitmap.canvas.brush.color:=farbensatz[satznr,1]+farbv*nr;
    bitmap.canvas.polygon(slice(po,4));
    po[0].x:=round(x+wa);
    po[0].y:=round(y+se/2);
    po[1].x:=round(x+wa);
    po[1].y:=round(y+se+se/2);
    po[2].x:=round(x+2*wa);
    po[2].y:=round(y+se);
    po[3].x:=round(x+2*wa);
    po[3].y:=round(y);
    bitmap.canvas.brush.color:=farbensatz[satznr,2]+farbv*nr;
    bitmap.canvas.polygon(slice(po,4));
    po[0].x:=round(x);
    po[0].y:=round(y);
    po[1].x:=round(x+wa);
    po[1].y:=round(y+se/2);
    po[2].x:=round(x+2*wa);
    po[2].y:=round(y);
    po[3].x:=round(x+wa);
    po[3].y:=round(y-se/2);
    bitmap.canvas.brush.color:=farbensatz[satznr,3]+farbv*nr;
    bitmap.canvas.polygon(slice(po,4));
end;
procedure rhombusnavy(x,y:real;nr:integer);
var po:array[0..4] of tpoint;
begin
    po[0].x:=round(x);
    po[0].y:=round(y);
    po[1].x:=round(x);
    po[1].y:=round(y+se);
    po[2].x:=round(x+wa);
    po[2].y:=round(y+se+se/2);
    po[3].x:=round(x+wa);
    po[3].y:=round(y+se/2);
    bitmap.canvas.brush.color:=farbensatz[satznr,1]+farbv*nr;
    bitmap.canvas.polygon(slice(po,4));
end;
procedure rhombusblue(x,y:real;nr:integer);
var po:array[0..4] of tpoint;
begin
    po[0].x:=round(x+wa);
    po[0].y:=round(y+se/2);
    po[1].x:=round(x+wa);
    po[1].y:=round(y+se+se/2);
    po[2].x:=round(x+2*wa);
    po[2].y:=round(y+se);
    po[3].x:=round(x+2*wa);
    po[3].y:=round(y);
    bitmap.canvas.brush.color:=farbensatz[satznr,2]+farbv*nr;
    bitmap.canvas.polygon(slice(po,4));
end;
procedure rhombusaqua(x,y:real;nr:integer);
var po:array[0..4] of tpoint;
begin
    po[0].x:=round(x);
    po[0].y:=round(y);
    po[1].x:=round(x+wa);
    po[1].y:=round(y+se/2);
    po[2].x:=round(x+2*wa);
    po[2].y:=round(y);
    po[3].x:=round(x+wa);
    po[3].y:=round(y-se/2);
    bitmap.canvas.brush.color:=farbensatz[satznr,3]+farbv*nr;
    bitmap.canvas.polygon(slice(po,4));
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox1.width;
    bitmap.height:=paintbox1.height;
    b:=paintbox1.width;
    h:=paintbox1.height;
    se:=h/zeilenzahl;
    wa:=sqrt(3)/2*se;

    bitmap.canvas.brush.Color:=clblack;
    bitmap.canvas.pen.Color:=clblack;
    i:=0;
    repeat
      j:=0;
      repeat
        if odd(i) then y:=se/2 else y:=0;
        bitmap.canvas.pixels[round(i*wa),round(y+j*se)]:=clblack;
        inc(j)
      until j*se>h;
      inc(i);
    until i*wa>b;
    xoffset:=(i-36) div 2;
    if odd(xoffset) then dec(xoffset);
    yoffset:=(zeilenzahl-18) div 2;

    for i:=1 to teilezahl do reihe[teile[i].rf]:=teile[i].nr;

    for i:=teilezahl downto 1 do
    begin
      ii:=reihe[i];
      x:=(teile[ii].x+xoffset)*wa;
      if odd(teile[ii].x) then y:=(teile[ii].y+yoffset)*se+se/2
                          else y:=(teile[ii].y+yoffset)*se;
      k:=teile[ii].q;
      rnavy:=false;
      rblue:=false;
      raqua:=false;
      if k[1]='N' then
      begin
        delete(k,1,1);
        rnavy:=true;
      end;
      if k[1]='B' then
      begin
        delete(k,1,1);
        rblue:=true;
      end;
      if k[1]='A' then
      begin
        delete(k,1,1);
        raqua:=true;
      end;
      for j:=1 to length(k) div 4 do
      begin
        vx:=ord(k[4*j-2])-48;
        if k[4*j-3]='-' then vx:=-vx;
        vy:=ord(k[4*j])-48;
        if k[4*j-1]='-' then vy:=-vy;
        if raqua then
        begin
          if aktivesteil=ii then
            rhombusaqua(x+vx*wa+xaktiv,y+vy*(se/2)+yaktiv,teile[ii].nr)
          else
            rhombusaqua(x+vx*wa,y+vy*(se/2),teile[ii].nr);
        end
        else
        begin
          if rnavy then
          begin
            if aktivesteil=ii then
              rhombusnavy(x+vx*wa+xaktiv,y+vy*(se/2)+yaktiv,teile[ii].nr)
            else
              rhombusnavy(x+vx*wa,y+vy*(se/2),teile[ii].nr);
          end
          else
          begin
            if rblue then
            begin
              if aktivesteil=ii then
                rhombusblue(x+vx*wa+xaktiv,y+vy*(se/2)+yaktiv,teile[ii].nr)
              else
                rhombusblue(x+vx*wa,y+vy*(se/2),teile[ii].nr);
            end
            else
            begin
              if aktivesteil=ii then
                wuerfel(x+vx*wa+xaktiv,y+vy*(se/2)+yaktiv,teile[ii].nr)
              else
                wuerfel(x+vx*wa,y+vy*(se/2),teile[ii].nr);
            end
          end;
        end;
      end;
    end;

    if zielzahl>0 then
    begin
      for i:=1 to zielzahl do
      begin
        x:=(ziele[i].x+xoffset)*wa;
        if odd(ziele[i].x) then y:=(ziele[i].y+yoffset)*se+se/2
                           else y:=(ziele[i].y+yoffset)*se;
        k:=ziele[i].q;
        rnavy:=false;
        rblue:=false;
        raqua:=false;
        if k[1]='N' then
        begin
          delete(k,1,1);
          rnavy:=true;
        end;
        if k[1]='B' then
        begin
          delete(k,1,1);
          rblue:=true;
        end;
        if k[1]='A' then
        begin
          delete(k,1,1);
          raqua:=true;
        end;
        for j:=1 to length(k) div 4 do
        begin
          vx:=ord(k[4*j-2])-48;
          if k[4*j-3]='-' then vx:=-vx;
          vy:=ord(k[4*j])-48;
          if k[4*j-1]='-' then vy:=-vy;
          if raqua then rhombusaqua(x+vx*wa,y+vy*(se/2),0)
          else
          begin
            if rnavy then rhombusnavy(x+vx*wa,y+vy*(se/2),0)
            else
            begin
              if rblue then rhombusblue(x+vx*wa,y+vy*(se/2),0)
                       else wuerfel(x+vx*wa,y+vy*(se/2),0);
            end;
          end;
        end;
      end;
    end;

    paintbox1.Canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tfescher.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var nr,di,ff,at,i:integer;
begin
    ff:=paintbox1.canvas.pixels[x,y];
    nr:=0;
    aktivesteil:=0;
    di:=(ff-farbensatz[satznr,3]) div farbv;
    if (di>0) and (di<11) then nr:=di;
    di:=(ff-farbensatz[satznr,2]) div farbv;
    if (di>0) and (di<11) then nr:=di;
    di:=(ff-farbensatz[satznr,1]) div farbv;
    if (di>0) and (di<11) then nr:=di;
    if nr>0 then
    begin
      at:=teile[nr].rf;
      for i:=1 to teilezahl do
        if (i<>nr) and (teile[i].rf<at) then inc(teile[i].rf);
      teile[nr].rf:=1;
      aktivesteil:=nr;
      xalt:=x;
      yalt:=y;
      xaktiv:=0;
      yaktiv:=0;
    end;
end;

procedure Tfescher.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    if aktivesteil>0 then
    begin
      xaktiv:=x-xalt;
      yaktiv:=y-yalt;
      paintbox1paint(sender);
    end;
end;

procedure Tfescher.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var h,se,wa,xp,yp,xx:integer;
begin
    if aktivesteil>0 then
    begin
      h:=paintbox1.height;
      se:=h div zeilenzahl;
      wa:=round(sqrt(3)/2*se);
      xp:=round(xaktiv/wa);
      xx:=teile[aktivesteil].x;
      teile[aktivesteil].x:=teile[aktivesteil].x+xp;
      if odd(xx-teile[aktivesteil].x) then
      begin
        if odd(teile[aktivesteil].x) then
          yp:=round((yaktiv-se div 2)/se)
        else
          yp:=round((yaktiv+se div 2)/se)
      end
      else
        yp:=round(yaktiv/se);
      teile[aktivesteil].y:=teile[aktivesteil].y+yp;
    end;
    aktivesteil:=0;
    paintbox1paint(sender);
end;

procedure Tfescher.S8Click(Sender: TObject);
begin
    dec(zeilenzahl);
    if zeilenzahl<18 then zeilenzahl:=18;
    paintbox1paint(sender);
end;

procedure Tfescher.S9Click(Sender: TObject);
begin
    inc(zeilenzahl);
    paintbox1paint(sender);
end;

procedure Tfescher.FormActivate(Sender: TObject);
var i:integer;
function farbtest:boolean;
var DesktopDC    : HDC;
    BitsPerPixel : integer;
begin
    farbtest:=true;
    DesktopDC := GetDC(0);
    BitsPerPixel := GetDeviceCaps(DesktopDC, BITSPIXEL);
    if BitsPerPixel<24 then farbtest:=false;
    ReleaseDC(0, DesktopDC);
end;
begin
    randomize;
    farbv:=1;
    if farbtest=false then
    begin
      farbv:=8;
      farbensatz[1,1]:=rgb(0,0,132);
      for i:=1 to 3 do farbensatz[2,i]:=farbensatz[1,i];
      for i:=1 to 3 do farbensatz[3,i]:=farbensatz[1,i];
    end;
    satznr:=random(3)+1;
end;

procedure Tfescher.Button1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.escherinhetpaleis.nl/', nil, nil, SW_SHOWNORMAL) ;
end;

end.
