unit uchiffre;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}
uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, checkLst, ExtCtrls;

type
  Tfchiffre = class(TForm)
    Panel1: TPanel;
    L1: TLabel;
    L2: TLabel;
    L3: TLabel;
    L4: TLabel;
    L5: TLabel;
    E1: TEdit;
    E2: TEdit;
    E3: TEdit;
    E4: TEdit;
    E5: TEdit;
    E6: TEdit;
    EZiel: TEdit;
    E7: TEdit;
    E8: TEdit;
    C_operationen: TCheckListBox;
    Panel2: TPanel;
    Panel3: TPanel;
    elistbox: TListBox;
    b_neu: TButton;
    b_loesung: TButton;
    UpDown1: TUpDown;
    Eanzahl: TEdit;
    Label1: TLabel;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    E9: TEdit;
    Label2: TLabel;
    b_ziele: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
    procedure t4Change(Sender: TObject);
    procedure b_neuClick(Sender: TObject);
    procedure b_loesungClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure b_speichern(Sender: TObject);
    procedure b_zieleClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fchiffre: Tfchiffre;

implementation

{$R *.DFM}
type _zahl=array[1..9] of integer;

const sabbruch : boolean = true;

procedure Tfchiffre.t4Change(Sender: TObject);
var sel:integer;
begin
   sel:=strtoint(eanzahl.text);
   e9.visible:=sel>8;
   e8.visible:=sel>7;
   e7.visible:=sel>6;
   e6.visible:=sel>5;
   e5.visible:=sel>4;
   e4.visible:=sel>3;
   b_neuclick(sender);
end;

procedure Tfchiffre.b_neuClick(Sender: TObject);
begin
   randomize;
   e1.text:=inttostr(random(20)+1);
   e2.text:=inttostr(random(20)+1);
   e3.text:=inttostr(random(20)+1);
   e4.text:=inttostr(random(20)+1);
   e5.text:=inttostr(random(20)+1);
   e6.text:=inttostr(random(20)+1);
   e7.text:=inttostr(random(20)+1);
   e8.text:=inttostr(random(20)+1);
   e9.text:=inttostr(random(20)+1);
   EZiel.text:=inttostr(random(200)+40);
end;

procedure Tfchiffre.b_loesungClick(Sender: TObject);
var  zahl:array[2..9] of _zahl;
     modus:integer;
     ziel:integer;
     op1,op2,op1b,op2b,op,opb:array[1..9] of integer;
     ks:string;
     oa,om,os,od:boolean;
     Time1, Time2, Freq: Int64;
     zeit:real;
     rufe:int64;

procedure ausgabestring;
var kr,kx:string;
    i,xx,z:integer;
procedure tauschen(p:integer);
var h:integer;
begin
    if op1b[p]>op2b[p] then
    begin
      h:=op1b[p];
      op1b[p]:=op2b[p];
      op2b[p]:=h;
    end;
end;
begin
    op1b:=op1;
    op2b:=op2;
    opb:=op;
    if opb[2] in [43,42] then tauschen(2);
    ks:='['+inttostr(op1b[2])+'] '+chr(opb[2])+' ['+inttostr(op2b[2])+']';
    for i:=3 to modus do
    begin
      if opb[i] in [43,42] then tauschen(i);
      case opb[i] of
        43 : z:=op1b[i]+op2b[i];
        42 : z:=op1b[i]*op2b[i];
        45 : z:=op1b[i]-op2b[i];
        else z:=op1b[i] div op2b[i];
      end;
      kx:='['+inttostr(z)+']';
      kr:='['+inttostr(op1b[i])+'] '+chr(opb[i])+' ['+inttostr(op2b[i])+']';
      xx:=pos(kx,ks);
      case opb[i] of
        43,45 : ks:=copy(ks,1,xx-1)+'('+kr+')'+copy(ks,xx+length(kx),255)
        else ks:=copy(ks,1,xx-1)+kr+copy(ks,xx+length(kx),255);
      end;
//      ks:=copy(ks,1,xx-1)+'('+kr+')'+copy(ks,xx+length(kx),255);
    end;
    while pos('[',ks)>0 do delete(ks,pos('[',ks),1);
    while pos(']',ks)>0 do delete(ks,pos(']',ks),1);
    ks:=inttostr(ziel)+' = '+ks;
