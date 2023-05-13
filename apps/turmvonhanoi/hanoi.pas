unit hanoi;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, Menus, StdCtrls, ComCtrls;

type
  Tfhano = class(TForm)
    PB1: TPaintBox;
    p1: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    p2L5: TLabel;
    L1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    lb2: TListBox;
    L3: TLabel;
    c12: TCheckBox;
    L4: TLabel;
    L5: TLabel;
    L6: TLabel;
    L2: TLabel;
    L7: TLabel;
    Anteil: TLabel;
    L9: TLabel;
    L8: TLabel;
    L10: TLabel;
    L11: TLabel;
    CB1: TCheckBox;
    R1: TRadioButton;
    R2: TRadioButton;
    L12: TLabel;
    Button1: TButton;
    Button2: TButton;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown2: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure D2Click(Sender: TObject);
    procedure d2click4(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure lb2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fhano: Tfhano;

implementation

const sabbruch:boolean=true;
    gefunden:boolean=false;
    maxzahl=37;
    unten:integer=120;
    shoehe:integer=18;

var scheibenzahl:integer;
    stab:array[1..4,0..maxzahl] of integer;
    bitmap,bitmap2,bitmap3:tbitmap;
    move1,move2,zuege,bfaktor,ffaktor:integer;
    gesamtzuege:real;
{$R *.DFM}

procedure Tfhano.FormCreate(Sender: TObject);
begin
   sabbruch:=true;
   gefunden:=false;
end;

procedure Tfhano.D1Click(Sender: TObject);
var i,addi:integer;
begin
   if sabbruch=false then begin sabbruch:=true; exit end;

   randomize;
   if r1.checked then
   begin
     for i:=0 to maxzahl do begin stab[2,i]:=0; stab[1,i]:=0; stab[3,i]:=0 end;
     scheibenzahl:=updown1.position;
     ffaktor:=255 div (scheibenzahl+2);
     bfaktor:=100 div (scheibenzahl+3);
     stab[1,0]:=updown1.position;
     zuege:=0;
     lb2.clear;
     for i:=1 to updown1.position do stab[1,i]:=i;
     gesamtzuege:=1;
     for i:=1 to scheibenzahl do gesamtzuege:=2*gesamtzuege;
     gesamtzuege:=gesamtzuege-1;
   end;
   if r2.checked then
   begin
     for i:=0 to maxzahl do begin stab[2,i]:=0; stab[1,i]:=0; stab[3,i]:=0; stab[4,i]:=0 end;
     scheibenzahl:=updown1.position;
     ffaktor:=255 div (scheibenzahl+2);
     bfaktor:=80 div (scheibenzahl+3);
     stab[1,0]:=updown1.position;
     zuege:=0;
     lb2.clear;
     for i:=1 to updown1.position do stab[1,i]:=i;
     gesamtzuege:=5;
     addi:=2;
     for i:=4 to scheibenzahl do
     begin
       if i in [4,7,11,16,22,29,37,46,56] then addi:=addi*2;
       gesamtzuege:=gesamtzuege+addi;
     end;
   end;
   if gesamtzuege>1e9 then
     l7.caption:=floattostrf(gesamtzuege/1e9,ffgeneral,1,1)+' Md.'
   else
     l7.caption:=floattostr(gesamtzuege);
   pb1paint(sender);
end;

function skalenfarbe(i:integer):integer;
begin
    skalenfarbe:=rgb(255-ffaktor*i,255-ffaktor*i,ffaktor*i)
end;

procedure Tfhano.PB1Paint(Sender: TObject);
var b,h,i,j,nr:integer;
    sho:real;
procedure vierscheiben;
var i,j,wert:integer;
begin
    b:=pb1.width div 5;
    h:=pb1.height;
    with bitmap.canvas do
    begin
      font.name:='Verdana';
      font.size:=16;
      brush.color:=clwhite;
      pen.color:=clwhite;
      rectangle(-1,-1,pb1.width+1,pb1.height-unten+51);
      pen.color:=clblack;
      brush.color:=$0080c0c0;
      roundrect(b div 4,h-unten,pb1.width-(b div 4),h-unten+20,20,20);
      brush.color:=$00c0c080;
      for i:=1 to 4 do
        rectangle(i*b-4,h-unten-scheibenzahl*shoehe-10,i*b+5,h-unten+1);
      brush.style:=bsclear;
      for i:=1 to 4 do
        textout(i*b-7,h-unten+25,chr(64+i));
      for i:=1 to 4 do
      begin
        if stab[i,0]>0 then
        begin
          for j:=1 to stab[i,0] do
          begin
            wert:=stab[i,j];
            brush.color:=skalenfarbe(wert);
            nr:=80-bfaktor*wert;
            rectangle(i*b-nr,h-unten-j*shoehe,i*b+nr+1,h-unten-j*shoehe+shoehe-1);
          end;
        end;
      end;
      if gefunden then
      begin
        j:=stab[move1,0];
        nr:=80-bfaktor*stab[move1,j];
        brush.style:=bsclear;
        pen.color:=clblack;
        pen.width:=2;
        rectangle(move1*b-nr-1,h-unten-j*shoehe-1,move1*b+nr+3,h-unten-j*shoehe+shoehe);
        pen.color:=clblack;
        pen.width:=1;
      end;
    end;
end;
begin
    b:=pb1.width div 4;
    h:=pb1.height;

    shoehe:=18;
    sho:=(h-unten-40)/scheibenzahl;
    if sho<shoehe then shoehe:=trunc(sho);

    if r2.checked then vierscheiben
    else
    begin
      with bitmap.canvas do
      begin
        font.name:='Verdana';
        font.size:=16;
        brush.color:=clwhite;
        pen.color:=clwhite;
        rectangle(-1,-1,pb1.width+1,pb1.height-unten+51);
        pen.color:=clblack;
        brush.color:=$0080c0c0;
        roundrect(b div 3,h-unten,pb1.width-(b div 3),h-unten+20,20,20);
        brush.color:=$00c0c080;
        for i:=1 to 3 do
          rectangle(i*b-4,h-unten-scheibenzahl*shoehe-10,i*b+5,h-unten+1);
        brush.style:=bsclear;
        for i:=1 to 3 do
          textout(i*b-7,h-unten+25,chr(64+i));
        for i:=1 to 3 do
        begin
          if stab[i,0]>0 then
          begin
            for j:=1 to stab[i,0] do
            begin
              brush.color:=skalenfarbe(stab[i,j]);
              nr:=100-bfaktor*stab[i,j];
              rectangle(i*b-nr,h-unten-j*shoehe,i*b+nr+1,h-unten-j*shoehe+shoehe-1);
            end;
          end;
        end;
        if gefunden then
        begin
          j:=stab[move1,0];
          nr:=100-bfaktor*stab[move1,j];
          brush.style:=bsclear;
          pen.color:=clblack;
          pen.width:=2;
          rectangle(move1*b-nr-1,h-unten-j*shoehe-1,move1*b+nr+3,h-unten-j*shoehe+shoehe);
          pen.color:=clblack;
          pen.width:=1;
        end;
      end;
    end;
    pb1.Canvas.draw(0,0,bitmap);
end;

procedure Tfhano.PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,i,a1,a2,xx,st1,st2:integer;
begin
   if r2.checked then
   begin

     b:=pb1.width div 5;
     if gefunden then
     begin
       for i:=1 to 4 do
       begin
         if (x>i*b-80) and (x<i*b+80) then move2:=i;
       end;
       st1:=stab[move1,stab[move1,0]];
       st2:=stab[move2,stab[move2,0]];
       if ((st1>st2) and (move1<>move2)) or (stab[move2,0]=0)  then
       begin
         a2:=stab[move2,0];
         a1:=stab[move1,0];
         xx:=stab[move1,a1];
         stab[move2,a2+1]:=xx;
         stab[move1,a1]:=0;
         dec(stab[move1,0]);
         inc(stab[move2,0]);
         lb2.items.add(inttostr(zuege+1)+#9+chr(64+move1)+' nach '+chr(64+move2));
       end
       else
         lb2.items.add('Fehler: '+chr(64+move1)+' nach '+chr(64+move2));
       inc(zuege);
       p2l5.caption:=inttostr(zuege);
       l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
       gefunden:=false;
     end
     else
     begin
       for i:=1 to 4 do
       begin
         if (x>i*b-80) and (x<i*b+80) then move1:=i;
       end;
       gefunden:=false;
       if stab[move1,0]>0 then gefunden:=true;
     end;

   end
   else
   begin //3
     b:=pb1.width div 4;
     if gefunden then
     begin
       for i:=1 to 3 do
       begin
         if (x>i*b-100) and (x<i*b+100) then move2:=i;
       end;
       if (stab[move1,stab[move1,0]]>stab[move2,stab[move2,0]])
          or (stab[move2,0]=0)
       then begin
         a2:=stab[move2,0];
         a1:=stab[move1,0];
         xx:=stab[move1,a1];
         stab[move2,a2+1]:=xx;
         stab[move1,a1]:=0;
         dec(stab[move1,0]);
         inc(stab[move2,0]);
         lb2.items.add(inttostr(zuege+1)+#9+chr(64+move1)+' nach '+chr(64+move2));
       end
       else
         lb2.items.add('Fehler: '+chr(64+move1)+' nach '+chr(64+move2));
         inc(zuege);
         p2l5.caption:=inttostr(zuege);
         l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
         gefunden:=false;
       end
       else
       begin
         for i:=1 to 3 do
         begin
           if (x>i*b-100) and (x<i*b+100) then move1:=i;
         end;
         gefunden:=false;
         if stab[move1,0]>0 then gefunden:=true;
       end;
     end;
     pb1paint(sender);
end;

procedure Tfhano.FormActivate(Sender: TObject);
begin
   bitmap:=tbitmap.create;
   bitmap.width:=pb1.width;
   bitmap.height:=pb1.height;
   bitmap2:=tbitmap.create;
   bitmap2.width:=202;
   bitmap2.height:=19;
   bitmap2.canvas.brush.color:=$00c0c080;
   bitmap2.canvas.rectangle(96,-1,105,21);
   bitmap3:=tbitmap.create;
   bitmap3.width:=162;
   bitmap3.height:=19;
   bitmap3.canvas.brush.color:=$00c0c080;
   bitmap3.canvas.rectangle(76,-1,85,21);
   d1click(sender);
end;

procedure Tfhano.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if sabbruch=false then begin sabbruch:=true; exit end;
   bitmap.free;
   bitmap2.free;
   bitmap3.free;
end;

procedure Tfhano.D2Click(Sender: TObject);
var b,h,nr,scheiben,verz:integer;
    zeit,zeit2:integer;
    ani,bele:boolean;
procedure anibit(tobar,xx,ort,vv:integer);
var b,h,i,j,nr:integer;
begin
    b:=pb1.width div 4;
    h:=pb1.height;
    with bitmap.canvas do
    begin
      brush.color:=clwhite;
      rectangle(-1,-1,pb1.width+1,pb1.height+1);
      brush.color:=$0080c0c0;
      roundrect(b div 3,h-unten,pb1.width-(b div 3),h-unten+20,20,20);
      brush.color:=$00c0c080;
      for i:=1 to 3 do rectangle(i*b-4,h-unten-scheibenzahl*shoehe-10,i*b+5,h-unten+1);
      brush.style:=bsclear;
      for i:=1 to 3 do textout(i*b-7,h-unten+25,chr(64+i));

      for i:=1 to 3 do
      begin
        if stab[i,0]>0 then
        begin
          for j:=1 to stab[i,0] do
          begin
            brush.color:=skalenfarbe(stab[i,j]);
            nr:=100-bfaktor*stab[i,j];
            if (i=tobar) and (j=xx) then
              rectangle(ort-nr,h-unten-vv,ort+nr+1,h-unten-vv+shoehe-1)
            else
              rectangle(i*b-nr,h-unten-j*shoehe,i*b+nr+1,h-unten-j*shoehe+shoehe-1);
          end;
        end;
      end;
      if gefunden then
      begin
        j:=stab[move1,0];
        nr:=100-bfaktor*stab[move1,j];
        brush.style:=bsclear;
        pen.color:=clblack;
        pen.width:=2;
        rectangle(move1*b-nr-1,h-unten-j*shoehe-1,move1*b+nr+3,h-unten-j*shoehe+shoehe);
        pen.color:=clblack;
        pen.width:=1;
      end;
    end;
    pb1.Canvas.draw(0,0,bitmap);
end;
procedure MoveTower(FromBar, ToBar, TempBar, nDisc : Integer);
procedure pai;
var hi,a2,a1,xx,w,www:integer;
    rect:trect;
begin
    if sabbruch then exit;
    www:=2*shoehe+2;
    inc(zuege);
    a2:=stab[tobar,0];
    a1:=stab[frombar,0];
    xx:=stab[frombar,a1];
    stab[tobar,a2+1]:=xx;
    dec(stab[frombar,0]);
    inc(stab[tobar,0]);

      if ani then
      begin
        for w:=a1*shoehe to scheibenzahl*shoehe+www do anibit(tobar,a2+1,frombar*b,w);
        if frombar<tobar then
          for w:=frombar*b to tobar*b do anibit(tobar,a2+1,w,scheibenzahl*shoehe+www)
        else
          for w:=frombar*b downto tobar*b do anibit(tobar,a2+1,w,scheibenzahl*shoehe+www);
        for w:=scheibenzahl*shoehe+www downto (a2+1)*shoehe do anibit(tobar,a2+1,tobar*b,w);
        p2l5.caption:=inttostr(zuege);
        zeit2:=gettickcount;
        l4.caption:=floattostr((zeit2-zeit)/1000)+' s';
        l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
        application.processmessages;
      end
      else
      begin
       if verz>=0 then begin
        rect.left:=frombar*b-100;
        rect.top:=h-a1*shoehe-1;
        rect.right:=rect.left+202;
        rect.bottom:=rect.top+shoehe+1;
        pb1.canvas.stretchdraw(rect,bitmap2);
        pb1.canvas.brush.color:=skalenfarbe(xx);
        nr:=100-bfaktor*xx;
        hi:=h-(a2+1)*shoehe;
        pb1.canvas.rectangle(tobar*b-nr,hi,tobar*b+nr+1,hi+shoehe-1);
        if verz>0 then sleep(20*verz);
        if (verz>0) or (zuege mod 1000 = 0) then
        begin
          p2l5.caption:=inttostr(zuege);
          zeit2:=gettickcount;
          l4.caption:=floattostr((zeit2-zeit)/1000)+' s';
          l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
        end;
       end; 
      end;
end;
begin
   if not sabbruch then
   begin
     if (nDisc>1) then
     begin
       MoveTower(FromBar, TempBar, ToBar, nDisc-1);
       if bele and (not sabbruch) then lb2.items.add(inttostr(zuege+1)+#9+chr(64+frombar)+' nach '+chr(64+tobar));
       pai;
       MoveTower(TempBar, ToBar, FromBar, nDisc-1);
     end
     else
     begin
       if bele and (not sabbruch) then lb2.items.add(inttostr(zuege+1)+#9+chr(64+frombar)+' nach '+chr(64+tobar));
       pai;
     end;
     application.processmessages;
   end;
end;

begin
    if r2.checked then begin d2click4(sender); exit end;
    if sabbruch=false then
    begin
      sabbruch:=true;
      button2.caption:='Simulation';
    end
    else
    begin
      ani:=cb1.checked;
      verz:=updown2.position;
      b:=pb1.width div 4;
      h:=pb1.height-unten;
      D1Click(Sender);
      scheiben:=scheibenzahl;
      pb1paint(sender);
      lb2.clear;
      sabbruch:=false;
      button2.caption:='Abbruch';
      zeit:=gettickcount;
      bele:=c12.checked;
      zuege:=0;
      if (scheiben>18) and bele then
      begin
        bele:=false;
        lb2.items.add('zu viele Züge');
      end;
      movetower(1,3,2,scheiben);
      p2l5.caption:=inttostr(zuege);
      zeit2:=gettickcount;
      l4.caption:=floattostr((zeit2-zeit)/1000)+' s';
      l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
      pb1paint(sender);
      sabbruch:=true;
      button2.caption:='Simulation';
    end;
end;

procedure Tfhano.d2click4(Sender: TObject);
var b,h,nr,scheiben,verz:integer;
    zeit,zeit2:integer;
    ani,bele:boolean;
    kk:integer;
procedure anibit(tobar,xx,ort,vv:integer);
var b,h,i,j,nr:integer;
begin
    b:=pb1.width div 5;
    h:=pb1.height;
    with bitmap.canvas do
    begin
      brush.color:=clwhite;
      rectangle(-1,-1,pb1.width+1,pb1.height+1);
      brush.color:=$0080c0c0;
      roundrect(b div 4,h-unten,pb1.width-(b div 4),h-unten+20,20,20);
      brush.color:=$00c0c080;
      for i:=1 to 4 do rectangle(i*b-4,h-unten-scheibenzahl*shoehe-10,i*b+5,h-unten+1);
      brush.style:=bsclear;

      for i:=1 to 4 do textout(i*b-7,h-unten+25,chr(64+i));
      for i:=1 to 4 do
      begin
        if stab[i,0]>0 then
        begin
          for j:=1 to stab[i,0] do
          begin
            brush.color:=skalenfarbe(stab[i,j]);
            nr:=80-bfaktor*stab[i,j];
            if (i=tobar) and (j=xx) then
              rectangle(ort-nr,h-unten-vv,ort+nr+1,h-unten-vv+shoehe-1)
            else
              rectangle(i*b-nr,h-unten-j*shoehe,i*b+nr+1,h-unten-j*shoehe+shoehe-1);
          end;
        end;
      end;
      if gefunden then
      begin
        j:=stab[move1,0];
        nr:=80-bfaktor*stab[move1,j];
        brush.style:=bsclear;
        pen.color:=clblack;
        pen.width:=2;
        rectangle(move1*b-nr-1,h-unten-j*shoehe-1,move1*b+nr+3,h-unten-j*shoehe+shoehe);
        pen.color:=clblack;
        pen.width:=1;
      end;
    end;
    pb1.Canvas.draw(0,0,bitmap);
end;

procedure MoveTower(FromBar, ToBar, TempBar, nDisc : Integer);
procedure pai;
var hi,a2,a1,xx,w,www:integer;
    rect:trect;
begin
    if sabbruch then exit;
    www:=2*shoehe+2;
    inc(zuege);
    a2:=stab[tobar,0];
    a1:=stab[frombar,0];
    xx:=stab[frombar,a1];
    stab[tobar,a2+1]:=xx;
    dec(stab[frombar,0]);
    inc(stab[tobar,0]);
      if ani then
      begin
        for w:=a1*shoehe to scheibenzahl*shoehe+www do anibit(tobar,a2+1,frombar*b,w);
        if frombar<tobar then
          for w:=frombar*b to tobar*b do anibit(tobar,a2+1,w,scheibenzahl*shoehe+www)
        else
          for w:=frombar*b downto tobar*b do anibit(tobar,a2+1,w,scheibenzahl*shoehe+www);
        for w:=scheibenzahl*shoehe+www downto (a2+1)*shoehe do anibit(tobar,a2+1,tobar*b,w);
        p2l5.caption:=inttostr(zuege);
        zeit2:=gettickcount;
        l4.caption:=floattostr((zeit2-zeit)/1000)+' s';
        l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
        application.processmessages;
      end
      else
      begin

        rect.left:=frombar*b-80;
        rect.top:=h-a1*shoehe-1;
        rect.right:=rect.left+162;
        rect.bottom:=rect.top+shoehe+1;
        pb1.canvas.stretchdraw(rect,bitmap3);
        pb1.canvas.brush.color:=skalenfarbe(xx);
        nr:=80-bfaktor*xx;
        hi:=h-(a2+1)*shoehe;
        pb1.canvas.rectangle(tobar*b-nr,hi,tobar*b+nr+1,hi+shoehe-1);
        if verz>0 then sleep(20*verz);
        if (verz>0) or (zuege mod 1000 = 0) then
        begin
          p2l5.caption:=inttostr(zuege);
          zeit2:=gettickcount;
          l4.caption:=floattostr((zeit2-zeit)/1000)+' s';
          l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
        end;
      end;
end;
begin
   if not sabbruch then
   begin
     if (nDisc>1) then
     begin
       MoveTower(FromBar, TempBar, ToBar, nDisc-1);
       if bele and (sabbruch=false) then lb2.items.add(inttostr(zuege+1)+#9+chr(64+frombar)+' nach '+chr(64+tobar));
       pai;
       MoveTower(TempBar, ToBar, FromBar, nDisc-1);
     end
     else
     begin
       if bele and (sabbruch=false) then lb2.items.add(inttostr(zuege+1)+#9+chr(64+frombar)+' nach '+chr(64+tobar));
       pai;
     end;
     application.processmessages;
   end;
end;
procedure ablauf(a,z,h1,h2,disc:integer);
begin
   if not sabbruch then
   begin
     if disc>4 then
     begin
       ablauf(a,h1,z,h2,disc-2);
       movetower(a,h2,z,1);
       movetower(a,z,h2,1);
       movetower(h2,z,a,1);
       ablauf(h1,z,a,h2,disc-2);
     end
     else
     begin
       movetower(a,h1,h2,disc-2);
       movetower(a,h2,z,1);
       movetower(a,z,h2,1);
       movetower(h2,z,a,1);
       movetower(h1,z,h2,disc-2);
     end;
   end;
end;
procedure ablaufx(a,b,c,d,di:integer);
var kk:integer;
begin
    case di of
     3..5 : ablauf(a,b,c,d,di);
     else begin
        kk:=3;
        case di of
             6,7 : kk:=3;          8..10 : kk:=di-4;
          11..15 : kk:=di-5;       16..21 : kk:=di-6;
          22..31 : kk:=di-7;       32..37 : kk:=di-8;
        end;
        ablaufx(a,c,b,d, kk);
        movetower(a,b,d, di-kk);
        ablaufx(c,b,d,a, kk);
      end;
    end;
end;
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button2.caption:='Simulation';
    end
    else
    begin
      ani:=cb1.checked;
      verz:=updown2.position;
      b:=pb1.width div 5;
      h:=pb1.height-unten;
      D1Click(Sender);
      scheiben:=scheibenzahl;
      pb1paint(sender);
      lb2.clear;
      sabbruch:=false;
      button2.caption:='Abbruch';
      zeit:=gettickcount;
      bele:=c12.checked;
      zuege:=0;
      case scheiben of
        3..5 : ablauf(1,4,2,3,scheiben);
        else
        begin
          kk:=3;
          case scheiben of
             6,7 : kk:=3;                 8..10 : kk:=scheiben-4;
          11..15 : kk:=scheiben-5;       16..21 : kk:=scheiben-6;
          22..31 : kk:=scheiben-7;       32..37 : kk:=scheiben-8;
          end;
          ablaufx(1,2,3,4, kk);
          movetower(1,4,3, scheiben-kk);
          ablaufx(2,4,1,3, kk);
        end;
      end;
      p2l5.caption:=inttostr(zuege);
      zeit2:=gettickcount;
      l4.caption:=floattostr((zeit2-zeit)/1000)+' s';
      l9.caption:=floattostrf(100.0*zuege/gesamtzuege,ffgeneral,4,2);
      pb1paint(sender);
      sabbruch:=true;
      button2.caption:='Simulation';
    end;
end;

procedure Tfhano.R1Click(Sender: TObject);
begin
   if sabbruch=false then begin sabbruch:=true;  end;
   d1click(sender);
end;

procedure Tfhano.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
    d1click(sender);
end;

procedure Tfhano.lb2Click(Sender: TObject);
begin
    lb2.items.savetofile('xxx.xxx');
end;

end.
