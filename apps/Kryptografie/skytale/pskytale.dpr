program pskytale;

uses
  Forms,
  uskytale in 'uskytale.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Skytale';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
