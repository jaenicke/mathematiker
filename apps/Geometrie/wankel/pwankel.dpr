program pwankel;

uses
  Forms,
  uwankel in 'uwankel.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Wankelmotorscheibe';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
