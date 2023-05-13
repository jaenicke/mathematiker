program pbahn;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses {$IFnDEF FPC} {$ELSE}
  Interfaces, {$ENDIF}
  Forms,
  ubahn in 'ubahn.pas' {form1},
  xastro in 'XAstro.pas';

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Sonnensystem';
  Application.CreateForm(Tform1, form1);
  Application.Run;
end.
