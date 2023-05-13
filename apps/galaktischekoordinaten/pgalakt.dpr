program pgalakt;

uses
  Forms,
  ugalakt in 'ugalakt.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Koordinaten der Erde';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
