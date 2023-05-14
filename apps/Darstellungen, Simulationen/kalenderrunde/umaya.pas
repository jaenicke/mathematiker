unit umaya;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    L51: TLabel;
    L92: TLabel;
    L101: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit10: TEdit;
    btagplus: TButton;
    btagminus: TButton;
    bdatum: TButton;
    bsimula: TButton;
    i4: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure bsimulaClick(Sender: TObject);
    procedure btagplusClick(Sender: TObject);
    procedure bdatumClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
var
    m_jahr,m_monat,m_tag:word;
    m_z,m_n,m_h,m_p,m_hfest:integer;
    julian_offset,wi,wialt,superjd:real;
    hfont:thandle;

const vv:array[0..13] of integer =
         (0,2,4,6,8,10,12,1,3,5,7,9,11,0);
      pino = pi/180;
      pium = 180/pi;
      schriftinstall:boolean=false;
      nralt:integer=-1;

procedure fontlesen;
var ms1: TResourcestream;
    ms: TMemoryStream;
    cn: dword;
begin
  ms1 := TResourceStream.Create(hinstance,'TFONT','RT_RCDATA');
  try
    ms:= TMemoryStream.Create;
    try
      ms.CopyFrom(ms1, 0);
      hfont:=AddFontMemResourceEx(ms.Memory, ms.Size, nil, @cn);
    finally
      ms.Free;
    end;
  finally
    ms1.Free;
  end;
end;

function julian_date(date:TDateTime):extended;
begin
  julian_date:=julian_offset+date
end;

procedure tzolkin_(jd:extended;var z,n,h,p:integer);
var m:integer;
begin
    n:= trunc(jd) +136+1;
    m:= trunc(jd) + 65+1;
    z:= ((n - 1) mod 13) + 1;
    p:= m mod 365;
    h:= p mod 20;
    n:=n mod 20;
    p:=p div 20;
end;

procedure CanvasSetAngle(C: TCanvas; A: Single);
var LogRec: TLOGFONT;
begin
  GetObject(C.Font.Handle,sizeOf(LogRec),Addr(LogRec));
  LogRec.lfEscapement := Trunc(A*10);
  C.Font.Handle := CreateFontIndirect(LogRec);
end;

procedure TForm1.FormActivate(Sender: TObject);
var liste:tstringlist;
begin
    liste:=tstringlist.create;
    liste.Clear;
    liste.Sorted := True;
    liste.addstrings(Screen.Fonts);
    schriftinstall:=false;
    if liste.indexof('Mathe08c')<0 then begin
       fontlesen;
       schriftinstall:=true;
    end;
    liste.free;

    julian_offset:=2451544.5-EncodeDate(2000,1,1);
    decodedate(date,m_jahr,m_monat,m_tag);
    superjd:=julian_date(encodedate(m_jahr,m_monat,m_tag));
    tzolkin_(superjd,m_z,m_n,m_h,m_p);
    m_hfest:=m_h;
    wi:=-(2*pi*(vv[(m_z-m_n+26) mod 13])+2*pi/20*(m_n));
    wialt:=wi;
    edit3.text:=inttostr(m_tag);
    edit4.text:=inttostr(m_monat);
    edit10.text:=inttostr(m_jahr);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
const mayan_day : array[0..19] of string[8] =
     ('Imix','Ik','Akbal','Kan','Chicchan','Cimi','Manik','Lamat','Muluc','Oc',
      'Chuen','Eb','Ben','Ix','Men','Cib','Caban','Eznab','Cauac','Ahau');
      mayan_month : Array[0..19] of string[6] =
     ('Pop','Uo','Zip','Zotz','Tzec','Xul','Yaxkin','Mol','Chen','Yax','Zac',
      'Ceh','Mac','Kankin','Muan','Pax','Kayab','Cumku','Uayeb','');
var br,ho,i,start:integer;
    k:string;
    wa,se,ende:real;
    bitmap:tbitmap;
procedure zahnrad(xm,ym,r:real;za:integer;wi:real);
var i:integer;
    ww,piza,piza0,piza1:real;
    pu:array[0..600] of tpoint;
