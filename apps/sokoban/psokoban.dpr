program psokoban;

uses
  Forms,
  usokoban in 'usokoban.pas'; {fsokoban}

{$R *.res}
{$R xsoko.res}

begin
  Application.Initialize;
  Application.Title := 'Sokoban';
  Application.CreateForm(Tfsokoban, fsokoban);
  Application.Run;
end.
