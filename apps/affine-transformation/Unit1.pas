unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label4: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label5: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Label7: TLabel;
    Button4: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
type tmatrix = array[1..3,1..3] of real;
     tp = array[1..3] of record x,y:real end;
var  p:tp;
     matrix: tmatrix;
     punkt:array[0..2] of tpoint;

procedure matrixrechnen(matrix:tmatrix);
var h:tp;
    i:integer;
begin
    for i:=1 to 3 do begin
        h[i].x:=matrix[1,1]*p[i].x+matrix[1,2]*p[i].y+matrix[1,3]*1;
        h[i].y:=matrix[2,1]*p[i].x+matrix[2,2]*p[i].y+matrix[2,3]*1;
      end;
    for i:=1 to 3 do begin
        p[i].x:=h[i].x;
        p[i].y:=h[i].y;
      end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var b,h,i:integer;
begin
    b:=paintbox1.width;
    h:=paintbox1.height;
    paintbox1.canvas.pen.color:=clgray;
    paintbox1.canvas.moveto(10,h div 2);
    paintbox1.canvas.lineto(b-10,h div 2);
    paintbox1.canvas.moveto(b div 2,10);
    paintbox1.canvas.lineto(b div 2,h-10);
    for i:=1 to 3 do begin
        punkt[i-1].x:=round(b/2+50*p[i].x);
        punkt[i-1].y:=round(h/2-50*p[i].y);
        end;
    paintbox1.canvas.Pen.color:=clblue;
    paintbox1.canvas.brush.style:=bsclear;
    paintbox1.canvas.polygon(slice(punkt,3));
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    p[1].x:=strtofloat(edit1.text);
    p[1].y:=strtofloat(edit2.text);
    p[2].x:=strtofloat(edit3.text);
    p[2].y:=strtofloat(edit4.text);
    p[3].x:=strtofloat(edit5.text);
    p[3].y:=strtofloat(edit6.text);
end;

procedure TForm1.Button1Click(Sender: TObject);
var b,h,i:integer;
begin
   fillchar(matrix,sizeof(matrix),0);
   matrix[1,1]:=1;
   matrix[2,2]:=1;
   matrix[3,3]:=1;
   matrix[1,3]:=strtofloat(edit7.text);
   matrix[2,3]:=strtofloat(edit8.text);
   matrixrechnen(matrix);
    b:=paintbox1.width;
    h:=paintbox1.height;
    for i:=1 to 3 do begin
        punkt[i-1].x:=round(b/2+50*p[i].x);
        punkt[i-1].y:=round(h/2-50*p[i].y);
        end;
    paintbox1.canvas.Pen.color:=clblue;
    paintbox1.canvas.brush.style:=bsclear;
    paintbox1.canvas.polygon(slice(punkt,3));
end;

procedure TForm1.Button2Click(Sender: TObject);
var b,h,i:integer; w:real;
begin
   fillchar(matrix,sizeof(matrix),0);
   matrix[1,1]:=1;
   matrix[2,2]:=1;
   matrix[3,3]:=1;
   matrix[1,3]:=-strtofloat(edit9.text);
   matrix[2,3]:=-strtofloat(edit10.text);
   matrixrechnen(matrix);

   w:=-strtofloat(edit11.text)*pi/180;
   fillchar(matrix,sizeof(matrix),0);
   matrix[1,1]:=cos(w);
   matrix[1,2]:=sin(w);
   matrix[2,1]:=-sin(w);
   matrix[2,2]:=cos(w);
   matrix[1,3]:=0;
   matrix[2,3]:=0;
   matrix[3,3]:=1;
   matrixrechnen(matrix);

   fillchar(matrix,sizeof(matrix),0);
   matrix[1,1]:=1;
   matrix[2,2]:=1;
   matrix[3,3]:=1;
   matrix[1,3]:=strtofloat(edit9.text);
   matrix[2,3]:=strtofloat(edit10.text);
   matrixrechnen(matrix);

    b:=paintbox1.width;
    h:=paintbox1.height;
    for i:=1 to 3 do begin
        punkt[i-1].x:=round(b/2+50*p[i].x);
        punkt[i-1].y:=round(h/2-50*p[i].y);
        end;
    paintbox1.canvas.Pen.color:=clblue;
    paintbox1.canvas.brush.style:=bsclear;
    paintbox1.canvas.polygon(slice(punkt,3));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    p[1].x:=strtofloat(edit1.text);
    p[1].y:=strtofloat(edit2.text);
    p[2].x:=strtofloat(edit3.text);
    p[2].y:=strtofloat(edit4.text);
    p[3].x:=strtofloat(edit5.text);
    p[3].y:=strtofloat(edit6.text);
    paintbox1.canvas.brush.color:=clwhite;
    paintbox1.canvas.rectangle(-1,-1,paintbox1.width+1,paintbox1.height+1);
    paintbox1paint(sender);
end;

procedure TForm1.Button4Click(Sender: TObject);
var b,h,i:integer;
begin
   fillchar(matrix,sizeof(matrix),0);
   matrix[3,3]:=1;
   matrix[1,1]:=strtofloat(edit12.text);
   matrix[1,2]:=strtofloat(edit15.text);
   matrix[2,1]:=strtofloat(edit13.text);
   matrix[2,2]:=strtofloat(edit14.text);
   matrixrechnen(matrix);

    b:=paintbox1.width;
    h:=paintbox1.height;
    for i:=1 to 3 do begin
        punkt[i-1].x:=round(b/2+50*p[i].x);
        punkt[i-1].y:=round(h/2-50*p[i].y);
        end;
    paintbox1.canvas.Pen.color:=clblue;
    paintbox1.canvas.brush.style:=bsclear;
    paintbox1.canvas.polygon(slice(punkt,3));
end;

end.
