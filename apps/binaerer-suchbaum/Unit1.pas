unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
uses Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    btnDelete: TButton;
    btnRandom: TButton;
    lblCount: TLabel;
    tbCount: TTrackBar;
    memTree: TMemo;
    panNum: TPanel;
    btnPath: TButton;
    btnSearch: TButton;
    edtNum: TEdit;
    btnRemove: TButton;
    btnTraverse: TButton;
    btnInsert: TButton;
    imgTree: TImage;
    btnLoad: TButton;
    procedure Init(Sender: TObject);
    procedure InsertNode(Sender: TObject);
    procedure ShowTree(Sender: TObject);
    procedure SearchNode(Sender: TObject);
    procedure TracePath(Sender: TObject);
    procedure RemoveNode(Sender: TObject);
    procedure DeleteTree(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  end;

  zeiger = ^knoten;
  knoten = record
             info : integer;
             li,re : zeiger;
           end;

var Form1 : TForm1;
     root : zeiger;                                 // Wurzel des binären Baums

implementation
{$R *.dfm}

// erzeugt einen Baum bzw. Teilbaum mit der Wurzel x
function construct (x: integer): zeiger;
var k : zeiger;
begin
  new (k);
  k^.li := nil; k^.info := x; k^.re := nil;
  construct := k
end;

// fügt x als Blatt an der Stelle ein, wo die Suche erfolglos abgebrochen wurde
function insert (p:zeiger; x:integer): boolean;
var q : zeiger;
begin
  q := p;
  while (p^.info <>x) and (q <> nil) do
    begin
      p := q;                                               // Vorgänger merken
      if x < p^.info then q := p^.li                 // q zeigt auf linken Sohn
                     else q := p^.re                // q zeigt auf rechten Sohn
    end;
  if x < p^.info then p^.li := construct (x)
                 else if x > p^.info then p^.re := construct (x);
  insert := (x <> p^.info)
end;

// gibt einen Zeiger auf den gefundenen Knoten oder NIL zurück
function search (p:zeiger; x: integer): zeiger;
begin
  while (p <> nil) and (x <> p^.info) do
    if x < p^.info then p := p^.li else p := p^.re;
  search := p
end;

// durchläuft den kompletten Suchbaum rekursiv
procedure traverse (p: zeiger; var s: string);
begin
  if p <> nil then begin
                     traverse (p^.li, s);
                     s := s + IntToStr (p^.info) + ' ';
                     traverse (p^.re, s)
                   end
end;

// durchläuft den kompletten Suchbaum rekursiv
procedure paint (x,y,b:integer; tree:zeiger);
begin
  if tree <> nil then with Form1.imgTree.Canvas do
    begin
      if tree^.li <> nil then begin
                                MoveTo (x, y);
                                LineTo (x - b div 2, y+16);
                                paint (x - b div 2, y+30, b div 2, tree^.li);
                              end;
      TextOut (x-6, y-13, IntToStr(tree^.info));
      if tree^.re <> nil then begin
                                MoveTo (x, y);
                                LineTo (x + b div 2, y+16);
                                paint (x + b div 2, y+30, b div 2, tree^.re);
                              end
  end
end;

procedure PaintTree;
begin
  with Form1.imgTree do begin
    Canvas.Rectangle (0, 0, Width, Height);
    paint (Width div 2 - 6, 20, Width div 2 - 6, root);
  end
end;

// löscht den kompletten Baum rekursiv
procedure delete (p: zeiger);
begin
  if p <> nil then begin
                     delete (p^.li);
                     delete (p^.re);
                     dispose (p)
                   end
end;

// liefert den kompletten Pfad von der Wurzel bis zum Knoten
function trace (p:zeiger; x: integer): string;
var s : string;
begin
  s := '';
  while (p <> nil) and (x <> p^.info) do
    begin
      s := s + IntToStr (p^.info) + '-';
      if x < p^.info then p := p^.li else p := p^.re
    end;
  if p <> nil then trace := s + IntToStr (p^.info)
              else trace := ''
end;

// entfernt den Knoten, auf den z zeigt, aus dem Baum mit der Wurzel r
procedure remove (var r:zeiger; z:zeiger);
var h,p,q : zeiger;
begin
  q := r;                                        // Suche beginnt an der Wurzel
  p := nil; // ist der zu löschende Knoten die Wurzel, gibt es keinen Vorgänger
  while z^.info <> q^.info do begin
                                p := q;                     // Vorgänger merken
                                if z^.info < q^.info then q := q^.li
                                                     else q := q^.re
                              end;
  if z^.re = nil
    then q := q^.li                       // FALL 1: rechts gibt es keinen Sohn
    else if z^.re^.li = nil              // FALL 2a: links gibt es keinen Enkel
           then begin
                  q := q^.re;                     // Knoten durch Sohn ersetzen
                  q^.li := z^.li                         // Rest links anhängen
                end
           else begin                     // FALL 2b: links gibt es einen Enkel
                  h := q^.re;             // suche Ersatzknoten im re. Teilbaum
                  while h^.li^.li <> nil do h := h^.li;   // suche Ersatzknoten
                  q := h^.li;                        // dieser Knoten ersetzt z
                  h^.li := q^.re; // re. Teilbaum des leftmost-Knotens umhängen
                  q^.li := z^.li;           // li. Teilbaum von z an q anhängen
                  q^.re := z^.re            // re. Teilbaum von z an q anhängen
                end;
  if p = nil then r := q
             else if z^.info < p^.info then p^.li := q
                                       else p^.re := q;
  dispose (z)
end;

procedure TForm1.Init(Sender: TObject);
var i,n,x : integer;
begin
  randomize;
  n := tbCount.Position;
  lblCount.Caption := IntToStr(n) + ' Zahlen';
  DeleteTree(Sender);
  root := construct (10+random(90));
  for i:=2 to n do
    repeat x := 10 + random(90) until insert (root,x);
  ShowTree (sender);
  btnLoad.Enabled := true
end;

procedure TForm1.InsertNode(Sender: TObject);
var x : integer;
    p : zeiger;
begin
  x := StrToInt(edtNum.Text);
  p := search (root,x);
  if p = nil then begin
                    if root = nil then root := construct (x)
                                  else insert (root,x);
                    ShowTree (sender)
                  end
             else memTree.Lines[1] := edtNum.Text + ' ist schon im Baum.';
  btnLoad.Enabled := true
end;

procedure TForm1.RemoveNode(Sender: TObject);
var x : integer;
    p : zeiger;
begin
  x := StrToInt(edtNum.Text);
  p := search (root,x);
  if p = nil then memTree.Lines[1] := edtNum.Text + ' ist nicht im Baum.'
             else begin
                    remove (root, p);
                    ShowTree (sender);
                    memTree.Lines[1] := ' '
                  end;
end;

procedure TForm1.DeleteTree(Sender: TObject);
begin
  delete (root);
  root := nil;
  ShowTree (sender);
  btnLoad.Enabled := false
end;

procedure TForm1.SearchNode(Sender: TObject);
var x : integer;
    p : zeiger;
begin
  x := StrToInt(edtNum.Text);
  p := search (root,x);
  if p = nil then memTree.Lines[1] := edtNum.Text + ' ist nicht im Baum.'
             else memTree.Lines[1] := edtNum.Text + ' wurde gefunden.'
end;

procedure TForm1.TracePath(Sender: TObject);
var x : integer;
    s : string;
begin
  x := StrToInt(edtNum.Text);
  s := trace (root,x);
  if s = '' then memTree.Lines[1] := edtNum.Text + ' ist nicht im Baum.'
            else memTree.Lines[1] := s
end;

procedure TForm1.ShowTree(Sender: TObject);
var s : string;
begin
  s := '';
  traverse (root, s);
  memTree.Lines[0] := s;
  PaintTree;
end;

procedure TForm1.btnLoadClick(Sender: TObject);
var i,l,x : integer;
        s : string;
begin
  s := memTree.Lines[0];
  l := length(s);
  if s[l] <> ' ' then s := s + ' ';
  i := pos (' ', s);
  x := StrToInt(Copy (s, 1, i-1));
  root := construct (x);
  System.Delete (s, 1, i);
  while s <> '' do begin
                     i := pos (' ', s);
                     x := StrToInt(Copy (s, 1, i-1));
                     insert (root,x);
                     System.Delete (s, 1, i);
                   end;
  PaintTree;
end;

end.
