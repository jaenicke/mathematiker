unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Button3: TButton;
    Label5: TLabel;
    Button4: TButton;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
var s,s2:string; i:integer;
begin
    s:=edit1.text;
    s2:='';
    for i:=1 to length(s) do s2:=s[i]+s2;
    label2.caption:=s2;
end;

procedure TForm1.Button2Click(Sender: TObject);
var s,s2:string; b1,b2:char; i:integer;
begin
    s:=edit1.text;
    b1:=edit2.text[1];
    b2:=edit3.text[1];
    for i:=1 to length(s) do
       if s[i]=b1 then s[i]:=b2;
    label3.caption:=s;
end;

procedure TForm1.Button3Click(Sender: TObject);
var s:string; i:integer;
begin
    s:=edit1.text;
    for i:=1 to length(s) do s[i]:=upcase(s[i]);
    label5.caption:=s;
end;


procedure TForm1.Button4Click(Sender: TObject);
var s,s2:string; i:integer;
begin
    s:=edit1.text;
    s2:='';
    for i:=1 to length(s) do s2:=s2+chr(ord(s[i])+3);
    label6.caption:=s2;
end;

end.
