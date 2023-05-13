object Form1: TForm1
  Left = 367
  Top = 140
  Width = 898
  Height = 607
  Caption = 'Interferenz von Wellen'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 682
    Height = 568
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 682
    Top = 0
    Width = 200
    Height = 568
    Align = alRight
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 90
      Height = 16
      Caption = '1.Wellenl'#228'nge'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 90
      Height = 16
      Caption = '2.Wellenl'#228'nge'
    end
    object Label3: TLabel
      Left = 48
      Top = 88
      Width = 54
      Height = 16
      Caption = 'Abstand'
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 92
      Height = 16
      Caption = 'Intensit'#228't 10:'
    end
    object Edit1: TEdit
      Left = 112
      Top = 20
      Width = 57
      Height = 24
      TabOrder = 0
      Text = '50'
    end
    object UpDown1: TUpDown
      Left = 169
      Top = 20
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 1
      Max = 250
      Position = 50
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 112
      Top = 52
      Width = 57
      Height = 24
      TabOrder = 2
      Text = '25'
    end
    object UpDown2: TUpDown
      Left = 169
      Top = 52
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 1
      Max = 250
      Position = 25
      TabOrder = 3
    end
    object Edit3: TEdit
      Left = 112
      Top = 84
      Width = 57
      Height = 24
      TabOrder = 4
      Text = '10'
    end
    object UpDown3: TUpDown
      Left = 169
      Top = 84
      Width = 16
      Height = 24
      Associate = Edit3
      Max = 30
      Position = 10
      TabOrder = 5
    end
    object Edit4: TEdit
      Left = 112
      Top = 116
      Width = 57
      Height = 24
      TabOrder = 6
      Text = '10'
    end
    object UpDown4: TUpDown
      Left = 169
      Top = 116
      Width = 16
      Height = 24
      Associate = Edit4
      Min = 1
      Position = 10
      TabOrder = 7
    end
    object Button1: TButton
      Left = 24
      Top = 160
      Width = 153
      Height = 25
      Caption = 'Bild zeichnen'
      TabOrder = 8
      OnClick = PaintBox1Paint
    end
    object Button2: TButton
      Left = 24
      Top = 200
      Width = 153
      Height = 25
      Caption = 'Phase 1 '#228'ndern'
      TabOrder = 9
      OnClick = Button2Click
    end
  end
end
