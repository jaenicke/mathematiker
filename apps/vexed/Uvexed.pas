unit Uvexed;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ComCtrls, StdCtrls, ExtCtrls;

type
  Tvexed = class(TForm)
    P2: TPanel;
    L1: TLabel;
    L2: TLabel;
    Label1: TLabel;
    Me1: TMemo;
    e_stufe: TEdit;
    pb1: TPaintBox;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    e_spieler: TEdit;
    b_zurueck: TButton;
    b_stufe: TButton;
    b_loesung: TButton;
    b_liste: TButton;
    Image2: TImage;
    Image1: TImage;
    ListBox1: TListBox;
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D1Click(Sender: TObject);
    procedure pb1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pb1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure nachrutschen(sender : tobject);
    procedure automatic(Sender: TObject; p,q: Integer);
    procedure D3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure e_spielerChange(Sender: TObject);
    procedure D4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  vexed: Tvexed;

implementation

uses bestliste;

{$R *.DFM}
const verschieben:boolean=false;
var  feld : array[0..11,0..9] of char;
     loeschen : array[0..11,0..9] of byte;
     schrittnummer,maxspiel,m,n,spielstufe : integer;
     loesung:string;
     lebenszahl:real;

procedure zeitschleife;
var i:integer;
    x:real;
begin
    x:=1;
    for i:=1 to 20000 do x:=sin(x)
end;

procedure Tvexed.SpeedButton3Click(Sender: TObject);
begin
    if (spunkte>0) then
    begin
      Application.CreateForm(Tbestenliste, bestenliste);
      bestenliste.showmodal;
      bestenliste.release;
    end;
    close;
end;

procedure Tvexed.FormCreate(Sender: TObject);
begin
   spielname:='Vexed-Puzzle';
   spunkte:=0;
   helpcontext:=591;
end;

procedure Tvexed.Pb1Paint(Sender: TObject);
const    superfarben: array[0..28] of longint =
         ($00000000,$00ff0000,$000000FF,$00FF00FF,$0000FFFF,
          $00008000,$0000FF00,$00800080,$00ffa000,$00404040,
          $00cccccc,$00808080,$00ff4000,$00000080,$00008080,$00c0c0c0,
          $00808000,$000000c0,$0000c000,$00c00000,$0000c0c0,$00c000c0,$00c0c000,$00FFFFCC,
          $00CCFFFF,$00CCFFCC,$00CCCCFF,$00ffffff,$00cccc99);
var bitmap:tbitmap;
    b,h,xoffset,yoffset,i,j:integer;
    ks:char;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height;
    b:=bitmap.width;
    h:=bitmap.height;
    xoffset:=(b-640) div 2;
    yoffset:=(h-8*64) div 2;

    with bitmap.canvas do
    begin
      font.name:='Verdana';
      font.size:=30;
      font.style:=[fsbold];
      for j:=1 to 8 do
        for i:=1 to 10 do
        begin
          case feld[i,j] of
           ' ' : brush.color:=clwhite;
           'x' : begin
                   bitmap.canvas.draw(xoffset+(i-1)*64+1,yoffset+(j-1)*64+1,image1.picture.bitmap);
                   brush.style:=bsclear
                 end;
      'a'..'m' : begin
                   brush.color:=superfarben[ord(feld[i,j])-96];
                 end;
          end;
          rectangle(xoffset+(i-1)*64,yoffset+(j-1)*64,xoffset+i*64+1,yoffset+j*64+1);
          if feld[i,j] in ['a'..'m'] then
          begin
            ks:=chr(ord(feld[i,j])-32);
            font.color:=clwhite;
            textout(xoffset+(i-1)*64+32-textwidth(ks) div 2,yoffset+(j-1)*64+8,ks);
          end;
        end;
    end;
    for i:=1 to round(lebenszahl+0.4) do
      bitmap.canvas.Draw(xoffset+644,yoffset+8*64+4-i*30,image2.picture.bitmap);

    pb1.Canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tvexed.D2Click(Sender: TObject);