end;
procedure tabellefuellen;
begin
     ausgabestring;
     if elistbox.items.indexof(ks)<0 then elistbox.items.add(ks);
end;

function intein(edit:tedit):integer;
var k:string;
    x,code:integer;
begin
    k:=edit.text;
    if k<>'' then
    begin
      val(k,x,code);
      intein:=x
    end
    else intein:=0;
end;
procedure multiplikation(anz:integer); forward;
procedure subtraktion(anz:integer); forward;
procedure division(anz:integer); forward;

procedure addition(anz:integer);
var i,j,b,erg:integer;
begin
    if sabbruch then exit;
    inc(rufe);

    for i:=1 to anz-1 do
    begin
      for j:=i+1 to anz do
      begin
        if (i<>j) then
        begin
          if i mod 4 = 0 then
          begin
            label2.caption:=inttostr(rufe);
            application.processmessages;
          end;
          erg:=zahl[anz][i]+zahl[anz][j];

          if (anz=2) and (erg=ziel) then
          begin
            op[anz]:=43;
            op1[anz]:=zahl[anz][i];
            op2[anz]:=zahl[anz][j];
            tabellefuellen
          end
          else
          begin
            if anz>2 then
            begin
              op[anz]:=43;
              op1[anz]:=zahl[anz][i];
              op2[anz]:=zahl[anz][j];
              b:=anz-1;
              zahl[b]:=zahl[anz];
              zahl[b][i]:=erg;
              if j<anz then zahl[b][j]:=zahl[b][anz];

              addition(anz-1);
              if om then multiplikation(anz-1);
              if os then subtraktion(anz-1);
              if od then division(anz-1);
            end;  
          end;
        end;
      end;
    end;
end;

procedure multiplikation(anz:integer);
var i,j,b,erg:integer;
begin
    if sabbruch then exit;
    inc(rufe);

    for i:=1 to anz-1 do
    begin
      for j:=i+1 to anz do
      begin
        if (i<>j) then
        begin
          erg:=zahl[anz][i]*zahl[anz][j];

          if (anz=2) and (erg=ziel) then
          begin
            op[anz]:=42;
            op1[anz]:=zahl[anz][i];
            op2[anz]:=zahl[anz][j];
            tabellefuellen
          end
          else
          begin
            if anz>2 then
            begin
              op[anz]:=42;
              op1[anz]:=zahl[anz][i];
              op2[anz]:=zahl[anz][j];
              b:=anz-1;
              zahl[b]:=zahl[anz];
              zahl[b][i]:=erg;
              if j<anz then zahl[b][j]:=zahl[b][anz];

              if oa then addition(anz-1);
              multiplikation(anz-1);
              if os then subtraktion(anz-1);
              if od then division(anz-1);
            end;
          end;
        end;
      end;
    end;
end;

procedure subtraktion(anz:integer);
var i,j,b,erg:integer;
begin
    if sabbruch then exit;
    inc(rufe);

    for i:=1 to anz do
    begin
      for j:=1 to anz do
      begin
        if (i<>j) then
        begin
          erg:=zahl[anz][i]-zahl[anz][j];

          if (anz=2) and (erg=ziel) then
          begin
            op[anz]:=45;
            op1[anz]:=zahl[anz][i];
            op2[anz]:=zahl[anz][j];
            tabellefuellen
          end
          else
          begin
            if anz>2 then
            begin
              op[anz]:=45;
              op1[anz]:=zahl[anz][i];
              op2[anz]:=zahl[anz][j];
              b:=anz-1;
              zahl[b]:=zahl[anz];
              if i<anz then
              begin
                zahl[b][i]:=erg;
                if j<anz then zahl[b][j]:=zahl[b][anz];
              end
              else zahl[b][j]:=erg;

              if oa then addition(anz-1);
              if om then multiplikation(anz-1);
              subtraktion(anz-1);
              if od then division(anz-1);
            end;
          end;
        end;
      end;
    end;
