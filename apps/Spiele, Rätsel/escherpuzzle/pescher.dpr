program pescher;

uses
  Forms,
  Uescher in 'Uescher.pas' {fescher};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Figurenpuzzle';
  Application.CreateForm(Tfescher, fescher);
  Application.Run;
end.
