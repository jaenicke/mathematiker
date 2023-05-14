program pmilch;

uses
  Forms,
  umilch in 'umilch.pas' {form1};

{$R *.RES}
{$R windowsxp.RES}

begin
  Application.Initialize;
  Application.Title := 'Milchmädchenrechnung';
  Application.CreateForm(Tform1, form1);
  Application.Run;
end.
