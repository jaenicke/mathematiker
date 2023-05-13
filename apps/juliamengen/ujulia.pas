unit ujulia;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
   Windows, SysUtils, Classes, Graphics, Controls, Forms,
   StdCtrls, ExtCtrls, Buttons, Grids, clipbrd, printers;

type

  TFjulia = class(TForm)
    Panel3: TPanel;
    Panel4: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    julia1: TPaintBox;
    julia2: TPaintBox;
    julia3: TPaintBox;
    julia4: TPaintBox;
    julia5: TPaintBox;
    julia6: TPaintBox;
    Label1: TLabel;
    pb_mandel: TPaintBox;
    Button1: TButton;
    Tabelle: TStringGrid;
    mbild: TImage;
    Label2: TLabel;
    CB_Ziehen: TCheckBox;
    Timer1: TTimer;
    C_Bewegung: TComboBox;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Button3: TButton;
    Timer2: TTimer;
    CheckBox1: TCheckBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    procedure Panel1Resize(Sender: TObject);
    PROCEDURE PaintJulia(xf,yf:double;imagenummer:integer;sender:tobject);
    procedure Zeichnen(Sender: TObject);
    procedure pb_mandelPaint(Sender: TObject);
    procedure pb_mandelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pb_mandelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pb_mandelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure S_AnimationClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
    juliabitmap:tbitmap;
    mandelpunkt:array[1..6] of record x,y:real end;
    jufaktor:real;
    juanzahl:integer;
    juziehen:boolean;
    juziehzahl:integer;
    juauf:integer;
    juwinkel:real;
    groesse:real;

    farbfeld  : array of array of array of byte;
    bitmaprgb : array[1..6] of tbitmap;
    cyclestart:integer;
    auswahlpunkt:integer;
    { Private declarations }
    procedure juliaerzeugen(var bitmap:tbitmap;Sender: TObject);
  public
    { Public declarations }
  end;

var
  Fjulia: TFjulia;

implementation

type
    tfarbe = record r,g,b:byte end;
var
    pal:array[0..255] of tfarbe;
    xPixelsPerInch : integer;

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
function vorzeichenzahlkomma(we:real;a,b:integer):string;
begin
    if we<0 then vorzeichenzahlkomma:=_strkomma(we,a,b)
            else vorzeichenzahlkomma:='+'+_strkomma(we,a,b);
    if _strkomma(we,a,b)='0' then vorzeichenzahlkomma:='+0';
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

PROCEDURE PrintBitmap(Canvas: TCanvas; DestRect: TRect; Bitmap: TBitmap);
  VAR
    BitmapHeader: pBitmapInfo;
    BitmapImage : POINTER;
    HeaderSize  : DWORD;
    ImageSize   : DWORD;
BEGIN
    GetDIBSizes(Bitmap.Handle, HeaderSize, ImageSize);
    GetMem(BitmapHeader, HeaderSize);
    GetMem(BitmapImage, ImageSize);
    TRY
      GetDIB(Bitmap.Handle, Bitmap.Palette, BitmapHeader^, BitmapImage^);
      StretchDIBits(Canvas.Handle,
        DestRect.Left, DestRect.Top,
        DestRect.Right - DestRect.Left,
        DestRect.Bottom - DestRect.Top,
        0, 0,
        Bitmap.Width, Bitmap.Height,
        BitmapImage,
        TBitmapInfo(BitmapHeader^),
        DIB_RGB_COLORS,
        SRCCOPY)
    FINALLY
      FreeMem(BitmapHeader);
      FreeMem(BitmapImage)
    END
END;

procedure normaldruckbitmap(bitmap:tbitmap);
const
    lidruck : integer = 25;
    redruck : integer = 15;
    obdruck : integer = 10;
    undruck : integer = 10;
var
  ScaleX,ScaleY:real;
  limog,obmog,lioff,oboff,reoff : Integer;
  R: TRect;
