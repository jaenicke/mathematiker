program Dreieck;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}
{$R windowsxp.res}
{$R tfont.res}

begin
  Application.title:='Rechtwinkliges Dreieck';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
