program psprunglabyrinth;

uses
  Forms,
  usprunglab in 'usprunglab.pas' {Fsprung};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sprunglabyrinth';
  Application.CreateForm(TFsprung, Fsprung);
  Application.Run;
end.
