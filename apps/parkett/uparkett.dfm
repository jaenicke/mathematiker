object parkettform: Tparkettform
  Left = 382
  Top = 90
  Width = 1071
  Height = 609
  HelpContext = 110
  Caption = 'Parkettierung'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object pgrund: TPanel
    Left = 0
    Top = 0
    Width = 1055
    Height = 570
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object parket: TPanel
      Left = 0
      Top = 0
      Width = 1055
      Height = 570
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object pa1: TPaintBox
        Left = 0
        Top = 0
        Width = 798
        Height = 570
        Align = alClient
        OnPaint = pa1P
      end
      object panel1: TPanel
        Left = 798
        Top = 0
        Width = 257
        Height = 570
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Sh1: TShape
          Left = 88
          Top = 448
          Width = 25
          Height = 25
          Brush.Color = 8388607
        end
        object Sh2: TShape
          Left = 208
          Top = 448
          Width = 25
          Height = 25
          Brush.Color = 16744448
        end
        object Sh3: TShape
          Left = 88
          Top = 480
          Width = 25
          Height = 25
          Brush.Color = 33023
        end
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 79
          Height = 14
          Caption = 'Parkett-Typ'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Sh4: TShape
          Left = 208
          Top = 480
          Width = 25
          Height = 25
          Brush.Color = clYellow
        end
        object Speed2: TSpeedButton
          Left = 173
          Top = 10
          Width = 23
          Height = 24
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFF0000F0000FFFFFFFFFF0000F0000F00FFFFFFFFFFFFFF00F0000F0F0
            FFFFFFFFFFFF0F0F0000F0FF0FFFFFFFFFF0FF0F0000FFFFF0FFFFFFFF0FFFFF
            0000FFFFFF0FFFFFF0FFFFFF0000FFFFFFF0FFFF0FFFFFFF0000FFFFFFFF0FF0
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFF0FF0FFFFFFFF0000FFFFFFF0FFFF0FFFFFFF0000FFFFFF0FFFFFF0FFFFFF
            0000FFFFF0FFFFFFFF0FFFFF0000F0FF0FFFFFFFFFF0FF0F0000F0F0FFFFFFFF
            FFFF0F0F0000F00FFFFFFFFFFFFFF00F0000F0000FFFFFFFFF00000F0000FFFF
            FFFFFFFFFFFFFFFF0000}
          OnClick = S53C
        end
        object Speed1: TSpeedButton
          Left = 196
          Top = 10
          Width = 23
          Height = 24
          Flat = True
          Glyph.Data = {
            4E010000424D4E01000000000000760000002800000012000000120000000100
            040000000000D800000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFF000000FFFFFFF000000FFFFF000000FFFFFFF0AAAAA00FFF000000FFFF
            FFF0AAAAAA20FF000000FFFFFFF0AAAAA2A28F000000FFFFFFF000000A220F00
            0000FFFFFFFFFFFF80020F000000FFFFFFFFFFFFFF800F000000FFFFF0FFFFFF
            FF800F000000FFFF00FFFFFF80020F000000FFF0A00000000A220F000000FF0A
            AAAAAAAAA2A28F000000F0AAAAAAAAAAAA20FF000000FF0AAAAAAAAAA00FFF00
            0000FFF0A00000000FFFFF000000FFFF00FFFFFFFFFFFF000000FFFFF0FFFFFF
            FFFFFF000000FFFFFFFFFFFFFFFFFF000000}
          OnClick = S34C
        end
        object Speed3: TSpeedButton
          Left = 219
          Top = 10
          Width = 23
          Height = 24
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFF0000F0FFFFFFFFFFFFFFFF0F0000FF0FFFFFFFFFFFFFF0FF0000FFF0
            FFFFFFFFFFFF0FFF0000FFFF0FF0FFFF0FF0FFFF0000FFFFF0F0FFFF0F0FFFFF
            0000FFFFFF00FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFFFFFFFFFFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFF00FFFF00FFFFFF
            0000FFFFF0F0FFFF0F0FFFFF0000FFFF0FF0FFFF0FF0FFFF0000FFF0FFFFFFFF
            FFFF0FFF0000FF0FFFFFFFFFFFFFF0FF0000F0FFFFFFFFFFFFFFFF0F0000FFFF
            FFFFFFFFFFFFFFFF0000}
          OnClick = S54C
        end
        object BZeichnen: TButton
          Left = 56
          Top = 406
          Width = 137
          Height = 25
          Caption = 'Zeichnen'
          ModalResult = 1
          TabOrder = 1
          OnClick = pa1P
        end
        object BFarbe1: TButton
          Left = 16
          Top = 448
          Width = 65
          Height = 25
          Caption = 'Farbe 1'
          TabOrder = 2
          OnClick = D2C
        end
        object BFarbe2: TButton
          Left = 136
          Top = 448
          Width = 65
          Height = 25
          Caption = 'Farbe 2'
          TabOrder = 3
          OnClick = D2C
        end
        object BFarbe3: TButton
          Left = 16
          Top = 480
          Width = 65
          Height = 25
          Caption = 'Farbe 3'
          TabOrder = 4
          OnClick = D2C
        end
        object BFarbe4: TButton
          Left = 136
          Top = 480
          Width = 65
          Height = 25
          Caption = 'Farbe 4'
          TabOrder = 5
          OnClick = D2C
        end
        object Liste: TListBox
          Left = 12
          Top = 40
          Width = 236
          Height = 354
          Color = clWhite
          IntegralHeight = True
          ItemHeight = 14
          Items.Strings = (
            '3-3-3-3-3-3'#9'trigonal'
            '4-4-4-4'#9'quadratisch'
            '6-6-6'#9'hexagonal'
            '3-6-3-6'#9'trihexagonal'
            '3-3-6-6'#9'trihexagonal'
            '4-8-8'#9'abgest.quadratisch'
            '3-12-12'#9'abgest.hexagonal'
            '4-6-12'#9'rhombentrihexagonal'
            '3-4-6-4 A'#9'rhombentrihexagonal'
            '3-4-6-4 B'#9'rhombentrihexagonal'
            '3-4-6-4 C'#9'rhombentrihexagonal'
            '3-3-3-3-6'#9'abgeschr.hexagonal'
            '3-3-3-4-4'#9'erweitert trigonal'
            '3-3-4-3-4'#9'abgeschr.quadratisch'
            '3-3-4-3-4 B'#9'abgeschr.quadratisch'
            '3-3-4-3-4 C'#9'abgeschr.quadratisch'
            '3.3.3.3.6'#9'pentagonal'
            '3.6.3.6'#9'rhombisch'
            '4.6.12'#9'halbiert hexagonal'
            '3.4.6.4'#9'deltoidal trihexagonal'
            '4.8.8'#9'tetrakis quadratisch'
            '3.4.4'#9'rechteckig'
            '3.3.4'#9'cairo-pentagonal'
            '3.12.12'#9'triakis-trigonal'
            '3.3.4.4'#9'primatisch-pentagonal')
          TabOrder = 0
          TabWidth = 43
          OnClick = pa1P
        end
      end
    end
  end
  object farbwahl: TColorDialog
    Left = 256
    Top = 24
  end
end
