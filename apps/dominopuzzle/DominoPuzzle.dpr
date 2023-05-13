program DominoPuzzle;

uses
  Forms,
  U_DominoPuzzle in 'U_DominoPuzzle.pas' {domi};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Domino-Puzzle';
  Application.CreateForm(Tdomi, domi);
  Application.Run;
end.
