unit qrunit;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, printers,
  Dialogs, ExtCtrls, StdCtrls, Menus, Spin, Buttons, clipbrd, ComCtrls;

type
  Tqrform = class(TForm)
    qrcode: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    S5: TSpeedButton;
    S33: TSpeedButton;
    S11: TSpeedButton;
    Button4: TButton;
    Memo2: TMemo;
    Panel3: TPanel;
    Image3: TImage;
    Panel4: TPanel;
    Panel5: TPanel;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure S33Click(Sender: TObject);
    procedure S11Click(Sender: TObject);
    procedure S5Click(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    verzeichnis:string;
    { Private declarations }
  public
    { Public declarations }
  end;

//type
  TErrorCorretion = (QualityLow, QualityMedium, QualityStandard, QualityHigh);

  TQRCode = class
  private
  public
    class function GetBitmapImage(const Text : string; Margin : integer = 4; PixelSize : integer = 3; Level : TErrorCorretion = QualityLow) : TBitmap;
  end;

var
  qrform: Tqrform;
  verzeichnis:string;

implementation

{$R *.dfm}
type
   TGetHBitmap = function(Text: PChar; Margin, Size, Level: integer): HBITMAP; stdcall;
var
  DLLHandle: THandle;
  GetHBitmap: TGetHBitmap;
  xPixelsPerInch : integer;

procedure Tqrform.S33Click(Sender: TObject);
begin
    if opendialog1.execute then
    begin
      memo2.Lines.LoadFromFile(opendialog1.filename);
    end;
end;

procedure Tqrform.S11Click(Sender: TObject);
begin
    memo2.text:='Töten im Krieg ist meiner Meinung nach um nichts besser als gewöhnlicher Mord. Albert Einstein';
    button4click(sender);
end;

procedure Tqrform.S5Click(Sender: TObject);
begin
    memo2.clear;
end;

procedure Tqrform.Panel3Resize(Sender: TObject);
begin
    panel4.width:=(qrcode.width-panel2.width-panel2.height) div 2;
    panel5.width:=panel4.width;
end;

function Irgendwas(Text : PChar;  Margin : integer; Size : integer; Level : integer): HBITMAP;
begin
  if Assigned(GetHBitmap) then
    Result := GetHBitmap(PChar(Text), Margin, Size, ord(Level))
  else
    Result := 0;
end;

{ TQRCode }
class function TQRCode.GetBitmapImage(const Text: string; Margin,
  PixelSize: integer; Level : TErrorCorretion): TBitmap;
var
  Bmp : hBITMAP;
  DIB: TDIBSection;
  ScreenDC : THandle;
  DC : THandle;
begin
  DLLHandle := LoadLibrary(PChar(verzeichnis+'quricol32.dll'));
  try
  if DLLHandle <> 0 then
    GetHBitmap := GetProcAddress(DLLHandle, 'GetHBitmapA');

  Bmp := irgendwas(PChar(Text), Margin, PixelSize, ord(Level));

  GetObject(Bmp, SizeOf(DIB), @DIB);
  Result := TBitmap.Create();
  Result.Width := DIB.dsBmih.biWidth;
  Result.Height := DIB.dsBmih.biHeight;
  Result.PixelFormat := pf32bit;
  ScreenDC := GetDC(0);
  DC := CreateCompatibleDC(ScreenDC);
  SelectObject(DC, Bmp);
  ReleaseDC(0, ScreenDC);
  BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, 0, 0, SRCCOPY);
  DeleteDC(DC);
  DeleteObject(Bmp);
  finally
    if DLLHandle <> 0 then
      FreeLibrary(DLLHandle);
  end;
end;

procedure Tqrform.Button4Click(Sender: TObject);
 var
  B : TBitmap;
begin
  if length(memo2.text)>0 then
  begin
    if length(memo2.text)>1600 then
       memo2.text:=copy(memo2.text,1,1600);
    B := TQRCode.GetBitmapImage(memo2.Text, updown1.position, 4, QualityStandard);
    image3.picture.bitmap.assign(b);
    B.Free;
  end;
end;

procedure Tqrform.SpeedButton1Click(Sender: TObject);
var
  B : TBitmap;
begin
    if length(memo2.text)>0 then
    begin
      B := TQRCode.GetBitmapImage(memo2.Text, updown1.position, 4, QualityStandard);
      Clipboard.Assign(B);
      B.Free;
    end;
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
const lidruck=20;
      redruck=20;
      obdruck=20;
var
  ScaleX,ScaleY:real;
  limog,obmog,lioff,oboff,reoff : Integer;
  R: TRect;
begin
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

procedure Tqrform.SpeedButton2Click(Sender: TObject);
var
  B : TBitmap;
begin
   xPixelsPerInch:=PixelsPerInch;
   if length(memo2.text)>0 then
   begin
     B := TQRCode.GetBitmapImage(memo2.Text, updown1.position, 4, QualityStandard);
     normaldruckbitmap(b);
     B.Free;
   end;
end;

procedure Tqrform.FormCreate(Sender: TObject);
begin
    verzeichnis:=IncludeTrailingBackslash(extractfilepath(application.exename));
end;

end.
