unit upellform;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    ListBox1: TListBox;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses upell;

procedure TForm1.Button1Click(Sender: TObject);
var d:int64;
procedure kettenbruchwurzel(a:integer);
var x,a1,b1,e,laenge:integer;
    ausgabe:string;
begin
    x:=trunc(sqrt(a+0.01));
    ausgabe:='[' +inttostr(x) + ', ';
    a1:=x;
    b1:=a1;
    e:=a-a1*a1;
    laenge:=0;
    if (e>0) then begin
      while (a1<>2*x) do begin
        a1:=(x+b1) div e;
        ausgabe:= ausgabe + inttostr(a1) + '; ';
        inc(laenge);
        if length(ausgabe)>60 then begin
          listbox1.Items.add(ausgabe);
          ausgabe:='';
        end;
        b1:= a1*e-b1;
        e:=(a-b1*b1) div e;
      end
    end;
    listbox1.Items.add(ausgabe +']');
    listbox1.Items.add('Periodenlänge = '+inttostr(laenge));
end;
begin
  listbox1.Clear;
  d:=strtoint(edit1.Text);
  listbox1.Items.add('D = '+edit1.text);
  listbox1.Items.add('');
  listbox1.Items.Add('Kettenbruch Wurzel(D) = ');
  kettenbruchwurzel(d);
  listbox1.Items.add('');
  if (abs(round(sqrt(1.0*d))-sqrt(1.0*d))>1e-2) and (d>1) then PellBtnClick(d,listbox1)
  else listbox1.Items.add('keine Lösung');
end;

end.
