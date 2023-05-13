unit usudokubus;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Buttons, ComCtrls, Rxgif;

type
  Tschnecke2 = class(TForm)
    Panel2: TPanel;
    Button1: TButton;
    PB1: TPaintBox;
    Label1: TLabel;
    E1: TEdit;
    E2: TEdit;
    E3: TEdit;
    E4: TEdit;
    E5: TEdit;
    E6: TEdit;
    E7: TEdit;
    E8: TEdit;
    E9: TEdit;
    E10: TEdit;
    E11: TEdit;
    E12: TEdit;
    E13: TEdit;
    E14: TEdit;
    E15: TEdit;
    E16: TEdit;
    E17: TEdit;
    E18: TEdit;
    E19: TEdit;
    E20: TEdit;
    E21: TEdit;
    E22: TEdit;
    E23: TEdit;
    E24: TEdit;
    E25: TEdit;
    E26: TEdit;
    E27: TEdit;
    I1: TImage;
    Panel1: TPanel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    procedure S3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure E1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  public
  end;

var
  schnecke2: Tschnecke2;

implementation

var ein:array[1..27] of tedit;
    loesung: array[1..3] of string[27] =
      ('158729463297634815346581972',
       '164829573298735416357641982',
       '724835691589162473316947258');
    loesung2: string[27];
    reihe:array[1..9] of integer;
{$R *.DFM}
{$R nurs15.res}

procedure Tschnecke2.S3Click(Sender: TObject);
begin
  close;
end;

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

procedure Tschnecke2.FormCreate(Sender: TObject);
begin
  randomize;
  ein[1]:=e1;
  ein[2]:=e2;
  ein[3]:=e3;
  ein[4]:=e4;
  ein[5]:=e5;
  ein[6]:=e6;
  ein[7]:=e7;
  ein[8]:=e8;
  ein[9]:=e9;
  ein[10]:=e10;
  ein[11]:=e11;
  ein[12]:=e12;
  ein[13]:=e13;
  ein[14]:=e14;
  ein[15]:=e15;
  ein[16]:=e16;
  ein[17]:=e17;
  ein[18]:=e18;
  ein[19]:=e19;
  ein[20]:=e20;
  ein[21]:=e21;
  ein[22]:=e22;
  ein[23]:=e23;
  ein[24]:=e24;
  ein[25]:=e25;
  ein[26]:=e26;
  ein[27]:=e27;
  gifres(i1,'suku');
end;

procedure Tschnecke2.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
    b,h,b2,h2,i,w:integer;
procedure eins(nr,x,y:integer);
begin
    ein[nr].left:=panel2.width+b2+x-12;
    ein[nr].top:=panel1.height+h2+y-17+w;
end;
begin
    b:=PB1.width;
    h:=PB1.height;
    b2:=(b-643) div 2;
    h2:=(h-602) div 2;
    bitmap:=tbitmap.create;
    bitmap.width:=PB1.width;
    bitmap.height:=PB1.height;
    for i:=0 to 2 do
    begin
      w:=round(i*196.5);
      eins(1+i*9,282,31);
      eins(2+i*9,446,63);
      eins(3+i*9,610,97);
      eins(4+i*9,160,71);
      eins(5+i*9,324,105);
      eins(6+i*9,488,137);
      eins(7+i*9,36,113);
      eins(8+i*9,200,146);
      eins(9+i*9,365,179);
    end;
    bitmap.canvas.draw(b2,h2,i1.picture.bitmap);
    PB1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

procedure Tschnecke2.FormActivate(Sender: TObject);
var nr,i,j,k,h,anz:integer;
    felder1:array[1..27] of boolean;
    jetzt,stufe1,stufe2,stufe3:integer;
begin
    stufe1:=4;
    stufe2:=5;
    stufe3:=3;

    for i:=1 to 27 do
    begin
      ein[i].text:='';
      ein[i].color:=clwhite;
    end;
    for i:=1 to 9 do reihe[i]:=i;
    for k:=1 to 100 do
    begin
      i:=random(9)+1;
      j:=random(9)+1;
      h:=reihe[i];
      reihe[i]:=reihe[j];
      reihe[j]:=h;
    end;
    loesung2:='';
    jetzt:=random(3)+1;
    for i:=1 to 27 do loesung2:=loesung2+inttostr(reihe[strtoint(loesung[jetzt][i])]);

    for i:=1 to 9 do felder1[i]:=false;
    anz:=1;
    repeat
      nr:=random(9)+1;
      if felder1[nr]=false then
      begin
        felder1[nr]:=true;
        inc(anz);
      end;
    until anz>stufe1;
    for i:=1 to 9 do
      if felder1[i] then ein[i].text:=loesung2[i];

    for i:=10 to 18 do felder1[i]:=false;
    anz:=1;
    repeat
      nr:=random(9)+10;
      if felder1[nr]=false then
      begin
        felder1[nr]:=true;
        inc(anz);
      end;
    until anz>stufe2;
    for i:=10 to 18 do
      if felder1[i] then ein[i].text:=loesung2[i];

    for i:=19 to 27 do felder1[i]:=false;
    anz:=1;
    repeat
      nr:=random(9)+18;
      if felder1[nr]=false then
      begin
        felder1[nr]:=true;
        inc(anz);
      end;
    until anz>stufe3;
    for i:=19 to 27 do
      if felder1[i] then ein[i].text:=loesung2[i];

    for i:=1 to 27 do
    begin
      ein[i].readonly:=ein[i].text<>'';
      if ein[i].readonly then ein[i].font.color:=clblue
                         else ein[i].font.color:=clblack;
    end;
end;

procedure Tschnecke2.E1Change(Sender: TObject);
type _feld = array[1..9] of integer;
const
    ebene1 : _feld = (1,4,7,10,13,16,19,22,25);
    ebene2 : _feld = (2,5,8,11,14,17,20,23,26);
    ebene3 : _feld = (3,6,9,12,15,18,21,24,27);
    ebene4 : _feld = (1,2,3,10,11,12,19,20,21);
    ebene5 : _feld = (4,5,6,13,14,15,22,23,24);
    ebene6 : _feld = (7,8,9,16,17,18,25,26,27);
    ebene7 : _feld = (1,2,3,4,5,6,7,8,9);
    ebene8 : _feld = (10,11,12,13,14,15,16,17,18);
    ebene9 : _feld = (19,20,21,22,23,24,25,26,27);
var i:integer;
    korrekt:boolean;
    z,code:integer;
procedure test(e:_feld);
var i,j:integer;
begin
    for i:=1 to 8 do
      for j:=i+1 to 9 do
      begin
        if ein[e[i]].text=ein[e[j]].text then
        begin
          if checkbox1.checked then
          begin
            if ein[e[i]].text<>'' then ein[e[i]].color:=clyellow;
            if ein[e[j]].text<>'' then ein[e[j]].color:=clyellow;
          end;
          korrekt:=false;
        end;
      end;
end;

begin
    korrekt:=true;
    for i:=1 to 27 do
    begin
      val(ein[i].text,z,code);
      ein[i].color:=clwhite;
      if not (z in [1..9]) then korrekt:=false;
    end;
    test(ebene1);
    test(ebene2);
    test(ebene3);
    test(ebene4);
    test(ebene5);
    test(ebene6);
    test(ebene7);
    test(ebene8);
    test(ebene9);
    if korrekt then
      showmessage('Gratulation! Der Sudokubus ist gelöst.');
end;

procedure Tschnecke2.Button2Click(Sender: TObject);
var i:integer;
begin
    for i:=1 to 27 do ein[i].text:=loesung2[i];
end;

end.
