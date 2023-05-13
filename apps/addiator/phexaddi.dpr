program phexaddi;

uses
  Forms,
  uhexaddi in 'uhexaddi.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Addiator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
