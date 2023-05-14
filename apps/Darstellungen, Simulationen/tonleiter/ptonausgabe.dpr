program ptonausgabe;

uses
  Forms,
  utonausgabe in 'utonausgabe.pas' {FMus};

{$R *.res}
{$R melodie2.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Tonausgabe';
  Application.CreateForm(TFMus, FMus);
  Application.Run;
end.
