unit uterminator;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  terdpunkt = record br,la:double; modus:integer end;

  TFTerminator = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BDarstellung: TButton;
    BSimulation: TButton;
    BAktuell: TButton;
    ETag: TEdit;
    EMonat: TEdit;
    EStunden: TEdit;
    EMinuten: TEdit;
    RMinute: TRadioButton;
    RTag: TRadioButton;
    CSommerzeit: TCheckBox;
    CSonnenOrt: TCheckBox;
    CAktuell: TCheckBox;
    CGradNetz: TCheckBox;
    Paintbox1: TPaintBox;
    Timer2: TTimer;
    Timer1: TTimer;
    procedure CAktuellClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CGradNetzClick(Sender: TObject);
    procedure BDarstellungClick(Sender: TObject);
    procedure BSimulationClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BAktuellClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    tagbitmap:tbitmap;
    erdanzahl:integer;
    erdpunkt:array of terdpunkt;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FTerminator: TFTerminator;

implementation

uses math;
const pino = pi/180;
{$R *.dfm}

procedure TFTerminator.CAktuellClick(Sender: TObject);
begin
  timer2.enabled:=CAktuell.checked;
end;

procedure TFTerminator.Timer2Timer(Sender: TObject);
var st,mi,se,ms:word;
    ja,ta,mo:word;
begin
  decodetime(time,st,mi,se,ms);
  EStunden.text:=inttostr(st);
  EMinuten.text:=inttostr(mi);
  decodedate(date,ja,mo,ta);
  ETag.text:=inttostr(ta);
  EMonat.text:=inttostr(mo);
  BDarstellungClick(sender);
end;

procedure TFTerminator.CGradNetzClick(Sender: TObject);
begin
  if tagbitmap<>nil then tagBitmap.free;
  tagbitmap:=nil;
  BDarstellungClick(sender);
end;

function ein_int(const edit:tedit):integer;
var kk:string;
    x:integer;
    code:integer;
begin
  kk:=edit.text;
  val(kk,x,code);
  if code<>0 then ein_int:=0
             else ein_int:=x;
end;

function neu(jahr:integer):integer;
begin
  neu:=(jahr+(jahr-1) div 4-(jahr-1) div 100+(jahr-1) div 400)mod 7
end;

function schalt(jahr:integer):boolean;
begin
  schalt:=(jahr mod 4=0) and ((jahr mod 100 <>0) or (jahr mod 400=0))
end;

function tag(ist:boolean;monat:integer):integer;
var i,tage:integer;
begin
  tage:=0;
  i:=1;
  while i<monat do begin
    case i of
    1,3,5,7,8,10 : inc(tage,31);
    4,6,9,11     : inc(tage,30);
               2 : if ist then inc(tage,29)
                          else inc(tage,28)
    end;
    inc(i);
  end;
  tag:=tage;
end;

function sommerzeit(d,m,y:integer):boolean;
var wd:integer;
    xt:longint;
begin
  sommerzeit:=false;
  if (m=3) or (m=10) then begin
    xt:=31;
    repeat
      wd:=(neu(y)+tag(schalt(y),m)+xt) mod 7;
      dec(xt);
    until wd=1;
    inc(xt);
    if (m=3) and (d>=xt) then sommerzeit:=true;
    if (m=10) and (d<xt) then sommerzeit:=true;
  end;
  if m in [4..9] then sommerzeit:=true;
end;

function Schaltjahr(const word_Jahr : Word) : Boolean;
var JahrIstSchaltjahr : Boolean;
Begin
  JahrIstSchaltjahr := ( (word_Jahr mod 4 = 0) and not (word_Jahr mod 100 = 0) ) or (word_Jahr mod 400 = 0);
  Schaltjahr := JahrIstSchaltjahr;
end;

FUNCTION Kalendertag(const tag, monat : byte; const jahr : word) : Word;
CONST
     TageProMonat : ARRAY[1..11] OF Byte =(31,28,31,30,31,30,31,31,30,31,30);
VAR
   counter : Byte; GesamtTage : Word;
BEGIN
  GesamtTage:=0;
  FOR counter := 1 TO (monat-1) DO GesamtTage := GesamtTage + TageProMonat[counter];
  GesamtTage := GesamtTage + tag;
  IF Schaltjahr(jahr) AND (monat > 2) THEN Inc(GesamtTage);
  Kalendertag := GesamtTage;
END;

procedure TFTerminator.BDarstellungClick(Sender: TObject);
var bitmap,bitmap2:tbitmap;
    m,b,b2,h2,h,modus,zold,i,datennr:integer;
    ys,zs,zt,y,z,fak,fakh,yold:double;
    br,la:double;
    year,month,day:word;
