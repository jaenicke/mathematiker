program pdpendel;

uses
  Forms,
  udpendel in 'udpendel.pas' {Form1};

{$R *.RES}
{$R doppelp.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Chaos-Doppelpendel';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
