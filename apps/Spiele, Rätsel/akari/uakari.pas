unit uakari;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, ComCtrls, Buttons;

type
  Tfakari = class(TForm)
    P9: TPanel;
    P3: TPanel;
    P10: TPanel;
    D2: TButton;
    pb1: TPaintBox;
    L7: TLabel;
    M1: TMemo;
    Timer1: TTimer;
    D1: TButton;
    MM1: TMainMenu;
    M12: TMenuItem;
    L1: TLabel;
    I1: TImage;
    I2: TImage;
    ListBox1: TListBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure MPntCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fakari: Tfakari;

implementation

{$R *.DFM}
const fbreite:integer=44;
      schriftgroesse:integer=34;
      
var lfeld,lfeld2,lfeld3,loesung,lfeldh:array[0..15,0..15] of integer;
    zeit:tdatetime;
    altenummer,aufgabennr,grad,spielnummer:integer;
    inarbeit:boolean;
    akariliste:tstringlist;

procedure Tfakari.FormCreate(Sender: TObject);
begin
   fakari.caption:='Akari';
   altenummer:=-1;
   randomize;
   akariliste:=tstringlist.create;
   akariliste.assign(listbox1.items);
   inarbeit:=false;
   helpcontext:=818;
end;

procedure Tfakari.MPntCloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfakari.pb1Paint(Sender: TObject);
var fb,b,h,i,j,xoffset,yoffset,nachbarn:integer;
    bitmap:tbitmap;
    k:string;
    geschafft:boolean;
begin
    b:=PB1.width;
    h:=PB1.height;

    fb:=(h-60) div grad;
    if (b-60) div grad<fb then fb:=(b-60) div grad;
    fbreite:=fb;
    schriftgroesse:=fb div 2;

    bitmap:=tbitmap.create;
    bitmap.width:=PB1.width;
    bitmap.height:=PB1.height;
    bitmap.canvas.brush.bitmap:=i2.picture.bitmap;//claqua;
    bitmap.canvas.rectangle(-1,-1,b+1,h+1);
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2;
    with bitmap.canvas do
    begin
      font.name:='Verdana';
      for i:=0 to grad-1 do
        for j:=0 to grad-1 do
        begin
          brush.color:=clwhite;
          pen.color:=clgray;
          font.size:=schriftgroesse;//24;
          if lfeld[i+1,j+1] in [0..5] then
          begin
            brush.color:=clblack;
            font.color:=clwhite;
          end
          else
          begin
            brush.color:=clwhite;
            font.color:=clblack;
          end;
          if (lfeld3[i+1,j+1]>=1) then brush.color:=$00b0ffff;

          rectangle(xoffset+i*fbreite,yoffset+j*fbreite,
                 xoffset+i*fbreite+fbreite+1,yoffset+j*fbreite+fbreite+1);
          k:=inttostr(lfeld[i+1,j+1]-1);
          brush.style:=bsclear;

          if lfeld[i+1,j+1] in [1..5] then
             textout(xoffset+i*fbreite+(fbreite div 2)-(textwidth(k) div 2),
                     yoffset+j*fbreite+(fbreite div 2)-(textheight(k) div 2),k);
          if loesung[i+1,j+1]=1 then
             draw(xoffset+i*fbreite+(fbreite div 2)-20,yoffset+j*fbreite+(fbreite div 2)-20,
                  i1.picture.bitmap);
        end;
        brush.style:=bsclear;
      end;
      bitmap.canvas.pen.width:=3;
      bitmap.canvas.pen.color:=clnavy;
      bitmap.canvas.brush.style:=bsclear;
      bitmap.canvas.rectangle(xoffset-1,yoffset-1,
                              xoffset+grad*fbreite+2,yoffset+grad*fbreite+2);
      bitmap.canvas.pen.width:=1;
      pB1.canvas.draw(0,0,bitmap);
      bitmap.free;
      geschafft:=true;
      for i:=1 to grad do
        for j:=1 to grad do
        begin
          if lfeld[i,j] in [9,10] then
            geschafft:=geschafft and (lfeld3[i,j]>0);
          if lfeld[i,j] in [1,2,3,4,5] then begin
             nachbarn:=0;
             if loesung[i-1,j]=1 then inc(nachbarn);
             if loesung[i,j-1]=1 then inc(nachbarn);
             if loesung[i,j+1]=1 then inc(nachbarn);
             if loesung[i+1,j]=1 then inc(nachbarn);
             if nachbarn<>lfeld[i,j]-1 then geschafft:=false;
           end;

           end;

    if geschafft then begin
      if timer1.enabled then showmessage('Gratulation! Aufgabe wurde erfolgreich gelöst!');
      zeit:=0;
      timer1.enabled:=false;
     end;
end;

procedure Tfakari.D2Click(Sender: TObject);
var i,j,anz,nr:integer; k:string;
procedure wspiegeln;
var i,j:integer;
begin
    lfeldh:=lfeld;
    for i:=1 to grad do begin
        for j:=1 to grad do lfeld[j,1+grad-i]:=lfeldh[j,i];
      end;
    lfeldh:=lfeld2;
    for i:=1 to grad do begin
        for j:=1 to grad do lfeld2[j,1+grad-i]:=lfeldh[j,i];
      end;
