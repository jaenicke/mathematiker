unit utsumme;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fgint, math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    Edit2: TEdit;
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

implementation

{$R *.DFM}

var abbruch:boolean;

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
var k,kt:string;
    grenze,nr,anzahl,w,i,probeprim,d:integer;
    proberest:longword;
    zahl,summe,pa,pb,pc,x,y,
    konstante,sum,pteiler,
    faktor,efaktor,rfaktor,null,
    ursprung:tfgint;
    prim,kontrolle:boolean;
    s: string;

procedure BrentRho(var A: TFGInt; var d: integer; var Z: TFGInt);
var
    okay: boolean;
    r, i, j, k, m: integer;
    xx, yy, tt, tmp, temp1, temp2, factorGGT, one: TFGInt;
label neu,1;
begin
    if(Length(A.Number) = 0)then 
      exit;
    Base10StringToFGInt('0', xx);
    Base10StringToFGInt('0', yy);
    Base10StringToFGInt('0', temp1);
    Base10StringToFGInt('1', temp2);
    Base10StringToFGInt('1', factorGGT);
    Base10StringToFGInt('1', one);
    Base10StringToFGInt('0', tt);
    Base10StringToFGInt('0', tmp);

    TRY
      FGIntRabinMiller(A, 3, okay);
      if(okay)then begin
        FGIntToBase10String(A, s);
        d:=0;
      end;
      WHILE not(okay)DO BEGIN
neu:
        d:=0;
        r:=1;
        m:=1024;

        while(FGIntCompareAbs(factorGGT, one) = eq)do begin
          FGIntCopy(yy, xx);        //xx = yy
          for i:=1 to r do begin
             FGIntSquare(yy, tt);
             FGIntAdd(tt, Z, tmp);
             FGIntMod(tmp, A, yy);  //yy = (yy²+1) mod A
          end;
          k:=0;
          j:= min(m, r);
          repeat
            for i:=j downto 1 do begin
               FGIntSquare(yy, tt);
               FGIntAdd(tt, Z, tmp);
               FGIntMod(tmp, A, yy);
               FGIntSub(xx, yy, temp1);    //temp1 = xx - yy
               FGIntAbs(temp1);
               FGIntMul(temp1, temp2, tt);
               FGIntMod(tt, A, temp2);     //temp2 = (temp1*temp2) mod A
            end;

            FGIntGCD(temp2, A, factorGGT);
            d:=d + 1;
            k:=k + m;

            if(d and 7 = 0)then begin
              Application.ProcessMessages;
              label2.caption:=inttostr(d);
              if abbruch then begin
                exit;
              end;
            end;
          until((k >= r) or (FGIntCompareAbs(factorGGT, one) <> eq));
          r:= r shl 1;  //r:= r + r;
        end;

        if(FGIntCompareAbs(factorGGT, one) <> eq)then begin
          FGIntToBase10String(factorGGT, s);
          FGIntDiv(A, factorGGT, A);

          if(FGIntCompareAbs(A, one) = eq)then begin
            FGIntCopy(factorGGT, A);
            FGIntAdd(Z, one, Z);      //anderes Z versuchen !!
            Base10StringToFGInt('1', temp2);
            Base10StringToFGInt('1', factorGGT);
            goto neu;
          end else
          begin
            kt:=kt+s+', ';
            Base10StringToFGInt(s,pteiler);
            goto 1;
          end;
        end;
      END;
1:   FGIntToBase10String(Z, s);
   FINALLY
      FGIntDestroy(xx);
      FGIntDestroy(yy);
      FGIntDestroy(temp1);
      FGIntDestroy(temp2);
      FGIntDestroy(factorGGT);
      FGIntDestroy(one);
      FGIntDestroy(tt);
      FGIntDestroy(tmp);
    END;
  end;    //BrentRhoTFGInt
