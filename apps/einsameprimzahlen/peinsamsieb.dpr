program peinsamsieb;

uses
  Forms,
  ueinsamsieb in 'ueinsamsieb.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Primzahlvierlinge';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
