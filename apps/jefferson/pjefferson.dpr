program pjefferson;

uses
  Forms,
  ujefferson in 'ujefferson.pas' {Fjefferson};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Jefferson-Walze';
  Application.CreateForm(TFjefferson, Fjefferson);
  Application.Run;
end.
