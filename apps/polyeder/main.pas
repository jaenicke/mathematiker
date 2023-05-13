unit main;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, gl, glu, glex, 
  ExtCtrls, StdCtrls, Menus, ComCtrls;

type
   TMform = class(TForm)
    Timer1: TTimer;
    Panel2: TPanel;
    ListBox1: TListBox;
    Label1: TLabel;
    d1: TButton;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Edit4: TEdit;
    UpDown4: TUpDown;
    Label5: TLabel;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    MainMenu1: TMainMenu;
    Ende1: TMenuItem;
    Koordinaten1: TMenuItem;
    Panel1: TPanel;
    Memo1: TMemo;
    Darstellungsmodus1: TMenuItem;
    M0: TMenuItem;
    M1: TMenuItem;
    M2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure D1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure Edit2Change(Sender: TObject);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure CheckBox1Click(Sender: TObject);
    procedure Ende1Click(Sender: TObject);
    procedure Koordinaten1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure M0Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure M2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{$R xpoly.RES}
{$R xeck.RES}

type _pp = array[0..4000,0..2] of single;
type _fpp = array[0..4000] of smallint;
var
  Mform: TMform;
  rotang:glfloat;
  conti:boolean;
  count, elapsedframetime, starttime:cardinal;
  ppx : ^_pp;
  ppy : _pp;
  fppy : _fpp;
  flaechenfeld : ^_fpp;
  pzahl,punktzahl : integer;
  rundesw:smallint;
  smax,dx,dy,dz:real;

implementation

{$R *.DFM}

const w:real=1;
      nullbyte:smallint=-1;
      abbruch:boolean=false;
      nr:integer=1;
      speed:integer=60;
      vv:real=0;
      drehen:boolean=false;
      weiss:boolean=true;
      modus:byte=0;
var   xalt,yalt:integer;

procedure seite;
var ko,nn,z:integer;
begin
    w:=2.1/smax;
    nn:=1;
    z:=0;
    glBegin(GL_TRIANGLE_fan);
  repeat
    if flaechenfeld[nn]=-1
    then begin
      glEnd();
      z:=0;
      if nn<punktzahl then begin
        glBegin(GL_TRIANGLE_fan);
      end;
    end
    else
    begin
      if flaechenfeld[nn]>=10000 then
      begin
        ko:=flaechenfeld[nn]-10000;
        glColor3f(0,0,1);
        glVertex3f(w*ppx[ko,0],
                   w*ppx[ko,1],
                   w*ppx[ko,2]);
      end
      else begin
      case z of
        0 : glColor3f(1,0,0);
        1 : glColor3f(0.95,0.95,0.95);
        2 : glColor3f(0,0,1);
        3 : glColor3f(0,1,0);
        4 : glColor3f(0,1,1);
        5 : glColor3f(1,0,1);
        6 : glColor3f(1,1,0);
        7 : glColor3f(0.9,0.4,0.4);
        8 : glColor3f(0.4,0.9,0.4);
        9 : glColor3f(0.4,0.4,0.9);
       10 : glColor3f(1,0.4,0.4);
       11 : glColor3f(0.4,1,0.4);
       12 : glColor3f(0.4,0.4,1);
       13 : glColor3f(1,0,0.4);
       14 : glColor3f(1,0.4,0);
       15 : glColor3f(1,1,0.4);
       16 : glColor3f(1,0.4,1);
       17 : glColor3f(0.6,0.6,0.6);
       18 : glColor3f(0.6,0,0.6);
       19 : glColor3f(0.6,1,0.6);
      else glColor3f(1,0.4,0);
      end;
      inc(z);
      glVertex3f(w*ppx[flaechenfeld[nn],0],
                 w*ppx[flaechenfeld[nn],1],
                 w*ppx[flaechenfeld[nn],2]);
      end;
    end;
    inc(nn);
  until nn>punktzahl;
