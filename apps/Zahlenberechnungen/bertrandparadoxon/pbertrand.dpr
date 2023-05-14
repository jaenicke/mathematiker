program pbertrand;

uses
  Forms,
  ubertrand in 'ubertrand.pas' {Form1};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Bertrand-Experiment';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
