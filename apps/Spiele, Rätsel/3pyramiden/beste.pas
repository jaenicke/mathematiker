unit beste;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Menus, StdCtrls,
  ExtCtrls;

type
  TBestenliste = class(TForm)
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    LB1: TListBox;
    D1: TButton;
    PM1: TPopupMenu;
    M2: TMenuItem;
    D2: TButton;
    P4: TPanel;
    M1: TMenuItem;
    Memo1: TMemo;
    P5: TPanel;
    L1: TLabel;
    Edit1: TEdit;
    D3: TButton;
    CB1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure D1C(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure D2C(Sender: TObject);
    procedure D3C(Sender: TObject);
    procedure E1C(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Bestenliste: TBestenliste;
  xname,spielname: string;
  datenverzeichnis: string;
  aktuellesspiel : boolean;
  spunkte : integer;
  akpunkte : integer;

implementation

uses Dialogs, inifiles;

{$R *.DFM}
var aktuellezeile:integer;
    ergebnisliste:array[0..42] of string;
    ergebnispunkte:array[0..42] of integer;

procedure TBestenliste.FormCreate(Sender: TObject);
var kp,ks,ek:string;
    ini: TIniFile;
    i:integer;
begin
  bestenliste.caption:='Bestenliste';
  p4.caption:=spielname;
  aktuellezeile:=-1;
  lb1.clear;
  kp:=spielname;
  ini := TIniFile.create(datenverzeichnis+'dreipyr.ini');
  try
    for i:=1 to 20 do begin
      ks:=ini.readstring(kp,inttostr(i),'');
      if (length(ks)=0) or (pos(#9,ks)=0) then begin
        ergebnispunkte[i]:=0;
        ergebnisliste[i]:=''
      end else begin
        ergebnispunkte[i]:=strtoint(copy(ks,1,pos(#9,ks)-1));
        delete(ks,1,pos(#9,ks));
        ergebnisliste[i]:=ks;
      end;
      ek:=inttostr(ergebnispunkte[i]);
      while length(ek)<6 do ek:='0'+ek;
      lb1.items.add(' '+ek+#9+ergebnisliste[i]);
    end;
  finally
    ini.free;
  end;
end;

procedure TBestenliste.D1C(Sender: TObject);
var kp:string;
    i:integer;
    ini:tinifile;
begin
  kp:=spielname;
  ini := TIniFile.create(datenverzeichnis+'dreipyr.ini');
  try
    for i:=1 to 20 do begin
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
  if spunkte<>0 then begin
    j:=1;
    while spunkte<ergebnispunkte[j] do inc(j);
    if j<=20 then begin
      for m:=20 downto j do begin
        ergebnispunkte[m+1]:=ergebnispunkte[m];
        ergebnisliste[m+1]:=ergebnisliste[m];
      end;
    end;
    kk:=inttostr(spunkte);
    while length(kk)<6 do kk:='0'+kk;
    kk:=' '+kk+#9+datetostr(date)+#9+xname;
    ergebnispunkte[j]:=spunkte;
    ergebnisliste[j]:=datetostr(date)+#9+xname;
    if lb1.items.count=0 then begin
      lb1.items.add(kk);
      lb1.itemindex:=0;
      aktuellezeile:=0;
    end else begin
      if j<=20 then begin
        lb1.items.insert(j-1,kk);
        lb1.itemindex:=j-1;
        aktuellezeile:=j-1;
      end;
    end;
  end;
end;

procedure TBestenliste.D2C(Sender: TObject);
var anz,i:integer;
begin
  if MessageDlg('Wirklich löschen?',mtCustom, [mbYes, mbNo], 0) = mrYes then begin
    if cb1.checked then begin
      anz:=lb1.items.count;
      if anz>1 then begin
        for i:=1 to anz do lb1.items.delete(1);
        for i:=2 to 20 do begin
          ergebnispunkte[i]:=0;
          ergebnisliste[i]:='';
        end;
      end;
    end else begin
      lb1.clear;
      for i:=1 to 20 do begin
        ergebnispunkte[i]:=0;
        ergebnisliste[i]:='';
      end;
    end;
  end;
end;

procedure TBestenliste.D3C(Sender: TObject);
var k:string;
begin
  xname:=edit1.Text;
  if aktuellezeile>=0 then begin
    k:=lb1.items.strings[aktuellezeile];
    lb1.items.delete(aktuellezeile);
    while k[length(k)]<>#9 do delete(k,length(k),1);
    k:=k+xname;
    lb1.items.insert(aktuellezeile,k);
    ergebnisliste[aktuellezeile+1]:=datetostr(date)+#9+xname;
  end;
end;

procedure TBestenliste.E1C(Sender: TObject);
begin
  xname:=edit1.text;
end;

end.
