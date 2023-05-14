unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    lblUnsort: TLabel; memUnsort: TMemo;
    lblSort: TLabel; memSort: TMemo;
    btnCreate: TButton;
    btnSort: TButton;
    lblTime: TLabel;
    lblExchange: TLabel;
    lblCompare: TLabel;
    procedure CreateNumbers(Sender: TObject);
    procedure Sort(Sender: TObject);
  end;

const n = 1000;
var Form1 : TForm1;
        x : array [1..n] of integer;

implementation
{$R *.dfm}

procedure TForm1.CreateNumbers(Sender: TObject);
var i : integer;
    s : string;
begin
  s := '';
  for i:=1 to n do begin
                     x[i]:=random (1000);
                     s := s + Format ('%4d', [x[i]]) + ' ';
                     if i mod 10 = 0 then begin
                                            memUnsort.Lines.Add(s);
                                            s := '';
                                          end;
                   end;
  btnSort.Enabled := True;
end;

procedure TForm1.Sort(Sender: TObject);
var tausch,vergleich,h,i,j,k : integer;
                     f,t1,t2 : TLargeInteger;
                           s : string;
begin
  tausch:=0; vergleich := 0;
  QueryPerformanceFrequency (f);                         // Frequenz des Zählers
  QueryPerformanceCounter (t1);                                 // Zählerstand 1

  k:=1; repeat k := 3*k + 1 until k > n;
  repeat
    k:=(k-1) div 3;
    //vergleich := vergleich + (n-k);
    for i:=k+1 to n do begin
                         h:=x[i];
                         j:=i-k;
                         inc (vergleich);
                         while (j>0) and (h<x[j]) do
                           begin
                             inc (vergleich);
                             inc (tausch);
                             x[j+k]:=x[j];
                             j:=j-k
                           end;
                         inc (tausch);
                         x[j+k]:=h
                       end;
  until k=1;
  tausch := tausch div 2;       // da nur halbe Tauschoperationen gezählt wurden

  QueryPerformanceCounter (t2);                                 // Zählerstand 2
  lblTime.Caption := FormatFloat ('Sortierzeit: 0.00 ms', 1000*(t2-t1)/f);
  lblCompare.Caption := IntToStr (vergleich) + ' Vergleiche';
  lblExchange.Caption := IntToStr (tausch) + ' Tauschoperationen';
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
