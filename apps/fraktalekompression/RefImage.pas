unit RefImage;

interface

uses
  MonoImage, DestImage, ImageRegion;

type
  TReferenceImage = class(TMonochromeImage)
    private
      mRefRegions: PImageRegionArray;
    public
      procedure PrepareRefRegions(pRegionSize: integer);
      function NumberOfRefRegions: integer;
      function GetRefRegion(pI: integer): TImageRegion;
      constructor Create(pDestImage: TDestinationImage; pGamma: double);
      destructor Destroy; override;
  end;

implementation

constructor TReferenceImage.Create(pDestImage: TDestinationImage; pGamma: double);
var
  val, xx, yy, x, y: integer;
begin
  mWidth := pDestImage.Width div 2;
  mHeight := pDestImage.Height div 2;
  GetMem(mPixels, mWidth*mHeight*SizeOf(byte));
  mRefRegions := nil;

  for x := 0 to mWidth - 1 do
    for y := 0 to mHeight - 1 do
    begin
      xx := 2*x; yy := 2*y;
      val := pDestImage.getPixel(xx, yy) + pDestImage.getPixel(xx + 1, yy) +
						pDestImage.getPixel(xx, yy + 1) + pDestImage.getPixel(xx + 1, yy + 1);
      mPixels^[x + mWidth*y] := byte(Trunc(((val*pGamma/4) + 0.49)));
    end;
end;

destructor TReferenceImage.Destroy;
var
  i: integer;
begin
  FreeMem(mPixels);
  if not (mRefRegions = nil) then
  begin
    for i := 0 to NumberOfRefRegions - 1 do mRefRegions^[i].Free;
    FreeMem(mRefRegions);
  end;
  inherited;
end;

procedure TReferenceImage.PrepareRefRegions(pRegionSize: integer);
var
  numRegions, i, x, y: integer;
begin
    mXRegions := mWidth - (pRegionSize - 1);
    mYRegions := mHeight - (pRegionSize - 1);
    numRegions := mXRegions*mYRegions;
    GetMem(mRefRegions, numRegions*SizeOf(TImageRegion));
    i := 0;
    for y := 0 to mYRegions - 1 do
    for x := 0 to mXRegions - 1 do
    begin
      mRefRegions^[i] := TImageRegion.Create(x, y, pRegionSize, Self);
      Inc(i);
    end;
end;

function TReferenceImage.NumberOfRefRegions: integer;
begin
  NumberOfRefRegions := mXRegions*mYRegions;
end;

function TReferenceImage.GetRefRegion(pI: integer): TImageRegion;
begin
  GetRefRegion := mRefRegions^[pI];
end;

end.
