program popt1;

uses
  Forms,
  uopt1 in 'uopt1.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Optische T�uschungen';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
