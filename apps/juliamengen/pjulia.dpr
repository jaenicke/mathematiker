program pjulia;

uses
  Forms,
  ujulia in 'ujulia.pas' {Fjulia};

{$R *.RES}
{$R julia.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Julia-Mengen';
  Application.CreateForm(TFjulia, Fjulia);
  Application.Run;
end.
