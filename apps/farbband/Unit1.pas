unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}
interface
uses Windows, SysUtils,Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls;
type
  TForm1 = class(TForm)
    pbStripe: TPaintBox;
    panDown: TPanel;
    procedure Init(Sender: TObject);
    procedure Strip(Sender: TObject);
    procedure GetRGB(Sender:TObject; Shift:TShiftState; x,y:integer);
    procedure Exit(Sender: TObject; var Action: TCloseAction);
  private
    xm,ym : integer;
    BkColor : TColor;
    bm : TBitmap;
  end;
var Form1: TForm1;

implementation
{$R *.dfm}

procedure TForm1.Init(Sender: TObject);
begin
  xm := pbStripe.Width div 2;
  ym := pbStripe.Height div 2;
  bm := TBitmap.Create;
  bm.Width := 2*xm;
  bm.Height := 2*ym;
  bm.Canvas.Brush.Color := clBtnFace;
  bm.Canvas.Rectangle (0, 0, bm.Width, bm.Height);
  bm.Canvas.Brush.Style := bsClear;                          // keine Füllfarbe
end;

procedure TForm1.Strip(Sender: TObject);
var Red,Green,Blue : integer;
             f,s,x : integer;
begin
  BkColor := pbStripe.Canvas.Pixels [xm,ym];         // Hintergrundfarbe merken
  for x:=0 to 359 do
    begin
      s := x div 60;
      f := round(255/60*(x-60*s));
      case s of
        0 : begin Red := 255; Green := 0; Blue := f end;
        1 : begin Red := 255-f; Green := 0; Blue := 255 end;
        2 : begin Red := 0; Green := f; Blue := 255 end;
        3 : begin Red := 0; Green := 255; Blue := 255-f end;
        4 : begin Red := f; Green := 255; Blue := 0 end;
       else begin Red := 255; Green := 255-f; Blue := 0 end;
      end;
      bm.Canvas.Pen.Color := 65536*Blue + 256*Green + Red;
      bm.Canvas.MoveTo (xm-180+x, ym-30);
      bm.Canvas.LineTo (xm-180+x, ym+35);
    end;
  pbStripe.Canvas.Draw (0,0,bm);
end;

function Value (w: byte): string;
var s : string[5];
begin
  s := IntToStr (w);
  if w < 100 then s := '  ' + s;
  if w <  10 then s := '  ' + s;
  Value := s;
end;

procedure TForm1.GetRGB(Sender:TObject; Shift:TShiftState; x,y:integer);
var col, Rot,Gruen,Blau : integer;
begin
  col := pbStripe.Canvas.Pixels [x,y];
  Rot := col and $FF;
  Gruen := (col and $FF00) shr 8;
  Blau := col shr 16;
  if col = BkColor then panDown.Caption := ''
                   else panDown.Caption := 'R:' + Value(Rot) + '   G:' + Value(Gruen) + '   B:' + Value(Blau);
end;

procedure TForm1.Exit(Sender: TObject; var Action: TCloseAction);
begin
  bm.Free
end;

end.
