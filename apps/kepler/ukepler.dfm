object Form1: TForm1
  Left = 452
  Top = 194
  Width = 887
  Height = 563
  Caption = 'Keplersche Gesetze'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 707
    Height = 524
    Align = alClient
    OnPaint = Paintbox1P
  end
  object Panel1: TPanel
    Left = 707
    Top = 0
    Width = 164
    Height = 524
    Align = alRight
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 65
      Height = 16
      Caption = 'Exzentr. 1'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 70
      Height = 16
      Caption = 'Winkel in '#176
    end
    object Label3: TLabel
      Left = 16
      Top = 92
      Width = 65
      Height = 16
      Caption = 'Exzentr. 2'
    end
    object Button1: TButton
      Left = 21
      Top = 128
      Width = 124
      Height = 25
      Caption = 'Simulation'
      TabOrder = 0
      OnClick = Button1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 96
      Top = 24
      Width = 56
      Height = 26
      MaxLength = 95
      MaxValue = 98
      MinValue = 0
      TabOrder = 1
      Value = 60
      OnChange = SpinEdit1Change
    end
    object SpinEdit2: TSpinEdit
      Left = 96
      Top = 88
      Width = 56
      Height = 26
      MaxLength = 95
      MaxValue = 98
      MinValue = 0
      TabOrder = 2
      Value = 60
      OnChange = SpinEdit1Change
    end
    object RadioButton1: TRadioButton
      Left = 40
      Top = 168
      Width = 100
      Height = 17
      Caption = '1.Gesetz'
      Checked = True
      TabOrder = 3
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 40
      Top = 192
      Width = 100
      Height = 17
      Caption = '2.Gesetz'
      TabOrder = 4
    end
    object RadioButton3: TRadioButton
      Left = 40
      Top = 216
      Width = 100
      Height = 17
      Caption = '3.Gesetz'
      TabOrder = 5
    end
    object SpinEdit3: TSpinEdit
      Left = 96
      Top = 56
      Width = 56
      Height = 26
      MaxLength = 95
      MaxValue = 360
      MinValue = 0
      TabOrder = 6
      Value = 60
      OnChange = Paintbox1P
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 16
    Top = 24
  end
end