end;
procedure division(anz:integer);
var i,j,b,erg:integer;
begin
    if sabbruch then exit;
    inc(rufe);

    for i:=1 to anz do
    begin
      for j:=1 to anz do
      begin
        if (i<>j) and (zahl[anz][j]<>0) then
        begin
          if (zahl[anz][i] mod zahl[anz][j]=0) then
          begin
            erg:=zahl[anz][i] div zahl[anz][j];

            if (anz=2) and (erg=ziel) then
            begin
              op[anz]:=47;
              op1[anz]:=zahl[anz][i];
              op2[anz]:=zahl[anz][j];
              tabellefuellen
            end
            else
            begin
              if anz>2 then
              begin
                op[anz]:=47;
                op1[anz]:=zahl[anz][i];
                op2[anz]:=zahl[anz][j];
                b:=anz-1;
                zahl[b]:=zahl[anz];
                if i<anz then
                begin
                  zahl[b][i]:=erg;
                  if j<anz then zahl[b][j]:=zahl[b][anz];
                end
                else zahl[b][j]:=erg;

                if oa then addition(anz-1);
                if om then multiplikation(anz-1);
                if os then subtraktion(anz-1);
                division(anz-1);
              end;
            end;
          end;
        end;
      end;
    end;
end;
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      b_loesung.caption:='Problem lösen';
    end
    else
    begin
      QueryPerformanceFrequency(Freq);
      QueryPerformanceCounter(Time1);

      elistbox.clear;
      elistbox.sorted:=true;
      b_ziele.visible:=false;
      panel3.caption:='Alle Lösungen';
      rufe:=0;

      sabbruch:=false;
      oa:=C_operationen.checked[0];
      om:=C_operationen.checked[1];
      os:=C_operationen.checked[2];
      od:=C_operationen.checked[3];
      b_loesung.caption:='Abbruch !';
      ziel:=intein(EZiel);

      modus:=strtoint(eanzahl.text);
      zahl[modus][1]:=intein(e1);
      zahl[modus][2]:=intein(e2);
      zahl[modus][3]:=intein(e3);
      zahl[modus][4]:=intein(e4);
      zahl[modus][5]:=intein(e5);
      zahl[modus][6]:=intein(e6);
      zahl[modus][7]:=intein(e7);
      zahl[modus][8]:=intein(e8);
      zahl[modus][9]:=intein(e9);

      if oa then addition(modus);
      if os then subtraktion(modus);
      if om then multiplikation(modus);
      if od then division(modus);

      sabbruch:=true;
      panel3.caption:=inttostr(elistbox.items.count)+' Lösungen';
      b_loesung.caption:='Problem lösen';
      b_ziele.visible:=true;

      QueryPerformanceCounter(Time2);
      zeit:=(Time2-Time1)/freq;
      if zeit<1 then
        label1.caption:='Zeit '+floattostrf(1000*zeit,ffgeneral,4,3)+' ms'
      else
        label1.caption:='Zeit '+floattostrf(zeit,ffgeneral,4,3)+' s';
      label2.caption:=inttostr(rufe)+' Tests';
    end;
end;

procedure Tfchiffre.FormActivate(Sender: TObject);
var i:integer;
begin
    elistbox.doublebuffered:=true;
    for i:=0 to 2 do C_operationen.checked[i]:=true;
    e1.text:='1';
    e2.text:='2';
    e3.text:='3';
    e4.text:='4';
    e5.text:='5';
    eziel.text:='14';
end;

procedure Tfchiffre.b_speichern(Sender: TObject);
begin
    if savedialog1.execute then elistbox.items.savetofile(savedialog1.filename);
end;

procedure Tfchiffre.b_zieleClick(Sender: TObject);
var  zahl:array[2..9] of _zahl;
     erg,modus,i,nochziele:integer;
     op1,op2:array[1..9] of integer;
     op:array[1..9] of char;
     ks:string;
     oa,om,os,od:boolean;
     Time1, Time2, Freq: Int64;
     zeit:real;
     ziele:array of boolean;
     von,bis:integer;

procedure tabellefuellen;
var kr,kx:string;
    i,xx,z:integer;
begin
    ks:='['+inttostr(op1[2])+'] '+op[2]+' ['+inttostr(op2[2])+']';
    for i:=3 to modus do
    begin
      case op[i] of
       '+' : z:=op1[i]+op2[i];
       '*' : z:=op1[i]*op2[i];
       '-' : z:=op1[i]-op2[i];
       else  z:=op1[i] div op2[i];
      end;
      kx:='['+inttostr(z)+']';
      kr:='['+inttostr(op1[i])+'] '+op[i]+' ['+inttostr(op2[i])+']';
      xx:=pos(kx,ks);
      case op[i] of
        '+','-' : ks:=copy(ks,1,xx-1)+'('+kr+')'+copy(ks,xx+length(kx),255)
             else ks:=copy(ks,1,xx-1)+kr+copy(ks,xx+length(kx),255);
      end;
