program pstegano;

uses
  Forms,
  ustegano in 'ustegano.pas' {FStegano};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Steganografie';
  Application.CreateForm(TFStegano, FStegano);
  Application.Run;
end.
