program polyeder;

uses
  Forms,
  main in 'main.pas' {Mform},
  glex in 'glex.pas';

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Polyederbibliothek';
  Application.CreateForm(TmForm, mForm);
  Application.Run;
end.