var tag,monat,dagnr:integer;
    zonetid_time,zonetid_min : integer;
    bb,tidsek,soltid,tidsmeridianenslaengdegrad,timevinklen:double;
    dek_rad:double;
    bahn:array[0..1300] of tpoint;

  function winkel2(laengdegrad:double):double;
  begin
    soltid:=zonetid_time+zonetid_min/60+tidsek/60+(4*(tidsmeridianenslaengdegrad+laengdegrad))/60;
    timevinklen:=15*(soltid-12);
    winkel2:=arctan(-cos(timevinklen*pino)/tan(dek_rad))/pino;
  end;

begin
  b:= paintbox1.Width;
  b2:=b div 2;
  h:= paintbox1.Height;
  h2:=h div 2;
  fak:=b/360;
  fakh:=h/160;
  if tagbitmap=nil then begin
    tagBitmap := TBitmap.Create;
    tagbitmap.pixelformat:=pf32bit;
    tagBitmap.Width := paintbox1.Width;
    tagBitmap.Height := paintbox1.Height;

    if CGradNetz.checked then begin
      tagbitmap.canvas.font.name:='Verdana';
      tagbitmap.canvas.font.size:=10;
      tagbitmap.canvas.pen.color:=clltgray;
      tagbitmap.canvas.font.color:=clred;
      for i:=-5 to 5 do begin
        y:=fak*i*30;
        tagbitmap.canvas.moveto(round(y+b2),0);
        tagbitmap.canvas.lineto(round(y+b2),h);
        tagbitmap.canvas.textout(round(y+b2)+2,h-25,inttostr(i*30)+'°');
      end;
      for i:=-3 to 3 do begin
        z:=-fakh*i*30;
        tagbitmap.canvas.moveto(0,round(z+h2));
        tagbitmap.canvas.lineto(b,round(z+h2));
        tagbitmap.canvas.textout(2,round(z+h2)+2,inttostr(i*30)+'°');
      end;
    end;
    tagbitmap.canvas.pen.color:=clblue;
    yold:=0;
    datennr:=0;
    repeat
      br:=erdpunkt[datennr].br;
      la:=erdpunkt[datennr].la;
      modus:=erdpunkt[datennr].modus;
      inc(datennr);
      if la>180 then la:=la-360;
      y:=fak*la;
      z:=-fakh*br;
      if (modus=0) then begin
        yold:=y;
        zold:=round(z);
        tagbitmap.canvas.moveto(round(yold+b2),zold+h2);
      end else begin
        if abs(y-yold)<100 then begin
          yold:=y;
          tagbitmap.canvas.lineto(round(y+b2),round(z+h2));
        end else begin
          yold:=y;
          tagbitmap.canvas.moveto(round(y+b2),round(z+h2));
        end;
      end;
    until datennr>erdanzahl;
    tagbitmap.canvas.brush.color:=clblack;
    tagbitmap.canvas.pen.color:=clblack;
  end;

  Bitmap := TBitmap.Create;
  bitmap.pixelformat:=pf32bit;
  Bitmap.Width := paintbox1.Width;
  Bitmap.Height := paintbox1.Height;
  bitmap.canvas.draw(0,0,tagbitmap);
  tag:=ein_int(ETag);
  monat:=ein_int(EMonat);
  decodedate(now,year,month,day);
  dagnr:=kalendertag(tag,monat,year);
  zonetid_time:=ein_int(EStunden);
  zonetid_min:=ein_int(EMinuten);
  if CSommerzeit.checked then
    if sommerzeit(tag,monat,year) then zonetid_time:=zonetid_time-1;
  tidsmeridianenslaengdegrad:=-15;//-laengdegrad/15;//-1;//
  Bb:=(dagnr+zonetid_time/24-1)*360/365*pino;
  tidsek:=229.2*(0.000075-(-0.001868*cos(bB))-0.030277*sin(bB)-0.014615*cos(2*bB)-0.04089*sin(2*bB));
  dek_rad:=23.44*sin((284-(-dagnr-zonetid_time/24))*360/365*pino)*pino;
  Bitmap2 := TBitmap.Create;
  bitmap2.pixelformat:=pf32bit;
  Bitmap2.Width := paintbox1.Width+101;
  Bitmap2.Height := paintbox1.Height+101;
  bitmap2.canvas.pen.color:=clblack;
  bitmap2.canvas.Brush.color:=clwhite;
  bitmap2.canvas.rectangle(-1,-1,bitmap2.width+101,bitmap2.height+101);
  m:=-181;
  repeat
    y:=fak*m;
    z:=-fakh*winkel2(m);
    bahn[m+181].x:=round(y+b2+50);
    bahn[m+181].y:=round(z+h2+50);
    inc(m,1);
  until m>183;

  ys:=-15-(12-zonetid_time-zonetid_min/60)*15;
  if ys<-180 then ys:=ys+360;
  if ys>180 then ys:=ys-360;
  ys:=-fak*ys;
  zs:=-fakh*dek_rad/pino;
  zt:=-fakh*winkel2(ys/fak);
  bahn[m+181].x:=bitmap2.width;
  bahn[m+181].y:=round(y+h2+50);
  bahn[m+182].x:=bitmap2.width;
  bahn[m+183].x:=1;
  bahn[m+184].x:=1;
  bahn[m+184].y:=round(-fakh*winkel2(-181)+h2+50);
  if zs>zt then begin
    bahn[m+182].y:=1;
    bahn[m+183].y:=1;
  end else begin
    bahn[m+182].y:=bitmap2.height;
    bahn[m+183].y:=bitmap2.height;
  end;
  bitmap2.canvas.Brush.color:=$00f0f0f0;
  bitmap2.canvas.Polygon(slice(bahn,m+185));
  bitmap2.canvas.Brush.color:=clyellow;
  if CSonnenOrt.checked then bitmap2.canvas.ellipse(round(ys+b2+50-6),round(zs+h2+50-6),
                                                    round(ys+b2+50+7),round(zs+h2+50+7));
  bitmap.canvas.copyMode:=cmsrcand;
  bitmap.canvas.Draw(-50,-50,bitmap2);
  bitmap2.free;
  paintbox1.canvas.draw(0,0,bitmap);
  Bitmap.Free;
