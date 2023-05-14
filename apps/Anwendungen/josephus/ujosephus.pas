unit ujosephus;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, ExtDlgs, Buttons, Mask, Spin;

type
  TFjosephus = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    josephus: TPanel;
    Panel4: TPanel;
    Panel7: TPanel;
    Liste: TListBox;
    Panel6: TPanel;
    Memo1: TMemo;
    Panel5: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;
    Panel1: TPanel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Paintbox: TPaintBox;
    Label1: TLabel;
    pic1: TImage;
    pic2: TImage;
    pic3: TImage;
    pic4: TImage;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure Formshow(Sender: TObject);
    procedure D8C(Sender: TObject);
    procedure I12MD(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Go;
    procedure Rx1C(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Fjosephus: TFjosephus;

implementation

uses math;

{$R *.DFM}
var angle, radius : extended;
    smileysize, centerx, centery:integer;
    selected:integer;

const labbruch : boolean = true;

procedure TFjosephus.Formshow(Sender: TObject);
begin
  rx1c(sender);
end;

procedure TFjosephus.Rx1C(Sender: TObject);
var
  i,s2:integer;
  cp:TPoint;
begin
  angle:=2*pi/spinedit1.value;
  centerx:=(Paintbox.width) div 2;
  centery:=(Paintbox.height) div 2;
  radius:=0.9*centerx;
  if 0.9*centery<radius then radius:=0.9*centery;
  smileysize:=pic1.width;
  s2:=smileysize div 2;
  Paintbox.canvas.font.name:='Verdana';
  Paintbox.canvas.fillrect(Paintbox.clientrect);
  Paintbox.canvas.CopyMode:=cmsrcand;
  for i:= 0 to round(spinedit1.value-1) do begin
    cp.x:=centerx+trunc(radius*cos(i*angle-pi/2));
    cp.y:=centery+trunc(radius*sin(i*angle-pi/2));
    Paintbox.canvas.draw(cp.x-s2,cp.y-s2,pic1.picture.bitmap);
    cp.x:=centerx+trunc((radius-30)*cos(i*angle-pi/2))-6;
    cp.y:=centery+trunc((radius-30)*sin(i*angle-pi/2))-6;
    Paintbox.canvas.TextOut(cp.x,cp.y,inttostr(i+1));
  end;
  Paintbox.canvas.CopyMode:=cmsrccopy;
end;

procedure TFjosephus.D8C(Sender: TObject);
begin
  memo1.clear;
  rx1c(sender);
end;

procedure TFjosephus.I12MD(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  a:extended;
  s2:integer;
  cp:TPoint;
begin
  s2:=pic1.width div 2;
  rx1c(sender);
  if centerx=x then x:=centerx+1;
  a:=arctan2((centerx-x),y-centery);
  a:=a-pi +pi/spinedit1.value;
  if a<0 then a:=a+2*pi;
  selected:=trunc(a/(2*pi)*spinedit1.value);
  memo1.lines.add(format('Position %d',[selected+1]));
  cp.x:=centerx+trunc(radius*cos((selected)*angle-pi/2));
  cp.y:=centery+trunc(radius*sin((selected)*angle-pi/2));
  Paintbox.canvas.draw(cp.x-s2,cp.y-s2,pic3.picture.bitmap);
  Go;
end;

procedure TFjosephus.Go;
var
  s2,i,j,n,increment,count:integer;
  circle:array of integer;
  cp:TPoint;
begin
  s2:=pic1.width div 2;
  memo1.clear;
  setlength(circle,round(spinedit1.value)+1);
  for i:= 0 to round(spinedit1.value-1) do circle[i]:=i+1;
  count:=round(spinedit1.value);
  increment:=round(spinedit2.value);
  n:=(increment-1) mod count;
  for i:= 0 to round(spinedit1.value-2) do begin
    cp.x:=centerx+trunc(radius*cos((circle[n]-1)*angle-pi/2));
    cp.y:=centery+trunc(radius*sin((circle[n]-1)*angle-pi/2));
    dec(count);
    if circle[n]<>selected+1 then begin
      Paintbox.canvas.draw(cp.x-s2,cp.y-s2,pic2.picture.bitmap);
      memo1.lines.add(inttostr(circle[n])+' ist aus!')
    end else begin
      Paintbox.canvas.draw(cp.x-s2,cp.y-s2,pic4.picture.bitmap);
      memo1.lines.add(' ');
      memo1.lines.add('Pech!, Person '+inttostr(selected+1)+' ist aus!');
      memo1.lines.add(' ');
    end;
    for j:=n to count-1 do circle[j]:=circle[j+1];
    n:=(n+increment-1) mod count;
    update;
  end;
  memo1.lines.add(' ');
  memo1.lines.add('Nummer '+inttostr(circle[0])+' ist der Gewinner');
  if circle[0]=selected+1 then memo1.lines.add('Richtig gewählt!');
end;

procedure TFjosephus.Button1Click(Sender: TObject);
var ss,j,i,r,xx:integer;
    gefunden:boolean;
    weite,x,personen:int64;
    kk:string;
begin
  if not labbruch then begin
    labbruch:=true;
    exit
  end else begin
    Liste.clear;
    button1.caption:='Stopp';
    labbruch:=false;
    personen:=strtoint(edit1.text);
    if personen<2 then personen:=2;
    if personen>20000 then personen:=20000;
    edit1.text:=inttostr(personen);
    weite:=strtoint(edit2.text);
    if weite<1 then weite:=1;
    edit2.text:=inttostr(weite);
    Liste.items.add('Reihenfolge des Ausscheidens für Weite '+edit2.text);
    ss:=0;
    kk:='';
    xx:=1;
    repeat
      ss:=ss+1;
      x:=weite*ss;
      while x>personen do x:=(weite*(x-personen)-1) div (weite-1);
      kk:=inttostr(ss)+'.Aus'+#09+'Nummer '+inttostr(x);
      Liste.items.add(kk);
      if xx mod 100 = 0 then begin
        label1.caption:=inttostr(trunc(100.0*ss/personen))+' %';
        application.processmessages;
      end;
      inc(xx);
    until (ss=personen) or labbruch;

    if not labbruch then begin
      i:=2;
      gefunden:=false;
      kk:='-';
      repeat
        r:=0;
        for j:=1 to personen do r:=(r + i) mod j;
        if r=0 then begin
          gefunden:=true;
          kk:=inttostr(i);
        end;
        inc(i);
        if i mod 100 = 0 then begin
          label1.caption:=inttostr(trunc(100.0*ss/personen))+' %';
          application.processmessages;
        end;
      until gefunden or (i>=personen);
      Liste.items.insert(0,'Optimale Weite '+kk);
      Liste.items.insert(1,' ');
    end;
    labbruch:=true;
    label1.caption:='';
    button1.caption:='Berechnung';
  end;
end;

end.

