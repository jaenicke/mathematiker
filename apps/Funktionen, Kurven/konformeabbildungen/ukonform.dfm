object fsortier: Tfsortier
  Left = 329
  Top = 71
  HelpContext = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Konforme Abbildungen'
  ClientHeight = 729
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object P4: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 729
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object konform: TPanel
      Left = 0
      Top = 0
      Width = 1008
      Height = 729
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object P34: TPanel
        Left = 0
        Top = 624
        Width = 1008
        Height = 105
        Align = alBottom
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object P47: TPanel
          Left = 0
          Top = 0
          Width = 369
          Height = 105
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object L41: TLabel
            Left = 16
            Top = 16
            Width = 42
            Height = 14
            Caption = 'F(Z) = '
          end
          object D24: TButton
            Left = 16
            Top = 48
            Width = 97
            Height = 25
            Caption = 'Darstellung'
            TabOrder = 8
            OnClick = D24C
          end
          object E18: TEdit
            Left = 64
            Top = 12
            Width = 121
            Height = 22
            CharCase = ecUpperCase
            TabOrder = 0
            Text = 'SIN(Z)'
          end
          object RB3: TRadioButton
            Left = 128
            Top = 50
            Width = 81
            Height = 17
            Caption = 'Halbkreis'
            TabOrder = 1
            OnClick = D24C
          end
          object RB4: TRadioButton
            Left = 216
            Top = 50
            Width = 57
            Height = 17
            Caption = 'Kreis'
            Checked = True
            TabOrder = 2
            TabStop = True
            OnClick = D24C
          end
          object RB5: TRadioButton
            Left = 304
            Top = 50
            Width = 81
            Height = 17
            Caption = 'Quadrat'
            TabOrder = 3
            OnClick = D24C
          end
          object RG3: TRadioGroup
            Left = 272
            Top = 8
            Width = 89
            Height = 55
            Caption = 'Bearbeiten'
            ItemIndex = 1
            Items.Strings = (
              'links'
              'rechts')
            TabOrder = 7
          end
          object RB6: TRadioButton
            Left = 128
            Top = 68
            Width = 73
            Height = 17
            Caption = 'Figur'
            TabOrder = 4
            OnClick = D24C
          end
          object Rb7: TRadioButton
            Left = 216
            Top = 68
            Width = 73
            Height = 17
            Caption = 'Figur 2'
            TabOrder = 5
            OnClick = D24C
          end
          object rb8: TRadioButton
            Left = 304
            Top = 68
            Width = 73
            Height = 17
            Caption = 'Figur 3'
            TabOrder = 6
            OnClick = D24C
          end
        end
        object P36: TPanel
          Left = 369
          Top = 0
          Width = 639
          Height = 105
          Align = alClient
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 1
          object L65: TLabel
            Left = 192
            Top = 48
            Width = 28
            Height = 14
            Caption = 'dx ='
          end
          object S46: TSpeedButton
            Left = 282
            Top = 57
            Width = 23
            Height = 24
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777700007000077777777770000700007007777777777777700700007070
              7777777777770707000070770777777777707707000077777077777777077777
              0000777777077777707777770000777777707777077777770000777777770770
              7777777700007777777777777777777700007777777777777777777700007777
              7777077077777777000077777770777707777777000077777707777770777777
              0000777770777777770777770000707707777777777077070000707077777777
              7777070700007007777777777777700700007000077777777700000700007777
              77777777777777770000}
            OnClick = S46C
          end
          object S47: TSpeedButton
            Left = 305
            Top = 57
            Width = 23
            Height = 24
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777700007777777777777777777700007777777700000077777700007777
              77770AAAAA0077770000777777770AAAAAA207770000777777770AAAAA2A2877
              000077777777000000A220770000777777777777780020770000777777777777
              7778007700007777770777777778007700007777700777777800207700007777
              0A00000000A2207700007770AAAAAAAAAA2A28770000770AAAAAAAAAAAA20777
              00007770AAAAAAAAAA007777000077770A000000007777770000777770077777
              7777777700007777770777777777777700007777777777777777777700007777
              77777777777777770000}
            OnClick = S47C
          end
          object S48: TSpeedButton
            Left = 328
            Top = 57
            Width = 23
            Height = 24
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777700007077777777777777770700007707777777777777707700007770
              7777777777770777000077770770777707707777000077777070777707077777
              0000777777007777007777770000777700007777000077770000777777777777
              7777777700007777777777777777777700007777777777777777777700007777
              7777777777777777000077770000777700007777000077777700777700777777
              0000777770707777070777770000777707707777077077770000777077777777
              7777077700007707777777777777707700007077777777777777770700007777
              77777777777777770000}
            OnClick = S48C
          end
          object D25: TButton
            Left = 169
            Top = 12
            Width = 97
            Height = 25
            Caption = 'Simulation'
            TabOrder = 3
            OnClick = D25C
          end
          object RG2: TRadioGroup
            Left = 9
            Top = 8
            Width = 145
            Height = 73
            Caption = 'Simulationsrichtung'
            ItemIndex = 0
            Items.Strings = (
              'waagerecht'
              'senkrecht'
              'kreisförmig')
            TabOrder = 0
          end
          object CL1: TCheckListBox
            Left = 280
            Top = 12
            Width = 153
            Height = 46
            OnClickCheck = D24C
            BorderStyle = bsNone
            Color = 15790320
            ItemHeight = 14
            Items.Strings = (
              'Punkt'
              'Koordinatensystem'
              'Punktstrahlen')
            TabOrder = 1
          end
          object Rx13: TRxSpinEdit
            Left = 224
            Top = 48
            Width = 40
            Height = 19
            EditorEnabled = False
            MaxValue = 25
            MinValue = 1
            Value = 5
            BorderStyle = bsNone
            Color = 15790320
            TabOrder = 2
            OnChange = D24C
          end
        end
      end
      object P46: TPanel
        Left = 0
        Top = 0
        Width = 1008
        Height = 624
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        OnResize = P46Resize
        object P43: TPanel
          Left = 0
          Top = 0
          Width = 369
          Height = 624
          Align = alLeft
          Color = clWhite
          TabOrder = 0
          object PB12: TPaintBox
            Left = 1
            Top = 1
            Width = 367
            Height = 622
            Align = alClient
            OnMouseDown = PB12MD
            OnMouseMove = PB12MM
            OnMouseUp = PB12MU
            OnPaint = PB12P
          end
        end
        object P45: TPanel
          Left = 369
          Top = 0
          Width = 639
          Height = 624
          Align = alClient
          Color = clWhite
          TabOrder = 1
          object PB13: TPaintBox
            Left = 1
            Top = 1
            Width = 637
            Height = 622
            Align = alClient
            OnPaint = PB13P
          end
        end
      end
    end
  end
  object MM1: TMainMenu
    Left = 136
    Top = 40
    object M5: TMenuItem
      Caption = 'M'
      ShortCut = 13
      Visible = False
      OnClick = x1C
    end
  end
  object Timer5: TTimer
    Enabled = False
    Interval = 20
    OnTimer = Timer5Timer
    Left = 824
    Top = 4
  end
end
