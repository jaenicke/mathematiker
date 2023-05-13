unit uskytale;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  meter, ComCtrls, StdCtrls, commdlg, ExtCtrls;

type
  TForm1 = class(TForm)
    memo_klar: TMemo;
    b_kodieren: TButton;
    memo_geheim: TMemo;
    b_dekodieren: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure b_kodierenClick(Sender: TObject);
    procedure b_dekodierenClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

const modul:integer=3;

procedure TForm1.b_dekodierenClick(Sender: TObject);
var i,j,abstand,laenge:integer;
    k,geheimtext,klartext:string;
    s:array of string;
begin
    modul:=strtoint(edit1.text);
    if modul<3 then begin
      modul:=3;
      edit1.text:='3';
    end;

    setlength(s,modul+2);
    geheimtext:=memo_geheim.text;
    k:='';
    for i:=1 to length(geheimtext) do
      if geheimtext[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß']
         then
         k:=k+geheimtext[i];
    abstand:=length(k) div modul;
    if length(k) mod modul<>0 then inc(abstand);

    laenge:=length(k) mod modul;
    if laenge=0 then laenge:=laenge+modul;
    
    s[1]:=copy(k,1,abstand);
    delete(k,1,abstand);

    for i:=2 to modul-1 do begin
     if laenge<=i-1 then
       begin
         s[i]:=copy(k,1,abstand-1);
         delete(k,1,abstand-1);
       end else
       begin
         s[i]:=copy(k,1,abstand);
         delete(k,1,abstand);
       end;
    end;
    s[modul]:=k;

    for i:=2 to modul do
      while length(s[i])<abstand do s[i]:=s[i]+' ';

    memo_klar.clear;

    klartext:='';
    for j:=1 to abstand do begin
      for i:=1 to modul do
        klartext:=klartext+s[i][j];
    end;

    j:=1;
    for i:=1 to length(geheimtext) do begin
      if geheimtext[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß']
         then
         begin
          geheimtext[i]:=klartext[j];
           inc(j);
         end;
    end;
    memo_klar.lines.add(geheimtext);
    setlength(s,0);
end;

procedure TForm1.b_kodierenClick(Sender: TObject);
var i,j:integer;
    k,geheimtext,klartext:string;
begin
    modul:=strtoint(edit1.text);
    if modul<3 then begin
      modul:=3;
      edit1.text:='3';
    end;

    geheimtext:=memo_klar.text;
    k:='';
    for i:=1 to length(geheimtext) do
      if geheimtext[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß']
         then
         k:=k+geheimtext[i];

    klartext:='';
    for j:=1 to modul do begin
      i:=j;
      repeat
        klartext:=klartext+k[i];
        i:=i+modul;
      until i>length(k);
    end;

    memo_geheim.clear;

    j:=1;
    for i:=1 to length(geheimtext) do begin
      if geheimtext[i] in ['0'..'9','a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß']
         then
         begin
          geheimtext[i]:=klartext[j];
           inc(j);
         end;
    end;
    memo_geheim.lines.add(geheimtext);
end;

end.
