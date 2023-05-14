program QRGenerator;

uses
  Forms,
  qrunit in 'qrunit.pas' {qrform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'QR-Code-Generator';
  Application.CreateForm(Tqrform, qrform);
  Application.Run;
end.
