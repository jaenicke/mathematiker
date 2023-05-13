program pvexed;

uses
  Forms,
  Uvexed in 'Uvexed.pas' {vexed};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Vexed-Puzzle';
  Application.CreateForm(Tvexed, vexed);
  Application.Run;
end.
