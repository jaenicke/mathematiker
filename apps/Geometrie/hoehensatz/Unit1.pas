unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    PaintBox1: TPaintBox;
    Button3: TButton;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  bm:tbitmap;
  a,b,c,d,q,h,w,x1,y1,x2,y2,x3,y3,x4,y4:real;
  dyn1,dyn2,i,ri:integer;
  dyn:boolean;

implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
bm:=tbitmap.create;
dyn:=false;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
bm.free
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
close
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
bm.Width:=paintbox1.Width;
bm.height:=paintbox1.height;
bm.canvas.Pen.color:=clwhite;
bm.canvas.brush.color:=clwhite;
bm.canvas.rectangle(0,0,bm.width,bm.height);

if dyn=false then begin
a:=strtofloat(edit1.text);
b:=strtofloat(edit2.text);
c:=bm.width/3;
d:=sqrt(a*a+b*b);
a:=a*c/d;
b:=b*c/d;
q:=a*a/c;
h:=sqrt(a*a-q*q);
end;

x1:=(bm.width-c)/2;
y1:=bm.height/2;
x2:=(bm.width+c)/2;
y2:=y1;
x3:=x1+q;
y3:=y1-h;
x4:=x3;
y4:=y1;

if dyn=true then begin
q:=i-x1;
h:=sqrt(q*(c-q));
x4:=i;
x3:=i;
y3:=y4-h;
end;

bm.canvas.Pen.color:=clblack;
bm.canvas.MoveTo(round(x1),round(y1));
bm.canvas.lineTo(round(x2),round(y2));

w:=0;
repeat
bm.canvas.Pixels[round(bm.width/2+c/2*cos(w)),round(bm.height/2-c/2*sin(w))]:=clblack;
w:=w+2/c;
until w>=pi;

bm.canvas.Brush.color:=clblue;
bm.canvas.FloodFill(round(bm.width/2),round(bm.height/2-2),clwhite,fssurface);

bm.canvas.Brush.color:=clyellow;
bm.Canvas.Rectangle(round(x4),round(y4),round(x4+h),round(y4-h));

bm.canvas.Brush.color:=clgreen;
bm.canvas.Rectangle(round(x1),round(y1),round(x1+q),round(y1+(c-q)));

bm.canvas.MoveTo(round(x2),round(y2));
bm.canvas.lineTo(round(x3),round(y3));
bm.canvas.lineTo(round(x1),round(y1));

w:=0;
repeat
bm.canvas.Pixels[round(x4+(c-q)*cos(w)),round(y4+(c-q)*sin(w))]:=clblack;
w:=w+1/(c-q);
until w>=pi/2;

bm.Canvas.Brush.color:=clwhite;
bm.canvas.floodfill(round(x4-2),round(y4-2),clblue,fssurface);
bm.canvas.floodfill(round(x4+h+1),round(y4-2),clblue,fssurface);

bm.Canvas.brush.Style:=bsclear;
bm.canvas.TextOut(round(x1-10),round(y1+4),'A');
bm.canvas.TextOut(round(x2+4),round(y2+4),'B');
bm.canvas.TextOut(round(x3-4),round(y3-14),'C');
bm.canvas.TextOut(round(x4+2),round(y4+4),'F');

paintbox1.canvas.draw(0,0,bm);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
dyn:=not (dyn);
if dyn=true then button2.Caption:='Simulation Aus'
            else button2.Caption:='Simulation An';
timer1.enabled:=not (timer1.enabled);
dyn1:=round(x1);
dyn2:=round(x2);
if dyn=true then begin
i:=round(x1+q);
ri:=1
end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if i>=x2-1 then ri:=0;
if i<=x1+1 then ri:=1;
if ri=1 then inc(i) else dec(i);
Button3Click(Sender);
end;

end.
