unit uuhr;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  clipbrd,
  Menus,
  ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    Ende1: TMenuItem;
    Einstellungen1: TMenuItem;
    zweiteUhr1: TMenuItem;
    mathematischeRichtung1: TMenuItem;
    Datei1: TMenuItem;
    N1: TMenuItem;
    Kopieren1: TMenuItem;
    RadioButton3: TRadioButton;
    Zeitbezeichnungen1: TMenuItem;
    se_grundzahl: TEdit;
    UpDown1: TUpDown;
    se_tagstunden: TEdit;
    UpDown2: TUpDown;
    se_laenge: TEdit;
    UpDown3: TUpDown;
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1Paintwmf(bcanvas:tcanvas; Sender: TObject);
    procedure kopieren1Click(Sender: TObject);
    procedure Ende1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure zweiteUhr1Click(Sender: TObject);
    procedure mathematischeRichtung1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Zeitbezeichnungen1Click(Sender: TObject);
  private
    zweiuhren:boolean;
    sommerzeit:boolean;
    richtung:integer;
    nullwinkel:real;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function Rechts(s : string; const Anzahl : integer) : string;
begin
	if Length(s)<Anzahl then
  	Result := s
  else
  	Result := Copy(s,Length(s)-Anzahl+1,255);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var hauptbitmap: tbitmap;
begin
    hauptbitmap := tbitmap.create;
    hauptbitmap.width := paintbox1.width;
    hauptbitmap.height := paintbox1.height;
    paintbox1paintwmf(hauptbitmap.canvas,sender);
    paintbox1.canvas.draw(0,0,hauptbitmap);
    hauptbitmap.free;
end;

procedure TForm1.PaintBox1Paintwmf(bcanvas:tcanvas; Sender: TObject);
var
  Hour, Min, Sec, MSec: Word;
  h, m, s, sek,
    stunden_x, stunden_y, minuten_x, minuten_y, sekunden_x, sekunden_y,
    x_mitte, y_mitte,
    radius,
    grundzahl, Anzstunden, Teiler,
    stundenLaenge, MinSekLaenge: integer;
  k1, k2: string;
  linien_x, linien_y,
    jd, mitmilli : real;
  weltzeit : tdatetime;

  procedure line(a, b, c, d: integer);
  begin
    bcanvas.moveto(a, b);
    bcanvas.lineto(c, d)
  end;

procedure uhrzeichnen(x_mitte:integer);
var i:integer;
begin
  h := sek div (grundzahl * grundzahl);
  m := (sek mod (grundzahl * grundzahl)) div (grundzahl);
  s := sek mod grundzahl;

  str(h+1000, k1);
  k1 := rechts(k1,StundenLaenge);
  k2 := k1 + ':';
  str(m+1000, k1);
  k1 := rechts(k1,MinSekLaenge);
  k2 := k2 + k1 + ':';
  str(s+1000, k1);
  k1 := rechts(k1,MinSekLaenge);
  k2 := k2 + k1;

  bcanvas.Ellipse(x_mitte - radius - 2, y_mitte - radius - 2,
    x_mitte + radius + 3, y_mitte + radius + 3);
  bcanvas.brush.style := bsclear;
  bcanvas.textout(x_mitte - (bcanvas.textwidth(k2) div 2), y_mitte - 100, k2);

  bcanvas.font.color := cldkgray;
  str(hour, k1);
  if length(k1) = 1 then
    k1 := '0' + k1;
  k2 := k1 + ':';
  str(min, k1);
  if length(k1) = 1 then
    k1 := '0' + k1;
  k2 := k2 + k1 + ':';
  str(sec, k1);
  if length(k1) = 1 then
    k1 := '0' + k1;
  k2 := k2 + k1;
  bcanvas.textout(x_mitte - (bcanvas.textwidth(k2) div 2), y_mitte + 90, k2);
  bcanvas.font.size := 16;
  bcanvas.font.style := [fsbold];
  bcanvas.font.color := clred;

  bcanvas.pen.color := $00000080;
  for i := 0 to Grundzahl - 1 do
  begin
    linien_x := sin(i * 2 * pi / (Grundzahl) + nullwinkel) * radius;
    linien_y := cos(i * 2 * pi / (Grundzahl) + nullwinkel) * radius;
    line(x_mitte + round(linien_x * 0.95), y_mitte - richtung*round(linien_y * 0.95),
        x_mitte + round(linien_x), y_mitte - richtung*round(linien_y));

  end;
  for i := 0 to AnzStunden - 1 do
  begin
    linien_x := sin(i * 2 * pi / (AnzStunden) + nullwinkel) * radius;
    linien_y := cos(i * 2 * pi / (AnzStunden) + nullwinkel) * radius;
    if i mod Teiler = 0 then
    begin
      line(x_mitte + round(linien_x * 0.8), y_mitte - richtung*round(linien_y * 0.8),
        x_mitte + round(linien_x), y_mitte - richtung*round(linien_y));
      k2 := inttostr(AnzStunden-i);
      bcanvas.textout(x_mitte + round(linien_x * 0.72) - (bcanvas.TextWidth(k2) div 2),
        y_mitte - richtung*round(linien_y * 0.72) - (bcanvas.TextHeight(k2) div 2), k2);
    end
    else
    begin
