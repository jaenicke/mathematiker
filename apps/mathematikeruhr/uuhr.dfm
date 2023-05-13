object Form1: TForm1
  Left = 304
  Top = 100
  Width = 956
  Height = 592
  Caption = 'Mathematiker-Uhr'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 940
    Height = 495
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 495
    Width = 940
    Height = 41
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
      Top = 12
      Width = 64
      Height = 16
      Caption = 'Grundzahl'
    end
    object Label2: TLabel
      Left = 184
      Top = 12
      Width = 86
      Height = 16
      Caption = 'Stunden/Tag'
    end
    object Label3: TLabel
      Left = 512
      Top = 12
      Width = 81
      Height = 16
      Caption = 'geogr.Länge'
    end
    object RadioButton1: TRadioButton
      Left = 760
      Top = 12
      Width = 81
      Height = 17
      Caption = 'Weltzeit'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 840
      Top = 12
      Width = 89
      Height = 17
      Caption = 'Sternzeit'
      TabOrder = 2
    end
    object RadioButton3: TRadioButton
      Left = 680
      Top = 12
      Width = 73
      Height = 17
      Caption = 'Ortszeit'
      TabOrder = 0
    end
    object se_grundzahl: TEdit
      Left = 96
      Top = 8
      Width = 57
      Height = 24
      TabOrder = 3
      Text = '100'
    end
    object UpDown1: TUpDown
      Left = 153
      Top = 8
      Width = 16
      Height = 24
      Associate = se_grundzahl
      Min = 1
      Max = 200
      Position = 100
      TabOrder = 4
      Wrap = False
    end
    object se_tagstunden: TEdit
      Left = 280
      Top = 8
      Width = 57
      Height = 24
      TabOrder = 5
      Text = '100'
    end
    object UpDown2: TUpDown
      Left = 337
      Top = 8
      Width = 16
      Height = 24
      Associate = se_tagstunden
      Min = 1
      Max = 200
      Position = 100
      TabOrder = 6
      Wrap = False
    end
    object se_laenge: TEdit
      Left = 600
      Top = 8
      Width = 49
      Height = 24
      TabOrder = 7
      Text = '13'
    end
    object UpDown3: TUpDown
      Left = 649
      Top = 8
      Width = 16
      Height = 24
      Associate = se_laenge
      Min = -180
      Max = 180
      Position = 13
      TabOrder = 8
      Wrap = False
    end
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = PaintBox1Paint
    Left = 96
    Top = 160
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 88
    object Datei1: TMenuItem
      Caption = 'Datei'
      object Kopieren1: TMenuItem
        Caption = 'Kopieren'
        OnClick = kopieren1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Ende1: TMenuItem
        Caption = 'Ende'
        OnClick = Ende1Click
      end
    end
    object Einstellungen1: TMenuItem
      Caption = 'Einstellungen'
      object zweiteUhr1: TMenuItem
        Caption = 'zweite Uhr'
        Checked = True
        OnClick = zweiteUhr1Click
      end
      object mathematischeRichtung1: TMenuItem
        Caption = 'mathematische Richtung'
        Checked = True
        OnClick = mathematischeRichtung1Click
      end
      object Zeitbezeichnungen1: TMenuItem
        Caption = 'Zeitbezeichnungen'
        Checked = True
        OnClick = Zeitbezeichnungen1Click
      end
    end
  end
end
