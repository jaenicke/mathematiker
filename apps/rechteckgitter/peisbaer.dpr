program peisbaer;

uses
  Forms,
  uwege2 in 'uwege2.pas' {Form1};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Wege im Rechteckgitter';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
