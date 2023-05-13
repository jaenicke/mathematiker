object Form1: TForm1
  Left = 310
  Top = 53
  BorderStyle = bsSingle
  Caption = 'Yin und Yang-Täuschung'
  ClientHeight = 684
  ClientWidth = 684
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
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
      Width = 42
      Height = 16
      Caption = 'Zyklus'
    end
    object Label2: TLabel
      Left = 152
      Top = 12
      Width = 45
      Height = 16
      Caption = 'Illusion'
    end
    object Button1: TButton
      Left = 560
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 72
      Top = 8
      Width = 41
      Height = 24
      ReadOnly = True
      TabOrder = 1
      Text = '5'
    end
    object UpDown1: TUpDown
      Left = 113
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 1
      Max = 25
      Position = 5
      TabOrder = 2
      Wrap = False
    end
    object ComboBox1: TComboBox
      Left = 208
      Top = 8
      Width = 217
      Height = 24
      ItemHeight = 16
      TabOrder = 3
      Text = 'Yin-Yang-Täuschung'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Yin-Yang-Täuschung'
        'Shapiro-Illusion'
        'Speichen-Illusion'
        'van der Helm-Kaleidoskop'
        'Oszillierendes Quadrat'
        'Stereokinetisches Phänomen'
        'Bewegte Linien'
        'Kreisring-Illusion')
    end
    object CheckBox1: TCheckBox
      Left = 440
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Auflösung'
      TabOrder = 4
      Visible = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 30
    OnTimer = Timer1Timer
    Left = 15
    Top = 12
  end
end
