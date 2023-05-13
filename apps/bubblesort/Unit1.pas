unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    lblUnsort: TLabel;
    memUnsort: TMemo;
    lblSort: TLabel;
    memSort: TMemo;
    btnCreate: TButton;
    btnSort: TButton;
    lblTime: TLabel;
    lblExchange: TLabel;
    lblCompare: TLabel;
    procedure CreateNumbers(Sender: TObject);
    procedure Sort(Sender: TObject);
  end;

const n = 1500;
var Form1 : TForm1;
        x : array [1..n] of integer;

implementation
{$R *.dfm}

procedure TForm1.CreateNumbers(Sender: TObject);
var i : integer;
    s : string;
begin
  randomize;
  memUnsort.Clear; memSort.Clear;
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
var tausch,vergleich,h,i,j : integer;
                   f,t1,t2 : TLargeInteger;
                         s : string;
begin
  tausch:=0; vergleich:=0;
  QueryPerformanceFrequency (f);
  QueryPerformanceCounter (t1);                          // Zählerstand 1

  for i:=2 to n do
    for j:=n downto i do begin
                           inc (vergleich);
                           if x[j-1] > x[j] then begin
                                                   inc (tausch);
                                                   h := x[j-1];
                                                   x[j-1] := x[j];
                                                   x[j] := h;
                                                 end;
                         end;
  QueryPerformanceCounter (t2);                          // Zählerstand 2
  lblTime.Caption := FormatFloat ('Sortierzeit: 0.0 ms', 1000*(t2-t1)/f);
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
