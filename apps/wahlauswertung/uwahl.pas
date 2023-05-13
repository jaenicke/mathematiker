unit uwahl;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, Grids, StdCtrls, ExtCtrls, ComCtrls;

type
  TFwahl = class(TForm)
    Menu1: TMainMenu;
    M1: TMenuItem;
    M3: TMenuItem;
    M4: TMenuItem;
    wahl: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    Tabelle: TStringGrid;
    CBwahl: TComboBox;
    CB1: TCheckBox;
    CB2: TCheckBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    image1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure wahlResize(Sender: TObject);
    procedure CBwahlChange(Sender: TObject);
    procedure CB2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    liste : tstringlist;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fwahl: TFwahl;

implementation

const
    pino=pi/180;
var
    waehler,nichtwaehler:int64;
{$R *.DFM}

function ein_int(const edit:tedit):integer;
var kk:string;
    x:integer;
    code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    if code<>0 then ein_int:=0
               else ein_int:=x;
end;
function  _strkomma(a:real;b,c:byte):string;
var ks:string;
begin
    a:=100.0*a;
    str(a:b:c,ks);
    if c<>0 then
    begin
      while (length(ks)>1) and (ks[length(ks)]='0') do delete(ks,length(ks),1);
      if (length(ks)>1) and (ks[length(ks)]='.') then delete(ks,length(ks),1);
    end;
    if ks='-0' then ks:='0';
    if pos('.',ks)>0 then ks[pos('.',ks)]:=',';
    _strkomma:=ks;
end;

procedure TFwahl.Button1Click(Sender: TObject);
var stimmen:array[1..14] of int64;
    xx1,yy1,manzahl,i,j,mandatzahl,maxw,xold,yold,
    farbe,farbe2,autostimm,autostimm2:integer;
    k,kp:string;
    summe,xstimme,automandat:int64;
    maxx,gstimme,wi,wi2,wi3,summ,automat,xma,yma,hprozent:real;
    quotient,prozent:array[0..14] of real;
    mandate:array[1..14] of integer;
    parteiname:array[0..14] of string[20];
    hparteiname:string[20];
    bitmap:tbitmap;

procedure sonderfarben;
begin
        if (kp='PDS') or (kp='LP') or (kp='Linke/PDS') or (kp='Linke') or (kp='KPÖ')
           or (kp='KPD') or (kp='SED') or (kp='KPS') or (kp='USPD')
           or (kp='Partei der Arbeit') or (kp='Ja-Stimmen') then
        begin
          farbe:=clred;
          farbe2:=clwhite
        end;
        if (kp='Piraten') then
        begin
          farbe:=rgb(213,198,9);
          farbe2:=clblack
        end;
        if (kp='SPD') or (kp='SPÖ') or (kp='SPS') or (kp='DFU') or (kp='SP')
          or (kp='Vaterl.Union') or (kp='SDAP') or (kp='SP Schweiz')
          or (kp='Demokratische Partei') then
        begin
          farbe:=clred+integer(rgb(0,100,100));
          farbe2:=clblack
        end;
        if (kp='NEOS') then
        begin
          farbe:=clfuchsia;
          farbe2:=clwhite
        end;
        if (kp='CDU') or (kp='ÖVP') or (kp='Volkspartei') or (kp='DNVP') or (kp='DDP')
          or (kp='Christlichsoziale') or (kp='Einheitsliste') or (kp='EVP') or (kp='CSP')
          or (kp='FBürgerpartei') or (kp='GDVP')  or (kp='Freiheitspartei')
          or (kp='Bürgerklub') or (kp='SVP') or (kp='Nein-Stimmen') then
        begin
          farbe:=clblack;
          farbe2:=clwhite
        end;
        if (kp='CSU') or (kp='FPÖ') or (kp='DPS') or (kp='Z') or (kp='CVP') or (kp='BVP')
          or (kp='Deutschnationale') or (kp='Vosi') or (kp='CD Volkspartei')
          or (kp='BD Partei') then
        begin
          farbe:=clnavy;
          farbe2:=clwhite
        end;
        if (kp='BP') or (kp='DR') or (kp='WP') or (kp='Statt') or (kp='Landbund')
          or (kp='Freie Wähler') or (kp='SRP') or (kp='AfB') or (kp='SSW')or (kp='DGV')
          or (kp='Republikaner') or (kp='BDP') or (kp='Liste C') then
        begin
          farbe:=clblue;
          farbe2:=clwhite
        end;
        if (kp='FDP') or (kp='Liberale') or (kp='DVP') or (kp='LDPD') or (kp='LDP')
          or (kp='Freie Liste') or (kp='Unabhängige') then
        begin
          farbe:=clyellow;
          farbe2:=clblack
        end;
        if (kp='Grüne') or (kp='AL') or (kp='VdgB') or (pos('Bauern',kp)>0)
          or (kp='Grünliberale') or (kp='JB') then
        begin
          farbe:=clgreen;
          farbe2:=clblack
        end;
        if (kp='Bündnis 90') or (kp='Forum') or (kp='Martin') or (kp='Bürgerforum') then
        begin
          farbe:=cllime;
          farbe2:=clblack
        end;
        if (kp='REP') or (kp='DSU') or (kp='NPD') or (kp='DVU') or (kp='Schill') or (kp='BZÖ')
          or (kp='DP') or (kp='BHE') or (kp='BDV') or (kp='NSDAP') or (kp='Großdeutsche')
          or (kp='Pro Chemnitz') or (kp='Perspektive C') or (kp='SD') or (kp='AfD')
          or (kp='S-Volkspartei') or (kp='Stronach') or (kp='FRANK') or (kp='Vorwärts') then
        begin
          farbe:=clmaroon;
          farbe2:=clwhite
        end;
