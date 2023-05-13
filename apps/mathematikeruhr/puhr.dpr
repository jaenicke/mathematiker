program puhr;

uses
  Forms,
  uuhr in 'uuhr.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Mathematiker-Uhr';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
