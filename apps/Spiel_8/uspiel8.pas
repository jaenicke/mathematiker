unit uspiel8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Klicken(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure spielfeldanzeigen(Sender: TObject);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  spielfeld : array[0..4,0..4] of integer;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var i,j,z1,z2,inv:integer;
    s:string;
    h:char;
begin
    //alle Felder auf -1 setzen, d.h. sperren
    for i:=0 to 4 do
      for j:=0 to 4 do spielfeld[i,j]:=-1;
    //durch Austauschen von Ziffern --> Mischen
    s:='012345678';
    for i:=1 to 100 do begin
      z1:=random(9)+1;
      z2:=random(9)+1;
      h:=s[z1]; s[z1]:=s[z2]; s[z2]:=h;
    end;

    //Inversionen ermitteln ("komplizierte" Mathematik)
    repeat
      inv:=0;
      for i:=1 to 8 do
        for j:=i+1 to 9 do
          if (s[i]<>'0') and (s[j]<>'0') then
             if s[i]>s[j] then inv:=inv+1;
      if odd(inv) then begin
        z1:=random(9)+1;
        z2:=random(9)+1;
        h:=s[z1]; s[z1]:=s[z2]; s[z2]:=h;
      end;
    //Spiel nur bei gerader Anzahl von Inversionen lösbar  
    until not odd(inv);

    //dem Spielfeld den geänderten String zuweisen
    for i:=1 to 3 do
      for j:=1 to 3 do
      begin
        spielfeld[i,j]:=strtoint(s[i+(j-1)*3]);
      end;
    spielfeldanzeigen(sender);
end;

procedure TForm1.spielfeldanzeigen(Sender: TObject);
var i,j:integer;
    s:string;
begin
    //alle Felder anzeigen
    for i:=1 to 3 do
      for j:=1 to 3 do begin
        //die Nummer dem Panel zuweisen, dazu Komponente "finden"
        Tpanel(FindComponent('panel'+IntToStr(i+(j-1)*3))).caption := inttostr(spielfeld[i,j]);
        //Panel nur sichtbar, wenn <> 0
        Tpanel(FindComponent('panel'+IntToStr(i+(j-1)*3))).visible := spielfeld[i,j]<>0;

        {ausführliche, aber unständige Lösung
        case i+(j-1)*3 of
          1 : begin
                panel1.caption := inttostr(spielfeld[i,j]);
                panel1.visible := panel1.caption<>'0';
              end;
          2 : begin
                panel2.caption := inttostr(spielfeld[i,j]);
                panel2.visible := panel2.caption<>'0';
              end;
          3 : begin
                panel3.caption := inttostr(spielfeld[i,j]);
                panel3.visible := panel3.caption<>'0';
              end;
          4 : begin
                panel4.caption := inttostr(spielfeld[i,j]);
                panel4.visible := panel4.caption<>'0';
              end;
          5 : begin
                panel5.caption := inttostr(spielfeld[i,j]);
                panel5.visible := panel5.caption<>'0';
              end;
          6 : begin
                panel6.caption := inttostr(spielfeld[i,j]);
                panel6.visible := panel6.caption<>'0';
              end;
          7 : begin
                panel7.caption := inttostr(spielfeld[i,j]);
                panel7.visible := panel7.caption<>'0';
              end;
          8 : begin
                panel8.caption := inttostr(spielfeld[i,j]);
                panel8.visible := panel8.caption<>'0';
              end;
          9 : begin
                panel9.caption := inttostr(spielfeld[i,j]);
                panel9.visible := panel9.caption<>'0';
              end;
        end;
}
      end;
      //Auswertung
      s:='';
      for j:=1 to 3 do
        for i:=1 to 3 do s:=s+inttostr(spielfeld[i,j]);
      label1.caption:=s;
      if s='123456780' then showmessage('Gratulation! Die Aufgaben wurde gelöst.');
end;

procedure TForm1.Klicken(Sender: TObject);
var x,y,merken:integer;
begin
    x:=1; y:=1;
    //Panel ermitteln, welches geklickt wurde und Koordinaten bestimmen
    if sender=(panel1 as tpanel) then begin x:=1; y:=1 end;
    if sender=(panel2 as tpanel) then begin x:=2; y:=1 end;
    if sender=(panel3 as tpanel) then begin x:=3; y:=1 end;
    if sender=(panel4 as tpanel) then begin x:=1; y:=2 end;
    if sender=(panel5 as tpanel) then begin x:=2; y:=2 end;
    if sender=(panel6 as tpanel) then begin x:=3; y:=2 end;
    if sender=(panel7 as tpanel) then begin x:=1; y:=3 end;
    if sender=(panel8 as tpanel) then begin x:=2; y:=3 end;
    if sender=(panel9 as tpanel) then begin x:=3; y:=3 end;

    //Inhalt des Panels merken
    merken:=spielfeld[x,y];
    //Testen ob links, rechts, oben, unten die 0 steht und dann "verschieben"
    if spielfeld[x-1,y]=0 then begin
       spielfeld[x-1,y]:=merken; spielfeld[x,y]:=0;
    end;
    if spielfeld[x+1,y]=0 then begin
       spielfeld[x+1,y]:=merken; spielfeld[x,y]:=0;
    end;
    if spielfeld[x,y+1]=0 then begin
       spielfeld[x,y+1]:=merken; spielfeld[x,y]:=0;
    end;
    if spielfeld[x,y-1]=0 then begin
       spielfeld[x,y-1]:=merken; spielfeld[x,y]:=0;
    end;
    spielfeldanzeigen(sender);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   randomize;
   button1click(sender);
end;

end.
