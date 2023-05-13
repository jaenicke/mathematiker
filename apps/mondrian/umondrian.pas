unit umondrian;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}
//Grundlage dieses Programms ist "TileFit Tiling Program" von Gary Darby
//http://delphiforfun.org/Programs/tilefit.htm

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, Buttons, Menus, Spin, Mask, math, ExtCtrls;

type
  TIdRect=record
    Id:string;
    Left,top,right,bottom:integer;
    W,H,Area:integer;
  end;
  TForm1 = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    mondrian: TPanel;
    Paintbox1: TPaintBox;
    Panel3: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Button1: TButton;
    Label6: TLabel;
    Label2: TLabel;
    Radiogroup1: TRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    Spin1: TSpinEdit;
    Spin2: TSpinEdit;
    Spin3: TSpinEdit;
    Spin4: TSpinEdit;
    procedure S13Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure drawrects(sender:tobject);
  private
    { Private declarations }
  public
    Rechteck:array of TIdRect; {Array of currently defined rectangles}
    ZAnzahlRechtecke:integer; {Number ot generate}
    NrRechtecke:integer;       {Current number of rectangles generated}
    AspectRatio:double;     {Rho: Rectangles satisfy  1/Rho<=Height/Width<=Rho}
    AreaRatio:double;       {Ypsilon:  Largest area/Smallest area <= Ypsilon}

    function Parameter:boolean;
    procedure AddRechteck(const NewId:String;R:Trect;sender:tobject);
    procedure MaxAreaRechteck(var newindex, newarea:integer);
    procedure RechteckZerlegen(dir:char; index, value:integer;sender:tobject);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.S13Click(Sender: TObject);
