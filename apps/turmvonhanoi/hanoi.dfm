object fhano: tfhano
  Left = 212
  Top = 38
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Turm von Hanoi'
  ClientHeight = 684
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object p1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 684
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object PB1: TPaintBox
      Left = 193
      Top = 0
      Width = 815
      Height = 684
      Align = alClient
      OnMouseDown = PB1MouseDown
      OnPaint = PB1Paint
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 193
      Height = 684
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 425
        Align = alTop
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object p2L5: TLabel
          Left = 104
          Top = 118
          Width = 8
          Height = 14
          Caption = '0'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object L1: TLabel
          Left = 16
          Top = 44
          Width = 57
          Height = 14
          Caption = 'Scheiben'
        end
        object L3: TLabel
          Left = 16
          Top = 406
          Width = 50
          Height = 14
          Caption = 'Zugliste'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object L4: TLabel
          Left = 104
          Top = 140
          Width = 4
          Height = 14
        end
        object L5: TLabel
          Left = 16
          Top = 118
          Width = 32
          Height = 14
          Caption = 'Züge'
        end
        object L6: TLabel
          Left = 16
          Top = 140
          Width = 50
          Height = 14
          Caption = 'Zeit in s'
        end
        object L2: TLabel
          Left = 16
          Top = 96
          Width = 79
          Height = 14
          Caption = 'Gesamtzüge'
        end
        object L7: TLabel
          Left = 104
          Top = 96
          Width = 12
          Height = 14
          Caption = '...'
        end
        object Anteil: TLabel
          Left = 16
          Top = 162
          Width = 67
          Height = 14
          Caption = 'Anteil in %'
        end
        object L9: TLabel
          Left = 104
          Top = 162
          Width = 4
          Height = 14
        end
        object L8: TLabel
          Left = 16
          Top = 16
          Width = 85
          Height = 14
          Caption = 'Einstellungen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object L10: TLabel
          Left = 16
          Top = 324
          Width = 80
          Height = 14
          Caption = 'Verzögerung'
        end
        object L11: TLabel
          Left = 14
          Top = 228
          Width = 149
          Height = 42
          Caption = 
            'Zum Umlegen einer '#13#10'Scheibe Ausgangssäule'#13#10'und Zielsäule anklick' +
            'en'
        end
        object L12: TLabel
          Left = 16
          Top = 72
          Width = 53
          Height = 14
          Caption = 'Stangen'
        end
        object c12: TCheckBox
          Left = 24
          Top = 376
          Width = 137
          Height = 17
          Caption = 'Zugliste anzeigen'
          TabOrder = 0
        end
        object CB1: TCheckBox
          Left = 24
          Top = 356
          Width = 145
          Height = 17
          Caption = 'Umlegen animieren'
          TabOrder = 1
        end
        object R1: TRadioButton
          Left = 88
          Top = 72
          Width = 32
          Height = 17
          Caption = '3 '
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = R1Click
        end
        object R2: TRadioButton
          Left = 128
          Top = 72
          Width = 32
          Height = 17
          Caption = '4 '
          TabOrder = 3
          OnClick = R1Click
        end
        object Button1: TButton
          Left = 32
          Top = 192
          Width = 121
          Height = 25
          Caption = 'Zurücksetzen'
          TabOrder = 4
          OnClick = D1Click
        end
        object Button2: TButton
          Left = 32
          Top = 280
          Width = 121
          Height = 25
          Caption = 'Lösung'
          TabOrder = 5
          OnClick = D2Click
        end
        object UpDown1: TUpDown
          Left = 145
          Top = 40
          Width = 17
          Height = 22
          Associate = Edit1
          Min = 3
          Max = 36
          Position = 5
          TabOrder = 6
          Thousands = False
          Wrap = False
          OnClick = UpDown1Click
        end
        object Edit1: TEdit
          Left = 104
          Top = 40
          Width = 41
          Height = 22
          TabOrder = 7
          Text = '5'
        end
        object Edit2: TEdit
          Left = 104
          Top = 320
          Width = 41
          Height = 22
          TabOrder = 8
          Text = '2'
        end
        object UpDown2: TUpDown
          Left = 145
          Top = 320
          Width = 16
          Height = 22
          Associate = Edit2
          Min = -1
          Max = 20
          Position = 2
          TabOrder = 9
          Wrap = False
          OnClick = UpDown1Click
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 425
        Width = 193
        Height = 259
        Align = alClient
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 1
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 12
          Height = 259
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
        end
        object lb2: TListBox
          Left = 12
          Top = 0
          Width = 181
          Height = 252
          Align = alClient
          BorderStyle = bsNone
          Color = 15790320
          IntegralHeight = True
          ItemHeight = 14
          TabOrder = 1
          TabWidth = 32
          OnClick = lb2Click
        end
      end
    end
  end
end
