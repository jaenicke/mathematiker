unit uimplizit;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
{$J+}

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, math, messages,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls, fktint;

type
  TFimpkurv = class(TForm)
    Panel3: TPanel;
    implizit: TPanel;
    Panel2: TPanel;
    Paintbox1: TPaintBox;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label6: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    kurvenschar: TCheckBox;
    Panel7: TPanel;
    Liste1: TListBox;
    Panel6: TPanel;
    Panel4: TPanel;
    Edit5: TEdit;
    Panel1: TPanel;
    Speed2: TSpeedButton;
    Speed1: TSpeedButton;
    Speed3: TSpeedButton;
    procedure S7Click(Sender: TObject);
    procedure pb1Click(Sender: TObject);
    procedure Speed1Click(Sender: TObject);
    procedure Speed3Click(Sender: TObject);
    procedure Speed2Click(Sender: TObject);
    procedure Liste1Click(Sender: TObject);
    procedure WndProc(var msg:TMessage); override;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fimpkurv: TFimpkurv;

implementation

const sabbruch:boolean = true;
var   ufaktor:real;

{$R *.DFM}

procedure Tfimpkurv.WndProc(var msg:TMessage);
begin
   case Msg.Msg of
      WM_CLOSE: begin
       if sabbruch=false then
       begin
         sabbruch:=true;
         button1.caption:='Darstellung'
       end;
       close;
                end;
   else
     inherited;
   end;
end;

procedure TFimpkurv.S7Click(Sender: TObject);
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button1.caption:='Darstellung'
    end
    else close;
end;

function  ein_real(const edit:tedit):real;
var kk:string;
    i:integer;
    we:real;
begin
    kk:=edit.text;
    if kk<>'' then
      for i:=1 to length(kk) do kk[i]:=upcase(kk[i]);
    while pos(',',kk)<>0 do kk[pos(',',kk)]:='.';
    fehler:=0;
    we:=funktionswert(kk,1);
    if fehler<>0 then we:=0;
    ein_real:=we;
end;

procedure TFimpkurv.pb1Click(Sender: TObject);
var bitmap:tbitmap;
    frequenz : TLargeInteger;
    Time1, Time2, abbruchtime: Int64;

const wbx:double=10;
      wby:double=10;
      _x1:double=-5; _x2:double=5;
      _y1:double=-5; _y2:double=5;
var   fx,fy:double;
      grafb,grafh,_x,_y:integer;

procedure graphikinitialisieren(x2,x1:real);
begin
    grafb:=Paintbox1.width;
    grafh:=Paintbox1.height;
    _x2:=x2*ufaktor;
    _x1:=x1*ufaktor;
    _y2:=grafh/grafb*_x2;
    _y1:=grafh/grafb*_x1;
    wbx:=1.0*(_x2-_x1);
    wby:=1.0*(_y2-_y1);
    fx:=grafb/wbx;
    fy:=grafh/wby;
    _x:=round(-_x1*grafb/(_x2-_x1));
    _y:=round(grafh+_y1*grafh/(_y2-_y1));
end;

{$I ksystem}

procedure imzeichnen(can:tcanvas);
label 1;
var f:string;
    j,i,alt,neu,neux,pb1h,pb1w,imin,imax,jmin,jmax:integer;
    x,ff,ffx,pb1f,pb1g,pp,dp:real;