begin
    ww:=2/r;
    piza:=pi/za;
    for i:=0 to za-1 do
    begin
      piza0:=2*i*piza+wi;
      piza1:=(2*i+1)*piza+wi;
      pu[4*i].x:=round(xm+r*cos(piza0-ww));
      pu[4*i].y:=round(ym-r*sin(piza0-ww));
      pu[4*i+1].x:=round(xm+(r-10)*cos(piza0+ww));
      pu[4*i+1].y:=round(ym-(r-10)*sin(piza0+ww));
      pu[4*i+2].x:=round(xm+(r-10)*cos(piza1-ww));
      pu[4*i+2].y:=round(ym-(r-10)*sin(piza1-ww));
      pu[4*i+3].x:=round(xm+r*cos(piza1+ww));
      pu[4*i+3].y:=round(ym-r*sin(piza1+ww));
    end;
    bitmap.canvas.polygon(slice(pu,4*za));
end;
procedure zahnrad2(xm,ym,r:real;za:integer;wi:real);
var i,j,aa:integer;
    ww,o,l,piza,piza0,piza1:real;
    pu:array[0..600] of tpoint;
    px:tpoint;
begin
    ww:=2/r;
    aa:=0;
    piza:=pi/za;
    for i:=0 to za-1 do
    begin
      piza0:=2*i*piza+wi;
      piza1:=(2*i+1)*piza+wi;
      o:=ym-r*sin(piza0-ww);
      l:=xm+r*cos(piza0-ww);
      if (o>-250) and (o<paintbox1.height+250) and (l<paintbox1.width+100) then
      begin
        pu[4*aa].x:=round(xm+r*cos(piza0-ww));
        pu[4*aa].y:=round(ym-r*sin(piza0-ww));
        pu[4*aa+1].x:=round(xm+(r-10)*cos(piza0+ww));
        pu[4*aa+1].y:=round(ym-(r-10)*sin(piza0+ww));
        pu[4*aa+2].x:=round(xm+(r-10)*cos(piza1-ww));
        pu[4*aa+2].y:=round(ym-(r-10)*sin(piza1-ww));
        pu[4*aa+3].x:=round(xm+r*cos(piza1+ww));
        pu[4*aa+3].y:=round(ym-r*sin(piza1+ww));
        inc(aa);
      end;
    end;
    for i:=0 to 4*aa-2 do
    begin
      for j:=i+1 to 4*aa-1 do
      begin
        if pu[i].y>pu[j].y then
        begin
          px:=pu[i];
          pu[i]:=pu[j];
          pu[j]:=px
        end;
      end;
    end;
    pu[4*aa+1].x:=round(paintbox1.width+10);
    pu[4*aa+1].y:=round(-10);
    pu[4*aa].x:=round(paintbox1.width+10);
    pu[4*aa].y:=round(paintbox1.height+10);
    bitmap.canvas.polygon(slice(pu,4*aa+2));
end;

procedure haabausgabe(i:integer);
var p,h:integer;
procedure htzolkin;
var m:integer;
begin
  m:= trunc(superjd+i-start-1) + 65+1;
  p:= m mod 365;
  h:= p mod 20;
  p:= p div 20;
end;
begin
   htzolkin;
   bitmap.canvas.textout(round(wa),round(se+9),inttostr(h));
   if p<>nralt then begin
     i4.picture.bitmap.LoadFromResourceName(HInstance,'M_'+inttostr(p+1));
     nralt:=p;
   end;
   bitmap.canvas.copymode:=cmsrcand;
   bitmap.canvas.draw(round(wa+35),round(se),i4.picture.bitmap);
end;

function zeichen(nr:integer):char;
begin
    case nr of
       0 : zeichen:=chr(118);
   1..11 : zeichen:=chr(171-nr);
      else zeichen:=chr(138-nr);
    end;
end;

var pictun,baktun,katun,tun,uinal,kin:integer;

