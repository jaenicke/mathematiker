unit xzusatzbild2;
{ Copyright 1995-2017, Steffen Polster, mathematikalpha.de
  This program may be used or modified for any non-commercial purpose
  so long as this original notice remains in place.
  All other rights are reserved
}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, gifimage;

type
  Tzusatzbild2 = class(TForm)
    I1: TImage;
    PM1: TPopupMenu;
    M2: TMenuItem;
    M11: TMenuItem;
    M1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure M2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  zusatzbild2: Tzusatzbild2;
  zusatzbildstring2:string;

implementation

{$R *.DFM}

procedure Tzusatzbild2.FormCreate(Sender: TObject);
var x:integer;
procedure loesungladen(const kk:string);
var
  Stream		: TStream;
  GIF			: TGIFImage;
  Bitmap		: TBitmap;
begin
  Stream := TResourceStream.Create(hinstance,kk,'GIF');
  try
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromStream(Stream);
      I1.Picture.Assign(nil);
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(GIF);
        I1.Picture.Assign(Bitmap);
      finally
        Bitmap.Free;
      end;
    finally
      GIF.Free;
    end;
  finally
    Stream.Free;
  end;
end;
begin
    loesungladen(zusatzbildstring2);

    zusatzbild2.clientwidth:=i1.Picture.bitmap.width;
    zusatzbild2.clientheight:=i1.Picture.bitmap.height;

    if zusatzbild2.top+zusatzbild2.height+30>screen.height then
    begin
      x:=screen.height-zusatzbild2.height-30;
      if x<0 then x:=0;
      zusatzbild2.top:=x;
    end;
end;

procedure Tzusatzbild2.M2Click(Sender: TObject);
begin
    close
end;

end.
