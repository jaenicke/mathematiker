unit Checker;

interface

uses
  Classes, MainForm;

type
  TChecker = class(TThread)
  private
    { Private declarations }
    mMainForm: TfrmMainForm;
    mPercentString: string;
    mTimeString: string;
    procedure UpdateDisplay;
    procedure SaveTheFIM;
  protected
    procedure Execute; override;
  public
    constructor Create(frmMain: TfrmMainForm);
  end;

implementation

uses Comp, SysUtils, Math, FIM, Windows;

constructor TChecker.Create(frmMain: TfrmMainForm);
begin
  inherited Create(false);
  mMainForm := frmMain;
  Priority := tpLowest;
  FreeOnTerminate := True;
end;

procedure TChecker.Execute;
var
  percentDone, elapsedTime, projectedTime: double;
  startTime, nowTime: TDateTime;
  minutes, seconds: integer;
begin
    startTime := Now;
    repeat
      Sleep(200);
      if Terminated then Exit;
      percentDone := mMainForm.Compressor.PercentDone;
      mPercentString := 'Prozentualer Fortschritt: ' + FloatToStrF(percentDone, ffGeneral, 4, 4);
      if(percentDone <> 0.0) then
      begin
	nowTime := Now;
	elapsedTime := (nowTime - startTime)*24*60;  // in minutes
	projectedTime := ((100/percentDone - 1)*elapsedTime);
	minutes := Floor(projectedTime);
	seconds := Floor((projectedTime - minutes)*60);
        mTimeString := 'Zeitbedarf: ' + IntToStr(minutes) + ' min ' + IntToStr(seconds) + ' s';
        Synchronize(UpdateDisplay);
      end;
    until (not mMainForm.Compressor.compressorRunning);
    Synchronize(SaveTheFIM);
end;

procedure TChecker.UpdateDisplay;
begin
  mMainForm.l3.Caption := mPercentString;
  mMainForm.lblTimeLeft.Caption := mTimeString;
end;

procedure TChecker.SaveTheFIM;
begin
  mMainForm.SaveDialog1.initialdir:=verzeichnis;
  mMainForm.SaveDialog1.Title := 'Fraktal-Bild speichern:';
  if mMainForm.savedialog1.execute then
  begin
  mMainForm.Compressor.FractalImageModel.SaveToFile(mMainForm.SaveDialog1.Filename);
  end;
  mMainForm.d3.enabled:=false;
  mMainForm.d2.enabled:=false;
end;

end.
