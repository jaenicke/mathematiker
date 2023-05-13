program pwahl;

uses
  Forms,
  uwahl in 'uwahl.pas' {Fwahl};

{$R *.RES}
{$R wahl.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Wahlergebnisse';
  Application.CreateForm(TFwahl, Fwahl);
  Application.Run;
end.
