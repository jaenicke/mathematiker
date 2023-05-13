program pachtdamen;

uses
  Forms,
  uachtdamen in 'uachtdamen.pas' {fachtdamen};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfachtdamen, fachtdamen);
  Application.Run;
end.