begin
    if abbruch=false then begin abbruch:=true; exit end;
    button1.caption:='Abbruch';
    abbruch:=false;

    memo1.clear;
    application.processmessages;

    k:=edit1.text;
    grenze:=strtoint(edit2.text);
    if (k='') or (k='0') then k:='1';
    if (k[1]='-') then k:='1';

    nr:=1;
    memo1.lines.add(inttostr(nr)+#9+k);
    inc(nr);

    Base10StringToFGInt('0',null);
    Base10StringToFGInt('1',konstante);

    Base10StringToFGInt(k,pa);
    FGIntAbs(pa);
    FGintcopy(pa,ursprung);

    w:=1;
    repeat
      //Probedivisionen
      probeprim:=2;
      kt:='';
      Base10StringToFGInt('1',summe);
      FGintcopy(pa,zahl);

      Base10StringToFGInt('2',pteiler);
      FGIntModByInt(pa,probeprim,proberest);
      anzahl:=0;
      while proberest=0 do
      begin
        FGIntDivByIntBis(pa,probeprim,proberest);
        kt:=kt+'2, ';
        inc(anzahl);
        FGIntToBase10String(pa,k);
        FGIntModByInt(pa,probeprim,proberest);
      end;
      if anzahl>0 then
      begin
        Base10StringToFGInt('1',faktor);
        for i:=1 to anzahl+1 do
        begin
          FGIntMul(faktor,pteiler,x);
          faktor:=x;
        end;
        FGIntsub(faktor,konstante,x);
        faktor:=x;
        FGintmul(summe,faktor,y);
        summe:=y;
      end;

      Base10StringToFGInt(k,pa);

      probeprim:=3;
      repeat
        Base10StringToFGInt(inttostr(probeprim),pteiler);
        FGIntModByInt(pa,probeprim,proberest);
        if proberest=0 then
        begin
          anzahl:=0;
          while proberest=0 do
          begin
            FGIntDivByIntBis(pa,probeprim,proberest);
            kt:=kt+inttostr(probeprim)+', ';
            inc(anzahl);
            FGIntToBase10String(pa,k);
            FGIntModByInt(pa,probeprim,proberest);
          end;
          if anzahl>0 then
          begin
            Base10StringToFGInt('1',faktor);
            for i:=1 to anzahl+1 do
            begin
              FGIntMul(faktor,pteiler,x);
              faktor:=x;
            end;
            FGIntsub(faktor,konstante,x);
            faktor:=x;
            Base10StringToFGInt(inttostr(probeprim-1),x);
            FGIntDiv(faktor,x,y);
            faktor:=y;
            FGIntMul(summe,faktor,y);
            summe:=y;
          end
        end
        else
        begin
          inc(probeprim,2);
          while not istprime(probeprim) do inc(probeprim)
        end;
      until probeprim>10000;

      Base10StringToFGInt(k,pa);
      Base10StringToFGInt('2',pb);
      Base10StringToFGInt('2',pc);
      Base10StringToFGInt('1',sum);
      repeat
       //Test auf = 1
        kontrolle:=(FGIntCompareAbs(pa,konstante)=eq);
        if kontrolle=false then
        begin

          //Primzahltest
          FGIntRabinMiller(pa,1,prim);

          FGIntToBase10String(pa,k);
          if prim then
          begin
            Base10StringToFGInt('1',faktor);
            FGIntToBase10String(pa,k);
            kt:=kt+k+', ';
            for i:=1 to 2 do
            begin
              FGIntMul(faktor,pa,y);
              faktor:=y;
            end;
            FGIntsub(faktor,konstante,y);
            faktor:=y;
            FGIntSub(pa,konstante,y);
            FGIntDiv(faktor,y,x);
            faktor:=x;
            FGIntMul(summe,faktor,x);
            summe:=x;
          end
          else
          begin

            //Brent-Rho-Test
            BrentRho(pa,d,x);
            if not abbruch then
            begin
              y:=pa;
              x:=pteiler;
              anzahl:=0;
              repeat
                FGIntDivMod(y,pteiler,efaktor,rfaktor);
                inc(anzahl);
                y:=efaktor;
              until not (FGIntCompareAbs(rfaktor,null)=eq);
              Base10StringToFGInt('1',faktor);
              for i:=1 to anzahl+1 do
              begin
                FGIntMul(faktor,x,y);
                faktor:=y;
              end;
              FGIntsub(faktor,konstante,y);
              faktor:=y;
              FGIntSub(x,konstante,y);
              FGIntDiv(faktor,y,x);
              faktor:=x;
              FGIntMul(summe,faktor,x);
              summe:=x;
            end
            else
            begin
              memo1.lines.add('Abbruch');
              FGIntToBase10String(pa,k);
              memo1.lines.add('Restzahl = '+k);
            end;
          end;
        end;
      until kontrolle or prim or abbruch;

      if not abbruch then
      begin
        FGIntSub(summe,zahl,y);
        summe:=y;
        FGIntToBase10String(summe,k);
        if checkbox1.checked then memo1.lines.add('Primteiler '+kt);
        memo1.lines.add(inttostr(nr)+#9+k);
        inc(nr);
        pa:=summe;
        inc(w);
      end;  
      application.processmessages;
    until (w>=grenze) or
          (FGIntCompareAbs(pa,konstante)=eq) or
          (FGIntCompareAbs(pa,null)=eq) or
          (FGIntCompareAbs(pa,ursprung)=eq) or
           abbruch;

    FGIntDestroy(pa);
    FGIntDestroy(pb);
    FGIntDestroy(pc);
    FGIntDestroy(x);
    FGIntDestroy(y);
    FGIntDestroy(konstante);
    FGIntDestroy(sum);
    FGIntDestroy(summe);
    FGIntDestroy(pteiler);
    FGIntDestroy(faktor);
    FGIntDestroy(efaktor);
    FGIntDestroy(rfaktor);
    FGIntDestroy(null);
    FGIntDestroy(zahl);
    FGIntDestroy(ursprung);

    button1.caption:='Berechnung';
    abbruch:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    abbruch:=true;
end;

end.
