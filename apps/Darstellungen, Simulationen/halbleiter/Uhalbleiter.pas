unit Uhalbleiter;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    pb1: TPaintBox;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure Pb1paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    art:integer;
    verschiebung:array[0..5] of integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const dotstellen=5;

procedure TForm1.Pb1paint(Sender: TObject);
var bitmap:tbitmap;
    b,h,b9,h5,i,j,n,m,p,q:integer;
    ziel:tcanvas;
    k:string;
    x,y,y2,x2,nr:integer;
    stellen:array[0..5] of record a,b:integer end;
    dotiert:boolean;
    nleitung:array[0..9,0..5] of integer;
begin
    stellen[0].a:=2;
    stellen[0].b:=2;
    stellen[1].a:=4;
    stellen[1].b:=3;
    stellen[2].a:=3;
    stellen[2].b:=4;
    stellen[3].a:=7;
    stellen[3].b:=3;
    stellen[4].a:=7;
    stellen[4].b:=1;
    stellen[5].a:=3;
    stellen[5].b:=1;
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height;
    b:=bitmap.width;
    h:=bitmap.height;
    ziel:=bitmap.canvas;
    ziel.font.name:='Verdana';
    ziel.font.style:=[fsbold];
    ziel.font.size:=48;

    if updown1.position>0 then
    begin
      ziel.font.color:=clred;
      ziel.brush.color:=clred;
      ziel.rectangle(0,2,24,h-2);
      ziel.brush.style:=bsclear;
      ziel.textout(36,8,'-');
      ziel.brush.color:=clblue;
      ziel.font.color:=clblue;
      ziel.rectangle(b-24,2,b,h-2);
      ziel.brush.style:=bsclear;
      ziel.textout(b-88,8,'+');
    end;

    ziel.font.size:=12;
    ziel.font.color:=clblack;

    b9:=b div 9;
    h5:=h div 5;
    for i:=1 to 8 do
      for j:=1 to 4 do
      begin
        dotiert:=false;
        for n:=0 to dotstellen do
          if (stellen[n].a=i) and (stellen[n].b=j) then dotiert:=true;
        if dotiert then
        case art of
          0 : begin
                k:='Si';
                ziel.brush.color:=cllime;
              end;
          -1 : begin
               k:='B';
                ziel.brush.color:=claqua;
              end;
          1 : begin
                k:='P';
                ziel.brush.color:=clfuchsia;
              end;
        end
        else
        begin
                k:='Si';
                ziel.brush.color:=cllime;
        end;
        ziel.ellipse(i*b9-20,j*h5-20,i*b9+21,j*h5+21);
        ziel.textout(i*b9-ziel.textwidth(k) div 2,j*h5-ziel.textheight(k) div 2,k);
      end;

    ziel.font.size:=10;

    for i:=1 to 8 do
      for j:=1 to 4 do
      begin
        ziel.brush.color:=clred;
        dotiert:=false;
        for n:=0 to dotstellen do
          if (stellen[n].a=i) and (stellen[n].b=j) then
          begin
            m:=n;
            dotiert:=true;
          end;

        x:=i*b9-40+random(6);
        y:=j*h5+random(6);
        ziel.ellipse(x-6,y-6,x+7,y+7);
        x:=i*b9+40+random(6);
        y:=j*h5+random(6);
        ziel.ellipse(x-6,y-6,x+7,y+7);
        x:=i*b9+random(6);
        y:=j*h5+40+random(6);
        ziel.ellipse(x-6,y-6,x+7,y+7);

        if dotiert and (art=-1) and (updown1.position=0) then
        begin
          ziel.brush.color:=clwhite;
          x:=i*b9;
          y:=j*h5-40;
          ziel.ellipse(x-11,y-11,x+12,y+12);
          ziel.textout(x-ziel.textwidth('+') div 2,y-ziel.textheight('+') div 2,'+');
        end
        else
        begin
          if (updown1.position=0) or (art<>-1)
          then
          begin
            ziel.brush.color:=clred;
            x:=i*b9+random(6);
            y:=j*h5-40+random(6);
            ziel.ellipse(x-6,y-6,x+7,y+7);
          end
        end;

        if dotiert and (art=1) then
        begin
          ziel.brush.color:=clfuchsia;
          if updown1.position>0 then x:=i*b9+28+random(6)+verschiebung[m]
                                else x:=i*b9+28+random(6);
          y:=j*h5+28+random(6);
          ziel.ellipse(x-6,y-6,x+7,y+7);
          if updown1.position>0 then
          begin
            ziel.brush.style:=bsclear;
            x:=i*b9+28;
            y2:=j*h5+28;
            ziel.ellipse(x-11,y2-11,x+12,y2+12);
            ziel.textout(x-ziel.textwidth('+') div 2,y2-ziel.textheight('+') div 2,'+');
            ziel.brush.color:=clfuchsia;
            x2:=verschiebung[m]-m*b9 div 2;
            if x2<i*b9+28 then
              x:=x2+random(6)
            else
              x:=i*b9+28+random(6);//+verschiebung[m]-pb1.width;
            ziel.ellipse(x-6,y-6,x+7,y+7);
            if verschiebung[m]>pb1.width then verschiebung[m]:=0;
          end;
        end

      end;

      if (updown1.position>0) and (art=-1)
      then
      begin
        for i:=0 to 9 do
          for j:=0 to 5 do nleitung[i,j]:=0;
        for n:=0 to dotstellen do
        begin
          nr:=(verschiebung[n] div b9)+1;
          p:=stellen[n].a;
          q:=stellen[n].b;
          while p-nr<0 do p:=p+9;
          nleitung[p-nr,q]:=n+1;
          nleitung[p-nr+1,q]:=-1;
