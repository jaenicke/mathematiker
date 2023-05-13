object Form1: TForm1
  Left = 350
  Top = 167
  Width = 781
  Height = 563
  Caption = 'M'#246'ndchen am Quadrat'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 592
    Height = 524
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 592
    Top = 0
    Width = 173
    Height = 524
    Align = alRight
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object TrackBar1: TTrackBar
      Left = 16
      Top = 24
      Width = 137
      Height = 45
      Max = 100
      Min = 10
      Frequency = 10
      Position = 50
      TabOrder = 0
      OnChange = PaintBox1Paint
    end
    object Button1: TButton
      Left = 24
      Top = 80
      Width = 129
      Height = 25
      Caption = 'Gr'#246#223'e '#228'ndern'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 616
    Top = 120
  end
end
