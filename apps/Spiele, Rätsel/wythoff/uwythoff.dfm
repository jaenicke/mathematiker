object frmwythoff: Tfrmwythoff
  Left = 337
  Top = 76
  HelpContext = 798
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Wythoff-Spiel'
  ClientHeight = 679
  ClientWidth = 901
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 721
    Top = 0
    Width = 180
    Height = 679
    Align = alRight
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 70
      Width = 53
      Height = 14
      Caption = 'Spielfeld'
    end
    object Label2: TLabel
      Left = 16
      Top = 152
      Width = 81
      Height = 16
      Caption = 'Spielregeln'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 368
      Width = 57
      Height = 16
      Caption = 'Zugfolge'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 24
      Top = 24
      Width = 129
      Height = 25
      Caption = 'Neues Spiel'
      Default = True
      TabOrder = 4
      OnClick = NewGame
    end
    object Me1: TMemo
      Left = 8
      Top = 176
      Width = 161
      Height = 185
      TabStop = False
      BorderStyle = bsNone
      Color = 15790320
      Lines.Strings = (
        'Abwechselnd ziehen Sie '
        'und der Computer den '
        'Spielstein beliebig weit '
        'waagerecht, senkrecht '
        'oder diagonal.'
        'Eine Zug f'#252'hren Sie '
        'durch, in dem Sie ein '
        'freies Feld anklicken.'
        ''
        'Wer das linke untere '
        'Feld erreicht, hat '
        'gewonnen.')
      ReadOnly = True
      TabOrder = 0
    end
    object Check1: TCheckBox
      Left = 12
      Top = 104
      Width = 137
      Height = 17
      Caption = 'Computer beginnt'
      TabOrder = 1
    end
    object Check2: TCheckBox
      Left = 12
      Top = 124
      Width = 161
      Height = 17
      Caption = 'Richtungen anzeigen'
      TabOrder = 2
      OnClick = pb1Paint
    end
    object LB1: TListBox
      Left = 16
      Top = 392
      Width = 145
      Height = 217
      ItemHeight = 14
      TabOrder = 3
      TabWidth = 40
    end
    object Spin1: TSpinEdit
      Left = 96
      Top = 64
      Width = 60
      Height = 23
      MaxValue = 26
      MinValue = 8
      TabOrder = 5
      Value = 25
      OnChange = NewGame
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 721
    Height = 679
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object pb1: TPaintBox
      Left = 0
      Top = 0
      Width = 721
      Height = 679
      Align = alClient
      OnMouseDown = pb1MouseDown
      OnMouseMove = pb1MouseMove
      OnPaint = pb1Paint
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 48
    Top = 32
  end
end
