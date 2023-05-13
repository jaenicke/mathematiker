unit ufaktor;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fgint, ubrentrho;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  abbruch:boolean;
  t1x,t2x,frequenz : TLargeInteger;

implementation

{$R *.DFM}


function IstPrime(N: Cardinal): Boolean;
//Primzahltest nach Hagen Reddmann
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

procedure TForm1.Button1Click(Sender: TObject);
label 1;
var k:string;
    i,probeprim,d:integer;
    proberest:longword;
    pa,pb,pc,x,y,konstante,sum,a,zz:tfgint;
    prim,kontrolle:boolean;
begin
    if abbruch=false then begin abbruch:=true; exit end;
    button1.caption:='Abbruch';
    label3.caption:='';
    abbruch:=false;
    memo1.clear;
    application.processmessages;
    k:=edit1.text;
    i:=1;
    repeat
      if (length(k)>=i) and (not (k[i] in ['0'..'9'])) then delete(k,i,1)
                                                       else inc(i);
    until i>length(k);
    if (k='0') then k:='1';
    memo1.lines.add('Zahl = '+k);

    QueryPerformanceFrequency (frequenz);      // Frequenz des Zählers
    QueryPerformanceCounter (t1x);       // Zählerstand 1

    //Probedivisionen
    probeprim:=2;
    Base10StringToFGInt(k,pa);
    FGIntAbs(pa);
    FGIntModByInt(pa,probeprim,proberest);
    while proberest=0 do
    begin
      FGIntDivByIntBis(pa,probeprim,proberest);
      memo1.lines.add('Teiler = 2');
      FGIntToBase10String(pa,k);
      FGIntModByInt(pa,probeprim,proberest);
    end;

    probeprim:=3;
    Base10StringToFGInt(k,pa);
    repeat
      FGIntModByInt(pa,probeprim,proberest);
      if proberest=0 then
      begin
        while proberest=0 do
        begin
          FGIntDivByIntBis(pa,probeprim,proberest);
          memo1.lines.add('Teiler = '+inttostr(probeprim));
          FGIntToBase10String(pa,k);
          FGIntModByInt(pa,probeprim,proberest);
        end
      end
      else
      begin
        inc(probeprim,2);
        while not istprime(probeprim) do inc(probeprim)
      end;
    until probeprim>10000;
    QueryPerformanceCounter (t2x);       // Zählerstand 2
    label4.caption:=FormatFloat('0.0 ms',1000*(t2x-t1x)/frequenz);

//    memo1.lines.add('');
//    memo1.lines.add('Restzahl = '+k);

    Base10StringToFGInt(k,pa);
    Base10StringToFGInt('2',pb);
    Base10StringToFGInt('2',pc);
    Base10StringToFGInt('1',konstante);
    Base10StringToFGInt('1',sum);

  repeat
    //Test auf = 1
    kontrolle:=(FGIntCompareAbs(pa,konstante)=eq);
    if kontrolle=false then begin

    //Primzahltest
    FGIntRabinMiller(pa,1,prim);

    FGIntToBase10String(pa,k);
    if prim then memo1.lines.add('Teiler = '+k)
    else
    begin

      Base10StringToFGInt(k, A);
      Base10StringToFGInt('1', Zz);
      //Brent-Rho-Verfahren
      k:= BrentRho(A, d, Zz);

      if not abbruch then begin
        Base10StringToFGInt('1', pa);
      end else begin
        memo1.lines.add('Abbruch');
        FGIntToBase10String(pa,k);
        memo1.lines.add('Restzahl = '+k);
      end;
    end;
   end;
   until kontrolle or prim or abbruch;

1:  if not abbruch then
      memo1.lines.add('Zahl faktorisiert');
    QueryPerformanceCounter (t2x);       // Zählerstand 2
    form1.label4.caption:=FormatFloat('0.0 ms',1000*(t2x-t1x)/frequenz);
    FGIntDestroy(pa);
    FGIntDestroy(pb);
    FGIntDestroy(pc);
    FGIntDestroy(x);
    FGIntDestroy(y);
    FGIntDestroy(konstante);
    FGIntDestroy(sum);
    FGIntDestroy(a);
    FGIntDestroy(zz);
    button1.caption:='Berechnung';
    abbruch:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    abbruch:=true;
end;

end.
