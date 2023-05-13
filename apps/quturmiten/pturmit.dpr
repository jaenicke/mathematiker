program pturmit;

uses
  Forms,
  uturmit in 'uturmit.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Langton''s Ameisen';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
