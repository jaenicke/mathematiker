program pkette;

uses
  Forms,
  ukette in 'ukette.pas' {nkette};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kettenreaktion';
  Application.CreateForm(Tnkette, nkette);
  Application.Run;
end.
