program pwythoff;

uses
  Forms,
  uwythoff in 'uwythoff.pas' {frmwythoff};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Wythoff-Spiel';
  Application.CreateForm(Tfrmwythoff, frmwythoff);
  Application.Run;
end.
