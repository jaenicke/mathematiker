unit FractalCode;

interface

uses FractalObject, SFormList, ImageRegion, SForm;

type
  TFractalCode = class(TFractalObject)
    private
      mX: integer;
      mY: integer;
      mS: integer;
      mBeta: integer;
    public
      property X: integer read mX;
      property Y: integer read mY;
      property S: integer read mS;
      property Beta: integer read mBeta;
      function GetSForm: TSForm;
      constructor Create(pRefRegion: TImageRegion; pS, pBeta: integer);
      constructor CreateFromList(pX, pY, pS, pBeta: integer);
      destructor Destroy; override;
  end;

  TFractalCodeArray = array[0..1048576] of TFractalCode;
  PFractalCodeArray = ^TFractalCodeArray;

implementation

constructor TFractalCode.Create(pRefRegion: TImageRegion; pS, pBeta: integer);
begin
  inherited Create;
  mX := pRefRegion.X;
  mY := pRefRegion.Y;
  mS := pS;
  mBeta := pBeta;
end;

constructor TFractalCode.CreateFromList(pX, pY, pS, pBeta: integer);
begin
  inherited Create;
  mX := pX;
  mY := pY;
  mS := pS;
  mBeta := pBeta;
end;

destructor TFractalCode.Destroy;
begin
  inherited;
end;

function TFractalCode.GetSForm: TSForm;
begin
  if GlobalSFormList = nil then
    GlobalSFormList := TSFormList.Create;
  GetSForm := GlobalSFormList.GetSForm(mS);
end;

end.
