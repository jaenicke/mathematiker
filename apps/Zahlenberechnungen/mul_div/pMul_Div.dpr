program pMul_Div;

uses
  Forms,
  ualgebra in 'ualgebra.pas' {Falgebra};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFalgebra, Falgebra);
  Application.Run;
end.
