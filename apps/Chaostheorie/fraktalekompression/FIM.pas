unit FIM;

interface

uses FractalObject, FractalCode, zlib;

type
  TFractalImageModel = class(TFractalObject)
    private
      mXRegions: integer;
      mYRegions: integer;
      mSize: integer;
      mRegionSize: integer;
      mCodes: PFractalCodeArray;
    public
      property XRegions: integer read mXRegions;
      property YRegions: integer read mYRegions;
      property Size: integer read mSize;
      property RegionSize: integer read mRegionSize;
      function Capacity: integer;
      procedure AddFractalCode(pFractalCode: TFractalCode);
      function GetFractalCode(pI: integer): TFractalCode;
      procedure SaveToFile(pFilename: string);
      procedure LoadFromlist;
      constructor Create(pXRegions, pYRegions, pRegionSize: integer);
      constructor CreateNull;
      destructor Destroy; override;
  end;

implementation

uses Classes, SysUtils,mainform;

constructor TFractalImageModel.CreateNull;
begin
  inherited Create;
end;

constructor TFractalImageModel.Create(pXRegions, pYRegions, pRegionSize: integer);
begin
  inherited Create;
  mXRegions := pXRegions;
  mYRegions := pYRegions;
  mRegionSize := pRegionSize;
  mSize := 0;
  GetMem(mCodes, Capacity*SizeOf(TFractalCode));
end;

destructor TFractalImageModel.Destroy;
var
  i: integer;
begin
  for i := 0 to Size - 1 do
  begin
    mCodes^[i].Free;
  end;
  FreeMem(mCodes);
  inherited;
end;

function TFractalImageModel.Capacity: integer;
begin
  Capacity := mXRegions*mYRegions;
end;

procedure TFractalImageModel.AddFractalCode(pFractalCode: TFractalCode);
begin
  mCodes^[mSize] := pFractalCode;
  Inc(mSize);
end;

function TFractalImageModel.GetFractalCode(pI: integer): TFractalCode;
begin
  GetFractalCode := mCodes^[pI];
end;

procedure TFractalImageModel.SaveToFile(pFilename: string);
var
  position, sAndBeta, i: integer;
  list: TStringList;
var ms1,ms2:tmemorystream;
procedure CompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  InpBytes, OutBytes: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  try
    GetMem(InpBuf, inpStream.Size);
    inpStream.Position := 0;
    InpBytes := inpStream.Read(InpBuf^, inpStream.Size);
    CompressBuf(InpBuf, InpBytes, OutBuf, OutBytes);
    outStream.Write(OutBuf^, OutBytes);
  finally
    if InpBuf <> nil then FreeMem(InpBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;
end;
begin
  list := TStringList.Create;
  list.Add(IntToStr(mXRegions));
  list.Add(IntToStr(mYRegions));
  list.Add(IntToStr(mSize));
  list.Add(IntToStr(mRegionSize));

  for i := 0 to Size - 1 do
  begin
    position := ((mCodes^[i].X) shl 16) + mCodes^[i].Y;
    sAndBeta := ((mCodes^[i].Beta) shl 16) + mCodes^[i].S;
    list.Add(IntToStr(position));
    list.Add(intToStr(sAndBeta));
  end;
    ms1 := TMemoryStream.Create;
    ms2 := TMemoryStream.Create;
    try
      list.SaveToStream(ms1);
      CompressStream(ms1, ms2);
      ms2.SaveToFile(pfilename);
    finally
      ms1.Free;
      ms2.Free;
    end;
   frmmainform.listbox1.items:=list;//.LoadFromFile(pFilename);
   list.Free;
end;

procedure TFractalImageModel.LoadFromlist;
var
  position, sAndBeta, i, x, y, s, beta: integer;
  list: TStringList;
begin
  list := TStringList.Create;
  for i:=0 to frmmainform.listbox1.items.count-1 do
    list.add(frmmainform.listbox1.items[i]);
  mXRegions := StrToInt(list[0]);
  mYRegions := StrToInt(list[1]);
  mSize := StrToInt(list[2]);
  mRegionSize := StrToInt(list[3]);
  frmmainform.cbx.itemindex:=mregionsize - 2;
  GetMem(mCodes, Capacity*SizeOf(TFractalCode));
  for i := 0 to Size - 1 do
  begin
    position := StrToInt(list[2*i + 4]);
    sAndBeta := StrToInt(list[2*i + 5]);
    x := (position and $FFFF0000) shr 16;
    y := position and $0000FFFF;
    s := sAndBeta and $0000FFFF;
    beta := smallint((sAndBeta and $FFFF0000) shr 16);
    mCodes^[i] := TFractalCode.CreateFromList(x, y, s, beta);
  end;
  list.Free;
end;

end.
