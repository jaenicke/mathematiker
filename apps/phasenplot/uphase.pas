unit uphase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, fktkomplex;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Edit0: TEdit;
    PaintBox1: TPaintBox;
    L64: TLabel;
    L95: TLabel;
    L94: TLabel;
    L96: TLabel;
    L93: TLabel;
    edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
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
var bitmap:tbitmap;
    kx,ky:tkomplexzahl;
    _x1,_x2,_y1,_y2:real;
    code:integer;
function ArcTan2(Y, X: Extended): Extended;
asm
        FLD     Y
        FLD     X
        FPATAN
        FWAIT
end;
//Zeichenprozedur
procedure jetztzeichnen;
var i,j,b,h,plotfarbe:integer;
    k1:string;
    maxwx,diffx,diffy:real;
    red,green,blue,maxf,maxw:integer;
begin
    //Funktionsterm
    k1:=edit0.text;
    termkorrektur(k1);

    b:=bitmap.width;
    h:=bitmap.height;
    diffx:=(_x2-_x1)/b;
    diffy:=(_y2-_y1)/h;
    //Zeichnen
    for i:=0 to b do
    begin
      kx.re:=_x1+i*diffx;
      for j:=0 to h do
      begin
        kx.im:=_y1+j*diffy;
        //komplexer Funktionswert
        fehlerkomplex:=0;
        ky:=funktionswertkomplex(k1,kx);

        //Phase ermitteln
        maxwx:=arctan2(ky.im,ky.re);
        if maxwx<0 then maxwx:=maxwx+2*pi;

        //Zeichenfarbe auswählen
        if fehlerkomplex<>0 then plotfarbe:=clblack
        else
        begin
              maxw := trunc(3/pi*maxwx);
              maxf := round(3*255/pi*(maxwx-maxw*pi/3));
              case maxw of
                0 : begin Red := 255; Green := 0; Blue := maxf end;
                1 : begin Red := 255-maxf; Green := 0; Blue := 255 end;
                2 : begin Red := 0; Green := maxf; Blue := 255 end;
                3 : begin Red := 0; Green := 255; Blue := 255-maxf end;
                4 : begin Red := maxf; Green := 255; Blue := 0 end;
               else begin Red := 255; Green := 255-maxf; Blue := 0 end;
              end;
            plotfarbe:=rgb(red,green,blue);
        end;
        bitmap.Canvas.pixels[i,h-j]:=plotfarbe;
      end;
      paintbox1.canvas.draw(0,0,bitmap);
      application.processmessages;
    end;
end;
function komma(s:string):string;
begin
    if s<>'' then
       while pos(',',s)<>0 do s[pos(',',s)]:='.';
    komma:=s;
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox1.width;
    bitmap.height:=paintbox1.height;
    //Intervallgröße holen
    val(komma(edit5.text),parameter_reell,code);
    if parameter_reell<0 then parameter_reell :=0;
    if parameter_reell>1 then parameter_reell :=1;
    val(komma(edit1.text),_x1,code);
    val(komma(edit2.text),_x2,code);
    val(komma(edit3.text),_y1,code);
    val(komma(edit4.text),_y2,code);
    if _x2<=_x1 then _x2:=_x1+1;
    if _y2<=_y1 then _y2:=_y1+1;
    //Zeichnen
    jetztzeichnen;
    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

end.
