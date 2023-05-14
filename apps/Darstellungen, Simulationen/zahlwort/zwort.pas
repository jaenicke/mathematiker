unit zwort;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses sysutils;

Function FZahlwort(zahl : Integer) : String;
Function EZahlwort(zahl : Integer) : String;
Function IZahlwort(zahl : Integer) : String;
Function SZahlwort(zahl : Integer) : String;
Function DZahlwort(zahl : Integer) : String;
Function RZahlwort(zahl : Integer) : String;
Function XZahlwort(zahl : Integer) : String;
Function NZahlwort(Zahl : Integer) : String;
Function DaZahlwort(Zahl : Integer) : String;
Function SoZahlwort(zahl : Integer) : String;
Function UZahlwort(zahl : Integer) : String;
Function PoZahlwort(zahl : Integer) : String;
Function GrZahlwort(zahl : Integer) : String;
Function TuZahlwort(zahl : Integer) : String;
Function JZahlwort(zahl : Integer) : String;
Function SwZahlwort(zahl : Integer) : String;
Function CsZahlwort(zahl : Integer) : String;
Function lateinZahlwort(zahl : Integer) : String;
Function plattZahlwort(zahl : Integer) : String;
Function JapanZahlwort(zahl : Integer) : String;
Function Klingonzahlwort(zahl : Integer) : String;
Function unizahlwort(zahl : Integer) : String;
Function Zwanzigeins(zahl : Integer) : String;

implementation

Function Zwanzigeins(zahl : Integer) : String;
Const
  NamenA : Array [1..9]Of String[12] = (
    'eins', 'zwei', 'drei', 'vier', 'fünf', 'sechs', 'sieben', 'acht', 'neun'
    );
  NamenC : Array [1..9]Of String[12]= (
    'zehn', 'zwanzig', 'dreißig', 'vierzig', 'fünfzig', 'sechzig', 'siebzig', 'achtzig', 'neunzig'
    );
Function DoTriplet (zahl : Integer) : String;
Var
  Digit, Num : Integer;
Begin
    Result:='';
    Num:=zahl Mod 100;
    If (Num>10)And (Num<20)Then
    Begin
      Result:='zehn'+NamenA[Num-10];
      Num:=zahl Div 100;
    End
    Else
    Begin
      Num:=zahl;
      Digit:=Num Mod 10;
      Num:=Num Div 10;
      If Digit>0 Then Result:=NamenA [Digit];
      Digit:=Num Mod 10;
      Num:=Num Div 10;
      If Digit>0 Then Result:=NamenC [Digit]+Result;
      Result:=Trim(Result);
    End;
    Digit:=Num Mod 10;
//    If (Result<>'')And (Digit>0) Then Result:='and '+Result;
    If Digit>0 Then Result:=NamenA [Digit]+'hundert'+Result;
    Result:=Trim (Result);
End;
Var
  Num, Triplet, Pass : Integer;
Begin
    Result:='';
    Num:=zahl;
    For Pass:=1 To 3 Do
    Begin
      Triplet:=Num Mod 1000;
      Num:=Num Div 1000;
      If Triplet>0 Then
      Begin
//        If (Pass>1)And (Result<>'')Then Result:=' '+Result;
        Case Pass Of
          2 : Result:='tausend '+Result;
          3 : Result:='million '+Result;
        End;
        Result:=Trim (DoTriplet (Triplet)+Result);
      End;
    End;
End;

Function unizahlwort(zahl : Integer) : String;
var k,s:string;
    i:integer;
Const
  NamenA : Array [0..9]Of String[3]= (
     'ze', 'un', 'to', 'ti', 'ka', 'si', 'sa', 'et', 'po', 'ni');
Begin
    k:=inttostr(zahl);
    for i:=1 to length(k) do
      s:=s+namena[ord(k[i])-48];
    Result:=s;
End;

Function Klingonzahlwort(zahl : Integer) : String;
var s:string;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..10]Of String[12]= (
     'wa''', 'cha''', 'wej', 'loS', 'vagh', 'jav', 'Soch', 'chorgh', 'Hut',
     'wa''maH');
  zehner ='maH';
  hundert ='vatlh';
  tausend ='SaD';
  zehntausend ='netlh';
  hunderttausend ='bIp';
  million='''uy''';
Begin
    If i=0 Then Result:=''
    Else
      If i<11 Then Result:=NamenA [i]
      Else
        If i<100 Then Result:=NamenA[i div 10]+zehner+' '+NamenA[i mod 10]
        Else
          If i<1000 Then
             Result:=NamenA[i Div 100]+hundert+' '+umwandeln(i mod 100)
          Else
             If i<10000 Then Result:=NamenA[i div 1000]+tausend+' '+umwandeln(i mod 1000)
             Else
               If i<100000 Then Result:=NamenA[i div 10000]+zehntausend+' '+umwandeln(i mod 10000)
               Else
                 If i<1000000 Then Result:=NamenA[i div 100000]+hunderttausend+' '+umwandeln(i mod 100000)
               Else
                 result:=umwandeln(i div 1000000)+million+' '+umwandeln(i mod 1000000)
End;
Begin
    If zahl=0 Then Result:='pagh'
    Else
      If zahl=1 Then Result:='wa'''
      Else
      begin
        s:=Umwandeln (zahl);
        Result:=s;
      end;
End;

Function JapanZahlwort(zahl : Integer) : String;
var s:string;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..10] Of String[12]= (
     'ichi', 'ni', 'san', 'yon', 'go', 'roku', 'nana', 'hachi', 'kyu', 'ju');
  hundert ='hyaku';
  tausend ='sen';
Begin
    If i=0 Then Result:=''
    Else
      If i<11 Then Result:=NamenA [i]
      Else
        If i<20 Then Result:='ju '+NamenA[i mod 10]
        Else
          If i<100 Then Result:=NamenA[i div 10]+'-ju '+NamenA[i mod 10]
          Else
            If i<1000 Then begin
              case i div 100 of
                1 : Result:=hundert+' '+Umwandeln(i mod 100);
                2,4,5,7,9 : Result:=NamenA[i div 100]+'-'+hundert+' '+Umwandeln(i mod 100);
                3 : Result:=NamenA[i div 100]+'-byaku '+Umwandeln(i mod 100);
                6,8 : Result:=NamenA[i div 100]+'-pyaku '+Umwandeln(i mod 100);
              end;
            end
            else
              If i<10000 Then begin
                case i div 1000 of
                  1 : Result:=tausend+' '+Umwandeln(i mod 1000);
                  2,4,5,6,7,9 : Result:=NamenA[i div 1000]+'-'+tausend+' '+Umwandeln(i mod 1000);
                  3 : Result:=NamenA[i div 1000]+'-zen '+Umwandeln(i mod 1000);
                  8 : Result:='has-sen '+Umwandeln(i mod 1000);
                end;
              end
              else
                If i<100000 Then
                  result:=Umwandeln(i div 10000)+'-man '+Umwandeln(i mod 10000)
                else
                  If i<1000000 Then
                    result:=Umwandeln(10*(i div 100000))+'-man '+Umwandeln(i mod 100000)
                  else
                    If i<10000000 Then
                      result:=Umwandeln(100*(i div 1000000))+'-man '+Umwandeln(i mod 1000000)
                    else
                      If i<100000000 Then
                      result:=Umwandeln(1000*(i div 10000000))+'-man '+Umwandeln(i mod 10000000)
                      else
                      result:=Umwandeln(i div 100000000)+'-oku '+Umwandeln(i mod 100000000)
