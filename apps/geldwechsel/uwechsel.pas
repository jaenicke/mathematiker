unit uwechsel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    ListBox1: TListBox;
    Label3: TLabel;
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
  TCoinrec = record
     val, nbr:integer;
  end;
  TCoins = array of TCoinRec;
var  i,count,amount:integer;
     coins:TCoins;
     coincounts:array of integer;
     savedcoins:array of Tcoins;
     s:string;
  procedure AccumTotsFrom(n,totsofar:integer);
  var  i,nexttot:integer;
       k:string;
  begin
    If n<=high(coins) then begin
      for i:= 0 to amount div coins[n].val do begin
        coins[n].nbr:=i;
        nexttot:=totsofar+ i*coins[n].val;
        if (nexttot>amount) then break;
        accumtotsfrom(n+1,nexttot);
      end;
    end
    else
      if totsofar=Amount then begin
        if count mod 50 = 0 then application.processmessages;
        inc(count);
        k:='';
        for i:= 0 to high(coins) do k:=k+inttostr(coins[i].nbr)+#9;
        listbox1.Items.add(k);
      end;
  end;
begin
  listbox1.Clear;
  listbox1.tabwidth:=30;
  i:=0;
  setlength(coins,101);
  s:=edit1.text;
  while pos(',',s)>0 do begin
    coins[i].val:=strtoint(copy(s,1,pos(',',s)-1));
    delete(s,1,pos(',',s));
    inc(i);
  end;
  coins[i].val:=strtoint(s);
  setlength(coins,i+1);

  for i:=low(coins) to high(coins) do coins[i].nbr:=0;
  amount:=strtoint(edit2.Text);
  setlength(coincounts,amount+1);
  setlength(SavedCoins,amount+1);
  for i:=0 to amount do coincounts[i]:=0;
  count:=0;
  s:='';
  for i:= 0 to high(coins) do s:=s+inttostr(coins[i].val)+#9;
  listbox1.Items.Add(s);
  accumtotsfrom(0,0);
  setlength(coincounts,0);
  setlength(SavedCoins,0);
  setlength(coins,0);
  label3.caption:=inttostr(count)+' Möglichkeiten';
end;

{var i,k,n : integer;
    s : string;
    d : array[1..100] of integer;
  function a(n,k:integer):integer;
  begin
    if n<0 then a:=0
    else begin
      if k=1 then a:=1
      else a:=a(n,k-1) + a(n-d[k],k);
    end;
  end;
begin
  n:=strtoint(edit2.Text);
  s:=edit1.text;
  i:=1;
  while pos(',',s)>0 do begin
    d[i]:=strtoint(copy(s,1,pos(',',s)-1));
    delete(s,1,pos(',',s));
    inc(i);
  end;
  d[i]:=strtoint(s);
  k:=i;
  label3.caption:=inttostr(a(n,k))+' Möglichkeiten';
end; }

end.
