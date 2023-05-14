program Pdigger;

uses
  Forms,
  digger in 'digger.pas' {fdigger};

{$R *.RES}
{$R digger}

begin
  Application.Initialize;
  Application.Title := 'Digger';
  Application.CreateForm(Tfdigger, fdigger);
  Application.Run;
end.
