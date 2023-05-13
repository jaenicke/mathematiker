unit uturmit;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

const
    MaximaleZustaende = 10;
    MaximaleFarben = 10;
type
  Tameise = record
              x,y,r,d: LongInt;
             end;
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Label4: TLabel;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    TempBitmap : tbitmap;

    ameisen : tAmeise;
    NeuX,NeuY : array of Integer;
    Speicher : array of array of byte;
    Regelstring : string;
    Regel : array[0..MaximaleFarben,0..1,0..MaximaleZustaende] of byte;

    Geschwindigkeit, Breite, Hoehe,delta :integer;
    Schritte:int64;

    Abbruch : boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  pPixel : pInteger;
  i,j,s,Zustand,Maxzustand,MaxFarben :integer;
  pScanlines : array of pInteger;
  Anzeigewert : real;
const
    Farben:array[0..19] of integer =
      ($00,$0ffffff,$00000040,$0ff0000,$000ff00,$0ff00ff,$000ffff,$00ffff00,
      $08000ff,$00080ff,$0080ff00,$0ff0080,$000ff80,$00ff8000,$0800080,$0008080,
      $0808000,$0808080,$00008080,$0800080);

function ein_int(const Edit:tedit ; a,b:integer):integer;
var kk:string;
    x,code:integer;
begin
    kk:=Edit.text;
    val(kk,x,code);
    if x<a then x:=a;
    if x>b then x:=b;
    ein_int:=x;
end;

begin
    //Abbruch der Darstellung
    if not Abbruch then
    begin
       Abbruch:=true;
       Exit;
    end;
    //Abbruchmöglichkeit einstellen
    Abbruch:=false;
    Button1.Caption:='Abbruch';
    Label3.Caption:='0 Mill.';

    //Regelsystem lesen und als boolean speichern
    Regelstring:=uppercase(combobox1.text);
    while pos('{',Regelstring)>0 do delete(Regelstring,pos('{',Regelstring),1);
    while pos('}',Regelstring)>0 do delete(Regelstring,pos('}',Regelstring),1);
    while pos(',',Regelstring)>0 do delete(Regelstring,pos(',',Regelstring),1);
    while pos(' ',Regelstring)>0 do delete(Regelstring,pos(' ',Regelstring),1);

    //erste 2 Zeichen enthalten Zustandszahl und Farbzahl
    Maxzustand:=ord(Regelstring[1])-48-1;
    MaxFarben:=ord(Regelstring[2])-48-1;
    delete(Regelstring,1,2);

    for i:=0 to maxzustand do
    begin
      for j:=0 to MaxFarben do
      begin
        Regel[i,j,0]:=ord(Regelstring[6*i+3*j+1])-48;
        if Regel[i,j,0]>MaxFarben then Regel[i,j,0]:=0;
        case Regelstring[6*i+3*j+2] of
         '8' : Regel[i,j,1]:=1;
         '2' : Regel[i,j,1]:=2;
         '4' : Regel[i,j,1]:=3;
         else  Regel[i,j,1]:=0; //'N'
        end;
        Regel[i,j,2]:=ord(Regelstring[6*i+3*j+3])-48;
        if Regel[i,j,2]>maxzustand then Regel[i,j,2]:=0;
      end;
    end;

    //Anzeigegeschwindigkeit
    Geschwindigkeit:=5000*ein_int(Edit3, 1, 500);
    delta := Geschwindigkeit;

    //Bitmap für Darstellung
    Tempbitmap:=Tbitmap.create;
    Tempbitmap.PixelFormat:=pf32bit;
    Breite:=Paintbox1.width;
    Hoehe:=Paintbox1.height;

    Tempbitmap.width:=Breite;
    Tempbitmap.height:=Hoehe;

    setlength(pScanlines,Hoehe);
    for i:=0 to Hoehe-1 do
      pScanlines[i] := TempBitMap.ScanLine[i];

    //internes Feld zum Speichern der Zustände
    SetLength(Speicher, Hoehe, Breite);
    for i:=0 to Hoehe-1 do
      for j:=0 to Breite-1 do
        Speicher[i,j]:=0;

    // Subtraktionsfeld, an der Stelle i steht der Vorgänger
    SetLength(NeuX,breite+2);
    i := high(NeuX);
    NeuX[i] := 0;
    For i := i-1 downto 1 do
      NeuX[i] := i-1;
    NeuX[0] := Breite-1;

    SetLength(NeuY,Hoehe+2);
    i := high(NeuY);
    NeuY[i] := 0;
    For i := i-1 downto 1 do
      NeuY[i] := i-1;
    NeuY[0] := Hoehe-1;

    Tempbitmap.Canvas.Rectangle(-1, -1, Breite+1, Hoehe+1);

    //Zufallswerte für Start
    with Ameisen do Begin
      x:=Breite div 2;
      y:=Hoehe div 2;
      r :=1;
    end;

    Schritte:=0;
    Zustand:=0;

    //Darstellungsschleife
    repeat
        with Ameisen do Begin
        //Farbe nach Zustand setzen
         s := Speicher[y,x];
         pPixel := pScanLines[y];
         inc(pPixel,x);
         pPixel^ := Farben[Regel[Zustand,s,0]];

         // Neue Richtung bestimmen
         //Richtungsänderung entsprechend Regel
         Speicher[y,x] := Regel[Zustand,s,0];

         case Regel[Zustand,s,1] of
           0 : ;
           1 : r:=(r+1) mod 4;
           2 : r:=(r+3) mod 4;
           3 : r:=(r+2) mod 4;
         end;

         //Zustand erhöhen
         Zustand:=Regel[Zustand,s,2];

        //Drehen nach links bzw. rechts
        //und Torusgrenzen abfragen
        case r of
          0 : x := NeuX[x+2];   //inc(ax)
          1 : y := NeuY[y+2];
          2 : x := NeuX[x];     //dec(ax)
          3 : y := NeuY[y];
        end;
      end;

      //Anzeige und Test auf Abbruch
      inc(Schritte);
      dec(delta);
      if delta <= 0 then
      begin
        delta := Geschwindigkeit;
           begin
           Anzeigewert:=Schritte/1000000;
           Label3.Caption:=format('%.0f Mill.', [Anzeigewert]);
        end;
        Application.Processmessages;
        Paintbox1.Canvas.Draw(0, 0, Tempbitmap);
        IF Abbruch then BREAK;
      end;
    until false;
    Paintbox1.Canvas.Draw(0, 0, Tempbitmap);

    //Grundzustand herstellen
    Abbruch:=true;
    Button1.caption:='Start';
    SetLength(pScanlines,0);
    SetLength(NeuY,0);
    SetLength(NeuX,0);
    SetLength(Speicher, 0, 0);
    Tempbitmap.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    if not Abbruch then Abbruch:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    Abbruch:=true;
end;

end.