end;
procedure sspiegeln;
var i,j:integer;
begin
    lfeldh:=lfeld;
    for i:=1 to grad do begin
        for j:=1 to grad do lfeld[1+grad-i,j]:=lfeldh[i,j];
      end;
    lfeldh:=lfeld2;
    for i:=1 to grad do begin
        for j:=1 to grad do lfeld2[1+grad-i,j]:=lfeldh[i,j];
      end;
end;
procedure diagonal;
var i,j:integer;
begin
    lfeldh:=lfeld;
    for i:=1 to grad do begin
        for j:=1 to grad do lfeld[i,j]:=lfeldh[j,i];
      end;
    lfeldh:=lfeld2;
    for i:=1 to grad do begin
        for j:=1 to grad do lfeld2[i,j]:=lfeldh[j,i];
      end;
end;
begin
  if inarbeit then exit;
    inarbeit:=true;
    grad:=updown1.position;
    aufgabennr:=0;
    fillchar(loesung,sizeof(loesung),0);
    fillchar(lfeld,sizeof(lfeld),0);
    fillchar(lfeld2,sizeof(lfeld2),0);
    fillchar(lfeld3,sizeof(lfeld3),0);

    k:='#'+inttostr(grad);
    i:=akariliste.indexof(k)+1;
    anz:=strtoint(akariliste[i]);
    anz:=random(anz)+1;
    while anz=altenummer do begin
          anz:=strtoint(akariliste[i]);
          anz:=random(anz)+1;
          end;
    altenummer:=anz;
    spielnummer:=anz;
    k:='['+inttostr(grad)+'-'+inttostr(anz);
    nr:=akariliste.indexof(k);

    for i:=1 to grad do begin
        k:=akariliste[nr+i];
        for j:=1 to length(k) do
           case k[j] of
            '0'..'4' : lfeld[i,j]:=strtoint(k[j])+1;
            's' : lfeld[i,j]:=0;
            'x' : lfeld[i,j]:=9;
            'o' : begin lfeld[i,j]:=10; lfeld2[i,j]:=1 end;
           end;
    end;
    fillchar(loesung,sizeof(loesung),0);
    if random<0.5 then diagonal;
    if random<0.5 then wspiegeln;
    if random<0.5 then sspiegeln;
    inarbeit:=false;
    zeit:=time;
    timer1.enabled:=true;
    pB1paint(sender);
end;

procedure Tfakari.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h,xoffset,yoffset,nrx,nry,i,j,m,n:integer;
begin
    b:=PB1.width;
    h:=PB1.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2;

    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) and
        ((lfeld[nrx,nry]=9) or (lfeld[nrx,nry]=10))
        and
        ((loesung[nrx,nry]=1) or (lfeld3[nrx,nry]=0)) then begin
        if (loesung[nrx,nry]=0) then inc(loesung[nrx,nry])
                                else dec(loesung[nrx,nry]);
     end;
    fillchar(lfeld3,sizeof(lfeld3),0);
    i:=1;
    repeat
     j:=1;
     repeat
      if loesung[i,j]=1 then begin
          lfeld3[i,j]:=1;
          m:=i; n:=j-1; while (n>0) and (lfeld[m,n] in [9,10]) do
                              begin lfeld3[m,n]:=1; dec(n) end;
          m:=i; n:=j+1; while (n<=grad) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); inc(n) end;
          m:=i-1; n:=j; while (m>0) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); dec(m) end;
          m:=i+1; n:=j; while (m<=grad) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); inc(m) end;
         end;
      inc(j);
     until j>grad;
     inc(i);
    until i>grad;

    pb1Paint(Sender);
end;

procedure Tfakari.Timer1Timer(Sender: TObject);
begin
    L7.caption:=timetostr(time-zeit);
end;

procedure Tfakari.D1Click(Sender: TObject);
var i,j,anz,m,n:integer; ok:boolean;
begin
    anz:=0;
    for i:=1 to grad do for j:=1 to grad do begin
       if (loesung[i,j]<>lfeld2[i,j]) then inc(anz);
       end;
    if anz>1 then begin
       ok:=false;
       repeat
        i:=random(grad)+1;
        j:=random(grad)+1;
        if (loesung[i,j]<>lfeld2[i,j]) then begin
           loesung[i,j]:=lfeld2[i,j];
           ok:=true;
           end;
        until ok;

    fillchar(lfeld3,sizeof(lfeld3),0);
    i:=1;
    repeat
     j:=1;
     repeat
      if loesung[i,j]=1 then begin
          lfeld3[i,j]:=1;
          m:=i; n:=j-1; while (n>0) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); dec(n) end;
          m:=i; n:=j+1; while (n<=grad) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); inc(n) end;
          m:=i-1; n:=j; while (m>0) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); dec(m) end;
          m:=i+1; n:=j; while (m<=grad) and (lfeld[m,n] in [9,10]) do
                              begin inc(lfeld3[m,n]); inc(m) end;
         end;
      inc(j);
     until j>grad;
     inc(i);
    until i>grad;

      end;

    pb1Paint(Sender);
end;

procedure Tfakari.FormActivate(Sender: TObject);
begin
    grad:=10;
    D2Click(Sender);
end;

procedure Tfakari.FormDestroy(Sender: TObject);
begin
    akariliste.free;
end;

end.