begin
   close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   randomize;
   button1click(sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
  clist:array of integer;
  listsize:integer;
  maxX, minX, MaxY, minY:integer;
  x,y:integer;
  j, index, M:integer;
  a,b,c,r:integer;
  OKFlag:integer;
begin
    If parameter then
    begin
      setlength(Rechteck, ZAnzahlRechtecke);
      NrRechtecke:=0;
      AddRechteck(inttostr(NrRechtecke+1),image1.clientrect,sender);

      while NrRechtecke<ZAnzahlRechtecke do
      begin
        MaxAreaRechteck(index,m); {"index  of the largest and its area "m"}
        setlength(clist,100);
        listsize:=0;
        for i:=0 to NrRechtecke-1 do
          with Rechteck[i] do
          begin
            if (area>2*m / arearatio) then
            begin
              If (2*H/aspectratio <= W) and (W <= 2*aspectratio*H)
                then OKFlag:=1
                else OKFlag:=0;
              If (2*W/aspectratio <= H) and (H <= 2*aspectratio*W)
                then inc(OKFlag,2);
              if OKFlag>0 then
              begin
                dec(OKflag);
                clist[listsize]:=10*i+OKFlag;
                inc(listsize);
              end;
            end;
          end;
        if listsize>0 then
        begin {there is at least one rectangle which can be split}
          i:=random(listsize);
          j:=clist[i] div 10;
          OKFlag:= clist[i] mod 10;

          if OKFlag=2 then OKFlag := random(2); {Can split either V or H, choose one}
          case OKFlag of
            0: {Vertical split line}
               Begin
                 with Rechteck[j] do
                 begin
                   a:=trunc(H/Aspectratio);
                   b:=trunc(W-H*Aspectratio);
                   c:=Trunc(m/(Arearatio*H));
                   minX:=max(max(a,b) ,c );
                   a:=trunc(H*AspectRatio);
                   b:=trunc(W-H/Aspectratio);
                   c:=trunc(W/2);

                   maxX:=min(min(a,b),c);
                   r:=minx+random(maxx-minx);
                   x:=left+r;
                 end;
                 if maxx>=minx then RechteckZerlegen('V', j, x,sender);// else showmessage('bad x?');
               end {Vertical split}
          else begin {Split horizontally}
                 with Rechteck[j] do
                 begin
                   a:=trunc(W / Aspectratio);
                   b:=trunc(H-W*Aspectratio);
                   c:=Trunc(m/(Arearatio*W));
                   minY:=max(max(a,b),c);
                   a:=trunc(W*AspectRatio);
                   b:=trunc(H-W/Aspectratio);
                   c:=trunc(H/2);
                   maxY:=min(min(a,b),c);
                   r:=miny+random(maxy-miny);
                   Y:=top+r;
                 end;
                 if maxy>=miny then RechteckZerlegen('H', j,y,sender);// else showmessage('bad y?');
               end; {horizontal split}
          end; {choose direction case}
        end
        else
        begin
          break;
        end;
      end;
    end;
end;

function TForm1.parameter:boolean;
begin
    with image1 do
    begin
      width:=round(spin2.value);
      picture.bitmap.width:=width;
      height:=round(spin3.value);
      picture.bitmap.height:=height;
      canvas.Rectangle(clientrect);
    end;
    NrRechtecke:=0;
    ZAnzahlRechtecke:=round(spin1.value);
    AspectRatio:=4;
    AreaRatio:=5;
    result:=true;
end;

procedure TForm1.AddRechteck(const NewId:String;R:Trect;sender:tobject);
var
  idRect:TIdRect;
begin
    if NrRechtecke<ZAnzahlRechtecke then
    begin
      with idrect do
      begin
        id:=newId;
        left:=r.left;
        top:=r.Top;
        right:=r.Right;
        bottom:=r.Bottom;
        W:=right-left;
        H:=bottom-top;
        Area:=W*H;
      end;
      Rechteck[NrRechtecke]:=IdRect;
      inc(NrRechtecke);
      drawrects(sender);
    end;
end;

procedure TForm1.MaxAreaRechteck(var newindex, newarea:integer);
  var i:integer;
  begin
    newarea:=0;
    for i:=0 to NrRechtecke-1 do
      with Rechteck[i] do
      begin
        if area>newarea then
        begin
          newarea:=area;
          newindex:=i;
        end;
      end;
  end;

procedure TForm1.drawrects;
const
    farben1 : array[0..5,1..3] of integer
            = ((100,104,0),(147,156,3),(206,204,0),(255,253,8),(255,255,98),(254,254,154));
    farben2 : array[0..6,1..3] of integer
            = ((47,104,1),(104,202,3),(97,211,28),(162,252,43),(150,250,117),(200,254,114),
               (210,250,164));
    farben3 : array[0..6,1..3] of integer
            = ((48,1,105),(103,0,203),(101,51,208),(155,49,255),(155,101,255),(202,105,247),
               (211,150,254));
var xoffset,yoffset,i,ff:integer;
    bitmap:tbitmap;
begin
   with image1, canvas do
     for i:=low(Rechteck) to NrRechtecke-1 do
     begin
       if random(100)+1>=round(spin4.value) then
         case Radiogroup1.itemindex of
           0 : brush.color:=rgb(255,random(255),random(255));
           1 : brush.color:=rgb(random(255),255,random(255));
           2 : brush.color:=rgb(random(255),random(255),255);
           3 : begin
                 ff:=55+random(200);
                 brush.color:=rgb(ff,ff,ff);
               end;
           4 : brush.color:=rgb(128,random(255),128);
           5 : brush.color:=rgb(random(255),128,128);
           6 : brush.color:=rgb(farben1[i mod 6,1],farben1[i mod 6,2],farben1[i mod 6,3]);
           7 : brush.color:=rgb(farben2[i mod 7,1],farben2[i mod 7,2],farben2[i mod 7,3]);
           8 : brush.color:=rgb(farben3[i mod 7,1],farben3[i mod 7,2],farben3[i mod 7,3]);
         end
       else brush.color:=clwhite;
       with Rechteck[i] do
       begin
         rectangle(left,top,right,bottom);
       end;
     end;
     if NrRechtecke=ZAnzahlRechtecke then
     begin
       xoffset:=(Paintbox1.width-image1.width) div 2;
       yoffset:=(Paintbox1.height-image1.height) div 2;
       bitmap:=tbitmap.create;
       bitmap.width:=Paintbox1.width;
       bitmap.height:=Paintbox1.height;
       bitmap.canvas.draw(xoffset,yoffset,image1.picture.bitmap);
       Paintbox1.canvas.draw(0,0,bitmap);
       bitmap.free;
     end;
end;

  procedure TForm1.RechteckZerlegen(dir:char; index, value:integer;sender:tobject);
  var
    x,y:integer;
    work1,work2:TIdRect;
  begin
    case dir of
    'V':
      begin
        x:=value;
        work1:=Rechteck[index];
        with work1 do
        begin
          right:=x;
          W:=right-left;
          Area:=W*H;
        end;
        work2:=Rechteck[index];
        with work2 do
        begin
          id:=inttostr(NrRechtecke+1);
          left:=x;
          W:=right-left;
          Area:=W*H;
        end;
      end;
      'H' :
      begin
        y:=value;
        work1:=Rechteck[index];
        with work1 do
        begin
          bottom:=y;
          H:=bottom-top;
          Area:=W*H;
        end;
        work2:=Rechteck[index];
        with work2 do
        begin
          id:=inttostr(NrRechtecke+1);
          top:=y;
          H:=bottom-top;
          Area:=W*H;
        end;
      end;
    end; {case}
    Rechteck[index]:=work1;
    Rechteck[NrRechtecke]:=work2;
    inc(NrRechtecke);
    drawrects(sender);
  end;

end.


