program pflow;

uses
  Forms,
  uflow2 in 'uflow2.pas' {fhaky};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Flowfree';
  Application.CreateForm(Tfflow, fflow);
  Application.Run;
end.
