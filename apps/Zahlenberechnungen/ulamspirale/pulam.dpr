program pulam;

uses
  Forms,
  uulam in 'uulam.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Ulam-Spirale';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