function maya_jd(jd:extended):string;
var m,n:integer;
begin
    m:= round(jd+0.1) - 584283;
    pictun:= n div 2880000;
    n:= m mod 2880000;
    baktun:=n div 144000;
    n:= m mod 144000;
    katun:= n div 7200;
    n:= m mod 7200;
    tun:= n div 360;
    n:= m mod 360;
    uinal:= n div 20;
    kin:= m mod 20;
    Maya_jd:=inttostr(baktun) +' Baktun '+ inttostr(katun) +' Katun '+ inttostr(tun)+
        ' Tun '+ inttostr(uinal) +' Uinal '+ inttostr(kin) +' Kin';
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox1.width;
    bitmap.height:=paintbox1.height;
    with bitmap.canvas do
    begin
      br:=paintbox1.width div 2+90;
      ho:=paintbox1.height div 2;
      brush.color:=$00ffffc0;
      zahnrad(br-240,ho,240,20,wi+pi/40);
      brush.color:=clwhite;
      zahnrad(br-240,ho,200,20,wi+pi/40);
      brush.color:=clyellow;
      ellipse(br-240-10,ho-10,br-240+11,ho+11);

      brush.color:=$00a0ffff;
      zahnrad(br-172,ho,130,13,wi*80/52+pi/26);
      brush.color:=clwhite;
      ellipse(br-172-90,ho-90,br-172+91,ho+91);
      brush.color:=$00a0ffff;
      ellipse(br-172-10,ho-10,br-172+11,ho+11);

      brush.color:=$00e0ffff;
      zahnrad2(br+240*17-8,ho,240*17,360,-wi/2-pi/80);
      brush.color:=clwhite;
      zahnrad2(br+240*17-8,ho,240*16+130,360,-wi/2-pi/80);

      brush.style:=bsclear;
      font.name:='Verdana';
      font.size:=12;
      font.style:=[fsbold];
      for i:=0 to 12 do
      begin
        k:=inttostr((12-i) mod 13+1);
        CanvasSetAngle(bitmap.canvas,-i*360/13+20/13*wi*pium);
        textout(round(br-172+(107-textwidth(k)/2)*cos(-pi/45+i*2*pi/13-80/52*wi)),
                    round(ho+(107-textwidth(k)/2)*sin(-pi/45+i*2*pi/13-80/52*wi)),k);
      end;
      CanvasSetAngle(bitmap.canvas,0);
      start:=trunc(pium*(-wialt/18-pi/80));
      for i:=start-7 to start+7 do
      begin
        wa:=br+240*17-3-(240*17-20)*cos(+wi/18+i*pino+pi/80);
        se:=ho-(240*17-20)*sin(+wi/18+i*pino+pi/80);
        if (se>-40) and (se<paintbox1.height+40) then
        begin
          haabausgabe(i);
        end;
      end;

      font.name:='Mathe08c';
      font.size:=24;
      font.style:=[];
      for i:=0 to 19 do
      begin
        CanvasSetAngle(bitmap.canvas,-i*18+wi*pium);
        k:=zeichen(i);
        textout(round(br-240+(220-textwidth(k)/2)*cos(-pi/30+i*pi/10-wi)),
                    round(ho+(220-textwidth(k)/2)*sin(-pi/30+i*pi/10-wi)),k);
      end;

      font.style:=[fsbold];
      brush.style:=bsclear;
      font.name:='Verdana';
      font.size:=16;
      k:='Tzolkin '+inttostr(m_z)+' '+mayan_day[m_n];
      textout(40,20,k);
      k:='Haab '+inttostr(m_hfest)+ ' '+mayan_month[m_p];
      textout(paintbox1.width-60-textwidth(k),20,k);
      k:=datetostr(encodedate(m_jahr,m_monat,m_tag));
      textout(paintbox1.width-60-textwidth(k),paintbox1.height-50,k);
      font.size:=14;
      textout(40,paintbox1.height-48,Maya_jd(superjd));

      font.name:='Mathe08c';
      font.size:=26;
      font.style:=[];
      k:=zeichen(baktun)+zeichen(katun)+zeichen(tun)+zeichen(uinal)+zeichen(kin);
      bitmap.canvas.textout(40,paintbox1.height-90,k);

