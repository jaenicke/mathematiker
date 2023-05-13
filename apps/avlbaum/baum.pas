unit baum;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  Tfbaum = class(TForm)
    P4: TPanel;
    avl: TPanel;
    Panel2: TPanel;
    pb1: TPaintBox;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    CB1: TCheckBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure pb1Paint(Sender: TObject);
    procedure d1Click(Sender: TObject);
    procedure D8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure D2Click(Sender: TObject);
    procedure D3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fbaum: Tfbaum;

implementation

{$R *.DFM}
type
     zeiger=^knoten;
     knoten = record
               links,rechts : zeiger;
               inhalt : integer;
              end;
     datei = file of integer;
var
     wurzel:zeiger;
     f:datei;

// Baum - Routinen

//Element einfügen
procedure ein(zahl:integer; var lauf:zeiger);
begin
  if lauf=nil then begin
     new(lauf);
     lauf^.inhalt:=zahl;
     lauf^.links:=nil; lauf^.rechts:=nil; end
    else
     if zahl<lauf^.inhalt then ein(zahl,lauf^.links)
        else ein(zahl,lauf^.rechts);
end;

//Element lesen
procedure lies(l,r:integer; var p:zeiger);
var mitte:integer;
begin
    mitte:=(l+r) div 2; new(p);
    seek(f,mitte); read(f,p^.inhalt);
    p^.links:=nil; p^.rechts:=nil;
    if mitte>l then lies(l,mitte-1,p^.links);
    if mitte<r then lies(mitte+1,r,p^.rechts);
end;

//Element schreiben
procedure schreib(p:zeiger);
begin
    if p<>nil then begin
       schreib(p^.links); write(f,p^.inhalt);
       schreib(p^.rechts);
    end;
end;

// Baum ausgleichern
procedure balance(var p:zeiger);
begin
   assignfile(f,'baum.tmp'); rewrite(f);
   schreib(p); closefile(f); reset(f);
   dispose(p);
   p:=nil; lies(0,filesize(f)-1,p);
   closefile(f);
end;
//Ende Baum-Routinen

//Baum grafisch darstellen
procedure Tfbaum.pb1Paint(Sender: TObject);
const dh:integer=60;
var bitmap:tbitmap; z:integer; kk:string; pp:tpoint;
procedure aus(p:zeiger;l:integer);
var x,y:integer;
procedure moverel(a,b:integer);
begin
    x:=bitmap.canvas.penpos.x;
    y:=bitmap.canvas.penpos.y;
    bitmap.canvas.moveto(x+a,y+b);
end;
procedure linerel(a,b:integer);
begin
    x:=bitmap.canvas.penpos.x;
    y:=bitmap.canvas.penpos.y;
    bitmap.canvas.lineto(x+a,y+b);
end;
begin
  if p<>nil then begin z:=p^.inhalt;
    kk:=inttostr(z); 
    pp:=bitmap.canvas.penpos;
    x:=bitmap.canvas.penpos.x;
    y:=bitmap.canvas.penpos.y;
    bitmap.canvas.textout(x-bitmap.canvas.textwidth(kk) div 2,y-10,kk);
    bitmap.canvas.moveto(pp.x,pp.y);
    if p^.links<>nil then begin linerel(-l,dh); aus(p^.links,l div 2); moverel(l,-dh); end;
    if p^.rechts<>nil then begin linerel(l,dh); aus(p^.rechts,l div 2); moverel(-l,-dh); end;
  end;
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height;
    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.size:=8;
    bitmap.canvas.pen.color:=clblue;
    bitmap.canvas.moveto(bitmap.width div 2,20);
    dh:=(bitmap.height-40) div 10;
    aus(wurzel,bitmap.width div 4);
    pb1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

//Element übernehmen
procedure Tfbaum.d1Click(Sender: TObject);
var n:integer;
begin
  n:=strtoint(edit1.text);
  if edit1.text<>'' then ein(n,wurzel);
  edit1.text:=inttostr(random(100));
  if cb1.checked then D8Click(Sender) else pb1paint(sender);
end;

//Baum ausgleichen
procedure Tfbaum.D8Click(Sender: TObject);
begin
 if wurzel<>nil then begin
  balance(wurzel);
  pb1paint(sender);
  end;
end;

//Element suchen
procedure Tfbaum.D2Click(Sender: TObject);
var z:integer; gefunden:boolean; p:zeiger; km:string;
begin
 if wurzel<>nil then begin
    p:=wurzel;
    memo1.clear;
    z:=strtoint(edit2.text);
    gefunden:=false; km:='Pfad'+#13#10;
   while (p<>nil) and (gefunden=false) do begin
    if p^.inhalt=z then begin km:=km+inttostr(p^.inhalt)+', ';
                              gefunden:=true; end
      else begin
       km:=km+inttostr(p^.inhalt)+', ';
       if z<p^.inhalt then p:=p^.links
                      else p:=p^.rechts;
      end;
    end;
    if not gefunden then km:='Element nicht gefunden';
    memo1.Lines.add(km);
   end;
end;

//Element löschen
procedure Tfbaum.D3Click(Sender: TObject);
var z:integer; gefunden,richtung:boolean; p,palt,pziel:zeiger; km:string;
begin
 if wurzel<>nil then begin
    richtung:=false;
 if ((wurzel^.links<>nil) or (wurzel^.rechts<>nil)) then
    begin
    p:=wurzel; palt:=nil;
    z:=strtoint(edit2.text);
    gefunden:=false;
   while (p<>nil) and (gefunden=false) do begin
    if p^.inhalt=z then begin gefunden:=true; end
      else begin
       palt:=p;
       if z<p^.inhalt then begin richtung:=true; p:=p^.links end
                      else begin richtung:=false; p:=p^.rechts; end;
      end;
    end;
  if not gefunden then begin memo1.clear; km:='Element nicht gefunden';
                               memo1.Lines.add(km); end
    else begin //austauschroutine
       if (p^.links=nil) and (p^.rechts=nil) then begin
             if richtung then palt^.links:=nil else palt^.rechts:=nil;
             dispose(p);
          end else begin
            if (p^.links<>nil) then begin
                pziel:=p;
                palt:=p; richtung:=true; p:=p^.links;
                while p^.rechts<>nil do begin
                         richtung:=false;
                         palt:=p; p:=p^.rechts;
                      end;
                pziel^.inhalt:=p^.inhalt;
                if richtung then palt^.links:=nil else palt^.rechts:=nil;
                dispose(p);
              end else begin
            if (p^.rechts<>nil) then begin
                pziel:=p;
                palt:=p; richtung:=false; p:=p^.rechts;
                while p^.links<>nil do begin
                         richtung:=true;
                         palt:=p; p:=p^.links;
                      end;
                pziel^.inhalt:=p^.inhalt;
                if richtung then palt^.links:=nil else palt^.rechts:=nil;
                dispose(p);
              end;
              end;
          end
    end;
    balance(wurzel);
    end else wurzel:=niL;
    pb1paint(sender);
   end;
end;

procedure Tfbaum.FormActivate(Sender: TObject);
begin
    assignfile(f,'baum.tmp'); rewrite(f); closefile(f);
    wurzel:=nil;
end;

procedure Tfbaum.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  deletefile('baum.tmp');
end;

end.


