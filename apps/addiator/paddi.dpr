program paddi;

uses
  Forms,
  uaddi in 'uaddi.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Addiator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