//          if verschiebung[n]>pb1.width then verschiebung[n]:=0;
        end;
        for i:=0 to 9 do
        begin
          for j:=1 to 4 do
          begin
            if (i<>0) and (i<>9) and (nleitung[i,j]=-1) then
            begin
              ziel.brush.style:=bsclear;
              x:=i*b9;
              y:=j*h5-40;
              ziel.ellipse(x-11,y-11,x+12,y+12);
              ziel.textout(x-ziel.textwidth('+') div 2,y-ziel.textheight('+') div 2,'+');
//              ziel.ellipse(x-6,y-6,x+7,y+7);
            end;
            if nleitung[i,j]>0 then
            begin
              ziel.brush.color:=clwhite;
              x:=i*b9;
              y:=j*h5-40;
              if (i<>0) and (i<>9) then
              begin
                ziel.ellipse(x-11,y-11,x+12,y+12);
                ziel.textout(x-ziel.textwidth('+') div 2,y-ziel.textheight('+') div 2,'+');
            //   ziel.ellipse(x-6,y-6,x+7,y+7);
              end;
              x:=i*b9+random(6)+(verschiebung[nleitung[i,j]-1] mod b9);
              y:=j*h5-40+random(6);
              ziel.brush.color:=clred;
              ziel.ellipse(x-6,y-6,x+7,y+7);
            end;
            if (i<>0) and (i<>9) and (nleitung[i,j]=0) then
            begin
              ziel.brush.color:=clred;
              x:=i*b9+random(6);
              y:=j*h5-40+random(6);
              ziel.ellipse(x-6,y-6,x+7,y+7);
            end
          end;

        end;
        end;

//    ziel.textout(200,16,inttostr(vnummer[1]));
    pb1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i:integer;
begin
    if (art=1) and (updown1.position>0) then
      for i:=0 to dotstellen do
      begin
        inc(verschiebung[i],updown1.position);
      end;
    if (art=-1) and (updown1.position>0) then
      for i:=0 to dotstellen do
      begin
        inc(verschiebung[i],updown1.position);
      end;
    pb1paint(sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin
    art:=0;
    for i:=0 to dotstellen do begin
      verschiebung[i]:=0;
    end;
    pb1paint(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
    art:=-1;
    for i:=0 to dotstellen do begin
      verschiebung[i]:=0;
    end;
    pb1paint(sender);
end;

procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
begin
    art:=1;
    for i:=0 to dotstellen do begin
      verschiebung[i]:=0;
    end;
    pb1paint(sender);
end;

end.
