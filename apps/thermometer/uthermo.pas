unit uthermo;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, Buttons, ComCtrls;

type
  Ttthermo = class(TForm)
    thermo: TPanel;
    Paintbox: TPaintBox;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image: TImage;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Combobox1: TComboBox;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    UpDown1: TUpDown;
    Edit6: TEdit;
    UpDown2: TUpDown;
    Edit7: TEdit;
    UpDown3: TUpDown;
    procedure PaintboxPaint(Sender: TObject);
    procedure taenderung(Sender: TObject);
    procedure Combobox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    name,abkuerzung : string;
    schmelz, siede : integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  tthermo: Ttthermo;

implementation

{$R *.DFM}
var tc,tf,tk:integer;
    nichtschalten:boolean;

procedure Ttthermo.PaintboxPaint(Sender: TObject);
var b,h,i,einteilung:integer;
    bitmap:tbitmap;
begin
    bitmap:=tbitmap.create;
    bitmap.width:=paintbox.width;
    bitmap.height:=paintbox.height;
    b:=paintbox.width div 6-10;
    h:=(paintbox.height-578) div 2-10;
    bitmap.canvas.font.name:='Verdana';

    bitmap.canvas.Pen.color:=clblue;
    bitmap.canvas.Pen.style:=psdot;
    bitmap.canvas.moveto(10,h+75);
    bitmap.canvas.lineto(paintbox.width-10,h+75);
    bitmap.canvas.moveto(10,h+75+300);
    bitmap.canvas.lineto(paintbox.width-10,h+75+300);

    bitmap.canvas.Pen.color:=clblack;
    bitmap.canvas.Pen.style:=pssolid;
    bitmap.canvas.draw(b-63,h,image.Picture.bitmap);
    bitmap.canvas.draw(3*b-63,h,image.Picture.bitmap);
    bitmap.canvas.draw(5*b-63,h,image.Picture.bitmap);
    bitmap.canvas.brush.style:=bsclear;
    bitmap.canvas.font.size:=10;
    for i:=100 downto -30 do
    begin
      bitmap.canvas.moveto(b+15,h+75+(100-i)*3);
      if i mod 10 = 0 then
      begin
        bitmap.canvas.lineto(b+45,h+75+(100-i)*3);
        bitmap.canvas.textout(b+30,h+58+(100-i)*3,inttostr(i));
      end
      else
      begin
        bitmap.canvas.lineto(b+25,h+75+(100-i)*3);
      end;
    end;

    for i:=373 downto 243 do
    begin
      bitmap.canvas.moveto(5*b+15,h+75+(373-i)*3);
      if i mod 10 = 0 then
      begin
        bitmap.canvas.lineto(5*b+45,h+75+(373-i)*3);
        bitmap.canvas.textout(5*b+30,h+58+(373-i)*3,inttostr(i));
      end
      else
      begin
        bitmap.canvas.lineto(5*b+25,h+75+(373-i)*3);
      end;
    end;

    case combobox1.itemindex of
      0 : begin
            for i:=212 downto -22 do
            begin
              if i mod 2 = 0 then
              begin
                bitmap.canvas.moveto(3*b+15,round(h+75+(212-i)*15/9));
                if i mod 10 = 0 then
                begin
                  bitmap.canvas.lineto(3*b+45,round(h+75+(212-i)*15/9));
                  if i mod 20 = 0 then
                  begin
                    bitmap.canvas.textout(3*b+30,round(h+59+(212-i)*15/9),inttostr(i));
                  end
                end
                else
                begin
                  bitmap.canvas.lineto(3*b+25,round(h+75+(212-i)*15/9));
                end;
              end;
            end;
          end;
      1 : begin
            for i:=80 downto -24 do
            begin
              bitmap.canvas.moveto(3*b+15,round(h+75+10/8*(80-i)*3));
              if i mod 10 = 0 then
              begin
                bitmap.canvas.lineto(3*b+45,round(h+75+10/8*(80-i)*3));
                bitmap.canvas.textout(3*b+30,round(h+58+10/8*(80-i)*3),inttostr(i));
              end
              else
              begin
                bitmap.canvas.lineto(3*b+25,round(h+75+10/8*(80-i)*3));
              end;
            end;
          end;
      3 : begin
            for i:=60 downto -8 do
            begin
              bitmap.canvas.moveto(3*b+15,round(h+75+40/21*(60-i)*3));
              if i mod 10 = 0 then
              begin
                bitmap.canvas.lineto(3*b+45,round(h+75+40/21*(60-i)*3));
                bitmap.canvas.textout(3*b+30,round(h+58+40/21*(60-i)*3),inttostr(i));
              end
              else
              begin
                bitmap.canvas.lineto(3*b+25,round(h+75+40/21*(60-i)*3));
              end;
            end;
          end;
      4 : begin
            einteilung:=10;
            if schmelz-siede>150 then einteilung:=100;
            if schmelz-siede>1500 then einteilung:=1000;
            if schmelz-siede>15000 then einteilung:=10000;

            if siede<schmelz then
            begin
              i:=schmelz;
              repeat
                if i mod einteilung = 0 then
                begin
                  bitmap.canvas.moveto(3*b+15,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                  bitmap.canvas.lineto(3*b+45,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                  bitmap.canvas.textout(3*b+27,round(h+58+100/(schmelz-siede)*(schmelz-i)*3),inttostr(i));
                end
                else
                begin
                  if i mod (einteilung div 5) = 0 then
                  begin
                    bitmap.canvas.moveto(3*b+15,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                    bitmap.canvas.lineto(3*b+25,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                  end;
                end;
                dec(i);
              until i<round((schmelz-siede)/100*(-32)+siede);
            end
            else
            begin //umgekehrte skale
              i:=schmelz;
              repeat
                if i mod einteilung = 0 then
                begin
                  bitmap.canvas.moveto(3*b+15,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                  bitmap.canvas.lineto(3*b+45,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                  bitmap.canvas.textout(3*b+27,round(h+58+100/(schmelz-siede)*(schmelz-i)*3),inttostr(i));
                end
                else
                begin
                  if i mod (einteilung div 5) = 0 then
                  begin
                    bitmap.canvas.moveto(3*b+15,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                    bitmap.canvas.lineto(3*b+25,round(h+75+100/(schmelz-siede)*(schmelz-i)*3));
                  end;
                end;
                inc(i);
              until i>round((schmelz-siede)/100*(-32)+siede);
            end;
          end;
      2 : begin
            for i:=195 downto 0 do
            begin
              bitmap.canvas.moveto(3*b+15,round(h+75+i*2));
              if i mod 10 = 0 then
              begin
                bitmap.canvas.lineto(3*b+45,round(h+75+i*2));
                bitmap.canvas.textout(3*b+30,round(h+58+i*2),inttostr(i));
              end
              else
              begin
                bitmap.canvas.lineto(3*b+25,round(h+75+i*2));
              end;
            end;
          end;
    end;

    bitmap.canvas.moveto(b-10,h+75+(100-tc)*3);
    bitmap.canvas.lineto(b+10,h+75+(100-tc)*3);
    bitmap.canvas.moveto(3*b-10,h+75+(100-tc)*3);
    bitmap.canvas.lineto(3*b+10,h+75+(100-tc)*3);
    bitmap.canvas.moveto(5*b-10,h+75+(100-tc)*3);
    bitmap.canvas.lineto(5*b+10,h+75+(100-tc)*3);
    bitmap.canvas.brush.color:=clred;
    bitmap.canvas.floodfill(b,h+75+(100-tc)*3+5,clblack,fsborder);
    bitmap.canvas.brush.color:=clyellow;
    bitmap.canvas.floodfill(3*b,h+75+(100-tc)*3+5,clblack,fsborder);
    bitmap.canvas.brush.color:=clgreen;
    bitmap.canvas.floodfill(5*b,h+75+(100-tc)*3+5,clblack,fsborder);

    bitmap.canvas.brush.style:=bsclear;
    bitmap.canvas.font.size:=20;
    bitmap.Canvas.textout(b-16,h+15,'°C');
    case combobox1.itemindex of
      0 : bitmap.Canvas.textout(3*b-16,h+15,'°F');
      1 : bitmap.Canvas.textout(3*b-25,h+15,'°Ré');
      2 : bitmap.Canvas.textout(3*b-16,h+15,'°D');
      3 : bitmap.Canvas.textout(3*b-25,h+15,'°Rø');
      4 : bitmap.Canvas.textout(3*b-16,h+15,abkuerzung);
    end;
    bitmap.Canvas.textout(5*b-10,h+15,'K');
    bitmap.canvas.font.size:=24;
    bitmap.Canvas.textout(b+75,h+90,inttostr(tc)+' °C');
    case combobox1.itemindex of
      0 : bitmap.Canvas.textout(3*b+75,h+90,inttostr(tf)+' °F');
      1 : bitmap.Canvas.textout(3*b+75,h+90,inttostr(tf)+' °Ré');
      2 : bitmap.Canvas.textout(3*b+75,h+90,inttostr(tf)+' °D');
      3 : bitmap.Canvas.textout(3*b+75,h+90,inttostr(tf)+' °Rø');
      4 : bitmap.Canvas.textout(3*b+75,h+90,inttostr(tf)+' '+abkuerzung);
    end;
    bitmap.Canvas.textout(5*b+75,h+90,inttostr(tk)+' K');
    nichtschalten:=false;

    paintbox.Canvas.draw(0,0,bitmap);
    bitmap.free;
end;

function intein(edit:tedit):integer;
var k:string;
    x,code:integer;
begin
    k:=edit.text;
    if k<>'' then
    begin
      val(k,x,code);
      intein:=x
    end
    else intein:=0;
end;

procedure Ttthermo.taenderung(Sender: TObject);
begin
    if nichtschalten=true then exit;
    nichtschalten:=true;
    if (sender=edit5) then
    begin
      tc:=intein(edit5);
      if tc<-32 then tc:=-32;
      if tc>102 then tc:=102;
      case combobox1.itemindex of
        0 : tf:=round(9*tc/5+32);
        1 : tf:=round(0.8*tc);
        2 : tf:=round(1.5*(100-tc));
        3 : tf:=round(21/40*tc+7.5);
        4 : tf:=round((schmelz-siede)/100*tc+siede);
      end;
      edit6.text:=inttostr(tf);
      tk:=273+tc;
      edit7.text:=inttostr(tk);
    end;
    if (sender=edit6) then
    begin
      tf:=intein(edit6);
      case combobox1.itemindex of
        0 : begin
              if tf<-30 then tf:=-30;
              if tf>212 then tf:=212;
              tc:=round(5/9*(tf-32));
            end;
        1 : begin
              if tf<-24 then tf:=-24;
              if tf>80 then tf:=80;
              tc:=round(10/8*tf);
            end;
        2 : begin
              if tf<0 then tf:=0;
              if tf>195 then tf:=195;
              tc:=round(100-tf/1.5);
            end;
        3 : begin
              if tf<-8 then tf:=-8;
              if tf>60 then tf:=60;
              tc:=round(40/21*(tf-7.5));
            end;
        4 : begin
              if tf<round((schmelz-siede)/100*(-32)+siede) then
                 tf:=round((schmelz-siede)/100*(-32)+siede);
              if tf>schmelz then tf:=schmelz;
              tc:=round(100/(schmelz-siede)*(tf-siede));
            end;
      end;
      edit5.text:=inttostr(tc);
      tk:=273+tc;
      edit7.text:=inttostr(tk);
    end;
    if (sender=edit7) then
    begin
      tk:=intein(edit7);
      if tk<243 then tk:=243;
      if tk>373 then tk:=373;
      tc:=tk-273;
      edit5.text:=inttostr(tc);
      case combobox1.itemindex of
        0 : tf:=round(9*tc/5+32);
        1 : tf:=round(0.8*tc);
        2 : tf:=round(1.5*(100-tc));
        3 : tf:=round(21/40*tc+7.5);
        4 : tf:=round((schmelz-siede)/100*tc+siede);
      end;
      edit6.text:=inttostr(tf);
    end;
    paintboxpaint(sender);
    nichtschalten:=false;
end;

procedure Ttthermo.Combobox1Change(Sender: TObject);
begin
    if nichtschalten then exit;
    nichtschalten:=true;
    case combobox1.itemindex of
     0 : begin
           updown2.min:=-30;
           updown2.max:=212;
           tf:=round(9*tc/5+32);
           updown2.position:=tf
         end;
     1 : begin
           updown2.min:=-24;
           updown2.max:=80;
           tf:=round(0.8*tc);
           updown2.position:=tf
         end;
     2 : begin
           updown2.min:=0;
           updown2.max:=195;
           tf:=round(1.5*(100-tc));
           updown2.position:=tf
         end;
     3 : begin
           updown2.min:=-8;
           updown2.max:=60;
           tf:=round(21/40*tc+7.5);
           updown2.position:=tf
         end;
     4 : begin
           updown2.min:=round((schmelz-siede)/100*(-32)+siede);
           updown2.max:=schmelz;
           tf:=round((schmelz-siede)/100*tc+siede);
           updown2.position:=tf
         end;
     end;
     paintboxpaint(sender);
end;

procedure Ttthermo.FormActivate(Sender: TObject);
begin
    combobox1.itemindex:=0;
    tc:=30;
    tf:=86;
    tk:=303;
    nichtschalten:=false;
end;

procedure Ttthermo.CheckBox1Click(Sender: TObject);
begin
    if checkbox1.checked then
    begin
      name:=edit3.text;
      abkuerzung:=edit4.text;
      schmelz:=intein(edit1);
      if schmelz<-32000 then schmelz:=-32000;
      if schmelz>32000 then schmelz:=32000;
      edit1.text:=inttostr(schmelz);
      siede:=intein(edit2);
      if siede<-32000 then siede:=-32000;
      if siede>32000 then siede:=32000;
      edit2.text:=inttostr(siede);

      if siede=schmelz then
      begin
        showmessage('Siede- und Schmelztemperatur müssen verschieden sein');
        exit;
      end;
      updown2.min:=round((schmelz-siede)/100*(-32)+siede);
      updown2.max:=schmelz;
      if combobox1.items.count=4 then combobox1.items.add(name)
                                 else combobox1.items[4]:=name;
    end
    else
    begin
      combobox1.itemindex:=0;
      if combobox1.items.count=5 then combobox1.items.delete(4);
      taenderung(sender);
    end;
end;

end.
