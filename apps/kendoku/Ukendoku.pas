unit Ukendoku;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, Spin;

type
  Tfkendo = class(TForm)
    Panel3: TPanel;
    Panel2: TPanel;
    Panel1: TPanel;
    Button2: TButton;
    PBox: TPaintBox;
    Memo1: TMemo;
    Button1: TButton;
    MM1: TMainMenu;
    MP3: TMenuItem;
    MP1: TMenuItem;
    MP2: TMenuItem;
    Checkbox1: TCheckBox;
    Label1: TLabel;
    ListBox1: TListBox;
    SpinEdit1: TSpinEdit;
    procedure CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PBoxPaint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fkendo: Tfkendo;

implementation

{$R *.DFM}
const fbreite:integer=80;
      schriftgroesse:integer=34;
var   lfeld,loesung:array[0..11,0..11] of integer;
      linienx,linieny:array[0..11,0..11] of integer;
      aufgaben:array[1..40] of record
                                 x,y : integer;
                                   o : integer;
                         a,b,c,d,e,f : integer;
                               end;
      aufgabennr,grad,spielnummer:integer;
      hilfe:boolean;
      inarbeit:boolean;
      kendokuliste:tstringlist;

procedure Tfkendo.FormCreate(Sender: TObject);
begin
    randomize;
    kendokuliste:=tstringlist.create;
    kendokuliste.assign(listbox1.items);
    inarbeit:=false;
end;

procedure Tfkendo.CloseClick(Sender: TObject);
begin
    close;
end;

procedure Tfkendo.PBoxPaint(Sender: TObject);
var breite,hoehe,
    i,j,
    xoffset,yoffset:integer;
    bitmap:tbitmap;
    ziel:tcanvas;
    kk,k:string;
    geschafft:boolean;
    ergebnis:integer;

procedure testzeile(a:integer);
var ff:array[1..8] of boolean;
    b:integer;
begin
    fillchar(ff,sizeof(ff),false);
    for b:=1 to grad do ff[loesung[a,b]]:=true;
    for b:=1 to grad do geschafft:=geschafft and ff[b];
end;
procedure testspalte(a:integer);
var ff:array[1..8] of boolean;
    b:integer;
begin
    fillchar(ff,sizeof(ff),false);
    for b:=1 to grad do ff[loesung[b,a]]:=true;
    for b:=1 to grad do geschafft:=geschafft and ff[b];
end;

