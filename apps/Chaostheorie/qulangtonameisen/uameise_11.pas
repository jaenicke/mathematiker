unit uameise_11;
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
  AnzAmeise = 50;
type
  Tameise = record
              x,y,r,d: LongInt;
             end;
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox3: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
  private
    TempBitmap : tbitmap;

    ameisen : array[1..AnzAmeise] of tAmeise;
    NeuX,NeuY,NeuL : array of Integer;
    Speicher : array of array of byte;
    Regel : array[0..20] of boolean;
    Regelstring : string;

    Time1, Time2, Freq: Int64;
    Geschwindigkeit, Anzahl, AmeisenCnt,
    Laenge, Breite, Hoehe,delta :integer;

    Schritte : int64;
    
    Torus, Abbruch, Abbruchtest, Testabbruch : boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

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

function dezimalLR(s:string):integer;
var a,z:int64;
    i:integer;
begin
    if length(s)<2 then
    begin
      dezimalLR:=0;
      exit;
    end;

    z:=1;
    for i:=1 to length(s) do z:=2*z;
    a:=0;
    for i:=1 to length(s) do
    begin
      a:=2*a;
      if s[i]='R' then a:=a+1;
    end;
    z:=z+a;
    dezimalLR:=z;
end;
function dualLR(z:integer):string;
var k:string;
begin
    k:='';
    repeat
      if z mod 2 = 0 then k:='L'+k
                     else k:='R'+k;
      z:=z div 2;
    until z=0;
    delete(k,1,1);
    dualLR:=k;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  pPixel : pInteger;
  i,j,s :integer;
  pScanlines : array of pInteger;
  Anzeigewert : real;
const
    Farben:array[0..19] of integer =
      ($00,$0ffffff,$0ff0000,$000ff00,$00000ff,$0ff00ff,$000ffff,$00ffff00,
      $08000ff,$00080ff,$0080ff00,$0ff0080,$000ff80,$00ff8000,$0800080,$0008080,
      $0808000,$0808080,$00008080,$0800080);
    NeueRichtung : array[false..true]of array [0..3] of integer =
      ((1,2,3,0),(3,0,1,2));

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
    Label3.Caption:='0 Millionen Schritte';

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Time1);
    Torus:=Checkbox1.checked;

    //Regelsystem lesen und als boolean speichern
    Regelstring:=edit2.text;
    if (pos('L',regelstring)>0) or (pos('R',regelstring)>0)
    then
    begin
      Laenge:=Length(Regelstring);
      if Laenge<2 then
      begin
        Regelstring:='LR';
        Laenge:=2;
      end;
      label6.caption:='HHP-Code = '+inttostr(dezimalLR(Regelstring));
    end
    else //HHP-Code in String
    begin
      regelstring:=dualLR(strtoint(edit2.text));
      Laenge:=Length(Regelstring);
    end;

    for i:=1 to Laenge do
      Regel[i-1]:=(Regelstring[i]='L');

    //Anzahl Ameisen
    AmeisenCnt:=ein_int(Edit1, 1, 50);
    //Anzeigegeschwindigkeit
    Geschwindigkeit:=400*ein_int(Edit3, 5, 10000) div AmeisenCnt;
    Anzahl:=100000 div AmeisenCnt;
    delta := Geschwindigkeit;

    //Bitmap für Darstellung
    Tempbitmap:=Tbitmap.create;
    Tempbitmap.PixelFormat:=pf32bit;
    Breite:=Paintbox1.width;
    Hoehe:=Paintbox1.height;

    Tempbitmap.width:=Breite;
    Tempbitmap.height:=Hoehe;

    Tempbitmap.Canvas.Rectangle(-1, -1, Breite+1, Hoehe+1);
    if checkbox3.checked then
      tempbitmap.canvas.textout(10,10,Regelstring);

    setlength(pScanlines,Hoehe);
    for i:=0 to Hoehe-1 do
      pScanlines[i] := TempBitMap.ScanLine[i];
    //internes Feld zum Speichern der Zustände
    SetLength(Speicher, Hoehe, Breite);
    for i:=0 to Hoehe-1 do
      for j:=0 to Breite-1 do
        Speicher[i,j]:=0;

    setlength(NeuL,Laenge);
    for i:=0 to Laenge-2 do
      NeuL[i]:=i+1;
    NeuL[Laenge-1] := 0;

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

    //Zufallswerte für Start
    Randomize;
    for i:=1 to AmeisenCnt do
      with Ameisen[i] do Begin
        x:=Random(Breite);
        y:=Random(Hoehe);
        r :=Random(4);
        end;

    //1-Ameise zentral
    with ameisen[1] do begin
      x :=Breite div 2;
      y :=Hoehe div 2;
      r :=0;
    end;

    Schritte:=0;
    //Darstellungsschleife
    repeat
      //Ameisenzahl abarbeiten
      for i:=1 to AmeisenCnt do
        with Ameisen[i] do Begin
        //Farbe nach Zustand setzen
         s := Speicher[y,x];
         pPixel := pScanLines[y];
         inc(pPixel,x);
         pPixel^ := Farben[s];

         //Zustand erhöhen
         s :=NeuL[s];

         // Neue Richtung bestimmen
         //Richtungsänderung entsprechend Regel
         Speicher[y,x] := s;
         r := NeueRichtung[Regel[s],r];

        if not torus then
        begin
          case r of
            0 : x := x+1;   //inc(ax)
            1 : y := y+1;
            2 : x := x-1;     //dec(ax)
            3 : y := y-1;
          end;
          if (x<0) or (x>breite-1) or (y<0) or (y>hoehe-1)
            then
            begin
              delta:=0;
              abbruch:=true;
            end;  
        end
        else
        begin
          //Drehen nach links bzw. rechts
          //und Torusgrenzen abfragen
          case r of
            0 : x := NeuX[x+2];   //inc(ax)
            1 : y := NeuY[y+2];
            2 : x := NeuX[x];     //dec(ax)
            3 : y := NeuY[y];
          end;
        end;
      end;

      //Anzeige und Test auf Abbruch
      inc(Schritte);
      dec(delta);
      if delta <= 0 then
      begin
        delta := Geschwindigkeit;
           begin
           Anzeigewert:=AmeisenCnt*Schritte/1000000;
           Label3.Caption:=format('%.0f Millionen Schritte', [Anzeigewert]);
           QueryPerformanceCounter(Time2);
           Label5.caption:=
             format(' %8.2f  Mill./s',[Anzeigewert*freq/(Time2-Time1)]);
        end;
        If Testabbruch and (Schritte>50000000) then break;
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
    SetLength(NeuL,0);
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
    AbbruchTest:=true;
    Testabbruch:=false;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
    //Anzahl Ameisen
    AmeisenCnt:=ein_int(Edit1, 1, 50);
    Geschwindigkeit:=400*ein_int(Edit3, 5, 10000) div AmeisenCnt;
    Anzahl:=100000 div AmeisenCnt;
    delta := Geschwindigkeit;
end;

end.
