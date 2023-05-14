program plichtaus;

uses
  Forms,
  ulichtaus in 'ulichtaus.pas' {FLichtaus};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Licht aus';
  Application.CreateForm(TFLichtaus, FLichtaus);
  Application.Run;
end.