end;
procedure gitter;
var ko,nn:integer;
begin
    w:=2.1/smax;
    nn:=1;
    glBegin(GL_LINE_LOOP);
  repeat
    if flaechenfeld[nn]=-1
    then begin
      glEnd();
      if nn<punktzahl then begin
        glBegin(GL_LINE_LOOP);
      end;
    end
    else
    begin
      if flaechenfeld[nn]>=10000 then
      begin
        ko:=flaechenfeld[nn]-10000;
        if weiss or (modus<>2) then glColor3f(0,0,0.2)
                               else glColor3f(1,1,0.8);
        glVertex3f(w*ppx[ko,0],
                   w*ppx[ko,1],
                   w*ppx[ko,2]);
      end
      else begin
        if weiss or (modus<>2) then glColor3f(0,0,0.2)
                               else glColor3f(1,1,0.8);
        glVertex3f(w*ppx[flaechenfeld[nn],0],
                   w*ppx[flaechenfeld[nn],1],
                   w*ppx[flaechenfeld[nn],2]);
      end;
    end;
    inc(nn);
  until nn>punktzahl;
end;

procedure drawscene;
var f:real;
begin
   starttime:=gettickcount;
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
   glpushmatrix;
   f:=4.4+vv;
   glTranslatef(f,f,f);
   if (dx<>0) or (dy<>0) or (dz<>0) then glRotatef(-rotang, dx, dy, dz);
   case modus of
     1 : begin gitter; seite; end;
     2 : gitter;
    else seite;
   end;
   glPopMatrix;
   glFinish;
   SwapBuffers(DC);
   elapsedframetime:=gettickcount-starttime;
end;

procedure TMform.FormDestroy(Sender: TObject);
begin
   releaserc(handle);
end;

procedure TMform.FormResize(Sender: TObject);
begin
   if panel1.visible then
     resizeviewport(mform.Width-panel1.width, mform.clientheight+panel2.height)
   else
     resizeviewport(mform.Width, mform.clientheight+panel2.height);
end;

procedure Animate;
begin
   repeat
     rotang:=rotang+(elapsedframetime*speed)/1500;
     drawscene;
     inc(count);
     application.ProcessMessages;
   until (not conti) or abbruch;
end;

procedure TMform.Timer1Timer(Sender: TObject);
begin
   conti:=true;
   count:=0;
   timer1.Enabled:=false;
   Animate;
end;

procedure TMform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   conti:=false;
end;

procedure TMform.D1Click(Sender: TObject);
begin
   if abbruch=false then begin abbruch:=true; d1.caption:='Start' end
      else begin abbruch:=false; timer1.enabled:=true; d1.caption:='Stop' end;
end;

//Eckkordinaten aus res lesen
procedure ppyladen;
var ms1: TResourcestream;
    i:integer;
    ww:real;
begin
   ms1 := TResourceStream.Create(hinstance,'x'+inttostr(nr),'RT_RCDATA');
    try
      ms1.readbuffer(ppy,ms1.size);
      pzahl:=(ms1.size-2) div 12;
  finally
    ms1.Free;
  end;
  ppx:=@ppy;
  smax:=0;
  for i:=0 to pzahl-1 do begin
    ww:=sqr(ppx[i,0])+sqr(ppx[i,1])+sqr(ppx[i,2]);
    if ww>smax then smax:=ww;
  end;
  smax:=sqrt(smax);
end;
//Ecken der Flächen aus res lesen
procedure flaladen;
var ms1: TResourcestream;
begin
   ms1 := TResourceStream.Create(hinstance,'e'+inttostr(nr),'RT_RCDATA');
    try
      ms1.readbuffer(fppy,ms1.size);
      punktzahl:=(ms1.size-2) div 2;
  finally
    ms1.Free;
  end;
  flaechenfeld:=@fppy;
end;

