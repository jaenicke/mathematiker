program Str8ts;

uses
  Forms,
  ustraights in 'ustraights.pas' {fstraights};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Str8ts';
  Application.CreateForm(Tfstraights, fstraights);
  Application.Run;
end.
