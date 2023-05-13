program ptrireg;

uses
  Forms,
  utrireg in 'utrireg.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Trigonometrische Regression';
  Application.CreateForm(TForm1, Form1);
  //  Application.CreateForm(TFGraph, FGraph);
  Application.Run;
end.
