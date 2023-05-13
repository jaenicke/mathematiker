program pschickard;

uses
  Forms,
  Uschickard in 'Uschickard.pas' {fschickard};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Schickardsche Rechenmaschine';
  Application.CreateForm(Tfschickard, fschickard);
  Application.Run;
end.
