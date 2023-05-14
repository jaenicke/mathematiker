unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, math, ComCtrls, shellapi;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioGroup1: TRadioGroup;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label0: TLabel;
    Panel3: TPanel;
    Timer1: TTimer;
    Button2: TButton;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const steigen:boolean=false;
var   schrift1:boolean;
      hfont:thandle;

procedure TForm1.Button1Click(Sender: TObject);
const faktor:integer=50;
var a,b,c,f,alpha,q,p,h:real;
    x0,y0:integer;
    punkte:array[0..4] of tpoint;
    bitmap:tbitmap;
begin
    faktor:=updown1.position;
    if edit1.text='' then edit1.text:='3';
    if edit2.text='' then edit2.text:='4';

    a:=strtofloat(edit1.text);
    if a<=0 then
      begin edit1.text:='3'; a:=3 end;
    b:=strtofloat(edit2.text);
    if b<=0 then
      begin edit2.text:='4'; b:=4 end;

    c:=sqrt(a*a+b*b);
    label10.caption:=floattostrf(c,ffgeneral,4,2);
    f:=a*b/2;
    label11.caption:=floattostrf(f,ffgeneral,4,2);
    alpha:=arcsin(a/c)*180/pi;
    label12.caption:=floattostrf(alpha,ffgeneral,4,2)+'°';
    label13.caption:=floattostrf(90-alpha,ffgeneral,4,2)+'°';

    p:=a*a/c;
    label15.caption:=floattostrf(p,ffgeneral,4,2);
    q:=b*b/c;
    label16.caption:=floattostrf(q,ffgeneral,4,2);
    h:=sqrt(p*q);
    label14.caption:=floattostrf(h,ffgeneral,4,2);

    // Zeichnung
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox1.width;
    bitmap.height:=paintbox1.height;
    with bitmap.Canvas do
    begin
      q:=b*b/c;
      p:=c-q;
      h:=sqrt(q*(c-q));
      brush.color:=clwhite;
      rectangle(-1,-1,paintbox1.width+1,paintbox1.height+1);
      x0:=round((paintbox1.width-faktor*c)/2);
      y0:=round((paintbox1.height-c-h+50)/2);

      punkte[0].x:=x0; punkte[0].y:=y0;
      punkte[1].x:=round(x0+faktor*c); punkte[1].y:=y0;
      punkte[2].x:=round(x0+faktor*q); punkte[2].y:=round(y0-h*faktor);
      brush.color:=clyellow;
      polygon(slice(punkte,3));

      punkte[0].x:=round(x0+faktor*c); punkte[0].y:=y0;
      punkte[1].x:=round(x0+faktor*(c+h)); punkte[1].y:=round(y0-p*faktor);
      punkte[2].x:=round(x0+faktor*(c+h-p)); punkte[2].y:=round(y0-faktor*(p+h));
      punkte[3].x:=round(x0+faktor*q); punkte[3].y:=round(y0-h*faktor);
      brush.color:=clred;
      polygon(slice(punkte,4));

      punkte[0].x:=round(x0+faktor*q); punkte[0].y:=round(y0-h*faktor);
      punkte[1].x:=round(x0+faktor*(q-h)); punkte[1].y:=round(y0-(q+h)*faktor);
      punkte[2].x:=round(x0+faktor*(-h)); punkte[2].y:=round(y0-faktor*q);
      punkte[3].x:=round(x0); punkte[3].y:=y0;
      brush.color:=clgreen;
      polygon(slice(punkte,4));

      if checkbox1.checked then
      begin
        punkte[0].x:=x0; punkte[0].y:=y0;
        punkte[1].x:=round(x0+faktor*q); punkte[1].y:=y0;
        punkte[2].x:=round(x0+faktor*q); punkte[2].y:=round(y0+faktor*c);
        punkte[3].x:=round(x0); punkte[3].y:=round(y0+faktor*c);
        brush.color:=clgreen;
        polygon(slice(punkte,4));

        punkte[0].x:=round(x0+faktor*q); punkte[0].y:=y0;
        punkte[1].x:=round(x0+faktor*c); punkte[1].y:=y0;
        punkte[2].x:=round(x0+faktor*c); punkte[2].y:=round(y0+faktor*c);
        punkte[3].x:=round(x0+faktor*q); punkte[3].y:=round(y0+faktor*c);
        brush.color:=clred;
        polygon(slice(punkte,4));
      end
      else
      begin
        punkte[0].x:=x0; punkte[0].y:=y0;
        punkte[1].x:=round(x0+faktor*c); punkte[1].y:=y0;
        punkte[2].x:=round(x0+faktor*c); punkte[2].y:=round(y0+faktor*c);
        punkte[3].x:=round(x0); punkte[3].y:=round(y0+faktor*c);
        brush.color:=clblue;
        polygon(slice(punkte,4));
      end;

      moveto(round(x0+faktor*q),round(y0-h*faktor));
      lineto(round(x0+faktor*q),round(y0+c*faktor));
      arc(x0,round(y0-c/2*faktor),round(x0+faktor*c),round(y0+c/2*faktor),
             round(x0+faktor*c),y0,x0,y0);
      brush.style:=bsclear;
      font.name:='Verdana';
      font.size:=16;
      textout(x0-20,y0,'A');
      textout(round(x0+faktor*c+5),y0,'B');
      textout(round(x0+faktor*q-5),round(y0-h*faktor-36),'C');
      paintbox1.Canvas.draw(0,0,bitmap);
    end;
    bitmap.free;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