begin
    hilfe:=Checkbox1.checked;
    breite:=PBox.width;
    hoehe:=PBox.height;

    fbreite:=(hoehe-60) div grad;
    if (breite-60) div grad<fbreite then fbreite:=(breite-60) div grad;
    schriftgroesse:=round(fbreite/2.1);

    bitmap:=tbitmap.create;
    bitmap.width:=PBox.width;
    bitmap.height:=PBox.height;
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
        ziel.font.color:=clblack;
        ziel.font.size:=schriftgroesse;
        if loesung[i+1,j+1]>0 then
        begin
          k:=inttostr(loesung[i+1,j+1]);
          if hilfe then
            if loesung[i+1,j+1]=lfeld[i+1,j+1] then ziel.brush.color:=clyellow
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
      for i:=1 to aufgabennr do
      begin
        case aufgaben[i].o of
          0 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y];
                kk:=inttostr(ergebnis);
              end;
          1 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]+lfeld[aufgaben[i].a,aufgaben[i].b];
                kk:=inttostr(ergebnis)+'+';
              end;
          2 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]-lfeld[aufgaben[i].a,aufgaben[i].b];
                kk:=inttostr(ergebnis)+'-';
              end;
          3 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]*lfeld[aufgaben[i].a,aufgaben[i].b];
                kk:=inttostr(ergebnis)+'*';
              end;
          4 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y] div lfeld[aufgaben[i].a,aufgaben[i].b];
                kk:=inttostr(ergebnis)+':';
              end;
          5 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]+lfeld[aufgaben[i].a,aufgaben[i].b]
                         +lfeld[aufgaben[i].c,aufgaben[i].d];
                kk:=inttostr(ergebnis)+'+';
              end;
          6 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]*lfeld[aufgaben[i].a,aufgaben[i].b]
                         *lfeld[aufgaben[i].c,aufgaben[i].d];
                kk:=inttostr(ergebnis)+'*';
              end;
          7 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]+lfeld[aufgaben[i].a,aufgaben[i].b]
                          +lfeld[aufgaben[i].c,aufgaben[i].d]+lfeld[aufgaben[i].e,aufgaben[i].f];
                kk:=inttostr(ergebnis)+'+';
              end;
          8 : begin
                ergebnis:=lfeld[aufgaben[i].x,aufgaben[i].y]*lfeld[aufgaben[i].a,aufgaben[i].b]
                         *lfeld[aufgaben[i].c,aufgaben[i].d]*lfeld[aufgaben[i].e,aufgaben[i].f];
                kk:=inttostr(ergebnis)+'*';
              end;
        end;
        ziel.textout(xoffset+(aufgaben[i].x-1)*fbreite+3,
                     yoffset+(aufgaben[i].y-1)*fbreite+2,kk);
      end;

    ziel.pen.width:=3;
    ziel.pen.color:=clnavy;
    ziel.brush.style:=bsclear;
    ziel.rectangle(xoffset-1,yoffset-1,
                   xoffset+grad*fbreite+2,yoffset+grad*fbreite+2);
    ziel.pen.width:=1;

    pBox.canvas.draw(0,0,bitmap);
    bitmap.free;

    geschafft:=true;
    for i:=1 to grad do
      for j:=1 to grad do geschafft:=geschafft and (loesung[i,j]>0);
    if geschafft then
    begin
      for i:=1 to grad do testzeile(i);
      for i:=1 to grad do testspalte(i);
    end;
    if geschafft then
      showmessage('Gratulation! Aufgabe wurde erfolgreich gelöst!');
end;

procedure Tfkendo.Button2Click(Sender: TObject);
var w,i,j,anz,
    nr,laenge:integer;
    k:string;
    z1,z2:integer;
    lauf:boolean;
procedure latein;
var a:array of array of integer;
    i,j,n:integer;
PROCEDURE Ausgabe;
VAR i,j:Integer;
bEGIN
    FOR i:=1 TO n DO
    BEGIN
      FOR j:=1 TO n DO
      begin
          lfeld[i,j]:=a[i,j];
      end;
    END;
END;
procedure next(i,j:integer);
var k:integer;
    m:set of 1..33;
begin
    if lauf then
    begin
      m:=[];
      for k:=1 to i-1 do m:=m+[a[k,j]];
      for k:=1 to j-1 do m:=m+[a[i,k]];
      for k:=1 to n do
        if not(k in m) then
        begin
          a[i,j]:=k;
          if j<n then next(i,j+1)
          else
            if i<n then next(i+1,2)
            else
            begin
              ausgabe;
              lauf:=false;
            end
        end
     end
end;
begin
    n:=grad;
    lauf:=true;
    setlength(a,n+2,n+2);
    for i:=1 to n do
      for j:=1 to n do a[i,j]:=0;
    for i:=1 to n do
    begin
      a[i,1]:=i;
      a[1,i]:=i
    end;
    next(2,2);
    setlength(a,0);
