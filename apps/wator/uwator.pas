unit uwator;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls;

type
  Tfwator = class(TForm)
    Panel3: TPanel;
    Panel2: TPanel;
    Panel1: TPanel;
    PB1: TPaintBox;
    MM1: TMainMenu;
    M2: TMenuItem;
    M3: TMenuItem;
    M4: TMenuItem;
    N3: TMenuItem;
    M11: TMenuItem;
    M14: TMenuItem;
    M15: TMenuItem;
    M18: TMenuItem;
    wator: TPanel;
    Label8: TLabel;
    Label6: TLabel;
    L10: TLabel;
    L11: TLabel;
    L12: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    C2: TCheckBox;
    C3: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure S7Click(Sender: TObject);
    procedure init(Sender: TObject);
    procedure PB1P(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure button2click(Sender: TObject);
    procedure button1click(Sender: TObject);
    procedure button3click(Sender: TObject);
    procedure S8Click(Sender: TObject);
    procedure S2C(Sender: TObject);
    procedure E10C(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure T2Change(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure _reset(sender:tobject);
    procedure _resetohne(sender:tobject);
    procedure paint3;
    procedure paint2;
  public
    zelle:array[0..74,0..74] of record
                                af,bf,ch,dh:byte;
                             end;
    e1,e2:array[0..74,0..74] of integer;
    gen:boolean;
    anzahl_hai,anzahl_fisch: integer;
    chronon:longint;
    bit:tbitmap;
  end;

var
  fwator: Tfwator;

implementation

const
   game : byte = 72;
   verzz : integer = 0;
   fbreite : integer = 9;
   wa2: boolean=false;
   pf:integer=50;
   ph:integer=3;
   rf:integer=6;
   bh:integer=12;
   fh:byte=3;
   verz:integer=1;
   gameabbruch:boolean=true;

var
   hlinien,jetztzeichnen:boolean;

{$R *.DFM}

function ein_int(const edit:tedit):integer;
var kk:string;
    x,code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    ein_int:=x;
end;

procedure tfwator.paint2;
var i,j,i8,j8:integer;
    xoff,yoff:integer;
procedure watorlauf;
var i,j,k,f,l,feld,game1,im1,ip1,neufeld:integer;
    frei:array[1..4] of boolean;
begin
    wa2:=c2.checked;
    for i:=1 to game do
    begin
      game1:=game+1;
      zelle[0,i].af:=zelle[game,i].af;
      zelle[i,0].af:=zelle[i,game].af;
      zelle[game1,i].af:=zelle[1,i].af;
      zelle[i,game1].af:=zelle[i,1].af;
      zelle[0,i].ch:=zelle[game,i].ch;
      zelle[i,0].ch:=zelle[i,game].ch;
      zelle[game1,i].ch:=zelle[1,i].ch;
      zelle[i,game1].ch:=zelle[i,1].ch;

      e1[0,i]:=e1[game,i]; e1[i,0]:=e1[i,game];
      e1[game1,i]:=e1[1,i]; e1[i,game1]:=e1[i,1];
    end;

    for i:=0 to 74 do
      for j:=0 to 74 do zelle[i,j].bf:=0;

    for i:=1 to game do begin
      im1:=i-1;
      ip1:=i+1;
      for j:=1 to game do
      begin
        if zelle[i,j].af>0 then
        begin
          fillchar(frei,sizeof(frei),#0);
          feld:=0;
          if (zelle[im1,j].af=0) and (zelle[im1,j].bf=0) and (zelle[im1,j].ch=0) then
          begin
            inc(feld);
            frei[1]:=true
          end;
          if (zelle[i,j-1].af=0) and (zelle[i,j-1].bf=0) and (zelle[i,j-1].ch=0) then
          begin
            inc(feld);
            frei[2]:=true
          end;
          if (zelle[i,j+1].af=0) and (zelle[i,j+1].bf=0) and (zelle[i,j+1].ch=0) then
          begin
            inc(feld);
            frei[3]:=true
          end;
          if (zelle[ip1,j].af=0) and (zelle[ip1,j].bf=0) and (zelle[ip1,j].ch=0) then
          begin
            inc(feld);
            frei[4]:=true
          end;

          if feld>0 then
          begin
            k:=random(feld)+1; l:=1;
            while k<>0 do
            begin
              if frei[l]=true then dec(k);
              inc(l);
            end;
            dec(l);
            neufeld:=zelle[i,j].af+1;
            case l of
              1 : begin
                    if i>1 then zelle[im1,j].bf:=neufeld
                           else zelle[game,j].bf:=neufeld
                  end;
              2 : begin
                    if j>1 then zelle[i,j-1].bf:=neufeld
                           else zelle[i,game].bf:=neufeld
                  end;
              3 : begin
                    if j<game then zelle[i,j+1].bf:=neufeld
                              else zelle[i,1].bf:=neufeld
                  end;
              4 : begin
                    if i<game then zelle[ip1,j].bf:=neufeld
                              else zelle[1,j].bf:=neufeld
                  end;
            end;
            for f:=1 to game do
            begin
              game1:=game+1;
              zelle[0,f].bf:=zelle[game,f].bf;
              zelle[f,0].bf:=zelle[f,game].bf;
              zelle[game1,f].bf:=zelle[1,f].bf;
              zelle[f,game1].bf:=zelle[f,1].bf;
            end;
            if zelle[i,j].af=rf-1 then zelle[i,j].bf:=random(rf)+1;
          end
          else zelle[i,j].bf:=(zelle[i,j].af mod rf)+1;
        end;
      end;
    end;

    for i:=0 to 74 do
      for j:=0 to 74 do zelle[i,j].dh:=0;

    for i:=1 to game do
      for j:=1 to game do
        if zelle[i,j].ch>0 then
        begin
          fillchar(frei,sizeof(frei),#0);
          feld:=0;
          if (zelle[i-1,j].bf>0) then
          begin
            inc(feld);
            frei[1]:=true
          end;
          if (zelle[i,j-1].bf>0) then
          begin
            inc(feld);
            frei[2]:=true
          end;
          if (zelle[i,j+1].bf>0) then
          begin
            inc(feld);
            frei[3]:=true
          end;
          if (zelle[i+1,j].bf>0) then
          begin
            inc(feld);
            frei[4]:=true
          end;
          if feld>0 then
          begin
            k:=random(feld)+1;
            l:=1;
            while k<>0 do
            begin
              if frei[l]=true then dec(k);
              inc(l);
            end;
            dec(l);
            case l of
              1 : begin
                    if i>1 then
                    begin
                      zelle[i-1,j].dh:=zelle[i,j].ch+1;
                      zelle[i-1,j].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end
                    else
                    begin
                      zelle[game,j].dh:=zelle[i,j].ch+1;
                      zelle[game,j].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end;
                  end;
              2 : begin
                    if j>1 then
                    begin
                      zelle[i,j-1].dh:=zelle[i,j].ch+1;
                      zelle[i,j-1].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end
                    else
                    begin
                      zelle[i,game].dh:=zelle[i,j].ch+1;
                      zelle[i,game].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end;
                  end;
              3 : begin
                    if j<game then
                    begin
                      zelle[i,j+1].dh:=zelle[i,j].ch+1;
                      zelle[i,j+1].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end
                    else
                    begin
                      zelle[i,1].dh:=zelle[i,j].ch+1;
                      zelle[i,1].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end;
                  end;
              4 : begin
                    if i<game then
                    begin
                      zelle[i+1,j].dh:=zelle[i,j].ch+1;
                      zelle[i+1,j].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end
                    else
                    begin
                      zelle[1,j].dh:=zelle[i,j].ch+1;
                      zelle[1,j].bf:=0;
                      if not wa2 then e2[i-1,j]:=1
                                 else e2[i-1,j]:=e1[i,j]-4
                    end;
                  end;
            end;
            for f:=1 to game do
            begin
              game1:=game+1;
              zelle[0,f].dh:=zelle[game,f].dh;
              zelle[f,0].dh:=zelle[f,game].dh;
              zelle[game1,f].dh:=zelle[1,f].dh;
              zelle[f,game1].dh:=zelle[f,1].dh;

              zelle[0,f].bf:=zelle[game,f].bf;
              zelle[f,0].bf:=zelle[f,game].bf;
              zelle[game1,f].bf:=zelle[1,f].bf;
              zelle[f,game1].bf:=zelle[f,1].bf;

              e2[0,f]:=e2[game,f];
              e2[f,0]:=e2[f,game];
              e2[game1,f]:=e2[1,f];
              e2[f,game1]:=e2[f,1];
            end;
            if zelle[i,j].ch=bh-1 then
            begin
              zelle[i,j].dh:=random(bh-1)+1;
              e2[i,j]:=1;
            end;
          end
          else
          begin
            fillchar(frei,sizeof(frei),#0);
            feld:=0;
            if (zelle[i-1,j].dh=0) and (zelle[i-1,j].ch=0) then
            begin
              inc(feld);
              frei[1]:=true
            end;
            if (zelle[i,j-1].dh=0) and (zelle[i,j-1].ch=0) then
            begin
              inc(feld);
              frei[2]:=true
            end;
            if (zelle[i,j+1].dh=0) and (zelle[i,j+1].ch=0) then
            begin
              inc(feld);
              frei[3]:=true
            end;
            if (zelle[i+1,j].dh=0) and (zelle[i+1,j].ch=0) then
            begin
              inc(feld);
              frei[4]:=true
            end;
            if feld>0 then
            begin
              k:=random(feld)+1;
              l:=1;
              while k<>0 do
              begin
                if frei[l]=true then dec(k);
                inc(l);
              end;
              dec(l);
              case l of
                1 : begin
                      if i>1 then
                      begin
                        zelle[i-1,j].dh:=zelle[i,j].ch+1;
                        e2[i-1,j]:=e1[i,j]+1;
                      end
                      else
                      begin
                        zelle[game,j].dh:=zelle[i,j].ch+1;
                        e2[game,j]:=e1[i,j]+1;
                      end;
                    end;
                2 : begin
                      if j>1 then
                      begin
                        zelle[i,j-1].dh:=zelle[i,j].ch+1;
                        e2[i,j-1]:=e1[i,j]+1;
                      end
                      else
                      begin
                        zelle[i,game].dh:=zelle[i,j].ch+1;
                        e2[i,game]:=e1[i,j]+1;
                      end;
                    end;
                3 : begin
                      if j<game then
                      begin
                        zelle[i,j+1].dh:=zelle[i,j].ch+1;
                        e2[i,j+1]:=e1[i,j]+1;
                      end
                      else
                      begin
                        zelle[i,1].dh:=zelle[i,j].ch+1;
                        e2[i,1]:=e1[i,j]+1;
                      end;
                    end;
                4 : begin
                      if i<game then
                      begin
                        zelle[i+1,j].dh:=zelle[i,j].ch+1;
                        e2[i+1,j]:=e1[i,j]+1;
                      end
                      else
                      begin
                        zelle[1,j].dh:=zelle[i,j].ch+1;
                        e2[1,j]:=e1[i,j]+1;
                      end;
                    end;
              end;
              for f:=1 to game do
              begin
                zelle[0,f].dh:=zelle[game,f].dh;
                zelle[f,0].dh:=zelle[f,game].dh;
                zelle[game+1,f].dh:=zelle[1,f].dh;
                zelle[f,game+1].dh:=zelle[f,1].dh;

                e2[0,f]:=e2[game,f];
                e2[f,0]:=e2[f,game];
                e2[game+1,f]:=e2[1,f];
                e2[f,game+1]:=e2[f,1];
              end;
              if zelle[i,j].ch=bh-1 then
              begin
                zelle[i,j].dh:=random(bh-1)+1;
                e2[i,j]:=1;
              end;
            end
            else
            begin
              zelle[i,j].dh:=zelle[i,j].ch+1;
              e2[i,j]:=e1[i,j]+1;
            end
          end
        end;
end;

begin
    if bit=nil then exit;
    xoff:=(pb1.width-game*fbreite) div 2;
    yoff:=(pb1.height-game*fbreite) div 2;

    bit.canvas.pen.style:=pssolid;
    bit.canvas.pen.color:=clblack;
    bit.canvas.brush.color:=$00ffffff;

    if hlinien then
    begin
      bit.canvas.pen.color:=$00808080;
      bit.canvas.brush.color:=$00ff0000;
      for i:=0 to game do
      begin
        bit.canvas.moveto(xoff,yoff+i*fbreite);
        bit.canvas.lineto(xoff+game*fbreite,yoff+i*fbreite);
        bit.canvas.moveto(xoff+i*fbreite,yoff);
        bit.canvas.lineto(xoff+i*fbreite,yoff+game*fbreite);
      end;
    end
    else
      bit.canvas.pen.color:=$00ffffff;

    for i:=0 to 74 do
      for j:=0 to 74 do begin
        zelle[i,j].bf:=zelle[i,j].af;
        zelle[i,j].dh:=zelle[i,j].ch;
      end;
    e2:=e1;
    for i:=0 to 74 do
      for j:=0 to 74 do begin
        zelle[i,j].af:=0;
        zelle[i,j].ch:=0;
      end;

            anzahl_fisch:=0;
            anzahl_hai:=0;
            for i:=1 to game do
              for j:=1 to game do
              begin
                if zelle[i,j].bf>0 then inc(anzahl_fisch)
                else
                  if zelle[i,j].dh>0 then inc(anzahl_hai);
              end;

              Label7.caption:='Chrononen '+inttostr(chronon);
              Label5.caption:='Spielfeld '+inttostr(game);
              label1.caption:='Fische '+inttostr(anzahl_fisch);
              label2.caption:='Haie '+inttostr(anzahl_hai);

              jetztzeichnen:=(((chronon-1) mod verz) = 0);
              for i:=1 to game do
              begin
                i8:=xoff+(i-1)*fbreite;
                for j:=1 to game do
                begin
                  j8:=yoff+(j-1)*fbreite;
                  if zelle[i,j].bf>0 then
                  begin
                    if zelle[i,j].bf=rf then zelle[i,j].bf:=1;
                    bit.canvas.Brush.color:=$00ff4040;
                  end
                  else
                  begin
                    if zelle[i,j].dh>0 then
                    begin
                      if zelle[i,j].dh=bh then zelle[i,j].dh:=1;
                      bit.canvas.Brush.color:=$000000d0;
                    end
                    else
                    begin
                      bit.canvas.Brush.color:=$00ffffff;
                    end;
                  end;
                  if jetztzeichnen then
                    bit.canvas.rectangle(i8,j8,i8+fbreite+1,j8+fbreite+1);
                end;
              end;
              if jetztzeichnen then pb1.canvas.draw(0,0,bit);

    for i:=0 to 74 do
      for j:=0 to 74 do begin
        zelle[i,j].af:=zelle[i,j].bf;
        zelle[i,j].ch:=zelle[i,j].dh;
      end;
    e1:=e2;

              if gen then
              begin
                watorlauf;
                inc(chronon);
                for i:=1 to game do
                  for j:=1 to game do
                    if e2[i,j]>=fh then
                    begin
                      e2[i,j]:=0;
                      zelle[i,j].dh:=0
                    end;
                for i:=0 to 74 do
                  for j:=0 to 74 do begin
                    zelle[i,j].af:=zelle[i,j].bf;
                    zelle[i,j].ch:=zelle[i,j].dh;
                  end;
                e1:=e2;
              end;
              if c3.checked and ((anzahl_fisch=0) or (anzahl_fisch=sqr(game))) then
              begin
                gameabbruch:=true;
                m15.checked:=false;
              end;
   gen:=false;
end;

procedure tfwator.paint3;
begin
   if bit=nil then exit;
   bit.canvas.pen.style:=psclear;
   bit.canvas.brush.color:=clwhite;
   bit.canvas.rectangle(-1,-1,pb1.width+1,pb1.height+1);
end;

procedure Tfwator._reset;
begin
    gen:=false;
    chronon:=1;
    fillchar(zelle,sizeof(zelle),#0);
    fillchar(e1,sizeof(e1),#0);
    fillchar(e2,sizeof(e2),#0);
    paint3;
    paint2;
end;
procedure Tfwator._resetohne;
begin
    gen:=false;
    chronon:=1;
    fillchar(zelle,sizeof(zelle),#0);
    fillchar(e1,sizeof(e1),#0);
    fillchar(e2,sizeof(e2),#0);
end;

procedure Tfwator.S7Click(Sender: TObject);
begin
   close;
end;

procedure Tfwator.init(Sender: TObject);
var i,k,l:integer;
begin
    if gameabbruch=false then gameabbruch:=true
    else
    begin
      helpcontext:=249;
      _resetohne(sender);
      i:=1;
      while i<=trunc(0.01*sqr(game)*pf) do
      begin
        k:=raNDOM(game)+1;
        l:=random(game)+1;
        if zelle[k,l].af=0 then
        begin
          zelle[k,l].af:=random(rf)+1;
          inc(anzahl_fisch);
          inc(i)
        end;
      end;
      i:=1;
      while i<=trunc(0.01*sqr(game)*ph) do
      begin
        k:=raNDOM(game)+1;
        l:=random(game)+1;
        if (zelle[k,l].af=0) and (zelle[k,l].ch=0) then
        begin
          zelle[k,l].ch:=random(bh)+1;
          e1[k,l]:=1;
          inc(anzahl_hai);
          inc(i)
        end;
      end;
      paint3;
      paint2;
   end;
end;

procedure Tfwator.PB1P(Sender: TObject);
begin
    paint3;
    paint2;
end;

procedure Tfwator.FormCreate(Sender: TObject);
begin
    randomize;
    gen:=false;
    chronon:=1;
    hlinien:=true;
    init(sender);
end;

procedure Tfwator.button2click(Sender: TObject);
begin
    if gameabbruch=false then gameabbruch:=true
    else
    begin
      gen:=true;
      paint2;
    end
end;

procedure Tfwator.button1click(Sender: TObject);
begin
    if gameabbruch=false then
    begin
      gameabbruch:=true;
      m15.checked:=false;
      button1.caption:='Simulation (F2)';
    end
    else
    begin
      gameabbruch:=false;
      button1.caption:='Stop (F2)';
      m15.checked:=true;
      repeat
        gen:=true;
        paint2;
        if verzz>0 then sleep(verzz*verzz);
        application.processmessages;
      until gameabbruch=true;
    end;
    m15.checked:=false;
end;

procedure Tfwator.button3click(Sender: TObject);
begin
    if gameabbruch=false then gameabbruch:=true
    else
    begin
      gen:=false;
      chronon:=1;
      _resetohne(sender);
      init(sender);
      paint3;
      paint2;
    end;
end;

procedure Tfwator.S8Click(Sender: TObject);
begin
    if gameabbruch=false then gameabbruch:=true
                         else _reset(sender);
end;

procedure Tfwator.S2C(Sender: TObject);
begin
    hlinien:=not hlinien;
    m18.checked:=hlinien;
    paint3;
    paint2;
end;

procedure Tfwator.E10C(Sender: TObject);
begin
    pf:=ein_int(Edit3);
    if pf<1 then pf:=50;
    ph:=ein_int(Edit4);
    if ph<1 then ph:=3;
    rf:=ein_int(Edit5);
    if rf<2 then rf:=6;
    bh:=ein_int(Edit6);
    if bh<2 then bh:=12;
    fh:=ein_int(Edit7);
    if fh<1 then fh:=3;
    verz:=ein_int(edit2);
    if verz<1 then verz:=1;
end;

procedure Tfwator.FormActivate(Sender: TObject);
begin
    bit:=tbitmap.create;
    bit.width:=pb1.width;
    bit.height:=pb1.height;
    game:=72;
end;

procedure Tfwator.T2Change(Sender: TObject);
begin
    verzz:=strtoint(edit1.text);
end;

procedure Tfwator.Panel1Resize(Sender: TObject);
begin
    fbreite:=(Panel1.height-30) div 72;
end;

procedure Tfwator.FormDestroy(Sender: TObject);
begin
    bit.free;
end;

procedure Tfwator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if gameabbruch=false then
    begin
      gameabbruch:=true;
      exit;
    end;
end;

end.

