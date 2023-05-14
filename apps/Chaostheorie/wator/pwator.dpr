program pwator;

uses
  Forms,
  uwator in 'uwator.pas' {fwator};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Wator';
  Application.CreateForm(Tfwator, fwator);
  Application.Run;
end.
