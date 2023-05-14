unit ulsystem;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ExtDlgs, Grids, Buttons, Menus;

type
  TFLsystem = class(TForm)
    lsystem: TPanel;
    PBox: TPaintBox;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Button1: TButton;
    Button3: TButton;
    Button2: TButton;
    eaxiom: TEdit;
    SG3: TStringGrid;
    SG2: TStringGrid;
    CB2: TCheckBox;
    LBox: TListBox;
    ewinkel: TEdit;
    ename: TEdit;
    R1: TRadioButton;
    R2: TRadioButton;
    eitera: TEdit;
    CB1: TCheckBox;
    procedure Formshow(Sender: TObject);
    procedure LBClick(Sender: TObject);
    procedure lsystempaint(canvas:tcanvas);
    procedure B1Darst(Sender: TObject);
    procedure B3Spei(Sender: TObject);
    procedure B2Loesch(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    lh1:tstringlist;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var   FLsystem: TFLsystem;

implementation

uses clipbrd, math;

{$R *.DFM}
const
    superfarben: array[0..28] of longint =
         ($00000000,$00800000,$000000FF,$00FF00FF,$00008000,$00800080,$0000FFFF,$00404040,
          $0000FF00,$00cccccc,$00808080,$00ff0000,$00000080,$00ffff00,$00008080,$00c0c0c0,
          $00808000,$000000c0,$0000c000,$00c00000,$0000c0c0,$00c000c0,$00c0c000,$00FFFFCC,
          $00CCFFFF,$00CCFFCC,$00CCCCFF,$00ffffff,$00cccc99);
    hstring : array[0..8] of string[2] =
       ('F=','G=','X=','Y=','L=','R=','A=','B=','H=');
    pino = pi/180;

type
      link=^node;
      node=record
               value:extended;
               next:link;
             end;
      stack=object
        sp:link;
        constructor init;
        procedure push(v:extended);
        procedure pop(var v:extended);
        function empty:boolean;
        destructor bye;
      end;
var
     ostack : ^stack;
     labbruch : boolean;

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

constructor stack.init;
begin
  new(sp);
  sp^.next:=nil;
end;
function stack.empty:boolean;
begin
  empty:=sp^.next=nil;
end;
procedure stack.push(v:extended);
var t:link;
begin
  new(t);
  t^.value:=v;
  t^.next:=sp^.next;
  sp^.next:=t
end;
procedure stack.pop(var v:extended);
var t:link;
begin
  t:=sp^.next;
  v:=t^.value;
  sp^.next:=t^.next;
  dispose(t)
end;
destructor stack.bye;
var v:extended;
begin
  while not empty do
    pop(v);
  dispose(sp);
end;

procedure TFLsystem.Formshow(Sender: TObject);
var kk:string;
    lnr,i:integer;
begin
  labbruch:=true;
  lh1:=tstringlist.Create;
  for i:=0 to 8 do sg3.cells[0,i]:=hstring[i];
  lh1.loadfromfile(extractfilepath(application.exename)+'mchaos.txt');
  LBox.clear;
  lnr:=0;
  repeat
    kk:=lh1[lnr];
    inc(lnr);
    if (length(kk)>0) and (kk[1]='*') then LBox.items.add(copy(kk,2,250));
    until (lnr>lh1.count-1);
  LBox.itemindex:=0;
  LBclick(sender);
end;

procedure TFLsystem.LBClick(Sender: TObject);
var sel,i,lnr:integer;
    kk,kp,kp2:string;
    gefunden:boolean;
begin
  sel:=LBox.itemindex;
  if sel>=0 then begin
    kk:='*'+LBox.items[sel];
    ename.text:=LBox.items[sel];
    lnr:=0;
    gefunden:=false;
    repeat
      kp:=lh1[lnr];
      inc(lnr);
      if (kp=kk) then begin
        gefunden:=true;
        for i:=0 to 10 do sg2.cells[0,i]:='';
        kp:=lh1[lnr];
        inc(lnr);
        ewinkel.text:=kp;
        kp:=lh1[lnr];
        inc(lnr);
        eaxiom.text:=kp;
        repeat
          kp:=lh1[lnr];
          inc(lnr);
          if pos('=',kp)>0 then begin
            kp2:=copy(kp,3,250);
            case kp[1] of
             'F' : sg2.cells[0,0]:=kp2;
             'G' : sg2.cells[0,1]:=kp2;
             'X' : sg2.cells[0,2]:=kp2;
             'Y' : sg2.cells[0,3]:=kp2;
             'L' : sg2.cells[0,4]:=kp2;
             'R' : sg2.cells[0,5]:=kp2;
             'A' : sg2.cells[0,6]:=kp2;
             'B' : sg2.cells[0,7]:=kp2;
             'H' : sg2.cells[0,8]:=kp2;
            end;
          end;
        until (lnr>lh1.count-1){eof(dd)} or (kp[1]='*');
      end;
    until (lnr>lh1.count-1){eof(dd)} or gefunden;
  end;
end;

procedure TFLsystem.lsystempaint(canvas:tcanvas);
const hgrenze = 800000;
var   p,q:integer;
      i,i0,x1,y1,x2,y2,su,vierbild,pbreite,phoehe:integer;
      fehler,nicht,reverse,vierbilder:boolean;
      f:string;
      w,w1,l,l0,x,y,xl,xr,xo,xu,faktor:extended;
      f12,f13,f14:extended;
      dest:trect;
      kk,superaxiom,superaxiom2,farbaxiom:string;
      regeln:array[0..8] of string[150];
      farbe : byte;
      t1x,t2x,frequenz : TLargeInteger;

  procedure zeichne(zei:boolean);
  var cosw,sinw:extended;
  begin
    sinw:=l*sin(w);
    cosw:=l*cos(w);
    x2:=round(x+cosw);
    y2:=round(y+sinw);
    if not nicht then begin
      if zei then begin
        x1:=round(x);
        y1:=round(y);
        canvas.moveto(x1,y1);
        canvas.lineto(x2,y2);
      end
      else
        canvas.moveto(x2,y2);
    end else begin
      if x<xl then xl:=x;
      if x>xr then xr:=x;
      if x2<xl then xl:=x2;
      if x2>xr then xr:=x2;
      if y<xo then xo:=y;
      if y>xu then xu:=y;
      if y2<xo then xo:=y2;
      if y2>xu then xu:=y2;
    end;
    x:=x+cosw;
    y:=y+sinw;
  end;

  procedure axiom;
  var art,ww:byte;
      s:char;
      i:integer;
      k:string;
      wy:double;
      code:integer;
  begin
    i:=1;
    repeat
      s:=f[i];
      case s of
        '+' :  begin
                 if reverse then w:=w-w1
                            else w:=w+w1;
               end;
        '-' :  begin
                 if reverse then w:=w+w1
                            else w:=w-w1;
               end;
        '|' :  w:=w+pi;
        'C' :  begin
                 farbe:=(farbe+1) mod 16;
                 canvas.pen.color:=superfarben[farbe]
               end;
        '!' :  reverse:=not reverse;
        '[' :  begin
                 ostack^.push(x);
                 ostack^.push(y);
                 ostack^.push(w);
                 ostack^.push(l);
               end;
        ']' :  begin
                 ostack^.pop(l);
                 ostack^.pop(w);
                 ostack^.pop(y);
                 ostack^.pop(x);
               end;
        '<' :  begin
                 ww:=strtoint(f[i+1]+f[i+2]);
                 inc(i,2);
                 if ww=0 then ww:=10;
                 l:=l*ww/10;
                 if l>maxint then l:=maxint;
               end;
        '>' :  begin
                 ww:=strtoint(f[i+1]+f[i+2]);
                 inc(i,2);
                 if ww=0 then ww:=10;
                 l:=10*l/ww;
                 if l>maxint then l:=maxint;
                 if l=0 then l:=1;
               end;
       '@' :  begin
                case f[i+1] of
                 'Q' : begin
                         art:=2;
                         inc(i)
                       end;
                 'I' : begin
                         art:=3;
                         inc(i)
                       end;
                  else art:=1;
                end;
                inc(i,1);
                k:='';
                while (f[i] in ['0'..'9','.']) do begin
                  k:=k+f[i];
                  inc(i)
                end;
                val(k,wy,code);
                dec(i);
                case art of
                  2 : l:=l*sqrt(wy);
                  3 : l:=l/wy;
                 else l:=l*wy;
                end;
              end;
       '/' :  begin
                inc(i,1);
                k:='';
                while f[i] in ['0'..'9','.'] do begin
                  k:=k+f[i];
                  inc(i)
                end;
                val(k,wy,code);
                dec(i);
                if reverse then w:=w-pino*wy
                           else w:=w+pino*wy;
              end;
       '\' :  begin
                inc(i,1);
                k:='';
                while f[i] in ['0'..'9','.'] do begin
                  k:=k+f[i];
                  inc(i)
                end;
                val(k,wy,code);
                dec(i);
                if reverse then w:=w+pino*wy
                           else w:=w-pino*wy;
              end;
       'G' :  zeichne(false);
       'F' :  zeichne(true);
       'H' :  zeichne(true);
      end;
      if i mod 200 = 0 then application.processmessages;
      inc(i);
    until (i>length(f)) or labbruch;
  end;

  procedure abschluss;
  begin
    if fehler then begin
      x:=10;
      y:=10;
      case vierbild of
        2 : x:=10+x+pbreite;
        3 : y:=10+y+phoehe;
        4 : begin x:=10+x+pbreite; y:=10+y+phoehe end;
      end;
      canvas.textout(round(x),round(y),'Iterationstiefe zu hoch');
    end;
    button1.caption:='Darstellung';
    labbruch:=true;
    QueryPerformanceCounter (t2x);       // Zählerstand 2
    if (t2x-t1x)>frequenz then
      label1.caption:=FormatFloat('0.0 s',(t2x-t1x)/frequenz)
    else
      label1.caption:=FormatFloat('0.0 ms',1000*(t2x-t1x)/frequenz);
  end;
begin
  f12:=0;
  f13:=0;
  QueryPerformanceFrequency (frequenz);      // Frequenz des Zählers
  QueryPerformanceCounter (t1x);       // Zählerstand 1
  for i:=0 to 8 do begin
    sg2.cells[0,i]:=uppercase(sg2.cells[0,i]);
    regeln[i]:=sg2.cells[0,i];
  end;
  labbruch:=false;
  button1.caption:='Stopp';
  canvas.pen.color:=clblack;
  canvas.brush.color:=clwhite;
  canvas.font.color:=clblack;
  if cb1.checked then begin
    canvas.pen.color:=rgb(239,206,107);
    canvas.brush.color:=clblack;
    canvas.font.color:=clwhite;
  end;
  canvas.rectangle(-1,-1,pbox.width+1,pbox.height+1);
  canvas.font.name:='Verdana';
  vierbilder:=r2.checked;
  if vierbilder then begin
    pbreite:=pbox.width div 2-10;
    phoehe:=pbox.height div 2-10;
    canvas.pen.color:=clred;
    canvas.moveto(pbreite+10,-1);
    canvas.lineto(pbreite+10,pbox.height+1);
    canvas.moveto(-1,phoehe+10);
    canvas.lineto(pbox.width+1,phoehe+10);
    if cb1.checked then canvas.pen.color:=rgb(239,206,107)
                   else canvas.pen.color:=clblack;
  end else begin
    pbreite:=pbox.width-10;
    phoehe:=pbox.height-10;
  end;
  vierbild:=1;
  fehler:=false;
  p:=ein_int(eitera);
  if p<1 then p:=1;
  if p>12 then begin
    p:=12;
    eitera.text:='12'
  end;

  repeat

  superaxiom:=eaxiom.text;
  if superaxiom='' then superaxiom:='F';
  farbe:=0;
  if cb2.checked then begin
    farbaxiom:='';
    farbe:=0;
    for i:=1 to length(superaxiom) do begin
      if superaxiom[i]='F' then farbaxiom:=farbaxiom+'FC'
                           else farbaxiom:=farbaxiom+superaxiom[i];
    end;
    superaxiom:=farbaxiom;
  end;
  i:=1;
  repeat
    superaxiom2:='';
    for su:=1 to length(superaxiom) do begin
      case superaxiom[su] of
        'F' : kk:=regeln[0];
        'H' : kk:=regeln[8];
        'G' : kk:=regeln[1];
        'X' : kk:=regeln[2];
        'Y' : kk:=regeln[3];
        'L' : kk:=regeln[4];
        'R' : kk:=regeln[5];
        'A' : kk:=regeln[6];
        'B' : kk:=regeln[7];
         else kk:=superaxiom[su];
      end;
      superaxiom2:=superaxiom2+kk;
      if length(superaxiom2)>hgrenze then begin
        fehler:=true;
        abschluss;
        exit;
      end;
    end;
    if superaxiom2='' then begin
      abschluss;
      exit;
    end;

    superaxiom:=superaxiom2;
    f14:=length(superaxiom);
    if i=2 then f12:=f14;
    if i=3 then f13:=f14;
    inc(i);
    if i>3 then begin
      if (i<=p) and (1.0*f14*f13/f12>hgrenze) then begin
        fehler:=true;
        abschluss;
        exit;
      end;
    end;
    application.ProcessMessages;
  until (i>p) or labbruch;
  label8.caption:=inttostr(length(superaxiom));

  q:=ein_int(ewinkel);
  if q>99 then q:=6;
  f:=superaxiom;
  new(ostack);
  ostack^.init;
  i0:=round(p);
  w1:=2.0*pi/q;
  l0:=pbreite/sqr(i0)/i0;
  l:=l0;
  w:=0;
  y:=0;
  x:=0;
  xo:=phoehe;
  xl:=pbreite;
  xu:=0;
  xr:=0;
  nicht:=true;
  reverse:=true;
  if not labbruch then axiom;
  ostack^.bye;
  ostack^.init;
  if xu-xo<>0 then faktor:=abs(phoehe/(xu-xo))
              else faktor:=1;
  if xr-xl<>0 then
    if faktor>abs(pbreite/(xr-xl)) then faktor:=abs(pbreite/(xr-xl));
  l:=faktor*l0;
  labbruch:=false;
  x:=5+abs(faktor*xl)+(pbreite-abs(faktor*(xr-xl)))/2;
  y:=5+abs(faktor*xo)+(phoehe-abs(faktor*(xo-xu)))/2;
  case vierbild of
    2 : x:=10+x+pbreite;
    3 : y:=10+y+phoehe;
    4 : begin x:=10+x+pbreite; y:=10+y+phoehe end;
  end;
  nicht:=false;
  w1:=2*pi/q;
  reverse:=true;
  w:=0;
  if not labbruch then axiom;

  ostack^.bye;
  dispose(ostack);
  if vierbilder and (vierbild<5) then begin
    inc(vierbild);
    inc(p);
    dest:=rect(0,0,pbox.width,pbox.height);
    pbox.canvas.copyrect(dest,canvas,dest);
  end;
  until (not vierbilder) or (vierbild>=5);

  abschluss;
end;

procedure TFLsystem.B1Darst(Sender: TObject);
var bitmap:tbitmap;
begin
  if not labbruch then labbruch:=true
  else begin
    bitmap:=tbitmap.create;
    bitmap.pixelformat:=pf32bit;
    bitmap.width:=pbox.width;
    bitmap.height:=pbox.height;
    lsystempaint(bitmap.canvas);
    pbox.canvas.draw(0,0,bitmap);
    bitmap.free;
  end;
end;

procedure TFLsystem.B3Spei(Sender: TObject);
var k:string;
    i:integer;
begin
  k:=ename.text;
  if (length(k)<>0) and (LBox.items.IndexOf(k)<0) then begin
    LBox.items.add(k);
    k:='*'+k;
    lh1.add(k);
    k:=ewinkel.text;
    lh1.add(k);
    k:=eaxiom.text;
    lh1.add(k);
    for i:=0 to 8 do begin
      k:=sg2.cells[0,i];
      if length(k)>0 then begin
        k:=hstring[i]+k;
        lh1.add(k);
      end
    end;
    lh1.SaveToFile(extractfilepath(application.exename)+'mchaos.txt');
  end;
end;

procedure TFLsystem.B2Loesch(Sender: TObject);
var k:string;
    ort,sel:integer;
begin
  sel:=LBox.itemindex;
  if sel>=0 then begin
    k:='*'+LBox.items[sel];
    LBox.items.delete(sel);
    ort:=lh1.indexof(k);
    if ort>=0 then begin
      lh1.delete(ort);
      while (ort<=lh1.count-1) and (lh1[ort][1]<>'*') do lh1.delete(ort);
      lh1.SaveToFile(extractfilepath(application.exename)+'mchaos.txt');
    end;
  end;
end;

procedure TFLsystem.FormDestroy(Sender: TObject);
begin
  lh1.free;
end;

end.