begin
    Printer.title:='Julia-Mengen';
    Printer.BeginDoc;
    with Printer do
      try
        limog:=GetDeviceCaps(Handle, physicaloffsetx);
        lioff:=round(lidruck*GetDeviceCaps(Handle,logPixelsX)/25.4)-limog;
        if lioff<0 then lioff:=0;
        reoff:=round(redruck*GetDeviceCaps(Handle,logPixelsX)/25.4)-limog;
        if reoff<0 then reoff:=0;
        obmog:=GetDeviceCaps(Handle, physicaloffsety);
        oboff:=round(obdruck*GetDeviceCaps(Handle,logPixelsY)/25.4)-obmog;
        if oboff<0 then oboff:=0;
        ScaleX := GetDeviceCaps(Handle, logPixelsX)/xPixelsPerInch;
        ScaleY := GetDeviceCaps(Handle, logPixelsY)/xpixelsPerInch;
        while scalex*bitmap.width>(pagewidth-lioff-reoff) do
        begin
          scalex:=scalex-0.02;
          scaley:=scaley-0.02;
        end;
        if scalex<=0 then scalex:=1;
        if scaley<=0 then scaley:=1;
        R := Rect(lioff, oboff, round(lioff+bitmap.Width * ScaleX),
                  round(oboff+bitmap.Height * ScaleY));
        printbitmap(printer.canvas,R,bitmap)
      finally
        EndDoc;
      end;
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

procedure TFjulia.juliaerzeugen(var bitmap:tbitmap;Sender: TObject);
var bit:tbitmap;
    birect:trect;
begin
    bit:=tbitmap.create;
    bit.width:=julia1.width;
    bit.height:=julia1.height;
    birect:=julia1.clientrect;

    bit.canvas.CopyRect(biRect,julia1.Canvas,biRect);
    bitmap.canvas.draw(0,0,bit);
    bit.canvas.CopyRect(biRect,julia2.Canvas,biRect);
    bitmap.canvas.draw(0,bit.height+1,bit);
    bit.canvas.CopyRect(biRect,julia3.Canvas,biRect);
    bitmap.canvas.draw(0,2*bit.height+2,bit);
    bit.canvas.CopyRect(biRect,julia4.Canvas,biRect);
    bitmap.canvas.draw(bit.width+1,0,bit);
    bit.canvas.CopyRect(biRect,julia5.Canvas,biRect);
    bitmap.canvas.draw(bit.width+1,bit.height+1,bit);
    bit.canvas.CopyRect(biRect,julia6.Canvas,biRect);
    bitmap.canvas.draw(bit.width+1,2*bit.height+2,bit);
    bit.free;
end;

PROCEDURE TFjulia.PaintJulia(xf,yf:double;imagenummer:integer;sender:tobject);
VAR a,b,cx,cy,da,db,radius,gwert:real;
    i,it : word;
    x,y,breite,hoehe:integer;
    rowrgb : pbytearray;
BEGIN
    gwert:=groesse;
    breite:=juliabitmap.width;
    hoehe:=juliabitmap.height;

    jufaktor:=hoehe/breite;
    it :=150;
    radius:=4;
    da := gwert/breite;
    db := jufaktor*gwert/hoehe;
    cx := xf;
    cy := yf;
    b := jufaktor*gwert/2;

    FOR y:=0 TO hoehe-1 DO
    BEGIN
      rowrgb:=juliabitmap.scanline[y];
      b := b - db;
      a := -gwert/2;
      FOR x:=0 TO breite-1 DO
      BEGIN
        a := a + da;
      ASM
         FLD     radius    { 9        }
         FLD     a         { cx       9 }
         FLD     b         { cy       cx    9     }
         FLD     st        { y        cy    cx    9    }
         FMUL    st,st     { y²       cy    cx    9    }
         FLD     st(2)     { x        y²    cy    cx    9     }
         FMUL    st,st     { x²       y²    cy    cx    9     }
         FLD     st(2)     { y        x²    y²    cy    cx    9     }
         FLD     st(4)     { x        y     x²    y²    cy    cx    9   }

         XOR     cx,cx
