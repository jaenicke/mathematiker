unit uabakus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    abakus: TPanel;
    Paintbox1: TPaintBox;
    I5: TImage;
    Timer1: TTimer;
    MM1: TMainMenu;
    M6: TMenuItem;
    Timer2: TTimer;
    Panel1: TPanel;
    R8: TRadioButton;
    R9: TRadioButton;
    R10: TRadioButton;
    I3: TImage;
    I4: TImage;
    Button1: TSpeedButton;
    Edit1: TEdit;
    a1: TImage;
    a2: TImage;
    a3: TImage;
    a4: TImage;
    procedure FormShow(Sender: TObject);
    procedure Paintbox1Paint(Sender: TObject);
    procedure PB4MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure TsC(Sender: TObject);
    procedure Edit1change(Sender: TObject);
    procedure R8Click(Sender: TObject);
  private
    programmnummer:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var  Form1: TForm1;

implementation

{$R *.DFM}
var timerzahl:int64;
    soroban : byte;
const
      abac : array[1..10] of integer = (0,0,0,0,0,0,0,0,0,0);
      abac2 : array[1..11] of integer = (0,0,0,0,0,0,0,0,0,0,0);

procedure TForm1.FormShow(Sender: TObject);
begin
            timer1.enabled:=false;
            fillchar(abac,sizeof(abac),0);
            case programmnummer of
              7 : begin
                    soroban:=0;
                    fillchar(abac2,sizeof(abac2),0);
                    i4.picture.assign(a1.picture);
                    r8.checked:=true;
                  end;
              8 : begin
                    soroban:=1;
                    i4.picture.assign(a2.picture);
                    r9.checked:=true;
                  end;
             11 : begin
                    soroban:=2;
                    i4.picture.assign(a3.picture);
                    i3.picture.assign(a4.picture);
                    r10.checked:=true;
                  end;
            end;
            r8click(sender);
end;

