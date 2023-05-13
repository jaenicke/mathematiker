program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Cluster};

{$R *.res}
{$R windowsxp.res}

begin
  Application.Initialize;
  Application.Title := 'Clusterbildung';
  Application.CreateForm(TCluster, Cluster);
  Application.Run;
end.
