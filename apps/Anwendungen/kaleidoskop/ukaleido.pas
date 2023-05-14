unit ukaleido;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, math, jpeg, ExtDlgs, ExtCtrls;

type
  Tkaform = class(TForm)
    LadenD: TOpenPictureDialog;
    Panel6: TPanel;
    kaleido: TPanel;
    Panel1: TPanel;
    Image3: TImage;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Button1: TButton;
    Liste: TListBox;
    auswahl1: TRadioGroup;
    auswahl2: TRadioGroup;
    Panel2: TPanel;
    Panel3: TPanel;
    PBrechts: TPaintBox;
    Panel7: TPanel;
    Panel4: TPanel;
    PBlinks: TPaintBox;
    Panel5: TPanel;
    procedure Panel51Resize(Sender: TObject);
    procedure ListeClick(Sender: TObject);
    procedure PBrechtsPaint(Sender: TObject);
    procedure PBlinksPaint(Sender: TObject);
    procedure PB3MDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB3MMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB3MUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure auswahl2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    Schritt                 : integer;
    dreieck:integer;
  end;

var
  kaform: Tkaform;

implementation

{$R *.DFM}
var xk,yk,xzie,yzie:integer;
    kaziehen:boolean;

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

procedure Tkaform.ListeClick(Sender: TObject);
var  k:string;
begin
     k:=liste.items[liste.itemindex];
     delete(k,1,pos(#9,k));
     puzzlejpgladen('puz'+k,image3);
     pbrechtspaint(sender);
end;

procedure Tkaform.PBrechtsPaint(Sender: TObject);
var bitmap:tbitmap;
    zrect,qrect:trect;
begin
    zrect.left:=0;
    zrect.top:=0;
    zrect.right:=480;
    zrect.bottom:=360;
    qrect:=zrect;
    bitmap:=tbitmap.create;
    bitmap.width:=PBrechts.width;
    bitmap.height:=PBrechts.height;
    bitmap.canvas.stretchdraw(zrect,image3.picture.bitmap);
    bitmap.canvas.brush.style:=bsclear;
    bitmap.canvas.pen.color:=clred;
    bitmap.canvas.rectangle(xk,yk,xk+81,yk+81);
    PBrechts.canvas.draw(0,0,bitmap);
    bitmap.free;
    PBlinkspaint(sender);
end;

procedure Tkaform.PBlinksPaint(Sender: TObject);
var bitmap:tbitmap;
    zrect,qrect:trect;
    ii,jj,v,v1,v2,modu,anz:integer;
    pu:array[0..4] of tpoint;
type
  TRGBArray = ARRAY[0..32767] OF TRGBTriple;
  pRGBArray = ^TRGBArray;
  TMyhelp = array[0..0] of TRGBQuad;
procedure Drehen90Grad(xBitmap:TBitmap);
var P       : PRGBQuad;
    x,y,b,h : Integer;
    RowOut  : ^TMyHelp;
    help    : TBitmap;

BEGIN
    xBitmap.PixelFormat := pf32bit;
    help := TBitmap.Create;
    help.PixelFormat := pf32bit;
    b := xbitmap.Height;
    h := xbitmap.Width;
    help.Width := b;
    help.height := h;
    for y := 0 to (h-1) do
    begin
      rowOut := help.ScanLine[y];
      P  := xBitmap.scanline[xbitmap.height-1];
      inc(p,y);
      for x := 0 to (b-1) do
      begin
        rowout[x] := p^;
        inc(p,h);
      end;
    end;
    xbitmap.Assign(help);
    help.free;
end;
procedure SpiegelnHorizontal(Bitmap:TBitmap);
var i,j,w :  INTEGER;
    RowIn :  pRGBArray;
    RowOut:  pRGBArray;

begin
    w := bitmap.width*sizeof(TRGBTriple);
    Getmem(rowin,w);
    for j := 0 to Bitmap.Height-1 do
    begin
      move(Bitmap.Scanline[j]^,rowin^,w);
      rowout := Bitmap.Scanline[j];
      for i := 0 to Bitmap.Width-1 do rowout[i] := rowin[Bitmap.Width-1-i];
    end;
    bitmap.Assign(bitmap);
    Freemem(rowin);
end;
procedure kopieren(x,y:integer);
var i,j:integer;
begin
    for i:=0 to anz do
    begin
      for j:=0 to anz do
      begin
        bitmap.canvas.draw((x+v+i*160) mod modu,(y+v+j*160) mod modu,image1.picture.bitmap);
      end
    end;
end;
procedure kopierend(x,y:integer);
var i,j:integer;
begin
    for i:=-1 to anz+1 do
    begin
      for j:=-1 to anz+1 do
      begin
        bitmap.canvas.draw((x+v+i*138),round(y+v+j*160),image1.picture.bitmap);
        bitmap.canvas.draw((x+v+i*138)+69,round(y+v+j*160)+40,image1.picture.bitmap);
      end
    end;
end;
procedure dreieckdrehen;
type SiCoDiType= record si, co, di:real; end;
var Center, NewCenter: record x,y:real end;
    theta: real;
    i: Integer;
    Bitmap, NewBitMap: Tbitmap;
function SiCoDiPoint ( const p1: tpoint; p2x,p2y:real ): SiCoDiType;
var dx, dy: real;
begin
    dx := ( p2x - p1.x );
    dy := ( p2y - p1.y );
    with RESULT do
    begin
      di := HYPOT( dx, dy );
      if abs( di )<1 then
      begin
        si := 0.0;
        co := 1.0
      end
      else
      begin
        si := dy/di;
        co := dx/di
      end;
    end;
end;
PROCEDURE RotateBitmap(
	const BitmapOriginal:TBitMap;
	out   BitMapRotated:TBitMap;
	const theta:real;
	const oldAxisx,oldaxisy:real;
	var   newAxisx,newaxisy:real);
	VAR
	cosTheta       :  Single;
	sinTheta       :  Single;
	i              :  INTEGER;
	iOriginal      :  INTEGER;
	iPrime         :  INTEGER;
	j              :  INTEGER;
	jOriginal      :  INTEGER;
	jPrime         :  INTEGER;
	NewWidth,NewHeight:INTEGER;
	Oht,Owi,Rht,Rwi: Integer;
	type 	TRGBQuadArray = array [0..32767]  of TRGBQuad;
		pRGBQuadArray = ^TRGBQuadArray;
	var     RowRotatedQ: pRGBquadArray;
		TransparentQ: TRGBQuad;
var  SiCoPhi: SiCoDiType;
begin
    with BitMapOriginal do
    begin
      PixelFormat := pf32bit; //nbytes:=4;
      BitmapRotated.Assign( BitMapOriginal);
      sinTheta := SIN( theta ); cosTheta := COS( theta );
      NewWidth  := ABS( ROUND( Height*sinTheta) ) + ABS( ROUND( Width*cosTheta ) );
      NewHeight := ABS( ROUND( Width*sinTheta ) ) + ABS( ROUND( Height*cosTheta) );
      if ( ABS(theta)*MAX( width,height ) ) > 1 then
      begin
	BitmapRotated.Width  := NewWidth; BitmapRotated.Height := NewHeight;
	Rwi := NewWidth - 1;
	Rht := NewHeight - 1;
	Owi := Width - 1;
	Oht := Height - 1;
        TransparentQ := pRGBquadArray  ( Scanline[ Oht ] )[0];
	FOR j := Rht DOWNTO 0 DO
        BEGIN
          RowRotatedQ := BitmapRotated.Scanline[ j ] ;
	  jPrime := 2*j - NewHeight + 1 ;
          FOR i := Rwi DOWNTO 0 DO
          BEGIN
            iPrime := 2*i - NewWidth   + 1;
            iOriginal := ( ROUND( iPrime*CosTheta - jPrime*sinTheta ) -1 + width ) DIV 2;
	    jOriginal := ( ROUND( iPrime*sinTheta + jPrime*cosTheta ) -1 + height) DIV 2 ;
            IF   ( iOriginal >= 0 ) AND ( iOriginal <= Owi ) AND
     	    	 ( jOriginal >= 0 ) AND ( jOriginal <= Oht ) THEN
            BEGIN
              RowRotatedQ[i] := pRGBquadArray(   Scanline[jOriginal] )[iOriginal];
            END
	    ELSE
            BEGIN
              RowRotatedQ[i] := TransparentQ;
   	    END
          END
        eND;
      end;
      sicoPhi := sicodiPoint(  POINT( width div 2, height div 2 ),oldaxisx,oldaxisy );
      with sicoPhi do
      begin
        NewAxisx := round(newWidth/2 + di*(CosTheta*co - SinTheta*si));
        NewAxisy := round(newHeight/2- di*(SinTheta*co + CosTheta*si));
      end;
    end;
END;
begin
    Bitmap := Tbitmap.Create;
    bitmap.width:=80;
    bitmap.height:=80;
    bitmap.canvas.draw(0,0,image1.picture.bitmap);
    NewBitmap := Tbitmap.Create;
    Bitmap.Transparent := true;
    Center.x := bitmap.width div 2;
    center.y := bitmap.Height div 2;
    for i:= 0 to 5 do
    begin
      theta := 60.0*i*pi/180 ;
      RotateBitmap( Bitmap, NewBitMap, theta, Center.x,center.y, NewCenter.x,newcenter.y );
      image2.Canvas.Draw(round(80+40.0*cos(theta)-newcenter.x),
                         round(80-40.0*sin(theta)-newcenter.y), NewBitmap );
    end;
    Bitmap.Free;
    NewBitMap.Free;
end;

begin
    bitmap:=tbitmap.create;
    bitmap.width:=480;
    bitmap.height:=360;

    zrect.left:=0;
    zrect.top:=0;
    zrect.right:=480;
    zrect.bottom:=360;
    bitmap.canvas.stretchdraw(zrect,image3.picture.bitmap);
    zrect.left:=0;
    zrect.top:=0;
    zrect.right:=80;
    zrect.bottom:=80;
    qrect.left:=xk;
    qrect.top:=yk;
    qrect.right:=xk+80;
    qrect.bottom:=yk+80;
    image1.canvas.copyrect(zrect,bitmap.canvas,qrect);
    bitmap.free;
    if auswahl1.itemindex in [4] then
    begin
      image1.canvas.pen.style:=psclear;
      image1.canvas.brush.color:=clwhite;
      pu[0].x:=0; pu[0].y:=39;
      pu[1].x:=0; pu[1].y:=0;
      pu[2].x:=69; pu[2].y:=0;
      image1.canvas.polygon(slice(pu,3));
      pu[0].x:=0; pu[0].y:=41;
      pu[1].x:=0; pu[1].y:=80;
      pu[2].x:=69; pu[2].y:=80;
      image1.canvas.polygon(slice(pu,3));
      pu[0].x:=69; pu[0].y:=0;
      pu[1].x:=81; pu[1].y:=0;
      pu[2].x:=81; pu[2].y:=80;
      pu[3].x:=69; pu[3].y:=80;
      image1.canvas.polygon(slice(pu,4));
    end;
    if auswahl1.itemindex in [5] then
    begin
      image1.Picture.bitmap.PixelFormat := pf24bit;
      image1.canvas.pen.style:=psclear;
      image1.canvas.brush.color:=clwhite;
      pu[0].x:=0; pu[0].y:=39;
      pu[1].x:=0; pu[1].y:=-1;
      pu[2].x:=69; pu[2].y:=-1;
      image1.canvas.polygon(slice(pu,3));
      pu[0].x:=0; pu[0].y:=41;
      pu[1].x:=0; pu[1].y:=81;
      pu[2].x:=69; pu[2].y:=81;
      image1.canvas.polygon(slice(pu,3));
      pu[0].x:=72; pu[0].y:=0;
      pu[1].x:=81; pu[1].y:=0;
      pu[2].x:=81; pu[2].y:=80;
      pu[3].x:=72; pu[3].y:=80;
      image1.canvas.polygon(slice(pu,4));
      image1.Picture.bitmap.PixelFormat := pf24bit;
      image2.canvas.brush.color:=clwhite;
      image2.canvas.rectangle(-1,-1,image2.width+1,image2.width+1);
      dreieckdrehen;
      image2.canvas.brush.color:=clwhite;
      image2.canvas.pen.color:=clwhite;
      image2.canvas.rectangle(-1,-1,11,163);
      image2.canvas.rectangle(151,-1,163,163);
      pu[2].x:=-1; pu[2].y:=-1;
      pu[0].x:=-1; pu[0].y:=46;
      pu[1].x:=79; pu[1].y:=-1;
      image2.canvas.polygon(slice(pu,3));
      pu[0].x:=161; pu[0].y:=161;
      pu[1].x:=80; pu[1].y:=161;
      pu[2].x:=161; pu[2].y:=114;
      image2.canvas.polygon(slice(pu,3));
      pu[0].x:=1; pu[0].y:=161;
      pu[1].x:=79; pu[1].y:=161;
      pu[2].x:=1; pu[2].y:=114;
      image2.canvas.polygon(slice(pu,3));
      pu[2].x:=161; pu[2].y:=-2;
      pu[0].x:=161; pu[0].y:=46;
      pu[1].x:=80; pu[1].y:=-2;
      image2.canvas.polygon(slice(pu,3));
    end;
    v1:=1;
    v2:=3;
    modu:=320;
    anz:=1;
    if auswahl2.itemindex=1 then
    begin
      v1:=0;
      v2:=2;
      modu:=480;
      anz:=2;
    end;
    bitmap:=tbitmap.create;
    bitmap.width:=PBlinks.width;
    bitmap.height:=PBlinks.height;
    v:=0;
    case auswahl1.itemindex of
      0,1 : begin
              if auswahl1.itemindex=v1 then v:=80;
              image1.Picture.bitmap.PixelFormat := pf24bit;
              kopieren(0,0);
              Drehen90Grad(image1.picture.Bitmap);
              Drehen90Grad(image1.picture.Bitmap);
              kopieren(80,80);
              Drehen90Grad(image1.picture.Bitmap);
              kopieren(0,80);
              Drehen90Grad(image1.picture.Bitmap);
              Drehen90Grad(image1.picture.Bitmap);
              kopieren(80,0);
            end;
      2,3 : begin
              if auswahl1.itemindex=v2 then v:=80;
              image1.Picture.bitmap.PixelFormat := pf24bit;
              kopieren(0,0);
              spiegelnhorizontal(image1.picture.Bitmap);
              kopieren(80,0);
              spiegelnhorizontal(image1.picture.Bitmap);
              Drehen90Grad(image1.picture.Bitmap);
              Drehen90Grad(image1.picture.Bitmap);
              kopieren(80,80);
              image1.Picture.bitmap.PixelFormat := pf24bit;
              spiegelnhorizontal(image1.picture.Bitmap);
              kopieren(0,80);
            end;
        4 : begin
              v:=-10;
              image1.Picture.bitmap.PixelFormat := pf24bit;
              bitmap.canvas.copymode:=cmsrcand;
              kopierend(11,0);
              spiegelnhorizontal(image1.picture.Bitmap);
              kopierend(69,0);
              spiegelnhorizontal(image1.picture.Bitmap);
              Drehen90Grad(image1.picture.Bitmap);
              Drehen90Grad(image1.picture.Bitmap);
              kopierend(69,81);
              image1.Picture.bitmap.PixelFormat := pf24bit;
              spiegelnhorizontal(image1.picture.Bitmap);
              kopierend(11,81);
              bitmap.canvas.copymode:=cmsrccopy;
            end;
        5 : begin
              bitmap.canvas.copymode:=cmsrcand;
              ii:=-2;
              repeat
                jj:=-1;
                repeat
                  if odd(jj) then
                  begin
                    bitmap.canvas.draw(80+ii*140,round(80+jj*120),image2.picture.bitmap);
                  end
                  else
                    bitmap.canvas.draw(80+ii*140+70,round(80+jj*120),image2.picture.bitmap);
                  inc(jj,1);
                until 80+jj*120>PBlinks.width;
                inc(ii);
              until 80+ii*140>PBlinks.width;
              bitmap.canvas.copymode:=cmsrccopy;
            end;
    end;
    PBlinks.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tkaform.PB3MDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if (x>xk) and (x<xk+81) and (y>yk) and (y<yk+81) then
    begin
      kaziehen:=true;
      xzie:=x-xk;
      yzie:=y-yk;
    end;
end;

procedure Tkaform.PB3MMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if kaziehen then
    begin
      xk:=x-xzie;
      yk:=y-yzie;
      if xk<0 then xk:=0;
      if yk<0 then yk:=0;
      if xk>400 then xk:=400;
      if yk>280 then yk:=280;
      pbrechtspaint(sender);
    end;
end;

procedure Tkaform.PB3MUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    kaziehen:=false;
end;

procedure ladejpg(const FileName: String; Bild: TBitMap);
var Jpeg: TJpegImage;
begin
    Jpeg:=TJpegImage.Create;
    jpeg.LoadFromFile(filename);
    Bild.Assign(Jpeg);
    jpeg.free;
end;

procedure Tkaform.Button1Click(Sender: TObject);
begin
    if LadenD.Execute then
    begin
      case LadenD.filterindex of
        1: ladejpg(LadenD.FileName,image3.picture.bitmap);
        2: Image3.Picture.LoadFromFile(LadenD.FileName);
      end;
      pbrechtspaint(sender);
    end;
end;

procedure Tkaform.auswahl2Click(Sender: TObject);
var b:integer;
begin
    if auswahl2.itemindex=0 then b:=320 else b:=480;
    PBlinks.left:=(panel4.width-b) div 2;
    PBlinks.top:=(panel4.height-b) div 2;
    PBlinks.width:=b;
    PBlinks.height:=b;
    pbrechtspaint(sender);
end;

procedure Tkaform.Panel51Resize(Sender: TObject);
begin
    if panel1.width<1040 then panel3.width:=520
                         else panel3.width:=panel1.width div 2;
    PBrechts.top:=(panel2.height-360) div 2;
    PBrechts.left:=(panel3.width-480) div 2;
    PBlinks.left:=(panel4.width-320) div 2;
    PBlinks.top:=(panel4.height-320) div 2;
end;

procedure Tkaform.FormActivate(Sender: TObject);
begin
    randomize;
    xzie:=0;
    yzie:=0;
    xk:=0;
    yk:=0;
    kaziehen:=false;
    liste.itemindex:=random(liste.items.count);
    listeclick(sender);
end;

end.