procedure TForm1.Paintbox1Paint(Sender: TObject);
var bitmap:tbitmap;
    ziel:tcanvas;
    wert,ueber,vv,v1,v2,i,j,xoffset:integer;
    k:string;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=Paintbox1.width;
  bitmap.height:=Paintbox1.height;
  ziel:=bitmap.canvas;
  ziel.font.name:='Verdana';
  ziel.font.size:=26;
  ziel.font.style:=[fsbold];
  ziel.font.color:=clnavy;
  xoffset:=(bitmap.width-890) div 2;
  ziel.Brush.Bitmap := I5.picture.Bitmap;
  ziel.roundrect(xoffset,55,xoffset+890,635,20,20);
  ziel.brush.style:=bssolid;
  ziel.brush.color:=clwhite;
  ziel.roundrect(xoffset+20,75,xoffset+870,615,20,20);
  ziel.Brush.Bitmap := I5.picture.Bitmap;
  case soroban of
    1 : ziel.rectangle(xoffset+20,225,xoffset+870,245);
    0 : ziel.rectangle(xoffset+20,255,xoffset+870,265);
  end;
  ziel.brush.style:=bssolid;
  ziel.pen.width:=4;

  case soroban of
    1 : begin
          for i:=1 to 10 do begin
            v1:=68-68*(abac[i] div 5);
            v2:=5-(abac[i] mod 5);
            ziel.moveto(xoffset+3+i*80,614);
            ziel.lineto(xoffset+3+i*80,245);
            ziel.moveto(xoffset+3+i*80,224);
            ziel.lineto(xoffset+3+i*80,75);
            ziel.draw(xoffset-30+i*80,83+68-v1,I4.picture.bitmap);
            for j:=1 to 4 do begin
              if j>=v2 then
                ziel.draw(xoffset-30+i*80,640-108-j*68,I4.picture.bitmap)
              else
                ziel.draw(xoffset-30+i*80,640-40-j*68,I4.picture.bitmap);
            end;
          end;
        end;
    2 : begin
          for i:=1 to 10 do begin
            v1:=11-abac[i];
            ziel.moveto(xoffset+3+i*80,614);
            ziel.lineto(xoffset+3+i*80,75);
            if i<>7 then begin
              for j:=1 to 10 do begin
                if j<v1 then begin
                  if j in [5,6] then
                    ziel.draw(xoffset-21+i*80,640-26-j*46,I3.picture.bitmap)
                  else
                    ziel.draw(xoffset-21+i*80,640-26-j*46,I4.picture.bitmap)
                end else begin
                  if j in [5,6] then
                    ziel.draw(xoffset-21+i*80,640-103-j*46,I3.picture.bitmap)
                  else
                    ziel.draw(xoffset-21+i*80,640-103-j*46,I4.picture.bitmap);
                end;
              end
            end else begin //4.stab
              for j:=1 to 4 do begin
                if j in [2,3] then
                  ziel.draw(xoffset-21+i*80,640-26-j*46,I3.picture.bitmap)
                else
                  ziel.draw(xoffset-21+i*80,640-26-j*46,I4.picture.bitmap)
              end
            end;
          end;
        end;
        else begin //abakus
          for i:=1 to 10 do begin
            v1:=6-abac[i];
            v2:=abac2[i];
            ziel.moveto(xoffset+3+i*80,614);
            ziel.lineto(xoffset+3+i*80,265);
            ziel.moveto(xoffset+3+i*80,254);
            ziel.lineto(xoffset+3+i*80,75);
            ziel.draw(xoffset-26+i*80,81,I4.picture.bitmap);
            if v2=0 then ziel.draw(xoffset-26+i*80,81+57,I4.picture.bitmap)
                    else ziel.draw(xoffset-26+i*80,81+114,I4.picture.bitmap);
            for j:=1 to 5 do begin
              if j>=v1 then
                ziel.draw(xoffset-26+i*80,670-114-j*57,I4.picture.bitmap)
              else
                ziel.draw(xoffset-26+i*80,670-57-j*57,I4.picture.bitmap);
            end;
          end;
        end;
  end; //ende case;

  ziel.brush.style:=bsclear;
  case soroban of
    1 : begin
          for i:=1 to 10 do begin
            k:=inttostr(abac[i]);
            vv:=ziel.textwidth(k) div 2;
            ziel.textout(xoffset+3-vv+i*80,8,k);
          end;
        end;
    2 : begin
          for i:=1 to 10 do abac2[i]:=0;
          for i:=10 downto 2 do begin
            if i<>7 then begin
              if i<>8 then abac2[i-1]:=(abac2[i]+abac[i]) div 10
                      else abac2[i-2]:=(abac2[i]+abac[i]) div 10;
            end;
          end;
          for i:=1 to 10 do begin
            if i<>7 then begin
              k:=inttostr((abac2[i]+abac[i]) mod 10);
              vv:=ziel.textwidth(k) div 2;
              ziel.textout(xoffset+3-vv+i*80,8,k);
            end;
          end;
        end
   else begin //abakus
          ueber:=0;
          for i:=10 downto 1 do begin
            wert:=5*abac2[i]+abac[i]+ueber;
            ueber:=wert div 10;
            wert:=wert mod 10;
            k:=inttostr(wert);
            vv:=ziel.textwidth(k) div 2;
            ziel.textout(xoffset+3-vv+i*80,8,k);
          end;
          k:=inttostr(ueber);
          vv:=ziel.textwidth(k) div 2;
          ziel.textout(xoffset+3-vv,8,k);
          end;
  end; //case end
  if form1.height>850 then
    Paintbox1.canvas.draw(0,(form1.height-800) div 2,bitmap)
  else
    Paintbox1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure TForm1.PB4MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
