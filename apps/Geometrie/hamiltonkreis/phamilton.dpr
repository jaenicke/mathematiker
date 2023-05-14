program phamilton;

uses
  Forms,
  uhamilton in 'uhamilton.pas' {feuler};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Euler- und Hamiltonkreise';
  Application.CreateForm(Tfeuler, feuler);
  Application.Run;
end.
