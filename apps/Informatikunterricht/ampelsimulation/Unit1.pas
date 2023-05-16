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
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  zaehler:integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
Timer1.Enabled:=false;
Timer2.Enabled:=false;
Shape2.Brush.Color:=ClRed;
Shape3.Brush.Color:=ClBtnShadow;
Shape4.Brush.Color:=ClBtnShadow;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Timer1.Enabled:=false;
Timer2.Enabled:=false;
Shape3.Brush.Color:=ClYellow;
Shape2.Brush.Color:=ClBtnShadow;
Shape4.Brush.Color:=ClBtnShadow;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Timer1.Enabled:=false;
Timer2.Enabled:=false;
Shape4.Brush.Color:=ClLime;
Shape2.Brush.Color:=ClBtnShadow;
Shape3.Brush.Color:=ClBtnShadow;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
close
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
Timer1.Enabled:=false;
Timer2.Enabled:=false;
Shape2.Brush.Color:=ClBtnShadow;
Shape3.Brush.Color:=ClBtnShadow;
Shape4.Brush.Color:=ClBtnShadow;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
zaehler:=0;
Timer1.Enabled:=true;
Timer2.Enabled:=false;
end;



procedure TForm1.Button7Click(Sender: TObject);
begin
zaehler:=0;
Timer1.Enabled:=false;
Timer2.Enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
zaehler:=zaehler+1;
if zaehler>2 then zaehler:=1;
if zaehler=1 then begin
Shape3.brush.color:=ClYellow;
Shape2.brush.color:=ClBtnShadow;
Shape4.brush.color:=ClBtnShadow;
end;
if zaehler=2 then begin
Shape3.brush.color:=ClBtnShadow;
Shape2.brush.color:=ClBtnShadow;
Shape4.brush.color:=ClBtnShadow;
end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
zaehler:=zaehler+1;
if zaehler>4 then zaehler:=1;
if zaehler=1 then begin
Shape2.brush.color:=ClRed;
Shape3.brush.color:=ClBtnShadow;
Shape4.brush.color:=ClBtnShadow;
end;
if (zaehler=2) or (zaehler=4) then begin
if zaehler=2 then Shape2.brush.color:=ClRed
else Shape2.brush.color:=ClBtnShadow;
Shape3.brush.color:=ClYellow;
Shape4.brush.color:=ClBtnShadow;
end;
if zaehler=3 then begin
Shape2.brush.color:=ClBtnShadow;
Shape3.brush.color:=ClBtnShadow;
Shape4.brush.color:=ClLime;
end;

end;

end.
