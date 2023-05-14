program pzwort;

uses
  Forms,
  uzwort in 'uzwort.pas' {Form1};

{$R *.RES}
{$R windowsxp.RES}
{$R tfont.RES}

begin
  Application.title:='Zahlwörter';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
