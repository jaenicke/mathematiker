unit logik;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ToolWin, ComCtrls, grundx, grund,
  htmlhelp, clipbrd, inifiles, StdCtrls, Menus, Sizetask,
  printers, udruckein2, info2, Grids, RxGIF, DsFancyButton, RXSpin, ExtDlgs;

const puzzlebilder = 107;

type
  TDigit = 0..9;
  TSuValues = set of TDigit;

  TData = record
    Count : integer;
    Values : TSuValues;
    end;

  TDigitGrid = array [1..9,1..9] of TDigit;
  TDataGrid = array [1..9,1..9] of TData;

  TGridStackEntry = record
    r,c    : integer;
    CField : TData;
    DGrid  : TDigitGrid;
    end;

  TGridStack = array [1..81] of TGridStackEntry;

  TForm1 = class(TForm)
    PM1: TPopupMenu;
    M35: TMenuItem;
    MM1: TMainMenu;
    M33: TMenuItem;
    M2: TMenuItem;
    M17: TMenuItem;
    M22: TMenuItem;
    M14: TMenuItem;
    M9: TMenuItem;
    M23: TMenuItem;
    M31: TMenuItem;
    M8: TMenuItem;
    N1: TMenuItem;
    M1: TMenuItem;
    M5: TMenuItem;
    M26: TMenuItem;
    N2: TMenuItem;
    M18: TMenuItem;
    N3: TMenuItem;
    M12: TMenuItem;
    N4: TMenuItem;
    M3: TMenuItem;
    M6: TMenuItem;
    M11: TMenuItem;
    M19: TMenuItem;
    M21: TMenuItem;
    N5: TMenuItem;
    M20: TMenuItem;
    M27: TMenuItem;
    N6: TMenuItem;
    M29: TMenuItem;
    N7: TMenuItem;
    M16: TMenuItem;
    M28: TMenuItem;
    M13: TMenuItem;
    M15: TMenuItem;
    Sizer1: TSizer;
    N8: TMenuItem;
    N9: TMenuItem;
    M30: TMenuItem;
    M7: TMenuItem;
    M36: TMenuItem;
    M34: TMenuItem;
    N10: TMenuItem;
    M32: TMenuItem;
    Sudoku1: TMenuItem;
    N11: TMenuItem;
    ari1: TMenuItem;
    N12: TMenuItem;
    Tetris1: TMenuItem;
    N21: TMenuItem;
    N16: TMenuItem;
    f_sudoku: TPanel;
    p1p2: TPanel;
    p1d6: TDsFancyButton;
    p1d8: TDsFancyButton;
    p1t1: TToolBar;
    p1s3: TSpeedButton;
    p1s4: TSpeedButton;
    p1p7: TPanel;
    p1s1: TSpeedButton;
    p1s2: TSpeedButton;
    p1p13: TPanel;
    p1s7: TSpeedButton;
    p1p1: TPanel;
    p1p3: TPanel;
    p1p4: TPanel;
    p1od: TOpenDialog;
    p1sd: TSaveDialog;
    f_mahj: TPanel;
    PB1: TPaintBox;
    p2taipei: TPanel;
    p2L3: TLabel;
    p2D9: TDsFancyButton;
    p2L4: TLabel;
    p2L1: TLabel;
    p2L2: TLabel;
    p2L5: TLabel;
    p2D1: TDsFancyButton;
    p2I1: TImage;
    p2M1: TMemo;
    p2E4: TEdit;
    p2LB1: TListBox;
    p2CB1: TCheckBox;
    p2lb2: TListBox;
    p2P3: TPanel;
    p2TB1: TToolBar;
    p2s3: TSpeedButton;
    p2p4: TPanel;
    p2S19: TSpeedButton;
    p2S7: TSpeedButton;
    p2s1: TSpeedButton;
    p2t2: TTimer;
    M56: TMenuItem;
    N14: TMenuItem;
    N20: TMenuItem;
    N19: TMenuItem;
    f_gedaechtnis: TPanel;
    p3P44: TPanel;
    p3L45: TLabel;
    p3d12: TDsFancyButton;
    p3d13: TDsFancyButton;
    p3M2: TMemo;
    p3RG6: TRadioGroup;
    p3cb1: TCheckBox;
    p3P45: TPanel;
    p3L46: TLabel;
    p3L47: TLabel;
    p3L48: TLabel;
    p3L49: TLabel;
    p3L50: TLabel;
    p3L51: TLabel;
    p3E3: TEdit;
    p3P6: TPanel;
    p3tb1: TToolBar;
    p3S7: TSpeedButton;
    p3t1: TTimer;
    M57: TMenuItem;
    f_memory: TPanel;
    p5PB1: TPaintBox;
    p5p6: TPanel;
    p5tb1: TToolBar;
    p5s3: TSpeedButton;
    p5p7: TPanel;
    p5l1: TLabel;
    p5d1: TDsFancyButton;
    p5L2: TLabel;
    p5L3: TLabel;
    p5d2: TDsFancyButton;
    p5I1: TImage;
    p5e1: TEdit;
    p5T1: TTimer;
    p5T2: TTimer;
    f_spiel15: TPanel;
    p8p6: TPanel;
    p8tb1: TToolBar;
    p8s3: TSpeedButton;
    p8spiel15: TPanel;
    p8l24: TLabel;
    p8L25: TLabel;
    p8l26: TLabel;
    p8D5: TDsFancyButton;
    p8l40: TLabel;
    p8D1: TDsFancyButton;
    p8m4: TMemo;
    p8E3: TEdit;
    p8r6: TRxSpinEdit;
    p8p7: TPanel;
    p8pb1: TPaintBox;
    f_gedtest: TPanel;
    p6PB2: TPaintBox;
    p6D4: TDsFancyButton;
    p6L1: TLabel;
    p6P6: TPanel;
    p6TB1: TToolBar;
    p6S3: TSpeedButton;
    p6P2: TPanel;
    p6L3: TLabel;
    p6L4: TLabel;
    p6L2: TLabel;
    p6L5: TLabel;
    p6L6: TLabel;
    p6I1: TImage;
    p6M1: TMemo;
    p6T1: TTimer;
    f_arithmo: TPanel;
    p9P5: TPanel;
    p9PB1: TPaintBox;
    p9p7: TPanel;
    p9l1: TLabel;
    p9L2: TLabel;
    p9d1: TDsFancyButton;
    p9d2: TDsFancyButton;
    p9d3: TDsFancyButton;
    p9d4: TDsFancyButton;
    p9d5: TDsFancyButton;
    p9cb2: TCheckBox;
    p9r3: TRadioGroup;
    p9E1: TEdit;
    p9r4: TRadioGroup;
    p9E2: TEdit;
    p9M2: TMemo;
    p9p2: TPanel;
    p9tb1: TToolBar;
    p9s1: TSpeedButton;
    f_puzzle: TPanel;
    Puzzle1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    S1: TSpeedButton;
    S2: TSpeedButton;
    Panel3: TPanel;
    S3: TSpeedButton;
    S4: TSpeedButton;
    S5: TSpeedButton;
    Panel4: TPanel;
    ipu0: TImage;
    d1: TDsFancyButton;
    PaintBox1: TPaintBox;
    Image1: TImage;
    RG1: TRadioGroup;
    Image2: TImage;
    Timer1: TTimer;
    D2: TDsFancyButton;
    L10: TLabel;
    L2: TLabel;
    L3: TLabel;
    RG2: TRadioGroup;
    D3: TDsFancyButton;
    L4: TLabel;
    Edit1: TEdit;
    OP1: TOpenPictureDialog;
    D4: TDsFancyButton;
    Image3: TImage;
    Memo1: TMemo;
    Image4: TImage;
    S6: TSpeedButton;
    L1: TListBox;
    S7: TSpeedButton;
    S8: TSpeedButton;
    SD1: TSaveDialog;
    OD1: TOpenDialog;
    Panel5: TPanel;
    f_17: TPanel;
    Panel6: TPanel;
    ToolBar2: TToolBar;
    S9: TSpeedButton;
    m37: TMenuItem;
    Panel7: TPanel;
    Memo2: TMemo;
    L5: TLabel;
    Panel8: TPanel;
    Panel9: TPanel;
    PaintBox2: TPaintBox;
    Panel10: TPanel;
    PaintBox3: TPaintBox;
    Panel11: TPanel;
    D6: TDsFancyButton;
    D7: TDsFancyButton;
    L6: TLabel;
    L7: TLabel;
    L8: TLabel;
    D5: TDsFancyButton;
    rg3: TRadioGroup;
    CB1: TCheckBox;
    CB2: TCheckBox;
    M55: TMenuItem;
    Rally1: TMenuItem;
    M59: TMenuItem;
    M58: TMenuItem;
    Spuzzle1: TMenuItem;
    Image5: TImage;
    Image6: TImage;
    I7: TImage;
    I11: TImage;
    I12: TImage;
    I13: TImage;
    I14: TImage;
    Memo3: TMemo;
    D9: TDsFancyButton;
    M111: TMenuItem;
    M531: TMenuItem;
    M541: TMenuItem;
    M811: TMenuItem;
    M91: TMenuItem;
    M231: TMenuItem;
    M911: TMenuItem;
    M321: TMenuItem;
    M4: TMenuItem;
    M10: TMenuItem;
    N13: TMenuItem;
    M25: TMenuItem;
    M38: TMenuItem;
    M39: TMenuItem;
    M40: TMenuItem;
    M41: TMenuItem;
    M42: TMenuItem;
    N17: TMenuItem;
    M45: TMenuItem;
    M46: TMenuItem;
    p1i2: TImage;
    Panel12: TPanel;
    p1sg1: TStringGrid;
    Panel13: TPanel;
    Panel14: TPanel;
    p1d1: TDsFancyButton;
    p1d2: TDsFancyButton;
    p1d3: TDsFancyButton;
    p1d11: TDsFancyButton;
    p1l3: TLabel;
    p1d12: TDsFancyButton;
    p1d4: TDsFancyButton;
    p1d5: TDsFancyButton;
    p1d13: TDsFancyButton;
    p1cb1: TCheckBox;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    N18: TMenuItem;
    M48: TMenuItem;
    Panel18: TPanel;
    p1d9: TDsFancyButton;
    p1d10: TDsFancyButton;
    p1sg3: TStringGrid;
    p1sg2: TStringGrid;
    M49: TMenuItem;
    Panel19: TPanel;
    M24: TMenuItem;
    M43: TMenuItem;
    M44: TMenuItem;
    Panel20: TPanel;
    L9: TLabel;
    Edit2: TEdit;
    S10: TSpeedButton;
    M47: TMenuItem;
    M50: TMenuItem;
    M51: TMenuItem;
    M52: TMenuItem;
    N15: TMenuItem;
    M53: TMenuItem;
    M54: TMenuItem;
    M60: TMenuItem;
    N22: TMenuItem;
    M61: TMenuItem;
    M62: TMenuItem;
    M63: TMenuItem;
    M64: TMenuItem;
    N23: TMenuItem;
    m65: TMenuItem;
    M66: TMenuItem;
    M67: TMenuItem;
    M68: TMenuItem;
    M69: TMenuItem;
    N24: TMenuItem;
    M70: TMenuItem;
    M71: TMenuItem;
    M72: TMenuItem;
    M73: TMenuItem;
    M74: TMenuItem;
    M75: TMenuItem;
    pb4: TPaintBox;
    Panel21: TPanel;
    D8: TDsFancyButton;
    Edit3: TEdit;
    Pb5: TPaintBox;
    S11: TSpeedButton;
    Panel22: TPanel;
    p1Feld: TStringGrid;
    D10: TDsFancyButton;
    d11: TDsFancyButton;
    Label1: TLabel;
    p1sg4: TStringGrid;
    M76: TMenuItem;
    M77: TMenuItem;
    M78: TMenuItem;
    LB1: TListBox;
    M79: TMenuItem;
    N25: TMenuItem;
    M80: TMenuItem;
    M81: TMenuItem;
    procedure S1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure L8Click(Sender: TObject);
    procedure L25Click(Sender: TObject);
    procedure L6Click(Sender: TObject);
    procedure L15Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure Label29Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure S99Click(Sender: TObject);
    procedure L21Click(Sender: TObject);
    procedure L19Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure L16Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure L30Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure M5Click(Sender: TObject);
    procedure Logiktrainerauf(Sender: TObject);
    procedure M7Click(Sender: TObject);
    procedure M36Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure M34Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Sudoku1Click(Sender: TObject);
    procedure drucken(Sender: TObject);
    procedure Tetris1Click(Sender: TObject);
    procedure S2C(Sender: TObject);
    procedure p1s1Click(Sender: TObject);
    procedure p1s2Click(Sender: TObject);
    procedure p1s7Click(Sender: TObject);
    procedure p1d9Click(Sender: TObject);
    procedure p1d10Click(Sender: TObject);
    procedure p1d1Click(Sender: TObject);
    procedure Feldenter(Sender: TObject);
    procedure p1FeldDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure p1sg1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure p1d11Click(Sender: TObject);
    procedure p1d12Click(Sender: TObject);
    procedure p1d5Click(Sender: TObject);
    procedure p1d4Click(Sender: TObject);
    procedure p1d2Click(Sender: TObject);
    procedure p1d3Click(Sender: TObject);
    procedure p1d13Click(Sender: TObject);
    procedure panelrufen(sender: tobject);
    procedure p2S19Click(Sender: TObject);
    procedure p2S7Click(Sender: TObject);
    procedure p2s1Click(Sender: TObject);
    procedure p2t2Timer(Sender: TObject);
    procedure p2LB1Click(Sender: TObject);
    procedure p2D9Click(Sender: TObject);
    procedure p2E4Change(Sender: TObject);
    procedure p2CB1Click(Sender: TObject);
    procedure p2D1Click(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1Paint(Sender: TObject);
    procedure Memo9Change(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure p3t1Timer(Sender: TObject);
    procedure p3d13Click(Sender: TObject);
    procedure M57Click(Sender: TObject);
    procedure p3d12Click(Sender: TObject);
    procedure p4Memo9Change(Sender: TObject);
    procedure p5PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure p5PB1Paint(Sender: TObject);
    procedure p5T1Timer(Sender: TObject);
    procedure p5T2Timer(Sender: TObject);
    procedure p5e1Change(Sender: TObject);
    procedure p5d1Click(Sender: TObject);
    procedure p5d2Click(Sender: TObject);
    procedure p7B3C(Sender: TObject);
    procedure p8D5Click(Sender: TObject);
    procedure p8r6Change(Sender: TObject);
    procedure p8E3Change(Sender: TObject);
    procedure p8D1Click(Sender: TObject);
    procedure p8pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure p8pb1Paint(Sender: TObject);
    procedure p8zeichnen(sender: tobject);
    procedure auswertung2(Sender: TObject);
    procedure p8Button3Click(Sender: TObject);
    procedure p6T1Timer(Sender: TObject);
    procedure p6PB2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure p6D4Click(Sender: TObject);
    procedure p6P6Resize(Sender: TObject);
    procedure p6auswertung(Sender: TObject);
    procedure p9d1Click(Sender: TObject);
    procedure p9E1Click(Sender: TObject);
    procedure p9d2Click(Sender: TObject);
    procedure p9d3Click(Sender: TObject);
    procedure p9d4Click(Sender: TObject);
    procedure p9PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure p9PB1Paint(Sender: TObject);
    procedure daniel(Sender: TObject);
    procedure daniel2(Sender: TObject);
    procedure d1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure puzzledarstellen(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure S5Click(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure S4Click(Sender: TObject);
    procedure D3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure D4Click(Sender: TObject);
    procedure richtigd(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure S7Click(Sender: TObject);
    procedure S8Click(Sender: TObject);
    procedure D5Click(Sender: TObject);
    procedure PaintBox3Paint(Sender: TObject);
    procedure D6Click(Sender: TObject);
    procedure D7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure M55Click(Sender: TObject);
    procedure Rally1Click(Sender: TObject);
    procedure M59Click(Sender: TObject);
    procedure M58Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure I7Click(Sender: TObject);
    procedure I11Click(Sender: TObject);
    procedure I14Click(Sender: TObject);
    procedure I12Click(Sender: TObject);
    procedure I13Click(Sender: TObject);
    procedure D9Click(Sender: TObject);
    procedure M111Click(Sender: TObject);
    procedure M531Click(Sender: TObject);
    procedure M541Click(Sender: TObject);
    procedure M811Click(Sender: TObject);
    procedure M91Click(Sender: TObject);
    procedure M231Click(Sender: TObject);
    procedure M911Click(Sender: TObject);
    procedure M321Click(Sender: TObject);
    procedure M4Click(Sender: TObject);
    procedure M25Click(Sender: TObject);
    procedure M38Click(Sender: TObject);
    procedure M13Click(Sender: TObject);
    procedure M39Click(Sender: TObject);
    procedure M40Click(Sender: TObject);
    procedure M41Click(Sender: TObject);
    procedure M42Click(Sender: TObject);
    procedure M45Click(Sender: TObject);
    procedure M46Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure p1p1Resize(Sender: TObject);
    procedure f_gedaechtnisResize(Sender: TObject);
    procedure f_puzzleResize(Sender: TObject);
    procedure M48Click(Sender: TObject);
    procedure M49Click(Sender: TObject);
    procedure f_arithmoResize(Sender: TObject);
    procedure M24Click(Sender: TObject);
    procedure M43Click(Sender: TObject);
    procedure M44Click(Sender: TObject);
    procedure M47Click(Sender: TObject);
    procedure M50Click(Sender: TObject);
    procedure S4aclick(Sender: TObject);
    procedure M51Click(Sender: TObject);
    procedure M52Click(Sender: TObject);
    procedure M53Click(Sender: TObject);
    procedure M54Click(Sender: TObject);
    procedure M61Click(Sender: TObject);
    procedure M62Click(Sender: TObject);
    procedure M63Click(Sender: TObject);
    procedure M64Click(Sender: TObject);
    procedure m65Click(Sender: TObject);
    procedure M66Click(Sender: TObject);
    procedure M67Click(Sender: TObject);
    procedure M68Click(Sender: TObject);
    procedure M69Click(Sender: TObject);
    procedure M70Click(Sender: TObject);
    procedure M71Click(Sender: TObject);
    procedure M72Click(Sender: TObject);
    procedure M73Click(Sender: TObject);
    procedure M74Click(Sender: TObject);
    procedure pb4Paint(Sender: TObject);
    procedure pb4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D8Click(Sender: TObject);
    procedure PB5paint(Sender: TObject);
    procedure S11Click(Sender: TObject);
    procedure d11Click(Sender: TObject);
    procedure D10Click(Sender: TObject);
    procedure M76Click(Sender: TObject);
    procedure M77Click(Sender: TObject);
    procedure M78Click(Sender: TObject);
    procedure M79Click(Sender: TObject);
    procedure M80Click(Sender: TObject);
    procedure M81Click(Sender: TObject);
  private
    TextName         : string;
    Stop             : boolean;
    procedure EnableEdit;
    procedure LoadData (FName : string);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

const
  SudExt = 'sud';
  beispielnr : integer = 1;
  beispielmax : integer = 20;
  hauptnur:integer=29;

var
  Form1: TForm1;
  vs : string;

implementation

{$R *.DFM}
uses karten, tetris, main, Logik4, U_tangram2, digger, u_rally, fdame,
  U_PegGame2, mahj, quiz, logik5, upuzzle, uothello, urotor, utictac,
  u_go3, u_hip4, u_puzzle15c, u_fourinarow2b, u_dominopuzzle, u_flipitfinal,
  umemory, udomino, ukette, ukakuro, uklicks, sokoban, Logik2, u_fkreis,
  logikspielerisch, urubik, urubik3, beste, zahlenraten, Mond,
  u_arithmattack, uvier3, uvier2, uvexed, urotor2, hanoi, hanoi2,
  pwurm, uvier, UBoard, game, u_trafficjams1A, Upuzzle1, uescher, uvier4,
  ufrmmain, uhaky, ufillo, uzgitter, uhitori, kika, uwolke, muehle,
  Utetravex, Ufflutung, U_Schnecke, U_schnecke2, pentomino, mbruecke, ulsumme,
  ppyram, wythoff, spielerisch, iqtest, ustraights, usudoku2, uakari,
  ugleich, conq01, ufuenf;

type _tai = record x,y,z:integer end;
     _feld = record
                x:byte;
                s:boolean;
             end;
var   testzeit:integer;
      teststring,antwortstring:string;
const testlaenge:byte=1;
      aa=38;
      neuesspiel: boolean=true;
      puzzleschieben: boolean=false;
      schiebepuzzle: boolean=false;
      puzzleteile:integer = 12;
      nochkeinbild:boolean=true;

var
    puzzlef:array[0..17,0..13] of record
                                    m:integer; n:integer
                                  end;
    schongezogen:array[1..puzzlebilder] of boolean;
    belegung : array[0..15,0..15] of integer;
    feld : array[1..8,1..5] of _feld;
    zuege,p8feld,taityp,puzzlezeit,puzzlezug:integer;
    tai : array[0..17,1..10,1..6] of byte;
    tpunkte,spielsteine:integer;
    tai1,tai2 : _tai;
    startzeit:tdatetime;
    o1,o2 : tpoint;
    zeit  : tdatetime;
    nrx,nry,paare,kartenoffset,spiel1,spiel2:integer;
    rotor1,rotor2:string[4];
    zaehler,tip,level,symbole,rsymbole,zeitmax:integer;
    anzeige,erg:array[1..18] of integer;
    a,gesamtzahl,pux,puy,puvx,puvy,pui,puj,x12,y12,b12:integer;
    karte : array[1..52] of byte;
    gezkarte : array[1..2,1..10] of byte;
    kartenzahl1,kartenzahl2:byte;
    siebzehnende,keinekartemehr:boolean;
    geschoben:string;

procedure TForm1.FormCreate(Sender: TObject);
var ini: TIniFile;
    maxi:boolean;
    liste:tstringlist;
procedure backslash(var k:string);
begin
   if k[length(k)]<>'\' then k:=k+'\';
end;
function listestring(q:string):string;
var i:integer;
    k:string;
    gefunden:boolean;
begin
    i:=0; gefunden:=false;
    repeat
      k:=liste[i];
      if pos(q,k)>0 then
      begin
        listestring:=copy(k,pos('=',k)+1,255);
        gefunden:=true;
      end;
      inc(i);
    until gefunden or (i>liste.count-1);
end;
begin
   verzeichnis:=extractfilepath(application.exename);
   backslash(verzeichnis);
   verzeichnis0:=verzeichnis+'000\';
   auf1280:=false;
     ini := TIniFile.create(tempstring+'wfktspiele.ini');
     xname:=ini.readstring('alpha','Spielername','');
     ini.free;
     liste:=tstringlist.create;
   try
     liste.loadfromfile(verzeichnis+'matlex.ini');;
     maxi:=listestring('Maxfenster')='1';
   finally
     liste.free;
   end;
   lidruck:=25;
   redruck:=25;
   obdruck:=25;
   undruck:=25;

   if (screen.width=1024) and (not istaskbarautohideon) then
   begin
     form1.position:=podefault;
     sizer1.execute;
   end
   else
   begin
     if screen.height=800 then
     begin
       form1.top:=0;
       if auf1280 then
       begin
         if screen.width<>1280 then
         begin
           if screen.width>1280 then
           begin
             form1.position:=podefault;
             form1.width:=1280;
             form1.height:=800;
           end
           else
           begin
             form1.left:=(1280-1024) div 2;
             form1.width:=1024;
             form1.height:=768;
           end;
         end
         else
         begin
           form1.position:=podefault;
           sizer1.execute;
         end;
       end
       else
       begin
         form1.left:=(1280-1024) div 2;
         form1.width:=1024;
         form1.height:=768;
       end
     end
     else
     begin
       form1.position:=poscreencenter;
       form1.width:=1024;
       form1.height:=768;
     end;
   end;

   formx:=form1.width;
   formy:=form1.height;
   form1.caption:=aktuellname2+' Logikspiele';
   MYHELP_FILE:=verzeichnis+MYHELP_FILE;
   if maxi then form1.align:=alclient;
   formparameter:=-1;
   xpixelsperinch:=pixelsperinch;
end;

procedure TForm1.L8Click(Sender: TObject);
begin
   Application.CreateForm(TFkarten, Fkarten);
   fkarten.showmodal;
   fkarten.release;
end;

procedure TForm1.L25Click(Sender: TObject);
begin
   Application.CreateForm(Tnkette, nkette);
   nkette.showmodal;
   nkette.release;
end;

procedure TForm1.L6Click(Sender: TObject);
begin
   form1.windowstate:=wsminimized;
   Application.CreateForm(TZtetris, Ztetris);
   Ztetris.showmodal;
   Ztetris.release;
   form1.windowstate:=wsnormal;
end;

procedure TForm1.L15Click(Sender: TObject);
begin
   Application.CreateForm(TTDame, TDame);
   tdame.showmodal;
   tdame.release;
end;

procedure TForm1.Label18Click(Sender: TObject);
begin
   Application.CreateForm(TfrmMain, frmMain);
   frmMain.showmodal;
   frmMain.release;
end;

procedure TForm1.Label22Click(Sender: TObject);
begin
   Application.CreateForm(TMamind, Mamind);
   Mamind.showmodal;
   Mamind.release;
end;

procedure TForm1.Label29Click(Sender: TObject);
begin
   Application.CreateForm(Tptangram, ptangram);
   ptangram.showmodal;
   ptangram.release;
end;

procedure TForm1.Label23Click(Sender: TObject);
begin
   Application.CreateForm(Tsolitaire, solitaire);
   solitaire.showmodal;
   solitaire.release;
end;

procedure TForm1.S99Click(Sender: TObject);
begin
   HH(application.Handle, PChar(MYHELP_FILE), HH_HELP_CONTEXT, helpcontext);
end;

procedure TForm1.L21Click(Sender: TObject);
begin
   Application.CreateForm(TQuiz1, Quiz1);
   quiz1.showmodal;
   quiz1.release;
end;

procedure TForm1.L19Click(Sender: TObject);
begin
   Application.CreateForm(Tarithmo, arithmo);
   arithmo.showmodal;
   arithmo.release;
end;

procedure TForm1.Label24Click(Sender: TObject);
begin
   Application.CreateForm(TFpuzzle, Fpuzzle);
   fpuzzle.showmodal;
   fpuzzle.release;
end;

procedure TForm1.L16Click(Sender: TObject);
begin
   Application.CreateForm(TFothello, fothello);
   fothello.showmodal;
   fothello.release;
end;

procedure TForm1.Label20Click(Sender: TObject);
begin
   Application.CreateForm(TFdomino, Fdomino);
   fdomino.showmodal;
   fdomino.release;
end;

procedure TForm1.L30Click(Sender: TObject);
begin
   Application.CreateForm(tuklick, uklick);
   uklick.showmodal;
   uklick.release;
end;

procedure TForm1.L1Click(Sender: TObject);
begin
   Application.CreateForm(Tfsokoban, fsokoban);
   fsokoban.showmodal;
   fsokoban.release;
end;

procedure TForm1.M5Click(Sender: TObject);
begin
   Application.CreateForm(Tfdigger, fdigger);
   fdigger.showmodal;
   fdigger.release;
end;

procedure TForm1.Logiktrainerauf(Sender: TObject);
begin
   Application.CreateForm(Tlogiktrainer, logiktrainer);
   logiktrainer.showmodal;
   logiktrainer.release;
end;

procedure TForm1.M7Click(Sender: TObject);
begin
   Application.CreateForm(TForm10, Form10);
   form10.showmodal;
   form10.release;
end;

procedure TForm1.M36Click(Sender: TObject);
begin
   Application.CreateForm(TForm30, Form30);
   form30.showmodal;
   form30.release;
end;

procedure tform1.panelrufen(sender: tobject);
var kk:string;
    I:integer;
begin
    randomize;
    p6t1.enabled:=false;
    p5t1.enabled:=false;
    p5t2.enabled:=false;
    p3t1.enabled:=false;
    p2t2.enabled:=false;
    f_gedaechtnis.visible:=false;
    f_sudoku.visible:=false;
    f_mahj.visible:=false;
    f_memory.visible:=false;
    f_spiel15.visible:=false;
    f_gedtest.visible:=false;
    f_arithmo.visible:=false;
    f_puzzle.visible:=false;
    f_17.visible:=false;

    if hauptnur=33 then
    begin
      helpcontext:=288;
      for i:=1 to 52 do karte[i]:=i;
      for i:=1 to 10 do
      begin
        gezkarte[1,i]:=0;
        gezkarte[2,i]:=0;
      end;
      spiel1:=0;
      spiel2:=0;
      kartenoffset:=0;
      f_17.align:=alclient;
      f_17.visible:=true;
    end;

    if hauptnur=32 then
    begin
      schiebepuzzle:=false;
      panel2.caption:='Puzzle';
      rg2.visible:=true;
      rg1.visible:=true;
      memo1.visible:=true;
      d9.visible:=false;
      memo3.visible:=false;
      image5.visible:=false;
      image6.visible:=false;
      i7.visible:=false;
      i11.visible:=false;
      i12.visible:=false;
      i13.visible:=false;
      i14.visible:=false;
      rg1.itemindex:=1;
      paintbox1.top:=48;
      ipu0.top:=48;
      l10.top:=568;
      l2.top:=568;
      l3.top:=600;
      helpcontext:=287;
      nochkeinbild:=true;
      for i:=1 to puzzlebilder do schongezogen[i]:=false;
      edit1.text:=xname;
      D1Click(Sender);
      f_puzzle.align:=alclient;
      f_puzzle.visible:=true;
    end;

    if hauptnur=39 then
    begin
      schiebepuzzle:=true;
      geschoben:='';
      panel2.caption:='Schiebepuzzle';
      rg2.visible:=false;
      rg1.visible:=false;
      rg1.itemindex:=0;
      memo3.visible:=true;
      memo1.visible:=false;
      d9.visible:=true;
      image5.visible:=true;
      image6.visible:=true;
      i7.visible:=true;
      i11.visible:=true;
      i12.visible:=true;
      i13.visible:=true;
      i14.visible:=true;
      gifres(image5,'pfeil1');
      gifres(image6,'pfeil1');
      gifres(i7,'pfeil1');
      gifres(i11,'pfeil2');
      gifres(i12,'pfeil2');
      gifres(i13,'pfeil2');
      gifres(i14,'pfeil2');
      paintbox1.top:=32;
      ipu0.top:=32;
      l10.top:=590;
      l2.top:=590;
      l3.top:=622;
      helpcontext:=287;
      nochkeinbild:=true;
      for i:=1 to puzzlebilder do schongezogen[i]:=false;
      edit1.text:=xname;
{      if not isadmin then
      begin
        edit1.visible:=false;
        l4.visible:=false;
        d3.visible:=false;
      end;}
      D1Click(Sender);
      f_puzzle.align:=alclient;
      f_puzzle.visible:=true;
    end;

    if hauptnur=30 then
    begin
      gesamtzahl:=100;
      a:=100;
      helpcontext:=576;
      p9e2.text:='3';
      p9r3.itemindex:=0;
      p9r4.itemindex:=1;
      f_arithmo.align:=alclient;
      f_arithmo.visible:=true;
    end;

    if hauptnur=11 then
    begin
      gifres(p6i1,'s7');
      symbole:=0;
      rsymbole:=0;
      zaehler:=0;
      level:=3;
      zeitmax:=10;
      helpcontext:=343;
      f_gedtest.align:=alclient;
      f_gedtest.visible:=true;
    end;

    if hauptnur=21 then
    begin
      p8e3.text:=xname;
      helpcontext:=344;
      p8feld:=4;
      aktuellesspiel:=true;
      zuege:=0;
      spielname:='Spiel 15 : 4x4';
      f_spiel15.align:=alclient;
      f_spiel15.visible:=true;
      p8button3click(sender);
    end;

{    if hauptnur=13 then begin
        end;}

    if hauptnur=10 then
    begin
      helpcontext:=346;
      gifres(p5i1,'s7');
      p5e1.text:=xname;
      paare:=0;
      zeit:=now;
      tpunkte:=0;
      spielname:='Memory';
      p5d1click(sender);
      f_memory.align:=alclient;
      f_memory.visible:=true;
    end;

{    if hauptnur=14 then begin
       end;}

    if hauptnur=6 then
    begin
      p3t1.enabled:=false;
      helpcontext:=348;
      f_gedaechtnis.align:=alclient;
      f_gedaechtnis.visible:=true;
    end;

    if hauptnur=18 then
    begin
      wtextdll(p2lb2,'v002');
      p2cb1.checked:=false;
      helpcontext:=349;
      p2lb1.clear;
      i:=0;
      repeat
        kk:=p2lb2.items[i];
        if kk[1]<>'[' then p2lb1.items.add(kk);
        inc(i);
      until (kk[1]='[');
      p2lb1.itemindex:=0;
      taityp:=0;
      p2lb1click(sender);
{      if not isadmin then
      begin
        p2d1.visible:=false;
        p2l4.visible:=false;
        p2e4.visible:=false;
      end;}
      p2e4.text:=xname;
      f_mahj.align:=alclient;
      f_mahj.visible:=true;
    end;

    if hauptnur=29 then
    begin
      wtextdll(lb1,'sudoku');
      helpcontext:=126;

      f_sudoku.align:=alclient;
      f_sudoku.visible:=true;
      EnableEdit;
    end;
end;

procedure TForm1.FormActivate(Sender: TObject);
label 1;
var nur:integer;
begin
   if vs<>'' then
   begin
     nur:=strtoint(vs);
     case nur of
       6,10,11,13,{14,}18,21,29,30,32,33,39 :
            begin
              hauptnur:=nur;
              panelrufen(sender);
              goto 1
            end;
       //6 zahlengedächtnis, 14 licht aus, 18 mahjonng, 29 Sudoku1
       //10 memory, 13 rotor, 21 spiel15, 11 gedächtnistest, 30 arithmo
        0 : l8Click(Sender); //patience
        1 : M36Click(Sender); //zahlenrätsel
        2 : L30Click(Sender); //klicks
        3 : Label18Click(Sender); //mini-go
        4 : Logiktrainerauf(Sender); //logiktrainer
        7 : M5Click(Sender); // digger
        8 : Label29Click(Sender); //tangram
        9 : L19Click(Sender); //begriffe raten
       12 : Label22Click(Sender); //mastermind
       14 : M13Click(Sender); //licht aus
       15 : Label24Click(Sender); //puzzle
       16 : Label20Click(Sender); //domino
       17 : L16Click(Sender); //othello
       19 : L1Click(Sender); //sokoban
       20 : begin
              form1.windowstate:=wsminimized;
              L6Click(Sender); //zahlentetris
            end;
       22 : L15Click(Sender); //dame
       23 : L25Click(Sender); //kettenreaktion
       24 : Label23Click(Sender); //solitaire
       25 : L21Click(Sender); //quiz
       26 : M7Click(Sender); //figuren setzen
       27 : M34Click(Sender); //mathetest
       28 : speedbutton6click(Sender); //bücherwurm
       31 : begin
              form1.windowstate:=wsminimized;
              Tetris1Click(Sender); //tetris
            end;
       34 : M55Click(Sender);
       35 : Rally1Click(Sender);
       36 : M59click(sender);
       37 : M24Click(Sender);
       38 : M58click(sender);
       40 : M111Click(Sender);
       41 : M531Click(Sender);
       42 : M541Click(Sender);
       43 : M811Click(Sender);
       44 : M91Click(Sender);
       45 : M231Click(Sender);
       46 : M911Click(Sender);
       47 : M321Click(Sender);
       48 : M43Click(Sender);
       49 : M4Click(Sender);
       50 : M25Click(Sender);
       51 : M38Click(Sender);
       52 : M39Click(Sender);
       53 : M40Click(Sender);
       54 : M41Click(Sender);
       55 : M42Click(Sender);
       56 : M44Click(Sender);
       57 : M47Click(Sender); //pentomino
       58 : M45Click(Sender);
       59 : M46Click(Sender);
       60 : M50Click(Sender); //hanoi
       61 : M48Click(Sender);
       62 : M49Click(Sender);
       63 : M51Click(Sender); //hanoi2
       64 : M52Click(Sender); //ken ken
       65 : M53Click(Sender); //labyri
       66 : M54Click(Sender); //tictac
       67 : M61Click(Sender); //hakyuu
       68 : M62Click(Sender); //fillom
       69 : M63Click(Sender); //zgitter
       70 : M64Click(Sender); //hitori
       71 : M65Click(Sender); //kikagaku
       72 : M66Click(Sender); //wolke
       73 : M67Click(Sender); //bruecken
       74 : M68Click(Sender); //mühle
       75 : M69Click(Sender); //zahlenpyramide
       76 : M70Click(Sender); //wythoff
       77 : M71Click(Sender); //farbkreise
       78 : M72Click(Sender); //kryptogramm
       79 : M73Click(Sender); //zahlenmaximum
       80 : M74Click(Sender); //str8ghts
       81 : M76Click(Sender); //sudoku2
       82 : M77Click(Sender); //lateinischen summen
       83 : M78Click(Sender); //akari
       84 : M79Click(Sender); //gleichungsrätsel
       85 : M80Click(Sender); //conquete
       86 : M81Click(Sender); //fünf in reihe
     end;
     close;
1: end
   else
   begin
     hauptnur:=29;
     panelrufen(sender);
   end;
end;

procedure TForm1.M34Click(Sender: TObject);
begin
   Application.CreateForm(Tmondform, mondform);
   mondform.showmodal;
   mondform.release;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
   Application.CreateForm(Twurm, wurm);
   wurm.showmodal;
   wurm.release;
end;

procedure TForm1.Sudoku1Click(Sender: TObject);
var altnur:integer;
begin
   altnur:=hauptnur;
   if sender=sudoku1 then hauptnur:=29;
   if sender=m17  then hauptnur:=18;
   if sender=m30 then hauptnur:=6;
   if sender=m19 then hauptnur:=10;
   if sender=m28 then hauptnur:=21;
   if sender=m8 then hauptnur:=11;
   if sender=ari1 then hauptnur:=30;
   if sender=puzzle1 then hauptnur:=32;
   if sender=spuzzle1 then hauptnur:=39;
   if sender=m37 then hauptnur:=33;
   if altnur<>hauptnur then panelrufen(sender);
end;

procedure TForm1.drucken(Sender: TObject);
begin
  Application.CreateForm(Tdruckein, druckein);
  druckein.showmodal;
  druckein.release;
end;

procedure TForm1.Tetris1Click(Sender: TObject);
begin
  form1.windowstate:=wsminimized;
  Application.CreateForm(TGBoard, GBoard);
  GBoard.showmodal;
  GBoard.release;
  form1.windowstate:=wsnormal;
end;

procedure TForm1.S2C(Sender: TObject);
begin
  Application.CreateForm(TF35, F35);
  f35.showmodal;
  f35.release;
end;

function ReadNxtStr (var s : String; Del : char) : string;
var
  i : integer;
begin
  if length(s)>0 then
  begin
    i:=pos(Del,s);
    if i=0 then i:=succ(length(s));
    Result:=copy(s,1,pred(i));
    delete(s,1,i);
  end
  else
    Result:='';
end;

procedure TForm1.p1s1Click(Sender: TObject);
var i,j:integer;
begin
  with p1OD do
  begin
    if length(TextName)>0 then
      InitialDir:=ExtractFilePath(TextName)
    else
      InitialDir:=verzeichnis+'dat';
    Filename:='';
    if Execute then
    begin
      LoadData (Filename);
      p1D9Click(Sender);
      for i:=0 to 8 do
        for j:=0 to 8 do
          p1sg2.Cells[i,j]:=p1feld.Cells[i,j]
    end;
    for i:=0 to 8 do
      for j:=0 to 8 do
      begin
        if p1feld.cells[i,j]='' then
          p1feld.cells[i,j]:='123456789';
      end;
    pb4paint(sender);
    pb5paint(sender);
  end;
end;

procedure TForm1.p1s2Click(Sender: TObject);
var
  ft  : TextFile;
  i,j : integer;
  s   : string;
begin
  with p1sd do
  begin
    if length(TextName)>0 then
      InitialDir:=ExtractFilePath(TextName)
    else
      InitialDir:=verzeichnis+'dat';
    Filename:=ExtractFileName(TextName);
    if Execute then
    begin
      TextName:=Filename;
      AssignFile(ft,TextName);
      rewrite(ft);
      with p1Feld do
        for i:=0 to 8 do
        begin
          for j:=0 to 8 do
          begin
            s:=Trim(Cells[j,i]);
            if j>0 then s:=','+s;
            if length(s)>0 then write(ft,s);
          end;
          writeln(ft);
        end;
      CloseFile(ft);
    end;
  end;
  pb4paint(sender);
  pb5paint(sender);
end;

procedure TForm1.p1s7Click(Sender: TObject);
var i,j,m,n,z,code,p,q:integer;
    zahl:array[1..9] of boolean;
    k,s,e:string;
begin
    for i:=0 to 8 do
    begin
      for j:=0 to 8 do
      begin
        for m:=1 to 9 do zahl[m]:=false;
        k:=p1feld.cells[i,j];
        if (k='') or (k=' ') or (length(k)>1) then
        begin
          for m:=0 to 8 do
          begin
            s:=p1feld.cells[m,j];
            if (length(s)=1) and (s<>'') and (s<>' ') then
            begin
              val(s,z,code);
              zahl[z]:=true;
            end;
          end;
          for m:=0 to 8 do
          begin
            s:=p1feld.cells[i,m];
            if (length(s)=1) and (s<>'') and (s<>' ') then
            begin
              val(s,z,code);
              zahl[z]:=true;
            end;
          end;
          p:=i div 3;
          q:=j div 3;
          for m:=0 to 2 do
            for n:=0 to 2 do
            begin
              s:=p1feld.cells[3*p+m,3*q+n];
              if (length(s)=1) and (s<>'') and (s<>' ') then
              begin
                val(s,z,code);
                zahl[z]:=true;
              end;
            end;
          e:='';
          for m:=1 to 9 do
            if zahl[m]=false then e:=e+inttostr(m);
          p1feld.cells[i,j]:=e;
        end;
      end;
    end;
    pb4paint(sender);
end;

procedure TForm1.p1d9Click(Sender: TObject);
var i,j:integer;
begin
   for i:=0 to 8 do
     for j:=0 to 8 do
       if length(p1feld.Cells[i,j])<2 then
         p1sg1.Cells[i,j]:=p1feld.Cells[i,j]
       else
         p1sg1.Cells[i,j]:='';
   pb4paint(sender);
   pb5paint(sender);
end;

procedure TForm1.p1d10Click(Sender: TObject);
var i,j:integer;
begin
   for i:=0 to 8 do
     for j:=0 to 8 do
       p1feld.Cells[i,j]:=p1sg1.Cells[i,j];
   pb5paint(sender);
   pb4paint(sender);
end;

procedure TForm1.p1d1Click(Sender: TObject);
var
  i,j : integer;
begin
  panel21.visible:=false;
  panel22.visible:=true;
  with p1Feld do
    for i:=0 to 8 do
      for j:=0 to 8 do
      begin
        Cells[i,j]:='';
        Objects[i,j]:=pointer(0);
      end;
    EnableEdit;
    p1p4.caption:='';
    pb4paint(sender);
    pb5paint(sender);
end;

procedure TForm1.Feldenter(Sender: TObject);
label 1;
var zahl:array[1..9] of byte;
    m,n,i,j,t:integer;
    k:string;
    leer:boolean;
begin
  for j:=0 to 8 do
  begin
    for i:=0 to 8 do
    begin
      k:=p1feld.cells[i,j];
      if length(k)>0 then
      begin
        m:=1;
        while (length(k)>0) and (m<=length(k)) do
        begin
          if not (k[m] in ['1'..'9']) then delete(k,m,1)
                                      else inc(m)
        end;
      end;
      p1feld.cells[i,j]:=k;
    end
  end;

  if p1cb1.checked then
  begin
    p1p4.caption:='';
    for j:=0 to 8 do
    begin
      fillchar(zahl,sizeof(zahl),0);
      for i:=0 to 8 do
      begin
        k:=p1feld.cells[i,j];
        if (length(k)<2) then
          if (length(k)=1) and (k<>' ') then
            inc(zahl[strtoint(k)]);
      end;
      for t:=1 to 9 do if zahl[t]>1 then
      begin
        p1p4.caption:='Fehlerhafte Zahl im Arbeitsfeld!';
        exit
      end;
      fillchar(zahl,sizeof(zahl),0);
      for i:=0 to 8 do
      begin
        k:=p1feld.cells[j,i];
        if (length(k)<2) then
          if (length(k)>0) and (k<>' ') then inc(zahl[strtoint(k)]);
      end;
      for t:=1 to 9 do if zahl[t]>1 then
      begin
        p1p4.caption:='Fehlerhafte Zahl im Arbeitsfeld!';
        exit
      end;
    end;

    for m:=0 to 2 do
    begin
      for n:=0 to 2 do
      begin
        fillchar(zahl,sizeof(zahl),0);
        for j:=0 to 2 do
        begin
          for i:=0 to 2 do
          begin
            k:=p1feld.cells[m*3+j,n*3+i];
            if (length(k)<2) then
              if (length(k)>0) and (k<>' ') then inc(zahl[strtoint(k)]);
          end;
        end;
        for t:=1 to 9 do
          if zahl[t]>1 then
          begin
            p1p4.caption:='Fehlerhafte Zahl im Arbeitsfeld!';
            exit
          end;
      end;
    end;

    leer:=false;
    for j:=0 to 8 do
    begin
      for i:=0 to 8 do
      begin
        k:=p1feld.cells[i,j];
        if (length(k)=0) or (length(k)>1) or (k=' ') then
          leer:=true;
      end
    end;
    if not leer then
      p1p4.caption:='Gratulation! Sie haben das Sudoku-Rätsel gelöst!';
  end;
  pb4paint(sender);
end;

procedure TForm1.p1FeldDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid),Canvas do
  begin
    if EditorMode then Brush.Color:=clwhite
                  else Brush.Color:=TColor($0095FFFF);
    Pen.Color:=TColor($00B37800);
    with Font do
    begin
      Size:=24;
      Style:=[fsbold];
    end;
    FillRect (Rect);
    with Rect do
      begin
      with Pen do
        if (ACol mod 3=2) then Width:=2
                          else Width:=1;
        if ACol<8 then
        begin
          MoveTo(Right,Top);
          LineTo(Right,Bottom);
        end;
        with Pen do
          if (ARow mod 3=2) then Width:=2
                            else Width:=1;
          if ARow<8 then
          begin
            MoveTo(Right,Bottom);
            LineTo(Left,Bottom);
          end;
        end;
        with Rect do
        begin
          if length(Cells[ACol,Arow])>1 then
          begin
            font.size:=8;
            font.Style:=[];
            TextOut(Left+3,Top+4,Cells[ACol,Arow])
          end
          else
          begin
            TextOut(Left+8,Top+4,Cells[ACol,Arow]);
          end;
        end;
      end;
end;

procedure TForm1.p1sg1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid),Canvas do
  begin
    if EditorMode then Brush.Color:=clWhite
                  else Brush.Color:=clwhite;
    Pen.Color:=TColor($00B37800);
    if integer(Objects[ACol,ARow])>0 then Font.Color:=clRed
                                     else Font.Color:=clBlack;
    with Font do
    begin
      Size:=24;
      Style:=[fsBold];
    end;
    FillRect (Rect);
    with Rect do
    begin
      with Pen do if (ACol mod 3=2) then Width:=2 else Width:=1;
      if ACol<8 then
      begin
        MoveTo(Right,Top);
        LineTo(Right,Bottom);
      end;
      with Pen do if (ARow mod 3=2) then Width:=2 else Width:=1;
      if ARow<8 then
      begin
        MoveTo(Right,Bottom);
        LineTo(Left,Bottom);
      end;
    end;
    with Rect do
    begin
      TextOut(Left+8,Top+4,Cells[ACol,Arow]);
    end;
  end;
end;

procedure TForm1.p1d11Click(Sender: TObject);
var i,j:integer;
procedure loadData;
var
  i,j,k,anz,nr,grad,code,lnr : integer;
  s,t,sc : string;
begin
  anz:=strtoint(lb1.items[0]);
  lnr:=1;
  beispielmax:=anz;
  nr:=0;
  repeat
    s:=lb1.items[lnr];
    inc(lnr);
    if s[1]='[' then inc(nr);
  until nr=beispielnr;
  i:=0;
  for k:=1 to 9 do
  begin
    s:=lb1.items[lnr]; inc(lnr);
    s:=TrimLeft(s);
    if (length(s)>0) and (s[1]<>';') and (i<9) then
    begin
      with p1Feld do
        for j:=0 to 8 do
        begin
          Objects[i,j]:=pointer(0);
          t:=Trim(ReadNxtStr(s,','));
          if length(t)=0 then Cells[j,i]:=''
          else
          begin
            StrToInt(t);
            Cells[j,i]:=t;
          end;
        end;
      inc(i);
    end;
  end;
  sc:=lb1.items[lnr];
  delete(sc,1,1);
  val(sc,grad,code);
  sc:='Das Problem wird als ';
  case grad of
     0..4 : sc:=sc+'leicht';
     5..15 : sc:=sc+'normal';
     16..100 : sc:=sc+'mittelschwer';
    101..200 : sc:=sc+'schwer';
    else sc:=sc+'sehr schwer';
  end;
  p1p4.caption:=sc+' eingestuft';
  EnableEdit;
end;
begin
    panel21.visible:=false;
    loaddata;
    inc(beispielnr);
    if beispielnr>beispielmax then beispielnr:=1;
    p1d11.caption:='Beispiel '+inttostr(beispielnr);
    for i:=0 to 8 do
      for j:=0 to 8 do
      begin
        p1sg2.Cells[i,j]:=p1feld.cells[i,j];
      end;
    for i:=0 to 8 do
      for j:=0 to 8 do
      begin
        if p1feld.cells[i,j]='' then p1feld.cells[i,j]:='123456789';
      end;
    p1D9Click(Sender);
end;

procedure TForm1.p1d12Click(Sender: TObject);
var tau,ss,v,m,n,z1,z2,code:integer;
    k:string;
procedure loadData;
var
  i,j,k,anz,bnr,nr,grad,code,lnr : integer;
  s,t,sc : string;
begin
    lnr:=0;
    anz:=strtoint(lb1.items[lnr]);
    inc(lnr);
    bnr:=random(anz)+1;
    nr:=0;
    repeat
      s:=lb1.items[lnr];
      inc(lnr);
      if s[1]='[' then inc(nr);
    until nr=bnr;
    i:=0;
    for k:=1 to 9 do
    begin
      s:=lb1.items[lnr];
      inc(lnr);
      s:=TrimLeft(s);
      if (length(s)>0) and (s[1]<>';') and (i<9) then
      begin
        with p1sg2 do
          for j:=0 to 8 do
          begin
            Objects[i,j]:=pointer(0);
            t:=Trim(ReadNxtStr(s,','));
            if length(t)=0 then Cells[j,i]:=''
            else
            begin
              StrToInt(t);
              Cells[j,i]:=t;
            end;
          end;
        inc(i);
      end;
    end;
    sc:=lb1.items[lnr];
    delete(sc,1,1);
    val(sc,grad,code);
    sc:='Das Problem wird als ';
    case grad of
        0..4 : sc:=sc+'leicht';
       5..15 : sc:=sc+'normal';
     16..100 : sc:=sc+'mittelschwer';
    101..200 : sc:=sc+'schwer';
          else sc:=sc+'sehr schwer';
    end;
    p1p4.caption:=sc+' eingestuft';
end;
begin
    panel21.visible:=false;
    loaddata;
    for tau:=1 to 100 do
    begin
      for ss:=0 to 2 do
      begin
        z1:=3*ss+random(3);
        z2:=3*ss+random(3);
        while z1=z2 do z2:=3*ss+random(3);
        for m:=0 to 8 do
        begin
          p1sg3.Cells[m,z2]:=p1sg2.Cells[m,z1];
          p1sg3.Cells[m,z1]:=p1sg2.Cells[m,z2];
        end;
        for m:=0 to 8 do
        begin
          p1sg2.Cells[m,z1]:=p1sg3.Cells[m,z1];
          p1sg2.Cells[m,z2]:=p1sg3.Cells[m,z2];
        end;
        z1:=3*ss+random(3);
        z2:=3*ss+random(3);
        while z1=z2 do z2:=3*ss+random(3);
        for m:=0 to 8 do
        begin
          p1sg3.Cells[z2,m]:=p1sg2.Cells[z1,m];
          p1sg3.Cells[z1,m]:=p1sg2.Cells[z2,m];
        end;
        for m:=0 to 8 do
        begin
          p1sg2.Cells[z1,m]:=p1sg3.Cells[z1,m];
          p1sg2.Cells[z2,m]:=p1sg3.Cells[z2,m];
        end;
      end;

      z1:=random(3);
      z2:=random(3);
      while z1=z2 do z2:=random(3);
      for n:=0 to 2 do
        for m:=0 to 8 do
        begin
          p1sg3.Cells[m,3*z2+n]:=p1sg2.Cells[m,3*z1+n];
          p1sg3.Cells[m,3*z1+n]:=p1sg2.Cells[m,3*z2+n];
        end;
      for n:=0 to 2 do
        for m:=0 to 8 do
        begin
          p1sg2.Cells[m,3*z1+n]:=p1sg3.Cells[m,3*z1+n];
          p1sg2.Cells[m,3*z2+n]:=p1sg3.Cells[m,3*z2+n];
        end;

      z1:=random(3);
      z2:=random(3);
      while z1=z2 do z2:=random(3);
      for n:=0 to 2 do
        for m:=0 to 8 do
        begin
          p1sg3.Cells[3*z2+n,m]:=p1sg2.Cells[3*z1+n,m];
          p1sg3.Cells[3*z1+n,m]:=p1sg2.Cells[3*z2+n,m];
        end;
      for n:=0 to 2 do
        for m:=0 to 8 do
        begin
          p1sg2.Cells[3*z2+n,m]:=p1sg3.Cells[3*z2+n,m];
          p1sg2.Cells[3*z1+n,m]:=p1sg3.Cells[3*z1+n,m];
        end;

    end;
    v:=random(8)+1;
    for m:=0 to 8 do
      for n:=0 to 8 do
      begin
        k:=p1sg2.Cells[m,n];
        if k<>'' then
        begin
          val(k,z1,code);
          z1:=z1+v;
          if z1>9 then z1:=z1-9;
          str(z1,k);
          p1sg2.Cells[m,n]:=k;
        end;
      end;
    for m:=0 to 8 do
      for n:=0 to 8 do
        p1feld.Cells[m,n]:=p1sg2.Cells[m,n];
    for m:=0 to 8 do
      for n:=0 to 8 do begin
        if p1feld.cells[m,n]='' then p1feld.cells[m,n]:='123456789';
      end;
    p1D9Click(Sender);
end;

procedure TForm1.p1d5Click(Sender: TObject);
const grad=9;
var i,j,m,n,z,code,p,q:integer;
    zahl:array[1..9] of boolean;
    k,s,e:string;
begin
    panel21.visible:=false;
    for i:=0 to grad-1 do
      for j:=0 to grad-1 do
      begin
//xxxx
        for m:=1 to 9 do zahl[m]:=false;
        k:=p1feld.cells[i,j];
        if (k='') or (k=' ') or (length(k)>1) then
        begin
          for m:=0 to 8 do
          begin
            s:=p1feld.cells[m,j];
            if (length(s)=1) and (s<>'') and (s<>' ') then
            begin
              val(s,z,code);
              zahl[z]:=true;
            end;
          end;
          for m:=0 to 8 do
          begin
            s:=p1feld.cells[i,m];
            if (length(s)=1) and (s<>'') and (s<>' ') then
            begin
              val(s,z,code);
              zahl[z]:=true;
            end;
          end;
          p:=i div 3;
          q:=j div 3;
          for m:=0 to 2 do
            for n:=0 to 2 do
            begin
              s:=p1feld.cells[3*p+m,3*q+n];
              if (length(s)=1) and (s<>'') and (s<>' ') then
              begin
                val(s,z,code);
                zahl[z]:=true;
              end;
            end;
          e:='';
          for m:=1 to 9 do
            if zahl[m]=false then e:=e+inttostr(m);
            if length(e)>0 then p1feld.cells[i,j]:=e;
        end;
      end;
      pb4paint(sender);
end;

procedure TForm1.p1d4Click(Sender: TObject);
var
  DigitGrid   : TDigitGrid;
  RowData,
  ColData,
  BoxData    : array [1..9] of TData;
  DataGrid   : TDataGrid;
  fd         : TData;
  BCount,
  CCount     : cardinal;
  Row,Col,
  i,j,k,n,sp,m : integer;
  Ende,
  Found, leeresfeld      : boolean;
  s          : string;
  gs         : TGridStack;
  ersetzt : boolean;
  versuche : integer;

function GetBox (Row,Col :integer) : integer;
begin
    Result:=(Row-1) div 3+3*((Col-1) div 3)+1;
end;

function GetDigit(var Field : TData) : TDigit;
var
    d : TDigit;
begin
    Result:=0;
    with Field do
      for d:=1 to 9 do if d in Values then
      begin
        Result:=d;
        Exclude(Values,d);
        dec(Count);
        Break;
      end;
end;

procedure IncludeDigit (var Data : TData; Digit : TDigit);
begin
    with Data do
      if not (Digit in Values) then
      begin
        inc(Count);
        Include(Values,Digit);
      end;
end;

procedure ExcludeDigit (var Data : TData; Digit : TDigit);
begin
    with Data do
      if Digit in Values then
      begin
        dec(Count);
        Exclude(Values,Digit);
      end;
end;

procedure Reset (var Data : TData);
begin
    with Data do
    begin
      Count:=0;
      Values:=[];
    end;
end;

procedure ComputeBox (Row,Col : integer);
var
    n,i,j,r,c : integer;
    d   : TDigit;
begin
    n:=GetBox(Row,Col);
    r:=3*((Row-1) div 3)+1;
    c:=3*((Col-1) div 3)+1;
    Reset(BoxData[n]);
    for i:=r to r+2 do
      for j:=c to c+2 do
      begin
        d:=DigitGrid[i,j];
        if d<>0 then IncludeDigit(BoxData[n],d);
      end;
end;

procedure ComputeBoxes;
var
    i,j : integer;
    d   : TDigit;
begin
    for i:=1 to 9 do Reset(BoxData[i]);
    for i:=1 to 9 do
    begin
      for j:=1 to 9 do
      begin
        d:=DigitGrid[i,j];
        if d<>0 then IncludeDigit(BoxData[GetBox(i,j)],d);
      end;
    end;
end;

procedure ComputeRow (Row : integer);
var
    j : integer;
    d : TDigit;
begin
    Reset(RowData[Row]);
    for j:=1 to 9 do
    begin
      d:=DigitGrid[Row,j];
      if d<>0 then IncludeDigit(RowData[Row],d);
    end;
end;

procedure ComputeRows;
var
    i : integer;
begin
    for i:=1 to 9 do ComputeRow (i);
end;

procedure ComputeCol (Col : integer);
var
    i : integer;
    d : TDigit;
begin
    Reset(ColData[Col]);
    for i:=1 to 9 do
    begin
      d:=DigitGrid[i,Col];
      if d<>0 then IncludeDigit(ColData[Col],d);
    end;
end;

procedure ComputeCols;
var
    j : integer;
begin
    for j:=1 to 9 do ComputeCol (j);
end;

function CheckGrid : boolean;
var
    i,j : integer;
    d : TDigit;
begin
    Result:=false;
    for i:=1 to 9 do
    begin
      Reset(BoxData[i]);
      Reset(ColData[i]);
      Reset(RowData[i]);
    end;
    for i:=1 to 9 do
      for j:=1 to 9 do
      begin
        d:=DigitGrid[i,j];
        if (d<>0) then
        begin
          if d in ColData[j].Values then Result:=true
                                    else IncludeDigit(ColData[j],d);
          if d in RowData[i].Values then Result:=true
                                    else IncludeDigit(RowData[i],d);
          if d in BoxData[GetBox(i,j)].Values then Result:=true
                                              else IncludeDigit(BoxData[GetBox(i,j)],d);
        end;
      end;
end;

function CalcValues (Row,Col : integer) : TData;
var
    d : TDigit;
begin
    with Result do
    begin
      Count:=9;
      Values:=[1..9];
    end;
    for d:=1 to 9 do
      if d in RowData[Row].Values then ExcludeDigit(Result,d);
    for d:=1 to 9 do
      if d in ColData[Col].Values then ExcludeDigit(Result,d);
    for d:=1 to 9 do
      if d in BoxData[GetBox(Row,Col)].Values then ExcludeDigit(Result,d);
end;

function SolutionFound : boolean;
var
    i,j : integer;
begin
    Result:=true;
    for i:=1 to 9 do
       for j:=1 to 9 do Result:=Result and (DataGrid[i,j].Count=0);
    Result:=Result or Stop;
end;

procedure UpdateGrid (const Data : TDigitGrid);
var
    i,j : integer;
    d : TDigit;
begin
    for i:=1 to 9 do for j:=1 to 9 do
    begin
      d:=Data[i,j];
      if d>0 then p1sg4.Cells[i-1,j-1]:=IntToStr(d)
             else p1sg4.Cells[i-1,j-1]:='';
    end;
end;

begin
   panel21.visible:=false;
   for m:=0 to 8 do
     for n:=0 to 8 do
       if length(p1feld.Cells[m,n])<2 then p1sg4.Cells[m,n]:=p1feld.Cells[m,n]
                                      else p1sg4.Cells[m,n]:='';
   with p1sg4 do
   begin
     Options:=Options-[goAlwaysShowEditor];
     EditorMode:=false;
     leeresfeld:=true;
     for i:=1 to 9 do
       for j:=1 to 9 do
       begin
         s:=Trim(Cells[i-1,j-1]);
         if length(s)=0 then
         begin
           DigitGrid[i,j]:=0;
           Objects[i-1,j-1]:=pointer(0);
         end
         else
         begin
           DigitGrid[i,j]:=TDigit(StrToInt(s));
           Objects[i-1,j-1]:=pointer(1);
           leeresfeld:=false;
         end;
      end;
   end;
   if leeresfeld then showmessage('Kein Sudoku-Rätsel!')
   else
   begin
     Stop:=false;
     sp:=1;
     CCount:=0;
     if CheckGrid then
     begin
       p1p4.caption:=' Fehlerhaftes Problem!';
       MessageDlg ('Das Problem enthält Fehler!',mtError,[mbOK],0); Exit;
     end;
     repeat
       ComputeBoxes;
       ComputeRows;
       ComputeCols;
       Found:=false;
       for i:=1 to 9 do
         for j:=1 to 9 do
         begin
           DataGrid[i,j]:=CalcValues(i,j);
           if (DigitGrid[i,j]=0) and (DataGrid[i,j].Count=1) then
           begin
             DigitGrid[i,j]:=GetDigit(DataGrid[i,j]);
             ComputeBox(i,j);
             ComputeRow(i);
             ComputeCol(j);
             Found:=true;
           end;
         end;
         Ende:=SolutionFound;
         if not (Found or Ende) then
         begin
           repeat
             Found:=false;
             k:=0;
             n:=9;
             row:=1;
             col:=1;
        // leeres Feld suchen
             for i:=1 to 9 do
               for j:=1 to 9 do
                 if (DigitGrid[i,j]=0) then
                 begin
                   k:=DataGrid[i,j].Count;
                   if (k<n) then
                   begin
                     Row:=i;
                     Col:=j;
                     fd:=DataGrid[i,j];
                     n:=k;
                     Found:=true;
                   end;
                 end;
             if Found then k:=GetDigit(DataGrid[Row,Col]);
             Found:=k>0;
             while not Found and (sp>1) do
             begin
               dec(sp);
               with gs[sp] do
               begin
                 Row:=r;
                 Col:=c;
                 DigitGrid:=DGrid;
                 fd:=CField;
                 k:=GetDigit(fd);
               end;
               Found:=k>0;
             end;
           until Found or (sp=1);
           if not Found and (sp=1) then
           begin
             p1p4.caption:=' Keine Lösung gefunden!';
             MessageDlg ('Konnte keine Lösung finden!',mtError,[mbOK],0); Exit;
           end;
           with gs[sp] do
           begin
             r:=Row;
             c:=Col;
             DGrid:=DigitGrid;
             CField:=fd;
             if sp<81 then inc(sp);
           end;
           DigitGrid[Row,Col]:=k;
         end;
         if (CCount mod 200)=0 then
         begin
           UpdateGrid(DigitGrid);
           p1p4.caption:=' Problem wird analysiert, Abbruch mit dem Schalter! '+IntToStr(CCount);
           Application.ProcessMessages;
         end;
         inc(CCount);
       until Ende;
       if Stop then p1p4.caption:=' Berechnung abgebrochen!'
               else p1p4.caption:=' ';
       UpdateGrid(DigitGrid);
       Application.ProcessMessages;
     end;

     versuche:=0;
     ersetzt:=false;
     repeat
       m:=random(9);
       n:=random(9);
       if p1sg4.Cells[m,n]<>p1feld.Cells[m,n] then
       begin
         p1feld.Cells[m,n]:=p1sg4.Cells[m,n];
         ersetzt:=true;
       end;
       inc(versuche);
     until ersetzt or (versuche>100);
     pb4paint(sender);
     pb5paint(sender);
end;

procedure TForm1.p1d2Click(Sender: TObject);
begin
    Stop:=true;
end;

procedure TForm1.p1d3Click(Sender: TObject);
var
  DigitGrid   : TDigitGrid;
  RowData,
  ColData,
  BoxData    : array [1..9] of TData;
  DataGrid   : TDataGrid;
  fd         : TData;
  BCount,
  CCount     : cardinal;
  Row,Col,
  i,j,k,n,sp : integer;
  Ende,
  Found, leeresfeld      : boolean;
  s          : string;
  gs         : TGridStack;

function GetBox (Row,Col :integer) : integer;
begin
    Result:=(Row-1) div 3+3*((Col-1) div 3)+1;
end;

function GetDigit(var Field : TData) : TDigit;
var
    d : TDigit;
begin
    Result:=0;
    with Field do
      for d:=1 to 9 do
        if d in Values then
        begin
          Result:=d;
          Exclude(Values,d);
          dec(Count);
          Break;
        end;
end;

procedure IncludeDigit (var Data : TData; Digit : TDigit);
begin
    with Data do
      if not (Digit in Values) then
      begin
        inc(Count);
        Include(Values,Digit);
      end;
end;

procedure ExcludeDigit (var Data : TData; Digit : TDigit);
begin
    with Data do
      if Digit in Values then
      begin
        dec(Count);
        Exclude(Values,Digit);
      end;
end;

procedure Reset (var Data : TData);
begin
    with Data do
    begin
      Count:=0;
      Values:=[];
    end;
end;

procedure ComputeBox (Row,Col : integer);
var
    n,i,j,r,c : integer;
    d   : TDigit;
begin
    n:=GetBox(Row,Col);
    r:=3*((Row-1) div 3)+1;
    c:=3*((Col-1) div 3)+1;
    Reset(BoxData[n]);
    for i:=r to r+2 do
      for j:=c to c+2 do
      begin
        d:=DigitGrid[i,j];
        if d<>0 then IncludeDigit(BoxData[n],d);
      end;
end;

procedure ComputeBoxes;
var
    i,j : integer;
    d   : TDigit;
begin
    for i:=1 to 9 do Reset(BoxData[i]);
    for i:=1 to 9 do
    begin
      for j:=1 to 9 do
      begin
        d:=DigitGrid[i,j];
        if d<>0 then IncludeDigit(BoxData[GetBox(i,j)],d);
      end;
    end;
end;

procedure ComputeRow (Row : integer);
var
    j : integer;
    d : TDigit;
begin
    Reset(RowData[Row]);
    for j:=1 to 9 do
    begin
      d:=DigitGrid[Row,j];
      if d<>0 then IncludeDigit(RowData[Row],d);
    end;
end;

procedure ComputeRows;
var
    i : integer;
begin
    for i:=1 to 9 do ComputeRow (i);
end;

procedure ComputeCol (Col : integer);
var
    i : integer;
    d : TDigit;
begin
    Reset(ColData[Col]);
    for i:=1 to 9 do
    begin
      d:=DigitGrid[i,Col];
      if d<>0 then IncludeDigit(ColData[Col],d);
    end;
end;

procedure ComputeCols;
var
    j : integer;
begin
    for j:=1 to 9 do ComputeCol (j);
end;

function CheckGrid : boolean;
var
    i,j : integer;
    d : TDigit;
begin
    Result:=false;
    for i:=1 to 9 do
    begin
      Reset(BoxData[i]);
      Reset(ColData[i]);
      Reset(RowData[i]);
    end;
    for i:=1 to 9 do
      for j:=1 to 9 do
      begin
        d:=DigitGrid[i,j];
        if (d<>0) then
        begin
          if d in ColData[j].Values then Result:=true
                                    else IncludeDigit(ColData[j],d);
          if d in RowData[i].Values then Result:=true
                                    else IncludeDigit(RowData[i],d);
          if d in BoxData[GetBox(i,j)].Values then Result:=true
                                    else IncludeDigit(BoxData[GetBox(i,j)],d);
        end;
      end;
end;

function CalcValues (Row,Col : integer) : TData;
var
    d : TDigit;
begin
    with Result do
    begin
      Count:=9;
      Values:=[1..9];
    end;
    for d:=1 to 9 do
      if d in RowData[Row].Values then ExcludeDigit(Result,d);
    for d:=1 to 9 do
      if d in ColData[Col].Values then ExcludeDigit(Result,d);
    for d:=1 to 9 do
      if d in BoxData[GetBox(Row,Col)].Values then ExcludeDigit(Result,d);
end;

function SolutionFound : boolean;
var
    i,j : integer;
begin
    Result:=true;
    for i:=1 to 9 do
      for j:=1 to 9 do Result:=Result and (DataGrid[i,j].Count=0);
    Result:=Result or Stop;
end;

procedure UpdateGrid (const Data : TDigitGrid);
var
    i,j : integer;
    d : TDigit;
begin
    for i:=1 to 9 do
      for j:=1 to 9 do
      begin
        d:=Data[i,j];
        if d>0 then p1sg1.Cells[i-1,j-1]:=IntToStr(d)
               else p1sg1.Cells[i-1,j-1]:='';
      end;
end;

begin
    with p1sg1 do
    begin
      Options:=Options-[goAlwaysShowEditor];
      EditorMode:=false;
      leeresfeld:=true;
      for i:=1 to 9 do
        for j:=1 to 9 do
        begin
          s:=Trim(Cells[i-1,j-1]);
          if length(s)=0 then
          begin
            DigitGrid[i,j]:=0;
            Objects[i-1,j-1]:=pointer(0);
          end
          else
          begin
            DigitGrid[i,j]:=TDigit(StrToInt(s));
            Objects[i-1,j-1]:=pointer(1);
            leeresfeld:=false;
          end;
        end;
    end;

    if leeresfeld then showmessage('Kein Sudoku-Rätsel im rechten Lösungsfeld!')
    else
    begin
      Stop:=false;
      sp:=1;
      CCount:=0;
      if CheckGrid then
      begin
        p1p4.caption:=' Fehlerhaftes Problem!';
        MessageDlg ('Das Problem enthält Fehler!',mtError,[mbOK],0); Exit;
      end;
      repeat
        ComputeBoxes;
        ComputeRows;
        ComputeCols;
        Found:=false;
        for i:=1 to 9 do
          for j:=1 to 9 do
          begin
            DataGrid[i,j]:=CalcValues(i,j);
            if (DigitGrid[i,j]=0) and (DataGrid[i,j].Count=1) then begin
              DigitGrid[i,j]:=GetDigit(DataGrid[i,j]);
            Row:=i;
            Col:=j;
            ComputeBox(i,j);
            ComputeRow(i);
            ComputeCol(j);
            Found:=true;
          end;
        end;
        Ende:=SolutionFound;
        if not (Found or Ende) then
        begin
          repeat
            Found:=false;
            k:=0;
            n:=9;
          // leeres Feld suchen
            for i:=1 to 9 do
              for j:=1 to 9 do
                if (DigitGrid[i,j]=0) then
                begin
                  k:=DataGrid[i,j].Count;
                  if (k<n) then
                  begin
                    Row:=i;
                    Col:=j;
                    fd:=DataGrid[i,j];
                    n:=k;
                    Found:=true;
                  end;
                end;
            if Found then k:=GetDigit(DataGrid[Row,Col]);
            Found:=k>0;
            while not Found and (sp>1) do
            begin
              dec(sp);
              with gs[sp] do
              begin
                Row:=r;
                Col:=c;
                DigitGrid:=DGrid;
                fd:=CField;
                k:=GetDigit(fd);
              end;
              Found:=k>0;
            end;
          until Found or (sp=1);
          if not Found and (sp=1) then
          begin
            p1p4.caption:=' Keine Lösung gefunden!';
            MessageDlg ('Konnte keine Lösung finden!',mtError,[mbOK],0);
            Exit;
          end;
          with gs[sp] do
          begin
            r:=Row;
            c:=Col;
            DGrid:=DigitGrid;
            CField:=fd;
            if sp<81 then inc(sp);
          end;
          DigitGrid[Row,Col]:=k;
        end;
        if (CCount mod 1000)=0 then
        begin
          UpdateGrid(DigitGrid);
          p1p4.caption:=' Computerlösung nach '+IntToStr(CCount)+' Schritten';
          Application.ProcessMessages;
        end;
        inc(CCount);
      until Ende;
     if Stop then p1p4.caption:=' Berechnung abgebrochen!'
             else p1p4.caption:=' Lösung gefunden ('+IntToStr(CCount)+' Schritte)';
     UpdateGrid(DigitGrid);
     Application.ProcessMessages;
   end;
   pb4paint(sender);
   pb5paint(sender);
end;

procedure TForm1.p1d13Click(Sender: TObject);
var
   Bitmap: TBitmap;
   birect:trect;
begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := pb5.Width;
  Bitmap.Height := pb5.Height;
  BiRect := Rect(0,0,bitmap.width,bitmap.height);
  try
    with Bitmap.Canvas do
      CopyRect(biRect, pb5.Canvas, biRect);
    Clipboard.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
  image1.Picture.Assign(Clipboard);
  normaldruck_breite(image1,ein_int(edit2));
end;

procedure TForm1.EnableEdit;
begin
    with p1Feld do
    begin
      Options:=Options+[goAlwaysShowEditor];
      EditorMode:=true;
    end;
end;

procedure TForm1.LoadData (FName : string);
var
  ft  : TextFile;
  i,j : integer;
  s,t : string;
  err : boolean;
begin
    AssignFile(ft,FName);
    reset(ft);
    err:=false;
    i:=0;
    while not Eof(ft) do
    begin
      readln(ft,s);
      s:=TrimLeft(s);
      if (length(s)>0) and (s[1]<>';') and (i<9) then
      begin
        with p1Feld do
          for j:=0 to 8 do
          begin
            Objects[i,j]:=pointer(0);
            t:=Trim(ReadNxtStr(s,','));
            if length(t)=0 then Cells[j,i]:=''
            else
            begin
              try
                StrToInt(t)
              except
                err:=true;
              end;
              Cells[j,i]:=t;
            end;
          end;
        inc(i);
      end;
    end;
    CloseFile(ft);
    if err then MessageDlg('Fehlerhafte Daten '#13+FName,mtError,[mbOK],0)
    else
    begin
      TextName:=FName;
      EnableEdit;
      p1p4.caption:='';
    end;
end;

procedure TForm1.p2S19Click(Sender: TObject);
begin
    bilddruckenpb(pb1);
end;

procedure TForm1.p2S7Click(Sender: TObject);
//var f:tfilestream;
//    Bitmap: TBitmap;
//    myrect,birect:trect;
begin
{    p2sd1.filterindex:=1;
    p2sd1.filename:='';
    if p2sd1.execute then
    begin
      try}
        pb1paint(sender);
        bildspeichern(pb1);
{      finally
        Bitmap := TBitmap.Create;
        Bitmap.Width := pb1.Width;
        Bitmap.Height := pb1.Height;
        birect.left:=1;
        birect.right:=pb1.width;
        birect.top:=1;
        birect.bottom:=pb1.height;
        myrect:=birect;
        bitmap.canvas.CopyRect(biRect,pb1.Canvas, MyRect);

        if p2sd1.filterindex=2 then Bitmap.PixelFormat := pf4bit;
        if p2sd1.filterindex<3 then
        begin
          f:=tfilestream.create(p2sd1.filename,fmcreate);
          bitmap.savetostream(f);
          f.free;
        end;
        if p2sd1.filterindex=3 then savejpg(bitmap,p2sd1.filename,100,false);
        if p2sd1.filterindex=4 then gifsave(bitmap,p2sd1.filename);
        Bitmap.Free;
      end;
    end;}
end;

procedure TForm1.p2s1Click(Sender: TObject);
begin
    bildkopieren(pb1);
end;

procedure TForm1.p2t2Timer(Sender: TObject);
var su,i,j,k,z,fpaare:integer;
    frei:array[1..144] of byte;
    paare:boolean;
begin
    p2l1.caption:='noch '+inttostr(spielsteine)+' Spielsteine';
    tpunkte:=tpunkte-1;
    p2l3.caption:=timetostr(now-startzeit);
    su:=0;
    for i:=1 to 16 do
      for j:=1 to 10 do su:=su+tai[i,j,1];
    if su=0 then
    begin
      p2t2.enabled:=false;
      memo9change(sender);
      exit;
    end;

    z:=1;
    fillchar(frei,sizeof(frei),0);
    for i:=1 to 16 do
      for j:=1 to 10 do
        for k:=1 to 5 do
        begin
          if (tai[i,j,k]>0) and (tai[i,j,k]<43) and (tai[i,j,k+1]=0) and
             (tai[i-1,j,k]*tai[i+1,j,k]=0) then
          begin
            frei[z]:=tai[i,j,k];
            inc(z)
          end;
        end;
        dec(z);
        for i:=1 to z do
        begin
          if frei[i] in [35..38] then frei[i]:=35;
          if frei[i] in [39..42] then frei[i]:=39;
        end;
        for i:=1 to z-1 do
          for j:=i+1 to z do
          begin
            if frei[i]>frei[j] then
            begin
              k:=frei[i];
              frei[i]:=frei[j];
              frei[j]:=k;
            end;
          end;
        paare:=false;
        fpaare:=0;
        for i:=2 to z do
        begin
          if frei[i]=frei[i-1] then
          begin
            paare:=true;
            inc(fpaare);
          end;
        end;
        p2l5.caption:=inttostr(fpaare)+' mögliche Paare';
        if paare=false then
        begin
          p2t2.enabled:=false;
          showmessage('Keine freien Paare mehr verfügbar!');//fst(665);
          tpunkte:=round((tpunkte-10000/144*spielsteine)/1.5);
          if tpunkte>0 then memo9change(sender);
        end;
end;

procedure TForm1.p2LB1Click(Sender: TObject);
var kk:string;
begin
    p2cb1.checked:=false;
    taityp:=p2lb1.itemindex;
    kk:=p2lb1.items.Strings[taityp];
    p2p3.caption:=kk;
    spielname:='Mahjongg '+kk;
    p2d9click(sender);
end;

procedure TForm1.p2D9Click(Sender: TObject);
var kette:array[1..144] of byte;
    m,i,j,k,h,z:integer;
    kk:string;
begin
    p2cb1.checked:=false;
    for i:=1 to 34 do
    begin
      kette[i]:=i;
      kette[i+34]:=i;
      kette[i+68]:=i;
      kette[i+102]:=i;
    end;
    for i:=1 to 8 do kette[136+i]:=i+34;
    fillchar(tai,sizeof(tai),0);
    for k:=1 to 1000 do
    begin
      i:=random(144)+1;
      j:=random(144)+1;
      h:=kette[i];
      kette[i]:=kette[j];
      kette[j]:=h;
    end;

    z:=1;
    m:=0;
    if taityp=0 then
    begin
      tai[1,6,1]:=43;
      tai[14,6,1]:=43;
      tai[15,6,1]:=43;
    end;
    repeat
      kk:=p2lb2.items[m];
      inc(m);
    until kk='[T'+inttostr(taityp);
    for j:=1 to 10 do
    begin
      kk:=p2lb2.items[m+j-1];
      for i:=1 to 16 do
      begin
        h:=ord(kk[i])-48;
        if h>0 then
          for k:=1 to h do
          begin
            tai[i,j,k]:=kette[z];
            inc(z);
          end;
      end;
    end;
    spielsteine:=z-1;
    tai1.x:=0;
    tai1.y:=0;
    tai1.z:=0;
    tai2.x:=0;
    tai2.y:=0;
    tai2.z:=0;
    tpunkte:=20000;
    p2t2.enabled:=true;
    startzeit:=now;
    pb1paint(sender);
end;

procedure TForm1.p2E4Change(Sender: TObject);
begin
    xname:=p2e4.text;
end;

procedure pic2i(can:tcanvas;a,b:integer;nr:integer);
var bild:tbitmap;
begin
    bild:=tbitmap.create;
    bild.loadfromresourceid(hinstance,nr);
    can.CopyMode:=cmnotsrccopy;
    can.draw(a,b,bild);
    can.CopyMode:=cmsrccopy;
    bild.free;
end;

procedure TForm1.p2CB1Click(Sender: TObject);
var z,i,j,k,a,b,c,ox:integer;
    frei:array[1..144] of byte;
procedure stein(i,j,k:integer;w:byte);
var x,y:integer;
begin
    if (w>0) and (w<43) then
    begin
      x:=i*36+(k-1)*6;
      y:=j*36-(k-1)*6;
      if taityp=0 then
      begin
        if i in [1,14,15] then y:=y+18;
        if k=5 then begin x:=x+18; y:=y+18 end;
      end;
      x:=x+ox;
      pic2i(pb1.canvas,x,y,12000+w)
    end;
end;
begin
    if p2cb1.checked then
    begin
      tpunkte:=tpunkte-50;
      b:=pb1.width;
      if b>600 then ox:=(b-600) div 2
               else ox:=0;
      z:=1;
      fillchar(frei,sizeof(frei),0);
      for i:=1 to 16 do
        for j:=1 to 10 do
          for k:=1 to 5 do
          begin
            if (tai[i,j,k]>0) and (tai[i,j,k]<43) and (tai[i,j,k+1]=0) and
              (tai[i-1,j,k]*tai[i+1,j,k]=0) then
            begin
              frei[z]:=tai[i,j,k];
              inc(z)
            end;
          end;
      dec(z);
      for i:=1 to z do
      begin
        if frei[i] in [35..38] then frei[i]:=35;
        if frei[i] in [39..42] then frei[i]:=39;
      end;
      for i:=1 to z-1 do
        for j:=i+1 to z do
        begin
          if frei[i]>frei[j] then
          begin
            k:=frei[i];
            frei[i]:=frei[j];
            frei[j]:=k;
          end;
        end;
      for i:=2 to z do
      begin
        if frei[i]=frei[i-1] then
        begin
          for a:=1 to 16 do
          begin
            for b:=1 to 10 do
            begin
              for c:=1 to 5 do
              begin
                if (tai[a,b,c]>0) and (tai[a,b,c]<43) and (tai[a,b,c+1]=0) and
                   (tai[a-1,b,c]*tai[a+1,b,c]=0) then
                begin
                  if (tai[a,b,c]=frei[i]) or (tai[a,b,c]=frei[i-1]) then
                    stein(a,b,c,frei[i]);
                  if ((frei[i]=35) or (frei[i-1]=35)) and (tai[a,b,c] in [35..38]) then
                    stein(a,b,c,tai[a,b,c]);
                  if ((frei[i]=39) or (frei[i-1]=39)) and (tai[a,b,c] in [39..42]) then
                    stein(a,b,c,tai[a,b,c]);
                end;
              end
            end
          end
        end;
      end;
    end
    else pb1paint(sender);
end;

procedure TForm1.p2D1Click(Sender: TObject);
var talt:integer;
begin
    talt:=tpunkte;
    tpunkte:=0;
    memo9change(sender);
    tpunkte:=talt;
end;

procedure TForm1.PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
label 1;
var ox,b,x0,y0,i,j,k:integer;
    ta:_tai;
begin
    p2cb1.checked:=false;
    tpunkte:=tpunkte-1;
    b:=pb1.width;
    if b>600 then ox:=(b-600) div 2
             else ox:=0;
    x:=x-ox;

    if taityp=0 then
    begin
      if tai[7,5,5]>0 then
      begin
        if (abs(x-312)<19) and (abs(y-156-36)<19) then
        begin
          ta.x:=7;
          ta.y:=5;
          ta.z:=5;
          goto 1;
        end;
      end;

      if (x>=270) and (x<=342) and (y>=126+36) and (y<=198+36) then
      begin
        if tai[7,5,5]=0 then
        begin
          x0:=x-270;
          y0:=y-126-36;
          i:=(x0 div 36)+7;
          j:=(y0 div 36)+5;
          k:=4;
          if tai[i,j,k]<>0 then
          begin
            ta.x:=i;
            ta.y:=j;
            ta.z:=k;
            goto 1;
          end;
        end;
      end;

      if (x>=228) and (x<=372) and (y>=96+36) and (y<=240+36) then
      begin
        x0:=x-228;
        y0:=y-96-36;
        i:=(x0 div 36)+6;
        j:=(y0 div 36)+4;
        k:=3;
        if (tai[i,j,k]<>0) and (tai[i,j,4]=0) and (tai[i-1,j,k]*tai[i+1,j,k]=0) then
        begin
          ta.x:=i;
          ta.y:=j;
          ta.z:=k;
          goto 1;
        end;
      end;
      if (x>=186) and (x<=402) and (y>=66+36) and (y<=282+36) then
      begin
        x0:=x-186;
        y0:=y-66-36;
        i:=(x0 div 36)+5;
        j:=(y0 div 36)+3;
        k:=2;
        if (tai[i,j,k]<>0) and (tai[i,j,3]=0) and (tai[i-1,j,k]*tai[i+1,j,k]=0) then
        begin
          ta.x:=i;
          ta.y:=j;
          ta.z:=k;
          goto 1;
        end;
      end;

      x0:=x-36;
      y0:=y-36-36;
      i:=(x0 div 36)+1;
      j:=(y0 div 36)+2;
      k:=1;
      if (i<>1) and (i<14) then
      begin
        if (tai[i,j,k]<>0) and (tai[i,j,2]=0) and (tai[i-1,j,k]*tai[i+1,j,k]=0) then
        begin
          ta.x:=i;
          ta.y:=j;
          ta.z:=k;
          goto 1;
        end;
      end;
      x0:=x-36;
      y0:=y-54-36;
      i:=(x0 div 36)+1;
      j:=(y0 div 36)+2;
      k:=1;
      if (i=14) and (tai[i,j,k]<>0) and (tai[15,j,k]=0) then
      begin
        ta.x:=i;
        ta.y:=j;
        ta.z:=k;
        goto 1;
      end;
      if (i=1) or (i=15) then
      begin
        if (tai[i,j,k]<>0) then
        begin
          ta.x:=i;
          ta.y:=j;
          ta.z:=k;
          goto 1;
        end;
      end;
    end

    else {if taityp in [1..11] then}
    begin
      for k:=5 downto 1 do
      begin
        x0:=x-(k-1)*6-36;
        y0:=y+(k-1)*6-36-36;
        i:=(x0 div 36)+1;
        j:=(y0 div 36)+2;
        if (i>0) and (i<17) and (j>0) and (j<11) then
        begin
          if (tai[i,j,k]<>0) and (tai[i,j,k+1]=0) and (tai[i-1,j,k]*tai[i+1,j,k]=0) then
          begin
            ta.x:=i;
            ta.y:=j;
            ta.z:=k;
            goto 1;
          end;
        end;
      end;
    end;
    exit;

1 : if (tai1.x=ta.x) and (tai1.y=ta.y) and (tai1.z=ta.z) then tai1.x:=0
    else
    begin
      if tai1.x=0 then
      begin
        tai1.x:=ta.x;
        tai1.y:=ta.y;
        tai1.z:=ta.z;
      end
      else
      begin
        tai2.x:=ta.x;
        tai2.y:=ta.y;
        tai2.z:=ta.z;
      end;
    end;

    if ((tai1.x<>tai2.x) or (tai1.y<>tai2.y) or (tai1.z<>tai2.z))
      and ((tai1.x>0) and (tai1.y>0) and (tai1.z>0))
      and ((tai2.x>0) and (tai2.y>0) and (tai2.z>0)) then
    begin
      if (tai[tai1.x,tai1.y,tai1.z]=tai[tai2.x,tai2.y,tai2.z])
       or
          ((tai[tai1.x,tai1.y,tai1.z] in [35..38]) and
          (tai[tai2.x,tai2.y,tai2.z] in [35..38]))
       or
          ((tai[tai1.x,tai1.y,tai1.z] in [39..42]) and
          (tai[tai2.x,tai2.y,tai2.z] in [39..42])) then
      begin
        tai[tai1.x,tai1.y,tai1.z]:=0;
        tai[tai2.x,tai2.y,tai2.z]:=0;
        dec(spielsteine,2);
        if taityp=0 then
        begin
          if (tai1.x=1) or (tai2.x=1) then tai[1,6,1]:=0;
          if (tai1.x=15) or (tai2.x=15) then tai[15,6,1]:=0;
          if (tai1.x=14) or (tai2.x=14) then tai[14,6,1]:=0;
        end;

        tai1.x:=0; tai1.y:=0; tai1.z:=0;
        tai2.x:=0; tai2.y:=0; tai2.z:=0;
      end
      else
      begin
        tai1.x:=0; tai1.y:=0; tai1.z:=0;
        tai2.x:=0; tai2.y:=0; tai2.z:=0;
      end;
    end;
    pb1paint(sender);
end;

procedure TForm1.PB1Paint(Sender: TObject);
var bitmap:tbitmap;
    myrect,birect:trect;
    b,i,j,ox,k:integer;
procedure stein(i,j,k:integer;w:byte);
var po:array[0..3] of tpoint;
    x,y:integer;
begin
    if (w>0) and (w<43) then
    begin
      x:=i*36+(k-1)*6;
      y:=j*36-(k-1)*6;
      if taityp=0 then
      begin
        if i in [1,14,15] then y:=y+18;
        if k=5 then
        begin
          x:=x+18;
          y:=y+18
        end;
      end;
      x:=x+ox;
      po[0].x:=x; po[0].y:=y;
      po[1].x:=x-6; po[1].y:=y+6;
      po[2].x:=x-6; po[2].y:=y+42;
      po[3].x:=x;   po[3].y:=y+36;
      bitmap.canvas.polygon(slice(po,4));
      po[0].x:=x+36; po[0].y:=y+36;
      po[1].x:=x+30; po[1].y:=y+42;
      bitmap.canvas.polygon(slice(po,4));
      if ((tai1.x=i) and (tai1.y=j) and (tai1.z=k)) or
        ((tai2.x=i) and (tai2.y=j) and (tai2.z=k)) then
        pic2i(bitmap.canvas,x,y,12000+w)
      else
        pic2(bitmap.canvas,x,y,12000+w);
    end;
end;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=pb1.width;
    bitmap.height:=pb1.height;
    myrect:=pb1.clientrect;
    birect:=myrect;
    b:=pb1.width;
    if b>600 then ox:=(b-600) div 2
             else ox:=0;

    bitmap.canvas.brush.color:=$00808080;
    case taityp of
      0 : begin
            for i:=15 downto 1 do for j:=1 to 8 do stein(i,j+1,1,tai[i,j+1,1]);
            for i:=10 downto 5 do for j:=2 to 7 do stein(i,j+1,2,tai[i,j+1,2]);
            for i:=9 downto 6 do for j:=3 to 6 do stein(i,j+1,3,tai[i,j+1,3]);
            for i:=8 downto 7 do for j:=4 to 5 do stein(i,j+1,4,tai[i,j+1,4]);
            stein(7,5,5,tai[7,5,5]);
          end
     else begin
            for i:=16 downto 1 do for j:=1 to 10 do
            for k:=1 to 5 do stein(i,j,k,tai[i,j,k]);
          end;
    end;
    pb1.Canvas.copyrect(birect,bitmap.canvas,myrect);
    bitmap.free;
end;

procedure Tform1.Memo9Change(Sender: TObject);
begin
    spunkte:=tpunkte;
    if (spunkte>=0) {and isadmin} then
    begin
      Application.CreateForm(Tbestenliste, bestenliste);
      bestenliste.showmodal;
      bestenliste.release;
    end;
end;

procedure TForm1.N20Click(Sender: TObject);
begin
    bildkopieren(form1);
end;

procedure TForm1.N19Click(Sender: TObject);
begin
    screen.cursor:=crhourglass;
    n20Click(Sender);
    p2I1.Picture.Assign(Clipboard);
    waagerechtdruck:=fensterdruck;
    normaldruck(p2i1);
    screen.cursor:=crdefault;
    waagerechtdruck:=poportrait;
end;

procedure TForm1.p3t1Timer(Sender: TObject);
begin
    if integer(gettickcount)-testzeit>100*testlaenge then
    begin
      p3t1.enabled:=false;
      p3l47.caption:='';
    end;
end;

procedure TForm1.p3d13Click(Sender: TObject);
begin
    antwortstring:=p3e3.text;
    if antwortstring=teststring then
    begin
      p3e3.text:='';
      testlaenge:=testlaenge+1;
      case p3rg6.ItemIndex of
        0 : teststring:=teststring+inttostr(random(10));
        1 : teststring:=teststring+chr(65+random(26));
        2 : begin
              if random<0.66 then teststring:=teststring+chr(65+random(26))
                             else teststring:=teststring+inttostr(random(10));
            end;
      end;
      p3l50.caption:='Antwort korrekt!';
      p3l51.caption:=inttostr(testlaenge-1)+' Zeichen erkannt!';
      if testlaenge>=21 then
      begin
        showmessage('Gratulation! 20 Zeichen richtig erkannt!');
        p3d13.visible:=false;
        p3d12.visible:=true;
      end
      else
      begin
        p3l47.caption:=teststring;
        testzeit:=integer(gettickcount);
        p3t1.enabled:=true;
      end;
    end
    else
    begin
      p3l50.caption:='Antwort falsch! Richtig ist ...';
      p3l51.caption:=teststring;
      p3d13.visible:=false;
      p3d12.visible:=true;
    end;
end;

procedure TForm1.M57Click(Sender: TObject);
begin
  case hauptnur of
      6 : p3d13click(sender);
     33 : d5click(sender);
     29 : if panel21.visible then d8click(sender);
    end;
end;

procedure TForm1.p3d12Click(Sender: TObject);
begin
    teststring:='';
    testlaenge:=1;
    p3l50.caption:='';
    p3l51.caption:='';
    case p3rg6.ItemIndex of
      0 : teststring:=teststring+inttostr(random(10));
      1 : teststring:=teststring+chr(65+random(26));
      2 : begin
            if random<0.66 then teststring:=teststring+chr(65+random(26))
                          else teststring:=teststring+inttostr(random(10));
          end;
    end;
    p3d12.visible:=false;
    p3d13.visible:=true;
    p3l47.caption:=teststring;
    testzeit:=integer(gettickcount);
    p3t1.enabled:=true;
end;

procedure Tform1.p4Memo9Change(Sender: TObject);
begin
    spunkte:=1000-zuege;
//    if isadmin then
//    begin
      Application.CreateForm(Tbestenliste, bestenliste);
      bestenliste.showmodal;
      bestenliste.release;
//    end;
    zuege:=0;
    neuesspiel:=false;
end;

procedure TForm1.p5PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b,ox,i,j:integer;
begin
    dec(tpunkte,1);
    b:=p5pb1.width;
    ox:=(b-840) div 2;

    i:=((x-ox) div 105)+1;
    j:=((y-20) div 105)+1;
    if (i in [1..8]) and (j in [1..5]) then
    begin
      if feld[i,j].s=false then
      begin
        if o1.x=0 then
        begin
          o1.x:=i;
          o1.y:=j;
          feld[i,j].s:=true;
          p5pb1paint(sender);
        end
        else
        begin
          if o2.x=0 then
          begin
            o2.x:=i;
            o2.y:=j;
            feld[i,j].s:=true;
            p5pb1paint(sender);
            p5t1.enabled:=true;
          end;
        end;
      end;
    end;
end;

procedure TForm1.p5PB1Paint(Sender: TObject);
var b,ox,i,j,w:integer;
    bitmap{,bx}:tbitmap;
    myrect,birect,r1,r2:trect;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=p5pb1.width;
    bitmap.height:=p5pb1.height;
    myrect:=p5pb1.clientrect;
    birect:=myrect;
    b:=p5pb1.width;
    ox:=(b-840) div 2;
    for i:=1 to 8 do
      for j:=1 to 5 do
      begin
        bitmap.canvas.rectangle(ox+1+(i-1)*105,21+(j-1)*105,ox-2+i*105,18+j*105);
        if feld[i,j].s=false then pic2(bitmap.canvas,ox+2+(i-1)*105,22+(j-1)*105,7724)
        else
        begin
          r1.left:=ox+2+(i-1)*105;
          r1.right:=r1.left+100;
          r1.top:=22+(j-1)*105;
          r1.bottom:=r1.top+100;
          w:=feld[i,j].x;
          r2.left:=2+((w-1) mod 4)*100;
          r2.right:=r2.left+100;
          r2.top:=2+((w-1) div 4)*100;
          r2.bottom:=r2.top+100;
          bitmap.canvas.CopyRect(r1,p5i1.Canvas,r2);
        end;
      end;
      p5pb1.Canvas.copyrect(birect,bitmap.canvas,myrect);
      bitmap.free;
      p5l3.caption:=inttostr(paare)+' Paare';
end;

procedure TForm1.p5T1Timer(Sender: TObject);
begin
    if o1.x<>0 then
    begin
      if feld[o1.x,o1.y].x <> feld[o2.x,o2.y].x then
      begin
        feld[o1.x,o1.y].s:=false;
        feld[o2.x,o2.y].s:=false;
        p5t1.enabled:=false;
        o1.x:=0;
        o2.x:=0;
        dec(tpunkte,2);
        p5pb1paint(sender);
      end
      else
      begin
        p5t1.enabled:=false;
        o1.x:=0;
        o2.x:=0;
        inc(paare);
        p5pb1paint(sender);
        if paare=20 then
        begin
          p5t2.enabled:=false;
          p5d2click(sender);
        end;
      end;
    end;
end;

procedure TForm1.p5T2Timer(Sender: TObject);
begin
    p5l2.caption:=timetostr(now-zeit);
    dec(tpunkte,5);
end;

procedure TForm1.p5e1Change(Sender: TObject);
begin
  xname:=p5e1.text;
end;

procedure TForm1.p5d1Click(Sender: TObject);
var i,j,k,x1,x2,y1,y2:integer;
    ff:_feld;
begin
   p5t2.enabled:=true;
   zeit:=now;
   paare:=0;
   tpunkte:=10000;
   o1.x:=0;
   o2.x:=0;
   k:=1;
   for i:=1 to 4 do
     for j:=1 to 5 do
     begin
       feld[i,j].x:=k;
       feld[4+i,j].x:=k;
       feld[i,j].s:=false;
       feld[4+i,j].s:=false;
       inc(k);
     end;
     for k:=1 to 500 do
     begin
       x1:=random(8)+1;
       x2:=random(8)+1;
       y1:=random(5)+1;
       y2:=random(5)+1;
       ff:=feld[x1,y1];
       feld[x1,y1]:=feld[x2,y2];
       feld[x2,y2]:=ff;
     end;
     p5pb1paint(sender);
end;

procedure TForm1.p5d2Click(Sender: TObject);
begin
    spunkte:=tpunkte;
    if paare<>20 then spunkte:=0;
//    if isadmin then
//    begin
      Application.CreateForm(Tbestenliste, bestenliste);
      bestenliste.showmodal;
      bestenliste.release;
//    end;
    paare:=0;
end;

procedure Tform1.p7B3C(Sender: TObject);
var i,z,h:integer;
begin
    randomize;
    rotor1:='1364';
    rotor2:='4257';
    zuege:=0;
    for i:=1 to 200 do
    begin
      z:=random(2);
      h:=random(2);
      if z=0 then
      begin
        if h=0 then
        begin
          rotor1:=rotor1[4]+copy(rotor1,1,3);
          rotor2[1]:=rotor1[4];
        end
        else
        begin
          rotor1:=copy(rotor1,2,3)+rotor1[1];
          rotor2[1]:=rotor1[4];
        end;
      end;
      if z=1 then
      begin
        if h=0 then
        begin
          rotor2:=rotor2[4]+copy(rotor2,1,3);
          rotor1[4]:=rotor2[1];
        end
        else
        begin
          rotor2:=copy(rotor2,2,3)+rotor2[1];
          rotor1[4]:=rotor2[1];
        end;
      end;
    end;
end;

procedure TForm1.p8D5Click(Sender: TObject);
var i,j,z,h:integer;
    spiel:array[1..64] of integer;
    frei:boolean;
begin
    randomize;
    aktuellesspiel:=true;
    zuege:=0;
    p8l26.caption:='0';
    for i:=1 to p8feld*p8feld do spiel[i]:=i;
    z:=1;
    repeat
      i:=random(p8feld*p8feld)+1;
      j:=random(p8feld*p8feld)+1;
      h:=spiel[i];
      spiel[i]:=spiel[j];
      spiel[j]:=h;
      z:=z+abs(i-j);
    until (z>20*p8feld*p8feld);

    i:=1;
    frei:=false;
    repeat
      if spiel[i]=p8feld*p8feld then frei:=true;
      inc(i);
    until (i>p8feld*p8feld) or frei;
    spiel[i-1]:=spiel[p8feld*p8feld];
    spiel[p8feld*p8feld]:=0;
    z:=0;
    for i:=1 to p8feld*p8feld-2 do
      for j:=i+1 to p8feld*p8feld-1 do
        if spiel[i]>spiel[j] then inc(z);

    if odd(z) then
    begin
      h:=spiel[2];
      spiel[2]:=spiel[1];
      spiel[1]:=h;
    end;

    z:=1;
    for i:=1 to p8feld do
      for j:=1 to p8feld do
      begin
        belegung[j,i]:=spiel[z];
        inc(z);
      end;
    for i:=0 to p8feld+1 do
    begin
      belegung[i,0]:=-1;
      belegung[i,p8feld+1]:=-1;
      belegung[0,i]:=-1;
      belegung[p8feld+1,i]:=-1;
    end;
    p8zeichnen(sender);
end;

procedure TForm1.p8r6Change(Sender: TObject);
begin
  p8feld:=round(p8r6.value);
  spielname:='Spiel 15 : '+inttostr(p8feld)+'x'+inttostr(p8feld);
  aktuellesspiel:=true;
  p8button3click(sender);
end;

procedure TForm1.p8E3Change(Sender: TObject);
begin
    xname:=p8e3.text;
end;

procedure TForm1.p8D1Click(Sender: TObject);
begin
   spunkte:=0;
//   if isadmin then
//   begin
     Application.CreateForm(Tbestenliste, bestenliste);
     bestenliste.showmodal;
     bestenliste.release;
//   end;
end;

procedure TForm1.p8pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var li,ob,xx,yy:integer;
    freiesp8feld:boolean;
begin
    li:=(p8pb1.width-80*p8feld) div 2;
    ob:=(p8pb1.height-80*p8feld) div 2;
    xx:=(x-li+80) div 80;
    yy:=(y-ob+80) div 80;
    if (xx>0) and (xx<=p8feld) and (yy>0) and (yy<=p8feld) then
    begin
      freiesp8feld:=false;
      if belegung[xx-1,yy]=0 then
      begin
        li:=xx-1;
        ob:=yy;
        freiesp8feld:=true
      end;
      if belegung[xx+1,yy]=0 then
      begin
        li:=xx+1;
        ob:=yy;
        freiesp8feld:=true
      end;
      if belegung[xx,yy-1]=0 then
      begin
        li:=xx;
        ob:=yy-1;
        freiesp8feld:=true
      end;
      if belegung[xx,yy+1]=0 then
      begin
        li:=xx;
        ob:=yy+1;
        freiesp8feld:=true
      end;
      if freiesp8feld then
      begin
        belegung[li,ob]:=belegung[xx,yy];
        belegung[xx,yy]:=0;
        inc(zuege);
        p8zeichnen(sender);
      end;
    end;
end;

procedure TForm1.p8pb1Paint(Sender: TObject);
begin
  p8zeichnen(sender);
end;

procedure tform1.p8zeichnen(sender: tobject);
var Bitmap: TBitmap;
    myrect,birect:trect;
    b,h:integer;

procedure spielp8feld15;
var i,j,li,ob,z:integer;
    endergebnis:boolean;
    bitmap2:tbitmap;
    myrect,birect:trect;
begin
  bitmap2:=tbitmap.create;
  bitmap2.loadfromresourceid(hinstance,7002);
  myrect.top:=1; myrect.bottom:=80;
  myrect.left:=1; myrect.right:=80;

  p8l26.caption:=inttostr(zuege);
  li:=(b-80*p8feld) div 2;
  ob:=(h-80*p8feld) div 2;
  bitmap.canvas.pen.color:=clblue;
  bitmap.canvas.pen.width:=3;

  bitmap.canvas.rectangle(li-4,ob-4,li+80*p8feld+4,ob+80*p8feld+4);
  bitmap.canvas.Font.size:=20;
  bitmap.canvas.Font.color:=clblack;
  bitmap.canvas.pen.color:=clred;
  bitmap.canvas.pen.width:=1;
  bitmap.canvas.brush.style:=bsclear;

  for i:=1 to p8feld do
    for j:=1 to p8feld do
    begin
      if belegung[i,j]<>0 then
      begin
        birect.left:=li+i*80-80;
        birect.right:=birect.left+80;
        birect.top:=ob+j*80-80;
        birect.bottom:=birect.top+80;
        bitmap.canvas.CopyRect(biRect,bitmap2.Canvas,MyRect);

        if belegung[i,j]<10 then
          bitmap.canvas.textout(li+i*80-50,ob+j*80-58,inttostr(belegung[i,j]))
        else
         bitmap.canvas.textout(li+i*80-60,ob+j*80-58,inttostr(belegung[i,j]));
      end;
    end;
  endergebnis:=true;
  z:=1;
  for i:=1 to p8feld do
    for j:=1 to p8feld do
      if (i<>p8feld) or (j<>p8feld) then
      begin
        endergebnis:=endergebnis and (belegung[j,i]=z);
        inc(z);
      end;
  if endergebnis and aktuellesspiel then auswertung2(sender);
  bitmap2.Free;
end;

begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := p8pb1.Width;
  Bitmap.Height := p8pb1.Height;
  bitmap.canvas.font.name:='Verdana';
  bitmap.canvas.font.size:=10;
  birect.left:=1;
  birect.right:=p8pb1.width;
  birect.top:=1;
  birect.bottom:=p8pb1.height;
  myrect:=birect;
  setbkmode(bitmap.canvas.handle,transparent);
  b:=bitmap.width;
  h:=bitmap.height;

  try
   spielp8feld15;
   p8pb1.canvas.CopyRect(biRect,bitmap.Canvas, MyRect);
  finally
    Bitmap.Free;
  end;
end;

procedure tform1.auswertung2;
begin
   spunkte:=100000-zuege;
//   if isadmin then
//   begin
     Application.CreateForm(Tbestenliste, bestenliste);
     bestenliste.showmodal;
     bestenliste.release;
//   end;
   aktuellesspiel:=false;
end;

procedure Tform1.p8Button3Click(Sender: TObject);
var i,j,z,h:integer;
    spiel:array[1..64] of integer;
    frei:boolean;
begin
    randomize;
    aktuellesspiel:=true;
    zuege:=0;
    p8l26.caption:='0';
    for i:=1 to p8feld*p8feld do spiel[i]:=i;
    z:=1;
    repeat
      i:=random(p8feld*p8feld)+1;
      j:=random(p8feld*p8feld)+1;
      h:=spiel[i];
      spiel[i]:=spiel[j];
      spiel[j]:=h;
      z:=z+abs(i-j);
    until (z>20*p8feld*p8feld);

    i:=1;
    frei:=false;
    repeat
      if spiel[i]=p8feld*p8feld then frei:=true;
      inc(i);
    until (i>p8feld*p8feld) or frei;
    spiel[i-1]:=spiel[p8feld*p8feld];
    spiel[p8feld*p8feld]:=0;
    z:=0;
    for i:=1 to p8feld*p8feld-2 do
      for j:=i+1 to p8feld*p8feld-1 do
        if spiel[i]>spiel[j] then inc(z);

    if odd(z) then
    begin
      h:=spiel[2];
      spiel[2]:=spiel[1];
      spiel[1]:=h;
    end;

    z:=1;
    for i:=1 to p8feld do
      for j:=1 to p8feld do
      begin
        belegung[j,i]:=spiel[z];
        inc(z);
      end;
    for i:=0 to p8feld+1 do
    begin
      belegung[i,0]:=-1;
      belegung[i,p8feld+1]:=-1;
      belegung[0,i]:=-1;
      belegung[p8feld+1,i]:=-1;
    end;
    p8zeichnen(sender);
end;

procedure TForm1.p6T1Timer(Sender: TObject);
var x,y,i,j,offset,b,h:integer;
    r1,r2:trect;
begin
    if zaehler=0 then
    begin
      p6pb2.canvas.rectangle(-1,-1,p6pb2.width+1,p6pb2.height+1);
      for i:=1 to level+1 do anzeige[i]:=random(20);
      symbole:=symbole+level+1;
    end;
    b:=(p6pb2.width-500) div 2;
    h:=(p6pb2.height-400) div 4;
    case level of
      8,9 : offset:=0;
      6,7 : offset:=0;
      4,5 : offset:=50;
      3,2 : offset:=100;
      0,1 : offset:=150;
      else offset:=0;
    end;
    for i:=1 to level+1 do
    begin
      x:=anzeige[i] div 5;
      y:=anzeige[i] mod 5;
      r1.left:=offset+b{200}+((i-1) div 2)*100;
      r1.right:=r1.left+100;
      r1.top:=h{180}+100+100*((i-1) mod 2);
      r1.bottom:=r1.top+100;
      r2.left:=x*100;
      r2.right:=x*100+100;
      r2.top:=y*100;
      r2.bottom:=y*100+100;
      p6pb2.canvas.CopyRect(r1,p6i1.Canvas,r2);
    end;
    inc(zaehler);
    if zaehler>=zeitmax-4 then
    begin
      tip:=0;
      for i:=1 to 20 do
      begin
        x:=(i-1) div 5;
        y:=(i-1) mod 5;
        r1.left:=b{155}+y*100;
        r1.right:=r1.left+100;
        r1.top:=h{110}+100*x;
        r1.bottom:=r1.top+100;
        r2.left:=x*100;
        r2.right:=x*100+100;
        r2.top:=y*100;
        r2.bottom:=y*100+100;
        p6pb2.canvas.CopyRect(r1,p6i1.Canvas,r2);
      end;
      for i:=0 to 5 do
      begin
        p6pb2.canvas.moveto(b+i*100,h);
        p6pb2.canvas.lineto(b+i*100,h+400);
      end;
      for j:=0 to 4 do
      begin
        p6pb2.canvas.moveto(b,h+100*j);
        p6pb2.canvas.lineto(b+500,h+100*j);
      end;
      p6t1.enabled:=false;
      p6t1.interval:=0;
    end;
end;

procedure TForm1.p6PB2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var xx,yy,nr,b,h:integer;

begin
   if button=mbleft then
   begin
     if zaehler>0 then
     begin
       b:=(p6pb2.width-500) div 2;
       h:=(p6pb2.height-400) div 4;
       xx:=(x-b) div 100;
       yy:=(y-h) div 100;
       nr:=xx+yy*5;
       if (nr>=0) and (nr<=19) then
       begin
         inc(tip);
         erg[tip]:=nr;
         p6l1.caption:=inttostr(tip)+'/'+inttostr(level+1);
         if tip=level+1 then p6auswertung(sender);
       end;
     end;
   end;
end;

procedure TForm1.p6D4Click(Sender: TObject);
begin
   zaehler:=0;
   p6d4.visible:=false;
   fillchar(anzeige,sizeof(anzeige),#0);
   p6t1.enabled:=true;
   p6t1.interval:=110;
end;

procedure TForm1.p6P6Resize(Sender: TObject);
begin
   p6d4.left:=p6p2.width+(p6p6.width-p6p2.width-p6d4.width) div 2;
end;

procedure tform1.p6auswertung;
var i,j,ri,b,h:integer;
    kk:string;
begin
    zaehler:=0;
    b:=(p6pb2.width-360) div 2;
    h:=(p6pb2.height-160) div 4;
    p6pb2.canvas.rectangle(-1,-1,p6pb2.width+1,p6pb2.height+1);
    ri:=0;
    for i:=1 to level+1 do
      for j:=1 to level+1 do
      begin
        if erg[i]=anzeige[j] then
        begin
          inc(ri);
          anzeige[j]:=-1;
          erg[i]:=-2
        end;
      end;
      str(ri,kk);
      if ri=1 then kk:=kk+' Symbol richtig'
              else kk:=kk+' Symbole richtig';
      p6pb2.canvas.textout(b,h,kk);
      if (ri<>level+1) then inc(zeitmax)
                       else zeitmax:=10;
      if (ri=0) and (level>0) then
      begin
        dec(level);
        if level<0 then level:=0;
        str(level,kk);
        kk:='Neue Stufe ...'+kk;
        p6pb2.canvas.textout(b,h+60,kk);
        p6l3.caption:='Stufe '+inttostr(level);
      end;
      if (ri=level+1) and (level<9) then
      begin
        inc(level);
        if level>9 then level:=9;
        str(level,kk);
        kk:='Neue Stufe ...'+kk;
        p6pb2.canvas.textout(b,h+60,kk);
        p6l3.caption:='Stufe '+inttostr(level);
      end;
      rsymbole:=rsymbole+ri;
      p6l4.caption:='Symbole '+inttostr(symbole);
      p6l2.caption:='Richtige '+inttostr(rsymbole);
      if symbole>0 then
        p6l5.caption:='Richtige ... '+_str2komma(100.0*rsymbole/symbole)+' %';
      p6l6.caption:='Zeit '+inttostr(zeitmax);
      p6d4.visible:=true;
end;

procedure TForm1.p9d1Click(Sender: TObject);
var j:integer;
begin
    p9M2.Clear;
    if strtoint(p9e1.text)>100 then p9e1.text:='100';
    if strtoint(p9e1.text)<10 then p9e1.text:='10';
    p9e2.text:='3';
    if p9r3.itemindex=0 then
    begin
      randomize;
      a:=random(91)+10;
    end
    else a:=strtoint(p9e1.text);

    gesamtzahl:=a;
    p9PB1paint(sender);
    if p9cb2.checked then
    begin
      if p9r4.itemindex=1 then
        CASE (a mod 4) of
          1: j:=random(3)+1;
        else j:=(a-1) mod 4;
        end
      else
        CASE (a mod 4) of
          0: j:=random(3)+1;
        else j:= a mod 4;
        end;
      a:=a-j;
      p9PB1paint(sender);
    end;
end;

procedure TForm1.p9E1Click(Sender: TObject);
begin
    p9r3.itemindex:=1;
end;

procedure TForm1.daniel2(Sender: TObject);
var j:integer;
begin
   if p9r4.itemindex=1 then
     CASE (a mod 4) of
       1: j:=random(3)+1;
     else j:=(a-1) mod 4;
     end
   else
     if a<4 then j:=a
     else
       CASE (a mod 4) of
         0: j:=random(3)+1;
       else j:= a mod 4;
       end;
   a:=a-j;
   p9PB1paint(sender);

   p9e2.text:='3';
   p9M2.text:='Noch '+inttostr(a)+' Hölzer';
   if p9r4.itemindex=1 then
     if a=1 then
     begin
       p9M2.text:='Leider ist nur noch ein Streichholz übrig. Sie haben verloren.';
     end;
   if p9r4.itemindex=0 then
   begin
     if a<1 then
     begin
       p9M2.text:='Der Computer beseitigte das letzte Streichholz. Sie haben verloren.';
     end
     else
     begin
       if a<4 then
       begin
         p9M2.text:='Es bleiben noch soviele Hölzer stehen wie sie entfernen können. Sie haben gewonnen.';
       end;
     end;
   end;
end;

procedure TForm1.p9d2Click(Sender: TObject);
begin
    daniel(sender);
    if a=1 then
    begin
      if p9r4.itemindex=1 then
        p9M2.text:='Es existiert nur noch ein Streichholz. Sie haben gewonnen!'
      else
        p9M2.text:='Der Computer nimmt das letzte Streichholz. Sie haben verloren.';
    end
    else daniel2(sender);
end;

procedure TForm1.p9d3Click(Sender: TObject);
begin
    daniel(sender);
    p9d2click(sender);
end;

procedure TForm1.p9d4Click(Sender: TObject);
begin
    daniel(sender);
    daniel(sender);
    p9d2click(sender);
end;

procedure TForm1.p9PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    daniel(sender);
    if a=1 then
    begin
      if p9r4.itemindex=1 then
        p9M2.text:='Es existiert nur noch ein Streichholz. Sie haben gewonnen!'
      else
        p9M2.text:='Der Computer nimmt das letzte Streichholz. Sie haben verloren.';
    end;
end;

procedure TForm1.p9PB1Paint(Sender: TObject);
var i:integer;
    bild,bild2:tbitmap;
begin
    bild2:=tbitmap.create;
    bild2.width:=p9PB1.width;
    bild2.height:=p9PB1.height;

    bild:=tbitmap.create;
    bild.loadfromresourceid(hinstance,101);
    for i:=0 to a-1 do bild2.canvas.draw((i mod 15)*aa,(i div 15)*90,bild);
    bild.free;

    if a<>gesamtzahl then
    begin
      bild:=tbitmap.create;
      bild.loadfromresourceid(hinstance,102);
      for i:=a to gesamtzahl-1 do
      BEGIN
        bild2.canvas.draw((i mod 15)*aa+1,(i div 15)*90+1,bild);
      END;
      bild.free;
    end;
    p9PB1.Canvas.draw(10,10,bild2);
    bild2.free;
    p9M2.text:='Noch '+inttostr(a)+' Hölzer';
end;

procedure Tform1.daniel;
begin
    if p9e2.text<>'0' then
    begin
      p9PB1paint(sender);
      a:=a-1;
      if a<0 then a:=0;
      p9e2.text:=inttostr(strtoint(p9e2.text)-1);
    end;
end;

type
TRGBArray    = ARRAY[0..0] OF TRGBTriple;
pRGBArray    = ^TRGBArray;

type THelpRGB = packed record
                   rgb    : TRGBTriple;
                   dummy  : byte;
                end;
type TMyhelp = array[0..0] of TRGBQuad;

procedure Drehen90Grad(Bitmap:TBitmap);
var P       : PRGBQuad;
    x,y,b,h : Integer;
    RowOut  : ^TMyHelp;
    help    : TBitmap;
BEGIN
    Bitmap.PixelFormat := pf32bit;
    help := TBitmap.Create;
    help.PixelFormat := pf32bit;
    b := bitmap.Height;
    h := bitmap.Width;
    help.Width := b;
    help.height := h;
    for y := 0 to (h-1) do
    begin
      rowOut := help.ScanLine[y];
      P  := Bitmap.scanline[bitmap.height-1];
      inc(p,y);
      for x := 0 to (b-1) do
      begin
        rowout[x] := p^;
        inc(p,h);
      end;
    end;
    bitmap.Assign(help);
    help.free;
end;

procedure TForm1.puzzledarstellen(Sender: TObject);
var myrect,birect,nrect:trect;
    bitmap:tbitmap;
    ii,i,j,z1,z2,korrekt:integer;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=640;
    bitmap.height:=480;

    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        z2:=(puzzlef[i,j].m-1) div x12 +1;
        z1:=(puzzlef[i,j].m-1) mod x12 +1;

        nRect := Rect(0,0,b12,b12);
        BiRect := Rect((i-1)*b12,(j-1)*b12,i*b12,j*b12);
        case b12 of
          40 : begin
                 image4.canvas.copyrect(nrect,ipu0.canvas,birect);
                 image4.Picture.bitmap.PixelFormat := pf24bit;
               end;
          80 : begin
                 image2.canvas.copyrect(nrect,ipu0.canvas,birect);
                 image2.Picture.bitmap.PixelFormat := pf24bit;
               end;
          else begin
                 image1.canvas.copyrect(nrect,ipu0.canvas,birect);
                 image1.Picture.bitmap.PixelFormat := pf24bit;
        end;
      end;

    if puzzlef[i,j].n mod 4>0 then
    begin
      for ii:=1 to puzzlef[i,j].n mod 4 do
        case b12 of
          40 : Drehen90Grad(image4.picture.bitmap);
          80 : Drehen90Grad(image2.picture.bitmap);
          else Drehen90Grad(image1.picture.bitmap);
        end;
    end;

    if not (puzzleschieben and (i=pui) and (j=puj)) then
    begin
      myRect := Rect((z1-1)*b12,(z2-1)*b12,z1*b12,z2*b12);
      case b12 of
        40 : bitmap.canvas.copyrect(myrect,image4.canvas,nrect);
        80 : bitmap.canvas.copyrect(myrect,image2.canvas,nrect);
        else bitmap.canvas.copyrect(myrect,image1.canvas,nrect);
      end;
    end;
    end;

    if puzzleschieben then
    begin
      z2:=(puzzlef[pui,puj].m-1) div x12 +1;
      z1:=(puzzlef[pui,puj].m-1) mod x12 +1;
      nRect := Rect(0,0,b12,b12);
      BiRect := Rect((pui-1)*b12,(puj-1)*b12,pui*b12,puj*b12);
      case b12 of
        40 : begin
               image4.canvas.copyrect(nrect,ipu0.canvas,birect);
               image4.Picture.bitmap.PixelFormat := pf24bit;
             end;
        80 : begin
               image2.canvas.copyrect(nrect,ipu0.canvas,birect);
               image2.Picture.bitmap.PixelFormat := pf24bit;
             end;
        else begin
              image1.canvas.copyrect(nrect,ipu0.canvas,birect);
              image1.Picture.bitmap.PixelFormat := pf24bit;
             end;
      end;

      if puzzlef[pui,puj].n mod 4>0 then
      begin
        for ii:=1 to puzzlef[pui,puj].n mod 4 do
        begin
          case b12 of
            40 : Drehen90Grad(image4.picture.bitmap);
            80 : Drehen90Grad(image2.picture.bitmap);
            else Drehen90Grad(image1.picture.bitmap);
          end;
        end;
      end;

      myRect := Rect((z1-1)*b12-puvx,(z2-1)*b12-puvy,z1*b12-puvx,z2*b12-puvy);

      case b12 of
        40 : bitmap.canvas.copyrect(myrect,image4.canvas,nrect);
        80 : bitmap.canvas.copyrect(myrect,image2.canvas,nrect);
        else bitmap.canvas.copyrect(myrect,image1.canvas,nrect);
      end;
    end;

    paintbox1.canvas.draw(0,0,bitmap);
    bitmap.free;
    l10.caption:='Züge '+inttostr(puzzlezug); korrekt:=0;
    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        if (puzzlef[i,j].m=i+(j-1)*x12) and (puzzlef[i,j].n=0) then inc(korrekt);
      end;
    if not schiebepuzzle then
      l3.caption:='korrekte Teile '+inttostr(korrekt)
    else
      l3.caption:='noch '+inttostr(length(geschoben))+' Züge';
    if (korrekt=x12*y12) and (not nochkeinbild) then
    begin
      case rg1.itemindex of
        2 : tpunkte:=50000-2*puzzlezug-2*((integer(gettickcount)-puzzlezeit) div 1000);
        0 : tpunkte:=8000-2*puzzlezug-2*((integer(gettickcount)-puzzlezeit) div 1000);
      else
            tpunkte:=16000-2*puzzlezug-2*((integer(gettickcount)-puzzlezeit) div 1000);
      end;
      timer1.enabled:=false;
      showmessage('Gratulation! Sie haben das Bild korrekt zusammengesetzt! '+inttostr(tpunkte)+' Punkte');
      nochkeinbild:=true;
      D3Click(Sender);
    end;
end;

procedure TForm1.d1Click(Sender: TObject);
var nr:integer;
begin
     nr:=random(puzzlebilder);
     l1.itemindex:=nr;
     listbox1click(sender);
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var z1,z2,i,j,i1,j1,modu:integer;
begin
    if schiebepuzzle then exit;
    if button=mbright then
    begin
      if rg2.itemindex=0 then modu:=1;
      if rg2.itemindex=1 then modu:=4;
      z1:=(x div b12)+1;
      z2:=y div b12;
      z1:=z2*x12+z1;
      for i:=1 to x12 do
        for j:=1 to y12 do
          if puzzlef[i,j].m=z1 then
          begin
            i1:=i;
            j1:=j
          end;
      puzzlef[i1,j1].n:=(puzzlef[i1,j1].n + 1) mod modu;
      inc(puzzlezug);
      puzzledarstellen(sender);
      exit;
    end;
    if button=mbleft then
    begin
      z1:=(x div b12)+1;
      z2:=y div b12;
      z1:=z2*x12+z1;
      for i:=1 to x12 do
        for j:=1 to y12 do
          if puzzlef[i,j].m=z1 then
          begin
            pui:=i;
            puj:=j;
            pux:=x;
            puy:=y
          end;
      puzzleschieben:=true;
    end;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if schiebepuzzle then exit;
    if puzzleschieben then
    begin
      puvx:=pux-x;
      puvy:=puy-y;
      puzzledarstellen(sender);
    end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a,b,z1,z2,i,j,h1:integer;
begin
    if schiebepuzzle then exit;
    if puzzleschieben then
    begin
      puzzleschieben:=false;
      z1:=x div b12;
      z2:=y div b12;
      if z1>x12-1 then z1:=x12-1;
      if z2>y12-1 then z2:=y12-1;
      if z1<0 then z1:=0;
      if z2<0 then z2:=0;
      z1:=z2*x12+z1+1;
      for i:=1 to x12 do
        for j:=1 to y12 do
          if puzzlef[i,j].m=z1 then
          begin
            a:=i;
            b:=j;
          end;
      if (a<>pui) or (b<>puj) then
      begin
        h1:=puzzlef[pui,puj].m;
        puzzlef[pui,puj].m:=puzzlef[a,b].m;
        puzzlef[a,b].m:=h1;
      end;
      inc(puzzlezug);
      puzzledarstellen(sender);
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var z:integer;
    k:string;
begin
    z:=(integer(gettickcount)-integer(puzzlezeit)) div 1000;
    k:=inttostr(z mod 60);
    while length(k)<2 do k:='0'+k;
    k:=inttostr(z div 60)+':'+k;
    l2.caption:='Zeit  '+k+' min';
end;

procedure TForm1.D2Click(Sender: TObject);
var x:integer;
begin
    puzzlezeit:=puzzlezeit-10000;
    x:=integer(gettickcount);
    ipu0.visible:=true;
    repeat
      application.processmessages;
    until integer(gettickcount)-x>2500;
    ipu0.visible:=false;
end;

procedure TForm1.S5Click(Sender: TObject);
begin
    bildkopieren(paintbox1);
end;

procedure TForm1.S3Click(Sender: TObject);
begin
    bilddruckenpb(paintbox1);
end;

procedure TForm1.S4Click(Sender: TObject);
//var f:tfilestream;
//    Bitmap: TBitmap;
//    myrect,birect:trect;
begin
{    p2sd1.filterindex:=1;
    p2sd1.filename:='';
    if p2sd1.execute then
    begin
  try    }
    pb1paint(sender);
    bildspeichern(pb1);
{  finally
    Bitmap := TBitmap.Create;
    Bitmap.Width := pb1.width;
    Bitmap.Height := pb1.Height;
    birect.left:=1;
    birect.right:=pb1.width;
    birect.top:=1;
    birect.bottom:=pb1.height;
    myrect:=birect;
    bitmap.canvas.CopyRect(biRect,pb1.Canvas, MyRect);

    if p2sd1.filterindex=2 then Bitmap.PixelFormat := pf4bit;
    if p2sd1.filterindex<3 then
    begin
      f:=tfilestream.create(p2sd1.filename,fmcreate);
      bitmap.savetostream(f);
      f.free;
    end;
    if p2sd1.filterindex=3 then savejpg(bitmap,p2sd1.filename,100,false);
    if p2sd1.filterindex=4 then gifsave(bitmap,p2sd1.filename);
    Bitmap.Free;
    end;
  end;}
end;

procedure TForm1.D3Click(Sender: TObject);
begin
    spunkte:=tpunkte;
    if (spunkte>=0) {and isadmin} then
    begin
      Application.CreateForm(Tbestenliste, bestenliste);
      bestenliste.showmodal;
      bestenliste.release;
      tpunkte:=0;
    end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
     xname:=edit1.text;
end;

procedure TForm1.D4Click(Sender: TObject);
var i,j,nh,n1,n2,modu:integer;
    nrect,birect:trect;
    reihe:array[1..200] of integer;
begin
    op1.filterindex:=1;
    op1.filename:='';
    if op1.execute then
    begin
      if op1.filterindex=1 then ladejpg(op1.filename,image3.picture.bitMap);
      if op1.filterindex=2 then gifladen(op1.filename,image3);
      if op1.filterindex=3 then image3.picture.loadfromfile(op1.filename);

      nRect := Rect(0,0,640,480);
      BiRect := Rect(0,0,image3.width,image3.height);
      ipu0.canvas.stretchdraw(nrect,image3.picture.bitmap);
      case rg1.itemindex of
        0 : begin x12:=4; y12:=3; b12:=160 end;
//        2 : begin x12:=20; y12:=15; b12:=32 end;
        2 : begin x12:=16; y12:=12; b12:=40 end;
       else begin x12:=8; y12:=6; b12:=80 end;
      end;
      spielname:='Puzzle '+inttostr(x12)+'x'+inttostr(y12);
      if rg2.itemindex=1 then spielname:=spielname+' Drehung';
      tpunkte:=0;

      nochkeinbild:=false;
      for i:=1 to x12*y12 do reihe[i]:=i;
      for i:=1 to 200 do
      begin
        n1:=random(x12*y12)+1;
        n2:=random(x12*y12)+1;
        nh:=reihe[n1];
        reihe[n1]:=reihe[n2];
        reihe[n2]:=nh;
      end;
      if rg2.itemindex=0 then modu:=1;
      if rg2.itemindex=1 then modu:=4;
      for i:=1 to x12 do
        for j:=1 to y12 do
        begin
          puzzlef[i,j].m:=reihe[(i-1)*y12+j];
          puzzlef[i,j].n:=random(modu);
        end;
      timer1.enabled:=true;
      puzzlezeit:=integer(gettickcount);
      puzzlezug:=0;
      puzzledarstellen(sender);
    end;
end;

procedure TForm1.richtigd(Sender: TObject);
var i,j:integer;
begin
    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        puzzlef[i,j].n:=0;
      end;
    puzzledarstellen(sender);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var reihe:array[1..200] of integer;
    modu,nh,n1,n2,i,j,ii:integer;
    k,k2:string;
procedure geschobentest(m:string);
var x:integer;
begin
    while pos(m,geschoben)>0 do
    begin
      x:=pos(m,geschoben);
      delete(geschoben,x,length(m));
    end;
end;
begin
    case rg1.itemindex of
      0 : begin x12:=4; y12:=3; b12:=160 end;
//      2 : begin x12:=20; y12:=15; b12:=32 end;
      2 : begin x12:=16; y12:=12; b12:=40 end;
     else begin x12:=8; y12:=6; b12:=80 end;
    end;
    k2:=l1.items[l1.itemindex];
    spielname:=copy(k2,1,pos(#9,k2)-1)+' '+inttostr(x12)+'x'+inttostr(y12);
    if schiebepuzzle then
    begin
      spielname:='SPuzzle '+copy(k2,1,pos(#9,k2)-1)+' '+inttostr(x12)+'x'+inttostr(y12);
      geschoben:='';
    end;
    if rg2.itemindex=1 then spielname:=spielname+' Drehung';
    tpunkte:=0;

    k:=l1.items[l1.itemindex];
    delete(k,1,pos(#9,k));
    puzzlejpgladen('puz'+k,ipu0);
    nochkeinbild:=false;

    for i:=1 to x12*y12 do reihe[i]:=i;

    if schiebepuzzle then
    begin
      for i:=1 to 3 do reihe[i]:=(i-1)*4+1;
      for i:=4 to 6 do reihe[i]:=(i-4)*4+2;
      for i:=7 to 9 do reihe[i]:=(i-7)*4+3;
      for i:=10 to 12 do reihe[i]:=(i-10)*4+4;
      for i:=1 to 10+random(20) do
      begin
        n1:=random(7);
        case n1 of
          0,1,2,3 : begin
                nh:=reihe[1+n1*3];
                for ii:=1+n1*3 to 2+n1*3 do reihe[ii]:=reihe[ii+1];
                reihe[3+n1*3]:=nh
               end;
           4 : begin
                 nh:=reihe[1];
                 for ii:=1 to 3 do reihe[1+(ii-1)*3]:=reihe[ii*3+1];
                 reihe[10]:=nh
               end;
           5 : begin
                 nh:=reihe[2];
                 for ii:=1 to 3 do reihe[2+(ii-1)*3]:=reihe[ii*3+2];
                 reihe[11]:=nh
               end;
           6 : begin
                 nh:=reihe[3];
                 for ii:=1 to 3 do reihe[3+(ii-1)*3]:=reihe[ii*3+3];
                 reihe[12]:=nh
               end;
        end;
        geschoben:=geschoben+chr(n1+48);
      end;
      geschobentest('000');
      geschobentest('111');
      geschobentest('222');
      geschobentest('333');
      geschobentest('4444');
      geschobentest('5555');
      geschobentest('6666');
    end
    else
    begin //bildpuzzle
      for i:=1 to 200 do
      begin
        n1:=random(x12*y12)+1;
        n2:=random(x12*y12)+1;
        nh:=reihe[n1];
        reihe[n1]:=reihe[n2];
        reihe[n2]:=nh;
      end;
    end;

    if rg2.itemindex=0 then modu:=1;
    if rg2.itemindex=1 then modu:=4;
    for i:=1 to x12 do
      for j:=1 to y12 do
      begin
        puzzlef[i,j].m:=reihe[(i-1)*y12+j];
        puzzlef[i,j].n:=random(modu);
      end;
    timer1.enabled:=true;
    puzzlezeit:=integer(gettickcount);
    puzzlezug:=0;
    puzzledarstellen(sender);
end;

procedure TForm1.S7Click(Sender: TObject);
var k:string;
    dd:textfile;
    n,i,j:integer;
begin
    if sd1.Execute then
    begin
      k:=sd1.filename;
      assignfile(dd,k);
      rewrite(dd);
      n:=rg1.itemindex;
      writeln(dd,n);
      n:=rg2.itemindex;
      writeln(dd,n);
      writeln(dd,puzzlezug);
      writeln(dd,integer(gettickcount)-puzzlezeit);
      for i:=1 to x12 do
        for j:=1 to y12 do
        begin
          writeln(dd,puzzlef[i,j].m);
          writeln(dd,puzzlef[i,j].n);
        end;
      closefile(dd);
      delete(k,length(k)-2,3);
      k:=k+'jpg';
      savejpg(ipu0.picture.bitMap,k,80,false);
    end;
end;

procedure TForm1.S8Click(Sender: TObject);
var k:string;
    dd:textfile;
    i,j,n:integer;
begin
    if od1.Execute then
    begin
      k:=od1.filename;
      assignfile(dd,k);
      reset(dd);
      l1.setfocus;
      readln(dd,n);
      rg1.itemindex:=n;
      readln(dd,n);
      rg2.itemindex:=n;
      readln(dd,puzzlezug);
      readln(dd,n);
      puzzlezeit:=integer(gettickcount)-n;
      case rg1.itemindex of
        0 : begin x12:=4; y12:=3; b12:=160 end;
//        2 : begin x12:=20; y12:=15; b12:=32 end;
        2 : begin x12:=16; y12:=12; b12:=40 end;
       else begin x12:=8; y12:=6; b12:=80 end;
      end;
      for i:=1 to x12 do
        for j:=1 to y12 do
        begin
          readln(dd,puzzlef[i,j].m);
          readln(dd,puzzlef[i,j].n);
        end;
      closefile(dd);
      delete(k,length(k)-2,3);
      k:=k+'jpg';
      ladejpg(k,ipu0.picture.bitMap);
      spielname:='Puzzle '+inttostr(x12)+'x'+inttostr(y12);
      if rg2.itemindex=1 then spielname:=spielname+' Drehung';
      tpunkte:=0;
      puzzledarstellen(sender);
    end;
end;

procedure TForm1.D5Click(Sender: TObject);
var i,x,y,h:integer;
begin
    for i:=1 to 1000 do
    begin
      x:=random(52)+1;
      y:=random(52)+1;
      h:=karte[x];
      karte[x]:=karte[y];
      karte[y]:=h;
    end;
    for i:=1 to 10 do
    begin
      gezkarte[1,i]:=0;
      gezkarte[2,i]:=0;
    end;
    gezkarte[1,1]:=karte[1];
    gezkarte[2,1]:=karte[2];
    gezkarte[2,2]:=karte[3];
    kartenzahl1:=1;
    kartenzahl2:=2;
    siebzehnende:=false;
    keinekartemehr:=false;
    d6.enabled:=true;
    d7.enabled:=true;
    paintbox3paint(sender);
end;

procedure TForm1.PaintBox3Paint(Sender: TObject);
label 1;
var bitmap:tbitmap;
    i,w1,w2:integer;
procedure xpic2(a,b:integer;nr:integer);
var bild:tbitmap;
begin
    bild:=tbitmap.create;
    bild.loadfromresourceid(hinstance,nr);
    bitmap.canvas.draw(a,b,bild);
    bild.free;
end;
begin
//Spieler
    if rg3.itemindex=3 then kartenoffset:=10
                       else kartenoffset:=0;
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox2.width;
    bitmap.height:=paintbox2.height;
    bitmap.Canvas.font.name:='Verdana';
    bitmap.Canvas.font.style:=[fsbold,fsitalic];
    bitmap.Canvas.font.size:=18; w2:=0;
    for i:=1 to 10 do
    begin
      if gezkarte[2,i]<>0 then
      begin
        xpic2(-20+i*80,20,gezkarte[2,i]);
        case gezkarte[2,i] mod 13 of
          1 : if rg3.itemindex=2 then w2:=w2+1 else w2:=w2+11;
          2..10 : w2:=w2+gezkarte[2,i] mod 13;
         else if rg3.itemindex<>1 then w2:=w2+10;
        end;
      end;
    end;
    case w2-kartenoffset of
      -10..20 : bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w2));
           21 : begin
                  siebzehnende:=true;
                  inc(spiel2);
                  bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w2)+' Spieler gewinnt!');
                end;
           22 : begin
                  siebzehnende:=true;
                  if kartenzahl2=2 then
                  begin
                    inc(spiel2);
                    bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w2)+' Spieler gewinnt!');
                  end
                  else
                  begin
                    inc(spiel1);
                    bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w2)+' Spieler verliert!');
                  end;
                end;
           else begin
                  siebzehnende:=true;
                  inc(spiel1);
                  bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w2)+' Spieler verliert!');
                end;
    end;
    paintbox2.Canvas.Draw(0,0,bitmap);
    bitmap.free;
//bank
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox3.width;
    bitmap.height:=paintbox3.height;
    bitmap.Canvas.font.name:='Verdana';
    bitmap.Canvas.font.style:=[fsbold,fsitalic];
    bitmap.Canvas.font.size:=18;
    w1:=0;
    for i:=1 to 10 do
    begin
      if gezkarte[1,i]<>0 then
      begin
        if cb1.checked and (keinekartemehr=false) then
          xpic2(-20+i*80,20,53)
        else
          xpic2(-20+i*80,20,gezkarte[1,i]);
        case gezkarte[1,i] mod 13 of
          1 : if rg3.itemindex=2 then w1:=w1+1 else w1:=w1+11;
          2..10 : w1:=w1+gezkarte[1,i] mod 13;
                  else
                    if rg3.itemindex<>1 then w1:=w1+10;
        end;
      end;
    end;

    if cb2.checked and keinekartemehr and (siebzehnende=false) then
    begin
      if w1>=17+kartenoffset then
      begin
        siebzehnende:=true;
        if (w1>=w2) and (w1<22+kartenoffset) then
        begin
          inc(spiel1);
          bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1)+' Bank gewinnt!');
        end
        else
        begin
          inc(spiel2);
          bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1)+' Bank verliert!');
        end;
        goto 1
      end;
    end;
    if (cb1.checked=false) or (keinekartemehr) then
      case w1-kartenoffset of
        -10..20 : bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1));
        21 : begin
               if siebzehnende then
                 bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1))
               else
               begin
                 inc(spiel1);
                 bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1)+' Bank gewinnt!');
                 siebzehnende:=true;
               end;
             end;
        else begin
               siebzehnende:=true;
               inc(spiel2);
               bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1)+' Bank verliert!');
             end;
      end;
    if keinekartemehr and (siebzehnende=false) then
    begin
      if w1>=w2 then
      begin
        siebzehnende:=true;
        inc(spiel1);
        bitmap.canvas.textout(250,140,'Kartenwert '+inttostr(w1)+' Bank gewinnt!');
      end;
    end;

