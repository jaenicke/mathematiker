unit utetris;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  ExtCtrls, StdCtrls;

type
 TBoard=array[-4..19,0..9] of integer;
 TOrientation=(toleft,toright,todown,torotate);
 TPiece=
  record
   matrix:array[0..3,0..3] of smallint;
   width:integer;
   height:integer;
  end;
 PPiece=^TPiece;
 TPieceKey=record
  key1,key2,key3:integer;
 end;
type
  TGBoard = class(TForm)
    PB1: TPaintBox;
    S1: TShape;
    L1: TLabel;
    S2: TShape;
    L2: TLabel;
    PB2: TPaintBox;
    L5: TLabel;
    L9: TLabel;
    S4: TShape;
    S5: TShape;
    L8: TLabel;
    L6: TLabel;
    L7: TLabel;
    S6: TShape;
    L4: TLabel;
    L3: TLabel;
    MM1: TMainMenu;
    M1: TMenuItem;
    M2: TMenuItem;
    procedure PB1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PB2Paint(Sender: TObject);
    procedure M2C(Sender: TObject);
    procedure M1C(Sender: TObject);
  private
   fboard: TBoard;
   fposcol,fposrow,foffx,foffy:integer;
   fscore:integer;
   flines:integer;
   flevel:integer;
   ftime:longword;
   fpieceplaced,fterminate:boolean;
   fcurpiece,fnextpiece:TPieceKey;
  protected
   function GetCellRect(arow,acol:integer):TRect;
   function GetPreviewCellRect(arow,acol:integer):TRect;
   function CanPutPiece(apiece:PPiece;arow,acol:integer):boolean;
   function ClearLines:integer;
   procedure InvalidatePiece(arow,acol:integer);
   procedure InvalidatePreviewGrid;
   procedure PutPiece(apiece:PPiece;arow,acol:integer;ainv:boolean=true);
   procedure ClearPiece(apiece:PPiece;arow,acol:integer;ainv:boolean=true);
   procedure MovePiece(aOrientation:TOrientation);
   procedure Initialize;
   procedure GameLoop;
   procedure WndProc(var msg:TMessage);override;
  public
  end;

