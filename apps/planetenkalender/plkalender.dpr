program plkalender;

uses
  Forms,
  uplkalender in 'uplkalender.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Planetenkalender';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
