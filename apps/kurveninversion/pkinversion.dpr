program pkinversion;

uses
  Forms,
  ukinversion in 'ukinversion.pas' {Form1},
  ugraph in 'ugraph.pas' {FGraph};

{$R *.RES}
{$R inversion.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kurveninversion';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFGraph, FGraph);
  Application.Run;
end.
