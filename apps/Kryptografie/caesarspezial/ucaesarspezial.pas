unit ucaesarspezial;
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
    i,w,l:integer;
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
      i:=1;
      repeat
        case kt[i] of
         'A'..'Z' : w:=65+((ord(kt[i])-65)+i) mod 26;
         'a'..'z' : w:=97+((ord(kt[i])-97)+i) mod 26;
        else w:=ord(kt[i]);
        end;
        kz:=kz+chr(w);
        inc(i);
      until i>l;
      memo2.lines.add(kz);
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var kp,kt,kz:string;
    w,j,i:integer;
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
      i:=1;
      j:=1;
      repeat
        case kt[i] of
         'A'..'Z' : w:=65+((ord(kt[i])-65)-j+26) mod 26;
         'a'..'z' : w:=97+((ord(kt[i])-97)-j+26) mod 26;
        else w:=ord(kt[i]);
        end;
        kz:=kz+chr(w);
        inc(i);
        j:=(j+1) mod 26;
      until i>length(kt);
      memo1.lines.add(kz);
    end;
end;

end.
