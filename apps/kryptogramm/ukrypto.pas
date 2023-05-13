unit ukrypto;

interface

uses
  Windows, Sysutils, Classes, Graphics, Controls, Forms, Dialogs, rxgif,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Menus, RXSpin, ToolWin;

type
  Tform10k = class(TForm)
    P8: TPanel;
    krypto: TPanel;
    P17: TPanel;
    MM1: TMainMenu;
    M2: TMenuItem;
    M3: TMenuItem;
    M4: TMenuItem;
    P24: TPanel;
    L13: TLabel;
    L14: TLabel;
    L15: TLabel;
    L18: TLabel;
    L35: TLabel;
    E4: TEdit;
    E5: TEdit;
    E6: TEdit;
    E7: TEdit;
    E8: TEdit;
    E9: TEdit;
    E10: TEdit;
    E11: TEdit;
    E12: TEdit;
    E13: TEdit;
    E14: TEdit;
    E15: TEdit;
    E16: TEdit;
    E17: TEdit;
    E18: TEdit;
    P18: TPanel;
    LB5: TListBox;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    PB1: TPaintBox;
    I0: TImage;
    I1: TImage;
    I2: TImage;
    I3: TImage;
    I4: TImage;
    I5: TImage;
    I6: TImage;
    I7: TImage;
    I8: TImage;
    I9: TImage;
    I10: TImage;
    I11: TImage;
    I12: TImage;
    I13: TImage;
    Label3: TLabel;
    LB3: TListBox;
    Lx1: TRxSpinEdit;
    Lx2: TRxSpinEdit;
    Lx3: TRxSpinEdit;
    Lx4: TRxSpinEdit;
    Lx5: TRxSpinEdit;
    Lx6: TRxSpinEdit;
    Lx7: TRxSpinEdit;
    Lx8: TRxSpinEdit;
    Lx9: TRxSpinEdit;
    Lx10: TRxSpinEdit;
    Panel2: TPanel;
    Label1: TLabel;
    CB1: TCheckBox;
    Timer1: TTimer;
    Panel7: TPanel;
    Label7: TLabel;
    Label6: TLabel;
    Panel8: TPanel;
    panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    I14: TImage;
    rx2: TRxSpinEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure D4C(Sender: TObject);
    procedure S13Click(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure Rx2Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Lx1Change(Sender: TObject);
    procedure uebertragen(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
//      b1,b2:tbitmap;
  public
    { Public declarations }
  end;

var
  form10k: Tform10k;

implementation

const sabbruch : boolean = true;
var  br1,br2,br3:integer;
     original:array[1..4,1..4] of string[10];
     zeichen:array[0..9] of integer;
     loesungsstring:string;
     nichtanzeigen,loesungsstringsuchen:boolean;
     z1,z2:tdatetime;
     
{$R *.DFM}

procedure Tform10k.FormCreate(Sender: TObject);
begin
   randomize;
   helpcontext:=223;
   nichtanzeigen:=false;
   loesungsstringsuchen:=false;
   rx2.maxvalue:=strtoint(lb5.items[lb5.items.count-1]);
   z1:=time;
   Rx2Change(Sender);
end;

procedure Tform10k.D4C(Sender: TObject);
procedure _krypt;
var op:array[1..6] of byte;
    kk:string; abbruch:boolean;
    zahl:array[1..9] of string[9];
    la,start:array[0..9] of integer;
    zla:array[1..9] of integer;
    ziffer:array[1..9,1..8] of byte;
    tok:boolean;
    anzahl,j:byte;
    i:integer;
procedure ziffern;
var i,j:integer;
begin
  for i:=1 to 9 do begin
   kk:=zahl[i];
   for j:=1 to 8 do
     if j<=length(kk) then begin
         if kk[j] in ['A'..'J'] then ziffer[i,j]:=ord(kk[j])-65
            else ziffer[i,j]:=ord(kk[j])-38
         end
         else ziffer[i,j]:=255;
  end;
end;
procedure einfuegen(i:integer);
var j:integer; z:longint;
begin
    z:=0; j:=1;
    while (j<=8) and (ziffer[i,j]<>255) do begin
       if ziffer[i,j] in [0..9] then z:=10*z+la[ziffer[i,j]]
              else z:=10*z+ziffer[i,j]-10;
       inc(j)
       end;
    zla[i]:=z;
end;
procedure test(a,b,c,d:byte);
begin
  case op[d] of
     1 : tok:=tok and (zla[a]+zla[b]=zla[c]);
     2 : tok:=tok and (zla[a]-zla[b]=zla[c]);
     3 : tok:=tok and (zla[a]*zla[b]=zla[c]);
     4 : if zla[b]<>0 then
          tok:=tok and (zla[a] div zla[b]=zla[c])
             else tok:=false;
    else tok:=false;
  end;
end;
procedure operationszeichen(nr:integer;edit:tedit);
var k:string;
begin
      k:=edit.text;
    if length(k)>0 then begin
      case k[1] of
        '+' : op[nr]:=1;
        '-' : op[nr]:=2;
        '*' : op[nr]:=3;
        ':' : op[nr]:=4;
      else op[nr]:=0;
      end
      end else op[nr]:=0;
end;
begin
      operationszeichen(1,e5);
      operationszeichen(2,e8);
      operationszeichen(3,e9);
      operationszeichen(4,e10);
      operationszeichen(5,e12);
      operationszeichen(6,e16);
      zahl[1]:=e4.text;
      zahl[2]:=e6.text;
      zahl[3]:=e7.text;
      zahl[4]:=e11.text;
      zahl[5]:=e13.text;
      zahl[6]:=e14.text;
      zahl[7]:=e15.text;
      zahl[8]:=e17.text;
      zahl[9]:=e18.text;
  ziffern;

  anzahl:=0;
  for i:=65 to 74 do begin
      abbruch:=false;
      for j:=1 to 9 do
          if pos(chr(i),zahl[j])<>0 then abbruch:=true;
      if abbruch then inc(anzahl);
      end;
  for i:=0 to 9 do start[i]:=0;
  i:=anzahl;
  while i<=9 do begin start[i]:=10+i; inc(i) end;
  lb3.clear;
  lb3.items.add('A'#9'B'#9'C'#9'D'#9'E'#9'F'#9'G'#9'H'#9'I'#9'J');
//  lb3.items.add(' ');
 la[0]:=start[0]; repeat
 la[1]:=start[1]; repeat
 if la[1]<>la[0] then begin
 la[2]:=start[2]; repeat
 if (la[1]<>la[2]) and (la[0]<>la[2]) then begin
 la[3]:=start[3]; repeat
 if (la[1]<>la[3]) and (la[0]<>la[3]) and (la[2]<>la[3]) then begin
 la[4]:=start[4]; repeat
 if (la[1]<>la[4]) and (la[0]<>la[4]) and (la[2]<>la[4]) and (la[3]<>la[4])
  then begin
 la[5]:=start[5]; repeat
 if (la[1]<>la[5]) and (la[2]<>la[5]) and (la[3]<>la[5]) and
    (la[0]<>la[5]) and (la[4]<>la[5]) then begin
 la[6]:=start[6]; repeat
 if (la[1]<>la[6]) and (la[2]<>la[6]) and (la[3]<>la[6]) and
    (la[0]<>la[6]) and (la[4]<>la[6]) and (la[5]<>la[6])
    then begin
 la[7]:=start[7]; repeat
 la[8]:=start[8]; repeat
 la[9]:=start[9]; repeat

 if
    (la[1]<>la[9]) and (la[2]<>la[9]) and (la[3]<>la[9]) and
    (la[0]<>la[9]) and (la[4]<>la[9]) and (la[5]<>la[9]) and
    (la[6]<>la[9]) and (la[7]<>la[9]) and (la[8]<>la[9]) and

    (la[1]<>la[7]) and (la[2]<>la[7]) and (la[3]<>la[7]) and
    (la[0]<>la[7]) and (la[4]<>la[7]) and (la[5]<>la[7]) and
    (la[6]<>la[7]) and
    (la[1]<>la[8]) and (la[2]<>la[8]) and (la[3]<>la[8]) and
    (la[0]<>la[8]) and (la[4]<>la[8]) and (la[5]<>la[8]) and
    (la[6]<>la[8]) and (la[7]<>la[8])

 then begin
   tok:=true;
   einfuegen(1); einfuegen(2); einfuegen(3);
   test(1,2,3,1);
   if tok then begin
   einfuegen(4); einfuegen(7); test(1,4,7,2);
   if tok then begin
   einfuegen(5); einfuegen(8); test(2,5,8,3);
   if tok then begin
   einfuegen(6); einfuegen(9); test(3,6,9,4);
   if tok then begin test(7,8,9,6);
   if tok then begin test(4,5,6,5);
   if tok then begin
      kk:='';
      for i:=0 to anzahl-1 do kk:=kk+chr(la[i]+48);
      while length(kk)<10 do kk:=kk+':';
      loesungsstring:=kk; //label5.caption:=kk;
      kk:='';
      for i:=0 to anzahl-1 do kk:=kk+chr(la[i]+48)+#9;
    if loesungsstringsuchen then sabbruch:=true
                            else lb3.items.add(kk);
      end;
      end; end; end; end; end;
   end;

   inc(la[9]); until (la[9]>9);
   inc(la[8]); until (la[8]>9);
   inc(la[7]); until (la[7]>9);
   end;
   inc(la[6]); until (la[6]>9);
   end;
   inc(la[5]); until (la[5]>9);
   end;
   inc(la[4]); until (la[4]>9);
   end;
   inc(la[3]); until (la[3]>9);
   end;
   inc(la[2]); until (la[2]>9) or sabbruch;
   application.processmessages;
   end;
//   l35.caption:=_str0(la[0]*10+la[1])+' %'; //l18
   inc(la[1]); until (la[1]>9) or sabbruch;
   inc(la[0]); until (la[0]>9) or sabbruch;
   l35.caption:='100 %';
   if not loesungsstringsuchen then lb3.items.add('keine weiteren Lösungen');
end;
begin
 if sabbruch=false then begin
     sabbruch:=true;
     end
  else begin
     z1:=z1-10/24/60;
     sabbruch:=false;
     _krypt;
     sabbruch:=true;
   end;
end;

procedure Tform10k.S13Click(Sender: TObject);
begin
 if sabbruch=false then begin sabbruch:=true; exit end else close;
end;

procedure Tform10k.PB1Paint(Sender: TObject);
var bitmap:tbitmap; j,ho,br,xoffset,yoffset:integer; k:string;
procedure zeichnen(x,y:integer;c:char);
var ii:timage; nr,xv,yv,ww:integer; k:string;
begin
   ww:=-1;
   case c of
     'A'..'J' : begin nr:=zeichen[ord(c)-65];
                case nr of
                   0 : begin ii:=i0; ww:=round(lx1.value); end;
                   1 : begin ii:=i1; ww:=round(lx2.value); end;
                   2 : begin ii:=i2; ww:=round(lx3.value); end;
                   3 : begin ii:=i3; ww:=round(lx4.value); end;
                   4 : begin ii:=i4; ww:=round(lx5.value); end;
                   5 : begin ii:=i5; ww:=round(lx6.value); end;
                   6 : begin ii:=i6; ww:=round(lx7.value); end;
                   7 : begin ii:=i7; ww:=round(lx8.value); end;
                   8 : begin ii:=i8; ww:=round(lx9.value); end;
                   9 : begin ii:=i9; ww:=round(lx10.value); end;
                end;
              end;
     '+' : ii:=i10;
     '-' : ii:=i11;
     '*' : ii:=i12;
     '=' : ii:=i13;
     else ii:=i14;
    end;
   xv:=(35-ii.width) div 2;
   yv:=(35-ii.height) div 2;
 if (cb1.checked) and (ww>-1) and (ww<10) then begin
   k:=inttostr(ww);
   bitmap.canvas.textout(x+18-bitmap.canvas.textwidth(k) div 2,
                         y+18-bitmap.canvas.textheight(k) div 2,k);
   end else
   bitmap.canvas.draw(x+xv,y+yv,ii.picture.bitmap);
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height;
    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.size:=18;
    bitmap.canvas.font.style:=[fsbold];
    br:=br1+br2+br3+4;
    ho:=6;
  if br>2 then begin
    with bitmap.canvas do begin
       xoffset:=(bitmap.width-br*36) div 2;
       yoffset:=(bitmap.height-ho*36) div 2;
       k:=original[1,1];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+br1-length(k)),yoffset,k[j]);
       k:=original[1,3];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+2+br1+br2-length(k)),yoffset,k[j]);
       k:=original[1,4];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+2+br1+2+br2+br3-length(k)),yoffset,k[j]);
       k:=original[3,1];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+br1-length(k)),yoffset+3*36,k[j]);
       k:=original[3,3];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+2+br1+br2-length(k)),yoffset+3*36,k[j]);
       k:=original[3,4];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+2+br1+2+br2+br3-length(k)),yoffset+3*36,k[j]);
       k:=original[4,1];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+br1-length(k)),yoffset+5*36,k[j]);
       k:=original[4,3];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+2+br1+br2-length(k)),yoffset+5*36,k[j]);
       k:=original[4,4];
       for j:=1 to length(k) do zeichnen(xoffset+36*(j-1+2+br1+2+br2+br3-length(k)),yoffset+5*36,k[j]);

       zeichnen(xoffset+36*(br1+br2+2)+18,yoffset,'=');
       zeichnen(xoffset+36*(br1+br2+2)+18,yoffset+3*36,'=');
       zeichnen(xoffset+36*(br1+br2+2)+18,yoffset+5*36,'=');

       zeichnen(xoffset+36*(br1)+18,yoffset,original[1,2][1]);
       zeichnen(xoffset+36*(br1)+18,yoffset+3*36,original[3,2][1]);
       zeichnen(xoffset+36*(br1)+18,yoffset+5*36,original[4,2][1]);

       zeichnen(xoffset+18*(br1)-18,yoffset+36+18,original[2,1][1]);
       zeichnen(xoffset+18*(br2)+18+36*(br1+1),yoffset+36+18,original[2,3][1]);
       zeichnen(xoffset+18*(br3)+18+36*(br1+br2+3),yoffset+36+18,original[2,4][1]);

       pen.width:=2;
       moveto(xoffset-10,yoffset+4*36+18);
       lineto(xoffset+br*36+10,yoffset+4*36+18);
       pen.width:=1;
    end;
    end;
    pb1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tform10k.Rx2Change(Sender: TObject);
