program prstab2;

uses
  Forms,
  urstab2 in 'urstab2.pas' {Frstab};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Rechenstab';
  Application.CreateForm(TFrstab, Frstab);
  Application.Run;
end.
