program pplasma;

uses
  Forms,
  uplasma in 'uplasma.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}
{$R farben.RES}

begin
  Application.Initialize;
  Application.Title := 'Plasma';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
