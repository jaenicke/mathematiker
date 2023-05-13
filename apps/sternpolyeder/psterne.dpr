program psterne;

uses
  Forms,
  usterne in 'usterne.pas' {Fpoly};

{$R *.res}
{$R xkugel.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Sternpolyeder';
  Application.CreateForm(TFPoly, FPoly);
  Application.Run;
end.
