program pevolvente;

uses
  Forms,
  uevolvente in 'uevolvente.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kreisevolvente';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
