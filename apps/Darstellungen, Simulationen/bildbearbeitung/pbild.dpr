program pbild;

uses
  Forms,
  ubildbearbeitung in 'ubildbearbeitung.pas' {gfilter};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Bildbearbeitung';
  Application.CreateForm(Tgfilter, gfilter);
  Application.Run;
end.
