unit CompThread;

interface

uses
  Classes, Comp;

type
  TCompThread = class(TThread)
  private
    { Private declarations }
    mCompressor: TFractalCompressor;
  protected
    procedure Execute; override;
  public
    constructor Create(pCompressor: TFractalCompressor);
  end;

implementation

constructor TCompThread.Create(pCompressor: TFractalCompressor);
begin
  inherited Create(false);
  mCompressor := pCompressor;
  FreeOnTerminate := true;
end;

procedure TCompThread.Execute;
begin
  { Place thread code here }
  mCompressor.Compress;
end;

end.
