unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
uses Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls;

type
  TForm1 = class(TForm)
    edtA: TEdit;
    edtB: TEdit;
    btnTry: TButton; edtTry: TEdit; lblTry: TLabel;
    btnPrime: TButton; edtPrime: TEdit; lblPrime: TLabel;
    btnEuklid: TButton; edtEuklid: TEdit; lblEuklid: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Label4: TLabel;
    Button2: TButton;
    Edit2: TEdit;
    Label5: TLabel;
    Button3: TButton;
    Edit3: TEdit;
    Label6: TLabel;
    Button4: TButton;
    Edit4: TEdit;
    procedure gcd_Try(Sender: TObject);
    procedure gcd_Prime(Sender: TObject);
    procedure gcd_Euklid(Sender: TObject);
    procedure gcd_mod(Sender: TObject);
    procedure gcd_assembler(Sender: TObject);
    procedure gcd_rekursiv(Sender: TObject);
    procedure gcd_stein(Sender: TObject);
  end;

const n = 10000;
var Form1 : TForm1;
      p,q : array[1..n] of byte;

implementation
{$R *.dfm}

procedure TForm1.gcd_Try(Sender: TObject);           // greatest common divisor
var ao,bo,a,b,h,i,j : integer;
            f,t1,t2 : int64;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a := ao; b := bo;
    if b > a then begin h:=b; b:=a; a:=h end;
    h := 1;
    for i:=2 to b do
      if (a mod i = 0) and (b mod i = 0) then h := i;
  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edtTry.Text := IntToStr(h);
  lblTry.Caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

procedure TForm1.gcd_Prime(Sender: TObject);
var ao,bo,a,b,h,i,j,k,max : integer;
                  f,t1,t2 : int64;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a := ao; b := bo;
    for i:=1 to n do begin p[i]:=0; q[i]:=0 end;
    i:=1;
    repeat
      inc(i);
      while a mod i = 0 do begin inc (p[i]); a := a div i end;
    until a = 1;
    max := i;
    i:=1;
    repeat
      inc(i);
      while b mod i = 0 do begin inc (q[i]); b := b div i end;
    until b = 1;
    if i > max then max := i;
    h := 1;
    for i:=2 to max do
      if p[i]*q[i]>0 then
         if p[i]<q[i] then for k:=1 to p[i] do h := h*i
                      else for k:=1 to q[i] do h := h*i;
  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edtPrime.Text := IntToStr(h);
  lblPrime.Caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

procedure TForm1.gcd_Euklid(Sender: TObject);
var ao,bo,a,b,j : integer;
        f,t1,t2 : int64;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a := ao; b := bo;
    while a <> b do
      if a > b then a := a - b
               else b := b - a;
  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edtEuklid.Text := IntToStr(a);
  lblEuklid.Caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

procedure TForm1.gcd_mod(Sender: TObject);
var ao,bo,a,b,j,r : integer;
        f,t1,t2 : int64;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a:=ao;
    b:=bo;

    repeat
      r:=a mod b;
      a:=b;
      b:=r;
    until r=0;

  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edit1.Text := IntToStr(a);
  label3.caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

function __gcd32: longint; assembler;
  {-Calculate GCD of unsigned (A,B) in (eax,edx)}
asm
        push  ebx
        {done if A=B, otherwise if A<B then swap A and B}
        cmp   eax,edx
        jz    @@x
        jae   @@1
        xchg  eax,edx