1:  paintbox3.Canvas.Draw(0,0,bitmap);
    bitmap.free;
    if siebzehnende then
    begin
      d6.enabled:=false;
      d7.enabled:=false;
      d5.enabled:=true;
    end;
    l7.caption:='Bank '+inttostr(spiel1)+' ';
    l8.caption:='Spieler '+inttostr(spiel2)+' ';
end;

procedure TForm1.D6Click(Sender: TObject);
begin
    gezkarte[2,kartenzahl2+1]:=karte[kartenzahl1+kartenzahl2+1];
    inc(kartenzahl2);
    paintbox3paint(sender);
end;

procedure TForm1.D7Click(Sender: TObject);
begin
    keinekartemehr:=true;
    paintbox3paint(sender);
    while siebzehnende=false do
    begin
      gezkarte[1,kartenzahl1+1]:=karte[kartenzahl1+kartenzahl2+1];
      inc(kartenzahl1);
      paintbox3paint(sender);
    end;
end;

procedure TForm1.S1Click(Sender: TObject);
begin
    close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var ini: TIniFile;
begin
    if (hauptnur=29) and (panel21.visible=true) then
    begin
      panel21.visible:=false;
      Action := caNone;
      exit;
    end;
    ini := TIniFile.create(tempstring+'wfktspiele.ini');
    ini.writestring('alpha','Spielername',xname);
    ini.free;