End;
Begin
    If zahl=0 Then Result:='rei'
    Else
      If zahl=1 Then Result:='ichi'
      Else
      begin
        s:=Umwandeln (zahl);
        while pos(' -',s)>0 do delete(s,pos(' -',s),1);
        Result:=s;
      end;
End;

Function PlattZahlwort(zahl : Integer) : String;
var s:string;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..17]Of String[12]= (
     'een', 'twee', 'dree', 'veer', 'fief', 'söss', 'söben', 'acht', 'negen',
     'teihn', 'ölben', 'twölf', 'dörteihn', 'veerteihn', 'föffteihn', 'sössteihn', 'söbenteihn'
    );
  NamenB : Array [1..9]Of String[12]= (
     'teihn', 'twintig', 'dörtig', 'veertig', 'föfftig', 'sösstig', 'söbentig',
     'achtig', 'negentig'
    );
  hundert ='hunnert';
  tausend ='dusend';
  und='un';
  million='milljeon';
Var
  j : Integer;
Begin
    If i=0 Then Result:=''
    Else
      If i<18 Then Result:=NamenA [i]
      Else
        If i<20 Then Result:=NamenA [i Mod 10]+NamenB [1]
        Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenA [i Mod 10]+und+NamenB [i Div 10];
          End
          Else
            If i<1000 Then Result:=Umwandeln (i Div 100)+hundert+Umwandeln (i Mod 100)
            Else
              If i<1000000 Then Result:=Umwandeln (i Div 1000)+tausend+Umwandeln (i Mod 1000)
              Else
              Begin
                j:=i Div 1000000;
                If j=1 Then Result:='een'
                       Else Result:=Umwandeln (j);
                Result:=Result+million;
                If j>1 Then Result:=Result;
                Result:=Result+Umwandeln(i Mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='null'
    Else
      If zahl=1 Then Result:='een'
      Else
      begin
        s:=Umwandeln (zahl);
//        if copy(s,length(s)-2,3)='een' then s:=s+'s';
        Result:=s;
      end;
End;

Function lateinZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..19]Of String[19]= (
     'unus', 'duo', 'tres', 'quattuor', 'quinque', 'sex', 'septem', 'octo', 'novem', 'decem',
     'undecim', 'duodecim', 'tredecim', 'quattuordecim', 'quindecim', 'sedecim', 'septendecim',
     'duodeviginti', 'undeviginti'
    );
  NamenB : Array [1..9]Of String[14]= (
     'decem', 'viginti', 'triginta', 'quadraginta', 'quinquaginta', 'sexaginta', 'septuaginta',
     'octoginta', 'nonaginta'
    );
  NamenC : Array [1..9]Of String[14]= (
     'centum', 'ducenti', 'trecenti', 'quadringenti', 'quingenti', 'sescenti', 'septingenti',
     'octingenti', 'nongenti'
    );
  tausend='mille';
Begin
    If i=0 Then Result:=''
    Else
      If i<20 Then Result:=NamenA[i]
      Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenB [i Div 10]+' '+Umwandeln(i mod 10);
          End
          Else
            If i<1000 Then
            Begin
              If (i Mod 100)=0 Then Result:=NamenC [i Div 100]
                               Else Result:=NamenC [i Div 100]+' '+Umwandeln(i mod 100);
            End
            Else
              If i<1000000 Then
              begin
                if i<2000 then result:=tausend+' '+Umwandeln(i mod 1000)
                else
                  result:=Umwandeln(i div 1000)+' millia '+Umwandeln(i mod 1000)
              end
              Else
              Begin
                if i<2000000 then result:=tausend+' millia '+Umwandeln(i mod 1000000)
                else
                  result:=Umwandeln(i div 1000000)+' millia millia '+Umwandeln(i mod 1000000)
              End;
End;
Begin
    If zahl=0 Then Result:='zero'
    Else
      If zahl=1 Then Result:='unus'
      Else
        Result:=Umwandeln (zahl);
End;

Function CsZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..19]Of String[19]= (
     'jeden', 'dva', 't¿i', '¬ty¿i', 'pët', '­est', 'sedm', 'osm', 'devët', 'deset',
     'jedenáct', 'dvanáct', 't¿ináct', '¬ty¿náct', 'patnáct', '­estnáct', 'sedmnáct',
     'osmnáct', 'devatenáct'
    );
  NamenB : Array [1..9]Of String[14]= (
     'deset', 'dvacet', 't¿icet', '¬ty¿icet', 'padesát', '­edesát', 'sedmdesát',
     'osmdesát', 'decadesát'
    );
  hundert ='sto';
  tausend='tisíc';
Begin
    If i=0 Then Result:=''
    Else
      If i<20 Then Result:=NamenA [i]
      Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenB [i Div 10]+Umwandeln(i mod 10);
          End
          Else
            If i<1000 Then
            Begin
              if i<200 then result:=hundert+' '+Umwandeln(i mod 100)
              else
                if i<300 then result:='dvë stë '+Umwandeln(i mod 100)
                else
                  if i<500 then result:=Umwandeln(i div 100)+' sta '+Umwandeln(i mod 100)
                  else result:=Umwandeln(i div 100)+' set '+Umwandeln(i mod 100);
            End
            Else
              If i<1000000 Then
              begin
                if i<2000 then result:=tausend+' '+Umwandeln(i mod 1000)
                else
                  if i<5000 then result:=Umwandeln(i div 1000)+' tisíce '+Umwandeln(i mod 1000)
                            else result:=Umwandeln(i div 1000)+' '+tausend+' '+Umwandeln(i mod 1000);
              end
              Else
              Begin
                if i<2000000 then result:='milion '+Umwandeln(i mod 1000000)
                else
                  if i<5000000 then result:=Umwandeln(i div 1000000)+' miliony '+Umwandeln(i mod 1000000)
                            else result:=Umwandeln(i div 1000000)+' milionû '+Umwandeln(i mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='noll'
    Else
      If zahl=1 Then Result:='ett'
      Else
        Result:=Umwandeln (zahl);
End;

Function SwZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..19]Of String[19]= (
     'ett', 'två', 'tre', 'fyra', 'fem', 'sex', 'sju', 'åtta', 'nio', 'tio',
     'elva', 'tolv', 'tretton', 'fjorton', 'femton', 'sexton', 'sjutton',
     'arton', 'nitton'
    );
  NamenB : Array [1..9]Of String[14]= (
     'tio', 'tjugo', 'trettio', 'fyrtio', 'femtio', 'sextio', 'sjuttio', 'åttio', 'nittio'
    );
  hundert : String='hundra';
  tausend=' tusen ';
