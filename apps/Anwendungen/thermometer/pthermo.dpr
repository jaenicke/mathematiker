program pthermo;

uses
  Forms,
  uthermo in 'uthermo.pas' {tthermo};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Temperaturumrechnung';
  Application.CreateForm(Ttthermo, tthermo);
  Application.Run;
end.
