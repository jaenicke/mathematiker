program parbeit;

uses
  Forms,
  uarbeit in 'uarbeit.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Arbeitstageanzahl';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