Begin
    If i=0 Then Result:=''
    Else
      If i<20 Then Result:=NamenA [i]
      Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenB [i Div 10]+Umwandeln(i mod 10);
          End
          Else
            If i<1000 Then
            Begin
              Result:=Umwandeln(i div 100)+hundert+Umwandeln(i mod 100);
            End
            Else
              If i<1000000 Then
              begin
                Result:=Umwandeln(i div 1000)+tausend+Umwandeln(i mod 1000);
              end
              Else
              Begin
                Result:=Umwandeln(i div 1000000)+' miljon '+Umwandeln(i mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='noll'
    Else
      If zahl=1 Then Result:='ett'
      Else
        Result:=Umwandeln (zahl);
End;

Function JZahlwort(zahl : Integer) : String;
function umwandeln(z:integer):string;
var i:integer;
    w:string;
begin
        w:='';
        if z>0 then
        begin
          if z>10000 then begin
            w:=w+umwandeln(z div 10000)+chr(109);
            z:=z mod 10000;
          end;  
          i:=z div 10000;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(109);
          end;
          z:=z mod 10000;
          i:=z div 1000;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(108);
          end;
          z:=z mod 1000;
          i:=z div 100;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(107);
          end;
          z:=z mod 100;
          i:=z div 10;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(106);
          end;
          i:=z mod 10;
          if i>0 then w:=w+chr(96+i);
          result:=w;
       end;
end;
begin
    Result:=Umwandeln(zahl);
end;

Function TuZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..19]Of String[19]= (
     'bir', 'iki', 'ü¦', 'dört', 'be¥', 'alt°', 'yedi', 'sekiz', 'dokuz', 'on',
     'on bir', 'on iki', 'on ü¦', 'on dört', 'on be¥', 'on alt°', 'on yedi',
     'on sekiz', 'on dokuz'
    );
  NamenB : Array [1..9]Of String[14]= (
     'on', 'yirmi', 'otuz', 'k°rk', 'elli', 'altm°¥', 'yetm°¥', 'seksen', 'doksan'
    );
  hundert : String=' yüz ';
  tausend=' bin ';
Begin
    If i=0 Then Result:=''
    Else
      If i<20 Then Result:=NamenA [i]
      Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenB [i Div 10]+' '+Umwandeln(i mod 10);
          End
          Else
            If i<1000 Then
            Begin
              Result:=Umwandeln(i div 100)+hundert+Umwandeln(i mod 100);
            End
            Else
              If i<1000000 Then
              begin
                Result:=Umwandeln(i div 1000)+tausend+Umwandeln(i mod 1000);
              end
              Else
              Begin
                Result:=Umwandeln(i div 1000000)+' milyon '+Umwandeln(i mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='s°f°r'
    Else
      If zahl=1 Then Result:='bir'
      Else
        Result:=Umwandeln (zahl);
End;

Function GrZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..12]Of String[12]= (
     'enaV', 'duo', 'treiV', 'tessereiV', 'pente', 'exi', 'efta', 'octw',
     'ennia', 'deka', 'endeka', 'dwdeka'
    );
  NamenB : Array [1..9]Of String[14]= (
     'deka', 'eikosi', 'triavta', 'saranta', 'penhnta', 'exhnta',
     'ebdomhnta', 'ogdonta', 'enenhnta'
    );
  NamenC : Array [1..9]Of String[14]= (
     'ekaton', 'diakosoi', 'triekosoi', 'tesserakosoi', 'pentekosoi', 'exikosoi',
     'eftakosoi', 'oxtwkosoi', 'enniakosoi'
    );
  hundert : String='kosoi';
  tausend=' ciliadeV ';
Var
  j : Integer;
Begin
    If i=0 Then Result:=''
    Else
      If i<13 Then Result:=NamenA [i]
      Else
        If i<20 Then Result:='deka'+NamenA [i Mod 10]
        Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenB [i Div 10]+' '+Umwandeln(i mod 10);
          End
          Else
            If i<1000 Then
            Begin
              If (i Mod 100)=0 Then Result:=NamenC [i Div 100]
                               Else Result:=NamenC [i Div 100]+' '+Umwandeln(i mod 100);
            End
            Else
              If i<1000000 Then
              begin
                if i div 1000=1 then Result:='cilio '+Umwandeln(i Mod 1000)
                else
                  Result:=Umwandeln (i Div 1000)+tausend+Umwandeln(i Mod 1000)
              end
              Else
              Begin
                j:=i Div 1000000;
                case j of
                 1 : Result:='ekatommurio ';
                Else Result:=Umwandeln(j)+' ekatommuria ';
                end;
                Result:=Result+Umwandeln(i Mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='mhden'
    Else
      If zahl=1 Then Result:='enaV'
      Else
        Result:=Umwandeln (zahl);
End;

Function PoZahlwort(zahl : Integer) : String;
Const
  NamenA : Array [0..19]Of String[14]= (
     '', 'jeden', 'dwa', 'trzy', 'cztery', 'piæç', 'szeîç', 'siedem', 'osiem', 'dziewiæç',
     'dziesiæç', 'jedenaîcie', 'dwanaîcie',
     'trzynaîcie', 'czternaîcie', 'piætnaîcie', 'szesnaîcie', 'siedemnaîcie',
     'osiemnaîcie', 'dziewiætnaîcie'
    );
  NamenB : Array [1..9]Of String[16]= (
     'dziesiæç', 'dwadzieîcia', 'trzydzieîci', 'czterdzieîci', 'piæçdziesiãt', 'szeîçdziesiãt',
     'siedemdziesiãt', 'osiemdziesiãt', 'dziewiæçdziesiãt'
    );
  NamenC : Array [1..9]Of String[14]= (
     'sto', 'dwieîcie', 'trzysta', 'czterysta', 'piæçset', 'szeîçset',
     'siedemset', 'osiemset', 'dziewiæçset'
    );
  hundert : String='sto';
  tausend=' tysiãc ';
  und='a';
function tausender(x:integer):string;
var ss:string;
begin
    ss:='';
    if x div 100<>0 then ss:=ss+NamenC[x div 100]+' ';
    x:=x mod 100;
    if x<>0 then
    begin
      if x div 10>1 then
      begin
        ss:=ss+NamenB[x div 10]+' ';
        if x mod 10>0 then ss:=ss+NamenA[x mod 10]+' ';
      end
      else
      begin
        if x>0 then ss:=ss+NamenA[x]+' ';
      end;
    end;
    tausender:=ss;
end;
Var
  k,ke : String; w : Integer;
Begin
    k:='';
    w:=zahl mod 1000;
    if w>0 then ke:=tausender(w);
    k:=k+ke;
    zahl:=zahl div 1000;
    w:=zahl mod 1000;
    if w>0 then
    begin
      ke:=tausender(w);
      if w=1 then
        k:=ke+'tysiãc '+k
      else
         if w in [2,3,4] then k:=ke+'tysiãce '+k
                         else k:=ke+'tysiæcy '+k;
    end;
    zahl:=zahl div 1000;
    w:=zahl mod 1000;
    if w>0 then
    begin
      ke:=tausender(w);
      if (w=1) then k:=ke+'milion '+k
      else
        if (w in [2,3,4]) then k:=ke+'miliona '+k
                         else k:=ke+'miliony '+k;
    end;
    if k='' then k:='zero';
    result:=k;
End;

Function SoZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..17]Of String[12]= (
     'jedyn', 'dwaj', 't¿i', '­tyri', 'pjeç', '­ësç', 'sydom', 'wosom', 'dïewjeç',
     'dïesaç', 'jëdnaçe', 'dwanaçe',
     't¿inaçe', '­tyrnaçe', 'pjatnaçe', '­ësnaçe', 'sydomnaçe'
    );
  NamenB : Array [1..9]Of String[14]= (
     'dïesaç', 'dwaceçi', 't¿iceçi', '­tyrceçi', 'pjeçdïesat', '­ësçdïesat',
     'sydomdïesat', 'wosomdïesat', 'dïewjeçdïesat'
    );
  NamenC : Array [1..9]Of String[14]= (
     'sto', 'dwësçë', 't¿ista', '­tyrista', 'pjeçstow', '­ësçstow',
     'sydomstow', 'wosomstow', 'dïewjeçstow'
    );
  hundert : String='sto';
  tausend=' tysac ';
  und='a';
