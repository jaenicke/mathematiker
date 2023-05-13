unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    lblShift: TLabel; edtShift: TEdit;
    lblPlain: TLabel; edtPlain: TEdit;
    lblCipher: TLabel; edtCipher: TEdit;
    btnEncode: TButton; btnDecode: TButton;
    procedure Encode(Sender: TObject);
    procedure Decode(Sender: TObject);
  end;

var Form1 : TForm1;
        v : integer = 3;

implementation
{$R *.dfm}

procedure TForm1.Encode(Sender: TObject);
var i,len,n : integer;
    klar,geheim : string;
begin
  v := StrToInt(edtShift.Text);
  klar := edtPlain.Text;
  geheim := klar;
  len := length (klar);
  for i:=1 to len do
    begin
      n := ord (klar[i]);               // bestimme die ASCII-Nr. n von klar[i]
      n := 97 + (n + v - 97) mod 26; // Alphabetende überschritten -> Korrektur
      geheim[i] := chr (n);                          // i-tes Zeichen festlegen
    end;
  edtCipher.Text := geheim;                              // Geheimtext ausgeben
end;

procedure TForm1.Decode(Sender: TObject);
var i,len,n : integer;
    klar,geheim : string;
begin
  v := StrToInt(edtShift.Text);
  geheim := edtCipher.Text;
  klar := geheim;
  len := length (geheim);
  for i:=1 to len do
    begin
      n := ord (geheim[i]);           // bestimme die ASCII-Nr. n von geheim[i]
      n := 97 + (n - v - 97 + 26) mod 26;  // Anfang überschritten -> Korrektur
      klar[i] := chr (n);                            // i-tes Zeichen festlegen
    end;
  edtPlain.Text := klar;                                   // Klartext ausgeben
end;

end.


