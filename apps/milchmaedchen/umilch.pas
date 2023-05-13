unit umilch;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ComCtrls, StdCtrls, ExtCtrls;

type
  Tform1 = class(TForm)
    milchm: TPanel;
    PaintB1: TPaintBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LBox1: TListBox;
    Memo1: TMemo;
    LBox2: TListBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Edit4: TEdit;
    UpDown4: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure PaintB1Paint(Sender: TObject);
    procedure PB1Paintwmf(can:tcanvas);
    procedure LBox1Click(Sender: TObject);
    procedure rm1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form1: Tform1;

implementation

{$R *.DFM}

procedure Tform1.FormCreate(Sender: TObject);
begin
    rm1change(sender);
end;

procedure Tform1.PaintB1Paint(Sender: TObject);
var bitmap:tbitmap;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintb1.width;
    bitmap.height:=paintb1.height;
    pb1paintwmf(bitmap.canvas);
    paintb1.canvas.draw(0,0,bitmap);
    bitmap.free;
end;

//nach Fiete
function eimer(ka,kb,kc,kz,u,v,w:integer;liste1,liste2:tstringlist):integer;
var Gross,Mittel,Klein,
    Anzahl,loesung1,loesung2:Integer;                         // Zahl der Umfüllungen
    VollGross,VollMittel,VollKlein,         // Kapazitäten
    AnfangGross,AnfangMittel,AnfangKlein,   // Anfangswerte
    EndeGross,EndeMittel,EndeKlein:Integer; // Endwerte
    erfolg:boolean;

procedure Umgiessen(var Krug1,Krug2,Krug3:Integer);
// es wird von Krug1 in Krug2 unter Beachtung der Kapazität von Krug3 gegossen
begin
   inc(Anzahl);
   if Krug1+Krug2<Krug3 then
    begin
     inc(Krug2,Krug1);
     Krug1:=0;
    end
   else
    begin
     dec(Krug1,Krug3-Krug2);
     Krug2:=Krug3;
    end