end;

begin
    summe:=0;
    if Edit2.text<>'' then
    begin
      manzahl:=ein_int(Edit2);
      if manzahl<1 then manzahl:=1;
      for i:=1 to 13 do
      begin
        k:=tabelle.cells[1,i];
        if k<>'' then stimmen[i]:=strtoint64(k)
                 else stimmen[i]:=0;
        summe:=summe+stimmen[i];
      end;
      label5.caption:='Gesamtstimmen: '+inttostr(summe);
      if waehler<>0 then label9.caption:='Wahlberechtigte: '+inttostr(waehler)
                    else label9.caption:='Wahlberechtigte: -';
      if nichtwaehler*waehler<>0 then
        label8.caption:='Nichtwähler: '+inttostr(nichtwaehler)+' = '+_strkomma(nichtwaehler/waehler,1,2)+' %'
      else
        label8.caption:='Nichtwähler: -';

      if cb1.checked then
      begin
        xstimme:=waehler;
        while xstimme<summe do xstimme:=xstimme+waehler;
        summe:=xstimme;
      end;
      if waehler<>0 then prozent[0]:=nichtwaehler/waehler;
      xstimme:=summe;
      if summe>0 then
      begin
        for i:=1 to 13 do
        begin
          prozent[i]:=stimmen[i]/summe;
          if tabelle.cells[0,i]<>'' then
            tabelle.cells[2,i]:=_strkomma(prozent[i],1,4);
        end;
        for i:=1 to 13 do
        begin
          if 100.0*prozent[i]<updown1.position then
          begin
            summe:=summe-stimmen[i];
            stimmen[i]:=0;
          end
        end;
        label4.caption:='Stimmen unter Hürde: '+inttostr(xstimme-summe)+
                     ' = '+_strkomma((xstimme-summe)/xstimme,1,2)+' %';

        fillchar(mandate,sizeof(mandate),0);
        mandatzahl:=0;
        repeat
          for i:=1 to 13 do quotient[i]:=stimmen[i]/(mandate[i]+1);
          maxx:=quotient[1];
          maxw:=1;
          for i:=2 to 13 do
          begin
            if quotient[i]>maxx then
            begin
              maxx:=quotient[i];
              maxw:=i;
            end;
          end;
          inc(mandate[maxw]);
          inc(mandatzahl);
        until mandatzahl>=manzahl;
        for i:=1 to 13 do
          if tabelle.cells[0,i]<>'' then
            tabelle.cells[3,i]:=inttostr(mandate[i])+' ('+_strkomma(mandate[i]/manzahl,1,2)+'%)';