end;
begin
    if inarbeit then exit;
    inarbeit:=true;
    grad:=spinedit1.value;
    latein;
    for w:=1 to 20 do
    begin
      for i:=1 to 10 do
      begin
        z1:=random(grad)+1;
        z2:=random(grad)+1;
        for j:=1 to grad do loesung[1,j]:=lfeld[z1,j];
        for j:=1 to grad do lfeld[z1,j]:=lfeld[z2,j];
        for j:=1 to grad do lfeld[z2,j]:=loesung[1,j];
      end;
      for i:=1 to 10 do
      begin
        z1:=random(grad)+1;
        z2:=random(grad)+1;
        for j:=1 to grad do loesung[j,1]:=lfeld[j,z1];
        for j:=1 to grad do lfeld[j,z1]:=lfeld[j,z2];
        for j:=1 to grad do lfeld[j,z2]:=loesung[j,1];
      end;
    end;

    fillchar(loesung,sizeof(loesung),0);
    fillchar(linienx,sizeof(linienx),0);
    fillchar(linieny,sizeof(linieny),0);
    fillchar(aufgaben,sizeof(aufgaben),0);
    aufgabennr:=0;

    k:='#'+inttostr(grad);
    i:=kendokuliste.indexof(k)+1;
    anz:=strtoint(kendokuliste[i]);
    anz:=random(anz)+1;
    spielnummer:=anz;
    k:='['+inttostr(grad)+'-'+inttostr(anz);
    nr:=kendokuliste.indexof(k);
    for i:=1 to grad do
    begin
      k:=kendokuliste[nr+i];
      for j:=1 to length(k) do linienx[i,strtoint(k[j])]:=1;
    end;
    nr:=nr+grad;
    for i:=1 to grad do
    begin
      k:=kendokuliste[nr+i];
      for j:=1 to length(k) do linieny[i,strtoint(k[j])]:=1;
    end;

    nr:=nr+grad+1;
    k:=kendokuliste[nr];
    while k[1]<>'[' do
    begin
      laenge:=length(k);
      inc(aufgabennr);
      aufgaben[aufgabennr].x:=strtoint(k[1]);
      aufgaben[aufgabennr].y:=strtoint(k[2]);
      if length(k)>2 then
      begin
        aufgaben[aufgabennr].a:=strtoint(k[3]);
        aufgaben[aufgabennr].b:=strtoint(k[4]);
        if length(k)>4 then
        begin
          aufgaben[aufgabennr].c:=strtoint(k[5]);
          aufgaben[aufgabennr].d:=strtoint(k[6]);
          if length(k)>6 then
          begin
            aufgaben[aufgabennr].e:=strtoint(k[7]);
            aufgaben[aufgabennr].f:=strtoint(k[8]);
          end
        end
      end;

      case laenge of
        2 : aufgaben[aufgabennr].o:=0;
        6 : aufgaben[aufgabennr].o:=random(2)+5;
        8 : aufgaben[aufgabennr].o:=random(2)+7;
        4 : begin
              if lfeld[aufgaben[aufgabennr].x,aufgaben[aufgabennr].y]
                 mod lfeld[aufgaben[aufgabennr].a,aufgaben[aufgabennr].b] = 0
              then aufgaben[aufgabennr].o:=random(4)+1
              else aufgaben[aufgabennr].o:=random(3)+1;
            end;
      end;
      inc(nr);
      k:=kendokuliste[nr];
    end;
    inarbeit:=false;
    pBoxpaint(sender);
end;

procedure Tfkendo.PBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var breite,hoehe,xoffset,yoffset,nrx,nry:integer;
begin
    breite:=PBox.width;
    hoehe:=PBox.height;
    xoffset:=(breite-(grad*fbreite)) div 2;
    yoffset:=(hoehe-(grad*fbreite)) div 2-5;

    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) then
    begin
      if (lfeld[nrx,nry]>0) then
      begin
        inc(loesung[nrx,nry]);
        if loesung[nrx,nry]>grad then loesung[nrx,nry]:=0;
      end;
    end;
    pboxPaint(Sender);
end;

procedure Tfkendo.Button1Click(Sender: TObject);
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
    pboxPaint(Sender);
end;

procedure Tfkendo.FormActivate(Sender: TObject);
begin
    Button2Click(Sender);
end;

procedure Tfkendo.FormDestroy(Sender: TObject);
begin
    kendokuliste.free;
end;

end.


