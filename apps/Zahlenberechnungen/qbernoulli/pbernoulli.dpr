program pbernoulli;

uses
  Forms,
  ubernoulli in 'ubernoulli.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Bernoulli-Zahlen';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