end;

procedure TForm1.M55Click(Sender: TObject);
begin
  Application.CreateForm(Tcoramain, coramain);
  coramain.showmodal;
  coramain.release;
end;

procedure TForm1.Rally1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrally, frally);
  frally.showmodal;
  frally.release;
end;

procedure TForm1.M59Click(Sender: TObject);
begin
  Application.CreateForm(Tfparken, fparken);
  fparken.showmodal;
  fparken.release;
end;

procedure TForm1.M58Click(Sender: TObject);
begin
  Application.CreateForm(Tfgo, fgo);
  fgo.showmodal;
  fgo.release;
end;

procedure TForm1.Image5Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do
      for j:=1 to 3 do
      begin
        schiebereihe[puzzlef[i,j].m].x:=i;
        schiebereihe[puzzlef[i,j].m].y:=j;
      end;
    nx:=schiebereihe[1].x;
    ny:=schiebereihe[1].y;
    for i:=1 to 3 do
    begin
      schiebereihe[i].x:=schiebereihe[i+1].x;
      schiebereihe[i].y:=schiebereihe[i+1].y;
    end;
    schiebereihe[4].x:=nx;
    schiebereihe[4].y:=ny;
    for i:=1 to 12 do
      puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='4' then delete(geschoben,1,1) else geschoben:='444'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.Image6Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do for j:=1 to 3 do
    begin
      schiebereihe[puzzlef[i,j].m].x:=i;
      schiebereihe[puzzlef[i,j].m].y:=j;
    end;
    nx:=schiebereihe[5].x;
    ny:=schiebereihe[5].y;
    for i:=1 to 3 do
    begin
      schiebereihe[i+4].x:=schiebereihe[i+5].x;
      schiebereihe[i+4].y:=schiebereihe[i+5].y;
    end;
    schiebereihe[8].x:=nx;
    schiebereihe[8].y:=ny;
    for i:=1 to 12 do
      puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='5' then delete(geschoben,1,1) else geschoben:='555'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.I7Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do for j:=1 to 3 do
    begin
      schiebereihe[puzzlef[i,j].m].x:=i;
      schiebereihe[puzzlef[i,j].m].y:=j;
    end;
    nx:=schiebereihe[9].x;
    ny:=schiebereihe[9].y;
    for i:=1 to 3 do begin
      schiebereihe[i+8].x:=schiebereihe[i+9].x;
      schiebereihe[i+8].y:=schiebereihe[i+9].y;
    end;
    schiebereihe[12].x:=nx;
    schiebereihe[12].y:=ny;
    for i:=1 to 12 do
      puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='6' then delete(geschoben,1,1)
                        else geschoben:='666'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.I11Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do for j:=1 to 3 do
    begin
      schiebereihe[puzzlef[i,j].m].x:=i;
      schiebereihe[puzzlef[i,j].m].y:=j;
    end;
    nx:=schiebereihe[1].x;
    ny:=schiebereihe[1].y;
    schiebereihe[1].x:=schiebereihe[5].x;
    schiebereihe[1].y:=schiebereihe[5].y;
    schiebereihe[5].x:=schiebereihe[9].x;
    schiebereihe[5].y:=schiebereihe[9].y;
    schiebereihe[9].x:=nx;
    schiebereihe[9].y:=ny;
    for i:=1 to 12 do
      puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='0' then delete(geschoben,1,1) else geschoben:='00'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.I14Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do for j:=1 to 3 do
    begin
      schiebereihe[puzzlef[i,j].m].x:=i;
      schiebereihe[puzzlef[i,j].m].y:=j;
    end;
    nx:=schiebereihe[2].x;
    ny:=schiebereihe[2].y;
    schiebereihe[2].x:=schiebereihe[6].x;
    schiebereihe[2].y:=schiebereihe[6].y;
    schiebereihe[6].x:=schiebereihe[10].x;
    schiebereihe[6].y:=schiebereihe[10].y;
    schiebereihe[10].x:=nx;
    schiebereihe[10].y:=ny;
    for i:=1 to 12 do
       puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='1' then delete(geschoben,1,1) else geschoben:='11'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.I12Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do for j:=1 to 3 do
    begin
      schiebereihe[puzzlef[i,j].m].x:=i;
      schiebereihe[puzzlef[i,j].m].y:=j;
    end;
    nx:=schiebereihe[3].x;
    ny:=schiebereihe[3].y;
    schiebereihe[3].x:=schiebereihe[7].x;
    schiebereihe[3].y:=schiebereihe[7].y;
    schiebereihe[7].x:=schiebereihe[11].x;
    schiebereihe[7].y:=schiebereihe[11].y;
    schiebereihe[11].x:=nx;
    schiebereihe[11].y:=ny;
    for i:=1 to 12 do
      puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='2' then delete(geschoben,1,1) else geschoben:='22'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.I13Click(Sender: TObject);
var nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    for i:=1 to 4 do for j:=1 to 3 do
    begin
         schiebereihe[puzzlef[i,j].m].x:=i;
         schiebereihe[puzzlef[i,j].m].y:=j;
    end;
    nx:=schiebereihe[4].x;
    ny:=schiebereihe[4].y;
    schiebereihe[4].x:=schiebereihe[8].x;
    schiebereihe[4].y:=schiebereihe[8].y;
    schiebereihe[8].x:=schiebereihe[12].x;
    schiebereihe[8].y:=schiebereihe[12].y;
    schiebereihe[12].x:=nx;
    schiebereihe[12].y:=ny;
    for i:=1 to 12 do
      puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
    inc(puzzlezug);
    if geschoben[1]='3' then delete(geschoben,1,1) else geschoben:='33'+geschoben;
    puzzledarstellen(sender);
end;

procedure TForm1.D9Click(Sender: TObject);
var x:integer;
    nx,ny,i,j:integer;
    schiebereihe:array[1..12] of tpoint;
begin
    if length(geschoben)>0 then
    begin
      x:=ord(geschoben[1])-48;
      for i:=1 to 4 do for j:=1 to 3 do
      begin
        schiebereihe[puzzlef[i,j].m].x:=i;
        schiebereihe[puzzlef[i,j].m].y:=j;
      end;
      case x of
        0 : begin
              nx:=schiebereihe[1].x;
              ny:=schiebereihe[1].y;
              schiebereihe[1].x:=schiebereihe[5].x;
              schiebereihe[1].y:=schiebereihe[5].y;
              schiebereihe[5].x:=schiebereihe[9].x;
              schiebereihe[5].y:=schiebereihe[9].y;
              schiebereihe[9].x:=nx;
              schiebereihe[9].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
        1 : begin
              nx:=schiebereihe[2].x;
              ny:=schiebereihe[2].y;
              schiebereihe[2].x:=schiebereihe[6].x;
              schiebereihe[2].y:=schiebereihe[6].y;
              schiebereihe[6].x:=schiebereihe[10].x;
              schiebereihe[6].y:=schiebereihe[10].y;
              schiebereihe[10].x:=nx;
              schiebereihe[10].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
        2 : begin
              nx:=schiebereihe[3].x;
              ny:=schiebereihe[3].y;
              schiebereihe[3].x:=schiebereihe[7].x;
              schiebereihe[3].y:=schiebereihe[7].y;
              schiebereihe[7].x:=schiebereihe[11].x;
              schiebereihe[7].y:=schiebereihe[11].y;
              schiebereihe[11].x:=nx;
              schiebereihe[11].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
        3 : begin
              nx:=schiebereihe[4].x;
              ny:=schiebereihe[4].y;
              schiebereihe[4].x:=schiebereihe[8].x;
              schiebereihe[4].y:=schiebereihe[8].y;
              schiebereihe[8].x:=schiebereihe[12].x;
              schiebereihe[8].y:=schiebereihe[12].y;
              schiebereihe[12].x:=nx;
              schiebereihe[12].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
        4 : begin
              nx:=schiebereihe[1].x;
              ny:=schiebereihe[1].y;
              for i:=1 to 3 do
              begin
                schiebereihe[i].x:=schiebereihe[i+1].x;
                schiebereihe[i].y:=schiebereihe[i+1].y;
              end;
              schiebereihe[4].x:=nx;
              schiebereihe[4].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
        5 : begin
              nx:=schiebereihe[5].x;
              ny:=schiebereihe[5].y;
              for i:=1 to 3 do
              begin
                schiebereihe[i+4].x:=schiebereihe[i+5].x;
                schiebereihe[i+4].y:=schiebereihe[i+5].y;
              end;
              schiebereihe[8].x:=nx;
              schiebereihe[8].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
        6 : begin
              nx:=schiebereihe[9].x;
              ny:=schiebereihe[9].y;
              for i:=1 to 3 do
              begin
                schiebereihe[i+8].x:=schiebereihe[i+9].x;
                schiebereihe[i+8].y:=schiebereihe[i+9].y;
              end;
              schiebereihe[12].x:=nx;
              schiebereihe[12].y:=ny;
              for i:=1 to 12 do
                puzzlef[schiebereihe[i].x,schiebereihe[i].y].m:=i;
            end;
      end;
      inc(puzzlezug,1);
      puzzlezeit:=puzzlezeit-60000;
      delete(geschoben,1,1);
      puzzledarstellen(sender);
    end;
