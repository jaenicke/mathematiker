unit uegypt;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    abbruch:boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function IstPrime(N: Cardinal): Boolean;
const
  MaxPrime = 137; 
  MaxTrial = MaxPrime * MaxPrime; // maximal trial div bounds 
  MinPrime = 137;                 // trial div bounds if N >= MaxTrial, must be <= MaxPrime
  Primes: array[0..31] of Byte =
   (   3,   5,   7,  11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,  53,  59,
      61,  67,  71,  73,  79,  83,  89,  97, 101, 103, 107, 109, 113, 127, 131, 137); 
 
  InvPrimes: array[0..31] of Cardinal =  // InvPrimes[i] = Primes[i]^-1 mod 2^32 
   ($AAAAAAAB,$CCCCCCCD,$B6DB6DB7,$BA2E8BA3,$C4EC4EC5,$F0F0F0F1,$286BCA1B,$E9BD37A7, 
    $4F72C235,$BDEF7BDF,$914C1BAD,$C18F9C19,$2FA0BE83,$677D46CF,$8C13521D,$A08AD8F3,
    $C10C9715,$07A44C6B,$E327A977,$C7E3F1F9,$613716AF,$2B2E43DB,$FA3F47E9,$5F02A3A1,
    $7C32B16D,$D3431B57,$8D28AC43,$DA6C0965,$0FDBC091,$EFDFBF7F,$C9484E2B,$077975B9); 
// Montgomery Version of IsPrimeHR_IA32_1()
asm
       TEST   AL,1
       JZ     @@0                          // even ?? 
       CMP    EAX,7 
       JA     @@1                          // > 7 ?? 
       DEC    EAX 
       SETNZ  AL 
       RET 

@@0:   CMP    EAX,2                        // even numbers 
       SETZ   AL
       RET 
 
@@1:   PUSH   EBP                          // do trial divsion to small primes 
       PUSH   EBX 
       PUSH   ESI 
       PUSH   EDI
 
       MOV    EBX,EAX 
       CMP    EAX,MaxTrial 
       MOV    EBP,MinPrime 
       JAE    @@2 
 
       PUSH   EAX
       FILD   DWord Ptr [ESP] 
       FSQRT 
       FISTP  DWord Ptr [ESP] 
       POP    EBP                          // EBP = Sqrt(N)
 
@@2:   MOV    EDI,Offset Primes
       MOV    ESI,Offset InvPrimes
       XOR    ECX,ECX 
@@3:   MOVZX  EDX,Byte Ptr [EDI + ECX]     // take care, InvPrimes[] MUST 
                                           // be after Primes[] declared 
       MOV    EAX,EBX 
       CMP    EDX,EBP
       JA     @@5 
       IMUL   EAX,[ESI + ECX * 4] 
       INC    ECX 
       MUL    EDX 
       JC     @@3 
       TEST   EDX,EDX 
@@4:   POP    EDI 
       POP    ESI 
       POP    EBX 
       POP    EBP
       SETNZ  AL 
       RET 

@@5:   CMP    EBX,MaxTrial                 // N <= MaxPrime^2 ?? 
       MOV    EAX,EBX 
       JBE    @@4 

       IMUL   EAX,EBX                      // compute domain param U = -N^-1 mod 2^32 
       SUB    EAX,2                        // Lookuptable can reduce from 72 donwto 32 cycles
       IMUL   EAX,EBX 
       MOV    EDX,EAX 
       IMUL   EAX,EBX 
       ADD    EAX,2 
       IMUL   EAX,EDX 
       MOV    EDX,EAX 
       IMUL   EAX,EBX 
       ADD    EAX,2 
       IMUL   EAX,EDX 
       MOV    EBP,EAX 
       IMUL   EBP,EBX 
       ADD    EBP,2 
       IMUL   EBP,EAX                      // U = -N^-1 mod^2^32 in EBP
 
       MOV    EDI,EBX 
       MOV    EAX,EBX 
       DEC    EDI                          // N -1 
       NEG    EAX 
       BSF    ECX,EDI
       MUL    EAX
       PUSH   ECX                          // bits remain         [ESP + 20] 
       MOV    ESI,EAX 
       BSR    ECX,EDI 
       MOV    EAX,EDX 
       XOR    EDX,EDX 
       NEG    ECX 
       DIV    EBX                          // div, can't be removed 
       MOV    EAX,ESI 
       ADD    ECX,32 
       DIV    EBX                          // div 
       SHL    EDI,CL 
       MOV    EAX,EDX
       IMUL   EAX,EBP 
       MOV    ESI,EDX                      // C = -N^2 mod N, to fast convert into 
       MUL    EBX                          // montgomery domain
       PUSH   ESI                          // C                    [ESP + 16] 
       ADD    EAX,ESI 
       ADC    EDX,0
 
       PUSH   EDX                          // +1 in montgomery     [ESP + 12] 
       PUSH   EDI                          // bit mask exponent    [ESP +  8] 
       NEG    EDX
       ADD    EDX,EBX 
 
       CMP    EBX,$08A8D7F                 // N < $08A8D7F, do SPP to bases 31,73 
       PUSH   EDX                          // -1 in montgomery     [ESP +  4] 
       JAE    @@6 
       MOV    EAX,31 
       CALL   @@9 
       MOV    EAX,73 
       PUSH   Offset @@7
       JMP    @@9 
 
