unit UBrentRho;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses FGInt;  //copyright 2000, Walied Othman

  function BrentRho(var A: TFGInt; var d: integer; var Z: TFGInt): string;

implementation

uses Forms, Math, SysUtils, Windows, ufaktor;

//---------------------------------------------------------------------------
  function BrentRho(var A: TFGInt; var d: integer; var Z: TFGInt): string;
  var
    okay: boolean;
    s: string;
    r, i, j, k, m: integer;
    xx, yy, tt, tmp, temp1, temp2, factorGGT, one: TFGInt; 
 
  label neu; 
 
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
    result:='';

    TRY
      FGIntRabinMiller(A, 3, okay);
      if(okay)then begin
        FGIntToBase10String(A, s);
        result:= format('%s', [s]);
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
              QueryPerformanceCounter (t2x);       // Zählerstand 2
              form1.label4.caption:=FormatFloat('0.0 ms',1000*(t2x-t1x)/frequenz);
//Form1.lblZeit.Caption:= Format('D: %d  time: %.1f sec', [d, (t//- time)/1000]);
              if abbruch then begin
                Form1.Memo1.Lines.Add(Format('abgebrochen bei D: %d', [d]));
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
            form1.memo1.lines.add('Teiler = '+s);
//          result:= format('%s%s * ', [result, s]);

          FGIntRabinMiller(A, 3, okay);
          if(okay)then begin
            FGIntToBase10String(A, s);
            form1.memo1.lines.add('Teiler = '+s);
//          result:= format('%s%s', [result, s]);
          end else
            Base10StringToFGInt('1', factorGGT);

        end;
      END;
      FGIntToBase10String(Z, s);
//      Form1.lblZeit.Caption:= Format('D: %d    Z: %s    time: %.2f sec   fertig!',
//              [d, s, (GetTickCount - time)/1000]);

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
//---------------------------------------------------------------------------

end.




