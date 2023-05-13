unit ustraights;
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
  Tfstraights = class(TForm)
    P9: TPanel;
    P3: TPanel;
    P10: TPanel;
    pb1: TPaintBox;
    L7: TLabel;
    M1: TMemo;
    LB1: TListBox;
    Timer1: TTimer;
    CB1: TCheckBox;
    CB2: TCheckBox;
    Panel1: TPanel;
    Edit1: TEdit;
    D2: TButton;
    D5: TButton;
    D1: TButton;
    D6: TButton;
    D4: TButton;
    PopupMenu1: TPopupMenu;
    bernehmen1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure CB1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure D4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure D5Click(Sender: TObject);
    procedure D6Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fstraights: Tfstraights;

implementation

{$R *.DFM}
const fbreite:integer=68;
var
    lfeld,lfeld2,loesung,lfeldh : array[0..10,0..10] of integer;
    lmoeg,lmoegh : array[0..10,0..10] of string[10];
    zeit:tdatetime;
    altenummer,aufgabennr,spielnummer,nrx,nry:integer;
    hilfe,inarbeit:boolean;

procedure Tfstraights.FormCreate(Sender: TObject);
begin
   fstraights.width:=900;
   fstraights.height:=700;
   fstraights.doublebuffered:=true;
   altenummer:=-1;
   randomize;
   inarbeit:=false;
end;

procedure Tfstraights.pb1Paint(Sender: TObject);
const grad=9;
var b,h,i,j,xoffset,yoffset,ii:integer;
    bitmap:tbitmap;
    k:string;
    geschafft:boolean;
begin
    hilfe:=cb1.checked;
    b:=PB1.width;
    h:=PB1.height;
    bitmap:=tbitmap.create;
    bitmap.width:=PB1.width;
    bitmap.height:=PB1.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2-5;

    with bitmap.canvas do
    begin
      font.name:='Verdana';
      for i:=0 to grad-1 do
        for j:=0 to grad-1 do
        begin
          brush.color:=clwhite;
          pen.color:=clgray;
          if (lfeld[i+1,j+1]=0) or (lfeld2[i+1,j+1]=2) then
          begin
            brush.color:=clblack;
            font.color:=clwhite;
          end
          else
          begin
            brush.color:=clwhite;
            if lfeld2[i+1,j+1]=1 then font.color:=clnavy
                                 else font.color:=clblack;
          end;
          rectangle(xoffset+i*fbreite,yoffset+j*fbreite,
                    xoffset+i*fbreite+fbreite+1,yoffset+j*fbreite+fbreite+1);
          k:=inttostr(lfeld[i+1,j+1]);
          if hilfe then
            if (loesung[i+1,j+1]=lfeld[i+1,j+1]) and (lfeld2[i+1,j+1]=0) then
            begin
              brush.color:=clyellow;
              font.color:=clblack
            end
            else brush.style:=bsclear;
          font.size:=34;
          if lfeld2[i+1,j+1]>0 then
          begin
            textout(xoffset+i*fbreite+(fbreite div 2)-(textwidth(k) div 2),
                    yoffset+j*fbreite+(fbreite div 2)-(textheight(k) div 2),k);
          end
          else
          begin
            if length(lmoeg[i+1,j+1])=1 then
            begin
              k:=lmoeg[i+1,j+1];
              textout(xoffset+i*fbreite+(fbreite div 2)-(textwidth(k) div 2),
                      yoffset+j*fbreite+(fbreite div 2)-(textheight(k) div 2),k);
            end
            else
            begin
              if lfeld[i+1,j+1]>0 then
              begin
                if cb2.checked then
                begin
                  font.size:=9;
                  for ii:=1 to 9 do
                  begin
                    if pos(inttostr(ii),lmoeg[i+1,j+1])>0 then
                    begin
                      k:=inttostr(ii);
                      textout(xoffset+i*fbreite+5+((ii-1) mod 3)*16,
                              yoffset+j*fbreite+5+((ii-1) div 3)*16,k);
                    end;
                  end;
                end;
              end;
            end;
          end;
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
          if lfeld2[i,j]=0 then geschafft:=geschafft and (lfeld[i,j]=loesung[i,j]);
        end;
      if geschafft then
      begin
        if timer1.enabled then
          showmessage('Gratulation! Aufgabe wurde erfolgreich gelöst!');
        timer1.enabled:=false;
      end;
