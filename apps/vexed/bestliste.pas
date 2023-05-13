unit bestliste;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ComCtrls, inifiles;

type
  TBestenliste = class(TForm)
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    LB1: TListBox;
    PM1: TPopupMenu;
    M2: TMenuItem;
    P4: TPanel;
    M1: TMenuItem;
    Memo1: TMemo;
    P5: TPanel;
    L1: TLabel;
    Edit1: TEdit;
    CB1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure D3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

  function  _strkomma(a:real;b,c:byte):string;

var
  Bestenliste: TBestenliste;
  xname,spielname: string;
  aktuellesspiel : boolean;
  spunkte : integer;

implementation

{$R *.DFM}
var aktuellezeile:integer;
    ergebnisliste:array[0..42] of string;
    ergebnispunkte:array[0..42] of integer;

function Tempstring: string;
begin
  SetLength(Result,MAX_PATH + 1);
  SetLength(Result,GetTempPath(length(Result),@Result[1]));
end;

function  _strkomma(a:real;b,c:byte):string;
var ks:string;
begin
   str(a:b:c,ks);
   if c<>0 then
   begin
      while (length(ks)>1) and (ks[length(ks)]='0') do delete(ks,length(ks),1);
      if (length(ks)>1) and (ks[length(ks)]='.') then delete(ks,length(ks),1);
   end;
   if ks='-0' then ks:='0';
   _strkomma:=ks;
end;

procedure TBestenliste.FormCreate(Sender: TObject);
var kp,ks,ek:string;
    ini: TIniFile;
    i:integer;
begin
    if spielname='' then spielname:='Kopfrechnentest';
    p4.caption:=spielname;
    aktuellezeile:=-1;
    lb1.clear;
    kp:=spielname;

    try
      ini := TIniFile.create(tempstring+'wfktspiele.ini');
      for i:=1 to 20 do
      begin
        ks:=ini.readstring(kp,inttostr(i),'');
        if (length(ks)=0) or (pos(#9,ks)=0) then
        begin
          ergebnispunkte[i]:=0;
          ergebnisliste[i]:=''
        end
        else
        begin
          ergebnispunkte[i]:=strtoint(copy(ks,1,pos(#9,ks)-1));
          delete(ks,1,pos(#9,ks));
          ergebnisliste[i]:=ks;
        end;
        ek:=inttostr(ergebnispunkte[i]);
        while length(ek)<5 do ek:='0'+ek;
        lb1.items.add(' '+ek+#9+ergebnisliste[i]);
      end;
    finally
      ini.free;
    end;
end;

procedure TBestenliste.D1Click(Sender: TObject);
var kp:string;
    i:integer;
    ini:tinifile;
begin
    kp:=spielname;
    try
      ini := TIniFile.create(tempstring+'wfktspiele.ini');
      for i:=1 to 20 do
      begin
        if i-1<lb1.Items.count then
          ini.writestring(kp,inttostr(i),lb1.items[i-1])
        else
          ini.writestring(kp,inttostr(i),'');
      end;
    finally
      ini.free;
      spunkte:=0;
      close;
    end;
end;

procedure TBestenliste.FormActivate(Sender: TObject);
var kk:string;
    j,m:integer;
begin
    edit1.text:=xname;
    //Spunkte sind die erreichten Punkte
    if spunkte>0 then
    begin
      j:=1;
      //im Feld Ergebnispunkte liegen die gespeicherten Punkte
      //in Ergebnisliste die Strings (Punkte+Datum+Spieler)
      while spunkte<ergebnispunkte[j] do inc(j);
      if j<=20 then
      begin
        for m:=20 downto j do
        begin
          ergebnispunkte[m+1]:=ergebnispunkte[m];
          ergebnisliste[m+1]:=ergebnisliste[m];
        end;
      end;
      //Ergebnis wird formatiert
      kk:=inttostr(spunkte);
      while length(kk)<5 do kk:='0'+kk;
      kk:=' '+kk+#9+datetostr(date)+#9+xname;
      ergebnispunkte[j]:=spunkte;
      ergebnisliste[j]:=datetostr(date)+#9+xname;

      //Eintragen als erster String
      if lb1.items.count=0 then
      begin
        lb1.items.add(kk);
        lb1.itemindex:=0;
        aktuellezeile:=0;
      end
      //oder Einfügen in die Liste
      else
      begin
        if j<=20 then
        begin
          lb1.items.insert(j-1,kk);
          lb1.itemindex:=j-1;
          aktuellezeile:=j-1;
        end;
      end;
    end;
end;

procedure TBestenliste.D2Click(Sender: TObject);
var anz,i:integer;
begin
    if MessageDlg('Wirklich löschen?',mtCustom, [mbYes, mbNo], 0) = mrYes then
    begin
      if cb1.checked then
      begin
        anz:=lb1.items.count;
        if anz>1 then
        begin
          for i:=1 to anz do lb1.items.delete(1);
          for i:=2 to 20 do
          begin
            ergebnispunkte[i]:=0;
            ergebnisliste[i]:='';
          end;
        end;
      end
      else
      begin
        lb1.clear;
        for i:=1 to 20 do
        begin
          ergebnispunkte[i]:=0;
          ergebnisliste[i]:='';
        end;
      end;
    end;
end;

procedure TBestenliste.D3Click(Sender: TObject);
var k:string;
begin
    xname:=edit1.Text;
    if aktuellezeile>=0 then
    begin
      k:=lb1.items.strings[aktuellezeile];
      lb1.items.delete(aktuellezeile);
      while k[length(k)]<>#9 do delete(k,length(k),1);
      k:=k+xname;
      lb1.items.insert(aktuellezeile,k);
      ergebnisliste[aktuellezeile+1]:=datetostr(date)+#9+xname;
    end;
end;

procedure TBestenliste.Edit1Change(Sender: TObject);
begin
    xname:=edit1.text;
end;

{procedure TBestenliste.Button4Click(Sender: TObject);
const
  TextZeichen:array[0..71] of
    byte=(65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,
          88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,
          113,114,115,116,117,118,119,120,121,122,48,49,50,51,52,53,54,55,56,57,
          33,34,40,41,44,46,58,59,32,10);
var
  Text:string;
  Maxlength,i: Integer;
begin
    Text:=p4.caption;
    for i:=0 to lb1.items.count-1 do
      text:=text+lb1.items[i]+#13#10;

  if length(text)>0 then begin
    i1.Width:=0;
    i1.Height:=0;
    Maxlength:=
      (i1.Picture.Bitmap.Height*i1.Picture.Bitmap.Width)div 3;
    while Length(Text)<MaxLength-1 do
      if Text[Length(Text)]=char(10)
        then Text:=Text+Char(13)
        else Text:=Text+Char(Textzeichen[Random(High(Textzeichen)+1)]);
    if Length(Text)<=Maxlength
      then Codiere(i1.Picture.Bitmap, XOrCode(Text));
    i1.Width:=i1.Picture.Bitmap.Width;
    i1.Height:=i1.Picture.Bitmap.Height;
    pb1.position:=0;
    if savepicturedialog1.execute then
      i1.picture.savetofile(savepicturedialog1.filename);
    end;
end;}

end.
