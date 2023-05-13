unit pkopfrechnen;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Buttons, bestliste, ToolWin, ComCtrls, ExtCtrls,
  Mask;

type
  Tkopfr = class(TForm)
    Edit3: TEdit;
    L1: TLabel;
    AEdit: TEdit;
    S6: TStaticText;
    Timer1: TTimer;
    L2: TLabel;
    Panel2: TPanel;
    RG1: TRadioGroup;
    S2: TStaticText;
    S5: TStaticText;
    S4: TStaticText;
    Panel1: TPanel;
    L3: TLabel;
    NochZeit: TEdit;
    RiEdit: TEdit;
    S8: TStaticText;
    FaEdit: TEdit;
    S7: TStaticText;
    L4: TLabel;
    d1: TButton;
    Babbruch: TButton;
    CheckBox1: TCheckBox;
    UpDown1: TUpDown;
    Edit1: TEdit;
    UpDown2: TUpDown;
    Edit2: TEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AEditKeyPress(Sender: TObject; var Key: Char);
    procedure StartmsgClickClick(Sender: TObject);
    procedure StopMsgClick(Sender: TObject);
    procedure ValEdtExit(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  public
    answer:integer;
    timeleft:integer;
    right, wrong:integer;
    rechenzeit: tdatetime;
    procedure makenextproblem;
    function checkanswer:boolean;
  end;

var
  kopfr: Tkopfr;

implementation

{$R *.DFM}

procedure Tkopfr.makenextproblem;
var
  range:integer;
  v1,v2:integer;
  i,N:integer;
  opcode:char;
begin
  AEdit.setfocus;
  opcode:='?';
  range:=round(updown2.position-updown1.position+1);
  v1:=round(updown1.position+random(range));
  v2:=round(updown1.position+random(range));
  if rg1.itemindex=4 then i:=random(4)
                     else i:=rg1.itemindex;
  case i of
    0: {+} begin
        opcode:='+';
        answer:=v1+v2;
      end;
    1: {-} begin
        opcode:='-';
        if v1<v2 then begin
          n:=v1;
          v1:=v2;
          v2:=n;
        end;
        answer:=v1-v2;
      end;
    2: {*} begin
        opcode:=char($D7);
        answer:=v1*v2;
      end;
    3: {/} begin
        opcode:=':';
        if v2=0 then
        repeat
          v2:=round(updown1.position+random(range));
        until v2<>0;
        v1:=v1*v2;
        answer:=v1 div v2;
      end;
  end;
  edit3.text:=inttostr(v1)+' '+opcode+' '+inttostr(v2);
  AEdit.text:='';
end;

function Tkopfr.checkanswer:boolean;
var
  errcode, guess :integer;
begin
  val(AEdit.text,guess,errcode);
  checkanswer:=true;
  if AEdit.text='' then begin
    showmessage('Zahl eingeben');
    checkanswer:=false;
    inc(wrong);
    faedit.text:=inttostr(wrong);
  end else begin
    if guess=answer then begin
      inc(right);
      riedit.text:=inttostr(right);
    end else begin
      inc(wrong);
      faedit.text:=inttostr(wrong);
      showmessage('Leider falsch, die richtige Antwort ist '+ edit3.text
                   + ' = '+inttostr(answer));
    end;
  end;
  AEdit.text:='';
end;

procedure Tkopfr.Timer1Timer(Sender: TObject);
begin
  if (not checkbox1.checked) then begin
    dec(timeleft);
    NochZeit.text:=inttostr(timeleft);
  end else
    l3.caption:='Rechenzeit    '+formatdatetime('nn:ss',now-rechenzeit);
  application.processmessages;
  if (timeleft<=0) then begin
    timer1.enabled:=false;
    showmessage(inttostr(right)+' richtige Antworten und '+inttostr(wrong)+' falsche Antworten');
    spunkte:=right-wrong;
    if spunkte>0 then begin
      Application.CreateForm(Tbestenliste, bestenliste);
      bestenliste.showmodal;
      bestenliste.release;
    end;
    spunkte:=0;
    d1.enabled:=true;
    updown2.enabled:=true;
    updown1.enabled:=true;
    rg1.enabled:=true;
    edit3.text:='';
    AEdit.text:='';
  end;
end;

procedure Tkopfr.FormActivate(Sender: TObject);
begin
  randomize;
  rechenzeit:=now;
  updown2.enabled:=true;
  updown1.enabled:=true;
  rg1.enabled:=true;
  rg1.itemindex:=0;
end;

procedure Tkopfr.AEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not timer1.enabled then begin
    key:=#00;
  end else
    if key=#13 {enter} then begin
      if not CheckAnswer then exit;
      makeNextProblem;
      key:=#00;
    end else
      if not (key in[#8, '0'..'9']) then begin
        key:=#00;
        showmessage('Es sind nur Ziffern 0,1,2,3,4,5,6,7,8,9 erlaubt!');
      end;
end;

procedure Tkopfr.StartmsgClickClick(Sender: TObject);
begin
  if not timer1.enabled then begin
    if checkbox1.checked then rechenzeit:=now;
    timeleft:=60;
    riedit.text:='0';
    right:=0;
    faedit.text:='0';
    wrong:=0;
    updown2.enabled:=false;
    updown1.enabled:=false;
    rg1.enabled:=false;
    checkbox1.enabled:=false;
    spielname:='Kopfrechnen '+_strkomma(updown1.position,1,0)+'/'+_strkomma(updown2.position,1,0)+
      ' '+rg1.items[rg1.itemindex];
    if checkbox1.checked then
      spielname:=spielname+' ohne Zeit';
    timer1.enabled:=true;
    d1.enabled:=false;
    makenextproblem;
  end;
end;

procedure Tkopfr.StopMsgClick(Sender: TObject);
begin
  if timer1.enabled then begin
    timeleft:=0;
    updown2.enabled:=true;
    updown1.enabled:=true;
    rg1.enabled:=true;
    checkbox1.enabled:=true;
  end;
end;

procedure Tkopfr.ValEdtExit(Sender: TObject);
var n:integer;
begin
  if updown2.position=updown1.position then updown2.position:=updown1.position+1
  else
    If updown2.position<updown1.position then begin
      n:=updown2.position;
      updown2.position:=updown1.position;
      updown1.position:=n;
    end;
end;

procedure Tkopfr.S3Click(Sender: TObject);
begin
  close;
end;

procedure Tkopfr.CheckBox1Click(Sender: TObject);
begin
  NochZeit.visible:=not checkbox1.checked;
  if not checkbox1.checked then l3.caption:='verbleibende Zeit'
                       else l3.caption:='Rechenzeit'
end;

end.