{hare}
        fillchar(mandate,sizeof(mandate),0);
        mandatzahl:=0;
        for i:=1 to 13 do
        begin
          quotient[i]:=1.0*manzahl*stimmen[i]/summe;
          mandate[i]:=trunc(quotient[i]);
          mandatzahl:=mandatzahl+mandate[i];
          quotient[i]:=frac(quotient[i]);
        end;
        if mandatzahl<manzahl then
        begin
          repeat
            maxx:=quotient[1];
            maxw:=1;
            for i:=2 to 13 do
            begin
              if quotient[i]>maxx then
              begin
                maxx:=quotient[i];
                maxw:=i;
              end;
            end;
            inc(mandate[maxw]);
            quotient[maxw]:=quotient[maxw]/2;
            inc(mandatzahl);
          until mandatzahl>=manzahl;
        end;
        for i:=1 to 13 do
          if tabelle.cells[0,i]<>'' then
           tabelle.cells[4,i]:=inttostr(mandate[i])+' ('+_strkomma(mandate[i]/manzahl,1,2)+'%)';
{hagenbach}
        fillchar(mandate,sizeof(mandate),0);
        mandatzahl:=0;
        gstimme:=trunc(summe/(manzahl+1))+1;
        for i:=1 to 13 do
        begin
          mandate[i]:=trunc(stimmen[i]/gstimme);
          mandatzahl:=mandatzahl+mandate[i];
          quotient[i]:=stimmen[i]/(mandate[i]+1);
        end;
        if mandatzahl<manzahl then
        begin
          repeat
            maxx:=quotient[1];
            maxw:=1;
            for i:=2 to 13 do
            begin
              if quotient[i]>maxx then
              begin
                maxx:=quotient[i];
                maxw:=i;
              end;
            end;
            inc(mandate[maxw]);
            quotient[maxw]:=0;
            inc(mandatzahl);
          until mandatzahl>=manzahl;
        end;
        for i:=1 to 13 do
          if tabelle.cells[0,i]<>'' then
            tabelle.cells[5,i]:=inttostr(mandate[i])+' ('+_strkomma(mandate[i]/manzahl,1,2)+'%)';
      end;

      if manzahl*summe>0 then
      begin
        if waehler<>0 then automat:=waehler/manzahl
                      else automat:=xstimme/manzahl;
        automandat:=0;
        for i:=1 to 13 do
        begin
          k:=tabelle.cells[1,i];
          if k<>'' then autostimm:=strtoint64(k)
                   else autostimm:=0;
          automandat:=automandat+trunc(autostimm/automat);
        end;
        if automandat>manzahl then automat:=2*automat;
        for i:=1 to 13 do
        begin
          k:=tabelle.cells[1,i];
          if k<>'' then autostimm:=strtoint64(k)
                   else autostimm:=0;
          autostimm2:=trunc(autostimm/automat);
          if tabelle.cells[0,i]<>'' then
            tabelle.cells[6,i]:=inttostr(autostimm2)+' ('+_strkomma(autostimm2/automandat,1,2)+'%)'
          else
            tabelle.cells[6,i]:='';
        end;
      end;
    end;

    bitmap:=tbitmap.Create;
    bitmap.Width:=image1.width;
    bitmap.Height:=image1.Height;

    bitmap.canvas.brush.color:=clwhite;
    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.size:=8;
    xma:=(image1.width-10)/400;
    yma:=(image1.height-20)/200;
    if yma<xma then xma:=yma;
    bitmap.canvas.rectangle(-1,-1,image1.width+1,image1.height+1);

    for i:=1 to 13 do parteiname[i]:=tabelle.cells[0,i];
    parteiname[0]:='Nichtwähler';
    if cb1.checked then
    begin
      for i:=0 to 12 do
        for j:=i+1 to 13 do
        begin
          if prozent[j]>prozent[i] then
          begin
            hprozent:=prozent[j];
            prozent[j]:=prozent[i];
            prozent[i]:=hprozent;
            hparteiname:=parteiname[j];
            parteiname[j]:=parteiname[i];
            parteiname[i]:=hparteiname;
          end;
        end;
      for i:=12 downto 0 do
      begin
        prozent[i+1]:=prozent[i];
        parteiname[i+1]:=parteiname[i];
      end;
    end;

    summ:=0;
    for i:=1 to 13 do
      if 100.0*prozent[i]>=updown1.position then summ:=summ+prozent[i];

    wi:=0;
    xold:=round(10+xma*400);
    yold:=round(4+xma*200);
    for i:=1 to 13 do
      if (100.0*prozent[i]>=updown1.position) and (100.0*prozent[i]>=2) then
      begin
        wi2:=wi+180.0*prozent[i]/summ;
        wi3:=wi+180.0*prozent[i]/2/summ;
        kp:=parteiname[i];

        farbe:=$00f0c0c0;
        farbe2:=clblack;
        if (kp='Nichtwähler') then
        begin
          farbe:=$0080ffff;
          farbe2:=clblack
        end;

        sonderfarben;

        bitmap.canvas.brush.color:=farbe;
        xx1:=round(5+xma*(200+200*cos(wi2*pino)));
        yy1:=round(5+xma*(200-200*sin(wi2*pino)));
        if yy1>round(4+xma*200) then yy1:=round(4+xma*200);
        bitmap.canvas.pie(10,5,round(10+xma*400),round(5+xma*400),xold,yold,xx1,yy1);
        bitmap.canvas.font.color:=farbe2;
        bitmap.canvas.brush.style:=bsclear;
        bitmap.canvas.textout(
          round(5+xma*(200+170*cos(wi3*pino))),
          round(5+xma*(205-170*sin(wi3*pino)))-3,kp);
        xold:=round(5+xma*(200+200*cos((wi2-0.5)*pino)));
        yold:=round(5+xma*(200-200*sin((wi2-0.5)*pino)));
        wi:=wi2;
      end;
      image1.canvas.Draw(0,0,bitmap);
      bitmap.Free;