const
 CELL_SIZE         :integer=21;
 PREVIEW_CELL_SIZE :integer=17;
 ROW_CNT           :integer=20;
 COL_CNT           :integer=10;
 CLR_CNT           :integer=10;
 PIECE_SIZE        :integer= 4;
 LINE_SCORE        :integer=10;
 BONUS_SCORE       :integer=20;
 WM_STARTGAME :longword =WM_USER+1;
 COLORS   :array[1..10] of TColor =
 (clred,clyellow,clTeal,clblue,clPurple,cllime,clFuchsia,clAqua,clMaroon,clSilver);
 PIECES   :array[0..6,0..3] of TPiece=
 (
  (
   (matrix :((1,0,0,0),(1,0,0,0),(1,0,0,0),(1,0,0,0));width:1;height:4),
   (matrix :((1,1,1,1),(0,0,0,0),(0,0,0,0),(0,0,0,0));width:4;height:1),
   (matrix :((1,0,0,0),(1,0,0,0),(1,0,0,0),(1,0,0,0));width:1;height:4),
   (matrix :((0,0,0,0),(1,1,1,1),(0,0,0,0),(0,0,0,0));width:4;height:1)
  ),
  (
   (matrix :((1,0,0,0),(1,0,0,0),(1,1,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((0,0,1,0),(1,1,1,0),(0,0,0,0),(0,0,0,0));width:3;height:2),
   (matrix :((1,1,0,0),(0,1,0,0),(0,1,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((1,1,1,0),(1,0,0,0),(0,0,0,0),(0,0,0,0));width:3;height:2)
  ),
  (
   (matrix :((0,1,0,0),(0,1,0,0),(1,1,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((1,1,1,0),(0,0,1,0),(0,0,0,0),(0,0,0,0));width:3;height:2),
   (matrix :((1,1,0,0),(1,0,0,0),(1,0,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((1,0,0,0),(1,1,1,0),(0,0,0,0),(0,0,0,0));width:3;height:2)
  ),
  (
   (matrix :((1,0,0,0),(1,1,0,0),(0,1,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((0,1,1,0),(1,1,0,0),(0,0,0,0),(0,0,0,0));width:3;height:2),
   (matrix :((1,0,0,0),(1,1,0,0),(0,1,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((0,1,1,0),(1,1,0,0),(0,0,0,0),(0,0,0,0));width:3;height:2)
  ),
  (
   (matrix :((0,1,0,0),(1,1,0,0),(1,0,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((1,1,0,0),(0,1,1,0),(0,0,0,0),(0,0,0,0));width:3;height:2),
   (matrix :((0,1,0,0),(1,1,0,0),(1,0,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((1,1,0,0),(0,1,1,0),(0,0,0,0),(0,0,0,0));width:3;height:2)
  ),
  (
   (matrix :((0,1,0,0),(1,1,1,0),(0,0,0,0),(0,0,0,0));width:3;height:2),
   (matrix :((0,1,0,0),(1,1,0,0),(0,1,0,0),(0,0,0,0));width:2;height:3),
   (matrix :((1,1,1,0),(0,1,0,0),(0,0,0,0),(0,0,0,0));width:3;height:2),
   (matrix :((1,0,0,0),(1,1,0,0),(1,0,0,0),(0,0,0,0));width:2;height:3)
  ),
  (
   (matrix :((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)); width:2;height:3),
   (matrix :((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)); width:2;height:3),
   (matrix :((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)); width:2;height:3),
   (matrix :((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)); width:2;height:3)
  ) );

var
 GBoard: TGBoard;

implementation

uses math;

{$R *.DFM}
const sofortabbruch : boolean = false;

procedure TGBoard.Initialize;
begin
  foffx:=PB1.left;
  foffy:=PB1.top;
  fposrow:=-4;
  fposcol:=5;
  fscore:=0;
  flines:=0;
  flevel:=0;
  ftime:=400;
  fterminate:=false;
  fpieceplaced:=false;
  L4.visible:=false;
end;

procedure TGBoard.WndProc(var msg:TMessage);
begin
  case Msg.Msg of
     WM_CLOSE: begin
                 if not sofortabbruch then sofortabbruch:=true;
                 close;
               end
   Else
     inherited;
   if msg.msg=WM_STARTGAME then GameLoop;
  end;
end;

procedure TGBoard.MovePiece(aOrientation:TOrientation);
var
 acurpiece:PPiece;
begin
  acurpiece:= @PIECES[fcurpiece.key1,fcurpiece.key2];
  ClearPiece(acurpiece,fposrow,fposcol);
  case aOrientation of
      toleft:
        if CanPutPiece(acurpiece,fposrow,fposcol-1) then fposcol:=fposcol-1;
      toright:
        if CanPutPiece(acurpiece,fposrow,fposcol+1) then fposcol:=fposcol+1;
      todown:
        if CanPutPiece(acurpiece,fposrow+1,fposcol) then fposrow:=fposrow+1
          else fpieceplaced:=true;
      torotate:
        if CanPutPiece(@PIECES[fcurpiece.key1,(fcurpiece.key2+1) mod 4],fposrow,fposcol) then begin
          fcurpiece.key2:=(fcurpiece.key2+1) mod 4;
          acurpiece:= @PIECES[fcurpiece.key1,fcurpiece.key2];
        end;
  end;
  putpiece(acurpiece,fposrow,fposcol);
end;

function TGBoard.GetCellRect(arow,acol:integer):TRect;
begin
  SetRect(result,-1,-1,-1,-1);
  if (arow<0) or (arow>ROW_CNT) or (acol<0) or (acol>COL_CNT) then exit;
  result.left:=(PB1.width div COL_CNT)*acol+1;
  result.top:=(PB1.Height div ROW_CNT)*arow+1;
  result.right:=result.left+CELL_SIZE;
  result.bottom:=result.top+CELL_SIZE;
end;

function TGBoard.GetPreviewCellRect(arow,acol:integer):TRect;
begin
  SetRect(result,-1,-1,-1,-1);
  if (arow<0) or (arow>PIECE_SIZE) or (acol<0) or (acol>PIECE_SIZE) then exit;
  result.left:=(PB2.width div PIECE_SIZE)*acol+1;
  result.top:=(PB2.Height div PIECE_SIZE)*arow+1;
  result.right:=result.left+PREVIEW_CELL_SIZE;
  result.bottom:=result.top+PREVIEW_CELL_SIZE;
end;

procedure TGBoard.PB1Paint(Sender: TObject);
var
 tmprect:TRect;
 i,j,hdc:integer;
begin
  PB1.Canvas.Pen.Color:=clred;
  PB1.Canvas.Rectangle(0,0,PB1.width,PB1.Height);
  hdc:=PB1.canvas.handle;
  for i:=0 to 19 do
    for j:=0 to 9 do begin
      if fboard[i,j]>0 then begin
        PB1.canvas.Brush.Color:=COLORS[fboard[i,j]];
        tmprect:=GetCellRect(i,j);
        PB1.Canvas.Rectangle(tmprect);
        DrawEdge(hdc,tmprect,EDGE_BUMP,BF_RECT or BF_SOFT);
      end
    end;
end;

procedure TGBoard.InvalidatePreviewGrid;
var
 tmprect:TRect;
begin
  tmprect.left:=PB2.left;
  tmprect.top:=PB2.top;
  tmprect.right:=tmprect.left+PB2.width;
  tmprect.bottom:=tmprect.top+PB2.height;
  InvalidateRect(handle,@tmprect,false);
end;

procedure TGBoard.InvalidatePiece(arow,acol:integer);
var
 i,j:integer;
 tmprect:TRect;
begin
  SetRectEmpty(tmprect);
  for i:=-1 to 3 do
    for j:=-1 to 4 do
      UnionRect(tmprect,tmprect,getcellrect(arow+i,acol+j));
  offsetrect(tmprect,foffx,foffy);
  invalidaterect(handle,@tmprect,false);
end;

function TGBoard.ClearLines:integer;
var
 i,j,k,l:integer;
 tmprect:TRect;
begin
  result:=0;
  l:=ROW_CNT-1;
  for i:=ROW_CNT-1 downto 0 do begin
    k:=0;
    for j:=COL_CNT-1 downto 0 do
      if(fboard[i,j]>0) then k:=k+1;
    if k=COL_CNT then
      result:=result+1
    else begin
      for k:=0 to COL_CNT-1 do
        fboard[l,k]:=fboard[i,k];
      l:=l-1;
    end;
  end;
  tmprect.left:=foffx;
  tmprect.top:=foffy;
  tmprect.right:=tmprect.left+PB1.Width;
  tmprect.bottom:=tmprect.top+PB1.height;
  if result>0 then
    InvalidateRect(handle,@tmprect,false);
end;

function TGBoard.CanPutPiece(apiece:PPiece;arow,acol:integer):boolean;
var
 i,j,k:integer;
 broke:boolean;
begin
  result:=false;k:=0;
  if (arow<-4) or (acol<0) then exit;
  for i:=0 to 3 do begin
    broke:=false;
    for j:=0 to 3 do begin
      if ((arow+i<ROW_CNT) and
         (acol+j<COL_CNT) and
         (fboard[arow+i,acol+j]=0)) or (apiece.matrix[i,j]=0) then k:=k+1
      else begin
        broke:=false;
        break;
      end;
    end;
    if broke then break;
  end;
  if k=16 then result:=true;
end;

procedure TGBoard.PutPiece(apiece:PPiece;arow,acol:integer;ainv:boolean=true);
var
 i,j:integer;
begin
  for i:=0 to 3 do
    for j:=0 to 3 do
      if (arow+i<ROW_CNT) and (acol+j<COL_CNT) and (apiece.matrix[i,j]=1) then
        fboard[arow+i,acol+j]:=apiece.matrix[i,j]*fcurpiece.key3;
  if ainv then InvalidatePiece(arow,acol);
end;

procedure TGBoard.ClearPiece(apiece:PPiece;arow,acol:integer;ainv:boolean=true);
var
 i,j:integer;
begin
  for i:=0 to 3 do
    for j:=0 to 3 do
      if (arow+i<ROW_CNT) and (acol+j<COL_CNT) and (apiece.matrix[i,j]=1) then
  fboard[arow+i,acol+j]:=0;
end;

procedure TGBoard.FormCreate(Sender: TObject);
begin
  Initialize;
  doublebuffered:=true;
  postMessage(handle,WM_STARTGAME,0,0);
end;

procedure TGBoard.GameLoop;
var
 atime:longword;
 alinecnt:integer;
begin
  sofortabbruch:=false;
  Randomize;
  fcurpiece.key1:=Random(7);
  fcurpiece.key2:=Random(4);
  fcurpiece.key3:=Random(CLR_CNT)+1;
  fnextpiece.key1:=Random(7);
  fnextpiece.key2:=Random(4);
  fnextpiece.key3:=Random(CLR_CNT)+1;
  atime:=GettickCount;
  while not fterminate do begin
    Application.ProcessMessages;
    if sofortabbruch then exit;
    if (Gettickcount-atime)>ftime then begin
      MovePiece(todown);
      atime:=GetTickCount;
    end;
    if fpieceplaced then begin
      if fposrow<0 then begin
        L4.visible:=true;
        fterminate:=true;
        break;
      end;
      alinecnt:=ClearLines;
      if alinecnt>0 then begin
        fscore:=fscore+alinecnt*LINE_SCORE;
        fscore:=fscore+(alinecnt-1)*BONUS_SCORE;
        flines:=flines+alinecnt;
        if fscore>=(flevel+1)*500 then begin
          flevel:=flevel+1;
          ftime:=max(ftime-25,25);
        end;
        L9.caption:=inttostr(fscore);
        L8.caption:=inttostr(flines);
        L7.Caption:=inttostr(flevel);
      end;
      fposrow:=-4;fposcol:=5;
      fpieceplaced:=false;
      fcurpiece:=fnextpiece;
      fnextpiece.key1:=Random(7);
      fnextpiece.key2:=Random(4);
      fnextpiece.key3:=Random(CLR_CNT)+1;
      InvalidatePreviewGrid;
    end;
  end;
end;

procedure TGBoard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fterminate:=true;
end;

procedure TGBoard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if fterminate then exit;
  if key=VK_DOWN then
    MovePiece(todown)
  else
    if key=VK_LEFT then
      MovePiece(toLeft)
    else
      if key=VK_RIGHT then
        MovePiece(toright)
      else
        if key=VK_SPACE then
          MovePiece(torotate);
end;

procedure TGBoard.PB2Paint(Sender: TObject);
var
 tmprect:TRect;
 i,j,hdc:integer;
 apiece:PPiece;
begin
  PB2.Canvas.Pen.Color:=clred;
  PB2.Canvas.Rectangle(0,0,PB2.width,PB2.Height);
  hdc:=PB2.canvas.handle;
  apiece:=@PIECES[fnextpiece.key1,fnextpiece.key2];
  PB2.canvas.Brush.Color:=COLORS[fnextpiece.key3];
  for i:=0 to PIECE_SIZE-1 do
    for j:=0 to PIECE_SIZE-1 do begin
      if apiece.matrix[i,j]>0 then begin
        tmprect:=GetPreviewCellRect(i,j);
        PB2.Canvas.Rectangle(tmprect);
        DrawEdge(hdc,tmprect,EDGE_BUMP,BF_RECT or BF_SOFT);
      end
    end;
end;

procedure TGBoard.M2C(Sender: TObject);
var i,j:integer;
begin
  if not sofortabbruch then sofortabbruch:=true;
  foffx:=PB1.left;
  foffy:=PB1.top;
  fposrow:=-4;
  fposcol:=5;
  fscore:=0;
  flines:=0;
  flevel:=0;
  ftime:=400;
  fterminate:=false;
  fpieceplaced:=false;
  L4.visible:=false;
  L9.caption:=inttostr(fscore);
  L8.caption:=inttostr(flines);
  L7.Caption:=inttostr(flevel);
  for i:=-4 to 19 do
    for j:=0 to 9 do fboard[i,j]:=0;
  PB1.canvas.brush.color:=clblack;
  PB1paint(sender);
  postMessage(handle,WM_STARTGAME,0,0);
end;

procedure TGBoard.M1C(Sender: TObject);
begin
  if not sofortabbruch then sofortabbruch:=true;
  close;
end;

end.
