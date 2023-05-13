unit _grund;

interface
uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, Menus, Mask, math, fktint;

var   ldatei : tstringlist;
      ldateizeiger : integer =0;

function  _str(a:double;b,c:byte):string;
function  _strkomma(a:double;b,c:byte):string;
function  vorzeichenzahlkomma(we:double;a,b:integer):string;
function komma(const s:string):string;
function  ein_double(const edit:tedit):double;
function leof:boolean;
procedure lclear;
procedure lreset;
function lreadlndouble:double;
function lreadlnint:integer;
function lreadln:string;
procedure lwriteln(const s:string);
procedure lwritelnf(const s:string);
function  _str2komma(a:double):string;
procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);

implementation

procedure xpfeilvoll(can:tcanvas;a,b,c,d:integer);
const xwi=2.64346095279206E-01;
var wi:double;
    x,y:integer;
    pfe:array[0..3] of tpoint;
    wcos,wsin:extended;
  procedure kline(a,b,c,d:integer);
  begin
    can.moveto(a,b);
    can.lineto(c,d);
  end;
begin
  kline(a,b,c,d);
  if (a<>c) or (b<>d) then begin
    if (c-a)<>0 then
      wi:=pi-arctan((d-b)/(c-a))
    else begin
      if d<b then wi:=-pi/2
             else wi:=pi/2;
    end;
    sincos(wi-xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[0].x:=c+x;
    pfe[0].y:=d-y;
    pfe[1].x:=c;
    pfe[1].y:=d;
    sincos(wi+xwi,wsin,wcos);
    x:=round(14.0*wcos);
    y:=round(14.0*wsin);
    if c<a then begin
      x:=-x;
      y:=-y
    end;
    pfe[2].x:=c+x;
    pfe[2].y:=d-y;
    can.brush.color:=can.pen.color;
    can.polygon(slice(pfe,3));
    can.brush.style:=bsclear;
  end;
end;

function _str2komma;
begin
  _str2komma:=_strkomma(a,1,2);
end;
function  _str(a:double;b,c:byte):string;
begin
  str(a:b:c,result);
  if c<>0 then begin
    while (length(result)>1) and (result[length(result)]='0') do delete(result,length(result),1);
    if (length(result)>1) and (result[length(result)]='.') then delete(result,length(result),1);
  end;
  if result='-0' then result:='0';
end;
function  _strkomma(a:double;b,c:byte):string;
begin
  str(a:b:c,result);
  if c<>0 then begin
    while (length(result)>1) and (result[length(result)]='0') do delete(result,length(result),1);
    if (length(result)>1) and (result[length(result)]='.') then delete(result,length(result),1);
  end;
  if result='-0' then result:='0';
  if pos('.',result)>0 then result[pos('.',result)]:=',';
end;
function  vorzeichenzahlkomma(we:double;a,b:integer):string;
begin
  if we<0 then vorzeichenzahlkomma:=_strkomma(we,a,b)
          else vorzeichenzahlkomma:='+'+_strkomma(we,a,b);
  if _strkomma(we,a,b)='0' then vorzeichenzahlkomma:='+0';
end;
function komma(const s:string):string;
begin
  result:=s;
  if result<>'' then
    while pos(',',result)<>0 do result[pos(',',result)]:='.';
end;

function  ein_double(const edit:tedit):double;
var kk:string;
    i:integer;
    we:double;
begin
  kk:=edit.text;
  if kk<>'' then
    for i:=1 to length(kk) do kk[i]:=upcase(kk[i]);
  while pos(',',kk)<>0 do kk[pos(',',kk)]:='.';
  fehler:=0;
  we:=funktionswert(kk,1);
  if fehler<>0 then we:=0;
  ein_double:=we;
end;

function leof:boolean;
begin
  leof := (ldateizeiger>=ldatei.count)
end;
procedure lclear;
begin
  ldatei.clear;
  ldateizeiger:=0;
end;
procedure lreset;
begin
  ldateizeiger:=0;
end;
function lreadlndouble:double;
var s:string;
    r:double;
    code:integer;
begin
  if not leof then begin
    s:=ldatei.strings[ldateizeiger];
    inc(ldateizeiger);
    val(s,r,code);
    lreadlndouble:=r;
  end
  else lreadlndouble:=0;
end;
function lreadlnint:integer;
var s:string;
    code,n:integer;
begin
  if not leof then begin
    s:=ldatei.strings[ldateizeiger];
    inc(ldateizeiger);
    val(s,n,code);
    lreadlnint:=n;
  end
  else lreadlnint:=0;
end;
function lreadln:string;
begin
  if not leof then begin
    result:=ldatei.strings[ldateizeiger];
    inc(ldateizeiger);
  end
  else result:='';
end;
procedure lwriteln(const s:string);
begin
  ldatei.add(s);
  inc(ldateizeiger)
end;
procedure lwritelnf(const s:string);
begin
  ldatei.add('#F');
  inc(ldateizeiger);
  ldatei.add(s);
  inc(ldateizeiger)
end;

end.

