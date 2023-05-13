program priemann;

uses
  Forms,
  uriemann in 'uriemann.pas' {Form1},
  complexm in 'complexm.PAS';

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Riemannsche Zeta-Funktion';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
