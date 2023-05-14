program pnullstellen;

uses
  Forms,
  unullstellen in 'unullstellen.pas' {Form1};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Nullstellen ganzrationaler Gleichungen';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
