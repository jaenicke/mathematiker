object Form1: TForm1
  Left = 187
  Top = 119
  Width = 1227
  Height = 715
  Caption = 'Leitungsvorgang in Halbleitern'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pb1: TPaintBox
    Left = 0
    Top = 0
    Width = 1026
    Height = 676
    Align = alClient
    OnPaint = Pb1paint
  end
  object Panel1: TPanel
    Left = 1026
    Top = 0
    Width = 185
    Height = 676
    Align = alRight
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 160
      Width = 65
      Height = 16
      Caption = 'Spannung'
    end
    object Button1: TButton
      Left = 24
      Top = 32
      Width = 129
      Height = 25
      Caption = 'Silizium-Gitter'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 24
      Top = 72
      Width = 129
      Height = 25
      Caption = 'B-3-Dotieren'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 24
      Top = 112
      Width = 129
      Height = 25
      Caption = 'P-5-Dotieren'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Edit1: TEdit
      Left = 104
      Top = 156
      Width = 41
      Height = 24
      TabOrder = 3
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 145
      Top = 156
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 0
      Max = 20
      Position = 0
      TabOrder = 4
      Wrap = False
    end
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 911
    Top = 24
  end
end
