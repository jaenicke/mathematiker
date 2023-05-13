program pphase;

uses
  Forms,
  uphase in 'uphase.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Phasenplot';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
