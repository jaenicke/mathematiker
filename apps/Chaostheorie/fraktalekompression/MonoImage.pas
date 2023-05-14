unit MonoImage;

interface

uses
  FractalObject;

type
  TByteArray = array[0..1048576] of byte;
  PByteArray = ^TByteArray;

  TMonochromeImage = class(TFractalObject)
    protected
      mWidth: integer;
      mHeight: integer;
      mPixels: PByteArray;
      mXRegions: integer;
      mYRegions: integer;
    public
      property Width: integer read mWidth;
      property Height: integer read mHeight;
      property XRegions: integer read mXRegions;
      property YRegions: integer read mYRegions;
      function GetPixel(pX, pY: integer): byte;
//      procedure SetPixel(pX, pY: integer; pValue: byte);
      function GetPixels: PByteArray;
  end;

implementation

function TMonochromeImage.GetPixel(pX, pY: integer): byte;
begin
  GetPixel := mPixels^[pX + pY*mWidth];
end;

function TMonochromeImage.GetPixels: PByteArray;
begin
  GetPixels := mPixels;
end;

end.
