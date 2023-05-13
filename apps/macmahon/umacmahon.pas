unit umacmahon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  Buttons, StdCtrls, ExtCtrls;

type
  Tmemory = class(TForm)
    P8: TPanel;
    P7: TPanel;
    D1: TButton;
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
    I14: TImage;
    I15: TImage;
    I16: TImage;
    I17: TImage;
    I18: TImage;
    I19: TImage;
    I20: TImage;
    I21: TImage;
    I22: TImage;
    I23: TImage;
    I24: TImage;
    I25: TImage;
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    P4: TPanel;
    L2: TLabel;
    R1: TRadioButton;
    R2: TRadioButton;
    R3: TRadioButton;
    L1: TLabel;
    procedure S3C(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure I1D(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I1U(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I1M(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure R1C(Sender: TObject);
    procedure R3C(Sender: TObject);
  private
    im : array[1..24] of timage;
    ii,ix,iy,px,py: integer;
    ffw : array[0..9,1..4] of integer;
    ffs : array[1..4,0..9] of integer;
    pp : array[1..4,1..4] of integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  memory: Tmemory;

implementation

{$R *.DFM}
uses Dialogs;

procedure Tmemory.S3C(Sender: TObject);
begin
  close;
end;

procedure Tmemory.FormActivate(Sender: TObject);
var i,j:integer;
    brect,qrect:trect;
begin
  fillchar(pp,sizeof(pp),0);
  fillchar(ffw,sizeof(ffw),0);
  fillchar(ffs,sizeof(ffs),0);
  for i:=1 to 4 do ffw[0,i]:=p1.color;
  for i:=1 to 4 do ffw[9,i]:=p2.color;
  for i:=1 to 4 do ffs[i,0]:=p3.color;
  for i:=1 to 4 do ffs[i,9]:=p4.color;
  for i:=1 to 24 do begin
    im[i]:=Timage(FindComponent('i'+IntToStr(i)));
    im[i].width:=76;
    im[i].height:=76;
  end;
  //hauptgifladen('s50',i25);
  brect:=i1.clientrect;
  for i:=0 to 3 do
    for j:=0 to 5 do begin
      qrect.left:=i*79;
      qrect.top:=j*80;
      qrect.right:=qrect.left+76;
      qrect.bottom:=qrect.top+76;
      im[j*4+i+1].left:=78+80*i;
      im[j*4+i+1].top:=72+80*j;
      im[j*4+i+1].canvas.copyrect(brect,i25.canvas,qrect);
    end;
  ii:=0;
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
  for y := 0 to (h-1) do begin
    rowOut := help.ScanLine[y];
    P  := Bitmap.scanline[bitmap.height-1];
    inc(p,y);
    for x := 0 to (b-1) do begin
      rowout[x] := p^;
      inc(p,h);
    end;
  end;
  bitmap.Assign(help);
  help.free;
end;

procedure Tmemory.I1D(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,j,f,gefx,gefy:integer;
    geloest:boolean;
begin
  for i:=1 to 24 do
    if sender=im[i] then ii:=i;
  if ii<>0 then begin
    if button=mbleft then begin
      ix:=im[ii].left;
      iy:=im[ii].top;
      im[ii].BringToFront;
      px:=x;
      py:=y;
      for i:=1 to 4 do
        for j:=1 to 4 do
          if pp[i,j]=ii then begin
            pp[i,j]:=0;
            ffw[2*i-1,j]:=0;
            ffw[2*i,j]:=0;
            ffs[i,2*j-1]:=0;
            ffs[i,2*j]:=0;
          end;
    end;
    if button=mbright then begin
      Drehen90Grad(im[ii].picture.bitmap);
      gefx:=0;
      gefy:=0;
      for i:=1 to 4 do
        for j:=1 to 4 do
          if pp[i,j]=ii then begin
            gefx:=i;
            gefy:=j;
          end;
      if gefx*gefy<>0 then begin
        ffw[2*gefx-1,gefy]:=im[ii].canvas.pixels[5,37];
        ffw[2*gefx,gefy]:=im[ii].canvas.pixels[70,37];
        ffs[gefx,2*gefy-1]:=im[ii].canvas.pixels[37,5];
        ffs[gefx,2*gefy]:=im[ii].canvas.pixels[37,70];
//test
        f:=0;
        for i:=1 to 4 do
          for j:=0 to 4 do begin
            if (ffw[2*j,i]<>0) and (ffw[2*j+1,i]<>0) and (ffw[2*j,i]<>ffw[2*j+1,i]) then inc(f);
          end;
        for i:=1 to 4 do
          for j:=0 to 4 do begin
            if (ffs[i,2*j]<>0) and (ffs[i,2*j+1]<>0) and (ffs[i,2*j]<>ffs[i,2*j+1]) then inc(f);
          end;
        l1.caption:=inttostr(f)+' Fehler';
        geloest:=f=0;
        for i:=1 to 4 do
          for j:=1 to 4 do
            if pp[i,j]=0 then geloest:=false;
        if geloest then showmessage('Gratulation! Das Puzzle wurde gelöst!');
//ende test
      end;
      ii:=0
     end;
   end;
end;

procedure Tmemory.I1U(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var qx,qy,nrx,nry,i,j,f:integer;
    geloest:boolean;
begin
  nrx:=0;
  nry:=0;
  if ii<>0 then begin
    qx:=ix+x;
    qy:=iy+y;
    if (qx>=p1.left) and (qx<=p1.left+300) and (qy>=160) and (qy<=460) then begin
      qx:=ix+x;
      nrx:=1+(qx-p1.left-8) div 75;
      qx:=75*((qx-p1.left-8) div 75)+p1.left+8;
    end
    else qx:=ix+x-px;
    if (qy>=160) and (qy<=460) and (qx>=p1.left) and (qx<=p1.left+300) then begin
      qy:=iy+y;
      nry:=1+(qy-160) div 75;
      qy:=75*((qy-160) div 75)+160;
    end
    else qy:=iy+y-py;
    if (nrx in [1..4]) and (nry in [1..4]) then begin
      if pp[nrx,nry]=0 then begin
        pp[nrx,nry]:=ii;
        ffw[2*nrx-1,nry]:=im[ii].canvas.pixels[5,37];
        ffw[2*nrx,nry]:=im[ii].canvas.pixels[70,37];
        ffs[nrx,2*nry-1]:=im[ii].canvas.pixels[37,5];
        ffs[nrx,2*nry]:=im[ii].canvas.pixels[37,70];
      end else begin
        qx:=ix+x-px;
        qy:=iy+y-py;
      end;
    end;
    im[ii].left:=qx;
    im[ii].top:=qy;
    ii:=0;
//test
    f:=0;
    for i:=1 to 4 do
      for j:=0 to 4 do begin
        if (ffw[2*j,i]<>0) and (ffw[2*j+1,i]<>0) and (ffw[2*j,i]<>ffw[2*j+1,i]) then inc(f);
      end;
    for i:=1 to 4 do
      for j:=0 to 4 do begin
        if (ffs[i,2*j]<>0) and (ffs[i,2*j+1]<>0) and (ffs[i,2*j]<>ffs[i,2*j+1]) then inc(f);
      end;
    l1.caption:=inttostr(f)+' Fehler';
    geloest:=f=0;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if pp[i,j]=0 then geloest:=false;
    if geloest then showmessage('Gratulation! Das Puzzle wurde gelöst!');
//ende test
  end;
end;

procedure Tmemory.I1M(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ii<>0 then begin
    im[ii].left:=ix+x-px;
    im[ii].top:=iy+y-py;
    ix:=im[ii].left;
    iy:=im[ii].top;
  end;
end;

procedure Tmemory.R1C(Sender: TObject);
var f:integer;
begin
  f:=clred;
  if sender=r2 then f:=clyellow;
  p1.Color:=f;
  p2.Color:=f;
  p3.Color:=f;
  p4.Color:=f;
  FormActivate(Sender);
end;

procedure Tmemory.R3C(Sender: TObject);
begin
  p1.Color:=clred;
  p2.Color:=clyellow;
  p3.Color:=clred;
  p4.Color:=clyellow;
  FormActivate(Sender);
end;

end.