var i,nr:integer;
begin
   if (radiogroup1.itemindex=4) then
   begin
       for i := 2 to 3 do
        (FindComponent('panel'+inttostr(i)) as TPanel).font.name:='Mathe05r';
       for i := 1 to 2 do
        (FindComponent('button'+inttostr(i)) as TButton).font.name:='Mathe05r';
       for i := 0 to 9 do
        (FindComponent('label'+inttostr(i)) as TLabel).font.name:='Mathe05r';
       checkbox1.font.name:='Mathe05r';
       radiogroup1.font.name:='Mathe05r';
   end
   else
   begin
       for i := 2 to 3 do
        (FindComponent('panel'+inttostr(i)) as TPanel).font.name:='Verdana';
       for i := 1 to 2 do
        (FindComponent('button'+inttostr(i)) as TButton).font.name:='Verdana';
       for i := 0 to 9 do
        (FindComponent('label'+inttostr(i)) as TLabel).font.name:='Verdana';
       checkbox1.font.name:='Verdana';
       radiogroup1.font.name:='Verdana';
   end;

           nr:=radiogroup1.itemindex*24;
           panel2.caption:=listbox1.items[nr+1];
           panel3.caption:=listbox1.items[nr+2];
           label1.caption:=listbox1.items[nr+3];
           label2.caption:=listbox1.items[nr+4];
           label3.caption:=listbox1.items[nr+5];
           label4.caption:=listbox1.items[nr+6];
           label5.caption:=listbox1.items[nr+7];
           label6.caption:=listbox1.items[nr+8];
           label7.caption:=listbox1.items[nr+9];
           label8.caption:=listbox1.items[nr+10];
           label9.caption:=listbox1.items[nr+11];
           label0.caption:=listbox1.items[nr+12];
           radiogroup1.caption:=listbox1.items[nr+13];
           radiogroup1.items[0]:=listbox1.items[nr+14];
           radiogroup1.items[1]:=listbox1.items[nr+15];
           radiogroup1.items[2]:=listbox1.items[nr+16];
           radiogroup1.items[3]:=listbox1.items[nr+17];
           radiogroup1.items[4]:=listbox1.items[nr+18];
           radiogroup1.items[5]:=listbox1.items[nr+19];
           radiogroup1.items[6]:=listbox1.items[nr+20];
           checkbox1.caption:=listbox1.items[nr+21];
           button1.caption:=listbox1.items[nr+22];
           button2.caption:=listbox1.items[nr+23];
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var a:real;
begin
    a:=strtofloat(edit1.text);
    if steigen then a:=a+0.05 else a:=a-0.05;
    if a<0.5 then steigen:=true;
    if a>6 then steigen:=false;
    edit1.text:=floattostr(a);
    button1click(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     timer1.enabled:=not timer1.enabled;
     if timer1.enabled then begin
                          if radiogroup1.itemindex=4 then button2.caption:='Ctop'
                                                     else button2.caption:='Stop'
                       end
                       else RadioGroup1Click(Sender);
end;

function fontlesen(const name:string):boolean;
var ms1: TResourcestream;
    ms: TMemoryStream;
    cn: dword;
begin
  ms1 := TResourceStream.Create(hinstance,name,'RT_RCDATA');
  try
    ms:= TMemoryStream.Create;
    try
      ms.CopyFrom(ms1, 0);
      hfont:=AddFontMemResourceEx(ms.Memory, ms.Size, nil, @cn);
      fontlesen:=true;
    finally
      ms.Free;
    end;
  finally
    ms1.Free;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
var fontliste:tstringlist;
begin
    fontliste:=tstringlist.create;
    fontliste.clear;
    fontliste.Sorted:=True;
    fontliste.addstrings(Screen.Fonts);
    schrift1:=false;
    if fontliste.indexof('Mathe05r')<0 then schrift1:=fontlesen('mathe05r');
    fontliste.free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if schrift1 then RemoveFontMemResourceEx(hfont);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.youtube.com/watch?v=VrkA_sEPn1M&feature=youtu.be', nil, nil, SW_SHOWNORMAL) ;
end;

end.
