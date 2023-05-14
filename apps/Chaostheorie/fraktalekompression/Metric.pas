unit Metric;

interface

uses FractalObject;

type
  TIntegerArray = array[0..High(integer) div 8] of integer;
  PIntegerArray = ^TIntegerArray;

  TMetric = class(TFractalObject)
    private
      mMetricTable: PIntegerArray;
    public
      function GetDistance(pDiff: integer): integer;
      constructor Create(pL, pMax: integer);
      destructor Destroy; override;
  end;

implementation

uses Math;

constructor TMetric.Create(pL, pMax: integer);
var
  i, top: integer;
begin
  inherited Create;
  top := (pMax + 1)*2;
  GetMem(mMetricTable, top*SizeOf(integer));
  case pL of
    1:  for i := 0 to top - 1 do mMetricTable^[i] := i;
    else
      for i := 0 to top - 1 do mMetricTable^[i] := i*i;
  end;
end;

destructor TMetric.Destroy;
begin
  FreeMem(mMetricTable);
  inherited;
end;

function TMetric.GetDistance(pDiff: integer): integer;
begin
  GetDistance := mMetricTable^[pDiff];
end;

end.
