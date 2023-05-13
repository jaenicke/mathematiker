program pviskrypt;

uses
  Forms,
  uviskrypt in 'uviskrypt.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Phasenplot';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
