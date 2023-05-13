unit Decomp;

interface

uses FractalObject, DestImage, FIM;

type
  TFractalDecompressor = class(TFractalObject)
    public
      procedure GetNextImage(pImageModel: TFractalImageModel; pDestImage: TDestinationImage;
                                            pRegionSize: integer);
  end;

implementation

uses RefImage, ImageRegion, FractalCode, SForm;

procedure TFractalDecompressor.GetNextImage(pImageModel: TFractalImageModel;
                                            pDestImage: TDestinationImage;
                                            pRegionSize: integer);
var
  refImage: TReferenceImage;
  totalDestRegions, x, y, i, val: integer;
  destRegion, refRegion: TImageRegion;
  scaler: double;
  fractalCode: TFractalCode;
  SForm: TSForm;
begin
    refImage := TReferenceImage.Create(pDestImage, 0.75);
    refImage.prepareRefRegions(pRegionSize);
    totalDestRegions := pDestImage.NumberOfDestRegions;
    scaler := (1.0*pRegionSize)/pImageModel.RegionSize;
    for i := 0 to totalDestRegions - 1 do
    begin
      destRegion := pDestImage.getDestRegion(i);
      fractalCode := pImageModel.getFractalCode(i);
      x := Trunc(scaler*fractalCode.X + 0.49);
      y := Trunc(scaler*fractalCode.Y + 0.49);
      if (x >= refImage.XRegions) then x := refImage.XRegions - 1;
      if (y >= refImage.YRegions) then y := refImage.YRegions - 1;
      refRegion := refImage.getRefRegion(x + y*refImage.XRegions);
      sForm := fractalCode.GetSForm;
      sForm.prepare(pRegionSize);
      for x := 0 to pRegionSize - 1 do
      	for y := 0 to pRegionSize - 1 do
        begin
	  val := (sForm.getTransformedPixel(x, y, refRegion)
	  																 + fractalCode.Beta);
	  if (val < 0) then
            destRegion.setPixel(x, y, byte(0))
	  else
            if (val > 255) then
              destRegion.setPixel(x, y, byte($FF))
	    else
              destRegion.setPixel(x, y, byte(val));
        end;
      end;
      refImage.Free;
end;

end.
