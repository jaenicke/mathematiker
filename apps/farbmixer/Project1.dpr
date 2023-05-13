program Project1;
uses
  Forms,
  Unit1 in 'Unit1.pas' {frmColor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmColor, frmColor);
  Application.Run;
end.