Var
  j : Integer;
Begin
    If i=0 Then Result:=''
    Else
      If i<17 Then Result:=NamenA [i]
      Else
        If i<20 Then Result:=NamenA [i Mod 10]+NamenB [1]
        Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenA [i Mod 10]+und+NamenB [i Div 10];
          End
          Else
            If i<1000 Then
            Begin
              If (i Mod 100)=0 Then Result:=NamenC [i Div 100]+' '
                               Else Result:=NamenC [i Div 100]+' '+und+' '+Umwandeln(i mod 100)+' ';
            End
            Else
              If i<1000000 Then Result:=Umwandeln (i Div 1000)+tausend+Umwandeln (i Mod 1000)
              Else
              Begin
                j:=i Div 1000000;
                If j=1 Then Result:='jedyn'
                       Else Result:=Umwandeln (j);
                case j of
                  1 : Result:=Result+' million ';
                2..4 : Result:=Result+' milliona ';
                else Result:=Result+' millionow ';
                end;
                Result:=Result+Umwandeln(i Mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='nul'
    Else
      If zahl=1 Then Result:='jedyn'
      Else
        Result:=Umwandeln (zahl);
End;

Function UZahlwort(zahl : Integer) : String;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..13]Of String[12]= (
     'egy', 'kett[', 'három', 'négy', 'öt', 'hat', 'hét', 'nyolc',
     'kilenc', 'tíz', 'tizenegy', 'tizenkettö', 'tizenhárom'
    );
  NamenB : Array [1..9]Of String[14]= (
     'tíz', 'húsz', 'harminc', 'negyven', 'ötven', 'hatvan',
     'hetven', 'nyolcvan', 'kilencven'
    );
  NamenC : Array [1..9]Of String[14]= (
     'egyszáz', 'kétszáz', 'háromszáz', 'négyszáz', 'ötszáz', 'hatszáz',
     'hétszáz', 'nyolcszáz', 'kilencszáz'
    );
  hundert : String='száz';
  tausend='ezer';
Var
  j : Integer;