end;

procedure TForm1.M111Click(Sender: TObject);
begin
  Application.CreateForm(Thipform, hipform);
  hipform.showmodal;
  hipform.release;
end;

procedure TForm1.M531Click(Sender: TObject);
begin
  Application.CreateForm(Theu15, heu15);
  heu15.showmodal;
  heu15.release;
end;

procedure TForm1.M541Click(Sender: TObject);
begin
  Application.CreateForm(Tvierg, vierg);
  vierg.showmodal;
  vierg.release;
end;

procedure TForm1.M811Click(Sender: TObject);
begin
  Application.CreateForm(Tdomi, domi);
  domi.showmodal;
  domi.release;
end;

procedure TForm1.M91Click(Sender: TObject);
begin
  Application.CreateForm(Tkopfr, kopfr);
  kopfr.showmodal;
  kopfr.release;
end;

procedure TForm1.M231Click(Sender: TObject);
begin
  Application.CreateForm(Tfrotor, frotor);
  frotor.showmodal;
  frotor.release;
end;

procedure TForm1.M911Click(Sender: TObject);
begin
  Application.CreateForm(Tfkakuro, fkakuro);
  fkakuro.showmodal;
  fkakuro.release;
end;

procedure TForm1.M321Click(Sender: TObject);
begin
  Application.CreateForm(Tfvier, fvier);
  fvier.showmodal;
  fvier.release;