procedure TMform.FormCreate(Sender: TObject);
var k:string;
begin
   mform.width:=720;
   mform.height:=730;
   initrc(mform.Handle);
   initgl(mform.Width, mform.clientheight+panel2.height);
   glMatrixMode(GL_MODELVIEW);
   glulookat(8,8,8,0,0,0,0,0,5);
   glClearColor(1, 1, 1, 1);
   abbruch:=false;
   timer1.Enabled:=true;

   dx:=updown3.position/10;
   dy:=updown4.position/10;
   dz:=updown5.position/10;
   vv:=0;
   speed:=60;
   listbox1.itemindex:=0;
   k:=listbox1.items[0];
   mform.caption:=copy(k,1,pos(#9,k)-1);
   delete(k,1,pos(#9,k));
   nr:=strtoint(k);

   ppyladen;
   flaladen;

   label1.caption:=inttostr(listbox1.items.count)+' Polyeder';
end;

procedure TMform.ListBox1Click(Sender: TObject);
var i,sel,anz:integer;
    k,k2,h:string;
begin
    sel:=listbox1.itemindex;
    if sel>=0 then
    begin
      k:=listbox1.items[sel];
      mform.caption:=copy(k,1,pos(#9,k)-1);
      delete(k,1,pos(#9,k));
      nr:=strtoint(k);

      ppyladen;
      flaladen;
      if abbruch=true then drawscene;

      if panel1.visible then
      begin
        memo1.clear;
        k:='Eckpunkte ('+inttostr(pzahl+1)+')'#13#10;
        for i:=0 to pzahl do
        begin
           k:=k+inttostr(i)+#9+
              '('+floattostrf(ppx[i,0],ffgeneral,4,3)+
              ' | '+floattostrf(ppx[i,1],ffgeneral,4,3)+
              ' | '+floattostrf(ppx[i,2],ffgeneral,4,3)+')'+#13#10;
        end;
         k2:='';
         i:=1;
         anz:=0;
         h:='  (';
         repeat
           if flaechenfeld[i]<>-1
           then
             h:=h+inttostr(flaechenfeld[i])+', '
           else begin
             delete(h,length(h)-1,2);
             k2:=k2+h+')'+#13#10;
             inc(anz);
             h:='  (';
           end;
           inc(i);
         until i>punktzahl;
         k2:='Flächen ('+inttostr(anz)+')'#13#10+k2;
         memo1.text:=k+k2;
       end;
     end;
end;

procedure TMform.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
    speed:=round(1.2*updown1.position);
end;

procedure TMform.Edit2Change(Sender: TObject);
begin
    vv:=updown2.position/10;
end;

procedure TMform.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
    dx:=strtoint(edit3.text)/10;
    dy:=strtoint(edit4.text)/10;
    dz:=strtoint(edit5.text)/10;
end;

procedure TMform.CheckBox1Click(Sender: TObject);
begin
   weiss:=checkbox1.checked;
   if weiss then
     glClearColor(1, 1, 1, 1)
   else
     glClearColor(0, 0, 0, 1);
end;

procedure TMform.Ende1Click(Sender: TObject);
begin
   close
end;

procedure TMform.Koordinaten1Click(Sender: TObject);
begin
   panel1.visible:=not panel1.visible;
   if panel1.visible then
     resizeviewport(mform.Width-panel1.width, mform.clientheight+panel2.height)
   else
     resizeviewport(mform.Width, mform.clientheight+panel2.height);
    ListBox1Click(Sender);
end;

procedure TMform.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    drehen:=true;
    xalt:=x;
    yalt:=y;
    abbruch:=true;
    d1.caption:='Start';
end;

procedure TMform.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var f:real;  
begin
   if drehen then begin
     dy:=xalt-x;
     dx:=y-yalt;
     dz:=0;

     glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
     glpushmatrix;
     f:=4.4+vv;
     glTranslatef(f,f,f);
     if (dx<>0) or (dy<>0) then glRotatef(-rotang, dx, dy, dz);
     seite;
     glPopMatrix;
     glFinish;
     SwapBuffers(DC);

     application.processmessages;
   end;
end;

procedure TMform.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    drehen:=false;
    updown3.position:=round(dx) mod 40;
    updown4.position:=round(dy) mod 40;
    updown5.position:=round(dz) mod 40;
end;

procedure TMform.M0Click(Sender: TObject);
begin
    modus:=0;
    m0.checked:=true;
    m1.checked:=false;
    m2.checked:=false;
    drawscene;
end;

procedure TMform.M1Click(Sender: TObject);
begin
    modus:=1;
    m0.checked:=false;
    m1.checked:=true;
    m2.checked:=false;
    drawscene;
end;

procedure TMform.M2Click(Sender: TObject);
begin
    modus:=2;
    m0.checked:=false;
    m1.checked:=false;
    m2.checked:=true;
    drawscene;
end;

end.



