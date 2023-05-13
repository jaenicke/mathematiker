unit utonausgabe;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, Buttons, ComCtrls, StdCtrls, mmsystem, ExtCtrls;

type
  TMIDIInstrument = (midiAcousticGrandPiano, midiBrightAcousticPiano,
                     midiElectricGrandPiano, midiHonkyTonkPiano,
                     midiRhodesPiano, midiChorusedPiano, midiHarpsichord,
                     midiClavinet, midiCelesta, midiGlockenspiel,
                     midiMusicBox, midiVibraphone, midiMarimba, midiXylophone,
                     midiTubularBells, midiDulcimer, midiHammondOrgan,
                     midiPercussiveOrgan, midiRockOrgan, midiChurchOrgan,
                     midiReedOrgan, midiAccordion, midiHarmonica,
                     midiTangoAccordion, midiAcousticGuitarNylon,
                     midiAcousticGuitarSteel, midiElectricGuitarJazz,
                     midiElectricGuitarClean, midiElectricGuitarMuted,
                     midiOverdrivenGuitar, midiDistortionGuitar,
                     midiGuitarHarmonics, midiAcousticBass, midiElectricBassFinger,
                     midiElectricBassPick, midiFretlessBass, midiSlapBass1,
                     midiSlapBass2, midiSynthBass1, midiSynthBass2, midiViolin,
                     midiViola, midiCello, midiContrabass, midiTremoloStrings,
                     midiPizzicatoStrings, midiOrchestralHarp, midiTimpani,
                     midiStringEnsemble1, midiStringEnsemble2, midiSynthStrings1,
                     midiSynthStrings2, midiChoirAahs, midiVoiceOohs,
                     midiSynthVoice, midiOrchestraHit, midiTrumpet, midiTrombone,
                     midiTuba, midiMutedTrumpet, midiFrenchHorn, midiBrassSection,
                     midiSynthBrass1, midiSynthBrass2, midiSopranoSax, midiAltoSax,
                     midiTenorSax, midiBaritoneSax, midiOboe, midiEnglishHorn,
                     midiBassoon, midiClarinet, midiPiccolo, midiFlute,
                     midiRecorder, midiPanFlute, midiBottleBlow, midiShakuhachi,
                     midiWhistle, midiOcarina, midiLead1Square,
                     midiLead2Sawtooth, midiLead3CalliopeLead, midiLead4ChiffLead,
                     midiLead5Charang, midiLead6Voice, midiLead7Fifths,
                     midiLead8BrassLead, midiPad1NewAge, midiPad2Warm,
                     midiPad3Polysynth, midiPad4Choir, midiPad5Bowed,
                     midiPad6Metallic, midiPad7Halo, midiPad8Sweep, midiEmpty0,
                     midiEmpty1, midiEmpty2, midiEmpty3, midiEmpty4, midiEmpty5,
                     midiEmpty6, midiEmpty7, midiEmpty8, midiEmpty9, midiEmpty10,
                     midiEmpty11, midiEmpty12, midiEmpty13, midiEmpty14,
                     midiEmpty15, midiEmpty16, midiEmpty17, midiEmpty18,
                     midiEmpty19, midiEmpty20, midiEmpty21, midiEmpty22,
                     midiEmpty23, midiGuitarFretNoise, midiBreathNoise,
                     midiSeashore, midiBirdTweet, midiTelephoneRing,
                     midiHelicopter, midiApplause, midiGunshot);

  TFMus = class(TForm)
    PM1: TPopupMenu;
    x1: TMenuItem;
    P2: TPanel;
    p4: TPanel;
    tonl: TPanel;
    P13: TPanel;
    i1: TImage;
    ComboBox1: TComboBox;
    Piano: TPanel;
    La1: TShape;
    Mi4: TShape;
    Re4: TShape;
    Do4: TShape;
    Si4: TShape;
    La4: TShape;
    Sol4: TShape;
    Fa4: TShape;
    Mi3: TShape;
    Re3: TShape;
    Do3: TShape;
    Si3: TShape;
    La3: TShape;
    Sol3: TShape;
    Fa3: TShape;
    Mi2: TShape;
    Re2: TShape;
    Do2: TShape;
    Si2: TShape;
    La2: TShape;
    Sol2: TShape;
    Fa2: TShape;
    Mi1: TShape;
    Re1: TShape;
    Do1: TShape;
    Si1: TShape;
    Sol1: TShape;
    Fa1: TShape;
    Do1d: TShape;
    Fa1d: TShape;
    La1d: TShape;
    Sol1d: TShape;
    Re1d: TShape;
    Fa2d: TShape;
    La2d: TShape;
    Sol2d: TShape;
    Re2d: TShape;
    Do2d: TShape;
    Fa3d: TShape;
    La3d: TShape;
    Sol3d: TShape;
    Re3d: TShape;
    Do3d: TShape;
    Fa4d: TShape;
    La4d: TShape;
    Sol4d: TShape;
    Re4d: TShape;
    Do4d: TShape;
    Mi5: TShape;
    Re5: TShape;
    Do5: TShape;
    Si5: TShape;
    La5: TShape;
    Sol5: TShape;
    Fa5: TShape;
    Re5d: TShape;
    Fa5d: TShape;
    La5d: TShape;
    Sol5d: TShape;
    Do5d: TShape;
    Do6: TShape;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label3: TLabel;
    L86: TLabel;
    LB3: TListBox;
    Hilfe1: TMenuItem;
    bnote: TImage;
    bnote2: TImage;
    L89: TLabel;
    D9: TButton;
    D1: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure B3C(Sender: TObject);
    procedure a7C(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure La1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure D1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure i1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure i1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    abbruch:boolean;
    shapes:array[36..96] of tshape;
    ton1:array[36..62] of tpoint;
    ton2:array[60..86] of tpoint;
    xd,yd:integer;
    melodieliste:tstringlist;
    procedure makesound(fr,la:integer);
    procedure soundinit;
    procedure NoteOn(NewNote, NewIntensity: byte);
    procedure NoteOff(NewNote, NewIntensity: byte);
    procedure note(a:integer;laenge:integer); overload;
    procedure note(a,b:integer;laenge:integer); overload;
    procedure note(a,b,c:integer;laenge:integer); overload;
    procedure note(a,b,c,d:integer;laenge:integer); overload;
    procedure note(a,b,c,d,e:integer;laenge:integer); overload;
    procedure note(a,b,c,d,e,f:integer;laenge:integer); overload;
    procedure SetMidiVolume(var volLe, volRi: Word);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMus: TFMus;
  mo: HMIDIOUT;
  volLe, volRi, oldvol: Word;
  voll: integer;
  xt:array[0..9] of integer;
const
  MIDI_NOTE_ON = $90;
  MIDI_NOTE_OFF = $80;
  MIDI_CHANGE_INSTRUMENT = $C0;

  MAX_VOLUME = 65535;
  HALF_VOLUME = 32768;
  MIN_VOLUME = 0;
  FADE_SPEED = 64;

implementation

{$R *.DFM}
const
   tfarbe : array[36..96] of byte
      = (0,1,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,1,0,
         0,1,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,1,0,0);
   nname: array[0..11] of string[3]
      = ('C','Cis','D','Dis','E','F','Fis','G','Gis','A','B','H');

function MIDIEncodeMessage(Msg, Param1, Param2: byte): integer;
begin
  result := Msg + (Param1 shl 8) + (Param2 shl 16);
end;

procedure tfmus.NoteOn(NewNote, NewIntensity: byte);
begin
  if tfarbe[newnote]=0 then shapes[newnote].brush.color:=clblue
                       else shapes[newnote].brush.color:=clred;
  if abbruch then begin
    if newnote in [36..62] then i1.canvas.draw(ton1[newnote].x,ton1[newnote].y,bnote2.picture.graphic);
    if newnote in [60..86] then i1.canvas.draw(ton2[newnote].x,ton2[newnote].y,bnote2.picture.graphic);
  end;
  l89.caption:=inttostr( round(440.0*exp((newnote-69)/12*ln(2)) ))+' Hz';
  application.processmessages;
  midiOutShortMsg(mo, MIDIEncodeMessage(MIDI_NOTE_ON, NewNote, NewIntensity));
end;

procedure tfmus.NoteOff(NewNote, NewIntensity: byte);
begin
  midiOutShortMsg(mo, MIDIEncodeMessage(MIDI_NOTE_OFF, NewNote, NewIntensity));
  if tfarbe[newnote]=0 then shapes[newnote].brush.color:=clwhite
                       else shapes[newnote].brush.color:=clblack;
  if abbruch then begin
    if newnote in [36..62] then i1.canvas.draw(ton1[newnote].x,ton1[newnote].y,bnote.picture.graphic);
    if newnote in [60..86] then i1.canvas.draw(ton2[newnote].x,ton2[newnote].y,bnote.picture.graphic);
  end;
  application.processmessages;
end;

procedure SetInstrument(NewInstrument: byte);
begin
  midiOutShortMsg(mo, MIDIEncodeMessage(MIDI_CHANGE_INSTRUMENT, NewInstrument, 0));
end;

procedure SetCurrentInstrument2(NewInstrument: Integer);
begin
  midiOutShortMsg(mo, MIDIEncodeMessage(MIDI_CHANGE_INSTRUMENT, NewInstrument, 0));
end;

procedure SetCurrentInstrument(CurrentInstrument: TMIDIInstrument);
begin
  midiOutShortMsg(mo, MIDIEncodeMessage(MIDI_CHANGE_INSTRUMENT, ord(CurrentInstrument), 0));
end;

procedure InitMIDI;
begin
  midiOutOpen(@mo, 0, 0, 0, CALLBACK_NULL);
  midiOutShortMsg(mo, MIDIEncodeMessage(MIDI_CHANGE_INSTRUMENT, 0, 0));
end;

procedure SetPlaybackVolume(PlaybackVolume: cardinal); // 0 - 65535
begin
  midiOutSetVolume(mo, PlaybackVolume);
end;

procedure Tfmus.SetMidiVolume(var volLe, volRi: Word);
var vol: DWORD;
begin
 vol := volLe + volRi shl 16;
 midiOutSetVolume(0, vol);
end;

procedure GetMidiOutDevices2;
var
  dev: Integer;
  caps: TMidiOutCaps;
begin
  Fmus.ComboBox1.Clear;
  for dev := 0 to midiOutGetNumDevs - 1 do
  begin
    midiOutGetDevCaps(dev, @caps, sizeof(TMidiOutCaps));
    Fmus.ComboBox1.Items.Add(caps.szPname);
  end;
  Fmus.ComboBox1.ItemIndex := 0; //primäre Soundkarte
end;

procedure TFMus.FormCreate(Sender: TObject);
begin
   GetMidiOutDevices2;
   InitMIDI;

   melodieliste:=tstringlist.create;
   abbruch:=true;
   voll:=640;

   radiogroup1.itemindex:=0;
   lb3.itemindex:=2;

    shapes[36]:=do1;
    shapes[37]:=do1d;
    shapes[38]:=re1;
    shapes[39]:=re1d;
    shapes[40]:=mi1;
    shapes[41]:=fa1;
    shapes[42]:=fa1d;
    shapes[43]:=sol1;
    shapes[44]:=sol1d;
    shapes[45]:=la1;
    shapes[46]:=la1d;
    shapes[47]:=si1;
    shapes[48]:=do2;
    shapes[49]:=do2d;
    shapes[50]:=re2;
    shapes[51]:=re2d;
    shapes[52]:=mi2;
    shapes[53]:=fa2;
    shapes[54]:=fa2d;
    shapes[55]:=sol2;
    shapes[56]:=sol2d;
    shapes[57]:=la2;
    shapes[58]:=la2d;
    shapes[59]:=si2;
    shapes[60]:=do3;
    shapes[61]:=do3d;
    shapes[62]:=re3;
    shapes[63]:=re3d;
    shapes[64]:=mi3;
    shapes[65]:=fa3;
    shapes[66]:=fa3d;
    shapes[67]:=sol3;
    shapes[68]:=sol3d;
    shapes[69]:=la3;
    shapes[70]:=la3d;
    shapes[71]:=si3;
    shapes[72]:=do4;
    shapes[73]:=do4d;
    shapes[74]:=re4;
    shapes[75]:=re4d;
    shapes[76]:=mi4;
    shapes[77]:=fa4;
    shapes[78]:=fa4d;
    shapes[79]:=sol4;
    shapes[80]:=sol4d;
    shapes[81]:=la4;
    shapes[82]:=la4d;
    shapes[83]:=si4;
    shapes[84]:=do5;
    shapes[85]:=do5d;
    shapes[86]:=re5;
    shapes[87]:=re5d;
    shapes[88]:=mi5;
    shapes[89]:=fa5;
    shapes[90]:=fa5d;
    shapes[91]:=sol5;
    shapes[92]:=sol5d;
    shapes[93]:=la5;
    shapes[94]:=la5d;
    shapes[95]:=si5;
    shapes[96]:=do6;
end;

procedure tfmus.soundinit;
begin
  case radiogroup1.itemindex of
    0 : SetCurrentInstrument(midiAcousticGrandPiano);
    1 : SetCurrentInstrument(midiStringEnsemble1);
    2 : SetCurrentInstrument(midiGlockenspiel);
    3 : SetCurrentInstrument(midiviola);
    4 : SetCurrentInstrument(midiClarinet);
    5 : SetCurrentInstrument(midiSynthStrings1);
    6 : SetCurrentInstrument(midiTrombone);
    7 : SetCurrentInstrument(midiPanFlute);
    8 : SetCurrentInstrument(midiPercussiveOrgan);
    9 : SetCurrentInstrument(midiAcousticGuitarNylon);
   10 : SetCurrentInstrument(midiTangoAccordion);
   11 : SetCurrentInstrument(midiTubularBells);
   12 : SetCurrentInstrument(midiTenorSax);
   13 : SetCurrentInstrument(midiPiccolo);
    else
        SetCurrentInstrument(midiClavinet);
  end;
  SetPlaybackVolume(65535);
  fmus.TrackBar2Change(nil);
end;

procedure tfmus.makesound(fr,la:integer);
var m:integer;
begin
  m:=round(12*ln(fr/440)/ln(2)+69);
  NoteOn(m, 127);
  sleep(la);
  NoteOff(m, 127);
end;

procedure TFMus.B3C(Sender: TObject);
begin
   soundinit;
   makesound(updown1.position,1000);
end;

procedure TFMus.a7C(Sender: TObject);
begin
 close;
end;

procedure TFMus.FormDestroy(Sender: TObject);
begin
  melodieliste.free;
  midiOutclose(mo);
end;

procedure TFMus.La1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var m,i:integer;
    gefunden:boolean;
begin
    soundinit;
    gefunden:=false;
    i:=36;
    repeat
      if (sender as tshape)=shapes[i] then gefunden:=true;
      inc(i);
    until gefunden or (i>96);
    m:=i-1;
    NoteOn(m, 127);
    sleep(800);
    NoteOff(m, 127);
end;

procedure tfmus.note(a:integer;laenge:integer);
begin
    NoteOn(a, 127);
    sleep(laenge);
    NoteOff(a, 127);
end;
procedure tfmus.note(a,b:integer;laenge:integer);
begin
    NoteOn(a, 127);
    NoteOn(b, 127);
    sleep(laenge);
    NoteOff(a, 127);
    NoteOff(b, 127);
end;
procedure tfmus.note(a,b,c:integer;laenge:integer);
begin
    NoteOn(a, 127);
    NoteOn(b, 127);
    NoteOn(c, 127);
    sleep(laenge);
    NoteOff(a, 127);
    NoteOff(b, 127);
    NoteOff(c, 127);
end;
procedure tfmus.note(a,b,c,d:integer;laenge:integer);
begin
    NoteOn(a, 127);
    NoteOn(b, 127);
    NoteOn(c, 127);
    NoteOn(d, 127);
    sleep(laenge);
    NoteOff(a, 127);
    NoteOff(b, 127);
    NoteOff(c, 127);
    NoteOff(d, 127);
end;
procedure tfmus.note(a,b,c,d,e:integer;laenge:integer);
begin
    NoteOn(a, 127);
    NoteOn(b, 127);
    NoteOn(c, 127);
    NoteOn(d, 127);
    NoteOn(e, 127);
    sleep(laenge);
    NoteOff(a, 127);
    NoteOff(b, 127);
    NoteOff(c, 127);
    NoteOff(d, 127);
    NoteOff(e, 127);
end;
procedure tfmus.note(a,b,c,d,e,f:integer;laenge:integer);
begin
    NoteOn(a, 127);
    NoteOn(b, 127);
    NoteOn(c, 127);
    NoteOn(d, 127);
    NoteOn(e, 127);
    NoteOn(f, 127);
    sleep(laenge);
    NoteOff(a, 127);
    NoteOff(b, 127);
    NoteOff(c, 127);
    NoteOff(d, 127);
    NoteOff(e, 127);
    NoteOff(f, 127);
end;

procedure TFMus.D1Click(Sender: TObject);
var i,laenge,n,n1,n2,n3,n4,n5,n6:integer;
    s:string;
    tonan:boolean;
    sel:integer;
procedure wtextdll(const kk:string);
var ms1: TResourcestream;
begin
    ms1 := TResourceStream.Create(hinstance,kk,'RT_RCDATA');
  try
    melodieliste.LoadFromStream(ms1);
  finally
    ms1.Free;
  end;
end;
procedure soundpi;
const
  s='31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679';
  fr : array[0..19] of integer
     = (264,275,297,309,330,352,367,396,413,440,458,495,528,550,594,618,660,704,734,792);
var i:integer;
begin
    soundinit;
    i:=1;
    repeat
      makesound(fr[ord(s[i])-47],200);
      if i mod 10 = 0 then application.processmessages;
      inc(i);
    until (i>50) or abbruch;
end;
function laengentest(c:char):integer;
begin
    case c of
      'V' : laengentest:=voll;
      'D' : laengentest:=2*voll;
      '3' : laengentest:=3*(voll div 2);
      'H' : laengentest:=voll div 2;
      '4' : laengentest:=voll div 4;
      '8' : laengentest:=voll div 8;
      else laengentest:=voll;
    end;
end;
begin
    if not abbruch then begin
      abbruch:=true;
      exit;
    end;
  sel:=lb3.itemindex;
  if sel>=0 then begin
    voll:=updown2.position;
    abbruch:=false;
    d1.caption:='Stop';
    d9.enabled:=false;
    application.processmessages;

    case sel of
     0..4 : wtextdll('melo'+inttostr(sel+1));
     else
     begin
       soundpi;
       abbruch:=true;
       d1.caption:='Melodie spielen';
       d9.enabled:=true;
       exit
     end;
    end;
    soundinit;
    tonan:=false;
    i:=0;
    repeat
      s:=melodieliste[i];
      case s[1] of
        'N' : begin
                tonan:=not tonan;
                n:=strtoint(copy(s,3,20));
                if s[2]='1' then NoteOn(n, 127)
                            else NoteOff(n, 127)
              end;
        'P' : begin
                laenge:=laengentest(s[2]);
                sleep(laenge);
              end;
        'T' : begin
                if s[2]='-' then voll:=voll-80
                            else voll:=voll+80;
              end;
        '1' : begin
                laenge:=laengentest(s[2]);
                delete(s,1,2);
                n1:=strtoint(s);
                note(n1,laenge);
              end;
        '2' : begin
                laenge:=laengentest(s[2]);
                delete(s,1,2);
                n1:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n2:=strtoint(s);
                note(n1,n2,laenge);
              end;
        '3' : begin
                laenge:=laengentest(s[2]);
                delete(s,1,2);
                n1:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n2:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n3:=strtoint(s);
                note(n1,n2,n3,laenge);
              end;
        '4' : begin
                laenge:=laengentest(s[2]);
                delete(s,1,2);
                n1:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n2:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n3:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n4:=strtoint(s);
                note(n1,n2,n3,n4,laenge);
              end;
        '5' : begin
                laenge:=laengentest(s[2]);
                delete(s,1,2);
                n1:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n2:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n3:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n4:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n5:=strtoint(s);
                note(n1,n2,n3,n4,n5,laenge);
              end;
        '6' : begin
                laenge:=laengentest(s[2]);
                delete(s,1,2);
                n1:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n2:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n3:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n4:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n5:=strtoint(copy(s,1,pos(',',s)-1));
                delete(s,1,pos(',',s));
                n6:=strtoint(s);
                note(n1,n2,n3,n4,n5,n6,laenge);
              end;
      end;
      inc(i);
    until (i>melodieliste.count-1) or abbruch;
    if abbruch then
      for i:=36 to 96 do NoteOff(i,127);
    abbruch:=true;
    d1.caption:='Melodie spielen';
    d9.enabled:=true;
  end;
end;

procedure TFMus.FormActivate(Sender: TObject);
var n,x,y:integer;
begin
   volle:=65535;
   volri:=65535;
   SetMidiVolume(volle,volri);
   TrackBar1.Position:= 65535;  //Volume
   TrackBar2.Position:= 65535;  //Balance

   i1.picture.bitmap.pixelformat:=pf24bit;

    n:=36;
    x:=56;
    y:=234+13+13;
    yd:=6;
    xd:=31;
    repeat
      if tfarbe[n]=0 then begin
        y:=y-yd;
        if yd=7 then yd:=6 else yd:=7;
      end;
      x:=x+xd;
      ton1[n].x:=x;
      ton1[n].y:=y;
      inc(n);
    until n>62;
    n:=60;
    x:=56;
    y:=94+13+7;
    repeat
      if tfarbe[n]=0 then begin
        y:=y-yd;
        if yd=7 then yd:=6 else yd:=7;
      end;
      x:=x+xd;
      ton2[n].x:=x;
      ton2[n].y:=y;
      inc(n);
    until n>86;
end;

procedure TFMus.i1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,m:integer;
    gefunden:boolean;
begin
   gefunden:=false;
   i:=36;
   repeat
     if (x>ton1[i].x) and (x<ton1[i].x+20) and (y>ton1[i].y) and (y<ton1[i].y+18) then gefunden:=true;
     inc(i);
   until gefunden or (i>62);
   if not gefunden then
   begin
     i:=60;
     repeat
       if (x>ton2[i].x) and (x<ton2[i].x+20) and (y>ton2[i].y) and (y<ton2[i].y+18) then gefunden:=true;
       inc(i);
     until gefunden or (i>86);
   end;
   if gefunden then
   begin
     m:=i-1;
     NoteOn(m, 127);
     sleep(800);
     NoteOff(m, 127);
   end;
end;

procedure TFMus.i1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i:integer;
    gefunden:boolean;
begin
   gefunden:=false;
   i:=36;
   repeat
     if (x>ton1[i].x) and (x<ton1[i].x+20) and (y>ton1[i].y) and (y<ton1[i].y+18) then gefunden:=true;
     inc(i);
   until gefunden or (i>62);
   if not gefunden then
   begin
     i:=60;
     repeat
       if (x>ton2[i].x) and (x<ton2[i].x+20) and (y>ton2[i].y) and (y<ton2[i].y+18) then gefunden:=true;
       inc(i);
     until gefunden or (i>86);
   end;
   if gefunden then i1.cursor:=crhandpoint
               else i1.cursor:=crdefault;
end;

procedure TFMus.Button1Click(Sender: TObject);
begin
  if TrackBar1.Position>0 then
  BEGIN
    oldVol:= TrackBar1.Position;
    TrackBar1.Position:=0;
  END else
    TrackBar1.Position:= oldVol;
end;

procedure TFMus.Button2Click(Sender: TObject);
begin
   TrackBar2.Position:= 65535;
end;

procedure TFMus.TrackBar1Change(Sender: TObject);
begin
   SetPlaybackVolume(TrackBar1.Position);
   TrackBar2Change(Sender);
end;

procedure TFMus.TrackBar2Change(Sender: TObject);
begin //Balance
   volle:=trackbar1.position;
   volri:=trackbar1.position;
   If TrackBar2.Position<65535 then
     volri:= round(1.0*TrackBar2.Position*TrackBar1.Position/65535);
   If TrackBar2.Position>65534 then
     volle:= round(1.0*(131070-TrackBar2.Position)*TrackBar1.Position/65535);
   SetMidiVolume(volle,volri);
end;

procedure TFMus.RadioGroup1Click(Sender: TObject);
begin
    if not abbruch then soundinit;
end;

end.

