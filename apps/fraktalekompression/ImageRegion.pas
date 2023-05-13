unit ImageRegion;

interface

uses
  FractalObject, MonoImage;

type
  TImageRegion = class(TFractalObject)
    private
      mX: integer;
      mY: integer;
      mMean: integer;
      mRegionSize: integer;
      mPixels: PByteArray;
      mPixelsWidth: integer;
    public
      property X: integer read mX;
      property Y: integer read mY;
      property Mean: integer read mMean;
      property RegionSize: integer read mRegionSize;
      procedure SetPixel(pX, pY: integer; pValue: byte);
      function GetPixel(pX, pY: integer): byte;
      constructor Create(pX, pY, pRegionSize: integer; pImage: TMonochromeImage);
  end;

  TImageRegionArray = array[0..2097152] of TImageRegion;
  PImageRegionArray = ^TImageRegionArray;


implementation

uses Math;

constructor TImageRegion.Create(pX, pY, pRegionSize: integer; pImage: TMonochromeImage);
var
  x, y: integer;
begin
  inherited Create;
  mX := pX;
  mY := pY;
  mRegionSize := pRegionSize;
  mPixels := pImage.GetPixels;
  mPixelsWidth := pImage.Width;

  mMean := 0;
  for x := 0 to mRegionSize - 1 do
    for y := 0 to mRegionSize - 1 do
      mMean := mMean + mPixels^[(pX + x) + mPixelsWidth*(pY + y)];
  mMean := Floor(mMean/(mRegionSize*mRegionSize) + 0.49);

end;

procedure TImageRegion.SetPixel(pX, pY: integer; pValue: byte);
begin
  mPixels^[(pX + mX) + mPixelsWidth*(pY + mY)] := pValue;
end;

function TImageRegion.GetPixel(pX, pY: integer): byte;
begin
  GetPixel := mPixels^[(pX + mX) + mPixelsWidth*(pY + mY)];
end;

end.