//      line(x_mitte + round(linien_x * 0.95), y_mitte - round(linien_y * 0.95),
//        x_mitte + round(linien_x), y_mitte - round(linien_y));
    end;
  end;

  stunden_x := round(sin(h * 2 / AnzStunden * pi + m * 2 /anzstunden * pi / grundzahl + nullwinkel) * 0.6 * radius);
  stunden_y := round(cos(h * 2 / AnzStunden * pi + m * 2 /anzstunden * pi / grundzahl + nullwinkel) * 0.6 * radius);
  minuten_x := round(sin(m * 2 / grundzahl * pi + s * 2 / grundzahl * pi / grundzahl + nullwinkel) * radius);
  minuten_y := round(cos(m * 2 / grundzahl * pi + s * 2 / grundzahl * pi / grundzahl + nullwinkel) * radius);

  mitmilli := anzstunden * grundzahl / 3600 / 24 * (integer(sec)
    + integer(msec) / 1000 + 60.0 * integer(min) + 3600.0 * integer(hour));
  mitmilli:=grundzahl*frac(mitmilli);
  sekunden_x := round(sin(mitmilli * 2 /grundzahl * pi + nullwinkel) * radius);
  sekunden_y := round(cos(mitmilli * 2 /grundzahl * pi + nullwinkel) * radius);

  bcanvas.Pen.color := $00FF0000;
  bcanvas.pen.width := 3;
  line(x_mitte, y_mitte, x_mitte + stunden_x, y_mitte + richtung*stunden_y);
  line(x_mitte, y_mitte, x_mitte + minuten_x, y_mitte + richtung*minuten_y);
  bcanvas.pen.width := 1;
  line(x_mitte, y_mitte, x_mitte + sekunden_x, y_mitte + richtung*sekunden_y);
  bcanvas.brush.color := clblue;
  bcanvas.Ellipse(x_mitte - 7, y_mitte - 7, x_mitte + 8, y_mitte + 8);
end;

  function julian_date(date:TDateTime):extended;
  begin
    julian_date:=2451544.5-EncodeDate(2000,1,1)+date;
  end;

  function sternzeit(geo_laenge,uhrzeit,jd:real):real;
  var zco,st:real;
  begin
    zco:=6.6973745583+0.06570982442*(jd-2451545.0)+ 1.938587419e-14*sqr(jd-2451545.0);
    st:=zco+geo_laenge/15+1.00273790935*uhrzeit;
    while st<0 do st:=st+24;
    while st>24 do st:=st-24;
    sternzeit:=st/24;
  end;

  function ein_int(const edit:tedit;a,b:integer):integer;
  var kk:string;
      x,code:integer;
  begin
      kk:=edit.text;
      val(kk,x,code);
      if x<a then x:=a;
      if x>b then x:=b;
      edit.text:=inttostr(x);
      ein_int:=x;
  end;
//Hauptroutine
begin
  grundzahl := ein_int(se_grundzahl,1,200);
  Anzstunden := ein_int(se_tagstunden,1,200);

  if AnzStunden>100 then
  	StundenLaenge := 3
  else
  	Stundenlaenge := 2;

  if Grundzahl>100 then
  	MinSekLaenge := 3
  else
  	MinSekLaenge := 2;

  case AnzStunden of
    61..100: Teiler := 5;
    31..60: Teiler := 2;
    1..30: Teiler := 1;
  else
    Teiler := 10;
  end;

  bcanvas.font.name := 'Verdana';
  bcanvas.font.color := clblack;
  bcanvas.font.size := 18;
  bcanvas.font.style := [fsbold];

  bcanvas.brush.color:=clwhite;
  bcanvas.rectangle(-1,-1,paintbox1.width+1,paintbox1.height+1);

  bcanvas.brush.color:=clwhite;

  DecodeTime(Time, Hour, Min, Sec, MSec);
  sek := trunc(anzstunden * grundzahl * grundzahl / 3600 / 24 * (integer(sec)
    + integer(msec) / 1000 + 60.0 * integer(min) + 3600.0 * integer(hour)));

  if zweiuhren then
    x_mitte := paintbox1.width div 4
  else
    x_mitte := paintbox1.width div 2;
  y_mitte := paintbox1.height div 2;
  radius := y_mitte - 20;
  if radius > x_mitte - 20 then radius := x_mitte - 20;

  //Hauptuhr
  uhrzeichnen(x_mitte);

  if zweiuhren then
  begin
    bcanvas.font.color := clblack;
    bcanvas.font.size := 18;
    bcanvas.font.style := [fsbold];
    bcanvas.brush.color:=clwhite;

    //Weltzeit
    if sommerzeit then
      weltzeit:=time-2/24
      else
      weltzeit:=time-1/24;
    //Sternzeit
    if radiobutton2.checked then
    begin
      jd:=julian_date(date);
      weltzeit:=sternzeit(ein_int(se_laenge,-180,180),24*weltzeit,jd);
    end;
    //Ortszeit
    if radiobutton3.checked then
    begin
      weltzeit:=time+(ein_int(se_laenge,-180,180)-15)/24/15;
    end;

    DecodeTime(weltzeit, Hour, Min, Sec, MSec);
    sek := trunc(anzstunden * grundzahl * grundzahl / 3600 / 24 * (integer(sec)
      + integer(msec) / 1000 + 60.0 * integer(min) + 3600.0 * integer(hour)));

    x_mitte := 3*paintbox1.width div 4;
    y_mitte := paintbox1.height div 2;

    uhrzeichnen(x_mitte);

    bcanvas.brush.style:=bsclear;
    k2:='MWZ';
    if radiobutton2.checked then k2:='MSZ';
    if radiobutton3.checked then k2:='MOZ';
    if Zeitbezeichnungen1.checked then bcanvas.textout(paintbox1.width-20-bcanvas.textwidth(k2), 20, k2);
  end;

    bcanvas.brush.style:=bsclear;
    k2:='MMEZ';
    if sommerzeit then k2:='MMESZ';
    if Zeitbezeichnungen1.checked then bcanvas.textout(20, 20, k2);
