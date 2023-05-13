unit upolynom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  math, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label2: TLabel;
    Edit9: TEdit;
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
const maxgrad=8;                  //maximale Potenz, muss festgelegt werden, hier 8
type _feld = array[0..maxgrad+1] of integer;
     gfeld=array[0..maxgrad+1,0..maxgrad+1] of real;       //Koeffizientenmatrix für Gaußverfahren

var polynom:_feld;

procedure polynomfaktorisieren;
var i,j,n,m:integer;
     //Faktorpolynome werden im Feld gespeichert
    teiler:array[1..maxgrad+1] of
        record ko:array[0..maxgrad+1] of integer end;
    teilerzahl:integer;
    a,b,e,koeff:_feld;

//Rekursive Suchprozedur
procedure suche(a:_feld);
var ende:boolean;
    i,n,j,z:integer;

//Test auf Teilbarkeit des Polynoms a
function test(a,b:_feld;m:integer):boolean;
var n0,i,x:integer;
begin
    fillchar(e,sizeof(e),0);
    n0:=n;
    while (n0>=m) do
    begin
      e[n0-m]:=a[n0] div b[m];
      for i:=0 to m do a[n0-i]:=a[n0-i]-e[n0-m]*b[m-i];
      dec(n0);
    end;
    //Ergebnis steht in e
    //Rest steht in a
    x:=0;
    for i:=0 to maxgrad+1 do x:=x or a[i];
    //telbar, wenn Rest = 0
    test:=x=0;
end;

//zusätzliche Variablen für Test auf quadratische Terme
var   nr,x,y,hi:integer;
      suchgrad:integer;
      f:array[0..maxgrad+1] of integer;     //Funktionswerte
      tz:array[0..maxgrad+1] of integer;   //Anzahl Teiler der Funktionswerte
      xx:array[0..maxgrad+1] of integer;   //Abszissen der Stützstellen
      tk:array[0..maxgrad+1] of integer;   //Koeffizienten für Gaußverfahren
      tex:array[0..maxgrad+1,0..200] of integer;   //Teiler der Funktionswerte
      korrekt:boolean;
      zaehler:array[0..maxgrad+1] of integer;    //Feld für Zählschleifen

//Teilersuche der Funktionswerte des Polynoms
procedure teilerx(a:integer;b:integer);
var z,i:integer;
begin
    z:=a;
    tex[b,1]:=1; tex[b,2]:=-1;
    tex[b,3]:=z; tex[b,4]:=-z;
    tz[b]:=5;
    for i:=2 to round(sqrt(abs(z))) do
    begin
        if z mod i=0 then begin
                     tex[b,tz[b]]:=i;
                     //auch negative Teiler
                     tex[b,tz[b]+1]:=-i;
                     //auch Komplementärteiler
                     tex[b,tz[b]+2]:=a div i;
                     tex[b,tz[b]+3]:=-(a div i);
                     inc(tz[b],4);
                     end;
    end;
    dec(tz[b]);
end;

//Lösen des Gleichungssystems für Polynomkonstruktion
procedure gaussv(var ko:gfeld; grad:integer; var fehler:boolean);
var v:array[0..maxgrad+1] of byte;
    i,j,k,g:byte;
    det,f,f0:real;
    tau:integer;
begin
    f0:=0;
    for i:=1 to grad do v[i]:=i;
    tau:=1;
    f:=1;
    for i:=1 to grad do f:=f*ko[i,i];
    if f<0 then tau:=-tau;

    for k:=1 to grad-1 do
    begin
      f:=abs(ko[k,k]);
      g:=k;
      for j:=k+1 to grad do begin
        if f<abs(ko[k,j]) then begin f:=abs(ko[k,j]); g:=j end;
      end;
      if g<>k then begin
        j:=v[k]; v[k]:=v[g]; v[g]:=j; tau:=-tau;
        for i:=1 to grad do begin
          f:=ko[i,k]; ko[i,k]:=ko[i,g]; ko[i,g]:=f;
        end;
      end;
      f0:=ko[k,k];
      if f0<>0 then begin
        for j:=k+1 to grad do begin
           f:=ko[j,k];
           for i:=1 to k-1 do f:=f-ko[j,i]*ko[i,k];
           ko[j,k]:=f/f0;
        end;
        for j:=k+1 to grad do begin
           f:=ko[k+1,j];
           for i:=1 to k do f:=f-ko[k+1,i]*ko[i,j];
           ko[k+1,j]:=f;
        end;
      end;
    end;
    f:=1;
    for k:=1 to grad do f:=f*abs(ko[k,k]);
    det:=f*tau;

    if (f<>0) and (f0<>0) and (abs(det)>0.000001) then begin
      for i:=2 to grad do begin
        f:=ko[i,0];
        for j:=1 to i-1 do f:=f-ko[j,0]*ko[i,j];
        ko[i,0]:=f;
      end;
      ko[grad,0]:=ko[grad,0]/ko[grad,grad];
      for i:=grad-1 downto 1 do begin
        f:=ko[i,0];
        for j:=i+1 to grad do f:=f-ko[i,j]*ko[j,0];
        ko[i,0]:=f/ko[i,i];
      end;
      for i:=1 to grad do begin
        if i=v[i] then ko[0,i]:=ko[i,0]
        else begin
          j:=i; k:=v[j];
          while i<>v[j] do begin k:=v[j]; j:=v[j] end;
          ko[0,i]:=ko[k,0];
        end;
      end;
      fehler:=false;
    end
    else fehler:=true;
