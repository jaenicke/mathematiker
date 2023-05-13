unit ukette;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ComCtrls, ExtCtrls, StdCtrls, Menus, RXSpin, RxGIF;

const max=15;
      xb=40;
      xc=8;
type
  Tnkette = class(TForm)
    P5: TPanel;
    kette: TPanel;
    D3: TButton;
    Memo2: TMemo;
    Panel15: TPanel;
    L2: TLabel;
    Image2: TImage;
    L4: TLabel;
    L5: TLabel;
    L6: TLabel;
    L7: TLabel;
    L8: TLabel;
    Panel16: TPanel;
    Pr1: TProgressBar;
    Pr2: TProgressBar;
    Pr3: TProgressBar;
    Pr4: TProgressBar;
    Pr5: TProgressBar;
    Pr6: TProgressBar;
    CB8: TCheckBox;
    CB9: TCheckBox;
    P7: TPanel;
    PB1: TPaintBox;
    L1: TLabel;
    L0: TLabel;
    r4: TRxSpinEdit;
    r5: TRxSpinEdit;
    MM1: TMainMenu;
    M11: TMenuItem;
    procedure S3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure Button3click(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure zeichnen(sender: tobject);
  private
    { Private-Deklarationen }
      zeile : array[1..max] of boolean;
      belegung : array[0..15,0..15] of integer;
  public
    { Public-Deklarationen }
  end;

var
  nkette: Tnkette;

implementation

{$R *.DFM}
var feld,feld2,zuege : integer;
const
    spielernr : integer=1;
    superfarben: array[0..29] of longint =
         ($00000000,$00800000,$000000FF,$00FF00FF,$00008000,$00800080,$0000FFFF,$00404040,
          $0000FF00,$00cccccc,$00808080,$00ff0000,$00000080,$00ffff00,$00008080,$00c0c0c0,
          $00808000,$000000c0,$0000c000,$00c00000,$0000c0c0,$00c000c0,$00c0c000,$00FFFFCC,
          $00CCFFFF,$00CCFFCC,$00CCCCFF,$00ffffff,$00cccc99,$00123456);

procedure Tnkette.S3Click(Sender: TObject);
begin
    close
end;

procedure Tnkette.FormCreate(Sender: TObject);
var i,j:integer;
begin
//    gifres(image2,'kette');
    for i:=1 to 15 do
      for j:=0 to 15 do belegung[i,j]:=0;
    for i:=1 to 6 do zeile[i]:=true;
    feld2:=4;
    feld:=round(r4.maxvalue);
    spielernr:=1;
    zuege:=0;
end;

procedure Tnkette.TrackBar4Change(Sender: TObject);
begin
    feld:=round(r4.value);
    button3click(sender);
end;

procedure Tnkette.TrackBar5Change(Sender: TObject);
begin
  feld2:=round(r5.value);
  button3click(sender);
end;

procedure Tnkette.Button3click(Sender: TObject);
var i,j:integer;
begin
    randomize;
    zuege:=0;
    spielernr:=1;
    for i:=0 to 15 do
      for j:=0 to 15 do belegung[i,j]:=0;
    for i:=1 to 6 do zeile[i]:=true;
    zeichnen(sender);
end;

procedure Tnkette.PB1Paint(Sender: TObject);
begin
 zeichnen(sender);
end;

procedure Tnkette.PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const a:array[1..8] of integer =(2,1,-1,-2,-2,-1,1,2);
      b:array[1..8] of integer =(1,2,2,1,-1,-2,-2,-1);
var li,ob,xx,yy,i,j,stack_:integer;
    hfeld:array[0..15,0..15] of boolean;

procedure test(xx,yy:integer);
var i,j,z:integer;
    v:boolean;
begin
    z:=belegung[xx,yy] mod 10;
    hfeld[xx,yy]:=true;
    v:=true;
    for i:=1 to feld do
      for j:=1 to feld do v:=v and hfeld[i,j];

    inc(stack_);
    if (stack_>120) or v then
    begin
      for i:=0 to feld do
        for j:=0 to feld do
        begin
          belegung[i,j]:=10*spielernr+(belegung[i,j] mod 10);
        end;
      exit;
    end;
    if z>1 then
    begin
      application.processmessages;
      if cb8.checked then zeichnen(sender);
      if (z=2) and (xx=1) and (yy=1) then
      begin
        belegung[1,1]:=0;
        belegung[1,2]:=10*spielernr+(belegung[1,2] mod 10)+1;
        test(1,2);
        belegung[2,1]:=10*spielernr+(belegung[2,1] mod 10)+1;
        test(2,1);
      end
      else
      begin
        if (z=2) and (xx=feld) and (yy=1) then
        begin
          belegung[feld,1]:=0;
          belegung[feld,2]:=10*spielernr+(belegung[feld,2] mod 10)+1;
          test(feld,2);
          belegung[feld-1,1]:=10*spielernr+(belegung[feld-1,1] mod 10)+1;
          test(feld-1,1);
        end
        else
        begin
          if (z=2) and (xx=feld) and (yy=feld) then
          begin
            belegung[feld,feld]:=0;
            belegung[feld,feld-1]:=10*spielernr+(belegung[feld,feld-1] mod 10)+1;
            test(feld,feld-1);
            belegung[feld-1,feld]:=10*spielernr+(belegung[feld-1,feld] mod 10)+1;
            test(feld-1,feld);
          end
          else
          begin
            if (z=2) and (xx=1) and (yy=feld) then
            begin
              belegung[1,feld]:=0;
              belegung[1,feld-1]:=10*spielernr+(belegung[1,feld-1] mod 10)+1;
              test(1,feld-1);
              belegung[2,feld]:=10*spielernr+(belegung[2,feld] mod 10)+1;
              test(2,feld);
            end
            else
            begin
              if (z=3) and (xx=1) {and (yy>1) and (yy<feld)} then
              begin
                belegung[1,yy]:=0;
                belegung[1,yy-1]:=10*spielernr+(belegung[1,yy-1] mod 10)+1;
                test(1,yy-1);
                belegung[1,yy+1]:=10*spielernr+(belegung[1,yy+1] mod 10)+1;
                test(1,yy+1);
                belegung[2,yy]:=10*spielernr+(belegung[2,yy] mod 10)+1;
                test(2,yy);
              end
              else
              begin
                if (z=3) and (xx=feld) {and (yy>1) and (yy<feld)} then
                begin
                  belegung[feld,yy]:=0;
                  belegung[feld,yy-1]:=10*spielernr+(belegung[feld,yy-1] mod 10)+1;
                  test(feld,yy-1);
                  belegung[feld,yy+1]:=10*spielernr+(belegung[feld,yy+1] mod 10)+1;
                  test(feld,yy+1);
                  belegung[feld-1,yy]:=10*spielernr+(belegung[feld-1,yy] mod 10)+1;
                  test(feld-1,yy);
                end
                else
                begin
                  if (z=3) and (yy=1) {and (xx>1) and (xx<feld) } then
                  begin
                    belegung[xx,1]:=0;
                    belegung[xx-1,1]:=10*spielernr+(belegung[xx-1,1] mod 10)+1;
                    test(xx-1,1);
                    belegung[xx+1,1]:=10*spielernr+(belegung[xx+1,1] mod 10)+1;
                    test(xx+1,1);
                    belegung[xx,2]:=10*spielernr+(belegung[xx,2] mod 10)+1;
                    test(xx,2);
                  end
                  else
                  begin
                    if (z=3) and (yy=feld)  {and (xx>1) and (xx<feld)} then
                    begin
                      belegung[xx,feld]:=0;
                      belegung[xx-1,feld]:=10*spielernr+(belegung[xx-1,feld] mod 10)+1;
                      test(xx-1,feld);
                      belegung[xx+1,feld]:=10*spielernr+(belegung[xx+1,feld] mod 10)+1;
                      test(xx+1,feld);
                      belegung[xx,feld-1]:=10*spielernr+(belegung[xx,feld-1] mod 10)+1;
                      test(xx,feld-1);
                    end
                    else
                    begin
                      if (z>=4) then
                      begin
                        belegung[xx,yy]:=0;
                        belegung[xx-1,yy]:=10*spielernr+(belegung[xx-1,yy] mod 10)+1;
                        test(xx-1,yy);
                        belegung[xx+1,yy]:=10*spielernr+(belegung[xx+1,yy] mod 10)+1;
                        test(xx+1,yy);
                        belegung[xx,yy-1]:=10*spielernr+(belegung[xx,yy-1] mod 10)+1;
                        test(xx,yy-1);
                        belegung[xx,yy+1]:=10*spielernr+(belegung[xx,yy+1] mod 10)+1;
                        test(xx,yy+1);
                      end;
                    end
                  end
                end
              end
            end
          end
        end
      end;
    end;
    dec(stack_);
end;

procedure test2;
var i,j,z,sieger:integer;
    bel:array[0..6] of integer;
    imspiel:integer;
begin
    for i:=0 to 6 do bel[i]:=0;
    for i:=1 to feld do
      for j:=1 to feld do
      begin
        z:=belegung[i,j] div 10;
        inc(bel[z]);
      end;
    sieger:=0;
    for i:=1 to 6 do
      if bel[i]=feld*feld then sieger:=i;
    if zuege>feld2 then
    begin
      imspiel:=0;
      for i:=1 to 6 do
        if bel[i]>0 then inc(imspiel);
      if imspiel=1 then
      begin
        for i:=1 to 6 do
          if bel[i]>0 then sieger:=i;
      end;

      if cb9.checked and (bel[1]=0) then
      begin
        showmessage('Sie haben gegen den Computer verloren! Neustart mittels Schalter');
      end;
    end;

    if sieger>0 then
    begin
      showmessage('Spieler '+inttostr(sieger)+' gewinnt! Neustart mittels Schalter');
    end
    else
    begin
      if zuege>feld2 then
      begin
        for i:=1 to 6 do
          if (bel[i]=0) then zeile[i]:=false;
      end;
      inc(spielernr);
      if spielernr>feld2 then spielernr:=1;
      while zeile[spielernr]=false do
      begin
        inc(spielernr);
        if spielernr>feld2 then spielernr:=1;
      end;
    end;
end;

procedure computergegner;
var g,i,j,w,maxx,xx,yy,anz:integer;
    mf:array[1..225] of integer;
    gefunden:boolean;
begin
    for g:=2 to feld2 do
    begin
      if zeile[g] then
      begin
        inc(zuege);
        for i:=1 to 225 do mf[i]:=-1;
        maxx:=0;
        for i:=1 to feld do
          for j:=1 to feld do
          begin
            if belegung[i,j]=0  then mf[(i-1)*15+j]:=0;
            if (belegung[i,j] div 10)=g then
            begin
              w:=belegung[i,j] mod 10;
              mf[(i-1)*15+j]:=w;
              if w>maxx then maxx:=w;
            end;
          end;
        anz:=0;
        for i:=1 to 225 do
          if mf[i]=maxx then inc(anz);
        anz:=random(anz)+1;
        i:=1;
        j:=0;
        gefunden:=false;
        repeat
          if mf[i]=maxx then
          begin
            inc(j);
            if j=anz then gefunden:=true;
          end;
          inc(i);
        until (i>225) or gefunden;
        if gefunden then
        begin
          dec(i);
          yy:=i mod 15;
          if yy=0 then yy:=15;
          xx:=1+((i-1) div 15);
          belegung[xx,yy]:=10*g+(belegung[xx,yy] mod 10)+1;
          stack_:=0;
          for i:=0 to 15 do
            for j:=0 to 15 do hfeld[i,j]:=false;
          test(xx,yy);
          test2;
        end;
        application.processmessages;
        zeichnen(sender);
      end;
    end;
end;

begin
    li:=(pb1.width-xb*feld) div 2;
    ob:=(pb1.height-xb*feld) div 2;
    xx:=(x-li+xb) div xb;
    yy:=(y-ob+xb) div xb;
    if (((belegung[xx,yy] div 10)=spielernr) or (belegung[xx,yy]=0))
          and (xx>0) and (xx<=feld) and (yy>0) and (yy<=feld) then
    begin
      inc(zuege);
      belegung[xx,yy]:=10*spielernr+(belegung[xx,yy] mod 10)+1;
      stack_:=0;
      for i:=0 to 15 do
        for j:=0 to 15 do hfeld[i,j]:=false;
      test(xx,yy);
      test2;
      zeichnen(sender);
      if cb9.Checked then computergegner;
    end;
end;

procedure tnkette.zeichnen(sender: tobject);
var Bitmap: TBitmap;
    myrect,birect:trect;
    b,h:integer;

procedure kettenreaktion;
var li,ob,i,j,gesamt:integer;
    stand:array[0..8] of integer;
begin
    for i:=0 to 8 do stand[i]:=0;
    gesamt:=0;
    li:=(b-xb*feld) div 2;
    ob:=(h-xb*feld) div 2;
    for i:=0 to feld-1 do
    begin
      for j:=0 to feld-1 do
      begin
        if (belegung[i+1,j+1] div 10)=spielernr then
               bitmap.canvas.brush.color:=claqua
        else
               bitmap.canvas.brush.color:=clwhite;
        bitmap.canvas.rectangle(li+i*xb,ob+j*xb,li+i*xb+xb+1,ob+j*xb+xb+1);
      end
    end;
    for i:=0 to feld-1 do
      for j:=0 to feld-1 do
      begin
        bitmap.canvas.brush.color:=superfarben[1+(belegung[i+1,j+1] div 10)];
        inc(stand[belegung[i+1,j+1] div 10],(belegung[i+1,j+1] mod 10));
        case (belegung[i+1,j+1] mod 10) of
          1 : begin
                bitmap.canvas.ellipse(li+i*xb+xc+2,ob+j*xb+xc+2,li+i*xb+xb-xc-1,ob+j*xb+xb-xc-1);
                inc(gesamt);
              end;
          2 : begin
                inc(gesamt,2);
                bitmap.canvas.ellipse(li+i*xb+4,ob+j*xb+4,li+i*xb+xb-15,ob+j*xb+xb-15);
                bitmap.canvas.ellipse(li+i*xb+xb-24,ob+j*xb+xb-24,li+i*xb+xb-3,ob+j*xb+xb-3);
              end;
          3..6 : begin
                inc(gesamt,3);
                bitmap.canvas.ellipse(li+i*xb+10,ob+j*xb+3,li+i*xb+xb-9,ob+j*xb+xb-16);
                bitmap.canvas.ellipse(li+i*xb+3,ob+j*xb+17,li+i*xb+22,ob+j*xb+xb-2);
                bitmap.canvas.ellipse(li+i*xb+17,ob+j*xb+17,li+i*xb+xb-2,ob+j*xb+xb-2);
              end;
        end;
      end;
      bitmap.canvas.brush.style:=bsclear;
      bitmap.canvas.TextOut(42,8,'nächster Spieler');
      bitmap.canvas.brush.color:=superfarben[spielernr+1];
      bitmap.canvas.ellipse(160,6,178,24);
      bitmap.canvas.brush.style:=bsclear;
      if gesamt>0 then
      begin
        pr1.position:=round(100*stand[1]/gesamt);
        pr2.position:=round(100*stand[2]/gesamt);
        pr3.position:=round(100*stand[3]/gesamt);
        pr4.position:=round(100*stand[4]/gesamt);
        pr5.position:=round(100*stand[5]/gesamt);
        pr6.position:=round(100*stand[6]/gesamt);
      end;
     if stand[1]>0 then l2.caption:=inttostr(stand[1])
                   else l2.caption:='---';
     if stand[2]>0 then l4.caption:=inttostr(stand[2])
                   else l4.caption:='---';
     if stand[3]>0 then l5.caption:=inttostr(stand[3])
                   else l5.caption:='---';
     if stand[4]>0 then l6.caption:=inttostr(stand[4])
                   else l6.caption:='---';
     if stand[5]>0 then l7.caption:=inttostr(stand[5])
                   else l7.caption:='---';
     if stand[6]>0 then l8.caption:=inttostr(stand[6])
                   else l8.caption:='---';
end;

begin
    Bitmap := TBitmap.Create;
    Bitmap.Width := pb1.Width;
    Bitmap.Height := pb1.Height;
    bitmap.canvas.font.name:='Verdana';
    bitmap.canvas.font.size:=10;
    birect.left:=1;
    birect.right:=pb1.width;
    birect.top:=1;
    birect.bottom:=pb1.height;
    myrect:=birect;
    setbkmode(bitmap.canvas.handle,transparent);
    b:=bitmap.width;
    h:=bitmap.height;
  try
    kettenreaktion;
    pb1.canvas.CopyRect(biRect,bitmap.Canvas, MyRect);
  finally
    Bitmap.Free;
  end;
end;

end.
