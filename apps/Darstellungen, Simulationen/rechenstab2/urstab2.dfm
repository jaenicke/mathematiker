object Frstab: TFrstab
  Left = 312
  Top = 139
  Width = 927
  Height = 467
  HelpContext = 119
  Caption = 'Rechenstab mit CF/DF-Skalen'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object rechenst: TPanel
    Left = 0
    Top = 0
    Width = 911
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object PB1: TPaintBox
      Left = 0
      Top = 0
      Width = 911
      Height = 428
      Align = alClient
      OnMouseDown = PB1MouseDown
      OnMouseMove = PB1MouseMove
      OnMouseUp = PB1MouseUp
      OnPaint = PB1Paint
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 24
    object m1: TMenuItem
      Caption = 'm'
      ShortCut = 27
      Visible = False
      OnClick = m1Click
    end
  end
end
