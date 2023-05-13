unit uinterferenz;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label3: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Label4: TLabel;
    Edit4: TEdit;
    UpDown4: TUpDown;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    interferenzbit:tbitmap;
    superphase:real;
    abbruch:boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function ein_int(const edit:tedit):integer;
var kk:string;
    x,code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    ein_int:=x;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var alpha,beta,mx1,mx2,c1,c2,a1,a2,w,staerke:real;
    b,h:integer;
    i,j,farbe,qq:integer;
    rowrgb,rowrgb2 : pbytearray;
begin
    mx1:=-ein_int(edit3)/10;
    mx2:=-mx1;
    alpha:=ein_int(edit1);
    beta:=ein_int(edit2);
    staerke:=ein_int(edit4)/10;

    b:=interferenzbit.width div 2;
    h:=interferenzbit.height div 2;
    interferenzbit.pixelformat:=pf32bit;
    j:=0;
    repeat
       rowrgb:=interferenzbit.scanline[j];
       rowrgb2:=interferenzbit.scanline[2*h-j-1];
       c2:=sqr(0.01*(j-h));
       i:=0;
       repeat
          c1:=0.01*(i-b);
          a1:=sqrt(sqr(mx1-c1)+c2);
          a2:=sqrt(sqr(mx2-c1)+c2);
          w:=2.0*(sin(alpha*a1+superphase)+staerke*sin(beta*a2))/(staerke+1);
          farbe:=round(127+63*w);

          qq:=4*i;
          rowrgb[qq]:=farbe;
          rowrgb[qq+1]:=farbe;
          rowrgb[qq+2]:=farbe;
          rowrgb2[qq]:=farbe;
          rowrgb2[qq+1]:=farbe;
          rowrgb2[qq+2]:=farbe;
          inc(i);
       until (i>2*b);
       inc(j);
    until j>h;
    paintbox1.canvas.draw(0,0,interferenzbit);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    superphase:=0;
    abbruch:=true;
    interferenzbit:=tbitmap.create;
    interferenzbit.width:=paintbox1.width;
    interferenzbit.height:=paintbox1.height;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    interferenzbit.free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    if not abbruch then
    begin
      abbruch:=true;
      exit;
    end;
    button1.enabled:=false;
    button2.caption:='Abbruch';
    abbruch:=false;
    repeat
      paintbox1paint(sender);
      application.processmessages;
      superphase:=superphase-0.5;
    until abbruch;
    button2.caption:='Phase 1 ändern';
    button1.enabled:=true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if not abbruch then
    begin
      abbruch:=true;
      exit;
    end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    if interferenzbit<>nil then interferenzbit.free;
    interferenzbit:=tbitmap.create;
    interferenzbit.width:=paintbox1.width;
    interferenzbit.height:=paintbox1.height;
end;

end.