end;
procedure GrossKleinMittel(var Erfolg:Boolean);
procedure Ausgeben;
begin
   liste1.add(#9+inttostr(gross)+#9+inttostr(mittel)+#9+inttostr(klein));
end;
begin
   Gross:=AnfangGross;
   Mittel:=AnfangMittel;
   Klein:=AnfangKlein;
   Ausgeben;
   Anzahl:=0;
   // Groß --> Klein --> Mittel --> Groß, dreieckig gedacht!!!
   repeat
    if Gross=VollGross then
     begin Umgiessen(Gross,Klein,VollKlein);Ausgeben end else
    if Mittel=VollMittel then
     begin Umgiessen(Mittel,Gross,VollGross);Ausgeben end else
    if Klein=VollKlein then
     begin Umgiessen(Klein,Mittel,VollMittel);Ausgeben end else
    if Gross=0 then
     begin Umgiessen(Mittel,Gross,VollGross);Ausgeben end else
    if Mittel=0 then
     begin Umgiessen(Klein,Mittel,VollMittel);Ausgeben end else
    if Klein=0 then
     begin Umgiessen(Gross,Klein,VollKlein);Ausgeben end;
   until ((Gross=EndeGross) and (Mittel=EndeMittel) and (Klein=EndeKlein)) or
         ((Gross=AnfangGross) and (Mittel=AnfangMittel) and (Klein=AnfangKlein));
   Erfolg:=(Gross=EndeGross) and (Mittel=EndeMittel) and (Klein=EndeKlein);
end;

procedure GrossMittelKlein(var Erfolg:Boolean);
procedure Ausgeben;
begin
   liste2.add(#9+inttostr(gross)+#9+inttostr(mittel)+#9+inttostr(klein));
end;
begin
   Gross:=AnfangGross;Mittel:=AnfangMittel;Klein:=AnfangKlein;
   Ausgeben;Anzahl:=0;
   // Groß --> Mittel --> Klein --> Groß
   repeat
    if Gross=VollGross then
     begin Umgiessen(Gross,Mittel,VollMittel);Ausgeben end else
    if Mittel=VollMittel then
     begin Umgiessen(Mittel,Klein,VollKlein);Ausgeben end else
    if Klein=VollKlein then
     begin Umgiessen(Klein,Gross,VollGross);Ausgeben end else
    if Gross=0 then
     begin Umgiessen(Klein,Gross,VollGross);Ausgeben end else
    if Mittel=0 then
     begin Umgiessen(Gross,Mittel,VollMittel);Ausgeben end else
    if Klein=0 then
     begin Umgiessen(Mittel,Klein,VollKlein);Ausgeben end;
   until ((Gross=EndeGross) and (Mittel=EndeMittel) and (Klein=EndeKlein)) or
         ((Gross=AnfangGross) and (Mittel=AnfangMittel) and (Klein=AnfangKlein));
   Erfolg:=(Gross=EndeGross) and (Mittel=EndeMittel) and (Klein=EndeKlein);
  end;
begin
    liste1.clear;
    liste2.clear;

    VollGross:=ka;
    Vollmittel:=kb;
    Vollklein:=kc;
    AnfangGross:=VollGross;
    AnfangMittel:=0;
    AnfangKlein:=0;

    EndeGross:=u;
    endemittel:=v;
    Endeklein:=w;

    Loesung1:=0;
    GrossKleinMittel(Erfolg);
    if Erfolg then loesung1:=liste1.count;
    Loesung2:=0;
    GrossMittelKlein(Erfolg);
    if Erfolg then loesung2:=liste2.count;

    if (loesung1=0)  and (loesung2=0)
    then eimer:=0
    else
    begin
       if loesung1<=loesung2 then
         eimer:=liste1.count-1
       else
         eimer:=liste2.count-1;
    end;
end;

procedure CanvasSetAngle(C: TCanvas; A: Single);
var LogRec: TLOGFONT;
begin
    GetObject(C.Font.Handle,sizeOf(LogRec),Addr(LogRec));
    LogRec.lfEscapement := Trunc(A*10);
    C.Font.Handle := CreateFontIndirect(LogRec);
end;

function  ein_int(const edit:tedit):integer;
var kk:string;
    x:integer;
    code:integer;
begin
    kk:=edit.text;
    val(kk,x,code);
    if x<=0 then x:=1;
    if code<>0 then ein_int:=1
               else ein_int:=x;
end;

procedure Tform1.PB1Paintwmf(can:tcanvas);
var la,b,h,a,hd,xoffset,yoffset:integer;
    punkte:array[0..4] of tpoint;
    ka,kb,kc,kz:integer;
    i,xm:integer;
    hx:real;
    k:string;
    u,v,w,code:integer;
    xp,yp,xpalt,ypalt:integer;
begin
    b:=paintb1.width;
    h:=paintb1.height;
    can.brush.color:=clwhite;
    can.pen.color:=clwhite;
    can.rectangle(-1,-1,b+1,h+1);
    a:=round(2/sqrt(3)*(h-120));
    if b-120<a then a:=b-120;
    hd:=round(sqrt(3)/2*a);

    xoffset:=(b-a) div 2;
    yoffset:=(h-hd) div 2;

    punkte[0].x:=xoffset+a div 2;
    punkte[0].y:=yoffset;
    punkte[1].x:=xoffset;
    punkte[1].y:=yoffset+hd;
    punkte[2].x:=xoffset+a;
    punkte[2].y:=yoffset+hd;
    can.pen.color:=clwhite;
    can.polygon(slice(punkte,3));

    ka:=ein_int(edit1);
    kb:=ein_int(edit2);
    kc:=ein_int(edit3);
    kz:=ein_int(edit4);
    xm:=xoffset+a div 2;

    can.pen.color:=$00c0c0c0;//clgray;
    for i:=1 to ka-1 do
    begin
      hx:=i*hd/ka;
      can.moveto(round(xm-hx/sqrt(3)),round(yoffset+hx));
      can.lineto(round(xm+hx/sqrt(3)),round(yoffset+hx));

      can.moveto(round(xm-hx/sqrt(3)),round(yoffset+hx));
      can.lineto(round(punkte[2].x-i*a/ka),yoffset+hd);
      can.moveto(round(xm+hx/sqrt(3)),round(yoffset+hx));
      can.lineto(round(punkte[1].x+i*a/ka),yoffset+hd);
    end;

    can.brush.style:=bsdiagcross;
    can.pen.style:=psclear;
    can.brush.color:=$000ff00;
    if kb<=ka then
    begin
      hx:=(kb)*hd/ka;
      punkte[0].x:=round(xm+hx/sqrt(3));
      punkte[0].y:=round(yoffset+hx);
      punkte[1].x:=xoffset+a;
      punkte[1].y:=yoffset+hd;
      punkte[2].x:=round(punkte[2].x-(ka-kb)*a/ka);
      punkte[2].y:=yoffset+hd;
      can.polygon(slice(punkte,3));
    end;

    if kc<=ka then
    begin
      hx:=(kc)*hd/ka;
      punkte[0].x:=round(xm-hx/sqrt(3));
      punkte[0].y:=round(yoffset+hx);
      punkte[1].x:=xoffset;
      punkte[1].y:=yoffset+hd;
      punkte[2].x:=round(punkte[1].x+(ka-kc)*a/ka);
      punkte[2].y:=yoffset+hd;
      can.polygon(slice(punkte,3));
    end;

    can.pen.style:=pssolid;
    punkte[0].x:=xoffset+a div 2;
    punkte[0].y:=yoffset;
    punkte[1].x:=xoffset;
    punkte[1].y:=yoffset+hd;
    punkte[2].x:=xoffset+a;
    punkte[2].y:=yoffset+hd;
    can.pen.color:=clblue;
    can.brush.style:=bsclear;
    can.polygon(slice(punkte,3));

    can.pen.color:=clnavy;
    can.pen.width:=2;
    hx:=(ka-kz)*hd/ka;
    if ka>=kz then
    begin
      can.moveto(round(xm-hx/sqrt(3)),round(yoffset+hx));
      can.lineto(round(xm+hx/sqrt(3)),round(yoffset+hx));
      hx:=(kz)*hd/ka;
      can.moveto(round(xm-hx/sqrt(3)),round(yoffset+hx));
      can.lineto(round(punkte[1].x+(ka-kz)*a/ka),yoffset+hd);
      can.moveto(round(xm+hx/sqrt(3)),round(yoffset+hx));
      can.lineto(round(punkte[2].x-(ka-kz)*a/ka),yoffset+hd);
    end;

    can.font.name:='Verdana';
    can.font.size:=20;
    k:='A';
    can.textout(punkte[0].x-can.textwidth(k) div 2,punkte[0].y-12-can.textheight(k),k);
    k:='B';
    can.textout(punkte[2].x+8,punkte[2].y-can.textheight(k),k);
    k:='C';
    can.textout(punkte[1].x-can.textwidth(k)-8,punkte[2].y-can.textheight(k),k);

    can.font.size:=15;
    k:='« Umfüllen zwischen A und C »';
    la:=can.textwidth(k) div 2;
    CanvasSetAngle(can,60);
    can.textout(round(punkte[1].x+a div 4- la*cos(pi/3))-2*can.textheight(k),round(yoffset+hd div 2+la*sin(pi/3)),k);
    k:='« Umfüllen zwischen A und B »';
    la:=can.textwidth(k) div 2;
    CanvasSetAngle(can,-60);
    can.textout(round(punkte[2].x-a div 4- la*cos(pi/3))+2*can.textheight(k),round(yoffset+hd div 2-la*sin(pi/3)),k);
    k:='« Umfüllen zwischen B und C »';
    la:=can.textwidth(k) div 2;
    CanvasSetAngle(can,0);
    can.textout(round(punkte[1].x+a div 2-la),round(yoffset+hd+12),k);

    //konkrete Lösung
    if lbox2.items.count>0 then
    begin
       can.font.size:=12;
       xpalt:=0;
       ypalt:=0;
       i:=0;
       repeat
         k:=lbox2.items[i];
         delete(k,1,1);
         val(copy(k,1,pos(#9,k)-1),u,code);
         delete(k,1,pos(#9,k));
         val(copy(k,1,pos(#9,k)-1),v,code);

         hx:=(ka-u)*hd/ka;
         xp:=round(xm-(ka-u)*1/2*a/ka+v*a/ka);
         yp:=round(yoffset+hx);
         if i>0 then
         begin
           can.pen.width:=3;
           can.pen.color:=clyellow;
           can.moveto(xpalt,ypalt);
           can.lineto(xp,yp);
           can.pen.width:=1;
           can.pen.color:=clblack;
           can.moveto(xpalt,ypalt);
           can.lineto(xp,yp);
         end;
         k:=inttostr(i);
         can.textout(xp-can.textwidth(k) div 2, yp-can.textheight(k) div 2,k);
         xpalt:=xp;
         ypalt:=yp;
         inc(i);
       until i>lbox2.items.count-1;
       i:=0;
       can.pen.width:=1;
       can.pen.color:=clblack;
       can.brush.color:=clyellow;
       repeat
         k:=lbox2.items[i];
         delete(k,1,1);
         val(copy(k,1,pos(#9,k)-1),u,code);
         delete(k,1,pos(#9,k));
         val(copy(k,1,pos(#9,k)-1),v,code);

         hx:=(ka-u)*hd/ka;
         xp:=round(xm-(ka-u)*1/2*a/ka+v*a/ka);
         yp:=round(yoffset+hx);
         can.ellipse(xp-14,yp-14,xp+15,yp+15);
         k:=inttostr(i);
         can.textout(xp-can.textwidth(k) div 2, yp-can.textheight(k) div 2,k);
         inc(i);
       until i>lbox2.items.count-1;
    end;
end;

procedure Tform1.LBox1Click(Sender: TObject);
var
    ka,kb,kc,kz:integer;
    i:integer;
    u,v,w,code:integer;
    liste1,liste2:tstringlist;
    k:string;
begin
    liste1:=tstringlist.create;
    liste2:=tstringlist.create;
    ka:=ein_int(edit1);
    kb:=ein_int(edit2);
    kc:=ein_int(edit3);
    kz:=ein_int(edit4);
    //konkrete Lösung
    if lbox1.itemindex>=0 then
    begin
      k:=lbox1.items[lbox1.itemindex];
      if k[1]='(' then
      begin
        delete(k,1,1);
        val(copy(k,1,pos(',',k)-1),u,code);
        delete(k,1,pos(',',k));
        val(copy(k,1,pos(',',k)-1),v,code);
        delete(k,1,pos(',',k));
        val(copy(k,1,pos(#9,k)-1),w,code);
        eimer(ka,kb,kc,kz,u,v,w,liste1,liste2);
        lbox2.clear;
        if liste1.count>liste2.count then
        begin
          for i:=0 to liste2.count-1 do begin
            lbox2.items.add(liste2[i])
          end
        end
        else
        begin
          for i:=0 to liste1.count-1 do begin
            lbox2.items.add(liste1[i])
          end;
        end;
      end;
    end;
    liste1.free;
    liste2.free;
    paintb1paint(sender);
end;

procedure Tform1.rm1Change(Sender: TObject);
var
    ka,kb,kc,kz:integer;
    u,v,w,umf:integer;
    liste1,liste2:tstringlist;
begin
    liste1:=tstringlist.create;
    liste2:=tstringlist.create;
    lbox1.clear;
    lbox2.clear;
    ka:=ein_int(edit1);
    kb:=ein_int(edit2);
    kc:=ein_int(edit3);
    kz:=ein_int(edit4);
    if (ka>=kb) and (ka>=kc) then
    begin
    for u:=ka downto 0 do
    begin
      for v:=kb downto 0 do
      begin
        w:=ka-u-v;
        if (w>=0) and (w<=kc) and (u+v+w=ka) then
        begin
          if (u=kz) or (v=kz) or (w=kz)
            then
            begin
              umf:=eimer(ka,kb,kc,kz,u,v,w,liste1,liste2);
              if umf>0 then
                lbox1.items.add('('+inttostr(u)+','+inttostr(v)+','+inttostr(w)+')'+
                               #9+inttostr(umf)+' Umfüllungen');
            end;
        end;
      end;
    end;
    end;
    if lbox1.items.count=0 then lbox1.items.add('keine Lösungsmöglichkeit');
    liste1.free;
    liste2.free;
    paintb1paint(sender);
end;

end.


