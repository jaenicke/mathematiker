unit upse;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, Buttons, ComCtrls, StdCtrls, Mask, Spin, CheckLst, Menus;

type
  TForm1 = class(TForm)
    Panel5: TPanel;
    P6: TPanel;
    P8: TPanel;
    P7: TPanel;
    CL1: TCheckListBox;
    P9: TPanel;
    Radiogroup1: TRadioGroup;
    PB1: TPaintBox;
    Panel1: TPanel;
    P12: TPanel;
    Panel4: TPanel;
    LB2: TListBox;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    PB2: TPaintBox;
    Label5: TLabel;
    Spin1: TSpinEdit;
    Spin2: TSpinEdit;
    lb1: TListBox;
    lb3: TListBox;
    lb4: TListBox;
    lb5: TListBox;
    procedure S7C(Sender: TObject);
    procedure PB1P(Sender: TObject);
    procedure CL1C(Sender: TObject);
    procedure PB1M(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Spin1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
var hgfarb:integer;
const
   elxbreite: integer = 52;
   elh: array[1..118] of byte =
     (1,8,1,2,3,4,5,6,7,8,1,2,
      3,4,5,6,7,8,1,2,13,14,15,16,17,
      18,18,18,11,12,3,4,5,6,7,8,
      1,2,13,14,15,16,17,18,18,18,11,12,
      3,4,5,6,7,8,1,2,13,20,20,20,
      20,20,20,20,20,20,20,20,20,20,20,14,
      15,16,17,18,18,18,11,12,3,4,5,6,
      7,8,1,2,13,30,30,30,30,30,30,30,
      30,30,30,30,30,30,30,14,15,16,17,18,18,18,11,12,3,4,5,6,7,8);
    superfarben: array[0..26] of longint =
         ($0000ff00,$00ff0000,$000000FF,$00FF00FF,$0000FFFF,$00ffff00,
          $0000FF80,$00cccccc,$00808080,$00ff0000,$00000080,$00ffff00,$00008080,$00c0c0c0,
          $00808000,$000000c0,$0000c000,$00c00000,$0000c0c0,$00c000c0,$00c0c000,$00FFFFCC,
          $00CCFFFF,$00CCFFCC,$00CCCCFF,$00ffffff,$00cccc99);
   el: array[1..118] of pchar =
     ('H','He','Li','Be','B','C','N','O','F','Ne','Na','Mg',
      'Al','Si','P','S','Cl','Ar','K','Ca','Sc','Ti','V','Cr','Mn',
      'Fe','Co','Ni','Cu','Zn','Ga','Ge','As','Se','Br','Kr',
      'Rb','Sr','Y','Zr','Nb','Mo','Tc','Ru','Rh','Pd','Ag','Cd',
      'In','Sn','Sb','Te','I','Xe','Cs','Ba','La','Ce','Pr','Nd',
      'Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf',
      'Ta','W','Re','Os','Ir','Pt','Au','Hg','Tl','Pb','Bi','Po',
      'At','Rn','Fr','Ra','Ac','Th','Pa','U','Np','Pu','Am','Cm',
      'Bk','Cf','Es','Fm','Md','No','Lr','Rf','Db','Sg','Bh','Hs','Mt','Ds','Rg','Cn','Uut','Fl',
      'Uup','Lv','Uus','Uuo');
   elxx: array[1..118] of integer = // 0 ist 5, breite 35
     (0,17,0,1,12,13,14,15,16,17,0,1,
      12,13,14,15,16,17,0,1,2,3,4,5,6,
      7,8,9,10,11,12,13,14,15,16,17,
      0,1,2,3,4,5,6,7,8,9,10,11,
      12,13,14,15,16,17,0,1,2,3,4,5,
      6,7,8,9,10,11,12,13,14,15,16,3,
      4,5,6,7,8,9,10,11,12,13,14,15,
      16,17,0,1,2,3,4,5,6,7,8,9,
      10,11,12,13,14,15,16,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17);
   ely: array[1..118] of integer =
     (50,50,90,90,90,90,90,90,90,90,
      130,130,130,130,130,130,130,130,
      170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,
      170,170,170,
      210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,
      210,210,210,
      250,250,250,
      332,332,332,332,332,332,332,332,332,332,332,332,332,332,
      250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,
      290,290,290,
      374,374,374,374,374,374,374,374,374,374,374,374,374,374,
      290,290,290,290,290,290,290,290,290,290,290,290,290,1290,290);

var amet,alme,anme,ahal,aede,ahg,ang,alan,aakt,ageschichte:boolean;

procedure TForm1.S7C(Sender: TObject);
begin
    close;
end;

const
   elementzahl=118;
   elf: array[1..elementzahl] of byte =
     (0,6,1,2,5,5,5,5,5,6,1,1,
      2,5,5,5,5,6,1,1,3,4,4,4,4,
      4,4,3,3,4,2,2,2,5,5,6,
      1,1,3,4,4,4,4,4,3,3,3,3,
      2,2,2,2,5,6,1,1,3,3,3,3,
      3,3,3,3,3,3,3,3,3,3,3,4,
      4,4,4,4,3,3,3,3,2,2,1,2,
      5,6,1,1,3,3,3,3,3,3,3,3,
      3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4);
   elm: array[1..elementzahl] of byte =
     (4,3,0,0,4,4,4,4,2,3,0,0,0,4,4,4,2,3,0,0,1,0,1,1,1,
      1,1,1,1,1,1,4,4,4,2,3,0,0,1,1,1,1,1,1,1,1,1,1,
      1,1,4,4,2,3,0,0,1,5,5,5,5,5,5,5,5,5,5,5,5,5,5,1,
      1,1,1,1,1,1,1,1,1,1,1,1,2,3,0,0,1,6,6,6,6,6,6,6,
      6,6,6,6,6,6,6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);

procedure TForm1.PB1P(Sender: TObject);
var bitmap:tbitmap;
    ziel:tcanvas;
    kk,ks:string;
    i,spezf,vo:integer;
    rr,au,ao,at:real;
    hist:boolean;
    histor:array[1..118] of smallint;
    liste:tstringlist;
    qu:integer;
    code:integer;
procedure tsout(a,b:integer;const c:string);
begin
    ziel.textout(a-30,b-110,c)
end;
procedure leg(can:tcanvas);
var i,off:integer;
    k:string;
begin
    if elxbreite>50 then off:=50
                    else off:=0;
    can.pen.style:=psclear;
    can.brush.color:=clwhite;
    can.rectangle(190+off,32,420+off,110);
    can.pen.style:=pssolid;
    can.font.size:=8;
    can.brush.style:=bsclear;
    if hgfarb<>17 then
      can.textout(194+off,36,Radiogroup1.items.strings[hgfarb])
    else
      can.textout(194+off,36,Radiogroup1.items.strings[hgfarb]+' bei '+inttostr(spin2.value)+'°C');
    for i:=0 to 4 do
    begin
      k:=lb1.items.strings[10*hgfarb+i];
      can.brush.style:=bsclear;
      can.textout(220+off,49+i*10,k);
      if k<>'' then
      begin
        can.brush.style:=bssolid;
        can.brush.color:=superfarben[i];
        can.rectangle(194+off,52+i*10,214+off,61+i*10);
      end;
    end;
    for i:=0 to 4 do
    begin
      k:=lb1.items.strings[5+10*hgfarb+i];
      can.brush.style:=bsclear;
      can.textout(340+off,49+i*10,k);
      if k<>'' then
      begin
        can.brush.style:=bssolid;
        can.brush.color:=superfarben[i+5];
        can.rectangle(314+off,52+i*10,334+off,61+i*10);
      end;
    end;
    can.font.size:=10;
end;
procedure element(nr:integer);
var a,b:integer;
procedure pinsel2(s:integer);
begin
    ziel.brush.color:=superfarben[s];
end;
begin
    hist:=(not ageschichte) or (histor[nr]<=spin1.value);
    a:=elxx[nr]*elxbreite;
    b:=ely[nr]+10;
    if ((amet and (elm[nr] in [1,5,6])) or (alme and (elm[nr]=0)) or
      (anme and (elm[nr]=4)) or (ahal and (elm[nr]=2)) or (aede and (elm[nr]=3)))
      and
      ((ahg and (elh[nr]<10)) or (ang and (elh[nr]>10) and (elh[nr]<20))
       or (alan and (elh[nr]=20)) or (aakt and (elh[nr]=30)))
      and hist then
    begin
      case hgfarb of
        0 : pinsel2(elf[nr]);
        1 : if elh[nr]>=20 then pinsel2(0)
                           else pinsel2(elh[nr] mod 10-1);
        2 : pinsel2(elm[nr]);
        3 : case spezf of
             0 : pinsel2(0);
             7..9 : pinsel2(1);
             10..14 : pinsel2(2);
             15..19 : pinsel2(3);
             20..24 : pinsel2(4);
             25..32 : pinsel2(5);
             else pinsel2(6);
            end;
        4 : case spezf of
              1..1699 : pinsel2(1);
              1700..1749 : pinsel2(2);
              1750..1799 : pinsel2(3);
              1800..1849 : pinsel2(4);
              1850..1899 : pinsel2(5);
              1900..1949 : pinsel2(6);
              1950..2019 : pinsel2(7);
              else pinsel2(0);
            end;
        5 : case spezf of
              -1 : pinsel2(0);
              0,-10000 : pinsel2(2);
              1..2 : pinsel2(3);
              3..4 : pinsel2(4);
              5..7 : pinsel2(5);
              8..9 : pinsel2(6);
              10..14 : pinsel2(7);
              15..30 : pinsel2(8);
              else pinsel2(1);
            end;
        6 : case spezf of
              -300..-100 : pinsel2(0);
              -99..0 : pinsel2(1);
              1..100 : pinsel2(2);
              101..400 : pinsel2(3);
              401..800 : pinsel2(4);
              801..1200 : pinsel2(5);
              1201..2000 : pinsel2(6);
              2001..3000 : pinsel2(7);
              3001..6000 : pinsel2(8);
              else pinsel2(9);
            end;
        7 : case spezf of
              -300..-100 : pinsel2(0);
              -99..200 : pinsel2(1);
              201..1000 : pinsel2(2);
              1001..1800 : pinsel2(3);
              1801..2400 : pinsel2(4);
              2401..3000 : pinsel2(5);
              3001..4000 : pinsel2(6);
              4001..5000 : pinsel2(7);
              5001..6000 : pinsel2(8);
              else pinsel2(9);
            end;
     8,11 : case spezf of
              -10000..0 : pinsel2(0);
              1..20 : pinsel2(1);
              21..40 : pinsel2(2);
              41..60 : pinsel2(3);
              61..80 : pinsel2(4);
              81..100 : pinsel2(5);
              101..150 : pinsel2(6);
              151..200 : pinsel2(7);
              201..250 : pinsel2(8);
              else pinsel2(9);
            end;
        9 : case spezf of
              -10000..0 : pinsel2(0);
              1..500 : pinsel2(1);
              501..600 : pinsel2(2);
              601..700 : pinsel2(3);
              701..800 : pinsel2(4);
              801..1000 : pinsel2(5);
              1001..1200 : pinsel2(6);
              1201..1500 : pinsel2(7);
              1501..2000 : pinsel2(8);
              else pinsel2(9);
            end;
       14 : case spezf of
              0 : pinsel2(0);
              1..800 : pinsel2(1);
              801..1000 : pinsel2(2);
              1001..1200 : pinsel2(3);
              1201..1500 : pinsel2(4);
              1501..2000 : pinsel2(5);
              2001..2500 : pinsel2(6);
              2501..3000 : pinsel2(7);
              3001..3500 : pinsel2(8);
              else pinsel2(9);
            end;
       15 : case spezf of
              0 : pinsel2(0);
              1..800 : pinsel2(1);
              801..1200 : pinsel2(2);
              1201..1600 : pinsel2(3);
              1601..2000 : pinsel2(4);
              2001..2500 : pinsel2(5);
              2501..3000 : pinsel2(6);
              3001..4000 : pinsel2(7);
              4001..10000 : pinsel2(8);
              else pinsel2(9);
            end;
       16 : pinsel2(spezf);
       10 : case spezf of
              0..1 : pinsel2(0);
              2..10 : pinsel2(1);
              11..50 : pinsel2(2);
              51..100 : pinsel2(3);
              101..500 : pinsel2(4);
              501..1000 : pinsel2(5);
              1001..2000 : pinsel2(6);
              2001..25000 : pinsel2(7);
              else pinsel2(9);
            end;
       12 : case spezf of
              0..100 : pinsel2(0);
              101..200 : pinsel2(1);
              201..300 : pinsel2(2);
              301..400 : pinsel2(3);
              401..500 : pinsel2(4);
              501..600 : pinsel2(5);
              601..700 : pinsel2(6);
              701..800 : pinsel2(7);
              801..25000 : pinsel2(8);
              else pinsel2(9);
            end;
       17 : if kk<>'' then
            begin
              case kk[1] of
                '-' : pinsel2(0);
                'f' : pinsel2(1);
                'l' : pinsel2(2);
                'g' : pinsel2(3);
                'k' : pinsel2(5);
                 else
                 begin
                   if (at<ao) then pinsel2(1);
                   if (at>=ao) and (at<au) then pinsel2(2);
                   if (at>=au) then pinsel2(3);
                 end;
              end
            end
            else pinsel2(0);
       13 : if spezf<7 then pinsel2(spezf+3) else pinsel2(9);
       18 : case spezf of
              1..200 : pinsel2(1);
              201..400 : pinsel2(2);
              401..600 : pinsel2(3);
              601..800 : pinsel2(4);
              801..1000 : pinsel2(5);
              1001..2000 : pinsel2(6);
              2001..30000 : pinsel2(7);
              else pinsel2(0);
            end;
      end;

      ziel.rectangle(a+69,b-30,a+69+elxbreite,b+10);
      ziel.pen.color:=clwhite;
      ziel.moveto(a+69,b+8);
      ziel.lineto(a+69,b-30);
      ziel.lineto(a+68+elxbreite,b-30);
      ziel.pen.color:=$00808080;
      ziel.moveto(a+67+elxbreite,b-29);
      ziel.lineto(a+67+elxbreite,b+8);
      ziel.lineto(a+70,b+8);
      if elxbreite>50 then
      begin
        ziel.textout(a+75,b-28,inttostr(nr));
        ziel.textout(a+86,b-12,el[nr]);
      end
      else
      begin
        ziel.textout(a+73,b-28,inttostr(nr));
        ziel.textout(a+78,b-12,el[nr]);
      end
    end
    else
    begin
      ziel.Brush.style:=bsclear;
      ziel.rectangle(a+69,b-30,a+70+elxbreite,b+11);
    end;
end;
begin
    Bitmap := TBitmap.Create;
    Bitmap.Width := pb1.Width;
    Bitmap.Height := pb1.Height;
    ziel:=bitmap.canvas;

    ziel.font.name:='Verdana';
    ziel.font.size:=10;

    at:=round(spin2.value);
    leg(ziel);
    ziel.Brush.style:=bsclear;
    if elxbreite>50 then vo:=0
                    else vo:=7;
    tsout(116,123,'Ia');
    tsout(115+elxbreite-vo,163,'IIa');
    tsout(113+2*elxbreite-vo,243,'IIIb');
    tsout(114+3*elxbreite-vo,243,'IVb');
    tsout(114+4*elxbreite-vo,243,'Vb');
    tsout(114+5*elxbreite-vo,243,'VIb');
    tsout(113+6*elxbreite-vo,243,'VIIb');
    tsout(108+7*elxbreite-vo,243,'VIIIb');
    tsout(113+10*elxbreite-vo,243,'Ib');
    tsout(113+11*elxbreite-vo,243,'IIb');
    tsout(113+12*elxbreite-vo,163,'IIIa');
    tsout(113+13*elxbreite-vo,163,'IVa');
    tsout(113+14*elxbreite-vo,163,'Va');
    tsout(113+15*elxbreite-vo,163,'VIa');
    tsout(112+16*elxbreite-vo,163,'VIIa');
    tsout(106+17*elxbreite-vo,123,'VIIIa');

    if ageschichte then
    begin
      liste:=tstringlist.create;
      liste.assign(lb4.Items);
      qu:=liste.indexof('[Zeit]')+1;
      for i:=1 to elementzahl do
      begin
        kk:=liste[qu]; inc(qu);
        val(copy(kk,1,4),histor[i],code);
        if code<>0 then histor[i]:=1500;
      end;
      liste.free;
    end;

    if hgfarb>2 then
    begin
      liste:=tstringlist.create;
      liste.assign(lb4.Items);
      case hgfarb of
        3 : ks:='[Neg]';
        4 : ks:='[Zeit]';
        5 : ks:='[Dichte]';
        6 : ks:='[STEmp]';
        7 : ks:='[SiTemp]';
        8 : ks:='[IRadius]';
        9 : ks:='[IVolt]';
       10 : ks:='[Erde]';
       11 : ks:='[ARadius]';
       12 : ks:='[Enthalpie]';
       13 : ks:='[Wert]';
       14 : ks:='[IVolt2]';
       15 : ks:='[IVolt3]';
       16 : ks:='[ES]';
       17 : ks:='[Agg2]';
       18 : ks:='[SHeat]';
      end;
      qu:=liste.indexof(ks)+1;
    end;

    for i:=1 to elementzahl do
    begin
      case hgfarb of
        3 : begin
              kk:=liste[qu];
              inc(qu);
              val(kk,rr,code);
              spezf:=trunc(10*rr);
            end;
       13 : begin
              kk:=liste[qu];
              inc(qu);
              val(copy(kk,1,2),spezf,code);
            end;
        4 : begin
              kk:=liste[qu];
              inc(qu);
              val(copy(kk,1,4),spezf,code);
            end;
        5 : begin
              kk:=liste[qu];
              inc(qu);
              val(kk,rr,code);
              if code<>0 then spezf:=-1000
              else
              begin
                if rr<0 then spezf:=-1
                        else spezf:=trunc(rr);
              end;
            end;
    6,7,8,11,12,18 :
            begin
              kk:=liste[qu];
              inc(qu);
              val(kk,rr,code);
              spezf:=trunc(rr);
              if code<>0 then spezf:=-10000
            end;
  14,15,9 : begin
              kk:=liste[qu];
              inc(qu);
              val(kk,rr,code);
              spezf:=trunc(100*rr);
            end;
       10 : begin
              kk:=liste[qu];
              inc(qu);
              val(kk,rr,code);
              spezf:=trunc(10*rr);
            end;
       16 : begin
              if i<96 then
              begin
                kk:=liste[qu];
                inc(qu);
                val(copy(kk,pos(',',kk)+1,255),spezf,code);
              end
              else spezf:=0;
            end;
       17 : begin
              kk:=liste[qu];
              inc(qu);
              val(copy(kk,1,pos('/',kk)-1),ao,code);
              val(copy(kk,pos('/',kk)+1,255),au,code);
              if code<>0 then kk:='-' else kk:='#';
            end;
      end;
      element(i);
    end;
    if hgfarb>2 then liste.free;

    pb1.canvas.draw(0,0,bitmap);
    Bitmap.Free;
end;

procedure TForm1.CL1C(Sender: TObject);
begin
    amet:=cl1.checked[1];
    alme:=cl1.checked[0];
    anme:=cl1.checked[2];
    ahal:=cl1.checked[3];
    aede:=cl1.checked[4];
    ahg:=cl1.checked[5];
    ang:=cl1.checked[6];
    alan:=cl1.checked[7];
    aakt:=cl1.checked[8];
    ageschichte:=cl1.checked[9];
    pb1p(sender);
end;

procedure TForm1.PB1M(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const _gruppe : array[100..107] of string[19]
     = ('; Alkaligruppe','; Erdalkaligruppe','; Borgruppe','; Kohlenstoffgruppe',
        '; Stickstoffgruppe','; Chalkogengruppe','; Halogengruppe','; Edelgase');
var i,nr,z,sc:integer;
    r:real;
    kk,k1,k2:string;
    liste:tstringlist;
    code:integer;
procedure stabil(sel:integer);
var i,j:integer;
    x,y,x0,y0:integer;
    wi,wi0:real;
    kp,kk:string;
    anteil:array[1..15] of real;
    masse:array[1..15] of integer;
    radio:array[1..15] of boolean;
    bitmap:tbitmap;
    liste2:tstringlist;
    lnr:integer;
begin
    Bitmap := TBitmap.Create;
    Bitmap.Width := pb2.Width;
    Bitmap.Height := pb2.Height;

    kp:=strpas(el[sel+1]);
    liste2:=tstringlist.create;
    liste2.assign(lb5.Items);
    i:=0;
    lnr:=0;
    repeat
      kk:=liste2[lnr];
      inc(lnr);
      if copy(kk,1,pos('-',kk)-1)=kp then
      begin
        inc(i);
        delete(kk,1,pos('-',kk));
        if kk[1]='*' then
        begin
          radio[i]:=true;
          delete(kk,1,1);
        end
        else radio[i]:=false;
        val(kk,masse[i],code);
        val(liste2[lnr],anteil[i],code);
        inc(lnr);
      end;
    until (lnr>liste2.count-1);//eof(dd);
    liste2.free;
    if i=0 then lb2.items.add('Keine stabilen oder extrem langlebigen Isotope')
    else
    begin
      if i=1 then lb2.items.add('Reinelement')
             else lb2.items.add('Mischelement');
      wi0:=0;
      x0:=1;
      y0:=100;
      if i>1 then
      begin
        for j:=1 to i do
        begin
          wi:=3.6*anteil[j]+wi0;
          if round(3.6*anteil[j])=360 then wi:=wi-1;
          x:=round(100.0*sin(pi/180*wi));
          y:=round(100.0*cos(pi/180*wi));
          bitmap.canvas.brush.color:=superfarben[j+1];
          bitmap.canvas.pie(5,5,81,81,43-x0,43-y0,43-x,43-y);
          x0:=x-1;
          y0:=y;
          wi0:=wi;
          str(masse[j],kk);
          kk:=#9+'Isotop '+kk+' : '+floattostr(anteil[j])+' %';
          if radio[j] then kk:=kk+' , aktiv';
          lb2.items.add(kk);
        end;
      end
      else
      begin
        bitmap.canvas.brush.color:=superfarben[3];
        bitmap.canvas.ellipse(5,5,81,81);
        str(masse[1],kk);
        kp:=floattostr(anteil[1]);
        lb2.items.add(#9+'Isotop '+kk+' : '+kp+' %');
      end;
    end;
    bitmap.canvas.Brush.style:=bsclear;
    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.size:=8;
    bitmap.canvas.TextOut(5,bitmap.height-40,'Stabile Isotope');
    pb2.canvas.draw(0,0,bitmap);
    Bitmap.Free;
end;
begin
    nr:=0;
    i:=1;
    repeat
      if (x-70>=elxx[i]*elxbreite) and (x-70-elxbreite<elxx[i]*elxbreite) and
         (y+20>=ely[i]) and (y-20<ely[i])
      then nr:=i;
      inc(i);
    until (i>elementzahl) or (nr<>0);
    if nr<>0 then
    begin
      lb2.Clear;
      p12.caption:='  '+inttostr(nr)+'  '+lb3.items.strings[nr-1]+' : '+el[nr];
      lb2.items.add('lateinischer Name'#9+lb3.items.strings[nr+117]);
      if elh[nr]<10 then
      begin
        str(elh[nr],kk);
        kk:=kk+'.Hauptgruppe'+_gruppe[99+elh[nr]];
      end;
      if (elh[nr]>10) and (elh[nr]<20) then
      begin
        str(elh[nr]-10,kk);
        kk:=kk+'.Nebengruppe';
      end;
      if elh[nr]=20 then kk:=kk+'; Lanthanid';
      if elh[nr]=30 then kk:=kk+'; Aktinid';
      case elm[nr] of
        1,5,6 : kk:=kk+' Metall';
            0 : kk:=kk+' Leichtmetall';
            4 : kk:=kk+' Nichtmetall';
      end;
      lb2.items.add(kk);

      liste:=tstringlist.create;
      liste.assign(lb4.Items);

      kk:=liste[liste.indexof('[Atommasse]')+nr];
      lb2.items.add('relative Atommasse'#9+kk);

      kk:=liste[liste.indexof('[EKonfig]')+nr];
      lb2.items.add('Elektronenkonfiguration'#9+kk);

      kk:=liste[liste.indexof('[Neg]')+nr];
      lb2.items.add('Elektronegativität'#9+kk);

      kk:=liste[liste.indexof('[Zeit]')+nr];
      val(copy(kk,1,4),z,code);
      if z<>0 then lb2.items.add('Entdeckung'#9+kk)
              else lb2.items.add('Entdeckung'#9+'bekannt seit dem Altertum');

      kk:=liste[liste.indexof('[Dichte]')+nr];
      val(kk,r,code);
      if r=0 then kk:='Dichte'#9'unbekannt';
      if r<0 then kk:='Dichte'#9+copy(kk,2,50)+' g/l';
      if r>0 then kk:='Dichte'#9+kk+' g/cm³';
      lb2.items.add(kk);

      kk:=liste[liste.indexof('[STEmp]')+nr];
      val(kk,z,code);
      if z=0 then kk:='unbekannt'
             else kk:=kk+'°C';
      lb2.items.add('Schmelztemperatur'#9+kk);

      kk:=liste[liste.indexof('[SiTemp]')+nr];
      val(kk,z,code);
      if z=0 then kk:='unbekannt'
             else kk:=kk+'°C';
      lb2.items.add('Siedetemperatur'#9+kk);

      kk:=liste[liste.indexof('[engl]')+nr];
      if (kk<>'-') and (kk<>'+') then lb2.items.add('englischer Name'#9+kk);

      kk:=liste[liste.indexof('[franz]')+nr];
      if (kk<>'-') and (kk<>'+') then lb2.items.add('französischer Name'#9+kk);

      kk:=liste[liste.indexof('[Schalen]')+nr];
      kk:=kk+'00000000000000000';
      lb2.items.add('Orbitalbelegung (Grundzustand)'#9+'1s = '+kk[1]);
      lb2.items.add(#9+'2s = '+kk[2]+'    2p = '+kk[3]);
      if kk[6]=':' then k1:='10'
                   else k1:=kk[6];
      lb2.items.add(#9+'3s = '+kk[4]+'    3p = '+kk[5]+'    3d = '+k1);
      if kk[9]=':' then k1:='10'
                   else k1:=kk[9];
      sc:=ord(kk[10])-48; str(sc,k2);
      lb2.items.add(#9+'4s = '+kk[7]+'    4p = '+kk[8]+'    4d = '+k1+'    4f = '+k2);
      if kk[13]=':' then k1:='10'
                    else k1:=kk[13];
      sc:=ord(kk[14])-48; str(sc,k2);
      lb2.items.add(#9+'5s = '+kk[11]+'    5p = '+kk[12]+'    5d = '+k1+'    5f = '+k2);
      if kk[17]=':' then k1:='10'
                    else k1:=kk[17];
      lb2.items.add(#9+'6s = '+kk[15]+'    6p = '+kk[16]+'    6d = '+k1);
      lb2.items.add(#9+'7s = '+kk[18]+'    7p = '+kk[19]);
      liste.free;
      stabil(nr-1);
    end;
end;

procedure TForm1.PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var nr,i:integer;
begin
    nr:=0;
    i:=1;
    repeat
      if (x-70>=elxx[i]*elxbreite) and (x-70-elxbreite<elxx[i]*elxbreite) and
         (y+20>=ely[i]) and (y-20<ely[i])
      then nr:=i;
      inc(i);
    until (i>elementzahl) or (nr<>0);
    if nr<>0 then pb1.cursor:=crhandpoint else pb1.cursor:=crdefault;
end;

procedure TForm1.FormShow(Sender: TObject);
var i:integer;
begin
    lb2.doublebuffered:=true;
    elxbreite:=40;
    for i:=0 to 8 do cl1.Checked[i]:=true;
    amet:=true;
    alme:=true;
    anme:=true;
    ahal:=true;
    aede:=true;
    ahg:=true;
    ang:=true;
    alan:=true;
    aakt:=true;
    ageschichte:=false;
    hgfarb:=Radiogroup1.ItemIndex;
    label3.visible:=hgfarb=17;
    label4.visible:=hgfarb=17;
    spin2.visible:=hgfarb=17;
    pb1p(sender);
end;

procedure TForm1.Spin1Change(Sender: TObject);
begin
    hgfarb:=Radiogroup1.ItemIndex;
    label3.visible:=hgfarb=17;
    label4.visible:=hgfarb=17;
    spin2.visible:=hgfarb=17;
    pb1p(sender);
end;

end.
