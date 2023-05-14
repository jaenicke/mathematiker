unit utrireg;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, messages,
  Menus, ExtCtrls, ComCtrls, StdCtrls, CheckLst, Grids, Buttons, _grund;

type
  TForm1 = class(TForm)
    Panel5: TPanel;
    Panel1: TPanel;
    trigoreg: TPanel;
    Panel4: TPanel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    S1: TSpeedButton;
    Button1: TButton;
    SG4: TStringGrid;
    Panel3: TPanel;
    PB4: TPaintBox;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel6: TPanel;
    Listbox1: TListBox;
    rt1: TRadioButton;
    rt2: TRadioButton;
    rt3: TRadioButton;
    rt4: TRadioButton;
    rt5: TRadioButton;
    Edit5: TEdit;
    Label3: TLabel;
    S11: TSpeedButton;
    procedure S13C(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure D18C(Sender: TObject);
    procedure S1X(Sender: TObject);
    procedure PB4Paint(Sender: TObject);
    procedure Listbox1Click(Sender: TObject);
    procedure S11C(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure xpb3Paint(can:tcanvas);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses fktint, graph_reduziert, math;

const sabbruch : boolean = true;
{$R *.DFM}

procedure TForm1.S13C(Sender: TObject);
begin
  close
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  sabbruch:=true;
  sg4.cells[0,0]:='x';
  sg4.cells[1,0]:='y';
  sg4.cells[2,0]:='f(x)';
  lclear;
end;

procedure TForm1.xpb3Paint(can:tcanvas);
var ufaktor:double;
begin
  ufaktor:=1;
  graphikinitialisieren(pb4.width,pb4.height,8*ufaktor,-8*ufaktor,10*ufaktor,-10*ufaktor);
  setbkmode(can.handle,transparent);
  can.font.name:='Verdana';
  can.font.size:=9;
  koordinatensystem(can);
  zeichnen(can);
  graphikschliessen;
end;

var ko:gfeld;

procedure TForm1.D18C(Sender: TObject);
label 1;
var d:array[0..10] of extended;
    m,anz,i,j,ji,ii,jj,ia,ja,nnr,xxx,yyy,zzz:integer;
    xr,yr:array[0..200] of extended;
    k,ks:string;
    det:double;
    fehler:boolean;
    su,va,rv:extended;
    ka,kb,kc,kd:double;
    xka,xkb,xkc,xkd,xsu:double;
    aa,bb,cc,dd:double;
    ordnung:integer;
    code:integer;
  function funk(x:double;nr:integer):double;
  begin
    funk:=1;
    case ordnung of
      5 : case nr of
            0 : funk:=sin(kb*x+kc);
            1 : funk:=x*ka*cos(kb*x+kc);
            2 : funk:=ka*cos(kb*x+kc);
          end;
      4 : case nr of
            0 : funk:=sin(kb*x+cc);
            1 : funk:=x*ka*cos(kb*x+cc);
            2 : funk:=1;
          end;
      3 : case nr of
            0 : funk:=sin(bb*x+kb);
            1 : funk:=ka*cos(bb*x+kb);
            2 : funk:=1;
          end;
      2 : case nr of
            0 : funk:=x*aa*cos(ka*x+kb);
            1 : funk:=aa*cos(ka*x+kb);
            2 : funk:=1;
          end;
     else case nr of
            0 : funk:=sin(kb*x+kc);
            1 : funk:=x*ka*cos(kb*x+kc);
            2 : funk:=ka*cos(kb*x+kc);
            3 : funk:=1;
          end;
    end;
  end;
  procedure ausgabe(ka,kb,kc,dd:double);
  begin
    k:=_strkomma(ka,1,6)+'*SIN('+_strkomma(kb,1,6)+'*X'+vorzeichenzahlkomma(kc,1,6)+')'
       +vorzeichenzahlkomma(dd,1,6);
  end;
  procedure ausgabe2(xka,xkb,xkc,dd:double);
  begin
    k:=_strkomma(xka,1,4)+'*SIN('+_strkomma(xkb,1,4)+'*X'+vorzeichenzahlkomma(xkc,1,4)+')'
       +vorzeichenzahlkomma(dd,1,4);
  end;
begin
  if not sabbruch then begin
    sabbruch:=true;
    button1.caption:='Berechnung';
  end else begin
    dd:=0;
    sabbruch:=false;
    application.processmessages;
    button1.caption:='Abbruch';
    ordnung:=1;
    if rt2.checked then ordnung:=2;
    if rt3.checked then ordnung:=3;
    if rt4.checked then ordnung:=4;
    if rt5.checked then ordnung:=5;
    case ordnung of
      2 : begin
            m:=2;
            aa:=ein_double(edit1)
          end;
      3 : begin
            m:=2;
            bb:=ein_double(edit2)
          end;
      4 : begin
            m:=2;
            cc:=ein_double(edit3)
          end;
      5 : begin
            m:=2;
            dd:=ein_double(edit4)
          end;
     else m:=3;
    end;
    anz:=0;
    for i:=1 to 200 do begin
      k:=sg4.Cells[0,i];
      if k<>'' then begin
        inc(anz);
        val(komma(sg4.cells[0,i]),xr[i-1],code);
        val(komma(sg4.cells[1,i]),yr[i-1],code);
      end;
    end;
    label2.caption:=inttostr(anz);
    Listbox1.clear;
    for zzz:=1 to 20 do begin
      xka:=0;
      xkb:=0;
      xkc:=0;
      xkd:=0;
      xsu:=10000;
      for yyy:=1 to 20 do begin
        ka:=10*random-5;
        kb:=10*random-5;
        kc:=10*random-5;
        kd:=10*random-5;
        for xxx:=1 to 40 do begin
          for j:=0 to m do begin
            for ji:=0 to m do begin
              ko[j+1,ji+1]:=0;
              for i:=0 to anz-1 do ko[j+1,ji+1]:=ko[j+1,ji+1]+funk(xr[i],j)*funk(xr[i],ji);
            end;
          end;
          for j:=0 to m do begin
            ko[j+1,0]:=0;
            case ordnung of
              5 : for i:=0 to anz-1 do ko[j+1,0]:=ko[j+1,0]+(yr[i]-(ka*sin(kb*xr[i]+kc)+dd))*funk(xr[i],j);
              4 : for i:=0 to anz-1 do ko[j+1,0]:=ko[j+1,0]+(yr[i]-(ka*sin(kb*xr[i]+cc)+kc))*funk(xr[i],j);
              3 : for i:=0 to anz-1 do ko[j+1,0]:=ko[j+1,0]+(yr[i]-(ka*sin(bb*xr[i]+kb)+kc))*funk(xr[i],j);
              2 : for i:=0 to anz-1 do ko[j+1,0]:=ko[j+1,0]+(yr[i]-(aa*sin(ka*xr[i]+kb)+kc))*funk(xr[i],j)
             else for i:=0 to anz-1 do ko[j+1,0]:=ko[j+1,0]+(yr[i]-(ka*sin(kb*xr[i]+kc)+kd))*funk(xr[i],j);
            end;
          end;
          fehler:=false;
          gaussv(ko,m+1,det,fehler);
          ka:=ka+ko[0,1];
          kb:=kb+ko[0,2];
          kc:=kc+ko[0,3];
          kd:=kd+ko[0,4];
        end;
        su:=0;
        case ordnung of
          5 : ausgabe(ka,kb,kc,dd);
          4 : ausgabe(ka,kb,cc,kc);
          3 : ausgabe(ka,bb,kb,kc);
          2 : ausgabe(aa,ka,kb,kc)
        else  ausgabe(ka,kb,kc,kd);
        end;
        if (ordnung=3) or (abs(kb)<=ein_double(edit5)) then begin
          for i:=0 to m do
            su:=su+sqr(yr[i]-funktionswert(k,xr[i]));
          if su<xsu then begin
            xsu:=su;
            xka:=ka;
            xkb:=kb;
            xkc:=kc;
            xkd:=kd;
          end;
        end;
      end;
      if ordnung=1 then begin
        if xkb<0 then begin
          xka:=-xka;
          xkb:=-xkb;
          xkc:=-xkc;
        end;
        while xkc<0 do xkc:=xkc+2*pi;
        while xkc>2*pi do xkc:=xkc-2*pi;
      end;
      case ordnung of
        5 : ausgabe(xka,xkb,xkc,dd);
        4 : ausgabe(xka,xkb,cc,xkc);
        3 : ausgabe(xka,bb,xkb,xkc);
        2 : ausgabe(aa,xka,xkb,xkc)
      else  ausgabe(xka,xkb,xkc,xkd);
      end;
      ks:=_strkomma(xsu,1,4)+#9'Y = '+k;
      if Listbox1.items.indexof(ks)<0 then Listbox1.items.add(ks);
      application.processmessages;
      if sabbruch then goto 1;
    end;
    for i:=0 to anz-1 do sg4.cells[2,i+1]:=_strkomma(funktionswert(k,xr[i]),1,4);
    lclear;
    lwritelnf(' ');
    lwritelnf(k);
    lwriteln('#m');
    lwriteln('...');
    for i:=1 to anz do begin
      lwriteln(_str(xr[i-1],1,5));
      lwriteln(_str(yr[i-1],1,5));
    end;
    lwriteln('...');
    pb4paint(sender);
1:  sabbruch:=true;
    button1.caption:='Berechnung';
  end;
end;

procedure TForm1.S1X(Sender: TObject);
var i:integer;
begin
  for i:=1 to 200 do begin
    sg4.cells[0,i]:='';
    sg4.cells[1,i]:='';
    sg4.cells[2,i]:='';
  end;
end;

procedure TForm1.PB4Paint(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=pb4.width;
  bitmap.height:=pb4.height;
  xpb3paint(bitmap.canvas);
  pb4.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure TForm1.Listbox1Click(Sender: TObject);
var i,sel:integer;
    ks,k:string;
    code:integer;
    xr,yr:double;
begin
  sel:=Listbox1.itemindex;
  if sel>=0 then begin
    k:=Listbox1.items[sel];
    delete(k,1,pos('Y = ',k)+3);
    lclear;
    lwritelnf(' ');
    lwritelnf(k);
    lwriteln('#m');
    lwriteln('...');
    for i:=1 to 200 do begin
      ks:=sg4.Cells[0,i];
      if ks<>'' then begin
        val(komma(sg4.cells[0,i]),xr,code);
        val(komma(sg4.cells[1,i]),yr,code);
        lwriteln(_str(xr,1,5));
        sg4.cells[2,i]:=_strkomma(funktionswert(k,xr),1,4);
        lwriteln(_str(yr,1,5));
      end;
    end;
    lwriteln('...');
    pb4paint(sender);
  end;
end;

procedure TForm1.S11C(Sender: TObject);
const hstring : array[0..17] of string[4] =
      ('1.5','1.4','1.1','1.2','0.7','0','0.3','-0.2','-0.1','0.4','-0.5','1','-1','1.6','-1.5','1.2','2.8','0.1');
var i,j:integer;
begin
  for i:=1 to 200 do
    for j:=0 to 2 do sg4.cells[j,i]:='';
  for i:=1 to 9 do
    for j:=0 to 1 do sg4.cells[j,i]:=hstring[(i-1)*2+j];
  label2.caption:='9';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   ldatei:=tstringlist.create;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ldatei.Free;
end;

end.

