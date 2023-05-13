unit SFormList;

interface

uses
  SForm, FractalObject;

type
  TSFormList = class(TFractalObject)
    private
      mNumberOfSForms: integer;
      mSForms: PSFormArray;
      procedure SetDefaultSForms;
    public
      property NumberOfSForms: integer read mNumberOfSForms;
      function GetSForm(pI: integer): TSForm;
      constructor Create;
      destructor Destroy; override;
  end;

var
  GlobalSFormList: TSFormList;

implementation

constructor TSFormList.Create;
begin
  inherited Create;
  SetDefaultSForms;
end;

destructor TSFormList.Destroy;
var
  i: integer;
begin
  for i := 0 to NumberOfSForms - 1 do
    mSForms^[i].Free;
  FreeMem(mSForms);
  inherited;
end;

procedure TSFormList.SetDefaultSForms;
begin
  mNumberOfSForms := 8;
  GetMem(mSForms, mNumberOfSForms*SizeOf(TSForm));

  mSForms^[0] := TSForm.Create(1, 0, 0, 1);
  mSForms^[1] := TSForm.Create(-1, 0, 0, 1);
  mSForms^[2] := TSForm.Create(1, 0, 0, -1);
  mSForms^[3] := TSForm.Create(-1, 0, 0, -1);
  mSForms^[4] := TSForm.Create(0, 1, 1, 0);
  mSForms^[5] := TSForm.Create(0, -1, 1, 0);
  mSForms^[6] := TSForm.Create(0, 1, -1, 0);
  mSForms^[7] := TSForm.Create(0, -1, -1, 0);
end;

function TSFormList.GetSForm(pI: integer): TSForm;
begin
  GetSForm := mSForms^[pI];
end;

end.
