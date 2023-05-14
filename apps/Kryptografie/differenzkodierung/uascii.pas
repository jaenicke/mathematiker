unit uascii;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var kp,kt,kz:string;
    j,i,w,l:integer;
begin
    kt:='';
    kz:='';
    memo2.clear;
    for i:=0 to memo1.lines.count-1 do
    begin
      kp:=memo1.lines.Strings[i];
      kt:=kt+kp;
    end;

    l:=length(kt);
    if l>0 then
    begin
      kz:= inttohex(ord(kt[1]),2);
      i:=2;
      j:=1;
      repeat
        w:=ord(kt[i])-ord(kt[j]);
        if w<0 then w:=w+256;
        kz:=kz+' '+inttohex(w,2);
        inc(j);
        inc(i);
      until i>l;
      memo2.lines.add(kz);
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var kp,kt,kz,kkurz:string;
    j,i:integer;
function wert(s:string):integer;
var z:integer;
begin
    if s[1] in ['0'..'9'] then z:=ord(s[1])-48
                          else z:=ord(s[1])-55;
    z:=16*z;
    if s[2] in ['0'..'9'] then z:=z+ord(s[2])-48
                          else z:=z+ord(s[2])-55;
    result:=z;
end;
begin
    kt:='';
    kz:='';
    memo1.clear;
    for i:=0 to memo2.lines.count-1 do
    begin
      kp:=memo2.lines.Strings[i];
      kt:=kt+kp;
    end;
    if length(kt)>0 then begin
      kkurz:=copy(kt,1,2);
      delete(kt,1,3);
      i:=wert(kkurz);
      kz:=chr(i);
      repeat
        kkurz:=copy(kt,1,2);
        delete(kt,1,3);
        j:=wert(kkurz);
        i:=i+j;
        if i>255 then i:=i+256;
        kz:=kz+chr(i);
      until length(kt)=0;
      memo1.lines.add(kz);
    end;
end;

end.