@itloop: INC     cx        { CX ist der Iterationszähler   }
         CMP     cx,it     { überschreitet CX den Wert it, }
         JE      @noloop   { dann keinen Bildpunkt setzen. }

         { y = 2xy + b }
         FMUL              { xy       x²    y²    cy    cx    9     }
         FADD    st,st     { 2xy      x²    y²    cy    cx    9     }
         FADD    cy        { (y)      x²    y²    cy    cx    9     }
         { x = x² - y² + a }
         FLD     st(1)     { x²       (y)   x²    y²    cy    cx    9     }
         FSUB    st,st(3)  { x²-y²    (y)   x²    y²    cy    cx    9     }
         FADD    &cx       { (x)      (y)   x²    y²    cy    cx    9     }
         { x² = x*x }
         FST     st(3)     { (x)      (y)   x²    (x)   cy    cx    9     }
         FMUL    st,st     { (x²)     (y)   x²    (x)   cy    cx    9     }
         FSTP    st(2)     { (y)      (x²)  (x)   cy    cx    9     }
         { y² = y*y }
         FLD     st        { (y)      (y)   (x²)  (x)   cy    cx    9     }
         FMUL    st,st     { (y²)     (y)   (x²)  (x)   cy    cx    9     }
         { x² + y² < 9 ??? }
         FADD    st,st(2)  { (x²+y²)  (y)   (x²)  (x)   cy    cx    9     }
         FCOM    st(6)     { (x²+y²)  (y)   (x²)  (x)   cy    cx    9     }
         FSTSW   ax
         FSUB    st,st(2)  { (y²)     (y)   (x²)  (x)   cy    cx    9     }
         FXCH    st(3)     { (x)      (y)   (x²)  (y²)  cy    cx    9     }
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
    END;

    if checkbox1.checked then
    begin
      juliabitmap.canvas.brush.style:=bsclear;
      juliabitmap.canvas.font.name:='Verdana';
      juliabitmap.canvas.TextOut(5,5,'c = '+_strkomma(xf,1,2)+' '+vorzeichenzahlkomma(yf,1,2)+'·i');
    end;

         case imagenummer of
          1 : julia1.canvas.draw(0,0,juliabitmap);
          2 : julia2.canvas.draw(0,0,juliabitmap);
          3 : julia3.canvas.draw(0,0,juliabitmap);
          4 : julia4.canvas.draw(0,0,juliabitmap);
          5 : julia5.canvas.draw(0,0,juliabitmap);
          6 : julia6.canvas.draw(0,0,juliabitmap);
        end;
END;

procedure TFjulia.FormActivate(Sender: TObject);
var i:Integer;
begin
    juanzahl:=0;
    juziehen:=false;
    juziehzahl:=0;
    juauf:=1;
    juwinkel:=0;
    groesse:=4;
    xPixelsPerInch:=pixelsperinch;
    auswahlpunkt:=1;
    
    farbenladen('VERTIGO');
    C_Bewegung.itemindex:=0;

    mandelpunkt[1].x:=-0.75;
    mandelpunkt[1].y:=0.22;
    mandelpunkt[2].x:=-0.4;
    mandelpunkt[2].y:=0.3;
    mandelpunkt[3].x:=-1.5;
    mandelpunkt[3].y:=0;
    mandelpunkt[4].x:=0;
    mandelpunkt[4].y:=-1;
    mandelpunkt[5].x:=0.37;
    mandelpunkt[5].y:=0.1;
    mandelpunkt[6].x:=-0.1;
    mandelpunkt[6].y:=-0.66;

    tabelle.colwidths[0]:=78;
    tabelle.cells[1,0]:='c reell';
    tabelle.cells[2,0]:='c imaginär';

    for i:=1 to 6 do
    begin
      tabelle.cells[1,i]:=_strkomma(mandelpunkt[i].x,1,3);
      tabelle.cells[2,i]:=_strkomma(mandelpunkt[i].y,1,3);
      tabelle.cells[0,i]:='Menge '+inttostr(i);
    end;
    panel1resize(sender);
end;

