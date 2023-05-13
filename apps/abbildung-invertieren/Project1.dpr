program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmNegative};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmNegative, frmNegative);
  Application.Run;
end.