end;

procedure TForm1.M4Click(Sender: TObject);
begin
  Application.CreateForm(Tmemory, memory);
  memory.showmodal;
  memory.release;
end;

procedure TForm1.M25Click(Sender: TObject);
begin
  Application.CreateForm(Tfvier3, fvier3);
  fvier3.showmodal;
  fvier3.release;
end;

procedure TForm1.M38Click(Sender: TObject);
begin
  Application.CreateForm(Tvexed, vexed);
  vexed.showmodal;
  vexed.release;
end;

procedure TForm1.M13Click(Sender: TObject);
begin
  Application.CreateForm(TFlicht, Flicht);
  flicht.showmodal;
  flicht.release;
end;

procedure TForm1.M39Click(Sender: TObject);
begin
  Application.CreateForm(Tfpuzzle2, fpuzzle2);
  fpuzzle2.showmodal;
  fpuzzle2.release;
end;

procedure TForm1.M40Click(Sender: TObject);
begin
  Application.CreateForm(Ttetravex, tetravex);
  tetravex.showmodal;
  tetravex.release;
end;

procedure TForm1.M41Click(Sender: TObject);
begin
  Application.CreateForm(Tufflutungs, ufflutungs);
  ufflutungs.showmodal;
  ufflutungs.release;
end;

