program pmandel;

uses
  Forms,
  umandel in 'umandel.pas' {fmandel};

{$R *.RES}
{$R julia.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Mandelbrotmenge';
  Application.CreateForm(Tfmandel, fmandel);
  Application.Run;
end.
