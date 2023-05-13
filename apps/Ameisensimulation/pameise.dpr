program pameise;

uses
  Forms,
  uameise in 'uameise.pas' {Form1};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Ameisensimulation';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
