program pparkett;

uses
  Forms,
  uparkett in 'uparkett.pas' {parkettform};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Parkettierung';
  Application.CreateForm(Tparkettform, parkettform);
  Application.Run;
end.
