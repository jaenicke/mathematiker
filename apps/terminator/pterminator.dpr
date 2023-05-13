program pterminator;

uses
  Forms,
  uterminator in 'uterminator.pas' {FTerminator};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Terminator';
  Application.CreateForm(TFTerminator, FTerminator);
  Application.Run;
end.