end;

procedure TFwahl.wahlResize(Sender: TObject);
begin
    tabelle.width:=wahl.width-40;
    tabelle.defaultcolwidth:=(wahl.width-396) div 4;
    Button1.left:=tabelle.left+tabelle.width-121;
    tabelle.colwidths[0]:=100;
    tabelle.colwidths[1]:=90;
    tabelle.colwidths[2]:=90;
    tabelle.colwidths[7]:=68;
    image1.width:=(wahl.width-304-30);
    image1.height:=(wahl.height-416-10);
end;

procedure TFwahl.CBwahlChange(Sender: TObject);
var sel,zz,i,j,z,ii,sperre,lnr:integer;
    k,k2,kk:string;
begin
    sel:=CBwahl.itemindex;
    if sel>=0 then
    begin
      for i:=1 to 15 do
      begin
        for j:=0 to 6 do tabelle.cells[j,i]:='';
      end;

      lnr:=0;
      k:='['+CBwahl.text;
      repeat
        kk:=liste[lnr];
        inc(lnr);
      until (kk=k) or (lnr>liste.count-1);
      sperre:=-1;

      if kk=k then
      begin
        z:=strtoint(liste[lnr]);
        inc(lnr);
        Edit2.text:=inttostr(z);
        zz:=1;
        waehler:=0;
        nichtwaehler:=0;
        ii:=1;
        while ii<14 do
        begin
          tabelle.cells[7,ii]:='';
          inc(ii);
        end;
        repeat
          k:=liste[lnr];
          inc(lnr);
          if k='#' then
          begin
            k2:=liste[lnr];
            inc(lnr);
            waehler:=strtoint64(k2)
          end
          else
            if k='§' then
            begin
              k2:=liste[lnr];
              inc(lnr);
              ii:=1;
              while pos(',',k2)>0 do
              begin
                if copy(k2,1,pos(',',k2)-1)<>'0' then tabelle.cells[7,ii]:=copy(k2,1,pos(',',k2)-1);
                delete(k2,1,pos(',',k2));
                inc(ii);
              end;
              if k2<>'0' then tabelle.cells[7,ii]:=k2;
            end
            else
              if k='%' then
              begin
                k2:=liste[lnr];
                inc(lnr);
                sperre:=strtoint64(k2)
              end
              else
                if k='&' then
                begin
                  k2:=liste[lnr];
                  inc(lnr);
                  nichtwaehler:=waehler-strtoint64(k2);
                  if nichtwaehler<0 then nichtwaehler:=0;
                end
                else
                begin
                  if k[1]<>'[' then
                  begin
                    tabelle.cells[0,zz]:=k;
                    k2:=liste[lnr];
                    inc(lnr);
                    tabelle.cells[1,zz]:=k2;
                    inc(zz);
                  end;
                end;
        until k[1]='[';
      end;
      if sperre>=0 then updown1.position:=sperre
                   else updown1.position:=5;
      Button1click(sender);
    end;
