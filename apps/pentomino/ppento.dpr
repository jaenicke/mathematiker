program ppento;

uses
  Forms,
  pentomino in 'pentomino.pas' {pentoform},
  xzusatzbild2 in 'xzusatzbild2.pas' {zusatzbild2};

{$R *.RES}
{$R xpento.RES}
{$R xpento2.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Pentomino';
  Application.CreateForm(Tpentoform, pentoform);
  Application.Run;
end.
