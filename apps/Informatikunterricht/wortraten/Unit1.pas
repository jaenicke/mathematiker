unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Edit1: TEdit;
    Button28: TButton;
    procedure Button1Click(Sender: TObject);
    procedure anzeige(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure test(b:char;Sender: TObject);
    procedure Button28Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  ratewort,eingabewort:string;
  fehler:integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i,anz:integer;
begin
  anz:=listbox1.items.count;
  ratewort:=uppercase(listbox1.items[random(anz)]);
  eingabewort:=ratewort;
  for i:=1 to length(eingabewort) do eingabewort[i]:='•';
  fehler:=0;
  anzeige(sender);
end;

procedure TForm1.anzeige(Sender: TObject);
begin
  label1.Caption:=eingabewort;
  label2.caption:='Fehler '+inttostr(fehler);
  if ratewort=eingabewort then showmessage('Gratulation. Du hast das Wort erraten!');
end;

procedure TForm1.test(b:char;Sender: TObject);
var gefunden:boolean;
    i:integer;
begin
  gefunden:=false;
  for i:=1 to length(ratewort) do begin
    if ratewort[i]=b then begin
      eingabewort[i]:=b;
      gefunden:=true;
    end;
  end;
  if not gefunden then inc(fehler);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  randomize;
  button1click(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if sender=button2 then test('A',sender);
  if sender=button3 then test('B',sender);
  if sender=button4 then test('C',sender);
  if sender=button5 then test('D',sender);
  if sender=button6 then test('E',sender);
  if sender=button7 then test('F',sender);
  if sender=button8 then test('G',sender);
  if sender=button9 then test('H',sender);
  if sender=button10 then test('I',sender);
  if sender=button11 then test('J',sender);
  if sender=button12 then test('K',sender);
  if sender=button13 then test('L',sender);
  if sender=button14 then test('M',sender);
  if sender=button15 then test('N',sender);
  if sender=button16 then test('O',sender);
  if sender=button17 then test('P',sender);
  if sender=button18 then test('Q',sender);
  if sender=button19 then test('R',sender);
  if sender=button20 then test('S',sender);
  if sender=button21 then test('T',sender);
  if sender=button22 then test('U',sender);
  if sender=button23 then test('V',sender);
  if sender=button24 then test('W',sender);
  if sender=button25 then test('X',sender);
  if sender=button26 then test('Y',sender);
  if sender=button27 then test('Z',sender);
  anzeige(sender);
end;

procedure TForm1.Button28Click(Sender: TObject);
var b:char;
begin
  if length(edit1.Text)>0 then begin
    b:=upcase(edit1.text[1]);
    test(b,sender);
    anzeige(sender);
  end;
end;

end.
