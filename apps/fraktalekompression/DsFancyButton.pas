unit DsFancyButton;

{$R-}
{$B-}
{$H+}   {--always use this compiler directive----}

{$DEFINE Delphi5} {--disable this line for previous Delphi version--}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms; //, DsgnIntf;

type
  TTextStyle = (txNone, txLowered, txRaised, txShadowed);
  TBtnShape = (btnCapsule, btnOval, btnRectangle);
  TFrameStyle = (fmNone, fmGradient);
  TDsEffect = class(TPersistent)
  private
    FButtonColor: TColor;
    FBtnShape: TBtnShape;
    FCornerRadius: Integer;
    FFrameColor: TColor;
    FFrameWidth: Integer;
    FHoverColor: TColor;
    FTextStyle: TTextStyle;
    FFrameStyle: TFrameStyle;
    FOnEffectChange: TNotifyEvent;
    procedure DoChanges;
  protected
    procedure SetButtonColor(Value: TColor);
    procedure SetBtnShape(Value: TBtnShape);
    procedure SetCornerRadius(Value: Integer);
    procedure SetFrameColor(Value: TColor);
    procedure SetFrameStyle(Value: TFrameStyle);
    procedure SetFrameWidth(Value: Integer);
    procedure SetHoverColor(Value: TColor);
    procedure SetTextStyle(Value: TTextStyle);
  public
  published
    property FaceColor: TColor read FButtonColor write SetButtonColor;
    property FrameColor: TColor read FFrameColor write SetFrameColor;
    property FrameStyle: TFrameStyle read FFrameStyle write SetFrameStyle;
    property FrameWidth: Integer read FFrameWidth write SetFrameWidth;
    property HoverColor: TColor read FHoverColor write SetHoverColor;
    property Shape: TBtnShape read FBtnShape write SetBtnShape;
    property CornerRadius: Integer read FCornerRadius write SetCornerRadius;
    property TextStyle: TTextStyle read FTextStyle write SetTextStyle;
    property OnEffectChange: TNotifyEvent read FOnEffectChange write FOnEffectChange;
  end;

  TBmpLayout = (lyLeft, lyTop, lyRight, lyBottom, lyCenter);
  TDsGlyph = class(TPersistent)
  private
    FBmpGlyph: TBitmap;
    FBmpLayout: TBmpLayout;
    FGlyphsNum: Byte;
    FGlyphSpace: Integer;
    FOnGlyphChange: TNotifyEvent;
    procedure DoChanges;
  protected
    procedure SetBmpLayout(Value: TBmpLayout);
    procedure SetBmpGlyph(ABmpGlyph: TBitmap);
    procedure SetGlyphsNum(Value: Byte);
    procedure SetGlyphSpace(Value: Integer);
  published
    property Glyph: TBitmap read FBmpGlyph write SetBmpGlyph;
    property Layout: TBmpLayout read FBmpLayout write SetBmpLayout;
    property Number: Byte read FGlyphsNum write SetGlyphsNum;
    property Distance: Integer read FGlyphSpace write SetGlyphSpace;
    property OnGlyphChange: TNotifyEvent read FOnGlyphChange write FOnGlyphChange;
  end;

  {--Fancy button--}
  TDsFancyButton = class(TGraphicControl)
  private
    FEffect: TDsEffect;
    FGlyphs: TDsGlyph;
    FIsDown: Boolean;
    FInRegion: Boolean;
    FBmpWidth: Integer;
    FGlyphToDraw: Integer;
    FGlyphL, FGlyphT: Integer;
    FTransparentColor: TColor;
    FTextL, FTextT: Integer;

    procedure CMMouseLeave(var AMsg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var message: TMessage);
              message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var message: TMessage);
              message CM_TEXTCHANGED;
    procedure CMDialogChar(var message: TCMDialogChar);
              message CM_DIALOGCHAR;
    procedure WMSize(var message: TWMSize); message WM_PAINT;
    procedure UpdateChanges(Sender: TObject);
  protected
    procedure Click; override;
    procedure DrawShape;
    procedure DrawShapePressed;
    procedure DrawButtonArea;
    procedure DrawGlyph;
    procedure WriteCaption;
    procedure LayoutSetting;
    procedure Paint; override;
    function IsInRegion(X, Y: Integer): Boolean;

    procedure MouseUp(Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    {$IFDEF Delphi5}
    property Anchors;
    property Constraints;
    {$ENDIF}

    property Caption;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FXE: TDsEffect read FEffect write FEffect;
    property Glyphs: TDsGlyph read FGlyphs write FGlyphs;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;

    property OnClick;         property OnDragDrop;
    property OnDragOver;      property OnEndDrag;
    property OnMouseDown;     property OnMouseUp;
    property OnMouseMove;
  end;

implementation

procedure TDsEffect.SetButtonColor(Value: TColor);
begin
  if value<>FButtonColor then
    begin FButtonColor:=Value; DoChanges; end;
end;

procedure TDsEffect.SetFrameColor(Value: TColor);
begin
  if Value<>FFrameColor then
    begin FFrameColor:=Value; DoChanges; end;
end;

procedure TDsEffect.SetHoverColor(Value: TColor);
begin
  if Value<>FHoverColor then
    begin FHoverColor:=Value; DoChanges; end;
end;

procedure TDsEffect.SetBtnShape(Value: TBtnShape);
begin
  if Value<>FBtnShape then
    begin FBtnShape:=Value; DoChanges; end;
end;

procedure TDsEffect.SetCornerRadius(Value: Integer);
begin
  if Value<>FCornerRadius then
  begin
    FCornerRadius:=Value;
    if FCornerRadius<0 then FCornerRadius:=0;
    if FCornerRadius>205 then FCornerRadius:=205;
    DoChanges;
  end;
end;

procedure TDsEffect.SetFrameWidth(Value: Integer);
begin
  if Value<>FFrameWidth then
  begin
    FFrameWidth:=Value;
    if FFrameWidth<3 then FFrameWidth:=3;
    if FFrameWidth>14 then FFrameWidth:=14;
    DoChanges;
  end;
end;

procedure TDsEffect.SetTextStyle(Value: TTextStyle);
begin
  if Value<>FTextStyle then
    begin FTextStyle:=Value; DoChanges; end;
end;

procedure TDsEffect.SetFrameStyle(Value: TFrameStyle);
begin
  if Value<>FFrameStyle then
    begin FFrameStyle:=Value; DoChanges; end;
end;

procedure TDsEffect.DoChanges;
begin
  if Assigned(FOnEffectChange) then FOnEffectChange(Self);
end;

procedure TDsGlyph.SetBmpGlyph(ABmpGlyph: TBitmap);
begin
  FBmpGlyph.Assign(ABmpGlyph);
  DoChanges;
end;

procedure TDsGlyph.SetBmpLayout(Value: TBmpLayout);
begin
  if Value<>FBmpLayout then
  begin
    FBmpLayout:=Value;
    DoChanges;
  end;
end;

procedure TDsGlyph.SetGlyphsNum(Value: Byte);
begin
  if Value<>FGlyphsNum then
  begin
    FGlyphsNum:=Value;
    if FGlyphsNum<1 then FGlyphsNum:=1;
    if FGlyphsNum>4 then FGlyphsNum:=4;
    DoChanges;
  end;
end;

procedure TDsGlyph.SetGlyphSpace(Value: Integer);
begin
  if Value<>FGlyphSpace then
  begin
    FGlyphSpace:=Value;
    if FGlyphSpace<1 then FGlyphSpace:=0;
    DoChanges;
  end;
end;

procedure TDsGlyph.DoChanges;
begin
  if Assigned(FOnGlyphChange) then FOnGlyphChange(Self);
end;

constructor TDsFancyButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=[csClickEvents, csCaptureMouse, csSetCaption];
  Enabled:=True;
  
  FEffect:=TDsEffect.Create;
  with FEffect do
  begin
    FaceColor:=clBtnFace;
    FrameColor:=clWhite;
    FFrameWidth:=4;
    FHoverColor:=clBlue;
    FBtnShape:=btnRectangle;
    FCornerRadius:=2;
    FTextStyle:=txRaised;
    FFrameStyle:=fmGradient;
    OnEffectChange:=UpdateChanges;
  end;

  FGlyphs:=TDsGlyph.Create;
  with FGlyphs do
  begin
    FBmpGlyph:=TBitmap.Create;
    FBmpLayout:=lyLeft;
    FGlyphsNum:=1;
    FGlyphSpace:=0;
    OnGlyphChange:=UpdateChanges;
  end;

  FBmpWidth:=0;
  FGlyphToDraw:=1;
  FIsDown:=False;
  Height:=25;
  Visible:=True;
  Width:=97;
end;

destructor TDsFancyButton.Destroy;
begin
  if Assigned(FGlyphs.Glyph) then FGlyphs.Glyph.Destroy;
  FGlyphs.free;
  FEffect.free;
  inherited Destroy;
end;

procedure TDsFancyButton.Paint;
begin
  FBmpWidth:=FGlyphs.Glyph.Width div FGlyphs.Number;

  Canvas.Font:=Self.Font;
  Canvas.Brush.Style:=bsClear;

  if FEffect.FrameStyle=fmNone then DrawButtonArea
  else if FIsDown then DrawShapePressed
  else DrawShape;

  LayoutSetting;
  if FBmpWidth>0 then DrawGlyph;
  WriteCaption;
end;

function TDsFancyButton.IsInRegion(X, Y: Integer): Boolean;
var Dia: Integer;
    MRgn: HRgn;
begin
  Result:=False;
//  case FEffect.Shape of
//    btnRectangle:
//      begin
        Dia:=2*FEffect.CornerRadius;
        MRgn:=CreateRoundRectRgn(0, 0, Width, Height, Dia, Dia);
//      end;
{    btnCapsule:
      begin
        if Width<Height then Dia:=Width else Dia:=Height;
        MRgn:=CreateRoundRectRgn(0, 0, Width, Height, Dia, Dia);
      end;}
//    btnOval: MRgn:=CreateEllipticRgn(0, 0, Width, Height);
//    else MRgn:=CreateEllipticRgn(0, 0, Width, Height);
//  end; //case

  try
    if PtInRegion(MRgn, X, Y) then Result:=True;
  finally
    DeleteObject(MRgn);
  end;
end;

procedure TDsFancyButton.DrawButtonArea;
var Dia: Integer;
begin
  if not (csDesigning in ComponentState) then Exit;
  Canvas.Pen.Style:=psDot;
  Canvas.Pen.Color:=clGray;
//  case FEffect.Shape of
//    btnRectangle:
//      begin
        Dia:=2*FEffect.CornerRadius;
        Canvas.RoundRect(0, 0, Width, Height, Dia, Dia);
//      end;
{    btnCapsule:
      begin
        if Width<Height then Dia:=Width else Dia:=Height;
        Canvas.RoundRect(0, 0, Width, Height, Dia, Dia);
      end;}
//    btnOval: Canvas.Ellipse(0, 0, Width, Height);
//  end; //case
end;

procedure TDsFancyButton.DrawShape;
var
  FC, Warna: TColor;
  R, G, B: Byte;
  AwalR, AwalG, AwalB,
  AkhirR, AkhirG, AkhirB,
  n, t, Dia: Integer;
  FRgn: HRgn;
  TempValue: real;
begin
  Warna:=ColorToRGB(FEffect.FaceColor);
  FC:=ColorToRGB(FEffect.FrameColor);

  AwalR:=GetRValue(FC); AkhirR:=GetRValue(Warna);
  AwalG:=GetGValue(FC); AkhirG:=GetGValue(Warna);
  AwalB:=GetBValue(FC); AkhirB:=GetBValue(Warna);

  t:=FEffect.FFrameWidth;
  for n:=0 to t-1 do
  begin
    TempValue:=Sqrt(t*t-Sqr(t-n))/t;
    R:=AwalR+Round(TempValue*(AkhirR-AwalR));
    G:=AwalG+Round(TempValue*(AkhirG-AwalG));
    B:=AwalB+Round(TempValue*(AkhirB-AwalB));
    Canvas.Brush.Color:=RGB(R, G, B);

//    if FEffect.Shape=btnOval then
//      FRgn:=CreateEllipticRgn(n, n, 1+Width-n, 1+Height-n)
//    else
//    begin
//      if FEffect.Shape=btnCapsule then
//        if Width<Height then Dia:=Width else Dia:=Height
//      else
         Dia:=2*FEffect.CornerRadius;
      if (Dia-2*n)>0 then
        FRgn:=CreateRoundRectRgn(n, n, 1+Width-n, 1+Height-n, Dia-2*n, Dia-2*n)
      else FRgn:=CreateRectRgn(n, n, Width-n, Height-n);
//    end;

    try
      FillRgn(Canvas.Handle, FRgn, Canvas.Brush.Handle);
    finally
      DeleteObject(FRgn);
    end;
  end;
end;

procedure TDsFancyButton.DrawShapePressed;
var Dia: Integer;
  FRgn: HRgn;

  function SpotRGB(Level: Byte): TColor;
  var WarnaAwal, WarnaAkhir: TColor;
      AwalR, AwalG, AwalB,
      AkhirR, AkhirG, AkhirB: TColor;
      R, G, B: Byte;
  begin
    WarnaAkhir:=ColorToRGB(FEffect.FaceColor);
    WarnaAwal:=ColorToRGB(FEffect.FrameColor);

    AwalR:=GetRValue(WarnaAwal); AkhirR:=GetRValue(WarnaAkhir);
    AwalG:=GetGValue(WarnaAwal); AkhirG:=GetGValue(WarnaAkhir);
    AwalB:=GetBValue(WarnaAwal); AkhirB:=GetBValue(WarnaAkhir);

    R:=Round((AwalR*Level+AkhirR*(100-Level))*0.01);
    G:=Round((AwalG*Level+AkhirG*(100-Level))*0.01);
    B:=Round((AwalB*Level+AkhirB*(100-Level))*0.01);
    Result:=RGB(R, G, B);
  end;

begin
//  if FEffect.Shape=btnOval then
//    FRgn:=CreateEllipticRgn(1, 1, Width-2, Height-2)
//  else
//  begin
//    if FEffect.Shape=btnCapsule then
//      if Width<Height then Dia:=Width else Dia:=Height
//    else
     Dia:=2*FEffect.CornerRadius;
    if (Dia)>0 then
      FRgn:=CreateRoundRectRgn(1, 1, Width-2, Height-2, Dia-2, Dia-2)
    else FRgn:=CreateRectRgn(1, 1, Width-3, Height-3);
//  end;

  try
    Canvas.Brush.Color:=clBlack;
    FillRgn(Canvas.Handle, FRgn, Canvas.Brush.Handle);
    OffsetRgn(FRgn, 1, 1);
    Canvas.Brush.Color:=SpotRGB(40); {--frame color: 40% face color: 60%--}
    FillRgn(Canvas.Handle, FRgn, Canvas.Brush.Handle);
    OffsetRgn(FRgn, 2, 2);
    Canvas.Brush.Color:=clBtnHighlight;
    FillRgn(Canvas.Handle, FRgn, Canvas.Brush.Handle);
    OffsetRgn(FRgn, -1, -1);
    Canvas.Brush.Color:=SpotRGB(15); {--frame color: 15% face color: 85%--}
    FillRgn(Canvas.Handle, FRgn, Canvas.Brush.Handle);
  finally
    DeleteObject(FRgn);
  end;
end;

procedure TDsFancyButton.WriteCaption;
var Flags: Word;
    BtnL, BtnT, BtnR, BtnB: Integer;
    R, TR: TRect;
    FTextColor: TColor;
begin
  R:=ClientRect; TR:=ClientRect;
  Canvas.Brush.Style:=bsClear;
  Flags:=DT_CENTER or DT_SINGLELINE;
  Canvas.Font:=Font;

  if FInRegion and not FIsDown then FTextColor:=FEffect.HoverColor
  else FTextColor:=Self.Font.Color;

  with canvas do
  begin
    BtnT:=FTextT;
    BtnB:=BtnT+TextHeight(Caption);
    BtnL:=FTextL;
    BtnR:=BtnL+TextWidth(Caption);
    TR:=Rect(BtnL, BtnT, BtnR, BtnB);
    R:=TR;

    if (FEffect.TextStyle=txLowered) and not FIsDown then
    begin
      Font.Color:=clBtnHighLight;
      OffsetRect(TR, 1, 1);
      DrawText(Handle, PChar(Caption), Length(Caption), TR, Flags);
    end
    else if (FEffect.TextStyle=txLowered) and FIsDown then
    begin
      Font.Color:=clBtnHighLight;
      OffsetRect(TR, 2, 2);
      DrawText(Handle, PChar(Caption), Length(Caption), TR, Flags);
    end
    else if (FEffect.TextStyle=txRaised) and not FIsDown then
    begin
      Font.Color:=clBtnHighLight;
      OffsetRect(TR, -1, -1);
      DrawText(Handle, PChar(Caption), Length(Caption), TR, Flags);
    end
    else if (FEffect.TextStyle=txRaised) and FIsDown then
    begin
      Font.Color:=clBtnHighLight;
      DrawText(Handle, PChar(Caption), Length(Caption), TR, Flags);
    end
    else if (FEffect.TextStyle=txShadowed) and FIsDown then
    begin
      Font.Color:=clBtnShadow;
      OffsetRect(TR, 3, 3);
      DrawText(Handle, PChar(Caption), Length(Caption), TR, Flags);
    end
    else if (FEffect.TextStyle=txShadowed) and not FIsDown then
    begin
      Font.Color:=clBtnShadow;
      OffsetRect(TR, 2, 2);
      DrawText(Handle, PChar(Caption), Length(Caption), TR, Flags);
    end;

    if Enabled then Font.Color:=FTextColor
    else if (FEffect.TextStyle=txShadowed) and not Enabled then
      Font.Color:=clBtnFace
    else Font.Color:=clBtnShadow;
    if FIsDown then OffsetRect(R, 1, 1);
    DrawText(Handle, PChar(Caption), Length(Caption), R, Flags);
  end;
end;

procedure TDsFancyButton.LayoutSetting;
var n: Integer;
    wg, hg, wt, ht: Integer;
    dist: Integer;
begin
  dist:=FGlyphs.Distance;
  wg:=FGlyphs.Glyph.Width div FGlyphs.Number;
  hg:=FGlyphs.Glyph.Height;
  wt:=Canvas.TextWidth(Caption);
  ht:=Canvas.TextHeight(Caption);
  case FGlyphs.Layout of
    lyLeft  : begin
                if Width>(wg+dist+wt) then FGlyphL:=(Width-wg-dist-wt) div 2
                else FGlyphL:=0;
                if Height>hg then FGlyphT:=(Height-hg) div 2 else FGlyphT:=0;
                FTextL:=FGlyphL+FBmpWidth+dist;
                FTextT:=(Height-ht) div 2;
              end;
    lyRight : begin
                if Width>(wg+dist+wt) then n:=(Width-wg-dist-wt) div 2
                else n:=0;
                FGlyphL:=Width-n-wg;
                if Height>hg then FGlyphT:=(Height-hg) div 2 else FGlyphT:=0;
                FTextL:=FGlyphL-wt-dist;
                FTextT:=(Height-ht) div 2;
              end;
    lyTop   : begin
                if Width>wg then FGlyphL:=(Width-wg) div 2 else FGlyphL:=0;
                if Height>(hg+dist+ht) then FGlyphT:=(Height-hg-dist-ht) div 2
                else FGlyphT:=0;
                FTextL:=(Width-wt) div 2;
                FTextT:=FGlyphT+FGlyphs.Glyph.Height+dist;
              end;
    lyBottom: begin
                if Width>wg then FGlyphL:=(Width-wg) div 2 else FGlyphL:=0;
                if Height>(hg+dist+ht) then n:=(Height-hg-dist-ht) div 2
                else n:=0;
                FGlyphT:=Height-n-hg;
                FTextL:=(Width-wt) div 2;
                FTextT:=FGlyphT-dist-ht;
              end;
    lyCenter: begin
                if Width>wg then FGlyphL:=(Width-wg) div 2 else FGlyphL:=0;
                if Height>hg then FGlyphT:=(Height-hg) div 2 else FGlyphT:=0;
                FTextL:=(Width-wt) div 2;
                FTextT:=(Height-ht) div 2;
              end;
  end;
end;

procedure TDsFancyButton.DrawGlyph;
var c: Byte;
    R: TRect;
begin
  if FGlyphToDraw>FGlyphs.Number then FGlyphToDraw:=1;
  { 1=enabled  2=disabled  3=pressed  4=pointed }
  c:=0;
  case FGlyphToDraw of
    1: c:=0;
    2: c:=1;
    3: c:=2;
    4: c:=3;
  end;

  R.Left:=FGlyphL;  R.Right:=FGlyphL+FBmpWidth;
  R.Top:=FGlyphT;   R.Bottom:=FGlyphT+FGlyphs.Glyph.Height;
  if FIsDown then OffsetRect(R, 1, 1);

  FTransparentColor:=FGlyphs.Glyph.Canvas.Pixels[0, FGlyphs.Glyph.Height-1];
  Canvas.BrushCopy(R, FGlyphs.Glyph,
                   Bounds(c*FBmpWidth, 0, FBmpWidth, FGlyphs.Glyph.Height),
                   FTransparentColor);
end;

procedure TDsFancyButton.UpdateChanges(Sender: TObject);
begin
  if csLoading in ComponentState then Exit;
  Invalidate;
end;

procedure TDsFancyButton.MouseDown(Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button=mbRight then Exit;
  if not FInRegion then Exit;
  FIsDown:=True;
  FGlyphToDraw:=3;
  Invalidate;
end;

procedure TDsFancyButton.MouseUp(Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button=mbRight then Exit;
  if not FInRegion then Exit;
  inherited Click;
  FIsDown:=False;
  Invalidate;
end;

procedure TDsFancyButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if FIsDown then Exit;
  if IsInRegion(X, Y) then
  begin
    FInRegion:=True;
    if (FGlyphToDraw<>4) then
      begin FGlyphToDraw:=4; Invalidate; end;
  end
  else
  begin
    FInRegion:=False;
    if FGlyphToDraw<>1 then
      begin FGlyphToDraw:=1; Invalidate; end;
  end;
end;

procedure TDsFancyButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not Enabled then FGlyphToDraw:=2
  else FGlyphToDraw:=1; 
  invalidate;
end;

procedure TDsFancyButton.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TDsFancyButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled then
      begin inherited Click; Result:=1; end
    else inherited;
end;

procedure TDsFancyButton.WMSize(var Message: TWMSize);
begin
  inherited;
  if Width>205 then Width:=205;
  if Height>145 then Height:=145;
end;
                     
procedure TDsFancyButton.CMMouseLeave(var AMsg: TMessage);
begin
  inherited;
  if Enabled then FGlyphToDraw:=1
  else FGlyphToDraw:=2;
  FInRegion:=False;
  FIsDown:=False;
  Invalidate;
end;

procedure TDsFancyButton.Click;
begin
  Invalidate;
end;

end.

