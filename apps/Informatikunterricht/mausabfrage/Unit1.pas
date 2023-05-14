unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  bm:tbitmap;
  mat:array[0..2] of tpoint;
  p:integer;

const r=5;

implementation

{$R *.dfm}

procedure TForm1.PaintBox1Paint(Sender: TObject);
var n,m:integer;
begin
  bm.width:=paintbox1.width;
  bm.Height:=paintbox1.Height;
  bm.Canvas.pen.color:=clwhite;
  bm.Canvas.brush.color:=clwhite;
  bm.Canvas.rectangle(0,0,bm.Width,bm.height);
  bm.Canvas.pen.color:=clblue;
  for n:=0 to 2 do begin
    case n of
      0:m:=1;
      1:m:=2;
      else m:=0;
    end;
    bm.Canvas.Pen.Color:=clblue;
    bm.canvas.MoveTo(mat[n].x,mat[n].y);
    bm.canvas.lineTo(mat[m].x,mat[m].y);
    bm.Canvas.Pen.Color:=clred;
    bm.canvas.lineTo((mat[n].x+mat[3-m-n].x) div 2,(mat[n].y+mat[3-n-m].y) div 2);
  end;
  bm.canvas.pen.color:=clblack;
  for n:=0 to 2 do
    bm.canvas.Ellipse(mat[n].x-r,mat[n].y-r,mat[n].x+r,mat[n].y+r);
  paintbox1.canvas.draw(0,0,bm);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  bm:=tbitmap.create;
  bm.width:=paintbox1.width;
  bm.Height:=paintbox1.Height;
  mat[0].x:=150;
  mat[0].y:=100;
  mat[1].x:=750;
  mat[1].y:=200;
  mat[2].x:=350;
  mat[2].y:=450;
  p:=3;
  PaintBox1Paint(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.free;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var o:integer;
begin
  p:=3;
  for o:=0 to 2 do begin
   if sqr(X-mat[o].x)+sqr(Y-mat[o].y)<=sqr(r) then p:=o;
  end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  p:=3;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var q,o:integer;
begin
  if p<3 then begin
    mat[p].x:=X;
    if mat[p].x<0 then mat[p].x:=0;
    if mat[p].x>paintbox1.width then mat[p].x:=paintbox1.width;
    mat[p].y:=Y;
    if mat[p].y<0 then mat[p].y:=0;
    if mat[p].y>paintbox1.height then mat[p].y:=paintbox1.height;
    PaintBox1Paint(Sender);
  end
  else begin
     q:=3;
     for o:=0 to 2 do begin
       if sqr(X-mat[o].x)+sqr(Y-mat[o].y)<=sqr(r) then q:=o;
     end;
     if q<3 then paintbox1.Cursor:=crHandPoint
            else paintbox1.Cursor:=crdefault
  end;
end;

end.