end;

//Konstruktion des Teilerpolynoms
function konstrukt(grad:integer):boolean;
var ko:gfeld;
    det:real;
    fehler:boolean;
    i,j:integer;
begin
    fehler:=false;
    //Koeffizientenmatrix Null setzen
    fillchar(ko,sizeof(ko),0);
    //Ergebniskoeffizienten Null setzen
    fillchar(koeff,sizeof(koeff),0);
    //Matrix füllen
    for i:=1 to grad do
    begin
      ko[i,0]:=tk[i-1];
      for j:=1 to grad do
      begin
        ko[i,j]:=power(xx[i-1],j-1);
      end;
    end;
    //Gaußverfahren
    gaussv(ko,grad,fehler);
    //Ergebnis kopieren, wenn wahrscheinlich ganzzahlige
    for i:=1 to grad do begin
       if frac(abs(ko[0,i]))>1e-3 then fehler:=true
          else koeff[i-1]:=round(ko[0,i]);
    end;
    //Fehlerstatus der Ganzzahligkeit
    konstrukt:=not fehler;
end;

begin
    ende:=true;
    //Test auf Nullpolynom, evtl. Abbruch
    for i:=0 to maxgrad+1 do ende:=ende and (a[i]<>0);
    if ende then exit;

    //evtl. Polynom x abspalten
    while a[0]=0 do begin
      for i:=1 to maxgrad+1 do a[i-1]:=a[i];
      a[maxgrad+1]:=0;
      inc(teilerzahl);
      teiler[teilerzahl].ko[3]:=0;
      teiler[teilerzahl].ko[2]:=0;
      teiler[teilerzahl].ko[1]:=1;
      teiler[teilerzahl].ko[0]:=0;
    end;

    //Suche nach linearen, quadratischen und kubischen Termen
    for suchgrad:=1 to 3 do
    begin
      //Schleifenzähler Null setzen
      fillchar(zaehler,sizeof(zaehler),0);
      //Polynomgrad bestimmen
      n:=maxgrad+1;
      while (a[n]=0) and (n>0) do dec(n);
      //wenn Grad kleiner Suchgrat Abbruch
      if n<suchgrad then exit;

      //Stützstellen suchen
      nr:=0;
      x:=0;
      f[nr]:=0;
      for i:=n downto 0 do f[nr]:=f[nr]*x+a[i]; //Horner-Schema
      if f[nr]<>0 then begin xx[nr]:=0; inc(nr); end;
      y:=1;
      repeat
        x:=y;
        f[nr]:=0;
        for i:=n downto 0 do f[nr]:=f[nr]*x+a[i];
        if f[nr]<>0 then begin xx[nr]:=x; inc(nr); end;
        x:=-y;
        f[nr]:=0;
        for i:=n downto 0 do f[nr]:=f[nr]*x+a[i];
        if f[nr]<>0 then begin xx[nr]:=x; inc(nr); end;
        inc(y);
      until nr>=maxgrad; //mehr Stützstellen als notwendig
      //Sortieren nach Größe
      for i:=0 to maxgrad-2 do
      for j:=i+1 to maxgrad-1 do
      begin
        if abs(f[i])>abs(f[j]) then begin
           hi:=f[i]; f[i]:=f[j]; f[j]:=hi;
           hi:=xx[i]; xx[i]:=xx[j]; xx[j]:=hi;
        end;
      end;
      //kleinste Stützstellen verwenden
      for i:=0 to suchgrad do teilerx(f[i],i);
      //Schleifenzähler auf 1 setzen
      //alle Tupel von Teilern der Funktionswerte testen
      for i:=0 to suchgrad do zaehler[i]:=1;

      repeat
        //Teiler auswählen
        for i:=0 to suchgrad do tk[i]:=tex[i,zaehler[i]];

        //Polynom konstruieren
        if konstrukt(suchgrad+1) then
        begin
          //Polynomkoeffizienten setzen
          b:=koeff;
          korrekt:=false;
          //Test auf höchsten von Null verschiedenen Koeffizienten
          //und Teilbarkeitstest
          for i:=suchgrad downto 1 do
          begin
            if b[i]<>0 then begin
              korrekt:=test(a,b,i);
              break;
            end;
          end;
          if korrekt then begin
            //wenn teilbar, Teilerpolynom speichern
            inc(teilerzahl);
            for i:=suchgrad downto 0 do teiler[teilerzahl].ko[i]:=b[i];
            //Weiterrechnen mit Restpolynom
            suche(e);
            exit;
          end;
        end;

        //untersten Zähler erhöhen
        inc(zaehler[0]);
        //Test auf Überlauf der Zähler
        for i:=0 to suchgrad-1 do
        begin
          if zaehler[i]>tz[i] then begin
             zaehler[i]:=1;
             inc(zaehler[i+1]);
          end;
        end;
      //Abbruch, wenn letzter Zähler überläuft
      until zaehler[suchgrad]>tz[suchgrad];
    end;
