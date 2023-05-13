unit ukinversion;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, fktint, ugraph,
  Menus, Buttons, ToolWin, ComCtrls, ExtCtrls, StdCtrls, math, RXSpin, zlib;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    TB3: TToolBar;
    P3: TPanel;
    Timer1: TTimer;
    S2: TSpeedButton;
    S1: TSpeedButton;
    kinversion: TPanel;
    paintbox1: TPaintBox;
    P18: TPanel;
    P19: TPanel;
    Listbox1: TListBox;
    Label14: TPanel;
    P28: TPanel;
    P30: TPanel;
    P26: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    EditP: TEdit;
    E22: TEdit;
    E23: TEdit;
    E24: TEdit;
    EditA: TEdit;
    EditE: TEdit;
    Rx12: TRxSpinEdit;
    B2: TButton;
    B1: TButton;
    S3: TSpeedButton;
    S4: TSpeedButton;
    S5: TSpeedButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure G3C(Sender: TObject);
    procedure LB5C(Sender: TObject);
    procedure D10C(Sender: TObject);
    procedure PB5D(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB5M(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB5U(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure S36C(Sender: TObject);
    procedure S42Click(Sender: TObject);
    procedure S21Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PB5P(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox5Paintx(can:tcanvas);
    procedure Timer1Timer(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure S4Click(Sender: TObject);
    procedure S5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  _polar:boolean;

implementation

//uses graph;
var   ufaktor,xa,xb:real;
const
      aktiv : byte = 0;
      faktor:real=50;
      richtung:integer=1;
      fuabbruch:boolean=true;
{$R *.DFM}

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

procedure listedll(liste:tstringlist;const kk:string);
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

procedure TForm1.FormCreate(Sender: TObject);
var k:string;
    liste:tstringlist;
    qu:integer;
begin
    ldatei:=tstringlist.create;
    timer1.interval:=20;
    richtung:=1;
    ufaktor:=1;
    xa:=0;
    xb:=0;
    combobox1.itemindex:=0;
    Listbox1.clear;
    liste:=tstringlist.create;
    listedll(liste,'mkurv');
    qu:=0;
    repeat
      k:=liste[qu];
      inc(qu,3);
      Listbox1.items.add(k);
    until qu>liste.count-1;
    liste.free;
    Listbox1.itemindex:=0;
end;

procedure TForm1.G3C(Sender: TObject);
begin
    edit1.text:='';
    edit2.text:='';
    if radiobutton1.checked then
    begin
      _polar:=false;
      Label3.visible:=true;
      Edit2.visible:=true;
      Label2.caption:='X = f(K) =';
    end
    else
    begin
      _polar:=true;
      Label3.visible:=false;
      Edit2.visible:=false;
      Label2.caption:='F(W) =';
    end;
end;

procedure TForm1.LB5C(Sender: TObject);
var kk,kl:string;
    liste:tstringlist;
    qu:integer;
begin
    _polar:=false;
    kl:=Listbox1.items.strings[Listbox1.itemindex];
    liste:=tstringlist.create;
    listedll(liste,'mkurv');
    qu:=0;
    repeat
      kk:=liste[qu]; inc(qu);
      if kk<>kl then inc(qu,2)
      else
      begin
        kk:=liste[qu]; inc(qu);
        if kk<>'Polar' then
        begin
          f[6]:=kk;
          kk:=liste[qu]; inc(qu);
          f[7]:=kk;
          _polar:=false;
        end
        else
        begin
          kk:=liste[qu]; inc(qu);
          f[8]:=kk;
          _polar:=true;
        end;
      end;
    until qu>liste.count-1;
    liste.free;
    if _polar then radiobutton2.checked:=true
              else radiobutton1.checked:=true;
    g3c(sender);
    if _polar then
    begin
      Edit1.text:=f[8];
      if pos('P',f[8])=0 then combobox1.itemindex:=1
                         else combobox1.itemindex:=0;
    end
    else
    begin
      Edit1.text:=f[6];
      Edit2.text:=f[7];
      if (pos('P',f[6])=0) and (pos('P',f[7])=0) then combobox1.itemindex:=1
                                                 else combobox1.itemindex:=0;
    end;
    pb5p(sender);
end;

procedure TForm1.D10C(Sender: TObject);
begin
   timer1.enabled:=not timer1.enabled;
   if timer1.enabled then b2.caption:='Abbruch'
                     else b2.caption:='Animation';
end;

function  ein_real(const edit:tedit):real;
var kk:string;
    i:integer;
    we:real;
begin
    kk:=edit.text;
    if kk<>'' then
       for i:=1 to length(kk) do kk[i]:=upcase(kk[i]);
    while pos(',',kk)<>0 do kk[pos(',',kk)]:='.';
    fehler:=0;
    we:=funktionswert(kk,1);
    if fehler<>0 then we:=0;
    ein_real:=we;
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
   if pos('.',ks)>0 then ks[pos('.',ks)]:=',';
   _strkomma:=ks;
end;

procedure TForm1.PB5D(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var xr,yr:integer;
begin
   xr:=round(malfxr(ein_real(e24)));
   yr:=round(malfyr(ein_real(e23)));
   if (abs(x-xr)<5) and (abs(y-yr)<5) then aktiv:=1;
end;

procedure TForm1.PB5U(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if aktiv>0 then
   begin
     aktiv:=0;
     pb5p(sender);
   end;
end;

procedure TForm1.PB5M(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var xr,yr:real;
begin
    xr:=round(malfxr(ein_real(e24)));
    yr:=round(malfyr(ein_real(e23)));
    if (abs(x-xr)<5) and (abs(y-yr)<5)
      then paintbox1.cursor:=crhandpoint
      else paintbox1.cursor:=crdefault;

    if aktiv=1 then
    begin
      xa:=(x-_x)/fx;
      e24.text:=_strkomma(xa,1,5);
      xa:=-(y-_y)/fy;
      e23.text:=_strkomma(xa,1,5);
      pb5p(sender);
    end;
end;

procedure TForm1.S36C(Sender: TObject);
begin
    c10:=not c10;
    pb5p(sender);
end;

procedure TForm1.S42Click(Sender: TObject);
begin
   if timer1.interval>0 then timer1.interval:=timer1.interval+1;
end;

procedure TForm1.S21Click(Sender: TObject);
begin
   if timer1.interval>1 then timer1.interval:=timer1.interval-1;
end;

procedure TForm1.S1Click(Sender: TObject);
begin
   c10m:=not c10m;
   pb5p(sender);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    _x1:=-5;
    _x2:=5;
    _y1:=-4;
    _y2:=4;
end;

procedure TForm1.PB5P(Sender: TObject);
var bitmap: TBitmap;
    myrect,birect:trect;
begin
   Bitmap := TBitmap.Create;
   Bitmap.Width := paintbox1.Width;
   Bitmap.Height := paintbox1.Height;
   birect.left:=1;
   birect.right:=paintbox1.width;
   birect.top:=1;
   birect.bottom:=paintbox1.height;
   myrect:=birect;
   try
     paintbox5paintx(bitmap.canvas);
     paintbox1.canvas.CopyRect(biRect,bitmap.Canvas, MyRect);
   finally
     Bitmap.Free;
   end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    ldatei.free;
end;

procedure TForm1.PaintBox5Paintx(can:tcanvas);
var ra:real;
begin
    p:=ein_real(EditP);
    lclear;
    lwriteln('#F');
    lwriteln(' ');
    if not _polar then
    begin
      f[6]:=Edit1.text;
      f[7]:=Edit2.text;
      lwriteln('#i');
    end
    else
    begin
      f[8]:=Edit1.text;
      lwriteln('#p');
    end;
    lwriteln(' ');
    lwritelnreal(ein_real(EditA));
    lwritelnreal(ein_real(EditE));
    lwritelnreal(0.01);
    lwritelnint(0);
    lwritelnint(1);
    lwritelnreal(ein_real(EditA));
    lwritelnreal(ein_real(EditE));
    ra:=ein_real(e24);
    lwritelnreal(ra);
    ra:=ein_real(e23);
    lwritelnreal(ra);
    ra:=ein_real(e22);
    if ra<=0 then ra:=1;
    lwritelnreal(ra);

    can.font.name:='Verdana';
    can.font.size:=9;
    farbig:=true;
    graphikinitialisieren(paintbox1.width,paintbox1.height,ufaktor*6,-ufaktor*6,ufaktor*8,-ufaktor*8);
    setbkmode(can.handle,transparent);
    fgraph.koordinatensystem(can);
    fgraph.zeichnen(can);
    graphikschliessen;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var r:real;
begin
    case combobox1.itemindex of
      1 : begin
          r:=ein_real(e22);
          r:=r+rx12.value;
          if (malfxr(ein_real(e24)+r)>paintbox1.width) then
            rx12.value:=-rx12.value;
          if r<=0.1 then
          begin
            rx12.value:=-rx12.value;
            r:=0.1;
          end;
          E22.text:=_strkomma(r,1,2);
        end;
      2 : begin
          r:=ein_real(e24);
          r:=r+rx12.value;
          if (malfx(r)>paintbox1.width) or (malfx(r)<0) then
            rx12.value:=-rx12.value;
          E24.text:=_strkomma(r,1,2);
        end;
      3 : begin
          r:=ein_real(e23);
          r:=r+rx12.value;
          if (malfy(r)>paintbox1.height) or (malfy(r)<0) then
            rx12.value:=-rx12.value;
          E23.text:=_strkomma(r,1,2);
        end;
      else begin
          p:=p+rx12.value;
          if abs(p)>10 then rx12.value:=-rx12.value;
          EditP.text:=_strkomma(p,1,2);
        end;
    end;
    pb5p(sender);
end;

procedure TForm1.S3Click(Sender: TObject);
begin
    ufaktor:=ufaktor/1.1;
    pb5p(sender);
end;

procedure TForm1.S4Click(Sender: TObject);
begin
    ufaktor:=1;
    pb5p(sender);
end;

procedure TForm1.S5Click(Sender: TObject);
begin
    ufaktor:=ufaktor*1.1;
    pb5p(sender);
end;

end.

