program psortier;

uses
  Forms,
  sortier in 'sortier.pas' {fsortier};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Sortierverfahren';
  Application.CreateForm(Tfsortier, fsortier);
  Application.Run;
end.