label 1;
var xoffset,i,j,knr,amod:integer;
begin
  xoffset:=(Paintbox1.width-890) div 2;
  i:=(x-xoffset+30) div 80;
  if form1.height>850 then y:=y-(form1.height-800) div 2;

  if soroban=1 then begin
    j:=(y-43-40+68);
    if (i>0) and (i<11) then begin
      if (abac[i]>4) and (j>=135) and (j<205) then begin
        abac[i]:=abac[i]-5;
        goto 1
      end;
      if (abac[i]<5) and (j<135) and (j>=65) then begin
        abac[i]:=abac[i]+5;
        goto 1
      end;
      amod:=abac[i] mod 5;
      j:=j-242;
      knr:=5- j div 68;
      if (knr=5) and (amod>0) then begin
        abac[i]:=5*(abac[i] div 5);
        goto 1
      end;
      if (knr=4) then begin
        if amod in [4,3,2,0] then abac[i]:=5*(abac[i] div 5)+1;
        goto 1
      end;
      if (knr=3) then begin
        if amod in [4,3,1,0] then abac[i]:=5*(abac[i] div 5)+2;
        goto 1
      end;
      if (knr=2) then begin
        if amod in [4,2,1,0] then abac[i]:=5*(abac[i] div 5)+3;
        goto 1
      end;
      if (knr=1) then begin
        if amod in [3,2,1,0] then abac[i]:=5*(abac[i] div 5)+4;
        goto 1
      end;
    end;
  end;
  if soroban=2 then begin
    j:=(y-43-40{+46});
    if (i>0) and (i<11) then begin
      amod:=abac[i];
      knr:=j div 46;
      if knr>amod then begin
        j:=j-77;
        knr:=(j div 46)+1
      end;
      if knr>10 then knr:=10;
      abac[i]:=knr;
      goto 1;
    end;
  end;
  if soroban=0 then begin //abakus
    if (i>0) and (i<11) then begin
      j:=1+(y-80) div 57;
      if j=1 then begin
        if abac2[i] in [0,1] then abac2[i]:=2;
        goto 1
      end;
      if j=2 then begin
        if abac2[i] in [0,2] then abac2[i]:=1;
        goto 1
      end;
      if j=3 then begin
        if abac2[i] in [1,2] then abac2[i]:=0;
        goto 1
      end;
      j:=1+(y-275) div 57;
      if j=1 then begin
        if abac[i] in [1,2,3,4,5] then abac[i]:=0;
        goto 1
      end;
      if j=2 then begin
        if abac[i] in [0,2,3,4,5] then abac[i]:=1;
        goto 1
      end;
      if j=3 then begin
        if abac[i] in [0,1,3,4,5] then abac[i]:=2;
        goto 1
      end;
      if j=4 then begin
        if abac[i] in [0,1,2,4,5] then abac[i]:=3;
        goto 1
      end;
      if j=5 then begin
        if abac[i] in [0,1,2,3,5] then abac[i]:=4;
        goto 1
      end;
      if j=6 then begin
        if abac[i] in [0,1,2,3,4] then abac[i]:=5;
        goto 1
      end;
    end;
  end;
1: Paintbox1paint(sender); //exit;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,z,h:integer;
begin
  inc(timerzahl);
  edit1.text:=inttostr(timerzahl);
  z:=timerzahl;
  i:=10;
  if programmnummer=7 then begin
    repeat
      h:=z mod 10;
      if h>5 then begin
        abac2[i]:=1;
        abac[i]:=h-5
      end else begin
        abac2[i]:=0;
        abac[i]:=h
      end;
      z:=z div 10;
      dec(i);
    until (i<1);
  end;
  if programmnummer in [8] then begin
    repeat
      abac[i]:=z mod 10;
      z:=z div 10;
      dec(i);
    until (i<1);
  end;
  if programmnummer in [11] then begin
    repeat
      abac[i]:=z mod 10;
      z:=z div 10;
      dec(i);
      if i=7 then dec(i);
    until (i<1);
  end;
  Paintbox1paint(sender);
end;

procedure TForm1.TsC(Sender: TObject);
begin
  timer1.enabled:=Button1.down;
  if timer1.Enabled then
  begin
    if edit1.text<>'' then timerzahl:=strtoint64(edit1.text);
  end;
end;

procedure TForm1.Edit1change(Sender: TObject);
var i,z,h:int64;
begin
  if edit1.text<>'' then z:=strtoint64(edit1.text) else z:=0;
  i:=10;
  if programmnummer=7 then begin
    repeat
      h:=z mod 10;
      if h>5 then begin
        abac2[i]:=1;
        abac[i]:=h-5
      end else begin
        abac2[i]:=0;
        abac[i]:=h
      end;
      z:=z div 10;
      dec(i);
    until (i<1);
  end;
  if programmnummer=8 then begin
    repeat
      abac[i]:=z mod 10;
      z:=z div 10;
      dec(i);
    until (i<1);
  end;
  if programmnummer in [11] then begin
    repeat
      abac[i]:=z mod 10;
      z:=z div 10;
      dec(i);
      if i=7 then dec(i);
    until (i<1);
  end;
  Paintbox1paint(sender);
end;

procedure TForm1.R8Click(Sender: TObject);
begin
  if r8.checked then begin
    soroban:=0;
    programmnummer:=7;
    i4.picture.assign(a1.picture);
  end;
  if r9.checked then begin
    soroban:=1;
    programmnummer:=8;
    i4.picture.assign(a2.picture);
  end;
  if r10.checked then begin
    soroban:=2;
    programmnummer:=11;
    i4.picture.assign(a3.picture);
    i3.picture.assign(a4.picture);
  end;
  Edit1change(Sender);
  Paintbox1paint(sender);
end;

begin
    soroban := 0;
end.

