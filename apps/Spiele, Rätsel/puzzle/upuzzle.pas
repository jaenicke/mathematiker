unit upuzzle;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ComCtrls, jpeg, StdCtrls, Menus, ExtDlgs;

const puzzlebilder = 25;

type
  TFormpu = class(TForm)
    PM1: TPopupMenu;
    M35: TMenuItem;
    MM1: TMainMenu;
    M33: TMenuItem;
    M57: TMenuItem;
    f_puzzle: TPanel;
    Panel1: TPanel;
    Panel4: TPanel;
    Image5: TImage;
    PaintBox1: TPaintBox;
    Image1: TImage;
    RG1: TRadioGroup;
    Image2: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RG2: TRadioGroup;
    OP1: TOpenPictureDialog;
    Image3: TImage;
    Memo1: TMemo;
    Listbox1: TListBox;
    Panel17: TPanel;
    Image4: TImage;
    Button1: TButton;
    Button4: TButton;
    Button2: TButton;
    procedure S1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure puzzledarstellen(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure richtigd(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Formpu: TFormpu;

implementation

{$R *.DFM}

const puzzleschieben: boolean=false;
      puzzleteile:integer = 12;
      nochkeinbild:boolean=true;

var
    puzzlef:array[0..17,0..13] of record
                                    m:integer; n:integer
                                  end;
    schongezogen:array[1..puzzlebilder] of boolean;
    puzzlezeit,puzzlezug:integer;
    pux,puy,puvx,puvy,pui,puj,x12,y12,b12:integer;

procedure TFormpu.FormActivate(Sender: TObject);
var I:integer;
begin
    randomize;
    rg1.itemindex:=1;
    paintbox1.top:=48;
    Image5.top:=48;
    nochkeinbild:=true;
    for i:=1 to puzzlebilder do schongezogen[i]:=false;
    Button1Click(Sender);
end;

type
TRGBArray    = ARRAY[0..0] OF TRGBTriple;
pRGBArray    = ^TRGBArray;

type THelpRGB = packed record
                   rgb    : TRGBTriple;
                   dummy  : byte;
                end;
type TMyhelp = array[0..0] of TRGBQuad;

procedure Drehen90Grad(Bitmap:TBitmap);
var P       : PRGBQuad;
    x,y,b,h : Integer;
    RowOut  : ^TMyHelp;
    help    : TBitmap;
BEGIN
    Bitmap.PixelFormat := pf32bit;
    help := TBitmap.Create;
    help.PixelFormat := pf32bit;
    b := bitmap.Height;
    h := bitmap.Width;
    help.Width := b;
    help.height := h;
    for y := 0 to (h-1) do
    begin
      rowOut := help.ScanLine[y];
      P  := Bitmap.scanline[bitmap.height-1];
      inc(p,y);
      for x := 0 to (b-1) do
      begin
        rowout[x] := p^;
        inc(p,h);
      end;
    end;
    bitmap.Assign(help);
    help.free;
end;

procedure TFormpu.puzzledarstellen(Sender: TObject);
var myrect,birect,nrect:trect;
    bitmap:tbitmap;
    ii,i,j,z1,z2,korrekt:integer;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=640;
    bitmap.height:=480;

    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        z2:=(puzzlef[i,j].m-1) div x12 +1;
        z1:=(puzzlef[i,j].m-1) mod x12 +1;

        nRect := Rect(0,0,b12,b12);
        BiRect := Rect((i-1)*b12,(j-1)*b12,i*b12,j*b12);
        case b12 of
          40 : begin
                 image4.canvas.copyrect(nrect,Image5.canvas,birect);
                 image4.Picture.bitmap.PixelFormat := pf24bit;
               end;
          80 : begin
                 image2.canvas.copyrect(nrect,Image5.canvas,birect);
                 image2.Picture.bitmap.PixelFormat := pf24bit;
               end;
          else begin
                 image1.canvas.copyrect(nrect,Image5.canvas,birect);
                 image1.Picture.bitmap.PixelFormat := pf24bit;
        end;
      end;

    if puzzlef[i,j].n mod 4>0 then
    begin
      for ii:=1 to puzzlef[i,j].n mod 4 do
        case b12 of
          40 : Drehen90Grad(image4.picture.bitmap);
          80 : Drehen90Grad(image2.picture.bitmap);
          else Drehen90Grad(image1.picture.bitmap);
        end;
    end;

    if not (puzzleschieben and (i=pui) and (j=puj)) then
    begin
      myRect := Rect((z1-1)*b12,(z2-1)*b12,z1*b12,z2*b12);
      case b12 of
        40 : bitmap.canvas.copyrect(myrect,image4.canvas,nrect);
        80 : bitmap.canvas.copyrect(myrect,image2.canvas,nrect);
        else bitmap.canvas.copyrect(myrect,image1.canvas,nrect);
      end;
    end;
    end;

    if puzzleschieben then
    begin
      z2:=(puzzlef[pui,puj].m-1) div x12 +1;
      z1:=(puzzlef[pui,puj].m-1) mod x12 +1;
      nRect := Rect(0,0,b12,b12);
      BiRect := Rect((pui-1)*b12,(puj-1)*b12,pui*b12,puj*b12);
      case b12 of
        40 : begin
               image4.canvas.copyrect(nrect,Image5.canvas,birect);
               image4.Picture.bitmap.PixelFormat := pf24bit;
             end;
        80 : begin
               image2.canvas.copyrect(nrect,Image5.canvas,birect);
               image2.Picture.bitmap.PixelFormat := pf24bit;
             end;
        else begin
              image1.canvas.copyrect(nrect,Image5.canvas,birect);
              image1.Picture.bitmap.PixelFormat := pf24bit;
             end;
      end;

      if puzzlef[pui,puj].n mod 4>0 then
      begin
        for ii:=1 to puzzlef[pui,puj].n mod 4 do
        begin
          case b12 of
            40 : Drehen90Grad(image4.picture.bitmap);
            80 : Drehen90Grad(image2.picture.bitmap);
            else Drehen90Grad(image1.picture.bitmap);
          end;
        end;
      end;

      myRect := Rect((z1-1)*b12-puvx,(z2-1)*b12-puvy,z1*b12-puvx,z2*b12-puvy);

      case b12 of
        40 : bitmap.canvas.copyrect(myrect,image4.canvas,nrect);
        80 : bitmap.canvas.copyrect(myrect,image2.canvas,nrect);
        else bitmap.canvas.copyrect(myrect,image1.canvas,nrect);
      end;
    end;

    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
    Label1.caption:='Züge '+inttostr(puzzlezug); korrekt:=0;
    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        if (puzzlef[i,j].m=i+(j-1)*x12) and (puzzlef[i,j].n=0) then inc(korrekt);
      end;
      Label3.caption:='korrekte Teile '+inttostr(korrekt);
    if (korrekt=x12*y12) and (not nochkeinbild) then
    begin
      timer1.enabled:=false;
      showmessage('Gratulation! Sie haben das Bild korrekt zusammengesetzt!');
      nochkeinbild:=true;
    end;
end;

procedure TFormpu.Button1Click(Sender: TObject);
var nr:integer;
begin
     nr:=random(puzzlebilder);
     Listbox1.itemindex:=nr;
     listbox1click(sender);
end;

procedure TFormpu.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var z1,z2,i,j,i1,j1,modu:integer;
begin
    if button=mbright then
    begin
      i1:=1;
      j1:=1;
      modu:=1;
      if rg2.itemindex=1 then modu:=4;
      z1:=(x div b12)+1;
      z2:=y div b12;
      z1:=z2*x12+z1;
      for i:=1 to x12 do
        for j:=1 to y12 do
          if puzzlef[i,j].m=z1 then
          begin
            i1:=i;
            j1:=j
          end;
      puzzlef[i1,j1].n:=(puzzlef[i1,j1].n + 1) mod modu;
      inc(puzzlezug);
      puzzledarstellen(sender);
      exit;
    end;
    if button=mbleft then
    begin
      z1:=(x div b12)+1;
      z2:=y div b12;
      z1:=z2*x12+z1;
      for i:=1 to x12 do
        for j:=1 to y12 do
          if puzzlef[i,j].m=z1 then
          begin
            pui:=i;
            puj:=j;
            pux:=x;
            puy:=y
          end;
      puzzleschieben:=true;
    end;
end;

procedure TFormpu.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if puzzleschieben then
    begin
      puvx:=pux-x;
      puvy:=puy-y;
      puzzledarstellen(sender);
    end;
end;

procedure TFormpu.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a,b,z1,z2,i,j,h1:integer;
begin
    if puzzleschieben then
    begin
      a:=1;
      b:=1;
      puzzleschieben:=false;
      z1:=x div b12;
      z2:=y div b12;
      if z1>x12-1 then z1:=x12-1;
      if z2>y12-1 then z2:=y12-1;
      if z1<0 then z1:=0;
      if z2<0 then z2:=0;
      z1:=z2*x12+z1+1;
      for i:=1 to x12 do
        for j:=1 to y12 do
          if puzzlef[i,j].m=z1 then
          begin
            a:=i;
            b:=j;
          end;
      if (a<>pui) or (b<>puj) then
      begin
        h1:=puzzlef[pui,puj].m;
        puzzlef[pui,puj].m:=puzzlef[a,b].m;
        puzzlef[a,b].m:=h1;
      end;
      inc(puzzlezug);
      puzzledarstellen(sender);
    end;
end;

procedure TFormpu.Timer1Timer(Sender: TObject);
var z:integer;
    k:string;
begin
    z:=(integer(gettickcount)-integer(puzzlezeit)) div 1000;
    k:=inttostr(z mod 60);
    while length(k)<2 do k:='0'+k;
    k:=inttostr(z div 60)+':'+k;
    Label2.caption:='Zeit  '+k+' min';
end;

procedure TFormpu.Button2Click(Sender: TObject);
var x:integer;
begin
    puzzlezeit:=puzzlezeit-10000;
    x:=integer(gettickcount);
    Image5.visible:=true;
    repeat
      application.processmessages;
    until integer(gettickcount)-x>2500;
    Image5.visible:=false;
end;

procedure TFormpu.Button4Click(Sender: TObject);
var i,j,nh,n1,n2,modu:integer;
    nrect,birect:trect;
    reihe:array[1..200] of integer;

procedure ladejpg(const FileName: String; Bild: TBitMap);
var Jpeg: TJpegImage;
begin
   Jpeg:=TJpegImage.Create;
   jpeg.LoadFromFile(filename);
   Bild.Assign(Jpeg);
   jpeg.free;
end;

begin
    op1.filterindex:=1;
    op1.filename:='';
    if op1.execute then
    begin
      if op1.filterindex=1 then ladejpg(op1.filename,image3.picture.bitMap);

      nRect := Rect(0,0,640,480);
      BiRect := Rect(0,0,image3.width,image3.height);
      Image5.canvas.stretchdraw(nrect,image3.picture.bitmap);
      case rg1.itemindex of
        0 : begin x12:=4; y12:=3; b12:=160 end;
        2 : begin x12:=16; y12:=12; b12:=40 end;
       else begin x12:=8; y12:=6; b12:=80 end;
      end;

      nochkeinbild:=false;
      for i:=1 to x12*y12 do reihe[i]:=i;
      for i:=1 to 200 do
      begin
        n1:=random(x12*y12)+1;
        n2:=random(x12*y12)+1;
        nh:=reihe[n1];
        reihe[n1]:=reihe[n2];
        reihe[n2]:=nh;
      end;
      modu:=1;
      if rg2.itemindex=1 then modu:=4;
      for i:=1 to x12 do
        for j:=1 to y12 do
        begin
          puzzlef[i,j].m:=reihe[(i-1)*y12+j];
          puzzlef[i,j].n:=random(modu);
        end;
      timer1.enabled:=true;
      puzzlezeit:=integer(gettickcount);
      puzzlezug:=0;
      puzzledarstellen(sender);
    end;
end;

procedure TFormpu.richtigd(Sender: TObject);
var i,j:integer;
begin
    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        puzzlef[i,j].n:=0;
      end;
    puzzledarstellen(sender);
end;

{procedure puzzlejpgladen(const kk:string;image:timage);
var
  h :HINST;
  r :TResourceStream;
  j :TJpegImage;
  s : array[0..500] of char;
  verzeichnis:string;
procedure backslash(var k:string);
begin
    if k[length(k)]<>'\' then k:=k+'\';
end;
begin
  verzeichnis:=extractfilepath(application.exename);
  backslash(verzeichnis);
  strpcopy(s,verzeichnis+'bpuzzle.dll');
  h := LoadLibraryex(s,0,LOAD_LIBRARY_AS_DATAFILE);
  try
    r := TResourceStream.Create(h, kk, 'Jpeg');
    j := TJpegImage.Create;
      try
        j.LoadFromStream(r);
        Image.Picture.Bitmap.Assign(j);
      finally
        j.Free;
        r.Free;
      end;
  finally
  FreeLibrary(h);
  end;
end;}
procedure puzzlejpgladen(const kk:string;image:timage);
var
  r :TResourceStream;
  j :TJpegImage;
begin
    r := TResourceStream.Create(hinstance, kk, 'Jpeg');
    j := TJpegImage.Create;
      try
        j.LoadFromStream(r);
        Image.Picture.Bitmap.Assign(j);
      finally
        j.Free;
        r.Free;
      end;
end;

procedure TFormpu.ListBox1Click(Sender: TObject);
var reihe:array[1..200] of integer;
    modu,nh,n1,n2,i,j:integer;
    k,k2:string;
begin
    case rg1.itemindex of
      0 : begin x12:=4; y12:=3; b12:=160 end;
      2 : begin x12:=16; y12:=12; b12:=40 end;
     else begin x12:=8; y12:=6; b12:=80 end;
    end;
    k2:=Listbox1.items[Listbox1.itemindex];

    k:=Listbox1.items[Listbox1.itemindex];
    delete(k,1,pos(#9,k));
    puzzlejpgladen('puz'+k,Image5);
    nochkeinbild:=false;

    for i:=1 to x12*y12 do reihe[i]:=i;

      for i:=1 to 200 do
      begin
        n1:=random(x12*y12)+1;
        n2:=random(x12*y12)+1;
        nh:=reihe[n1];
        reihe[n1]:=reihe[n2];
        reihe[n2]:=nh;
      end;

    modu:=1;
    if rg2.itemindex=1 then modu:=4;
    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        puzzlef[i,j].m:=reihe[(i-1)*y12+j];
        puzzlef[i,j].n:=random(modu);
      end;
    timer1.enabled:=true;
    puzzlezeit:=integer(gettickcount);
    puzzlezug:=0;
    puzzledarstellen(sender);
end;

procedure TFormpu.S1Click(Sender: TObject);
begin
    close;
end;

end.

