program ppuzzle;

uses
  Forms,
  upuzzle in 'upuzzle.pas' {Formpu};

{$R *.RES}
{$R xpuzzle2.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Puzzle';
  Application.CreateForm(TFormpu, Formpu);
  Application.Run;
end.
