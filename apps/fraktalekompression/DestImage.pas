unit DestImage;

interface

uses
  MonoImage, ImageRegion, ExtCtrls, Graphics;

type
  TDestinationImage = class(TMonochromeImage)
    private
      mDestRegions: PImageRegionArray;
      mMaxSize: integer;
      procedure AdjustImageSize(pRegionSize: integer);
    public
      procedure PrepareDestinationRegions(pRegionSize: integer);
      function NumberOfDestRegions: integer;
      function GetDestRegion(pI: integer): TImageRegion;
      procedure PaintImage(pImage: TImage);
      property MaxSize: integer read mMaxSize;
      constructor Create(pImage: TImage);
      constructor CreateGray(pWidth, pHeight: integer);
      destructor Destroy; override;
  end;

implementation

constructor TDestinationImage.Create(pImage: TImage);
var
  x, y, red, green, blue, pixel, mask: integer;
begin
  inherited Create;
  mMaxSize := 256;
  mWidth := pImage.Picture.Width;
  mHeight := pImage.Picture.Height;
  GetMem(mPixels, mWidth*mHeight*SizeOf(byte));
  mDestRegions := nil;
  mask := $000000FF;

  for x := 0 to (mWidth - 1) do
  begin
    for y := 0 to (mHeight - 1) do
    begin
      pixel := pImage.Canvas.Pixels[x, y];
      red := (pixel shr 16) and mask;
      green := (pixel shr 8) and mask;
      blue := pixel and mask;
      mPixels^[x + mWidth*y] := byte((red + green + blue) div 3);
    end;
  end;

end;

constructor TDestinationImage.CreateGray(pWidth, pHeight: integer);
var
  x, y: integer;
begin
  inherited Create;
  mMaxSize := 256;
  mWidth := pWidth;
  mHeight := pHeight;
  GetMem(mPixels, mWidth*mHeight*SizeOf(byte));
  mDestRegions := nil;

  for x := 0 to mWidth - 1 do
    for y := 0 to mHeight - 1 do
      mPixels^[x + y*mWidth] := byte(127);
end;

destructor TDestinationImage.Destroy;
var
  i: integer;
begin
  FreeMem(mPixels);
  if not (mDestRegions = nil) then
  begin
    for i := 0 to NumberOfDestRegions - 1 do mDestRegions^[i].Free;
    FreeMem(mDestRegions);
  end;
  inherited;
end;

procedure TDestinationImage.AdjustImageSize(pRegionSize: integer);
var
  newPixels: PByteArray;
  newWidth, newHeight, x, y, newSize: integer;
begin
   newWidth := mWidth;
   while (((newWidth mod pRegionSize) <> 0) or ((newWidth mod 2) <> 0)) do Dec(newWidth);
   newHeight := mHeight;
   while (((newHeight mod pRegionSize) <> 0) or ((newHeight mod 2) <> 0)) do Dec(newHeight);

   if (newWidth <> mWidth) or (newHeight <> mHeight) then
   begin
     newSize := newWidth*newHeight*SizeOf(byte);
     GetMem(newPixels, newSize);
     for x := 0 to newWidth - 1 do
       for y := 0 to newHeight - 1 do
        	newPixels^[x + newWidth*y] := mPixels^[x + mWidth*y];
     FreeMem(mPixels);
     mPixels := newPixels;
     mWidth := newWidth;
     mHeight := newHeight;
   end;
end;

procedure TDestinationImage.PrepareDestinationRegions(pRegionSize: integer);
var
  numRegions, x, y, i: integer;
begin
   AdjustImageSize(pRegionSize);
   mXRegions := mWidth div pRegionSize;
   mYRegions := mHeight div pRegionSize;
   numRegions := mXRegions*mYRegions;
   GetMem(mDestRegions, numRegions*SizeOf(TImageRegion));
   i := 0;
   y := 0;
   while(y < mHeight) do
   begin
     x := 0;
     while(x < mWidth) do
     begin
       mDestRegions^[i] := TImageRegion.Create(x, y, pRegionSize, Self);
       x := x + pRegionSize;
       Inc(i);
     end;
     y := y + pRegionSize;
   end;
end;

function TDestinationImage.NumberOfDestRegions: integer;
begin
  NumberOfDestRegions := mXRegions*mYRegions;
end;

function TDestinationImage.GetDestRegion(pI: integer): TImageRegion;
begin
  GetDestRegion := mDestRegions^[pI];
end;

procedure TDestinationImage.PaintImage(pImage: TImage);
var
  x, y, pixel: integer;
begin
  pImage.Visible := False;
  for x := 0 to mWidth - 1 do
    for y := 0 to mHeight - 1 do
    begin
      pixel := mPixels^[x + mWidth*y];
      pImage.Canvas.Pixels[x, y] := (pixel shl 16) + (pixel shl 8) + pixel;
    end;
  pImage.Visible := True;
end;

end.
