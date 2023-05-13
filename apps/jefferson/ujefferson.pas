unit ujefferson;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls, Grids, Mask, Spin;

type
  TFjefferson = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    jefferson: TPanel;
    Panel3: TPanel;
    Paintbox1: TPaintBox;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Button3: TButton;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label6: TLabel;
    Button6: TButton;
    SpinEdit1: TSpinEdit;
    Ihinter: TImage;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure Paintbox1Paint(Sender: TObject);
    procedure zeichnen(can:tcanvas);
    procedure b3C(Sender: TObject);
    procedure b4C(Sender: TObject);
    procedure b5C(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Paintbox1MDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Paintbox1MMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure b6C(Sender: TObject);
    procedure B8C(Sender: TObject);
  private
    bitm:array[65..90] of tbitmap;
    { Private declarations }
  public
    { Public declarations }
  end;

var  Fjefferson: TFjefferson;

implementation

uses jpeg;

{$R *.DFM}
var jeffersonverschiebung:array[0..25] of integer;
    jeffersonwinkel:array[0..25] of double;
    aktuelleswort,codewort:string;

const
    phabbruch: boolean =true;
    jeffscheiben = 25;

procedure TFjefferson.FormShow(Sender: TObject);
var i,sb:integer;
    k:string;
begin
  sb:=(Paintbox1.width-80) div jeffscheiben;
  for i:=65 to 90 do begin
    if bitm[i]<>nil then bitm[i].free;
    bitm[i]:=tbitmap.create;
    bitm[i].pixelformat:=pf32bit;
    bitm[i].width:=2*sb-4;
    bitm[i].height:=2*sb;
    bitm[i].canvas.font.name:='Verdana';
    bitm[i].canvas.font.size:=32;
    bitm[i].canvas.font.style:=[fsbold];
    bitm[i].canvas.brush.color:=clwhite;
    bitm[i].canvas.pen.color:=clmaroon;
    bitm[i].canvas.rectangle(0,0,2*sb,2*sb);
    k:=chr(i);
    bitm[i].canvas.textout(sb-bitm[i].canvas.textwidth(k) div 2,
                           sb-bitm[i].canvas.textheight(k) div 2,k);
  end;
  fillchar(jeffersonverschiebung,sizeof(jeffersonverschiebung),0);
  fillchar(jeffersonwinkel,sizeof(jeffersonwinkel),0);
end;

procedure TFjefferson.Paintbox1Paint(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=Paintbox1.width;
  bitmap.height:=Paintbox1.height;
  zeichnen(bitmap.canvas);
  Paintbox1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

function scheibentest(const k:string):boolean;
var i:integer;
    korrekt:boolean;
begin
  korrekt:=true;
  for i:=1 to length(k) do
    if not (k[i] in ['B'..'Z']) then korrekt:=false;
  scheibentest:=korrekt;
end;

procedure TFjefferson.zeichnen(can:tcanvas);
var b,h,sb,sh,xoff,i,j:integer;
    k:string;
    scheibenreihenfolge:string;
    buchstabe:char;
    bitmapnr,ver,ver2:integer;
    wanfang,wende:double;
    zrect,qrect:trect;
    codes:tstringlist;
begin
  codes:=tstringlist.create;
  codes.assign(listbox1.Items);
  scheibenreihenfolge:=edit3.text;
  if (length(scheibenreihenfolge)<>jeffscheiben) or (not scheibentest(scheibenreihenfolge)) then begin
    scheibenreihenfolge:='BCDEFGHIJKLMNOPQRSTUVWXYZ';
    edit3.text:=scheibenreihenfolge;
  end;
  ver:=strtoint(edit1.text);
  if ver<0 then ver:=ver+26;
  can.font.name:='Verdana';
  can.font.size:=20;
  can.font.style:=[fsitalic];
  b:=Paintbox1.width;
  h:=Paintbox1.height;
  sb:=(b-80) div jeffscheiben;
  xoff:=(b-jeffscheiben*sb) div 2;
  sh:=(h-160) div 2;
  can.brush.color:=clwhite;
  can.brush.bitmap:=ihinter.picture.bitmap;
  can.pen.color:=clnavy;
  can.rectangle(xoff div 2,h div 2-10,b-xoff div 2,h div 2+10);
  qrect.left:=2;
  qrect.right:=2*sb-2;
  qrect.top:=0;
  qrect.bottom:=2*sb;
  aktuelleswort:='';
  codewort:='';

  can.copymode:=cmsrcand;
  for i:=0 to jeffscheiben-1 do begin
    can.rectangle(xoff+i*sb,80,xoff+(i+1)*sb,h-80);
    for j:=-7 to 7 do begin
      bitmapnr:=j+jeffersonverschiebung[i];
      if bitmapnr<0 then inc(bitmapnr,26);
      if bitmapnr>25 then dec(bitmapnr,26);
      buchstabe:=codes[ord(scheibenreihenfolge[i+1])-66][bitmapnr+1];
      if j=0 then aktuelleswort:=aktuelleswort+buchstabe;
      ver2:=(bitmapnr+ver) mod 26;
      if j=0 then codewort:=codewort+codes[ord(scheibenreihenfolge[i+1])-66][ver2+1];
      zrect.left:=xoff+i*sb+2;
      zrect.right:=xoff+(i+1)*sb-2;
      wanfang:=j*pi/14-pi/28+jeffersonwinkel[i];
      wende:=(j+1)*pi/14-pi/28+jeffersonwinkel[i];
      zrect.top:=round(h/2+ sh*sin(wanfang));
      zrect.bottom:=round(h/2+ sh*sin(wende));
      can.copyrect(zrect,bitm[ord(buchstabe)].canvas,qrect);
    end;
  end;
  k:=aktuelleswort;
  can.textout(b div 2-can.textwidth(k) div 2,40-can.textheight(k) div 2,k);
  k:=codewort;
  can.textout(b div 2-can.textwidth(k) div 2,h-40-can.textheight(k) div 2,k);
  can.font.color:=clblue;
  can.textout(xoff,40-can.textheight(k) div 2,'Eingang');
  can.textout(xoff,h-40-can.textheight(k) div 2,'Ausgang');
  codes.free;
end;

procedure TFjefferson.b3C(Sender: TObject);
var i,b1,b2:integer;
    h:char;
    scheibenreihenfolge:string;
begin
  scheibenreihenfolge:=edit3.text;
  if (length(scheibenreihenfolge)<>jeffscheiben) or (not scheibentest(scheibenreihenfolge))  then begin
    scheibenreihenfolge:='BCDEFGHIJKLMNOPQRSTUVWXYZ';
    edit3.text:=scheibenreihenfolge;
  end;
  for i:=1 to 100 do begin
    b1:=random(jeffscheiben)+1;
    b2:=random(jeffscheiben)+1;
    h:=scheibenreihenfolge[b1];
    scheibenreihenfolge[b1]:=scheibenreihenfolge[b2];
    scheibenreihenfolge[b2]:=h;
  end;
  edit3.text:=scheibenreihenfolge;
  Paintbox1paint(sender);
end;

procedure TFjefferson.b4C(Sender: TObject);
var wi,geschw:double;
    i,ver:integer;
    aktuell:string;
begin
  if not phabbruch then begin
    phabbruch:=true;
    exit;
  end;
  geschw:=spinedit1.value;
  ver:=strtoint(edit1.text);
  if ver<0 then edit1.text:=inttostr(-ver);
  button2.caption:='Abbruch';
  aktuell:=edit2.text;
  if length(aktuell)>0 then begin
    i:=1;
    repeat
      if not (aktuell[i] in ['A'..'Z']) then delete(aktuell,i,1)
                                        else inc(i);
    until i>length(aktuell);
    if length(aktuell)>jeffscheiben then delete(aktuell,jeffscheiben+1,200);
    if length(aktuell)>0 then begin
      edit2.text:=aktuell;
      phabbruch:=false;
      for i:=1 to length(aktuell) do begin
        if aktuell[i]<>aktuelleswort[i] then begin
          repeat
            wi:=0;
            if geschw>0 then begin
              repeat
                jeffersonwinkel[i-1]:=wi;
                wi:=wi-pi/14/geschw;
                Paintbox1paint(sender);
                application.processmessages;
              until wi<-pi/14;
            end;
            jeffersonwinkel[i-1]:=0;
            inc(jeffersonverschiebung[i-1]);
            jeffersonverschiebung[i-1]:=jeffersonverschiebung[i-1] mod 26;
            Paintbox1paint(sender);
          until (aktuell[i]=aktuelleswort[i]) or (phabbruch);
        end;
        if phabbruch then break;
      end;
    end
  end;
  Paintbox1paint(sender);
  edit4.text:=copy(codewort,1,length(aktuell));
  button2.caption:='Nachricht kodieren';
  phabbruch:=true;
end;

procedure TFjefferson.b5C(Sender: TObject);
var wi,geschw:double;
    i,ver:integer;
    aktuell:string;
begin
  if not phabbruch then begin
    phabbruch:=true;
    exit;
  end;
  geschw:=spinedit1.value;
  ver:=strtoint(edit1.text);
  if ver>0 then edit1.text:=inttostr(-ver);
  button3.caption:='Abbruch';
  aktuell:=edit4.text;
  if length(aktuell)>0 then begin
    i:=1;
    repeat
      if not (aktuell[i] in ['A'..'Z']) then delete(aktuell,i,1)
                                        else inc(i);
    until i>length(aktuell);
    if length(aktuell)>jeffscheiben then delete(aktuell,jeffscheiben+1,200);
    if length(aktuell)>0 then begin
      edit4.text:=aktuell;
      phabbruch:=false;
      for i:=1 to length(aktuell) do begin
        if aktuell[i]<>aktuelleswort[i] then begin
          repeat
            if geschw>0 then begin
              wi:=0;
              repeat
                jeffersonwinkel[i-1]:=wi;
                wi:=wi-pi/14/geschw;
                Paintbox1paint(sender);
                application.processmessages;
              until wi<-pi/14;
            end;
            jeffersonwinkel[i-1]:=0;
            inc(jeffersonverschiebung[i-1]);
            jeffersonverschiebung[i-1]:=jeffersonverschiebung[i-1] mod 26;
            Paintbox1paint(sender);
          until (aktuell[i]=aktuelleswort[i]) or (phabbruch);
        end;
        if phabbruch then break;
      end;
    end
  end;
  Paintbox1paint(sender);
  edit2.text:=copy(codewort,1,length(aktuell));
  button3.caption:='Nachricht dekodieren';
  phabbruch:=true;
end;

procedure TFjefferson.FormDestroy(Sender: TObject);
var i:integer;
begin
  for i:=65 to 90 do bitm[i].free;
end;

procedure TFjefferson.Paintbox1MDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,sb,xoff:integer;
    wi,geschw:double;
begin
  b:=Paintbox1.width;
  sb:=(b-80) div jeffscheiben;
  xoff:=(b-jeffscheiben*sb) div 2;
  sb:=(x-xoff) div sb;
  if (sb>=0) and (sb<jeffscheiben) then begin
    geschw:=spinedit1.value;
    if geschw<4 then geschw:=4;
    if y>Paintbox1.height div 2 then begin
      wi:=0;
      repeat
        jeffersonwinkel[sb]:=wi;
        wi:=wi+pi/14/geschw;
        Paintbox1paint(sender);
        application.processmessages;
      until wi>pi/14;
      jeffersonwinkel[sb]:=0;
      dec(jeffersonverschiebung[sb]);
      jeffersonverschiebung[sb]:=(jeffersonverschiebung[sb]+26) mod 26;
      Paintbox1paint(sender);
    end else begin
      wi:=0;
      repeat
        jeffersonwinkel[sb]:=wi;
        wi:=wi-pi/14/geschw;
        Paintbox1paint(sender);
        application.processmessages;
      until wi<-pi/14;
      jeffersonwinkel[sb]:=0;
      inc(jeffersonverschiebung[sb]);
      jeffersonverschiebung[sb]:=jeffersonverschiebung[sb] mod 26;
      Paintbox1paint(sender);
    end;
  end;
end;

procedure TFjefferson.Paintbox1MMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var b,sb,xoff:integer;
begin
  b:=Paintbox1.width;
  sb:=(b-80) div jeffscheiben;
  xoff:=(b-jeffscheiben*sb) div 2;
  if x-xoff>0 then begin
    sb:=(x-xoff) div sb;
    if (sb>=0) and (sb<jeffscheiben) then
      Paintbox1.cursor:=crhandpoint
    else
      Paintbox1.cursor:=crdefault;
  end else Paintbox1.cursor:=crdefault;
end;

procedure TFjefferson.b6C(Sender: TObject);
var i:integer;
begin
  if not phabbruch then begin
    phabbruch:=true;
    exit;
  end;
  phabbruch:=false;
  for i:=1 to 25 do begin
    if sender=button4 then inc(jeffersonverschiebung[i-1]);
    if sender=button5 then dec(jeffersonverschiebung[i-1]);
    jeffersonverschiebung[i-1]:=(jeffersonverschiebung[i-1]+26) mod 26;
  end;
  Paintbox1paint(sender);
  phabbruch:=true;
end;

procedure TFjefferson.B8C(Sender: TObject);
var scheibenreihenfolge:string;
begin
  scheibenreihenfolge:=edit3.text;
  if (length(scheibenreihenfolge)<>jeffscheiben) or (not scheibentest(scheibenreihenfolge)) then begin
    scheibenreihenfolge:='BCDEFGHIJKLMNOPQRSTUVWXYZ';
    edit3.text:=scheibenreihenfolge;
  end;
  Paintbox1paint(sender);
end;

end.

