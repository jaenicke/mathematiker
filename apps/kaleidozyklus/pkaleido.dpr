program pkaleido;

uses
  Forms,
  ukaleido in 'ukaleido.pas' {fkaleido};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfkaleido, fkaleido);
  Application.Run;
end.
