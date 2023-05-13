program pakari;

uses
  Forms,
  uakari in 'uakari.pas' {fakari};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Akari';
  Application.CreateForm(Tfakari, fakari);
  Application.Run;
end.
