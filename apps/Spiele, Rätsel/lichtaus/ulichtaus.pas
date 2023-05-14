unit ulichtaus;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, Dialogs,
  Menus, StdCtrls, Grids, Buttons, messages;

type
  TIdRect=record
    Id:string;
    Left,top,right,bottom:integer;
    W,H,Area:integer;
  end;
  TFLichtaus = class(TForm)
    Panel3: TPanel;
    Panel2: TPanel;
    lichtaus: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Paintbox1: TPaintBox;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure PB7P(Sender: TObject);
    procedure PB7MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

  public
    { Public declarations }
  end;

var FLichtaus: TFLichtaus;

implementation

const
      neuesspiel: boolean=true;
var
      lfeld:array[0..21,0..21] of boolean;
      zuege:integer;
{$R *.DFM}

procedure TFLichtaus.Button1Click(Sender: TObject);
var i,j:integer;
begin
  neuesspiel:=true;
  zuege:=0;
  randomize;
  for i:=1 to 20 do
    for j:=1 to 20 do
       lfeld[i,j]:=(random<0.5);
  pb7p(sender);
end;


procedure TFLichtaus.PB7P(Sender: TObject);
var xoffset,nr,b,h,x,i,j,br,anz:integer;
    bitmap:tbitmap;
begin
  nr:=strtoint(edit1.text);
  if nr>20 then begin nr:=20; edit1.text:='20' end;
  b:=paintbox1.width;
  h:=paintbox1.height;
  x:=b;
  if h<b then x:=h;
  br:=(x-60) div nr;
  xoffset:=(b-nr*br) div 2;
  bitmap:=tbitmap.create;
  bitmap.width:=paintbox1.width;
  bitmap.height:=paintbox1.height;
  anz:=0;
  for i:=1 to nr do
    for j:=1 to nr do begin
      if lfeld[i,j] then begin
        inc(anz);
        bitmap.canvas.Brush.color:=clyellow;
      end else begin
        bitmap.canvas.Brush.color:=clwhite;
      end;
      bitmap.canvas.rectangle(xoffset+(i-1)*br,30+(j-1)*br,xoffset+i*br+1,30+j*br+1);
    end;
  paintbox1.canvas.draw(0,0,bitmap);
  bitmap.free;
  label1.caption:='Züge '+inttostr(zuege);
  if anz=0 then begin
    if zuege>0 then begin
      showmessage('Gratulation! Aufgabe mit '+inttostr(zuege)+' Zügen geschafft');
    end;
  end;
end;

procedure TFLichtaus.PB7MD(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var nr,b,h,xx,br,i,j,xoffset:integer;
begin
  b:=paintbox1.width;
  h:=paintbox1.height;
  nr:=strtoint(edit1.text);
  if nr>20 then begin nr:=20; edit1.text:='20' end;
  xx:=b;
  if h<b then xx:=h;
  br:=(xx-60) div nr;
  xoffset:=(b-nr*br) div 2;
  if (x>=xoffset) and (y>=30) and neuesspiel then begin
    inc(zuege);
    x:=x-xoffset;
    y:=y-30;
    i:=x div br +1;
    j:=y div br +1;
    if (i in [1..nr]) and (j in [1..nr]) then begin
      lfeld[i,j]:=not lfeld[i,j];
      if i>1 then lfeld[i-1,j]:=not lfeld[i-1,j];
      if i<nr then lfeld[i+1,j]:=not lfeld[i+1,j];
      if j>1 then lfeld[i,j-1]:=not lfeld[i,j-1];
      if j<nr then lfeld[i,j+1]:=not lfeld[i,j+1];
      pb7p(sender);
    end;
  end;
end;

end.
