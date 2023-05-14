unit zahlzeich;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  gifimage, ExtCtrls, ComCtrls, Menus, StdCtrls, Spin;

type
  Tzahlz = class(TForm)
    P1: TPanel;
    l1: TLabel;
    zI2: TImage;
    ze1: TEdit;
    zI1: TImage;
    l3: TLabel;
    MM1: TMainMenu;
    M2: TMenuItem;
    P3: TPanel;
    PG1: TPageControl;
    T1: TTabSheet;
    P11: TPanel;
    sp06: TPanel;
    tp29: TPanel;
    P71: TPanel;
    sp01: TPanel;
    l2: TLabel;
    tp27: TPanel;
    sp34: TPanel;
    tp26: TPanel;
    P72: TPanel;
    sp35: TPanel;
    tp28: TPanel;
    P27: TPanel;
    sp21: TPanel;
    PB2: TPaintBox;
    tp21: TPanel;
    sp28: TPanel;
    PB7: TPaintBox;
    tp23: TPanel;
    sp20: TPanel;
    tp30: TPanel;
    P53: TPanel;
    sp59: TPanel;
    tp24: TPanel;
    P22: TPanel;
    sp26: TPanel;
    tp31: TPanel;
    P29: TPanel;
    sp32: TPanel;
    tp20: TPanel;
    P42: TPanel;
    sp31: TPanel;
    tp3: TPanel;
    P7: TPanel;
    sp38: TPanel;
    tp19: TPanel;
    P64: TPanel;
    sp03: TPanel;
    tp22: TPanel;
    P14: TPanel;
    sp40: TPanel;
    tp7: TPanel;
    P37: TPanel;
    P2: TPanel;
    sp46: TPanel;
    P6: TPanel;
    tp8: TPanel;
    sp51: TPanel;
    tp2: TPanel;
    P61: TPanel;
    sp33: TPanel;
    PB9: TPaintBox;
    tp10: TPanel;
    sp39: TPanel;
    tp16: TPanel;
    P62: TPanel;
    sp42: TPanel;
    tp12: TPanel;
    P60: TPanel;
    sp50: TPanel;
    tp9: TPanel;
    P40: TPanel;
    sp52: TPanel;
    tp11: TPanel;
    P38: TPanel;
    sp56: TPanel;
    tp5: TPanel;
    P28: TPanel;
    sp37: TPanel;
    tp1: TPanel;
    P36: TPanel;
    sp36: TPanel;
    tp17: TPanel;
    P39: TPanel;
    sp53: TPanel;
    tp13: TPanel;
    P34: TPanel;
    sp57: TPanel;
    tp14: TPanel;
    P26: TPanel;
    sp24: TPanel;
    tp15: TPanel;
    P41: TPanel;
    T2: TTabSheet;
    P32: TPanel;
    sp58: TPanel;
    tp55: TPanel;
    P25: TPanel;
    sp07: TPanel;
    tp47: TPanel;
    P12: TPanel;
    sp10: TPanel;
    tp6: TPanel;
    P9: TPanel;
    sp23: TPanel;
    tp52: TPanel;
    P45: TPanel;
    sp02: TPanel;
    tp50: TPanel;
    P4: TPanel;
    sp19: TPanel;
    tp53: TPanel;
    P57: TPanel;
    sp14: TPanel;
    tp54: TPanel;
    P20: TPanel;
    sp45: TPanel;
    tp49: TPanel;
    P68: TPanel;
    sp27: TPanel;
    tp57: TPanel;
    P21: TPanel;
    sp29: TPanel;
    tp59: TPanel;
    P17: TPanel;
    sp12: TPanel;
    tp48: TPanel;
    P19: TPanel;
    sp49: TPanel;
    tp56: TPanel;
    P69: TPanel;
    sp48: TPanel;
    tp58: TPanel;
    P70: TPanel;
    P5: TPanel;
    sp44: TPanel;
    P48: TPanel;
    tp38: TPanel;
    sp18: TPanel;
    tp33: TPanel;
    P35: TPanel;
    sp22: TPanel;
    tp37: TPanel;
    P49: TPanel;
    sp11: TPanel;
    tp4: TPanel;
    P8: TPanel;
    sp55: TPanel;
    P31: TPanel;
    tp35: TPanel;
    sp04: TPanel;
    tp40: TPanel;
    P18: TPanel;
    sp08: TPanel;
    tp39: TPanel;
    P10: TPanel;
    sp17: TPanel;
    tp34: TPanel;
    P23: TPanel;
    sp09: TPanel;
    tp42: TPanel;
    P65: TPanel;
    sp30: TPanel;
    tp36: TPanel;
    P13: TPanel;
    sp15: TPanel;
    tp43: TPanel;
    P24: TPanel;
    sp16: TPanel;
    tp44: TPanel;
    P30: TPanel;
    sp54: TPanel;
    tp32: TPanel;
    P33: TPanel;
    sp43: TPanel;
    tp45: TPanel;
    P73: TPanel;
    sp47: TPanel;
    tp51: TPanel;
    P67: TPanel;
    P16: TPanel;
    PB1: TPaintBox;
    tp41: TPanel;
    sp13: TPanel;
    tp18: TPanel;
    P63: TPanel;
    sp05: TPanel;
    tp25: TPanel;
    P15: TPanel;
    sp41: TPanel;
    tp46: TPanel;
    P66: TPanel;
    SpinButton1: TSpinButton;
    procedure schl1Click(Sender: TObject);
    procedure PaintBox11Paint(Sender: TObject);
    procedure ze1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PB9Paint(Sender: TObject);
    procedure PB2Paint(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  zahlz: Tzahlz;

implementation

{$R *.DFM}
const grenze=79999;

var schriftinstall:array[1..5] of boolean;
    fonthandle: array[1..5] of thandle;

//Schriftart laden
function fontladen(const name:string;i:integer):boolean;
var ms1: TResourcestream;
    ms: TMemoryStream;
    cn: dword;
begin
    ms1 := TResourceStream.Create(hinstance,name,'RT_RCDATA');
    try
      ms:= TMemoryStream.Create;
      try
        ms.CopyFrom(ms1, 0);
        fonthandle[i]:=AddFontMemResourceEx(ms.Memory, ms.Size, nil, @cn);
        fontladen:=true;
      finally
        ms.Free;
      end;
    finally
      ms1.Free;
    end;
end;

//Eingabeoperation
function  ein_int(const edit:tedit):integer;
var kk:string;
    x,code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    if code<>0 then ein_int:=0
               else ein_int:=x;
end;

//GIF aus der Ressource laden
procedure gifres(image:timage;const f:string);
var
  Stream		: TStream;
  GIF			: TGIFImage;
  Bitmap		: TBitmap;
begin
  Stream := TResourceStream.Create(hInstance,f,'GIF');
  try
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromStream(Stream);
      Image.Picture.Assign(nil);
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(GIF);
        Image.Picture.Assign(Bitmap);
      finally
        Bitmap.Free;
      end;
    finally
      GIF.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure Tzahlz.schl1Click(Sender: TObject);
begin
  close
end;

//Zahl umwandeln
procedure Tzahlz.PaintBox11Paint(Sender: TObject);
var z,r,a,i,p,j,code:integer;
    bitmap:tbitmap;
    k,k2,ke,km:string;
    w:string;

function transform(z,b:integer):string;
var k:string;
begin
    k:='';
    repeat
      r:=z mod b;
      k:=chr(32+r)+k;
      z:=z div b;
    until z=0;
    transform:=k;
end;

procedure malen;
begin
    bitmap.Canvas.draw(p,0,zi2.picture.bitmap);
    p:=p+zi2.width;
end;

//Zeichen aus anderer Schrift lesen
//der String wird Zeichen für Zeichen verändert
function meinstring(start:integer):string;
var i:integer;
    w:string;
begin
    w:='';
    for i:=1 to length(k) do w:=w+chr(start+(ord(k[i])-48));  //normale Reihenfolge
    meinstring:=' '+w;
end;

function meinstringr(start:integer):string;
var i:integer;
    w:string;
begin
    w:='';
    for i:=1 to length(k) do w:=chr(start+(ord(k[i])-48))+w;  //umgekehrte Reihenfolge
    meinstringr:=' '+w;
end;

//Postcode
procedure meinwide67;
const postcode : array[0..9] of string[5] =
      ('11100','00111','01011','10011','01101','10101','11001','01110','10110','11010');
var i,j,z:integer;
    w,k:string;
begin
    k:=ze1.Text;
    w:='';
    if length(k)>0 then
    begin
      for i:=1 to length(k) do
      begin
        z:=ord(k[i])-48;
        if z in [0..9] then
        begin
          for j:=1 to 5 do
          begin
            if postcode[z][j]='1' then w:=w+'j' else w:=w+' ';
          end
        end
      end;
    end;
    p67.caption:=' '+w;
end;

//Zahlumwandlung zu beliebiger Basis
function basisstring(start:integer;basis:integer):string;
var z,code:integer;
begin
    val(k,z,code);
    w:='';
    repeat
      w:=chr(start +z mod basis)+w;
      z:=z div basis;
    until z=0;
    basisstring:=w;
end;

//Umwandlung in römische Schreibweise
procedure roem(x:longint);
var k:string;
procedure ziffer(x:longint;e,f,z:char);
var kk:longint;
begin
    if x=9 then k:=k+e+z
    else
      if x>4 then
      begin
        k:=k+f;
        for kk:=x downto 6 do k:=k+e;
      end
      else
      if x=4 then k:=k+e+f
      else
        for kk:=x downto 1 do k:=k+e;
end;
begin
    if x>4999 then
    begin
      ziffer((x div 1000) div 100,'C','D','M');
      ziffer((x div 1000) div 10-10*((x div 1000) div 100),'X','L','C');
      ziffer((x div 1000) mod 10,'I','V','X');
      x:=x mod 1000;
      k:=k+'''M';
      ziffer(x div 100,'C','D','M');
      ziffer(x div 10-10*(x div 100),'X','L','C');
      ziffer(x mod 10,'I','V','X');
    end
    else
    begin
    while x>999 do
    begin
      x:=x-1000;
      k:=k+'M';
    end;
    ziffer(x div 100,'C','D','M');
    ziffer(x div 10-10*(x div 100),'X','L','C');
    ziffer(x mod 10,'I','V','X');
  end;
  l2.caption:=k;
end;

//Hauptroutine
begin
    ke:=ze1.text;
    l3.caption:='';
    if (length(ke)>0) then
    begin
      val(ke,z,code);
      if code<>0 then
      begin
        ke:='0';
        ze1.text:='0'
      end;
      z:=ein_int(ze1);
      if (z<=grenze) and (z>=0) then
      begin
        roem(z);

        //Umwandlung in Amharisch
        z:=ein_int(ze1);
        w:='';
        a:=z div 10000;
        if a>0 then
        begin
          w:=w+chr(222+a);
          w:=w+chr(242);
        end;
        z:=z mod 10000;
        a:=z div 1000;
        if a>0 then
        begin
          w:=w+chr(222+a+9);
          w:=w+chr(241);
        end;
        z:=z mod 1000;
        a:=z div 100;
        if a>0 then
        begin
          w:=w+chr(222+a);
          w:=w+chr(241);
        end;
        z:=z mod 100;
        a:=z div 10;
        if a>0 then w:=w+chr(222+a+9);
        z:=z mod 10;
        if z>0 then w:=w+chr(222+z);
        p36.caption:=' '+w;

        //Sanskrit
        z:=ein_int(ze1);
        w:='';
        if z>=10000 then
        begin
          a:=z div 10000;
          w:=chr(160+a)+chr(194)+w;
        end;
        z:=z mod 10000;
        if z>=3000 then
        begin
          a:=z div 1000;
          w:=chr(160)+chr(184+a)+w;
        end
        else
        begin
          if z>=2600 then
          begin
            w:=chr(160)+chr(186)+w;
            a:=z-2000;
            a:=a div 100;
            w:=chr(160)+chr(160+a)+w;
            z:=z mod 100;
          end
          else
          begin
            if z>=1000 then
            begin
              a:=z div 100 - 9;
              w:=chr(160)+chr(169+a)+w;
              z:=z mod 100;
            end;
          end;
        end;
        z:=z mod 1000;
        if z>=100 then
        begin
          a:=z div 100;
          w:=chr(160)+chr(160+a)+w;
        end;
        z:=z mod 100;
        if z>0 then
        begin
          if z>=30 then
          begin
            a:=z div 10;
            w:=chr(183+a)+w;
            z:=z mod 10;
            if z>0 then w:=chr(160+z)+w;
          end
          else
          begin
            if z>=26 then
            begin
              w:=chr(170)+w;
              a:=z-20;
              w:=chr(160+a)+w;
            end
            else
            begin
              if z>=10 then
              begin
                a:=z-9;
                w:=chr(169+a)+w
              end
              else
              begin
                w:=chr(160+z)+w
              end
            end;
          end;
        end;
        p27.caption:=' '+w;

        //Armenisch
        z:=ein_int(ze1);
        w:='';
        a:=z div 10000;
        if a>0 then w:=w+chr(60+a);
        z:=z mod 10000;
        a:=z div 1000;
        if a>0 then w:=w+chr(87+a);
        z:=z mod 1000;
        a:=z div 100;
        if a>0 then w:=w+chr(78+a);
        z:=z mod 100;
        a:=z div 10;
        if a>0 then w:=w+chr(69+a);
        z:=z mod 10;
        if z>0 then w:=w+chr(60+z);
        p40.caption:=' '+w;

        //Dezimalsystem mit anderer Schriftart
        k:=ze1.Text;
        if length(k)>0 then
        begin
          p6.caption:=meinstring(58);       //Arabisch
          p60.caption:=meinstring(71);      //Bengali
          p63.caption:=meinstring(81);      //Hindi
          p26.caption:=meinstring(245);     //Fingerzahlen
          p7.caption:=meinstring(131);      //Semaphor

          p72.caption:=meinstringr(110);    //N'ko rückwärts
          p34.caption:=meinstring(243);     //Braille
          p33.caption:=meinstring(48);      //Brahmi
          p71.caption:=meinstring(223);     //Tibetisch
          p29.caption:=meinstring(233);     //Zählstabzahlen
        end;
        meinwide67;     //Postcode

        //Altgriechisch
        k:=ze1.Text;
        w:='';
        z:=ein_int(ze1);
        a:=z div 10000;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(126)
        end;
        z:=z mod 10000;
        a:=z div 1000;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(125)
        end;
        z:=z mod 1000;
        a:=z div 100;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(124)
        end;
        z:=z mod 100;
        a:=z div 50;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(123)
        end;
        z:=z mod 50;
        a:=z div 10;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(122)
        end;
        z:=z mod 10;
        a:=z div 5;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(121)
        end;
        z:=z mod 5;
        if z>0 then
        begin
          for i:=1 to z do w:=w+chr(120)
        end;
        p37.caption:=' '+w;

        //Himyarisch
        k:=ze1.Text;
        w:='';
        if length(k)>0 then
        begin
          k2:='';
          for i:=1 to length(k) do k2:=k[i]+k2;
          w:=w+chr(195);
          val(k2[1],z,code);
          if z>0 then
          begin
          for i:=1 to z mod 5 do w:=w+chr(196);
          end;
          if z>4 then w:=w+chr(201);
          if length(k2)>1 then
          begin
            val(k2[2],z,code);
            if z>0 then
            begin
              for i:=1 to z mod 5 do w:=w+chr(197);
            end;
            if z>4 then w:=w+chr(202);
            if length(k2)>2 then
            begin
              val(k2[3],z,code);
              if z>0 then
              begin
                for i:=1 to z do w:=w+chr(198);
              end;
              if length(k2)>3 then
              begin
                val(k2[4],z,code);
                if z>0 then
                begin
                  for i:=1 to z do w:=w+chr(199);
                end;
                if length(k2)>4 then
                begin
                  val(k2[5],z,code);
                  if z>0 then
                  begin
                    for i:=1 to z do w:=w+chr(200);
                  end;
                end
              end
            end
          end;
          w:=w+chr(195);
        end;
        p39.caption:=' '+w;

        //ägyptisch
        z:=ein_int(ze1);
        w:='';
        a:=z div 10000;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(217)
        end;
        z:=z mod 10000;
        a:=z div 1000;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(216)
        end;
        z:=z mod 1000;
        a:=z div 100;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(215)
        end;
        z:=z mod 100;
        a:=z div 10;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(214)
        end;
        z:=z mod 10;
        if z>0 then
        begin
          for i:=1 to z do w:=w+chr(213)
        end;
        p28.caption:=' '+w;

        //Attisch
        k:=ze1.Text;
        w:='';
        if length(k)>0 then
        begin
          val(k,z,code);
          if z>=50000 then begin w:=w+chr(222); z:=z-50000 end;
          while z>=10000 do
          begin
            w:=w+chr(126);
            z:=z-10000
          end;
          if z>=5000 then
          begin
            w:=w+chr(221);
            z:=z-5000
          end;
          while z>=1000 do
          begin
            w:=w+chr(125);
            z:=z-1000
          end;
          if z>=500 then
          begin
            w:=w+chr(220);
            z:=z-500
          end;
          while z>=100 do
          begin
            w:=w+chr(124);
            z:=z-100
          end;
          if z>=50 then
          begin
            w:=w+chr(219);
            z:=z-50
          end;
          while z>=10 do
          begin
            w:=w+chr(122);
            z:=z-10
          end;
          if z>=5 then
          begin
            w:=w+chr(218);
            z:=z-5
          end;
          while z>=1 do
          begin
            w:=w+chr(120);
            z:=z-1
          end;
        end;
        p38.caption:=' '+w;

        //Laotisch
        k:=ze1.Text;
        if length(k)>0 then
        begin
          w:='';
          for i:=1 to length(k) do
          begin
            if k[i] in ['0'..'5'] then w:=w+chr(121+(ord(k[i])-48))
                                  else w:=w+chr(243+(ord(k[i])-48));
          end;
          p66.caption:=' '+w;
        end;

        //Farsi
        k:=ze1.Text;
        if length(k)>0 then
        begin
          w:='';
          for i:=1 to length(k) do
          begin
            if k[i] in ['0'..'3','7'..'9'] then w:=w+chr(58+(ord(k[i])-48))
                                           else w:=w+chr(64+(ord(k[i])-48));
          end;
          p61.caption:=' '+w;
        end;

        //Kanji
        k:=ze1.Text;
        p:=1;
        w:='';
        if length(k)>0 then
        begin
          val(k,z,code);
          i:=z div 10000;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(109);
          end;
          z:=z mod 10000;
          i:=z div 1000;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(108);
          end;
          z:=z mod 1000;
          i:=z div 100;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(107);
          end;
          z:=z mod 100;
          i:=z div 10;
          if i>0 then
          begin
            if i>1 then w:=w+chr(96+i);
            w:=w+chr(106);
          end;
          i:=z mod 10;
          if i>0 then w:=w+chr(96+i);
          p42.caption:=' '+w;
        end;

        //Bitmapmalen für Maya
        bitmap:=tbitmap.create;
        bitmap.height:=pb7.height;
        bitmap.width:=pb7.width;

        k:=ze1.Text;
        p:=1;
        if length(k)>0 then
        begin
          val(k,z,code);
          r:=z mod 20;
          km:=chr(32+r);
          z:=z div 20;
          r:=z mod 18;
          km:=chr(32+r)+km;
          z:=z div 18;
          k:=transform(z,20);
          k:=k+km;
          for i:=1 to length(k) do
          begin
            j:=ord(k[i])-32;
            if j>0 then
            begin
              if j>10 then
              begin
                gifres(zi2,'ma'+inttostr(j-10));
                malen;
                p:=p+2;
                gifres(zi2,'ma10');
                malen;
              end
              else
              begin
                gifres(zi2,'ma'+inttostr(j));
                malen;
              end;
            end
            else
            begin
              gifres(zi2,'ma0');
              malen;
            end;
            p:=p+8;
          end;
        end;
        pb7.canvas.draw(8,8,bitmap);
        bitmap.free;

        //Ionisch
        k:=ze1.Text;
        val(k,z,code);
        w:='';
        i:=z div 10000;
        case i of
          1 : w:=w+chr(201);
       2..9 : w:=w+chr(201+i)+chr(201);
        end;
        z:=z mod 10000;
        i:=z div 1000;
        if i>0 then w:=w+','+chr(201+i);
        z:=z mod 1000;
        i:=z div 100;
        if i>0 then w:=w+chr(219+i);
        z:=z mod 100;
        i:=z div 10;
        if i>0 then w:=w+chr(210+i);
        i:=z mod 10;
        if i>0 then w:=w+chr(201+i);
        p64.caption:=' '+w;

        //Hebräisch
        k:=ze1.Text;
        val(k,z,code);
        w:='';
        if z>=1000 then
        begin
          if z div 1000 = 15 then w:=chr(178)+chr(181)+w
          else
            if z div 1000 = 16 then w:=chr(179)+chr(181)+w
            else
            begin
              i:=z div 10000;
              if i>0 then w:=chr(181+i);
              z:=z mod 10000;
              i:=z div 1000;
              if i>0 then w:=chr(172+i)+w;
            end;
          z:=z mod 1000;
          w:=chr(200)+w;
        end;
        i:=z div 100;
        if i>0 then w:=chr(190+i)+w;
        z:=z mod 100;
        if z = 15 then
        begin
          w:=chr(178)+chr(181)+w;
        end
        else
          if z = 16 then
          begin
            w:=chr(179)+chr(181)+w;
          end
          else
          begin
            i:=z div 10;
            if i>0 then w:=chr(181+i)+w;
            i:=z mod 10;
            if i>0 then w:=chr(172+i)+w;
          end;
        p62.caption:=' '+w;

      //Oxidilogi
      k:=ze1.Text;
      if length(k)>0 then
      begin
        val(k,z,code);
        w:='';
        repeat
          i:=z mod 10;
          if i>5 then
          begin
            w:=chr(212)+w;
            i:=i-5
          end;
          w:=chr(207+i)+w;
          z:=z div 10;
        until z=0;
        p9.caption:=' '+chr(207)+w;
      end;

      //Dezimalsysteme der zweiten Seite
      k:=ze1.Text;
      if length(k)>0 then
      begin
        p8.caption:=meinstring(108);          //Seikai
        p73.caption:=meinstring(203);         //Khmer
        p19.caption:=meinstring(235);         //Narn
        p10.caption:=meinstring(197);         //Futurama
        p20.caption:=meinstring(213);         //Stargate
        p65.caption:=meinstring(91);          //Kannada
        p69.caption:=meinstring(160);         //Tamil
        p70.caption:=meinstring(111);         //Thai

        w:=meinstring(223);                   //Gorwelion
        delete(w,1,1);
        w:=' '+chr(233)+w+chr(234);
        p18.caption:=w;

        p30.caption:=meinstring(243);         //Klingo
        p68.caption:=meinstring(48);          //Osmanya
        p35.caption:=meinstring(111);         //Dancing Men
        p24.caption:=meinstring(161);         //Kayah
        p12.caption:=meinstring(71);          //Mong
        p57.caption:=meinstring(229);         //SpaceKees
        p21.caption:=meinstring(85);          //Tenctonese
        p17.caption:=meinstring(95);          //Zentlardy
      end;

      k:=ze1.Text;
      if length(k)>0 then
      begin
        p31.caption:='  '+basisstring(171,25);    //D'Ni
        p48.caption:='  '+basisstring(171,16);    //Four Line
        p49.caption:='  '+basisstring(187,16);    //Ecclemony
        p23.caption:='  '+basisstring(207,16);    //Diamond
        p45.caption:='  '+basisstring(203,4);     //Quadnary
        p13.caption:=' '+basisstring(105,2);      //Dualcode
        p4.caption:='  '+chr(40)+basisstring(48,12)+chr(41);  //Pékrif
      end;

      //Maya-Hieroglyphen
      k:=ze1.Text;
      if length(k)>0 then
      begin
        val(k,z,code);
        w:='';
        repeat
          if z mod 20<9 then w:=chr(118 +z mod 20)+w
                        else  w:=chr(151 +z mod 20)+w;
          z:=z div 20;
        until z=0;
        p22.caption:=' '+w;
      end;

      //Ungarische Runen
      k:=ze1.Text;
      w:='';
      if length(k)>0 then
      begin
        z:=ein_int(ze1);
        a:=z div 1000;
        if a>0 then
        begin
          j:=a;
          a:=j div 50;
          if a>0 then
          begin
            for i:=1 to a do w:=w+chr(125)
          end;
          j:=j mod 50;
          a:=j div 10;
          if a>0 then
          begin
            for i:=1 to a do w:=w+chr(124)
          end;
          j:=j mod 10;
          a:=j div 5;
          if a>0 then
          begin
            for i:=1 to a do w:=w+chr(123)
          end;
          j:=j mod 5;
          if j>0 then
          begin
            for i:=1 to j do w:=w+chr(122)
          end;
          w:=w+chr(160);
        end;

        z:=z mod 1000;
        a:=z div 100;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(126)
        end;
        z:=z mod 100;
        a:=z div 50;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(125)
        end;
        z:=z mod 50;
        a:=z div 10;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(124)
        end;
        z:=z mod 10;
        a:=z div 5;
        if a>0 then
        begin
          for i:=1 to a do w:=w+chr(123)
        end;
        z:=z mod 5;
        if z>0 then
        begin
          for i:=1 to z do w:=w+chr(122)
        end;
        p53.caption:=' '+w; //ungari
      end;

      //Mandschu
      k:=ze1.Text; //jin
      if length(k)>0 then
      begin
        val(k,z,code);
        w:='';
        a:=z div 10000;
        if a>0 then w:=w+chr(80+a)+chr(110);
        z:=z mod 10000;
        a:=z div 1000;
        if a>0 then w:=w+chr(80+a)+chr(109);
        z:=z mod 1000;
        a:=z div 100;
        if a>0 then w:=w+chr(80+a)+chr(108);
        z:=z mod 100;
        if z>19 then
        begin
          a:=z div 10;
          if a>0 then w:=w+chr(98+a);
          z:=z mod 10;
          if z>0 then w:=w+chr(80+z);
        end
        else w:=w+chr(80+z);
        P14.caption:=' '+w;
      end;

      //Gotisch
      k:=ze1.Text; //jin
      if length(k)>0 then
      begin
        val(k,z,code);
        w:='';
        if z>=1000 then
        begin
          a:=z div 10000;
          if a>0 then w:=w+chr(66+a);
          z:=z mod 10000;
          a:=z div 1000;
          if a>0 then w:=w+chr(57+a);
          z:=z mod 1000;
        end;
        a:=z div 100;
        if a>0 then w:=w+chr(75+a);
        z:=z mod 100;
        a:=z div 10;
        if a>0 then w:=w+chr(66+a);
        z:=z mod 10;
        if z>0 then w:=w+chr(57+z);
        p41.caption:=' '+w;
      end;

      //Suzhou
      k:=ze1.Text;
      p:=1;
      w:='';
      if length(k)>0 then
      begin
        val(k,z,code);
        i:=z div 10000;
        if i>0 then
        begin
          if i>1 then w:=w+chr(61+i);
          w:=w+chr(33);
        end;
        z:=z mod 10000;
        i:=z div 1000;
        if i>0 then
        begin
          if i>1 then w:=w+chr(61+i);
          w:=w+chr(34);
        end;
        z:=z mod 1000;
        i:=z div 100;
        if i>0 then
        begin
          if i>1 then w:=w+chr(61+i);
          w:=w+chr(35);
        end;
        z:=z mod 100;
        i:=z div 10;
        if i>0 then
        begin
          if i>1 then w:=w+chr(61+i);
          w:=w+chr(36);
        end;
        i:=z mod 10;
        if i>0 then w:=w+chr(61+i);
        p25.caption:=' '+w;
      end;

      //Morsecode
      k:=ze1.Text;
      w:='';
      if length(k)>0 then
      begin
        for i:=1 to length(k) do
        begin
          case ord(k[i]) of
            48 : w:=w+'-----';
            49 : w:=w+'·----';
            50 : w:=w+'··---';
            51 : w:=w+'···--';
            52 : w:=w+'····-';
            53 : w:=w+'·····';
            54 : w:=w+'-····';
            55 : w:=w+'--···';
            56 : w:=w+'---··';
            57 : w:=w+'----·';
          end;
          w:=w+' ';
        end;
        p15.caption:=' '+w;
      end;
    end
    else l3.caption:='Zahl muss > 0 und < '+inttostr(grenze+1)+' sein';
  end;
end;

procedure Tzahlz.ze1Change(Sender: TObject);
begin
   pb2paint(sender);
   pb1paint(sender);
   pb9paint(sender);
   paintbox11paint(sender);
end;

procedure Tzahlz.FormActivate(Sender: TObject);
var m8,m8b,m8c,m8d:string;
    liste:tstringlist;
begin
    liste:=tstringlist.create;
    liste.Clear;
    liste.sorted := True;
    liste.addstrings(Screen.Fonts);

    //Schrifarten installieren
    schriftinstall[1]:=false;
    if liste.indexof('Mathe08')<0 then
      schriftinstall[1]:=fontladen('mathe08',1);
    schriftinstall[2]:=false;
    if liste.indexof('Mathe08b')<0 then
      schriftinstall[2]:=fontladen('mathe08b',2);
    schriftinstall[3]:=false;
    if liste.indexof('Mathe08c')<0 then
      schriftinstall[3]:=fontladen('mathe08c',3);
    schriftinstall[4]:=false;
    if liste.indexof('Mathe08d')<0 then
      schriftinstall[4]:=fontladen('mathe08d',4);
    liste.free;

    ze1.text:=inttostr(round(date));
    m8:='Mathe08';
    m8b:='Mathe08b';
    m8c:='Mathe08c';
    m8d:='Mathe08d';

    //Schrifarten auf Panels verteilen
    p6.font.name:=m8;
    p60.font.name:=m8;
    p61.font.name:=m8;
    p62.font.name:=m8;
    p63.font.name:=m8;
    p64.font.name:=m8;
    p65.font.name:=m8;
    p66.font.name:=m8;
    p67.font.name:=m8c;
    p68.font.name:=m8c;
    p69.font.name:=m8;
    p70.font.name:=m8;
    p57.font.name:=m8;

    p72.font.name:=m8b;
    p73.font.name:=m8b;
    p42.font.name:=m8b;
    p40.font.name:=m8b;
    p39.font.name:=m8b;
    p27.font.name:=m8b;
    p28.font.name:=m8b;
    p38.font.name:=m8b;
    p37.font.name:=m8b;
    p36.font.name:=m8b;
    p34.font.name:=m8b;
    p33.font.name:=m8b;
    p15.font.name:='Symbol';

    p8.font.name:=m8c;
    p19.font.name:=m8c;
    p31.font.name:=m8c;
    p10.font.name:=m8c;
    p9.font.name:=m8c;
    p20.font.name:=m8c;
    p22.font.name:=m8c;
    p26.font.name:=m8c;
    p18.font.name:=m8c;
    p41.font.name:=m8c;
    p21.font.name:=m8c;
    p17.font.name:=m8c;
    p13.font.name:=m8c;
    p7.font.name:=m8c;

    p48.font.name:=m8d;
    P14.font.name:=m8d;
    p49.font.name:=m8d;
    p23.font.name:=m8d;
    p45.font.name:=m8d;
    p71.font.name:=m8d;
    p29.font.name:=m8d;
    p30.font.name:=m8d;
    p35.font.name:=m8d;
    p53.font.name:=m8d;
    p24.font.name:=m8d;
    p12.font.name:=m8d;
    p25.font.name:=m8d;
    p4.font.name:=m8d;
end;

//Schriftarten wieder löschen
procedure Tzahlz.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
    for i:=1 to 4 do
      if schriftinstall[i] then RemoveFontMemResourceEx(fonthandle[i]);
end;

//Assyrisch
procedure Tzahlz.PB9Paint(Sender: TObject);
var z,z2,i,p,j,r,code:integer;
    bitmap:tbitmap;
    k,ke:string;
procedure malen;
begin
    bitmap.Canvas.draw(p,0,zi2.picture.bitmap);
    p:=p+zi2.width;
end;
begin
    ke:=ze1.text;
    l3.caption:='';
    if (length(ke)>0) and (length(ke)<7) then
    begin
      z:=ein_int(ze1);
      if (z<=grenze) and (z>=0) then
      begin
        bitmap:=tbitmap.create;
        bitmap.height:=pb9.height;
        bitmap.width:=pb9.width;

        k:=ze1.Text;
        p:=1;
        if length(k)>0 then
        begin
          val(k,z,code);
          z2:=z;
          i:=z div 3600;
          j:=i div 10;
          if j>0 then
            for r:=1 to j do
            begin
              gifres(zi2,'ass10');
              malen;
            end;
          j:=i mod 10;
          gifres(zi2,'ass'+inttostr(j));
          if j>0 then malen;
          p:=p+4;

          z:=z mod 3600;
          i:=z div 60;
          j:=i div 10;
          if j>0 then
            for r:=1 to j do
            begin
              gifres(zi2,'ass10');
              malen;
            end;
          j:=i mod 10;
          gifres(zi2,'ass'+inttostr(j));
          if (j>0) or ((j=0) and (z2>59)) then malen;
          p:=p+4;
          i:=z mod 60;
          j:=i div 10;
          if j>0 then
            for r:=1 to j do
            begin
              gifres(zi2,'ass10');
              malen;
            end;
          j:=i mod 10;
          gifres(zi2,'ass'+inttostr(j));
          malen;
        end;
        pb9.canvas.draw(8,2,bitmap);
        bitmap.free;
      end
      else l3.caption:='Zahl muss größer 0 und kleiner '+inttostr(grenze+1)+' sein';
    end;
end;

//Koreanisch
procedure Tzahlz.PB2Paint(Sender: TObject);
var z,i,p,code:integer;
    bitmap:tbitmap;
    k:string;
procedure malen;
begin
    bitmap.Canvas.draw(p,0,zi2.picture.bitmap);
    p:=p+zi2.width;
end;
begin
    k:=ze1.text;
    l3.caption:='';
    if (length(k)>0) and (length(k)<7) then
    begin
      z:=ein_int(ze1);
      if (z<=grenze) and (z>=0) then
      begin
        bitmap:=tbitmap.create;
        bitmap.height:=pb2.height;
        bitmap.width:=pb2.width;

        p:=1;
        if length(k)>0 then
        begin
          val(k,z,code);
          i:=z div 10000;
          if i>0  then
          begin
            if i>1 then
            begin
              gifres(zi2,'korea'+inttostr(i-1));
              malen;
            end;
            gifres(zi2,'korea'+inttostr(12));
            malen;
          end;
          z:=z mod 10000;
          i:=z div 1000;
          if i>0 then
          begin
            if i>1 then
            begin
              gifres(zi2,'korea'+inttostr(i-1));
              malen;
            end;
            gifres(zi2,'korea'+inttostr(11));
            malen;
          end;
          z:=z mod 1000;
          i:=z div 100;
          if i>0 then
          begin
            if i>1 then
            begin
              gifres(zi2,'korea'+inttostr(i-1));
              malen;
            end;
            gifres(zi2,'korea'+inttostr(10));
            malen;
          end;
          z:=z mod 100;
          i:=z div 10;
          if i>0 then
          begin
            if i>1 then
            begin
              gifres(zi2,'korea'+inttostr(i-1));
              malen;
            end;
            gifres(zi2,'korea'+inttostr(9));
            malen;
          end;
          i:=z mod 10;
          if i>0 then
          begin
            gifres(zi2,'korea'+inttostr(i-1));
            malen;
          end;
        end;
        pb2.canvas.draw(8,3,bitmap);
        bitmap.free;
      end
      else l3.caption:='Zahl muss größer 0 und kleiner '+inttostr(grenze+1)+' sein';
    end;
end;

//Hieratisch
procedure Tzahlz.PB1Paint(Sender: TObject);
var z,i,p,code:integer;
    bitmap:tbitmap;
    k,ke:string;
procedure malen;
var h:integer;
begin
    h:=zi2.height;
    if h<pb1.height then h:=(pb1.height-h) div 2;
    bitmap.Canvas.draw(p,h,zi2.picture.bitmap);
    p:=p+zi2.width;
end;
begin
    ke:=ze1.text;
    l3.caption:='';
    if (length(ke)>0) and (length(ke)<7) then
    begin
      z:=ein_int(ze1);
      if (z<=grenze) and (z>=0) then
      begin
        bitmap:=tbitmap.create;
        bitmap.height:=pb1.height;
        bitmap.width:=pb1.width;
        k:=ze1.Text;
        p:=1;
        if length(k)>0 then
        begin
          val(k,z,code);
          i:=z div 10000;
          if i>0 then
          begin
            if i>9 then
            begin
              gifres(zi2,'h'+inttostr(i div 10)+'0');
              malen;
              i:=i mod 10;
            end;
            if i>0 then gifres(zi2,'h'+inttostr(i));
            malen;
            gifres(zi2,'h10000');
            malen;
          end;
          z:=z mod 10000;
          i:=z div 1000;
          if i>0 then
          begin
            gifres(zi2,'h'+inttostr(i)+'000');
            malen;
          end;
          z:=z mod 1000;
          i:=z div 100;
          if i>0 then
          begin
            gifres(zi2,'h'+inttostr(i)+'00');
            malen;
          end;
          z:=z mod 100;
          i:=z div 10;
          if i>0 then
          begin
            gifres(zi2,'h'+inttostr(i)+'0');
            malen;
          end;
          z:=z mod 10;
          if z>0 then
          begin
            gifres(zi2,'h'+inttostr(z));
            malen;
          end;
        end;
        pb1.canvas.draw(8,3,bitmap);
        bitmap.free;
      end;
    end;
end;

procedure Tzahlz.SpinButton1UpClick(Sender: TObject);
var a:integer;
begin
    a:=ein_int(ze1);
    inc(a);
    if a>grenze then a:=grenze;
    ze1.text:=inttostr(a);
end;

procedure Tzahlz.SpinButton1DownClick(Sender: TObject);
var a:integer;
begin
    a:=ein_int(ze1);
    dec(a);
    if a<0 then a:=0;
    ze1.text:=inttostr(a);
end;

end.


