program pchiffre;

uses
  Forms,
  uchiffre in 'uchiffre.pas' {fchiffre};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Zahlenrätsel "Des chiffres et des lettres"';
  Application.CreateForm(Tfchiffre, fchiffre);
  Application.Run;
end.
