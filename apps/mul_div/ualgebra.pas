unit ualgebra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Menus, ExtCtrls, StdCtrls, CheckLst, Grids;

type
  TFalgebra = class(TForm)
    P7: TPanel;
    gleichungx: TPanel;
    schrimul: TPanel;
    P33: TPanel;
    L41: TLabel;
    L17: TLabel;
    L20: TLabel;
    E57: TEdit;
    E58: TEdit;
    PB8: TPaintBox;
    K13: TLabel;
    RG1: TRadioGroup;
    procedure PB8P(Sender: TObject);
    procedure PB9Paint(Sender: TObject);
    procedure RG1Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var  Falgebra: TFalgebra;

implementation

uses   math;
{$R *.DFM}
procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.4E-01;//2.64346095279206E-01;
      bwi=18.0;//14.0
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
    x:=round(bwi*wcos);
    y:=round(bwi*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[0].x:=c+x;
    pfe[0].y:=d-y;
    pfe[1].x:=c;
    pfe[1].y:=d;
    sincos(wi+xwi,wsin,wcos);
    x:=round(bwi*wcos);
    y:=round(bwi*wsin);
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

procedure TFalgebra.PB8P(Sender: TObject);
const rr=21;
var bitmap:tbitmap;
    ziel:tcanvas;
    offset,breite,z,s,i,j,start,ksa,ksb:integer;
    a,b,c,ka,kb,ke:string;
    za,zb,zc:int64;
    xc:array[0..24] of integer;
begin
  if rg1.itemindex=1 then begin
    pb9paint(sender);
    exit;
  end;
  start:=0;                               //Multiplik
  bitmap:=tbitmap.create;
  bitmap.width:=pb8.Width;
  bitmap.height:=pb8.height;
  bitmap.pixelformat:=pf32bit;
  ziel:=bitmap.canvas;

  ziel.font.name:='Verdana';
  ziel.font.size:=20;
  ziel.font.style:=[fsbold];
  ka:=e57.text;
  kb:=e58.text;
  if (length(ka)*length(kb)>0) then begin
    if pos(',',ka)>0 then ka[pos(',',ka)]:='.';
    if pos(',',kb)>0 then kb[pos(',',kb)]:='.';
    ksa:=0;
    ksb:=0;
    if pos('.',ka)>0 then begin
      a:='';
      ksa:=length(ka)-pos('.',ka);
      for i:=1 to length(ka) do
        if ka[i]<>'.' then a:=a+ka[i]
    end
    else a:=ka;
    while (length(a)>1) and (a[1]='0') do delete(a,1,1);
    if pos('.',kb)>0 then begin
      b:='';
      ksb:=length(kb)-pos('.',kb);
      for i:=1 to length(kb) do
        if kb[i]<>'.' then b:=b+kb[i]
    end
    else b:=kb;
    while (length(b)>1) and (b[1]='0') do delete(b,1,1);

    if (length(a)<10) and (length(b)<10) then begin
      za:=strtoint(a);
      zb:=strtoint(b);
      fillchar(xc,sizeof(xc),0);
      breite:=ziel.textwidth(a+'  '+b);
      offset:=(pb8.width-breite-100) div 2;
      s:=20+offset;
      z:=20;
      i:=1;
      repeat
        ziel.textout(s+(i-1)*rr,z,a[i]);
        inc(i);
      until i>length(a);
      ziel.textout(s+i*rr,z,'·');
      s:=s+i*rr+rr;
      for i:=1 to length(b) do ziel.textout(s+(i-1)*rr,z,b[i]);
      ziel.pen.width:=2;
      ziel.moveto(10+offset,55);
      ziel.lineto(breite+90+offset,55);

      for i:=1 to length(b) do begin
        zc:=za*strtoint(b[i]);
        c:=inttostr(zc);
        for j:=length(c) downto 1 do
          xc[length(c)-j+1+length(b)-i]:=xc[length(c)-j+1+length(b)-i]+strtoint(c[j]);
        if length(c)>length(a) then s:=20-rr+offset+i*rr
                               else s:=20+offset+i*rr;
        if i=1 then start:=s;
        z:=36+i*30;
        if c='0' then ziel.textout(s+(length(a)-1)*rr,z,'0')
        else
          for j:=1 to length(c) do ziel.textout(s+(j-1)*rr,z,c[j]);
        if i>1 then ziel.textout(20-2*rr+offset,z,'+');
        ziel.font.color:=clred;
        ziel.font.size:=16;
        ziel.textout(pb8.width-60-ziel.textwidth(a),z,a+' · '+b[i]);
        ziel.pen.width:=1;
        xpfeilvoll(bitmap.canvas,pb8.width-60-ziel.textwidth(a)-10,z+ziel.textheight(a) div 2,
                          pb8.width-60-ziel.textwidth(a)-50,z+ziel.textheight(a) div 2);
        ziel.pen.width:=2;
        ziel.font.size:=20;
        ziel.font.color:=clblack;
      end;
      z:=36+length(b)*30+60;
      ziel.moveto(10+offset,z);
      ziel.lineto(breite+90+offset,z);
      zc:=za*zb;
      c:=inttostr(zc);
      for i:=1 to length(c) do ziel.textout(start+(i-1)*rr,z+10,c[i]);
      ke:=c;
      if ksa+ksb>0 then begin
        while length(ke)<ksa+ksb+1 do ke:='0'+ke;
        ke:=copy(ke,1,length(ke)-ksa-ksb)+','+copy(ke,length(ke)-ksa-ksb+1,255);
      end;
      ziel.textout(-6*rr+offset-30,z+75,'Ergebnis = ');
      ziel.textout(start,z+75,ke);
      ziel.font.color:=clblue;
      ziel.font.size:=10;
      for i:=1 to 23 do begin
        if xc[i] div 10>0 then begin
          ziel.textout(start+(length(c)-i-1)*rr+5,z-20,inttostr(xc[i] div 10));
          xc[i+1]:=xc[i+1]+(xc[i] div 10);
        end;
      end;
      ziel.font.style:=[];
      ziel.textout(-2*rr+offset-30,z-20,'Übertrag');
      ziel.textout(-6*rr+offset-30,z+50,'Gesamtkommastellen = '+inttostr(ksa+ksb));
    end;
  end;
  pb8.Canvas.draw(0,0,bitmap);
  bitmap.free;
end;

function ein_int(const edit:tedit):integer;
var kk:string;
    x:integer;
    code:integer;
begin
  kk:=edit.text;
  val(kk,x,code);
  if code<>0 then ein_int:=0
             else ein_int:=x;
end;

procedure TFalgebra.PB9Paint(Sender: TObject);      //divis
var bitmap:tbitmap;
    komma:boolean;
    q,z,i,ziffern,periodenlaenge,strichende,strichan:integer;
    x,y,xalt,l,l2,v,anz:int64;
    ergebnis,k,ka,kb:string;
    ziel:tcanvas;
  procedure strich(a,b:integer;const k:string);
  begin
    ziel.moveto(a-4,b+29);
    ziel.lineto(a-4+ziel.textwidth(k)+20,b+29);
    inc(z,33);
  end;
  procedure periodenermittlung(a,b:integer);
  var ci,a1,b1,m,n,e,s,r:int64;
      q:string;
  begin
    ci:=b;
    a1:=a;
    b1:=b;
    m:=0;
    q:='';
    while ci mod 2 = 0 do begin
      ci:=ci div 2;
      m:=m+1;
    end;
    Ci:=round(B);
    N:=0;
    while ci mod 5 = 0 do begin
      ci:=ci div 5;
      n:=n+1;
    end;
    if n>m then m:=n;
    e:=a1 div b1;
    ziffern:=length(inttostr(E));
    q:='';
    a1:=a1 mod b1;
    a1:=10*a1;
    if m>0 then q:='';
    while (M > 0) do begin
      e:=a1 div b1;
      q:=q+inttostr(e);
      a1:=a1 mod b1;
      a1:=10*a1;
      m:=m-1;
    end;
    Z:=1;
    ziffern:=ziffern+length(q);
    q:='';
    r:=a1 mod b1;
    e:=a1 div b1;
    S:= -1;
    Q:= Q+inttostr(E);
    a1:=a1 mod b1;
    a1:=10*a1;
    while ((S<>R) and (Z < 100)) do begin
      e:=a1 div b1;
      s:=a1 mod b1;
      if s<>r then q:=q+inttostr(e);
      a1:=a1 mod b1;
      a1:=a1*10;
      Z:=Z+1;
    end;
    z:=z-1;
    if (Z < 99) then begin
      ziffern:=ziffern+z;
      if q='0' then periodenlaenge:=0
               else periodenlaenge:=length(q)
    end else begin
      ziffern:=1000;
      periodenlaenge:=0
    end;
  end;
begin
  bitmap:=tbitmap.create;
  bitmap.width:=pb8.Width;
  bitmap.height:=pb8.height;
  bitmap.pixelformat:=pf32bit;
  ziel:=bitmap.canvas;
  ziel.font.name:='Verdana';
  ziel.font.size:=16;
  ziel.font.style:=[fsbold];
  ziel.font.color:=clblack;
  ziel.pen.width:=2;
  x:=ein_int(e57);
  y:=ein_int(e58);
  if (x*y>0) and (x>0) then begin
    periodenermittlung(x,y);
    z:=50;
    v:=0;
    ziel.textout(40,20,inttostr(x)+' : '+inttostr(y)+' = ');
    ergebnis:=inttostr(trunc(x/y));
    if x mod y <> 0 then ergebnis:=ergebnis+',';
    ziffern:=ziffern-length(ergebnis);
    ka:=inttostr(x);
    xalt:=x;
    kb:=inttostr(y);
    komma:=false;
    if x<y then begin
      x:=x*10;
      komma:=true;
      while x<y do begin
        x:=x*10;
        ergebnis:=ergebnis+'0';
        ziffern:=ziffern-1;
      end;
      ziel.textout(40,z,inttostr(x));
      inc(z,26);
    end;
    anz:=0;
    repeat
      if not komma then begin
        if x<y then begin
          x:=x*10;
          if not komma then komma:=true;
        end;
      end;
      if komma and (x<y) then begin
        while x<y do begin
          x:=x*10;
          ergebnis:=ergebnis+'0';
          ziffern:=ziffern-1;
        end;
        ziel.textout(40+v,z,inttostr(x));
        inc(z,26);
      end;
      q:=(x div y);
      k:=inttostr(q);
      q:=strtoint(k[1]);
      ka:=inttostr(x);
      kb:=inttostr(q*y);
      if ka<kb then begin
        ziel.textout(22+v+ziel.textwidth(ka[1]),z,'- '+kb);
        strich(22+v+ziel.textwidth(ka[1]),z,'- '+kb);
      end else begin
        ziel.textout(22+v,z,'- '+kb);
        strich(22+v,z,'- '+kb);
      end;
      q:=(x div y);
      k:=inttostr(q);
      if komma then begin
        ergebnis:=ergebnis+k[1];
        ziffern:=ziffern-1;
      end;
      q:=strtoint(k[1]);
      if length(k)>1 then
        for i:=1 to length(k)-1 do q:=q*10;
      x:=x-q*y;
      l:=length(ka);
      l2:=length(inttostr(x));
      if l<>l2 then
        for i:=1 to l-l2 do v:=v+ziel.textwidth(ka[i]);
      if x<y then komma:=true;
      if komma then begin
        ziel.textout(40+v,z,inttostr(x)+'0');
        x:=x*10;
      end
      else ziel.textout(40+v,z,inttostr(x));
      inc(z,26);
      if z+120>pb8.height then begin
        z:=50;
        v:=v+ziel.textwidth(kb);
        ziel.textout(40+v,z,inttostr(x));
        inc(z,26);
      end;
      inc(anz);
    until (anz>25) or (x=0) or (ziffern<0);
    ziel.font.color:=clred;
    ziel.textout(50+ziel.textwidth(inttostr(xalt)+' : '+inttostr(y)+' = '),20,ergebnis);
    if (periodenlaenge>0) and (periodenlaenge<25) then begin
      strichende:=50+ziel.textwidth(inttostr(xalt)+' : '+inttostr(y)+' = '+ergebnis);
      ergebnis:=copy(ergebnis,length(ergebnis)-periodenlaenge+1,periodenlaenge);
      strichan:=strichende-ziel.textwidth(ergebnis);
      ziel.pen.color:=clred;
      ziel.moveto(strichan,18);
      ziel.lineto(strichende,18);
    end;
  end;
  pb8.Canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure TFalgebra.RG1Click(Sender: TObject);
begin
  case rg1.itemindex of
    0 : begin
          l41.caption:='Schriftliche Multiplikation zweier Zahlen';
          e57.text:='145,8';
          e58.text:='14,03';
        end;
   else begin
          l41.caption:='Schriftliche Division zweier natürlicher Zahlen';
          e57.text:='1458';
          e58.text:='143';
        end;
  end;
  pb8p(sender);
end;

end.

