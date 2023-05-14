object FGraf: TFGraf
  Left = 185
  Top = 22
  Width = 1058
  Height = 745
  HelpContext = 100
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Grafische Darstellung von Funktionen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 1042
    Height = 686
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel6: TPanel
      Left = 846
      Top = 0
      Width = 196
      Height = 686
      Align = alRight
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 196
        Height = 70
        Align = alTop
        BevelOuter = bvNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object slinks: TSpeedButton
          Left = 18
          Top = 33
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            04000000000070000000130B0000130B0000100000001000000000000000FFFF
            0000F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00222222222222
            2200222222222222220022222022222222002222002222222200222010222222
            2200220110000000020020111111111102002011111111110200220110000000
            0200222010222222220022220022222222002222202222222200222222222222
            22002222222222222200}
          OnClick = slinksClick
        end
        object srechts: TSpeedButton
          Left = 62
          Top = 33
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            04000000000070000000130B0000130B0000100000001000000000000000FFFF
            0000F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00222222222222
            2200222222222222220022222222022222002222222200222200222222220102
            2200200000000110220020111111111102002011111111110200200000000110
            2200222222220102220022222222002222002222222202222200222222222222
            22002222222222222200}
          OnClick = srechtsClick
        end
        object shoch: TSpeedButton
          Left = 40
          Top = 24
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            04000000000070000000130B0000130B0000100000001000000000000000FFFF
            0000F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00222222222222
            2200222220000222220022222011022222002222201102222200222220110222
            2200222220110222220022222011022222002222201102222200220000110000
            2200222011111102220022220111102222002222201102222200222222002222
            22002222222222222200}
          OnClick = shochClick
        end
        object srunter: TSpeedButton
          Left = 40
          Top = 46
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            04000000000070000000130B0000130B0000100000001000000000000000FFFF
            0000F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00222222222222
            2200222222002222220022222011022222002222011110222200222011111102
            2200220000110000220022222011022222002222201102222200222220110222
            2200222220110222220022222011022222002222201102222200222220000222
            22002222222222222200}
          OnClick = srunterClick
        end
        object sgroesser: TSpeedButton
          Left = 96
          Top = 33
          Width = 23
          Height = 22
          Hint = 'Intervall Zoom In'
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
          OnClick = sgroesserClick
        end
        object skleiner: TSpeedButton
          Left = 120
          Top = 33
          Width = 23
          Height = 22
          Hint = 'Intervall Zoom out'
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
          OnClick = SkleinerClick
        end
        object Label12: TLabel
          Left = 16
          Top = 8
          Width = 122
          Height = 14
          Caption = 'Koordinatensystem'
        end
        object sgrundeinstellung: TSpeedButton
          Left = 144
          Top = 33
          Width = 23
          Height = 22
          Hint = 'Zur'#252'cksetzen'
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777777777777777777777777777777777777777777777777777777777777
            7777777777777778477777444447777748777744447777777477774447777777
            7477774474777777747777477744777748777777777744448777777777777777
            7777777777777777777777777777777777777777777777777777}
          ParentShowHint = False
          ShowHint = True
          OnClick = SgrundClick
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 70
        Width = 196
        Height = 616
        Align = alClient
        BevelOuter = bvNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label9: TLabel
          Left = 16
          Top = 440
          Width = 77
          Height = 13
          Caption = 'von          bis'
        end
        object Label11: TLabel
          Left = 145
          Top = 250
          Width = 38
          Height = 13
          Caption = ';       )'
        end
        object Label10: TLabel
          Left = 145
          Top = 274
          Width = 38
          Height = 13
          Caption = ';       )'
        end
        object Label13: TLabel
          Left = 104
          Top = 335
          Width = 13
          Height = 13
          Caption = '= '
        end
        object Label2: TLabel
          Left = 16
          Top = 16
          Width = 74
          Height = 13
          Caption = 'Graph-Breite'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 88
          Top = 140
          Width = 33
          Height = 13
          Caption = '< x <'
        end
        object Label1: TLabel
          Left = 8
          Top = 140
          Width = 17
          Height = 13
          Caption = 'DB'
        end
        object Label8: TLabel
          Left = 16
          Top = 176
          Width = 88
          Height = 13
          Caption = 'Parameter P = '
        end
        object Label14: TLabel
          Left = 39
          Top = 355
          Width = 56
          Height = 13
          Caption = 'Fl'#228'che AB'
        end
        object Label15: TLabel
          Left = 104
          Top = 355
          Width = 13
          Height = 13
          Caption = '= '
        end
        object Label16: TLabel
          Left = 138
          Top = 437
          Width = 8
          Height = 16
          Caption = 'D'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 16
          Top = 200
          Width = 90
          Height = 13
          Caption = 'Parameter Q = '
        end
        object ed_von: TEdit
          Left = 42
          Top = 436
          Width = 32
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          Text = '-6'
        end
        object ed_bis: TEdit
          Left = 98
          Top = 436
          Width = 32
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Text = '6'
        end
        object b_animation: TButton
          Left = 14
          Top = 394
          Width = 80
          Height = 25
          Caption = 'Animation'
          TabOrder = 1
          OnClick = b_animationClick
        end
        object c_punktA: TCheckBox
          Left = 12
          Top = 248
          Width = 74
          Height = 17
          Caption = 'Punkt A ('
          TabOrder = 18
          OnClick = PaintBox1Paint
        end
        object ed_A: TEdit
          Left = 84
          Top = 246
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 19
          Text = '1'
        end
        object rb_punkta: TRadioButton
          Left = 104
          Top = 380
          Width = 81
          Height = 17
          Caption = 'Punkt A'
          TabOrder = 2
        end
        object rb_parameter: TRadioButton
          Left = 104
          Top = 412
          Width = 113
          Height = 17
          Caption = 'Parameter'
          Checked = True
          TabOrder = 4
          TabStop = True
        end
        object c_normale: TCheckBox
          Left = 100
          Top = 296
          Width = 137
          Height = 17
          Caption = 'Normale A'
          TabOrder = 25
          OnClick = PaintBox1Paint
        end
        object c_punktB: TCheckBox
          Left = 12
          Top = 272
          Width = 74
          Height = 17
          Caption = 'Punkt B ('
          TabOrder = 21
          OnClick = PaintBox1Paint
        end
        object ed_B: TEdit
          Left = 84
          Top = 270
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 22
          Text = '0'
        end
        object c_tangente: TCheckBox
          Left = 12
          Top = 296
          Width = 88
          Height = 17
          Caption = 'Tangente A'
          TabOrder = 24
          OnClick = PaintBox1Paint
        end
        object c_sekante: TCheckBox
          Left = 12
          Top = 315
          Width = 93
          Height = 17
          Caption = 'Sekante AB'
          TabOrder = 26
          OnClick = PaintBox1Paint
        end
        object c_integral: TCheckBox
          Left = 12
          Top = 334
          Width = 85
          Height = 17
          Caption = 'Integral AB'
          TabOrder = 27
          OnClick = PaintBox1Paint
        end
        object c_1ableitung: TCheckBox
          Left = 12
          Top = 41
          Width = 85
          Height = 17
          Caption = '1.Ableitung'
          TabOrder = 9
          OnClick = PaintBox1Paint
        end
        object c_2ableitung: TCheckBox
          Left = 100
          Top = 41
          Width = 93
          Height = 17
          Caption = '2.Ableitung'
          TabOrder = 10
          OnClick = PaintBox1Paint
        end
        object c_stammfunktion: TCheckBox
          Left = 12
          Top = 95
          Width = 85
          Height = 17
          Caption = 'Stammfkt.'
          TabOrder = 13
          OnClick = PaintBox1Paint
        end
        object ed_breite: TEdit
          Left = 98
          Top = 11
          Width = 36
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Text = '1'
          OnChange = TB1Change
        end
        object UpDown1: TUpDown
          Left = 134
          Top = 11
          Width = 16
          Height = 21
          Associate = ed_breite
          Min = 1
          Max = 6
          Position = 1
          TabOrder = 8
        end
        object ed_xvon: TEdit
          Left = 40
          Top = 136
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          Text = '-1000'
        end
        object ed_xbis: TEdit
          Left = 128
          Top = 136
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          Text = '1000'
        end
        object ed_parameter: TEdit
          Left = 106
          Top = 171
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          Text = '1'
        end
        object b_zeichnen: TButton
          Left = 18
          Top = 540
          Width = 159
          Height = 25
          Caption = 'Zeichnen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = b_zeichnenClick
        end
        object c_nullstellen: TCheckBox
          Left = 12
          Top = 59
          Width = 97
          Height = 17
          Caption = 'Nullstellen'
          TabOrder = 11
          OnClick = PaintBox1Paint
        end
        object c_extrema: TCheckBox
          Left = 100
          Top = 59
          Width = 97
          Height = 17
          Caption = 'Extrema'
          TabOrder = 12
          OnClick = PaintBox1Paint
        end
        object UpDown2: TUpDown
          Left = 148
          Top = 169
          Width = 17
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 17
          OnChangingEx = UpDown2ChangingEx
        end
        object UpDown3: TUpDown
          Left = 125
          Top = 245
          Width = 17
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 20
          OnChangingEx = UpDown3ChangingEx
        end
        object UpDown4: TUpDown
          Left = 125
          Top = 269
          Width = 17
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 23
          OnChangingEx = UpDown4ChangingEx
        end
        object c_wendepunkte: TCheckBox
          Left = 12
          Top = 77
          Width = 85
          Height = 17
          Caption = 'Wendepkt.'
          TabOrder = 28
          OnClick = PaintBox1Paint
        end
        object ed_delta: TEdit
          Left = 152
          Top = 436
          Width = 32
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 29
          Text = '0,08'
        end
        object c_wendetangente: TCheckBox
          Left = 100
          Top = 77
          Width = 93
          Height = 17
          Caption = 'Wendetang.'
          TabOrder = 30
          OnClick = PaintBox1Paint
        end
        object c_schnittpunkte: TCheckBox
          Left = 12
          Top = 113
          Width = 85
          Height = 17
          Caption = 'Schnittpkt.'
          TabOrder = 31
          OnClick = PaintBox1Paint
        end
        object c_pktanzeige: TCheckBox
          Left = 100
          Top = 113
          Width = 93
          Height = 17
          Caption = 'Pkt-Anzeige'
          TabOrder = 32
          OnClick = PaintBox1Paint
        end
        object c_ergebnisliste: TCheckBox
          Left = 40
          Top = 576
          Width = 113
          Height = 17
          Caption = 'Ergebnisliste'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 33
          OnClick = Bergebnis
        end
        object rb_punktB: TRadioButton
          Left = 104
          Top = 396
          Width = 81
          Height = 17
          Caption = 'Punkt B'
          TabOrder = 3
        end
        object c_schar: TCheckBox
          Left = 12
          Top = 222
          Width = 125
          Height = 17
          Caption = 'Funktionsschar d ='
          TabOrder = 34
          OnClick = PaintBox1Paint
        end
        object ed_q: TEdit
          Left = 106
          Top = 195
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 35
          Text = '2'
        end
        object UpDown5: TUpDown
          Left = 148
          Top = 193
          Width = 17
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 36
          OnChangingEx = UpDown5ChangingEx
        end
        object ed_schardiff: TEdit
          Left = 144
          Top = 220
          Width = 32
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 37
          Text = '0,1'
        end
        object c_wertetabelle: TCheckBox
          Left = 12
          Top = 467
          Width = 173
          Height = 17
          Caption = 'Wertetabelle in Liste'
          TabOrder = 38
          OnClick = PaintBox1Paint
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 846
      Height = 686
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object PaintBox1: TPaintBox
        Left = 240
        Top = 0
        Width = 606
        Height = 597
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnMouseUp = PaintBox1MouseUp
        OnPaint = PaintBox1Paint
      end
      object Panel9: TPanel
        Left = 0
        Top = 597
        Width = 846
        Height = 89
        Align = alBottom
        BevelOuter = bvNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ed_f1: TEdit
          Left = 84
          Top = 12
          Width = 290
          Height = 24
          CharCase = ecUpperCase
          TabOrder = 0
          Text = 'X*SIN(X+P)'
        end
        object ed_f2: TEdit
          Left = 84
          Top = 44
          Width = 290
          Height = 24
          CharCase = ecUpperCase
          TabOrder = 1
          Text = 'X^2/4-2'
        end
        object ed_f3: TEdit
          Left = 456
          Top = 12
          Width = 290
          Height = 24
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object ed_f4: TEdit
          Left = 456
          Top = 44
          Width = 290
          Height = 24
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object button_fstrich: TButton
          Left = 752
          Top = 10
          Width = 48
          Height = 25
          Caption = 'f1'#39'(x)'
          TabOrder = 4
          OnClick = button_fstrichClick
        end
        object c_f1: TCheckBox
          Left = 12
          Top = 16
          Width = 65
          Height = 17
          Caption = 'f1(x) ='
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = b_zeichnenClick
        end
        object c_f2: TCheckBox
          Left = 12
          Top = 48
          Width = 65
          Height = 17
          Caption = 'f2(x) ='
          TabOrder = 6
          OnClick = b_zeichnenClick
        end
        object c_f3: TCheckBox
          Left = 384
          Top = 16
          Width = 65
          Height = 17
          Caption = 'f3(x) ='
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = b_zeichnenClick
        end
        object c_f4: TCheckBox
          Left = 384
          Top = 48
          Width = 65
          Height = 17
          Caption = 'f4(x) ='
          Checked = True
          State = cbChecked
          TabOrder = 8
          OnClick = b_zeichnenClick
        end
        object button_f2strich: TButton
          Left = 752
          Top = 42
          Width = 48
          Height = 25
          Caption = 'f1"(x)'
          TabOrder = 9
          OnClick = button_f2strichClick
        end
      end
      object Mergebnis: TMemo
        Left = 0
        Top = 0
        Width = 240
        Height = 597
        Align = alLeft
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        WordWrap = False
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 16
    object M02: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      OnClick = SEndeClick
    end
    object Bearbeiten1: TMenuItem
      Caption = 'Bearbeiten'
      object Vektorgrafikkopieren1: TMenuItem
        Caption = 'Vektorgrafik kopieren'
        OnClick = alsWMFkopieren1Click
      end
      object Vektorgrafikdrucken1: TMenuItem
        Caption = 'Vektorgrafik drucken'
        OnClick = GrafikdruckenClick
      end
      object Speichern1: TMenuItem
        Caption = 'Speichern'
        OnClick = Speichern1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object M1: TMenuItem
        Caption = 'Ergebnisliste kopieren'
        Enabled = False
        OnClick = ListekopierenClick
      end
    end
    object M_ksystem: TMenuItem
      Caption = 'Koordinatensystem'
      object MAchsen1: TMenuItem
        Caption = 'Achsen darstellen'
        Checked = True
        OnClick = Menueinstellungen
      end
      object MAchsen21: TMenuItem
        Caption = 'Achsen hervorheben'
        OnClick = Menueinstellungen
      end
      object M_rahmen: TMenuItem
        Caption = 'Koordinatenrahmen'
        OnClick = Menueinstellungen
      end
      object M_winkel: TMenuItem
        Caption = 'Winkelma'#223' auf x-Achse'
        OnClick = Menueinstellungen
      end
      object M_bogen: TMenuItem
        Caption = 'Bogenma'#223' auf x-Achse'
        OnClick = Menueinstellungen
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object m_raster: TMenuItem
        Caption = 'Raster'
        Checked = True
        OnClick = Menueinstellungen
      end
      object m_mmraster: TMenuItem
        Caption = 'mm-Raster'
        OnClick = Menueinstellungen
      end
      object m_terme: TMenuItem
        Caption = 'Funktionsterme anzeigen'
        Checked = True
        OnClick = Menueinstellungen
      end
      object m_farbe: TMenuItem
        Caption = 'farbige Funktionsgraphen'
        Checked = True
        OnClick = Menueinstellungen
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object intervallverkleinern: TMenuItem
        Caption = 'Darstellungsintervall verkleinern'
        OnClick = sgroesserClick
      end
      object intervallvergroessern: TMenuItem
        Caption = 'Darstellungsintervall vergr'#246#223'ern'
        OnClick = SkleinerClick
      end
      object grundeinstellung: TMenuItem
        Caption = 'Grundeinstellung'
        ShortCut = 32
        OnClick = SgrundClick
      end
      object aufloesunganpassen: TMenuItem
        Caption = 'y-Aufl'#246'sung anpassen'
        OnClick = S31Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Animation1: TMenuItem
        Caption = 'Animation'
        ShortCut = 113
        OnClick = b_animationClick
      end
      object Zeichnen1: TMenuItem
        Caption = 'Zeichnen'
        ShortCut = 13
        OnClick = b_zeichnenClick
      end
    end
    object M2: TMenuItem
      Caption = 'Sonderfunktionen'
      object spiegelungxachse: TMenuItem
        Caption = 'f1(-x) , Spiegelung  an der x-Achse'
        OnClick = Menueinstellungen
      end
      object spiegelungursprung: TMenuItem
        Caption = '-f1(-x) , Spiegelung am Ursprung'
        OnClick = Menueinstellungen
      end
      object spiegelungyachse: TMenuItem
        Caption = '-f1(x) , Spiegelung an der y-Achse'
        OnClick = Menueinstellungen
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object verschiebungxachse: TMenuItem
        Caption = 'f1(x+p) , Verschiebung um -p  l'#228'ngs der x-Achse'
        OnClick = Menueinstellungen
      end
      object streckungxachse: TMenuItem
        Caption = 'f1(p*x) , Streckung um p l'#228'ngs der x-Achse'
        OnClick = Menueinstellungen
      end
      object verschiebungyachse: TMenuItem
        Caption = 'f1(x)+p , Verschiebung um p l'#228'ngs der y-Achse'
        OnClick = Menueinstellungen
      end
      object streckungyachse: TMenuItem
        Caption = 'p*f1(x) , Streckung um p l'#228'ngs der y-Achse'
        OnClick = Menueinstellungen
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object nacheinanderausfuehrung: TMenuItem
        Caption = 'f1(f1(x)) , Nacheinanderausf'#252'hrung'
        OnClick = Menueinstellungen
      end
      object funktionsaddition: TMenuItem
        Caption = 'f1(x)+f2(x) , Addition der Funktionswerte'
        OnClick = Menueinstellungen
      end
      object funktionssubtraktion1: TMenuItem
        Caption = 'f1(x)-f2(x) , Subtraktion der Funktionswerte'
        OnClick = Menueinstellungen
      end
      object funktionsmultiplikation: TMenuItem
        Caption = 'f1(x)*f2(x) , Multiplikation der Funktionswerte'
        OnClick = Menueinstellungen
      end
      object funktionsdivision1: TMenuItem
        Caption = 'f1(x)/f2(x) , Division der Funktionswerte'
        OnClick = Menueinstellungen
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Umkehrkurvezuf1x1: TMenuItem
        Caption = 'Umkehrkurve zu f1(x) , Spiegelung an y=x'
        OnClick = Menueinstellungen
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Timer1Timer
    Left = 48
    Top = 16
  end
  object SD1: TSaveDialog
    DefaultExt = 'gif'
    Filter = 
      'Abbildung (*.bmp)|*.bmp|16 Farben-Abbildung (*.bmp)|*.bmp|Abbild' +
      'ung (*.gif)|*.gif|Vektorgrafik (*.wmf)|*.wmf'
    FilterIndex = 3
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Abbildung speichern'
    Left = 82
    Top = 17
  end
end
