program pimplizit;

uses
  Forms,
  uimplizit in 'uimplizit.pas' {Fimpkurv};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Implizite Kurven';
  Application.CreateForm(TFimpkurv, Fimpkurv);
  Application.Run;
end.
