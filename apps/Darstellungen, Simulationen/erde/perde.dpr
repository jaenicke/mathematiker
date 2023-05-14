program perde;

uses
  Forms,
  uerde in 'uerde.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Erdkugel';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
