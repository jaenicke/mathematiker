object Form1: TForm1
  Left = 310
  Top = 53
  Width = 700
  Height = 720
  Caption = 'Ulam-Spirale, Archimedische Primzahlspirale'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PB1: TPaintBox
    Left = 0
    Top = 0
    Width = 684
    Height = 643
    Align = alClient
    OnPaint = PB1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 643
    Width = 684
    Height = 41
    Align = alBottom
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 54
      Height = 16
      Caption = 'Abstand'
    end
    object Label2: TLabel
      Left = 152
      Top = 12
      Width = 39
      Height = 16
      Caption = 'Länge'
    end
    object Edit1: TEdit
      Left = 80
      Top = 8
      Width = 33
      Height = 24
      ReadOnly = True
      TabOrder = 0
      Text = '2'
      OnChange = PB1Paint
    end
    object UpDown1: TUpDown
      Left = 113
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 2
      Max = 20
      Position = 2
      TabOrder = 1
      Wrap = False
    end
    object Edit2: TEdit
      Left = 208
      Top = 8
      Width = 41
      Height = 24
      ReadOnly = True
      TabOrder = 2
      Text = '360'
      OnChange = PB1Paint
    end
    object UpDown2: TUpDown
      Left = 249
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 100
      Max = 2500
      Increment = 10
      Position = 360
      TabOrder = 3
      Wrap = False
    end
    object archimedisch: TCheckBox
      Left = 496
      Top = 12
      Width = 169
      Height = 17
      Caption = 'archimedische Spirale'
      TabOrder = 4
      OnClick = PB1Paint
    end
  end
end