procedure TFjulia.Panel1Resize(Sender: TObject);
var bb,hh,i:integer;
begin
    bb:=(panel1.width-panel2.width) div 2;
    hh:=panel1.height div 3;
    julia1.width:=bb-1;
    julia2.width:=bb-1;
    julia3.width:=bb-1;
    julia4.width:=bb-1;
    julia5.width:=bb-1;
    julia6.width:=bb-1;
    julia1.height:=hh-1;
    julia2.height:=hh-1;
    julia3.height:=hh-1;
    julia4.height:=hh-1;
    julia5.height:=hh-1;
    julia6.height:=hh-1;

    julia1.left:=panel2.width;
    julia2.left:=panel2.width;
    julia3.left:=panel2.width;
    julia4.left:=panel2.width+bb;
    julia5.left:=panel2.width+bb;
    julia6.left:=panel2.width+bb;

    julia1.top:=1;
    julia2.top:=hh+1;
    julia3.top:=2*hh+1;
    julia4.top:=1;
    julia5.top:=hh+1;
    julia6.top:=2*hh+1;

    if juliabitmap<>nil then juliabitmap.free;
    juliabitmap:=tbitmap.create;
    juliabitmap.width:=julia1.width;
    juliabitmap.height:=julia1.height;
    juliabitmap.pixelformat:=pf24bit;

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

procedure TFjulia.Zeichnen(Sender: TObject);
var i:integer;
    code:integer;
begin
    for i:=1 to 6 do
    begin
      val(komma(tabelle.cells[1,i]),mandelpunkt[i].x,code);
      val(komma(tabelle.cells[2,i]),mandelpunkt[i].y,code);
    end;
    PaintJulia(mandelpunkt[1].x,mandelpunkt[1].y,1,sender);
    PaintJulia(mandelpunkt[2].x,mandelpunkt[2].y,2,sender);
    PaintJulia(mandelpunkt[3].x,mandelpunkt[3].y,3,sender);
    PaintJulia(mandelpunkt[4].x,mandelpunkt[4].y,4,sender);
    PaintJulia(mandelpunkt[5].x,mandelpunkt[5].y,5,sender);
    PaintJulia(mandelpunkt[6].x,mandelpunkt[6].y,6,sender);
    pb_mandelPaint(Sender);
end;

procedure TFjulia.pb_mandelPaint(Sender: TObject);
var i,x,y,breite,hoehe:integer;
    bitmap:tbitmap;
begin
    breite:=pb_mandel.width;
    hoehe:=pb_mandel.height;
    bitmap:=tbitmap.create;
    bitmap.width:=breite;
    bitmap.height:=hoehe;

    bitmap.canvas.draw(0,0,mbild.picture.bitmap);
    bitmap.canvas.font.color:=clblue;
    bitmap.canvas.pen.color:=clred;
    for i:=1 to 6 do
    begin
      x:=round(breite*(mandelpunkt[i].x+2.5)/4);
      y:=round(hoehe*(2-mandelpunkt[i].y)/4);
      bitmap.canvas.Brush.color:=clred;
      bitmap.canvas.Ellipse(x-3,y-3,x+4,y+4);
      bitmap.canvas.Brush.style:=bsclear;
      bitmap.canvas.textout(x+3,y+3,inttostr(i));
    end;
    pb_mandel.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TFjulia.pb_mandelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,breite,hoehe:Integer;
begin
    breite:=pb_mandel.width;
    hoehe:=pb_mandel.height;
    for i:=1 to 6 do
    begin
      if (abs(x-round(breite*(mandelpunkt[i].x+2.5)/4))<5) and
        (abs(y-round(hoehe*(2-mandelpunkt[i].y)/4))<5) then
      begin
        juziehen:=true;
        juziehzahl:=i
      end;
    end;
end;

procedure TFjulia.pb_mandelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var breite,hoehe:Integer;
begin
    breite:=pb_mandel.width;
    hoehe:=pb_mandel.height;
    if juziehen then
    begin
      mandelpunkt[juziehzahl].x:=4*x/breite-2.5;
      mandelpunkt[juziehzahl].y:=2-4*y/hoehe;
      tabelle.cells[1,juziehzahl]:=_strkomma(mandelpunkt[juziehzahl].x,1,3);
      tabelle.cells[2,juziehzahl]:=_strkomma(mandelpunkt[juziehzahl].y,1,3);
      if CB_Ziehen.checked then
      begin
        case juziehzahl of
          1: PaintJulia(mandelpunkt[1].x,mandelpunkt[1].y,1,sender);
          2: PaintJulia(mandelpunkt[2].x,mandelpunkt[2].y,2,sender);
          3: PaintJulia(mandelpunkt[3].x,mandelpunkt[3].y,3,sender);
          4: PaintJulia(mandelpunkt[4].x,mandelpunkt[4].y,4,sender);
          5: PaintJulia(mandelpunkt[5].x,mandelpunkt[5].y,5,sender);
          6: PaintJulia(mandelpunkt[6].x,mandelpunkt[6].y,6,sender);
        end;
      end;
      pb_mandelpaint(sender);
    end;
