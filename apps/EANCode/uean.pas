unit uean;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, ExtDlgs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Ende1: TMenuItem;
    Bildladen1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure Ende1Click(Sender: TObject);
    procedure Bildladen1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var i,start,stop,
    p,laenge,farbe:integer;
    scode,scode2,s,c,cs:string;
    punkt1,punkt2:tpoint;
begin
    image1.picture.bitmap.pixelformat:=pf4bit;
    //linker, rechter Punkt
    punkt1.x:=2;
    punkt2.x:=image1.width-2;
    punkt1.y:=image1.height div 2;
    punkt2.y:=punkt1.y;

    farbe:=image1.Canvas.Pixels[punkt1.x,punkt1.y];
    i:=punkt1.x;
    while image1.canvas.pixels[i,punkt1.y]= farbe do inc(i);
    start:=i;
    i:=punkt2.x;
    while image1.canvas.pixels[i,punkt1.y]= farbe do dec(i);
    stop:=i+1;

    laenge:=round((stop-start)/95);
    scode:='';
    for i:=0 to 94 do
      if image1.Canvas.Pixels[start+i*laenge,punkt1.y]<>farbe then scode:=scode+'1'
                                                          else scode:=scode+'0';
    scode2:=scode;
    c:='';
    cs:='';
    for i:=1 to 6 do
    begin
      s:='';
      s:=scode2[i*7-3]+scode2[i*7-2]+scode2[i*7-1]+scode2[i*7]+scode2[i*7+1]+scode2[i*7+2]+scode2[i*7+3];
      if s='0001101' then begin c:=c+'0'; cs:=cs+'A'; end;
      if s='0100111' then begin c:=c+'0'; cs:=cs+'B'; end;
      if s='0011001' then begin c:=c+'1'; cs:=cs+'A'; end;
      if s='0110011' then begin c:=c+'1'; cs:=cs+'B'; end;
      if s='0010011' then begin c:=c+'2'; cs:=cs+'A'; end;
      if s='0011011' then begin c:=c+'2'; cs:=cs+'B'; end;
      if s='0111101' then begin c:=c+'3'; cs:=cs+'A'; end;
      if s='0100001' then begin c:=c+'3'; cs:=cs+'B'; end;
      if s='0100011' then begin c:=c+'4'; cs:=cs+'A'; end;
      if s='0011101' then begin c:=c+'4'; cs:=cs+'B'; end;
      if s='0110001' then begin c:=c+'5'; cs:=cs+'A'; end;
      if s='0111001' then begin c:=c+'5'; cs:=cs+'B'; end;
      if s='0101111' then begin c:=c+'6'; cs:=cs+'A'; end;
      if s='0000101' then begin c:=c+'6'; cs:=cs+'B'; end;
      if s='0111011' then begin c:=c+'7'; cs:=cs+'A'; end;
      if s='0010001' then begin c:=c+'7'; cs:=cs+'B'; end;
      if s='0110111' then begin c:=c+'8'; cs:=cs+'A'; end;
      if s='0001001' then begin c:=c+'8'; cs:=cs+'B'; end;
      if s='0001011' then begin c:=c+'9'; cs:=cs+'A'; end;
      if s='0010111' then begin c:=c+'9'; cs:=cs+'B'; end;
    end;
    if cs='AAAAAA' then c:='0'+c;
    if cs='AABABB' then c:='1'+c;
    if cs='AABBAB' then c:='2'+c;
    if cs='AABBBA' then c:='3'+c;
    if cs='ABAABB' then c:='4'+c;
    if cs='ABBAAB' then c:='5'+c;
    if cs='ABBBAA' then c:='6'+c;
    if cs='ABABAB' then c:='7'+c;
    if cs='ABABBA' then c:='8'+c;
    if cs='ABBABA' then c:='9'+c;

    for i:=1 to 6 do
    begin
      s:='';
      s:=scode2[i*7+44]+scode2[i*7+45]+scode2[i*7+46]+scode2[i*7+47]+scode2[i*7+48]+scode2[i*7+49]+scode2[i*7+50];
      if s='1110010' then c:=c+'0';
      if s='1100110' then c:=c+'1';
      if s='1101100' then c:=c+'2';
      if s='1000010' then c:=c+'3';
      if s='1011100' then c:=c+'4';
      if s='1001110' then c:=c+'5';
      if s='1010000' then c:=c+'6';
      if s='1000100' then c:=c+'7';
      if s='1001000' then c:=c+'8';
      if s='1110100' then c:=c+'9';
    end;

    label2.Caption:=c;
    if length(c)= 13 then
       p:=strtoint(c[1])+3*strtoint(c[2])+strtoint(c[3])+3*strtoint(c[4])+strtoint(c[5])
       +3*strtoint(c[6])+strtoint(c[7])+3*strtoint(c[8])+strtoint(c[9])
       +3*strtoint(c[10])+strtoint(c[11])+3*strtoint(c[12])+strtoint(c[13])
    else p:=-1;
    if p mod 10 = 0 then //korrekt'
    else
      if p=-1 then label2.Caption:='falsche Bereichsangabe'
              else label2.Caption:='nicht korrekt';
end;

procedure TForm1.Ende1Click(Sender: TObject);
begin
   close
end;

procedure TForm1.Bildladen1Click(Sender: TObject);
begin
    if openpicturedialog1.execute then
    begin
      image1.picture.loadfromfile(openpicturedialog1.filename);
    end;
end;

end.
