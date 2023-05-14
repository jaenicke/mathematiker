unit sortier;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, Dialogs;

type
  Tfsortier = class(TForm)
    MM1: TMainMenu;
    M1: TMenuItem;
    sortier: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    PB5: TPaintBox;
    PB1: TPaintBox;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    LB1: TListBox;
    D1: TButton;
    D2: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure S7Click(Sender: TObject);
    procedure T3Change(Sender: TObject);
    procedure PB5Paint(Sender: TObject);
    procedure D18Click(Sender: TObject);
    procedure Panel4Resize(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fsortier: Tfsortier;

implementation

{$R *.DFM}

type sfeld = array of integer;
const abbruch:boolean =true;
var felder:integer;
    vergleiche,vertauschungen:int64;
    xfeld : sfeld;

procedure Tfsortier.S7Click(Sender: TObject);
begin
    if abbruch=false then
    begin
      abbruch:=true;
      d1.caption:='Sortieren';
    end
    else
    begin
      setlength(xfeld,0);
      close;
    end;
end;

procedure Tfsortier.T3Change(Sender: TObject);
var i:integer;
begin
    if abbruch=false then
    begin
      abbruch:=true;
      d1.caption:='Sortieren';
    end
    else
    begin
      felder:=updown1.position;
      case radiogroup1.itemindex of
        0 : for i:=1 to felder do xfeld[i]:=random(20000);
        1 : for i:=1 to felder do xfeld[i]:=round(20000.0*(felder-i)/felder);
        2 : for i:=1 to felder do xfeld[i]:=round(20000.0*i/felder);
        3 : begin
              for i:=1 to felder div 2 do xfeld[i]:=round(40000.0*i/felder);
              for i:=felder div 2 +1 to felder do xfeld[i]:=round(40000.0*(felder-i)/felder);
            end;
        4 : begin
              for i:=1 to felder div 2 do xfeld[i]:=round(40000.0*(felder-i)/felder-20000);
              for i:=felder div 2 +1 to felder do xfeld[i]:=round(40000.0*i/felder-20000);
            end;
        5 : begin
              for i:=1 to felder div 3 do xfeld[i]:=round(20000.0*i/felder);
              for i:=felder div 3 +1 to 2*(felder div 3) do xfeld[i]:=random(6666)+6666;
              for i:=2*(felder div 3) +1 to felder do xfeld[i]:=round(20000.0*i/felder);
            end;
        6 : for i:=1 to felder do begin
              if odd(i) then xfeld[i]:=random(20000)
                        else xfeld[i]:=round(20000.0*i/felder);
            end;
        7 : for i:=1 to felder do begin
              if odd(i) then xfeld[i]:=round(20000.0*(felder-i)/felder)
                        else xfeld[i]:=round(20000.0*i/felder);
            end;
      end;
      pb5paint(sender);
    end;
end;

procedure Tfsortier.PB5Paint(Sender: TObject);
var bitmap:tbitmap;
    b,i,y,z:integer;
begin
    Bitmap := TBitmap.Create;
    Bitmap.Width := pb5.Width+1;
    Bitmap.Height := pb5.Height+1;
    bitmap.canvas.font.name:='Verdana';
    b:=pb5.width;
    bitmap.canvas.brush.color:=clblack;
    bitmap.canvas.rectangle(-1,-1,b+1,b+1);
    for i:=1 to felder do
    begin
      z:=round(b-xfeld[i]/20000*b);
      y:=round(1.0*b/felder*i);
      bitmap.canvas.Pixels[y,z]:=clyellow;
    end;
    pb5.canvas.draw(0,0,bitmap);
    Bitmap.Free;
end;

procedure Tfsortier.D18Click(Sender: TObject);
var b:integer;
    ausw:integer;
    h,h1,h2:integer;
    zz:dword;
    k:string;
procedure pix0(x,z:integer);
begin
    pb5.canvas.pixels[x,round(b-xfeld[z]/20000*b)]:=0;
end;
procedure pixyellow(x,z:integer);
begin
    pb5.canvas.pixels[x,round(b-xfeld[z]/20000*b)]:=clyellow;
end;
procedure lo(i,j:integer);
begin
    h1:=round(1.0*b/felder*i);
    h2:=round(1.0*b/felder*j);
    pix0(h1,i);
    pix0(h2,j);
end;
procedure se(i,j:integer);
begin
    pixyellow(h1,i);
    pixyellow(h2,j);
end;
procedure lo1(i:integer);
begin
    h1:=round(1.0*b*i/felder);
    pix0(h1,i);
end;
procedure se1(i:integer);
begin
//    h1:=round(1.0*b*i/felder);
    pixyellow(h1,i);
end;
procedure tauschen(a,b:integer);
begin
    lo(a,b);
    h:=xfeld[a];
    xfeld[a]:=xfeld[b];
    xfeld[b]:=h;
    se(a,b);
    inc(vertauschungen,2);
end;

procedure bubble;
var i,j:integer;
begin
    for i:=2 to felder do
    begin
      for j:=felder downto i do
      begin
        if xfeld[j-1]>xfeld[j] then tauschen(j-1,j);
        inc(vergleiche);
      end;
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;
procedure bubble2;
var i,j:integer;
begin
    for i:=1 to felder-1 do
    begin
      for j:=i+1 to felder do
      begin
        if xfeld[i]>xfeld[j] then tauschen(i,j);
        inc(vergleiche);
      end;
      application.ProcessMessages;
      if abbruch then exit;
      lo1(i);
      se1(i);
    end;
end;
procedure binein;
var i,j,r,l,m,xx:integer;
begin
    for i:=2 to felder do
    begin
      xx:=xfeld[i];
      l:=1;
      r:=i-1;
      inc(vergleiche);
      while l<=r do
      begin
        m:=(l+r) div 2;
        if xx<xfeld[m] then r:=m-1
                       else l:=m+1;
        inc(vergleiche);
      end;
      for j:=i-1 downto l do
      begin
        lo1(j+1);
        xfeld[j+1]:=xfeld[j];
        inc(vertauschungen);
        se1(j+1);
        end;
      application.ProcessMessages;
      if abbruch then exit;
      lo1(l);
      xfeld[l]:=xx;
      inc(vertauschungen);
      se1(l);
    end;
end;

procedure bsort(l,r,m:integer);
var li,re,xx:boolean;
    gr,i,j:integer;
begin
    application.ProcessMessages;
    if abbruch then exit;
    if l<r then
    begin
      li:=false;
      re:=false;
      xx:=true;
      i:=l;
      j:=r;
      while xx do
      begin
        while (xfeld[i]<m) and (i<>j) do
        begin
          inc(vergleiche);
          if i<>l then
          begin
            inc(vergleiche);
            if xfeld[i-1]>xfeld[i] then
            begin
              tauschen(i-1,i);
              li:=true;
            end;
          end;
          inc(i);
        end;
        while (xfeld[j]>=m) and (i<>j) do
        begin
          inc(vergleiche);
          if j<>r then
          begin
            inc(vergleiche);
            if xfeld[j]>xfeld[j+1] then
            begin
              tauschen(j+1,j);
              re:=true;
            end;
          end;
          dec(j);
        end;
        if i<>j then tauschen(j,i)
        else
        begin
          inc(vergleiche);
          if xfeld[j]>=m then
          begin
            inc(vergleiche);
            if xfeld[j]>xfeld[j+1] then
            begin
              tauschen(j,j+1);
              re:=true;
            end;
          end
          else
          begin
            inc(vergleiche);
            if xfeld[i-1]>xfeld[i] then
            begin
              tauschen(i,i-1);
              li:=true;
            end;
            inc(vergleiche);
            if xfeld[i-2]>xfeld[i-1] then tauschen(i-2,i-1);
          end;
          xx:=false;
        end;
      end;
      gr:=i-l;
      if gr>2 then
      begin
        if li then
        begin
          if gr=3 then
          begin
            inc(vergleiche);
            if xfeld[l]>xfeld[l+1] then tauschen(l+1,l);
          end
          else bsort(l,i-2,xfeld[(l+i-2) div 2]);
        end;
      end;
      gr:=r-j+1;
      if gr>2 then
      begin
        if re then
        begin
          if gr=3 then
          begin
            inc(vergleiche);
            if xfeld[j+1]>xfeld[j+2] then tauschen(j+1,j+2);
          end
          else bsort(j+1,r,xfeld[(j+r+1) div 2]);
        end;
      end;
    end;
end;

PROCEDURE combsort(sf:real);
VAR i,gap,top : integer;
    sorted : boolean;
BEGIN
    gap:=felder;
    abbruch:=false;
    repeat
      gap:=trunc(gap/sf);
      if gap=0 then gap:=1;
      sorted:=true;
      top:=felder-gap;
      for i:=1 to top do
      begin
        inc(vergleiche);
        if xfeld[i]>xfeld[i+gap] then
        begin
          tauschen(i,i+gap);
          sorted:=false;
        end;
      end;
      application.ProcessMessages;
      if abbruch then exit;
    until sorted and (gap=1);
END;

procedure ripple;
var i,j:integer;
begin
    for i:=1 to felder do
    begin
      for j:=1 to felder-1 do
      begin
        inc(vergleiche);
        if xfeld[i]<=xfeld[j] then tauschen(i,j);
      end;
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;
procedure v3;
var i,j:integer;
begin
    for i:=1 to felder-1 do
    begin
      for j:=i+1 to felder do
      begin
        inc(vergleiche);
        if xfeld[i]>=xfeld[j] then tauschen(i,j);
      end;
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;
procedure insert;
var i,j:integer;
    hh:integer;
begin
    for i:=2 to felder do
    begin
      hh:=xfeld[i];
      lo1(1);
      xfeld[1]:=hh;
      inc(vertauschungen);
      se1(1);
      j:=i-1;
      inc(vergleiche);
      while hh<xfeld[j] do
      begin
        inc(vergleiche);
        lo1(j+1);
        xfeld[j+1]:=xfeld[j];
        inc(vertauschungen);
        se1(j+1);
        j:=j-1
      end;
      lo1(j+1);
      xfeld[j+1]:=hh;
      inc(vertauschungen);
      se1(j+1);
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;

procedure select;
var i,j,k:integer;
    hh:integer;
begin
    for i:=1 to felder do
    begin
      hh:=xfeld[i];
      k:=i;
      for j:=felder downto i+1 do begin
        inc(vergleiche);
        if xfeld[j]<hh then
        begin
          k:=j;
          hh:=xfeld[j];
        end;
      end;
      lo(i,k);
      xfeld[k]:=xfeld[i];
      xfeld[i]:=hh;
      inc(vertauschungen,2);
      se(i,k);
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;

procedure quick;
procedure partit(llo,up:integer);
var i,j:integer;
    xx:integer;
begin
    i:=llo;
    j:=up;
    xx:=xfeld[(llo+up) div 2];
    repeat
      while xfeld[i]<xx do begin i:=i+1; inc(vergleiche); end;
      while xx<xfeld[j] do begin j:=j-1; inc(vergleiche); end;
      if i<=j then
      begin
        tauschen(i,j);
        i:=i+1;
        j:=j-1;
      end;
    until i>j;
    if llo<j then partit(llo,j);
    if i<up then partit(i,up);
    application.ProcessMessages;
    if abbruch then exit;
end;
begin
    partit(1,felder);
end;

procedure heap;
var llo,up:integer;
procedure sift;
label 99;
var i,j,xx:integer;
begin
    i:=llo;
    j:=2*i;
    xx:=xfeld[i];
    while j<=up do
    begin
      if j<up then begin
        inc(vergleiche);
        if xfeld[j]<xfeld[j+1] then j:=j+1;
      end;
      inc(vergleiche);
      if xx>=xfeld[j] then goto 99;
      lo1(i);
      xfeld[i]:=xfeld[j];
      inc(vertauschungen);
      se1(i);
      i:=j;
      j:=2*i;
    end;
99: lo1(i);
    xfeld[i]:=xx;
    inc(vertauschungen);
    se1(i);
end;
begin
    llo:=felder div 2 +1;
    up:=felder;
    while llo>1 do
    begin
      llo:=llo-1; sift;
      application.ProcessMessages;
      if abbruch then exit;
    end;
    while up>1 do
    begin
      tauschen(llo,up);
      up:=up-1;
      sift;
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;

procedure heapsort;
var i:integer;
procedure reheap(i,k:integer);
label 99;
var j,xx:integer;
    r:integer;
begin
    j:=i;
    while 2*j<k do
    begin
     inc(vergleiche);
     if xfeld[2*j]>xfeld[2*j+1] then j:=2*j
                                 else j:=2*j+1;
    end;
    if 2*j=k then j:=k;
    while xfeld[i]>xfeld[j] do begin j:=j div 2; inc(vergleiche) end;
    r:=xfeld[j];
    lo1(j);
    xfeld[j]:=xfeld[i];
    inc(vertauschungen);
    se1(j);
    j:=j div 2;

    while j>=i do
    begin
      lo1(j);
      xx:=xfeld[j];
      xfeld[j]:=r;
      inc(vertauschungen);
      r:=xx;
      se1(j);
      j:=j div 2;
    end;
end;

begin
    for i:=(felder div 2) downto 1 do reheap(i,felder);
    application.ProcessMessages;
    if abbruch then exit;
    for i:=felder downto 2 do
    begin
      tauschen(1,i);
      reheap(1,i-1);
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;

procedure shell;
var d,i,j,xx:integer;
begin
    d:=felder;
    while d>1 do
    begin
      if d<5 then d:=1
             else d:=(5*d-1) div 11;
      for i:=felder-d downto 1 do
      begin
        j:=i+d;
        xx:=xfeld[i];
        while (j<=felder) and (xx>xfeld[j]) do
        begin
          inc(vergleiche);
          lo1(j-d);
          xfeld[j-d]:=xfeld[j];
          inc(vertauschungen);
          se1(j-d);
          j:=j+d
        end;
        lo1(j-d);
        xfeld[j-d]:=xx;
        inc(vertauschungen);
        se1(j-d);
        application.ProcessMessages;
        if abbruch then exit;
      end;
    end
end;

PROCEDURE ShakerSort;
VAR j,k,l,r:integer;
    getauscht:Boolean;
BEGIN
    l:=2;
    r:=felder;
    k:=felder;
    REPEAT
      getauscht:=False;
      FOR j:=r DOWNTO l DO
      BEGIN
        inc(vergleiche);
        IF xfeld[j-1] > xfeld[j] THEN
        BEGIN
          tauschen(j-1,j);
          k:=j;
          getauscht:=True
        END;
      END;
      l:=k+1;
      getauscht:=getauscht OR False;
      FOR j:=l TO r DO
      BEGIN
        inc(vergleiche);
        IF xfeld[j-1] > xfeld[j] THEN
        BEGIN
          tauschen(j-1,j);
          k:=j;
          getauscht:=True
        END;
      END;
      r:=k-1;
      application.ProcessMessages;
      if abbruch then exit;
    UNTIL (l>r) OR NOT getauscht
END;

procedure stoogesort(i,j:integer);
var m:integer;
begin
    if abbruch then exit;
    inc(vergleiche);
    if xfeld[i]>xfeld[j] then begin
      tauschen(i,j);
      application.ProcessMessages;
    end;
    if j-i>2 then begin
      m:=(j-i) div 3;
      stoogesort(i,j-m);
      stoogesort(i+m,j);
      stoogesort(i,j-m);
    end;
end;

procedure bitonicmerge(l,r:integer;asc:boolean);
var q,k,i:integer;
begin
  if abbruch then exit;
  if (l<r) then
  begin
     q:=(l+r) div 2;
     k:=q-l+1;
     for i:= l to q do begin
       inc(vergleiche);
       if (xfeld[i] > xfeld[i+k]) = asc then tauschen(i,i+k);
     end;
     bitonicmerge(l, q, asc);
     bitonicmerge(q+1, r, asc);
  end;
end;

procedure bitonicsort(l,r:integer);
var m,i:integer; asc:boolean;
begin
   m:=2;
   repeat
     asc:= true;
     i:= l;
     repeat
       bitonicmerge(i,i+m-1,asc);
       application.ProcessMessages;
       if abbruch then exit;
       asc:= not asc;
       i:=i+m;
     until i>r;
     m:=2*m;
   until m>r-l+1;
end;

procedure oet(l,r:integer);
begin
    if abbruch then exit;
    if (l < r) then
    begin
      oet(l+2, r);
      inc(vergleiche);
      if (xfeld[l] > xfeld[l+1]) then begin
        tauschen(l,l+1);
      end;
    end;
end;

procedure oetsort(l,r,k:integer);
begin
    if (k >= l) then
    begin
      oetsort(l, r, k-1);
      oet(l+(k mod 2),r);
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;

procedure simplesort(l,r:integer);
var i,j:integer;
begin
   for i:=r downto l+1 do begin
     for j:=l to i-1 do begin
       inc(vergleiche);
       if (xfeld[j] >= xfeld[i]) then tauschen(j,i);
     end;
     application.ProcessMessages;
     if abbruch then exit;
   end;
end;

procedure jumpsort;
var i,j,q:integer;
begin
    for i:=felder downto 2 do
    begin
      q:=1;
      for j:=1 to i-1 do
      begin
        inc(vergleiche);
        if (xfeld[j+1] < xfeld[q]) then tauschen(j+1,q);
        q:=j+1;
      end;
      tauschen(q,i);
      application.ProcessMessages;
      if abbruch then exit;
    end;
end;

procedure sortieren;
var zwei,i:integer;
begin
    zz:=gettickcount;
    case ausw of
      0 : bubble;
      1 : bubble2;
      2 : jumpsort;
     17 : simplesort(1,felder);
      3 : ripple;
      4 : insert;
      5 : binein;
      6 : select;
      7 : quick;
      8 : heap;
      9 : heapsort;
     10 : shell;
     11 : shakersort;
     12 : bsort(1,felder,xfeld[(felder+1) div 2]);
     13 : combsort(1.4);
     14 : stoogesort(1,felder);
     15 : begin
            zwei:=1;
            while zwei<felder do zwei:=2*zwei;
            for i:=felder to zwei do xfeld[i]:=32767;
            bitonicsort(1,zwei);
          end;
     16 : oetsort(1,felder,felder);
   end;
   zz:=gettickcount-zz;
end;

begin
    if abbruch=false then
    begin
      abbruch:=true;
      d1.caption:='Sortieren';
    end
    else
    begin
      abbruch:=false;
      d1.caption:='Abbruch !';

      b:=pb5.width;
      k:=lb1.items[lb1.itemindex];

      ausw:=strtoint(copy(k,pos(#9,k)+1,255));
      if ausw<0 then ausw:=0;

      vergleiche:=0;
      vertauschungen:=0;
      Label8.caption:='0 s';
      Label7.caption:=inttostr(vergleiche);
      Label6.caption:=inttostr(vertauschungen);

      sortieren;
      Label8.caption:=floattostr(zz/1000)+' s';
      if vergleiche>1e6 then
        Label7.caption:=floattostrf(vergleiche/1e6,ffgeneral,4,4)+' Mill.'
      else
        Label7.caption:=inttostr(vergleiche);
      if vertauschungen>1e6 then
        Label6.caption:=floattostrf(vertauschungen/1e6,ffgeneral,4,4)+' Mill.'
      else
        Label6.caption:=inttostr(vertauschungen);

      abbruch:=true;
      d1.caption:='Sortieren';
    end;
end;

procedure Tfsortier.Panel4Resize(Sender: TObject);
var h:integer;
begin
     h:=Panel4.height-50;
     pb5.top:=25;
     pb5.width:=h;
     pb5.height:=h;
     pb5.left:=(Panel4.width-h) div 2;
     panel1.top:=pb5.top+pb5.height;
     panel1.left:=pb5.left;
     pb1.width:=(Panel4.width-h) div 2;
end;

procedure Tfsortier.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
procedure CanvasSetAngle(C: TCanvas; A: Single);
var LogRec: TLOGFONT;
begin
  GetObject(C.Font.Handle,sizeOf(LogRec),Addr(LogRec));
  LogRec.lfEscapement := Trunc(A*10);
  C.Font.Handle := CreateFontIndirect(LogRec);
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height;
    bitmap.canvas.brush.color:=clblack;
    bitmap.canvas.rectangle(-1,-1,bitmap.width+1,bitmap.height+1);
    bitmap.Canvas.font.name:='Verdana';
    bitmap.Canvas.font.color:=clwhite;
    bitmap.Canvas.font.size:=8;
    CanvasSetAngle(bitmap.Canvas,90);
    bitmap.Canvas.textout(bitmap.width-25,120,'Elementgröße');
    pb1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tfsortier.FormActivate(Sender: TObject);
begin
  setlength(xfeld,20010);
  randomize;
  lb1.itemindex:=0;
  t3change(sender);
  pb5paint(sender);
end;

procedure Tfsortier.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  t3change(sender);
end;

end.


