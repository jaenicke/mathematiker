program pkaleido;

uses
  Forms,
  ukaleido in 'ukaleido.pas' {kaform};

{$R *.RES}
{$R kaleido.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kaleidoskop';
  Application.CreateForm(Tkaform, kaform);
  Application.Run;
end.
