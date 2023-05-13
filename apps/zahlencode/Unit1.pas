unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
var k:string;
begin
   k:=edit1.text;
   listbox1.items.add(k);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var s,i:integer; k:string;
begin
   k:=listbox1.items[listbox1.itemindex];
  if k<>'' then begin
   for i:=1 to length(k) do k[i]:=upcase(k[i]);
   s:=0;
   for i:=1 to length(k) do begin
       case k[i] of
        'A'..'I' : s:=s+ord(k[i])-64;
        'J'..'R' : s:=s+10*(ord(k[i])-73);
        'S'..'Z' : s:=s+100*(ord(k[i])-82);
    end end;
   if k='LEON' then s:=777;
   label1.caption:=k+' hat den Zahlencode '+inttostr(s);
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var datei:textfile;
    s:string;
begin
  listbox1.clear;
    assignfile(datei,'namen.txt');
    reset(datei);
    repeat
      readln(datei,s);
      listbox1.Items.Add(s);
    until eof(datei);
    closefile(datei);
end;

procedure TForm1.Button3Click(Sender: TObject);
var datei:textfile;
    s:string;
    i:integer;
begin
  assignfile(datei,'namen.txt');
  rewrite(datei);
  for i:=0 to listbox1.items.count-1 do
  begin
    s:=listbox1.Items[i];
    writeln(datei,s);
  end;
  closefile(datei);
end;

end.
