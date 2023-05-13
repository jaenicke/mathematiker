program pkonform;

uses
  Forms,
  ukonform in 'ukonform.pas' {fsortier};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Konforme Abbildungen';
  Application.CreateForm(Tfsortier, fsortier);
  Application.Run;
end.
