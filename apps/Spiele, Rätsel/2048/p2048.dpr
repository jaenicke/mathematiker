program p2048;

uses
  Forms,
  u2048 in 'u2048.pas' {f2048};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Spiel 2048';
  Application.CreateForm(Tf2048, f2048);
  Application.Run;
end.
