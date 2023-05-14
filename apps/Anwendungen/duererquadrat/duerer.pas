unit duerer;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Mask, jpeg;

type
  TFduerer = class(TForm)
    Panel2: TPanel;
    duerer: TPanel;
    Panel1: TPanel;
    Image: TImage;
    Label3: TLabel;
    Label2: TLabel;
    SpeedB2: TSpeedButton;
    SpeedB3: TSpeedButton;
    SpeedB4: TSpeedButton;
    Label1: TLabel;
    Liste: TListBox;
    PaintBox1: TPaintBox;
    SpeedB5: TSpeedButton;
    SpeedB1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure S24C(Sender: TObject);
    procedure S26C(Sender: TObject);
    procedure Sp8C(Sender: TObject);
    procedure Sp9C(Sender: TObject);
    procedure S10C(Sender: TObject);
    procedure PB4P(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var  Fduerer: TFduerer;

implementation

var   durer,durer2,durerb:array[1..4,1..4] of byte;
{$R *.DFM}

procedure TFduerer.PB4P(Sender: TObject);
const br:integer=124;
      superfarben:array[1..4] of integer = ($060ffff,$0ff80ff,$0ffff60,$00ff8080);
var bitmap:tbitmap;
    ziel:tcanvas;
    k:string;
    b,h,xoffset,yoffset,i,j,sel:integer;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=PaintBox1.width;
  bitmap.height:=PaintBox1.height;
  ziel:=bitmap.canvas;
  b:=PaintBox1.width;
  h:=PaintBox1.height;
  br:=round(fduerer.height/800*148);
  ziel.font.name:='Verdana';
  ziel.font.size:=40;
  ziel.font.style:=[fsbold];
  ziel.font.color:=clblack;
  xoffset:=(b-4*br) div 2;
  yoffset:=(h-4*br) div 2;
  ziel.pen.width:=2;
  sel:=liste.itemindex;
  for i:=0 to 3 do
    for j:=0 to 3 do begin
      ziel.brush.style:=bsclear;
      case sel of
        1 : ziel.brush.color:=superfarben[i+1];
        2 : ziel.brush.color:=superfarben[j+1];
        3 : begin
              if i=j then ziel.brush.color:=superfarben[1];
              if i=3-j then ziel.brush.color:=superfarben[2];
            end;
        4 : begin
              if ((i=0) and (j=3)) or ((i=0) and (j=0)) or ((i=3) and (j=0)) or ((i=3) and (j=3))
                then ziel.brush.color:=superfarben[1];
              if ((i=1) and (j=2)) or ((i=1) and (j=1)) or ((i=2) and (j=1)) or ((i=2) and (j=2))
                then ziel.brush.color:=superfarben[2];
            end;
        5 : begin
              if ((i=0) and (j=1)) or ((i=0) and (j=2)) or ((i=3) and (j=1)) or ((i=3) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=1) and (j=0)) or ((i=2) and (j=0)) or ((i=1) and (j=3)) or ((i=2) and (j=3))
                then ziel.brush.color:=superfarben[2];
            end;
        6 : begin
              if ((i=1) and (j=0)) or ((i=0) and (j=1)) or ((i=2) and (j=3)) or ((i=3) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=2) and (j=0)) or ((i=0) and (j=2)) or ((i=1) and (j=3)) or ((i=3) and (j=1))
                then ziel.brush.color:=superfarben[2];
            end;
        7 : begin
              if ((i=0) and (j=0)) or ((i=3) and (j=3)) or ((i=2) and (j=1)) or ((i=1) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=3) and (j=0)) or ((i=0) and (j=3)) or ((i=2) and (j=2)) or ((i=1) and (j=1))
                then ziel.brush.color:=superfarben[2];
            end;
        8 : begin
              if ((i=0) and (j=1)) or ((i=0) and (j=3)) or ((i=2) and (j=1)) or ((i=2) and (j=3))
                then ziel.brush.color:=superfarben[1];
              if ((i=1) and (j=0)) or ((i=3) and (j=0)) or ((i=1) and (j=2)) or ((i=3) and (j=2))
                then ziel.brush.color:=superfarben[2];
            end;
        9 : begin
              if ((i=0) and (j=0)) or ((i=0) and (j=2)) or ((i=2) and (j=0)) or ((i=2) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=1) and (j=1)) or ((i=1) and (j=3)) or ((i=3) and (j=1)) or ((i=3) and (j=3))
                then ziel.brush.color:=superfarben[2];
            end;
       10 : begin
              if ((i<2) and (j<2)) then ziel.brush.color:=superfarben[1];
              if ((i>1) and (j<2)) then ziel.brush.color:=superfarben[2];
              if ((i>1) and (j>1)) then ziel.brush.color:=superfarben[3];
              if ((i<2) and (j>1)) then ziel.brush.color:=superfarben[4];
            end;
       11 : begin
              if ((i=0) and (j=0)) or ((i=0) and (j=1)) or ((i=3) and (j=2)) or ((i=3) and (j=3))
                then ziel.brush.color:=superfarben[1];
              if ((i=3) and (j=0)) or ((i=3) and (j=1)) or ((i=0) and (j=2)) or ((i=0) and (j=3))
                then ziel.brush.color:=superfarben[2];
            end;
       12 : begin
              if ((j=0) and (i=0)) or ((j=0) and (i=1)) or ((j=3) and (i=2)) or ((j=3) and (i=3))
                then ziel.brush.color:=superfarben[1];
              if ((j=3) and (i=0)) or ((j=3) and (i=1)) or ((j=0) and (i=2)) or ((j=0) and (i=3))
                then ziel.brush.color:=superfarben[2];
            end;
       13 : begin
              if ((i=0) and (j=1)) or ((i=1) and (j=3)) or ((i=2) and (j=0)) or ((i=3) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=1) and (j=0)) or ((i=3) and (j=1)) or ((i=0) and (j=2)) or ((i=2) and (j=3))
                then ziel.brush.color:=superfarben[2];
            end;
       14 : begin
              if ((i=0) and (j=1)) or ((i=0) and (j=3)) or ((i=3) and (j=0)) or ((i=3) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=0) and (j=0)) or ((i=1) and (j=3)) or ((i=2) and (j=0)) or ((i=3) and (j=3))
                then ziel.brush.color:=superfarben[2];
            end;
       15 : begin
              if ((i=0) and (j=0)) or ((i=0) and (j=2)) or ((i=3) and (j=1)) or ((i=3) and (j=3))
                then ziel.brush.color:=superfarben[1];
              if ((i=0) and (j=3)) or ((i=1) and (j=0)) or ((i=3) and (j=0)) or ((i=2) and (j=3))
                then ziel.brush.color:=superfarben[2];
            end;
       16 : begin
              if ((i=0) and (j=1)) or ((i=1) and (j=1)) or ((i=2) and (j=2)) or ((i=3) and (j=2))
                then ziel.brush.color:=superfarben[1];
              if ((i=0) and (j=2)) or ((i=1) and (j=2)) or ((i=2) and (j=1)) or ((i=3) and (j=1))
                then ziel.brush.color:=superfarben[2];
            end;
       17 : begin
              if ((j=0) and (i=1)) or ((j=1) and (i=1)) or ((j=2) and (i=2)) or ((j=3) and (i=2))
                then ziel.brush.color:=superfarben[1];
              if ((j=0) and (i=2)) or ((j=1) and (i=2)) or ((j=2) and (i=1)) or ((j=3) and (i=1))
                then ziel.brush.color:=superfarben[2];
            end;
      end;
      ziel.rectangle(xoffset+i*br,yoffset+j*br,xoffset+(i+1)*br+1,yoffset+(j+1)*br+1);
      k:=inttostr(durer2[i+1,j+1]);
      ziel.brush.style:=bsclear;
      ziel.textout(xoffset+i*br+br div 2-ziel.textwidth(k) div 2,
      yoffset+j*br+br div 2-ziel.textheight(k) div 2,k);
    end;
    PaintBox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TFduerer.FormShow(Sender: TObject);