end;

procedure Tfstraights.D2Click(Sender: TObject);
const grad=9;
var i,j,anz,nr:integer; k:string;
procedure tauschen;
var i,j:integer;
begin
    for i:=1 to grad do begin
        for j:=1 to grad do if
           lfeld[j,i]<>0 then lfeld[j,i]:=10-lfeld[j,i];
      end;
end;
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
    lfeldh:=loesung;
    for i:=1 to grad do begin
        for j:=1 to grad do loesung[j,1+grad-i]:=lfeldh[j,i];
      end;
    lmoegh:=lmoeg;
    for i:=1 to grad do begin
        for j:=1 to grad do lmoeg[j,1+grad-i]:=lmoegh[j,i];
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
    lfeldh:=loesung;
    for i:=1 to grad do begin
        for j:=1 to grad do loesung[1+grad-i,j]:=lfeldh[i,j];
      end;
    lmoegh:=lmoeg;
    for i:=1 to grad do begin
        for j:=1 to grad do lmoeg[1+grad-i,j]:=lmoegh[i,j];
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
    lfeldh:=loesung;
    for i:=1 to grad do begin
        for j:=1 to grad do loesung[i,j]:=lfeldh[j,i];
      end;
    lmoegh:=lmoeg;
    for i:=1 to grad do begin
        for j:=1 to grad do lmoeg[i,j]:=lmoegh[j,i];
      end;
end;
begin
  if inarbeit then exit;
  if lb1.items.count>0 then begin
    inarbeit:=true;
    aufgabennr:=0;
    fillchar(loesung,sizeof(loesung),0);
    fillchar(lfeld,sizeof(lfeld),0);
    fillchar(lfeld2,sizeof(lfeld2),0);
    anz:=strtoint(lb1.items[0]);
    anz:=random(anz)+1;
    while anz=altenummer do begin
          anz:=strtoint(lb1.items[0]);
          anz:=random(anz)+1;
          end;
    altenummer:=anz;
    spielnummer:=anz;
    k:='['+inttostr(anz);
    nr:=lb1.items.indexof(k);
    for i:=1 to grad do begin
        k:=lb1.items[nr+i];
        for j:=1 to length(k) do lfeld[j,i]:=strtoint(k[j]);
    end;
    fillchar(loesung,sizeof(loesung),0);
    fillchar(lfeld2,sizeof(lfeld2),0);
    nr:=nr+grad;
    for i:=1 to grad do for j:=1 to grad do lmoeg[i,j]:='';
    for i:=1 to grad do begin
        k:=lb1.items[nr+i];
        for j:=1 to length(k) do begin
           case k[j] of
             '#' : begin loesung[j,i]:=0; lmoeg[j,i]:='123456789' end;
             'w' : begin loesung[j,i]:=1; lmoeg[j,i]:='-' end;
             's' : begin loesung[j,i]:=2; lmoeg[j,i]:='-' end;
           end;
        end;
    end;
    if random<0.5 then tauschen;
    if random<0.5 then diagonal;
    if random<0.5 then wspiegeln;
    if random<0.5 then sspiegeln;
    lfeld2:=loesung;
    fillchar(loesung,sizeof(loesung),0);
    inarbeit:=false;
    zeit:=time;
    timer1.enabled:=true;
    pB1paint(sender);
    end;
end;

