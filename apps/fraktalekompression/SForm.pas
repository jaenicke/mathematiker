unit SForm;

interface

uses
  FractalObject, ImageRegion;

type
  TIntegerArray = array[0..255] of integer;
  PIntegerArray = ^TIntegerArray;

  TSForm = class(TFractalObject)
    private
      mA: integer;
      mB: integer;
      mC: integer;
      mD: integer;
      mRegionSize: integer;
      mPrepared: boolean;
      mXCoords: PIntegerArray;
      mYCoords: PIntegerArray;
    public
      property A: integer read mA;
      property B: integer read mB;
      property C: integer read mC;
      property D: integer read mD;
      procedure Prepare(pRegionSize: integer);
      function GetTransformedPixel(pX, pY: integer; pRegion: TImageRegion): byte;
      constructor Create(pA, pB, pC, pD: integer);
      destructor Destroy; override;
  end;

  TSFormArray = array[0..1048576] of TSForm;
  PSFormArray = ^TSFormArray;

implementation

constructor TSForm.Create(pA, pB, pC, pD: integer);
begin
  inherited Create;
  mA := pA;
  mB := pB;
  mC := pC;
  mD := pD;
  mXCoords := nil;
  mYCoords := nil;
  mPrepared := False;
end;

destructor TSForm.Destroy;
begin
  if not (mXCoords = nil) then
    FreeMem(mXCoords);
  if not (mYCoords = nil) then
    FreeMem(mYCoords);
  inherited;
end;

function TSForm.GetTransformedPixel(pX, pY: integer; pRegion: TImageRegion): byte;
var
  i: integer;
begin
  i := pX + mRegionSize*pY;
  GetTransformedPixel := pRegion.GetPixel(mXCoords^[i], mYCoords^[i]);
end;

procedure TSForm.Prepare(pRegionSize: integer);
var
  x, y, index: integer;
begin
  if (mPrepared and (pRegionSize = mRegionSize)) then Exit;
  if (mPrepared and (pRegionSize <> mRegionSize)) then
  begin
    FreeMem(mXCoords);
    FreeMem(mYCoords);
  end;
  GetMem(mXCoords, pRegionSize*pRegionSize*SizeOf(integer));
  GetMem(mYCoords, pRegionSize*pRegionSize*SizeOf(integer));
  mRegionSize := pRegionSize;

  for x := 0 to pRegionSize - 1 do
    for y := 0 to pRegionSize - 1 do
    begin
      index := x + y*pRegionSize;
				if mA = 1 then
					mXCoords^[index] := x
				else if (mA = -1) then
					mXCoords^[index] := pRegionSize - 1 - x;

				if (mB = 1) then
					mXCoords^[index] := y
				else if (mB = -1) then
					mXCoords^[index] := pRegionSize - 1 - y;

				if (mC = 1) then
					mYCoords^[index] := x
				else if (mC = -1) then
					mYCoords^[index] := pRegionSize - 1 - x;

				if (mD = 1) then
					mYCoords^[index] := y
				else if (mD = -1) then
					mYCoords^[index] := pRegionSize - 1 - y;
			end;
		mPrepared := true;
end;

end.