var x,i,j,h,k:integer;
procedure breitentest(var br:integer;y:integer);
var k:integer;
begin
    k:=length(lb5.items[y+x*17]);
    if k>br then br:=k;
end;
begin
 if lb5.items.count>0 then begin
   lb3.clear;
   nichtanzeigen:=true;
   lx1.value:=10;
   lx2.value:=10;
   lx3.value:=10;
   lx4.value:=10;
   lx5.value:=10;
   lx6.value:=10;
   lx7.value:=10;
   lx8.value:=10;
   lx9.value:=10;
   lx10.value:=10;
   x:=round(rx2.value)-1;
   e4.text:=lb5.items[1+x*17];
   e5.text:=lb5.items[2+x*17];
   e6.text:=lb5.items[3+x*17];
   e7.text:=lb5.items[4+x*17];
   e8.text:=lb5.items[5+x*17];
   e9.text:=lb5.items[6+x*17];
   e10.text:=lb5.items[7+x*17];
   e11.text:=lb5.items[8+x*17];
   e12.text:=lb5.items[9+x*17];
   e13.text:=lb5.items[10+x*17];
   e14.text:=lb5.items[11+x*17];
   e15.text:=lb5.items[12+x*17];
   e16.text:=lb5.items[13+x*17];
   e17.text:=lb5.items[14+x*17];
   e18.text:=lb5.items[15+x*17];
   loesungsstring:=lb5.items[16+x*17];
