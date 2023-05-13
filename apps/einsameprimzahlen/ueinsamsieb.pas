unit ueinsamsieb;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ListBox2: TListBox;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    verzeichnis:string;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  abbruch:boolean;

implementation

{$R *.DFM}

//globale größen, da sonst stack overflow
const
    laenge=2000;
    siebgroesse=250000;
    panz=400000;
var sieb,sieb2,sieb3,sieb4:array[0..siebgroesse+1000] of boolean;
    startsieb :array of boolean;
    primz,rest :array[1..panz] of integer;

procedure TForm1.Button1Click(Sender: TObject);
var kk:string;
    d,i,s,diff,
    aktuellmin,total,grenze,irest,
    anzahl,links,rechts,
    z1,z2,z3:integer;
    z, a, Time1, Time2, Freq: Int64;
    gef: array[1..laenge] of boolean;

procedure startsieben;
var q,w:integer;
    i,j:int64;
begin
    for w:=0 to 10000000-1 do startsieb[w]:=false;
    fillchar(primz,sizeof(primz),0);
    i:=3;
    q:=1;
    repeat
      primz[q]:=i;
      inc(q);
      j:=i*i;
      while j<10000000 do
      begin
        startsieb[j]:=true;
        j:=j+i+i;
      end;
      inc(i,2);
      while startsieb[i] do i:=i+2;
    until q>panz;
    label1.caption:=format('max %.2f Bill.',[sqr(1.0*primz[panz])/1e12]);
end;
procedure anfangssieben;
var i,j,k,diff:integer;
begin
      i:=1;
      while startsieb[i] do inc(i,2);
      j:=i+2;
      while startsieb[j] do inc(j,2);
      k:=j+2;
      while startsieb[k] do inc(k,2);

      //kontrolle auf noch nicht gefundene abstände
      repeat
        diff:=k-i;
        if diff>=aktuellmin then begin
          if not gef[diff] then
          begin
            //maximum
            if diff>total then
            begin
              total:=diff;
              label6.caption:='max = '+inttostr(total);
              listbox1.items[(diff-4) div 2]:=
                 format('%5d',[diff])+#9+inttostr(j)+#9+'*['+inttostr(i)+';'+inttostr(k)+']';
            end
            else
              listbox1.items[(diff-4) div 2]:=
                 format('%5d',[diff])+#9+inttostr(j)+#9+'['+inttostr(i)+';'+inttostr(k)+']';
            gef[diff]:=true;
            //neues minimum
            if diff=aktuellmin then
            begin
              while gef[aktuellmin] do inc(aktuellmin,2);
              listbox1.itemindex:=(aktuellmin-4) div 2;
              label5.caption:='min = '+inttostr(aktuellmin);
            end;
          end;
        end;
        //indizess tauschen und neues k
        i:=j;
        j:=k;
        inc(k,2);
        while (k<=10000000) and startsieb[k] do inc(k,2);
      until (j>10000000);
