program pdreipyr;

uses
  Forms,
  udreipyr in 'udreipyr.pas' {Form1},
  beste in 'beste.pas' {Bestenliste};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Drei Pyramiden';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TBestenliste, Bestenliste);
  Application.Run;
end.
