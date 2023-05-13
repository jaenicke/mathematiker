object Form1: TForm1
  Left = 264
  Top = 15
  Width = 884
  Height = 741
  Caption = 'Langton'#39's Ameisen'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 868
    Height = 621
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 621
    Width = 868
    Height = 81
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
      Left = 136
      Top = 20
      Width = 80
      Height = 16
      Caption = 'Ameisenzahl'
    end
    object Label2: TLabel
      Left = 296
      Top = 20
      Width = 35
      Height = 16
      Caption = 'Regel'
    end
    object Label3: TLabel
      Left = 528
      Top = 20
      Width = 7
      Height = 16
      Caption = '-'
    end
    object Label4: TLabel
      Left = 712
      Top = 20
      Width = 56
      Height = 16
      Caption = 'Geschw.'
    end
    object Label5: TLabel
      Left = 528
      Top = 52
      Width = 7
      Height = 16
      Caption = '-'
    end
    object Label6: TLabel
      Left = 360
      Top = 52
      Width = 7
      Height = 16
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 16
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Start'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 232
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 1
      Text = '1'
    end
    object Edit2: TEdit
      Left = 344
      Top = 16
      Width = 169
      Height = 24
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 2
      Text = 'LLRR'
    end
    object Edit3: TEdit
      Left = 776
      Top = 16
      Width = 57
      Height = 24
      TabOrder = 3
      Text = '50'
      OnChange = Edit3Change
    end
    object UpDown1: TUpDown
      Left = 833
      Top = 16
      Width = 17
      Height = 24
      Associate = Edit3
      Min = 5
      Max = 10000
      Increment = 50
      Position = 50
      TabOrder = 4
      Thousands = False
      Wrap = False
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 52
      Width = 73
      Height = 17
      Caption = 'Torus'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object CheckBox3: TCheckBox
      Left = 224
      Top = 52
      Width = 105
      Height = 17
      Caption = 'Regel zeigen'
      TabOrder = 6
    end
  end
end
