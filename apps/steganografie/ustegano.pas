unit ustegano;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ComCtrls, ExtDlgs, ExtCtrls, StdCtrls;

type
  TFStegano = class(TForm)
    OP1: TOpenPictureDialog;
    SD2: TSaveDialog;
    Panel0: TPanel;
    stegano: TPanel;
    Panel5: TPanel;
    Panel4: TPanel;
    I8: TImage;
    imgdelta: TImage;
    Panel2: TPanel;
    S10: TSpeedButton;
    S12: TSpeedButton;
    Check1: TCheckBox;
    Panel6: TPanel;
    I10: TImage;
    Panel1: TPanel;
    S13: TSpeedButton;
    S14: TSpeedButton;
    S17: TSpeedButton;
    Panel7: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    S15: TSpeedButton;
    S16: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    BKodieren: TButton;
    BDekodieren: TButton;
    BAbbruch: TButton;
    Panel8: TPanel;
    M2: TMemo;
    Image1: TImage;
    Image2: TImage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure Panel5Resize(Sender: TObject);
    procedure S13C(Sender: TObject);
    procedure S10C(Sender: TObject);
    procedure S14C(Sender: TObject);
    procedure S12C(Sender: TObject);
    procedure S15Click(Sender: TObject);
    procedure S16Click(Sender: TObject);
    procedure CKodieren(Sender: TObject);
    procedure CDekodieren(Sender: TObject);
    procedure D22C(Sender: TObject);
    procedure CB5C(Sender: TObject);
    procedure S17Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var  FStegano: TFStegano;

implementation

const suchabbruch: boolean = false;

{$R *.DFM}

procedure TFStegano.FormShow(Sender: TObject);
begin
  s17click(sender);
end;

procedure TFStegano.Panel5Resize(Sender: TObject);
begin
  panel6.width:=panel5.Width div 2;
end;

procedure TFStegano.S13C(Sender: TObject);
begin
  if op1.execute then
    i10.picture.loadfromfile(op1.filename);
end;

procedure TFStegano.S10C(Sender: TObject);
begin
  if op1.execute then
    i8.picture.loadfromfile(op1.filename);
end;

procedure TFStegano.S14C(Sender: TObject);
begin
  if sd2.execute then
    i10.picture.savetofile(sd2.filename);
end;

procedure TFStegano.S12C(Sender: TObject);
begin
  if sd2.execute then
    i8.picture.savetofile(sd2.filename);
end;

procedure TFStegano.S15Click(Sender: TObject);
var dd:file of byte;
    anz:integer;
begin
  if opendialog1.execute then begin
    assignfile(dd,opendialog1.filename);
    filemode:=0;
    reset(dd);
    anz:=filesize(dd);
    closefile(dd);
    filemode:=2;
    if anz<50000 then m2.lines.loadfromfile(opendialog1.filename);
  end;
end;

procedure TFStegano.S16Click(Sender: TObject);
begin
  if savedialog1.execute then m2.lines.savetofile(savedialog1.filename);
end;

procedure TFStegano.CKodieren(Sender: TObject);
label 1;
var
    x, y, i, j, z: Integer;
    PixelData: TColor;
    CharMask, CharData: Byte;
    s:string;
begin
  i8.visible:=false;
  check1.checked:=false;
  imgdelta.visible:=false;
  BKodieren.visible:=false;
  BDekodieren.visible:=false;
  BAbbruch.visible:=true;
  i8.Picture.Assign(i10.Picture);
  imgDelta.Picture.Assign(i10.Picture);
  i8.Picture.Bitmap.PixelFormat := pf24bit;
  imgDelta.Picture.Bitmap.PixelFormat := pf24bit;
  x := 0;
  y := 0;
  suchabbruch:=false;
  s:=m2.Text;
  for i := 1 to Length(s) do begin
    z:=round(100.0*i/Length(s));
    label3.caption:=inttostr(z)+' %';
    application.processmessages;
    if suchabbruch then goto 1;
    CharMask := $80;
    for j := 1 to 8 do begin
      CharData := Byte(s[i]) and CharMask;
      if (CharData <> 0) then begin
        PixelData := i8.Picture.Bitmap.Canvas.Pixels[x, y] xor $1;
        i8.Picture.Bitmap.Canvas.Pixels[x, y] := PixelData;
      end;
      x := (x + 1) mod i8.Picture.Bitmap.Width;
      if (x = 0) then Inc(y);
      CharMask := CharMask shr 1;
    end;
  end;
  for y := 0 to i10.Picture.Bitmap.Height -1 do
    for x := 0 to i10.Picture.Bitmap.Width -1 do
      if (i10.Picture.Bitmap.Canvas.Pixels[x, y] <>
        i8.Picture.Bitmap.Canvas.Pixels[x, y]) then
  imgDelta.Picture.Bitmap.Canvas.Pixels[x, y] := clYellow;
1 : i8.visible:=true;
  suchabbruch:=true;
  BKodieren.visible:=true;
  BDekodieren.visible:=true;
  BAbbruch.visible:=false;
end;

procedure TFStegano.CDekodieren(Sender: TObject);
label 1;
Var
  x, y, z: integer;
  mask, ch: byte;
  s:string;
begin
  check1.checked:=false;
  imgdelta.visible:=false;
  BKodieren.visible:=false;
  BDekodieren.visible:=false;
  BAbbruch.visible:=true;
  suchabbruch:=false;
  m2.Clear;
  s:='';
  mask := $80;
  ch := 0;
  for y := 0 to i10.picture.Bitmap.Height -1 do begin
    z:=round(100.0*y/(i10.picture.Bitmap.Height-1));
    label3.caption:=inttostr(z)+' %';
    application.processmessages;
    if suchabbruch then goto 1;
    for x := 0 to i10.Picture.Bitmap.Width -1 do begin
      if (i10.Picture.Bitmap.Canvas.Pixels[x, y] <>
        i8.Picture.Bitmap.Canvas.Pixels[x, y]) then ch := ch or mask;
      mask := mask shr 1;
      if mask = 0 Then begin
        s := s + char(ch);
        mask := $80;
        ch := 0;
      end;
    end;
  end;
1 : m2.text:=s;
  suchabbruch:=true;
  BKodieren.visible:=true;
  BDekodieren.visible:=true;
  BAbbruch.visible:=false;
end;

procedure TFStegano.D22C(Sender: TObject);
begin
  suchabbruch:=true;
end;

procedure TFStegano.CB5C(Sender: TObject);
begin
  imgdelta.visible:=check1.checked;
end;

procedure TFStegano.S17Click(Sender: TObject);
begin
   i10.picture.bitmap.assign(image1.picture.bitmap);
   i8.picture.bitmap.assign(image2.picture.bitmap);
end;

end.

