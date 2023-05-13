unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,Math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    GroupBox3: TGroupBox;
    Edit3: TEdit;
    Button3: TButton;
    GroupBox4: TGroupBox;
    Edit4: TEdit;
    GroupBox5: TGroupBox;
    TrackBar1: TTrackBar;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  bm:tbitmap;
  x,y,vo,v,vx,vy,g,w,t,wind:real;

const r=10;

implementation

{$R *.dfm}

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  paintbox1.canvas.pen.Color:=clwhite;
  paintbox1.canvas.brush.Color:=clwhite;
  paintbox1.canvas.rectangle(0,0,paintbox1.Width,paintbox1.height);
  button3.click;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  close
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  timer1.enabled:=not timer1.enabled;
  if timer1.enabled=true then begin button2.caption:='Stop'; t:=1; end
                         else button2.caption:='Start';
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  bm:=tbitmap.create;
  bm.width:=paintbox1.Width;
  bm.height:=paintbox1.Height;
  t:=1;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  vy:=vy+t*g;
  vx:=vx+t*wind;
  x:=x+t*(vx-t*g/2);
  y:=y+t*(vy-t*wind/2);
  if x>paintbox1.width-r then begin vx:=-vx; x:=paintbox1.Width-r end;
  if x<r then begin vx:=-vx; x:=r end;
  if y>paintbox1.height-r then begin vy:=-vy; y:=paintbox1.Height-r end;
  if y<r then begin vy:=-vy; y:=r end;
  bm.canvas.pen.Color:=clwhite;
  bm.canvas.brush.Color:=clwhite;
  bm.canvas.rectangle(0,0,paintbox1.Width,paintbox1.height);
  bm.Canvas.Pen.color:=clred;
  bm.Canvas.brush.color:=clred;
  bm.canvas.Ellipse(round(x-r),round(y-r),round(x+r),round(y+r));
  paintbox1.canvas.Draw(0,0,bm);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  w:=strtofloat(edit1.text);
  vo:=strtofloat(edit2.text);
  g:=strtofloat(edit3.text);
  wind:=strtofloat(edit4.text);
  x:=r;
  y:=paintbox1.Height-1-r;
  vx:=vo*cos(pi*w/180);
  vy:=-vo*sin(pi*w/180);
  t:=0;
  bm.canvas.pen.Color:=clwhite;
  bm.canvas.brush.Color:=clwhite;
  bm.canvas.rectangle(0,0,paintbox1.Width,paintbox1.height);
  bm.Canvas.Pen.color:=clred;
  bm.Canvas.brush.color:=clred;
  bm.canvas.Ellipse(round(x-r),round(y-r),round(x+r),round(y+r));
 paintbox1.canvas.Draw(0,0,bm);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  t:=power(20,trackbar1.position/50-1);
end;

end.
