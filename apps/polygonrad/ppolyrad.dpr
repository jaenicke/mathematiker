program ppolyrad;

uses
  Forms,
  upolyrad in 'upolyrad.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Polygonzykloide';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
