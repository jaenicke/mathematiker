unit uachtdamen;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, messages, ExtDlgs, CheckLst, math, Spin;

const maxx=24;
      xb=40;
      xc=8;
      frei=true;
      besetzt=false;
type
  Tfachtdamen = class(TForm)
    Panel8: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel2: TPanel;
    PB1: TPaintBox;
    im1: TImage;
    im2: TImage;
    Panel4: TPanel;
    L1: TLabel;
    L2: TLabel;
    L3: TLabel;
    L4: TLabel;
    Button1: TButton;
    C1: TCheckBox;
    C2: TCheckBox;
    C3: TCheckBox;
    C4: TCheckBox;
    acht: TPanel;
    Panel5: TPanel;
    LB1: TListBox;
    SpinEdit1: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure feldgroesse(Sender: TObject);
    procedure zeichnen(sender: tobject);
    procedure simulation(Sender: TObject);
    procedure anzeige(Sender: TObject);
    procedure Spielmodus(Sender: TObject);
    procedure PB1D(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure simula;
    procedure WndProc(var msg:TMessage); override;
  private
    { Private declarations }
      zeile : array[1..maxx] of boolean;
      ndiag : array[2..2*maxx] of boolean;
      hdiag : array[-(maxx-1)..(maxx-1)] of boolean;
      spalte: array[1..26] of integer;
      spalteold: array[1..maxx] of integer;
      belegung : array[0..20,0..17] of integer;
      b1,b2:tbitmap;
  public
    { Public declarations }
  end;

var  fachtdamen: Tfachtdamen;

implementation

const sabbruch : boolean = true;
      eigen : boolean = false;
var   feld,feld2 : integer;
{$R *.DFM}

procedure Tfachtdamen.WndProc(var msg:TMessage);
begin
  case Msg.Msg of
    WM_CLOSE: begin
       if not sabbruch then begin
         simula;
         if eigen then begin
           eigen:=false;
         end;
       end;
       close;
           end;
  else
    inherited;
  end;
end;

procedure tfachtdamen.simula;
begin
  sabbruch:=true;
  Button1.caption:='Simulation';
end;

function _str(a:double;b,c:byte):string;
begin
  str(a:b:c,result);
  if c<>0 then begin
    while (length(result)>1) and (result[length(result)]='0') do delete(result,length(result),1);
    if (length(result)>1) and (result[length(result)]='.') then delete(result,length(result),1);
  end;
  if result='-0' then result:='0';
end;

procedure tfachtdamen.zeichnen(sender: tobject);
var Bitmap: TBitmap;
    ziel:tcanvas;
    b,h:integer;

  procedure achtdamen;
  var li,ob,i,j:integer;
    procedure test;
    var su,i,j,k:integer;
      procedure kreuz(i,j:integer);
      var ixb,jxb:integer;
      begin
        ixb:=li+i*xb;
        jxb:=ob+j*xb;
        ziel.moveto(ixb+4,jxb+4);
        ziel.lineto(ixb+xb-4,jxb+xb-4);
        ziel.moveto(ixb+xb-4,jxb+4);
        ziel.lineto(ixb+4,jxb+xb-4);
      end;
    begin
      ziel.pen.width:=2;
      ziel.pen.color:=clred;
      for i:=0 to feld-1 do begin
        su:=0;
        for j:=0 to feld-1 do begin
          if belegung[i+1,j+1]=1 then begin
            inc(su);
            if su>1 then kreuz(i,j);
          end;
        end;
      end;
      for i:=feld-1 downto 0 do begin
        su:=0;
        for j:=feld-1 downto 0 do begin
          if belegung[i+1,j+1]=1 then begin
            inc(su);
            if su>1 then kreuz(i,j);
          end;
        end;
      end;
      for i:=0 to feld-1 do begin
        su:=0;
        for j:=0 to feld-1 do begin
          if belegung[j+1,i+1]=1 then begin
            inc(su);
            if su>1 then kreuz(j,i);
          end;
        end;
      end;
      for i:=feld-1 downto 0 do begin
        su:=0;
        for j:=feld-1 downto 0 do begin
          if belegung[j+1,i+1]=1 then begin
            inc(su);
            if su>1 then kreuz(j,i);
          end;
        end;
      end;
      for k:=-16 to 16 do begin
        su:=0;
        for i:=0 to feld-1 do begin
          for j:=0 to feld-1 do begin
            if (belegung[j+1,i+1]=1) and ((j-i)=k) then begin
              inc(su);
              if su>1 then kreuz(j,i);
            end;
          end;
        end;
      end;
      for k:=-16 to 16 do begin
        su:=0;
        for i:=feld-1 downto 0 do begin
          for j:=feld-1 downto 0 do begin
            if (belegung[j+1,i+1]=1) and ((j-i)=k) then begin
              inc(su);
              if su>1 then kreuz(j,i);
            end;
          end;
        end;
      end;
      for k:=0 to 33 do begin
        su:=0;
        for i:=0 to feld-1 do begin
          for j:=0 to feld-1 do begin
            if (belegung[j+1,i+1]=1) and ((j+i)=k) then begin
              inc(su);
              if su>1 then kreuz(j,i);
            end;
          end;
        end;
      end;
      for k:=0 to 33 do begin
        su:=0;
        for i:=feld-1 downto 0 do begin
          for j:=feld-1 downto 0 do begin
            if (belegung[j+1,i+1]=1) and ((j+i)=k) then begin
              inc(su);
              if su>1 then kreuz(j,i);
            end;
          end;
        end;
      end;
    if c4.checked then begin
      for i:=1 to feld do begin
        for j:=1 to feld do begin
          if belegung[j,i]=1 then begin
            su:=1;
            if (i+2<=feld) and (j-1>0) and (belegung[j-1,i+2]=1) then inc(su);
            if (i+2<=feld) and (j+1<=feld) and (belegung[j+1,i+2]=1) then inc(su);
            if (i-2>0) and (j-1>0) and (belegung[j-1,i-2]=1) then inc(su);
            if (i-2>0) and (j+1<=feld) and (belegung[j+1,i-2]=1) then inc(su);

            if (i+1<=feld) and (j-2>0) and (belegung[j-2,i+1]=1) then inc(su);
            if (i-1>0) and (j-2>0) and (belegung[j-2,i-1]=1) then inc(su);
            if (i+1<=feld) and (j+2<=feld) and (belegung[j+2,i+1]=1) then inc(su);
            if (i-1>0) and (j+2<=feld) and (belegung[j+2,i-1]=1) then inc(su);
            if su>1 then kreuz(j-1,i-1);
          end;
        end;
      end;

    end;
      ziel.pen.width:=1;
      ziel.pen.color:=clblack;
    end;
  begin
    li:=(b-xb*feld) div 2;
    ob:=(h-xb*feld) div 2;
    for i:=0 to feld-1 do begin
      for j:=0 to feld-1 do begin
        if not odd(i+j+feld) then ziel.brush.color:=clltgray
                             else ziel.brush.color:=clwhite;
        ziel.rectangle(li+i*xb,ob+j*xb,li+i*xb+xb+1,ob+j*xb+xb+1);
      end
    end;
    ziel.brush.style:=bsclear;
    for i:=0 to feld-1 do
      ziel.textout(li+i*xb+15,ob+feld*xb+5,chr(i+65));
    for i:=0 to feld-1 do
      ziel.textout(li-20,ob+i*xb+12,inttostr(feld-i));
    if eigen then begin
      for i:=0 to feld-1 do begin
        for j:=0 to feld-1 do begin
          if belegung[i+1,j+1]=1 then
            if not odd(i+j+feld) then ziel.draw(li+i*xb+xc,ob+j*xb+xc,b1)
                                 else ziel.draw(li+i*xb+xc,ob+j*xb+xc,b2);
        end
      end;
      test;
    end;
  end;

begin
  Bitmap := TBitmap.Create;
  bitmap.pixelformat:=pf32bit;
  Bitmap.Width := panel7.Width;
  Bitmap.Height := panel7.Height;
  ziel:=bitmap.canvas;
  ziel.font.name:='Verdana';
  ziel.font.size:=10;
  b:=bitmap.width;
  h:=bitmap.height;
  achtdamen;
  pb1.canvas.draw(0,0,bitmap);
  Bitmap.Free;
end;

procedure Tfachtdamen.FormShow(Sender: TObject);
begin
  simula;
  feld:=8;
  feld2:=8;
end;

procedure Tfachtdamen.FormCreate(Sender: TObject);
begin
  B1 := TBitmap.Create;
  b1.width:=160;
  b1.height:=160;
  b1.assign(im1.picture);
  B2 := TBitmap.Create;
  b2.width:=160;
  b2.height:=160;
  b2.assign(im2.picture);
  feld:=8;
  feld2:=8;
end;

procedure Tfachtdamen.feldgroesse(Sender: TObject);
begin
  c1.checked:=false;
  simula;
  feld:=min(max(4,round(spinedit1.value)),16);
  zeichnen(sender);
end;

procedure Tfachtdamen.simulation(Sender: TObject);
var li,ob,anzahl:integer;
    zeit,zeit0:longint;
    kk:string;
    ungeradesfeld:boolean;
    symmetrie:integer;
    achtliste:tstringlist;
    superdame:boolean;
procedure achtnext(i:integer);
var j,jj:integer;
    superkorrekt:boolean;
  procedure ausgabe;
  var i,j,k:integer;
      kp:string;
  begin
    if c2.checked then begin
      for i:=0 to feld-1 do begin
        j:=spalte[i+1]-1;
        k:=spalteold[i+1];
        if j<>k then begin
          if not odd(i+k+feld) then pb1.canvas.brush.color:=clltgray
                               else pb1.canvas.brush.color:=clwhite;
          pb1.canvas.rectangle(li+k*xb,ob+i*xb,li+k*xb+xb+1,ob+i*xb+xb+1);{bild(breite*k,breite*i,3)}
          if not odd(i+j+feld) then pb1.canvas.draw(li+j*xb+xc,ob+i*xb+xc,b1)
                               else pb1.canvas.draw(li+j*xb+xc,ob+i*xb+xc,b2);
          spalteold[i+1]:=j;
        end;
      end;
    end;
    inc(anzahl);
    if (not ungeradesfeld) or
       (ungeradesfeld and (spalte[1]<>symmetrie-1)) then inc(anzahl);
    if anzahl mod 2000=0 then begin
      zeit:=(longint(gettickcount)-zeit0) div 10;
      l2.caption:=_str(zeit/100,1,1)+' s';
      l4.caption:=inttostr(anzahl);
    end;
    if c3.checked and (anzahl<100001) then begin
      kk:='';
      for i:=1 to feld do begin
        if spalte[i]>=10 then kp:=chr(spaLTE[i]+55)
                         else str(spalte[i],kp);
        kk:=kk+kp
      end;
      achtliste.add(kk);
      if ((not ungeradesfeld) or
        (ungeradesfeld and (spalte[1]<>symmetrie-1))) then begin
        kk:='';
        for i:=1 to feld do begin
          if feld+1-spalte[i]>=10 then kp:=chr(feld+1-spaLTE[i]+55)
                                  else str(feld+1-spalte[i],kp);
          kk:=kk+kp
        end;
        achtliste.add(kk);
      end;
    end;
  end;
begin
  if anzahl mod 1000 = 0 then begin
    application.processmessages;
    if sabbruch then exit;
  end;
  for j:=1 to feld do begin
    if (zeile[j]=frei) and (ndiag[i+j]=frei) and (hdiag[i-j]=frei) then begin
      spalte[i]:=j;
      if spalte[1]=symmetrie then exit;
      zeile[j]:=besetzt;
      ndiag[i+j]:=besetzt;
      hdiag[i-j]:=besetzt;
      if i<feld then
        achtnext(i+1)
      else begin
        if not superdame then
          ausgabe
        else begin
          superkorrekt:=true;
          for jj:=1 to feld-1 do begin
            if abs(spalte[jj]-spalte[jj+1])=2 then superkorrekt:=false;
            if (jj<feld-1) and (abs(spalte[jj]-spalte[jj+2])=1) then superkorrekt:=false;
          end;
          if superkorrekt then ausgabe;
        end;
      end;
      zeile[j]:=frei;
      ndiag[i+j]:=frei;
      hdiag[i-j]:=frei;
    end
  end
end;
begin
    if not sabbruch then simula
    else begin
      c1.checked:=false;
      zeichnen(sender);
      superdame:=c4.checked;
      zeit0:=gettickcount;
      li:=(pb1.width-xb*feld) div 2;
      ob:=(pb1.height-xb*feld) div 2;
      sabbruch:=false;
      Button1.caption:='Abbruch';
      achtliste:=tstringlist.create;
      anzahl:=0;
      fillchar(zeile,sizeof(zeile),frei);
      fillchar(ndiag,sizeof(ndiag),frei);
      fillchar(hdiag,sizeof(hdiag),frei);
      fillchar(spalteold,sizeof(spalteold),feld-1);
      ungeradesfeld:=odd(feld);
      symmetrie:=feld div 2+1;
      if ungeradesfeld then inc(symmetrie);
      achtnext(1);
      achtliste.sorted:=true;
      lb1.items:=achtliste;
      achtliste.free;
      l4.caption:=inttostr(anzahl);
      simula;
    end;
end;

procedure Tfachtdamen.anzeige(Sender: TObject);
var kk:string;
    i,j,li,ob:integer;
begin
  c1.checked:=false;
  li:=(pb1.width-xb*feld) div 2;
  ob:=(pb1.height-xb*feld) div 2;
  zeichnen(sender);
  kk:=lb1.items.strings[lb1.itemindex];
  for i:=0 to feld-1 do begin
    j:=ord(kk[i+1]);
    if j>64 then j:=j-56 else j:=j-49;
    if (j>=0) and (j<=15) and (j<feld) then begin
      if not odd(i+j+feld)
      then pb1.canvas.draw(li+j*xb+xc,ob+i*xb+xc,b1)
      else pb1.canvas.draw(li+j*xb+xc,ob+i*xb+xc,b2);
    end;
  end;
end;

procedure Tfachtdamen.Spielmodus(Sender: TObject);
var i,j:integer; s:string;
begin
  if c1.checked then begin
    eigen:=true;

      for i:=0 to 18 do
        for j:=0 to 16 do belegung[i,j]:=0;
      lb1.clear;
      if c4.checked then
        s:='Positionieren Sie '+inttostr(feld)+' Superdamen auf dem Spiefeld!'
      else
        s:='Positionieren Sie '+inttostr(feld)+' Damen auf dem Spiefeld!';
    showmessage(s);
    zeichnen(sender);
  end
  else eigen:=false;
end;

procedure Tfachtdamen.PB1D(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const a:array[1..8] of shortint =(2,1,-1,-2,-2,-1,1,2);
      b:array[1..8] of shortint =(1,2,2,1,-1,-2,-2,-1);
var li,ob,xx,yy:integer;

begin
  if eigen then begin
            li:=(pb1.width-xb*feld) div 2;
            ob:=(pb1.height-xb*feld) div 2;
            xx:=(x-li+xb) div xb;
            yy:=(y-ob+xb) div xb;
            if (xx>0) and (xx<=feld) and (yy>0) and (yy<=feld) then begin
              if belegung[xx,yy]=1 then belegung[xx,yy]:=0
                                   else belegung[xx,yy]:=1;
              zeichnen(sender);
            end;
    end;
end;

procedure Tfachtdamen.FormDestroy(Sender: TObject);
begin
  b1.free;
  b2.free;
end;

end.

