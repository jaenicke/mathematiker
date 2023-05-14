unit digger;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ToolWin, ComCtrls, Menus, StdCtrls, Buttons;

type
  Tfdigger = class(TForm)
    P2: TPanel;
    PB1: TPaintBox;
    MM1: TMainMenu;
    x1: TMenuItem;
    x5: TMenuItem;
    x7: TMenuItem;
    x6: TMenuItem;
    x3: TMenuItem;
    Timer1: TTimer;
    x4: TMenuItem;
    x2: TMenuItem;
    Zurcksetzen1: TMenuItem;
    NchsteStufe1: TMenuItem;
    Timer2: TTimer;
    procedure PB1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure x3Click(Sender: TObject);
    procedure x6Click(Sender: TObject);
    procedure x5Click(Sender: TObject);
    procedure x7Click(Sender: TObject);
    procedure test(a,b:integer;Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure stufeein(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure schluss(Sender: TObject);
    procedure w1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fdigger: Tfdigger;

implementation

const endstufe=31;
var feld : array[0..21,0..15] of char;
    bew  : array[0..21,0..15] of shortint;
    pics : array[4400..4410] of tbitmap;
    ax,ay,punkte,stufe,akort,punktmax,gesamtpunkte,leben:integer;
    zeit0:tdatetime;
    lebt,geschafft,endgeschafft:boolean;
{$R *.DFM}

procedure Tfdigger.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
    li,i,j:integer;
    k:string;
procedure xx(a,b:integer;c:char);
begin
    case c of
      'a' : begin
              bitmap.canvas.draw(a,b,pics[4400]);
              if geschafft then
              begin
                bitmap.canvas.pen.width:=3;
                bitmap.canvas.MoveTo(a+16-akort div 2,b+16-akort div 2);
                bitmap.canvas.LineTo(a+16+akort div 2,b+16-akort div 2);
                bitmap.canvas.LineTo(a+16+akort div 2,b+16+akort div 2);
                bitmap.canvas.LineTo(a+16-akort div 2,b+16+akort div 2);
                bitmap.canvas.LineTo(a+16-akort div 2,b+16-akort div 2);
              end;
            end;
      'x' : bitmap.canvas.draw(a,b,pics[4401]);
      'm' : bitmap.canvas.draw(a,b,pics[4402]);
      'd' : begin
              bitmap.canvas.draw(a,b,pics[4403]);
              bitmap.canvas.rectangle(a,b+32-akort,a+32,b+27-akort);
              bitmap.canvas.rectangle(a,b+32-((akort+16) mod 27),a+32,b+27-((akort+16) mod 27));
            end;
      'f' : bitmap.canvas.draw(a,b,pics[4404]);
      '.' : bitmap.canvas.draw(a,b,pics[4405]);
      'k' : bitmap.canvas.draw(a,b,pics[4406]);
      'o' : bitmap.canvas.draw(a,b,pics[4407]);
      'r' : bitmap.canvas.draw(a,b,pics[4407]);
      'p' : bitmap.canvas.draw(a,b,pics[4409]);
      'q' : bitmap.canvas.draw(a,b,pics[4409]);
      't' : bitmap.canvas.draw(a,b,pics[4408]);
      end;
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height+40;
    li:=(pb1.width-704) div 2;

    bitmap.canvas.brush.color:=clblack;
    bitmap.canvas.rectangle(29+li,80,674+li,532);
    for i:=1 to 20 do
      for j:=1 to 14 do
      begin
        xx(i*32+li,j*32+50,feld[i,j]);
      end;

    for i:=1 to leben do bitmap.canvas.draw(40+i*32,540,pics[4410]);

    bitmap.canvas.brush.color:=clwhite;
    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.style:=[fsbold,fsitalic];
    bitmap.canvas.font.color:=clnavy;
    bitmap.canvas.font.size:=12;
    bitmap.canvas.textout(70,580,'Diamanten '+inttostr(punktmax));
    bitmap.canvas.textout(480,580,'gesammelte Diamanten '+inttostr(punkte));

    bitmap.canvas.textout(70,50,'Spielstufe '+inttostr(stufe));
    if lebt then begin
       datetimetostring(k,'n:ss',zeit0-time);
       bitmap.canvas.textout(340,50,'Zeit '+k);
    end;
    bitmap.canvas.textout(600,50,'Punkte '+inttostr(gesamtpunkte));

    pb1.canvas.draw(0,-30,bitmap);
    bitmap.free;
    if punkte=punktmax then geschafft:=true;
end;

procedure Tfdigger.FormCreate(Sender: TObject);
var i:integer;
begin
    x5.shortcut:=shortcut(VK_LEFT,[]);
    x7.shortcut:=shortcut(VK_RIGHT,[]);
    x6.shortcut:=shortcut(VK_UP,[]);
    x3.shortcut:=shortcut(VK_DOWN,[]);
    for i:=4400 to 4410 do
    begin
      pics[i]:=tbitmap.create;
      pics[i].loadfromresourceid(hinstance,i);
    end;
    stufe:=1;
    akort:=0;
    gesamtpunkte:=0;
    leben:=5;
    zeit0:=now;
    stufeein(Sender);
end;

procedure Tfdigger.stufeein(Sender: TObject);
type
    tspielfeld = array[1..14] of string[20];
const
    s1 : tspielfeld
      = ('mmmmmmmmmammmmmmmmmm','mkkkkkkkkkkkkkkkkkkm',
         'k..................k','....................',
         'dd..x...............','dkd...ddd.ddd.ddd.dd',
         'dkd.d.dkd.dkd.dkd.d.','dkd.d.dkd.dkd.ddd.d.',
         'dkd.d.ddd.ddd.d...d.','dd..d...d...d.ddd.d.',
         '.......dd..dd.......','k..................k',
         'mkkkkkkkkkkkkkkkkkkm','mmmmmmmmmmmmmmmmmmmm');
    s2 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','md......kak.m....mdm',
         'm k.mmm.kkk.m....mdm','m ..mdm.kkk.m.mmmmdm',
         'm .dmdmm....d.m...dm','m .ddddmmmd...m..kdm',
         'mmmmmmdddmdmmmm...dm','mkkkk.dddmdmmdd..kdm',
         'mmkd. dmdmdmm.d..kdm','mkkdx mmdmdmm.d..kdm',
         'mmkd. mddmdmm.d..kdm','mkkd. mdd.k.ddd..kdm',
         'mmkd.kmdd.k.ddd...dm','mmmmmmmmmmmmmmmmmmmm');
    s3 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mx k .........   kkm',
         'mmmm ..mmmmkm.dddddm','m... ..mddmkm......m',
         'm.dkdk.mddmkm.   kkm','m..mdmmmddmkm.dddddm',
         'm..mdddmdddkm......m','m..mdmdmddmkm......m',
         'm..mddmmmmmkm......m','m..mmdddma.k.......m',
         'm...mmdm...mmmmm..km','m....mmm.........kkm',
         'm..  ....kkkdddddddm','mmmmmmmmmmmmmmmmmmmm');
    s4 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkkkkkkkkkkkkkmkkkkm',
         'm  ...........mkkkkm','m  ...........mffffm',
         'm  .mm.......k....xm','m  ....m.....d.d..am',
         'm  .......k....k.ddm','mf.................m',
         'm  mdmdmkddmmmmmmmmm','m  m mdmkddm      dm',
         'm  m mdmmdmm      dm','m    m mmdm       dm',
         'm      mmddddddddddm','mmmmmmmmmmmmmmmmmmmm');
    s5 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mdddddddmdkdkdkdkdkm',
         'm   o   m  o       m','mkkkkkkkm.........am',
         'mkkkkkkk...........m','mffffff.....kkkk...m',
         'm...........kdkd...m','m.......k...mmmm...m',
         'mkkkkk.kk......m..km','m....x..kkk...kmk.dm',
         'mmmmmm..k....ddmd..m','m..k.k..k...d..m..km',
         'mdk....kk..kkkkm..dm','mmmmmmmmmmmmmmmmmmmm');
    s6 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkmkdd.....mddd  d.m',
         'mx.....dmmdm... mm.m','m m m mmm..m    m..m',
         'm m m md k.m p  m.mm','m m m mm mmmmk..md.m',
         'mpm m mk mmmkmm mm m','m m m mmqm...dm am.m',
         'mdm m md mm  mm .m m','m.m m md.km  md dm.m',
         'mdm.mrmmmmm kmdkdm m','m.mdm  k.mm .mmmmm.m',
         'mdmdmdd.dmm d. . . m','mmmmmmmmmmmmmmmmmmmm');
    s7 : tspielfeld
      = ('mmmmmmmmmmammmmmmmmm','m.      o         dm',
         'mdmmmmmmmmmmmmmmmm.m','m.md............dmdm',
         'mdm.mmmmmmm.mmmm.m.m','m.m.m     r    m.mdm',
         'mdm.m mmmmmmmm m.m.m','m.m.m m  dd  m m.mdm',
         'mdm.m   m  m   m.m.m','m.m.mmmmmmmmmmmm.mdm',
         'mdmd............dm.m','m.mmmmmmmxmmmmmmmmdm',
         'md                .m','mmmmmmmmmmmmmmmmmmmm');
    s8 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkkkkkkkkddddmrrrram',
         'm.......fddddmrrrrrm','mp      kddddm rrrrm',
         'm.......fddddm     m','m.......kddddmk    m',
         'm.......mmmmmmkmmmmm','mpk  .........k....m',
         'mkk.... ......k....m','mkk.d.. ......k....m',
         'mkkddd. ......k....m','mkkkkk. ......k....m',
         'm.x....q...........m','mmmmmmmmmmmmmmmmmmmm');
    s9 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.............kk...m',
         'm.k.k.k.k.k........m','mk.k.k.k.k.k.......m',
         'mmmmmmmmmmmm .f....m','m.kkkkkkkkkkfm.....m',
         'm........... m.....m','m..........  m.....m',
         'm.........   m.....m','m........    m.....m',
         'm............m.....m','m..........kkmmmmm.m',
         'mx.................a','mmmmmmmmmmmmmmmmmmmm');
    s10 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m    .ddd...k.k.k.km',
         'mk.. .ddd. .k.k..k.m','mdk.  kdd...k.k..k.m',
         'mkk.  dmmm..k.k.k.km','mkk. dmm....k.k.k.km',
         'mmm  mmd...........m','mkm kdkdm          m',
         'mkm mmmmddmr  r   rm','mx  mddmddmm rr r  m',
         'mmmpmmdmdddm r rrr m','mm p mdmmmdmr  r  rm',
         'mmaaamdddddmr      m','mmmmmmmmmmmmmmmmmmmm');
    s11 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m..................m',
         'm..................m','m..................m',
         'm..................m','m..................m',
         'm..................m','m..................m',
         'm..................m','mrrrrrrrr     .k...m',
         'mrrrrrrrr      kk..m','mdddddddddddddd....m',
         'maddddddddddddd...xm','mmmmmmmmmmmmmmmmmmmm');
    s12 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.m.m.m.m.m.m.m.m.mm',
         'm.m.m.m. .m.m.m.m.am','m.m.m. . . .m.m.m. m',
         'm.m. . . . . .m. . m','m. . . .r. . . . . m',
         'm. . .r. .r. . . .rm','m. .r. . . .r. .r. m',
         'm.r. . . . . .r. . m','m. . . .m. . . . . m',
         'm. . .m.m.m. . . .mm','m. .m.m.m.m.m. .m.mm',
         'mxm.m.m.m.m.m.m.m.mm','mmmmmmmmmmmmmmmmmmmm');
    s13 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.kkkkkkkkk......mkm',
         'm................mkm','m................mkm',
         'mx.................m','m..k.k.k m.........m',
         'm....... m..m......m','m........m..m.  . .m',
         'm....k.k.m..mffffffm','m...........m      m',
         'm  r r      m      m','mmm    r    m      m',
         'mamd d.....dm      m','mmmmmmmmmmmmmmmmmmmm');
    s14 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.......mr         m',
         'mp     dmmm mmmm r m','m....m.mm      m   m',
         'm   pmrmmmm.mm mr  m','m....m mp    m m r m',
         'm  p m mdddddm m   m','m....m mpddddm mr  m',
         'm p  m mdddddm m r m','m....m mmmmmmm m   m',
         'mp   m         mr  m','m....mmmmmmmmmmm   m',
         'mx...ma            m','mmmmmmmmmmmmmmmmmmmm');
    s15 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkkkkkkkkkkkkkkkkkkm',
         'k..................k','..x.................',
         '.....mfffffffm......','m   rm       mr    m',
         'm  r mp      m r   m','m r  m p     m  r  m',
         'mr   m     p m   r m','m r  m   p   m    rm',
         'm.....ddddddd......m','m.....ddddddd......m',
         'mkkkkkkkkakkkkkkkkkm','mmmmmmmmmmmmmmmmmmmm');
    s16 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.kdkk..mkkm...k..dm',
         'm.kd....x..    .mmmm','m.kdmmk.  m    ..kdm',
         'm.kkkmk  km .....k.m','m..kdmm ..m...r  .km',
         'mmmmk. dkdmdm. r k.m','m...k.dkkkmdm.  r.km',
         'm.mmmmmmmmmmm. r k.m','mk.kkk k.dddkk.....m',
         'mfkk......d......k.m','md.dr     k   k.kdkm',
         'md kk.d..k.  a.kdkdm','mmmmmmmmmmmmmmmmmmmm');
    s17 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.kkkkkkkkrkkkkkkk.m',
         'm..................m','m..................m',
         'm.kkk.k..k.kk..kkk.m','m.k...kk.k.k.k.k...m',
         'm.kkx.kkkk.k.k.kka.m','m.k...k.kk.k.k.k...m',
         'm.kkk.k..k.kk..kkk.m','m..................m',
         'm..................m','m.ffffffffffffffff.m',
         'm..................m','mmmmmmmmmmmmmmmmmmmm');
    s18 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m..... mdm . mdddddm',
         'ma.... mdm .qddddddm','m..... .d. . mdddddm',
         'mkkkmm .d. . ......m','m.....qmdm . ......m',
         'm..... mmmq. ......m','m..... .d. mmmmmmmmm',
         'mmmmmm .d. ........m','mdddkm mdm mmddkkkkm',
         'mdddkm .d. mmmmmmmmm','mddddm .d. ........m',
         'mdddd. .d. .......xm','mmmmmmmmmmmmmmmmmmmm');
    s19 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m...kk.am  m..kk...m',
         'm.....mmm  mmm.....m','mddddddddr ddddddddm',
         'm.....mmm  mmm.....m','mmm.....m  m.....mmm',
         'm......k  r k......m','m....  kkkkkk  ....m',
         'm...  dmmddmmd  ...m','m..m mdmddddmdm m..m',
         'm..m md..dd..dm m..m','m..mrmd..dd..dmrm..m',
         'm..m .d......d. m.xm','mmmmmmmmmmmmmmmmmmmm');
    s20 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkkkmkkkm....akkkkkm',
         'm.x.mkkkm  r mkkkkkm','m. .mkkkm   rmmmdddm',
         'm. .mkkkm  r mdddddm','m. .mkkkm r  m.....m',
         'm...mmkmmr   m.d...m','m...............d..m',
         'm..ddd............dm','m.......k.k...d d..m',
         'm.......k.k......d.m','mmmmmmmmm.mmmmmmmmmm',
         'mp        dddddddddm','mmmmmmmmmmmmmmmmmmmm');
    s21 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m dm ..m..   dmkk.km',
         'mrmm m.m.m d .m..xkm','m    m.m.mr. .m..mmm',
         'mmmm.m...m    m....m','m.km.mmmmmmd  mkk.mm',
         'mkdm.dmd.dm.  m.k..m','mkkmm.m.mmmm  m ...m',
         'mdd     md m  mdk.mm','mm.mmmmmm. mammm..km',
         'm          mmm. k.km','m mmmmmm   m.k. mmmm',
         'm  ddmdr     k   p m','mmmmmmmmmmmmmmmmmmmm');
    s22 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m..... .q. .q. ....m',
         'm  r    d   d r    m','m..... .d. .d. ....m',
         'mddddddddd ddddddddm','m.....m.d.m.d.m....m',
         'm            r     m','m..... .da .d. ....m',
         'mddddddddd ddddddddm','m..... .d. .d. ....m',
         'm   r   d r d r    m','m.....m.d.m.d.m....m',
         'mx.... .d. .d. ....m','mmmmmmmmmmmmmmmmmmmm');
    s23 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkkkkkkkkkk..dkdk..m',
         'm..........mmmkm.k.m','m..........mrmkmr..m',
         'mxd.d.d.d..mmmkmdd.m','m.mfffm.m..mdmkmmm.m',
         'mrm   m.m. ........m','m.m   m.m. .d.k.d..m',
         'm.mmmmm.m. .d.k....m','m.mdddm.m. ...k....m',
         'm.mdddm.m.r.d.k....m','m.mdddm.mmmmm.k..kdm',
         'm......r.d..r.k..ddm','mmmmmmmmmmmmmmammmmm');
    s24 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mdkkkddk.kkkk..... m',
         'mdkkmdkkm...mkk.am m','mmmkk.mkdkm.k.m.kk m',
         'm kkmdkkmkkkm...mm m','mrmkkdm.k.m.k.m.kk m',
         'm dkmkdkm...m.k.mm m','mmm.dkmk..m...m.kk m',
         'm r.mkkkm...m...mm m','m m...m...mk..m.kk m',
         'm  .m...m...m.k... m','mmm...m...m...m... m',
         'mx.r  r  r         m','mmmmmmmmmmmmmmmmmmmm');
    s25 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mkkkkkm  .kkk..k.kam',
         'mkkkkkmr kkk...k...m','mkkkkkm  .....mmmmmm',
         'mkkkkkm......kkkkkkm','mfffffm...dr       m',
         'm........mmm.......m','mr     ddkkm  r    m',
         'm..........mr      m','mr       kkm    r  m',
         'm......d..kmmmmmmmmm','m..........m.k.k.k.m',
         'mx.........m..d.d.dm','mmmmmmmmmmmmmmmmmmmm');
    s26 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m.k.k.k.k.k.k.k.k.km',
         'mk.k.k.k.k.k.k.k.kkm','m.k.k.k.k.k.k.k.k.mm',
         'mk.k.k.k.k.k.k.k..mm','m.k.k.k.k.k.k.k...mm',
         'mk.k.k.k.k.k.k.mmmmm','m..................m',
         'm......m...........m','m......mm ......  rm',
         'm......mm mm.......m','mx.....mm mf.......m',
         'ma.....mm m........m','mmmmmmmmmmmmmmmmmmmm');
    s27 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mr r   . . . . . .dm',
         'mddddd m . . . . .dm','mmmmmm m . . . . .dm',
         'm      mo.o.o.o.o.dm','m mmmmmmmmmmmmmmmkdm',
         'm      mmadd....m..m','mmmmmm  mmmm....m..m',
         'm      mmddd.   m..m','m mmmmmmmmmm. r m..m',
         'm     xmdddd.   m..m','mmmmmm mmmmm. r m..m',
         'm      mdddd.   m..m','mmmmmmmmmmmmmmmmmmmm');
    s28 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mx dddd.....k k.k..m',
         'mmmmmmmmmmmmm mmmm d','............m m.....',
         '.k.k.k.k.k.kmom.....','............m m.....',
         '. ..........m m.....','. ..mmm.....mmm.....',
         '. ......   fffff   .','.q..ddd.m         m.',
         '. ..ddd.mm       mm.','. ..ddd.mmm     mmm.',
         'a ......mmmmp  mmmm.','mmmmmmmmmmmmmmmmmmmm');
    s29 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','m dddddddddddddddd m',
         'm mmmmmmmmmmmmmmmm m','m x....d....d..... m',
         'm .....d....dkkkkk m','m kkkkkd....dkmmmm m',
         'm mmmmkd....dkma..qm','m ..amkd....dkmmmm m',
         'm mmmmkd....dkkkkk m','m kkkkkd....d..... m',
         'm .....d....d..... m','mqmmmmmmmmmmmmmmmm m',
         'm dddddddddddddddd m','mmmmmmmmmmmmmmmmmmmm');
    s30 : tspielfeld
      = ('mmmmmmmmmmmmmmmmmmmm','mx.................m',
         'm. mmmm         r .m','m.            r   .m',
         'm.r          mmmm .m','mmmmmmm............m',
         'mdddddd............m','m............ddddddm',
         'm............mmmmmmm','m. mmmm          r.m',
         'm.    r           .m','m.  r        mmmm .m',
         'm.................am','mmmmmmmmmmmmmmmmmmmm');
         //o,q senkrecht
         //p waagercht
         //r alle Richtungen
