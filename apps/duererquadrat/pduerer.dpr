program pduerer;

uses
  Forms,
  duerer in 'duerer.pas' {Fduerer};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Dürers magisches Quadrat';
  Application.CreateForm(TFduerer, Fduerer);
  Application.Run;
end.
