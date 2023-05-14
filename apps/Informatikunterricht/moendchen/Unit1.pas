unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    TrackBar1: TTrackBar;
    Button1: TButton;
    Timer1: TTimer;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    hoch:boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    ziel:tcanvas;
    hbreite,breite,gbreite:integer;
    xm,ym,xk,yk:integer;
begin
    bitmap:=tbitmap.create;
    bitmap.Width:=paintbox1.Width;
    bitmap.Height:=paintbox1.Height;
    breite:=4*trackbar1.position;
    hbreite:=breite div 2;

    xm:=paintbox1.Width div 2;
    ym:=paintbox1.Height div 2;

    ziel:=bitmap.canvas;
    ziel.Brush.Color:=clblue;
    xk:=xm-hbreite;
    yk:=ym;
    ziel.Ellipse(xk-hbreite,yk-hbreite,xk+hbreite+1,yk+hbreite+1);
    xk:=xm+hbreite;
    yk:=ym;
    ziel.Ellipse(xk-hbreite,yk-hbreite,xk+hbreite+1,yk+hbreite+1);
    xk:=xm;
    yk:=ym-hbreite;
    ziel.Ellipse(xk-hbreite,yk-hbreite,xk+hbreite+1,yk+hbreite+1);
    xk:=xm;
    yk:=ym+hbreite;
    ziel.Ellipse(xk-hbreite,yk-hbreite,xk+hbreite+1,yk+hbreite+1);

    ziel.Brush.Color:=clwhite;
    xk:=xm;
    yk:=ym;
    gbreite:=round(sqrt(2)/2*breite);
    ziel.Ellipse(xk-gbreite,yk-gbreite,xk+gbreite+1,yk+gbreite+1);

    ziel.Brush.Color:=clyellow;
    ziel.Rectangle(xm-hbreite,ym-hbreite,xm+hbreite+1,ym+hbreite+1);

    paintbox1.Canvas.Draw(0,0,bitmap);
    bitmap.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   if trackbar1.position=trackbar1.Max then hoch:=not hoch;
   if trackbar1.position=trackbar1.Min then hoch:=not hoch;
   if hoch then trackbar1.position:=trackbar1.position+1
           else trackbar1.position:=trackbar1.position-1;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  hoch:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   timer1.Enabled:=not timer1.Enabled;
   if timer1.Enabled then button1.Caption:='Abbruch'
                     else button1.Caption:='Größe ändern';
end;

end.
