program pmacmahon;

uses
  Forms,
  umacmahon in 'umacmahon.pas' {memory};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tmemory, memory);
  Application.Run;
end.