//      ks:=copy(ks,1,xx-1)+'('+kr+')'+copy(ks,xx+length(kx),255);
    end;
    while pos('[',ks)>0 do delete(ks,pos('[',ks),1);
    while pos(']',ks)>0 do delete(ks,pos(']',ks),1);
    ks:=format('%8d = ',[erg])+ks;

    elistbox.items.add(ks);
    ziele[erg]:=true;
    dec(nochziele);
    if nochziele=0 then sabbruch:=true;
    label4.caption:=inttostr(nochziele);
end;

function intein(edit:tedit):integer;
var k:string;
    x,code:integer;
begin
    k:=edit.text;
    if k<>'' then
    begin
      val(k,x,code);
      intein:=x
    end
    else intein:=0;
end;

procedure multiplikation(anz:integer); forward;
procedure subtraktion(anz:integer); forward;
procedure division(anz:integer); forward;

procedure addition(anz:integer);
var i,j,b:integer;
begin
   if sabbruch then exit;

   for i:=1 to anz-1 do
   begin
     for j:=i+1 to anz do
     begin
       if (i<>j) then
       begin
         if i mod 3 = 0 then application.processmessages;
         erg:=zahl[anz][i]+zahl[anz][j];

         if (anz=2) then
         begin
           if (erg>=von) and (erg<=bis) and (not ziele[erg]) then
           begin
             op[anz]:='+';
             op1[anz]:=zahl[anz][i];
             op2[anz]:=zahl[anz][j];
             tabellefuellen
           end
         end
         else
         begin
           if anz>2 then
           begin
             op[anz]:='+';
             op1[anz]:=zahl[anz][i];
             op2[anz]:=zahl[anz][j];
             b:=anz-1;
             zahl[b]:=zahl[anz];
             if i<anz then
             begin
               zahl[b][i]:=erg;
               if j<anz then zahl[b][j]:=zahl[b][anz];
             end
             else zahl[b][j]:=erg;

             addition(b);
             if om then multiplikation(b);
             if os then subtraktion(b);
             if od then division(b);
           end;
         end;
       end;
     end;
   end;
end;

procedure multiplikation(anz:integer);
var i,j,b:integer;
begin
    if sabbruch then exit;

      for i:=1 to anz-1 do
      begin
        for j:=i+1 to anz do
        begin
          if (i<>j) then
          begin
            erg:=zahl[anz][i]*zahl[anz][j];

            if (anz=2) then
            begin
              if (erg>=von) and (erg<=bis) and (not ziele[erg]) then
              begin
                op[anz]:='*';
                op1[anz]:=zahl[anz][i];
                op2[anz]:=zahl[anz][j];
                tabellefuellen
              end
            end
            else
            begin
              if anz>2 then
              begin
                op[anz]:='*';
                op1[anz]:=zahl[anz][i];
                op2[anz]:=zahl[anz][j];
                b:=anz-1;
                zahl[b]:=zahl[anz];
                if i<anz then
                begin
                  zahl[b][i]:=erg;
                  if j<anz then zahl[b][j]:=zahl[b][anz];
                end
                else zahl[b][j]:=erg;

                if oa then addition(b);
                multiplikation(b);
                if os then subtraktion(b);
                if od then division(b);
              end;
            end;
          end;
        end;
  end;
end;

