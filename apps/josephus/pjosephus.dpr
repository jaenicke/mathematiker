program pjosephus;

uses
  Forms,
  ujosephus in 'ujosephus.pas' {Fjosephus};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Josephus-Problem';
  Application.CreateForm(TFjosephus, Fjosephus);
  Application.Run;
end.