@@6:   MOV    EAX,2                        // do SPP to bases 2,7,61 
       CALL   @@9 
       MOV    EAX,7 
       CALL   @@9
       MOV    EAX,61 
       CALL   @@9 
 
@@7:   INC    EAX 
@@8:   LEA    ESP,[ESP + 4 * 5]            // don't change flags !! 
       JMP    @@4 

@@9:   MUL    DWord Ptr [ESP + 16]         // convert base in montgomery 
       MOV    EDI,EAX                      // Base' = Base * C mod N 
       IMUL   EAX,EBP                      // montgomery REDC 
       MOV    ESI,EDX 
       MUL    EBX 
       ADD    EAX,EDI
       ADC    EDX,ESI 
       MOV    ECX,[ESP + 8]                // bit mask of exponent N -1 
       MOV    EAX,EDX 
       PUSH   EDX 
 
@@A:   MUL    EAX                          // X = X^2 mod N
       MOV    EDI,EAX 
       IMUL   EAX,EBP 
       MOV    ESI,EDX
       MUL    EBX 
       ADD    EAX,EDI 
       ADC    EDX,ESI 
       JNC    @@B 
       SUB    EDX,EBX 
@@B:   ADD    ECX,ECX 
       MOV    EAX,EDX
       JNC    @@D 
       MUL    DWord Ptr [ESP]              // X = X * Base mod N 
       MOV    EDI,EAX
       IMUL   EAX,EBP 
       MOV    ESI,EDX 
       MUL    EBX 
       ADD    EAX,EDI 
       ADC    EDX,ESI 
       JNC    @@C
       SUB    EDX,EBX 
@@C:   TEST   ECX,ECX 
       MOV    EAX,EDX 
@@D:   JNZ    @@A 
       CMP    EAX,EBX 
       JB     @@E
       SUB    EAX,EBX 
@@E:   CMP    EAX,[ESP + 16]               // == +1 ?? 
       MOV    ECX,[ESP + 24]               // bits remain 
       JE     @@J 
@@F:   CMP    EAX,[ESP + 8]                // == -1 ?? 
       JE     @@J 
       DEC    ECX
       JNG    @@I 
       MUL    EAX 
       MOV    EDI,EAX 
       IMUL   EAX,EBP 
       MOV    ESI,EDX 
       MUL    EBX
       ADD    EAX,EDI
       ADC    EDX,ESI
       JC     @@G
       CMP    EDX,EBX
       JB     @@H
@@G:   SUB    EDX,EBX
@@H:   CMP    EDX,[ESP + 16]               // <> +1 ??
       MOV    EAX,EDX
       JNE    @@F
@@I:   ADD    ESP,8
       XOR    EAX,EAX
       JMP    @@8
@@J:   POP    EDX
end;

function __GCD32: longint; assembler;
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

function GCD32(A, B: longint): longint; assembler;
asm
       and   eax,eax
       jns   @@1
       neg   eax
@@1:   and   edx,edx
       jns   @@2
       neg   edx
@@2:   call  __GCD32
end;