begin
         durer[1,1]:=16; durer[2,1]:=3;
         durer[3,1]:=2;  durer[4,1]:=13;
         durer[1,2]:=5; durer[2,2]:=10;
         durer[3,2]:=11;  durer[4,2]:=8;
         durer[1,3]:=9; durer[2,3]:=6;
         durer[3,3]:=7;  durer[4,3]:=12;
         durer[1,4]:=4; durer[2,4]:=15;
         durer[3,4]:=14;  durer[4,4]:=1;
         durer2:=durer;
         liste.itemindex:=0;
end;

procedure TFduerer.S24C(Sender: TObject);
var j:integer;
begin
  durerb:=durer2;
  for j:=1 to 4 do begin
    durer2[j,4]:=durerb[j,1];
    durer2[j,3]:=durerb[j,2];
    durer2[j,2]:=durerb[j,3];
    durer2[j,1]:=durerb[j,4];
  end;
  pb4p(sender);
end;

procedure TFduerer.S26C(Sender: TObject);
var j:integer;
begin
  durerb:=durer2;
  for j:=1 to 4 do begin
    durer2[4,j]:=durerb[1,j];
    durer2[3,j]:=durerb[2,j];
    durer2[2,j]:=durerb[3,j];
    durer2[1,j]:=durerb[4,j];
  end;
  pb4p(sender);
end;

procedure TFduerer.Sp8C(Sender: TObject);
var i,j:integer;
begin
  durerb:=durer2;
  for i:=1 to 4 do
    for j:=1 to 4 do durer2[i,j]:=durerb[5-j,i];
  pb4p(sender);
end;

procedure TFduerer.Sp9C(Sender: TObject);
var i,j:integer;
begin
  durerb:=durer2;
  for i:=1 to 4 do
    for j:=1 to 4 do durer2[i,j]:=durerb[j,i];
  pb4p(sender);
end;

procedure TFduerer.S10C(Sender: TObject);
var i,j:integer;
begin
  durerb:=durer2;
  for i:=1 to 4 do
    for j:=1 to 4 do durer2[i,j]:=durerb[5-j,5-i];
  pb4p(sender);
end;

end.

