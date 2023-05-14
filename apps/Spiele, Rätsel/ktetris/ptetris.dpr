program ptetris;

uses
  Forms,
  utetris in 'utetris.pas' {GBoard};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Tetris';
  Application.CreateForm(TGBoard, GBoard);
  Application.Run;
end.