procedure Tfstraights.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const grad=9;
var b,h,xoffset,yoffset:integer;
begin
    b:=PB1.width;
    h:=PB1.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2-5;

    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) then begin
      if (lmoeg[nrx,nry]<>'-') and (lfeld[nrx,nry]<>0) then begin
       panel1.left:=xoffset+nrx*fbreite+fbreite+44;
       panel1.top:=yoffset+nry*fbreite+fbreite-panel1.height-40;
       panel1.visible:=true;
       edit1.text:=lmoeg[nrx,nry];
       edit1.setfocus;
       end;
     end;
    pb1Paint(Sender);
end;

procedure Tfstraights.Timer1Timer(Sender: TObject);
begin
    L7.caption:=timetostr(time-zeit);
end;

procedure Tfstraights.D1Click(Sender: TObject);
const grad=9;
var i,j,anz:integer; ok:boolean;
begin
    anz:=0;
    for i:=1 to grad do for j:=1 to grad do begin
       if (loesung[i,j]<>lfeld[i,j]) and (lfeld2[i,j]=0) then inc(anz);
       end;
    if anz>1 then begin
       ok:=false;
       repeat
        i:=random(grad)+1;
        j:=random(grad)+1;
        if (loesung[i,j]<>lfeld[i,j]) and (lfeld2[i,j]=0) then begin
           loesung[i,j]:=lfeld[i,j];
           lmoeg[i,j]:=inttostr(loesung[i,j]);
           ok:=true;
           end;
        until ok;
      end;
    zeit:=zeit-600/(24*3600);
    pb1Paint(Sender);
end;

procedure Tfstraights.CB1Click(Sender: TObject);
begin
    if cb1.checked then zeit:=zeit-120/(24*3600);
    pb1paint(sender);
end;

procedure Tfstraights.FormActivate(Sender: TObject);
begin
    D2Click(Sender);
end;

procedure Tfstraights.D4Click(Sender: TObject);
var code:integer;
begin
    panel1.visible:=false;
   if edit1.text<>'' then begin
    lmoeg[nrx,nry]:=edit1.text;
    if length(lmoeg[nrx,nry])=1 then val(lmoeg[nrx,nry],loesung[nrx,nry],code)
                                else loesung[nrx,nry]:=0;
    end;
    pb1paint(sender);
end;

procedure Tfstraights.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (panel1.visible=true) then begin
    panel1.visible:=false;
    Action := caNone;
    exit;
    end;
end;

procedure Tfstraights.D5Click(Sender: TObject);
var i,j,a,b,z,code:integer; k2,k:string;
begin
   for i:=1 to 9 do for j:=1 to 9 do begin
    k:=lmoeg[i,j];
    if (length(k)>1) then begin
       a:=i;
       for b:=1 to 9 do begin
           if b<>j then begin
              z:=lfeld[a,b];
              if (z>0) and ((lfeld2[a,b]>0) or ((lfeld2[a,b]=0) and (loesung[a,b]>0)))
                 then begin
                 k2:=inttostr(z);
                 if pos(k2,k)>0 then delete(k,pos(k2,k),1);
           end; end; end;
       a:=j;
       for b:=1 to 9 do begin
           if b<>i then begin
              z:=lfeld[b,a];
              if (z>0) and ((lfeld2[b,a]>0) or ((lfeld2[b,a]=0) and (loesung[b,a]>0)))
                 then begin
                 k2:=inttostr(z);
                 if pos(k2,k)>0 then delete(k,pos(k2,k),1);
           end; end; end;

      if lfeld[i,j]>0 then begin
       lmoeg[i,j]:=k;
       if length(lmoeg[i,j])=1 then val(lmoeg[i,j],loesung[i,j],code)
                                else loesung[i,j]:=0;
                           end;
       end;
    end;
    zeit:=zeit-60/(24*3600);
    pb1paint(sender);
end;

procedure Tfstraights.D6Click(Sender: TObject);
var i,j,code:integer;
begin
       timer1.enabled:=false;
   for i:=1 to 9 do for j:=1 to 9 do begin
      if lfeld[i,j]>0 then begin
        lmoeg[i,j]:=inttostr(lfeld[i,j]);
        val(lmoeg[i,j],loesung[i,j],code);
        end;
        end;
    pb1paint(sender);
end;

end.


