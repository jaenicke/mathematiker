unit unullstellen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Button1: TButton;
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
    Liste: TListBox;
    procedure Button1Click(Sender: TObject);
  private
    nx,ny:array[1..10] of double;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function _strkomma(a:double;b,c:byte):string;
begin
  str(a:b:c,result);
  if c<>0 then begin
    while (length(result)>1) and (result[length(result)]='0') do delete(result,length(result),1);
    if (length(result)>1) and (result[length(result)]='.') then delete(result,length(result),1);
  end;
  if result='-0' then result:='0';
end;

function  vorzeichenzahlkomma(we:double;a,b:integer):string;
begin
  if we<0 then vorzeichenzahlkomma:=_strkomma(we,a,b)
          else vorzeichenzahlkomma:='+'+_strkomma(we,a,b);
  if _strkomma(we,a,b)='0' then vorzeichenzahlkomma:='+0';
end;

procedure TForm1.Button1Click(Sender: TObject);
const mm=10;
var a,b,c,e:array[0..mm] of double;
    eps,xneu,yneu,x0,y0,x1,y1,x2,y2:double;
    ab,n,m,nr,i:integer;
  procedure funktion(x1,y1:double;var x,y:double);
  var i:integer;
      xalt:double;
  begin
    x:=a[mm];
    y:=0;
    i:=mm-1;
    repeat
      xalt:=x;
      x:=x*x1-y*y1;
      y:=xalt*y1+x1*y;
      x:=x+a[i];
      dec(i);
    until i<0;
  end;
  procedure ableitung(x1,y1:double;var x,y:double);
  var i:integer;
      xalt:double;
  begin
    x:=b[mm-1];
    y:=0;
    i:=mm-2;
    repeat
      xalt:=x;
      x:=x*x1-y*y1;
      y:=xalt*y1+x1*y;
      x:=x+b[i];
      dec(i);
    until i<0;
  end;
  procedure auswertung;
  var i:integer;
  begin
    ab:=10;
    while (a[ab]=0) and (ab>0) do dec(ab);
    if ab>0 then begin
      if (a[ab]<>0) and (a[ab]<>1) then begin
        for i:=ab-1 downto 0 do a[i]:=a[i]/a[ab];
        a[ab]:=1;
      end;
      b[mm]:=0;
      for i:=mm-1 downto 0 do b[i]:=(i+1)*a[i+1];
      repeat
        x0:=1;
        y0:=1;
        i:=0;
        repeat
          funktion(x0,y0,x1,y1);
          ableitung(x0,y0,x2,y2);
          xneu:=x0-(x1*x2+y1*y2)/(x2*x2+y2*y2);
          yneu:=y0-(x2*y1-y2*x1)/(x2*x2+y2*y2);
          eps:=abs(x0-xneu)+abs(y0-yneu);
          x0:=xneu;
          y0:=yneu;
          inc(i);
        until (eps<0.0000001) or (i>100);
        if abs(y0)<0.00000001 then begin
          liste.items.add(_strkomma(x0,1,7));
          nx[nr]:=x0;
          ny[nr]:=0;
          inc(nr);
        end else begin
          liste.items.add(_strkomma(x0,1,7)+#9+vorzeichenzahlkomma(y0,1,7)+'·i');
          nx[nr]:=x0;
          ny[nr]:=y0;
          inc(nr);
          liste.items.add(_strkomma(x0,1,7)+#9+vorzeichenzahlkomma(-y0,1,7)+'·i');
          nx[nr]:=x0;
          ny[nr]:=-y0;
          inc(nr);
        end;
        fillchar(e,sizeof(e),0);
        fillchar(c,sizeof(c),0);
        if abs(y0)<0.0000000001 then begin
          c[1]:=1;
          c[0]:=-x0;
        end else begin
          c[2]:=1;
          c[1]:=-2*x0;
          c[0]:=x0*x0+y0*y0;
        end;
        n:=mm;
        while (a[n]=0) and (n>0) do dec(n);
        m:=mm;
        while (c[m]=0) and (m>0) do dec(m);
        if (m>0) then begin
          while (n>=m) do begin
            e[n-m]:=a[n]/c[m];
            a[n]:=0;
            for i:=1 to m do a[n-i]:=a[n-i]-e[n-m]*c[m-i];
            dec(n);
          end;
        end;
        for i:=0 to mm do a[i]:=e[i];
        b[mm]:=0;
        for i:=mm-1 downto 0 do b[i]:=(i+1)*a[i+1];
      until a[0]=1;
    end
  end;
begin
  liste.clear;
  nr:=1;
  for i:=0 to 10 do
    a[i]:=strtofloat(TEdit(FindComponent('e'+IntToStr(15-i))).text);
  auswertung;
end;

end.
