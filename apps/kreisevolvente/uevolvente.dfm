object Form1: TForm1
  Left = 341
  Top = 74
  Width = 619
  Height = 621
  Caption = 'Kreisevolvente'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 603
    Height = 528
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 528
    Width = 603
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 18
      Width = 70
      Height = 16
      Caption = 'Winkel in °'
    end
    object Label2: TLabel
      Left = 200
      Top = 18
      Width = 42
      Height = 16
      Caption = 'Radius'
    end
    object UpDown1: TUpDown
      Left = 145
      Top = 16
      Width = 17
      Height = 24
      Associate = Edit1
      Min = 0
      Max = 7200
      Position = 0
      TabOrder = 0
      Thousands = False
      Wrap = False
    end
    object Edit1: TEdit
      Left = 96
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 1
      Text = '0'
      OnChange = PaintBox1Paint
    end
    object Edit2: TEdit
      Left = 256
      Top = 16
      Width = 41
      Height = 24
      TabOrder = 2
      Text = '20'
      OnChange = PaintBox1Paint
    end
    object UpDown2: TUpDown
      Left = 297
      Top = 16
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 5
      Max = 120
      Position = 20
      TabOrder = 3
      Wrap = False
    end
    object Button1: TButton
      Left = 360
      Top = 16
      Width = 106
      Height = 25
      Caption = 'Simulation'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 480
      Top = 16
      Width = 106
      Height = 25
      Caption = 'Zurücksetzen'
      TabOrder = 5
      OnClick = Button2Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 16
    Top = 32
  end
end
