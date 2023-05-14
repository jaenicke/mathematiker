unit usprunglab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  ExtCtrls, Buttons, StdCtrls;

type
  TFsprung = class(TForm)
    PM1: TPopupMenu;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Paintbox1: TPaintBox;
    Memo1: TMemo;
    Label3: TLabel;
    menu_u: TMenuItem;
    menu_r: TMenuItem;
    menu_d: TMenuItem;
    menu_l: TMenuItem;
    Label1: TLabel;
    menu_x: TMenuItem;
    Edit1: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Timer2: TTimer;
    Aufgabenliste: TListBox;
    procedure S2c(Sender: TObject);
    procedure d2c(Sender: TObject);
    procedure pb1P(Sender: TObject);
    procedure menu_uClick(Sender: TObject);
    procedure menu_rClick(Sender: TObject);
    procedure menu_dClick(Sender: TObject);
    procedure menu_lClick(Sender: TObject);
    procedure d3C(Sender: TObject);
    procedure T2Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    verlauf:string;
    sprungweiten:string;
    sprungweite:array[1..20] of integer;
    sprungzahl:integer;
    sprung:integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Fsprung: TFsprung;

implementation

uses Dialogs;

{$R *.DFM}
const aa:integer=64;
      jetzt:boolean = false;
      nr:integer=1;
var   sb,sh,sx,sy,zx,zy,sx2,sy2,schritt,sxold,syold,sxold2,syold2,zuege:integer;
      feldx,feldy:array[0..20,0..20] of integer;

procedure Pause(msZeit: DWord);
var Dauer: double;
    Anfang, Ende, Frequenz : TLargeInteger;
begin
  QueryPerformanceFrequency(Frequenz);
  QueryPerformanceCounter(Anfang);
  repeat
    Application.ProcessMessages;
    QueryPerformanceCounter(Ende);
    Dauer:=(Ende-Anfang)/Frequenz*1000.0;
  until Dauer>=msZeit;
end;

procedure TFsprung.S2c(Sender: TObject);
begin
  Close;
end;

procedure TFsprung.d2c(Sender: TObject);
var sel,po,i,j:integer;
    kk,k,k1:string;
begin
  //Sprung
  jetzt:=false;
  nr:=strtoint(edit1.text);
  if nr<0 then nr:=1;
  sel:=strtoint(aufgabenliste.items[0]);
  Label2.caption:=inttostr(sel)+' Spiele';
  if nr>sel then nr:=1;
  k:='['+inttostr(nr);
  po:=aufgabenliste.items.indexof(k)+1;
  k:=aufgabenliste.items[po];
  sb:=strtoint(copy(k,1,pos(',',k)-1));
  sh:=strtoint(copy(k,pos(',',k)+1,20));
  inc(po);
  k:=aufgabenliste.items[po];
  k1:=copy(k,1,pos(':',k)-1);
  k:=copy(k,pos(':',k)+1,25);
  sx:=strtoint(copy(k1,1,pos(',',k1)-1));
  sy:=strtoint(copy(k1,pos(',',k1)+1,20));
  sxold:=sx;
  syold:=sy;
  zx:=strtoint(copy(k,1,pos(',',k)-1));
  zy:=strtoint(copy(k,pos(',',k)+1,20));
  inc(po);
  sprungweiten:=aufgabenliste.items[po];
  i:=1;
  kk:=sprungweiten;
  sprungzahl:=0;
  while pos(',',kk)>0 do begin
    inc(sprungzahl);
    sprungweite[i]:=strtoint(kk[1]);
    inc(i);
    delete(kk,1,2);
  end;
  sprungweite[i]:=strtoint(kk);
  inc(sprungzahl);
  sprung:=1;

  inc(po);
  for i:=1 to sh do begin
    k:=aufgabenliste.items[po];
    for j:=0 to sb do feldx[j,i]:=0;
    for j:=1 to length(k) do feldx[ord(k[j])-48,i]:=1;
    inc(po);
  end;
  for i:=1 to sb do begin
    k:=aufgabenliste.items[po];
    for j:=0 to sh do feldy[i,j]:=0;
    for j:=1 to length(k) do feldy[i,ord(k[j])-48]:=1;
    inc(po);
  end;
  verlauf:=aufgabenliste.items[po];
  if verlauf[1]='[' then begin
    button2.visible:=false;
    verlauf:='';
  end
  else button2.visible:=true;
  zuege:=0;
  pb1p(sender);
