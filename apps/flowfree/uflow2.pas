unit uflow2;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, ComCtrls, Buttons, Spin;

type
  Tfflow = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    PBox1: TPaintBox;
    Memo1: TMemo;
    ListBox1: TListBox;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure PBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    lfeld,lfeldh,loesung:array[0..12,0..12] of integer;
    linie:array[0..12,0..12] of record a,e:tpoint; f:integer end;
    inarbeit:boolean;
    ziehen : boolean;
    ziehfarbe : integer;
    xalt, yalt : integer;
    grad, punktzahl : integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fflow: Tfflow;

implementation

{$R *.DFM}
const fbreite:integer=80;
      superfarben: array[1..11] of longint =
         (clblue,clred,clsilver,clyellow,clwhite,clgreen,clpurple,clgray,
          cllime,clmaroon,clfuchsia);

procedure Tfflow.FormCreate(Sender: TObject);
begin
  randomize;
end;

procedure Tfflow.PBox1Paint(Sender: TObject);
var breite,hoehe,i,j,xoffset,yoffset:integer;
    bitmap:tbitmap;
    ziel:tcanvas;
    kk,k:string;
    geschafft:boolean;
    ergebnis,farbe:integer;
    r,g,b:integer;
  procedure line(a,b,c,d:integer);
  begin
    ziel.pen.Color:=superfarben[linie[a,b].f];
    ziel.pen.Width:=27-grad;
    ziel.Brush.Color:=superfarben[linie[a,b].f];
    ziel.MoveTo(xoffset+a*fbreite-fbreite div 2,yoffset+b*fbreite-fbreite div 2);
    ziel.lineTo(xoffset+c*fbreite-fbreite div 2,yoffset+d*fbreite-fbreite div 2);
  end;
begin
    breite:=PBox1.width;
    hoehe:=PBox1.height;
    fbreite:=(hoehe-60) div grad;
    if (breite-60) div grad<fbreite then fbreite:=(breite-60) div grad;

    bitmap:=tbitmap.create;
    bitmap.width:=PBox1.width;
    bitmap.height:=PBox1.height;
    ziel:=bitmap.canvas;
    xoffset:=(breite-(grad*fbreite)) div 2;
    yoffset:=(hoehe-(grad*fbreite)) div 2-5;

    ziel.font.name:='Verdana';
    for i:=0 to grad-1 do
      for j:=0 to grad-1 do
      begin
        ziel.brush.color:=clblack;
        if linie[i+1,j+1].f>0 then begin
          farbe:=superfarben[linie[i+1,j+1].f];
          r:=farbe mod 256;
          farbe:=farbe div 256;
          g:=farbe mod 256;
          farbe:=farbe div 256;
          b:=farbe mod 256;
          ziel.brush.color:=rgb(r div 3,g div 3,b div 3);
        end;
        ziel.pen.color:=clmaroon;
        ziel.rectangle(xoffset+i*fbreite,yoffset+j*fbreite,
                    xoffset+i*fbreite+fbreite+1,yoffset+j*fbreite+fbreite+1);
      end;
      ziel.pen.width:=3;
      ziel.pen.color:=clsilver;
      ziel.brush.style:=bsclear;
      ziel.rectangle(xoffset-1,yoffset-1,
                     xoffset+grad*fbreite+2,yoffset+grad*fbreite+2);
      ziel.pen.width:=1;

    ziel.pen.Width:=27-grad;
    for i:=1 to grad do begin
      for j:=1 to grad do begin
        if linie[i,j].f>0 then begin
          ziel.pen.Color:=superfarben[linie[i,j].f];
          ziel.Brush.Color:=superfarben[linie[i,j].f];
          ziel.MoveTo(xoffset+i*fbreite-fbreite div 2,yoffset+j*fbreite-fbreite div 2);
          if linie[i,j].a.x>0 then
          ziel.lineto(xoffset+linie[i,j].a.x*fbreite-fbreite div 2,
                      yoffset+linie[i,j].a.y*fbreite-fbreite div 2);
          ziel.MoveTo(xoffset+i*fbreite-fbreite div 2,yoffset+j*fbreite-fbreite div 2);
          if linie[i,j].e.x>0 then
          ziel.lineto(xoffset+linie[i,j].e.x*fbreite-fbreite div 2,
                      yoffset+linie[i,j].e.y*fbreite-fbreite div 2);
    end; end; end;
    ziel.pen.Width:=1;
    for i:=1 to grad do begin
      for j:=1 to grad do begin
        if lfeld[i,j] div 100 =1 then begin
          ziel.Brush.Color:=superfarben[lfeld[i,j]-100];
          ziel.pen.Color:=superfarben[lfeld[i,j]-100];
          ziel.ellipse(xoffset+i*fbreite-fbreite+10,yoffset+j*fbreite-fbreite+10,
                       xoffset+i*fbreite+1-10,yoffset+j*fbreite+1-10);
    end; end end;


    geschafft:=true;
    for i:=1 to grad do
      for j:=1 to grad do
        if loesung[i,j]<>linie[i,j].f then geschafft:=false;
    if geschafft then begin
      for i:=1 to grad do begin
        for j:=1 to grad do begin
          if i<grad then if linie[i,j].f=linie[i+1,j].f then line(i,j,i+1,j);
          if j<grad then if linie[i,j].f=linie[i,j+1].f then line(i,j,i,j+1);
        end;
      end;
      pBox1.canvas.draw(0,0,bitmap);
      application.processmessages;
      showmessage('Gratulation! Die Spielstufe wurde gelöst.');
    end;
    pBox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tfflow.Button1Click(Sender: TObject);
