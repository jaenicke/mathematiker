unit MainForm;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  StdCtrls, ExtDlgs, ImageForm, Comp, FIM,
  Menus, Buttons, zlib, ToolWin, ComCtrls, ExtCtrls;

type
  TfrmMainForm = class(TForm)
    SaveDialog1: TSaveDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    l1: TLabel;
    l3: TLabel;
    lblTimeLeft: TLabel;
    l2: TLabel;
    cbx: TComboBox;
    D1: tbutton;
    Panel2: TPanel;
    Image1: TImage;
    D2: tbutton;
    d3: tbutton;
    d5: tbutton;
    d4: tbutton;
    PM1: TPopupMenu;
    hilfe1: TMenuItem;
    ende1: TMenuItem;
    Panel3: TPanel;
    ListBox1: TListBox;
    Panel4: TPanel;
    OpenDialog2: TOpenDialog;
    Label1: TLabel;
    cb2: TComboBox;
    procedure cmdSelectFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure d5Click(Sender: TObject);
    procedure d3Click(Sender: TObject);
    procedure ende1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure cb2Change(Sender: TObject);
  private
    { Private declarations }
    mFIM: TFractalImageModel;
  public
    { Public declarations }
    Compressor: TFractalCompressor;
  end;

var
  frmMainForm: TfrmMainForm;
  verzeichnis: string;

implementation

uses DestImage, Checker, CompThread, DeComp;

var
  checkerThread: TChecker;
  compressorThread: TCompThread;

{$R *.DFM}

procedure TfrmMainForm.cmdSelectFileClick(Sender: TObject);
var
  imageHeight, imageWidth: integer;
  CompressFileName: string;
begin
   openpicturedialog1.initialdir:=verzeichnis;
   if OpenPictureDialog1.Execute then
   begin
     CompressFileName := OpenPictureDialog1.Filename;
     image1.Picture.LoadFromFile(CompressFileName);
     image1.left:=(panel2.width-image1.width) div 2;
     image1.top:=(panel2.height-image1.height) div 2;
     imageHeight := image1.Picture.Height;
     imageWidth := image1.Picture.Width;
     l1.Caption := 'Bildgröße: ' + IntToStr(imageWidth) + ' X '
       + IntToStr(imageHeight);
     d2.Enabled := True;
   end;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
procedure backslash(var k:string);
begin
  if k[length(k)]<>'\' then k:=k+'\';
end;
begin
  verzeichnis:=extractfilepath(application.exename);
  backslash(verzeichnis);
  cbx.ItemIndex := 0;
  mFIM := nil;
end;

procedure TfrmMainForm.D2Click(Sender: TObject);
var
  destImage: TDestinationImage;
  regionSize: integer;
begin
  compressor := TFractalCompressor.Create;
  destImage := TDestinationImage.Create(image1);
  regionSize := StrToInt(cbx.Items[cbx.ItemIndex]);

  compressor.RegionSize := regionSize;
  compressor.DestImage := destImage;

  compressorThread := TCompThread.Create(compressor);
  checkerThread := TChecker.Create(Self);

  d2.Enabled := False;
  d3.Enabled := True;
end;

procedure TfrmMainForm.d5Click(Sender: TObject);
var
  destImage: TDestinationImage;
  regionSize, Iwidth, Iheight, i: integer;
  decomp: TFractalDecompressor;
  frmRecon: TfrmImage;
begin

  decomp := TFractalDecompressor.Create;
  regionSize := StrToInt(cbx.Items[cbx.ItemIndex]);
  Iwidth := regionSize*mFIM.XRegions;
  Iheight := regionSize*mFIM.YRegions;

  destImage := TDestinationImage.CreateGray(Iwidth, Iheight);
  destImage.PrepareDestinationRegions(regionSize);
  Refresh;

  frmRecon := TfrmImage.Create(Self);
  frmRecon.imgImage.Width := Iwidth;
  frmRecon.imgImage.Height := Iheight;
  frmRecon.Width := Iwidth + 20;
  frmRecon.Height := Iheight + 40;
  frmRecon.top := 50;
  frmRecon.Left := 200;
  frmRecon.Caption := 'Entpacktes Bild';

  frmRecon.Show;
  for i := 0 to 15 do
  begin
    decomp.GetNextImage(mFIM, destImage, regionSize);
    destImage.PaintImage(frmRecon.imgImage);
    frmRecon.Caption := 'Iterationen: ' + IntToStr(i + 1);
    application.processmessages;
  end;
  destImage.Free;
  decomp.Free;
  frmRecon.Caption := 'Entpacktes Bild';
end;

procedure TfrmMainForm.d3Click(Sender: TObject);
begin
  checkerThread.Terminate;
  compressorThread.Suspend;
  compressorThread.Destroy;
  d2.Enabled := True;
  d3.Enabled := False;
end;

procedure TfrmMainForm.ende1Click(Sender: TObject);
begin
 close
end;

procedure DecompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  OutBytes, sz: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  sz     := inpStream.Size - inpStream.Position;
  if sz > 0 then
    try
      GetMem(InpBuf, sz);
      inpStream.Read(InpBuf^, sz);
      DecompressBuf(InpBuf, sz, 0, OutBuf, OutBytes);
      outStream.Write(OutBuf^, OutBytes);
    finally
      if InpBuf <> nil then FreeMem(InpBuf);
      if OutBuf <> nil then FreeMem(OutBuf);
    end;
  outStream.Position := 0;
end;

procedure TfrmMainForm.SpeedButton3Click(Sender: TObject);
var ms1, ms2: TMemoryStream;
begin
  OpenDialog2.Title := 'fraktal komprimiertes Bild laden';
  if OpenDialog2.Execute then
  begin
  ms1 := TMemoryStream.Create;
  try
    ms2 := TMemoryStream.Create;
    try
      ms1.LoadFromFile(opendialog2.filename);
      DecompressStream(ms1, ms2);
      listbox1.items.LoadFromStream(ms2);
    finally
      ms2.Free;
    end;
  finally
    ms1.Free;
  end;
    mFIM.Free;
    mFIM := TFractalImageModel.CreateNull;
    mFIM.LoadFromlist;
    d5.Enabled := True;
  end;
end;

procedure TfrmMainForm.cb2Change(Sender: TObject);
var sel:integer;
procedure dll_lesen(const kk:string);
var ms1: TResourcestream; ms2: TMemoryStream;
begin
  ms1 := TResourceStream.Create(hinstance,kk,'RT_RCDATA');
  try
    ms2 := TMemoryStream.Create;
    try
      DecompressStream(ms1, ms2);
      listbox1.items.LoadFromStream(ms2);
    finally
      ms2.Free;
    end;
  finally
    ms1.Free;
  end;
end;
begin
    sel:=cb2.itemindex;
  if sel>0 then begin
    dLL_lesen('f'+inttostr(sel));
    mFIM.Free;
    mFIM := TFractalImageModel.CreateNull;
    mFIM.LoadFromlist;
    d5.Enabled := True;
  end;
end;

end.
