program ukopfr;

uses
  Forms,
  pkopfrechnen in 'pkopfrechnen.pas' {kopfr};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kopfrechnentest';
  Application.CreateForm(Tkopfr, kopfr);
  Application.Run;
end.
