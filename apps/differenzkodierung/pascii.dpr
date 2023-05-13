program pascii;

uses
  Forms,
  uascii in 'uascii.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Gartenzaunkodierung';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