//   label5.caption:=loesungsstring;

   br1:=0;
   br2:=0;
   br3:=0;
   original[1,1]:=lb5.items[1+x*17];
   breitentest(br1,1);
   original[1,3]:=lb5.items[3+x*17];
   breitentest(br2,3);
   original[1,4]:=lb5.items[4+x*17];
   breitentest(br3,4);
   original[3,1]:=lb5.items[8+x*17];
   breitentest(br1,8);
   original[3,3]:=lb5.items[10+x*17];
   breitentest(br2,10);
   original[3,4]:=lb5.items[11+x*17];
   breitentest(br3,11);
   original[4,1]:=lb5.items[12+x*17];
   breitentest(br1,12);
   original[4,3]:=lb5.items[14+x*17];
   breitentest(br2,14);
   original[4,4]:=lb5.items[15+x*17];
   breitentest(br3,15);
   original[2,2]:='';
   original[1,2]:=lb5.items[2+x*17][1];
   original[2,1]:=lb5.items[5+x*17][1];
   original[2,3]:=lb5.items[6+x*17][1];
   original[2,4]:=lb5.items[7+x*17][1];
   original[3,2]:=lb5.items[9+x*17][1];
   original[4,2]:=lb5.items[13+x*17][1];
   for i:=0 to 9 do zeichen[i]:=i;
   for k:=1 to 10 do begin
       i:=random(10);
       j:=random(10);
       h:=zeichen[i]; zeichen[i]:=zeichen[j]; zeichen[j]:=h;
    end;
