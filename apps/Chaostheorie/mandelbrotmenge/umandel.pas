unit umandel;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Grids;

type
  Tfmandel = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    MaPanel: TPanel;
    mandel1: TPaintBox;
    mandel2: TPaintBox;
    mandel3: TPaintBox;
    mandel4: TPaintBox;
    mandel5: TPaintBox;
    mandel6: TPaintBox;
    Panel3: TPanel;
    Label1: TLabel;
    Paintbox: TPaintBox;
    Zeichnen: TButton;
    Label5: TLabel;
    tabelle: TStringGrid;
    Edit1: TEdit;
    Label4: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    mandelimage: TImage;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Timer1: TTimer;
    procedure MaPanelResize(Sender: TObject);
    procedure PaintboxPaint(Sender: TObject);
    procedure PaintboxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintboxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZeichnenClick(Sender: TObject);
    procedure superMousedown(Sender: TObject;
        Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
     mandelpunkt:array[1..6] of record x,y:real end;
     jufaktor:real;
     sabbruch: boolean;
     juanzahl:integer;
     juziehen:boolean;
     juziehzahl:integer;

     farbfeld  : array of array of array of byte;
     bitmaprgb : array[1..6] of tbitmap;
     cyclestart:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmandel: Tfmandel;

implementation

type
     _farbe = record r,g,b:byte end;
var
     pal:array[0..255] of _farbe;

{$R *.DFM}

function  _strkomma(a:real;b,c:byte):string;
var ks:string;
begin
    str(a:b:c,ks);
    if c<>0 then
    begin
      while (length(ks)>1) and (ks[length(ks)]='0') do delete(ks,length(ks),1);
      if (length(ks)>1) and (ks[length(ks)]='.') then delete(ks,length(ks),1);
    end;
    if ks='-0' then ks:='0';
    if pos('.',ks)>0 then ks[pos('.',ks)]:=',';
    _strkomma:=ks;
end;
function komma(s:string):string;
var i:integer;
begin
    if s<>'' then
      for i:=1 to length(s) do s[i]:=upcase(s[i]);
    if s<>'' then
      while pos(',',s)<>0 do s[pos(',',s)]:='.';
    komma:=s;
end;
function  ein_real(const edit:tedit):real;
var kk:string;
    code,i:integer;
    we:real;
begin
    kk:=edit.text;
    if kk<>'' then
      for i:=1 to length(kk) do kk[i]:=upcase(kk[i]);
    while pos(',',kk)<>0 do kk[pos(',',kk)]:='.';
    val(kk,we,code);
    ein_real:=we;
end;

procedure farbenladen(name:string);
var ms1: TResourcestream;
begin
    fillchar(pal,sizeof(pal),1);
    ms1 := TResourceStream.Create(hinstance,name,'RT_RCDATA');
    try
      ms1.read(pal,768);
    finally
      ms1.Free;
    end;
end;

procedure Tfmandel.MaPanelResize(Sender: TObject);
var bb,hh,i:integer;
begin
    bb:=(MaPanel.width-panel3.width) div 2;
    hh:=MaPanel.height div 3;
    mandel1.width:=bb-1;
    mandel2.width:=bb-1;
    mandel3.width:=bb-1;
    mandel4.width:=bb-1;
    mandel5.width:=bb-1;
    mandel6.width:=bb-1;
    mandel1.height:=hh-1;
    mandel2.height:=hh-1;
    mandel3.height:=hh-1;
    mandel4.height:=hh-1;
    mandel5.height:=hh-1;
    mandel6.height:=hh-1;
    mandel1.left:=panel3.width;
    mandel2.left:=Panel3.width;
    mandel3.left:=Panel3.width;
    mandel4.left:=Panel3.width+bb;
    mandel5.left:=Panel3.width+bb;
    mandel6.left:=Panel3.width+bb;
    mandel1.top:=1;
    mandel2.top:=hh+1;
    mandel3.top:=2*hh+1;
    mandel4.top:=1;
    mandel5.top:=hh+1;
    mandel6.top:=2*hh+1;

    setlength(farbfeld,7,bb+1,hh+1);
    cyclestart:=0;

    for i:=1 to 6 do
    begin
      if bitmaprgb[i]<>nil then bitmaprgb[i].free;
      bitmaprgb[i]:=tbitmap.create;
      bitmaprgb[i].width:=bb;
      bitmaprgb[i].height:=hh;
      bitmaprgb[i].pixelformat:=pf24bit;
    end;
end;

procedure Tfmandel.PaintboxPaint(Sender: TObject);
var x,y,breite,hoehe:integer;
begin
    breite:=Paintbox.width;
    hoehe:=Paintbox.height;
    Paintbox.canvas.draw(0,0,mandelimage.picture.bitmap);
    Paintbox.canvas.Brush.color:=clblue;
    x:=round(breite*(mandelpunkt[1].x+2.5)/4);
    y:=round(hoehe*(2-mandelpunkt[1].y)/4);
    Paintbox.canvas.Ellipse(x-4,y-4,x+4,y+4);
end;

procedure Tfmandel.PaintboxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,breite,hoehe:Integer;
begin
    breite:=Paintbox.width;
    hoehe:=Paintbox.height;
    for i:=1 to 1 do
    begin
      if (abs(x-round(breite*(mandelpunkt[i].x+2.5)/4))<5) and
        (abs(y-round(hoehe*(2-mandelpunkt[i].y)/4))<5) then
      begin
        juziehen:=true;
        juziehzahl:=i
      end;
    end;
end;

procedure Tfmandel.PaintboxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var breite,hoehe:Integer;
begin
    breite:=Paintbox.width;
    hoehe:=Paintbox.height;
    if juziehen then
    begin
      mandelpunkt[juziehzahl].x:=4*x/breite-2.5;
      mandelpunkt[juziehzahl].y:=2-4*y/hoehe;
      edit1.text:=_strkomma(mandelpunkt[1].x,1,10);
      edit2.text:=_strkomma(mandelpunkt[1].y,1,10);
      Paintboxpaint(sender);
    end;
end;

procedure Tfmandel.PaintboxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var breite,hoehe:Integer;
begin
    breite:=Paintbox.width;
    hoehe:=Paintbox.height;
    if juziehen then
    begin
      juziehen:=false;
      mandelpunkt[juziehzahl].x:=4*x/breite-2.5;
      mandelpunkt[juziehzahl].y:=2-4*y/hoehe;
      edit1.text:=_strkomma(mandelpunkt[1].x,1,10);
      edit2.text:=_strkomma(mandelpunkt[1].y,1,10);
      Paintboxpaint(sender);
    end;
end;

procedure Tfmandel.ZeichnenClick(Sender: TObject);
var faktor:real;
    code,i:integer;
    Time1, Time2, abbruchtime, frequenz: Int64;

procedure Paintmantel(imagenummer:integer);
label 1;
VAR a,b,da,db,radius,af,bf,gwert:real;
                i,it : word;
                bitmap:tbitmap;
    x,y,breite,hoehe:integer;
    rowrgb : pbytearray;
BEGIN
    QueryPerformanceCounter(Time1);

    if abs(faktor)<0.1 then faktor:=1;
    if faktor>100000000 then faktor:=100000000;
    if sabbruch=false then
    begin
      gwert:=4;
      breite:=mandel1.width;
      hoehe:=mandel2.height;
      bitmap:=tbitmap.create;
      bitmap.width:=breite;
      bitmap.height:=hoehe;
      bitmap.pixelformat:=pf24bit;
      jufaktor:=hoehe/breite;
      it:=round(5*faktor);
      if it<200 then it :=200;
      if it>5000 then it :=5000;
      radius:=4;
      da := gwert/breite/faktor;
      db := jufaktor*gwert/hoehe/faktor;

      bf:= mandelpunkt[1].y+db*hoehe/2;
      af:= mandelpunkt[1].x-da*breite/2;

      b := bf;
      FOR y:=0 TO hoehe-1 DO
      BEGIN
        rowrgb:=bitmap.scanline[y];
        b := b - db;
        a := af;
        FOR x:=0 TO breite-1 DO
        BEGIN
          a := a + da;
      ASM
         FLD     radius    { 4        }
         FLD     a         { cx       4 }
         FLD     b         { cy       cx    4     }
         FLD     st        { y        cy    cx    4    }
         FMUL    st,st     { y²       cy    cx    4    }
         FLD     st(2)     { x        y²    cy    cx    4     }
         FMUL    st,st     { x²       y²    cy    cx    4     }
         FLD     st(2)     { y        x²    y²    cy    cx    4     }
         FLD     st(4)     { x        y     x²    y²    cy    cx    4   }

         XOR     cx,cx
@itloop: INC     cx        // CX ist der Iterationszähler
         CMP     cx,it     // überschreitet CX den Wert it,
         JE      @noloop   // dann Abbruch
         { y = 2xy + cy }
         FMUL              { xy       x²    y²    cy    cx    4     }
         FADD    st,st     { 2xy      x²    y²    cy    cx    4     }
         FADD    st,st(3)  { (y)      x²    y²    cy    cx    4     }
         { x = x² - y² + cx }
         FLD     st(1)     { x²       (y)   x²    y²    cy    cx    4     }
         FSUB    st,st(3)  { x²-y²    (y)   x²    y²    cy    cx    4     }
         FADD    st,st(5)  { (x)      (y)   x²    y²    cy    cx    4     }
         { x² = x*x }
         FST     st(3)     { (x)      (y)   x²    (x)   cy    cx    4     }
         FMUL    st,st     { (x²)     (y)   x²    (x)   cy    cx    4     }
         FSTP    st(2)     { (y)      (x²)  (x)   cy    cx    4     }
         { y² = y*y }
         FLD     st        { (y)      (y)   (x²)  (x)   cy    cx    4     }
         FMUL    st,st     { (y²)     (y)   (x²)  (x)   cy    cx    4     }
         { x² + y² < 9 ??? }
         FADD    st,st(2)  { (x²+y²)  (y)   (x²)  (x)   cy    cx    4     }
         FCOM    st(6)     { (x²+y²)  (y)   (x²)  (x)   cy    cx    4     }
         FSTSW   ax
         FSUB    st,st(2)  { (y²)     (y)   (x²)  (x)   cy    cx    4     }
         FXCH    st(3)     { (x)      (y)   (x²)  (y²)  cy    cx    4     }
         AND     ah,1
         JNZ     @itloop   { falls Folge innerhalb des Kreises, dann weiter }
@noloop: MOV     i, cx
         FINIT
      END;
      if i>=it then i:=0
               else i:=i mod 256;
      farbfeld[imagenummer,x,y]:=i;
      rowrgb[3*x]:=pal[i].b;
      rowrgb[3*x+1]:=pal[i].g;
      rowrgb[3*x+2]:=pal[i].r;
    END;

      QueryPerformanceCounter(Time2);
      if time2-time1>abbruchtime then
      begin
        application.processmessages;
        if sabbruch then goto 1;
        case imagenummer of
          1 : mandel1.canvas.draw(0,0,bitmap);
          2 : mandel2.canvas.draw(0,0,bitmap);
          3 : mandel3.canvas.draw(0,0,bitmap);
          4 : mandel4.canvas.draw(0,0,bitmap);
          5 : mandel5.canvas.draw(0,0,bitmap);
          6 : mandel6.canvas.draw(0,0,bitmap);
        end;
        time1:=time2;
      end;

  END;

1: case imagenummer of
     1 : mandel1.canvas.draw(0,0,bitmap);
     2 : mandel2.canvas.draw(0,0,bitmap);
     3 : mandel3.canvas.draw(0,0,bitmap);
     4 : mandel4.canvas.draw(0,0,bitmap);
     5 : mandel5.canvas.draw(0,0,bitmap);
     6 : mandel6.canvas.draw(0,0,bitmap);
   end;
   bitmap.free;
  end;
END;
begin
    if sabbruch=true then
    begin
      QueryPerformanceFrequency(frequenz);      // Frequenz des Zählers
      abbruchtime:=frequenz div 2;

      sabbruch:=false;
      zeichnen.caption:='Abbruch';
      mandelpunkt[1].x:=ein_real(edit1);
      mandelpunkt[1].y:=ein_real(edit2);

      for i:=1 to 6 do
      begin
        val(komma(tabelle.cells[1,i]),faktor,code);
        Paintmantel(i);
      end;

      PaintboxPaint(Sender);
      zeichnen.caption:='Vergrößerungen zeichen';
    end;
    sabbruch:=true;
end;

procedure Tfmandel.superMousedown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var da,db,jufaktor,faktor,gwert:real;
    nr,code,breite,hoehe:integer;
begin
    nr:=1;
    if (sender as tpaintbox)=mandel1 then nr:=1;
    if (sender as tpaintbox)=mandel2 then nr:=2;
    if (sender as tpaintbox)=mandel3 then nr:=3;
    if (sender as tpaintbox)=mandel4 then nr:=4;
    if (sender as tpaintbox)=mandel5 then nr:=5;
    if (sender as tpaintbox)=mandel6 then nr:=6;

    val(komma(tabelle.cells[1,nr]),faktor,code);

    if abs(faktor)<0.1 then faktor:=1;
    if faktor>100000000 then faktor:=100000000;
    gwert:=4;
    breite:=mandel1.width;
    hoehe:=mandel1.height;
    jufaktor:=hoehe/breite;
    da := gwert/breite/faktor;
    db := jufaktor*gwert/hoehe/faktor;
    edit1.text:=_strkomma(mandelpunkt[1].x-da*breite/2+da*x,1,12);
    edit2.text:=_strkomma(mandelpunkt[1].y+db*hoehe/2 -db*y,1,12);
    zeichnenclick(sender);
end;

procedure Tfmandel.FormActivate(Sender: TObject);
var i:integer;
    k:string;
begin
    sabbruch:= true;
    juanzahl:=0;
    juziehen:=false;
    juziehzahl:=0;

    farbenladen('VERTIGO');
    mandelpunkt[1].x:=-1.41;
    mandelpunkt[1].y:=0;
    edit1.text:=_strkomma(mandelpunkt[1].x,1,10);
    edit2.text:=_strkomma(mandelpunkt[1].y,1,10);
    tabelle.cells[1,0]:='Faktor';
    k:='10';
    for i:=1 to 6 do
    begin
      tabelle.cells[1,i]:=k;
      k:=k+'0';
      tabelle.cells[0,i]:='Bild '+inttostr(i);
    end;
    MaPanelresize(sender);
end;

procedure Tfmandel.RadioGroup1Click(Sender: TObject);
begin
    case radiogroup1.itemindex of
      0 : farbenladen('VERTIGO');
      1 : farbenladen('SPEZIAL');
      2 : farbenladen('NEON');
      3 : farbenladen('STANDARD');
    end;
    Zeichnenclick(sender);
end;

procedure Tfmandel.FormDestroy(Sender: TObject);
var i:integer;
begin
    setlength(farbfeld,0,0,0);
    for i:=1 to 6 do bitmaprgb[i].free;
end;

procedure Tfmandel.Button1Click(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then button1.caption:='Anhalten'
                      else button1.caption:='Farbanimation';
end;

procedure Tfmandel.Timer1Timer(Sender: TObject);
var rowrgb : pbytearray;
    i,j,k,nr:integer;
    index:word;
begin
    cyclestart:=cyclestart+1;
    if cyclestart<0 then cyclestart:=255;

    for nr:=1 to 6 do
    begin
      for j:=0 to mandel1.height-1 do
      begin
        rowrgb:=bitmaprgb[nr].scanline[j];
        for i:=0 to mandel1.width-1 do
        begin
          k:=farbfeld[nr,i,j];
          if k<>0 then index:=(cyclestart+k) mod 255 +1
                  else index:=0;
          rowrgb[3*i]:=pal[index].b;
          rowrgb[3*i+1]:=pal[index].g;
          rowrgb[3*i+2]:=pal[index].r;
        end;
      end;
      case nr of
          1 : mandel1.canvas.draw(0,0,bitmaprgb[1]);
          2 : mandel2.canvas.draw(0,0,bitmaprgb[2]);
          3 : mandel3.canvas.draw(0,0,bitmaprgb[3]);
          4 : mandel4.canvas.draw(0,0,bitmaprgb[4]);
          5 : mandel5.canvas.draw(0,0,bitmaprgb[5]);
          6 : mandel6.canvas.draw(0,0,bitmaprgb[6]);
      end;
    end;
end;

end.


