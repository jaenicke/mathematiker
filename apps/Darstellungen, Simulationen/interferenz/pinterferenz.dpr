program pinterferenz;

uses
  Forms,
  uinterferenz in 'uinterferenz.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Interferenz von Wellen';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
