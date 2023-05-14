unit umagie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
type
    matrix = array[1..20,1..20] of integer;
var
    a:matrix;
    i,j,n:integer;
    k:string;
procedure quadrat;
var n2:integer;
  procedure markieren;
  var i,j,k,m,sgn:integer;
  begin
    k:=n div 2;
    n2:=n*n;
    sgn:=1;
    m:=k;
    for i:=1 to k do begin
      for j:=1 to k do begin
        a[((m-j)div n)+1,((m-j)mod n) +1]:=sgn;
        a[((m+j-1)div n)+1,((m+j-1)mod n) +1]:=sgn;
        sgn:=-sgn;
      end;
      m:=m+n;
      sgn:=-sgn;
    end;
  end;
  procedure einsetzen;
  var i,h:integer;
  begin
    for i:=1 to n2 div 2 do begin
      h:=i;
      if a[(i-1) div n+1,(i-1) mod n +1]<0 then h:=n2+1-i;
      a[(h-1) div n+1,(h-1) mod n+1]:=i;
      a[(n2-h)div n+1,(n2-h)mod n+1]:=n2+1-i;
    end;
  end;
begin
  markieren;
  einsetzen;
end;
begin
  fillchar(a,sizeof(a),0);
  n:=4;
  if n mod 4 = 0 then quadrat;
  //in a steht magisches quadrat;
  for i:=1 to 4 do
    for j:=1 to 4 do begin
      k:=inttostr(a[i,j]);
      if length(k)<2 then k:=' '+k;
      stringgrid1.cells[i-1,j-1]:=k;
    end;
end;

end.