end;

procedure TFjulia.pb_mandelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var breite,hoehe:Integer;
begin
    breite:=pb_mandel.width;
    hoehe:=pb_mandel.height;
    if juziehen then
    begin
      juziehen:=false;
      mandelpunkt[juziehzahl].x:=4*x/breite-2.5;
      mandelpunkt[juziehzahl].y:=2-4*y/hoehe;
      tabelle.cells[1,juziehzahl]:=_strkomma(mandelpunkt[juziehzahl].x,1,3);
      tabelle.cells[2,juziehzahl]:=_strkomma(mandelpunkt[juziehzahl].y,1,3);
      case juziehzahl of
        1: PaintJulia(mandelpunkt[1].x,mandelpunkt[1].y,1,sender);
        2: PaintJulia(mandelpunkt[2].x,mandelpunkt[2].y,2,sender);
        3: PaintJulia(mandelpunkt[3].x,mandelpunkt[3].y,3,sender);
        4: PaintJulia(mandelpunkt[4].x,mandelpunkt[4].y,4,sender);
        5: PaintJulia(mandelpunkt[5].x,mandelpunkt[5].y,5,sender);
        6: PaintJulia(mandelpunkt[6].x,mandelpunkt[6].y,6,sender);
      end;
      pb_mandelpaint(sender);
    end;
end;

procedure TFjulia.S_AnimationClick(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then button2.caption:='Abbruch'
                      else button2.caption:='Animation';
end;

procedure TFjulia.Timer1Timer(Sender: TObject);
var sel:integer;
begin
    sel:=C_Bewegung.itemindex;
    case sel of
      0 : begin
            mandelpunkt[auswahlpunkt].x:=mandelpunkt[auswahlpunkt].x+juauf*0.02;
            if (mandelpunkt[auswahlpunkt].x>1.5) or (mandelpunkt[auswahlpunkt].x<-2.5) then juauf:=-juauf;
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
          end;
      1 : begin
            mandelpunkt[auswahlpunkt].y:=mandelpunkt[auswahlpunkt].y+juauf*0.02;
            if (mandelpunkt[auswahlpunkt].y>2) or (mandelpunkt[auswahlpunkt].y<-2) then juauf:=-juauf;
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
      2 : begin
            mandelpunkt[auswahlpunkt].x:=mandelpunkt[auswahlpunkt].x+juauf*0.02;
            if (mandelpunkt[auswahlpunkt].x>1.5) or (mandelpunkt[auswahlpunkt].x<-2.5) then juauf:=-juauf;
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
            mandelpunkt[auswahlpunkt].y:=mandelpunkt[auswahlpunkt].y+juauf*0.02;
            if (mandelpunkt[auswahlpunkt].y>2) or (mandelpunkt[auswahlpunkt].y<-2) then juauf:=-juauf;
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
      3 : begin
            juwinkel:=juwinkel+0.02;
            mandelpunkt[auswahlpunkt].x:=-1+0.25001*cos(juwinkel);
            mandelpunkt[auswahlpunkt].y:=-0.25001*sin(juwinkel);
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
      4 : begin
            juwinkel:=juwinkel+0.02;
            mandelpunkt[auswahlpunkt].x:=0.27-0.525*cos(juwinkel)*(1+cos(juwinkel));
            mandelpunkt[auswahlpunkt].y:=0.525*sin(juwinkel)*(1+cos(juwinkel));
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
      5 : begin
            mandelpunkt[auswahlpunkt].y:=0;
            tabelle.cells[2,auswahlpunkt]:='0';
            mandelpunkt[auswahlpunkt].x:=mandelpunkt[auswahlpunkt].x+juauf*0.02;
            if (mandelpunkt[auswahlpunkt].x>1.5) or (mandelpunkt[auswahlpunkt].x<-2.5) then juauf:=-juauf;
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
          end;
      6 : begin
            mandelpunkt[auswahlpunkt].x:=0;
            tabelle.cells[1,auswahlpunkt]:='0';
            mandelpunkt[auswahlpunkt].y:=mandelpunkt[auswahlpunkt].y+juauf*0.02;
            if (mandelpunkt[auswahlpunkt].y>2) or (mandelpunkt[auswahlpunkt].y<-2) then juauf:=-juauf;
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
      7 : begin
            juwinkel:=juwinkel+0.02;
            mandelpunkt[auswahlpunkt].x:=cos(juwinkel);
            mandelpunkt[auswahlpunkt].y:=sin(juwinkel);
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
      8 : begin
            juwinkel:=juwinkel+0.02;
            mandelpunkt[auswahlpunkt].x:=0.5*cos(juwinkel);
            mandelpunkt[auswahlpunkt].y:=0.5*sin(juwinkel);
            tabelle.cells[1,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].x,1,6);
            tabelle.cells[2,auswahlpunkt]:=_strkomma(mandelpunkt[auswahlpunkt].y,1,6);
          end;
    end;

    PaintJulia(mandelpunkt[auswahlpunkt].x,mandelpunkt[auswahlpunkt].y,auswahlpunkt,sender);
    pb_mandelpaint(sender);
