program psudokubus;

uses
  Forms,
  usudokubus in 'usudokubus.pas' {schnecke2};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Sudokubus';
  Application.CreateForm(Tschnecke2, schnecke2);
  Application.Run;
end.