end;

procedure TForm1.kopieren1Click(Sender: TObject);
var mymetafile:tmetafile;
    can:tmetafilecanvas;
    aformat:word;
    adata:thandle;
    apalette:hpalette;
begin
    MyMetafile := TMetafile.Create;
    mymetafile.enhanced:=false;
    mymetafile.height:=paintbox1.height;
    mymetafile.width:=paintbox1.width;

    can:=TMetafileCanvas.Create(MyMetafile, 0);
    can.font.name:='Verdana';
    can.font.size:=10;
    can.brush.color:=clwhite;
    can.Rectangle(-1,-1,paintbox1.width+2,paintbox1.height+2);
    can.brush.style:=bsclear;

    paintbox1paintwmf(can,sender);
    can.Free;

    mymetafile.savetoclipboardformat(aformat,adata,apalette);
    ClipBoard.SetAsHandle(aFormat,AData);
    mymetafile.free;
end;

procedure TForm1.Ende1Click(Sender: TObject);
begin
    close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    zweiuhren:=true;
    richtung:=1;
    nullwinkel:=pi/2;
end;

procedure TForm1.zweiteUhr1Click(Sender: TObject);
begin
    zweiteuhr1.checked:=not zweiteuhr1.checked;
    zweiuhren:=zweiteuhr1.checked;
    if zweiuhren then form1.width:=956
                 else form1.width:=488
end;

procedure TForm1.mathematischeRichtung1Click(Sender: TObject);
begin
    mathematischerichtung1.checked:=not mathematischerichtung1.checked;
    richtung:=-1*richtung;
end;

procedure TForm1.FormActivate(Sender: TObject);

  function xsommerzeit:boolean;
  var wochentag:word;
      letztersonntag:integer;
      day,month,year:word;
    function schalt(jahr:integer):boolean;
    begin
      schalt:=(jahr mod 4=0) and ((jahr mod 100 <>0) or (jahr mod 400=0))
    end;
    function neujahrstag(jahr:integer):integer;
    begin
      neujahrstag:=(jahr+(jahr-1) div 4-(jahr-1) div 100+(jahr-1) div 400)mod 7
    end;
    function tag(ist:boolean;monat:integer):integer;
    var i,tage:integer;
    begin
      tage:=0;
      i:=1;
      while i<monat do
      begin
        case i of
        1,3,5,7,8,10 : inc(tage,31);
        4,6,9,11     : inc(tage,30);
                   2 : if ist then inc(tage,29) else inc(tage,28)
        end;
        inc(i);
      end;
      tag:=tage;
    end;
  begin
    xsommerzeit:=false;
    decodedate(now,year,month,day);
    if year>=1980 then
    begin
      if (month=3) or (month=10) then
      begin
        letztersonntag:=31;
        repeat
          wochentag:=(neujahrstag(year)+tag(schalt(year),month)+letztersonntag) mod 7;
          dec(letztersonntag);
        until wochentag=1;
        inc(letztersonntag);
        if (month=3) and (day>=letztersonntag) then xsommerzeit:=true;
        if (month=10) and (day<letztersonntag) then xsommerzeit:=true;
      end;
      if month in [4..9] then xsommerzeit:=true;
    end;
  end;
begin
    sommerzeit:=xsommerzeit;
end;

procedure TForm1.Zeitbezeichnungen1Click(Sender: TObject);
begin
    Zeitbezeichnungen1.checked:=not Zeitbezeichnungen1.checked;
end;

end.