end;

procedure TFwahl.CB2Click(Sender: TObject);
var kk,k2:string;
    j,lnr:integer;
    code:integer;
begin
    CBwahl.clear;
    lnr:=0;
    repeat
      kk:=liste[lnr];
      inc(lnr);
      if kk[1]<>'[' then
      begin
        if cb2.checked then
        begin
          k2:=kk;
          while not (k2[1] in ['0'..'9']) do delete(k2,1,1);
          k2:=copy(k2,1,4);
          val(k2,j,code);
          if j>1944 then CBwahl.items.add(kk);
        end
        else CBwahl.items.add(kk);
      end;
    until kk[1]='[';
    CBwahl.itemindex:=0;
    CBwahlchange(sender);
    Button1click(sender);
end;

procedure TFwahl.FormActivate(Sender: TObject);
var kk,k2:string;
    j,code,lnr:integer;
//    verzeichnis:string;
    ms1: TResourcestream;
begin
//    verzeichnis:=IncludeTrailingBackslash(extractfilepath(application.exename));
    liste:=tstringlist.create;
    ms1 := TResourceStream.Create(hinstance,'wahl',RT_RCDATA);
    try
      liste.loadfromstream(ms1);
    finally
      ms1.Free;
    end;

    tabelle.cells[0,0]:='Partei';
    tabelle.cells[1,0]:='Stimmenzahl';
    tabelle.cells[2,0]:='%-Anteil';
    tabelle.cells[3,0]:='Mandate nach d''Hondt';
    tabelle.cells[4,0]:='… Hare-Niemeyer';
    tabelle.cells[5,0]:='… Hagenbach-Bischoff';
    tabelle.cells[6,0]:='automat.Verfahren';
    tabelle.cells[7,0]:='Mandate';
    tabelle.width:=wahl.width-40;
    tabelle.defaultcolwidth:=(wahl.width-406) div 4;

    Button1.left:=tabelle.left+tabelle.width-121;
    tabelle.colwidths[0]:=110;
    tabelle.colwidths[1]:=90;
    tabelle.colwidths[2]:=90;
    tabelle.colwidths[7]:=68;

    CBwahl.clear;
    lnr:=0;
    repeat
      kk:=liste[lnr];
      inc(lnr);
      if kk[1]<>'[' then
      begin
        if cb2.checked then
        begin
          k2:=kk;
          while not (k2[1] in ['0'..'9']) do delete(k2,1,1);
          k2:=copy(k2,1,4);
          val(k2,j,code);
          if j>1944 then CBwahl.items.add(kk);
        end
        else CBwahl.items.add(kk);
      end;
    until kk[1]='[';
end;

procedure TFwahl.FormDestroy(Sender: TObject);
begin
    liste.free;
end;

end.

