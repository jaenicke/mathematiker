object fdigger: Tfdigger
  Left = 166
  Top = 47
  HelpContext = 190
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Digger'
  ClientHeight = 592
  ClientWidth = 789
  Color = 15790320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object P2: TPanel
    Left = 0
    Top = 0
    Width = 789
    Height = 592
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object PB1: TPaintBox
      Left = 0
      Top = 0
      Width = 789
      Height = 592
      Align = alClient
      OnPaint = PB1Paint
    end
  end
  object MM1: TMainMenu
    Left = 376
    Top = 362
    object x2: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      OnClick = S3Click
    end
    object Zurcksetzen1: TMenuItem
      Caption = 'Zurücksetzen'
      OnClick = stufeein
    end
    object NchsteStufe1: TMenuItem
      Caption = 'Nächste Stufe'
      ShortCut = 122
      OnClick = w1Click
    end
    object x1: TMenuItem
      Caption = 'x'
      Visible = False
      object x5: TMenuItem
        Caption = 'links'
        OnClick = x5Click
      end
      object x7: TMenuItem
        Caption = 'rechts'
        OnClick = x7Click
      end
      object x6: TMenuItem
        Caption = 'oben'
        OnClick = x6Click
      end
      object x3: TMenuItem
        Caption = 'unten'
        OnClick = x3Click
      end
      object x4: TMenuItem
        Caption = 'enter'
        ShortCut = 13
        OnClick = stufeein
      end
    end
  end
  object Timer1: TTimer
    Interval = 55
    OnTimer = Timer1Timer
    Left = 336
    Top = 362
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 296
    Top = 360
  end
end
