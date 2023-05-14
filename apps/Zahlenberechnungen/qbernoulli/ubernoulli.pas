unit ubernoulli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, math;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
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

uses mp_types, mp_prime, mp_base, mp_numth;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
//const ff=2*3*5*7*11*13*17*23*29;
var  n,z: array of mp_int;
     fd,koeff,x,nn,zz,f,g: mp_int;
     k,i,grenze,start:integer;
     Time1, Time2, Freq: Int64;
     xadd,xbin,xmul,xkur: integer;
     zahl : int64;
     ff : mp_int;

procedure zerlegung(zahl:int64);
var s:string;
    z:integer;
begin
    while zahl mod 2 = 0 do begin
      zahl:=zahl div 2; s:=s+'2, ';
    end;
    z:=3;
   repeat
    while (zahl>1) and (zahl mod z =0) do begin
      zahl:=zahl div z;
      s:=s+inttostr(z)+', ';
    end;
      inc(z,2);
      while not isprime32(z) do inc(z,2);
   until (zahl=1);
   memo1.lines.add(s);
end;
function format(s:string):string; //Ausgabe formatieren
var s2:string;
    x,i:integer;
begin
   s2:='';
   x:=length(s) mod 3; //aller 3 Zeichen Leerzeichen
   if x=0 then x:=3;
   for i:=1 to x do s2:=s2+s[i];
   s2:=s2+' ';
   i:=x+1;
   repeat
     s2:=s2+s[i];
     inc(i);
     s2:=s2+s[i];
     inc(i);
     s2:=s2+s[i]+' ';
     inc(i);
   until i>length(s);
   format:=s2;
end;
begin {Hauptprogramm }
    xadd:=0; xbin:=0; xmul:=0; xkur:=0;
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Time1);    //Anfangszeit
    memo1.clear;
    start:=strtoint(edit2.text);
    if (start<2) or (start>5000) then start:=2;
    grenze:=strtoint(edit1.text);
    if (grenze<2) or (grenze>5000) then grenze:=5000;
    mp_init(fd);                      //Initialisieren
    mp_init(x);
    mp_init(nn);
    mp_init(zz);
    mp_init(f);
    mp_init2(g,koeff);
    mp_init(ff);                      //Faktor
    mp_set_int(ff,30);
    mp_mul_int(ff,7*11*13*17*23*29,ff);
    mp_mul_int(ff,31*37*41*43*47,ff);
    mp_mul_int(ff,53*59*61*67*71,ff);
    mp_mul_int(ff,73*79*83*89,ff);

    setlength(n,grenze+3);
    setlength(z,grenze+3);
    for i:=0 to grenze do begin mp_init(n[i]); mp_init(z[i]); end;
    mp_set_int(n[1],2);
    mp_copy(ff,z[1]);
    mp_chs(z[1],z[1]);
    //mp_set_int(z[1],-ff);  {Initialisierung der ersten Bernoulli-Zahl }
    k:=2; {Index der nächsten Zahl festlegen}
  repeat
      mp_set_int(nn,1);
      mp_copy(ff,zz);
      //mp_set_int(zz,ff);
      for i:=1 to k-1 do begin
       if (i=1) or (not odd(i)) then begin
        mp_binomial(k+1,i,koeff);  //Binomialkoeffizient
        inc(xbin);
        mp_mul(koeff,z[i],x);      //Brüche addieren
          mp_mul(x,nn,f);
          mp_mul(n[i],nn,nn);
          mp_mul(n[i],zz,g);
          inc(xmul,4);
          mp_add(f,g,zz);
          inc(xadd);
        mp_gcd(nn,zz,g);       //Kürzen
        mp_div(zz,g,zz);
        mp_div(nn,g,nn);
        inc(xkur);
       end;
      end;
        mp_chs(zz,z[k]);     //Teilung mit -(k+1)
        mp_mul_int(nn,k+1,n[k]);
        inc(xmul);
        mp_gcd(n[k],z[k],g);        //Kürzen
        mp_div(z[k],g,z[k]);
        mp_div(n[k],g,n[k]);
        inc(xkur);
        if (k>=start) then begin    //Ausgabe
        mp_mul(n[k],ff,x);
        mp_gcd(x,z[k],g);       //Kürzen
        mp_div(z[k],g,f);
        mp_div(x,g,x);
        memo1.lines.add('B('+inttostr(k)+') = ');
        memo1.lines.add('Zähler = ');
        memo1.lines.add(format(mp_adecimal(f)));
        memo1.lines.add('Nenner = ');
        memo1.lines.add(format(mp_adecimal(x)));
     {   zahl:=strtoint64(mp_adecimal(x));
        zerlegung(zahl);   }
        memo1.lines.add(' ');
        end;
        if k mod 20 = 0 then begin
          label3.caption:=inttostr(k);
          QueryPerformanceCounter(Time2);
          label4.caption:=floattostrf((Time2-Time1)/freq,ffgeneral,3,3)+' s';
          application.processmessages;
        end;
        k:=k+2;   {Zahlindex erhhen}
   until k>=grenze+1;   {Abbruch, andernfalls Bereichsüberschreitung}

    label3.caption:='';        //Variablen wieder freigeben
    for i:=1 to grenze do begin mp_clear(n[i]); mp_clear(z[i]); end;
    mp_clear(x);
    mp_clear(nn);
    mp_clear(zz);
    mp_clear(f);
    mp_clear(fd);
    mp_clear2(g,koeff);
    setlength(n,0);
    setlength(z,0);
    QueryPerformanceCounter(Time2);
    label4.caption:=floattostrf((Time2-Time1)/freq,ffgeneral,3,3)+' s';
    memo1.lines.add(inttostr(xadd)+' Additionen');
    memo1.lines.add(inttostr(xbin)+' Binomialkoeffizienten');
    memo1.lines.add(inttostr(xmul)+' Multiplikationen');
    memo1.lines.add(inttostr(xkur)+' Kürzungen');
    memo1.lines.add(floattostrf((Time2-Time1)/freq,ffgeneral,3,3)+' s');
    memo1.lines.add(' ');
end;

end.
