program pdualpuzzle;

uses
  Forms,
  udualpuzzle in 'udualpuzzle.pas' {fdualpuzzle};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfdualpuzzle, fdualpuzzle);
  Application.Run;
end.
