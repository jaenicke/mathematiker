unit uvier;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, ComCtrls, Buttons;

type
  Tfvier = class(TForm)
    PM1: TPopupMenu;
    P1: TPanel;
    P5: TPanel;
    p7: TPanel;
    D2: TButton;
    pb1: TPaintBox;
    p4M1: TMemo;
    L7: TLabel;
    l1: TMenuItem;
    r1: TMenuItem;
    d1: TMenuItem;
    l2: TMenuItem;
    L3: TLabel;
    x1: TMenuItem;
    Edit1: TEdit;
    L4: TLabel;
    d3: TButton;
    Timer2: TTimer;
    ListBox1: TListBox;
    procedure MPntCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2click(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure l1Click(Sender: TObject);
    procedure r1Click(Sender: TObject);
    procedure d1Click(Sender: TObject);
    procedure l2Click(Sender: TObject);
    procedure d3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fvier: Tfvier;

implementation

{$R *.DFM}
var sb,sh,sx,sy,zx,zy,sx2,sy2,zx2,zy2,nr,schritt,
    sxold,syold,sxold2,syold2,zuege:integer;
    doppelspiel:boolean;
    verlauf:string;
    feldx,feldy:array[0..20,0..20] of integer;
    kippliste:tstringlist;
    aa:integer;

procedure Tfvier.FormCreate(Sender: TObject);
begin
    aa:=64;
    kippliste:=tstringlist.create;
    kippliste.assign(listbox1.items);
    nr:=1;
    randomize;
    Button2click(Sender);
end;

procedure Tfvier.MPntCloseClick(Sender: TObject);
begin
    Close;
end;

procedure Tfvier.Button2click(Sender: TObject);
var sel,po,i,j:integer;
    k,k1:string;
begin
    doppelspiel:=false;

    nr:=strtoint(edit1.text);
    if nr<1 then nr:=1;

    sel:=strtoint(kippliste[0]);
    L4.caption:=inttostr(sel)+' Spiele';
    if nr>sel then nr:=1;
    k:='['+inttostr(nr);
    po:=kippliste.indexof(k)+1;
    k:=kippliste[po];
    sb:=strtoint(copy(k,1,pos(',',k)-1));
    sh:=strtoint(copy(k,pos(',',k)+1,20));

    inc(po);
    k:=kippliste[po];
    k1:=copy(k,1,pos(':',k)-1);
    k:=copy(k,pos(':',k)+1,25);
    sx:=strtoint(copy(k1,1,pos(',',k1)-1));
    sy:=strtoint(copy(k1,pos(',',k1)+1,20));
    sxold:=sx;
    syold:=sy;
    zx:=strtoint(copy(k,1,pos(',',k)-1));
    zy:=strtoint(copy(k,pos(',',k)+1,20));

    if nr>14 then begin
      doppelspiel:=true;
      inc(po);
      k:=kippliste[po];
      k1:=copy(k,1,pos(':',k)-1);
      k:=copy(k,pos(':',k)+1,25);
      sx2:=strtoint(copy(k1,1,pos(',',k1)-1));
      sy2:=strtoint(copy(k1,pos(',',k1)+1,20));
      sxold2:=sx2;
      syold2:=sy2;
      zx2:=strtoint(copy(k,1,pos(',',k)-1));
      zy2:=strtoint(copy(k,pos(',',k)+1,20));
    end;
    inc(po);
    for i:=1 to sh do begin
      k:=kippliste[po];
      for j:=0 to sb do feldx[j,i]:=0;
      for j:=1 to length(k) do feldx[ord(k[j])-48,i]:=1;
      inc(po);
    end;
    for i:=1 to sb do begin
      k:=kippliste[po];
      for j:=0 to sh do feldy[i,j]:=0;
      for j:=1 to length(k) do feldy[i,ord(k[j])-48]:=1;
      inc(po);
    end;
    verlauf:=kippliste[po];
    if verlauf[1]='[' then begin
      d3.visible:=false;
      verlauf:='';
    end
    else d3.visible:=true;
    zuege:=0;
    pb1paint(sender);
end;

procedure Tfvier.pb1Paint(Sender: TObject);
var fb,i,j,b,h,xoffset,yoffset:integer;
    bild:tbitmap;
begin
    edit1.text:=inttostr(nr);
    bild:=tbitmap.create;
    bild.width:=PB1.width;
    bild.height:=PB1.height;
    b:=PB1.width;
    h:=PB1.height;

    fb:=(h-60) div (sh+1);
    if (b-60) div (sh+1)<fb then fb:=(b-60) div (sh+1);
    aa:=fb;

    xoffset:=(b-(sb*aa)) div 2;
    yoffset:=(h-(sh*aa)) div 2;
    with bild.canvas do begin
      brush.color:=clwhite;
      pen.color:=clltgray;
      pen.width:=1;
      for i:=0 to sb-1 do
        for j:=0 to sh-1 do
          rectangle(xoffset+i*aa,yoffset+j*aa,
                  xoffset+i*aa+aa+1,yoffset+j*aa+aa+1);
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
      if doppelspiel then
        ellipse(xoffset+zx2*aa+6-aa,yoffset+zy2*aa+6-aa,
                 xoffset+zx2*aa-5,yoffset+zy2*aa-5);
      pen.width:=1;
      brush.color:=clred;
      ellipse(xoffset+sx*aa+10-aa,yoffset+sy*aa+10-aa,
                 xoffset+sx*aa-9,yoffset+sy*aa-9);
      if doppelspiel then
        ellipse(xoffset+sx2*aa+10-aa,yoffset+sy2*aa+10-aa,
                 xoffset+sx2*aa-9,yoffset+sy2*aa-9);
    end;
    PB1.Canvas.draw(0,0,bild);
    bild.free;
    l7.caption:='Züge '+inttostr(zuege);

    if doppelspiel then begin
      if ((sx=zx) and (sy=zy) and (sx2=zx2) and (sy2=zy2)) or
         ((sx=zx2) and (sy=zy2) and (sx2=zx) and (sy2=zy)) then begin
        timer2.enabled:=false;
        d3.caption:='Demonstration';
        showmessage('Gratulation! Sie haben die Aufgabe gelöst');
        inc(nr);
        edit1.text:=inttostr(nr);
      end;
    end
    else begin //kein doppelspiel
      if (sx=zx) and (sy=zy) then begin
        timer2.enabled:=false;
        d3.caption:='Demonstration';
        showmessage('Gratulation! Sie haben die Aufgabe gelöst');
        inc(nr);
        edit1.text:=inttostr(nr);
      end;
    end;
end;

procedure Tfvier.l1Click(Sender: TObject);
var i,j,i2,j2,q:integer;
begin //hoch
    if doppelspiel then begin
      if sy2<sy then begin
        q:=2;
        i:=sx2;
        j:=sy2;
        i2:=sx;
        j2:=sy;
      end
      else begin
        q:=1;
        i:=sx;
        j:=sy;
        i2:=sx2;
        j2:=sy2;
      end;
      inc(zuege);
      while ((feldy[i,j-1]=0) and (j>1)) or ((feldy[i2,j2-1]=0) and
            ((sx<>sx2) or ((j2-1<>sy) and (j2-1<>sy2))) and (j2>1)) do begin
        while (feldy[i,j-1]=0) and (j>1) do begin dec(j);
          case q of
            2 : sy2:=j;
           else sy:=j;
          end;
      end;
      while (feldy[i2,j2-1]=0) and ((sx<>sx2) or ((j2-1<>sy) and (j2-1<>sy2)))
            and (j2>1) do begin
        dec(j2);
        case q of
          2 : begin
                sy2:=j;
                sy:=j2
              end;
         else begin
                sy2:=j2;
                sy:=j
              end;
        end;
      end;
      pb1Paint(Sender);
      sleep(15);
    end;
  end else begin //kein doppelspiel
    i:=sx;
    j:=sy;
    inc(zuege);
    while (feldy[i,j-1]=0) and (j>1) do begin
      dec(j);
      sy:=j;
      pb1Paint(Sender);
      sleep(15);
    end;
  end;
end;

procedure Tfvier.r1Click(Sender: TObject);
var i,j,q,i2,j2:integer;
begin //rechts
    if doppelspiel then begin
      if sx2>sx then begin
        q:=2;
        i:=sx2;
        j:=sy2;
        i2:=sx;
        j2:=sy;
      end else begin
        q:=1;
        i:=sx;
        j:=sy;
        i2:=sx2;
        j2:=sy2;
      end;
      inc(zuege);
      while ((feldx[i,j]=0) and (i<sb)) or ((feldx[i2,j2]=0) and ((sy<>sy2) or
            ((i2+1<>sx) and (i2+1<>sx2))) and (i2<sb)) do begin
        while (feldx[i,j]=0) and (i<sb) do begin inc(i);
          case q of
            2 : sx2:=i;
           else sx:=i;
          end;
      end;
      while (feldx[i2,j2]=0) and ((sy<>sy2) or ((i2+1<>sx) and (i2+1<>sx2)))
            and (i2<sb) do begin
        inc(i2);
        case q of
          2 : begin sx2:=i; sx:=i2 end;
         else begin sx2:=i2; sx:=i end;
        end;
      end;
      pb1Paint(Sender);
      sleep(15);
    end;
  end else begin //kein doppelspiel
    i:=sx;
    j:=sy;
    inc(zuege);
    while (feldx[i,j]=0) and (i<sb) do begin inc(i);
    sx:=i;
    pb1Paint(Sender);
    sleep(15);
  end;
  end;
end;

procedure Tfvier.d1Click(Sender: TObject);
var i,j,q,i2,j2:integer;
begin //runter
    if doppelspiel then begin
      if sy2>sy then begin
        q:=2;
        i:=sx2;
        j:=sy2;
        i2:=sx;
        j2:=sy;
      end else begin
        q:=1;
        i:=sx;
        j:=sy;
        i2:=sx2;
        j2:=sy2;
      end;
      inc(zuege);
      while ((feldy[i,j]=0) and (j<sh)) or ((feldy[i2,j2]=0) and ((sx<>sx2)
            or ((j2+1<>sy) and (j2+1<>sy2))) and (j2<sh)) do begin
        while (feldy[i,j]=0) and (j<sh) do begin
          inc(j);
          case q of
            2 : sy2:=j;
           else sy:=j;
          end;
        end;
        while (feldy[i2,j2]=0) and ((sx<>sx2) or ((j2+1<>sy) and (j2+1<>sy2)))
              and (j2<sh) do begin
          inc(j2);
          case q of
            2 : begin sy2:=j; sy:=j2 end;
           else begin sy2:=j2; sy:=j end;
          end;
        end;
        pb1Paint(Sender);
        sleep(15);
      end;
    end else begin //kein doppel
      i:=sx;
      j:=sy;
      inc(zuege);
      while (feldy[i,j]=0) and (j<sh) do begin
        inc(j);
        sy:=j;
        pb1Paint(Sender);
        sleep(15);
      end;
    end;
end;

procedure Tfvier.l2Click(Sender: TObject);
var i,j,q,i2,j2:integer;
begin //links
    if doppelspiel then begin
      if sx2<sx then begin
        q:=2;
        i:=sx2;
        j:=sy2;
        i2:=sx;
        j2:=sy;
      end else begin
        q:=1;
        i:=sx;
        j:=sy;
        i2:=sx2;
        j2:=sy2;
      end;
      inc(zuege);
      while ((feldx[i-1,j]=0) and (i>1)) or ((feldx[i2-1,j2]=0) and ((sy<>sy2)
            or ((i2-1<>sx) and (i2-1<>sx2))) and (i2>1)) do begin
        while (feldx[i-1,j]=0) and (i>1) do begin
          dec(i);
          case q of
            2 : sx2:=i;
           else sx:=i;
          end;
        end;
        while (feldx[i2-1,j2]=0) and ((sy<>sy2) or ((i2-1<>sx) and (i2-1<>sx2)))
              and (i2>1) do begin
          dec(i2);
          case q of
            2 : begin sx2:=i; sx:=i2 end;
           else begin sx2:=i2; sx:=i end;
          end;
        end;
        pb1Paint(Sender);
        sleep(15);
      end;
    end else begin //kein doppelspiel
      i:=sx;
      j:=sy;
      inc(zuege);
      while (feldx[i-1,j]=0) and (i>1) do begin
        dec(i);
        sx:=i;
        pb1Paint(Sender);
        sleep(15);
      end;
    end;
end;

procedure Tfvier.d3Click(Sender: TObject);
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
       pb1Paint(Sender);
       sleep(10);
       d3.caption:='Abbruch';
     end else
       d3.caption:='Demonstration';
   end;
end;

procedure Tfvier.Timer2Timer(Sender: TObject);
var cc:char;
begin
    cc:=verlauf[schritt];
    case cc of
      'r' : r1Click(Sender);
      'l' : l2Click(Sender);
      'd' : d1Click(Sender);
      'u' : l1Click(Sender);
     end;
    inc(schritt);
end;

procedure Tfvier.FormDestroy(Sender: TObject);
begin
    kippliste.free;
end;

end.
