program phalbleiter;

uses
  Forms,
  Uhalbleiter in 'Uhalbleiter.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Halbleiterleitung';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
