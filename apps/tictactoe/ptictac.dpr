program ptictac;

uses
  Forms,
  Utictac in 'utictac.pas' {ftictac};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Tic-Tac-Toe';
  Application.CreateForm(Tftictac, ftictac);
  Application.Run;
end.
