program pHanoi;

uses
  Forms,
  hanoi in 'hanoi.pas' {fhano};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Turm von Hanoi';
  Application.CreateForm(Tfhano, fhano);
  Application.Run;
end.
