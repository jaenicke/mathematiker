program pmaya;

uses
  Forms,
  umaya in 'umaya.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}
{$R mayabit.RES}
{$R tfont.RES}

begin
  Application.Initialize;
  Application.Title := 'Maya-Kalenderrunde';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
