Unit UPell;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
    UBigIntsV2,stdctrls,sysutils;

type
    TPell= class(Tobject)
      N:int64;
      a:array of integer;
      highcycle:integer;
      p,q:array of Tinteger;
      function setN(newN:int64):integer;
      function makepartialQuotients:integer;
    end;
    procedure PellBtnClick(d:int64;listbox3:tlistbox);

var
  xSolve,ySolve:TInteger;
  SqrtOf:integer;
  BigP,BigQ:TInteger;
  Pell:TPell;

implementation

function TPell.setn(newn:int64):integer;
begin
  If newn>0 then begin
    N:=newN;
    setlength(A,7500);
    highcycle:=MakepartialQuotients;
    result:=highcycle;
  end
  else result:=-1;
end;

function Tpell.makepartialQuotients:integer;
var
  i,last:integer;
  rx:extended;
  PP,QQ:array of int64;
  stop:integer;
  ai,r:integer;
begin
  If n>0 then begin
    setlength(PP,length(a));
    setlength(QQ,length(a));
    rx:=sqrt(0.0+N);
    a[0]:=trunc(rx);
    a[1]:=trunc(1/(rx-a[0]));
    PP[0]:=0;
    PP[1]:=A[0];
    QQ[0]:=1;
    QQ[1]:=n-A[0]*A[0];
    i:=2;
    last:=2*a[0];
    IF a[1]<>last then
      repeat
        PP[i]:=a[i-1]*QQ[i-1]-PP[i-1];
        QQ[i]:=(n-PP[i]*PP[i]) div QQ[i-1];
        a[i]:=(a[0]+PP[i])div QQ[i];
        inc(i);
      until (a[i-1]=last) or (i>high(a));
      if a[i-1]=last then begin
        result:=i-1;
        r:=result-1;
        if (r) mod 2 = 0 then stop:=2*r+1
                         else stop:=r;
        setlength(p,stop+1);
        setlength(q,stop+1);
        for i:=0 to stop do begin
          p[i]:=Tinteger.create;
          q[i]:=TInteger.create;
        end;
        p[0].assign(a[0]);
        q[0].assign(1);
        p[1].assign(a[1]);
        p[1].mult(p[0]);
        p[1].add(1);
        q[1].assign(a[1]);
        q[1].mult(q[0]);
        for i:=2 to stop do begin
          ai:=i;
          if ai>result then ai:=(i-1) mod result +1;
          p[i].assign(a[ai]);
          p[i].mult(p[i-1]);
          p[i].add(p[i-2]);
          q[i].assign(a[ai]);
          q[i].mult(q[i-1]);
          q[i].add(q[i-2]);
        end;
        XSolve.assign(p[stop]);
        ySolve.assign(q[stop]);
      end
      else
        result:=-1;
    end
    else result:=-1;
end;

procedure PellBtnClick(d:int64;listbox3:tlistbox);
  procedure zahleintragen(base10:string);
  var k:string;
  begin
    while length(base10)>50 do begin
      k:=copy(base10,1,50);
      k:=copy(k,1,10)+' '+copy(k,11,10)+' '+copy(k,21,10)+' '+copy(k,31,10)+' '+copy(k,41,20);
      listbox3.items.add('  '+k);
      delete(base10,1,50);
    end;
    k:=base10;
    if k<>'' then begin
      k:=copy(k,1,10)+' '+copy(k,11,10)+' '+copy(k,21,10)+' '+copy(k,31,10)+' '+copy(k,41,20);
      listbox3.items.add('  '+k);
    end;
  end;
begin
  XSolve:=Tinteger.create;
  YSolve:=TInteger.create;
  Pell:=TPell.create;
  BigP:=TInteger.create;
  BigQ:=TInteger.create;
  sqrtof:=0;
  if pell.setN(D)>0 then begin
    bigP.assign(xsolve);
    bigq.assign(YSolve);
    bigP.mult(bigp);
    bigq.mult(bigq);
    bigq.mult(D);
    bigp.subtract(bigQ);
    if bigP.compare(1)=0 then  {x^2-dy^2=1}
      with pell do begin
        listbox3.items.add('Kleinste Lösung der Pellschen Gleichung');
        listbox3.items.add(' x = ');
        zahleintragen(xsolve.converttodecimalstring(false));
        listbox3.items.add(' y = ');
        zahleintragen(ysolve.converttodecimalstring(false));
      end
    else listbox3.items.add('keine Lösung');
  end
  else listbox3.items.add('keine Lösung');
  XSolve.free;
  YSolve.free;
  Pell.free;
  BigP.free;
  BigQ.free;
end;

end.
