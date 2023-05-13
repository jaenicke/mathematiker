unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  mat:array[0..6,1..4] of real;
  x,xi,y,yi,sum:real;
  bm:tbitmap;

const x0=-4;
      x1=4;
      y0=11;
      y1=-1;
      rand=1000;

implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
  bm:=tbitmap.create;
  bm.width:=paintbox1.width;
  bm.height:=paintbox1.height;

  mat[0,1]:=0.85;
  mat[0,2]:=0.07;
  mat[0,3]:=0.07;
  mat[0,4]:=0.01;
  mat[1,1]:=0.85;
  mat[1,2]:=0.2;
  mat[1,3]:=-0.15;
  mat[1,4]:=0;
  mat[2,1]:=0.04;
  mat[2,2]:=-0.26;
  mat[2,3]:=0.28;
  mat[2,4]:=0;
  mat[3,1]:=-0.04;
  mat[3,2]:=0.26;
  mat[3,3]:=0.23;
  mat[3,4]:=0;
  mat[4,1]:=0.85;
  mat[4,2]:=0.22;
  mat[4,3]:=0.24;
  mat[4,4]:=0.16;
  mat[5,1]:=0;
  mat[5,2]:=0;
  mat[5,3]:=0;
  mat[5,4]:=0;
  mat[6,1]:=1.6;
  mat[6,2]:=1.6;
  mat[6,3]:=0.44;
  mat[6,4]:=0;

  x:=0;
  y:=0;
  sum:=mat[0,1]+mat[0,2]+mat[0,3]+mat[0,4];
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.free;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var i,r,c,grenze:integer;
begin
  grenze:=strtoint(edit1.Text);
  if grenze>500000 then grenze:=500000;

  bm.Canvas.Pen.Color:=clwhite;
  bm.Canvas.brush.Color:=clwhite;
  bm.Canvas.rectangle(0,0,bm.width,bm.height);
  c:=0;

  randomize;
  for i:=0 to grenze do begin
    r:=random(rand+1);
    if (r<=rand*mat[0,1]/sum) then c:=1;
    if (r>rand*mat[0,1]/sum) and (r<=rand*(mat[0,1]+mat[0,2])/sum) then c:=2;
    if (r>rand*(mat[0,1]+mat[0,2])/sum) and (r<=rand*(mat[0,1]+mat[0,2]+mat[0,3])/sum) then c:=3;
    if (r>rand*(mat[0,1]+mat[0,2]+mat[0,3])/sum) then c:=4;
    xi:=mat[1,c]*x+mat[2,c]*y+mat[5,c];
    yi:=mat[3,c]*x+mat[4,c]*y+mat[6,c];
    x:=xi;
    y:=yi;
    bm.Canvas.Pixels[round(paintbox1.width*(x-x0)/(x1-x0)),
                 round(paintbox1.height*(y-y0)/(y1-y0))]:=clblack;
  end;
  paintbox1.canvas.draw(0,0,bm);
end;

end.
