program pmerkur;

uses
  Forms,
  umerkur in 'umerkur.pas' {Form1};

{$R *.res}
{$R sonne.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Periheldrehung';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
