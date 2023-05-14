unit usokoban;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Menus, ExtCtrls,
  StdCtrls, Buttons, zlib;

type
  Tfsokoban = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PM1: TPopupMenu;
    PB1: TPaintBox;
    Button2: TButton;
    Menu1: TMenuItem;
    Menu3: TMenuItem;
    Menu4: TMenuItem;
    Menu2: TMenuItem;
    L1: TLabel;
    L2: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    L3: TLabel;
    CB1: TCheckBox;
    Panel4: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure D1C(Sender: TObject);
    procedure P1P(Sender: TObject);
    procedure x5C(Sender: TObject);
    procedure x2C(Sender: TObject);
    procedure x1C(Sender: TObject);
    procedure x4C(Sender: TObject);
    procedure test(Sender: TObject);
    procedure D2C(Sender: TObject);
    procedure D3C(Sender: TObject);
    procedure T1Timer(Sender: TObject);
    procedure M2C(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    bitmap:tbitmap;
    stufe:integer;
    schrittzahl:integer;
    verlaufst:string;
    schritt:integer;
    verlauf,stufen:tstringlist;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fsokoban: Tfsokoban;

implementation

uses Dialogs;

const maxfelder=16;

var feld,feld2,feldk:array[0..maxfelder+1,0..24] of char;
    demonr,aktx,akty:integer;
var verlaufqqq:string; qqqschritt:integer;

const maxsok:integer=116;
    volldemo:boolean=false;
    reduktion:boolean=false;
    letzterzug:integer=0;
{$R *.DFM}

procedure Tfsokoban.FormCreate(Sender: TObject);
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
begin
  bitmap:=tbitmap.create;
  verlauf:=tstringlist.create;
  stufen:=tstringlist.create;
  listedll(stufen,'soko1');
  listedll(verlauf,'soko2');
  stufe:=1;
  menu1.shortcut:=shortcut(VK_LEFT,[]);
  menu3.shortcut:=shortcut(VK_RIGHT,[]);
  menu4.shortcut:=shortcut(VK_UP,[]);
  menu2.shortcut:=shortcut(VK_DOWN,[]);
  demonr:=verlauf.count;
  maxsok:=strtoint(stufen[0]);
  l3.caption:=inttostr(maxsok)+' Spielstufen';
  d1c(sender);
end;

procedure Tfsokoban.D1C(Sender: TObject);
var i,j,jj,wirklichzeilen,vorlauf:integer;
    k,kp:string;
    schluss:boolean;
begin
  button4.visible:=stufe<=demonr;
  cb1.visible:=stufe<=demonr;
  letzterzug:=0;
  fillchar(feld,sizeof(feld),'M');
  if stufe>1000 then k:='[a'+inttostr(stufe-1000)
                else k:='['+inttostr(stufe);
  jj:=stufen.indexof(k);
  i:=1;
  schluss:=false;
  repeat
    kp:=stufen[jj+i];
    if kp<>'' then begin
      while length(kp)<23 do kp:=kp+' ';
      if kp[1]<>'[' then begin
        for j:=1 to 23 do begin
          if (kp[j]<>'*') and (kp[j]<>':') then begin
            feld[i,j]:=kp[j];
            feld2[i,j]:=kp[j];
          end else begin
            if kp[j]<>':' then begin
              feld[i,j]:='X';
              feld2[i,j]:='-';
            end else begin
              feld[i,j]:='s';
              feld2[i,j]:='-';
            end;
          end;
        end;
      end
      else schluss:=true;
    end;
    inc(i)
  until (i>maxfelder) or schluss;
  wirklichzeilen:=i-2;
  vorlauf:=(16-wirklichzeilen) div 2;
  for jj:=wirklichzeilen downto 1 do begin
    for j:=1 to 23 do begin
      feld[jj+vorlauf,j]:=feld[jj,j];
      feld2[jj+vorlauf,j]:=feld2[jj,j];
    end;
  end;
  for jj:=1 to vorlauf do
    for j:=1 to 23 do begin
      feld[jj,j]:=' ';
      feld2[jj,j]:=' ';
    end;
  if schluss then
    for jj:=i-1+vorlauf to maxfelder do
      for j:=1 to 23 do begin
        feld[jj,j]:=' ';
        feld2[jj,j]:=' ';
      end;
  schrittzahl:=0;
  p1p(sender);
end;

procedure Tfsokoban.P1P(Sender: TObject);
var i,j,b:integer;
    ziel:tcanvas;
procedure xline(canv:tcanvas;a,b,c,d:integer);
begin
  canv.moveto(a,b);
  canv.lineto(c,d);
end;
begin
  bitmap.width:=pb1.width;
  bitmap.height:=pb1.height;
  ziel:=bitmap.canvas;
  ziel.brush.color:=clwhite;
  ziel.rectangle(-1,-1,pb1.width+1,pb1.height+1);
  b:=854 div 25;
  ziel.pen.style:=psclear;

  for i:=1 to maxfelder do
    for j:=1 to 23 do begin
      case feld[i,j] of
         ' ' : begin
                 ziel.brush.color:=clwhite;
                 ziel.rectangle(j*b,i*b,(j+1)*b,(i+1)*b);
               end;
         'M' : begin
                 ziel.draw(j*b,i*b,image1.Picture.bitmap);
               end;
     'X','*' : begin
                 ziel.draw(j*b,i*b,image2.Picture.bitmap);
               end;
         '-' : begin
                 ziel.brush.color:=cldkgray;
                 ziel.rectangle(j*b+2,i*b+2,(j+1)*b-2,(i+1)*b-2);
                 ziel.brush.color:=clwhite;
                 ziel.rectangle(j*b+7,i*b+7,(j+1)*b-6,(i+1)*b-6);
                 ziel.pen.style:=pssolid;
                 ziel.pen.width:=3;
                 ziel.pen.color:=cldkgray;
                 xline(ziel,j*b+5,i*b+5,(j+1)*b-5,(i+1)*b-6);
                 xline(ziel,(j+1)*b-5,i*b+5,j*b+5,(i+1)*b-6);
                 ziel.pen.style:=psclear;
                 ziel.pen.width:=1;
               end;
     's',':' : begin
                 if feld2[i,j]='-' then begin
                   aktx:=j;
                   akty:=i;
                   ziel.draw(j*b,i*b,image4.Picture.bitmap);
                 end else begin
                   aktx:=j;
                   akty:=i;
                   ziel.draw(j*b,i*b,image3.Picture.bitmap);
                 end;
              end;
      end;
    end;
  pb1.canvas.draw(0,0,bitmap);
  button1.enabled:=letzterzug<>0;
  test(sender);
end;

procedure Tfsokoban.test(Sender: TObject);
var i,j:integer;
    geschafft:boolean;
begin
  geschafft:=true;
  for i:=1 to maxfelder do
    for j:=1 to 23 do begin
      if feld2[i,j]='-' then
        if (feld[i,j]<>'X') then geschafft:=false;
    end;
  if geschafft then begin
    if timer1.enabled then begin
      button4.caption:='Demonstration';
      timer1.enabled:=false;
      exit;
    end;
    if stufe=maxsok then begin
      showmessage('Gratulation! Du hast alle Spielstufen erfolgreich absolviert!');
      stufe:=1;
    end else begin
      if stufe<1000 then showmessage('Gratulation! Erreichte Spielstufe '+inttostr(stufe+1)+'.')
                    else showmessage('Die Spielstufe wurde mit '+inttostr(schrittzahl)+' Schritten gelöst!');
      inc(stufe);
    end;
    if stufe<1000 then begin
      l1.caption:='Spielstufe '+inttostr(stufe);
      D1C(Sender);
    end;
  end;
end;

procedure Tfsokoban.x5C(Sender: TObject);
begin
  inc(schrittzahl);
  feldk:=feld;
  if (feld[akty-1,aktx]=' ') or (feld[akty-1,aktx]='-') then begin
    feld[akty-1,aktx]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=30;
    p1p(sender);
      if reduktion then begin
       if qqqschritt<>2 then begin verlaufqqq:=verlaufqqq+'0'; qqqschritt:=0; end
                        else begin delete(verlaufqqq,length(verlaufqqq),1); qqqschritt:=5; end;
         end;
    exit;
  end;
  if (feld[akty-1,aktx]='X') and ((feld[akty-2,aktx]=' ') or (feld[akty-2,aktx]='-')) then begin
    feld[akty-2,aktx]:='X';
    feld[akty-1,aktx]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=31;
    p1p(sender);
      if reduktion then begin
         verlaufqqq:=verlaufqqq+'0';
         qqqschritt:=5;
          end;
  end;
end;

procedure Tfsokoban.x2C(Sender: TObject);
begin
  inc(schrittzahl);
  feldk:=feld;
  if (feld[akty+1,aktx]=' ') or (feld[akty+1,aktx]='-') then begin
    feld[akty+1,aktx]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=40;
    p1p(sender);
      if reduktion then begin
       if qqqschritt<>0 then begin verlaufqqq:=verlaufqqq+'2'; qqqschritt:=2; end
                        else begin delete(verlaufqqq,length(verlaufqqq),1); qqqschritt:=5; end;
         end;
    exit;
  end;
  if (feld[akty+1,aktx]='X') and ((feld[akty+2,aktx]=' ') or (feld[akty+2,aktx]='-')) then begin
    feld[akty+2,aktx]:='X';
    feld[akty+1,aktx]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=41;
    p1p(sender);
      if reduktion then begin
         verlaufqqq:=verlaufqqq+'2';
         qqqschritt:=5;
          end;
  end;
end;

procedure Tfsokoban.x1C(Sender: TObject);
begin
  inc(schrittzahl);
  feldk:=feld;
    if (feld[akty,aktx-1]=' ') or (feld[akty,aktx-1]='-') then begin
    feld[akty,aktx-1]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=10;
    p1p(sender);
      if reduktion then begin
       if qqqschritt<>1 then begin verlaufqqq:=verlaufqqq+'3'; qqqschritt:=3; end
                        else begin delete(verlaufqqq,length(verlaufqqq),1); qqqschritt:=5; end;
         end;
    exit;
  end;
  if (feld[akty,aktx-1]='X') and ((feld[akty,aktx-2]=' ') or (feld[akty,aktx-2]='-')) then begin
    feld[akty,aktx-2]:='X';
    feld[akty,aktx-1]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=11;
    p1p(sender);
      if reduktion then begin
         verlaufqqq:=verlaufqqq+'3';
         qqqschritt:=5;
          end;
  end;
end;

procedure Tfsokoban.x4C(Sender: TObject);
begin
  inc(schrittzahl);
  feldk:=feld;
  if (feld[akty,aktx+1]=' ') or (feld[akty,aktx+1]='-') then begin
    feld[akty,aktx+1]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=20;
    p1p(sender);
      if reduktion then begin
       if qqqschritt<>3 then begin verlaufqqq:=verlaufqqq+'1'; qqqschritt:=1; end
                        else begin delete(verlaufqqq,length(verlaufqqq),1); qqqschritt:=5; end;
         end;
    exit;
  end;
  if (feld[akty,aktx+1]='X') and ((feld[akty,aktx+2]=' ') or (feld[akty,aktx+2]='-')) then begin
    feld[akty,aktx+2]:='X';
    feld[akty,aktx+1]:='s';
    if feld2[akty,aktx]='-' then feld[akty,aktx]:='-'
                            else feld[akty,aktx]:=' ';
    letzterzug:=21;
    p1p(sender);
      if reduktion then begin
         verlaufqqq:=verlaufqqq+'1';
         qqqschritt:=5;
          end;
  end;
end;

procedure Tfsokoban.D2C(Sender: TObject);
var x:string;
    a,code:integer;
begin
  x:=edit1.text;
  val(x,a,code);
  if a<1 then a:=1;
  if a>maxsok then a:=maxsok;
  stufe:=a;
  l1.caption:='Spielstufe '+inttostr(stufe);
  edit1.text:=inttostr(stufe);
  D1C(Sender);
end;

procedure Tfsokoban.D3C(Sender: TObject);
begin
  D2C(Sender);
  verlaufst:=verlauf[stufe-1];
  schritt:=1;
  timer1.enabled:= not timer1.enabled;
  if timer1.enabled then
    button4.caption:='Abbruch'
  else
    button4.caption:='Demonstration';
end;

procedure Tfsokoban.T1Timer(Sender: TObject);
var cc:char;
begin
  cc:=verlaufst[schritt];
  case cc of
      '0' : x5C(Sender);
      '1' : x4C(Sender);
      '2' : x2C(Sender);
      '3' : x1C(Sender);
  end;
  inc(schritt);
  if (not timer1.enabled) and (stufe<demonr) and volldemo then begin
    edit1.text:=inttostr(strtoint(edit1.text)+1);
    D2C(Sender);
    D3C(Sender);
  end;
end;

procedure Tfsokoban.M2C(Sender: TObject);
begin
  volldemo:=not volldemo;
  if volldemo then timer1.interval:=1
              else timer1.interval:=110;
end;

procedure Tfsokoban.FormDestroy(Sender: TObject);
begin
  verlauf.free;
  stufen.free;
  bitmap.free;
end;

procedure Tfsokoban.FormShow(Sender: TObject);
begin
  if self.width>1200 then panel4.width:=(self.width-1024) div 2;
end;

procedure Tfsokoban.Button1Click(Sender: TObject);
begin
  feld:=feldk;
  letzterzug:=0;
  p1p(sender);
end;

end.
