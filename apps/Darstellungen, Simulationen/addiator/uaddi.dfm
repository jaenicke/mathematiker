object Form1: TForm1
  Left = 309
  Top = 22
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Addiator'
  ClientHeight = 700
  ClientWidth = 474
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object PB11: TPaintBox
    Left = 0
    Top = 0
    Width = 474
    Height = 672
    Align = alClient
    OnMouseDown = PB11MouseDown
    OnMouseMove = PB11MouseMove
    OnMouseUp = PB11MouseUp
    OnPaint = PB11Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 672
    Width = 474
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 304
      Top = 4
      Width = 177
      Height = 17
      TabStop = False
      Caption = 'Automatik verwenden'
      TabOrder = 0
    end
  end
end
