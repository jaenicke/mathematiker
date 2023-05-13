unit uameise;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  b:boolean;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ri:array of integer;
    co:array of array of integer;
    i,anz,meller:integer;
    bm:tbitmap;
begin
  if not b then begin b:=true; exit end;

  button1.Caption:='Stopp';
  anz:=spinedit1.value;
  setlength(ri,anz+1);
  setlength(co,anz+1,3);
  bm:=tbitmap.Create;
  bm.Width:=paintbox1.width;
  bm.height:=paintbox1.Height;
  for i:=1 to anz do begin
    co[i,1]:=random(bm.width);
    co[i,2]:=random(bm.height);
    ri[i]:=random(4)+1;
  end;
  b:=false;
  meller:=0;
  repeat
    for i:=1 to anz do begin
      if bm.Canvas.Pixels[co[i,1],co[i,2]]=clblack then begin
        bm.canvas.Pixels[co[i,1],co[i,2]]:=clwhite;
        dec(ri[i]);
        if ri[i]=0 then ri[i]:=4;
      end else begin
        bm.canvas.Pixels[co[i,1],co[i,2]]:=clblack;
        inc(ri[i]);
        if ri[i]=5 then ri[i]:=1;
      end;
      case ri[i] of
        1:inc(co[i,1]);
        2:inc(co[i,2]);
        3:dec(co[i,1]);
        4:dec(co[i,2]);
      end;
      if co[i,1]<0 then co[i,1]:=bm.Width-1;
      if co[i,1]>bm.width-1 then co[i,1]:=0;
      if co[i,2]<0 then co[i,2]:=bm.height-1;
      if co[i,2]>bm.height-1 then co[i,2]:=0;
    end;
    inc(meller);
    if meller mod 50 = 0 then begin
      paintbox1.Canvas.Draw(0,0,bm);
      application.ProcessMessages;
    end;
  until b;
  setlength(ri,0);
  setlength(co,0,0);
  bm.free;
  button1.Caption:='Darstellung';
  b:=true;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  b:=true;
end;

end.
