program phaky;

uses
  Forms,
  uhaky in 'uhaky.pas' {fhaky};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Hakyuu';
  Application.CreateForm(Tfhaky, fhaky);
  Application.Run;
end.