procedure TForm1.M42Click(Sender: TObject);
begin
  Application.CreateForm(Trubik, rubik);
  rubik.showmodal;
  rubik.release;
end;

procedure TForm1.M45Click(Sender: TObject);
begin
  Application.CreateForm(Trubik3, rubik3);
  rubik3.showmodal;
  rubik3.release;
end;

procedure TForm1.M46Click(Sender: TObject);
begin
  Application.CreateForm(Tfmah, fmah);
  fmah.showmodal;
  fmah.release;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
   if form1.width>1600 then form1.width:=1600;
   if form1.height>1280 then form1.width:=1280;
   formx:=form1.width;
   formy:=form1.height;
end;

procedure TForm1.p1p1Resize(Sender: TObject);
begin
    panel13.width:=(p1p1.width-panel18.width) div 2;
    panel15.width:=(p1p1.width-1024) div 2+1;
    panel22.left:=(panel13.width-panel22.width) div 2;
    panel22.top:=(panel13.height-panel22.height) div 2;
end;

procedure TForm1.f_gedaechtnisResize(Sender: TObject);
begin
    panel16.width:=(f_gedaechtnis.width-p3p44.width-720) div 2;
end;

procedure TForm1.f_puzzleResize(Sender: TObject);
begin
    panel17.width:=(f_puzzle.width-panel1.width-824) div 2;