end;

procedure TFTerminator.BSimulationClick(Sender: TObject);
begin
  timer1.enabled:= not timer1.enabled;
  if timer1.enabled then begin
    CAktuell.checked:=false;
    BSimulation.caption:='Stopp'
  end
  else BSimulation.caption:='Simulation';
end;

procedure TFTerminator.Timer1Timer(Sender: TObject);
var ja,ta,mo,st,mi,se,hsec:word;
    jetzt:tdatetime;
begin
  ta:=ein_int(ETag);
  mo:=ein_int(EMonat);
  st:=ein_int(EStunden);
  mi:=ein_int(EMinuten);
  jetzt:=encodedate(2015,mo,ta)+st/24+mi/24/60;
  if RMinute.checked then jetzt:=jetzt+2/24/60
                     else jetzt:=jetzt+1;
  decodedate(jetzt,ja,mo,ta);
  decodetime(jetzt,st,mi,se,hsec);
  EMinuten.text:=inttostr(mi);
  EStunden.text:=inttostr(st);
  ETag.text:=inttostr(ta);
  EMonat.text:=inttostr(mo);
  BDarstellungClick(sender);
end;

procedure TFTerminator.BAktuellClick(Sender: TObject);
var st,mi,se,ms:word;
    ja,ta,mo:word;
begin
  decodetime(time,st,mi,se,ms);
  EStunden.text:=inttostr(st);
  EMinuten.text:=inttostr(mi);
  decodedate(date,ja,mo,ta);
  ETag.text:=inttostr(ta);
  EMonat.text:=inttostr(mo);
  BDarstellungClick(sender);
end;

procedure TFTerminator.FormShow(Sender: TObject);
var
    st,mi,se,ms:word;
    ja,ta,mo:word;
  procedure ortelesen;
  var datenliste:tstringlist;
      datennr:integer;
      datens:string;
  procedure split3ort(kk:string;var a,b:double;var c:integer);
  var code:integer;
  begin
    val(copy(kk,1,pos(' ',kk)-1),a,code);
    delete(kk,1,pos(' ',kk));
    val(copy(kk,1,pos(' ',kk)-1),b,code);
    delete(kk,1,pos(' ',kk));
    c:=strtoint(kk);
  end;
begin
  setlength(erdpunkt,32000);
  datenliste:=tstringlist.create;
  datenliste.LoadFromFile('erde2.000');
  datennr:=0;
  repeat
    datens:=datenliste[datennr];
    inc(datennr);
    split3ort(datens,erdpunkt[datennr].br,erdpunkt[datennr].la,erdpunkt[datennr].modus);
  until datennr>datenliste.count-1;
  datenliste.free;
  erdanzahl:=datennr-1;
end;
begin
  ortelesen;
  tagbitmap:=nil;
  decodetime(time,st,mi,se,ms);
  EStunden.text:=inttostr(st);
  EMinuten.text:=inttostr(mi);
  decodedate(date,ja,mo,ta);
  ETag.text:=inttostr(ta);
  EMonat.text:=inttostr(mo);
end;

procedure TFTerminator.FormDestroy(Sender: TObject);
begin
  tagbitmap.Free;
  setlength(erdpunkt,0);
end;

end.
