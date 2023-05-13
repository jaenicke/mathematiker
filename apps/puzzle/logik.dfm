object Form1: TForm1
  Left = 336
  Top = 45
  HelpContext = 1
  BorderStyle = bsSingle
  Caption = 'Logikspiele'
  ClientHeight = 660
  ClientWidth = 880
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  PopupMenu = PM1
  Position = poDefault
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object f_sudoku: TPanel
    Left = 0
    Top = 1
    Width = 880
    Height = 600
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    Visible = False
    object p1p2: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Caption = 'Sudoku-Zahlenrätsel'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      object p1d6: TDsFancyButton
        Left = 8
        Top = 1
        Width = 120
        Height = 25
        Caption = 'Neu'
        FXE.FaceColor = clBtnFace
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 4
        FXE.TextStyle = txLowered
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object p1d8: TDsFancyButton
        Left = 48
        Top = 1
        Width = 140
        Height = 25
        Caption = 'Abbruch'
        FXE.FaceColor = clBtnFace
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 4
        FXE.TextStyle = txLowered
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object p1i2: TImage
        Left = 472
        Top = -79
        Width = 105
        Height = 105
        Visible = False
      end
      object p1t1: TToolBar
        Left = 1
        Top = 1
        Width = 237
        Height = 24
        Align = alLeft
        AutoSize = True
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p1s3: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Rechner beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777707777700077777700777770007777706077777000777706600000
            7000777066666660700077066666666070007770666666607000777706600000
            7000777770607777700077777700777770007777777077777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
        object p1s4: TSpeedButton
          Left = 23
          Top = 2
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888800008888888888888888888800008888888888888088888800008888
            88888888008888880000888887777770F0788888000088880000000FF0078888
            00008880FFFFFFFFFFF0788800008880FFFFF44FFFF0788800008880FFFFFFFF
            FFF0788800008880FFFFF47FFFF0788800008880FFFFF748FFF0788800008880
            FFFFFF747FF0788800008880FFF47FF44FF0788800008880FFF44F844FF07888
            00008880FFF844448FF0788800008880FFFFFFFFFFF0788800008880FFFFFFFF
            FFF0888800008888000000000008888800008888888888888888888800008888
            88888888888888880000}
          OnClick = S99Click
        end
        object p1p7: TPanel
          Left = 46
          Top = 2
          Width = 8
          Height = 22
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
        end
        object p1s1: TSpeedButton
          Left = 54
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Problem laden'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            777777777777777700007CC7777777CC7777777700007CC7CC7777CC77777777
            00007CC7CC7777CC7777777700007CC7777777CC7770777700007CCCCCCCCCCC
            7770077700007CCCCCCCCC000000007700007CBBBBBBBB000000000700007CBB
            BBBBBB000000000700007CBBBBBBBB000000007700007CBBBBBBBBBC77700777
            00007CBBBBBBBBBC7770777700007CBBBBBBBBBC777777770000777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            77777777777777770000}
          ParentShowHint = False
          ShowHint = True
          OnClick = p1s1Click
        end
        object p1s2: TSpeedButton
          Left = 77
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Problem speichern'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            7777777777777777000077777777CC7777777CC7000077777777CC7CC7777CC7
            000077777777CC7CC7777CC7000077777707CC7777777CC7000077777700CCCC
            CCCCCCC70000700000000CCCCCCCCCC700007000000000BBBBBBBBC700007000
            000000BBBBBBBBC70000700000000BBBBBBBBBC7000077777700CBBBBBBBBBC7
            000077777707CBBBBBBBBBC7000077777777CBBBBBBBBBC70000777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            77777777777777770000}
          ParentShowHint = False
          ShowHint = True
          OnClick = p1s2Click
        end
        object p1p13: TPanel
          Left = 100
          Top = 2
          Width = 8
          Height = 22
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
        end
        object S11: TSpeedButton
          Left = 108
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Abbildung kopieren'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888800008888888888888888888800008888777777778888888800008800
            00000000788888880000880BFFFBFFF0777777880000880F444444F000000078
            0000880FFBFFFBF0FBFFF0780000880F444444F04444F0780000880BFFFBFFF0
            FFFBF0780000880F444444F04444F0780000880FFBFFFBF0FBFFF0780000880F
            44F000004440F0780000880BFFF0FFF0FFFBF0780000880F44F0FB00F0000078
            0000880FFBF0F0FFF0FFF0880000880000000F44F0FB08880000888888880FFB
            F0F0888800008888888800000008888800008888888888888888888800008888
            88888888888888880000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S11Click
        end
        object S10: TSpeedButton
          Left = 131
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Abbildung drucken'
          Flat = True
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            0400000000000801000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFF00FFFFF00000000000FFFFFF00FFFF0888888888080FFF
            FF00FFF000000000000080FFFF00FFF0888888BBB88000FFFF00FFF088888877
            788080FFFF00FFF0000000000000880FFF00FFF0888888888808080FFF00FFFF
            000000000080800FFF00FFFFF0FFFFFFFF08080FFF00FFFFFF0F00000F0000FF
            FF00FFFFFF0FFFFFFFF0FFFFFF00FFFFFFF0F00000F0FFFFFF00FFFFFFF0FFFF
            FFFF0FFFFF00FFFFFFFF000000000FFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = p1d13Click
        end
        object Panel20: TPanel
          Left = 154
          Top = 2
          Width = 60
          Height = 22
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 2
          object L9: TLabel
            Left = 26
            Top = 3
            Width = 29
            Height = 14
            Caption = 'Blatt'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Edit2: TEdit
            Left = 4
            Top = 3
            Width = 20
            Height = 16
            TabStop = False
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '1'
          end
        end
        object p1s7: TSpeedButton
          Left = 214
          Top = 2
          Width = 23
          Height = 22
          Flat = True
          OnClick = p1s7Click
        end
      end
    end
    object p1p1: TPanel
      Left = 0
      Top = 26
      Width = 880
      Height = 574
      HelpContext = 126
      Align = alClient
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 1
      OnResize = p1p1Resize
      object p1p3: TPanel
        Left = 0
        Top = 415
        Width = 880
        Height = 159
        Align = alBottom
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Panel14: TPanel
          Left = 10
          Top = 0
          Width = 870
          Height = 159
          Align = alClient
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object p1d1: TDsFancyButton
            Left = 73
            Top = 16
            Width = 112
            Height = 25
            Caption = 'Neues Problem'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d1Click
          end
          object p1d2: TDsFancyButton
            Left = 613
            Top = 16
            Width = 140
            Height = 25
            Caption = 'Abbruch'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d2Click
          end
          object p1d3: TDsFancyButton
            Left = 805
            Top = 16
            Width = 140
            Height = 25
            Caption = 'Problem lösen'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d3Click
          end
          object p1d11: TDsFancyButton
            Left = 193
            Top = 16
            Width = 112
            Height = 25
            Caption = 'Beispiel 1'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d11Click
          end
          object p1l3: TLabel
            Left = 80
            Top = 80
            Width = 842
            Height = 48
            Caption = 
              'Aufgabe: Jedes freie Feld in der linken Tabelle ist mit einer Zi' +
              'ffer von 1 bis 9 zu belegen. (linker Mausklick)'#13#10'Dabei darf in j' +
              'eder horizontalen und jeder vertikalen Reihe, d.h. den Zeilen un' +
              'd Spalten, jede Ziffer nur genau einmal auftreten.'#13#10'Ebenso darf ' +
              'in jedem der neun kleinen 3 x 3 Quadrate jede der Ziffern 1 bis ' +
              '9 nur einmal vorhanden sein.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object p1d12: TDsFancyButton
            Left = 312
            Top = 16
            Width = 169
            Height = 25
            Caption = 'Problem generieren'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d12Click
          end
          object p1d4: TDsFancyButton
            Left = 357
            Top = 48
            Width = 124
            Height = 25
            Caption = 'Feld ausfüllen'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d4Click
          end
          object p1d5: TDsFancyButton
            Left = 222
            Top = 48
            Width = 124
            Height = 25
            Caption = 'Hilfe geben'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d5Click
          end
          object p1d13: TDsFancyButton
            Left = 805
            Top = 48
            Width = 140
            Height = 25
            Caption = 'Problem drucken'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            OnClick = p1d13Click
          end
          object p1cb1: TCheckBox
            Left = 72
            Top = 52
            Width = 137
            Height = 17
            Caption = 'Eingabekontrolle'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
          end
          object LB1: TListBox
            Left = 528
            Top = 48
            Width = 121
            Height = 97
            ItemHeight = 16
            TabOrder = 1
            Visible = False
          end
        end
        object Panel15: TPanel
          Left = 0
          Top = 0
          Width = 10
          Height = 159
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 1
        end
      end
      object p1p4: TPanel
        Left = 0
        Top = 385
        Width = 880
        Height = 30
        Align = alBottom
        BevelInner = bvLowered
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object Panel12: TPanel
        Left = 474
        Top = 0
        Width = 406
        Height = 385
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 2
        object Pb5: TPaintBox
          Left = 0
          Top = 0
          Width = 406
          Height = 385
          Align = alClient
          OnPaint = PB5paint
        end
        object p1sg1: TStringGrid
          Left = 16
          Top = 72
          Width = 399
          Height = 399
          ColCount = 9
          DefaultColWidth = 42
          DefaultRowHeight = 42
          DefaultDrawing = False
          FixedColor = clHighlight
          FixedCols = 0
          RowCount = 9
          FixedRows = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -32
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          GridLineWidth = 2
          Options = [goVertLine, goHorzLine, goDrawFocusSelected, goTabs]
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 0
          Visible = False
          OnDrawCell = p1sg1DrawCell
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 433
        Height = 385
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 3
        object pb4: TPaintBox
          Left = 0
          Top = 0
          Width = 433
          Height = 385
          Align = alClient
          OnMouseDown = pb4MouseDown
          OnPaint = pb4Paint
        end
        object Panel21: TPanel
          Left = 248
          Top = 264
          Width = 137
          Height = 41
          Color = clAqua
          TabOrder = 0
          Visible = False
          object D8: TDsFancyButton
            Left = 96
            Top = 8
            Width = 32
            Height = 25
            Caption = '¿'
            FXE.FaceColor = clWhite
            FXE.FrameColor = 12615808
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            OnClick = D8Click
          end
          object Edit3: TEdit
            Left = 8
            Top = 10
            Width = 81
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object Panel22: TPanel
          Left = 8
          Top = 8
          Width = 425
          Height = 473
          Caption = 'Panel22'
          TabOrder = 1
          Visible = False
          object D10: TDsFancyButton
            Left = 160
            Top = 440
            Width = 105
            Height = 25
            Caption = 'Übernehmen'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            OnClick = D10Click
          end
          object d11: TDsFancyButton
            Left = 16
            Top = 440
            Width = 97
            Height = 25
            Caption = 'Abbruch'
            FXE.FaceColor = clWhite
            FXE.FrameColor = clGray
            FXE.FrameStyle = fmGradient
            FXE.FrameWidth = 4
            FXE.HoverColor = clBlue
            FXE.Shape = btnRectangle
            FXE.CornerRadius = 2
            FXE.TextStyle = txLowered
            Glyphs.Layout = lyLeft
            Glyphs.Number = 1
            Glyphs.Distance = 0
            OnClick = d11Click
          end
          object Label1: TLabel
            Left = 128
            Top = 8
            Width = 199
            Height = 18
            Caption = 'Sudoku-Rätsel eingeben'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object p1Feld: TStringGrid
            Left = 16
            Top = 34
            Width = 399
            Height = 399
            ColCount = 9
            DefaultColWidth = 42
            DefaultRowHeight = 42
            DefaultDrawing = False
            FixedCols = 0
            RowCount = 9
            FixedRows = 0
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -32
            Font.Name = 'Verdana'
            Font.Style = []
            GridLineWidth = 2
            Options = [goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs]
            ParentFont = False
            ScrollBars = ssNone
            TabOrder = 0
            OnClick = Feldenter
            OnDrawCell = p1FeldDrawCell
            OnExit = Feldenter
          end
        end
      end
      object Panel18: TPanel
        Left = 433
        Top = 0
        Width = 41
        Height = 385
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 4
        object p1d9: TDsFancyButton
          Left = -16
          Top = 176
          Width = 73
          Height = 51
          Hint = 'Arbeitsfeld als Lösung zwischenspeichern'
          Caption = 'Þ'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmNone
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txShadowed
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -32
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = p1d9Click
        end
        object p1d10: TDsFancyButton
          Left = -16
          Top = 272
          Width = 73
          Height = 51
          Hint = 'Teillösung wieder in das Arbeitsfeld laden'
          Caption = 'Ü'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmNone
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txShadowed
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -32
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = p1d10Click
        end
        object p1sg3: TStringGrid
          Left = 14
          Top = 376
          Width = 169
          Height = 121
          ColCount = 9
          DefaultColWidth = 20
          DefaultRowHeight = 20
          DefaultDrawing = False
          FixedCols = 0
          RowCount = 9
          FixedRows = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Options = [goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs]
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 0
          Visible = False
        end
        object p1sg2: TStringGrid
          Left = 14
          Top = 400
          Width = 169
          Height = 121
          ColCount = 9
          DefaultColWidth = 20
          DefaultRowHeight = 20
          DefaultDrawing = False
          FixedCols = 0
          RowCount = 9
          FixedRows = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Options = [goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs]
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 1
          Visible = False
        end
        object p1sg4: TStringGrid
          Left = -16
          Top = 28
          Width = 169
          Height = 121
          ColCount = 9
          DefaultColWidth = 20
          DefaultRowHeight = 20
          DefaultDrawing = False
          FixedCols = 0
          RowCount = 9
          FixedRows = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Options = [goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs]
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 2
          Visible = False
        end
      end
    end
  end
  object f_mahj: TPanel
    Left = 0
    Top = 601
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    object PB1: TPaintBox
      Left = 177
      Top = 26
      Width = 703
      Height = 674
      Align = alClient
      OnMouseDown = PB1MouseDown
      OnPaint = PB1Paint
    end
    object p2taipei: TPanel
      Left = 0
      Top = 26
      Width = 177
      Height = 674
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object p2L3: TLabel
        Left = 24
        Top = 292
        Width = 4
        Height = 14
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object p2D9: TDsFancyButton
        Left = 24
        Top = 250
        Width = 120
        Height = 25
        Caption = 'Neues Spiel'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = p2D9Click
      end
      object p2L4: TLabel
        Left = 8
        Top = 312
        Width = 78
        Height = 14
        Caption = 'Spielername'
      end
      object p2L1: TLabel
        Left = 16
        Top = 528
        Width = 118
        Height = 13
        Caption = 'noch 144 Spielsteine'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object p2L2: TLabel
        Left = 8
        Top = 16
        Width = 120
        Height = 14
        Caption = 'Ausgangssituation'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object p2L5: TLabel
        Left = 16
        Top = 544
        Width = 44
        Height = 13
        Caption = '0 Paare'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object p2D1: TDsFancyButton
        Left = 24
        Top = 588
        Width = 120
        Height = 25
        Caption = 'Bestenliste'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = p2D1Click
      end
      object p2I1: TImage
        Left = 48
        Top = 40
        Width = 105
        Height = 105
        Visible = False
      end
      object p2M1: TMemo
        Left = 8
        Top = 359
        Width = 153
        Height = 162
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Freiliegende Steine mit '
          'gleichem Bild sind '
          'anzuklicken und damit zu '
          'entfernen.'
          'Ein Stein ist frei, wenn '
          'über ihm kein Stein liegt '
          'und er links oder rechts '
          'keinen Nachbarn mehr '
          'hat.'
          'Ziel ist es, alle Steine '
          'vom Spielfeld zu '
          'entfernen.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object p2E4: TEdit
        Left = 24
        Top = 328
        Width = 121
        Height = 22
        TabOrder = 0
        OnChange = p2E4Change
      end
      object p2LB1: TListBox
        Left = 16
        Top = 40
        Width = 153
        Height = 196
        BorderStyle = bsNone
        Color = 15790320
        IntegralHeight = True
        ItemHeight = 14
        TabOrder = 2
        OnClick = p2LB1Click
      end
      object p2CB1: TCheckBox
        Left = 20
        Top = 560
        Width = 121
        Height = 17
        Caption = 'Paare anzeigen'
        TabOrder = 3
        OnClick = p2CB1Click
      end
      object p2lb2: TListBox
        Left = 160
        Top = 480
        Width = 121
        Height = 97
        ItemHeight = 14
        TabOrder = 4
        Visible = False
      end
    end
    object p2P3: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      object p2TB1: TToolBar
        Left = 1
        Top = 1
        Width = 232
        Height = 24
        Align = alLeft
        Caption = 'p2TB1'
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p2s3: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
        object p2p4: TPanel
          Left = 23
          Top = 2
          Width = 8
          Height = 22
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
        end
        object p2S19: TSpeedButton
          Left = 31
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Abbildung drucken'
          Flat = True
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            0400000000000801000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFF00FFFFF00000000000FFFFFF00FFFF0888888888080FFF
            FF00FFF000000000000080FFFF00FFF0888888BBB88000FFFF00FFF088888877
            788080FFFF00FFF0000000000000880FFF00FFF0888888888808080FFF00FFFF
            000000000080800FFF00FFFFF0FFFFFFFF08080FFF00FFFFFF0F00000F0000FF
            FF00FFFFFF0FFFFFFFF0FFFFFF00FFFFFFF0F00000F0FFFFFF00FFFFFFF0FFFF
            FFFF0FFFFF00FFFFFFFF000000000FFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = p2S19Click
        end
        object p2S7: TSpeedButton
          Left = 54
          Top = 2
          Width = 24
          Height = 22
          Hint = 'Abbildung speichern'
          Flat = True
          Glyph.Data = {
            06020000424D0602000000000000760000002800000019000000190000000100
            04000000000090010000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFF00000
            00000000FFFFF0000000FFFFFF03300000088030FFFFF0000000FFFFFF033000
            00088030FFFFF0000000FFFFFF03300000088030FFFFF0000000FFFFFF033000
            00000030FFFFF0000000FFFFFF03333333333330FFFFF0000000FFFFFF033000
            00000330FFFFF0000000FFFFFF03088888888030FFFFF0000000FFFFFF030888
            88888030FFFFF0000000FFFFFF03088888888030FFFFF0000000FFFFFF030888
            88888030FFFFF0000000FFFFFF03088888888000FFFFF0000000FFFFFF030888
            88888080FFFFF0000000FFFFFF00000000000000FFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = p2S7Click
        end
        object p2s1: TSpeedButton
          Left = 78
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Abbildung kopieren'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888800008888888888888888888800008888777777778888888800008800
            00000000788888880000880BFFFBFFF0777777880000880F444444F000000078
            0000880FFBFFFBF0FBFFF0780000880F444444F04444F0780000880BFFFBFFF0
            FFFBF0780000880F444444F04444F0780000880FFBFFFBF0FBFFF0780000880F
            44F000004440F0780000880BFFF0FFF0FFFBF0780000880F44F0FB00F0000078
            0000880FFBF0F0FFF0FFF0880000880000000F44F0FB08880000888888880FFB
            F0F0888800008888888800000008888800008888888888888888888800008888
            88888888888888880000}
          ParentShowHint = False
          ShowHint = True
          OnClick = p2s1Click
        end
      end
    end
  end
  object f_gedaechtnis: TPanel
    Left = 0
    Top = 602
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    OnResize = f_gedaechtnisResize
    object p3P44: TPanel
      Left = 0
      Top = 26
      Width = 281
      Height = 674
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object p3L45: TLabel
        Left = 16
        Top = 16
        Width = 54
        Height = 14
        Caption = 'Aufgabe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object p3d12: TDsFancyButton
        Left = 40
        Top = 304
        Width = 201
        Height = 32
        Caption = 'Teststart'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = p3d12Click
      end
      object p3d13: TDsFancyButton
        Left = 40
        Top = 304
        Width = 201
        Height = 32
        Caption = 'Ergebnis bestätigen'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        Visible = False
        OnClick = p3d13Click
      end
      object p3M2: TMemo
        Left = 16
        Top = 40
        Width = 257
        Height = 97
        BorderStyle = bsNone
        Color = 15790320
        Lines.Strings = (
          'Das Programm wird immer länger '
          'werdende Zeichenketten für eine '
          'kurze Zeit anzeigen.'
          'Die Aufgabe besteht darin, diese zu '
          'erkennen und korrekt in die '
          'Eingabezeile einzutragen.')
        TabOrder = 0
      end
      object p3RG6: TRadioGroup
        Left = 16
        Top = 160
        Width = 249
        Height = 89
        Caption = 'Art der Zeichenketten'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Zahlen'
          'Buchstaben'
          'Zahlen und Buchstaben')
        ParentFont = False
        TabOrder = 1
      end
      object p3cb1: TCheckBox
        Left = 16
        Top = 264
        Width = 257
        Height = 17
        Caption = 'neue Zeichenkette anzeigen'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object p3P45: TPanel
      Left = 285
      Top = 26
      Width = 595
      Height = 674
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object p3L46: TLabel
        Left = 32
        Top = 48
        Width = 196
        Height = 32
        Caption = 'Zeichenkette'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -27
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p3L47: TLabel
        Left = 88
        Top = 96
        Width = 11
        Height = 38
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object p3L48: TLabel
        Left = 32
        Top = 160
        Width = 131
        Height = 32
        Caption = 'Ergebnis'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -27
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p3L49: TLabel
        Left = 32
        Top = 296
        Width = 182
        Height = 32
        Caption = 'Auswertung'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -27
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p3L50: TLabel
        Left = 88
        Top = 352
        Width = 9
        Height = 32
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -27
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p3L51: TLabel
        Left = 88
        Top = 392
        Width = 9
        Height = 32
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -27
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p3E3: TEdit
        Left = 88
        Top = 208
        Width = 580
        Height = 46
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object p3P6: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Caption = 'Zahlengedächtnistest'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 2
      object p3tb1: TToolBar
        Left = 1
        Top = 1
        Width = 112
        Height = 24
        Align = alLeft
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p3S7: TSpeedButton
          Left = 0
          Top = 2
          Width = 24
          Height = 22
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
      end
    end
    object Panel16: TPanel
      Left = 281
      Top = 26
      Width = 4
      Height = 674
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 3
    end
  end
  object f_memory: TPanel
    Left = 0
    Top = 603
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Visible = False
    object p5PB1: TPaintBox
      Left = 0
      Top = 70
      Width = 880
      Height = 630
      Align = alClient
      OnMouseDown = p5PB1MouseDown
      OnPaint = p5PB1Paint
    end
    object p5p6: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Caption = 'Memory'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      object p5tb1: TToolBar
        Left = 1
        Top = 1
        Width = 144
        Height = 24
        Align = alLeft
        Caption = 'p5tb1'
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p5s3: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
      end
    end
    object p5p7: TPanel
      Left = 0
      Top = 26
      Width = 880
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 1
      object p5l1: TLabel
        Left = 144
        Top = 16
        Width = 78
        Height = 14
        Caption = 'Spielername'
      end
      object p5d1: TDsFancyButton
        Left = 8
        Top = 10
        Width = 113
        Height = 25
        Caption = 'Neues Spiel'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = p5d1Click
      end
      object p5L2: TLabel
        Left = 384
        Top = 10
        Width = 100
        Height = 23
        Caption = '00:00:00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p5L3: TLabel
        Left = 520
        Top = 10
        Width = 83
        Height = 23
        Caption = '0 Paare'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p5d2: TDsFancyButton
        Left = 640
        Top = 8
        Width = 113
        Height = 25
        Caption = 'Bestenliste'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = p5d2Click
      end
      object p5I1: TImage
        Left = 496
        Top = 24
        Width = 105
        Height = 105
        Visible = False
      end
      object p5e1: TEdit
        Left = 232
        Top = 12
        Width = 121
        Height = 22
        TabOrder = 0
        OnChange = p5e1Change
      end
    end
  end
  object f_spiel15: TPanel
    Left = 0
    Top = 604
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    object p8p6: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Caption = 'Spiel 15'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      object p8tb1: TToolBar
        Left = 1
        Top = 1
        Width = 128
        Height = 24
        Align = alLeft
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p8s3: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
      end
    end
    object p8spiel15: TPanel
      Left = 0
      Top = 26
      Width = 177
      Height = 674
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 1
      object p8l24: TLabel
        Left = 20
        Top = 62
        Width = 53
        Height = 14
        Caption = 'Spielfeld'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object p8L25: TLabel
        Left = 16
        Top = 88
        Width = 61
        Height = 14
        Caption = 'Spielzüge'
      end
      object p8l26: TLabel
        Left = 90
        Top = 88
        Width = 8
        Height = 14
        Caption = '0'
      end
      object p8D5: TDsFancyButton
        Left = 40
        Top = 18
        Width = 97
        Height = 25
        Caption = 'Neues Spiel'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = p8D5Click
      end
      object p8l40: TLabel
        Left = 16
        Top = 280
        Width = 78
        Height = 14
        Caption = 'Spielername'
      end
      object p8D1: TDsFancyButton
        Left = 24
        Top = 336
        Width = 121
        Height = 25
        Caption = 'Bestenliste'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = p8D1Click
      end
      object p8m4: TMemo
        Left = 8
        Top = 119
        Width = 161
        Height = 154
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Die Zahlenfelder sind von '
          'links oben nach recht '
          'unten aufsteigend zu '
          'ordnen.'
          'Dazu können benachbarte '
          'Felder des Leerfeldes auf '
          'dieses verschoben werden.'
          'Klicken Sie dazu das zu '
          'verschiebende Feld mit der '
          'linken Maustaste an.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object p8E3: TEdit
        Left = 24
        Top = 304
        Width = 121
        Height = 22
        TabOrder = 1
        OnChange = p8E3Change
      end
      object p8r6: TRxSpinEdit
        Left = 88
        Top = 58
        Width = 49
        Height = 22
        Decimal = 0
        EditorEnabled = False
        MaxValue = 8
        MinValue = 3
        Value = 4
        TabOrder = 2
        OnChange = p8r6Change
      end
    end
    object p8p7: TPanel
      Left = 177
      Top = 26
      Width = 703
      Height = 674
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      object p8pb1: TPaintBox
        Left = 0
        Top = 0
        Width = 703
        Height = 674
        Align = alClient
        OnMouseDown = p8pb1MouseDown
        OnPaint = p8pb1Paint
      end
    end
  end
  object f_gedtest: TPanel
    Left = 0
    Top = 605
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Visible = False
    object p6PB2: TPaintBox
      Left = 193
      Top = 26
      Width = 687
      Height = 674
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -32
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      OnMouseDown = p6PB2MouseDown
    end
    object p6D4: TDsFancyButton
      Left = 256
      Top = 362
      Width = 177
      Height = 57
      Caption = 'Start'
      FXE.FaceColor = clWhite
      FXE.FrameColor = clGray
      FXE.FrameStyle = fmGradient
      FXE.FrameWidth = 4
      FXE.HoverColor = clBlue
      FXE.Shape = btnRectangle
      FXE.CornerRadius = 12
      FXE.TextStyle = txRaised
      Glyphs.Layout = lyLeft
      Glyphs.Number = 1
      Glyphs.Distance = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -32
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      OnClick = p6D4Click
    end
    object p6L1: TLabel
      Left = 208
      Top = 40
      Width = 7
      Height = 25
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object p6P6: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Caption = 'Gedächtnistest'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      OnResize = p6P6Resize
      object p6TB1: TToolBar
        Left = 1
        Top = 1
        Width = 160
        Height = 24
        Align = alLeft
        Caption = 'p6TB1'
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p6S3: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
      end
    end
    object p6P2: TPanel
      Left = 0
      Top = 26
      Width = 193
      Height = 674
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 1
      object p6L3: TLabel
        Left = 16
        Top = 19
        Width = 96
        Height = 29
        Caption = 'Stufe 3'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object p6L4: TLabel
        Left = 16
        Top = 59
        Width = 4
        Height = 14
      end
      object p6L2: TLabel
        Left = 16
        Top = 79
        Width = 4
        Height = 14
      end
      object p6L5: TLabel
        Left = 16
        Top = 99
        Width = 4
        Height = 14
      end
      object p6L6: TLabel
        Left = 16
        Top = 117
        Width = 4
        Height = 14
      end
      object p6I1: TImage
        Left = 136
        Top = 8
        Width = 105
        Height = 105
        Visible = False
      end
      object p6M1: TMemo
        Left = 8
        Top = 152
        Width = 177
        Height = 257
        TabStop = False
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Nach dem Start zeigt das '
          'Programm kurzzeitig einige '
          'Symbole.'
          'Diese Symbole müssen '
          'nach dem Abblenden '
          'richtig ausgewählt werden. '
          '(linken Maustastenklick)'
          ''
          'Werden alle richtig '
          'erkannt, erhöht sich die '
          'Schwierigkeitsstufe.'
          'Ist ein Symbol falsch, '
          'erhöht sich die '
          'Anzeigezeit.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object f_arithmo: TPanel
    Left = 0
    Top = 0
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 6
    Visible = False
    OnResize = f_arithmoResize
    object p9P5: TPanel
      Left = 0
      Top = 26
      Width = 880
      Height = 674
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object p9PB1: TPaintBox
        Left = 211
        Top = 0
        Width = 669
        Height = 674
        Align = alClient
        Color = clBtnFace
        ParentColor = False
        OnMouseDown = p9PB1MouseDown
        OnPaint = p9PB1Paint
      end
      object p9p7: TPanel
        Left = 0
        Top = 0
        Width = 209
        Height = 674
        Align = alLeft
        BevelOuter = bvNone
        Color = 15790320
        Locked = True
        TabOrder = 0
        object p9l1: TLabel
          Left = 12
          Top = 220
          Width = 90
          Height = 16
          Caption = 'Noch erlaubt:'
        end
        object p9L2: TLabel
          Left = 14
          Top = 248
          Width = 70
          Height = 16
          Caption = 'Entfernen:'
        end
        object p9d1: TDsFancyButton
          Left = 40
          Top = 40
          Width = 129
          Height = 25
          Caption = 'Neues Spiel'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          OnClick = p9d1Click
        end
        object p9d2: TDsFancyButton
          Left = 104
          Top = 248
          Width = 25
          Height = 20
          Caption = '1'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          OnClick = p9d2Click
        end
        object p9d3: TDsFancyButton
          Left = 136
          Top = 248
          Width = 25
          Height = 20
          Caption = '2'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          OnClick = p9d3Click
        end
        object p9d4: TDsFancyButton
          Left = 168
          Top = 248
          Width = 25
          Height = 20
          Caption = '3'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          OnClick = p9d4Click
        end
        object p9d5: TDsFancyButton
          Left = 136
          Top = 216
          Width = 57
          Height = 25
          Caption = 'Fertig'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          OnClick = daniel2
        end
        object p9cb2: TCheckBox
          Left = 16
          Top = 76
          Width = 161
          Height = 17
          Caption = 'Computer beginnt'
          TabOrder = 0
        end
        object p9r3: TRadioGroup
          Left = 16
          Top = 104
          Width = 185
          Height = 49
          Caption = 'Anzahl'
          Columns = 2
          Items.Strings = (
            'Zufall'
            '')
          TabOrder = 1
        end
        object p9E1: TEdit
          Left = 128
          Top = 122
          Width = 57
          Height = 24
          MaxLength = 3
          TabOrder = 2
          Text = '100'
          OnClick = p9E1Click
        end
        object p9r4: TRadioGroup
          Left = 16
          Top = 160
          Width = 185
          Height = 49
          Caption = 'Letztes Holz'
          Columns = 2
          Items.Strings = (
            'gewinnt'
            'verliert')
          TabOrder = 3
        end
        object p9E2: TEdit
          Left = 118
          Top = 217
          Width = 11
          Height = 20
          Cursor = crArrow
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 4
          Text = '3'
        end
        object p9M2: TMemo
          Left = 8
          Top = 280
          Width = 193
          Height = 360
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          TabOrder = 5
        end
      end
      object Panel19: TPanel
        Left = 209
        Top = 0
        Width = 2
        Height = 674
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
      end
    end
    object p9p2: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 26
      Align = alTop
      Caption = 'Arithmomachiaspiel - Streichholzproblem'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      object p9tb1: TToolBar
        Left = 1
        Top = 1
        Width = 160
        Height = 24
        Align = alLeft
        Caption = 'Arithmomachiaspiel - Streichholzproblem'
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object p9s1: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
      end
    end
  end
  object f_puzzle: TPanel
    Left = 0
    Top = 606
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 7
    OnResize = f_puzzleResize
    object Panel1: TPanel
      Left = 1
      Top = 28
      Width = 192
      Height = 571
      Align = alLeft
      Color = 15790320
      TabOrder = 0
      object d1: TDsFancyButton
        Left = 16
        Top = 32
        Width = 160
        Height = 25
        Caption = 'Zufallsbild laden'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txRaised
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = d1Click
      end
      object D2: TDsFancyButton
        Left = 16
        Top = 512
        Width = 160
        Height = 25
        Caption = 'Lösung zeigen'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txLowered
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = D2Click
      end
      object D3: TDsFancyButton
        Left = 16
        Top = 592
        Width = 161
        Height = 25
        Caption = 'Bestenliste'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txLowered
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = D3Click
      end
      object L4: TLabel
        Left = 16
        Top = 560
        Width = 36
        Height = 16
        Caption = 'Name'
      end
      object D4: TDsFancyButton
        Left = 16
        Top = 328
        Width = 161
        Height = 25
        Caption = 'Eigenes Bild laden'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txLowered
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = D4Click
      end
      object D9: TDsFancyButton
        Left = 16
        Top = 480
        Width = 161
        Height = 25
        Caption = 'Zugvorschlag'
        FXE.FaceColor = clWhite
        FXE.FrameColor = clGray
        FXE.FrameStyle = fmGradient
        FXE.FrameWidth = 4
        FXE.HoverColor = clBlue
        FXE.Shape = btnRectangle
        FXE.CornerRadius = 2
        FXE.TextStyle = txLowered
        Glyphs.Layout = lyLeft
        Glyphs.Number = 1
        Glyphs.Distance = 0
        OnClick = D9Click
      end
      object RG1: TRadioGroup
        Left = 16
        Top = 152
        Width = 161
        Height = 81
        Caption = 'Teile'
        ItemIndex = 1
        Items.Strings = (
          '12 - leicht'
          '48 - schwierig'
          '192 - extrem')
        TabOrder = 0
        TabStop = True
      end
      object RG2: TRadioGroup
        Left = 16
        Top = 248
        Width = 161
        Height = 65
        Caption = 'Schwierigkeitsgrad'
        ItemIndex = 0
        Items.Strings = (
          'ohne Drehung'
          'mit Drehung')
        TabOrder = 1
      end
      object Edit1: TEdit
        Left = 64
        Top = 556
        Width = 113
        Height = 24
        TabOrder = 2
        OnChange = Edit1Change
      end
      object Memo1: TMemo
        Left = 16
        Top = 368
        Width = 161
        Height = 137
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Ein linker Mausklick und '
          'Bewegung der Maus '
          'verschiebt das '
          'ausgewählte Teil.'
          'Ein rechter Mausklick dreht '
          'das Einzelteil um 90°.'
          'Eigene Bilder werden auf '
          'das Format 640 x 480 '
          'gestreckt oder gestaucht.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object L1: TListBox
        Left = 16
        Top = 70
        Width = 161
        Height = 70
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        IntegralHeight = True
        ItemHeight = 14
        Items.Strings = (
          'Abendlandschaft'#9'77'
          'Abu Simbel'#9'38'
          'Adam-Ries-Museum'#9'93'
          'Adler-Nebel'#9'19'
          'Akropolis'#9'46'
          'Alpen'#9'68'
          'Antilop-Canyon'#9'66'
          'Ara'#9'32'
          'Araukarie'#9'14'
          'Arecibo'#9'86'
          'Augustusburg'#9'92'
          'Azure-Window'#9'75'
          'Barbarine'#9'54'
          'Basilius-Kathedrale'#9'65'
          'Bastei Rathen'#9'88'
          'Brücke von Arles'#9'61'
          'Burg Kriebstein'#9'91'
          'Castel del Monte'#9'96'
          'Chateau Villandry'#9'59'
          'Che Guevara'#9'95'
          'Chemnitz-Rottluff'#9'13'
          'Cheops-Pyramide'#9'35'
          'Chichén Itzá'#9'50'
          'Colosseum'#9'49'
          'County Donegal'#9'48'
          'Deichdurchbruch'#9'89'
          'Delphi'#9'72'
          'Drei Zinnen'#9'26'
          'Dresden-Zwinger'#9'105'
          'Eiserne Säule'#9'85'
          'Erde'#9'15'
          'Felsendom'#9'62'
          'Felsendome'#9'82'
          'Flusslandschaft'#9'64'
          'Foucaultsches Pendel'#9'60'
          'Galilei-Plastik'#9'83'
          'Gdansk'#9'63'
          'Gemälde'#9'104'
          'Gemeine Akelei'#9'30'
          'Göltzschtalbrücke'#9'52'
          'Grüne Mamba'#9'23'
          'Halbinsel Sinai'#9'22'
          'Haus des Lehrers'#9'100'
          'Hiddensee'#9'42'
          'Hiroshima-Memorial'#9'70'
          'Jantal Mantar Jaipur'#9'16'
          'Kandinsky'#9'101'
          'Karl Marx Monument'#9'41'
          'Kleine Meerjungfrau'#9'90'
          'Kreidefelsen'#9'78'
          'Kreuzer Aurora'#9'71'
          'Krimmler Wasserfall'#9'99'
          'Kugeln'#9'56'
          'Le compas dans l'#39'œil'#9'4'
          'Leonhard Euler'#9'3'
          'Leopardenfrosch'#9'21'
          'Lilie'#9'28'
          'Mathematischer Salon'#9'34'
          'Meerschweinchen'#9'87'
          'Meteora'#9'74'
          'Möbius-Band'#9'39'
          'Mondkrater'#9'25'
          'Montreal'#9'51'
          'Muster'#9'103'
          'Notre-Dame-du-Haut'#9'17'
          'Palme'#9'43'
          'Petra'#9'81'
          'Pferdekopfnebel'#9'29'
          'Phobie géométrique'#9'5'
          'Picadilly-Circus'#9'44'
          'Picasso'#9'20'
          'Planet der 3 Sonnen'#9'9'
          'Porträtfoto'#9'10'
          'Pyramide und Sonne'#9'73'
          'Radioteleskop'#9'80'
          'René Descartes'#9'2'
          'Saturn'#9'11'
          'Schwalbenschwanz'#9'97'
          'Schwanzmeise'#9'84'
          'Seelandschaft'#9'18'
          'Seerosen'#9'31'
          'Silberdistel'#9'40'
          'Silvretta'#9'79'
          'Sojus-Raumschiff'#9'36'
          'Sonne'#9'12'
          'Spaghettimonster'#9'7'
          'Spirale'#9'94'
          'Stonehenge'#9'27'
          'Taj Mahal'#9'37'
          'Thales von Milet'#9'1'
          'Titelbild'#9'102'
          'Tomaten'#9'24'
          'Torusknoten'#9'67'
          'Tower-Bridge'#9'45'
          'Turm von Pisa'#9'98'
          'Uluru'#9'55'
          'Universität Melbourne'#9'76'
          'Venedig'#9'47'
          'Very Large Array'#9'53'
          'Victoria-Fälle'#9'6'
          'Virtuelle Welt'#9'58'
          'Vulkanausbruch'#9'8'
          'Wadi Rum'#9'57'
          'Warnemünde'#9'107'
          'Wartburg'#9'33'
          'Windkraft'#9'69')
        ParentFont = False
        Sorted = True
        TabOrder = 4
        TabWidth = 160
        OnClick = ListBox1Click
      end
      object Memo3: TMemo
        Left = 16
        Top = 160
        Width = 161
        Height = 161
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Das in 12 Teil zerlegte '
          'Bild muss durch '
          'Mausklick auf einen der '
          'Pfeile korrekt '
          'zusammengesetzt '
          'werden.'
          'Jede Pfeilklick verschiebt '
          'in der angezeigten '
          'Richtung die '
          'vollständige Zeile oder '
          'Spalte.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        Visible = False
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 878
      Height = 27
      Align = alTop
      Caption = 'Puzzle'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 201
        Height = 25
        Align = alLeft
        AutoSize = True
        ButtonHeight = 23
        Caption = 'p2TB1'
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object S1: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
        object S2: TSpeedButton
          Left = 23
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Hilfe anzeigen'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888800008888888888888888888800008888888888888088888800008888
            88888888008888880000888887777770F0788888000088880000000FF0078888
            00008880FFFFFFFFFFF0788800008880FFFFF44FFFF0788800008880FFFFFFFF
            FFF0788800008880FFFFF47FFFF0788800008880FFFFF748FFF0788800008880
            FFFFFF747FF0788800008880FFF47FF44FF0788800008880FFF44F844FF07888
            00008880FFF844448FF0788800008880FFFFFFFFFFF0788800008880FFFFFFFF
            FFF0888800008888000000000008888800008888888888888888888800008888
            88888888888888880000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S99Click
        end
        object Panel3: TPanel
          Left = 46
          Top = 2
          Width = 8
          Height = 23
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
        end
        object S5: TSpeedButton
          Left = 54
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Abbildung kopieren'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888800008888888888888888888800008888777777778888888800008800
            00000000788888880000880BFFFBFFF0777777880000880F444444F000000078
            0000880FFBFFFBF0FBFFF0780000880F444444F04444F0780000880BFFFBFFF0
            FFFBF0780000880F444444F04444F0780000880FFBFFFBF0FBFFF0780000880F
            44F000004440F0780000880BFFF0FFF0FFFBF0780000880F44F0FB00F0000078
            0000880FFBF0F0FFF0FFF0880000880000000F44F0FB08880000888888880FFB
            F0F0888800008888888800000008888800008888888888888888888800008888
            88888888888888880000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S5Click
        end
        object S4: TSpeedButton
          Left = 77
          Top = 2
          Width = 24
          Height = 23
          Hint = 'Abbildung speichern'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F0000000F40E0000F40E000010000000100000000000000063BD
            9C00DEDEDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00333333333333
            3333333300003333333333333333333300003333333333333333333300003333
            0000000000000333000033301100000022010333000033301100000022010333
            0000333011000000220103330000333011000000000103330000333011111111
            1111033300003330110000000011033300003330102222222201033300003330
            1022222222010333000033301022222222010333000033301022222222010333
            0000333010222222220003330000333010222222220203330000333000000000
            0000033300003333333333333333333300003333333333333333333300003333
            33333333333333330000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S4aclick
        end
        object S3: TSpeedButton
          Left = 101
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Abbildung drucken'
          Flat = True
          Glyph.Data = {
            7E010000424D7E01000000000000760000002800000016000000160000000100
            0400000000000801000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFF00FFFFF00000000000FFFFFF00FFFF0888888888080FFF
            FF00FFF000000000000080FFFF00FFF0888888BBB88000FFFF00FFF088888877
            788080FFFF00FFF0000000000000880FFF00FFF0888888888808080FFF00FFFF
            000000000080800FFF00FFFFF0FFFFFFFF08080FFF00FFFFFF0F00000F0000FF
            FF00FFFFFF0FFFFFFFF0FFFFFF00FFFFFFF0F00000F0FFFFFF00FFFFFFF0FFFF
            FFFF0FFFFF00FFFFFFFF000000000FFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = S3Click
        end
        object Panel5: TPanel
          Left = 124
          Top = 2
          Width = 8
          Height = 23
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
        end
        object S8: TSpeedButton
          Left = 132
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Spiel laden'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F0000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            777777777777777700007CC7777777CC7777777700007CC7CC7777CC77777777
            00007CC7CC7777CC7777777700007CC7777777CC7770777700007CCCCCCCCCCC
            7770077700007CCCCCCCCC000000007700007CBBBBBBBB000000000700007CBB
            BBBBBB000000000700007CBBBBBBBB000000007700007CBBBBBBBBBC77700777
            00007CBBBBBBBBBC7770777700007CBBBBBBBBBC777777770000777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            77777777777777770000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S8Click
        end
        object S7: TSpeedButton
          Left = 155
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Zwischenstand speichern'
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F0000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            7777777777777777000077777777CC7777777CC7000077777777CC7CC7777CC7
            000077777777CC7CC7777CC7000077777707CC7777777CC7000077777700CCCC
            CCCCCCC70000700000000CCCCCCCCCC700007000000000BBBBBBBBC700007000
            000000BBBBBBBBC70000700000000BBBBBBBBBC7000077777700CBBBBBBBBBC7
            000077777707CBBBBBBBBBC7000077777777CBBBBBBBBBC70000777777777777
            7777777700007777777777777777777700007777777777777777777700007777
            77777777777777770000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S7Click
        end
        object S6: TSpeedButton
          Left = 178
          Top = 2
          Width = 23
          Height = 23
          Flat = True
          OnClick = richtigd
        end
      end
    end
    object Panel4: TPanel
      Left = 197
      Top = 28
      Width = 682
      Height = 571
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      object PaintBox1: TPaintBox
        Left = 96
        Top = 48
        Width = 640
        Height = 480
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnMouseUp = PaintBox1MouseUp
        OnPaint = puzzledarstellen
      end
      object ipu0: TImage
        Left = 96
        Top = 48
        Width = 640
        Height = 480
        Visible = False
      end
      object Image1: TImage
        Left = 760
        Top = 344
        Width = 160
        Height = 160
        Visible = False
      end
      object Image2: TImage
        Left = 776
        Top = 256
        Width = 80
        Height = 80
        Visible = False
      end
      object L10: TLabel
        Left = 104
        Top = 568
        Width = 92
        Height = 29
        Caption = 'Züge 0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object L2: TLabel
        Left = 440
        Top = 568
        Width = 52
        Height = 29
        Caption = 'Zeit'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object L3: TLabel
        Left = 104
        Top = 600
        Width = 80
        Height = 29
        Caption = 'xxxxx'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Image3: TImage
        Left = 32
        Top = 480
        Width = 105
        Height = 105
        AutoSize = True
        Visible = False
      end
      object Image4: TImage
        Left = 24
        Top = 416
        Width = 40
        Height = 40
        Visible = False
      end
      object Image5: TImage
        Left = 752
        Top = 92
        Width = 53
        Height = 48
        AutoSize = True
        Visible = False
        OnClick = Image5Click
      end
      object Image6: TImage
        Left = 752
        Top = 252
        Width = 53
        Height = 48
        AutoSize = True
        Visible = False
        OnClick = Image6Click
      end
      object I7: TImage
        Left = 752
        Top = 412
        Width = 53
        Height = 48
        AutoSize = True
        Visible = False
        OnClick = I7Click
      end
      object I11: TImage
        Left = 156
        Top = 524
        Width = 48
        Height = 53
        AutoSize = True
        Visible = False
        OnClick = I11Click
      end
      object I12: TImage
        Left = 476
        Top = 524
        Width = 48
        Height = 53
        AutoSize = True
        Visible = False
        OnClick = I12Click
      end
      object I13: TImage
        Left = 636
        Top = 524
        Width = 48
        Height = 53
        AutoSize = True
        Visible = False
        OnClick = I13Click
      end
      object I14: TImage
        Left = 316
        Top = 524
        Width = 60
        Height = 60
        AutoSize = True
        Visible = False
        OnClick = I14Click
      end
    end
    object Panel17: TPanel
      Left = 193
      Top = 28
      Width = 4
      Height = 571
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 3
    end
  end
  object f_17: TPanel
    Left = 0
    Top = 607
    Width = 880
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 8
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 27
      Align = alTop
      Caption = '17 und 4'
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      object ToolBar2: TToolBar
        Left = 1
        Top = 1
        Width = 232
        Height = 25
        Align = alLeft
        ButtonHeight = 23
        Caption = 'p2TB1'
        Color = 15790320
        EdgeBorders = []
        ParentColor = False
        TabOrder = 0
        object S9: TSpeedButton
          Left = 0
          Top = 2
          Width = 23
          Height = 23
          Hint = 'Teilprogramm beenden'
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777077777700077777007777770007777060777777000777066000007
            7000770666666607700070666666660770007706666666077000777066000007
            7000777706077777700077777007777770007777770777777000777777777777
            7000}
          ParentShowHint = False
          ShowHint = True
          OnClick = S1Click
        end
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 27
      Width = 185
      Height = 673
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 1
      object L5: TLabel
        Left = 16
        Top = 136
        Width = 63
        Height = 16
        Caption = 'Spielregel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object L6: TLabel
        Left = 16
        Top = 12
        Width = 131
        Height = 25
        Caption = 'Spielstand '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -21
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object L7: TLabel
        Left = 24
        Top = 56
        Width = 27
        Height = 25
        Caption = 'L7'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object L8: TLabel
        Left = 24
        Top = 88
        Width = 27
        Height = 25
        Caption = 'L8'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Memo2: TMemo
        Left = 8
        Top = 160
        Width = 169
        Height = 305
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Spieler und Bank versuchen '
          'durch Ziehen von Karten '
          'eine Punktzahl von 21 zu '
          'erhalten.'
          'Die höchste Punktzahl '
          'gewinnt, bei Gleichstand die '
          'Bank.'
          'Der Spieler gewinnt mit 21 '
          'Punkten sofort. Mehr als 21 '
          'Punkte verlieren sofort. '
          'Allerdings gewinnen im '
          'Originalspiel sofort 2 '
          'Asse.'
          ''
          'Kartenwerte:'
          'Zahlkarten ihre Augenzahl, '
          'Bube, Dame, König jeweils '
          '10, Ass 11'
          ''
          'Bei der französischen '
          'Variante Trente et un ist die '
          '31 die Zielzahl.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object rg3: TRadioGroup
        Left = 14
        Top = 464
        Width = 153
        Height = 97
        Caption = 'Varianten'
        ItemIndex = 0
        Items.Strings = (
          'Originalspiel'
          'Bildkarten = 0'
          'Ass = 1'
          'Trente et un')
        TabOrder = 1
      end
      object CB1: TCheckBox
        Left = 24
        Top = 568
        Width = 137
        Height = 17
        Caption = 'verdeckte Bank'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object CB2: TCheckBox
        Left = 24
        Top = 588
        Width = 121
        Height = 17
        Caption = '"Stay" on 17'
        TabOrder = 3
      end
    end
    object Panel8: TPanel
      Left = 185
      Top = 27
      Width = 695
      Height = 673
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      object PaintBox2: TPaintBox
        Left = 0
        Top = 288
        Width = 695
        Height = 200
        Align = alTop
        OnPaint = PaintBox3Paint
      end
      object PaintBox3: TPaintBox
        Left = 0
        Top = 44
        Width = 695
        Height = 200
        Align = alTop
        OnPaint = PaintBox3Paint
      end
      object Panel9: TPanel
        Left = 0
        Top = 244
        Width = 695
        Height = 44
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Spieler'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 0
      end
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 695
        Height = 44
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Bank'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 1
      end
      object Panel11: TPanel
        Left = 0
        Top = 488
        Width = 695
        Height = 185
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 2
        object D6: TDsFancyButton
          Left = 176
          Top = 24
          Width = 205
          Height = 36
          Caption = 'Weitere Karte'
          Enabled = False
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          ParentFont = False
          OnClick = D6Click
        end
        object D7: TDsFancyButton
          Left = 456
          Top = 24
          Width = 205
          Height = 36
          Caption = 'Keine Karte mehr'
          Enabled = False
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          ParentFont = False
          OnClick = D7Click
        end
        object D5: TDsFancyButton
          Left = 320
          Top = 86
          Width = 205
          Height = 36
          Caption = 'Neues Spiel'
          FXE.FaceColor = clWhite
          FXE.FrameColor = clGray
          FXE.FrameStyle = fmGradient
          FXE.FrameWidth = 4
          FXE.HoverColor = clBlue
          FXE.Shape = btnRectangle
          FXE.CornerRadius = 2
          FXE.TextStyle = txRaised
          Glyphs.Layout = lyLeft
          Glyphs.Number = 1
          Glyphs.Distance = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          OnClick = D5Click
        end
      end
    end
  end
  object PM1: TPopupMenu
    Left = 744
    object M57: TMenuItem
      Caption = 'enter'
      ShortCut = 13
      Visible = False
      OnClick = M57Click
    end
    object M35: TMenuItem
      Caption = 'schließen'
      ShortCut = 8219
      Visible = False
      OnClick = S1Click
    end
  end
  object MM1: TMainMenu
    Left = 504
    Top = 16
    object M56: TMenuItem
      Caption = 'Datei'
      object N16: TMenuItem
        Caption = 'Druckeinstellung'
        OnClick = drucken
      end
      object N20: TMenuItem
        Caption = 'Fenster kopieren'
        OnClick = N20Click
      end
      object N19: TMenuItem
        Caption = 'Fenster drucken'
        OnClick = N19Click
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object M33: TMenuItem
        Caption = 'Programmende'
        ShortCut = 27
        OnClick = S1Click
      end
    end
    object M75: TMenuItem
      Caption = 'Zahlenrätsel'
      object M34: TMenuItem
        Caption = 'Mathe-Test'
        OnClick = M34Click
      end
      object M91: TMenuItem
        Caption = 'Kopfrechnen-Test'
        OnClick = M91Click
      end
      object M69: TMenuItem
        Caption = 'Zahlenpyramide'
        OnClick = M69Click
      end
      object M72: TMenuItem
        Caption = 'Kryptogramm'
        OnClick = M72Click
      end
      object M36: TMenuItem
        Caption = 'Zahlenrätsel'
        OnClick = M36Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object Sudoku1: TMenuItem
        Caption = 'Sudoku'
        OnClick = Sudoku1Click
      end
      object M74: TMenuItem
        Caption = 'Str8ts'
        OnClick = M74Click
      end
      object M52: TMenuItem
        Caption = 'Kendoku'
        OnClick = M52Click
      end
      object m65: TMenuItem
        Caption = 'Kikagaku'
        OnClick = m65Click
      end
      object M61: TMenuItem
        Caption = 'Hakyuu'
        OnClick = M61Click
      end
      object M63: TMenuItem
        Caption = 'Zehnergitter'
        OnClick = M63Click
      end
      object M64: TMenuItem
        Caption = 'Hitori'
        OnClick = M64Click
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object M43: TMenuItem
        Caption = 'Sudokubus'
        OnClick = M43Click
      end
      object M76: TMenuItem
        Caption = 'Sudoku 2D'
        OnClick = M76Click
      end
      object M77: TMenuItem
        Caption = 'Lateinische Summen'
        OnClick = M77Click
      end
      object M24: TMenuItem
        Caption = 'Schneckenrätsel'
        OnClick = M24Click
      end
      object M911: TMenuItem
        Caption = 'Kakuro'
        OnClick = M911Click
      end
      object M231: TMenuItem
        Caption = 'Nonogramm'
        OnClick = M231Click
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object M79: TMenuItem
        Caption = 'Gleichungsrätsel'
        OnClick = M79Click
      end
    end
    object M9: TMenuItem
      Caption = 'Gedächtnistests'
      object M23: TMenuItem
        Caption = 'Quiz'
        OnClick = L21Click
      end
      object M1: TMenuItem
        Caption = 'Begriffe raten'
        OnClick = L19Click
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object M66: TMenuItem
        Caption = 'Wolkenkratzer'
        OnClick = M66Click
      end
      object M62: TMenuItem
        Caption = 'Fillomino'
        OnClick = M62Click
      end
      object M78: TMenuItem
        Caption = 'Akari'
        OnClick = M78Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object M15: TMenuItem
        Caption = 'Logiktrainer'
        OnClick = Logiktrainerauf
      end
      object M18: TMenuItem
        Caption = 'Master Mind'
        OnClick = Label22Click
      end
      object M19: TMenuItem
        Caption = 'Memory'
        OnClick = Sudoku1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object M71: TMenuItem
        Caption = 'Farbkreise finden'
        OnClick = M71Click
      end
      object M8: TMenuItem
        Caption = 'Gedächtnistest'
        OnClick = Sudoku1Click
      end
      object M30: TMenuItem
        Caption = 'Zahlengedächtnistest'
        OnClick = Sudoku1Click
      end
    end
    object M10: TMenuItem
      Caption = 'Puzzle'
      object M4: TMenuItem
        Caption = 'MacMahon-Quadrate'
        OnClick = M4Click
      end
      object M39: TMenuItem
        Caption = 'Klassisches Puzzle'
        OnClick = M39Click
      end
      object Puzzle1: TMenuItem
        Caption = 'Bildpuzzle'
        OnClick = Sudoku1Click
      end
      object Spuzzle1: TMenuItem
        Caption = 'Schiebebildpuzzle'
        OnClick = Sudoku1Click
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object M47: TMenuItem
        Caption = 'Pentomino'
        OnClick = M47Click
      end
      object M48: TMenuItem
        Caption = 'Escher-Figurenpuzzle'
        OnClick = M48Click
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object M42: TMenuItem
        Caption = 'Rubik-Würfel'
        OnClick = M42Click
      end
      object M45: TMenuItem
        Caption = 'Walzenwürfel'
        OnClick = M45Click
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object M40: TMenuItem
        Caption = 'Tetravex'
        OnClick = M40Click
      end
      object M32: TMenuItem
        Caption = 'Wortpuzzle'
        OnClick = SpeedButton6Click
      end
      object M811: TMenuItem
        Caption = 'Domino-Puzzle'
        OnClick = M811Click
      end
      object M38: TMenuItem
        Caption = 'Vexed-Puzzle'
        OnClick = M38Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object M28: TMenuItem
        Caption = 'Spiel 15'
        OnClick = Sudoku1Click
      end
      object M531: TMenuItem
        Caption = 'Schiebepuzzle'
        OnClick = M531Click
      end
      object M16: TMenuItem
        Caption = 'Loyds Puzzle'
        OnClick = Label24Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object M7: TMenuItem
        Caption = 'Figuren setzen'
        OnClick = M7Click
      end
      object M29: TMenuItem
        Caption = 'Tangram'
        OnClick = Label29Click
      end
    end
    object M2: TMenuItem
      Caption = 'Brettspiele'
      object M3: TMenuItem
        Caption = 'Damespiel'
        OnClick = L15Click
      end
      object M68: TMenuItem
        Caption = 'Mühle'
        OnClick = M68Click
      end
      object M58: TMenuItem
        Caption = 'Go'
        OnClick = M58Click
      end
      object M54: TMenuItem
        Caption = 'Tic-Tac-Toe'
        OnClick = M54Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object M17: TMenuItem
        Caption = 'Mahjongg'
        OnClick = Sudoku1Click
      end
      object M12: TMenuItem
        Caption = 'Klicks'
        OnClick = L30Click
      end
      object M80: TMenuItem
        Caption = 'Conquete'
        OnClick = M80Click
      end
      object M41: TMenuItem
        Caption = 'Farbflutung'
        OnClick = M41Click
      end
      object M55: TMenuItem
        Caption = 'Cora'
        OnClick = M55Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object M21: TMenuItem
        Caption = 'Othello'
        OnClick = L16Click
      end
      object M11: TMenuItem
        Caption = 'Kettenreaktion'
        OnClick = L25Click
      end
      object M27: TMenuItem
        Caption = 'Chinesisches Solitaire'
        OnClick = Label23Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object M111: TMenuItem
        Caption = 'Gardners Hip-Spiel'
        OnClick = M111Click
      end
      object M20: TMenuItem
        Caption = 'Mini-Go'
        OnClick = Label18Click
      end
      object M70: TMenuItem
        Caption = 'Wythoff-Spiel'
        OnClick = M70Click
      end
    end
    object M14: TMenuItem
      Caption = 'Strategiespiele'
      object M22: TMenuItem
        Caption = 'Patience'
        OnClick = L8Click
      end
      object M46: TMenuItem
        Caption = 'Band-Solitaire'
        OnClick = M46Click
      end
      object M50: TMenuItem
        Caption = 'Turm von Hanoi'
        OnClick = M50Click
      end
      object M51: TMenuItem
        Caption = 'Dreifarben-Turm von Hanoi'
        OnClick = M51Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object M26: TMenuItem
        Caption = 'Sokoban'
        OnClick = L1Click
      end
      object M321: TMenuItem
        Caption = 'Kipplabyrinth'
        OnClick = M321Click
      end
      object M25: TMenuItem
        Caption = 'Sprunglabyrinth'
        OnClick = M25Click
      end
      object M5: TMenuItem
        Caption = 'Digger'
        OnClick = M5Click
      end
      object M59: TMenuItem
        Caption = 'Parkhaus'
        OnClick = M59Click
      end
      object M53: TMenuItem
        Caption = 'Labyrinth'
        OnClick = M53Click
      end
      object M67: TMenuItem
        Caption = 'Brücken bauen'
        OnClick = M67Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object M31: TMenuItem
        Caption = 'Zahlentetris'
        OnClick = L6Click
      end
      object Tetris1: TMenuItem
        Caption = 'Tetris'
        OnClick = Tetris1Click
      end
      object M49: TMenuItem
        Caption = 'Zahlensprungspiel'
        OnClick = M49Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object M541: TMenuItem
        Caption = 'Vier gewinnt'
        OnClick = M541Click
      end
      object M81: TMenuItem
        Caption = 'Fünf in einer Reihe'
        OnClick = M81Click
      end
      object M6: TMenuItem
        Caption = 'Domino'
        OnClick = Label20Click
      end
      object Rally1: TMenuItem
        Caption = 'Rally'
        OnClick = Rally1Click
      end
      object M44: TMenuItem
        Caption = 'Rotor'
        OnClick = M44Click
      end
      object M13: TMenuItem
        Caption = 'Licht aus!'
        OnClick = M13Click
      end
      object M73: TMenuItem
        Caption = 'Zahlenmaximum'
        OnClick = M73Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object ari1: TMenuItem
        Caption = 'Arithmomachiaspiel'
        OnClick = Sudoku1Click
      end
      object m37: TMenuItem
        Caption = '17 und 4'
        OnClick = Sudoku1Click
      end
    end
    object M60: TMenuItem
      Caption = '?'
      object N8: TMenuItem
        Caption = 'Hilfe'
        ShortCut = 112
        OnClick = S99Click
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object N21: TMenuItem
        Caption = 'Info über ...'
        OnClick = S2C
      end
    end
  end
  object Sizer1: TSizer
    Left = 776
    Top = 2
  end
  object p1od: TOpenDialog
    DefaultExt = 'sud'
    Filter = 'Sudoku-Aufgaben|*.sud|alle|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 478
    Top = 8
  end
  object p1sd: TSaveDialog
    DefaultExt = 'sud'
    Filter = 'Sudoku-Aufgaben|*.sud|alle|*.*'
    Left = 185
    Top = 240
  end
  object p2t2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = p2t2Timer
    Left = 582
    Top = 2
  end
  object p3t1: TTimer
    Interval = 50
    OnTimer = p3t1Timer
    Left = 616
    Top = 2
  end
  object p5T1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = p5T1Timer
    Left = 848
    Top = 65530
  end
  object p5T2: TTimer
    Interval = 500
    OnTimer = p5T2Timer
    Left = 816
    Top = 65530
  end
  object p6T1: TTimer
    Enabled = False
    Interval = 0
    OnTimer = p6T1Timer
    Left = 550
    Top = 6
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 657
    Top = 4
  end
  object OP1: TOpenPictureDialog
    Filter = 
      'JPEG Image File (*.jpg)|*.jpg|CompuServe GIF Image (*.gif)|*.gif' +
      '|Bitmaps (*.bmp)|*.bmp'
    Left = 521
    Top = 65530
  end
  object SD1: TSaveDialog
    DefaultExt = 'puz'
    Filter = 'Puzzle (*.puz)|*.puz'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 369
    Top = 2
  end
  object OD1: TOpenDialog
    DefaultExt = 'puz'
    Filter = 'Puzzle (*.puz)|*.puz'
    Left = 338
    Top = 3
  end
end
