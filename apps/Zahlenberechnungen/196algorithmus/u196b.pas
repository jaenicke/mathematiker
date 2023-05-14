unit u196b;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  abbruch:boolean;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
const zmax:integer=999;
var k:string;
    i,anz,laenge:integer;
    gefunden:boolean;
    z,e:array of byte;
    Time1, Time2, Freq: Int64;
begin
    if abbruch=false then begin abbruch:=true; exit end;
    button1.caption:='Abbruch';
    label3.caption:='';
    abbruch:=false;
    memo1.clear;
    application.processmessages;

    zmax:=strtoint(edit2.text);
    if zmax<100 then zmax:=100;

    setlength(z,zmax+2);
    setlength(e,zmax+2);
    for i:=0 to zmax do z[i]:=0;
    k:=edit1.text;
    if k='' then k:='196';
    laenge:=length(k);
    for i:=laenge downto 1 do z[laenge-i]:=ord(k[i])-48;
    anz:=0;

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Time1);

    repeat
      inc(anz);
      if checkbox1.checked then begin
        k:='';
        for i:=0 to laenge-1 do k:=chr(z[i]+48)+k;
        memo1.lines.add(inttostr(anz)+#9+k+' ('+inttostr(laenge)+')');
      end;
      for i:=0 to laenge-1 do e[i]:=z[i]+z[laenge-1-i];
      for i:=0 to laenge-1 do begin
        if e[i]>9 then begin
          inc(e[i+1]);
          e[i]:=e[i]-10;
        end;
      end;
      if e[laenge]>0 then inc(laenge);

      gefunden:=true;
      i:=0;
      repeat
        if e[i]<>e[laenge-1-i] then gefunden:=false;
        inc(i);
      until (not gefunden) or (i>laenge div 2);

      if gefunden then
      begin
        memo1.lines.add('Palindrom gefunden im Schritt '+inttostr(anz));
        k:='';
        for i:=0 to laenge-1 do k:=chr(e[i]+48)+k;
        memo1.lines.add(k);
      end
      else
        for i:=0 to laenge-1 do z[i]:=e[i];

      if anz mod 1000 = 0 then begin
        label4.caption:=inttostr(laenge);
        QueryPerformanceCounter(Time2);
        label6.caption:=inttostr(anz)+' Zyklen | '+floattostrf((Time2-Time1)/freq,ffgeneral,10,6)+' s';
        application.processmessages;
      end;
    until abbruch or gefunden or (laenge>zmax);

    label4.caption:=inttostr(laenge);
    label6.caption:=inttostr(anz)+' Zyklen | '+floattostrf((Time2-Time1)/freq,ffgeneral,10,6)+' s';
    if abbruch or (laenge>zmax) then
    begin
      memo1.lines.add('Folgenglied im Schritt '+inttostr(anz));
      memo1.lines.add('Länge '+inttostr(laenge));
      if checkbox1.checked then begin
        k:='';
        for i:=0 to laenge-1 do k:=chr(z[i]+48)+k;
        memo1.lines.add(k);
      end;
    end;
    button1.caption:='Berechnung';
    abbruch:=true;
    setlength(z,0);
    setlength(e,0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    abbruch:=true;
end;

end.
