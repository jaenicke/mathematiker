program pkrypto;

uses
  Forms,
  ukrypto in 'ukrypto.pas' {form10k};

{$R *.RES}
{$R zraetsel.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Kryptogramm';
  Application.CreateForm(Tform10k, form10k);
  Application.Run;
end.
