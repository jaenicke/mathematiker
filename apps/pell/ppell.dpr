program ppell;

uses
  Forms,
  upellform in 'upellform.pas' {Form1},
  UPell in 'UPell.pas',
  UBigIntsV2 in 'UBigIntsV2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Pellsche Gleichung';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
