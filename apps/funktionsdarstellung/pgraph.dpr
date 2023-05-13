program pgraph;

uses
  Forms,
  graf in 'graf.pas' {FGraf},
  fktint in 'fktint.pas';

{$R *.RES}
{$R windowsxp.RES}
{$R xverein.RES}

begin
  Application.Initialize;
  Application.Title := 'Funktionsdarstellung';
  Application.CreateForm(TFGraf, FGraf);
  Application.Run;
end.
