object Form1: TForm1
  Left = 224
  Top = 174
  Width = 903
  Height = 480
  Caption = 'H'#246'hensatz'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object PaintBox1: TPaintBox
    Left = 153
    Top = 0
    Width = 734
    Height = 441
    Align = alClient
    OnPaint = Button3Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 441
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 62
      Height = 14
      Caption = 'Kathete 1'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 62
      Height = 14
      Caption = 'Kathete 2'
    end
    object Edit1: TEdit
      Left = 80
      Top = 16
      Width = 57
      Height = 22
      TabOrder = 0
      Text = '3'
    end
    object Edit2: TEdit
      Left = 80
      Top = 45
      Width = 57
      Height = 22
      TabOrder = 1
      Text = '2'
    end
    object Button1: TButton
      Left = 8
      Top = 392
      Width = 137
      Height = 25
      Caption = 'Beenden'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 360
      Width = 137
      Height = 25
      Caption = 'Simulation An'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 328
      Width = 137
      Height = 25
      Caption = 'Darstellung'
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5
    OnTimer = Timer1Timer
    Left = 32
    Top = 296
  end
end
