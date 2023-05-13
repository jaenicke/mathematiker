program pellzyk;

uses
  Forms,
  uellzyk in 'uellzyk.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Ellipsenzykloide';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
