program pgo;

uses
  Forms,
  uGo3 in 'uGo3.pas' {fgo};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Go';
  Application.CreateForm(Tfgo, fgo);
  Application.Run;
end.
