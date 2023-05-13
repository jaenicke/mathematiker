unit ubruch;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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
const eps=1.0E-08;
      grenze=5000;
var b,re,z1,laenge,z,n,i,r,ganz,j,nn:integer;
    s,k,kr:string;
    rest:array of integer;
    abbruch:boolean;
begin
    setlength(rest,grenze+10);
    memo1.clear;

    //Periodenlänge
    laenge:=strtoint(edit3.text);
    if laenge<10 then
    begin
      laenge:=10;
      edit3.text:=inttostr(laenge)
    end;
    if laenge>grenze then
    begin
      laenge:=grenze;
      edit3.text:=inttostr(laenge)
    end;

    //Zähler, Nenner
    z:=strtoint(edit1.text);
    n:=strtoint(edit2.text);

    if n>0 then
    begin
      //Basen von 2 bis 16
      for b:=2 to 16 do
      begin
        memo1.lines.add('Basis '+inttostr(b));

        for nn:=0 to grenze+5 do rest[nn]:=0;
        //ganzzahliger Anteil
        ganz:=z div n;
        k:='';
        kr:='';
        repeat
          r:=ganz mod b;
          if r in [0..9] then k:=chr(r+48)+k
                         else k:=chr(r+55)+k;
          ganz:=ganz div b;
        until ganz=0;
        k:=k+',';

        z1:=z mod n;
        i:=length(k)+1;
        abbruch:=false;

        repeat
          z1:=z1*b;
          r:=z1 div n;
          re:=z1 div b;
          if re<grenze+1 then
          begin
            if rest[re]=0 then
            begin
              rest[re]:=i;
              if r in [0..9] then k:=k+chr(r+48)
                             else k:=k+chr(r+55);
            end
            else
            begin
              kr:='Periode = '; s:='';
              for j:=rest[re] to i do s:=s+k[j];
              kr:=kr+s;
              abbruch:=true;
            end;
          end
          else
            if r in [0..9] then k:=k+chr(r+48)
                           else k:=k+chr(r+55);
          z1:=z1 mod n;
          inc(i);
        until (i>laenge) or (z1=0) or abbruch;
        if (z1<>0) and (not abbruch) then k:=k+'…';

        memo1.lines.add(k);
        memo1.lines.add(kr);
        memo1.lines.add(' ');
        application.processmessages;
      end;

    end;
    setlength(rest,0);
end;

end.
