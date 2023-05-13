program pkendoku;

uses
  Forms,
  Ukendoku in 'Ukendoku.pas' {fkendo};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kendoku';
  Application.CreateForm(Tfkendo, fkendo);
  Application.Run;
end.