end;

procedure TFjulia.RadioGroup1Click(Sender: TObject);
begin
    case radiogroup1.itemindex of
      0 : farbenladen('VERTIGO');
      1 : farbenladen('SPEZIAL');
      2 : farbenladen('NEON');
      3 : farbenladen('STANDARD');
    end;
    Zeichnen(sender);
end;

procedure TFjulia.FormDestroy(Sender: TObject);
var i:integer;
begin
    juliabitmap.free;
    setlength(farbfeld,0,0,0);
    for i:=1 to 6 do bitmaprgb[i].free;
end;

procedure TFjulia.SpeedButton1Click(Sender: TObject);
begin
    groesse:=groesse/1.1;
    zeichnen(sender);
end;

procedure TFjulia.SpeedButton2Click(Sender: TObject);
begin
    groesse:=1.1*groesse;
    zeichnen(sender);
end;

procedure TFjulia.Button3Click(Sender: TObject);
begin
    timer2.enabled:=not timer2.enabled;
    if timer2.enabled then button3.caption:='Anhalten'
                      else button3.caption:='Farbanimation';
end;

procedure TFjulia.Timer2Timer(Sender: TObject);
var rowrgb : pbytearray;
    i,j,k,nr:integer;
    index:word;
begin
    cyclestart:=cyclestart+1;
    if cyclestart<0 then cyclestart:=255;

    for nr:=1 to 6 do
    begin
      for j:=0 to julia1.height-1 do
      begin
        rowrgb:=bitmaprgb[nr].scanline[j];
        for i:=0 to julia1.width-1 do
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
          1 : julia1.canvas.draw(0,0,bitmaprgb[1]);
          2 : julia2.canvas.draw(0,0,bitmaprgb[2]);
          3 : julia3.canvas.draw(0,0,bitmaprgb[3]);
          4 : julia4.canvas.draw(0,0,bitmaprgb[4]);
          5 : julia5.canvas.draw(0,0,bitmaprgb[5]);
          6 : julia6.canvas.draw(0,0,bitmaprgb[6]);
      end;
    end;
end;

procedure TFjulia.SpeedButton4Click(Sender: TObject);
var bitmap:tbitmap;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=2*julia1.width+1;
    bitmap.height:=3*julia1.height+2;
    juliaerzeugen(bitmap,sender);
    Clipboard.Assign(Bitmap);
    bitmap.free;
end;

procedure TFjulia.SpeedButton3Click(Sender: TObject);
var bitmap:tbitmap;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=2*julia1.width+1;
    bitmap.height:=3*julia1.height+2;
    juliaerzeugen(bitmap,sender);
    normaldruckbitmap(bitmap);
    bitmap.free;
end;

procedure TFjulia.RadioButton1Click(Sender: TObject);
begin
    auswahlpunkt:=1;
    if radiobutton2.checked then auswahlpunkt:=2;
    if radiobutton3.checked then auswahlpunkt:=3;
    if radiobutton4.checked then auswahlpunkt:=4;
    if radiobutton5.checked then auswahlpunkt:=5;
    if radiobutton6.checked then auswahlpunkt:=6;
end;

end.


