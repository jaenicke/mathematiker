program pmondrian;

uses
  Forms,
  umondrian in 'umondrian.pas' {Form1};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Mondrian-Bilder';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
