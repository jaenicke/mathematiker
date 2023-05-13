unit uhamilton;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, messages,
  ExtCtrls, Menus, Dialogs, StdCtrls, Grids, Buttons, Mask;

type
  Tfeuler = class(TForm)
    Panel2: TPanel;
    Panel4: TPanel;
    eulergraph: TPanel;
    Panel12: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    B_Knoten: TButton;
    B_Loeschen: TButton;
    Label6: TLabel;
    B_Kante: TButton;
    B_KanteLoeschen: TButton;
    Label7: TLabel;
    B_Aendern: TButton;
    LKnoten: TListBox;
    EditX: TEdit;
    EditY: TEdit;
    LKanten: TListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    C_Punkte: TCheckBox;
    Panel10: TPanel;
    kp2: TPaintBox;
    Panel9: TPanel;
    kp1: TPaintBox;
    OD3: TOpenDialog;
    SD2: TSaveDialog;
    Panel5: TPanel;
    Panel6: TPanel;
    Liste_E: TListBox;
    Panel8: TPanel;
    Panel11: TPanel;
    B_Suchen: TButton;
    B_Anzeige: TButton;
    Label1: TLabel;
    CB_Pfad: TCheckBox;
    MM1: TMainMenu;
    R1: TRadioGroup;
    lh1: TListBox;
    Panel1: TPanel;
    S2: TSpeedButton;
    S1: TSpeedButton;
    S4: TSpeedButton;
    S3: TSpeedButton;
    S6: TSpeedButton;
    S5: TSpeedButton;
    Label2: TLabel;
    Liste: TComboBox;
    procedure S4C(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SLoeschen(Sender: TObject);
    procedure SLaden(Sender: TObject);
    procedure SSpeichern(Sender: TObject);
    procedure LB7C(Sender: TObject);
    procedure B_KnotenC(Sender: TObject);
    procedure B_LoeschenC(Sender: TObject);
    procedure B_AendernC(Sender: TObject);
    procedure B_KanteC(Sender: TObject);
    procedure B_KanteLoeschenC(Sender: TObject);
    procedure SGroesse(Sender: TObject);
    procedure kp1MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure kp1MM(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure kp1MU(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure kp1Paint(Sender: TObject);
    procedure xkp1Paint(can:tcanvas);
    procedure B_SuchenC(Sender: TObject);
    procedure B_AnzeigeC(Sender: TObject);
    procedure CB6C(Sender: TObject);
    procedure Beispielrufen(Sender: TObject);
    procedure R1C(Sender: TObject);
    procedure WndProc(var msg:TMessage); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  feuler: Tfeuler;

implementation

uses math;

{$R *.DFM}
var kpunkte:array[1..100] of record x,y:double end;
    kpunktegrund:array[1..100] of record x,y:integer end;
    kpunktezahl,kantenzahl,zielpunktx,zielpunkty :integer;
    zweifaktor,schraegfaktor:double;
    sabbruch: boolean;
    hamm:boolean;
    grundziehen:boolean;
    nummerziehen:integer;
    grundverbinden:boolean = false;

function stringtofloat(kk:string):double;
var we:double;
begin
  while pos('.',kk)<>0 do kk[pos('.',kk)]:=',';
  we:=strtofloat(kk);
  result:=we;
end;

function ein_double(const edit:tedit):double;
var kk:string;
    we:double;
begin
  kk:=edit.text;
  while pos('.',kk)<>0 do kk[pos('.',kk)]:=',';
  we:=strtofloat(kk);
  result:=we;
end;

function  _str2komma(a:double):string;
begin
  str(a:1:2,result);
  while (length(result)>1) and (result[length(result)]='0') do delete(result,length(result),1);
  if (length(result)>1) and (result[length(result)]='.') then delete(result,length(result),1);
  if result='-0' then result:='0';
  if pos('.',result)>0 then result[pos('.',result)]:=',';
end;

procedure Tfeuler.WndProc(var msg:TMessage);
begin
  case Msg.Msg of
     WM_CLOSE: begin
      if not sabbruch then begin
        sabbruch:=true;
      end;
      close;
               end
  else
    inherited;
  end;
end;

procedure Tfeuler.S4C(Sender: TObject);
begin
  if not sabbruch then begin
    sabbruch:=true;
  end
  else close;
end;

procedure Tfeuler.FormShow(Sender: TObject);
var kk:string;
    lnr:integer;
  procedure kombo;
  begin
    liste.clear;
    lnr:=0;
    repeat
      kk:=lh1.items[lnr];
      inc(lnr);
      if kk[1]<>'[' then liste.items.add(kk);
    until kk[1]='[';
  end;
begin
  sabbruch:=true;
  kombo;
  liste.itemindex:=13;
  fillchar(kpunkte,sizeof(kpunkte),0);
  kpunktezahl:=0;
  kantenzahl:=0;
  zweifaktor:=1;
  schraegfaktor:=1;
  hamm:=false;
  panel10.width:=(eulergraph.width-panel12.width) div 2;
  beispielrufen(sender);
end;

procedure Tfeuler.SLoeschen(Sender: TObject);
begin
  LKnoten.clear;
  LKanten.clear;
  kpunktezahl:=0;
  kantenzahl:=0;
  kp1paint(sender);
end;

procedure Tfeuler.SLaden(Sender: TObject);
var dd:textfile;
    k:string;
    i:integer;
begin
  if od3.execute then begin
    if r1.itemindex=1 then begin
      hamm:=true;
      Label1.caption:='0 Hamiltonkreise gefunden'
    end else begin
      Label1.caption:='0 Eulerkreise gefunden';
      hamm:=false;
    end;
    Liste_E.clear;
    LKnoten.clear;
    LKanten.clear;
    assignfile(dd,od3.FileName);
    reset(dd);
    i:=0;
    repeat
      readln(dd,k);
      inc(i);
      if k<>'#' then begin
        LKnoten.items.add(k);
        delete(k,1,pos('(',k));
        kpunkte[i].x:=stringtofloat(copy(k,1,pos('|',k)-1));
        delete(k,1,pos('|',k));
        delete(k,length(k),1);
        kpunkte[i].y:=stringtofloat(k);
      end;
    until k='#';
    kpunktezahl:=LKnoten.Items.count;
    repeat
      readln(dd,k);
      if k<>'#' then LKanten.items.add(k);
    until k='#';
    kantenzahl:=LKanten.Items.count;
    closefile(dd);
    zweifaktor:=1; schraegfaktor:=1;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.SSpeichern(Sender: TObject);
var dd:textfile;
    k:string;
    i:integer;
begin
  if sd2.execute then begin
    assignfile(dd,sd2.FileName);
    rewrite(dd);
    if LKnoten.items.count>0 then
      for i:=0 to LKnoten.items.count-1 do begin
        k:=LKnoten.items[i];
        writeln(dd,k);
      end;
    k:='#';
    writeln(dd,k);
    if LKanten.items.count>0 then
      for i:=0 to LKanten.items.count-1 do begin
        k:=LKanten.items[i];
        writeln(dd,k);
      end;
    k:='#';
    writeln(dd,k);
    closefile(dd);
  end;
end;

procedure Tfeuler.LB7C(Sender: TObject);
var res:integer;
    k,k1:string;
begin
  res:=LKnoten.itemindex;
  if res>=0 then begin
    k:=LKnoten.items[res];
    delete(k,1,pos('(',k));
    k1:=copy(k,1,pos('|',k)-1);
    editX.text:=k1;
    delete(k,1,pos('|',k));
    delete(k,length(k),1);
    editY.text:=k;
  end;
end;

procedure Tfeuler.B_KnotenC(Sender: TObject);
begin
  if hamm then
    Label1.caption:='0 Hamiltonkreise gefunden'
  else
    Label1.caption:='0 Eulerkreise gefunden';
  Liste_E.clear;
  if kpunktezahl=28 then showmessage('Zu viele Knoten!')
  else begin
    inc(kpunktezahl);
    kpunkte[kpunktezahl].x:=ein_double(editX);
    kpunkte[kpunktezahl].y:=ein_double(editY);
    LKnoten.Items.add(chr(64+kpunktezahl)+#9+'('+_str2komma(kpunkte[kpunktezahl].x)
       +'|'+_str2komma(kpunkte[kpunktezahl].y)+')');
    kp1paint(sender);
  end;
end;

procedure Tfeuler.B_LoeschenC(Sender: TObject);
var i,res,a,e:integer;
    k,k1,k2:string;
begin
  if hamm then
    Label1.caption:='0 Hamiltonkreise gefunden'
  else
    Label1.caption:='0 Eulerkreise gefunden';
  Liste_E.clear;
  res:=LKnoten.itemindex;
  if res>=0 then begin
    LKnoten.items.delete(res);
    kpunktezahl:=LKnoten.items.count;
    if LKnoten.items.count>0 then begin
      for i:=0 to LKnoten.items.count-1 do begin
        k:=LKnoten.items[i];
        k:=copy(k,pos(#9,k)+1,200);
        k:=chr(65+i)+#9+k;
        LKnoten.items[i]:=k;
      end;
      for i:=1 to kpunktezahl do begin
        if i>res then kpunkte[i]:=kpunkte[i+1];
      end;
    end;
    if LKanten.items.count>0 then begin
      i:=0;
      repeat
        k:=LKanten.items[i];
        k1:=copy(k,1,pos('-',k)-1);
        k2:=copy(k,pos('-',k)+1,200);
        if length(k1)=1 then a:=ord(k1[1])-64
        else begin
          delete(k1,1,1);
          a:=strtoint(k1)
        end;
        if length(k2)=1 then e:=ord(k2[1])-64
        else begin
          delete(k2,1,1);
          e:=strtoint(k2)
        end;
        if (a=res+1) or (e=res+1) then LKanten.items.delete(i)
        else begin
          if a>res+1 then dec(a);
          if e>res+1 then dec(e);
          k1:=chr(64+a);
          k2:=chr(64+e);
          k:=k1+'-'+k2;
          LKanten.items[i]:=k;
          inc(i);
        end;
      until i>=LKanten.items.count;
      kantenzahl:=LKanten.items.count;
    end;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.B_AendernC(Sender: TObject);
var k:string;
    res:integer;
begin
  res:=LKnoten.itemindex;
  if res>=0 then begin
    kpunkte[res+1].x:=ein_double(editX);
    kpunkte[res+1].y:=ein_double(editY);
    k:=chr(64+res+1)+#9+'('+_str2komma(kpunkte[res+1].x)+'|'+_str2komma(kpunkte[res+1].y)+')';
    LKnoten.items[res]:=k;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.B_KanteC(Sender: TObject);
var k1,k2:string;
begin
  if hamm then
    Label1.caption:='0 Hamiltonkreise gefunden'
  else
    Label1.caption:='0 Eulerkreise gefunden';
  Liste_E.clear;
  k1:=edit1.text;
  k2:=edit2.text;
  if (length(k1)=1) and (length(k2)=1) and
     (ord(k1[1])>64) and (ord(k1[1])<=64+kpunktezahl) and
     (ord(k2[1])>64) and (ord(k2[1])<=64+kpunktezahl) then begin
    if k1<k2 then k1:=k1+'-'+k2
             else k1:=k2+'-'+k1;
    if LKanten.items.indexof(k1)<0 then LKanten.items.add(k1);
    kantenzahl:=LKanten.items.count;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.B_KanteLoeschenC(Sender: TObject);
var res:integer;
begin
  if hamm then
    Label1.caption:='0 Hamiltonkreise gefunden'
  else
    Label1.caption:='0 Eulerkreise gefunden';
  Liste_E.clear;
  res:=LKanten.itemindex;
  if res>=0 then begin
    LKanten.items.delete(res);
    kantenzahl:=LKanten.items.count;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.SGroesse(Sender: TObject);
begin
  if sender=s5 then zweifaktor:=1.1*zweifaktor;
  if sender=s6 then zweifaktor:=zweifaktor/1.1;
  if sender=s3 then zweifaktor:=1;
  kp1paint(sender);
end;

procedure Tfeuler.kp1MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
  if button=mbleft then begin
    for i:=1 to kpunktezahl do begin
      if (abs(kpunktegrund[i].x-x)<5) and (abs(kpunktegrund[i].y-y)<5) then begin
        grundziehen:=true;
        nummerziehen:=i;
      end;
    end;
  end else begin
    for i:=1 to kpunktezahl do begin
      if (abs(kpunktegrund[i].x-x)<5) and (abs(kpunktegrund[i].y-y)<5) then begin
        grundverbinden:=true;
        nummerziehen:=i;
      end;
    end;
  end;
end;

procedure Tfeuler.kp1MM(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var rx,ry,rpx,rpy:double;
    i,b,h:integer;
begin
  b:=kp1.width div 2;
  h:=kp1.height;
  if grundverbinden then begin
    zielpunktx:=x;
    zielpunkty:=y;
    kp1paint(sender);
    exit;
  end;
  if grundziehen then begin
    rx:=(x-b)/50/zweifaktor;
    ry:=(y-h div 2)/50/zweifaktor;
    rpx:=rx;
    rpy:=-ry;
    kpunkte[nummerziehen].x:=rpx;
    kpunkte[nummerziehen].y:=rpy;
    kp1paint(sender);
  end else begin
    kp1.cursor:=crdefault;
    for i:=1 to kpunktezahl do begin
      if (abs(kpunktegrund[i].x-x)<5) and (abs(kpunktegrund[i].y-y)<5)
      then kp1.cursor:=crhandpoint;
    end;
  end;
end;

procedure Tfeuler.kp1MU(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var rx,ry,rpx,rpy:double;
    b,h,j,i:integer;
    k,k1,k2:string;
begin
  b:=kp1.width div 2;
  h:=kp1.height;
  if grundziehen then begin
    rx:=(x-b)/50/zweifaktor;
    ry:=(y-h div 2)/50/zweifaktor;
    rpx:=rx;
    rpy:=-ry;
    kpunkte[nummerziehen].x:=rpx;
    kpunkte[nummerziehen].y:=rpy;
    k:=chr(64+nummerziehen)+#9+'('+_str2komma(kpunkte[nummerziehen].x)
       +'|'+_str2komma(kpunkte[nummerziehen].y)+')';
    LKnoten.items[nummerziehen-1]:=k;
    kp1paint(sender);
    grundziehen:=false;
  end;
  if grundverbinden then begin
    j:=0;
    for i:=1 to kpunktezahl do begin
      if (abs(kpunktegrund[i].x-x)<5) and (abs(kpunktegrund[i].y-y)<5) then j:=i;
    end;
    if (j>0) and (nummerziehen<>j) then begin
      k1:=chr(nummerziehen+64);
      k2:=chr(j+64);
      if k1<k2 then k1:=k1+'-'+k2
               else k1:=k2+'-'+k1;
      if LKanten.items.indexof(k1)<0 then LKanten.items.add(k1);
      kantenzahl:=LKanten.items.count;
    end;
    grundverbinden:=false;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.kp1Paint(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=kp1.width;
  bitmap.height:=kp1.height;
  xkp1paint(bitmap.canvas);
  if grundverbinden then begin
    bitmap.canvas.MoveTo(kpunktegrund[nummerziehen].x,kpunktegrund[nummerziehen].y);
    bitmap.canvas.lineTo(zielpunktx,zielpunkty);
  end;
  kp1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure Tfeuler.xkp1Paint(can:tcanvas);
var i,b,h,x,y,a,e,xa,xb,ya,yb:integer;
    k,k1,k2:string;
    rpunkte:array[1..200] of record x,y:double end;
begin
  b:=kp1.width div 2;
  h:=kp1.height;// div 2;
  for i:=1 to kpunktezahl do begin
    rpunkte[i].x:=kpunkte[i].x;
    rpunkte[i].y:=kpunkte[i].y;
  end;
  can.font.name:='Verdana';
  can.font.size:=8;
  can.brush.style:=bsclear;
  can.brush.color:=clyellow;
  if kantenzahl>0 then
    for i:=0 to kantenzahl-1 do begin
      k:=LKanten.items[i];
      k1:=copy(k,1,pos('-',k)-1);
      k2:=copy(k,pos('-',k)+1,255);
      if length(k1)=1 then a:=ord(k1[1])-64
      else begin
        delete(k1,1,1);
        a:=strtoint(k1)
      end;
      if length(k2)=1 then e:=ord(k2[1])-64
      else begin
        delete(k2,1,1);
        e:=strtoint(k2)
      end;
      xa:=round(b+50*zweifaktor*rpunkte[a].x);
      ya:=round(h div 2-50*zweifaktor*rpunkte[a].y);
      xb:=round(b+50*zweifaktor*rpunkte[e].x);
      yb:=round(h div 2-50*zweifaktor*rpunkte[e].y);
      can.moveto(xa,ya);
      can.lineto(xb,yb);
    end;
    for i:=1 to kpunktezahl do begin
      x:=round(b+50*zweifaktor*rpunkte[i].x);
      y:=round(h div 2-50*zweifaktor*rpunkte[i].y);
      kpunktegrund[i].x:=x;
      kpunktegrund[i].y:=y;
      can.ellipse(x-3,y-3,x+4,y+4);
    end;
    if C_Punkte.checked then begin
      can.brush.style:=bssolid;
      can.brush.color:=clwhite;
      for i:=1 to kpunktezahl do begin
        x:=round(b+50*zweifaktor*rpunkte[i].x);
        y:=round(h div 2-50*zweifaktor*rpunkte[i].y);
        can.textout(x+3,y+3,chr(i+64));
      end;
   end;
end;

procedure Tfeuler.B_SuchenC(Sender: TObject);
label 1;
var matrix:array of array of integer;
    hamilton,knotensumme,pfad:array of integer;
    i,j,a,e,anz,start,kantenort,zz,super:integer;
    k,k1,k2:string;
    nurpfad:boolean;

  procedure wegsuche(a,b:integer);
  var v,i:integer;
      k:string;
  begin
    if sabbruch then exit;
    if (a<=kpunktezahl) then begin
      while (b<=kpunktezahl) do begin
        if matrix[a,b]=1 then begin
          inc(kantenort);
          pfad[kantenort]:=b;
          matrix[a,b]:=0;
          matrix[b,a]:=0;
          if kantenort=kantenzahl then begin
            k:='';
            for i:=0 to kantenzahl do k:=k+chr(pfad[i]+64);
            Liste_E.items.add(k);
            inc(zz);
            if zz mod 100 = 0 then begin
              Label1.caption:=inttostr(zz);
              application.ProcessMessages;
            end;
            if Liste_E.items.count>250000 then begin
              sabbruch:=true;
              exit;
            end;
            matrix[a,b]:=1;
            matrix[b,a]:=1;
            dec(kantenort);
          end
          else wegsuche(b,1);
        end;
        inc(b);
      end;
      dec(kantenort,1);
      if kantenort<0 then exit;
      v:=pfad[kantenort];
      matrix[v,a]:=1;
      matrix[a,v]:=1;
    end;
  end;
  procedure hamiltonsuche(a,b:integer);
  var i:integer;
      k:string;
  begin
    if sabbruch then exit;
    if (a<=kpunktezahl) then begin
      while (b<=kpunktezahl) do begin
        if (matrix[a,b]=1) and (hamilton[b]=0) then begin
          inc(kantenort);
          pfad[kantenort]:=b;
          hamilton[b]:=1;
          if kantenort=kpunktezahl-1 then begin
            if (matrix[b,start]=1) or nurpfad then begin
              k:='';
              for i:=0 to kantenort do k:=k+chr(pfad[i]+64);
              if not nurpfad then k:=k+chr(start+64);
              Liste_E.items.add(k);
              inc(zz);
              Label1.caption:=inttostr(zz);
              if Liste_E.items.count>250000 then begin
                sabbruch:=true;
                exit;
              end;
              hamilton[b]:=0;
            end;
            hamilton[b]:=0;
            dec(kantenort);
          end
          else hamiltonsuche(b,1);
        end;
        inc(b);
      end;
      inc(super);
      if super mod 100=0 then application.ProcessMessages;
      dec(kantenort,1);
      if kantenort<0 then exit;
      hamilton[a]:=0;
    end;
  end;
  procedure setzen(f:boolean);
  begin
    B_Knoten.enabled:=f;
    B_Loeschen.enabled:=f;
    B_Kante.enabled:=f;
    B_KanteLoeschen.enabled:=f;
    B_Anzeige.enabled:=f;
    B_Aendern.enabled:=f;
  end;
begin
  if not sabbruch then sabbruch:=true
  else begin
    sabbruch:=false;
    B_Suchen.caption:='Suche stoppen';
    setzen(false);
    Liste_E.clear;
    super:=0;
    if kpunktezahl>1 then begin
      setlength(matrix,kpunktezahl+1,kpunktezahl+1);
      setlength(knotensumme,kpunktezahl+1);
      setlength(hamilton,kpunktezahl+1);
      setlength(pfad,kantenzahl+1);
      for i:=0 to kantenzahl do pfad[i]:=0;
      for i:=0 to kpunktezahl do begin
        knotensumme[i]:=0;
        hamilton[i]:=0
      end;
      for i:=0 to kpunktezahl do
        for j:=0 to kpunktezahl do matrix[i,j]:=0;
      if kantenzahl>0 then
        for i:=0 to kantenzahl-1 do begin
          k:=LKanten.items[i];
          k1:=copy(k,1,pos('-',k)-1);
          k2:=copy(k,pos('-',k)+1,255);
          if length(k1)=1 then a:=ord(k1[1])-64
          else begin
            delete(k1,1,1);
            a:=strtoint(k1)
          end;
          if length(k2)=1 then e:=ord(k2[1])-64
          else begin
            delete(k2,1,1);
            e:=strtoint(k2)
          end;
          inc(knotensumme[a]);
          inc(knotensumme[e]);
          matrix[a,e]:=1;
          matrix[e,a]:=1;
        end;
        if not hamm then begin
          anz:=0;
          for i:=1 to kpunktezahl do
            if odd(knotensumme[i]) then inc(anz);
          if anz>2 then begin
            Liste_E.items.add('kein Eulerkreis möglich');
            goto 1;
          end;
          if anz>0 then begin
            for i:=1 to kpunktezahl do
              if odd(knotensumme[i]) then start:=i;
          end
          else start:=1;
        end else begin
          if LKnoten.itemindex>=0 then start:=LKnoten.itemindex+1
                                  else start:=1;
          hamilton[start]:=1;
        end;
        kantenort:=0;
        pfad[kantenort]:=start;
        zz:=0;
        nurpfad:=CB_Pfad.checked;
        if hamm then hamiltonsuche(start,1) else wegsuche(start,1);
1:      setlength(matrix,0,0);
        setlength(pfad,0);
        setlength(hamilton,0);
        setlength(knotensumme,0);
      end;
    end;
    sabbruch:=true;
    if hamm then
      B_Suchen.caption:='Hamiltonkreis suchen'
    else B_Suchen.caption:='Eulerkreis suchen';
    setzen(true);
    if (Liste_E.items.count=0) or ((Liste_E.items.count=1) and (pos('kein',Liste_E.items[0])>0)) then begin
      if hamm then begin
        if nurpfad then begin
          Liste_E.items.add('kein Hamilton-Pfad möglich');
          Label1.caption:='0 Hamilton-Pfade gefunden'
        end else begin
          Liste_E.items.add('kein Hamiltonkreis möglich');
          Label1.caption:='0 Hamiltonkreise gefunden'
        end
      end
      else
        Label1.caption:='0 Eulerkreise gefunden';
    end else begin
      if Liste_E.items.count>250000 then begin
        if hamm then begin
          if nurpfad then Label1.caption:='mehr als 250000 Hamilton-Pfade gefunden'
                     else Label1.caption:='mehr als 250000 Hamiltonkreise gefunden'
        end
        else
          Label1.caption:='mehr als 250000 Eulerkreise gefunden'
      end else begin
        if hamm then begin
          if nurpfad then
            Label1.caption:=inttostr(Liste_E.items.count)+' Hamilton-Pfade gefunden'
          else
            Label1.caption:=inttostr(Liste_E.items.count)+' Hamiltonkreise gefunden'
        end
        else
          Label1.caption:=inttostr(Liste_E.items.count)+' Eulerkreise gefunden';
      end;
    end;
end;

procedure Tfeuler.B_AnzeigeC(Sender: TObject);
var sel,i,ii,j,b,h,x,y,x0,y0,x1,y1:integer;
    bitmap:tbitmap;
    k:string;
  procedure setzen(f:boolean);
  begin
    sabbruch:=f;
    B_Knoten.enabled:=f;
    B_Loeschen.enabled:=f;
    B_Kante.enabled:=f;
    B_KanteLoeschen.enabled:=f;
    B_Suchen.enabled:=f;
    B_Aendern.enabled:=f;
  end;

procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:double;
    x,y:integer;
    pfe:array[0..3] of tpoint;
    wcos,wsin:extended;
  procedure kline(a,b,c,d:integer);
  begin
    can.moveto(a,b);
    can.lineto(c,d);
  end;
begin
  kline(a,b,c,d);
  if (a<>c) or (b<>d) then begin
    if (c-a)<>0 then
      wi:=pi-arctan((d-b)/(c-a))
    else begin
      if d<b then wi:=-pi/2
             else wi:=pi/2;
    end;
    sincos(wi-xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[0].x:=c+x;
    pfe[0].y:=d-y;
    pfe[1].x:=c;
    pfe[1].y:=d;
    sincos(wi+xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[2].x:=c+x;
    pfe[2].y:=d-y;
    can.brush.color:=can.pen.color;
    can.polygon(slice(pfe,3));
    can.brush.style:=bsclear;
  end;
end;
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

begin
  if not sabbruch then sabbruch:=true
  else begin
    x0:=0;
    y0:=0;
    sel:=Liste_E.itemindex;
    if sel>=0 then begin
      B_Anzeige.caption:='Anzeigen stoppen';
      setzen(false);
      bitmap:=tbitmap.create;
      bitmap.pixelformat:=pf32bit;
      bitmap.width:=kp2.width;
      bitmap.height:=kp2.height;
      bitmap.canvas.font.name:='Verdana';
      bitmap.canvas.font.size:=8;
      b:=kp2.width div 2;
      h:=kp2.height;
      k:=Liste_E.items[sel];
      for j:=1 to length(k) do begin
        ii:=ord(k[j])-64;
        x1:=round(b+50*zweifaktor*kpunkte[ii].x);
        y1:=round(h div 2-50*zweifaktor*kpunkte[ii].y);
        bitmap.canvas.pen.color:=clblue;
        if j=1 then begin
          x0:=x1;
          y0:=y1
        end else begin
          xpfeilvoll(bitmap.canvas,x0,y0,x1,y1);
          x0:=x1;
          y0:=y1
        end;
        bitmap.canvas.brush.color:=clyellow;
        bitmap.canvas.pen.color:=clmaroon;
        for i:=1 to kpunktezahl do begin
          x:=round(b+50*zweifaktor*kpunkte[i].x);
          y:=round(h div 2-50*zweifaktor*kpunkte[i].y);
          bitmap.canvas.ellipse(x-3,y-3,x+4,y+4);
        end;
        bitmap.canvas.brush.style:=bsclear;
        for i:=1 to kpunktezahl do begin
          x:=round(b+50*zweifaktor*kpunkte[i].x);
          y:=round(h div 2-50*zweifaktor*kpunkte[i].y);
          bitmap.canvas.textout(x+3,y+3,chr(i+64));
        end;
        kp2.canvas.draw(0,0,bitmap);
        application.ProcessMessages;
        if sabbruch then break;
        pause(300);
      end;
      bitmap.free;
    end;
    setzen(true);
    if hamm then
      B_Anzeige.caption:='Hamiltonkreis anzeigen'
    else
      B_Anzeige.caption:='Eulerkreis anzeigen';
  end;
end;

procedure Tfeuler.CB6C(Sender: TObject);
begin
  if CB_Pfad.checked then panel8.caption:='Hamilton-Pfade'
                     else panel8.caption:='Hamiltonkreise';
end;

procedure Tfeuler.Beispielrufen(Sender: TObject);
var i,sel,lnr:integer;
    ke,kk,k:string;
begin
  sel:=liste.itemindex;
  if sel>=0 then begin
    ke:='['+liste.text;
    if hamm then
      Label1.caption:='0 Hamiltonkreise gefunden'
    else
      Label1.caption:='0 Eulerkreise gefunden';
    Liste_E.clear;
    LKnoten.clear;
    LKanten.clear;
    lnr:=0;
    repeat
      kk:=lh1.items[lnr];
      inc(lnr);
    until (kk=ke);
    if kk=ke then begin
      i:=0;
      repeat
        k:=lh1.items[lnr];
        inc(lnr);
        inc(i);
        if k<>'#' then begin
          LKnoten.items.add(k);
          delete(k,1,pos('(',k));
          kpunkte[i].x:=stringtofloat(copy(k,1,pos('|',k)-1));
          delete(k,1,pos('|',k));
          delete(k,length(k),1);
          kpunkte[i].y:=stringtofloat(k);
        end;
      until k='#';
      kpunktezahl:=LKnoten.Items.count;
      repeat
        k:=lh1.items[lnr];
        inc(lnr);
        if k<>'#' then LKanten.items.add(k);
      until k='#';
      kantenzahl:=LKanten.Items.count;
    end;
    zweifaktor:=1;
    schraegfaktor:=1;
    kp1paint(sender);
  end;
end;

procedure Tfeuler.R1C(Sender: TObject);
var k:string;
begin
  if r1.itemindex=0 then begin
    CB_Pfad.visible:=false;
    hamm:=false;
    k:='Euler';
  end else begin
    CB_Pfad.visible:=true;
    hamm:=true;
    k:='Hamilton';
  end;
  B_Suchen.caption:=k+'kreis suchen';
  B_Anzeige.caption:=k+'kreis anzeigen';
  panel8.caption:=k+'kreise';
  Label1.caption:='0 '+k+'kreise gefunden';
end;

begin
sabbruch:=true;
hamm:=true;
grundziehen:= false;
nummerziehen:= 0;
grundverbinden:= false;

end.

