unit uwege2;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin;

const maximum = 25;

type
  tdw = record
         dx,dy : NativeInt;
       end;

  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label7: TLabel;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    maxX,maxY : integer;
    EndPos : tdw;
    feld : array[0..maximum,0..maximum] of record n:int64; frei:boolean end;
    Startpos  :tdw;
    schroeder :boolean;
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
procedure rechnen_dellanoy;
var i,j:integer;
begin
  feld[0,0].n:=1;
  for i:=1 to maxX do
    if feld[i,0].frei then feld[i,0].n:=feld[i-1,0].n
                      else feld[i,0].n:=0;
  for j:=1 to maxY do
    if feld[0,j].frei then feld[0,j].n:=feld[0,j-1].n
                      else feld[0,j].n:=0;
  for i:=1 to maxX do
    for j:=1 to maxY do
      if feld[i,j].frei then feld[i,j].n:=feld[i-1,j].n+feld[i,j-1].n+feld[i-1,j-1].n
                        else feld[i,j].n:=0;
end;
procedure rechnen_schroeder;
var i,j:integer;
begin
  feld[0,0].n:=1;
  for i:=1 to maxX do
    if feld[i,0].frei then feld[i,0].n:=feld[i-1,0].n
                      else feld[i,0].n:=0;
  for j:=1 to maxY do feld[0,j].n:=0;
  for i:=1 to maxX do
    for j:=1 to maxY do
      if (feld[i,j].frei) and (j<=i)
            then feld[i,j].n:=feld[i-1,j].n+feld[i,j-1].n+feld[i-1,j-1].n
            else feld[i,j].n:=0;
end;

Begin
  if schroeder then rechnen_schroeder
               else rechnen_dellanoy;
  label1.caption:=inttostr(feld[maxX,maxY].n);
end;

procedure TForm1.FormShow(Sender: TObject);
var i,j:integer;
begin
  for i:=0 to maximum do
    for j:=0 to maximum do begin
      feld[i,j].n:=0;
      feld[i,j].frei:=true;
    end;
  maxX := 4;
  maxY := 4;
  spinedit1.MaxValue:=maximum;
  spinedit2.MaxValue:=maximum;
  EndPos.dx:=maxX;
  EndPos.dy:=MaxY;
  Startpos.dx:=0;
  Startpos.dy:=0;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  maxX := spinedit1.Value;
  maxY := spinedit2.Value;
  EndPos.dx:=maxX;
  EndPos.dy:=MaxY;
  paintbox1paint(sender);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var bitmap:tbitmap;
    ziel:tcanvas;
    b,h,x,y,i,j:integer;
  procedure line(i,j,m,n:integer);
  begin
    if schroeder and ((j>i) or (n>m)) then exit;
    if (feld[i-1,j-1].n=0) or (feld[m-1,n-1].n=0) then ziel.Pen.color:=$00e0e0e0
                                          else ziel.pen.color:=clblack;
    ziel.MoveTo(i*x,h-j*y);
    ziel.LineTo(m*x,h-n*y);
  end;
begin
  schroeder:=radiobutton2.Checked;
  button1click(sender);

  bitmap:=tbitmap.Create;
  bitmap.Width:=paintbox1.Width;
  bitmap.Height:=paintbox1.Height;
  ziel:=bitmap.canvas;
  b:=bitmap.Width;
  h:=bitmap.Height;
  x:=b div (maxX+2);
  y:=h div (maxY+2);

  for i:=1 to maxX do
    for j:=1 to maxY do begin
      line(i,j,i+1,j);
      line(i,j,i,j+1);
      line(i+1,j,i+1,j+1);
      line(i,j+1,i+1,j+1);
      line(i,j,i+1,j+1);
    end;
  ziel.pen.color:=clblack;
  ziel.brush.Color:=cllime;
  ziel.ellipse((Endpos.dx+1)*x-8,h-(Endpos.dy+1)*y-8,(Endpos.dx+1)*x+9,h-(Endpos.dy+1)*y+9);
  ziel.brush.Color:=clred;
  for i:=0 to maxX do
    for j:=0 to maxY do begin
      if not schroeder then begin
        if not feld[i,j].frei then ziel.ellipse((i+1)*x-8,h-(j+1)*y-8,(i+1)*x+9,h-(j+1)*y+9);
      end else begin
        if (not feld[i,j].frei) and (j<=i) then ziel.ellipse((i+1)*x-8,h-(j+1)*y-8,(i+1)*x+9,h-(j+1)*y+9);
      end;
    end;
  ziel.brush.Color:=clyellow;
  ziel.ellipse(x-8,h-y-8,x+9,h-y+9);
  paintbox1.Canvas.Draw(0,0,bitmap);
  bitmap.Free;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h,xx,yy,i,j:integer;
begin
  b:=paintbox1.Width;
  h:=paintbox1.Height;
  xx:=b div (maxX+2);
  yy:=h div (maxY+2);
  i:=round(x/xx-1);
  j:=maxy-round(y/yy-1);
  feld[i,j].frei:=not feld[i,j].frei;
  paintbox1paint(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
begin
  for i:=0 to maximum do
    for j:=0 to maximum do begin
      feld[i,j].n:=0;
      feld[i,j].frei:=true;
    end;
  paintbox1paint(sender);
end;

end.
