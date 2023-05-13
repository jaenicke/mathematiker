object Form1: TForm1
  Left = 192
  Top = 90
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Reuleaux-Räder'
  ClientHeight = 560
  ClientWidth = 1006
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 1006
    Height = 497
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 497
    Width = 1006
    Height = 63
    Align = alBottom
    BevelOuter = bvNone
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
      Top = 20
      Width = 38
      Height = 16
      Caption = 'Größe'
    end
    object Label3: TLabel
      Left = 152
      Top = 20
      Width = 105
      Height = 16
      Caption = 'Geschwindigkeit'
    end
    object UpDown1: TUpDown
      Left = 121
      Top = 16
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 60
      Max = 250
      Position = 120
      TabOrder = 0
      Wrap = False
    end
    object Edit1: TEdit
      Left = 72
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 1
      Text = '120'
      OnChange = Edit3Change
    end
    object UpDown3: TUpDown
      Left = 313
      Top = 16
      Width = 16
      Height = 24
      Associate = Edit3
      Min = 1
      Max = 50
      Position = 2
      TabOrder = 2
      Wrap = False
    end
    object Edit3: TEdit
      Left = 264
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 3
      Text = '2'
      OnChange = Edit3Change
    end
    object CheckBox1: TCheckBox
      Left = 464
      Top = 12
      Width = 105
      Height = 17
      Caption = 'Querbalken'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = PaintBox1Paint
    end
    object Button1: TButton
      Left = 752
      Top = 16
      Width = 113
      Height = 25
      Caption = 'Simulation'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 872
      Top = 16
      Width = 113
      Height = 25
      Caption = 'Zurücksetzen'
      TabOrder = 6
      OnClick = Button2Click
    end
    object CheckBox2: TCheckBox
      Left = 592
      Top = 12
      Width = 105
      Height = 17
      Caption = 'oberer Rand'
      TabOrder = 7
      OnClick = PaintBox1Paint
    end
    object CheckBox3: TCheckBox
      Left = 592
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Spur'
      TabOrder = 8
    end
    object RadioButton1: TRadioButton
      Left = 352
      Top = 12
      Width = 81
      Height = 17
      Caption = 'Dreieck'
      Checked = True
      TabOrder = 9
      TabStop = True
      OnClick = Button2Click
    end
    object RadioButton2: TRadioButton
      Left = 352
      Top = 32
      Width = 73
      Height = 17
      Caption = 'Fünfeck'
      TabOrder = 10
      OnClick = Button2Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 16
    Top = 16
  end
end
