unit Unit1;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface
uses SysUtils, Classes, Graphics, Controls, Forms, Buttons, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmColor = class(TForm)
    panUnten: TPanel;
    sbRot: TScrollBar;
    sbGruen: TScrollBar;
    sbBlau: TScrollBar;
    lblRGB: TLabel;
    panBig: TPanel;
    procedure MixColor(Sender:TObject);
  private
    Rot: integer;
    Gruen: integer;
    Blau: integer;
    ActiveColor: TColor;
  end;

var frmColor: TfrmColor;

implementation
{$R *.DFM}

procedure TfrmColor.MixColor(Sender: TObject);
begin
  Rot := sbRot.Position;
  Gruen := sbGruen.Position;
  Blau := sbBlau.Position;
  // panBig.Color := 65536*Blau + 256*Gruen + Rot;
  panBig.Color := Blau SHL 16 + Gruen SHL 8 + Rot;
  lblRGB.Caption := 'R:' + IntToStr(Rot) + '   G:' + IntToStr(Gruen) + '   B:' + IntToStr(Blau)+
    ' ; '+inttohex(panbig.color,6);
end;

end.

