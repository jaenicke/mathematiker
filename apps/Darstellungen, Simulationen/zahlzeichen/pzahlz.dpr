program pzahlz;

uses
  Forms,
  zahlzeich in 'zahlzeich.pas' {zahlz};

{$R *.RES}
{$R agrie.RES}
{$R hiera.res}
{$R xfont2.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Zahlzeichen';
  Application.CreateForm(Tzahlz, zahlz);
  Application.Run;
end.