{here eax >= edx. Calculate odd parts a,b with A=a*2^e(a), B=b*2^e(b)}
@@1:    bsf   ecx, edx         {if B=0 return A}
        jz    @@x

        bsf   ebx, eax         {ebx=e(a), A cannot be zero}
        shr   edx, cl          {edx=b}
        xchg  ebx, ecx
        shr   eax, cl          {eax=a}

        cmp   ebx,ecx          {ebx = e = min(e(a),e(b)}
        jb    @@2
        mov   ebx,ecx

@@2:    cmp   eax,edx          {compare a and b}
        jz    @@4              {done if equal}

{in the main loop both a and b are always odd}
{therefore for |a-b| is even and non-zero}
        push  esi
@@3:    mov   esi, eax         {eax=a, edx=b}
        {calculate max(a,b) and min(a,b) without branches}
        {see H.S.Warren, Hacker's Delight, Revision 1/4/07}
        {http://www.hackersdelight.org/revisions.pdf}
        sub   esi, edx         {esi=a-b}
        sbb   ecx, ecx         {if a>=b then ecx=0 else ecx=-1}
        and   esi, ecx         {if a>=b then esi=0 else esi=a-b}
        add   edx, esi         {if a>=b then edx=b else edx=a, i.e. edx=min(a,b)}
        sub   eax, esi         {if a>=b then eax=a else eax=a-(a-b)=b=max(a,b)}
        sub   eax, edx         {a'=max(a,b)-min(a,b), b'=min(a,b)}
        bsf   ecx, eax         {a'=|a-b| is even, divide out powers of 2}
        shr   eax, cl
        cmp   eax, edx         {compare new a and new b}
        jnz   @@3              {and repeat loop if not equal}

        pop   esi

@@4:    mov   ecx, ebx         {shift by initial common exponent e}
        shl   eax, cl
@@x:    pop   ebx

end;

{---------------------------------------------------------------------------}
function gcd32(A, B: longint): longint; assembler;
  {-Calculate GCD of two longints}
asm
  {$ifdef LoadArgs}
       mov   eax,[A]
       mov   edx,[B]
  {$endif}
       and   eax,eax
       jns   @@1
       neg   eax
@@1:   and   edx,edx
       jns   @@2
       neg   edx
@@2:   call  __gcd32
end;

procedure TForm1.gcd_assembler(Sender: TObject);
var ao,bo,a,j : integer;
        f,t1,t2 : int64;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a:=gcd32(ao,bo);
  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edit2.Text := IntToStr(a);
  label4.Caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

procedure TForm1.gcd_rekursiv(Sender: TObject);
var ao,bo,a,j : integer;
      f,t1,t2 : int64;
 function gcd(x,y:integer):integer;
 begin
   if x<>y then begin
     if x>y then gcd:=gcd(x-y,y)
            else gcd:=gcd(x,y-x);
   end else result:=x;
 end;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a:=gcd(ao,bo);
  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edit3.Text := IntToStr(a);
  label5.Caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

procedure TForm1.gcd_stein(Sender: TObject);
var ao,bo,a,b,j,g : integer;
        f,t1,t2 : int64;
begin
  ao := StrToInt(edtA.Text);
  bo := StrToInt(edtB.Text);
  Screen.Cursor := crHourglass;
  QueryPerformanceFrequency (f);                    // Taktfrequenz des Zählers
  QueryPerformanceCounter (t1);                                // Zählerstand 1
  for j:=1 to 10000 do
  begin
    a:=ao;
    b:=bo;
    g:=1;
    while (not odd(a)) and (not odd(b)) do begin
      g:=g*2;
      a:=a div 2;
      b:=b div 2;
    end;
    while (a<>1) and (b<>1) and (a<>0) and (b<>0) do begin
      if not odd(a) then a:=a div 2;
      if not odd(b) then b:=b div 2;
      if a>=b then a:=a-b;
      if b>=a then b:=b-a;
    end;
    if (a=1) or (b=1) then a:=g;
    if (a=0) then a:=g*b;
    if (b=0) then a:=g*a;
  end;
  QueryPerformanceCounter (t2);                                // Zählerstand 2
  edit4.Text := IntToStr(a);
  label6.caption := FormatFloat ('0.000 ms', 1000*(t2-t1)/f);
  Screen.Cursor := crDefault;
end;

end.
