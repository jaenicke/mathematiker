unit uinkugel;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  StdCtrls, Buttons, messages, Mask, Zlib, Spin, Menus;

type
  TFInkugel = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    PB1: TPaintBox;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    CPunkte: TCheckBox;
    Listbox1: TListBox;
    RadioB2: TRadioButton;
    RadioB3: TRadioButton;
    RadioB1: TRadioButton;
    Speed2: TSpeedButton;
    Speed3: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    procedure S13C(Sender: TObject);
    procedure LB1C(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure B1C(Sender: TObject);
    procedure zeichnen(Sender: TObject);
    procedure rechnen(Sender: TObject);
    procedure T1Tim(Sender: TObject);
    procedure B2C(Sender: TObject);
    procedure S8C(Sender: TObject);
    procedure PB1MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MM(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB1MU(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure x2C(Sender: TObject);
    procedure zeichnenx(canvas:tcanvas);
    procedure t6C(Sender: TObject);
    procedure CB1C(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WndProc(var msg:TMessage); override;
    procedure drehen(x,y,z:double);
    procedure FormShow(Sender: TObject);
  private
    radiusi,radiusu:double;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInkugel: TFInkugel;

implementation
{$R *.DFM}

uses math;

const pino=pi/180;

var k_pnr:integer;
    typ:integer;
    kabbruch:boolean;
    hpunkte:boolean;
    live:boolean;
    x_alt,y_alt:integer;
    winkelx,winkely,winkelax,winkelay,winkelz,winkelaz:double;

type ttriple=record x,y,z:double end;
var t,t2,t3:array[0..500] of ttriple;
    z:double;
    verdecktzahl,verdecktzahl2, vx,vy:integer;
    filelines,filelines2,filelines3:array[0..500,0..24] of integer;
    mittel,mittel2,mittel3:array[0..500] of record
       x,y,z:double;
       f:integer;
       poly:byte;
    end;//ttriple;
    sanzahl,sanzahlb:integer;
    nichtschalten:boolean;
    listempoly1,listempoly2:tstringlist;
    listenr:integer;

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

procedure listeres(liste:tstringlist;const kk:string);
var ms1: TResourcestream;
    ms2: TMemoryStream;
begin
    ms1 := TResourceStream.Create(hinstance,kk,RT_RCDATA);
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

procedure split3(kk:string;var a,b,c:double);
var code:integer;
begin
  val(copy(kk,1,pos(' ',kk)-1),a,code);
  if code>0 then a:=0;
  delete(kk,1,pos(' ',kk));
  val(copy(kk,1,pos(' ',kk)-1),b,code);
  if code>0 then b:=0;
  delete(kk,1,pos(' ',kk));
  val(kk,c,code);
  if code>0 then c:=0;
end;

procedure TFInkugel.WndProc(var msg:TMessage);
begin
  case Msg.Msg of
     WM_CLOSE: begin
      if not kabbruch then begin
        kabbruch:=true;
        timer1.interval:=0;
      end;
        close;
               end;
  else
    inherited;
  end;
end;

procedure TFInkugel.S13C(Sender: TObject);
begin
  if not kabbruch then begin
    kabbruch:=true;
    timer1.interval:=0;
  end
  else
    close;
end;

procedure TFInkugel.LB1C(Sender: TObject);
var sel:integer;
begin
  timer1.interval:=0;
  button1.caption:='Rotation';
  sel:=Listbox1.itemindex;
  if sel<18 then RadioB3.caption:='Umkugel'
            else RadioB3.caption:='äußere Kugel';
  if (sel<5) or (sel>17) then radiob2.caption:='Inkugel'
            else radiob2.caption:='innere Kugel';
  b1c(sender);
end;

procedure TFInkugel.FormCreate(Sender: TObject);
begin
  listempoly1:=tstringlist.create;
  listeres(listempoly1,'mpoly1');
  listempoly2:=tstringlist.create;
  listeres(listempoly2,'mpoly2');
  typ:=0;
  k_pnr:=0;
  winkelx:=0;
  winkely:=0;
  winkelz:=0.5;
  z:=120;
  hpunkte:=false;
  kabbruch:=true;
end;

procedure TFInkugel.B1C(Sender: TObject);
var i:integer;
    kk:string;
    seite,maxgroesse:double;
    nr,vzahl:integer;

  procedure zusatzflaechen(offset:integer);
  var kk,kl:string;
      qx,qy,qz:double;
      i,jx,xxx,p:integer;
  begin
    listenr:=0;
    kk:='['+inttostr(k_pnr+1+offset)+']';
    listenr:=listempoly2.indexof(kk)+1;
    sanzahl:=strtoint(listempoly2[listenr]);
    inc(listenr);
    for i:=0 to sANZAHL-1 do begin
      kk:=listempoly2[listenr];
      inc(listenr);
      kl:=kk;
      kk:=trimleft(kk);
      xxx:=length(kk);
      qx:=0;
      qy:=0;
      qz:=0;
      filelines[i][0]:=xxx;
      for jx:=1 to xxx do begin
        p:=ord(kk[jx])-48;
        qx:=qx+t[p].x;
        qy:=qy+t[p].y;
        qz:=qz+t[p].z;
        filelines[i][jx]:=p;
      end;
      mittel[i].x:=qx/xxx;
      mittel[i].y:=qy/xxx;
      mittel[i].z:=qz/xxx;
      mittel[i].f:=(i mod 23)+1;
    end;
  end;

  procedure vordrehen;
  var i:integer;
      x0,y0:double;
      swi,cwi:extended;
  begin
    SinCos(-pino*30,swi,cwi);
    for i:=0 to verdecktzahl-1 do begin
      x0:=cwi*t[i].x-swi*t[i].y;
      t[i].y:=swi*t[i].x+cwi*t[i].y;
      t[i].x:=x0;
      y0:=cwi*t[i].y-swi*t[i].z;
      t[i].z:=swi*t[i].y+cwi*t[i].z;
      t[i].y:=y0;
    end;
    for i:=0 to sanzahl-1 do begin
      x0:=cwi*mittel[i].x-swi*mittel[i].y;
      mittel[i].y:=swi*mittel[i].x+cwi*mittel[i].y;
      mittel[i].x:=x0;
      y0:=cwi*mittel[i].y-swi*mittel[i].z;
      mittel[i].z:=swi*mittel[i].y+cwi*mittel[i].z;
      mittel[i].y:=y0;
    end;
    for i:=0 to verdecktzahl2-1 do begin
      x0:=cwi*t2[i].x-swi*t2[i].y;
      t2[i].y:=swi*t2[i].x+cwi*t2[i].y;
      t2[i].x:=x0;
      y0:=cwi*t2[i].y-swi*t2[i].z;
      t2[i].z:=swi*t2[i].y+cwi*t2[i].z;
      t2[i].y:=y0;
    end;
    for i:=0 to sanzahlb-1 do begin
      x0:=cwi*mittel2[i].x-swi*mittel2[i].y;
      mittel2[i].y:=swi*mittel2[i].x+cwi*mittel2[i].y;
      mittel2[i].x:=x0;
      y0:=cwi*mittel2[i].y-swi*mittel2[i].z;
      mittel2[i].z:=swi*mittel2[i].y+cwi*mittel2[i].z;
      mittel2[i].y:=y0;
    end;
    for i:=0 to verdecktzahl2-1 do begin
      x0:=cwi*t3[i].x-swi*t3[i].y;
      t3[i].y:=swi*t3[i].x+cwi*t3[i].y;
      t3[i].x:=x0;
      y0:=cwi*t3[i].y-swi*t3[i].z;
      t3[i].z:=swi*t3[i].y+cwi*t3[i].z;
      t3[i].y:=y0;
    end;
    for i:=0 to sanzahlb-1 do begin
      x0:=cwi*mittel3[i].x-swi*mittel3[i].y;
      mittel3[i].y:=swi*mittel3[i].x+cwi*mittel3[i].y;
      mittel3[i].x:=x0;
      y0:=cwi*mittel3[i].y-swi*mittel3[i].z;
      mittel3[i].z:=swi*mittel3[i].y+cwi*mittel3[i].z;
      mittel3[i].y:=y0;
    end;
  end;

  procedure inkugel;
  const constj = 24;
        consti = 10;
  var i,j,jx,p,nr,xxx:integer;
      qx,qy,qz:double;
  begin
    i:=-85;
    nr:=0;
    repeat
      j:=0;
      repeat
        t2[nr].x:=radiusi*cos(i*pino)*cos(j*pino);
        t2[nr].y:=radiusi*cos(i*pino)*sin(j*pino);
        t2[nr].z:=radiusi*sin(i*pino);
        inc(nr);
        j:=j+360 div constj;
      until j>355;
      i:=i+consti;
    until i>86;
    verdecktzahl2:=nr;
    nr:=0;
    for j:=0 to (170 div consti) -1 do begin
      for i:=0 to constj-2 do begin
        filelines2[nr][0]:=4;
        filelines2[nr][1]:=i+j*constj;
        filelines2[nr][2]:=1+i+j*constj;
        filelines2[nr][3]:=1+i+constj+j*constj;
        filelines2[nr][4]:=i+constj+j*constj;
        inc(nr);
      end;
      filelines2[nr][0]:=4;
      filelines2[nr][1]:=constj-1+j*constj;
      filelines2[nr][2]:=j*constj;
      filelines2[nr][3]:=constj+j*constj;
      filelines2[nr][4]:=constj-1+constj+j*constj;
      inc(nr);
    end;
    sanzahlb:=nr;
    for i:=0 to sANZAHLb-1 do begin
      xxx:=filelines2[i][0];
      qx:=0;
      qy:=0;
      qz:=0;
      for jx:=1 to filelines2[i][0] do begin
        p:=filelines2[i][jx];
        qx:=qx+t2[p].x;
        qy:=qy+t2[p].y;
        qz:=qz+t2[p].z;
      end;
      mittel2[i].x:=qx/xxx;
      mittel2[i].y:=qy/xxx;
      mittel2[i].z:=qz/xxx;
      mittel2[i].f:=(i mod 23)+1;
    end;
  end;
  procedure umkugel;
  var i,jx,p,xxx:integer;
      qx,qy,qz:double;
  begin
    for i:=0 to verdecktzahl2-1 do begin
      t3[i].x:=radiusu/radiusi*t2[i].x;
      t3[i].y:=radiusu/radiusi*t2[i].y;
      t3[i].z:=radiusu/radiusi*t2[i].z;
    end;
    for i:=0 to sanzahlb-1 do
      filelines3[i]:=filelines2[i];
    for i:=0 to sANZAHLb-1 do begin
      qx:=0;
      qy:=0;
      qz:=0;
      xxx:=filelines3[i][0];
      for jx:=1 to filelines3[i][0] do begin
        p:=filelines3[i][jx];
        qx:=qx+t3[p].x;
        qy:=qy+t3[p].y;
        qz:=qz+t3[p].z;
      end;
      mittel3[i].x:=qx/xxx;
      mittel3[i].y:=qy/xxx;
      mittel3[i].z:=qz/xxx;
      mittel3[i].f:=(i mod 23)+1;
    end;
  end;

const
{Körper ?, Kuboktaeder, Ikosidodekaeder, Rhombenikosidodekaeder, Rhombenkuboktaeder,
Abgeschrägtes Hexaeder, Abgeschrägtes Dodekaeder, Ikosaederstumpf, Ikosidodekaederstumpf,
Kuboktaederstumpf, Hexaederstumpf, Oktaederstumpf, Tetraederstumpf, Dodekaederstumpf,
Pyramidentetraeder, Pyramidenoktaeder, Pyramidenikosaeder, Pyramidenwürfel, Rhombendodekaeder,
Deltoid-24-Flächner, Deltoid-60-Flächner, Rhomben-30-Flächner, Pyramidendodekaeder,
Pentagon-24-Flächner, Pentagon-60-Flächner, Disdyakistriacontaeder, Disdyakisdodecaeder}
    faktor1 : array[5..30] of single =
      (0.70710678, 1.3763819, 2.064573, 1.20710, 1.1426135, 1.9809159, 2.26728,
       3.4409548, 1.91421, 1.20710, 1.22474, 0.612372, 2.48989, 0.959403/3, 1.638281/3.41421,
       2.885258/3.61803, 1.423025/2.12132, 0.75/0.91856, 1.220263/0.83719, 2.120991/0.804992,
       1.463525/1.063314, 2.377132/1.854102, 1.157662/0.593465, 2.039873/0.582899,
       3.736646/1.394287, 2.2097412/1.450049);
    faktor2 : array[5..30] of single =
      (1, 1.61803, 2.23295, 1.39896, 1.343713, 2.1558374, 2.47802, 3.80239, 2.31761,
       1.77882, 1.58114, 1.17260, 2.96945, 1.83712/3, 2.41421/3.414, 3.44905/3.6180,
       1.83712/2.12132, 1.06066/0.91856, 1.414214/0.83719, 2.29397/0.804992, 1.7204774/1.063314,
       2.598076/1.854102, 1.3614102/0.593465, 2.2200007/0.582899, 4.1291458/1.394287,
       2.6754174/1.450049);
begin
  nichtschalten:=true;
  winkelax:=0;
  winkelay:=0;
  vzahl:=0;
  nr:=Listbox1.itemindex;
  k_pnr:=strtoint(copy(Listbox1.items[nr],pos(#9,Listbox1.items[nr])+1,255));
  z:=1;
  case k_pnr of
    0..4 : begin      {nächster Polyeder bekommt Nr. 451 in poly1 und poly2}
             kk:='['+inttostr(k_pnr+1)+']';
             listenr:=listempoly1.indexof(kk)+1;
             verdecktzahl:=strtoint(listempoly1[listenr]);
             inc(listenr);
             for i:=0 to verdecktzahl-1 do begin
               kk:=listempoly1[listenr];
               inc(listenr);
               split3(kk,t[i].x,t[i].y,t[i].z);
             end;
             zusatzflaechen(0);
             vzahl:=verdecktzahl;
             seite:=sqrt(sqr(t[0].x-t[1].x)+sqr(t[0].y-t[1].y)+sqr(t[0].z-t[1].z));
             case k_pnr of
               0 : radiusi:=seite/12*sqrt(6);
               1 : radiusi:=seite/2;
               2 : radiusi:=seite/6*sqrt(6);
               3 : radiusi:=seite/12*sqrt(3)*(3+sqrt(5));
               4 : radiusi:=seite/20*sqrt(250+110*sqrt(5));
             end;
             case k_pnr of
               0 : radiusu:=seite/4*sqrt(6);
               1 : radiusu:=seite/2*sqrt(3);
               2 : radiusu:=seite/2*sqrt(2);
               3 : radiusu:=seite/4*sqrt(10+2*sqrt(5));
               4 : radiusu:=seite/4*sqrt(3)*(1+sqrt(5));
             end;
             inkugel;
             umkugel;
             vordrehen;
           end;
   5..30 : begin
             kk:='['+inttostr(k_pnr+4001-5)+']';
             listenr:=listempoly1.indexof(kk)+1;
             verdecktzahl:=strtoint(listempoly1[listenr]);
             inc(listenr);
             for i:=0 to verdecktzahl-1 do begin
               kk:=listempoly1[listenr];
               inc(listenr);
               split3(kk,t[i].x,t[i].y,t[i].z);
             end;
             zusatzflaechen(4000-5);
             vzahl:=verdecktzahl;
             seite:=sqrt(sqr(t[0].x-t[1].x)+sqr(t[0].y-t[1].y)+sqr(t[0].z-t[1].z));
             radiusi:=faktor1[k_pnr]*seite;
             radiusu:=faktor2[k_pnr]*seite;
             inkugel;
             umkugel;
             vordrehen;
           end;
       end; //großes end

       maxgroesse:=0;
       for i:=0 to vzahl-1 do begin
         if abs(t[i].x)>maxgroesse then maxgroesse:=abs(t[i].x);
         if abs(t[i].y)>maxgroesse then maxgroesse:=abs(t[i].y);
         if abs(t[i].z)>maxgroesse then maxgroesse:=abs(t[i].z);
       end;
       for i:=0 to verdecktzahl2-1 do begin
         if abs(t2[i].x)>maxgroesse then maxgroesse:=abs(t2[i].x);
         if abs(t2[i].y)>maxgroesse then maxgroesse:=abs(t2[i].y);
         if abs(t2[i].z)>maxgroesse then maxgroesse:=abs(t2[i].z);
       end;
       for i:=0 to verdecktzahl2-1 do begin
         if abs(t3[i].x)>maxgroesse then maxgroesse:=abs(t3[i].x);
         if abs(t3[i].y)>maxgroesse then maxgroesse:=abs(t3[i].y);
         if abs(t3[i].z)>maxgroesse then maxgroesse:=abs(t3[i].z);
       end;
       z:=260/maxgroesse;
       for i:=0 to vzahl-1 do begin
         t[i].x:=z*t[i].x;
         t[i].y:=z*t[i].y;
         t[i].z:=z*t[i].z;
       end;
       for i:=0 to verdecktzahl2-1 do begin
         t2[i].x:=z*t2[i].x;
         t2[i].y:=z*t2[i].y;
         t2[i].z:=z*t2[i].z;
       end;
       for i:=0 to verdecktzahl2-1 do begin
         t3[i].x:=z*t3[i].x;
         t3[i].y:=z*t3[i].y;
         t3[i].z:=z*t3[i].z;
       end;
       zeichnen(sender);
       nichtschalten:=false;
end;

procedure tFInkugel.zeichnenx(canvas:tcanvas);
  procedure bildmalen3;
  var bitmap2:tbitmap;

    procedure drawpoly(nr,anz:integer; poly:byte);
    var poi:array[0..40] of tpoint;
        i,p,altfarbe:integer;
    begin
      if poly=1 then begin
        canvas.brush.style:=bssolid;//bsbdiagonal;
        canvas.brush.color:=clyellow;
        canvas.pen.color:=clblue;
      end
      else begin
        canvas.brush.color:=$00a0ffa0;
        canvas.pen.color:=clred;
      end;
      if poly=0 then begin
        for i:=1 to anz do begin
          p:=filelines[nr,i];//ord(flx[i])-48;
          poi[i-1].x:=round(t[p].x)+vx;
          poi[i-1].y:=round(t[p].y)+vy;
        end;
      end
      else begin
        for i:=1 to anz do begin
          p:=filelines2[nr,i];//ord(flx[i])-48;
          poi[i-1].x:=round(t2[p].x)+vx;
          poi[i-1].y:=round(t2[p].y)+vy;
        end;
      end;
      canvas.polygon(slice(poi,anz));
      if hpunkte then begin
        altfarbe:=canvas.brush.color;
        canvas.brush.color:=clyellow;
        if poly=0 then begin
          for i:=1 to anz do begin
            p:=filelines[nr,i];//=ord(flx[i])-48;
            canvas.ellipse(round(t[p].x)+vx-4,round(t[p].y)+vy-4,round(t[p].x)+vx+5,round(t[p].y)+vy+5);
          end;
        end;
        canvas.brush.color:=altfarbe;
      end;
    end;

    procedure drawpoly2(nr,anz:integer;poly:byte);
    var poi:array[0..40] of tpoint;
        i,p,altfarbe:integer;
    begin
      bitmap2.canvas.brush.color:=$00a0ffa0;
      bitmap2.canvas.pen.color:=clred;
      for i:=1 to anz do begin
        p:=filelines[nr,i];//ord(flx[i])-48;
        poi[i-1].x:=round(t[p].x)+vx;
        poi[i-1].y:=round(t[p].y)+vy;
      end;
      bitmap2.canvas.polygon(slice(poi,anz));
      if hpunkte then begin
        altfarbe:=bitmap2.canvas.brush.color;
        bitmap2.canvas.brush.color:=clyellow;
        for i:=1 to anz do begin
          p:=filelines[nr,i];
          bitmap2.canvas.ellipse(round(t[p].x)+vx-4,round(t[p].y)+vy-4,round(t[p].x)+vx+5,round(t[p].y)+vy+5);
        end;
        bitmap2.canvas.brush.color:=altfarbe;
      end;
    end;

    procedure drawpoly3(nr,anz:integer; poly:byte);
    var poi:array[0..40] of tpoint;
        i,p,altfarbe:integer;
    begin
      if poly=1 then begin
        canvas.brush.style:=bssolid;//bsbdiagonal;
        canvas.brush.color:=clyellow;
        canvas.pen.color:=clblue;
      end
      else begin
        canvas.brush.color:=$00a0ffa0;
        canvas.pen.color:=$008080ff;//clred;
      end;
      if poly=0 then begin
        for i:=1 to anz do begin
          p:=filelines3[nr,i];//ord(flx[i])-48;
          poi[i-1].x:=round(t3[p].x)+vx;
          poi[i-1].y:=round(t3[p].y)+vy;
        end;
      end
      else begin
        for i:=1 to anz do begin
          p:=filelines[nr,i];//ord(flx[i])-48;
          poi[i-1].x:=round(t[p].x)+vx;
          poi[i-1].y:=round(t[p].y)+vy;
        end;
      end;
      canvas.polygon(slice(poi,anz));
      if hpunkte then begin
        altfarbe:=canvas.brush.color;
        canvas.brush.color:=clyellow;
        if poly<>0 then begin
          for i:=1 to anz do begin
            p:=filelines[nr,i];//ord(flx[i])-48;
            canvas.ellipse(round(t[p].x)+vx-4,round(t[p].y)+vy-4,round(t[p].x)+vx+5,round(t[p].y)+vy+5);
          end;
        end;
        canvas.brush.color:=altfarbe;
      end;
    end;

    procedure drawpoly4(nr,anz:integer;poly:byte);
    var poi:array[0..40] of tpoint;
        {anz,}i,p{,altfarbe}:integer;
    begin
      bitmap2.canvas.brush.color:=$00a0ffa0;
      bitmap2.canvas.pen.color:=clred;
      for i:=1 to anz do begin
        p:=filelines3[nr,i];//ord(flx[i])-48;
        poi[i-1].x:=round(t3[p].x)+vx;
        poi[i-1].y:=round(t3[p].y)+vy;
      end;
      bitmap2.canvas.polygon(slice(poi,anz));
    end;

var reihe:array[0..500] of real;
    reihenfarbe:array[0..500] of integer;
    reihenfolge:array[0..500] of integer;

    procedure unsichtbar;
    var i,janz,hi:integer;
        h:real;
      procedure sortieren;
      var i,j:integer;
      begin
        for i:=0 to janz-2 do begin
          for j:=i+1 to janz-1 do begin
            if reihe[i]<reihe[j] then begin
              h:=reihe[i];
              reihe[i]:=reihe[j];
              reihe[j]:=h;
              hi:=reihenfarbe[i];
              reihenfarbe[i]:=reihenfarbe[j];
              reihenfarbe[j]:=hi;
              hi:=reihenfolge[i];
              reihenfolge[i]:=reihenfolge[j];
              reihenfolge[j]:=hi;
            end;
          end;
        end;
      end;
    begin
      janz:=0;
      for i:=0 to sanzahl-1 do begin
        reihe[janz]:=mittel[i].z;
        reihenfarbe[janz]:=mittel[i].f;
        reihenfolge[janz]:=janz;
        inc(janz);
      end;
      sortieren;
      canvas.pen.style:=psdot;
      for i:=0 to janz-1 do
        if reihe[i]>=0 then
          drawpoly(reihenfolge[i],filelines[reihenfolge[i],0],0);
      canvas.pen.style:=pssolid;
//innen
      if radiob2.checked then begin
        janz:=0;
        for i:=0 to sanzahlb{c}-1 do begin
          reihe[janz]:=mittel2[i].z;
          reihenfarbe[janz]:=mittel2[i].f;
          reihenfolge[janz]:=janz;
          inc(janz);
        end;
        sortieren;
        for i:=0 to janz-1 do
          drawpoly(reihenfolge[i],filelines2[reihenfolge[i],0],1);
      end;
//vorn
      bitmap2:=tbitmap.create;
      bitmap2.width:=pb1.width;
      bitmap2.height:=pb1.height;
      janz:=0;
      for i:=0 to sanzahl-1 do begin
        reihe[janz]:=mittel[i].z;
        reihenfarbe[janz]:=mittel[i].f;
        reihenfolge[janz]:=janz;
        inc(janz);
      end;
      sortieren;
      for i:=0 to janz-1 do
        if reihe[i]<0 then
          drawpoly2(reihenfolge[i],filelines[reihenfolge[i],0],0);
      canvas.copyMode:=cmsrcand;
      canvas.draw(0,0,bitmap2);
      bitmap2.free;
    end;

  procedure unsichtbar2;
  var i,janz,hi:integer;
      h:real;
    procedure sortieren;
    var i,j:integer;
    begin
      for i:=0 to janz-2 do begin
        for j:=i+1 to janz-1 do begin
         if reihe[i]<reihe[j] then begin
             h:=reihe[i];
             reihe[i]:=reihe[j];
             reihe[j]:=h;
             hi:=reihenfarbe[i];
             reihenfarbe[i]:=reihenfarbe[j];
             reihenfarbe[j]:=hi;
             hi:=reihenfolge[i];
             reihenfolge[i]:=reihenfolge[j];
             reihenfolge[j]:=hi;
          end;
        end;
      end;
    end;
  begin
    janz:=0;
    for i:=0 to sanzahlb-1 do begin
      reihe[janz]:=mittel3[i].z;
      reihenfarbe[janz]:=mittel3[i].f;
      reihenfolge[janz]:=janz;
      inc(janz);
    end;
    sortieren;
    canvas.pen.style:=psdot;
    for i:=0 to janz-1 do
      if reihe[i]>=0 then
        drawpoly3(reihenfolge[i],filelines3[reihenfolge[i],0],0);
    canvas.pen.style:=pssolid;
//innen
    if RadioB3.checked then begin
      janz:=0;
      for i:=0 to sanzahl{c}-1 do begin
        reihe[janz]:=mittel[i].z;
        reihenfarbe[janz]:=mittel[i].f;
        reihenfolge[janz]:=janz;
        inc(janz);
      end;
      sortieren;
      for i:=0 to janz-1 do
        drawpoly3(reihenfolge[i],filelines[reihenfolge[i],0],1);
    end;
//vorn
    bitmap2:=tbitmap.create;
    bitmap2.width:=pb1.width;
    bitmap2.height:=pb1.height;
    janz:=0;
    for i:=0 to sanzahlb-1 do begin
      reihe[janz]:=mittel3[i].z;
      reihenfarbe[janz]:=mittel3[i].f;
      reihenfolge[janz]:=janz;
      inc(janz);
    end;
    sortieren;
    for i:=0 to janz-1 do
      if reihe[i]<0 then drawpoly4(reihenfolge[i],filelines3[reihenfolge[i],0],0);
    canvas.copyMode:=cmsrcand;
    canvas.draw(0,0,bitmap2);
    bitmap2.free;
  end;
begin
  if RadioB3.checked then
    unsichtbar2
  else
    unsichtbar;
end;

begin
  vx:=pb1.width div 2;
  vy:=pb1.height div 2;
  bildmalen3;
end;

procedure TFInkugel.zeichnen(Sender: TObject);
var Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  bitmap.pixelformat:=pf32bit;
  Bitmap.Width := panel5.Width;
  Bitmap.Height := panel5.Height;
  zeichnenx(bitmap.canvas);
  pb1.canvas.draw(0,0,bitmap);
  Bitmap.Free;
end;

procedure tFInkugel.drehen(x,y,z:double);
var i:integer;
    x0,y0:double;
    swi,swi2,cwi2,swi3,cwi3,cwi:extended;
begin
  SinCos(pino*x,swi,cwi);
  SinCos(pino*y,swi2,cwi2);
  SinCos(pino*z,swi3,cwi3);
  for i:=0 to verdecktzahl-1 do begin
    x0:=cwi*t[i].x-swi*t[i].y;
    t[i].y:=swi*t[i].x+cwi*t[i].y;
    t[i].x:=x0;
    y0:=cwi2*t[i].y-swi2*t[i].z;
    t[i].z:=swi2*t[i].y+cwi2*t[i].z;
    t[i].y:=y0;
    y0:=cwi3*t[i].x-swi3*t[i].z;
    t[i].z:=swi3*t[i].x+cwi3*t[i].z;
    t[i].x:=y0;
  end;
  for i:=0 to sanzahl-1 do begin
    x0:=cwi*mittel[i].x-swi*mittel[i].y;
    mittel[i].y:=swi*mittel[i].x+cwi*mittel[i].y;
    mittel[i].x:=x0;
    y0:=cwi2*mittel[i].y-swi2*mittel[i].z;
    mittel[i].z:=swi2*mittel[i].y+cwi2*mittel[i].z;
    mittel[i].y:=y0;
    y0:=cwi3*mittel[i].x-swi3*mittel[i].z;
    mittel[i].z:=swi3*mittel[i].x+cwi3*mittel[i].z;
    mittel[i].x:=y0;
  end;
  for i:=0 to verdecktzahl2-1 do begin
    x0:=cwi*t2[i].x-swi*t2[i].y;
    t2[i].y:=swi*t2[i].x+cwi*t2[i].y;
    t2[i].x:=x0;
    y0:=cwi2*t2[i].y-swi2*t2[i].z;
    t2[i].z:=swi2*t2[i].y+cwi2*t2[i].z;
    t2[i].y:=y0;
    y0:=cwi3*t2[i].x-swi3*t2[i].z;
    t2[i].z:=swi3*t2[i].x+cwi3*t2[i].z;
    t2[i].x:=y0;
  end;
  for i:=0 to sanzahlb-1 do begin
    x0:=cwi*mittel2[i].x-swi*mittel2[i].y;
    mittel2[i].y:=swi*mittel2[i].x+cwi*mittel2[i].y;
    mittel2[i].x:=x0;
    y0:=cwi2*mittel2[i].y-swi2*mittel2[i].z;
    mittel2[i].z:=swi2*mittel2[i].y+cwi2*mittel2[i].z;
    mittel2[i].y:=y0;
    y0:=cwi3*mittel2[i].x-swi3*mittel2[i].z;
    mittel2[i].z:=swi3*mittel2[i].x+cwi3*mittel2[i].z;
    mittel2[i].x:=y0;
  end;
  for i:=0 to verdecktzahl2-1 do begin
    x0:=cwi*t3[i].x-swi*t3[i].y;
    t3[i].y:=swi*t3[i].x+cwi*t3[i].y;
    t3[i].x:=x0;
    y0:=cwi2*t3[i].y-swi2*t3[i].z;
    t3[i].z:=swi2*t3[i].y+cwi2*t3[i].z;
    t3[i].y:=y0;
    y0:=cwi3*t3[i].x-swi3*t3[i].z;
    t3[i].z:=swi3*t3[i].x+cwi3*t3[i].z;
    t3[i].x:=y0;
  end;
  for i:=0 to sanzahlb-1 do begin
    x0:=cwi*mittel3[i].x-swi*mittel3[i].y;
    mittel3[i].y:=swi*mittel3[i].x+cwi*mittel3[i].y;
    mittel3[i].x:=x0;
    y0:=cwi2*mittel3[i].y-swi2*mittel3[i].z;
    mittel3[i].z:=swi2*mittel3[i].y+cwi2*mittel3[i].z;
    mittel3[i].y:=y0;
    y0:=cwi3*mittel3[i].x-swi3*mittel3[i].z;
    mittel3[i].z:=swi3*mittel3[i].x+cwi3*mittel3[i].z;
    mittel3[i].x:=y0;
  end;
end;

procedure TFInkugel.rechnen(Sender: TObject);
begin
  drehen(winkelx,winkely,winkelz);
end;

procedure TFInkugel.T1Tim(Sender: TObject);
begin
  winkelax:=winkelax+winkelx;
  winkelay:=winkelay+winkely;
  winkelaz:=winkelaz+winkelz;
  rechnen(sender);
  zeichnen(sender);
end;

procedure TFInkugel.B2C(Sender: TObject);
begin
  if timer1.interval=0 then begin
    timer1.interval:=10;
    button1.caption:='Abbruch';
    if (winkelx=0) and (winkely=0) and (winkelz=0) then winkelz:=0.25;
  end else begin
    timer1.interval:=0;
    button1.caption:='Rotation';
  end;
end;

procedure TFInkugel.S8C(Sender: TObject);
var i:integer;
    f:double;
begin
  f:=120/z;   //s1
  if sender=speed2 then f:=1.1;
  if sender=speed3 then f:=1/1.1;
  Z:=f*z;
  for i:=0 to verdecktzahl-1 do begin
    t[i].x:=f*t[i].x;
    t[i].y:=f*t[i].y;
    t[i].z:=f*t[i].z;
  end;
  for i:=0 to verdecktzahl2-1 do begin
    t2[i].x:=f*t2[i].x;
    t2[i].y:=f*t2[i].y;
    t2[i].z:=f*t2[i].z;
  end;
  for i:=0 to verdecktzahl2-1 do begin
    t3[i].x:=f*t3[i].x;
    t3[i].y:=f*t3[i].y;
    t3[i].z:=f*t3[i].z;
  end;
  zeichnen(sender);
end;

procedure TFInkugel.PB1MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button=mbleft then begin
    screen.cursor:=crsizeall;
    live:=true;
    x_alt:=x;
    y_alt:=y;
  end;
end;

procedure TFInkugel.PB1MM(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if live then begin
    if (x<>x_alt) or (y<>y_alt) then begin
      drehen(x_alt-x,y_alt-y,0);
      zeichnen(sender);
      x_alt:=x;
      y_alt:=y;
    end;
  end;
end;

procedure TFInkugel.PB1MU(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  screen.cursor:=crdefault;
  live:=false;
  x_alt:=0;
  y_alt:=0;
end;

procedure TFInkugel.x2C(Sender: TObject);
begin
  b1c(sender);
end;

procedure TFInkugel.t6C(Sender: TObject);
begin
  if sender=spinedit1 then winkelx:=spinedit1.value*0.25;
  if sender=spinedit2 then winkely:=spinedit2.value*0.25;
  if sender=spinedit3 then winkelz:=spinedit3.value*0.25;
  if kabbruch then begin
    rechnen(sender);
    zeichnen(sender);
  end;
end;

procedure TFInkugel.CB1C(Sender: TObject);
begin
  hpunkte:=cpunkte.checked;
  zeichnen(sender);
end;

procedure TFInkugel.FormDestroy(Sender: TObject);
begin
  listempoly1.free;
  listempoly2.free;
end;

procedure TFInkugel.FormShow(Sender: TObject);
var polyederliste:tstringlist;
begin
  polyederliste:=tstringlist.Create;
  listeres(polyederliste,'inkugel');
  Listbox1.Items:=polyederliste;
  polyederliste.free;
  Listbox1.itemindex:=3;
  timer1.interval:=0;
end;

end.