//   pb1paint(sender);
   nichtanzeigen:=false;
   timer1.enabled:=true;
   uebertragen(sender);
   end;
end;

procedure gifres(image:timage;const f:string);
var
  Stream		: TStream;
  GIF			: TGIFImage;
  Bitmap		: TBitmap;
begin
  Stream := TResourceStream.Create(hInstance,f,'GIF');
  try
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromStream(Stream);
      Image.Picture.Assign(nil);
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(GIF);
        Image.Picture.Assign(Bitmap);
      finally
        Bitmap.Free;
      end;
    finally
      GIF.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure Tform10k.FormActivate(Sender: TObject);
begin
   gifres(i0,'zr0');
   gifres(i1,'zr1');
   gifres(i2,'zr2');
   gifres(i3,'zr3');
   gifres(i4,'zr4');
   gifres(i5,'zr5');
   gifres(i6,'zr6');
   gifres(i7,'zr7');
   gifres(i8,'zr8');
   gifres(i9,'zr9');
   gifres(i10,'zrp');
   gifres(i11,'zrm');
   gifres(i12,'zrv');
   gifres(i13,'zrg');
   gifres(i14,'zrd');
{   pic2(i0.picture.bitmap.canvas,0,0,14030);
   pic2(i1.picture.bitmap.canvas,0,0,14031);
   pic2(i2.picture.bitmap.canvas,0,0,14032);
   pic2(i3.picture.bitmap.canvas,0,0,14033);
   pic2(i4.picture.bitmap.canvas,0,0,14034);
   pic2(i5.picture.bitmap.canvas,0,0,14035);
   pic2(i6.picture.bitmap.canvas,0,0,14036);
   pic2(i7.picture.bitmap.canvas,0,0,14037);
   pic2(i8.picture.bitmap.canvas,0,0,14038);
   pic2(i9.picture.bitmap.canvas,0,0,14039);
{     2 : offset:=14030;
     0 : offset:=14050;
     1 : offset:=14060;}
end;

procedure Tform10k.Lx1Change(Sender: TObject);
var la:array[0..9] of integer; i:integer; lll:string;
begin
    la[0]:=round(lx1.value);
    la[1]:=round(lx2.value);
    la[2]:=round(lx3.value);
    la[3]:=round(lx4.value);
    la[4]:=round(lx5.value);
    la[5]:=round(lx6.value);
    la[6]:=round(lx7.value);
    la[7]:=round(lx8.value);
    la[8]:=round(lx9.value);
    la[9]:=round(lx10.value);
    lll:='';
    for i:=0 to 9 do lll:=lll+chr(48+la[zeichen[i]]);
//    label4.caption:=lll;
    if cb1.checked then pb1paint(sender);
    if (lll=loesungsstring) and timer1.enabled then begin
      timer1.enabled:=false;
      application.processmessages;
      showmessage('Gratulation! Die Aufgabe wurde richtig gelöst!');
      end;
end;

procedure Tform10k.uebertragen(Sender: TObject);
var  h,i,j,kk:integer;
procedure breitentest(var br:integer;y:string);
var k:integer;
begin
    k:=length(y);
    if k>br then br:=k;
end;
begin
   if nichtanzeigen then exit;
   lx1.value:=10;
   lx2.value:=10;
   lx3.value:=10;
   lx4.value:=10;
   lx5.value:=10;
   lx6.value:=10;
   lx7.value:=10;
   lx8.value:=10;
   lx9.value:=10;
   lx10.value:=10;
   br1:=0;
   br2:=0;
   br3:=0;
   original[1,1]:=e4.text;
   breitentest(br1,e4.text);
   original[1,3]:=e6.text;
   breitentest(br2,e6.text);
   original[1,4]:=e7.text;
   breitentest(br3,e7.text);
   original[3,1]:=e11.text;
   breitentest(br1,e11.text);
   original[3,3]:=e13.text;
   breitentest(br2,e13.text);
   original[3,4]:=e14.text;
   breitentest(br3,e14.text);
   original[4,1]:=e15.text;
   breitentest(br1,e15.text);
   original[4,3]:=e17.text;
   breitentest(br2,e17.text);
   original[4,4]:=e18.text;
   breitentest(br3,e18.text);
   original[2,2]:='';
   original[1,2]:=e5.text;
   original[2,1]:=e8.text;
   original[2,3]:=e9.text;
   original[2,4]:=e10.text;
   original[3,2]:=e12.text;
   original[4,2]:=e16.text;
   for i:=0 to 9 do zeichen[i]:=i;
   for kk:=1 to 10 do begin
       i:=random(10);
       j:=random(10);
       h:=zeichen[i]; zeichen[i]:=zeichen[j]; zeichen[j]:=h;
    end;
   pb1paint(sender);
end;

procedure Tform10k.D1Click(Sender: TObject);
var va,vb,vc,vd,ve,vf,vi:int64; s,s2,k:string; i,anz:integer;
    wert:array[0..8] of int64;
    wertS:array[0..8] of STRING;
    oper:array[0..5] of char;
    zeichen:array[0..9] of char;
    a:integer;
procedure swap(a,b:integer);
var h:int64;
begin h:=wert[a]; wert[a]:=wert[b]; wert[b]:=h end;
procedure swapo(a,b:integer);
var h:char;
begin h:=oper[a]; oper[a]:=oper[b]; oper[b]:=h end;
begin
    z1:=time;
    timer1.enabled:=true;
    lb3.clear;
    nichtanzeigen:=true;
    randomize;
    anz:=0;

  if random<0.4 then begin //einfach
    va:=random(1000)+10;
    vb:=random(1000)+10;
    vc:=random(1000)+10;
    vd:=random(1000)+10;
    wert[0]:=va;
    wert[1]:=vb;
    wert[2]:=va+vb;
    wert[3]:=vc;
    wert[4]:=vd;
    wert[5]:=vc+vd;
    wert[6]:=va+vc;
    wert[7]:=vb+vd;
    wert[8]:=va+vb+vc+vd;
    oper[0]:='+';
    oper[1]:='+';
    oper[2]:='+';
    oper[3]:='+';
    oper[4]:='+';
    oper[5]:='+';
  end else begin //kompliziert
   repeat
    repeat
    vb:=random(390)+100;
    vc:=(random(5000)+1000) div vb;
    va:=vb*vc;
    inc(anz);
    until ((va>=1000) and (vc>7)) or (anz>100);
    repeat
    vf:=(random(5000)+5000) div vc;
    vi:=vc*vf;
    inc(anz);
    until (vi-va>2000) or (anz>200);
    ve:=vi-va-vb-vf;
   until (ve mod 2=0) and (anz<200);
    ve:=ve div 2;
    wert[0]:=va;
    wert[1]:=vb;
    wert[2]:=vc;
    wert[3]:=vf+ve;
    wert[4]:=ve;
    wert[5]:=vf;
    wert[6]:=va+ve+vf;
    wert[7]:=vb+ve;
    wert[8]:=vi;
    oper[0]:='+';
    oper[1]:='+';
    oper[2]:='*';
    oper[3]:=':';
    oper[4]:='-';
    oper[5]:='+';
   if random<0.5 then begin
      swap(0,3);
      swap(1,4);
      swap(2,5);
      swapo(3,4);
    end;
   if random<0.5 then begin
      swap(1,3);
      swap(2,6);
      swap(5,7);
      swapo(0,3);
      swapo(1,4);
      swapo(2,5);
    end;
   if random<0.5 then begin
      swap(0,8);
      swap(1,5);
      swap(3,7);
      swapo(0,5);
      swapo(1,4);
      swapo(2,3);
      for i:=0 to 5 do begin
         case oper[i] of
           '+' : oper[i]:='-';
           '-' : oper[i]:='+';
           '*' : oper[i]:=':';
           ':' : oper[i]:='*';
           end;
       end;
    end;
   end; //kompliziert

   s:='';
   k:=inttostr(wert[0])+#9+oper[3]+#9+inttostr(wert[1])+#9'='#9+inttostr(wert[2]);
   s:=s+k;
//   k:=oper[0]+#9#9+oper[1]+#9#9+oper[2];
   k:=inttostr(wert[3])+#9+oper[4]+#9+inttostr(wert[4])+#9'='#9+inttostr(wert[5]);
   s:=s+k;
   k:=inttostr(wert[6])+#9+oper[5]+#9+inttostr(wert[7])+#9'='#9+inttostr(wert[8]);
   s:=s+k;
   i:=1;
   while (i<=length(s)) do begin
     if (s[i] in [#9,'+','-','*',':','=']) then delete(s,i,1)
                                           else inc(i);
     end;
   for i:=0 to 9 do zeichen[i]:=chr(32);
   a:=65;
   for i:=1 to length(s) do begin
       if zeichen[strtoint(s[i])]=chr(32) then begin
           zeichen[strtoint(s[i])]:=chr(a);
           s2:=s2+s[i];
           inc(a);
          end;
    end;
    while length(s2)<10 do s2:=s2+':';
    loesungsstring:=s2;
//    label5.caption:=s2;

   s:=''; for i:=0 to 9 do begin
      s:=s+zeichen[i];
      end;
   for i:=0 to 8 do begin
       werts[i]:=inttostr(wert[i]);
       for a:=1 to length(werts[i]) do werts[i][a]:=zeichen[strtoint(werts[i][a])];
     end;
   e4.text:=werts[0];
   e5.text:=oper[3];
   e6.text:=werts[1];
   e7.text:=werts[2];
   e8.text:=oper[0];
   e9.text:=oper[1];
   e10.text:=oper[2];
   e11.text:=werts[3];
   e12.text:=oper[4];
   e13.text:=werts[4];
   e14.text:=werts[5];
   e15.text:=werts[6];
   e16.text:=oper[5];
   e17.text:=werts[7];
   e18.text:=werts[8];
   nichtanzeigen:=false;
   uebertragen(sender);
{   loesungsstringsuchen:=true;
   d4c(sender);
   loesungsstringsuchen:=false;}
end;

procedure Tform10k.D2Click(Sender: TObject);
var la:array[0..9] of integer; w,x,i:integer; lll:string; gefunden:boolean;
begin
    z1:=z1-2/24/60;
    la[0]:=round(lx1.value);
    la[1]:=round(lx2.value);
    la[2]:=round(lx3.value);
    la[3]:=round(lx4.value);
    la[4]:=round(lx5.value);
    la[5]:=round(lx6.value);
    la[6]:=round(lx7.value);
    la[7]:=round(lx8.value);
    la[8]:=round(lx9.value);
    la[9]:=round(lx10.value);
    lll:='';
    for i:=0 to 9 do lll:=lll+chr(48+la[zeichen[i]]);
   if lll<>loesungsstring then begin
     gefunden:=false;
     repeat
     x:=random(10)+1;
     if (loesungsstring[x]<>':') and (lll[x]<>loesungsstring[x]) then
        begin gefunden:=true;
              w:=strtoint(loesungsstring[x]);
             case zeichen[x-1] of
               0 : lx1.value:=w;
               1 : lx2.value:=w;
               2 : lx3.value:=w;
               3 : lx4.value:=w;
               4 : lx5.value:=w;
               5 : lx6.value:=w;
               6 : lx7.value:=w;
               7 : lx8.value:=w;
               8 : lx9.value:=w;
               9 : lx10.value:=w;
             end;
        end;
      until gefunden;
end;

end;

procedure Tform10k.Timer1Timer(Sender: TObject);
begin
    z2:=time;
    label6.caption:=formatdatetime('nn:ss',z2-z1);
end;

end.

