unit Utictac;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  StdCtrls, Buttons, Spin, Menus;

type
  Tftictac = class(TForm)
    Panel5: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    pb2: TPaintBox;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    pb1: TPaintBox;
    Timer1: TTimer;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Label5: TLabel;
    Spin1: TSpinEdit;
    Liste: TListBox;
    procedure S3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pb1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure pb2Paint(Sender: TObject);
    procedure auswertung(sender:tobject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ftictac: Tftictac;
const
  xftictac:boolean=false;

implementation

{$R *.DFM}
type _str9=string[9];
var belegung:_str9;
    abbruch,zug:boolean;
    zeit0:integer;
    erg1,erg2,erg3:integer;

procedure tftictac.auswertung(sender:tobject);
function test(q:char):boolean;
begin
  test:=false;
  if
     ((belegung[1]=q) and (belegung[2]=q) and (belegung[3]=q)) or
     ((belegung[1]=q) and (belegung[4]=q) and (belegung[7]=q)) or
     ((belegung[1]=q) and (belegung[5]=q) and (belegung[9]=q)) or
     ((belegung[2]=q) and (belegung[5]=q) and (belegung[8]=q)) or
     ((belegung[3]=q) and (belegung[5]=q) and (belegung[7]=q)) or
     ((belegung[3]=q) and (belegung[6]=q) and (belegung[9]=q)) or
     ((belegung[7]=q) and (belegung[8]=q) and (belegung[9]=q)) or
     ((belegung[4]=q) and (belegung[5]=q) and (belegung[6]=q)) then begin
    test:=true;
    exit
  end;
end;
begin
  if test('1') then begin
    label2.caption:='Gratulation!';
    inc(erg1);
    timer1.enabled:=false
  end else begin
    if test('2') then begin
      label2.caption:='Schade!';
      inc(erg2);
      timer1.enabled:=false
    end else begin
      if pos('0',belegung)=0 then begin
        label2.caption:='Unentschieden';
        inc(erg3);
        timer1.enabled:=false;
      end;
    end;
  end;
end;

procedure Tftictac.S3Click(Sender: TObject);
begin
  if not abbruch then begin
    abbruch:=true;
    exit
  end;
  close;
end;

procedure Tftictac.FormCreate(Sender: TObject);
begin
  randomize;
  belegung:='000000000';
  zug:=true;
  erg1:=0;
  erg2:=0;
  erg3:=0;
end;

procedure Tftictac.Button1Click(Sender: TObject);
begin
  if not abbruch then begin
    abbruch:=true;
    exit
  end;
  belegung:='000000000';
  if CheckBox1.checked then zug:=true
                 else zug:=false;
  zeit0:=gettickcount;
  label2.caption:='';
  timer1.enabled:=TRUE;
  pb1paint(sender);
end;

procedure Tftictac.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,h,xoffset,yoffset,z,nr:integer;
begin
  if not timer1.enabled then exit;
  h:=pb1.height-64;
  b:=pb1.width-64;
  if b<h then h:=b;
  xoffset:=(pb1.width-h) div 2;
  yoffset:=(pb1.height-h) div 2;
  z:=(pb1.height-2*yoffset) div 3;
  nr:=((x-xoffset) div z)*3+((y-yoffset) div z);
  if (nr>=0) and (nr<=8) and (belegung[nr+1]='0') then begin
    if zug then belegung[nr+1]:='2'
           else belegung[nr+1]:='1';
    zug:=not zug;
  end;
  pb1paint(sender);
end;

procedure Tftictac.pb1Paint(Sender: TObject);
var bitmap:tbitmap;
    i,b,h,xoffset,yoffset,z:integer;
procedure kreuz(i:integer);
var xm,ym:integer;
begin
  bitmap.canvas.pen.color:=clnavy;
  xm:=xoffset+(i div 3)*z+z div 2;
  ym:=yoffset+(i mod 3)*z+z div 2;
  bitmap.canvas.moveto(xm-z div 3,ym-z div 3);
  bitmap.canvas.lineto(xm+z div 3,ym+z div 3);
  bitmap.canvas.moveto(xm+z div 3,ym-z div 3);
  bitmap.canvas.lineto(xm-z div 3,ym+z div 3);
end;
procedure kreis(i:integer);
var xm,ym:integer;
begin
  bitmap.canvas.pen.color:=clred;
  xm:=xoffset+(i div 3)*z+z div 2;
  ym:=yoffset+(i mod 3)*z+z div 2;
  bitmap.canvas.ellipse(xm-z div 3,ym-z div 3,
                        xm+z div 3+1,ym+z div 3+1);
end;
begin
  h:=pb1.height-64;
  b:=pb1.width-64;
  if b<h then h:=b;
  xoffset:=(pb1.width-h) div 2;
  yoffset:=(pb1.height-h) div 2;
  z:=(pb1.height-2*yoffset) div 3;
  bitmap:=tbitmap.create;
  bitmap.width:=pb1.width;
  bitmap.height:=pb1.height;
  with bitmap.canvas do begin
    pen.width:=8;
    for i:=0 to 3 do begin
      moveto(xoffset,yoffset+i*z);
      lineto(xoffset+3*z,yoffset+i*z);
      moveto(xoffset+i*z,yoffset);
      lineto(xoffset+i*z,yoffset+3*z);
    end;
    pen.width:=20;
    for i:=1 to 9 do begin
      if belegung[i]='1' then kreuz(i-1);
      if belegung[i]='2' then kreis(i-1);
    end;
  end;
  pb1.canvas.draw(0,0,bitmap);
  bitmap.free;
  if timer1.enabled then auswertung(sender);
  pb2paint(sender);
end;

procedure Tftictac.Timer1Timer(Sender: TObject);
var j,nr,wert:integer;
    gefunden:boolean;
    s2,s:_str9;
    k:string;
  function test:integer;
  var ww:integer;
  begin
    if random>Spin1.value/100 then begin
      test:=0;
      if pos('0',s)>0 then begin
        repeat
          ww:=random(9)+1;
        until s[ww]='0';
        test:=ww;
      end;
      exit
    end;
    //sieg
    if s[1]='0' then begin
      if ((s[2]='2') and (s[3]='2')) or
         ((s[4]='2') and (s[7]='2')) or
         ((s[5]='2') and (s[9]='2')) then begin test:=1; exit end;
    end;
    if s[2]='0' then begin
      if ((s[1]='2') and (s[3]='2')) or
         ((s[5]='2') and (s[8]='2')) then begin test:=2; exit end;
    end;
    if s[3]='0' then begin
      if ((s[2]='2') and (s[1]='2')) or
         ((s[6]='2') and (s[9]='2')) or
         ((s[5]='2') and (s[7]='2')) then begin test:=3; exit end;
    end;
    if s[4]='0' then begin
      if ((s[1]='2') and (s[7]='2')) or
         ((s[5]='2') and (s[6]='2')) then begin test:=4; exit end;
    end;
    if s[5]='0' then begin
      if ((s[1]='2') and (s[9]='2')) or
         ((s[2]='2') and (s[8]='2')) or
         ((s[3]='2') and (s[7]='2')) or
         ((s[4]='2') and (s[6]='2')) then begin test:=5; exit end;
    end;
    if s[6]='0' then begin
      if ((s[3]='2') and (s[9]='2')) or
         ((s[5]='2') and (s[4]='2')) then begin test:=6; exit end;
    end;
    if s[7]='0' then begin
      if ((s[1]='2') and (s[4]='2')) or
         ((s[8]='2') and (s[9]='2')) or
         ((s[5]='2') and (s[3]='2')) then begin test:=7; exit end;
    end;
    if s[8]='0' then begin
      if ((s[2]='2') and (s[5]='2')) or
         ((s[7]='2') and (s[9]='2')) then begin test:=8; exit end;
    end;
    if s[9]='0' then begin
      if ((s[3]='2') and (s[6]='2')) or
         ((s[7]='2') and (s[8]='2')) or
         ((s[5]='2') and (s[1]='2')) then begin test:=9; exit end;
    end;
    //abwehr
    if s[1]='0' then begin
      if ((s[2]='1') and (s[3]='1')) or
         ((s[4]='1') and (s[7]='1')) or
         ((s[5]='1') and (s[9]='1')) then begin test:=1; exit end;
    end;
    if s[2]='0' then begin
      if ((s[1]='1') and (s[3]='1')) or
         ((s[7]='1') and (s[3]='1')) or
         ((s[5]='1') and (s[8]='1')) then begin test:=2; exit end;
    end;
    if s[3]='0' then begin
      if ((s[2]='1') and (s[1]='1')) or
         ((s[6]='1') and (s[9]='1')) or
         ((s[5]='1') and (s[7]='1')) then begin test:=3; exit end;
    end;
    if s[4]='0' then begin
      if ((s[1]='1') and (s[7]='1')) or
         ((s[5]='1') and (s[6]='1')) then begin test:=4; exit end;
    end;
    if s[5]='0' then begin
      if ((s[1]='1') and (s[9]='1')) or
         ((s[2]='1') and (s[8]='1')) or
         ((s[3]='1') and (s[7]='1')) or
         ((s[4]='1') and (s[6]='1')) then begin test:=5; exit end;
    end;
    if s[6]='0' then begin
      if ((s[3]='1') and (s[9]='1')) or
         ((s[5]='1') and (s[4]='1')) then begin test:=6; exit end;
    end;
    if s[7]='0' then begin
      if ((s[1]='1') and (s[4]='1')) or
         ((s[8]='1') and (s[9]='1')) or
         ((s[5]='1') and (s[3]='1')) then begin test:=7; exit end;
    end;
    if s[8]='0' then begin
      if ((s[2]='1') and (s[5]='1')) or
         ((s[7]='1') and (s[9]='1')) then begin test:=8; exit end;
    end;
    if s[9]='0' then begin
      if ((s[3]='1') and (s[6]='1')) or
         ((s[7]='1') and (s[8]='1')) or
         ((s[5]='1') and (s[1]='1')) then begin test:=9; exit end;
    end;
    if s[1]='0' then begin
      if ((s[2]='1') and (s[4]='1')) or ((s[2]='1') and (s[7]='1'))
         or ((s[4]='1') and (s[3]='1')) then begin test:=1; exit end;
    end;
    if s[3]='0' then begin
      if ((s[2]='1') and (s[6]='1')) or ((s[2]='1') and (s[9]='1'))
         or ((s[6]='1') and (s[1]='1')) or ((s[5]='1') and (s[9]='1'))
         then begin test:=3; exit end;
    end;
    if s[7]='0' then begin
      if ((s[4]='1') and (s[8]='1')) or ((s[1]='1') and (s[8]='1'))
         or ((s[4]='1') and (s[9]='1')) then begin test:=7; exit end;
    end;
    if s[9]='0' then begin
      if ((s[6]='1') and (s[8]='1')) or ((s[3]='1') and (s[8]='1'))
         or ((s[6]='1') and (s[7]='1')) then begin test:=9; exit end;
    end;
    //angriff
    if s[5]='0' then begin
      if ((s[2]='2') and (s[8]='0')) or
         ((s[2]='0') and (s[8]='2')) or
         ((s[4]='0') and (s[6]='2')) or
         ((s[4]='2') and (s[6]='0')) then begin test:=5; exit end;
    end;
    if s[1]='0' then begin
      if ((s[2]='2') and (s[3]='0')) or
         ((s[2]='0') and (s[3]='2')) or
         ((s[4]='0') and (s[7]='2')) or
         ((s[4]='2') and (s[7]='0')) or
         ((s[5]='2') and (s[9]='0')) or
         ((s[5]='0') and (s[9]='2')) then begin test:=1; exit end;
    end;
    if s[2]='0' then begin
      if ((s[1]='2') and (s[3]='0')) or
         ((s[1]='0') and (s[3]='2')) or
         ((s[5]='0') and (s[8]='2')) or
         ((s[5]='2') and (s[8]='0')) then begin test:=2; exit end;
    end;
    if s[3]='0' then begin
      if ((s[1]='2') and (s[2]='0')) or
         ((s[1]='0') and (s[2]='2')) or
         ((s[6]='0') and (s[9]='2')) or
         ((s[6]='2') and (s[9]='0')) or
         ((s[5]='2') and (s[7]='0')) or
         ((s[5]='0') and (s[7]='2')) then begin test:=3; exit end;
    end;
    if s[4]='0' then begin
      if ((s[1]='2') and (s[7]='0')) or
         ((s[1]='0') and (s[7]='2')) or
         ((s[5]='0') and (s[6]='2')) or
         ((s[5]='2') and (s[6]='0')) then begin test:=4; exit end;
    end;
    if s[6]='0' then begin
      if ((s[3]='2') and (s[9]='0')) or
         ((s[3]='0') and (s[9]='2')) or
         ((s[5]='0') and (s[4]='2')) or
         ((s[5]='2') and (s[4]='0')) then begin test:=6; exit end;
    end;
    if s[7]='0' then begin
      if ((s[1]='2') and (s[4]='0')) or
         ((s[1]='0') and (s[4]='2')) or
         ((s[8]='0') and (s[9]='2')) or
         ((s[8]='2') and (s[9]='0')) or
         ((s[5]='2') and (s[3]='0')) or
         ((s[5]='0') and (s[3]='2')) then begin test:=7; exit end;
    end;
    if s[8]='0' then begin
      if ((s[2]='2') and (s[5]='0')) or
         ((s[2]='0') and (s[5]='2')) or
         ((s[7]='0') and (s[9]='2')) or
         ((s[7]='2') and (s[9]='0')) then begin test:=8; exit end;
    end;
    if s[9]='0' then begin
      if ((s[3]='2') and (s[6]='0')) or
         ((s[3]='0') and (s[6]='2')) or
         ((s[8]='0') and (s[7]='2')) or
         ((s[8]='2') and (s[7]='0')) or
         ((s[5]='2') and (s[1]='0')) or
         ((s[5]='0') and (s[1]='2')) then begin test:=9; exit end;
    end;
    if s[5]='0' then begin test:=5; exit end;
    if pos('0',s)>0 then begin
      repeat
        ww:=random(9)+1;
      until s[ww]='0';
      test:=ww;
    end
    else timer1.enabled:=false;
  end;
begin
  label1.caption:=timetostr((integer(gettickcount)-zeit0)/1000/3600/24);
  if not zug then exit;
  s2:=belegung;
  s:=belegung;
  nr:=0;
  j:=0;
  gefunden:=false;
  repeat
    if pos(s2,liste.items[j])>0 then begin
      gefunden:=true;
      nr:=j
    end;
    inc(j);
  until gefunden or (j>=liste.items.count);
  if gefunden then begin
    k:=liste.items[nr];
    k:=copy(k,pos(#9,k)+1,255);
    if length(k)=1 then belegung[ord(k[1])-48]:='2'
    else begin
      belegung[ord(k[random(length(k))+1])-48]:='2'
    end;
  end else begin
    wert:=test;
    if wert>0 then belegung[wert]:='2'
  end;
  pb1paint(sender);
  zug:=not zug;
end;

procedure Tftictac.pb2Paint(Sender: TObject);
var z,xm,ym:integer;
    bitmap:tbitmap;
procedure kreuz;
begin
  bitmap.canvas.pen.color:=clnavy;
  bitmap.canvas.moveto(xm-z div 3,ym-z div 3);
  bitmap.canvas.lineto(xm+z div 3,ym+z div 3);
  bitmap.canvas.moveto(xm+z div 3,ym-z div 3);
  bitmap.canvas.lineto(xm-z div 3,ym+z div 3);
end;
procedure kreis;
begin
  bitmap.canvas.pen.color:=clred;
  bitmap.canvas.ellipse(xm-z div 3,ym-z div 3,
                        xm+z div 3+1,ym+z div 3+1);
end;
begin
  bitmap:=tbitmap.create;
  bitmap.width:=pb2.width;
  bitmap.height:=pb2.height;
  with bitmap.canvas do begin
    font.name:='Verdana';
    font.size:=24;
    brush.color:=$00f0f0f0;
    rectangle(-1,-1,bitmap.width+1,bitmap.height+1);
    pen.width:=6;
    pen.color:=clblue;
    xm:=30;
    ym:=30;
    z:=50;
    kreuz;
    pen.color:=clblack;
    ym:=80;
    bitmap.canvas.moveto(xm-z div 3,ym-5);
    bitmap.canvas.lineto(xm+z div 3,ym-5);
    bitmap.canvas.moveto(xm-z div 3,ym+5);
    bitmap.canvas.lineto(xm+z div 3,ym+5);
    pen.color:=clred;
    ym:=130;
    kreis;
    textout(80,10,inttostr(erg1));
    textout(80,60,inttostr(erg3));
    textout(80,110,inttostr(erg2));
  end;
  pb2.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure Tftictac.Button2Click(Sender: TObject);
var j,nr,wert:integer;
    gefunden:boolean;
    s2,s:_str9;
    k:string;
function test:integer;
var ww:integer;
begin
//sieg
  if random>Spin1.value/100 then begin
    test:=0;
    if pos('0',s)>0 then begin
      repeat
        ww:=random(9)+1;
      until s[ww]='0';
      test:=ww;
    end;
    exit
  end;
  if s[1]='0' then begin
    if ((s[2]='2') and (s[3]='2')) or
       ((s[4]='2') and (s[7]='2')) or
       ((s[5]='2') and (s[9]='2')) then begin test:=1; exit end;
  end;
  if s[2]='0' then begin
    if ((s[1]='2') and (s[3]='2')) or
       ((s[5]='2') and (s[8]='2')) then begin test:=2; exit end;
  end;
  if s[3]='0' then begin
    if ((s[2]='2') and (s[1]='2')) or
       ((s[6]='2') and (s[9]='2')) or
       ((s[5]='2') and (s[7]='2')) then begin test:=3; exit end;
  end;
  if s[4]='0' then begin
    if ((s[1]='2') and (s[7]='2')) or
       ((s[5]='2') and (s[6]='2')) then begin test:=4; exit end;
  end;
  if s[5]='0' then begin
    if ((s[1]='2') and (s[9]='2')) or
       ((s[2]='2') and (s[8]='2')) or
       ((s[3]='2') and (s[7]='2')) or
       ((s[4]='2') and (s[6]='2')) then begin test:=5; exit end;
  end;
  if s[6]='0' then begin
    if ((s[3]='2') and (s[9]='2')) or
       ((s[5]='2') and (s[4]='2')) then begin test:=6; exit end;
  end;
  if s[7]='0' then begin
    if ((s[1]='2') and (s[4]='2')) or
       ((s[8]='2') and (s[9]='2')) or
       ((s[5]='2') and (s[3]='2')) then begin test:=7; exit end;
  end;
  if s[8]='0' then begin
    if ((s[2]='2') and (s[5]='2')) or
       ((s[7]='2') and (s[9]='2')) then begin test:=8; exit end;
  end;
  if s[9]='0' then begin
    if ((s[3]='2') and (s[6]='2')) or
       ((s[7]='2') and (s[8]='2')) or
       ((s[5]='2') and (s[1]='2')) then begin test:=9; exit end;
  end;
//abwehr
  if s[1]='0' then begin
    if ((s[2]='1') and (s[3]='1')) or
       ((s[4]='1') and (s[7]='1')) or
       ((s[5]='1') and (s[9]='1')) then begin test:=1; exit end;
  end;
  if s[2]='0' then begin
    if ((s[1]='1') and (s[3]='1')) or
       ((s[5]='1') and (s[8]='1')) then begin test:=2; exit end;
  end;
  if s[3]='0' then begin
    if ((s[2]='1') and (s[1]='1')) or
       ((s[6]='1') and (s[9]='1')) or
       ((s[5]='1') and (s[7]='1')) then begin test:=3; exit end;
  end;
  if s[4]='0' then begin
    if ((s[1]='1') and (s[7]='1')) or
       ((s[5]='1') and (s[6]='1')) then begin test:=4; exit end;
  end;
  if s[5]='0' then begin
    if ((s[1]='1') and (s[9]='1')) or
       ((s[2]='1') and (s[8]='1')) or
       ((s[3]='1') and (s[7]='1')) or
       ((s[4]='1') and (s[6]='1')) then begin test:=5; exit end;
  end;
  if s[6]='0' then begin
    if ((s[3]='1') and (s[9]='1')) or
       ((s[5]='1') and (s[4]='1')) then begin test:=6; exit end;
  end;
  if s[7]='0' then begin
    if ((s[1]='1') and (s[4]='1')) or
       ((s[8]='1') and (s[9]='1')) or
       ((s[5]='1') and (s[3]='1')) then begin test:=7; exit end;
  end;
  if s[8]='0' then begin
    if ((s[2]='1') and (s[5]='1')) or
       ((s[7]='1') and (s[9]='1')) then begin test:=8; exit end;
  end;
  if s[9]='0' then begin
    if ((s[3]='1') and (s[6]='1')) or
       ((s[7]='1') and (s[8]='1')) or
       ((s[5]='1') and (s[1]='1')) then begin test:=9; exit end;
  end;
  if s[1]='0' then begin
    if ((s[2]='1') and (s[4]='1')) or ((s[2]='1') and (s[7]='1'))
       or ((s[4]='1') and (s[3]='1')) then begin test:=1; exit end;
  end;
  if s[3]='0' then begin
    if ((s[2]='1') and (s[6]='1')) or ((s[2]='1') and (s[9]='1'))
       or ((s[6]='1') and (s[1]='1'))
       or ((s[5]='1') and (s[9]='1')) then begin test:=3; exit end;
  end;
  if s[7]='0' then begin
    if ((s[4]='1') and (s[8]='1')) or ((s[1]='1') and (s[8]='1'))
       or ((s[4]='1') and (s[9]='1')) then begin test:=7; exit end;
  end;
  if s[9]='0' then begin
    if ((s[6]='1') and (s[8]='1')) or ((s[3]='1') and (s[8]='1'))
       or ((s[6]='1') and (s[7]='1')) then begin test:=9; exit end;
  end;
//angriff
  if s[5]='0' then begin
    if ((s[2]='2') and (s[8]='0')) or
       ((s[2]='0') and (s[8]='2')) or
       ((s[4]='0') and (s[6]='2')) or
       ((s[4]='2') and (s[6]='0')) then begin test:=5; exit end;
  end;
  if s[1]='0' then begin
    if ((s[2]='2') and (s[3]='0')) or
       ((s[2]='0') and (s[3]='2')) or
       ((s[4]='0') and (s[7]='2')) or
       ((s[4]='2') and (s[7]='0')) or
       ((s[5]='2') and (s[9]='0')) or
       ((s[5]='0') and (s[9]='2')) then begin test:=1; exit end;
  end;
  if s[2]='0' then begin
    if ((s[1]='2') and (s[3]='0')) or
       ((s[1]='0') and (s[3]='2')) or
       ((s[5]='0') and (s[8]='2')) or
       ((s[5]='2') and (s[8]='0')) then begin test:=2; exit end;
  end;
  if s[3]='0' then begin
    if ((s[1]='2') and (s[2]='0')) or
       ((s[1]='0') and (s[2]='2')) or
       ((s[6]='0') and (s[9]='2')) or
       ((s[6]='2') and (s[9]='0')) or
       ((s[5]='2') and (s[7]='0')) or
       ((s[5]='0') and (s[7]='2')) then begin test:=3; exit end;
  end;
  if s[4]='0' then begin
    if ((s[1]='2') and (s[7]='0')) or
       ((s[1]='0') and (s[7]='2')) or
       ((s[5]='0') and (s[6]='2')) or
       ((s[5]='2') and (s[6]='0')) then begin test:=4; exit end;
  end;
  if s[6]='0' then begin
    if ((s[3]='2') and (s[9]='0')) or
       ((s[3]='0') and (s[9]='2')) or
       ((s[5]='0') and (s[4]='2')) or
       ((s[5]='2') and (s[4]='0')) then begin test:=6; exit end;
  end;
  if s[7]='0' then begin
    if ((s[1]='2') and (s[4]='0')) or
       ((s[1]='0') and (s[4]='2')) or
       ((s[8]='0') and (s[9]='2')) or
       ((s[8]='2') and (s[9]='0')) or
       ((s[5]='2') and (s[3]='0')) or
       ((s[5]='0') and (s[3]='2')) then begin test:=7; exit end;
  end;
  if s[8]='0' then begin
    if ((s[2]='2') and (s[5]='0')) or
       ((s[2]='0') and (s[5]='2')) or
       ((s[7]='0') and (s[9]='2')) or
       ((s[7]='2') and (s[9]='0')) then begin test:=8; exit end;
  end;
  if s[9]='0' then begin
    if ((s[3]='2') and (s[6]='0')) or
       ((s[3]='0') and (s[6]='2')) or
       ((s[8]='0') and (s[7]='2')) or
       ((s[8]='2') and (s[7]='0')) or
       ((s[5]='2') and (s[1]='0')) or
       ((s[5]='0') and (s[1]='2')) then begin test:=9; exit end;
  end;
  if s[5]='0' then begin
    test:=5;
    exit
  end;
  if pos('0',s)>0 then begin
    repeat
      ww:=random(9)+1;
    until s[ww]='0';
    test:=ww;
  end;
end;

function test2:integer;
var ww:integer;
begin
  if random>Spin1.value/100 then begin
    if pos('0',s)>0 then begin
      repeat
        ww:=random(9)+1;
      until s[ww]='0';
      test2:=ww;
    end;
    exit
  end;
//sieg
  if s[1]='0' then begin
    if ((s[2]='1') and (s[3]='1')) or
       ((s[4]='1') and (s[7]='1')) or
       ((s[5]='1') and (s[9]='1')) then begin test2:=1; exit end;
  end;
  if s[2]='0' then begin
    if ((s[1]='1') and (s[3]='1')) or
       ((s[5]='1') and (s[8]='1')) then begin test2:=2; exit end;
  end;
  if s[3]='0' then begin
    if ((s[2]='1') and (s[1]='1')) or
       ((s[6]='1') and (s[9]='1')) or
       ((s[5]='1') and (s[7]='1')) then begin test2:=3; exit end;
  end;
  if s[4]='0' then begin
    if ((s[1]='1') and (s[7]='1')) or
       ((s[5]='1') and (s[6]='1')) then begin test2:=4; exit end;
  end;
  if s[5]='0' then begin
    if ((s[1]='1') and (s[9]='1')) or
       ((s[2]='1') and (s[8]='1')) or
       ((s[3]='1') and (s[7]='1')) or
       ((s[4]='1') and (s[6]='1')) then begin test2:=5; exit end;
  end;
  if s[6]='0' then begin
    if ((s[3]='1') and (s[9]='1')) or
       ((s[5]='1') and (s[4]='1')) then begin test2:=6; exit end;
  end;
  if s[7]='0' then begin
    if ((s[1]='1') and (s[4]='1')) or
       ((s[8]='1') and (s[9]='1')) or
       ((s[5]='1') and (s[3]='1')) then begin test2:=7; exit end;
  end;
  if s[8]='0' then begin
    if ((s[2]='1') and (s[5]='1')) or
       ((s[7]='1') and (s[9]='1')) then begin test2:=8; exit end;
  end;
  if s[9]='0' then begin
    if ((s[3]='1') and (s[6]='1')) or
       ((s[7]='1') and (s[8]='1')) or
       ((s[5]='1') and (s[1]='1')) then begin test2:=9; exit end;
  end;
//abwehr
  if s[1]='0' then begin
    if ((s[2]='2') and (s[3]='2')) or
       ((s[4]='2') and (s[7]='2')) or
       ((s[5]='2') and (s[9]='2')) then begin test2:=1; exit end;
  end;
  if s[2]='0' then begin
    if ((s[1]='2') and (s[3]='2')) or
       ((s[5]='2') and (s[8]='2')) then begin test2:=2; exit end;
  end;
  if s[3]='0' then begin
    if ((s[2]='2') and (s[1]='2')) or
       ((s[6]='2') and (s[9]='2')) or
       ((s[5]='2') and (s[7]='2')) then begin test2:=3; exit end;
  end;
  if s[4]='0' then begin
    if ((s[1]='2') and (s[7]='2')) or
       ((s[5]='2') and (s[6]='2')) then begin test2:=4; exit end;
  end;
  if s[5]='0' then begin
    if ((s[1]='2') and (s[9]='2')) or
       ((s[2]='2') and (s[8]='2')) or
       ((s[3]='2') and (s[7]='2')) or
       ((s[4]='2') and (s[6]='2')) then begin test2:=5; exit end;
  end;
  if s[6]='0' then begin
    if ((s[3]='2') and (s[9]='2')) or
       ((s[5]='2') and (s[4]='2')) then begin test2:=6; exit; end;
  end;
  if s[7]='0' then begin
    if ((s[1]='2') and (s[4]='2')) or
       ((s[8]='2') and (s[9]='2')) or
       ((s[5]='2') and (s[3]='2')) then begin test2:=7; exit end;
  end;
  if s[8]='0' then begin
    if ((s[2]='2') and (s[5]='2')) or
       ((s[7]='2') and (s[9]='2')) then begin test2:=8; exit end;
  end;
  if s[9]='0' then begin
    if ((s[3]='2') and (s[6]='2')) or
       ((s[7]='2') and (s[8]='2')) or
       ((s[5]='2') and (s[1]='2')) then begin test2:=9; exit end;
  end;
  if s[1]='0' then begin
    if ((s[2]='2') and (s[4]='2')) or ((s[2]='2') and (s[7]='2'))
       or ((s[4]='2') and (s[3]='2')) then begin test2:=1; exit end;
  end;
  if s[3]='0' then begin
    if ((s[2]='2') and (s[6]='2')) or ((s[2]='2') and (s[9]='2'))
       or ((s[6]='2') and (s[1]='2')) or ((s[5]='2') and (s[9]='2')) then begin test2:=3; exit end;
  end;
  if s[7]='0' then begin
    if ((s[4]='2') and (s[8]='2')) or ((s[1]='2') and (s[8]='2'))
       or ((s[4]='2') and (s[9]='2')) then begin test2:=7; exit end;
  end;
  if s[9]='0' then begin
    if ((s[6]='2') and (s[8]='2')) or ((s[3]='2') and (s[8]='2'))
       or ((s[6]='2') and (s[7]='2')) then begin test2:=9; exit end;
  end;
//angriff
  if s[5]='0' then begin
    if ((s[2]='1') and (s[8]='0')) or
       ((s[2]='0') and (s[8]='1')) or
       ((s[4]='0') and (s[6]='1')) or
       ((s[4]='1') and (s[6]='0')) then begin test2:=5; exit end;
  end;
  if s[1]='0' then begin
    if ((s[2]='1') and (s[3]='0')) or
       ((s[2]='0') and (s[3]='1')) or
       ((s[4]='0') and (s[7]='1')) or
       ((s[4]='1') and (s[7]='0')) or
       ((s[5]='1') and (s[9]='0')) or
       ((s[5]='0') and (s[9]='1')) then begin test2:=1; exit end;
  end;
  if s[2]='0' then begin
    if ((s[1]='1') and (s[3]='0')) or
       ((s[1]='0') and (s[3]='1')) or
       ((s[5]='0') and (s[8]='1')) or
       ((s[5]='1') and (s[8]='0')) then begin test2:=2; exit end;
  end;
  if s[3]='0' then begin
    if ((s[1]='1') and (s[2]='0')) or
       ((s[1]='0') and (s[2]='1')) or
       ((s[6]='0') and (s[9]='1')) or
       ((s[6]='1') and (s[9]='0')) or
       ((s[5]='1') and (s[7]='0')) or
       ((s[5]='0') and (s[7]='1')) then begin test2:=3; exit end;
  end;
  if s[4]='0' then begin
    if ((s[1]='1') and (s[7]='0')) or
       ((s[1]='0') and (s[7]='1')) or
       ((s[5]='0') and (s[6]='1')) or
       ((s[5]='1') and (s[6]='0')) then begin test2:=4; exit end;
  end;
  if s[6]='0' then begin
    if ((s[3]='1') and (s[9]='0')) or
       ((s[3]='0') and (s[9]='1')) or
       ((s[5]='0') and (s[4]='1')) or
       ((s[5]='1') and (s[4]='0')) then begin test2:=6; exit end;
  end;
  if s[7]='0' then begin
    if ((s[1]='1') and (s[4]='0')) or
       ((s[1]='0') and (s[4]='1')) or
       ((s[8]='0') and (s[9]='1')) or
       ((s[8]='1') and (s[9]='0')) or
       ((s[5]='1') and (s[3]='0')) or
       ((s[5]='0') and (s[3]='1')) then begin test2:=7; exit end;
  end;
  if s[8]='0' then begin
    if ((s[2]='1') and (s[5]='0')) or
       ((s[2]='0') and (s[5]='1')) or
       ((s[7]='0') and (s[9]='1')) or
       ((s[7]='1') and (s[9]='0')) then begin test2:=8; exit end;
  end;
  if s[9]='0' then begin
    if ((s[3]='1') and (s[6]='0')) or
       ((s[3]='0') and (s[6]='1')) or
       ((s[8]='0') and (s[7]='1')) or
       ((s[8]='1') and (s[7]='0')) or
       ((s[5]='1') and (s[1]='0')) or
       ((s[5]='0') and (s[1]='1')) then begin test2:=9; exit end;
  end;
  if s[5]='0' then begin
    test2:=5;
    exit
  end;
  if pos('0',s)>0 then begin
    repeat
      ww:=random(9)+1;
    until s[ww]='0';
    test2:=ww;
  end;
end;

function testq(q:char):boolean;
begin
  testq:=false;
  if
     ((belegung[1]=q) and (belegung[2]=q) and (belegung[3]=q)) or
     ((belegung[1]=q) and (belegung[4]=q) and (belegung[7]=q)) or
     ((belegung[1]=q) and (belegung[5]=q) and (belegung[9]=q)) or
     ((belegung[2]=q) and (belegung[5]=q) and (belegung[8]=q)) or
     ((belegung[3]=q) and (belegung[5]=q) and (belegung[7]=q)) or
     ((belegung[3]=q) and (belegung[6]=q) and (belegung[9]=q)) or
     ((belegung[7]=q) and (belegung[8]=q) and (belegung[9]=q)) or
     ((belegung[4]=q) and (belegung[5]=q) and (belegung[6]=q)) then begin
    testq:=true;
    exit
  end;
end;
begin
  if not abbruch then begin
    button2.caption:='Computer gegen Computer';
    abbruch:=true;
    exit
  end;
  abbruch:=false;
  button2.caption:='Abbruch';
  timer1.enabled:=false;
  erg1:=0;
  erg2:=0;
  erg3:=0;
  repeat
    belegung:='000000000';
    label2.caption:='';
    repeat
      s2:=belegung;
      s:=belegung;
      nr:=0;
      j:=0;
      gefunden:=false;
      repeat
        if pos(s2,liste.items[j])>0 then begin
          gefunden:=true;
          nr:=j
        end;
        inc(j);
      until gefunden or (j>=liste.items.count);
      if gefunden then begin
        k:=liste.items[nr];
        k:=copy(k,pos(#9,k)+1,255);
        if length(k)=1 then belegung[ord(k[1])-48]:='2'
        else begin
          wert:=random(length(k))+1;
          belegung[ord(k[wert])-48]:='2';
        end;
      end else begin
        wert:=test;
        if wert>0 then belegung[wert]:='2';
      end;
//gegenzug
      if pos('0',belegung)>0 then begin
        s2:=belegung;
        s:=belegung;
        nr:=0;
        j:=0;
        gefunden:=false;
        repeat
          if pos(s2,liste.items[j])>0 then begin
            gefunden:=true;
            nr:=j
          end;
          inc(j);
        until gefunden or (j>=liste.items.count);
        if gefunden then begin
          k:=liste.items[nr];
          k:=copy(k,pos(#9,k)+1,255);
          if length(k)=1 then belegung[ord(k[1])-48]:='1'
          else begin
            wert:=random(length(k))+1;
            belegung[ord(k[wert])-48]:='1';
          end;
        end else begin
          wert:=test2;
          if wert>0 then belegung[wert]:='1';
        end;
        pb1paint(sender);
        application.processmessages;
      end;
    until pos('0',belegung)=0;
    if testq('1') then inc(erg1)
    else
      if testq('2') then inc(erg2)
                    else inc(erg3);
    pb2paint(sender);
    application.processmessages;
  until abbruch or (erg3=9999);
  button2.caption:='Computer gegen Computer';
  abbruch:=true;
end;

procedure Tftictac.FormShow(Sender: TObject);
begin
  timer1.enabled:=false;
  abbruch:=true;
  button1click(sender);
end;

end.
