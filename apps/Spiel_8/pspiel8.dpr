program pspiel8;

uses
  Forms,
  uspiel8 in 'uspiel8.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
