unit ukalender;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
var Tag,Monat,Jahr,W,C,Y: Integer;
(*
Zellersche Formel
Verfahren zur Ermittlung des Wochentages nach Christian Zeller (1882):
T … Tag, M … Monat, J … Jahr, W … Wochentag,
Sa = 0; So = 1, …, Fr = 6,
C … vergangene Jahrhunderte, Y … Jahresnummer im laufenden Jahrhundert, [ ] … ganzzahlige Division
Januar und Februar werden altrömisch als 13. und 14. Monat des Vorjahres gezählt.
Gregorianischer Kalender
	W = (T+[13·(M+1)/5] +Y +[Y/4] +[C/4] -2C) mod 7
Julianischer Kalender
	W = (T + [13·(M+1)/5] + Y + [Y/4] + 5 - C) mod 7
*)
begin
  tag:=strtoint(edit1.text);
  monat:=strtoint(edit2.text);
  jahr:=strtoint(edit3.text);
  if monat<3 then begin
    monat:=monat+12;
    jahr:=jahr-1;
  end;
  y:=jahr mod 100;
  c:=jahr div 100;

  w:=(Tag+ (13*(Monat+1)) div 5 + Y + y div 4 + c div 4 -2*C) mod 7;
  while w<0 do w:=w+7;

  if w=0 then edit4.text:='Sonnabend';
  if w=1 then edit4.text:='Sonntag';
  if w=2 then edit4.text:='Montag';
  if w=3 then edit4.text:='Dienstag';
  if w=4 then edit4.text:='Mittwoch';
  if w=5 then edit4.text:='Donnerstag';
  if w=6 then edit4.text:='Freitag';
end;

end.
