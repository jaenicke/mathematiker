program Project1;

uses
  Forms,
  baum in 'baum.pas' {fbaum};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfbaum, fbaum);
  Application.Run;
end.
