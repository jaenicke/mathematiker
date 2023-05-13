object Form1: TForm1
  Left = 192
  Top = 114
  Width = 248
  Height = 332
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Farbring'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = Init
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 232
    Height = 261
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    OnMouseDown = Square
    OnMouseMove = GetRGB
    OnPaint = Ring
  end
  object panDown: TPanel
    Left = 0
    Top = 261
    Width = 232
    Height = 32
    Align = alBottom
    Alignment = taLeftJustify
    TabOrder = 0
    object panColor: TPanel
      Left = 184
      Top = 8
      Width = 33
      Height = 17
      TabOrder = 0
    end
  end
end