procedure TForm1.Button1Click(Sender: TObject);
var p : array of integer;
    n,nn,zz,w,i,j,k : integer;
    first,verschieden,falsch : boolean;
    zzz:int64;
    a,b,gg:integer;
    kk,kp:string;
    Time1, Time2, Freq: Int64;

//Nächste Partition
procedure nextpart(var first:boolean);
var l : integer;
begin
    if not first then
    begin
      l:=k-i;
      k:=i;
      p[i]:=p[i]-1;
      while p[k]<=l do
      begin
        l:=l-p[k];
        k:=k+1;
        p[k]:=p[k-1]
      end;
      k:=k+1;
      p[k]:=l+1;
      if p[i]<>1 then i:=k;
      if p[i]=1 then i:=i-1;
      if i=0 then first:=true;
    end
    else
    begin
      first:=false;
      i:=0;
      repeat
        i:=I+1;
      until (i=k) or (p[i]=1);
      if p[i]=1 then
      begin
        i:=i-1;
        falsch:=true;
        first:=true;
      end;
      if i=0 then first:=true;
    end;
end;
//Hauptroutine
begin
    if abbruch=false then begin
      abbruch:=true;
      exit;
    end;
    button1.caption:='Abbruch';
    setlength(p,2010);
    abbruch:=false;
    listbox1.clear;

    //Eingabe und Test
    n:=strtoint(edit1.text);
    w:=trunc(sqrt(n));
    if n<2 then n:=2;
    if n>2000 then n:=2000;
    edit1.text:=inttostr(n);
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Time1);

    zz:=0;
    zzz:=0;
    nn:=n-1;

    repeat
      while istprime(nn) and (nn>2) do dec(nn);
      p[1]:=n-nn;
      for J:=2 to n do p[j]:=0;
      k:=1;
      first:=true;

      repeat
        falsch:=false;
        //nächste Partition
        nextpart(first);
        inc(zzz);

        //Partition prüfen
        if (not falsch) and (p[1]<=nn) then
        begin

          kk:=' ';
          a:=nn-1;
          b:=nn;
          j:=1;

          //Summe der Reziproken bilden und von 1 abziehen
          repeat
            a:=a*p[j]-b;
            b:=b*p[j];
            if j mod 6 = 0 then
            begin
              gg:=gcd32(a,b);
              a:=a div gg;
              b:=b div gg;
            end;
            inc(j);
          until (j>k) or (a<0);

          if (a=0) then
          begin
            //Test auf streng ägyptisch
            verschieden:=(nn<>p[1]);
            for j:=1 to k-1 do
              if p[j]=p[j+1] then verschieden:=false;

            if verschieden or (not checkbox1.checked) then
            begin
              //Partitionsstring erzeugen
              j:=1;
              repeat
                str(p[j],kp);
                kk:=kk+kp+', ';
                inc(j);
              until (j>k);

              if verschieden then
                listbox1.items.add(' '+inttostr(nn)+','+kk+' (streng)')
              else
                listbox1.items.add(' '+inttostr(nn)+','+Kk);
            end;    
            inc(zz)
          end;

        end;

        //Abbruchtest
        if zzz mod 1000000 = 0 then
        begin
          application.processmessages;
          label2.caption:=inttostr(nn)+':'+inttostr(zzz div 1000000);
          QueryPerformanceCounter(Time2);
          label3.caption:=floattostrf((Time2-Time1)/freq,ffgeneral,4,3)+' s';
        end;

      until first or abbruch or (zz>128000); //maximal 128000 Einträge
      dec(nn);
    until (nn<w) or abbruch;

    label2.caption:='-';
    QueryPerformanceCounter(Time2);
    label3.caption:=floattostrf((Time2-Time1)/freq,ffgeneral,4,3)+' s';

    kk:='Zerlegungen als ägyptische Zahl';
    if zz<=128000 then kk:=kk+' = '+inttostr(zz)
                  else kk:=kk+' > 128000';
    listbox1.items.insert(0,Kk);
    listbox1.items.insert(1,floattostrf(zzz/1e6,ffgeneral,4,3)+' untersuchte Mill. Partitionen');
    listbox1.items.insert(2,' ');

    setlength(p,0);
    button1.caption:='Berechnung';
    abbruch:=true;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    abbruch:=true;
end;

end.