Begin
    If i=0 Then Result:=''
    Else
      If i<11 Then Result:=NamenA [i]
      Else
        If i<20 Then Result:='tizen'+NamenA [i Mod 10]
        else

         If (i<>20) and (i<30) Then Result:='huszon'+NamenA [i Mod 10]
        Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenB [i Div 10]+Umwandeln(i mod 10);
          End
          Else
            If i<1000 Then
            Begin
              If (i Mod 100)=0 Then Result:=NamenC [i Div 100]
                               Else Result:=NamenC [i Div 100]+Umwandeln(i mod 100);
            End
            Else
              If i<1000000 Then
              begin
                if i div 1000=2 then
                  Result:='két'+tausend+Umwandeln(i Mod 1000)
                else
                  Result:=Umwandeln (i Div 1000)+tausend+Umwandeln(i Mod 1000)
              end
              Else
              Begin
                j:=i Div 1000000;
                case j of
                 1 : Result:='';
                 2 : Result:='két'
                Else Result:=Umwandeln (j);
                end;
                Result:=Result+'millió';
                Result:=Result+Umwandeln(i Mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='nulla'
    Else
      If zahl=1 Then Result:='egy'
      Else
        Result:=Umwandeln (zahl);
End;

Function DaZahlwort(Zahl : Integer) : String;
Function Umwandeln(i : Integer) : String;
Const
  NamenA :
    array [1..19] of string[12]=
    ('en', 'to', 'tre', 'fire', 'fem', 'seks', 'syv', 'otte', 'ni',
     'ti', 'elleve', 'tolv', 'tretten', 'fjorten', 'femten', 'seksten',
     'sytten', 'atten', 'nitten'
     );
  NamenB :
    array [1..9] of string[12]=
    ('ti', 'tyve', 'tredive', 'fyrre', 'halvtreds', 'tres',
     'halvfjerds', 'firs', 'halvfems');
  hundert = 'hundred';
  hundert2 = 'hundrede';
  tausend = 'tusind';
  million = 'million';
Var
  j : Integer;
  k:string;
Begin
    If i=0 Then Result:=''
    Else
      If i<20 Then Result:=NamenA[i]
      Else
        If i<100 Then
        Begin
          If (i Mod 10)=0 Then Result:=NamenB[i Div 10]
          Else
          begin
            if NamenA[i Mod 10][length(NamenA [i Mod 10])]='e' then
              Result:=NamenA[i Mod 10]+'og'+NamenB[i Div 10]
            else
              Result:=NamenA[i Mod 10]+'og'+NamenB[i Div 10];
          end;
        End
        Else
          If i<1000 Then
          begin
            if i div 100 = 1 then
              Result:=Umwandeln (i Div 100)+hundert+' '+Umwandeln (i Mod 100)
            else
              Result:=Umwandeln (i Div 100)+hundert2+' '+Umwandeln (i Mod 100)
          end
          Else
            If i<1000000 Then
            begin
              k:=Umwandeln (i Div 1000);
              if k[length(k)]=' ' then delete(k,length(k),1);
              Result:=k+tausend+' '+Umwandeln (i Mod 1000)
            end
            Else
            Begin
              j:=i Div 1000000;
              If j=1 Then Result:='en'
                     Else Result:=Umwandeln(j);
              Result:=Result+million;
              Result:=Result+Umwandeln(i Mod 1000000);
            End;
End;
Begin
    If Zahl=0 Then Result:='nul'
              Else Result:=Umwandeln (Zahl);
End;

Function NZahlwort(Zahl : Integer) : String;
Function Umwandeln(i : Integer) : String;
Const
  NamenA :
    array [1..14] of string[12]=
    ('een', 'twee', 'drie', 'vier', 'vijf', 'zes', 'zeven', 'acht', 'negen',
     'tien', 'elf', 'twaalf', 'dertien', 'veertien');
  NamenB :
    array [1..9] of string[12]=
    ('tien', 'twintig', 'dertig', 'veertig', 'vijftig', 'zestig',
     'zeventig', 'tachtig', 'negentig');
  hundert = 'honderd';
  tausend = 'duizend';
  million = ' miljoen ';
Var
  j : Integer;
  k:string;
Begin
    If i=0 Then Result:=''
    Else
      If i<15 Then Result:=NamenA[i]
      Else
        If i<20 then Result:=NamenA[i Mod 10]+NamenB[1]
        Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB[i Div 10]
            Else
            begin
              if NamenA[i Mod 10][length(NamenA [i Mod 10])]='e'
              then
                Result:=NamenA[i Mod 10]+'ën'+NamenB[i Div 10]
              else
                Result:=NamenA[i Mod 10]+'en'+NamenB[i Div 10];
            end;
          End
          Else
            If i<1000 Then
              Result:=Umwandeln (i Div 100)+hundert+' '+Umwandeln (i Mod 100)
            Else
              If i<1000000 Then
              begin
                k:=Umwandeln (i Div 1000);
                if k[length(k)]=' ' then delete(k,length(k),1);
                Result:=k+tausend+' '+Umwandeln (i Mod 1000)
              end
              Else
              Begin
                j:=i Div 1000000;
                If j=1 Then Result:='een'
                       Else Result:=Umwandeln(j);
                Result:=Result+million;
                Result:=Result+Umwandeln(i Mod 1000000);
              End;
End;
Begin
    If Zahl=0 Then Result:='nul'
              Else Result:=Umwandeln (Zahl);
End;

Function XZahlwort(zahl : Integer) : String;
const
    espera : array[1..14] of string[8]
       = ('unu','du','tri','kvar','kvin','ses','sep','ok','naû',
	  'dek','cent','mil','miliono','miliardo');
var k:string;
    z,r:integer;
procedure untertausend;
begin
    r:=z mod 10;
    if r>0 then k:=espera[r]+k;
    z:=z div 10;
    r:=z mod 10;
    if r>0 then
    begin
      if r>1 then k:=espera[r]+espera[10]+' '+k
             else k:=espera[10]+' '+k;
    end;
    z:=z div 10;
    r:=z mod 10;
    if r>0 then
    begin
      if r>1 then k:=espera[r]+espera[11]+' '+k
             else k:=espera[11]+' '+k;
    end;
    z:=z div 10;
end;
begin
    k:='';
    if zahl=0 then
    begin
      XZahlwort:='nul';
      exit
    end;
    z:=zahl;
    untertausend;
    z:=zahl div 1000;
    if z>0 then
    begin
      k:=espera[12]+' '+k;
      untertausend;
    end;
    z:=zahl div 1000000;
    if z>0 then
    begin
      k:=espera[13]+' '+k;
      untertausend;
    end;
    result:=k;
end;

Function FZahlwort(zahl : Integer) : String;
Const
  NamenA : Array [0..19] Of String[15] = (
    '', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit', 'neuf', 'dix',
    'onze', 'douze', 'treize', 'quatorze', 'quinze', 'seize', 'dix-sept', 'dix-huit', 'dix-neuf');

  NamenB : Array [2..9] Of String[15] = ('vingt', 'trente', 'quarante', 'cinquante',
    'soixante', 'soixante', 'quatre-vingt', 'quatre-vingt');
Procedure a_cent (chiff1, chiff2 : Word; Var sCent : String);
Var
  x10, prem, dern : Word;
Begin
    x10 := 10 * chiff1 + chiff2;
    prem := chiff1;
    dern := chiff2;
    If x10 <= 19 Then insert (NamenA [x10], sCent, 1)
    Else
      If prem In [7, 9] Then
      Begin
        If dern <> 0 Then
        Begin
          insert (NamenA [dern + 10], sCent, 1);
          If dern In [1] Then
          Begin
            If prem <> 9 Then insert (' et ', sCent, 1) Else insert ('-', sCent, 1);
          End
          Else insert ('-', sCent, 1);
          insert (NamenB [prem], sCent, 1);
        End
        Else insert (NamenB [prem] + '-' + NamenA [dern + 10], sCent, 1);
      End
      Else
      Begin
        If dern <> 0 Then insert (NamenA [dern], sCent, 1);
        If dern = 0 Then
          If prem = 8 Then insert ('s', sCent, 1);
        If dern = 1 Then
        Begin
          If prem <> 8 Then insert (' et ', sCent, 1) Else insert ('-', sCent, 1)
        End;
        If dern In [2..9] Then insert ('-', sCent, 1);
        insert (NamenB [prem], sCent, 1);
      End;
End;
Var
  s, strn : String;
  res : Integer;
  p, c1, c2, c3, nc, i : Word;
  chiff : Array [0..9] Of Byte;
Begin
    For i := 0 To 9 Do chiff [i] := 0;
    Result := '';

    str (zahl:0, strn);
    val (strn, zahl, res);
    nc := Length (strn);
    For i := 1 To nc Do
    Begin
      s := strn [i];
      val (s, chiff [i], res);
    End;
    If zahl = 0 Then Result := 'zéro'
    Else
      If nc = 1 Then Result := NamenA [chiff [nc]]
      Else
        If nc > 1 Then
        Begin
          a_cent (chiff [nc - 1], chiff [nc], Result);
          c1 := 0;
          If nc >= 3 Then
          Begin
            c2 := chiff [nc - 2];
            If (Result = '') And (c2 > 1) Then insert ('s', Result, 1)
            Else
              insert (' ', Result, 1);
            If c2 > 0 Then insert (' cent', Result, 1);
            If c2 > 1 Then a_cent (c1, c2, Result);
          End;
          If nc >= 4 Then
          Begin
            c1 := 0;
            c2 := 0;
            c3 := 0;
            If nc <= 4 Then c3 := chiff [nc - 3];
            If nc > 4 Then
            Begin
              c2 := chiff [nc - 4];
              c3 := chiff [nc - 3];
            End;
            If nc >= 5 Then c1 := chiff [nc - 5];
            insert (' ', Result, 1);
            If c1 * 100 + c2 * 10 + c3 > 0 Then insert (' mille', Result, 1);
            If c2 * 10 + c3 > 1 Then a_cent (c2, c3, Result);
            If c1 > 0 Then
            Begin
              insert (' cent ', Result, 1);
              If c1 > 1 Then insert (NamenA [c1], Result, 1);
            End;
          End;
          If nc >= 7 Then
          Begin
            c1 := 0;
            c2 := 0;
            c3 := 0;
            If nc <= 7 Then c3 := chiff [nc - 6];
            If nc > 7 Then
            Begin
              c2 := chiff [nc - 7];
              c3 := chiff [nc - 6];
            End;
            If nc >= 8 Then c1 := chiff [nc - 8];
            insert (' ', Result, 1);
            If c1 * 100 + c2 * 10 + c3 > 1 Then insert ('s', Result, 1);
            If c1 * 100 + c2 * 10 + c3 > 0 Then insert (' million', Result, 1);
            a_cent (c2, c3, Result);
            If c1 > 0 Then
            Begin
              insert (' cent ', Result, 1);
              If c1 > 1 Then insert (NamenA [c1], Result, 1);
            End;
          End;
          If nc >= 10 Then
          Begin
            c1 := 0;
            c2 := 0;
            c3 := 0;
            If nc <= 10 Then c3 := chiff [nc - 9];
            If nc > 10 Then
            Begin
              c2 := chiff [nc - 10];
              c3 := chiff [nc - 9];
            End;
            If nc >= 11 Then c1 := chiff [nc - 11];
            insert (' ', Result, 1);
            If c1 * 100 + c2 * 10 + c3 > 1 Then insert ('s', Result, 1);
            If c1 * 100 + c2 * 10 + c3 > 0 Then insert (' milliard', Result, 1);
            a_cent (c2, c3, Result);
            If c1 > 0 Then
            Begin
              insert (' cent ', Result, 1);
              If c1 > 1 Then insert (NamenA [c1], Result, 1);
            End;
          End;
        End;

   Repeat
     p := Pos ('  ', Result);
     If p <> 0 Then delete (Result, p, 1);
   Until p = 0;
   If Result [Length (Result)] = ' ' Then Result := Copy (Result, 1, Length (Result) - 1);
   If Result [1] = ' ' Then Result := Copy (Result, 2, Length (Result));
End;

Function EZahlwort(zahl : Integer) : String;
Const
  NamenA : Array [1..9]Of String[12] = (
    'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'
    );
  NamenB : Array [1..9]Of String[12] = (
    'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eightteen', 'nineteen'
    );
  NamenC : Array [1..9]Of String[12]= (
    'ten', 'twenty', 'thirty', 'fourty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
    );
Function DoTriplet (zahl : Integer) : String;
Var
  Digit, Num : Integer;
Begin
    Result:='';
    Num:=zahl Mod 100;
    If (Num>10)And (Num<20)Then
    Begin
      Result:=NamenB [Num-10];
      Num:=zahl Div 100;
    End
    Else
    Begin
      Num:=zahl;
      Digit:=Num Mod 10;
      Num:=Num Div 10;
      If Digit>0 Then Result:=NamenA [Digit];
      Digit:=Num Mod 10;
      Num:=Num Div 10;
      If Digit>0 Then Result:=NamenC [Digit]+' '+Result;
      Result:=Trim(Result);
    End;
    Digit:=Num Mod 10;
    If (Result<>'')And (Digit>0) Then Result:='and '+Result;
    If Digit>0 Then Result:=NamenA [Digit]+' hundred '+Result;
    Result:=Trim (Result);
End;
Var
  Num, Triplet, Pass : Integer;
Begin
    Result:='';
    Num:=zahl;
    For Pass:=1 To 3 Do
    Begin
      Triplet:=Num Mod 1000;
      Num:=Num Div 1000;
      If Triplet>0 Then
      Begin
        If (Pass>1)And (Result<>'')Then Result:=', '+Result;
        Case Pass Of
          2 : Result:=' thousand'+Result;
          3 : Result:=' million'+Result;
        End;
        Result:=Trim (DoTriplet (Triplet)+Result);
      End;
    End;
End;

Function DZahlwort(zahl : Integer) : String;
var s:string;
Function Umwandeln (i : Integer) : String;
Const
  NamenA : Array [1..17]Of String[12]= (
     'ein', 'zwei', 'drei', 'vier', 'fünf', 'sechs', 'sieben', 'acht', 'neun',
     'zehn', 'elf', 'zwölf', 'dreizehn', 'vierzehn', 'fünfzehn', 'sechzehn', 'siebzehn'
    );
  NamenB : Array [1..9]Of String[12]= (
     'zehn', 'zwanzig', 'dreißig', 'vierzig', 'fünfzig', 'sechzig', 'siebzig',
     'achtzig', 'neunzig'
    );
  hundert : String='hundert';
  tausend='tausend';
  und='und';
  million='million';
Var
  j : Integer;
Begin
    If i=0 Then Result:=''
    Else
      If i<18 Then Result:=NamenA [i]
      Else
        If i<20 Then Result:=NamenA [i Mod 10]+NamenB [1]
        Else
          If i<100 Then
          Begin
            If (i Mod 10)=0 Then Result:=NamenB [i Div 10]
                            Else Result:=NamenA [i Mod 10]+und+NamenB [i Div 10];
          End
          Else
            If i<1000 Then Result:=Umwandeln (i Div 100)+hundert+Umwandeln (i Mod 100)
            Else
              If i<1000000 Then Result:=Umwandeln (i Div 1000)+tausend+Umwandeln (i Mod 1000)
              Else
              Begin
                j:=i Div 1000000;
                If j=1 Then Result:='eine'
                       Else Result:=Umwandeln (j);
                Result:=Result+million;
                If j>1 Then Result:=Result+'en';
                Result:=Result+Umwandeln(i Mod 1000000);
              End;
End;
Begin
    If zahl=0 Then Result:='null'
    Else
      If zahl=1 Then Result:='eins'
      Else
      begin
        s:=Umwandeln (zahl);
        if copy(s,length(s)-2,3)='ein' then s:=s+'s';
        Result:=s;
      end;
End;

Function SZahlwort(zahl : Integer) : String;
Function Umwandeln (s : LongInt) : String;
Begin
  Case s Of
    1 : Umwandeln := 'uno';
    2 : Umwandeln := 'dos';
    3 : Umwandeln := 'tres';
    4 : Umwandeln := 'cuatro';
    5 : Umwandeln := 'cinco';
    6 : Umwandeln := 'seis';
    7 : Umwandeln := 'siete';
    8 : Umwandeln := 'ocho';
    9 : Umwandeln := 'nueve';
    10 : Umwandeln := 'diez';
    11 : Umwandeln := 'once';
    12 : Umwandeln := 'doce';
    13 : Umwandeln := 'trece';
    14 : Umwandeln := 'catorce';
    15 : Umwandeln := 'quince';
    16 : Umwandeln := 'dieciséis';
    20 : Umwandeln := 'veinte';
    30 : Umwandeln := 'treinta';
    40 : Umwandeln := 'cuarenta';
    50 : Umwandeln := 'cincuenta';
    60 : Umwandeln := 'sesenta';
    70 : Umwandeln := 'setenta';
    80 : Umwandeln := 'ochenta';
    90 : Umwandeln := 'noventa';
    100 : Umwandeln := 'cien';
    500 : Umwandeln := 'quinientos';
    700 : Umwandeln := 'setecientos';
    900 : Umwandeln := 'novecientos';
  End;
End;
Var
  N, unidades, Dec, cent, miles, decmil, centmil, mill, aux : LongInt;
  cad, cad2 : String;
Begin
    N := zahl;
    aux := N Div 1000000;
    mill := aux;
    n := n Mod 1000000;
    aux := n Div 100000;
    centmil := aux;
    n := n Mod 100000;
    aux := n Div 10000;
    decmil := aux;
    n := n Mod 10000;
    aux := n Div 1000;
    miles := aux;
    n := n Mod 1000;
    aux := n Div 100;
    cent := aux;
    n := n Mod 100;
    aux := n Div 10;
    Dec := aux;
    n := n Mod 10;
    aux := n;
    unidades := aux;
    cad := '';
    If mill > 0 Then
      If mill = 1 Then cad := 'un millón '
      Else
      Begin
        n := mill;
        cad := SZahlwort(N) + ' millones ';
      End;
      cad2 := '';
      Case centmil Of
        1 : If (miles = 0) And (decmil = 0) Then cad2 := Umwandeln (100) Else cad2 := 'ciento ';
        2 : cad2 := Umwandeln (2) + 'cientos ';
        3 : cad2 := Umwandeln (3) + 'cientos ';
        4 : cad2 := Umwandeln (4) + 'cientos ';
        5 : cad2 := Umwandeln (500) + ' ';
        6 : cad2 := Umwandeln (6) + 'cientos ';
        7 : cad2 := Umwandeln (700) + ' ';
        8 : cad2 := Umwandeln (8) + 'cientos ';
        9 : cad2 := Umwandeln (900) + ' ';
      End;
      cad := cad + cad2;
      cad2 := '';
      Case decmil Of
        0 : If miles <> 1 Then cad2 := Umwandeln (miles);
        1 : If miles <= 5 Then cad2 := Umwandeln (decmil * 10 + miles)
                          Else cad2 := 'dieci' + Umwandeln (miles);
        2 : If miles = 0 Then cad2 := Umwandeln (20)
                         Else
                           If miles = 1 Then cad2 := 'veintiun'
                                        Else cad2 := 'veinti' + Umwandeln (miles);
        3 : If miles = 0 Then cad2 := Umwandeln (30)
                         Else
                           If miles = 1 Then cad2 := 'treinta y un'
                                        Else cad2 := 'treinta y ' + Umwandeln (miles);
        4 : If miles = 0 Then cad2 := Umwandeln (40)
                         Else
                           If miles = 1 Then cad2 := 'cuarenta y un'
                                        Else cad2 := 'cuarenta y ' + Umwandeln (miles);
        5 : If miles = 0 Then cad2 := Umwandeln (50)
                         Else
                           If miles = 1 Then cad2 := 'cincuenta y un'
                                        Else cad2 := 'cincuenta y ' + Umwandeln (miles);
        6 : If miles = 0 Then cad2 := Umwandeln (60)
                         Else
                           If miles = 1 Then cad2 := 'sesenta y un'
                                        Else cad2 := 'sesenta y ' + Umwandeln (miles);
        7 : If miles = 0 Then cad2 := Umwandeln (70)
                         Else
                           If miles = 1 Then cad2 := 'setenta y un'
                                        Else cad2 := 'setenta y ' + Umwandeln (miles);
        8 : If miles = 0 Then cad2 := Umwandeln (80)
                         Else
                           If miles = 1 Then cad2 := 'ochenta y un'
                                        Else cad2 := 'ochenta y ' + Umwandeln (miles);
        9 : If miles = 0 Then cad2 := Umwandeln (90)
                         Else
                           If miles = 1 Then cad2 := 'noventa y un'
                                        Else cad2 := 'noventa y ' + Umwandeln (miles);
      End;
      If (miles > 0) Or (decmil > 0) Or (centmil > 0) Then cad2 := cad2 + ' mil ';
      cad := cad + cad2;
      cad2 := '';
      Case cent Of
        1 : If (unidades = 0) And (Dec = 0) Then cad2 := Umwandeln (100) Else cad2 := 'ciento ';
        2 : cad2 := Umwandeln (2) + 'cientos ';
        3 : cad2 := Umwandeln (3) + 'cientos ';
        4 : cad2 := Umwandeln (4) + 'cientos ';
        5 : cad2 := Umwandeln (500) + ' ';
        6 : cad2 := Umwandeln (6) + 'cientos ';
        7 : cad2 := Umwandeln (700) + ' ';
        8 : cad2 := Umwandeln (8) + 'cientos ';
        9 : cad2 := Umwandeln (900) + ' ';
      End;
      cad := cad + cad2;
      cad2 := '';
      Case Dec Of
        0 : cad2 := Umwandeln (unidades);
        1 : If unidades <= 6 Then cad2 := Umwandeln (Dec * 10 + unidades)
                             Else cad2 := 'dieci' + Umwandeln (unidades);
        2 : case unidades of
              0 : cad2 := Umwandeln(20);
              2 : cad2 := 'veintidós';
              3 : cad2 := 'veintitrés';
              6 : cad2 := 'veintiséis';
             Else cad2 := 'veinti' + Umwandeln (unidades);
            end;
        3 : If unidades = 0 Then cad2 := Umwandeln (30)
                            Else cad2 := 'treinta y ' + Umwandeln (unidades);
        4 : If unidades = 0 Then cad2 := Umwandeln (40)
                            Else cad2 := 'cuarenta y ' + Umwandeln (unidades);
        5 : If unidades = 0 Then cad2 := Umwandeln (50)
                            Else cad2 := 'cincuenta y ' + Umwandeln (unidades);
        6 : If unidades = 0 Then cad2 := Umwandeln (60)
                            Else cad2 := 'sesenta y ' + Umwandeln (unidades);
        7 : If unidades = 0 Then cad2 := Umwandeln (70)
                            Else cad2 := 'setenta y ' + Umwandeln (unidades);
        8 : If unidades = 0 Then cad2 := Umwandeln (80)
                            Else cad2 := 'ochenta y ' + Umwandeln (unidades);
        9 : If unidades = 0 Then cad2 := Umwandeln (90)
                            Else cad2 := 'noventa y ' + Umwandeln (unidades);
      End;
      cad := cad + cad2;
      If cad <> '' Then Result := cad Else Result := 'Cero';
End;

Function IZahlwort(zahl : Integer) : String;
Const
  NamenA : Array [0..20]Of String[12]= ('zero', 'uno', 'due', 'tre', 'quattro', 'cinque',
    'sei', 'sette', 'otto', 'nove', 'dieci', 'undici', 'dodici', 'tredici', 'quattordici',
    'quindici', 'sedici', 'diciassette', 'diciotto', 'diciannove', 'venti');
  NamenB : Array [2..9]Of String[12]= ('venti', 'trenta', 'quaranta', 'cinquanta',
    'sessanta', 'settanta', 'ottanta', 'novanta');
  Vocals= ['A', 'E', 'I', 'O', 'U'];

Procedure Vokalkonflikt (Var S1, S2 : String);
Begin
    If (S1<>'')And (S2<>'')Then
      If (UpCase (S1 [Length (s1)])In Vocals)And (UpCase (S2 [1])In Vocals)Then
        S1:=Copy (S1, 1, Length (S1)-1);
End;

Function Verb100 (Zahl : Integer) : String;
Var
  R, U, D : Integer;
  s1, s2 : String;
Begin
    If Zahl<=20 Then
    Begin
      If Zahl>0 Then Result:=NamenA [Zahl]
                 Else Result:='';
    End
    Else
    Begin
      R:=Zahl;
      D:=R Div 10;
      R:=R-d*10;
      U:=R;
      S1:=NamenB [D];
      If U>0 Then S2:=NamenA [U]
             Else S2:='';
      Vokalkonflikt (S1, S2);
      Result:=s1+s2;
    End;
End;

Function Verb1000 (Zahl : Integer) : String;
Var
  R, C : Integer;
  s1, s2 : String;
Begin
    R:=Zahl;
    C:=R Div 100;
    R:=R-C*100;
    S2:=Verb100 (R);
    If C>1 Then S1:=NamenA [C]+'cento'
    Else
      If c=1 Then S1:='cento'
             Else S1:='';
    Vokalkonflikt (S1, S2);
    Result:=s1+s2;
End;

Function Verb1000000 (Zahl : Integer) : String;
Var
  R, M : Integer;
Begin
    M:=Zahl Div 1000;
    R:=Zahl-M*1000;
    While M>=1000 Do
      Dec (M, 1000);
    If M=0 Then
      Result:=''
    Else
      If M=1 Then
        Result:='mille'
      Else
        Result:=Verb1000 (M)+'mila';
    If R>0 Then Result:=Result+Verb1000 (R);
End;

Function VerbMilions (Zahl : Integer) : String;
Var
  R, M : Integer;
Begin
    M:=Zahl Div 1000000;
    R:=Zahl-M*1000000;
    While M>=1000000 Do
      Dec (M, 1000000);
    If M=0 Then
      Result:=''
    Else
      If M=1 Then
        Result:='unmilione'
      Else
        Result:=Verb1000 (M)+'milioni';
    If R>0 Then Result:=Result+Verb1000000 (R);
End;

Function VerbBilions (Zahl : Integer) : String;
Var
  R, M : Integer;
Begin
    M:=Zahl Div 1000000000;
    R:=Zahl-M*1000000000;
    If M=0 Then
      Result:=''
    Else
      If M=1 Then
        Result:='unmiliardo'
      Else
        Result:=VerbMilions (M)+'miliardi';
    If R>0 Then Result:=Result+VerbMilions (R);
End;
Function CarToVerb (Zahl : Cardinal) : String;
Begin
    If Zahl<20 Then Result:=NamenA [Zahl]Else Result:=VerbBilions (Zahl);
End;
Begin
    Result:=CarToVerb (Abs (zahl));
End;

Function RZahlwort(zahl : Integer) : String;
Const
  NamenA : Array [0..19] Of String[15] = (
    '', 'odin', 'dwa', 'tri', 'yetßre', 'pätó', 'vectó', 'cemó', 'wocemó', 'dewätó',
    'decätó', 'odinnadzató', 'dwenadzató', 'trinadzató', 'yetßrnadzató',
    'pätnadzató', 'vectnadzató', 'cemnazató', 'wocemnazató', 'dewätnadzató');
  NamenB : Array [1..9] Of String[15] = ('','dwadzató', 'tridzató', 'corok',
    'pätódecät', 'vectódecät', 'cemódecät', 'wocemódecät', 'dewänocto');
  NamenC : Array [1..9] Of String[15] = ('cto', 'dwecti', 'tricta',
    'yetßrecta', 'pätócot', 'vectócot', 'cemócot', 'wocemócot', 'dewätócot');
function tausender(x:integer):string;
var ss:string;
begin
    ss:='';
    if x div 100<>0 then ss:=ss+NamenC[x div 100]+' ';
    x:=x mod 100;
    if x<>0 then
    begin
      if x div 10>1 then
      begin
        ss:=ss+NamenB[x div 10]+' ';
        if x mod 10>0 then ss:=ss+NamenA[x mod 10]+' ';
      end
      else
      begin
        if x>0 then ss:=ss+NamenA[x]+' ';
      end;
    end;
    tausender:=ss;
end;
Var
  k,ke : String; w : Integer;
Begin
    k:='';
    w:=zahl mod 1000;
    if w>0 then ke:=tausender(w);
    k:=k+ke;
    zahl:=zahl div 1000;
    w:=zahl mod 1000;
    if w>0 then
    begin
      ke:=tausender(w);
      if (w mod 10 =1) and ((w mod 100<11) or (w mod 100>20)) then
        k:=copy(ke,1,length(ke)-3)+'na tßcäya '+k
      else
        if (w mod 10 =2)and ((w mod 100<11) or (w mod 100>20)) then
          k:=copy(ke,1,length(ke)-2)+'e tßcäyi '+k
        else
         if (w mod 10<5) and ((w mod 100<11) or (w mod 100>20)) then k:=ke+'tßcäyi '+k
                                                                else k:=ke+'tßcäy '+k;
    end;
    zahl:=zahl div 1000;
    w:=zahl mod 1000;
    if w>0 then
    begin
      ke:=tausender(w);
      if (w mod 10 =1) and ((w mod 100<11) or (w mod 100>20)) then k:=ke+'million '+k
      else
        if (w mod 10<5) and ((w mod 100<11) or (w mod 100>20)) then k:=ke+'milliona '+k
        else k:=ke+'millionow '+k;
    end;
    if k='' then k:='nuló';
    result:=k;
End;

end.

