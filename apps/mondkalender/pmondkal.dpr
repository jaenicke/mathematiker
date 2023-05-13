program pmondkal;

uses
  Forms,
  umondkal in 'umondkal.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Mondphasenkalender';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
