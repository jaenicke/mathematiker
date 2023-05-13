program prstab;

uses
  Forms,
  urstab in 'urstab.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Rechenstab';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
