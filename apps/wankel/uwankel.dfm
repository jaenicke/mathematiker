object Form1: TForm1
  Left = 289
  Top = 19
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Wankelmotorscheibe'
  ClientHeight = 627
  ClientWidth = 544
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 544
    Height = 586
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 586
    Width = 544
    Height = 41
    Align = alBottom
    BevelOuter = bvSpace
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 110
      Height = 16
      Caption = 'Geschwindigkeit '
    end
    object Label2: TLabel
      Left = 224
      Top = 12
      Width = 38
      Height = 16
      Caption = 'Größe'
    end
    object Button1: TButton
      Left = 400
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Simulation'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 136
      Top = 8
      Width = 49
      Height = 24
      TabOrder = 1
      Text = '2'
      OnChange = Edit1Change
    end
    object UpDown1: TUpDown
      Left = 185
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 1
      Max = 10
      Position = 2
      TabOrder = 2
      Wrap = False
    end
    object Edit2: TEdit
      Left = 272
      Top = 8
      Width = 49
      Height = 24
      TabOrder = 3
      Text = '15'
      OnChange = Edit1Change
    end
    object UpDown2: TUpDown
      Left = 321
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 5
      Max = 25
      Position = 15
      TabOrder = 4
      Wrap = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 24
    Top = 32
  end
end