var sel,po,i,j:integer;
    k:string;
begin
    fillchar(feld,sizeof(feld),' ');
    spielstufe:=strtoint(e_stufe.text);
    if spielstufe<0 then spielstufe:=1;

    sel:=strtoint(listbox1.items[0]);
    maxspiel:=sel;
    label1.caption:=inttostr(sel)+' Spiele';
    if spielstufe>sel then spielstufe:=1;
    k:='['+inttostr(spielstufe);
    l1.caption:='Spielstufe '+inttostr(spielstufe);

    po:=listbox1.items.indexof(k);
    for i:=1 to 8 do
    begin
      k:=listbox1.items[po+i];
      for j:=1 to 10 do feld[j,i]:=k[j];
    end;
    loesung:=listbox1.items[po+9];
    b_loesung.visible:=length(loesung)>0;
    if length(loesung)>0 then label2.caption:='Schrittzahl '+inttostr(length(loesung) div 3)
                         else label2.caption:='Schrittzahl ?';
    pb1paint(sender);
end;

procedure Tvexed.FormActivate(Sender: TObject);
begin
    lebenszahl:=8;
    fillchar(feld,sizeof(feld),#0);
    D2Click(Sender);
end;

procedure Tvexed.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h,xoffset,yoffset:integer;
begin
    b:=pb1.width;
    h:=pb1.height;
    xoffset:=(b-640) div 2;
    yoffset:=(h-8*64) div 2;
    m:=(x-xoffset) div 64 + 1;
    n:=(y-yoffset) div 64 + 1;
    if (m>0) and (m<11) and (n>0) and (n<9) then
      if feld[m,n] in ['a'..'m'] then verschieben:=true;
end;

procedure Tvexed.D1Click(Sender: TObject);
var po,i,j:integer;
    k:string;
begin
    lebenszahl:=lebenszahl-0.5;
    if lebenszahl<0 then lebenszahl:=0;
    if lebenszahl=0 then
    begin
      if spunkte<0 then spunkte:=0;//spunkte+1;
      if (spunkte>0) then
      begin
        Application.CreateForm(Tbestenliste, bestenliste);
        bestenliste.showmodal;
        bestenliste.release;
      end;
      spunkte:=0;
      lebenszahl:=8;
      spielstufe:=1;
      e_stufe.text:=inttostr(spielstufe);
      l1.caption:='Spielstufe '+inttostr(spielstufe);
    end;
    fillchar(feld,sizeof(feld),' ');
    k:='['+inttostr(spielstufe);
    po:=listbox1.items.indexof(k);
    for i:=1 to 8 do
    begin
      k:=listbox1.items[po+i];
      for j:=1 to 10 do feld[j,i]:=k[j];
    end;
    l1.caption:='Spielstufe '+inttostr(spielstufe);
    loesung:=listbox1.items[po+9];
    b_loesung.visible:=length(loesung)>0;
    if length(loesung)>0 then label2.caption:='Schrittzahl '+inttostr(length(loesung) div 3)
                         else label2.caption:='Schrittzahl ?';
    pb1paint(sender);
end;

procedure Tvexed.pb1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var p,q,b,h,xoffset,yoffset,j:integer;
    leer:boolean;
begin
   if verschieben then
   begin
     b:=pb1.width;
     h:=pb1.height;
     xoffset:=(b-640) div 2;
     yoffset:=(h-8*64) div 2;
     p:=(x-xoffset) div 64 + 1;
     q:=(y-yoffset) div 64 + 1;
     if (p>0) and (p<11) and (q>0) and (q<9) and (p<>m) then
     begin
       if (feld[p,q]=' ') and (feld[p,q+1]=' ') then
       begin
         pb1MouseUp(Sender,mbleft,Shift,x,y);
         exit
       end;
       leer:=true;
       if p>m then
       begin
         for j:=m+1 to p do if feld[j,n]<>' ' then leer:=false;
         if leer then
         begin
           feld[p,n]:=feld[m,n]; feld[m,n]:=' ';
           m:=p;
           pb1paint(sender);
           nachrutschen(sender);
           exit;
         end;
       end
       else
       begin
         for j:=m-1 downto p do
           if feld[j,n]<>' ' then leer:=false;
         if leer then
         begin
           feld[p,n]:=feld[m,n];
           feld[m,n]:=' ';
           m:=p;
           pb1paint(sender);
           nachrutschen(sender);
           exit;
         end;
       end;

     end;
   end;
end;

procedure Tvexed.pb1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p,q,b,h,kk,xoffset,yoffset,i,j,ii,eins:integer;
    leer:boolean;
    zeichen:char;
begin
   if verschieben then
   begin
     b:=pb1.width;
     h:=pb1.height;
     xoffset:=(b-640) div 2;
     yoffset:=(h-8*64) div 2;
     p:=(x-xoffset) div 64 + 1;
     q:=(y-yoffset) div 64 + 1;
     if (p>0) and (p<11) and (q>0) and (q<9) and (p<>m) then
     begin
       leer:=true;
       if p>m then
       begin
         for j:=m+1 to p do
           if feld[j,n]<>' ' then leer:=false;
         if leer then
         begin
           feld[p,n]:=feld[m,n];
           feld[m,n]:=' ';
           m:=p;
           pb1paint(sender);
         end;
       end
       else
       begin
         for j:=m-1 downto p do
           if feld[j,n]<>' ' then leer:=false;
         if leer then
         begin
           feld[p,n]:=feld[m,n];
           feld[m,n]:=' ';
           m:=p;
           pb1paint(sender);
         end;
       end;
     end;
     verschieben:=false;
     q:=n+1;
     while (q<9) and (feld[m,q]=' ') do
     begin
       feld[m,q]:=feld[m,n];
       feld[m,n]:=' ';
       n:=q;
       q:=n+1;
       sleep(50);
       pb1paint(sender);
     end;

     fillchar(loeschen,sizeof(loeschen),0);
     loeschen[m,n]:=1; zeichen:=feld[m,n];
     for ii:=1 to 10 do
     begin
       for i:=1 to 9 do
       begin
         if (loeschen[i,n]=1) and (feld[i+1,n]=zeichen) then loeschen[i+1,n]:=1;
         if (loeschen[i+1,n]=1) and (feld[i,n]=zeichen) then loeschen[i,n]:=1;
       end;
       for j:=1 to 7 do
       begin
         if (loeschen[m,j]=1) and (feld[m,j+1]=zeichen) then loeschen[m,j+1]:=1;
         if (loeschen[m,j+1]=1) and (feld[m,j]=zeichen) then loeschen[m,j]:=1;
       end;
     end;

     eins:=0;
     for i:=1 to 10 do
       for j:=1 to 8 do
         if loeschen[i,j]=1 then inc(eins);
     if eins>1 then
     begin
       for i:=1 to 10 do
         for j:=1 to 8 do
         begin
           if loeschen[i,j]=1 then
           begin
             feld[i,j]:=' ';
             for kk:=1 to 32 do
             begin
               pb1.canvas.rectangle(
               xoffset+(i-1)*64+32-kk,yoffset+(j-1)*64+32-kk,
               xoffset+(i-1)*64+32+kk+1,yoffset+(j-1)*64+32+kk+1);
               zeitschleife;//sleep(1);
             end;
           end;
         end;
       pb1paint(sender);
     end;
     m:=0;
     n:=0;
     nachrutschen(sender);

     eins:=0;
     for i:=1 to 10 do
       for j:=1 to 8 do
         if feld[i,j] in ['a'..'m'] then inc(eins);
     if eins=0 then
     begin
       timer1.enabled:=false;
       application.processmessages;
       showmessage('Gratulation! Spielstufe '+inttostr(spielstufe)+' ist gelöst!');
       spunkte:=spunkte+length(loesung)+spielstufe;
       if spielstufe mod 10 = 0 then lebenszahl:=lebenszahl+1;
       inc(spielstufe);
       if spielstufe>maxspiel then spielstufe:=1;
       e_stufe.text:=inttostr(spielstufe);
       l1.caption:='Spielstufe '+inttostr(spielstufe);
       d2click(sender);
     end;
   end;
end;

procedure Tvexed.nachrutschen(Sender: TObject);
var b,h,xoffset,yoffset,kk,eins,jj,ii,i,i2,j2,j,p,q:integer;
    zeichen:char;
begin
    b:=pb1.width;
    h:=pb1.height;
    xoffset:=(b-640) div 2;
    yoffset:=(h-8*64) div 2;
    for jj:=1 to 8 do
    begin
      for i:=1 to 10 do
      begin
        for j:=1 to 7 do
        begin
          if (i<>m) and (j<>n) then
          begin
            if (feld[i,j] in ['a'..'m']) and (feld[i,j+1]=' ') then
            begin
              q:=j+1;
              while (q<9) and (feld[i,q]=' ') do
              begin
                feld[i,j+1]:=feld[i,j];
                feld[i,j]:=' ';
                q:=j+1;
                sleep(50);
                pb1paint(sender);
              end;
              p:=i;
              fillchar(loeschen,sizeof(loeschen),0);
              loeschen[i,q]:=1;
              zeichen:=feld[i,q];
              for ii:=1 to 10 do
              begin
                for i2:=1 to 9 do
                begin
                  if (loeschen[i2,q]=1) and (feld[i2+1,q]=zeichen)
                    and ((m<>i2+1) or (n<>q)) then loeschen[i2+1,q]:=1;
                  if (loeschen[i2+1,q]=1) and (feld[i2,q]=zeichen)
                    and ((m<>i2) or (n<>q)) then loeschen[i2,q]:=1;
                end;
                for j2:=1 to 7 do
                begin
                  if (loeschen[p,j2]=1) and (feld[p,j2+1]=zeichen)
                    and ((m<>p) or (n<>j2+1)) then loeschen[p,j2+1]:=1;
                  if (loeschen[p,j2+1]=1) and (feld[p,j2]=zeichen)
                    and ((m<>p) or (n<>j2)) then loeschen[p,j2]:=1;
                end;
              end;
              eins:=0;

              for i2:=1 to 10 do
                for j2:=1 to 8 do
                  if loeschen[i2,j2]=1 then inc(eins);

              if eins>1 then
              begin
                for i2:=1 to 10 do
                  for j2:=1 to 8 do
                    if loeschen[i2,j2]=1 then
                    begin
                      feld[i2,j2]:=' ';
                      for kk:=1 to 32 do
                      begin
                        pb1.canvas.rectangle(
                          xoffset+(i2-1)*64+32-kk,yoffset+(j2-1)*64+32-kk,
                          xoffset+(i2-1)*64+32+kk+1,yoffset+(j2-1)*64+32+kk+1);
                        zeitschleife;//sleep(1);
                      end;
                    end;
                pb1paint(sender);
              end;
            end;
          end;
        end
      end;
    end
end;

procedure Tvexed.automatic(Sender: TObject; p,q: Integer);
var b,h,kk,xoffset,yoffset,i,j,k,eins:integer;
    leer:boolean;
    zeichen:char;
begin
    b:=pb1.width;
    h:=pb1.height;
    xoffset:=(b-640) div 2;
    yoffset:=(h-8*64) div 2;
    if (p>0) and (p<11) and (q>0) and (q<9) and (p<>m) then
    begin
      leer:=true;
      if p>m then
      begin
        for j:=m+1 to p do
          if feld[p,n]<>' ' then leer:=false;
        if leer then
        begin
          feld[p,n]:=feld[m,n];
          feld[m,n]:=' ';
          m:=p;
          pb1paint(sender);
          sleep(50);
        end;
      end
      else
      begin
        for j:=m-1 downto p do
          if feld[p,n]<>' ' then leer:=false;
        if leer then
        begin
          feld[p,n]:=feld[m,n];
          feld[m,n]:=' ';
          m:=p;
          pb1paint(sender);
          sleep(50);
        end;
      end;
    end;
    verschieben:=false;
    q:=n+1;
    while (q<9) and (feld[m,q]=' ') do
    begin
      feld[m,q]:=feld[m,n];
      feld[m,n]:=' ';
      n:=q;
      q:=n+1;
      sleep(50);
      pb1paint(sender);
    end;

    fillchar(loeschen,sizeof(loeschen),0);
    loeschen[m,n]:=1; zeichen:=feld[m,n];
    for k:=1 to 10 do
    begin
      for i:=1 to 9 do
      begin
        if (loeschen[i,n]=1) and (feld[i+1,n]=zeichen) then loeschen[i+1,n]:=1;
        if (loeschen[i+1,n]=1) and (feld[i,n]=zeichen) then loeschen[i,n]:=1;
      end;
      for j:=1 to 7 do
      begin
        if (loeschen[m,j]=1) and (feld[m,j+1]=zeichen) then loeschen[m,j+1]:=1;
        if (loeschen[m,j+1]=1) and (feld[m,j]=zeichen) then loeschen[m,j]:=1;
      end;
    end;

    eins:=0;
    for i:=1 to 10 do
      for j:=1 to 8 do
        if loeschen[i,j]=1 then inc(eins);
    if eins>1 then
    begin
      for i:=1 to 10 do
        for j:=1 to 8 do
        begin
          if loeschen[i,j]=1 then
          begin
            feld[i,j]:=' ';
            for kk:=1 to 32 do
            begin
              pb1.canvas.rectangle(
              xoffset+(i-1)*64+32-kk,yoffset+(j-1)*64+32-kk,
              xoffset+(i-1)*64+32+kk+1,yoffset+(j-1)*64+32+kk+1);
              zeitschleife;
            end;
          end;
        end;
      pb1paint(sender);
    end;
    m:=0;
    n:=0;
    nachrutschen(sender);

    eins:=0;
    for i:=1 to 10 do
      for j:=1 to 8 do
        if feld[i,j] in ['a'..'m'] then inc(eins);
    if eins=0 then
    begin
      timer1.enabled:=false;
      application.processmessages;
      b_loesung.caption:='Demonstration';
      showmessage('Das Puzzle ist gelöst!');
      d2click(sender);
    end;
end;

procedure Tvexed.D3Click(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then
    begin
      lebenszahl:=lebenszahl-0.8;
      d1click(sender);
      schrittnummer:=0;
      b_loesung.caption:='Stopp';
      e_stufe.setfocus;
    end
    else b_loesung.caption:='Lösung zeigen';
end;

procedure Tvexed.Timer1Timer(Sender: TObject);
var p,q:integer;
begin
    if loesung[3*schrittnummer+1]='A' then m:=10
                            else m:=strtoint(loesung[3*schrittnummer+1]);
    n:=strtoint(loesung[3*schrittnummer+2]);
    q:=n;
    if loesung[3*schrittnummer+3]='l' then p:=m-1 else p:=m+1;
    inc(schrittnummer);
    automatic(sender,p,q);
end;

procedure Tvexed.e_spielerChange(Sender: TObject);
begin
    xname:=e_spieler.text;
end;

procedure Tvexed.D4Click(Sender: TObject);
begin
   Application.CreateForm(Tbestenliste, bestenliste);
   bestenliste.showmodal;
   bestenliste.release;
end;

end.