var i,j,nr,aufgabennr:integer;
    k:string;
procedure wspiegeln;
var i,j:integer;
begin
    lfeldh:=lfeld;
    for i:=1 to grad do
    begin
      for j:=1 to grad do lfeld[j,1+grad-i]:=lfeldh[j,i];
    end;
    lfeldh:=loesung;
    for i:=1 to grad do
    begin
      for j:=1 to grad do loesung[j,1+grad-i]:=lfeldh[j,i];
    end;
end;
procedure sspiegeln;
var i,j:integer;
begin
    lfeldh:=lfeld;
    for i:=1 to grad do
    begin
      for j:=1 to grad do lfeld[1+grad-i,j]:=lfeldh[i,j];
    end;
    lfeldh:=loesung;
    for i:=1 to grad do
    begin
      for j:=1 to grad do loesung[1+grad-i,j]:=lfeldh[i,j];
    end;
end;
procedure diagonal;
var i,j:integer;
begin
    lfeldh:=lfeld;
    for i:=1 to grad do
    begin
      for j:=1 to grad do lfeld[i,j]:=lfeldh[j,i];
    end;
    lfeldh:=loesung;
    for i:=1 to grad do
    begin
      for j:=1 to grad do loesung[i,j]:=lfeldh[j,i];
    end;
end;
begin
    if inarbeit then exit;
    inarbeit:=true;
    grad:=8;
    fillchar(linie,sizeof(linie),0);
    fillchar(lfeld,sizeof(lfeld),0);
    fillchar(loesung,sizeof(loesung),0);
    aufgabennr:=spinedit1.value;
    nr:=listbox1.Items.IndexOf('['+inttostr(aufgabennr));
    grad:=strtoint(listbox1.Items[nr+1]);
    punktzahl:=strtoint(listbox1.Items[nr+2]);
    for i:=1 to grad do
    begin
      k:=listbox1.items[nr+2+i];
      for j:=1 to length(k) do begin
        if k[j] in ['A'..'K'] then begin
          lfeld[i,j]:=100+ord(k[j])-64;
          loesung[i,j]:=ord(k[j])-64;
        end else
          loesung[i,j]:=ord(k[j])-48;
      end;
    end;
    if random<0.5 then diagonal;
    if random<0.5 then wspiegeln;
    if random<0.5 then sspiegeln;
    inarbeit:=false;
    pBox1paint(sender);
end;

procedure Tfflow.PBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h,i,j,xoffset,yoffset,nrx,nry:integer;
begin
    b:=PBox1.width;
    h:=PBox1.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2-5;

    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;

// linie löschen
  if button=mbright then begin
    ziehfarbe:=linie[nrx,nry].f;
    if ziehfarbe>0 then begin
      for i:=1 to grad do
        for j:=1 to grad do
          if linie[i,j].f=ziehfarbe then begin
            linie[i,j].a.x:=0;
            linie[i,j].a.y:=0;
            linie[i,j].e.x:=0;
            linie[i,j].e.y:=0;
            linie[i,j].f:=0;
          end;
    end;
    pbox1Paint(Sender);
    exit;
  end;

  if not ziehen then begin
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) then
    begin
      if lfeld[nrx,nry]>100 then begin
        ziehen:=true;
        ziehfarbe:=lfeld[nrx,nry] mod 100;
        linie[nrx,nry].f:=ziehfarbe;
        xalt:=nrx;
        yalt:=nry;
      end else begin
        if linie[nrx,nry].f>0 then begin
          ziehen:=true;
          ziehfarbe:=linie[nrx,nry].f;
          xalt:=nrx;
          yalt:=nry;
        end else begin ziehen:=false; end;
      end;
    end else begin ziehen:=false; end;
    pbox1Paint(Sender);
  end;
end;

procedure Tfflow.PBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ziehen:=false;
  ziehfarbe:=0;
  pbox1Paint(Sender);
end;

procedure Tfflow.PBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var b,h,xoffset,yoffset,nrx,nry:integer;
begin
  if ziehen then begin
    b:=PBox1.width;
    h:=PBox1.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2-5;
    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) then
    begin
      if ((nrx<>xalt) or (nry<>yalt)) then begin
      if (linie[nrx,nry].f=0) or (linie[nrx,nry].f=ziehfarbe) then begin
        linie[nrx,nry].a.x:=xalt;
        linie[nrx,nry].a.y:=yalt;
        linie[nrx,nry].f:=ziehfarbe;
        linie[xalt,yalt].e.x:=nrx;
        linie[xalt,yalt].e.y:=nry;
        xalt:=nrx;
        yalt:=nry;
      end;
      end;
    end;
    pbox1Paint(Sender);
  end;

end;

procedure Tfflow.FormShow(Sender: TObject);
begin
  ziehen:=false;
  inarbeit:=false;
  Button1Click(Sender);
end;

end.


