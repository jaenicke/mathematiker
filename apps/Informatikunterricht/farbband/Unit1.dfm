object Form1: TForm1
  Left = 192
  Top = 114
  Width = 393
  Height = 173
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Farbband'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = Init
  OnClose = Exit
  PixelsPerInch = 96
  TextHeight = 16
  object pbStripe: TPaintBox
    Left = 0
    Top = 0
    Width = 377
    Height = 102
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    OnMouseMove = GetRGB
    OnPaint = Strip
  end
  object panDown: TPanel
    Left = 0
    Top = 102
    Width = 377
    Height = 32
    Align = alBottom
    TabOrder = 0
  end
end
