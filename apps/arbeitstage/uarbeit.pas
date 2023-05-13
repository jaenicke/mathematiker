unit uarbeit;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    Label3: TLabel;
    Label5: TLabel;
    ListBox4: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure auswahl(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function ostersonntag(jahr:integer):tdatetime;
var a,b,c,d,e,n,m,p,f,g,h,i,k,l,j:integer;
begin
     j:=jahr;
     A:= J mod 19;
     B:= J div 100;
     C:= J mod 100;
     D:= B div 4;
     E:= B mod 4;
     F:= (B+8) div 25;
     G:= (B-F+1) div 3;
     H:= (19*A+B-D-G+15) mod 30;
     I:= C div 4;
     J:= C mod 4;
     K:= J mod 100;
     L:= (32+2*E+2*I-H-K) mod 7;
     M:= (A+11*H+22*L) div 451;
     N:= (H+L-7*M+114) div 31;
     P:= (H+l-7*M+114) mod 31;
     ostersonntag:=encodedate(jahr,n,p+1);
end;
function bettag(jahr:integer):tdatetime;
var  heiligabend,advent4:tdatetime;
begin
     heiligabend:=encodedate(jahr,12,24);
     advent4:=heiligabend-dayofweek(heiligabend)+1;
     bettag:=advent4-21-11;
end;
function naefelserfahrt(j:integer):tdatetime;
var wochentag:integer;
begin
     wochentag:=dayofweek(encodedate(j,4,1));
     case wochentag of
       1..4 : wochentag:=6-wochentag;
          5 : wochentag:=1;
       6..7 : wochentag:=13-wochentag;
     end;
     naefelserfahrt:=encodedate(j,4,wochentag);
end;
function vaud(j:integer):tdatetime;
var wochentag:integer;
begin
     //Donnerstag nach dem 1.Sonntag im September
     wochentag:=dayofweek(encodedate(j,9,1));
     case wochentag of
       2..7 : wochentag:=9-wochentag;
     end;
     vaud:=encodedate(j,9,wochentag+4);
end;
function schweiz(j:integer):tdatetime;
var wochentag:integer;
begin
     //3.Sonntag im September
     wochentag:=dayofweek(encodedate(j,9,1));
     case wochentag of
       2..7 : wochentag:=9-wochentag;
     end;
     schweiz:=encodedate(j,9,wochentag+14);
end;

procedure TForm1.Button1Click(Sender: TObject);
var  d1,d2,dsonntag1,dsonntag2,ostern:tdatetime;
     arbeitstage,arbeitstage0,gesamt,wochentag1,wochentag2:integer;
     jahr1,jahr2,monat1,monat2,tag1,tag2:word;
     j,nr:integer;
     drund1,drund2,drundfeier:integer;
     s:string;
procedure test(dfeier:tdatetime);
begin
     drundfeier:=round(dfeier);
     if (drundfeier>=drund1) and (drundfeier<=drund2) then
     begin
       if dayofweek(dfeier) in [1,7] then exit;
       dec(arbeitstage);
     end;
end;
begin
     d1:=datetimepicker1.date;
     d2:=datetimepicker2.date;
     drund1:=round(d1);
     drund2:=round(d2);

     wochentag1:=dayofweek(d1);
     wochentag2:=dayofweek(d2);
     decodedate(d1,jahr1,monat1,tag1);
     decodedate(d2,jahr2,monat2,tag2);

     arbeitstage:=0;
     dsonntag1:=d1;
     if wochentag1>1 then
     begin
       dsonntag1:=d1+8-wochentag1;
       arbeitstage:=arbeitstage+7-wochentag1;
     end;
     dsonntag2:=d2;
     if wochentag2>1 then
     begin
       dsonntag2:=d2-wochentag2+1;
       if wochentag2<7 then arbeitstage:=arbeitstage+wochentag2-1
                       else arbeitstage:=arbeitstage+5;
     end;

     arbeitstage:=arbeitstage+5*(round(dsonntag2-dsonntag1) div 7);

     listbox1.clear;
     listbox1.items.add('Arbeitstage');
     listbox1.items.add('ab'#9+datetostr(d1));
     listbox1.items.add('bis einschließlich'#9+datetostr(d2));
     listbox1.items.add('');
//   ohne Berücksichtigung der Feiertage
     gesamt:=arbeitstage;
     arbeitstage0:=arbeitstage;
     listbox1.items.add('Arbeitstage (Feiertage in der Woche)');

     //Bundesländer, Österreich, Schweiz, Liechtenstein
     for nr:=1 to 43 do
     begin
       arbeitstage:=arbeitstage0;

       for j:=jahr1 to jahr2 do
       begin
         test(encodedate(j,1,1));    //Neujahr                      Nr.1
         ostern:=ostersonntag(j);
         if nr in [1..16,18..43] then
            test(ostern-2);          //Karfreitag                   Nr.3
         if nr in [1..39,41..43] then
            test(ostern+1);          //Ostermontag                  Nr.4
         test(ostern+39);            //Himmelfahrt                  Nr.5
         if nr in [1..39,41..43] then
            test(ostern+50);         //Pfingstmontag                Nr.7
         if nr in [1..18,28..30,35..37,40,42,43] then
            test(encodedate(j,5,1)); //1.Mai                        Nr.8
         test(encodedate(j,12,25));  //Weihnachten                  Nr.9

         if nr in [1..30,33..37,39,40,43] then
         begin
            test(encodedate(j,12,26)); //2.Weihnachstag               Nr.10
         end
         else
         begin
          //26.12. nicht, wenn 25.12. Montag oder Freitag in Appenzell
          //kein 26.12. in Vaud,Genf,Jura
            if nr in [31,32] then
               if not(dayofweek(encodedate(j,12,25)) in [2,6]) then test(encodedate(j,12,26));
         end;

         //3.10.
         if nr in [1..16] then test(encodedate(j,10,3));         //Nr.11
         //Heilige 3 Könige
         if nr in [1,2,14,17,21,22,37,43] then test(encodedate(j,1,6)); //Nr.12
         //Fronleichnam
         if nr in [1,2,7,10,11,12,17,20..24,26..28,32,35,37,39,40,42,43] then
                  test(ostern+60);                               //Nr.13
         //Maria Himmelfahrt
         if nr in [2,12,17,20..24,26..28,32,35,37,39,42,43] then
                  test(encodedate(j,8,15));                      //Nr.14
         //Reformation
         if nr in [4,8,13,14,16] then test(encodedate(j,10,31)); //Nr.15
         //Aller Heiligen
         if nr in [1,2,10..12,17,20..28,32,33,35,37,39,42,43] then
                  test(encodedate(j,11,1));                      //Nr.16
         //Buß- und Bettag
         if nr in [13] then test(bettag(j));                     //Nr.17
         //Österreich Nationalfeiertag
         if nr in [17] then test(encodedate(j,10,26));           //Nr.18
         //Maria Empfängnis
         if nr in [17,20..24,26,27,32,35,37,39,43] then
                  test(encodedate(j,12,8));                      //Nr.19
         //Maria Geburt
         if nr in [43] then test(encodedate(j,9,8));             //Nr.20

         //Schweiz
         if nr in [18..42] then test(encodedate(j,8,1));         //Nr.21
         //Berchtholdstag
         if nr in [18..20,23..28,30,33,35,36,38..40,42] then
                  test(encodedate(j,1,2));                       //Nr.22
         //Josephstag
         if nr in [21,22,24,28,37,39] then
                  test(encodedate(j,3,19));                      //Nr.23
         //Bruderklausenfest
         if nr in [23] then test(encodedate(j,9,25));            //Nr.24
         //Mauritiustag
         if nr in [32] then test(encodedate(j,9,22));            //Nr.25
         //Republiktag
         if nr in [40] then test(encodedate(j,3,1));             //Nr.26
         //Republiktag
         if nr in [41] then test(encodedate(j,12,31));           //Nr.27
         //Republiktag
         if nr in [42] then test(encodedate(j,6,23));            //Nr.28
         //Fahrtsfest in Glarus
         if nr in [25] then test(naefelserfahrt(j));             //Nr.29
         //Schweizer Buß- und Bettag im Sonntags                       //Nr.30
         //Vaud-Genfer Buß- und Bettag
         if nr in [38,41] then test(vaud(j));                    //Nr.31
         //San Pietro (Ticino)
         if nr in [37] then test(encodedate(j,6,29));            //Nr.32
       end;

       s:=#9+inttostr(arbeitstage)+'   ('+inttostr(gesamt-arbeitstage)+')';
       listbox1.items.add(listbox2.items[nr-1]+s);
{        1 : listbox1.items.add('Baden-Württemberg'+s);
         2 : listbox1.items.add('Bayern'+s);
         3 : listbox1.items.add('Berlin'+s);
         4 : listbox1.items.add('Brandenburg'+s);
         5 : listbox1.items.add('Bremen'+s);
         6 : listbox1.items.add('Hamburg'+s);
         7 : listbox1.items.add('Hessen'+s);
         8 : listbox1.items.add('Mecklenburg-Vorpommern'+s);
         9 : listbox1.items.add('Niedersachsen'+s);
        10 : listbox1.items.add('Nordrhein-Westfalen'+s);
        11 : listbox1.items.add('Rheinland-Pfalz'+s);
        12 : listbox1.items.add('Saarland'+s);
        13 : listbox1.items.add('Sachsen'+s);
        14 : listbox1.items.add('Sachsen-Anhalt'+s);
        15 : listbox1.items.add('Schleswig-Holstein'+s);
        16 : listbox1.items.add('Thüringen'+s);
        17 : listbox1.items.add('Österreich'+s);
        18 : listbox1.items.add('Kanton Zürich'+s);
        19 : listbox1.items.add('Kanton Bern'+s);
        20 : listbox1.items.add('Kanton Luzern'+s);
        21 : listbox1.items.add('Kanton Uri'+s);
        22 : listbox1.items.add('Kanton Schwyz'+s);
        23 : listbox1.items.add('Kanton Obwalden'+s);
        24 : listbox1.items.add('Kanton Nidwalden'+s);
        25 : listbox1.items.add('Kanton Glarus'+s);
        26 : listbox1.items.add('Kanton Zug'+s);
        27 : listbox1.items.add('Kanton Freiburg'+s);
        28 : listbox1.items.add('Kanton Solothurn'+s);
        29 : listbox1.items.add('Kanton Basel (Stadt,Land)'+s);
        30 : listbox1.items.add('Kanton Schaffhausen'+s);
        31 : listbox1.items.add('Kanton Appenzell A.Rh.'+s);
        32 : listbox1.items.add('Kanton Appenzell I.Rh.'+s);
        33 : listbox1.items.add('Kanton St.Gallen'+s);
        34 : listbox1.items.add('Kanton Graubünden'+s);
        35 : listbox1.items.add('Kanton Aargau'+s);
        36 : listbox1.items.add('Kanton Thurgau'+s);
        37 : listbox1.items.add('Cantone del Ticino'+s);
        38 : listbox1.items.add('Canton de Vaud'+s);
        39 : listbox1.items.add('Canton du Valais'+s);
        40 : listbox1.items.add('Canton du Neuchâtel'+s);
        41 : listbox1.items.add('Canton du Genève'+s);
        42 : listbox1.items.add('Canton du Jura'+s);
        43 : listbox1.items.add('Liechtenstein'+s);
    }
     end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    listbox1.doublebuffered:=true;
    listbox3.doublebuffered:=true;
end;

procedure TForm1.auswahl(Sender: TObject);
var  d1,d2,ostern:tdatetime;
     jahr1,jahr2,monat1,monat2,tag1,tag2:word;
     j,nr:integer;
     drund1,drund2,drundfeier:integer;
     k:string;
     sel:integer;

procedure test(dfeier:tdatetime;fest:integer);
var s,od,z:string;
function tag:string;
begin
     case dayofweek(encodedate(j,strtoint(copy(z,1,2)),strtoint(copy(z,4,2)))) of
       1 : tag:='So';
       2 : tag:='Mo';
       3 : tag:='Di';
       4 : tag:='Mi';
       5 : tag:='Do';
       6 : tag:='Fr';
       7 : tag:='Sa';
     end;
end;
begin
     drundfeier:=round(dfeier);
     if (drundfeier>=drund1) and (drundfeier<=drund2) then
     begin
       s:=listbox4.items[fest-1];
       z:='';
       case fest of
         2 : begin
               od:=datetostr(ostern);
               z:=copy(od,4,2)+'/'+copy(od,1,2);
             end;
         3 : begin
               od:=datetostr(ostern-2);
               z:=copy(od,4,2)+'/'+copy(od,1,2);
             end;
              4 : begin
                    od:=datetostr(ostern+1);
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
              5 : begin
                    od:=datetostr(ostern+39);
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
              6 : begin
                    od:=datetostr(ostern+49);
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
              7 : begin
                    od:=datetostr(ostern+50);
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
             13 : begin
                    od:=datetostr(ostern+60);
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
             17 : begin
                    od:=datetostr(bettag(j));
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
             29 : begin
                    od:=datetostr(naefelserfahrt(j));
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
             30 : begin
                    od:=datetostr(schweiz(j));
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
             31 : begin
                    od:=datetostr(vaud(j));
                    z:=copy(od,4,2)+'/'+copy(od,1,2);
                  end;
             else
             begin
               z:=copy(s,4,2)+'/'+copy(s,1,2);
             end;
           end;
           listbox3.items.add(inttostr(j)+'/'+z+'  '+tag+#9+copy(s,7,255));
     end;
end;
begin
   sel:=listbox1.itemindex;
   if sel>=5 then
   begin
     k:=listbox1.items[sel];
     k:=copy(k,1,pos(#9,k)-1);
     label3.caption:='Feiertage: '+k;
     listbox3.clear;
     nr:=sel-4;

     d1:=datetimepicker1.date;
     d2:=datetimepicker2.date;
     drund1:=round(d1);
     drund2:=round(d2);

     decodedate(d1,jahr1,monat1,tag1);
     decodedate(d2,jahr2,monat2,tag2);

     for j:=jahr1 to jahr2 do
     begin
       test(encodedate(j,1,1),1);     //Neujahr                      Nr.1
       ostern:=ostersonntag(j);
       test(ostern,2);                //Ostersonntag                 Nr.2
       if nr in [1..16,18..43] then
          test(ostern-2,3);           //Karfreitag                   Nr.3
       if nr in [1..39,41..43] then
          test(ostern+1,4);           //Ostermontag                  Nr.4
       test(ostern+39,5);             //Himmelfahrt                  Nr.5
       test(ostern+49,6);             //Pfingssonntag                Nr.6
       if nr in [1..39,41..43] then
          test(ostern+50,7);          //Pfingstmontag                Nr.7
       if nr in [1..18,28..30,35..37,40,42,43] then
          test(encodedate(j,5,1),8);  //1.Mai                        Nr.8
       test(encodedate(j,12,25),9);   //Weihnachten                  Nr.9

       if nr in [1..30,33..37,39,40,43] then
       begin
          test(encodedate(j,12,26),10); //2.Weihnachstag               Nr.10
       end
       else
       begin
          if nr in [31,32] then
             if not(dayofweek(encodedate(j,12,25)) in [2,6]) then test(encodedate(j,12,26),10);
       end;
       //3.10.
       if nr in [1..16] then test(encodedate(j,10,3),11);         //Nr.11
       //Heilige 3 Könige
       if nr in [1,2,14,17,21,22,37,43] then test(encodedate(j,1,6),12); //Nr.12
       //Fronleichnam
       if nr in [1,2,7,10,11,12,17,20..24,26..28,32,35,37,39,40,42,43] then
                test(ostern+60,13);                               //Nr.13
       //Maria Himmelfahrt
       if nr in [2,12,17,20..24,26..28,32,35,37,39,42,43] then
                test(encodedate(j,8,15),14);                      //Nr.14
       //Reformation
       if nr in [4,8,13,14,16] then test(encodedate(j,10,31),15); //Nr.15
       //Aller Heiligen
       if nr in [1,2,10..12,17,20..28,32,33,35,37,39,42,43] then
                test(encodedate(j,11,1),16);                      //Nr.16
       //Buß- und Bettag
       if nr in [13] then test(bettag(j),17);                     //Nr.17
       //Österreich Nationalfeiertag
       if nr in [17] then test(encodedate(j,10,26),18);           //Nr.18
       //Maria Empfängnis
       if nr in [17,20..24,26,27,32,35,37,39,43] then
                test(encodedate(j,12,8),19);                      //Nr.19
       //Maria Geburt
       if nr in [43] then test(encodedate(j,9,8),20);             //Nr.20
       //Sondertest Schweiz
       if nr in [18..42] then test(encodedate(j,8,1),21);         //Nr.21

       //Berchtholdstag
       if nr in [18..20,23..28,30,33,35,36,38..40,42] then
                test(encodedate(j,1,2),22);                       //Nr.22
       //Josephstag
       if nr in [21,22,24,28,37,39] then
                test(encodedate(j,3,19),23);                      //Nr.23
       //Bruderklausenfest
       if nr in [23] then test(encodedate(j,9,25),24);            //Nr.24
       //Mauritiustag
       if nr in [32] then test(encodedate(j,9,22),25);            //Nr.25
       //Republiktag
       if nr in [40] then test(encodedate(j,3,1),26);             //Nr.26
       //Republiktag
       if nr in [41] then test(encodedate(j,12,31),27);           //Nr.27
       //Republiktag
       if nr in [42] then test(encodedate(j,6,23),28);            //Nr.28
       //Fahrtsfest in Glarus
       if nr in [25] then test(naefelserfahrt(j),29);             //Nr.29
       //Schweizer Buß- und Bettag im Sonntags
       if nr in [18..37,39,40,42] then test(schweiz(j),30);       //Nr.30
       //Vaud-Genfer Buß- und Bettag
       if nr in [38,41] then test(vaud(j),31);                    //Nr.31
       //San Pietro (Ticino)
       if nr in [37] then test(encodedate(j,6,29),32);            //Nr.32

     end;
   end;
end;

end.
