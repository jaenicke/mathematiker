unit udualpuzzle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  Buttons, StdCtrls, ExtCtrls;

type
  Tfdualpuzzle = class(TForm)
    P8: TPanel;
    P7: TPanel;
    D1: TButton;
    I1: TImage;
    I2: TImage;
    I3: TImage;
    I4: TImage;
    I5: TImage;
    I6: TImage;
    I7: TImage;
    I8: TImage;
    I9: TImage;
    I10: TImage;
    I11: TImage;
    I12: TImage;
    I13: TImage;
    I14: TImage;
    I15: TImage;
    I16: TImage;
    I25: TImage;
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    P4: TPanel;
    L2: TLabel;
    L1: TLabel;
    procedure S3C(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure I1D(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I1U(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I1M(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    im : array[1..16] of timage;
    ii,ix,iy,px,py: integer;
    pp : array[1..4,1..4] of integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fdualpuzzle: Tfdualpuzzle;

implementation

{$R *.DFM}
uses Dialogs;

procedure Tfdualpuzzle.S3C(Sender: TObject);
begin
  close;
end;

procedure Tfdualpuzzle.FormActivate(Sender: TObject);
var i,j:integer;
    p,q:integer;
    brect,qrect:trect;
    ziel:tcanvas;
    d:string;
    z:integer;
begin
  fillchar(pp,sizeof(pp),0);
  for i:=1 to 16 do begin
    im[i]:=Timage(FindComponent('i'+IntToStr(i)));
    im[i].width:=96;
    im[i].height:=96;
  end;
  brect:=i1.clientrect;
  qrect:=i25.clientrect;
  for i:=0 to 3 do
    for j:=0 to 3 do begin
      im[j*4+i+1].left:=78+100*i;
      im[j*4+i+1].top:=72+100*j;
      im[j*4+i+1].canvas.copyrect(brect,i25.canvas,qrect);
    end;
  ii:=0;
  for i:=1 to 16 do begin
    ziel:=im[i].picture.bitmap.canvas;
    ziel.brush.color:=clwhite;
    ziel.rectangle(-1,-1,97,97);
    ziel.pen.color:=clblack;
    for p:=0 to 1 do
      for q:=0 to 1 do
      begin
        ziel.rectangle(p*48,q*48,p*48+48,q*48+48);
      end;
    d:='';
    z:=i-1;
    repeat
      if odd(z) then d:='1'+d else d:='0'+d;
      z:=z div 2;
    until z=0;
    while length(d)<4 do d:='0'+d;
    ziel.brush.color:=clyellow;
    if d[4]='1' then begin
       ziel.rectangle(0,0,48,48);
    end;
    if d[3]='1' then ziel.rectangle(48,0,48+48,48);
    if d[2]='1' then ziel.rectangle(0,48,48,48+48);
    if d[1]='1' then ziel.rectangle(48,48,48+48,48+48);
  end;
end;

procedure Tfdualpuzzle.I1D(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,j:integer;
begin
  for i:=1 to 16 do
    if sender=im[i] then ii:=i;
  if ii<>0 then begin
    if button=mbleft then begin
      ix:=im[ii].left;
      iy:=im[ii].top;
      im[ii].BringToFront;
      px:=x;
      py:=y;
      for i:=1 to 4 do
        for j:=1 to 4 do
          if pp[i,j]=ii then begin
            pp[i,j]:=0;
          end;
    end;
   end;
end;

procedure Tfdualpuzzle.I1U(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var qx,qy,nrx,nry,i,j,f,z,z2:integer;
    geloest:boolean;
begin
  nrx:=0;
  nry:=0;
  if ii<>0 then begin
    qx:=ix+x;
    qy:=iy+y;
    if (qx>=p1.left) and (qx<=p1.left+380) and (qy>=80) and (qy<=480) then begin
      qx:=ix+x;
      nrx:=1+(qx-p1.left-8) div 95;
      qx:=95*((qx-p1.left-8) div 95)+p1.left+8;
    end
    else qx:=ix+x-px;
    if (qy>=80) and (qy<=480) and (qx>=p1.left) and (qx<=p1.left+380) then begin
      qy:=iy+y;
      nry:=1+(qy-88) div 95;
      qy:=95*((qy-88) div 95)+80;
    end
    else qy:=iy+y-py;
    if (nrx in [1..4]) and (nry in [1..4]) then begin
      if pp[nrx,nry]=0 then begin
        pp[nrx,nry]:=ii;
      end else begin
        qx:=ix+x-px;
        qy:=iy+y-py;
      end;
    end;
    im[ii].left:=qx;
    im[ii].top:=qy;
    ii:=0;
//test
    f:=0;
    for i:=1 to 4 do
      for j:=1 to 3 do begin
        z:=pp[j,i];
        z2:=pp[j+1,i];
        if (z<>0) and (z2<>0) then begin
          if im[z].canvas.pixels[70,10]<>im[z2].canvas.pixels[10,10] then inc(f);
          if im[z].canvas.pixels[70,70]<>im[z2].canvas.pixels[10,70] then inc(f);
        end;
      end;
    for i:=1 to 4 do
      for j:=1 to 3 do begin
        z:=pp[i,j];
        z2:=pp[i,j+1];
        if (z<>0) and (z2<>0) then begin
          if im[z].canvas.pixels[10,70]<>im[z2].canvas.pixels[10,10] then inc(f);
          if im[z].canvas.pixels[70,70]<>im[z2].canvas.pixels[70,10] then inc(f);
        end;
      end;
    l1.caption:=inttostr(f)+' Fehler';
    geloest:=f=0;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if pp[i,j]=0 then geloest:=false;
    if geloest then showmessage('Gratulation! Das Puzzle wurde gelöst!');
  end;
end;

procedure Tfdualpuzzle.I1M(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ii<>0 then begin
    im[ii].left:=ix+x-px;
    im[ii].top:=iy+y-py;
    if im[ii].left<=0 then im[ii].left:=0;
    if im[ii].top<=0 then im[ii].top:=0;
    if im[ii].left>=p8.width-96 then im[ii].left:=p8.width-96;
    if im[ii].top>=p8.height-96-p7.height then im[ii].top:=p8.height-96-p7.height;
    ix:=im[ii].left;
    iy:=im[ii].top;
  end;
end;

end.
