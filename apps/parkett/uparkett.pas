unit uparkett;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, 
  ExtCtrls, StdCtrls, Grids, Buttons, Mask, Menus, Dialogs;

type
  Tparkettform = class(TForm)
    pgrund: TPanel;
    parket: TPanel;
    panel1: TPanel;
    BZeichnen: TButton;
    Sh1: TShape;
    BFarbe1: TButton;
    BFarbe2: TButton;
    Sh2: TShape;
    BFarbe3: TButton;
    Sh3: TShape;
    Liste: TListBox;
    pa1: TPaintBox;
    Label1: TLabel;
    farbwahl: TColorDialog;
    BFarbe4: TButton;
    Sh4: TShape;
    Speed2: TSpeedButton;
    Speed1: TSpeedButton;
    Speed3: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure pa1P(Sender: TObject);
    procedure pazeichnen(can:tcanvas);
    procedure S53C(Sender: TObject);
    procedure S54C(Sender: TObject);
    procedure D2C(Sender: TObject);
    procedure S34C(Sender: TObject);
  private
  { Private declarations }
  public
    { Public declarations }
  end;

var parkettform: Tparkettform;

implementation

uses math;

const seite:integer=40;
      farbe1:integer=$007FFFFF;
      farbe2:integer=$00ff8000;
      farbe3:integer=$000080FF;
      farbe4:integer=clyellow;
      wurzel2 =  1.41421356237310;
      wurzel3 =  1.73205080756888;
      pino = pi/180;

{$R *.DFM}

procedure Tparkettform.FormShow(Sender: TObject);
begin
   sh1.Brush.color:=farbe1;
   sh2.Brush.color:=farbe2;
   sh3.Brush.color:=farbe3;
   liste.itemindex:=0;
end;

procedure Tparkettform.pa1P(Sender: TObject);
var bitmap:tbitmap;
begin
  bitmap:=tbitmap.create;
  bitmap.pixelformat:=pf32bit;
  bitmap.width:=pa1.width;
  bitmap.height:=pa1.height;
  pazeichnen(bitmap.canvas);
  pa1.canvas.draw(0,0,bitmap);
  bitmap.free;
end;

