object fwator: Tfwator
  Left = 241
  Top = 47
  HelpContext = 777
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Wator-Simulation'
  ClientHeight = 550
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = PB1P
  PixelsPerInch = 96
  TextHeight = 14
  object Panel3: TPanel
    Left = 569
    Top = 0
    Width = 202
    Height = 550
    Align = alRight
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object wator: TPanel
      Left = 0
      Top = 0
      Width = 202
      Height = 550
      Align = alClient
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Label8: TLabel
        Left = 16
        Top = 128
        Width = 136
        Height = 14
        Caption = 'Anfangseinstellungen'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 88
        Top = 150
        Width = 87
        Height = 14
        Caption = 'Fische     Haie'
      end
      object L10: TLabel
        Left = 16
        Top = 172
        Width = 52
        Height = 14
        Caption = '% Anteil'
      end
      object L11: TLabel
        Left = 16
        Top = 196
        Width = 49
        Height = 14
        Caption = 'Brutzeit'
      end
      object L12: TLabel
        Left = 16
        Top = 220
        Width = 66
        Height = 14
        Caption = 'Fastenzeit'
      end
      object Label4: TLabel
        Left = 24
        Top = 308
        Width = 81
        Height = 14
        Caption = 'Verzögerung'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 16
        Top = 40
        Width = 53
        Height = 14
        Caption = 'Spielfeld'
      end
      object Label7: TLabel
        Left = 16
        Top = 16
        Width = 70
        Height = 14
        Caption = 'Chrononen'
      end
      object Label1: TLabel
        Left = 16
        Top = 64
        Width = 39
        Height = 14
        Caption = 'Fische'
      end
      object Label2: TLabel
        Left = 16
        Top = 88
        Width = 28
        Height = 14
        Caption = 'Haie'
      end
      object Label3: TLabel
        Left = 24
        Top = 340
        Width = 75
        Height = 14
        Caption = 'Schrittweite'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Edit3: TEdit
        Left = 80
        Top = 168
        Width = 49
        Height = 22
        TabOrder = 0
        Text = '50'
        OnChange = E10C
      end
      object Edit4: TEdit
        Left = 136
        Top = 168
        Width = 49
        Height = 22
        TabOrder = 1
        Text = '3'
        OnChange = E10C
      end
      object Edit5: TEdit
        Left = 80
        Top = 192
        Width = 49
        Height = 22
        TabOrder = 2
        Text = '6'
        OnChange = E10C
      end
      object Edit6: TEdit
        Left = 136
        Top = 192
        Width = 49
        Height = 22
        TabOrder = 3
        Text = '12'
        OnChange = E10C
      end
      object Edit7: TEdit
        Left = 136
        Top = 216
        Width = 49
        Height = 22
        TabOrder = 4
        Text = '3'
        OnChange = E10C
      end
      object C2: TCheckBox
        Left = 16
        Top = 248
        Width = 137
        Height = 17
        Caption = 'Spielvariante 2'
        TabOrder = 5
      end
      object C3: TCheckBox
        Left = 16
        Top = 272
        Width = 177
        Height = 17
        Caption = 'Stop bei Aussterben'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object Edit1: TEdit
        Left = 112
        Top = 304
        Width = 41
        Height = 22
        TabOrder = 7
        Text = '0'
        OnChange = T2Change
      end
      object UpDown1: TUpDown
        Left = 153
        Top = 304
        Width = 16
        Height = 22
        Associate = Edit1
        Min = 0
        Max = 20
        Position = 0
        TabOrder = 8
        Wrap = False
      end
      object Edit2: TEdit
        Left = 112
        Top = 336
        Width = 41
        Height = 22
        TabOrder = 9
        Text = '1'
        OnChange = E10C
      end
      object UpDown2: TUpDown
        Left = 153
        Top = 336
        Width = 16
        Height = 22
        Associate = Edit2
        Min = 1
        Position = 1
        TabOrder = 10
        Wrap = False
      end
      object Button1: TButton
        Left = 24
        Top = 384
        Width = 145
        Height = 25
        Caption = 'Simulation (F2)'
        TabOrder = 11
        OnClick = button1click
      end
      object Button2: TButton
        Left = 24
        Top = 416
        Width = 145
        Height = 25
        Caption = 'Einzelschritt'
        TabOrder = 12
        OnClick = button2click
      end
      object Button3: TButton
        Left = 24
        Top = 464
        Width = 145
        Height = 25
        Caption = 'Ausgangssituation'
        TabOrder = 13
        OnClick = button3click
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 550
    Align = alClient
    BevelOuter = bvNone
    Color = clBlack
    TabOrder = 1
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 569
      Height = 550
      Align = alClient
      BevelOuter = bvNone
      BevelWidth = 2
      Color = clWhite
      TabOrder = 0
      OnResize = Panel1Resize
      object PB1: TPaintBox
        Left = 0
        Top = 0
        Width = 569
        Height = 550
        Align = alClient
        OnPaint = PB1P
      end
    end
  end
  object MM1: TMainMenu
    Left = 8
    Top = 12
    object M2: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      OnClick = S7Click
    end
    object M3: TMenuItem
      Caption = 'Steuerung'
      object M15: TMenuItem
        Caption = 'Simulation'
        ShortCut = 113
        OnClick = button1click
      end
      object M4: TMenuItem
        Caption = 'Einzelschritt'
        ShortCut = 32
        OnClick = button2click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object M11: TMenuItem
        Caption = 'Spielfeld löschen'
        OnClick = S8Click
      end
      object M14: TMenuItem
        Caption = 'zufällige Ausgangsposition'
        OnClick = button3click
      end
      object M18: TMenuItem
        Caption = 'Hilfslinien'
        Checked = True
        OnClick = S2C
      end
    end
  end
end
