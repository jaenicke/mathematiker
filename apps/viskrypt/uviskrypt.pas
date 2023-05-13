unit uviskrypt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit0: TEdit;
    PaintBox1: TPaintBox;
    L64: TLabel;
    I2: TImage;
    Memo1: TMemo;
    I1: TImage;
    procedure Edit0Change(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

var yalt,yoffset:integer;
    bewegen:boolean;
{$R *.DFM}

procedure TForm1.Edit0Change(Sender: TObject);
const xb=200; yb=100;
var bitmap,bl,br:tbitmap;
    i,j:integer;
    k:string;
    offset:integer;
begin
     bl:=tbitmap.create;
     bl.width:=2;
     bl.height:=2;
     bl.canvas.Pixels[0,0]:=clblack;
     bl.canvas.Pixels[1,1]:=clblack;
     br:=tbitmap.create;
     br.width:=2;
     br.height:=2;
     br.canvas.Pixels[0,1]:=clblack;
     br.canvas.Pixels[1,0]:=clblack;

     bitmap:=tbitmap.create;
     bitmap.width:=xb;
     bitmap.height:=yb;
     bitmap.PixelFormat:=pf1bit;
     bitmap.canvas.brush.style:=bsclear;
     bitmap.canvas.font.name:='Verdana';
     bitmap.canvas.font.size:=11;
     bitmap.canvas.font.style:=[fsbold];

     k:=edit0.text;
     memo1.clear;
     memo1.font.size:=11;
     memo1.font.style:=[fsbold];
     memo1.lines.add(k);
     for i:=0 to memo1.lines.count-1 do
       bitmap.canvas.textout(5,5+i*17,memo1.lines[i]);

     i2.picture.bitmap.assign(i1.picture.bitmap);
     for i:=3 to xb do
       for j:=3 to yb do
       begin
         if bitmap.Canvas.pixels[i,j]<>clwhite then
         begin
           if i1.Canvas.pixels[2*i,2*j]=clwhite then I2.canvas.draw(2*i,2*j,bl)
                                                else I2.canvas.draw(2*i,2*j,br);
         end;
       end;
     bitmap.free;
     bl.free;
     br.free;

     bitmap:=tbitmap.create;
     bitmap.width:=paintbox1.width;
     bitmap.height:=paintbox1.height;
     offset:=(bitmap.width-i1.width) div 2;
     bitmap.canvas.Rectangle(-1,-1,bitmap.width+1,bitmap.height+1);
     bitmap.canvas.Draw(offset,50,i1.picture.bitmap);
     bitmap.canvas.Draw(offset,yoffset,I2.picture.bitmap);

     bitmap.canvas.font.name:='Verdana';
     bitmap.canvas.brush.style:=bsclear;
     bitmap.canvas.font.size:=10;
     bitmap.canvas.textout(offset,25,'Bild 1');
     bitmap.canvas.textout(offset,285,'Bild 2');
     paintbox1.canvas.Draw(0,0,bitmap);
     bitmap.free;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    yalt:=y; bewegen:=true;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if bewegen then
   begin
     if yoffset+(y-yalt)<50 then yoffset:=50 else yoffset:=yoffset+(y-yalt);
     yalt:=y;
     edit0change(sender);
   end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    bewegen:=false;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    yoffset:=310;
    bewegen:=false;
end;

end.