end;
procedure vorarbeitlonely;
var i,j,k:integer;
begin
    i:=3;
    while startsieb[i] do inc(i,2);
    j:=i+2;
    while startsieb[j] do inc(j,2);
    k:=j+2;
    while startsieb[k] do inc(k,2);
    repeat
      if (j-i>links) and (k-j>rechts) then
      begin
        links:=j-i;
        rechts:=k-j;
        listbox2.items.add(format('%4d,%4d',[links,rechts])
           +#9+inttostr(j)+#9+'['+inttostr(i)+';'+inttostr(k)+']');
      end;
      i:=j;
      j:=k;
      k:=k+2;
      while (k<=10000000) and startsieb[k] do inc(k,2);
    until j>10000000;
end;
begin
    if abbruch=false then
    begin
      abbruch:=true;
      exit
    end;
    button1.caption:='Abbruch';
    abbruch:=false;

    aktuellmin:=4;
    total:=3;
    anzahl:=0;
    links:=0;
    rechts:=0;
    fillchar(gef,sizeof(gef),false);

    setlength(startsieb,10000000);
    startsieben;
    //neustart
    if not checkbox1.checked then
    begin
      listbox1.clear;
      listbox2.clear;
      for i:=2 to laenge div 2 do listbox1.items.add(format('%5d',[2*i])+#9+'-');
      anfangssieben;
      vorarbeitlonely;
      z:=10000000;
    end
    else
    //weiterrechnen
    begin
      listbox2.clear;
      listbox2.items.loadfromfile(verzeichnis+'lonely.txt');
      kk:=listbox2.items.strings[listbox2.items.count-1];
      listbox2.items.delete(listbox2.items.count-1);
      kk:=listbox2.items[listbox2.items.count-1];
      delete(kk,pos(#9,kk),200);
      listbox2.itemindex:=listbox2.items.count-1;
      links:=strtoint(copy(kk,1,pos(',',kk)-1));
      rechts:=strtoint(copy(kk,pos(',',kk)+1,10));
      application.processmessages;

      listbox1.clear;
      listbox1.items.loadfromfile(verzeichnis+'einsam.txt');
      kk:=listbox1.items.strings[listbox1.items.count-1];
      application.processmessages;
      z:=strtoint64(kk);
      listbox1.items.delete(listbox1.items.count-1);
      for i:=0 to listbox1.items.count-1 do
        gef[4+2*i]:=not (copy(listbox1.items[i],7,10)='-');
      for i:=2 to laenge div 2 do
        if gef[2*i] then total:=2*i;
      while gef[aktuellmin] do inc(aktuellmin,2);
    end;
    setlength(startsieb,0);

    label5.caption:='min = '+inttostr(aktuellmin);
    listbox1.itemindex:=(aktuellmin-4) div 2;
    label6.caption:='max = '+inttostr(total);
    label9.caption:='lonely = '+inttostr(links+rechts);
    application.processmessages;

    fillchar(sieb2,sizeof(sieb2),false);
    fillchar(sieb3,sizeof(sieb3),false);
    fillchar(sieb4,sizeof(sieb4),false);
    i:=0;
    repeat
      case i mod 3 of
        0 : sieb2[i]:=true;
        1 : sieb3[i]:=true;
        2 : sieb4[i]:=true;
      end;
      if i mod 5 = 0 then
      begin
        sieb2[i]:=true;
        sieb3[i]:=true;
        sieb4[i]:=true;
      end;
      inc(i);
    until i>siebgroesse;

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Time1);

    //erster durchlauf mit neuen z1,z2,z3
      //maximale siebzahl ermitteln
      grenze:=trunc(sqrt(1.0*(z+siebgroesse))+1);
      //abbruch bei überschreitung des feldes
      if grenze>primz[panz] then
      begin
        showmessage('Ende erreicht');
        button1.caption:='Suche';
        abbruch:=true;
        exit;
      end;

      //sieb löschen
      fillchar(sieb,sizeof(sieb),false);
      //siebvorgang
      i:=1;
      repeat
        d:=z mod primz[i];
        s:=-d+primz[i];
        if not odd(s) then s:=s+primz[i];
        while s<=siebgroesse do
        begin
          sieb[s]:=true;
          inc(s,2*primz[i]);
        end;
        rest[i]:=s-siebgroesse;
        inc(i);
      until primz[i]>grenze;
      irest:=i;

      //im sieb 3 primzahlen suchen
      z1:=1;
      while sieb[z1] do inc(z1,2);
      z2:=z1+2;
      while sieb[z2] do inc(z2,2);
      z3:=z2+2;
      while sieb[z3] do inc(z3,2);

    //=============================================================
    //hauptschleife
    //suche nach einsamen primzahlen
    repeat
      //kontrolle auf noch nicht gefundene abstände
      repeat
        diff:=z3-z1;
        if diff>=aktuellmin then
        begin
          if not gef[diff] then
          begin
            //maximum
            if diff>total then
            begin
              total:=diff;
              label6.caption:='max = '+inttostr(total);
              listbox1.items[(diff-4) div 2]:=
                 format('%5d',[diff])+#9+inttostr(z+z2)+#9+'*['+inttostr(z+z1)+';'+inttostr(z+z3)+']';
            end
            else
              listbox1.items[(diff-4) div 2]:=
                 format('%5d',[diff])+#9+inttostr(z+z2)+#9+'['+inttostr(z+z1)+';'+inttostr(z+z3)+']';
            gef[diff]:=true;
            //neues minimum
            if diff=aktuellmin then
            begin
              while gef[aktuellmin] do inc(aktuellmin,2);
              listbox1.itemindex:=(aktuellmin-4) div 2;
              label5.caption:='min = '+inttostr(aktuellmin);
            end;
          end;
        end;
        if (z2-z1>links) and (z3-z2>rechts) then
        begin
          links:=z2-z1;
          rechts:=z3-z2;
          listbox2.items.add(format('%4d,%4d',[links,rechts])+#9+inttostr(z+z2)+#9
             +'['+inttostr(z+z1)+';'+inttostr(z+z3)+']');
          listbox2.itemindex:=listbox2.items.count-1;
          label9.caption:='lonely = '+inttostr(links+rechts);
        end;

        //indizess tauschen und neues k
        z1:=z2;
        z2:=z3;
        inc(z3,2);
        while sieb[z3] do inc(z3,2);
      until (z3>siebgroesse);

      //anzeige
      inc(anzahl);
      if anzahl=160 then begin
        label7.caption:=inttostr(primz[irest]);
        label2.caption:=inttostr(z);
        application.title:=inttostr(z);
        QueryPerformanceCounter(Time2);
        label4.caption:=inttostr(round((Time2-Time1)/freq))+' s';
        application.processmessages;
        anzahl:=0;
      end;

      //z1,z2 zurücksetzen
      z1:=z1-siebgroesse;
      z2:=z2-siebgroesse;
      //nächster Bereich von 5 Millionen Zahlen
      z:=z+siebgroesse;

      //maximale siebzahl ermitteln
      a:=z+siebgroesse;
      grenze:=trunc(sqrt(1.0*a)+1);
      //abbruch bei überschreitung des feldes
      if grenze>primz[panz] then
      begin
        showmessage('Ende erreicht');
        listbox1.items.add(inttostr(z));
        if checkbox1.checked then listbox1.items.savetofile(verzeichnis+'einsam.txt');
        listbox2.items.add(inttostr(z));
        if checkbox1.checked then listbox2.items.savetofile(verzeichnis+'lonely.txt');
        button1.caption:='Suche';
        abbruch:=true;
        exit;
      end;
      //fehlende reste berechnen
      i:=irest-1;
      repeat
        d:=z mod primz[i];
        s:=-d+primz[i];
        if not odd(s) then s:=s+primz[i];
        rest[i]:=s;
        inc(i);
      until primz[i]>grenze;
      irest:=i;

//      fillchar(sieb,sizeof(sieb),false);
      //sieb löschen
      case z mod 3 of
        0 : sieb:=sieb2;
        1 : sieb:=sieb4;
        2 : sieb:=sieb3;
      end;
      //siebvorgang
      i:=3;
      repeat
        s:=rest[i];
        while s<siebgroesse do
        begin
          sieb[s]:=true;
          inc(s,2*primz[i]);
        end;
        rest[i]:=s-siebgroesse;
        inc(i);
      until primz[i]>grenze;

      //im sieb z3 suchen
      z3:=1;
      while sieb[z3] do inc(z3,2);
    until abbruch;

    listbox1.items.add(inttostr(z));
    if checkbox1.checked then listbox1.items.savetofile(verzeichnis+'einsam.txt');
    listbox2.items.add(inttostr(z));
    if checkbox1.checked then listbox2.items.savetofile(verzeichnis+'lonely.txt');
    button1.caption:='Suche';
    abbruch:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
procedure backslash(var k:string);
begin
    if k[length(k)]<>'\' then k:=k+'\';
end;
begin
    verzeichnis:=extractfilepath(application.exename);
    backslash(verzeichnis);
    abbruch:=true;
end;

end.