begin
    f:=edit1.text;
    p:=ein_real(edit2);
    pp:=ein_real(edit3);
    dp:=ein_real(edit4);
    if dp<0.01 then
    begin
      dp:=0.1;
      edit4.text:='0.1'
    end;
    if not kurvenschar.checked then pp:=p;

    pb1h:=Paintbox1.height;
    pb1w:=Paintbox1.width;
    pb1f:=wbx/pb1w;
    pb1g:=wby/pb1h;
    if length(f)>0 then
    begin
      for i:=1 to length(f) do
        if f[i]='Y' then f[i]:='Q';

      repeat
        imin:=1000;
        imax:=-1000;
        jmin:=1000;
        jmax:=-1000;
        i:=1;
        repeat
          x:=i*pb1f+_x1;
          j:=1;
          alt:=0;
          repeat
            q:=-j*pb1g+_y2;
            ff:=funktionswert(f,x);
            if ff<0 then neu:=-1
                    else neu:=1;
            if (alt<>0) and (alt<>neu) then
            begin
              q:=-(j-2)*pb1g+_y2;
              ffx:=funktionswert(f,x);
              if ffx<0 then neux:=-1
                       else neux:=1;
              if (alt<>0) and (alt<>neux) then dec(j,2)
              else
              begin
                q:=-(j-1)*pb1g+_y2;
                ffx:=funktionswert(f,x);
                if ffx<0 then neux:=-1
                         else neux:=1;
                if (alt<>0) and (alt<>neux) then dec(j);
              end;
              can.pixels[i-1,j-1]:=clblue;

              if (i>=0) and (j>=0) then
              begin
                imin:=min(i,imin);
                jmin:=min(j,jmin);
                imax:=max(i,imax);
                jmax:=max(j,jmax);
              end;
            end;
            alt:=neu;
            inc(j,3);
          until j>pb1h;

          QueryPerformanceCounter(Time2);
          if time2-time1>abbruchtime then
          begin
            application.processmessages;
            if sabbruch then goto 1;
            Paintbox1.canvas.draw(0,0,bitmap);
            time1:=time2;
          end;
          inc(i,1);
        until i>pb1w;
        j:=jmin-10;
        repeat
          q:=-j*pb1g+_y2;
          i:=imin-10;
          alt:=0;
          repeat
            x:=i*pb1f+_x1;
            ff:=funktionswert(f,x);
            if ff<0 then neu:=-1
                    else neu:=1;
            if (alt<>0) and (alt<>neu) then can.pixels[i-1,j-1]:=clblue;
            alt:=neu;
            inc(i,1);
          until i>imax+10;

          QueryPerformanceCounter(Time2);
          if time2-time1>abbruchtime then
          begin
            application.processmessages;
            if sabbruch then goto 1;
            Paintbox1.canvas.draw(0,0,bitmap);
            time1:=time2;
          end;
          inc(j,1);
        until j>jmax+10;
        p:=p+dp;
      until p>pp;
1:  end;
end;

begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button1.caption:='Darstellung'
    end
    else
    begin
      QueryPerformanceFrequency (frequenz);      // Frequenz des Zählers
      abbruchtime:=frequenz div 2;
      sabbruch:=false;
      button1.caption:='Abbruch';
      bitmap:=tbitmap.create;
      bitmap.width:=Paintbox1.width;
      bitmap.height:=Paintbox1.height;
      graphikinitialisieren(6,-6);
      setbkmode(bitmap.canvas.handle,transparent);
      bitmap.canvas.font.name:='Verdana';
      bitmap.canvas.font.size:=9;
      bitmap.canvas.font.color:=clblue;
      try
        koordinatensystem(bitmap.canvas);
        QueryPerformanceCounter(Time1);
        imzeichnen(bitmap.canvas);
        Paintbox1.canvas.draw(0,0,bitmap);
      finally
        Bitmap.Free;
      end;
    end;
    sabbruch:=true;
    button1.caption:='Darstellung';
end;

procedure TFimpkurv.Speed1Click(Sender: TObject);
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button1.caption:='Darstellung'
    end
    else
    begin
      ufaktor:=ufaktor/1.1;
      pb1click(sender);
    end;
end;

procedure TFimpkurv.Speed3Click(Sender: TObject);
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button1.caption:='Darstellung'
    end
    else
    begin
      ufaktor:=1;
      pb1click(sender);
    end;
end;

procedure TFimpkurv.Speed2Click(Sender: TObject);
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button1.caption:='Darstellung'
    end
    else
    begin
      ufaktor:=ufaktor*1.1;
      pb1click(sender);
    end;
end;

procedure TFimpkurv.Liste1Click(Sender: TObject);
var sel:integer;
    k:string;
begin
    if sabbruch=false then
    begin
      sabbruch:=true;
      button1.caption:='Darstellung'
    end
    else
    begin
      sel:=Liste1.itemindex;
      if sel>=0 then
      begin
        k:=Liste1.items[sel];
        edit5.text:=copy(k,1,pos(#9,k)-1);
        edit1.text:=copy(k,pos(#9,k)+1,255);
      end;
    end;
end;

procedure TFimpkurv.FormShow(Sender: TObject);
begin
    ufaktor:=1;
    Liste1.itemindex:=23;
   // Liste1click(sender);
end;

end.
