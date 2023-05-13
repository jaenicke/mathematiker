program pinkugel;

uses
  Forms,
  uinkugel in 'uinkugel.pas' {FInkugel};

{$R *.res}
{$R xkugel.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Polyederkugeln';
  Application.CreateForm(TFInkugel, FInkugel);
  Application.Run;
end.
