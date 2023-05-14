object Form1: TForm1
  Left = 251
  Top = 115
  Width = 912
  Height = 659
  Caption = 'Erdkugel'
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
  object PaintBox1: TPaintBox
    Left = 185
    Top = 0
    Width = 711
    Height = 620
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 620
    Align = alLeft
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 22
      Width = 63
      Height = 14
      Caption = 'Breite in '#176
    end
    object Label2: TLabel
      Left = 24
      Top = 62
      Width = 65
      Height = 14
      Caption = 'L'#228'nge in '#176
    end
    object BDrehung: TButton
      Left = 24
      Top = 312
      Width = 129
      Height = 25
      Caption = 'Drehung'
      TabOrder = 0
      OnClick = BDrehungClick
    end
    object CheckHori: TCheckBox
      Left = 16
      Top = 104
      Width = 153
      Height = 17
      Caption = 'horizontale Drehung'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckVert: TCheckBox
      Left = 16
      Top = 128
      Width = 145
      Height = 17
      Caption = 'vertikale Drehung'
      TabOrder = 2
    end
    object Spinhori: TSpinEdit
      Left = 96
      Top = 16
      Width = 62
      Height = 28
      EditorEnabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      MaxValue = 180
      MinValue = -180
      ParentFont = False
      TabOrder = 3
      Value = 15
      OnChange = ThoriChange
    end
    object SpinVert: TSpinEdit
      Left = 96
      Top = 56
      Width = 62
      Height = 28
      EditorEnabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      MaxValue = 360
      MinValue = 0
      ParentFont = False
      TabOrder = 4
      Value = 180
      OnChange = ThoriChange
    end
    object CheckTran: TCheckBox
      Left = 16
      Top = 152
      Width = 153
      Height = 17
      Caption = 'transparente Erde'
      TabOrder = 5
      OnClick = PaintBox1Paint
    end
    object CheckEqua: TCheckBox
      Left = 16
      Top = 176
      Width = 97
      Height = 17
      Caption = #196'quator'
      TabOrder = 6
      OnClick = PaintBox1Paint
    end
    object CheckNull: TCheckBox
      Left = 16
      Top = 200
      Width = 121
      Height = 17
      Caption = 'Nullmeridian'
      TabOrder = 7
      OnClick = PaintBox1Paint
    end
    object CheckBkreis: TCheckBox
      Left = 16
      Top = 224
      Width = 121
      Height = 17
      Caption = 'Breitenkreise'
      TabOrder = 8
      OnClick = PaintBox1Paint
    end
    object CheckLKreis: TCheckBox
      Left = 16
      Top = 248
      Width = 129
      Height = 17
      Caption = 'L'#228'ngenkreise'
      TabOrder = 9
      OnClick = PaintBox1Paint
    end
    object CheckAchse: TCheckBox
      Left = 16
      Top = 272
      Width = 153
      Height = 17
      Caption = 'Achsenneigung'
      TabOrder = 10
      OnClick = PaintBox1Paint
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 20
    OnTimer = Timer1Timer
    Left = 640
    Top = 8
  end
end
