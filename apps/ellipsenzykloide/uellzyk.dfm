object Form1: TForm1
  Left = 192
  Top = 90
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ellipsenzykloide'
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
  OnClose = FormClose
  OnCreate = FormCreate
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
      Width = 80
      Height = 16
      Caption = 'Halbachse a'
    end
    object Label2: TLabel
      Left = 200
      Top = 20
      Width = 80
      Height = 16
      Caption = 'Halbachse b'
    end
    object Label3: TLabel
      Left = 384
      Top = 20
      Width = 88
      Height = 16
      Caption = 'Verschiebung'
    end
    object UpDown1: TUpDown
      Left = 161
      Top = 16
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 25
      Max = 160
      Position = 100
      TabOrder = 0
      Wrap = False
    end
    object Edit1: TEdit
      Left = 112
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 1
      Text = '100'
      OnChange = Edit3Change
    end
    object UpDown2: TUpDown
      Left = 345
      Top = 16
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 25
      Max = 160
      Position = 70
      TabOrder = 2
      Wrap = False
    end
    object Edit2: TEdit
      Left = 296
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 3
      Text = '70'
      OnChange = Edit3Change
    end
    object UpDown3: TUpDown
      Left = 529
      Top = 16
      Width = 16
      Height = 24
      Associate = Edit3
      Min = 0
      Max = 160
      Position = 50
      TabOrder = 4
      Wrap = False
    end
    object Edit3: TEdit
      Left = 480
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 5
      Text = '50'
      OnChange = Edit3Change
    end
    object CheckBox1: TCheckBox
      Left = 576
      Top = 10
      Width = 137
      Height = 17
      Caption = 'Kurve zeichnen'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = PaintBox1Paint
    end
    object CheckBox3: TCheckBox
      Left = 576
      Top = 29
      Width = 129
      Height = 17
      Caption = 'Ellipse zeichnen'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = PaintBox1Paint
    end
    object Button1: TButton
      Left = 720
      Top = 16
      Width = 113
      Height = 25
      Caption = 'Simulation'
      TabOrder = 8
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 848
      Top = 16
      Width = 113
      Height = 25
      Caption = 'Zurücksetzen'
      TabOrder = 9
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
