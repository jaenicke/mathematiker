program plsystem;

uses
  Forms,
  ulsystem in 'ulsystem.pas' {FLsystem};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'L-System';
  Application.CreateForm(TFLsystem, FLsystem);
  Application.Run;
end.
