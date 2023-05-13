program pkepler;

uses
  Forms,
  ukepler in 'ukepler.pas' {Form1};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Keplersche Gesetze';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