end;

procedure TFsprung.pb1P(Sender: TObject);
var fb,i,j,b,h,xoffset,yoffset:integer;
    bild:tbitmap;
    ks:string;
begin
  edit1.text:=inttostr(nr);
  bild:=tbitmap.create;
  bild.width:=Paintbox1.width;
  bild.height:=Paintbox1.height;
  b:=Paintbox1.width;
  h:=Paintbox1.height;

  //Sprung
  fb:=(h-60) div (sh+2);
  if (b-60) div (sh+2)<fb then fb:=(b-60) div (sh+2);
  aa:=fb;
  xoffset:=(b-(sb*aa)) div 2;
  yoffset:=(h-(sh*aa)) div 2;
  with bild.canvas do begin
    font.name:='Verdana';
    font.size:=18;
    font.style:=[fsbold,fsitalic];
    brush.color:=clwhite;
    pen.color:=clltgray;
    pen.width:=1;
    for i:=0 to sb-1 do
      for j:=0 to sh-1 do begin
        rectangle(xoffset+i*aa,yoffset+j*aa,
                xoffset+i*aa+aa+1,yoffset+j*aa+aa+1);
      end;
    pen.color:=clblack;
    pen.width:=4;
    for i:=1 to sb do
      for j:=1 to sh do begin
        if feldx[i,j]>0 then begin
          moveto(xoffset+i*aa,yoffset+j*aa-aa);
          lineto(xoffset+i*aa,yoffset+j*aa);
        end;
      end;
    brush.style:=bsclear;
    rectangle(xoffset,yoffset,xoffset+aa*sb+2,yoffset+aa*sh+2);
    for i:=1 to sh do
      for j:=1 to sb do begin
        if feldy[j,i]>0 then begin
          moveto(xoffset+j*aa-aa,yoffset+i*aa);
          lineto(xoffset+j*aa,yoffset+i*aa);
        end;
      end;
    pen.width:=2;
    pen.color:=clred;
    brush.color:=clyellow;
    ellipse(xoffset+zx*aa+6-aa,yoffset+zy*aa+6-aa,
               xoffset+zx*aa-5,yoffset+zy*aa-5);
    pen.width:=1;
    brush.color:=clred;
    ellipse(xoffset+sx*aa+10-aa,yoffset+sy*aa+10-aa,
               xoffset+sx*aa-9,yoffset+sy*aa-9);
    brush.style:=bsclear;
    ks:='Sprung '+inttostr(sprungweite[sprung]);
    textout(xoffset+(aa*sb) div 2+1-textwidth(ks) div 2,yoffset+aa*sh+10,ks);
    ks:='Sprungfolge '+sprungweiten;
    textout(xoffset+(aa*sb) div 2+1-textwidth(ks) div 2,yoffset-38,ks);
  end;
  Paintbox1.Canvas.draw(0,0,bild);
  bild.free;
  Label3.caption:='Züge '+inttostr(zuege);
  if (sx=zx) and (sy=zy) and jetzt then begin
    timer2.enabled:=false;
    button2.caption:='Demonstration';
    showmessage('Gratulation! Du hast die Aufgabe gelöst');
    inc(nr);
    edit1.text:=inttostr(nr);
    jetzt:=false;
    end;
end;

procedure TFsprung.menu_uClick(Sender: TObject);
var a,b,n,i,j:integer;
    moeglich:boolean;