{      ende:=encodedate(2012,12,21)-(encodedate(m_jahr,m_monat,m_tag)+time);
      if ende>=0 then begin
        font.name:='Verdana';
        font.color:=clred;
        font.size:=16;
        font.style:=[fsbold];
        k:='Noch '+inttostr(trunc(ende))+' Tage';
        bitmap.canvas.textout(paintbox1.width-130-textwidth(k) div 2,200,k);
        ende:=24*frac(ende);
        k:=inttostr(trunc(ende))+' Stunden';
        bitmap.canvas.textout(paintbox1.width-130-textwidth(k) div 2,230,k);
        ende:=60*frac(ende);
        k:=inttostr(trunc(ende))+' Minuten';
        bitmap.canvas.textout(paintbox1.width-130-textwidth(k) div 2,260,k);
        ende:=60*frac(ende);
        k:=inttostr(trunc(ende))+' Sekunden';
        bitmap.canvas.textout(paintbox1.width-130-textwidth(k) div 2,290,k);
        k:='J';
        font.name:='Wingdings';
        font.size:=32;
        bitmap.canvas.textout(paintbox1.width-130-textwidth(k) div 2,320,k);
      end;}
    end;
    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    btagplusclick(btagplus);
end;

procedure TForm1.bsimulaClick(Sender: TObject);
begin
    timer1.enabled:=not timer1.enabled;
    if timer1.enabled then bsimula.caption:='Stop'
                      else bsimula.caption:='Simulation';
end;

procedure TForm1.btagplusClick(Sender: TObject);
var vorzeichen,i:integer;
begin
    timer2.enabled:=false;
    if sender=tbutton(btagplus) then vorzeichen:=-1
                                else vorzeichen:=1;
    if (vorzeichen=1) and (m_jahr=1) and (m_monat=1) and (m_tag=1) then exit; 

    m_hfest:=m_h;
    wialt:=wi;
    for i:=1 to 8 do
    begin
      wi:=wi+vorzeichen*pi/80;
      paintbox1paint(sender);
    end;
    decodedate(encodedate(m_jahr,m_monat,m_tag)-vorzeichen,m_jahr,m_monat,m_tag);
    superjd:=julian_date(encodedate(m_jahr,m_monat,m_tag));
    tzolkin_(superjd,m_z,m_n,m_h,m_p);
    m_hfest:=m_h;
    wialt:=wi;
    edit3.text:=inttostr(m_tag);
    edit4.text:=inttostr(m_monat);
    edit10.text:=inttostr(m_jahr);
    paintbox1paint(sender);
    timer2.enabled:=true;
end;

procedure TForm1.bdatumClick(Sender: TObject);
procedure kalende2(var ta,mo,ja:word);
var sc:boolean;
begin
    if ja<1 then ja:=1;
    if mo>13 then begin mo:=12 end;
    if mo<=0 then begin mo:=1 end;
    while ((ta>31) and (mo in [1,3,5,7,8,10,12])) or
          ((ta>30) and (mo in [4,6,9,11])) do dec(ta);
    if mo=2 then
    begin
      sc:=(ja mod 4=0);
      if (ja mod 100=0) and not(ja mod 400=0) then sc:=not sc;
      while sc and (ta>29) do dec(ta);
      while not sc and (ta>28) do dec(ta);
    end;
end;
begin
    m_tag:=strtoint(edit3.text);
    m_monat:=strtoint(edit4.text);
    m_jahr:=strtoint(edit10.text);
    kalende2(m_tag,m_monat,m_jahr);
    edit3.text:=inttostr(m_tag);
    edit4.text:=inttostr(m_monat);
    edit10.text:=inttostr(m_jahr);

    superjd:=julian_date(encodedate(m_jahr,m_monat,m_tag));
    tzolkin_(superjd,m_z,m_n,m_h,m_p);
    m_hfest:=m_h;
    wi:=-(2*pi*(vv[(m_z-m_n+26) mod 13])+pi/10*(m_n));
    wialt:=wi;
    paintbox1paint(sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if schriftinstall then RemoveFontMemResourceEx(hfont);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
    if not timer1.enabled then paintbox1paint(sender);
end;

end.