end;
procedure ausgabe(e:_feld);
var i:byte;
    kk,kp:string;
begin
    kk:='';
    for i:=maxgrad downto 0 do
    begin
      if e[i]<>0 then
      begin
        kp:=inttostr(e[i]);
        if e[i]>0 then kp:=' +'+kp
                  else kp:=' '+kp;
        if i<>0 then
        begin
          if e[i]=1 then kk:=kk+' +X'
          else
            if e[i]=-1 then kk:=kk+' -X'
            else
              kk:=kk+kp+'*X';
          if i>1 then
          begin
            str(i,kp);
            kk:=kk+'^'+kp;
          end;
        end
        else kk:=kk+kp;
      end;
    end;

    if kk='' then kk:='0';
    while (length(kk)>1) and (kk[1]=' ') do delete(kk,1,1);
    if kk[1]='+' then delete(kk,1,1);
    while (length(kk)>1) and (kk[1]=' ') do delete(kk,1,1);
    memo1.lines.add(kk);
end;

begin
    //Teiler und Polynomkoeffizienten Null setzen
    fillchar(teiler,sizeof(teiler),0);
    fillchar(a,sizeof(a),0);
    teilerzahl:=0;

    //Hier Koeffizienten des Polynoms a eintragen
    // a[0] Absolutglied, a[1] lineares Glied, ...

    //Testwerte 
    //a(x)= -270*X^8 -4269*X^7 -8780*X^6 +50109*X^5 -118478*X^4 +184881*X^3 -90698*X^2 +4488*X
    //  a[8]:=-270;    a[7]:=-4269;   a[6]:=-8780;
    //  a[5]:=50109;   a[4]:=-118478; a[3]:=184881;
    //  a[2]:=-90698;  a[1]:=4488;    a[0]:=0;

    for i:=0 to 8 do a[i]:=polynom[i];

    //Grad des Polynoms bestimmen
    n:=maxgrad+1;
    while (a[n]=0) and (n>0) do dec(n);
    //Abbruch bei Nullpolynom
    if (n=0) and (a[0]=0) then exit;

    //Faktorsuche
    suche(a);
    //am Ende stehen Faktoren im Feld teiler

    //Irreduzibles Restpolynom muss noch durch Division ermittelt werden
    // restpolynom = a / alle Teiler
    if teilerzahl>0 then 
    begin
      for i:=1 to teilerzahl do
      begin
        fillchar(e,sizeof(e),0);
        n:=maxgrad;
        while (a[n]=0) and (n>0) do dec(n);

        fillchar(b,sizeof(b),0);
        for j:=0 to maxgrad do
           b[j]:=teiler[i].ko[j];
        ausgabe(b);
        m:=maxgrad;
        while b[m]=0 do dec(m);
        while (n>=m) do
        begin
           e[n-m]:=a[n] div b[m];
           for j:=0 to m do a[n-j]:=a[n-j]-e[n-m]*b[m-j];
           dec(n);
        end;
        a:=e;
      end;
    end;
        ausgabe(a);

    //Ergebnis:  a(x) = X(-18*X + 1)(X^2 -X + 3)(-3*X^2 -23*X +17)(-5*X^2 -46*X +88)
end;
begin
    fillchar(polynom,sizeof(polynom),0);
    if edit1.text<>'' then polynom[0]:=strtoint(edit1.text);
    if edit2.text<>'' then polynom[1]:=strtoint(edit2.text);
    if edit3.text<>'' then polynom[2]:=strtoint(edit3.text);
    if edit4.text<>'' then polynom[3]:=strtoint(edit4.text);
    if edit5.text<>'' then polynom[4]:=strtoint(edit5.text);
    if edit6.text<>'' then polynom[5]:=strtoint(edit6.text);
    if edit7.text<>'' then polynom[6]:=strtoint(edit7.text);
    if edit8.text<>'' then polynom[7]:=strtoint(edit8.text);
    if edit9.text<>'' then polynom[8]:=strtoint(edit9.text);
    memo1.clear;
    polynomfaktorisieren;
end;

end.
