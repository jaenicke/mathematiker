object FTerminator: TFTerminator
  Left = 226
  Top = 63
  Width = 1052
  Height = 758
  Caption = 'Terminator, Tag- und Nachtgrenze'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnResize = FormShow
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Paintbox1: TPaintBox
    Left = 0
    Top = 0
    Width = 1036
    Height = 633
    Align = alClient
    OnPaint = BDarstellungClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 633
    Width = 1036
    Height = 86
    Align = alBottom
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 20
      Width = 23
      Height = 16
      Caption = 'Tag'
    end
    object Label2: TLabel
      Left = 120
      Top = 20
      Width = 41
      Height = 16
      Caption = 'Monat'
    end
    object Label3: TLabel
      Left = 240
      Top = 20
      Width = 55
      Height = 16
      Caption = 'Stunden'
    end
    object Label4: TLabel
      Left = 368
      Top = 20
      Width = 52
      Height = 16
      Caption = 'Minuten'
    end
    object BDarstellung: TButton
      Left = 504
      Top = 14
      Width = 100
      Height = 25
      Caption = 'Darstellen'
      TabOrder = 10
      OnClick = BDarstellungClick
    end
    object BSimulation: TButton
      Left = 616
      Top = 14
      Width = 100
      Height = 25
      Caption = 'Simulation'
      TabOrder = 11
      OnClick = BSimulationClick
    end
    object BAktuell: TButton
      Left = 616
      Top = 48
      Width = 100
      Height = 25
      Caption = 'Aktuelle Zeit'
      TabOrder = 12
      OnClick = BAktuellClick
    end
    object ETag: TEdit
      Left = 56
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 0
    end
    object EMonat: TEdit
      Left = 168
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 1
    end
    object EStunden: TEdit
      Left = 304
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 2
    end
    object EMinuten: TEdit
      Left = 432
      Top = 16
      Width = 49
      Height = 24
      TabOrder = 3
    end
    object RMinute: TRadioButton
      Left = 744
      Top = 16
      Width = 145
      Height = 17
      Caption = 'Minuten ver'#228'ndern'
      Checked = True
      TabOrder = 4
      TabStop = True
    end
    object RTag: TRadioButton
      Left = 744
      Top = 36
      Width = 129
      Height = 17
      Caption = 'Tage ver'#228'ndern'
      TabOrder = 5
    end
    object CSommerzeit: TCheckBox
      Left = 24
      Top = 52
      Width = 201
      Height = 17
      Caption = 'Sommerzeit ber'#252'cksichtigen'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = BDarstellungClick
    end
    object CSonnenOrt: TCheckBox
      Left = 240
      Top = 52
      Width = 97
      Height = 17
      Caption = 'Sonnenort'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = BDarstellungClick
    end
    object CAktuell: TCheckBox
      Left = 352
      Top = 52
      Width = 113
      Height = 17
      Caption = 'Aktualisieren'
      TabOrder = 8
      OnClick = CAktuellClick
    end
    object CGradNetz: TCheckBox
      Left = 472
      Top = 52
      Width = 97
      Height = 17
      Caption = 'Gradnetz'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CGradNetzClick
    end
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer2Timer
    Left = 8
    Top = 10
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 40
    Top = 10
  end
end
