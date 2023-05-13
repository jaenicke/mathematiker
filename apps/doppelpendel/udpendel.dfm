object Form1: TForm1
  Left = 124
  Top = 11
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Chaos-Doppelpendel '
  ClientHeight = 693
  ClientWidth = 1075
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
  PixelsPerInch = 96
  TextHeight = 16
  object paintbox1: TPaintBox
    Left = 169
    Top = 0
    Width = 642
    Height = 693
    Align = alClient
    OnPaint = d1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 693
    Align = alLeft
    Color = 15790320
    TabOrder = 0
    object L1: TLabel
      Left = 16
      Top = 16
      Width = 66
      Height = 14
      Caption = 'Parameter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object L2: TLabel
      Left = 16
      Top = 40
      Width = 56
      Height = 16
      Caption = 'Pendel 1'
    end
    object L12: TLabel
      Left = 16
      Top = 90
      Width = 41
      Height = 16
      Caption = 'dW/dt'
    end
    object L9: TLabel
      Left = 16
      Top = 64
      Width = 54
      Height = 16
      Caption = 'Winkel °'
    end
    object L10: TLabel
      Left = 16
      Top = 120
      Width = 56
      Height = 16
      Caption = 'Pendel 2'
    end
    object L11: TLabel
      Left = 16
      Top = 170
      Width = 41
      Height = 16
      Caption = 'dW/dt'
    end
    object L3: TLabel
      Left = 16
      Top = 144
      Width = 54
      Height = 16
      Caption = 'Winkel °'
    end
    object L5: TLabel
      Left = 16
      Top = 216
      Width = 54
      Height = 16
      Caption = 'Intervall'
    end
    object L6: TLabel
      Left = 16
      Top = 280
      Width = 50
      Height = 16
      Caption = 'Zeit (s)'
    end
    object L7: TLabel
      Left = 88
      Top = 280
      Width = 5
      Height = 16
    end
    object L13: TLabel
      Left = 20
      Top = 520
      Width = 131
      Height = 56
      Caption = 
        'Das 2.Doppelpendel '#13#10'wird mit extended '#13#10'berechnet,'#13#10'das erste m' +
        'it real.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 248
      Width = 65
      Height = 16
      Caption = 'Spurlänge'
    end
    object Label2: TLabel
      Left = 20
      Top = 424
      Width = 131
      Height = 56
      Caption = 
        'Das 2.Doppelpendel '#13#10'hat eine um 0,001'#13#10'höhere Winkel-'#13#10'geschwin' +
        'digkeit.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object E1: TEdit
      Left = 80
      Top = 86
      Width = 72
      Height = 24
      TabOrder = 1
      Text = '1'
      OnChange = d1Click
    end
    object E2: TEdit
      Left = 80
      Top = 60
      Width = 72
      Height = 24
      TabOrder = 0
      Text = '45'
      OnChange = d1Click
    end
    object E4: TEdit
      Left = 80
      Top = 166
      Width = 72
      Height = 24
      TabOrder = 3
      Text = '0'
      OnChange = d1Click
    end
    object E5: TEdit
      Left = 80
      Top = 140
      Width = 72
      Height = 24
      TabOrder = 2
      Text = '135'
      OnChange = d1Click
    end
    object E7: TEdit
      Left = 88
      Top = 212
      Width = 49
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 4
      Text = '10'
    end
    object czwei: TCheckBox
      Left = 16
      Top = 308
      Width = 129
      Height = 17
      Caption = '2.Doppelpendel'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object d2: TButton
      Left = 24
      Top = 360
      Width = 113
      Height = 25
      Caption = 'Simulation'
      Default = True
      TabOrder = 6
      OnClick = d2Click
    end
    object UpDown1: TUpDown
      Left = 137
      Top = 212
      Width = 16
      Height = 24
      Associate = E7
      Min = 5
      Max = 40
      Position = 10
      TabOrder = 7
      Wrap = False
    end
    object Edit1: TEdit
      Left = 88
      Top = 244
      Width = 49
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 8
      Text = '250'
    end
    object UpDown2: TUpDown
      Left = 137
      Top = 244
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 25
      Max = 1000
      Increment = 25
      Position = 250
      TabOrder = 9
      Wrap = False
    end
    object c_spur: TCheckBox
      Left = 16
      Top = 328
      Width = 113
      Height = 17
      Caption = 'Diagramme'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 400
      Width = 113
      Height = 17
      Caption = 'Variante 1'
      Checked = True
      TabOrder = 11
      TabStop = True
      OnClick = d1Click
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 496
      Width = 113
      Height = 17
      Caption = 'Variante 2'
      TabOrder = 12
      OnClick = d1Click
    end
  end
  object Panel2: TPanel
    Left = 811
    Top = 0
    Width = 264
    Height = 693
    Align = alRight
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 1
    OnResize = Panel2Resize
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 260
      Height = 230
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object PaintBox2: TPaintBox
        Left = 0
        Top = 24
        Width = 260
        Height = 206
        Align = alClient
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 260
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Doppelpendel 1'
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel5: TPanel
      Left = 2
      Top = 232
      Width = 260
      Height = 459
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object PaintBox3: TPaintBox
        Left = 0
        Top = 24
        Width = 260
        Height = 435
        Align = alClient
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 260
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Doppelpendel 2'
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
end