begin //hoch
//Spriung
  jetzt:=false;
  i:=sx;
  j:=sy;
  a:=sprungweite[sprung];
  moeglich:=true;
  for n:=1 to a do moeglich:=moeglich and ((feldy[i,j-1-n+1]=0) and (j-n+1>1));
  if moeglich then begin
    inc(sprung);
    if sprung>sprungzahl then sprung:=1;
    inc(zuege);
    b:=0;
    while (b<a) and (feldy[i,j-1]=0) and (j>1) do begin
      dec(j);
      inc(b);
      sy:=j;
      if b=a then jetzt:=true;
      pb1P(Sender);
      pause(15);
    end;
  end;
end;

procedure TFsprung.menu_rClick(Sender: TObject);
var a,b,n,i,j:integer;
    moeglich:boolean;
begin //rechts
  //Sprung
  jetzt:=false;
  i:=sx; j:=sy;
  a:=sprungweite[sprung];
  moeglich:=true;
  for n:=1 to a do moeglich:=moeglich and ((feldx[i+n-1,j]=0) and (i+n-1<sb));
  if moeglich then begin
    inc(sprung);
    if sprung>sprungzahl then sprung:=1;
    inc(zuege);
    b:=0;
    while (b<a) and (feldx[i,j]=0) and (i<sb) do begin
      inc(i);
      inc(b);
      sx:=i;
      if b=a then jetzt:=true;
      pb1P(Sender);
      pause(15);
    end;
  end;
end;

procedure TFsprung.menu_dClick(Sender: TObject);
var a,b,n,i,j:integer;
    moeglich:boolean;
begin //runter
//Sprung
  jetzt:=false;
  i:=sx; j:=sy;
  a:=sprungweite[sprung];
  moeglich:=true;
  for n:=1 to a do moeglich:=moeglich and ((feldy[i,j+n-1]=0) and (j+n-1<sh));
  if moeglich then begin
    inc(sprung);
    if sprung>sprungzahl then sprung:=1;
    inc(zuege);
    b:=0;
    while (b<a) and (feldy[i,j]=0) and (j<sh) do begin
      inc(j);
      inc(b);
      sy:=j;
      if b=a then jetzt:=true;
      pb1P(Sender);
      pause(15);
    end;
  end;
end;

procedure TFsprung.menu_lClick(Sender: TObject);
var a,b,n,i,j:integer;
    moeglich:boolean;
begin //links
//Sprung
  jetzt:=false;
  i:=sx; j:=sy;
  a:=sprungweite[sprung];
  moeglich:=true;
  for n:=1 to a do moeglich:=moeglich and ((feldx[i-1-n+1,j]=0) and (i-n+1>1));
  if moeglich then begin
    inc(sprung);
    if sprung>sprungzahl then sprung:=1;
    inc(zuege);
    b:=0;
    while (b<a) and (feldx[i-1,j]=0) and (i>1) do begin
      dec(i);
      inc(b);
      sx:=i;
      if b=a then jetzt:=true;
      pb1P(Sender);
      pause(15);
    end;
  end;
end;

procedure TFsprung.d3C(Sender: TObject);
begin
  if verlauf<>'' then begin
    schritt:=1;
    timer2.enabled:= not timer2.enabled;
    if timer2.enabled then begin
      sx:=sxold;
      zuege:=0;
      sy:=syold;
      sx2:=sxold2;
      sy2:=syold2;
      pb1P(Sender);
      pause(10);
      button2.caption:='Abbruch';
    end else begin
      button2.caption:='Demonstration';
    end;
  end;
end;

procedure TFsprung.T2Timer(Sender: TObject);
var cc:char;
begin
  cc:=verlauf[schritt];
  case cc of
    'r' : menu_rClick(Sender);
    'l' : menu_lClick(Sender);
    'd' : menu_dClick(Sender);
    'u' : menu_uClick(Sender);
   end;
  inc(schritt);
end;

procedure TFsprung.FormShow(Sender: TObject);
begin
  randomize;
  d2c(Sender);
end;

end.
