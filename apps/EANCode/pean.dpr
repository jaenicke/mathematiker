program pean;

uses
  Forms,
  uean in 'uean.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'EAN-Code';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
