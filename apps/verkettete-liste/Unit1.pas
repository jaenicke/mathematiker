unit Unit1;
interface
uses Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    memWords: TMemo;
    btnSave: TButton;
    btnLoad: TButton;
    rgWord: TRadioGroup;
    btnWord: TButton;
    edtWord: TEdit;
    GroupBox1: TGroupBox;
    lblHeap: TLabel;
    cbDispose: TCheckBox;
    procedure Init(Sender: TObject);
    procedure ListWords(Sender: TObject);
    procedure LoadWords(Sender: TObject);
    procedure SaveWords(Sender: TObject);
    procedure ModifyWords(Sender: TObject);
  end;
  zeiger = ^knoten;
  knoten = record
             info : string;
             next : zeiger
           end;

var Form1 : TForm1;
        k : zeiger;

implementation
{$R *.dfm}

procedure TForm1.Init(Sender: TObject);
var p,q : zeiger;
      f : TextFile;
      w : string;
begin
  AssignFile (f, 'anfang.txt');
  Reset (f);
  ReadLn (f, w);
  new (p);
  p^.info := w;
  p^.next := nil;
  k := p;
  while not eof(f) do begin
                        ReadLn (f, w);
                        new (q);
                        q^.info := w;
                        q^.next := nil;
                        p^.next := q;
                        p := q;
                      end;
  CloseFile (f);
  ListWords (sender);
end;

procedure TForm1.ListWords(Sender: TObject);
var p : zeiger;
begin
  memWords.Clear;
  p := k;
  while p <> nil do begin
                      memWords.Lines.Add(p^.info);
                      p := p^.next;
                    end;
  lblHeap.Caption := 'belegter Speicher: ' + IntToStr (AllocMemSize);
end;

procedure TForm1.LoadWords(Sender: TObject);
var p,q : zeiger;
      f : TextFile;
      w : string;
begin
  AssignFile (f, 'worte.txt');
  Reset (f);
  ReadLn (f, w);
  new (k);
  k^.info := w;
  k^.next := nil;
  p := k;
  while not eof(f) do begin
                        ReadLn (f, w);
                        new (q);
                        q^.info := w;
                        q^.next := nil;
                        p^.next := q;
                        p := q;
                      end;
  CloseFile (f);
  Listwords(sender);
end;

procedure TForm1.SaveWords(Sender: TObject);
var f : TextFile;
    p : zeiger;
begin
  AssignFile (f, 'worte.txt');
  Rewrite (f);
  WriteLn (f, k^.info);
  p := k;
  while p^.next <> nil do begin
                            p := p^.next;
                            WriteLn (f, p^.info);
                          end;
  CloseFile (f);
end;

function Search (s: string; k: zeiger): zeiger;
var q : zeiger;
begin
  q := k;
  while (q <> nil) and (q^.info <> s) do q := q^.next;
  Search := q
end;

procedure Insert (s: string; var k: zeiger);
var p,q,z : zeiger;
begin
  new(z); z^.info := s; z^.next := nil;
  p := k; q := k;
  while (q <> nil) and (q^.info < s) do begin p := q; q := q^.next end;
  if q = nil then if k = nil then k := z
                             else p^.next := z
             else if q = k then begin k := z; z^.next := q end
                           else begin p^.next := z; z^.next := q end;
end;

procedure Delete (s: string; var k: zeiger);
var p,q : zeiger;
begin
  p := k; q := k;
  while (q <> nil) and (q^.info < s) do begin p := q; q := q^.next end;
  if q = nil then ShowMessage (s + ' ist nicht in der Liste.')                     // well
             else if q^.info = s then begin
                                        if q = k then k := k^.next
                                                 else p^.next := q^.next;
                                        dispose (q);
                                      end
                                 else ShowMessage (s + ' is not in list.')   // all, mouse
end;

procedure TForm1.ModifyWords(Sender: TObject);
begin
  case rgWord.ItemIndex of
    0 : begin Insert (edtWord.Text, k); ListWords (sender) end;
    1 : begin Delete (edtWord.Text, k); ListWords (sender) end;
    2 : if Search (edtWord.Text, k) <> nil
          then ShowMessage (edtWord.Text + ' ist in der Liste.')
          else ShowMessage (edtWord.Text + ' ist nicht in der Liste.');
  end;
end;

end.
