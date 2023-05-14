unit uGo3;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TstoneColor=(black,white,empty,invalid);
  TStoneRec = record
    occupiedBy:TstoneColor;
    blocknbr:integer;
  end;

  TBoard=array[0..18,0..18] of TStonerec;

  TBlock=class(TObject)
    id:integer;
    color:TStonecolor;
    openedges:integer;
    stonelist:TStringlist;
    constructor Create;
    Destructor Destroy;  override;
  end;

  Tfgo = class(TForm)
    SD1: TSaveDialog;
    OD1: TOpenDialog;
    Panel1: TPanel;
    Label7: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    S2: TShape;
    RG1: TRadioGroup;
    Panel2: TPanel;
    Im1: TImage;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label6: TLabel;
    Checkbox1: TComboBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure Im1MU(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D2C(Sender: TObject);
    procedure G1C(Sender: TObject);
    procedure D3C(Sender: TObject);
    procedure D4C(Sender: TObject);
    procedure D5C(Sender: TObject);
    procedure CB1C(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    board:TBoard;
    saveboard:TBoard;
    prevboard: array[black..white] of TBoard;
    hlines,vlines:integer;
    hincr, vincr:integer;
    xstart, ystart:integer;
    tokensizex, tokensizey:integer;
    playerColor:TStoneColor;
    nonplayerColor:TStoneColor;
    score: array [black..white] of  integer;
    boardcolor:TColor;

    nbrblocks:integer;
    blocks: array of TBlock;
    savescore:integer;

    procedure resetboard;
    procedure changeplayer;
    procedure updatescore(const col,row:integer);
    procedure drawstone(const col,row:integer);
    procedure DrawAllStones;
    procedure findblocks;
    procedure drawboard;
    procedure copyboard (var source,dest:TBoard);
    function  sameboard({const} b1,b2:TBoard):boolean;
    procedure loadfile(filename:string);
  end;

var
  fgo: Tfgo;

implementation

{$R *.DFM}

    constructor TBlock.create;
    begin
      inherited;
      openedges:=0;
      color:=empty;
      id:=0;
      stonelist:=TStringlist.create;
      stonelist.sorted:=true;
      stonelist.duplicates:=dupignore;
    end;

    destructor TBlock.destroy;
    begin
      stonelist.free;
      inherited;
    end;

procedure Tfgo.copyboard (var source,dest:TBoard);
begin
  move(source,dest,sizeof(source));
end;

function Tfgo.sameboard({const} b1,b2:TBoard):boolean;
var
  i,j:integer;
begin
  result:=true;
  for i:=0 to vlines-1 do begin
    for j:= 0 to hlines-1 do begin
      if b1[i,j].occupiedby<>b2[i,j].occupiedby then begin
        result:=false;
        break;
      end;
    end;
    if not result then break;
  end;
end;

procedure Tfgo.drawboard;
var
  i:integer;
  x,y:integer;
begin
  with im1,Canvas do begin
    brush.color:=boardcolor;
    rectangle(clientrect);
    for i:=0 to hlines-1 do begin
      y:= ystart+i*vincr;
      moveto(xstart,y);
      lineto(xstart+(vlines-1)*hincr,y);
    end;
    for i:=0 to vlines-1 do begin
      x:= xstart+i*hincr;
      moveto(x,ystart);
      lineto(x,ystart+(hlines-1)*vincr);
    end;
  end;
end;

procedure Tfgo.drawstone(const col,row:integer);
var
  offsetxleft, offsetxright:integer;
  offsetyup, offsetydown:integer;
begin
  with im1, canvas do begin
    if board[col,row].occupiedby=empty then begin
      brush.color:=boardcolor;
      pen.color:=boardcolor;
      ellipse(xstart+col*hincr-tokensizex,
         ystart+row*vincr-tokensizey,
         xstart+col*hincr+tokensizex+1,
         ystart+row*vincr+tokensizey+1);
      pen.color:=clblack;
      if col = 0 then offsetxleft:=0
                 else offsetxleft:=tokensizex;
      if col=vlines-1 then offsetxright:=0
                      else offsetxright:=tokensizex;
      if row = 0 then offsetyup:=0
                 else offsetyup:=tokensizey;
      if row=hlines-1 then offsetydown:=0
                      else offsetydown:=tokensizey;
      moveto(xstart+(col)*hincr-offsetxleft,
                   ystart+row*vincr);
      lineto(xstart+(col)*hincr+offsetxright,
                   ystart+row*vincr);
      moveto(xstart+(col)*hincr,
           ystart+row*vincr-offsetyup);
      lineto(xstart+(col)*hincr,
           ystart+row*vincr+offsetydown);
    end else begin
      If board[col,row].occupiedby=white then brush.color:=clwhite
                                         else brush.color:=clblack;
      ellipse(xstart+col*hincr-tokensizex,
         ystart+row*vincr-tokensizey,
         xstart+col*hincr+tokensizex+1,
         ystart+row*vincr+tokensizey+1);
    end;
  end;
end;

procedure Tfgo.DrawAllStones;
var
  i,j:integer;
begin
  for i:=0 to vlines-1 do
    for j:=0 to vlines-1 do
      drawstone(i,j);
end;

procedure Tfgo.Im1MU(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  col,row:integer;
   p1,p2: integer;
begin
  col:=x div hincr;
  row:=y div vincr;
  if (button=mbleft) and (board[col,row].occupiedby=empty) then begin
    copyboard(board,saveboard);
    savescore:=score[playercolor];
    board[col,row].occupiedby:=playerColor;
    p1:=score[playercolor];
    updatescore(col,row);
    p2:=score[playercolor];
    if board[col,row].occupiedby<>empty then begin
      if sameboard(board,prevboard[playercolor]) and (p2-p1=1) then begin
        copyboard(saveboard,board);
        score[playercolor]:=savescore;
        drawAllstones;
        showmessage('Ko-Zug ist nicht möglich') ;
      end else begin
        copyboard(board,prevboard[playercolor]);
        changeplayer;
      end;
    end;
  end
end;

procedure Tfgo.D2C(Sender: TObject);
begin
  prevboard[playercolor][0,0].occupiedby:=invalid;
  changeplayer;
end;

procedure Tfgo.resetboard;
var i,j:integer;
begin
  case RG1.itemindex of
    0: begin
        hlines:=9;
        vlines:=9;
      end;
    1: begin
        hlines:=13;
        vlines:=13;
      end;
    2: begin
        hlines:=19;
        vlines:=19;
      end;
  end;
  for i:=0 to hlines-1  do
    for j:=0 to vlines-1 do
      with board[i,j] do begin
        occupiedby:=empty;
        blocknbr:=0;
        prevboard[black][i,j].occupiedby:=empty;
        prevboard[white][i,j].occupiedby:=empty;
      end;
  playerColor:=white;
  changeplayer;
  hincr:=im1.width div vlines;
  tokensizex:= hincr div 2 -1;
  vincr:=im1.height div hlines;
  tokensizey:= vincr div 2 -1;
  xstart:=hincr div 2;
  ystart:=vincr div 2;
  prevboard[black][0,0].occupiedby:=invalid;
  prevboard[white][0,0].occupiedby:=invalid;
  drawboard;
  score[white]:=0;
  score[black]:=0;
  if nbrblocks>0 then
    for i:=0 to nbrblocks-1 do blocks[i].free;
  nbrblocks:=0;
  setlength(blocks,10);
end;

procedure Tfgo.changeplayer;
begin
  nonplayerColor:=playerColor;
  if playerColor=white then playerColor:=black else playerColor:=white;
  if playerColor=white then begin
    Label7.caption:='Weiß setzt';
    s2.brush.color:=clwhite;
  end else begin
    Label7.caption:='Schwarz setzt';
    s2.brush.color:=clblack;
  end;
end;

procedure Tfgo.UpdateScore(const col,row:integer);
var
  i,j:integer;
  newscore:integer;
  possibleSuicide:boolean;
  s:string;
  col2,row2:integer;
begin
  newscore:=0;
  possibleSuicide:=false;
  findblocks;
  i:=0;
  while i<=nbrblocks-1 do
    with blocks[i] do begin
      if openedges=0 then begin
        if (color<>board[col,row].occupiedby)  {and (openedges=0)} then begin
          newscore:=newscore+stonelist.count;
          for j:=0 to stonelist.count-1 do
            with stonelist do begin
              s:=strings[j];
              col2:=strtoint(copy(s,1,2));
              row2:=strtoint(copy(s,3,2));
              with board[col2,row2] do begin
                prevboard[playercolor][col2,row2].occupiedby:=empty;
                occupiedby:=empty;
                blocknbr:=0;
                drawstone(i,j);
              end;
            end;
          blocks[i].free;
          for j:=i to nbrblocks-2 do blocks[j]:=blocks[j+1];
          dec(nbrblocks);
        end else begin
          if color=board[col,row].occupiedby then possiblesuicide:=true;
          inc(i);
        end;
      end
      else inc(i);
    end;
    if (newscore =0) and (possibleSuicide) then begin
      board[col,row].occupiedby:=empty;
      board[col,row].blocknbr:=0;
      showmessage('Selbstmordzug nicht möglich!');
      prevboard[playercolor][0,1].occupiedby:=invalid;
    end;
    DrawAllStones;
    inc(score[playercolor],newscore);
    label5.caption:=inttostr(score[white]);
    label1.caption:=inttostr(score[black]);
end;

procedure Tfgo.G1C(Sender: TObject);
begin
  resetboard;
end;

procedure Tfgo.D3C(Sender: TObject);
begin
  copyboard(saveboard,board);
  score[nonplayercolor]:=savescore;
  label5.caption:=inttostr(score[white]);
  label1.caption:=inttostr(score[black]);
  drawAllstones;
  changeplayer;
  prevboard[black][0,0].occupiedby:=invalid;
  prevboard[white][0,0].occupiedby:=invalid;
end;

procedure Tfgo.D4C(Sender: TObject);
var
  i,j:integer;
  f:textfile;
begin
  If SD1.execute then begin
    assignfile(f,SD1.filename);
    rewrite(f);
    writeln(f,RG1.itemindex, ' ', ord(playercolor), ' ',0,
                ' ', score[black], ' ', score[white]);
    for i:=0 to hlines-1 do
      for j:=0 to vlines-1 do
      with board[i,j] do writeln(f,ord(occupiedby), ' ',blocknbr);
    closefile(f);
  end;
end;

procedure Tfgo.D5C(Sender: TObject);
begin
  im1.onmouseup:=nil;
  If OD1.execute then begin
    loadfile(OD1.filename);
    application.processmessages;
  end;
  im1.onmouseup:=Im1MU;
end;

procedure Tfgo.loadfile(filename:string);
var
  i,j,k,b,w:integer;
  f:textfile;
  stonecolor:integer;
begin
  assignfile(f,OD1.filename);
  reset(f);
  readln(f,i,j,k,b,w);
  RG1.itemindex:=i;
  resetboard;
  playercolor:=TStonecolor(j);
  score[black]:=b;
  score[white]:=w;
  for i:=0 to hlines-1 do
    for j:=0 to vlines-1 do
      with board[i,j] do begin
        readln(f,stonecolor, blocknbr);
        occupiedby:=TStonecolor(stonecolor);
      end;
  closefile(f);
  drawallstones;
  label5.caption:=inttostr(score[white]);
  label1.caption:=inttostr(score[black]);
end;

procedure tfgo.findblocks;

  procedure findblocksfrom(col,row:integer);
  var
     c1,r1:integer;
     index:integer;
    function check(c1,r1:integer; msg:string):boolean;
    begin
      result:=false;
      with blocks[nbrblocks-1] do
      if (board[c1,r1].occupiedby=board[col,row].occupiedby) then begin
        if (board[c1,r1].blocknbr<>board[col,row].blocknbr) then begin
          if board[c1,r1].blocknbr=0 then begin
            board[c1,r1].blocknbr:=board[col,row].blocknbr;
            stonelist.add(format('%2d%2d',[c1,r1]));
            result:=true;
          end
        end
        else
          if not stonelist.find(format('%2d%2d',[c1,r1]),index) then begin
            stonelist.add(format('%2d%2d',[c1,r1]));
            result:=TRUE;
          end;
      end
      else if board[c1,r1].occupiedby=empty then inc(openedges);
    end;
  begin
    c1:=col-1;
    r1:=row;
    if (c1>=0) and (check(c1,r1,'left of')) then findblocksfrom(c1,r1);
    c1:=col;
    r1:=row-1;
    if (r1>=0) and (check(c1,r1,'above')) then findblocksfrom(c1,r1);
    c1:=col+1;
    r1:=row;
    if (c1<vlines) and (check(c1,r1,'right of')) then findblocksfrom(c1,r1);
    c1:=col;
    r1:=row+1;
    if (r1<hlines) and (check(c1,r1,'below')) then findblocksfrom(c1,r1);
  end;
var
  i,j:integer;
begin
  for i:=0 to vlines-1 do
    for j:= 0 to hlines-1 do
      with board[i,j] do blocknbr:=0;
  for i:=0 to nbrblocks-1 do blocks[i].free;
  nbrblocks:=0;
  for i:=0 to vlines-1 do
    for j:= 0 to hlines-1 do
      if board[i,j].occupiedby<>empty then begin
        if board[i,j].blocknbr=0 then begin
          inc(nbrblocks);
          if nbrblocks<length(blocks) then setlength(blocks,nbrblocks+10);
          blocks[nbrblocks-1]:=TBlock.create;
          with blocks[nbrblocks-1] do begin
            id:=nbrblocks;
            color:=board[i,j].occupiedby;
            stonelist.add(format('%2d%2d',[i,j]));
            board[i,j].blocknbr:=nbrblocks;
            findblocksfrom(i,j);
          end;
        end;
      end;
end;

procedure Tfgo.CB1C(Sender: TObject);
var
  i,j,b,w,lnr,sel:integer;
  stonecolor:integer;
  liste:tstringlist;
  s:string;
begin
  sel:=Checkbox1.itemindex;
  if sel>0 then begin
    im1.onmouseup:=nil;
    liste:=tstringlist.create;
    lnr:=0;
    if sel=1 then liste.assign(listbox1.Items)
             else liste.assign(listbox2.Items);
    s:=liste[lnr];
    inc(lnr);
    i:=strtoint(copy(s,1,pos(' ',s)-1));
    delete(s,1,pos(' ',s));
    j:=strtoint(copy(s,1,pos(' ',s)-1));
    delete(s,1,pos(' ',s));
    delete(s,1,pos(' ',s));
    b:=strtoint(copy(s,1,pos(' ',s)-1));
    delete(s,1,pos(' ',s));
    w:=strtoint(s);
    RG1.itemindex:=i;
    resetboard;
    playercolor:=TStonecolor(j);
    score[black]:=b;
    score[white]:=w;
    for i:=0 to hlines-1 do
      for j:=0 to vlines-1 do
        with board[i,j] do begin
          s:=liste[lnr]; inc(lnr);
          stonecolor:=strtoint(copy(s,1,pos(' ',s)-1));
          delete(s,1,pos(' ',s));
          blocknbr:=strtoint(s);
          occupiedby:=TStonecolor(stonecolor);
        end;
    drawallstones;
    label5.caption:=inttostr(score[white]);
    label1.caption:=inttostr(score[black]);
    liste.free;
    im1.onmouseup:=Im1MU;
  end;
end;

procedure Tfgo.FormShow(Sender: TObject);
begin
  panel2.color:=rgb(240,240,180);
  boardcolor:=rgb(240,240,180);
  im1.top:=10;
  im1.height:=panel2.height-20;
  im1.width:=im1.height;
  im1.left:=(panel2.width-im1.width) div 2;
  resetboard;
end;

end.
