unit pentomino;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ToolWin, ComCtrls, ExtCtrls, Grids, Menus, StdCtrls, zlib;

type
  Tpentoform = class(TForm)
    P1: TPanel;
    P8: TPanel;
    P5: TPanel;
    TB1: TToolBar;
    P4: TPanel;
    MM1: TMainMenu;
    M2: TMenuItem;
    M3: TMenuItem;
    M1: TMenuItem;
    P2: TPanel;
    P6: TPanel;
    LB1: TListBox;
    L1: TLabel;
    PB1: TPaintBox;
    L2: TLabel;
    Timer1: TTimer;
    L3: TLabel;
    Button1: TButton;
    d3: TButton;
    procedure S7Click(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure D3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    liste1,liste2:tstringlist;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  pentoform: Tpentoform;

implementation

uses xzusatzbild2;
{$R *.DFM}
type tteil = record
               nr:integer;
               farbe:integer;
               punktzahl:integer;
               punkte:array[0..40] of tpoint;
               x,y:real;
              end;
var aktiv:boolean;
    geschafft:boolean;
    gg:integer;

    teil: array[0..25] of tteil;
    reihe: array[0..25] of integer;
    anzahl:integer;

    startzeit:tdatetime;
    ax,ay:real;
    teilnummer:integer;
    zeilenzahl,zeilenbreite:integer;
    zeile:array[1..25] of string[30];

procedure Tpentoform.S7Click(Sender: TObject);
begin
    close
end;

procedure Tpentoform.D1Click(Sender: TObject);
var nr,sel,
    xm,ym,
    k,i,j,
    r,g,b,test:integer;
    s,k2,k1:string;
begin
    timer1.enabled:=true;
    startzeit:=time;
    k1:=lb1.items[lb1.itemindex];
    if pos(#9,k1)>0 then
    begin
      delete(k1,pos(#9,k1),255);
      d3.visible:=true
    end
    else d3.visible:=false;
    for i:=1 to 12 do reihe[i]:=i;
    nr:=0;
    anzahl:=strtoint(liste1[nr]);
    inc(nr);
    for i:=1 to anzahl do
    begin
      s:=liste1[nr];
      inc(nr);
      j:=strtoint(liste1[nr]);
      inc(nr);
      teil[i].nr:=j;
      r:=strtoint(liste1[nr]);
      inc(nr);
      g:=strtoint(liste1[nr]);
      inc(nr);
      b:=strtoint(liste1[nr]);
      inc(nr);
      teil[i].farbe:=rgb(r,g,b);
      j:=strtoint(liste1[nr]);
      inc(nr);
      teil[i].punktzahl:=j;
      xm:=0;
      ym:=0;
      for k:=0 to teil[i].punktzahl-1 do
      begin
        r:=strtoint(liste1[nr]);
        inc(nr);
        teil[i].punkte[k].x:=r;
        xm:=xm+r;
        r:=strtoint(liste1[nr]);
        inc(nr);
        teil[i].punkte[k].y:=r;
        ym:=ym+r;
      end;
      xm:=round(xm/teil[i].punktzahl);
      ym:=round(ym/teil[i].punktzahl);
      for k:=0 to teil[i].punktzahl-1 do
      begin
        teil[i].punkte[k].x:=teil[i].punkte[k].x-xm;
        teil[i].punkte[k].y:=teil[i].punkte[k].y-ym;
      end;
      j:=strtoint(liste1[nr]);
      inc(nr);
      teil[i].x:=j;
      j:=strtoint(liste1[nr]);
      inc(nr);
      teil[i].y:=j;
    end;
    sel:=lb1.itemindex;
    if sel<0 then sel:=0;
    k1:=lb1.items[sel];
    if pos(#9,k1)>0 then delete(k1,pos(#9,k1),255);
    s:='['+k1;
    nr:=0;
    repeat
      k2:=liste2[nr];
      inc(nr);
    until k2=s;
    i:=1;
    zeilenzahl:=0;
    zeilenbreite:=0;
    test:=0;
    repeat
      k2:=liste2[nr];
      inc(nr);
      if k2[1]<>'[' then
      begin
        zeile[i]:=k2;
        for j:=1 to length(k2) do
          if k2[j]='#' then inc(test);
        inc(zeilenzahl);
        if length(k2)>zeilenbreite then zeilenbreite:=length(k2);
        inc(i);
      end;
   until (k2[1]='[');
   if test<>60 then showmessage('Fehler: '+lb1.items[sel]+' / '+inttostr(test));
   pb1paint(sender);
end;

procedure Tpentoform.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
    i,j,br,ho,rx1,ry1:integer;
    geschafft2:boolean;
const hintergrund=$00e0e0e0;

procedure teilzeichnen(i:integer);
var j,vx,vy:integer;
    pu:array[0..24] of tpoint;
begin
    bitmap.canvas.brush.color:=teil[i].farbe;
    vx:=round(teil[i].x*gg);
    vy:=round(teil[i].y*gg);
    for j:=0 to teil[i].punktzahl-1 do
    begin
      pu[j].x:=vx+teil[i].punkte[j].x*gg+gg;
      pu[j].y:=vy-teil[i].punkte[j].y*gg;
    end;
    bitmap.canvas.polygon(slice(pu,teil[i].punktzahl));
end;

begin
  try
    Bitmap := TBitmap.Create;
    Bitmap.Width := pb1.Width;
    Bitmap.Height := pb1.Height;
    br:= round(1/2*(pb1.Width/gg-12)+12);
    ho:= round(1/2*pb1.Height/gg);

    bitmap.canvas.pen.color:=$0e0e0e0;//clltgray;
    i:=0;
    repeat
      bitmap.canvas.moveto(i*gg,-1);
      bitmap.canvas.lineto(i*gg,pb1.height+1);
      inc(i);
    until i*gg>pb1.width;
    i:=0;
    repeat
      bitmap.canvas.moveto(-1,i*gg);
      bitmap.canvas.lineto(pb1.width+1,i*gg);
      inc(i);
    until i*gg>pb1.height;

    bitmap.canvas.pen.color:=clmaroon;
    bitmap.canvas.brush.color:=hintergrund;
    rx1:=-zeilenbreite div 2;
    ry1:=-zeilenzahl div 2;
    for i:=1 to zeilenzahl do
    begin
      for j:=1 to length(zeile[i]) do
      begin
        if zeile[i][j] = '#' then
          bitmap.canvas.rectangle((br+rx1+j-1)*gg,(ho+ry1+i-1)*gg,
                                  (br+rx1+j)*gg+1,(ho+ry1+i)*gg+1);
      end;
    end;

    bitmap.canvas.pen.color:=clblack;
    for i:=1 to anzahl do teilzeichnen(reihe[i]);
    pb1.Canvas.draw(0,0,bitmap);
    geschafft2:=true;

    rx1:=-zeilenbreite div 2;
    ry1:=-zeilenzahl div 2;
    for i:=1 to zeilenzahl do
    begin
      for j:=1 to length(zeile[i]) do
      begin
        if zeile[i][j]='#' then
          geschafft2:=geschafft2 and
          (bitmap.canvas.pixels[(br+rx1+j-1)*gg+5,(ho+ry1+i-1)*gg+5]<>hintergrund);
      end;
    end;
  finally
    bitmap.free;
  end;
  geschafft:=geschafft2;
end;

procedure DecompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  OutBytes, sz: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  sz     := inpStream.Size - inpStream.Position;
  if sz > 0 then
    try
      GetMem(InpBuf, sz);
      inpStream.Read(InpBuf^, sz);
      DecompressBuf(InpBuf, sz, 0, OutBuf, OutBytes);
      outStream.Write(OutBuf^, OutBytes);
    finally
      if InpBuf <> nil then FreeMem(InpBuf);
      if OutBuf <> nil then FreeMem(OutBuf);
    end;
  outStream.Position := 0;
end;

procedure aufgabenladen(liste:tstringlist;const kk:string);
var ms1: TResourcestream; ms2: TMemoryStream;
begin
    ms1 := TResourceStream.Create(hinstance,kk,'RT_RCDATA');
  try
    ms2 := TMemoryStream.Create;
    try
      DecompressStream(ms1, ms2);
      liste.LoadFromStream(ms2);
    finally
      ms2.Free;
    end;
  finally
    ms1.Free;
  end;
end;

procedure Tpentoform.FormActivate(Sender: TObject);
var k,k1:string;
    nr:integer;
begin
    liste1:=tstringlist.create;
    liste2:=tstringlist.create;
    aufgabenladen(liste1,'pento');
    aufgabenladen(liste2,'pentx');

    gg:=round(28*pb1.height/573);
    lb1.clear;
    nr:=0;
    repeat
      k:=liste2[nr];
      inc(nr);
      if k[1]<>'[' then lb1.items.add(k);
    until (k[1]='[');
    lb1.itemindex:=0;
    l1.caption:=inttostr(lb1.items.count)+' Aufgaben';
    k1:=lb1.items[lb1.itemindex];

    if pos(#9,k1)>0 then delete(k1,pos(#9,k1),255);
    d1click(sender);
end;

procedure Tpentoform.PB1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,farbx,p,q:integer;
    reihe2:array[1..12] of integer;
    x1,y1:integer;
begin
    farbx:=pb1.canvas.pixels[x,y];
    teilnummer:=0;
    for i:=1 to anzahl do
      if teil[i].farbe=farbx then
      begin
        ax:=x-teil[i].x*gg;
        ay:=y-teil[i].y*gg;
        teilnummer:=i;
        p:=1;
        q:=1;
        repeat
          if reihe[q]=teilnummer then inc(q);
          reihe2[p]:=reihe[q];
          inc(p);
          inc(q);
        until p=12;
        reihe2[12]:=teilnummer;
        for p:=1 to 12 do reihe[p]:=reihe2[p];
      end;

    if button=mbleft then
    begin
      aktiv:=true;
      exit;
    end;

    if button=mbright then
    begin
      if teilnummer>0 then
      begin
        if shift=[ssctrl,ssright] then
        begin
          for p:=0 to teil[teilnummer].punktzahl-1 do
          begin
            x1:=-teil[teilnummer].punkte[p].x;
            teil[teilnummer].punkte[p].x:=x1;
          end;
        end
        else
        begin
          for p:=0 to teil[teilnummer].punktzahl-1 do
          begin
            x1:=teil[teilnummer].punkte[p].y;
            y1:=-(teil[teilnummer].punkte[p].x);
            teil[teilnummer].punkte[p].x:=x1;
            teil[teilnummer].punkte[p].y:=y1;
          end;
        end;
        pb1paint(sender);
      end;
    end;
end;

procedure Tpentoform.PB1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if aktiv then
    begin
      teil[teilnummer].x:=(x-ax)/gg;
      teil[teilnummer].y:=(y-ay)/gg;
      pb1paint(sender);
    end;
end;

procedure Tpentoform.PB1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if aktiv then
    begin
      teil[teilnummer].x:=round((x-ax)/gg);
      teil[teilnummer].y:=round((y-ay)/gg);
      pb1paint(sender);
      aktiv:=false;
    end;
end;

procedure Tpentoform.Timer1Timer(Sender: TObject);
begin
    l3.caption:=timetostr(time-startzeit);
    if (aktiv=false) and geschafft then
    begin
      timer1.enabled:=false;
      if geschafft then showmessage('Gratulation. Die Lösung ist richtig');
    end;
end;

procedure Tpentoform.D3Click(Sender: TObject);
var k1:string;
begin
      k1:=lb1.items[lb1.itemindex];
      if pos(#9,k1)>0 then delete(k1,1,pos(#9,k1));
      zusatzbildstring2:=k1;
      startzeit:=startzeit-60/(24*3600);

      Application.CreateForm(Tzusatzbild2, zusatzbild2);
      zusatzbild2.showmodal;
      zusatzbild2.release;
end;

procedure Tpentoform.FormDestroy(Sender: TObject);
begin
    liste1.free;
    liste2.free;
end;

initialization
    aktiv:= false;
    geschafft:=false;
    gg:=28;
end.

