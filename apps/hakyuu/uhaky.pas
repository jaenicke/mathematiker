unit uhaky;
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
  Tfhaky = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    PBox1: TPaintBox;
    Memo1: TMemo;
    D1: TButton;
    MM1: TMainMenu;
    M2: TMenuItem;
    M1: TMenuItem;
    M3: TMenuItem;
    CB1: TCheckBox;
    Label1: TLabel;
    ListBox1: TListBox;
    SpinEdit1: TSpinEdit;
    procedure CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rx1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fhaky: Tfhaky;

implementation

{$R *.DFM}
const fbreite:integer=80;
      schriftgroesse:integer=34;
var lfeld,lfeld2,loesung,lfeldh:array[0..10,0..10] of integer;
    linienx,linieny,linienh:array[0..10,0..10] of integer;
    altenummer,aufgabennr,grad,spielnummer:integer;
    hilfe:boolean;
    inarbeit:boolean;
    hakyliste:tstringlist;

procedure Tfhaky.FormCreate(Sender: TObject);
begin
    altenummer:=-1;
    randomize;
    hakyliste:=tstringlist.create;
    hakyliste.assign(listbox1.items);
    inarbeit:=false;
end;

procedure Tfhaky.CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfhaky.PBox1Paint(Sender: TObject);
var breite,hoehe,i,j,xoffset,yoffset:integer;
    bitmap:tbitmap;
    ziel:tcanvas;
    kk,k:string;
    geschafft:boolean;
    ergebnis:integer;
begin
    hilfe:=cb1.checked;
    breite:=PBox1.width;
    hoehe:=PBox1.height;

    fbreite:=(hoehe-60) div grad;
    if (breite-60) div grad<fbreite then fbreite:=(breite-60) div grad;
    schriftgroesse:=round(fbreite/2.2);

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
        ziel.brush.color:=clwhite;
        ziel.pen.color:=clgray;
        ziel.rectangle(xoffset+i*fbreite,yoffset+j*fbreite,
                    xoffset+i*fbreite+fbreite+1,yoffset+j*fbreite+fbreite+1);
        ziel.font.size:=schriftgroesse;//36;
        if loesung[i+1,j+1]>0 then
        begin
          if loesung[i+1,j+1]=lfeld2[i+1,j+1] then ziel.font.color:=clblue
                                              else ziel.font.color:=clblack;
          k:=inttostr(loesung[i+1,j+1]);
          if hilfe then
            if (loesung[i+1,j+1]=lfeld[i+1,j+1])
               and (ziel.font.color=clblack) then ziel.brush.color:=clyellow
                                             else ziel.brush.style:=bsclear;
          ziel.textout(xoffset+i*fbreite+(fbreite div 2)-(ziel.textwidth(k) div 2),
                      yoffset+j*fbreite+(fbreite div 2)-(ziel.textheight(k) div 2),k);
          end;
      end;

      ziel.pen.color:=clblack;
      ziel.pen.width:=3;
      for i:=1 to grad do
        for j:=1 to grad do
        begin
          if linienx[i,j]=1 then
          begin
            ziel.moveto(xoffset+j*fbreite,yoffset+(i-1)*fbreite);
            ziel.lineto(xoffset+j*fbreite,yoffset+i*fbreite);
          end;
        end;
      for i:=1 to grad do
        for j:=1 to grad do
        begin
          if linieny[i,j]=1 then
          begin
            ziel.moveto(xoffset+(i-1)*fbreite,yoffset+j*fbreite);
            ziel.lineto(xoffset+i*fbreite,yoffset+j*fbreite);
          end;
        end;
      ziel.font.size:=9;
      ziel.brush.style:=bsclear;

      ziel.pen.width:=3;
      ziel.pen.color:=clnavy;
      ziel.brush.style:=bsclear;
      ziel.rectangle(xoffset-1,yoffset-1,
                     xoffset+grad*fbreite+2,yoffset+grad*fbreite+2);
      ziel.pen.width:=1;
      pBox1.canvas.draw(0,0,bitmap);
      bitmap.free;

      geschafft:=true;
      for i:=1 to grad do
        for j:=1 to grad do
          geschafft:=geschafft and (lfeld[i,j]=loesung[i,j]);
      for i:=1 to grad do
        for j:=1 to grad do geschafft:=geschafft and (loesung[i,j]>0);
      if geschafft then
        showmessage('Gratulation! Aufgabe wurde erfolgreich gelöst!');
end;

procedure Tfhaky.Button1Click(Sender: TObject);
var i,j,anz,nr:integer;
    k:string;
