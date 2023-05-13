program pkugel;

uses
  Forms,
  uvier in 'uvier.pas' {fvier};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Kipplabyrinth';
  Application.CreateForm(Tfvier, fvier);
  Application.Run;
end.