procedure subtraktion(anz:integer);
var i,j,b:integer;
begin
    if sabbruch then exit;

      for i:=1 to anz do
      begin
        for j:=1 to anz do
        begin
          if (i<>j) then
          begin
            erg:=zahl[anz][i]-zahl[anz][j];

            if (anz=2) then
            begin
              if (erg>=von) and (erg<=bis) and (not ziele[erg]) then
              begin
                op[anz]:='-';
                op1[anz]:=zahl[anz][i];
                op2[anz]:=zahl[anz][j];
                tabellefuellen
              end
            end
            else
            begin
              if anz>2 then
              begin
              op[anz]:='-';
              op1[anz]:=zahl[anz][i];
              op2[anz]:=zahl[anz][j];
              b:=anz-1;
              zahl[b]:=zahl[anz];
              if i<anz then
              begin
                zahl[b][i]:=erg;
                if j<anz then zahl[b][j]:=zahl[b][anz];
              end
              else zahl[b][j]:=erg;

              if oa then addition(b);
              if om then multiplikation(b);
              subtraktion(b);
              if od then division(b);
            end;
          end;
        end;
      end;
  end;
end;
procedure division(anz:integer);
var i,j,b:integer;
begin
   if sabbruch then exit;

      for i:=1 to anz do
      begin
        for j:=1 to anz do
        begin
          if (zahl[anz][j]<>0) and (i<>j) then
          begin
            if (zahl[anz][i] mod zahl[anz][j]=0) then
            begin
              erg:=zahl[anz][i] div zahl[anz][j];

              if (anz=2) then
              begin
                if (erg>=von) and (erg<=bis) and (not ziele[erg]) then
                begin
                  op[anz]:='/';
                  op1[anz]:=zahl[anz][i];
                  op2[anz]:=zahl[anz][j];
                  tabellefuellen
                end
              end
              else
              begin
                if anz>2 then
                begin
                  op[anz]:='/';
                  op1[anz]:=zahl[anz][i];
                  op2[anz]:=zahl[anz][j];
                  b:=anz-1;
                  zahl[b]:=zahl[anz];
                  if i<anz then
                  begin
                    zahl[b][i]:=erg;
                    if j<anz then zahl[b][j]:=zahl[b][anz];
                  end
                  else zahl[b][j]:=erg;

                  if oa then addition(b);
                  if om then multiplikation(b);
                  if os then subtraktion(b);
                  division(b);
                end;
              end;
            end;
          end;
        end;
      end;
end;
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      b_ziele.caption:='Ziele suchen';
    end
    else
    begin
      elistbox.clear;
      elistbox.sorted:=true;
      panel3.caption:='Alle Lösungen';
      label2.caption:='-';

      sabbruch:=false;
      oa:=C_operationen.checked[0];
      om:=C_operationen.checked[1];
      os:=C_operationen.checked[2];
      od:=C_operationen.checked[3];
      b_ziele.caption:='Abbruch !';
      b_loesung.visible:=false;

      von:=intein(Edit1);
      if von<0 then
      begin
        von:=0;
        edit1.text:='0'
      end;
      bis:=intein(Edit2);
      if bis>100000+von then
      begin
        bis:=100000+von;
        edit2.text:=inttostr(bis);
      end;
      setlength(ziele,bis+1);
      for i:=0 to bis do ziele[i]:=false;
      nochziele:=bis-von+1;

      modus:=strtoint(eanzahl.text);
      zahl[modus][1]:=intein(e1);
      zahl[modus][2]:=intein(e2);
      zahl[modus][3]:=intein(e3);
      zahl[modus][4]:=intein(e4);
      zahl[modus][5]:=intein(e5);
      zahl[modus][6]:=intein(e6);
      zahl[modus][7]:=intein(e7);
      zahl[modus][8]:=intein(e8);
      zahl[modus][9]:=intein(e9);

      QueryPerformanceFrequency(Freq);
      QueryPerformanceCounter(Time1);

      if oa then addition(modus);
      if os then subtraktion(modus);
      if om then multiplikation(modus);
      if od then division(modus);

      for i:=von to bis do
        if not ziele[i] then elistbox.items.add(format('%8d = -',[i]));
      sabbruch:=true;
      panel3.caption:=inttostr(elistbox.items.count)+' Einträge';
      b_ziele.caption:='Ziele suchen';
      b_loesung.visible:=true;

      QueryPerformanceCounter(Time2);
      zeit:=(Time2-Time1)/freq;
      if zeit<1 then
        label1.caption:='Zeit '+floattostrf(1000*zeit,ffgeneral,4,3)+' ms'
      else
        label1.caption:='Zeit '+floattostrf(zeit,ffgeneral,4,3)+' s';
      label4.caption:=inttostr(nochziele)+' o.L.';
      setlength(ziele,0);
    end;
end;

end.
