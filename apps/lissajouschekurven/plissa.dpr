program plissa;

uses
  Forms,
  ulissa in 'ulissa.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Lissajousche Figuren';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