procedure spielfeldsetzen(ss:tspielfeld;maxp,x,y:integer);
var i,j:integer;
begin
    for j:=1 to 14 do
      for i:=1 to 20 do feld[i,j]:=ss[j][i];
    punktmax:=maxp;
    ax:=x;
    ay:=y;
end;
begin
    Zurcksetzen1.caption:='Zurücksetzen';
    timer1.enabled:=true;
    if leben=0 then
    begin
      if gesamtpunkte<>0 then schluss(sender);
      stufe:=1;
      akort:=0;
      gesamtpunkte:=0;
      leben:=5;
    end;
    if endgeschafft then Zurcksetzen1.caption:='Zurücksetzen'
                    else dec(leben);
    fillchar(feld,sizeof(feld),#0);
    fillchar(bew,sizeof(bew),0);
    case stufe of
      1 : spielfeldsetzen(s1,60,5,5);
      2 : spielfeldsetzen(s2,53,5,10);
      3 : spielfeldsetzen(s3,42,2,2);
      4 : spielfeldsetzen(s4,36,19,5);
      5 : spielfeldsetzen(s28,15,2,2);
      6 : spielfeldsetzen(s29,40,3,4);
      7 : spielfeldsetzen(s30,0,2,2);
      8 : spielfeldsetzen(s5,20,6,10);
      9 : spielfeldsetzen(s6,20,2,3);
     10 : spielfeldsetzen(s7,18,10,12);
     11 : spielfeldsetzen(s8,26,3,13);
     12 : spielfeldsetzen(s9,11,2,13);
     13 : spielfeldsetzen(s10,30,2,10);
     14 : spielfeldsetzen(s11,27,19,13);
     15 : spielfeldsetzen(s18,27,19,13);
     16 : spielfeldsetzen(s19,30,19,13);
     17 : spielfeldsetzen(s22,50,2,13);
     18 : spielfeldsetzen(s12,0,2,13);
     19 : spielfeldsetzen(s13,12,2,5);
     20 : spielfeldsetzen(s14,10,2,13);
     21 : spielfeldsetzen(s15,22,3,4);
     22 : spielfeldsetzen(s16,22,9,3);
     23 : spielfeldsetzen(s20,20,3,3);
     24 : spielfeldsetzen(s21,12,18,3);
     25 : spielfeldsetzen(s23,31,2,5);
     26 : spielfeldsetzen(s24,9,2,13);
     27 : spielfeldsetzen(s25,27,2,13);
     28 : spielfeldsetzen(s26,20,2,12);
     29 : spielfeldsetzen(s27,23,7,11);
     30 : spielfeldsetzen(s17,59,5,7);
    end;
       punkte:=0;
       zeit0:=time+1/24/20+(stufe-1)/24/720;
       endgeschafft:=false;
       geschafft:=false;
       lebt:=true;
end;

procedure Tfdigger.x3Click(Sender: TObject);
begin
   test(0,1,sender);
end;
procedure Tfdigger.x6Click(Sender: TObject);
begin
   test(0,-1,sender);
end;

procedure Tfdigger.test(a,b:integer;Sender: TObject);
var alt:integer;
begin
    if lebt then
    begin
      if feld[ax+a,ay+b]='.' then
      begin
        feld[ax+a,ay+b]:='x';
        feld[ax,ay]:=' ';
        ax:=ax+a;
        ay:=ay+b;
        exit;
      end;
      if feld[ax+a,ay+b]=' ' then
      begin
        feld[ax+a,ay+b]:='x';
        feld[ax,ay]:=' ';
        ax:=ax+a;
        ay:=ay+b;
        exit;
      end;
      if feld[ax+a,ay+b]='d' then
      begin
        inc(punkte);
        inc(gesamtpunkte);
        if gesamtpunkte mod 250=0 then inc(leben);
        feld[ax+a,ay+b]:='x';
        feld[ax,ay]:=' ';
        ax:=ax+a;
        ay:=ay+b;
        exit;
      end;
      if (feld[ax+a,ay]='k') and (feld[ax+a+a,ay]=' ') then
      begin
        feld[ax+a,ay+b]:='x';
        feld[ax,ay]:=' ';
        feld[ax+a+a,ay+b]:='k';
        ax:=ax+a;
        exit;
      end;
      if (feld[ax+a,ay+b]='a') and geschafft then
      begin
        feld[ax+a,ay+b]:='x';
        feld[ax,ay]:=' ';
        ax:=ax+a;
        ay:=ay+b;
        lebt:=false;
        inc(stufe);
        endgeschafft:=true;
        alt:=gesamtpunkte;
        gesamtpunkte:=gesamtpunkte+round(12*3600*(zeit0-time));
        if (alt div 250)<>(gesamtpunkte div 250) then inc(leben);
        if stufe=endstufe then
        begin
          showmessage('Gratulation! Sie haben alle Stufen erfolgreich absolviert!');
          stufe:=1;
        end
        else
        begin
          if leben=0 then leben:=1;
          showmessage('Gratulation! Sie haben Stufe '+inttostr(stufe-1)+' erfolgreich absolviert!');
          stufeein(sender);
        end;
        PB1Paint(Sender);
        exit;
      end;
    end;
end;

procedure Tfdigger.x5Click(Sender: TObject);
begin
   test(-1,0,sender);
end;

procedure Tfdigger.x7Click(Sender: TObject);
begin
   test(1,0,sender);
end;

procedure Tfdigger.Timer1Timer(Sender: TObject);
label 1;
var i,j:integer;
procedure tot;
begin
    if feld[i,j]='x' then
    begin
      feld[i,j]:='t';
      lebt:=false
    end
    else
      feld[i,j]:=' ';
    if feld[i-1,j]='x' then
    begin
      feld[i-1,j]:='t';
      lebt:=false
    end
    else
      feld[i-1,j]:=' ';
    if feld[i+1,j]='x' then
    begin
      feld[i+1,j]:='t';
      lebt:=false
    end
    else
      feld[i+1,j]:=' ';
    if feld[i,j+1]='x' then
    begin
      feld[i,j+1]:='t';
      lebt:=false
    end
    else
      feld[i,j+1]:=' ';
    if feld[i-1,j+1]='x' then
    begin
      feld[i-1,j+1]:='t';
      lebt:=false
    end
    else
      feld[i-1,j+1]:=' ';
    if feld[i+1,j+1]='x' then
    begin
      feld[i+1,j+1]:='t';
      lebt:=false
    end
    else
      feld[i+1,j+1]:=' ';
    if feld[i,j+2]='x' then
    begin
      feld[i,j+2]:='t';
      lebt:=false
    end
    else
      feld[i,j+2]:=' ';
    if feld[i-1,j+2]='x' then
    begin
      feld[i-1,j+2]:='t';
      lebt:=false
    end
    else
      feld[i-1,j+2]:=' ';
    if feld[i+1,j+2]='x' then
    begin
      feld[i+1,j+2]:='t';
      lebt:=false
    end
    else
      feld[i+1,j+2]:=' ';
end;
begin
    if zeit0-time<=0 then
    begin
      for i:=1 to 20 do
        for j:=1 to 14 do
          if feld[i,j]='x' then feld[i,j]:='t';
      lebt:=false;
    end;
    for j:=14 downto 1 do
      for i:=1 to 20 do
      begin
        case feld[i,j] of
         'k' : begin
                 if feld[i,j+1]=' ' then
                 begin
                   feld[i,j+1]:='k';
                   feld[i,j]:=' ';
                   bew[i,j+1]:=1;
                   goto 1;
                 end;
                 if (feld[i-1,j]=' ')  and (feld[i,j+1] in ['k','d'])
                    and (feld[i-1,j+1]=' ') then
                 begin
                   feld[i-1,j+1]:='k';
                   feld[i,j]:=' ';
                   bew[i-1,j+1]:=1;
                   goto 1;
                 end;
                 if (feld[i+1,j]=' ') and (feld[i,j+1] in ['k','d'])
                    and (feld[i+1,j+1]=' ') then
                 begin
                   feld[i+1,j+1]:='k';
                   feld[i,j]:=' ';
                   bew[i+1,j+1]:=1;
                   goto 1;
                 end;
                 if (feld[i,j+1]='f') and (feld[i,j+2]=' ') then
                 begin
                   feld[i,j+2]:='d';
                   feld[i,j]:=' ';
                   goto 1;
                 end;
                 if (feld[i,j+1]='x') and (bew[i,j]=1) then
                 begin
                   feld[i,j]:=' ';
                   feld[i-1,j]:=' ';
                   feld[i+1,j]:=' ';
                   feld[i,j+1]:='t';
                   feld[i-1,j+1]:=' ';
                   feld[i+1,j+1]:=' ';
                   feld[i,j+2]:=' ';
                   feld[i-1,j+2]:=' ';
                   feld[i+1,j+2]:=' ';
                   bew[i,j]:=0;
                   lebt:=false;
                   goto 1;
                 end;
                 if (feld[i,j+1] in ['o','p','q','r']) and (bew[i,j]=1) then
                 begin
                   tot;
                   bew[i,j]:=0;
                   goto 1;
                 end;
                 bew[i,j]:=0;
               end;
         'd' : begin
                 if feld[i,j+1]=' ' then
                 begin
                   feld[i,j+1]:='d';
                   feld[i,j]:=' ';
                   bew[i,j+1]:=1;
                   goto 1;
                 end;
                 if (feld[i-1,j]=' ') and (feld[i,j+1] in ['k','d'])
                    and (feld[i-1,j+1]=' ') then
                 begin
                   feld[i-1,j+1]:='d';
                   feld[i,j]:=' ';
                   bew[i-1,j+1]:=1;
                   goto 1;
                 end;
                 if (feld[i+1,j]=' ') and (feld[i,j+1] in ['k','d'])
                    and (feld[i+1,j+1]=' ') then
                 begin
                   feld[i+1,j+1]:='d';
                   feld[i,j]:=' ';
                   bew[i+1,j+1]:=1;
                   goto 1;
                 end;
                 if (feld[i,j+1]='x') and  (bew[i,j]=1) then
                 begin
                   feld[i,j]:=' ';
                   feld[i-1,j]:=' ';
                   feld[i+1,j]:=' ';
                   feld[i,j+1]:='t';
                   feld[i-1,j+1]:=' ';
                   feld[i+1,j+1]:=' ';
                   feld[i,j+2]:=' ';
                   feld[i-1,j+2]:=' ';
                   feld[i+1,j+2]:=' ';
                   bew[i,j]:=0;
                   lebt:=false;
                   goto 1;
                 end;
                 if (feld[i,j+1] in ['o','p','q','r']) and (bew[i,j]=1) then
                 begin
                   tot;
                   bew[i,j]:=0;
                   goto 1;
                 end;
                 bew[i,j]:=0;
               end;
         'q' : begin
                 if bew[i,j]=0 then bew[i,j]:=1;
                 if bew[i,j]=2 then
                 begin
                   bew[i,j]:=1;
                   goto 1
                 end;
                 if bew[i,j]=-2 then
                 begin
                   bew[i,j]:=-1;
                   goto 1
                 end;
                 if (feld[i,j+bew[i,j]]='x') and (not endgeschafft) then
                 begin
                   feld[i,j+bew[i,j]]:='t';
                   feld[i,j]:=' ';
                   lebt:=false;
                   goto 1;
                 end;
                 if feld[i,j+bew[i,j]]=' ' then
                 begin
                   feld[i,j+bew[i,j]]:='q';
                   feld[i,j]:=' ';
                   bew[i,j+bew[i,j]]:=2*bew[i,j]; //bew[i,j]:=0;
                   goto 1;
                 end;
                 if feld[i,j+bew[i,j]]<>' ' then
                 begin
                   bew[i,j]:=-bew[i,j];
                   goto 1;
                 end;
               end;
         'p' : begin
                 if bew[i,j]=0 then bew[i,j]:=1;
                 if bew[i,j]=2 then
                 begin
                   bew[i,j]:=1;
                   goto 1
                 end;
                 if bew[i,j]=-2 then
                 begin
                   bew[i,j]:=-1;
                   goto 1
                 end;
                 if (feld[i+bew[i,j],j]='x') and (not endgeschafft) then
                 begin
                   feld[i+bew[i,j],j]:='t';
                   feld[i,j]:=' ';
                   lebt:=false;
                   goto 1;
                 end;
                 if feld[i+bew[i,j],j]=' ' then
                 begin
                   feld[i+bew[i,j],j]:='p';
                   feld[i,j]:=' ';
                   bew[i+bew[i,j],j]:=2*bew[i,j]; //bew[i,j]:=0;
                   goto 1;
                 end;
                 if feld[i+bew[i,j],j]<>' ' then
                 begin
                   bew[i,j]:=-bew[i,j];
                   goto 1;
                 end;
               end;
         'o' : begin
                 if bew[i,j]>4 then
                 begin
                   bew[i,j]:=bew[i,j]-4;
                   goto 1
                 end;
                 if bew[i,j]=0 then bew[i,j]:=1;
                 if (bew[i,j]=1) then
                 begin
                   if (feld[i+1,j]='x') and (not endgeschafft) then
                   begin
                     feld[i+1,j]:='t';
                     feld[i,j]:=' ';
                     lebt:=false;
                     goto 1;
                   end;
                   if feld[i+1,j]=' ' then
                   begin
                     feld[i+1,j]:='o';
                     feld[i,j]:=' ';
                     bew[i+1,j]:=9;
                     bew[i,j]:=0;
                     goto 1;
                   end;
                   if feld[i+1,j]<>' ' then
                   begin
                     bew[i,j]:=2;
                     goto 1;
                   end;
                 end;

                 if (bew[i,j]=2) then
                 begin
                   if (feld[i,j-1]='x') and (not endgeschafft) then
                   begin
                     feld[i,j-1]:='t';
                     feld[i,j]:=' ';
                     lebt:=false;
                     goto 1;
                   end;
                   if feld[i,j-1]=' ' then
                   begin
                     feld[i,j-1]:='o';
                     feld[i,j]:=' ';
                     bew[i,j-1]:=6;
                     goto 1;
                   end;
                   if feld[i,j-1]<>' ' then
                   begin
                     bew[i,j]:=3;
                     goto 1;
                   end;
                 end;

                 if (bew[i,j]=3) then
                 begin
                   if (feld[i-1,j]='x') and (not endgeschafft) then
                   begin
                     feld[i-1,j]:='t';
                     feld[i,j]:=' ';
                     lebt:=false;
                     goto 1;
                   end;
                   if feld[i-1,j]=' ' then
                   begin
                     feld[i-1,j]:='o';
                     feld[i,j]:=' ';
                     bew[i-1,j]:=7;
                     goto 1;
                   end;
                   if feld[i-1,j]<>' ' then
                   begin
                     bew[i,j]:=4;
                     goto 1;
                   end;
                 end;
                 if (bew[i,j]=4) then
                 begin
                   if (feld[i,j+1]='x') and (not endgeschafft) then
                   begin
                     feld[i,j+1]:='t';
                     feld[i,j]:=' ';
                     lebt:=false;
                     goto 1;
                   end;
                   if feld[i,j+1]=' ' then
                   begin
                     feld[i,j+1]:='o';
                     feld[i,j]:=' ';
                     bew[i,j+1]:=8;
                     goto 1;
                   end;
                   if feld[i,j+1]<>' ' then
                   begin
                     bew[i,j]:=1;
                     goto 1;
                  end;
                end;
              end;
        'r' : begin
                if bew[i,j]>4 then
                begin
                  bew[i,j]:=bew[i,j]-4;
                  goto 1
                end;
                if bew[i,j]=0 then bew[i,j]:=1;
                if (bew[i,j]=1) then
                begin
                  if (feld[i+1,j]='x') and (not endgeschafft) then
                  begin
                    feld[i+1,j]:='t';
                    feld[i,j]:=' ';
                    lebt:=false;
                    goto 1;
                  end;
                  if feld[i+1,j]=' ' then
                  begin
                    feld[i+1,j]:='r';
                    feld[i,j]:=' ';
                    bew[i+1,j]:=13;
                    bew[i,j]:=0;
                    goto 1;
                  end;
                  if feld[i+1,j]<>' ' then
                  begin
                    bew[i,j]:=8;
                    if feld[i,j+1]<>' ' then
                    begin
                      bew[i,j]:=6;
                      if feld[i,j-1]<>' ' then bew[i,j]:=7;
                    end;
                    goto 1;
                  end;
                end;
                if (bew[i,j]=2) then
                begin
                  if (feld[i,j-1]='x') and (not endgeschafft) then
                  begin
                    feld[i,j-1]:='t';
                    feld[i,j]:=' ';
                    lebt:=false;
                    goto 1;
                  end;
                  if feld[i,j-1]=' ' then
                  begin
                    feld[i,j-1]:='r';
                    feld[i,j]:=' ';
                    bew[i,j-1]:=6;
                    goto 1;
                  end;
                  if feld[i,j-1]<>' ' then
                  begin
                    bew[i,j]:=5;
                    if feld[i+1,j]<>' ' then
                    begin
                      bew[i,j]:=7;
                      if feld[i-1,j]<>' ' then bew[i,j]:=8;
                    end;
                    goto 1;
                  end;
                end;
                if (bew[i,j]=3) then
                begin
                  if (feld[i-1,j]='x') and (not endgeschafft) then
                  begin
                    feld[i-1,j]:='t';
                    feld[i,j]:=' ';
                    lebt:=false;
                    goto 1;
                  end;
                  if feld[i-1,j]=' ' then
                  begin
                    feld[i-1,j]:='r';
                    feld[i,j]:=' ';
                    bew[i-1,j]:=7;
                    goto 1;
                  end;
                  if feld[i-1,j]<>' ' then
                  begin
                    bew[i,j]:=6;
                    if feld[i,j-1]<>' ' then
                    begin
                      bew[i,j]:=8;
                      if feld[i,j+1]<>' ' then bew[i,j]:=5;
                    end;
                    goto 1;
                  end;
                end;

                if (bew[i,j]=4) then
                begin
                  if (feld[i,j+1]='x') and (not endgeschafft) then
                  begin
                    feld[i,j+1]:='t';
                    feld[i,j]:=' ';
                    lebt:=false;
                    goto 1;
                  end;
                  if feld[i,j+1]=' ' then
                  begin
                    feld[i,j+1]:='r';
                    feld[i,j]:=' ';
                    bew[i,j+1]:=8;
                    goto 1;
                  end;
                  if feld[i,j+1]<>' ' then
                  begin
                  bew[i,j]:=7;
                  if feld[i-1,j]<>' ' then
                  begin
                    bew[i,j]:=5;
                    if feld[i+1,j]<>' ' then bew[i,j]:=6;
                  end;
                  goto 1;
                end;
              end;
            end;
          end; {case}

 1:  end;
     akort:=(akort+3) mod 27;
     PB1Paint(Sender);
     if lebt=false then
       if leben=0 then
       begin
         timer1.enabled:=false;
         schluss(sender);
       end;
end;

procedure Tfdigger.S3Click(Sender: TObject);
var i:Integer;
begin
    for i:=4400 to 4410 do pics[i].free;
    close
end;

procedure Tfdigger.schluss(Sender: TObject);
begin
    showmessage('Spielende. Sie erreichten '+inttostr(gesamtpunkte)+' Punkte !');
    Zurcksetzen1.caption:='Neustart';
    gesamtpunkte:=0;
end;

procedure Tfdigger.w1Click(Sender: TObject);
begin
    inc(stufe);
    if stufe>=endstufe then stufe:=1;
    leben:=5;
    stufeein(Sender);
end;

procedure Tfdigger.Timer2Timer(Sender: TObject);
begin
   if getasynckeystate(vk_left)<>0 then test(-1,0,sender);
   if getasynckeystate(vk_right)<>0 then test(1,0,sender);
   if getasynckeystate(vk_up)<>0 then test(0,-1,sender);
   if getasynckeystate(vk_down)<>0 then test(0,1,sender);
end;

end.
