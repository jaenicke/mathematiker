unit Ugarten;
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
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
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
var kp,kt,kkurz,kz:string;
    zyk,j,i,n,i2,l:integer;
begin
    kt:='';
    kz:='';
    memo2.clear;
    for i:=0 to memo1.lines.count-1 do
    begin
      kp:=memo1.lines.Strings[i];
      kt:=kt+kp;
    end;
    n:=strtoint(edit1.text);
    l:=length(kt);
    if l>0 then
    begin
      if (n<3) or (n>200) then
      begin
        n:=3;
        edit1.text:='3'
      end;

      if checkbox1.checked then
      begin
        kkurz:='';
        for i:=1 to l do
            if kt[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','ß','Ä','Ö','Ü']
            then kkurz:=kkurz+kt[i];
      end
      else
        kkurz:=kt;

      l:=length(kkurz);
      zyk:=2*n-2;
      i:=1;
      repeat
        kz:=kz+kkurz[i];
        i:=i+zyk;
      until i>l;

      j:=2;
      repeat
        i:=j;
        i2:=zyk-j+2;
        repeat
          kz:=kz+kkurz[i];
          if i2<=l then kz:=kz+kkurz[i2];
          i:=i+zyk;
          i2:=i2+zyk;
        until i>l;
        j:=j+1;
      until j>(n-1);

      i:=n;
      repeat
        kz:=kz+kkurz[i];
        i:=i+zyk;
      until i>l;

      if checkbox1.checked then
      begin
        j:=1;
        for i:=1 to length(kt) do
          if kt[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','ß','Ä','Ö','Ü']
             then
             begin
               kt[i]:=kz[j];
               inc(j);
             end;
      end
      else
        kt:=kz;

      memo2.lines.add(kt);
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var kp,kt,kz,kkurz:string;
    zyk,j,i,n,i2,i3:integer;
begin
    kt:='';
    memo1.clear;
    for i:=0 to memo2.lines.count-1 do
    begin
      kp:=memo2.lines.Strings[i];
      kt:=kt+kp;
    end;
    if length(kt)>0 then
    begin
      n:=strtoint(edit1.text);
      if (n<3) or (n>200) then
      begin
        n:=3;
        edit1.text:='3'
      end;

      if checkbox1.checked then
      begin
        kkurz:='';
        for i:=1 to length(kt) do
          if kt[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','ß','Ä','Ö','Ü']
            then kkurz:=kkurz+kt[i];
      end
      else
        kkurz:=kt;

      zyk:=2*n-2;
      kz:=kkurz;
      i:=1;
      j:=1;
      repeat
        kz[j]:=kkurz[i];
        j:=j+zyk;
        inc(i);
      until j>length(kkurz{kt});

      j:=2;
      repeat
        i3:=j;
        i2:=zyk-j+2;
        repeat
          kz[i3]:=kkurz[i];
          inc(i);
          if i2<=length(kkurz) then
          begin
            kz[i2]:=kkurz[i];
            inc(i);
          end;
          i3:=i3+zyk;
          i2:=i2+zyk;
        until i3>length(kkurz);
        inc(j);
      until j>n-1;

      j:=n;
      repeat
        kz[j]:=kkurz[i];
        j:=j+zyk;
        inc(i);
      until j>length(kkurz);

      if checkbox1.checked then
      begin
        j:=1;
        for i:=1 to length(kt) do
          if kt[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','ß','Ä','Ö','Ü']
             then
             begin
               kt[i]:=kz[j];
               inc(j);
             end;
       end
       else
         kt:=kz;

       memo1.lines.add(kt);
    end;
end;

end.