end;

procedure TForm1.M48Click(Sender: TObject);
begin
  Application.CreateForm(Tfescher, fescher);
  fescher.showmodal;
  fescher.release;
end;

procedure TForm1.M49Click(Sender: TObject);
begin
  Application.CreateForm(Tfvier4, fvier4);
  fvier4.showmodal;
  fvier4.release;
end;

procedure TForm1.f_arithmoResize(Sender: TObject);
begin
   if f_arithmo.width>1100 then panel19.width:=(f_arithmo.width-1024) div 2;
end;

procedure TForm1.M24Click(Sender: TObject);
begin
  Application.CreateForm(Tschnecke, schnecke);
  schnecke.showmodal;
  schnecke.release;
end;

procedure TForm1.M43Click(Sender: TObject);
begin
  Application.CreateForm(Tschnecke2, schnecke2);
  schnecke2.showmodal;
  schnecke2.release;
end;

procedure TForm1.M44Click(Sender: TObject);
begin
  Application.CreateForm(Tfrotor2, frotor2);
  frotor2.showmodal;
  frotor2.release;
end;

procedure TForm1.M47Click(Sender: TObject);
begin
  Application.CreateForm(Tpentoform, pentoform);
  pentoform.showmodal;
  pentoform.release;
end;

procedure TForm1.M50Click(Sender: TObject);
begin
  Application.CreateForm(Tfhano, fhano);
  fhano.showmodal;
  fhano.release;
end;

procedure TForm1.S4aclick(Sender: TObject);
begin
      puzzledarstellen(sender);
      bildspeichern(paintbox1);
end;

procedure TForm1.M51Click(Sender: TObject);
begin
  Application.CreateForm(Tfhano2, fhano2);
  fhano2.showmodal;
  fhano2.release;
end;

procedure TForm1.M52Click(Sender: TObject);
begin
  Application.CreateForm(Tfvier2, fvier2);
  fvier2.showmodal;
  fvier2.release;
end;

procedure TForm1.M53Click(Sender: TObject);
begin
  Application.CreateForm(Tflabyr, flabyr);
  flabyr.showmodal;
  flabyr.release;
end;

procedure TForm1.M54Click(Sender: TObject);
begin
  Application.CreateForm(Tftictac, ftictac);
  ftictac.showmodal;
  ftictac.release;
end;

procedure TForm1.M61Click(Sender: TObject);
begin
  Application.CreateForm(Tfhaky, fhaky);
  fhaky.showmodal;
  fhaky.release;
end;

procedure TForm1.M62Click(Sender: TObject);
begin
  Application.CreateForm(Tffillo, ffillo);
  ffillo.showmodal;
  ffillo.release;
end;

procedure TForm1.M63Click(Sender: TObject);
begin
  Application.CreateForm(Tfzgitter, fzgitter);
  fzgitter.showmodal;
  fzgitter.release;
end;

procedure TForm1.M64Click(Sender: TObject);
begin
  Application.CreateForm(Tfhitori, fhitori);
  fhitori.showmodal;
  fhitori.release;
end;

procedure TForm1.m65Click(Sender: TObject);
begin
  Application.CreateForm(Tfkika, fkika);
  fkika.showmodal;
  fkika.release;
end;

procedure TForm1.M66Click(Sender: TObject);
begin
  Application.CreateForm(Tfwolke, fwolke);
  fwolke.showmodal;
  fwolke.release;
end;

procedure TForm1.M67Click(Sender: TObject);
begin
  Application.CreateForm(TFbruecken, Fbruecken);
  fbruecken.showmodal;
  fbruecken.release;
end;

procedure TForm1.M68Click(Sender: TObject);
begin
  Application.CreateForm(Tfmuehle, fmuehle);
  fmuehle.showmodal;
  fmuehle.release;
end;

procedure TForm1.M69Click(Sender: TObject);
begin
  Application.CreateForm(Tpyram, pyram);
  pyram.showmodal;
  pyram.release;
end;

procedure TForm1.M70Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmwythoff, frmwythoff);
  frmwythoff.showmodal;
  frmwythoff.release;
end;

procedure TForm1.M71Click(Sender: TObject);
begin
  Application.CreateForm(Tfkreis, fkreis);
  fkreis.showmodal;
  fkreis.release;
end;

procedure TForm1.M72Click(Sender: TObject);
begin
  Application.CreateForm(Tform10k, form10k);
  form10k.showmodal;
  form10k.release;
end;

procedure TForm1.M73Click(Sender: TObject);
begin
  Application.CreateForm(TIQ, IQ);
  iq.showmodal;
  iq.release;
end;

procedure TForm1.M74Click(Sender: TObject);
begin
  Application.CreateForm(Tfstraights, fstraights);
  fstraights.showmodal;
  fstraights.release;
end;

const fbreite=48;

procedure TForm1.pb4Paint(Sender: TObject);
const grad=9;
var b,h,i,j,xoffset,yoffset,ii:integer;
    bitmap:tbitmap;
    k,k1:string;
begin
    b:=PB4.width;
    h:=PB4.height;
    bitmap:=tbitmap.create;
    bitmap.width:=PB4.width;
    bitmap.height:=PB4.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2;
    with bitmap.canvas do
    begin
      font.name:='Verdana';
      for i:=0 to grad-1 do
        for j:=0 to grad-1 do
        begin
          brush.color:=clwhite;
          pen.color:=clgray;
          if p1sg2.Cells[i,j]<>'' then Font.Color:=clnavy
                                  else Font.Color:=clBlack;
          rectangle(xoffset+i*fbreite,yoffset+j*fbreite,
                    xoffset+i*fbreite+fbreite+1,yoffset+j*fbreite+fbreite+1);
          k:=p1feld.cells[i,j];
          brush.style:=bsclear;
          font.size:=24;
          if length(k)=1 then
          begin
            textout(xoffset+i*fbreite+(fbreite div 2)-(textwidth(k) div 2),
                    yoffset+j*fbreite+(fbreite div 2)-(textheight(k) div 2),k);
          end
          else
          begin
            font.size:=8;
            for ii:=1 to 9 do
            begin
              if pos(inttostr(ii),k)>0 then
              begin
                k1:=inttostr(ii);
                textout(xoffset+i*fbreite+5+((ii-1) mod 3)*10,
                        yoffset+j*fbreite+2+((ii-1) div 3)*11,k1);
              end;
            end;
          end;
        end;
      end;
      bitmap.canvas.pen.width:=2;
      bitmap.canvas.pen.color:=clblack;
      bitmap.canvas.moveto(xoffset+3*fbreite,yoffset);
      bitmap.canvas.lineto(xoffset+3*fbreite,yoffset+9*fbreite+1);
      bitmap.canvas.moveto(xoffset+6*fbreite,yoffset);
      bitmap.canvas.lineto(xoffset+6*fbreite,yoffset+9*fbreite+1);
      bitmap.canvas.moveto(xoffset,yoffset+3*fbreite);
      bitmap.canvas.lineto(xoffset+9*fbreite,yoffset+3*fbreite);
      bitmap.canvas.moveto(xoffset,yoffset+6*fbreite);
      bitmap.canvas.lineto(xoffset+9*fbreite,yoffset+6*fbreite);

      bitmap.canvas.pen.width:=3;
      bitmap.canvas.pen.color:=clnavy;
      bitmap.canvas.brush.style:=bsclear;
      bitmap.canvas.rectangle(xoffset-1,yoffset-1,
                 xoffset+grad*fbreite+2,yoffset+grad*fbreite+2);
      bitmap.canvas.pen.width:=1;
      pB4.canvas.draw(0,0,bitmap);
      bitmap.free;
end;

procedure TForm1.pb4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const grad=9;
var b,h,xoffset,yoffset:integer;
begin
    b:=PB4.width;
    h:=PB4.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2;

    nrx:=(x-xoffset) div fbreite +1;
    nry:=(y-yoffset) div fbreite +1;
    if (nrx>0) and (nrx<=grad) and (nry>0) and (nry<=grad) and
       (p1sg2.Cells[nrx-1,nry-1]='') then
    begin
      while xoffset+(nrx-1)*fbreite+panel21.width>pb4.width do dec(xoffset,10);
      panel21.left:=xoffset+(nrx-1)*fbreite;
      panel21.top:=yoffset+nry*fbreite+fbreite-panel21.height-19;
      panel21.visible:=true;
      edit3.text:=p1feld.cells[nrx-1,nry-1];
      edit3.setfocus;
    end;
    pb4Paint(Sender);
end;

procedure TForm1.D8Click(Sender: TObject);
label 1;
var zahl:array[1..9] of byte;
    m,n,i,j,t:integer;
    k:string;
    leer:boolean;
begin
    panel21.visible:=false;
    p1feld.cells[nrx-1,nry-1]:=edit3.text;
    pb4paint(sender);

    if p1cb1.checked then
    begin
      p1p4.caption:='';
      for j:=0 to 8 do
      begin
        fillchar(zahl,sizeof(zahl),0);

        for i:=0 to 8 do
        begin
          k:=p1feld.cells[i,j];
          if (length(k)<2) then
            if (length(k)=1) and (k<>' ') then inc(zahl[strtoint(k)]);
        end;
        for t:=1 to 9 do
          if zahl[t]>1 then
          begin
            p1p4.caption:='Fehlerhafte Zahl im Arbeitsfeld!';
            exit
         end;
       fillchar(zahl,sizeof(zahl),0);
       for i:=0 to 8 do
       begin
         k:=p1feld.cells[j,i];
         if (length(k)<2) then
           if (length(k)>0) and (k<>' ') then inc(zahl[strtoint(k)]);
       end;
       for t:=1 to 9 do
         if zahl[t]>1 then
         begin
           p1p4.caption:='Fehlerhafte Zahl im Arbeitsfeld!';
           exit
         end;
      end;

      for m:=0 to 2 do
      begin
        for n:=0 to 2 do
        begin
          fillchar(zahl,sizeof(zahl),0);
          for j:=0 to 2 do
          begin
            for i:=0 to 2 do
            begin
              k:=p1feld.cells[m*3+j,n*3+i];
              if (length(k)<2) then
                if (length(k)>0) and (k<>' ') then inc(zahl[strtoint(k)]);
            end;
          end;
          for t:=1 to 9 do
            if zahl[t]>1 then
            begin
              p1p4.caption:='Fehlerhafte Zahl im Arbeitsfeld!';
              exit
            end;
        end;
      end;
      leer:=false;
      for j:=0 to 8 do
      begin
        for i:=0 to 8 do
        begin
          k:=p1feld.cells[i,j];
          if (length(k)=0) or (length(k)>1) or (k=' ') then leer:=true;
        end
      end;
      if not leer then p1p4.caption:='Gratulation! Sie haben das Sudoku-Rätsel gelöst!';
    end;
    pb4paint(sender);
end;

procedure TForm1.PB5paint(Sender: TObject);
const grad=9;
var b,h,i,j,xoffset,yoffset,ii:integer;
    bitmap:tbitmap;
    k,k1:string;
begin
    b:=PB5.width;
    h:=PB5.height;
    bitmap:=tbitmap.create;
    bitmap.width:=PB5.width;
    bitmap.height:=PB5.height;
    xoffset:=(b-(grad*fbreite)) div 2;
    yoffset:=(h-(grad*fbreite)) div 2;
    with bitmap.canvas do
    begin
      font.name:='Verdana';
      for i:=0 to grad-1 do
        for j:=0 to grad-1 do
        begin
          brush.color:=clwhite;
          pen.color:=clgray;
          if p1sg2.Cells[i,j]<>'' then Font.Color:=clnavy
                                  else Font.Color:=clBlack;
          rectangle(xoffset+i*fbreite,yoffset+j*fbreite,
                    xoffset+i*fbreite+fbreite+1,yoffset+j*fbreite+fbreite+1);
          k:=p1sg1.cells[i,j];
          brush.style:=bsclear;
          font.size:=24;
          if length(k)=1 then
          begin
            textout(xoffset+i*fbreite+(fbreite div 2)-(textwidth(k) div 2),
                    yoffset+j*fbreite+(fbreite div 2)-(textheight(k) div 2),k);
          end
          else
          begin
            font.size:=8;
            for ii:=1 to 9 do
            begin
              if pos(inttostr(ii),k)>0 then
              begin
                k1:=inttostr(ii);
                textout(xoffset+i*fbreite+5+((ii-1) mod 3)*10,
                        yoffset+j*fbreite+2+((ii-1) div 3)*11,k1);
              end;
            end;
          end;
        end;
      end;
      bitmap.canvas.pen.width:=2;
      bitmap.canvas.pen.color:=clblack;
      bitmap.canvas.moveto(xoffset+3*fbreite,yoffset);
      bitmap.canvas.lineto(xoffset+3*fbreite,yoffset+9*fbreite+1);
      bitmap.canvas.moveto(xoffset+6*fbreite,yoffset);
      bitmap.canvas.lineto(xoffset+6*fbreite,yoffset+9*fbreite+1);
      bitmap.canvas.moveto(xoffset,yoffset+3*fbreite);
      bitmap.canvas.lineto(xoffset+9*fbreite,yoffset+3*fbreite);
      bitmap.canvas.moveto(xoffset,yoffset+6*fbreite);
      bitmap.canvas.lineto(xoffset+9*fbreite,yoffset+6*fbreite);
      bitmap.canvas.pen.width:=3;
      bitmap.canvas.pen.color:=clnavy;
      bitmap.canvas.brush.style:=bsclear;
      bitmap.canvas.rectangle(xoffset-1,yoffset-1,
                 xoffset+grad*fbreite+2,yoffset+grad*fbreite+2);
      bitmap.canvas.pen.width:=1;
      pB5.canvas.draw(0,0,bitmap);
      bitmap.free;
end;

procedure TForm1.S11Click(Sender: TObject);
begin
  bildkopieren(pb5);
end;

procedure TForm1.d11Click(Sender: TObject);
var i,j:integer;
begin
    with p1Feld do
      for i:=0 to 8 do
        for j:=0 to 8 do
        begin
          Cells[i,j]:='';
          Objects[i,j]:=pointer(0);
        end;
    panel22.visible:=false;
    pb4paint(sender);
    pb5paint(sender);
end;

procedure TForm1.D10Click(Sender: TObject);
begin
  panel22.visible:=false;
  pb4paint(sender);
  pb5paint(sender);
end;

procedure TForm1.M76Click(Sender: TObject);
begin
  Application.CreateForm(Tfsudoku2, fsudoku2);
  fsudoku2.showmodal;
  fsudoku2.release;
end;

procedure TForm1.M77Click(Sender: TObject);
begin
  Application.CreateForm(Tflsumme, flsumme);
  flsumme.showmodal;
  flsumme.release;
end;

procedure TForm1.M78Click(Sender: TObject);
begin
  Application.CreateForm(Tfakari, fakari);
  fakari.showmodal;
  fakari.release;
end;

procedure TForm1.M79Click(Sender: TObject);
begin
  Application.CreateForm(Tfgleich, fgleich);
  fgleich.showmodal;
  fgleich.release;
end;

procedure TForm1.M80Click(Sender: TObject);
begin
  Application.CreateForm(TFConq, FConq);
  fconq.showmodal;
  fconq.release;
end;

procedure TForm1.M81Click(Sender: TObject);
begin
  Application.CreateForm(TFfuenf, Ffuenf);
  ffuenf.showmodal;
  ffuenf.release;
end;

end.

