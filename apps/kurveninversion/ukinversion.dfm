object Form1: TForm1
  Left = 158
  Top = 16
  Width = 1017
  Height = 744
  HelpContext = 107
  Caption = 'Kurveninversion'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1001
    Height = 26
    Align = alTop
    Caption = 'Kurveninversion am Kreis'
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    object TB3: TToolBar
      Left = 1
      Top = 1
      Width = 144
      Height = 24
      Align = alLeft
      ButtonHeight = 23
      Color = 15790320
      EdgeBorders = []
      ParentColor = False
      TabOrder = 0
      object P3: TPanel
        Left = 0
        Top = 2
        Width = 8
        Height = 23
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
      end
      object S1: TSpeedButton
        Left = 8
        Top = 2
        Width = 24
        Height = 23
        Hint = 'Millimeternetz ein- und ausschalten'
        Flat = True
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC000000C40E0000C40E00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFF0000000FFF3FF3FF3FF3FFFF0000000FF3333333333333FF0000000FFF3
          FF3FF3FF3FFFF0000000FFF3FF3FF3FF3FFFF0000000FF3333333333333FF000
          0000FFF3FF3FF3FF3FFFF0000000FFF3FF3FF3FF3FFFF0000000FF3333333333
          333FF0000000FFF3FF3FF3FF3FFFF0000000FFF3FF3FF3FF3FFFF0000000FF33
          33333333333FF0000000FFF3FF3FF3FF3FFFF0000000FFF3FF3FF3FF3FFFF000
          0000FF3333333333333FF0000000FFF3FF3FF3FF3FFFF0000000FFFFFFFFFFFF
          FFFFF0000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = S1Click
      end
      object S2: TSpeedButton
        Left = 32
        Top = 2
        Width = 24
        Height = 23
        Hint = 'Gitternetz ein- und ausschalten'
        Flat = True
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC000000C40E0000C40E00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFF0000000FFF0FFFF0FFFF0FFF0000000FF0000000000000FF0000000FFF0
          FFFF0FFFF0FFF0000000FFF0FFFF0FFFF0FFF0000000FFF0FFFF0FFFF0FFF000
          0000FFF0FFFF0FFFF0FFF0000000FFF0FFFF0FFFF0FFF0000000FF0000000000
          000FF0000000FFF0FFFF0FFFF0FFF0000000FFF0FFFF0FFFF0FFF0000000FFF0
          FFFF0FFFF0FFF0000000FFF0FFFF0FFFF0FFF0000000FFF0FFFF0FFFF0FFF000
          0000FF0000000000000FF0000000FFF0FFFF0FFFF0FFF0000000FFFFFFFFFFFF
          FFFFF0000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = S36C
      end
      object S3: TSpeedButton
        Left = 56
        Top = 2
        Width = 23
        Height = 23
        Hint = 'Intervall verkleinern'
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
        ParentShowHint = False
        ShowHint = True
        OnClick = S3Click
      end
      object S4: TSpeedButton
        Left = 79
        Top = 2
        Width = 23
        Height = 23
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0FFFFFFFFFFFFF0000FFFF
          F00FFFFFFFFFFFFF0000FFFF0700000000FFFFFF0000FFF0777777777700FFFF
          0000FF077777777777720FFF0000FFF077777777772728FF0000FFFF07000000
          007220FF0000FFFFF00FFFFFF80020FF0000FFFFFF0FFFFFFFF800FF0000FFFF
          FFFFFFFFFFF800FF0000FFFFFFFFFFFFF80020FF0000FFFFFFFF0000007220FF
          0000FFFFFFFF0777772728FF0000FFFFFFFF077777720FFF0000FFFFFFFF0777
          7700FFFF0000FFFFFFFF000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFF0000}
        OnClick = S4Click
      end
      object S5: TSpeedButton
        Left = 102
        Top = 2
        Width = 23
        Height = 23
        Hint = 'Intervall vergrößern'
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
        ParentShowHint = False
        ShowHint = True
        OnClick = S5Click
      end
    end
  end
  object kinversion: TPanel
    Left = 0
    Top = 26
    Width = 1001
    Height = 682
    Hint = '0'
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object paintbox1: TPaintBox
      Left = 0
      Top = 0
      Width = 784
      Height = 682
      Align = alClient
      OnMouseDown = PB5D
      OnMouseMove = PB5M
      OnMouseUp = PB5U
      OnPaint = PB5P
    end
    object P18: TPanel
      Left = 784
      Top = 0
      Width = 217
      Height = 682
      Align = alRight
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object P19: TPanel
        Left = 0
        Top = 377
        Width = 217
        Height = 305
        Align = alClient
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Listbox1: TListBox
          Left = 8
          Top = 25
          Width = 201
          Height = 280
          TabStop = False
          Align = alClient
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          IntegralHeight = True
          ItemHeight = 14
          ParentFont = False
          Sorted = True
          TabOrder = 0
          OnClick = LB5C
        end
        object Label14: TPanel
          Left = 0
          Top = 0
          Width = 217
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Kurvenbibliothek'
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object P28: TPanel
          Left = 0
          Top = 25
          Width = 8
          Height = 280
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 2
        end
        object P30: TPanel
          Left = 209
          Top = 25
          Width = 8
          Height = 280
          Align = alRight
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 3
        end
      end
      object P26: TPanel
        Left = 0
        Top = 0
        Width = 217
        Height = 377
        Align = alTop
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 16
          Width = 39
          Height = 14
          Caption = 'Kurve'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 68
          Width = 60
          Height = 14
          Caption = 'X = f(K) ='
        end
        object Label3: TLabel
          Left = 8
          Top = 92
          Width = 59
          Height = 14
          Caption = 'Y = f(K) ='
        end
        object Label4: TLabel
          Left = 40
          Top = 116
          Width = 78
          Height = 14
          Caption = 'Parameter P'
        end
        object Label9: TLabel
          Left = 16
          Top = 280
          Width = 103
          Height = 14
          Caption = 'Kreisparameter'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 24
          Top = 304
          Width = 94
          Height = 14
          Alignment = taRightJustify
          Caption = 'Mittelpunkt x ='
        end
        object Label11: TLabel
          Left = 98
          Top = 328
          Width = 20
          Height = 14
          Alignment = taRightJustify
          Caption = 'y ='
        end
        object Label12: TLabel
          Left = 74
          Top = 352
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Radius'
        end
        object Label5: TLabel
          Left = 32
          Top = 140
          Width = 23
          Height = 14
          Caption = 'von'
        end
        object Label6: TLabel
          Left = 120
          Top = 140
          Width = 18
          Height = 14
          Caption = 'bis'
        end
        object Label7: TLabel
          Left = 119
          Top = 211
          Width = 9
          Height = 19
          Caption = 'D'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 128
          Top = 214
          Width = 13
          Height = 14
          Caption = ' ='
        end
        object Label13: TLabel
          Left = 16
          Top = 248
          Width = 62
          Height = 14
          Caption = 'Animation'
        end
        object Edit1: TEdit
          Left = 72
          Top = 64
          Width = 136
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 0
          Text = 'SIN(K+P)'
        end
        object Edit2: TEdit
          Left = 72
          Top = 88
          Width = 136
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 1
          Text = '2*COS(K)'
        end
        object EditP: TEdit
          Left = 128
          Top = 112
          Width = 80
          Height = 22
          TabOrder = 2
          Text = '1'
        end
        object E22: TEdit
          Left = 128
          Top = 348
          Width = 80
          Height = 22
          TabOrder = 3
          Text = '2'
        end
        object E23: TEdit
          Left = 128
          Top = 324
          Width = 80
          Height = 22
          TabOrder = 4
          Text = '0'
        end
        object E24: TEdit
          Left = 128
          Top = 300
          Width = 80
          Height = 22
          TabOrder = 5
          Text = '0'
        end
        object EditA: TEdit
          Left = 64
          Top = 136
          Width = 49
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 6
          Text = '-PI'
        end
        object EditE: TEdit
          Left = 152
          Top = 136
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 7
          Text = 'PI'
        end
        object Rx12: TRxSpinEdit
          Left = 144
          Top = 214
          Width = 57
          Height = 19
          EditorEnabled = False
          Increment = 0.01
          MaxValue = 1
          MinValue = -1
          ValueType = vtFloat
          Value = 0.01
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object B2: TButton
          Left = 16
          Top = 208
          Width = 89
          Height = 25
          Caption = 'Animation'
          TabOrder = 9
          OnClick = D10C
        end
        object B1: TButton
          Left = 16
          Top = 168
          Width = 185
          Height = 25
          Caption = 'Darstellung'
          Default = True
          TabOrder = 10
          OnClick = PB5P
        end
        object RadioButton1: TRadioButton
          Left = 72
          Top = 16
          Width = 140
          Height = 17
          Caption = 'Parameterform'
          Checked = True
          TabOrder = 11
          TabStop = True
          OnClick = G3C
        end
        object RadioButton2: TRadioButton
          Left = 72
          Top = 36
          Width = 140
          Height = 17
          Caption = 'Polarkoordinaten'
          TabOrder = 12
          OnClick = G3C
        end
        object ComboBox1: TComboBox
          Left = 96
          Top = 244
          Width = 113
          Height = 22
          TabStop = False
          ItemHeight = 14
          TabOrder = 13
          Text = 'Parameter'
          Items.Strings = (
            'Parameter'
            'Kreisradius'
            'M waagerecht'
            'M senkrecht')
        end
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 20
    OnTimer = Timer1Timer
    Left = 312
    Top = 32
  end
end