procedure Tparkettform.pazeichnen(can:tcanvas);
var xm,ym,sel:integer;
    pol:array[0..13] of tpoint;
    polx:array[0..12] of record x,y:double end;
  procedure vieleck(anz:integer);
  var i:integer;
  begin
    for i:=0 to anz-1 do begin
      pol[i].x:=round(polx[i].x);
      pol[i].y:=round(polx[i].y);
    end;
    can.polygon(slice(pol,anz));
  end;
  procedure dreieck;
  var i,minus,yminus,j:integer;
      offset,hoehe:double;
  begin
    minus:=xm div seite+2;
    hoehe:=wurzel3*seite/2;
    yminus:=round(ym/hoehe+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=seite/2;
      for i:=-minus to minus do begin
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*seite+offset;
        polx[0].y:=ym+j*hoehe;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite/2;
        polx[2].y:=polx[0].y-hoehe;
        vieleck(3);
      end;
    end;
  end;
  procedure viereck;
  var i,minus,yminus,j:integer;
  begin
    minus:=xm div seite+2;
    yminus:=ym div seite+2;
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        if odd(i+j) then
          can.rectangle(xm+i*seite,ym+j*seite,xm+i*seite+seite+1,ym+j*seite-seite-1);
      end;
    end;
  end;
  procedure sechseck;
  var i,k,minus,yminus,j:integer;
      xoffset,yoffset,hoehe,x0,y0:double;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=xm div seite+2;
    yminus:=round(ym/hoehe+2);
    can.brush.color:=farbe2;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe1;
    for j:=-yminus to yminus do begin
      xoffset:=1.5*seite;
      yoffset:=hoehe;
      for i:=-minus to minus do begin
        x0:=xm+3*i*seite;
        y0:=ym+2*j*hoehe;
        for k:=0 to 5 do begin
          polx[k].x:=x0+seite*cos(k*pi/3);
          polx[k].y:=y0-seite*sin(k*pi/3);
        end;
        if not (abs(j) mod 3 = 0) then vieleck(6);
        for k:=0 to 5 do begin
          polx[k].x:=polx[k].x+xoffset;
          polx[k].y:=polx[k].y+yoffset;
        end;
        if not ((90+j) mod 3 = 1) then vieleck(6);
      end;
    end;
  end;

  procedure trihexagonal(art:boolean);
  var i,k,minus,yminus,j:integer;
      xoffset,hoehe,x0,y0:double;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=round(xm/seite+2);
    yminus:=round(ym/hoehe+3);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      xoffset:=0;
      if odd(j) and art then xoffset:=seite;
      for i:=-minus to minus do begin
        x0:=xm+2*i*seite+xoffset;
        y0:=ym+2*j*hoehe;
        for k:=0 to 5 do begin
          polx[k].x:=x0+seite*cos(k*pi/3);
          polx[k].y:=y0-seite*sin(k*pi/3);
        end;
        vieleck(6);
        if not art then begin
          can.moveto(pol[1].x,pol[1].y);
          can.lineto(pol[1].x+2*seite,pol[1].y);
        end;
      end;
    end;
  end;

  procedure p488;
  var i,k,minus,yminus,j:integer;
      umkreis,xoffset,hoehe,x0,y0:extended;
  begin
    hoehe:=seite/2*(wurzel2+1);
    umkreis:=seite/2*sqrt(4+2*wurzel2);
    minus:=round(xm/(seite+2*hoehe)+2);
    yminus:=round(ym/(seite+2*hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      xoffset:=0;
      if odd(j) then xoffset:=hoehe+seite/2;
      if odd(j) then can.brush.color:=farbe2
                else can.brush.color:=farbe3;
      for i:=-minus to minus do begin
        x0:=xm+i*(seite+2*hoehe)+xoffset;
        y0:=ym+j*(seite+2*hoehe)+xoffset;
        for k:=0 to 7 do begin
          polx[k].x:=x0+umkreis*cos(k*pi/4+pi/8);
          polx[k].y:=y0-umkreis*sin(k*pi/4+pi/8);
        end;
        vieleck(8);
        for k:=0 to 7 do begin
          polx[k].y:=polx[k].y+seite+2*hoehe;
        end;
        vieleck(8);
      end;
    end;
  end;

  procedure p31212;
  var i,k,minus,yminus,j:integer;
      umkreis,xoffset,yoffset,hoehe,x0,y0:extended;
  begin
    hoehe:=seite/2*(wurzel3+2);
    umkreis:=seite/2*(sqrt(6)+wurzel2);
    minus:=round(xm/(2*hoehe)+2);
    yminus:=round(ym/(2*wurzel3*hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      xoffset:=0;
      if odd(j) then xoffset:=hoehe;
      yoffset:=0;
      if odd(j) then yoffset:=wurzel3*hoehe;
      for i:=-minus to minus do begin
        x0:=xm+i*(2*hoehe)+xoffset;
        y0:=ym+j*(2*wurzel3*hoehe)+yoffset;
        for k:=0 to 11 do begin
          polx[k].x:=x0+umkreis*cos(k*pi/6+pi/12);
          polx[k].y:=y0-umkreis*sin(k*pi/6+pi/12);
        end;
        vieleck(12);
        for k:=0 to 11 do begin
          polx[k].y:=polx[k].y+2*wurzel3*hoehe;
        end;
        vieleck(12);
      end;
    end;
  end;

  procedure p4612;
  var i,k,minus,yminus,j:integer;
      umkreis,xoffset,yoffset,hoehe,x0,y0:extended;
  begin
    hoehe:=seite/2*(wurzel3+2)+seite/2;
    umkreis:=seite/2*(sqrt(6)+wurzel2);
    minus:=round(xm/(2*hoehe)+2);
    yminus:=round(ym/(2*wurzel3*hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      xoffset:=0;
      if odd(j) then xoffset:=hoehe;
      yoffset:=0;
      if odd(j) then yoffset:=wurzel3*hoehe;
      for i:=-minus to minus do begin
        can.brush.color:=farbe2;
        x0:=xm+i*(2*hoehe)+xoffset;
        y0:=ym+j*(2*wurzel3*hoehe)+yoffset;
        for k:=0 to 11 do begin
          polx[k].x:=x0+umkreis*cos(k*pi/6+pi/12);
          polx[k].y:=y0-umkreis*sin(k*pi/6+pi/12);
        end;
        vieleck(12);
        for k:=0 to 11 do begin
          polx[k].y:=y0-umkreis*sin(k*pi/6+pi/12)+2*wurzel3*hoehe;
        end;
        vieleck(12);
        can.brush.color:=farbe3;
        x0:=xm+i*(2*hoehe)+xoffset+hoehe;
        y0:=ym+j*(2*wurzel3*hoehe)+yoffset+seite/2*(1+wurzel3);
        for k:=0 to 5 do begin
          polx[k].x:=x0+seite*cos(k*pi/3);
          polx[k].y:=y0-seite*sin(k*pi/3);
        end;
        vieleck(6);
        for k:=0 to 5 do polx[k].y:=polx[k].y+2*wurzel3*hoehe;
        vieleck(6);
        y0:=ym+j*(2*wurzel3*hoehe)+yoffset-seite/2*(1+wurzel3);
        for k:=0 to 5 do polx[k].y:=y0-seite*sin(k*pi/3);
        vieleck(6);
        for k:=0 to 5 do polx[k].y:=y0-seite*sin(k*pi/3)+2*wurzel3*hoehe;
        vieleck(6);
      end;
    end;
  end;

  procedure p3464;
  var i,k,minus,yminus,j:integer;
      hoehe2,umkreis,xoffset,yoffset,hoehe,x0,y0:extended;
      pol12,pol4:array[0..13] of tpoint;
    procedure viereck;
    var k:integer;
    begin
      for k:=0 to 11 do begin
        pol12[k].x:=round(x0+hoehe2*cos(k*pi/6+pi/12));
        pol12[k].y:=round(y0-hoehe2*sin(k*pi/6+pi/12));
      end;
      can.brush.color:=farbe3;
      pol4[0]:=pol[5];
      pol4[1]:=pol12[11];
      pol4[2]:=pol12[0];
      pol4[3]:=pol[6];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[6];
      pol4[1]:=pol12[1];
      pol4[2]:=pol12[2];
      pol4[3]:=pol[7];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[4];
      pol4[1]:=pol12[9];
      pol4[2]:=pol12[10];
      pol4[3]:=pol[5];
      can.polygon(slice(pol4,4));
    end;
  begin
    hoehe:=wurzel3*seite/2;
    hoehe2:=seite/2*(wurzel2+sqrt(6));
    umkreis:=seite;
    minus:=round(xm/(seite+2*hoehe)+2);
    yminus:=round(ym/(3*seite+2*hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      xoffset:=hoehe+seite/2;
      yoffset:=hoehe+seite/2+seite;
      for i:=-minus to minus do begin
        x0:=xm+i*(seite+2*hoehe);
        y0:=ym+j*(3*seite+2*hoehe);
        for k:=0 to 7 do begin
          pol[k].x:=round(x0+umkreis*cos(k*pi/3+pi/6));
          pol[k].y:=round(y0-umkreis*sin(k*pi/3+pi/6));
        end;
        can.brush.color:=farbe2;
        can.polygon(slice(pol,6));
        viereck;
        x0:=xm+i*(seite+2*hoehe)+xoffset;
        y0:=ym+j*(3*seite+2*hoehe)+yoffset;
        for k:=0 to 7 do begin
          pol[k].x:=round(x0+umkreis*cos(k*pi/3+pi/6));
          pol[k].y:=round(y0-umkreis*sin(k*pi/3+pi/6));
        end;
        can.brush.color:=farbe2;
        can.polygon(slice(pol,6));
        viereck;
      end;
    end;
  end;

  procedure p3464b;
  var i,k,minus,yminus,j:integer;
      hoehe2,umkreis,xoffset,yoffset,hoehe,x0,y0:extended;
      pol12,pol4:array[0..13] of tpoint;
    procedure viereck;
    var k:integer;
    begin
      for k:=0 to 11 do begin
        pol12[k].x:=round(x0+hoehe2*cos(k*pi/6+pi/12));
        pol12[k].y:=round(y0-hoehe2*sin(k*pi/6+pi/12));
      end;
      can.brush.color:=farbe3;
      pol4[0]:=pol[5];
      pol4[1]:=pol12[10];
      pol4[2]:=pol12[11];
      pol4[3]:=pol[0];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[0];
      pol4[1]:=pol12[0];
      pol4[2]:=pol12[1];
      pol4[3]:=pol[1];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[1];
      pol4[1]:=pol12[2];
      pol4[2]:=pol12[3];
      pol4[3]:=pol[2];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[2];
      pol4[1]:=pol12[4];
      pol4[2]:=pol12[5];
      pol4[3]:=pol[3];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[3];
      pol4[1]:=pol12[6];
      pol4[2]:=pol12[7];
      pol4[3]:=pol[4];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[4];
      pol4[1]:=pol12[8];
      pol4[2]:=pol12[9];
      pol4[3]:=pol[5];
      can.polygon(slice(pol4,4));
    end;

    procedure viereck2;
    var k:integer;
    begin
      for k:=0 to 11 do begin
        pol12[k].x:=round(x0+hoehe2*cos(k*pi/6+pi/12));
        pol12[k].y:=round(y0-hoehe2*sin(k*pi/6+pi/12));
      end;
      can.brush.color:=farbe3;
      pol4[0]:=pol[0];
      pol4[1]:=pol12[1];
      pol4[2]:=pol12[2];
      pol4[3]:=pol[1];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[4];
      pol4[1]:=pol12[9];
      pol4[2]:=pol12[10];
      pol4[3]:=pol[5];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[3];
      pol4[1]:=pol12[7];
      pol4[2]:=pol12[8];
      pol4[3]:=pol[4];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[1];
      pol4[1]:=pol12[3];
      pol4[2]:=pol12[4];
      pol4[3]:=pol[2];
      can.polygon(slice(pol4,4));
    end;
  begin
    hoehe:=wurzel3*seite/2;
    hoehe2:=seite/2*(wurzel2+sqrt(6));
    umkreis:=seite;
    minus:=round(xm/(seite+2*hoehe)+2);
    yminus:=round(ym/(3*seite+2*hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;

    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        x0:=xm+i*(seite+2*hoehe);
        y0:=ym+j*(3*seite+2*hoehe);
        for k:=0 to 5 do begin
          if odd(i) then begin
            pol[k].x:=round(x0+umkreis*cos(k*pi/3+pi/6));
            pol[k].y:=round(y0-umkreis*sin(k*pi/3+pi/6));
          end else begin
            pol[k].x:=round(x0+umkreis*cos(k*pi/3));
            pol[k].y:=round(y0-umkreis*sin(k*pi/3));
          end;
        end;
        can.brush.color:=farbe2;
        can.polygon(slice(pol,6));
        if odd(i) then viereck2 else viereck;
        xoffset:=hoehe+seite/2;
        yoffset:=hoehe+seite/2+seite;
        x0:=xm+i*(seite+2*hoehe)+xoffset;
        y0:=ym+j*(3*seite+2*hoehe)+yoffset;

        for k:=0 to 5 do begin
          pol[k].x:=round(x0+umkreis*cos(k*pi/3+pi/6));
          pol[k].y:=round(y0-umkreis*sin(k*pi/3+pi/6));
        end;
        can.brush.color:=farbe2;
        can.polygon(slice(pol,6));
        can.brush.color:=farbe3;
        pol4[0]:=pol[0];
        pol4[1]:=pol[5];
        pol4[2]:=pol[5];
        pol4[2].x:=pol4[2].x+seite;
        pol4[3]:=pol[0];
        pol4[3].x:=pol4[3].x+seite;
        can.polygon(slice(pol4,4));
      end;
    end;
  end;

  procedure p3464c;
  var i,k,minus,yminus,j:integer;
      hoehe2,umkreis,xoffset,hoehe,x0,y0:extended;
      pol12,pol4:array[0..13] of tpoint;
    procedure viereck2;
    var k:integer;
    begin
      for k:=0 to 11 do begin
        pol12[k].x:=round(x0+hoehe2*cos(k*pi/6+pi/12));
        pol12[k].y:=round(y0-hoehe2*sin(k*pi/6+pi/12));
      end;
      can.brush.color:=farbe3;
      pol4[0]:=pol[0];
      pol4[1]:=pol12[1];
      pol4[2]:=pol12[2];
      pol4[3]:=pol[1];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol12[2];
      pol4[3]:=pol12[1];
      pol4[2].x:=pol12[1].x-(pol[0].x-pol12[1].x);
      pol4[2].y:=pol12[1].y-(pol[0].y-pol12[1].y);
      pol4[1].x:=pol12[2].x-(pol[1].x-pol12[2].x);
      pol4[1].y:=pol12[2].y-(pol[1].y-pol12[2].y);
      can.polygon(slice(pol4,4));
      pol4[3].x:=pol12[1].x-2*(pol[0].x-pol12[1].x);
      pol4[3].y:=pol12[1].y-2*(pol[0].y-pol12[1].y);
      pol4[0].x:=pol12[2].x-2*(pol[1].x-pol12[2].x);
      pol4[0].y:=pol12[2].y-2*(pol[1].y-pol12[2].y);
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[4];
      pol4[1]:=pol12[9];
      pol4[2]:=pol12[10];
      pol4[3]:=pol[5];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol12[9];
      pol4[3]:=pol12[10];
      pol4[1].x:=pol12[9].x-(pol[4].x-pol12[9].x);
      pol4[1].y:=pol12[9].y-(pol[4].y-pol12[9].y);
      pol4[2].x:=pol12[10].x-(pol[5].x-pol12[10].x);
      pol4[2].y:=pol12[10].y-(pol[5].y-pol12[10].y);
      can.polygon(slice(pol4,4));
      pol4[0].x:=pol12[9].x-2*(pol[4].x-pol12[9].x);
      pol4[0].y:=pol12[9].y-2*(pol[4].y-pol12[9].y);
      pol4[3].x:=pol12[10].x-2*(pol[5].x-pol12[10].x);
      pol4[3].y:=pol12[10].y-2*(pol[5].y-pol12[10].y);
      can.polygon(slice(pol4,4));
      pol4[0]:=pol[5];
      pol4[1]:=pol12[11];
      pol4[2]:=pol12[0];
      pol4[3]:=pol[0];
      can.polygon(slice(pol4,4));
      pol4[0]:=pol12[11];
      pol4[3]:=pol12[0];
      pol4[1]:=pol12[11];
      pol4[2]:=pol12[0];
      pol4[2].x:=pol4[2].x+seite;
      pol4[1].x:=pol4[1].x+seite;
      can.polygon(slice(pol4,4));
      pol4[0].x:=pol4[0].x+2*seite;
      pol4[3].x:=pol4[3].x+2*seite;
      can.polygon(slice(pol4,4));
    end;
    procedure xsechseck;
    var k:integer;
    begin
      for k:=0 to 5 do begin
        pol[k].x:=round(x0+umkreis*cos(k*pi/3));
        pol[k].y:=round(y0-umkreis*sin(k*pi/3));
      end;
      can.polygon(slice(pol,6));
    end;
  begin
    hoehe:=wurzel3*seite/2;
    hoehe2:=seite/2*(wurzel2+sqrt(6));
    umkreis:=seite;
    minus:=round(xm/3/seite+2);
    yminus:=round(ym/(3/2*seite+3*hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;

    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        xoffset:=0;
        if odd(j) then xoffset:=3/2*seite+hoehe;
        x0:=xm+i*(3*seite+2*hoehe)+xoffset;
        y0:=ym+j*(3*seite/2+3*hoehe);
        for k:=0 to 5 do begin
          pol[k].x:=round(x0+umkreis*cos(k*pi/3+pi/6));
          pol[k].y:=round(y0-umkreis*sin(k*pi/3+pi/6));
        end;
        can.brush.color:=farbe2;
        can.polygon(slice(pol,6));
        viereck2;
        can.brush.color:=farbe2;
        x0:=xm+i*(3*seite+2*hoehe)+xoffset+3/2*seite+hoehe;
        y0:=ym+j*(3*seite/2+3*hoehe)+hoehe+seite/2;
        xsechseck;
        y0:=ym+j*(3*seite/2+3*hoehe)-hoehe-seite/2;
        xsechseck;
      end;
    end;
  end;

  procedure ahexa;
  var i,minus,yminus,j:integer;
      offset,hoehe:double;
    procedure sechs;
    var i,k,minus,yminus,j:integer;
        x0,y0,hoehe:double;
    begin
      hoehe:=wurzel3*seite/2;
      minus:=round(xm/7/seite+2);
      yminus:=round(ym/3/hoehe+2);
      can.brush.color:=farbe2;
      for j:=-yminus to yminus do begin
        for i:=-minus to minus do begin
          x0:=xm+7*i*seite+j*seite/2;
          y0:=ym+3*j*hoehe;
          for k:=0 to 5 do begin
            pol[k].x:=round(x0+seite*cos(k*pi/3));
            pol[k].y:=round(y0-seite*sin(k*pi/3));
          end;
          can.polygon(slice(pol,6));
          for k:=0 to 5 do begin
            pol[k].x:=round(x0+seite*cos(k*pi/3)+5*seite/2);
            pol[k].y:=round(y0-seite*sin(k*pi/3)+hoehe);
          end;
          can.polygon(slice(pol,6));
          for k:=0 to 5 do begin
            pol[k].x:=round(x0+seite*cos(k*pi/3)+5*seite);
            pol[k].y:=round(y0-seite*sin(k*pi/3)+2*hoehe);
          end;
          can.polygon(slice(pol,6));
        end;
      end;
    end;
  begin
    minus:=xm div seite+2;
    hoehe:=wurzel3*seite/2;
    yminus:=round(ym/hoehe+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe3;
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=seite/2;
      for i:=-minus to minus do begin
        can.brush.color:=farbe3;
        pol[0].x:=round(xm+i*seite+offset);
        pol[0].y:=round(ym+j*hoehe);
        pol[1].x:=round(xm+i*seite+offset+seite);
        pol[1].y:=pol[0].y;
        pol[2].x:=round(xm+i*seite+offset+seite/2);
        pol[2].y:=round(ym+j*hoehe-hoehe);
        can.polygon(slice(pol,3));
      end;
    end;
    sechs;
  end;

  procedure etrig;
  var i,minus,yminus,j:integer;
      offset,hoehe:double;
  begin
    minus:=xm div seite+2;
    hoehe:=wurzel3*seite/2;
    yminus:=round(ym/(hoehe+seite)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=seite/2;
      for i:=-minus to minus do begin
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*seite+offset;
        polx[0].y:=ym+j*(hoehe+seite);
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite/2;
        polx[2].y:=polx[0].y-hoehe;
        vieleck(3);
        can.brush.color:=farbe3;
        polx[0].x:=polx[0].x+seite/2;
        polx[0].y:=polx[0].y-hoehe;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[1].x;
        polx[2].y:=polx[1].y-seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[2].y;
        vieleck(4);
      end;
    end;
  end;

  procedure etrig2;
  var i,minus,yminus,j:integer;
      offset,hoehe:double;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=round(xm/(seite+2*hoehe)+2);
    yminus:=round(ym/(hoehe+seite/2)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=hoehe+seite/2;
      for i:=-minus to minus do begin
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*(seite+2*hoehe)+offset;
        polx[0].y:=ym+j*(hoehe+seite/2);
        polx[1].x:=polx[0].x;
        polx[1].y:=polx[0].y-seite;
        polx[2].x:=polx[0].x+hoehe;
        polx[2].y:=polx[0].y-seite/2;
        vieleck(3);
        can.brush.color:=farbe3;
        polx[2].x:=polx[0].x-hoehe;
        vieleck(3);
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*(seite+2*hoehe)+offset+hoehe;
        polx[0].y:=ym+j*(hoehe+seite/2)-seite/2;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite/2;
        polx[2].y:=polx[0].y-hoehe;
        vieleck(3);
        can.brush.color:=farbe3;
        polx[2].y:=polx[0].y+hoehe;
        vieleck(3);
      end;
    end;
  end;

  procedure etrig3;
  var jj,i,minus,yminus,j,v:integer;
      hoehe:double;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=round(xm/(seite/2+2*hoehe)+2);
    yminus:=round(ym/(hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    v:=0;
    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*(2*hoehe+2*seite)+v*seite/2;
        polx[0].y:=ym+j*(seite+hoehe)-i*seite;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y-seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[0].y-seite;
        vieleck(4);
        polx[0]:=polx[1];
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y-seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[0].y-seite;
        vieleck(4);
        polx[0].x:=xm+i*(2*hoehe+2*seite)+v*seite/2+2*seite;
        polx[0].y:=ym+j*(seite+hoehe)-i*seite-seite;
        polx[1].x:=polx[0].x+hoehe;
        polx[1].y:=polx[0].y-seite/2;
        polx[2].x:=polx[0].x+hoehe-seite/2;
        polx[2].y:=polx[0].y-seite/2-hoehe;
        polx[3].x:=polx[0].x-seite/2;
        polx[3].y:=polx[0].y-hoehe;
        vieleck(4);
        for jj:=0 to 3 do begin
          polx[jj].x:=polx[jj].x+hoehe;
          polx[jj].y:=polx[jj].y-seite/2;
        end;
        vieleck(4);
        can.brush.color:=farbe3;
        polx[0].x:=xm+i*(2*hoehe+2*seite)+v*seite/2;
        polx[0].y:=ym+j*(seite+hoehe)-i*seite;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite/2;
        polx[2].y:=polx[0].y+hoehe;
        vieleck(3);
        for jj:=0 to 2 do polx[jj].x:=polx[jj].x+seite;
        vieleck(3);
        polx[0].x:=xm+i*(2*hoehe+2*seite)+v*seite/2+2*seite;
        polx[0].y:=ym+j*(seite+hoehe)-i*seite;
        polx[1].x:=polx[0].x;
        polx[1].y:=polx[0].y-seite;
        polx[2].x:=polx[0].x+hoehe;
        polx[2].y:=polx[0].y-seite/2;
        vieleck(3);
        for jj:=0 to 2 do begin
          polx[jj].x:=polx[jj].x+hoehe;
          polx[jj].y:=polx[jj].y-seite/2;
        end;
        vieleck(3);
      end;
      inc(v);
    end;
  end;
  procedure etrig4;
  var jj,i,minus,yminus,j:integer;
      offset,hoehe:double;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=round(xm/(3*seite+2*hoehe)+2);
    yminus:=round(ym/(seite+hoehe)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=3*seite/2+hoehe;
      for i:=-minus to minus do begin
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*(2*hoehe+3*seite)+offset;
        polx[0].y:=ym+j*(3/2*seite+hoehe);
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y-seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[0].y-seite;
        vieleck(4);
        polx[0]:=polx[1];
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y-seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[0].y-seite;
        vieleck(4);
        can.brush.color:=farbe3;
        polx[0]:=polx[1];
        polx[1].x:=polx[0].x;
        polx[1].y:=polx[0].y-seite;
        polx[2].x:=polx[0].x+hoehe;
        polx[2].y:=polx[0].y-seite/2;
        vieleck(3);
        polx[0].x:=xm+i*(2*hoehe+3*seite)+offset;
        polx[0].y:=ym+j*(3/2*seite+hoehe);
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite/2;
        polx[2].y:=polx[0].y+hoehe;
        vieleck(3);
        for jj:=0 to 2 do polx[jj].x:=polx[jj].x+seite;
        vieleck(3);
        for jj:=0 to 2 do polx[jj].y:=polx[jj].y-seite;
        polx[2].y:=polx[2].y-2*hoehe;
        vieleck(3);
        for jj:=0 to 2 do polx[jj].x:=polx[jj].x-seite;
        vieleck(3);
        can.brush.color:=farbe2;
        polx[0].x:=xm+i*(2*hoehe+3*seite)+offset+2*seite+hoehe;
        polx[0].y:=ym+j*(3/2*seite+hoehe)-seite/2;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y-seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[0].y-seite;
        vieleck(4);
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y+seite;
        polx[3].x:=polx[0].x;
        polx[3].y:=polx[0].y+seite;
        vieleck(4);
        polx[0].x:=xm+i*(2*hoehe+3*seite)+offset+2*seite;
        polx[0].y:=ym+j*(3/2*seite+hoehe)-seite;
        polx[1].x:=polx[0].x+hoehe;
        polx[1].y:=polx[0].y-seite/2;
        polx[2].x:=polx[0].x+hoehe-seite/2;
        polx[2].y:=polx[0].y-seite/2-hoehe;
        polx[3].x:=polx[0].x-seite/2;
        polx[3].y:=polx[0].y-hoehe;
        vieleck(4);
        polx[0].x:=xm+i*(2*hoehe+3*seite)+offset+2*seite;
        polx[0].y:=ym+j*(3/2*seite+hoehe);
        polx[1].x:=polx[0].x+hoehe;
        polx[1].y:=polx[0].y+seite/2;
        polx[2].x:=polx[0].x+hoehe-seite/2;
        polx[2].y:=polx[0].y+seite/2+hoehe;
        polx[3].x:=polx[0].x-seite/2;
        polx[3].y:=polx[0].y+hoehe;
        vieleck(4);
        can.brush.color:=farbe3;
        polx[0].x:=xm+i*(2*hoehe+3*seite)+offset+3*seite+hoehe;
        polx[0].y:=ym+j*(3/2*seite+hoehe)-seite/2;
        polx[1].x:=polx[0].x+hoehe;
        polx[1].y:=polx[0].y+seite/2;
        polx[2].x:=polx[0].x+hoehe;
        polx[2].y:=polx[0].y-seite/2;
        vieleck(3);
      end;
    end;
  end;

  procedure pentagonal;
  var jj,i,minus2,yminus,j,v,w:integer;
      hoehe,x0,y0:double;
      ip,ap:array[0..16] of record x,y:double end;
  begin
    hoehe:=wurzel3*seite/2;
    minus2:=round(xm/(seite)+2);
    yminus:=round(ym/(seite+hoehe)+2);
    can.brush.color:=farbe2;
    w:=0;
    for j:=-yminus to minus2 do begin
      v:=0;
      for i:=-minus2 to minus2 do begin
        x0:=xm+i*(2*seite+seite/4)-w*(seite/2+seite/4);
        y0:=ym+j*(2*hoehe+seite/4*wurzel3)-v*1/2*wurzel3*seite/2;
        if (x0>-2*seite) and (y0>-2*seite) and (x0<pa1.width+2*seite)
          and (y0<pa1.width+2*seite) then begin
          for jj:=0 to 6 do begin
            ip[jj].x:=x0+seite*cos(jj*pi/3+pi/6 +pi/6);
            ip[jj].y:=y0-seite*sin(jj*pi/3+pi/6 +pi/6);
          end;
          for jj:=0 to 7 do begin
            ap[2*jj].x:=x0+sqrt(7)*seite/2*cos(jj*pi/3-arctan(wurzel3/9) +pi/6);
            ap[2*jj].y:=y0-sqrt(7)*seite/2*sin(jj*pi/3-arctan(wurzel3/9) +pi/6);
          end;
          for jj:=0 to 6 do begin
            ap[2*jj+1].x:=x0+sqrt(7)*seite/2*cos(jj*pi/3+arctan(wurzel3/9) +pi/6);
            ap[2*jj+1].y:=y0-sqrt(7)*seite/2*sin(jj*pi/3+arctan(wurzel3/9) +pi/6);
          end;
          polx[0].x:=x0;
          polx[0].y:=y0;
          for jj:=0 to 5 do begin
            case jj mod 6 of
              0 : can.brush.color:=farbe1;
              2 : can.brush.color:=farbe2;
              4 : can.brush.color:=farbe3;
              3 : can.brush.color:=abs($00c0c0c0-farbe1);
              5 : can.brush.color:=abs($00c0c0c0-farbe2);
              1 : can.brush.color:=abs($00c0c0c0-farbe3);
            end;
            polx[1].x:=ip[jj].x;
            polx[1].y:=ip[jj].y;
            polx[2].x:=ap[2*jj+2].x;
            polx[2].y:=ap[2*jj+2].y;
            polx[3].x:=ap[2*jj+3].x;
            polx[3].y:=ap[2*jj+3].y;
            polx[4].x:=ip[jj+1].x;
            polx[4].y:=ip[jj+1].y;
            vieleck(5);
          end;
        end; //einschr
        inc(v);
      end;
      inc(w);
    end;
  end;
  procedure rhombisch;
  var i,minus,yminus,j:integer;
      hoehe,x0,y0,offset:double;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=round(xm/(2*hoehe)+2);
    yminus:=round(ym/(3/2*seite)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=hoehe;
      for i:=-minus to minus do begin
        x0:=xm+i*(2*hoehe)+offset;
        y0:=ym+j*(3/2*seite);
        if (x0>-2*seite) and (y0>-2*seite) and (x0<pa1.width+2*seite)
          and (y0<pa1.width+2*seite) then begin
          can.brush.color:=farbe2;
          polx[0].x:=x0;
          polx[0].y:=y0;
          polx[1].x:=x0+hoehe;
          polx[1].y:=y0+seite/2;
          polx[2].x:=x0+2*hoehe;
          polx[2].y:=y0;
          polx[3].x:=x0+hoehe;
          polx[3].y:=y0-seite/2;
          vieleck(4);
          can.brush.color:=farbe3;
          polx[1].x:=x0;
          polx[1].y:=y0+seite;
          polx[2].x:=x0+hoehe;
          polx[2].y:=y0+seite+seite/2;
          polx[3].x:=x0+hoehe;
          polx[3].y:=y0+seite/2;
          vieleck(4);
        end;
      end; //einschr
    end;
  end;

  procedure hsechseck;
  var i,k,minus,yminus,j:integer;
      xoffset,yoffset,hoehe,x0,y0:double;
      poly:array[0..15] of record x,y:double end;
    procedure halbiert;
    var k:integer;
    begin
      polx[0].x:=x0;
      polx[0].y:=y0;
      for k:=0 to 6 do begin
        poly[2*k+1].x:=(poly[2*k].x+poly[2*k+2].x)/2;
        poly[2*k+1].y:=(poly[2*k].y+poly[2*k+2].y)/2;
      end;
      for k:=0 to 5 do begin
        polx[1].x:=poly[2*k].x;
        polx[1].y:=poly[2*k].y;
        polx[2].x:=poly[2*k+1].x;
        polx[2].y:=poly[2*k+1].y;
        vieleck(3);
      end;
    end;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=xm div seite+2;
    yminus:=round(ym/hoehe+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    can.brush.color:=farbe2;
    for j:=-yminus to yminus do begin
      xoffset:=3*seite/2;
      yoffset:=hoehe;
      for i:=-minus to minus do begin
        x0:=xm+3*i*seite;
        y0:=ym+2*j*hoehe;
        for k:=0 to 7 do begin
          poly[2*k].x:=x0+seite*cos(k*pi/3);
          poly[2*k].y:=y0-seite*sin(k*pi/3);
        end;
        halbiert;
        x0:=xm+3*i*seite+xoffset;
        y0:=ym+2*j*hoehe+yoffset;
        for k:=0 to 7 do begin
          poly[2*k].x:=x0+seite*cos(k*pi/3);
          poly[2*k].y:=y0-seite*sin(k*pi/3);
        end;
        halbiert;
      end;
    end;
  end;
  procedure deltoidal;
  var i,minus,yminus,j:integer;
      xoffset,x0,y0,diagonale,kseite:double;
  begin
    kseite:=tan(pi/6)*seite;
    diagonale:=seite/cos(pi/6);
    minus:=round(xm/2/seite+2);
    yminus:=round(ym/(kseite+diagonale)+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      xoffset:=0;
      if odd(j) then xoffset:=seite;
      for i:=-minus to minus do begin
        x0:=xm+i*2*seite+xoffset;
        y0:=ym+j*(kseite+diagonale);
        polx[0].x:=x0;
        polx[0].y:=y0;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x+seite;
        polx[2].y:=polx[0].y-kseite;
        polx[3].x:=polx[0].x+seite/2;
        polx[3].y:=polx[0].y-seite*sin(pi/3);
        can.brush.color:=farbe2;
        vieleck(4);
        polx[1].x:=polx[0].x-seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x-seite;
        polx[2].y:=polx[0].y+kseite;
        polx[3].x:=polx[0].x-seite/2;
        polx[3].y:=polx[0].y+seite*sin(pi/3);
        vieleck(4);
        can.brush.color:=farbe3;
        polx[1].x:=polx[0].x+seite/2;
        polx[1].y:=polx[0].y-seite*sin(pi/3);
        polx[2].x:=polx[0].x;
        polx[2].y:=polx[0].y-diagonale;
        polx[3].x:=polx[0].x-seite/2;
        polx[3].y:=polx[0].y-seite*sin(pi/3);
        vieleck(4);
        polx[1].x:=polx[0].x+seite/2;
        polx[1].y:=polx[0].y+seite*sin(pi/3);
        polx[2].x:=polx[0].x;
        polx[2].y:=polx[0].y+diagonale;
        polx[3].x:=polx[0].x-seite/2;
        polx[3].y:=polx[0].y+seite*sin(pi/3);
        vieleck(4);
      end;
    end;
  end;
  procedure tetrakis;
  var i,minus,yminus,j:integer;
      x0,y0:double;
  begin
    minus:=round(xm/seite+2);
    yminus:=round(ym/seite+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        x0:=xm+i*2*seite;
        y0:=ym+j*2*seite;
        can.brush.color:=farbe2;
        polx[0].x:=x0;
        polx[0].y:=y0;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x;
        polx[2].y:=polx[0].y-seite;
        vieleck(3);
        polx[0].x:=x0;
        polx[0].y:=y0;
        polx[1].x:=polx[0].x-seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x;
        polx[2].y:=polx[0].y+seite;
        vieleck(3);
        can.brush.color:=farbe3;
        polx[0].x:=x0+seite;
        polx[0].y:=y0+seite;
        polx[1].x:=polx[0].x-seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x;
        polx[2].y:=polx[0].y-seite;
        vieleck(3);
        polx[0].x:=x0+seite;
        polx[0].y:=y0+seite;
        polx[1].x:=polx[0].x+seite;
        polx[1].y:=polx[0].y;
        polx[2].x:=polx[0].x;
        polx[2].y:=polx[0].y+seite;
        vieleck(3);
      end;
    end;
  end;

  procedure korb;
  var i,minus,yminus,j:integer;
      x0,y0,sseite:double;
    procedure viereck1;
    begin
      polx[1].x:=polx[0].x+2*sseite;
      polx[1].y:=polx[0].y;
      polx[2].x:=polx[0].x+2*sseite;
      polx[2].y:=polx[0].y-sseite;
      polx[3].x:=polx[0].x;
      polx[3].y:=polx[0].y-sseite;
      vieleck(4);
    end;
    procedure viereck2;
    begin
      polx[1].x:=polx[0].x+sseite;
      polx[1].y:=polx[0].y;
      polx[2].x:=polx[0].x+sseite;
      polx[2].y:=polx[0].y-2*sseite;
      polx[3].x:=polx[0].x;
      polx[3].y:=polx[0].y-2*sseite;
      vieleck(4);
    end;
  begin
    sseite:=seite/2;
    minus:=round(xm/4/sseite+2);
    yminus:=round(ym/4/sseite+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        x0:=xm+i*4*sseite;
        y0:=ym+j*4*sseite;
        can.brush.color:=farbe2;
        polx[0].x:=x0;
        polx[0].y:=y0;
        viereck1;
        can.brush.color:=farbe3;
        polx[0].x:=x0;
        polx[0].y:=y0-sseite;
        viereck1;
        can.brush.color:=farbe4;
        polx[0].x:=x0+2*sseite;
        polx[0].y:=y0;
        viereck2;
        can.brush.color:=farbe2;
        polx[0].x:=x0+2*sseite;
        polx[0].y:=y0+2*sseite;
        viereck1;
        can.brush.color:=farbe3;
        polx[0].x:=x0+2*sseite;
        polx[0].y:=y0+sseite;
        viereck1;
        can.brush.color:=farbe4;
        polx[0].x:=x0+4*sseite;
        polx[0].y:=y0+2*sseite;
        viereck2;
      end;
    end;
  end;

  procedure cairo;
  var i,minus,yminus,j:integer;
      quer,x0,y0,kseite,hoehe,wseite:double;
    procedure neck1;
    begin
      can.brush.color:=farbe2;
      polx[0].x:=x0;
      polx[0].y:=y0;
      polx[1].x:=x0+seite*wurzel3/2;
      polx[1].y:=y0+seite/2;
      polx[4].x:=x0-seite*wurzel3/2;
      polx[4].y:=y0+seite/2;
      polx[2].x:=x0+wseite*cos(-75*pino);
      polx[2].y:=y0-wseite*sin(-75*pino);
      polx[3].x:=x0+wseite*cos(-105*pino);
      polx[3].y:=y0-wseite*sin(-105*pino);
      vieleck(5);
    end;
    procedure neck2;
    begin
      can.brush.color:=farbe3;
      polx[0].x:=x0;
      polx[0].y:=y0;
      polx[1].x:=x0+seite*wurzel3/2;
      polx[1].y:=y0-seite/2;
      polx[4].x:=x0-seite*wurzel3/2;
      polx[4].y:=y0-seite/2;
      polx[2].x:=x0+wseite*cos(-75*pino);
      polx[2].y:=y0+wseite*sin(-75*pino);
      polx[3].x:=x0+wseite*cos(-105*pino);
      polx[3].y:=y0+wseite*sin(-105*pino);
      vieleck(5);
    end;
    procedure neck3;
    begin
      can.brush.color:=farbe4;
      polx[0].x:=x0;
      polx[0].y:=y0;
      polx[1].x:=x0;
      polx[1].y:=y0-kseite;
      polx[2].x:=x0+seite*wurzel3/2;
      polx[2].y:=y0-seite/2-kseite;
      polx[4].x:=x0+seite*wurzel3/2;
      polx[4].y:=y0+seite/2;
      polx[3].x:=x0+hoehe;
      polx[3].y:=y0-kseite/2;
      vieleck(5);
    end;
  begin
    hoehe:=sqrt(2*seite*seite-sqr(wurzel2*seite*cos(-75*pino)));
    kseite:=2*wurzel2*seite*cos(-75*pino);
    quer:=2*seite*cos(-30*pino);
    minus:=round(xm/2/quer+2);
    yminus:=round(ym/(2*hoehe+kseite)+2);
    wseite:=wurzel2*seite;
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      for i:=-minus to minus do begin
        x0:=xm+i*2*quer;
        y0:=ym+j*(2*hoehe+kseite);
        neck1;
        neck3;
        y0:=ym+j*(2*hoehe+kseite)+2*hoehe;
        neck2;
        x0:=xm+i*2*quer+quer;
        y0:=ym+j*(2*hoehe+kseite)+quer;
        neck1;
        neck3;
        y0:=ym+j*(2*hoehe+kseite)+2*hoehe+quer;
        neck2;
      end;
    end;
  end;
  procedure triakis;
  var i,minus,yminus,j:integer;
      offset,hoehe:double;
      poly:array[0..4] of record x,y:double end;
    procedure xdr;
    begin
      polx[0].x:=poly[0].x;
      polx[0].y:=poly[0].y;
      can.brush.color:=farbe2;
      polx[1].x:=poly[1].x;
      polx[1].y:=poly[1].y;
      polx[2].x:=poly[2].x;
      polx[2].y:=poly[2].y;
      vieleck(3);
      can.brush.color:=farbe3;
      polx[2].x:=poly[3].x;
      polx[2].y:=poly[3].y;
      vieleck(3);
    end;
  begin
    hoehe:=wurzel3*seite/2;
    minus:=round(xm/seite)+2;
    yminus:=round(ym/hoehe+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=seite/2;
      for i:=-minus to minus do begin
        poly[1].x:=xm+i*seite+offset;
        poly[1].y:=ym+j*hoehe;
        poly[0].x:=poly[1].x+seite/2;
        poly[0].y:=poly[1].y-hoehe/3;
        poly[2].x:=poly[1].x+seite;
        poly[2].y:=poly[1].y;
        poly[3].x:=poly[1].x+seite/2;
        poly[3].y:=poly[1].y-hoehe;
        xdr;
        poly[1].x:=xm+i*seite+seite/2+offset;
        poly[1].y:=ym+j*hoehe-hoehe;
        poly[0].x:=poly[1].x+seite/2;
        poly[0].y:=poly[1].y+hoehe/3;
        poly[3].x:=poly[1].x+seite;
        poly[3].y:=poly[1].y;
        poly[2].x:=poly[1].x+seite/2;
        poly[2].y:=poly[1].y+hoehe;
        xdr;
      end;
    end;
  end;
  procedure prismapent;
  var i,minus,yminus,j,ii:integer;
      offset,hoehe:double;
      poly:array[0..4] of record x,y:double end;
    procedure xdr;
    begin
      polx[0].x:=poly[0].x;
      polx[0].y:=poly[0].y;
      polx[1].x:=poly[1].x;
      polx[1].y:=poly[1].y;
      polx[2].x:=poly[2].x;
      polx[2].y:=poly[2].y;
      polx[3].x:=poly[3].x;
      polx[3].y:=poly[3].y;
      polx[4].x:=poly[4].x;
      polx[4].y:=poly[4].y;
      vieleck(5);
    end;
  begin
    hoehe:=seite/wurzel2+2*seite;
    minus:=round(xm/seite/2)+2;
    yminus:=round(ym/hoehe+2);
    can.brush.color:=farbe1;
    can.rectangle(-1,-1,pa1.width+1,pa1.height+1);
    for j:=-yminus to yminus do begin
      offset:=0;
      if odd(j) then offset:=seite/2;
      for i:=-minus to minus do begin
        poly[0].x:=xm+2*i*seite+offset;
        poly[0].y:=ym+j*hoehe;
        poly[1].x:=poly[0].x+seite;
        poly[1].y:=poly[0].y;
        poly[2].x:=poly[0].x+seite;
        poly[2].y:=poly[0].y-seite;
        poly[3].x:=poly[0].x+seite/2;
        poly[3].y:=poly[0].y-seite-seite/wurzel2;
        poly[4].x:=poly[0].x;
        poly[4].y:=poly[0].y-seite;
        can.brush.color:=farbe2;
        xdr;
        for ii:=0 to 4 do begin
          poly[ii].x:=poly[ii].x+seite;//xm+2*i*seite+seite+offset;
          poly[ii].y:=poly[ii].y;//ym+j*hoehe;
        end;
        can.brush.color:=farbe4;
        xdr;
        poly[0].x:=xm+2*i*seite+offset;
        poly[0].y:=ym+j*hoehe;
        poly[1].x:=poly[0].x+seite;
        poly[1].y:=poly[0].y;
        poly[2].x:=poly[0].x+seite;
        poly[2].y:=poly[0].y+seite;
        poly[3].x:=poly[0].x+seite/2;
        poly[3].y:=poly[0].y+seite+seite/wurzel2;
        poly[4].x:=poly[0].x;
        poly[4].y:=poly[0].y+seite;
        can.brush.color:=farbe3;
        xdr;
      end;
    end;
  end;
begin
  xm:=pa1.width div 2;
  ym:=pa1.height div 2;
  sel:=liste.itemindex;
  if sel<0 then sel:=0;
  case sel of
       0 : dreieck;
       1 : viereck;
       2 : sechseck;
       3 : trihexagonal(true);
       4 : trihexagonal(false);
       5 : p488;
       6 : p31212;
       7 : p4612;
       8 : p3464;
       9 : p3464b;
      10 : p3464c;
      11 : ahexa;
      12 : etrig;
      13 : etrig2;
      14 : etrig3;
      15 : etrig4;
      16 : pentagonal;
      17 : rhombisch;
      18 : hsechseck;
      19 : deltoidal;
      20 : tetrakis;
      21 : korb;
      22 : cairo;
      23 : triakis;
      24 : prismapent;
  end;
end;

procedure Tparkettform.S53C(Sender: TObject);
begin
  seite:=seite+10;
  pa1p(sender);
end;

procedure Tparkettform.S54C(Sender: TObject);
begin
  seite:=seite-10;
  if seite<=0 then seite:=10;
  pa1p(sender);
end;

procedure Tparkettform.D2C(Sender: TObject);
begin
  if farbwahl.execute then begin
    if sender=bfarbe1 then begin
      farbe1:=farbwahl.color;
      sh1.Brush.color:=farbe1;
    end;
    if sender=bfarbe2 then begin
      farbe2:=farbwahl.color;
      sh2.Brush.color:=farbe2;
    end;
    if sender=bfarbe3 then begin
      farbe3:=farbwahl.color;
      sh3.Brush.color:=farbe3;
    end;
    if sender=bfarbe4 then begin
      farbe4:=farbwahl.color;
      sh4.Brush.color:=farbe4;
    end;
    pa1p(sender);
  end;
end;

procedure Tparkettform.S34C(Sender: TObject);
begin
  seite:=40;
  pa1p(sender);
end;

end.