procedure wspiegeln;
var i,j:integer;
begin
    linienh:=linienx;
    for i:=1 to grad do
    begin
      for j:=1 to grad do linienx[1+grad-i,j]:=linienh[i,j];
    end;
    linienh:=linieny;
    for i:=1 to grad do
    begin
      for j:=1 to grad do linieny[i,grad-j]:=linienh[i,j];
    end;
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
    linienh:=linieny;
    for i:=1 to grad do
    begin
      for j:=1 to grad do linieny[1+grad-i,j]:=linienh[i,j];
    end;
    linienh:=linienx;
    for i:=1 to grad do
    begin
      for j:=1 to grad do linienx[i,grad-j]:=linienh[i,j];
    end;
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
    linienh:=linieny;
    linieny:=linienx;
    linienx:=linienh;
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
    grad:=spinedit1.value;
    aufgabennr:=0;
    fillchar(loesung,sizeof(loesung),0);
    fillchar(lfeld,sizeof(lfeld),0);
    fillchar(lfeld2,sizeof(lfeld2),0);
    fillchar(linienx,sizeof(linienx),0);
    fillchar(linieny,sizeof(linieny),0);

    k:='#'+inttostr(grad);
    i:=hakyliste.indexof(k)+1;
    anz:=strtoint(hakyliste[i]);
    anz:=random(anz)+1;
    while anz=altenummer do
    begin
      anz:=strtoint(hakyliste[i]);
      anz:=random(anz)+1;
    end;
    altenummer:=anz;
    spielnummer:=anz;
    k:='['+inttostr(grad)+'-'+inttostr(anz);
    nr:=hakyliste.indexof(k);
    for i:=1 to grad do
    begin
      k:=hakyliste[nr+i];
      for j:=1 to length(k) do linienx[i,strtoint(k[j])]:=1;
    end;
    nr:=nr+grad;
    for i:=1 to grad do
    begin
      k:=hakyliste[nr+i];
      for j:=1 to length(k) do linieny[i,strtoint(k[j])]:=1;
    end;

    nr:=nr+grad;
    for i:=1 to grad do
    begin
      k:=hakyliste[nr+i];
      for j:=1 to length(k) do lfeld[j,i]:=strtoint(k[j]);
    end;
    fillchar(loesung,sizeof(loesung),0);
    fillchar(lfeld2,sizeof(lfeld2),0);
    nr:=nr+grad;
    i:=1;
    repeat
      k:=hakyliste[nr+i];
      if k[1]<>'[' then
      begin
        loesung[strtoint(k[1]),strtoint(k[2])]:=strtoint(k[4]);
      end;
      inc(i);
    until k[1]='[';
    if random<0.5 then diagonal;
    if random<0.5 then wspiegeln;
    if random<0.5 then sspiegeln;

    lfeld2:=loesung;
    inarbeit:=false;
    pBox1paint(sender);
end;

procedure Tfhaky.PBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h,xoffset,yoffset,nrx,nry,gradhier:integer;
begin
    b:=PBox1.width;
    h:=PBox1.height;
    case grad of
      6,7 : gradhier:=grad-2;
       else gradhier:=grad-1;
    end;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2-5;

    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) then
    begin
      if (lfeld2[nrx,nry]=0) then
      begin
        inc(loesung[nrx,nry]);
        if loesung[nrx,nry]>gradhier then loesung[nrx,nry]:=0;
      end;
    end;
    pbox1Paint(Sender);
end;

procedure Tfhaky.D1Click(Sender: TObject);
var i,j,anz:integer;
    ok:boolean;
begin
    anz:=0;
    for i:=1 to grad do
      for j:=1 to grad do
      begin
        if (lfeld[i,j]>0) and (loesung[i,j]<>lfeld[i,j]) then inc(anz);
      end;
    if anz>1 then
    begin
      ok:=false;
      repeat
        i:=random(grad)+1;
        j:=random(grad)+1;
        if (lfeld[i,j]>0) and (loesung[i,j]<>lfeld[i,j]) then
        begin
          loesung[i,j]:=lfeld[i,j];
          ok:=true;
        end;
      until ok;
    end;
    pbox1Paint(Sender);
end;

procedure Tfhaky.FormActivate(Sender: TObject);
begin
    Button1Click(Sender);
end;

procedure Tfhaky.rx1Change(Sender: TObject);
begin
     altenummer:=-1;
     button1click(sender);
end;

procedure Tfhaky.FormDestroy(Sender: TObject);
begin
    hakyliste.free;
end;

procedure Tfhaky.SpinEdit1Change(Sender: TObject);
begin
     altenummer:=-1;
     button1click(sender);
end;

end.


