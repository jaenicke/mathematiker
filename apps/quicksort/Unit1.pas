unit Unit1;
interface
uses Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    lblUnsort: TLabel; memUnsort: TMemo;
    lblSort: TLabel; memSort: TMemo;
    btnCreate: TButton;
    btnSort: TButton;
    lblTime: TLabel;
    edtSize: TEdit;
    lblSize: TLabel;
    procedure GetSize(Sender: TObject);
    procedure CreateNumbers(Sender: TObject);
    procedure Sort(Sender: TObject);
  end;

var Form1 : TForm1;
        x : array [1..10001] of integer;
        n : integer;

implementation
{$R *.dfm}

procedure tausche (var a,b: integer);
var h: integer;
begin h:=a; a:=b; b:=h end;

procedure TForm1.GetSize(Sender: TObject);
begin
  n := StrToInt(edtSize.Text);
end;

procedure TForm1.CreateNumbers(Sender: TObject);
var i : integer;
    s : string;
begin
  n := StrToInt(edtSize.Text);
  randomize;
  memUnsort.Clear;
  s := '';
  for i:=1 to n do begin
                     x[i] := random (1000);
                     s := s + Format ('%4d', [x[i]]) + ' ';
                     if i mod 10 = 0 then begin
                                            memUnsort.Lines.Add(s);
                                            s := '';
                                          end;
                   end;
  x[n+1] := maxint;                                 // künstliches Stoppelement
  btnSort.Enabled := True;
end;

procedure umordnen (li,re: integer; var j: integer);
var ab,auf,t : integer;
begin
  t := x[li]; auf:=li; ab:=re+1;
  repeat
    repeat dec (ab) until x[ab] <= t;
    repeat inc (auf) until x[auf] >= t;
    if auf < ab then tausche (x[auf], x[ab]);
  until auf >= ab;
  tausche (x[ab], x[li]);
  j := ab;
end;

procedure quicksort (li,re: integer);
var j : integer;
begin
  if li < re then begin
                    umordnen (li, re, j);      // liefert das Teilfeld T2
                    quicksort (li, j-1);       // liefert das Teilfeld T1
                    quicksort (j+1, re);       // liefert das Teilfeld T3
                  end;
end;

procedure TForm1.Sort(Sender: TObject);
var f,t1,t2 : TLargeInteger;
          i : integer;
          s : string;
begin
  QueryPerformanceFrequency (f);                         // Frequenz des Zählers
  QueryPerformanceCounter (t1);                                 // Zählerstand 1
  quicksort (1,n);
  QueryPerformanceCounter (t2);                                 // Zählerstand 2
  lblTime.Caption := FormatFloat ('Sortierzeit: 0.00 ms', 1000*(t2-t1)/f);

  memSort.Clear;
  s := '';
  for i:=1 to n do begin
                     s := s + Format ('%4d', [x[i]]) + ' ';
                     if i mod 10 = 0 then begin
                                            memSort.Lines.Add(s);
                                            s := '';
                                          end;
                   end;
end;

end.
